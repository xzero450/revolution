// Copyright (C) 1999-2000 Id Software, Inc.
//
// cg_consolecmds.c -- text commands typed in at the local console, or
// executed by a key binding

#include "cg_local.h"
#include "../ui/ui_shared.h"
#ifdef MISSIONPACK
extern menuDef_t *menuScoreboard;
#endif


//typedef enum
//{
//	T_EOF,
//	T_SEMI,
//	T_BEGIN_BRACKET,
//	T_END_BRACKET,
//	T_STRING,
//	T_TOKEN
//} token_type;

void CG_TargetCommand_f( void ) {
	int		targetNum;
	char	test[4];

	targetNum = CG_CrosshairPlayer();
	if (!targetNum ) {
		return;
	}

	trap_Argv( 1, test, 4 );
	trap_SendConsoleCommand( va( "gc %i %i", targetNum, atoi( test ) ) );
}



/*
=================
CG_SizeUp_f

Keybinding command
=================
*/
static void CG_SizeUp_f (void) {
	trap_Cvar_Set("cg_viewsize", va("%i",(int)(cg_viewsize.integer+10)));
}


/*
=================
CG_SizeDown_f

Keybinding command
=================
*/
static void CG_SizeDown_f (void) {
	trap_Cvar_Set("cg_viewsize", va("%i",(int)(cg_viewsize.integer-10)));
}


/*
=============
CG_Viewpos_f

Debugging command to print the current position
=============
*/
static void CG_Viewpos_f (void) {
	CG_Printf ("(%i %i %i) : %i\n", (int)cg.refdef.vieworg[0],
		(int)cg.refdef.vieworg[1], (int)cg.refdef.vieworg[2], 
		(int)cg.refdefViewAngles[YAW]);
}


static void CG_ScoresDown_f( void ) {

#ifdef MISSIONPACK
		CG_BuildSpectatorString();
#endif
	if ( cg.scoresRequestTime + 2000 < cg.time ) {
		// the scores are more than two seconds out of data,
		// so request new ones
		cg.scoresRequestTime = cg.time;
		trap_SendClientCommand( "score" );

		// leave the current scores up if they were already
		// displayed, but if this is the first hit, clear them out
		if ( !cg.showScores ) {
			cg.showScores = qtrue;
			cg.numScores = 0;
		}
	} else {
		// show the cached contents even if they just pressed if it
		// is within two seconds
		cg.showScores = qtrue;
	}
}

static void CG_ScoresUp_f( void ) {
	if ( cg.showScores ) {
		cg.showScores = qfalse;
		cg.scoreFadeTime = cg.time;
	}
}

#ifdef MISSIONPACK
extern menuDef_t *menuScoreboard;
void Menu_Reset();			// FIXME: add to right include file

static void CG_LoadHud_f( void) {
  char buff[1024];
	const char *hudSet;
  memset(buff, 0, sizeof(buff));

	String_Init();
	Menu_Reset();
	
	trap_Cvar_VariableStringBuffer("cg_hudFiles", buff, sizeof(buff));
	hudSet = buff;
	if (hudSet[0] == '\0') {
		hudSet = "ui/hud.txt";
	}

	CG_LoadMenus(hudSet);
  menuScoreboard = NULL;
}


static void CG_scrollScoresDown_f( void) {
	if (menuScoreboard && cg.scoreBoardShowing) {
		Menu_ScrollFeeder(menuScoreboard, FEEDER_SCOREBOARD, qtrue);
		Menu_ScrollFeeder(menuScoreboard, FEEDER_REDTEAM_LIST, qtrue);
		Menu_ScrollFeeder(menuScoreboard, FEEDER_BLUETEAM_LIST, qtrue);
	}
}


static void CG_scrollScoresUp_f( void) {
	if (menuScoreboard && cg.scoreBoardShowing) {
		Menu_ScrollFeeder(menuScoreboard, FEEDER_SCOREBOARD, qfalse);
		Menu_ScrollFeeder(menuScoreboard, FEEDER_REDTEAM_LIST, qfalse);
		Menu_ScrollFeeder(menuScoreboard, FEEDER_BLUETEAM_LIST, qfalse);
	}
}


static void CG_spWin_f( void) {
	trap_Cvar_Set("cg_cameraOrbit", "2");
	trap_Cvar_Set("cg_cameraOrbitDelay", "35");
	trap_Cvar_Set("cg_thirdPerson", "1");
	trap_Cvar_Set("cg_thirdPersonAngle", "0");
	trap_Cvar_Set("cg_thirdPersonRange", "100");
	CG_AddBufferedSound(cgs.media.winnerSound);
	//trap_S_StartLocalSound(cgs.media.winnerSound, CHAN_ANNOUNCER);
	CG_CenterPrint("YOU WIN!", SCREEN_HEIGHT * .30, 0);
}

static void CG_spLose_f( void) {
	trap_Cvar_Set("cg_cameraOrbit", "2");
	trap_Cvar_Set("cg_cameraOrbitDelay", "35");
	trap_Cvar_Set("cg_thirdPerson", "1");
	trap_Cvar_Set("cg_thirdPersonAngle", "0");
	trap_Cvar_Set("cg_thirdPersonRange", "100");
	CG_AddBufferedSound(cgs.media.loserSound);
	//trap_S_StartLocalSound(cgs.media.loserSound, CHAN_ANNOUNCER);
	CG_CenterPrint("YOU LOSE...", SCREEN_HEIGHT * .30, 0);
}

#endif

static void CG_TellTarget_f( void ) {
	int		clientNum;
	char	command[128];
	char	message[128];

	clientNum = CG_CrosshairPlayer();
	if ( clientNum == -1 ) {
		return;
	}

	trap_Args( message, 128 );
	Com_sprintf( command, 128, "tell %i %s", clientNum, message );
	trap_SendClientCommand( command );
}

static void CG_TellAttacker_f( void ) {
	int		clientNum;
	char	command[128];
	char	message[128];

	clientNum = CG_LastAttacker();
	if ( clientNum == -1 ) {
		return;
	}

	trap_Args( message, 128 );
	Com_sprintf( command, 128, "tell %i %s", clientNum, message );
	trap_SendClientCommand( command );
}

static void CG_VoiceTellTarget_f( void ) {
	int		clientNum;
	char	command[128];
	char	message[128];

	clientNum = CG_CrosshairPlayer();
	if ( clientNum == -1 ) {
		return;
	}

	trap_Args( message, 128 );
	Com_sprintf( command, 128, "vtell %i %s", clientNum, message );
	trap_SendClientCommand( command );
}

static void CG_VoiceTellAttacker_f( void ) {
	int		clientNum;
	char	command[128];
	char	message[128];

	clientNum = CG_LastAttacker();
	if ( clientNum == -1 ) {
		return;
	}

	trap_Args( message, 128 );
	Com_sprintf( command, 128, "vtell %i %s", clientNum, message );
	trap_SendClientCommand( command );
}

static void CG_Ready_f( void ) {
	if ( g_allowReady.integer == 1 && cgs.clientinfo[cg.clientNum].team != TEAM_SPECTATOR && cg.time > cg.readyInterval && cg.warmup > 0 ) {
			cg.readyInterval = cg.time + READY_INTERVAL;

			trap_SendClientCommand( "ready" );
		}
}

static void CG_Notready_f( void ) {
	//CG_Printf("Not ready\n");
	if ( g_allowReady.integer == 1 && cg.totalOccurance <= 2 && cg.time > cg.notreadyInterval && cgs.clientinfo[cg.clientNum].team != TEAM_SPECTATOR && cg.warmup > 0 ) {
		//CG_Printf("Sending command");
		cg.totalOccurance = ++cg.totalOccurance;
			cg.notreadyInterval = cg.time + NOTREADY_INTERVAL;

			trap_SendClientCommand( "notready" );
	}
}

#ifdef MISSIONPACK
static void CG_NextTeamMember_f( void ) {
  CG_SelectNextPlayer();
}

static void CG_PrevTeamMember_f( void ) {
  CG_SelectPrevPlayer();
}

