bss
align 1
LABELV $78
skip 64
export CG_PlaceString
code
proc CG_PlaceString 12 20
file "../cg_event.c"
line 20
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_event.c -- handle entity events at snapshot or playerstate transitions
;4:
;5:#include "cg_local.h"
;6:
;7:// for the voice chats
;8:#ifdef MISSIONPACK // bk001205
;9:#include "../../ui/menudef.h"
;10:#endif
;11://==========================================================================
;12:
;13:/*
;14:===================
;15:CG_PlaceString
;16:
;17:Also called by scoreboard drawing
;18:===================
;19:*/
;20:const char	*CG_PlaceString( int rank ) {
line 24
;21:	static char	str[64];
;22:	char	*s, *t;
;23:
;24:	if ( rank & RANK_TIED_FLAG ) {
ADDRFP4 0
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $79
line 25
;25:		rank &= ~RANK_TIED_FLAG;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -16385
BANDI4
ASGNI4
line 26
;26:		t = "Tied for ";
ADDRLP4 4
ADDRGP4 $81
ASGNP4
line 27
;27:	} else {
ADDRGP4 $80
JUMPV
LABELV $79
line 28
;28:		t = "";
ADDRLP4 4
ADDRGP4 $82
ASGNP4
line 29
;29:	}
LABELV $80
line 31
;30:
;31:	if ( rank == 1 ) {
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $83
line 32
;32:		s = S_COLOR_BLUE "1st" S_COLOR_WHITE;		// draw in blue
ADDRLP4 0
ADDRGP4 $85
ASGNP4
line 33
;33:	} else if ( rank == 2 ) {
ADDRGP4 $84
JUMPV
LABELV $83
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $86
line 34
;34:		s = S_COLOR_RED "2nd" S_COLOR_WHITE;		// draw in red
ADDRLP4 0
ADDRGP4 $88
ASGNP4
line 35
;35:	} else if ( rank == 3 ) {
ADDRGP4 $87
JUMPV
LABELV $86
ADDRFP4 0
INDIRI4
CNSTI4 3
NEI4 $89
line 36
;36:		s = S_COLOR_YELLOW "3rd" S_COLOR_WHITE;		// draw in yellow
ADDRLP4 0
ADDRGP4 $91
ASGNP4
line 37
;37:	} else if ( rank == 11 ) {
ADDRGP4 $90
JUMPV
LABELV $89
ADDRFP4 0
INDIRI4
CNSTI4 11
NEI4 $92
line 38
;38:		s = "11th";
ADDRLP4 0
ADDRGP4 $94
ASGNP4
line 39
;39:	} else if ( rank == 12 ) {
ADDRGP4 $93
JUMPV
LABELV $92
ADDRFP4 0
INDIRI4
CNSTI4 12
NEI4 $95
line 40
;40:		s = "12th";
ADDRLP4 0
ADDRGP4 $97
ASGNP4
line 41
;41:	} else if ( rank == 13 ) {
ADDRGP4 $96
JUMPV
LABELV $95
ADDRFP4 0
INDIRI4
CNSTI4 13
NEI4 $98
line 42
;42:		s = "13th";
ADDRLP4 0
ADDRGP4 $100
ASGNP4
line 43
;43:	} else if ( rank % 10 == 1 ) {
ADDRGP4 $99
JUMPV
LABELV $98
ADDRFP4 0
INDIRI4
CNSTI4 10
MODI4
CNSTI4 1
NEI4 $101
line 44
;44:		s = va("%ist", rank);
ADDRGP4 $103
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 45
;45:	} else if ( rank % 10 == 2 ) {
ADDRGP4 $102
JUMPV
LABELV $101
ADDRFP4 0
INDIRI4
CNSTI4 10
MODI4
CNSTI4 2
NEI4 $104
line 46
;46:		s = va("%ind", rank);
ADDRGP4 $106
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 47
;47:	} else if ( rank % 10 == 3 ) {
ADDRGP4 $105
JUMPV
LABELV $104
ADDRFP4 0
INDIRI4
CNSTI4 10
MODI4
CNSTI4 3
NEI4 $107
line 48
;48:		s = va("%ird", rank);
ADDRGP4 $109
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 49
;49:	} else {
ADDRGP4 $108
JUMPV
LABELV $107
line 50
;50:		s = va("%ith", rank);
ADDRGP4 $110
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 51
;51:	}
LABELV $108
LABELV $105
LABELV $102
LABELV $99
LABELV $96
LABELV $93
LABELV $90
LABELV $87
LABELV $84
line 53
;52:
;53:	Com_sprintf( str, sizeof( str ), "%s%s", t, s );
ADDRGP4 $78
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $111
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 54
;54:	return str;
ADDRGP4 $78
RETP4
LABELV $77
endproc CG_PlaceString 12 20
proc CG_Obituary 224 20
line 62
;55:}
;56:
;57:/*
;58:=============
;59:CG_Obituary
;60:=============
;61:*/
;62:static void CG_Obituary( entityState_t *ent ) {
line 74
;63:	int			mod;
;64:	int			target, attacker;
;65:	char		*message;
;66:	char		*message2;
;67:	const char	*targetInfo;
;68:	const char	*attackerInfo;
;69:	char		targetName[64];
;70:	char		attackerName[64];
;71:	gender_t	gender;
;72:	clientInfo_t	*ci;
;73:
;74:	target = ent->otherEntityNum;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 75
;75:	attacker = ent->otherEntityNum2;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
line 76
;76:	mod = ent->eventParm;
ADDRLP4 80
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 78
;77:
;78:	if ( target < 0 || target >= MAX_CLIENTS ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $115
ADDRLP4 4
INDIRI4
CNSTI4 64
LTI4 $113
LABELV $115
line 79
;79:		CG_Error( "CG_Obituary: target out of range" );
ADDRGP4 $116
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 80
;80:	}
LABELV $113
line 81
;81:	ci = &cgs.clientinfo[target];
ADDRLP4 72
CNSTI4 1776
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cgs+40960
ADDP4
ASGNP4
line 84
;82:	
;83:	
;84:	if ( ci->sex[0] == 'f' || ci->sex[0] == 'F' ) {
ADDRLP4 168
ADDRLP4 72
INDIRP4
CNSTI4 188
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 102
EQI4 $120
ADDRLP4 168
INDIRI4
CNSTI4 70
NEI4 $118
LABELV $120
line 86
;85:		//CG_Printf("female\n");
;86:		gender = GENDER_FEMALE;
ADDRLP4 160
CNSTI4 1
ASGNI4
line 87
;87:	} else if ( ci->sex[0] == 'm' || ci->sex[0] == 'M' ) {
ADDRGP4 $119
JUMPV
LABELV $118
ADDRLP4 172
ADDRLP4 72
INDIRP4
CNSTI4 188
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 109
EQI4 $123
ADDRLP4 172
INDIRI4
CNSTI4 77
NEI4 $121
LABELV $123
line 89
;88:		//CG_Printf("male\n");
;89:		gender = GENDER_MALE;
ADDRLP4 160
CNSTI4 0
ASGNI4
line 90
;90:	} else if ( ci->sex[0] == 'n' || ci->sex[0] == 'N' ) {
ADDRGP4 $122
JUMPV
LABELV $121
ADDRLP4 176
ADDRLP4 72
INDIRP4
CNSTI4 188
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 110
EQI4 $126
ADDRLP4 176
INDIRI4
CNSTI4 78
NEI4 $124
LABELV $126
line 92
;91:		//CG_Printf("neuter\n");
;92:		gender = GENDER_NEUTER;
ADDRLP4 160
CNSTI4 2
ASGNI4
line 93
;93:	} else {
ADDRGP4 $125
JUMPV
LABELV $124
line 94
;94:		gender = ci->gender;
ADDRLP4 160
ADDRLP4 72
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
ASGNI4
line 95
;95:	}
LABELV $125
LABELV $122
LABELV $119
line 97
;96:
;97:	if ( attacker < 0 || attacker >= MAX_CLIENTS ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $129
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $127
LABELV $129
line 98
;98:		attacker = ENTITYNUM_WORLD;
ADDRLP4 0
CNSTI4 1022
ASGNI4
line 99
;99:		attackerInfo = NULL;
ADDRLP4 88
CNSTP4 0
ASGNP4
line 100
;100:	} else {
ADDRGP4 $128
JUMPV
LABELV $127
line 101
;101:		attackerInfo = CG_ConfigString( CS_PLAYERS + attacker );
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 184
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 88
ADDRLP4 184
INDIRP4
ASGNP4
line 102
;102:	}
LABELV $128
line 104
;103:
;104:	targetInfo = CG_ConfigString( CS_PLAYERS + target );
ADDRLP4 4
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 184
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 84
ADDRLP4 184
INDIRP4
ASGNP4
line 105
;105:	if ( !targetInfo ) {
ADDRLP4 84
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $130
line 106
;106:		return;
ADDRGP4 $112
JUMPV
LABELV $130
line 108
;107:	}
;108:	Q_strncpyz( targetName, Info_ValueForKey( targetInfo, "n" ), sizeof(targetName) - 2);
ADDRLP4 84
INDIRP4
ARGP4
ADDRGP4 $132
ARGP4
ADDRLP4 188
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
ARGP4
ADDRLP4 188
INDIRP4
ARGP4
CNSTI4 62
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 109
;109:	strcat( targetName, S_COLOR_WHITE );
ADDRLP4 8
ARGP4
ADDRGP4 $133
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 111
;110:
;111:	message2 = "";
ADDRLP4 156
ADDRGP4 $82
ASGNP4
line 115
;112:
;113:	// check for single client messages
;114:
;115:	switch( mod ) {
ADDRLP4 196
CNSTI4 0
ASGNI4
ADDRLP4 80
INDIRI4
ADDRLP4 196
INDIRI4
EQI4 $152
ADDRLP4 80
INDIRI4
ADDRLP4 196
INDIRI4
LTI4 $134
LABELV $153
ADDRLP4 80
INDIRI4
CNSTI4 14
LTI4 $134
ADDRLP4 80
INDIRI4
CNSTI4 22
GTI4 $134
ADDRLP4 80
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $154-56
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $154
address $142
address $144
address $146
address $140
address $134
address $138
address $136
address $148
address $150
code
LABELV $136
line 117
;116:	case MOD_SUICIDE:
;117:		message = "suicides";
ADDRLP4 76
ADDRGP4 $137
ASGNP4
line 118
;118:		break;
ADDRGP4 $135
JUMPV
LABELV $138
line 120
;119:	case MOD_FALLING:
;120:		message = "cratered";
ADDRLP4 76
ADDRGP4 $139
ASGNP4
line 121
;121:		break;
ADDRGP4 $135
JUMPV
LABELV $140
line 123
;122:	case MOD_CRUSH:
;123:		message = "was squished";
ADDRLP4 76
ADDRGP4 $141
ASGNP4
line 124
;124:		break;
ADDRGP4 $135
JUMPV
LABELV $142
line 126
;125:	case MOD_WATER:
;126:		message = "sank like a rock";
ADDRLP4 76
ADDRGP4 $143
ASGNP4
line 127
;127:		break;
ADDRGP4 $135
JUMPV
LABELV $144
line 129
;128:	case MOD_SLIME:
;129:		message = "melted";
ADDRLP4 76
ADDRGP4 $145
ASGNP4
line 130
;130:		break;
ADDRGP4 $135
JUMPV
LABELV $146
line 132
;131:	case MOD_LAVA:
;132:		message = "does a back flip into the lava";
ADDRLP4 76
ADDRGP4 $147
ASGNP4
line 133
;133:		break;
ADDRGP4 $135
JUMPV
LABELV $148
line 135
;134:	case MOD_TARGET_LASER:
;135:		message = "saw the light";
ADDRLP4 76
ADDRGP4 $149
ASGNP4
line 136
;136:		break;
ADDRGP4 $135
JUMPV
LABELV $150
line 138
;137:	case MOD_TRIGGER_HURT:
;138:		message = "was in the wrong place";
ADDRLP4 76
ADDRGP4 $151
ASGNP4
line 139
;139:		break;
ADDRGP4 $135
JUMPV
LABELV $152
line 142
;140://freeze
;141:	case MOD_UNKNOWN:
;142:		CG_BodyObituary( ent, targetName );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 CG_BodyObituary
CALLV
pop
line 143
;143:		return;
ADDRGP4 $112
JUMPV
LABELV $134
line 146
;144://freeze
;145:	default:
;146:		message = NULL;
ADDRLP4 76
CNSTP4 0
ASGNP4
line 147
;147:		break;
LABELV $135
line 150
;148:	}
;149:
;150:	if (attacker == target) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $156
line 152
;151:		//gender = ci->gender;
;152:		switch (mod) {
ADDRLP4 208
CNSTI4 5
ASGNI4
ADDRLP4 80
INDIRI4
ADDRLP4 208
INDIRI4
EQI4 $160
ADDRLP4 80
INDIRI4
CNSTI4 7
EQI4 $168
ADDRLP4 80
INDIRI4
CNSTI4 9
EQI4 $176
ADDRLP4 80
INDIRI4
ADDRLP4 208
INDIRI4
LTI4 $158
LABELV $193
ADDRLP4 80
INDIRI4
CNSTI4 13
EQI4 $184
ADDRGP4 $158
JUMPV
LABELV $160
line 159
;153:#ifdef MISSIONPACK
;154:		case MOD_KAMIKAZE:
;155:			message = "goes out with a bang";
;156:			break;
;157:#endif
;158:		case MOD_GRENADE_SPLASH:
;159:			if ( gender == GENDER_FEMALE )
ADDRLP4 160
INDIRI4
CNSTI4 1
NEI4 $161
line 160
;160:				message = "tripped on her own grenade";
ADDRLP4 76
ADDRGP4 $163
ASGNP4
ADDRGP4 $159
JUMPV
LABELV $161
line 161
;161:			else if ( gender == GENDER_NEUTER )
ADDRLP4 160
INDIRI4
CNSTI4 2
NEI4 $164
line 162
;162:				message = "tripped on its own grenade";
ADDRLP4 76
ADDRGP4 $166
ASGNP4
ADDRGP4 $159
JUMPV
LABELV $164
line 164
;163:			else
;164:				message = "tripped on his own grenade";
ADDRLP4 76
ADDRGP4 $167
ASGNP4
line 165
;165:			break;
ADDRGP4 $159
JUMPV
LABELV $168
line 167
;166:		case MOD_ROCKET_SPLASH:
;167:			if ( gender == GENDER_FEMALE )
ADDRLP4 160
INDIRI4
CNSTI4 1
NEI4 $169
line 168
;168:				message = "blew herself up";
ADDRLP4 76
ADDRGP4 $171
ASGNP4
ADDRGP4 $159
JUMPV
LABELV $169
line 169
;169:			else if ( gender == GENDER_NEUTER )
ADDRLP4 160
INDIRI4
CNSTI4 2
NEI4 $172
line 170
;170:				message = "blew itself up";
ADDRLP4 76
ADDRGP4 $174
ASGNP4
ADDRGP4 $159
JUMPV
LABELV $172
line 172
;171:			else
;172:				message = "blew himself up";
ADDRLP4 76
ADDRGP4 $175
ASGNP4
line 173
;173:			break;
ADDRGP4 $159
JUMPV
LABELV $176
line 175
;174:		case MOD_PLASMA_SPLASH:
;175:			if ( gender == GENDER_FEMALE )
ADDRLP4 160
INDIRI4
CNSTI4 1
NEI4 $177
line 176
;176:				message = "melted herself";
ADDRLP4 76
ADDRGP4 $179
ASGNP4
ADDRGP4 $159
JUMPV
LABELV $177
line 177
;177:			else if ( gender == GENDER_NEUTER )
ADDRLP4 160
INDIRI4
CNSTI4 2
NEI4 $180
line 178
;178:				message = "melted itself";
ADDRLP4 76
ADDRGP4 $182
ASGNP4
ADDRGP4 $159
JUMPV
LABELV $180
line 180
;179:			else
;180:				message = "melted himself";
ADDRLP4 76
ADDRGP4 $183
ASGNP4
line 181
;181:			break;
ADDRGP4 $159
JUMPV
LABELV $184
line 183
;182:		case MOD_BFG_SPLASH:
;183:			message = "should have used a smaller gun";
ADDRLP4 76
ADDRGP4 $185
ASGNP4
line 184
;184:			break;
ADDRGP4 $159
JUMPV
LABELV $158
line 197
;185:#ifdef MISSIONPACK
;186:		case MOD_PROXIMITY_MINE:
;187:			if( gender == GENDER_FEMALE ) {
;188:				message = "found her prox mine";
;189:			} else if ( gender == GENDER_NEUTER ) {
;190:				message = "found it's prox mine";
;191:			} else {
;192:				message = "found his prox mine";
;193:			}
;194:			break;
;195:#endif
;196:		default:
;197:			if ( gender == GENDER_FEMALE )
ADDRLP4 160
INDIRI4
CNSTI4 1
NEI4 $186
line 198
;198:				message = "killed herself";
ADDRLP4 76
ADDRGP4 $188
ASGNP4
ADDRGP4 $159
JUMPV
LABELV $186
line 199
;199:			else if ( gender == GENDER_NEUTER )
ADDRLP4 160
INDIRI4
CNSTI4 2
NEI4 $189
line 200
;200:				message = "killed itself";
ADDRLP4 76
ADDRGP4 $191
ASGNP4
ADDRGP4 $159
JUMPV
LABELV $189
line 202
;201:			else
;202:				message = "killed himself";
ADDRLP4 76
ADDRGP4 $192
ASGNP4
line 203
;203:			break;
LABELV $159
line 205
;204:		}
;205:	}
LABELV $156
line 207
;206:
;207:	if (message) {
ADDRLP4 76
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $194
line 208
;208:		CG_Printf( "%s %s.\n", targetName, message);
ADDRGP4 $196
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 209
;209:		return;
ADDRGP4 $112
JUMPV
LABELV $194
line 213
;210:	}
;211:
;212:	// check for kill messages from the current clientNum
;213:	if ( attacker == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $197
line 217
;214:		char	*s;
;215:		//int		divideBy;
;216:		//cg_drawDeathMessage.integer==2?(divideBy = 2):(divideBy = 1);
;217:		if ( hud_count && strlen(ch_file.string) ) {
ADDRGP4 hud_count
INDIRI4
CNSTI4 0
EQI4 $200
ADDRGP4 ch_file+16
ARGP4
ADDRLP4 208
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 208
INDIRI4
CNSTI4 0
EQI4 $200
line 219
;218:			//FragMessage
;219:			memset(cg.fragMessageChar, 0, sizeof(cg.fragMessageChar) );
ADDRGP4 cg+170320
ARGP4
CNSTI4 0
ARGI4
CNSTI4 128
ARGI4
ADDRGP4 memset
CALLP4
pop
line 220
;220:			s = va("You fragged %s", targetName );
ADDRGP4 $205
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 212
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 204
ADDRLP4 212
INDIRP4
ASGNP4
line 221
;221:			Com_sprintf(cg.fragMessageChar, sizeof(cg.fragMessageChar), "%s", s);
ADDRGP4 cg+170320
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $208
ARGP4
ADDRLP4 204
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 222
;222:			cg.fragMessageTime = cg.time;
ADDRGP4 cg+170316
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 224
;223:			//RankMessage
;224:			if ( cgs.gametype < GT_TEAM ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
GEI4 $201
line 225
;225:				memset(cg.rankMessageChar, 0, sizeof(cg.rankMessageChar) );
ADDRGP4 cg+170452
ARGP4
CNSTI4 0
ARGI4
CNSTI4 128
ARGI4
ADDRGP4 memset
CALLP4
pop
line 226
;226:				s = va("%s place with %i", CG_PlaceString( cg.snap->ps.persistant[PERS_RANK] + 1 ), cg.snap->ps.persistant[PERS_SCORE] );
ADDRGP4 cg+36
INDIRP4
CNSTI4 300
ADDP4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 216
ADDRGP4 CG_PlaceString
CALLP4
ASGNP4
ADDRGP4 $216
ARGP4
ADDRLP4 216
INDIRP4
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ARGI4
ADDRLP4 220
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 204
ADDRLP4 220
INDIRP4
ASGNP4
line 227
;227:				Com_sprintf(cg.rankMessageChar, sizeof(cg.rankMessageChar), "%s", s);
ADDRGP4 cg+170452
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $208
ARGP4
ADDRLP4 204
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 228
;228:				cg.rankMessageTime = cg.time;
ADDRGP4 cg+170448
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 229
;229:			}
line 230
;230:        } else if ( cgs.gametype < GT_TEAM && !cg.scoreBoardShowing ) {
ADDRGP4 $201
JUMPV
LABELV $200
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
GEI4 $223
ADDRGP4 cg+120472
INDIRI4
CNSTI4 0
NEI4 $223
line 231
;231:			s = va("You fragged %s\n%s place with %i", targetName, 
ADDRGP4 cg+36
INDIRP4
CNSTI4 300
ADDP4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 212
ADDRGP4 CG_PlaceString
CALLP4
ASGNP4
ADDRGP4 $227
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 212
INDIRP4
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ARGI4
ADDRLP4 216
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 204
ADDRLP4 216
INDIRP4
ASGNP4
line 234
;232:				CG_PlaceString( cg.snap->ps.persistant[PERS_RANK] + 1 ),
;233:				cg.snap->ps.persistant[PERS_SCORE] );
;234:		} else {
ADDRGP4 $224
JUMPV
LABELV $223
line 235
;235:			s = va("You fragged %s", targetName );
ADDRGP4 $205
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 212
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 204
ADDRLP4 212
INDIRP4
ASGNP4
line 236
;236:		}
LABELV $224
LABELV $201
line 244
;237:#ifdef MISSIONPACK
;238:		if (!(cg_singlePlayerActive.integer && cg_cameraOrbit.integer)) {
;239:			if ( cg_drawDeathMessage.integer ) {
;240:				CG_CenterPrint( s, SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH );
;241:			}
;242:		} 
;243:#else
;244:		if ( cg_drawDeathMessage.integer && !(hud_count && strlen(ch_file.string)) ) {
ADDRLP4 212
CNSTI4 0
ASGNI4
ADDRGP4 cg_drawDeathMessage+12
INDIRI4
ADDRLP4 212
INDIRI4
EQI4 $230
ADDRGP4 hud_count
INDIRI4
ADDRLP4 212
INDIRI4
EQI4 $234
ADDRGP4 ch_file+16
ARGP4
ADDRLP4 216
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 216
INDIRI4
CNSTI4 0
NEI4 $230
LABELV $234
line 245
;245:			CG_CenterPrint( s, SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH );
ADDRLP4 204
INDIRP4
ARGP4
CNSTI4 144
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 246
;246:		}
LABELV $230
line 250
;247:#endif
;248:
;249:		// print the text message as well
;250:	}
LABELV $197
line 253
;251:
;252:	// check for double client messages
;253:	if ( !attackerInfo ) {
ADDRLP4 88
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $235
line 254
;254:		attacker = ENTITYNUM_WORLD;
ADDRLP4 0
CNSTI4 1022
ASGNI4
line 255
;255:		strcpy( attackerName, "noname" );
ADDRLP4 92
ARGP4
ADDRGP4 $237
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 256
;256:	} else {
ADDRGP4 $236
JUMPV
LABELV $235
line 257
;257:		Q_strncpyz( attackerName, Info_ValueForKey( attackerInfo, "n" ), sizeof(attackerName) - 2);
ADDRLP4 88
INDIRP4
ARGP4
ADDRGP4 $132
ARGP4
ADDRLP4 204
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 92
ARGP4
ADDRLP4 204
INDIRP4
ARGP4
CNSTI4 62
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 258
;258:		strcat( attackerName, S_COLOR_WHITE );
ADDRLP4 92
ARGP4
ADDRGP4 $133
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 260
;259:		// check for kill messages about the current clientNum
;260:		if ( target == cg.snap->ps.clientNum ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $238
line 261
;261:			Q_strncpyz( cg.killerName, attackerName, sizeof( cg.killerName ) );
ADDRGP4 cg+120480
ARGP4
ADDRLP4 92
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 262
;262:		}
LABELV $238
line 263
;263:	}
LABELV $236
line 265
;264:
;265:	if ( attacker != ENTITYNUM_WORLD ) {
ADDRLP4 0
INDIRI4
CNSTI4 1022
EQI4 $243
line 266
;266:		switch (mod) {
ADDRLP4 80
INDIRI4
CNSTI4 1
LTI4 $245
ADDRLP4 80
INDIRI4
CNSTI4 23
GTI4 $245
ADDRLP4 80
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $280-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $280
address $253
address $249
address $251
address $255
address $258
address $261
address $263
address $265
address $268
address $269
address $271
address $273
address $273
address $245
address $245
address $245
address $245
address $276
address $245
address $245
address $245
address $245
address $247
code
LABELV $247
line 268
;267:		case MOD_GRAPPLE:
;268:			message = "was caught by";
ADDRLP4 76
ADDRGP4 $248
ASGNP4
line 269
;269:			break;
ADDRGP4 $246
JUMPV
LABELV $249
line 271
;270:		case MOD_GAUNTLET:
;271:			message = "was pummeled by";
ADDRLP4 76
ADDRGP4 $250
ASGNP4
line 272
;272:			break;
ADDRGP4 $246
JUMPV
LABELV $251
line 274
;273:		case MOD_MACHINEGUN:
;274:			message = "was machinegunned by";
ADDRLP4 76
ADDRGP4 $252
ASGNP4
line 275
;275:			break;
ADDRGP4 $246
JUMPV
LABELV $253
line 277
;276:		case MOD_SHOTGUN:
;277:			message = "was gunned down by";
ADDRLP4 76
ADDRGP4 $254
ASGNP4
line 278
;278:			break;
ADDRGP4 $246
JUMPV
LABELV $255
line 280
;279:		case MOD_GRENADE:
;280:			message = "ate";
ADDRLP4 76
ADDRGP4 $256
ASGNP4
line 281
;281:			message2 = "'s grenade";
ADDRLP4 156
ADDRGP4 $257
ASGNP4
line 282
;282:			break;
ADDRGP4 $246
JUMPV
LABELV $258
line 284
;283:		case MOD_GRENADE_SPLASH:
;284:			message = "was shredded by";
ADDRLP4 76
ADDRGP4 $259
ASGNP4
line 285
;285:			message2 = "'s shrapnel";
ADDRLP4 156
ADDRGP4 $260
ASGNP4
line 286
;286:			break;
ADDRGP4 $246
JUMPV
LABELV $261
line 288
;287:		case MOD_ROCKET:
;288:			message = "ate";
ADDRLP4 76
ADDRGP4 $256
ASGNP4
line 289
;289:			message2 = "'s rocket";
ADDRLP4 156
ADDRGP4 $262
ASGNP4
line 290
;290:			break;
ADDRGP4 $246
JUMPV
LABELV $263
line 292
;291:		case MOD_ROCKET_SPLASH:
;292:			message = "almost dodged";
ADDRLP4 76
ADDRGP4 $264
ASGNP4
line 293
;293:			message2 = "'s rocket";
ADDRLP4 156
ADDRGP4 $262
ASGNP4
line 294
;294:			break;
ADDRGP4 $246
JUMPV
LABELV $265
line 296
;295:		case MOD_PLASMA:
;296:			message = "was melted by";
ADDRLP4 76
ADDRGP4 $266
ASGNP4
line 297
;297:			message2 = "'s plasmagun";
ADDRLP4 156
ADDRGP4 $267
ASGNP4
line 298
;298:			break;
ADDRGP4 $246
JUMPV
LABELV $268
line 300
;299:		case MOD_PLASMA_SPLASH:
;300:			message = "was melted by";
ADDRLP4 76
ADDRGP4 $266
ASGNP4
line 301
;301:			message2 = "'s plasmagun";
ADDRLP4 156
ADDRGP4 $267
ASGNP4
line 302
;302:			break;
ADDRGP4 $246
JUMPV
LABELV $269
line 304
;303:		case MOD_RAILGUN:
;304:			message = "was railed by";
ADDRLP4 76
ADDRGP4 $270
ASGNP4
line 305
;305:			break;
ADDRGP4 $246
JUMPV
LABELV $271
line 307
;306:		case MOD_LIGHTNING:
;307:			message = "was electrocuted by";
ADDRLP4 76
ADDRGP4 $272
ASGNP4
line 308
;308:			break;
ADDRGP4 $246
JUMPV
LABELV $273
line 311
;309:		case MOD_BFG:
;310:		case MOD_BFG_SPLASH:
;311:			message = "was blasted by";
ADDRLP4 76
ADDRGP4 $274
ASGNP4
line 312
;312:			message2 = "'s BFG";
ADDRLP4 156
ADDRGP4 $275
ASGNP4
line 313
;313:			break;
ADDRGP4 $246
JUMPV
LABELV $276
line 335
;314:#ifdef MISSIONPACK
;315:		case MOD_NAIL:
;316:			message = "was nailed by";
;317:			break;
;318:		case MOD_CHAINGUN:
;319:			message = "got lead poisoning from";
;320:			message2 = "'s Chaingun";
;321:			break;
;322:		case MOD_PROXIMITY_MINE:
;323:			message = "was too close to";
;324:			message2 = "'s Prox Mine";
;325:			break;
;326:		case MOD_KAMIKAZE:
;327:			message = "falls to";
;328:			message2 = "'s Kamikaze blast";
;329:			break;
;330:		case MOD_JUICED:
;331:			message = "was juiced by";
;332:			break;
;333:#endif
;334:		case MOD_TELEFRAG:
;335:			message = "tried to invade";
ADDRLP4 76
ADDRGP4 $277
ASGNP4
line 336
;336:			message2 = "'s personal space";
ADDRLP4 156
ADDRGP4 $278
ASGNP4
line 337
;337:			break;
ADDRGP4 $246
JUMPV
LABELV $245
line 339
;338:		default:
;339:			message = "was killed by";
ADDRLP4 76
ADDRGP4 $279
ASGNP4
line 340
;340:			break;
LABELV $246
line 343
;341:		}
;342:
;343:		if (message) {
ADDRLP4 76
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $282
line 344
;344:			CG_Printf( "%s %s %s%s\n", 
ADDRGP4 $284
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 92
ARGP4
ADDRLP4 156
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 346
;345:				targetName, message, attackerName, message2);
;346:			return;
ADDRGP4 $112
JUMPV
LABELV $282
line 348
;347:		}
;348:	}
LABELV $243
line 351
;349:
;350:	// we don't know what it was
;351:	CG_Printf( "%s died.\n", targetName );
ADDRGP4 $285
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 352
;352:}
LABELV $112
endproc CG_Obituary 224 20
proc CG_UseItem 32 16
line 361
;353:
;354://==========================================================================
;355:
;356:/*
;357:===============
;358:CG_UseItem
;359:===============
;360:*/
;361:static void CG_UseItem( centity_t *cent ) {
line 367
;362:	clientInfo_t *ci;
;363:	int			itemNum, clientNum;
;364:	gitem_t		*item;
;365:	entityState_t *es;
;366:
;367:	es = &cent->currentState;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 369
;368:	
;369:	itemNum = (es->event & ~EV_EVENT_BITS) - EV_USE_ITEM0;
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
CNSTI4 24
SUBI4
ASGNI4
line 370
;370:	if ( itemNum < 0 || itemNum > HI_NUM_HOLDABLE ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $289
ADDRLP4 0
INDIRI4
CNSTI4 6
LEI4 $287
LABELV $289
line 371
;371:		itemNum = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 372
;372:	}
LABELV $287
line 375
;373:
;374:	// print a message if the local player
;375:	if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 4
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $290
line 376
;376:		if ( !itemNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $293
line 377
;377:			CG_CenterPrint( "No item to use", SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH );
ADDRGP4 $295
ARGP4
CNSTI4 144
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 378
;378:		} else {
ADDRGP4 $294
JUMPV
LABELV $293
line 379
;379:			item = BG_FindItemForHoldable( itemNum );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 BG_FindItemForHoldable
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 24
INDIRP4
ASGNP4
line 380
;380:			CG_CenterPrint( va("Use %s", item->pickup_name), SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH );
ADDRGP4 $296
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 28
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
CNSTI4 144
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 381
;381:		}
LABELV $294
line 382
;382:	}
LABELV $290
line 384
;383:
;384:	switch ( itemNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $299
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $298
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $303
ADDRGP4 $297
JUMPV
LABELV $297
LABELV $299
line 387
;385:	default:
;386:	case HI_NONE:
;387:		trap_S_StartSound (NULL, es->number, CHAN_BODY, cgs.media.useNothingSound );
CNSTP4 0
ARGP4
ADDRLP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+156680+616
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 388
;388:		break;
ADDRGP4 $298
JUMPV
line 391
;389:
;390:	case HI_TELEPORTER:
;391:		break;
LABELV $303
line 394
;392:
;393:	case HI_MEDKIT:
;394:		clientNum = cent->currentState.clientNum;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 395
;395:		if ( clientNum >= 0 && clientNum < MAX_CLIENTS ) {
ADDRLP4 28
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
LTI4 $304
ADDRLP4 28
INDIRI4
CNSTI4 64
GEI4 $304
line 396
;396:			ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 16
CNSTI4 1776
ADDRLP4 12
INDIRI4
MULI4
ADDRGP4 cgs+40960
ADDP4
ASGNP4
line 397
;397:			ci->medkitUsageTime = cg.time;
ADDRLP4 16
INDIRP4
CNSTI4 172
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 398
;398:		}
LABELV $304
line 399
;399:		trap_S_StartSound (NULL, es->number, CHAN_BODY, cgs.media.medkitSound );
CNSTP4 0
ARGP4
ADDRLP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+156680+948
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 400
;400:		break;
LABELV $298
line 414
;401:
;402:#ifdef MISSIONPACK
;403:	case HI_KAMIKAZE:
;404:		break;
;405:
;406:	case HI_PORTAL:
;407:		break;
;408:	case HI_INVULNERABILITY:
;409:		trap_S_StartSound (NULL, es->number, CHAN_BODY, cgs.media.useInvulnerabilitySound );
;410:		break;
;411:#endif
;412:	}
;413:
;414:}
LABELV $286
endproc CG_UseItem 32 16
proc CG_ItemPickup 0 0
line 423
;415:
;416:/*
;417:================
;418:CG_ItemPickup
;419:
;420:A new item was picked up this frame
;421:================
;422:*/
;423:static void CG_ItemPickup( int itemNum ) {
line 426
;424:
;425:	//CG_Printf("CG_ItemPikup --");
;426:	if ( bg_itemlist[itemNum].giType == IT_TEAM ) {
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist+36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $311
line 427
;427:		cg.itemPickupFlag = bg_itemlist[itemNum].giTag;
ADDRGP4 cg+130824
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
ASGNI4
line 428
;428:	}
LABELV $311
line 429
;429:	cg.itemPickup = itemNum;
ADDRGP4 cg+130812
ADDRFP4 0
INDIRI4
ASGNI4
line 430
;430:	cg.itemPickupTime = cg.time;
ADDRGP4 cg+130816
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 431
;431:	cg.itemPickupBlendTime = cg.time;
ADDRGP4 cg+130820
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 433
;432:	// see if it should be the grabbed weapon
;433:	if ( bg_itemlist[itemNum].giType == IT_WEAPON ) {
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist+36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $321
line 435
;434:		// select it immediately
;435:		if ( cg_autoswitch.integer && bg_itemlist[itemNum].giTag != WP_MACHINEGUN ) {
ADDRGP4 cg_autoswitch+12
INDIRI4
CNSTI4 0
EQI4 $324
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 2
EQI4 $324
line 436
;436:			cg.weaponSelectTime = cg.time;
ADDRGP4 cg+130828
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 437
;437:			SET_WEAPON(cg.weaponSelect, bg_itemlist[itemNum].giTag);
ADDRGP4 cg+108944
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
ASGNI4
line 438
;438:		}
LABELV $324
line 439
;439:	}
LABELV $321
line 441
;440:
;441:}
LABELV $310
endproc CG_ItemPickup 0 0
export CG_PainEvent
proc CG_PainEvent 12 16
line 451
;442:
;443:
;444:/*
;445:================
;446:CG_PainEvent
;447:
;448:Also called by playerstate transition
;449:================
;450:*/
;451:void CG_PainEvent( centity_t *cent, int health ) {
line 455
;452:	char	*snd;
;453:
;454:	// don't do more than two pain sounds a second
;455:	if ( cg.time - cent->pe.painTime < 500 ) {
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 596
ADDP4
INDIRI4
SUBI4
CNSTI4 500
GEI4 $333
line 456
;456:		return;
ADDRGP4 $332
JUMPV
LABELV $333
line 459
;457:	}
;458:
;459:	if ( health < 25 ) {
ADDRFP4 4
INDIRI4
CNSTI4 25
GEI4 $336
line 460
;460:		snd = "*pain25_1.wav";
ADDRLP4 0
ADDRGP4 $338
ASGNP4
line 461
;461:	} else if ( health < 50 ) {
ADDRGP4 $337
JUMPV
LABELV $336
ADDRFP4 4
INDIRI4
CNSTI4 50
GEI4 $339
line 462
;462:		snd = "*pain50_1.wav";
ADDRLP4 0
ADDRGP4 $341
ASGNP4
line 463
;463:	} else if ( health < 75 ) {
ADDRGP4 $340
JUMPV
LABELV $339
ADDRFP4 4
INDIRI4
CNSTI4 75
GEI4 $342
line 464
;464:		snd = "*pain75_1.wav";
ADDRLP4 0
ADDRGP4 $344
ASGNP4
line 465
;465:	} else {
ADDRGP4 $343
JUMPV
LABELV $342
line 466
;466:		snd = "*pain100_1.wav";
ADDRLP4 0
ADDRGP4 $345
ASGNP4
line 467
;467:	}
LABELV $343
LABELV $340
LABELV $337
line 468
;468:	trap_S_StartSound( NULL, cent->currentState.number, CHAN_VOICE, 
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 472
;469:		CG_CustomSound( cent->currentState.number, snd ) );
;470:
;471:	// save pain time for programitic twitch animation
;472:	cent->pe.painTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 596
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 473
;473:	cent->pe.painDirection ^= 1;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 600
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 474
;474:}
LABELV $332
endproc CG_PainEvent 12 16
lit
align 4
LABELV $498
byte 4 0
byte 4 0
byte 4 1065353216
export CG_EntityEvent
code
proc CG_EntityEvent 112 48
line 487
;475:
;476:
;477:
;478:/*
;479:==============
;480:CG_EntityEvent
;481:
;482:An entity has an event value
;483:also called by CG_CheckPlayerstateEvents
;484:==============
;485:*/
;486:#define	DEBUGNAME(x) if(cg_debugEvents.integer){CG_Printf(x"\n");}
;487:void CG_EntityEvent( centity_t *cent, vec3_t position ) {
line 496
;488:	entityState_t	*es;
;489:	//AdvancedDamage_t	*ad;
;490:	int				event;
;491:	vec3_t			dir;
;492:	const char		*s;
;493:	int				clientNum;
;494:	clientInfo_t	*ci;
;495:
;496:	es = &cent->currentState;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 497
;497:	event = es->event & ~EV_EVENT_BITS;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
ASGNI4
line 499
;498:
;499:	if ( cg_debugEvents.integer ) {
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $348
line 500
;500:		CG_Printf( "ent:%3i  event:%3i ", es->number, event );
ADDRGP4 $351
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 501
;501:	}
LABELV $348
line 503
;502:
;503:	if ( !event ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $352
line 504
;504:		DEBUGNAME("ZEROEVENT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $347
ADDRGP4 $357
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 505
;505:		return;
ADDRGP4 $347
JUMPV
LABELV $352
line 508
;506:	}
;507:
;508:	clientNum = es->clientNum;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 509
;509:	if ( clientNum < 0 || clientNum >= MAX_CLIENTS ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $360
ADDRLP4 8
INDIRI4
CNSTI4 64
LTI4 $358
LABELV $360
line 510
;510:		clientNum = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 511
;511:	}
LABELV $358
line 512
;512:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 12
CNSTI4 1776
ADDRLP4 8
INDIRI4
MULI4
ADDRGP4 cgs+40960
ADDP4
ASGNP4
line 518
;513:
;514:
;515:
;516:	//if (!AllowEntityInteraction(cent))
;517:	//	return;
;518:	if ( cg.eventAdjustment&& event > 1 ) {
ADDRGP4 cg+170852
INDIRI4
CNSTI4 0
EQI4 $362
ADDRLP4 4
INDIRI4
CNSTI4 1
LEI4 $362
line 519
;519:		event--;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 520
;520:	}
LABELV $362
line 521
;521:	switch ( event ) {
ADDRLP4 4
INDIRI4
CNSTI4 1
LTI4 $365
ADDRLP4 4
INDIRI4
CNSTI4 83
GTI4 $365
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1010-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1010
address $367
address $377
address $388
address $399
address $410
address $463
address $463
address $463
address $463
address $421
address $436
address $449
address $493
address $505
address $516
address $523
address $530
address $537
address $543
address $561
address $575
address $588
address $595
address $600
address $605
address $610
address $615
address $620
address $625
address $630
address $635
address $640
address $645
address $650
address $655
address $660
address $665
address $670
address $365
address $696
address $689
address $675
address $682
address $704
address $781
address $790
address $801
address $759
address $748
address $720
address $725
address $730
address $735
address $770
address $365
address $928
address $936
address $936
address $936
address $942
address $947
address $960
address $973
address $986
address $715
address $365
address $365
address $365
address $365
address $365
address $365
address $365
address $365
address $1000
address $995
address $510
address $365
address $365
address $365
address $365
address $365
address $365
address $583
code
LABELV $367
line 526
;522:	//
;523:	// movement generated events
;524:	//
;525:	case EV_FOOTSTEP:
;526:		DEBUGNAME("EV_FOOTSTEP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $368
ADDRGP4 $371
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $368
line 527
;527:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $366
line 528
;528:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 40
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 568
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 cgs+156680+624
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 530
;529:				cgs.media.footsteps[ ci->footsteps ][rand()&3] );
;530:		}
line 531
;531:		break;
ADDRGP4 $366
JUMPV
LABELV $377
line 533
;532:	case EV_FOOTSTEP_METAL:
;533:		DEBUGNAME("EV_FOOTSTEP_METAL");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $378
ADDRGP4 $381
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $378
line 534
;534:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $366
line 535
;535:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 40
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+156680+624+80
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 537
;536:				cgs.media.footsteps[ FOOTSTEP_METAL ][rand()&3] );
;537:		}
line 538
;538:		break;
ADDRGP4 $366
JUMPV
LABELV $388
line 540
;539:	case EV_FOOTSPLASH:
;540:		DEBUGNAME("EV_FOOTSPLASH");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $389
ADDRGP4 $392
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $389
line 541
;541:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $366
line 542
;542:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 40
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+156680+624+96
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 544
;543:				cgs.media.footsteps[ FOOTSTEP_SPLASH ][rand()&3] );
;544:		}
line 545
;545:		break;
ADDRGP4 $366
JUMPV
LABELV $399
line 547
;546:	case EV_FOOTWADE:
;547:		DEBUGNAME("EV_FOOTWADE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $400
ADDRGP4 $403
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $400
line 548
;548:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $366
line 549
;549:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 40
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+156680+624+96
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 551
;550:				cgs.media.footsteps[ FOOTSTEP_SPLASH ][rand()&3] );
;551:		}
line 552
;552:		break;
ADDRGP4 $366
JUMPV
LABELV $410
line 554
;553:	case EV_SWIM:
;554:		DEBUGNAME("EV_SWIM");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $411
ADDRGP4 $414
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $411
line 555
;555:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $366
line 556
;556:			trap_S_StartSound (NULL, es->number, CHAN_BODY, 
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 40
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+156680+624+96
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 558
;557:				cgs.media.footsteps[ FOOTSTEP_SPLASH ][rand()&3] );
;558:		}
line 559
;559:		break;
ADDRGP4 $366
JUMPV
LABELV $421
line 563
;560:
;561:
;562:	case EV_FALL_SHORT:
;563:		DEBUGNAME("EV_FALL_SHORT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $422
ADDRGP4 $425
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $422
line 564
;564:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.landSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+156680+808
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 565
;565:		if ( clientNum == cg.predictedPlayerState.clientNum && cg_fallKick.integer ) {
ADDRLP4 8
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $366
ADDRGP4 cg_fallKick+12
INDIRI4
CNSTI4 0
EQI4 $366
line 567
;566:			// smooth landing z changes
;567:			cg.landChange = -8;
ADDRGP4 cg+108936
CNSTF4 3238002688
ASGNF4
line 568
;568:			cg.landTime = cg.time;
ADDRGP4 cg+108940
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 569
;569:		}
line 570
;570:		break;
ADDRGP4 $366
JUMPV
LABELV $436
line 572
;571:	case EV_FALL_MEDIUM:
;572:		DEBUGNAME("EV_FALL_MEDIUM");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $437
ADDRGP4 $440
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $437
line 574
;573:		// use normal pain sound
;574:		trap_S_StartSound( NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, "*pain100_1.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $345
ARGP4
ADDRLP4 40
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 575
;575:		if ( clientNum == cg.predictedPlayerState.clientNum && cg_fallKick.integer ) {
ADDRLP4 8
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $366
ADDRGP4 cg_fallKick+12
INDIRI4
CNSTI4 0
EQI4 $366
line 577
;576:			// smooth landing z changes
;577:			cg.landChange = -16;
ADDRGP4 cg+108936
CNSTF4 3246391296
ASGNF4
line 578
;578:			cg.landTime = cg.time;
ADDRGP4 cg+108940
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 579
;579:		}
line 580
;580:		break;
ADDRGP4 $366
JUMPV
LABELV $449
line 582
;581:	case EV_FALL_FAR:
;582:		DEBUGNAME("EV_FALL_FAR");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $450
ADDRGP4 $453
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $450
line 583
;583:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, CG_CustomSound( es->number, "*fall1.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $454
ARGP4
ADDRLP4 44
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 584
;584:		cent->pe.painTime = cg.time;	// don't play a pain sound right after this
ADDRFP4 0
INDIRP4
CNSTI4 596
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 585
;585:		if ( clientNum == cg.predictedPlayerState.clientNum ) {
ADDRLP4 8
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $366
line 587
;586:			// smooth landing z changes
;587:			cg.landChange = -24;
ADDRGP4 cg+108936
CNSTF4 3250585600
ASGNF4
line 588
;588:			cg.landTime = cg.time;
ADDRGP4 cg+108940
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 589
;589:		}
line 590
;590:		break;
ADDRGP4 $366
JUMPV
LABELV $463
line 596
;591:
;592:	case EV_STEP_4:
;593:	case EV_STEP_8:
;594:	case EV_STEP_12:
;595:	case EV_STEP_16:		// smooth out step up transitions
;596:		DEBUGNAME("EV_STEP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $464
ADDRGP4 $467
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $464
line 597
;597:	{
line 602
;598:		float	oldStep;
;599:		int		delta;
;600:		int		step;
;601:
;602:		if ( clientNum != cg.predictedPlayerState.clientNum ) {
ADDRLP4 8
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
EQI4 $468
line 603
;603:			break;
ADDRGP4 $366
JUMPV
LABELV $468
line 606
;604:		}
;605:		// if we are interpolating, we don't need to smooth steps
;606:		if ( cg.demoPlayback || (cg.snap->ps.pm_flags & PMF_FOLLOW) ||
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRGP4 cg+8
INDIRI4
ADDRLP4 60
INDIRI4
NEI4 $480
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
ADDRLP4 60
INDIRI4
NEI4 $480
ADDRGP4 cg_nopredict+12
INDIRI4
ADDRLP4 60
INDIRI4
NEI4 $480
ADDRGP4 cg_synchronousClients+12
INDIRI4
ADDRLP4 60
INDIRI4
EQI4 $472
LABELV $480
line 607
;607:			cg_nopredict.integer || cg_synchronousClients.integer ) {
line 608
;608:			break;
ADDRGP4 $366
JUMPV
LABELV $472
line 611
;609:		}
;610:		// check for stepping up before a previous step is completed
;611:		delta = cg.time - cg.stepTime;
ADDRLP4 48
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+108924
INDIRI4
SUBI4
ASGNI4
line 612
;612:		if (delta < STEP_TIME) {
ADDRLP4 48
INDIRI4
CNSTI4 200
GEI4 $483
line 613
;613:			oldStep = cg.stepChange * (STEP_TIME - delta) / STEP_TIME;
ADDRLP4 52
ADDRGP4 cg+108920
INDIRF4
CNSTI4 200
ADDRLP4 48
INDIRI4
SUBI4
CVIF4 4
MULF4
CNSTF4 1128792064
DIVF4
ASGNF4
line 614
;614:		} else {
ADDRGP4 $484
JUMPV
LABELV $483
line 615
;615:			oldStep = 0;
ADDRLP4 52
CNSTF4 0
ASGNF4
line 616
;616:		}
LABELV $484
line 619
;617:
;618:		// add this amount
;619:		step = 4 * (event - EV_STEP_4 + 1 );
ADDRLP4 56
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 24
SUBI4
CNSTI4 4
ADDI4
ASGNI4
line 620
;620:		cg.stepChange = oldStep + step;
ADDRGP4 cg+108920
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 621
;621:		if ( cg.stepChange > MAX_STEP_CHANGE ) {
ADDRGP4 cg+108920
INDIRF4
CNSTF4 1107296256
LEF4 $487
line 622
;622:			cg.stepChange = MAX_STEP_CHANGE;
ADDRGP4 cg+108920
CNSTF4 1107296256
ASGNF4
line 623
;623:		}
LABELV $487
line 624
;624:		cg.stepTime = cg.time;
ADDRGP4 cg+108924
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 625
;625:		break;
ADDRGP4 $366
JUMPV
LABELV $493
line 629
;626:	}
;627:
;628:	case EV_JUMP_PAD:
;629:		DEBUGNAME("EV_JUMP_PAD");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $494
ADDRGP4 $497
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $494
line 631
;630://		CG_Printf( "EV_JUMP_PAD w/effect #%i\n", es->eventParm );
;631:		{
line 633
;632:			localEntity_t	*smoke;
;633:			vec3_t			up = {0, 0, 1};
ADDRLP4 48
ADDRGP4 $498
INDIRB
ASGNB 12
line 636
;634:
;635:
;636:			smoke = CG_SmokePuff( cent->lerpOrigin, up, 
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
ARGP4
ADDRLP4 48
ARGP4
CNSTF4 1107296256
ARGF4
ADDRLP4 64
CNSTF4 1065353216
ASGNF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
CNSTF4 1051260355
ARGF4
CNSTF4 1148846080
ARGF4
ADDRGP4 cg+107604
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 cgs+156680+332
INDIRI4
ARGI4
ADDRLP4 68
ADDRGP4 CG_SmokePuff
CALLP4
ASGNP4
ADDRLP4 60
ADDRLP4 68
INDIRP4
ASGNP4
line 643
;637:						  32, 
;638:						  1, 1, 1, 0.33f,
;639:						  1000, 
;640:						  cg.time, 0,
;641:						  LEF_PUFF_DONT_SCALE, 
;642:						  cgs.media.smokePuffShader );
;643:		}
line 646
;644:
;645:		// boing sound at origin, jump sound on player
;646:		trap_S_StartSound ( cent->lerpOrigin, -1, CHAN_VOICE, cgs.media.jumpPadSound );
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 cgs+156680+816
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 647
;647:		trap_S_StartSound (NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, "*jump1.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $504
ARGP4
ADDRLP4 48
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 648
;648:		break;
ADDRGP4 $366
JUMPV
LABELV $505
line 651
;649:
;650:	case EV_JUMP:
;651:		DEBUGNAME("EV_JUMP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $506
ADDRGP4 $509
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $506
line 652
;652:		trap_S_StartSound (NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, "*jump1.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $504
ARGP4
ADDRLP4 52
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 653
;653:		break;
ADDRGP4 $366
JUMPV
LABELV $510
line 655
;654:	case EV_TAUNT:
;655:		DEBUGNAME("EV_TAUNT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $511
ADDRGP4 $514
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $511
line 656
;656:		trap_S_StartSound (NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, "*taunt.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $515
ARGP4
ADDRLP4 56
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 657
;657:		break;
ADDRGP4 $366
JUMPV
LABELV $516
line 685
;658:#ifdef MISSIONPACK
;659:	case EV_TAUNT_YES:
;660:		DEBUGNAME("EV_TAUNT_YES");
;661:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_YES);
;662:		break;
;663:	case EV_TAUNT_NO:
;664:		DEBUGNAME("EV_TAUNT_NO");
;665:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_NO);
;666:		break;
;667:	case EV_TAUNT_FOLLOWME:
;668:		DEBUGNAME("EV_TAUNT_FOLLOWME");
;669:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_FOLLOWME);
;670:		break;
;671:	case EV_TAUNT_GETFLAG:
;672:		DEBUGNAME("EV_TAUNT_GETFLAG");
;673:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_ONGETFLAG);
;674:		break;
;675:	case EV_TAUNT_GUARDBASE:
;676:		DEBUGNAME("EV_TAUNT_GUARDBASE");
;677:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_ONDEFENSE);
;678:		break;
;679:	case EV_TAUNT_PATROL:
;680:		DEBUGNAME("EV_TAUNT_PATROL");
;681:		CG_VoiceChatLocal(SAY_TEAM, qfalse, es->number, COLOR_CYAN, VOICECHAT_ONPATROL);
;682:		break;
;683:#endif
;684:	case EV_WATER_TOUCH:
;685:		DEBUGNAME("EV_WATER_TOUCH");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $517
ADDRGP4 $520
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $517
line 686
;686:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.watrInSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+156680+932
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 687
;687:		break;
ADDRGP4 $366
JUMPV
LABELV $523
line 689
;688:	case EV_WATER_LEAVE:
;689:		DEBUGNAME("EV_WATER_LEAVE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $524
ADDRGP4 $527
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $524
line 690
;690:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.watrOutSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+156680+936
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 691
;691:		break;
ADDRGP4 $366
JUMPV
LABELV $530
line 693
;692:	case EV_WATER_UNDER:
;693:		DEBUGNAME("EV_WATER_UNDER");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $531
ADDRGP4 $534
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $531
line 694
;694:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.watrUnSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+156680+940
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 695
;695:		break;
ADDRGP4 $366
JUMPV
LABELV $537
line 697
;696:	case EV_WATER_CLEAR:
;697:		DEBUGNAME("EV_WATER_CLEAR");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $538
ADDRGP4 $541
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $538
line 698
;698:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, CG_CustomSound( es->number, "*gasp.wav" ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $542
ARGP4
ADDRLP4 60
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 699
;699:		break;
ADDRGP4 $366
JUMPV
LABELV $543
line 702
;700:
;701:	case EV_ITEM_PICKUP:
;702:		DEBUGNAME("EV_ITEM_PICKUP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $544
ADDRGP4 $547
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $544
line 703
;703:		{
line 707
;704:			gitem_t	*item;
;705:			int		index;
;706:
;707:			index = es->eventParm;		// player predicted
ADDRLP4 64
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 709
;708:
;709:			if ( index < 1 || index >= bg_numItems ) {
ADDRLP4 72
ADDRLP4 64
INDIRI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 1
LTI4 $550
ADDRLP4 72
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $548
LABELV $550
line 710
;710:				break;
ADDRGP4 $366
JUMPV
LABELV $548
line 712
;711:			}
;712:			item = &bg_itemlist[ index ];
ADDRLP4 68
CNSTI4 52
ADDRLP4 64
INDIRI4
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 716
;713:
;714:			// powerups and team items will have a separate global sound, this one
;715:			// will be played at prediction time
;716:			if ( item->giType == IT_POWERUP || item->giType == IT_TEAM) {
ADDRLP4 76
ADDRLP4 68
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 5
EQI4 $553
ADDRLP4 76
INDIRI4
CNSTI4 8
NEI4 $551
LABELV $553
line 717
;717:				trap_S_StartSound (NULL, es->number, CHAN_AUTO,	cgs.media.n_healthSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+156680+1092
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 718
;718:			} else if (item->giType == IT_PERSISTANT_POWERUP) {
ADDRGP4 $552
JUMPV
LABELV $551
ADDRLP4 68
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 7
NEI4 $556
line 735
;719:#ifdef MISSIONPACK
;720:				switch (item->giTag ) {
;721:					case PW_SCOUT:
;722:						trap_S_StartSound (NULL, es->number, CHAN_AUTO,	cgs.media.scoutSound );
;723:					break;
;724:					case PW_GUARD:
;725:						trap_S_StartSound (NULL, es->number, CHAN_AUTO,	cgs.media.guardSound );
;726:					break;
;727:					case PW_DOUBLER:
;728:						trap_S_StartSound (NULL, es->number, CHAN_AUTO,	cgs.media.doublerSound );
;729:					break;
;730:					case PW_AMMOREGEN:
;731:						trap_S_StartSound (NULL, es->number, CHAN_AUTO,	cgs.media.ammoregenSound );
;732:					break;
;733:				}
;734:#endif
;735:			} else {
ADDRGP4 $557
JUMPV
LABELV $556
line 736
;736:				trap_S_StartSound (NULL, es->number, CHAN_AUTO,	trap_S_RegisterSound( item->pickup_sound, qfalse ) );
ADDRLP4 68
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 80
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 80
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 737
;737:			}
LABELV $557
LABELV $552
line 740
;738:
;739:			// show icon and name on status bar
;740:			if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $366
line 741
;741:				CG_ItemPickup( index );
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 CG_ItemPickup
CALLV
pop
line 742
;742:			}
line 743
;743:		}
line 744
;744:		break;
ADDRGP4 $366
JUMPV
LABELV $561
line 747
;745:
;746:	case EV_GLOBAL_ITEM_PICKUP:
;747:		DEBUGNAME("EV_GLOBAL_ITEM_PICKUP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $562
ADDRGP4 $565
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $562
line 748
;748:		{
line 752
;749:			gitem_t	*item;
;750:			int		index;
;751:
;752:			index = es->eventParm;		// player predicted
ADDRLP4 64
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 754
;753:
;754:			if ( index < 1 || index >= bg_numItems ) {
ADDRLP4 72
ADDRLP4 64
INDIRI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 1
LTI4 $568
ADDRLP4 72
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $566
LABELV $568
line 755
;755:				break;
ADDRGP4 $366
JUMPV
LABELV $566
line 757
;756:			}
;757:			item = &bg_itemlist[ index ];
ADDRLP4 68
CNSTI4 52
ADDRLP4 64
INDIRI4
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 759
;758:			// powerup pickups are global
;759:			if( item->pickup_sound ) {
ADDRLP4 68
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $569
line 760
;760:				trap_S_StartSound (NULL, cg.snap->ps.clientNum, CHAN_AUTO, trap_S_RegisterSound( item->pickup_sound, qfalse ) );
ADDRLP4 68
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 76
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 76
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 761
;761:			}
LABELV $569
line 764
;762:
;763:			// show icon and name on status bar
;764:			if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $366
line 765
;765:				CG_ItemPickup( index );
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 CG_ItemPickup
CALLV
pop
line 766
;766:			}
line 767
;767:		}
line 768
;768:		break;
ADDRGP4 $366
JUMPV
LABELV $575
line 774
;769:
;770:	//
;771:	// weapon events
;772:	//
;773:	case EV_NOAMMO:
;774:		DEBUGNAME("EV_NOAMMO");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $576
ADDRGP4 $579
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $576
line 776
;775://		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.noAmmoSound );
;776:		if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $366
line 777
;777:			CG_OutOfAmmoChange();
ADDRGP4 CG_OutOfAmmoChange
CALLV
pop
line 778
;778:		}
line 779
;779:		break;
ADDRGP4 $366
JUMPV
LABELV $583
line 782
;780:	//monkk: offhand grapple
;781:	case EV_FIRE_GRAPPLE:
;782:		DEBUGNAME("EV_FIRE_GRAPPLE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $366
ADDRGP4 $587
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 784
;783:		//CG_FireGrapple( cent );
;784:		break;
ADDRGP4 $366
JUMPV
LABELV $588
line 786
;785:	case EV_CHANGE_WEAPON:
;786:		DEBUGNAME("EV_CHANGE_WEAPON");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $589
ADDRGP4 $592
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $589
line 787
;787:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.selectSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+156680+612
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 788
;788:		break;
ADDRGP4 $366
JUMPV
LABELV $595
line 790
;789:	case EV_FIRE_WEAPON:
;790:		DEBUGNAME("EV_FIRE_WEAPON");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $596
ADDRGP4 $599
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $596
line 791
;791:		CG_FireWeapon( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_FireWeapon
CALLV
pop
line 792
;792:		break;
ADDRGP4 $366
JUMPV
LABELV $600
line 794
;793:	case EV_USE_ITEM0:
;794:		DEBUGNAME("EV_USE_ITEM0");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $601
ADDRGP4 $604
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $601
line 795
;795:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 796
;796:		break;
ADDRGP4 $366
JUMPV
LABELV $605
line 798
;797:	case EV_USE_ITEM1:
;798:		DEBUGNAME("EV_USE_ITEM1");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $606
ADDRGP4 $609
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $606
line 799
;799:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 800
;800:		break;
ADDRGP4 $366
JUMPV
LABELV $610
line 802
;801:	case EV_USE_ITEM2:
;802:		DEBUGNAME("EV_USE_ITEM2");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $611
ADDRGP4 $614
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $611
line 803
;803:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 804
;804:		break;
ADDRGP4 $366
JUMPV
LABELV $615
line 806
;805:	case EV_USE_ITEM3:
;806:		DEBUGNAME("EV_USE_ITEM3");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $616
ADDRGP4 $619
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $616
line 807
;807:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 808
;808:		break;
ADDRGP4 $366
JUMPV
LABELV $620
line 810
;809:	case EV_USE_ITEM4:
;810:		DEBUGNAME("EV_USE_ITEM4");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $621
ADDRGP4 $624
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $621
line 811
;811:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 812
;812:		break;
ADDRGP4 $366
JUMPV
LABELV $625
line 814
;813:	case EV_USE_ITEM5:
;814:		DEBUGNAME("EV_USE_ITEM5");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $626
ADDRGP4 $629
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $626
line 815
;815:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 816
;816:		break;
ADDRGP4 $366
JUMPV
LABELV $630
line 818
;817:	case EV_USE_ITEM6:
;818:		DEBUGNAME("EV_USE_ITEM6");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $631
ADDRGP4 $634
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $631
line 819
;819:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 820
;820:		break;
ADDRGP4 $366
JUMPV
LABELV $635
line 822
;821:	case EV_USE_ITEM7:
;822:		DEBUGNAME("EV_USE_ITEM7");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $636
ADDRGP4 $639
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $636
line 823
;823:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 824
;824:		break;
ADDRGP4 $366
JUMPV
LABELV $640
line 826
;825:	case EV_USE_ITEM8:
;826:		DEBUGNAME("EV_USE_ITEM8");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $641
ADDRGP4 $644
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $641
line 827
;827:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 828
;828:		break;
ADDRGP4 $366
JUMPV
LABELV $645
line 830
;829:	case EV_USE_ITEM9:
;830:		DEBUGNAME("EV_USE_ITEM9");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $646
ADDRGP4 $649
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $646
line 831
;831:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 832
;832:		break;
ADDRGP4 $366
JUMPV
LABELV $650
line 834
;833:	case EV_USE_ITEM10:
;834:		DEBUGNAME("EV_USE_ITEM10");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $651
ADDRGP4 $654
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $651
line 835
;835:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 836
;836:		break;
ADDRGP4 $366
JUMPV
LABELV $655
line 838
;837:	case EV_USE_ITEM11:
;838:		DEBUGNAME("EV_USE_ITEM11");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $656
ADDRGP4 $659
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $656
line 839
;839:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 840
;840:		break;
ADDRGP4 $366
JUMPV
LABELV $660
line 842
;841:	case EV_USE_ITEM12:
;842:		DEBUGNAME("EV_USE_ITEM12");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $661
ADDRGP4 $664
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $661
line 843
;843:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 844
;844:		break;
ADDRGP4 $366
JUMPV
LABELV $665
line 846
;845:	case EV_USE_ITEM13:
;846:		DEBUGNAME("EV_USE_ITEM13");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $666
ADDRGP4 $669
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $666
line 847
;847:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 848
;848:		break;
ADDRGP4 $366
JUMPV
LABELV $670
line 850
;849:	case EV_USE_ITEM14:
;850:		DEBUGNAME("EV_USE_ITEM14");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $671
ADDRGP4 $674
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $671
line 851
;851:		CG_UseItem( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 852
;852:		break;
ADDRGP4 $366
JUMPV
LABELV $675
line 860
;853:
;854:	//=================================================================
;855:
;856:	//
;857:	// other events
;858:	//
;859:	case EV_PLAYER_TELEPORT_IN:
;860:		DEBUGNAME("EV_PLAYER_TELEPORT_IN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $676
ADDRGP4 $679
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $676
line 861
;861:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.teleInSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+156680+788
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 862
;862:		CG_SpawnEffect( position);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_SpawnEffect
CALLV
pop
line 863
;863:		break;
ADDRGP4 $366
JUMPV
LABELV $682
line 866
;864:
;865:	case EV_PLAYER_TELEPORT_OUT:
;866:		DEBUGNAME("EV_PLAYER_TELEPORT_OUT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $683
ADDRGP4 $686
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $683
line 867
;867:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.teleOutSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+156680+792
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 868
;868:		CG_SpawnEffect(  position);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_SpawnEffect
CALLV
pop
line 869
;869:		break;
ADDRGP4 $366
JUMPV
LABELV $689
line 872
;870:
;871:	case EV_ITEM_POP:
;872:		DEBUGNAME("EV_ITEM_POP");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $690
ADDRGP4 $693
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $690
line 873
;873:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.respawnSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+156680+800
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 874
;874:		break;
ADDRGP4 $366
JUMPV
LABELV $696
line 876
;875:	case EV_ITEM_RESPAWN:
;876:		DEBUGNAME("EV_ITEM_RESPAWN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $697
ADDRGP4 $700
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $697
line 877
;877:		cent->miscTime = cg.time;	// scale up from this
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 878
;878:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.respawnSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+156680+800
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 879
;879:		break;
ADDRGP4 $366
JUMPV
LABELV $704
line 882
;880:
;881:	case EV_GRENADE_BOUNCE:
;882:		DEBUGNAME("EV_GRENADE_BOUNCE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $705
ADDRGP4 $708
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $705
line 883
;883:		if ( rand() & 1 ) {
ADDRLP4 64
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $709
line 884
;884:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.hgrenb1aSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+156680+1096
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 885
;885:		} else {
ADDRGP4 $366
JUMPV
LABELV $709
line 886
;886:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.hgrenb2aSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+156680+1100
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 887
;887:		}
line 888
;888:		break;
ADDRGP4 $366
JUMPV
LABELV $715
line 933
;889:
;890:#ifdef MISSIONPACK
;891:	case EV_PROXIMITY_MINE_STICK:
;892:		DEBUGNAME("EV_PROXIMITY_MINE_STICK");
;893:		if( es->eventParm & SURF_FLESH ) {
;894:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.wstbimplSound );
;895:		} else 	if( es->eventParm & SURF_METALSTEPS ) {
;896:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.wstbimpmSound );
;897:		} else {
;898:			trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.wstbimpdSound );
;899:		}
;900:		break;
;901:
;902:	case EV_PROXIMITY_MINE_TRIGGER:
;903:		DEBUGNAME("EV_PROXIMITY_MINE_TRIGGER");
;904:		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.wstbactvSound );
;905:		break;
;906:	case EV_KAMIKAZE:
;907:		DEBUGNAME("EV_KAMIKAZE");
;908:		CG_KamikazeEffect( cent->lerpOrigin );
;909:		break;
;910:	case EV_OBELISKEXPLODE:
;911:		DEBUGNAME("EV_OBELISKEXPLODE");
;912:		CG_ObeliskExplode( cent->lerpOrigin, es->eventParm );
;913:		break;
;914:	case EV_OBELISKPAIN:
;915:		DEBUGNAME("EV_OBELISKPAIN");
;916:		CG_ObeliskPain( cent->lerpOrigin );
;917:		break;
;918:	case EV_INVUL_IMPACT:
;919:		DEBUGNAME("EV_INVUL_IMPACT");
;920:		CG_InvulnerabilityImpact( cent->lerpOrigin, cent->currentState.angles );
;921:		break;
;922:	case EV_JUICED:
;923:		DEBUGNAME("EV_JUICED");
;924:		CG_InvulnerabilityJuiced( cent->lerpOrigin );
;925:		break;
;926:	case EV_LIGHTNINGBOLT:
;927:		DEBUGNAME("EV_LIGHTNINGBOLT");
;928:		CG_LightningBoltBeam(es->origin2, es->pos.trBase);
;929:		break;
;930:
;931:#endif
;932:	case EV_SCOREPLUM:
;933:		DEBUGNAME("EV_SCOREPLUM");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $716
ADDRGP4 $719
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $716
line 934
;934:		CG_ScorePlum( cent->currentState.otherEntityNum, cent->lerpOrigin, cent->currentState.time );
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 704
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_ScorePlum
CALLV
pop
line 935
;935:		break;
ADDRGP4 $366
JUMPV
LABELV $720
line 941
;936:
;937:	//
;938:	// missile impacts
;939:	//
;940:	case EV_MISSILE_HIT:
;941:		DEBUGNAME("EV_MISSILE_HIT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $721
ADDRGP4 $724
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $721
line 942
;942:		ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 943
;943:		CG_MissileHitPlayer( es->weapon, position, dir, es->otherEntityNum );
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_MissileHitPlayer
CALLV
pop
line 944
;944:		break;
ADDRGP4 $366
JUMPV
LABELV $725
line 947
;945:
;946:	case EV_MISSILE_MISS:
;947:		DEBUGNAME("EV_MISSILE_MISS");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $726
ADDRGP4 $729
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $726
line 948
;948:		ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 949
;949:		CG_MissileHitWall( es->weapon, 0, position, dir, IMPACTSOUND_DEFAULT );
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
ADDRLP4 76
CNSTI4 0
ASGNI4
ADDRLP4 76
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 76
INDIRI4
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 950
;950:		break;
ADDRGP4 $366
JUMPV
LABELV $730
line 953
;951:
;952:	case EV_MISSILE_MISS_METAL:
;953:		DEBUGNAME("EV_MISSILE_MISS_METAL");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $731
ADDRGP4 $734
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $731
line 954
;954:		ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 955
;955:		CG_MissileHitWall( es->weapon, 0, position, dir, IMPACTSOUND_METAL );
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 956
;956:		break;
ADDRGP4 $366
JUMPV
LABELV $735
line 959
;957:
;958:	case EV_RAILTRAIL:
;959:		DEBUGNAME("EV_RAILTRAIL");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $736
ADDRGP4 $739
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $736
line 960
;960:		cent->currentState.weapon = WP_RAILGUN;
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 7
ASGNI4
line 963
;961://unlagged - attack prediction #2
;962:		// if the client is us, unlagged is on server-side, and we've got it client-side
;963:		if ( es->clientNum == cg.predictedPlayerState.clientNum && 
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $740
ADDRLP4 80
CNSTI4 0
ASGNI4
ADDRGP4 cgs+157800
INDIRI4
ADDRLP4 80
INDIRI4
EQI4 $740
ADDRGP4 cg_aimType+12
INDIRI4
ADDRLP4 80
INDIRI4
LEI4 $740
line 964
;964:				cgs.delagHitscan && cg_aimType.integer > 0 ) {
line 967
;965:			// do nothing, because it was already predicted
;966:			//Com_Printf("Ignoring rail trail event\n");
;967:		}
ADDRGP4 $366
JUMPV
LABELV $740
line 968
;968:		else {
line 970
;969:			// draw a rail trail, because it wasn't predicted
;970:			CG_RailTrail( ci, es->origin2, es->pos.trBase );
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 CG_RailTrail
CALLV
pop
line 973
;971:
;972:			// if the end was on a nomark surface, don't make an explosion
;973:			if ( es->eventParm != 255 ) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 255
EQI4 $366
line 974
;974:				ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 975
;975:				CG_MissileHitWall( es->weapon, es->clientNum, position, dir, IMPACTSOUND_DEFAULT );
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 976
;976:			}
line 978
;977:			//Com_Printf("Non-predicted rail trail\n");
;978:		}
line 980
;979://unlagged - attack prediction #2
;980:		break;
ADDRGP4 $366
JUMPV
LABELV $748
line 983
;981:
;982:	case EV_BULLET_HIT_WALL:
;983:		DEBUGNAME("EV_BULLET_HIT_WALL");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $749
ADDRGP4 $752
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $749
line 986
;984://unlagged - attack prediction #2
;985:		// if the client is us, unlagged is on server-side, and we've got it client-side
;986:		if ( es->clientNum == cg.predictedPlayerState.clientNum && 
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $753
ADDRLP4 84
CNSTI4 0
ASGNI4
ADDRGP4 cgs+157800
INDIRI4
ADDRLP4 84
INDIRI4
EQI4 $753
ADDRGP4 cg_aimType+12
INDIRI4
ADDRLP4 84
INDIRI4
LEI4 $753
line 987
;987:				cgs.delagHitscan && cg_aimType.integer > 0 ) {
line 990
;988:			// do nothing, because it was already predicted
;989:			//Com_Printf("Ignoring bullet event\n");
;990:		}
ADDRGP4 $366
JUMPV
LABELV $753
line 991
;991:		else {
line 993
;992:			// do the bullet, because it wasn't predicted
;993:			ByteToDir( es->eventParm, dir );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 994
;994:			CG_Bullet( es->pos.trBase, es->otherEntityNum, dir, qfalse, ENTITYNUM_WORLD );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1022
ARGI4
ADDRGP4 CG_Bullet
CALLV
pop
line 996
;995:			//Com_Printf("Non-predicted bullet\n");
;996:		}
line 998
;997://unlagged - attack prediction #2
;998:		break;
ADDRGP4 $366
JUMPV
LABELV $759
line 1001
;999:
;1000:	case EV_BULLET_HIT_FLESH:
;1001:		DEBUGNAME("EV_BULLET_HIT_FLESH");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $760
ADDRGP4 $763
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $760
line 1004
;1002://unlagged - attack prediction #2
;1003:		// if the client is us, unlagged is on server-side, and we've got it client-side
;1004:		if ( es->clientNum == cg.predictedPlayerState.clientNum && 
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $764
ADDRLP4 88
CNSTI4 0
ASGNI4
ADDRGP4 cgs+157800
INDIRI4
ADDRLP4 88
INDIRI4
EQI4 $764
ADDRGP4 cg_aimType+12
INDIRI4
ADDRLP4 88
INDIRI4
LEI4 $764
line 1005
;1005:				cgs.delagHitscan && cg_aimType.integer > 0 ) {
line 1008
;1006:			// do nothing, because it was already predicted
;1007:			//Com_Printf("Ignoring bullet event\n");
;1008:		}
ADDRGP4 $366
JUMPV
LABELV $764
line 1009
;1009:		else {
line 1011
;1010:			// do the bullet, because it wasn't predicted
;1011:			CG_Bullet( es->pos.trBase, es->otherEntityNum, dir, qtrue, es->eventParm );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Bullet
CALLV
pop
line 1013
;1012:			//Com_Printf("Non-predicted bullet\n");
;1013:		}
line 1015
;1014://unlagged - attack prediction #2
;1015:		break;
ADDRGP4 $366
JUMPV
LABELV $770
line 1018
;1016:
;1017:	case EV_SHOTGUN:
;1018:		DEBUGNAME("EV_SHOTGUN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $771
ADDRGP4 $774
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $771
line 1021
;1019://unlagged - attack prediction #2
;1020:		// if the client is us, unlagged is on server-side, and we've got it client-side
;1021:		if ( es->otherEntityNum == cg.predictedPlayerState.clientNum && 
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $775
ADDRLP4 92
CNSTI4 0
ASGNI4
ADDRGP4 cgs+157800
INDIRI4
ADDRLP4 92
INDIRI4
EQI4 $775
ADDRGP4 cg_aimType+12
INDIRI4
ADDRLP4 92
INDIRI4
LEI4 $775
line 1022
;1022:				cgs.delagHitscan && cg_aimType.integer > 0 ) {
line 1025
;1023:			// do nothing, because it was already predicted
;1024:			//Com_Printf("Ignoring shotgun event\n");
;1025:		}
ADDRGP4 $366
JUMPV
LABELV $775
line 1026
;1026:		else {
line 1028
;1027:			// do the shotgun pattern, because it wasn't predicted
;1028:			CG_ShotgunFire( es );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_ShotgunFire
CALLV
pop
line 1030
;1029:			//Com_Printf("Non-predicted shotgun pattern\n");
;1030:		}
line 1032
;1031://unlagged - attack prediction #2
;1032:		break;
ADDRGP4 $366
JUMPV
LABELV $781
line 1035
;1033:
;1034:	case EV_GENERAL_SOUND:
;1035:		DEBUGNAME("EV_GENERAL_SOUND");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $782
ADDRGP4 $785
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $782
line 1036
;1036:		if ( cgs.gameSounds[ es->eventParm ] ) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35836
ADDP4
INDIRI4
CNSTI4 0
EQI4 $786
line 1037
;1037:			trap_S_StartSound (NULL, es->number, CHAN_VOICE, cgs.gameSounds[ es->eventParm ] );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35836
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1038
;1038:		} else {
ADDRGP4 $366
JUMPV
LABELV $786
line 1039
;1039:			s = CG_ConfigString( CS_SOUNDS + es->eventParm );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 96
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 28
ADDRLP4 96
INDIRP4
ASGNP4
line 1040
;1040:			trap_S_StartSound (NULL, es->number, CHAN_VOICE, CG_CustomSound( es->number, s ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 100
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1041
;1041:		}
line 1042
;1042:		break;
ADDRGP4 $366
JUMPV
LABELV $790
line 1045
;1043:
;1044:	case EV_GLOBAL_SOUND:	// play from the player's head so it never diminishes
;1045:		DEBUGNAME("EV_GLOBAL_SOUND");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $791
ADDRGP4 $794
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $791
line 1046
;1046:		if ( cgs.gameSounds[ es->eventParm ] ) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35836
ADDP4
INDIRI4
CNSTI4 0
EQI4 $795
line 1055
;1047:			//CG_Printf("if:SoundIndexNum: %i", es->eventParm );
;1048:			/*if ( es->eventParm == 11 ) {
;1049:				char	path[MAX_QPATH];
;1050:				memset(path, 0, sizeof(path));
;1051:				Com_sprintf(path, sizeof(path), "sound/%s/accuracy.wav", s_announcer.string);
;1052:				trap_SendConsoleCommand(va("play %s \n", path));
;1053:				//trap_S_StartSound ( NULL, cg.snap->ps.clientNum, CHAN_AUTO, path );
;1054:			} else {*/
;1055:				trap_S_StartSound (NULL, cg.snap->ps.clientNum, CHAN_AUTO, cgs.gameSounds[ es->eventParm ] );
CNSTP4 0
ARGP4
ADDRLP4 96
CNSTI4 184
ASGNI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35836
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1057
;1056:			//}
;1057:		} else {
ADDRGP4 $366
JUMPV
LABELV $795
line 1058
;1058:			s = CG_ConfigString( CS_SOUNDS + es->eventParm );
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 96
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 28
ADDRLP4 96
INDIRP4
ASGNP4
line 1060
;1059:			//CG_Printf("else:SoundIndexNum: %i", es->eventParm );
;1060:			trap_S_StartSound (NULL, cg.snap->ps.clientNum, CHAN_AUTO, CG_CustomSound( es->number, s ) );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 100
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1061
;1061:		}
line 1062
;1062:		break;
ADDRGP4 $366
JUMPV
LABELV $801
line 1065
;1063:
;1064:	case EV_GLOBAL_TEAM_SOUND:	// play from the player's head so it never diminishes
;1065:		{
line 1066
;1066:			DEBUGNAME("EV_GLOBAL_TEAM_SOUND");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $802
ADDRGP4 $805
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $802
line 1067
;1067:			switch( es->eventParm ) {
ADDRLP4 96
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 0
LTI4 $366
ADDRLP4 96
INDIRI4
CNSTI4 14
GTI4 $366
ADDRLP4 96
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $927
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $927
address $812
address $822
address $832
address $844
address $856
address $876
address $896
address $904
address $912
address $915
address $918
address $921
address $924
address $366
address $809
code
LABELV $809
line 1069
;1068:				case GTS_PICKED_UP_DROP_TEAM_FLAG: // dropped flag was picked up
;1069:						CG_AddBufferedSound( cgs.media.pickedUpYourTeamSound );
ADDRGP4 cgs+156680+1004
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1070
;1070:					break;
ADDRGP4 $366
JUMPV
LABELV $812
line 1072
;1071:				case GTS_RED_CAPTURE: // CTF: red team captured the blue flag, 1FCTF: red team captured the neutral flag
;1072:					if ( cgs.clientinfo[cg.clientNum].team == TEAM_RED )
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $813
line 1073
;1073:						CG_AddBufferedSound( cgs.media.captureYourTeamSound );
ADDRGP4 cgs+156680+980
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $366
JUMPV
LABELV $813
line 1075
;1074:					else
;1075:						CG_AddBufferedSound( cgs.media.captureOpponentSound );
ADDRGP4 cgs+156680+984
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1076
;1076:					break;
ADDRGP4 $366
JUMPV
LABELV $822
line 1078
;1077:				case GTS_BLUE_CAPTURE: // CTF: blue team captured the red flag, 1FCTF: blue team captured the neutral flag
;1078:					if ( cgs.clientinfo[cg.clientNum].team == TEAM_BLUE )
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $823
line 1079
;1079:						CG_AddBufferedSound( cgs.media.captureYourTeamSound );
ADDRGP4 cgs+156680+980
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $366
JUMPV
LABELV $823
line 1081
;1080:					else
;1081:						CG_AddBufferedSound( cgs.media.captureOpponentSound );
ADDRGP4 cgs+156680+984
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1082
;1082:					break;
ADDRGP4 $366
JUMPV
LABELV $832
line 1084
;1083:				case GTS_RED_RETURN: // CTF: blue flag returned, 1FCTF: never used
;1084:					if ( cgs.clientinfo[cg.clientNum].team == TEAM_RED )
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $833
line 1085
;1085:						CG_AddBufferedSound( cgs.media.returnYourTeamSound );
ADDRGP4 cgs+156680+988
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $834
JUMPV
LABELV $833
line 1087
;1086:					else
;1087:						CG_AddBufferedSound( cgs.media.returnOpponentSound );
ADDRGP4 cgs+156680+992
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
LABELV $834
line 1089
;1088:					//
;1089:					CG_AddBufferedSound( cgs.media.blueFlagReturnedSound );
ADDRGP4 cgs+156680+1012
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1090
;1090:					break;
ADDRGP4 $366
JUMPV
LABELV $844
line 1092
;1091:				case GTS_BLUE_RETURN: // CTF red flag returned, 1FCTF: neutral flag returned
;1092:					if ( cgs.clientinfo[cg.clientNum].team == TEAM_BLUE )
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $845
line 1093
;1093:						CG_AddBufferedSound( cgs.media.returnYourTeamSound );
ADDRGP4 cgs+156680+988
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $846
JUMPV
LABELV $845
line 1095
;1094:					else
;1095:						CG_AddBufferedSound( cgs.media.returnOpponentSound );
ADDRGP4 cgs+156680+992
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
LABELV $846
line 1097
;1096:					//
;1097:					CG_AddBufferedSound( cgs.media.redFlagReturnedSound );
ADDRGP4 cgs+156680+1008
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1098
;1098:					break;
ADDRGP4 $366
JUMPV
LABELV $856
line 1102
;1099:
;1100:				case GTS_RED_TAKEN: // CTF: red team took blue flag, 1FCTF: blue team took the neutral flag
;1101:					// if this player picked up the flag then a sound is played in CG_CheckLocalSounds
;1102:					if (cg.snap->ps.powerups[PW_BLUEFLAG] || cg.snap->ps.powerups[PW_NEUTRALFLAG]) {
ADDRLP4 104
CNSTI4 0
ASGNI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
ADDRLP4 104
INDIRI4
NEI4 $861
ADDRGP4 cg+36
INDIRP4
CNSTI4 392
ADDP4
INDIRI4
ADDRLP4 104
INDIRI4
EQI4 $857
LABELV $861
line 1103
;1103:					}
ADDRGP4 $366
JUMPV
LABELV $857
line 1104
;1104:					else {
line 1105
;1105:					if (cgs.clientinfo[cg.clientNum].team == TEAM_BLUE) {
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $862
line 1111
;1106:#ifdef MISSIONPACK
;1107:							if (cgs.gametype == GT_1FCTF) 
;1108:								CG_AddBufferedSound( cgs.media.yourTeamTookTheFlagSound );
;1109:							else
;1110:#endif
;1111:						 	CG_AddBufferedSound( cgs.media.enemyTookYourFlagSound );
ADDRGP4 cgs+156680+1020
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1112
;1112:						}
ADDRGP4 $366
JUMPV
LABELV $862
line 1113
;1113:						else if (cgs.clientinfo[cg.clientNum].team == TEAM_RED) {
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $366
line 1119
;1114:#ifdef MISSIONPACK
;1115:							if (cgs.gametype == GT_1FCTF)
;1116:								CG_AddBufferedSound( cgs.media.enemyTookTheFlagSound );
;1117:							else
;1118:#endif
;1119: 							CG_AddBufferedSound( cgs.media.yourTeamTookEnemyFlagSound );
ADDRGP4 cgs+156680+1028
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1120
;1120:						}
line 1121
;1121:					}
line 1122
;1122:					break;
ADDRGP4 $366
JUMPV
LABELV $876
line 1125
;1123:				case GTS_BLUE_TAKEN: // CTF: blue team took the red flag, 1FCTF red team took the neutral flag
;1124:					// if this player picked up the flag then a sound is played in CG_CheckLocalSounds
;1125:					if (cg.snap->ps.powerups[PW_REDFLAG] || cg.snap->ps.powerups[PW_NEUTRALFLAG]) {
ADDRLP4 108
CNSTI4 0
ASGNI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
ADDRLP4 108
INDIRI4
NEI4 $881
ADDRGP4 cg+36
INDIRP4
CNSTI4 392
ADDP4
INDIRI4
ADDRLP4 108
INDIRI4
EQI4 $877
LABELV $881
line 1126
;1126:					}
ADDRGP4 $366
JUMPV
LABELV $877
line 1127
;1127:					else {
line 1128
;1128:						if (cgs.clientinfo[cg.clientNum].team == TEAM_RED) {
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $882
line 1134
;1129:#ifdef MISSIONPACK
;1130:							if (cgs.gametype == GT_1FCTF)
;1131:								CG_AddBufferedSound( cgs.media.yourTeamTookTheFlagSound );
;1132:							else
;1133:#endif
;1134:							CG_AddBufferedSound( cgs.media.enemyTookYourFlagSound );
ADDRGP4 cgs+156680+1020
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1135
;1135:						}
ADDRGP4 $366
JUMPV
LABELV $882
line 1136
;1136:						else if (cgs.clientinfo[cg.clientNum].team == TEAM_BLUE) {
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $366
line 1142
;1137:#ifdef MISSIONPACK
;1138:							if (cgs.gametype == GT_1FCTF)
;1139:								CG_AddBufferedSound( cgs.media.enemyTookTheFlagSound );
;1140:							else
;1141:#endif
;1142:							CG_AddBufferedSound( cgs.media.yourTeamTookEnemyFlagSound );
ADDRGP4 cgs+156680+1028
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1143
;1143:						}
line 1144
;1144:					}
line 1145
;1145:					break;
ADDRGP4 $366
JUMPV
LABELV $896
line 1147
;1146:				case GTS_REDOBELISK_ATTACKED: // Overload: red obelisk is being attacked
;1147:					if (cgs.clientinfo[cg.clientNum].team == TEAM_RED) {
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $366
line 1148
;1148:						CG_AddBufferedSound( cgs.media.yourBaseIsUnderAttackSound );
ADDRGP4 cgs+156680+1040
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1149
;1149:					}
line 1150
;1150:					break;
ADDRGP4 $366
JUMPV
LABELV $904
line 1152
;1151:				case GTS_BLUEOBELISK_ATTACKED: // Overload: blue obelisk is being attacked
;1152:					if (cgs.clientinfo[cg.clientNum].team == TEAM_BLUE) {
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $366
line 1153
;1153:						CG_AddBufferedSound( cgs.media.yourBaseIsUnderAttackSound );
ADDRGP4 cgs+156680+1040
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1154
;1154:					}
line 1155
;1155:					break;
ADDRGP4 $366
JUMPV
LABELV $912
line 1158
;1156:
;1157:				case GTS_REDTEAM_SCORED:
;1158:					CG_AddBufferedSound(cgs.media.redScoredSound);
ADDRGP4 cgs+156680+960
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1159
;1159:					break;
ADDRGP4 $366
JUMPV
LABELV $915
line 1161
;1160:				case GTS_BLUETEAM_SCORED:
;1161:					CG_AddBufferedSound(cgs.media.blueScoredSound);
ADDRGP4 cgs+156680+964
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1162
;1162:					break;
ADDRGP4 $366
JUMPV
LABELV $918
line 1164
;1163:				case GTS_REDTEAM_TOOK_LEAD:
;1164:					CG_AddBufferedSound(cgs.media.redLeadsSound);
ADDRGP4 cgs+156680+968
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1165
;1165:					break;
ADDRGP4 $366
JUMPV
LABELV $921
line 1167
;1166:				case GTS_BLUETEAM_TOOK_LEAD:
;1167:					CG_AddBufferedSound(cgs.media.blueLeadsSound);
ADDRGP4 cgs+156680+972
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1168
;1168:					break;
ADDRGP4 $366
JUMPV
LABELV $924
line 1170
;1169:				case GTS_TEAMS_ARE_TIED:
;1170:					CG_AddBufferedSound( cgs.media.teamsTiedSound );
ADDRGP4 cgs+156680+976
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1171
;1171:					break;
line 1178
;1172:#ifdef MISSIONPACK
;1173:				case GTS_KAMIKAZE:
;1174:					trap_S_StartLocalSound(cgs.media.kamikazeFarSound, CHAN_ANNOUNCER);
;1175:					break;
;1176:#endif
;1177:				default:
;1178:					break;
line 1180
;1179:			}
;1180:			break;
ADDRGP4 $366
JUMPV
LABELV $928
line 1186
;1181:		}
;1182:
;1183:	case EV_PAIN:
;1184:		// local player sounds are triggered in CG_CheckLocalSounds,
;1185:		// so ignore events on the player
;1186:		DEBUGNAME("EV_PAIN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $929
ADDRGP4 $932
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $929
line 1187
;1187:		if ( cent->currentState.number != cg.snap->ps.clientNum ) {
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
EQI4 $366
line 1188
;1188:			CG_PainEvent( cent, es->eventParm );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_PainEvent
CALLV
pop
line 1189
;1189:		}
line 1190
;1190:		break;
ADDRGP4 $366
JUMPV
LABELV $936
line 1195
;1191:
;1192:	case EV_DEATH1:
;1193:	case EV_DEATH2:
;1194:	case EV_DEATH3:
;1195:		DEBUGNAME("EV_DEATHx");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $937
ADDRGP4 $940
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $937
line 1196
;1196:		trap_S_StartSound( NULL, es->number, CHAN_VOICE, 
ADDRGP4 $941
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 57
SUBI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 96
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 100
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1198
;1197:				CG_CustomSound( es->number, va("*death%i.wav", event - EV_DEATH1 + 1) ) );
;1198:		break;
ADDRGP4 $366
JUMPV
LABELV $942
line 1202
;1199:
;1200:
;1201:	case EV_OBITUARY:
;1202:		DEBUGNAME("EV_OBITUARY");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $943
ADDRGP4 $946
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $943
line 1203
;1203:		CG_Obituary( es );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Obituary
CALLV
pop
line 1204
;1204:		break;
ADDRGP4 $366
JUMPV
LABELV $947
line 1210
;1205:
;1206:	//
;1207:	// powerup events
;1208:	//
;1209:	case EV_POWERUP_QUAD:
;1210:		DEBUGNAME("EV_POWERUP_QUAD");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $948
ADDRGP4 $951
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $948
line 1211
;1211:		if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $952
line 1212
;1212:			cg.powerupActive = PW_QUAD;
ADDRGP4 cg+130556
CNSTI4 1
ASGNI4
line 1213
;1213:			cg.powerupTime = cg.time;
ADDRGP4 cg+130560
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1214
;1214:		}
LABELV $952
line 1215
;1215:		trap_S_StartSound (NULL, es->number, CHAN_ITEM, cgs.media.quadSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 cgs+156680+604
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1216
;1216:		break;
ADDRGP4 $366
JUMPV
LABELV $960
line 1218
;1217:	case EV_POWERUP_BATTLESUIT:
;1218:		DEBUGNAME("EV_POWERUP_BATTLESUIT");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $961
ADDRGP4 $964
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $961
line 1219
;1219:		if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $965
line 1220
;1220:			cg.powerupActive = PW_BATTLESUIT;
ADDRGP4 cg+130556
CNSTI4 2
ASGNI4
line 1221
;1221:			cg.powerupTime = cg.time;
ADDRGP4 cg+130560
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1222
;1222:		}
LABELV $965
line 1223
;1223:		trap_S_StartSound (NULL, es->number, CHAN_ITEM, cgs.media.protectSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 cgs+156680+1088
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1224
;1224:		break;
ADDRGP4 $366
JUMPV
LABELV $973
line 1226
;1225:	case EV_POWERUP_REGEN:
;1226:		DEBUGNAME("EV_POWERUP_REGEN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $974
ADDRGP4 $977
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $974
line 1227
;1227:		if ( es->number == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $978
line 1228
;1228:			cg.powerupActive = PW_REGEN;
ADDRGP4 cg+130556
CNSTI4 5
ASGNI4
line 1229
;1229:			cg.powerupTime = cg.time;
ADDRGP4 cg+130560
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1230
;1230:		}
LABELV $978
line 1231
;1231:		trap_S_StartSound (NULL, es->number, CHAN_ITEM, cgs.media.regenSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 cgs+156680+1084
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1232
;1232:		break;
ADDRGP4 $366
JUMPV
LABELV $986
line 1235
;1233:
;1234:	case EV_GIB_PLAYER:
;1235:		DEBUGNAME("EV_GIB_PLAYER");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $987
ADDRGP4 $990
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $987
line 1239
;1236:		// don't play gib sound when using the kamikaze because it interferes
;1237:		// with the kamikaze sound, downside is that the gib sound will also
;1238:		// not be played when someone is gibbed while just carrying the kamikaze
;1239:		if ( !(es->eFlags & EF_KAMIKAZE) ) {
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
NEI4 $991
line 1240
;1240:			trap_S_StartSound( NULL, es->number, CHAN_BODY, cgs.media.gibSound );
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+156680+772
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1241
;1241:		}
LABELV $991
line 1242
;1242:		CG_GibPlayer( cent->lerpOrigin );
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
ARGP4
ADDRGP4 CG_GibPlayer
CALLV
pop
line 1243
;1243:		break;
ADDRGP4 $366
JUMPV
LABELV $995
line 1246
;1244:
;1245:	case EV_STOPLOOPINGSOUND:
;1246:		DEBUGNAME("EV_STOPLOOPINGSOUND");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $996
ADDRGP4 $999
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $996
line 1247
;1247:		trap_S_StopLoopingSound( es->number );
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StopLoopingSound
CALLV
pop
line 1248
;1248:		es->loopSound = 0;
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
CNSTI4 0
ASGNI4
line 1249
;1249:		break;
ADDRGP4 $366
JUMPV
LABELV $1000
line 1252
;1250:
;1251:	case EV_DEBUG_LINE:
;1252:		DEBUGNAME("EV_DEBUG_LINE");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1001
ADDRGP4 $1004
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1001
line 1253
;1253:		CG_Beam( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Beam
CALLV
pop
line 1254
;1254:		break;
ADDRGP4 $366
JUMPV
LABELV $365
line 1257
;1255:
;1256:	default:
;1257:		DEBUGNAME("UNKNOWN");
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $1005
ADDRGP4 $1008
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1005
line 1258
;1258:		CG_Error( "Unknown event: %i", event );
ADDRGP4 $1009
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 1259
;1259:		break;
LABELV $366
line 1262
;1260:	}
;1261:
;1262:}
LABELV $347
endproc CG_EntityEvent 112 48
export CG_CheckEvents
proc CG_CheckEvents 8 12
line 1271
;1263:
;1264:
;1265:/*
;1266:==============
;1267:CG_CheckEvents
;1268:
;1269:==============
;1270:*/
;1271:void CG_CheckEvents( centity_t *cent ) {
line 1273
;1272:	// check for event-only entities
;1273:	if ( cent->currentState.eType > ET_EVENTS ) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
LEI4 $1013
line 1274
;1274:		if ( cent->previousEvent ) {
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1015
line 1275
;1275:			return;	// already fired
ADDRGP4 $1012
JUMPV
LABELV $1015
line 1278
;1276:		}
;1277:		// if this is a player event set the entity number of the client entity number
;1278:		if ( cent->currentState.eFlags & EF_PLAYER_EVENT ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1017
line 1279
;1279:			cent->currentState.number = cent->currentState.otherEntityNum;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 1280
;1280:		}
LABELV $1017
line 1282
;1281:
;1282:		cent->previousEvent = 1;
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
CNSTI4 1
ASGNI4
line 1284
;1283:
;1284:		cent->currentState.event = cent->currentState.eType - ET_EVENTS;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
SUBI4
ASGNI4
line 1285
;1285:	} else {
ADDRGP4 $1014
JUMPV
LABELV $1013
line 1287
;1286:		// check for events riding with another entity
;1287:		if ( cent->currentState.event == cent->previousEvent ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
NEI4 $1019
line 1288
;1288:			return;
ADDRGP4 $1012
JUMPV
LABELV $1019
line 1290
;1289:		}
;1290:		cent->previousEvent = cent->currentState.event;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 428
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ASGNI4
line 1291
;1291:		if ( ( cent->currentState.event & ~EV_EVENT_BITS ) == 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
CNSTI4 0
NEI4 $1021
line 1292
;1292:			return;
ADDRGP4 $1012
JUMPV
LABELV $1021
line 1294
;1293:		}
;1294:	}
LABELV $1014
line 1297
;1295:
;1296:	// calculate the position at exactly the frame time
;1297:	BG_EvaluateTrajectory( &cent->currentState.pos, cg.snap->serverTime, cent->lerpOrigin );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 1298
;1298:	CG_SetEntitySoundPosition( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetEntitySoundPosition
CALLV
pop
line 1300
;1299:
;1300:	CG_EntityEvent( cent, cent->lerpOrigin );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 704
ADDP4
ARGP4
ADDRGP4 CG_EntityEvent
CALLV
pop
line 1301
;1301:}
LABELV $1012
endproc CG_CheckEvents 8 12
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
import CG_InitConsoleCommands
import CG_ConsoleCommand
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
LABELV $1009
byte 1 85
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1008
byte 1 85
byte 1 78
byte 1 75
byte 1 78
byte 1 79
byte 1 87
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $1004
byte 1 69
byte 1 86
byte 1 95
byte 1 68
byte 1 69
byte 1 66
byte 1 85
byte 1 71
byte 1 95
byte 1 76
byte 1 73
byte 1 78
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $999
byte 1 69
byte 1 86
byte 1 95
byte 1 83
byte 1 84
byte 1 79
byte 1 80
byte 1 76
byte 1 79
byte 1 79
byte 1 80
byte 1 73
byte 1 78
byte 1 71
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $990
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 73
byte 1 66
byte 1 95
byte 1 80
byte 1 76
byte 1 65
byte 1 89
byte 1 69
byte 1 82
byte 1 10
byte 1 0
align 1
LABELV $977
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 79
byte 1 87
byte 1 69
byte 1 82
byte 1 85
byte 1 80
byte 1 95
byte 1 82
byte 1 69
byte 1 71
byte 1 69
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $964
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 79
byte 1 87
byte 1 69
byte 1 82
byte 1 85
byte 1 80
byte 1 95
byte 1 66
byte 1 65
byte 1 84
byte 1 84
byte 1 76
byte 1 69
byte 1 83
byte 1 85
byte 1 73
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $951
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 79
byte 1 87
byte 1 69
byte 1 82
byte 1 85
byte 1 80
byte 1 95
byte 1 81
byte 1 85
byte 1 65
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $946
byte 1 69
byte 1 86
byte 1 95
byte 1 79
byte 1 66
byte 1 73
byte 1 84
byte 1 85
byte 1 65
byte 1 82
byte 1 89
byte 1 10
byte 1 0
align 1
LABELV $941
byte 1 42
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $940
byte 1 69
byte 1 86
byte 1 95
byte 1 68
byte 1 69
byte 1 65
byte 1 84
byte 1 72
byte 1 120
byte 1 10
byte 1 0
align 1
LABELV $932
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 65
byte 1 73
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $805
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 76
byte 1 79
byte 1 66
byte 1 65
byte 1 76
byte 1 95
byte 1 84
byte 1 69
byte 1 65
byte 1 77
byte 1 95
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $794
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 76
byte 1 79
byte 1 66
byte 1 65
byte 1 76
byte 1 95
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $785
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 69
byte 1 78
byte 1 69
byte 1 82
byte 1 65
byte 1 76
byte 1 95
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $774
byte 1 69
byte 1 86
byte 1 95
byte 1 83
byte 1 72
byte 1 79
byte 1 84
byte 1 71
byte 1 85
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $763
byte 1 69
byte 1 86
byte 1 95
byte 1 66
byte 1 85
byte 1 76
byte 1 76
byte 1 69
byte 1 84
byte 1 95
byte 1 72
byte 1 73
byte 1 84
byte 1 95
byte 1 70
byte 1 76
byte 1 69
byte 1 83
byte 1 72
byte 1 10
byte 1 0
align 1
LABELV $752
byte 1 69
byte 1 86
byte 1 95
byte 1 66
byte 1 85
byte 1 76
byte 1 76
byte 1 69
byte 1 84
byte 1 95
byte 1 72
byte 1 73
byte 1 84
byte 1 95
byte 1 87
byte 1 65
byte 1 76
byte 1 76
byte 1 10
byte 1 0
align 1
LABELV $739
byte 1 69
byte 1 86
byte 1 95
byte 1 82
byte 1 65
byte 1 73
byte 1 76
byte 1 84
byte 1 82
byte 1 65
byte 1 73
byte 1 76
byte 1 10
byte 1 0
align 1
LABELV $734
byte 1 69
byte 1 86
byte 1 95
byte 1 77
byte 1 73
byte 1 83
byte 1 83
byte 1 73
byte 1 76
byte 1 69
byte 1 95
byte 1 77
byte 1 73
byte 1 83
byte 1 83
byte 1 95
byte 1 77
byte 1 69
byte 1 84
byte 1 65
byte 1 76
byte 1 10
byte 1 0
align 1
LABELV $729
byte 1 69
byte 1 86
byte 1 95
byte 1 77
byte 1 73
byte 1 83
byte 1 83
byte 1 73
byte 1 76
byte 1 69
byte 1 95
byte 1 77
byte 1 73
byte 1 83
byte 1 83
byte 1 10
byte 1 0
align 1
LABELV $724
byte 1 69
byte 1 86
byte 1 95
byte 1 77
byte 1 73
byte 1 83
byte 1 83
byte 1 73
byte 1 76
byte 1 69
byte 1 95
byte 1 72
byte 1 73
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $719
byte 1 69
byte 1 86
byte 1 95
byte 1 83
byte 1 67
byte 1 79
byte 1 82
byte 1 69
byte 1 80
byte 1 76
byte 1 85
byte 1 77
byte 1 10
byte 1 0
align 1
LABELV $708
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 82
byte 1 69
byte 1 78
byte 1 65
byte 1 68
byte 1 69
byte 1 95
byte 1 66
byte 1 79
byte 1 85
byte 1 78
byte 1 67
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $700
byte 1 69
byte 1 86
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 95
byte 1 82
byte 1 69
byte 1 83
byte 1 80
byte 1 65
byte 1 87
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $693
byte 1 69
byte 1 86
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 95
byte 1 80
byte 1 79
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $686
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 76
byte 1 65
byte 1 89
byte 1 69
byte 1 82
byte 1 95
byte 1 84
byte 1 69
byte 1 76
byte 1 69
byte 1 80
byte 1 79
byte 1 82
byte 1 84
byte 1 95
byte 1 79
byte 1 85
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $679
byte 1 69
byte 1 86
byte 1 95
byte 1 80
byte 1 76
byte 1 65
byte 1 89
byte 1 69
byte 1 82
byte 1 95
byte 1 84
byte 1 69
byte 1 76
byte 1 69
byte 1 80
byte 1 79
byte 1 82
byte 1 84
byte 1 95
byte 1 73
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $674
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 49
byte 1 52
byte 1 10
byte 1 0
align 1
LABELV $669
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 49
byte 1 51
byte 1 10
byte 1 0
align 1
LABELV $664
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 49
byte 1 50
byte 1 10
byte 1 0
align 1
LABELV $659
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 49
byte 1 49
byte 1 10
byte 1 0
align 1
LABELV $654
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 49
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $649
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 57
byte 1 10
byte 1 0
align 1
LABELV $644
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 56
byte 1 10
byte 1 0
align 1
LABELV $639
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 55
byte 1 10
byte 1 0
align 1
LABELV $634
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 54
byte 1 10
byte 1 0
align 1
LABELV $629
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 53
byte 1 10
byte 1 0
align 1
LABELV $624
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 52
byte 1 10
byte 1 0
align 1
LABELV $619
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 51
byte 1 10
byte 1 0
align 1
LABELV $614
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 50
byte 1 10
byte 1 0
align 1
LABELV $609
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 49
byte 1 10
byte 1 0
align 1
LABELV $604
byte 1 69
byte 1 86
byte 1 95
byte 1 85
byte 1 83
byte 1 69
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $599
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 73
byte 1 82
byte 1 69
byte 1 95
byte 1 87
byte 1 69
byte 1 65
byte 1 80
byte 1 79
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $592
byte 1 69
byte 1 86
byte 1 95
byte 1 67
byte 1 72
byte 1 65
byte 1 78
byte 1 71
byte 1 69
byte 1 95
byte 1 87
byte 1 69
byte 1 65
byte 1 80
byte 1 79
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $587
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 73
byte 1 82
byte 1 69
byte 1 95
byte 1 71
byte 1 82
byte 1 65
byte 1 80
byte 1 80
byte 1 76
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $579
byte 1 69
byte 1 86
byte 1 95
byte 1 78
byte 1 79
byte 1 65
byte 1 77
byte 1 77
byte 1 79
byte 1 10
byte 1 0
align 1
LABELV $565
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 76
byte 1 79
byte 1 66
byte 1 65
byte 1 76
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 95
byte 1 80
byte 1 73
byte 1 67
byte 1 75
byte 1 85
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $547
byte 1 69
byte 1 86
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 95
byte 1 80
byte 1 73
byte 1 67
byte 1 75
byte 1 85
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $542
byte 1 42
byte 1 103
byte 1 97
byte 1 115
byte 1 112
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $541
byte 1 69
byte 1 86
byte 1 95
byte 1 87
byte 1 65
byte 1 84
byte 1 69
byte 1 82
byte 1 95
byte 1 67
byte 1 76
byte 1 69
byte 1 65
byte 1 82
byte 1 10
byte 1 0
align 1
LABELV $534
byte 1 69
byte 1 86
byte 1 95
byte 1 87
byte 1 65
byte 1 84
byte 1 69
byte 1 82
byte 1 95
byte 1 85
byte 1 78
byte 1 68
byte 1 69
byte 1 82
byte 1 10
byte 1 0
align 1
LABELV $527
byte 1 69
byte 1 86
byte 1 95
byte 1 87
byte 1 65
byte 1 84
byte 1 69
byte 1 82
byte 1 95
byte 1 76
byte 1 69
byte 1 65
byte 1 86
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $520
byte 1 69
byte 1 86
byte 1 95
byte 1 87
byte 1 65
byte 1 84
byte 1 69
byte 1 82
byte 1 95
byte 1 84
byte 1 79
byte 1 85
byte 1 67
byte 1 72
byte 1 10
byte 1 0
align 1
LABELV $515
byte 1 42
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $514
byte 1 69
byte 1 86
byte 1 95
byte 1 84
byte 1 65
byte 1 85
byte 1 78
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $509
byte 1 69
byte 1 86
byte 1 95
byte 1 74
byte 1 85
byte 1 77
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $504
byte 1 42
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $497
byte 1 69
byte 1 86
byte 1 95
byte 1 74
byte 1 85
byte 1 77
byte 1 80
byte 1 95
byte 1 80
byte 1 65
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $467
byte 1 69
byte 1 86
byte 1 95
byte 1 83
byte 1 84
byte 1 69
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $454
byte 1 42
byte 1 102
byte 1 97
byte 1 108
byte 1 108
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $453
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 65
byte 1 76
byte 1 76
byte 1 95
byte 1 70
byte 1 65
byte 1 82
byte 1 10
byte 1 0
align 1
LABELV $440
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 65
byte 1 76
byte 1 76
byte 1 95
byte 1 77
byte 1 69
byte 1 68
byte 1 73
byte 1 85
byte 1 77
byte 1 10
byte 1 0
align 1
LABELV $425
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 65
byte 1 76
byte 1 76
byte 1 95
byte 1 83
byte 1 72
byte 1 79
byte 1 82
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $414
byte 1 69
byte 1 86
byte 1 95
byte 1 83
byte 1 87
byte 1 73
byte 1 77
byte 1 10
byte 1 0
align 1
LABELV $403
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 79
byte 1 79
byte 1 84
byte 1 87
byte 1 65
byte 1 68
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $392
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 79
byte 1 79
byte 1 84
byte 1 83
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 72
byte 1 10
byte 1 0
align 1
LABELV $381
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 79
byte 1 79
byte 1 84
byte 1 83
byte 1 84
byte 1 69
byte 1 80
byte 1 95
byte 1 77
byte 1 69
byte 1 84
byte 1 65
byte 1 76
byte 1 10
byte 1 0
align 1
LABELV $371
byte 1 69
byte 1 86
byte 1 95
byte 1 70
byte 1 79
byte 1 79
byte 1 84
byte 1 83
byte 1 84
byte 1 69
byte 1 80
byte 1 10
byte 1 0
align 1
LABELV $357
byte 1 90
byte 1 69
byte 1 82
byte 1 79
byte 1 69
byte 1 86
byte 1 69
byte 1 78
byte 1 84
byte 1 10
byte 1 0
align 1
LABELV $351
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 37
byte 1 51
byte 1 105
byte 1 32
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 37
byte 1 51
byte 1 105
byte 1 32
byte 1 0
align 1
LABELV $345
byte 1 42
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 49
byte 1 48
byte 1 48
byte 1 95
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $344
byte 1 42
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 55
byte 1 53
byte 1 95
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $341
byte 1 42
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 53
byte 1 48
byte 1 95
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $338
byte 1 42
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 50
byte 1 53
byte 1 95
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $296
byte 1 85
byte 1 115
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $295
byte 1 78
byte 1 111
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $285
byte 1 37
byte 1 115
byte 1 32
byte 1 100
byte 1 105
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $284
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $279
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $278
byte 1 39
byte 1 115
byte 1 32
byte 1 112
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 97
byte 1 108
byte 1 32
byte 1 115
byte 1 112
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $277
byte 1 116
byte 1 114
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $275
byte 1 39
byte 1 115
byte 1 32
byte 1 66
byte 1 70
byte 1 71
byte 1 0
align 1
LABELV $274
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 98
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $272
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 114
byte 1 111
byte 1 99
byte 1 117
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $270
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $267
byte 1 39
byte 1 115
byte 1 32
byte 1 112
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
LABELV $266
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $264
byte 1 97
byte 1 108
byte 1 109
byte 1 111
byte 1 115
byte 1 116
byte 1 32
byte 1 100
byte 1 111
byte 1 100
byte 1 103
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $262
byte 1 39
byte 1 115
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $260
byte 1 39
byte 1 115
byte 1 32
byte 1 115
byte 1 104
byte 1 114
byte 1 97
byte 1 112
byte 1 110
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $259
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 104
byte 1 114
byte 1 101
byte 1 100
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $257
byte 1 39
byte 1 115
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $256
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $254
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 103
byte 1 117
byte 1 110
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $252
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 109
byte 1 97
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 101
byte 1 103
byte 1 117
byte 1 110
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $250
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 112
byte 1 117
byte 1 109
byte 1 109
byte 1 101
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $248
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 99
byte 1 97
byte 1 117
byte 1 103
byte 1 104
byte 1 116
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $237
byte 1 110
byte 1 111
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $227
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 37
byte 1 115
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $216
byte 1 37
byte 1 115
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $208
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $205
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $196
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $192
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $191
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $188
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $185
byte 1 115
byte 1 104
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 115
byte 1 109
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 114
byte 1 32
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $183
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $182
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $179
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $175
byte 1 98
byte 1 108
byte 1 101
byte 1 119
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $174
byte 1 98
byte 1 108
byte 1 101
byte 1 119
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $171
byte 1 98
byte 1 108
byte 1 101
byte 1 119
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $167
byte 1 116
byte 1 114
byte 1 105
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $166
byte 1 116
byte 1 114
byte 1 105
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $163
byte 1 116
byte 1 114
byte 1 105
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $151
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 119
byte 1 114
byte 1 111
byte 1 110
byte 1 103
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $149
byte 1 115
byte 1 97
byte 1 119
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $147
byte 1 100
byte 1 111
byte 1 101
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 102
byte 1 108
byte 1 105
byte 1 112
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 111
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 108
byte 1 97
byte 1 118
byte 1 97
byte 1 0
align 1
LABELV $145
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $143
byte 1 115
byte 1 97
byte 1 110
byte 1 107
byte 1 32
byte 1 108
byte 1 105
byte 1 107
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $141
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 113
byte 1 117
byte 1 105
byte 1 115
byte 1 104
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $139
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
LABELV $137
byte 1 115
byte 1 117
byte 1 105
byte 1 99
byte 1 105
byte 1 100
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $133
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $132
byte 1 110
byte 1 0
align 1
LABELV $116
byte 1 67
byte 1 71
byte 1 95
byte 1 79
byte 1 98
byte 1 105
byte 1 116
byte 1 117
byte 1 97
byte 1 114
byte 1 121
byte 1 58
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $111
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $110
byte 1 37
byte 1 105
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $109
byte 1 37
byte 1 105
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $106
byte 1 37
byte 1 105
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $103
byte 1 37
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $100
byte 1 49
byte 1 51
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $97
byte 1 49
byte 1 50
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $94
byte 1 49
byte 1 49
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $91
byte 1 94
byte 1 51
byte 1 51
byte 1 114
byte 1 100
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $88
byte 1 94
byte 1 49
byte 1 50
byte 1 110
byte 1 100
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $85
byte 1 94
byte 1 52
byte 1 49
byte 1 115
byte 1 116
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $82
byte 1 0
align 1
LABELV $81
byte 1 84
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 0
