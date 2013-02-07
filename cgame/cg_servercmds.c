// Copyright (C) 1999-2000 Id Software, Inc.
//
// cg_servercmds.c -- reliably sequenced text commands sent by the server
// these are processed at snapshot transition time, so there will definately
// be a valid snapshot this frame

#include "cg_local.h"
#include "../../ui/menudef.h" // bk001205 - for Q3_ui as well
#include "..\game\bg_promode.h" // CPM

typedef struct {
	const char *order;
	int taskNum;
} orderTask_t;

static const orderTask_t validOrders[] = {
	{ VOICECHAT_GETFLAG,						TEAMTASK_OFFENSE },
	{ VOICECHAT_OFFENSE,						TEAMTASK_OFFENSE },
	{ VOICECHAT_DEFEND,							TEAMTASK_DEFENSE },
	{ VOICECHAT_DEFENDFLAG,					TEAMTASK_DEFENSE },
	{ VOICECHAT_PATROL,							TEAMTASK_PATROL },
	{ VOICECHAT_CAMP,								TEAMTASK_CAMP },
	{ VOICECHAT_FOLLOWME,						TEAMTASK_FOLLOW },
	{ VOICECHAT_RETURNFLAG,					TEAMTASK_RETRIEVE },
	{ VOICECHAT_FOLLOWFLAGCARRIER,	TEAMTASK_ESCORT }
};

static const int numValidOrders = sizeof(validOrders) / sizeof(orderTask_t);

#ifdef MISSIONPACK // bk001204
static int CG_ValidOrder(const char *p) {
	int i;
	for (i = 0; i < numValidOrders; i++) {
		if (Q_stricmp(p, validOrders[i].order) == 0) {
			return validOrders[i].taskNum;
		}
	}
	return -1;
}
#endif

/*
=================
CG_NewParseScores

=================
*/
static void CG_NewParseScores() {
	char string[1024];
	byte bytez[1024];
	int i = 0, j = 1, position = 0, total = 0;

	trap_Argv( j++, string, sizeof( string ) );

	memset( cg.scores, 0, sizeof( cg.scores ) );
	memset(bytez, 0, sizeof(bytez));
	memcpy(bytez, string, sizeof(bytez));

	//position += 3;
	if ( cg.dbgScoreboard ) {
		CG_Printf("%s\n", string);
		do {
			CG_Printf("^6DBG:CLT: %i -- %d\n", position, bytez[position++]);
		} while ( position != 1400 && bytez[position] != 0 );
	}
	//total = position;
	position = 0;

	//Grab the first info
	cg.numScores = (int)bytez[position++] - 40;
	if ( cg.numScores == 0 ) {
		CG_Printf("^1ERROR: Client recieved possible 0 scores\n");
	}
	cg.teamScores[0] = (int)bytez[position++] - 40;//Red
	cg.teamScores[1] = (int)bytez[position++] - 40;//Blue
	cgs.picked_up = (int)bytez[position++] - 40;

	
	do {
		//Grab client num
		cg.scores[i].client = (int)bytez[position++] - 40;
		//Grab ping
		cg.scores[i].ping = (bytez[position] - 64) * 63 + (bytez[position+1] - 64);
		position += 2;
		//switch on ping
		switch ( cg.scores[i].ping ) {
			case 4032:
				cg.scores[i].ping = 999;
				cg.scores[i].time = (bytez[position] - 64) * 63 + (bytez[position+1] - 64);
				position += 2;
				break;

			case 4031:
				cg.scores[i].ping = -1;
				cg.scores[i].time = (bytez[position] - 64) * 63 + (bytez[position+1] - 64);
				position += 2;
				break;

			default:
				cg.scores[i].time = (bytez[position] - 64) * 63 + (bytez[position+1] - 64);		
				position += 2;

					switch ( cgs.clientinfo[cg.scores[i].client].team ) {
						case TEAM_SPECTATOR:
							break;//We have everything
						default:
							cg.scores[i].score = (bytez[position] - 64) * 63 + (bytez[position+1] - 64);
							position += 2;
							cg.scores[i].scoreFlags = (bytez[position] - 64) * 63 + (bytez[position+1] - 64);
							position += 2;
							cgs.clientinfo[cg.scores[i].client].powerups = bytez[position++] - 40;
							cg.scores[i].accuracy = (bytez[position] - 64) * 63 + (bytez[position+1] - 64);
							if ( cg.scores[i].accuracy > 100 ) {
								cg.scores[i].accuracy -= 100;
								cg.scores[i].score *= -1;
							}
							position += 2;
							cg.scores[i].impressiveCount = (bytez[position] - 64) * 63 + (bytez[position+1] - 64);
							position += 2;
							cg.scores[i].excellentCount = (bytez[position] - 64) * 63 + (bytez[position+1] - 64);
							position += 2;
							cg.scores[i].guantletCount = (bytez[position] - 64) * 63 + (bytez[position+1] - 64);
							position += 2;
							cg.scores[i].defendCount = (bytez[position] - 64) * 63 + (bytez[position+1] - 64);
							position += 2;
							cg.scores[i].assistCount = (bytez[position] - 64) * 63 + (bytez[position+1] - 64);
							position += 2;
							cg.scores[i].perfect = bytez[position++] - 40;
							cg.scores[i].captures = (bytez[position] - 64) * 63 + (bytez[position+1] - 64);
							position += 2;
							cg.scores[i].shots[WP_GAUNTLET] = (bytez[position] - 64) * 63 + (bytez[position+1] - 64);
							position += 2;
							cg.scores[i].shots[WP_MACHINEGUN] = (bytez[position] - 64) * 63 + (bytez[position+1] - 64);
							position += 2;
							cg.scores[i].shots[WP_SHOTGUN] = (bytez[position] - 64) * 63 + (bytez[position+1] - 64);
							position += 2;
							cg.scores[i].shots[WP_GRENADE_LAUNCHER] = (bytez[position] - 64) * 63 + (bytez[position+1] - 64);
							position += 2;
							cg.scores[i].shots[WP_ROCKET_LAUNCHER] = (bytez[position] - 64) * 63 + (bytez[position+1] - 64);
							position += 2;
							cg.scores[i].shots[WP_LIGHTNING] = (bytez[position] - 64) * 63 + (bytez[position+1] - 64);
							position += 2;
							cg.scores[i].shots[WP_RAILGUN] = (bytez[position] - 64) * 63 + (bytez[position+1] - 64);
							position += 2;
							cg.scores[i].shots[WP_PLASMAGUN] = (bytez[position] - 64) * 63 + (bytez[position+1] - 64);
							position += 2;
							cg.scores[i].shots[WP_BFG] = (bytez[position] - 64) * 63 + (bytez[position+1] - 64);
							position += 2;
							cg.scores[i].hits[WP_GAUNTLET] = (bytez[position] - 64) * 63 + (bytez[position+1] - 64);
							position += 2;
							cg.scores[i].hits[WP_MACHINEGUN] = (bytez[position] - 64) * 63 + (bytez[position+1] - 64);
							position += 2;
							cg.scores[i].hits[WP_SHOTGUN] = (bytez[position] - 64) * 63 + (bytez[position+1] - 64);
							position += 2;
							cg.scores[i].hits[WP_GRENADE_LAUNCHER] = (bytez[position] - 64) * 63 + (bytez[position+1] - 64);
							position += 2;
							cg.scores[i].hits[WP_ROCKET_LAUNCHER] = (bytez[position] - 64) * 63 + (bytez[position+1] - 64);
							position += 2;
							cg.scores[i].hits[WP_LIGHTNING] = (bytez[position] - 64) * 63 + (bytez[position+1] - 64);
							position += 2;
							cg.scores[i].hits[WP_RAILGUN] = (bytez[position] - 64) * 63 + (bytez[position+1] - 64);
							position += 2;
							cg.scores[i].hits[WP_PLASMAGUN] = (bytez[position] - 64) * 63 + (bytez[position+1] - 64);
							position += 2;
							cg.scores[i].hits[WP_BFG] = (bytez[position] - 64) * 63 + (bytez[position+1] - 64);
							position += 2;
							cg.scores[i].deaths = (bytez[position] - 64) * 63 + (bytez[position+1] - 64);
							position += 2;
							cg.scores[i].specnum = bytez[position++] - 40;
					}
		}

		cgs.clientinfo[ cg.scores[i].client ].score = cg.scores[i].score;
		cg.scores[i].team = cgs.clientinfo[cg.scores[i].client].team;
		cg.numTeamPlayers[cg.scores[i].team]++;
		//if ( cg.dbgScoreboard ) {
			//CG_Printf("i: %i < cg.%i && position: %i < total: %i\n", i, cg.numScores, position, total);
		//}
		i++;
		if ( i < cg.numScores )
			trap_Argv( j++, string, sizeof( string ) );
	} while (i < cg.numScores);// && position < total);
}


