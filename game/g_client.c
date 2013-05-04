// Copyright (C) 1999-2000 Id Software, Inc.
//
#include "g_local.h"
#include "bg_promode.h"

// g_client.c -- client functions that don't happen every frame

static vec3_t	playerMins = {-15, -15, -24};
static vec3_t	playerMaxs = {15, 15, 32};

/*QUAKED info_player_deathmatch (1 0 1) (-16 -16 -24) (16 16 32) initial
potential spawning position for deathmatch games.
The first time a player enters the game, they will be at an 'initial' spot.
Targets will be fired when someone spawns in on them.
"nobots" will prevent bots from using this spot.
"nohumans" will prevent non-bots from using this spot.
*/
void SP_info_player_deathmatch( gentity_t *ent ) {
	int		i;

	G_SpawnInt( "nobots", "0", &i);
	if ( i ) {
		ent->flags |= FL_NO_BOTS;
	}
	G_SpawnInt( "nohumans", "0", &i );
	if ( i ) {
		ent->flags |= FL_NO_HUMANS;
	}
}

/*QUAKED info_player_start (1 0 0) (-16 -16 -24) (16 16 32)
equivelant to info_player_deathmatch
*/
void SP_info_player_start(gentity_t *ent) {
	ent->classname = "info_player_deathmatch";
	SP_info_player_deathmatch( ent );
}

/*QUAKED info_player_intermission (1 0 1) (-16 -16 -24) (16 16 32)
The intermission will be viewed from this point.  Target an info_notnull for the view direction.
*/
void SP_info_player_intermission( gentity_t *ent ) {

}



/*
=======================================================================

  SelectSpawnPoint

=======================================================================
*/

/*
================
SpotWouldTelefrag

================
*/
qboolean SpotWouldTelefrag( gentity_t *spot ) {
	int			i, num;
	int			touch[MAX_GENTITIES];
	gentity_t	*hit;
	vec3_t		mins, maxs;

	VectorAdd( spot->s.origin, playerMins, mins );
	VectorAdd( spot->s.origin, playerMaxs, maxs );
	num = trap_EntitiesInBox( mins, maxs, touch, MAX_GENTITIES );

	for (i=0 ; i<num ; i++) {
		hit = &g_entities[touch[i]];
		//if ( hit->client && hit->client->ps.stats[STAT_HEALTH] > 0 ) {
		if ( hit->client) {
			return qtrue;
		}

	}

	return qfalse;
}

/*
================
SelectNearestDeathmatchSpawnPoint

Find the spot that we DON'T want to use
================
*/
#define	MAX_SPAWN_POINTS	128
gentity_t *SelectNearestDeathmatchSpawnPoint( vec3_t from ) {
	gentity_t	*spot;
	vec3_t		delta;
	float		dist, nearestDist;
	gentity_t	*nearestSpot;

	nearestDist = 999999;
	nearestSpot = NULL;
	spot = NULL;

	while ((spot = G_Find (spot, FOFS(classname), "info_player_deathmatch")) != NULL) {

		VectorSubtract( spot->s.origin, from, delta );
		dist = VectorLength( delta );
		if ( dist < nearestDist ) {
			nearestDist = dist;
			nearestSpot = spot;
		}
	}

	return nearestSpot;
}


/*
================
SelectRandomDeathmatchSpawnPoint

go to a random point that doesn't telefrag
================
*/
#define	MAX_SPAWN_POINTS	128
gentity_t *SelectRandomDeathmatchSpawnPoint( void ) {
	gentity_t	*spot;
	int			count;
	int			selection;
	gentity_t	*spots[MAX_SPAWN_POINTS];

	count = 0;
	spot = NULL;

	while ((spot = G_Find (spot, FOFS(classname), "info_player_deathmatch")) != NULL) {
		if ( SpotWouldTelefrag( spot ) ) {
			continue;
		}
		spots[ count ] = spot;
		count++;
	}

	if ( !count ) {	// no spots that won't telefrag
		return G_Find( NULL, FOFS(classname), "info_player_deathmatch");
	}

	selection = rand() % count;
	return spots[ selection ];
}

/*
===========
SelectRandomFurthestSpawnPoint

Chooses a player start, deathmatch start, etc
============
*/
gentity_t *SelectRandomFurthestSpawnPoint ( vec3_t avoidPoint, vec3_t origin, vec3_t angles ) {
	gentity_t	*spot;
	vec3_t		delta;
	float		dist;
	float		list_dist[64];
	gentity_t	*list_spot[64];
	int			numSpots, rnd, i, j;

	numSpots = 0;
	spot = NULL;

	while ((spot = G_Find (spot, FOFS(classname), "info_player_deathmatch")) != NULL) {
		if ( SpotWouldTelefrag( spot ) ) {
			continue;
		}
		VectorSubtract( spot->s.origin, avoidPoint, delta );
		dist = VectorLength( delta );
		for (i = 0; i < numSpots; i++) {
			if ( dist > list_dist[i] ) {
				if ( numSpots >= 64 )
					numSpots = 64-1;
				for (j = numSpots; j > i; j--) {
					list_dist[j] = list_dist[j-1];
					list_spot[j] = list_spot[j-1];
				}
				list_dist[i] = dist;
				list_spot[i] = spot;
				numSpots++;
				if (numSpots > 64)
					numSpots = 64;
				break;
			}
		}
		if (i >= numSpots && numSpots < 64) {
			list_dist[numSpots] = dist;
			list_spot[numSpots] = spot;
			numSpots++;
		}
	}
	if (!numSpots) {
		spot = G_Find( NULL, FOFS(classname), "info_player_deathmatch");
		if (!spot)
			G_Error( "Couldn't find a spawn point" );
		VectorCopy (spot->s.origin, origin);
		origin[2] += 9;
		VectorCopy (spot->s.angles, angles);
		return spot;
	}

	// select a random spot from the spawn points furthest away
	rnd = random() * (numSpots / 2);

	VectorCopy (list_spot[rnd]->s.origin, origin);
	origin[2] += 9;
	VectorCopy (list_spot[rnd]->s.angles, angles);

	return list_spot[rnd];
}

/*
===========
SelectSpawnPoint

Chooses a player start, deathmatch start, etc
============
*/
gentity_t *SelectSpawnPoint ( vec3_t avoidPoint, vec3_t origin, vec3_t angles ) {
	return SelectRandomFurthestSpawnPoint( avoidPoint, origin, angles );

	/*
	gentity_t	*spot;
	gentity_t	*nearestSpot;

	nearestSpot = SelectNearestDeathmatchSpawnPoint( avoidPoint );

	spot = SelectRandomDeathmatchSpawnPoint ( );
	if ( spot == nearestSpot ) {
		// roll again if it would be real close to point of death
		spot = SelectRandomDeathmatchSpawnPoint ( );
		if ( spot == nearestSpot ) {
			// last try
			spot = SelectRandomDeathmatchSpawnPoint ( );
		}		
	}

	// find a single player start spot
	if (!spot) {
		G_Error( "Couldn't find a spawn point" );
	}

	VectorCopy (spot->s.origin, origin);
	origin[2] += 9;
	VectorCopy (spot->s.angles, angles);

	return spot;
	*/
}

/*
===========
SelectInitialSpawnPoint

Try to find a spawn point marked 'initial', otherwise
use normal spawn selection.
============
*/
gentity_t *SelectInitialSpawnPoint( vec3_t origin, vec3_t angles ) {
	gentity_t	*spot;

	spot = NULL;
	while ((spot = G_Find (spot, FOFS(classname), "info_player_deathmatch")) != NULL) {
		if ( spot->spawnflags & 1 ) {
			break;
		}
	}

	if ( !spot || SpotWouldTelefrag( spot ) ) {
		return SelectSpawnPoint( vec3_origin, origin, angles );
	}

	VectorCopy (spot->s.origin, origin);
	origin[2] += 9;
	VectorCopy (spot->s.angles, angles);

	return spot;
}

