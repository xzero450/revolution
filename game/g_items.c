// Copyright (C) 1999-2000 Id Software, Inc.
//
#include "g_local.h"
#include "bg_promode.h"

/*

  Items are any object that a player can touch to gain some effect.

  Pickup will return the number of seconds until they should respawn.

  all items should pop when dropped in lava or slime

  Respawnable items don't actually go away when picked up, they are
  just made invisible and untouchable.  This allows them to ride
  movers and respawn apropriately.
*/


#define	RESPAWN_ARMOR		25
#define	RESPAWN_HEALTH		35
#define	RESPAWN_AMMO		40
#define	RESPAWN_HOLDABLE	60
#define	RESPAWN_MEGAHEALTH	35//120
#define	RESPAWN_POWERUP		120


//======================================================================

int Pickup_Powerup( gentity_t *ent, gentity_t *other ) {
	int			quantity;
	int			i;
	gclient_t	*client;

	if ( other->client->spawnProtection == qtrue) {
		//FIXME: Should we really turn off spawn protection just because we grabbed a power up?
		other->client->spawnProtection = qfalse;
	}

	if ( !other->client->ps.powerups[ent->item->giTag] ) {
		// round timing to seconds to make multiple powerup timers
		// count in sync
		other->client->ps.powerups[ent->item->giTag] = 
			level.time - ( level.time % 1000 );
	}

	if ( ent->count ) {
		quantity = ent->count;
	} else {
		quantity = ent->item->quantity;
	}

	other->client->ps.powerups[ent->item->giTag] += quantity * 1000;

	// give any nearby players a "denied" anti-reward
	for ( i = 0 ; i < level.maxclients ; i++ ) {
		vec3_t		delta;
		float		len;
		vec3_t		forward;
		trace_t		tr;

		client = &level.clients[i];
		if ( client == other->client ) {
			continue;
		}
		if ( client->pers.connected == CON_DISCONNECTED ) {
			continue;
		}
		if ( client->ps.stats[STAT_HEALTH] <= 0 ) {
			continue;
		}

    // if same team in team game, no sound
    // cannot use OnSameTeam as it expects to g_entities, not clients
  	if ( g_gametype.integer >= GT_TEAM && other->client->sess.sessionTeam == client->sess.sessionTeam  ) {
      continue;
    }
//freeze
	if ( g_gamemode.integer > 3 ) {
		if ( is_spectator( other->client ) ) continue;
	}
//freeze

		// if too far away, no sound
		VectorSubtract( ent->s.pos.trBase, client->ps.origin, delta );
		len = VectorNormalize( delta );
		if ( len > 192 ) {
			continue;
		}

		// if not facing, no sound
		//if ( g_AdvancedDamage.integer == 0 ) {
			//I personally don't care what direction we're facing
			//Play the sound, players can back into it.
		AngleVectors( client->ps.viewangles, forward, NULL, NULL );
		if ( DotProduct( delta, forward ) < 0.4 ) {
			continue;
		}
		//}

		// if not line of sight, no sound
		trap_Trace( &tr, client->ps.origin, NULL, NULL, ent->s.pos.trBase, ENTITYNUM_NONE, CONTENTS_SOLID );
		if ( tr.fraction != 1.0 ) {
			continue;
		}

		// anti-reward
		client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_DENIEDREWARD;
	}
	//return RESPAWN_POWERUP;
	// CPM: Battle Suit uses different respawn times from the other powerups in cpm
	return (ent->item->giTag == PW_BATTLESUIT) ? cpm_itemrespawnBS : cpm_itemrespawnpowerup; // CPM
}

//======================================================================

#ifdef MISSIONPACK
int Pickup_PersistantPowerup( gentity_t *ent, gentity_t *other ) {
	int		clientNum;
	char	userinfo[MAX_INFO_STRING];
	float	handicap;
	int		max;

	other->client->ps.stats[STAT_PERSISTANT_POWERUP] = ent->item - bg_itemlist;
	other->client->persistantPowerup = ent;

	switch( ent->item->giTag ) {
	case PW_GUARD:
		clientNum = other->client->ps.clientNum;
		trap_GetUserinfo( clientNum, userinfo, sizeof(userinfo) );
		handicap = atof( Info_ValueForKey( userinfo, "handicap" ) );
		if( handicap<=0.0f || handicap>100.0f) {
			handicap = 100.0f;
		}
		max = (int)(2 *  handicap);

		other->health = max;
		other->client->ps.stats[STAT_HEALTH] = max;
		other->client->ps.stats[STAT_MAX_HEALTH] = max;
		other->client->ps.stats[STAT_ARMOR] = max;
		other->client->pers.maxHealth = max;

		break;

	case PW_SCOUT:
		clientNum = other->client->ps.clientNum;
		trap_GetUserinfo( clientNum, userinfo, sizeof(userinfo) );
		handicap = atof( Info_ValueForKey( userinfo, "handicap" ) );
		if( handicap<=0.0f || handicap>100.0f) {
			handicap = 100.0f;
		}
		other->client->pers.maxHealth = handicap;
		other->client->ps.stats[STAT_ARMOR] = 0;
		break;

	case PW_DOUBLER:
		clientNum = other->client->ps.clientNum;
		trap_GetUserinfo( clientNum, userinfo, sizeof(userinfo) );
		handicap = atof( Info_ValueForKey( userinfo, "handicap" ) );
		if( handicap<=0.0f || handicap>100.0f) {
			handicap = 100.0f;
		}
		other->client->pers.maxHealth = handicap;
		break;
	case PW_AMMOREGEN:
		clientNum = other->client->ps.clientNum;
		trap_GetUserinfo( clientNum, userinfo, sizeof(userinfo) );
		handicap = atof( Info_ValueForKey( userinfo, "handicap" ) );
		if( handicap<=0.0f || handicap>100.0f) {
			handicap = 100.0f;
		}
		other->client->pers.maxHealth = handicap;
		memset(other->client->ammoTimes, 0, sizeof(other->client->ammoTimes));
		break;
	default:
		clientNum = other->client->ps.clientNum;
		trap_GetUserinfo( clientNum, userinfo, sizeof(userinfo) );
		handicap = atof( Info_ValueForKey( userinfo, "handicap" ) );
		if( handicap<=0.0f || handicap>100.0f) {
			handicap = 100.0f;
		}
		other->client->pers.maxHealth = handicap;
		break;
	}

	return -1;
}