/*
=================
CG_ParseScores

=================
*/
#define NUM1	32
static void CG_ParseScores( void ) {
	int		i, powerups;
	byte	do_we_memset = 0;


	do_we_memset = atoi( CG_Argv( 1 ) );
	if ( do_we_memset == 99 ) {
			cg.numScores = atoi( CG_Argv( 2 ) );
		if ( cg.numScores > MAX_CLIENTS ) {
			cg.numScores = MAX_CLIENTS;
		}

		cg.teamScores[0] = atoi( CG_Argv( 3 ) );//Red
		cg.teamScores[1] = atoi( CG_Argv( 4 ) );//Blue

		cgs.picked_up = atoi( CG_Argv( 5 ) );
		memset( cg.scores, 0, sizeof( cg.scores ) );
		cg.numScoreParse = 0;
		CG_Printf("^3%i %i %i %i\n", cg.numScores, cg.teamScores[0], cg.teamScores[1], cgs.picked_up);
	} else {
		i = 0;

		cg.scores[cg.numScoreParse].client = atoi( CG_Argv( i * NUM1 + 1 ) );
		cg.scores[cg.numScoreParse].score = atoi( CG_Argv( i * NUM1 + 2 ) );
		cg.scores[cg.numScoreParse].ping = atoi( CG_Argv( i * NUM1 + 3 ) );
		cg.scores[cg.numScoreParse].time = atoi( CG_Argv( i * NUM1 + 4 ) );
		cg.scores[cg.numScoreParse].scoreFlags = atoi( CG_Argv( i * NUM1 + 5 ) );
		powerups = atoi( CG_Argv( i * NUM1 + 6 ) );
		cg.scores[cg.numScoreParse].accuracy = atoi(CG_Argv(i * NUM1 + 7));
		cg.scores[cg.numScoreParse].impressiveCount = atoi(CG_Argv(i * NUM1 + 8));
		cg.scores[cg.numScoreParse].excellentCount = atoi(CG_Argv(i * NUM1 + 9));
		cg.scores[cg.numScoreParse].guantletCount = atoi(CG_Argv(i * NUM1 + 10));
		cg.scores[cg.numScoreParse].defendCount = atoi(CG_Argv(i * NUM1 + 11));
		cg.scores[cg.numScoreParse].assistCount = atoi(CG_Argv(i * NUM1 + 12));
		cg.scores[cg.numScoreParse].perfect = atoi(CG_Argv(i * NUM1 + 13));
		cg.scores[cg.numScoreParse].captures = atoi(CG_Argv(i * NUM1 + 14));
		cg.scores[cg.numScoreParse].shots[WP_GAUNTLET] = atoi(CG_Argv(i * NUM1 + 15));
		cg.scores[cg.numScoreParse].shots[WP_MACHINEGUN] = atoi(CG_Argv(i * NUM1 + 16));
		cg.scores[cg.numScoreParse].shots[WP_SHOTGUN] = atoi(CG_Argv(i * NUM1 + 17));
		cg.scores[cg.numScoreParse].shots[WP_GRENADE_LAUNCHER] = atoi(CG_Argv(i * NUM1 + 18));
		cg.scores[cg.numScoreParse].shots[WP_ROCKET_LAUNCHER] = atoi(CG_Argv(i * NUM1 + 19));
		cg.scores[cg.numScoreParse].shots[WP_LIGHTNING] = atoi(CG_Argv(i * NUM1 + 20));
		cg.scores[cg.numScoreParse].shots[WP_RAILGUN] = atoi(CG_Argv(i * NUM1 + 21));
		cg.scores[cg.numScoreParse].shots[WP_PLASMAGUN] = atoi(CG_Argv(i * NUM1 + 22));
		cg.scores[cg.numScoreParse].shots[WP_BFG] = atoi(CG_Argv(i * NUM1 + 23));
		cg.scores[cg.numScoreParse].hits[WP_GAUNTLET] = atoi(CG_Argv(i * NUM1 + 24));
		cg.scores[cg.numScoreParse].hits[WP_MACHINEGUN] = atoi(CG_Argv(i * NUM1 + 25));
		cg.scores[cg.numScoreParse].hits[WP_SHOTGUN] = atoi(CG_Argv(i * NUM1 + 26));
		cg.scores[cg.numScoreParse].hits[WP_GRENADE_LAUNCHER] = atoi(CG_Argv(i * NUM1 + 27));
		cg.scores[cg.numScoreParse].hits[WP_ROCKET_LAUNCHER] = atoi(CG_Argv(i * NUM1 + 28));
		cg.scores[cg.numScoreParse].hits[WP_LIGHTNING] = atoi(CG_Argv(i * NUM1 + 29));
		cg.scores[cg.numScoreParse].hits[WP_RAILGUN] = atoi(CG_Argv(i * NUM1 + 30));
		cg.scores[cg.numScoreParse].hits[WP_PLASMAGUN] = atoi(CG_Argv(i * NUM1 + 31));
		cg.scores[cg.numScoreParse].hits[WP_BFG] = atoi(CG_Argv(i * NUM1 + 32));
		cg.scores[cg.numScoreParse].deaths = atoi(CG_Argv(i * NUM1 + 33));
		cg.scores[cg.numScoreParse].specnum = atoi(CG_Argv(i * NUM1 + 34)); //Lucron: specspy

		if ( cg.scores[cg.numScoreParse].client < 0 || cg.scores[cg.numScoreParse].client >= MAX_CLIENTS ) {
			cg.scores[cg.numScoreParse].client = 0;
		}
		cgs.clientinfo[ cg.scores[cg.numScoreParse].client ].score = cg.scores[cg.numScoreParse].score;
		cgs.clientinfo[ cg.scores[cg.numScoreParse].client ].powerups = powerups;
		cg.scores[cg.numScoreParse].team = cgs.clientinfo[cg.scores[cg.numScoreParse].client].team;
		cg.numTeamPlayers[cg.scores[cg.numScoreParse].team]++;
		cg.numScoreParse++;
	}
#ifdef MISSIONPACK
	CG_SetScoreSelection(NULL);
#endif

}