// ASS U ME's enumeration order as far as task specific orders, OFFENSE is zero, CAMP is last
//
static void CG_NextOrder_f( void ) {
	clientInfo_t *ci = cgs.clientinfo + cg.snap->ps.clientNum;
	if (ci) {
		if (!ci->teamLeader && sortedTeamPlayers[cg_currentSelectedPlayer.integer] != cg.snap->ps.clientNum) {
			return;
		}
	}
	if (cgs.currentOrder < TEAMTASK_CAMP) {
		cgs.currentOrder++;

		if (cgs.currentOrder == TEAMTASK_RETRIEVE) {
			if (!CG_OtherTeamHasFlag()) {
				cgs.currentOrder++;
			}
		}

		if (cgs.currentOrder == TEAMTASK_ESCORT) {
			if (!CG_YourTeamHasFlag()) {
				cgs.currentOrder++;
			}
		}

	} else {
		cgs.currentOrder = TEAMTASK_OFFENSE;
	}
	cgs.orderPending = qtrue;
	cgs.orderTime = cg.time + 3000;
}


static void CG_ConfirmOrder_f (void ) {
	trap_SendConsoleCommand(va("cmd vtell %d %s\n", cgs.acceptLeader, VOICECHAT_YES));
	trap_SendConsoleCommand("+button5; wait; -button5");
	if (cg.time < cgs.acceptOrderTime) {
		trap_SendClientCommand(va("teamtask %d\n", cgs.acceptTask));
		cgs.acceptOrderTime = 0;
	}
}

static void CG_DenyOrder_f (void ) {
	trap_SendConsoleCommand(va("cmd vtell %d %s\n", cgs.acceptLeader, VOICECHAT_NO));
	trap_SendConsoleCommand("+button6; wait; -button6");
	if (cg.time < cgs.acceptOrderTime) {
		cgs.acceptOrderTime = 0;
	}
}

static void CG_TaskOffense_f (void ) {
	if (cgs.gametype == GT_CTF || cgs.gametype == GT_1FCTF) {
		trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONGETFLAG));
	} else {
		trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONOFFENSE));
	}
	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_OFFENSE));
}

static void CG_TaskDefense_f (void ) {
	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONDEFENSE));
	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_DEFENSE));
}

static void CG_TaskPatrol_f (void ) {
	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONPATROL));
	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_PATROL));
}

static void CG_TaskCamp_f (void ) {
	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONCAMPING));
	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_CAMP));
}

static void CG_TaskFollow_f (void ) {
	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONFOLLOW));
	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_FOLLOW));
}

static void CG_TaskRetrieve_f (void ) {
	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONRETURNFLAG));
	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_RETRIEVE));
}

static void CG_TaskEscort_f (void ) {
	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONFOLLOWCARRIER));
	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_ESCORT));
}

static void CG_TaskOwnFlag_f (void ) {
	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_IHAVEFLAG));
}

static void CG_TauntKillInsult_f (void ) {
	trap_SendConsoleCommand("cmd vsay kill_insult\n");
}

static void CG_TauntPraise_f (void ) {
	trap_SendConsoleCommand("cmd vsay praise\n");
}

static void CG_TauntTaunt_f (void ) {
	trap_SendConsoleCommand("cmd vtaunt\n");
}

static void CG_TauntDeathInsult_f (void ) {
	trap_SendConsoleCommand("cmd vsay death_insult\n");
}

static void CG_TauntGauntlet_f (void ) {
	trap_SendConsoleCommand("cmd vsay kill_guantlet\n");
}

static void CG_TaskSuicide_f (void ) {
	int		clientNum;
	char	command[128];

	clientNum = CG_CrosshairPlayer();
	if ( clientNum == -1 ) {
		return;
	}

	Com_sprintf( command, 128, "tell %i suicide", clientNum );
	trap_SendClientCommand( command );
}



/*
==================
CG_TeamMenu_f
==================
*/
/*
static void CG_TeamMenu_f( void ) {
  if (trap_Key_GetCatcher() & KEYCATCH_CGAME) {
    CG_EventHandling(CGAME_EVENT_NONE);
    trap_Key_SetCatcher(0);
  } else {
    CG_EventHandling(CGAME_EVENT_TEAMMENU);
    //trap_Key_SetCatcher(KEYCATCH_CGAME);
  }
}
*/

/*
==================
CG_EditHud_f
==================
*/
/*
static void CG_EditHud_f( void ) {
  //cls.keyCatchers ^= KEYCATCH_CGAME;
  //VM_Call (cgvm, CG_EVENT_HANDLING, (cls.keyCatchers & KEYCATCH_CGAME) ? CGAME_EVENT_EDITHUD : CGAME_EVENT_NONE);
}
*/

#endif

/*
==================
CG_StartOrbit_f
==================
*/

static void CG_StartOrbit_f( void ) {
	char var[MAX_TOKEN_CHARS];

	trap_Cvar_VariableStringBuffer( "developer", var, sizeof( var ) );
	if ( !atoi(var) ) {
		return;
	}
	if (cg_cameraOrbit.value != 0) {
		trap_Cvar_Set ("cg_cameraOrbit", "0");
		trap_Cvar_Set("cg_thirdPerson", "0");
	} else {
		trap_Cvar_Set("cg_cameraOrbit", "5");
		trap_Cvar_Set("cg_thirdPerson", "1");
		trap_Cvar_Set("cg_thirdPersonAngle", "0");
		trap_Cvar_Set("cg_thirdPersonRange", "100");
	}
}

/*
static void CG_Camera_f( void ) {
	char name[1024];
	trap_Argv( 1, name, sizeof(name));
	if (trap_loadCamera(name)) {
		cg.cameraMode = qtrue;
		trap_startCamera(cg.time);
	} else {
		CG_Printf ("Unable to load camera %s\n",name);
	}
}
*/

static void CG_TossFlag_f ( void ) {
//	char	command[128];
//	char	message[128];
//	playerState_t *ps;

	if ( cgs.gametype != GT_CTF ) {
		return;
	}
	//if ( !cg.predictedPlayerState.powerups[PW_BLUEFLAG]
	//|| !cg.predictedPlayerState.powerups[PW_REDFLAG] ) {
	//	cg.
	//	return; //not carrying a flag
	//}

	if ( cg.time > cg.naftInterval ) {
		cg.naftInterval = cg.time + 700;
		cg.lastHeldFlag = cg.itemPickupFlag;
		trap_SendClientCommand( "tossflag"  );
	}
}

static void CG_TimeOut_f ( void ) {
	char	message[128];

	trap_Args( message, 128 );
	trap_SendClientCommand( va("callvote timeout %s", message) );
	//trap_SendClientCommand("callvote timeout");
}

static void CG_Timein_f ( void ) {
	char	message[128];

	trap_Args( message, 128 );
	trap_SendClientCommand( va("callvote timein %s", message) );
}

//static void CG_unlockTeam_f ( void ) {
//	trap_SendClientCommand("callteamvote unlockTeam");
//	//trap_SendClientCommand("callvote timeout");
//}
//
//static void CG_lockTeam_f ( void ) {
//	trap_SendClientCommand("callteamvote lockTeam");
//}


static void CG_Speedometer_f ( void ) {
	int ac;//, i;
	char st[MAX_CVAR_VALUE_STRING], *tmp;
	char ds[12], dm[12], x[12], y[12], a[12];

	ac = trap_Argc();
	tmp = ch_Speedometer.string;
	CG_ExtractToken(&tmp, ds);
	CG_ExtractToken(&tmp, dm);
	CG_ExtractToken(&tmp, x);
	CG_ExtractToken(&tmp, y);
	CG_ExtractToken(&tmp, a);

	switch(ac)
	{
		case 1:
			trap_SendConsoleCommand("ch_Speedometer");
			return;

		case 2:
			trap_Argv(1, ds, 12);
			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s %s", ds, dm, x, y, a);
			break;

		case 3:
			trap_Argv(1, ds, 12);
			trap_Argv(2, dm, 12);
			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s %s", ds, dm, x, y, a);
			break;

		case 4:
			trap_Argv(1, ds, 12);
			trap_Argv(2, dm, 12);
			trap_Argv(3, x, 12);
			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s %s", ds, dm, x, y, a);
			break;

		case 5:
			trap_Argv(1, ds, 12);
			trap_Argv(2, dm, 12);
			trap_Argv(3, x, 12);
			trap_Argv(4, y, 12);
			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s %s", ds, dm, x, y, a);
			break;

		case 6:
			trap_Argv(1, ds, 12);
			trap_Argv(2, dm, 12);
			trap_Argv(3, x, 12);
			trap_Argv(4, y, 12);
			trap_Argv(5, a, 12);
			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s %s", ds, dm, x, y, a);
			break;
	}

	trap_Cvar_Set("ch_Speedometer", st);

#if 0
	/* This neat little hack allows users to skip
	using quotes in the console */
	if ( trap_Argc() < 6 ) {
		//Hack.
		trap_SendConsoleCommand("ch_Speedometer");
		return;
	}
	trap_Cvar_Set( "ch_Speedometer", ConcatArgs(1) );
	//trap_SendConsoleCommand("ch_Speedometer %s", ConcatArgs(1));
#endif
}

