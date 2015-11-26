// Copyright (C) 1999-2000 Id Software, Inc.
//

#include "g_local.h"
#include "bg_promode.h" // CPM


/*
===============
G_DamageFeedback

Called just before a snapshot is sent to the given player.
Totals up all damage and generates both the player_state_t
damage values to that client for pain blends and kicks, and
global pain sound events for all clients.
===============
*/
void P_DamageFeedback( gentity_t *player ) {
	gclient_t	*client;
	float	count;
	vec3_t	angles;

	client = player->client;
	if ( client->ps.pm_type == PM_DEAD ) {
		return;
	}

	// total points of damage shot at the player this frame
	count = client->damage_blood + client->damage_armor;
	if ( count == 0 ) {
		return;		// didn't take any damage
	}

	if ( count > 255 ) {
		count = 255;
	}

	// send the information to the client

	// world damage (falling, slime, etc) uses a special code
	// to make the blend blob centered instead of positional
	if ( client->damage_fromWorld ) {
		client->ps.damagePitch = 255;
		client->ps.damageYaw = 255;

		client->damage_fromWorld = qfalse;
	} else {
		vectoangles( client->damage_from, angles );
		client->ps.damagePitch = angles[PITCH]/360.0 * 256;
		client->ps.damageYaw = angles[YAW]/360.0 * 256;
	}

	// play an apropriate pain sound
	if ( (level.time > player->pain_debounce_time) && !(player->flags & FL_GODMODE) ) {
		player->pain_debounce_time = level.time + 700;
		G_AddEvent( player, EV_PAIN, player->health );
		client->ps.damageEvent++;
	}


	client->ps.damageCount = count;

	//
	// clear totals
	//
	client->damage_blood = 0;
	client->damage_armor = 0;
	client->damage_knockback = 0;
}



/*
=============
P_WorldEffects

Check for lava / slime contents and drowning
=============
*/
void P_WorldEffects( gentity_t *ent ) {
	qboolean	envirosuit;
	int			waterlevel;

	if ( ent->client->noclip ) {
		ent->client->airOutTime = level.time + 12000;	// don't need air
		return;
	}

	waterlevel = ent->waterlevel;

	envirosuit = ent->client->ps.powerups[PW_BATTLESUIT] > level.time;

	//
	// check for drowning
	//
	if ( waterlevel == 3 ) {
		// envirosuit give air
		if ( envirosuit ) {
			ent->client->airOutTime = level.time + 10000;
		}

		// if out of air, start drowning
		if ( ent->client->airOutTime < level.time) {
			// drown!
			ent->client->airOutTime += 1000;
			if ( ent->health > 0 ) {
				// take more damage the longer underwater
				ent->damage += 2;
				if (ent->damage > 15)
					ent->damage = 15;

				// play a gurp sound instead of a normal pain sound
				if (ent->health <= ent->damage) {
					G_Sound(ent, CHAN_VOICE, G_SoundIndex("*drown.wav"));
				} else if (rand()&1) {
					G_Sound(ent, CHAN_VOICE, G_SoundIndex("sound/player/gurp1.wav"));
				} else {
					G_Sound(ent, CHAN_VOICE, G_SoundIndex("sound/player/gurp2.wav"));
				}

				// don't play a normal pain sound
				ent->pain_debounce_time = level.time + 200;

				G_Damage (ent, NULL, NULL, NULL, NULL, 
					ent->damage, DAMAGE_NO_ARMOR, MOD_WATER);
			}
		}
	} else {
		ent->client->airOutTime = level.time + 12000;
		ent->damage = 2;
	}

	//
	// check for sizzle damage (move to pmove?)
	//
	if (waterlevel && 
		(ent->watertype&(CONTENTS_LAVA|CONTENTS_SLIME)) ) {
		if (ent->health > 0
			&& ent->pain_debounce_time <= level.time	) {

			if ( envirosuit ) {
				G_AddEvent( ent, EV_POWERUP_BATTLESUIT, 0 );
			} else {
				if (ent->watertype & CONTENTS_LAVA) {
					G_Damage (ent, NULL, NULL, NULL, NULL, 
						30*waterlevel, 0, MOD_LAVA);
				}

				if (ent->watertype & CONTENTS_SLIME) {
					G_Damage (ent, NULL, NULL, NULL, NULL, 
						10*waterlevel, 0, MOD_SLIME);
				}
			}
		}
	}
}



/*
===============
G_SetClientSound
===============
*/
void G_SetClientSound( gentity_t *ent ) {
#ifdef MISSIONPACK
	if( ent->s.eFlags & EF_TICKING ) {
		ent->client->ps.loopSound = G_SoundIndex( "sound/weapons/proxmine/wstbtick.wav");
	}
	else
#endif
	if (ent->waterlevel && (ent->watertype&(CONTENTS_LAVA|CONTENTS_SLIME)) ) {
		ent->client->ps.loopSound = level.snd_fry;
	} else {
		ent->client->ps.loopSound = 0;
	}
}



//==============================================================

/*
==============
ClientImpacts
==============
*/
void ClientImpacts( gentity_t *ent, pmove_t *pm ) {
	int		i, j;
	trace_t	trace;
	gentity_t	*other;

	memset( &trace, 0, sizeof( trace ) );
	for (i=0 ; i<pm->numtouch ; i++) {
		for (j=0 ; j<i ; j++) {
			if (pm->touchents[j] == pm->touchents[i] ) {
				break;
			}
		}
		if (j != i) {
			continue;	// duplicated
		}
		other = &g_entities[ pm->touchents[i] ];

		
		/*if (!G_AllowEntityInteraction(ent, other))
		{
			continue;
		}*/


		if ( ( ent->r.svFlags & SVF_BOT ) && ( ent->touch ) ) {
			ent->touch( ent, other, &trace );
		}

		if ( !other->touch ) {
			continue;
		}

		other->touch( other, ent, &trace );
	}

}

/*
============
G_TouchTriggers

Find all trigger entities that ent's current position touches.
Spectators will only interact with teleporters.
============
*/
void	G_TouchTriggers( gentity_t *ent ) {
	int			i, num;
	int			touch[MAX_GENTITIES];
	gentity_t	*hit;
	trace_t		trace;
	vec3_t		mins, maxs;
	//vec3_t		origin;
	//qboolean	weTouch = qtrue;
	static vec3_t	range = { 40, 40, 52 };//This might be helpful for total control

	if ( !ent->client ) {
		return;
	}

	// dead clients don't activate triggers!
	if ( ent->client->ps.stats[STAT_HEALTH] <= 0 ) {
		return;
	}

	//Play with range and the mins and maxs in the trap
	//Do we gain anything by doing that?
	VectorSubtract( ent->client->ps.origin, range, mins );
	VectorAdd( ent->client->ps.origin, range, maxs );

	num = trap_EntitiesInBox( mins, maxs, touch, MAX_GENTITIES );

	// can't use ent->absmin, because that has a one unit pad
	VectorAdd( ent->client->ps.origin, ent->r.mins, mins );
	VectorAdd( ent->client->ps.origin, ent->r.maxs, maxs );

	//G_Printf("%i\n", cpm_itemsize);
	for ( i=0 ; i<num ; i++ ) {
		hit = &g_entities[touch[i]];

		if ( !hit->touch && !ent->touch ) {
			continue;
		}
		if ( !( hit->r.contents & CONTENTS_TRIGGER ) ) {
			continue;
		}

		// ignore most entities if a spectator
/*freeze
		if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
freeze*/
		//if ( is_spectator( ent->client ) ) {
		if ( (g_gametype.integer == GT_FREEZE && is_spectator(ent->client)) || (g_gametype.integer != GT_FREEZE && ent->client->sess.sessionTeam == TEAM_SPECTATOR) ) {
//freeze
			if ( hit->s.eType != ET_TELEPORT_TRIGGER &&
				// this is ugly but adding a new ET_? type will
				// most likely cause network incompatibilities
				hit->touch != Touch_DoorTrigger) {
				continue;
			}
		}

		/*if (!G_AllowEntityInteraction(ent, hit))
		{
			continue;
		}*/

		// use seperate code for determining if an item is picked up
		// so you don't have to actually contact its bounding box
		if ( hit->s.eType == ET_ITEM ) {
			memset( &trace, 0, sizeof(trace) );

			if ( hit->touch ) {
				hit->touch (hit, ent, &trace);
			}


			/***************************
			* There is most likely a
			* much better way of handling
			* this, but this is how I got
			* it working.
			***************************/
			//FIXME: This shouldn't need 2 qboolean's.
			if ( !g_pro_mode.integer && !BG_PlayerTouchesItem( &ent->client->ps, &hit->s, level.time ) ) {
				continue;
			} else if ( g_pro_mode.integer && !BG_ProModePlayerTouchesItem( &ent->client->ps, &hit->s, level.time ) ) {
				continue;
			}
		} else {
			if ( !trap_EntityContact( mins, maxs, hit ) ) {
				continue;
			}
		}
		
		memset( &trace, 0, sizeof(trace) );

		if ( hit->touch ) {
			hit->touch (hit, ent, &trace);
		}

		if ( ( ent->r.svFlags & SVF_BOT ) && ( ent->touch ) ) {
			ent->touch( ent, hit, &trace );
		}
	}

	// if we didn't touch a jump pad this pmove frame
	if ( ent->client->ps.jumppad_frame != ent->client->ps.pmove_framecount ) {
		ent->client->ps.jumppad_frame = 0;
		ent->client->ps.jumppad_ent = 0;
	}
}