/*
=================
CG_UpdCvar

=================
*/
static void CG_UpdCvar( void ) {
	int		cvarNum, value;

	cvarNum = atoi( CG_Argv( 1 ) );
	value = atoi( CG_Argv( 2 ) );
	if ( cvarNum == 1 && rate.integer < value ) {
		//Update rate
		trap_SendConsoleCommand(va("rate %i", value));
		//Setup the new minimum for clamping and such
		cgs.minRate = value;
	} else if ( cvarNum == 2 ) {
		if ( value > -2 ) {
			trap_SendConsoleCommand(va("cg_railHum %i", value));
		}
		cgs.railHum = value;

	} else {
		char	cvar_name[128], cvar_value[32];
		Q_strncpyz( cvar_name, CG_Argv( 1 ), sizeof(cvar_name) );
		Q_strncpyz( cvar_value, CG_Argv( 2 ), sizeof(cvar_value) );
		trap_Cvar_Set(cvar_name, cvar_value);
	}

}
#define NUM_CONN_VARS 14 //13+1
/*
=================
CG_ConnUCv()
=================
*/
void CG_ConnUCv() {
	int cvarValue;
	int i = 0;
	char cvar_value[8];

	do {
		i++;
		cvarValue = atoi( CG_Argv( i ) );
		memset(cvar_value, 0, sizeof(cvar_value));
		Q_strncpyz( cvar_value, CG_Argv( i ), sizeof(cvar_value) );
		if ( i == 1 ) {
			//Update rate
			if ( rate.integer < cvarValue ) {
				trap_SendConsoleCommand(va("rate %i", cvarValue));
			}
			//Setup the new minimum for clamping and such
			cgs.minRate = cvarValue;
		} else if ( i == 2 ) {
			if ( cvarValue > -2 ) {
				trap_SendConsoleCommand(va("cg_railHum %i", cvarValue));
			}
			cgs.railHum = cvarValue;
		} else if ( i == 3 ) {
			trap_Cvar_Set("weap_gauntletCycle", cvar_value);
		} else if ( i == 4 ) {
			trap_Cvar_Set("weap_machinegunCycle", cvar_value);
		} else if ( i == 5 ) {
			trap_Cvar_Set("weap_shotgunCycle", cvar_value);
		} else if ( i == 6 ) {
			trap_Cvar_Set("weap_grenadelauncherCycle", cvar_value);
		} else if ( i == 7 ) {
			trap_Cvar_Set("weap_lightninggunCycle", cvar_value);
		} else if ( i == 8 ) {
			trap_Cvar_Set("weap_rocketlauncherCycle", cvar_value);
		} else if ( i == 9 ) {
			trap_Cvar_Set("weap_railgunCycle", cvar_value);
		} else if ( i == 10 ) {
			trap_Cvar_Set("weap_plasmagunCycle", cvar_value);
		} else if ( i == 11 ) {
			trap_Cvar_Set("weap_bfgCycle", cvar_value);
		} else if ( i == 12 ) {
			trap_Cvar_Set("g_DynamicGauntletCycle", cvar_value);
		} else if ( i == 13 ) {
			cgs.allowedWeapons = cvarValue;
		}

	} while ( i < NUM_CONN_VARS );

}

/*
=================
CG_ParseTeamInfo

=================
*/
static void CG_ParseTeamInfo( void ) {
	int		i;
	int		client;

	numSortedTeamPlayers = atoi( CG_Argv( 1 ) );

	for ( i = 0 ; i < numSortedTeamPlayers ; i++ ) {
		client = atoi( CG_Argv( i * 6 + 2 ) );

		sortedTeamPlayers[i] = client;

		cgs.clientinfo[ client ].location = atoi( CG_Argv( i * 6 + 3 ) );
		cgs.clientinfo[ client ].health = atoi( CG_Argv( i * 6 + 4 ) );
		cgs.clientinfo[ client ].armor = atoi( CG_Argv( i * 6 + 5 ) );
		cgs.clientinfo[ client ].curWeapon = atoi( CG_Argv( i * 6 + 6 ) );
		cgs.clientinfo[ client ].powerups = atoi( CG_Argv( i * 6 + 7 ) );
	}
}


/*
================
CG_ParseServerinfo

This is called explicitly when the gamestate is first received,
and whenever the server updates any serverinfo flagged cvars
================
*/
void CG_ParseServerinfo( void ) {
	const char	*info;
	char	*mapname;

	info = CG_ConfigString( CS_SERVERINFO );
	cgs.gametype = atoi( Info_ValueForKey( info, "g_gametype" ) );
	trap_Cvar_Set("g_gametype", va("%i", cgs.gametype));
	cgs.dmflags = atoi( Info_ValueForKey( info, "dmflags" ) );
	cgs.teamflags = atoi( Info_ValueForKey( info, "teamflags" ) );
	cgs.fraglimit = atoi( Info_ValueForKey( info, "fraglimit" ) );
	cgs.capturelimit = atoi( Info_ValueForKey( info, "capturelimit" ) );
	cgs.timelimit = atoi( Info_ValueForKey( info, "timelimit" ) );
	cgs.maxclients = atoi( Info_ValueForKey( info, "sv_maxclients" ) );
	mapname = Info_ValueForKey( info, "mapname" );
	Com_sprintf( cgs.mapname, sizeof( cgs.mapname ), "maps/%s.bsp", mapname );
	Q_strncpyz( cgs.redTeam, Info_ValueForKey( info, "g_redTeam" ), sizeof(cgs.redTeam) );
	trap_Cvar_Set("g_redTeam", cgs.redTeam);
	Q_strncpyz( cgs.blueTeam, Info_ValueForKey( info, "g_blueTeam" ), sizeof(cgs.blueTeam) );
	trap_Cvar_Set("g_blueTeam", cgs.blueTeam);

//unlagged - server options
	// we'll need this for deciding whether or not to predict weapon effects
	cgs.delagHitscan = atoi( Info_ValueForKey( info, "g_delagHitscan" ) );
	trap_Cvar_Set("g_delagHitscan", va("%i", cgs.delagHitscan));
//unlagged - server options
	cgs.minRate = atoi( Info_ValueForKey( info, "sv_minRate" ) );
}

/*
==================
CG_ParseWarmup
==================
*/
static void CG_ParseWarmup( void ) {
	const char	*info;
	int			warmup;

	info = CG_ConfigString( CS_WARMUP );

	warmup = atoi( info );
	cg.warmupCount = -1;

	if ( warmup == 0 && cg.warmup ) {

	} else if ( warmup > 0 && cg.warmup <= 0 ) {
#ifdef MISSIONPACK
		if (cgs.gametype >= GT_CTF && cgs.gametype <= GT_HARVESTER) {
			trap_S_StartLocalSound( cgs.media.countPrepareTeamSound, CHAN_ANNOUNCER );
		} else
#endif
		{
			trap_S_StartLocalSound( cgs.media.countPrepareSound, CHAN_ANNOUNCER );
		}
	}

	cg.warmup = warmup;
}

/*
================
CG_SetConfigValues

Called on load to set the initial values from configure strings
================
*/
void CG_SetConfigValues( void ) {
	const char *s;

	cgs.scores1 = atoi( CG_ConfigString( CS_SCORES1 ) );
	cgs.scores2 = atoi( CG_ConfigString( CS_SCORES2 ) );
	cgs.levelStartTime = atoi( CG_ConfigString( CS_LEVEL_START_TIME ) );
	if( cgs.gametype == GT_CTF ) {
		s = CG_ConfigString( CS_FLAGSTATUS );
		cgs.flags[TEAM_RED-1] = s[0] - '0';
		cgs.flags[TEAM_BLUE-1] = s[1] - '0';
	}
#ifdef MISSIONPACK
	else if( cgs.gametype == GT_1FCTF ) {
		s = CG_ConfigString( CS_FLAGSTATUS );
		cgs.flagStatus = s[0] - '0';
	}
#endif
	cg.warmup = atoi( CG_ConfigString( CS_WARMUP ) );
}

/*
=====================
CG_ShaderStateChanged
=====================
*/
void CG_ShaderStateChanged(void) {
	char originalShader[MAX_QPATH];
	char newShader[MAX_QPATH];
	char timeOffset[16];
	const char *o;
	char *n,*t;

	o = CG_ConfigString( CS_SHADERSTATE );
	while (o && *o) {
		n = strstr(o, "=");
		if (n && *n) {
			strncpy(originalShader, o, n-o);
			originalShader[n-o] = 0;
			n++;
			t = strstr(n, ":");
			if (t && *t) {
				strncpy(newShader, n, t-n);
				newShader[t-n] = 0;
			} else {
				break;
			}
			t++;
			o = strstr(t, "@");
			if (o) {
				strncpy(timeOffset, t, o-t);
				timeOffset[o-t] = 0;
				o++;
				trap_R_RemapShader( originalShader, newShader, timeOffset );
			}
		} else {
			break;
		}
	}
}

