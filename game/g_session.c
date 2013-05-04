// Copyright (C) 1999-2000 Id Software, Inc.
//
#include "g_local.h"


/*
=======================================================================

  SESSION DATA

Session data is the only data that stays persistant across level loads
and tournament restarts.
=======================================================================
*/

/*
================
G_WriteClientSessionData

Called on game shutdown
================
*/
void G_WriteClientSessionData( gclient_t *client ) {
	const char	*s;
	const char	*var;

	s = va("%i %i %i %i %i %i %i %i %i %i", 
		client->sess.sessionTeam,
		client->sess.spectatorTime,
		client->sess.spectatorState,
		client->sess.spectatorClient,
		client->sess.wins,
		client->sess.losses,
		client->sess.teamLeader,
		client->sess.isAdmin,
		client->sess.speconly,
		client->pers.altConsoleSayMode
		);

	var = va( "session%i", client - level.clients );

	trap_Cvar_Set( var, s );
}

/*
================
G_ReadSessionData

Called on a reconnect
================
*/
void G_ReadSessionData( gclient_t *client ) {
	char	s[MAX_STRING_CHARS];
	const char	*var;

	// bk001205 - format
	int teamLeader;
	int spectatorState;
	int sessionTeam;
	int	isAdmin;
//	int speconly;
	int altConsoleSayMode;

	var = va( "session%i", client - level.clients );
	trap_Cvar_VariableStringBuffer( var, s, sizeof(s) );

	sscanf( s, "%i %i %i %i %i %i %i %i %i %i",
		&sessionTeam,                 // bk010221 - format
		&client->sess.spectatorTime,
		&spectatorState,              // bk010221 - format
		&client->sess.spectatorClient,
		&client->sess.wins,
		&client->sess.losses,
		&teamLeader,                   // bk010221 - format
		&isAdmin,
		&client->sess.speconly,
		&altConsoleSayMode
		);

	// bk001205 - format issues
	client->sess.sessionTeam = (team_t)sessionTeam;
	client->sess.spectatorState = (spectatorState_t)spectatorState;
	client->sess.teamLeader = (qboolean)teamLeader;
	client->sess.isAdmin = (qboolean)isAdmin;
	//client->sess.speconly = (qboolean)speconly;
	client->pers.altConsoleSayMode = (qboolean)altConsoleSayMode;
}

/*
================
G_WriteTaskData

Called on game shutdown
================
*/
void G_WriteTaskData( void ) {
	const char	*s;
	const char	*var;
	int i;

	for ( i = 0; i < MAX_SERVER_TASKS; i++ ) {
		s = va("%i %i %i %s",
			tasks[i].sv_task_runTime,
			tasks[i].sv_task_repeatTime,
			tasks[i].sv_task_startTime,
			tasks[i].sv_task_command
			);

		var = va( "task%i", i );
		trap_Cvar_Set( var, s );
	}
}

/*
================
G_ReadTaskData

Called on... dunno yet
================
*/
void G_ReadTaskData( int taskNum ) {
	char	s[MAX_STRING_CHARS];
	char	*s1;
	const char	*var;
	char	*token;

//	char cmd[MAX_STRING_CHARS];

	var = va( "task%i", taskNum );
	trap_Cvar_VariableStringBuffer( var, s, sizeof(s) );

	s1 = s;
	token = COM_Parse( &s1 );
	tasks[taskNum].sv_task_runTime = atoi(token);
	token = COM_Parse( &s1 );
	tasks[taskNum].sv_task_repeatTime = atoi(token);
	token = COM_Parse( &s1 );
	tasks[taskNum].sv_task_startTime = atoi(token);

	strcpy(tasks[taskNum].sv_task_command, s1);
}