//======================================================================
#endif

int Pickup_Holdable( gentity_t *ent, gentity_t *other ) {

	other->client->ps.stats[STAT_HOLDABLE_ITEM] = ent->item - bg_itemlist;

	if( ent->item->giTag == HI_KAMIKAZE ) {
		other->client->ps.eFlags |= EF_KAMIKAZE;
	}

	return RESPAWN_HOLDABLE;
}


//======================================================================

/*void Add_Ammo (gentity_t *ent, int weapon, int count)
{
	ent->client->ps.ammo[weapon] += count;
	if ( ent->client->ps.ammo[weapon] > 200 ) {
		ent->client->ps.ammo[weapon] = 200;
	}
}*/
void Add_Ammo (gentity_t *ent, int weapon, int count)
{
	// CPM: Cap ammo for certain weapons
	int		quantity;
	
	switch (weapon)
	{
		case WP_SHOTGUN: quantity = cpm_SSGmaxammo; break;
		case WP_GRENADE_LAUNCHER: quantity = cpm_GLmaxammo; break;
		case WP_ROCKET_LAUNCHER: quantity = cpm_RLmaxammo; break;
		case WP_LIGHTNING: quantity = cpm_LGmaxammo; break;
		case WP_RAILGUN: quantity = cpm_RGmaxammo; break;
		default: quantity = 200;
	}

	ent->client->ps.ammo[weapon] += count;
	if ( ent->client->ps.ammo[weapon] > quantity ) {
		ent->client->ps.ammo[weapon] = quantity;
	}
	// !CPM
}

int Pickup_Ammo (gentity_t *ent, gentity_t *other)
{
	int		quantity;

	if ( ent->count ) {
		quantity = ent->count;
	} else {
		//quantity = ent->item->quantity;
		// CPM: Ammo counts from boxes
		switch (ent->item->giTag)
		{
			case WP_MACHINEGUN: quantity = cpm_MGbox; break;
			case WP_RAILGUN: quantity = cpm_RGbox; break;
			default: quantity = ent->item->quantity;
		}
		// !CPM
	}

	Add_Ammo (other, ent->item->giTag, quantity);

	//return RESPAWN_AMMO;
	return cpm_itemrespawnammo; // CPM
}

//======================================================================


int Pickup_Weapon (gentity_t *ent, gentity_t *other) {
	int		quantity;

	if ( ent->count < 0 ) {
		quantity = 0; // None for you, sir!
	} else {
		if ( ent->count ) {
			quantity = ent->count;
		} else {
			//quantity = ent->item->quantity;
			// CPM: Ammo counts from weapons
			switch (ent->item->giTag)
			{
				case WP_MACHINEGUN: quantity = cpm_MGweapon; break;
				default: quantity = ent->item->quantity;
			}
			// !CPM
		}

		// dropped items and teamplay weapons always have full ammo
		if ( ! (ent->flags & FL_DROPPED_ITEM) && g_gametype.integer != GT_TEAM ) {
			// respawning rules
			// drop the quantity if the already have over the minimum
			if ( other->client->ps.ammo[ ent->item->giTag ] < quantity ) {
				quantity = quantity - other->client->ps.ammo[ ent->item->giTag ];
			} else {
				quantity = 1;		// only add a single shot
			}
		}
	}

	// add the weapon
	other->client->ps.stats[STAT_WEAPONS] |= ( 1 << ent->item->giTag );

	Add_Ammo( other, ent->item->giTag, quantity );

	if (ent->item->giTag == WP_GRAPPLING_HOOK)
		other->client->ps.ammo[ent->item->giTag] = -1; // unlimited ammo

	// team deathmatch has slow weapon respawns
	if ( g_gametype.integer == GT_TEAM ) {
		return g_weaponTeamRespawn.integer;
	}

	return g_weaponRespawn.integer;
}


//======================================================================

// CPM: Megahealth respawn function
void CPM_HealthDecay(gentity_t *ent)
{
	if (!ent->activator) {
		ent->think = RespawnItem;
		ent->nextthink = level.time + CPM_MEGARESPAWNDELAY * 1000;
		return;
	}

	if (strcmp(ent->activator->classname,"player")
		|| ent->activator->client->ps.stats[STAT_HEALTH] <= 100) {
		ent->nextthink = level.time + CPM_MEGARESPAWNDELAY * 1000;
		ent->think = RespawnItem;
		return;
	}

	ent->nextthink = level.time + 1000;
}
// !CPM