/*
===========
SelectSpectatorSpawnPoint

============
*/
gentity_t *SelectSpectatorSpawnPoint( vec3_t origin, vec3_t angles ) {
	FindIntermissionPoint();

	VectorCopy( level.intermission_origin, origin );
	VectorCopy( level.intermission_angle, angles );

	return NULL;
}

/*
=======================================================================

BODYQUE

=======================================================================
*/

/*
===============
InitBodyQue
===============
*/
void InitBodyQue (void) {
	int		i;
	gentity_t	*ent;

	level.bodyQueIndex = 0;
	for (i=0; i<BODY_QUEUE_SIZE ; i++) {
		ent = G_Spawn();
		ent->classname = "bodyque";
		ent->neverFree = qtrue;
		level.bodyQue[i] = ent;
	}
}

/*
=============
BodySink

After sitting around for five seconds, fall into the ground and dissapear
=============
*/
void BodySink( gentity_t *ent ) {
	if ( level.time - ent->timestamp > 6500 ) {
		// the body ques are never actually freed, they are just unlinked
		//ent->relink = 0;
		trap_UnlinkEntity( ent );
		ent->physicsObject = qfalse;
		return;	
	}
	ent->nextthink = level.time + 100;
	ent->s.pos.trBase[2] -= 1;
}

/*
=============
CopyToBodyQue

A player is respawning, so make an entity that looks
just like the existing corpse to leave behind.
=============
*/
void CopyToBodyQue( gentity_t *ent ) {
#ifdef MISSIONPACK
	gentity_t	*e;
	int i;
#endif
	gentity_t		*body;
	int			contents;

	//ent->relink = 0;
	trap_UnlinkEntity (ent);

	// if client is in a nodrop area, don't leave the body
	contents = trap_PointContents( ent->s.origin, -1 );
	if ( contents & CONTENTS_NODROP ) {
		return;
	}

	// grab a body que and cycle to the next one
	body = level.bodyQue[ level.bodyQueIndex ];
	level.bodyQueIndex = (level.bodyQueIndex + 1) % BODY_QUEUE_SIZE;

	//body->relink = 0;
	trap_UnlinkEntity (body);

	body->s = ent->s;
	body->s.eFlags = EF_DEAD;		// clear EF_TALK, etc
#ifdef MISSIONPACK
	if ( ent->s.eFlags & EF_KAMIKAZE ) {
		body->s.eFlags |= EF_KAMIKAZE;

		// check if there is a kamikaze timer around for this owner
		for (i = 0; i < MAX_GENTITIES; i++) {
			e = &g_entities[i];
			if (!e->inuse)
				continue;
			if (e->activator != ent)
				continue;
			if (strcmp(e->classname, "kamikaze timer"))
				continue;
			e->activator = body;
			break;
		}
	}
#endif
	body->s.powerups = 0;	// clear powerups
	body->s.loopSound = 0;	// clear lava burning
	body->s.number = body - g_entities;
	body->timestamp = level.time;
	body->physicsObject = qtrue;
	body->physicsBounce = 0;		// don't bounce
	if ( body->s.groundEntityNum == ENTITYNUM_NONE ) {
		body->s.pos.trType = TR_GRAVITY;
		body->s.pos.trTime = level.time;
		VectorCopy( ent->client->ps.velocity, body->s.pos.trDelta );
	} else {
		body->s.pos.trType = TR_STATIONARY;
	}
	body->s.event = 0;

	// change the animation to the last-frame only, so the sequence
	// doesn't repeat anew for the body
	switch ( body->s.legsAnim & ~ANIM_TOGGLEBIT ) {
	case BOTH_DEATH1:
	case BOTH_DEAD1:
		body->s.torsoAnim = body->s.legsAnim = BOTH_DEAD1;
		break;
	case BOTH_DEATH2:
	case BOTH_DEAD2:
		body->s.torsoAnim = body->s.legsAnim = BOTH_DEAD2;
		break;
	case BOTH_DEATH3:
	case BOTH_DEAD3:
	default:
		body->s.torsoAnim = body->s.legsAnim = BOTH_DEAD3;
		break;
	}

	body->r.svFlags = ent->r.svFlags;
	VectorCopy (ent->r.mins, body->r.mins);
	VectorCopy (ent->r.maxs, body->r.maxs);
	VectorCopy (ent->r.absmin, body->r.absmin);
	VectorCopy (ent->r.absmax, body->r.absmax);

	body->clipmask = CONTENTS_SOLID | CONTENTS_PLAYERCLIP;
	body->r.contents = CONTENTS_CORPSE;
	body->r.ownerNum = ent->s.number;

	body->nextthink = level.time + 5000;
	body->think = BodySink;

	body->die = body_die;

	// don't take more damage if already gibbed
	if ( ent->health <= GIB_HEALTH ) {
		body->takedamage = qfalse;
	} else {
		body->takedamage = qtrue;
	}


	VectorCopy ( body->s.pos.trBase, body->r.currentOrigin );
	trap_LinkEntity (body);
}

//======================================================================


/*
==================
SetClientViewAngle

==================
*/
void SetClientViewAngle( gentity_t *ent, vec3_t angle ) {
	int			i;

	// set the delta angle
	for (i=0 ; i<3 ; i++) {
		int		cmdAngle;

		cmdAngle = ANGLE2SHORT(angle[i]);
		ent->client->ps.delta_angles[i] = cmdAngle - ent->client->pers.cmd.angles[i];
	}
	VectorCopy( angle, ent->s.angles );
	VectorCopy (ent->s.angles, ent->client->ps.viewangles);
}

/*
================
respawn
================
*/
void respawn( gentity_t *ent ) {
	gentity_t	*tent;

//freeze
	if ( g_gamemode.integer > 3 ) {
		if ( Set_spectator( ent ) ) return;
	}
//freeze
	CopyToBodyQue (ent);
	ClientSpawn(ent);

	// add a teleportation effect
	tent = G_TempEntity( ent->client->ps.origin, EV_PLAYER_TELEPORT_IN );
	tent->s.clientNum = ent->s.clientNum;
}

/*
================
TeamCount

Returns number of players on a team
================
*/
team_t TeamCount( int ignoreClientNum, int team ) {
	int		i;
	int		count = 0;

	for ( i = 0 ; i < level.maxclients ; i++ ) {
		if ( i == ignoreClientNum ) {
			continue;
		}
		if ( level.clients[i].pers.connected == CON_DISCONNECTED ) {
			continue;
		}
		if ( level.clients[i].sess.sessionTeam == team ) {
			count++;
		}
	}

	return count;
}

/*
================
TeamLeader

Returns the client number of the team leader
================
*/
int TeamLeader( int team ) {
	int		i;

	for ( i = 0 ; i < level.maxclients ; i++ ) {
		if ( level.clients[i].pers.connected == CON_DISCONNECTED ) {
			continue;
		}
		if ( level.clients[i].sess.sessionTeam == team ) {
			if ( level.clients[i].sess.teamLeader )
				return i;
		}
	}

	return -1;
}