static void CG_OBDetector_f ( void ) {
	int ac;//, i;
	char st[MAX_CVAR_VALUE_STRING], *tmp;
	char d[12], x[12], y[12], a[12];

	ac = trap_Argc();
	tmp = ch_OBDetector.string;
	CG_ExtractToken(&tmp, d);
	CG_ExtractToken(&tmp, x);
	CG_ExtractToken(&tmp, y);
	CG_ExtractToken(&tmp, a);

	switch(ac)
	{
		case 1:
			trap_SendConsoleCommand("ch_OBDetector");
			return;

		case 2:
			trap_Argv(1, d, 12);
			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s", d, x, y, a);
			break;

		case 3:
			trap_Argv(1, d, 12);
			trap_Argv(2, x, 12);
			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s", d, x, y, a);
			break;

		case 4:
			trap_Argv(1, d, 12);
			trap_Argv(2, x, 12);
			trap_Argv(3, y, 12);
			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s", d, x, y, a);
			break;

		case 5:
			trap_Argv(1, d, 12);
			trap_Argv(2, x, 12);
			trap_Argv(3, y, 12);
			trap_Argv(4, a, 12);
			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s", d, x, y, a);
			break;
	}

	trap_Cvar_Set("ch_OBDetector", st);
}

static void CG_Weaponsidebar_f ( void ) {
	int ac;//, i;
	char st[MAX_CVAR_VALUE_STRING], *tmp;
	char ds[12], bc[12], fc[12], sc[12], sf[12];

	ac = trap_Argc();
	tmp = ch_weaponSideBar.string;
	CG_ExtractToken(&tmp, ds);
	CG_ExtractToken(&tmp, bc);
	CG_ExtractToken(&tmp, fc);
	CG_ExtractToken(&tmp, sc);
	CG_ExtractToken(&tmp, sf);

	switch(ac)
	{
		case 1:
			trap_SendConsoleCommand("ch_weaponSideBar");
			return;

		case 2:
			trap_Argv(1, ds, 12);
			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s %s", ds, bc, fc, sc, sf);
			break;

		case 3:
			trap_Argv(1, ds, 12);
			trap_Argv(2, bc, 12);
			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s %s", ds, bc, fc, sc, sf);
			break;

		case 4:
			trap_Argv(1, ds, 12);
			trap_Argv(2, bc, 12);
			trap_Argv(3, fc, 12);
			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s %s", ds, bc, fc, sc, sf);
			break;

		case 5:
			trap_Argv(1, ds, 12);
			trap_Argv(2, bc, 12);
			trap_Argv(3, fc, 12);
			trap_Argv(4, sc, 12);
			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s %s", ds, bc, fc, sc, sf);
			break;

		case 6:
			trap_Argv(1, ds, 12);
			trap_Argv(2, bc, 12);
			trap_Argv(3, fc, 12);
			trap_Argv(4, sc, 12);
			trap_Argv(5, sf, 12);
			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s %s", ds, bc, fc, sc, sf);
			break;
	}

	trap_Cvar_Set("ch_weaponSideBar", st);

#if 0
	/* This neat little hack allows users to skip
	using quotes in the console */
	if ( trap_Argc() < 6 ) {
		//Hack.
		trap_SendConsoleCommand("ch_weaponSideBar");
		return;
	}
	trap_Cvar_Set( "ch_weaponSideBar", ConcatArgs(1) );
#endif
}

static void CG_KeyPress_f ( void ) {
	int ac;//, i;
	char st[MAX_CVAR_VALUE_STRING], *tmp;
	char dk[12], x[12], y[12], kc[12], fc[12], s[12];

	ac = trap_Argc();
	tmp = ch_viewKeyPress.string;
	CG_ExtractToken(&tmp, dk);
	CG_ExtractToken(&tmp, x);
	CG_ExtractToken(&tmp, y);
	CG_ExtractToken(&tmp, kc);
	CG_ExtractToken(&tmp, fc);
	CG_ExtractToken(&tmp, s);

	switch(ac)
	{
		case 1:
			trap_SendConsoleCommand("ch_viewKeyPress");
			return;

		case 2:
			trap_Argv(1, dk, 12);
			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s %s %s", dk, x, y, kc, fc, s);
			break;

		case 3:
			trap_Argv(1, dk, 12);
			trap_Argv(2, x, 12);
			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s %s %s", dk, x, y, kc, fc, s);
			break;

		case 4:
			trap_Argv(1, dk, 12);
			trap_Argv(2, x, 12);
			trap_Argv(3, y, 12);
			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s %s %s", dk, x, y, kc, fc, s);
			break;

		case 5:
			trap_Argv(1, dk, 12);
			trap_Argv(2, x, 12);
			trap_Argv(3, y, 12);
			trap_Argv(4, kc, 12);
			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s %s %s", dk, x, y, kc, fc, s);
			break;

		case 6:
			trap_Argv(1, dk, 12);
			trap_Argv(2, x, 12);
			trap_Argv(3, y, 12);
			trap_Argv(4, kc, 12);
			trap_Argv(5, fc, 12);
			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s %s %s", dk, x, y, kc, fc, s);
			break;

		case 7:
			trap_Argv(1, dk, 12);
			trap_Argv(2, x, 12);
			trap_Argv(3, y, 12);
			trap_Argv(4, kc, 12);
			trap_Argv(5, fc, 12);
			trap_Argv(6, s, 12);
			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s %s %s", dk, x, y, kc, fc, s);
			break;
	}

	trap_Cvar_Set("ch_viewKeyPress", st);

#if 0
	/* This neat little hack allows users to skip
	using quotes in the console */
	if ( trap_Argc() < 7 ) {
		//Hack.
		trap_SendConsoleCommand("ch_viewKeyPress");
		return;
	}
	trap_Cvar_Set( "ch_viewKeyPress", ConcatArgs(1) );
#endif
}

void CG_resetMaxSpeed_f (void) {
	max_speed = 0;
}

void CG_SetAlarm_f ( void ) {
	//byte		time_type;
	char		token[24];

	trap_Argv( 1, token, sizeof(token) );
	if ( !Q_stricmp( "unset", token ) ) {
		cg.alarmSet = qfalse;
		return;
	}

	if ( trap_Argc() < 1 ) {
		CG_Printf("Make sure you set the alarm correctly.\n /alarm unset or /alarm <hour> <minute> <time_type>v-- Example: /alarm 1 9 32\n ");
	}
	//Set the variables, everything else is taken care of *in* the alarm.
	cg.alarmSet = qtrue;
	//cg.time_type = atoi( CG_Argv( 2 ) );
	cg.alarmTime_hour = atoi( token );
	//CG_Printf( "%s ", token );
	trap_Argv( 2, token, sizeof(token) );
	//CG_Printf( "%s ", token );
	cg.alarmTime_minute = atoi( token );
	//CG_Printf("hour %i, minute %i\n", cg.alarmTime_hour, cg.alarmTime_minute);
	if ( trap_Argc() > 3 ) {
		trap_Argv( 3, token, sizeof(token) );
		cg.time_type = atoi( token );
	}

}


//static void CG_DbgRWS_f ( void ) {
//
//	
//	if ( cgs.dbgrws ) {
//		//Only add server debuging once the client stuff has been verified to work
//		//Secondly, send a server command so it know's we're debugging it.
//		trap_SendClientCommand("dbgrws \n");
//		return;
//	}
//
//	//Firstly set the qboolean to know we're debugging it
//	if ( !cgs.dbgrws ) {//On
//		cgs.dbgrws = qtrue;
//	} else {//Off
//		cgs.dbgrws = qfalse;
//		//We'll have to turn it off, no server side only dbg's for now =[
//		trap_SendClientCommand("dbgrws \n");
//	}
//	if ( !cg.dbgsto ) {//On
//		cg.dbgsto = qtrue;
//	} else {//Off
//		cg.dbgsto = qfalse;
//	}
//}

