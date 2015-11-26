// Copyright (C) 1999-2000 Id Software, Inc.
//

#include "g_local.h"
#include "bg_promode.h" // CPM

level_locals_t	level;
tasks_t			tasks[MAX_SERVER_TASKS];
gameSettings_t	gameSettings;
bans_t			bans[NUM_BANS];

typedef struct {
	vmCvar_t	*vmCvar;
	char		*cvarName;
	char		*defaultString;
	int			cvarFlags;
	int			modificationCount;  // for tracking changes
	qboolean	trackChange;	    // track this variable, and announce if changed
  qboolean teamShader;        // track and if changed, update shader state
} cvarTable_t;

gentity_t		g_entities[MAX_GENTITIES];
gclient_t		g_clients[MAX_CLIENTS];

vmCvar_t	g_gametype;
vmCvar_t	g_dmflags;
vmCvar_t	g_fraglimit;
vmCvar_t	g_timelimit;
vmCvar_t	g_capturelimit;
vmCvar_t	g_friendlyFire;
vmCvar_t	g_password;
vmCvar_t	g_needpass;
vmCvar_t	g_maxclients;
vmCvar_t	g_maxGameClients;
vmCvar_t	g_dedicated;
vmCvar_t	g_speed;
vmCvar_t	g_gravity;
vmCvar_t	g_cheats;
vmCvar_t	g_knockback;
vmCvar_t	g_quadfactor;
vmCvar_t	g_forcerespawn;
vmCvar_t	g_inactivity;
vmCvar_t	g_debugMove;
vmCvar_t	g_debugAlloc;
vmCvar_t	g_weaponRespawn;
vmCvar_t	g_weaponTeamRespawn;
vmCvar_t	g_motd;
vmCvar_t	g_synchronousClients;
vmCvar_t	g_warmup;
//vmCvar_t	g_doWarmup;
vmCvar_t	g_restarted;
vmCvar_t	g_log;
vmCvar_t	g_logSync;
vmCvar_t	g_blood;
vmCvar_t	g_podiumDist;
vmCvar_t	g_podiumDrop;
vmCvar_t	g_allowVote;
vmCvar_t	g_teamAutoJoin;
vmCvar_t	g_teamForceBalance;
//vmCvar_t	g_banIPs;
//vmCvar_t	g_filterBan;
vmCvar_t	g_smoothClients;

vmCvar_t	g_gamemode;
vmCvar_t	g_freezeRoundRespawn;
vmCvar_t	g_freezeAutothawTime;
vmCvar_t	g_allowLockedTeams;
vmCvar_t	g_FallingDamage;
vmCvar_t	g_SelfDamage;
vmCvar_t	g_StaticKnockback;
vmCvar_t	g_railgunKnockback;
vmCvar_t	g_teamKnockback;
vmCvar_t	g_RailJumping;
vmCvar_t	g_RailjumpRadius;
vmCvar_t	g_DynamicRailgunCycle;
vmCvar_t	g_returnFlag;
vmCvar_t	g_IU_ctf_sounds;
vmCvar_t	pmove_fixed;
vmCvar_t	pmove_msec;
vmCvar_t	sv_lock_pmove;
//vmCvar_t	sv_max_timeNudge;
vmCvar_t	g_rankings;
vmCvar_t	g_listEntity;
/* Weapon Cycles & allowed weapons */
vmCvar_t	weap_enableHook;
vmCvar_t	weap_allowed;
vmCvar_t	weap_gauntletCycle;
vmCvar_t	weap_machinegunCycle;
vmCvar_t	weap_shotgunCycle;
vmCvar_t	weap_grenadelauncherCycle;
vmCvar_t	weap_lightninggunCycle;
vmCvar_t	weap_rocketlauncherCycle;
vmCvar_t	weap_railgunCycle;
vmCvar_t	weap_plasmagunCycle;
vmCvar_t	weap_bfgCycle;
#ifdef MISSIONPACK
vmCvar_t	g_obeliskHealth;
vmCvar_t	g_obeliskRegenPeriod;
vmCvar_t	g_obeliskRegenAmount;
vmCvar_t	g_obeliskRespawnDelay;
vmCvar_t	g_cubeTimeout;
vmCvar_t	g_redteam;
vmCvar_t	g_blueteam;
vmCvar_t	g_singlePlayer;
vmCvar_t	g_enableDust;
vmCvar_t	g_enableBreath;
vmCvar_t	g_proxMineTimeout;
//freeze
//#else
//vmCvar_t	g_enableBreath;
//freeze
#endif
//freeze
//unlagged - server options
vmCvar_t	g_delagHitscan;
vmCvar_t	g_delagProjectiles;
//vmCvar_t	g_unlaggedVersion;
//vmCvar_t	g_truePing;
vmCvar_t	g_wpflags;
vmCvar_t	sv_fps;
//unlagged - server options
vmCvar_t	lastmap;
vmCvar_t	g_fastRespawn;
vmCvar_t	g_fastSwitch; //Fast weapon switching
vmCvar_t	g_muteSpecs; // mute spectators
vmCvar_t	g_muteTourneyspecs; //mute tourney spectators
vmCvar_t	g_flagSacrifice;//monkk
vmCvar_t	g_sacrificeAnnounce;//Monkk
vmCvar_t	g_timeOutLimit;
vmCvar_t	g_timeOutLength;
vmCvar_t	g_timeInGrace;
vmCvar_t	g_pro_mode; // CPM: The overall CPM toggle
vmCvar_t	g_allowHandicap;
vmCvar_t	modname;
vmCvar_t	sv_minRate;
vmCvar_t	g_allowReady;
vmCvar_t	g_readyGrace;
vmCvar_t	g_fixMuzzleBug;
vmCvar_t	g_AdminPassword;
vmCvar_t	g_allowSave;
vmCvar_t	sv_lock_cg_railHum_to;
vmCvar_t	g_gauntletKnockback;
vmCvar_t	g_gauntletJumping;
vmCvar_t	g_gauntletjumpRadius;
vmCvar_t	g_DynamicGauntletCycle;
vmCvar_t	g_allowObliterate;
vmCvar_t	g_spawnProtection;
vmCvar_t	g_interference;

vmCvar_t	sv_motd1;
vmCvar_t	sv_motd2;
vmCvar_t	sv_motd3;
vmCvar_t	sv_motd4;
vmCvar_t	sv_motd5;
vmCvar_t	sv_motd6;
vmCvar_t	sv_motd7;
vmCvar_t	sv_motd8;
vmCvar_t	sv_allowUnnamed;