int Pickup_Health (gentity_t *ent, gentity_t *other) {
	int			max;
	int			quantity;

	// small and mega healths will go over the max
#ifdef MISSIONPACK
	if( other->client && bg_itemlist[other->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_GUARD ) {
		max = other->client->ps.stats[STAT_MAX_HEALTH];
	}
	else
#endif
	if ( ent->item->quantity != 5 && ent->item->quantity != 100 ) {
		max = other->client->ps.stats[STAT_MAX_HEALTH];
	} else {
		max = other->client->ps.stats[STAT_MAX_HEALTH] * 2;
	}

	if ( ent->count ) {
		quantity = ent->count;
	} else {
		quantity = ent->item->quantity;
	}

	other->health += quantity;

	if (other->health > max ) {
		other->health = max;
	}
	other->client->ps.stats[STAT_HEALTH] = other->health;

	//if ( ent->item->giTag == 100 ) {		// mega health respawns slow
	//	return RESPAWN_MEGAHEALTH;
	//}
	// CPM: Megahealth system
	if ( ent->item->quantity == 100 ) {		// mega health respawns slow
		//if (cpm_megastyle)
		if ( g_pro_mode.integer ) {
			if (g_gametype.integer >= GT_TEAM)
				return RESPAWN_MEGAHEALTH;
			ent->think = CPM_HealthDecay;
			ent->activator = other;
			return 1; // nextthink will be one second
		}
		return RESPAWN_HEALTH; // due to a bug in the vq3 code, this must return health respawn
			// and not megahealth respawn (or else megahealth wont respawn once every 35 seconds
			// on maps like q3dm13)
	}
	// !CPM

	//return RESPAWN_HEALTH;
	return cpm_itemrespawnhealth; // CPM
}

//======================================================================

/*int Pickup_Armor( gentity_t *ent, gentity_t *other ) {
#ifdef MISSIONPACK
	int		upperBound;

	other->client->ps.stats[STAT_ARMOR] += ent->item->quantity;

	if( other->client && bg_itemlist[other->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_GUARD ) {
		upperBound = other->client->ps.stats[STAT_MAX_HEALTH];
	}
	else {
		upperBound = other->client->ps.stats[STAT_MAX_HEALTH] * 2;
	}

	if ( other->client->ps.stats[STAT_ARMOR] > upperBound ) {
		other->client->ps.stats[STAT_ARMOR] = upperBound;
	}
#else
	other->client->ps.stats[STAT_ARMOR] += ent->item->quantity;
	if ( other->client->ps.stats[STAT_ARMOR] > other->client->ps.stats[STAT_MAX_HEALTH] * 2 ) {
		other->client->ps.stats[STAT_ARMOR] = other->client->ps.stats[STAT_MAX_HEALTH] * 2;
	}
#endif

	return RESPAWN_ARMOR;
}*/
int Pickup_Armor( gentity_t *ent, gentity_t *other ) {
	// CPM: vq3 armor system
	if (!g_pro_mode.integer) {
	// !CPM
		other->client->ps.stats[STAT_ARMOR] += ent->item->quantity;
		if ( other->client->ps.stats[STAT_ARMOR] > other->client->ps.stats[STAT_MAX_HEALTH] * 2 ) {
			other->client->ps.stats[STAT_ARMOR] = other->client->ps.stats[STAT_MAX_HEALTH] * 2;
		}

		return RESPAWN_ARMOR;
	// CPM
	}
	
	// cpm armor system
	if ( ent->item->quantity == 100 ) { // RA
		other->client->ps.stats[STAT_ARMOR] = 200;
		other->client->ps.stats[STAT_ARMORTYPE] = 2;
	} else if ( ent->item->quantity == 50 ) { // YA
		if (other->client->ps.stats[STAT_ARMORTYPE] == 2) {
			other->client->ps.stats[STAT_ARMOR] *= CPM_RAMULTIPLIER;
		}

		other->client->ps.stats[STAT_ARMOR] += 100;
		if (other->client->ps.stats[STAT_ARMOR] > 150) {
			other->client->ps.stats[STAT_ARMOR] = 150;
		}
		other->client->ps.stats[STAT_ARMORTYPE] = 1;
	} else {// Shard
		//G_Printf("DBG: Pickup Shard\n");
		if (other->client->ps.stats[STAT_ARMOR] >= 0) {
			other->client->ps.stats[STAT_ARMORTYPE] = 1; // YA protection
		}
		other->client->ps.stats[STAT_ARMOR] += 2;
	}

	return RESPAWN_ARMOR; // 25 seconds
	// !CPM
}

//======================================================================

/*
===============
RespawnItem
===============
*/
void RespawnItem( gentity_t *ent ) {
	// randomly select from teamed entities
	if (ent->team) {
		gentity_t	*master;
		int	count;
		int choice;

		if ( !ent->teammaster ) {
			G_Error( "RespawnItem: bad teammaster");
		}
		master = ent->teammaster;

		for (count = 0, ent = master; ent; ent = ent->teamchain, count++)
			;

		choice = rand() % count;

		for (count = 0, ent = master; count < choice; ent = ent->teamchain, count++)
			;
	}

	ent->r.contents = CONTENTS_TRIGGER;
	ent->s.eFlags &= ~EF_NODRAW;
	ent->r.svFlags &= ~SVF_NOCLIENT;
	trap_LinkEntity (ent);

	//monkk: for flag sacrifice. This may not be reqd. w/ the way Revolution does manual
	//flag return.
	if( ent->item->giTag == PW_REDFLAG || ent->item->giTag == PW_BLUEFLAG || ent->item->giTag == PW_NEUTRALFLAG ) {
		ent->s.generic1 = 1;
	}

	if ( ent->item->giType == IT_POWERUP ) {
		// play powerup spawn sound to all clients
		gentity_t	*te;

		// if the powerup respawn sound should Not be global
		if (ent->speed) {
			te = G_TempEntity( ent->s.pos.trBase, EV_GENERAL_SOUND );
		}
		else {
			te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_SOUND );
		}
		te->s.eventParm = G_SoundIndex( "sound/items/poweruprespawn.wav" );
		te->r.svFlags |= SVF_BROADCAST;
	}

	if ( ent->item->giType == IT_HOLDABLE && ent->item->giTag == HI_KAMIKAZE ) {
		// play powerup spawn sound to all clients
		gentity_t	*te;

		// if the powerup respawn sound should Not be global
		if (ent->speed) {
			te = G_TempEntity( ent->s.pos.trBase, EV_GENERAL_SOUND );
		}
		else {
			te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_SOUND );
		}
		te->s.eventParm = G_SoundIndex( "sound/items/kamikazerespawn.wav" );
		te->r.svFlags |= SVF_BROADCAST;
	}

	// play the normal respawn sound only to nearby clients
	G_AddEvent( ent, EV_ITEM_RESPAWN, 0 );

	ent->nextthink = 0;
}