/*
=================
SpectatorThink
=================
*/
void SpectatorThink( gentity_t *ent, usercmd_t *ucmd ) {
	pmove_t	pm;
	gclient_t	*client;
	int		ping;

	client = ent->client;
	//Ping hack, the real one?
	//G_Printf("Ping_Fix %i\n", gameSettings.ping_fix);
	if ( gameSettings.ping_fix ) {
		ping = client->ps.ping;
	}

	if ( client->sess.spectatorState != SPECTATOR_FOLLOW ) {
		client->ps.pm_type = PM_SPECTATOR;
		client->ps.speed = 400;	// faster than normal

		// set up for pmove
		memset (&pm, 0, sizeof(pm));
		pm.ps = &client->ps;
		pm.cmd = *ucmd;
		pm.tracemask = MASK_PLAYERSOLID & ~CONTENTS_BODY;	// spectators can fly through bodies
		pm.trace = trap_Trace;
		pm.pointcontents = trap_PointContents;

		// perform a pmove
		Pmove (&pm);
		// save results of pmove
		VectorCopy( client->ps.origin, ent->s.origin );

		G_TouchTriggers( ent );
//		ent->relink = 0;
		trap_UnlinkEntity( ent );
	}

	if ( gameSettings.ping_fix ) {
		client->ps.ping = ping;
	}

	client->oldbuttons = client->buttons;
	client->buttons = ucmd->buttons;

	// attack button cycles through spectators
	if ( ( client->buttons & BUTTON_ATTACK ) && ! ( client->oldbuttons & BUTTON_ATTACK ) ) {
		Cmd_FollowCycle_f( ent, 1 );
	}
//freeze
	else if (g_gametype.integer == GT_FREEZE) {
		respawnSpectator( ent );
	}
//freeze
	
}



/*
=================
ClientInactivityTimer

Returns qfalse if the client is dropped
=================
*/
qboolean ClientInactivityTimer( gclient_t *client ) {
	if ( ! g_inactivity.integer ) {
		// give everyone some time, so if the operator sets g_inactivity during
		// gameplay, everyone isn't kicked
		client->inactivityTime = level.time + 60 * 1000;
		client->inactivityWarning = qfalse;
	} else if ( client->pers.cmd.forwardmove || 
		client->pers.cmd.rightmove || 
		client->pers.cmd.upmove ||
		(client->pers.cmd.buttons & BUTTON_ATTACK) ) {
		client->inactivityTime = level.time + g_inactivity.integer * 1000;
		client->inactivityWarning = qfalse;
	} else if ( !client->pers.localClient ) {
//freeze
		if ( g_gametype.integer == GT_FREEZE ) {
			if ( g_entities[ client->ps.clientNum ].freezeState ) {
				return qtrue;
			}
		}
//freeze
		if ( level.time > client->inactivityTime ) {
			//trap_DropClient( client - level.clients, "Dropped due to inactivity" );
			//Hack: We probably should build our own trap_ to do this.
			//trap_SendConsoleCommand(EXEC_NOW, va("forceteam %i s", client->ps.clientNum));
			SetTeam( &g_entities[client - level.clients], "s", qtrue );
			return qfalse;
		}
		if ( level.time > client->inactivityTime - 10000 && !client->inactivityWarning ) {
			client->inactivityWarning = qtrue;
			trap_SendServerCommand( client - level.clients, "cp \"Ten seconds until inactivity drop!\n\"" );
		}
	}
	return qtrue;
}