/*
================
PickTeam

================
*/
team_t PickTeam( int ignoreClientNum ) {
	int		counts[TEAM_NUM_TEAMS];

	counts[TEAM_BLUE] = TeamCount( ignoreClientNum, TEAM_BLUE );
	counts[TEAM_RED] = TeamCount( ignoreClientNum, TEAM_RED );

	if ( counts[TEAM_BLUE] > counts[TEAM_RED] ) {
		return TEAM_RED;
	}
	if ( counts[TEAM_RED] > counts[TEAM_BLUE] ) {
		return TEAM_BLUE;
	}
	// equal team count, so join the team with the lowest score
	if ( level.teamScores[TEAM_BLUE] > level.teamScores[TEAM_RED] ) {
		return TEAM_RED;
	}
	return TEAM_BLUE;
}

/*
===========
ForceClientSkin

Forces a client's skin (for teamplay)
===========
*/
/*
static void ForceClientSkin( gclient_t *client, char *model, const char *skin ) {
	char *p;

	if ((p = Q_strrchr(model, '/')) != 0) {
		*p = 0;
	}

	Q_strcat(model, MAX_QPATH, "/");
	Q_strcat(model, MAX_QPATH, skin);
}
*/

/*
===========
ParseBadNames
We can't get any closer to CG_ParseAnimationFile, this damn thing better work
===========
*/ /*
void ParseBadNames (char *p,  int outSize ) {
	char		*text_p, *prev;
		int			length;//, i, j;
		char		*name;//, *Value;
		//char		filePath[MAX_QPATH + 20];
		int			skip;
		char		text[20000];
		char		filename[MAX_QPATH];
		fileHandle_t	f;

		// load the file
		Com_sprintf(filename, sizeof(filename), "config/badnames.cfg");
		length = trap_FS_FOpenFile( filename, &f, FS_READ );
		if ( length <= 0 ) {
			return;
		}
		if ( length >= sizeof( text ) - 1 ) {
			G_Printf( "File too long\n" );
			G_LogPrintf("BadNames.cfg is too long\n");
			return;
		}

		if ( length < 3) {
			return;
		}

		//memset(&text, 0, sizeof(text));
		//memset(&text[0], 0, sizeof(text));
		trap_FS_Read( text, length, f );
		text[length] = 0;
		trap_FS_FCloseFile( f );

		// parse the text
		text_p = text;
		skip = 0;

		// read optional parameters
		while ( 1 ) {
			prev = text_p;	// so we can unget
			name = COM_Parse( &text_p );

			//G_Printf("%s -- ", Name );

			if ( !name || name == 0 ) {
				//FIXME: This doesn't work
				G_LogPrintf("*WORKING* BadNames: String is NULL\n");
				break;
			}

			if ( strlen( name ) < 1 ) {
				G_LogPrintf("*WARNING* BadNames: String length is less than 1\n");
					break;
			}
			if ( strlen( name ) > MAX_NETNAME ) {
				G_LogPrintf("*ERROR* BadNames: String length is too big\n");
				break;
			}

		
			if ( !Q_stricmp(p, name) ) {
				Q_strncpyz( p, "UnnamedPlayer", outSize );
				break;
			}
			//G_Printf("Loop -");
		}
} */

/*
===========
ClientCheckName
============
*/
static void ClientCleanName( const char *in, char *out, int outSize ) {
	int		len, colorlessLen;
	char	ch;
	char	*p;
	int		spaces;
	//qboolean	parseBadNames = qtrue;

	//save room for trailing null byte
	outSize--;

	len = 0;
	colorlessLen = 0;
	p = out;
	*p = 0;
	spaces = 0;

	while( 1 ) {
		ch = *in++;
		if( !ch ) {
			break;
		}

		// don't allow leading spaces
		if( !*p && ch == ' ' ) {
			continue;
		}

		// check colors
		if( ch == Q_COLOR_ESCAPE ) {
			// solo trailing carat is not a color prefix
			if( !*in ) {
				break;
			}

			// don't allow black in a name, period
			//if( ColorIndex(*in) == 0 ) {
			//	in++;
			//	continue;
			//}

			// make sure room in dest for both chars
			if( len > outSize - 2 ) {
				break;
			}

			*out++ = ch;
			*out++ = *in++;
			len += 2;
			continue;
		}

		// don't allow too many consecutive spaces
		if( ch == ' ' ) {
			spaces++;
			if( spaces > 3 ) {
				continue;
			}
		}
		else {
			spaces = 0;
		}

		if( len > outSize - 1 ) {
			break;
		}

		*out++ = ch;
		colorlessLen++;
		len++;
	}
	*out = 0;

	// don't allow empty names
	if( *p == 0 || colorlessLen == 0 || !Q_stricmp(p,"all") || !Q_stricmp(p,"allbots") ) {
		Q_strncpyz( p, "UnnamedPlayer", outSize );
		//parseBadNames = qfalse;
	}
/*
	if ( parseBadNames && CG_FileExists("config/badnames.cfg") && !(trap_Cvar_VariableIntegerValue("disable_badnames")) ) {
		//disallowed names.. This should be a seperate config that gets parsed.
		ParseBadNames(p, outSize);
	} */
}

static void StripFade ( const char *in, char *out, int outSize ) {
	int		len;
	char	ch;
	char	*p;
	qboolean wasFade = qfalse;

	//qboolean	parseBadNames = qtrue;

	//save room for trailing null byte
	outSize--;

	len = 0;
	p = out;
	*p = 0;

	while( 1 ) {
		ch = *in++;
		if( !ch ) {
			break;
		}

		if ( wasFade ) {
			wasFade = qfalse;
			if ( *in == ',' ) {
				continue;
			}
		}

		// check colors
		if( ch == Q_COLOR_ESCAPE ) {
			// solo trailing carat is not a color prefix
			if( !*in ) {
				break;
			}

			// make sure room in dest for both chars
			if( len > outSize - 2 ) {
				break;
			}

			*out++ = ch;
			*out++ = *in++;
			len += 2;
			
			//
			if( !*in ) {
				break;
			}

			if ( (*in == ',' || *in == ':') ) {
				*in++;//Go forward
				if ( !*in ) {
					break;
				}
				if (*in != Q_COLOR_ESCAPE ) {//Check for another color
					*in--;//Go back cuz it's not fading.
				} else {
					wasFade = qtrue;
				}
			}
			continue;
		}

		if( len > outSize - 1 ) {
			break;
		}

		*out++ = ch;
		len++;
			
	}
	*out = 0;
}