/*
================
CG_ConfigStringModified

================
*/
static void CG_ConfigStringModified( void ) {
	const char	*str;
	int		num;

	num = atoi( CG_Argv( 1 ) );

	// get the gamestate from the client system, which will have the
	// new configstring already integrated
	trap_GetGameState( &cgs.gameState );

	// look up the individual string that was modified
	str = CG_ConfigString( num );

	// do something with it if necessary
	if ( num == CS_MUSIC ) {
		CG_StartMusic();
	} else if ( num == CS_SERVERINFO ) {
		CG_ParseServerinfo();
	} else if ( num == CS_WARMUP ) {
		CG_ParseWarmup();
	} else if ( num == CS_SCORES1 ) {
		cgs.scores1 = atoi( str );
	} else if ( num == CS_SCORES2 ) {
		cgs.scores2 = atoi( str );
	} else if ( num == CS_LEVEL_START_TIME ) {
		cgs.levelStartTime = atoi( str );
	/*} else if ( num == CS_VOTE_TIME ) {
		cgs.voteTime = atoi( str );
		cgs.voteModified = qtrue;
	} else if ( num == CS_VOTE_YES ) {
		cgs.voteYes = atoi( str );
		cgs.voteModified = qtrue;
	} else if ( num == CS_VOTE_NO ) {
		cgs.voteNo = atoi( str );
		cgs.voteModified = qtrue;
	} else if ( num == CS_VOTE_STRING ) {
		Q_strncpyz( cgs.voteString, str, sizeof( cgs.voteString ) );*/
#ifdef MISSIONPACK
		trap_S_StartLocalSound( cgs.media.voteNow, CHAN_ANNOUNCER );
#endif //MISSIONPACK
	/*} else if ( num >= CS_TEAMVOTE_TIME && num <= CS_TEAMVOTE_TIME + 1) {
		cgs.teamVoteTime[num-CS_TEAMVOTE_TIME] = atoi( str );
		cgs.teamVoteModified[num-CS_TEAMVOTE_TIME] = qtrue;
	} else if ( num >= CS_TEAMVOTE_YES && num <= CS_TEAMVOTE_YES + 1) {
		cgs.teamVoteYes[num-CS_TEAMVOTE_YES] = atoi( str );
		cgs.teamVoteModified[num-CS_TEAMVOTE_YES] = qtrue;
	} else if ( num >= CS_TEAMVOTE_NO && num <= CS_TEAMVOTE_NO + 1) {
		cgs.teamVoteNo[num-CS_TEAMVOTE_NO] = atoi( str );
		cgs.teamVoteModified[num-CS_TEAMVOTE_NO] = qtrue;
	} else if ( num >= CS_TEAMVOTE_STRING && num <= CS_TEAMVOTE_STRING + 1) {
		Q_strncpyz( cgs.teamVoteString[num-CS_TEAMVOTE_STRING], str, sizeof( cgs.teamVoteString ) );*/
#ifdef MISSIONPACK
		trap_S_StartLocalSound( cgs.media.voteNow, CHAN_ANNOUNCER );
#endif
	} else if ( num == CS_INTERMISSION ) {
		cg.intermissionStarted = atoi( str );
	} else if ( num >= CS_MODELS && num < CS_MODELS+MAX_MODELS ) {
		cgs.gameModels[ num-CS_MODELS ] = trap_R_RegisterModel( str );
	} else if ( num >= CS_SOUNDS && num < CS_SOUNDS+MAX_MODELS ) {
		if ( str[0] != '*' ) {	// player specific sounds don't register here
			cgs.gameSounds[ num-CS_SOUNDS] = trap_S_RegisterSound( str, qfalse );
		}
	} else if ( num >= CS_PLAYERS && num < CS_PLAYERS+MAX_CLIENTS ) {
		CG_NewClientInfo( num - CS_PLAYERS );
		CG_BuildSpectatorString();
	} else if ( num == CS_FLAGSTATUS ) {
		if( cgs.gametype == GT_CTF ) {
			// format is rb where its red/blue, 0 is at base, 1 is taken, 2 is dropped
			cgs.flags[TEAM_RED-1] = str[0] - '0';
			cgs.flags[TEAM_BLUE-1] = str[1] - '0';
		}
#ifdef MISSIONPACK
		else if( cgs.gametype == GT_1FCTF ) {
			cgs.flagStatus = str[0] - '0';
		}
#endif
	}
	else if ( num == CS_SHADERSTATE ) {
		CG_ShaderStateChanged();
	}
	// CPM
		else if ( num == CS_PRO_MODE )
		{
			CPM_UpdateSettings( (atoi(str)) ? ((cgs.gametype == GT_TEAM) ? 2 : 1) : 0 );
		}
	// !CPM
		
}


/*
=======================
CG_AddToTeamChat

=======================
*/
static void CG_AddToTeamChat( const char *str ) {
	int len;
	char *p, *ls;
	int lastcolor;
	int chatHeight;

	if (cg_teamChatHeight.integer < TEAMCHAT_HEIGHT) {
		chatHeight = cg_teamChatHeight.integer;
	} else {
		chatHeight = TEAMCHAT_HEIGHT;
	}

	if (chatHeight <= 0 || cg_teamChatTime.integer <= 0) {
		// team chat disabled, dump into normal chat
		cgs.teamChatPos = cgs.teamLastChatPos = 0;
		return;
	}

	len = 0;

	p = cgs.teamChatMsgs[cgs.teamChatPos % chatHeight];
	*p = 0;

	lastcolor = '7';

	ls = NULL;
	while (*str) {
		if (len > TEAMCHAT_WIDTH - 1) {
			if (ls) {
				str -= (p - ls);
				str++;
				p -= (p - ls);
			}
			*p = 0;

			cgs.teamChatMsgTimes[cgs.teamChatPos % chatHeight] = cg.time;

			cgs.teamChatPos++;
			p = cgs.teamChatMsgs[cgs.teamChatPos % chatHeight];
			*p = 0;
			*p++ = Q_COLOR_ESCAPE;
			*p++ = lastcolor;
			len = 0;
			ls = NULL;
		}

		if ( Q_IsColorString( str ) ) {
			*p++ = *str++;
			lastcolor = *str;
			*p++ = *str++;
			continue;
		}
		if (*str == ' ') {
			ls = p;
		}
		*p++ = *str++;
		len++;
	}
	*p = 0;

	cgs.teamChatMsgTimes[cgs.teamChatPos % chatHeight] = cg.time;
	cgs.teamChatPos++;

	if (cgs.teamChatPos - cgs.teamLastChatPos > chatHeight)
		cgs.teamLastChatPos = cgs.teamChatPos - chatHeight;
}

/*
===============
CG_MapRestart

The server has issued a map_restart, so the next snapshot
is completely new and should not be interpolated to.

A tournement restart will clear everything, but doesn't
require a reload of all the media
===============
*/
static void CG_MapRestart( void ) {
	if ( cg_showmiss.integer ) {
		CG_Printf( "CG_MapRestart\n" );
	}

	CG_InitLocalEntities();
	CG_InitMarkPolys();
	CG_ClearParticles ();

	// make sure the "3 frags left" warnings play again
	cg.fraglimitWarnings = 0;

	cg.timelimitWarnings = 0;

	cg.intermissionStarted = qfalse;

	cgs.voteTime = 0;

	cg.mapRestart = qtrue;

	CG_StartMusic();

	trap_S_ClearLoopingSounds(qtrue);

	// we really should clear more parts of cg here and stop sounds

	// play the "fight" sound if this is a restart without warmup
	if ( cg.warmup == 0 /* && cgs.gametype == GT_TOURNAMENT */) {
		trap_S_StartLocalSound( cgs.media.countFightSound, CHAN_ANNOUNCER );
		//CG_CenterPrint( "FIGHT!", 120, GIANTCHAR_WIDTH*2 );
	}
#ifdef MISSIONPACK
	if (cg_singlePlayerActive.integer) {
		trap_Cvar_Set("ui_matchStartTime", va("%i", cg.time));
		if (cg_recordSPDemo.integer && cg_recordSPDemoName.string && *cg_recordSPDemoName.string) {
			trap_SendConsoleCommand(va("set g_synchronousclients 1 ; record %s \n", cg_recordSPDemoName.string));
		}
	}
#endif
	trap_Cvar_Set("cg_thirdPerson", "0");
}

#define MAX_VOICEFILESIZE	16384
#define MAX_VOICEFILES		8
#define MAX_VOICECHATS		64
#define MAX_VOICESOUNDS		64
#define MAX_CHATSIZE		64
#define MAX_HEADMODELS		64