static void CG_HelpSystem_f(void)
{
//	char			*text_p, *prev;
	int				length = 0;//, linelength = 0;
//	int				j = 0, m = 0, l = 0, k = 0;
//	char			*line;
//	char			explanation[256];
	char			text[MAX_HELP_FILE_SIZE];
	char			filename[MAX_QPATH];
	char			arg1[128], arg2[128];
	char			tmp[513];
	char			*token, *ptr;
//	qboolean		helpList = qfalse;
	fileHandle_t	f;
	int				i;
	qboolean		serverhelp = qfalse;

	arg1[2] = '\0';
	arg2[0] = '\0';
	trap_Argv(1, arg1, sizeof(arg1));

	if(arg1[0] == '-' && arg1[1] == 's' && arg1[2] == '\0')
	{
		serverhelp = qtrue;
		trap_Argv(2, arg2, sizeof(arg2));

		if((strlen(language.string) > 1) && (CG_FileExists(va("config/help/server/%s.help.cfg", language.string))))
			Com_sprintf(filename, sizeof(filename), "config/help/server/%s.help.cfg", language.string);
		else
		{
			CG_Printf(""S_COLOR_RED"Loading %s.help.cfg failed! Defaulting to en.help.cfg\n", language.string);
			Com_sprintf(filename, sizeof(filename), "config/help/server/en.help.cfg");
		}
	}
	else
	{
		if((strlen(language.string) > 1) && (CG_FileExists(va("config/help/client/%s.help.cfg", language.string))))
			Com_sprintf(filename, sizeof(filename), "config/help/client/%s.help.cfg", language.string);
		else
		{
			CG_Printf(""S_COLOR_RED"Loading %s.help.cfg failed! Defaulting to en.help.cfg\n", language.string);
			Com_sprintf(filename, sizeof(filename), "config/help/client/en.help.cfg");
		}
	}

	if((length = trap_FS_FOpenFile(filename, &f, FS_READ)) <= 0)
	{
		CG_Printf(""S_COLOR_RED"Loading %s.help.cfg failed! Failed to open the file\n", language.string);
		return;
	}

	if(length >= MAX_HELP_FILE_SIZE)
	{
		CG_Printf(""S_COLOR_RED"Loading %s.help.cfg failed! File too large\n", language.string);
		return;
	}

	trap_FS_Read(text, length, f);
	text[length] = '\0';
	trap_FS_FCloseFile(f);

	if((!serverhelp && !arg1[0]) || (serverhelp && !arg2[0]))
	{
		if(serverhelp)
		{
			//list all the available server help commands
			if(!(token = HelpParse(arg2, text, qtrue)))
			{
				CG_Printf(""S_COLOR_RED"ERROR: Failed to read the help file\n", arg1);
				return;
			}
		}
		else
		{
			//list all the available help commands
			if(!(token = HelpParse(arg1, text, qtrue)))
			{
				CG_Printf(""S_COLOR_RED"ERROR: Failed to read the help file\n", arg1);
				return;
			}
		}

		length = strlen(token);
		if(length > 512)
		{
			//CG_Printf seems to have a limit to the length of a string that can be output
			//so we play it safe and break the output into 512 character chunks
			if(serverhelp)
				CG_Printf(""S_COLOR_YELLOW"The following server commands/cvars are available:\n");
			else
				CG_Printf(""S_COLOR_YELLOW"The following commands/cvars are available:\n");

			ptr = token;
			for(i = 0; i < (length / 512); i++)
			{
				if(i != ((length / 512) - 1))
				{
					memcpy(tmp, ptr, 512);
					tmp[512] = '\0';
				}
				else
				{
					memcpy(tmp, ptr, length - (i * 512));
					tmp[length - (i * 512)] = '\0';
				}

				CG_Printf(""S_COLOR_YELLOW"%s", tmp);
				ptr += 512;
			}

			CG_Printf("\n");
		}
		else
		{
			if(serverhelp)
				CG_Printf(""S_COLOR_YELLOW"The following server commands/cvars are available:\n%s\n", token);
			else
				CG_Printf(""S_COLOR_YELLOW"The following commands/cvars are available:\n%s\n", token);
		}

		CG_Printf(""S_COLOR_YELLOW"\n%s %s\n", GAMEVERSION, BUILDINFO);
		CG_Printf(""S_COLOR_YELLOW"Usage: \\help command\n");
	}
	else
	{
		if(serverhelp)
		{
			//list only the specified server help command
			if(!(token = HelpParse(arg2, text, qfalse)))
			{
				CG_Printf(""S_COLOR_RED"ERROR: Command %s not found\n", arg2);
				return;
			}
		}
		else
		{
			//list only the specified help command
			if(!(token = HelpParse(arg1, text, qfalse)))
			{
				CG_Printf(""S_COLOR_RED"ERROR: Command %s not found\n", arg1);
				return;
			}
		}

		CG_Printf(""S_COLOR_YELLOW"%s\n", token);
	}

#if 0
	//memset(&print, 0, sizeof(print));
	memset(&explanation, 0, sizeof(explanation));
	text_p = text;

	if((strlen(arg1) == 0) && (!Q_stricmp(arg1, "help_list")))
	{
			token = stristr(text_p, "help_list");
			helpList = qtrue;
		} else {
			token = stristr(text_p, arg1);
		}

	if(!helpList)
	{
			Com_sprintf(explanation, sizeof(explanation), HelpParse(token));
			if ( strlen(explanation) < 3 ) {//No possible way this could be valid
				memset(explanation, 0, sizeof(explanation) );
				//Com_sprintf(explanation, sizeof(explanation), HelpParse("help_list"));
				token = stristr(text_p, "help_list");
				helpList = qtrue;
				CG_Printf(""S_COLOR_RED"ERROR: Command %s not found.\n", arg1);
			}
		} /*else*/
		if ( helpList ) {
			qboolean	insertNewline = qfalse;
			qboolean	foundStart = qfalse;
			qboolean	foundEnd = qfalse;
			qboolean	start = qfalse;

			CG_Printf("Availabe help cmmands:\n");

			while ( 1 ) {
				prev = text_p; //so we can unget
				line = COM_Parse(&token);


				if ( (line[j - 1] == '{' || line[0] == '{') && !foundStart ) {
					foundStart = qtrue;
				}

				if ( foundStart ) {//This is consuming, but safe-ish
					memset(&checkChar, 0, sizeof(checkChar));
					Com_sprintf(checkChar, sizeof(checkChar), line );
					for ( l = 0; l != strlen(checkChar); l++ ) {
						if ( checkChar[l] == '}' ) {
							foundEnd = qtrue; //Use this to break the while loop
							break;//break this loop, no need to continue
						}
					}
				}

				if ( foundEnd ) {
					break;
				}

				if ( start ) {
					//This is a very good example of laziness
					//FixedName to align things, then point line to it..
					if ( m < 2 ) {
						m++;
						FixedName( newLine, line, 26 );
						line = newLine;//Re-pointer to avoid changing a bunch of code.
					} else {
						m = 0;
						insertNewline = qtrue;
					}
					j = strlen(newLine);

					if ( linelength + j > 1024 ) {
						//This voids the string limit to make sure all the columns get lined up.
						//Not exactly safe, careful for endless loops
						CG_Printf("%s", explanation);
						memset(&explanation, 0, sizeof(explanation));
						linelength = 0;
					}
					linelength += j;
					Q_strcat(explanation, sizeof(explanation), va("%s", line));

					if ( insertNewline ) {
						k++;
						insertNewline = qfalse;
					//	linelength++;
					//	Q_strcat(explanation, sizeof(explanation), " ");
					//	linelength++;
					//	explanation[linelength] = '\n';
						/* Trying this */
						//Ideally we should do this, print every time we want a new line
						//for some reason it'd only add a new line 5 times, then stop.
						//This works around that.
						CG_Printf("%s\n", explanation);
						memset(&explanation, 0, sizeof(explanation));
						linelength = 0;
					}

				}

				if ( foundStart && !start ) {
					start = qtrue;
				}
			}
		}

		CG_Printf("%s\n", explanation);
		if ( helpList ) {
			CG_Printf("\n%s %s\n", GAMEVERSION, BUILDINFO);
			CG_Printf("usage: \\help command \n");
		}
#endif
}