/*
===========
ClientUserInfoChanged

Called from ClientConnect when the player first connects and
directly by the server system when the player updates a userinfo variable.

The game can override any of the settings and call trap_SetUserinfo
if desired.
============
*/
void ClientUserinfoChanged( int clientNum ) {
	gentity_t *ent;
	int		teamTask, teamLeader, team, health;
	char	*s;
	char	model[MAX_QPATH];
	char	headModel[MAX_QPATH];
	char	oldname[MAX_STRING_CHARS];
	gclient_t	*client;
	char	c1[MAX_INFO_STRING];
//	char	c2[MAX_INFO_STRING];Evo:Model
	char	redTeam[MAX_INFO_STRING];
	char	blueTeam[MAX_INFO_STRING];
	char	userinfo[MAX_INFO_STRING];
	char	sex[32];

	ent = g_entities + clientNum;
	client = ent->client;

	trap_GetUserinfo( clientNum, userinfo, sizeof( userinfo ) );

	// check for malformed or illegal info strings
	if ( !Info_Validate(userinfo) ) {
		strcpy (userinfo, "\\name\\badinfo");
	}

	// check for local client
	s = Info_ValueForKey( userinfo, "ip" );
	if ( !strcmp( s, "localhost" ) ) {
		client->pers.localClient = qtrue;
	}

	// check the item prediction
	s = Info_ValueForKey( userinfo, "cg_predictItems" );
	if ( !atoi( s ) ) {
		client->pers.predictItemPickup = qfalse;
	} else {
		client->pers.predictItemPickup = qtrue;
	}

//unlagged - client options
	// see if the player has opted out
	//s = Info_ValueForKey( userinfo, "cg_delag" );
	//if ( !atoi( s ) ) {
	//	client->pers.delag = 0;
	//} else {
	//	client->pers.delag = atoi( s );
	//}

	// see if the player is nudging his shots
	//s = Info_ValueForKey( userinfo, "cg_cmdTimeNudge" );
	//client->pers.cmdTimeNudge = atoi( s );

	// see if the player wants to debug the backward reconciliation
	s = Info_ValueForKey( userinfo, "cg_debugDelag" );
	if ( !atoi( s ) ) {
		client->pers.debugDelag = qfalse;
	}
	else {
		client->pers.debugDelag = qtrue;
	}

	// see if the player is simulating incoming latency
	//s = Info_ValueForKey( userinfo, "cg_latentSnaps" );
	//client->pers.latentSnaps = atoi( s );

	// see if the player is simulating outgoing latency
	//s = Info_ValueForKey( userinfo, "cg_latentCmds" );
	//client->pers.latentCmds = atoi( s );

	// see if the player is simulating outgoing packet loss
	//s = Info_ValueForKey( userinfo, "cg_plOut" );
	//client->pers.plOut = atoi( s );
//unlagged - client options
	s = Info_ValueForKey( userinfo, "cg_fixedTeleporterAngles" );
	if ( !atoi( s ) ) {
		client->pers.fixedTeleporterAngles = qfalse;
	} else {
		client->pers.fixedTeleporterAngles = qtrue;
	}

	// set name
	Q_strncpyz ( oldname, client->pers.netname, sizeof( oldname ) );
	s = Info_ValueForKey (userinfo, "name");
	ClientCleanName( s, client->pers.netname, sizeof(client->pers.netname) );
	StripFade(client->pers.netname, client->pers.altnetname, sizeof(client->pers.altnetname));

	if ( !sv_allowUnnamed.integer ) { 
		if ( Q_stricmp(client->pers.netname, "UnnamedPlayer") == 0 ) {
			client->sess.speconly |= 2;
		} else if ( client->sess.speconly & 2 ) {
			client->sess.speconly &= ~2;
		}
	}

	Q_strncpyz( sex, Info_ValueForKey (userinfo, "sex"), sizeof( sex ) );
	//ClientCleanName( s, client->pers.netname, sizeof(client->pers.netname) );

	if ( client->sess.sessionTeam == TEAM_SPECTATOR ) {
		if ( client->sess.spectatorState == SPECTATOR_SCOREBOARD ) {
			Q_strncpyz( client->pers.netname, "scoreboard", sizeof(client->pers.netname) );
		}
	}

	if ( client->pers.connected == CON_CONNECTED ) {
		if ( strcmp( oldname, client->pers.netname ) ) {
			trap_SendServerCommand( -1, va("print \"%s" S_COLOR_WHITE " renamed to %s\n\"", oldname, 
				client->pers.netname) );
		}
	}

	// set max health
#ifdef MISSIONPACK
	if (client->ps.powerups[PW_GUARD]) {
		client->pers.maxHealth = 200;
	} else {
		health = atoi( Info_ValueForKey( userinfo, "handicap" ) );
		client->pers.maxHealth = health;
		if ( client->pers.maxHealth < 1 || client->pers.maxHealth > 100 ) {
			client->pers.maxHealth = 100;
		}
	}
#else
	health = atoi( Info_ValueForKey( userinfo, "handicap" ) );
	client->pers.maxHealth = health;
	if ( gameSettings.spawn_health > 0 && gameSettings.spawn_health != 100 ) {
		client->pers.maxHealth = gameSettings.spawn_health;
	} else
	if ( client->pers.maxHealth < 1 || client->pers.maxHealth > 100 || g_pro_mode.integer || !g_allowHandicap.integer) {
			(client->pers.maxHealth = 100);
	}
#endif
	client->ps.stats[STAT_MAX_HEALTH] = client->pers.maxHealth;

	// set model
	if( g_gametype.integer >= GT_TEAM ) {
		Q_strncpyz( model, Info_ValueForKey (userinfo, "team_model"), sizeof( model ) );
		Q_strncpyz( headModel, Info_ValueForKey (userinfo, "team_headmodel"), sizeof( headModel ) );
	} else {
		Q_strncpyz( model, Info_ValueForKey (userinfo, "model"), sizeof( model ) );
		Q_strncpyz( headModel, Info_ValueForKey (userinfo, "headmodel"), sizeof( headModel ) );
	}

	// bots set their team a few frames later
	if (g_gametype.integer >= GT_TEAM && g_entities[clientNum].r.svFlags & SVF_BOT) {
		s = Info_ValueForKey( userinfo, "team" );
		if ( !Q_stricmp( s, "red" ) || !Q_stricmp( s, "r" ) ) {
			team = TEAM_RED;
		} else if ( !Q_stricmp( s, "blue" ) || !Q_stricmp( s, "b" ) ) {
			team = TEAM_BLUE;
		} else {
			// pick the team with the least number of players
			team = PickTeam( clientNum );
		}
	}
	else {
		team = client->sess.sessionTeam;
	}

/*	NOTE: all client side now

	// team
	switch( team ) {
	case TEAM_RED:
		ForceClientSkin(client, model, "red");
//		ForceClientSkin(client, headModel, "red");
		break;
	case TEAM_BLUE:
		ForceClientSkin(client, model, "blue");
//		ForceClientSkin(client, headModel, "blue");
		break;
	}
	// don't ever use a default skin in teamplay, it would just waste memory
	// however bots will always join a team but they spawn in as spectator
	if ( g_gametype.integer >= GT_TEAM && team == TEAM_SPECTATOR) {
		ForceClientSkin(client, model, "red");
//		ForceClientSkin(client, headModel, "red");
	}
*/

#ifdef MISSIONPACK
	if (g_gametype.integer >= GT_TEAM) {
		client->pers.teamInfo = qtrue;
	} else {
		s = Info_ValueForKey( userinfo, "cg_drawTeamOverlay" );
		if ( ! *s || atoi( s ) != 0 ) {
			client->pers.teamInfo = qtrue;
		} else {
			client->pers.teamInfo = qfalse;
		}
	}
#else
	// teamInfo
	s = Info_ValueForKey( userinfo, "cg_drawTeamOverlay" );
	if ( ! *s || atoi( s ) != 0 ) {
		client->pers.teamInfo = qtrue;
	} else {
		client->pers.teamInfo = qfalse;
	}
#endif
	
	s = Info_ValueForKey( userinfo, "cg_pmove_fixed" );
	if ( !*s || atoi( s ) == 0 ) {
		client->pers.pmoveFixed = qfalse;
	} else {
		client->pers.pmoveFixed = qtrue;
	}

	s = Info_ValueForKey( userinfo, "cg_fastRespawn_override" );
	if ( !*s || atoi( s ) == 0 ) {
		client->pers.fastRespawn = qfalse;
	} else {
		client->pers.fastRespawn = qtrue;
	}
	

	// team task (0 = none, 1 = offence, 2 = defence)
	teamTask = atoi(Info_ValueForKey(userinfo, "teamtask"));
	// team Leader (1 = leader, 0 is normal player)
	teamLeader = client->sess.teamLeader;

	s = Info_ValueForKey (userinfo, "cl_maxpackets"); //FIXME: atoi once?
	ent->client->pers.ping_fix_adjustment = atoi(s)>=80?(15):(0.3 * atoi(s) - 9);

	// see if the player is nudging his shots
	s = Info_ValueForKey( userinfo, "cg_aimNudge" );
	client->pers.cmdTimeNudge = atoi( s );
	client->sess.aimType = atoi(Info_ValueForKey( userinfo, "cg_aimType" ));
	if (client->sess.aimType > g_delagHitscan.integer) {
		client->sess.aimType = g_delagHitscan.integer;
	} else
	if (client->sess.aimType < 0  || client->sess.aimType > 3 ) {
		if ( ent->r.svFlags & SVF_BOT ) {
			client->sess.aimType = 0;
		} else {
			client->sess.aimType = 2;
		}
	}
	//Evo:Model:colors
	/*if ( ent->r.svFlags & SVF_BOT ) {
		strcpy(c1, Info_ValueForKey( userinfo, "color1" ));
		strcpy(c2, Info_ValueForKey( userinfo, "color2" ));
	} else {*/
		strcpy(c1, Info_ValueForKey( userinfo, "colors" ));
	//}
	

	strcpy(redTeam, Info_ValueForKey( userinfo, "g_redteam" ));
	strcpy(blueTeam, Info_ValueForKey( userinfo, "g_blueteam" ));

	// send over a subset of the userinfo keys so other clients can
	// print scoreboards, display models, and play custom sounds
	if ( ent->r.svFlags & SVF_BOT ) {
		s = va("n\\%s\\t\\%i\\model\\%s\\hmodel\\%s\\c1\\%s\\hc\\%i\\w\\%i\\l\\%i\\skill\\%s\\tt\\%d\\tl\\%d",
			client->pers.netname, team, model, headModel, c1,
			client->pers.maxHealth, client->sess.wins, client->sess.losses,
			Info_ValueForKey( userinfo, "skill" ), teamTask, teamLeader );
	} else {
		s = va("n\\%s\\t\\%i\\model\\%s\\hmodel\\%s\\g_redteam\\%s\\g_blueteam\\%s\\c1\\%s\\hc\\%i\\w\\%i\\l\\%i\\tt\\%d\\tl\\%d\\sex\\%s",
			client->pers.netname, client->sess.sessionTeam, model, headModel, redTeam, blueTeam, c1, 
			client->pers.maxHealth, client->sess.wins, client->sess.losses, teamTask, teamLeader, sex);
	}

	trap_SetConfigstring( CS_PLAYERS+clientNum, s );

	// this is not the userinfo, more like the configstring actually
	G_LogPrintf( "ClientUserinfoChanged: %i %s\n", clientNum, s );
}