typedef struct voiceChat_s
{
	char id[64];
	int numSounds;
	sfxHandle_t sounds[MAX_VOICESOUNDS];
	char chats[MAX_VOICESOUNDS][MAX_CHATSIZE];
} voiceChat_t;

typedef struct voiceChatList_s
{
	char name[64];
	int gender;
	int numVoiceChats;
	voiceChat_t voiceChats[MAX_VOICECHATS];
} voiceChatList_t;

typedef struct headModelVoiceChat_s
{
	char headmodel[64];
	int voiceChatNum;
} headModelVoiceChat_t;

voiceChatList_t voiceChatLists[MAX_VOICEFILES];
headModelVoiceChat_t headModelVoiceChat[MAX_HEADMODELS];

/*
=================
CG_ParseVoiceChats
=================
*/
int CG_ParseVoiceChats( const char *filename, voiceChatList_t *voiceChatList, int maxVoiceChats ) {
	int	len, i;
	fileHandle_t f;
	char buf[MAX_VOICEFILESIZE];
	char **p, *ptr;
	char *token;
	voiceChat_t *voiceChats;
	qboolean compress;
	sfxHandle_t sound;

	compress = qtrue;
	if (cg_buildScript.integer) {
		compress = qfalse;
	}

	len = trap_FS_FOpenFile( filename, &f, FS_READ );
	if ( !f ) {
		trap_Print( va( S_COLOR_RED "voice chat file not found: %s\n", filename ) );
		return qfalse;
	}
	if ( len >= MAX_VOICEFILESIZE ) {
		trap_Print( va( S_COLOR_RED "voice chat file too large: %s is %i, max allowed is %i", filename, len, MAX_VOICEFILESIZE ) );
		trap_FS_FCloseFile( f );
		return qfalse;
	}

	trap_FS_Read( buf, len, f );
	buf[len] = 0;
	trap_FS_FCloseFile( f );

	ptr = buf;
	p = &ptr;

	Com_sprintf(voiceChatList->name, sizeof(voiceChatList->name), "%s", filename);
	voiceChats = voiceChatList->voiceChats;
	for ( i = 0; i < maxVoiceChats; i++ ) {
		voiceChats[i].id[0] = 0;
	}
	token = COM_ParseExt(p, qtrue);
	if (!token || token[0] == 0) {
		return qtrue;
	}
	if (!Q_stricmp(token, "female")) {
		voiceChatList->gender = GENDER_FEMALE;
	}
	else if (!Q_stricmp(token, "male")) {
		voiceChatList->gender = GENDER_MALE;
	}
	else if (!Q_stricmp(token, "neuter")) {
		voiceChatList->gender = GENDER_NEUTER;
	}
	else {
		trap_Print( va( S_COLOR_RED "expected gender not found in voice chat file: %s\n", filename ) );
		return qfalse;
	}

	voiceChatList->numVoiceChats = 0;
	while ( 1 ) {
		token = COM_ParseExt(p, qtrue);
		if (!token || token[0] == 0) {
			return qtrue;
		}
		Com_sprintf(voiceChats[voiceChatList->numVoiceChats].id, sizeof( voiceChats[voiceChatList->numVoiceChats].id ), "%s", token);
		token = COM_ParseExt(p, qtrue);
		if (Q_stricmp(token, "{")) {
			trap_Print( va( S_COLOR_RED "expected { found %s in voice chat file: %s\n", token, filename ) );
			return qfalse;
		}
		voiceChats[voiceChatList->numVoiceChats].numSounds = 0;
		while(1) {
			token = COM_ParseExt(p, qtrue);
			if (!token || token[0] == 0) {
				return qtrue;
			}
			if (!Q_stricmp(token, "}"))
				break;
			sound = trap_S_RegisterSound( token, compress );
			voiceChats[voiceChatList->numVoiceChats].sounds[voiceChats[voiceChatList->numVoiceChats].numSounds] = sound;
			token = COM_ParseExt(p, qtrue);
			if (!token || token[0] == 0) {
				return qtrue;
			}
			Com_sprintf(voiceChats[voiceChatList->numVoiceChats].chats[
							voiceChats[voiceChatList->numVoiceChats].numSounds], MAX_CHATSIZE, "%s", token);
			if (sound)
				voiceChats[voiceChatList->numVoiceChats].numSounds++;
			if (voiceChats[voiceChatList->numVoiceChats].numSounds >= MAX_VOICESOUNDS)
				break;
		}
		voiceChatList->numVoiceChats++;
		if (voiceChatList->numVoiceChats >= maxVoiceChats)
			return qtrue;
	}
	return qtrue;
}

/*
=================
CG_LoadVoiceChats
=================
*/
void CG_LoadVoiceChats( void ) {
	int size;

	size = trap_MemoryRemaining();
//freeze
#ifdef MISSIONPACK
//freeze
	CG_ParseVoiceChats( "scripts/female1.voice", &voiceChatLists[0], MAX_VOICECHATS );
	CG_ParseVoiceChats( "scripts/female2.voice", &voiceChatLists[1], MAX_VOICECHATS );
	CG_ParseVoiceChats( "scripts/female3.voice", &voiceChatLists[2], MAX_VOICECHATS );
	CG_ParseVoiceChats( "scripts/male1.voice", &voiceChatLists[3], MAX_VOICECHATS );
	CG_ParseVoiceChats( "scripts/male2.voice", &voiceChatLists[4], MAX_VOICECHATS );
	CG_ParseVoiceChats( "scripts/male3.voice", &voiceChatLists[5], MAX_VOICECHATS );
	CG_ParseVoiceChats( "scripts/male4.voice", &voiceChatLists[6], MAX_VOICECHATS );
	CG_ParseVoiceChats( "scripts/male5.voice", &voiceChatLists[7], MAX_VOICECHATS );
//freeze
//#else
//	CG_ParseVoiceChats( "scripts/female4.voice", &voiceChatLists[ 0 ], MAX_VOICECHATS );
//	CG_ParseVoiceChats( "scripts/male6.voice", &voiceChatLists[ 1 ], MAX_VOICECHATS );
#endif
//freeze
//	CG_Printf("voice chat memory size = %d\n", size - trap_MemoryRemaining());
}

/*
=================
CG_HeadModelVoiceChats
=================
*/
int CG_HeadModelVoiceChats( char *filename ) {
	int	len, i;
	fileHandle_t f;
	char buf[MAX_VOICEFILESIZE];
	char **p, *ptr;
	char *token;

	len = trap_FS_FOpenFile( filename, &f, FS_READ );
	if ( !f ) {
		//trap_Print( va( "voice chat file not found: %s\n", filename ) );
		return -1;
	}
	if ( len >= MAX_VOICEFILESIZE ) {
		trap_Print( va( S_COLOR_RED "voice chat file too large: %s is %i, max allowed is %i", filename, len, MAX_VOICEFILESIZE ) );
		trap_FS_FCloseFile( f );
		return -1;
	}

	trap_FS_Read( buf, len, f );
	buf[len] = 0;
	trap_FS_FCloseFile( f );

	ptr = buf;
	p = &ptr;

	token = COM_ParseExt(p, qtrue);
	if (!token || token[0] == 0) {
		return -1;
	}

	for ( i = 0; i < MAX_VOICEFILES; i++ ) {
		if ( !Q_stricmp(token, voiceChatLists[i].name) ) {
			return i;
		}
	}

	//FIXME: maybe try to load the .voice file which name is stored in token?

	return -1;
}


/*
=================
CG_GetVoiceChat
=================
*/
int CG_GetVoiceChat( voiceChatList_t *voiceChatList, const char *id, sfxHandle_t *snd, char **chat) {
	int i, rnd;

	for ( i = 0; i < voiceChatList->numVoiceChats; i++ ) {
		if ( !Q_stricmp( id, voiceChatList->voiceChats[i].id ) ) {
			rnd = random() * voiceChatList->voiceChats[i].numSounds;
			*snd = voiceChatList->voiceChats[i].sounds[rnd];
			*chat = voiceChatList->voiceChats[i].chats[rnd];
			return qtrue;
		}
	}
	return qfalse;
}

