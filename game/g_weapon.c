// Copyright (C) 1999-2000 Id Software, Inc.
//
// g_weapon.c 
// perform the server side effects of a weapon firing

#include "g_local.h"
#include "bg_promode.h"

static	float	s_quadFactor;
static	vec3_t	forward, right, up;
static	vec3_t	muzzle;

extern void G_ExplodeMissile( gentity_t *ent );
int ComputeNewTimeShift(gentity_t *ent, int range, int clientHitHum);

#define NUM_NAILSHOTS 15

/*
================
G_BounceProjectile
================
*/
void G_BounceProjectile( vec3_t start, vec3_t impact, vec3_t dir, vec3_t endout ) {
	vec3_t v, newv;
	float dot;

	VectorSubtract( impact, start, v );
	dot = DotProduct( v, dir );
	VectorMA( v, -2*dot, dir, newv );

	VectorNormalize(newv);
	VectorMA(impact, 8192, newv, endout);
}


/*
======================================================================

GAUNTLET

======================================================================
*/

void Weapon_Gauntlet( gentity_t *ent ) {

}

/*
===============
CheckGauntletAttack
===============
*/
qboolean CheckGauntletAttack( gentity_t *ent ) {
	trace_t		tr;
	vec3_t		end;
	gentity_t	*tent;
	gentity_t	*traceEnt;
	int			damage = gameSettings.hitscans[GS_GAUNTLET][GS_DAMAGE];
	// mod code start
	int			hitNothing = 0;
	int			timeshift = 0;
	int			clientHitNum = 0;
	int			shifted = 0;

	++ent->client->pers.stats_shots[WP_GAUNTLET];

		//unlagged - backward reconciliation #2
	// put them back
		//Do this for railjumping?
	G_UndoTimeShiftFor( ent );
	//unlagged - backward reconciliation #2
	// set aiming directions
	AngleVectors (ent->client->ps.viewangles, forward, right, up);

	CalcMuzzlePoint ( ent, forward, right, up, muzzle );

	VectorMA (muzzle, gameSettings.hitscans[GS_GAUNTLET][GS_RANGE], forward, end);
	//VectorMA (muzzle, 32, forward, end);

	if (ent->client->frameAimType >= 2 ) {
		clientHitNum = GetClientTarget(ent);
		timeshift = ComputeNewTimeShift(ent, gameSettings.hitscans[GS_LIGHTNING][GS_RANGE], clientHitNum);

		if ( timeshift == 0 ) {
			hitNothing = 1;
		}

		if (timeshift == -1 || timeshift == 1) {
			if( LogAccuracyHit( &g_entities[clientHitNum], ent ) ) {			
				ent->client->accuracy_hits++;
			}
			G_Damage (&g_entities[clientHitNum], ent, ent, forward, end, damage, 0, MOD_LIGHTNING);
			return qtrue;
		}
	}

	trap_Trace (&tr, muzzle, NULL, NULL, end, ent->s.number, MASK_SHOT);
	if ( tr.surfaceFlags & SURF_NOIMPACT ) {
		return qfalse;
	}

	traceEnt = &g_entities[ tr.entityNum ];

	// send blood impact
	if ( traceEnt->takedamage && traceEnt->client ) {
		tent = G_TempEntity( tr.endpos, EV_MISSILE_HIT );
		tent->s.otherEntityNum = traceEnt->s.number;
		tent->s.eventParm = DirToByte( tr.plane.normal );
		tent->s.weapon = ent->s.weapon;
	}

	if ( !traceEnt->takedamage) {
		return qfalse;
	}
	//unlagged - backward reconciliation #2
	// put them back
		//Do this for railjumping?
	G_UndoTimeShiftFor( ent );
	//unlagged - backward reconciliation #2

	if (ent->client->ps.powerups[PW_QUAD] ) {
		G_AddEvent( ent, EV_POWERUP_QUAD, 0 );
		s_quadFactor = g_quadfactor.value;
	} else {
		s_quadFactor = 1;
	}
#ifdef MISSIONPACK
	if( ent->client->persistantPowerup && ent->client->persistantPowerup->item && ent->client->persistantPowerup->item->giTag == PW_DOUBLER ) {
		s_quadFactor *= 2;
	}
#endif


	damage = gameSettings.hitscans[GS_GAUNTLET][GS_DAMAGE] * s_quadFactor;
	//if ( traceEnt->client ) {
		++ent->client->pers.stats_hits[WP_GAUNTLET];
		ent->client->pers.stats_damage[WP_GAUNTLET] += damage;
		ent->client->pers.stats_totaldamage += damage;
	//}
	G_Damage( traceEnt, ent, ent, forward, tr.endpos,
		damage, 0, MOD_GAUNTLET );

	return qtrue;
}

/*
===============
CheckGauntletJump
===============
*/
qboolean CheckGauntletJump( gentity_t *ent ) {
	vec3_t		end;
	gentity_t	*traceEnt;
	vec3_t		v;
	float		dist, points;
	int			j;
	trace_t		trace;
	vec3_t		dir;//XX rj
	memcpy( dir, forward, sizeof(dir) );


	if ( !g_gauntletJumping.integer ) {
		return qfalse;
	}

	++ent->client->pers.stats_shots[WP_GAUNTLET];

	AngleVectors (ent->client->ps.viewangles, forward, right, up);
	CalcMuzzlePoint ( ent, forward, right, up, muzzle );
	VectorMA (muzzle, 8192, forward, end);
	trap_Trace (&trace, muzzle, NULL, NULL, end, ent->s.number, MASK_SHOT);

	traceEnt = &g_entities[ trace.entityNum ];

	if ( trace.entityNum < 64 ) { //We hit a client in the trace, not valid.
		return qfalse;
	}

	if ( g_gauntletjumpRadius.integer >= 1 && g_gauntletJumping.integer > 0 ) {
		for ( j = 0 ; j < 3 ; j++ ) {
			if ( trace.endpos[j] < ent->r.absmin[j] ) {
				v[j] = ent->r.absmin[j] - trace.endpos[j];
			} else if ( trace.endpos[j] > ent->r.absmax[j] ) {
				v[j] = trace.endpos[j] - ent->r.absmax[j];
			} else {
				v[j] = 0;
			}
		}

		dist = VectorLength( v );

		g_StaticKnockback.integer?(points = g_gauntletKnockback.integer):(points = g_gauntletKnockback.integer * ( 1.0 - dist / g_gauntletjumpRadius.integer ));
		if ( dist <= g_gauntletjumpRadius.integer ) {
			if ( g_gauntletJumping.integer == 2  ) {
				//Monkk's railjumping code
					vec3_t	kvel, inverseRailPath;
					float	mass;

					mass = 200;

					VectorCopy(forward, inverseRailPath);
					VectorInverse(inverseRailPath);
					VectorScale ( inverseRailPath, g_knockback.value * (points - 1) / mass, kvel);//Subract 1 for Quad's IU1.2 "feel"
					VectorAdd (ent->client->ps.velocity, kvel, ent->client->ps.velocity);

					if ( !ent->client->ps.pm_time ) {
						int		t;
						t = (points - 1) * 2;//Subract 1 for Quad's IU1.2 "feel"

						if ( t < 50 ) {
							t = 50;
						}
						if ( t > 200 ) {
							t = 200;
						}
						ent->client->ps.pm_time = t;
						ent->client->ps.pm_flags |= PMF_TIME_KNOCKBACK;
					}
					return qtrue;
			} else if ( g_gauntletJumping.integer == 3 || g_gauntletJumping.integer == 4 ) {//XoneXfer
				gentity_t	*bolt;//XX rj
				
				/* RailJump style 4 is possibly closer to IU than anything... */
				

				bolt = G_Spawn();
				bolt->classname = "rocket";
				bolt->nextthink = level.time + 2000;
				//bolt->nextthink = level.time;//Think now <-- Evo did it.
				bolt->think = G_ExplodeMissile;
				
				
				bolt->s.eType = ET_MISSILE;
				bolt->r.svFlags = SVF_USE_CURRENT_ORIGIN;
				bolt->r.svFlags = SVF_NOCLIENT;
				bolt->s.eFlags |= EF_NODRAW ;
				bolt->s.weapon = WP_ROCKET_LAUNCHER;
				bolt->r.ownerNum = ent->s.number;
				bolt->parent = ent;
				bolt->damage = g_gauntletKnockback.integer;
				bolt->splashDamage = g_gauntletKnockback.integer;
				bolt->splashRadius = g_gauntletjumpRadius.integer;//was 120
				bolt->methodOfDeath = MOD_XX_RAILJUMP;
				bolt->splashMethodOfDeath = MOD_XX_RAILJUMP;
				bolt->clipmask = MASK_SHOT;
				bolt->target_ent = NULL;
				
				bolt->s.pos.trType = TR_LINEAR;
				//bolt->s.pos.trTime = level.time - 50;		// move a bit on the very first frame
				VectorCopy( muzzle, bolt->s.pos.trBase );
				VectorScale( dir, (g_RailJumping.integer == 3 ? (900) : (50000)), bolt->s.pos.trDelta );
				SnapVector( bolt->s.pos.trDelta );			// save net bandwidth
				VectorCopy (muzzle, bolt->r.currentOrigin);
				
				VectorSet(bolt->r.mins, 0, 0, 0);
				VectorCopy(bolt->r.mins, bolt->r.absmin);
				VectorSet(bolt->r.maxs, 0, 0, 0);
				VectorCopy(bolt->r.maxs, bolt->r.absmax);
				return qtrue;
			} else {//Revolution
				vec3_t	kvel;
				float	mass;
				mass = 200;

				VectorSubtract (ent->r.currentOrigin, muzzle, end);
				// push the center of mass higher than the origin so players
				// get knocked into the air more
				end[2] += 26;

				VectorNormalize(end);
				VectorScale ( end, g_knockback.value * points / mass, kvel);
				VectorAdd (ent->client->ps.velocity, kvel, ent->client->ps.velocity);

				if ( !ent->client->ps.pm_time ) {
					int		t;
					t = points * 2;

					if ( t < 50 ) {
						t = 50;
					}
					if ( t > 200 ) {
						t = 200;
					}
					ent->client->ps.pm_time = t;
					ent->client->ps.pm_flags |= PMF_TIME_KNOCKBACK;
				}
				return qtrue;
			}
		}
	}

	return qfalse;
}


