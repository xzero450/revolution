bss
align 4
LABELV $69
skip 4
export BotNumActivePlayers
code
proc BotNumActivePlayers 1056 12
file "../ai_chat.c"
line 48
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:
;4:/*****************************************************************************
;5: * name:		ai_chat.c
;6: *
;7: * desc:		Quake3 bot AI
;8: *
;9: * $Archive: /MissionPack/code/game/ai_chat.c $
;10: *
;11: *****************************************************************************/
;12:
;13:#include "g_local.h"
;14:#include "botlib.h"
;15:#include "be_aas.h"
;16:#include "be_ea.h"
;17:#include "be_ai_char.h"
;18:#include "be_ai_chat.h"
;19:#include "be_ai_gen.h"
;20:#include "be_ai_goal.h"
;21:#include "be_ai_move.h"
;22:#include "be_ai_weap.h"
;23://
;24:#include "ai_main.h"
;25:#include "ai_dmq3.h"
;26:#include "ai_chat.h"
;27:#include "ai_cmd.h"
;28:#include "ai_dmnet.h"
;29://
;30:#include "chars.h"				//characteristics
;31:#include "inv.h"				//indexes into the inventory
;32:#include "syn.h"				//synonyms
;33:#include "match.h"				//string matching types and vars
;34:
;35:// for the voice chats
;36:#ifdef MISSIONPACK // bk001205
;37:#include "../../ui/menudef.h"
;38:#endif
;39:
;40:#define TIME_BETWEENCHATTING	25
;41:
;42:
;43:/*
;44:==================
;45:BotNumActivePlayers
;46:==================
;47:*/
;48:int BotNumActivePlayers(void) {
line 53
;49:	int i, num;
;50:	char buf[MAX_INFO_STRING];
;51:	static int maxclients;
;52:
;53:	if (!maxclients)
ADDRGP4 $69
INDIRI4
CNSTI4 0
NEI4 $70
line 54
;54:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $72
ARGP4
ADDRLP4 1032
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $69
ADDRLP4 1032
INDIRI4
ASGNI4
LABELV $70
line 56
;55:
;56:	num = 0;
ADDRLP4 1028
CNSTI4 0
ASGNI4
line 57
;57:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 1024
CNSTI4 0
ASGNI4
ADDRGP4 $76
JUMPV
LABELV $73
line 58
;58:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
ADDRLP4 1024
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 60
;59:		//if no config string or no name
;60:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 0
ARGP4
ADDRLP4 1036
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
EQI4 $80
ADDRLP4 0
ARGP4
ADDRGP4 $79
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
NEI4 $77
LABELV $80
ADDRGP4 $74
JUMPV
LABELV $77
line 62
;61:		//skip spectators
;62:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
ADDRLP4 0
ARGP4
ADDRGP4 $83
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
CNSTI4 3
NEI4 $81
ADDRGP4 $74
JUMPV
LABELV $81
line 64
;63:		//
;64:		num++;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 65
;65:	}
LABELV $74
line 57
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $76
ADDRLP4 1024
INDIRI4
ADDRGP4 $69
INDIRI4
GEI4 $84
ADDRLP4 1024
INDIRI4
CNSTI4 64
LTI4 $73
LABELV $84
line 66
;66:	return num;
ADDRLP4 1028
INDIRI4
RETI4
LABELV $68
endproc BotNumActivePlayers 1056 12
bss
align 4
LABELV $86
skip 4
export BotIsFirstInRankings
code
proc BotIsFirstInRankings 1524 12
line 74
;67:}
;68:
;69:/*
;70:==================
;71:BotIsFirstInRankings
;72:==================
;73:*/
;74:int BotIsFirstInRankings(bot_state_t *bs) {
line 80
;75:	int i, score;
;76:	char buf[MAX_INFO_STRING];
;77:	static int maxclients;
;78:	playerState_t ps;
;79:
;80:	if (!maxclients)
ADDRGP4 $86
INDIRI4
CNSTI4 0
NEI4 $87
line 81
;81:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $72
ARGP4
ADDRLP4 1500
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $86
ADDRLP4 1500
INDIRI4
ASGNI4
LABELV $87
line 83
;82:
;83:	score = bs->cur_ps.persistant[PERS_SCORE];
ADDRLP4 1496
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRI4
ASGNI4
line 84
;84:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $92
JUMPV
LABELV $89
line 85
;85:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
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
line 87
;86:		//if no config string or no name
;87:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 4
ARGP4
ADDRLP4 1504
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1504
INDIRI4
CNSTI4 0
EQI4 $95
ADDRLP4 4
ARGP4
ADDRGP4 $79
ARGP4
ADDRLP4 1508
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1508
INDIRP4
ARGP4
ADDRLP4 1512
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1512
INDIRI4
CNSTI4 0
NEI4 $93
LABELV $95
ADDRGP4 $90
JUMPV
LABELV $93
line 89
;88:		//skip spectators
;89:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
ADDRLP4 4
ARGP4
ADDRGP4 $83
ARGP4
ADDRLP4 1516
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1516
INDIRP4
ARGP4
ADDRLP4 1520
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1520
INDIRI4
CNSTI4 3
NEI4 $96
ADDRGP4 $90
JUMPV
LABELV $96
line 91
;90:		//
;91:		BotAI_GetClientState(i, &ps);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1028
ARGP4
ADDRGP4 BotAI_GetClientState
CALLI4
pop
line 92
;92:		if (score < ps.persistant[PERS_SCORE]) return qfalse;
ADDRLP4 1496
INDIRI4
ADDRLP4 1028+248
INDIRI4
GEI4 $98
CNSTI4 0
RETI4
ADDRGP4 $85
JUMPV
LABELV $98
line 93
;93:	}
LABELV $90
line 84
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $92
ADDRLP4 0
INDIRI4
ADDRGP4 $86
INDIRI4
GEI4 $101
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $89
LABELV $101
line 94
;94:	return qtrue;
CNSTI4 1
RETI4
LABELV $85
endproc BotIsFirstInRankings 1524 12
bss
align 4
LABELV $103
skip 4
export BotIsLastInRankings
code
proc BotIsLastInRankings 1524 12
line 102
;95:}
;96:
;97:/*
;98:==================
;99:BotIsLastInRankings
;100:==================
;101:*/
;102:int BotIsLastInRankings(bot_state_t *bs) {
line 108
;103:	int i, score;
;104:	char buf[MAX_INFO_STRING];
;105:	static int maxclients;
;106:	playerState_t ps;
;107:
;108:	if (!maxclients)
ADDRGP4 $103
INDIRI4
CNSTI4 0
NEI4 $104
line 109
;109:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $72
ARGP4
ADDRLP4 1500
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $103
ADDRLP4 1500
INDIRI4
ASGNI4
LABELV $104
line 111
;110:
;111:	score = bs->cur_ps.persistant[PERS_SCORE];
ADDRLP4 1496
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRI4
ASGNI4
line 112
;112:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $109
JUMPV
LABELV $106
line 113
;113:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
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
line 115
;114:		//if no config string or no name
;115:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 4
ARGP4
ADDRLP4 1504
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1504
INDIRI4
CNSTI4 0
EQI4 $112
ADDRLP4 4
ARGP4
ADDRGP4 $79
ARGP4
ADDRLP4 1508
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1508
INDIRP4
ARGP4
ADDRLP4 1512
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1512
INDIRI4
CNSTI4 0
NEI4 $110
LABELV $112
ADDRGP4 $107
JUMPV
LABELV $110
line 117
;116:		//skip spectators
;117:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
ADDRLP4 4
ARGP4
ADDRGP4 $83
ARGP4
ADDRLP4 1516
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1516
INDIRP4
ARGP4
ADDRLP4 1520
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1520
INDIRI4
CNSTI4 3
NEI4 $113
ADDRGP4 $107
JUMPV
LABELV $113
line 119
;118:		//
;119:		BotAI_GetClientState(i, &ps);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1028
ARGP4
ADDRGP4 BotAI_GetClientState
CALLI4
pop
line 120
;120:		if (score > ps.persistant[PERS_SCORE]) return qfalse;
ADDRLP4 1496
INDIRI4
ADDRLP4 1028+248
INDIRI4
LEI4 $115
CNSTI4 0
RETI4
ADDRGP4 $102
JUMPV
LABELV $115
line 121
;121:	}
LABELV $107
line 112
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $109
ADDRLP4 0
INDIRI4
ADDRGP4 $103
INDIRI4
GEI4 $118
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $106
LABELV $118
line 122
;122:	return qtrue;
CNSTI4 1
RETI4
LABELV $102
endproc BotIsLastInRankings 1524 12
bss
align 1
LABELV $120
skip 32
align 4
LABELV $121
skip 4
export BotFirstClientInRankings
code
proc BotFirstClientInRankings 1528 12
line 130
;123:}
;124:
;125:/*
;126:==================
;127:BotFirstClientInRankings
;128:==================
;129:*/
;130:char *BotFirstClientInRankings(void) {
line 137
;131:	int i, bestscore, bestclient;
;132:	char buf[MAX_INFO_STRING];
;133:	static char name[32];
;134:	static int maxclients;
;135:	playerState_t ps;
;136:
;137:	if (!maxclients)
ADDRGP4 $121
INDIRI4
CNSTI4 0
NEI4 $122
line 138
;138:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $72
ARGP4
ADDRLP4 1504
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $121
ADDRLP4 1504
INDIRI4
ASGNI4
LABELV $122
line 140
;139:
;140:	bestscore = -999999;
ADDRLP4 1496
CNSTI4 -999999
ASGNI4
line 141
;141:	bestclient = 0;
ADDRLP4 1500
CNSTI4 0
ASGNI4
line 142
;142:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $127
JUMPV
LABELV $124
line 143
;143:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
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
line 145
;144:		//if no config string or no name
;145:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 4
ARGP4
ADDRLP4 1508
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1508
INDIRI4
CNSTI4 0
EQI4 $130
ADDRLP4 4
ARGP4
ADDRGP4 $79
ARGP4
ADDRLP4 1512
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1512
INDIRP4
ARGP4
ADDRLP4 1516
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1516
INDIRI4
CNSTI4 0
NEI4 $128
LABELV $130
ADDRGP4 $125
JUMPV
LABELV $128
line 147
;146:		//skip spectators
;147:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
ADDRLP4 4
ARGP4
ADDRGP4 $83
ARGP4
ADDRLP4 1520
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1520
INDIRP4
ARGP4
ADDRLP4 1524
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1524
INDIRI4
CNSTI4 3
NEI4 $131
ADDRGP4 $125
JUMPV
LABELV $131
line 149
;148:		//
;149:		BotAI_GetClientState(i, &ps);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1028
ARGP4
ADDRGP4 BotAI_GetClientState
CALLI4
pop
line 150
;150:		if (ps.persistant[PERS_SCORE] > bestscore) {
ADDRLP4 1028+248
INDIRI4
ADDRLP4 1496
INDIRI4
LEI4 $133
line 151
;151:			bestscore = ps.persistant[PERS_SCORE];
ADDRLP4 1496
ADDRLP4 1028+248
INDIRI4
ASGNI4
line 152
;152:			bestclient = i;
ADDRLP4 1500
ADDRLP4 0
INDIRI4
ASGNI4
line 153
;153:		}
LABELV $133
line 154
;154:	}
LABELV $125
line 142
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $127
ADDRLP4 0
INDIRI4
ADDRGP4 $121
INDIRI4
GEI4 $137
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $124
LABELV $137
line 155
;155:	EasyClientName(bestclient, name, 32);
ADDRLP4 1500
INDIRI4
ARGI4
ADDRGP4 $120
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 156
;156:	return name;
ADDRGP4 $120
RETP4
LABELV $119
endproc BotFirstClientInRankings 1528 12
bss
align 1
LABELV $139
skip 32
align 4
LABELV $140
skip 4
export BotLastClientInRankings
code
proc BotLastClientInRankings 1528 12
line 164
;157:}
;158:
;159:/*
;160:==================
;161:BotLastClientInRankings
;162:==================
;163:*/
;164:char *BotLastClientInRankings(void) {
line 171
;165:	int i, worstscore, bestclient;
;166:	char buf[MAX_INFO_STRING];
;167:	static char name[32];
;168:	static int maxclients;
;169:	playerState_t ps;
;170:
;171:	if (!maxclients)
ADDRGP4 $140
INDIRI4
CNSTI4 0
NEI4 $141
line 172
;172:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $72
ARGP4
ADDRLP4 1504
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $140
ADDRLP4 1504
INDIRI4
ASGNI4
LABELV $141
line 174
;173:
;174:	worstscore = 999999;
ADDRLP4 1496
CNSTI4 999999
ASGNI4
line 175
;175:	bestclient = 0;
ADDRLP4 1500
CNSTI4 0
ASGNI4
line 176
;176:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $146
JUMPV
LABELV $143
line 177
;177:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
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
line 179
;178:		//if no config string or no name
;179:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 4
ARGP4
ADDRLP4 1508
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1508
INDIRI4
CNSTI4 0
EQI4 $149
ADDRLP4 4
ARGP4
ADDRGP4 $79
ARGP4
ADDRLP4 1512
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1512
INDIRP4
ARGP4
ADDRLP4 1516
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1516
INDIRI4
CNSTI4 0
NEI4 $147
LABELV $149
ADDRGP4 $144
JUMPV
LABELV $147
line 181
;180:		//skip spectators
;181:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
ADDRLP4 4
ARGP4
ADDRGP4 $83
ARGP4
ADDRLP4 1520
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1520
INDIRP4
ARGP4
ADDRLP4 1524
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1524
INDIRI4
CNSTI4 3
NEI4 $150
ADDRGP4 $144
JUMPV
LABELV $150
line 183
;182:		//
;183:		BotAI_GetClientState(i, &ps);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1028
ARGP4
ADDRGP4 BotAI_GetClientState
CALLI4
pop
line 184
;184:		if (ps.persistant[PERS_SCORE] < worstscore) {
ADDRLP4 1028+248
INDIRI4
ADDRLP4 1496
INDIRI4
GEI4 $152
line 185
;185:			worstscore = ps.persistant[PERS_SCORE];
ADDRLP4 1496
ADDRLP4 1028+248
INDIRI4
ASGNI4
line 186
;186:			bestclient = i;
ADDRLP4 1500
ADDRLP4 0
INDIRI4
ASGNI4
line 187
;187:		}
LABELV $152
line 188
;188:	}
LABELV $144
line 176
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $146
ADDRLP4 0
INDIRI4
ADDRGP4 $140
INDIRI4
GEI4 $156
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $143
LABELV $156
line 189
;189:	EasyClientName(bestclient, name, 32);
ADDRLP4 1500
INDIRI4
ARGI4
ADDRGP4 $139
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 190
;190:	return name;
ADDRGP4 $139
RETP4
LABELV $138
endproc BotLastClientInRankings 1528 12
bss
align 4
LABELV $158
skip 4
align 1
LABELV $159
skip 32
export BotRandomOpponentName
code
proc BotRandomOpponentName 1320 12
line 198
;191:}
;192:
;193:/*
;194:==================
;195:BotRandomOpponentName
;196:==================
;197:*/
;198:char *BotRandomOpponentName(bot_state_t *bs) {
line 205
;199:	int i, count;
;200:	char buf[MAX_INFO_STRING];
;201:	int opponents[MAX_CLIENTS], numopponents;
;202:	static int maxclients;
;203:	static char name[32];
;204:
;205:	if (!maxclients)
ADDRGP4 $158
INDIRI4
CNSTI4 0
NEI4 $160
line 206
;206:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $72
ARGP4
ADDRLP4 1292
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $158
ADDRLP4 1292
INDIRI4
ASGNI4
LABELV $160
line 208
;207:
;208:	numopponents = 0;
ADDRLP4 1028
CNSTI4 0
ASGNI4
line 209
;209:	opponents[0] = 0;
ADDRLP4 1036
CNSTI4 0
ASGNI4
line 210
;210:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $165
JUMPV
LABELV $162
line 211
;211:		if (i == bs->client) continue;
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $166
ADDRGP4 $163
JUMPV
LABELV $166
line 213
;212:		//
;213:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
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
line 215
;214:		//if no config string or no name
;215:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 4
ARGP4
ADDRLP4 1296
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1296
INDIRI4
CNSTI4 0
EQI4 $170
ADDRLP4 4
ARGP4
ADDRGP4 $79
ARGP4
ADDRLP4 1300
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1300
INDIRP4
ARGP4
ADDRLP4 1304
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1304
INDIRI4
CNSTI4 0
NEI4 $168
LABELV $170
ADDRGP4 $163
JUMPV
LABELV $168
line 217
;216:		//skip spectators
;217:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
ADDRLP4 4
ARGP4
ADDRGP4 $83
ARGP4
ADDRLP4 1308
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1308
INDIRP4
ARGP4
ADDRLP4 1312
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1312
INDIRI4
CNSTI4 3
NEI4 $171
ADDRGP4 $163
JUMPV
LABELV $171
line 219
;218:		//skip team mates
;219:		if (BotSameTeam(bs, i)) continue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1316
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1316
INDIRI4
CNSTI4 0
EQI4 $173
ADDRGP4 $163
JUMPV
LABELV $173
line 221
;220:		//
;221:		opponents[numopponents] = i;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1036
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 222
;222:		numopponents++;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 223
;223:	}
LABELV $163
line 210
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $165
ADDRLP4 0
INDIRI4
ADDRGP4 $158
INDIRI4
GEI4 $175
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $162
LABELV $175
line 224
;224:	count = random() * numopponents;
ADDRLP4 1300
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1032
ADDRLP4 1300
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 1028
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 225
;225:	for (i = 0; i < numopponents; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $179
JUMPV
LABELV $176
line 226
;226:		count--;
ADDRLP4 1032
ADDRLP4 1032
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 227
;227:		if (count <= 0) {
ADDRLP4 1032
INDIRI4
CNSTI4 0
GTI4 $180
line 228
;228:			EasyClientName(opponents[i], name, sizeof(name));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1036
ADDP4
INDIRI4
ARGI4
ADDRGP4 $159
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 229
;229:			return name;
ADDRGP4 $159
RETP4
ADDRGP4 $157
JUMPV
LABELV $180
line 231
;230:		}
;231:	}
LABELV $177
line 225
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $179
ADDRLP4 0
INDIRI4
ADDRLP4 1028
INDIRI4
LTI4 $176
line 232
;232:	EasyClientName(opponents[0], name, sizeof(name));
ADDRLP4 1036
INDIRI4
ARGI4
ADDRGP4 $159
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 233
;233:	return name;
ADDRGP4 $159
RETP4
LABELV $157
endproc BotRandomOpponentName 1320 12
bss
align 1
LABELV $183
skip 128
export BotMapTitle
code
proc BotMapTitle 1028 12
line 242
;234:}
;235:
;236:/*
;237:==================
;238:BotMapTitle
;239:==================
;240:*/
;241:
;242:char *BotMapTitle(void) {
line 246
;243:	char info[1024];
;244:	static char mapname[128];
;245:
;246:	trap_GetServerinfo(info, sizeof(info));
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetServerinfo
CALLV
pop
line 248
;247:
;248:	strncpy(mapname, Info_ValueForKey( info, "mapname" ), sizeof(mapname)-1);
ADDRLP4 0
ARGP4
ADDRGP4 $184
ARGP4
ADDRLP4 1024
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $183
ARGP4
ADDRLP4 1024
INDIRP4
ARGP4
CNSTI4 127
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 249
;249:	mapname[sizeof(mapname)-1] = '\0';
ADDRGP4 $183+127
CNSTI1 0
ASGNI1
line 251
;250:
;251:	return mapname;
ADDRGP4 $183
RETP4
LABELV $182
endproc BotMapTitle 1028 12
export BotWeaponNameForMeansOfDeath
proc BotWeaponNameForMeansOfDeath 4 0
line 261
;252:}
;253:
;254:
;255:/*
;256:==================
;257:BotWeaponNameForMeansOfDeath
;258:==================
;259:*/
;260:
;261:char *BotWeaponNameForMeansOfDeath(int mod) {
line 262
;262:	switch(mod) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $187
ADDRLP4 0
INDIRI4
CNSTI4 23
GTI4 $187
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $210-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $210
address $189
address $191
address $193
address $195
address $195
address $197
address $197
address $199
address $199
address $201
address $203
address $205
address $205
address $187
address $187
address $187
address $187
address $187
address $187
address $187
address $187
address $187
address $207
code
LABELV $189
line 263
;263:		case MOD_SHOTGUN: return "Shotgun";
ADDRGP4 $190
RETP4
ADDRGP4 $186
JUMPV
LABELV $191
line 264
;264:		case MOD_GAUNTLET: return "Gauntlet";
ADDRGP4 $192
RETP4
ADDRGP4 $186
JUMPV
LABELV $193
line 265
;265:		case MOD_MACHINEGUN: return "Machinegun";
ADDRGP4 $194
RETP4
ADDRGP4 $186
JUMPV
LABELV $195
line 267
;266:		case MOD_GRENADE:
;267:		case MOD_GRENADE_SPLASH: return "Grenade Launcher";
ADDRGP4 $196
RETP4
ADDRGP4 $186
JUMPV
LABELV $197
line 269
;268:		case MOD_ROCKET:
;269:		case MOD_ROCKET_SPLASH: return "Rocket Launcher";
ADDRGP4 $198
RETP4
ADDRGP4 $186
JUMPV
LABELV $199
line 271
;270:		case MOD_PLASMA:
;271:		case MOD_PLASMA_SPLASH: return "Plasmagun";
ADDRGP4 $200
RETP4
ADDRGP4 $186
JUMPV
LABELV $201
line 272
;272:		case MOD_RAILGUN: return "Railgun";
ADDRGP4 $202
RETP4
ADDRGP4 $186
JUMPV
LABELV $203
line 273
;273:		case MOD_LIGHTNING: return "Lightning Gun";
ADDRGP4 $204
RETP4
ADDRGP4 $186
JUMPV
LABELV $205
line 275
;274:		case MOD_BFG:
;275:		case MOD_BFG_SPLASH: return "BFG10K";
ADDRGP4 $206
RETP4
ADDRGP4 $186
JUMPV
LABELV $207
line 283
;276:#ifdef MISSIONPACK
;277:		case MOD_NAIL: return "Nailgun";
;278:		case MOD_CHAINGUN: return "Chaingun";
;279:		case MOD_PROXIMITY_MINE: return "Proximity Launcher";
;280:		case MOD_KAMIKAZE: return "Kamikaze";
;281:		case MOD_JUICED: return "Prox mine";
;282:#endif
;283:		case MOD_GRAPPLE: return "Grapple";
ADDRGP4 $208
RETP4
ADDRGP4 $186
JUMPV
LABELV $187
line 284
;284:		default: return "[unknown weapon]";
ADDRGP4 $209
RETP4
LABELV $186
endproc BotWeaponNameForMeansOfDeath 4 0
export BotRandomWeaponName
proc BotRandomWeaponName 12 0
line 293
;285:	}
;286:}
;287:
;288:/*
;289:==================
;290:BotRandomWeaponName
;291:==================
;292:*/
;293:char *BotRandomWeaponName(void) {
line 299
;294:	int rnd;
;295:
;296:#ifdef MISSIONPACK
;297:	rnd = random() * 11.9;
;298:#else
;299:	rnd = random() * 8.9;
ADDRLP4 4
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
CNSTF4 1091462758
ADDRLP4 4
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
CVFI4 4
ASGNI4
line 301
;300:#endif
;301:	switch(rnd) {
ADDRLP4 8
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $213
ADDRLP4 8
INDIRI4
CNSTI4 7
GTI4 $213
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $223
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $223
address $215
address $216
address $217
address $218
address $219
address $220
address $221
address $222
code
LABELV $215
line 302
;302:		case 0: return "Gauntlet";
ADDRGP4 $192
RETP4
ADDRGP4 $212
JUMPV
LABELV $216
line 303
;303:		case 1: return "Shotgun";
ADDRGP4 $190
RETP4
ADDRGP4 $212
JUMPV
LABELV $217
line 304
;304:		case 2: return "Machinegun";
ADDRGP4 $194
RETP4
ADDRGP4 $212
JUMPV
LABELV $218
line 305
;305:		case 3: return "Grenade Launcher";
ADDRGP4 $196
RETP4
ADDRGP4 $212
JUMPV
LABELV $219
line 306
;306:		case 4: return "Rocket Launcher";
ADDRGP4 $198
RETP4
ADDRGP4 $212
JUMPV
LABELV $220
line 307
;307:		case 5: return "Plasmagun";
ADDRGP4 $200
RETP4
ADDRGP4 $212
JUMPV
LABELV $221
line 308
;308:		case 6: return "Railgun";
ADDRGP4 $202
RETP4
ADDRGP4 $212
JUMPV
LABELV $222
line 309
;309:		case 7: return "Lightning Gun";
ADDRGP4 $204
RETP4
ADDRGP4 $212
JUMPV
LABELV $213
line 315
;310:#ifdef MISSIONPACK
;311:		case 8: return "Nailgun";
;312:		case 9: return "Chaingun";
;313:		case 10: return "Proximity Launcher";
;314:#endif
;315:		default: return "BFG10K";
ADDRGP4 $206
RETP4
LABELV $212
endproc BotRandomWeaponName 12 0
export BotVisibleEnemies
proc BotVisibleEnemies 172 20
line 324
;316:	}
;317:}
;318:
;319:/*
;320:==================
;321:BotVisibleEnemies
;322:==================
;323:*/
;324:int BotVisibleEnemies(bot_state_t *bs) {
line 329
;325:	float vis;
;326:	int i;
;327:	aas_entityinfo_t entinfo;
;328:
;329:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $225
line 331
;330:
;331:		if (i == bs->client) continue;
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $229
ADDRGP4 $226
JUMPV
LABELV $229
line 333
;332:		//
;333:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 335
;334:		//
;335:		if (!entinfo.valid) continue;
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $231
ADDRGP4 $226
JUMPV
LABELV $231
line 337
;336:		//if the enemy isn't dead and the enemy isn't the bot self
;337:		if (EntityIsDead(&entinfo) || entinfo.number == bs->entitynum) continue;
ADDRLP4 4
ARGP4
ADDRLP4 148
ADDRGP4 EntityIsDead
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $236
ADDRLP4 4+20
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
NEI4 $233
LABELV $236
ADDRGP4 $226
JUMPV
LABELV $233
line 339
;338:		//if the enemy is invisible and not shooting
;339:		if (EntityIsInvisible(&entinfo) && !EntityIsShooting(&entinfo)) {
ADDRLP4 4
ARGP4
ADDRLP4 152
ADDRGP4 EntityIsInvisible
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $237
ADDRLP4 4
ARGP4
ADDRLP4 156
ADDRGP4 EntityIsShooting
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
NEI4 $237
line 340
;340:			continue;
ADDRGP4 $226
JUMPV
LABELV $237
line 343
;341:		}
;342:		//if on the same team
;343:		if (BotSameTeam(bs, i)) continue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 160
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
EQI4 $239
ADDRGP4 $226
JUMPV
LABELV $239
line 345
;344:		//check if the enemy is visible
;345:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
ADDRLP4 164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 164
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 164
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 164
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 168
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 144
ADDRLP4 168
INDIRF4
ASGNF4
line 346
;346:		if (vis > 0) return qtrue;
ADDRLP4 144
INDIRF4
CNSTF4 0
LEF4 $241
CNSTI4 1
RETI4
ADDRGP4 $224
JUMPV
LABELV $241
line 347
;347:	}
LABELV $226
line 329
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $225
line 348
;348:	return qfalse;
CNSTI4 0
RETI4
LABELV $224
endproc BotVisibleEnemies 172 20
export BotValidChatPosition
proc BotValidChatPosition 164 28
line 356
;349:}
;350:
;351:/*
;352:==================
;353:BotValidChatPosition
;354:==================
;355:*/
;356:int BotValidChatPosition(bot_state_t *bs) {
line 361
;357:	vec3_t point, start, end, mins, maxs;
;358:	bsp_trace_t trace;
;359:
;360:	//if the bot is dead all positions are valid
;361:	if (BotIsDead(bs)) return qtrue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 144
ADDRGP4 BotIsDead
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $244
CNSTI4 1
RETI4
ADDRGP4 $243
JUMPV
LABELV $244
line 363
;362:	//never start chatting with a powerup
;363:	if (bs->inventory[INVENTORY_QUAD] ||
ADDRLP4 148
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 152
CNSTI4 0
ASGNI4
ADDRLP4 148
INDIRP4
CNSTI4 5092
ADDP4
INDIRI4
ADDRLP4 152
INDIRI4
NEI4 $251
ADDRLP4 148
INDIRP4
CNSTI4 5100
ADDP4
INDIRI4
ADDRLP4 152
INDIRI4
NEI4 $251
ADDRLP4 148
INDIRP4
CNSTI4 5104
ADDP4
INDIRI4
ADDRLP4 152
INDIRI4
NEI4 $251
ADDRLP4 148
INDIRP4
CNSTI4 5108
ADDP4
INDIRI4
ADDRLP4 152
INDIRI4
NEI4 $251
ADDRLP4 148
INDIRP4
CNSTI4 5112
ADDP4
INDIRI4
ADDRLP4 152
INDIRI4
EQI4 $246
LABELV $251
line 367
;364:		bs->inventory[INVENTORY_HASTE] ||
;365:		bs->inventory[INVENTORY_INVISIBILITY] ||
;366:		bs->inventory[INVENTORY_REGEN] ||
;367:		bs->inventory[INVENTORY_FLIGHT]) return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $243
JUMPV
LABELV $246
line 371
;368:	//must be on the ground
;369:	//if (bs->cur_ps.groundEntityNum != ENTITYNUM_NONE) return qfalse;
;370:	//do not chat if in lava or slime
;371:	VectorCopy(bs->origin, point);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 372
;372:	point[2] -= 24;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1103101952
SUBF4
ASGNF4
line 373
;373:	if (trap_PointContents(point,bs->entitynum) & (CONTENTS_LAVA|CONTENTS_SLIME)) return qfalse;
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 156
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 24
BANDI4
CNSTI4 0
EQI4 $253
CNSTI4 0
RETI4
ADDRGP4 $243
JUMPV
LABELV $253
line 375
;374:	//do not chat if under water
;375:	VectorCopy(bs->origin, point);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 376
;376:	point[2] += 32;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 377
;377:	if (trap_PointContents(point,bs->entitynum) & MASK_WATER) return qfalse;
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 160
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $256
CNSTI4 0
RETI4
ADDRGP4 $243
JUMPV
LABELV $256
line 379
;378:	//must be standing on the world entity
;379:	VectorCopy(bs->origin, start);
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 380
;380:	VectorCopy(bs->origin, end);
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 381
;381:	start[2] += 1;
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 382
;382:	end[2] -= 10;
ADDRLP4 24+8
ADDRLP4 24+8
INDIRF4
CNSTF4 1092616192
SUBF4
ASGNF4
line 383
;383:	trap_AAS_PresenceTypeBoundingBox(PRESENCE_CROUCH, mins, maxs);
CNSTI4 4
ARGI4
ADDRLP4 36
ARGP4
ADDRLP4 48
ARGP4
ADDRGP4 trap_AAS_PresenceTypeBoundingBox
CALLV
pop
line 384
;384:	BotAI_Trace(&trace, start, mins, maxs, end, bs->client, MASK_SOLID);
ADDRLP4 60
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 48
ARGP4
ADDRLP4 24
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 385
;385:	if (trace.ent != ENTITYNUM_WORLD) return qfalse;
ADDRLP4 60+80
INDIRI4
CNSTI4 1022
EQI4 $260
CNSTI4 0
RETI4
ADDRGP4 $243
JUMPV
LABELV $260
line 387
;386:	//the bot is in a position where it can chat
;387:	return qtrue;
CNSTI4 1
RETI4
LABELV $243
endproc BotValidChatPosition 164 28
export BotChat_EnterGame
proc BotChat_EnterGame 68 32
line 395
;388:}
;389:
;390:/*
;391:==================
;392:BotChat_EnterGame
;393:==================
;394:*/
;395:int BotChat_EnterGame(bot_state_t *bs) {
line 399
;396:	char name[32];
;397:	float rnd;
;398:
;399:	if ( bot_nochat.integer == 1 ) {
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 1
NEI4 $264
line 400
;400:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $263
JUMPV
LABELV $264
line 402
;401:	}
;402:	if (bs->lastchat_time > FloatTime() - TIME_BETWEENCHATTING) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1103626240
SUBF4
LEF4 $267
CNSTI4 0
RETI4
ADDRGP4 $263
JUMPV
LABELV $267
line 404
;403:	//don't chat in teamplay
;404:	if (TeamPlayIsOn()) return qfalse;
ADDRLP4 36
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $269
CNSTI4 0
RETI4
ADDRGP4 $263
JUMPV
LABELV $269
line 406
;405:	// don't chat in tournament mode
;406:	if (gametype == GT_TOURNAMENT) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 1
NEI4 $271
CNSTI4 0
RETI4
ADDRGP4 $263
JUMPV
LABELV $271
line 407
;407:	rnd = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_ENTEREXITGAME, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 27
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 40
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 40
INDIRF4
ASGNF4
line 408
;408:	if (!bot_fastchat.integer) {
ADDRGP4 bot_fastchat+12
INDIRI4
CNSTI4 0
NEI4 $273
line 409
;409:		if (random() > rnd) return qfalse;
ADDRLP4 44
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 0
INDIRF4
LEF4 $276
CNSTI4 0
RETI4
ADDRGP4 $263
JUMPV
LABELV $276
line 410
;410:	}
LABELV $273
line 411
;411:	if (BotNumActivePlayers() <= 1) return qfalse;
ADDRLP4 44
ADDRGP4 BotNumActivePlayers
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 1
GTI4 $278
CNSTI4 0
RETI4
ADDRGP4 $263
JUMPV
LABELV $278
line 412
;412:	if (!BotValidChatPosition(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 BotValidChatPosition
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $280
CNSTI4 0
RETI4
ADDRGP4 $263
JUMPV
LABELV $280
line 413
;413:	BotAI_BotInitialChat(bs, "game_enter",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 52
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 60
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $282
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 $283
ASGNP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 420
;414:				EasyClientName(bs->client, name, 32),	// 0
;415:				BotRandomOpponentName(bs),				// 1
;416:				"[invalid var]",						// 2
;417:				"[invalid var]",						// 3
;418:				BotMapTitle(),							// 4
;419:				NULL);
;420:	bs->lastchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 421
;421:	bs->chatto = CHAT_ALL;
ADDRFP4 0
INDIRP4
CNSTI4 6052
ADDP4
CNSTI4 0
ASGNI4
line 422
;422:	return qtrue;
CNSTI4 1
RETI4
LABELV $263
endproc BotChat_EnterGame 68 32
export BotChat_ExitGame
proc BotChat_ExitGame 64 32
line 430
;423:}
;424:
;425:/*
;426:==================
;427:BotChat_ExitGame
;428:==================
;429:*/
;430:int BotChat_ExitGame(bot_state_t *bs) {
line 434
;431:	char name[32];
;432:	float rnd;
;433:
;434:	if ( bot_nochat.integer == 1 ) {
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 1
NEI4 $285
line 435
;435:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $284
JUMPV
LABELV $285
line 437
;436:	}
;437:	if (bs->lastchat_time > FloatTime() - TIME_BETWEENCHATTING) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1103626240
SUBF4
LEF4 $288
CNSTI4 0
RETI4
ADDRGP4 $284
JUMPV
LABELV $288
line 439
;438:	//don't chat in teamplay
;439:	if (TeamPlayIsOn()) return qfalse;
ADDRLP4 36
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $290
CNSTI4 0
RETI4
ADDRGP4 $284
JUMPV
LABELV $290
line 441
;440:	// don't chat in tournament mode
;441:	if (gametype == GT_TOURNAMENT) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 1
NEI4 $292
CNSTI4 0
RETI4
ADDRGP4 $284
JUMPV
LABELV $292
line 442
;442:	rnd = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_ENTEREXITGAME, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 27
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 40
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 40
INDIRF4
ASGNF4
line 443
;443:	if (!bot_fastchat.integer) {
ADDRGP4 bot_fastchat+12
INDIRI4
CNSTI4 0
NEI4 $294
line 444
;444:		if (random() > rnd) return qfalse;
ADDRLP4 44
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 0
INDIRF4
LEF4 $297
CNSTI4 0
RETI4
ADDRGP4 $284
JUMPV
LABELV $297
line 445
;445:	}
LABELV $294
line 446
;446:	if (BotNumActivePlayers() <= 1) return qfalse;
ADDRLP4 44
ADDRGP4 BotNumActivePlayers
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 1
GTI4 $299
CNSTI4 0
RETI4
ADDRGP4 $284
JUMPV
LABELV $299
line 448
;447:	//
;448:	BotAI_BotInitialChat(bs, "game_exit",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 48
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 56
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $301
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 $283
ASGNP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 56
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 455
;449:				EasyClientName(bs->client, name, 32),	// 0
;450:				BotRandomOpponentName(bs),				// 1
;451:				"[invalid var]",						// 2
;452:				"[invalid var]",						// 3
;453:				BotMapTitle(),							// 4
;454:				NULL);
;455:	bs->lastchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 456
;456:	bs->chatto = CHAT_ALL;
ADDRFP4 0
INDIRP4
CNSTI4 6052
ADDP4
CNSTI4 0
ASGNI4
line 457
;457:	return qtrue;
CNSTI4 1
RETI4
LABELV $284
endproc BotChat_ExitGame 64 32
export BotChat_StartLevel
proc BotChat_StartLevel 56 16
line 465
;458:}
;459:
;460:/*
;461:==================
;462:BotChat_StartLevel
;463:==================
;464:*/
;465:int BotChat_StartLevel(bot_state_t *bs) {
line 469
;466:	char name[32];
;467:	float rnd;
;468:
;469:	if ( bot_nochat.integer == 1 ) {
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 1
NEI4 $303
line 470
;470:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $302
JUMPV
LABELV $303
line 472
;471:	}
;472:	if (BotIsObserver(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 BotIsObserver
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $306
CNSTI4 0
RETI4
ADDRGP4 $302
JUMPV
LABELV $306
line 473
;473:	if (bs->lastchat_time > FloatTime() - TIME_BETWEENCHATTING) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1103626240
SUBF4
LEF4 $308
CNSTI4 0
RETI4
ADDRGP4 $302
JUMPV
LABELV $308
line 475
;474:	//don't chat in teamplay
;475:	if (TeamPlayIsOn()) {
ADDRLP4 40
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $310
line 476
;476:	    trap_EA_Command(bs->client, "vtaunt");
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $312
ARGP4
ADDRGP4 trap_EA_Command
CALLV
pop
line 477
;477:	    return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $302
JUMPV
LABELV $310
line 480
;478:	}
;479:	// don't chat in tournament mode
;480:	if (gametype == GT_TOURNAMENT) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 1
NEI4 $313
CNSTI4 0
RETI4
ADDRGP4 $302
JUMPV
LABELV $313
line 481
;481:	rnd = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_STARTENDLEVEL, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 26
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 44
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 44
INDIRF4
ASGNF4
line 482
;482:	if (!bot_fastchat.integer) {
ADDRGP4 bot_fastchat+12
INDIRI4
CNSTI4 0
NEI4 $315
line 483
;483:		if (random() > rnd) return qfalse;
ADDRLP4 48
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 0
INDIRF4
LEF4 $318
CNSTI4 0
RETI4
ADDRGP4 $302
JUMPV
LABELV $318
line 484
;484:	}
LABELV $315
line 485
;485:	if (BotNumActivePlayers() <= 1) return qfalse;
ADDRLP4 48
ADDRGP4 BotNumActivePlayers
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 1
GTI4 $320
CNSTI4 0
RETI4
ADDRGP4 $302
JUMPV
LABELV $320
line 486
;486:	BotAI_BotInitialChat(bs, "level_start",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 52
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $322
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 489
;487:				EasyClientName(bs->client, name, 32),	// 0
;488:				NULL);
;489:	bs->lastchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 490
;490:	bs->chatto = CHAT_ALL;
ADDRFP4 0
INDIRP4
CNSTI4 6052
ADDP4
CNSTI4 0
ASGNI4
line 491
;491:	return qtrue;
CNSTI4 1
RETI4
LABELV $302
endproc BotChat_StartLevel 56 16
export BotChat_EndLevel
proc BotChat_EndLevel 80 32
line 499
;492:}
;493:
;494:/*
;495:==================
;496:BotChat_EndLevel
;497:==================
;498:*/
;499:int BotChat_EndLevel(bot_state_t *bs) {
line 503
;500:	char name[32];
;501:	float rnd;
;502:
;503:	if ( bot_nochat.integer == 1 ) {
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 1
NEI4 $324
line 504
;504:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $323
JUMPV
LABELV $324
line 506
;505:	}
;506:	if (BotIsObserver(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 BotIsObserver
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $327
CNSTI4 0
RETI4
ADDRGP4 $323
JUMPV
LABELV $327
line 507
;507:	if (bs->lastchat_time > FloatTime() - TIME_BETWEENCHATTING) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1103626240
SUBF4
LEF4 $329
CNSTI4 0
RETI4
ADDRGP4 $323
JUMPV
LABELV $329
line 509
;508:	// teamplay
;509:	if (TeamPlayIsOn()) 
ADDRLP4 40
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $331
line 510
;510:	{
line 511
;511:		if (BotIsFirstInRankings(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 BotIsFirstInRankings
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $333
line 512
;512:			trap_EA_Command(bs->client, "vtaunt");
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $312
ARGP4
ADDRGP4 trap_EA_Command
CALLV
pop
line 513
;513:		}
LABELV $333
line 514
;514:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $323
JUMPV
LABELV $331
line 517
;515:	}
;516:	// don't chat in tournament mode
;517:	if (gametype == GT_TOURNAMENT) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 1
NEI4 $335
CNSTI4 0
RETI4
ADDRGP4 $323
JUMPV
LABELV $335
line 518
;518:	rnd = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_STARTENDLEVEL, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 26
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 44
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 44
INDIRF4
ASGNF4
line 519
;519:	if (!bot_fastchat.integer) {
ADDRGP4 bot_fastchat+12
INDIRI4
CNSTI4 0
NEI4 $337
line 520
;520:		if (random() > rnd) return qfalse;
ADDRLP4 48
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 0
INDIRF4
LEF4 $340
CNSTI4 0
RETI4
ADDRGP4 $323
JUMPV
LABELV $340
line 521
;521:	}
LABELV $337
line 522
;522:	if (BotNumActivePlayers() <= 1) return qfalse;
ADDRLP4 48
ADDRGP4 BotNumActivePlayers
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 1
GTI4 $342
CNSTI4 0
RETI4
ADDRGP4 $323
JUMPV
LABELV $342
line 524
;523:	//
;524:	if (BotIsFirstInRankings(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 BotIsFirstInRankings
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $344
line 525
;525:		BotAI_BotInitialChat(bs, "level_end_victory",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 56
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 64
ADDRGP4 BotLastClientInRankings
CALLP4
ASGNP4
ADDRLP4 68
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $346
ARGP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 532
;526:				EasyClientName(bs->client, name, 32),	// 0
;527:				BotRandomOpponentName(bs),				// 1
;528:				"[invalid var]",						// 2
;529:				BotLastClientInRankings(),				// 3
;530:				BotMapTitle(),							// 4
;531:				NULL);
;532:	}
ADDRGP4 $345
JUMPV
LABELV $344
line 533
;533:	else if (BotIsLastInRankings(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 BotIsLastInRankings
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $347
line 534
;534:		BotAI_BotInitialChat(bs, "level_end_lose",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 60
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 68
ADDRGP4 BotFirstClientInRankings
CALLP4
ASGNP4
ADDRLP4 72
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $349
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRGP4 $283
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 541
;535:				EasyClientName(bs->client, name, 32),	// 0
;536:				BotRandomOpponentName(bs),				// 1
;537:				BotFirstClientInRankings(),				// 2
;538:				"[invalid var]",						// 3
;539:				BotMapTitle(),							// 4
;540:				NULL);
;541:	}
ADDRGP4 $348
JUMPV
LABELV $347
line 542
;542:	else {
line 543
;543:		BotAI_BotInitialChat(bs, "level_end",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 60
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 68
ADDRGP4 BotFirstClientInRankings
CALLP4
ASGNP4
ADDRLP4 72
ADDRGP4 BotLastClientInRankings
CALLP4
ASGNP4
ADDRLP4 76
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $350
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 550
;544:				EasyClientName(bs->client, name, 32),	// 0
;545:				BotRandomOpponentName(bs),				// 1
;546:				BotFirstClientInRankings(),				// 2
;547:				BotLastClientInRankings(),				// 3
;548:				BotMapTitle(),							// 4
;549:				NULL);
;550:	}
LABELV $348
LABELV $345
line 551
;551:	bs->lastchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 552
;552:	bs->chatto = CHAT_ALL;
ADDRFP4 0
INDIRP4
CNSTI4 6052
ADDP4
CNSTI4 0
ASGNI4
line 553
;553:	return qtrue;
CNSTI4 1
RETI4
LABELV $323
endproc BotChat_EndLevel 80 32
export BotChat_Death
proc BotChat_Death 116 20
line 561
;554:}
;555:
;556:/*
;557:==================
;558:BotChat_Death
;559:==================
;560:*/
;561:int BotChat_Death(bot_state_t *bs) {
line 565
;562:	char name[32];
;563:	float rnd;
;564:
;565:	if ( bot_nochat.integer == 1 ) {
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 1
NEI4 $352
line 566
;566:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $351
JUMPV
LABELV $352
line 568
;567:	}
;568:	if (bs->lastchat_time > FloatTime() - TIME_BETWEENCHATTING) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1103626240
SUBF4
LEF4 $355
CNSTI4 0
RETI4
ADDRGP4 $351
JUMPV
LABELV $355
line 569
;569:	rnd = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_DEATH, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 29
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 36
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 32
ADDRLP4 36
INDIRF4
ASGNF4
line 571
;570:	// don't chat in tournament mode
;571:	if (gametype == GT_TOURNAMENT) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 1
NEI4 $357
CNSTI4 0
RETI4
ADDRGP4 $351
JUMPV
LABELV $357
line 573
;572:	//if fast chatting is off
;573:	if (!bot_fastchat.integer) {
ADDRGP4 bot_fastchat+12
INDIRI4
CNSTI4 0
NEI4 $359
line 574
;574:		if (random() > rnd) return qfalse;
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 32
INDIRF4
LEF4 $362
CNSTI4 0
RETI4
ADDRGP4 $351
JUMPV
LABELV $362
line 575
;575:	}
LABELV $359
line 576
;576:	if (BotNumActivePlayers() <= 1) return qfalse;
ADDRLP4 40
ADDRGP4 BotNumActivePlayers
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 1
GTI4 $364
CNSTI4 0
RETI4
ADDRGP4 $351
JUMPV
LABELV $364
line 578
;577:	//
;578:	if (bs->lastkilledby >= 0 && bs->lastkilledby < MAX_CLIENTS)
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 5996
ADDP4
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
LTI4 $366
ADDRLP4 44
INDIRI4
CNSTI4 64
GEI4 $366
line 579
;579:		EasyClientName(bs->lastkilledby, name, 32);
ADDRFP4 0
INDIRP4
CNSTI4 5996
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
ADDRGP4 $367
JUMPV
LABELV $366
line 581
;580:	else
;581:		strcpy(name, "[world]");
ADDRLP4 0
ARGP4
ADDRGP4 $368
ARGP4
ADDRGP4 strcpy
CALLP4
pop
LABELV $367
line 583
;582:	//
;583:	if (TeamPlayIsOn() && BotSameTeam(bs, bs->lastkilledby)) {
ADDRLP4 48
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $369
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 52
INDIRP4
CNSTI4 5996
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $369
line 584
;584:		if (bs->lastkilledby == bs->client) return qfalse;
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 5996
ADDP4
INDIRI4
ADDRLP4 60
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $371
CNSTI4 0
RETI4
ADDRGP4 $351
JUMPV
LABELV $371
line 585
;585:		BotAI_BotInitialChat(bs, "death_teammate", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $373
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 586
;586:		bs->chatto = CHAT_TEAM;
ADDRFP4 0
INDIRP4
CNSTI4 6052
ADDP4
CNSTI4 1
ASGNI4
line 587
;587:	}
ADDRGP4 $370
JUMPV
LABELV $369
line 589
;588:	else
;589:	{
line 591
;590:		//teamplay
;591:		if (TeamPlayIsOn()) {
ADDRLP4 60
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $374
line 592
;592:			trap_EA_Command(bs->client, "vtaunt");
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $312
ARGP4
ADDRGP4 trap_EA_Command
CALLV
pop
line 593
;593:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $351
JUMPV
LABELV $374
line 596
;594:		}
;595:		//
;596:		if (bs->botdeathtype == MOD_WATER)
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
CNSTI4 14
NEI4 $376
line 597
;597:			BotAI_BotInitialChat(bs, "death_drown", BotRandomOpponentName(bs), NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $378
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
ADDRGP4 $377
JUMPV
LABELV $376
line 598
;598:		else if (bs->botdeathtype == MOD_SLIME)
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
CNSTI4 15
NEI4 $379
line 599
;599:			BotAI_BotInitialChat(bs, "death_slime", BotRandomOpponentName(bs), NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $381
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
ADDRGP4 $380
JUMPV
LABELV $379
line 600
;600:		else if (bs->botdeathtype == MOD_LAVA)
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
CNSTI4 16
NEI4 $382
line 601
;601:			BotAI_BotInitialChat(bs, "death_lava", BotRandomOpponentName(bs), NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $384
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
ADDRGP4 $383
JUMPV
LABELV $382
line 602
;602:		else if (bs->botdeathtype == MOD_FALLING)
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
CNSTI4 19
NEI4 $385
line 603
;603:			BotAI_BotInitialChat(bs, "death_cratered", BotRandomOpponentName(bs), NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $387
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
ADDRGP4 $386
JUMPV
LABELV $385
line 604
;604:		else if (bs->botsuicide || //all other suicides by own weapon
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
CNSTI4 0
ASGNI4
ADDRLP4 80
INDIRP4
CNSTI4 6008
ADDP4
INDIRI4
ADDRLP4 84
INDIRI4
NEI4 $394
ADDRLP4 88
ADDRLP4 80
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 17
EQI4 $394
ADDRLP4 88
INDIRI4
CNSTI4 20
EQI4 $394
ADDRLP4 88
INDIRI4
CNSTI4 21
EQI4 $394
ADDRLP4 88
INDIRI4
CNSTI4 22
EQI4 $394
ADDRLP4 88
INDIRI4
ADDRLP4 84
INDIRI4
NEI4 $388
LABELV $394
line 610
;605:				bs->botdeathtype == MOD_CRUSH ||
;606:				bs->botdeathtype == MOD_SUICIDE ||
;607:				bs->botdeathtype == MOD_TARGET_LASER ||
;608:				bs->botdeathtype == MOD_TRIGGER_HURT ||
;609:				bs->botdeathtype == MOD_UNKNOWN)
;610:			BotAI_BotInitialChat(bs, "death_suicide", BotRandomOpponentName(bs), NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 92
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $395
ARGP4
ADDRLP4 92
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
ADDRGP4 $389
JUMPV
LABELV $388
line 611
;611:		else if (bs->botdeathtype == MOD_TELEFRAG)
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
CNSTI4 18
NEI4 $396
line 612
;612:			BotAI_BotInitialChat(bs, "death_telefrag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $398
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
ADDRGP4 $397
JUMPV
LABELV $396
line 617
;613:#ifdef MISSIONPACK
;614:		else if (bs->botdeathtype == MOD_KAMIKAZE && trap_BotNumInitialChats(bs->cs, "death_kamikaze"))
;615:			BotAI_BotInitialChat(bs, "death_kamikaze", name, NULL);
;616:#endif
;617:		else {
line 618
;618:			if ((bs->botdeathtype == MOD_GAUNTLET ||
ADDRLP4 96
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 2
EQI4 $403
ADDRLP4 96
INDIRI4
CNSTI4 10
EQI4 $403
ADDRLP4 96
INDIRI4
CNSTI4 12
EQI4 $403
ADDRLP4 96
INDIRI4
CNSTI4 13
NEI4 $399
LABELV $403
ADDRLP4 100
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
GEF4 $399
line 621
;619:				bs->botdeathtype == MOD_RAILGUN ||
;620:				bs->botdeathtype == MOD_BFG ||
;621:				bs->botdeathtype == MOD_BFG_SPLASH) && random() < 0.5) {
line 623
;622:
;623:				if (bs->botdeathtype == MOD_GAUNTLET)
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
CNSTI4 2
NEI4 $404
line 624
;624:					BotAI_BotInitialChat(bs, "death_gauntlet",
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
ARGI4
ADDRLP4 104
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $406
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 104
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
ADDRGP4 $400
JUMPV
LABELV $404
line 628
;625:							name,												// 0
;626:							BotWeaponNameForMeansOfDeath(bs->botdeathtype),		// 1
;627:							NULL);
;628:				else if (bs->botdeathtype == MOD_RAILGUN)
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
CNSTI4 10
NEI4 $407
line 629
;629:					BotAI_BotInitialChat(bs, "death_rail",
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
ARGI4
ADDRLP4 108
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $409
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 108
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
ADDRGP4 $400
JUMPV
LABELV $407
line 634
;630:							name,												// 0
;631:							BotWeaponNameForMeansOfDeath(bs->botdeathtype),		// 1
;632:							NULL);
;633:				else
;634:					BotAI_BotInitialChat(bs, "death_bfg",
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
ARGI4
ADDRLP4 112
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $410
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 112
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 638
;635:							name,												// 0
;636:							BotWeaponNameForMeansOfDeath(bs->botdeathtype),		// 1
;637:							NULL);
;638:			}
ADDRGP4 $400
JUMPV
LABELV $399
line 640
;639:			//choose between insult and praise
;640:			else if (random() < trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_INSULT, 0, 1)) {
ADDRLP4 104
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 24
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 108
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 104
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 108
INDIRF4
GEF4 $411
line 641
;641:				BotAI_BotInitialChat(bs, "death_insult",
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
ARGI4
ADDRLP4 112
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $413
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 112
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 645
;642:							name,												// 0
;643:							BotWeaponNameForMeansOfDeath(bs->botdeathtype),		// 1
;644:							NULL);
;645:			}
ADDRGP4 $412
JUMPV
LABELV $411
line 646
;646:			else {
line 647
;647:				BotAI_BotInitialChat(bs, "death_praise",
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
ARGI4
ADDRLP4 112
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $414
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 112
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 651
;648:							name,												// 0
;649:							BotWeaponNameForMeansOfDeath(bs->botdeathtype),		// 1
;650:							NULL);
;651:			}
LABELV $412
LABELV $400
line 652
;652:		}
LABELV $397
LABELV $389
LABELV $386
LABELV $383
LABELV $380
LABELV $377
line 653
;653:		bs->chatto = CHAT_ALL;
ADDRFP4 0
INDIRP4
CNSTI4 6052
ADDP4
CNSTI4 0
ASGNI4
line 654
;654:	}
LABELV $370
line 655
;655:	bs->lastchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 656
;656:	return qtrue;
CNSTI4 1
RETI4
LABELV $351
endproc BotChat_Death 116 20
export BotChat_Kill
proc BotChat_Kill 80 16
line 664
;657:}
;658:
;659:/*
;660:==================
;661:BotChat_Kill
;662:==================
;663:*/
;664:int BotChat_Kill(bot_state_t *bs) {
line 668
;665:	char name[32];
;666:	float rnd;
;667:
;668:	if ( bot_nochat.integer == 1 ) {
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 1
NEI4 $416
line 669
;669:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $415
JUMPV
LABELV $416
line 671
;670:	}
;671:	if (bs->lastchat_time > FloatTime() - TIME_BETWEENCHATTING) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1103626240
SUBF4
LEF4 $419
CNSTI4 0
RETI4
ADDRGP4 $415
JUMPV
LABELV $419
line 672
;672:	rnd = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_KILL, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 28
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 36
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 32
ADDRLP4 36
INDIRF4
ASGNF4
line 674
;673:	// don't chat in tournament mode
;674:	if (gametype == GT_TOURNAMENT) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 1
NEI4 $421
CNSTI4 0
RETI4
ADDRGP4 $415
JUMPV
LABELV $421
line 676
;675:	//if fast chat is off
;676:	if (!bot_fastchat.integer) {
ADDRGP4 bot_fastchat+12
INDIRI4
CNSTI4 0
NEI4 $423
line 677
;677:		if (random() > rnd) return qfalse;
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 32
INDIRF4
LEF4 $426
CNSTI4 0
RETI4
ADDRGP4 $415
JUMPV
LABELV $426
line 678
;678:	}
LABELV $423
line 679
;679:	if (bs->lastkilledplayer == bs->client) return qfalse;
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 5992
ADDP4
INDIRI4
ADDRLP4 40
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $428
CNSTI4 0
RETI4
ADDRGP4 $415
JUMPV
LABELV $428
line 680
;680:	if (BotNumActivePlayers() <= 1) return qfalse;
ADDRLP4 44
ADDRGP4 BotNumActivePlayers
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 1
GTI4 $430
CNSTI4 0
RETI4
ADDRGP4 $415
JUMPV
LABELV $430
line 681
;681:	if (!BotValidChatPosition(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 BotValidChatPosition
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $432
CNSTI4 0
RETI4
ADDRGP4 $415
JUMPV
LABELV $432
line 683
;682:	//
;683:	if (BotVisibleEnemies(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 BotVisibleEnemies
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $434
CNSTI4 0
RETI4
ADDRGP4 $415
JUMPV
LABELV $434
line 685
;684:	//
;685:	EasyClientName(bs->lastkilledplayer, name, 32);
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 687
;686:	//
;687:	bs->chatto = CHAT_ALL;
ADDRFP4 0
INDIRP4
CNSTI4 6052
ADDP4
CNSTI4 0
ASGNI4
line 688
;688:	if (TeamPlayIsOn() && BotSameTeam(bs, bs->lastkilledplayer)) {
ADDRLP4 56
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $436
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 5992
ADDP4
INDIRI4
ARGI4
ADDRLP4 64
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $436
line 689
;689:		BotAI_BotInitialChat(bs, "kill_teammate", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $438
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 690
;690:		bs->chatto = CHAT_TEAM;
ADDRFP4 0
INDIRP4
CNSTI4 6052
ADDP4
CNSTI4 1
ASGNI4
line 691
;691:	}
ADDRGP4 $437
JUMPV
LABELV $436
line 693
;692:	else
;693:	{
line 695
;694:		//don't chat in teamplay
;695:		if (TeamPlayIsOn()) {
ADDRLP4 68
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $439
line 696
;696:			trap_EA_Command(bs->client, "vtaunt");
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $312
ARGP4
ADDRGP4 trap_EA_Command
CALLV
pop
line 697
;697:			return qfalse;			// don't wait
CNSTI4 0
RETI4
ADDRGP4 $415
JUMPV
LABELV $439
line 700
;698:		}
;699:		//
;700:		if (bs->enemydeathtype == MOD_GAUNTLET) {
ADDRFP4 0
INDIRP4
CNSTI4 6004
ADDP4
INDIRI4
CNSTI4 2
NEI4 $441
line 701
;701:			BotAI_BotInitialChat(bs, "kill_gauntlet", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $443
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 702
;702:		}
ADDRGP4 $442
JUMPV
LABELV $441
line 703
;703:		else if (bs->enemydeathtype == MOD_RAILGUN) {
ADDRFP4 0
INDIRP4
CNSTI4 6004
ADDP4
INDIRI4
CNSTI4 10
NEI4 $444
line 704
;704:			BotAI_BotInitialChat(bs, "kill_rail", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $446
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 705
;705:		}
ADDRGP4 $445
JUMPV
LABELV $444
line 706
;706:		else if (bs->enemydeathtype == MOD_TELEFRAG) {
ADDRFP4 0
INDIRP4
CNSTI4 6004
ADDP4
INDIRI4
CNSTI4 18
NEI4 $447
line 707
;707:			BotAI_BotInitialChat(bs, "kill_telefrag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $449
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 708
;708:		}
ADDRGP4 $448
JUMPV
LABELV $447
line 714
;709:#ifdef MISSIONPACK
;710:		else if (bs->botdeathtype == MOD_KAMIKAZE && trap_BotNumInitialChats(bs->cs, "kill_kamikaze"))
;711:			BotAI_BotInitialChat(bs, "kill_kamikaze", name, NULL);
;712:#endif
;713:		//choose between insult and praise
;714:		else if (random() < trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_INSULT, 0, 1)) {
ADDRLP4 72
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 24
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 76
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 72
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 76
INDIRF4
GEF4 $450
line 715
;715:			BotAI_BotInitialChat(bs, "kill_insult", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $452
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 716
;716:		}
ADDRGP4 $451
JUMPV
LABELV $450
line 717
;717:		else {
line 718
;718:			BotAI_BotInitialChat(bs, "kill_praise", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $453
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 719
;719:		}
LABELV $451
LABELV $448
LABELV $445
LABELV $442
line 720
;720:	}
LABELV $437
line 721
;721:	bs->lastchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 722
;722:	return qtrue;
CNSTI4 1
RETI4
LABELV $415
endproc BotChat_Kill 80 16
export BotChat_EnemySuicide
proc BotChat_EnemySuicide 56 16
line 730
;723:}
;724:
;725:/*
;726:==================
;727:BotChat_EnemySuicide
;728:==================
;729:*/
;730:int BotChat_EnemySuicide(bot_state_t *bs) {
line 734
;731:	char name[32];
;732:	float rnd;
;733:
;734:	if ( bot_nochat.integer == 1 ) {
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 1
NEI4 $455
line 735
;735:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $454
JUMPV
LABELV $455
line 737
;736:	}
;737:	if (bs->lastchat_time > FloatTime() - TIME_BETWEENCHATTING) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1103626240
SUBF4
LEF4 $458
CNSTI4 0
RETI4
ADDRGP4 $454
JUMPV
LABELV $458
line 738
;738:	if (BotNumActivePlayers() <= 1) return qfalse;
ADDRLP4 36
ADDRGP4 BotNumActivePlayers
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 1
GTI4 $460
CNSTI4 0
RETI4
ADDRGP4 $454
JUMPV
LABELV $460
line 740
;739:	//
;740:	rnd = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_KILL, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 28
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 40
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 32
ADDRLP4 40
INDIRF4
ASGNF4
line 742
;741:	//don't chat in teamplay
;742:	if (TeamPlayIsOn()) return qfalse;
ADDRLP4 44
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $462
CNSTI4 0
RETI4
ADDRGP4 $454
JUMPV
LABELV $462
line 744
;743:	// don't chat in tournament mode
;744:	if (gametype == GT_TOURNAMENT) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 1
NEI4 $464
CNSTI4 0
RETI4
ADDRGP4 $454
JUMPV
LABELV $464
line 746
;745:	//if fast chat is off
;746:	if (!bot_fastchat.integer) {
ADDRGP4 bot_fastchat+12
INDIRI4
CNSTI4 0
NEI4 $466
line 747
;747:		if (random() > rnd) return qfalse;
ADDRLP4 48
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 32
INDIRF4
LEF4 $469
CNSTI4 0
RETI4
ADDRGP4 $454
JUMPV
LABELV $469
line 748
;748:	}
LABELV $466
line 749
;749:	if (!BotValidChatPosition(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 BotValidChatPosition
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $471
CNSTI4 0
RETI4
ADDRGP4 $454
JUMPV
LABELV $471
line 751
;750:	//
;751:	if (BotVisibleEnemies(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 BotVisibleEnemies
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $473
CNSTI4 0
RETI4
ADDRGP4 $454
JUMPV
LABELV $473
line 753
;752:	//
;753:	if (bs->enemy >= 0) EasyClientName(bs->enemy, name, 32);
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
CNSTI4 0
LTI4 $475
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
ADDRGP4 $476
JUMPV
LABELV $475
line 754
;754:	else strcpy(name, "");
ADDRLP4 0
ARGP4
ADDRGP4 $477
ARGP4
ADDRGP4 strcpy
CALLP4
pop
LABELV $476
line 755
;755:	BotAI_BotInitialChat(bs, "enemy_suicide", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $478
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 756
;756:	bs->lastchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 757
;757:	bs->chatto = CHAT_ALL;
ADDRFP4 0
INDIRP4
CNSTI4 6052
ADDP4
CNSTI4 0
ASGNI4
line 758
;758:	return qtrue;
CNSTI4 1
RETI4
LABELV $454
endproc BotChat_EnemySuicide 56 16
export BotChat_HitTalking
proc BotChat_HitTalking 68 20
line 766
;759:}
;760:
;761:/*
;762:==================
;763:BotChat_HitTalking
;764:==================
;765:*/
;766:int BotChat_HitTalking(bot_state_t *bs) {
line 771
;767:	char name[32], *weap;
;768:	int lasthurt_client;
;769:	float rnd;
;770:
;771:	if ( bot_nochat.integer == 1 ) {
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 1
NEI4 $480
line 772
;772:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $479
JUMPV
LABELV $480
line 774
;773:	}
;774:	if (bs->lastchat_time > FloatTime() - TIME_BETWEENCHATTING) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1103626240
SUBF4
LEF4 $483
CNSTI4 0
RETI4
ADDRGP4 $479
JUMPV
LABELV $483
line 775
;775:	if (BotNumActivePlayers() <= 1) return qfalse;
ADDRLP4 44
ADDRGP4 BotNumActivePlayers
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 1
GTI4 $485
CNSTI4 0
RETI4
ADDRGP4 $479
JUMPV
LABELV $485
line 776
;776:	lasthurt_client = g_entities[bs->client].client->lasthurt_client;
ADDRLP4 0
CNSTI4 896
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 10324
ADDP4
INDIRI4
ASGNI4
line 777
;777:	if (!lasthurt_client) return qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $488
CNSTI4 0
RETI4
ADDRGP4 $479
JUMPV
LABELV $488
line 778
;778:	if (lasthurt_client == bs->client) return qfalse;
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $490
CNSTI4 0
RETI4
ADDRGP4 $479
JUMPV
LABELV $490
line 780
;779:	//
;780:	if (lasthurt_client < 0 || lasthurt_client >= MAX_CLIENTS) return qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $494
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $492
LABELV $494
CNSTI4 0
RETI4
ADDRGP4 $479
JUMPV
LABELV $492
line 782
;781:	//
;782:	rnd = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_HITTALKING, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 31
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 52
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 40
ADDRLP4 52
INDIRF4
ASGNF4
line 784
;783:	//don't chat in teamplay
;784:	if (TeamPlayIsOn()) return qfalse;
ADDRLP4 56
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $495
CNSTI4 0
RETI4
ADDRGP4 $479
JUMPV
LABELV $495
line 786
;785:	// don't chat in tournament mode
;786:	if (gametype == GT_TOURNAMENT) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 1
NEI4 $497
CNSTI4 0
RETI4
ADDRGP4 $479
JUMPV
LABELV $497
line 788
;787:	//if fast chat is off
;788:	if (!bot_fastchat.integer) {
ADDRGP4 bot_fastchat+12
INDIRI4
CNSTI4 0
NEI4 $499
line 789
;789:		if (random() > rnd * 0.5) return qfalse;
ADDRLP4 60
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
ADDRLP4 40
INDIRF4
MULF4
LEF4 $502
CNSTI4 0
RETI4
ADDRGP4 $479
JUMPV
LABELV $502
line 790
;790:	}
LABELV $499
line 791
;791:	if (!BotValidChatPosition(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 BotValidChatPosition
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $504
CNSTI4 0
RETI4
ADDRGP4 $479
JUMPV
LABELV $504
line 793
;792:	//
;793:	ClientName(g_entities[bs->client].client->lasthurt_client, name, sizeof(name));
CNSTI4 896
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 10324
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 794
;794:	weap = BotWeaponNameForMeansOfDeath(g_entities[bs->client].client->lasthurt_client);
CNSTI4 896
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 10324
ADDP4
INDIRI4
ARGI4
ADDRLP4 64
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRLP4 36
ADDRLP4 64
INDIRP4
ASGNP4
line 796
;795:	//
;796:	BotAI_BotInitialChat(bs, "hit_talking", name, weap, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $508
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 797
;797:	bs->lastchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 798
;798:	bs->chatto = CHAT_ALL;
ADDRFP4 0
INDIRP4
CNSTI4 6052
ADDP4
CNSTI4 0
ASGNI4
line 799
;799:	return qtrue;
CNSTI4 1
RETI4
LABELV $479
endproc BotChat_HitTalking 68 20
export BotChat_HitNoDeath
proc BotChat_HitNoDeath 216 20
line 807
;800:}
;801:
;802:/*
;803:==================
;804:BotChat_HitNoDeath
;805:==================
;806:*/
;807:int BotChat_HitNoDeath(bot_state_t *bs) {
line 813
;808:	char name[32], *weap;
;809:	float rnd;
;810:	int lasthurt_client;
;811:	aas_entityinfo_t entinfo;
;812:
;813:	lasthurt_client = g_entities[bs->client].client->lasthurt_client;
ADDRLP4 0
CNSTI4 896
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 10324
ADDP4
INDIRI4
ASGNI4
line 814
;814:	if (!lasthurt_client) return qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $511
CNSTI4 0
RETI4
ADDRGP4 $509
JUMPV
LABELV $511
line 815
;815:	if (lasthurt_client == bs->client) return qfalse;
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $513
CNSTI4 0
RETI4
ADDRGP4 $509
JUMPV
LABELV $513
line 817
;816:	//
;817:	if (lasthurt_client < 0 || lasthurt_client >= MAX_CLIENTS) return qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $517
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $515
LABELV $517
CNSTI4 0
RETI4
ADDRGP4 $509
JUMPV
LABELV $515
line 819
;818:	//
;819:	if ( bot_nochat.integer == 1 ) {
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 1
NEI4 $518
line 820
;820:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $509
JUMPV
LABELV $518
line 822
;821:	}
;822:	if (bs->lastchat_time > FloatTime() - TIME_BETWEENCHATTING) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1103626240
SUBF4
LEF4 $521
CNSTI4 0
RETI4
ADDRGP4 $509
JUMPV
LABELV $521
line 823
;823:	if (BotNumActivePlayers() <= 1) return qfalse;
ADDRLP4 188
ADDRGP4 BotNumActivePlayers
CALLI4
ASGNI4
ADDRLP4 188
INDIRI4
CNSTI4 1
GTI4 $523
CNSTI4 0
RETI4
ADDRGP4 $509
JUMPV
LABELV $523
line 824
;824:	rnd = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_HITNODEATH, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 32
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 192
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 180
ADDRLP4 192
INDIRF4
ASGNF4
line 826
;825:	//don't chat in teamplay
;826:	if (TeamPlayIsOn()) return qfalse;
ADDRLP4 196
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 0
EQI4 $525
CNSTI4 0
RETI4
ADDRGP4 $509
JUMPV
LABELV $525
line 828
;827:	// don't chat in tournament mode
;828:	if (gametype == GT_TOURNAMENT) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 1
NEI4 $527
CNSTI4 0
RETI4
ADDRGP4 $509
JUMPV
LABELV $527
line 830
;829:	//if fast chat is off
;830:	if (!bot_fastchat.integer) {
ADDRGP4 bot_fastchat+12
INDIRI4
CNSTI4 0
NEI4 $529
line 831
;831:		if (random() > rnd * 0.5) return qfalse;
ADDRLP4 200
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 200
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
ADDRLP4 180
INDIRF4
MULF4
LEF4 $532
CNSTI4 0
RETI4
ADDRGP4 $509
JUMPV
LABELV $532
line 832
;832:	}
LABELV $529
line 833
;833:	if (!BotValidChatPosition(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 200
ADDRGP4 BotValidChatPosition
CALLI4
ASGNI4
ADDRLP4 200
INDIRI4
CNSTI4 0
NEI4 $534
CNSTI4 0
RETI4
ADDRGP4 $509
JUMPV
LABELV $534
line 835
;834:	//
;835:	if (BotVisibleEnemies(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 204
ADDRGP4 BotVisibleEnemies
CALLI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 0
EQI4 $536
CNSTI4 0
RETI4
ADDRGP4 $509
JUMPV
LABELV $536
line 837
;836:	//
;837:	BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 838
;838:	if (EntityIsShooting(&entinfo)) return qfalse;
ADDRLP4 40
ARGP4
ADDRLP4 208
ADDRGP4 EntityIsShooting
CALLI4
ASGNI4
ADDRLP4 208
INDIRI4
CNSTI4 0
EQI4 $538
CNSTI4 0
RETI4
ADDRGP4 $509
JUMPV
LABELV $538
line 840
;839:	//
;840:	ClientName(lasthurt_client, name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 841
;841:	weap = BotWeaponNameForMeansOfDeath(g_entities[bs->client].client->lasthurt_mod);
CNSTI4 896
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 10328
ADDP4
INDIRI4
ARGI4
ADDRLP4 212
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRLP4 36
ADDRLP4 212
INDIRP4
ASGNP4
line 843
;842:	//
;843:	BotAI_BotInitialChat(bs, "hit_nodeath", name, weap, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $541
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 844
;844:	bs->lastchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 845
;845:	bs->chatto = CHAT_ALL;
ADDRFP4 0
INDIRP4
CNSTI4 6052
ADDP4
CNSTI4 0
ASGNI4
line 846
;846:	return qtrue;
CNSTI4 1
RETI4
LABELV $509
endproc BotChat_HitNoDeath 216 20
export BotChat_HitNoKill
proc BotChat_HitNoKill 208 20
line 854
;847:}
;848:
;849:/*
;850:==================
;851:BotChat_HitNoKill
;852:==================
;853:*/
;854:int BotChat_HitNoKill(bot_state_t *bs) {
line 859
;855:	char name[32], *weap;
;856:	float rnd;
;857:	aas_entityinfo_t entinfo;
;858:
;859:	if ( bot_nochat.integer == 1 ) {
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 1
NEI4 $543
line 860
;860:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $542
JUMPV
LABELV $543
line 862
;861:	}
;862:	if (bs->lastchat_time > FloatTime() - TIME_BETWEENCHATTING) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1103626240
SUBF4
LEF4 $546
CNSTI4 0
RETI4
ADDRGP4 $542
JUMPV
LABELV $546
line 863
;863:	if (BotNumActivePlayers() <= 1) return qfalse;
ADDRLP4 180
ADDRGP4 BotNumActivePlayers
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 1
GTI4 $548
CNSTI4 0
RETI4
ADDRGP4 $542
JUMPV
LABELV $548
line 864
;864:	rnd = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_HITNOKILL, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 33
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 184
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 176
ADDRLP4 184
INDIRF4
ASGNF4
line 866
;865:	//don't chat in teamplay
;866:	if (TeamPlayIsOn()) return qfalse;
ADDRLP4 188
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 188
INDIRI4
CNSTI4 0
EQI4 $550
CNSTI4 0
RETI4
ADDRGP4 $542
JUMPV
LABELV $550
line 868
;867:	// don't chat in tournament mode
;868:	if (gametype == GT_TOURNAMENT) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 1
NEI4 $552
CNSTI4 0
RETI4
ADDRGP4 $542
JUMPV
LABELV $552
line 870
;869:	//if fast chat is off
;870:	if (!bot_fastchat.integer) {
ADDRGP4 bot_fastchat+12
INDIRI4
CNSTI4 0
NEI4 $554
line 871
;871:		if (random() > rnd * 0.5) return qfalse;
ADDRLP4 192
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
ADDRLP4 176
INDIRF4
MULF4
LEF4 $557
CNSTI4 0
RETI4
ADDRGP4 $542
JUMPV
LABELV $557
line 872
;872:	}
LABELV $554
line 873
;873:	if (!BotValidChatPosition(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 192
ADDRGP4 BotValidChatPosition
CALLI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 0
NEI4 $559
CNSTI4 0
RETI4
ADDRGP4 $542
JUMPV
LABELV $559
line 875
;874:	//
;875:	if (BotVisibleEnemies(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 196
ADDRGP4 BotVisibleEnemies
CALLI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 0
EQI4 $561
CNSTI4 0
RETI4
ADDRGP4 $542
JUMPV
LABELV $561
line 877
;876:	//
;877:	BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 878
;878:	if (EntityIsShooting(&entinfo)) return qfalse;
ADDRLP4 36
ARGP4
ADDRLP4 200
ADDRGP4 EntityIsShooting
CALLI4
ASGNI4
ADDRLP4 200
INDIRI4
CNSTI4 0
EQI4 $563
CNSTI4 0
RETI4
ADDRGP4 $542
JUMPV
LABELV $563
line 880
;879:	//
;880:	ClientName(bs->enemy, name, sizeof(name));
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 881
;881:	weap = BotWeaponNameForMeansOfDeath(g_entities[bs->enemy].client->lasthurt_mod);
CNSTI4 896
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 10328
ADDP4
INDIRI4
ARGI4
ADDRLP4 204
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRLP4 32
ADDRLP4 204
INDIRP4
ASGNP4
line 883
;882:	//
;883:	BotAI_BotInitialChat(bs, "hit_nokill", name, weap, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $566
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 884
;884:	bs->lastchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 885
;885:	bs->chatto = CHAT_ALL;
ADDRFP4 0
INDIRP4
CNSTI4 6052
ADDP4
CNSTI4 0
ASGNI4
line 886
;886:	return qtrue;
CNSTI4 1
RETI4
LABELV $542
endproc BotChat_HitNoKill 208 20
export BotChat_Random
proc BotChat_Random 96 36
line 894
;887:}
;888:
;889:/*
;890:==================
;891:BotChat_Random
;892:==================
;893:*/
;894:int BotChat_Random(bot_state_t *bs) {
line 898
;895:	float rnd;
;896:	char name[32];
;897:
;898:	if ( bot_nochat.integer == 1 ) {
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 1
NEI4 $568
line 899
;899:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $567
JUMPV
LABELV $568
line 901
;900:	}
;901:	if (BotIsObserver(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 BotIsObserver
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $571
CNSTI4 0
RETI4
ADDRGP4 $567
JUMPV
LABELV $571
line 902
;902:	if (bs->lastchat_time > FloatTime() - TIME_BETWEENCHATTING) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1103626240
SUBF4
LEF4 $573
CNSTI4 0
RETI4
ADDRGP4 $567
JUMPV
LABELV $573
line 904
;903:	// don't chat in tournament mode
;904:	if (gametype == GT_TOURNAMENT) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 1
NEI4 $575
CNSTI4 0
RETI4
ADDRGP4 $567
JUMPV
LABELV $575
line 906
;905:	//don't chat when doing something important :)
;906:	if (bs->ltgtype == LTG_TEAMHELP ||
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 1
EQI4 $580
ADDRLP4 40
INDIRI4
CNSTI4 2
EQI4 $580
ADDRLP4 40
INDIRI4
CNSTI4 5
NEI4 $577
LABELV $580
line 908
;907:		bs->ltgtype == LTG_TEAMACCOMPANY ||
;908:		bs->ltgtype == LTG_RUSHBASE) return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $567
JUMPV
LABELV $577
line 910
;909:	//
;910:	rnd = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_RANDOM, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 34
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 44
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 32
ADDRLP4 44
INDIRF4
ASGNF4
line 911
;911:	if (random() > bs->thinktime * 0.1) return qfalse;
ADDRLP4 48
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1036831949
ADDRFP4 0
INDIRP4
CNSTI4 4904
ADDP4
INDIRF4
MULF4
LEF4 $581
CNSTI4 0
RETI4
ADDRGP4 $567
JUMPV
LABELV $581
line 912
;912:	if (!bot_fastchat.integer) {
ADDRGP4 bot_fastchat+12
INDIRI4
CNSTI4 0
NEI4 $583
line 913
;913:		if (random() > rnd) return qfalse;
ADDRLP4 52
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 32
INDIRF4
LEF4 $586
CNSTI4 0
RETI4
ADDRGP4 $567
JUMPV
LABELV $586
line 914
;914:		if (random() > 0.25) return qfalse;
ADDRLP4 56
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1048576000
LEF4 $588
CNSTI4 0
RETI4
ADDRGP4 $567
JUMPV
LABELV $588
line 915
;915:	}
LABELV $583
line 916
;916:	if (BotNumActivePlayers() <= 1) return qfalse;
ADDRLP4 52
ADDRGP4 BotNumActivePlayers
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 1
GTI4 $590
CNSTI4 0
RETI4
ADDRGP4 $567
JUMPV
LABELV $590
line 918
;917:	//
;918:	if (!BotValidChatPosition(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 BotValidChatPosition
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $592
CNSTI4 0
RETI4
ADDRGP4 $567
JUMPV
LABELV $592
line 920
;919:	//
;920:	if (BotVisibleEnemies(bs)) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 BotVisibleEnemies
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $594
CNSTI4 0
RETI4
ADDRGP4 $567
JUMPV
LABELV $594
line 922
;921:	//
;922:	if (bs->lastkilledplayer == bs->client) {
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 5992
ADDP4
INDIRI4
ADDRLP4 64
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $596
line 923
;923:		strcpy(name, BotRandomOpponentName(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 924
;924:	}
ADDRGP4 $597
JUMPV
LABELV $596
line 925
;925:	else {
line 926
;926:		EasyClientName(bs->lastkilledplayer, name, sizeof(name));
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 927
;927:	}
LABELV $597
line 928
;928:	if (TeamPlayIsOn()) {
ADDRLP4 68
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $598
line 929
;929:		trap_EA_Command(bs->client, "vtaunt");
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $312
ARGP4
ADDRGP4 trap_EA_Command
CALLV
pop
line 930
;930:		return qfalse;			// don't wait
CNSTI4 0
RETI4
ADDRGP4 $567
JUMPV
LABELV $598
line 933
;931:	}
;932:	//
;933:	if (random() < trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_MISC, 0, 1)) {
ADDRLP4 72
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 25
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 76
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 72
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 76
INDIRF4
GEF4 $600
line 934
;934:		BotAI_BotInitialChat(bs, "random_misc",
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 84
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRLP4 88
ADDRGP4 BotRandomWeaponName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $602
ARGP4
ADDRLP4 80
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 92
ADDRGP4 $283
ASGNP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRLP4 88
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 942
;935:					BotRandomOpponentName(bs),	// 0
;936:					name,						// 1
;937:					"[invalid var]",			// 2
;938:					"[invalid var]",			// 3
;939:					BotMapTitle(),				// 4
;940:					BotRandomWeaponName(),		// 5
;941:					NULL);
;942:	}
ADDRGP4 $601
JUMPV
LABELV $600
line 943
;943:	else {
line 944
;944:		BotAI_BotInitialChat(bs, "random_insult",
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 84
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRLP4 88
ADDRGP4 BotRandomWeaponName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $603
ARGP4
ADDRLP4 80
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 92
ADDRGP4 $283
ASGNP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRLP4 88
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 952
;945:					BotRandomOpponentName(bs),	// 0
;946:					name,						// 1
;947:					"[invalid var]",			// 2
;948:					"[invalid var]",			// 3
;949:					BotMapTitle(),				// 4
;950:					BotRandomWeaponName(),		// 5
;951:					NULL);
;952:	}
LABELV $601
line 953
;953:	bs->lastchat_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6100
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 954
;954:	bs->chatto = CHAT_ALL;
ADDRFP4 0
INDIRP4
CNSTI4 6052
ADDP4
CNSTI4 0
ASGNI4
line 955
;955:	return qtrue;
CNSTI4 1
RETI4
LABELV $567
endproc BotChat_Random 96 36
export BotChatTime
proc BotChatTime 8 16
line 963
;956:}
;957:
;958:/*
;959:==================
;960:BotChatTime
;961:==================
;962:*/
;963:float BotChatTime(bot_state_t *bs) {
line 966
;964:	int cpm;
;965:
;966:	cpm = trap_Characteristic_BInteger(bs->character, CHARACTERISTIC_CHAT_CPM, 1, 4000);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 23
ARGI4
CNSTI4 1
ARGI4
CNSTI4 4000
ARGI4
ADDRLP4 4
ADDRGP4 trap_Characteristic_BInteger
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 968
;967:
;968:	return 2.0;	//(float) trap_BotChatLength(bs->cs) * 30 / cpm;
CNSTF4 1073741824
RETF4
LABELV $604
endproc BotChatTime 8 16
export BotChatTest
proc BotChatTest 184 36
line 976
;969:}
;970:
;971:/*
;972:==================
;973:BotChatTest
;974:==================
;975:*/
;976:void BotChatTest(bot_state_t *bs) {
line 982
;977:
;978:	char name[32];
;979:	char *weap;
;980:	int num, i;
;981:
;982:	num = trap_BotNumInitialChats(bs->cs, "game_enter");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $282
ARGP4
ADDRLP4 44
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 44
INDIRI4
ASGNI4
line 983
;983:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $609
JUMPV
LABELV $606
line 984
;984:	{
line 985
;985:		BotAI_BotInitialChat(bs, "game_enter",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 48
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 56
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $282
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 $283
ASGNP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 56
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 992
;986:					EasyClientName(bs->client, name, 32),	// 0
;987:					BotRandomOpponentName(bs),				// 1
;988:					"[invalid var]",						// 2
;989:					"[invalid var]",						// 3
;990:					BotMapTitle(),							// 4
;991:					NULL);
;992:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 64
CNSTI4 0
ASGNI4
ADDRLP4 64
INDIRI4
ARGI4
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 993
;993:	}
LABELV $607
line 983
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $609
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $606
line 994
;994:	num = trap_BotNumInitialChats(bs->cs, "game_exit");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $301
ARGP4
ADDRLP4 48
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 48
INDIRI4
ASGNI4
line 995
;995:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $613
JUMPV
LABELV $610
line 996
;996:	{
line 997
;997:		BotAI_BotInitialChat(bs, "game_exit",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 52
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 60
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $301
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 $283
ASGNP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1004
;998:					EasyClientName(bs->client, name, 32),	// 0
;999:					BotRandomOpponentName(bs),				// 1
;1000:					"[invalid var]",						// 2
;1001:					"[invalid var]",						// 3
;1002:					BotMapTitle(),							// 4
;1003:					NULL);
;1004:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRLP4 68
INDIRI4
ARGI4
ADDRLP4 68
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1005
;1005:	}
LABELV $611
line 995
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $613
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $610
line 1006
;1006:	num = trap_BotNumInitialChats(bs->cs, "level_start");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $322
ARGP4
ADDRLP4 52
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 52
INDIRI4
ASGNI4
line 1007
;1007:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $617
JUMPV
LABELV $614
line 1008
;1008:	{
line 1009
;1009:		BotAI_BotInitialChat(bs, "level_start",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 56
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $322
ARGP4
ADDRLP4 56
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1012
;1010:					EasyClientName(bs->client, name, 32),	// 0
;1011:					NULL);
;1012:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1013
;1013:	}
LABELV $615
line 1007
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $617
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $614
line 1014
;1014:	num = trap_BotNumInitialChats(bs->cs, "level_end_victory");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $346
ARGP4
ADDRLP4 56
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 56
INDIRI4
ASGNI4
line 1015
;1015:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $621
JUMPV
LABELV $618
line 1016
;1016:	{
line 1017
;1017:		BotAI_BotInitialChat(bs, "level_end_victory",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 60
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 68
ADDRGP4 BotFirstClientInRankings
CALLP4
ASGNP4
ADDRLP4 72
ADDRGP4 BotLastClientInRankings
CALLP4
ASGNP4
ADDRLP4 76
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $346
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1024
;1018:				EasyClientName(bs->client, name, 32),	// 0
;1019:				BotRandomOpponentName(bs),				// 1
;1020:				BotFirstClientInRankings(),				// 2
;1021:				BotLastClientInRankings(),				// 3
;1022:				BotMapTitle(),							// 4
;1023:				NULL);
;1024:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 80
CNSTI4 0
ASGNI4
ADDRLP4 80
INDIRI4
ARGI4
ADDRLP4 80
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1025
;1025:	}
LABELV $619
line 1015
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $621
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $618
line 1026
;1026:	num = trap_BotNumInitialChats(bs->cs, "level_end_lose");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $349
ARGP4
ADDRLP4 60
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 60
INDIRI4
ASGNI4
line 1027
;1027:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $625
JUMPV
LABELV $622
line 1028
;1028:	{
line 1029
;1029:		BotAI_BotInitialChat(bs, "level_end_lose",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 64
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 72
ADDRGP4 BotFirstClientInRankings
CALLP4
ASGNP4
ADDRLP4 76
ADDRGP4 BotLastClientInRankings
CALLP4
ASGNP4
ADDRLP4 80
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $349
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 80
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1036
;1030:				EasyClientName(bs->client, name, 32),	// 0
;1031:				BotRandomOpponentName(bs),				// 1
;1032:				BotFirstClientInRankings(),				// 2
;1033:				BotLastClientInRankings(),				// 3
;1034:				BotMapTitle(),							// 4
;1035:				NULL);
;1036:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 84
CNSTI4 0
ASGNI4
ADDRLP4 84
INDIRI4
ARGI4
ADDRLP4 84
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1037
;1037:	}
LABELV $623
line 1027
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $625
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $622
line 1038
;1038:	num = trap_BotNumInitialChats(bs->cs, "level_end");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $350
ARGP4
ADDRLP4 64
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 64
INDIRI4
ASGNI4
line 1039
;1039:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $629
JUMPV
LABELV $626
line 1040
;1040:	{
line 1041
;1041:		BotAI_BotInitialChat(bs, "level_end",
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 68
ADDRGP4 EasyClientName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 76
ADDRGP4 BotFirstClientInRankings
CALLP4
ASGNP4
ADDRLP4 80
ADDRGP4 BotLastClientInRankings
CALLP4
ASGNP4
ADDRLP4 84
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $350
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 80
INDIRP4
ARGP4
ADDRLP4 84
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1048
;1042:				EasyClientName(bs->client, name, 32),	// 0
;1043:				BotRandomOpponentName(bs),				// 1
;1044:				BotFirstClientInRankings(),				// 2
;1045:				BotLastClientInRankings(),				// 3
;1046:				BotMapTitle(),							// 4
;1047:				NULL);
;1048:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 88
CNSTI4 0
ASGNI4
ADDRLP4 88
INDIRI4
ARGI4
ADDRLP4 88
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1049
;1049:	}
LABELV $627
line 1039
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $629
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $626
line 1050
;1050:	EasyClientName(bs->lastkilledby, name, sizeof(name));
ADDRFP4 0
INDIRP4
CNSTI4 5996
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 1051
;1051:	num = trap_BotNumInitialChats(bs->cs, "death_drown");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $378
ARGP4
ADDRLP4 68
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 68
INDIRI4
ASGNI4
line 1052
;1052:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $633
JUMPV
LABELV $630
line 1053
;1053:	{
line 1055
;1054:		//
;1055:		BotAI_BotInitialChat(bs, "death_drown", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $378
ARGP4
ADDRLP4 8
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1056
;1056:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
CNSTI4 0
ASGNI4
ADDRLP4 72
INDIRI4
ARGI4
ADDRLP4 72
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1057
;1057:	}
LABELV $631
line 1052
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $633
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $630
line 1058
;1058:	num = trap_BotNumInitialChats(bs->cs, "death_slime");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $381
ARGP4
ADDRLP4 72
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 72
INDIRI4
ASGNI4
line 1059
;1059:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $637
JUMPV
LABELV $634
line 1060
;1060:	{
line 1061
;1061:		BotAI_BotInitialChat(bs, "death_slime", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $381
ARGP4
ADDRLP4 8
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1062
;1062:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 76
CNSTI4 0
ASGNI4
ADDRLP4 76
INDIRI4
ARGI4
ADDRLP4 76
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1063
;1063:	}
LABELV $635
line 1059
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $637
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $634
line 1064
;1064:	num = trap_BotNumInitialChats(bs->cs, "death_lava");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $384
ARGP4
ADDRLP4 76
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 76
INDIRI4
ASGNI4
line 1065
;1065:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $641
JUMPV
LABELV $638
line 1066
;1066:	{
line 1067
;1067:		BotAI_BotInitialChat(bs, "death_lava", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $384
ARGP4
ADDRLP4 8
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1068
;1068:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 80
CNSTI4 0
ASGNI4
ADDRLP4 80
INDIRI4
ARGI4
ADDRLP4 80
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1069
;1069:	}
LABELV $639
line 1065
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $641
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $638
line 1070
;1070:	num = trap_BotNumInitialChats(bs->cs, "death_cratered");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $387
ARGP4
ADDRLP4 80
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 80
INDIRI4
ASGNI4
line 1071
;1071:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $645
JUMPV
LABELV $642
line 1072
;1072:	{
line 1073
;1073:		BotAI_BotInitialChat(bs, "death_cratered", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $387
ARGP4
ADDRLP4 8
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1074
;1074:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 84
CNSTI4 0
ASGNI4
ADDRLP4 84
INDIRI4
ARGI4
ADDRLP4 84
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1075
;1075:	}
LABELV $643
line 1071
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $645
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $642
line 1076
;1076:	num = trap_BotNumInitialChats(bs->cs, "death_suicide");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $395
ARGP4
ADDRLP4 84
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 84
INDIRI4
ASGNI4
line 1077
;1077:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $649
JUMPV
LABELV $646
line 1078
;1078:	{
line 1079
;1079:		BotAI_BotInitialChat(bs, "death_suicide", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $395
ARGP4
ADDRLP4 8
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1080
;1080:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 88
CNSTI4 0
ASGNI4
ADDRLP4 88
INDIRI4
ARGI4
ADDRLP4 88
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1081
;1081:	}
LABELV $647
line 1077
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $649
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $646
line 1082
;1082:	num = trap_BotNumInitialChats(bs->cs, "death_telefrag");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $398
ARGP4
ADDRLP4 88
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 88
INDIRI4
ASGNI4
line 1083
;1083:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $653
JUMPV
LABELV $650
line 1084
;1084:	{
line 1085
;1085:		BotAI_BotInitialChat(bs, "death_telefrag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $398
ARGP4
ADDRLP4 8
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1086
;1086:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 92
CNSTI4 0
ASGNI4
ADDRLP4 92
INDIRI4
ARGI4
ADDRLP4 92
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1087
;1087:	}
LABELV $651
line 1083
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $653
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $650
line 1088
;1088:	num = trap_BotNumInitialChats(bs->cs, "death_gauntlet");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $406
ARGP4
ADDRLP4 92
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 92
INDIRI4
ASGNI4
line 1089
;1089:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $657
JUMPV
LABELV $654
line 1090
;1090:	{
line 1091
;1091:		BotAI_BotInitialChat(bs, "death_gauntlet",
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
ARGI4
ADDRLP4 96
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $406
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 96
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1095
;1092:				name,												// 0
;1093:				BotWeaponNameForMeansOfDeath(bs->botdeathtype),		// 1
;1094:				NULL);
;1095:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 100
CNSTI4 0
ASGNI4
ADDRLP4 100
INDIRI4
ARGI4
ADDRLP4 100
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1096
;1096:	}
LABELV $655
line 1089
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $657
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $654
line 1097
;1097:	num = trap_BotNumInitialChats(bs->cs, "death_rail");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $409
ARGP4
ADDRLP4 96
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 96
INDIRI4
ASGNI4
line 1098
;1098:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $661
JUMPV
LABELV $658
line 1099
;1099:	{
line 1100
;1100:		BotAI_BotInitialChat(bs, "death_rail",
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
ARGI4
ADDRLP4 100
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $409
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 100
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1104
;1101:				name,												// 0
;1102:				BotWeaponNameForMeansOfDeath(bs->botdeathtype),		// 1
;1103:				NULL);
;1104:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 104
CNSTI4 0
ASGNI4
ADDRLP4 104
INDIRI4
ARGI4
ADDRLP4 104
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1105
;1105:	}
LABELV $659
line 1098
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $661
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $658
line 1106
;1106:	num = trap_BotNumInitialChats(bs->cs, "death_bfg");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $410
ARGP4
ADDRLP4 100
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 100
INDIRI4
ASGNI4
line 1107
;1107:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $665
JUMPV
LABELV $662
line 1108
;1108:	{
line 1109
;1109:		BotAI_BotInitialChat(bs, "death_bfg",
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
ARGI4
ADDRLP4 104
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $410
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 104
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1113
;1110:				name,												// 0
;1111:				BotWeaponNameForMeansOfDeath(bs->botdeathtype),		// 1
;1112:				NULL);
;1113:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 108
CNSTI4 0
ASGNI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1114
;1114:	}
LABELV $663
line 1107
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $665
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $662
line 1115
;1115:	num = trap_BotNumInitialChats(bs->cs, "death_insult");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $413
ARGP4
ADDRLP4 104
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 104
INDIRI4
ASGNI4
line 1116
;1116:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $669
JUMPV
LABELV $666
line 1117
;1117:	{
line 1118
;1118:		BotAI_BotInitialChat(bs, "death_insult",
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
ARGI4
ADDRLP4 108
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $413
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 108
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1122
;1119:					name,												// 0
;1120:					BotWeaponNameForMeansOfDeath(bs->botdeathtype),		// 1
;1121:					NULL);
;1122:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 112
CNSTI4 0
ASGNI4
ADDRLP4 112
INDIRI4
ARGI4
ADDRLP4 112
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1123
;1123:	}
LABELV $667
line 1116
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $669
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $666
line 1124
;1124:	num = trap_BotNumInitialChats(bs->cs, "death_praise");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $414
ARGP4
ADDRLP4 108
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 108
INDIRI4
ASGNI4
line 1125
;1125:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $673
JUMPV
LABELV $670
line 1126
;1126:	{
line 1127
;1127:		BotAI_BotInitialChat(bs, "death_praise",
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
INDIRI4
ARGI4
ADDRLP4 112
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $414
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 112
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1131
;1128:					name,												// 0
;1129:					BotWeaponNameForMeansOfDeath(bs->botdeathtype),		// 1
;1130:					NULL);
;1131:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 116
CNSTI4 0
ASGNI4
ADDRLP4 116
INDIRI4
ARGI4
ADDRLP4 116
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1132
;1132:	}
LABELV $671
line 1125
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $673
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $670
line 1134
;1133:	//
;1134:	EasyClientName(bs->lastkilledplayer, name, 32);
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 1136
;1135:	//
;1136:	num = trap_BotNumInitialChats(bs->cs, "kill_gauntlet");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $443
ARGP4
ADDRLP4 112
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 112
INDIRI4
ASGNI4
line 1137
;1137:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $677
JUMPV
LABELV $674
line 1138
;1138:	{
line 1140
;1139:		//
;1140:		BotAI_BotInitialChat(bs, "kill_gauntlet", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $443
ARGP4
ADDRLP4 8
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1141
;1141:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 116
CNSTI4 0
ASGNI4
ADDRLP4 116
INDIRI4
ARGI4
ADDRLP4 116
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1142
;1142:	}
LABELV $675
line 1137
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $677
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $674
line 1143
;1143:	num = trap_BotNumInitialChats(bs->cs, "kill_rail");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $446
ARGP4
ADDRLP4 116
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 116
INDIRI4
ASGNI4
line 1144
;1144:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $681
JUMPV
LABELV $678
line 1145
;1145:	{
line 1146
;1146:		BotAI_BotInitialChat(bs, "kill_rail", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $446
ARGP4
ADDRLP4 8
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1147
;1147:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 120
CNSTI4 0
ASGNI4
ADDRLP4 120
INDIRI4
ARGI4
ADDRLP4 120
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1148
;1148:	}
LABELV $679
line 1144
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $681
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $678
line 1149
;1149:	num = trap_BotNumInitialChats(bs->cs, "kill_telefrag");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $449
ARGP4
ADDRLP4 120
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 120
INDIRI4
ASGNI4
line 1150
;1150:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $685
JUMPV
LABELV $682
line 1151
;1151:	{
line 1152
;1152:		BotAI_BotInitialChat(bs, "kill_telefrag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $449
ARGP4
ADDRLP4 8
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1153
;1153:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 124
CNSTI4 0
ASGNI4
ADDRLP4 124
INDIRI4
ARGI4
ADDRLP4 124
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1154
;1154:	}
LABELV $683
line 1150
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $685
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $682
line 1155
;1155:	num = trap_BotNumInitialChats(bs->cs, "kill_insult");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $452
ARGP4
ADDRLP4 124
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 124
INDIRI4
ASGNI4
line 1156
;1156:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $689
JUMPV
LABELV $686
line 1157
;1157:	{
line 1158
;1158:		BotAI_BotInitialChat(bs, "kill_insult", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $452
ARGP4
ADDRLP4 8
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1159
;1159:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 128
CNSTI4 0
ASGNI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1160
;1160:	}
LABELV $687
line 1156
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $689
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $686
line 1161
;1161:	num = trap_BotNumInitialChats(bs->cs, "kill_praise");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $453
ARGP4
ADDRLP4 128
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 128
INDIRI4
ASGNI4
line 1162
;1162:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $693
JUMPV
LABELV $690
line 1163
;1163:	{
line 1164
;1164:		BotAI_BotInitialChat(bs, "kill_praise", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $453
ARGP4
ADDRLP4 8
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1165
;1165:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRLP4 132
INDIRI4
ARGI4
ADDRLP4 132
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1166
;1166:	}
LABELV $691
line 1162
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $693
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $690
line 1167
;1167:	num = trap_BotNumInitialChats(bs->cs, "enemy_suicide");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $478
ARGP4
ADDRLP4 132
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 132
INDIRI4
ASGNI4
line 1168
;1168:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $697
JUMPV
LABELV $694
line 1169
;1169:	{
line 1170
;1170:		BotAI_BotInitialChat(bs, "enemy_suicide", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $478
ARGP4
ADDRLP4 8
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1171
;1171:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 136
CNSTI4 0
ASGNI4
ADDRLP4 136
INDIRI4
ARGI4
ADDRLP4 136
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1172
;1172:	}
LABELV $695
line 1168
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $697
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $694
line 1173
;1173:	ClientName(g_entities[bs->client].client->lasthurt_client, name, sizeof(name));
CNSTI4 896
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 10324
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1174
;1174:	weap = BotWeaponNameForMeansOfDeath(g_entities[bs->client].client->lasthurt_client);
CNSTI4 896
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 10324
ADDP4
INDIRI4
ARGI4
ADDRLP4 136
ADDRGP4 BotWeaponNameForMeansOfDeath
CALLP4
ASGNP4
ADDRLP4 40
ADDRLP4 136
INDIRP4
ASGNP4
line 1175
;1175:	num = trap_BotNumInitialChats(bs->cs, "hit_talking");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $508
ARGP4
ADDRLP4 140
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 140
INDIRI4
ASGNI4
line 1176
;1176:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $703
JUMPV
LABELV $700
line 1177
;1177:	{
line 1178
;1178:		BotAI_BotInitialChat(bs, "hit_talking", name, weap, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $508
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1179
;1179:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 144
CNSTI4 0
ASGNI4
ADDRLP4 144
INDIRI4
ARGI4
ADDRLP4 144
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1180
;1180:	}
LABELV $701
line 1176
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $703
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $700
line 1181
;1181:	num = trap_BotNumInitialChats(bs->cs, "hit_nodeath");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $541
ARGP4
ADDRLP4 144
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 144
INDIRI4
ASGNI4
line 1182
;1182:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $707
JUMPV
LABELV $704
line 1183
;1183:	{
line 1184
;1184:		BotAI_BotInitialChat(bs, "hit_nodeath", name, weap, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $541
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1185
;1185:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 148
CNSTI4 0
ASGNI4
ADDRLP4 148
INDIRI4
ARGI4
ADDRLP4 148
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1186
;1186:	}
LABELV $705
line 1182
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $707
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $704
line 1187
;1187:	num = trap_BotNumInitialChats(bs->cs, "hit_nokill");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $566
ARGP4
ADDRLP4 148
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 148
INDIRI4
ASGNI4
line 1188
;1188:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $711
JUMPV
LABELV $708
line 1189
;1189:	{
line 1190
;1190:		BotAI_BotInitialChat(bs, "hit_nokill", name, weap, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $566
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1191
;1191:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 152
CNSTI4 0
ASGNI4
ADDRLP4 152
INDIRI4
ARGI4
ADDRLP4 152
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1192
;1192:	}
LABELV $709
line 1188
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $711
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $708
line 1194
;1193:	//
;1194:	if (bs->lastkilledplayer == bs->client) {
ADDRLP4 152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 152
INDIRP4
CNSTI4 5992
ADDP4
INDIRI4
ADDRLP4 152
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $712
line 1195
;1195:		strcpy(name, BotRandomOpponentName(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 156
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 8
ARGP4
ADDRLP4 156
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1196
;1196:	}
ADDRGP4 $713
JUMPV
LABELV $712
line 1197
;1197:	else {
line 1198
;1198:		EasyClientName(bs->lastkilledplayer, name, sizeof(name));
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 1199
;1199:	}
LABELV $713
line 1201
;1200:	//
;1201:	num = trap_BotNumInitialChats(bs->cs, "random_misc");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $602
ARGP4
ADDRLP4 156
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 156
INDIRI4
ASGNI4
line 1202
;1202:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $717
JUMPV
LABELV $714
line 1203
;1203:	{
line 1205
;1204:		//
;1205:		BotAI_BotInitialChat(bs, "random_misc",
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 160
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 164
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRLP4 168
ADDRGP4 BotRandomWeaponName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $602
ARGP4
ADDRLP4 160
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 172
ADDRGP4 $283
ASGNP4
ADDRLP4 172
INDIRP4
ARGP4
ADDRLP4 172
INDIRP4
ARGP4
ADDRLP4 164
INDIRP4
ARGP4
ADDRLP4 168
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1213
;1206:					BotRandomOpponentName(bs),	// 0
;1207:					name,						// 1
;1208:					"[invalid var]",			// 2
;1209:					"[invalid var]",			// 3
;1210:					BotMapTitle(),				// 4
;1211:					BotRandomWeaponName(),		// 5
;1212:					NULL);
;1213:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 176
CNSTI4 0
ASGNI4
ADDRLP4 176
INDIRI4
ARGI4
ADDRLP4 176
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1214
;1214:	}
LABELV $715
line 1202
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $717
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $714
line 1215
;1215:	num = trap_BotNumInitialChats(bs->cs, "random_insult");
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 $603
ARGP4
ADDRLP4 160
ADDRGP4 trap_BotNumInitialChats
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 160
INDIRI4
ASGNI4
line 1216
;1216:	for (i = 0; i < num; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $721
JUMPV
LABELV $718
line 1217
;1217:	{
line 1218
;1218:		BotAI_BotInitialChat(bs, "random_insult",
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 164
ADDRGP4 BotRandomOpponentName
CALLP4
ASGNP4
ADDRLP4 168
ADDRGP4 BotMapTitle
CALLP4
ASGNP4
ADDRLP4 172
ADDRGP4 BotRandomWeaponName
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $603
ARGP4
ADDRLP4 164
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 176
ADDRGP4 $283
ASGNP4
ADDRLP4 176
INDIRP4
ARGP4
ADDRLP4 176
INDIRP4
ARGP4
ADDRLP4 168
INDIRP4
ARGP4
ADDRLP4 172
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1226
;1219:					BotRandomOpponentName(bs),	// 0
;1220:					name,						// 1
;1221:					"[invalid var]",			// 2
;1222:					"[invalid var]",			// 3
;1223:					BotMapTitle(),				// 4
;1224:					BotRandomWeaponName(),		// 5
;1225:					NULL);
;1226:		trap_BotEnterChat(bs->cs, 0, CHAT_ALL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 180
CNSTI4 0
ASGNI4
ADDRLP4 180
INDIRI4
ARGI4
ADDRLP4 180
INDIRI4
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1227
;1227:	}
LABELV $719
line 1216
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $721
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $718
line 1228
;1228:}
LABELV $605
endproc BotChatTest 184 36
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
import BotTeamLeader
import BotAI_GetSnapshotEntity
import BotAI_GetEntityState
import BotAI_GetClientState
import BotAI_Trace
import BotAI_BotInitialChat
import BotAI_Print
import floattime
import BotEntityInfo
import NumBots
import BotResetState
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
LABELV $603
byte 1 114
byte 1 97
byte 1 110
byte 1 100
byte 1 111
byte 1 109
byte 1 95
byte 1 105
byte 1 110
byte 1 115
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $602
byte 1 114
byte 1 97
byte 1 110
byte 1 100
byte 1 111
byte 1 109
byte 1 95
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 0
align 1
LABELV $566
byte 1 104
byte 1 105
byte 1 116
byte 1 95
byte 1 110
byte 1 111
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $541
byte 1 104
byte 1 105
byte 1 116
byte 1 95
byte 1 110
byte 1 111
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $508
byte 1 104
byte 1 105
byte 1 116
byte 1 95
byte 1 116
byte 1 97
byte 1 108
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $478
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 95
byte 1 115
byte 1 117
byte 1 105
byte 1 99
byte 1 105
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $477
byte 1 0
align 1
LABELV $453
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 95
byte 1 112
byte 1 114
byte 1 97
byte 1 105
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $452
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 95
byte 1 105
byte 1 110
byte 1 115
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $449
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 95
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $446
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 95
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $443
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 95
byte 1 103
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $438
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 109
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $414
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 112
byte 1 114
byte 1 97
byte 1 105
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $413
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 105
byte 1 110
byte 1 115
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $410
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 98
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $409
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $406
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 103
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $398
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $395
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 115
byte 1 117
byte 1 105
byte 1 99
byte 1 105
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $387
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 99
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $384
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 108
byte 1 97
byte 1 118
byte 1 97
byte 1 0
align 1
LABELV $381
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 115
byte 1 108
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $378
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 100
byte 1 114
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $373
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 109
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $368
byte 1 91
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 93
byte 1 0
align 1
LABELV $350
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 95
byte 1 101
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $349
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 95
byte 1 101
byte 1 110
byte 1 100
byte 1 95
byte 1 108
byte 1 111
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $346
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 95
byte 1 101
byte 1 110
byte 1 100
byte 1 95
byte 1 118
byte 1 105
byte 1 99
byte 1 116
byte 1 111
byte 1 114
byte 1 121
byte 1 0
align 1
LABELV $322
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $312
byte 1 118
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $301
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 95
byte 1 101
byte 1 120
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $283
byte 1 91
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 118
byte 1 97
byte 1 114
byte 1 93
byte 1 0
align 1
LABELV $282
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 95
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $209
byte 1 91
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 93
byte 1 0
align 1
LABELV $208
byte 1 71
byte 1 114
byte 1 97
byte 1 112
byte 1 112
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $206
byte 1 66
byte 1 70
byte 1 71
byte 1 49
byte 1 48
byte 1 75
byte 1 0
align 1
LABELV $204
byte 1 76
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 71
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $202
byte 1 82
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $200
byte 1 80
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $198
byte 1 82
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 32
byte 1 76
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $196
byte 1 71
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 76
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $194
byte 1 77
byte 1 97
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 101
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $192
byte 1 71
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $190
byte 1 83
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $184
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $83
byte 1 116
byte 1 0
align 1
LABELV $79
byte 1 110
byte 1 0
align 1
LABELV $72
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