/*
===============
Touch_Item
===============
*/
void Touch_Item (gentity_t *ent, gentity_t *other, trace_t *trace) {
	int			respawn;
	qboolean	predict;
	int			counts[TEAM_NUM_TEAMS];

	counts[TEAM_BLUE] = TeamCount( -1, TEAM_BLUE );
	counts[TEAM_RED] = TeamCount( -1, TEAM_RED );

	/*if ( level.dbgflags && ent->item->giType == IT_TEAM ) {
		G_LogPrintf("DEBUG:Flags: Client %i is touching the %s. \n", other->client->ps.clientNum, ent->item->pickup_name);
		trap_SendServerCommand( other->client->ps.clientNum, va("print \"DEBUG:Flags: You're touching the %s. \n\"", ent->item->pickup_name) );
	}*/
	//G_Printf("DBG: Pickup item\n");											//DBG:Evo:This was commented out before fuxing with the tossflag
	if ( level.time <= other->client->naft[0] /*&& (ent->item->giType == IT_TEAM && ent->item->giTag == other->client->naft[1])*/ ) {
		//G_Printf("DBG: NAFT return\n");
		return;
	}

	//G_Printf("We're in Touch_Item\n");
	if ( (g_gamemode.integer == 1 || g_gamemode.integer == 3 || g_gamemode.integer == 5) && ent->item->giType != IT_TEAM ) {
		//G_Printf("instagib return\n");
		return;
	}

	if ( ent->s.eFlags & EF_NODRAW && ent->item->giType != IT_TEAM) {
		return;
	}

	if (!other->client)
		return;
	if (other->health < 1)
		return;		// dead people can't pickup

//freeze
	if ( g_gamemode.integer > 3 ) {
		if ( other->freezeState ) {
			return;
		}
	}
//freeze

	//G_Printf("Pre flag rules\n");
	//Check to see if it's a valid flag touch for the red team or the blue team.
	if (g_gametype.integer == GT_CTF && g_returnFlag.integer >= 0 && ent->item->giType == IT_TEAM) {
		//G_Printf("We're touching a flag that would not normally be touched\n");
		//G_Printf("We're in the returnflag touch rules");
		if (other->client->ps.persistant[PERS_TEAM] == TEAM_RED) {
		//	G_Printf("Red: We're touching a team flag or a enemy flag\n");
			//These are disallowed touches
			if (ent->item->giTag == PW_REDFLAG && ent->flags & FL_DROPPED_ITEM && g_returnFlag.integer == 1 && other->client->ps.powerups[PW_BLUEFLAG] ||
				ent->item->giTag == PW_BLUEFLAG && g_returnFlag.integer == 1 && other->client->ps.powerups[PW_REDFLAG] ||
				ent->item->giTag == PW_BLUEFLAG && ent->r.svFlags & SVF_NOCLIENT ||
				ent->item->giTag == PW_BLUEFLAG && (other->client->ps.powerups[PW_BLUEFLAG] || other->client->ps.powerups[PW_REDFLAG]) ||
				ent->item->giTag == PW_REDFLAG && !(ent->flags & FL_DROPPED_ITEM) && !(other->client->ps.powerups[PW_BLUEFLAG] || other->client->ps.powerups[PW_REDFLAG]) ||
				ent->item->giTag == PW_REDFLAG && ent->r.svFlags & SVF_NOCLIENT && other->client->ps.powerups[PW_BLUEFLAG] ||
				ent->item->giTag == PW_REDFLAG && ent->flags & FL_DROPPED_ITEM && g_returnFlag.integer == 2 && counts[TEAM_RED] >= 2 && other->client->ps.powerups[PW_BLUEFLAG]) {
		//			G_Printf("Red: return\n");
					//I had issues with it allowing these touches..
					//The below if should get rewritten to conform to this, probably, eventually, maybe.
					return;
			}	
		} else if (other->client->ps.persistant[PERS_TEAM] == TEAM_BLUE) {
		//	G_Printf("Blue: We're touching a team flag or a enemy flag\n");
			//These are disallowed touches
			if (ent->item->giTag == PW_BLUEFLAG && ent->flags & FL_DROPPED_ITEM && g_returnFlag.integer == 1 && other->client->ps.powerups[PW_REDFLAG] ||
				ent->item->giTag == PW_REDFLAG && g_returnFlag.integer == 1 && other->client->ps.powerups[PW_BLUEFLAG] ||
				ent->item->giTag == PW_REDFLAG && ent->r.svFlags & SVF_NOCLIENT ||
				ent->item->giTag == PW_REDFLAG && (other->client->ps.powerups[PW_BLUEFLAG] || other->client->ps.powerups[PW_REDFLAG]) ||
				ent->item->giTag == PW_BLUEFLAG && !(ent->flags & FL_DROPPED_ITEM) && !(other->client->ps.powerups[PW_BLUEFLAG] || other->client->ps.powerups[PW_REDFLAG]) ||
				ent->item->giTag == PW_BLUEFLAG && ent->r.svFlags & SVF_NOCLIENT && other->client->ps.powerups[PW_REDFLAG] ||
				ent->item->giTag == PW_BLUEFLAG && ent->flags & FL_DROPPED_ITEM && g_returnFlag.integer == 2 && counts[TEAM_BLUE] >= 2 && other->client->ps.powerups[PW_REDFLAG]) {
		//			G_Printf("Blue: return\n");
					return;
			}	
		}
	} else {
		//Do the normal touch_item stuff.
		if ( !BG_CanItemBeGrabbed( g_gametype.integer, &ent->s, &other->client->ps )  ) {
			//G_Printf("DBG: Not touchable\n");
			return;
		}
	}

	G_LogPrintf( "Item: %i %s\n", other->s.number, ent->item->classname );

	predict = other->client->pers.predictItemPickup;

	// call the item-specific pickup function
	switch( ent->item->giType ) {
	case IT_WEAPON:
		respawn = Pickup_Weapon(ent, other);
		level.stats_picked |= (1 << ((ent->item->giTag) - 1));
//		predict = qfalse;
		break;
	case IT_AMMO:
		respawn = Pickup_Ammo(ent, other);
//		predict = qfalse;
		break;
	case IT_ARMOR:
		respawn = Pickup_Armor(ent, other);
		break;
	case IT_HEALTH:
		respawn = Pickup_Health(ent, other);
		break;
	case IT_POWERUP:
		respawn = Pickup_Powerup(ent, other);
		predict = qfalse;
		break;
#ifdef MISSIONPACK
	case IT_PERSISTANT_POWERUP:
		respawn = Pickup_PersistantPowerup(ent, other);
		break;
#endif
	case IT_TEAM:
		//G_Printf("Pickup_Team was called\n");
		respawn = Pickup_Team(ent, other);
		break;
	case IT_HOLDABLE:
		respawn = Pickup_Holdable(ent, other);
		break;
	default:
		return;
	}

	if ( !respawn ) {
		return;
	}
	

	// play the normal pickup sound
	if (predict) {
		G_AddPredictableEvent( other, EV_ITEM_PICKUP, ent->s.modelindex );
	} else {
		G_AddEvent( other, EV_ITEM_PICKUP, ent->s.modelindex );
	}

	// powerup pickups are global broadcasts
	if ( ent->item->giType == IT_POWERUP || ent->item->giType == IT_TEAM) {
		// if we want the global sound to play
		if (!ent->speed) {
			gentity_t	*te;

			te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_ITEM_PICKUP );
			te->s.eventParm = ent->s.modelindex;
			te->r.svFlags |= SVF_BROADCAST;
		} else {
			gentity_t	*te;

			te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_ITEM_PICKUP );
			te->s.eventParm = ent->s.modelindex;
			// only send this temp entity to a single client
			te->r.svFlags |= SVF_SINGLECLIENT;
			te->r.singleClient = other->s.number;
		}
	}

	// fire item targets
	G_UseTargets (ent, other);

	// wait of -1 will not respawn
	if ( ent->wait == -1 ) {
		ent->r.svFlags |= SVF_NOCLIENT;
		ent->s.eFlags |= EF_NODRAW;
		ent->r.contents = 0;
		ent->unlinkAfterEvent = qtrue;
		return;
	}

	// non zero wait overrides respawn time
	//if ( ent->wait ) {
	if ( ent->wait && ent->think != CPM_HealthDecay) {	// CPM
		respawn = ent->wait;
	}

	// random can be used to vary the respawn time
	if ( ent->random ) {
		respawn += crandom() * ent->random;
		if ( respawn < 1 ) {
			respawn = 1;
		}
	}

	// dropped items will not respawn
	if ( ent->flags & FL_DROPPED_ITEM ) {
		ent->freeAfterEvent = qtrue;
	}

	// picked up items still stay around, they just don't
	// draw anything.  This allows respawnable items
	// to be placed on movers.
	ent->r.svFlags |= SVF_NOCLIENT;
	ent->s.eFlags |= EF_NODRAW;
	ent->r.contents = 0;

	// ZOID
	// A negative respawn times means to never respawn this item (but don't 
	// delete it).  This is used by items that are respawned by third party 
	// events such as ctf flags
	/*if ( respawn <= 0 ) {
		ent->nextthink = 0;
		ent->think = 0;
	} else {
		ent->nextthink = level.time + respawn * 1000;
		ent->think = RespawnItem;
	}*/
	if ( respawn <= 0 ) {
		ent->nextthink = 0;
		ent->think = 0;
	} else {
		ent->nextthink = level.time + respawn * 1000;
		if (ent->think != CPM_HealthDecay) ent->think = RespawnItem; // CPM
	}
	trap_LinkEntity( ent );
}