/*
======================================================================

MACHINEGUN

======================================================================
*/

/*
======================
SnapVectorTowards

Round a vector to integers for more efficient network
transmission, but make sure that it rounds towards a given point
rather than blindly truncating.  This prevents it from truncating 
into a wall.
======================
*/
//unlagged - attack prediction #3
// moved to q_shared.c
/*
void SnapVectorTowards( vec3_t v, vec3_t to ) {
	int		i;

	for ( i = 0 ; i < 3 ; i++ ) {
		if ( to[i] <= v[i] ) {
			v[i] = (int)v[i];
		} else {
			v[i] = (int)v[i] + 1;
		}
	}
}
*/
//unlagged - attack prediction #3

#ifdef MISSIONPACK
#define CHAINGUN_SPREAD		600
#endif
#define MACHINEGUN_SPREAD	200
#define	MACHINEGUN_DAMAGE	7
#define	MACHINEGUN_TEAM_DAMAGE	5		// wimpier MG in teamplay

void Bullet_Fire (gentity_t *ent, float spread, int damage ) {
	trace_t		tr;
	vec3_t		end;
#ifdef MISSIONPACK
	vec3_t		impactpoint, bouncedir;
#endif
	float		r;
	float		u;
	gentity_t	*tent;
	gentity_t	*traceEnt;
	int			i, passent;
//unlagged - attack prediction #2
	// we have to use something now that the client knows in advance
	int			seed = ent->client->attackTime % 256;
//unlagged - attack prediction #2
	int			unlinked = 0;
	int			timeshiftResult;
//	gentity_t	*unlinkedEntities[10];
	int			clientEnt;
	int			hitNothing = 0;
	int			shifted = 0;

    //NT - shift other clients back to the client's idea of the server
    // time to compensate for lag
	++ent->client->pers.stats_shots[WP_MACHINEGUN];

	damage *= s_quadFactor;



//unlagged - attack prediction #2
	// this has to match what's on the client
/*
	r = random() * M_PI * 2.0f;
	u = sin(r) * crandom() * spread * 16;
	r = cos(r) * crandom() * spread * 16;
*/
	r = Q_random(&seed) * M_PI * 2.0f;
	u = sin(r) * Q_crandom(&seed) * spread * 16;
	r = cos(r) * Q_crandom(&seed) * spread * 16;
//unlagged - attack prediction #2
	VectorMA (muzzle, 8192*16, forward, end);
	VectorMA (end, r, right, end);
	VectorMA (end, u, up, end);

	 if (ent->client->frameAimType >= 2) {
			clientEnt = GetClientTarget(ent);
		timeshiftResult = ComputeNewTimeShift(ent, 8192*16, clientEnt);

		if (timeshiftResult == 0) {
			hitNothing = 1;
		}

		if (timeshiftResult == -1) {
			traceEnt = &g_entities[clientEnt];
			if ( traceEnt->takedamage /*&& G_AllowEntityInteraction(ent, traceEnt)*/) {
				if (traceEnt->client) {
					tent = G_TempEntity( tr.endpos, EV_BULLET_HIT_FLESH );
					tent->s.eventParm = traceEnt->s.number;
					tent->s.clientNum = ent->s.number;
					tent->s.otherEntityNum = ent->s.number;

					if (ent && ent->client) {
						tent->r.svFlags |= SVF_CLIENTMASK;
						tent->r.singleClient = GetClientMask(ent->client->sess.sessionTeam);
					}

					if( LogAccuracyHit( traceEnt, ent ) ) {
						ent->client->accuracy_hits++;
					}
				}

				G_Damage( traceEnt, ent, ent, forward, tr.endpos,
					damage, 0, MOD_MACHINEGUN);
			}
		}
	}


	passent = ent->s.number;
	for (i = 0; i < 10; i++) {

//unlagged - backward reconciliation #2
		// backward-reconcile the other clients
		G_DoTimeShiftFor( ent );
//unlagged - backward reconciliation #2

		trap_Trace (&tr, muzzle, NULL, NULL, end, passent, MASK_SHOT);

//unlagged - backward reconciliation #2
		// put them back
		G_UndoTimeShiftFor( ent );
//unlagged - backward reconciliation #2

		if ( tr.surfaceFlags & SURF_NOIMPACT ) {
			return;
		}

		traceEnt = &g_entities[ tr.entityNum ];

		// snap the endpos to integers, but nudged towards the line
		SnapVectorTowards( tr.endpos, muzzle );

		// send bullet impact
		if ( traceEnt->takedamage && traceEnt->client ) {
			tent = G_TempEntity( tr.endpos, EV_BULLET_HIT_FLESH );
			tent->s.eventParm = traceEnt->s.number;
//unlagged - attack prediction #2
			// we need the client number to determine whether or not to
			// suppress this event
			tent->s.clientNum = ent->s.clientNum;
//unlagged - attack prediction #2
			if( LogAccuracyHit( traceEnt, ent ) ) {
				ent->client->accuracy_hits++;
			}
//freeze
		} else if ( g_gamemode.integer > 3 && is_body( traceEnt ) ) {
			tent = G_TempEntity( tr.endpos, EV_BULLET_HIT_FLESH );
			tent->s.eventParm = traceEnt->s.number;
//freeze
		} else {
			tent = G_TempEntity( tr.endpos, EV_BULLET_HIT_WALL );
			tent->s.eventParm = DirToByte( tr.plane.normal );
//unlagged - attack prediction #2
			// we need the client number to determine whether or not to
			// suppress this event
			tent->s.clientNum = ent->s.clientNum;
//unlagged - attack prediction #2
		}
		tent->s.otherEntityNum = ent->s.number;

		if ( traceEnt->takedamage) {
#ifdef MISSIONPACK
			if ( traceEnt->client && traceEnt->client->invulnerabilityTime > level.time ) {
				if (G_InvulnerabilityEffect( traceEnt, forward, tr.endpos, impactpoint, bouncedir )) {
					G_BounceProjectile( muzzle, impactpoint, bouncedir, end );
					VectorCopy( impactpoint, muzzle );
					// the player can hit him/herself with the bounced rail
					passent = ENTITYNUM_NONE;
				}
				else {
					VectorCopy( tr.endpos, muzzle );
					passent = traceEnt->s.number;
				}
				continue;
			}
			else {
#endif
				if ( traceEnt->client ) {
					++ent->client->pers.stats_hits[WP_MACHINEGUN];
					ent->client->pers.stats_damage[WP_MACHINEGUN] += damage;
					ent->client->pers.stats_totaldamage += damage;
				}
				G_Damage( traceEnt, ent, ent, forward, tr.endpos,
					damage, 0, MOD_MACHINEGUN);
#ifdef MISSIONPACK
			}
#endif
		}
		break;
	}
}


/*
======================================================================

BFG

======================================================================
*/

void BFG_Fire ( gentity_t *ent ) {
	gentity_t	*m;

	++ent->client->pers.stats_shots[WP_BFG];

	m = fire_bfg (ent, muzzle, forward);
	m->damage *= s_quadFactor;
	m->splashDamage *= s_quadFactor;

//	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
}