// bk001129 - made static to avoid aliasing
static cvarTable_t		gameCvarTable[] = {
	// don't override the cheat state set by the system
	{ &g_cheats, "sv_cheats", "", 0, 0, qfalse },
	{ &sv_minRate, "sv_minRate", "2500", CVAR_ARCHIVE | CVAR_SERVERINFO, 0, qfalse },

	// noset vars
	//{ NULL, "gamename", GAMEVERSION , CVAR_SERVERINFO | CVAR_ROM, 0, qfalse  },
	//hack to get Revolution to change how it shows up in scanners
	{ NULL, "gamename", GAMEVERSION , CVAR_SERVERINFO, 0, qfalse  },
	{ NULL, "modname", GAMEVERSION , CVAR_SERVERINFO | CVAR_ROM, 0, qfalse  },
	{ NULL, "gamedate", __DATE__ , CVAR_ROM, 0, qfalse  },
	{ &g_restarted, "g_restarted", "0", CVAR_ROM, 0, qfalse  },
	{ NULL, "sv_mapname", "", CVAR_SERVERINFO | CVAR_ROM, 0, qfalse  },

	// latched vars
	{ &g_gametype, "g_gametype", "0", CVAR_SERVERINFO | CVAR_USERINFO | CVAR_LATCH, 0, qfalse  },

	{ &g_maxclients, "sv_maxclients", "8", CVAR_SERVERINFO | CVAR_LATCH | CVAR_ARCHIVE, 0, qfalse  },
	{ &g_maxGameClients, "g_maxGameClients", "0", CVAR_SERVERINFO | CVAR_LATCH | CVAR_ARCHIVE, 0, qfalse  },

	// change anytime vars
	{ &g_dmflags, "dmflags", "0", CVAR_SERVERINFO | CVAR_ARCHIVE, 0, qfalse  },
	{ &g_fraglimit, "fraglimit", "20", CVAR_SERVERINFO | CVAR_ARCHIVE | CVAR_NORESTART, 0, qtrue },
	{ &g_timelimit, "timelimit", "0", CVAR_SERVERINFO | CVAR_ARCHIVE | CVAR_NORESTART, 0, qtrue },
	{ &g_capturelimit, "capturelimit", "8", CVAR_SERVERINFO | CVAR_ARCHIVE | CVAR_NORESTART, 0, qtrue },

	{ &g_synchronousClients, "g_synchronousClients", "0", CVAR_SYSTEMINFO, 0, qfalse  },

	{ &g_friendlyFire, "g_friendlyFire", "0", CVAR_ARCHIVE, 0, qtrue  },

	{ &g_teamAutoJoin, "g_teamAutoJoin", "0", CVAR_ARCHIVE  },
	{ &g_teamForceBalance, "g_teamForceBalance", "0", CVAR_ARCHIVE  },

	{ &g_warmup, "g_warmup", "20", CVAR_ARCHIVE, 0, qtrue  },
	//{ &g_doWarmup, "g_doWarmup", "0", 0, 0, qtrue  },
	{ &g_log, "g_log", "games.log", CVAR_ARCHIVE, 0, qfalse  },
	{ &g_logSync, "g_logSync", "0", CVAR_ARCHIVE, 0, qfalse  },

	{ &g_password, "g_password", "", CVAR_USERINFO, 0, qfalse  },

	//{ &g_banIPs, "g_banIPs", "", CVAR_ARCHIVE, 0, qfalse  },
	//{ &g_filterBan, "g_filterBan", "1", CVAR_ARCHIVE, 0, qfalse  },

	{ &g_needpass, "g_needpass", "0", CVAR_SERVERINFO | CVAR_ROM, 0, qfalse },

	{ &g_dedicated, "dedicated", "0", 0, 0, qfalse  },

	{ &g_speed, "g_speed", "320", 0, 0, qtrue  },
	{ &g_gravity, "g_gravity", "800", 0, 0, qtrue  },
	{ &g_knockback, "g_knockback", "1000", 0, 0, qtrue  },
	{ &g_quadfactor, "g_quadfactor", "3", 0, 0, qtrue  },
	{ &g_weaponRespawn, "g_weaponrespawn", "5", 0, 0, qtrue  },
	{ &g_weaponTeamRespawn, "g_weaponTeamRespawn", "30", 0, 0, qtrue },
	{ &g_forcerespawn, "g_forcerespawn", "20", 0, 0, qtrue },
	{ &g_inactivity, "g_inactivity", "0", 0, 0, qtrue },
	{ &g_debugMove, "g_debugMove", "0", 0, 0, qfalse },
	{ &g_debugAlloc, "g_debugAlloc", "0", 0, 0, qfalse },
	{ &g_motd, "g_motd", "", 0, 0, qfalse },
	{ &g_blood, "com_blood", "1", 0, 0, qfalse },

	{ &g_podiumDist, "g_podiumDist", "80", 0, 0, qfalse },
	{ &g_podiumDrop, "g_podiumDrop", "70", 0, 0, qfalse },

	{ &g_allowVote, "g_allowVote", "1", CVAR_ARCHIVE, 0, qfalse },
	{ &g_listEntity, "g_listEntity", "0", 0, 0, qfalse },

#ifdef MISSIONPACK
	{ &g_obeliskHealth, "g_obeliskHealth", "2500", 0, 0, qfalse },
	{ &g_obeliskRegenPeriod, "g_obeliskRegenPeriod", "1", 0, 0, qfalse },
	{ &g_obeliskRegenAmount, "g_obeliskRegenAmount", "15", 0, 0, qfalse },
	{ &g_obeliskRespawnDelay, "g_obeliskRespawnDelay", "10", CVAR_SERVERINFO, 0, qfalse },

	{ &g_cubeTimeout, "g_cubeTimeout", "30", 0, 0, qfalse },
	{ &g_redteam, "g_redteam", "Stroggs", CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_USERINFO , 0, qtrue, qtrue },
	{ &g_blueteam, "g_blueteam", "Pagans", CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_USERINFO , 0, qtrue, qtrue  },
	{ &g_singlePlayer, "ui_singlePlayerActive", "", 0, 0, qfalse, qfalse  },

	{ &g_enableDust, "g_enableDust", "0", CVAR_SERVERINFO, 0, qtrue, qfalse },
	{ &g_enableBreath, "g_enableBreath", "0", CVAR_SERVERINFO, 0, qtrue, qfalse },
	{ &g_proxMineTimeout, "g_proxMineTimeout", "20000", 0, 0, qfalse },
//freeze
//#else
//	{ &g_enableBreath, "g_enableBreath", "1", CVAR_SERVERINFO, 0, qtrue, qfalse },
//freeze
#endif
//freeze
	//{ &g_wpflags, "wpflags", "0", 0, 0, qfalse },
//freeze
	{ &g_smoothClients, "g_smoothClients", "2", CVAR_SERVERINFO, 0, qfalse},
	{ &g_gamemode, "g_gamemode", "0", CVAR_SYSTEMINFO | CVAR_SERVERINFO | CVAR_LATCH, 0, qfalse },
	{ &g_freezeRoundRespawn, "g_freezeRoundRespawn", "1", 0, 0, qfalse },
	{ &g_freezeAutothawTime, "g_freezeAutothawTime", "60", 0, 0, qfalse },
	{ &g_allowLockedTeams, "g_allowLockedTeams", "0", 0, 0, qtrue },
	{ &g_allowReady, "g_allowReady", "1", CVAR_SYSTEMINFO, 0, qtrue },
	{ &g_readyGrace, "g_readyGrace", "5", 0, 0, qtrue },
	{ &g_FallingDamage, "g_FallingDamage", "1", 0, 0, qtrue },
	{ &g_SelfDamage, "g_SelfDamage", "1", 0, 0, qtrue },
	{ &g_StaticKnockback, "g_StaticKnockback", "0", 0, 0, qtrue },
	{ &g_railgunKnockback, "g_railgunKnockback", "100", 0, 0, qtrue },
	{ &g_RailJumping, "g_RailJumping", "0", 0, 0, qtrue },
	{ &g_gauntletKnockback, "g_gauntletKnockback", "30", 0, 0, qtrue },
	{ &g_gauntletJumping, "g_gauntletJumping", "0", 0, 0, qtrue },
	{ &g_gauntletjumpRadius, "g_gauntletjumpRadius", "36", 0, 0, qtrue },
	{ &g_DynamicGauntletCycle, "g_DynamicGauntletCycle", "0", 0, 0, qtrue },
	{ &g_teamKnockback, "g_teamKnockback", "-1", 0, 0, qtrue },
	{ &g_RailjumpRadius, "g_RailjumpRadius", "100", 0, 0, qtrue },
	{ &g_DynamicRailgunCycle, "g_DynamicRailgunCycle", "0", 0, 0, qtrue },
	{ &g_fixMuzzleBug, "g_fixMuzzleBug", "0", CVAR_LATCH, 0, qfalse },
	{ &g_returnFlag, "g_returnFlag", "0", 0, 0, qtrue },
	{ &g_IU_ctf_sounds, "g_IU_ctf_sounds", "0", 0, 0, qtrue },
	{ &pmove_fixed, "pmove_fixed", "0", CVAR_SYSTEMINFO, 0, qfalse},
	{ &pmove_msec, "pmove_msec", "8", CVAR_SYSTEMINFO, 0, qfalse},
	{ &sv_lock_pmove, "sv_lock_pmove", "0", CVAR_SYSTEMINFO, 0, qtrue},
	//{ &sv_max_timeNudge, "sv_max_timeNudge", "0", CVAR_SYSTEMINFO | CVAR_SERVERINFO, 0, qtrue},
	//unlagged - server options
	{ &g_delagHitscan, "g_delagHitscan", "2", CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_LATCH | CVAR_SYSTEMINFO, 0, qtrue },
	{ &g_delagProjectiles, "g_delagProjectiles", "1", 0, 0, qtrue },
	//{ &g_unlaggedVersion, "g_unlaggedVersion", "2.0", CVAR_ROM | CVAR_SERVERINFO, 0, qfalse },
	//{ &g_truePing, "g_truePing", "1", CVAR_ARCHIVE, 0, qtrue },
	// it's CVAR_SYSTEMINFO so the client's sv_fps will be automagically set to its value
	{ &sv_fps, "sv_fps", "20", CVAR_SYSTEMINFO, 0, qfalse },
	//unlagged - server options
	{&lastmap, "lastmap", "", CVAR_ROM | CVAR_LATCH, 0, qfalse},//monkk

	{ &g_rankings, "g_rankings", "0", 0, 0, qfalse},
	/* Weapon Cycles & allowed weapons */
	{ &weap_enableHook, "weap_enableHook", "0", CVAR_LATCH, 0, qfalse },//monkk
	{ &weap_allowed, "weap_allowed", "511", CVAR_LATCH, 0, qfalse },
	{ &weap_gauntletCycle, "weap_GauntletCycle", "400", 0, 0, qtrue },
	{ &weap_machinegunCycle, "weap_machinegunCycle", "100", 0, 0, qtrue },
	{ &weap_shotgunCycle, "weap_shotgunCycle", "1000", 0, 0, qtrue },
	{ &weap_grenadelauncherCycle, "weap_grenadelauncherCycle", "800", 0, 0, qtrue },
	{ &weap_lightninggunCycle, "weap_lightninggunCycle", "50", 0, 0, qtrue },
	{ &weap_rocketlauncherCycle, "weap_rocketlauncherCycle", "800", 0, 0, qtrue },
	{ &weap_railgunCycle, "weap_railgunCycle", "1500", 0, 0, qtrue },
	{ &weap_plasmagunCycle, "weap_plasmagunCycle", "100", 0, 0, qtrue },
	{ &weap_bfgCycle, "weap_bfgCycle", "200", 0, 0, qtrue },
	/* Weapon Cycles & allowed weapons */
	{ &g_flagSacrifice, "g_flagSacrifice", "0", CVAR_SYSTEMINFO, 0, qtrue},//Monkk
	{ &g_sacrificeAnnounce, "g_sacrificeAnnounce", "7", CVAR_SYSTEMINFO, 0, qtrue},//Monkk
	{ &g_fastRespawn, "g_fastRespawn", "0", 0, 0, qtrue },
	{ &g_fastSwitch, "g_fastSwitch", "0", CVAR_SYSTEMINFO | CVAR_LATCH, 0, qfalse },//Fast weapon switching
	{ &g_muteSpecs, "g_muteSpecs", "0", 0, 0, qtrue }, //mute spectators
	{ &g_muteTourneyspecs, "g_muteTourneyspecs", "1", 0, 0, qtrue }, //mute tournament spectators
	{ &g_allowHandicap, "g_allowHandicap", "1", 0, 0, qtrue },
	{ &g_pro_mode, "g_pro_mode", "0", CVAR_SYSTEMINFO | CVAR_SERVERINFO/* | CVAR_LATCH*/, 0, qtrue  }, // CPM: The overall CPM Toggle
	{ &g_timeInGrace, "g_timeInGrace", "0", 0, 0, qtrue },
	{ &g_timeOutLength, "g_timeOutLength", "30", 0, 0, qtrue },
	{ &g_timeOutLimit, "g_timeOutLimit", "2", 0, 0, qtrue },
	{ &g_allowSave, "g_allowSave", "0", 0, 0, qtrue },

	{ &sv_allowUnnamed, "sv_allowUnnamed", "1", CVAR_ARCHIVE, 0, qfalse },
	{ &sv_motd1, "sv_motd1", "", CVAR_ARCHIVE, 0, qfalse  },
	{ &sv_motd2, "sv_motd2", "", CVAR_ARCHIVE, 0, qfalse  },
	{ &sv_motd3, "sv_motd3", "", CVAR_ARCHIVE, 0, qfalse  },
	{ &sv_motd4, "sv_motd4", "", CVAR_ARCHIVE, 0, qfalse  },
	{ &sv_motd5, "sv_motd5", "", CVAR_ARCHIVE, 0, qfalse  },
	{ &sv_motd6, "sv_motd6", "", CVAR_ARCHIVE, 0, qfalse  },
	{ &sv_motd7, "sv_motd7", "", CVAR_ARCHIVE, 0, qfalse  },
	{ &sv_motd8, "sv_motd8", "", CVAR_ARCHIVE, 0, qfalse  },

	{ &sv_lock_cg_railHum_to, "sv_lock_cg_railHum_to", "-2", 0, 0, qfalse },
	{ &g_allowObliterate, "g_allowObliterate", "1", CVAR_ARCHIVE, 0, qtrue },
	{ &g_spawnProtection, "g_spawnProtection", "0", 0, 0, qtrue },
	{ &g_AdminPassword, "g_AdminPassword", "", CVAR_ARCHIVE, 0, qfalse  },
	{ &g_interference, "g_interference", "1", CVAR_SYSTEMINFO, 0, qtrue  }

};

// bk001129 - made static to avoid aliasing
static int gameCvarTableSize = sizeof( gameCvarTable ) / sizeof( gameCvarTable[0] );


void G_InitGame( int levelTime, int randomSeed, int restart );
void G_RunFrame( int levelTime );
void G_ShutdownGame( int restart );
void CheckExitRules( void );


/*
================
vmMain

This is the only way control passes into the module.
This must be the very first function compiled into the .q3vm file
================
*/
int vmMain( int command, int arg0, int arg1, int arg2, int arg3, int arg4, int arg5, int arg6, int arg7, int arg8, int arg9, int arg10, int arg11  ) {
	switch ( command ) {
	case GAME_INIT:
		G_InitGame( arg0, arg1, arg2 );
		return 0;
	case GAME_SHUTDOWN:
		G_ShutdownGame( arg0 );
		return 0;
	case GAME_CLIENT_CONNECT:
		return (int)ClientConnect( arg0, arg1, arg2 );
	case GAME_CLIENT_THINK:
		ClientThink( arg0 );
		return 0;
	case GAME_CLIENT_USERINFO_CHANGED:
		ClientUserinfoChanged( arg0 );
		return 0;
	case GAME_CLIENT_DISCONNECT:
		ClientDisconnect( arg0 );
		return 0;
	case GAME_CLIENT_BEGIN:
		ClientBegin( arg0 );
		return 0;
	case GAME_CLIENT_COMMAND:
		ClientCommand( arg0 );
		return 0;
	case GAME_RUN_FRAME:
		G_RunFrame( arg0 );
		return 0;
	case GAME_CONSOLE_COMMAND:
		return ConsoleCommand();
	case BOTAI_START_FRAME:
		return BotAIStartFrame( arg0 );
	}

	return -1;
}