/*
================
G_WriteClientSessionData

Called on game shutdown
================
*/
void G_WriteGameSettings() {
	const char	*s;
	const char	*var = "rvogs1";
	const char	*var1 = "rvogs2";

	//trap_Cvar_VariableStringBuffer( var, s, sizeof(s) );
	s = va("%i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i", 
		gameSettings.missiles[GS_GRENADE][GS_DAMAGE],
		gameSettings.missiles[GS_GRENADE][GS_SPLASH_DAMAGE],
		gameSettings.missiles[GS_GRENADE][GS_SPEED],
		gameSettings.missiles[GS_GRENADE][GS_TIME],
		gameSettings.missiles[GS_GRENADE][GS_RADIUS],
		//5
		gameSettings.missiles[GS_ROCKET][GS_DAMAGE],
		gameSettings.missiles[GS_ROCKET][GS_SPLASH_DAMAGE],
		gameSettings.missiles[GS_ROCKET][GS_SPEED],
		gameSettings.missiles[GS_ROCKET][GS_TIME],
		gameSettings.missiles[GS_ROCKET][GS_RADIUS],
		//10
		gameSettings.missiles[GS_PLASMA][GS_DAMAGE],
		gameSettings.missiles[GS_PLASMA][GS_SPLASH_DAMAGE],
		gameSettings.missiles[GS_PLASMA][GS_SPEED],
		gameSettings.missiles[GS_PLASMA][GS_TIME],
		gameSettings.missiles[GS_PLASMA][GS_RADIUS],
		//15
		gameSettings.missiles[GS_BFG][GS_DAMAGE],
		gameSettings.missiles[GS_BFG][GS_SPLASH_DAMAGE],
		gameSettings.missiles[GS_BFG][GS_SPEED],
		gameSettings.missiles[GS_BFG][GS_TIME],
		gameSettings.missiles[GS_BFG][GS_RADIUS]
		//20
		);
	trap_Cvar_Set( var, s );


	s = va("%i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i",
		gameSettings.hitscans[GS_GAUNTLET][GS_DAMAGE],
		gameSettings.hitscans[GS_GAUNTLET][GS_RANGE],
		//22
		gameSettings.hitscans[GS_MACHINEGUN][GS_DAMAGE],
		gameSettings.hitscans[GS_MACHINEGUN][GS_RANGE],
		//24
		gameSettings.hitscans[GS_SHOTGUN][GS_DAMAGE],
		gameSettings.hitscans[GS_SHOTGUN][GS_RANGE],
		//26
		gameSettings.hitscans[GS_LIGHTNING][GS_DAMAGE],
		gameSettings.hitscans[GS_LIGHTNING][GS_RANGE],
		//28
		gameSettings.hitscans[GS_RAILGUN][GS_DAMAGE],
		gameSettings.hitscans[GS_RAILGUN][GS_RANGE],
		//30
		gameSettings.hook_speed,
		gameSettings.quadfactor_radius,
		gameSettings.allowTossflag,
		gameSettings.spawn_armor,
		gameSettings.spawn_health,
		gameSettings.wasPreviousSession,
		gameSettings.ping_fix,
		level.team_Locked[TEAM_FREE],
		level.team_Locked[TEAM_RED],
		level.team_Locked[TEAM_BLUE]
		//40
		);
	trap_Cvar_Set( var1, s );
}

/*
================
G_ReadGameSettings

Called on... dunno yet
================
*/
void G_ReadGameSetings() {
	char	s[MAX_STRING_CHARS];
	const char	*var = "rvogs1";
	const char	*var1 = "rvogs2";

	int	wasPreviousSession;
	int	quadfactor_radius;
	int	allowTossflag;
	int	ping_fix;
	int	team_Locked[TEAM_NUM_TEAMS];

	trap_Cvar_VariableStringBuffer( var, s, sizeof(s) );
	sscanf( s, "%i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i", 
		&gameSettings.missiles[GS_GRENADE][GS_DAMAGE],
		&gameSettings.missiles[GS_GRENADE][GS_SPLASH_DAMAGE],
		&gameSettings.missiles[GS_GRENADE][GS_SPEED],
		&gameSettings.missiles[GS_GRENADE][GS_TIME],
		&gameSettings.missiles[GS_GRENADE][GS_RADIUS],
		//5
		&gameSettings.missiles[GS_ROCKET][GS_DAMAGE],
		&gameSettings.missiles[GS_ROCKET][GS_SPLASH_DAMAGE],
		&gameSettings.missiles[GS_ROCKET][GS_SPEED],
		&gameSettings.missiles[GS_ROCKET][GS_TIME],
		&gameSettings.missiles[GS_ROCKET][GS_RADIUS],
		//10
		&gameSettings.missiles[GS_PLASMA][GS_DAMAGE],
		&gameSettings.missiles[GS_PLASMA][GS_SPLASH_DAMAGE],
		&gameSettings.missiles[GS_PLASMA][GS_SPEED],
		&gameSettings.missiles[GS_PLASMA][GS_TIME],
		&gameSettings.missiles[GS_PLASMA][GS_RADIUS],
		//15
		&gameSettings.missiles[GS_BFG][GS_DAMAGE],
		&gameSettings.missiles[GS_BFG][GS_SPLASH_DAMAGE],
		&gameSettings.missiles[GS_BFG][GS_SPEED],
		&gameSettings.missiles[GS_BFG][GS_TIME],
		&gameSettings.missiles[GS_BFG][GS_RADIUS]
		//20
		);

	memset(s, 0, sizeof(s));
	trap_Cvar_VariableStringBuffer( var1, s, sizeof(s) );
	sscanf(s, "%i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i",
		&gameSettings.hitscans[GS_GAUNTLET][GS_DAMAGE],
		&gameSettings.hitscans[GS_GAUNTLET][GS_RANGE],
		//22
		&gameSettings.hitscans[GS_MACHINEGUN][GS_DAMAGE],
		&gameSettings.hitscans[GS_MACHINEGUN][GS_RANGE],
		//24
		&gameSettings.hitscans[GS_SHOTGUN][GS_DAMAGE],
		&gameSettings.hitscans[GS_SHOTGUN][GS_RANGE],
		//26
		&gameSettings.hitscans[GS_LIGHTNING][GS_DAMAGE],
		&gameSettings.hitscans[GS_LIGHTNING][GS_RANGE],
		//28
		&gameSettings.hitscans[GS_RAILGUN][GS_DAMAGE],
		&gameSettings.hitscans[GS_RAILGUN][GS_RANGE],
		//30
		&gameSettings.hook_speed,
		&quadfactor_radius,
		&allowTossflag,
		&gameSettings.spawn_armor,
		&gameSettings.spawn_health,
		&wasPreviousSession,
		&ping_fix,
		&team_Locked[TEAM_FREE],
		&team_Locked[TEAM_RED],
		&team_Locked[TEAM_BLUE]
		//40
		);


	gameSettings.quadfactor_radius = (qboolean)quadfactor_radius;
	gameSettings.allowTossflag = (qboolean)allowTossflag;
	gameSettings.wasPreviousSession = (qboolean)wasPreviousSession;
	gameSettings.ping_fix = (qboolean)ping_fix;
	//
	level.team_Locked[TEAM_FREE] = (qboolean)team_Locked[TEAM_FREE];
	level.team_Locked[TEAM_RED] = (qboolean)team_Locked[TEAM_RED];
	level.team_Locked[TEAM_BLUE] = (qboolean)team_Locked[TEAM_BLUE];
}