/*
======================================================================

SHOTGUN

======================================================================
*/

// DEFAULT_SHOTGUN_SPREAD and DEFAULT_SHOTGUN_COUNT	are in bg_public.h, because
// client predicts same spreads
#define	DEFAULT_SHOTGUN_DAMAGE	10

qboolean ShotgunPellet( vec3_t start, vec3_t end, gentity_t *ent ) {
	trace_t		tr;
	int			damage, i, passent;
	gentity_t	*traceEnt;
#ifdef MISSIONPACK
	vec3_t		impactpoint, bouncedir;
#endif
	vec3_t		tr_start, tr_end;
	int			unlinked = 0;
//	gentity_t	*unlinkedEntities[10];

	/* Ideally we should make some messy looking if's so we don't need these variables */
	//WP_DEFAULTS
	//int	damage = cpm_SSGdmg;

	passent = ent->s.number;
	VectorCopy( start, tr_start );
	VectorCopy( end, tr_end );
	for (i = 0; i < 10; i++) {
		trap_Trace (&tr, tr_start, NULL, NULL, tr_end, 128, MASK_SHOT);
		traceEnt = &g_entities[ tr.entityNum ];

		// send bullet impact
		if (  tr.surfaceFlags & SURF_NOIMPACT ) {
			return qfalse;
		}

		if ( traceEnt->takedamage) {
			//damage = DEFAULT_SHOTGUN_DAMAGE * s_quadFactor;
			damage = gameSettings.hitscans[GS_SHOTGUN][GS_DAMAGE] * s_quadFactor; // CPM
#ifdef MISSIONPACK
			if ( traceEnt->client && traceEnt->client->invulnerabilityTime > level.time ) {
				if (G_InvulnerabilityEffect( traceEnt, forward, tr.endpos, impactpoint, bouncedir )) {
					G_BounceProjectile( tr_start, impactpoint, bouncedir, tr_end );
					VectorCopy( impactpoint, tr_start );
					// the player can hit him/herself with the bounced rail
					passent = ENTITYNUM_NONE;
				}
				else {
					VectorCopy( tr.endpos, tr_start );
					passent = traceEnt->s.number;
				}
				continue;
			}
			else {
				G_Damage( traceEnt, ent, ent, forward, tr.endpos,
					damage, 0, MOD_SHOTGUN);
				if( LogAccuracyHit( traceEnt, ent ) ) {
					return qtrue;
				}
			}
#else		
			//if ( traceEnt->client ) {
			//	ent->client->pers.stats_damage[WP_SHOTGUN] += damage;
			//	ent->client->pers.stats_totaldamage += damage;
			//}
			G_Damage( traceEnt, ent, ent, forward, tr.endpos,	damage, 0, MOD_SHOTGUN);
				if( LogAccuracyHit( traceEnt, ent ) ) {
			return qtrue;
		}
#endif
		}
		return qfalse;
	}
	return qfalse;
}

// this should match CG_ShotgunPattern
void ShotgunPattern( vec3_t origin, vec3_t origin2, int seed, gentity_t *ent ) {
	int			i;
	float		r, u;
	vec3_t		end;
	vec3_t		forward, right, up;
	int			oldScore;
	qboolean	hitClient = qfalse;

//unlagged - attack prediction #2
	// use this for testing
	//Com_Printf( "Server seed: %d\n", seed );
//unlagged - attack prediction #2

	// mod code start

	int	shifted = 0;

	// mod code end

	// derive the right and up vectors from the forward vector, because
	// the client won't have any other information
	VectorNormalize2( origin2, forward );
	PerpendicularVector( right, forward );
	CrossProduct( forward, right, up );

	oldScore = ent->client->ps.persistant[PERS_SCORE];

	// mod code start

	
//unlagged - backward reconciliation #2
	// backward-reconcile the other clients
	G_DoTimeShiftFor( ent );
//unlagged - backward reconciliation #2



    //NT - shift other clients back to the client's idea of the server
    // time to compensate for lag
/*
	if ( g_delagHitscan.integer && ent->client && ent->client->frameAimType != 0 && 
        !(ent->r.svFlags & SVF_BOT) ) {
        G_TimeShiftAllClients( GetClientServerTime(ent), ent );
		shifted = 1;
    }
*/
	// mod code end

	// generate the "random" spread pattern
	for ( i = 0 ; i < DEFAULT_SHOTGUN_COUNT ; i++ ) {
	//for ( i = 0 ; i < cpm_SSGcount ; i++ ) { // CPM
		r = Q_crandom( &seed ) * DEFAULT_SHOTGUN_SPREAD * 16;
		u = Q_crandom( &seed ) * DEFAULT_SHOTGUN_SPREAD * 16;
	//	r = Q_crandom( &seed ) * cpm_SSGspread;  // CPM
	//	u = Q_crandom( &seed ) * cpm_SSGspread;  // CPM
		VectorMA( origin, 8192 * 16, forward, end);
		VectorMA (end, r, right, end);
		VectorMA (end, u, up, end);
		++ent->client->pers.stats_shots[WP_SHOTGUN];
		if( ShotgunPellet( origin, end, ent ) && !hitClient ) {
			hitClient = qtrue;
			if ( ent->client ) {
				++ent->client->pers.stats_hits[WP_SHOTGUN];
			}
			ent->client->accuracy_hits++;
		}
	}
	
	// mod code start

//unlagged - backward reconciliation #2
	// put them back
	G_UndoTimeShiftFor( ent );
//unlagged - backward reconciliation #2
	
    //NT - move the clients back to their proper positions

    //if ( shifted ) {
    //    G_UnTimeShiftAllClients( ent );
    //}

	// mod code end
}


void weapon_supershotgun_fire (gentity_t *ent) {
	gentity_t		*tent;

	//ComputeNewTimeShift(ent, 4096);

	// send shotgun blast
	tent = G_TempEntity( muzzle, EV_SHOTGUN );
	VectorScale( forward, 4096, tent->s.origin2 );
	SnapVector( tent->s.origin2 );
//unlagged - attack prediction #2
	// this has to be something the client can predict now
	//tent->s.eventParm = rand() & 255;		// seed for spread pattern
	tent->s.eventParm = ent->client->attackTime % 256; // seed for spread pattern
//unlagged - attack prediction #2
	tent->s.otherEntityNum = ent->s.number;
	tent->s.clientNum = ent->s.number;


	if (ent && ent->client)
	{
		tent->r.svFlags |= SVF_CLIENTMASK;
		tent->r.singleClient = GetClientMask(ent->client->sess.sessionTeam);
	}

	ShotgunPattern( tent->s.pos.trBase, tent->s.origin2, tent->s.eventParm, ent );
}


/*
======================================================================

GRENADE LAUNCHER

======================================================================
*/

void weapon_grenadelauncher_fire (gentity_t *ent) {
	gentity_t	*m;

	++ent->client->pers.stats_shots[WP_GRENADE_LAUNCHER];
	// extra vertical velocity
	forward[2] += 0.2f;
	VectorNormalize( forward );

	m = fire_grenade (ent, muzzle, forward);
	m->damage *= s_quadFactor;
	m->splashDamage *= s_quadFactor;

//	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
}

/*
======================================================================

ROCKET

======================================================================
*/

void Weapon_RocketLauncher_Fire (gentity_t *ent) {
	gentity_t	*m;

	++ent->client->pers.stats_shots[WP_ROCKET_LAUNCHER];

	m = fire_rocket (ent, muzzle, forward);
	m->damage *= s_quadFactor;
	m->splashDamage *= s_quadFactor;

//	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
}


/*
======================================================================

PLASMA GUN

======================================================================
*/

void Weapon_Plasmagun_Fire (gentity_t *ent) {
	gentity_t	*m;

	++ent->client->pers.stats_shots[WP_PLASMAGUN];

	m = fire_plasma (ent, muzzle, forward);
	m->damage *= s_quadFactor;
	m->splashDamage *= s_quadFactor;

//	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
}

/*
======================================================================

RAILGUN

======================================================================
*/
#define	MAX_RAIL_HITS	4

//
// Mod code start
//