void QDECL G_Printf( const char *fmt, ... ) {
	va_list		argptr;
	char		text[1024];

	va_start (argptr, fmt);
	vsprintf (text, fmt, argptr);
	va_end (argptr);

	trap_Printf( text );
}

void QDECL G_Error( const char *fmt, ... ) {
	va_list		argptr;
	char		text[1024];

	va_start (argptr, fmt);
	vsprintf (text, fmt, argptr);
	va_end (argptr);

	trap_Error( text );
}

/*
================
G_FindTeams

Chain together all entities with a matching team field.
Entity teams are used for item groups and multi-entity mover groups.

All but the first will have the FL_TEAMSLAVE flag set and teammaster field set
All but the last will have the teamchain field set to the next one
================
*/
void G_FindTeams( void ) {
	gentity_t	*e, *e2;
	int		i, j;
	int		c, c2;

	c = 0;
	c2 = 0;
	for ( i=1, e=g_entities+i ; i < level.num_entities ; i++,e++ ){
		if (!e->inuse)
			continue;
		if (!e->team)
			continue;
		if (e->flags & FL_TEAMSLAVE)
			continue;
		e->teammaster = e;
		c++;
		c2++;
		for (j=i+1, e2=e+1 ; j < level.num_entities ; j++,e2++)
		{
			if (!e2->inuse)
				continue;
			if (!e2->team)
				continue;
			if (e2->flags & FL_TEAMSLAVE)
				continue;
			if (!strcmp(e->team, e2->team))
			{
				c2++;
				e2->teamchain = e->teamchain;
				e->teamchain = e2;
				e2->teammaster = e;
				e2->flags |= FL_TEAMSLAVE;

				// make sure that targets only point at the master
				if ( e2->targetname ) {
					e->targetname = e2->targetname;
					e2->targetname = NULL;
				}
			}
		}
	}

	G_Printf ("%i teams with %i entities\n", c, c2);
}

void G_RemapTeamShaders() {
#ifdef MISSIONPACK
	char string[1024];
	float f = level.time * 0.001;
	Com_sprintf( string, sizeof(string), "team_icon/%s_red", g_redteam.string );
	AddRemap("textures/ctf2/redteam01", string, f); 
	AddRemap("textures/ctf2/redteam02", string, f); 
	Com_sprintf( string, sizeof(string), "team_icon/%s_blue", g_blueteam.string );
	AddRemap("textures/ctf2/blueteam01", string, f); 
	AddRemap("textures/ctf2/blueteam02", string, f); 
	trap_SetConfigstring(CS_SHADERSTATE, BuildShaderStateConfig());
#endif
}

void G_RegisterQuickModes( void ) {
	char	filelist[2048];
	char	qmName[MAX_QPATH];
	char	modeList[MAX_QUICKMODE_LIST_SIZE];
	char*	fileptr;
	int		i, filelen, numfiles, cnt;

	// iterate directory of all player models
	//numdirs = trap_FS_GetFileList("config/quickmodes", ".cfg", dirlist, 2048 );
	//dirptr  = dirlist;
	//for (i=0; i<numdirs; i++, dirptr+=dirlen+1)
	//{
	//	dirlen = strlen(dirptr);
	//	
	//	if (dirlen && dirptr[dirlen-1]=='/') dirptr[dirlen-1]='\0';

	//	if (!strcmp(dirptr,".") || !strcmp(dirptr,".."))
	//		continue;
	//		
		// iterate all .cfg files in directory
	numfiles = trap_FS_GetFileList( "config/quickmodes", "cfg", filelist, 2048 );
	fileptr  = filelist;
	memset(modeList, 0, sizeof(modeList));
	for (i=0, cnt=0; i<numfiles; i++, fileptr += filelen+1)
	{
		filelen = strlen(fileptr);
		COM_StripExtension(fileptr,qmName);
		//ParseQuickModeConfig(fileptr);
		if(cnt + 1 + filelen < sizeof(modeList) )
		{
			Q_strcat(modeList, sizeof(modeList), va("%s\n", qmName));
			cnt += filelen + 1;
		}
	}
	if( numfiles > 0 ) {
		trap_Cvar_Set("__quickmodes", modeList);
	}
//	}	

	//APSFIXME - Degenerate no models case
}


/*
=================
G_RegisterCvars
=================
*/
void G_RegisterCvars( void ) {
	int			i;
	cvarTable_t	*cv;
	qboolean remapped = qfalse;

	for ( i = 0, cv = gameCvarTable ; i < gameCvarTableSize ; i++, cv++ ) {
		trap_Cvar_Register( cv->vmCvar, cv->cvarName,
			cv->defaultString, cv->cvarFlags );
		if ( cv->vmCvar )
			cv->modificationCount = cv->vmCvar->modificationCount;
		/*
				// CPM: Detect if g_pro_mode has been changed
				if (!strcmp(cv->cvarName,"g_pro_mode")) {
					// Update all settings
					CPM_UpdateSettings((g_pro_mode.integer) ?
						((g_gametype.integer == GT_TEAM) ? 2 : 1) : 0);

					// Set the config string (so clients will be updated)
					trap_SetConfigstring(CS_PRO_MODE, va("%d", g_pro_mode.integer));

					// Update all pro mode-dependent server-side cvars					
					if (g_pro_mode.integer) {
						trap_Cvar_Set("g_quadfactor", "4" ); // pro mode default
						trap_Cvar_Set("g_forcerespawn", "3" );
						trap_Cvar_Set("g_weaponrespawn", "15" );
						trap_Cvar_Set("dmflags", va("%d", g_dmflags.integer | DF_NO_FOOTSTEPS)); // turn off footsteps
					} else {
						trap_Cvar_Set("g_quadfactor", "3" ); // q3 default
						trap_Cvar_Set("g_forcerespawn", "20" );
						trap_Cvar_Set("g_weaponrespawn", "5" );
						trap_Cvar_Set("dmflags", va("%d", g_dmflags.integer & ~DF_NO_FOOTSTEPS)); // turn on footsteps
					}
				}
				// !CPM
				*/
				//if ( g_gamemode.integer == 2 ) {
				//	trap_Cvar_Set("weap_allowed", "64" );
				//}
				//if ( g_gamemode.integer == 3 ) {
				//	trap_Cvar_Set("weap_allowed", "81" );
				//}

		if (cv->teamShader) {
			remapped = qtrue;
		}
	}

	if (remapped) {
		G_RemapTeamShaders();
	}

	// check some things
	if ( g_gametype.integer < 0 || g_gametype.integer >= GT_MAX_GAME_TYPE ) {
		G_Printf( "g_gametype %i is out of range, defaulting to 0\n", g_gametype.integer );
		trap_Cvar_Set( "g_gametype", "0" );
	}

	level.warmupModificationCount = g_warmup.modificationCount;
}

/*
=================
G_UpdateCvars
=================
*/
void G_UpdateCvars( void ) {
	int			i;
	cvarTable_t	*cv;
	qboolean remapped = qfalse;

	for ( i = 0, cv = gameCvarTable ; i < gameCvarTableSize ; i++, cv++ ) {
		if ( cv->vmCvar ) {
			trap_Cvar_Update( cv->vmCvar );

			if ( cv->modificationCount != cv->vmCvar->modificationCount ) {
				cv->modificationCount = cv->vmCvar->modificationCount;

				if ( cv->vmCvar == &sv_minRate ) {
					if ( cv->vmCvar->integer < 2500 ) {
						G_Printf("minRate was too low, reset to 2500\n");
						trap_Cvar_Set( "sv_minRate", "2500" );
					}
					trap_SendServerCommand( -1, va("updcvar 1 %i\n", cv->vmCvar->integer) );
				} else if ( cv->vmCvar == &g_AdminPassword && ( strlen(cv->vmCvar->string) > 0 && strlen(cv->vmCvar->string) < 3) ) {
					G_Printf("Password must be atleast 3 charactors\n");
					trap_Cvar_Set( "g_AdminPassword", "" );
				} else if ( cv->vmCvar == &g_FallingDamage && cv->vmCvar->integer == -1 ) {
					//set dmflags falling damage(off)
					trap_Cvar_Set("dmflags", va("%d", g_dmflags.integer | DF_NO_FALLING));
				} else if ( cv->vmCvar == &g_FallingDamage && cv->vmCvar->integer >= 0 ) {
					//set dmflags falling damage(on)
					trap_Cvar_Set("dmflags", va("%d", g_dmflags.integer & ~DF_NO_FALLING));
				/*} else if ( cv->vmCvar == &sv_fps ) {
					trap_SendServerCommand( -1, va("updcvar 1 %i\n", cv->vmCvar->integer));*/
				} else if ( cv->vmCvar == &weap_machinegunCycle ) {
					trap_SendServerCommand( -1, va("updcvar weap_machinegunCycle %i\n", weap_machinegunCycle.integer ) );
				} else if ( cv->vmCvar == &weap_shotgunCycle ) {
					trap_SendServerCommand( -1, va("updcvar weap_shotgunCycle %i\n", weap_shotgunCycle.integer ) );
				} else if ( cv->vmCvar == &weap_grenadelauncherCycle ) {
					trap_SendServerCommand( -1, va("updcvar weap_grenadelauncherCycle %i\n", weap_grenadelauncherCycle.integer ) );
				} else if ( cv->vmCvar == &weap_lightninggunCycle ) {
					trap_SendServerCommand( -1, va("updcvar weap_lightninggunCycle %i\n", weap_lightninggunCycle.integer ) );
				} else if ( cv->vmCvar == &weap_rocketlauncherCycle ) {
					trap_SendServerCommand( -1, va("updcvar weap_rocketlauncherCycle %i\n", weap_rocketlauncherCycle.integer ) );
				} else if ( cv->vmCvar == &weap_railgunCycle ) {
					trap_SendServerCommand( -1, va("updcvar weap_railgunCycle %i\n", weap_railgunCycle.integer ) );
				} else if ( cv->vmCvar == &weap_plasmagunCycle ) {
					trap_SendServerCommand( -1, va("updcvar weap_plasmagunCycle %i\n", weap_plasmagunCycle.integer ) );
				} else if ( cv->vmCvar == &weap_bfgCycle ) {
					trap_SendServerCommand( -1, va("updcvar weap_bfgCycle %i\n", weap_bfgCycle.integer ) );
				} else if ( cv->vmCvar == &g_DynamicGauntletCycle ) {
					trap_SendServerCommand( -1, va("updcvar g_DynamicGauntletCycle %i\n", g_DynamicGauntletCycle.integer ) );
				} else if ( cv->vmCvar == &sv_lock_cg_railHum_to ) {
					trap_SendServerCommand( -1, va("updcvar 2 %i\n", sv_lock_cg_railHum_to.integer ) );
				}else if ( cv->vmCvar == &g_allowLockedTeams && cv->vmCvar->integer ) {
					trap_Cvar_Set( "disable_lockTeam", "0" );//FIXME: Update this
					trap_Cvar_Set( "disable_unlockTeam", "0" );//FIXME: Update this
				} else if ( cv->vmCvar == &g_allowLockedTeams && !cv->vmCvar->integer ) {
					trap_Cvar_Set( "disable_lockTeam", "1" );//FIXME: Update this
					trap_Cvar_Set( "disable_unlockTeam", "1" );//FIXME: Update this
					level.team_Locked[TEAM_RED] = level.team_Locked[TEAM_BLUE] = qfalse;
				} else if ( cv->vmCvar == &g_pro_mode ) {
					// CPM: Detect if g_pro_mode has been changed
					CPM_UpdateSettings((cv->vmCvar->integer) ? ((g_gametype.integer == GT_TEAM) ? 2 : 1) : 0);
					// Update all pro mode-dependent server-side cvars					
					/*if (cv->vmCvar->integer) {
					//	//FIXME: This'll probably cause a crash..
						trap_Cvar_Set("g_quadfactor", "4" ); // pro mode default
						trap_Cvar_Set("g_forcerespawn", "3" );
						trap_Cvar_Set("g_weaponrespawn", "15" );
						trap_Cvar_Set("dmflags", va("%d", g_dmflags.integer | DF_NO_FOOTSTEPS)); // turn off footsteps
					} else {
						trap_Cvar_Set("g_quadfactor", "3" ); // q3 default
						trap_Cvar_Set("g_forcerespawn", "20" );
						trap_Cvar_Set("g_weaponrespawn", "5" );
						trap_Cvar_Set("dmflags", va("%d", g_dmflags.integer & ~DF_NO_FOOTSTEPS)); // turn on footsteps
					}*/
				// Set the config string (so clients will be updated)
					trap_SetConfigstring(CS_PRO_MODE, va("%d", g_pro_mode.integer));
					continue;
				}

				if ( cv->trackChange ) {
					trap_SendServerCommand( -1, va("print \"Server: %s changed to %s\n\"", 
						cv->cvarName, cv->vmCvar->string ) );
				}

				if (cv->teamShader) {
					remapped = qtrue;
				}
			}
		}
	}

	if (remapped) {
		G_RemapTeamShaders();
	}
}