/*
=================
CG_VoiceChatListForClient
=================
*/
voiceChatList_t *CG_VoiceChatListForClient( int clientNum ) {
	clientInfo_t *ci;
	int voiceChatNum, i, j, k, gender;
	char filename[MAX_QPATH], headModelName[MAX_QPATH];

	if ( clientNum < 0 || clientNum >= MAX_CLIENTS ) {
		clientNum = 0;
	}
	ci = &cgs.clientinfo[ clientNum ];

	for ( k = 0; k < 2; k++ ) {
		if ( k == 0 ) {
			if (ci->headModelName[0] == '*') {
				Com_sprintf( headModelName, sizeof(headModelName), "%s/%s", ci->headModelName+1, ci->headSkinName );
			}
			else {
				Com_sprintf( headModelName, sizeof(headModelName), "%s/%s", ci->headModelName, ci->headSkinName );
			}
		}
		else {
			if (ci->headModelName[0] == '*') {
				Com_sprintf( headModelName, sizeof(headModelName), "%s", ci->headModelName+1 );
			}
			else {
				Com_sprintf( headModelName, sizeof(headModelName), "%s", ci->headModelName );
			}
		}
		// find the voice file for the head model the client uses
		for ( i = 0; i < MAX_HEADMODELS; i++ ) {
			if (!Q_stricmp(headModelVoiceChat[i].headmodel, headModelName)) {
				break;
			}
		}
		if (i < MAX_HEADMODELS) {
			return &voiceChatLists[headModelVoiceChat[i].voiceChatNum];
		}
		// find a <headmodelname>.vc file
		for ( i = 0; i < MAX_HEADMODELS; i++ ) {
			if (!strlen(headModelVoiceChat[i].headmodel)) {
				Com_sprintf(filename, sizeof(filename), "scripts/%s.vc", headModelName);
				voiceChatNum = CG_HeadModelVoiceChats(filename);
				if (voiceChatNum == -1)
					break;
				Com_sprintf(headModelVoiceChat[i].headmodel, sizeof ( headModelVoiceChat[i].headmodel ),
							"%s", headModelName);
				headModelVoiceChat[i].voiceChatNum = voiceChatNum;
				return &voiceChatLists[headModelVoiceChat[i].voiceChatNum];
			}
		}
	}
	gender = ci->gender;
	for (k = 0; k < 2; k++) {
		// just pick the first with the right gender
		for ( i = 0; i < MAX_VOICEFILES; i++ ) {
			if (strlen(voiceChatLists[i].name)) {
				if (voiceChatLists[i].gender == gender) {
					// store this head model with voice chat for future reference
					for ( j = 0; j < MAX_HEADMODELS; j++ ) {
						if (!strlen(headModelVoiceChat[j].headmodel)) {
							Com_sprintf(headModelVoiceChat[j].headmodel, sizeof ( headModelVoiceChat[j].headmodel ),
									"%s", headModelName);
							headModelVoiceChat[j].voiceChatNum = i;
							break;
						}
					}
					return &voiceChatLists[i];
				}
			}
		}
		// fall back to male gender because we don't have neuter in the mission pack
		if (gender == GENDER_MALE)
			break;
		gender = GENDER_MALE;
	}
	// store this head model with voice chat for future reference
	for ( j = 0; j < MAX_HEADMODELS; j++ ) {
		if (!strlen(headModelVoiceChat[j].headmodel)) {
			Com_sprintf(headModelVoiceChat[j].headmodel, sizeof ( headModelVoiceChat[j].headmodel ),
					"%s", headModelName);
			headModelVoiceChat[j].voiceChatNum = 0;
			break;
		}
	}
	// just return the first voice chat list
	return &voiceChatLists[0];
}

#define MAX_VOICECHATBUFFER		32

typedef struct bufferedVoiceChat_s
{
	int clientNum;
	sfxHandle_t snd;
	int voiceOnly;
	char cmd[MAX_SAY_TEXT];
	char message[MAX_SAY_TEXT];
} bufferedVoiceChat_t;

bufferedVoiceChat_t voiceChatBuffer[MAX_VOICECHATBUFFER];

/*
=================
CG_PlayVoiceChat
=================
*/
void CG_PlayVoiceChat( bufferedVoiceChat_t *vchat ) {

#ifdef MISSIONPACK

	// if we are going into the intermission, don't start any voices
	if ( cg.intermissionStarted ) {
		return;
	}

	if ( !cg_noVoiceChats.integer ) {
		trap_S_StartLocalSound( vchat->snd, CHAN_VOICE);
//freeze
//#ifdef MISSIONPACK
//freeze
		if (vchat->clientNum != cg.snap->ps.clientNum) {
			int orderTask = CG_ValidOrder(vchat->cmd);
			if (orderTask > 0) {
				cgs.acceptOrderTime = cg.time + 5000;
				Q_strncpyz(cgs.acceptVoice, vchat->cmd, sizeof(cgs.acceptVoice));
				cgs.acceptTask = orderTask;
				cgs.acceptLeader = vchat->clientNum;
			}
			// see if this was an order
			CG_ShowResponseHead();
		}
//freeze
//#endif
//freeze
	}
	if (!vchat->voiceOnly && !cg_noVoiceText.integer) {
		CG_AddToTeamChat( vchat->message );
		CG_Printf( "%s\n", vchat->message );
	}
	voiceChatBuffer[cg.voiceChatBufferOut].snd = 0;

#endif
}

/*
=====================
CG_PlayBufferedVoieChats
=====================
*/
void CG_PlayBufferedVoiceChats( void ) {

#ifdef MISSIONPACK
	if ( cg.voiceChatTime < cg.time ) {
		if (cg.voiceChatBufferOut != cg.voiceChatBufferIn && voiceChatBuffer[cg.voiceChatBufferOut].snd) {
			//
			CG_PlayVoiceChat(&voiceChatBuffer[cg.voiceChatBufferOut]);
			//
			cg.voiceChatBufferOut = (cg.voiceChatBufferOut + 1) % MAX_VOICECHATBUFFER;
			cg.voiceChatTime = cg.time + 1000;
		}
	}
#endif
}

/*
=====================
CG_AddBufferedVoiceChat
=====================
*/
void CG_AddBufferedVoiceChat( bufferedVoiceChat_t *vchat ) {

#ifdef MISSIONPACK

	// if we are going into the intermission, don't start any voices
	if ( cg.intermissionStarted ) {
		return;
	}

	memcpy(&voiceChatBuffer[cg.voiceChatBufferIn], vchat, sizeof(bufferedVoiceChat_t));
	cg.voiceChatBufferIn = (cg.voiceChatBufferIn + 1) % MAX_VOICECHATBUFFER;
	if (cg.voiceChatBufferIn == cg.voiceChatBufferOut) {
		CG_PlayVoiceChat( &voiceChatBuffer[cg.voiceChatBufferOut] );
		cg.voiceChatBufferOut++;
	}

#endif

}

/*
=================
CG_VoiceChatLocal
=================
*/
void CG_VoiceChatLocal( int mode, qboolean voiceOnly, int clientNum, int color, const char *cmd ) {

#ifdef MISSIONPACK

	char *chat;
	voiceChatList_t *voiceChatList;
	clientInfo_t *ci;
	sfxHandle_t snd;
	bufferedVoiceChat_t vchat;

	// if we are going into the intermission, don't start any voices
	if ( cg.intermissionStarted ) {
		return;
	}

	if ( clientNum < 0 || clientNum >= MAX_CLIENTS ) {
		clientNum = 0;
	}
	ci = &cgs.clientinfo[ clientNum ];

	cgs.currentVoiceClient = clientNum;

	voiceChatList = CG_VoiceChatListForClient( clientNum );

	if ( CG_GetVoiceChat( voiceChatList, cmd, &snd, &chat ) ) {
		//
		if ( mode == SAY_TEAM || !cg_teamChatsOnly.integer ) {
			vchat.clientNum = clientNum;
			vchat.snd = snd;
			vchat.voiceOnly = voiceOnly;
			Q_strncpyz(vchat.cmd, cmd, sizeof(vchat.cmd));
			if ( mode == SAY_TELL ) {
				Com_sprintf(vchat.message, sizeof(vchat.message), "[%s]: %c%c%s", ci->name, Q_COLOR_ESCAPE, color, chat);
			}
			else if ( mode == SAY_TEAM ) {
//freeze
				const char	*p = CG_ConfigString( CS_LOCATIONS + ci->location );

				if ( !p || !*p ) {
//freeze
				Com_sprintf(vchat.message, sizeof(vchat.message), "(%s): %c%c%s", ci->name, Q_COLOR_ESCAPE, color, chat);
//freeze
				} else {
					Com_sprintf( vchat.message, sizeof ( vchat.message ), "(%s) (%s): %c%c%s", ci->name, p, Q_COLOR_ESCAPE, color, chat );
				}
//freeze
			}
			else {
				Com_sprintf(vchat.message, sizeof(vchat.message), "%s: %c%c%s", ci->name, Q_COLOR_ESCAPE, color, chat);
			}
			CG_AddBufferedVoiceChat(&vchat);
		}
	}

#endif

}