int dot(vec3_t A, vec3_t B, vec3_t C) {
    double AB[2];
    double BC[2];
	double dot;

    AB[0] = B[0]-A[0];
    AB[1] = B[1]-A[1];
    BC[0] = C[0]-B[0];
    BC[1] = C[1]-B[1];

    dot = AB[0] * BC[0] + AB[1] * BC[1];

    return dot;
}
//Compute the cross product AB x AC
double cross(vec3_t A, vec3_t B, vec3_t C) {
    double AB[2];
    double AC[2];
	double cross;

    AB[0] = B[0]-A[0];
    AB[1] = B[1]-A[1];
    AC[0] = C[0]-A[0];
    AC[1] = C[1]-A[1];

    cross = AB[0] * AC[1] - AB[1] * AC[0];

    return cross;
}
//Compute the distance from A to B
double distance(vec3_t A, vec3_t B){
    double d1 = A[0] - B[0];
    double d2 = A[1] - B[1];
    return sqrt(d1*d1+d2*d2);
}
//Compute the distance from AB to C
//if isSegment is true, AB is a segment, not a line.
double linePointDist(vec3_t A, vec3_t B, vec3_t C, int isSegment) {
	double dot1;
	double dot2;
    double dist = cross(A,B,C) / distance(A,B);

    if(isSegment) {
        dot1 = dot(A,B,C);
        if(dot1 > 0)
			return distance(B,C);

        dot2 = dot(B,A,C);
        if(dot2 > 0)
			return distance(A,C);
    }
    return abs(dist);
}


int GetClientServerTime(gentity_t* ent) {
	int ttime = 0;

	if (!ent || !ent->client)
		return level.time;

	if (ent->client->frameAimType == 0)
	{
		return level.previousTime + ent->client->frameOffset;
	}

	if (ent->client->frameAimType == 1)
	{
		return ent->client->attackTime + ent->client->pers.cmdTimeNudge;
		
	}

	//ttime = ent->client->pers.cmd.serverTime + ent->client->sess.ServertimeNudge;

	ttime = ent->client->attackTime + ent->client->pers.cmdTimeNudge;

	/*
	//trap_SendServerCommandC( ent->client->ps.clientNum, va("print \"GetClientServerTime: %i, %i, %i\n\"", level.time, level.time - ent->client->sess.aimNudge, ent->client->sess.aimNudge));
	if (level.time - ent->client->sess.aimNudge > level.time)
	{
		return level.previousTime + ent->client->frameOffset;
	}
	else
	{
		return level.time - ent->client->sess.aimNudge;
	}
	*/

	if (ttime > level.time)
		ttime = level.time;

	return ttime;
}

int ValidateHitAimType2(gentity_t *ent, int clientHitNum, int range)
{
	trace_t		trace;
	vec3_t		end;
	//vec3_t		mins;
	//vec3_t		maxs;
	gentity_t *oent = &g_entities[clientHitNum];
	int time;
	int hitTarget = 0;
	int timeOffset = 9999;
	int bestTime = GetClientServerTime(ent);
	int bestTimeOffset = 9999;
	double closestDistance = 9999;
	double dist = 9999;
	//int timeOffsetAtClosest = GetClientServerTime(ent);

	int counter = 0;
	int counter1 = 0;
	int counter2 = 0;

	if (!range)
		range = 8192;

	VectorMA (muzzle, range, forward, end);

	if (!oent || !ent)
		return 0;


	G_DoTimeShiftFor( ent );

	trap_Trace (&trace, muzzle, NULL, NULL, end, 128, MASK_SHOT );

	if (trace.entityNum == clientHitNum) {
		return GetClientServerTime(ent);
	}
	G_UndoTimeShiftFor( ent );


	// FIXME: Temporary fix for DENIED issues due to geometry
	// This opens up the potential for a shoot through walls exploit
	trap_Trace (&trace, muzzle, NULL, NULL, end, 128, 0 );
	//trap_Trace (&trace, muzzle, NULL, NULL, end, 128, MASK_SOLID );
		


	for (time = level.time; time >= level.time-(NUM_CLIENT_HISTORY*(1000/sv_fps.integer)); time -= 25) {

		//G_TimeShiftAllClients(time, ent);
		G_TimeShiftClient(oent, time, qfalse, oent);

		dist = linePointDist(muzzle, trace.endpos, g_entities[clientHitNum].r.currentOrigin, 1);

		//G_UnTimeShiftAllClients(ent);
		G_UnTimeShiftClient(oent);

		if (dist < closestDistance) {
			closestDistance = dist;
			//timeOffsetAtClosest = time - GetClientServerTime(ent);
			bestTime = time;
		}
	}

	// Don't force kills for gauntlet, as it would allow a larger gauntlet range.
	if (closestDistance < 100 /*&& range > 100*/) {
		ent->client->sess.ServertimeNudge = bestTime - ent->client->pers.cmd.serverTime;
		return -1;
	}

	return -2;
}

int GetClientTarget(gentity_t *ent) {
	
	if (ent->r.svFlags & SVF_BOT) {
		return -2;
	}

	
	if (ent->client->hitClient == 0) { // Client said they missed
		//G_Printf("Client %i said miss\n", ent->client->ps.clientNum);
		return -1;
	} else {
		// client said they hit this person. Still need to verify to prevent hackers.
		// Need to subtract 1 to get real client number, since 0 is used to represent a miss.
		//G_Printf("Client %i said hit: %i -- %i\n", ent->client->ps.clientNum, ent->client->hitClient, ent->client->hitClient - 1);
		return ent->client->hitClient - 1;
	}
}

/**********************
ComputeNewTimeShift
-
returns:
0	client said they missed
1	client hit
2	this is a bot, bots don't use timeshift
3	this client uses old style aim, or isn't unlagged
-1	client said they hit, and it's close enough that it's probably true
-2	client said they hit, but server says they're not shooting in the 
	right direction... could be lag related, or an attempted cheater
**********************/


int ComputeNewTimeShift(gentity_t *ent, int range, int clientHitNum) {
	int timeshift = 0;
	//int clientHitNum = 0;

	if (!ent || !ent->client)
		return 3;

	if (ent->r.svFlags & SVF_BOT) {
		return 2;
	} else {
		/*if (ent->client->frameAimType == 0 || ent->client->frameAimType == 1) {
			return 3;
		}*/
		
		//clientHitNum = GetClientTarget(ent);

		// Client said they missed, so return
		if (clientHitNum < 0) {
			return 0;
		}

		if (ent->client->frameAimType >= 2) {
			if (clientHitNum >= 0 && clientHitNum < MAX_CLIENTS) {
				// don't bother trying to find a way to hit yourself, but still try to hit other clients
				if (clientHitNum == ent->client->ps.clientNum) {
					return 1;
				}

				// valid client number
				timeshift = ValidateHitAimType2(ent, clientHitNum, range);
				if (timeshift == -1) {
					return -1;
				}
				if (timeshift == -2) {
					if (ent->client->ps.weapon == WP_RAILGUN) {
						trap_SendServerCommand( ent-g_entities, va("miss \"%i\"", clientHitNum) );
					}
					return -2;
				}
			}
		}
	}

	return 1;
}

//
// Mod code end
//