/*
================
G_ReadBans
================
*/
void G_ReadBans() {
	int i = 0,count = 0;
//	const char	*var;
	static char		*fsptr;
//	char	s[128];
	//
	int				length = 0;
	char			text[MAX_HELP_FILE_SIZE];
	//char			filename[MAX_QPATH];
	char			token[MAX_TOKEN_CHARS];	
	fileHandle_t	f;

	length = trap_FS_FOpenFile("ban.cfg", &f, FS_READ);
	if (length <= 0) {
		Com_Printf(""S_COLOR_RED"Loading ban.cfg failed! Failed to open the file\n");
		trap_FS_FCloseFile( f );//4/22/2013
		return;
	}

	if (length >= MAX_HELP_FILE_SIZE) {
		Com_Printf(""S_COLOR_RED"Loading ban.cfg failed! File too large\n");
		trap_FS_FCloseFile( f );//4/22/2013
		return;
	}

	trap_FS_Read(text, length, f);
	text[length] = '\0';
	trap_FS_FCloseFile(f);
	fsptr = text;
	//
	while ( GetToken(token, &fsptr) != T_EOF && count < NUM_BANS ) {
		switch ( i ) {
			case 0:
				i++;
				//Parse ip's to bytes =/
				//G_Printf("%s\n", token);
				Q_strncpyz(bans[count].ip, token, sizeof(bans[count].ip));
				//sscanf(token, "%d.%d.%d.%d", &bans[count].ip[0], &bans[count].ip[1], &bans[count].ip[2], &bans[count].ip[3]);
				break;
			case 1:
				i++;
				//G_Printf("%s\n", token);
				bans[count].time = atoi(token);
				break;
			case 2:
				i++;
				//G_Printf("%s\n", token);
				bans[count].type = atoi(token);
				break;
			case 3:
				i = 0;
				//G_Printf("%s\n", token);
				//Com_sprintf(bans[count].message, sizeof(bans[count].message), "%s", token);
				Q_strncpyz(bans[count].message, token, sizeof(bans[count].message));
				//G_Printf("%i: %s - %s\n", count, bans[count].ip,  bans[count].message);
				count++;
				break;
		}
	}
}

int getTimeDiff( void ) {
	int timeDiff = 0;
	int	tmHours = 0;
	qtime_t		curSysTime;
	trap_RealTime(&curSysTime);

	if (level.sysStartTime.tm_min < curSysTime.tm_min) {
		timeDiff = curSysTime.tm_min - level.sysStartTime.tm_min;
		//G_Printf("DBG:TimeDiff: startMin < curMin: %i\n", timeDiff);
	} else {
		timeDiff = 60 - (level.sysStartTime.tm_min - curSysTime.tm_min);
		//G_Printf("DBG:TimeDiff: startMin > curMin: %i\n", timeDiff);
	}

	if ( curSysTime.tm_yday != level.sysStartTime.tm_yday ) {
		if ( level.sysStartTime.tm_yday < curSysTime.tm_yday ) {
			tmHours = 24 * (curSysTime.tm_yday - level.sysStartTime.tm_yday);
			//G_Printf("DBG:TimeDiff: startDay < curDay: %i\n", tmHours);
		} else {
			tmHours = 24 * ((365 - level.sysStartTime.tm_yday) + curSysTime.tm_yday);
			//G_Printf("DBG:TimeDiff: startDay > curDay: %i\n", tmHours);
		}
	}

	if ( curSysTime.tm_hour != level.sysStartTime.tm_hour ) {
		if (level.sysStartTime.tm_hour < curSysTime.tm_hour) {
			tmHours += curSysTime.tm_hour - level.sysStartTime.tm_hour;
			//G_Printf("DBG:TimeDiff: startHour < curHour: %i\n", tmHours);
		} else {
			tmHours += 24 - (level.sysStartTime.tm_hour - curSysTime.tm_hour);
			//G_Printf("DBG:TimeDiff: startHour > curHour: %i\n", tmHours);
		}
	}

	timeDiff += (tmHours * 60);

	//G_Printf("DBG:TimeDiff:Return: %i\n", timeDiff);
	return timeDiff;
}