//Superhud - Begin
int	findArrayNum ( char *arrayName ) {
	//ugly if/else setup
	//We return from the enum list to make sure we're in sync, it's also easier to understand and update
	if ( !Q_stricmp(arrayName, "!DEFAULT")) {
		return DEFAULT;
	} else if ( !Q_stricmp( arrayName, "PreDecorate" )) {
		return PreDecorate;
	} else if ( !Q_stricmp( arrayName, "AmmoMessage" )) {
		return AmmoMessage;
	} else if ( !Q_stricmp( arrayName, "Chat1" )) {
		return Chat1;
	} else if ( !Q_stricmp( arrayName, "Chat2" )) {
		return Chat2;
	} else if ( !Q_stricmp( arrayName, "Chat3" )) {
		return Chat3;
	} else if ( !Q_stricmp( arrayName, "Chat4" )) {
		return Chat4;
	} else if ( !Q_stricmp( arrayName, "Chat5" )) {
		return Chat5;
	} else if ( !Q_stricmp( arrayName, "Chat6" )) {
		return Chat6;
	} else if ( !Q_stricmp( arrayName, "Chat7" )) {
		return Chat7;
	} else if ( !Q_stricmp( arrayName, "Chat8" )) {
		return Chat8;
	} else if ( !Q_stricmp( arrayName, "Console" )) {
		return Console;
	} else if ( !Q_stricmp( arrayName, "FlagStatus_NME" )) {
		return FlagStatus_NME;
	} else if ( !Q_stricmp( arrayName, "FlagStatus_OWN" )) {
		return FlagStatus_OWN;
	} else if ( !Q_stricmp( arrayName, "FollowMessage" )) {
		return FollowMessage;
	} else if ( !Q_stricmp( arrayName, "FPS" )) {
		return FPS;
	} else if ( !Q_stricmp( arrayName, "FragMessage" )) {
		return FragMessage;
	} else if ( !Q_stricmp( arrayName, "GameTime" )) {
		return GameTime;
	} else if ( !Q_stricmp( arrayName, "GameType" )) {
		return GameType;
	} else if ( !Q_stricmp( arrayName, "ItemPickup" )) {
		return ItemPickup;
	} else if ( !Q_stricmp( arrayName, "ItemPickupIcon" )) {
		return ItemPickupIcon;
	} else if ( !Q_stricmp( arrayName, "NetGraph" )) {
		return NetGraph;
	} else if ( !Q_stricmp( arrayName, "NetGraphPing" )) {
		return NetGraphPing;
	} else if ( !Q_stricmp( arrayName, "PlayerSpeed" )) {
		return PlayerSpeed;
	} else if ( !Q_stricmp( arrayName, "PowerUp1_Icon" )) {
		return PowerUp1_Icon;
	} else if ( !Q_stricmp( arrayName, "PowerUp2_Icon" )) {
		return PowerUp2_Icon;
	} else if ( !Q_stricmp( arrayName, "PowerUp3_Icon" )) {
		return PowerUp3_Icon;
	} else if ( !Q_stricmp( arrayName, "PowerUp4_Icon" )) {
		return PowerUp4_Icon;
	} else if ( !Q_stricmp( arrayName, "PowerUp1_Time" )) {
		return PowerUp1_Time;
	} else if ( !Q_stricmp( arrayName, "PowerUp2_Time" )) {
		return PowerUp2_Time;
	} else if ( !Q_stricmp( arrayName, "PowerUp3_Time" )) {
		return PowerUp3_Time;
	} else if ( !Q_stricmp( arrayName, "PowerUp4_Time" )) {
		return PowerUp4_Time;
	} else if ( !Q_stricmp( arrayName, "RankMessage" )) {
		return RankMessage;
	} else if ( !Q_stricmp( arrayName, "Score_Limit" )) {
		return Score_Limit;
	} else if ( !Q_stricmp( arrayName, "Score_NME" )) {
		return Score_NME;
	} else if ( !Q_stricmp( arrayName, "Score_OWN" )) {
		return Score_OWN;
	} else if ( !Q_stricmp( arrayName, "SpecMessage" )) {
		return SpecMessage;
	} else if ( !Q_stricmp( arrayName, "StatusBar_ArmorBar" )) {
		return StatusBar_ArmorBar;
	} else if ( !Q_stricmp( arrayName, "StatusBar_ArmorCount" )) {
		return StatusBar_ArmorCount;
	} else if ( !Q_stricmp( arrayName, "StatusBar_ArmorIcon" )) {
		return StatusBar_ArmorIcon;
	} else if ( !Q_stricmp( arrayName, "StatusBar_AmmoBar" )) {
		return StatusBar_AmmoBar;
	} else if ( !Q_stricmp( arrayName, "StatusBar_AmmoCount" )) {
		return StatusBar_AmmoCount;
	} else if ( !Q_stricmp( arrayName, "StatusBar_AmmoIcon" )) {
		return StatusBar_AmmoIcon;
	} else if ( !Q_stricmp( arrayName, "StatusBar_HealthBar" )) {
		return StatusBar_HealthBar;
	} else if ( !Q_stricmp( arrayName, "StatusBar_HealthCount" )) {
		return StatusBar_HealthCount;
	} else if ( !Q_stricmp( arrayName, "StatusBar_HealthIcon" )) {
		return StatusBar_HealthIcon;
	} else if ( !Q_stricmp( arrayName, "TargetName" )) {
		return TargetName;
	} else if ( !Q_stricmp( arrayName, "TargetStatus" )) {
		return TargetStatus;
	} else if ( !Q_stricmp( arrayName, "TeamCount_NME" )) {
		return TeamCount_NME;
	} else if ( !Q_stricmp( arrayName, "TeamCount_OWN" )) {
		return TeamCount_OWN;
	} else if ( !Q_stricmp( arrayName, "TeamIcon_NME" )) {
		return TeamIcon_NME;
	} else if ( !Q_stricmp( arrayName, "TeamIcon_OWN" )) {
		return TeamIcon_OWN;
	} else if ( !Q_stricmp( arrayName, "Team1" )) {
		return Team1;
	} else if ( !Q_stricmp( arrayName, "Team2" )) {
		return Team2;
	} else if ( !Q_stricmp( arrayName, "Team3" )) {
		return Team3;
	} else if ( !Q_stricmp( arrayName, "Team4" )) {
		return Team4;
	} else if ( !Q_stricmp( arrayName, "Team5" )) {
		return Team5;
	} else if ( !Q_stricmp( arrayName, "Team6" )) {
		return Team6;
	} else if ( !Q_stricmp( arrayName, "Team7" )) {
		return Team7;
	} else if ( !Q_stricmp( arrayName, "Team8" )) {
		return Team8;
	} else if ( !Q_stricmp( arrayName, "VoteMessageArena" )) {
		return VoteMessageArena;
	} else if ( !Q_stricmp( arrayName, "VoteMessageWorld" )) {
		return VoteMessageWorld;
	} else if ( !Q_stricmp( arrayName, "WarmupInfo" )) {
		return WarmupInfo;
	} else if ( !Q_stricmp( arrayName, "WeaponList" )) {
		return WeaponList;
	} else if ( !Q_stricmp( arrayName, "PostDecorate" )) {
		return PostDecorate;
	} else {
		//No recognized command
		return none;
	}

}