/*
============
G_InitGame

============
*/
void G_InitGame( int levelTime, int randomSeed, int restart ) {
	int				i/*, j*/;

	G_Printf ("------- Game Initialization -------\n");
	G_Printf ("gamename: %s\n", GAMEVERSION);
	G_Printf ("gamedate: %s\n", __DATE__);
	G_Printf ("Mod info: %s\n", BUILDINFO);

	srand( randomSeed );

	//set g_doWarmup to 1 to work around the map_restart delay
	trap_SendConsoleCommand( EXEC_NOW, "set g_doWarmup 1\n" );

	G_RegisterCvars();

	//G_ProcessIPBans();

	G_InitMemory();

	// CPM: Initialize
	// Update all settings
	CPM_UpdateSettings((g_pro_mode.integer) ?
		((g_gametype.integer == GT_TEAM) ? 2 : 1) : 0);

	// Set the config string
	trap_SetConfigstring(CS_PRO_MODE, va("%d", g_pro_mode.integer));
	// !CPM

	// set some level globals
	memset( &level, 0, sizeof( level ) );
	level.time = levelTime;
	level.startTime = levelTime;
	trap_RealTime(&level.sysStartTime);

	memset( &tasks, 0, sizeof( tasks ) );

	for ( i = 0; i < MAX_SERVER_TASKS; i++ ) {
		G_ReadTaskData(i);
	}

	memset( &bans, 0, sizeof(bans));
	G_ReadBans();



	memset( &gameSettings, 0, sizeof( gameSettings ) );
	//gameSettings.wasPreviousSession = qfalse;
	G_ReadGameSetings();
	if ( !gameSettings.wasPreviousSession ) {
		//Set defaults
		gameSettings.missiles[GS_GRENADE][GS_DAMAGE]		=	100;
		gameSettings.missiles[GS_GRENADE][GS_SPLASH_DAMAGE]	=	100;
		gameSettings.missiles[GS_GRENADE][GS_SPEED]			=	700;
		gameSettings.missiles[GS_GRENADE][GS_TIME]			=	2500;
		gameSettings.missiles[GS_GRENADE][GS_RADIUS]		=	150;
		//5
		gameSettings.missiles[GS_ROCKET][GS_DAMAGE]			=	100;
		gameSettings.missiles[GS_ROCKET][GS_SPLASH_DAMAGE]	=	100;
		gameSettings.missiles[GS_ROCKET][GS_SPEED]			=	900;
		gameSettings.missiles[GS_ROCKET][GS_TIME]			=	15000;
		gameSettings.missiles[GS_ROCKET][GS_RADIUS]			=	120;
		//10
		gameSettings.missiles[GS_PLASMA][GS_DAMAGE]			=	20;
		gameSettings.missiles[GS_PLASMA][GS_SPLASH_DAMAGE]	=	15;
		gameSettings.missiles[GS_PLASMA][GS_SPEED]			=	2000;
		gameSettings.missiles[GS_PLASMA][GS_TIME]			=	10000;
		gameSettings.missiles[GS_PLASMA][GS_RADIUS]			=	20;
		//15
		gameSettings.missiles[GS_BFG][GS_DAMAGE]			=	100;
		gameSettings.missiles[GS_BFG][GS_SPLASH_DAMAGE]		=	100;
		gameSettings.missiles[GS_BFG][GS_SPEED]				=	2000;
		gameSettings.missiles[GS_BFG][GS_TIME]				=	10000;
		gameSettings.missiles[GS_BFG][GS_RADIUS]			=	120;
		//20
		gameSettings.hitscans[GS_GAUNTLET][GS_DAMAGE]	=	50;
		gameSettings.hitscans[GS_GAUNTLET][GS_RANGE]	=	32;
		//22
		gameSettings.hitscans[GS_MACHINEGUN][GS_DAMAGE]	=	7;
		gameSettings.hitscans[GS_MACHINEGUN][GS_RANGE]	=	5;
		//24
		gameSettings.hitscans[GS_SHOTGUN][GS_DAMAGE]	=	cpm_SSGdmg;
		gameSettings.hitscans[GS_SHOTGUN][GS_RANGE]		=	0;
		//26
		gameSettings.hitscans[GS_LIGHTNING][GS_DAMAGE]	=	8;
		gameSettings.hitscans[GS_LIGHTNING][GS_RANGE]	=	LIGHTNING_RANGE;
		//28
		gameSettings.hitscans[GS_RAILGUN][GS_DAMAGE]	=	100;
		gameSettings.hitscans[GS_RAILGUN][GS_RANGE]		=	8192;
		//30
		gameSettings.hook_speed			=	800;
		gameSettings.quadfactor_radius	=	qfalse;
		gameSettings.allowTossflag		=	qtrue;
		gameSettings.spawn_armor		=	0;
		gameSettings.spawn_health		=	100;
		gameSettings.wasPreviousSession	=	qtrue;
		gameSettings.ping_fix			=	qtrue;

		level.team_Locked[TEAM_FREE] = level.team_Locked[TEAM_RED] = level.team_Locked[TEAM_BLUE] = qfalse;
	}

	level.snd_fry = G_SoundIndex("sound/player/fry.wav");	// FIXME standing in lava / slime

	if ( g_gametype.integer != GT_SINGLE_PLAYER && g_log.string[0] ) {
		if ( g_logSync.integer ) {
			trap_FS_FOpenFile( g_log.string, &level.logFile, FS_APPEND_SYNC );
		} else {
			trap_FS_FOpenFile( g_log.string, &level.logFile, FS_APPEND );
		}
		if ( !level.logFile ) {
			G_Printf( "WARNING: Couldn't open logfile: %s\n", g_log.string );
		} else {
			char	serverinfo[MAX_INFO_STRING];

			trap_GetServerinfo( serverinfo, sizeof( serverinfo ) );

			G_LogPrintf("------------------------------------------------------------\n" );
			G_LogPrintf("InitGame: %s\n", serverinfo );
			G_LogPrintf("Game_Start:\n");
			G_LogPrintf("TeamName: 1 RED\n");
			G_LogPrintf("TeamName: 2 BLUE\n");
		}
	} else {
		G_Printf( "Not logging to disk.\n" );
	}

	G_InitWorldSession();

	// initialize all entities for this game
	memset( g_entities, 0, MAX_GENTITIES * sizeof(g_entities[0]) );
	level.gentities = g_entities;

	// initialize all clients for this game
	level.maxclients = g_maxclients.integer;
	memset( g_clients, 0, MAX_CLIENTS * sizeof(g_clients[0]) );
	level.clients = g_clients;

	// set client fields on player ents
	for ( i=0 ; i<level.maxclients ; i++ ) {
		g_entities[i].client = level.clients + i;
	}

	// always leave room for the max number of clients,
	// even if they aren't all used, so numbers inside that
	// range are NEVER anything but clients
	level.num_entities = MAX_CLIENTS;

	// let the server system know where the entites are
	trap_LocateGameData( level.gentities, level.num_entities, sizeof( gentity_t ), 
		&level.clients[0].ps, sizeof( level.clients[0] ) );

	// reserve some spots for dead player bodies
	InitBodyQue();

	ClearRegisteredItems();

	// parse the key/value pairs and spawn gentities
	G_SpawnEntitiesFromString();

	// general initialization
	G_FindTeams();

	// make sure we have flags for CTF, etc
	if( g_gametype.integer >= GT_TEAM ) {
		G_CheckTeamItems();
	}

	SaveRegisteredItems();

	G_Printf ("-----------------------------------\n");

	if( g_gametype.integer == GT_SINGLE_PLAYER || trap_Cvar_VariableIntegerValue( "com_buildScript" ) ) {
		G_ModelIndex( SP_PODIUM_MODEL );
		G_SoundIndex( "sound/player/gurp1.wav" );
		G_SoundIndex( "sound/player/gurp2.wav" );
	}

	if ( trap_Cvar_VariableIntegerValue( "bot_enable" ) ) {
		BotAISetup( restart );
		BotAILoadMap( restart );
		G_InitBots( restart );
	}

	G_RemapTeamShaders();

	G_RegisterQuickModes();

	//monkk: lastmap
	if ( *lastmap.string ) {
		trap_Cvar_Set("previousmap", lastmap.string);
	} else {
		trap_Cvar_Set("previousmap", "map_restart 0");
	}

}



/*
=================
G_ShutdownGame
=================
*/
void G_ShutdownGame( int restart ) {
	char	s[MAX_STRING_CHARS];//monkk
	G_Printf ("==== ShutdownGame ====\n");

	
	trap_Cvar_VariableStringBuffer("nextmap", s, sizeof(s));
	if ( *s) {
		trap_Cvar_Set("previousmap", s);
	} else {
		trap_Cvar_Set("previousmap", "map_restart 0\n");
	}

	if ( level.logFile ) {
		G_LogPrintf("ShutdownGame:\n" );
		G_LogPrintf("------------------------------------------------------------\n" );
		trap_FS_FCloseFile( level.logFile );
	}

	// write all the client session data so we can get it back
	G_WriteSessionData();
	G_WriteTaskData();

	if ( trap_Cvar_VariableIntegerValue( "bot_enable" ) ) {
		BotAIShutdown( restart );
	}
}



//===================================================================

#ifndef GAME_HARD_LINKED
// this is only here so the functions in q_shared.c and bg_*.c can link

