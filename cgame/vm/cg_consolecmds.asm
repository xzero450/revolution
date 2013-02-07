export CG_TargetCommand_f
code
proc CG_TargetCommand_f 20 12
file "../cg_consolecmds.c"
line 23
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_consolecmds.c -- text commands typed in at the local console, or
;4:// executed by a key binding
;5:
;6:#include "cg_local.h"
;7:#include "../ui/ui_shared.h"
;8:#ifdef MISSIONPACK
;9:extern menuDef_t *menuScoreboard;
;10:#endif
;11:
;12:
;13://typedef enum
;14://{
;15://	T_EOF,
;16://	T_SEMI,
;17://	T_BEGIN_BRACKET,
;18://	T_END_BRACKET,
;19://	T_STRING,
;20://	T_TOKEN
;21://} token_type;
;22:
;23:void CG_TargetCommand_f( void ) {
line 27
;24:	int		targetNum;
;25:	char	test[4];
;26:
;27:	targetNum = CG_CrosshairPlayer();
ADDRLP4 8
ADDRGP4 CG_CrosshairPlayer
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 28
;28:	if (!targetNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $86
line 29
;29:		return;
ADDRGP4 $85
JUMPV
LABELV $86
line 32
;30:	}
;31:
;32:	trap_Argv( 1, test, 4 );
CNSTI4 1
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 33
;33:	trap_SendConsoleCommand( va( "gc %i %i", targetNum, atoi( test ) ) );
ADDRLP4 4
ARGP4
ADDRLP4 12
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 $88
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 34
;34:}
LABELV $85
endproc CG_TargetCommand_f 20 12
proc CG_SizeUp_f 4 8
line 45
;35:
;36:
;37:
;38:/*
;39:=================
;40:CG_SizeUp_f
;41:
;42:Keybinding command
;43:=================
;44:*/
;45:static void CG_SizeUp_f (void) {
line 46
;46:	trap_Cvar_Set("cg_viewsize", va("%i",(int)(cg_viewsize.integer+10)));
ADDRGP4 $91
ARGP4
ADDRGP4 cg_viewsize+12
INDIRI4
CNSTI4 10
ADDI4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $90
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 47
;47:}
LABELV $89
endproc CG_SizeUp_f 4 8
proc CG_SizeDown_f 4 8
line 57
;48:
;49:
;50:/*
;51:=================
;52:CG_SizeDown_f
;53:
;54:Keybinding command
;55:=================
;56:*/
;57:static void CG_SizeDown_f (void) {
line 58
;58:	trap_Cvar_Set("cg_viewsize", va("%i",(int)(cg_viewsize.integer-10)));
ADDRGP4 $91
ARGP4
ADDRGP4 cg_viewsize+12
INDIRI4
CNSTI4 10
SUBI4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $90
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 59
;59:}
LABELV $93
endproc CG_SizeDown_f 4 8
proc CG_Viewpos_f 0 20
line 69
;60:
;61:
;62:/*
;63:=============
;64:CG_Viewpos_f
;65:
;66:Debugging command to print the current position
;67:=============
;68:*/
;69:static void CG_Viewpos_f (void) {
line 70
;70:	CG_Printf ("(%i %i %i) : %i\n", (int)cg.refdef.vieworg[0],
ADDRGP4 $96
ARGP4
ADDRGP4 cg+109048+24
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 cg+109048+24+4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 cg+109048+24+8
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 cg+109416+4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 73
;71:		(int)cg.refdef.vieworg[1], (int)cg.refdef.vieworg[2], 
;72:		(int)cg.refdefViewAngles[YAW]);
;73:}
LABELV $95
endproc CG_Viewpos_f 0 20
proc CG_ScoresDown_f 0 4
line 76
;74:
;75:
;76:static void CG_ScoresDown_f( void ) {
line 81
;77:
;78:#ifdef MISSIONPACK
;79:		CG_BuildSpectatorString();
;80:#endif
;81:	if ( cg.scoresRequestTime + 2000 < cg.time ) {
ADDRGP4 cg+110464
INDIRI4
CNSTI4 2000
ADDI4
ADDRGP4 cg+107604
INDIRI4
GEI4 $108
line 84
;82:		// the scores are more than two seconds out of data,
;83:		// so request new ones
;84:		cg.scoresRequestTime = cg.time;
ADDRGP4 cg+110464
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 85
;85:		trap_SendClientCommand( "score" );
ADDRGP4 $114
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 89
;86:
;87:		// leave the current scores up if they were already
;88:		// displayed, but if this is the first hit, clear them out
;89:		if ( !cg.showScores ) {
ADDRGP4 cg+120468
INDIRI4
CNSTI4 0
NEI4 $109
line 90
;90:			cg.showScores = qtrue;
ADDRGP4 cg+120468
CNSTI4 1
ASGNI4
line 91
;91:			cg.numScores = 0;
ADDRGP4 cg+110468
CNSTI4 0
ASGNI4
line 92
;92:		}
line 93
;93:	} else {
ADDRGP4 $109
JUMPV
LABELV $108
line 96
;94:		// show the cached contents even if they just pressed if it
;95:		// is within two seconds
;96:		cg.showScores = qtrue;
ADDRGP4 cg+120468
CNSTI4 1
ASGNI4
line 97
;97:	}
LABELV $109
line 98
;98:}
LABELV $107
endproc CG_ScoresDown_f 0 4
proc CG_ScoresUp_f 0 0
line 100
;99:
;100:static void CG_ScoresUp_f( void ) {
line 101
;101:	if ( cg.showScores ) {
ADDRGP4 cg+120468
INDIRI4
CNSTI4 0
EQI4 $122
line 102
;102:		cg.showScores = qfalse;
ADDRGP4 cg+120468
CNSTI4 0
ASGNI4
line 103
;103:		cg.scoreFadeTime = cg.time;
ADDRGP4 cg+120476
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 104
;104:	}
LABELV $122
line 105
;105:}
LABELV $121
endproc CG_ScoresUp_f 0 0
proc CG_TellTarget_f 264 20
line 172
;106:
;107:#ifdef MISSIONPACK
;108:extern menuDef_t *menuScoreboard;
;109:void Menu_Reset();			// FIXME: add to right include file
;110:
;111:static void CG_LoadHud_f( void) {
;112:  char buff[1024];
;113:	const char *hudSet;
;114:  memset(buff, 0, sizeof(buff));
;115:
;116:	String_Init();
;117:	Menu_Reset();
;118:	
;119:	trap_Cvar_VariableStringBuffer("cg_hudFiles", buff, sizeof(buff));
;120:	hudSet = buff;
;121:	if (hudSet[0] == '\0') {
;122:		hudSet = "ui/hud.txt";
;123:	}
;124:
;125:	CG_LoadMenus(hudSet);
;126:  menuScoreboard = NULL;
;127:}
;128:
;129:
;130:static void CG_scrollScoresDown_f( void) {
;131:	if (menuScoreboard && cg.scoreBoardShowing) {
;132:		Menu_ScrollFeeder(menuScoreboard, FEEDER_SCOREBOARD, qtrue);
;133:		Menu_ScrollFeeder(menuScoreboard, FEEDER_REDTEAM_LIST, qtrue);
;134:		Menu_ScrollFeeder(menuScoreboard, FEEDER_BLUETEAM_LIST, qtrue);
;135:	}
;136:}
;137:
;138:
;139:static void CG_scrollScoresUp_f( void) {
;140:	if (menuScoreboard && cg.scoreBoardShowing) {
;141:		Menu_ScrollFeeder(menuScoreboard, FEEDER_SCOREBOARD, qfalse);
;142:		Menu_ScrollFeeder(menuScoreboard, FEEDER_REDTEAM_LIST, qfalse);
;143:		Menu_ScrollFeeder(menuScoreboard, FEEDER_BLUETEAM_LIST, qfalse);
;144:	}
;145:}
;146:
;147:
;148:static void CG_spWin_f( void) {
;149:	trap_Cvar_Set("cg_cameraOrbit", "2");
;150:	trap_Cvar_Set("cg_cameraOrbitDelay", "35");
;151:	trap_Cvar_Set("cg_thirdPerson", "1");
;152:	trap_Cvar_Set("cg_thirdPersonAngle", "0");
;153:	trap_Cvar_Set("cg_thirdPersonRange", "100");
;154:	CG_AddBufferedSound(cgs.media.winnerSound);
;155:	//trap_S_StartLocalSound(cgs.media.winnerSound, CHAN_ANNOUNCER);
;156:	CG_CenterPrint("YOU WIN!", SCREEN_HEIGHT * .30, 0);
;157:}
;158:
;159:static void CG_spLose_f( void) {
;160:	trap_Cvar_Set("cg_cameraOrbit", "2");
;161:	trap_Cvar_Set("cg_cameraOrbitDelay", "35");
;162:	trap_Cvar_Set("cg_thirdPerson", "1");
;163:	trap_Cvar_Set("cg_thirdPersonAngle", "0");
;164:	trap_Cvar_Set("cg_thirdPersonRange", "100");
;165:	CG_AddBufferedSound(cgs.media.loserSound);
;166:	//trap_S_StartLocalSound(cgs.media.loserSound, CHAN_ANNOUNCER);
;167:	CG_CenterPrint("YOU LOSE...", SCREEN_HEIGHT * .30, 0);
;168:}
;169:
;170:#endif
;171:
;172:static void CG_TellTarget_f( void ) {
line 177
;173:	int		clientNum;
;174:	char	command[128];
;175:	char	message[128];
;176:
;177:	clientNum = CG_CrosshairPlayer();
ADDRLP4 260
ADDRGP4 CG_CrosshairPlayer
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 260
INDIRI4
ASGNI4
line 178
;178:	if ( clientNum == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $129
line 179
;179:		return;
ADDRGP4 $128
JUMPV
LABELV $129
line 182
;180:	}
;181:
;182:	trap_Args( message, 128 );
ADDRLP4 132
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Args
CALLV
pop
line 183
;183:	Com_sprintf( command, 128, "tell %i %s", clientNum, message );
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $131
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 132
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 184
;184:	trap_SendClientCommand( command );
ADDRLP4 4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 185
;185:}
LABELV $128
endproc CG_TellTarget_f 264 20
proc CG_TellAttacker_f 264 20
line 187
;186:
;187:static void CG_TellAttacker_f( void ) {
line 192
;188:	int		clientNum;
;189:	char	command[128];
;190:	char	message[128];
;191:
;192:	clientNum = CG_LastAttacker();
ADDRLP4 260
ADDRGP4 CG_LastAttacker
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 260
INDIRI4
ASGNI4
line 193
;193:	if ( clientNum == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $133
line 194
;194:		return;
ADDRGP4 $132
JUMPV
LABELV $133
line 197
;195:	}
;196:
;197:	trap_Args( message, 128 );
ADDRLP4 132
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Args
CALLV
pop
line 198
;198:	Com_sprintf( command, 128, "tell %i %s", clientNum, message );
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $131
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 132
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 199
;199:	trap_SendClientCommand( command );
ADDRLP4 4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 200
;200:}
LABELV $132
endproc CG_TellAttacker_f 264 20
proc CG_VoiceTellTarget_f 264 20
line 202
;201:
;202:static void CG_VoiceTellTarget_f( void ) {
line 207
;203:	int		clientNum;
;204:	char	command[128];
;205:	char	message[128];
;206:
;207:	clientNum = CG_CrosshairPlayer();
ADDRLP4 260
ADDRGP4 CG_CrosshairPlayer
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 260
INDIRI4
ASGNI4
line 208
;208:	if ( clientNum == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $136
line 209
;209:		return;
ADDRGP4 $135
JUMPV
LABELV $136
line 212
;210:	}
;211:
;212:	trap_Args( message, 128 );
ADDRLP4 132
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Args
CALLV
pop
line 213
;213:	Com_sprintf( command, 128, "vtell %i %s", clientNum, message );
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $138
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 132
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 214
;214:	trap_SendClientCommand( command );
ADDRLP4 4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 215
;215:}
LABELV $135
endproc CG_VoiceTellTarget_f 264 20
proc CG_VoiceTellAttacker_f 264 20
line 217
;216:
;217:static void CG_VoiceTellAttacker_f( void ) {
line 222
;218:	int		clientNum;
;219:	char	command[128];
;220:	char	message[128];
;221:
;222:	clientNum = CG_LastAttacker();
ADDRLP4 260
ADDRGP4 CG_LastAttacker
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 260
INDIRI4
ASGNI4
line 223
;223:	if ( clientNum == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $140
line 224
;224:		return;
ADDRGP4 $139
JUMPV
LABELV $140
line 227
;225:	}
;226:
;227:	trap_Args( message, 128 );
ADDRLP4 132
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Args
CALLV
pop
line 228
;228:	Com_sprintf( command, 128, "vtell %i %s", clientNum, message );
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $138
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 132
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 229
;229:	trap_SendClientCommand( command );
ADDRLP4 4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 230
;230:}
LABELV $139
endproc CG_VoiceTellAttacker_f 264 20
proc CG_Ready_f 0 4
line 232
;231:
;232:static void CG_Ready_f( void ) {
line 233
;233:	if ( g_allowReady.integer == 1 && cgs.clientinfo[cg.clientNum].team != TEAM_SPECTATOR && cg.time > cg.readyInterval && cg.warmup > 0 ) {
ADDRGP4 g_allowReady+12
INDIRI4
CNSTI4 1
NEI4 $143
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 3
EQI4 $143
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+162072
INDIRI4
LEI4 $143
ADDRGP4 cg+130804
INDIRI4
CNSTI4 0
LEI4 $143
line 234
;234:			cg.readyInterval = cg.time + READY_INTERVAL;
ADDRGP4 cg+162072
ADDRGP4 cg+107604
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 236
;235:
;236:			trap_SendClientCommand( "ready" );
ADDRGP4 $154
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 237
;237:		}
LABELV $143
line 238
;238:}
LABELV $142
endproc CG_Ready_f 0 4
proc CG_Notready_f 5 4
line 240
;239:
;240:static void CG_Notready_f( void ) {
line 242
;241:	//CG_Printf("Not ready\n");
;242:	if ( g_allowReady.integer == 1 && cg.totalOccurance <= 2 && cg.time > cg.notreadyInterval && cgs.clientinfo[cg.clientNum].team != TEAM_SPECTATOR && cg.warmup > 0 ) {
ADDRGP4 g_allowReady+12
INDIRI4
CNSTI4 1
NEI4 $156
ADDRGP4 cg+162080
INDIRU1
CVUI4 1
CNSTI4 2
GTI4 $156
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+162076
INDIRI4
LEI4 $156
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 3
EQI4 $156
ADDRGP4 cg+130804
INDIRI4
CNSTI4 0
LEI4 $156
line 244
;243:		//CG_Printf("Sending command");
;244:		cg.totalOccurance = ++cg.totalOccurance;
ADDRLP4 0
ADDRGP4 cg+162080
ASGNP4
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRU1
CVUI4 1
CNSTI4 1
ADDI4
CVIU4 4
CVUU1 4
ASGNU1
ADDRLP4 0
INDIRP4
ADDRLP4 4
INDIRU1
ASGNU1
ADDRGP4 cg+162080
ADDRLP4 4
INDIRU1
ASGNU1
line 245
;245:			cg.notreadyInterval = cg.time + NOTREADY_INTERVAL;
ADDRGP4 cg+162076
ADDRGP4 cg+107604
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 247
;246:
;247:			trap_SendClientCommand( "notready" );
ADDRGP4 $170
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 248
;248:	}
LABELV $156
line 249
;249:}
LABELV $155
endproc CG_Notready_f 5 4
proc CG_StartOrbit_f 1028 12
line 424
;250:
;251:#ifdef MISSIONPACK
;252:static void CG_NextTeamMember_f( void ) {
;253:  CG_SelectNextPlayer();
;254:}
;255:
;256:static void CG_PrevTeamMember_f( void ) {
;257:  CG_SelectPrevPlayer();
;258:}
;259:
;260:// ASS U ME's enumeration order as far as task specific orders, OFFENSE is zero, CAMP is last
;261://
;262:static void CG_NextOrder_f( void ) {
;263:	clientInfo_t *ci = cgs.clientinfo + cg.snap->ps.clientNum;
;264:	if (ci) {
;265:		if (!ci->teamLeader && sortedTeamPlayers[cg_currentSelectedPlayer.integer] != cg.snap->ps.clientNum) {
;266:			return;
;267:		}
;268:	}
;269:	if (cgs.currentOrder < TEAMTASK_CAMP) {
;270:		cgs.currentOrder++;
;271:
;272:		if (cgs.currentOrder == TEAMTASK_RETRIEVE) {
;273:			if (!CG_OtherTeamHasFlag()) {
;274:				cgs.currentOrder++;
;275:			}
;276:		}
;277:
;278:		if (cgs.currentOrder == TEAMTASK_ESCORT) {
;279:			if (!CG_YourTeamHasFlag()) {
;280:				cgs.currentOrder++;
;281:			}
;282:		}
;283:
;284:	} else {
;285:		cgs.currentOrder = TEAMTASK_OFFENSE;
;286:	}
;287:	cgs.orderPending = qtrue;
;288:	cgs.orderTime = cg.time + 3000;
;289:}
;290:
;291:
;292:static void CG_ConfirmOrder_f (void ) {
;293:	trap_SendConsoleCommand(va("cmd vtell %d %s\n", cgs.acceptLeader, VOICECHAT_YES));
;294:	trap_SendConsoleCommand("+button5; wait; -button5");
;295:	if (cg.time < cgs.acceptOrderTime) {
;296:		trap_SendClientCommand(va("teamtask %d\n", cgs.acceptTask));
;297:		cgs.acceptOrderTime = 0;
;298:	}
;299:}
;300:
;301:static void CG_DenyOrder_f (void ) {
;302:	trap_SendConsoleCommand(va("cmd vtell %d %s\n", cgs.acceptLeader, VOICECHAT_NO));
;303:	trap_SendConsoleCommand("+button6; wait; -button6");
;304:	if (cg.time < cgs.acceptOrderTime) {
;305:		cgs.acceptOrderTime = 0;
;306:	}
;307:}
;308:
;309:static void CG_TaskOffense_f (void ) {
;310:	if (cgs.gametype == GT_CTF || cgs.gametype == GT_1FCTF) {
;311:		trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONGETFLAG));
;312:	} else {
;313:		trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONOFFENSE));
;314:	}
;315:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_OFFENSE));
;316:}
;317:
;318:static void CG_TaskDefense_f (void ) {
;319:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONDEFENSE));
;320:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_DEFENSE));
;321:}
;322:
;323:static void CG_TaskPatrol_f (void ) {
;324:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONPATROL));
;325:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_PATROL));
;326:}
;327:
;328:static void CG_TaskCamp_f (void ) {
;329:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONCAMPING));
;330:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_CAMP));
;331:}
;332:
;333:static void CG_TaskFollow_f (void ) {
;334:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONFOLLOW));
;335:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_FOLLOW));
;336:}
;337:
;338:static void CG_TaskRetrieve_f (void ) {
;339:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONRETURNFLAG));
;340:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_RETRIEVE));
;341:}
;342:
;343:static void CG_TaskEscort_f (void ) {
;344:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_ONFOLLOWCARRIER));
;345:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_ESCORT));
;346:}
;347:
;348:static void CG_TaskOwnFlag_f (void ) {
;349:	trap_SendConsoleCommand(va("cmd vsay_team %s\n", VOICECHAT_IHAVEFLAG));
;350:}
;351:
;352:static void CG_TauntKillInsult_f (void ) {
;353:	trap_SendConsoleCommand("cmd vsay kill_insult\n");
;354:}
;355:
;356:static void CG_TauntPraise_f (void ) {
;357:	trap_SendConsoleCommand("cmd vsay praise\n");
;358:}
;359:
;360:static void CG_TauntTaunt_f (void ) {
;361:	trap_SendConsoleCommand("cmd vtaunt\n");
;362:}
;363:
;364:static void CG_TauntDeathInsult_f (void ) {
;365:	trap_SendConsoleCommand("cmd vsay death_insult\n");
;366:}
;367:
;368:static void CG_TauntGauntlet_f (void ) {
;369:	trap_SendConsoleCommand("cmd vsay kill_guantlet\n");
;370:}
;371:
;372:static void CG_TaskSuicide_f (void ) {
;373:	int		clientNum;
;374:	char	command[128];
;375:
;376:	clientNum = CG_CrosshairPlayer();
;377:	if ( clientNum == -1 ) {
;378:		return;
;379:	}
;380:
;381:	Com_sprintf( command, 128, "tell %i suicide", clientNum );
;382:	trap_SendClientCommand( command );
;383:}
;384:
;385:
;386:
;387:/*
;388:==================
;389:CG_TeamMenu_f
;390:==================
;391:*/
;392:/*
;393:static void CG_TeamMenu_f( void ) {
;394:  if (trap_Key_GetCatcher() & KEYCATCH_CGAME) {
;395:    CG_EventHandling(CGAME_EVENT_NONE);
;396:    trap_Key_SetCatcher(0);
;397:  } else {
;398:    CG_EventHandling(CGAME_EVENT_TEAMMENU);
;399:    //trap_Key_SetCatcher(KEYCATCH_CGAME);
;400:  }
;401:}
;402:*/
;403:
;404:/*
;405:==================
;406:CG_EditHud_f
;407:==================
;408:*/
;409:/*
;410:static void CG_EditHud_f( void ) {
;411:  //cls.keyCatchers ^= KEYCATCH_CGAME;
;412:  //VM_Call (cgvm, CG_EVENT_HANDLING, (cls.keyCatchers & KEYCATCH_CGAME) ? CGAME_EVENT_EDITHUD : CGAME_EVENT_NONE);
;413:}
;414:*/
;415:
;416:#endif
;417:
;418:/*
;419:==================
;420:CG_StartOrbit_f
;421:==================
;422:*/
;423:
;424:static void CG_StartOrbit_f( void ) {
line 427
;425:	char var[MAX_TOKEN_CHARS];
;426:
;427:	trap_Cvar_VariableStringBuffer( "developer", var, sizeof( var ) );
ADDRGP4 $172
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 428
;428:	if ( !atoi(var) ) {
ADDRLP4 0
ARGP4
ADDRLP4 1024
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 0
NEI4 $173
line 429
;429:		return;
ADDRGP4 $171
JUMPV
LABELV $173
line 431
;430:	}
;431:	if (cg_cameraOrbit.value != 0) {
ADDRGP4 cg_cameraOrbit+8
INDIRF4
CNSTF4 0
EQF4 $175
line 432
;432:		trap_Cvar_Set ("cg_cameraOrbit", "0");
ADDRGP4 $178
ARGP4
ADDRGP4 $179
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 433
;433:		trap_Cvar_Set("cg_thirdPerson", "0");
ADDRGP4 $180
ARGP4
ADDRGP4 $179
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 434
;434:	} else {
ADDRGP4 $176
JUMPV
LABELV $175
line 435
;435:		trap_Cvar_Set("cg_cameraOrbit", "5");
ADDRGP4 $178
ARGP4
ADDRGP4 $181
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 436
;436:		trap_Cvar_Set("cg_thirdPerson", "1");
ADDRGP4 $180
ARGP4
ADDRGP4 $182
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 437
;437:		trap_Cvar_Set("cg_thirdPersonAngle", "0");
ADDRGP4 $183
ARGP4
ADDRGP4 $179
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 438
;438:		trap_Cvar_Set("cg_thirdPersonRange", "100");
ADDRGP4 $184
ARGP4
ADDRGP4 $185
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 439
;439:	}
LABELV $176
line 440
;440:}
LABELV $171
endproc CG_StartOrbit_f 1028 12
proc CG_TossFlag_f 0 4
line 455
;441:
;442:/*
;443:static void CG_Camera_f( void ) {
;444:	char name[1024];
;445:	trap_Argv( 1, name, sizeof(name));
;446:	if (trap_loadCamera(name)) {
;447:		cg.cameraMode = qtrue;
;448:		trap_startCamera(cg.time);
;449:	} else {
;450:		CG_Printf ("Unable to load camera %s\n",name);
;451:	}
;452:}
;453:*/
;454:
;455:static void CG_TossFlag_f ( void ) {
line 460
;456://	char	command[128];
;457://	char	message[128];
;458://	playerState_t *ps;
;459:
;460:	if ( cgs.gametype != GT_CTF ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
EQI4 $187
line 461
;461:		return;
ADDRGP4 $186
JUMPV
LABELV $187
line 469
;462:	}
;463:	//if ( !cg.predictedPlayerState.powerups[PW_BLUEFLAG]
;464:	//|| !cg.predictedPlayerState.powerups[PW_REDFLAG] ) {
;465:	//	cg.
;466:	//	return; //not carrying a flag
;467:	//}
;468:
;469:	if ( cg.time > cg.naftInterval ) {
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+162048
INDIRI4
LEI4 $190
line 470
;470:		cg.naftInterval = cg.time + 700;
ADDRGP4 cg+162048
ADDRGP4 cg+107604
INDIRI4
CNSTI4 700
ADDI4
ASGNI4
line 471
;471:		cg.lastHeldFlag = cg.itemPickupFlag;
ADDRGP4 cg+162052
ADDRGP4 cg+130824
INDIRI4
ASGNI4
line 472
;472:		trap_SendClientCommand( "tossflag"  );
ADDRGP4 $198
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 473
;473:	}
LABELV $190
line 474
;474:}
LABELV $186
endproc CG_TossFlag_f 0 4
proc CG_TimeOut_f 132 8
line 476
;475:
;476:static void CG_TimeOut_f ( void ) {
line 479
;477:	char	message[128];
;478:
;479:	trap_Args( message, 128 );
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Args
CALLV
pop
line 480
;480:	trap_SendClientCommand( va("callvote timeout %s", message) );
ADDRGP4 $200
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 128
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 482
;481:	//trap_SendClientCommand("callvote timeout");
;482:}
LABELV $199
endproc CG_TimeOut_f 132 8
proc CG_Timein_f 132 8
line 484
;483:
;484:static void CG_Timein_f ( void ) {
line 487
;485:	char	message[128];
;486:
;487:	trap_Args( message, 128 );
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Args
CALLV
pop
line 488
;488:	trap_SendClientCommand( va("callvote timein %s", message) );
ADDRGP4 $202
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 128
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 489
;489:}
LABELV $201
endproc CG_Timein_f 132 8
proc CG_Speedometer_f 332 32
line 501
;490:
;491://static void CG_unlockTeam_f ( void ) {
;492://	trap_SendClientCommand("callteamvote unlockTeam");
;493://	//trap_SendClientCommand("callvote timeout");
;494://}
;495://
;496://static void CG_lockTeam_f ( void ) {
;497://	trap_SendClientCommand("callteamvote lockTeam");
;498://}
;499:
;500:
;501:static void CG_Speedometer_f ( void ) {
line 506
;502:	int ac;//, i;
;503:	char st[MAX_CVAR_VALUE_STRING], *tmp;
;504:	char ds[12], dm[12], x[12], y[12], a[12];
;505:
;506:	ac = trap_Argc();
ADDRLP4 324
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 324
INDIRI4
ASGNI4
line 507
;507:	tmp = ch_Speedometer.string;
ADDRLP4 0
ADDRGP4 ch_Speedometer+16
ASGNP4
line 508
;508:	CG_ExtractToken(&tmp, ds);
ADDRLP4 0
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 509
;509:	CG_ExtractToken(&tmp, dm);
ADDRLP4 0
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 510
;510:	CG_ExtractToken(&tmp, x);
ADDRLP4 0
ARGP4
ADDRLP4 32
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 511
;511:	CG_ExtractToken(&tmp, y);
ADDRLP4 0
ARGP4
ADDRLP4 44
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 512
;512:	CG_ExtractToken(&tmp, a);
ADDRLP4 0
ARGP4
ADDRLP4 56
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 514
;513:
;514:	switch(ac)
ADDRLP4 328
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 328
INDIRI4
CNSTI4 1
LTI4 $205
ADDRLP4 328
INDIRI4
CNSTI4 6
GTI4 $205
ADDRLP4 328
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $215-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $215
address $207
address $209
address $211
address $212
address $213
address $214
code
line 515
;515:	{
LABELV $207
line 517
;516:		case 1:
;517:			trap_SendConsoleCommand("ch_Speedometer");
ADDRGP4 $208
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 518
;518:			return;
ADDRGP4 $203
JUMPV
LABELV $209
line 521
;519:
;520:		case 2:
;521:			trap_Argv(1, ds, 12);
CNSTI4 1
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 522
;522:			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s %s", ds, dm, x, y, a);
ADDRLP4 68
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $210
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 44
ARGP4
ADDRLP4 56
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 523
;523:			break;
ADDRGP4 $206
JUMPV
LABELV $211
line 526
;524:
;525:		case 3:
;526:			trap_Argv(1, ds, 12);
CNSTI4 1
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 527
;527:			trap_Argv(2, dm, 12);
CNSTI4 2
ARGI4
ADDRLP4 20
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 528
;528:			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s %s", ds, dm, x, y, a);
ADDRLP4 68
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $210
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 44
ARGP4
ADDRLP4 56
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 529
;529:			break;
ADDRGP4 $206
JUMPV
LABELV $212
line 532
;530:
;531:		case 4:
;532:			trap_Argv(1, ds, 12);
CNSTI4 1
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 533
;533:			trap_Argv(2, dm, 12);
CNSTI4 2
ARGI4
ADDRLP4 20
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 534
;534:			trap_Argv(3, x, 12);
CNSTI4 3
ARGI4
ADDRLP4 32
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 535
;535:			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s %s", ds, dm, x, y, a);
ADDRLP4 68
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $210
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 44
ARGP4
ADDRLP4 56
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 536
;536:			break;
ADDRGP4 $206
JUMPV
LABELV $213
line 539
;537:
;538:		case 5:
;539:			trap_Argv(1, ds, 12);
CNSTI4 1
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 540
;540:			trap_Argv(2, dm, 12);
CNSTI4 2
ARGI4
ADDRLP4 20
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 541
;541:			trap_Argv(3, x, 12);
CNSTI4 3
ARGI4
ADDRLP4 32
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 542
;542:			trap_Argv(4, y, 12);
CNSTI4 4
ARGI4
ADDRLP4 44
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 543
;543:			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s %s", ds, dm, x, y, a);
ADDRLP4 68
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $210
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 44
ARGP4
ADDRLP4 56
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 544
;544:			break;
ADDRGP4 $206
JUMPV
LABELV $214
line 547
;545:
;546:		case 6:
;547:			trap_Argv(1, ds, 12);
CNSTI4 1
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 548
;548:			trap_Argv(2, dm, 12);
CNSTI4 2
ARGI4
ADDRLP4 20
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 549
;549:			trap_Argv(3, x, 12);
CNSTI4 3
ARGI4
ADDRLP4 32
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 550
;550:			trap_Argv(4, y, 12);
CNSTI4 4
ARGI4
ADDRLP4 44
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 551
;551:			trap_Argv(5, a, 12);
CNSTI4 5
ARGI4
ADDRLP4 56
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 552
;552:			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s %s", ds, dm, x, y, a);
ADDRLP4 68
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $210
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 44
ARGP4
ADDRLP4 56
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 553
;553:			break;
LABELV $205
LABELV $206
line 556
;554:	}
;555:
;556:	trap_Cvar_Set("ch_Speedometer", st);
ADDRGP4 $208
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 569
;557:
;558:#if 0
;559:	/* This neat little hack allows users to skip
;560:	using quotes in the console */
;561:	if ( trap_Argc() < 6 ) {
;562:		//Hack.
;563:		trap_SendConsoleCommand("ch_Speedometer");
;564:		return;
;565:	}
;566:	trap_Cvar_Set( "ch_Speedometer", ConcatArgs(1) );
;567:	//trap_SendConsoleCommand("ch_Speedometer %s", ConcatArgs(1));
;568:#endif
;569:}
LABELV $203
endproc CG_Speedometer_f 332 32
proc CG_OBDetector_f 320 28
line 571
;570:
;571:static void CG_OBDetector_f ( void ) {
line 576
;572:	int ac;//, i;
;573:	char st[MAX_CVAR_VALUE_STRING], *tmp;
;574:	char d[12], x[12], y[12], a[12];
;575:
;576:	ac = trap_Argc();
ADDRLP4 312
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 312
INDIRI4
ASGNI4
line 577
;577:	tmp = ch_OBDetector.string;
ADDRLP4 0
ADDRGP4 ch_OBDetector+16
ASGNP4
line 578
;578:	CG_ExtractToken(&tmp, d);
ADDRLP4 0
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 579
;579:	CG_ExtractToken(&tmp, x);
ADDRLP4 0
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 580
;580:	CG_ExtractToken(&tmp, y);
ADDRLP4 0
ARGP4
ADDRLP4 32
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 581
;581:	CG_ExtractToken(&tmp, a);
ADDRLP4 0
ARGP4
ADDRLP4 44
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 583
;582:
;583:	switch(ac)
ADDRLP4 316
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 316
INDIRI4
CNSTI4 1
LTI4 $219
ADDRLP4 316
INDIRI4
CNSTI4 5
GTI4 $219
ADDRLP4 316
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $228-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $228
address $221
address $223
address $225
address $226
address $227
code
line 584
;584:	{
LABELV $221
line 586
;585:		case 1:
;586:			trap_SendConsoleCommand("ch_OBDetector");
ADDRGP4 $222
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 587
;587:			return;
ADDRGP4 $217
JUMPV
LABELV $223
line 590
;588:
;589:		case 2:
;590:			trap_Argv(1, d, 12);
CNSTI4 1
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 591
;591:			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s", d, x, y, a);
ADDRLP4 56
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $224
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 44
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 592
;592:			break;
ADDRGP4 $220
JUMPV
LABELV $225
line 595
;593:
;594:		case 3:
;595:			trap_Argv(1, d, 12);
CNSTI4 1
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 596
;596:			trap_Argv(2, x, 12);
CNSTI4 2
ARGI4
ADDRLP4 20
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 597
;597:			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s", d, x, y, a);
ADDRLP4 56
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $224
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 44
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 598
;598:			break;
ADDRGP4 $220
JUMPV
LABELV $226
line 601
;599:
;600:		case 4:
;601:			trap_Argv(1, d, 12);
CNSTI4 1
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 602
;602:			trap_Argv(2, x, 12);
CNSTI4 2
ARGI4
ADDRLP4 20
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 603
;603:			trap_Argv(3, y, 12);
CNSTI4 3
ARGI4
ADDRLP4 32
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 604
;604:			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s", d, x, y, a);
ADDRLP4 56
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $224
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 44
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 605
;605:			break;
ADDRGP4 $220
JUMPV
LABELV $227
line 608
;606:
;607:		case 5:
;608:			trap_Argv(1, d, 12);
CNSTI4 1
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 609
;609:			trap_Argv(2, x, 12);
CNSTI4 2
ARGI4
ADDRLP4 20
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 610
;610:			trap_Argv(3, y, 12);
CNSTI4 3
ARGI4
ADDRLP4 32
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 611
;611:			trap_Argv(4, a, 12);
CNSTI4 4
ARGI4
ADDRLP4 44
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 612
;612:			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s", d, x, y, a);
ADDRLP4 56
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $224
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 44
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 613
;613:			break;
LABELV $219
LABELV $220
line 616
;614:	}
;615:
;616:	trap_Cvar_Set("ch_OBDetector", st);
ADDRGP4 $222
ARGP4
ADDRLP4 56
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 617
;617:}
LABELV $217
endproc CG_OBDetector_f 320 28
proc CG_Weaponsidebar_f 332 32
line 619
;618:
;619:static void CG_Weaponsidebar_f ( void ) {
line 624
;620:	int ac;//, i;
;621:	char st[MAX_CVAR_VALUE_STRING], *tmp;
;622:	char ds[12], bc[12], fc[12], sc[12], sf[12];
;623:
;624:	ac = trap_Argc();
ADDRLP4 324
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 324
INDIRI4
ASGNI4
line 625
;625:	tmp = ch_weaponSideBar.string;
ADDRLP4 0
ADDRGP4 ch_weaponSideBar+16
ASGNP4
line 626
;626:	CG_ExtractToken(&tmp, ds);
ADDRLP4 0
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 627
;627:	CG_ExtractToken(&tmp, bc);
ADDRLP4 0
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 628
;628:	CG_ExtractToken(&tmp, fc);
ADDRLP4 0
ARGP4
ADDRLP4 32
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 629
;629:	CG_ExtractToken(&tmp, sc);
ADDRLP4 0
ARGP4
ADDRLP4 44
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 630
;630:	CG_ExtractToken(&tmp, sf);
ADDRLP4 0
ARGP4
ADDRLP4 56
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 632
;631:
;632:	switch(ac)
ADDRLP4 328
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 328
INDIRI4
CNSTI4 1
LTI4 $232
ADDRLP4 328
INDIRI4
CNSTI4 6
GTI4 $232
ADDRLP4 328
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $241-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $241
address $234
address $236
address $237
address $238
address $239
address $240
code
line 633
;633:	{
LABELV $234
line 635
;634:		case 1:
;635:			trap_SendConsoleCommand("ch_weaponSideBar");
ADDRGP4 $235
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 636
;636:			return;
ADDRGP4 $230
JUMPV
LABELV $236
line 639
;637:
;638:		case 2:
;639:			trap_Argv(1, ds, 12);
CNSTI4 1
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 640
;640:			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s %s", ds, bc, fc, sc, sf);
ADDRLP4 68
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $210
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 44
ARGP4
ADDRLP4 56
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 641
;641:			break;
ADDRGP4 $233
JUMPV
LABELV $237
line 644
;642:
;643:		case 3:
;644:			trap_Argv(1, ds, 12);
CNSTI4 1
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 645
;645:			trap_Argv(2, bc, 12);
CNSTI4 2
ARGI4
ADDRLP4 20
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 646
;646:			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s %s", ds, bc, fc, sc, sf);
ADDRLP4 68
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $210
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 44
ARGP4
ADDRLP4 56
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 647
;647:			break;
ADDRGP4 $233
JUMPV
LABELV $238
line 650
;648:
;649:		case 4:
;650:			trap_Argv(1, ds, 12);
CNSTI4 1
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 651
;651:			trap_Argv(2, bc, 12);
CNSTI4 2
ARGI4
ADDRLP4 20
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 652
;652:			trap_Argv(3, fc, 12);
CNSTI4 3
ARGI4
ADDRLP4 32
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 653
;653:			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s %s", ds, bc, fc, sc, sf);
ADDRLP4 68
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $210
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 44
ARGP4
ADDRLP4 56
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 654
;654:			break;
ADDRGP4 $233
JUMPV
LABELV $239
line 657
;655:
;656:		case 5:
;657:			trap_Argv(1, ds, 12);
CNSTI4 1
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 658
;658:			trap_Argv(2, bc, 12);
CNSTI4 2
ARGI4
ADDRLP4 20
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 659
;659:			trap_Argv(3, fc, 12);
CNSTI4 3
ARGI4
ADDRLP4 32
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 660
;660:			trap_Argv(4, sc, 12);
CNSTI4 4
ARGI4
ADDRLP4 44
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 661
;661:			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s %s", ds, bc, fc, sc, sf);
ADDRLP4 68
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $210
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 44
ARGP4
ADDRLP4 56
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 662
;662:			break;
ADDRGP4 $233
JUMPV
LABELV $240
line 665
;663:
;664:		case 6:
;665:			trap_Argv(1, ds, 12);
CNSTI4 1
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 666
;666:			trap_Argv(2, bc, 12);
CNSTI4 2
ARGI4
ADDRLP4 20
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 667
;667:			trap_Argv(3, fc, 12);
CNSTI4 3
ARGI4
ADDRLP4 32
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 668
;668:			trap_Argv(4, sc, 12);
CNSTI4 4
ARGI4
ADDRLP4 44
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 669
;669:			trap_Argv(5, sf, 12);
CNSTI4 5
ARGI4
ADDRLP4 56
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 670
;670:			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s %s", ds, bc, fc, sc, sf);
ADDRLP4 68
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $210
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 44
ARGP4
ADDRLP4 56
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 671
;671:			break;
LABELV $232
LABELV $233
line 674
;672:	}
;673:
;674:	trap_Cvar_Set("ch_weaponSideBar", st);
ADDRGP4 $235
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 686
;675:
;676:#if 0
;677:	/* This neat little hack allows users to skip
;678:	using quotes in the console */
;679:	if ( trap_Argc() < 6 ) {
;680:		//Hack.
;681:		trap_SendConsoleCommand("ch_weaponSideBar");
;682:		return;
;683:	}
;684:	trap_Cvar_Set( "ch_weaponSideBar", ConcatArgs(1) );
;685:#endif
;686:}
LABELV $230
endproc CG_Weaponsidebar_f 332 32
proc CG_KeyPress_f 344 36
line 688
;687:
;688:static void CG_KeyPress_f ( void ) {
line 693
;689:	int ac;//, i;
;690:	char st[MAX_CVAR_VALUE_STRING], *tmp;
;691:	char dk[12], x[12], y[12], kc[12], fc[12], s[12];
;692:
;693:	ac = trap_Argc();
ADDRLP4 336
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 336
INDIRI4
ASGNI4
line 694
;694:	tmp = ch_viewKeyPress.string;
ADDRLP4 0
ADDRGP4 ch_viewKeyPress+16
ASGNP4
line 695
;695:	CG_ExtractToken(&tmp, dk);
ADDRLP4 0
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 696
;696:	CG_ExtractToken(&tmp, x);
ADDRLP4 0
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 697
;697:	CG_ExtractToken(&tmp, y);
ADDRLP4 0
ARGP4
ADDRLP4 32
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 698
;698:	CG_ExtractToken(&tmp, kc);
ADDRLP4 0
ARGP4
ADDRLP4 44
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 699
;699:	CG_ExtractToken(&tmp, fc);
ADDRLP4 0
ARGP4
ADDRLP4 56
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 700
;700:	CG_ExtractToken(&tmp, s);
ADDRLP4 0
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 702
;701:
;702:	switch(ac)
ADDRLP4 340
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 340
INDIRI4
CNSTI4 1
LTI4 $245
ADDRLP4 340
INDIRI4
CNSTI4 7
GTI4 $245
ADDRLP4 340
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $256-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $256
address $247
address $249
address $251
address $252
address $253
address $254
address $255
code
line 703
;703:	{
LABELV $247
line 705
;704:		case 1:
;705:			trap_SendConsoleCommand("ch_viewKeyPress");
ADDRGP4 $248
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 706
;706:			return;
ADDRGP4 $243
JUMPV
LABELV $249
line 709
;707:
;708:		case 2:
;709:			trap_Argv(1, dk, 12);
CNSTI4 1
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 710
;710:			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s %s %s", dk, x, y, kc, fc, s);
ADDRLP4 80
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $250
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 44
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 711
;711:			break;
ADDRGP4 $246
JUMPV
LABELV $251
line 714
;712:
;713:		case 3:
;714:			trap_Argv(1, dk, 12);
CNSTI4 1
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 715
;715:			trap_Argv(2, x, 12);
CNSTI4 2
ARGI4
ADDRLP4 20
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 716
;716:			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s %s %s", dk, x, y, kc, fc, s);
ADDRLP4 80
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $250
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 44
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 717
;717:			break;
ADDRGP4 $246
JUMPV
LABELV $252
line 720
;718:
;719:		case 4:
;720:			trap_Argv(1, dk, 12);
CNSTI4 1
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 721
;721:			trap_Argv(2, x, 12);
CNSTI4 2
ARGI4
ADDRLP4 20
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 722
;722:			trap_Argv(3, y, 12);
CNSTI4 3
ARGI4
ADDRLP4 32
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 723
;723:			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s %s %s", dk, x, y, kc, fc, s);
ADDRLP4 80
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $250
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 44
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 724
;724:			break;
ADDRGP4 $246
JUMPV
LABELV $253
line 727
;725:
;726:		case 5:
;727:			trap_Argv(1, dk, 12);
CNSTI4 1
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 728
;728:			trap_Argv(2, x, 12);
CNSTI4 2
ARGI4
ADDRLP4 20
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 729
;729:			trap_Argv(3, y, 12);
CNSTI4 3
ARGI4
ADDRLP4 32
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 730
;730:			trap_Argv(4, kc, 12);
CNSTI4 4
ARGI4
ADDRLP4 44
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 731
;731:			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s %s %s", dk, x, y, kc, fc, s);
ADDRLP4 80
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $250
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 44
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 732
;732:			break;
ADDRGP4 $246
JUMPV
LABELV $254
line 735
;733:
;734:		case 6:
;735:			trap_Argv(1, dk, 12);
CNSTI4 1
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 736
;736:			trap_Argv(2, x, 12);
CNSTI4 2
ARGI4
ADDRLP4 20
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 737
;737:			trap_Argv(3, y, 12);
CNSTI4 3
ARGI4
ADDRLP4 32
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 738
;738:			trap_Argv(4, kc, 12);
CNSTI4 4
ARGI4
ADDRLP4 44
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 739
;739:			trap_Argv(5, fc, 12);
CNSTI4 5
ARGI4
ADDRLP4 56
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 740
;740:			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s %s %s", dk, x, y, kc, fc, s);
ADDRLP4 80
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $250
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 44
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 741
;741:			break;
ADDRGP4 $246
JUMPV
LABELV $255
line 744
;742:
;743:		case 7:
;744:			trap_Argv(1, dk, 12);
CNSTI4 1
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 745
;745:			trap_Argv(2, x, 12);
CNSTI4 2
ARGI4
ADDRLP4 20
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 746
;746:			trap_Argv(3, y, 12);
CNSTI4 3
ARGI4
ADDRLP4 32
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 747
;747:			trap_Argv(4, kc, 12);
CNSTI4 4
ARGI4
ADDRLP4 44
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 748
;748:			trap_Argv(5, fc, 12);
CNSTI4 5
ARGI4
ADDRLP4 56
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 749
;749:			trap_Argv(6, s, 12);
CNSTI4 6
ARGI4
ADDRLP4 68
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 750
;750:			Com_sprintf(st, MAX_CVAR_VALUE_STRING, "%s %s %s %s %s %s", dk, x, y, kc, fc, s);
ADDRLP4 80
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $250
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 44
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 751
;751:			break;
LABELV $245
LABELV $246
line 754
;752:	}
;753:
;754:	trap_Cvar_Set("ch_viewKeyPress", st);
ADDRGP4 $248
ARGP4
ADDRLP4 80
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 766
;755:
;756:#if 0
;757:	/* This neat little hack allows users to skip
;758:	using quotes in the console */
;759:	if ( trap_Argc() < 7 ) {
;760:		//Hack.
;761:		trap_SendConsoleCommand("ch_viewKeyPress");
;762:		return;
;763:	}
;764:	trap_Cvar_Set( "ch_viewKeyPress", ConcatArgs(1) );
;765:#endif
;766:}
LABELV $243
endproc CG_KeyPress_f 344 36
export CG_resetMaxSpeed_f
proc CG_resetMaxSpeed_f 0 0
line 768
;767:
;768:void CG_resetMaxSpeed_f (void) {
line 769
;769:	max_speed = 0;
ADDRGP4 max_speed
CNSTF4 0
ASGNF4
line 770
;770:}
LABELV $258
endproc CG_resetMaxSpeed_f 0 0
export CG_SetAlarm_f
proc CG_SetAlarm_f 48 12
line 772
;771:
;772:void CG_SetAlarm_f ( void ) {
line 776
;773:	//byte		time_type;
;774:	char		token[24];
;775:
;776:	trap_Argv( 1, token, sizeof(token) );
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 24
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 777
;777:	if ( !Q_stricmp( "unset", token ) ) {
ADDRGP4 $262
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $260
line 778
;778:		cg.alarmSet = qfalse;
ADDRGP4 cg+162084
CNSTI4 0
ASGNI4
line 779
;779:		return;
ADDRGP4 $259
JUMPV
LABELV $260
line 782
;780:	}
;781:
;782:	if ( trap_Argc() < 1 ) {
ADDRLP4 28
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 1
GEI4 $264
line 783
;783:		CG_Printf("Make sure you set the alarm correctly.\n /alarm unset or /alarm <hour> <minute> <time_type>v-- Example: /alarm 1 9 32\n ");
ADDRGP4 $266
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 784
;784:	}
LABELV $264
line 786
;785:	//Set the variables, everything else is taken care of *in* the alarm.
;786:	cg.alarmSet = qtrue;
ADDRGP4 cg+162084
CNSTI4 1
ASGNI4
line 788
;787:	//cg.time_type = atoi( CG_Argv( 2 ) );
;788:	cg.alarmTime_hour = atoi( token );
ADDRLP4 0
ARGP4
ADDRLP4 32
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cg+162092
ADDRLP4 32
INDIRI4
ASGNI4
line 790
;789:	//CG_Printf( "%s ", token );
;790:	trap_Argv( 2, token, sizeof(token) );
CNSTI4 2
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 24
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 792
;791:	//CG_Printf( "%s ", token );
;792:	cg.alarmTime_minute = atoi( token );
ADDRLP4 0
ARGP4
ADDRLP4 36
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cg+162096
ADDRLP4 36
INDIRI4
ASGNI4
line 794
;793:	//CG_Printf("hour %i, minute %i\n", cg.alarmTime_hour, cg.alarmTime_minute);
;794:	if ( trap_Argc() > 3 ) {
ADDRLP4 40
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 3
LEI4 $270
line 795
;795:		trap_Argv( 3, token, sizeof(token) );
CNSTI4 3
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 24
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 796
;796:		cg.time_type = atoi( token );
ADDRLP4 0
ARGP4
ADDRLP4 44
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cg+162088
ADDRLP4 44
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 797
;797:	}
LABELV $270
line 799
;798:
;799:}
LABELV $259
endproc CG_SetAlarm_f 48 12
proc CG_HelpSystem_f 17260 16
line 828
;800:
;801:
;802://static void CG_DbgRWS_f ( void ) {
;803://
;804://	
;805://	if ( cgs.dbgrws ) {
;806://		//Only add server debuging once the client stuff has been verified to work
;807://		//Secondly, send a server command so it know's we're debugging it.
;808://		trap_SendClientCommand("dbgrws \n");
;809://		return;
;810://	}
;811://
;812://	//Firstly set the qboolean to know we're debugging it
;813://	if ( !cgs.dbgrws ) {//On
;814://		cgs.dbgrws = qtrue;
;815://	} else {//Off
;816://		cgs.dbgrws = qfalse;
;817://		//We'll have to turn it off, no server side only dbg's for now =[
;818://		trap_SendClientCommand("dbgrws \n");
;819://	}
;820://	if ( !cg.dbgsto ) {//On
;821://		cg.dbgsto = qtrue;
;822://	} else {//Off
;823://		cg.dbgsto = qfalse;
;824://	}
;825://}
;826:
;827:static void CG_HelpSystem_f(void)
;828:{
line 830
;829://	char			*text_p, *prev;
;830:	int				length = 0;//, linelength = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 842
;831://	int				j = 0, m = 0, l = 0, k = 0;
;832://	char			*line;
;833://	char			explanation[256];
;834:	char			text[MAX_HELP_FILE_SIZE];
;835:	char			filename[MAX_QPATH];
;836:	char			arg1[128], arg2[128];
;837:	char			tmp[513];
;838:	char			*token, *ptr;
;839://	qboolean		helpList = qfalse;
;840:	fileHandle_t	f;
;841:	int				i;
;842:	qboolean		serverhelp = qfalse;
ADDRLP4 656
CNSTI4 0
ASGNI4
line 844
;843:
;844:	arg1[2] = '\0';
ADDRLP4 8+2
CNSTI1 0
ASGNI1
line 845
;845:	arg2[0] = '\0';
ADDRLP4 660
CNSTI1 0
ASGNI1
line 846
;846:	trap_Argv(1, arg1, sizeof(arg1));
CNSTI4 1
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 848
;847:
;848:	if(arg1[0] == '-' && arg1[1] == 's' && arg1[2] == '\0')
ADDRLP4 8
INDIRI1
CVII4 1
CNSTI4 45
NEI4 $275
ADDRLP4 8+1
INDIRI1
CVII4 1
CNSTI4 115
NEI4 $275
ADDRLP4 8+2
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $275
line 849
;849:	{
line 850
;850:		serverhelp = qtrue;
ADDRLP4 656
CNSTI4 1
ASGNI4
line 851
;851:		trap_Argv(2, arg2, sizeof(arg2));
CNSTI4 2
ARGI4
ADDRLP4 660
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 853
;852:
;853:		if((strlen(language.string) > 1) && (CG_FileExists(va("config/help/server/%s.help.cfg", language.string))))
ADDRGP4 language+16
ARGP4
ADDRLP4 17244
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 17244
INDIRI4
CNSTI4 1
LEI4 $279
ADDRGP4 $282
ARGP4
ADDRGP4 language+16
ARGP4
ADDRLP4 17248
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 17248
INDIRP4
ARGP4
ADDRLP4 17252
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 17252
INDIRI4
CNSTI4 0
EQI4 $279
line 854
;854:			Com_sprintf(filename, sizeof(filename), "config/help/server/%s.help.cfg", language.string);
ADDRLP4 17172
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $282
ARGP4
ADDRGP4 language+16
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
ADDRGP4 $276
JUMPV
LABELV $279
line 856
;855:		else
;856:		{
line 857
;857:			CG_Printf(""S_COLOR_RED"Loading %s.help.cfg failed! Defaulting to en.help.cfg\n", language.string);
ADDRGP4 $285
ARGP4
ADDRGP4 language+16
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 858
;858:			Com_sprintf(filename, sizeof(filename), "config/help/server/en.help.cfg");
ADDRLP4 17172
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $287
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 859
;859:		}
line 860
;860:	}
ADDRGP4 $276
JUMPV
LABELV $275
line 862
;861:	else
;862:	{
line 863
;863:		if((strlen(language.string) > 1) && (CG_FileExists(va("config/help/client/%s.help.cfg", language.string))))
ADDRGP4 language+16
ARGP4
ADDRLP4 17244
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 17244
INDIRI4
CNSTI4 1
LEI4 $288
ADDRGP4 $291
ARGP4
ADDRGP4 language+16
ARGP4
ADDRLP4 17248
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 17248
INDIRP4
ARGP4
ADDRLP4 17252
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 17252
INDIRI4
CNSTI4 0
EQI4 $288
line 864
;864:			Com_sprintf(filename, sizeof(filename), "config/help/client/%s.help.cfg", language.string);
ADDRLP4 17172
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $291
ARGP4
ADDRGP4 language+16
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
ADDRGP4 $289
JUMPV
LABELV $288
line 866
;865:		else
;866:		{
line 867
;867:			CG_Printf(""S_COLOR_RED"Loading %s.help.cfg failed! Defaulting to en.help.cfg\n", language.string);
ADDRGP4 $285
ARGP4
ADDRGP4 language+16
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 868
;868:			Com_sprintf(filename, sizeof(filename), "config/help/client/en.help.cfg");
ADDRLP4 17172
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $295
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 869
;869:		}
LABELV $289
line 870
;870:	}
LABELV $276
line 872
;871:
;872:	if((length = trap_FS_FOpenFile(filename, &f, FS_READ)) <= 0)
ADDRLP4 17172
ARGP4
ADDRLP4 17236
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 17244
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 17244
INDIRI4
ASGNI4
ADDRLP4 17244
INDIRI4
CNSTI4 0
GTI4 $296
line 873
;873:	{
line 874
;874:		CG_Printf(""S_COLOR_RED"Loading %s.help.cfg failed! Failed to open the file\n", language.string);
ADDRGP4 $298
ARGP4
ADDRGP4 language+16
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 875
;875:		return;
ADDRGP4 $273
JUMPV
LABELV $296
line 878
;876:	}
;877:
;878:	if(length >= MAX_HELP_FILE_SIZE)
ADDRLP4 0
INDIRI4
CNSTI4 16384
LTI4 $300
line 879
;879:	{
line 880
;880:		CG_Printf(""S_COLOR_RED"Loading %s.help.cfg failed! File too large\n", language.string);
ADDRGP4 $302
ARGP4
ADDRGP4 language+16
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 881
;881:		return;
ADDRGP4 $273
JUMPV
LABELV $300
line 884
;882:	}
;883:
;884:	trap_FS_Read(text, length, f);
ADDRLP4 788
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 17236
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 885
;885:	text[length] = '\0';
ADDRLP4 0
INDIRI4
ADDRLP4 788
ADDP4
CNSTI1 0
ASGNI1
line 886
;886:	trap_FS_FCloseFile(f);
ADDRLP4 17236
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 888
;887:
;888:	if((!serverhelp && !arg1[0]) || (serverhelp && !arg2[0]))
ADDRLP4 17248
CNSTI4 0
ASGNI4
ADDRLP4 656
INDIRI4
ADDRLP4 17248
INDIRI4
NEI4 $307
ADDRLP4 8
INDIRI1
CVII4 1
ADDRLP4 17248
INDIRI4
EQI4 $306
LABELV $307
ADDRLP4 17252
CNSTI4 0
ASGNI4
ADDRLP4 656
INDIRI4
ADDRLP4 17252
INDIRI4
EQI4 $304
ADDRLP4 660
INDIRI1
CVII4 1
ADDRLP4 17252
INDIRI4
NEI4 $304
LABELV $306
line 889
;889:	{
line 890
;890:		if(serverhelp)
ADDRLP4 656
INDIRI4
CNSTI4 0
EQI4 $308
line 891
;891:		{
line 893
;892:			//list all the available server help commands
;893:			if(!(token = HelpParse(arg2, text, qtrue)))
ADDRLP4 660
ARGP4
ADDRLP4 788
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 17256
ADDRGP4 HelpParse
CALLP4
ASGNP4
ADDRLP4 17240
ADDRLP4 17256
INDIRP4
ASGNP4
ADDRLP4 17256
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $309
line 894
;894:			{
line 895
;895:				CG_Printf(""S_COLOR_RED"ERROR: Failed to read the help file\n", arg1);
ADDRGP4 $312
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 896
;896:				return;
ADDRGP4 $273
JUMPV
line 898
;897:			}
;898:		}
LABELV $308
line 900
;899:		else
;900:		{
line 902
;901:			//list all the available help commands
;902:			if(!(token = HelpParse(arg1, text, qtrue)))
ADDRLP4 8
ARGP4
ADDRLP4 788
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 17256
ADDRGP4 HelpParse
CALLP4
ASGNP4
ADDRLP4 17240
ADDRLP4 17256
INDIRP4
ASGNP4
ADDRLP4 17256
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $313
line 903
;903:			{
line 904
;904:				CG_Printf(""S_COLOR_RED"ERROR: Failed to read the help file\n", arg1);
ADDRGP4 $312
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 905
;905:				return;
ADDRGP4 $273
JUMPV
LABELV $313
line 907
;906:			}
;907:		}
LABELV $309
line 909
;908:
;909:		length = strlen(token);
ADDRLP4 17240
INDIRP4
ARGP4
ADDRLP4 17256
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 17256
INDIRI4
ASGNI4
line 910
;910:		if(length > 512)
ADDRLP4 0
INDIRI4
CNSTI4 512
LEI4 $315
line 911
;911:		{
line 914
;912:			//CG_Printf seems to have a limit to the length of a string that can be output
;913:			//so we play it safe and break the output into 512 character chunks
;914:			if(serverhelp)
ADDRLP4 656
INDIRI4
CNSTI4 0
EQI4 $317
line 915
;915:				CG_Printf(""S_COLOR_YELLOW"The following server commands/cvars are available:\n");
ADDRGP4 $319
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
ADDRGP4 $318
JUMPV
LABELV $317
line 917
;916:			else
;917:				CG_Printf(""S_COLOR_YELLOW"The following commands/cvars are available:\n");
ADDRGP4 $320
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $318
line 919
;918:
;919:			ptr = token;
ADDRLP4 652
ADDRLP4 17240
INDIRP4
ASGNP4
line 920
;920:			for(i = 0; i < (length / 512); i++)
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $324
JUMPV
LABELV $321
line 921
;921:			{
line 922
;922:				if(i != ((length / 512) - 1))
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 512
DIVI4
CNSTI4 1
SUBI4
EQI4 $325
line 923
;923:				{
line 924
;924:					memcpy(tmp, ptr, 512);
ADDRLP4 136
ARGP4
ADDRLP4 652
INDIRP4
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 925
;925:					tmp[512] = '\0';
ADDRLP4 136+512
CNSTI1 0
ASGNI1
line 926
;926:				}
ADDRGP4 $326
JUMPV
LABELV $325
line 928
;927:				else
;928:				{
line 929
;929:					memcpy(tmp, ptr, length - (i * 512));
ADDRLP4 136
ARGP4
ADDRLP4 652
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 9
LSHI4
SUBI4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 930
;930:					tmp[length - (i * 512)] = '\0';
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 9
LSHI4
SUBI4
ADDRLP4 136
ADDP4
CNSTI1 0
ASGNI1
line 931
;931:				}
LABELV $326
line 933
;932:
;933:				CG_Printf(""S_COLOR_YELLOW"%s", tmp);
ADDRGP4 $328
ARGP4
ADDRLP4 136
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 934
;934:				ptr += 512;
ADDRLP4 652
ADDRLP4 652
INDIRP4
CNSTI4 512
ADDP4
ASGNP4
line 935
;935:			}
LABELV $322
line 920
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $324
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 512
DIVI4
LTI4 $321
line 937
;936:
;937:			CG_Printf("\n");
ADDRGP4 $329
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 938
;938:		}
ADDRGP4 $316
JUMPV
LABELV $315
line 940
;939:		else
;940:		{
line 941
;941:			if(serverhelp)
ADDRLP4 656
INDIRI4
CNSTI4 0
EQI4 $330
line 942
;942:				CG_Printf(""S_COLOR_YELLOW"The following server commands/cvars are available:\n%s\n", token);
ADDRGP4 $332
ARGP4
ADDRLP4 17240
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
ADDRGP4 $331
JUMPV
LABELV $330
line 944
;943:			else
;944:				CG_Printf(""S_COLOR_YELLOW"The following commands/cvars are available:\n%s\n", token);
ADDRGP4 $333
ARGP4
ADDRLP4 17240
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $331
line 945
;945:		}
LABELV $316
line 947
;946:
;947:		CG_Printf(""S_COLOR_YELLOW"\n%s %s\n", GAMEVERSION, BUILDINFO);
ADDRGP4 $334
ARGP4
ADDRGP4 $335
ARGP4
ADDRGP4 $336
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 948
;948:		CG_Printf(""S_COLOR_YELLOW"Usage: \\help command\n");
ADDRGP4 $337
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 949
;949:	}
ADDRGP4 $305
JUMPV
LABELV $304
line 951
;950:	else
;951:	{
line 952
;952:		if(serverhelp)
ADDRLP4 656
INDIRI4
CNSTI4 0
EQI4 $338
line 953
;953:		{
line 955
;954:			//list only the specified server help command
;955:			if(!(token = HelpParse(arg2, text, qfalse)))
ADDRLP4 660
ARGP4
ADDRLP4 788
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 17256
ADDRGP4 HelpParse
CALLP4
ASGNP4
ADDRLP4 17240
ADDRLP4 17256
INDIRP4
ASGNP4
ADDRLP4 17256
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $339
line 956
;956:			{
line 957
;957:				CG_Printf(""S_COLOR_RED"ERROR: Command %s not found\n", arg2);
ADDRGP4 $342
ARGP4
ADDRLP4 660
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 958
;958:				return;
ADDRGP4 $273
JUMPV
line 960
;959:			}
;960:		}
LABELV $338
line 962
;961:		else
;962:		{
line 964
;963:			//list only the specified help command
;964:			if(!(token = HelpParse(arg1, text, qfalse)))
ADDRLP4 8
ARGP4
ADDRLP4 788
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 17256
ADDRGP4 HelpParse
CALLP4
ASGNP4
ADDRLP4 17240
ADDRLP4 17256
INDIRP4
ASGNP4
ADDRLP4 17256
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $343
line 965
;965:			{
line 966
;966:				CG_Printf(""S_COLOR_RED"ERROR: Command %s not found\n", arg1);
ADDRGP4 $342
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 967
;967:				return;
ADDRGP4 $273
JUMPV
LABELV $343
line 969
;968:			}
;969:		}
LABELV $339
line 971
;970:
;971:		CG_Printf(""S_COLOR_YELLOW"%s\n", token);
ADDRGP4 $345
ARGP4
ADDRLP4 17240
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 972
;972:	}
LABELV $305
line 1083
;973:
;974:#if 0
;975:	//memset(&print, 0, sizeof(print));
;976:	memset(&explanation, 0, sizeof(explanation));
;977:	text_p = text;
;978:
;979:	if((strlen(arg1) == 0) && (!Q_stricmp(arg1, "help_list")))
;980:	{
;981:			token = stristr(text_p, "help_list");
;982:			helpList = qtrue;
;983:		} else {
;984:			token = stristr(text_p, arg1);
;985:		}
;986:
;987:	if(!helpList)
;988:	{
;989:			Com_sprintf(explanation, sizeof(explanation), HelpParse(token));
;990:			if ( strlen(explanation) < 3 ) {//No possible way this could be valid
;991:				memset(explanation, 0, sizeof(explanation) );
;992:				//Com_sprintf(explanation, sizeof(explanation), HelpParse("help_list"));
;993:				token = stristr(text_p, "help_list");
;994:				helpList = qtrue;
;995:				CG_Printf(""S_COLOR_RED"ERROR: Command %s not found.\n", arg1);
;996:			}
;997:		} /*else*/
;998:		if ( helpList ) {
;999:			qboolean	insertNewline = qfalse;
;1000:			qboolean	foundStart = qfalse;
;1001:			qboolean	foundEnd = qfalse;
;1002:			qboolean	start = qfalse;
;1003:
;1004:			CG_Printf("Availabe help cmmands:\n");
;1005:
;1006:			while ( 1 ) {
;1007:				prev = text_p; //so we can unget
;1008:				line = COM_Parse(&token);
;1009:
;1010:
;1011:				if ( (line[j - 1] == '{' || line[0] == '{') && !foundStart ) {
;1012:					foundStart = qtrue;
;1013:				}
;1014:
;1015:				if ( foundStart ) {//This is consuming, but safe-ish
;1016:					memset(&checkChar, 0, sizeof(checkChar));
;1017:					Com_sprintf(checkChar, sizeof(checkChar), line );
;1018:					for ( l = 0; l != strlen(checkChar); l++ ) {
;1019:						if ( checkChar[l] == '}' ) {
;1020:							foundEnd = qtrue; //Use this to break the while loop
;1021:							break;//break this loop, no need to continue
;1022:						}
;1023:					}
;1024:				}
;1025:
;1026:				if ( foundEnd ) {
;1027:					break;
;1028:				}
;1029:
;1030:				if ( start ) {
;1031:					//This is a very good example of laziness
;1032:					//FixedName to align things, then point line to it..
;1033:					if ( m < 2 ) {
;1034:						m++;
;1035:						FixedName( newLine, line, 26 );
;1036:						line = newLine;//Re-pointer to avoid changing a bunch of code.
;1037:					} else {
;1038:						m = 0;
;1039:						insertNewline = qtrue;
;1040:					}
;1041:					j = strlen(newLine);
;1042:
;1043:					if ( linelength + j > 1024 ) {
;1044:						//This voids the string limit to make sure all the columns get lined up.
;1045:						//Not exactly safe, careful for endless loops
;1046:						CG_Printf("%s", explanation);
;1047:						memset(&explanation, 0, sizeof(explanation));
;1048:						linelength = 0;
;1049:					}
;1050:					linelength += j;
;1051:					Q_strcat(explanation, sizeof(explanation), va("%s", line));
;1052:
;1053:					if ( insertNewline ) {
;1054:						k++;
;1055:						insertNewline = qfalse;
;1056:					//	linelength++;
;1057:					//	Q_strcat(explanation, sizeof(explanation), " ");
;1058:					//	linelength++;
;1059:					//	explanation[linelength] = '\n';
;1060:						/* Trying this */
;1061:						//Ideally we should do this, print every time we want a new line
;1062:						//for some reason it'd only add a new line 5 times, then stop.
;1063:						//This works around that.
;1064:						CG_Printf("%s\n", explanation);
;1065:						memset(&explanation, 0, sizeof(explanation));
;1066:						linelength = 0;
;1067:					}
;1068:
;1069:				}
;1070:
;1071:				if ( foundStart && !start ) {
;1072:					start = qtrue;
;1073:				}
;1074:			}
;1075:		}
;1076:
;1077:		CG_Printf("%s\n", explanation);
;1078:		if ( helpList ) {
;1079:			CG_Printf("\n%s %s\n", GAMEVERSION, BUILDINFO);
;1080:			CG_Printf("usage: \\help command \n");
;1081:		}
;1082:#endif
;1083:}
LABELV $273
endproc CG_HelpSystem_f 17260 16
export findArrayNum
proc findArrayNum 260 8
line 1086
;1084:
;1085://Superhud - Begin
;1086:int	findArrayNum ( char *arrayName ) {
line 1089
;1087:	//ugly if/else setup
;1088:	//We return from the enum list to make sure we're in sync, it's also easier to understand and update
;1089:	if ( !Q_stricmp(arrayName, "!DEFAULT")) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $349
ARGP4
ADDRLP4 0
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $347
line 1090
;1090:		return DEFAULT;
CNSTI4 1
RETI4
ADDRGP4 $346
JUMPV
LABELV $347
line 1091
;1091:	} else if ( !Q_stricmp( arrayName, "PreDecorate" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $352
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $350
line 1092
;1092:		return PreDecorate;
CNSTI4 2
RETI4
ADDRGP4 $346
JUMPV
LABELV $350
line 1093
;1093:	} else if ( !Q_stricmp( arrayName, "AmmoMessage" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $355
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $353
line 1094
;1094:		return AmmoMessage;
CNSTI4 3
RETI4
ADDRGP4 $346
JUMPV
LABELV $353
line 1095
;1095:	} else if ( !Q_stricmp( arrayName, "Chat1" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $358
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $356
line 1096
;1096:		return Chat1;
CNSTI4 6
RETI4
ADDRGP4 $346
JUMPV
LABELV $356
line 1097
;1097:	} else if ( !Q_stricmp( arrayName, "Chat2" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $361
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $359
line 1098
;1098:		return Chat2;
CNSTI4 7
RETI4
ADDRGP4 $346
JUMPV
LABELV $359
line 1099
;1099:	} else if ( !Q_stricmp( arrayName, "Chat3" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $364
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $362
line 1100
;1100:		return Chat3;
CNSTI4 8
RETI4
ADDRGP4 $346
JUMPV
LABELV $362
line 1101
;1101:	} else if ( !Q_stricmp( arrayName, "Chat4" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $367
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $365
line 1102
;1102:		return Chat4;
CNSTI4 9
RETI4
ADDRGP4 $346
JUMPV
LABELV $365
line 1103
;1103:	} else if ( !Q_stricmp( arrayName, "Chat5" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $370
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $368
line 1104
;1104:		return Chat5;
CNSTI4 10
RETI4
ADDRGP4 $346
JUMPV
LABELV $368
line 1105
;1105:	} else if ( !Q_stricmp( arrayName, "Chat6" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $373
ARGP4
ADDRLP4 32
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $371
line 1106
;1106:		return Chat6;
CNSTI4 11
RETI4
ADDRGP4 $346
JUMPV
LABELV $371
line 1107
;1107:	} else if ( !Q_stricmp( arrayName, "Chat7" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $376
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $374
line 1108
;1108:		return Chat7;
CNSTI4 12
RETI4
ADDRGP4 $346
JUMPV
LABELV $374
line 1109
;1109:	} else if ( !Q_stricmp( arrayName, "Chat8" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $379
ARGP4
ADDRLP4 40
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $377
line 1110
;1110:		return Chat8;
CNSTI4 13
RETI4
ADDRGP4 $346
JUMPV
LABELV $377
line 1111
;1111:	} else if ( !Q_stricmp( arrayName, "Console" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $382
ARGP4
ADDRLP4 44
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $380
line 1112
;1112:		return Console;
CNSTI4 14
RETI4
ADDRGP4 $346
JUMPV
LABELV $380
line 1113
;1113:	} else if ( !Q_stricmp( arrayName, "FlagStatus_NME" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $385
ARGP4
ADDRLP4 48
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $383
line 1114
;1114:		return FlagStatus_NME;
CNSTI4 15
RETI4
ADDRGP4 $346
JUMPV
LABELV $383
line 1115
;1115:	} else if ( !Q_stricmp( arrayName, "FlagStatus_OWN" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $388
ARGP4
ADDRLP4 52
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $386
line 1116
;1116:		return FlagStatus_OWN;
CNSTI4 16
RETI4
ADDRGP4 $346
JUMPV
LABELV $386
line 1117
;1117:	} else if ( !Q_stricmp( arrayName, "FollowMessage" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $391
ARGP4
ADDRLP4 56
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $389
line 1118
;1118:		return FollowMessage;
CNSTI4 17
RETI4
ADDRGP4 $346
JUMPV
LABELV $389
line 1119
;1119:	} else if ( !Q_stricmp( arrayName, "FPS" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $394
ARGP4
ADDRLP4 60
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $392
line 1120
;1120:		return FPS;
CNSTI4 18
RETI4
ADDRGP4 $346
JUMPV
LABELV $392
line 1121
;1121:	} else if ( !Q_stricmp( arrayName, "FragMessage" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $397
ARGP4
ADDRLP4 64
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
NEI4 $395
line 1122
;1122:		return FragMessage;
CNSTI4 19
RETI4
ADDRGP4 $346
JUMPV
LABELV $395
line 1123
;1123:	} else if ( !Q_stricmp( arrayName, "GameTime" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $400
ARGP4
ADDRLP4 68
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
NEI4 $398
line 1124
;1124:		return GameTime;
CNSTI4 20
RETI4
ADDRGP4 $346
JUMPV
LABELV $398
line 1125
;1125:	} else if ( !Q_stricmp( arrayName, "GameType" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $403
ARGP4
ADDRLP4 72
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $401
line 1126
;1126:		return GameType;
CNSTI4 21
RETI4
ADDRGP4 $346
JUMPV
LABELV $401
line 1127
;1127:	} else if ( !Q_stricmp( arrayName, "ItemPickup" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $406
ARGP4
ADDRLP4 76
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $404
line 1128
;1128:		return ItemPickup;
CNSTI4 22
RETI4
ADDRGP4 $346
JUMPV
LABELV $404
line 1129
;1129:	} else if ( !Q_stricmp( arrayName, "ItemPickupIcon" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $409
ARGP4
ADDRLP4 80
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
NEI4 $407
line 1130
;1130:		return ItemPickupIcon;
CNSTI4 23
RETI4
ADDRGP4 $346
JUMPV
LABELV $407
line 1131
;1131:	} else if ( !Q_stricmp( arrayName, "NetGraph" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $412
ARGP4
ADDRLP4 84
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
NEI4 $410
line 1132
;1132:		return NetGraph;
CNSTI4 24
RETI4
ADDRGP4 $346
JUMPV
LABELV $410
line 1133
;1133:	} else if ( !Q_stricmp( arrayName, "NetGraphPing" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $415
ARGP4
ADDRLP4 88
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
NEI4 $413
line 1134
;1134:		return NetGraphPing;
CNSTI4 25
RETI4
ADDRGP4 $346
JUMPV
LABELV $413
line 1135
;1135:	} else if ( !Q_stricmp( arrayName, "PlayerSpeed" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $418
ARGP4
ADDRLP4 92
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
NEI4 $416
line 1136
;1136:		return PlayerSpeed;
CNSTI4 26
RETI4
ADDRGP4 $346
JUMPV
LABELV $416
line 1137
;1137:	} else if ( !Q_stricmp( arrayName, "PowerUp1_Icon" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $421
ARGP4
ADDRLP4 96
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 0
NEI4 $419
line 1138
;1138:		return PowerUp1_Icon;
CNSTI4 27
RETI4
ADDRGP4 $346
JUMPV
LABELV $419
line 1139
;1139:	} else if ( !Q_stricmp( arrayName, "PowerUp2_Icon" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $424
ARGP4
ADDRLP4 100
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
NEI4 $422
line 1140
;1140:		return PowerUp2_Icon;
CNSTI4 28
RETI4
ADDRGP4 $346
JUMPV
LABELV $422
line 1141
;1141:	} else if ( !Q_stricmp( arrayName, "PowerUp3_Icon" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $427
ARGP4
ADDRLP4 104
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 0
NEI4 $425
line 1142
;1142:		return PowerUp3_Icon;
CNSTI4 29
RETI4
ADDRGP4 $346
JUMPV
LABELV $425
line 1143
;1143:	} else if ( !Q_stricmp( arrayName, "PowerUp4_Icon" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $430
ARGP4
ADDRLP4 108
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 108
INDIRI4
CNSTI4 0
NEI4 $428
line 1144
;1144:		return PowerUp4_Icon;
CNSTI4 30
RETI4
ADDRGP4 $346
JUMPV
LABELV $428
line 1145
;1145:	} else if ( !Q_stricmp( arrayName, "PowerUp1_Time" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $433
ARGP4
ADDRLP4 112
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 0
NEI4 $431
line 1146
;1146:		return PowerUp1_Time;
CNSTI4 31
RETI4
ADDRGP4 $346
JUMPV
LABELV $431
line 1147
;1147:	} else if ( !Q_stricmp( arrayName, "PowerUp2_Time" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $436
ARGP4
ADDRLP4 116
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 0
NEI4 $434
line 1148
;1148:		return PowerUp2_Time;
CNSTI4 32
RETI4
ADDRGP4 $346
JUMPV
LABELV $434
line 1149
;1149:	} else if ( !Q_stricmp( arrayName, "PowerUp3_Time" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $439
ARGP4
ADDRLP4 120
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 0
NEI4 $437
line 1150
;1150:		return PowerUp3_Time;
CNSTI4 33
RETI4
ADDRGP4 $346
JUMPV
LABELV $437
line 1151
;1151:	} else if ( !Q_stricmp( arrayName, "PowerUp4_Time" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $442
ARGP4
ADDRLP4 124
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 0
NEI4 $440
line 1152
;1152:		return PowerUp4_Time;
CNSTI4 34
RETI4
ADDRGP4 $346
JUMPV
LABELV $440
line 1153
;1153:	} else if ( !Q_stricmp( arrayName, "RankMessage" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $445
ARGP4
ADDRLP4 128
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 128
INDIRI4
CNSTI4 0
NEI4 $443
line 1154
;1154:		return RankMessage;
CNSTI4 35
RETI4
ADDRGP4 $346
JUMPV
LABELV $443
line 1155
;1155:	} else if ( !Q_stricmp( arrayName, "Score_Limit" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $448
ARGP4
ADDRLP4 132
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 0
NEI4 $446
line 1156
;1156:		return Score_Limit;
CNSTI4 36
RETI4
ADDRGP4 $346
JUMPV
LABELV $446
line 1157
;1157:	} else if ( !Q_stricmp( arrayName, "Score_NME" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $451
ARGP4
ADDRLP4 136
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 0
NEI4 $449
line 1158
;1158:		return Score_NME;
CNSTI4 37
RETI4
ADDRGP4 $346
JUMPV
LABELV $449
line 1159
;1159:	} else if ( !Q_stricmp( arrayName, "Score_OWN" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $454
ARGP4
ADDRLP4 140
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
NEI4 $452
line 1160
;1160:		return Score_OWN;
CNSTI4 38
RETI4
ADDRGP4 $346
JUMPV
LABELV $452
line 1161
;1161:	} else if ( !Q_stricmp( arrayName, "SpecMessage" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $457
ARGP4
ADDRLP4 144
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
NEI4 $455
line 1162
;1162:		return SpecMessage;
CNSTI4 39
RETI4
ADDRGP4 $346
JUMPV
LABELV $455
line 1163
;1163:	} else if ( !Q_stricmp( arrayName, "StatusBar_ArmorBar" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $460
ARGP4
ADDRLP4 148
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $458
line 1164
;1164:		return StatusBar_ArmorBar;
CNSTI4 40
RETI4
ADDRGP4 $346
JUMPV
LABELV $458
line 1165
;1165:	} else if ( !Q_stricmp( arrayName, "StatusBar_ArmorCount" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $463
ARGP4
ADDRLP4 152
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
NEI4 $461
line 1166
;1166:		return StatusBar_ArmorCount;
CNSTI4 41
RETI4
ADDRGP4 $346
JUMPV
LABELV $461
line 1167
;1167:	} else if ( !Q_stricmp( arrayName, "StatusBar_ArmorIcon" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $466
ARGP4
ADDRLP4 156
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
NEI4 $464
line 1168
;1168:		return StatusBar_ArmorIcon;
CNSTI4 42
RETI4
ADDRGP4 $346
JUMPV
LABELV $464
line 1169
;1169:	} else if ( !Q_stricmp( arrayName, "StatusBar_AmmoBar" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $469
ARGP4
ADDRLP4 160
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
NEI4 $467
line 1170
;1170:		return StatusBar_AmmoBar;
CNSTI4 43
RETI4
ADDRGP4 $346
JUMPV
LABELV $467
line 1171
;1171:	} else if ( !Q_stricmp( arrayName, "StatusBar_AmmoCount" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $472
ARGP4
ADDRLP4 164
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 0
NEI4 $470
line 1172
;1172:		return StatusBar_AmmoCount;
CNSTI4 44
RETI4
ADDRGP4 $346
JUMPV
LABELV $470
line 1173
;1173:	} else if ( !Q_stricmp( arrayName, "StatusBar_AmmoIcon" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $475
ARGP4
ADDRLP4 168
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 0
NEI4 $473
line 1174
;1174:		return StatusBar_AmmoIcon;
CNSTI4 45
RETI4
ADDRGP4 $346
JUMPV
LABELV $473
line 1175
;1175:	} else if ( !Q_stricmp( arrayName, "StatusBar_HealthBar" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $478
ARGP4
ADDRLP4 172
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
NEI4 $476
line 1176
;1176:		return StatusBar_HealthBar;
CNSTI4 46
RETI4
ADDRGP4 $346
JUMPV
LABELV $476
line 1177
;1177:	} else if ( !Q_stricmp( arrayName, "StatusBar_HealthCount" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $481
ARGP4
ADDRLP4 176
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 0
NEI4 $479
line 1178
;1178:		return StatusBar_HealthCount;
CNSTI4 47
RETI4
ADDRGP4 $346
JUMPV
LABELV $479
line 1179
;1179:	} else if ( !Q_stricmp( arrayName, "StatusBar_HealthIcon" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $484
ARGP4
ADDRLP4 180
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 0
NEI4 $482
line 1180
;1180:		return StatusBar_HealthIcon;
CNSTI4 48
RETI4
ADDRGP4 $346
JUMPV
LABELV $482
line 1181
;1181:	} else if ( !Q_stricmp( arrayName, "TargetName" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $487
ARGP4
ADDRLP4 184
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 184
INDIRI4
CNSTI4 0
NEI4 $485
line 1182
;1182:		return TargetName;
CNSTI4 49
RETI4
ADDRGP4 $346
JUMPV
LABELV $485
line 1183
;1183:	} else if ( !Q_stricmp( arrayName, "TargetStatus" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $490
ARGP4
ADDRLP4 188
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 188
INDIRI4
CNSTI4 0
NEI4 $488
line 1184
;1184:		return TargetStatus;
CNSTI4 50
RETI4
ADDRGP4 $346
JUMPV
LABELV $488
line 1185
;1185:	} else if ( !Q_stricmp( arrayName, "TeamCount_NME" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $493
ARGP4
ADDRLP4 192
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 0
NEI4 $491
line 1186
;1186:		return TeamCount_NME;
CNSTI4 51
RETI4
ADDRGP4 $346
JUMPV
LABELV $491
line 1187
;1187:	} else if ( !Q_stricmp( arrayName, "TeamCount_OWN" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $496
ARGP4
ADDRLP4 196
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 0
NEI4 $494
line 1188
;1188:		return TeamCount_OWN;
CNSTI4 52
RETI4
ADDRGP4 $346
JUMPV
LABELV $494
line 1189
;1189:	} else if ( !Q_stricmp( arrayName, "TeamIcon_NME" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $499
ARGP4
ADDRLP4 200
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 200
INDIRI4
CNSTI4 0
NEI4 $497
line 1190
;1190:		return TeamIcon_NME;
CNSTI4 53
RETI4
ADDRGP4 $346
JUMPV
LABELV $497
line 1191
;1191:	} else if ( !Q_stricmp( arrayName, "TeamIcon_OWN" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $502
ARGP4
ADDRLP4 204
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 0
NEI4 $500
line 1192
;1192:		return TeamIcon_OWN;
CNSTI4 54
RETI4
ADDRGP4 $346
JUMPV
LABELV $500
line 1193
;1193:	} else if ( !Q_stricmp( arrayName, "Team1" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $505
ARGP4
ADDRLP4 208
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 208
INDIRI4
CNSTI4 0
NEI4 $503
line 1194
;1194:		return Team1;
CNSTI4 55
RETI4
ADDRGP4 $346
JUMPV
LABELV $503
line 1195
;1195:	} else if ( !Q_stricmp( arrayName, "Team2" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $508
ARGP4
ADDRLP4 212
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 212
INDIRI4
CNSTI4 0
NEI4 $506
line 1196
;1196:		return Team2;
CNSTI4 56
RETI4
ADDRGP4 $346
JUMPV
LABELV $506
line 1197
;1197:	} else if ( !Q_stricmp( arrayName, "Team3" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $511
ARGP4
ADDRLP4 216
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 216
INDIRI4
CNSTI4 0
NEI4 $509
line 1198
;1198:		return Team3;
CNSTI4 57
RETI4
ADDRGP4 $346
JUMPV
LABELV $509
line 1199
;1199:	} else if ( !Q_stricmp( arrayName, "Team4" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $514
ARGP4
ADDRLP4 220
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 220
INDIRI4
CNSTI4 0
NEI4 $512
line 1200
;1200:		return Team4;
CNSTI4 58
RETI4
ADDRGP4 $346
JUMPV
LABELV $512
line 1201
;1201:	} else if ( !Q_stricmp( arrayName, "Team5" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $517
ARGP4
ADDRLP4 224
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 224
INDIRI4
CNSTI4 0
NEI4 $515
line 1202
;1202:		return Team5;
CNSTI4 59
RETI4
ADDRGP4 $346
JUMPV
LABELV $515
line 1203
;1203:	} else if ( !Q_stricmp( arrayName, "Team6" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $520
ARGP4
ADDRLP4 228
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 228
INDIRI4
CNSTI4 0
NEI4 $518
line 1204
;1204:		return Team6;
CNSTI4 60
RETI4
ADDRGP4 $346
JUMPV
LABELV $518
line 1205
;1205:	} else if ( !Q_stricmp( arrayName, "Team7" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $523
ARGP4
ADDRLP4 232
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 232
INDIRI4
CNSTI4 0
NEI4 $521
line 1206
;1206:		return Team7;
CNSTI4 61
RETI4
ADDRGP4 $346
JUMPV
LABELV $521
line 1207
;1207:	} else if ( !Q_stricmp( arrayName, "Team8" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $526
ARGP4
ADDRLP4 236
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 236
INDIRI4
CNSTI4 0
NEI4 $524
line 1208
;1208:		return Team8;
CNSTI4 62
RETI4
ADDRGP4 $346
JUMPV
LABELV $524
line 1209
;1209:	} else if ( !Q_stricmp( arrayName, "VoteMessageArena" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $529
ARGP4
ADDRLP4 240
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 240
INDIRI4
CNSTI4 0
NEI4 $527
line 1210
;1210:		return VoteMessageArena;
CNSTI4 63
RETI4
ADDRGP4 $346
JUMPV
LABELV $527
line 1211
;1211:	} else if ( !Q_stricmp( arrayName, "VoteMessageWorld" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $532
ARGP4
ADDRLP4 244
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 244
INDIRI4
CNSTI4 0
NEI4 $530
line 1212
;1212:		return VoteMessageWorld;
CNSTI4 64
RETI4
ADDRGP4 $346
JUMPV
LABELV $530
line 1213
;1213:	} else if ( !Q_stricmp( arrayName, "WarmupInfo" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $535
ARGP4
ADDRLP4 248
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 248
INDIRI4
CNSTI4 0
NEI4 $533
line 1214
;1214:		return WarmupInfo;
CNSTI4 65
RETI4
ADDRGP4 $346
JUMPV
LABELV $533
line 1215
;1215:	} else if ( !Q_stricmp( arrayName, "WeaponList" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $538
ARGP4
ADDRLP4 252
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 252
INDIRI4
CNSTI4 0
NEI4 $536
line 1216
;1216:		return WeaponList;
CNSTI4 66
RETI4
ADDRGP4 $346
JUMPV
LABELV $536
line 1217
;1217:	} else if ( !Q_stricmp( arrayName, "PostDecorate" )) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $541
ARGP4
ADDRLP4 256
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 256
INDIRI4
CNSTI4 0
NEI4 $539
line 1218
;1218:		return PostDecorate;
CNSTI4 67
RETI4
ADDRGP4 $346
JUMPV
LABELV $539
line 1219
;1219:	} else {
line 1221
;1220:		//No recognized command
;1221:		return none;
CNSTI4 0
RETI4
LABELV $346
endproc findArrayNum 260 8
bss
align 4
LABELV $543
skip 4
export ParseHud
code
proc ParseHud 18124 16
line 1330
;1222:	}
;1223:
;1224:}
;1225:
;1226://token_type GetToken(char *token, char **line)
;1227://{
;1228://	char *ptr;
;1229://	token_type ret = T_TOKEN;
;1230://
;1231://	if((**line) == '\0')
;1232://	{
;1233://		*ptr = '\0';
;1234://		return T_EOF;
;1235://	}
;1236://
;1237://	ptr = token;
;1238://
;1239://t_start:
;1240://	//scan off leading spaces, tabs, commas and newlines
;1241://	while(((**line) == ' ') || ((**line) == '\t') || ((**line) == '\n') || ((**line) == 0xd) || ((**line) == ','))
;1242://		(*line)++;
;1243://
;1244://	if((**line) == ';')
;1245://	{
;1246://		(*line)++;
;1247://		*ptr = '\0';
;1248://		return T_SEMI;
;1249://	}
;1250://	else if((**line) == '{')
;1251://	{
;1252://		(*line)++;
;1253://		*ptr = '\0';
;1254://		return T_BEGIN_BRACKET;
;1255://	}
;1256://	else if((**line) == '}')
;1257://	{
;1258://		(*line)++;
;1259://		*ptr = '\0';
;1260://		return T_END_BRACKET;
;1261://	}
;1262://	else if((**line) == '#')
;1263://	{
;1264://		//comments
;1265://		while(((**line) != '\n') && ((**line) != 0xd))
;1266://		{
;1267://			if((**line) == '\0')
;1268://			{
;1269://				*ptr = '\0';
;1270://				return T_EOF;
;1271://			}
;1272://
;1273://			(*line)++;
;1274://		}
;1275://
;1276://		goto t_start;
;1277://	}
;1278://	else if((**line) == '"')
;1279://	{
;1280://		(*line)++;
;1281://
;1282://		//string
;1283://		while((**line) != '"')
;1284://		{
;1285://			if((**line) == '\0')
;1286://			{
;1287://				*ptr = '\0';
;1288://				return T_EOF;
;1289://			}
;1290://
;1291://			(*ptr) = (**line);
;1292://			ptr++;
;1293://			(*line)++;
;1294://		}
;1295://
;1296://		(*line)++;
;1297://		*ptr = '\0';
;1298://		return T_STRING;
;1299://	}
;1300://	else if((**line) == '\0')
;1301://	{
;1302://		*ptr = '\0';
;1303://		return T_EOF;
;1304://	}
;1305://
;1306://	//parse the token
;1307://	while(((**line) != ' ') && ((**line) != '\t') && ((**line) != '\n') && ((**line) != 0xd) && ((**line) != ',') && ((**line) != ';') && ((**line) != '{') && ((**line) != '}'))
;1308://	{
;1309://		if((**line) == '\0')
;1310://			break;
;1311:///*
;1312://		if(((**line) == ';'))
;1313://		{
;1314://			(*line)++;			//skip over the semi
;1315://			ret = T_SEMI;
;1316://			break;
;1317://		}
;1318://*/
;1319://		(*ptr) = (**line);
;1320://		ptr++;
;1321://		(*line)++;
;1322://	}
;1323://
;1324://	*ptr = '\0';
;1325://	
;1326://	return ret;
;1327://}
;1328:
;1329://NOTE: hud[] array length = maxHudCommands + 64
;1330:void ParseHud( void ) {
line 1335
;1331:	char			token[MAX_TOKEN_CHARS];			//max size for a single token
;1332:	char			filestring[MAX_HELP_FILE_SIZE];
;1333://	qboolean		cmdu[maxHudCommands];			//marks when a command has been used
;1334:	static char		*fsptr;
;1335:	int				index = 0;						//index into hud array
ADDRLP4 1036
CNSTI4 0
ASGNI4
line 1337
;1336:	int				ret, cmdi, i;
;1337:	int				length = 0;
ADDRLP4 1548
CNSTI4 0
ASGNI4
line 1345
;1338:	char			filename[MAX_QPATH];
;1339:	fileHandle_t	f;
;1340:	hud_t			default_info;
;1341:	char			*ptr;
;1342://	int				eof_count = 0;//fault tolerance.
;1343:
;1344:	//check for a file extension
;1345:	if((length = strlen(ch_file.string)) <= 0)
ADDRGP4 ch_file+16
ARGP4
ADDRLP4 18004
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1548
ADDRLP4 18004
INDIRI4
ASGNI4
ADDRLP4 18004
INDIRI4
CNSTI4 0
GTI4 $544
line 1346
;1346:		return;
ADDRGP4 $542
JUMPV
LABELV $544
line 1348
;1347:
;1348:	ptr = ch_file.string + (length - 1);
ADDRLP4 1544
ADDRLP4 1548
INDIRI4
ADDRGP4 ch_file+16-1
ADDP4
ASGNP4
ADDRGP4 $550
JUMPV
LABELV $549
line 1350
;1349:	while((ptr != ch_file.string) && (*ptr != '.'))
;1350:		ptr--;
ADDRLP4 1544
ADDRLP4 1544
INDIRP4
CNSTI4 -1
ADDP4
ASGNP4
LABELV $550
line 1349
ADDRLP4 1544
INDIRP4
CVPU4 4
ADDRGP4 ch_file+16
CVPU4 4
EQU4 $553
ADDRLP4 1544
INDIRP4
INDIRI1
CVII4 1
CNSTI4 46
NEI4 $549
LABELV $553
line 1352
;1351:
;1352:	if(ptr == ch_file.string)
ADDRLP4 1544
INDIRP4
CVPU4 4
ADDRGP4 ch_file+16
CVPU4 4
NEU4 $554
line 1353
;1353:	{
line 1355
;1354:		//have to add extension
;1355:		if(CG_FileExists(va("hud/%s.cfg", ch_file.string)))
ADDRGP4 $559
ARGP4
ADDRGP4 ch_file+16
ARGP4
ADDRLP4 18012
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 18012
INDIRP4
ARGP4
ADDRLP4 18016
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 18016
INDIRI4
CNSTI4 0
EQI4 $557
line 1356
;1356:		{
line 1357
;1357:			Com_sprintf(filename, sizeof(filename), "hud/%s.cfg", ch_file.string);
ADDRLP4 17940
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $559
ARGP4
ADDRGP4 ch_file+16
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1358
;1358:			trap_Cvar_Set("ch_file", va("%s.cfg", ch_file.string));
ADDRGP4 $563
ARGP4
ADDRGP4 ch_file+16
ARGP4
ADDRLP4 18020
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $562
ARGP4
ADDRLP4 18020
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1359
;1359:		}
ADDRGP4 $555
JUMPV
LABELV $557
line 1361
;1360:		else
;1361:		{
line 1362
;1362:			CG_Printf(""S_COLOR_RED"Loading HUD file %s failed! Defaulting to no HUD file\n", ch_file.string);
ADDRGP4 $565
ARGP4
ADDRGP4 ch_file+16
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1363
;1363:			trap_Cvar_Set("ch_file", "");
ADDRGP4 $562
ARGP4
ADDRGP4 $567
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1364
;1364:		}
line 1365
;1365:	}
ADDRGP4 $555
JUMPV
LABELV $554
line 1367
;1366:	else
;1367:	{
line 1368
;1368:		if(CG_FileExists(va("hud/%s", ch_file.string)))
ADDRGP4 $570
ARGP4
ADDRGP4 ch_file+16
ARGP4
ADDRLP4 18012
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 18012
INDIRP4
ARGP4
ADDRLP4 18016
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 18016
INDIRI4
CNSTI4 0
EQI4 $568
line 1369
;1369:			Com_sprintf(filename, sizeof(filename), "hud/%s", ch_file.string);
ADDRLP4 17940
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $570
ARGP4
ADDRGP4 ch_file+16
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
ADDRGP4 $569
JUMPV
LABELV $568
line 1371
;1370:		else
;1371:		{
line 1372
;1372:			CG_Printf(""S_COLOR_RED"Loading HUD file %s failed! Defaulting to no HUD file\n", ch_file.string);
ADDRGP4 $565
ARGP4
ADDRGP4 ch_file+16
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1373
;1373:			trap_Cvar_Set("ch_file", "");
ADDRGP4 $562
ARGP4
ADDRGP4 $567
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1374
;1374:		}
LABELV $569
line 1375
;1375:	}
LABELV $555
line 1378
;1376:
;1377:	//load the file
;1378:	length = 0;
ADDRLP4 1548
CNSTI4 0
ASGNI4
line 1379
;1379:	if((length = trap_FS_FOpenFile(filename, &f, FS_READ)) <= 0)
ADDRLP4 17940
ARGP4
ADDRLP4 17936
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 18012
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 1548
ADDRLP4 18012
INDIRI4
ASGNI4
ADDRLP4 18012
INDIRI4
CNSTI4 0
GTI4 $574
line 1380
;1380:	{
line 1381
;1381:		CG_Printf(""S_COLOR_RED"Loading HUD file %s failed! Empty HUD file\n", ch_file.string);
ADDRGP4 $576
ARGP4
ADDRGP4 ch_file+16
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1382
;1382:		return;
ADDRGP4 $542
JUMPV
LABELV $574
line 1385
;1383:	}
;1384:
;1385:	if(length >= MAX_HELP_FILE_SIZE - 1)
ADDRLP4 1548
INDIRI4
CNSTI4 16383
LTI4 $578
line 1386
;1386:	{
line 1387
;1387:		CG_Printf(""S_COLOR_RED"Loading HUD file %s failed! HUD file is too long\n", ch_file.string);
ADDRGP4 $580
ARGP4
ADDRGP4 ch_file+16
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1388
;1388:		return;
ADDRGP4 $542
JUMPV
LABELV $578
line 1391
;1389:	}
;1390:
;1391:	memset(filestring, 0, MAX_HELP_FILE_SIZE);
ADDRLP4 1552
ARGP4
CNSTI4 0
ARGI4
CNSTI4 16384
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1392
;1392:	trap_FS_Read(filestring, length, f);
ADDRLP4 1552
ARGP4
ADDRLP4 1548
INDIRI4
ARGI4
ADDRLP4 17936
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 1393
;1393:	trap_FS_FCloseFile(f);
ADDRLP4 17936
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 1394
;1394:	filestring[length] = '\0';
ADDRLP4 1548
INDIRI4
ADDRLP4 1552
ADDP4
CNSTI1 0
ASGNI1
line 1395
;1395:	fsptr = filestring;
ADDRGP4 $543
ADDRLP4 1552
ASGNP4
line 1397
;1396:
;1397:	memset(&default_info, 0, sizeof(default_info));
ADDRLP4 1040
ARGP4
CNSTI4 0
ARGI4
CNSTI4 504
ARGI4
ADDRGP4 memset
CALLP4
pop
ADDRGP4 $583
JUMPV
LABELV $582
line 1401
;1398:
;1399:	//loop through each element
;1400:	while(*fsptr)
;1401:	{
line 1402
;1402:		if(index >= (maxHudCommands + 64))
ADDRLP4 1036
INDIRI4
CNSTI4 132
LTI4 $585
line 1403
;1403:		{
line 1404
;1404:			CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! hud[] array overflow", ch_file.string);
ADDRGP4 $587
ARGP4
ADDRGP4 ch_file+16
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1405
;1405:			break;
ADDRGP4 $584
JUMPV
LABELV $585
line 1408
;1406:		}
;1407:
;1408:		if((ret = GetToken(token, &fsptr)) == T_EOF)
ADDRLP4 0
ARGP4
ADDRGP4 $543
ARGP4
ADDRLP4 18016
ADDRGP4 GetToken
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 18016
INDIRI4
ASGNI4
ADDRLP4 18016
INDIRI4
CNSTI4 0
NEI4 $589
line 1409
;1409:			break;
ADDRGP4 $584
JUMPV
LABELV $589
line 1412
;1410:
;1411:		//command name
;1412:		if((cmdi = findArrayNum(token)) == none)
ADDRLP4 0
ARGP4
ADDRLP4 18020
ADDRGP4 findArrayNum
CALLI4
ASGNI4
ADDRLP4 1032
ADDRLP4 18020
INDIRI4
ASGNI4
ADDRLP4 18020
INDIRI4
CNSTI4 0
NEI4 $591
line 1413
;1413:		{
line 1414
;1414:			CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! Unrecognized command %s", ch_file.string, token);
ADDRGP4 $593
ARGP4
ADDRGP4 ch_file+16
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1415
;1415:			break;
ADDRGP4 $584
JUMPV
LABELV $591
line 1418
;1416:		}
;1417:
;1418:		if(cmdi != DEFAULT)
ADDRLP4 1032
INDIRI4
CNSTI4 1
EQI4 $595
line 1419
;1419:			memcpy(&hud[index], &default_info, sizeof(hud_t));
ADDRLP4 18024
CNSTI4 504
ASGNI4
ADDRLP4 18024
INDIRI4
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud
ADDP4
ARGP4
ADDRLP4 1040
ARGP4
ADDRLP4 18024
INDIRI4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $596
JUMPV
LABELV $595
line 1421
;1420:		else
;1421:		{
line 1423
;1422:			//reset booleans to get around a limitation/bug known about in CPMA
;1423:			default_info.draw3d = qfalse;
ADDRLP4 1040+52
CNSTI4 0
ASGNI4
line 1424
;1424:			default_info.fill = qfalse;
ADDRLP4 1040+56
CNSTI4 0
ASGNI4
line 1425
;1425:			default_info.doublebar = qfalse;
ADDRLP4 1040+60
CNSTI4 0
ASGNI4
line 1426
;1426:			default_info.monospace = qfalse;
ADDRLP4 1040+64
CNSTI4 0
ASGNI4
line 1427
;1427:		}
LABELV $596
line 1429
;1428:
;1429:		hud[index].element = cmdi;
CNSTI4 504
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud+44
ADDP4
ADDRLP4 1032
INDIRI4
ASGNI4
line 1430
;1430:		strncpy(hud[index].name, token, 41);
CNSTI4 504
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud
ADDP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 41
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 1432
;1431:
;1432:		ret = GetToken(token, &fsptr);
ADDRLP4 0
ARGP4
ADDRGP4 $543
ARGP4
ADDRLP4 18028
ADDRGP4 GetToken
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 18028
INDIRI4
ASGNI4
line 1433
;1433:		if(ret != T_BEGIN_BRACKET)
ADDRLP4 1028
INDIRI4
CNSTI4 2
EQI4 $607
line 1434
;1434:		{
line 1435
;1435:			CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! Expected '{' after command %s", ch_file.string, hud[index].name);
ADDRGP4 $604
ARGP4
ADDRGP4 ch_file+16
ARGP4
CNSTI4 504
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud
ADDP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1436
;1436:			break;
ADDRGP4 $584
JUMPV
LABELV $606
line 1440
;1437:		}
;1438:
;1439:		while(*fsptr)
;1440:		{
line 1441
;1441:			ret = GetToken(token, &fsptr);
ADDRLP4 0
ARGP4
ADDRGP4 $543
ARGP4
ADDRLP4 18032
ADDRGP4 GetToken
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 18032
INDIRI4
ASGNI4
line 1443
;1442:
;1443:			if(ret == T_END_BRACKET)
ADDRLP4 1028
INDIRI4
CNSTI4 3
NEI4 $609
line 1444
;1444:				break;
ADDRGP4 $608
JUMPV
LABELV $609
line 1445
;1445:			else if(ret == T_BEGIN_BRACKET)
ADDRLP4 1028
INDIRI4
CNSTI4 2
NEI4 $611
line 1446
;1446:			{
line 1447
;1447:				CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! Syntax error in definition of %s: too many '{' found", ch_file.string, hud[index].name);
ADDRGP4 $613
ARGP4
ADDRGP4 ch_file+16
ARGP4
CNSTI4 504
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud
ADDP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1448
;1448:				hud_count = index;
ADDRGP4 hud_count
ADDRLP4 1036
INDIRI4
ASGNI4
line 1449
;1449:				return;
ADDRGP4 $542
JUMPV
LABELV $611
line 1451
;1450:			}
;1451:			else if(ret == T_EOF)
ADDRLP4 1028
INDIRI4
CNSTI4 0
NEI4 $615
line 1452
;1452:			{
line 1453
;1453:				CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! Unexpected end of file", ch_file.string);
ADDRGP4 $617
ARGP4
ADDRGP4 ch_file+16
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1454
;1454:				hud_count = index;
ADDRGP4 hud_count
ADDRLP4 1036
INDIRI4
ASGNI4
line 1455
;1455:				return;
ADDRGP4 $542
JUMPV
LABELV $615
line 1457
;1456:			}
;1457:			else if(ret == T_SEMI)
ADDRLP4 1028
INDIRI4
CNSTI4 1
NEI4 $619
line 1458
;1458:				continue;
ADDRGP4 $607
JUMPV
LABELV $619
line 1460
;1459:
;1460:			if(!Q_stricmp(token, "bgcolor"))
ADDRLP4 0
ARGP4
ADDRGP4 $623
ARGP4
ADDRLP4 18036
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 18036
INDIRI4
CNSTI4 0
NEI4 $621
line 1461
;1461:			{
line 1462
;1462:				for(i = 0; i < 4; i++)
ADDRLP4 1024
CNSTI4 0
ASGNI4
LABELV $624
line 1463
;1463:				{
line 1464
;1464:					ret = GetToken(token, &fsptr);
ADDRLP4 0
ARGP4
ADDRGP4 $543
ARGP4
ADDRLP4 18040
ADDRGP4 GetToken
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 18040
INDIRI4
ASGNI4
line 1465
;1465:					if(token[0] == 'T')
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 84
NEI4 $628
line 1466
;1466:					{
line 1467
;1467:						if(cmdi == DEFAULT)
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $630
line 1468
;1468:							default_info.TEBgcolor = TEAM_COLORS;
ADDRLP4 1040+173
CNSTU1 1
ASGNU1
ADDRGP4 $629
JUMPV
LABELV $630
line 1470
;1469:						else
;1470:							hud[index].TEBgcolor = TEAM_COLORS;
CNSTI4 504
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud+173
ADDP4
CNSTU1 1
ASGNU1
line 1471
;1471:					}
ADDRGP4 $629
JUMPV
LABELV $628
line 1472
;1472:					else if(token[0] == 'E')
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 69
NEI4 $634
line 1473
;1473:					{
line 1474
;1474:						if(cmdi == DEFAULT)
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $636
line 1475
;1475:							default_info.TEBgcolor = ENEMY_COLORS;
ADDRLP4 1040+173
CNSTU1 2
ASGNU1
ADDRGP4 $635
JUMPV
LABELV $636
line 1477
;1476:						else
;1477:							hud[index].TEBgcolor = ENEMY_COLORS;
CNSTI4 504
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud+173
ADDP4
CNSTU1 2
ASGNU1
line 1478
;1478:					}
ADDRGP4 $635
JUMPV
LABELV $634
line 1480
;1479:					else
;1480:					{
line 1481
;1481:						if(ret != T_TOKEN || token[0] < 0x2d || token[0] > 0x39 || token[0] == 0x2f)
ADDRLP4 1028
INDIRI4
CNSTI4 5
NEI4 $644
ADDRLP4 18044
ADDRLP4 0
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 18044
INDIRI4
CNSTI4 45
LTI4 $644
ADDRLP4 18044
INDIRI4
CNSTI4 57
GTI4 $644
ADDRLP4 18044
INDIRI4
CNSTI4 47
NEI4 $640
LABELV $644
line 1482
;1482:						{
line 1483
;1483:							CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! bgcolor command requires 4 color values", ch_file.string);
ADDRGP4 $645
ARGP4
ADDRGP4 ch_file+16
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1484
;1484:							hud_count = index;
ADDRGP4 hud_count
ADDRLP4 1036
INDIRI4
ASGNI4
line 1485
;1485:							return;
ADDRGP4 $542
JUMPV
LABELV $640
line 1488
;1486:						}
;1487:
;1488:						if(cmdi == DEFAULT)
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $647
line 1489
;1489:							default_info.bgcolor[i] = atof(token);
ADDRLP4 0
ARGP4
ADDRLP4 18048
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 1024
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1040+84
ADDP4
ADDRLP4 18048
INDIRF4
ASGNF4
ADDRGP4 $648
JUMPV
LABELV $647
line 1491
;1490:						else
;1491:							hud[index].bgcolor[i] = atof(token);
ADDRLP4 0
ARGP4
ADDRLP4 18052
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 1024
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 504
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud+84
ADDP4
ADDP4
ADDRLP4 18052
INDIRF4
ASGNF4
LABELV $648
line 1492
;1492:					}
LABELV $635
LABELV $629
line 1493
;1493:				}
LABELV $625
line 1462
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 4
LTI4 $624
line 1494
;1494:			}
ADDRGP4 $622
JUMPV
LABELV $621
line 1495
;1495:			else if(!Q_stricmp(token, "color"))
ADDRLP4 0
ARGP4
ADDRGP4 $653
ARGP4
ADDRLP4 18040
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 18040
INDIRI4
CNSTI4 0
NEI4 $651
line 1496
;1496:			{
line 1497
;1497:				for(i = 0; i < 4; i++)
ADDRLP4 1024
CNSTI4 0
ASGNI4
LABELV $654
line 1498
;1498:				{
line 1499
;1499:					ret = GetToken(token, &fsptr);
ADDRLP4 0
ARGP4
ADDRGP4 $543
ARGP4
ADDRLP4 18044
ADDRGP4 GetToken
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 18044
INDIRI4
ASGNI4
line 1500
;1500:					if(token[0] == 'T')
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 84
NEI4 $658
line 1501
;1501:					{
line 1502
;1502:						if(cmdi == DEFAULT)
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $660
line 1503
;1503:							default_info.TEBgcolor = TEAM_COLORS;
ADDRLP4 1040+173
CNSTU1 1
ASGNU1
ADDRGP4 $659
JUMPV
LABELV $660
line 1505
;1504:						else
;1505:							hud[index].TEBgcolor = TEAM_COLORS;
CNSTI4 504
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud+173
ADDP4
CNSTU1 1
ASGNU1
line 1506
;1506:					}
ADDRGP4 $659
JUMPV
LABELV $658
line 1507
;1507:					else if(token[0] == 'E')
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 69
NEI4 $664
line 1508
;1508:					{
line 1509
;1509:						if(cmdi == DEFAULT)
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $666
line 1510
;1510:							default_info.TEBgcolor = ENEMY_COLORS;
ADDRLP4 1040+173
CNSTU1 2
ASGNU1
ADDRGP4 $665
JUMPV
LABELV $666
line 1512
;1511:						else
;1512:							hud[index].TEBgcolor = ENEMY_COLORS;
CNSTI4 504
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud+173
ADDP4
CNSTU1 2
ASGNU1
line 1513
;1513:					}
ADDRGP4 $665
JUMPV
LABELV $664
line 1515
;1514:					else
;1515:					{
line 1516
;1516:						if(ret != T_TOKEN || token[0] < 0x2d || token[0] > 0x39 || token[0] == 0x2f)
ADDRLP4 1028
INDIRI4
CNSTI4 5
NEI4 $674
ADDRLP4 18048
ADDRLP4 0
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 18048
INDIRI4
CNSTI4 45
LTI4 $674
ADDRLP4 18048
INDIRI4
CNSTI4 57
GTI4 $674
ADDRLP4 18048
INDIRI4
CNSTI4 47
NEI4 $670
LABELV $674
line 1517
;1517:						{
line 1518
;1518:							CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! color command requires 4 color values", ch_file.string);
ADDRGP4 $675
ARGP4
ADDRGP4 ch_file+16
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1519
;1519:							hud_count = index;
ADDRGP4 hud_count
ADDRLP4 1036
INDIRI4
ASGNI4
line 1520
;1520:							return;
ADDRGP4 $542
JUMPV
LABELV $670
line 1523
;1521:						}
;1522:
;1523:						if(cmdi == DEFAULT)
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $677
line 1524
;1524:							default_info.color[i] = atof(token);
ADDRLP4 0
ARGP4
ADDRLP4 18052
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 1024
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1040+68
ADDP4
ADDRLP4 18052
INDIRF4
ASGNF4
ADDRGP4 $678
JUMPV
LABELV $677
line 1526
;1525:						else
;1526:							hud[index].color[i] = atof(token);
ADDRLP4 0
ARGP4
ADDRLP4 18056
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 1024
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 504
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud+68
ADDP4
ADDP4
ADDRLP4 18056
INDIRF4
ASGNF4
LABELV $678
line 1527
;1527:					}
LABELV $665
LABELV $659
line 1528
;1528:				}
LABELV $655
line 1497
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 4
LTI4 $654
line 1529
;1529:			}
ADDRGP4 $652
JUMPV
LABELV $651
line 1530
;1530:			else if(!Q_stricmp(token, "doublebar"))
ADDRLP4 0
ARGP4
ADDRGP4 $683
ARGP4
ADDRLP4 18044
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 18044
INDIRI4
CNSTI4 0
NEI4 $681
line 1531
;1531:			{
line 1532
;1532:				if(cmdi == DEFAULT)
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $684
line 1533
;1533:					default_info.doublebar = qtrue;
ADDRLP4 1040+60
CNSTI4 1
ASGNI4
ADDRGP4 $682
JUMPV
LABELV $684
line 1535
;1534:				else
;1535:					hud[index].doublebar = qtrue;
CNSTI4 504
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud+60
ADDP4
CNSTI4 1
ASGNI4
line 1536
;1536:			}
ADDRGP4 $682
JUMPV
LABELV $681
line 1537
;1537:			else if(!Q_stricmp(token, "fade"))
ADDRLP4 0
ARGP4
ADDRGP4 $690
ARGP4
ADDRLP4 18048
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 18048
INDIRI4
CNSTI4 0
NEI4 $688
line 1538
;1538:			{
line 1539
;1539:				for(i = 0; i < 4; i++)
ADDRLP4 1024
CNSTI4 0
ASGNI4
LABELV $691
line 1540
;1540:				{
line 1541
;1541:					ret = GetToken(token, &fsptr);
ADDRLP4 0
ARGP4
ADDRGP4 $543
ARGP4
ADDRLP4 18052
ADDRGP4 GetToken
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 18052
INDIRI4
ASGNI4
line 1542
;1542:					if(ret != T_TOKEN || token[0] < 0x2d || token[0] > 0x39 || token[0] == 0x2f)
ADDRLP4 1028
INDIRI4
CNSTI4 5
NEI4 $699
ADDRLP4 18056
ADDRLP4 0
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 18056
INDIRI4
CNSTI4 45
LTI4 $699
ADDRLP4 18056
INDIRI4
CNSTI4 57
GTI4 $699
ADDRLP4 18056
INDIRI4
CNSTI4 47
NEI4 $695
LABELV $699
line 1543
;1543:					{
line 1544
;1544:						CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! fade command requires 4 color values", ch_file.string);
ADDRGP4 $700
ARGP4
ADDRGP4 ch_file+16
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1545
;1545:						hud_count = index;
ADDRGP4 hud_count
ADDRLP4 1036
INDIRI4
ASGNI4
line 1546
;1546:						return;
ADDRGP4 $542
JUMPV
LABELV $695
line 1549
;1547:					}
;1548:
;1549:					if(cmdi == DEFAULT)
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $702
line 1550
;1550:						default_info.fade[i] = atof(token);
ADDRLP4 0
ARGP4
ADDRLP4 18060
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 1024
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1040+100
ADDP4
ADDRLP4 18060
INDIRF4
ASGNF4
ADDRGP4 $703
JUMPV
LABELV $702
line 1552
;1551:					else
;1552:						hud[index].fade[i] = atof(token);
ADDRLP4 0
ARGP4
ADDRLP4 18064
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 1024
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 504
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud+100
ADDP4
ADDP4
ADDRLP4 18064
INDIRF4
ASGNF4
LABELV $703
line 1553
;1553:				}
LABELV $692
line 1539
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 4
LTI4 $691
line 1554
;1554:			}
ADDRGP4 $689
JUMPV
LABELV $688
line 1555
;1555:			else if(!Q_stricmp(token, "fill"))
ADDRLP4 0
ARGP4
ADDRGP4 $708
ARGP4
ADDRLP4 18052
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 18052
INDIRI4
CNSTI4 0
NEI4 $706
line 1556
;1556:			{
line 1557
;1557:				if(cmdi == DEFAULT)
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $709
line 1558
;1558:					default_info.fill = qtrue;
ADDRLP4 1040+56
CNSTI4 1
ASGNI4
ADDRGP4 $707
JUMPV
LABELV $709
line 1560
;1559:				else
;1560:					hud[index].fill = qtrue;
CNSTI4 504
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud+56
ADDP4
CNSTI4 1
ASGNI4
line 1561
;1561:			}
ADDRGP4 $707
JUMPV
LABELV $706
line 1562
;1562:			else if(!Q_stricmp(token, "font"))
ADDRLP4 0
ARGP4
ADDRGP4 $715
ARGP4
ADDRLP4 18056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 18056
INDIRI4
CNSTI4 0
NEI4 $713
line 1563
;1563:			{
line 1564
;1564:				ret = GetToken(token, &fsptr);
ADDRLP4 0
ARGP4
ADDRGP4 $543
ARGP4
ADDRLP4 18060
ADDRGP4 GetToken
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 18060
INDIRI4
ASGNI4
line 1565
;1565:				if(ret != T_TOKEN)
ADDRLP4 1028
INDIRI4
CNSTI4 5
EQI4 $716
line 1566
;1566:				{
line 1567
;1567:					CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! Invalid syntax in font command", ch_file.string);
ADDRGP4 $718
ARGP4
ADDRGP4 ch_file+16
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1568
;1568:					hud_count = index;
ADDRGP4 hud_count
ADDRLP4 1036
INDIRI4
ASGNI4
line 1569
;1569:					return;
ADDRGP4 $542
JUMPV
LABELV $716
line 1572
;1570:				}
;1571:
;1572:				if(Q_stricmp(token, "cpma") && Q_stricmp(token, "id") && Q_stricmp(token, "idblock") && Q_stricmp(token, "threewave"))
ADDRLP4 0
ARGP4
ADDRGP4 $722
ARGP4
ADDRLP4 18064
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 18064
INDIRI4
CNSTI4 0
EQI4 $720
ADDRLP4 0
ARGP4
ADDRGP4 $723
ARGP4
ADDRLP4 18068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 18068
INDIRI4
CNSTI4 0
EQI4 $720
ADDRLP4 0
ARGP4
ADDRGP4 $724
ARGP4
ADDRLP4 18072
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 18072
INDIRI4
CNSTI4 0
EQI4 $720
ADDRLP4 0
ARGP4
ADDRGP4 $725
ARGP4
ADDRLP4 18076
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 18076
INDIRI4
CNSTI4 0
EQI4 $720
line 1573
;1573:				{
line 1574
;1574:					CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! Invalid font %s", ch_file.string, token);
ADDRGP4 $726
ARGP4
ADDRGP4 ch_file+16
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1575
;1575:					hud_count = index;
ADDRGP4 hud_count
ADDRLP4 1036
INDIRI4
ASGNI4
line 1576
;1576:					return;
ADDRGP4 $542
JUMPV
LABELV $720
line 1579
;1577:				}
;1578:
;1579:				if(cmdi == DEFAULT)
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $728
line 1580
;1580:					strncpy(default_info.font, token, sizeof(default_info.font));
ADDRLP4 1040+176
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 strncpy
CALLP4
pop
ADDRGP4 $714
JUMPV
LABELV $728
line 1582
;1581:				else
;1582:					strncpy(hud[index].font, token, sizeof(hud[index].font));
CNSTI4 504
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud+176
ADDP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 1583
;1583:			}
ADDRGP4 $714
JUMPV
LABELV $713
line 1584
;1584:			else if(!Q_stricmp(token, "fontsize"))
ADDRLP4 0
ARGP4
ADDRGP4 $736
ARGP4
ADDRLP4 18060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 18060
INDIRI4
CNSTI4 0
NEI4 $734
line 1585
;1585:			{
line 1586
;1586:				ret = GetToken(token, &fsptr);
ADDRLP4 0
ARGP4
ADDRGP4 $543
ARGP4
ADDRLP4 18064
ADDRGP4 GetToken
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 18064
INDIRI4
ASGNI4
line 1587
;1587:				if(ret != T_TOKEN || token[0] < 0x30 || token[0] > 0x39)
ADDRLP4 1028
INDIRI4
CNSTI4 5
NEI4 $740
ADDRLP4 18068
ADDRLP4 0
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 18068
INDIRI4
CNSTI4 48
LTI4 $740
ADDRLP4 18068
INDIRI4
CNSTI4 57
LEI4 $737
LABELV $740
line 1588
;1588:				{
line 1589
;1589:					CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! fontsize command requires at least 1 integer value", ch_file.string);
ADDRGP4 $741
ARGP4
ADDRGP4 ch_file+16
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1590
;1590:					hud_count = index;
ADDRGP4 hud_count
ADDRLP4 1036
INDIRI4
ASGNI4
line 1591
;1591:					return;
ADDRGP4 $542
JUMPV
LABELV $737
line 1594
;1592:				}
;1593:
;1594:				if(cmdi == DEFAULT)
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $743
line 1595
;1595:					default_info.fontsize[0] = atoi(token);
ADDRLP4 0
ARGP4
ADDRLP4 18072
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1040+160
ADDRLP4 18072
INDIRI4
ASGNI4
ADDRGP4 $744
JUMPV
LABELV $743
line 1597
;1596:				else
;1597:					hud[index].fontsize[0] = atoi(token);
ADDRLP4 0
ARGP4
ADDRLP4 18076
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTI4 504
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud+160
ADDP4
ADDRLP4 18076
INDIRI4
ASGNI4
LABELV $744
line 1599
;1598:
;1599:				if(GetToken(token, &fsptr) == T_EOF)
ADDRLP4 0
ARGP4
ADDRGP4 $543
ARGP4
ADDRLP4 18080
ADDRGP4 GetToken
CALLI4
ASGNI4
ADDRLP4 18080
INDIRI4
CNSTI4 0
NEI4 $747
line 1600
;1600:				{
line 1601
;1601:					CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! Unexpected end of file", ch_file.string);
ADDRGP4 $617
ARGP4
ADDRGP4 ch_file+16
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1602
;1602:					hud_count = index;
ADDRGP4 hud_count
ADDRLP4 1036
INDIRI4
ASGNI4
line 1603
;1603:					return;
ADDRGP4 $542
JUMPV
LABELV $747
line 1606
;1604:				}
;1605:
;1606:				if(token[0] >= 0x30 && token[0] <= 0x39)
ADDRLP4 18084
ADDRLP4 0
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 18084
INDIRI4
CNSTI4 48
LTI4 $750
ADDRLP4 18084
INDIRI4
CNSTI4 57
GTI4 $750
line 1607
;1607:				{
line 1608
;1608:					if(cmdi == DEFAULT)
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $752
line 1609
;1609:						default_info.fontsize[1] = atoi(token);
ADDRLP4 0
ARGP4
ADDRLP4 18088
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1040+160+4
ADDRLP4 18088
INDIRI4
ASGNI4
ADDRGP4 $735
JUMPV
LABELV $752
line 1611
;1610:					else
;1611:						hud[index].fontsize[1] = atoi(token);
ADDRLP4 0
ARGP4
ADDRLP4 18092
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTI4 504
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud+160+4
ADDP4
ADDRLP4 18092
INDIRI4
ASGNI4
line 1612
;1612:				}
ADDRGP4 $735
JUMPV
LABELV $750
line 1614
;1613:				else
;1614:				{
line 1615
;1615:					if(cmdi == DEFAULT)
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $758
line 1616
;1616:						default_info.fontsize[1] = -1;
ADDRLP4 1040+160+4
CNSTI4 -1
ASGNI4
ADDRGP4 $759
JUMPV
LABELV $758
line 1618
;1617:					else
;1618:						hud[index].fontsize[1] = -1;
CNSTI4 504
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud+160+4
ADDP4
CNSTI4 -1
ASGNI4
LABELV $759
line 1621
;1619:
;1620:					//reset the current position in the file
;1621:					fsptr -= strlen(token);
ADDRLP4 0
ARGP4
ADDRLP4 18088
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 18092
ADDRGP4 $543
ASGNP4
ADDRLP4 18092
INDIRP4
ADDRLP4 18092
INDIRP4
INDIRP4
ADDRLP4 18088
INDIRI4
SUBP4
ASGNP4
line 1622
;1622:				}
line 1623
;1623:			}
ADDRGP4 $735
JUMPV
LABELV $734
line 1624
;1624:			else if(!Q_stricmp(token, "image"))
ADDRLP4 0
ARGP4
ADDRGP4 $766
ARGP4
ADDRLP4 18064
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 18064
INDIRI4
CNSTI4 0
NEI4 $764
line 1625
;1625:			{
line 1628
;1626:				char *ep;
;1627:
;1628:				ret = GetToken(token, &fsptr);
ADDRLP4 0
ARGP4
ADDRGP4 $543
ARGP4
ADDRLP4 18072
ADDRGP4 GetToken
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 18072
INDIRI4
ASGNI4
line 1629
;1629:				if(ret != T_STRING)
ADDRLP4 1028
INDIRI4
CNSTI4 4
EQI4 $767
line 1630
;1630:				{
line 1631
;1631:					CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! image command requires an image file to be specified", ch_file.string);
ADDRGP4 $769
ARGP4
ADDRGP4 ch_file+16
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1632
;1632:					hud_count = index;
ADDRGP4 hud_count
ADDRLP4 1036
INDIRI4
ASGNI4
line 1633
;1633:					return;
ADDRGP4 $542
JUMPV
LABELV $767
line 1636
;1634:				}
;1635:
;1636:				ep = token;
ADDRLP4 18068
ADDRLP4 0
ASGNP4
ADDRGP4 $772
JUMPV
LABELV $771
line 1638
;1637:				while(*ep != '\0')
;1638:					ep++;
ADDRLP4 18068
ADDRLP4 18068
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $772
line 1637
ADDRLP4 18068
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $771
line 1640
;1639:
;1640:				ep -= 5;
ADDRLP4 18068
ADDRLP4 18068
INDIRP4
CNSTI4 -5
ADDP4
ASGNP4
line 1641
;1641:				if(!Q_stricmp(ep, ".skin"))
ADDRLP4 18068
INDIRP4
ARGP4
ADDRGP4 $776
ARGP4
ADDRLP4 18076
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 18076
INDIRI4
CNSTI4 0
NEI4 $774
line 1642
;1642:				{
line 1643
;1643:					if(cmdi == DEFAULT)
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $777
line 1644
;1644:						default_info.image = trap_R_RegisterSkin(token);
ADDRLP4 0
ARGP4
ADDRLP4 18080
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRLP4 1040+496
ADDRLP4 18080
INDIRI4
ASGNI4
ADDRGP4 $765
JUMPV
LABELV $777
line 1646
;1645:					else
;1646:						hud[index].image = trap_R_RegisterSkin(token);
ADDRLP4 0
ARGP4
ADDRLP4 18084
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
CNSTI4 504
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud+496
ADDP4
ADDRLP4 18084
INDIRI4
ASGNI4
line 1647
;1647:				}
ADDRGP4 $765
JUMPV
LABELV $774
line 1649
;1648:				else
;1649:				{
line 1650
;1650:					if(cmdi == DEFAULT)
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $781
line 1651
;1651:						default_info.image = trap_R_RegisterShader(token);
ADDRLP4 0
ARGP4
ADDRLP4 18080
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 1040+496
ADDRLP4 18080
INDIRI4
ASGNI4
ADDRGP4 $765
JUMPV
LABELV $781
line 1653
;1652:					else
;1653:						hud[index].image = trap_R_RegisterShader(token);
ADDRLP4 0
ARGP4
ADDRLP4 18084
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
CNSTI4 504
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud+496
ADDP4
ADDRLP4 18084
INDIRI4
ASGNI4
line 1654
;1654:				}
line 1655
;1655:			}
ADDRGP4 $765
JUMPV
LABELV $764
line 1656
;1656:			else if(!Q_stricmp(token, "monospace"))
ADDRLP4 0
ARGP4
ADDRGP4 $787
ARGP4
ADDRLP4 18068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 18068
INDIRI4
CNSTI4 0
NEI4 $785
line 1657
;1657:			{
line 1658
;1658:				if(cmdi == DEFAULT)
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $788
line 1659
;1659:					default_info.monospace = qtrue;
ADDRLP4 1040+64
CNSTI4 1
ASGNI4
ADDRGP4 $786
JUMPV
LABELV $788
line 1661
;1660:				else
;1661:					hud[index].monospace = qtrue;
CNSTI4 504
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud+64
ADDP4
CNSTI4 1
ASGNI4
line 1662
;1662:			}
ADDRGP4 $786
JUMPV
LABELV $785
line 1663
;1663:			else if(!Q_stricmp(token, "rect"))
ADDRLP4 0
ARGP4
ADDRGP4 $794
ARGP4
ADDRLP4 18072
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 18072
INDIRI4
CNSTI4 0
NEI4 $792
line 1664
;1664:			{
line 1665
;1665:				for(i = 0; i < 4; i++)
ADDRLP4 1024
CNSTI4 0
ASGNI4
LABELV $795
line 1666
;1666:				{
line 1667
;1667:					ret = GetToken(token, &fsptr);
ADDRLP4 0
ARGP4
ADDRGP4 $543
ARGP4
ADDRLP4 18076
ADDRGP4 GetToken
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 18076
INDIRI4
ASGNI4
line 1668
;1668:					if(ret != T_TOKEN || (token[0] < 0x30 && token[0] != 0x2d) || token[0] > 0x39)
ADDRLP4 1028
INDIRI4
CNSTI4 5
NEI4 $802
ADDRLP4 18080
ADDRLP4 0
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 18080
INDIRI4
CNSTI4 48
GEI4 $803
ADDRLP4 18080
INDIRI4
CNSTI4 45
NEI4 $802
LABELV $803
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 57
LEI4 $799
LABELV $802
line 1669
;1669:					{
line 1670
;1670:						CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! rect command requires 4 integer values", ch_file.string);
ADDRGP4 $804
ARGP4
ADDRGP4 ch_file+16
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1671
;1671:						hud_count = index;
ADDRGP4 hud_count
ADDRLP4 1036
INDIRI4
ASGNI4
line 1672
;1672:						return;
ADDRGP4 $542
JUMPV
LABELV $799
line 1675
;1673:					}
;1674:
;1675:					if(cmdi == DEFAULT)
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $806
line 1676
;1676:						default_info.rect[i] = atoi(token);
ADDRLP4 0
ARGP4
ADDRLP4 18084
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1040+144
ADDP4
ADDRLP4 18084
INDIRI4
ASGNI4
ADDRGP4 $807
JUMPV
LABELV $806
line 1678
;1677:					else
;1678:						hud[index].rect[i] = atoi(token);
ADDRLP4 0
ARGP4
ADDRLP4 18088
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 504
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud+144
ADDP4
ADDP4
ADDRLP4 18088
INDIRI4
ASGNI4
LABELV $807
line 1679
;1679:				}
LABELV $796
line 1665
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 4
LTI4 $795
line 1680
;1680:			}
ADDRGP4 $793
JUMPV
LABELV $792
line 1681
;1681:			else if(!Q_stricmp(token, "text"))
ADDRLP4 0
ARGP4
ADDRGP4 $812
ARGP4
ADDRLP4 18076
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 18076
INDIRI4
CNSTI4 0
NEI4 $810
line 1682
;1682:			{
line 1683
;1683:				ret = GetToken(token, &fsptr);
ADDRLP4 0
ARGP4
ADDRGP4 $543
ARGP4
ADDRLP4 18080
ADDRGP4 GetToken
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 18080
INDIRI4
ASGNI4
line 1684
;1684:				if(ret != T_STRING)
ADDRLP4 1028
INDIRI4
CNSTI4 4
EQI4 $813
line 1685
;1685:				{
line 1686
;1686:					CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! text command requires a string of characters", ch_file.string);
ADDRGP4 $815
ARGP4
ADDRGP4 ch_file+16
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1687
;1687:					hud_count = index;
ADDRGP4 hud_count
ADDRLP4 1036
INDIRI4
ASGNI4
line 1688
;1688:					return;
ADDRGP4 $542
JUMPV
LABELV $813
line 1691
;1689:				}
;1690:
;1691:				if(cmdi == DEFAULT)
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $817
line 1692
;1692:					strncpy(default_info.text, token, 255);
ADDRLP4 1040+240
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 255
ARGI4
ADDRGP4 strncpy
CALLP4
pop
ADDRGP4 $811
JUMPV
LABELV $817
line 1694
;1693:				else
;1694:					strncpy(hud[index].text, token, 255);
CNSTI4 504
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud+240
ADDP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 255
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 1695
;1695:			}
ADDRGP4 $811
JUMPV
LABELV $810
line 1696
;1696:			else if(!Q_stricmp(token, "textalign"))
ADDRLP4 0
ARGP4
ADDRGP4 $823
ARGP4
ADDRLP4 18080
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 18080
INDIRI4
CNSTI4 0
NEI4 $821
line 1697
;1697:			{
line 1698
;1698:				ret = GetToken(token, &fsptr);
ADDRLP4 0
ARGP4
ADDRGP4 $543
ARGP4
ADDRLP4 18084
ADDRGP4 GetToken
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 18084
INDIRI4
ASGNI4
line 1699
;1699:				if(ret != T_TOKEN)
ADDRLP4 1028
INDIRI4
CNSTI4 5
EQI4 $824
line 1700
;1700:				{
line 1701
;1701:					CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! textalign command requires either L, C or R as an argument", ch_file.string);
ADDRGP4 $826
ARGP4
ADDRGP4 ch_file+16
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1702
;1702:					hud_count = index;
ADDRGP4 hud_count
ADDRLP4 1036
INDIRI4
ASGNI4
line 1703
;1703:					return;
ADDRGP4 $542
JUMPV
LABELV $824
line 1706
;1704:				}
;1705:
;1706:				if(token[0] == 'l' || token[0] == 'L')
ADDRLP4 18088
ADDRLP4 0
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 18088
INDIRI4
CNSTI4 108
EQI4 $830
ADDRLP4 18088
INDIRI4
CNSTI4 76
NEI4 $828
LABELV $830
line 1707
;1707:				{
line 1708
;1708:					if(cmdi == DEFAULT)
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $831
line 1709
;1709:						default_info.textalign = 2;
ADDRLP4 1040+174
CNSTU1 2
ASGNU1
ADDRGP4 $822
JUMPV
LABELV $831
line 1711
;1710:					else
;1711:						hud[index].textalign = 2;
CNSTI4 504
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud+174
ADDP4
CNSTU1 2
ASGNU1
line 1712
;1712:				}
ADDRGP4 $822
JUMPV
LABELV $828
line 1713
;1713:				else if(token[0] == 'c' || token[0] == 'C')
ADDRLP4 18092
ADDRLP4 0
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 18092
INDIRI4
CNSTI4 99
EQI4 $837
ADDRLP4 18092
INDIRI4
CNSTI4 67
NEI4 $835
LABELV $837
line 1714
;1714:				{
line 1715
;1715:					if(cmdi == DEFAULT)
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $838
line 1716
;1716:						default_info.textalign = 1;
ADDRLP4 1040+174
CNSTU1 1
ASGNU1
ADDRGP4 $822
JUMPV
LABELV $838
line 1718
;1717:					else
;1718:						hud[index].textalign = 1;
CNSTI4 504
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud+174
ADDP4
CNSTU1 1
ASGNU1
line 1719
;1719:				}
ADDRGP4 $822
JUMPV
LABELV $835
line 1720
;1720:				else if(token[0] == 'r' || token[0] == 'R')
ADDRLP4 18096
ADDRLP4 0
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 18096
INDIRI4
CNSTI4 114
EQI4 $844
ADDRLP4 18096
INDIRI4
CNSTI4 82
NEI4 $842
LABELV $844
line 1721
;1721:				{
line 1722
;1722:					if(cmdi == DEFAULT)
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $845
line 1723
;1723:						default_info.textalign = 0;
ADDRLP4 1040+174
CNSTU1 0
ASGNU1
ADDRGP4 $822
JUMPV
LABELV $845
line 1725
;1724:					else
;1725:						hud[index].textalign = 0;
CNSTI4 504
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud+174
ADDP4
CNSTU1 0
ASGNU1
line 1726
;1726:				}
ADDRGP4 $822
JUMPV
LABELV $842
line 1728
;1727:				else
;1728:				{
line 1729
;1729:					CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! textalign command requires either l, c or r as an argument", ch_file.string);
ADDRGP4 $849
ARGP4
ADDRGP4 ch_file+16
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1730
;1730:					hud_count = index;
ADDRGP4 hud_count
ADDRLP4 1036
INDIRI4
ASGNI4
line 1731
;1731:					return;
ADDRGP4 $542
JUMPV
line 1733
;1732:				}
;1733:			}
LABELV $821
line 1734
;1734:			else if(!Q_stricmp(token, "textstyle"))
ADDRLP4 0
ARGP4
ADDRGP4 $853
ARGP4
ADDRLP4 18084
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 18084
INDIRI4
CNSTI4 0
NEI4 $851
line 1735
;1735:			{
line 1736
;1736:				ret = GetToken(token, &fsptr);
ADDRLP4 0
ARGP4
ADDRGP4 $543
ARGP4
ADDRLP4 18088
ADDRGP4 GetToken
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 18088
INDIRI4
ASGNI4
line 1737
;1737:				if(ret != T_TOKEN || token[0] < 0x30 || token[0] > 0x39)
ADDRLP4 1028
INDIRI4
CNSTI4 5
NEI4 $857
ADDRLP4 18092
ADDRLP4 0
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 18092
INDIRI4
CNSTI4 48
LTI4 $857
ADDRLP4 18092
INDIRI4
CNSTI4 57
LEI4 $854
LABELV $857
line 1738
;1738:				{
line 1739
;1739:					CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! textstyle command requires an integer value (0 or 1)", ch_file.string);
ADDRGP4 $858
ARGP4
ADDRGP4 ch_file+16
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1740
;1740:					hud_count = index;
ADDRGP4 hud_count
ADDRLP4 1036
INDIRI4
ASGNI4
line 1741
;1741:					return;
ADDRGP4 $542
JUMPV
LABELV $854
line 1744
;1742:				}
;1743:
;1744:				if(cmdi == DEFAULT)
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $860
line 1745
;1745:					default_info.textstyle = atoi(token);
ADDRLP4 0
ARGP4
ADDRLP4 18096
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1040+175
ADDRLP4 18096
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
ADDRGP4 $852
JUMPV
LABELV $860
line 1747
;1746:				else
;1747:					hud[index].textstyle = atoi(token);
ADDRLP4 0
ARGP4
ADDRLP4 18100
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTI4 504
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud+175
ADDP4
ADDRLP4 18100
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 1748
;1748:			}
ADDRGP4 $852
JUMPV
LABELV $851
line 1749
;1749:			else if(!Q_stricmp(token, "time"))
ADDRLP4 0
ARGP4
ADDRGP4 $866
ARGP4
ADDRLP4 18088
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 18088
INDIRI4
CNSTI4 0
NEI4 $864
line 1750
;1750:			{
line 1751
;1751:				ret = GetToken(token, &fsptr);
ADDRLP4 0
ARGP4
ADDRGP4 $543
ARGP4
ADDRLP4 18092
ADDRGP4 GetToken
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 18092
INDIRI4
ASGNI4
line 1752
;1752:				if(ret != T_TOKEN || (token[0] < 0x30 && token[0] != 0x2d) || token[0] > 0x39)
ADDRLP4 1028
INDIRI4
CNSTI4 5
NEI4 $870
ADDRLP4 18096
ADDRLP4 0
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 18096
INDIRI4
CNSTI4 48
GEI4 $871
ADDRLP4 18096
INDIRI4
CNSTI4 45
NEI4 $870
LABELV $871
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 57
LEI4 $867
LABELV $870
line 1753
;1753:				{
line 1754
;1754:					CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! time command requires an integer value", ch_file.string);
ADDRGP4 $872
ARGP4
ADDRGP4 ch_file+16
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1755
;1755:					hud_count = index;
ADDRGP4 hud_count
ADDRLP4 1036
INDIRI4
ASGNI4
line 1756
;1756:					return;
ADDRGP4 $542
JUMPV
LABELV $867
line 1759
;1757:				}
;1758:
;1759:				if(cmdi == DEFAULT)
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $874
line 1760
;1760:					default_info.time = atoi(token);
ADDRLP4 0
ARGP4
ADDRLP4 18100
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1040+168
ADDRLP4 18100
INDIRI4
ASGNI4
ADDRGP4 $865
JUMPV
LABELV $874
line 1762
;1761:				else
;1762:					hud[index].time = atoi(token);
ADDRLP4 0
ARGP4
ADDRLP4 18104
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTI4 504
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud+168
ADDP4
ADDRLP4 18104
INDIRI4
ASGNI4
line 1763
;1763:			}
ADDRGP4 $865
JUMPV
LABELV $864
line 1764
;1764:			else if(!Q_stricmp(token, "model"))
ADDRLP4 0
ARGP4
ADDRGP4 $880
ARGP4
ADDRLP4 18092
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 18092
INDIRI4
CNSTI4 0
NEI4 $878
line 1765
;1765:			{
line 1766
;1766:				ret = GetToken(token, &fsptr);
ADDRLP4 0
ARGP4
ADDRGP4 $543
ARGP4
ADDRLP4 18096
ADDRGP4 GetToken
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 18096
INDIRI4
ASGNI4
line 1767
;1767:				if(ret != T_STRING)
ADDRLP4 1028
INDIRI4
CNSTI4 4
EQI4 $881
line 1768
;1768:				{
line 1769
;1769:					CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! image command requires an image file to be specified", ch_file.string);
ADDRGP4 $769
ARGP4
ADDRGP4 ch_file+16
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1770
;1770:					hud_count = index;
ADDRGP4 hud_count
ADDRLP4 1036
INDIRI4
ASGNI4
line 1771
;1771:					return;
ADDRGP4 $542
JUMPV
LABELV $881
line 1774
;1772:				}
;1773:
;1774:				if(cmdi == DEFAULT)
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $884
line 1775
;1775:					default_info.model = trap_R_RegisterModel(token);
ADDRLP4 0
ARGP4
ADDRLP4 18100
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 1040+500
ADDRLP4 18100
INDIRI4
ASGNI4
ADDRGP4 $879
JUMPV
LABELV $884
line 1777
;1776:				else
;1777:					hud[index].model = trap_R_RegisterModel(token);
ADDRLP4 0
ARGP4
ADDRLP4 18104
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
CNSTI4 504
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud+500
ADDP4
ADDRLP4 18104
INDIRI4
ASGNI4
line 1778
;1778:			}
ADDRGP4 $879
JUMPV
LABELV $878
line 1779
;1779:			else if(!Q_stricmp(token, "angles"))
ADDRLP4 0
ARGP4
ADDRGP4 $890
ARGP4
ADDRLP4 18096
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 18096
INDIRI4
CNSTI4 0
NEI4 $888
line 1780
;1780:			{
line 1781
;1781:				for(i = 0; i < 3; i++)
ADDRLP4 1024
CNSTI4 0
ASGNI4
LABELV $891
line 1782
;1782:				{
line 1783
;1783:					ret = GetToken(token, &fsptr);
ADDRLP4 0
ARGP4
ADDRGP4 $543
ARGP4
ADDRLP4 18100
ADDRGP4 GetToken
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 18100
INDIRI4
ASGNI4
line 1784
;1784:					if(ret != T_TOKEN || token[0] < 0x2d || token[0] > 0x39 || token[0] == 0x2f)
ADDRLP4 1028
INDIRI4
CNSTI4 5
NEI4 $899
ADDRLP4 18104
ADDRLP4 0
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 18104
INDIRI4
CNSTI4 45
LTI4 $899
ADDRLP4 18104
INDIRI4
CNSTI4 57
GTI4 $899
ADDRLP4 18104
INDIRI4
CNSTI4 47
NEI4 $895
LABELV $899
line 1785
;1785:					{
line 1786
;1786:						CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! angles command requires 3 float values", ch_file.string);
ADDRGP4 $900
ARGP4
ADDRGP4 ch_file+16
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1787
;1787:						hud_count = index;
ADDRGP4 hud_count
ADDRLP4 1036
INDIRI4
ASGNI4
line 1788
;1788:						return;
ADDRGP4 $542
JUMPV
LABELV $895
line 1791
;1789:					}
;1790:
;1791:					if(cmdi == DEFAULT)
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $902
line 1792
;1792:						default_info.angles[i] = atof(token);
ADDRLP4 0
ARGP4
ADDRLP4 18108
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 1024
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1040+116
ADDP4
ADDRLP4 18108
INDIRF4
ASGNF4
ADDRGP4 $903
JUMPV
LABELV $902
line 1794
;1793:					else
;1794:						hud[index].angles[i] = atof(token);
ADDRLP4 0
ARGP4
ADDRLP4 18112
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 1024
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 504
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud+116
ADDP4
ADDP4
ADDRLP4 18112
INDIRF4
ASGNF4
LABELV $903
line 1795
;1795:				}
LABELV $892
line 1781
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 3
LTI4 $891
line 1797
;1796:
;1797:				ret = GetToken(token, &fsptr);
ADDRLP4 0
ARGP4
ADDRGP4 $543
ARGP4
ADDRLP4 18100
ADDRGP4 GetToken
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 18100
INDIRI4
ASGNI4
line 1798
;1798:				if(ret != T_TOKEN || token[0] < 0x2d || token[0] > 0x39 || token[0] == 0x2f)
ADDRLP4 1028
INDIRI4
CNSTI4 5
NEI4 $910
ADDRLP4 18104
ADDRLP4 0
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 18104
INDIRI4
CNSTI4 45
LTI4 $910
ADDRLP4 18104
INDIRI4
CNSTI4 57
GTI4 $910
ADDRLP4 18104
INDIRI4
CNSTI4 47
NEI4 $906
LABELV $910
line 1799
;1799:					fsptr -= strlen(token);
ADDRLP4 0
ARGP4
ADDRLP4 18108
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 18112
ADDRGP4 $543
ASGNP4
ADDRLP4 18112
INDIRP4
ADDRLP4 18112
INDIRP4
INDIRP4
ADDRLP4 18108
INDIRI4
SUBP4
ASGNP4
ADDRGP4 $889
JUMPV
LABELV $906
line 1801
;1800:				else
;1801:				{
line 1802
;1802:					if(cmdi == DEFAULT)
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $911
line 1803
;1803:						default_info.angles[3] = atof(token);
ADDRLP4 0
ARGP4
ADDRLP4 18116
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 1040+116+12
ADDRLP4 18116
INDIRF4
ASGNF4
ADDRGP4 $889
JUMPV
LABELV $911
line 1805
;1804:					else
;1805:						hud[index].angles[3] = atof(token);
ADDRLP4 0
ARGP4
ADDRLP4 18120
ADDRGP4 atof
CALLF4
ASGNF4
CNSTI4 504
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud+116+12
ADDP4
ADDRLP4 18120
INDIRF4
ASGNF4
line 1806
;1806:				}
line 1807
;1807:			}
ADDRGP4 $889
JUMPV
LABELV $888
line 1808
;1808:			else if(!Q_stricmp(token, "offset"))
ADDRLP4 0
ARGP4
ADDRGP4 $919
ARGP4
ADDRLP4 18100
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 18100
INDIRI4
CNSTI4 0
NEI4 $917
line 1809
;1809:			{
line 1810
;1810:				for(i = 0; i < 3; i++)
ADDRLP4 1024
CNSTI4 0
ASGNI4
LABELV $920
line 1811
;1811:				{
line 1812
;1812:					ret = GetToken(token, &fsptr);
ADDRLP4 0
ARGP4
ADDRGP4 $543
ARGP4
ADDRLP4 18104
ADDRGP4 GetToken
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 18104
INDIRI4
ASGNI4
line 1813
;1813:					if(ret != T_TOKEN || token[0] < 0x2d || token[0] > 0x39 || token[0] == 0x2f)
ADDRLP4 1028
INDIRI4
CNSTI4 5
NEI4 $928
ADDRLP4 18108
ADDRLP4 0
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 18108
INDIRI4
CNSTI4 45
LTI4 $928
ADDRLP4 18108
INDIRI4
CNSTI4 57
GTI4 $928
ADDRLP4 18108
INDIRI4
CNSTI4 47
NEI4 $924
LABELV $928
line 1814
;1814:					{
line 1815
;1815:						CG_Printf(""S_COLOR_RED"ERROR: Loading HUD file %s failed! offset command requires 3 float values", ch_file.string);
ADDRGP4 $929
ARGP4
ADDRGP4 ch_file+16
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1816
;1816:						hud_count = index;
ADDRGP4 hud_count
ADDRLP4 1036
INDIRI4
ASGNI4
line 1817
;1817:						return;
ADDRGP4 $542
JUMPV
LABELV $924
line 1820
;1818:					}
;1819:
;1820:					if(cmdi == DEFAULT)
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $931
line 1821
;1821:						default_info.offset[i] = atof(token);
ADDRLP4 0
ARGP4
ADDRLP4 18112
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 1024
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1040+132
ADDP4
ADDRLP4 18112
INDIRF4
ASGNF4
ADDRGP4 $932
JUMPV
LABELV $931
line 1823
;1822:					else
;1823:						hud[index].offset[i] = atof(token);
ADDRLP4 0
ARGP4
ADDRLP4 18116
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 1024
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 504
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud+132
ADDP4
ADDP4
ADDRLP4 18116
INDIRF4
ASGNF4
LABELV $932
line 1824
;1824:				}
LABELV $921
line 1810
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 3
LTI4 $920
line 1825
;1825:			}
ADDRGP4 $918
JUMPV
LABELV $917
line 1826
;1826:			else if(!Q_stricmp(token, "draw"))
ADDRLP4 0
ARGP4
ADDRGP4 $937
ARGP4
ADDRLP4 18104
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 18104
INDIRI4
CNSTI4 0
NEI4 $935
line 1827
;1827:			{
line 1828
;1828:				if(cmdi == DEFAULT)
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $938
line 1829
;1829:					default_info.draw = qtrue;
ADDRLP4 1040+48
CNSTI4 1
ASGNI4
ADDRGP4 $936
JUMPV
LABELV $938
line 1831
;1830:				else
;1831:					hud[index].draw = qtrue;
CNSTI4 504
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud+48
ADDP4
CNSTI4 1
ASGNI4
line 1832
;1832:			}
ADDRGP4 $936
JUMPV
LABELV $935
line 1833
;1833:			else if(!Q_stricmp(token, "draw3d"))
ADDRLP4 0
ARGP4
ADDRGP4 $944
ARGP4
ADDRLP4 18108
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 18108
INDIRI4
CNSTI4 0
NEI4 $942
line 1834
;1834:			{
line 1835
;1835:				if(cmdi == DEFAULT)
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $945
line 1836
;1836:					default_info.draw3d = qtrue;
ADDRLP4 1040+52
CNSTI4 1
ASGNI4
ADDRGP4 $946
JUMPV
LABELV $945
line 1838
;1837:				else
;1838:					hud[index].draw3d = qtrue;
CNSTI4 504
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 hud+52
ADDP4
CNSTI4 1
ASGNI4
LABELV $946
line 1839
;1839:			}
LABELV $942
LABELV $936
LABELV $918
LABELV $889
LABELV $879
LABELV $865
LABELV $852
LABELV $822
LABELV $811
LABELV $793
LABELV $786
LABELV $765
LABELV $735
LABELV $714
LABELV $707
LABELV $689
LABELV $682
LABELV $652
LABELV $622
line 1840
;1840:		}
LABELV $607
line 1439
ADDRGP4 $543
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $606
LABELV $608
line 1842
;1841:
;1842:		if(cmdi != DEFAULT)
ADDRLP4 1032
INDIRI4
CNSTI4 1
EQI4 $949
line 1843
;1843:			index++;
ADDRLP4 1036
ADDRLP4 1036
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $949
line 1844
;1844:	}
LABELV $583
line 1400
ADDRGP4 $543
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $582
LABELV $584
line 1846
;1845:
;1846:	hud_count = index;
ADDRGP4 hud_count
ADDRLP4 1036
INDIRI4
ASGNI4
line 1847
;1847:}
LABELV $542
endproc ParseHud 18124 16
export CG_forceBackwards_f
proc CG_forceBackwards_f 0 0
line 1853
;1848://Superhud - End
;1849:
;1850://static void CG_Help_f(void) {
;1851://	ParseHelp("config/help/english.cfg");
;1852://}
;1853:void CG_forceBackwards_f () {
line 1854
;1854:	cg.eventAdjustment = qtrue;
ADDRGP4 cg+170852
CNSTI4 1
ASGNI4
line 1855
;1855:}
LABELV $951
endproc CG_forceBackwards_f 0 0
export CG_dbgScoreboard_f
proc CG_dbgScoreboard_f 0 0
line 1856
;1856:void CG_dbgScoreboard_f () {
line 1857
;1857:	cg.dbgScoreboard?(cg.dbgScoreboard=qfalse):(cg.dbgScoreboard=qtrue);
ADDRGP4 cg+170856
INDIRI4
CNSTI4 0
EQI4 $958
ADDRGP4 cg+170856
CNSTI4 0
ASGNI4
ADDRGP4 $959
JUMPV
LABELV $958
ADDRGP4 cg+170856
CNSTI4 1
ASGNI4
LABELV $959
line 1858
;1858:}
LABELV $953
endproc CG_dbgScoreboard_f 0 0
proc CG_Say_f 296 16
line 1860
;1859:
;1860:static void CG_Say_f ( void ) {
line 1864
;1861:	char	text[MAX_SAY_TEXT];
;1862:	char	cmd[32];
;1863:
;1864:	Com_sprintf(text, sizeof(text), "%s", ConcatArgs(1));
CNSTI4 1
ARGI4
ADDRLP4 288
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $961
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1865
;1865:	trap_Argv( 0, cmd, sizeof( cmd ) );
CNSTI4 0
ARGI4
ADDRLP4 256
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1866
;1866:	trap_SendClientCommand( va("%s %s\n", cmd, text) );
ADDRGP4 $962
ARGP4
ADDRLP4 256
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 292
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 292
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 1867
;1867:}
LABELV $960
endproc CG_Say_f 296 16
data
align 4
LABELV commands
address $964
address CG_TestGun_f
address $965
address CG_TestModel_f
address $966
address CG_TestModelNextFrame_f
address $967
address CG_TestModelPrevFrame_f
address $968
address CG_TestModelNextSkin_f
address $969
address CG_TestModelPrevSkin_f
address $970
address CG_Viewpos_f
address $971
address CG_ScoresDown_f
address $972
address CG_ScoresUp_f
address $973
address CG_ZoomDown_f
address $974
address CG_ZoomUp_f
address $975
address CG_SizeUp_f
address $976
address CG_SizeDown_f
address $977
address CG_NextWeapon_f
address $978
address CG_PrevWeapon_f
address $979
address CG_Weapon_f
address $980
address CG_TellTarget_f
address $981
address CG_TellAttacker_f
address $982
address CG_VoiceTellTarget_f
address $983
address CG_VoiceTellAttacker_f
address $984
address CG_TargetCommand_f
address $154
address CG_Ready_f
address $170
address CG_Notready_f
address $985
address CG_StartOrbit_f
address $986
address CG_LoadDeferredPlayers
address $198
address CG_TossFlag_f
address $987
address CG_TimeOut_f
address $988
address CG_Timein_f
address $989
address CG_Speedometer_f
address $990
address CG_Speedometer_f
address $991
address CG_Speedometer_f
address $992
address CG_Speedometer_f
address $993
address CG_OBDetector_f
address $994
address CG_OBDetector_f
address $995
address CG_OBDetector_f
address $996
address CG_Weaponsidebar_f
address $997
address CG_Weaponsidebar_f
address $998
address CG_Weaponsidebar_f
address $999
address CG_KeyPress_f
address $1000
address CG_KeyPress_f
address $1001
address CG_KeyPress_f
address $1002
address CG_KeyPress_f
address $1003
address CG_KeyPress_f
address $1004
address CG_HelpSystem_f
address $1005
address CG_SetAlarm_f
address $1006
address ParseHud
address $1007
address CG_resetMaxSpeed_f
address $1008
address CG_forceBackwards_f
address $1009
address CG_dbgScoreboard_f
export CG_ConsoleCommand
code
proc CG_ConsoleCommand 16 8
line 1969
;1868:
;1869:typedef struct {
;1870:	char	*cmd;
;1871:	void	(*function)(void);
;1872:} consoleCommand_t;
;1873:
;1874:static consoleCommand_t	commands[] = {
;1875:	{ "testgun", CG_TestGun_f },
;1876:	{ "testmodel", CG_TestModel_f },
;1877:	{ "nextframe", CG_TestModelNextFrame_f },
;1878:	{ "prevframe", CG_TestModelPrevFrame_f },
;1879:	{ "nextskin", CG_TestModelNextSkin_f },
;1880:	{ "prevskin", CG_TestModelPrevSkin_f },
;1881:	{ "viewpos", CG_Viewpos_f },
;1882:	{ "+scores", CG_ScoresDown_f },
;1883:	{ "-scores", CG_ScoresUp_f },
;1884:	{ "+zoom", CG_ZoomDown_f },
;1885:	{ "-zoom", CG_ZoomUp_f },
;1886:	{ "sizeup", CG_SizeUp_f },
;1887:	{ "sizedown", CG_SizeDown_f },
;1888:	{ "weapnext", CG_NextWeapon_f },
;1889:	{ "weapprev", CG_PrevWeapon_f },
;1890:	{ "weapon", CG_Weapon_f },
;1891:	{ "tell_target", CG_TellTarget_f },
;1892:	{ "tell_attacker", CG_TellAttacker_f },
;1893:	{ "vtell_target", CG_VoiceTellTarget_f },
;1894:	{ "vtell_attacker", CG_VoiceTellAttacker_f },
;1895:	{ "tcmd", CG_TargetCommand_f },
;1896:	{ "ready", CG_Ready_f },//Zero: Ready up.
;1897:	{ "notready", CG_Notready_f },//Zero: "I'm not ready anymore..." Must be a virgin.
;1898:#ifdef MISSIONPACK
;1899:	{ "loadhud", CG_LoadHud_f },
;1900:	{ "nextTeamMember", CG_NextTeamMember_f },
;1901:	{ "prevTeamMember", CG_PrevTeamMember_f },
;1902:	{ "nextOrder", CG_NextOrder_f },
;1903:	{ "confirmOrder", CG_ConfirmOrder_f },
;1904:	{ "denyOrder", CG_DenyOrder_f },
;1905:	{ "taskOffense", CG_TaskOffense_f },
;1906:	{ "taskDefense", CG_TaskDefense_f },
;1907:	{ "taskPatrol", CG_TaskPatrol_f },
;1908:	{ "taskCamp", CG_TaskCamp_f },
;1909:	{ "taskFollow", CG_TaskFollow_f },
;1910:	{ "taskRetrieve", CG_TaskRetrieve_f },
;1911:	{ "taskEscort", CG_TaskEscort_f },
;1912:	{ "taskSuicide", CG_TaskSuicide_f },
;1913:	{ "taskOwnFlag", CG_TaskOwnFlag_f },
;1914:	{ "tauntKillInsult", CG_TauntKillInsult_f },
;1915:	{ "tauntPraise", CG_TauntPraise_f },
;1916:	{ "tauntTaunt", CG_TauntTaunt_f },
;1917:	{ "tauntDeathInsult", CG_TauntDeathInsult_f },
;1918:	{ "tauntGauntlet", CG_TauntGauntlet_f },
;1919:	{ "spWin", CG_spWin_f },
;1920:	{ "spLose", CG_spLose_f },
;1921:	{ "scoresDown", CG_scrollScoresDown_f },
;1922:	{ "scoresUp", CG_scrollScoresUp_f },
;1923:#endif
;1924:	{ "startOrbit", CG_StartOrbit_f },
;1925:	//{ "camera", CG_Camera_f },
;1926:	{ "loaddeferred", CG_LoadDeferredPlayers },
;1927:	{ "tossflag", CG_TossFlag_f },
;1928:	{ "timeout", CG_TimeOut_f },
;1929:	{ "timein", CG_Timein_f },
;1930:	/*{ "unlockTeam", CG_unlockTeam_f },
;1931:	{ "lockTeam", CG_lockTeam_f },*/
;1932:	{ "cg_drawSpeedometer", CG_Speedometer_f },
;1933:	{ "cg_Speedometer", CG_Speedometer_f },
;1934:	{ "cg_drawUPS", CG_Speedometer_f },
;1935:	{ "speedometer", CG_Speedometer_f },
;1936:	{ "cg_OBDetector", CG_OBDetector_f },
;1937:	{ "cg_drawOBDetector", CG_OBDetector_f },
;1938:	{ "obdetector", CG_OBDetector_f },
;1939:	{ "cg_drawWeaponSideBar", CG_Weaponsidebar_f },
;1940:	{ "cg_WeaponSideBar", CG_Weaponsidebar_f },
;1941:	{ "weaponsidebar", CG_Weaponsidebar_f },
;1942:	{ "viewkeys", CG_KeyPress_f },
;1943:	{ "cg_viewkeypress", CG_KeyPress_f },
;1944:	{ "keypress", CG_KeyPress_f },
;1945:	{ "keypresses", CG_KeyPress_f },
;1946:	{ "viewkeypress", CG_KeyPress_f },
;1947:	{ "help", CG_HelpSystem_f },
;1948:	{ "alarm", CG_SetAlarm_f },
;1949:	//{ "dbgrws", CG_DbgRWS_f },
;1950:	//{ "dbgsto", CG_DbgRWS_f },
;1951:	//Superhud - Begin
;1952:	{ "reloadHUD", ParseHud },
;1953:	{ "resetMaxSpeed", CG_resetMaxSpeed_f },
;1954:	{ "forceBackwards", CG_forceBackwards_f },
;1955:	{ "dbgScoreboard", CG_dbgScoreboard_f }
;1956:	//Superhud - End
;1957:
;1958:};
;1959:
;1960:
;1961:/*
;1962:=================
;1963:CG_ConsoleCommand
;1964:
;1965:The string has been tokenized and can be retrieved with
;1966:Cmd_Argc() / Cmd_Argv()
;1967:=================
;1968:*/
;1969:qboolean CG_ConsoleCommand( void ) {
line 1973
;1970:	const char	*cmd;
;1971:	int		i;
;1972:
;1973:	cmd = CG_Argv(0);
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 1975
;1974:
;1975:	for ( i = 0 ; i < sizeof( commands ) / sizeof( commands[0] ) ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1014
JUMPV
LABELV $1011
line 1976
;1976:		if ( !Q_stricmp( cmd, commands[i].cmd ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 commands
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $1015
line 1977
;1977:			commands[i].function();
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 commands+4
ADDP4
INDIRP4
CALLV
pop
line 1978
;1978:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1010
JUMPV
LABELV $1015
line 1980
;1979:		}
;1980:	}
LABELV $1012
line 1975
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1014
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 49
LTU4 $1011
line 1982
;1981:
;1982:	return qfalse;
CNSTI4 0
RETI4
LABELV $1010
endproc CG_ConsoleCommand 16 8
export CG_InitConsoleCommands
proc CG_InitConsoleCommands 4 4
line 1994
;1983:}
;1984:
;1985:
;1986:/*
;1987:=================
;1988:CG_InitConsoleCommands
;1989:
;1990:Let the client system know about all of our commands
;1991:so it can perform tab completion
;1992:=================
;1993:*/
;1994:void CG_InitConsoleCommands( void ) {
line 1997
;1995:	int		i;
;1996:
;1997:	for ( i = 0 ; i < sizeof( commands ) / sizeof( commands[0] ) ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1022
JUMPV
LABELV $1019
line 1998
;1998:		trap_AddCommand( commands[i].cmd );
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 commands
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 1999
;1999:	}
LABELV $1020
line 1997
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1022
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 49
LTU4 $1019
line 2005
;2000:
;2001:	//
;2002:	// the game server will interpret these commands, which will be automatically
;2003:	// forwarded to the server after they are not recognized locally
;2004:	//
;2005:	trap_AddCommand ("kill");
ADDRGP4 $1023
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2006
;2006:	trap_AddCommand ("say");//This should be a client command to make sure everything get null terminated
ADDRGP4 $1024
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2007
;2007:	trap_AddCommand ("say_team");//This should be a client command to make sure everything get null terminated
ADDRGP4 $1025
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2008
;2008:	trap_AddCommand ("tell");
ADDRGP4 $1026
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2009
;2009:	trap_AddCommand ("vsay");
ADDRGP4 $1027
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2010
;2010:	trap_AddCommand ("vsay_team");
ADDRGP4 $1028
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2011
;2011:	trap_AddCommand ("vtell");
ADDRGP4 $1029
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2012
;2012:	trap_AddCommand ("vtaunt");
ADDRGP4 $1030
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2013
;2013:	trap_AddCommand ("vosay");
ADDRGP4 $1031
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2014
;2014:	trap_AddCommand ("vosay_team");
ADDRGP4 $1032
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2015
;2015:	trap_AddCommand ("votell");
ADDRGP4 $1033
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2016
;2016:	trap_AddCommand ("give");
ADDRGP4 $1034
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2017
;2017:	trap_AddCommand ("god");
ADDRGP4 $1035
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2018
;2018:	trap_AddCommand ("notarget");
ADDRGP4 $1036
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2019
;2019:	trap_AddCommand ("noclip");
ADDRGP4 $1037
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2020
;2020:	trap_AddCommand ("team");
ADDRGP4 $1038
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2021
;2021:	trap_AddCommand ("follow");
ADDRGP4 $1039
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2022
;2022:	trap_AddCommand ("levelshot");
ADDRGP4 $1040
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2023
;2023:	trap_AddCommand ("addbot");
ADDRGP4 $1041
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2024
;2024:	trap_AddCommand ("setviewpos");
ADDRGP4 $1042
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2025
;2025:	trap_AddCommand ("callvote");
ADDRGP4 $1043
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2026
;2026:	trap_AddCommand ("vote");
ADDRGP4 $1044
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2027
;2027:	trap_AddCommand ("callteamvote");
ADDRGP4 $1045
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2028
;2028:	trap_AddCommand ("teamvote");
ADDRGP4 $1046
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2029
;2029:	trap_AddCommand ("stats");
ADDRGP4 $1047
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2030
;2030:	trap_AddCommand ("teamtask");
ADDRGP4 $1048
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2031
;2031:	trap_AddCommand ("loaddefered");	// spelled wrong, but not changing for demo
ADDRGP4 $1049
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2032
;2032:	trap_AddCommand ("help");
ADDRGP4 $1004
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2033
;2033:	trap_AddCommand ("players");
ADDRGP4 $1050
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2034
;2034:	trap_AddCommand ("maplist");
ADDRGP4 $1051
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2035
;2035:	trap_AddCommand ("load");
ADDRGP4 $1052
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2036
;2036:	trap_AddCommand ("save");
ADDRGP4 $1053
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2037
;2037:	trap_AddCommand ("admin");
ADDRGP4 $1054
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2038
;2038:	trap_AddCommand ("adminPassword");
ADDRGP4 $1055
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2039
;2039:	trap_AddCommand ("mutestatus");
ADDRGP4 $1056
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2040
;2040:	trap_AddCommand ("quickmodes");
ADDRGP4 $1057
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2041
;2041:	trap_AddCommand ("teams");
ADDRGP4 $1058
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2042
;2042:	trap_AddCommand ("lock");//FIXME: Should be made 'smarter' so it isn't sent when in spec or when teams aren't lockable.
ADDRGP4 $1059
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2043
;2043:	trap_AddCommand ("unlock");//FIXME: Should be made 'smarter' so it isn't sent when in spec or when teams aren't lockable.
ADDRGP4 $1060
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2045
;2044:	//trap_AddCommand ("dbgflags");
;2045:	trap_AddCommand ("motd");
ADDRGP4 $1061
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2046
;2046:	trap_AddCommand("altConsoleSayMode");
ADDRGP4 $1062
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 2047
;2047:}
LABELV $1018
endproc CG_InitConsoleCommands 4 4
import trap_PC_SourceFileAndLine
import trap_PC_ReadToken
import trap_PC_FreeSource
import trap_PC_LoadSource
import trap_PC_AddGlobalDefine
import Controls_SetDefaults
import Controls_SetConfig
import Controls_GetConfig
import UI_OutOfMemory
import UI_InitMemory
import UI_Alloc
import Display_CacheAll
import Menu_SetFeederSelection
import Menu_Paint
import Menus_CloseAll
import LerpColor
import Display_HandleKey
import Menus_CloseByName
import Menus_ShowByName
import Menus_FindByName
import Menus_OpenByName
import Display_KeyBindPending
import Display_CursorType
import Display_MouseMove
import Display_CaptureItem
import Display_GetContext
import Menus_Activate
import Menus_AnyFullScreenVisible
import Menu_Reset
import Menus_ActivateByName
import Menu_PaintAll
import Menu_New
import Menu_Count
import PC_Script_Parse
import PC_String_Parse
import PC_Rect_Parse
import PC_Int_Parse
import PC_Color_Parse
import PC_Float_Parse
import Script_Parse
import String_Parse
import Rect_Parse
import Int_Parse
import Color_Parse
import Float_Parse
import Menu_ScrollFeeder
import Menu_HandleMouseMove
import Menu_HandleKey
import Menu_GetFocused
import Menu_PostParse
import Item_Init
import Menu_Init
import Display_ExpandMacros
import Init_Display
import String_Report
import String_Init
import String_Alloc
import trap_Trace
import CG_NewParticleArea
import initparticles
import CG_ParticleExplosion
import CG_ParticleMisc
import CG_ParticleDust
import CG_ParticleSparks
import CG_ParticleBulletDebris
import CG_ParticleSnowFlurry
import CG_AddParticleShrapnel
import CG_ParticleSmoke
import CG_ParticleSnow
import CG_AddParticles
import CG_ClearParticles
import trap_GetEntityToken
import trap_getCameraInfo
import trap_startCamera
import trap_loadCamera
import trap_SnapVector
import trap_CIN_SetExtents
import trap_CIN_DrawCinematic
import trap_CIN_RunCinematic
import trap_CIN_StopCinematic
import trap_CIN_PlayCinematic
import trap_RealTime
import trap_Key_GetKey
import trap_Key_SetCatcher
import trap_Key_GetCatcher
import trap_Key_IsDown
import trap_R_RegisterFont
import trap_MemoryRemaining
import testPrintFloat
import testPrintInt
import trap_SetUserCmdValue
import trap_GetUserCmd
import trap_GetCurrentCmdNumber
import trap_GetServerCommand
import trap_GetSnapshot
import trap_GetCurrentSnapshotNumber
import trap_GetGameState
import trap_GetGlconfig
import trap_R_RemapShader
import trap_R_LerpTag
import trap_R_ModelBounds
import trap_R_DrawStretchPic
import trap_R_SetColor
import trap_R_RenderScene
import trap_R_LightForPoint
import trap_R_AddLightToScene
import trap_R_AddPolysToScene
import trap_R_AddPolyToScene
import trap_R_AddRefEntityToScene
import trap_R_ClearScene
import trap_R_RegisterShaderNoMip
import trap_R_RegisterShader
import trap_R_RegisterSkin
import trap_R_RegisterModel
import trap_R_LoadWorldMap
import trap_S_StopBackgroundTrack
import trap_S_StartBackgroundTrack
import trap_S_RegisterSound
import trap_S_Respatialize
import trap_S_UpdateEntityPosition
import trap_S_AddRealLoopingSound
import trap_S_AddLoopingSound
import trap_S_ClearLoopingSounds
import trap_S_StartLocalSound
import trap_S_StopLoopingSound
import trap_S_StartSound
import trap_CM_MarkFragments
import trap_CM_TransformedBoxTrace
import trap_CM_BoxTrace
import trap_CM_TransformedPointContents
import trap_CM_PointContents
import trap_CM_TempBoxModel
import trap_CM_InlineModel
import trap_CM_NumInlineModels
import trap_CM_LoadMap
import trap_UpdateScreen
import trap_SendClientCommand
import trap_AddCommand
import trap_SendConsoleCommand
import trap_FS_Seek
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_Args
import trap_Cvar_VariableStringBuffer
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_Milliseconds
import trap_Error
import trap_Print
import CG_AddGib
import Q_Isfreeze
import CG_BodyObituary
import CG_CheckChangedPredictableEvents
import CG_TransitionPlayerState
import CG_Respawn
import CG_PlayBufferedVoiceChats
import CG_VoiceChatLocal
import CG_ShaderStateChanged
import CG_LoadVoiceChats
import CG_SetConfigValues
import CG_ParseServerinfo
import CG_ExecuteNewServerCommands
import CG_DrawOldTourneyScoreboard
import CG_DrawNewScoreboard
import CG_DrawOldScoreboard
import CG_DrawInformation
import CG_LoadingClient
import CG_LoadingItem
import CG_LoadingString
import CG_TransitionEntity
import CG_ProcessSnapshots
import CG_MakeExplosion
import CG_Bleed
import CG_BigExplode
import CG_GibPlayer
import CG_ScorePlum
import CG_SpawnEffect
import CG_BubbleTrail
import CG_SmokePuff
import CG_AddLocalEntities
import CG_AllocLocalEntity
import CG_InitLocalEntities
import CG_ImpactMark
import CG_AddMarks
import CG_InitMarkPolys
import CG_OutOfAmmoChange
import CG_DrawWeaponSelect
import CG_AddPlayerWeapon
import CG_AddViewWeapon
import CG_GrappleTrail
import CG_RailTrail
import CG_Bullet
import CG_ShotgunFire
import CG_MissileHitPlayer
import CG_MissileHitWall
import CG_FireGrapple
import CG_FireWeapon
import CG_RegisterItemVisuals
import CG_RegisterWeapon
import CG_Weapon_f
import CG_PrevWeapon_f
import CG_NextWeapon_f
import CG_PositionRotatedEntityOnTag
import CG_PositionEntityOnTag
import CG_AdjustPositionForMover
import CG_Beam
import CG_AddPacketEntities
import CG_SetEntitySoundPosition
import CG_PainEvent
import CG_EntityEvent
import CG_PlaceString
import CG_CheckEvents
import CG_LoadDeferredPlayers
import CG_PredictPlayerState
import CG_Trace
import CG_PointContents
import CG_BuildSolidList
import CG_ParseColors
import isEnemy
import isTeammate
import CG_CustomSound
import CG_NewClientInfo
import CG_AddRefEntityWithPowerups
import CG_ResetPlayerEntity
import CG_Player
import CG_DrawOBs
import CG_ExtractToken
import CG_StatusHandle
import CG_OtherTeamHasFlag
import CG_YourTeamHasFlag
import CG_GameTypeString
import CG_CheckOrderPending
import CG_Text_PaintChar
import CG_Draw3DModel
import CG_GetKillerText
import CG_GetGameStatusText
import CG_GetTeamColor
import CG_InitTeamChat
import CG_SetPrintString
import CG_ShowResponseHead
import CG_RunMenuScript
import CG_OwnerDrawVisible
import CG_GetValue
import CG_SelectNextPlayer
import CG_SelectPrevPlayer
import CG_Text_Height
import CG_Text_Width
import CG_Text_Paint
import CG_OwnerDraw
import CG_DrawTeamBackground
import CG_DrawFlagModel
import CG_DrawActive
import CG_DrawHead
import CG_CenterPrint
import CG_AddLagometerSnapshotInfo
import CG_AddLagometerFrameInfo
import CG_DrawHud2D
import CG_ScanForCrosshairEntity
import CG_DrawTeamInfo
import CG_DrawSnapshot
import CG_DrawScoreboard
import CG_DrawReward
import CG_DrawKeyPress
import CG_DrawIntermission
import CG_DrawHoldableItem
import CG_DrawDisconnect
import CG_DrawCrosshair
import CG_DrawClock
import CG_DrawCenterString
import CG_Alarm
import CG_FigureHUDColor
import DrawMOTDBox
import teamChat2
import teamChat1
import systemChat
import drawTeamOverlayModificationCount
import numSortedTeamPlayers
import sortedTeamPlayers
import CG_DrawTopBottom
import CG_DrawSides
import CG_DrawRect
import UI_DrawProportionalString
import CG_GetColorForHealth
import CG_ColorForHealth
import CG_TileClear
import CG_TeamColor
import CG_FadeFromColorTo
import CG_FadeColor
import CG_DrawStrlen
import CG_DrawSmallStringColor
import CG_DrawSmallString
import CG_DrawBigStringColor
import CG_DrawBigString
import CG_DrawStringExt
import CG_DrawString
import CG_DrawPic
import CG_FillRect
import CG_AdjustFrom640
import CG_DrawActiveFrame
import CG_AddBufferedSound
import CG_ZoomUp_f
import CG_ZoomDown_f
import CG_TestModelPrevSkin_f
import CG_TestModelNextSkin_f
import CG_TestModelPrevFrame_f
import CG_TestModelNextFrame_f
import CG_TestGun_f
import CG_TestModel_f
import CG_BuildSpectatorString
import CG_GetSelectedScore
import CG_SetScoreSelection
import CG_RankRunFrame
import CG_EventHandling
import CG_MouseEvent
import CG_KeyEvent
import CG_LoadMenus
import CG_LastAttacker
import CG_CrosshairPlayer
import CG_UpdateCvars
import CG_StartMusic
import CG_Error
import CG_Printf
import CG_Argv
import CG_ConfigString
import CG_Cvar_ClampInt
import CG_AddBoundingBox
import CG_PredictWeaponEffects
import CG_GetFadeTime
import cg_itemFX
import cg_lightningImpact
import cg_smokeGrowth_RL
import cg_smokeGrowth_GL
import cg_smokeRadius_RL
import cg_smokeRadius_GL
import cg_smoke_SG
import cg_damageDraw
import cg_fallKick
import cg_fontFade
import cg_debugModels
import cg_blueName
import cg_redName
import ch_shadowOffset
import cg_oldScoreboard
import cg_crosshairPulse
import cg_autoRecord
import cg_autoScreenshot
import s_ambient
import s_announcer
import cg_noteamchatbeep
import cg_nochatbeep
import cg_railHum
import cg_fixedTeleporterAngles
import cg_fastRespawn_override
import cg_muzzleFlash
import cg_drawDeathMessage
import cg_aimNudge
import cg_aimType
import cg_fullWeaponCycle
import cl_timeNudge
import sex
import ch_viewKeyPress
import ch_weaponSideBar
import ch_OBDetector
import ch_Speedometer
import ch_file
import language
import cg_motdDisplayTime
import cg_optimizePrediction
import cg_projectileNudge
import sv_fps
import cg_drawBBox
import cg_debugDelag
import cg_delag
import cl_guid
import cl_maxpackets
import snaps
import com_maxfps
import cl_packetdup
import rate
import color2
import color1
import colors
import r_vertexLight
import cg_deadBodyDarken
import cg_adjustTeamColors
import cg_TeamColors
import cg_EnemyColors
import cg_forceColors
import cg_teamModel
import cg_enemyModel
import g_allowHandicap
import g_pro_mode
import g_delagHitscan
import g_gamemode
import g_allowReady
import g_fastSwitch
import g_interference
import g_DynamicGauntletCycle
import weap_bfgCycle
import weap_plasmagunCycle
import weap_railgunCycle
import weap_rocketlauncherCycle
import weap_lightninggunCycle
import weap_grenadelauncherCycle
import weap_shotgunCycle
import weap_machinegunCycle
import weap_gauntletCycle
import weap_enableHook
import cg_enableBreath
import cg_trueLightning
import cg_oldPlasma
import cg_oldRocket
import cg_railStyle
import cg_noProjectileTrail
import cg_noTaunt
import cg_bigFont
import cg_smallFont
import cg_cameraMode
import cg_timescale
import cg_timescaleFadeSpeed
import cg_timescaleFadeEnd
import cg_cameraOrbitDelay
import cg_cameraOrbit
import cg_pmove_fixed
import sv_lock_pmove
import pmove_msec
import pmove_fixed
import cg_smoothClients
import cg_scorePlum
import cg_noVoiceText
import cg_noVoiceChats
import cg_teamChatsOnly
import cg_drawFriend
import cg_deferPlayers
import cg_predictItems
import cg_blood
import cg_paused
import cg_buildScript
import cg_forceModel
import cg_stats
import cg_teamChatHeight
import cg_teamChatTime
import cg_synchronousClients
import cg_drawAttacker
import cg_lagometer
import cg_stereoSeparation
import cg_thirdPerson
import cg_thirdPersonAngle
import cg_thirdPersonRange
import cg_zoomFov
import cg_fov
import cg_simpleItems
import cg_ignore
import cg_autoswitch
import cg_tracerLength
import cg_tracerWidth
import cg_tracerChance
import cg_viewsize
import cg_drawGun
import cg_gun_z
import cg_gun_y
import cg_gun_x
import cg_gun_frame
import cg_brassTime
import cg_addMarks
import cg_footsteps
import cg_showmiss
import cg_noPlayerAnims
import cg_nopredict
import cg_errorDecay
import cg_railTrailTime
import cg_debugEvents
import cg_debugPosition
import cg_debugAnim
import cg_animSpeed
import cg_draw2D
import cg_drawStatus
import cg_crosshairHealth
import cg_crosshairColor
import cg_crosshairSize
import cg_crosshairY
import cg_crosshairX
import cg_drawTeamOverlay
import cg_drawRewards
import cg_drawCrosshairNames
import cg_drawCrosshair
import cg_drawAmmoWarning
import cg_drawIcons
import cg_draw3dIcons
import cg_drawSnapshot
import cg_drawFPS
import cg_drawClock
import cg_drawTimer
import cg_gibs
import cg_shadows
import cg_swingSpeed
import cg_bobroll
import cg_bobpitch
import cg_bobup
import cg_runroll
import cg_runpitch
import cg_centertime
import chat
import autoFile
import max_speed
import hud_count
import hud
import cg_markPolys
import cg_items
import cg_weapons
import cg_entities
import cg
import cgs
import lagometer
import forceModelModificationCount
import BG_ProModePlayerTouchesItem
import BG_PlayerTouchesItem
import BG_PlayerStateToEntityStateExtraPolate
import BG_PlayerStateToEntityState
import BG_TouchJumpPad
import BG_AddPredictableEventToPlayerstate
import BG_EvaluateTrajectoryDelta
import BG_EvaluateTrajectory
import BG_CanItemBeGrabbed
import BG_FindItemForHoldable
import BG_FindItemForPowerup
import BG_FindItemForWeapon
import BG_FindItem
import bg_numItems
import bg_itemlist
import Pmove
import PM_UpdateViewAngles
import Com_Printf
import Com_Error
import Info_NextPair
import Info_Validate
import Info_SetValueForKey_Big
import Info_SetValueForKey
import Info_RemoveKey_big
import Info_RemoveKey
import Info_ValueForKey
import va
import trap_FS_FOpenFile
import CG_FileExists
import findCharacter
import FixedName
import SanitizeString
import ConcatArgs
import trap_Argv
import trap_Argc
import Q_CopyStringUntil
import Q_CleanString
import Q_CleanStr
import Q_PrintStrlen
import Q_strcat
import Q_strncpyz
import Q_strrchr
import Q_strupr
import Q_strlwr
import Q_stricmpn
import Q_strncmp
import Q_stricmp
import Q_isalpha
import Q_isupper
import Q_islower
import Q_isprint
import Com_sprintf
import Parse3DMatrix
import Parse2DMatrix
import Parse1DMatrix
import SkipRestOfLine
import SkipBracedSection
import COM_MatchToken
import COM_ParseWarning
import COM_ParseError
import COM_Compress
import stristr
import HelpParse
import GetToken
import COM_ParseExt
import COM_Parse
import COM_GetCurrentParseLine
import COM_BeginParseSession
import COM_DefaultExtension
import COM_StripExtension
import COM_SkipPath
import Com_Clamp
import PerpendicularVector
import AngleVectors
import MatrixMultiply
import MakeNormalVectors
import RotateAroundDirection
import RotatePointAroundVector
import ProjectPointOnPlane
import PlaneFromPoints
import AngleDelta
import AngleNormalize180
import AngleNormalize360
import AnglesSubtract
import AngleSubtract
import LerpAngle
import AngleMod
import BoxOnPlaneSide
import SetPlaneSignbits
import AxisCopy
import AxisClear
import AnglesToAxis
import vectoangles
import Q_crandom
import Q_random
import Q_rand
import Q_acos
import Q_log2
import VectorRotate
import Vector4Scale
import VectorNormalize2
import VectorNormalize
import CrossProduct
import VectorInverse
import VectorNormalizeFast
import DistanceSquared
import Distance
import VectorLengthSquared
import VectorLength
import VectorCompare
import AddPointToBounds
import ClearBounds
import RadiusFromBounds
import NormalizeColor
import ColorBytes4
import ColorBytes3
import _VectorMA
import _VectorScale
import _VectorCopy
import _VectorAdd
import _VectorSubtract
import _DotProduct
import SnapVectorTowards
import ByteToDir
import DirToByte
import ClampShort
import ClampChar
import Q_rsqrt
import Q_fabs
import axisDefault
import vec3_origin
import g_color_table
import ColorIndex
import color_z
import color_y
import color_x
import color_w
import color_v
import color_u
import color_t
import color_s
import color_r
import color_q
import color_p
import color_o
import color_n
import color_m
import color_l
import color_k
import color_j
import color_i
import color_h
import color_g
import color_f
import color_e
import color_d
import color_c
import color_b
import color_a
import colorMdGrey
import colorOrange
import colorWhite
import colorCyan
import colorMagenta
import colorYellow
import colorBlue
import colorGreen
import colorRed
import colorBlack
import bytedirs
import Com_Memcpy
import Com_Memset
import Hunk_Alloc
import FloatSwap
import LongSwap
import ShortSwap
import acos
import fabs
import abs
import tan
import atan2
import cos
import sin
import sqrt
import floor
import ceil
import memcpy
import memset
import memmove
import sscanf
import vsprintf
import _atoi
import atoi
import _atof
import atof
import toupper
import tolower
import strncpy
import strstr
import strchr
import strcmp
import strcpy
import strcat
import strlen
import rand
import srand
import qsort
lit
align 1
LABELV $1062
byte 1 97
byte 1 108
byte 1 116
byte 1 67
byte 1 111
byte 1 110
byte 1 115
byte 1 111
byte 1 108
byte 1 101
byte 1 83
byte 1 97
byte 1 121
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $1061
byte 1 109
byte 1 111
byte 1 116
byte 1 100
byte 1 0
align 1
LABELV $1060
byte 1 117
byte 1 110
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $1059
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $1058
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $1057
byte 1 113
byte 1 117
byte 1 105
byte 1 99
byte 1 107
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $1056
byte 1 109
byte 1 117
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $1055
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 80
byte 1 97
byte 1 115
byte 1 115
byte 1 119
byte 1 111
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $1054
byte 1 97
byte 1 100
byte 1 109
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $1053
byte 1 115
byte 1 97
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $1052
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $1051
byte 1 109
byte 1 97
byte 1 112
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $1050
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $1049
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $1048
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $1047
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $1046
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $1045
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $1044
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $1043
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $1042
byte 1 115
byte 1 101
byte 1 116
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 112
byte 1 111
byte 1 115
byte 1 0
align 1
LABELV $1041
byte 1 97
byte 1 100
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $1040
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $1039
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $1038
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $1037
byte 1 110
byte 1 111
byte 1 99
byte 1 108
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $1036
byte 1 110
byte 1 111
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $1035
byte 1 103
byte 1 111
byte 1 100
byte 1 0
align 1
LABELV $1034
byte 1 103
byte 1 105
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $1033
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $1032
byte 1 118
byte 1 111
byte 1 115
byte 1 97
byte 1 121
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $1031
byte 1 118
byte 1 111
byte 1 115
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $1030
byte 1 118
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $1029
byte 1 118
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $1028
byte 1 118
byte 1 115
byte 1 97
byte 1 121
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $1027
byte 1 118
byte 1 115
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $1026
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $1025
byte 1 115
byte 1 97
byte 1 121
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $1024
byte 1 115
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $1023
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $1009
byte 1 100
byte 1 98
byte 1 103
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 98
byte 1 111
byte 1 97
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $1008
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 66
byte 1 97
byte 1 99
byte 1 107
byte 1 119
byte 1 97
byte 1 114
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $1007
byte 1 114
byte 1 101
byte 1 115
byte 1 101
byte 1 116
byte 1 77
byte 1 97
byte 1 120
byte 1 83
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $1006
byte 1 114
byte 1 101
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 72
byte 1 85
byte 1 68
byte 1 0
align 1
LABELV $1005
byte 1 97
byte 1 108
byte 1 97
byte 1 114
byte 1 109
byte 1 0
align 1
LABELV $1004
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 0
align 1
LABELV $1003
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 107
byte 1 101
byte 1 121
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $1002
byte 1 107
byte 1 101
byte 1 121
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $1001
byte 1 107
byte 1 101
byte 1 121
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $1000
byte 1 99
byte 1 103
byte 1 95
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 107
byte 1 101
byte 1 121
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $999
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 107
byte 1 101
byte 1 121
byte 1 115
byte 1 0
align 1
LABELV $998
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 105
byte 1 100
byte 1 101
byte 1 98
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $997
byte 1 99
byte 1 103
byte 1 95
byte 1 87
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 83
byte 1 105
byte 1 100
byte 1 101
byte 1 66
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $996
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 87
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 83
byte 1 105
byte 1 100
byte 1 101
byte 1 66
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $995
byte 1 111
byte 1 98
byte 1 100
byte 1 101
byte 1 116
byte 1 101
byte 1 99
byte 1 116
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $994
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 79
byte 1 66
byte 1 68
byte 1 101
byte 1 116
byte 1 101
byte 1 99
byte 1 116
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $993
byte 1 99
byte 1 103
byte 1 95
byte 1 79
byte 1 66
byte 1 68
byte 1 101
byte 1 116
byte 1 101
byte 1 99
byte 1 116
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $992
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 111
byte 1 109
byte 1 101
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $991
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 85
byte 1 80
byte 1 83
byte 1 0
align 1
LABELV $990
byte 1 99
byte 1 103
byte 1 95
byte 1 83
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 111
byte 1 109
byte 1 101
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $989
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 83
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 111
byte 1 109
byte 1 101
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $988
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $987
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 111
byte 1 117
byte 1 116
byte 1 0
align 1
LABELV $986
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $985
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 79
byte 1 114
byte 1 98
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $984
byte 1 116
byte 1 99
byte 1 109
byte 1 100
byte 1 0
align 1
LABELV $983
byte 1 118
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 95
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $982
byte 1 118
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 95
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $981
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 95
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $980
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 95
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $979
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $978
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 112
byte 1 114
byte 1 101
byte 1 118
byte 1 0
align 1
LABELV $977
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $976
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $975
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $974
byte 1 45
byte 1 122
byte 1 111
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $973
byte 1 43
byte 1 122
byte 1 111
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $972
byte 1 45
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $971
byte 1 43
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $970
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 112
byte 1 111
byte 1 115
byte 1 0
align 1
LABELV $969
byte 1 112
byte 1 114
byte 1 101
byte 1 118
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $968
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $967
byte 1 112
byte 1 114
byte 1 101
byte 1 118
byte 1 102
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $966
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 102
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $965
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $964
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $962
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $961
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $944
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 51
byte 1 100
byte 1 0
align 1
LABELV $937
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 0
align 1
LABELV $929
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 72
byte 1 85
byte 1 68
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 33
byte 1 32
byte 1 111
byte 1 102
byte 1 102
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 114
byte 1 101
byte 1 113
byte 1 117
byte 1 105
byte 1 114
byte 1 101
byte 1 115
byte 1 32
byte 1 51
byte 1 32
byte 1 102
byte 1 108
byte 1 111
byte 1 97
byte 1 116
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $919
byte 1 111
byte 1 102
byte 1 102
byte 1 115
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $900
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 72
byte 1 85
byte 1 68
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 33
byte 1 32
byte 1 97
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 115
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 114
byte 1 101
byte 1 113
byte 1 117
byte 1 105
byte 1 114
byte 1 101
byte 1 115
byte 1 32
byte 1 51
byte 1 32
byte 1 102
byte 1 108
byte 1 111
byte 1 97
byte 1 116
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $890
byte 1 97
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $880
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $872
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 72
byte 1 85
byte 1 68
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 33
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 114
byte 1 101
byte 1 113
byte 1 117
byte 1 105
byte 1 114
byte 1 101
byte 1 115
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 103
byte 1 101
byte 1 114
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $866
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $858
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 72
byte 1 85
byte 1 68
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 33
byte 1 32
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 115
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 114
byte 1 101
byte 1 113
byte 1 117
byte 1 105
byte 1 114
byte 1 101
byte 1 115
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 103
byte 1 101
byte 1 114
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 40
byte 1 48
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 49
byte 1 41
byte 1 0
align 1
LABELV $853
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 115
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $849
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 72
byte 1 85
byte 1 68
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 33
byte 1 32
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 97
byte 1 108
byte 1 105
byte 1 103
byte 1 110
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 114
byte 1 101
byte 1 113
byte 1 117
byte 1 105
byte 1 114
byte 1 101
byte 1 115
byte 1 32
byte 1 101
byte 1 105
byte 1 116
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 108
byte 1 44
byte 1 32
byte 1 99
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 114
byte 1 32
byte 1 97
byte 1 115
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 97
byte 1 114
byte 1 103
byte 1 117
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $826
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 72
byte 1 85
byte 1 68
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 33
byte 1 32
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 97
byte 1 108
byte 1 105
byte 1 103
byte 1 110
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 114
byte 1 101
byte 1 113
byte 1 117
byte 1 105
byte 1 114
byte 1 101
byte 1 115
byte 1 32
byte 1 101
byte 1 105
byte 1 116
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 76
byte 1 44
byte 1 32
byte 1 67
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 82
byte 1 32
byte 1 97
byte 1 115
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 97
byte 1 114
byte 1 103
byte 1 117
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $823
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 97
byte 1 108
byte 1 105
byte 1 103
byte 1 110
byte 1 0
align 1
LABELV $815
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 72
byte 1 85
byte 1 68
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 33
byte 1 32
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 114
byte 1 101
byte 1 113
byte 1 117
byte 1 105
byte 1 114
byte 1 101
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $812
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $804
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 72
byte 1 85
byte 1 68
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 33
byte 1 32
byte 1 114
byte 1 101
byte 1 99
byte 1 116
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 114
byte 1 101
byte 1 113
byte 1 117
byte 1 105
byte 1 114
byte 1 101
byte 1 115
byte 1 32
byte 1 52
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 103
byte 1 101
byte 1 114
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $794
byte 1 114
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $787
byte 1 109
byte 1 111
byte 1 110
byte 1 111
byte 1 115
byte 1 112
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $776
byte 1 46
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $769
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 72
byte 1 85
byte 1 68
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 33
byte 1 32
byte 1 105
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 114
byte 1 101
byte 1 113
byte 1 117
byte 1 105
byte 1 114
byte 1 101
byte 1 115
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 105
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 105
byte 1 102
byte 1 105
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $766
byte 1 105
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $741
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 72
byte 1 85
byte 1 68
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 33
byte 1 32
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 114
byte 1 101
byte 1 113
byte 1 117
byte 1 105
byte 1 114
byte 1 101
byte 1 115
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 108
byte 1 101
byte 1 97
byte 1 115
byte 1 116
byte 1 32
byte 1 49
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 103
byte 1 101
byte 1 114
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $736
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $726
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 72
byte 1 85
byte 1 68
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 33
byte 1 32
byte 1 73
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $725
byte 1 116
byte 1 104
byte 1 114
byte 1 101
byte 1 101
byte 1 119
byte 1 97
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $724
byte 1 105
byte 1 100
byte 1 98
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $723
byte 1 105
byte 1 100
byte 1 0
align 1
LABELV $722
byte 1 99
byte 1 112
byte 1 109
byte 1 97
byte 1 0
align 1
LABELV $718
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 72
byte 1 85
byte 1 68
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 33
byte 1 32
byte 1 73
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 115
byte 1 121
byte 1 110
byte 1 116
byte 1 97
byte 1 120
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $715
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $708
byte 1 102
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $700
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 72
byte 1 85
byte 1 68
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 33
byte 1 32
byte 1 102
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 114
byte 1 101
byte 1 113
byte 1 117
byte 1 105
byte 1 114
byte 1 101
byte 1 115
byte 1 32
byte 1 52
byte 1 32
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $690
byte 1 102
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $683
byte 1 100
byte 1 111
byte 1 117
byte 1 98
byte 1 108
byte 1 101
byte 1 98
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $675
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 72
byte 1 85
byte 1 68
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 33
byte 1 32
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 114
byte 1 101
byte 1 113
byte 1 117
byte 1 105
byte 1 114
byte 1 101
byte 1 115
byte 1 32
byte 1 52
byte 1 32
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $653
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $645
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 72
byte 1 85
byte 1 68
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 33
byte 1 32
byte 1 98
byte 1 103
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 114
byte 1 101
byte 1 113
byte 1 117
byte 1 105
byte 1 114
byte 1 101
byte 1 115
byte 1 32
byte 1 52
byte 1 32
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $623
byte 1 98
byte 1 103
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $617
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 72
byte 1 85
byte 1 68
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 33
byte 1 32
byte 1 85
byte 1 110
byte 1 101
byte 1 120
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 101
byte 1 110
byte 1 100
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $613
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 72
byte 1 85
byte 1 68
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 33
byte 1 32
byte 1 83
byte 1 121
byte 1 110
byte 1 116
byte 1 97
byte 1 120
byte 1 32
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 105
byte 1 110
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 39
byte 1 123
byte 1 39
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $604
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 72
byte 1 85
byte 1 68
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 33
byte 1 32
byte 1 69
byte 1 120
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 39
byte 1 123
byte 1 39
byte 1 32
byte 1 97
byte 1 102
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $593
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 72
byte 1 85
byte 1 68
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 33
byte 1 32
byte 1 85
byte 1 110
byte 1 114
byte 1 101
byte 1 99
byte 1 111
byte 1 103
byte 1 110
byte 1 105
byte 1 122
byte 1 101
byte 1 100
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $587
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 72
byte 1 85
byte 1 68
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 33
byte 1 32
byte 1 104
byte 1 117
byte 1 100
byte 1 91
byte 1 93
byte 1 32
byte 1 97
byte 1 114
byte 1 114
byte 1 97
byte 1 121
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 102
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $580
byte 1 94
byte 1 49
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 72
byte 1 85
byte 1 68
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 33
byte 1 32
byte 1 72
byte 1 85
byte 1 68
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $576
byte 1 94
byte 1 49
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 72
byte 1 85
byte 1 68
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 33
byte 1 32
byte 1 69
byte 1 109
byte 1 112
byte 1 116
byte 1 121
byte 1 32
byte 1 72
byte 1 85
byte 1 68
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $570
byte 1 104
byte 1 117
byte 1 100
byte 1 47
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $567
byte 1 0
align 1
LABELV $565
byte 1 94
byte 1 49
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 72
byte 1 85
byte 1 68
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 33
byte 1 32
byte 1 68
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 72
byte 1 85
byte 1 68
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $563
byte 1 37
byte 1 115
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $562
byte 1 99
byte 1 104
byte 1 95
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $559
byte 1 104
byte 1 117
byte 1 100
byte 1 47
byte 1 37
byte 1 115
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $541
byte 1 80
byte 1 111
byte 1 115
byte 1 116
byte 1 68
byte 1 101
byte 1 99
byte 1 111
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $538
byte 1 87
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 76
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $535
byte 1 87
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 0
align 1
LABELV $532
byte 1 86
byte 1 111
byte 1 116
byte 1 101
byte 1 77
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 87
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 0
align 1
LABELV $529
byte 1 86
byte 1 111
byte 1 116
byte 1 101
byte 1 77
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 65
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 0
align 1
LABELV $526
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 56
byte 1 0
align 1
LABELV $523
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 55
byte 1 0
align 1
LABELV $520
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 54
byte 1 0
align 1
LABELV $517
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 53
byte 1 0
align 1
LABELV $514
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 52
byte 1 0
align 1
LABELV $511
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 51
byte 1 0
align 1
LABELV $508
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 50
byte 1 0
align 1
LABELV $505
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 49
byte 1 0
align 1
LABELV $502
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 73
byte 1 99
byte 1 111
byte 1 110
byte 1 95
byte 1 79
byte 1 87
byte 1 78
byte 1 0
align 1
LABELV $499
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 73
byte 1 99
byte 1 111
byte 1 110
byte 1 95
byte 1 78
byte 1 77
byte 1 69
byte 1 0
align 1
LABELV $496
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 67
byte 1 111
byte 1 117
byte 1 110
byte 1 116
byte 1 95
byte 1 79
byte 1 87
byte 1 78
byte 1 0
align 1
LABELV $493
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 67
byte 1 111
byte 1 117
byte 1 110
byte 1 116
byte 1 95
byte 1 78
byte 1 77
byte 1 69
byte 1 0
align 1
LABELV $490
byte 1 84
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $487
byte 1 84
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $484
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 66
byte 1 97
byte 1 114
byte 1 95
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 73
byte 1 99
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $481
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 66
byte 1 97
byte 1 114
byte 1 95
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 67
byte 1 111
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $478
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 66
byte 1 97
byte 1 114
byte 1 95
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 66
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $475
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 66
byte 1 97
byte 1 114
byte 1 95
byte 1 65
byte 1 109
byte 1 109
byte 1 111
byte 1 73
byte 1 99
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $472
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 66
byte 1 97
byte 1 114
byte 1 95
byte 1 65
byte 1 109
byte 1 109
byte 1 111
byte 1 67
byte 1 111
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $469
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 66
byte 1 97
byte 1 114
byte 1 95
byte 1 65
byte 1 109
byte 1 109
byte 1 111
byte 1 66
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $466
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 66
byte 1 97
byte 1 114
byte 1 95
byte 1 65
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 73
byte 1 99
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $463
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 66
byte 1 97
byte 1 114
byte 1 95
byte 1 65
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 67
byte 1 111
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $460
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 66
byte 1 97
byte 1 114
byte 1 95
byte 1 65
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 66
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $457
byte 1 83
byte 1 112
byte 1 101
byte 1 99
byte 1 77
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $454
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 95
byte 1 79
byte 1 87
byte 1 78
byte 1 0
align 1
LABELV $451
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 95
byte 1 78
byte 1 77
byte 1 69
byte 1 0
align 1
LABELV $448
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 95
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $445
byte 1 82
byte 1 97
byte 1 110
byte 1 107
byte 1 77
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $442
byte 1 80
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 85
byte 1 112
byte 1 52
byte 1 95
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $439
byte 1 80
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 85
byte 1 112
byte 1 51
byte 1 95
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $436
byte 1 80
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 85
byte 1 112
byte 1 50
byte 1 95
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $433
byte 1 80
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 85
byte 1 112
byte 1 49
byte 1 95
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $430
byte 1 80
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 85
byte 1 112
byte 1 52
byte 1 95
byte 1 73
byte 1 99
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $427
byte 1 80
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 85
byte 1 112
byte 1 51
byte 1 95
byte 1 73
byte 1 99
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $424
byte 1 80
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 85
byte 1 112
byte 1 50
byte 1 95
byte 1 73
byte 1 99
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $421
byte 1 80
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 85
byte 1 112
byte 1 49
byte 1 95
byte 1 73
byte 1 99
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $418
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 83
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $415
byte 1 78
byte 1 101
byte 1 116
byte 1 71
byte 1 114
byte 1 97
byte 1 112
byte 1 104
byte 1 80
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $412
byte 1 78
byte 1 101
byte 1 116
byte 1 71
byte 1 114
byte 1 97
byte 1 112
byte 1 104
byte 1 0
align 1
LABELV $409
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 80
byte 1 105
byte 1 99
byte 1 107
byte 1 117
byte 1 112
byte 1 73
byte 1 99
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $406
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 80
byte 1 105
byte 1 99
byte 1 107
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $403
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $400
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $397
byte 1 70
byte 1 114
byte 1 97
byte 1 103
byte 1 77
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $394
byte 1 70
byte 1 80
byte 1 83
byte 1 0
align 1
LABELV $391
byte 1 70
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 77
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $388
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 95
byte 1 79
byte 1 87
byte 1 78
byte 1 0
align 1
LABELV $385
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 95
byte 1 78
byte 1 77
byte 1 69
byte 1 0
align 1
LABELV $382
byte 1 67
byte 1 111
byte 1 110
byte 1 115
byte 1 111
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $379
byte 1 67
byte 1 104
byte 1 97
byte 1 116
byte 1 56
byte 1 0
align 1
LABELV $376
byte 1 67
byte 1 104
byte 1 97
byte 1 116
byte 1 55
byte 1 0
align 1
LABELV $373
byte 1 67
byte 1 104
byte 1 97
byte 1 116
byte 1 54
byte 1 0
align 1
LABELV $370
byte 1 67
byte 1 104
byte 1 97
byte 1 116
byte 1 53
byte 1 0
align 1
LABELV $367
byte 1 67
byte 1 104
byte 1 97
byte 1 116
byte 1 52
byte 1 0
align 1
LABELV $364
byte 1 67
byte 1 104
byte 1 97
byte 1 116
byte 1 51
byte 1 0
align 1
LABELV $361
byte 1 67
byte 1 104
byte 1 97
byte 1 116
byte 1 50
byte 1 0
align 1
LABELV $358
byte 1 67
byte 1 104
byte 1 97
byte 1 116
byte 1 49
byte 1 0
align 1
LABELV $355
byte 1 65
byte 1 109
byte 1 109
byte 1 111
byte 1 77
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $352
byte 1 80
byte 1 114
byte 1 101
byte 1 68
byte 1 101
byte 1 99
byte 1 111
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $349
byte 1 33
byte 1 68
byte 1 69
byte 1 70
byte 1 65
byte 1 85
byte 1 76
byte 1 84
byte 1 0
align 1
LABELV $345
byte 1 94
byte 1 51
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $342
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 67
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $337
byte 1 94
byte 1 51
byte 1 85
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 92
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $336
byte 1 50
byte 1 46
byte 1 48
byte 1 48
byte 1 91
byte 1 67
byte 1 104
byte 1 105
byte 1 50
byte 1 93
byte 1 32
byte 1 45
byte 1 32
byte 1 66
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 32
byte 1 68
byte 1 97
byte 1 116
byte 1 101
byte 1 58
byte 1 32
byte 1 83
byte 1 101
byte 1 112
byte 1 116
byte 1 101
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 32
byte 1 53
byte 1 44
byte 1 32
byte 1 50
byte 1 48
byte 1 48
byte 1 57
byte 1 0
align 1
LABELV $335
byte 1 82
byte 1 101
byte 1 118
byte 1 111
byte 1 108
byte 1 117
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $334
byte 1 94
byte 1 51
byte 1 10
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $333
byte 1 94
byte 1 51
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 115
byte 1 47
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 97
byte 1 118
byte 1 97
byte 1 105
byte 1 108
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 58
byte 1 10
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $332
byte 1 94
byte 1 51
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 115
byte 1 47
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 97
byte 1 118
byte 1 97
byte 1 105
byte 1 108
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 58
byte 1 10
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $329
byte 1 10
byte 1 0
align 1
LABELV $328
byte 1 94
byte 1 51
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $320
byte 1 94
byte 1 51
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 115
byte 1 47
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 97
byte 1 118
byte 1 97
byte 1 105
byte 1 108
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 58
byte 1 10
byte 1 0
align 1
LABELV $319
byte 1 94
byte 1 51
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 115
byte 1 47
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 97
byte 1 118
byte 1 97
byte 1 105
byte 1 108
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 58
byte 1 10
byte 1 0
align 1
LABELV $312
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 70
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $302
byte 1 94
byte 1 49
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 46
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 33
byte 1 32
byte 1 70
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 108
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $298
byte 1 94
byte 1 49
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 46
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 33
byte 1 32
byte 1 70
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 111
byte 1 112
byte 1 101
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $295
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 105
byte 1 103
byte 1 47
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 47
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 47
byte 1 101
byte 1 110
byte 1 46
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $291
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 105
byte 1 103
byte 1 47
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 47
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 47
byte 1 37
byte 1 115
byte 1 46
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $287
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 105
byte 1 103
byte 1 47
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 47
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 47
byte 1 101
byte 1 110
byte 1 46
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $285
byte 1 94
byte 1 49
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 46
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 33
byte 1 32
byte 1 68
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 101
byte 1 110
byte 1 46
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $282
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 105
byte 1 103
byte 1 47
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 47
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 47
byte 1 37
byte 1 115
byte 1 46
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $266
byte 1 77
byte 1 97
byte 1 107
byte 1 101
byte 1 32
byte 1 115
byte 1 117
byte 1 114
byte 1 101
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 97
byte 1 108
byte 1 97
byte 1 114
byte 1 109
byte 1 32
byte 1 99
byte 1 111
byte 1 114
byte 1 114
byte 1 101
byte 1 99
byte 1 116
byte 1 108
byte 1 121
byte 1 46
byte 1 10
byte 1 32
byte 1 47
byte 1 97
byte 1 108
byte 1 97
byte 1 114
byte 1 109
byte 1 32
byte 1 117
byte 1 110
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 47
byte 1 97
byte 1 108
byte 1 97
byte 1 114
byte 1 109
byte 1 32
byte 1 60
byte 1 104
byte 1 111
byte 1 117
byte 1 114
byte 1 62
byte 1 32
byte 1 60
byte 1 109
byte 1 105
byte 1 110
byte 1 117
byte 1 116
byte 1 101
byte 1 62
byte 1 32
byte 1 60
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 95
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 62
byte 1 118
byte 1 45
byte 1 45
byte 1 32
byte 1 69
byte 1 120
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 101
byte 1 58
byte 1 32
byte 1 47
byte 1 97
byte 1 108
byte 1 97
byte 1 114
byte 1 109
byte 1 32
byte 1 49
byte 1 32
byte 1 57
byte 1 32
byte 1 51
byte 1 50
byte 1 10
byte 1 32
byte 1 0
align 1
LABELV $262
byte 1 117
byte 1 110
byte 1 115
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $250
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $248
byte 1 99
byte 1 104
byte 1 95
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 75
byte 1 101
byte 1 121
byte 1 80
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $235
byte 1 99
byte 1 104
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 83
byte 1 105
byte 1 100
byte 1 101
byte 1 66
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $224
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $222
byte 1 99
byte 1 104
byte 1 95
byte 1 79
byte 1 66
byte 1 68
byte 1 101
byte 1 116
byte 1 101
byte 1 99
byte 1 116
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $210
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $208
byte 1 99
byte 1 104
byte 1 95
byte 1 83
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 111
byte 1 109
byte 1 101
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $202
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 105
byte 1 110
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $200
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $198
byte 1 116
byte 1 111
byte 1 115
byte 1 115
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $185
byte 1 49
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $184
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 104
byte 1 105
byte 1 114
byte 1 100
byte 1 80
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 82
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $183
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 104
byte 1 105
byte 1 114
byte 1 100
byte 1 80
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 65
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $182
byte 1 49
byte 1 0
align 1
LABELV $181
byte 1 53
byte 1 0
align 1
LABELV $180
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 104
byte 1 105
byte 1 114
byte 1 100
byte 1 80
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $179
byte 1 48
byte 1 0
align 1
LABELV $178
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 97
byte 1 109
byte 1 101
byte 1 114
byte 1 97
byte 1 79
byte 1 114
byte 1 98
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $172
byte 1 100
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 111
byte 1 112
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $170
byte 1 110
byte 1 111
byte 1 116
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 0
align 1
LABELV $154
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 0
align 1
LABELV $138
byte 1 118
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $131
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $114
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $96
byte 1 40
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 41
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $91
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $90
byte 1 99
byte 1 103
byte 1 95
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $88
byte 1 103
byte 1 99
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 0