/*
=================
weapon_railgun_fire
=================
*/
//#define	MAX_RAIL_HITS	4
//#define	ADV_MAX_RAIL_HITS	18
void weapon_railgun_fire (gentity_t *ent) {
	vec3_t		end;
	vec3_t		v;

#ifdef MISSIONPACK
	vec3_t impactpoint, bouncedir;
//freeze
#else
//	vec3_t	impactpoint, bouncedir;
//freeze
#endif
	trace_t		trace;//MonkK
	gentity_t	*tent;
	gentity_t	*traceEnt;
	float		dist, points;
	int			damage;
	int			i, j;
	int			hits;
	int			unlinked;
	int			passent;
	// mod code start
	int			RJFired = 0;
	int			clientHitNum;
	int			noStatPenalty = 0;
	int			hitNothing = 0;
	int			shifted = 0;
	int			numWalls = 0;
	int			timeshift;
	// mod code end
	int			lastTraceIndex;
	gentity_t	*unlinkedEntities[MAX_RAIL_HITS];
	vec3_t		dir;//XX rj
	memcpy( dir, forward, sizeof(dir) );

	++ent->client->pers.stats_shots[WP_RAILGUN];

	damage = gameSettings.hitscans[GS_RAILGUN][GS_DAMAGE] * s_quadFactor;

//unlagged - backward reconciliation #2
	// backward-reconcile the other clients
	//G_DoTimeShiftFor( ent );
//unlagged - backward reconciliation #2
	VectorMA (muzzle, gameSettings.hitscans[GS_RAILGUN][GS_RANGE], forward, end);

	// trace only against the solids, so the railgun will go through people
	unlinked = hits = 0;
	lastTraceIndex = -1;
	passent = ent->s.number;

	if (ent->client->frameAimType >= 2) {
		//Don't waste time doing this for aimType 1 or 0
		clientHitNum = GetClientTarget(ent);

		if ( g_allowObliterate.integer == 2 ) {
			trap_SendServerCommand(-1, va("print \"RailFired: %i - ToD: %i - Hit: %i\n\"",level.time, ent->timeOfDeath, clientHitNum ));
		}

		timeshift = ComputeNewTimeShift(ent, 0, clientHitNum);

		if ( timeshift == 0 ) {
			hitNothing = 1;
		}
		if (timeshift == -1 /*&& clientHitNum >= 0 && clientHitNum < 32*/) { // force kill
			i = clientHitNum;

			if ( g_entities[i].takedamage /*&& G_AllowEntityInteraction(ent, &g_entities[i])*/ ){
				if ( LogAccuracyHit( &g_entities[i], ent ) ) {
					hits++;
				}
				G_Damage (&g_entities[i], ent, ent, forward, end, damage, 0, MOD_RAILGUN);
						
				// unlink this entity, so the next trace will go past it
				trap_UnlinkEntity( &g_entities[i] );
				unlinkedEntities[unlinked] = &g_entities[i];
				unlinked++;
			}
		}
	}

	G_DoTimeShiftFor( ent );
	do {
		trap_Trace (&trace, muzzle, NULL, NULL, end, passent, MASK_SHOT );

		if ( trace.entityNum >= ENTITYNUM_MAX_NORMAL ) {
			break;
		}

		traceEnt = &g_entities[ trace.entityNum ];
		
		if ( traceEnt->takedamage ) {

#ifdef MISSIONPACK
			if ( traceEnt->client && traceEnt->client->invulnerabilityTime > level.time ) {
				if ( G_InvulnerabilityEffect( traceEnt, forward, trace.endpos, impactpoint, bouncedir ) ) {
					G_BounceProjectile( muzzle, impactpoint, bouncedir, end );
					// snap the endpos to integers to save net bandwidth, but nudged towards the line
					SnapVectorTowards( trace.endpos, muzzle );
					// send railgun beam effect
					tent = G_TempEntity( trace.endpos, EV_RAILTRAIL );
					// set player number for custom colors on the railtrail
					tent->s.clientNum = ent->s.clientNum;
					VectorCopy( muzzle, tent->s.origin2 );
					// move origin a bit to come closer to the drawn gun muzzle
					VectorMA( tent->s.origin2, 4, right, tent->s.origin2 );
					VectorMA( tent->s.origin2, -1, up, tent->s.origin2 );
					tent->s.eventParm = 255;	// don't make the explosion at the end
					//
					VectorCopy( impactpoint, muzzle );
					// the player can hit him/herself with the bounced rail
					passent = ENTITYNUM_NONE;
				}
			}
			else {
				if( LogAccuracyHit( traceEnt, ent ) ) {
					hits++;
				}
				G_Damage (traceEnt, ent, ent, forward, trace.endpos, damage, 0, MOD_RAILGUN);
			}
#else	
				if( LogAccuracyHit( traceEnt, ent ) ) {
					hits++;
				}
				G_Damage (traceEnt, ent, ent, forward, trace.endpos, damage, 0, MOD_RAILGUN);		
#endif	
		}

		if ( trace.contents & CONTENTS_SOLID ) {
			break;		// we hit something solid enough to stop the beam
		}

		// unlink this entity, so the next trace will go past it
		trap_UnlinkEntity( traceEnt );
		unlinkedEntities[unlinked] = traceEnt;
		unlinked++;
		
	} while ( unlinked < MAX_RAIL_HITS );
	G_UndoTimeShiftFor( ent );

	// link back in any entities we unlinked
	for ( i = 0 ; i < unlinked ; i++ ) {
		trap_LinkEntity( unlinkedEntities[i] );
	}

	//Do stats
	ent->client->pers.stats_hits[WP_RAILGUN] += hits;
	ent->client->pers.stats_damage[WP_RAILGUN] += (hits * damage);
	ent->client->pers.stats_totaldamage += (hits * damage);

	// the final trace endpos will be the terminal point of the rail trail

	// snap the endpos to integers to save net bandwidth, but nudged towards the line
	SnapVectorTowards( trace.endpos, muzzle );

	// send railgun beam effect
	tent = G_TempEntity( trace.endpos, EV_RAILTRAIL );

	// set player number for custom colors on the railtrail
	tent->s.clientNum = ent->s.clientNum;

	VectorCopy( muzzle, tent->s.origin2 );
	// move origin a bit to come closer to the drawn gun muzzle
	VectorMA( tent->s.origin2, 4, right, tent->s.origin2 );
	VectorMA( tent->s.origin2, -1, up, tent->s.origin2 );

	// no explosion at end if SURF_NOIMPACT, but still make the trail
	if ( trace.surfaceFlags & SURF_NOIMPACT ) {
		tent->s.eventParm = 255;	// don't make the explosion at the end
	} else {
		tent->s.eventParm = DirToByte( trace.plane.normal );
	}
	tent->s.clientNum = ent->s.clientNum;

	// give the shooter a reward sound if they have made two railgun hits in a row
	if ( hits == 0 ) {
		// complete miss
		ent->client->accurateCount = 0;
	} else {
		// check for "impressive" reward sound
		ent->client->accurateCount += hits;
		if ( ent->client->accurateCount >= 2 && 
			!(g_gamemode.integer == 1 || g_gamemode.integer == 5) ) {
			ent->client->accurateCount -= 2;
			ent->client->ps.persistant[PERS_IMPRESSIVE_COUNT]++;
			// add the sprite over the player's head
			ent->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
			ent->client->ps.eFlags |= EF_AWARD_IMPRESSIVE;
			ent->client->rewardTime = level.time + REWARD_SPRITE_TIME;
		} else if ( ent->client->accurateCount >= 3 && 
			(g_gamemode.integer == 1 || g_gamemode.integer == 5) ) {
				gentity_t	*tempEnt2;
				//FIXME: Evo: This probably needs to get broken to work with s_announcer
				tempEnt2 = G_TempEntity( ent->s.origin, EV_GLOBAL_SOUND );
				tempEnt2->s.eventParm = G_SoundIndex( "sound/feedback/accuracy.wav" );
				tempEnt2->r.svFlags |= SVF_BROADCAST;

				ent->client->accurateCount = 0;
				trap_SendServerCommand( -1, va("print \"%s" S_COLOR_CYAN " got an accuracy!\n\"", ent->client->pers.netname) );
			//trap_SendServerCommand(-1, "play \"sound/feedback/accuracy.wav");
		}
		ent->client->accuracy_hits++;
	}
	//Should we do this before determining who got killed?
	if ( g_RailJumping.integer >= 1 && g_RailjumpRadius.integer >= 1 ) {
		for ( j = 0 ; j < 3 ; j++ ) {
			if ( trace.endpos[j] < ent->r.absmin[j] ) {
				v[j] = ent->r.absmin[j] - trace.endpos[j];
			} else if ( trace.endpos[j] > ent->r.absmax[j] ) {
				v[j] = trace.endpos[j] - ent->r.absmax[j];
			} else {
				v[j] = 0;
			}
		}

		dist = VectorLength( v );
		if ( dist <= g_RailjumpRadius.integer ) {
			if ( hits == 0 ) {//only subtract from shots when we didn't hit anything :/
				ent->client->pers.stats_shots[WP_RAILGUN]--;
			}
			++ent->client->pers.stats_railjumps;

			if ( g_DynamicRailgunCycle.integer >= 1 ) {
				ent->client->ps.weaponTime = g_DynamicRailgunCycle.integer;
			}

			g_StaticKnockback.integer?(points = g_railgunKnockback.integer):(points = g_railgunKnockback.integer * ( 1.0 - dist / g_RailjumpRadius.integer ));

			if (g_RailJumping.integer == 2 ) {//Monkk's railjumping code
				vec3_t	kvel, inverseRailPath;
				float	mass;
				mass = 200;

				VectorCopy(forward, inverseRailPath);
				if ( !g_fixMuzzleBug.integer ) {
					VectorInverse(inverseRailPath);
				}
				VectorScale ( inverseRailPath, g_knockback.value * (points - 1) / mass, kvel);//Subract 1 for Quad's IU1.2 "feel"
				VectorAdd (ent->client->ps.velocity, kvel, ent->client->ps.velocity);

				if ( !ent->client->ps.pm_time ) {
					int		t;
					t = (points - 1) * 2;//was knockback | Subract 1 for Quad's IU1.2 "feel"

					if ( t < 50 ) {
						t = 50;
					}
					if ( t > 200 ) {
						t = 200;
					}
					ent->client->ps.pm_time = t;
					ent->client->ps.pm_flags |= PMF_TIME_KNOCKBACK;
				}
			} else if ( g_RailJumping.integer == 3 || g_RailJumping.integer == 4 ) {//XoneXfer
				gentity_t	*bolt;//XX rj
				
				/* RailJump style 4 is possibly closer to IU than anything... */
				

				bolt = G_Spawn();
				bolt->classname = "rocket";
				bolt->nextthink = level.time + 2000;
				//bolt->nextthink = level.time;//Think now <-- Evo did it.
				bolt->think = G_ExplodeMissile;
				
				
				bolt->s.eType = ET_MISSILE;
				bolt->r.svFlags = SVF_USE_CURRENT_ORIGIN;
				bolt->r.svFlags = SVF_NOCLIENT;
				bolt->s.eFlags |= EF_NODRAW ;
				bolt->s.weapon = WP_ROCKET_LAUNCHER;
				bolt->r.ownerNum = ent->s.number;
				bolt->parent = ent;
				bolt->damage = g_railgunKnockback.integer;
				bolt->splashDamage = g_railgunKnockback.integer;
				bolt->splashRadius = g_RailjumpRadius.integer;//was 120
				bolt->methodOfDeath = MOD_XX_RAILJUMP;
				bolt->splashMethodOfDeath = MOD_XX_RAILJUMP;
				bolt->clipmask = MASK_SHOT;
				bolt->target_ent = NULL;
				
				bolt->s.pos.trType = TR_LINEAR;
				//bolt->s.pos.trTime = level.time - 50;		// move a bit on the very first frame
				VectorCopy( muzzle, bolt->s.pos.trBase );
				VectorScale( dir, (g_RailJumping.integer == 3 ? (900) : (50000)), bolt->s.pos.trDelta );
				SnapVector( bolt->s.pos.trDelta );			// save net bandwidth
				VectorCopy (muzzle, bolt->r.currentOrigin);
				
				VectorSet(bolt->r.mins, 0, 0, 0);
				VectorCopy(bolt->r.mins, bolt->r.absmin);
				VectorSet(bolt->r.maxs, 0, 0, 0);
				VectorCopy(bolt->r.maxs, bolt->r.absmax);
			} else {//Revolution
				//New
				vec3_t	kvel;
				float	mass;
				mass = 200;

				VectorSubtract (ent->r.currentOrigin, muzzle, end);
				// push the center of mass higher than the origin so players
				// get knocked into the air more
				end[2] += 26;

				VectorNormalize(end);
				VectorScale ( end, g_knockback.value * points / mass, kvel);
				VectorAdd (ent->client->ps.velocity, kvel, ent->client->ps.velocity);

				if ( !ent->client->ps.pm_time ) {
					int		t;
					t = points * 2;

					if ( t < 50 ) {
						t = 50;
					}
					if ( t > 200 ) {
						t = 200;
					}
					ent->client->ps.pm_time = t;
					ent->client->ps.pm_flags |= PMF_TIME_KNOCKBACK;
				}
			}
		}
	}
}