/*
===========
ClientConnect

Called when a player begins connecting to the server.
Called again for every map change or tournement restart.

The session information will be valid after exit.

Return NULL if the client should be allowed, otherwise return
a string with the reason for denial.

Otherwise, the client will be sent the current gamestate
and will eventually get to ClientBegin.

firstTime will be qtrue the very first time a client connects
to the server machine, but qfalse on map changes and tournement
restarts.
============
*/
int CheckBans( char *ip ) {
	int i = 0;
	int j = 0;

	for (i = 0; i < NUM_BANS; i++) {
		if ( strlen(bans[i].ip) > 2) {
			for ( j = 0; j <= strlen(bans[i].ip); j++ ) {
				//G_Printf("%i - %i -- %s - %s\n", strlen(bans[i].ip), j, ip[j], bans[i].ip[j] );
				if ( bans[i].ip[j] == '*' ) {
					//G_Printf("foundSubNet\n");
					if ( bans[i].time > 0 ) {
						if ( bans[i].time - getTimeDiff() <= 0 ) {
							break;
						}
					}
					return i;
				} else if ( ip[j] == bans[i].ip[j]) {
					if ( j == strlen(bans[i].ip)-1 ) {
						//G_Printf("Ban matched and no subnet added\n");
						if ( bans[i].time > 0 ) {
							if ( bans[i].time - getTimeDiff() <= 0 ) {
								break;
							}
						}
						return i;
					}
				} else if (ip[j] != bans[i].ip[j]) {
					break;
				}
			}
		}
	}
	return -1;
}