void G_WriteBans( void ) {
	int i = 0;
	char			text[MAX_HELP_FILE_SIZE];
	fileHandle_t	f;
	qboolean		first = qtrue;
	int				minuteDiff = getTimeDiff();

	memset(text, 0, sizeof(text));
	for (i = 0; i < NUM_BANS; i++) {
		if ( strlen(bans[i].ip) > 2 ) {
			if ( bans[i].time == 0 || (bans[i].time -= minuteDiff) > 0 ) {
				if ( first ) {
					Com_sprintf(text, sizeof(text), "%s %i %i \"%s\"\n", bans[i].ip, bans[i].time, bans[i].type, bans[i].message );
					first = qfalse;
				} else {
					Com_sprintf(text, sizeof(text), "%s%s %i %i \"%s\"\n", text, bans[i].ip, bans[i].time, bans[i].type, bans[i].message );
				}
			}
		}
	}
	trap_FS_FOpenFile( "ban.cfg", &f, FS_WRITE );
	trap_FS_Write( text, strlen(text), f );
	trap_FS_FCloseFile(f);
}

/*
================
G_InitSessionData

Called on a first-time connect
================
*/
void G_InitSessionData( gclient_t *client, char *userinfo ) {
	clientSession_t	*sess;
	const char		*value;

	sess = &client->sess;

	// initial team determination
	if ( g_gametype.integer >= GT_TEAM ) {
		if ( g_teamAutoJoin.integer ) {
			sess->sessionTeam = PickTeam( -1 );
			BroadcastTeamChange( client, -1 );
		} else {
			// always spawn as spectator in team games
			sess->sessionTeam = TEAM_SPECTATOR;	
		}
	} else {
		value = Info_ValueForKey( userinfo, "team" );
		if ( value[0] == 's' ) {
			// a willing spectator, not a waiting-in-line
			sess->sessionTeam = TEAM_SPECTATOR;
		} else {
			switch ( g_gametype.integer ) {
			default:
			case GT_FFA:
			case GT_SINGLE_PLAYER:
				if ( g_maxGameClients.integer > 0 && 
					level.numNonSpectatorClients >= g_maxGameClients.integer ) {
					sess->sessionTeam = TEAM_SPECTATOR;
				} else {
					sess->sessionTeam = TEAM_FREE;
				}
				break;
			case GT_TOURNAMENT:
				// if the game is full, go into a waiting mode
				if ( level.numNonSpectatorClients >= 2 ) {
					sess->sessionTeam = TEAM_SPECTATOR;
				} else {
					sess->sessionTeam = TEAM_FREE;
				}
				break;
			}
		}
	}

	sess->spectatorState = SPECTATOR_FREE;
	sess->spectatorTime = level.time;
	sess->aimType = 2;
	sess->aimNudge = 0;

	G_WriteClientSessionData( client );
}


/*
==================
G_InitWorldSession

==================
*/
void G_InitWorldSession( void ) {
	char	s[MAX_STRING_CHARS];
	//int			gt;

	trap_Cvar_VariableStringBuffer( "session", s, sizeof(s) );
	level.gt = atoi( s );
	
	// if the gametype changed since the last session, don't use any
	// client sessions
	if ( g_gametype.integer != level.gt ) {
		level.newSession = qtrue;
		G_Printf( "Gametype changed, clearing session data.\n" );
	}
}

/*
==================
G_WriteSessionData

==================
*/
void G_WriteSessionData( void ) {
	int		i;

	trap_Cvar_Set( "session", va("%i", g_gametype.integer) );

	for ( i = 0 ; i < level.maxclients ; i++ ) {
		if ( level.clients[i].pers.connected == CON_CONNECTED ) {
			G_WriteClientSessionData( &level.clients[i] );
		}
	}

	G_WriteTaskData();
	G_WriteGameSettings();
	G_WriteBans();
}
