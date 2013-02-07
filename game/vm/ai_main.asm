export BotAI_Print
code
proc BotAI_Print 2056 12
file "../ai_main.c"
line 75
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:
;4:/*****************************************************************************
;5: * name:		ai_main.c
;6: *
;7: * desc:		Quake3 bot AI
;8: *
;9: * $Archive: /MissionPack/code/game/ai_main.c $
;10: *
;11: *****************************************************************************/
;12:
;13:
;14:#include "g_local.h"
;15:#include "q_shared.h"
;16:#include "botlib.h"		//bot lib interface
;17:#include "be_aas.h"
;18:#include "be_ea.h"
;19:#include "be_ai_char.h"
;20:#include "be_ai_chat.h"
;21:#include "be_ai_gen.h"
;22:#include "be_ai_goal.h"
;23:#include "be_ai_move.h"
;24:#include "be_ai_weap.h"
;25://
;26:#include "ai_main.h"
;27:#include "ai_dmq3.h"
;28:#include "ai_chat.h"
;29:#include "ai_cmd.h"
;30:#include "ai_dmnet.h"
;31:#include "ai_vcmd.h"
;32:
;33://
;34:#include "chars.h"
;35:#include "inv.h"
;36:#include "syn.h"
;37:
;38:#define MAX_PATH		144
;39:
;40:
;41://bot states
;42:bot_state_t	*botstates[MAX_CLIENTS];
;43://number of bots
;44:int numbots;
;45://floating point time
;46:float floattime;
;47://time to do a regular update
;48:float regularupdate_time;
;49://
;50:int bot_interbreed;
;51:int bot_interbreedmatchcount;
;52://
;53:vmCvar_t bot_thinktime;
;54:vmCvar_t bot_memorydump;
;55:vmCvar_t bot_saveroutingcache;
;56:vmCvar_t bot_pause;
;57:vmCvar_t bot_report;
;58:vmCvar_t bot_testsolid;
;59:vmCvar_t bot_testclusters;
;60:vmCvar_t bot_developer;
;61:vmCvar_t bot_interbreedchar;
;62:vmCvar_t bot_interbreedbots;
;63:vmCvar_t bot_interbreedcycle;
;64:vmCvar_t bot_interbreedwrite;
;65:
;66:
;67:void ExitLevel( void );
;68:
;69:
;70:/*
;71:==================
;72:BotAI_Print
;73:==================
;74:*/
;75:void QDECL BotAI_Print(int type, char *fmt, ...) {
line 79
;76:	char str[2048];
;77:	va_list ap;
;78:
;79:	va_start(ap, fmt);
ADDRLP4 0
ADDRFP4 4+4
ASGNP4
line 80
;80:	vsprintf(str, fmt, ap);
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 81
;81:	va_end(ap);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 83
;82:
;83:	switch(type) {
ADDRLP4 2052
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 2052
INDIRI4
CNSTI4 1
LTI4 $70
ADDRLP4 2052
INDIRI4
CNSTI4 5
GTI4 $70
ADDRLP4 2052
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $83-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $83
address $72
address $74
address $76
address $78
address $80
code
LABELV $72
line 84
;84:		case PRT_MESSAGE: {
line 85
;85:			G_Printf("%s", str);
ADDRGP4 $73
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 86
;86:			break;
ADDRGP4 $71
JUMPV
LABELV $74
line 88
;87:		}
;88:		case PRT_WARNING: {
line 89
;89:			G_Printf( S_COLOR_YELLOW "Warning: %s", str );
ADDRGP4 $75
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 90
;90:			break;
ADDRGP4 $71
JUMPV
LABELV $76
line 92
;91:		}
;92:		case PRT_ERROR: {
line 93
;93:			G_Printf( S_COLOR_RED "Error: %s", str );
ADDRGP4 $77
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 94
;94:			break;
ADDRGP4 $71
JUMPV
LABELV $78
line 96
;95:		}
;96:		case PRT_FATAL: {
line 97
;97:			G_Printf( S_COLOR_RED "Fatal: %s", str );
ADDRGP4 $79
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 98
;98:			break;
ADDRGP4 $71
JUMPV
LABELV $80
line 100
;99:		}
;100:		case PRT_EXIT: {
line 101
;101:			G_Error( S_COLOR_RED "Exit: %s", str );
ADDRGP4 $81
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 102
;102:			break;
ADDRGP4 $71
JUMPV
LABELV $70
line 104
;103:		}
;104:		default: {
line 105
;105:			G_Printf( "unknown print type\n" );
ADDRGP4 $82
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 106
;106:			break;
LABELV $71
line 109
;107:		}
;108:	}
;109:}
LABELV $68
endproc BotAI_Print 2056 12
export BotAI_Trace
proc BotAI_Trace 56 28
line 117
;110:
;111:
;112:/*
;113:==================
;114:BotAI_Trace
;115:==================
;116:*/
;117:void BotAI_Trace(bsp_trace_t *bsptrace, vec3_t start, vec3_t mins, vec3_t maxs, vec3_t end, int passent, int contentmask) {
line 120
;118:	trace_t trace;
;119:
;120:	trap_Trace(&trace, start, mins, maxs, end, passent, contentmask);
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 20
INDIRI4
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 122
;121:	//copy the trace information
;122:	bsptrace->allsolid = trace.allsolid;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRI4
ASGNI4
line 123
;123:	bsptrace->startsolid = trace.startsolid;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0+4
INDIRI4
ASGNI4
line 124
;124:	bsptrace->fraction = trace.fraction;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0+8
INDIRF4
ASGNF4
line 125
;125:	VectorCopy(trace.endpos, bsptrace->endpos);
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 0+12
INDIRB
ASGNB 12
line 126
;126:	bsptrace->plane.dist = trace.plane.dist;
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 0+24+12
INDIRF4
ASGNF4
line 127
;127:	VectorCopy(trace.plane.normal, bsptrace->plane.normal);
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 0+24
INDIRB
ASGNB 12
line 128
;128:	bsptrace->plane.signbits = trace.plane.signbits;
ADDRFP4 0
INDIRP4
CNSTI4 41
ADDP4
ADDRLP4 0+24+17
INDIRU1
ASGNU1
line 129
;129:	bsptrace->plane.type = trace.plane.type;
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 0+24+16
INDIRU1
ASGNU1
line 130
;130:	bsptrace->surface.value = trace.surfaceFlags;
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 0+44
INDIRI4
ASGNI4
line 131
;131:	bsptrace->ent = trace.entityNum;
ADDRFP4 0
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 0+52
INDIRI4
ASGNI4
line 132
;132:	bsptrace->exp_dist = 0;
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTF4 0
ASGNF4
line 133
;133:	bsptrace->sidenum = 0;
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 134
;134:	bsptrace->contents = 0;
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
CNSTI4 0
ASGNI4
line 135
;135:}
LABELV $85
endproc BotAI_Trace 56 28
export BotAI_GetClientState
proc BotAI_GetClientState 4 12
line 142
;136:
;137:/*
;138:==================
;139:BotAI_GetClientState
;140:==================
;141:*/
;142:int BotAI_GetClientState( int clientNum, playerState_t *state ) {
line 145
;143:	gentity_t	*ent;
;144:
;145:	ent = &g_entities[clientNum];
ADDRLP4 0
CNSTI4 896
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 146
;146:	if ( !ent->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $99
line 147
;147:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $98
JUMPV
LABELV $99
line 149
;148:	}
;149:	if ( !ent->client ) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $101
line 150
;150:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $98
JUMPV
LABELV $101
line 153
;151:	}
;152:
;153:	memcpy( state, &ent->client->ps, sizeof(playerState_t) );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
CNSTI4 468
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 154
;154:	return qtrue;
CNSTI4 1
RETI4
LABELV $98
endproc BotAI_GetClientState 4 12
export BotAI_GetEntityState
proc BotAI_GetEntityState 4 12
line 162
;155:}
;156:
;157:/*
;158:==================
;159:BotAI_GetEntityState
;160:==================
;161:*/
;162:int BotAI_GetEntityState( int entityNum, entityState_t *state ) {
line 165
;163:	gentity_t	*ent;
;164:
;165:	ent = &g_entities[entityNum];
ADDRLP4 0
CNSTI4 896
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 166
;166:	memset( state, 0, sizeof(entityState_t) );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 208
ARGI4
ADDRGP4 memset
CALLP4
pop
line 167
;167:	if (!ent->inuse) return qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $104
CNSTI4 0
RETI4
ADDRGP4 $103
JUMPV
LABELV $104
line 168
;168:	if (!ent->r.linked) return qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
NEI4 $106
CNSTI4 0
RETI4
ADDRGP4 $103
JUMPV
LABELV $106
line 169
;169:	if (ent->r.svFlags & SVF_NOCLIENT) return qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $108
CNSTI4 0
RETI4
ADDRGP4 $103
JUMPV
LABELV $108
line 170
;170:	memcpy( state, &ent->s, sizeof(entityState_t) );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 208
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 171
;171:	return qtrue;
CNSTI4 1
RETI4
LABELV $103
endproc BotAI_GetEntityState 4 12
export BotAI_GetSnapshotEntity
proc BotAI_GetSnapshotEntity 8 12
line 179
;172:}
;173:
;174:/*
;175:==================
;176:BotAI_GetSnapshotEntity
;177:==================
;178:*/
;179:int BotAI_GetSnapshotEntity( int clientNum, int sequence, entityState_t *state ) {
line 182
;180:	int		entNum;
;181:
;182:	entNum = trap_BotGetSnapshotEntity( clientNum, sequence );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 trap_BotGetSnapshotEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 183
;183:	if ( entNum == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $111
line 184
;184:		memset(state, 0, sizeof(entityState_t));
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 208
ARGI4
ADDRGP4 memset
CALLP4
pop
line 185
;185:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $110
JUMPV
LABELV $111
line 188
;186:	}
;187:
;188:	BotAI_GetEntityState( entNum, state );
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 BotAI_GetEntityState
CALLI4
pop
line 190
;189:
;190:	return sequence + 1;
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
RETI4
LABELV $110
endproc BotAI_GetSnapshotEntity 8 12
export BotAI_BotInitialChat
proc BotAI_BotInitialChat 56 44
line 198
;191:}
;192:
;193:/*
;194:==================
;195:BotAI_BotInitialChat
;196:==================
;197:*/
;198:void QDECL BotAI_BotInitialChat( bot_state_t *bs, char *type, ... ) {
line 204
;199:	int		i, mcontext;
;200:	va_list	ap;
;201:	char	*p;
;202:	char	*vars[MAX_MATCHVARIABLES];
;203:
;204:	memset(vars, 0, sizeof(vars));
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
CNSTI4 32
ARGI4
ADDRGP4 memset
CALLP4
pop
line 205
;205:	va_start(ap, type);
ADDRLP4 40
ADDRFP4 4+4
ASGNP4
line 206
;206:	p = va_arg(ap, char *);
ADDRLP4 48
ADDRLP4 40
INDIRP4
CNSTU4 4
ADDP4
ASGNP4
ADDRLP4 40
ADDRLP4 48
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 48
INDIRP4
CNSTI4 -4
ADDP4
INDIRP4
ASGNP4
line 207
;207:	for (i = 0; i < MAX_MATCHVARIABLES; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $115
line 208
;208:		if( !p ) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $119
line 209
;209:			break;
ADDRGP4 $117
JUMPV
LABELV $119
line 211
;210:		}
;211:		vars[i] = p;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 212
;212:		p = va_arg(ap, char *);
ADDRLP4 52
ADDRLP4 40
INDIRP4
CNSTU4 4
ADDP4
ASGNP4
ADDRLP4 40
ADDRLP4 52
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 52
INDIRP4
CNSTI4 -4
ADDP4
INDIRP4
ASGNP4
line 213
;213:	}
LABELV $116
line 207
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 8
LTI4 $115
LABELV $117
line 214
;214:	va_end(ap);
ADDRLP4 40
CNSTP4 0
ASGNP4
line 216
;215:
;216:	mcontext = BotSynonymContext(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 BotSynonymContext
CALLI4
ASGNI4
ADDRLP4 44
ADDRLP4 52
INDIRI4
ASGNI4
line 218
;217:
;218:	trap_BotInitialChat( bs->cs, type, mcontext, vars[0], vars[1], vars[2], vars[3], vars[4], vars[5], vars[6], vars[7] );
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8+4
INDIRP4
ARGP4
ADDRLP4 8+8
INDIRP4
ARGP4
ADDRLP4 8+12
INDIRP4
ARGP4
ADDRLP4 8+16
INDIRP4
ARGP4
ADDRLP4 8+20
INDIRP4
ARGP4
ADDRLP4 8+24
INDIRP4
ARGP4
ADDRLP4 8+28
INDIRP4
ARGP4
ADDRGP4 trap_BotInitialChat
CALLV
pop
line 219
;219:}
LABELV $113
endproc BotAI_BotInitialChat 56 44
export BotTestAAS
proc BotTestAAS 64 16
line 227
;220:
;221:
;222:/*
;223:==================
;224:BotTestAAS
;225:==================
;226:*/
;227:void BotTestAAS(vec3_t origin) {
line 231
;228:	int areanum;
;229:	aas_areainfo_t info;
;230:
;231:	trap_Cvar_Update(&bot_testsolid);
ADDRGP4 bot_testsolid
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 232
;232:	trap_Cvar_Update(&bot_testclusters);
ADDRGP4 bot_testclusters
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 233
;233:	if (bot_testsolid.integer) {
ADDRGP4 bot_testsolid+12
INDIRI4
CNSTI4 0
EQI4 $129
line 234
;234:		if (!trap_AAS_Initialized()) return;
ADDRLP4 56
ADDRGP4 trap_AAS_Initialized
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $132
ADDRGP4 $128
JUMPV
LABELV $132
line 235
;235:		areanum = BotPointAreaNum(origin);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 60
INDIRI4
ASGNI4
line 236
;236:		if (areanum) BotAI_Print(PRT_MESSAGE, "\remtpy area");
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $134
CNSTI4 1
ARGI4
ADDRGP4 $136
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
ADDRGP4 $130
JUMPV
LABELV $134
line 237
;237:		else BotAI_Print(PRT_MESSAGE, "\r^1SOLID area");
CNSTI4 1
ARGI4
ADDRGP4 $137
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 238
;238:	}
ADDRGP4 $130
JUMPV
LABELV $129
line 239
;239:	else if (bot_testclusters.integer) {
ADDRGP4 bot_testclusters+12
INDIRI4
CNSTI4 0
EQI4 $138
line 240
;240:		if (!trap_AAS_Initialized()) return;
ADDRLP4 56
ADDRGP4 trap_AAS_Initialized
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $141
ADDRGP4 $128
JUMPV
LABELV $141
line 241
;241:		areanum = BotPointAreaNum(origin);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 60
INDIRI4
ASGNI4
line 242
;242:		if (!areanum)
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $143
line 243
;243:			BotAI_Print(PRT_MESSAGE, "\r^1Solid!                              ");
CNSTI4 1
ARGI4
ADDRGP4 $145
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
ADDRGP4 $144
JUMPV
LABELV $143
line 244
;244:		else {
line 245
;245:			trap_AAS_AreaInfo(areanum, &info);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_AAS_AreaInfo
CALLI4
pop
line 246
;246:			BotAI_Print(PRT_MESSAGE, "\rarea %d, cluster %d       ", areanum, info.cluster);
CNSTI4 1
ARGI4
ADDRGP4 $146
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4+12
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 247
;247:		}
LABELV $144
line 248
;248:	}
LABELV $138
LABELV $130
line 249
;249:}
LABELV $128
endproc BotTestAAS 64 16
export BotReportStatus
proc BotReportStatus 560 24
line 256
;250:
;251:/*
;252:==================
;253:BotReportStatus
;254:==================
;255:*/
;256:void BotReportStatus(bot_state_t *bs) {
line 261
;257:	char goalname[MAX_MESSAGE_SIZE];
;258:	char netname[MAX_MESSAGE_SIZE];
;259:	char *leader, flagstatus[32];
;260:	//
;261:	ClientName(bs->client, netname, sizeof(netname));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 262
;262:	if (Q_stricmp(netname, bs->teamleader) == 0) leader = "L";
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
ARGP4
ADDRLP4 548
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 548
INDIRI4
CNSTI4 0
NEI4 $149
ADDRLP4 288
ADDRGP4 $151
ASGNP4
ADDRGP4 $150
JUMPV
LABELV $149
line 263
;263:	else leader = " ";
ADDRLP4 288
ADDRGP4 $152
ASGNP4
LABELV $150
line 265
;264:
;265:	strcpy(flagstatus, "  ");
ADDRLP4 256
ARGP4
ADDRGP4 $153
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 266
;266:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $154
line 267
;267:		if (BotCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 552
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 552
INDIRI4
CNSTI4 0
EQI4 $156
line 268
;268:			if (BotTeam(bs) == TEAM_RED) strcpy(flagstatus, S_COLOR_RED"F ");
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 556
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 556
INDIRI4
CNSTI4 1
NEI4 $158
ADDRLP4 256
ARGP4
ADDRGP4 $160
ARGP4
ADDRGP4 strcpy
CALLP4
pop
ADDRGP4 $159
JUMPV
LABELV $158
line 269
;269:			else strcpy(flagstatus, S_COLOR_BLUE"F ");
ADDRLP4 256
ARGP4
ADDRGP4 $161
ARGP4
ADDRGP4 strcpy
CALLP4
pop
LABELV $159
line 270
;270:		}
LABELV $156
line 271
;271:	}
LABELV $154
line 287
;272:#ifdef MISSIONPACK
;273:	else if (gametype == GT_1FCTF) {
;274:		if (Bot1FCTFCarryingFlag(bs)) {
;275:			if (BotTeam(bs) == TEAM_RED) strcpy(flagstatus, S_COLOR_RED"F ");
;276:			else strcpy(flagstatus, S_COLOR_BLUE"F ");
;277:		}
;278:	}
;279:	else if (gametype == GT_HARVESTER) {
;280:		if (BotHarvesterCarryingCubes(bs)) {
;281:			if (BotTeam(bs) == TEAM_RED) Com_sprintf(flagstatus, sizeof(flagstatus), S_COLOR_RED"%2d", bs->inventory[INVENTORY_REDCUBE]);
;282:			else Com_sprintf(flagstatus, sizeof(flagstatus), S_COLOR_BLUE"%2d", bs->inventory[INVENTORY_BLUECUBE]);
;283:		}
;284:	}
;285:#endif
;286:
;287:	switch(bs->ltgtype) {
ADDRLP4 552
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
ASGNI4
ADDRLP4 552
INDIRI4
CNSTI4 1
LTI4 $162
ADDRLP4 552
INDIRI4
CNSTI4 13
GTI4 $162
ADDRLP4 552
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $190-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $190
address $165
address $167
address $169
address $179
address $181
address $183
address $175
address $175
address $177
address $171
address $173
address $187
address $185
code
LABELV $165
line 289
;288:		case LTG_TEAMHELP:
;289:		{
line 290
;290:			EasyClientName(bs->teammate, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 291
;291:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: helping %s\n", netname, leader, flagstatus, goalname);
CNSTI4 1
ARGI4
ADDRGP4 $166
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRLP4 292
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 292
;292:			break;
ADDRGP4 $163
JUMPV
LABELV $167
line 295
;293:		}
;294:		case LTG_TEAMACCOMPANY:
;295:		{
line 296
;296:			EasyClientName(bs->teammate, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 297
;297:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: accompanying %s\n", netname, leader, flagstatus, goalname);
CNSTI4 1
ARGI4
ADDRGP4 $168
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRLP4 292
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 298
;298:			break;
ADDRGP4 $163
JUMPV
LABELV $169
line 301
;299:		}
;300:		case LTG_DEFENDKEYAREA:
;301:		{
line 302
;302:			trap_BotGoalName(bs->teamgoal.number, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6668
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 303
;303:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: defending %s\n", netname, leader, flagstatus, goalname);
CNSTI4 1
ARGI4
ADDRGP4 $170
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRLP4 292
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 304
;304:			break;
ADDRGP4 $163
JUMPV
LABELV $171
line 307
;305:		}
;306:		case LTG_GETITEM:
;307:		{
line 308
;308:			trap_BotGoalName(bs->teamgoal.number, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6668
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 309
;309:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: getting item %s\n", netname, leader, flagstatus, goalname);
CNSTI4 1
ARGI4
ADDRGP4 $172
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRLP4 292
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 310
;310:			break;
ADDRGP4 $163
JUMPV
LABELV $173
line 313
;311:		}
;312:		case LTG_KILL:
;313:		{
line 314
;314:			ClientName(bs->teamgoal.entitynum, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6664
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 315
;315:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: killing %s\n", netname, leader, flagstatus, goalname);
CNSTI4 1
ARGI4
ADDRGP4 $174
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRLP4 292
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 316
;316:			break;
ADDRGP4 $163
JUMPV
LABELV $175
line 320
;317:		}
;318:		case LTG_CAMP:
;319:		case LTG_CAMPORDER:
;320:		{
line 321
;321:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: camping\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $176
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 322
;322:			break;
ADDRGP4 $163
JUMPV
LABELV $177
line 325
;323:		}
;324:		case LTG_PATROL:
;325:		{
line 326
;326:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: patrolling\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $178
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 327
;327:			break;
ADDRGP4 $163
JUMPV
LABELV $179
line 330
;328:		}
;329:		case LTG_GETFLAG:
;330:		{
line 331
;331:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: capturing flag\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $180
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 332
;332:			break;
ADDRGP4 $163
JUMPV
LABELV $181
line 335
;333:		}
;334:		case LTG_RUSHBASE:
;335:		{
line 336
;336:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: rushing base\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $182
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 337
;337:			break;
ADDRGP4 $163
JUMPV
LABELV $183
line 340
;338:		}
;339:		case LTG_RETURNFLAG:
;340:		{
line 341
;341:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: returning flag\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $184
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 342
;342:			break;
ADDRGP4 $163
JUMPV
LABELV $185
line 345
;343:		}
;344:		case LTG_ATTACKENEMYBASE:
;345:		{
line 346
;346:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: attacking the enemy base\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $186
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 347
;347:			break;
ADDRGP4 $163
JUMPV
LABELV $187
line 350
;348:		}
;349:		case LTG_HARVEST:
;350:		{
line 351
;351:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: harvesting\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $188
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 352
;352:			break;
ADDRGP4 $163
JUMPV
LABELV $162
line 355
;353:		}
;354:		default:
;355:		{
line 356
;356:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: roaming\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $189
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 357
;357:			break;
LABELV $163
line 360
;358:		}
;359:	}
;360:}
LABELV $148
endproc BotReportStatus 560 24
export BotTeamplayReport
proc BotTeamplayReport 1056 12
line 367
;361:
;362:/*
;363:==================
;364:BotTeamplayReport
;365:==================
;366:*/
;367:void BotTeamplayReport(void) {
line 371
;368:	int i;
;369:	char buf[MAX_INFO_STRING];
;370:
;371:	BotAI_Print(PRT_MESSAGE, S_COLOR_RED"RED\n");
CNSTI4 1
ARGI4
ADDRGP4 $193
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 372
;372:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $197
JUMPV
LABELV $194
line 374
;373:		//
;374:		if ( !botstates[i] || !botstates[i]->inuse ) continue;
ADDRLP4 1028
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1028
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $200
ADDRLP4 1028
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $198
LABELV $200
ADDRGP4 $195
JUMPV
LABELV $198
line 376
;375:		//
;376:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 378
;377:		//if no config string or no name
;378:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 4
ARGP4
ADDRLP4 1032
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
EQI4 $204
ADDRLP4 4
ARGP4
ADDRGP4 $203
ARGP4
ADDRLP4 1036
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1036
INDIRP4
ARGP4
ADDRLP4 1040
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $201
LABELV $204
ADDRGP4 $195
JUMPV
LABELV $201
line 380
;379:		//skip spectators
;380:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_RED) {
ADDRLP4 4
ARGP4
ADDRGP4 $207
ARGP4
ADDRLP4 1044
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1044
INDIRP4
ARGP4
ADDRLP4 1048
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 1
NEI4 $205
line 381
;381:			BotReportStatus(botstates[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotReportStatus
CALLV
pop
line 382
;382:		}
LABELV $205
line 383
;383:	}
LABELV $195
line 372
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $197
ADDRLP4 0
INDIRI4
ADDRGP4 maxclients
INDIRI4
GEI4 $208
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $194
LABELV $208
line 384
;384:	BotAI_Print(PRT_MESSAGE, S_COLOR_BLUE"BLUE\n");
CNSTI4 1
ARGI4
ADDRGP4 $209
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 385
;385:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $213
JUMPV
LABELV $210
line 387
;386:		//
;387:		if ( !botstates[i] || !botstates[i]->inuse ) continue;
ADDRLP4 1032
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1032
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $216
ADDRLP4 1032
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $214
LABELV $216
ADDRGP4 $211
JUMPV
LABELV $214
line 389
;388:		//
;389:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 391
;390:		//if no config string or no name
;391:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 4
ARGP4
ADDRLP4 1036
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
EQI4 $219
ADDRLP4 4
ARGP4
ADDRGP4 $203
ARGP4
ADDRLP4 1040
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 1044
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $217
LABELV $219
ADDRGP4 $211
JUMPV
LABELV $217
line 393
;392:		//skip spectators
;393:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_BLUE) {
ADDRLP4 4
ARGP4
ADDRGP4 $207
ARGP4
ADDRLP4 1048
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1048
INDIRP4
ARGP4
ADDRLP4 1052
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 2
NEI4 $220
line 394
;394:			BotReportStatus(botstates[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotReportStatus
CALLV
pop
line 395
;395:		}
LABELV $220
line 396
;396:	}
LABELV $211
line 385
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $213
ADDRLP4 0
INDIRI4
ADDRGP4 maxclients
INDIRI4
GEI4 $222
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $210
LABELV $222
line 397
;397:}
LABELV $192
endproc BotTeamplayReport 1056 12
export BotSetInfoConfigString
proc BotSetInfoConfigString 880 16
line 404
;398:
;399:/*
;400:==================
;401:BotSetInfoConfigString
;402:==================
;403:*/
;404:void BotSetInfoConfigString(bot_state_t *bs) {
line 411
;405:	char goalname[MAX_MESSAGE_SIZE];
;406:	char netname[MAX_MESSAGE_SIZE];
;407:	char action[MAX_MESSAGE_SIZE];
;408:	char *leader, carrying[32], *cs;
;409:	bot_goal_t goal;
;410:	//
;411:	ClientName(bs->client, netname, sizeof(netname));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 256
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 412
;412:	if (Q_stricmp(netname, bs->teamleader) == 0) leader = "L";
ADDRLP4 256
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
ARGP4
ADDRLP4 864
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 864
INDIRI4
CNSTI4 0
NEI4 $224
ADDRLP4 544
ADDRGP4 $151
ASGNP4
ADDRGP4 $225
JUMPV
LABELV $224
line 413
;413:	else leader = " ";
ADDRLP4 544
ADDRGP4 $152
ASGNP4
LABELV $225
line 415
;414:
;415:	strcpy(carrying, "  ");
ADDRLP4 512
ARGP4
ADDRGP4 $153
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 416
;416:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 4
NEI4 $226
line 417
;417:		if (BotCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 868
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 868
INDIRI4
CNSTI4 0
EQI4 $228
line 418
;418:			strcpy(carrying, "F ");
ADDRLP4 512
ARGP4
ADDRGP4 $230
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 419
;419:		}
LABELV $228
line 420
;420:	}
LABELV $226
line 435
;421:#ifdef MISSIONPACK
;422:	else if (gametype == GT_1FCTF) {
;423:		if (Bot1FCTFCarryingFlag(bs)) {
;424:			strcpy(carrying, "F ");
;425:		}
;426:	}
;427:	else if (gametype == GT_HARVESTER) {
;428:		if (BotHarvesterCarryingCubes(bs)) {
;429:			if (BotTeam(bs) == TEAM_RED) Com_sprintf(carrying, sizeof(carrying), "%2d", bs->inventory[INVENTORY_REDCUBE]);
;430:			else Com_sprintf(carrying, sizeof(carrying), "%2d", bs->inventory[INVENTORY_BLUECUBE]);
;431:		}
;432:	}
;433:#endif
;434:
;435:	switch(bs->ltgtype) {
ADDRLP4 868
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
ASGNI4
ADDRLP4 868
INDIRI4
CNSTI4 1
LTI4 $231
ADDRLP4 868
INDIRI4
CNSTI4 13
GTI4 $231
ADDRLP4 868
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $260-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $260
address $234
address $236
address $238
address $248
address $250
address $252
address $244
address $244
address $246
address $240
address $242
address $256
address $254
code
LABELV $234
line 437
;436:		case LTG_TEAMHELP:
;437:		{
line 438
;438:			EasyClientName(bs->teammate, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRLP4 552
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 439
;439:			Com_sprintf(action, sizeof(action), "helping %s", goalname);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $235
ARGP4
ADDRLP4 552
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 440
;440:			break;
ADDRGP4 $232
JUMPV
LABELV $236
line 443
;441:		}
;442:		case LTG_TEAMACCOMPANY:
;443:		{
line 444
;444:			EasyClientName(bs->teammate, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRLP4 552
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 445
;445:			Com_sprintf(action, sizeof(action), "accompanying %s", goalname);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $237
ARGP4
ADDRLP4 552
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 446
;446:			break;
ADDRGP4 $232
JUMPV
LABELV $238
line 449
;447:		}
;448:		case LTG_DEFENDKEYAREA:
;449:		{
line 450
;450:			trap_BotGoalName(bs->teamgoal.number, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6668
ADDP4
INDIRI4
ARGI4
ADDRLP4 552
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 451
;451:			Com_sprintf(action, sizeof(action), "defending %s", goalname);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $239
ARGP4
ADDRLP4 552
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 452
;452:			break;
ADDRGP4 $232
JUMPV
LABELV $240
line 455
;453:		}
;454:		case LTG_GETITEM:
;455:		{
line 456
;456:			trap_BotGoalName(bs->teamgoal.number, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6668
ADDP4
INDIRI4
ARGI4
ADDRLP4 552
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 457
;457:			Com_sprintf(action, sizeof(action), "getting item %s", goalname);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $241
ARGP4
ADDRLP4 552
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 458
;458:			break;
ADDRGP4 $232
JUMPV
LABELV $242
line 461
;459:		}
;460:		case LTG_KILL:
;461:		{
line 462
;462:			ClientName(bs->teamgoal.entitynum, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6664
ADDP4
INDIRI4
ARGI4
ADDRLP4 552
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 463
;463:			Com_sprintf(action, sizeof(action), "killing %s", goalname);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $243
ARGP4
ADDRLP4 552
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 464
;464:			break;
ADDRGP4 $232
JUMPV
LABELV $244
line 468
;465:		}
;466:		case LTG_CAMP:
;467:		case LTG_CAMPORDER:
;468:		{
line 469
;469:			Com_sprintf(action, sizeof(action), "camping");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $245
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 470
;470:			break;
ADDRGP4 $232
JUMPV
LABELV $246
line 473
;471:		}
;472:		case LTG_PATROL:
;473:		{
line 474
;474:			Com_sprintf(action, sizeof(action), "patrolling");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $247
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 475
;475:			break;
ADDRGP4 $232
JUMPV
LABELV $248
line 478
;476:		}
;477:		case LTG_GETFLAG:
;478:		{
line 479
;479:			Com_sprintf(action, sizeof(action), "capturing flag");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $249
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 480
;480:			break;
ADDRGP4 $232
JUMPV
LABELV $250
line 483
;481:		}
;482:		case LTG_RUSHBASE:
;483:		{
line 484
;484:			Com_sprintf(action, sizeof(action), "rushing base");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $251
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 485
;485:			break;
ADDRGP4 $232
JUMPV
LABELV $252
line 488
;486:		}
;487:		case LTG_RETURNFLAG:
;488:		{
line 489
;489:			Com_sprintf(action, sizeof(action), "returning flag");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $253
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 490
;490:			break;
ADDRGP4 $232
JUMPV
LABELV $254
line 493
;491:		}
;492:		case LTG_ATTACKENEMYBASE:
;493:		{
line 494
;494:			Com_sprintf(action, sizeof(action), "attacking the enemy base");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $255
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 495
;495:			break;
ADDRGP4 $232
JUMPV
LABELV $256
line 498
;496:		}
;497:		case LTG_HARVEST:
;498:		{
line 499
;499:			Com_sprintf(action, sizeof(action), "harvesting");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $257
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 500
;500:			break;
ADDRGP4 $232
JUMPV
LABELV $231
line 503
;501:		}
;502:		default:
;503:		{
line 504
;504:			trap_BotGetTopGoal(bs->gs, &goal);
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRLP4 808
ARGP4
ADDRGP4 trap_BotGetTopGoal
CALLI4
pop
line 505
;505:			trap_BotGoalName(goal.number, goalname, sizeof(goalname));
ADDRLP4 808+44
INDIRI4
ARGI4
ADDRLP4 552
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 506
;506:			Com_sprintf(action, sizeof(action), "roaming %s", goalname);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $259
ARGP4
ADDRLP4 552
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 507
;507:			break;
LABELV $232
line 510
;508:		}
;509:	}
;510:  	cs = va("l\\%s\\c\\%s\\a\\%s",
ADDRGP4 $262
ARGP4
ADDRLP4 544
INDIRP4
ARGP4
ADDRLP4 512
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 876
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 548
ADDRLP4 876
INDIRP4
ASGNP4
line 514
;511:				leader,
;512:				carrying,
;513:				action);
;514:  	trap_SetConfigstring (CS_BOTINFO + bs->client, cs);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 25
ADDI4
ARGI4
ADDRLP4 548
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 515
;515:}
LABELV $223
endproc BotSetInfoConfigString 880 16
export BotUpdateInfoConfigStrings
proc BotUpdateInfoConfigStrings 1044 12
line 522
;516:
;517:/*
;518:==============
;519:BotUpdateInfoConfigStrings
;520:==============
;521:*/
;522:void BotUpdateInfoConfigStrings(void) {
line 526
;523:	int i;
;524:	char buf[MAX_INFO_STRING];
;525:
;526:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $267
JUMPV
LABELV $264
line 528
;527:		//
;528:		if ( !botstates[i] || !botstates[i]->inuse )
ADDRLP4 1028
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1028
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $270
ADDRLP4 1028
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $268
LABELV $270
line 529
;529:			continue;
ADDRGP4 $265
JUMPV
LABELV $268
line 531
;530:		//
;531:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 533
;532:		//if no config string or no name
;533:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n")))
ADDRLP4 4
ARGP4
ADDRLP4 1032
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
EQI4 $273
ADDRLP4 4
ARGP4
ADDRGP4 $203
ARGP4
ADDRLP4 1036
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1036
INDIRP4
ARGP4
ADDRLP4 1040
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $271
LABELV $273
line 534
;534:			continue;
ADDRGP4 $265
JUMPV
LABELV $271
line 535
;535:		BotSetInfoConfigString(botstates[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotSetInfoConfigString
CALLV
pop
line 536
;536:	}
LABELV $265
line 526
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $267
ADDRLP4 0
INDIRI4
ADDRGP4 maxclients
INDIRI4
GEI4 $274
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $264
LABELV $274
line 537
;537:}
LABELV $263
endproc BotUpdateInfoConfigStrings 1044 12
export BotInterbreedBots
proc BotInterbreedBots 288 20
line 544
;538:
;539:/*
;540:==============
;541:BotInterbreedBots
;542:==============
;543:*/
;544:void BotInterbreedBots(void) {
line 550
;545:	float ranks[MAX_CLIENTS];
;546:	int parent1, parent2, child;
;547:	int i;
;548:
;549:	// get rankings for all the bots
;550:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $276
line 551
;551:		if ( botstates[i] && botstates[i]->inuse ) {
ADDRLP4 272
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 272
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $280
ADDRLP4 272
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $280
line 552
;552:			ranks[i] = botstates[i]->num_kills * 2 - botstates[i]->num_deaths;
ADDRLP4 276
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 280
ADDRLP4 276
INDIRI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 276
INDIRI4
ADDRLP4 4
ADDP4
ADDRLP4 280
INDIRP4
CNSTI4 6032
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 280
INDIRP4
CNSTI4 6028
ADDP4
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 553
;553:		}
ADDRGP4 $281
JUMPV
LABELV $280
line 554
;554:		else {
line 555
;555:			ranks[i] = -1;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 3212836864
ASGNF4
line 556
;556:		}
LABELV $281
line 557
;557:	}
LABELV $277
line 550
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $276
line 559
;558:
;559:	if (trap_GeneticParentsAndChildSelection(MAX_CLIENTS, ranks, &parent1, &parent2, &child)) {
CNSTI4 64
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 264
ARGP4
ADDRLP4 268
ARGP4
ADDRLP4 260
ARGP4
ADDRLP4 272
ADDRGP4 trap_GeneticParentsAndChildSelection
CALLI4
ASGNI4
ADDRLP4 272
INDIRI4
CNSTI4 0
EQI4 $282
line 560
;560:		trap_BotInterbreedGoalFuzzyLogic(botstates[parent1]->gs, botstates[parent2]->gs, botstates[child]->gs);
ADDRLP4 276
CNSTI4 2
ASGNI4
ADDRLP4 280
ADDRGP4 botstates
ASGNP4
ADDRLP4 284
CNSTI4 6528
ASGNI4
ADDRLP4 264
INDIRI4
ADDRLP4 276
INDIRI4
LSHI4
ADDRLP4 280
INDIRP4
ADDP4
INDIRP4
ADDRLP4 284
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRLP4 268
INDIRI4
ADDRLP4 276
INDIRI4
LSHI4
ADDRLP4 280
INDIRP4
ADDP4
INDIRP4
ADDRLP4 284
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
INDIRI4
ADDRLP4 276
INDIRI4
LSHI4
ADDRLP4 280
INDIRP4
ADDP4
INDIRP4
ADDRLP4 284
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotInterbreedGoalFuzzyLogic
CALLV
pop
line 561
;561:		trap_BotMutateGoalFuzzyLogic(botstates[child]->gs, 1);
ADDRLP4 260
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_BotMutateGoalFuzzyLogic
CALLV
pop
line 562
;562:	}
LABELV $282
line 564
;563:	// reset the kills and deaths
;564:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $284
line 565
;565:		if (botstates[i] && botstates[i]->inuse) {
ADDRLP4 276
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 276
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $288
ADDRLP4 276
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $288
line 566
;566:			botstates[i]->num_kills = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 6032
ADDP4
CNSTI4 0
ASGNI4
line 567
;567:			botstates[i]->num_deaths = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 6028
ADDP4
CNSTI4 0
ASGNI4
line 568
;568:		}
LABELV $288
line 569
;569:	}
LABELV $285
line 564
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $284
line 570
;570:}
LABELV $275
endproc BotInterbreedBots 288 20
export BotWriteInterbreeded
proc BotWriteInterbreeded 24 8
line 577
;571:
;572:/*
;573:==============
;574:BotWriteInterbreeded
;575:==============
;576:*/
;577:void BotWriteInterbreeded(char *filename) {
line 581
;578:	float rank, bestrank;
;579:	int i, bestbot;
;580:
;581:	bestrank = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 582
;582:	bestbot = -1;
ADDRLP4 12
CNSTI4 -1
ASGNI4
line 584
;583:	// get the best bot
;584:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $291
line 585
;585:		if ( botstates[i] && botstates[i]->inuse ) {
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $295
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $295
line 586
;586:			rank = botstates[i]->num_kills * 2 - botstates[i]->num_deaths;
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 20
INDIRP4
CNSTI4 6032
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 20
INDIRP4
CNSTI4 6028
ADDP4
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 587
;587:		}
ADDRGP4 $296
JUMPV
LABELV $295
line 588
;588:		else {
line 589
;589:			rank = -1;
ADDRLP4 4
CNSTF4 3212836864
ASGNF4
line 590
;590:		}
LABELV $296
line 591
;591:		if (rank > bestrank) {
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $297
line 592
;592:			bestrank = rank;
ADDRLP4 8
ADDRLP4 4
INDIRF4
ASGNF4
line 593
;593:			bestbot = i;
ADDRLP4 12
ADDRLP4 0
INDIRI4
ASGNI4
line 594
;594:		}
LABELV $297
line 595
;595:	}
LABELV $292
line 584
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $291
line 596
;596:	if (bestbot >= 0) {
ADDRLP4 12
INDIRI4
CNSTI4 0
LTI4 $299
line 598
;597:		//write out the new goal fuzzy logic
;598:		trap_BotSaveGoalFuzzyLogic(botstates[bestbot]->gs, filename);
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_BotSaveGoalFuzzyLogic
CALLV
pop
line 599
;599:	}
LABELV $299
line 600
;600:}
LABELV $290
endproc BotWriteInterbreeded 24 8
export BotInterbreedEndMatch
proc BotInterbreedEndMatch 8 8
line 609
;601:
;602:/*
;603:==============
;604:BotInterbreedEndMatch
;605:
;606:add link back into ExitLevel?
;607:==============
;608:*/
;609:void BotInterbreedEndMatch(void) {
line 611
;610:
;611:	if (!bot_interbreed) return;
ADDRGP4 bot_interbreed
INDIRI4
CNSTI4 0
NEI4 $302
ADDRGP4 $301
JUMPV
LABELV $302
line 612
;612:	bot_interbreedmatchcount++;
ADDRLP4 0
ADDRGP4 bot_interbreedmatchcount
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 613
;613:	if (bot_interbreedmatchcount >= bot_interbreedcycle.integer) {
ADDRGP4 bot_interbreedmatchcount
INDIRI4
ADDRGP4 bot_interbreedcycle+12
INDIRI4
LTI4 $304
line 614
;614:		bot_interbreedmatchcount = 0;
ADDRGP4 bot_interbreedmatchcount
CNSTI4 0
ASGNI4
line 616
;615:		//
;616:		trap_Cvar_Update(&bot_interbreedwrite);
ADDRGP4 bot_interbreedwrite
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 617
;617:		if (strlen(bot_interbreedwrite.string)) {
ADDRGP4 bot_interbreedwrite+16
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $307
line 618
;618:			BotWriteInterbreeded(bot_interbreedwrite.string);
ADDRGP4 bot_interbreedwrite+16
ARGP4
ADDRGP4 BotWriteInterbreeded
CALLV
pop
line 619
;619:			trap_Cvar_Set("bot_interbreedwrite", "");
ADDRGP4 $311
ARGP4
ADDRGP4 $312
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 620
;620:		}
LABELV $307
line 621
;621:		BotInterbreedBots();
ADDRGP4 BotInterbreedBots
CALLV
pop
line 622
;622:	}
LABELV $304
line 623
;623:}
LABELV $301
endproc BotInterbreedEndMatch 8 8
export BotInterbreeding
proc BotInterbreeding 16 20
line 630
;624:
;625:/*
;626:==============
;627:BotInterbreeding
;628:==============
;629:*/
;630:void BotInterbreeding(void) {
line 633
;631:	int i;
;632:
;633:	trap_Cvar_Update(&bot_interbreedchar);
ADDRGP4 bot_interbreedchar
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 634
;634:	if (!strlen(bot_interbreedchar.string)) return;
ADDRGP4 bot_interbreedchar+16
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $314
ADDRGP4 $313
JUMPV
LABELV $314
line 636
;635:	//make sure we are in tournament mode
;636:	if (gametype != GT_TOURNAMENT) {
ADDRGP4 gametype
INDIRI4
CNSTI4 1
EQI4 $317
line 637
;637:		trap_Cvar_Set("g_gametype", va("%d", GT_TOURNAMENT));
ADDRGP4 $320
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $319
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 638
;638:		ExitLevel();
ADDRGP4 ExitLevel
CALLV
pop
line 639
;639:		return;
ADDRGP4 $313
JUMPV
LABELV $317
line 642
;640:	}
;641:	//shutdown all the bots
;642:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $321
line 643
;643:		if (botstates[i] && botstates[i]->inuse) {
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $325
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $325
line 644
;644:			BotAIShutdownClient(botstates[i]->client, qfalse);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 BotAIShutdownClient
CALLI4
pop
line 645
;645:		}
LABELV $325
line 646
;646:	}
LABELV $322
line 642
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $321
line 648
;647:	//make sure all item weight configs are reloaded and Not shared
;648:	trap_BotLibVarSet("bot_reloadcharacters", "1");
ADDRGP4 $327
ARGP4
ADDRGP4 $328
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 650
;649:	//add a number of bots using the desired bot character
;650:	for (i = 0; i < bot_interbreedbots.integer; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $332
JUMPV
LABELV $329
line 651
;651:		trap_SendConsoleCommand( EXEC_INSERT, va("addbot %s 4 free %i %s%d\n",
ADDRGP4 $334
ARGP4
ADDRGP4 bot_interbreedchar+16
ARGP4
CNSTI4 50
ADDRLP4 0
INDIRI4
MULI4
ARGI4
ADDRGP4 bot_interbreedchar+16
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 1
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 653
;652:						bot_interbreedchar.string, i * 50, bot_interbreedchar.string, i) );
;653:	}
LABELV $330
line 650
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $332
ADDRLP4 0
INDIRI4
ADDRGP4 bot_interbreedbots+12
INDIRI4
LTI4 $329
line 655
;654:	//
;655:	trap_Cvar_Set("bot_interbreedchar", "");
ADDRGP4 $337
ARGP4
ADDRGP4 $312
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 656
;656:	bot_interbreed = qtrue;
ADDRGP4 bot_interbreed
CNSTI4 1
ASGNI4
line 657
;657:}
LABELV $313
endproc BotInterbreeding 16 20
export BotEntityInfo
proc BotEntityInfo 0 8
line 664
;658:
;659:/*
;660:==============
;661:BotEntityInfo
;662:==============
;663:*/
;664:void BotEntityInfo(int entnum, aas_entityinfo_t *info) {
line 665
;665:	trap_AAS_EntityInfo(entnum, info);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_AAS_EntityInfo
CALLV
pop
line 666
;666:}
LABELV $338
endproc BotEntityInfo 0 8
export NumBots
proc NumBots 0 0
line 673
;667:
;668:/*
;669:==============
;670:NumBots
;671:==============
;672:*/
;673:int NumBots(void) {
line 674
;674:	return numbots;
ADDRGP4 numbots
INDIRI4
RETI4
LABELV $339
endproc NumBots 0 0
export BotTeamLeader
proc BotTeamLeader 12 4
line 682
;675:}
;676:
;677:/*
;678:==============
;679:BotTeamLeader
;680:==============
;681:*/
;682:int BotTeamLeader(bot_state_t *bs) {
line 685
;683:	int leader;
;684:
;685:	leader = ClientFromName(bs->teamleader);
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 686
;686:	if (leader < 0) return qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $341
CNSTI4 0
RETI4
ADDRGP4 $340
JUMPV
LABELV $341
line 687
;687:	if (!botstates[leader] || !botstates[leader]->inuse) return qfalse;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $345
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $343
LABELV $345
CNSTI4 0
RETI4
ADDRGP4 $340
JUMPV
LABELV $343
line 688
;688:	return qtrue;
CNSTI4 1
RETI4
LABELV $340
endproc BotTeamLeader 12 4
export AngleDifference
proc AngleDifference 4 0
line 696
;689:}
;690:
;691:/*
;692:==============
;693:AngleDifference
;694:==============
;695:*/
;696:float AngleDifference(float ang1, float ang2) {
line 699
;697:	float diff;
;698:
;699:	diff = ang1 - ang2;
ADDRLP4 0
ADDRFP4 0
INDIRF4
ADDRFP4 4
INDIRF4
SUBF4
ASGNF4
line 700
;700:	if (ang1 > ang2) {
ADDRFP4 0
INDIRF4
ADDRFP4 4
INDIRF4
LEF4 $347
line 701
;701:		if (diff > 180.0) diff -= 360.0;
ADDRLP4 0
INDIRF4
CNSTF4 1127481344
LEF4 $348
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
line 702
;702:	}
ADDRGP4 $348
JUMPV
LABELV $347
line 703
;703:	else {
line 704
;704:		if (diff < -180.0) diff += 360.0;
ADDRLP4 0
INDIRF4
CNSTF4 3274964992
GEF4 $351
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
LABELV $351
line 705
;705:	}
LABELV $348
line 706
;706:	return diff;
ADDRLP4 0
INDIRF4
RETF4
LABELV $346
endproc AngleDifference 4 0
export BotChangeViewAngle
proc BotChangeViewAngle 16 4
line 714
;707:}
;708:
;709:/*
;710:==============
;711:BotChangeViewAngle
;712:==============
;713:*/
;714:float BotChangeViewAngle(float angle, float ideal_angle, float speed) {
line 717
;715:	float move;
;716:
;717:	angle = AngleMod(angle);
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRFP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 718
;718:	ideal_angle = AngleMod(ideal_angle);
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRFP4 4
ADDRLP4 8
INDIRF4
ASGNF4
line 719
;719:	if (angle == ideal_angle) return angle;
ADDRFP4 0
INDIRF4
ADDRFP4 4
INDIRF4
NEF4 $354
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $353
JUMPV
LABELV $354
line 720
;720:	move = ideal_angle - angle;
ADDRLP4 0
ADDRFP4 4
INDIRF4
ADDRFP4 0
INDIRF4
SUBF4
ASGNF4
line 721
;721:	if (ideal_angle > angle) {
ADDRFP4 4
INDIRF4
ADDRFP4 0
INDIRF4
LEF4 $356
line 722
;722:		if (move > 180.0) move -= 360.0;
ADDRLP4 0
INDIRF4
CNSTF4 1127481344
LEF4 $357
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
line 723
;723:	}
ADDRGP4 $357
JUMPV
LABELV $356
line 724
;724:	else {
line 725
;725:		if (move < -180.0) move += 360.0;
ADDRLP4 0
INDIRF4
CNSTF4 3274964992
GEF4 $360
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
LABELV $360
line 726
;726:	}
LABELV $357
line 727
;727:	if (move > 0) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $362
line 728
;728:		if (move > speed) move = speed;
ADDRLP4 0
INDIRF4
ADDRFP4 8
INDIRF4
LEF4 $363
ADDRLP4 0
ADDRFP4 8
INDIRF4
ASGNF4
line 729
;729:	}
ADDRGP4 $363
JUMPV
LABELV $362
line 730
;730:	else {
line 731
;731:		if (move < -speed) move = -speed;
ADDRLP4 0
INDIRF4
ADDRFP4 8
INDIRF4
NEGF4
GEF4 $366
ADDRLP4 0
ADDRFP4 8
INDIRF4
NEGF4
ASGNF4
LABELV $366
line 732
;732:	}
LABELV $363
line 733
;733:	return AngleMod(angle + move);
ADDRFP4 0
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ARGF4
ADDRLP4 12
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 12
INDIRF4
RETF4
LABELV $353
endproc BotChangeViewAngle 16 4
export BotChangeViewAngles
proc BotChangeViewAngles 80 16
line 741
;734:}
;735:
;736:/*
;737:==============
;738:BotChangeViewAngles
;739:==============
;740:*/
;741:void BotChangeViewAngles(bot_state_t *bs, float thinktime) {
line 745
;742:	float diff, factor, maxchange, anglespeed, disired_speed;
;743:	int i;
;744:
;745:	if (bs->ideal_viewangles[PITCH] > 180) bs->ideal_viewangles[PITCH] -= 360;
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
INDIRF4
CNSTF4 1127481344
LEF4 $369
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
LABELV $369
line 747
;746:	//
;747:	if (bs->enemy >= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
CNSTI4 0
LTI4 $371
line 748
;748:		factor = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_VIEW_FACTOR, 0.01f, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTF4 1008981770
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 28
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 28
INDIRF4
ASGNF4
line 749
;749:		maxchange = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_VIEW_MAXCHANGE, 1, 1800);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
CNSTF4 1065353216
ARGF4
CNSTF4 1155596288
ARGF4
ADDRLP4 32
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 32
INDIRF4
ASGNF4
line 750
;750:	}
ADDRGP4 $372
JUMPV
LABELV $371
line 751
;751:	else {
line 752
;752:		factor = 0.05f;
ADDRLP4 16
CNSTF4 1028443341
ASGNF4
line 753
;753:		maxchange = 360;
ADDRLP4 8
CNSTF4 1135869952
ASGNF4
line 754
;754:	}
LABELV $372
line 755
;755:	if (maxchange < 240) maxchange = 240;
ADDRLP4 8
INDIRF4
CNSTF4 1131413504
GEF4 $373
ADDRLP4 8
CNSTF4 1131413504
ASGNF4
LABELV $373
line 756
;756:	maxchange *= thinktime;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRFP4 4
INDIRF4
MULF4
ASGNF4
line 757
;757:	for (i = 0; i < 2; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $375
line 759
;758:		//
;759:		if (bot_challenge.integer) {
ADDRGP4 bot_challenge+12
INDIRI4
CNSTI4 0
EQI4 $379
line 761
;760:			//smooth slowdown view model
;761:			diff = abs(AngleDifference(bs->viewangles[i], bs->ideal_viewangles[i]));
ADDRLP4 28
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 6576
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 AngleDifference
CALLF4
ASGNF4
ADDRLP4 36
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 40
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 40
INDIRI4
CVIF4 4
ASGNF4
line 762
;762:			anglespeed = diff * factor;
ADDRLP4 4
ADDRLP4 12
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ASGNF4
line 763
;763:			if (anglespeed > maxchange) anglespeed = maxchange;
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $382
ADDRLP4 4
ADDRLP4 8
INDIRF4
ASGNF4
LABELV $382
line 764
;764:			bs->viewangles[i] = BotChangeViewAngle(bs->viewangles[i],
ADDRLP4 44
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
ADDRLP4 44
INDIRI4
ADDRLP4 48
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRI4
ADDRLP4 48
INDIRP4
CNSTI4 6576
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 56
ADDRGP4 BotChangeViewAngle
CALLF4
ASGNF4
ADDRLP4 52
INDIRP4
ADDRLP4 56
INDIRF4
ASGNF4
line 766
;765:											bs->ideal_viewangles[i], anglespeed);
;766:		}
ADDRGP4 $380
JUMPV
LABELV $379
line 767
;767:		else {
line 769
;768:			//over reaction view model
;769:			bs->viewangles[i] = AngleMod(bs->viewangles[i]);
ADDRLP4 28
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
INDIRF4
ARGF4
ADDRLP4 32
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 28
INDIRP4
ADDRLP4 32
INDIRF4
ASGNF4
line 770
;770:			bs->ideal_viewangles[i] = AngleMod(bs->ideal_viewangles[i]);
ADDRLP4 36
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 36
INDIRP4
ADDRLP4 40
INDIRF4
ASGNF4
line 771
;771:			diff = AngleDifference(bs->viewangles[i], bs->ideal_viewangles[i]);
ADDRLP4 44
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRI4
ADDRLP4 48
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRI4
ADDRLP4 48
INDIRP4
CNSTI4 6576
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 52
ADDRGP4 AngleDifference
CALLF4
ASGNF4
ADDRLP4 12
ADDRLP4 52
INDIRF4
ASGNF4
line 772
;772:			disired_speed = diff * factor;
ADDRLP4 20
ADDRLP4 12
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ASGNF4
line 773
;773:			bs->viewanglespeed[i] += (bs->viewanglespeed[i] - disired_speed);
ADDRLP4 56
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6588
ADDP4
ADDP4
ASGNP4
ADDRLP4 60
ADDRLP4 56
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 56
INDIRP4
ADDRLP4 60
INDIRF4
ADDRLP4 60
INDIRF4
ADDRLP4 20
INDIRF4
SUBF4
ADDF4
ASGNF4
line 774
;774:			if (bs->viewanglespeed[i] > 180) bs->viewanglespeed[i] = maxchange;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6588
ADDP4
ADDP4
INDIRF4
CNSTF4 1127481344
LEF4 $384
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6588
ADDP4
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
LABELV $384
line 775
;775:			if (bs->viewanglespeed[i] < -180) bs->viewanglespeed[i] = -maxchange;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6588
ADDP4
ADDP4
INDIRF4
CNSTF4 3274964992
GEF4 $386
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6588
ADDP4
ADDP4
ADDRLP4 8
INDIRF4
NEGF4
ASGNF4
LABELV $386
line 776
;776:			anglespeed = bs->viewanglespeed[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6588
ADDP4
ADDP4
INDIRF4
ASGNF4
line 777
;777:			if (anglespeed > maxchange) anglespeed = maxchange;
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $388
ADDRLP4 4
ADDRLP4 8
INDIRF4
ASGNF4
LABELV $388
line 778
;778:			if (anglespeed < -maxchange) anglespeed = -maxchange;
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
NEGF4
GEF4 $390
ADDRLP4 4
ADDRLP4 8
INDIRF4
NEGF4
ASGNF4
LABELV $390
line 779
;779:			bs->viewangles[i] += anglespeed;
ADDRLP4 64
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
line 780
;780:			bs->viewangles[i] = AngleMod(bs->viewangles[i]);
ADDRLP4 68
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
INDIRF4
ARGF4
ADDRLP4 72
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 68
INDIRP4
ADDRLP4 72
INDIRF4
ASGNF4
line 782
;781:			//demping
;782:			bs->viewanglespeed[i] *= 0.45 * (1 - factor);
ADDRLP4 76
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6588
ADDP4
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRF4
CNSTF4 1055286886
CNSTF4 1065353216
ADDRLP4 16
INDIRF4
SUBF4
MULF4
MULF4
ASGNF4
line 783
;783:		}
LABELV $380
line 786
;784:		//BotAI_Print(PRT_MESSAGE, "ideal_angles %f %f\n", bs->ideal_viewangles[0], bs->ideal_viewangles[1], bs->ideal_viewangles[2]);`
;785:		//bs->viewangles[i] = bs->ideal_viewangles[i];
;786:	}
LABELV $376
line 757
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $375
line 788
;787:	//bs->viewangles[PITCH] = 0;
;788:	if (bs->viewangles[PITCH] > 180) bs->viewangles[PITCH] -= 360;
ADDRFP4 0
INDIRP4
CNSTI4 6564
ADDP4
INDIRF4
CNSTF4 1127481344
LEF4 $392
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 6564
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
LABELV $392
line 790
;789:	//elementary action: view
;790:	trap_EA_View(bs->client, bs->viewangles);
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 32
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
ADDRGP4 trap_EA_View
CALLV
pop
line 791
;791:}
LABELV $368
endproc BotChangeViewAngles 80 16
export BotInputToUserCommand
proc BotInputToUserCommand 136 16
line 798
;792:
;793:/*
;794:==============
;795:BotInputToUserCommand
;796:==============
;797:*/
;798:void BotInputToUserCommand(bot_input_t *bi, usercmd_t *ucmd, int delta_angles[3], int time) {
line 804
;799:	vec3_t angles, forward, right;
;800:	short temp;
;801:	int j;
;802:
;803:	//clear the whole structure
;804:	memset(ucmd, 0, sizeof(usercmd_t));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 24
ARGI4
ADDRGP4 memset
CALLP4
pop
line 808
;805:	//
;806:	//Com_Printf("dir = %f %f %f speed = %f\n", bi->dir[0], bi->dir[1], bi->dir[2], bi->speed);
;807:	//the duration for the user command in milli seconds
;808:	ucmd->serverTime = time;
ADDRFP4 4
INDIRP4
ADDRFP4 12
INDIRI4
ASGNI4
line 810
;809:	//
;810:	if (bi->actionflags & ACTION_DELAYEDJUMP) {
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $395
line 811
;811:		bi->actionflags |= ACTION_JUMP;
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 812
;812:		bi->actionflags &= ~ACTION_DELAYEDJUMP;
ADDRLP4 48
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 -32769
BANDI4
ASGNI4
line 813
;813:	}
LABELV $395
line 815
;814:	//set the buttons
;815:	if (bi->actionflags & ACTION_RESPAWN) ucmd->buttons = BUTTON_ATTACK;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $397
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 1
ASGNI4
LABELV $397
line 816
;816:	if (bi->actionflags & ACTION_ATTACK) ucmd->buttons |= BUTTON_ATTACK;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $399
ADDRLP4 44
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
LABELV $399
line 817
;817:	if (bi->actionflags & ACTION_TALK) ucmd->buttons |= BUTTON_TALK;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 65536
BANDI4
CNSTI4 0
EQI4 $401
ADDRLP4 48
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
LABELV $401
line 818
;818:	if (bi->actionflags & ACTION_GESTURE) ucmd->buttons |= BUTTON_GESTURE;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 131072
BANDI4
CNSTI4 0
EQI4 $403
ADDRLP4 52
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
LABELV $403
line 819
;819:	if (bi->actionflags & ACTION_USE) ucmd->buttons |= BUTTON_USE_HOLDABLE;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $405
ADDRLP4 56
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
LABELV $405
line 820
;820:	if (bi->actionflags & ACTION_WALK) ucmd->buttons |= BUTTON_WALKING;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 524288
BANDI4
CNSTI4 0
EQI4 $407
ADDRLP4 60
CNSTI4 16
ASGNI4
ADDRLP4 64
ADDRFP4 4
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
ADDRLP4 60
INDIRI4
BORI4
ASGNI4
LABELV $407
line 821
;821:	if (bi->actionflags & ACTION_AFFIRMATIVE) ucmd->buttons |= BUTTON_AFFIRMATIVE;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 1048576
BANDI4
CNSTI4 0
EQI4 $409
ADDRLP4 68
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
LABELV $409
line 822
;822:	if (bi->actionflags & ACTION_NEGATIVE) ucmd->buttons |= BUTTON_NEGATIVE;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 2097152
BANDI4
CNSTI4 0
EQI4 $411
ADDRLP4 72
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
LABELV $411
line 823
;823:	if (bi->actionflags & ACTION_GETFLAG) ucmd->buttons |= BUTTON_GETFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 8388608
BANDI4
CNSTI4 0
EQI4 $413
ADDRLP4 76
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
LABELV $413
line 824
;824:	if (bi->actionflags & ACTION_GUARDBASE) ucmd->buttons |= BUTTON_GUARDBASE;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 16777216
BANDI4
CNSTI4 0
EQI4 $415
ADDRLP4 80
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
LABELV $415
line 825
;825:	if (bi->actionflags & ACTION_PATROL) ucmd->buttons |= BUTTON_PATROL;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 33554432
BANDI4
CNSTI4 0
EQI4 $417
ADDRLP4 84
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
LABELV $417
line 826
;826:	if (bi->actionflags & ACTION_FOLLOWME) ucmd->buttons |= BUTTON_FOLLOWME;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 134217728
BANDI4
CNSTI4 0
EQI4 $419
ADDRLP4 88
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
CNSTI4 1024
BORI4
ASGNI4
LABELV $419
line 828
;827:	//
;828:	ucmd->weapon = bi->weapon;
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 831
;829:	//set the view angles
;830:	//NOTE: the ucmd->angles are the angles WITHOUT the delta angles
;831:	ucmd->angles[PITCH] = ANGLE2SHORT(bi->viewangles[PITCH]);
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 1199570944
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
MULF4
CNSTF4 1135869952
DIVF4
CVFI4 4
CNSTI4 65535
BANDI4
ASGNI4
line 832
;832:	ucmd->angles[YAW] = ANGLE2SHORT(bi->viewangles[YAW]);
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1199570944
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
MULF4
CNSTF4 1135869952
DIVF4
CVFI4 4
CNSTI4 65535
BANDI4
ASGNI4
line 833
;833:	ucmd->angles[ROLL] = ANGLE2SHORT(bi->viewangles[ROLL]);
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1199570944
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
MULF4
CNSTF4 1135869952
DIVF4
CVFI4 4
CNSTI4 65535
BANDI4
ASGNI4
line 835
;834:	//subtract the delta angles
;835:	for (j = 0; j < 3; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $421
line 836
;836:		temp = ucmd->angles[j] - delta_angles[j];
ADDRLP4 92
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4
ADDRLP4 92
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
INDIRI4
ADDRLP4 92
INDIRI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRI4
SUBI4
CVII2 4
ASGNI2
line 844
;837:		/*NOTE: disabled because temp should be mod first
;838:		if ( j == PITCH ) {
;839:			// don't let the player look up or down more than 90 degrees
;840:			if ( temp > 16000 ) temp = 16000;
;841:			else if ( temp < -16000 ) temp = -16000;
;842:		}
;843:		*/
;844:		ucmd->angles[j] = temp;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
ADDRLP4 4
INDIRI2
CVII4 2
ASGNI4
line 845
;845:	}
LABELV $422
line 835
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $421
line 849
;846:	//NOTE: movement is relative to the REAL view angles
;847:	//get the horizontal forward and right vector
;848:	//get the pitch in the range [-180, 180]
;849:	if (bi->dir[2]) angles[PITCH] = bi->viewangles[PITCH];
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 0
EQF4 $425
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
ADDRGP4 $426
JUMPV
LABELV $425
line 850
;850:	else angles[PITCH] = 0;
ADDRLP4 20
CNSTF4 0
ASGNF4
LABELV $426
line 851
;851:	angles[YAW] = bi->viewangles[YAW];
ADDRLP4 20+4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 852
;852:	angles[ROLL] = 0;
ADDRLP4 20+8
CNSTF4 0
ASGNF4
line 853
;853:	AngleVectors(angles, forward, right, NULL);
ADDRLP4 20
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 32
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 855
;854:	//bot input speed is in the range [0, 400]
;855:	bi->speed = bi->speed * 127 / 400;
ADDRLP4 92
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTF4 1123942400
ADDRLP4 92
INDIRP4
INDIRF4
MULF4
CNSTF4 1137180672
DIVF4
ASGNF4
line 857
;856:	//set the view independent movement
;857:	ucmd->forwardmove = DotProduct(forward, bi->dir) * bi->speed;
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 4
INDIRP4
CNSTI4 21
ADDP4
ADDRLP4 8
INDIRF4
ADDRLP4 96
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDRLP4 8+4
INDIRF4
ADDRLP4 96
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 8+8
INDIRF4
ADDRLP4 96
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 96
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
MULF4
CVFI4 4
CVII1 4
ASGNI1
line 858
;858:	ucmd->rightmove = DotProduct(right, bi->dir) * bi->speed;
ADDRLP4 100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 4
INDIRP4
CNSTI4 22
ADDP4
ADDRLP4 32
INDIRF4
ADDRLP4 100
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDRLP4 32+4
INDIRF4
ADDRLP4 100
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 32+8
INDIRF4
ADDRLP4 100
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 100
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
MULF4
CVFI4 4
CVII1 4
ASGNI1
line 859
;859:	ucmd->upmove = abs(forward[2]) * bi->dir[2] * bi->speed;
ADDRLP4 8+8
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 104
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 108
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 4
INDIRP4
CNSTI4 23
ADDP4
ADDRLP4 104
INDIRI4
CVIF4 4
ADDRLP4 108
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
MULF4
ADDRLP4 108
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
MULF4
CVFI4 4
CVII1 4
ASGNI1
line 861
;860:	//normal keyboard movement
;861:	if (bi->actionflags & ACTION_MOVEFORWARD) ucmd->forwardmove += 127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $434
ADDRLP4 112
ADDRFP4 4
INDIRP4
CNSTI4 21
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
ADDI4
CVII1 4
ASGNI1
LABELV $434
line 862
;862:	if (bi->actionflags & ACTION_MOVEBACK) ucmd->forwardmove -= 127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $436
ADDRLP4 116
ADDRFP4 4
INDIRP4
CNSTI4 21
ADDP4
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 116
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
SUBI4
CVII1 4
ASGNI1
LABELV $436
line 863
;863:	if (bi->actionflags & ACTION_MOVELEFT) ucmd->rightmove -= 127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $438
ADDRLP4 120
ADDRFP4 4
INDIRP4
CNSTI4 22
ADDP4
ASGNP4
ADDRLP4 120
INDIRP4
ADDRLP4 120
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
SUBI4
CVII1 4
ASGNI1
LABELV $438
line 864
;864:	if (bi->actionflags & ACTION_MOVERIGHT) ucmd->rightmove += 127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $440
ADDRLP4 124
ADDRFP4 4
INDIRP4
CNSTI4 22
ADDP4
ASGNP4
ADDRLP4 124
INDIRP4
ADDRLP4 124
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
ADDI4
CVII1 4
ASGNI1
LABELV $440
line 866
;865:	//jump/moveup
;866:	if (bi->actionflags & ACTION_JUMP) ucmd->upmove += 127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $442
ADDRLP4 128
ADDRFP4 4
INDIRP4
CNSTI4 23
ADDP4
ASGNP4
ADDRLP4 128
INDIRP4
ADDRLP4 128
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
ADDI4
CVII1 4
ASGNI1
LABELV $442
line 868
;867:	//crouch/movedown
;868:	if (bi->actionflags & ACTION_CROUCH) ucmd->upmove -= 127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $444
ADDRLP4 132
ADDRFP4 4
INDIRP4
CNSTI4 23
ADDP4
ASGNP4
ADDRLP4 132
INDIRP4
ADDRLP4 132
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
SUBI4
CVII1 4
ASGNI1
LABELV $444
line 872
;869:	//
;870:	//Com_Printf("forward = %d right = %d up = %d\n", ucmd.forwardmove, ucmd.rightmove, ucmd.upmove);
;871:	//Com_Printf("ucmd->serverTime = %d\n", ucmd->serverTime);
;872:}
LABELV $394
endproc BotInputToUserCommand 136 16
export BotUpdateInput
proc BotUpdateInput 64 16
line 879
;873:
;874:/*
;875:==============
;876:BotUpdateInput
;877:==============
;878:*/
;879:void BotUpdateInput(bot_state_t *bs, int time, int elapsed_time) {
line 884
;880:	bot_input_t bi;
;881:	int j;
;882:
;883:	//add the delta angles to the bot's current view angles
;884:	for (j = 0; j < 3; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $447
line 885
;885:		bs->viewangles[j] = AngleMod(bs->viewangles[j] + SHORT2ANGLE(bs->cur_ps.delta_angles[j]));
ADDRLP4 44
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
ADDRLP4 44
INDIRI4
ADDRLP4 48
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
INDIRF4
CNSTF4 1001652224
ADDRLP4 44
INDIRI4
ADDRLP4 48
INDIRP4
CNSTI4 72
ADDP4
ADDP4
INDIRI4
CVIF4 4
MULF4
ADDF4
ARGF4
ADDRLP4 56
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 52
INDIRP4
ADDRLP4 56
INDIRF4
ASGNF4
line 886
;886:	}
LABELV $448
line 884
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $447
line 888
;887:	//change the bot view angles
;888:	BotChangeViewAngles(bs, (float) elapsed_time / 1000);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
CVIF4 4
CNSTF4 1148846080
DIVF4
ARGF4
ADDRGP4 BotChangeViewAngles
CALLV
pop
line 890
;889:	//retrieve the bot input
;890:	trap_EA_GetInput(bs->client, (float) time / 1000, &bi);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
CVIF4 4
CNSTF4 1148846080
DIVF4
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 trap_EA_GetInput
CALLV
pop
line 892
;891:	//respawn hack
;892:	if (bi.actionflags & ACTION_RESPAWN) {
ADDRLP4 4+32
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $451
line 893
;893:		if (bs->lastucmd.buttons & BUTTON_ATTACK) bi.actionflags &= ~(ACTION_RESPAWN|ACTION_ATTACK);
ADDRFP4 0
INDIRP4
CNSTI4 504
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $454
ADDRLP4 4+32
ADDRLP4 4+32
INDIRI4
CNSTI4 -10
BANDI4
ASGNI4
LABELV $454
line 894
;894:	}
LABELV $451
line 896
;895:	//convert the bot input to a usercmd
;896:	BotInputToUserCommand(&bi, &bs->lastucmd, bs->cur_ps.delta_angles, time);
ADDRLP4 4
ARGP4
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 44
INDIRP4
CNSTI4 72
ADDP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 BotInputToUserCommand
CALLV
pop
line 898
;897:	//subtract the delta angles
;898:	for (j = 0; j < 3; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $457
line 899
;899:		bs->viewangles[j] = AngleMod(bs->viewangles[j] - SHORT2ANGLE(bs->cur_ps.delta_angles[j]));
ADDRLP4 48
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
ADDRLP4 48
INDIRI4
ADDRLP4 52
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
INDIRF4
CNSTF4 1001652224
ADDRLP4 48
INDIRI4
ADDRLP4 52
INDIRP4
CNSTI4 72
ADDP4
ADDP4
INDIRI4
CVIF4 4
MULF4
SUBF4
ARGF4
ADDRLP4 60
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 56
INDIRP4
ADDRLP4 60
INDIRF4
ASGNF4
line 900
;900:	}
LABELV $458
line 898
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $457
line 901
;901:}
LABELV $446
endproc BotUpdateInput 64 16
export BotAIRegularUpdate
proc BotAIRegularUpdate 0 0
line 908
;902:
;903:/*
;904:==============
;905:BotAIRegularUpdate
;906:==============
;907:*/
;908:void BotAIRegularUpdate(void) {
line 909
;909:	if (regularupdate_time < FloatTime()) {
ADDRGP4 regularupdate_time
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $462
line 910
;910:		trap_BotUpdateEntityItems();
ADDRGP4 trap_BotUpdateEntityItems
CALLV
pop
line 911
;911:		regularupdate_time = FloatTime() + 0.3;
ADDRGP4 regularupdate_time
ADDRGP4 floattime
INDIRF4
CNSTF4 1050253722
ADDF4
ASGNF4
line 912
;912:	}
LABELV $462
line 913
;913:}
LABELV $461
endproc BotAIRegularUpdate 0 0
export RemoveColorEscapeSequences
proc RemoveColorEscapeSequences 28 0
line 920
;914:
;915:/*
;916:==============
;917:RemoveColorEscapeSequences
;918:==============
;919:*/
;920:void RemoveColorEscapeSequences( char *text ) {
line 923
;921:	int i, l;
;922:
;923:	l = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 924
;924:	for ( i = 0; text[i]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $468
JUMPV
LABELV $465
line 925
;925:		if (Q_IsColorString(&text[i])) {
ADDRLP4 8
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $469
ADDRLP4 12
CNSTI4 94
ASGNI4
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 12
INDIRI4
NEI4 $469
ADDRLP4 16
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $469
ADDRLP4 16
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $469
line 926
;926:			i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 927
;927:			continue;
ADDRGP4 $466
JUMPV
LABELV $469
line 929
;928:		}
;929:		if (text[i] > 0x7E)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 126
LEI4 $471
line 930
;930:			continue;
ADDRGP4 $466
JUMPV
LABELV $471
line 931
;931:		text[l++] = text[i];
ADDRLP4 20
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 4
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRP4
ADDP4
ADDRLP4 0
INDIRI4
ADDRLP4 24
INDIRP4
ADDP4
INDIRI1
ASGNI1
line 932
;932:	}
LABELV $466
line 924
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $468
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $465
line 933
;933:	text[l] = '\0';
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 934
;934:}
LABELV $464
endproc RemoveColorEscapeSequences 28 0
export BotAI
proc BotAI 1092 12
line 941
;935:
;936:/*
;937:==============
;938:BotAI
;939:==============
;940:*/
;941:int BotAI(int client, float thinktime) {
line 946
;942:	bot_state_t *bs;
;943:	char buf[1024], *args;
;944:	int j;
;945:
;946:	trap_EA_ResetInput(client);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 trap_EA_ResetInput
CALLV
pop
line 948
;947:	//
;948:	bs = botstates[client];
ADDRLP4 4
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
line 949
;949:	if (!bs || !bs->inuse) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $476
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $474
LABELV $476
line 950
;950:		BotAI_Print(PRT_FATAL, "BotAI: client %d is not setup\n", client);
CNSTI4 4
ARGI4
ADDRGP4 $477
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 951
;951:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $473
JUMPV
LABELV $474
line 955
;952:	}
;953:
;954:	//retrieve the current client state
;955:	BotAI_GetClientState( client, &bs->cur_ps );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRGP4 BotAI_GetClientState
CALLI4
pop
ADDRGP4 $479
JUMPV
LABELV $478
line 958
;956:
;957:	//retrieve any waiting server commands
;958:	while( trap_BotGetServerCommand(client, buf, sizeof(buf)) ) {
line 960
;959:		//have buf point to the command and args to the command arguments
;960:		args = strchr( buf, ' ');
ADDRLP4 12
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 1040
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 1040
INDIRP4
ASGNP4
line 961
;961:		if (!args) continue;
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $481
ADDRGP4 $479
JUMPV
LABELV $481
line 962
;962:		*args++ = '\0';
ADDRLP4 1044
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 1044
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 1044
INDIRP4
CNSTI1 0
ASGNI1
line 965
;963:
;964:		//remove color espace sequences from the arguments
;965:		RemoveColorEscapeSequences( args );
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 RemoveColorEscapeSequences
CALLV
pop
line 967
;966:
;967:		if (!Q_stricmp(buf, "cp "))
ADDRLP4 12
ARGP4
ADDRGP4 $485
ARGP4
ADDRLP4 1048
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $483
line 968
;968:			{ /*CenterPrintf*/ }
ADDRGP4 $484
JUMPV
LABELV $483
line 969
;969:		else if (!Q_stricmp(buf, "cs"))
ADDRLP4 12
ARGP4
ADDRGP4 $488
ARGP4
ADDRLP4 1052
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
NEI4 $486
line 970
;970:			{ /*ConfigStringModified*/ }
ADDRGP4 $487
JUMPV
LABELV $486
line 971
;971:		else if (!Q_stricmp(buf, "print")) {
ADDRLP4 12
ARGP4
ADDRGP4 $491
ARGP4
ADDRLP4 1056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $489
line 973
;972:			//remove first and last quote from the chat message
;973:			memmove(args, args+1, strlen(args));
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1060
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 1060
INDIRI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 974
;974:			args[strlen(args)-1] = '\0';
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1068
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1068
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 975
;975:			trap_BotQueueConsoleMessage(bs->cs, CMS_NORMAL, args);
ADDRLP4 4
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_BotQueueConsoleMessage
CALLV
pop
line 976
;976:		}
ADDRGP4 $490
JUMPV
LABELV $489
line 977
;977:		else if (!Q_stricmp(buf, "chat")) {
ADDRLP4 12
ARGP4
ADDRGP4 $494
ARGP4
ADDRLP4 1060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
NEI4 $492
line 979
;978:			//remove first and last quote from the chat message
;979:			memmove(args, args+1, strlen(args));
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1064
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 1064
INDIRI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 980
;980:			args[strlen(args)-1] = '\0';
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1072
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1072
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 981
;981:			trap_BotQueueConsoleMessage(bs->cs, CMS_CHAT, args);
ADDRLP4 4
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_BotQueueConsoleMessage
CALLV
pop
line 982
;982:		}
ADDRGP4 $493
JUMPV
LABELV $492
line 983
;983:		else if (!Q_stricmp(buf, "tchat")) {
ADDRLP4 12
ARGP4
ADDRGP4 $497
ARGP4
ADDRLP4 1064
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 0
NEI4 $495
line 985
;984:			//remove first and last quote from the chat message
;985:			memmove(args, args+1, strlen(args));
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1068
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 1068
INDIRI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 986
;986:			args[strlen(args)-1] = '\0';
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1076
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1076
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 987
;987:			trap_BotQueueConsoleMessage(bs->cs, CMS_CHAT, args);
ADDRLP4 4
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_BotQueueConsoleMessage
CALLV
pop
line 988
;988:		}
ADDRGP4 $496
JUMPV
LABELV $495
line 1000
;989:#ifdef MISSIONPACK
;990:		else if (!Q_stricmp(buf, "vchat")) {
;991:			BotVoiceChatCommand(bs, SAY_ALL, args);
;992:		}
;993:		else if (!Q_stricmp(buf, "vtchat")) {
;994:			BotVoiceChatCommand(bs, SAY_TEAM, args);
;995:		}
;996:		else if (!Q_stricmp(buf, "vtell")) {
;997:			BotVoiceChatCommand(bs, SAY_TELL, args);
;998:		}
;999:#endif
;1000:		else if (!Q_stricmp(buf, "scores"))
ADDRLP4 12
ARGP4
ADDRGP4 $500
ARGP4
ADDRLP4 1068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1068
INDIRI4
CNSTI4 0
NEI4 $498
line 1001
;1001:			{ /*FIXME: parse scores?*/ }
ADDRGP4 $499
JUMPV
LABELV $498
line 1002
;1002:		else if (!Q_stricmp(buf, "clientLevelShot"))
ADDRLP4 12
ARGP4
ADDRGP4 $503
ARGP4
ADDRLP4 1072
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1072
INDIRI4
CNSTI4 0
NEI4 $501
line 1003
;1003:			{ /*ignore*/ }
LABELV $501
LABELV $499
LABELV $496
LABELV $493
LABELV $490
LABELV $487
LABELV $484
line 1004
;1004:	}
LABELV $479
line 958
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1040
ADDRGP4 trap_BotGetServerCommand
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $478
line 1006
;1005:	//add the delta angles to the bot's current view angles
;1006:	for (j = 0; j < 3; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $504
line 1007
;1007:		bs->viewangles[j] = AngleMod(bs->viewangles[j] + SHORT2ANGLE(bs->cur_ps.delta_angles[j]));
ADDRLP4 1044
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 1052
ADDRLP4 1044
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
ASGNP4
ADDRLP4 1052
INDIRP4
INDIRF4
CNSTF4 1001652224
ADDRLP4 1044
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 72
ADDP4
ADDP4
INDIRI4
CVIF4 4
MULF4
ADDF4
ARGF4
ADDRLP4 1056
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 1052
INDIRP4
ADDRLP4 1056
INDIRF4
ASGNF4
line 1008
;1008:	}
LABELV $505
line 1006
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $504
line 1010
;1009:	//increase the local time of the bot
;1010:	bs->ltime += thinktime;
ADDRLP4 1044
ADDRLP4 4
INDIRP4
CNSTI4 6060
ADDP4
ASGNP4
ADDRLP4 1044
INDIRP4
ADDRLP4 1044
INDIRP4
INDIRF4
ADDRFP4 4
INDIRF4
ADDF4
ASGNF4
line 1012
;1011:	//
;1012:	bs->thinktime = thinktime;
ADDRLP4 4
INDIRP4
CNSTI4 4904
ADDP4
ADDRFP4 4
INDIRF4
ASGNF4
line 1014
;1013:	//origin of the bot
;1014:	VectorCopy(bs->cur_ps.origin, bs->origin);
ADDRLP4 4
INDIRP4
CNSTI4 4908
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 1016
;1015:	//eye coordinates of the bot
;1016:	VectorCopy(bs->cur_ps.origin, bs->eye);
ADDRLP4 4
INDIRP4
CNSTI4 4936
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 1017
;1017:	bs->eye[2] += bs->cur_ps.viewheight;
ADDRLP4 1060
ADDRLP4 4
INDIRP4
CNSTI4 4944
ADDP4
ASGNP4
ADDRLP4 1060
INDIRP4
ADDRLP4 1060
INDIRP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1019
;1018:	//get the area the bot is in
;1019:	bs->areanum = BotPointAreaNum(bs->origin);
ADDRLP4 4
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRLP4 1068
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 4948
ADDP4
ADDRLP4 1068
INDIRI4
ASGNI4
line 1021
;1020:	//the real AI
;1021:	BotDeathmatchAI(bs, thinktime);
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRGP4 BotDeathmatchAI
CALLV
pop
line 1023
;1022:	//set the weapon selection every AI frame
;1023:	trap_EA_SelectWeapon(bs->client, bs->weaponnum);
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_SelectWeapon
CALLV
pop
line 1025
;1024:	//subtract the delta angles
;1025:	for (j = 0; j < 3; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $508
line 1026
;1026:		bs->viewangles[j] = AngleMod(bs->viewangles[j] - SHORT2ANGLE(bs->cur_ps.delta_angles[j]));
ADDRLP4 1076
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 1084
ADDRLP4 1076
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
ASGNP4
ADDRLP4 1084
INDIRP4
INDIRF4
CNSTF4 1001652224
ADDRLP4 1076
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 72
ADDP4
ADDP4
INDIRI4
CVIF4 4
MULF4
SUBF4
ARGF4
ADDRLP4 1088
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 1084
INDIRP4
ADDRLP4 1088
INDIRF4
ASGNF4
line 1027
;1027:	}
LABELV $509
line 1025
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $508
line 1029
;1028:	//everything was ok
;1029:	return qtrue;
CNSTI4 1
RETI4
LABELV $473
endproc BotAI 1092 12
export BotScheduleBotThink
proc BotScheduleBotThink 12 0
line 1037
;1030:}
;1031:
;1032:/*
;1033:==================
;1034:BotScheduleBotThink
;1035:==================
;1036:*/
;1037:void BotScheduleBotThink(void) {
line 1040
;1038:	int i, botnum;
;1039:
;1040:	botnum = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1042
;1041:
;1042:	for( i = 0; i < MAX_CLIENTS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $513
line 1043
;1043:		if( !botstates[i] || !botstates[i]->inuse ) {
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $519
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $517
LABELV $519
line 1044
;1044:			continue;
ADDRGP4 $514
JUMPV
LABELV $517
line 1047
;1045:		}
;1046:		//initialize the bot think residual time
;1047:		botstates[i]->botthink_residual = bot_thinktime.integer * botnum / numbots;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 bot_thinktime+12
INDIRI4
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 numbots
INDIRI4
DIVI4
ASGNI4
line 1048
;1048:		botnum++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1049
;1049:	}
LABELV $514
line 1042
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $513
line 1050
;1050:}
LABELV $512
endproc BotScheduleBotThink 12 0
export BotWriteSessionData
proc BotWriteSessionData 20 72
line 1057
;1051:
;1052:/*
;1053:==============
;1054:BotWriteSessionData
;1055:==============
;1056:*/
;1057:void BotWriteSessionData(bot_state_t *bs) {
line 1061
;1058:	const char	*s;
;1059:	const char	*var;
;1060:
;1061:	s = va(
ADDRGP4 $522
ARGP4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 6756
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6764
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6780
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6808
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6816
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6820
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6812
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6768
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 6772
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 6776
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 6784
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 6788
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 6792
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 6796
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 6800
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 6804
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 1085
;1062:			"%i %i %i %i %i %i %i %i"
;1063:			" %f %f %f"
;1064:			" %f %f %f"
;1065:			" %f %f %f",
;1066:		bs->lastgoal_decisionmaker,
;1067:		bs->lastgoal_ltgtype,
;1068:		bs->lastgoal_teammate,
;1069:		bs->lastgoal_teamgoal.areanum,
;1070:		bs->lastgoal_teamgoal.entitynum,
;1071:		bs->lastgoal_teamgoal.flags,
;1072:		bs->lastgoal_teamgoal.iteminfo,
;1073:		bs->lastgoal_teamgoal.number,
;1074:		bs->lastgoal_teamgoal.origin[0],
;1075:		bs->lastgoal_teamgoal.origin[1],
;1076:		bs->lastgoal_teamgoal.origin[2],
;1077:		bs->lastgoal_teamgoal.mins[0],
;1078:		bs->lastgoal_teamgoal.mins[1],
;1079:		bs->lastgoal_teamgoal.mins[2],
;1080:		bs->lastgoal_teamgoal.maxs[0],
;1081:		bs->lastgoal_teamgoal.maxs[1],
;1082:		bs->lastgoal_teamgoal.maxs[2]
;1083:		);
;1084:
;1085:	var = va( "botsession%i", bs->client );
ADDRGP4 $523
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
ASGNP4
line 1087
;1086:
;1087:	trap_Cvar_Set( var, s );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1088
;1088:}
LABELV $521
endproc BotWriteSessionData 20 72
export BotReadSessionData
proc BotReadSessionData 1036 76
line 1095
;1089:
;1090:/*
;1091:==============
;1092:BotReadSessionData
;1093:==============
;1094:*/
;1095:void BotReadSessionData(bot_state_t *bs) {
line 1099
;1096:	char	s[MAX_STRING_CHARS];
;1097:	const char	*var;
;1098:
;1099:	var = va( "botsession%i", bs->client );
ADDRGP4 $523
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 1028
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1024
ADDRLP4 1028
INDIRP4
ASGNP4
line 1100
;1100:	trap_Cvar_VariableStringBuffer( var, s, sizeof(s) );
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
line 1102
;1101:
;1102:	sscanf(s,
ADDRLP4 0
ARGP4
ADDRGP4 $522
ARGP4
ADDRLP4 1032
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1032
INDIRP4
CNSTI4 6756
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6760
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6764
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6780
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6808
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6816
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6820
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6812
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6768
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6772
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6776
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6784
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6788
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6792
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6796
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6800
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6804
ADDP4
ARGP4
ADDRGP4 sscanf
CALLI4
pop
line 1125
;1103:			"%i %i %i %i %i %i %i %i"
;1104:			" %f %f %f"
;1105:			" %f %f %f"
;1106:			" %f %f %f",
;1107:		&bs->lastgoal_decisionmaker,
;1108:		&bs->lastgoal_ltgtype,
;1109:		&bs->lastgoal_teammate,
;1110:		&bs->lastgoal_teamgoal.areanum,
;1111:		&bs->lastgoal_teamgoal.entitynum,
;1112:		&bs->lastgoal_teamgoal.flags,
;1113:		&bs->lastgoal_teamgoal.iteminfo,
;1114:		&bs->lastgoal_teamgoal.number,
;1115:		&bs->lastgoal_teamgoal.origin[0],
;1116:		&bs->lastgoal_teamgoal.origin[1],
;1117:		&bs->lastgoal_teamgoal.origin[2],
;1118:		&bs->lastgoal_teamgoal.mins[0],
;1119:		&bs->lastgoal_teamgoal.mins[1],
;1120:		&bs->lastgoal_teamgoal.mins[2],
;1121:		&bs->lastgoal_teamgoal.maxs[0],
;1122:		&bs->lastgoal_teamgoal.maxs[1],
;1123:		&bs->lastgoal_teamgoal.maxs[2]
;1124:		);
;1125:}
LABELV $524
endproc BotReadSessionData 1036 76
export BotAISetupClient
proc BotAISetupClient 512 16
line 1132
;1126:
;1127:/*
;1128:==============
;1129:BotAISetupClient
;1130:==============
;1131:*/
;1132:int BotAISetupClient(int client, struct bot_settings_s *settings, qboolean restart) {
line 1137
;1133:	char filename[MAX_PATH], name[MAX_PATH], gender[MAX_PATH];
;1134:	bot_state_t *bs;
;1135:	int errnum;
;1136:
;1137:	if (!botstates[client]) botstates[client] = G_Alloc(sizeof(bot_state_t));
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $526
CNSTI4 9088
ARGI4
ADDRLP4 440
ADDRGP4 G_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
ADDRLP4 440
INDIRP4
ASGNP4
LABELV $526
line 1138
;1138:	bs = botstates[client];
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
line 1140
;1139:
;1140:	if (bs && bs->inuse) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $528
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $528
line 1141
;1141:		BotAI_Print(PRT_FATAL, "BotAISetupClient: client %d already setup\n", client);
CNSTI4 4
ARGI4
ADDRGP4 $530
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 1142
;1142:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $525
JUMPV
LABELV $528
line 1145
;1143:	}
;1144:
;1145:	if (!trap_AAS_Initialized()) {
ADDRLP4 448
ADDRGP4 trap_AAS_Initialized
CALLI4
ASGNI4
ADDRLP4 448
INDIRI4
CNSTI4 0
NEI4 $531
line 1146
;1146:		BotAI_Print(PRT_FATAL, "AAS not initialized\n");
CNSTI4 4
ARGI4
ADDRGP4 $533
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 1147
;1147:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $525
JUMPV
LABELV $531
line 1151
;1148:	}
;1149:
;1150:	//load the bot character
;1151:	bs->character = trap_BotLoadCharacter(settings->characterfile, settings->skill);
ADDRLP4 452
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 452
INDIRP4
ARGP4
ADDRLP4 452
INDIRP4
CNSTI4 144
ADDP4
INDIRF4
ARGF4
ADDRLP4 456
ADDRGP4 trap_BotLoadCharacter
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 6520
ADDP4
ADDRLP4 456
INDIRI4
ASGNI4
line 1152
;1152:	if (!bs->character) {
ADDRLP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $534
line 1153
;1153:		BotAI_Print(PRT_FATAL, "couldn't load skill %f from %s\n", settings->skill, settings->characterfile);
CNSTI4 4
ARGI4
ADDRGP4 $536
ARGP4
ADDRLP4 460
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 460
INDIRP4
CNSTI4 144
ADDP4
INDIRF4
ARGF4
ADDRLP4 460
INDIRP4
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 1154
;1154:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $525
JUMPV
LABELV $534
line 1157
;1155:	}
;1156:	//copy the settings
;1157:	memcpy(&bs->settings, settings, sizeof(bot_settings_t));
ADDRLP4 0
INDIRP4
CNSTI4 4608
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 292
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1159
;1158:	//allocate a goal state
;1159:	bs->gs = trap_BotAllocGoalState(client);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 460
ADDRGP4 trap_BotAllocGoalState
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 6528
ADDP4
ADDRLP4 460
INDIRI4
ASGNI4
line 1161
;1160:	//load the item weights
;1161:	trap_Characteristic_String(bs->character, CHARACTERISTIC_ITEMWEIGHTS, filename, MAX_PATH);
ADDRLP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 40
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Characteristic_String
CALLV
pop
line 1162
;1162:	errnum = trap_BotLoadItemWeights(bs->gs, filename);
ADDRLP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 464
ADDRGP4 trap_BotLoadItemWeights
CALLI4
ASGNI4
ADDRLP4 148
ADDRLP4 464
INDIRI4
ASGNI4
line 1163
;1163:	if (errnum != BLERR_NOERROR) {
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $537
line 1164
;1164:		trap_BotFreeGoalState(bs->gs);
ADDRLP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeGoalState
CALLV
pop
line 1165
;1165:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $525
JUMPV
LABELV $537
line 1168
;1166:	}
;1167:	//allocate a weapon state
;1168:	bs->ws = trap_BotAllocWeaponState();
ADDRLP4 468
ADDRGP4 trap_BotAllocWeaponState
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 6536
ADDP4
ADDRLP4 468
INDIRI4
ASGNI4
line 1170
;1169:	//load the weapon weights
;1170:	trap_Characteristic_String(bs->character, CHARACTERISTIC_WEAPONWEIGHTS, filename, MAX_PATH);
ADDRLP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Characteristic_String
CALLV
pop
line 1171
;1171:	errnum = trap_BotLoadWeaponWeights(bs->ws, filename);
ADDRLP4 0
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 472
ADDRGP4 trap_BotLoadWeaponWeights
CALLI4
ASGNI4
ADDRLP4 148
ADDRLP4 472
INDIRI4
ASGNI4
line 1172
;1172:	if (errnum != BLERR_NOERROR) {
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $539
line 1173
;1173:		trap_BotFreeGoalState(bs->gs);
ADDRLP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeGoalState
CALLV
pop
line 1174
;1174:		trap_BotFreeWeaponState(bs->ws);
ADDRLP4 0
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeWeaponState
CALLV
pop
line 1175
;1175:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $525
JUMPV
LABELV $539
line 1178
;1176:	}
;1177:	//allocate a chat state
;1178:	bs->cs = trap_BotAllocChatState();
ADDRLP4 476
ADDRGP4 trap_BotAllocChatState
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 6532
ADDP4
ADDRLP4 476
INDIRI4
ASGNI4
line 1180
;1179:	//load the chat file
;1180:	trap_Characteristic_String(bs->character, CHARACTERISTIC_CHAT_FILE, filename, MAX_PATH);
ADDRLP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 21
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Characteristic_String
CALLV
pop
line 1181
;1181:	trap_Characteristic_String(bs->character, CHARACTERISTIC_CHAT_NAME, name, MAX_PATH);
ADDRLP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 22
ARGI4
ADDRLP4 296
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Characteristic_String
CALLV
pop
line 1182
;1182:	errnum = trap_BotLoadChatFile(bs->cs, filename, name);
ADDRLP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 296
ARGP4
ADDRLP4 480
ADDRGP4 trap_BotLoadChatFile
CALLI4
ASGNI4
ADDRLP4 148
ADDRLP4 480
INDIRI4
ASGNI4
line 1183
;1183:	if (errnum != BLERR_NOERROR) {
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $541
line 1184
;1184:		trap_BotFreeChatState(bs->cs);
ADDRLP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeChatState
CALLV
pop
line 1185
;1185:		trap_BotFreeGoalState(bs->gs);
ADDRLP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeGoalState
CALLV
pop
line 1186
;1186:		trap_BotFreeWeaponState(bs->ws);
ADDRLP4 0
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeWeaponState
CALLV
pop
line 1187
;1187:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $525
JUMPV
LABELV $541
line 1190
;1188:	}
;1189:	//get the gender characteristic
;1190:	trap_Characteristic_String(bs->character, CHARACTERISTIC_GENDER, gender, MAX_PATH);
ADDRLP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 152
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Characteristic_String
CALLV
pop
line 1192
;1191:	//set the chat gender
;1192:	if (*gender == 'f' || *gender == 'F') trap_BotSetChatGender(bs->cs, CHAT_GENDERFEMALE);
ADDRLP4 484
ADDRLP4 152
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 484
INDIRI4
CNSTI4 102
EQI4 $545
ADDRLP4 484
INDIRI4
CNSTI4 70
NEI4 $543
LABELV $545
ADDRLP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotSetChatGender
CALLV
pop
ADDRGP4 $544
JUMPV
LABELV $543
line 1193
;1193:	else if (*gender == 'm' || *gender == 'M') trap_BotSetChatGender(bs->cs, CHAT_GENDERMALE);
ADDRLP4 488
ADDRLP4 152
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 488
INDIRI4
CNSTI4 109
EQI4 $548
ADDRLP4 488
INDIRI4
CNSTI4 77
NEI4 $546
LABELV $548
ADDRLP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotSetChatGender
CALLV
pop
ADDRGP4 $547
JUMPV
LABELV $546
line 1194
;1194:	else trap_BotSetChatGender(bs->cs, CHAT_GENDERLESS);
ADDRLP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotSetChatGender
CALLV
pop
LABELV $547
LABELV $544
line 1196
;1195:
;1196:	bs->inuse = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 1
ASGNI4
line 1197
;1197:	bs->client = client;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 1198
;1198:	bs->entitynum = client;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 1199
;1199:	bs->setupcount = 4;
ADDRLP4 0
INDIRP4
CNSTI4 6016
ADDP4
CNSTI4 4
ASGNI4
line 1200
;1200:	bs->entergame_time = FloatTime();
ADDRLP4 0
INDIRP4
CNSTI4 6064
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 1201
;1201:	bs->ms = trap_BotAllocMoveState();
ADDRLP4 492
ADDRGP4 trap_BotAllocMoveState
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 6524
ADDP4
ADDRLP4 492
INDIRI4
ASGNI4
line 1202
;1202:	bs->walker = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_WALKER, 0, 1);
ADDRLP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 48
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 500
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 6056
ADDP4
ADDRLP4 500
INDIRF4
ASGNF4
line 1203
;1203:	numbots++;
ADDRLP4 504
ADDRGP4 numbots
ASGNP4
ADDRLP4 504
INDIRP4
ADDRLP4 504
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1205
;1204:
;1205:	if (trap_Cvar_VariableIntegerValue("bot_testichat")) {
ADDRGP4 $551
ARGP4
ADDRLP4 508
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 508
INDIRI4
CNSTI4 0
EQI4 $549
line 1206
;1206:		trap_BotLibVarSet("bot_testichat", "1");
ADDRGP4 $551
ARGP4
ADDRGP4 $328
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1207
;1207:		BotChatTest(bs);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 BotChatTest
CALLV
pop
line 1208
;1208:	}
LABELV $549
line 1210
;1209:	//NOTE: reschedule the bot thinking
;1210:	BotScheduleBotThink();
ADDRGP4 BotScheduleBotThink
CALLV
pop
line 1212
;1211:	//if interbreeding start with a mutation
;1212:	if (bot_interbreed) {
ADDRGP4 bot_interbreed
INDIRI4
CNSTI4 0
EQI4 $552
line 1213
;1213:		trap_BotMutateGoalFuzzyLogic(bs->gs, 1);
ADDRLP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_BotMutateGoalFuzzyLogic
CALLV
pop
line 1214
;1214:	}
LABELV $552
line 1216
;1215:	// if we kept the bot client
;1216:	if (restart) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $554
line 1217
;1217:		BotReadSessionData(bs);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 BotReadSessionData
CALLV
pop
line 1218
;1218:	}
LABELV $554
line 1220
;1219:	//bot has been setup succesfully
;1220:	return qtrue;
CNSTI4 1
RETI4
LABELV $525
endproc BotAISetupClient 512 16
export BotAIShutdownClient
proc BotAIShutdownClient 16 12
line 1228
;1221:}
;1222:
;1223:/*
;1224:==============
;1225:BotAIShutdownClient
;1226:==============
;1227:*/
;1228:int BotAIShutdownClient(int client, qboolean restart) {
line 1231
;1229:	bot_state_t *bs;
;1230:
;1231:	bs = botstates[client];
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
line 1232
;1232:	if (!bs || !bs->inuse) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $559
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $557
LABELV $559
line 1234
;1233:		//BotAI_Print(PRT_ERROR, "BotAIShutdownClient: client %d already shutdown\n", client);
;1234:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $556
JUMPV
LABELV $557
line 1237
;1235:	}
;1236:
;1237:	if (restart) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $560
line 1238
;1238:		BotWriteSessionData(bs);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 BotWriteSessionData
CALLV
pop
line 1239
;1239:	}
LABELV $560
line 1241
;1240:
;1241:	if (BotChat_ExitGame(bs)) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotChat_ExitGame
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $562
line 1242
;1242:		trap_BotEnterChat(bs->cs, bs->client, CHAT_ALL);
ADDRLP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1243
;1243:	}
LABELV $562
line 1245
;1244:
;1245:	trap_BotFreeMoveState(bs->ms);
ADDRLP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeMoveState
CALLV
pop
line 1247
;1246:	//free the goal state`			
;1247:	trap_BotFreeGoalState(bs->gs);
ADDRLP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeGoalState
CALLV
pop
line 1249
;1248:	//free the chat file
;1249:	trap_BotFreeChatState(bs->cs);
ADDRLP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeChatState
CALLV
pop
line 1251
;1250:	//free the weapon weights
;1251:	trap_BotFreeWeaponState(bs->ws);
ADDRLP4 0
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeWeaponState
CALLV
pop
line 1253
;1252:	//free the bot character
;1253:	trap_BotFreeCharacter(bs->character);
ADDRLP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeCharacter
CALLV
pop
line 1255
;1254:	//
;1255:	BotFreeWaypoints(bs->checkpoints);
ADDRLP4 0
INDIRP4
CNSTI4 9072
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotFreeWaypoints
CALLV
pop
line 1256
;1256:	BotFreeWaypoints(bs->patrolpoints);
ADDRLP4 0
INDIRP4
CNSTI4 9076
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotFreeWaypoints
CALLV
pop
line 1258
;1257:	//clear activate goal stack
;1258:	BotClearActivateGoalStack(bs);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 BotClearActivateGoalStack
CALLV
pop
line 1260
;1259:	//clear the bot state
;1260:	memset(bs, 0, sizeof(bot_state_t));
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 9088
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1262
;1261:	//set the inuse flag to qfalse
;1262:	bs->inuse = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 1264
;1263:	//there's one bot less
;1264:	numbots--;
ADDRLP4 12
ADDRGP4 numbots
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1266
;1265:	//everything went ok
;1266:	return qtrue;
CNSTI4 1
RETI4
LABELV $556
endproc BotAIShutdownClient 16 12
export BotResetState
proc BotResetState 796 12
line 1277
;1267:}
;1268:
;1269:/*
;1270:==============
;1271:BotResetState
;1272:
;1273:called when a bot enters the intermission or observer mode and
;1274:when the level is changed
;1275:==============
;1276:*/
;1277:void BotResetState(bot_state_t *bs) {
line 1286
;1278:	int client, entitynum, inuse;
;1279:	int movestate, goalstate, chatstate, weaponstate;
;1280:	bot_settings_t settings;
;1281:	int character;
;1282:	playerState_t ps;							//current player state
;1283:	float entergame_time;
;1284:
;1285:	//save some things that should not be reset here
;1286:	memcpy(&settings, &bs->settings, sizeof(bot_settings_t));
ADDRLP4 28
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 4608
ADDP4
ARGP4
CNSTI4 292
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1287
;1287:	memcpy(&ps, &bs->cur_ps, sizeof(playerState_t));
ADDRLP4 324
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 468
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1288
;1288:	inuse = bs->inuse;
ADDRLP4 8
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 1289
;1289:	client = bs->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1290
;1290:	entitynum = bs->entitynum;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1291
;1291:	character = bs->character;
ADDRLP4 320
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ASGNI4
line 1292
;1292:	movestate = bs->ms;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ASGNI4
line 1293
;1293:	goalstate = bs->gs;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ASGNI4
line 1294
;1294:	chatstate = bs->cs;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ASGNI4
line 1295
;1295:	weaponstate = bs->ws;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
ASGNI4
line 1296
;1296:	entergame_time = bs->entergame_time;
ADDRLP4 792
ADDRFP4 0
INDIRP4
CNSTI4 6064
ADDP4
INDIRF4
ASGNF4
line 1298
;1297:	//free checkpoints and patrol points
;1298:	BotFreeWaypoints(bs->checkpoints);
ADDRFP4 0
INDIRP4
CNSTI4 9072
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotFreeWaypoints
CALLV
pop
line 1299
;1299:	BotFreeWaypoints(bs->patrolpoints);
ADDRFP4 0
INDIRP4
CNSTI4 9076
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotFreeWaypoints
CALLV
pop
line 1301
;1300:	//reset the whole state
;1301:	memset(bs, 0, sizeof(bot_state_t));
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 9088
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1303
;1302:	//copy back some state stuff that should not be reset
;1303:	bs->ms = movestate;
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1304
;1304:	bs->gs = goalstate;
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1305
;1305:	bs->cs = chatstate;
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 1306
;1306:	bs->ws = weaponstate;
ADDRFP4 0
INDIRP4
CNSTI4 6536
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 1307
;1307:	memcpy(&bs->cur_ps, &ps, sizeof(playerState_t));
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 324
ARGP4
CNSTI4 468
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1308
;1308:	memcpy(&bs->settings, &settings, sizeof(bot_settings_t));
ADDRFP4 0
INDIRP4
CNSTI4 4608
ADDP4
ARGP4
ADDRLP4 28
ARGP4
CNSTI4 292
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1309
;1309:	bs->inuse = inuse;
ADDRFP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ASGNI4
line 1310
;1310:	bs->client = client;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1311
;1311:	bs->entitynum = entitynum;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 1312
;1312:	bs->character = character;
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
ADDRLP4 320
INDIRI4
ASGNI4
line 1313
;1313:	bs->entergame_time = entergame_time;
ADDRFP4 0
INDIRP4
CNSTI4 6064
ADDP4
ADDRLP4 792
INDIRF4
ASGNF4
line 1315
;1314:	//reset several states
;1315:	if (bs->ms) trap_BotResetMoveState(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
CNSTI4 0
EQI4 $565
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetMoveState
CALLV
pop
LABELV $565
line 1316
;1316:	if (bs->gs) trap_BotResetGoalState(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
CNSTI4 0
EQI4 $567
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetGoalState
CALLV
pop
LABELV $567
line 1317
;1317:	if (bs->ws) trap_BotResetWeaponState(bs->ws);
ADDRFP4 0
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
CNSTI4 0
EQI4 $569
ADDRFP4 0
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetWeaponState
CALLV
pop
LABELV $569
line 1318
;1318:	if (bs->gs) trap_BotResetAvoidGoals(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
CNSTI4 0
EQI4 $571
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidGoals
CALLV
pop
LABELV $571
line 1319
;1319:	if (bs->ms) trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
CNSTI4 0
EQI4 $573
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
LABELV $573
line 1320
;1320:}
LABELV $564
endproc BotResetState 796 12
export BotAILoadMap
proc BotAILoadMap 280 16
line 1327
;1321:
;1322:/*
;1323:==============
;1324:BotAILoadMap
;1325:==============
;1326:*/
;1327:int BotAILoadMap( int restart ) {
line 1331
;1328:	int			i;
;1329:	vmCvar_t	mapname;
;1330:
;1331:	if (!restart) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $576
line 1332
;1332:		trap_Cvar_Register( &mapname, "mapname", "", CVAR_SERVERINFO | CVAR_ROM );
ADDRLP4 4
ARGP4
ADDRGP4 $578
ARGP4
ADDRGP4 $312
ARGP4
CNSTI4 68
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1333
;1333:		trap_BotLibLoadMap( mapname.string );
ADDRLP4 4+16
ARGP4
ADDRGP4 trap_BotLibLoadMap
CALLI4
pop
line 1334
;1334:	}
LABELV $576
line 1336
;1335:
;1336:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $580
line 1337
;1337:		if (botstates[i] && botstates[i]->inuse) {
ADDRLP4 276
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 276
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $584
ADDRLP4 276
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $584
line 1338
;1338:			BotResetState( botstates[i] );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotResetState
CALLV
pop
line 1339
;1339:			botstates[i]->setupcount = 4;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 6016
ADDP4
CNSTI4 4
ASGNI4
line 1340
;1340:		}
LABELV $584
line 1341
;1341:	}
LABELV $581
line 1336
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $580
line 1343
;1342:
;1343:	BotSetupDeathmatchAI();
ADDRGP4 BotSetupDeathmatchAI
CALLV
pop
line 1345
;1344:
;1345:	return qtrue;
CNSTI4 1
RETI4
LABELV $575
endproc BotAILoadMap 280 16
bss
align 4
LABELV $587
skip 4
align 4
LABELV $588
skip 4
align 4
LABELV $589
skip 4
export BotAIStartFrame
code
proc BotAIStartFrame 152 12
line 1357
;1346:}
;1347:
;1348:#ifdef MISSIONPACK
;1349:void ProximityMine_Trigger( gentity_t *trigger, gentity_t *other, trace_t *trace );
;1350:#endif
;1351:
;1352:/*
;1353:==================
;1354:BotAIStartFrame
;1355:==================
;1356:*/
;1357:int BotAIStartFrame(int time) {
line 1366
;1358:	int i;
;1359:	gentity_t	*ent;
;1360:	bot_entitystate_t state;
;1361:	int elapsed_time, thinktime;
;1362:	static int local_time;
;1363:	static int botlib_residual;
;1364:	static int lastbotthink_time;
;1365:
;1366:	G_CheckBotSpawn();
ADDRGP4 G_CheckBotSpawn
CALLV
pop
line 1368
;1367:
;1368:	trap_Cvar_Update(&bot_rocketjump);
ADDRGP4 bot_rocketjump
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1369
;1369:	trap_Cvar_Update(&bot_grapple);
ADDRGP4 bot_grapple
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1370
;1370:	trap_Cvar_Update(&bot_fastchat);
ADDRGP4 bot_fastchat
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1371
;1371:	trap_Cvar_Update(&bot_nochat);
ADDRGP4 bot_nochat
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1372
;1372:	trap_Cvar_Update(&bot_testrchat);
ADDRGP4 bot_testrchat
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1373
;1373:	trap_Cvar_Update(&bot_thinktime);
ADDRGP4 bot_thinktime
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1374
;1374:	trap_Cvar_Update(&bot_memorydump);
ADDRGP4 bot_memorydump
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1375
;1375:	trap_Cvar_Update(&bot_saveroutingcache);
ADDRGP4 bot_saveroutingcache
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1376
;1376:	trap_Cvar_Update(&bot_pause);
ADDRGP4 bot_pause
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1377
;1377:	trap_Cvar_Update(&bot_report);
ADDRGP4 bot_report
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1379
;1378:
;1379:	if (bot_report.integer) {
ADDRGP4 bot_report+12
INDIRI4
CNSTI4 0
EQI4 $590
line 1382
;1380://		BotTeamplayReport();
;1381://		trap_Cvar_Set("bot_report", "0");
;1382:		BotUpdateInfoConfigStrings();
ADDRGP4 BotUpdateInfoConfigStrings
CALLV
pop
line 1383
;1383:	}
LABELV $590
line 1385
;1384:
;1385:	if (bot_pause.integer) {
ADDRGP4 bot_pause+12
INDIRI4
CNSTI4 0
EQI4 $593
line 1387
;1386:		// execute bot user commands every frame
;1387:		for( i = 0; i < MAX_CLIENTS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $596
line 1388
;1388:			if( !botstates[i] || !botstates[i]->inuse ) {
ADDRLP4 128
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 128
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $602
ADDRLP4 128
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $600
LABELV $602
line 1389
;1389:				continue;
ADDRGP4 $597
JUMPV
LABELV $600
line 1391
;1390:			}
;1391:			if( g_entities[i].client->pers.connected != CON_CONNECTED ) {
CNSTI4 896
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $603
line 1392
;1392:				continue;
ADDRGP4 $597
JUMPV
LABELV $603
line 1394
;1393:			}
;1394:			botstates[i]->lastucmd.forwardmove = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 509
ADDP4
CNSTI1 0
ASGNI1
line 1395
;1395:			botstates[i]->lastucmd.rightmove = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 510
ADDP4
CNSTI1 0
ASGNI1
line 1396
;1396:			botstates[i]->lastucmd.upmove = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 511
ADDP4
CNSTI1 0
ASGNI1
line 1397
;1397:			botstates[i]->lastucmd.buttons = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 504
ADDP4
CNSTI4 0
ASGNI4
line 1398
;1398:			botstates[i]->lastucmd.serverTime = time;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 488
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 1399
;1399:			trap_BotUserCommand(botstates[i]->client, &botstates[i]->lastucmd);
ADDRLP4 132
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 132
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 132
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRGP4 trap_BotUserCommand
CALLV
pop
line 1400
;1400:		}
LABELV $597
line 1387
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $596
line 1401
;1401:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $586
JUMPV
LABELV $593
line 1404
;1402:	}
;1403:
;1404:	if (bot_memorydump.integer) {
ADDRGP4 bot_memorydump+12
INDIRI4
CNSTI4 0
EQI4 $606
line 1405
;1405:		trap_BotLibVarSet("memorydump", "1");
ADDRGP4 $609
ARGP4
ADDRGP4 $328
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1406
;1406:		trap_Cvar_Set("bot_memorydump", "0");
ADDRGP4 $610
ARGP4
ADDRGP4 $611
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1407
;1407:	}
LABELV $606
line 1408
;1408:	if (bot_saveroutingcache.integer) {
ADDRGP4 bot_saveroutingcache+12
INDIRI4
CNSTI4 0
EQI4 $612
line 1409
;1409:		trap_BotLibVarSet("saveroutingcache", "1");
ADDRGP4 $615
ARGP4
ADDRGP4 $328
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1410
;1410:		trap_Cvar_Set("bot_saveroutingcache", "0");
ADDRGP4 $616
ARGP4
ADDRGP4 $611
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1411
;1411:	}
LABELV $612
line 1413
;1412:	//check if bot interbreeding is activated
;1413:	BotInterbreeding();
ADDRGP4 BotInterbreeding
CALLV
pop
line 1415
;1414:	//cap the bot think time
;1415:	if (bot_thinktime.integer > 200) {
ADDRGP4 bot_thinktime+12
INDIRI4
CNSTI4 200
LEI4 $617
line 1416
;1416:		trap_Cvar_Set("bot_thinktime", "200");
ADDRGP4 $620
ARGP4
ADDRGP4 $621
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1417
;1417:	}
LABELV $617
line 1419
;1418:	//if the bot think time changed we should reschedule the bots
;1419:	if (bot_thinktime.integer != lastbotthink_time) {
ADDRGP4 bot_thinktime+12
INDIRI4
ADDRGP4 $589
INDIRI4
EQI4 $622
line 1420
;1420:		lastbotthink_time = bot_thinktime.integer;
ADDRGP4 $589
ADDRGP4 bot_thinktime+12
INDIRI4
ASGNI4
line 1421
;1421:		BotScheduleBotThink();
ADDRGP4 BotScheduleBotThink
CALLV
pop
line 1422
;1422:	}
LABELV $622
line 1424
;1423:
;1424:	elapsed_time = time - local_time;
ADDRLP4 120
ADDRFP4 0
INDIRI4
ADDRGP4 $587
INDIRI4
SUBI4
ASGNI4
line 1425
;1425:	local_time = time;
ADDRGP4 $587
ADDRFP4 0
INDIRI4
ASGNI4
line 1427
;1426:
;1427:	botlib_residual += elapsed_time;
ADDRLP4 128
ADDRGP4 $588
ASGNP4
ADDRLP4 128
INDIRP4
ADDRLP4 128
INDIRP4
INDIRI4
ADDRLP4 120
INDIRI4
ADDI4
ASGNI4
line 1429
;1428:
;1429:	if (elapsed_time > bot_thinktime.integer) thinktime = elapsed_time;
ADDRLP4 120
INDIRI4
ADDRGP4 bot_thinktime+12
INDIRI4
LEI4 $626
ADDRLP4 124
ADDRLP4 120
INDIRI4
ASGNI4
ADDRGP4 $627
JUMPV
LABELV $626
line 1430
;1430:	else thinktime = bot_thinktime.integer;
ADDRLP4 124
ADDRGP4 bot_thinktime+12
INDIRI4
ASGNI4
LABELV $627
line 1433
;1431:
;1432:	// update the bot library
;1433:	if ( botlib_residual >= thinktime ) {
ADDRGP4 $588
INDIRI4
ADDRLP4 124
INDIRI4
LTI4 $630
line 1434
;1434:		botlib_residual -= thinktime;
ADDRLP4 132
ADDRGP4 $588
ASGNP4
ADDRLP4 132
INDIRP4
ADDRLP4 132
INDIRP4
INDIRI4
ADDRLP4 124
INDIRI4
SUBI4
ASGNI4
line 1436
;1435:
;1436:		trap_BotLibStartFrame((float) time / 1000);
ADDRFP4 0
INDIRI4
CVIF4 4
CNSTF4 1148846080
DIVF4
ARGF4
ADDRGP4 trap_BotLibStartFrame
CALLI4
pop
line 1438
;1437:
;1438:		if (!trap_AAS_Initialized()) return qfalse;
ADDRLP4 136
ADDRGP4 trap_AAS_Initialized
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 0
NEI4 $632
CNSTI4 0
RETI4
ADDRGP4 $586
JUMPV
LABELV $632
line 1441
;1439:
;1440:		//update entities in the botlib
;1441:		for (i = 0; i < MAX_GENTITIES; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $634
line 1442
;1442:			ent = &g_entities[i];
ADDRLP4 4
CNSTI4 896
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1443
;1443:			if (!ent->inuse) {
ADDRLP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $638
line 1444
;1444:				trap_BotLibUpdateEntity(i, NULL);
ADDRLP4 0
INDIRI4
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 trap_BotLibUpdateEntity
CALLI4
pop
line 1445
;1445:				continue;
ADDRGP4 $635
JUMPV
LABELV $638
line 1447
;1446:			}
;1447:			if (!ent->r.linked) {
ADDRLP4 4
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
NEI4 $640
line 1448
;1448:				trap_BotLibUpdateEntity(i, NULL);
ADDRLP4 0
INDIRI4
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 trap_BotLibUpdateEntity
CALLI4
pop
line 1449
;1449:				continue;
ADDRGP4 $635
JUMPV
LABELV $640
line 1451
;1450:			}
;1451:			if (ent->r.svFlags & SVF_NOCLIENT) {
ADDRLP4 4
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $642
line 1452
;1452:				trap_BotLibUpdateEntity(i, NULL);
ADDRLP4 0
INDIRI4
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 trap_BotLibUpdateEntity
CALLI4
pop
line 1453
;1453:				continue;
ADDRGP4 $635
JUMPV
LABELV $642
line 1456
;1454:			}
;1455:			// do not update missiles
;1456:			if (ent->s.eType == ET_MISSILE && ent->s.weapon != WP_GRAPPLING_HOOK) {
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $644
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 10
EQI4 $644
line 1457
;1457:				trap_BotLibUpdateEntity(i, NULL);
ADDRLP4 0
INDIRI4
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 trap_BotLibUpdateEntity
CALLI4
pop
line 1458
;1458:				continue;
ADDRGP4 $635
JUMPV
LABELV $644
line 1461
;1459:			}
;1460:			// do not update event only entities
;1461:			if (ent->s.eType > ET_EVENTS) {
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
LEI4 $646
line 1462
;1462:				trap_BotLibUpdateEntity(i, NULL);
ADDRLP4 0
INDIRI4
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 trap_BotLibUpdateEntity
CALLI4
pop
line 1463
;1463:				continue;
ADDRGP4 $635
JUMPV
LABELV $646
line 1475
;1464:			}
;1465:#ifdef MISSIONPACK
;1466:			// never link prox mine triggers
;1467:			if (ent->r.contents == CONTENTS_TRIGGER) {
;1468:				if (ent->touch == ProximityMine_Trigger) {
;1469:					trap_BotLibUpdateEntity(i, NULL);
;1470:					continue;
;1471:				}
;1472:			}
;1473:#endif
;1474:			//
;1475:			memset(&state, 0, sizeof(bot_entitystate_t));
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
CNSTI4 112
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1477
;1476:			//
;1477:			VectorCopy(ent->r.currentOrigin, state.origin);
ADDRLP4 8+8
ADDRLP4 4
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 1478
;1478:			if (i < MAX_CLIENTS) {
ADDRLP4 0
INDIRI4
CNSTI4 64
GEI4 $649
line 1479
;1479:				VectorCopy(ent->s.apos.trBase, state.angles);
ADDRLP4 8+20
ADDRLP4 4
INDIRP4
CNSTI4 60
ADDP4
INDIRB
ASGNB 12
line 1480
;1480:			} else {
ADDRGP4 $650
JUMPV
LABELV $649
line 1481
;1481:				VectorCopy(ent->r.currentAngles, state.angles);
ADDRLP4 8+20
ADDRLP4 4
INDIRP4
CNSTI4 500
ADDP4
INDIRB
ASGNB 12
line 1482
;1482:			}
LABELV $650
line 1483
;1483:			VectorCopy(ent->s.origin2, state.old_origin);
ADDRLP4 8+32
ADDRLP4 4
INDIRP4
CNSTI4 104
ADDP4
INDIRB
ASGNB 12
line 1484
;1484:			VectorCopy(ent->r.mins, state.mins);
ADDRLP4 8+44
ADDRLP4 4
INDIRP4
CNSTI4 436
ADDP4
INDIRB
ASGNB 12
line 1485
;1485:			VectorCopy(ent->r.maxs, state.maxs);
ADDRLP4 8+56
ADDRLP4 4
INDIRP4
CNSTI4 448
ADDP4
INDIRB
ASGNB 12
line 1486
;1486:			state.type = ent->s.eType;
ADDRLP4 8
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1487
;1487:			state.flags = ent->s.eFlags;
ADDRLP4 8+4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1488
;1488:			if (ent->r.bmodel) state.solid = SOLID_BSP;
ADDRLP4 4
INDIRP4
CNSTI4 432
ADDP4
INDIRI4
CNSTI4 0
EQI4 $657
ADDRLP4 8+72
CNSTI4 3
ASGNI4
ADDRGP4 $658
JUMPV
LABELV $657
line 1489
;1489:			else state.solid = SOLID_BBOX;
ADDRLP4 8+72
CNSTI4 2
ASGNI4
LABELV $658
line 1490
;1490:			state.groundent = ent->s.groundEntityNum;
ADDRLP4 8+68
ADDRLP4 4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ASGNI4
line 1491
;1491:			state.modelindex = ent->s.modelindex;
ADDRLP4 8+76
ADDRLP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ASGNI4
line 1492
;1492:			state.modelindex2 = ent->s.modelindex2;
ADDRLP4 8+80
ADDRLP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
ASGNI4
line 1493
;1493:			state.frame = ent->s.frame;
ADDRLP4 8+84
ADDRLP4 4
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ASGNI4
line 1494
;1494:			state.event = ent->s.event;
ADDRLP4 8+88
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ASGNI4
line 1495
;1495:			state.eventParm = ent->s.eventParm;
ADDRLP4 8+92
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 1496
;1496:			state.powerups = ent->s.powerups;
ADDRLP4 8+96
ADDRLP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ASGNI4
line 1497
;1497:			state.legsAnim = ent->s.legsAnim;
ADDRLP4 8+104
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
line 1498
;1498:			state.torsoAnim = ent->s.torsoAnim;
ADDRLP4 8+108
ADDRLP4 4
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ASGNI4
line 1499
;1499:			state.weapon = ent->s.weapon;
ADDRLP4 8+100
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
line 1501
;1500:			//
;1501:			trap_BotLibUpdateEntity(i, &state);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRGP4 trap_BotLibUpdateEntity
CALLI4
pop
line 1502
;1502:		}
LABELV $635
line 1441
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1024
LTI4 $634
line 1504
;1503:
;1504:		BotAIRegularUpdate();
ADDRGP4 BotAIRegularUpdate
CALLV
pop
line 1505
;1505:	}
LABELV $630
line 1507
;1506:
;1507:	floattime = trap_AAS_Time();
ADDRLP4 132
ADDRGP4 trap_AAS_Time
CALLF4
ASGNF4
ADDRGP4 floattime
ADDRLP4 132
INDIRF4
ASGNF4
line 1510
;1508:
;1509:	// execute scheduled bot AI
;1510:	for( i = 0; i < MAX_CLIENTS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $671
line 1511
;1511:		if( !botstates[i] || !botstates[i]->inuse ) {
ADDRLP4 136
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 136
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $677
ADDRLP4 136
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $675
LABELV $677
line 1512
;1512:			continue;
ADDRGP4 $672
JUMPV
LABELV $675
line 1515
;1513:		}
;1514:		//
;1515:		botstates[i]->botthink_residual += elapsed_time;
ADDRLP4 140
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 140
INDIRP4
ADDRLP4 140
INDIRP4
INDIRI4
ADDRLP4 120
INDIRI4
ADDI4
ASGNI4
line 1517
;1516:		//
;1517:		if ( botstates[i]->botthink_residual >= thinktime ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 124
INDIRI4
LTI4 $678
line 1518
;1518:			botstates[i]->botthink_residual -= thinktime;
ADDRLP4 144
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 144
INDIRP4
ADDRLP4 144
INDIRP4
INDIRI4
ADDRLP4 124
INDIRI4
SUBI4
ASGNI4
line 1520
;1519:
;1520:			if (!trap_AAS_Initialized()) return qfalse;
ADDRLP4 148
ADDRGP4 trap_AAS_Initialized
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $680
CNSTI4 0
RETI4
ADDRGP4 $586
JUMPV
LABELV $680
line 1522
;1521:
;1522:			if (g_entities[i].client->pers.connected == CON_CONNECTED) {
CNSTI4 896
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $682
line 1523
;1523:				BotAI(i, (float) thinktime / 1000);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 124
INDIRI4
CVIF4 4
CNSTF4 1148846080
DIVF4
ARGF4
ADDRGP4 BotAI
CALLI4
pop
line 1524
;1524:			}
LABELV $682
line 1525
;1525:		}
LABELV $678
line 1526
;1526:	}
LABELV $672
line 1510
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $671
line 1530
;1527:
;1528:
;1529:	// execute bot user commands every frame
;1530:	for( i = 0; i < MAX_CLIENTS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $685
line 1531
;1531:		if( !botstates[i] || !botstates[i]->inuse ) {
ADDRLP4 136
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 136
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $691
ADDRLP4 136
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $689
LABELV $691
line 1532
;1532:			continue;
ADDRGP4 $686
JUMPV
LABELV $689
line 1534
;1533:		}
;1534:		if( g_entities[i].client->pers.connected != CON_CONNECTED ) {
CNSTI4 896
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $692
line 1535
;1535:			continue;
ADDRGP4 $686
JUMPV
LABELV $692
line 1538
;1536:		}
;1537:
;1538:		BotUpdateInput(botstates[i], time, elapsed_time);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 120
INDIRI4
ARGI4
ADDRGP4 BotUpdateInput
CALLV
pop
line 1539
;1539:		trap_BotUserCommand(botstates[i]->client, &botstates[i]->lastucmd);
ADDRLP4 140
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 140
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 140
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRGP4 trap_BotUserCommand
CALLV
pop
line 1540
;1540:	}
LABELV $686
line 1530
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $685
line 1542
;1541:
;1542:	return qtrue;
CNSTI4 1
RETI4
LABELV $586
endproc BotAIStartFrame 152 12
export BotInitLibrary
proc BotInitLibrary 212 16
line 1550
;1543:}
;1544:
;1545:/*
;1546:==============
;1547:BotInitLibrary
;1548:==============
;1549:*/
;1550:int BotInitLibrary(void) {
line 1554
;1551:	char buf[144];
;1552:
;1553:	//set the maxclients and maxentities library variables before calling BotSetupLibrary
;1554:	trap_Cvar_VariableStringBuffer("sv_maxclients", buf, sizeof(buf));
ADDRGP4 $696
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1555
;1555:	if (!strlen(buf)) strcpy(buf, "8");
ADDRLP4 0
ARGP4
ADDRLP4 144
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
NEI4 $697
ADDRLP4 0
ARGP4
ADDRGP4 $699
ARGP4
ADDRGP4 strcpy
CALLP4
pop
LABELV $697
line 1556
;1556:	trap_BotLibVarSet("maxclients", buf);
ADDRGP4 $700
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1557
;1557:	Com_sprintf(buf, sizeof(buf), "%d", MAX_GENTITIES);
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 $320
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1558
;1558:	trap_BotLibVarSet("maxentities", buf);
ADDRGP4 $701
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1560
;1559:	//bsp checksum
;1560:	trap_Cvar_VariableStringBuffer("sv_mapChecksum", buf, sizeof(buf));
ADDRGP4 $702
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1561
;1561:	if (strlen(buf)) trap_BotLibVarSet("sv_mapChecksum", buf);
ADDRLP4 0
ARGP4
ADDRLP4 148
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $703
ADDRGP4 $702
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $703
line 1563
;1562:	//maximum number of aas links
;1563:	trap_Cvar_VariableStringBuffer("max_aaslinks", buf, sizeof(buf));
ADDRGP4 $705
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1564
;1564:	if (strlen(buf)) trap_BotLibVarSet("max_aaslinks", buf);
ADDRLP4 0
ARGP4
ADDRLP4 152
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $706
ADDRGP4 $705
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $706
line 1566
;1565:	//maximum number of items in a level
;1566:	trap_Cvar_VariableStringBuffer("max_levelitems", buf, sizeof(buf));
ADDRGP4 $708
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1567
;1567:	if (strlen(buf)) trap_BotLibVarSet("max_levelitems", buf);
ADDRLP4 0
ARGP4
ADDRLP4 156
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
EQI4 $709
ADDRGP4 $708
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $709
line 1569
;1568:	//game type
;1569:	trap_Cvar_VariableStringBuffer("g_gametype", buf, sizeof(buf));
ADDRGP4 $319
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1570
;1570:	if (!strlen(buf)) strcpy(buf, "0");
ADDRLP4 0
ARGP4
ADDRLP4 160
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
NEI4 $711
ADDRLP4 0
ARGP4
ADDRGP4 $611
ARGP4
ADDRGP4 strcpy
CALLP4
pop
LABELV $711
line 1571
;1571:	trap_BotLibVarSet("g_gametype", buf);
ADDRGP4 $319
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1573
;1572:	//bot developer mode and log file
;1573:	trap_BotLibVarSet("bot_developer", bot_developer.string);
ADDRGP4 $713
ARGP4
ADDRGP4 bot_developer+16
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1574
;1574:	trap_BotLibVarSet("log", buf);
ADDRGP4 $715
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1576
;1575:	//no chatting
;1576:	trap_Cvar_VariableStringBuffer("bot_nochat", buf, sizeof(buf));
ADDRGP4 $716
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1577
;1577:	if (strlen(buf)) trap_BotLibVarSet("nochat", "0");
ADDRLP4 0
ARGP4
ADDRLP4 164
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 0
EQI4 $717
ADDRGP4 $719
ARGP4
ADDRGP4 $611
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $717
line 1579
;1578:	//visualize jump pads
;1579:	trap_Cvar_VariableStringBuffer("bot_visualizejumppads", buf, sizeof(buf));
ADDRGP4 $720
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1580
;1580:	if (strlen(buf)) trap_BotLibVarSet("bot_visualizejumppads", buf);
ADDRLP4 0
ARGP4
ADDRLP4 168
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 0
EQI4 $721
ADDRGP4 $720
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $721
line 1582
;1581:	//forced clustering calculations
;1582:	trap_Cvar_VariableStringBuffer("bot_forceclustering", buf, sizeof(buf));
ADDRGP4 $723
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1583
;1583:	if (strlen(buf)) trap_BotLibVarSet("forceclustering", buf);
ADDRLP4 0
ARGP4
ADDRLP4 172
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
EQI4 $724
ADDRGP4 $726
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $724
line 1585
;1584:	//forced reachability calculations
;1585:	trap_Cvar_VariableStringBuffer("bot_forcereachability", buf, sizeof(buf));
ADDRGP4 $727
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1586
;1586:	if (strlen(buf)) trap_BotLibVarSet("forcereachability", buf);
ADDRLP4 0
ARGP4
ADDRLP4 176
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 0
EQI4 $728
ADDRGP4 $730
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $728
line 1588
;1587:	//force writing of AAS to file
;1588:	trap_Cvar_VariableStringBuffer("bot_forcewrite", buf, sizeof(buf));
ADDRGP4 $731
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1589
;1589:	if (strlen(buf)) trap_BotLibVarSet("forcewrite", buf);
ADDRLP4 0
ARGP4
ADDRLP4 180
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 0
EQI4 $732
ADDRGP4 $734
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $732
line 1591
;1590:	//no AAS optimization
;1591:	trap_Cvar_VariableStringBuffer("bot_aasoptimize", buf, sizeof(buf));
ADDRGP4 $735
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1592
;1592:	if (strlen(buf)) trap_BotLibVarSet("aasoptimize", buf);
ADDRLP4 0
ARGP4
ADDRLP4 184
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 184
INDIRI4
CNSTI4 0
EQI4 $736
ADDRGP4 $738
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $736
line 1594
;1593:	//
;1594:	trap_Cvar_VariableStringBuffer("bot_saveroutingcache", buf, sizeof(buf));
ADDRGP4 $616
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1595
;1595:	if (strlen(buf)) trap_BotLibVarSet("saveroutingcache", buf);
ADDRLP4 0
ARGP4
ADDRLP4 188
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 188
INDIRI4
CNSTI4 0
EQI4 $739
ADDRGP4 $615
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $739
line 1597
;1596:	//reload instead of cache bot character files
;1597:	trap_Cvar_VariableStringBuffer("bot_reloadcharacters", buf, sizeof(buf));
ADDRGP4 $327
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1598
;1598:	if (!strlen(buf)) strcpy(buf, "0");
ADDRLP4 0
ARGP4
ADDRLP4 192
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 0
NEI4 $741
ADDRLP4 0
ARGP4
ADDRGP4 $611
ARGP4
ADDRGP4 strcpy
CALLP4
pop
LABELV $741
line 1599
;1599:	trap_BotLibVarSet("bot_reloadcharacters", buf);
ADDRGP4 $327
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1601
;1600:	//base directory
;1601:	trap_Cvar_VariableStringBuffer("fs_basepath", buf, sizeof(buf));
ADDRGP4 $743
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1602
;1602:	if (strlen(buf)) trap_BotLibVarSet("basedir", buf);
ADDRLP4 0
ARGP4
ADDRLP4 196
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 0
EQI4 $744
ADDRGP4 $746
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $744
line 1604
;1603:	//game directory
;1604:	trap_Cvar_VariableStringBuffer("fs_game", buf, sizeof(buf));
ADDRGP4 $747
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1605
;1605:	if (strlen(buf)) trap_BotLibVarSet("gamedir", buf);
ADDRLP4 0
ARGP4
ADDRLP4 200
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 200
INDIRI4
CNSTI4 0
EQI4 $748
ADDRGP4 $750
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $748
line 1607
;1606:	//cd directory
;1607:	trap_Cvar_VariableStringBuffer("fs_cdpath", buf, sizeof(buf));
ADDRGP4 $751
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1608
;1608:	if (strlen(buf)) trap_BotLibVarSet("cddir", buf);
ADDRLP4 0
ARGP4
ADDRLP4 204
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 0
EQI4 $752
ADDRGP4 $754
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $752
line 1614
;1609:	//
;1610:#ifdef MISSIONPACK
;1611:	trap_BotLibDefine("MISSIONPACK");
;1612:#endif
;1613:	//setup the bot library
;1614:	return trap_BotLibSetup();
ADDRLP4 208
ADDRGP4 trap_BotLibSetup
CALLI4
ASGNI4
ADDRLP4 208
INDIRI4
RETI4
LABELV $695
endproc BotInitLibrary 212 16
export BotAISetup
proc BotAISetup 8 16
line 1622
;1615:}
;1616:
;1617:/*
;1618:==============
;1619:BotAISetup
;1620:==============
;1621:*/
;1622:int BotAISetup( int restart ) {
line 1625
;1623:	int			errnum;
;1624:
;1625:	trap_Cvar_Register(&bot_thinktime, "bot_thinktime", "100", CVAR_CHEAT);
ADDRGP4 bot_thinktime
ARGP4
ADDRGP4 $620
ARGP4
ADDRGP4 $756
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1626
;1626:	trap_Cvar_Register(&bot_memorydump, "bot_memorydump", "0", CVAR_CHEAT);
ADDRGP4 bot_memorydump
ARGP4
ADDRGP4 $610
ARGP4
ADDRGP4 $611
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1627
;1627:	trap_Cvar_Register(&bot_saveroutingcache, "bot_saveroutingcache", "0", CVAR_CHEAT);
ADDRGP4 bot_saveroutingcache
ARGP4
ADDRGP4 $616
ARGP4
ADDRGP4 $611
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1628
;1628:	trap_Cvar_Register(&bot_pause, "bot_pause", "0", CVAR_CHEAT);
ADDRGP4 bot_pause
ARGP4
ADDRGP4 $757
ARGP4
ADDRGP4 $611
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1629
;1629:	trap_Cvar_Register(&bot_report, "bot_report", "0", CVAR_CHEAT);
ADDRGP4 bot_report
ARGP4
ADDRGP4 $758
ARGP4
ADDRGP4 $611
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1630
;1630:	trap_Cvar_Register(&bot_testsolid, "bot_testsolid", "0", CVAR_CHEAT);
ADDRGP4 bot_testsolid
ARGP4
ADDRGP4 $759
ARGP4
ADDRGP4 $611
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1631
;1631:	trap_Cvar_Register(&bot_testclusters, "bot_testclusters", "0", CVAR_CHEAT);
ADDRGP4 bot_testclusters
ARGP4
ADDRGP4 $760
ARGP4
ADDRGP4 $611
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1632
;1632:	trap_Cvar_Register(&bot_developer, "bot_developer", "0", CVAR_CHEAT);
ADDRGP4 bot_developer
ARGP4
ADDRGP4 $713
ARGP4
ADDRGP4 $611
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1633
;1633:	trap_Cvar_Register(&bot_interbreedchar, "bot_interbreedchar", "", 0);
ADDRGP4 bot_interbreedchar
ARGP4
ADDRGP4 $337
ARGP4
ADDRGP4 $312
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1634
;1634:	trap_Cvar_Register(&bot_interbreedbots, "bot_interbreedbots", "10", 0);
ADDRGP4 bot_interbreedbots
ARGP4
ADDRGP4 $761
ARGP4
ADDRGP4 $762
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1635
;1635:	trap_Cvar_Register(&bot_interbreedcycle, "bot_interbreedcycle", "20", 0);
ADDRGP4 bot_interbreedcycle
ARGP4
ADDRGP4 $763
ARGP4
ADDRGP4 $764
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1636
;1636:	trap_Cvar_Register(&bot_interbreedwrite, "bot_interbreedwrite", "", 0);
ADDRGP4 bot_interbreedwrite
ARGP4
ADDRGP4 $311
ARGP4
ADDRGP4 $312
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1639
;1637:
;1638:	//if the game is restarted for a tournament
;1639:	if (restart) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $765
line 1640
;1640:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $755
JUMPV
LABELV $765
line 1644
;1641:	}
;1642:
;1643:	//initialize the bot states
;1644:	memset( botstates, 0, sizeof(botstates) );
ADDRGP4 botstates
ARGP4
CNSTI4 0
ARGI4
CNSTI4 256
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1646
;1645:
;1646:	errnum = BotInitLibrary();
ADDRLP4 4
ADDRGP4 BotInitLibrary
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 1647
;1647:	if (errnum != BLERR_NOERROR) return qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $767
CNSTI4 0
RETI4
ADDRGP4 $755
JUMPV
LABELV $767
line 1648
;1648:	return qtrue;
CNSTI4 1
RETI4
LABELV $755
endproc BotAISetup 8 16
export BotAIShutdown
proc BotAIShutdown 8 8
line 1656
;1649:}
;1650:
;1651:/*
;1652:==============
;1653:BotAIShutdown
;1654:==============
;1655:*/
;1656:int BotAIShutdown( int restart ) {
line 1661
;1657:
;1658:	int i;
;1659:
;1660:	//if the game is restarted for a tournament
;1661:	if ( restart ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $770
line 1663
;1662:		//shutdown all the bots in the botlib
;1663:		for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $772
line 1664
;1664:			if (botstates[i] && botstates[i]->inuse) {
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $776
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $776
line 1665
;1665:				BotAIShutdownClient(botstates[i]->client, restart);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 BotAIShutdownClient
CALLI4
pop
line 1666
;1666:			}
LABELV $776
line 1667
;1667:		}
LABELV $773
line 1663
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $772
line 1669
;1668:		//don't shutdown the bot library
;1669:	}
ADDRGP4 $771
JUMPV
LABELV $770
line 1670
;1670:	else {
line 1671
;1671:		trap_BotLibShutdown();
ADDRGP4 trap_BotLibShutdown
CALLI4
pop
line 1672
;1672:	}
LABELV $771
line 1673
;1673:	return qtrue;
CNSTI4 1
RETI4
LABELV $769
endproc BotAIShutdown 8 8
import ExitLevel
bss
export bot_interbreedwrite
align 4
LABELV bot_interbreedwrite
skip 272
export bot_interbreedcycle
align 4
LABELV bot_interbreedcycle
skip 272
export bot_interbreedbots
align 4
LABELV bot_interbreedbots
skip 272
export bot_interbreedchar
align 4
LABELV bot_interbreedchar
skip 272
export bot_developer
align 4
LABELV bot_developer
skip 272
export bot_testclusters
align 4
LABELV bot_testclusters
skip 272
export bot_testsolid
align 4
LABELV bot_testsolid
skip 272
export bot_report
align 4
LABELV bot_report
skip 272
export bot_pause
align 4
LABELV bot_pause
skip 272
export bot_saveroutingcache
align 4
LABELV bot_saveroutingcache
skip 272
export bot_memorydump
align 4
LABELV bot_memorydump
skip 272
export bot_thinktime
align 4
LABELV bot_thinktime
skip 272
export bot_interbreedmatchcount
align 4
LABELV bot_interbreedmatchcount
skip 4
export bot_interbreed
align 4
LABELV bot_interbreed
skip 4
export regularupdate_time
align 4
LABELV regularupdate_time
skip 4
export numbots
align 4
LABELV numbots
skip 4
export botstates
align 4
LABELV botstates
skip 256
import BotVoiceChat_Defend
import BotVoiceChatCommand
import BotDumpNodeSwitches
import BotResetNodeSwitches
import AINode_Battle_NBG
import AINode_Battle_Retreat
import AINode_Battle_Chase
import AINode_Battle_Fight
import AINode_Seek_LTG
import AINode_Seek_NBG
import AINode_Seek_ActivateEntity
import AINode_Stand
import AINode_Respawn
import AINode_Observer
import AINode_Intermission
import AIEnter_Battle_NBG
import AIEnter_Battle_Retreat
import AIEnter_Battle_Chase
import AIEnter_Battle_Fight
import AIEnter_Seek_Camp
import AIEnter_Seek_LTG
import AIEnter_Seek_NBG
import AIEnter_Seek_ActivateEntity
import AIEnter_Stand
import AIEnter_Respawn
import AIEnter_Observer
import AIEnter_Intermission
import BotPrintTeamGoal
import BotMatchMessage
import notleader
import BotChatTest
import BotValidChatPosition
import BotChatTime
import BotChat_Random
import BotChat_EnemySuicide
import BotChat_Kill
import BotChat_Death
import BotChat_HitNoKill
import BotChat_HitNoDeath
import BotChat_HitTalking
import BotChat_EndLevel
import BotChat_StartLevel
import BotChat_ExitGame
import BotChat_EnterGame
import ctf_blueflag
import ctf_redflag
import bot_challenge
import bot_testrchat
import bot_nochat
import bot_fastchat
import bot_rocketjump
import bot_grapple
import maxclients
import gametype
import BotMapScripts
import BotPointAreaNum
import ClientOnSameTeamFromName
import ClientFromName
import BotFindWayPoint
import BotCreateWayPoint
import BotAlternateRoute
import BotGetAlternateRouteGoal
import BotCTFRetreatGoals
import BotCTFSeekGoals
import BotRememberLastOrderedTask
import BotCTFCarryingFlag
import BotOppositeTeam
import BotTeam
import BotClearActivateGoalStack
import BotPopFromActivateGoalStack
import BotEnableActivateGoalAreas
import BotAIPredictObstacles
import BotAIBlocked
import BotCheckAttack
import BotAimAtEnemy
import BotEntityVisible
import BotRoamGoal
import BotFindEnemy
import InFieldOfVision
import BotVisibleTeamMatesAndEnemies
import BotEnemyFlagCarrierVisible
import BotTeamFlagCarrierVisible
import BotTeamFlagCarrier
import TeamPlayIsOn
import BotSameTeam
import BotAttackMove
import BotWantsToCamp
import BotHasPersistantPowerupAndWeapon
import BotCanAndWantsToRocketJump
import BotWantsToHelp
import BotWantsToChase
import BotWantsToRetreat
import BotFeelingBad
import BotAggression
import BotTeamGoals
import BotSetLastOrderedTask
import BotSynonymContext
import ClientSkin
import EasyClientName
import ClientName
import BotSetTeamStatus
import BotSetUserInfo
import EntityIsShooting
import EntityIsInvisible
import EntityIsDead
import BotInLavaOrSlime
import BotIntermission
import BotIsObserver
import BotIsDead
import BotBattleUseItems
import BotUpdateBattleInventory
import BotUpdateInventory
import BotSetupForMovement
import BotChooseWeapon
import BotFreeWaypoints
import BotDeathmatchAI
import BotShutdownDeathmatchAI
import BotSetupDeathmatchAI
export floattime
align 4
LABELV floattime
skip 4
import BotResetWeaponState
import BotFreeWeaponState
import BotAllocWeaponState
import BotLoadWeaponWeights
import BotGetWeaponInfo
import BotChooseBestFightWeapon
import BotShutdownWeaponAI
import BotSetupWeaponAI
import BotShutdownMoveAI
import BotSetupMoveAI
import BotSetBrushModelTypes
import BotAddAvoidSpot
import BotInitMoveState
import BotFreeMoveState
import BotAllocMoveState
import BotPredictVisiblePosition
import BotMovementViewTarget
import BotReachabilityArea
import BotResetLastAvoidReach
import BotResetAvoidReach
import BotMoveInDirection
import BotMoveToGoal
import BotResetMoveState
import BotShutdownGoalAI
import BotSetupGoalAI
import BotFreeGoalState
import BotAllocGoalState
import BotFreeItemWeights
import BotLoadItemWeights
import BotMutateGoalFuzzyLogic
import BotSaveGoalFuzzyLogic
import BotInterbreedGoalFuzzyLogic
import BotUpdateEntityItems
import BotInitLevelItems
import BotSetAvoidGoalTime
import BotAvoidGoalTime
import BotGetMapLocationGoal
import BotGetNextCampSpotGoal
import BotGetLevelItemGoal
import BotItemGoalInVisButNotVisible
import BotTouchingGoal
import BotChooseNBGItem
import BotChooseLTGItem
import BotGetSecondGoal
import BotGetTopGoal
import BotGoalName
import BotDumpGoalStack
import BotDumpAvoidGoals
import BotEmptyGoalStack
import BotPopGoal
import BotPushGoal
import BotRemoveFromAvoidGoals
import BotResetAvoidGoals
import BotResetGoalState
import GeneticParentsAndChildSelection
import BotSetChatName
import BotSetChatGender
import BotLoadChatFile
import BotReplaceSynonyms
import UnifyWhiteSpaces
import BotMatchVariable
import BotFindMatch
import StringContains
import BotGetChatMessage
import BotEnterChat
import BotChatLength
import BotReplyChat
import BotNumInitialChats
import BotInitialChat
import BotNumConsoleMessages
import BotNextConsoleMessage
import BotRemoveConsoleMessage
import BotQueueConsoleMessage
import BotFreeChatState
import BotAllocChatState
import BotShutdownChatAI
import BotSetupChatAI
import BotShutdownCharacters
import Characteristic_String
import Characteristic_BInteger
import Characteristic_Integer
import Characteristic_BFloat
import Characteristic_Float
import BotFreeCharacter
import BotLoadCharacter
import EA_Shutdown
import EA_Setup
import EA_ResetInput
import EA_GetInput
import EA_EndRegular
import EA_View
import EA_Move
import EA_DelayedJump
import EA_Jump
import EA_SelectWeapon
import EA_Use
import EA_Gesture
import EA_Talk
import EA_Respawn
import EA_Attack
import EA_MoveRight
import EA_MoveLeft
import EA_MoveBack
import EA_MoveForward
import EA_MoveDown
import EA_MoveUp
import EA_Walk
import EA_Crouch
import EA_Action
import EA_Command
import EA_SayTeam
import EA_Say
import GetBotLibAPI
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
import getTimeDiff
import G_WriteBans
import G_WriteGameSetings
import G_WriteTaskData
import G_WriteSessionData
import G_InitWorldSession
import G_ReadBans
import G_InitSessionData
import G_ReadGameSetings
import G_ReadTaskData
import G_ReadSessionData
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
LABELV $764
byte 1 50
byte 1 48
byte 1 0
align 1
LABELV $763
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 98
byte 1 114
byte 1 101
byte 1 101
byte 1 100
byte 1 99
byte 1 121
byte 1 99
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $762
byte 1 49
byte 1 48
byte 1 0
align 1
LABELV $761
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 98
byte 1 114
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $760
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 99
byte 1 108
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $759
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 115
byte 1 111
byte 1 108
byte 1 105
byte 1 100
byte 1 0
align 1
LABELV $758
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 114
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $757
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 112
byte 1 97
byte 1 117
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $756
byte 1 49
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $754
byte 1 99
byte 1 100
byte 1 100
byte 1 105
byte 1 114
byte 1 0
align 1
LABELV $751
byte 1 102
byte 1 115
byte 1 95
byte 1 99
byte 1 100
byte 1 112
byte 1 97
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $750
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 100
byte 1 105
byte 1 114
byte 1 0
align 1
LABELV $747
byte 1 102
byte 1 115
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $746
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 100
byte 1 105
byte 1 114
byte 1 0
align 1
LABELV $743
byte 1 102
byte 1 115
byte 1 95
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 112
byte 1 97
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $738
byte 1 97
byte 1 97
byte 1 115
byte 1 111
byte 1 112
byte 1 116
byte 1 105
byte 1 109
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $735
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 97
byte 1 97
byte 1 115
byte 1 111
byte 1 112
byte 1 116
byte 1 105
byte 1 109
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $734
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 119
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $731
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 119
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $730
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 114
byte 1 101
byte 1 97
byte 1 99
byte 1 104
byte 1 97
byte 1 98
byte 1 105
byte 1 108
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $727
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 114
byte 1 101
byte 1 97
byte 1 99
byte 1 104
byte 1 97
byte 1 98
byte 1 105
byte 1 108
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $726
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 99
byte 1 108
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $723
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 99
byte 1 108
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $720
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 118
byte 1 105
byte 1 115
byte 1 117
byte 1 97
byte 1 108
byte 1 105
byte 1 122
byte 1 101
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 112
byte 1 97
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $719
byte 1 110
byte 1 111
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $716
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 110
byte 1 111
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $715
byte 1 108
byte 1 111
byte 1 103
byte 1 0
align 1
LABELV $713
byte 1 98
byte 1 111
byte 1 116
byte 1 95
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
LABELV $708
byte 1 109
byte 1 97
byte 1 120
byte 1 95
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $705
byte 1 109
byte 1 97
byte 1 120
byte 1 95
byte 1 97
byte 1 97
byte 1 115
byte 1 108
byte 1 105
byte 1 110
byte 1 107
byte 1 115
byte 1 0
align 1
LABELV $702
byte 1 115
byte 1 118
byte 1 95
byte 1 109
byte 1 97
byte 1 112
byte 1 67
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 115
byte 1 117
byte 1 109
byte 1 0
align 1
LABELV $701
byte 1 109
byte 1 97
byte 1 120
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 105
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $700
byte 1 109
byte 1 97
byte 1 120
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $699
byte 1 56
byte 1 0
align 1
LABELV $696
byte 1 115
byte 1 118
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $621
byte 1 50
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $620
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 107
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $616
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 115
byte 1 97
byte 1 118
byte 1 101
byte 1 114
byte 1 111
byte 1 117
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 99
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 0
align 1
LABELV $615
byte 1 115
byte 1 97
byte 1 118
byte 1 101
byte 1 114
byte 1 111
byte 1 117
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 99
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 0
align 1
LABELV $611
byte 1 48
byte 1 0
align 1
LABELV $610
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 109
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 100
byte 1 117
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $609
byte 1 109
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 100
byte 1 117
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $578
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $551
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 105
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $536
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $533
byte 1 65
byte 1 65
byte 1 83
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 105
byte 1 110
byte 1 105
byte 1 116
byte 1 105
byte 1 97
byte 1 108
byte 1 105
byte 1 122
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $530
byte 1 66
byte 1 111
byte 1 116
byte 1 65
byte 1 73
byte 1 83
byte 1 101
byte 1 116
byte 1 117
byte 1 112
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 97
byte 1 108
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 117
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $523
byte 1 98
byte 1 111
byte 1 116
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
LABELV $522
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
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 0
align 1
LABELV $503
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 76
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 83
byte 1 104
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $500
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $497
byte 1 116
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $494
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $491
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $488
byte 1 99
byte 1 115
byte 1 0
align 1
LABELV $485
byte 1 99
byte 1 112
byte 1 32
byte 1 0
align 1
LABELV $477
byte 1 66
byte 1 111
byte 1 116
byte 1 65
byte 1 73
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 117
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $337
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 98
byte 1 114
byte 1 101
byte 1 101
byte 1 100
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $334
byte 1 97
byte 1 100
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 52
byte 1 32
byte 1 102
byte 1 114
byte 1 101
byte 1 101
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $328
byte 1 49
byte 1 0
align 1
LABELV $327
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 114
byte 1 101
byte 1 108
byte 1 111
byte 1 97
byte 1 100
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
LABELV $320
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $319
byte 1 103
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $312
byte 1 0
align 1
LABELV $311
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 98
byte 1 114
byte 1 101
byte 1 101
byte 1 100
byte 1 119
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $262
byte 1 108
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 99
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 97
byte 1 92
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $259
byte 1 114
byte 1 111
byte 1 97
byte 1 109
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $257
byte 1 104
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $255
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $253
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $251
byte 1 114
byte 1 117
byte 1 115
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $249
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $247
byte 1 112
byte 1 97
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $245
byte 1 99
byte 1 97
byte 1 109
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $243
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $241
byte 1 103
byte 1 101
byte 1 116
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $239
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $237
byte 1 97
byte 1 99
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 97
byte 1 110
byte 1 121
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $235
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $230
byte 1 70
byte 1 32
byte 1 0
align 1
LABELV $209
byte 1 94
byte 1 52
byte 1 66
byte 1 76
byte 1 85
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $207
byte 1 116
byte 1 0
align 1
LABELV $203
byte 1 110
byte 1 0
align 1
LABELV $193
byte 1 94
byte 1 49
byte 1 82
byte 1 69
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $189
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 114
byte 1 111
byte 1 97
byte 1 109
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $188
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 104
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $186
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $184
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $182
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 114
byte 1 117
byte 1 115
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $180
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $178
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 112
byte 1 97
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $176
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 99
byte 1 97
byte 1 109
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $174
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $172
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $170
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $168
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 97
byte 1 99
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 97
byte 1 110
byte 1 121
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $166
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $161
byte 1 94
byte 1 52
byte 1 70
byte 1 32
byte 1 0
align 1
LABELV $160
byte 1 94
byte 1 49
byte 1 70
byte 1 32
byte 1 0
align 1
LABELV $153
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $152
byte 1 32
byte 1 0
align 1
LABELV $151
byte 1 76
byte 1 0
align 1
LABELV $146
byte 1 13
byte 1 97
byte 1 114
byte 1 101
byte 1 97
byte 1 32
byte 1 37
byte 1 100
byte 1 44
byte 1 32
byte 1 99
byte 1 108
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $145
byte 1 13
byte 1 94
byte 1 49
byte 1 83
byte 1 111
byte 1 108
byte 1 105
byte 1 100
byte 1 33
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $137
byte 1 13
byte 1 94
byte 1 49
byte 1 83
byte 1 79
byte 1 76
byte 1 73
byte 1 68
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 97
byte 1 0
align 1
LABELV $136
byte 1 13
byte 1 101
byte 1 109
byte 1 116
byte 1 112
byte 1 121
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 97
byte 1 0
align 1
LABELV $82
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $81
byte 1 94
byte 1 49
byte 1 69
byte 1 120
byte 1 105
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $79
byte 1 94
byte 1 49
byte 1 70
byte 1 97
byte 1 116
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $77
byte 1 94
byte 1 49
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $75
byte 1 94
byte 1 51
byte 1 87
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $73
byte 1 37
byte 1 115
byte 1 0