//token_type GetToken(char *token, char **line)
//{
//	char *ptr;
//	token_type ret = T_TOKEN;
//
//	if((**line) == '\0')
//	{
//		*ptr = '\0';
//		return T_EOF;
//	}
//
//	ptr = token;
//
//t_start:
//	//scan off leading spaces, tabs, commas and newlines
//	while(((**line) == ' ') || ((**line) == '\t') || ((**line) == '\n') || ((**line) == 0xd) || ((**line) == ','))
//		(*line)++;
//
//	if((**line) == ';')
//	{
//		(*line)++;
//		*ptr = '\0';
//		return T_SEMI;
//	}
//	else if((**line) == '{')
//	{
//		(*line)++;
//		*ptr = '\0';
//		return T_BEGIN_BRACKET;
//	}
//	else if((**line) == '}')
//	{
//		(*line)++;
//		*ptr = '\0';
//		return T_END_BRACKET;
//	}
//	else if((**line) == '#')
//	{
//		//comments
//		while(((**line) != '\n') && ((**line) != 0xd))
//		{
//			if((**line) == '\0')
//			{
//				*ptr = '\0';
//				return T_EOF;
//			}
//
//			(*line)++;
//		}
//
//		goto t_start;
//	}
//	else if((**line) == '"')
//	{
//		(*line)++;
//
//		//string
//		while((**line) != '"')
//		{
//			if((**line) == '\0')
//			{
//				*ptr = '\0';
//				return T_EOF;
//			}
//
//			(*ptr) = (**line);
//			ptr++;
//			(*line)++;
//		}
//
//		(*line)++;
//		*ptr = '\0';
//		return T_STRING;
//	}
//	else if((**line) == '\0')
//	{
//		*ptr = '\0';
//		return T_EOF;
//	}
//
//	//parse the token
//	while(((**line) != ' ') && ((**line) != '\t') && ((**line) != '\n') && ((**line) != 0xd) && ((**line) != ',') && ((**line) != ';') && ((**line) != '{') && ((**line) != '}'))
//	{
//		if((**line) == '\0')
//			break;
///*
//		if(((**line) == ';'))
//		{
//			(*line)++;			//skip over the semi
//			ret = T_SEMI;
//			break;
//		}
//*/
//		(*ptr) = (**line);
//		ptr++;
//		(*line)++;
//	}
//
//	*ptr = '\0';
//	
//	return ret;
//}