void QDECL Com_Error ( int level, const char *error, ... ) {
	va_list		argptr;
	char		text[1024];

	va_start (argptr, error);
	vsprintf (text, error, argptr);
	va_end (argptr);

	G_Error( "%s", text);
}

void QDECL Com_Printf( const char *msg, ... ) {
	va_list		argptr;
	char		text[1024];

	va_start (argptr, msg);
	vsprintf (text, msg, argptr);
	va_end (argptr);

	G_Printf ("%s", text);
}

#endif

/*
========================================================================

PLAYER COUNTING / SCORE SORTING

========================================================================
*/

/*
=============
AddTournamentPlayer

If there are less than two tournament players, put a
spectator in the game and restart
=============
*/
void AddTournamentPlayer( void ) {
	int			i;
	gclient_t	*client;
	gclient_t	*nextInLine;

	if ( level.numPlayingClients >= 2 ) {
		return;
	}

	// never change during intermission
	if ( level.intermissiontime ) {
		return;
	}

	nextInLine = NULL;

	for ( i = 0 ; i < level.maxclients ; i++ ) {
		client = &level.clients[i];
		if ( client->pers.connected != CON_CONNECTED ) {
			continue;
		}
		if ( client->sess.sessionTeam != TEAM_SPECTATOR ) {
			continue;
		}
		if ( client->sess.speconly ) {
			client->sess.spectatorTime = level.time;
			continue;
		}
		// never select the dedicated follow or scoreboard clients
		if ( client->sess.spectatorState == SPECTATOR_SCOREBOARD || 
			client->sess.spectatorClient < 0  ) {
			continue;
		}

		if ( !nextInLine || client->sess.spectatorTime < nextInLine->sess.spectatorTime ) {
			nextInLine = client;
		}
	}

	if ( !nextInLine ) {
		return;
	}

	level.warmupTime = -1;

	// set them to free-for-all team
	SetTeam( &g_entities[ nextInLine - level.clients ], "f", qtrue );
}

/*
=======================
RemoveTournamentLoser

Make the loser a spectator at the back of the line
=======================
*/
void RemoveTournamentLoser( void ) {
	int			clientNum;

	if ( level.numPlayingClients != 2 ) {
		return;
	}

	clientNum = level.sortedClients[1];

	if ( level.clients[ clientNum ].pers.connected != CON_CONNECTED ) {
		return;
	}

	// make them a spectator
	SetTeam( &g_entities[ clientNum ], "s", qtrue );
}

/*
=======================
RemoveTournamentWinner
=======================
*/
void RemoveTournamentWinner( void ) {
	int			clientNum;

	if ( level.numPlayingClients != 2 ) {
		return;
	}

	clientNum = level.sortedClients[0];

	if ( level.clients[ clientNum ].pers.connected != CON_CONNECTED ) {
		return;
	}

	// make them a spectator
	SetTeam( &g_entities[ clientNum ], "s", qtrue );
}

/*
=======================
AdjustTournamentScores
=======================
*/
void AdjustTournamentScores( void ) {
	int			clientNum;

	clientNum = level.sortedClients[0];
	if ( level.clients[ clientNum ].pers.connected == CON_CONNECTED ) {
		level.clients[ clientNum ].sess.wins++;
		ClientUserinfoChanged( clientNum );
	}

	clientNum = level.sortedClients[1];
	if ( level.clients[ clientNum ].pers.connected == CON_CONNECTED ) {
		level.clients[ clientNum ].sess.losses++;
		ClientUserinfoChanged( clientNum );
	}

}

/*
=============
SortRanks

=============
*/
int QDECL SortRanks( const void *a, const void *b ) {
	gclient_t	*ca, *cb;

	ca = &level.clients[*(int *)a];
	cb = &level.clients[*(int *)b];

	// sort special clients last
	if ( ca->sess.spectatorState == SPECTATOR_SCOREBOARD || ca->sess.spectatorClient < 0 ) {
		return 1;
	}
	if ( cb->sess.spectatorState == SPECTATOR_SCOREBOARD || cb->sess.spectatorClient < 0  ) {
		return -1;
	}

	// then connecting clients
	if ( ca->pers.connected == CON_CONNECTING ) {
		return 1;
	}
	if ( cb->pers.connected == CON_CONNECTING ) {
		return -1;
	}


	// then spectators
	if ( ca->sess.sessionTeam == TEAM_SPECTATOR && cb->sess.sessionTeam == TEAM_SPECTATOR ) {
		if ( ca->sess.spectatorTime < cb->sess.spectatorTime ) {
			return -1;
		}
		if ( ca->sess.spectatorTime > cb->sess.spectatorTime ) {
			return 1;
		}
		return 0;
	}
	if ( ca->sess.sessionTeam == TEAM_SPECTATOR ) {
		return 1;
	}
	if ( cb->sess.sessionTeam == TEAM_SPECTATOR ) {
		return -1;
	}

	// then sort by score
	if ( ca->ps.persistant[PERS_SCORE]
		> cb->ps.persistant[PERS_SCORE] ) {
		return -1;
	}
	if ( ca->ps.persistant[PERS_SCORE]
		< cb->ps.persistant[PERS_SCORE] ) {
		return 1;
	}
	return 0;
}

/*
============
CalculateRanks

Recalculates the score ranks of all players
This will be called on every client connect, begin, disconnect, death,
and team change.
============
*/
void CalculateRanks( void ) {
	int		i;
	int		rank;
	int		score;
	int		newScore;
	gclient_t	*cl;

	level.follow1 = -1;
	level.follow2 = -1;
	level.numConnectedClients = 0;
	level.numNonSpectatorClients = 0;
	level.numPlayingClients = 0;
	level.numVotingClients = 0;		// don't count bots
	for ( i = 0; i < TEAM_NUM_TEAMS; i++ ) {
		level.numteamVotingClients[i] = 0;
	}
	for ( i = 0 ; i < level.maxclients ; i++ ) {
		if ( level.clients[i].pers.connected != CON_DISCONNECTED ) {
			level.sortedClients[level.numConnectedClients] = i;
			level.numConnectedClients++;

			if ( level.clients[i].sess.sessionTeam != TEAM_SPECTATOR ) {
				level.numNonSpectatorClients++;
			
				// decide if this should be auto-followed
				if ( level.clients[i].pers.connected == CON_CONNECTED ) {
					level.numPlayingClients++;
					if ( !(g_entities[i].r.svFlags & SVF_BOT) ) {
						level.numVotingClients++;
						if ( level.clients[i].sess.sessionTeam == TEAM_RED )
							level.numteamVotingClients[0]++;
						else if ( level.clients[i].sess.sessionTeam == TEAM_BLUE )
							level.numteamVotingClients[1]++;
					}
					if ( level.follow1 == -1 ) {
						level.follow1 = i;
					} else if ( level.follow2 == -1 ) {
						level.follow2 = i;
					}
				}
			}
		}
	}

	qsort( level.sortedClients, level.numConnectedClients, 
		sizeof(level.sortedClients[0]), SortRanks );

	// set the rank value for all clients that are connected and not spectators
	if ( g_gametype.integer >= GT_TEAM ) {
		// in team games, rank is just the order of the teams, 0=red, 1=blue, 2=tied
		for ( i = 0;  i < level.numConnectedClients; i++ ) {
			cl = &level.clients[ level.sortedClients[i] ];
			if ( level.teamScores[TEAM_RED] == level.teamScores[TEAM_BLUE] ) {
				cl->ps.persistant[PERS_RANK] = 2;
			} else if ( level.teamScores[TEAM_RED] > level.teamScores[TEAM_BLUE] ) {
				cl->ps.persistant[PERS_RANK] = 0;
			} else {
				cl->ps.persistant[PERS_RANK] = 1;
			}
		}
	} else {	
		rank = -1;
		score = 0;
		for ( i = 0;  i < level.numPlayingClients; i++ ) {
			cl = &level.clients[ level.sortedClients[i] ];
			newScore = cl->ps.persistant[PERS_SCORE];
			if ( i == 0 || newScore != score ) {
				rank = i;
				// assume we aren't tied until the next client is checked
				level.clients[ level.sortedClients[i] ].ps.persistant[PERS_RANK] = rank;
			} else {
				// we are tied with the previous client
				level.clients[ level.sortedClients[i-1] ].ps.persistant[PERS_RANK] = rank | RANK_TIED_FLAG;
				level.clients[ level.sortedClients[i] ].ps.persistant[PERS_RANK] = rank | RANK_TIED_FLAG;
			}
			score = newScore;
			if ( g_gametype.integer == GT_SINGLE_PLAYER && level.numPlayingClients == 1 ) {
				level.clients[ level.sortedClients[i] ].ps.persistant[PERS_RANK] = rank | RANK_TIED_FLAG;
			}
		}
	}

	// set the CS_SCORES1/2 configstrings, which will be visible to everyone
	if ( g_gametype.integer >= GT_TEAM ) {
		trap_SetConfigstring( CS_SCORES1, va("%i", level.teamScores[TEAM_RED] ) );
		trap_SetConfigstring( CS_SCORES2, va("%i", level.teamScores[TEAM_BLUE] ) );
	} else {
		if ( level.numConnectedClients == 0 ) {
			trap_SetConfigstring( CS_SCORES1, va("%i", SCORE_NOT_PRESENT) );
			trap_SetConfigstring( CS_SCORES2, va("%i", SCORE_NOT_PRESENT) );
		} else if ( level.numConnectedClients == 1 ) {
			trap_SetConfigstring( CS_SCORES1, va("%i", level.clients[ level.sortedClients[0] ].ps.persistant[PERS_SCORE] ) );
			trap_SetConfigstring( CS_SCORES2, va("%i", SCORE_NOT_PRESENT) );
		} else {
			trap_SetConfigstring( CS_SCORES1, va("%i", level.clients[ level.sortedClients[0] ].ps.persistant[PERS_SCORE] ) );
			trap_SetConfigstring( CS_SCORES2, va("%i", level.clients[ level.sortedClients[1] ].ps.persistant[PERS_SCORE] ) );
		}
	}

	// see if it is time to end the level
/*freeze*/
	if ( g_gametype.integer != GT_FREEZE ) {
		CheckExitRules();
	}
/*freeze*/

	// if we are at the intermission, send the new info to everyone
	if ( level.intermissiontime ) {
		SendScoreboardMessageToAllClients();
		//Stats
		//ConsoleStatsBoard();
		//Cmd_Stats_f( -1 );
	}
}


/*
========================================================================

MAP CHANGING

========================================================================
*/

/*
========================
SendScoreboardMessageToAllClients

Do this at BeginIntermission time and whenever ranks are recalculated
due to enters/exits/forced team changes
========================
*/
void SendScoreboardMessageToAllClients( void ) {
	int		i;

	for ( i = 0 ; i < level.maxclients ; i++ ) {
		if ( level.clients[ i ].pers.connected == CON_CONNECTED ) {
			DeathmatchScoreboardMessage( g_entities + i );
		}
	}
}

