export G_WriteClientSessionData
code
proc G_WriteClientSessionData 20 44
file "../g_session.c"
line 23
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:#include "g_local.h"
;4:
;5:
;6:/*
;7:=======================================================================
;8:
;9:  SESSION DATA
;10:
;11:Session data is the only data that stays persistant across level loads
;12:and tournament restarts.
;13:=======================================================================
;14:*/
;15:
;16:/*
;17:================
;18:G_WriteClientSessionData
;19:
;20:Called on game shutdown
;21:================
;22:*/
;23:void G_WriteClientSessionData( gclient_t *client ) {
line 27
;24:	const char	*s;
;25:	const char	*var;
;26:
;27:	s = va("%i %i %i %i %i %i %i %i %i %i", 
ADDRGP4 $68
ARGP4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 10192
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 10196
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 10200
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 10204
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 10208
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 10212
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 10216
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 10220
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 10184
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 40
;28:		client->sess.sessionTeam,
;29:		client->sess.spectatorTime,
;30:		client->sess.spectatorState,
;31:		client->sess.spectatorClient,
;32:		client->sess.wins,
;33:		client->sess.losses,
;34:		client->sess.teamLeader,
;35:		client->sess.isAdmin,
;36:		client->sess.speconly,
;37:		client->pers.altConsoleSayMode
;38:		);
;39:
;40:	var = va( "session%i", client - level.clients );
ADDRGP4 $69
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 level
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 10828
DIVI4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
ASGNP4
line 42
;41:
;42:	trap_Cvar_Set( var, s );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 43
;43:}
LABELV $67
endproc G_WriteClientSessionData 20 44
export G_ReadSessionData
proc G_ReadSessionData 1056 48
line 52
;44:
;45:/*
;46:================
;47:G_ReadSessionData
;48:
;49:Called on a reconnect
;50:================
;51:*/
;52:void G_ReadSessionData( gclient_t *client ) {
line 64
;53:	char	s[MAX_STRING_CHARS];
;54:	const char	*var;
;55:
;56:	// bk001205 - format
;57:	int teamLeader;
;58:	int spectatorState;
;59:	int sessionTeam;
;60:	int	isAdmin;
;61://	int speconly;
;62:	int altConsoleSayMode;
;63:
;64:	var = va( "session%i", client - level.clients );
ADDRGP4 $69
ARGP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 level
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 10828
DIVI4
ARGI4
ADDRLP4 1048
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1024
ADDRLP4 1048
INDIRP4
ASGNP4
line 65
;65:	trap_Cvar_VariableStringBuffer( var, s, sizeof(s) );
ADDRLP4 1024
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 67
;66:
;67:	sscanf( s, "%i %i %i %i %i %i %i %i %i %i",
ADDRLP4 0
ARGP4
ADDRGP4 $68
ARGP4
ADDRLP4 1036
ARGP4
ADDRLP4 1052
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1052
INDIRP4
CNSTI4 10192
ADDP4
ARGP4
ADDRLP4 1032
ARGP4
ADDRLP4 1052
INDIRP4
CNSTI4 10200
ADDP4
ARGP4
ADDRLP4 1052
INDIRP4
CNSTI4 10204
ADDP4
ARGP4
ADDRLP4 1052
INDIRP4
CNSTI4 10208
ADDP4
ARGP4
ADDRLP4 1028
ARGP4
ADDRLP4 1040
ARGP4
ADDRLP4 1052
INDIRP4
CNSTI4 10220
ADDP4
ARGP4
ADDRLP4 1044
ARGP4
ADDRGP4 sscanf
CALLI4
pop
line 81
;68:		&sessionTeam,                 // bk010221 - format
;69:		&client->sess.spectatorTime,
;70:		&spectatorState,              // bk010221 - format
;71:		&client->sess.spectatorClient,
;72:		&client->sess.wins,
;73:		&client->sess.losses,
;74:		&teamLeader,                   // bk010221 - format
;75:		&isAdmin,
;76:		&client->sess.speconly,
;77:		&altConsoleSayMode
;78:		);
;79:
;80:	// bk001205 - format issues
;81:	client->sess.sessionTeam = (team_t)sessionTeam;
ADDRFP4 0
INDIRP4
CNSTI4 10188
ADDP4
ADDRLP4 1036
INDIRI4
ASGNI4
line 82
;82:	client->sess.spectatorState = (spectatorState_t)spectatorState;
ADDRFP4 0
INDIRP4
CNSTI4 10196
ADDP4
ADDRLP4 1032
INDIRI4
ASGNI4
line 83
;83:	client->sess.teamLeader = (qboolean)teamLeader;
ADDRFP4 0
INDIRP4
CNSTI4 10212
ADDP4
ADDRLP4 1028
INDIRI4
ASGNI4
line 84
;84:	client->sess.isAdmin = (qboolean)isAdmin;
ADDRFP4 0
INDIRP4
CNSTI4 10216
ADDP4
ADDRLP4 1040
INDIRI4
ASGNI4
line 86
;85:	//client->sess.speconly = (qboolean)speconly;
;86:	client->pers.altConsoleSayMode = (qboolean)altConsoleSayMode;
ADDRFP4 0
INDIRP4
CNSTI4 10184
ADDP4
ADDRLP4 1044
INDIRI4
ASGNI4
line 87
;87:}
LABELV $70
endproc G_ReadSessionData 1056 48
export G_WriteTaskData
proc G_WriteTaskData 24 20
line 96
;88:
;89:/*
;90:================
;91:G_WriteTaskData
;92:
;93:Called on game shutdown
;94:================
;95:*/
;96:void G_WriteTaskData( void ) {
line 101
;97:	const char	*s;
;98:	const char	*var;
;99:	int i;
;100:
;101:	for ( i = 0; i < MAX_SERVER_TASKS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $72
line 102
;102:		s = va("%i %i %i %s",
ADDRGP4 $76
ARGP4
ADDRLP4 12
CNSTI4 396
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRGP4 tasks+4
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ADDRGP4 tasks+8
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ADDRGP4 tasks
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ADDRGP4 tasks+12
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
ASGNP4
line 109
;103:			tasks[i].sv_task_runTime,
;104:			tasks[i].sv_task_repeatTime,
;105:			tasks[i].sv_task_startTime,
;106:			tasks[i].sv_task_command
;107:			);
;108:
;109:		var = va( "task%i", i );
ADDRGP4 $80
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 20
INDIRP4
ASGNP4
line 110
;110:		trap_Cvar_Set( var, s );
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 111
;111:	}
LABELV $73
line 101
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $72
line 112
;112:}
LABELV $71
endproc G_WriteTaskData 24 20
export G_ReadTaskData
proc G_ReadTaskData 1064 12
line 121
;113:
;114:/*
;115:================
;116:G_ReadTaskData
;117:
;118:Called on... dunno yet
;119:================
;120:*/
;121:void G_ReadTaskData( int taskNum ) {
line 129
;122:	char	s[MAX_STRING_CHARS];
;123:	char	*s1;
;124:	const char	*var;
;125:	char	*token;
;126:
;127://	char cmd[MAX_STRING_CHARS];
;128:
;129:	var = va( "task%i", taskNum );
ADDRGP4 $80
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1036
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1032
ADDRLP4 1036
INDIRP4
ASGNP4
line 130
;130:	trap_Cvar_VariableStringBuffer( var, s, sizeof(s) );
ADDRLP4 1032
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 132
;131:
;132:	s1 = s;
ADDRLP4 4
ADDRLP4 8
ASGNP4
line 133
;133:	token = COM_Parse( &s1 );
ADDRLP4 4
ARGP4
ADDRLP4 1040
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1040
INDIRP4
ASGNP4
line 134
;134:	tasks[taskNum].sv_task_runTime = atoi(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1044
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTI4 396
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 tasks+4
ADDP4
ADDRLP4 1044
INDIRI4
ASGNI4
line 135
;135:	token = COM_Parse( &s1 );
ADDRLP4 4
ARGP4
ADDRLP4 1048
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1048
INDIRP4
ASGNP4
line 136
;136:	tasks[taskNum].sv_task_repeatTime = atoi(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1052
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTI4 396
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 tasks+8
ADDP4
ADDRLP4 1052
INDIRI4
ASGNI4
line 137
;137:	token = COM_Parse( &s1 );
ADDRLP4 4
ARGP4
ADDRLP4 1056
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1056
INDIRP4
ASGNP4
line 138
;138:	tasks[taskNum].sv_task_startTime = atoi(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1060
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTI4 396
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 tasks
ADDP4
ADDRLP4 1060
INDIRI4
ASGNI4
line 140
;139:
;140:	strcpy(tasks[taskNum].sv_task_command, s1);
CNSTI4 396
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 tasks+12
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 141
;141:}
LABELV $81
endproc G_ReadTaskData 1064 12
export G_WriteGameSettings
proc G_WriteGameSettings 20 84
line 150
;142:
;143:/*
;144:================
;145:G_WriteClientSessionData
;146:
;147:Called on game shutdown
;148:================
;149:*/
;150:void G_WriteGameSettings() {
line 152
;151:	const char	*s;
;152:	const char	*var = "rvogs1";
ADDRLP4 4
ADDRGP4 $86
ASGNP4
line 153
;153:	const char	*var1 = "rvogs2";
ADDRLP4 8
ADDRGP4 $87
ASGNP4
line 156
;154:
;155:	//trap_Cvar_VariableStringBuffer( var, s, sizeof(s) );
;156:	s = va("%i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i", 
ADDRGP4 $88
ARGP4
ADDRGP4 gameSettings+24
INDIRI4
ARGI4
ADDRGP4 gameSettings+24+8
INDIRI4
ARGI4
ADDRGP4 gameSettings+24+12
INDIRI4
ARGI4
ADDRGP4 gameSettings+24+16
INDIRI4
ARGI4
ADDRGP4 gameSettings+24+4
INDIRI4
ARGI4
ADDRGP4 gameSettings+24+20
INDIRI4
ARGI4
ADDRGP4 gameSettings+24+20+8
INDIRI4
ARGI4
ADDRGP4 gameSettings+24+20+12
INDIRI4
ARGI4
ADDRGP4 gameSettings+24+20+16
INDIRI4
ARGI4
ADDRGP4 gameSettings+24+20+4
INDIRI4
ARGI4
ADDRGP4 gameSettings+24+40
INDIRI4
ARGI4
ADDRGP4 gameSettings+24+40+8
INDIRI4
ARGI4
ADDRGP4 gameSettings+24+40+12
INDIRI4
ARGI4
ADDRGP4 gameSettings+24+40+16
INDIRI4
ARGI4
ADDRGP4 gameSettings+24+40+4
INDIRI4
ARGI4
ADDRGP4 gameSettings+24+60
INDIRI4
ARGI4
ADDRGP4 gameSettings+24+60+8
INDIRI4
ARGI4
ADDRGP4 gameSettings+24+60+12
INDIRI4
ARGI4
ADDRGP4 gameSettings+24+60+16
INDIRI4
ARGI4
ADDRGP4 gameSettings+24+60+4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 182
;157:		gameSettings.missiles[GS_GRENADE][GS_DAMAGE],
;158:		gameSettings.missiles[GS_GRENADE][GS_SPLASH_DAMAGE],
;159:		gameSettings.missiles[GS_GRENADE][GS_SPEED],
;160:		gameSettings.missiles[GS_GRENADE][GS_TIME],
;161:		gameSettings.missiles[GS_GRENADE][GS_RADIUS],
;162:		//5
;163:		gameSettings.missiles[GS_ROCKET][GS_DAMAGE],
;164:		gameSettings.missiles[GS_ROCKET][GS_SPLASH_DAMAGE],
;165:		gameSettings.missiles[GS_ROCKET][GS_SPEED],
;166:		gameSettings.missiles[GS_ROCKET][GS_TIME],
;167:		gameSettings.missiles[GS_ROCKET][GS_RADIUS],
;168:		//10
;169:		gameSettings.missiles[GS_PLASMA][GS_DAMAGE],
;170:		gameSettings.missiles[GS_PLASMA][GS_SPLASH_DAMAGE],
;171:		gameSettings.missiles[GS_PLASMA][GS_SPEED],
;172:		gameSettings.missiles[GS_PLASMA][GS_TIME],
;173:		gameSettings.missiles[GS_PLASMA][GS_RADIUS],
;174:		//15
;175:		gameSettings.missiles[GS_BFG][GS_DAMAGE],
;176:		gameSettings.missiles[GS_BFG][GS_SPLASH_DAMAGE],
;177:		gameSettings.missiles[GS_BFG][GS_SPEED],
;178:		gameSettings.missiles[GS_BFG][GS_TIME],
;179:		gameSettings.missiles[GS_BFG][GS_RADIUS]
;180:		//20
;181:		);
;182:	trap_Cvar_Set( var, s );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 185
;183:
;184:
;185:	s = va("%i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i",
ADDRGP4 $88
ARGP4
ADDRGP4 gameSettings+104
INDIRI4
ARGI4
ADDRGP4 gameSettings+104+4
INDIRI4
ARGI4
ADDRGP4 gameSettings+104+8
INDIRI4
ARGI4
ADDRGP4 gameSettings+104+8+4
INDIRI4
ARGI4
ADDRGP4 gameSettings+104+16
INDIRI4
ARGI4
ADDRGP4 gameSettings+104+16+4
INDIRI4
ARGI4
ADDRGP4 gameSettings+104+24
INDIRI4
ARGI4
ADDRGP4 gameSettings+104+24+4
INDIRI4
ARGI4
ADDRGP4 gameSettings+104+32
INDIRI4
ARGI4
ADDRGP4 gameSettings+104+32+4
INDIRI4
ARGI4
ADDRGP4 gameSettings+20
INDIRI4
ARGI4
ADDRGP4 gameSettings+144
INDIRI4
ARGI4
ADDRGP4 gameSettings+8
INDIRI4
ARGI4
ADDRGP4 gameSettings+12
INDIRI4
ARGI4
ADDRGP4 gameSettings+16
INDIRI4
ARGI4
ADDRGP4 gameSettings
INDIRI4
ARGI4
ADDRGP4 gameSettings+4
INDIRI4
ARGI4
ADDRGP4 level+10864
INDIRI4
ARGI4
ADDRGP4 level+10864+4
INDIRI4
ARGI4
ADDRGP4 level+10864+8
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 213
;186:		gameSettings.hitscans[GS_GAUNTLET][GS_DAMAGE],
;187:		gameSettings.hitscans[GS_GAUNTLET][GS_RANGE],
;188:		//22
;189:		gameSettings.hitscans[GS_MACHINEGUN][GS_DAMAGE],
;190:		gameSettings.hitscans[GS_MACHINEGUN][GS_RANGE],
;191:		//24
;192:		gameSettings.hitscans[GS_SHOTGUN][GS_DAMAGE],
;193:		gameSettings.hitscans[GS_SHOTGUN][GS_RANGE],
;194:		//26
;195:		gameSettings.hitscans[GS_LIGHTNING][GS_DAMAGE],
;196:		gameSettings.hitscans[GS_LIGHTNING][GS_RANGE],
;197:		//28
;198:		gameSettings.hitscans[GS_RAILGUN][GS_DAMAGE],
;199:		gameSettings.hitscans[GS_RAILGUN][GS_RANGE],
;200:		//30
;201:		gameSettings.hook_speed,
;202:		gameSettings.quadfactor_radius,
;203:		gameSettings.allowTossflag,
;204:		gameSettings.spawn_armor,
;205:		gameSettings.spawn_health,
;206:		gameSettings.wasPreviousSession,
;207:		gameSettings.ping_fix,
;208:		level.team_Locked[TEAM_FREE],
;209:		level.team_Locked[TEAM_RED],
;210:		level.team_Locked[TEAM_BLUE]
;211:		//40
;212:		);
;213:	trap_Cvar_Set( var1, s );
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 214
;214:}
LABELV $85
endproc G_WriteGameSettings 20 84
export G_ReadGameSetings
proc G_ReadGameSetings 1064 88
line 223
;215:
;216:/*
;217:================
;218:G_ReadGameSettings
;219:
;220:Called on... dunno yet
;221:================
;222:*/
;223:void G_ReadGameSetings() {
line 225
;224:	char	s[MAX_STRING_CHARS];
;225:	const char	*var = "rvogs1";
ADDRLP4 1040
ADDRGP4 $86
ASGNP4
line 226
;226:	const char	*var1 = "rvogs2";
ADDRLP4 1044
ADDRGP4 $87
ASGNP4
line 234
;227:
;228:	int	wasPreviousSession;
;229:	int	quadfactor_radius;
;230:	int	allowTossflag;
;231:	int	ping_fix;
;232:	int	team_Locked[TEAM_NUM_TEAMS];
;233:
;234:	trap_Cvar_VariableStringBuffer( var, s, sizeof(s) );
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 235
;235:	sscanf( s, "%i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i", 
ADDRLP4 0
ARGP4
ADDRGP4 $88
ARGP4
ADDRGP4 gameSettings+24
ARGP4
ADDRGP4 gameSettings+24+8
ARGP4
ADDRGP4 gameSettings+24+12
ARGP4
ADDRGP4 gameSettings+24+16
ARGP4
ADDRGP4 gameSettings+24+4
ARGP4
ADDRGP4 gameSettings+24+20
ARGP4
ADDRGP4 gameSettings+24+20+8
ARGP4
ADDRGP4 gameSettings+24+20+12
ARGP4
ADDRGP4 gameSettings+24+20+16
ARGP4
ADDRGP4 gameSettings+24+20+4
ARGP4
ADDRGP4 gameSettings+24+40
ARGP4
ADDRGP4 gameSettings+24+40+8
ARGP4
ADDRGP4 gameSettings+24+40+12
ARGP4
ADDRGP4 gameSettings+24+40+16
ARGP4
ADDRGP4 gameSettings+24+40+4
ARGP4
ADDRGP4 gameSettings+24+60
ARGP4
ADDRGP4 gameSettings+24+60+8
ARGP4
ADDRGP4 gameSettings+24+60+12
ARGP4
ADDRGP4 gameSettings+24+60+16
ARGP4
ADDRGP4 gameSettings+24+60+4
ARGP4
ADDRGP4 sscanf
CALLI4
pop
line 262
;236:		&gameSettings.missiles[GS_GRENADE][GS_DAMAGE],
;237:		&gameSettings.missiles[GS_GRENADE][GS_SPLASH_DAMAGE],
;238:		&gameSettings.missiles[GS_GRENADE][GS_SPEED],
;239:		&gameSettings.missiles[GS_GRENADE][GS_TIME],
;240:		&gameSettings.missiles[GS_GRENADE][GS_RADIUS],
;241:		//5
;242:		&gameSettings.missiles[GS_ROCKET][GS_DAMAGE],
;243:		&gameSettings.missiles[GS_ROCKET][GS_SPLASH_DAMAGE],
;244:		&gameSettings.missiles[GS_ROCKET][GS_SPEED],
;245:		&gameSettings.missiles[GS_ROCKET][GS_TIME],
;246:		&gameSettings.missiles[GS_ROCKET][GS_RADIUS],
;247:		//10
;248:		&gameSettings.missiles[GS_PLASMA][GS_DAMAGE],
;249:		&gameSettings.missiles[GS_PLASMA][GS_SPLASH_DAMAGE],
;250:		&gameSettings.missiles[GS_PLASMA][GS_SPEED],
;251:		&gameSettings.missiles[GS_PLASMA][GS_TIME],
;252:		&gameSettings.missiles[GS_PLASMA][GS_RADIUS],
;253:		//15
;254:		&gameSettings.missiles[GS_BFG][GS_DAMAGE],
;255:		&gameSettings.missiles[GS_BFG][GS_SPLASH_DAMAGE],
;256:		&gameSettings.missiles[GS_BFG][GS_SPEED],
;257:		&gameSettings.missiles[GS_BFG][GS_TIME],
;258:		&gameSettings.missiles[GS_BFG][GS_RADIUS]
;259:		//20
;260:		);
;261:
;262:	memset(s, 0, sizeof(s));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1024
ARGI4
ADDRGP4 memset
CALLP4
pop
line 263
;263:	trap_Cvar_VariableStringBuffer( var1, s, sizeof(s) );
ADDRLP4 1044
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 264
;264:	sscanf(s, "%i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i",
ADDRLP4 0
ARGP4
ADDRGP4 $88
ARGP4
ADDRGP4 gameSettings+104
ARGP4
ADDRGP4 gameSettings+104+4
ARGP4
ADDRGP4 gameSettings+104+8
ARGP4
ADDRGP4 gameSettings+104+8+4
ARGP4
ADDRGP4 gameSettings+104+16
ARGP4
ADDRGP4 gameSettings+104+16+4
ARGP4
ADDRGP4 gameSettings+104+24
ARGP4
ADDRGP4 gameSettings+104+24+4
ARGP4
ADDRGP4 gameSettings+104+32
ARGP4
ADDRGP4 gameSettings+104+32+4
ARGP4
ADDRGP4 gameSettings+20
ARGP4
ADDRLP4 1052
ARGP4
ADDRLP4 1056
ARGP4
ADDRGP4 gameSettings+12
ARGP4
ADDRGP4 gameSettings+16
ARGP4
ADDRLP4 1048
ARGP4
ADDRLP4 1060
ARGP4
ADDRLP4 1024
ARGP4
ADDRLP4 1024+4
ARGP4
ADDRLP4 1024+8
ARGP4
ADDRGP4 sscanf
CALLI4
pop
line 294
;265:		&gameSettings.hitscans[GS_GAUNTLET][GS_DAMAGE],
;266:		&gameSettings.hitscans[GS_GAUNTLET][GS_RANGE],
;267:		//22
;268:		&gameSettings.hitscans[GS_MACHINEGUN][GS_DAMAGE],
;269:		&gameSettings.hitscans[GS_MACHINEGUN][GS_RANGE],
;270:		//24
;271:		&gameSettings.hitscans[GS_SHOTGUN][GS_DAMAGE],
;272:		&gameSettings.hitscans[GS_SHOTGUN][GS_RANGE],
;273:		//26
;274:		&gameSettings.hitscans[GS_LIGHTNING][GS_DAMAGE],
;275:		&gameSettings.hitscans[GS_LIGHTNING][GS_RANGE],
;276:		//28
;277:		&gameSettings.hitscans[GS_RAILGUN][GS_DAMAGE],
;278:		&gameSettings.hitscans[GS_RAILGUN][GS_RANGE],
;279:		//30
;280:		&gameSettings.hook_speed,
;281:		&quadfactor_radius,
;282:		&allowTossflag,
;283:		&gameSettings.spawn_armor,
;284:		&gameSettings.spawn_health,
;285:		&wasPreviousSession,
;286:		&ping_fix,
;287:		&team_Locked[TEAM_FREE],
;288:		&team_Locked[TEAM_RED],
;289:		&team_Locked[TEAM_BLUE]
;290:		//40
;291:		);
;292:
;293:
;294:	gameSettings.quadfactor_radius = (qboolean)quadfactor_radius;
ADDRGP4 gameSettings+144
ADDRLP4 1052
INDIRI4
ASGNI4
line 295
;295:	gameSettings.allowTossflag = (qboolean)allowTossflag;
ADDRGP4 gameSettings+8
ADDRLP4 1056
INDIRI4
ASGNI4
line 296
;296:	gameSettings.wasPreviousSession = (qboolean)wasPreviousSession;
ADDRGP4 gameSettings
ADDRLP4 1048
INDIRI4
ASGNI4
line 297
;297:	gameSettings.ping_fix = (qboolean)ping_fix;
ADDRGP4 gameSettings+4
ADDRLP4 1060
INDIRI4
ASGNI4
line 299
;298:	//
;299:	level.team_Locked[TEAM_FREE] = (qboolean)team_Locked[TEAM_FREE];
ADDRGP4 level+10864
ADDRLP4 1024
INDIRI4
ASGNI4
line 300
;300:	level.team_Locked[TEAM_RED] = (qboolean)team_Locked[TEAM_RED];
ADDRGP4 level+10864+4
ADDRLP4 1024+4
INDIRI4
ASGNI4
line 301
;301:	level.team_Locked[TEAM_BLUE] = (qboolean)team_Locked[TEAM_BLUE];
ADDRGP4 level+10864+8
ADDRLP4 1024+8
INDIRI4
ASGNI4
line 302
;302:}
LABELV $174
endproc G_ReadGameSetings 1064 88
bss
align 4
LABELV $265
skip 4
export G_ReadBans
code
proc G_ReadBans 17440 12
line 309
;303:
;304:/*
;305:================
;306:G_ReadBans
;307:================
;308:*/
;309:void G_ReadBans() {
line 310
;310:	int i = 0,count = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRLP4 4
CNSTI4 0
ASGNI4
line 315
;311://	const char	*var;
;312:	static char		*fsptr;
;313://	char	s[128];
;314:	//
;315:	int				length = 0;
ADDRLP4 1032
CNSTI4 0
ASGNI4
line 322
;316:	char			text[MAX_HELP_FILE_SIZE];
;317:	//char			filename[MAX_QPATH];
;318:	char			token[MAX_TOKEN_CHARS];	
;319:	fileHandle_t	f;
;320:
;321:
;322:	if ((length = trap_FS_FOpenFile("ban.cfg", &f, FS_READ)) <= 0) {
ADDRGP4 $268
ARGP4
ADDRLP4 17420
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 17424
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 1032
ADDRLP4 17424
INDIRI4
ASGNI4
ADDRLP4 17424
INDIRI4
CNSTI4 0
GTI4 $266
line 323
;323:		Com_Printf(""S_COLOR_RED"Loading ban.cfg failed! Failed to open the file\n");
ADDRGP4 $269
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 324
;324:		return;
ADDRGP4 $264
JUMPV
LABELV $266
line 327
;325:	}
;326:
;327:	if (length >= MAX_HELP_FILE_SIZE) {
ADDRLP4 1032
INDIRI4
CNSTI4 16384
LTI4 $270
line 328
;328:		Com_Printf(""S_COLOR_RED"Loading ban.cfg failed! File too large\n");
ADDRGP4 $272
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 329
;329:		return;
ADDRGP4 $264
JUMPV
LABELV $270
line 332
;330:	}
;331:
;332:	trap_FS_Read(text, length, f);
ADDRLP4 1036
ARGP4
ADDRLP4 1032
INDIRI4
ARGI4
ADDRLP4 17420
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 333
;333:	text[length] = '\0';
ADDRLP4 1032
INDIRI4
ADDRLP4 1036
ADDP4
CNSTI1 0
ASGNI1
line 334
;334:	trap_FS_FCloseFile(f);
ADDRLP4 17420
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 335
;335:	fsptr = text;
ADDRGP4 $265
ADDRLP4 1036
ASGNP4
ADDRGP4 $274
JUMPV
LABELV $273
line 337
;336:	//
;337:	while ( GetToken(token, &fsptr) != T_EOF && count < NUM_BANS ) {
line 338
;338:		switch ( i ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $276
ADDRLP4 0
INDIRI4
CNSTI4 3
GTI4 $276
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $286
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $286
address $278
address $279
address $281
address $283
code
LABELV $278
line 340
;339:			case 0:
;340:				i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 343
;341:				//Parse ip's to bytes =/
;342:				//G_Printf("%s\n", token);
;343:				Q_strncpyz(bans[count].ip, token, sizeof(bans[count].ip));
CNSTI4 152
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 bans
ADDP4
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 345
;344:				//sscanf(token, "%d.%d.%d.%d", &bans[count].ip[0], &bans[count].ip[1], &bans[count].ip[2], &bans[count].ip[3]);
;345:				break;
ADDRGP4 $277
JUMPV
LABELV $279
line 347
;346:			case 1:
;347:				i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 349
;348:				//G_Printf("%s\n", token);
;349:				bans[count].time = atoi(token);
ADDRLP4 8
ARGP4
ADDRLP4 17432
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTI4 152
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 bans+16
ADDP4
ADDRLP4 17432
INDIRI4
ASGNI4
line 350
;350:				break;
ADDRGP4 $277
JUMPV
LABELV $281
line 352
;351:			case 2:
;352:				i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 354
;353:				//G_Printf("%s\n", token);
;354:				bans[count].type = atoi(token);
ADDRLP4 8
ARGP4
ADDRLP4 17436
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTI4 152
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 bans+20
ADDP4
ADDRLP4 17436
INDIRI4
ASGNI4
line 355
;355:				break;
ADDRGP4 $277
JUMPV
LABELV $283
line 357
;356:			case 3:
;357:				i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 360
;358:				//G_Printf("%s\n", token);
;359:				//Com_sprintf(bans[count].message, sizeof(bans[count].message), "%s", token);
;360:				Q_strncpyz(bans[count].message, token, sizeof(bans[count].message));
CNSTI4 152
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 bans+24
ADDP4
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 362
;361:				//G_Printf("%i: %s - %s\n", count, bans[count].ip,  bans[count].message);
;362:				count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 363
;363:				break;
LABELV $276
LABELV $277
line 365
;364:		}
;365:	}
LABELV $274
line 337
ADDRLP4 8
ARGP4
ADDRGP4 $265
ARGP4
ADDRLP4 17428
ADDRGP4 GetToken
CALLI4
ASGNI4
ADDRLP4 17428
INDIRI4
CNSTI4 0
EQI4 $287
ADDRLP4 4
INDIRI4
CNSTI4 64
LTI4 $273
LABELV $287
line 366
;366:}
LABELV $264
endproc G_ReadBans 17440 12
export getTimeDiff
proc getTimeDiff 44 4
line 368
;367:
;368:int getTimeDiff( void ) {
line 369
;369:	int timeDiff = 0;
ADDRLP4 36
CNSTI4 0
ASGNI4
line 370
;370:	int	tmHours = 0;
ADDRLP4 40
CNSTI4 0
ASGNI4
line 372
;371:	qtime_t		curSysTime;
;372:	trap_RealTime(&curSysTime);
ADDRLP4 0
ARGP4
ADDRGP4 trap_RealTime
CALLI4
pop
line 374
;373:
;374:	if (level.sysStartTime.tm_min < curSysTime.tm_min) {
ADDRGP4 level+52+4
INDIRI4
ADDRLP4 0+4
INDIRI4
GEI4 $289
line 375
;375:		timeDiff = curSysTime.tm_min - level.sysStartTime.tm_min;
ADDRLP4 36
ADDRLP4 0+4
INDIRI4
ADDRGP4 level+52+4
INDIRI4
SUBI4
ASGNI4
line 377
;376:		//G_Printf("DBG:TimeDiff: startMin < curMin: %i\n", timeDiff);
;377:	} else {
ADDRGP4 $290
JUMPV
LABELV $289
line 378
;378:		timeDiff = 60 - (level.sysStartTime.tm_min - curSysTime.tm_min);
ADDRLP4 36
CNSTI4 60
ADDRGP4 level+52+4
INDIRI4
ADDRLP4 0+4
INDIRI4
SUBI4
SUBI4
ASGNI4
line 380
;379:		//G_Printf("DBG:TimeDiff: startMin > curMin: %i\n", timeDiff);
;380:	}
LABELV $290
line 382
;381:
;382:	if ( curSysTime.tm_yday != level.sysStartTime.tm_yday ) {
ADDRLP4 0+28
INDIRI4
ADDRGP4 level+52+28
INDIRI4
EQI4 $300
line 383
;383:		if ( level.sysStartTime.tm_yday < curSysTime.tm_yday ) {
ADDRGP4 level+52+28
INDIRI4
ADDRLP4 0+28
INDIRI4
GEI4 $305
line 384
;384:			tmHours = 24 * (curSysTime.tm_yday - level.sysStartTime.tm_yday);
ADDRLP4 40
CNSTI4 24
ADDRLP4 0+28
INDIRI4
ADDRGP4 level+52+28
INDIRI4
SUBI4
MULI4
ASGNI4
line 386
;385:			//G_Printf("DBG:TimeDiff: startDay < curDay: %i\n", tmHours);
;386:		} else {
ADDRGP4 $306
JUMPV
LABELV $305
line 387
;387:			tmHours = 24 * ((365 - level.sysStartTime.tm_yday) + curSysTime.tm_yday);
ADDRLP4 40
CNSTI4 24
CNSTI4 365
ADDRGP4 level+52+28
INDIRI4
SUBI4
ADDRLP4 0+28
INDIRI4
ADDI4
MULI4
ASGNI4
line 389
;388:			//G_Printf("DBG:TimeDiff: startDay > curDay: %i\n", tmHours);
;389:		}
LABELV $306
line 390
;390:	}
LABELV $300
line 392
;391:
;392:	if ( curSysTime.tm_hour != level.sysStartTime.tm_hour ) {
ADDRLP4 0+8
INDIRI4
ADDRGP4 level+52+8
INDIRI4
EQI4 $316
line 393
;393:		if (level.sysStartTime.tm_hour < curSysTime.tm_hour) {
ADDRGP4 level+52+8
INDIRI4
ADDRLP4 0+8
INDIRI4
GEI4 $321
line 394
;394:			tmHours += curSysTime.tm_hour - level.sysStartTime.tm_hour;
ADDRLP4 40
ADDRLP4 40
INDIRI4
ADDRLP4 0+8
INDIRI4
ADDRGP4 level+52+8
INDIRI4
SUBI4
ADDI4
ASGNI4
line 396
;395:			//G_Printf("DBG:TimeDiff: startHour < curHour: %i\n", tmHours);
;396:		} else {
ADDRGP4 $322
JUMPV
LABELV $321
line 397
;397:			tmHours += 24 - (level.sysStartTime.tm_hour - curSysTime.tm_hour);
ADDRLP4 40
ADDRLP4 40
INDIRI4
CNSTI4 24
ADDRGP4 level+52+8
INDIRI4
ADDRLP4 0+8
INDIRI4
SUBI4
SUBI4
ADDI4
ASGNI4
line 399
;398:			//G_Printf("DBG:TimeDiff: startHour > curHour: %i\n", tmHours);
;399:		}
LABELV $322
line 400
;400:	}
LABELV $316
line 402
;401:
;402:	timeDiff += (tmHours * 60);
ADDRLP4 36
ADDRLP4 36
INDIRI4
CNSTI4 60
ADDRLP4 40
INDIRI4
MULI4
ADDI4
ASGNI4
line 405
;403:
;404:	//G_Printf("DBG:TimeDiff:Return: %i\n", timeDiff);
;405:	return timeDiff;
ADDRLP4 36
INDIRI4
RETI4
LABELV $288
endproc getTimeDiff 44 4
export G_WriteBans
proc G_WriteBans 16424 32
line 408
;406:}
;407:
;408:void G_WriteBans( void ) {
line 409
;409:	int i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 412
;410:	char			text[MAX_HELP_FILE_SIZE];
;411:	fileHandle_t	f;
;412:	qboolean		first = qtrue;
ADDRLP4 16392
CNSTI4 1
ASGNI4
line 413
;413:	int				minuteDiff = getTimeDiff();
ADDRLP4 16400
ADDRGP4 getTimeDiff
CALLI4
ASGNI4
ADDRLP4 16388
ADDRLP4 16400
INDIRI4
ASGNI4
line 415
;414:
;415:	memset(text, 0, sizeof(text));
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 16384
ARGI4
ADDRGP4 memset
CALLP4
pop
line 416
;416:	for (i = 0; i < NUM_BANS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $333
line 417
;417:		if ( strlen(bans[i].ip) > 2 ) {
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bans
ADDP4
ARGP4
ADDRLP4 16404
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 16404
INDIRI4
CNSTI4 2
LEI4 $337
line 418
;418:			if ( bans[i].time == 0 || (bans[i].time -= minuteDiff) > 0 ) {
ADDRLP4 16408
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 16408
INDIRI4
ADDRGP4 bans+16
ADDP4
INDIRI4
CNSTI4 0
EQI4 $343
ADDRLP4 16412
ADDRLP4 16408
INDIRI4
ADDRGP4 bans+16
ADDP4
ASGNP4
ADDRLP4 16416
ADDRLP4 16412
INDIRP4
INDIRI4
ADDRLP4 16388
INDIRI4
SUBI4
ASGNI4
ADDRLP4 16412
INDIRP4
ADDRLP4 16416
INDIRI4
ASGNI4
ADDRLP4 16416
INDIRI4
CNSTI4 0
LEI4 $339
LABELV $343
line 419
;419:				if ( first ) {
ADDRLP4 16392
INDIRI4
CNSTI4 0
EQI4 $344
line 420
;420:					Com_sprintf(text, sizeof(text), "%s %i %i \"%s\"\n", bans[i].ip, bans[i].time, bans[i].type, bans[i].message );
ADDRLP4 4
ARGP4
CNSTI4 16384
ARGI4
ADDRGP4 $346
ARGP4
ADDRLP4 16420
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 16420
INDIRI4
ADDRGP4 bans
ADDP4
ARGP4
ADDRLP4 16420
INDIRI4
ADDRGP4 bans+16
ADDP4
INDIRI4
ARGI4
ADDRLP4 16420
INDIRI4
ADDRGP4 bans+20
ADDP4
INDIRI4
ARGI4
ADDRLP4 16420
INDIRI4
ADDRGP4 bans+24
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 421
;421:					first = qfalse;
ADDRLP4 16392
CNSTI4 0
ASGNI4
line 422
;422:				} else {
ADDRGP4 $345
JUMPV
LABELV $344
line 423
;423:					Com_sprintf(text, sizeof(text), "%s%s %i %i \"%s\"\n", text, bans[i].ip, bans[i].time, bans[i].type, bans[i].message );
ADDRLP4 4
ARGP4
CNSTI4 16384
ARGI4
ADDRGP4 $350
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 16420
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 16420
INDIRI4
ADDRGP4 bans
ADDP4
ARGP4
ADDRLP4 16420
INDIRI4
ADDRGP4 bans+16
ADDP4
INDIRI4
ARGI4
ADDRLP4 16420
INDIRI4
ADDRGP4 bans+20
ADDP4
INDIRI4
ARGI4
ADDRLP4 16420
INDIRI4
ADDRGP4 bans+24
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 424
;424:				}
LABELV $345
line 425
;425:			}
LABELV $339
line 426
;426:		}
LABELV $337
line 427
;427:	}
LABELV $334
line 416
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $333
line 428
;428:	trap_FS_FOpenFile( "ban.cfg", &f, FS_WRITE );
ADDRGP4 $268
ARGP4
ADDRLP4 16396
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 trap_FS_FOpenFile
CALLI4
pop
line 429
;429:	trap_FS_Write( text, strlen(text), f );
ADDRLP4 4
ARGP4
ADDRLP4 16404
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ARGP4
ADDRLP4 16404
INDIRI4
ARGI4
ADDRLP4 16396
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 430
;430:	trap_FS_FCloseFile(f);
ADDRLP4 16396
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 431
;431:}
LABELV $332
endproc G_WriteBans 16424 32
export G_InitSessionData
proc G_InitSessionData 16 8
line 440
;432:
;433:/*
;434:================
;435:G_InitSessionData
;436:
;437:Called on a first-time connect
;438:================
;439:*/
;440:void G_InitSessionData( gclient_t *client, char *userinfo ) {
line 444
;441:	clientSession_t	*sess;
;442:	const char		*value;
;443:
;444:	sess = &client->sess;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 10188
ADDP4
ASGNP4
line 447
;445:
;446:	// initial team determination
;447:	if ( g_gametype.integer >= GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $355
line 448
;448:		if ( g_teamAutoJoin.integer ) {
ADDRGP4 g_teamAutoJoin+12
INDIRI4
CNSTI4 0
EQI4 $358
line 449
;449:			sess->sessionTeam = PickTeam( -1 );
CNSTI4 -1
ARGI4
ADDRLP4 8
ADDRGP4 PickTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ASGNI4
line 450
;450:			BroadcastTeamChange( client, -1 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 BroadcastTeamChange
CALLV
pop
line 451
;451:		} else {
ADDRGP4 $356
JUMPV
LABELV $358
line 453
;452:			// always spawn as spectator in team games
;453:			sess->sessionTeam = TEAM_SPECTATOR;	
ADDRLP4 0
INDIRP4
CNSTI4 3
ASGNI4
line 454
;454:		}
line 455
;455:	} else {
ADDRGP4 $356
JUMPV
LABELV $355
line 456
;456:		value = Info_ValueForKey( userinfo, "team" );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $361
ARGP4
ADDRLP4 8
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 457
;457:		if ( value[0] == 's' ) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 115
NEI4 $362
line 459
;458:			// a willing spectator, not a waiting-in-line
;459:			sess->sessionTeam = TEAM_SPECTATOR;
ADDRLP4 0
INDIRP4
CNSTI4 3
ASGNI4
line 460
;460:		} else {
ADDRGP4 $363
JUMPV
LABELV $362
line 461
;461:			switch ( g_gametype.integer ) {
ADDRLP4 12
ADDRGP4 g_gametype+12
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $367
ADDRLP4 12
INDIRI4
CNSTI4 1
EQI4 $373
ADDRLP4 12
INDIRI4
CNSTI4 2
EQI4 $367
ADDRGP4 $364
JUMPV
LABELV $364
LABELV $367
line 465
;462:			default:
;463:			case GT_FFA:
;464:			case GT_SINGLE_PLAYER:
;465:				if ( g_maxGameClients.integer > 0 && 
ADDRGP4 g_maxGameClients+12
INDIRI4
CNSTI4 0
LEI4 $368
ADDRGP4 level+121
INDIRU1
CVUI4 1
ADDRGP4 g_maxGameClients+12
INDIRI4
LTI4 $368
line 466
;466:					level.numNonSpectatorClients >= g_maxGameClients.integer ) {
line 467
;467:					sess->sessionTeam = TEAM_SPECTATOR;
ADDRLP4 0
INDIRP4
CNSTI4 3
ASGNI4
line 468
;468:				} else {
ADDRGP4 $365
JUMPV
LABELV $368
line 469
;469:					sess->sessionTeam = TEAM_FREE;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 470
;470:				}
line 471
;471:				break;
ADDRGP4 $365
JUMPV
LABELV $373
line 474
;472:			case GT_TOURNAMENT:
;473:				// if the game is full, go into a waiting mode
;474:				if ( level.numNonSpectatorClients >= 2 ) {
ADDRGP4 level+121
INDIRU1
CVUI4 1
CNSTI4 2
LTI4 $374
line 475
;475:					sess->sessionTeam = TEAM_SPECTATOR;
ADDRLP4 0
INDIRP4
CNSTI4 3
ASGNI4
line 476
;476:				} else {
ADDRGP4 $365
JUMPV
LABELV $374
line 477
;477:					sess->sessionTeam = TEAM_FREE;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 478
;478:				}
line 479
;479:				break;
LABELV $365
line 481
;480:			}
;481:		}
LABELV $363
line 482
;482:	}
LABELV $356
line 484
;483:
;484:	sess->spectatorState = SPECTATOR_FREE;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 1
ASGNI4
line 485
;485:	sess->spectatorTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 486
;486:	sess->aimType = 2;
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
CNSTI4 2
ASGNI4
line 487
;487:	sess->aimNudge = 0;
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
CNSTI4 0
ASGNI4
line 489
;488:
;489:	G_WriteClientSessionData( client );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_WriteClientSessionData
CALLV
pop
line 490
;490:}
LABELV $354
endproc G_InitSessionData 16 8
export G_InitWorldSession
proc G_InitWorldSession 1028 12
line 499
;491:
;492:
;493:/*
;494:==================
;495:G_InitWorldSession
;496:
;497:==================
;498:*/
;499:void G_InitWorldSession( void ) {
line 503
;500:	char	s[MAX_STRING_CHARS];
;501:	//int			gt;
;502:
;503:	trap_Cvar_VariableStringBuffer( "session", s, sizeof(s) );
ADDRGP4 $379
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 504
;504:	level.gt = atoi( s );
ADDRLP4 0
ARGP4
ADDRLP4 1024
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 level+112
ADDRLP4 1024
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 508
;505:	
;506:	// if the gametype changed since the last session, don't use any
;507:	// client sessions
;508:	if ( g_gametype.integer != level.gt ) {
ADDRGP4 g_gametype+12
INDIRI4
ADDRGP4 level+112
INDIRU1
CVUI4 1
EQI4 $381
line 509
;509:		level.newSession = qtrue;
ADDRGP4 level+108
CNSTI4 1
ASGNI4
line 510
;510:		G_Printf( "Gametype changed, clearing session data.\n" );
ADDRGP4 $386
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 511
;511:	}
LABELV $381
line 512
;512:}
LABELV $378
endproc G_InitWorldSession 1028 12
export G_WriteSessionData
proc G_WriteSessionData 8 8
line 520
;513:
;514:/*
;515:==================
;516:G_WriteSessionData
;517:
;518:==================
;519:*/
;520:void G_WriteSessionData( void ) {
line 523
;521:	int		i;
;522:
;523:	trap_Cvar_Set( "session", va("%i", g_gametype.integer) );
ADDRGP4 $388
ARGP4
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $379
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 525
;524:
;525:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $393
JUMPV
LABELV $390
line 526
;526:		if ( level.clients[i].pers.connected == CON_CONNECTED ) {
CNSTI4 10828
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $395
line 527
;527:			G_WriteClientSessionData( &level.clients[i] );
CNSTI4 10828
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ARGP4
ADDRGP4 G_WriteClientSessionData
CALLV
pop
line 528
;528:		}
LABELV $395
line 529
;529:	}
LABELV $391
line 525
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $393
ADDRLP4 0
INDIRI4
ADDRGP4 level+28
INDIRI4
LTI4 $390
line 531
;530:
;531:	G_WriteTaskData();
ADDRGP4 G_WriteTaskData
CALLV
pop
line 532
;532:	G_WriteGameSettings();
ADDRGP4 G_WriteGameSettings
CALLV
pop
line 533
;533:	G_WriteBans();
ADDRGP4 G_WriteBans
CALLV
pop
line 534
;534:}
LABELV $387
endproc G_WriteSessionData 8 8
import trap_RealTime
import Cmd_Timein_f
import Cmd_Timeout_f
import trap_SnapVector
import trap_GeneticParentsAndChildSelection
import trap_BotResetWeaponState
import trap_BotFreeWeaponState
import trap_BotAllocWeaponState
import trap_BotLoadWeaponWeights
import trap_BotGetWeaponInfo
import trap_BotChooseBestFightWeapon
import trap_BotAddAvoidSpot
import trap_BotInitMoveState
import trap_BotFreeMoveState
import trap_BotAllocMoveState
import trap_BotPredictVisiblePosition
import trap_BotMovementViewTarget
import trap_BotReachabilityArea
import trap_BotResetLastAvoidReach
import trap_BotResetAvoidReach
import trap_BotMoveInDirection
import trap_BotMoveToGoal
import trap_BotResetMoveState
import trap_BotFreeGoalState
import trap_BotAllocGoalState
import trap_BotMutateGoalFuzzyLogic
import trap_BotSaveGoalFuzzyLogic
import trap_BotInterbreedGoalFuzzyLogic
import trap_BotFreeItemWeights
import trap_BotLoadItemWeights
import trap_BotUpdateEntityItems
import trap_BotInitLevelItems
import trap_BotSetAvoidGoalTime
import trap_BotAvoidGoalTime
import trap_BotGetLevelItemGoal
import trap_BotGetMapLocationGoal
import trap_BotGetNextCampSpotGoal
import trap_BotItemGoalInVisButNotVisible
import trap_BotTouchingGoal
import trap_BotChooseNBGItem
import trap_BotChooseLTGItem
import trap_BotGetSecondGoal
import trap_BotGetTopGoal
import trap_BotGoalName
import trap_BotDumpGoalStack
import trap_BotDumpAvoidGoals
import trap_BotEmptyGoalStack
import trap_BotPopGoal
import trap_BotPushGoal
import trap_BotResetAvoidGoals
import trap_BotRemoveFromAvoidGoals
import trap_BotResetGoalState
import trap_BotSetChatName
import trap_BotSetChatGender
import trap_BotLoadChatFile
import trap_BotReplaceSynonyms
import trap_UnifyWhiteSpaces
import trap_BotMatchVariable
import trap_BotFindMatch
import trap_StringContains
import trap_BotGetChatMessage
import trap_BotEnterChat
import trap_BotChatLength
import trap_BotReplyChat
import trap_BotNumInitialChats
import trap_BotInitialChat
import trap_BotNumConsoleMessages
import trap_BotNextConsoleMessage
import trap_BotRemoveConsoleMessage
import trap_BotQueueConsoleMessage
import trap_BotFreeChatState
import trap_BotAllocChatState
import trap_Characteristic_String
import trap_Characteristic_BInteger
import trap_Characteristic_Integer
import trap_Characteristic_BFloat
import trap_Characteristic_Float
import trap_BotFreeCharacter
import trap_BotLoadCharacter
import trap_EA_ResetInput
import trap_EA_GetInput
import trap_EA_EndRegular
import trap_EA_View
import trap_EA_Move
import trap_EA_DelayedJump
import trap_EA_Jump
import trap_EA_SelectWeapon
import trap_EA_MoveRight
import trap_EA_MoveLeft
import trap_EA_MoveBack
import trap_EA_MoveForward
import trap_EA_MoveDown
import trap_EA_MoveUp
import trap_EA_Crouch
import trap_EA_Respawn
import trap_EA_Use
import trap_EA_Attack
import trap_EA_Talk
import trap_EA_Gesture
import trap_EA_Action
import trap_EA_Command
import trap_EA_SayTeam
import trap_EA_Say
import trap_AAS_PredictClientMovement
import trap_AAS_Swimming
import trap_AAS_AlternativeRouteGoals
import trap_AAS_PredictRoute
import trap_AAS_EnableRoutingArea
import trap_AAS_AreaTravelTimeToGoalArea
import trap_AAS_AreaReachability
import trap_AAS_IntForBSPEpairKey
import trap_AAS_FloatForBSPEpairKey
import trap_AAS_VectorForBSPEpairKey
import trap_AAS_ValueForBSPEpairKey
import trap_AAS_NextBSPEntity
import trap_AAS_PointContents
import trap_AAS_TraceAreas
import trap_AAS_PointReachabilityAreaIndex
import trap_AAS_PointAreaNum
import trap_AAS_Time
import trap_AAS_PresenceTypeBoundingBox
import trap_AAS_Initialized
import trap_AAS_EntityInfo
import trap_AAS_AreaInfo
import trap_AAS_BBoxAreas
import trap_BotUserCommand
import trap_BotGetServerCommand
import trap_BotGetSnapshotEntity
import trap_BotLibTest
import trap_BotLibUpdateEntity
import trap_BotLibLoadMap
import trap_BotLibStartFrame
import trap_BotLibDefine
import trap_BotLibVarGet
import trap_BotLibVarSet
import trap_BotLibShutdown
import trap_BotLibSetup
import trap_DebugPolygonDelete
import trap_DebugPolygonCreate
import trap_GetEntityToken
import trap_GetUsercmd
import trap_BotFreeClient
import trap_BotAllocateClient
import trap_EntityContact
import trap_EntitiesInBox
import trap_UnlinkEntity
import trap_LinkEntity
import trap_AreasConnected
import trap_AdjustAreaPortalState
import trap_InPVSIgnorePortals
import trap_InPVS
import trap_PointContents
import trap_Trace
import trap_SetBrushModel
import trap_GetServerinfo
import trap_SetUserinfo
import trap_GetUserinfo
import trap_GetConfigstring
import trap_SetConfigstring
import trap_SendServerCommand
import trap_DropClient
import trap_LocateGameData
import trap_Cvar_VariableStringBuffer
import trap_Cvar_VariableValue
import trap_Cvar_VariableIntegerValue
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_SendConsoleCommand
import trap_FS_Seek
import trap_FS_GetFileList
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_Args
import trap_Milliseconds
import trap_Error
import trap_Printf
import sv_allowUnnamed
import sv_motd8
import sv_motd7
import sv_motd6
import sv_motd5
import sv_motd4
import sv_motd3
import sv_motd2
import sv_motd1
import g_interference
import g_spawnProtection
import g_allowObliterate
import g_freezeAutothawTime
import g_freezeRoundRespawn
import g_DynamicGauntletCycle
import g_gauntletjumpRadius
import g_gauntletJumping
import g_gauntletKnockback
import sv_lock_cg_railHum_to
import g_allowSave
import g_AdminPassword
import g_fixMuzzleBug
import g_readyGrace
import g_allowReady
import g_sacrificeAnnounce
import g_flagSacrifice
import lastmap
import modname
import g_timeInGrace
import g_timeOutLength
import g_timeOutLimit
import g_allowHandicap
import g_pro_mode
import g_muteTourneyspecs
import g_muteSpecs
import g_fastSwitch
import g_fastRespawn
import weap_bfgCycle
import weap_plasmagunCycle
import weap_railgunCycle
import weap_rocketlauncherCycle
import weap_lightninggunCycle
import weap_grenadelauncherCycle
import weap_shotgunCycle
import weap_machinegunCycle
import weap_gauntletCycle
import weap_allowed
import weap_enableHook
import g_wpflags
import sv_fps
import g_delagProjectiles
import g_delagHitscan
import g_proxMineTimeout
import g_singlePlayer
import g_enableBreath
import g_enableDust
import g_rankings
import sv_lock_pmove
import pmove_msec
import pmove_fixed
import g_IU_ctf_sounds
import g_returnFlag
import g_DynamicRailgunCycle
import g_RailjumpRadius
import g_RailJumping
import g_teamKnockback
import g_railgunKnockback
import g_StaticKnockback
import g_SelfDamage
import g_FallingDamage
import g_allowLockedTeams
import g_gamemode
import g_smoothClients
import g_blueteam
import g_redteam
import g_cubeTimeout
import g_obeliskRespawnDelay
import g_obeliskRegenAmount
import g_obeliskRegenPeriod
import g_obeliskHealth
import g_teamForceBalance
import g_teamAutoJoin
import g_allowVote
import g_blood
import g_warmup
import g_motd
import g_synchronousClients
import g_weaponTeamRespawn
import g_weaponRespawn
import g_debugAlloc
import g_debugMove
import g_inactivity
import g_forcerespawn
import g_quadfactor
import g_knockback
import g_speed
import g_gravity
import g_needpass
import g_password
import g_friendlyFire
import g_capturelimit
import g_timelimit
import g_fraglimit
import g_dmflags
import sv_minRate
import g_restarted
import g_maxGameClients
import g_maxclients
import g_cheats
import g_dedicated
import g_gametype
import bans
import g_entities
import gameSettings
import tasks
import level
import InvulnerabilityEffect
import locationSpawn
import CheckDelay
import team_wins
import player_freeze
import is_body_freeze
import is_body
import DamageBody
import Body_free
import Persistant_spectator
import respawnSpectator
import Set_Client
import Set_spectator
import is_spectator
import Pickup_Team
import CheckTeamStatus
import TeamplayInfoMessage
import Team_GetLocationMsgByVec
import Team_GetLocationMsg
import Team_GetLocationByVec
import Team_GetLocation
import SelectCTFSpawnPoint
import Team_FreeEntity
import Team_ReturnFlag
import Team_InitGame
import Team_CheckHurtCarrier
import Team_FragBonuses
import Team_DroppedFlagThink
import AddTeamScore
import TeamColorString
import OtherTeamName
import TeamName
import OtherTeam
import BotTestAAS
import BotAIStartFrame
import BotAIShutdownClient
import BotAISetupClient
import BotAILoadMap
import BotAIShutdown
import BotAISetup
import BotInterbreedEndMatch
import Svcmd_BotList_f
import Svcmd_AddBot_f
import G_BotConnect
import G_RemoveQueuedBotBegin
import G_CheckBotSpawn
import G_GetBotInfoByName
import G_GetBotInfoByNumber
import G_InitBots
import Svcmd_AbortPodium_f
import SpawnModelsOnVictoryPads
import UpdateTournamentInfo
import G_WriteGameSetings
import Svcmd_GameMem_f
import G_InitMemory
import G_Alloc
import CheckObeliskAttack
import Team_CheckDroppedItem
import OnSameTeam
import ClassnameIsMover
import AnnounceFlagSacrifice
import PlayerHasFlagPowerup
import NoDropAreaBelow
import SpawnFlagAtLastKnownGood
import G_RunClient
import ClientEndFrame
import ClientThink
import ClientCommand
import ClientBegin
import ClientDisconnect
import ClientUserinfoChanged
import ClientConnect
import G_Error
import G_Printf
import SendScoreboardMessageToAllClients
import G_LogPrintf
import G_RunThink
import CheckTeamLeader
import SetLeader
import FindIntermissionPoint
import ReadyCheck
import DeathmatchScoreboardMessage
import G_SetStats
import MoveClientToIntermission
import FireWeapon
import ConsoleCommand
import SpotWouldTelefrag
import CalculateRanks
import AddScore
import player_die
import ClientSpawn
import InitBodyQue
import InitClientResp
import InitClientPersistant
import BeginIntermission
import respawn
import CopyToBodyQue
import SelectSpawnPoint
import SetClientViewAngle
import PickTeam
import TeamLeader
import TeamCount
import G_TimeShiftClient
import G_PredictPlayerMove
import G_UnTimeShiftClient
import G_UndoTimeShiftFor
import G_DoTimeShiftFor
import G_UnTimeShiftAllClients
import G_TimeShiftAllClients
import G_StoreHistory
import G_ResetHistory
import FireWeaponGrapple
import Weapon_HookThink
import Weapon_HookFree
import CheckGauntletJump
import CheckGauntletAttack
import CalcMuzzlePoint
import LogAccuracyHit
import TeleportPlayer
import trigger_teleporter_touch
import Touch_DoorTrigger
import G_RunMover
import fire_grapple
import fire_bfg
import fire_railgun
import fire_rocket
import fire_grenade
import fire_plasma
import fire_blaster
import G_RunMissile
import TossClientCubes
import CPM_RadiusDamage
import TossClientItems
import body_die
import G_InvulnerabilityEffect
import G_RadiusDamage
import G_Damage
import CanDamage
import BuildShaderStateConfig
import AddRemap
import G_SetOrigin
import G_AddEvent
import G_AddPredictableEvent
import vectoyaw
import vtos
import tv
import G_TouchSolids
import G_TouchTriggers
import G_EntitiesFree
import G_FreeEntity
import G_Sound
import G_TempEntity
import G_Spawn
import G_InitGentity
import G_SetMovedir
import G_UseTargets
import G_PickTarget
import G_Find
import G_KillBox
import G_TeamCommand
import G_SoundIndex
import G_ModelIndex
import SaveRegisteredItems
import RegisterItem
import ClearRegisteredItems
import Touch_Item
import Add_Ammo
import ArmorIndex
import Think_Weapon
import FinishSpawningItem
import G_SpawnItem
import SetRespawn
import LaunchItem
import Drop_Item
import PrecacheItem
import UseHoldableItem
import RespawnItem
import G_RunItem
import G_CheckTeamItems
import Registered
import CheckForAutoUnlock
import FindMapNameForNumber
import Cmd_FollowCycle_f
import SetTeam
import BroadcastTeamChange
import StopFollowing
import Cmd_Score_f
import Cmd_Stats_f
import G_NewString
import G_SpawnEntitiesFromString
import G_SpawnVector
import G_SpawnInt
import G_SpawnFloat
import G_SpawnString
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
LABELV $388
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $386
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 100
byte 1 44
byte 1 32
byte 1 99
byte 1 108
byte 1 101
byte 1 97
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 115
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 100
byte 1 97
byte 1 116
byte 1 97
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $379
byte 1 115
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $361
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $350
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $346
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $272
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
byte 1 98
byte 1 97
byte 1 110
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
LABELV $269
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
byte 1 98
byte 1 97
byte 1 110
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
LABELV $268
byte 1 98
byte 1 97
byte 1 110
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $88
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $87
byte 1 114
byte 1 118
byte 1 111
byte 1 103
byte 1 115
byte 1 50
byte 1 0
align 1
LABELV $86
byte 1 114
byte 1 118
byte 1 111
byte 1 103
byte 1 115
byte 1 49
byte 1 0
align 1
LABELV $80
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $76
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $69
byte 1 115
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $68
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 0