char *ClientConnect( int clientNum, qboolean firstTime, qboolean isBot ) {
	char		*value;
//	char		*areabits;
	gclient_t	*client;
	char		userinfo[MAX_INFO_STRING];
	gentity_t	*ent;
	char		ip[128];
	int			ban = -1;

	ent = &g_entities[ clientNum ];

	//Set bots to ready and normal clients to notready
	
	if (isBot) {
		level.clients[ent-g_entities].playerReady = qtrue;
		level.totalReady++;
	} else {
		level.clients[ent-g_entities].playerReady = qfalse;
	}
	trap_GetUserinfo( clientNum, userinfo, sizeof( userinfo ) );

 	// IP filtering
 	// https://zerowing.idsoftware.com/bugzilla/show_bug.cgi?id=500
 	// recommanding PB based IP / GUID banning, the builtin system is pretty limited
 	// check to see if they are on the banned IP list
	value = Info_ValueForKey (userinfo, "ip");
	//ip = Info_ValueForKey (userinfo, "ip");
	Com_sprintf(ip, 128, value);
	/*if ( G_FilterPacket( value ) ) {
		return "You are banned from this server.";
	}*/

	ban = CheckBans(ip);
	if ( ban >= 0 && bans[ban].type & 1) {
		static char banMessage[1024];
		//char *msg;

		Com_sprintf(banMessage, sizeof(banMessage), "You have been banned:\n%s", bans[ban].message);
		//return sv_banMsg.string;
		/*trap_DropClient(clientNum, banMessage);
		return NULL;*/
		//msg = banMessage;
		return banMessage;
	}

  // we don't check password for bots and local client
  // NOTE: local client <-> "ip" "localhost"
  //   this means this client is not running in our current process
	//if ( (!( ent->r.svFlags & SVF_BOT ) || !isBot) && (strcmp(value, "localhost") != 0)) {
	if ( !isBot && (strcmp(value, "localhost") != 0) ) {
		// check for a password
		value = Info_ValueForKey (userinfo, "password");
		if ( g_password.string[0] && Q_stricmp( g_password.string, "none" ) &&
			strcmp( g_password.string, value) != 0) {
			return "Invalid password";
		}
	}

	// they can connect
	ent->client = level.clients + clientNum;
	client = ent->client;

	if ( ban >= 0 && bans[ban].type & 2 ) {
		client->sess.speconly |= 2;
	}

	if ( !isBot ) {
		value = Info_ValueForKey (userinfo, "cl_maxpackets"); //FIXME: atoi once?
		ent->client->pers.ping_fix_adjustment = atoi(value)>=80?(15):(0.3 * atoi(value) - 9);
	}

	ent->client->naft[0] = ent->client->naft[1] = 0;

//	areabits = client->areabits;

	memset( client, 0, sizeof(*client) );

	client->pers.connected = CON_CONNECTING;

	// read or initialize the session data
	if ( isBot || firstTime || (level.newSession && !( (g_gametype.integer == GT_CTF || g_gametype.integer == GT_TEAM) && (level.gt == GT_CTF || level.gt == GT_TEAM) ) )) {
		G_InitSessionData( client, userinfo );
	} //else {
		//client->sess.losses = 0;
		//client->sess.wins = 0;
		//client->sess.teamLeader = qfalse;
		//client->sess.spectatorClient = 0;//-1?
		//client->sess.spectatorState = SPECTATOR_FREE;//SPECTATOR_NOT?
		//client->sess.spectatorTime = 0;
	//}
	G_ReadSessionData( client );
//freeze
	if ( g_gamemode.integer > 3 ) {
		if ( g_gametype.integer != GT_TOURNAMENT ) {
			client->sess.wins = 0;
		}
		ent->freezeState = qfalse;
		ent->readyBegin = qfalse;
	}
//freeze

	if( isBot ) {
		ent->r.svFlags |= SVF_BOT;
		ent->inuse = qtrue;
		if( !G_BotConnect( clientNum, !firstTime ) ) {
			return "BotConnectfailed";
		}
	}

	// get and distribute relevent paramters
	if (!isBot) {
		sscanf(ip, "%d.%d.%d.%d", &client->pers.ip[0], &client->pers.ip[1], &client->pers.ip[2], &client->pers.ip[3]);
		value = Info_ValueForKey( userinfo, "cl_guid" );
		G_LogPrintf( "ClientDetails: ip\\%s\\id\\%i\\guid\\%s\n", ip, clientNum, value);
	}
	G_LogPrintf( "ClientConnect: %i\n", clientNum );
	ClientUserinfoChanged( clientNum );

	// don't do the "xxx connected" messages if they were caried over from previous level
	if ( firstTime ) {
		trap_SendServerCommand( -1, va("print \"%s" S_COLOR_WHITE " connected\n\"", client->pers.netname) );
	}

	if ( g_gametype.integer >= GT_TEAM &&
		client->sess.sessionTeam != TEAM_SPECTATOR ) {
		BroadcastTeamChange( client, -1 );
	}

	// count current clients and rank for scoreboard
	CalculateRanks();

	// for statistics
//	client->areabits = areabits;
//	if ( !client->areabits )
//		client->areabits = G_Alloc( (trap_AAS_PointReachabilityAreaIndex( NULL ) + 7) / 8 );

//unlagged - backward reconciliation #5
	// announce it
	if ( firstTime ) {
		if ( g_delagHitscan.integer ) {
			trap_SendServerCommand( clientNum, "print \"This server is Unlagged: full lag compensation is ON!\n\"" );
		} else {
			trap_SendServerCommand( clientNum, "print \"This server is Unlagged: full lag compensation is OFF!\n\"" );
		}
//unlagged - backward reconciliation #5

		trap_SendServerCommand( ent-g_entities, va("motd \"%s\" \"%s\" \"%s\" \"%s\" \"%s\" \"%s\" \"%s\" \"%s\"", 
			sv_motd1.string,
			sv_motd2.string,
			sv_motd3.string,
			sv_motd4.string,
			sv_motd5.string,
			sv_motd6.string,
			sv_motd7.string,
			sv_motd8.string) );

	//Mod messages
	//if ( firstTime ) {
		trap_SendServerCommand( clientNum, va("print \"This server is running %s %s\nPlease visit http://www.quake-revolution.net for details. Please also post questions, comments, suggestions, or bug reports on the forums -Thanks.\n\"", GAMEVERSION, BUILDINFO) );
	}

	if ( g_muteTourneyspecs.integer == 0 && g_gametype.integer == 1 ) {
		trap_SendServerCommand( clientNum, "print \"Tournament spectators are not muted.\n\"" );
	}
	if ( g_muteSpecs.integer == 1 && g_gametype.integer != 1 ) {
		trap_SendServerCommand( clientNum, "print \"Spectators are muted.\n\"" );
	}

	//#################
	//# Send client cvar information
	//if ( g_dedicated.integer ) {
	//FIXME: sv_Fps doesn't need to be sent anymore
		trap_SendServerCommand( clientNum, va("connUCv %i %i %i %i %i %i %i %i %i %i %i %i %i\n",
			sv_minRate.integer,
			sv_lock_cg_railHum_to.integer,
			weap_gauntletCycle.integer,
			weap_machinegunCycle.integer,
			weap_shotgunCycle.integer,
			weap_grenadelauncherCycle.integer,
			weap_lightninggunCycle.integer,
			weap_rocketlauncherCycle.integer,
			weap_railgunCycle.integer,
			weap_plasmagunCycle.integer,
			weap_bfgCycle.integer,
			g_DynamicGauntletCycle.integer,
			weap_allowed.integer) );
	//}
	//#
	//#################

		//Send vote information of one is in progress..
		if (level.voteTime) {
			trap_SendServerCommand( clientNum, va("vt \"%i %s\n\"", level.voteTime, level.voteDisplayString) );
			trap_SendServerCommand( clientNum, va("vt \"%i %i\n\"", level.voteYes, level.voteNo) );
		} else if (level.teamVoteTime[TEAM_RED-1]) {
			trap_SendServerCommand( clientNum, va("tv \"%i %i %i\n\"", TEAM_RED-1, level.teamVoteTime[TEAM_RED-1], level.teamVoteString[TEAM_RED-1]) );
			trap_SendServerCommand( clientNum, va("tv \"%i %i %i\n\"", TEAM_RED-1, level.teamVoteYes[TEAM_RED-1], level.teamVoteNo[TEAM_RED-1]) );
		} else if (level.teamVoteTime[TEAM_BLUE-1]) {
			trap_SendServerCommand( clientNum, va("tv \"%i %i %i\n\"", TEAM_BLUE-1, level.teamVoteTime[TEAM_BLUE-1], level.teamVoteString[TEAM_BLUE-1]) );
			trap_SendServerCommand( clientNum, va("tv \"%i %i %i\n\"", TEAM_BLUE-1, level.teamVoteYes[TEAM_BLUE-1], level.teamVoteNo[TEAM_BLUE-1]) );
		}


	return NULL;
}

/*
===========
ClientBegin

called when a client has finished connecting, and is ready
to be placed into the level.  This will happen every level load,
and on transition between teams, but doesn't happen on respawns
============
*/
void ClientBegin( int clientNum ) {
	gentity_t	*ent;
	gclient_t	*client;
	gentity_t	*tent;
	int			flags;

	ent = g_entities + clientNum;

	client = level.clients + clientNum;

	if ( ent->r.linked ) {
		//ent->relink = 0;
		trap_UnlinkEntity( ent );
	}
	G_InitGentity( ent );
	ent->touch = 0;
	ent->pain = 0;
	ent->client = client;

	client->pers.connected = CON_CONNECTED;
	client->pers.enterTime = level.time;
	client->pers.teamState.state = TEAM_BEGIN;
	//client->pers.last_Event = -1;

	// save eflags around this, because changing teams will
	// cause this to happen with a valid entity, and we
	// want to make sure the teleport bit is set right
	// so the viewpoint doesn't interpolate through the
	// world to the new position
	flags = client->ps.eFlags;
	memset( &client->ps, 0, sizeof( client->ps ) );
	client->ps.eFlags = flags;

	// locate ent at a spawn point
	ClientSpawn( ent );

	if ( client->sess.sessionTeam != TEAM_SPECTATOR ) {
		// send event
		tent = G_TempEntity( ent->client->ps.origin, EV_PLAYER_TELEPORT_IN );
		tent->s.clientNum = ent->s.clientNum;

		if ( g_gametype.integer != GT_TOURNAMENT  ) {
			trap_SendServerCommand( -1, va("print \"%s" S_COLOR_WHITE " entered the game\n\"", client->pers.netname) );
		}
	}
	G_LogPrintf( "ClientBegin: %i\n", clientNum );

	// count current clients and rank for scoreboard
	CalculateRanks();
}