/*
========================
MoveClientToIntermission

When the intermission starts, this will be called for all players.
If a new client connects, this will be called after the spawn function.
========================
*/
void MoveClientToIntermission( gentity_t *ent ) {
	// take out of follow mode if needed
	if ( ent->client->sess.spectatorState == SPECTATOR_FOLLOW ) {
		StopFollowing( ent );
	}


	// move to the spot
	VectorCopy( level.intermission_origin, ent->s.origin );
	VectorCopy( level.intermission_origin, ent->client->ps.origin );
	VectorCopy (level.intermission_angle, ent->client->ps.viewangles);
	ent->client->ps.pm_type = PM_INTERMISSION;

	// clean up powerup info
	memset( ent->client->ps.powerups, 0, sizeof(ent->client->ps.powerups) );

	ent->client->ps.eFlags = 0;
	ent->s.eFlags = 0;
	ent->s.eType = ET_GENERAL;
	ent->s.modelindex = 0;
	ent->s.loopSound = 0;
	ent->s.event = 0;
	ent->r.contents = 0;
}

/*
==================
FindIntermissionPoint

This is also used for spectator spawns
==================
*/
void FindIntermissionPoint( void ) {
	gentity_t	*ent, *target;
	vec3_t		dir;

	// find the intermission spot
	ent = G_Find (NULL, FOFS(classname), "info_player_intermission");
	if ( !ent ) {	// the map creator forgot to put in an intermission point...
		SelectSpawnPoint ( vec3_origin, level.intermission_origin, level.intermission_angle );
	} else {
		VectorCopy (ent->s.origin, level.intermission_origin);
		VectorCopy (ent->s.angles, level.intermission_angle);
		// if it has a target, look towards it
		if ( ent->target ) {
			target = G_PickTarget( ent->target );
			if ( target ) {
				VectorSubtract( target->s.origin, level.intermission_origin, dir );
				vectoangles( dir, level.intermission_angle );
			}
		}
	}

}

void GetIntermissionPoint( vec3_t origin, vec3_t angles )  {
	gentity_t	*ent, *target;
	vec3_t		dir;

	// find the intermission spot
	ent = G_Find (NULL, FOFS(classname), "info_player_intermission");
	if ( !ent ) {	// the map creator forgot to put in an intermission point...
		SelectSpawnPoint ( vec3_origin, origin, angles );
	} else {
		VectorCopy (ent->s.origin, origin);
		VectorCopy (ent->s.angles, angles);
		// if it has a target, look towards it
		if ( ent->target ) {
			target = G_PickTarget( ent->target );
			if ( target ) {
				VectorSubtract( target->s.origin, origin, dir );
				vectoangles( dir, angles );
			}
		}
	}
}

/*
==================
BeginIntermission
==================
*/
void BeginIntermission( void ) {
	int			i, ki;
	gentity_t	*client;
	vec3_t		v,a;//monkk, origin and angles of sound temp ent

	
	if ( level.intermissiontime ) {
		return;		// already active
	}

	// if in tournement mode, change the wins / losses
	if ( g_gametype.integer == GT_TOURNAMENT ) {
		AdjustTournamentScores();
	}

	level.intermissiontime = level.time;
	FindIntermissionPoint();

#ifdef MISSIONPACK
	if (g_singlePlayer.integer) {
		trap_Cvar_Set("ui_singlePlayerActive", "0");
		UpdateTournamentInfo();
	}
#else
	// if single player game
	if ( g_gametype.integer == GT_SINGLE_PLAYER ) {
		UpdateTournamentInfo();
		SpawnModelsOnVictoryPads();
	}
#endif

	// move all clients to the intermission point
	for (i=0 ; i< level.maxclients ; i++) {
		client = g_entities + i;
		if (!client->inuse)
			continue;
		// respawn if dead
		if (client->health <= 0) {
			respawn(client);
		}
		MoveClientToIntermission( client );
	}

	// send the current scoring to all clients
	SendScoreboardMessageToAllClients();
	//Stats
	//ConsoleStatsBoard();
	Cmd_Stats_f( -1 );

	G_LogPrintf("***END OF GAME CLIENTS***\n");
	//int ki;
	for ( ki = 0; ki < (int)level.numConnectedClients; ki++ ) {
		G_LogPrintf("ClientNum: %i -- ClientName: %s\n", level.clients[level.sortedClients[ki]].ps.clientNum, level.clients[level.sortedClients[ki]].pers.netname );
	}
	G_LogPrintf("***END OF GAME CLIENTS***\n");

	GetIntermissionPoint(v,a);
	if ( g_gametype.integer == GT_TOURNAMENT ) {
		gentity_t	*tempEnt;
		tempEnt = G_TempEntity( v, EV_GLOBAL_SOUND );
		tempEnt->s.eventParm = G_SoundIndex( "sound/world/buzzer.wav" );
		tempEnt->r.svFlags |= SVF_BROADCAST;
	} else {
		gentity_t	*tempEnt;
		tempEnt = G_TempEntity( v, EV_GLOBAL_SOUND );
		tempEnt->s.eventParm = G_SoundIndex( "sound/teamplay/flagtaken_yourteam_01.wav" );
		tempEnt->r.svFlags |= SVF_BROADCAST;
	}

}