/*
=================
CG_VoiceChat
=================
*/
void CG_VoiceChat( int mode ) {

#ifdef MISSIONPACK

	const char *cmd;
	int clientNum, color;
	qboolean voiceOnly;

	voiceOnly = atoi(CG_Argv(1));
	clientNum = atoi(CG_Argv(2));
	color = atoi(CG_Argv(3));
	cmd = CG_Argv(4);

	if (cg_noTaunt.integer != 0) {
		if (!strcmp(cmd, VOICECHAT_KILLINSULT)  || !strcmp(cmd, VOICECHAT_TAUNT) || \
			!strcmp(cmd, VOICECHAT_DEATHINSULT) || !strcmp(cmd, VOICECHAT_KILLGAUNTLET) || \
			!strcmp(cmd, VOICECHAT_PRAISE)) {
			return;
		}
	}

	CG_VoiceChatLocal( mode, voiceOnly, clientNum, color, cmd );

#endif

}

/*
=================
CG_RemoveChatEscapeChar
=================
*/
static void CG_RemoveChatEscapeChar( char *text ) {
	int i, l;

	l = 0;
	for ( i = 0; text[i]; i++ ) {
		if (text[i] == '\x19')
			continue;
		text[l++] = text[i];
	}
	text[l] = '\0';
}


static void CG_HandleMiss( int clientsMissed )
{
//	int i;

	if (cg_aimType.integer == 2 || cg_aimType.integer == 3)
	{
		if (clientsMissed >= 0 && clientsMissed < 32)
		{
//			cg_entities[clientsMissed].deathTime = 0;
			trap_S_StartLocalSound( cgs.media.deniedSound, CHAN_ANNOUNCER );
		}
	}



//	if (cg_aimType.integer == 3)
//	{
//		for (i=0;i<32;i++)
//		{
//			if ((clientsMissed >> i) & 1)
//			{
////				cg_entities[i].deathTime = 0;
//			}
//		}
//		trap_S_StartLocalSound( cgs.media.deniedSound, CHAN_ANNOUNCER );
//	}
	
}

void CG_HandleVote(char *cmd) {
	char *token;
	token = COM_Parse(&cmd);

	//CG_Printf("HandleVote: %s\n", cmd);

	if ( !cgs.voteTime ) { //FIXME: It's possible to get the yes/no totals sent before this
		char msg[MAX_STRING_TOKENS];
//		char *token1;
		cgs.voteTime = atoi( token );
		Q_strncpyz(msg, cmd, sizeof(msg));
		//CG_Printf("DBG: VoteDisplay: %s %s -- %s\n", token, token1, msg);
		Com_sprintf(cgs.voteString, sizeof(cgs.voteString), "%s", msg);
		cgs.voteYes = 1;
	} else {
		if ( atoi(token) == -1 ) {
			cgs.voteTime = 0;
			cgs.voteYes = 0;
			cgs.voteNo = 0;
			memset(cgs.voteString, 0, sizeof(cgs.voteString));
		} else {
			trap_S_StartLocalSound( cgs.media.talkSound, CHAN_LOCAL_SOUND );
			cgs.voteYes = atoi( token );
			cgs.voteNo = atoi( cmd );
		}
	}
	//CG_Printf("DBG: VoteDisplay: %s %i %i %i\n", cgs.voteString, cgs.voteTime, cgs.voteYes, cgs.voteNo);
}

void CG_HandleTeamVote(char *cmd) {
	int team;
	char *token;
	token = COM_Parse(&cmd);
	team = atoi(token);

	token = COM_Parse(&cmd);
	if ( !cgs.teamVoteTime[team] ) { //FIXME: It's possible to get the yes/no totals sent before this
		char msg[MAX_STRING_TOKENS];
		cgs.teamVoteTime[team] = atoi( token );
		Q_strncpyz(msg, cmd, sizeof(msg));
		Com_sprintf(cgs.teamVoteString[team], sizeof(cgs.teamVoteString[team]), "%s", msg);
		cgs.teamVoteYes[team] = 1;
	} else {
		if ( atoi(token) == -1 ) {
			//CG_Printf("DBG: team: %i\n", team);
			cgs.teamVoteTime[team] = 0;
			cgs.teamVoteYes[team] = 0;
			cgs.teamVoteNo[team] = 0;
			memset(cgs.teamVoteString[team], 0, sizeof(cgs.teamVoteString[team]));
		} else {
			trap_S_StartLocalSound( cgs.media.talkSound, CHAN_LOCAL_SOUND );
			cgs.teamVoteYes[team] = atoi( token );
			cgs.teamVoteNo[team] = atoi( cmd );
		}
	}
}

void CG_DisplayVoteCmds ( char *string ) {
	char *token;
	int i = 0;

	CG_Printf(""S_COLOR_CYAN"Vote commands are:\n\n");

	token = COM_Parse(&string);
	while ( token[0] ) {
		if ( i == 2 ) {
			CG_Printf(""S_COLOR_CYAN"%s\n", token);
		} else {
			CG_Printf(""S_COLOR_CYAN"%24s", token);
		}
		token = COM_Parse(&string);
		i++;
		if ( i == 3 ) {
			i = 0;
			//CG_Printf("\n");
		}
	}
	CG_Printf("\n");
}

static void CG_motd( void ) {
//	int		i;

	strcpy(cg.sv_motd1, CG_Argv( 1 ) );
	strcpy(cg.sv_motd2, CG_Argv( 2 ) );
	strcpy(cg.sv_motd3, CG_Argv( 3 ) );
	strcpy(cg.sv_motd4, CG_Argv( 4 ) );
	strcpy(cg.sv_motd5, CG_Argv( 5 ) );
	strcpy(cg.sv_motd6, CG_Argv( 6 ) );
	strcpy(cg.sv_motd7, CG_Argv( 7 ) );
	strcpy(cg.sv_motd8, CG_Argv( 8 ) );

	cg.motdScrollTime = cg.time + 1000;
	cg.motdDisplayTime = cg.time + (cg_motdDisplayTime.integer * 1000);
}

void CG_HandleReady( int clientNum, qboolean readyState ) {
	CG_Printf("%s" S_COLOR_WHITE " is%s ready.\n", cgs.clientinfo[clientNum].name, readyState?(""):(" not"));
	CG_CenterPrint(va("%s" S_COLOR_WHITE " is%s ready.\n", cgs.clientinfo[clientNum].name, readyState?(""):(" not")),
		SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH);
}

	
	char	smsg[48] = {0};