/*
===========
ClientSpawn

Called every time a client is placed fresh in the world:
after the first ClientBegin, and after each respawn
Initializes all non-persistant parts of playerState
============
*/
void ClientSpawn(gentity_t *ent) {
	int		index;
	vec3_t	spawn_origin, spawn_angles;
	gclient_t	*client;
	int		i;
	clientPersistant_t	saved;
	clientSession_t		savedSess;
	int		persistant[MAX_PERSISTANT];
	gentity_t	*spawnPoint;
	int		flags;
	int		savedPing;
//	char	*savedAreaBits;
	int		accuracy_hits, accuracy_shots;
	int		eventSequence;
	char	userinfo[MAX_INFO_STRING];

	index = ent - g_entities;
	client = ent->client;

	ent->deathCounted = qfalse;

	// find a spawn point
	// do it before setting health back up, so farthest
	// ranging doesn't count this client
	if ( client->sess.sessionTeam == TEAM_SPECTATOR ) {
		spawnPoint = SelectSpectatorSpawnPoint ( 
						spawn_origin, spawn_angles);
	} else if (g_gametype.integer >= GT_CTF ) {
		// all base oriented team games use the CTF spawn points
		spawnPoint = SelectCTFSpawnPoint ( 
						client->sess.sessionTeam, 
						client->pers.teamState.state, 
						spawn_origin, spawn_angles);
	} else {
		do {
			// the first spawn should be at a good looking spot
			if ( !client->pers.initialSpawn && client->pers.localClient ) {
				client->pers.initialSpawn = qtrue;
				spawnPoint = SelectInitialSpawnPoint( spawn_origin, spawn_angles );
			} else {
				// don't spawn near existing origin if possible
				spawnPoint = SelectSpawnPoint ( 
					client->ps.origin, 
					spawn_origin, spawn_angles);
			}

			// Tim needs to prevent bots from spawning at the initial point
			// on q3dm0...
			if ( ( spawnPoint->flags & FL_NO_BOTS ) && ( ent->r.svFlags & SVF_BOT ) ) {
				continue;	// try again
			}
			// just to be symetric, we have a nohumans option...
			if ( ( spawnPoint->flags & FL_NO_HUMANS ) && !( ent->r.svFlags & SVF_BOT ) ) {
				continue;	// try again
			}

			break;

		} while ( 1 );
	}
	client->pers.teamState.state = TEAM_ACTIVE;

	// always clear the kamikaze flag
	ent->s.eFlags &= ~EF_KAMIKAZE;

	// toggle the teleport bit so the client knows to not lerp
	// and never clear the voted flag
	flags = ent->client->ps.eFlags & (EF_TELEPORT_BIT | EF_VOTED | EF_TEAMVOTED);
	flags ^= EF_TELEPORT_BIT;

//unlagged - backward reconciliation #3
	// we don't want players being backward-reconciled to the place they died
	G_ResetHistory( ent );
	// and this is as good a time as any to clear the saved state
	ent->client->saved.leveltime = 0;
//unlagged - backward reconciliation #3

	// clear everything but the persistant data

	saved = client->pers;
	savedSess = client->sess;
	savedPing = client->ps.ping;
//	savedAreaBits = client->areabits;
	accuracy_hits = client->accuracy_hits;
	accuracy_shots = client->accuracy_shots;
	for ( i = 0 ; i < MAX_PERSISTANT ; i++ ) {
		persistant[i] = client->ps.persistant[i];
	}
	eventSequence = client->ps.eventSequence;

	memset (client, 0, sizeof(*client)); // bk FIXME: Com_Memset?

	client->pers = saved;
	client->sess = savedSess;
	client->ps.ping = savedPing;
//	client->areabits = savedAreaBits;
	client->accuracy_hits = accuracy_hits;
	client->accuracy_shots = accuracy_shots;
	client->lastkilled_client = -1;

	for ( i = 0 ; i < MAX_PERSISTANT ; i++ ) {
		client->ps.persistant[i] = persistant[i];
	}
	client->ps.eventSequence = eventSequence;
	// increment the spawncount so the client will detect the respawn
	client->ps.persistant[PERS_SPAWN_COUNT]++;
	client->ps.persistant[PERS_TEAM] = client->sess.sessionTeam;

	client->airOutTime = level.time + 12000;

	trap_GetUserinfo( index, userinfo, sizeof(userinfo) );
	// set max health
	client->pers.maxHealth = atoi( Info_ValueForKey( userinfo, "handicap" ) );
	if ( client->pers.maxHealth < 1 || client->pers.maxHealth > 100 ) {
		client->pers.maxHealth = 100;
	}
	//FIXME: Better method?
	client->ps.stats[STAT_ARMOR] = gameSettings.spawn_armor;

	
	//client->ps.stats[STAT_MAX_HEALTH] = trap_Cvar_VariableIntegerValue("spawn_health");

	client->ps.stats[STAT_MAX_HEALTH] = client->pers.maxHealth;
	client->ps.eFlags = flags;

	ent->s.groundEntityNum = ENTITYNUM_NONE;
	ent->client = &level.clients[index];
	ent->takedamage = qtrue;
	ent->inuse = qtrue;
	ent->classname = "player";
	ent->r.contents = CONTENTS_BODY;
	ent->clipmask = MASK_PLAYERSOLID;
	ent->die = player_die;
	ent->waterlevel = 0;
	ent->watertype = 0;
	ent->flags = 0;
	
	VectorCopy (playerMins, ent->r.mins);
	VectorCopy (playerMaxs, ent->r.maxs);

	client->ps.clientNum = index;

	//Instagib or InstaFreeze or Railz or Rockets'n'Rails
	if ( g_gamemode.integer != 0 && g_gamemode.integer != 4 ) {
		//If it's an allowed weapon and it's after any possible change, they can have it.
		int i = 0;
		for ( i = WP_GAUNTLET; i < WP_BFG + 1; i++ ) {
			if ( weap_allowed.integer & (1 << (i - 1)) ) {
				client->ps.stats[STAT_WEAPONS] |= ( 1 << i );
				level.stats_picked |= 1 << (i - 1);
				if ( g_gamemode.integer == 2 ) {
					client->ps.ammo[i] = 25;
				} else {
					client->ps.ammo[i] = INFINITE;
				}
			}
		}
	} else {
		//Normal baseq3 or freeze
		if ( weap_allowed.integer & 1 ) {
			client->ps.stats[STAT_WEAPONS] |= ( 1 << WP_GAUNTLET );
			client->ps.ammo[WP_GAUNTLET] = -1;
			level.stats_picked |= (1 << (WP_GAUNTLET - 1));
		}

		if ( weap_allowed.integer & 2 ) {
			client->ps.stats[STAT_WEAPONS] |= ( 1 << WP_MACHINEGUN );
			level.stats_picked |= (1 << (WP_MACHINEGUN - 1));

			if ( g_gamemode.integer == 1 || g_gamemode.integer == 5 ) {
				client->ps.ammo[WP_MACHINEGUN] = INFINITE;
			} else if ( g_gametype.integer == GT_TEAM ) {
				client->ps.ammo[WP_MACHINEGUN] = 50;
			} else {
				client->ps.ammo[WP_MACHINEGUN] = cpm_MGweapon; // CPM
			}
		}
	}

	if( weap_enableHook.integer != 0 ) {
		client->ps.ammo[WP_GRAPPLING_HOOK] = -1;
		if( weap_enableHook.integer == 2 ) {//only give the hook weapon when hook mode is 2
			client->ps.stats[STAT_WEAPONS] |= ( 1 << WP_GRAPPLING_HOOK );
		}
	}

	if ( g_spawnProtection.integer ) {
		client->ps.powerups[PW_BATTLESUIT] = level.time + g_spawnProtection.integer * 1000;
		client->spawnProtection = qtrue;
	}
	client->firstframe = 1;
	client->ps.ammo[WP_GRAPPLING_HOOK] = -1;

	// health will count down towards max_health
	//ent->health = client->ps.stats[STAT_HEALTH] = client->ps.stats[STAT_MAX_HEALTH] + 25;
	ent->health = client->ps.stats[STAT_HEALTH] = client->ps.stats[STAT_MAX_HEALTH] * cpm_respawnhealth; // CPM

	G_SetOrigin( ent, spawn_origin );
	VectorCopy( spawn_origin, client->ps.origin );

	// the respawned flag will be cleared after the attack and jump keys come up
	client->ps.pm_flags |= PMF_RESPAWNED;

	trap_GetUsercmd( client - level.clients, &ent->client->pers.cmd );
	SetClientViewAngle( ent, spawn_angles );

/*freeze
	if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
freeze*/
	if ( ( g_gamemode.integer > 3 && is_spectator( client ) ) || 
		( g_gamemode.integer < 4 && ent->client->sess.sessionTeam == TEAM_SPECTATOR ) ) {
//freeze

	} else {
		G_KillBox( ent );
		trap_LinkEntity (ent);

		// force the base weapon up
		client->ps.weapon = WP_MACHINEGUN;
		client->ps.weaponstate = WEAPON_READY;

	}

	// don't allow full run speed for a bit
	client->ps.pm_flags |= PMF_TIME_KNOCKBACK;
	client->ps.pm_time = 100;

	client->respawnTime = level.time;
	client->inactivityTime = level.time + g_inactivity.integer * 1000;
	client->latched_buttons = 0;

	// set default animations
	client->ps.torsoAnim = TORSO_STAND;
	client->ps.legsAnim = LEGS_IDLE;

	if ( level.intermissiontime ) {
		MoveClientToIntermission( ent );
	} else {
		// fire the targets of the spawn point
		G_UseTargets( spawnPoint, ent );

		// select the highest weapon number available, after any
		// spawn given items have fired
		client->ps.weapon = 1;
		for ( i = WP_NUM_WEAPONS - 1 ; i > 0 ; i-- ) {
			if ( client->ps.stats[STAT_WEAPONS] & ( 1 << i ) ) {
				client->ps.weapon = i;
				break;
			}
		}
//freeze
		if ( g_gamemode.integer == 4 && client->ps.stats[ STAT_WEAPONS ] & ( 1 << WP_ROCKET_LAUNCHER ) ) {
			client->ps.weapon = WP_ROCKET_LAUNCHER;
		}
/*
		if ( g_startArmor.integer > 0 ) {
			client->ps.stats[ STAT_ARMOR ] += g_startArmor.integer;
			if ( client->ps.stats[ STAT_ARMOR ] > client->ps.stats[ STAT_MAX_HEALTH ] * 2 ) {
				client->ps.stats[ STAT_ARMOR ] = client->ps.stats[ STAT_MAX_HEALTH ] * 2;
			}
		}*/
//freeze
	}

	// run a client frame to drop exactly to the floor,
	// initialize animations and other things
	client->ps.commandTime = level.time - 100;
	ent->client->pers.cmd.serverTime = level.time;
	ClientThink( ent-g_entities );

	// positively link the client, even if the command times are weird
/*freeze
	if ( ent->client->sess.sessionTeam != TEAM_SPECTATOR ) {
freeze*/
	if ( (g_gamemode.integer > 3 && !is_spectator( client )) || 
		(g_gamemode.integer < 4 && ent->client->sess.sessionTeam != TEAM_SPECTATOR) ) {
//freeze
		BG_PlayerStateToEntityState( &client->ps, &ent->s, qtrue );
		VectorCopy( ent->client->ps.origin, ent->r.currentOrigin );
		trap_LinkEntity( ent );
	}

	// run the presend to set anything else
	ClientEndFrame( ent );

	// clear entity state values
	BG_PlayerStateToEntityState( &client->ps, &ent->s, qtrue );
}