/*
=============
ExitLevel

When the intermission has been exited, the server is either killed
or moved to a new level based on the "nextmap" cvar 

=============
*/
void ExitLevel (void) {
	int		i;
	gclient_t *cl;

	//bot interbreeding
	BotInterbreedEndMatch();

	// if we are running a tournement map, kick the loser to spectator status,
	// which will automatically grab the next spectator and restart
	if ( g_gametype.integer == GT_TOURNAMENT  ) {
		if ( !level.restarted ) {
			RemoveTournamentLoser();
			trap_SendConsoleCommand( EXEC_APPEND, "map_restart 0\n" );
			level.restarted = qtrue;
			level.changemap = NULL;
			level.intermissiontime = 0;
		}
		return;	
	}

	if ( g_gametype.integer == GT_FREEZE ) {
		gentity_t	*ent;
		//Stop following if not a spectator
		for ( i = 0; i < g_maxclients.integer; i++ ) {
			ent = g_entities + i;

			if ( ent->client->sess.spectatorState == SPECTATOR_FOLLOW ) {
				ent->client->sess.spectatorState = SPECTATOR_NOT;
				ent->client->sess.spectatorClient = 0;
				ent->client->ps.pm_flags &= ~PMF_FOLLOW;
				//ent->r.svFlags &= ~SVF_BOT;
				ent->client->ps.clientNum = ent - g_entities;
			}
			ent->freezeState = qfalse;
			ent->freezeThawTime = 0;
		//Unfreeze everyone.
	}


	trap_SendConsoleCommand( EXEC_APPEND, "vstr nextmap\n" );
	level.changemap = NULL;
	level.intermissiontime = 0;

	// reset all the scores so we don't enter the intermission again
	level.teamScores[TEAM_RED] = 0;
	level.teamScores[TEAM_BLUE] = 0;
	for ( i=0 ; i< g_maxclients.integer ; i++ ) {
		cl = level.clients + i;
		if ( cl->pers.connected != CON_CONNECTED ) {
			continue;
		}
		cl->ps.persistant[PERS_SCORE] = 0;
	}

	// we need to do this here before chaning to CON_CONNECTING
	G_WriteSessionData();

	// change all client states to connecting, so the early players into the
	// next level will know the others aren't done reconnecting
	for (i=0 ; i< g_maxclients.integer ; i++) {
		if ( level.clients[i].pers.connected == CON_CONNECTED ) {
			level.clients[i].pers.connected = CON_CONNECTING;
		}
	}

}

/*
=================
G_LogPrintf

Print to the logfile with a time stamp if it is open
=================
*/
void QDECL G_LogPrintf( const char *fmt, ... ) {
	va_list		argptr;
	char		string[1024];
	int			min, tens, sec;

	sec = level.time / 1000;

	min = sec / 60;
	sec -= min * 60;
	tens = sec / 10;
	sec -= tens * 10;

	Com_sprintf( string, sizeof(string), "%3i:%i%i ", min, tens, sec );

	va_start( argptr, fmt );
	vsprintf( string +7 , fmt,argptr );
	va_end( argptr );

	if ( g_dedicated.integer ) {
		G_Printf( "%s", string + 7 );
	}

	if ( !level.logFile ) {
		return;
	}

	trap_FS_Write( string, strlen( string ), level.logFile );
}

/*
================
LogExit

Append information about this game to the log file
================
*/
void LogExit( const char *string ) {
	int				i, numSorted;
	gclient_t		*cl;
#ifdef MISSIONPACK // bk001205
	qboolean won = qtrue;
#endif
	G_LogPrintf( "Exit: %s\n", string );

	level.intermissionQueued = level.time;

	// this will keep the clients from playing any voice sounds
	// that will get cut off when the queued intermission starts
	trap_SetConfigstring( CS_INTERMISSION, "1" );

	// don't send more than 32 scores (FIXME?)
	numSorted = level.numConnectedClients;
	if ( numSorted > 32 ) {
		numSorted = 32;
	}

	if ( g_gametype.integer >= GT_TEAM ) {
		G_LogPrintf( "red:%i  blue:%i\n",
			level.teamScores[TEAM_RED], level.teamScores[TEAM_BLUE] );
	}

	for (i=0 ; i < numSorted ; i++) {
		int		ping;

		cl = &level.clients[level.sortedClients[i]];

		if ( cl->sess.sessionTeam == TEAM_SPECTATOR ) {
			continue;
		}
		if ( cl->pers.connected == CON_CONNECTING ) {
			continue;
		}

		ping = cl->ps.ping < 999 ? cl->ps.ping : 999;

		G_LogPrintf( "score: %i  ping: %i  client: %i %s\n", cl->ps.persistant[PERS_SCORE], ping, level.sortedClients[i],	cl->pers.netname );
#ifdef MISSIONPACK
		if (g_singlePlayer.integer && g_gametype.integer == GT_TOURNAMENT) {
			if (g_entities[cl - level.clients].r.svFlags & SVF_BOT && cl->ps.persistant[PERS_RANK] == 0) {
				won = qfalse;
			}
		}
#endif

	}

#ifdef MISSIONPACK
	if (g_singlePlayer.integer) {
		if (g_gametype.integer >= GT_CTF) {
			won = level.teamScores[TEAM_RED] > level.teamScores[TEAM_BLUE];
		}
		trap_SendConsoleCommand( EXEC_APPEND, (won) ? "spWin\n" : "spLose\n" );
	}
#endif


}


/*
=================
CheckIntermissionExit

The level will stay at the intermission for a minimum of 5 seconds
If all players wish to continue, the level will then exit.
If one or more players have not acknowledged the continue, the game will
wait 10 seconds before going on.
=================
*/
void CheckIntermissionExit( void ) {
	int			ready, notReady;
	int			i;
	gclient_t	*cl;
	int			readyMask;

	if ( g_gametype.integer == GT_SINGLE_PLAYER ) {
		return;
	}

	// see which players are ready
	ready = 0;
	notReady = 0;
	readyMask = 0;
	for (i=0 ; i< g_maxclients.integer ; i++) {
		cl = level.clients + i;
		if ( cl->pers.connected != CON_CONNECTED ) {
			continue;
		}
		if ( g_entities[cl->ps.clientNum].r.svFlags & SVF_BOT ) {
			continue;
		}

		if ( cl->playerReady ) {
			ready++;
			if ( i < 16 ) {
				readyMask |= 1 << i;
			}
		} else {
			notReady++;
		}
	}

	// copy the readyMask to each player's stats so
	// it can be displayed on the scoreboard
	for (i=0 ; i< g_maxclients.integer ; i++) {
		cl = level.clients + i;
		if ( cl->pers.connected != CON_CONNECTED ) {
			continue;
		}
		cl->ps.stats[STAT_CLIENTS_READY] = readyMask;
	}

	// never exit in less than five seconds
	if ( level.time < level.intermissiontime + 5000 ) {
		return;
	}

	// if nobody wants to go, clear timer
/*freeze
	if ( !ready ) {
freeze*/
	if ( (g_gametype.integer != GT_FREEZE && !ready) || (g_gametype.integer == GT_FREEZE && !ready && notReady) ) {
//freeze
		level.readyToExit = qfalse;
		return;
	}

	// if everyone wants to go, go now
	if ( !notReady ) {
		ExitLevel();
		return;
	}

	// the first person to ready starts the ten second timeout
	if ( !level.readyToExit ) {
		level.readyToExit = qtrue;
		level.exitTime = level.time;
	}

	// if we have waited ten seconds since at least one player
	// wanted to exit, go ahead
	if ( level.time < level.exitTime + 10000 ) {
		return;
	}

	ExitLevel();
}

/*
=============
ScoreIsTied
=============
*/
qboolean ScoreIsTied( void ) {
	int		a, b;

	if ( level.numPlayingClients < 2 ) {
		return qfalse;
	}
	
	if ( g_gametype.integer >= GT_TEAM ) {
		return level.teamScores[TEAM_RED] == level.teamScores[TEAM_BLUE];
	}

	a = level.clients[level.sortedClients[0]].ps.persistant[PERS_SCORE];
	b = level.clients[level.sortedClients[1]].ps.persistant[PERS_SCORE];

	return a == b;
}

/*
=================
CheckExitRules

There will be a delay between the time the exit is qualified for
and the time everyone is moved to the intermission spot, so you
can see the last frag.
=================
*/
void CheckExitRules( void ) {
 	int			i;
	gclient_t	*cl;
	// if at the intermission, wait for all non-bots to
	// signal ready, then go to next level
	if ( level.intermissiontime ) {
		CheckIntermissionExit ();
		return;
	}

	if ( level.intermissionQueued ) {
#ifdef MISSIONPACK
		int time = (g_singlePlayer.integer) ? SP_INTERMISSION_DELAY_TIME : INTERMISSION_DELAY_TIME;
		if ( level.time - level.intermissionQueued >= time ) {
			level.intermissionQueued = 0;
			BeginIntermission();
		}
#else
		if ( level.time - level.intermissionQueued >= INTERMISSION_DELAY_TIME ) {
			level.intermissionQueued = 0;
			BeginIntermission();
		}
#endif
		return;
	}

//freeze
	if ( g_gametype.integer == GT_FREEZE ) {
		CheckDelay();
	}
//freeze
	// check for sudden death
	if ( ScoreIsTied() ) {
		// always wait for sudden death
		return;
	}

	if ( g_timelimit.integer && !level.warmupTime ) {
		if ( level.time - level.startTime >= g_timelimit.integer*60000 ) {
			trap_SendServerCommand( -1, "print \"Timelimit hit.\n\"");
			G_LogPrintf("Game_End: Timelimit\n");
			LogExit( "Timelimit hit." );
			//Stats
			//ConsoleStatsBoard();
			//Cmd_Stats_f( NULL, -1 );
			return;
		}
	}

	if ( level.numPlayingClients < 2 ) {
		return;
	}

	if ( g_gametype.integer < GT_CTF && g_fraglimit.integer ) {
		if ( level.teamScores[TEAM_RED] >= g_fraglimit.integer ) {
			trap_SendServerCommand( -1, "print \"Red hit the fraglimit.\n\"" );
			G_LogPrintf("Game_End: Fraglimit\n");
			LogExit( "Fraglimit hit." );
			return;
		}

		if ( level.teamScores[TEAM_BLUE] >= g_fraglimit.integer ) {
			trap_SendServerCommand( -1, "print \"Blue hit the fraglimit.\n\"" );
			G_LogPrintf("Game_End: Fraglimit\n");
			LogExit( "Fraglimit hit." );
			return;
		}

		for ( i=0 ; i< g_maxclients.integer ; i++ ) {
			cl = level.clients + i;
			if ( cl->pers.connected != CON_CONNECTED ) {
				continue;
			}
			if ( cl->sess.sessionTeam != TEAM_FREE ) {
				continue;
			}

			if ( cl->ps.persistant[PERS_SCORE] >= g_fraglimit.integer ) {
				G_LogPrintf("Game_End: Fraglimit\n");
				LogExit( "Fraglimit hit." );
				trap_SendServerCommand( -1, va("print \"%s" S_COLOR_WHITE " hit the fraglimit.\n\"",
					cl->pers.netname ) );
				return;
			}
		}
	}


	if ( g_gametype.integer >= GT_CTF && g_gametype.integer != GT_FREEZE && g_capturelimit.integer ) {
//freeze - reverted 5.10.2013
//	if ( (g_gamemode.integer < 4 && g_gametype.integer >= GT_CTF && g_capturelimit.integer) || 
//		(g_gamemode.integer > 3 && g_gametype.integer >= GT_TEAM && g_capturelimit.integer) ) {
//freeze

		if ( level.teamScores[TEAM_RED] >= g_capturelimit.integer ) {
			trap_SendServerCommand( -1, "print \"Red hit the capturelimit.\n\"" );
			G_LogPrintf("Game_End: Capturelimit\n");
			LogExit( "Capturelimit hit." );
			return;
		}

		if ( level.teamScores[TEAM_BLUE] >= g_capturelimit.integer ) {
			trap_SendServerCommand( -1, "print \"Blue hit the capturelimit.\n\"" );
			G_LogPrintf("Game_End: Capturelimit\n");
			LogExit( "Capturelimit hit." );
			return;
		}
	}
}



/*
========================================================================

FUNCTIONS CALLED EVERY FRAME

========================================================================
*/


/*
=============
CheckTournament

Once a frame, check for changes in tournement player state
=============
*/
void CheckTournament( void ) {
	// check because we run 3 game frames before calling Connect and/or ClientBegin
	// for clients on a map_restart
	if ( level.numPlayingClients == 0 ) {
		return;
	}

	if ( g_gametype.integer == GT_TOURNAMENT ) {

		// pull in a spectator if needed
		if ( level.numPlayingClients < 2 ) {
			AddTournamentPlayer();
		}

		// if we don't have two players, go back to "waiting for players"
		if ( level.numPlayingClients != 2 ) {
			if ( level.warmupTime != -1 ) {
				level.warmupTime = -1;
				trap_SetConfigstring( CS_WARMUP, va("%i", level.warmupTime) );
				G_LogPrintf( "Warmup:\n" );
			}
			return;
		}

		if ( level.warmupTime == 0 ) {
			return;
		}

		// if the warmup is changed at the console, restart it
		if ( g_warmup.modificationCount != level.warmupModificationCount ) {
			level.warmupModificationCount = g_warmup.modificationCount;
			level.warmupTime = -1;
		}

		// if all players have arrived, start the countdown
		if ( level.warmupTime < 0 ) {
			if ( level.numPlayingClients == 2 ) {
				// fudge by -1 to account for extra delays
				//level.warmupTime = level.time + ( g_warmup.integer - 1 ) * 1000;
				level.originalWarmupTime = level.warmupTime = level.time + ( g_warmup.integer - 1 ) * 1000;
				trap_SetConfigstring( CS_WARMUP, va("%i", level.warmupTime) );
			}
			return;
		}

		// if the warmup time has counted down, restart
		if ( level.time > level.warmupTime ) {
			level.warmupTime += 10000;
			trap_Cvar_Set( "g_restarted", "1" );
			trap_SendConsoleCommand( EXEC_APPEND, "map_restart 0\n" );
			level.restarted = qtrue;
			return;
		}
	} else if ( g_gametype.integer != GT_SINGLE_PLAYER && level.warmupTime != 0 ) {
		int		counts[TEAM_NUM_TEAMS];
		qboolean	notEnough = qfalse;

		//counts[TEAM_BLUE] = TeamCount( -1, TEAM_BLUE );
		//counts[TEAM_RED] = TeamCount( -1, TEAM_RED );
		if ( g_gametype.integer >= GT_TEAM ) {
			counts[TEAM_BLUE] = TeamCount( -1, TEAM_BLUE );
			counts[TEAM_RED] = TeamCount( -1, TEAM_RED );

			if (counts[TEAM_RED] < 1 || counts[TEAM_BLUE] < 1) {
				notEnough = qtrue;
			}
		} else if ( level.numPlayingClients < 2 ) {
			notEnough = qtrue;
		}

//freeze
	//	if ( g_gamemode.integer > 3 ) {
	//		if ( !notEnough ) {
	//			notEnough = readyCheck();
	//		}
	//	}
//freeze
		if ( notEnough ) {
		//if ( level.warmupTime != -1 && ( (g_gametype.integer >= GT_TEAM && (counts[TEAM_BLUE] == 0 || counts[TEAM_RED] == 0)) || (g_gametype.integer < GT_TEAM && level.numPlayingClients < 2)) ) {
			if ( level.warmupTime != -1 ) {
				level.warmupTime = -1;
				trap_SetConfigstring( CS_WARMUP, va("%i", level.warmupTime) );
				G_LogPrintf( "Warmup:\n" );
			}
			return; // still waiting for team members
		}

		if ( level.warmupTime == 0 ) {
			return;
		}

		// if the warmup is changed at the console, restart it
		if ( g_warmup.modificationCount != level.warmupModificationCount ) {
			level.warmupModificationCount = g_warmup.modificationCount;
			level.warmupTime = -1;
		}

		// if all players have arrived, start the countdown
		if ( level.warmupTime < 0 ) {
			// fudge by -1 to account for extra delays
			//level.warmupTime = level.time + ( g_warmup.integer - 1 ) * 1000;
			level.originalWarmupTime = level.warmupTime = level.time + ( g_warmup.integer - 1 ) * 1000;
			trap_SetConfigstring( CS_WARMUP, va("%i", level.warmupTime) );
			return;
		}

		// if the warmup time has counted down, restart
		if ( level.time > level.warmupTime ) {
			level.warmupTime += 10000;
			trap_Cvar_Set( "g_restarted", "1" );
			trap_SendConsoleCommand( EXEC_APPEND, "map_restart 0\n" );
			level.restarted = qtrue;
			return;
		}
	}
}

/*
==================
PrintTeam
==================
*/
void PrintTeam(int team, char *message) {
	int i;

	for ( i = 0 ; i < level.maxclients ; i++ ) {
		if (level.clients[i].sess.sessionTeam != team)
			continue;
		trap_SendServerCommand( i, message );
	}
}

/*
==================
SetLeader
==================
*/
void SetLeader(int team, int client) {
	int i;

	if ( level.clients[client].pers.connected == CON_DISCONNECTED ) {
		PrintTeam(team, va("print \"%s is not connected\n\"", level.clients[client].pers.netname) );
		return;
	}
	if (level.clients[client].sess.sessionTeam != team) {
		PrintTeam(team, va("print \"%s is not on the team anymore\n\"", level.clients[client].pers.netname) );
		return;
	}
	for ( i = 0 ; i < level.maxclients ; i++ ) {
		if (level.clients[i].sess.sessionTeam != team)
			continue;
		if (level.clients[i].sess.teamLeader) {
			level.clients[i].sess.teamLeader = qfalse;
			ClientUserinfoChanged(i);
		}
	}
	level.clients[client].sess.teamLeader = qtrue;
	ClientUserinfoChanged( client );
	PrintTeam(team, va("print \"%s is the new team leader\n\"", level.clients[client].pers.netname) );
}

/*
==================
CheckTeamLeader
==================
*/
void CheckTeamLeader( int team ) {
	int i;

	for ( i = 0 ; i < level.maxclients ; i++ ) {
		if (level.clients[i].sess.sessionTeam != team)
			continue;
		if (level.clients[i].sess.teamLeader)
			break;
	}
	if (i >= level.maxclients) {
		for ( i = 0 ; i < level.maxclients ; i++ ) {
			if (level.clients[i].sess.sessionTeam != team)
				continue;
			if (!(g_entities[i].r.svFlags & SVF_BOT)) {
				level.clients[i].sess.teamLeader = qtrue;
				break;
			}
		}
		for ( i = 0 ; i < level.maxclients ; i++ ) {
			if (level.clients[i].sess.sessionTeam != team)
				continue;
			level.clients[i].sess.teamLeader = qtrue;
			break;
		}
	}
}

/*
==================
CheckCvars
==================
*/
void CheckCvars( void ) {
	static int lastMod = -1;

	if ( g_password.modificationCount != lastMod ) {
		lastMod = g_password.modificationCount;
		if ( *g_password.string && Q_stricmp( g_password.string, "none" ) ) {
			trap_Cvar_Set( "g_needpass", "1" );
		} else {
			trap_Cvar_Set( "g_needpass", "0" );
		}
	}
}

/*
=================
CheckTasks()

Runs the time check for tasks, and executes them when needed
=================
*/
void CheckTasks( void ) {
	//tasks_t		*tasks;
	int			i;

	for (i = 0; i < MAX_SERVER_TASKS; i++) {
		if ( tasks[i].sv_task_repeatTime >= 0 ) {
			//G_Printf("runTime[%i]: %i -- level.time: %i\n", i, tasks[i].sv_task_runTime, level.time);
			if (tasks[i].sv_task_startTime <= level.time ) {
				if ( tasks[i].sv_task_runTime < level.time ) {
				//	G_Printf("Task: %i -- Time: %i -- Command: %s\n", i, tasks[i].sv_task_repeatTime, tasks[i].sv_task_command);
					//Set the next run time right away
					tasks[i].sv_task_runTime = level.time + (tasks[i].sv_task_repeatTime * 1000);
					//Exec the command now
					trap_SendConsoleCommand( EXEC_NOW, va("%s", tasks[i].sv_task_command) );
				}
			}

			if ( tasks[i].sv_task_repeatTime == 0 ) {
				//Remove the task
				memset( &(tasks[i]), 0, sizeof(tasks[i]) );
			}
		}
	}
}

/*
=============
G_RunThink

Runs thinking code for this frame if necessary
=============
*/
void G_RunThink (gentity_t *ent) {
	float	thinktime;

	if(level.match_timeout == 1 && (ent - g_entities) >= g_maxclients.integer &&
		ent->nextthink > level.time && strstr(ent->classname, "DPRINTF_") == NULL) {
		ent->nextthink += level.time - level.previousTime;
	}

	thinktime = ent->nextthink;
	if (thinktime <= 0) {
		return;
	}
	if (thinktime > level.time) {
		return;
	}
	
	ent->nextthink = 0;
	if (!ent->think) {
		G_Error ( "NULL ent->think");
	}
	ent->think (ent);
}

/*
================
G_RunFrame

Advances the non-player objects in the world
================
*/
void G_RunFrame( int levelTime ) {
	int			i;
	gentity_t	*ent;
	int			msec;
	int start, end;

//int debugint;

	// mod code start

//	gentity_t*	unlinkedEntities[MAX_GENTITIES];
//	int			j;
	int			unlinked = 0;

    //NT - store the time the frame started
    //level.frameStartTime = trap_Milliseconds();

	// mod code end


	// if we are waiting for the level to restart, do nothing
	if ( level.restarted ) {
		return;
	}

	level.framenum++;
	level.previousTime = level.time;
	level.time = levelTime;
	msec = level.time - level.previousTime;

	// get any cvar changes
	G_UpdateCvars();
	/*if ( g_pro_mode.integer && !level.cpm ) {
		level.cpm = qtrue;
		trap_Cvar_Set("g_quadfactor", "4" ); // pro mode default
		trap_Cvar_Set("g_forcerespawn", "3" );
		trap_Cvar_Set("g_weaponrespawn", "15" );
		trap_Cvar_Set("dmflags", va("%d", g_dmflags.integer | DF_NO_FOOTSTEPS)); // turn off footsteps
	} else if ( !g_pro_mode.integer && level.cpm ) {
		level.cpm = qfalse;
		trap_Cvar_Set("g_quadfactor", "3" ); // q3 default
		trap_Cvar_Set("g_forcerespawn", "20" );
		trap_Cvar_Set("g_weaponrespawn", "5" );
		trap_Cvar_Set("dmflags", va("%d", g_dmflags.integer & ~DF_NO_FOOTSTEPS)); // turn on footsteps
	}*/

	//
	// go through all allocated objects
	//
	start = trap_Milliseconds();
	ent = &g_entities[0];
	for (i=0 ; i<level.num_entities ; i++, ent++) {
		if ( !ent->inuse ) {
			continue;
		}

		// clear events that are too old
		if ( level.time - ent->eventTime > EVENT_VALID_MSEC ) {
			if ( ent->s.event ) {
				ent->s.event = 0;	// &= EV_EVENT_BITS;
				if ( ent->client ) {
					ent->client->ps.externalEvent = 0;
					// predicted events should never be set to zero
					//ent->client->ps.events[0] = 0;
					//ent->client->ps.events[1] = 0;
				}
			}
			if ( ent->freeAfterEvent ) {
				// tempEntities or dropped items completely go away after their event
				G_FreeEntity( ent );
				continue;
			} else if ( ent->unlinkAfterEvent ) {
				// items that will respawn will hide themselves after their pickup event
				ent->unlinkAfterEvent = qfalse;
				//ent->relink = 0;
				trap_UnlinkEntity( ent );
			}
		}

		// temporary entities don't think
		if ( ent->freeAfterEvent ) {
			continue;
		}

		if ( !ent->r.linked && ent->neverFree ) {
			continue;
		}

//unlagged - backward reconciliation #2
		// we'll run missiles separately to save CPU in backward reconciliation
/*
		if ( ent->s.eType == ET_MISSILE ) {
			G_RunMissile( ent );
			continue;
		}
*/
//unlagged - backward reconciliation #2

		if ( ent->s.eType == ET_ITEM || ent->physicsObject ) {
			if ( level.match_timeout == 0 ) {
				G_RunItem( ent );
				//G_Printf("G_RunItem Called\n");
			} else {
				// During a timeout, gotta keep track of stuff in the air
				ent->s.pos.trTime += level.time - level.previousTime;
				G_RunThink(ent);
			}
			continue;
		}

		if ( ent->s.eType == ET_MOVER ) {
			G_RunMover( ent );
			continue;
		}

		if ( i < MAX_CLIENTS ) {
			G_RunClient( ent );
			continue;
		}

		G_RunThink( ent );
	}

//unlagged - backward reconciliation #2
	// NOW run the missiles, with all players backward-reconciled
	// to the positions they were in exactly 50ms ago, at the end
	// of the last server frame
	if ( g_delagProjectiles.integer ) {
		G_TimeShiftAllClients( level.previousTime, NULL );
	}

	ent = &g_entities[0];
	for (i=0 ; i<level.num_entities ; i++, ent++) {
		if ( !ent->inuse ) {
			continue;
		}

		// temporary entities don't think
		if ( ent->freeAfterEvent ) {
			continue;
		}

		if ( ent->s.eType == ET_MISSILE ) {
			if ( level.match_timeout == 0 ) {
				G_RunMissile( ent );
			} else {
				// During a timeout, gotta keep track of stuff in the air
				ent->s.pos.trTime += level.time - level.previousTime;
				ent->nextthink += level.time - level.previousTime;
				G_RunThink(ent);
			}
		}

		/*if ( ent->s.eType == ET_ITEM || ent->physicsObject ) {
			if ( level.match_timeout == 0 ) {
				G_RunItem( ent );
			} else {
				// During a timeout, gotta keep track of stuff in the air
				ent->s.pos.trTime += level.time - level.previousTime;
				G_RunThink(ent);
			}
		}*/
	}

	if ( g_delagProjectiles.integer ) {
		G_UnTimeShiftAllClients( NULL );
	}
	//unlagged - backward reconciliation #2

end = trap_Milliseconds();

start = trap_Milliseconds();
	// perform final fixups on the players
	ent = &g_entities[0];
	for (i=0 ; i < level.maxclients ; i++, ent++ ) {
		if ( ent->inuse ) {
			ClientEndFrame( ent );
		}
	}
end = trap_Milliseconds();

	//Check the server tasks
	CheckTasks();

	// see if it is time to do a tournement restart
	CheckTournament();

	// see if it is time to end the level
	CheckExitRules();

	// update to team status?
	CheckTeamStatus();

	// cancel vote if timed out or execute the command
	if ( level.voteTime && ((level.time - level.voteTime) >= VOTE_TIME) ) {
		level.voteTime = 0;
		//trap_SendServerCommand( -1, "print \"Vote failed.\n\"" );
		trap_SendServerCommand( -1, "vt -1\n" );
	} else if ( level.voteExecuteTime && level.voteExecuteTime < level.time ) {
		level.voteTime = 0;
		level.voteExecuteTime = 0;
		trap_SendConsoleCommand( EXEC_APPEND, va("%s\n", level.voteString ) );
	}

	// cancel vote if time ran out
	if ( level.teamVoteTime[TEAM_RED-1] && (level.time - level.teamVoteTime[TEAM_RED-1]) >= VOTE_TIME) {
		level.teamVoteTime[TEAM_RED-1] = 0;
		//Spike - you really wanna send the vote failed message to only the red team?
		trap_SendServerCommand( -1, "print \"Team vote failed.\n\"" );
		trap_SendServerCommand( -1, va("tv \"%i -1\n\"", TEAM_RED-1) );
	} else if ( level.teamVoteTime[TEAM_BLUE-1] && (level.time - level.teamVoteTime[TEAM_BLUE-1]) >= VOTE_TIME) {
		level.teamVoteTime[TEAM_BLUE-1] = 0;
		//Spike - you really wanna send the vote failed message to only the blue team?
		trap_SendServerCommand( -1, "print \"Team vote failed.\n\"" );
		trap_SendServerCommand( -1, va("tv \"%i -1\n\"", TEAM_BLUE-1) );
	}

	// for tracking changes
	CheckCvars();

	/*We don't need this
	if (g_listEntity.integer) {
		for (i = 0; i < MAX_GENTITIES; i++) {
			G_Printf("%4i: %s\n", i, g_entities[i].classname);
		}
		trap_Cvar_Set("g_listEntity", "0");
	}*/

//unlagged - backward reconciliation #4
	// record the time at the end of this frame - it should be about
	// the time the next frame begins - when the server starts
	// accepting commands from connected clients
	level.frameStartTime = trap_Milliseconds();
//unlagged - backward reconciliation #4
}