//NOTE: hud[] array length = maxHudCommands + 64
void ParseHud( void ) {
	char			token[MAX_TOKEN_CHARS];			//max size for a single token
	char			filestring[MAX_HELP_FILE_SIZE];
//	qboolean		cmdu[maxHudCommands];			//marks when a command has been used
	static char		*fsptr;
	int				index = 0;						//index into hud array
	int				ret, cmdi, i;
	int				length = 0;
	char			filename[MAX_QPATH];
	fileHandle_t	f;
	hud_t			default_info;
	char			*ptr;
//	int				eof_count = 0;//fault tolerance.

	//check for a file extension
	if((length = strlen(ch_file.string)) <= 0)
		return;

	ptr = ch_file.string + (length - 1);
	while((ptr != ch_file.string) && (*ptr != '.'))
		ptr--;

	if(ptr == ch_file.string)
	{
		//have to add extension
		if(CG_FileExists(va("hud/%s.cfg", ch_file.string)))
		{
			Com_sprintf(filename, sizeof(filename), "hud/%s.cfg", ch_file.string);
			trap_Cvar_Set("ch_file", va("%s.cfg", ch_file.string));
		}
		else
		{
			CG_Printf(""S_COLOR_RED"Loading HUD file %s failed! Defaulting to no HUD file\n", ch_file.string);
			trap_Cvar_Set("ch_file", "");
		}
	}
	else
	{
		if(CG_FileExists(va("hud/%s", ch_file.string)))
			Com_sprintf(filename, sizeof(filename), "hud/%s", ch_file.string);
		else
		{
			CG_Printf(""S_COLOR_RED"Loading HUD file %s failed! Defaulting to no HUD file\n", ch_file.string);
			trap_Cvar_Set("ch_file", "");
		}
	}

	//load the file
	length = 0;
	if((length = trap_FS_FOpenFile(filename, &f, FS_READ)) <= 0)
	{
		CG_Printf(""S_COLOR_RED"Loading HUD file %s failed! Empty HUD file\n", ch_file.string);
		return;
	}

	if(length >= MAX_HELP_FILE_SIZE - 1)
	{
		CG_Printf(""S_COLOR_RED"Loading HUD file %s failed! HUD file is too long\n", ch_file.string);
		return;
	}

	memset(filestring, 0, MAX_HELP_FILE_SIZE);
	trap_FS_Read(filestring, length, f);
	trap_FS_FCloseFile(f);
	filestring[length] = '\0';
	fsptr = filestring;

	memset(&default_info, 0, sizeof(default_info));

	//loop through each element
	while(*fsptr)
	{
		if(index >= (maxHudCommands + 64))
		{
			CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! hud[] array overflow", ch_file.string);
			break;
		}

		if((ret = GetToken(token, &fsptr)) == T_EOF)
			break;

		//command name
		if((cmdi = findArrayNum(token)) == none)
		{
			CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! Unrecognized command %s", ch_file.string, token);
			break;
		}

		if(cmdi != DEFAULT)
			memcpy(&hud[index], &default_info, sizeof(hud_t));
		else
		{
			//reset booleans to get around a limitation/bug known about in CPMA
			default_info.draw3d = qfalse;
			default_info.fill = qfalse;
			default_info.doublebar = qfalse;
			default_info.monospace = qfalse;
		}

		hud[index].element = cmdi;
		strncpy(hud[index].name, token, 41);

		ret = GetToken(token, &fsptr);
		if(ret != T_BEGIN_BRACKET)
		{
			CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! Expected '{' after command %s", ch_file.string, hud[index].name);
			break;
		}

		while(*fsptr)
		{
			ret = GetToken(token, &fsptr);

			if(ret == T_END_BRACKET)
				break;
			else if(ret == T_BEGIN_BRACKET)
			{
				CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! Syntax error in definition of %s: too many '{' found", ch_file.string, hud[index].name);
				hud_count = index;
				return;
			}
			else if(ret == T_EOF)
			{
				CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! Unexpected end of file", ch_file.string);
				hud_count = index;
				return;
			}
			else if(ret == T_SEMI)
				continue;

			if(!Q_stricmp(token, "bgcolor"))
			{
				for(i = 0; i < 4; i++)
				{
					ret = GetToken(token, &fsptr);
					if(token[0] == 'T')
					{
						if(cmdi == DEFAULT)
							default_info.TEBgcolor = TEAM_COLORS;
						else
							hud[index].TEBgcolor = TEAM_COLORS;
					}
					else if(token[0] == 'E')
					{
						if(cmdi == DEFAULT)
							default_info.TEBgcolor = ENEMY_COLORS;
						else
							hud[index].TEBgcolor = ENEMY_COLORS;
					}
					else
					{
						if(ret != T_TOKEN || token[0] < 0x2d || token[0] > 0x39 || token[0] == 0x2f)
						{
							CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! bgcolor command requires 4 color values", ch_file.string);
							hud_count = index;
							return;
						}

						if(cmdi == DEFAULT)
							default_info.bgcolor[i] = atof(token);
						else
							hud[index].bgcolor[i] = atof(token);
					}
				}
			}
			else if(!Q_stricmp(token, "color"))
			{
				for(i = 0; i < 4; i++)
				{
					ret = GetToken(token, &fsptr);
					if(token[0] == 'T')
					{
						if(cmdi == DEFAULT)
							default_info.TEBgcolor = TEAM_COLORS;
						else
							hud[index].TEBgcolor = TEAM_COLORS;
					}
					else if(token[0] == 'E')
					{
						if(cmdi == DEFAULT)
							default_info.TEBgcolor = ENEMY_COLORS;
						else
							hud[index].TEBgcolor = ENEMY_COLORS;
					}
					else
					{
						if(ret != T_TOKEN || token[0] < 0x2d || token[0] > 0x39 || token[0] == 0x2f)
						{
							CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! color command requires 4 color values", ch_file.string);
							hud_count = index;
							return;
						}

						if(cmdi == DEFAULT)
							default_info.color[i] = atof(token);
						else
							hud[index].color[i] = atof(token);
					}
				}
			}
			else if(!Q_stricmp(token, "doublebar"))
			{
				if(cmdi == DEFAULT)
					default_info.doublebar = qtrue;
				else
					hud[index].doublebar = qtrue;
			}
			else if(!Q_stricmp(token, "fade"))
			{
				for(i = 0; i < 4; i++)
				{
					ret = GetToken(token, &fsptr);
					if(ret != T_TOKEN || token[0] < 0x2d || token[0] > 0x39 || token[0] == 0x2f)
					{
						CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! fade command requires 4 color values", ch_file.string);
						hud_count = index;
						return;
					}

					if(cmdi == DEFAULT)
						default_info.fade[i] = atof(token);
					else
						hud[index].fade[i] = atof(token);
				}
			}
			else if(!Q_stricmp(token, "fill"))
			{
				if(cmdi == DEFAULT)
					default_info.fill = qtrue;
				else
					hud[index].fill = qtrue;
			}
			else if(!Q_stricmp(token, "font"))
			{
				ret = GetToken(token, &fsptr);
				if(ret != T_TOKEN)
				{
					CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! Invalid syntax in font command", ch_file.string);
					hud_count = index;
					return;
				}

				if(Q_stricmp(token, "cpma") && Q_stricmp(token, "id") && Q_stricmp(token, "idblock") && Q_stricmp(token, "threewave"))
				{
					CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! Invalid font %s", ch_file.string, token);
					hud_count = index;
					return;
				}

				if(cmdi == DEFAULT)
					strncpy(default_info.font, token, sizeof(default_info.font));
				else
					strncpy(hud[index].font, token, sizeof(hud[index].font));
			}
			else if(!Q_stricmp(token, "fontsize"))
			{
				ret = GetToken(token, &fsptr);
				if(ret != T_TOKEN || token[0] < 0x30 || token[0] > 0x39)
				{
					CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! fontsize command requires at least 1 integer value", ch_file.string);
					hud_count = index;
					return;
				}

				if(cmdi == DEFAULT)
					default_info.fontsize[0] = atoi(token);
				else
					hud[index].fontsize[0] = atoi(token);

				if(GetToken(token, &fsptr) == T_EOF)
				{
					CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! Unexpected end of file", ch_file.string);
					hud_count = index;
					return;
				}

				if(token[0] >= 0x30 && token[0] <= 0x39)
				{
					if(cmdi == DEFAULT)
						default_info.fontsize[1] = atoi(token);
					else
						hud[index].fontsize[1] = atoi(token);
				}
				else
				{
					if(cmdi == DEFAULT)
						default_info.fontsize[1] = -1;
					else
						hud[index].fontsize[1] = -1;

					//reset the current position in the file
					fsptr -= strlen(token);
				}
			}
			else if(!Q_stricmp(token, "image"))
			{
				char *ep;

				ret = GetToken(token, &fsptr);
				if(ret != T_STRING)
				{
					CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! image command requires an image file to be specified", ch_file.string);
					hud_count = index;
					return;
				}

				ep = token;
				while(*ep != '\0')
					ep++;

				ep -= 5;
				if(!Q_stricmp(ep, ".skin"))
				{
					if(cmdi == DEFAULT)
						default_info.image = trap_R_RegisterSkin(token);
					else
						hud[index].image = trap_R_RegisterSkin(token);
				}
				else
				{
					if(cmdi == DEFAULT)
						default_info.image = trap_R_RegisterShader(token);
					else
						hud[index].image = trap_R_RegisterShader(token);
				}
			}
			else if(!Q_stricmp(token, "monospace"))
			{
				if(cmdi == DEFAULT)
					default_info.monospace = qtrue;
				else
					hud[index].monospace = qtrue;
			}
			else if(!Q_stricmp(token, "rect"))
			{
				for(i = 0; i < 4; i++)
				{
					ret = GetToken(token, &fsptr);
					if(ret != T_TOKEN || (token[0] < 0x30 && token[0] != 0x2d) || token[0] > 0x39)
					{
						CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! rect command requires 4 integer values", ch_file.string);
						hud_count = index;
						return;
					}

					if(cmdi == DEFAULT)
						default_info.rect[i] = atoi(token);
					else
						hud[index].rect[i] = atoi(token);
				}
			}
			else if(!Q_stricmp(token, "text"))
			{
				ret = GetToken(token, &fsptr);
				if(ret != T_STRING)
				{
					CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! text command requires a string of characters", ch_file.string);
					hud_count = index;
					return;
				}

				if(cmdi == DEFAULT)
					strncpy(default_info.text, token, 255);
				else
					strncpy(hud[index].text, token, 255);
			}
			else if(!Q_stricmp(token, "textalign"))
			{
				ret = GetToken(token, &fsptr);
				if(ret != T_TOKEN)
				{
					CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! textalign command requires either L, C or R as an argument", ch_file.string);
					hud_count = index;
					return;
				}

				if(token[0] == 'l' || token[0] == 'L')
				{
					if(cmdi == DEFAULT)
						default_info.textalign = 2;
					else
						hud[index].textalign = 2;
				}
				else if(token[0] == 'c' || token[0] == 'C')
				{
					if(cmdi == DEFAULT)
						default_info.textalign = 1;
					else
						hud[index].textalign = 1;
				}
				else if(token[0] == 'r' || token[0] == 'R')
				{
					if(cmdi == DEFAULT)
						default_info.textalign = 0;
					else
						hud[index].textalign = 0;
				}
				else
				{
					CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! textalign command requires either l, c or r as an argument", ch_file.string);
					hud_count = index;
					return;
				}
			}
			else if(!Q_stricmp(token, "textstyle"))
			{
				ret = GetToken(token, &fsptr);
				if(ret != T_TOKEN || token[0] < 0x30 || token[0] > 0x39)
				{
					CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! textstyle command requires an integer value (0 or 1)", ch_file.string);
					hud_count = index;
					return;
				}

				if(cmdi == DEFAULT)
					default_info.textstyle = atoi(token);
				else
					hud[index].textstyle = atoi(token);
			}
			else if(!Q_stricmp(token, "time"))
			{
				ret = GetToken(token, &fsptr);
				if(ret != T_TOKEN || (token[0] < 0x30 && token[0] != 0x2d) || token[0] > 0x39)
				{
					CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! time command requires an integer value", ch_file.string);
					hud_count = index;
					return;
				}

				if(cmdi == DEFAULT)
					default_info.time = atoi(token);
				else
					hud[index].time = atoi(token);
			}
			else if(!Q_stricmp(token, "model"))
			{
				ret = GetToken(token, &fsptr);
				if(ret != T_STRING)
				{
					CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! image command requires an image file to be specified", ch_file.string);
					hud_count = index;
					return;
				}

				if(cmdi == DEFAULT)
					default_info.model = trap_R_RegisterModel(token);
				else
					hud[index].model = trap_R_RegisterModel(token);
			}
			else if(!Q_stricmp(token, "angles"))
			{
				for(i = 0; i < 3; i++)
				{
					ret = GetToken(token, &fsptr);
					if(ret != T_TOKEN || token[0] < 0x2d || token[0] > 0x39 || token[0] == 0x2f)
					{
						CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! angles command requires 3 float values", ch_file.string);
						hud_count = index;
						return;
					}

					if(cmdi == DEFAULT)
						default_info.angles[i] = atof(token);
					else
						hud[index].angles[i] = atof(token);
				}

				ret = GetToken(token, &fsptr);
				if(ret != T_TOKEN || token[0] < 0x2d || token[0] > 0x39 || token[0] == 0x2f)
					fsptr -= strlen(token);
				else
				{
					if(cmdi == DEFAULT)
						default_info.angles[3] = atof(token);
					else
						hud[index].angles[3] = atof(token);
				}
			}
			else if(!Q_stricmp(token, "offset"))
			{
				for(i = 0; i < 3; i++)
				{
					ret = GetToken(token, &fsptr);
					if(ret != T_TOKEN || token[0] < 0x2d || token[0] > 0x39 || token[0] == 0x2f)
					{
						CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! offset command requires 3 float values", ch_file.string);
						hud_count = index;
						return;
					}

					if(cmdi == DEFAULT)
						default_info.offset[i] = atof(token);
					else
						hud[index].offset[i] = atof(token);
				}
			}
			else if(!Q_stricmp(token, "draw"))
			{
				if(cmdi == DEFAULT)
					default_info.draw = qtrue;
				else
					hud[index].draw = qtrue;
			}
			else if(!Q_stricmp(token, "draw3d"))
			{
				if(cmdi == DEFAULT)
					default_info.draw3d = qtrue;
				else
					hud[index].draw3d = qtrue;
			}
		}

		if(cmdi != DEFAULT)
			index++;
	}

	hud_count = index;
}
//Superhud - End

//static void CG_Help_f(void) {
//	ParseHelp("config/help/english.cfg");
//}
void CG_forceBackwards_f () {
	cg.eventAdjustment = qtrue;
}
void CG_dbgScoreboard_f () {
	cg.dbgScoreboard?(cg.dbgScoreboard=qfalse):(cg.dbgScoreboard=qtrue);
}