/*
===========
ClientDisconnect

Called when a player drops from the server.
Will not be called between levels.

This should NOT be called directly by any game logic,
call trap_DropClient(), which will call this and do
server system housekeeping.
============
*/
void ClientDisconnect( int clientNum ) {
	gentity_t	*ent;
	gentity_t	*tent;
	int			i, team;

	// mod code start
//	char		buffer[100];
	// mod code end


	//FIXME: This shouldn't be like this, it should be for the one team required..
	CheckForAutoUnlock(TEAM_RED);
	CheckForAutoUnlock(TEAM_BLUE);
	CheckForAutoUnlock(TEAM_FREE);

	// cleanup if we are kicking a bot that
	// hasn't spawned yet
	G_RemoveQueuedBotBegin( clientNum );

	ent = g_entities + clientNum;
	if ( !ent->client ) {
		return;
	}
	if ( level.clients[ent-g_entities].playerReady&& level.warmupTime >= 1 ) {
		level.totalReady--;
	}

	team = ent->client->sess.sessionTeam;

	// stop any following clients
	for ( i = 0 ; i < level.maxclients ; i++ ) {
/*freeze
		if ( level.clients[i].sess.sessionTeam == TEAM_SPECTATOR
freeze*/
		if ( (g_gamemode.integer > 3 && is_spectator( &level.clients[ i ]) || 
			(g_gamemode.integer < 4 && level.clients[i].sess.sessionTeam == TEAM_SPECTATOR) )
//freeze
			&& level.clients[i].sess.spectatorState == SPECTATOR_FOLLOW
			&& level.clients[i].sess.spectatorClient == clientNum ) {
			StopFollowing( &g_entities[i] );
		}
	}

	// send effect if they were completely connected
	if ( ent->client->pers.connected == CON_CONNECTED 
/*freeze
		&& ent->client->sess.sessionTeam != TEAM_SPECTATOR ) {
freeze*/
		&& ((g_gamemode.integer > 3 && !is_spectator( ent->client )) || (g_gamemode.integer < 4 && ent->client->sess.sessionTeam != TEAM_SPECTATOR)) ) {
//freeze
		tent = G_TempEntity( ent->client->ps.origin, EV_PLAYER_TELEPORT_OUT );
		tent->s.clientNum = ent->s.clientNum;

		// They don't get to take powerups with them!
		// Especially important for stuff like CTF flags
		TossClientItems( ent );
#ifdef MISSIONPACK
		TossClientPersistantPowerups( ent );
		if( g_gametype.integer == GT_HARVESTER ) {
			TossClientCubes( ent );
		}
#endif

	}

	G_LogPrintf( "ClientDisconnect: %i\n", clientNum );

	// if we are playing in tourney mode and losing, give a win to the other player
	if ( (g_gametype.integer == GT_TOURNAMENT )
		&& !level.intermissiontime
		&& !level.warmupTime && level.sortedClients[1] == clientNum ) {
		level.clients[ level.sortedClients[0] ].sess.wins++;
		ClientUserinfoChanged( level.sortedClients[0] );
	}

	//ent->relink = 0;
	trap_UnlinkEntity (ent);
	ent->s.modelindex = 0;
	ent->inuse = qfalse;
	ent->classname = "disconnected";
	ent->client->pers.connected = CON_DISCONNECTED;
	ent->client->ps.persistant[PERS_TEAM] = TEAM_FREE;
	ent->client->sess.sessionTeam = TEAM_FREE;
	CheckForAutoUnlock(team); //Check for autounlock

	trap_SetConfigstring( CS_PLAYERS + clientNum, "");

	CalculateRanks();

	if ( ent->r.svFlags & SVF_BOT ) {
		BotAIShutdownClient( clientNum, qfalse );
	}
}