/*
======================================================================

GRAPPLING HOOK

======================================================================
*/

void Weapon_GrapplingHook_Fire (gentity_t *ent)
{
//freeze
//	AngleVectors( ent->client->ps.viewangles, forward, right, up );
//	CalcMuzzlePoint( ent, forward, right, up, muzzle );
//freeze
	if (!ent->client->fireHeld && !ent->client->hook)
		fire_grapple (ent, muzzle, forward);

	ent->client->fireHeld = qtrue;
}

void Weapon_HookFree (gentity_t *ent)
{
//freeze
	//ent->parent->timestamp = level.time;
//freeze
	ent->parent->client->hook = NULL;
	ent->parent->client->ps.pm_flags &= ~PMF_GRAPPLE_PULL;
	G_FreeEntity( ent );
}

void Weapon_HookThink (gentity_t *ent)
{
	if (ent->enemy) {
		vec3_t v, oldorigin;

		VectorCopy(ent->r.currentOrigin, oldorigin);
		v[0] = ent->enemy->r.currentOrigin[0] + (ent->enemy->r.mins[0] + ent->enemy->r.maxs[0]) * 0.5;
		v[1] = ent->enemy->r.currentOrigin[1] + (ent->enemy->r.mins[1] + ent->enemy->r.maxs[1]) * 0.5;
		v[2] = ent->enemy->r.currentOrigin[2] + (ent->enemy->r.mins[2] + ent->enemy->r.maxs[2]) * 0.5;
		SnapVectorTowards( v, oldorigin );	// save net bandwidth

		G_SetOrigin( ent, v );
	}

	VectorCopy( ent->r.currentOrigin, ent->parent->client->ps.grapplePoint);
}

/*
======================================================================

LIGHTNING GUN

======================================================================
*/

void Weapon_LightningFire( gentity_t *ent ) {
	trace_t		tr;
	vec3_t		end;
#ifdef MISSIONPACK
	vec3_t impactpoint, bouncedir;
#endif
	gentity_t	*traceEnt, *tent;
	int			damage, i, passent;
	int			unlinked = 0;
//	gentity_t	*unlinkedEntities[10];
	
	// mod code start
	int			hitNothing = 0;
	int			timeshift = 0;
	int			clientHitNum = 0;
	int			shifted = 0;

	
	++ent->client->pers.stats_shots[WP_LIGHTNING];
//unlagged - server options
	// this is configurable now
	damage = gameSettings.hitscans[GS_LIGHTNING][GS_DAMAGE] * s_quadFactor;


	if (ent->client->frameAimType >= 2 ) {
		clientHitNum = GetClientTarget(ent);
		timeshift = ComputeNewTimeShift(ent, gameSettings.hitscans[GS_LIGHTNING][GS_RANGE], clientHitNum);

		if ( timeshift == 0 ) {
			hitNothing = 1;
		}

		if (timeshift == -1 || timeshift == 1) {
			if( LogAccuracyHit( &g_entities[clientHitNum], ent ) ) {
				ent->client->accuracy_hits++;
				++ent->client->pers.stats_hits[WP_LIGHTNING];
				ent->client->pers.stats_damage[WP_LIGHTNING] += damage;
				ent->client->pers.stats_totaldamage += damage;
			}
			G_Damage (&g_entities[clientHitNum], ent, ent, forward, end, damage, 0, MOD_LIGHTNING);
			return;
		}
	}
	// mod code end

//unlagged - server options

	passent = ent->s.number;
	for (i = 0; i < 10; i++) {
		VectorMA( muzzle, gameSettings.hitscans[GS_LIGHTNING][GS_RANGE], forward, end );

//unlagged - backward reconciliation #2
	// backward-reconcile the other clients
	G_DoTimeShiftFor( ent );
//unlagged - backward reconciliation #2

		trap_Trace (&tr, muzzle, NULL, NULL, end, passent, MASK_SHOT);

//unlagged - backward reconciliation #2
	// put them back
	G_UndoTimeShiftFor( ent );
//unlagged - backward reconciliation #2

#ifdef MISSIONPACK
		// if not the first trace (the lightning bounced of an invulnerability sphere)
		if (i) {
			// add bounced off lightning bolt temp entity
			// the first lightning bolt is a cgame only visual
			//
			tent = G_TempEntity( muzzle, EV_LIGHTNINGBOLT );
			tent->s.clientNum = ent->s.number;
			VectorCopy( tr.endpos, end );
			SnapVector( end );
			VectorCopy( end, tent->s.origin2 );
		}
#endif
		if ( tr.entityNum == ENTITYNUM_NONE ) {
			return;
		}

		traceEnt = &g_entities[ tr.entityNum ];

		if ( traceEnt->takedamage /*&& G_AllowEntityInteraction(ent, traceEnt)*/ ) {
#ifdef MISSIONPACK
			if ( traceEnt->client && traceEnt->client->invulnerabilityTime > level.time ) {
				if (G_InvulnerabilityEffect( traceEnt, forward, tr.endpos, impactpoint, bouncedir )) {
					G_BounceProjectile( muzzle, impactpoint, bouncedir, end );
					VectorCopy( impactpoint, muzzle );
					VectorSubtract( end, impactpoint, forward );
					VectorNormalize(forward);
					// the player can hit him/herself with the bounced lightning
					passent = ENTITYNUM_NONE;
				}
				else {
					VectorCopy( tr.endpos, muzzle );
					passent = traceEnt->s.number;
				}
				continue;
			}
			else {
				G_Damage( traceEnt, ent, ent, forward, tr.endpos,
					damage, 0, MOD_LIGHTNING);
			}
#else
			if ( traceEnt->client ) {
				++ent->client->pers.stats_hits[WP_LIGHTNING];
				ent->client->pers.stats_damage[WP_LIGHTNING] += damage;
				ent->client->pers.stats_totaldamage += damage;
			}
				G_Damage( traceEnt, ent, ent, forward, tr.endpos,
					damage, 0, MOD_LIGHTNING);
#endif
		}

		if ( traceEnt->takedamage && traceEnt->client ) {
			tent = G_TempEntity( tr.endpos, EV_MISSILE_HIT );
			tent->s.otherEntityNum = traceEnt->s.number;
			tent->s.eventParm = DirToByte( tr.plane.normal );
			tent->s.weapon = ent->s.weapon;
			if( LogAccuracyHit( traceEnt, ent ) ) {
				ent->client->accuracy_hits++;
			}
//freeze
		} else if ( g_gamemode.integer > 3 && is_body( traceEnt ) ) {
			tent = G_TempEntity( tr.endpos, EV_MISSILE_HIT );
			tent->s.otherEntityNum = traceEnt->s.number;
			tent->s.eventParm = DirToByte( tr.plane.normal );
			tent->s.weapon = ent->s.weapon;
//freeze
		} else if ( !( tr.surfaceFlags & SURF_NOIMPACT ) ) {
			tent = G_TempEntity( tr.endpos, EV_MISSILE_MISS );
			tent->s.eventParm = DirToByte( tr.plane.normal );
		}

		break;
	}
}