/*
=================
CG_ServerCommand

The string has been tokenized and can be retrieved with
Cmd_Argc() / Cmd_Argv()
=================
*/
static void CG_ServerCommand( void ) {
	const char	*cmd;
	char		text[MAX_SAY_TEXT];
	cmd = CG_Argv(0);

	if ( !cmd[0] ) {
		// server claimed the command
		return;
	}

	if ( !strcmp( cmd, "motd" ) ) {
		CG_motd();
		return;
	}

	if ( !strcmp( cmd, "miss" ) ) {
		CG_HandleMiss( atoi(CG_Argv(1)) );
		return;
	}

	if ( !strcmp( cmd, "cp" ) ) {
		CG_CenterPrint( CG_Argv(1), SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH );
		return;
	}

	if ( !strcmp( cmd, "cs" ) ) {
		CG_ConfigStringModified();
		return;
	}

	if ( !strcmp( cmd, "print" ) ) {
		CG_Printf( "%s", CG_Argv(1) );
#ifdef MISSIONPACK
		cmd = CG_Argv(1);			// yes, this is obviously a hack, but so is the way we hear about
									// votes passing or failing
		if ( !Q_stricmpn( cmd, "vote failed", 11 ) || !Q_stricmpn( cmd, "team vote failed", 16 )) {
			trap_S_StartLocalSound( cgs.media.voteFailed, CHAN_ANNOUNCER );
		} else if ( !Q_stricmpn( cmd, "vote passed", 11 ) || !Q_stricmpn( cmd, "team vote passed", 16 ) ) {
			trap_S_StartLocalSound( cgs.media.votePassed, CHAN_ANNOUNCER );
		}
#endif
		return;
	}

	if ( !strcmp( cmd, "chat" ) ) {
		if ( ((cg_teamChatsOnly.integer == 0) || (cg.intermissionStarted && cg_teamChatsOnly.integer == 2)) ) {
			if ( !cg_nochatbeep.integer ) {
				trap_S_StartLocalSound( cgs.media.talkSound, CHAN_LOCAL_SOUND );
			}
			Q_strncpyz( text, CG_Argv(1), MAX_SAY_TEXT );
			CG_RemoveChatEscapeChar( text );
			CG_Printf( "%s \n", text );

			if ( hud_count && strlen(ch_file.string) ) {
				int i;
				//Clear message 8 is exists
				if (chat[MAX_CHATS-1].time) {
					chat[MAX_CHATS-1].time = 0;
					memset(chat[MAX_CHATS-1].msg, 0, sizeof(chat[MAX_CHATS-1].msg) );
				}

				//Move existing messages
				for ( i = (MAX_CHATS - 2); i != -1; i-- ) {
					if ( chat[i].time ) {
						//Move info
						Q_strncpyz(chat[i+1].msg, chat[i].msg, MAX_SAY_TEXT);
						//memcpy(chat[i+1].msg, chat[i].msg, sizeof(chat[i+1].msg) );
						chat[i+1].time = chat[i].time;
						//CG_Printf("ShiftFrom:%i:%i:%s\n", i, chat[i].time, chat[i].msg);
						//CG_Printf("ShiftTo:%i:%i:%s\n", i+1, chat[i+1].time, chat[i+1].msg);
						//Clear old info.
						chat[i].time = 0;
						memset(chat[i].msg, 0, sizeof(chat[i].msg) );
					}
				}

				//Assign the new message
				Q_strncpyz(chat[0].msg, text, MAX_SAY_TEXT);
				chat[0].time = cg.time;
				//chat_count++;
			}
		}
		return;
	}

	if ( !strcmp( cmd, "tchat" ) ) {
		if ( !cg_noteamchatbeep.integer) {
			trap_S_StartLocalSound( cgs.media.talkSound, CHAN_LOCAL_SOUND );
		}
		Q_strncpyz( text, CG_Argv(1), MAX_SAY_TEXT );
		CG_RemoveChatEscapeChar( text );
		CG_AddToTeamChat( text );
		CG_Printf( "%s \n", text );
		
		if ( hud_count && strlen(ch_file.string) ) {
				int i;
				//Clear message 8 is exists
				if (chat[MAX_CHATS-1].time) {
					chat[MAX_CHATS-1].time = 0;
					memset(chat[MAX_CHATS-1].msg, 0, sizeof(chat[MAX_CHATS-1].msg) );
				}

				//Move existing messages
				for ( i = (MAX_CHATS - 2); i != -1; i-- ) {
					if ( chat[i].time ) {
						//Move info
						Q_strncpyz(chat[i+1].msg, chat[i].msg, MAX_SAY_TEXT);
						//memcpy(chat[i+1].msg, chat[i].msg, sizeof(chat[i+1].msg) );
						chat[i+1].time = chat[i].time;
						//CG_Printf("ShiftFrom:%i:%i:%s\n", i, chat[i].time, chat[i].msg);
						//CG_Printf("ShiftTo:%i:%i:%s\n", i+1, chat[i+1].time, chat[i+1].msg);
						//Clear old info.
						chat[i].time = 0;
						memset(chat[i].msg, 0, sizeof(chat[i].msg) );
					}
				}

				//Assign the new message
				Q_strncpyz(chat[0].msg, text, MAX_SAY_TEXT);
				chat[0].time = cg.time;
				//chat_count++;
			}
		return;
	}
	if ( !strcmp( cmd, "vchat" ) ) {
		CG_VoiceChat( SAY_ALL );
		return;
	}

	if ( !strcmp( cmd, "vtchat" ) ) {
		CG_VoiceChat( SAY_TEAM );
		return;
	}

	if ( !strcmp( cmd, "vtell" ) ) {
		CG_VoiceChat( SAY_TELL );
		return;
	}

	if ( !strcmp( cmd, "s1s" ) ) {
		CG_NewParseScores((char *)cmd);
		return;
	}

	if ( !strcmp( cmd, "scores" ) ) {
		CG_ParseScores();
		return;
	}

	if ( !strcmp( cmd, "updcvar" ) ) {
		CG_UpdCvar();
		return;
	}

	if ( !strcmp( cmd, "connUCv" ) ) {
		CG_ConnUCv();
			return;
	}

	if ( !strcmp( cmd, "tinfo" ) ) {
		CG_ParseTeamInfo();
		return;
	}

	if ( !strcmp( cmd, "map_restart" ) ) {
		CG_MapRestart();
		return;
	}

  if ( Q_stricmp (cmd, "remapShader") == 0 ) {
		if (trap_Argc() == 4) {
			trap_R_RemapShader(CG_Argv(1), CG_Argv(2), CG_Argv(3));
		}
	}

	// loaddeferred can be both a servercmd and a consolecmd
	if ( !strcmp( cmd, "loaddefered" ) ) {	// FIXME: spelled wrong, but not changing for demo
		CG_LoadDeferredPlayers();
		return;
	}

	// clientLevelShot is sent before taking a special screenshot for
	// the menu system during development
	if ( !strcmp( cmd, "clientLevelShot" ) ) {
		cg.levelShot = qtrue;
		return;
	}

	//vote commands
	if ( !strcmp( cmd, "vtc" ) ) {
		char	cmdlist[MAX_STRING_TOKENS];
		Q_strncpyz( cmdlist, CG_Argv(1), MAX_STRING_TOKENS );
		//CG_Printf("%s", cmdlist);
		CG_DisplayVoteCmds(cmdlist);
		return;
	}
	//vote
	if ( !strcmp( cmd, "vt" ) ) {
		char	cmdlist[MAX_STRING_TOKENS];
		Q_strncpyz( cmdlist, CG_Argv(1), MAX_STRING_TOKENS );
		CG_HandleVote(cmdlist);
		return;
	}
	//teamvote
	if ( !strcmp( cmd, "tv" ) ) {
		char	cmdlist[MAX_STRING_TOKENS];
		Q_strncpyz( cmdlist, CG_Argv(1), MAX_STRING_TOKENS );
		//CG_Printf("DBG: %s\n", cmdlist);
		CG_HandleTeamVote( cmdlist );
		return;
	}
	//ready
	if ( !strcmp( cmd, "rd" )) {
		CG_HandleReady( atoi(CG_Argv(1)), qtrue );
		return;
	}

	//ready
	if ( !strcmp( cmd, "nrd" )) {
		CG_HandleReady( atoi(CG_Argv(1)), qfalse );
		return;
	}

	if ( !strcmp( cmd, "play" ) ) {
		trap_SendConsoleCommand(va("play %s \n", CG_Argv(1)));
		return;
	}

	CG_Printf( "Unknown client game command: %s\n", cmd );
}


/*
====================
CG_ExecuteNewServerCommands

Execute all of the server commands that were received along
with this this snapshot.
====================
*/
void CG_ExecuteNewServerCommands( int latestSequence ) {
	while ( cgs.serverCommandSequence < latestSequence ) {
		if ( trap_GetServerCommand( ++cgs.serverCommandSequence ) ) {
			CG_ServerCommand();
		}
	}
}