//======================================================================

/*
================
LaunchItem

Spawns an item and tosses it forward
================
*/
gentity_t *LaunchItem( gitem_t *item, vec3_t origin, vec3_t velocity ) {
	gentity_t	*dropped;

	dropped = G_Spawn();

	dropped->s.eType = ET_ITEM;
	dropped->s.modelindex = item - bg_itemlist;	// store item number in modelindex
	dropped->s.modelindex2 = 1; // This is non-zero is it's a dropped item

	dropped->classname = item->classname;
	dropped->item = item;
	VectorSet (dropped->r.mins, -ITEM_RADIUS, -ITEM_RADIUS, -ITEM_RADIUS);
	VectorSet (dropped->r.maxs, ITEM_RADIUS, ITEM_RADIUS, ITEM_RADIUS);
	dropped->r.contents = CONTENTS_TRIGGER;

	dropped->touch = Touch_Item;

	G_SetOrigin( dropped, origin );
	dropped->s.pos.trType = TR_GRAVITY;
	dropped->s.pos.trTime = level.time;
	VectorCopy( velocity, dropped->s.pos.trDelta );

	dropped->s.eFlags |= EF_BOUNCE_HALF;
#ifdef MISSIONPACK
	if ((g_gametype.integer == GT_CTF || g_gametype.integer == GT_1FCTF)			&& item->giType == IT_TEAM) { // Special case for CTF flags
#else
	if (g_gametype.integer == GT_CTF && item->giType == IT_TEAM) { // Special case for CTF flags
#endif
		dropped->think = Team_DroppedFlagThink;
		dropped->nextthink = level.time + 30000;
		Team_CheckDroppedItem( dropped );
	} else { // auto-remove after 30 seconds
		dropped->think = G_FreeEntity;
		dropped->nextthink = level.time + 30000;
	}

	dropped->flags = FL_DROPPED_ITEM;

	trap_LinkEntity (dropped);

	return dropped;
}

/*
================
Drop_Item

Spawns an item and tosses it forward
================
*/
gentity_t *Drop_Item( gentity_t *ent, gitem_t *item, float angle, qboolean tossflag ) {
	vec3_t	velocity;
	vec3_t	angles;
	
	VectorCopy( ent->s.apos.trBase, angles );
	angles[YAW] += angle;
	angles[PITCH] = 0;	// always forward

	AngleVectors( angles, velocity, NULL, NULL );
	VectorScale( velocity, 150, velocity );
	velocity[2] += 200 + crandom() * 50;
	if ( tossflag ) {
		if ( (ent->client->ps.velocity[0] < 300 && ent->client->ps.velocity[0] > -300) &&
			(ent->client->ps.velocity[1] < 300 && ent->client->ps.velocity[1] > -300) &&
			(ent->client->ps.velocity[2] < 300 && ent->client->ps.velocity[2] > -300) || !(trap_Cvar_VariableIntegerValue("new_flagtoss")) ) {
			velocity[2] += 200 + crandom() * 50;
		} else {
			//Scale the velocity down, otherwise we're grabbing it right away
			VectorScale(ent->client->ps.velocity, 1.2, velocity);
		}
	}
	
	return LaunchItem( item, ent->s.pos.trBase, velocity );

}


/*
================
Use_Item

Respawn the item
================
*/
void Use_Item( gentity_t *ent, gentity_t *other, gentity_t *activator ) {
	RespawnItem( ent );
}

//======================================================================

/*
================
FinishSpawningItem

Traces down to find where an item should rest, instead of letting them
free fall from their spawn points
================
*/
void FinishSpawningItem( gentity_t *ent ) {
	trace_t		tr;
	vec3_t		dest;

	VectorSet( ent->r.mins, -ITEM_RADIUS, -ITEM_RADIUS, -ITEM_RADIUS );
	VectorSet( ent->r.maxs, ITEM_RADIUS, ITEM_RADIUS, ITEM_RADIUS );

	ent->s.eType = ET_ITEM;
	ent->s.modelindex = ent->item - bg_itemlist;		// store item number in modelindex
	ent->s.modelindex2 = 0; // zero indicates this isn't a dropped item

	ent->r.contents = CONTENTS_TRIGGER;
	ent->touch = Touch_Item;
	// useing an item causes it to respawn
	ent->use = Use_Item;

	if ( ent->spawnflags & 1 ) {
		// suspended
		G_SetOrigin( ent, ent->s.origin );
	} else {
		// drop to floor
		VectorSet( dest, ent->s.origin[0], ent->s.origin[1], ent->s.origin[2] - 4096 );
		trap_Trace( &tr, ent->s.origin, ent->r.mins, ent->r.maxs, dest, ent->s.number, MASK_SOLID );
		if ( tr.startsolid ) {
			G_Printf ("FinishSpawningItem: %s startsolid at %s\n", ent->classname, vtos(ent->s.origin));
			G_FreeEntity( ent );
			return;
		}

		// allow to ride movers
		ent->s.groundEntityNum = tr.entityNum;

		G_SetOrigin( ent, tr.endpos );
	}

	// team slaves and targeted items aren't present at start
	if ( ( ent->flags & FL_TEAMSLAVE ) || ent->targetname ) {
		ent->s.eFlags |= EF_NODRAW;
		ent->r.contents = 0;
		return;
	}

	// powerups don't spawn in for a while
	//if ( ent->item->giType == IT_POWERUP && (g_gamemode.integer == 0 || g_gamemode.integer == 2)) {
	if ( ent->item->giType == IT_POWERUP && !cpm_startpowerups && (g_gamemode.integer == 0 || g_gamemode.integer == 2) ) { // CPM
		float	respawn;

		respawn = 45 + crandom() * 15;
		ent->s.eFlags |= EF_NODRAW;
		ent->r.contents = 0;
		ent->nextthink = level.time + respawn * 1000;
		ent->think = RespawnItem;
		return;
	}


	trap_LinkEntity (ent);
}


qboolean	itemRegistered[MAX_ITEMS];
//freeze
qboolean Registered( gitem_t *item ) {
	return ( item && itemRegistered[ item - bg_itemlist ] );
}
//freeze

/*
==================
G_CheckTeamItems
==================
*/
void G_CheckTeamItems( void ) {

	// Set up team stuff
	Team_InitGame();

	if( g_gametype.integer == GT_CTF ) {
		gitem_t	*item;

		// check for the two flags
		item = BG_FindItem( "Red Flag" );
		if ( !item || !itemRegistered[ item - bg_itemlist ] ) {
			G_Printf( S_COLOR_YELLOW "WARNING: No team_CTF_redflag in map" );
		}
		item = BG_FindItem( "Blue Flag" );
		if ( !item || !itemRegistered[ item - bg_itemlist ] ) {
			G_Printf( S_COLOR_YELLOW "WARNING: No team_CTF_blueflag in map" );
		}
	}
#ifdef MISSIONPACK
	if( g_gametype.integer == GT_1FCTF ) {
		gitem_t	*item;

		// check for all three flags
		item = BG_FindItem( "Red Flag" );
		if ( !item || !itemRegistered[ item - bg_itemlist ] ) {
			G_Printf( S_COLOR_YELLOW "WARNING: No team_CTF_redflag in map" );
		}
		item = BG_FindItem( "Blue Flag" );
		if ( !item || !itemRegistered[ item - bg_itemlist ] ) {
			G_Printf( S_COLOR_YELLOW "WARNING: No team_CTF_blueflag in map" );
		}
		item = BG_FindItem( "Neutral Flag" );
		if ( !item || !itemRegistered[ item - bg_itemlist ] ) {
			G_Printf( S_COLOR_YELLOW "WARNING: No team_CTF_neutralflag in map" );
		}
	}

	if( g_gametype.integer == GT_OBELISK ) {
		gentity_t	*ent;

		// check for the two obelisks
		ent = NULL;
		ent = G_Find( ent, FOFS(classname), "team_redobelisk" );
		if( !ent ) {
			G_Printf( S_COLOR_YELLOW "WARNING: No team_redobelisk in map" );
		}

		ent = NULL;
		ent = G_Find( ent, FOFS(classname), "team_blueobelisk" );
		if( !ent ) {
			G_Printf( S_COLOR_YELLOW "WARNING: No team_blueobelisk in map" );
		}
	}

	if( g_gametype.integer == GT_HARVESTER ) {
		gentity_t	*ent;

		// check for all three obelisks
		ent = NULL;
		ent = G_Find( ent, FOFS(classname), "team_redobelisk" );
		if( !ent ) {
			G_Printf( S_COLOR_YELLOW "WARNING: No team_redobelisk in map" );
		}

		ent = NULL;
		ent = G_Find( ent, FOFS(classname), "team_blueobelisk" );
		if( !ent ) {
			G_Printf( S_COLOR_YELLOW "WARNING: No team_blueobelisk in map" );
		}

		ent = NULL;
		ent = G_Find( ent, FOFS(classname), "team_neutralobelisk" );
		if( !ent ) {
			G_Printf( S_COLOR_YELLOW "WARNING: No team_neutralobelisk in map" );
		}
	}
#endif
}

/*
==============
ClearRegisteredItems
==============
*/
void ClearRegisteredItems( void ) {
	memset( itemRegistered, 0, sizeof( itemRegistered ) );

	// players always start with the base weapon
	RegisterItem( BG_FindItemForWeapon( WP_MACHINEGUN ) );
	RegisterItem( BG_FindItemForWeapon( WP_GAUNTLET ) );
	//if( weap_enableHook.integer ) {
		RegisterItem( BG_FindItemForWeapon( WP_GRAPPLING_HOOK ) );
	//}
#ifdef MISSIONPACK
	if( g_gametype.integer == GT_HARVESTER ) {
		RegisterItem( BG_FindItem( "Red Cube" ) );
		RegisterItem( BG_FindItem( "Blue Cube" ) );
	}
#endif
}

/*
===============
RegisterItem

The item will be added to the precache list
===============
*/
void RegisterItem( gitem_t *item ) {
	if ( !item ) {
		G_Error( "RegisterItem: NULL" );
	}
	itemRegistered[ item - bg_itemlist ] = qtrue;
}


/*
===============
SaveRegisteredItems

Write the needed items to a config string
so the client will know which ones to precache
===============
*/
void SaveRegisteredItems( void ) {
	char	string[MAX_ITEMS+1];
	int		i;
	int		count;

	count = 0;
	for ( i = 0 ; i < bg_numItems ; i++ ) {
		if ( itemRegistered[i] ) {
			count++;
			string[i] = '1';
		} else {
			string[i] = '0';
		}
	}
	string[ bg_numItems ] = 0;

	G_Printf( "%i items registered\n", count );
	trap_SetConfigstring(CS_ITEMS, string);
}

/*
============
G_ItemDisabled
============
*/
int G_ItemDisabled( gitem_t *item ) {

	char name[128];

	Com_sprintf(name, sizeof(name), "disable_%s", item->classname);
	return trap_Cvar_VariableIntegerValue( name );
}

/*
============
G_SpawnItem

Sets the clipping size and plants the object on the floor.

Items can't be immediately dropped to floor, because they might
be on an entity that hasn't spawned yet.
============
*/
void G_SpawnItem (gentity_t *ent, gitem_t *item) {
	G_SpawnFloat( "random", "0", &ent->random );
	G_SpawnFloat( "wait", "0", &ent->wait );

	RegisterItem( item );
	if ( G_ItemDisabled(item) )
		return;

	//Monkk: sarcifice. Added this because some decisions on whether to sacrifice
	//are based on whether the flag is at the base position or not, and in
	//reactance, this is how we do it. This can be removed if all references in
	//the sacrifice that use ent->s.generic1 as a guide go too!
	//TODO: Check this for removal!
	if( item->giType == IT_TEAM ) {
	//	G_LogPrintf("DEBUG: Flag: Should spawn a %s \n", item->pickup_name);
		ent->s.generic1= 1;
	}
	ent->item = item;
	// some movers spawn on the second frame, so delay item
	// spawns until the third frame so they can ride trains
	ent->nextthink = level.time + FRAMETIME * 2;
	ent->think = FinishSpawningItem;

	if ( ((g_gamemode.integer == 1 || g_gamemode.integer == 3 || g_gamemode.integer == 5) && item->giType != IT_TEAM)/* || (g_gamemode.integer == 2 && (ent->item->giType != IT_TEAM || ent->item->giType != IT_WEAPON || ent->item->giType != IT_POWERUP) )*/ ) {
	//	ent->r.svFlags |= SVF_NOCLIENT;
		ent->s.eFlags |= EF_NODRAW;
	//	ent->r.contents = 0;
	} else { /** Probablay no longer need this **/
		/*if( item->giType == IT_TEAM ) {
			G_LogPrintf("DEBUG: Flag: We're really spawning a %s \n", item->pickup_name);
		}*/
		if ( item->giType == IT_WEAPON || item->giType == IT_AMMO ) {
			if ( (!Q_stricmp( item->classname, "ammo_bullets" ) || item->giTag == WP_MACHINEGUN) && !(weap_allowed.integer & 2) ) {
				ent->r.svFlags |= SVF_NOCLIENT;
				ent->s.eFlags |= EF_NODRAW;
			} else if ( (!Q_stricmp( item->classname, "ammo_shells" ) || item->giTag == WP_SHOTGUN) && !(weap_allowed.integer & 4) ) {
				ent->r.svFlags |= SVF_NOCLIENT;
				ent->s.eFlags |= EF_NODRAW;
			} else if ( (!Q_stricmp( item->classname, "ammo_grenades" ) || item->giTag == WP_GRENADE_LAUNCHER) && !(weap_allowed.integer & 8) ) {
				ent->r.svFlags |= SVF_NOCLIENT;
				ent->s.eFlags |= EF_NODRAW;
			} else if ( (!Q_stricmp( item->classname, "ammo_rockets" ) || item->giTag == WP_ROCKET_LAUNCHER) && !(weap_allowed.integer & 16) ) {
				ent->r.svFlags |= SVF_NOCLIENT;
				ent->s.eFlags |= EF_NODRAW;
			} else if ( (!Q_stricmp( item->classname, "ammo_lightning" ) || item->giTag == WP_LIGHTNING) && !(weap_allowed.integer & 32) ) {
				ent->r.svFlags |= SVF_NOCLIENT;
				ent->s.eFlags |= EF_NODRAW;
			} else if ( (!Q_stricmp( item->classname, "ammo_slugs" ) || item->giTag == WP_RAILGUN) && !(weap_allowed.integer & 64) ) {
				ent->r.svFlags |= SVF_NOCLIENT;
				ent->s.eFlags |= EF_NODRAW;
			} else if ( (!Q_stricmp( item->classname, "ammo_cells" ) || item->giTag == WP_PLASMAGUN) && !(weap_allowed.integer & 128) ) {
				ent->r.svFlags |= SVF_NOCLIENT;
				ent->s.eFlags |= EF_NODRAW;
			} else if ( (!Q_stricmp( item->classname, "ammo_bfg" ) || item->giTag == WP_BFG) && !(weap_allowed.integer & 256) ) {
				ent->r.svFlags |= SVF_NOCLIENT;
				ent->s.eFlags |= EF_NODRAW;
			}/** Probablay no longer need this **/
		}

	ent->physicsBounce = 0.50;		// items are bouncy

	if ( item->giType == IT_POWERUP && g_gamemode.integer == 0 ) {
		G_SoundIndex( "sound/items/poweruprespawn.wav" );
		G_SpawnFloat( "noglobalsound", "0", &ent->speed);
	}

#ifdef MISSIONPACK
	if ( item->giType == IT_PERSISTANT_POWERUP ) {
		ent->s.generic1 = ent->spawnflags;
	}
#endif
	}
}


/*
================
G_BounceItem

================
*/
void G_BounceItem( gentity_t *ent, trace_t *trace ) {
	vec3_t	velocity;
	float	dot;
	int		hitTime;

	// reflect the velocity on the trace plane
	hitTime = level.previousTime + ( level.time - level.previousTime ) * trace->fraction;
	BG_EvaluateTrajectoryDelta( &ent->s.pos, hitTime, velocity );
	dot = DotProduct( velocity, trace->plane.normal );
	VectorMA( velocity, -2*dot, trace->plane.normal, ent->s.pos.trDelta );

	// cut the velocity to keep from bouncing forever
	VectorScale( ent->s.pos.trDelta, ent->physicsBounce, ent->s.pos.trDelta );

	// check for stop
	if ( trace->plane.normal[2] > 0 && ent->s.pos.trDelta[2] < 40 ) {
		trace->endpos[2] += 1.0;	// make sure it is off ground
		SnapVector( trace->endpos );
		G_SetOrigin( ent, trace->endpos );
		ent->s.groundEntityNum = trace->entityNum;
//freeze
		if ( g_gamemode.integer > 3 && ent->pain_debounce_time < level.time - 700 ) {
			ent->pain_debounce_time = level.time;
			G_AddEvent( ent, EV_FALL_SHORT, 0 );
		}
//freeze
		return;
	}

	VectorAdd( ent->r.currentOrigin, trace->plane.normal, ent->r.currentOrigin);
	VectorCopy( ent->r.currentOrigin, ent->s.pos.trBase );
	ent->s.pos.trTime = level.time;
}


/*
================
G_RunItem

================
*/
void G_RunItem( gentity_t *ent ) {
	vec3_t		origin;
	trace_t		tr;
	int			contents;
	int			mask;

	//G_Printf("G_RunItem:\n");

	// if groundentity has been set to -1, it may have been pushed off an edge
	if ( ent->s.groundEntityNum == -1 ) {
		//G_Printf("ent->s.groundEntityNum == -1\n");
		if ( ent->s.pos.trType != TR_GRAVITY ) {
		//	G_Printf("ent->s.pos.trType != TR_GRAVITY\n");
			ent->s.pos.trType = TR_GRAVITY;
			ent->s.pos.trTime = level.time;
		}
	}

	if ( ent->s.pos.trType == TR_STATIONARY ) {
		//G_Printf("TR_STATIONARY: G_RunThink( ent );\n");
		// check think function
		G_RunThink( ent );
		return;
	}

	// get current position
	BG_EvaluateTrajectory( &ent->s.pos, level.time, origin );

	// trace a line from the previous position to the current position
	if ( ent->clipmask ) {
		mask = ent->clipmask;
	} else {
		mask = MASK_PLAYERSOLID & ~CONTENTS_BODY;//MASK_SOLID;
	}
//freeze
	if ( g_gamemode.integer > 3 && is_body_freeze( ent ) )
		trap_Trace( &tr, ent->r.currentOrigin, ent->r.mins, ent->r.maxs, origin, ent->s.number, mask );
	else
//freeze
	trap_Trace( &tr, ent->r.currentOrigin, ent->r.mins, ent->r.maxs, origin, 
		ent->r.ownerNum, mask );

	VectorCopy( tr.endpos, ent->r.currentOrigin );

	if ( tr.startsolid ) {
		tr.fraction = 0;
	}
	
	//G_Printf("trap_LinkEntity( ent );\n");
	trap_LinkEntity( ent );	// FIXME: avoid this for stationary?

	// check think function
	//G_Printf("G_RunThink( ent );\n");
	G_RunThink( ent );

	if ( tr.fraction == 1 ) {
		return;
	}

	// if it is in a nodrop volume, remove it
	contents = trap_PointContents( ent->r.currentOrigin, -1 );

	//Monkk: flag sacrifice
	//TODO: Evo check this for freeze...
	//if ( contents & CONTENTS_NODROP ) {
	if((contents & (CONTENTS_NODROP | CONTENTS_LAVA | CONTENTS_SLIME) ) || (ent->watertype & (CONTENTS_LAVA | CONTENTS_SLIME)) ) {
		if (g_flagSacrifice.integer != 0 && ent->item && (ent->item->giType == IT_TEAM) && (ent->item->giTag) && (ent->item->giTag == PW_REDFLAG || ent->item->giTag == PW_BLUEFLAG || ent->item->giTag == PW_NEUTRALFLAG) ) {
			SpawnFlagAtLastKnownGood(ent);
		} else {
			if(ent->item && ent->item->giType == IT_TEAM) {
				Team_FreeEntity( ent );
			} else {
//freeze
				if ( g_gamemode.integer > 3 ) {
					if ( is_body( ent ) ) {
						if ( level.time - ent->timestamp > 10000 ) {
							Body_free( ent );
						}
						return;
					}
				}
//freeze
				G_FreeEntity( ent );
			}
		}
		return;
	}

	G_BounceItem( ent, &tr );
}