/*
==================
ClientTimerActions

Actions that happen once a second
==================
*/
void ClientTimerActions( gentity_t *ent, int msec ) {
	gclient_t	*client;
#ifdef MISSIONPACK
	int			maxHealth;
#endif

	client = ent->client;
	client->timeResidual += msec;

	while ( client->timeResidual >= 1000 ) {
		client->timeResidual -= 1000;

		// regenerate
#ifdef MISSIONPACK
		if( bg_itemlist[client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_GUARD ) {
			maxHealth = client->ps.stats[STAT_MAX_HEALTH] / 2;
		}
		else if ( client->ps.powerups[PW_REGEN] ) {
			maxHealth = client->ps.stats[STAT_MAX_HEALTH];
		}
		else {
			maxHealth = 0;
		}
		if( maxHealth ) {
			if ( ent->health < maxHealth ) {
				ent->health += 15;
				if ( ent->health > maxHealth * 1.1 ) {
					ent->health = maxHealth * 1.1;
				}
				G_AddEvent( ent, EV_POWERUP_REGEN, 0 );
			} else if ( ent->health < maxHealth * 2) {
				ent->health += 5;
				if ( ent->health > maxHealth * 2 ) {
					ent->health = maxHealth * 2;
				}
				G_AddEvent( ent, EV_POWERUP_REGEN, 0 );
			}
#else
		if ( client->ps.powerups[PW_REGEN] ) {
			if ( ent->health < client->ps.stats[STAT_MAX_HEALTH]) {
				ent->health += 15;
				if ( ent->health > client->ps.stats[STAT_MAX_HEALTH] * 1.1 ) {
					ent->health = client->ps.stats[STAT_MAX_HEALTH] * 1.1;
				}
				G_AddEvent( ent, EV_POWERUP_REGEN, 0 );
			} else if ( ent->health < client->ps.stats[STAT_MAX_HEALTH] * 2) {
				ent->health += 5;
				if ( ent->health > client->ps.stats[STAT_MAX_HEALTH] * 2 ) {
					ent->health = client->ps.stats[STAT_MAX_HEALTH] * 2;
				}
				G_AddEvent( ent, EV_POWERUP_REGEN, 0 );
			}
#endif
		} else {
			// count down health when over max
			if ( ent->health > client->ps.stats[STAT_MAX_HEALTH] ) {
				ent->health--;
			}
		}

		// count down armor when over max
		//if ( client->ps.stats[STAT_ARMOR] > client->ps.stats[STAT_MAX_HEALTH] ) {
		if ( (client->ps.stats[STAT_ARMOR] > client->ps.stats[STAT_MAX_HEALTH]) && !g_pro_mode.integer ) { // CPM
			client->ps.stats[STAT_ARMOR]--;
		}
	}
#ifdef MISSIONPACK
	if( bg_itemlist[client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_AMMOREGEN ) {
		int w, max, inc, t, i;
    int weapList[]={WP_MACHINEGUN,WP_SHOTGUN,WP_GRENADE_LAUNCHER,WP_ROCKET_LAUNCHER,WP_LIGHTNING,WP_RAILGUN,WP_PLASMAGUN,WP_BFG,WP_NAILGUN,WP_PROX_LAUNCHER,WP_CHAINGUN};
    int weapCount = sizeof(weapList) / sizeof(int);
		//
    for (i = 0; i < weapCount; i++) {
		  w = weapList[i];

		  switch(w) {
			  case WP_MACHINEGUN: max = 50; inc = 4; t = 1000; break;
			  case WP_SHOTGUN: max = 10; inc = 1; t = 1500; break;
			  case WP_GRENADE_LAUNCHER: max = 10; inc = 1; t = 2000; break;
			  case WP_ROCKET_LAUNCHER: max = 10; inc = 1; t = 1750; break;
			  case WP_LIGHTNING: max = 50; inc = 5; t = 1500; break;
			  case WP_RAILGUN: max = 10; inc = 1; t = 1750; break;
			  case WP_PLASMAGUN: max = 50; inc = 5; t = 1500; break;
			  case WP_BFG: max = 10; inc = 1; t = 4000; break;
			  case WP_NAILGUN: max = 10; inc = 1; t = 1250; break;
			  case WP_PROX_LAUNCHER: max = 5; inc = 1; t = 2000; break;
			  case WP_CHAINGUN: max = 100; inc = 5; t = 1000; break;
			  default: max = 0; inc = 0; t = 1000; break;
		  }
		  client->ammoTimes[w] += msec;
		  if ( client->ps.ammo[w] >= max ) {
			  client->ammoTimes[w] = 0;
		  }
		  if ( client->ammoTimes[w] >= t ) {
			  while ( client->ammoTimes[w] >= t )
				  client->ammoTimes[w] -= t;
			  client->ps.ammo[w] += inc;
			  if ( client->ps.ammo[w] > max ) {
				  client->ps.ammo[w] = max;
			  }
		  }
    }
	}
#endif
}

/*
====================
ClientIntermissionThink
====================
*/
void ClientIntermissionThink( gclient_t *client ) {
	client->ps.eFlags &= ~EF_TALK;
	client->ps.eFlags &= ~EF_FIRING;

	// the level will exit when everyone wants to or after timeouts

	// swap and latch button actions
	client->oldbuttons = client->buttons;
	client->buttons = client->pers.cmd.buttons;
	if ( client->buttons & ( BUTTON_ATTACK | BUTTON_USE_HOLDABLE ) & ( client->oldbuttons ^ client->buttons ) ) {
		// this used to be an ^1 but once a player says ready, it should stick
		client->playerReady = qtrue;
	}
}


/*
================
ClientEvents

Events will be passed on to the clients for presentation,
but any server game effects are handled here
================
*/
void ClientEvents( gentity_t *ent, int oldEventSequence ) {
	int		i, j;
	int		event;
	int		eventParm = 0;
	gclient_t *client;
	int		damage;
	vec3_t	dir;
	vec3_t	origin, angles;
	gitem_t *item;
	gentity_t *drop;

	

	client = ent->client;

	if ( oldEventSequence < client->ps.eventSequence - MAX_PS_EVENTS ) {
		oldEventSequence = client->ps.eventSequence - MAX_PS_EVENTS;
	}
	for ( i = oldEventSequence ; i < client->ps.eventSequence ; i++ ) {
		event = client->ps.events[ i & (MAX_PS_EVENTS-1) ];

		switch ( event ) {
		case EV_FALL_MEDIUM:
		case EV_FALL_FAR:
		//case EV_FALL_ADV:
			if ( g_FallingDamage.integer == 0 ) {
				break;
			}
			if ( ent->s.eType != ET_PLAYER ) {
				break;		// not in the player model
			}
			if ( g_dmflags.integer & DF_NO_FALLING ) {
				break;
			}

			if ( event == EV_FALL_FAR ) {
				damage = 10;
			} else {
				damage = 5;
			}	
			
			VectorSet (dir, 0, 0, 1);
			ent->pain_debounce_time = level.time + 200;	// no normal pain sound
			G_Damage (ent, NULL, NULL, NULL, NULL, damage, 0, MOD_FALLING);
			break;

		//monkk:offhand grapple
		case EV_FIRE_GRAPPLE:
			if( weap_enableHook.integer == 1 ) {
				FireWeaponGrapple( ent );
			}
			break;

		case EV_FIRE_WEAPON:
			//trap_SendServerCommand( ent->client->ps.clientNum, va("print \"DBGRWS:Entered EV_FIRE_WEAPON -- %i\n\"", level.time) );

			//trap_SendServerCommand( ent->client->ps.clientNum, va("print \"DBGRWS:event: %i, eventParm: %i\n\"", event, eventParm) );
			FireWeapon( ent, eventParm );
			break;

		case EV_USE_ITEM1:		// teleporter
			// drop flags in CTF
			item = NULL;
			j = 0;

			if ( ent->client->ps.powerups[ PW_REDFLAG ] ) {
				item = BG_FindItemForPowerup( PW_REDFLAG );
				j = PW_REDFLAG;
			} else if ( ent->client->ps.powerups[ PW_BLUEFLAG ] ) {
				item = BG_FindItemForPowerup( PW_BLUEFLAG );
				j = PW_BLUEFLAG;
			} else if ( ent->client->ps.powerups[ PW_NEUTRALFLAG ] ) {
				item = BG_FindItemForPowerup( PW_NEUTRALFLAG );
				j = PW_NEUTRALFLAG;
			}

			if ( item ) {
				drop = Drop_Item( ent, item, 0, qfalse );
				// decide how many seconds it has left
				drop->count = ( ent->client->ps.powerups[ j ] - level.time ) / 1000;
				if ( drop->count < 1 ) {
					drop->count = 1;
				}

				ent->client->ps.powerups[ j ] = 0;
			}

#ifdef MISSIONPACK
			if ( g_gametype.integer == GT_HARVESTER ) {
				if ( ent->client->ps.generic1 > 0 ) {
					if ( ent->client->sess.sessionTeam == TEAM_RED ) {
						item = BG_FindItem( "Blue Cube" );
					} else {
						item = BG_FindItem( "Red Cube" );
					}
					if ( item ) {
						for ( j = 0; j < ent->client->ps.generic1; j++ ) {
							drop = Drop_Item( ent, item, 0, qfalse );
							if ( ent->client->sess.sessionTeam == TEAM_RED ) {
								drop->spawnflags = TEAM_BLUE;
							} else {
								drop->spawnflags = TEAM_RED;
							}
						}
					}
					ent->client->ps.generic1 = 0;
				}
			}
#endif
			SelectSpawnPoint( ent->client->ps.origin, origin, angles );
			TeleportPlayer( ent, origin, angles, qtrue );
			break;

		case EV_USE_ITEM2:		// medkit
			ent->health = ent->client->ps.stats[STAT_MAX_HEALTH] + 25;

			break;

#ifdef MISSIONPACK
		case EV_USE_ITEM3:		// kamikaze
			// make sure the invulnerability is off
			ent->client->invulnerabilityTime = 0;
			// start the kamikze
			G_StartKamikaze( ent );
			break;

		case EV_USE_ITEM4:		// portal
			if( ent->client->portalID ) {
				DropPortalSource( ent );
			}
			else {
				DropPortalDestination( ent );
			}
			break;
		case EV_USE_ITEM5:		// invulnerability
			ent->client->invulnerabilityTime = level.time + 10000;
			break;
#endif

		default:
			break;
		}
	}

	//if ( !wait && ent->client->pers.last_Event == EV_FIRE_WEAPON && (
	//	ent->s.weapon == WP_GAUNTLET || ent->s.weapon == WP_MACHINEGUN ||
	//	ent->s.weapon == WP_SHOTGUN || ent->s.weapon == WP_RAILGUN )) {
		//	G_Printf("We should've waited, do hitscan\n");
	//		ent->client->pers.last_Event = -1;
	//		FireWeapon( ent );
	//}

	//ent->client->pers.wait = qfalse;

}

#ifdef MISSIONPACK
/*
==============
StuckInOtherClient
==============
*/
static int StuckInOtherClient(gentity_t *ent) {
	int i;
	gentity_t	*ent2;

	ent2 = &g_entities[0];
	for ( i = 0; i < MAX_CLIENTS; i++, ent2++ ) {
		if ( ent2 == ent ) {
			continue;
		}
		if ( !ent2->inuse ) {
			continue;
		}
		if ( !ent2->client ) {
			continue;
		}
		if ( ent2->health <= 0 ) {
			continue;
		}
		//
		if (ent2->r.absmin[0] > ent->r.absmax[0])
			continue;
		if (ent2->r.absmin[1] > ent->r.absmax[1])
			continue;
		if (ent2->r.absmin[2] > ent->r.absmax[2])
			continue;
		if (ent2->r.absmax[0] < ent->r.absmin[0])
			continue;
		if (ent2->r.absmax[1] < ent->r.absmin[1])
			continue;
		if (ent2->r.absmax[2] < ent->r.absmin[2])
			continue;
		return qtrue;
	}
	return qfalse;
}
#endif

void BotTestSolid(vec3_t origin);

/*
==============
SendPendingPredictableEvents
==============
*/
void SendPendingPredictableEvents( playerState_t *ps ) {
	gentity_t *t;
	int event, seq;
	int extEvent, number;

	// if there are still events pending
	if ( ps->entityEventSequence < ps->eventSequence ) {
		// create a temporary entity for this event which is sent to everyone
		// except the client who generated the event
		seq = ps->entityEventSequence & (MAX_PS_EVENTS-1);
		event = ps->events[ seq ] | ( ( ps->entityEventSequence & 3 ) << 8 );
		// set external event to zero before calling BG_PlayerStateToEntityState
		extEvent = ps->externalEvent;
		ps->externalEvent = 0;
		// create temporary entity for event
		t = G_TempEntity( ps->origin, event );
		number = t->s.number;
		BG_PlayerStateToEntityState( ps, &t->s, qtrue );
		t->s.number = number;
		t->s.eType = ET_EVENTS + event;
		t->s.eFlags |= EF_PLAYER_EVENT;
		t->s.otherEntityNum = ps->clientNum;
		// send to everyone except the client who generated the event
		t->r.svFlags |= SVF_NOTSINGLECLIENT;
		t->r.singleClient = ps->clientNum;
		// set back external event
		ps->externalEvent = extEvent;
	}
}

/*
==============
ClientThink

This will be called once for each client frame, which will
usually be a couple times for each server frame on fast clients.

If "g_synchronousClients 1" is set, this will be called exactly
once for each server frame, which makes for smooth demo recording.
==============
*/
//monkk:?performance?
#define SAC_UPDATE_DISTANCE 100
void ClientThink_real( gentity_t *ent, int forced ) {
	gclient_t	*client;
	pmove_t		pm;
	int			oldEventSequence;
	int			msec;
	usercmd_t	*ucmd;
	vec3_t		v;
//	char		buffer[65];
	int			shifted = 0;
//	int			team;

	client = ent->client;

	// don't think if the client is not yet connected (and thus not yet spawned in)
	if (client->pers.connected != CON_CONNECTED) {
		return;
	}

	/*
	if (client->sess.sessionTeam == TEAM_WARMUP && g_gametype.integer != GT_TOURNAMENT)
	{
		SetTeamInt(ent, PickTeam( -1 ));
	}

	if (g_gametype.integer >= GT_TEAM)
	{
		if (client->sess.sessionTeam == TEAM_FREE)
		{
			SetTeamInt(ent, PickTeam( -1 ));
		}
	}
	else
	{
		if (client->sess.sessionTeam == TEAM_RED || client->sess.sessionTeam == TEAM_BLUE)
		{
			SetTeamInt(ent, PickTeam( -1 ));
		}

	}
	*/

	/*
	// Causes clients to flicker when they have packet loss...
	// commenting out until I get around to finding a way around that issue.
	if (ent)
	{
		ent->r.svFlags &= (~SVF_CLIENTMASK);
	}
	*/


	// mark the time, so the connection sprite can be removed
	ucmd = &ent->client->pers.cmd;

	//Save the target clientNum and set the weapon we're switching to.
	//ent->client->pers.targ_clientNum = (int)ucmd->weapon;
	//ucmd->weapon |= ent->client->pers.weapon;
	
	/*if ( ent->client->pers.dbgrws && ent->client->hitClient >= 1 ) {
			trap_SendServerCommand( ent-g_entities, va("print \"DBGRWS: Client Firing, claiming hit. Raw: %i at %i\n\"", ucmd->weapon, ucmd->serverTime) );
	}*/


	//ucmd->weapon = WEAPON_MASK(ucmd->weapon);

	if ( gameSettings.ping_fix == 2 ) {
		char *s, userinfo[MAX_INFO_STRING];
		int ping = 0, i = 0, oldPing = 0;

		trap_GetUserinfo( ent-g_entities, userinfo, sizeof(userinfo) );
		s = Info_ValueForKey( userinfo, "com_maxfps" );//Get /com_maxfps
		i = atoi(s);

		i = (1000 / i);
		oldPing = (client->pers.pingsamples[client->pers.samplehead==0?(NUM_PING_SAMPLES-1):(client->pers.samplehead-1)] + 20);
		ping = level.previousTime + client->frameOffset - ucmd->serverTime;
		ping -= i;

		//if we weren't recording before, or the current ping isn't 20ms spike or more than the last, but record it if the pingspare was comparable to it.
		if ( ping >= 0 && (!client->pers.pingsamples[0] || ((ping <= oldPing) && (ping <= client->pers.pingspare))) ) {
			client->pers.pingsamples[client->pers.samplehead] = ping;
			client->pers.samplehead++;
			if ( client->pers.samplehead >= NUM_PING_SAMPLES ) {
				client->pers.samplehead = 0;
			}
		} 
		client->pers.pingspare = ping + 20;
	}

	// sanity check the command time to prevent speedup cheating
	if ( ucmd->serverTime > level.time + 200 ) {
		ucmd->serverTime = level.time + 200;
//		G_Printf("serverTime <<<<<\n" );
	}
	if ( ucmd->serverTime < level.time - 1000 ) {
		ucmd->serverTime = level.time - 1000;
//		G_Printf("serverTime >>>>>\n" );
	} 

	//unlagged - smooth clients #1
	// keep track of this for later - we'll use this to decide whether or not
	// to send extrapolated positions for this client
	if (!forced || g_smoothClients.integer == 2 ) {
		ent->client->lastUpdateFrame = level.framenum;
	}
	//unlagged - smooth clients #1


//unlagged - backward reconciliation #4
	// frameOffset should be about the number of milliseconds into a frame 
	// this command packet was received, depending on how fast the server
	// does a G_RunFrame()
	client->frameOffset = trap_Milliseconds() - level.frameStartTime;

	// save the command time *before* pmove_fixed messes with the serverTime,
	// and *after* lag simulation messes with it :)
	// attackTime will be used for backward reconciliation later (time shift)
	client->attackTime = ucmd->serverTime;
//unlagged - backward reconciliation #4

	msec = ucmd->serverTime - client->ps.commandTime;
	// following others may result in bad times, but we still want
	// to check for follow toggles
	if ( msec < 1 && client->sess.spectatorState != SPECTATOR_FOLLOW ) {
		return;
	}
	if ( msec > 200 ) {
		msec = 200;
	}

	if ( pmove_msec.integer < 8 ) {
		trap_Cvar_Set("pmove_msec", "8");
	}
	else if (pmove_msec.integer > 33) {
		trap_Cvar_Set("pmove_msec", "33");
	}

	if ( (pmove_fixed.integer && sv_lock_pmove.integer) || client->pers.pmoveFixed ) {
		ucmd->serverTime = ((ucmd->serverTime + pmove_msec.integer-1) / pmove_msec.integer) * pmove_msec.integer;
		//if (ucmd->serverTime - client->ps.commandTime <= 0)
		//	return;
	}

	//
	// check for exiting intermission
	//
	if ( level.intermissiontime ) {
		ClientIntermissionThink( client );
		return;
	}

	// spectators don't do much
/*freeze
	if ( client->sess.sessionTeam == TEAM_SPECTATOR ) {
freeze*/
	if ( (g_gametype.integer == GT_FREEZE && is_spectator( client )) || (g_gametype.integer != GT_FREEZE && client->sess.sessionTeam == TEAM_SPECTATOR) ) {
//freeze
		if ( client->sess.spectatorState == SPECTATOR_SCOREBOARD ) {
			return;
		}
		SpectatorThink( ent, ucmd );
		return;
	}

	// check for inactivity timer, but never drop the local client of a non-dedicated server
	if ( !ClientInactivityTimer( client ) ) {
		return;
	}

	if ( level.match_timeout == 1 && level.time >= level.match_timein && level.match_time != -1 ) {
		trap_SendServerCommand( -1, va("cp \"\""));
		level.match_timeout = 0;
	} else if ( level.match_timeout == 1 && level.time >= level.match_interval ) { 
		int pausesec; 
		level.match_interval = level.time + 1000;
		pausesec = (level.match_timein - level.time) / 1000;
		if (level.match_time != -1) {
			trap_SendServerCommand( -1, va("cp \"Time out! %i seconds remaining\n\"", pausesec));
			if ( g_timelimit.integer ) {
				//We have a timelimit, "fake" a later startTime to adjust end time.
				level.startTime += 1000;
			}
		} else {
			trap_SendServerCommand( -1, va("cp \"Time out!\n\""));
			if ( g_timelimit.integer ) {
				//We have a timelimit, "fake" a later startTime to adjust end time.
				level.startTime += 1000;
			}
		}
	}  
	//UpdatePlayerLastKnownGood - Monkk added for flag sacrifice
	if ( //player is alive and has the flag, or in air
		g_flagSacrifice.integer != 0 &&
		(ent->client->ps.groundEntityNum != ENTITYNUM_NONE)								&&
		(ent->health > 0)																&& 
		(! ClassnameIsMover((&g_entities[ent->client->ps.groundEntityNum])->classname)) &&
		PlayerHasFlagPowerup(ent, -1)
		)
	{ 
		VectorCopy(ent->r.currentOrigin, v);
		VectorSubtract(v, level.playerLastKnownGood[ent - g_entities][0], v);
		if( VectorLength(v) >= SAC_UPDATE_DISTANCE ) { 
			//100 units away and not in air
			int contents = trap_PointContents( ent->r.currentOrigin, -1 );
			int touchingNoDrop = ( 
				(contents & (CONTENTS_NODROP | CONTENTS_LAVA | CONTENTS_SLIME) ) ||
				(ent->watertype & (CONTENTS_LAVA | CONTENTS_SLIME) )
			);

			if ( ! touchingNoDrop ) { 
				//it's not on a mover and it's not in a "flag sarcifice zone"
				VectorCopy(level.playerLastKnownGood[ent - g_entities][0], level.playerLastKnownGood[ent - g_entities][1]);
				VectorCopy(ent->r.currentOrigin, level.playerLastKnownGood[ent - g_entities][0]);//copy the ent's current location to LKG
			}
		}
	}

	// clear the rewards if time
	if ( level.time > client->rewardTime ) {
		client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
	}

		// freeze player (RELOAD_FAILED still allowed to move/look)
	if(level.match_timeout == 1) {
		client->ps.pm_type = PM_FREEZE;
	}
	else if ( client->noclip ) {
		client->ps.pm_type = PM_NOCLIP;
	} else if ( client->ps.stats[STAT_HEALTH] <= 0 ) {
		client->ps.pm_type = PM_DEAD;
	} else {
		client->ps.pm_type = PM_NORMAL;
	}

	client->ps.gravity = g_gravity.value;

	// set speed
	client->ps.speed = g_speed.value;

#ifdef MISSIONPACK
	if( bg_itemlist[client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_SCOUT ) {
		client->ps.speed *= 1.5;
	}
	else
#endif
	if ( client->ps.powerups[PW_HASTE] ) {
		client->ps.speed *= 1.3;
	}

	//monkk:grappling hook weapon and offhand grapple
	switch( weap_enableHook.integer ) {
		case 1: //offhand grapple
			if ( client->hook && !( ucmd->buttons & BUTTON_FIRE_GRAPPLE ) ) {
				Weapon_HookFree(client->hook);
			}
			break;
		case 2: //grapple weapon
			// Let go of the hook if we aren't firing
			if ( client->ps.weapon == WP_GRAPPLING_HOOK &&
				client->hook && !( ucmd->buttons & BUTTON_ATTACK ) ) {
				Weapon_HookFree(client->hook);
			}
			break;
/*		default: //hook not enabled
			break;	//don't do a thang
*/
	}

	// set up for pmove
	oldEventSequence = client->ps.eventSequence;

	memset (&pm, 0, sizeof(pm));

	// check for the hit-scan gauntlet, don't let the action
	// go through as an attack unless it actually hits something
	if ( WEAPON_MASK(client->ps.weapon) == WP_GAUNTLET && !( ucmd->buttons & BUTTON_TALK ) &&
		( ucmd->buttons & BUTTON_ATTACK ) && client->ps.weaponTime <= 0 ) {
		pm.gauntletHit = CheckGauntletAttack( ent );
		if ( !pm.gauntletHit ) {
			pm.gauntletJump = CheckGauntletJump( ent );
		}
	}

	if ( ent->flags & FL_FORCE_GESTURE ) {
		ent->flags &= ~FL_FORCE_GESTURE;
		ent->client->pers.cmd.buttons |= BUTTON_GESTURE;
	}

#ifdef MISSIONPACK
	// check for invulnerability expansion before doing the Pmove
	if (client->ps.powerups[PW_INVULNERABILITY] ) {
		if ( !(client->ps.pm_flags & PMF_INVULEXPAND) ) {
			vec3_t mins = { -42, -42, -42 };
			vec3_t maxs = { 42, 42, 42 };
			vec3_t oldmins, oldmaxs;

			VectorCopy (ent->r.mins, oldmins);
			VectorCopy (ent->r.maxs, oldmaxs);
			// expand
			VectorCopy (mins, ent->r.mins);
			VectorCopy (maxs, ent->r.maxs);
			trap_LinkEntity(ent);
			// check if this would get anyone stuck in this player
			if ( !StuckInOtherClient(ent) ) {
				// set flag so the expanded size will be set in PM_CheckDuck
				client->ps.pm_flags |= PMF_INVULEXPAND;
			}
			// set back
			VectorCopy (oldmins, ent->r.mins);
			VectorCopy (oldmaxs, ent->r.maxs);
			trap_LinkEntity(ent);
		}
	}
#endif

	pm.ps = &client->ps;
	pm.cmd = *ucmd;
	if ( pm.ps->pm_type == PM_DEAD ) {
		pm.tracemask = MASK_PLAYERSOLID & ~CONTENTS_BODY;
	}
	else if ( ent->r.svFlags & SVF_BOT ) {
		pm.tracemask = MASK_PLAYERSOLID | CONTENTS_BOTCLIP;
	}
	else {
		pm.tracemask = MASK_PLAYERSOLID;
	}
	pm.trace = trap_Trace;
	pm.pointcontents = trap_PointContents;
	pm.debugLevel = g_debugMove.integer;
	pm.noFootsteps = ( g_dmflags.integer & DF_NO_FOOTSTEPS ) > 0;

	//if ( sv_lock_pmove.integer == 1 ) {
	//pm.pmove_fixed = pmove_fixed.integer | client->pers.pmoveFixed;
	//	pm.pmove_fixed = pmove_fixed.integer;
	//} else {
	//	pm.pmove_fixed = client->pers.pmoveFixed;
	//}
	sv_lock_pmove.integer?(pm.pmove_fixed = pmove_fixed.integer):(pm.pmove_fixed = client->pers.pmoveFixed);
	pm.pmove_msec = pmove_msec.integer;

	VectorCopy( client->ps.origin, client->oldOrigin );

	if (g_allowObliterate.integer)
	{
		pm.timeOfDeath = ent->timeOfDeath;
	}
	else
	{
		pm.timeOfDeath = ent->client->pers.cmd.serverTime - 1;
	}

	pm.commandTime = ent->client->pers.cmd.serverTime;

#ifdef MISSIONPACK
	if (level.intermissionQueued != 0 && g_singlePlayer.integer) {
		if ( level.time - level.intermissionQueued >= 1000  ) {
			pm.cmd.buttons = 0;
			pm.cmd.forwardmove = 0;
			pm.cmd.rightmove = 0;
			pm.cmd.upmove = 0;
			if ( level.time - level.intermissionQueued >= 2000 && level.time - level.intermissionQueued <= 2500 ) {
				trap_SendConsoleCommand( EXEC_APPEND, "centerview\n");
			}
			ent->client->ps.pm_type = PM_SPINTERMISSION;
		}
	}
	Pmove (&pm);
#else
	Pmove (&pm);
#endif
	//We have to run a pmove before we can dump into client->
		if ( shifted ) {
			G_UnTimeShiftAllClients( ent );
		}
	//ent->client->distance = pm.adDistance;
	//G_Printf("%i -- %i", ent->client->distance, pm.adDistance );

	// save results of pmove
	if ( ent->client->ps.eventSequence != oldEventSequence ) {
		ent->eventTime = level.time;
	}
//unlagged - smooth clients #2
	// clients no longer do extrapolation if cg_smoothClients is 1, because
	// skip correction is all handled server-side now
	// since that's the case, it makes no sense to store the extra info
	// in the client's snapshot entity, so let's save a little bandwidth

	//if (!g_unlaggedSmoothClients.integer && g_smoothClients.integer == 1) {
	if (g_smoothClients.integer == 1) {
		BG_PlayerStateToEntityStateExtraPolate( &ent->client->ps, &ent->s, ent->client->ps.commandTime, qtrue );
	} else {
		BG_PlayerStateToEntityState( &ent->client->ps, &ent->s, qtrue );
//	}
//unlagged - smooth clients #2
	}
	SendPendingPredictableEvents( &ent->client->ps );

	if ( !( ent->client->ps.eFlags & EF_FIRING ) ) {
		client->fireHeld = qfalse;		// for grapple
	}

	// use the snapped origin for linking so it matches client predicted versions
	VectorCopy( ent->s.pos.trBase, ent->r.currentOrigin );

	VectorCopy (pm.mins, ent->r.mins);
	VectorCopy (pm.maxs, ent->r.maxs);

	ent->waterlevel = pm.waterlevel;
	ent->watertype = pm.watertype;

	// execute client events
	if(level.match_timeout == 0) {
		ClientEvents( ent, oldEventSequence );
	}

	// link entity now, after any personal teleporters have been used
	trap_LinkEntity (ent);
	if ( !ent->client->noclip ) {
		G_TouchTriggers( ent );
	}

	// NOTE: now copy the exact origin over otherwise clients can be snapped into solid
	VectorCopy( ent->client->ps.origin, ent->r.currentOrigin );

	//test for solid areas in the AAS file
	BotTestAAS(ent->r.currentOrigin);

	// touch other objects
	ClientImpacts( ent, &pm );

	// save results of triggers and client events
	if (ent->client->ps.eventSequence != oldEventSequence) {
		ent->eventTime = level.time;
	}

	// swap and latch button actions
	client->oldbuttons = client->buttons;
	client->buttons = ucmd->buttons;
	client->latched_buttons |= client->buttons & ~client->oldbuttons;

	// check for respawning
	//FIXME: May not be needed.
	if ( client->ps.stats[STAT_HEALTH] <= 0 /*&& (g_allowObliterate.integer == 0 ||
		(g_allowObliterate.integer && pm.timeOfDeath >= pm.commandTime) )*/ ) {
		// wait for the attack button to be pressed
		if ( level.time > client->respawnTime ) {
			// forcerespawn is to prevent users from waiting out powerups
			if ( g_forcerespawn.integer > 0 && 
				( level.time - client->respawnTime ) > g_forcerespawn.integer * 1000 ) {
				respawn( ent );
				return;
			}
		
			// pressing attack or use is the normal respawn method
			if ( ucmd->buttons & ( BUTTON_ATTACK | BUTTON_USE_HOLDABLE ) ) {
				respawn( ent );
			}
		}
		return;
	}

	// perform once-a-second actions
	if(level.match_timeout == 0) {
		ClientTimerActions( ent, msec );
	}
}
//Monkk
qboolean PlayerHasFlagPowerup(gentity_t *ent, int flag) {
	qboolean hasFlag = qtrue;

	if (! ent || ! ent->client) {
		return qfalse;
	}

	if (flag == -1) { //search for any flag
		if( ent->client->ps.powerups[PW_REDFLAG] ) {
		} else if( ent->client->ps.powerups[PW_BLUEFLAG] ) {
#ifdef MISSIONPACK
		} else if( ent->client->ps.powerups[PW_NEUTRALFLAG] ) {
#endif
		} else {
			hasFlag = qfalse;
		}
	} else { //just the flag in particular
		hasFlag = (qboolean)(ent->client->ps.powerups[flag]);
	}

	return hasFlag;
}
qboolean ClassnameIsMover(char *classname) {
	qboolean rslt = qfalse;
	//monkk: hmm... managed to get a null pointer sent in here...
	if( !classname ) {
		return qtrue;//monkk: if the classname is null, chances are it can move i think
	}
	if (
		(strcmp(classname, "func_bobbing"	) == 0) ||
		//(strcmp(classname, "func_button"	) == 0) ||
		(strcmp(classname, "func_door"	) == 0) ||
		//(strcmp(classname, "func_group"	) == 0) ||
		(strcmp(classname, "func_pendulum") == 0) ||
		(strcmp(classname, "func_plat"	) == 0) ||
		(strcmp(classname, "func_rotating") == 0) ||
		//(strcmp(classname, "func_static"	) == 0) ||
		//(strcmp(classname, "func_timer"	) == 0) ||
		(strcmp(classname, "func_train"	) == 0) 
		)
	{
		rslt = qtrue;
	}
	return rslt;
}
void SpawnFlagAtLastKnownGood(gentity_t *flag) { 
	gentity_t	*pEnt;
	gitem_t		*item; 
	vec3_t		lastKnownGood;
	int			flagPowerupIndex, flagCheckCount,flagTeam;
	qboolean	flagSacrificed = qfalse;

	//the flag item is calling to sacrifice itself
	
	//sets up flagPowerupIndex, flagCheckCount, and finds the pEnt for the player last holding the flag
	flagSacrificed = qtrue;
	flagPowerupIndex = flag->item->giTag;
	item = flag->item;

	//determine the power up index for the flag that is thinking
	flagCheckCount = (flagPowerupIndex==PW_REDFLAG)?0:((flagPowerupIndex==PW_BLUEFLAG)?1:2);
	//set the player entity
	pEnt = &g_entities[flag->flagSacData.lastPickupPlayerEntNum];
	trap_UnlinkEntity(flag);

	//pick an LKG, and don't attempt a sacrifice more then 3 times...
	switch( flag->flagSacData.sacrificeCount ) {
		case 0:
			//1st attempt, use the players LKG. 
			VectorCopy(flag->flagSacData.sacrificePos[flag->flagSacData.sacrificeCount], lastKnownGood);
			break;
		case 1:
			//2nd attempt, try the secondary LKG
			trap_SendServerCommand(-1, "print \""S_COLOR_RED"Error: invalid LKG, attempting secondary.\n\"\n");
			VectorCopy(flag->flagSacData.sacrificePos[flag->flagSacData.sacrificeCount], lastKnownGood);
			break;
		default :
			flagTeam = (flag->item->giTag==PW_REDFLAG)?TEAM_RED:((flag->item->giTag==PW_BLUEFLAG)?TEAM_BLUE:TEAM_FREE);
			//just return it to the base... something screwy has occured
			trap_SendServerCommand(-1, "print \""S_COLOR_RED"Error: invalid LKG determination. Flag returned to base\n\"\n");
			Team_ReturnFlag( flagTeam );
			return;
	}

	//move the falling flag to be the LKG
	//G_SetOrigin( flag, lastKnownGood );
	VectorCopy(lastKnownGood, flag->s.pos.trBase);
	VectorCopy(lastKnownGood, flag->r.currentOrigin);
	flag->s.pos.trDuration = 0;
	flag->s.pos.trTime = 0;
	VectorClear(flag->s.pos.trDelta);

	flag->s.pos.trType = TR_GRAVITY;// TR_STATIONARY;
	trap_LinkEntity(flag);
	//set the flag status for the correct flag we dropped
	Team_CheckDroppedItem(flag);
	//display sacrifice the text and play the sound
	AnnounceFlagSacrifice(flag);
	//increment the sac count
	flag->flagSacData.sacrificeCount++;

	return; 
} 
static char *sacStart		= "\""S_COLOR_YELLOW"-- ";
static char *sacBlueFlag	= S_COLOR_BLUE"BLUE FLAG";
static char *sacRedFlag		= S_COLOR_RED"RED FLAG";
static char *sacNeutralFlag = S_COLOR_WHITE"NEUTRAL FLAG";
static char *sacUnknownFlag = S_COLOR_MAGENTA"UNKNOWN?!? FLAG";
static char *sacMid			= " "S_COLOR_YELLOW"was SACRIFICED by: "S_COLOR_WHITE;
static char *sacMidBig		= " "S_COLOR_YELLOW"SACRIFICED near \n";
static char *sacEnd			= " "S_COLOR_YELLOW"--"S_COLOR_WHITE;
static char *sacUnknownLoc	= S_COLOR_YELLOW"--Unknown";
void AnnounceFlagSacrifice(gentity_t *flag) {
	gentity_t	*te;
	char		name[128];
	int			flagColor = flag->item->giTag;
	// don't let text be too long for malicious reasons
	char		location[64];
	qboolean	locFound = qfalse;

	//get location message based on location of last known good ent, for that extra level of accuracy
	locFound = Team_GetLocationMsgByVec(flag->flagSacData.sacrificePos[flag->flagSacData.sacrificeCount], location, sizeof(location));
	if ( locFound && location ) {
		Com_sprintf (name, sizeof(name), "%s "S_COLOR_YELLOW"near the %s"S_COLOR_WHITE, flag->flagSacData.sacPlayerName, location);
	} else {
		Com_sprintf (name, sizeof(name), S_COLOR_WHITE"%s", flag->flagSacData.sacPlayerName );
	}

	//anything meaningful to log... dunno
	//G_LogPrintf( "flag sacrifice: %s: %s %s\n", player->client->pers.netname, chatText );
	/*G_Printf("flag sacrifice: %s: %s\n", player->client->pers.netname);
	G_Printf("location: %s\n", location);*/
	// send it to all the apropriate clients
	switch (flagColor) {
		case PW_REDFLAG :
			if (g_sacrificeAnnounce.integer & SAC_CONSOLE) {
				trap_SendServerCommand(-1, va("chat %s%s%s%s%s",sacStart,sacRedFlag,sacMid,name,sacEnd));
			}
			if (g_sacrificeAnnounce.integer & SAC_SCREEN) {
				trap_SendServerCommand(-1, va(  "cp \"%s%s%s\n\"", sacRedFlag,sacMidBig,(locFound)?location:sacUnknownLoc));
			}
			break;
		case PW_BLUEFLAG :
			if (g_sacrificeAnnounce.integer & SAC_CONSOLE) {
				trap_SendServerCommand(-1, va("chat %s%s%s%s%s",sacStart,sacBlueFlag,sacMid,name,sacEnd));
			}
			if (g_sacrificeAnnounce.integer & SAC_SCREEN) {
				trap_SendServerCommand(-1, va(  "cp \"%s%s%s\n\"", sacBlueFlag,sacMidBig,(locFound)?location:sacUnknownLoc));
			}
			break;
		case PW_NEUTRALFLAG :
			if (g_sacrificeAnnounce.integer & SAC_CONSOLE) {
				trap_SendServerCommand(-1, va("chat %s%s%s%s%s",sacStart,sacNeutralFlag,sacMid,name,sacEnd));
			}
			if (g_sacrificeAnnounce.integer & SAC_SCREEN) {
				trap_SendServerCommand(-1, va(  "cp \"%s%s%s\n\"", sacNeutralFlag,sacMidBig,(locFound)?location:sacUnknownLoc));
			}
			break;
		default :
			if (g_sacrificeAnnounce.integer & SAC_CONSOLE) {
				trap_SendServerCommand(-1, va("chat %s%s%s%s%s",sacStart,sacUnknownFlag,sacMid,name,sacEnd));
			}
			if (g_sacrificeAnnounce.integer & SAC_SCREEN) {
				trap_SendServerCommand(-1, va(  "cp \"%s%s%s\n\"", sacUnknownFlag,sacMidBig,(locFound)?location:sacUnknownLoc));
			}
			break;
	}

	if (g_sacrificeAnnounce.integer & SAC_SOUND && (flag->flagSacData.sacrificeCount < 2) ) {
		te = G_TempEntity( flag->flagSacData.sacrificePos[flag->flagSacData.sacrificeCount], EV_GLOBAL_SOUND );
		te->s.eventParm = G_SoundIndex( "sound/teamplay/flagtaken_opponent_01.wav" );
		te->r.svFlags |= SVF_BROADCAST;
	}
}

void StoreClientCommand(int clientNum, usercmd_t* cmd) {
	gentity_t *ent;
//	int			j;

	//Set the game entity of the client
	ent = g_entities + clientNum;
	ent->client->pers.cmdStackIndex++;//Go to the next command in stack

	if (ent->client->pers.cmdStackIndex > 255)
		ent->client->pers.cmdStackIndex = 0;//Loop commands

	//Copy the command to the stack.
	memcpy( &ent->client->pers.cmdStack[ent->client->pers.cmdStackIndex], cmd, sizeof(usercmd_t) );
}

/***************
RetrieveClientCommand
returns qtrue when it finds a command to be executed
***************/
qboolean RetrieveClientCommand(int clientNum, usercmd_t* cmd) {
	int			i;
//	int			j;
	int			count = 0;
	gentity_t	*ent;
	usercmd_t	*tmpCmd = 0;

	ent = g_entities + clientNum;//Client
	i = ent->client->pers.cmdStackIndex;
	tmpCmd = &ent->client->pers.cmdStack[i];//Last executed command

	
/**/
	if ( ent->r.svFlags & SVF_BOT || level.intermissiontime || ent->client->frameAimType == 0 || ent->client->frameAimType == 1  || ent->client->frameAimType == 3) {
		if (tmpCmd && tmpCmd->serverTime) {
			//Copy the current command to be executed
			memcpy( &ent->client->pers.cmd, tmpCmd, sizeof(usercmd_t) );
			memset( tmpCmd, 0, sizeof(usercmd_t) );//tmpCmd is no longer useful

			if ( ent->client->frameAimType != 3 )
				ent->client->hitClient = 0;//We're not using a client Hitscan so any value is useless

			ent->client->lastCmdTime = level.time;//Set the command time to now because we ran now.
			return qtrue;
		}
		return qfalse;
	}
/**/

	while (tmpCmd && tmpCmd->serverTime) {
		i--;
		count++;
		if (i < 0)
			i = 255;

		if (i == ent->client->pers.cmdStackIndex) {
			//if we're at the stackIndex go to the next command
			i++;
			if (i > 255) {
				i = 0;
			}

			tmpCmd = &ent->client->pers.cmdStack[i];//Get the 'next' command

			memcpy( &ent->client->pers.cmd, tmpCmd, sizeof(usercmd_t) );//Set the 'next' command to the current one executed
			memset( tmpCmd, 0, sizeof(usercmd_t) );

			ent->client->hitClient = 0;//Reset the hitClient - we'll set it later [fixme: dunno why we couldn't do it now]

			ent->client->lastCmdTime = level.time;//Set the command time to now because we ran now.
			return qtrue;
		}

		tmpCmd = &ent->client->pers.cmdStack[i];
	} 

	i++;
	if (i > 255) {
		i = 0;
	}

	tmpCmd = &ent->client->pers.cmdStack[i];

	if (tmpCmd && tmpCmd->serverTime) {
		if (ent->r.svFlags & SVF_BOT || level.intermissiontime || ent->client->frameAimType == 0 || ent->client->frameAimType == 1 || ent->client->frameAimType == 3) {
			//Copy the current command to be executed
			memcpy( &ent->client->pers.cmd, tmpCmd, sizeof(usercmd_t) );
			memset( tmpCmd, 0, sizeof(usercmd_t) );//tmpCmd is no longer useful

			if ( ent->client->frameAimType != 3 )
				ent->client->hitClient = 0;//We're not using a client Hitscan so any value is useless

			ent->client->lastCmdTime = level.time;//Set the command time to now because we ran now.
			return qtrue;
		}

		if (ent->client->frameAimType == 2 || ent->client->lastCmdTime < level.time - 500 || ent->client->fixLockup > level.time - 500){
			if (ent->client->lastCmdTime < level.time - 500) {
				//FIXME: What was this supposed to do?
				ent->client->fixLockup = level.time;
			}

			//
			if (count > 1) {
				i++;
				if (i > 255)
					i = 0;

				//Set the hitCleint
				ent->client->hitClient = ent->client->pers.cmdStack[i].weapon;

				tmpCmd->weapon = ent->client->weaponSwitch;

				memcpy( &ent->client->pers.cmd, tmpCmd, sizeof(usercmd_t) );
				memset( tmpCmd, 0, sizeof(usercmd_t) );


				// If we've gotten to this point, the client is either using aimType 2, or
				// we've been forced to use aimType 2 because it's too laggy to use aimType 3
				ent->client->frameAimType = 2;
				return qtrue;
			} else {
				return qfalse;
			}
			/**/
		}
	}
	//Nothing worked out right
	return qfalse;
}
//Monkk
/*
==================
ClientThink

A new command has arrived from the client
==================
*/
void ClientThink( int clientNum ) {
	gentity_t *ent;
	usercmd_t	cmd;

	ent = g_entities + clientNum;
	if (!ent->client)
		return;
	trap_GetUsercmd( clientNum, &cmd );

	ent->client->frameAimType = ent->client->sess.aimType;
	

	//ent->client->pers.targ_clientNum = (int)ent->client->pers.cmd.weapon;
	//ent->client->pers.last_EventTime = ent->client->pers.cmd.serverTime;
	//G_Printf("clientNum: %i -- clientNum + 1/: %i", (int)ent->client->pers.cmd.weapon - 1, (int)ent->client->pers.cmd.weapon + 2);

//unlagged - smooth clients #1
	// this is handled differently now

	// mark the time we got info, so we can display the
	// phone jack if they don't get any for a while
	//if ( !g_unlaggedSmoothClients.integer ) {
	if ( g_smoothClients.integer != 2 ) {
		ent->client->lastCmdTime = level.time;
	}

//unlagged - smooth clients #1

	/**/
	StoreClientCommand( clientNum, &cmd );

	ent->client->frameAimType = ent->client->sess.aimType;

	while (RetrieveClientCommand( clientNum, &cmd )) {
		if ( !(ent->r.svFlags & SVF_BOT) && !g_synchronousClients.integer ) {

			ent->client->lastCmdTime = level.time;

			//UnlinkUninteractibleEntities(ent);

			ClientThink_real( ent, 0 );

			//RelinkUninteractibleEntities();
			
		}
	}
	/** /

	memcpy( &ent->client->pers.cmd, &cmd, sizeof(usercmd_t) );

	if ( !(ent->r.svFlags & SVF_BOT) && !g_synchronousClients.integer ) 
	{

		ent->client->lastCmdTime = level.time;

		UnlinkUninteractibleEntities(ent);

		ClientThink_real( ent, 0 );

		RelinkUninteractibleEntities();
		
	}

	/**/
}


void G_RunClient( gentity_t *ent ) {
	if ( !(ent->r.svFlags & SVF_BOT) && !g_synchronousClients.integer ) {
		return;
	}
	//UnlinkUninteractibleEntities(ent);
	ent->client->pers.cmd.serverTime = level.time;
	ClientThink_real( ent, 0 );
	//RelinkUninteractibleEntities();
}


/*
==================
SpectatorClientEndFrame

==================
*/
void SpectatorClientEndFrame( gentity_t *ent ) {
	gclient_t	*cl;
	int			ping;

	if ( gameSettings.ping_fix ) {
		ping = ent->client->ps.ping;//new!!
	}
	// if we are doing a chase cam or a remote view, grab the latest info
	if ( ent->client->sess.spectatorState == SPECTATOR_FOLLOW ) {
		int		clientNum, flags;

		clientNum = ent->client->sess.spectatorClient;

		// team follow1 and team follow2 go to whatever clients are playing
		if ( clientNum == -1 ) {
			clientNum = level.follow1;
		} else if ( clientNum == -2 ) {
			clientNum = level.follow2;
		}
		if ( clientNum >= 0 ) {

			ent->client->pers.stats_specnum = clientNum + 1; // Lucron: specspy

			cl = &level.clients[ clientNum ];
/*freeze
			if ( cl->pers.connected == CON_CONNECTED && cl->sess.sessionTeam != TEAM_SPECTATOR ) {
freeze*/
			if ( (g_gametype.integer == GT_FREEZE && cl->pers.connected == CON_CONNECTED && !is_spectator( cl )) || 
				(g_gametype.integer != GT_FREEZE && cl->pers.connected == CON_CONNECTED && cl->sess.sessionTeam != TEAM_SPECTATOR) ) {
//freeze
				flags = (cl->ps.eFlags & ~(EF_VOTED | EF_TEAMVOTED)) | (ent->client->ps.eFlags & (EF_VOTED | EF_TEAMVOTED));
				//cl->pers.realPing = cl->ps.ping;
				//ent->client->pers.realPing = ent->client->ps.ping;
				//G_Printf("%i %i", ent->client->pers.realPing, ent->client->ps.ping);
/*freeze*/
				if ( g_gametype.integer != GT_FREEZE ) {
					ent->client->ps = cl->ps;
/*freeze*/		} else {
					Persistant_spectator( ent, cl );
				}
//freeze
				//G_Printf("%i %i", ent->client->pers.realPing, ent->client->ps.ping);
				if ( gameSettings.ping_fix ) {
					ent->client->ps.ping = ping;
				}
				ent->client->ps.pm_flags |= PMF_FOLLOW;
				ent->client->ps.eFlags = flags;
				return;
			} else {
				// drop them to free spectators unless they are dedicated camera followers
				if ( ent->client->sess.spectatorClient >= 0 ) {
		/*freeze*/	if ( g_gametype.integer != GT_FREEZE ) {
						ent->client->sess.spectatorState = SPECTATOR_FREE;
						ClientBegin( ent->client - level.clients );
		/*freeze*/  } else {
						StopFollowing( ent );
					}
//freeze
				}
			}
		} else {
			ent->client->pers.stats_specnum = 0; //Lucron: specspy
		}

	}

	if ( ent->client->sess.spectatorState == SPECTATOR_SCOREBOARD ) {
		ent->client->ps.pm_flags |= PMF_SCOREBOARD;
	} else {
		ent->client->ps.pm_flags &= ~PMF_SCOREBOARD;
	}
	//ent->client->ps.ping = ping;
}

/*
==============
ClientEndFrame

Called at the end of each server frame for each connected client
A fast client will have multiple ClientThink for each ClientEndFrame,
while a slow client may have multiple ClientEndFrame between ClientThink.
==============
*/
void ClientEndFrame( gentity_t *ent ) {
	int			i;
	int			clientCmdTime;
	clientPersistant_t	*pers;
	usercmd_t	cmd;

//unlagged - smooth clients #1
	int frames;
//unlagged - smooth clients #1

/*freeze
	if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
freeze*/
	if ( ( g_gametype.integer == GT_FREEZE && is_spectator( ent->client ) ) || 
		( g_gametype.integer != GT_FREEZE && ent->client->sess.sessionTeam == TEAM_SPECTATOR )) {
//freeze
		SpectatorClientEndFrame( ent );
		return;
	}
	
	//ent->client->pers.stats_specnum = 0; //Lucron: specspy

	pers = &ent->client->pers;

	// turn off any expired powerups
	for ( i = 0 ; i < MAX_POWERUPS ; i++ ) {
		// Make sure we dont let stuff like CTF flags expire.
		if(level.match_timeout == 1 && ent->client->ps.powerups[i] != INT_MAX) {
				ent->client->ps.powerups[i] += level.time - level.previousTime;
		}

		if ( ent->client->ps.powerups[ i ] < level.time ) {
			ent->client->ps.powerups[ i ] = 0;
		}
	}

#ifdef MISSIONPACK
	// set powerup for player animation
	if( bg_itemlist[ent->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_GUARD ) {
		ent->client->ps.powerups[PW_GUARD] = level.time;
	}
	if( bg_itemlist[ent->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_SCOUT ) {
		ent->client->ps.powerups[PW_SCOUT] = level.time;
	}
	if( bg_itemlist[ent->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_DOUBLER ) {
		ent->client->ps.powerups[PW_DOUBLER] = level.time;
	}
	if( bg_itemlist[ent->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_AMMOREGEN ) {
		ent->client->ps.powerups[PW_AMMOREGEN] = level.time;
	}
	if ( ent->client->invulnerabilityTime > level.time ) {
		ent->client->ps.powerups[PW_INVULNERABILITY] = level.time;
	}
#endif

		if(level.match_timeout == 1) {
			int time_delta = level.time - level.previousTime;

			ent->client->airOutTime += time_delta;
			ent->client->inactivityTime += time_delta;
		//	ent->client->pers.connected += time_delta;
			ent->client->pers.enterTime += time_delta;
			ent->client->pers.teamState.lastreturnedflag += time_delta;
			ent->client->pers.teamState.lasthurtcarrier += time_delta;
			ent->client->pers.teamState.lastfraggedcarrier += time_delta;
			ent->pain_debounce_time += time_delta;

		}

	// save network bandwidth
#if 0
	if ( !g_synchronousClients->integer && ent->client->ps.pm_type == PM_NORMAL ) {
		// FIXME: this must change eventually for non-sync demo recording
		VectorClear( ent->client->ps.viewangles );
	}
#endif

	//
	// If the end of unit layout is displayed, don't give
	// the player any normal movement attributes
	//
	if ( level.intermissiontime ) {
		return;
	}

//unlagged - smooth clients #1
	// see how many frames the client has missed
	frames = level.framenum - ent->client->lastUpdateFrame - 1;

	// don't extrapolate more than two frames
	if ( frames > 4 ) {
		ent->client->frameAimType = 1;
		clientCmdTime = ent->client->lastCmdTime;

		while (RetrieveClientCommand( ent->client->ps.clientNum, &cmd )) {
			if ( !(ent->r.svFlags & SVF_BOT) && !g_synchronousClients.integer ) {
				//UnlinkUninteractibleEntities(ent);
				ClientThink_real( ent, 1 );
				//RelinkUninteractibleEntities();
			}
		}
		//cmd.weapon = ent->client->weaponSwitch;//trial
		ent->client->lastCmdTime = clientCmdTime;
	}

	if(level.match_timeout == 0) {
		// burn from lava, etc
		P_WorldEffects (ent);

		// apply all the damage taken this frame
		P_DamageFeedback (ent);
	}

	// add the EF_CONNECTION flag if we haven't gotten commands recently
	if ( g_smoothClients.integer != 2 ) {
		if ( level.time - ent->client->lastCmdTime > 1000 ) {
			ent->s.eFlags |= EF_CONNECTION;
		} else {
			ent->s.eFlags &= ~EF_CONNECTION;
		}
	}

	ent->client->ps.stats[STAT_HEALTH] = ent->health;	// FIXME: get rid of ent->health...

	G_SetClientSound (ent);

	// set the latest information
//unlagged - smooth clients #2
	// clients no longer do extrapolation if cg_smoothClients is 1, because
	// skip correction is all handled server-side now
	// since that's the case, it makes no sense to store the extra info
	// in the client's snapshot entity, so let's save a little bandwidth

	if (g_smoothClients.integer == 1) {
		BG_PlayerStateToEntityStateExtraPolate( &ent->client->ps, &ent->s, ent->client->ps.commandTime, qtrue );
	} else {
		BG_PlayerStateToEntityState( &ent->client->ps, &ent->s, qtrue );
	}
//unlagged - smooth clients #2

	SendPendingPredictableEvents( &ent->client->ps );

	if ( ent->client->lastUpdateFrame != 0 && frames > 400 && ent->client->ps.ping >= 999 ) {
		trap_DropClient( ent->client->ps.clientNum, "No packet flow." );
		return;
	}
//unlagged - smooth clients #1
	//if ( g_unlaggedSmoothClients.integer ) {
	if ( g_smoothClients.integer == 2 ) {
		// mark as not missing updates initially
		ent->client->ps.eFlags &= ~EF_CONNECTION;

		// see how many frames the client has missed
		frames = level.framenum - ent->client->lastUpdateFrame - 1;

		// don't extrapolate more than two frames
		if ( frames > 4 ) {
			frames = 4;

			// if they missed more than two in a row, show the phone jack
			ent->client->ps.eFlags |= EF_CONNECTION;
			ent->s.eFlags |= EF_CONNECTION;
		}

		// did the client miss any frames?
		if ( frames > 0 && g_smoothClients.integer ) {
			// yep, missed one or more, so extrapolate the player's movement
			G_PredictPlayerMove( ent, (float)frames / sv_fps.integer );
			// save network bandwidth
			SnapVector( ent->s.pos.trBase );
		}
	}
//unlagged - smooth clients #1
//unlagged - backward reconciliation #1
	// store the client's position for backward reconciliation later
	G_StoreHistory( ent );
//unlagged - backward reconciliation #1

	// set the bit for the reachability area the client is currently in
//	i = trap_AAS_PointReachabilityAreaIndex( ent->client->ps.origin );
//	ent->client->areabits[i >> 3] |= 1 << (i & 7);

}
/*
int G_AllowEntityInteraction(gentity_t *client, gentity_t *ent)
{
	int clientNum1 = -1;
	int clientNum2 = -1;
	gentity_t *ent1;
	gentity_t *ent2;

	//int debug = 0;

	//return 1;

	if (!client || !ent)
		return 0;


	if (client->client)
	{
		clientNum1 = client->s.number;

	}
	if (clientNum1 < 0 || clientNum1 >= MAX_CLIENTS)
	{
		if (client->parent && client->parent->client)
		{
			clientNum1 = client->parent->client->ps.clientNum;
		}
	}
	if (clientNum1 < 0 || clientNum1 >= MAX_CLIENTS)
	{
		return 1;
	}



	if (ent->client)
	{
		clientNum2 = ent->s.number;
	}
	if (clientNum2 < 0 || clientNum2 >= MAX_CLIENTS)
	{
		if (ent->parent && ent->parent->client)
		{
			clientNum2 = ent->parent->client->ps.clientNum;
		}
	}

	if (clientNum2 < 0 || clientNum2 >= MAX_CLIENTS)
	{
		return 1;
	}


	ent1 = &g_entities[ clientNum1 ];
	ent2 = &g_entities[ clientNum2 ];

	if (!ent1->client)
		return 1;
	if (!ent2->client)
		return 1;


	
	if (ent1->client->pers.connected != CON_CONNECTED)
		return 0;

	if (ent2->client->pers.connected != CON_CONNECTED)
		return 0;
	


	if (clientNum1 == clientNum2)
		return 1;


	


	if (ent1->client->sess.sessionTeam == TEAM_SPECTATOR || ent2->client->sess.sessionTeam == TEAM_SPECTATOR)
	{
		return 0;
	}*/


/*	if (ent1->client->sess.sessionTeam == TEAM_WARMUP)
	{
		if (ent2->client->sess.sessionTeam != TEAM_WARMUP)
			return 0;
	}

	if (ent2->client->sess.sessionTeam == TEAM_WARMUP)
	{
		if (ent1->client->sess.sessionTeam != TEAM_WARMUP)
			return 0;
	}*/
/*
	return 1;
}



int G_TestCanTouchEnt( int clientNum, int entityNum )
{

	return G_AllowEntityInteraction ( &g_entities[ clientNum ], &g_entities[ entityNum ] );
}*/


int GetClientMask( team_t team )
{
	int				i;
	int				mask;
	gentity_t		*ent;

	mask = 0;

	for (i = 0; i < 32; i++)
	{
		ent = &g_entities[i];

		if (!ent)
			continue;
		if (!ent->client)
			continue;
		//if (ent->client->pers.connected != CON_CONNECTED)
		//	continue;

					

/*		if (team == TEAM_WARMUP)
		{
			if (ent->client->sess.sessionTeam != TEAM_WARMUP)
				continue;
		}
		else 
		{
			if (ent->client->sess.sessionTeam == TEAM_WARMUP)
				continue;
		}*/

		//trap_SendServerCommandC( i, va("print \"%i\n\"", i) );

		mask |= (1 << ent->client->ps.clientNum);
		//mask |= (1 << i);
	}

	return mask;
}


int GetClientMaskExclude( team_t team, int exclude )
{
	int				i;
	int				mask;
	gentity_t		*ent;

	mask = 0;

	for (i = 0; i < 32; i++)
	{
		ent = &g_entities[i];

		if (!ent)
			continue;
		if (!ent->client)
			continue;
		//if (ent->client->pers.connected != CON_CONNECTED)
		//	continue;
		if (ent->client->ps.clientNum == exclude)
			continue;
/*		if (team == TEAM_WARMUP)
		{
			if (ent->client->sess.sessionTeam != TEAM_WARMUP)
				continue;
		}
		else 
		{
			if (ent->client->sess.sessionTeam == TEAM_WARMUP)
				continue;
		}*/


		mask |= (1 << ent->client->ps.clientNum);
	}

	return mask;
}


/*
gentity_t*	g_unlinkedEntities[MAX_GENTITIES];
int			g_unlinked = 0;

void UnlinkUninteractibleEntities(gentity_t *ent)
{
	int			i;

	g_unlinked = 0;

	// unlink all entities that this user can't interact with.
	for (i = 0; i < MAX_GENTITIES; i++)
	{
		if (g_entities[i].r.linked && !G_AllowEntityInteraction(ent, &g_entities[i]))
		{
			g_unlinkedEntities[g_unlinked] = &g_entities[i]; 

			trap_UnlinkEntity(&g_entities[i]);

			g_unlinkedEntities[g_unlinked]->relink = 1;

			g_unlinked++;
		}
	}
}



void RelinkUninteractibleEntities()
{
	int			i;

	// relink all entities that were previously unlinked
	for ( i = 0 ; i < g_unlinked ; i++ ) {
		if (g_unlinkedEntities[i])// && g_unlinkedEntities[i]->relink)
			trap_LinkEntity( g_unlinkedEntities[i] );
	}	
}
*/