#ifdef MISSIONPACK
/*
======================================================================

NAILGUN

======================================================================
*/

void Weapon_Nailgun_Fire (gentity_t *ent) {
	gentity_t	*m;
	int			count;

	for( count = 0; count < NUM_NAILSHOTS; count++ ) {
		m = fire_nail (ent, muzzle, forward, right, up );
		m->damage *= s_quadFactor;
		m->splashDamage *= s_quadFactor;
	}

//	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
}


/*
======================================================================

PROXIMITY MINE LAUNCHER

======================================================================
*/

void weapon_proxlauncher_fire (gentity_t *ent) {
	gentity_t	*m;

	// extra vertical velocity
	forward[2] += 0.2f;
	VectorNormalize( forward );

	m = fire_prox (ent, muzzle, forward);
	m->damage *= s_quadFactor;
	m->splashDamage *= s_quadFactor;

//	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
}

#endif

//======================================================================


/*
===============
LogAccuracyHit
===============
*/
qboolean LogAccuracyHit( gentity_t *target, gentity_t *attacker ) {
	if( !target->takedamage ) {
		return qfalse;
	}

	/*if ( !G_AllowEntityInteraction(attacker, target) )
	{
		return qfalse;
	}*/

	if ( target == attacker ) {
		return qfalse;
	}

	if( !target->client ) {
		return qfalse;
	}

	if( !attacker->client ) {
		return qfalse;
	}

	if( target->client->ps.stats[STAT_HEALTH] <= 0 ) {
		return qfalse;
	}

	if ( OnSameTeam( target, attacker ) ) {
		return qfalse;
	}

	return qtrue;
}

//#define MUZZLE	14
//14
// ripped from qfusion
void G_ProjectSource ( vec3_t point, vec3_t distance, vec3_t forward, vec3_t right, vec3_t result ) {
   result[0] = point[0] + forward[0] * distance[0] + right[0] * distance[1];
   result[1] = point[1] + forward[1] * distance[0] + right[1] * distance[1];
   result[2] = point[2] + forward[2] * distance[0] + right[2] * distance[1] + distance[2];
}
/*
===============
CalcMuzzlePoint

set muzzle location relative to pivoting eye
===============
*/
void CalcMuzzlePoint ( gentity_t *ent, vec3_t forward, vec3_t right, vec3_t up, vec3_t muzzlePoint ) {
	if ( g_fixMuzzleBug.integer ) {
		vec3_t start;
		vec3_t offset;

		AngleVectors (ent->client->ps.viewangles, forward, right, NULL);
		VectorSet(offset, 0-5, 0, 0+20);
		G_ProjectSource (ent->client->ps.origin, offset, forward, right, start);
		VectorCopy( start, muzzlePoint );
	} else {
		VectorCopy( ent->s.pos.trBase, muzzlePoint );
		muzzlePoint[2] += ent->client->ps.viewheight;
		VectorMA( muzzlePoint, 14, forward, muzzlePoint );
	}
	// snap to integer coordinates for more efficient network bandwidth usage
	SnapVector( muzzlePoint );
}

/*
===============
CalcMuzzlePointOrigin

set muzzle location relative to pivoting eye
===============
*/
void CalcMuzzlePointOrigin ( gentity_t *ent, vec3_t origin, vec3_t forward, vec3_t right, vec3_t up, vec3_t muzzlePoint ) {
	if ( g_fixMuzzleBug.integer ) {
		vec3_t start;
		vec3_t offset;

		AngleVectors (ent->client->ps.viewangles, forward, right, NULL);
		VectorSet(offset, 0-5, 0, 0+20);
		G_ProjectSource (ent->client->ps.origin, offset, forward, right, start);
		VectorCopy( start, muzzlePoint );
	} else {
		VectorCopy( ent->s.pos.trBase, muzzlePoint );
		muzzlePoint[2] += ent->client->ps.viewheight;
		VectorMA( muzzlePoint, 14, forward, muzzlePoint );
	}
	// snap to integer coordinates for more efficient network bandwidth usage
	SnapVector( muzzlePoint );
}

void FireWeaponGrapple( gentity_t *ent) {
	//server won't accecpt the client command unless the mod_enableHook == 1

	// set aiming directions
	AngleVectors (ent->client->ps.viewangles, forward, right, up);

	CalcMuzzlePointOrigin ( ent, ent->client->oldOrigin, forward, right, up, muzzle );

	if( ent->client->buttons & BUTTON_FIRE_GRAPPLE ) {
		Weapon_GrapplingHook_Fire( ent );
	}
}


/*
===============
FireWeapon
===============
*/
void FireWeapon( gentity_t *ent, int evtParm ) {
	if (ent->client->ps.powerups[PW_QUAD] ) {
		s_quadFactor = g_quadfactor.value;
	} else {
		s_quadFactor = 1;
	}
#ifdef MISSIONPACK
	if( ent->client->persistantPowerup && ent->client->persistantPowerup->item && ent->client->persistantPowerup->item->giTag == PW_DOUBLER ) {
		s_quadFactor *= 2;
	}
#endif

	// track shots taken for accuracy tracking.  Grapple is not a weapon and gauntet is just not tracked
	if( ent->s.weapon != WP_GRAPPLING_HOOK && ent->s.weapon != WP_GAUNTLET ) {
#ifdef MISSIONPACK
		if( ent->s.weapon == WP_NAILGUN ) {
			ent->client->accuracy_shots += NUM_NAILSHOTS;
		} else {
			ent->client->accuracy_shots++;
		}
#else
		ent->client->accuracy_shots++;
#endif
	}

	if ( g_spawnProtection.integer && ent->client->spawnProtection == qtrue ) {
		ent->client->ps.powerups[PW_BATTLESUIT] = 0;
		ent->client->spawnProtection = qfalse;
	}
	// set aiming directions
	AngleVectors (ent->client->ps.viewangles, forward, right, up);

	CalcMuzzlePointOrigin ( ent, ent->client->oldOrigin, forward, right, up, muzzle );
	//It's the same thing.. need to port it?
	//CalcMuzzlePoint ( ent, ent->client->oldOrigin, forward, right, up, muzzle );

	// fire the specific weapon
	switch( ent->s.weapon ) {
	case WP_GAUNTLET:
			Weapon_Gauntlet( ent );
		break;
	case WP_LIGHTNING:
		Weapon_LightningFire( ent );
		break;
	case WP_SHOTGUN:
			weapon_supershotgun_fire( ent );
		break;
	case WP_MACHINEGUN:
		/*if ( g_gametype.integer != GT_TEAM ) {
			Bullet_Fire( ent, MACHINEGUN_SPREAD, MACHINEGUN_DAMAGE );
		} else {
			Bullet_Fire( ent, MACHINEGUN_SPREAD, MACHINEGUN_TEAM_DAMAGE );
		}
		break;*/
		if ( g_gametype.integer != GT_TEAM ) {
			Bullet_Fire( ent, MACHINEGUN_SPREAD, gameSettings.hitscans[GS_MACHINEGUN][GS_DAMAGE] ); // CPM
		} else {
			Bullet_Fire( ent, MACHINEGUN_SPREAD, gameSettings.hitscans[GS_MACHINEGUN][GS_RANGE] ); // CPM
		}
		break;
	case WP_GRENADE_LAUNCHER:
		weapon_grenadelauncher_fire( ent );
		break;
	case WP_ROCKET_LAUNCHER:
		Weapon_RocketLauncher_Fire( ent );
		break;
	case WP_PLASMAGUN:
		Weapon_Plasmagun_Fire( ent );
		break;
	case WP_RAILGUN:
		weapon_railgun_fire( ent );
		break;
	case WP_BFG:
		BFG_Fire( ent );
		break;
	case WP_GRAPPLING_HOOK:
		Weapon_GrapplingHook_Fire( ent );
		break;
#ifdef MISSIONPACK
	case WP_NAILGUN:
		Weapon_Nailgun_Fire( ent );
		break;
	case WP_PROX_LAUNCHER:
		weapon_proxlauncher_fire( ent );
		break;
	case WP_CHAINGUN:
		Bullet_Fire( ent, CHAINGUN_SPREAD, MACHINEGUN_DAMAGE );
		break;
#endif
	default:
// FIXME		G_Error( "Bad ent->s.weapon" );
		break;
	}
}