static void CG_Say_f ( void ) {
	char	text[MAX_SAY_TEXT];
	char	cmd[32];

	Com_sprintf(text, sizeof(text), "%s", ConcatArgs(1));
	trap_Argv( 0, cmd, sizeof( cmd ) );
	trap_SendClientCommand( va("%s %s\n", cmd, text) );
}

typedef struct {
	char	*cmd;
	void	(*function)(void);
} consoleCommand_t;

static consoleCommand_t	commands[] = {
	{ "testgun", CG_TestGun_f },
	{ "testmodel", CG_TestModel_f },
	{ "nextframe", CG_TestModelNextFrame_f },
	{ "prevframe", CG_TestModelPrevFrame_f },
	{ "nextskin", CG_TestModelNextSkin_f },
	{ "prevskin", CG_TestModelPrevSkin_f },
	{ "viewpos", CG_Viewpos_f },
	{ "+scores", CG_ScoresDown_f },
	{ "-scores", CG_ScoresUp_f },
	{ "+zoom", CG_ZoomDown_f },
	{ "-zoom", CG_ZoomUp_f },
	{ "sizeup", CG_SizeUp_f },
	{ "sizedown", CG_SizeDown_f },
	{ "weapnext", CG_NextWeapon_f },
	{ "weapprev", CG_PrevWeapon_f },
	{ "weapon", CG_Weapon_f },
	{ "tell_target", CG_TellTarget_f },
	{ "tell_attacker", CG_TellAttacker_f },
	{ "vtell_target", CG_VoiceTellTarget_f },
	{ "vtell_attacker", CG_VoiceTellAttacker_f },
	{ "tcmd", CG_TargetCommand_f },
	{ "ready", CG_Ready_f },//Zero: Ready up.
	{ "notready", CG_Notready_f },//Zero: "I'm not ready anymore..." Must be a virgin.
#ifdef MISSIONPACK
	{ "loadhud", CG_LoadHud_f },
	{ "nextTeamMember", CG_NextTeamMember_f },
	{ "prevTeamMember", CG_PrevTeamMember_f },
	{ "nextOrder", CG_NextOrder_f },
	{ "confirmOrder", CG_ConfirmOrder_f },
	{ "denyOrder", CG_DenyOrder_f },
	{ "taskOffense", CG_TaskOffense_f },
	{ "taskDefense", CG_TaskDefense_f },
	{ "taskPatrol", CG_TaskPatrol_f },
	{ "taskCamp", CG_TaskCamp_f },
	{ "taskFollow", CG_TaskFollow_f },
	{ "taskRetrieve", CG_TaskRetrieve_f },
	{ "taskEscort", CG_TaskEscort_f },
	{ "taskSuicide", CG_TaskSuicide_f },
	{ "taskOwnFlag", CG_TaskOwnFlag_f },
	{ "tauntKillInsult", CG_TauntKillInsult_f },
	{ "tauntPraise", CG_TauntPraise_f },
	{ "tauntTaunt", CG_TauntTaunt_f },
	{ "tauntDeathInsult", CG_TauntDeathInsult_f },
	{ "tauntGauntlet", CG_TauntGauntlet_f },
	{ "spWin", CG_spWin_f },
	{ "spLose", CG_spLose_f },
	{ "scoresDown", CG_scrollScoresDown_f },
	{ "scoresUp", CG_scrollScoresUp_f },
#endif
	{ "startOrbit", CG_StartOrbit_f },
	//{ "camera", CG_Camera_f },
	{ "loaddeferred", CG_LoadDeferredPlayers },
	{ "tossflag", CG_TossFlag_f },
	{ "timeout", CG_TimeOut_f },
	{ "timein", CG_Timein_f },
	/*{ "unlockTeam", CG_unlockTeam_f },
	{ "lockTeam", CG_lockTeam_f },*/
	{ "cg_drawSpeedometer", CG_Speedometer_f },
	{ "cg_Speedometer", CG_Speedometer_f },
	{ "cg_drawUPS", CG_Speedometer_f },
	{ "speedometer", CG_Speedometer_f },
	{ "cg_OBDetector", CG_OBDetector_f },
	{ "cg_drawOBDetector", CG_OBDetector_f },
	{ "obdetector", CG_OBDetector_f },
	{ "cg_drawWeaponSideBar", CG_Weaponsidebar_f },
	{ "cg_WeaponSideBar", CG_Weaponsidebar_f },
	{ "weaponsidebar", CG_Weaponsidebar_f },
	{ "viewkeys", CG_KeyPress_f },
	{ "cg_viewkeypress", CG_KeyPress_f },
	{ "keypress", CG_KeyPress_f },
	{ "keypresses", CG_KeyPress_f },
	{ "viewkeypress", CG_KeyPress_f },
	{ "help", CG_HelpSystem_f },
	{ "alarm", CG_SetAlarm_f },
	//{ "dbgrws", CG_DbgRWS_f },
	//{ "dbgsto", CG_DbgRWS_f },
	//Superhud - Begin
	{ "reloadHUD", ParseHud },
	{ "resetMaxSpeed", CG_resetMaxSpeed_f },
	{ "forceBackwards", CG_forceBackwards_f },
	{ "dbgScoreboard", CG_dbgScoreboard_f }
	//Superhud - End

};


/*
=================
CG_ConsoleCommand

The string has been tokenized and can be retrieved with
Cmd_Argc() / Cmd_Argv()
=================
*/
qboolean CG_ConsoleCommand( void ) {
	const char	*cmd;
	int		i;

	cmd = CG_Argv(0);

	for ( i = 0 ; i < sizeof( commands ) / sizeof( commands[0] ) ; i++ ) {
		if ( !Q_stricmp( cmd, commands[i].cmd ) ) {
			commands[i].function();
			return qtrue;
		}
	}

	return qfalse;
}


/*
=================
CG_InitConsoleCommands

Let the client system know about all of our commands
so it can perform tab completion
=================
*/
void CG_InitConsoleCommands( void ) {
	int		i;

	for ( i = 0 ; i < sizeof( commands ) / sizeof( commands[0] ) ; i++ ) {
		trap_AddCommand( commands[i].cmd );
	}

	//
	// the game server will interpret these commands, which will be automatically
	// forwarded to the server after they are not recognized locally
	//
	trap_AddCommand ("kill");
	trap_AddCommand ("say");//This should be a client command to make sure everything get null terminated
	trap_AddCommand ("say_team");//This should be a client command to make sure everything get null terminated
	trap_AddCommand ("tell");
	trap_AddCommand ("vsay");
	trap_AddCommand ("vsay_team");
	trap_AddCommand ("vtell");
	trap_AddCommand ("vtaunt");
	trap_AddCommand ("vosay");
	trap_AddCommand ("vosay_team");
	trap_AddCommand ("votell");
	trap_AddCommand ("give");
	trap_AddCommand ("god");
	trap_AddCommand ("notarget");
	trap_AddCommand ("noclip");
	trap_AddCommand ("team");
	trap_AddCommand ("follow");
	trap_AddCommand ("levelshot");
	trap_AddCommand ("addbot");
	trap_AddCommand ("setviewpos");
	trap_AddCommand ("callvote");
	trap_AddCommand ("vote");
	trap_AddCommand ("callteamvote");
	trap_AddCommand ("teamvote");
	trap_AddCommand ("stats");
	trap_AddCommand ("teamtask");
	trap_AddCommand ("loaddefered");	// spelled wrong, but not changing for demo
	trap_AddCommand ("help");
	trap_AddCommand ("players");
	trap_AddCommand ("maplist");
	trap_AddCommand ("load");
	trap_AddCommand ("save");
	trap_AddCommand ("admin");
	trap_AddCommand ("adminPassword");
	trap_AddCommand ("mutestatus");
	trap_AddCommand ("quickmodes");
	trap_AddCommand ("teams");
	trap_AddCommand ("lock");//FIXME: Should be made 'smarter' so it isn't sent when in spec or when teams aren't lockable.
	trap_AddCommand ("unlock");//FIXME: Should be made 'smarter' so it isn't sent when in spec or when teams aren't lockable.
	//trap_AddCommand ("dbgflags");
	trap_AddCommand ("motd");
	trap_AddCommand("altConsoleSayMode");
}