#ifdef MISSIONPACK

/*
===============
KamikazeRadiusDamage
===============
*/
static void KamikazeRadiusDamage( vec3_t origin, gentity_t *attacker, float damage, float radius ) {
	float		dist;
	gentity_t	*ent;
	int			entityList[MAX_GENTITIES];
	int			numListedEntities;
	vec3_t		mins, maxs;
	vec3_t		v;
	vec3_t		dir;
	int			i, e;

	if ( radius < 1 ) {
		radius = 1;
	}

	for ( i = 0 ; i < 3 ; i++ ) {
		mins[i] = origin[i] - radius;
		maxs[i] = origin[i] + radius;
	}

	numListedEntities = trap_EntitiesInBox( mins, maxs, entityList, MAX_GENTITIES );

	for ( e = 0 ; e < numListedEntities ; e++ ) {
		ent = &g_entities[entityList[ e ]];

		if (!ent->takedamage /*&& G_AllowEntityInteraction(attacker, ent)*/) {
			continue;
		}

		// dont hit things we have already hit
		if( ent->kamikazeTime > level.time ) {
			continue;
		}

		// find the distance from the edge of the bounding box
		for ( i = 0 ; i < 3 ; i++ ) {
			if ( origin[i] < ent->r.absmin[i] ) {
				v[i] = ent->r.absmin[i] - origin[i];
			} else if ( origin[i] > ent->r.absmax[i] ) {
				v[i] = origin[i] - ent->r.absmax[i];
			} else {
				v[i] = 0;
			}
		}

		dist = VectorLength( v );
		if ( dist >= radius ) {
			continue;
		}

//		if( CanDamage (ent, origin) ) {
			VectorSubtract (ent->r.currentOrigin, origin, dir);
			// push the center of mass higher than the origin so players
			// get knocked into the air more
			dir[2] += 24;
			G_Damage( ent, NULL, attacker, dir, origin, damage, DAMAGE_RADIUS|DAMAGE_NO_TEAM_PROTECTION, MOD_KAMIKAZE );
			ent->kamikazeTime = level.time + 3000;
//		}
	}
}

/*
===============
KamikazeShockWave
===============
*/
static void KamikazeShockWave( vec3_t origin, gentity_t *attacker, float damage, float push, float radius ) {
	float		dist;
	gentity_t	*ent;
	int			entityList[MAX_GENTITIES];
	int			numListedEntities;
	vec3_t		mins, maxs;
	vec3_t		v;
	vec3_t		dir;
	int			i, e;

	if ( radius < 1 )
		radius = 1;

	for ( i = 0 ; i < 3 ; i++ ) {
		mins[i] = origin[i] - radius;
		maxs[i] = origin[i] + radius;
	}

	numListedEntities = trap_EntitiesInBox( mins, maxs, entityList, MAX_GENTITIES );

	for ( e = 0 ; e < numListedEntities ; e++ ) {
		ent = &g_entities[entityList[ e ]];

		// dont hit things we have already hit
		if( ent->kamikazeShockTime > level.time ) {
			continue;
		}

		// find the distance from the edge of the bounding box
		for ( i = 0 ; i < 3 ; i++ ) {
			if ( origin[i] < ent->r.absmin[i] ) {
				v[i] = ent->r.absmin[i] - origin[i];
			} else if ( origin[i] > ent->r.absmax[i] ) {
				v[i] = origin[i] - ent->r.absmax[i];
			} else {
				v[i] = 0;
			}
		}

		dist = VectorLength( v );
		if ( dist >= radius ) {
			continue;
		}

//		if( CanDamage (ent, origin) ) {
			VectorSubtract (ent->r.currentOrigin, origin, dir);
			dir[2] += 24;
			G_Damage( ent, NULL, attacker, dir, origin, damage, DAMAGE_RADIUS|DAMAGE_NO_TEAM_PROTECTION, MOD_KAMIKAZE );
			//
			dir[2] = 0;
			VectorNormalize(dir);
			if ( ent->client ) {
				ent->client->ps.velocity[0] = dir[0] * push;
				ent->client->ps.velocity[1] = dir[1] * push;
				ent->client->ps.velocity[2] = 100;
			}
			ent->kamikazeShockTime = level.time + 3000;
//		}
	}
}

/*
===============
KamikazeDamage
===============
*/
static void KamikazeDamage( gentity_t *self ) {
	int i;
	float t;
	gentity_t *ent;
	vec3_t newangles;

	self->count += 100;

	if (self->count >= KAMI_SHOCKWAVE_STARTTIME) {
		// shockwave push back
		t = self->count - KAMI_SHOCKWAVE_STARTTIME;
		KamikazeShockWave(self->s.pos.trBase, self->activator, 25, 400,	(int) (float) t * KAMI_SHOCKWAVE_MAXRADIUS / (KAMI_SHOCKWAVE_ENDTIME - KAMI_SHOCKWAVE_STARTTIME) );
	}
	//
	if (self->count >= KAMI_EXPLODE_STARTTIME) {
		// do our damage
		t = self->count - KAMI_EXPLODE_STARTTIME;
		KamikazeRadiusDamage( self->s.pos.trBase, self->activator, 400,	(int) (float) t * KAMI_BOOMSPHERE_MAXRADIUS / (KAMI_IMPLODE_STARTTIME - KAMI_EXPLODE_STARTTIME) );
	}

	// either cycle or kill self
	if( self->count >= KAMI_SHOCKWAVE_ENDTIME ) {
		G_FreeEntity( self );
		return;
	}
	self->nextthink = level.time + 100;

	// add earth quake effect
	newangles[0] = crandom() * 2;
	newangles[1] = crandom() * 2;
	newangles[2] = 0;
	for (i = 0; i < MAX_CLIENTS; i++)
	{
		ent = &g_entities[i];
		if (!ent->inuse)
			continue;
		if (!ent->client)
			continue;

		if (ent->client->ps.groundEntityNum != ENTITYNUM_NONE) {
			ent->client->ps.velocity[0] += crandom() * 120;
			ent->client->ps.velocity[1] += crandom() * 120;
			ent->client->ps.velocity[2] = 30 + random() * 25;
		}

		ent->client->ps.delta_angles[0] += ANGLE2SHORT(newangles[0] - self->movedir[0]);
		ent->client->ps.delta_angles[1] += ANGLE2SHORT(newangles[1] - self->movedir[1]);
		ent->client->ps.delta_angles[2] += ANGLE2SHORT(newangles[2] - self->movedir[2]);
	}
	VectorCopy(newangles, self->movedir);
}

/*
===============
G_StartKamikaze
===============
*/
void G_StartKamikaze( gentity_t *ent ) {
	gentity_t	*explosion;
	gentity_t	*te;
	vec3_t		snapped;

	// start up the explosion logic
	explosion = G_Spawn();

	explosion->s.eType = ET_EVENTS + EV_KAMIKAZE;
	explosion->eventTime = level.time;

	if ( ent->client ) {
		VectorCopy( ent->s.pos.trBase, snapped );
	}
	else {
		VectorCopy( ent->activator->s.pos.trBase, snapped );
	}
	SnapVector( snapped );		// save network bandwidth
	G_SetOrigin( explosion, snapped );

	explosion->classname = "kamikaze";
	explosion->s.pos.trType = TR_STATIONARY;

	explosion->kamikazeTime = level.time;

	explosion->think = KamikazeDamage;
	explosion->nextthink = level.time + 100;
	explosion->count = 0;
	VectorClear(explosion->movedir);

	trap_LinkEntity( explosion );

	if (ent->client) {
		//
		explosion->activator = ent;
		//
		ent->s.eFlags &= ~EF_KAMIKAZE;
		// nuke the guy that used it
		G_Damage( ent, ent, ent, NULL, NULL, 100000, DAMAGE_NO_PROTECTION, MOD_KAMIKAZE );
	}
	else {
		if ( !strcmp(ent->activator->classname, "bodyque") ) {
			explosion->activator = &g_entities[ent->activator->r.ownerNum];
		}
		else {
			explosion->activator = ent->activator;
		}
	}

	// play global sound at all clients
	te = G_TempEntity(snapped, EV_GLOBAL_TEAM_SOUND );
	te->r.svFlags |= SVF_BROADCAST;
	te->s.eventParm = GTS_KAMIKAZE;
	te->s.clientNum = ent->s.number;
}
#endif
