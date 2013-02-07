data
export cg_customSoundNames
align 4
LABELV cg_customSoundNames
address $77
address $78
address $79
address $80
address $81
address $82
address $83
address $84
address $85
address $86
address $87
address $88
address $89
skip 76
export isTeammate
code
proc isTeammate 0 0
file "../cg_players.c"
line 28
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_players.c -- handle the media and animation for player entities
;4:#include "cg_local.h"
;5:
;6:char	*cg_customSoundNames[MAX_CUSTOM_SOUNDS] = {
;7:	"*death1.wav",
;8:	"*death2.wav",
;9:	"*death3.wav",
;10:	"*jump1.wav",
;11:	"*pain25_1.wav",
;12:	"*pain50_1.wav",
;13:	"*pain75_1.wav",
;14:	"*pain100_1.wav",
;15:	"*falling1.wav",
;16:	"*gasp.wav",
;17:	"*drown.wav",
;18:	"*fall1.wav",
;19:	"*taunt.wav"
;20:};
;21:
;22:/*
;23:================
;24:Determine whether client is on localClient's team.
;25://Evo:Model:Begin
;26:================
;27:*/
;28:qboolean isTeammate ( clientInfo_t *ci, int clientNum ) {
line 29
;29:	if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $91
line 30
;30:		if ( !ci->localClient ) {
ADDRFP4 0
INDIRP4
CNSTI4 1768
ADDP4
INDIRI4
CNSTI4 0
NEI4 $94
line 31
;31:			if ( ci->team == cgs.clientinfo[cg.clientNum].team ) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
NEI4 $96
line 32
;32:				if ( ci->team != TEAM_SPECTATOR ) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 3
EQI4 $101
line 33
;33:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $90
JUMPV
LABELV $101
line 35
;34:				}
;35:			}
LABELV $96
line 36
;36:		}
LABELV $94
line 37
;37:	}
LABELV $91
line 38
;38:	return qfalse;
CNSTI4 0
RETI4
LABELV $90
endproc isTeammate 0 0
export isEnemy
proc isEnemy 0 0
line 41
;39:}
;40://Evo:Model:Continue
;41:qboolean isEnemy ( clientInfo_t *ci, int clientNum ) {
line 42
;42:	if ( cgs.clientinfo[cg.clientNum].team != TEAM_SPECTATOR ) {
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 3
EQI4 $104
line 43
;43:		if ( cgs.gametype >= GT_TEAM) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $109
line 44
;44:			if ( !ci->localClient ) {
ADDRFP4 0
INDIRP4
CNSTI4 1768
ADDP4
INDIRI4
CNSTI4 0
NEI4 $110
line 45
;45:				if ( ci->team != cgs.clientinfo[cg.clientNum].team ) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
EQI4 $110
line 46
;46:					if ( ci->team != TEAM_SPECTATOR ) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 3
EQI4 $110
line 47
;47:							return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $103
JUMPV
line 49
;48:					}
;49:				}
line 50
;50:			}
line 51
;51:		} else if ( cgs.gametype < GT_TEAM ) {
LABELV $109
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
GEI4 $121
line 52
;52:			if ( !ci->localClient ) {
ADDRFP4 0
INDIRP4
CNSTI4 1768
ADDP4
INDIRI4
CNSTI4 0
NEI4 $124
line 53
;53:				if ( ci->team == TEAM_FREE ) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 0
NEI4 $126
line 54
;54:						return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $103
JUMPV
LABELV $126
line 56
;55:				}
;56:			}
LABELV $124
line 57
;57:		}
LABELV $121
LABELV $110
line 58
;58:	}
LABELV $104
line 59
;59:	return qfalse;
CNSTI4 0
RETI4
LABELV $103
endproc isEnemy 0 0
export CG_CustomSound
proc CG_CustomSound 16 8
line 69
;60:}
;61://Evo:Model:End
;62:
;63:/*
;64:================
;65:CG_CustomSound
;66:
;67:================
;68:*/
;69:sfxHandle_t	CG_CustomSound( int clientNum, const char *soundName ) {
line 73
;70:	clientInfo_t *ci;
;71:	int			i;
;72:
;73:	if ( soundName[0] != '*' ) {
ADDRFP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
EQI4 $129
line 74
;74:		return trap_S_RegisterSound( soundName, qfalse );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $128
JUMPV
LABELV $129
line 77
;75:	}
;76:
;77:	if ( clientNum < 0 || clientNum >= MAX_CLIENTS ) {
ADDRLP4 8
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $133
ADDRLP4 8
INDIRI4
CNSTI4 64
LTI4 $131
LABELV $133
line 78
;78:		clientNum = 0;
ADDRFP4 0
CNSTI4 0
ASGNI4
line 79
;79:	}
LABELV $131
line 80
;80:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 4
CNSTI4 1776
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 cgs+40960
ADDP4
ASGNP4
line 82
;81:
;82:	for ( i = 0 ; i < MAX_CUSTOM_SOUNDS && cg_customSoundNames[i] ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $138
JUMPV
LABELV $135
line 83
;83:		if ( !strcmp( soundName, cg_customSoundNames[i] ) ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_customSoundNames
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $139
line 84
;84:			return ci->sounds[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 1640
ADDP4
ADDP4
INDIRI4
RETI4
ADDRGP4 $128
JUMPV
LABELV $139
line 86
;85:		}
;86:	}
LABELV $136
line 82
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $138
ADDRLP4 0
INDIRI4
CNSTI4 32
GEI4 $141
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_customSoundNames
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $135
LABELV $141
line 88
;87:
;88:	CG_Error( "Unknown custom sound: %s", soundName );
ADDRGP4 $142
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 89
;89:	return 0;
CNSTI4 0
RETI4
LABELV $128
endproc CG_CustomSound 16 8
proc CG_ParseAnimationFile 20084 12
line 110
;90:}
;91:
;92:
;93:
;94:/*
;95:=============================================================================
;96:
;97:CLIENT INFO
;98:
;99:=============================================================================
;100:*/
;101:
;102:/*
;103:======================
;104:CG_ParseAnimationFile
;105:
;106:Read a configuration file containing animation coutns and rates
;107:models/players/visor/animation.cfg, etc
;108:======================
;109:*/
;110:static qboolean	CG_ParseAnimationFile( const char *filename, clientInfo_t *ci ) {
line 121
;111:	char		*text_p, *prev;
;112:	int			len;
;113:	int			i;
;114:	char		*token;
;115:	float		fps;
;116:	int			skip;
;117:	char		text[20000];
;118:	fileHandle_t	f;
;119:	animation_t *animations;
;120:
;121:	animations = ci->animations;
ADDRLP4 8
ADDRFP4 4
INDIRP4
CNSTI4 604
ADDP4
ASGNP4
line 124
;122:
;123:	// load the file
;124:	len = trap_FS_FOpenFile( filename, &f, FS_READ );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20032
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 20036
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 20036
INDIRI4
ASGNI4
line 125
;125:	if ( len <= 0 ) {
ADDRLP4 28
INDIRI4
CNSTI4 0
GTI4 $144
line 126
;126:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $143
JUMPV
LABELV $144
line 128
;127:	}
;128:	if ( len >= sizeof( text ) - 1 ) {
ADDRLP4 28
INDIRI4
CVIU4 4
CNSTU4 19999
LTU4 $146
line 129
;129:		CG_Printf( "File %s too long\n", filename );
ADDRGP4 $148
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 130
;130:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $143
JUMPV
LABELV $146
line 132
;131:	}
;132:	trap_FS_Read( text, len, f );
ADDRLP4 32
ARGP4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 20032
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 133
;133:	text[len] = 0;
ADDRLP4 28
INDIRI4
ADDRLP4 32
ADDP4
CNSTI1 0
ASGNI1
line 134
;134:	trap_FS_FCloseFile( f );
ADDRLP4 20032
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 137
;135:
;136:	// parse the text
;137:	text_p = text;
ADDRLP4 12
ADDRLP4 32
ASGNP4
line 138
;138:	skip = 0;	// quite the compiler warning
ADDRLP4 24
CNSTI4 0
ASGNI4
line 140
;139:
;140:	ci->footsteps = FOOTSTEP_NORMAL;
ADDRFP4 4
INDIRP4
CNSTI4 568
ADDP4
CNSTI4 0
ASGNI4
line 141
;141:	VectorClear( ci->headOffset );
ADDRLP4 20040
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20044
CNSTF4 0
ASGNF4
ADDRLP4 20040
INDIRP4
CNSTI4 564
ADDP4
ADDRLP4 20044
INDIRF4
ASGNF4
ADDRLP4 20040
INDIRP4
CNSTI4 560
ADDP4
ADDRLP4 20044
INDIRF4
ASGNF4
ADDRLP4 20040
INDIRP4
CNSTI4 556
ADDP4
ADDRLP4 20044
INDIRF4
ASGNF4
line 142
;142:	ci->gender = GENDER_MALE;
ADDRFP4 4
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 0
ASGNI4
line 143
;143:	ci->fixedlegs = qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 548
ADDP4
CNSTI4 0
ASGNI4
line 144
;144:	ci->fixedtorso = qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 552
ADDP4
CNSTI4 0
ASGNI4
ADDRGP4 $150
JUMPV
LABELV $149
line 147
;145:
;146:	// read optional parameters
;147:	while ( 1 ) {
line 148
;148:		prev = text_p;	// so we can unget
ADDRLP4 20
ADDRLP4 12
INDIRP4
ASGNP4
line 149
;149:		token = COM_Parse( &text_p );
ADDRLP4 12
ARGP4
ADDRLP4 20048
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20048
INDIRP4
ASGNP4
line 150
;150:		if ( !token ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $152
line 151
;151:			break;
ADDRGP4 $151
JUMPV
LABELV $152
line 153
;152:		}
;153:		if ( !Q_stricmp( token, "footsteps" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $156
ARGP4
ADDRLP4 20052
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20052
INDIRI4
CNSTI4 0
NEI4 $154
line 154
;154:			token = COM_Parse( &text_p );
ADDRLP4 12
ARGP4
ADDRLP4 20056
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20056
INDIRP4
ASGNP4
line 155
;155:			if ( !token ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $157
line 156
;156:				break;
ADDRGP4 $151
JUMPV
LABELV $157
line 158
;157:			}
;158:			if ( !Q_stricmp( token, "default" ) || !Q_stricmp( token, "normal" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $161
ARGP4
ADDRLP4 20060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20060
INDIRI4
CNSTI4 0
EQI4 $163
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $162
ARGP4
ADDRLP4 20064
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20064
INDIRI4
CNSTI4 0
NEI4 $159
LABELV $163
line 159
;159:				ci->footsteps = FOOTSTEP_NORMAL;
ADDRFP4 4
INDIRP4
CNSTI4 568
ADDP4
CNSTI4 0
ASGNI4
line 160
;160:			} else if ( !Q_stricmp( token, "boot" ) ) {
ADDRGP4 $150
JUMPV
LABELV $159
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $166
ARGP4
ADDRLP4 20068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20068
INDIRI4
CNSTI4 0
NEI4 $164
line 161
;161:				ci->footsteps = FOOTSTEP_BOOT;
ADDRFP4 4
INDIRP4
CNSTI4 568
ADDP4
CNSTI4 1
ASGNI4
line 162
;162:			} else if ( !Q_stricmp( token, "flesh" ) ) {
ADDRGP4 $150
JUMPV
LABELV $164
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $169
ARGP4
ADDRLP4 20072
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20072
INDIRI4
CNSTI4 0
NEI4 $167
line 163
;163:				ci->footsteps = FOOTSTEP_FLESH;
ADDRFP4 4
INDIRP4
CNSTI4 568
ADDP4
CNSTI4 2
ASGNI4
line 164
;164:			} else if ( !Q_stricmp( token, "mech" ) ) {
ADDRGP4 $150
JUMPV
LABELV $167
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $172
ARGP4
ADDRLP4 20076
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20076
INDIRI4
CNSTI4 0
NEI4 $170
line 165
;165:				ci->footsteps = FOOTSTEP_MECH;
ADDRFP4 4
INDIRP4
CNSTI4 568
ADDP4
CNSTI4 3
ASGNI4
line 166
;166:			} else if ( !Q_stricmp( token, "energy" ) ) {
ADDRGP4 $150
JUMPV
LABELV $170
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $175
ARGP4
ADDRLP4 20080
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20080
INDIRI4
CNSTI4 0
NEI4 $173
line 167
;167:				ci->footsteps = FOOTSTEP_ENERGY;
ADDRFP4 4
INDIRP4
CNSTI4 568
ADDP4
CNSTI4 4
ASGNI4
line 168
;168:			} else {
ADDRGP4 $150
JUMPV
LABELV $173
line 169
;169:				CG_Printf( "Bad footsteps parm in %s: %s\n", filename, token );
ADDRGP4 $176
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 170
;170:			}
line 171
;171:			continue;
ADDRGP4 $150
JUMPV
LABELV $154
line 172
;172:		} else if ( !Q_stricmp( token, "headoffset" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $179
ARGP4
ADDRLP4 20056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20056
INDIRI4
CNSTI4 0
NEI4 $177
line 173
;173:			for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $180
line 174
;174:				token = COM_Parse( &text_p );
ADDRLP4 12
ARGP4
ADDRLP4 20060
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20060
INDIRP4
ASGNP4
line 175
;175:				if ( !token ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $184
line 176
;176:					break;
ADDRGP4 $150
JUMPV
LABELV $184
line 178
;177:				}
;178:				ci->headOffset[i] = atof( token );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20064
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 556
ADDP4
ADDP4
ADDRLP4 20064
INDIRF4
ASGNF4
line 179
;179:			}
LABELV $181
line 173
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 3
LTI4 $180
line 180
;180:			continue;
ADDRGP4 $150
JUMPV
LABELV $177
line 181
;181:		} else if ( !Q_stricmp( token, "sex" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $188
ARGP4
ADDRLP4 20060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20060
INDIRI4
CNSTI4 0
NEI4 $186
line 182
;182:			token = COM_Parse( &text_p );
ADDRLP4 12
ARGP4
ADDRLP4 20064
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20064
INDIRP4
ASGNP4
line 183
;183:			if ( !token ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $189
line 184
;184:				break;
ADDRGP4 $151
JUMPV
LABELV $189
line 186
;185:			}
;186:			if ( token[0] == 'f' || token[0] == 'F' ) {
ADDRLP4 20068
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 20068
INDIRI4
CNSTI4 102
EQI4 $193
ADDRLP4 20068
INDIRI4
CNSTI4 70
NEI4 $191
LABELV $193
line 187
;187:				ci->gender = GENDER_FEMALE;
ADDRFP4 4
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 1
ASGNI4
line 188
;188:			} else if ( token[0] == 'n' || token[0] == 'N' ) {
ADDRGP4 $150
JUMPV
LABELV $191
ADDRLP4 20072
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 20072
INDIRI4
CNSTI4 110
EQI4 $196
ADDRLP4 20072
INDIRI4
CNSTI4 78
NEI4 $194
LABELV $196
line 189
;189:				ci->gender = GENDER_NEUTER;
ADDRFP4 4
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 2
ASGNI4
line 190
;190:			} else {
ADDRGP4 $150
JUMPV
LABELV $194
line 191
;191:				ci->gender = GENDER_MALE;
ADDRFP4 4
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 0
ASGNI4
line 192
;192:			}
line 193
;193:			continue;
ADDRGP4 $150
JUMPV
LABELV $186
line 194
;194:		} else if ( !Q_stricmp( token, "fixedlegs" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $199
ARGP4
ADDRLP4 20064
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20064
INDIRI4
CNSTI4 0
NEI4 $197
line 195
;195:			ci->fixedlegs = qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 548
ADDP4
CNSTI4 1
ASGNI4
line 196
;196:			continue;
ADDRGP4 $150
JUMPV
LABELV $197
line 197
;197:		} else if ( !Q_stricmp( token, "fixedtorso" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $202
ARGP4
ADDRLP4 20068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20068
INDIRI4
CNSTI4 0
NEI4 $200
line 198
;198:			ci->fixedtorso = qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 552
ADDP4
CNSTI4 1
ASGNI4
line 199
;199:			continue;
ADDRGP4 $150
JUMPV
LABELV $200
line 203
;200:		}
;201:
;202:		// if it is a number, start parsing animations
;203:		if ( token[0] >= '0' && token[0] <= '9' ) {
ADDRLP4 20072
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 20072
INDIRI4
CNSTI4 48
LTI4 $203
ADDRLP4 20072
INDIRI4
CNSTI4 57
GTI4 $203
line 204
;204:			text_p = prev;	// unget the token
ADDRLP4 12
ADDRLP4 20
INDIRP4
ASGNP4
line 205
;205:			break;
ADDRGP4 $151
JUMPV
LABELV $203
line 207
;206:		}
;207:		Com_Printf( "unknown token '%s' is %s\n", token, filename );
ADDRGP4 $205
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 208
;208:	}
LABELV $150
line 147
ADDRGP4 $149
JUMPV
LABELV $151
line 211
;209:
;210:	// read information for each frame
;211:	for ( i = 0 ; i < MAX_ANIMATIONS ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $206
line 213
;212:
;213:		token = COM_Parse( &text_p );
ADDRLP4 12
ARGP4
ADDRLP4 20048
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20048
INDIRP4
ASGNP4
line 214
;214:		if ( !*token ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $210
line 215
;215:			if( i >= TORSO_GETFLAG && i <= TORSO_NEGATIVE ) {
ADDRLP4 4
INDIRI4
CNSTI4 25
LTI4 $208
ADDRLP4 4
INDIRI4
CNSTI4 30
GTI4 $208
line 216
;216:				animations[i].firstFrame = animations[TORSO_GESTURE].firstFrame;
CNSTI4 28
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 217
;217:				animations[i].frameLerp = animations[TORSO_GESTURE].frameLerp;
CNSTI4 28
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 12
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ASGNI4
line 218
;218:				animations[i].initialLerp = animations[TORSO_GESTURE].initialLerp;
CNSTI4 28
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 16
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 219
;219:				animations[i].loopFrames = animations[TORSO_GESTURE].loopFrames;
CNSTI4 28
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 8
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ASGNI4
line 220
;220:				animations[i].numFrames = animations[TORSO_GESTURE].numFrames;
CNSTI4 28
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 4
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ASGNI4
line 221
;221:				animations[i].reversed = qfalse;
CNSTI4 28
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
CNSTI4 0
ASGNI4
line 222
;222:				animations[i].flipflop = qfalse;
CNSTI4 28
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 223
;223:				continue;
ADDRGP4 $207
JUMPV
line 225
;224:			}
;225:			break;
LABELV $210
line 227
;226:		}
;227:		animations[i].firstFrame = atoi( token );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20052
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTI4 28
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
ADDRLP4 20052
INDIRI4
ASGNI4
line 229
;228:		// leg only frames are adjusted to not count the upper body only frames
;229:		if ( i == LEGS_WALKCR ) {
ADDRLP4 4
INDIRI4
CNSTI4 13
NEI4 $214
line 230
;230:			skip = animations[LEGS_WALKCR].firstFrame - animations[TORSO_GESTURE].firstFrame;
ADDRLP4 24
ADDRLP4 8
INDIRP4
CNSTI4 364
ADDP4
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
SUBI4
ASGNI4
line 231
;231:		}
LABELV $214
line 232
;232:		if ( i >= LEGS_WALKCR && i<TORSO_GETFLAG) {
ADDRLP4 4
INDIRI4
CNSTI4 13
LTI4 $216
ADDRLP4 4
INDIRI4
CNSTI4 25
GEI4 $216
line 233
;233:			animations[i].firstFrame -= skip;
ADDRLP4 20060
CNSTI4 28
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
ASGNP4
ADDRLP4 20060
INDIRP4
ADDRLP4 20060
INDIRP4
INDIRI4
ADDRLP4 24
INDIRI4
SUBI4
ASGNI4
line 234
;234:		}
LABELV $216
line 236
;235:
;236:		token = COM_Parse( &text_p );
ADDRLP4 12
ARGP4
ADDRLP4 20060
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20060
INDIRP4
ASGNP4
line 237
;237:		if ( !*token ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $218
line 238
;238:			break;
ADDRGP4 $208
JUMPV
LABELV $218
line 240
;239:		}
;240:		animations[i].numFrames = atoi( token );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20064
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTI4 28
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 4
ADDP4
ADDRLP4 20064
INDIRI4
ASGNI4
line 242
;241:
;242:		animations[i].reversed = qfalse;
CNSTI4 28
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
CNSTI4 0
ASGNI4
line 243
;243:		animations[i].flipflop = qfalse;
CNSTI4 28
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 245
;244:		// if numFrames is negative the animation is reversed
;245:		if (animations[i].numFrames < 0) {
CNSTI4 28
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 0
GEI4 $220
line 246
;246:			animations[i].numFrames = -animations[i].numFrames;
ADDRLP4 20068
CNSTI4 28
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 20068
INDIRP4
ADDRLP4 20068
INDIRP4
INDIRI4
NEGI4
ASGNI4
line 247
;247:			animations[i].reversed = qtrue;
CNSTI4 28
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
CNSTI4 1
ASGNI4
line 248
;248:		}
LABELV $220
line 250
;249:
;250:		token = COM_Parse( &text_p );
ADDRLP4 12
ARGP4
ADDRLP4 20068
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20068
INDIRP4
ASGNP4
line 251
;251:		if ( !*token ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $222
line 252
;252:			break;
ADDRGP4 $208
JUMPV
LABELV $222
line 254
;253:		}
;254:		animations[i].loopFrames = atoi( token );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20072
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTI4 28
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 8
ADDP4
ADDRLP4 20072
INDIRI4
ASGNI4
line 256
;255:
;256:		token = COM_Parse( &text_p );
ADDRLP4 12
ARGP4
ADDRLP4 20076
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20076
INDIRP4
ASGNP4
line 257
;257:		if ( !*token ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $224
line 258
;258:			break;
ADDRGP4 $208
JUMPV
LABELV $224
line 260
;259:		}
;260:		fps = atof( token );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20080
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 20080
INDIRF4
ASGNF4
line 261
;261:		if ( fps == 0 ) {
ADDRLP4 16
INDIRF4
CNSTF4 0
NEF4 $226
line 262
;262:			fps = 1;
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
line 263
;263:		}
LABELV $226
line 264
;264:		animations[i].frameLerp = 1000 / fps;
CNSTI4 28
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 12
ADDP4
CNSTF4 1148846080
ADDRLP4 16
INDIRF4
DIVF4
CVFI4 4
ASGNI4
line 265
;265:		animations[i].initialLerp = 1000 / fps;
CNSTI4 28
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI4 16
ADDP4
CNSTF4 1148846080
ADDRLP4 16
INDIRF4
DIVF4
CVFI4 4
ASGNI4
line 266
;266:	}
LABELV $207
line 211
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 31
LTI4 $206
LABELV $208
line 268
;267:
;268:	if ( i != MAX_ANIMATIONS ) {
ADDRLP4 4
INDIRI4
CNSTI4 31
EQI4 $228
line 269
;269:		CG_Printf( "Error parsing animation file: %s", filename );
ADDRGP4 $230
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 270
;270:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $143
JUMPV
LABELV $228
line 274
;271:	}
;272:
;273:	// crouch backward animation
;274:	memcpy(&animations[LEGS_BACKCR], &animations[LEGS_WALKCR], sizeof(animation_t));
ADDRLP4 8
INDIRP4
CNSTI4 896
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 364
ADDP4
ARGP4
CNSTI4 28
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 275
;275:	animations[LEGS_BACKCR].reversed = qtrue;
ADDRLP4 8
INDIRP4
CNSTI4 916
ADDP4
CNSTI4 1
ASGNI4
line 277
;276:	// walk backward animation
;277:	memcpy(&animations[LEGS_BACKWALK], &animations[LEGS_WALK], sizeof(animation_t));
ADDRLP4 8
INDIRP4
CNSTI4 924
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 392
ADDP4
ARGP4
CNSTI4 28
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 278
;278:	animations[LEGS_BACKWALK].reversed = qtrue;
ADDRLP4 8
INDIRP4
CNSTI4 944
ADDP4
CNSTI4 1
ASGNI4
line 280
;279:	// flag moving fast
;280:	animations[FLAG_RUN].firstFrame = 0;
ADDRLP4 8
INDIRP4
CNSTI4 952
ADDP4
CNSTI4 0
ASGNI4
line 281
;281:	animations[FLAG_RUN].numFrames = 16;
ADDRLP4 8
INDIRP4
CNSTI4 956
ADDP4
CNSTI4 16
ASGNI4
line 282
;282:	animations[FLAG_RUN].loopFrames = 16;
ADDRLP4 8
INDIRP4
CNSTI4 960
ADDP4
CNSTI4 16
ASGNI4
line 283
;283:	animations[FLAG_RUN].frameLerp = 1000 / 15;
ADDRLP4 8
INDIRP4
CNSTI4 964
ADDP4
CNSTI4 66
ASGNI4
line 284
;284:	animations[FLAG_RUN].initialLerp = 1000 / 15;
ADDRLP4 8
INDIRP4
CNSTI4 968
ADDP4
CNSTI4 66
ASGNI4
line 285
;285:	animations[FLAG_RUN].reversed = qfalse;
ADDRLP4 8
INDIRP4
CNSTI4 972
ADDP4
CNSTI4 0
ASGNI4
line 287
;286:	// flag not moving or moving slowly
;287:	animations[FLAG_STAND].firstFrame = 16;
ADDRLP4 8
INDIRP4
CNSTI4 980
ADDP4
CNSTI4 16
ASGNI4
line 288
;288:	animations[FLAG_STAND].numFrames = 5;
ADDRLP4 8
INDIRP4
CNSTI4 984
ADDP4
CNSTI4 5
ASGNI4
line 289
;289:	animations[FLAG_STAND].loopFrames = 0;
ADDRLP4 8
INDIRP4
CNSTI4 988
ADDP4
CNSTI4 0
ASGNI4
line 290
;290:	animations[FLAG_STAND].frameLerp = 1000 / 20;
ADDRLP4 8
INDIRP4
CNSTI4 992
ADDP4
CNSTI4 50
ASGNI4
line 291
;291:	animations[FLAG_STAND].initialLerp = 1000 / 20;
ADDRLP4 8
INDIRP4
CNSTI4 996
ADDP4
CNSTI4 50
ASGNI4
line 292
;292:	animations[FLAG_STAND].reversed = qfalse;
ADDRLP4 8
INDIRP4
CNSTI4 1000
ADDP4
CNSTI4 0
ASGNI4
line 294
;293:	// flag speeding up
;294:	animations[FLAG_STAND2RUN].firstFrame = 16;
ADDRLP4 8
INDIRP4
CNSTI4 1008
ADDP4
CNSTI4 16
ASGNI4
line 295
;295:	animations[FLAG_STAND2RUN].numFrames = 5;
ADDRLP4 8
INDIRP4
CNSTI4 1012
ADDP4
CNSTI4 5
ASGNI4
line 296
;296:	animations[FLAG_STAND2RUN].loopFrames = 1;
ADDRLP4 8
INDIRP4
CNSTI4 1016
ADDP4
CNSTI4 1
ASGNI4
line 297
;297:	animations[FLAG_STAND2RUN].frameLerp = 1000 / 15;
ADDRLP4 8
INDIRP4
CNSTI4 1020
ADDP4
CNSTI4 66
ASGNI4
line 298
;298:	animations[FLAG_STAND2RUN].initialLerp = 1000 / 15;
ADDRLP4 8
INDIRP4
CNSTI4 1024
ADDP4
CNSTI4 66
ASGNI4
line 299
;299:	animations[FLAG_STAND2RUN].reversed = qtrue;
ADDRLP4 8
INDIRP4
CNSTI4 1028
ADDP4
CNSTI4 1
ASGNI4
line 309
;300:	//
;301:	// new anims changes
;302:	//
;303://	animations[TORSO_GETFLAG].flipflop = qtrue;
;304://	animations[TORSO_GUARDBASE].flipflop = qtrue;
;305://	animations[TORSO_PATROL].flipflop = qtrue;
;306://	animations[TORSO_AFFIRMATIVE].flipflop = qtrue;
;307://	animations[TORSO_NEGATIVE].flipflop = qtrue;
;308:	//
;309:	return qtrue;
CNSTI4 1
RETI4
LABELV $143
endproc CG_ParseAnimationFile 20084 12
proc CG_FindClientModelFile 44 40
line 334
;310:}
;311:
;312:/*
;313:==========================
;314:CG_FileExists
;315:No longer static, so I can abuse it elsewhere
;316:==========================
;317:*/ /*
;318://static
;319:qboolean	CG_FileExists(const char *filename) {
;320:	int len;
;321:
;322:	len = trap_FS_FOpenFile( filename, 0, FS_READ );
;323:	if (len>0) {
;324:		return qtrue;
;325:	}
;326:	return qfalse;
;327:}*/
;328:
;329:/*
;330:==========================
;331:CG_FindClientModelFile
;332:==========================
;333:*/
;334:static qboolean	CG_FindClientModelFile( char *filename, int length, clientInfo_t *ci, const char *teamName, const char *modelName, const char *skinName, const char *base, const char *ext ) {
line 338
;335:	char *team, *charactersFolder;
;336:	int i;
;337:
;338:	if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $232
line 339
;339:		switch ( ci->team ) {
ADDRLP4 12
ADDRFP4 8
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 2
EQI4 $238
ADDRGP4 $235
JUMPV
LABELV $238
line 340
;340:			case TEAM_BLUE: {
line 341
;341:				team = "blue";
ADDRLP4 8
ADDRGP4 $239
ASGNP4
line 342
;342:				break;
ADDRGP4 $233
JUMPV
LABELV $235
line 344
;343:			}
;344:			default: {
line 345
;345:				team = "red";
ADDRLP4 8
ADDRGP4 $240
ASGNP4
line 346
;346:				break;
line 349
;347:			}
;348:		}
;349:	}
ADDRGP4 $233
JUMPV
LABELV $232
line 350
;350:	else {
line 351
;351:		team = "default";
ADDRLP4 8
ADDRGP4 $161
ASGNP4
line 352
;352:	}
LABELV $233
line 353
;353:	charactersFolder = "";
ADDRLP4 4
ADDRGP4 $241
ASGNP4
ADDRGP4 $243
JUMPV
LABELV $242
line 354
;354:	while(1) {
line 355
;355:		for ( i = 0; i < 2; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $245
line 356
;356:			if ( i == 0 && teamName && *teamName ) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $249
ADDRLP4 16
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $249
ADDRLP4 16
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 12
INDIRI4
EQI4 $249
line 358
;357:				//								"models/players/characters/james/stroggs/lower_lily_red.skin"
;358:				Com_sprintf( filename, length, "models/players/%s%s/%s%s_%s_%s.%s", charactersFolder, modelName, teamName, base, skinName, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $251
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 359
;359:			} else {
ADDRGP4 $250
JUMPV
LABELV $249
line 361
;360:				//								"models/players/characters/james/lower_lily_red.skin"
;361:				Com_sprintf( filename, length, "models/players/%s%s/%s_%s_%s.%s", charactersFolder, modelName, base, skinName, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $252
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 362
;362:			}
LABELV $250
line 363
;363:			if ( CG_FileExists( filename ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $253
line 364
;364:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $231
JUMPV
LABELV $253
line 367
;365:			}
;366:			//Evo:Model:Change
;367:			if ( cgs.gametype >= GT_TEAM && !ci->forceNMEorTM && !ci->localClient || cgs.gametype >= GT_TEAM && ci->localClient && Q_stricmp(skinName, "pm") ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $262
ADDRLP4 24
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRLP4 24
INDIRP4
CNSTI4 1772
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
NEI4 $262
ADDRLP4 24
INDIRP4
CNSTI4 1768
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
EQI4 $260
LABELV $262
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $255
ADDRFP4 8
INDIRP4
CNSTI4 1768
ADDP4
INDIRI4
CNSTI4 0
EQI4 $255
ADDRFP4 20
INDIRP4
ARGP4
ADDRGP4 $259
ARGP4
ADDRLP4 32
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $255
LABELV $260
line 369
;368:				//CG_Printf( "gt_team:models/players/%s%s/%s%s_%s.%s", charactersFolder, modelName, teamName, base, team, ext );
;369:				if ( i == 0 && teamName && *teamName ) {
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $263
ADDRLP4 40
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $263
ADDRLP4 40
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 36
INDIRI4
EQI4 $263
line 371
;370:					//								"models/players/characters/james/stroggs/lower_red.skin"
;371:					Com_sprintf( filename, length, "models/players/%s%s/%s%s_%s.%s", charactersFolder, modelName, teamName, base, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $265
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 372
;372:				} else {
ADDRGP4 $256
JUMPV
LABELV $263
line 374
;373:					//								"models/players/characters/james/lower_red.skin"
;374:					Com_sprintf( filename, length, "models/players/%s%s/%s_%s.%s", charactersFolder, modelName, base, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $266
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 375
;375:				}
line 376
;376:			} else {
ADDRGP4 $256
JUMPV
LABELV $255
line 378
;377:				//CG_Printf( "norm:models/players/%s%s/%s%s_%s.%s", charactersFolder, modelName, teamName, base, skinName, ext );
;378:				if ( i == 0 && teamName && *teamName ) {
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $267
ADDRLP4 40
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $267
ADDRLP4 40
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 36
INDIRI4
EQI4 $267
line 380
;379:					//								"models/players/characters/james/stroggs/lower_lily.skin"
;380:					Com_sprintf( filename, length, "models/players/%s%s/%s%s_%s.%s", charactersFolder, modelName, teamName, base, skinName, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $265
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 381
;381:				} else {
ADDRGP4 $268
JUMPV
LABELV $267
line 383
;382:					//								"models/players/characters/james/lower_lily.skin"
;383:					Com_sprintf( filename, length, "models/players/%s%s/%s_%s.%s", charactersFolder, modelName, base, skinName, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $266
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 384
;384:				}
LABELV $268
line 385
;385:			}
LABELV $256
line 386
;386:			if ( CG_FileExists( filename ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $269
line 387
;387:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $231
JUMPV
LABELV $269
line 389
;388:			}
;389:			if ( !teamName || !*teamName ) {
ADDRLP4 40
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $273
ADDRLP4 40
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $271
LABELV $273
line 390
;390:				break;
ADDRGP4 $247
JUMPV
LABELV $271
line 392
;391:			}
;392:		}
LABELV $246
line 355
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $245
LABELV $247
line 394
;393:		// if tried the heads folder first
;394:		if ( charactersFolder[0] ) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $274
line 395
;395:			break;
ADDRGP4 $244
JUMPV
LABELV $274
line 397
;396:		}
;397:		charactersFolder = "characters/";
ADDRLP4 4
ADDRGP4 $276
ASGNP4
line 398
;398:	}
LABELV $243
line 354
ADDRGP4 $242
JUMPV
LABELV $244
line 400
;399:
;400:	return qfalse;
CNSTI4 0
RETI4
LABELV $231
endproc CG_FindClientModelFile 44 40
proc CG_FindClientHeadFile 44 40
line 408
;401:}
;402:
;403:/*
;404:==========================
;405:CG_FindClientHeadFile
;406:==========================
;407:*/
;408:static qboolean	CG_FindClientHeadFile( char *filename, int length, clientInfo_t *ci, const char *teamName, const char *headModelName, const char *headSkinName, const char *base, const char *ext ) {
line 412
;409:	char *team, *headsFolder;
;410:	int i;
;411:
;412:	if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $278
line 413
;413:		switch ( ci->team ) {
ADDRLP4 12
ADDRFP4 8
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 2
EQI4 $284
ADDRGP4 $281
JUMPV
LABELV $284
line 414
;414:			case TEAM_BLUE: {
line 415
;415:				team = "blue";
ADDRLP4 8
ADDRGP4 $239
ASGNP4
line 416
;416:				break;
ADDRGP4 $279
JUMPV
LABELV $281
line 418
;417:			}
;418:			default: {
line 419
;419:				team = "red";
ADDRLP4 8
ADDRGP4 $240
ASGNP4
line 420
;420:				break;
line 423
;421:			}
;422:		}
;423:	} else {
ADDRGP4 $279
JUMPV
LABELV $278
line 424
;424:		team = "default";
ADDRLP4 8
ADDRGP4 $161
ASGNP4
line 425
;425:	}
LABELV $279
line 427
;426:
;427:	if ( headModelName[0] == '*' ) {
ADDRFP4 16
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $285
line 428
;428:		headsFolder = "heads/";
ADDRLP4 4
ADDRGP4 $287
ASGNP4
line 429
;429:		headModelName++;
ADDRFP4 16
ADDRFP4 16
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 430
;430:	} else {
ADDRGP4 $289
JUMPV
LABELV $285
line 431
;431:		headsFolder = "";
ADDRLP4 4
ADDRGP4 $241
ASGNP4
line 432
;432:	}
ADDRGP4 $289
JUMPV
LABELV $288
line 433
;433:	while(1) {
line 434
;434:		for ( i = 0; i < 2; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $291
line 435
;435:			if ( i == 0 && teamName && *teamName ) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $295
ADDRLP4 16
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $295
ADDRLP4 16
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 12
INDIRI4
EQI4 $295
line 436
;436:				Com_sprintf( filename, length, "models/players/%s%s/%s/%s%s_%s.%s", headsFolder, headModelName, headSkinName, teamName, base, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $297
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 437
;437:			} else {
ADDRGP4 $296
JUMPV
LABELV $295
line 438
;438:				Com_sprintf( filename, length, "models/players/%s%s/%s/%s_%s.%s", headsFolder, headModelName, headSkinName, base, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $298
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 439
;439:			}
LABELV $296
line 440
;440:			if ( CG_FileExists( filename ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $299
line 441
;441:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $277
JUMPV
LABELV $299
line 444
;442:			}
;443:			//Evo:Model:Change
;444:			if ( cgs.gametype >= GT_TEAM && !ci->forceNMEorTM && !ci->localClient || cgs.gametype >= GT_TEAM && ci->localClient && Q_stricmp(headSkinName, "pm") ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $307
ADDRLP4 24
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRLP4 24
INDIRP4
CNSTI4 1772
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
NEI4 $307
ADDRLP4 24
INDIRP4
CNSTI4 1768
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
EQI4 $305
LABELV $307
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $301
ADDRFP4 8
INDIRP4
CNSTI4 1768
ADDP4
INDIRI4
CNSTI4 0
EQI4 $301
ADDRFP4 20
INDIRP4
ARGP4
ADDRGP4 $259
ARGP4
ADDRLP4 32
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $301
LABELV $305
line 445
;445:				if ( i == 0 &&  teamName && *teamName ) {
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $308
ADDRLP4 40
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $308
ADDRLP4 40
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 36
INDIRI4
EQI4 $308
line 446
;446:					Com_sprintf( filename, length, "models/players/%s%s/%s%s_%s.%s", headsFolder, headModelName, teamName, base, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $265
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 447
;447:				} else {
ADDRGP4 $302
JUMPV
LABELV $308
line 448
;448:					Com_sprintf( filename, length, "models/players/%s%s/%s_%s.%s", headsFolder, headModelName, base, team, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $266
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 449
;449:				}
line 450
;450:			} else {
ADDRGP4 $302
JUMPV
LABELV $301
line 451
;451:				if ( i == 0 && teamName && *teamName ) {
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $310
ADDRLP4 40
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $310
ADDRLP4 40
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 36
INDIRI4
EQI4 $310
line 452
;452:					Com_sprintf( filename, length, "models/players/%s%s/%s%s_%s.%s", headsFolder, headModelName, teamName, base, headSkinName, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $265
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 453
;453:				} else {
ADDRGP4 $311
JUMPV
LABELV $310
line 454
;454:					Com_sprintf( filename, length, "models/players/%s%s/%s_%s.%s", headsFolder, headModelName, base, headSkinName, ext );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $266
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 28
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 455
;455:				}
LABELV $311
line 456
;456:			}
LABELV $302
line 457
;457:			if ( CG_FileExists( filename ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $312
line 458
;458:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $277
JUMPV
LABELV $312
line 460
;459:			}
;460:			if ( !teamName || !*teamName ) {
ADDRLP4 40
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $316
ADDRLP4 40
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $314
LABELV $316
line 461
;461:				break;
ADDRGP4 $293
JUMPV
LABELV $314
line 463
;462:			}
;463:		}
LABELV $292
line 434
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $291
LABELV $293
line 465
;464:		// if tried the heads folder first
;465:		if ( headsFolder[0] ) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $317
line 466
;466:			break;
ADDRGP4 $290
JUMPV
LABELV $317
line 468
;467:		}
;468:		headsFolder = "heads/";
ADDRLP4 4
ADDRGP4 $287
ASGNP4
line 469
;469:	}
LABELV $289
line 433
ADDRGP4 $288
JUMPV
LABELV $290
line 471
;470:
;471:	return qfalse;
CNSTI4 0
RETI4
LABELV $277
endproc CG_FindClientHeadFile 44 40
proc CG_RegisterClientSkin 84 32
line 479
;472:}
;473:
;474:/*
;475:==========================
;476:CG_RegisterClientSkin
;477:==========================
;478:*/
;479:static qboolean	CG_RegisterClientSkin( clientInfo_t *ci, const char *teamName, const char *modelName, const char *skinName, const char *headModelName, const char *headSkinName ) {
line 482
;480:	char filename[MAX_QPATH];
;481:	
;482:	if ( CG_FindClientModelFile( filename, sizeof(filename), ci, teamName, modelName, skinName, "lower", "skin" ) ) {
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRFP4 0
INDIRP4
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
ADDRGP4 $322
ARGP4
ADDRGP4 $323
ARGP4
ADDRLP4 64
ADDRGP4 CG_FindClientModelFile
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $320
line 483
;483:		ci->legsSkin = trap_R_RegisterSkin( filename );
ADDRLP4 0
ARGP4
ADDRLP4 68
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 580
ADDP4
ADDRLP4 68
INDIRI4
ASGNI4
line 484
;484:	}
LABELV $320
line 485
;485:	if (!ci->legsSkin) {
ADDRFP4 0
INDIRP4
CNSTI4 580
ADDP4
INDIRI4
CNSTI4 0
NEI4 $324
line 486
;486:		Com_Printf( "Leg skin load failure: %s\n", filename );
ADDRGP4 $326
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 487
;487:	}
LABELV $324
line 489
;488:
;489:	if ( CG_FindClientModelFile( filename, sizeof(filename), ci, teamName, modelName, skinName, "upper", "skin" ) ) {
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRFP4 0
INDIRP4
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
ADDRGP4 $329
ARGP4
ADDRGP4 $323
ARGP4
ADDRLP4 68
ADDRGP4 CG_FindClientModelFile
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $327
line 490
;490:		ci->torsoSkin = trap_R_RegisterSkin( filename );
ADDRLP4 0
ARGP4
ADDRLP4 72
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 588
ADDP4
ADDRLP4 72
INDIRI4
ASGNI4
line 491
;491:	}
LABELV $327
line 492
;492:	if (!ci->torsoSkin) {
ADDRFP4 0
INDIRP4
CNSTI4 588
ADDP4
INDIRI4
CNSTI4 0
NEI4 $330
line 493
;493:		Com_Printf( "Torso skin load failure: %s\n", filename );
ADDRGP4 $332
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 494
;494:	}
LABELV $330
line 496
;495:
;496:	if ( CG_FindClientHeadFile( filename, sizeof(filename), ci, teamName, headModelName, headSkinName, "head", "skin" ) ) {
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRGP4 $335
ARGP4
ADDRGP4 $323
ARGP4
ADDRLP4 72
ADDRGP4 CG_FindClientHeadFile
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
EQI4 $333
line 497
;497:		ci->headSkin = trap_R_RegisterSkin( filename );
ADDRLP4 0
ARGP4
ADDRLP4 76
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 596
ADDP4
ADDRLP4 76
INDIRI4
ASGNI4
line 498
;498:	}
LABELV $333
line 499
;499:	if (!ci->headSkin) {
ADDRFP4 0
INDIRP4
CNSTI4 596
ADDP4
INDIRI4
CNSTI4 0
NEI4 $336
line 500
;500:		Com_Printf( "Head skin load failure: %s\n", filename );
ADDRGP4 $338
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 501
;501:	}
LABELV $336
line 504
;502:
;503:	// if any skins failed to load
;504:	if ( !ci->legsSkin || !ci->torsoSkin || !ci->headSkin ) {
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
CNSTI4 0
ASGNI4
ADDRLP4 76
INDIRP4
CNSTI4 580
ADDP4
INDIRI4
ADDRLP4 80
INDIRI4
EQI4 $342
ADDRLP4 76
INDIRP4
CNSTI4 588
ADDP4
INDIRI4
ADDRLP4 80
INDIRI4
EQI4 $342
ADDRLP4 76
INDIRP4
CNSTI4 596
ADDP4
INDIRI4
ADDRLP4 80
INDIRI4
NEI4 $339
LABELV $342
line 505
;505:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $319
JUMPV
LABELV $339
line 507
;506:	}
;507:	return qtrue;
CNSTI4 1
RETI4
LABELV $319
endproc CG_RegisterClientSkin 84 32
proc CG_RegisterClientModelname 296 32
line 515
;508:}
;509:
;510:/*
;511:==========================
;512:CG_RegisterClientModelname
;513:==========================
;514:*/
;515:static qboolean CG_RegisterClientModelname( clientInfo_t *ci, const char *modelName, const char *skinName, const char *headModelName, const char *headSkinName, const char *teamName ) {
line 519
;516:	char	filename[MAX_QPATH*2];
;517:	const char		*headName;
;518:	char newTeamName[MAX_QPATH*2];
;519:	qboolean		wasVertex = qfalse;//This is used to "reset" vertex after the shader has been loaded
ADDRLP4 132
CNSTI4 0
ASGNI4
line 521
;520:
;521:	if ( r_vertexLight.integer ) {
ADDRGP4 r_vertexLight+12
INDIRI4
CNSTI4 0
EQI4 $344
line 524
;522:		//Skins don't work right in vertex =/
;523:		//Technically you should be able to add this check everywhere this function is called but it was easier to do here I thought
;524:		wasVertex = qtrue;
ADDRLP4 132
CNSTI4 1
ASGNI4
line 525
;525:		trap_Cvar_Set( "r_vertexLight", "0");
ADDRGP4 $347
ARGP4
ADDRGP4 $348
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 526
;526:   }
LABELV $344
line 528
;527:
;528:	if ( headModelName[0] == '\0' ) {
ADDRFP4 12
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $349
line 529
;529:		headName = modelName;
ADDRLP4 128
ADDRFP4 4
INDIRP4
ASGNP4
line 530
;530:	} else {
ADDRGP4 $350
JUMPV
LABELV $349
line 531
;531:		headName = headModelName;
ADDRLP4 128
ADDRFP4 12
INDIRP4
ASGNP4
line 532
;532:	}
LABELV $350
line 533
;533:	Com_sprintf( filename, sizeof( filename ), "models/players/%s/lower.md3", modelName );
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $351
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 534
;534:	ci->legsModel = trap_R_RegisterModel( filename );
ADDRLP4 0
ARGP4
ADDRLP4 264
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
ADDRLP4 264
INDIRI4
ASGNI4
line 535
;535:	if ( !ci->legsModel ) {
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
CNSTI4 0
NEI4 $352
line 536
;536:		Com_sprintf( filename, sizeof( filename ), "models/players/characters/%s/lower.md3", modelName );
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $354
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 537
;537:		ci->legsModel = trap_R_RegisterModel( filename );
ADDRLP4 0
ARGP4
ADDRLP4 268
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
ADDRLP4 268
INDIRI4
ASGNI4
line 538
;538:		if ( !ci->legsModel ) {
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
CNSTI4 0
NEI4 $355
line 539
;539:			if ( cg_debugModels.integer ) {
ADDRGP4 cg_debugModels+12
INDIRI4
CNSTI4 0
EQI4 $357
line 540
;540:				Com_Printf( "Failed to load model file %s\n", filename );
ADDRGP4 $360
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 541
;541:			}
LABELV $357
line 542
;542:			if ( wasVertex ) {
ADDRLP4 132
INDIRI4
CNSTI4 0
EQI4 $361
line 544
;543:				//Reset to vertex
;544:				trap_Cvar_Set( "r_vertexLight", "1");
ADDRGP4 $347
ARGP4
ADDRGP4 $363
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 545
;545:			}
LABELV $361
line 546
;546:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $343
JUMPV
LABELV $355
line 548
;547:		}
;548:	}
LABELV $352
line 550
;549:
;550:	Com_sprintf( filename, sizeof( filename ), "models/players/%s/upper.md3", modelName );
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $364
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 551
;551:	ci->torsoModel = trap_R_RegisterModel( filename );
ADDRLP4 0
ARGP4
ADDRLP4 268
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 584
ADDP4
ADDRLP4 268
INDIRI4
ASGNI4
line 552
;552:	if ( !ci->torsoModel ) {
ADDRFP4 0
INDIRP4
CNSTI4 584
ADDP4
INDIRI4
CNSTI4 0
NEI4 $365
line 553
;553:		Com_sprintf( filename, sizeof( filename ), "models/players/characters/%s/upper.md3", modelName );
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $367
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 554
;554:		ci->torsoModel = trap_R_RegisterModel( filename );
ADDRLP4 0
ARGP4
ADDRLP4 272
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 584
ADDP4
ADDRLP4 272
INDIRI4
ASGNI4
line 555
;555:		if ( !ci->torsoModel ) {
ADDRFP4 0
INDIRP4
CNSTI4 584
ADDP4
INDIRI4
CNSTI4 0
NEI4 $368
line 556
;556:			if ( cg_debugModels.integer ) {
ADDRGP4 cg_debugModels+12
INDIRI4
CNSTI4 0
EQI4 $370
line 557
;557:				Com_Printf( "Failed to load model file %s\n", filename );
ADDRGP4 $360
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 558
;558:			}
LABELV $370
line 559
;559:			if ( wasVertex ) {
ADDRLP4 132
INDIRI4
CNSTI4 0
EQI4 $373
line 561
;560:				//Reset to vertex
;561:				trap_Cvar_Set( "r_vertexLight", "1");
ADDRGP4 $347
ARGP4
ADDRGP4 $363
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 562
;562:			}
LABELV $373
line 563
;563:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $343
JUMPV
LABELV $368
line 565
;564:		}
;565:	}
LABELV $365
line 567
;566:
;567:	if( headName[0] == '*' ) {
ADDRLP4 128
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $375
line 568
;568:		Com_sprintf( filename, sizeof( filename ), "models/players/heads/%s/%s.md3", &headModelName[1], &headModelName[1] );
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $377
ARGP4
ADDRLP4 272
ADDRFP4 12
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 272
INDIRP4
ARGP4
ADDRLP4 272
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 569
;569:	} else {
ADDRGP4 $376
JUMPV
LABELV $375
line 570
;570:		Com_sprintf( filename, sizeof( filename ), "models/players/%s/head.md3", headName );
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $378
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 571
;571:	}
LABELV $376
line 572
;572:	ci->headModel = trap_R_RegisterModel( filename );
ADDRLP4 0
ARGP4
ADDRLP4 272
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 592
ADDP4
ADDRLP4 272
INDIRI4
ASGNI4
line 574
;573:	// if the head model could not be found and we didn't load from the heads folder try to load from there
;574:	if ( !ci->headModel && headName[0] != '*' ) {
ADDRFP4 0
INDIRP4
CNSTI4 592
ADDP4
INDIRI4
CNSTI4 0
NEI4 $379
ADDRLP4 128
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
EQI4 $379
line 575
;575:		Com_sprintf( filename, sizeof( filename ), "models/players/heads/%s/%s.md3", headModelName, headModelName );
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $377
ARGP4
ADDRLP4 276
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 276
INDIRP4
ARGP4
ADDRLP4 276
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 576
;576:		ci->headModel = trap_R_RegisterModel( filename );
ADDRLP4 0
ARGP4
ADDRLP4 280
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 592
ADDP4
ADDRLP4 280
INDIRI4
ASGNI4
line 577
;577:	}
LABELV $379
line 578
;578:	if ( !ci->headModel ) {
ADDRFP4 0
INDIRP4
CNSTI4 592
ADDP4
INDIRI4
CNSTI4 0
NEI4 $381
line 579
;579:		if ( cg_debugModels.integer ) {
ADDRGP4 cg_debugModels+12
INDIRI4
CNSTI4 0
EQI4 $383
line 580
;580:			Com_Printf( "Failed to load model file %s\n", filename );
ADDRGP4 $360
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 581
;581:		}
LABELV $383
line 582
;582:		if ( wasVertex ) {
ADDRLP4 132
INDIRI4
CNSTI4 0
EQI4 $386
line 584
;583:			//Reset to vertex
;584:			trap_Cvar_Set( "r_vertexLight", "1");
ADDRGP4 $347
ARGP4
ADDRGP4 $363
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 585
;585:		}
LABELV $386
line 586
;586:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $343
JUMPV
LABELV $381
line 590
;587:	}
;588:
;589:	// if any skins failed to load, return failure
;590:	if ( !CG_RegisterClientSkin( ci, teamName, modelName, skinName, headName, headSkinName ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 276
ADDRGP4 CG_RegisterClientSkin
CALLI4
ASGNI4
ADDRLP4 276
INDIRI4
CNSTI4 0
NEI4 $388
line 591
;591:		if ( teamName && *teamName) {
ADDRLP4 280
ADDRFP4 20
INDIRP4
ASGNP4
ADDRLP4 280
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $390
ADDRLP4 280
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $390
line 592
;592:			if ( cg_debugModels.integer ) {
ADDRGP4 cg_debugModels+12
INDIRI4
CNSTI4 0
EQI4 $392
line 593
;593:				Com_Printf( "Failed to load skin file: %s : %s : %s, %s : %s\n", teamName, modelName, skinName, headName, headSkinName );
ADDRGP4 $395
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 594
;594:			}
LABELV $392
line 595
;595:			if( ci->team == TEAM_BLUE ) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $396
line 596
;596:				Com_sprintf(newTeamName, sizeof(newTeamName), "%s/", DEFAULT_BLUETEAM_NAME);
ADDRLP4 136
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $398
ARGP4
ADDRGP4 $399
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 597
;597:			} else {
ADDRGP4 $397
JUMPV
LABELV $396
line 598
;598:				Com_sprintf(newTeamName, sizeof(newTeamName), "%s/", DEFAULT_REDTEAM_NAME);
ADDRLP4 136
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $398
ARGP4
ADDRGP4 $400
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 599
;599:			}
LABELV $397
line 600
;600:			if ( !CG_RegisterClientSkin( ci, newTeamName, modelName, skinName, headName, headSkinName ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 136
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 284
ADDRGP4 CG_RegisterClientSkin
CALLI4
ASGNI4
ADDRLP4 284
INDIRI4
CNSTI4 0
NEI4 $391
line 601
;601:				if ( cg_debugModels.integer ) {
ADDRGP4 cg_debugModels+12
INDIRI4
CNSTI4 0
EQI4 $403
line 602
;602:					Com_Printf( "Failed to load skin file: %s : %s : %s, %s : %s\n", newTeamName, modelName, skinName, headName, headSkinName );
ADDRGP4 $395
ARGP4
ADDRLP4 136
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 603
;603:				}
LABELV $403
line 604
;604:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $343
JUMPV
line 606
;605:			}
;606:		} else {
LABELV $390
line 607
;607:			if ( cg_debugModels.integer ) {
ADDRGP4 cg_debugModels+12
INDIRI4
CNSTI4 0
EQI4 $406
line 608
;608:				Com_Printf( "Failed to load skin file: %s : %s, %s : %s\n", modelName, skinName, headName, headSkinName );
ADDRGP4 $409
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 609
;609:			}
LABELV $406
line 610
;610:			if ( wasVertex ) {
ADDRLP4 132
INDIRI4
CNSTI4 0
EQI4 $410
line 612
;611:				//Reset to vertex
;612:				trap_Cvar_Set( "r_vertexLight", "1");
ADDRGP4 $347
ARGP4
ADDRGP4 $363
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 613
;613:			}
LABELV $410
line 614
;614:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $343
JUMPV
LABELV $391
line 616
;615:		}
;616:	}
LABELV $388
line 619
;617:
;618:	// load the animations
;619:	Com_sprintf( filename, sizeof( filename ), "models/players/%s/animation.cfg", modelName );
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $412
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 620
;620:	if ( !CG_ParseAnimationFile( filename, ci ) ) {
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 280
ADDRGP4 CG_ParseAnimationFile
CALLI4
ASGNI4
ADDRLP4 280
INDIRI4
CNSTI4 0
NEI4 $413
line 621
;621:		Com_sprintf( filename, sizeof( filename ), "models/players/characters/%s/animation.cfg", modelName );
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $415
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 622
;622:		if ( !CG_ParseAnimationFile( filename, ci ) ) {
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 284
ADDRGP4 CG_ParseAnimationFile
CALLI4
ASGNI4
ADDRLP4 284
INDIRI4
CNSTI4 0
NEI4 $416
line 623
;623:			Com_Printf( "Failed to load animation file %s\n", filename );
ADDRGP4 $418
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 624
;624:			if ( wasVertex ) {
ADDRLP4 132
INDIRI4
CNSTI4 0
EQI4 $419
line 626
;625:				//Reset to vertex
;626:				trap_Cvar_Set( "r_vertexLight", "1");
ADDRGP4 $347
ARGP4
ADDRGP4 $363
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 627
;627:			}
LABELV $419
line 628
;628:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $343
JUMPV
LABELV $416
line 630
;629:		}
;630:	}
LABELV $413
line 632
;631:
;632:	if ( CG_FindClientHeadFile( filename, sizeof(filename), ci, teamName, headName, headSkinName, "icon", "skin" ) ) {
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 $423
ARGP4
ADDRGP4 $323
ARGP4
ADDRLP4 284
ADDRGP4 CG_FindClientHeadFile
CALLI4
ASGNI4
ADDRLP4 284
INDIRI4
CNSTI4 0
EQI4 $421
line 633
;633:		ci->modelIcon = trap_R_RegisterShaderNoMip( filename );
ADDRLP4 0
ARGP4
ADDRLP4 288
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 600
ADDP4
ADDRLP4 288
INDIRI4
ASGNI4
line 634
;634:	} else if ( CG_FindClientHeadFile( filename, sizeof(filename), ci, teamName, headName, headSkinName, "icon", "tga" ) ) {
ADDRGP4 $422
JUMPV
LABELV $421
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 $423
ARGP4
ADDRGP4 $426
ARGP4
ADDRLP4 288
ADDRGP4 CG_FindClientHeadFile
CALLI4
ASGNI4
ADDRLP4 288
INDIRI4
CNSTI4 0
EQI4 $424
line 635
;635:		ci->modelIcon = trap_R_RegisterShaderNoMip( filename );
ADDRLP4 0
ARGP4
ADDRLP4 292
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 600
ADDP4
ADDRLP4 292
INDIRI4
ASGNI4
line 636
;636:	}
LABELV $424
LABELV $422
line 638
;637:
;638:	if ( !ci->modelIcon ) {
ADDRFP4 0
INDIRP4
CNSTI4 600
ADDP4
INDIRI4
CNSTI4 0
NEI4 $427
line 639
;639:		if ( wasVertex ) {
ADDRLP4 132
INDIRI4
CNSTI4 0
EQI4 $429
line 641
;640:			//Reset to vertex
;641:			trap_Cvar_Set( "r_vertexLight", "1");
ADDRGP4 $347
ARGP4
ADDRGP4 $363
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 642
;642:		}
LABELV $429
line 643
;643:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $343
JUMPV
LABELV $427
line 645
;644:	}
;645:	if ( wasVertex ) {
ADDRLP4 132
INDIRI4
CNSTI4 0
EQI4 $431
line 647
;646:		//Reset to vertex
;647:		trap_Cvar_Set( "r_vertexLight", "1");
ADDRGP4 $347
ARGP4
ADDRGP4 $363
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 648
;648:	}
LABELV $431
line 649
;649:	return qtrue;
CNSTI4 1
RETI4
LABELV $343
endproc CG_RegisterClientModelname 296 32
proc CG_ColorFromString 20 4
line 657
;650:}
;651:
;652:/*
;653:====================
;654:CG_ColorFromString
;655:====================
;656:*/
;657:static void CG_ColorFromString( const char *v, vec3_t color ) {
line 660
;658:	int val;
;659:
;660:	VectorClear( color );
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
ADDRLP4 4
INDIRP4
ADDRLP4 8
INDIRF4
ASGNF4
line 662
;661:
;662:	val = atoi( v );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 664
;663:
;664:	if ( val < 1 || val > 7 ) {
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $436
ADDRLP4 0
INDIRI4
CNSTI4 7
LEI4 $434
LABELV $436
line 665
;665:		VectorSet( color, 1, 1, 1 );
ADDRFP4 4
INDIRP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1065353216
ASGNF4
line 666
;666:		return;
ADDRGP4 $433
JUMPV
LABELV $434
line 669
;667:	}
;668:
;669:	if ( val & 1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $437
line 670
;670:		color[2] = 1.0f;
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1065353216
ASGNF4
line 671
;671:	}
LABELV $437
line 672
;672:	if ( val & 2 ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $439
line 673
;673:		color[1] = 1.0f;
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 1065353216
ASGNF4
line 674
;674:	}
LABELV $439
line 675
;675:	if ( val & 4 ) {
ADDRLP4 0
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $441
line 676
;676:		color[0] = 1.0f;
ADDRFP4 4
INDIRP4
CNSTF4 1065353216
ASGNF4
line 677
;677:	}
LABELV $441
line 678
;678:}
LABELV $433
endproc CG_ColorFromString 20 4
proc CG_LoadClientInfo 148 24
line 689
;679:
;680:#define MAX_ERRORS 5 //Evo:Model:
;681:/*
;682:===================
;683:CG_LoadClientInfo
;684:
;685:Load it now, taking the disk hits.
;686:This will usually be deferred to a safe time
;687:===================
;688:*/
;689:static void CG_LoadClientInfo( clientInfo_t *ci ) {
line 696
;690:	const char	*dir, *fallback;
;691:	int			i, modelloaded;
;692:	const char	*s;
;693:	int			clientNum;
;694:	char		teamname[MAX_QPATH];
;695:	//For the rewrite
;696:	int			loadAttempt = 0;//Evo:Model:Variable
ADDRLP4 4
CNSTI4 0
ASGNI4
line 698
;697:
;698:	teamname[0] = 0;
ADDRLP4 16
CNSTI1 0
ASGNI1
line 712
;699:#ifdef MISSIONPACK
;700:	if( cgs.gametype >= GT_TEAM) {
;701:		if( ci->team == TEAM_BLUE ) {
;702:			Q_strncpyz(teamname, cg_blueTeamName.string, sizeof(teamname) );
;703:		} else {
;704:			Q_strncpyz(teamname, cg_redTeamName.string, sizeof(teamname) );
;705:		}
;706:	}
;707:	if( teamname[0] ) {
;708:		strcat( teamname, "/" );
;709:	}
;710:#endif
;711:	//Evo:Model:Begin
;712:	for ( loadAttempt = 0; loadAttempt < MAX_ERRORS; loadAttempt++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $444
line 721
;713:		//Attempt to load a model for the client
;714:		
;715:		//First Attempt loads the model/skin in clientInfo
;716:		//Second attempt loads the saved model/skin [may be the same in some cases]
;717:
;718:		//We will likely want to check for skin forcing i.e. cg_enemyModel /pm
;719:		//When skin forcing this loop will likely hhave to ahve the possibility of running twice.
;720:		//1 full pass[4? tries] to skin force, then kill skin forcing and try to load a model.
;721:		if ( loadAttempt >= 1 ) {
ADDRLP4 4
INDIRI4
CNSTI4 1
LTI4 $448
line 723
;722:			//Clear the models and skins
;723:			memset(ci->modelName, 0, sizeof(ci->modelName) );
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 724
;724:			memset(ci->skinName, 0, sizeof(ci->skinName) );
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 725
;725:			memset(ci->headModelName, 0, sizeof(ci->headModelName) );
ADDRFP4 0
INDIRP4
CNSTI4 348
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 726
;726:			memset(ci->headSkinName, 0, sizeof(ci->headSkinName) );
ADDRFP4 0
INDIRP4
CNSTI4 412
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 729
;727:
;728:			//Copy a different set of models/skins to the client's set
;729:			if ( loadAttempt == 2 && !ci->localClient) { //Can't be localClient
ADDRLP4 4
INDIRI4
CNSTI4 2
NEI4 $450
ADDRFP4 0
INDIRP4
CNSTI4 1768
ADDP4
INDIRI4
CNSTI4 0
NEI4 $450
line 731
;730:				//If we ever reach this one, do not attempt to load like enemy/teamModel
;731:				Com_sprintf(ci->modelName, sizeof(ci->modelName), cg.savedmodelName);
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 cg+170580
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 732
;732:				Com_sprintf(ci->skinName, sizeof(ci->skinName), cg.savedskinName);
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 cg+170644
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 733
;733:				Com_sprintf(ci->headModelName, sizeof(ci->headModelName), cg.savedheadModelName);
ADDRFP4 0
INDIRP4
CNSTI4 348
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 cg+170708
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 734
;734:				Com_sprintf(ci->headSkinName, sizeof(ci->headSkinName), cg.savedheadSkinName);
ADDRFP4 0
INDIRP4
CNSTI4 412
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 cg+170772
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 735
;735:			} else if ( loadAttempt == 1 && !ci->localClient && ci->forceNMEorTM ) {  //Can't be localClient
ADDRGP4 $451
JUMPV
LABELV $450
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $456
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 96
CNSTI4 0
ASGNI4
ADDRLP4 92
INDIRP4
CNSTI4 1768
ADDP4
INDIRI4
ADDRLP4 96
INDIRI4
NEI4 $456
ADDRLP4 92
INDIRP4
CNSTI4 1772
ADDP4
INDIRI4
ADDRLP4 96
INDIRI4
EQI4 $456
line 737
;736:				//Third attempt loads the localClient info
;737:				Com_sprintf(ci->modelName, sizeof(ci->modelName), cgs.clientinfo[cg.clientNum].modelName);
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
ARGP4
CNSTI4 64
ARGI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+220
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 738
;738:				Com_sprintf(ci->skinName, sizeof(ci->skinName), cgs.clientinfo[cg.clientNum].skinName);
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
ARGP4
CNSTI4 64
ARGI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+284
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 739
;739:				Com_sprintf(ci->headModelName, sizeof(ci->headModelName), cgs.clientinfo[cg.clientNum].headModelName);
ADDRFP4 0
INDIRP4
CNSTI4 348
ADDP4
ARGP4
CNSTI4 64
ARGI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+348
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 740
;740:				Com_sprintf(ci->headSkinName, sizeof(ci->headSkinName), cgs.clientinfo[cg.clientNum].headSkinName);
ADDRFP4 0
INDIRP4
CNSTI4 412
ADDP4
ARGP4
CNSTI4 64
ARGI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+412
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 742
;741:				
;742:			} else if ( loadAttempt == 3 ) {
ADDRGP4 $457
JUMPV
LABELV $456
ADDRLP4 4
INDIRI4
CNSTI4 3
NEI4 $470
line 744
;743:				//Fourth attempt just force the overall default model
;744:				Com_sprintf(ci->modelName, sizeof(ci->modelName), DEFAULT_MODEL);
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $472
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 745
;745:				Com_sprintf(ci->skinName, sizeof(ci->skinName), "default");
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $161
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 746
;746:				Com_sprintf(ci->headModelName, sizeof(ci->headModelName), DEFAULT_MODEL);
ADDRFP4 0
INDIRP4
CNSTI4 348
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $472
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 747
;747:				Com_sprintf(ci->headSkinName, sizeof(ci->headSkinName), "default");
ADDRFP4 0
INDIRP4
CNSTI4 412
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $161
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 749
;748:				//Com_sprintf(ci->skinName, sizeof(ci->skinName), cgs.clientinfo[cg.clientNum].skinName);
;749:				ci->forceNMEorTM = qfalse; //We can no longer have forceNMEorTM to true, for team skinning purposes.
ADDRFP4 0
INDIRP4
CNSTI4 1772
ADDP4
CNSTI4 0
ASGNI4
line 751
;750:										   //We'll likely have to do a /pm skin check before we can officially determine this though.
;751:			} else if ( loadAttempt == 4 ) {
ADDRGP4 $471
JUMPV
LABELV $470
ADDRLP4 4
INDIRI4
CNSTI4 4
NEI4 $473
line 752
;752:				CG_Error("Something is terribly wrong with your game.\n It can't load any model!");
ADDRGP4 $475
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 753
;753:			}
LABELV $473
LABELV $471
LABELV $457
LABELV $451
line 754
;754:		}
LABELV $448
line 757
;755:		//CG_Printf("DBG:%i: %s -- %s\n", loadAttempt, ci->modelName, ci->skinName);
;756:
;757:		modelloaded = qtrue;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 758
;758:		if ( !CG_RegisterClientModelname( ci, ci->modelName, ci->skinName, ci->headModelName, ci->headSkinName, teamname ) ) {
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRLP4 92
INDIRP4
CNSTI4 220
ADDP4
ARGP4
ADDRLP4 92
INDIRP4
CNSTI4 284
ADDP4
ARGP4
ADDRLP4 92
INDIRP4
CNSTI4 348
ADDP4
ARGP4
ADDRLP4 92
INDIRP4
CNSTI4 412
ADDP4
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 96
ADDRGP4 CG_RegisterClientModelname
CALLI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 0
NEI4 $446
line 759
;759:			if ( cg_debugModels.integer ) {
ADDRGP4 cg_debugModels+12
INDIRI4
CNSTI4 0
EQI4 $478
line 760
;760:				CG_Printf( "CG_RegisterClientModelname( %s, %s, %s, %s %s ) failed\n", ci->modelName, ci->skinName, ci->headModelName, ci->headSkinName, teamname );
ADDRGP4 $481
ARGP4
ADDRLP4 100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 220
ADDP4
ARGP4
ADDRLP4 100
INDIRP4
CNSTI4 284
ADDP4
ARGP4
ADDRLP4 100
INDIRP4
CNSTI4 348
ADDP4
ARGP4
ADDRLP4 100
INDIRP4
CNSTI4 412
ADDP4
ARGP4
ADDRLP4 16
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 761
;761:			}
LABELV $478
line 762
;762:			modelloaded = qfalse;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 763
;763:		} else {
line 764
;764:			break;
LABELV $477
line 766
;765:		}
;766:	}
LABELV $445
line 712
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 5
LTI4 $444
LABELV $446
line 771
;767:	//We removed a bunch of bullshit CG_Error() stuff.
;768:	//Which was likely the worst possible way to handle something like this.
;769:	//Evo:Model:End
;770:
;771:	ci->newAnims = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
CNSTI4 0
ASGNI4
line 772
;772:	if ( ci->torsoModel ) {
ADDRFP4 0
INDIRP4
CNSTI4 584
ADDP4
INDIRI4
CNSTI4 0
EQI4 $482
line 775
;773:		orientation_t tag;
;774:		// if the torso model has the "tag_flag"
;775:		if ( trap_R_LerpTag( &tag, ci->torsoModel, 0, 0, 1, "tag_flag" ) ) {
ADDRLP4 92
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 584
ADDP4
INDIRI4
ARGI4
ADDRLP4 140
CNSTI4 0
ASGNI4
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 140
INDIRI4
ARGI4
CNSTF4 1065353216
ARGF4
ADDRGP4 $486
ARGP4
ADDRLP4 144
ADDRGP4 trap_R_LerpTag
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $484
line 776
;776:			ci->newAnims = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
CNSTI4 1
ASGNI4
line 777
;777:		}
LABELV $484
line 778
;778:	}
LABELV $482
line 781
;779:
;780:	// sounds
;781:	dir = ci->modelName;
ADDRLP4 84
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
ASGNP4
line 782
;782:	fallback = (cgs.gametype >= GT_TEAM) ? DEFAULT_TEAM_MODEL : DEFAULT_MODEL;
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $489
ADDRLP4 92
ADDRGP4 $472
ASGNP4
ADDRGP4 $490
JUMPV
LABELV $489
ADDRLP4 92
ADDRGP4 $472
ASGNP4
LABELV $490
ADDRLP4 88
ADDRLP4 92
INDIRP4
ASGNP4
line 784
;783:
;784:	for ( i = 0 ; i < MAX_CUSTOM_SOUNDS ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $491
line 785
;785:		s = cg_customSoundNames[i];
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_customSoundNames
ADDP4
INDIRP4
ASGNP4
line 786
;786:		if ( !s ) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $495
line 787
;787:			break;
ADDRGP4 $493
JUMPV
LABELV $495
line 789
;788:		}
;789:		ci->sounds[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 1640
ADDP4
ADDP4
CNSTI4 0
ASGNI4
line 791
;790:		// if the model didn't load, use the sounds of the default model
;791:		if (modelloaded) {
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $497
line 792
;792:			ci->sounds[i] = trap_S_RegisterSound( va("sound/player/%s/%s", dir, s + 1), qfalse );
ADDRGP4 $499
ARGP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 96
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 96
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 100
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 1640
ADDP4
ADDP4
ADDRLP4 100
INDIRI4
ASGNI4
line 793
;793:		}
LABELV $497
line 794
;794:		if ( !ci->sounds[i] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 1640
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $500
line 795
;795:			ci->sounds[i] = trap_S_RegisterSound( va("sound/player/%s/%s", fallback, s + 1), qfalse );
ADDRGP4 $499
ARGP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 96
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 96
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 100
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 1640
ADDP4
ADDP4
ADDRLP4 100
INDIRI4
ASGNI4
line 796
;796:		}
LABELV $500
line 797
;797:	}
LABELV $492
line 784
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $491
LABELV $493
line 799
;798:
;799:	ci->deferred = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
CNSTI4 0
ASGNI4
line 803
;800:
;801:	// reset any existing players and bodies, because they might be in bad
;802:	// frames for this new model
;803:	clientNum = ci - cgs.clientinfo;
ADDRLP4 80
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 cgs+40960
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 1776
DIVI4
ASGNI4
line 804
;804:	for ( i = 0 ; i < MAX_GENTITIES ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $503
line 805
;805:		if ( cg_entities[i].currentState.clientNum == clientNum
ADDRLP4 96
CNSTI4 728
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 96
INDIRI4
ADDRGP4 cg_entities+168
ADDP4
INDIRI4
ADDRLP4 80
INDIRI4
NEI4 $507
ADDRLP4 96
INDIRI4
ADDRGP4 cg_entities+4
ADDP4
INDIRI4
CNSTI4 1
NEI4 $507
line 806
;806:			&& cg_entities[i].currentState.eType == ET_PLAYER ) {
line 807
;807:			CG_ResetPlayerEntity( &cg_entities[i] );
CNSTI4 728
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ARGP4
ADDRGP4 CG_ResetPlayerEntity
CALLV
pop
line 808
;808:		}
LABELV $507
line 809
;809:	}
LABELV $504
line 804
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1024
LTI4 $503
line 810
;810:}
LABELV $443
endproc CG_LoadClientInfo 148 24
proc CG_CopyClientInfoModel 52 12
line 817
;811:
;812:/*
;813:======================
;814:CG_CopyClientInfoModel
;815:======================
;816:*/
;817:static void CG_CopyClientInfoModel( clientInfo_t *from, clientInfo_t *to ) {
line 818
;818:	VectorCopy( from->headOffset, to->headOffset );
ADDRLP4 0
CNSTI4 556
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRB
ASGNB 12
line 819
;819:	to->footsteps = from->footsteps;
ADDRLP4 4
CNSTI4 568
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 820
;820:	to->gender = from->gender;
ADDRLP4 8
CNSTI4 572
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 822
;821:
;822:	to->legsModel = from->legsModel;
ADDRLP4 12
CNSTI4 576
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 823
;823:	to->legsSkin = from->legsSkin;
ADDRLP4 16
CNSTI4 580
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 824
;824:	to->torsoModel = from->torsoModel;
ADDRLP4 20
CNSTI4 584
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 825
;825:	to->torsoSkin = from->torsoSkin;
ADDRLP4 24
CNSTI4 588
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 826
;826:	to->headModel = from->headModel;
ADDRLP4 28
CNSTI4 592
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 827
;827:	to->headSkin = from->headSkin;
ADDRLP4 32
CNSTI4 596
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 828
;828:	to->modelIcon = from->modelIcon;
ADDRLP4 36
CNSTI4 600
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 830
;829:
;830:	to->newAnims = from->newAnims;
ADDRLP4 40
CNSTI4 544
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 832
;831:
;832:	memcpy( to->animations, from->animations, sizeof( to->animations ) );
ADDRLP4 44
CNSTI4 604
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
ARGP4
CNSTI4 1036
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 833
;833:	memcpy( to->sounds, from->sounds, sizeof( to->sounds ) );
ADDRLP4 48
CNSTI4 1640
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 834
;834:}
LABELV $511
endproc CG_CopyClientInfoModel 52 12
proc CG_ScanForExistingClientInfo 60 8
line 841
;835:
;836:/*
;837:======================
;838:CG_ScanForExistingClientInfo
;839:======================
;840:*/
;841:static qboolean CG_ScanForExistingClientInfo( clientInfo_t *ci ) {
line 845
;842:	int		i;
;843:	clientInfo_t	*match;
;844:
;845:	for ( i = 0 ; i < cgs.maxclients ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $516
JUMPV
LABELV $513
line 846
;846:		match = &cgs.clientinfo[ i ];
ADDRLP4 0
CNSTI4 1776
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cgs+40960
ADDP4
ASGNP4
line 847
;847:		if ( !match->infoValid ) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $519
line 848
;848:			continue;
ADDRGP4 $514
JUMPV
LABELV $519
line 850
;849:		}
;850:		if ( match->deferred ) {
ADDRLP4 0
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
CNSTI4 0
EQI4 $521
line 851
;851:			continue;
ADDRGP4 $514
JUMPV
LABELV $521
line 853
;852:		}
;853:		if ( !Q_stricmp( ci->modelName, match->modelName )
ADDRLP4 8
CNSTI4 220
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $523
ADDRLP4 16
CNSTI4 284
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $523
ADDRLP4 24
CNSTI4 348
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $523
ADDRLP4 32
CNSTI4 412
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $523
ADDRLP4 40
CNSTI4 508
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ARGP4
ADDRLP4 44
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $523
ADDRLP4 48
CNSTI4 476
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
ARGP4
ADDRLP4 52
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $523
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $526
ADDRLP4 56
CNSTI4 68
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRI4
NEI4 $523
LABELV $526
line 859
;854:			&& !Q_stricmp( ci->skinName, match->skinName )
;855:			&& !Q_stricmp( ci->headModelName, match->headModelName )
;856:			&& !Q_stricmp( ci->headSkinName, match->headSkinName ) 
;857:			&& !Q_stricmp( ci->blueTeam, match->blueTeam ) 
;858:			&& !Q_stricmp( ci->redTeam, match->redTeam )
;859:			&& (cgs.gametype < GT_TEAM || ci->team == match->team) ) {
line 862
;860:			// this clientinfo is identical, so use it's handles
;861:
;862:			ci->deferred = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
CNSTI4 0
ASGNI4
line 864
;863:
;864:			CG_CopyClientInfoModel( match, ci );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_CopyClientInfoModel
CALLV
pop
line 866
;865:
;866:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $512
JUMPV
LABELV $523
line 868
;867:		}
;868:	}
LABELV $514
line 845
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $516
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+31480
INDIRI4
LTI4 $513
line 871
;869:
;870:	// nothing matches, so defer the load
;871:	return qfalse;
CNSTI4 0
RETI4
LABELV $512
endproc CG_ScanForExistingClientInfo 60 8
proc CG_SetDeferredClientInfo 36 8
line 882
;872:}
;873:
;874:/*
;875:======================
;876:CG_SetDeferredClientInfo
;877:
;878:We aren't going to load it now, so grab some other
;879:client's info to use until we have some spare time.
;880:======================
;881:*/
;882:static void CG_SetDeferredClientInfo( clientInfo_t *ci ) {
line 888
;883:	int		i;
;884:	clientInfo_t	*match;
;885:
;886:	// if someone else is already the same models and skins we
;887:	// can just load the client info
;888:	for ( i = 0 ; i < cgs.maxclients ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $531
JUMPV
LABELV $528
line 889
;889:		match = &cgs.clientinfo[ i ];
ADDRLP4 0
CNSTI4 1776
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cgs+40960
ADDP4
ASGNP4
line 890
;890:		if ( !match->infoValid || match->deferred ) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $536
ADDRLP4 0
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $534
LABELV $536
line 891
;891:			continue;
ADDRGP4 $529
JUMPV
LABELV $534
line 893
;892:		}
;893:		if ( Q_stricmp( ci->skinName, match->skinName ) ||
ADDRLP4 16
CNSTI4 284
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $541
ADDRLP4 24
CNSTI4 220
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $541
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $537
ADDRLP4 32
CNSTI4 68
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRI4
EQI4 $537
LABELV $541
line 897
;894:			 Q_stricmp( ci->modelName, match->modelName ) ||
;895://			 Q_stricmp( ci->headModelName, match->headModelName ) ||
;896://			 Q_stricmp( ci->headSkinName, match->headSkinName ) ||
;897:			 (cgs.gametype >= GT_TEAM && ci->team != match->team) ) {
line 898
;898:			continue;
ADDRGP4 $529
JUMPV
LABELV $537
line 901
;899:		}
;900:		// just load the real info cause it uses the same models and skins
;901:		CG_LoadClientInfo( ci );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_LoadClientInfo
CALLV
pop
line 902
;902:		return;
ADDRGP4 $527
JUMPV
LABELV $529
line 888
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $531
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+31480
INDIRI4
LTI4 $528
line 906
;903:	}
;904:
;905:	// if we are in teamplay, only grab a model if the skin is correct
;906:	if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $542
line 907
;907:		for ( i = 0 ; i < cgs.maxclients ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $548
JUMPV
LABELV $545
line 908
;908:			match = &cgs.clientinfo[ i ];
ADDRLP4 0
CNSTI4 1776
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cgs+40960
ADDP4
ASGNP4
line 909
;909:			if ( !match->infoValid || match->deferred ) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $553
ADDRLP4 0
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $551
LABELV $553
line 910
;910:				continue;
ADDRGP4 $546
JUMPV
LABELV $551
line 913
;911:			}
;912:			
;913:			if ( g_gamemode.integer < 4 ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 4
GEI4 $554
line 914
;914:				if ( Q_stricmp( ci->skinName, match->skinName ) ||
ADDRLP4 16
CNSTI4 284
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $560
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $555
ADDRLP4 24
CNSTI4 68
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
EQI4 $555
LABELV $560
line 915
;915:					(cgs.gametype >= GT_TEAM && ci->team != match->team) ) {
line 916
;916:					continue;
ADDRGP4 $546
JUMPV
line 918
;917:				}
;918:			} else {
LABELV $554
line 919
;919:				if ( ci->team != TEAM_SPECTATOR && ci->team != match->team ) {
ADDRLP4 16
CNSTI4 68
ASGNI4
ADDRLP4 20
ADDRFP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 3
EQI4 $561
ADDRLP4 20
INDIRI4
ADDRLP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
EQI4 $561
line 920
;920:					continue;
ADDRGP4 $546
JUMPV
LABELV $561
line 922
;921:				}
;922:			}
LABELV $555
line 924
;923://freeze
;924:			ci->deferred = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
CNSTI4 1
ASGNI4
line 925
;925:			CG_CopyClientInfoModel( match, ci );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_CopyClientInfoModel
CALLV
pop
line 926
;926:			return;
ADDRGP4 $527
JUMPV
LABELV $546
line 907
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $548
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+31480
INDIRI4
LTI4 $545
line 932
;927:		}
;928:		// load the full model, because we don't ever want to show
;929:		// an improper team skin.  This will cause a hitch for the first
;930:		// player, when the second enters.  Combat shouldn't be going on
;931:		// yet, so it shouldn't matter
;932:		CG_LoadClientInfo( ci );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_LoadClientInfo
CALLV
pop
line 933
;933:		return;
ADDRGP4 $527
JUMPV
LABELV $542
line 937
;934:	}
;935:
;936:	// find the first valid clientinfo and grab its stuff
;937:	for ( i = 0 ; i < cgs.maxclients ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $566
JUMPV
LABELV $563
line 938
;938:		match = &cgs.clientinfo[ i ];
ADDRLP4 0
CNSTI4 1776
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cgs+40960
ADDP4
ASGNP4
line 939
;939:		if ( !match->infoValid ) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $569
line 940
;940:			continue;
ADDRGP4 $564
JUMPV
LABELV $569
line 943
;941:		}
;942:
;943:		ci->deferred = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
CNSTI4 1
ASGNI4
line 944
;944:		CG_CopyClientInfoModel( match, ci );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_CopyClientInfoModel
CALLV
pop
line 945
;945:		return;
ADDRGP4 $527
JUMPV
LABELV $564
line 937
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $566
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+31480
INDIRI4
LTI4 $563
line 949
;946:	}
;947:
;948:	// we should never get here...
;949:	CG_Printf( "CG_SetDeferredClientInfo: no valid clients!\n" );
ADDRGP4 $571
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 951
;950:
;951:	CG_LoadClientInfo( ci );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_LoadClientInfo
CALLV
pop
line 952
;952:}
LABELV $527
endproc CG_SetDeferredClientInfo 36 8
export CG_NewClientInfo
proc CG_NewClientInfo 2092 16
line 960
;953:
;954:
;955:/*
;956:======================
;957:CG_NewClientInfo
;958:======================
;959:*/
;960:void CG_NewClientInfo( int clientNum ) {
line 969
;961:	clientInfo_t *ci;
;962:	clientInfo_t newInfo;
;963:	const char	*configstring;
;964:	const char	*v;
;965:	char		colors[24];
;966:	int			i, color;
;967:	char		*slash;
;968:
;969:	ci = &cgs.clientinfo[clientNum];
ADDRLP4 1816
CNSTI4 1776
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 cgs+40960
ADDP4
ASGNP4
line 971
;970:
;971:	configstring = CG_ConfigString( clientNum + CS_PLAYERS );
ADDRFP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 1824
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 1788
ADDRLP4 1824
INDIRP4
ASGNP4
line 972
;972:	if ( !configstring[0] ) {
ADDRLP4 1788
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $574
line 973
;973:		memset( ci, 0, sizeof( *ci ) );
ADDRLP4 1816
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1776
ARGI4
ADDRGP4 memset
CALLP4
pop
line 974
;974:		return;		// player just left
ADDRGP4 $572
JUMPV
LABELV $574
line 979
;975:	}
;976:
;977:	// build into a temp buffer so the defer checks can use
;978:	// the old value
;979:	memset( &newInfo, 0, sizeof( newInfo ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1776
ARGI4
ADDRGP4 memset
CALLP4
pop
line 981
;980:
;981:	if ( clientNum == cg.clientNum ) {
ADDRFP4 0
INDIRI4
ADDRGP4 cg+4
INDIRI4
NEI4 $576
line 983
;982:		//Probably have to mark something in so that it reloads enemy/team models
;983:		newInfo.localClient = qtrue;
ADDRLP4 0+1768
CNSTI4 1
ASGNI4
line 984
;984:	} else {
ADDRGP4 $577
JUMPV
LABELV $576
line 985
;985:		newInfo.localClient = qfalse;
ADDRLP4 0+1768
CNSTI4 0
ASGNI4
line 986
;986:	}
LABELV $577
line 989
;987:
;988:	// isolate the player's name
;989:	v = Info_ValueForKey(configstring, "n");
ADDRLP4 1788
INDIRP4
ARGP4
ADDRGP4 $581
ARGP4
ADDRLP4 1828
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1784
ADDRLP4 1828
INDIRP4
ASGNP4
line 990
;990:	Q_strncpyz( newInfo.name, v, sizeof( newInfo.name ) );
ADDRLP4 0+4
ARGP4
ADDRLP4 1784
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 992
;991:
;992:	v = Info_ValueForKey(configstring, "sex");
ADDRLP4 1788
INDIRP4
ARGP4
ADDRGP4 $188
ARGP4
ADDRLP4 1832
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1784
ADDRLP4 1832
INDIRP4
ASGNP4
line 993
;993:	Q_strncpyz( newInfo.sex, v, sizeof( newInfo.sex ) );
ADDRLP4 0+188
ARGP4
ADDRLP4 1784
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 997
;994:	//Evo:Model:Begin
;995:	// colors
;996:	//PM Skin / Colors, we replaced /color1 and /color2 with /colors
;997:	Com_sprintf(colors, sizeof(colors), "%s", Info_ValueForKey( configstring, "c1" ) );
ADDRLP4 1788
INDIRP4
ARGP4
ADDRGP4 $587
ARGP4
ADDRLP4 1836
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1792
ARGP4
CNSTI4 24
ARGI4
ADDRGP4 $586
ARGP4
ADDRLP4 1836
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 998
;998:	if ( colors[0] == '0' ) {
ADDRLP4 1792
INDIRI1
CVII4 1
CNSTI4 48
NEI4 $588
line 1000
;999:		//CG_Printf("Setting white 1\n");
;1000:		memcpy( newInfo.color1, g_color_table[ColorIndex(7)], sizeof( newInfo.color1 ) );
CNSTI4 7
ARGI4
ADDRLP4 1840
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 0+76
ARGP4
ADDRLP4 1840
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1001
;1001:	} else {
ADDRGP4 $589
JUMPV
LABELV $588
line 1002
;1002:		memcpy( newInfo.color1, g_color_table[ColorIndex(colors[0])], sizeof( newInfo.color1 ) );
ADDRLP4 1792
INDIRI1
CVII4 1
ARGI4
ADDRLP4 1840
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 0+76
ARGP4
ADDRLP4 1840
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1003
;1003:	}
LABELV $589
line 1004
;1004:	if ( colors[4] == '0' ) {
ADDRLP4 1792+4
INDIRI1
CVII4 1
CNSTI4 48
NEI4 $594
line 1006
;1005:		//CG_Printf("Setting white 2\n");
;1006:		memcpy( newInfo.color2, g_color_table[ColorIndex(7)], sizeof( newInfo.color2 ) );
CNSTI4 7
ARGI4
ADDRLP4 1840
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 0+112
ARGP4
ADDRLP4 1840
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1007
;1007:	} else {
ADDRGP4 $595
JUMPV
LABELV $594
line 1008
;1008:		memcpy( newInfo.color2, g_color_table[ColorIndex(colors[4])], sizeof( newInfo.color2 ) );
ADDRLP4 1792+4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 1840
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 0+112
ARGP4
ADDRLP4 1840
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1009
;1009:	}
LABELV $595
line 1010
;1010:	for ( i = 0; i < 5; i++ ) {
ADDRLP4 1776
CNSTI4 0
ASGNI4
LABELV $602
line 1011
;1011:		color = ColorIndex(colors[i]);
ADDRLP4 1776
INDIRI4
ADDRLP4 1792
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 1840
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 1780
ADDRLP4 1840
INDIRI4
ASGNI4
line 1012
;1012:		newInfo.colors[i][0] = g_color_table[color][0] * 255;
ADDRLP4 1848
CNSTF4 1132396544
ADDRLP4 1780
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 1852
CNSTF4 1325400064
ASGNF4
ADDRLP4 1848
INDIRF4
ADDRLP4 1852
INDIRF4
LTF4 $608
ADDRLP4 1844
ADDRLP4 1848
INDIRF4
ADDRLP4 1852
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $609
JUMPV
LABELV $608
ADDRLP4 1844
ADDRLP4 1848
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $609
ADDRLP4 1776
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0+92
ADDP4
ADDRLP4 1844
INDIRU4
CVUU1 4
ASGNU1
line 1013
;1013:		newInfo.colors[i][1] = g_color_table[color][1] * 255;
ADDRLP4 1860
CNSTF4 1132396544
ADDRLP4 1780
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+4
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 1864
CNSTF4 1325400064
ASGNF4
ADDRLP4 1860
INDIRF4
ADDRLP4 1864
INDIRF4
LTF4 $614
ADDRLP4 1856
ADDRLP4 1860
INDIRF4
ADDRLP4 1864
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $615
JUMPV
LABELV $614
ADDRLP4 1856
ADDRLP4 1860
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $615
ADDRLP4 1776
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0+92+1
ADDP4
ADDRLP4 1856
INDIRU4
CVUU1 4
ASGNU1
line 1014
;1014:		newInfo.colors[i][2] = g_color_table[color][2] * 255;
ADDRLP4 1872
CNSTF4 1132396544
ADDRLP4 1780
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+8
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 1876
CNSTF4 1325400064
ASGNF4
ADDRLP4 1872
INDIRF4
ADDRLP4 1876
INDIRF4
LTF4 $620
ADDRLP4 1868
ADDRLP4 1872
INDIRF4
ADDRLP4 1876
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $621
JUMPV
LABELV $620
ADDRLP4 1868
ADDRLP4 1872
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $621
ADDRLP4 1776
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0+92+2
ADDP4
ADDRLP4 1868
INDIRU4
CVUU1 4
ASGNU1
line 1015
;1015:		newInfo.colors[i][3] = g_color_table[color][3] * 255;
ADDRLP4 1884
CNSTF4 1132396544
ADDRLP4 1780
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+12
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 1888
CNSTF4 1325400064
ASGNF4
ADDRLP4 1884
INDIRF4
ADDRLP4 1888
INDIRF4
LTF4 $626
ADDRLP4 1880
ADDRLP4 1884
INDIRF4
ADDRLP4 1888
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $627
JUMPV
LABELV $626
ADDRLP4 1880
ADDRLP4 1884
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $627
ADDRLP4 1776
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0+92+3
ADDP4
ADDRLP4 1880
INDIRU4
CVUU1 4
ASGNU1
line 1016
;1016:	}
LABELV $603
line 1010
ADDRLP4 1776
ADDRLP4 1776
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 1776
INDIRI4
CNSTI4 5
LTI4 $602
line 1020
;1017:	//Evo:Model:End
;1018:
;1019:	// bot skill
;1020:	v = Info_ValueForKey( configstring, "skill" );
ADDRLP4 1788
INDIRP4
ARGP4
ADDRGP4 $628
ARGP4
ADDRLP4 1840
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1784
ADDRLP4 1840
INDIRP4
ASGNP4
line 1021
;1021:	newInfo.botSkill = atoi( v );
ADDRLP4 1784
INDIRP4
ARGP4
ADDRLP4 1844
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+72
ADDRLP4 1844
INDIRI4
ASGNI4
line 1024
;1022:
;1023:	// handicap
;1024:	v = Info_ValueForKey( configstring, "hc" );
ADDRLP4 1788
INDIRP4
ARGP4
ADDRGP4 $630
ARGP4
ADDRLP4 1848
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1784
ADDRLP4 1848
INDIRP4
ASGNP4
line 1025
;1025:	newInfo.handicap = atoi( v );
ADDRLP4 1784
INDIRP4
ARGP4
ADDRLP4 1852
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+148
ADDRLP4 1852
INDIRI4
ASGNI4
line 1028
;1026:
;1027:	// wins
;1028:	v = Info_ValueForKey( configstring, "w" );
ADDRLP4 1788
INDIRP4
ARGP4
ADDRGP4 $632
ARGP4
ADDRLP4 1856
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1784
ADDRLP4 1856
INDIRP4
ASGNP4
line 1029
;1029:	newInfo.wins = atoi( v );
ADDRLP4 1784
INDIRP4
ARGP4
ADDRLP4 1860
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+152
ADDRLP4 1860
INDIRI4
ASGNI4
line 1032
;1030:
;1031:	// losses
;1032:	v = Info_ValueForKey( configstring, "l" );
ADDRLP4 1788
INDIRP4
ARGP4
ADDRGP4 $634
ARGP4
ADDRLP4 1864
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1784
ADDRLP4 1864
INDIRP4
ASGNP4
line 1033
;1033:	newInfo.losses = atoi( v );
ADDRLP4 1784
INDIRP4
ARGP4
ADDRLP4 1868
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+156
ADDRLP4 1868
INDIRI4
ASGNI4
line 1036
;1034:
;1035:	// team
;1036:	v = Info_ValueForKey( configstring, "t" );
ADDRLP4 1788
INDIRP4
ARGP4
ADDRGP4 $636
ARGP4
ADDRLP4 1872
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1784
ADDRLP4 1872
INDIRP4
ASGNP4
line 1037
;1037:	newInfo.team = atoi( v );
ADDRLP4 1784
INDIRP4
ARGP4
ADDRLP4 1876
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+68
ADDRLP4 1876
INDIRI4
ASGNI4
line 1038
;1038:	if ( clientNum == cg.clientNum && newInfo.team != cgs.clientinfo[clientNum].team ) {
ADDRLP4 1880
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 1880
INDIRI4
ADDRGP4 cg+4
INDIRI4
NEI4 $638
ADDRLP4 0+68
INDIRI4
CNSTI4 1776
ADDRLP4 1880
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
EQI4 $638
line 1049
;1039:		//Evo:Model:
;1040:		//We changed teams, reload all models
;1041:
;1042:		//Most other mods are dependant on cg.snap->ps.persistant[PERS_TEAM]
;1043:		//Which ultimately allows you to see which ever team you're spectating as _your_ team.
;1044:		//Parhaps this is a route that should be looked into.
;1045:		//
;1046:		//This "hack" is quite ugly, however so long as client's defer models it works alright.
;1047:
;1048:		//Hack, reload all clients =/
;1049:		forceModelModificationCount = -1;
ADDRGP4 forceModelModificationCount
CNSTI4 -1
ASGNI4
line 1050
;1050:	}
LABELV $638
line 1053
;1051:
;1052:	// team task
;1053:	v = Info_ValueForKey( configstring, "tt" );
ADDRLP4 1788
INDIRP4
ARGP4
ADDRGP4 $644
ARGP4
ADDRLP4 1884
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1784
ADDRLP4 1884
INDIRP4
ASGNP4
line 1054
;1054:	newInfo.teamTask = atoi(v);
ADDRLP4 1784
INDIRP4
ARGP4
ADDRLP4 1888
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+160
ADDRLP4 1888
INDIRI4
ASGNI4
line 1057
;1055:
;1056:	// team leader
;1057:	v = Info_ValueForKey( configstring, "tl" );
ADDRLP4 1788
INDIRP4
ARGP4
ADDRGP4 $646
ARGP4
ADDRLP4 1892
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1784
ADDRLP4 1892
INDIRP4
ASGNP4
line 1058
;1058:	newInfo.teamLeader = atoi(v);
ADDRLP4 1784
INDIRP4
ARGP4
ADDRLP4 1896
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+164
ADDRLP4 1896
INDIRI4
ASGNI4
line 1060
;1059:
;1060:	v = Info_ValueForKey( configstring, "g_redteam" );
ADDRLP4 1788
INDIRP4
ARGP4
ADDRGP4 $648
ARGP4
ADDRLP4 1900
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1784
ADDRLP4 1900
INDIRP4
ASGNP4
line 1061
;1061:	Q_strncpyz(newInfo.redTeam, v, MAX_TEAMNAME);
ADDRLP4 0+476
ARGP4
ADDRLP4 1784
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1063
;1062:
;1063:	v = Info_ValueForKey( configstring, "g_blueteam" );
ADDRLP4 1788
INDIRP4
ARGP4
ADDRGP4 $650
ARGP4
ADDRLP4 1904
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1784
ADDRLP4 1904
INDIRP4
ASGNP4
line 1064
;1064:	Q_strncpyz(newInfo.blueTeam, v, MAX_TEAMNAME);
ADDRLP4 0+508
ARGP4
ADDRLP4 1784
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1067
;1065:
;1066:	// model
;1067:	v = Info_ValueForKey( configstring, "model" );
ADDRLP4 1788
INDIRP4
ARGP4
ADDRGP4 $652
ARGP4
ADDRLP4 1908
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1784
ADDRLP4 1908
INDIRP4
ASGNP4
line 1068
;1068:	if ( strlen(cg_enemyModel.string) > 0 && isEnemy(&newInfo, clientNum) ) {
ADDRGP4 cg_enemyModel+16
ARGP4
ADDRLP4 1912
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1912
INDIRI4
CNSTI4 0
LEI4 $653
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1916
ADDRGP4 isEnemy
CALLI4
ASGNI4
ADDRLP4 1916
INDIRI4
CNSTI4 0
EQI4 $653
line 1074
;1069:		//Evo:Model:
;1070:		char modelStr[MAX_QPATH];
;1071:		char skinStr[MAX_QPATH];
;1072:		char *skin;
;1073:		//Save the client's model
;1074:		Q_strncpyz( cg.savedmodelName, v, sizeof( cg.savedmodelName ) );
ADDRGP4 cg+170580
ARGP4
ADDRLP4 1784
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1075
;1075:		if ( ( skin = strchr( cg.savedmodelName, '/' ) ) == NULL) {
ADDRGP4 cg+170580
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 2052
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1920
ADDRLP4 2052
INDIRP4
ASGNP4
ADDRLP4 2052
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $658
line 1076
;1076:			skin = "default";
ADDRLP4 1920
ADDRGP4 $161
ASGNP4
line 1077
;1077:		} else {
ADDRGP4 $659
JUMPV
LABELV $658
line 1078
;1078:			*skin++ = 0;
ADDRLP4 2056
ADDRLP4 1920
INDIRP4
ASGNP4
ADDRLP4 1920
ADDRLP4 2056
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 2056
INDIRP4
CNSTI1 0
ASGNI1
line 1079
;1079:		}
LABELV $659
line 1080
;1080:		Q_strncpyz( cg.savedskinName, skin, sizeof( cg.savedskinName ) );
ADDRGP4 cg+170644
ARGP4
ADDRLP4 1920
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1081
;1081:		skin = 0;
ADDRLP4 1920
CNSTP4 0
ASGNP4
line 1085
;1082:		//CG_Printf("DBG: %s -- %s\n", cg.savedmodelName, cg.savedskinName);
;1083:		
;1084:		//"force" enemyModel and/or skin
;1085:		if ( cg_enemyModel.string[0] != '/' ) {
ADDRGP4 cg_enemyModel+16
INDIRI1
CVII4 1
CNSTI4 47
EQI4 $663
line 1086
;1086:			Com_sprintf(modelStr, sizeof(modelStr), cg_enemyModel.string, 0);
ADDRLP4 1924
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 cg_enemyModel+16
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1087
;1087:		} else {
ADDRGP4 $664
JUMPV
LABELV $663
line 1089
;1088:			char *model2;
;1089:			Com_sprintf(modelStr, sizeof(modelStr), v, 0);
ADDRLP4 1924
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 1784
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1090
;1090:			model2 = Q_CopyStringUntil(modelStr, "/");
ADDRLP4 1924
ARGP4
ADDRGP4 $667
ARGP4
ADDRLP4 2060
ADDRGP4 Q_CopyStringUntil
CALLP4
ASGNP4
ADDRLP4 2056
ADDRLP4 2060
INDIRP4
ASGNP4
line 1092
;1091:			//CG_Printf("%s\n", model2);
;1092:			Com_sprintf(modelStr, sizeof(modelStr), model2, 0);
ADDRLP4 1924
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 2056
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1093
;1093:			Com_sprintf(skinStr, sizeof(skinStr), cg_enemyModel.string, 0);
ADDRLP4 1988
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 cg_enemyModel+16
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1094
;1094:		}
LABELV $664
line 1096
;1095:		
;1096:		if ( skinStr[0] == '/' ) {
ADDRLP4 1988
INDIRI1
CVII4 1
CNSTI4 47
NEI4 $669
line 1097
;1097:				skin = skinStr;
ADDRLP4 1920
ADDRLP4 1988
ASGNP4
line 1098
;1098:				*skin++ = 0;
ADDRLP4 2056
ADDRLP4 1920
INDIRP4
ASGNP4
ADDRLP4 1920
ADDRLP4 2056
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 2056
INDIRP4
CNSTI1 0
ASGNI1
line 1099
;1099:		} else {
ADDRGP4 $670
JUMPV
LABELV $669
line 1100
;1100:			if ( ( skin = strchr( modelStr, '/' ) ) == NULL) {
ADDRLP4 1924
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 2056
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1920
ADDRLP4 2056
INDIRP4
ASGNP4
ADDRLP4 2056
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $671
line 1101
;1101:				skin = "default";
ADDRLP4 1920
ADDRGP4 $161
ASGNP4
line 1102
;1102:			} else {
ADDRGP4 $672
JUMPV
LABELV $671
line 1103
;1103:				*skin++ = 0;
ADDRLP4 2060
ADDRLP4 1920
INDIRP4
ASGNP4
ADDRLP4 1920
ADDRLP4 2060
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 2060
INDIRP4
CNSTI1 0
ASGNI1
line 1104
;1104:			}
LABELV $672
line 1105
;1105:		}
LABELV $670
line 1107
;1106:
;1107:		if ( cg_debugModels.integer ) {
ADDRGP4 cg_debugModels+12
INDIRI4
CNSTI4 0
EQI4 $673
line 1108
;1108:			CG_Printf("DBG:EnemyModel: %s - Skin: %s\n", modelStr, skin);
ADDRGP4 $676
ARGP4
ADDRLP4 1924
ARGP4
ADDRLP4 1920
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1109
;1109:		}
LABELV $673
line 1110
;1110:		Q_strncpyz( newInfo.skinName, skin, sizeof( newInfo.skinName ) );
ADDRLP4 0+284
ARGP4
ADDRLP4 1920
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1111
;1111:		Q_strncpyz( newInfo.modelName, modelStr, sizeof( newInfo.modelName ) );
ADDRLP4 0+220
ARGP4
ADDRLP4 1924
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1112
;1112:		newInfo.forceNMEorTM = qtrue;
ADDRLP4 0+1772
CNSTI4 1
ASGNI4
line 1114
;1113:
;1114:	} else if ( strlen(cg_teamModel.string) > 0 && isTeammate(&newInfo, clientNum) ) {
ADDRGP4 $654
JUMPV
LABELV $653
ADDRGP4 cg_teamModel+16
ARGP4
ADDRLP4 1920
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1920
INDIRI4
CNSTI4 0
LEI4 $682
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1924
ADDRGP4 isTeammate
CALLI4
ASGNI4
ADDRLP4 1924
INDIRI4
CNSTI4 0
EQI4 $682
line 1120
;1115:		//Evo:Model:
;1116:		char modelStr[MAX_QPATH];
;1117:		char skinStr[MAX_QPATH];
;1118:		char *skin;
;1119:		//Save the client's model
;1120:		Q_strncpyz( cg.savedmodelName, v, sizeof( cg.savedmodelName ) );
ADDRGP4 cg+170580
ARGP4
ADDRLP4 1784
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1121
;1121:		if ( ( skin = strchr( cg.savedmodelName, '/' ) ) == NULL) {
ADDRGP4 cg+170580
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 2060
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1928
ADDRLP4 2060
INDIRP4
ASGNP4
ADDRLP4 2060
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $687
line 1122
;1122:			skin = "default";
ADDRLP4 1928
ADDRGP4 $161
ASGNP4
line 1123
;1123:		} else {
ADDRGP4 $688
JUMPV
LABELV $687
line 1124
;1124:			*skin++ = 0;
ADDRLP4 2064
ADDRLP4 1928
INDIRP4
ASGNP4
ADDRLP4 1928
ADDRLP4 2064
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 2064
INDIRP4
CNSTI1 0
ASGNI1
line 1125
;1125:		}
LABELV $688
line 1126
;1126:		Q_strncpyz( cg.savedskinName, skin, sizeof( cg.savedskinName ) );
ADDRGP4 cg+170644
ARGP4
ADDRLP4 1928
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1127
;1127:		skin = 0;
ADDRLP4 1928
CNSTP4 0
ASGNP4
line 1131
;1128:		//CG_Printf("DBG: %s -- %s\n", cg.savedmodelName, cg.savedskinName);
;1129:		
;1130:		//"force" teamModel and/or skin
;1131:		if ( cg_teamModel.string[0] != '/' ) {
ADDRGP4 cg_teamModel+16
INDIRI1
CVII4 1
CNSTI4 47
EQI4 $692
line 1132
;1132:			Com_sprintf(modelStr, sizeof(modelStr), cg_teamModel.string, 0);
ADDRLP4 1932
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 cg_teamModel+16
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1133
;1133:		} else {
ADDRGP4 $693
JUMPV
LABELV $692
line 1135
;1134:			char *model2;
;1135:			Com_sprintf(modelStr, sizeof(modelStr), v, 0);
ADDRLP4 1932
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 1784
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1136
;1136:			model2 = Q_CopyStringUntil(modelStr, "/");
ADDRLP4 1932
ARGP4
ADDRGP4 $667
ARGP4
ADDRLP4 2068
ADDRGP4 Q_CopyStringUntil
CALLP4
ASGNP4
ADDRLP4 2064
ADDRLP4 2068
INDIRP4
ASGNP4
line 1138
;1137:			//CG_Printf("%s\n", model2);
;1138:			Com_sprintf(modelStr, sizeof(modelStr), model2, 0);
ADDRLP4 1932
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 2064
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1139
;1139:			Com_sprintf(skinStr, sizeof(skinStr), cg_teamModel.string, 0);
ADDRLP4 1996
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 cg_teamModel+16
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1140
;1140:		}
LABELV $693
line 1142
;1141:
;1142:			if ( skinStr[0] == '/' ) {
ADDRLP4 1996
INDIRI1
CVII4 1
CNSTI4 47
NEI4 $697
line 1143
;1143:				skin = skinStr;
ADDRLP4 1928
ADDRLP4 1996
ASGNP4
line 1144
;1144:				*skin++ = 0;
ADDRLP4 2064
ADDRLP4 1928
INDIRP4
ASGNP4
ADDRLP4 1928
ADDRLP4 2064
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 2064
INDIRP4
CNSTI1 0
ASGNI1
line 1145
;1145:			} else {
ADDRGP4 $698
JUMPV
LABELV $697
line 1146
;1146:				if ( ( skin = strchr( modelStr, '/' ) ) == NULL) {
ADDRLP4 1932
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 2064
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1928
ADDRLP4 2064
INDIRP4
ASGNP4
ADDRLP4 2064
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $699
line 1147
;1147:					skin = "default";
ADDRLP4 1928
ADDRGP4 $161
ASGNP4
line 1148
;1148:				} else {
ADDRGP4 $700
JUMPV
LABELV $699
line 1149
;1149:					*skin++ = 0;
ADDRLP4 2068
ADDRLP4 1928
INDIRP4
ASGNP4
ADDRLP4 1928
ADDRLP4 2068
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 2068
INDIRP4
CNSTI1 0
ASGNI1
line 1150
;1150:				}
LABELV $700
line 1151
;1151:			}
LABELV $698
line 1153
;1152:
;1153:		if ( cg_debugModels.integer ) {
ADDRGP4 cg_debugModels+12
INDIRI4
CNSTI4 0
EQI4 $701
line 1154
;1154:			CG_Printf("DBG:TeamModel: %s - Skin: %s\n", modelStr, skin);
ADDRGP4 $704
ARGP4
ADDRLP4 1932
ARGP4
ADDRLP4 1928
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1155
;1155:		}
LABELV $701
line 1156
;1156:		Q_strncpyz( newInfo.skinName, skin, sizeof( newInfo.skinName ) );
ADDRLP4 0+284
ARGP4
ADDRLP4 1928
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1157
;1157:		Q_strncpyz( newInfo.modelName, modelStr, sizeof( newInfo.modelName ) );
ADDRLP4 0+220
ARGP4
ADDRLP4 1932
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1158
;1158:		newInfo.forceNMEorTM = qtrue;
ADDRLP4 0+1772
CNSTI4 1
ASGNI4
line 1159
;1159:	} else if ( cg_forceModel.integer ) {
ADDRGP4 $683
JUMPV
LABELV $682
ADDRGP4 cg_forceModel+12
INDIRI4
CNSTI4 0
EQI4 $710
line 1166
;1160:		// forcemodel makes everyone use a single model
;1161:		// to prevent load hitches
;1162:		char modelStr[MAX_QPATH];
;1163:		char *skin;
;1164:
;1165:		//It's possible that this litterally pulls out /headmodel and not the /team_headmodel when it should do so.
;1166:		trap_Cvar_VariableStringBuffer( "model", modelStr, sizeof( modelStr ) );
ADDRGP4 $652
ARGP4
ADDRLP4 1928
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1167
;1167:		if ( ( skin = strchr( modelStr, '/' ) ) == NULL) {
ADDRLP4 1928
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 1996
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1992
ADDRLP4 1996
INDIRP4
ASGNP4
ADDRLP4 1996
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $713
line 1168
;1168:			skin = "default";
ADDRLP4 1992
ADDRGP4 $161
ASGNP4
line 1169
;1169:		} else {
ADDRGP4 $714
JUMPV
LABELV $713
line 1170
;1170:			*skin++ = 0;
ADDRLP4 2000
ADDRLP4 1992
INDIRP4
ASGNP4
ADDRLP4 1992
ADDRLP4 2000
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 2000
INDIRP4
CNSTI1 0
ASGNI1
line 1171
;1171:		}
LABELV $714
line 1173
;1172:
;1173:		Q_strncpyz( newInfo.skinName, skin, sizeof( newInfo.skinName ) );
ADDRLP4 0+284
ARGP4
ADDRLP4 1992
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1174
;1174:		Q_strncpyz( newInfo.modelName, modelStr, sizeof( newInfo.modelName ) );
ADDRLP4 0+220
ARGP4
ADDRLP4 1928
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1176
;1175:
;1176:		if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $719
line 1178
;1177:			// keep skin name
;1178:			slash = strchr( v, '/' );
ADDRLP4 1784
INDIRP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 2000
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1820
ADDRLP4 2000
INDIRP4
ASGNP4
line 1179
;1179:			if ( slash ) {
ADDRLP4 1820
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $722
line 1180
;1180:				Q_strncpyz( newInfo.skinName, slash + 1, sizeof( newInfo.skinName ) );
ADDRLP4 0+284
ARGP4
ADDRLP4 1820
INDIRP4
CNSTI4 1
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1181
;1181:			}
LABELV $722
line 1182
;1182:		}
LABELV $719
line 1183
;1183:		if ( cg_debugModels.integer ) {
ADDRGP4 cg_debugModels+12
INDIRI4
CNSTI4 0
EQI4 $711
line 1184
;1184:			CG_Printf("DBG:ForceModel: %s - Skin: %s\n", modelStr, skin);
ADDRGP4 $729
ARGP4
ADDRLP4 1928
ARGP4
ADDRLP4 1992
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1185
;1185:		}
line 1186
;1186:	} else {
ADDRGP4 $711
JUMPV
LABELV $710
line 1187
;1187:		if ( strlen(v) == 0 ) {
ADDRLP4 1784
INDIRP4
ARGP4
ADDRLP4 1928
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1928
INDIRI4
CNSTI4 0
NEI4 $730
line 1188
;1188:			Q_strncpyz( newInfo.modelName, DEFAULT_MODEL, sizeof( newInfo.modelName ) );
ADDRLP4 0+220
ARGP4
ADDRGP4 $472
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1189
;1189:		} else {
ADDRGP4 $731
JUMPV
LABELV $730
line 1190
;1190:			Q_strncpyz( newInfo.modelName, v, sizeof( newInfo.modelName ) );
ADDRLP4 0+220
ARGP4
ADDRLP4 1784
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1191
;1191:		}
LABELV $731
line 1193
;1192:
;1193:		slash = strchr( newInfo.modelName, '/' );
ADDRLP4 0+220
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 1932
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1820
ADDRLP4 1932
INDIRP4
ASGNP4
line 1194
;1194:		if ( !slash ) {
ADDRLP4 1820
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $737
line 1196
;1195:			// modelName didn not include a skin name
;1196:			Q_strncpyz( newInfo.skinName, "default", sizeof( newInfo.skinName ) );
ADDRLP4 0+284
ARGP4
ADDRGP4 $161
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1197
;1197:		} else {
ADDRGP4 $738
JUMPV
LABELV $737
line 1198
;1198:			Q_strncpyz( newInfo.skinName, slash + 1, sizeof( newInfo.skinName ) );
ADDRLP4 0+284
ARGP4
ADDRLP4 1820
INDIRP4
CNSTI4 1
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1200
;1199:			// truncate modelName
;1200:			*slash = 0;
ADDRLP4 1820
INDIRP4
CNSTI1 0
ASGNI1
line 1201
;1201:		}
LABELV $738
line 1202
;1202:	}
LABELV $711
LABELV $683
LABELV $654
line 1205
;1203:
;1204:	// head model
;1205:	v = Info_ValueForKey( configstring, "hmodel" );
ADDRLP4 1788
INDIRP4
ARGP4
ADDRGP4 $743
ARGP4
ADDRLP4 1928
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1784
ADDRLP4 1928
INDIRP4
ASGNP4
line 1206
;1206:	if ( strlen(cg_enemyModel.string) > 0 && isEnemy(&newInfo, clientNum) ) {
ADDRGP4 cg_enemyModel+16
ARGP4
ADDRLP4 1932
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1932
INDIRI4
CNSTI4 0
LEI4 $744
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1936
ADDRGP4 isEnemy
CALLI4
ASGNI4
ADDRLP4 1936
INDIRI4
CNSTI4 0
EQI4 $744
line 1212
;1207:		//Evo:Model:
;1208:		char modelStr[MAX_QPATH];
;1209:		char skinStr[MAX_QPATH];
;1210:		char *skin;
;1211:		//Save the client's model
;1212:		Q_strncpyz( cg.savedheadModelName, v, sizeof( cg.savedheadModelName ) );
ADDRGP4 cg+170708
ARGP4
ADDRLP4 1784
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1213
;1213:		if ( ( skin = strchr( cg.savedheadModelName, '/' ) ) == NULL) {
ADDRGP4 cg+170708
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 2072
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1940
ADDRLP4 2072
INDIRP4
ASGNP4
ADDRLP4 2072
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $749
line 1214
;1214:			skin = "default";
ADDRLP4 1940
ADDRGP4 $161
ASGNP4
line 1215
;1215:		} else {
ADDRGP4 $750
JUMPV
LABELV $749
line 1216
;1216:			*skin++ = 0;
ADDRLP4 2076
ADDRLP4 1940
INDIRP4
ASGNP4
ADDRLP4 1940
ADDRLP4 2076
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 2076
INDIRP4
CNSTI1 0
ASGNI1
line 1217
;1217:		}
LABELV $750
line 1218
;1218:		Q_strncpyz( cg.savedheadSkinName, skin, sizeof( cg.savedheadSkinName ) );
ADDRGP4 cg+170772
ARGP4
ADDRLP4 1940
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1219
;1219:		skin = 0;
ADDRLP4 1940
CNSTP4 0
ASGNP4
line 1223
;1220:		//CG_Printf("DBG: %s -- %s\n", cg.savedheadModelName, cg.savedheadSkinName);
;1221:		
;1222:		//"force" enemyModel and/or skin
;1223:		if ( cg_enemyModel.string[0] != '/' ) {
ADDRGP4 cg_enemyModel+16
INDIRI1
CVII4 1
CNSTI4 47
EQI4 $754
line 1224
;1224:			Com_sprintf(modelStr, sizeof(modelStr), cg_enemyModel.string, 0);
ADDRLP4 1944
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 cg_enemyModel+16
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1225
;1225:		} else {
ADDRGP4 $755
JUMPV
LABELV $754
line 1227
;1226:			char *model2;
;1227:			Com_sprintf(modelStr, sizeof(modelStr), v, 0);
ADDRLP4 1944
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 1784
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1228
;1228:			model2 = Q_CopyStringUntil(modelStr, "/");
ADDRLP4 1944
ARGP4
ADDRGP4 $667
ARGP4
ADDRLP4 2080
ADDRGP4 Q_CopyStringUntil
CALLP4
ASGNP4
ADDRLP4 2076
ADDRLP4 2080
INDIRP4
ASGNP4
line 1230
;1229:			//CG_Printf("%s\n", model2);
;1230:			Com_sprintf(modelStr, sizeof(modelStr), model2, 0);
ADDRLP4 1944
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 2076
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1231
;1231:			Com_sprintf(skinStr, sizeof(skinStr), cg_enemyModel.string, 0);
ADDRLP4 2008
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 cg_enemyModel+16
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1232
;1232:		}
LABELV $755
line 1234
;1233:		///
;1234:			if ( skinStr[0] == '/' ) {
ADDRLP4 2008
INDIRI1
CVII4 1
CNSTI4 47
NEI4 $759
line 1235
;1235:					skin = skinStr;
ADDRLP4 1940
ADDRLP4 2008
ASGNP4
line 1236
;1236:					*skin++ = 0;
ADDRLP4 2076
ADDRLP4 1940
INDIRP4
ASGNP4
ADDRLP4 1940
ADDRLP4 2076
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 2076
INDIRP4
CNSTI1 0
ASGNI1
line 1237
;1237:			} else
ADDRGP4 $760
JUMPV
LABELV $759
line 1238
;1238:		if ( ( skin = strchr( modelStr, '/' ) ) == NULL) {
ADDRLP4 1944
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 2076
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1940
ADDRLP4 2076
INDIRP4
ASGNP4
ADDRLP4 2076
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $761
line 1239
;1239:			skin = "default";
ADDRLP4 1940
ADDRGP4 $161
ASGNP4
line 1240
;1240:		} else {
ADDRGP4 $762
JUMPV
LABELV $761
line 1241
;1241:			*skin++ = 0;
ADDRLP4 2080
ADDRLP4 1940
INDIRP4
ASGNP4
ADDRLP4 1940
ADDRLP4 2080
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 2080
INDIRP4
CNSTI1 0
ASGNI1
line 1242
;1242:		}
LABELV $762
LABELV $760
line 1244
;1243:
;1244:		Q_strncpyz( newInfo.headSkinName, skin, sizeof( newInfo.headSkinName ) );
ADDRLP4 0+412
ARGP4
ADDRLP4 1940
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1245
;1245:		Q_strncpyz( newInfo.headModelName, modelStr, sizeof( newInfo.headModelName ) );
ADDRLP4 0+348
ARGP4
ADDRLP4 1944
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1246
;1246:		if ( cg_debugModels.integer ) {
ADDRGP4 cg_debugModels+12
INDIRI4
CNSTI4 0
EQI4 $745
line 1247
;1247:			CG_Printf("DBG:Model: %s - Skin: %s\n", modelStr, skin);
ADDRGP4 $770
ARGP4
ADDRLP4 1944
ARGP4
ADDRLP4 1940
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1248
;1248:		}
line 1249
;1249:	} else if ( strlen(cg_teamModel.string) > 0 && isTeammate(&newInfo, clientNum) ) {
ADDRGP4 $745
JUMPV
LABELV $744
ADDRGP4 cg_teamModel+16
ARGP4
ADDRLP4 1940
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1940
INDIRI4
CNSTI4 0
LEI4 $771
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1944
ADDRGP4 isTeammate
CALLI4
ASGNI4
ADDRLP4 1944
INDIRI4
CNSTI4 0
EQI4 $771
line 1255
;1250:		//Evo:Model:
;1251:		char modelStr[MAX_QPATH];
;1252:		char skinStr[MAX_QPATH];
;1253:		char *skin;
;1254:		//Save the client's model
;1255:		Q_strncpyz( cg.savedheadModelName, v, sizeof( cg.savedheadModelName ) );
ADDRGP4 cg+170708
ARGP4
ADDRLP4 1784
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1256
;1256:		if ( ( skin = strchr( cg.savedheadModelName, '/' ) ) == NULL) {
ADDRGP4 cg+170708
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 2080
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1948
ADDRLP4 2080
INDIRP4
ASGNP4
ADDRLP4 2080
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $776
line 1257
;1257:			skin = "default";
ADDRLP4 1948
ADDRGP4 $161
ASGNP4
line 1258
;1258:		} else {
ADDRGP4 $777
JUMPV
LABELV $776
line 1259
;1259:			*skin++ = 0;
ADDRLP4 2084
ADDRLP4 1948
INDIRP4
ASGNP4
ADDRLP4 1948
ADDRLP4 2084
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 2084
INDIRP4
CNSTI1 0
ASGNI1
line 1260
;1260:		}
LABELV $777
line 1261
;1261:		Q_strncpyz( cg.savedheadSkinName, skin, sizeof( cg.savedheadSkinName ) );
ADDRGP4 cg+170772
ARGP4
ADDRLP4 1948
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1262
;1262:		skin = 0;
ADDRLP4 1948
CNSTP4 0
ASGNP4
line 1266
;1263:		//CG_Printf("DBG: %s -- %s\n", cg.savedheadModelName, cg.savedheadSkinName);
;1264:		
;1265:		//"force" teamModel and/or skin
;1266:		if ( cg_teamModel.string[0] != '/' ) {
ADDRGP4 cg_teamModel+16
INDIRI1
CVII4 1
CNSTI4 47
EQI4 $781
line 1267
;1267:			Com_sprintf(modelStr, sizeof(modelStr), cg_teamModel.string, 0);
ADDRLP4 1952
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 cg_teamModel+16
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1268
;1268:		} else {
ADDRGP4 $782
JUMPV
LABELV $781
line 1270
;1269:			char *model2;
;1270:			Com_sprintf(modelStr, sizeof(modelStr), v, 0);
ADDRLP4 1952
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 1784
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1271
;1271:			model2 = Q_CopyStringUntil(modelStr, "/");
ADDRLP4 1952
ARGP4
ADDRGP4 $667
ARGP4
ADDRLP4 2088
ADDRGP4 Q_CopyStringUntil
CALLP4
ASGNP4
ADDRLP4 2084
ADDRLP4 2088
INDIRP4
ASGNP4
line 1273
;1272:			//CG_Printf("%s\n", model2);
;1273:			Com_sprintf(modelStr, sizeof(modelStr), model2, 0);
ADDRLP4 1952
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 2084
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1274
;1274:			Com_sprintf(skinStr, sizeof(skinStr), cg_teamModel.string, 0);
ADDRLP4 2016
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 cg_teamModel+16
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1275
;1275:		}
LABELV $782
line 1277
;1276:
;1277:			if ( skinStr[0] == '/' ) {
ADDRLP4 2016
INDIRI1
CVII4 1
CNSTI4 47
NEI4 $786
line 1278
;1278:				skin = skinStr;
ADDRLP4 1948
ADDRLP4 2016
ASGNP4
line 1279
;1279:				*skin++ = 0;
ADDRLP4 2084
ADDRLP4 1948
INDIRP4
ASGNP4
ADDRLP4 1948
ADDRLP4 2084
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 2084
INDIRP4
CNSTI1 0
ASGNI1
line 1280
;1280:			} else
ADDRGP4 $787
JUMPV
LABELV $786
line 1281
;1281:		if ( ( skin = strchr( modelStr, '/' ) ) == NULL) {
ADDRLP4 1952
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 2084
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1948
ADDRLP4 2084
INDIRP4
ASGNP4
ADDRLP4 2084
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $788
line 1282
;1282:			skin = "default";
ADDRLP4 1948
ADDRGP4 $161
ASGNP4
line 1283
;1283:		} else {
ADDRGP4 $789
JUMPV
LABELV $788
line 1284
;1284:			*skin++ = 0;
ADDRLP4 2088
ADDRLP4 1948
INDIRP4
ASGNP4
ADDRLP4 1948
ADDRLP4 2088
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 2088
INDIRP4
CNSTI1 0
ASGNI1
line 1285
;1285:		}
LABELV $789
LABELV $787
line 1287
;1286:
;1287:		Q_strncpyz( newInfo.headSkinName, skin, sizeof( newInfo.headSkinName ) );
ADDRLP4 0+412
ARGP4
ADDRLP4 1948
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1288
;1288:		Q_strncpyz( newInfo.headModelName, modelStr, sizeof( newInfo.headModelName ) );
ADDRLP4 0+348
ARGP4
ADDRLP4 1952
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1289
;1289:	} else if ( cg_forceModel.integer ) {
ADDRGP4 $772
JUMPV
LABELV $771
ADDRGP4 cg_forceModel+12
INDIRI4
CNSTI4 0
EQI4 $794
line 1297
;1290:		// forcemodel makes everyone use a single model
;1291:		// to prevent load hitches
;1292:		char modelStr[MAX_QPATH];
;1293:		char *skin;
;1294:
;1295:	
;1296:		//It's possible that this litterally pulls out /headmodel and not the /team_headmodel when it should do so.
;1297:			trap_Cvar_VariableStringBuffer( "headmodel", modelStr, sizeof( modelStr ) );
ADDRGP4 $797
ARGP4
ADDRLP4 1948
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1298
;1298:			if ( ( skin = strchr( modelStr, '/' ) ) == NULL) {
ADDRLP4 1948
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 2016
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 2012
ADDRLP4 2016
INDIRP4
ASGNP4
ADDRLP4 2016
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $798
line 1299
;1299:				skin = "default";
ADDRLP4 2012
ADDRGP4 $161
ASGNP4
line 1300
;1300:			} else {
ADDRGP4 $799
JUMPV
LABELV $798
line 1301
;1301:				*skin++ = 0;
ADDRLP4 2020
ADDRLP4 2012
INDIRP4
ASGNP4
ADDRLP4 2012
ADDRLP4 2020
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 2020
INDIRP4
CNSTI1 0
ASGNI1
line 1302
;1302:			}
LABELV $799
line 1304
;1303:
;1304:			Q_strncpyz( newInfo.headSkinName, skin, sizeof( newInfo.headSkinName ) );
ADDRLP4 0+412
ARGP4
ADDRLP4 2012
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1305
;1305:			Q_strncpyz( newInfo.headModelName, modelStr, sizeof( newInfo.headModelName ) );
ADDRLP4 0+348
ARGP4
ADDRLP4 1948
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1307
;1306:
;1307:		if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $795
line 1309
;1308:			// keep skin name
;1309:			slash = strchr( v, '/' );
ADDRLP4 1784
INDIRP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 2020
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1820
ADDRLP4 2020
INDIRP4
ASGNP4
line 1310
;1310:			if ( slash ) {
ADDRLP4 1820
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $795
line 1311
;1311:				Q_strncpyz( newInfo.headSkinName, slash + 1, sizeof( newInfo.headSkinName ) );
ADDRLP4 0+412
ARGP4
ADDRLP4 1820
INDIRP4
CNSTI4 1
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1312
;1312:			}
line 1313
;1313:		}
line 1314
;1314:	} else {
ADDRGP4 $795
JUMPV
LABELV $794
line 1315
;1315:		if ( strlen(v) == 0 ) {
ADDRLP4 1784
INDIRP4
ARGP4
ADDRLP4 1948
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1948
INDIRI4
CNSTI4 0
NEI4 $811
line 1316
;1316:			Q_strncpyz( newInfo.headModelName, DEFAULT_MODEL, sizeof( newInfo.headModelName ) );
ADDRLP4 0+348
ARGP4
ADDRGP4 $472
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1317
;1317:		} else {
ADDRGP4 $812
JUMPV
LABELV $811
line 1318
;1318:			Q_strncpyz( newInfo.headModelName, v, sizeof( newInfo.headModelName ) );
ADDRLP4 0+348
ARGP4
ADDRLP4 1784
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1319
;1319:		}
LABELV $812
line 1321
;1320:
;1321:		slash = strchr( newInfo.headModelName, '/' );
ADDRLP4 0+348
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 1952
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1820
ADDRLP4 1952
INDIRP4
ASGNP4
line 1322
;1322:		if ( !slash ) {
ADDRLP4 1820
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $818
line 1324
;1323:			// modelName didn not include a skin name
;1324:			Q_strncpyz( newInfo.headSkinName, "default", sizeof( newInfo.headSkinName ) );
ADDRLP4 0+412
ARGP4
ADDRGP4 $161
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1325
;1325:		} else {
ADDRGP4 $819
JUMPV
LABELV $818
line 1326
;1326:			Q_strncpyz( newInfo.headSkinName, slash + 1, sizeof( newInfo.headSkinName ) );
ADDRLP4 0+412
ARGP4
ADDRLP4 1820
INDIRP4
CNSTI4 1
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1328
;1327:			// truncate modelName
;1328:			*slash = 0;
ADDRLP4 1820
INDIRP4
CNSTI1 0
ASGNI1
line 1329
;1329:		}
LABELV $819
line 1330
;1330:	}
LABELV $795
LABELV $772
LABELV $745
line 1334
;1331:
;1332:	// scan for an existing clientinfo that matches this modelname
;1333:	// so we can avoid loading checks if possible
;1334:	if ( !CG_ScanForExistingClientInfo( &newInfo ) ) {
ADDRLP4 0
ARGP4
ADDRLP4 1948
ADDRGP4 CG_ScanForExistingClientInfo
CALLI4
ASGNI4
ADDRLP4 1948
INDIRI4
CNSTI4 0
NEI4 $824
line 1337
;1335:		qboolean	forceDefer;
;1336:
;1337:		forceDefer = trap_MemoryRemaining() < 4000000;
ADDRLP4 1960
ADDRGP4 trap_MemoryRemaining
CALLI4
ASGNI4
ADDRLP4 1960
INDIRI4
CNSTI4 4000000
GEI4 $827
ADDRLP4 1956
CNSTI4 1
ASGNI4
ADDRGP4 $828
JUMPV
LABELV $827
ADDRLP4 1956
CNSTI4 0
ASGNI4
LABELV $828
ADDRLP4 1952
ADDRLP4 1956
INDIRI4
ASGNI4
line 1341
;1338:
;1339:		// if we are defering loads, just have it pick the first valid
;1340:		//Evo:Model: don't defer models when we're explicitly forcing them.
;1341:		if ( !newInfo.forceNMEorTM && ( forceDefer || (cg_deferPlayers.integer && !cg_buildScript.integer && !cg.loading ) ) ) {
ADDRLP4 1964
CNSTI4 0
ASGNI4
ADDRLP4 0+1772
INDIRI4
ADDRLP4 1964
INDIRI4
NEI4 $829
ADDRLP4 1952
INDIRI4
ADDRLP4 1964
INDIRI4
NEI4 $835
ADDRGP4 cg_deferPlayers+12
INDIRI4
ADDRLP4 1964
INDIRI4
EQI4 $829
ADDRGP4 cg_buildScript+12
INDIRI4
ADDRLP4 1964
INDIRI4
NEI4 $829
ADDRGP4 cg+20
INDIRI4
ADDRLP4 1964
INDIRI4
NEI4 $829
LABELV $835
line 1343
;1342:			// keep whatever they had if it won't violate team skins
;1343:			CG_SetDeferredClientInfo( &newInfo );
ADDRLP4 0
ARGP4
ADDRGP4 CG_SetDeferredClientInfo
CALLV
pop
line 1345
;1344:			// if we are low on memory, leave them with this model
;1345:			if ( forceDefer ) {
ADDRLP4 1952
INDIRI4
CNSTI4 0
EQI4 $830
line 1346
;1346:				CG_Printf( "Memory is low.  Using deferred model.\n" );
ADDRGP4 $838
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1347
;1347:				newInfo.deferred = qfalse;
ADDRLP4 0+540
CNSTI4 0
ASGNI4
line 1348
;1348:			}
line 1349
;1349:		} else {
ADDRGP4 $830
JUMPV
LABELV $829
line 1350
;1350:			CG_LoadClientInfo( &newInfo );
ADDRLP4 0
ARGP4
ADDRGP4 CG_LoadClientInfo
CALLV
pop
line 1351
;1351:		}
LABELV $830
line 1352
;1352:	}
LABELV $824
line 1355
;1353:
;1354:	// replace whatever was there with the new one
;1355:	newInfo.infoValid = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1356
;1356:	*ci = newInfo;
ADDRLP4 1816
INDIRP4
ADDRLP4 0
INDIRB
ASGNB 1776
line 1359
;1357:
;1358:	//Evo:Model:Clear saved variables, we don't need them after the client has loaded.
;1359:	if ( newInfo.forceNMEorTM ) {
ADDRLP4 0+1772
INDIRI4
CNSTI4 0
EQI4 $840
line 1360
;1360:		memset(cg.savedheadModelName, 0, sizeof(cg.savedheadModelName) );
ADDRGP4 cg+170708
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1361
;1361:		memset(cg.savedheadSkinName, 0, sizeof(cg.savedheadSkinName) );
ADDRGP4 cg+170772
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1362
;1362:		memset(cg.savedmodelName, 0, sizeof(cg.savedmodelName) );
ADDRGP4 cg+170580
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1363
;1363:		memset(cg.savedskinName, 0, sizeof(cg.savedskinName) );
ADDRGP4 cg+170644
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1364
;1364:	}
LABELV $840
line 1365
;1365:}
LABELV $572
endproc CG_NewClientInfo 2092 16
export CG_LoadDeferredPlayers
proc CG_LoadDeferredPlayers 20 4
line 1378
;1366:
;1367:
;1368:
;1369:/*
;1370:======================
;1371:CG_LoadDeferredPlayers
;1372:
;1373:Called each frame when a player is dead
;1374:and the scoreboard is up
;1375:so deferred players can be loaded
;1376:======================
;1377:*/
;1378:void CG_LoadDeferredPlayers( void ) {
line 1383
;1379:	int		i;
;1380:	clientInfo_t	*ci;
;1381:
;1382:	// scan for a deferred player to load
;1383:	for ( i = 0, ci = cgs.clientinfo ; i < cgs.maxclients ; i++, ci++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
ADDRGP4 cgs+40960
ASGNP4
ADDRGP4 $855
JUMPV
LABELV $852
line 1384
;1384:		if ( ci->infoValid && ci->deferred ) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $858
ADDRLP4 0
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $858
line 1386
;1385:			// if we are low on memory, leave it deferred
;1386:			if ( trap_MemoryRemaining() < 4000000 ) {
ADDRLP4 16
ADDRGP4 trap_MemoryRemaining
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 4000000
GEI4 $860
line 1387
;1387:				CG_Printf( "Memory is low.  Using deferred model.\n" );
ADDRGP4 $838
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1388
;1388:				ci->deferred = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 540
ADDP4
CNSTI4 0
ASGNI4
line 1389
;1389:				continue;
ADDRGP4 $853
JUMPV
LABELV $860
line 1391
;1390:			}
;1391:			CG_LoadClientInfo( ci );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_LoadClientInfo
CALLV
pop
line 1393
;1392://			break;
;1393:		}
LABELV $858
line 1394
;1394:	}
LABELV $853
line 1383
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1776
ADDP4
ASGNP4
LABELV $855
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+31480
INDIRI4
LTI4 $852
line 1395
;1395:}
LABELV $851
endproc CG_LoadDeferredPlayers 20 4
proc CG_SetLerpFrameAnimation 12 8
line 1413
;1396:
;1397:/*
;1398:=============================================================================
;1399:
;1400:PLAYER ANIMATION
;1401:
;1402:=============================================================================
;1403:*/
;1404:
;1405:
;1406:/*
;1407:===============
;1408:CG_SetLerpFrameAnimation
;1409:
;1410:may include ANIM_TOGGLEBIT
;1411:===============
;1412:*/
;1413:static void CG_SetLerpFrameAnimation( clientInfo_t *ci, lerpFrame_t *lf, int newAnimation ) {
line 1416
;1414:	animation_t	*anim;
;1415:
;1416:	lf->animationNumber = newAnimation;
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 1417
;1417:	newAnimation &= ~ANIM_TOGGLEBIT;
ADDRFP4 8
ADDRFP4 8
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 1419
;1418:
;1419:	if ( newAnimation < 0 || newAnimation >= MAX_TOTALANIMATIONS ) {
ADDRLP4 4
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $865
ADDRLP4 4
INDIRI4
CNSTI4 37
LTI4 $863
LABELV $865
line 1420
;1420:		CG_Error( "Bad animation number: %i", newAnimation );
ADDRGP4 $866
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 1421
;1421:	}
LABELV $863
line 1423
;1422:
;1423:	anim = &ci->animations[ newAnimation ];
ADDRLP4 0
CNSTI4 28
ADDRFP4 8
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
ADDP4
ASGNP4
line 1425
;1424:
;1425:	lf->animation = anim;
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 1426
;1426:	lf->animationTime = lf->frameTime + anim->initialLerp;
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ADDI4
ASGNI4
line 1428
;1427:
;1428:	if ( cg_debugAnim.integer ) {
ADDRGP4 cg_debugAnim+12
INDIRI4
CNSTI4 0
EQI4 $867
line 1429
;1429:		CG_Printf( "Anim: %i\n", newAnimation );
ADDRGP4 $870
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 1430
;1430:	}
LABELV $867
line 1431
;1431:}
LABELV $862
endproc CG_SetLerpFrameAnimation 12 8
proc CG_RunLerpFrame 44 12
line 1441
;1432:
;1433:/*
;1434:===============
;1435:CG_RunLerpFrame
;1436:
;1437:Sets cg.snap, cg.oldFrame, and cg.backlerp
;1438:cg.time should be between oldFrameTime and frameTime after exit
;1439:===============
;1440:*/
;1441:static void CG_RunLerpFrame( clientInfo_t *ci, lerpFrame_t *lf, int newAnimation, float speedScale ) {
line 1446
;1442:	int			f, numFrames;
;1443:	animation_t	*anim;
;1444:
;1445:	// debugging tool to get no animations
;1446:	if ( cg_animSpeed.integer == 0 ) {
ADDRGP4 cg_animSpeed+12
INDIRI4
CNSTI4 0
NEI4 $872
line 1447
;1447:		lf->oldFrame = lf->frame = lf->backlerp = 0;
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
CNSTF4 0
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 20
ADDRLP4 16
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
ADDRLP4 12
INDIRP4
ADDRLP4 20
INDIRI4
ASGNI4
line 1448
;1448:		return;
ADDRGP4 $871
JUMPV
LABELV $872
line 1452
;1449:	}
;1450:
;1451:	// see if the animation sequence is switching
;1452:	if ( newAnimation != lf->animationNumber || !lf->animation ) {
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 8
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
NEI4 $877
ADDRLP4 12
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $875
LABELV $877
line 1453
;1453:		CG_SetLerpFrameAnimation( ci, lf, newAnimation );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 CG_SetLerpFrameAnimation
CALLV
pop
line 1454
;1454:	}
LABELV $875
line 1458
;1455:
;1456:	// if we have passed the current frame, move it to
;1457:	// oldFrame and calculate a new frame
;1458:	if ( cg.time >= lf->frameTime ) {
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
LTI4 $878
line 1459
;1459:		lf->oldFrame = lf->frame;
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1460
;1460:		lf->oldFrameTime = lf->frameTime;
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1463
;1461:
;1462:		// get the next frame based on the animation
;1463:		anim = lf->animation;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
ASGNP4
line 1464
;1464:		if ( !anim->frameLerp ) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
NEI4 $881
line 1465
;1465:			return;		// shouldn't happen
ADDRGP4 $871
JUMPV
LABELV $881
line 1467
;1466:		}
;1467:		if ( cg.time < lf->animationTime ) {
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
GEI4 $883
line 1468
;1468:			lf->frameTime = lf->animationTime;		// initial lerp
ADDRLP4 24
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ASGNI4
line 1469
;1469:		} else {
ADDRGP4 $884
JUMPV
LABELV $883
line 1470
;1470:			lf->frameTime = lf->oldFrameTime + anim->frameLerp;
ADDRLP4 24
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 28
CNSTI4 12
ASGNI4
ADDRLP4 24
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
ADDI4
ASGNI4
line 1471
;1471:		}
LABELV $884
line 1472
;1472:		f = ( lf->frameTime - lf->animationTime ) / anim->frameLerp;
ADDRLP4 24
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 28
CNSTI4 12
ASGNI4
ADDRLP4 4
ADDRLP4 24
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
ADDRLP4 24
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
SUBI4
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
DIVI4
ASGNI4
line 1473
;1473:		f *= speedScale;		// adjust for haste, etc
ADDRLP4 4
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRFP4 12
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 1475
;1474:
;1475:		numFrames = anim->numFrames;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1476
;1476:		if (anim->flipflop) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 0
EQI4 $886
line 1477
;1477:			numFrames *= 2;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 1478
;1478:		}
LABELV $886
line 1479
;1479:		if ( f >= numFrames ) {
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $888
line 1480
;1480:			f -= numFrames;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ASGNI4
line 1481
;1481:			if ( anim->loopFrames ) {
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 0
EQI4 $890
line 1482
;1482:				f %= anim->loopFrames;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MODI4
ASGNI4
line 1483
;1483:				f += anim->numFrames - anim->loopFrames;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
SUBI4
ADDI4
ASGNI4
line 1484
;1484:			} else {
ADDRGP4 $891
JUMPV
LABELV $890
line 1485
;1485:				f = numFrames - 1;
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1488
;1486:				// the animation is stuck at the end, so it
;1487:				// can immediately transition to another sequence
;1488:				lf->frameTime = cg.time;
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1489
;1489:			}
LABELV $891
line 1490
;1490:		}
LABELV $888
line 1491
;1491:		if ( anim->reversed ) {
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 0
EQI4 $893
line 1492
;1492:			lf->frame = anim->firstFrame + anim->numFrames - 1 - f;
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ADDRLP4 4
INDIRI4
SUBI4
ASGNI4
line 1493
;1493:		}
ADDRGP4 $894
JUMPV
LABELV $893
line 1494
;1494:		else if (anim->flipflop && f>=anim->numFrames) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 0
EQI4 $895
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LTI4 $895
line 1495
;1495:			lf->frame = anim->firstFrame + anim->numFrames - 1 - (f%anim->numFrames);
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 40
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ADDRLP4 4
INDIRI4
ADDRLP4 40
INDIRI4
MODI4
SUBI4
ASGNI4
line 1496
;1496:		}
ADDRGP4 $896
JUMPV
LABELV $895
line 1497
;1497:		else {
line 1498
;1498:			lf->frame = anim->firstFrame + f;
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 1499
;1499:		}
LABELV $896
LABELV $894
line 1500
;1500:		if ( cg.time > lf->frameTime ) {
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
LEI4 $897
line 1501
;1501:			lf->frameTime = cg.time;
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1502
;1502:			if ( cg_debugAnim.integer ) {
ADDRGP4 cg_debugAnim+12
INDIRI4
CNSTI4 0
EQI4 $901
line 1503
;1503:				CG_Printf( "Clamp lf->frameTime\n");
ADDRGP4 $904
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1504
;1504:			}
LABELV $901
line 1505
;1505:		}
LABELV $897
line 1506
;1506:	}
LABELV $878
line 1508
;1507:
;1508:	if ( lf->frameTime > cg.time + 200 ) {
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 200
ADDI4
LEI4 $905
line 1509
;1509:		lf->frameTime = cg.time;
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1510
;1510:	}
LABELV $905
line 1512
;1511:
;1512:	if ( lf->oldFrameTime > cg.time ) {
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $909
line 1513
;1513:		lf->oldFrameTime = cg.time;
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1514
;1514:	}
LABELV $909
line 1516
;1515:	// calculate current lerp value
;1516:	if ( lf->frameTime == lf->oldFrameTime ) {
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
NEI4 $913
line 1517
;1517:		lf->backlerp = 0;
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 0
ASGNF4
line 1518
;1518:	} else {
ADDRGP4 $914
JUMPV
LABELV $913
line 1519
;1519:		lf->backlerp = 1.0 - (float)( cg.time - lf->oldFrameTime ) / ( lf->frameTime - lf->oldFrameTime );
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 1065353216
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 24
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
SUBI4
CVIF4 4
DIVF4
SUBF4
ASGNF4
line 1520
;1520:	}
LABELV $914
line 1521
;1521:}
LABELV $871
endproc CG_RunLerpFrame 44 12
proc CG_ClearLerpFrame 16 12
line 1529
;1522:
;1523:
;1524:/*
;1525:===============
;1526:CG_ClearLerpFrame
;1527:===============
;1528:*/
;1529:static void CG_ClearLerpFrame( clientInfo_t *ci, lerpFrame_t *lf, int animationNumber ) {
line 1530
;1530:	lf->frameTime = lf->oldFrameTime = cg.time;
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 1531
;1531:	CG_SetLerpFrameAnimation( ci, lf, animationNumber );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 CG_SetLerpFrameAnimation
CALLV
pop
line 1532
;1532:	lf->oldFrame = lf->frame = lf->animation->firstFrame;
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 8
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 8
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1533
;1533:}
LABELV $916
endproc CG_ClearLerpFrame 16 12
proc CG_PlayerAnimation 20 16
line 1542
;1534:
;1535:
;1536:/*
;1537:===============
;1538:CG_PlayerAnimation
;1539:===============
;1540:*/
;1541:static void CG_PlayerAnimation( centity_t *cent, int *legsOld, int *legs, float *legsBackLerp,
;1542:						int *torsoOld, int *torso, float *torsoBackLerp ) {
line 1547
;1543:	clientInfo_t	*ci;
;1544:	int				clientNum;
;1545:	float			speedScale;
;1546:
;1547:	clientNum = cent->currentState.clientNum;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 1549
;1548:
;1549:	if ( cg_noPlayerAnims.integer ) {
ADDRGP4 cg_noPlayerAnims+12
INDIRI4
CNSTI4 0
EQI4 $919
line 1550
;1550:		*legsOld = *legs = *torsoOld = *torso = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRFP4 20
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
ADDRFP4 16
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1551
;1551:		return;
ADDRGP4 $918
JUMPV
LABELV $919
line 1554
;1552:	}
;1553:
;1554:	if ( cent->currentState.powerups & ( 1 << PW_HASTE ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $922
line 1555
;1555:		speedScale = 1.5;
ADDRLP4 4
CNSTF4 1069547520
ASGNF4
line 1556
;1556:	} else {
ADDRGP4 $923
JUMPV
LABELV $922
line 1557
;1557:		speedScale = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 1558
;1558:	}
LABELV $923
line 1560
;1559:
;1560:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 0
CNSTI4 1776
ADDRLP4 8
INDIRI4
MULI4
ADDRGP4 cgs+40960
ADDP4
ASGNP4
line 1563
;1561:
;1562:	// do the shuffle turn frames locally
;1563:	if ( cent->pe.legs.yawing && ( cent->currentState.legsAnim & ~ANIM_TOGGLEBIT ) == LEGS_IDLE ) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 476
ADDP4
INDIRI4
CNSTI4 0
EQI4 $925
ADDRLP4 12
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
CNSTI4 22
NEI4 $925
line 1564
;1564:		CG_RunLerpFrame( ci, &cent->pe.legs, LEGS_TURN, speedScale );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 452
ADDP4
ARGP4
CNSTI4 24
ARGI4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 CG_RunLerpFrame
CALLV
pop
line 1565
;1565:	} else {
ADDRGP4 $926
JUMPV
LABELV $925
line 1566
;1566:		CG_RunLerpFrame( ci, &cent->pe.legs, cent->currentState.legsAnim, speedScale );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 452
ADDP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 CG_RunLerpFrame
CALLV
pop
line 1567
;1567:	}
LABELV $926
line 1569
;1568:
;1569:	*legsOld = cent->pe.legs.oldFrame;
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
ASGNI4
line 1570
;1570:	*legs = cent->pe.legs.frame;
ADDRFP4 8
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
INDIRI4
ASGNI4
line 1571
;1571:	*legsBackLerp = cent->pe.legs.backlerp;
ADDRFP4 12
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRF4
ASGNF4
line 1573
;1572:
;1573:	CG_RunLerpFrame( ci, &cent->pe.torso, cent->currentState.torsoAnim, speedScale );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 500
ADDP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 CG_RunLerpFrame
CALLV
pop
line 1575
;1574:
;1575:	*torsoOld = cent->pe.torso.oldFrame;
ADDRFP4 16
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 500
ADDP4
INDIRI4
ASGNI4
line 1576
;1576:	*torso = cent->pe.torso.frame;
ADDRFP4 20
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 508
ADDP4
INDIRI4
ASGNI4
line 1577
;1577:	*torsoBackLerp = cent->pe.torso.backlerp;
ADDRFP4 24
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRF4
ASGNF4
line 1578
;1578:}
LABELV $918
endproc CG_PlayerAnimation 20 16
proc CG_SwingAngles 28 8
line 1594
;1579:
;1580:/*
;1581:=============================================================================
;1582:
;1583:PLAYER ANGLES
;1584:
;1585:=============================================================================
;1586:*/
;1587:
;1588:/*
;1589:==================
;1590:CG_SwingAngles
;1591:==================
;1592:*/
;1593:static void CG_SwingAngles( float destination, float swingTolerance, float clampTolerance,
;1594:					float speed, float *angle, qboolean *swinging ) {
line 1599
;1595:	float	swing;
;1596:	float	move;
;1597:	float	scale;
;1598:
;1599:	if ( !*swinging ) {
ADDRFP4 20
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $928
line 1601
;1600:		// see if a swing should be started
;1601:		swing = AngleSubtract( *angle, destination );
ADDRFP4 16
INDIRP4
INDIRF4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ASGNF4
line 1602
;1602:		if ( swing > swingTolerance || swing < -swingTolerance ) {
ADDRLP4 20
ADDRFP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRF4
GTF4 $932
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRF4
NEGF4
GEF4 $930
LABELV $932
line 1603
;1603:			*swinging = qtrue;
ADDRFP4 20
INDIRP4
CNSTI4 1
ASGNI4
line 1604
;1604:		}
LABELV $930
line 1605
;1605:	}
LABELV $928
line 1607
;1606:
;1607:	if ( !*swinging ) {
ADDRFP4 20
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $933
line 1608
;1608:		return;
ADDRGP4 $927
JUMPV
LABELV $933
line 1613
;1609:	}
;1610:	
;1611:	// modify the speed depending on the delta
;1612:	// so it doesn't seem so linear
;1613:	swing = AngleSubtract( destination, *angle );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ASGNF4
line 1614
;1614:	scale = fabs( swing );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 16
INDIRF4
ASGNF4
line 1615
;1615:	if ( scale < swingTolerance * 0.5 ) {
ADDRLP4 4
INDIRF4
CNSTF4 1056964608
ADDRFP4 4
INDIRF4
MULF4
GEF4 $935
line 1616
;1616:		scale = 0.5;
ADDRLP4 4
CNSTF4 1056964608
ASGNF4
line 1617
;1617:	} else if ( scale < swingTolerance ) {
ADDRGP4 $936
JUMPV
LABELV $935
ADDRLP4 4
INDIRF4
ADDRFP4 4
INDIRF4
GEF4 $937
line 1618
;1618:		scale = 1.0;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 1619
;1619:	} else {
ADDRGP4 $938
JUMPV
LABELV $937
line 1620
;1620:		scale = 2.0;
ADDRLP4 4
CNSTF4 1073741824
ASGNF4
line 1621
;1621:	}
LABELV $938
LABELV $936
line 1624
;1622:
;1623:	// swing towards the destination angle
;1624:	if ( swing >= 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LTF4 $939
line 1625
;1625:		move = cg.frametime * scale * speed;
ADDRLP4 8
ADDRGP4 cg+107600
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
MULF4
ADDRFP4 12
INDIRF4
MULF4
ASGNF4
line 1626
;1626:		if ( move >= swing ) {
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRF4
LTF4 $942
line 1627
;1627:			move = swing;
ADDRLP4 8
ADDRLP4 0
INDIRF4
ASGNF4
line 1628
;1628:			*swinging = qfalse;
ADDRFP4 20
INDIRP4
CNSTI4 0
ASGNI4
line 1629
;1629:		}
LABELV $942
line 1630
;1630:		*angle = AngleMod( *angle + move );
ADDRLP4 20
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 8
INDIRF4
ADDF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 1631
;1631:	} else if ( swing < 0 ) {
ADDRGP4 $940
JUMPV
LABELV $939
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $944
line 1632
;1632:		move = cg.frametime * scale * -speed;
ADDRLP4 8
ADDRGP4 cg+107600
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
MULF4
ADDRFP4 12
INDIRF4
NEGF4
MULF4
ASGNF4
line 1633
;1633:		if ( move <= swing ) {
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRF4
GTF4 $947
line 1634
;1634:			move = swing;
ADDRLP4 8
ADDRLP4 0
INDIRF4
ASGNF4
line 1635
;1635:			*swinging = qfalse;
ADDRFP4 20
INDIRP4
CNSTI4 0
ASGNI4
line 1636
;1636:		}
LABELV $947
line 1637
;1637:		*angle = AngleMod( *angle + move );
ADDRLP4 20
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 8
INDIRF4
ADDF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 1638
;1638:	}
LABELV $944
LABELV $940
line 1641
;1639:
;1640:	// clamp to no more than tolerance
;1641:	swing = AngleSubtract( destination, *angle );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 20
INDIRF4
ASGNF4
line 1642
;1642:	if ( swing > clampTolerance ) {
ADDRLP4 0
INDIRF4
ADDRFP4 8
INDIRF4
LEF4 $949
line 1643
;1643:		*angle = AngleMod( destination - (clampTolerance - 1) );
ADDRFP4 0
INDIRF4
ADDRFP4 8
INDIRF4
CNSTF4 1065353216
SUBF4
SUBF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRFP4 16
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 1644
;1644:	} else if ( swing < -clampTolerance ) {
ADDRGP4 $950
JUMPV
LABELV $949
ADDRLP4 0
INDIRF4
ADDRFP4 8
INDIRF4
NEGF4
GEF4 $951
line 1645
;1645:		*angle = AngleMod( destination + (clampTolerance - 1) );
ADDRFP4 0
INDIRF4
ADDRFP4 8
INDIRF4
CNSTF4 1065353216
SUBF4
ADDF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRFP4 16
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 1646
;1646:	}
LABELV $951
LABELV $950
line 1647
;1647:}
LABELV $927
endproc CG_SwingAngles 28 8
proc CG_AddPainTwitch 12 0
line 1654
;1648:
;1649:/*
;1650:=================
;1651:CG_AddPainTwitch
;1652:=================
;1653:*/
;1654:static void CG_AddPainTwitch( centity_t *cent, vec3_t torsoAngles ) {
line 1658
;1655:	int		t;
;1656:	float	f;
;1657:
;1658:	t = cg.time - cent->pe.painTime;
ADDRLP4 0
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 596
ADDP4
INDIRI4
SUBI4
ASGNI4
line 1659
;1659:	if ( t >= PAIN_TWITCH_TIME ) {
ADDRLP4 0
INDIRI4
CNSTI4 200
LTI4 $955
line 1660
;1660:		return;
ADDRGP4 $953
JUMPV
LABELV $955
line 1663
;1661:	}
;1662:
;1663:	f = 1.0 - (float)t / PAIN_TWITCH_TIME;
ADDRLP4 4
CNSTF4 1065353216
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1128792064
DIVF4
SUBF4
ASGNF4
line 1665
;1664:
;1665:	if ( cent->pe.painDirection ) {
ADDRFP4 0
INDIRP4
CNSTI4 600
ADDP4
INDIRI4
CNSTI4 0
EQI4 $957
line 1666
;1666:		torsoAngles[ROLL] += 20 * f;
ADDRLP4 8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CNSTF4 1101004800
ADDRLP4 4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1667
;1667:	} else {
ADDRGP4 $958
JUMPV
LABELV $957
line 1668
;1668:		torsoAngles[ROLL] -= 20 * f;
ADDRLP4 8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CNSTF4 1101004800
ADDRLP4 4
INDIRF4
MULF4
SUBF4
ASGNF4
line 1669
;1669:	}
LABELV $958
line 1670
;1670:}
LABELV $953
endproc CG_AddPainTwitch 12 0
data
align 4
LABELV $960
byte 4 0
byte 4 22
byte 4 45
byte 4 -22
byte 4 0
byte 4 22
byte 4 -45
byte 4 -22
code
proc CG_PlayerAngles 148 24
line 1687
;1671:
;1672:
;1673:/*
;1674:===============
;1675:CG_PlayerAngles
;1676:
;1677:Handles seperate torso motion
;1678:
;1679:  legs pivot based on direction of movement
;1680:
;1681:  head always looks exactly at cent->lerpAngles
;1682:
;1683:  if motion < 20 degrees, show in head only
;1684:  if < 45 degrees, also show in torso
;1685:===============
;1686:*/
;1687:static void CG_PlayerAngles( centity_t *cent, vec3_t legs[3], vec3_t torso[3], vec3_t head[3] ) {
line 1696
;1688:	vec3_t		legsAngles, torsoAngles, headAngles;
;1689:	float		dest;
;1690:	static	int	movementOffsets[8] = { 0, 22, 45, -22, 0, 22, -45, -22 };
;1691:	vec3_t		velocity;
;1692:	float		speed;
;1693:	int			dir, clientNum;
;1694:	clientInfo_t	*ci;
;1695:
;1696:	VectorCopy( cent->lerpAngles, headAngles );
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 1697
;1697:	headAngles[YAW] = AngleMod( headAngles[YAW] );
ADDRLP4 24+4
INDIRF4
ARGF4
ADDRLP4 68
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 68
INDIRF4
ASGNF4
line 1698
;1698:	VectorClear( legsAngles );
ADDRLP4 72
CNSTF4 0
ASGNF4
ADDRLP4 12+8
ADDRLP4 72
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 72
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 72
INDIRF4
ASGNF4
line 1699
;1699:	VectorClear( torsoAngles );
ADDRLP4 76
CNSTF4 0
ASGNF4
ADDRLP4 0+8
ADDRLP4 76
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 76
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 76
INDIRF4
ASGNF4
line 1704
;1700:
;1701:	// --------- yaw -------------
;1702:
;1703:	// allow yaw to drift a bit
;1704:	if ( ( cent->currentState.legsAnim & ~ANIM_TOGGLEBIT ) != LEGS_IDLE 
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
CNSTI4 -129
ASGNI4
ADDRLP4 80
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ADDRLP4 84
INDIRI4
BANDI4
CNSTI4 22
NEI4 $969
ADDRLP4 80
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ADDRLP4 84
INDIRI4
BANDI4
CNSTI4 11
EQI4 $967
LABELV $969
line 1705
;1705:		|| ( cent->currentState.torsoAnim & ~ANIM_TOGGLEBIT ) != TORSO_STAND  ) {
line 1707
;1706:		// if not standing still, always point all in the same direction
;1707:		cent->pe.torso.yawing = qtrue;	// always center
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
CNSTI4 1
ASGNI4
line 1708
;1708:		cent->pe.torso.pitching = qtrue;	// always center
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
CNSTI4 1
ASGNI4
line 1709
;1709:		cent->pe.legs.yawing = qtrue;	// always center
ADDRFP4 0
INDIRP4
CNSTI4 476
ADDP4
CNSTI4 1
ASGNI4
line 1710
;1710:	}
LABELV $967
line 1713
;1711:
;1712:	// adjust legs for movement dir
;1713:	if ( cent->currentState.eFlags & EF_DEAD ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $970
line 1715
;1714:		// don't let dead bodies twitch
;1715:		dir = 0;
ADDRLP4 52
CNSTI4 0
ASGNI4
line 1716
;1716:	} else {
ADDRGP4 $971
JUMPV
LABELV $970
line 1717
;1717:		dir = cent->currentState.angles2[YAW];
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 132
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 1718
;1718:		if ( dir < 0 || dir > 7 ) {
ADDRLP4 52
INDIRI4
CNSTI4 0
LTI4 $974
ADDRLP4 52
INDIRI4
CNSTI4 7
LEI4 $972
LABELV $974
line 1719
;1719:			CG_Error( "Bad player movement angle" );
ADDRGP4 $975
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 1720
;1720:		}
LABELV $972
line 1721
;1721:	}
LABELV $971
line 1722
;1722:	legsAngles[YAW] = headAngles[YAW] + movementOffsets[ dir ];
ADDRLP4 12+4
ADDRLP4 24+4
INDIRF4
ADDRLP4 52
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $960
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1723
;1723:	torsoAngles[YAW] = headAngles[YAW] + 0.25 * movementOffsets[ dir ];
ADDRLP4 0+4
ADDRLP4 24+4
INDIRF4
CNSTF4 1048576000
ADDRLP4 52
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $960
ADDP4
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 1726
;1724:
;1725:	// torso
;1726:	CG_SwingAngles( torsoAngles[YAW], 25, 90, cg_swingSpeed.value, &cent->pe.torso.yawAngle, &cent->pe.torso.yawing );
ADDRLP4 0+4
INDIRF4
ARGF4
CNSTF4 1103626240
ARGF4
CNSTF4 1119092736
ARGF4
ADDRGP4 cg_swingSpeed+8
INDIRF4
ARGF4
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 520
ADDP4
ARGP4
ADDRLP4 88
INDIRP4
CNSTI4 524
ADDP4
ARGP4
ADDRGP4 CG_SwingAngles
CALLV
pop
line 1727
;1727:	CG_SwingAngles( legsAngles[YAW], 40, 90, cg_swingSpeed.value, &cent->pe.legs.yawAngle, &cent->pe.legs.yawing );
ADDRLP4 12+4
INDIRF4
ARGF4
CNSTF4 1109393408
ARGF4
CNSTF4 1119092736
ARGF4
ADDRGP4 cg_swingSpeed+8
INDIRF4
ARGF4
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 472
ADDP4
ARGP4
ADDRLP4 92
INDIRP4
CNSTI4 476
ADDP4
ARGP4
ADDRGP4 CG_SwingAngles
CALLV
pop
line 1729
;1728:
;1729:	torsoAngles[YAW] = cent->pe.torso.yawAngle;
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRF4
ASGNF4
line 1730
;1730:	legsAngles[YAW] = cent->pe.legs.yawAngle;
ADDRLP4 12+4
ADDRFP4 0
INDIRP4
CNSTI4 472
ADDP4
INDIRF4
ASGNF4
line 1736
;1731:
;1732:
;1733:	// --------- pitch -------------
;1734:
;1735:	// only show a fraction of the pitch angle in the torso
;1736:	if ( headAngles[PITCH] > 180 ) {
ADDRLP4 24
INDIRF4
CNSTF4 1127481344
LEF4 $986
line 1737
;1737:		dest = (-360 + headAngles[PITCH]) * 0.75f;
ADDRLP4 60
CNSTF4 1061158912
ADDRLP4 24
INDIRF4
CNSTF4 3283353600
ADDF4
MULF4
ASGNF4
line 1738
;1738:	} else {
ADDRGP4 $987
JUMPV
LABELV $986
line 1739
;1739:		dest = headAngles[PITCH] * 0.75f;
ADDRLP4 60
CNSTF4 1061158912
ADDRLP4 24
INDIRF4
MULF4
ASGNF4
line 1740
;1740:	}
LABELV $987
line 1741
;1741:	CG_SwingAngles( dest, 15, 30, 0.1f, &cent->pe.torso.pitchAngle, &cent->pe.torso.pitching );
ADDRLP4 60
INDIRF4
ARGF4
CNSTF4 1097859072
ARGF4
CNSTF4 1106247680
ARGF4
CNSTF4 1036831949
ARGF4
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 528
ADDP4
ARGP4
ADDRLP4 96
INDIRP4
CNSTI4 532
ADDP4
ARGP4
ADDRGP4 CG_SwingAngles
CALLV
pop
line 1742
;1742:	torsoAngles[PITCH] = cent->pe.torso.pitchAngle;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ASGNF4
line 1745
;1743:
;1744:	//
;1745:	clientNum = cent->currentState.clientNum;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 1746
;1746:	if ( clientNum >= 0 && clientNum < MAX_CLIENTS ) {
ADDRLP4 36
INDIRI4
CNSTI4 0
LTI4 $988
ADDRLP4 36
INDIRI4
CNSTI4 64
GEI4 $988
line 1747
;1747:		ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 64
CNSTI4 1776
ADDRLP4 36
INDIRI4
MULI4
ADDRGP4 cgs+40960
ADDP4
ASGNP4
line 1748
;1748:		if ( ci->fixedtorso ) {
ADDRLP4 64
INDIRP4
CNSTI4 552
ADDP4
INDIRI4
CNSTI4 0
EQI4 $991
line 1749
;1749:			torsoAngles[PITCH] = 0.0f;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1750
;1750:		}
LABELV $991
line 1751
;1751:	}
LABELV $988
line 1757
;1752:
;1753:	// --------- roll -------------
;1754:
;1755:
;1756:	// lean towards the direction of travel
;1757:	VectorCopy( cent->currentState.pos.trDelta, velocity );
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 1758
;1758:	speed = VectorNormalize( velocity );
ADDRLP4 40
ARGP4
ADDRLP4 104
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 56
ADDRLP4 104
INDIRF4
ASGNF4
line 1759
;1759:	if ( speed ) {
ADDRLP4 56
INDIRF4
CNSTF4 0
EQF4 $993
line 1763
;1760:		vec3_t	axis[3];
;1761:		float	side;
;1762:
;1763:		speed *= 0.05f;
ADDRLP4 56
CNSTF4 1028443341
ADDRLP4 56
INDIRF4
MULF4
ASGNF4
line 1765
;1764:
;1765:		AnglesToAxis( legsAngles, axis );
ADDRLP4 12
ARGP4
ADDRLP4 108
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1766
;1766:		side = speed * DotProduct( velocity, axis[1] );
ADDRLP4 144
ADDRLP4 56
INDIRF4
ADDRLP4 40
INDIRF4
ADDRLP4 108+12
INDIRF4
MULF4
ADDRLP4 40+4
INDIRF4
ADDRLP4 108+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 40+8
INDIRF4
ADDRLP4 108+12+8
INDIRF4
MULF4
ADDF4
MULF4
ASGNF4
line 1767
;1767:		legsAngles[ROLL] -= side;
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
ADDRLP4 144
INDIRF4
SUBF4
ASGNF4
line 1769
;1768:
;1769:		side = speed * DotProduct( velocity, axis[0] );
ADDRLP4 144
ADDRLP4 56
INDIRF4
ADDRLP4 40
INDIRF4
ADDRLP4 108
INDIRF4
MULF4
ADDRLP4 40+4
INDIRF4
ADDRLP4 108+4
INDIRF4
MULF4
ADDF4
ADDRLP4 40+8
INDIRF4
ADDRLP4 108+8
INDIRF4
MULF4
ADDF4
MULF4
ASGNF4
line 1770
;1770:		legsAngles[PITCH] += side;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 144
INDIRF4
ADDF4
ASGNF4
line 1771
;1771:	}
LABELV $993
line 1774
;1772:
;1773:	//
;1774:	clientNum = cent->currentState.clientNum;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 1775
;1775:	if ( clientNum >= 0 && clientNum < MAX_CLIENTS ) {
ADDRLP4 36
INDIRI4
CNSTI4 0
LTI4 $1007
ADDRLP4 36
INDIRI4
CNSTI4 64
GEI4 $1007
line 1776
;1776:		ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 64
CNSTI4 1776
ADDRLP4 36
INDIRI4
MULI4
ADDRGP4 cgs+40960
ADDP4
ASGNP4
line 1777
;1777:		if ( ci->fixedlegs ) {
ADDRLP4 64
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1010
line 1778
;1778:			legsAngles[YAW] = torsoAngles[YAW];
ADDRLP4 12+4
ADDRLP4 0+4
INDIRF4
ASGNF4
line 1779
;1779:			legsAngles[PITCH] = 0.0f;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 1780
;1780:			legsAngles[ROLL] = 0.0f;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 1781
;1781:		}
LABELV $1010
line 1782
;1782:	}
LABELV $1007
line 1785
;1783:
;1784:	// pain twitch
;1785:	CG_AddPainTwitch( cent, torsoAngles );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_AddPainTwitch
CALLV
pop
line 1788
;1786:
;1787:	// pull the angles back out of the hierarchial chain
;1788:	AnglesSubtract( headAngles, torsoAngles, headAngles );
ADDRLP4 24
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 24
ARGP4
ADDRGP4 AnglesSubtract
CALLV
pop
line 1789
;1789:	AnglesSubtract( torsoAngles, legsAngles, torsoAngles );
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 AnglesSubtract
CALLV
pop
line 1790
;1790:	AnglesToAxis( legsAngles, legs );
ADDRLP4 12
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1791
;1791:	AnglesToAxis( torsoAngles, torso );
ADDRLP4 0
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1792
;1792:	AnglesToAxis( headAngles, head );
ADDRLP4 24
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1793
;1793:}
LABELV $959
endproc CG_PlayerAngles 148 24
proc CG_HasteTrail 40 48
line 1803
;1794:
;1795:
;1796://==========================================================================
;1797:
;1798:/*
;1799:===============
;1800:CG_HasteTrail
;1801:===============
;1802:*/
;1803:static void CG_HasteTrail( centity_t *cent ) {
line 1808
;1804:	localEntity_t	*smoke;
;1805:	vec3_t			origin;
;1806:	int				anim;
;1807:
;1808:	if ( cent->trailTime > cg.time ) {
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $1016
line 1809
;1809:		return;
ADDRGP4 $1015
JUMPV
LABELV $1016
line 1811
;1810:	}
;1811:	anim = cent->pe.legs.animationNumber & ~ANIM_TOGGLEBIT;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 1812
;1812:	if ( anim != LEGS_RUN && anim != LEGS_BACK ) {
ADDRLP4 12
INDIRI4
CNSTI4 15
EQI4 $1019
ADDRLP4 12
INDIRI4
CNSTI4 16
EQI4 $1019
line 1813
;1813:		return;
ADDRGP4 $1015
JUMPV
LABELV $1019
line 1816
;1814:	}
;1815:
;1816:	cent->trailTime += 100;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 1817
;1817:	if ( cent->trailTime < cg.time ) {
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
GEI4 $1021
line 1818
;1818:		cent->trailTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1819
;1819:	}
LABELV $1021
line 1821
;1820:
;1821:	VectorCopy( cent->lerpOrigin, origin );
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRB
ASGNB 12
line 1822
;1822:	origin[2] -= 16;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1824
;1823:
;1824:	smoke = CG_SmokePuff( origin, vec3_origin, 
ADDRLP4 0
ARGP4
ADDRGP4 vec3_origin
ARGP4
CNSTF4 1090519040
ARGF4
ADDRLP4 28
CNSTF4 1065353216
ASGNF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
CNSTF4 1140457472
ARGF4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRGP4 cgs+156680+484
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 CG_SmokePuff
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 36
INDIRP4
ASGNP4
line 1834
;1825:				  8, 
;1826:				  1, 1, 1, 1,
;1827:				  500, 
;1828:				  cg.time,
;1829:				  0,
;1830:				  0,
;1831:				  cgs.media.hastePuffShader );
;1832:
;1833:	// use the optimized local entity add
;1834:	smoke->leType = LE_SCALE_FADE;
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 7
ASGNI4
line 1835
;1835:}
LABELV $1015
endproc CG_HasteTrail 40 48
proc CG_BreathPuffs 64 48
line 1842
;1836:
;1837:/*
;1838:===============
;1839:CG_BreathPuffs
;1840:===============
;1841:*/
;1842:static void CG_BreathPuffs( centity_t *cent, refEntity_t *head) {
line 1847
;1843:	clientInfo_t *ci;
;1844:	vec3_t up, origin;
;1845:	int contents;
;1846:
;1847:	ci = &cgs.clientinfo[ cent->currentState.number ];
ADDRLP4 24
CNSTI4 1776
ADDRFP4 0
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+40960
ADDP4
ASGNP4
line 1849
;1848:
;1849:	if (g_gamemode.integer < 4) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 4
GEI4 $1031
line 1850
;1850:		return;
ADDRGP4 $1029
JUMPV
LABELV $1031
line 1853
;1851:	}
;1852:
;1853:	if (!cg_enableBreath.integer) {
ADDRGP4 cg_enableBreath+12
INDIRI4
CNSTI4 0
NEI4 $1034
line 1854
;1854:		return;
ADDRGP4 $1029
JUMPV
LABELV $1034
line 1857
;1855:	}
;1856:
;1857:	if ( ci->breathPuffTime > cg.time ) {
ADDRLP4 24
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $1037
line 1858
;1858:		return;
ADDRGP4 $1029
JUMPV
LABELV $1037
line 1861
;1859:	}
;1860:
;1861:	if ( cent->currentState.number == cg.snap->ps.clientNum && !cg.renderingThirdPerson) {
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $1040
ADDRGP4 cg+107628
INDIRI4
CNSTI4 0
NEI4 $1040
line 1862
;1862:		return;
ADDRGP4 $1029
JUMPV
LABELV $1040
line 1864
;1863:	}
;1864:	if ( cent->currentState.eFlags & EF_DEAD ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1044
line 1865
;1865:		return;
ADDRGP4 $1029
JUMPV
LABELV $1044
line 1872
;1866:	}
;1867://freeze
;1868://	if ( !cent->currentState.weapon ) {
;1869://		return;
;1870://	}
;1871://freeze
;1872:	contents = trap_CM_PointContents( head->origin, 0 );
ADDRFP4 4
INDIRP4
CNSTI4 68
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 32
ADDRGP4 trap_CM_PointContents
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 32
INDIRI4
ASGNI4
line 1873
;1873:	if ( contents & ( CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) ) {
ADDRLP4 28
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $1046
line 1874
;1874:		return;
ADDRGP4 $1029
JUMPV
LABELV $1046
line 1877
;1875:	}
;1876:
;1877:	ci->breathPuffTime = cg.time + 2000;
ADDRLP4 24
INDIRP4
CNSTI4 184
ADDP4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 1879
;1878:
;1879:	VectorSet( up, 0, 0, 8 );
ADDRLP4 36
CNSTF4 0
ASGNF4
ADDRLP4 12
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 12+8
CNSTF4 1090519040
ASGNF4
line 1880
;1880:	VectorMA(head->origin, 8, head->axis[0], origin);
ADDRLP4 40
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 44
CNSTF4 1090519040
ASGNF4
ADDRLP4 0
ADDRLP4 40
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ADDRLP4 44
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 40
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ADDRLP4 44
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 48
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 48
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
CNSTF4 1090519040
ADDRLP4 48
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1881
;1881:	VectorMA(origin, -4, head->axis[2], origin);
ADDRLP4 52
CNSTF4 3229614080
ASGNF4
ADDRLP4 56
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 52
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 56
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 3229614080
ADDRFP4 4
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1882
;1882:	CG_SmokePuff( origin, up, 16, 1, 1, 1, 0.66f, 1500, cg.time, cg.time + 400, LEF_PUFF_DONT_SCALE, cgs.media.shotgunSmokePuffShader );
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
CNSTF4 1098907648
ARGF4
ADDRLP4 60
CNSTF4 1065353216
ASGNF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
CNSTF4 1059648963
ARGF4
CNSTF4 1153138688
ARGF4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 400
ADDI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 cgs+156680+340
INDIRI4
ARGI4
ADDRGP4 CG_SmokePuff
CALLP4
pop
line 1884
;1883:	
;1884:}
LABELV $1029
endproc CG_BreathPuffs 64 48
proc CG_TrailItem 188 12
line 1945
;1885:
;1886:
;1887:#ifdef MISSIONPACK
;1888:
;1889:/*
;1890:===============
;1891:CG_DustTrail
;1892:===============
;1893:*/
;1894:static void CG_DustTrail( centity_t *cent ) {
;1895:	int				anim;
;1896:	localEntity_t	*dust;
;1897:	vec3_t end, vel;
;1898:	trace_t tr;
;1899:
;1900:	if (!cg_enableDust.integer)
;1901:		return;
;1902:
;1903:	if ( cent->dustTrailTime > cg.time ) {
;1904:		return;
;1905:	}
;1906:
;1907:	anim = cent->pe.legs.animationNumber & ~ANIM_TOGGLEBIT;
;1908:	if ( anim != LEGS_LANDB && anim != LEGS_LAND ) {
;1909:		return;
;1910:	}
;1911:
;1912:	cent->dustTrailTime += 40;
;1913:	if ( cent->dustTrailTime < cg.time ) {
;1914:		cent->dustTrailTime = cg.time;
;1915:	}
;1916:
;1917:	VectorCopy(cent->currentState.pos.trBase, end);
;1918:	end[2] -= 64;
;1919:	CG_Trace( &tr, cent->currentState.pos.trBase, NULL, NULL, end, cent->currentState.number, MASK_PLAYERSOLID );
;1920:
;1921:	if ( !(tr.surfaceFlags & SURF_DUST) )
;1922:		return;
;1923:
;1924:	VectorCopy( cent->currentState.pos.trBase, end );
;1925:	end[2] -= 16;
;1926:
;1927:	VectorSet(vel, 0, 0, -30);
;1928:	dust = CG_SmokePuff( end, vel,
;1929:				  24,
;1930:				  .8f, .8f, 0.7f, 0.33f,
;1931:				  500,
;1932:				  cg.time,
;1933:				  0,
;1934:				  0,
;1935:				  cgs.media.dustPuffShader );
;1936:}
;1937:
;1938:#endif
;1939:
;1940:/*
;1941:===============
;1942:CG_TrailItem
;1943:===============
;1944:*/
;1945:static void CG_TrailItem( centity_t *cent, qhandle_t hModel ) {
line 1950
;1946:	refEntity_t		ent;
;1947:	vec3_t			angles;
;1948:	vec3_t			axis[3];
;1949:
;1950:	VectorCopy( cent->lerpAngles, angles );
ADDRLP4 140
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 1951
;1951:	angles[PITCH] = 0;
ADDRLP4 140
CNSTF4 0
ASGNF4
line 1952
;1952:	angles[ROLL] = 0;
ADDRLP4 140+8
CNSTF4 0
ASGNF4
line 1953
;1953:	AnglesToAxis( angles, axis );
ADDRLP4 140
ARGP4
ADDRLP4 152
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1955
;1954:
;1955:	memset( &ent, 0, sizeof( ent ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1956
;1956:	VectorMA( cent->lerpOrigin, -16, axis[0], ent.origin );
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRF4
CNSTF4 3246391296
ADDRLP4 152
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+4
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
INDIRF4
CNSTF4 3246391296
ADDRLP4 152+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+8
ADDRFP4 0
INDIRP4
CNSTI4 712
ADDP4
INDIRF4
CNSTF4 3246391296
ADDRLP4 152+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1957
;1957:	ent.origin[2] += 16;
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 1958
;1958:	angles[YAW] += 90;
ADDRLP4 140+4
ADDRLP4 140+4
INDIRF4
CNSTF4 1119092736
ADDF4
ASGNF4
line 1959
;1959:	AnglesToAxis( angles, ent.axis );
ADDRLP4 140
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1961
;1960:
;1961:	ent.hModel = hModel;
ADDRLP4 0+8
ADDRFP4 4
INDIRI4
ASGNI4
line 1962
;1962:	trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1963
;1963:}
LABELV $1061
endproc CG_TrailItem 188 12
proc CG_PlayerFlag 356 24
line 1971
;1964:
;1965:
;1966:/*
;1967:===============
;1968:CG_PlayerFlag
;1969:===============
;1970:*/
;1971:static void CG_PlayerFlag( centity_t *cent, qhandle_t hSkin, refEntity_t *torso ) {
line 1980
;1972:	clientInfo_t	*ci;
;1973:	refEntity_t	pole;
;1974:	refEntity_t	flag;
;1975:	vec3_t		angles, dir;
;1976:	int			legsAnim, flagAnim, updateangles;
;1977:	float		angle, d;
;1978:
;1979:	// show the flag pole model
;1980:	memset( &pole, 0, sizeof(pole) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1981
;1981:	pole.hModel = cgs.media.flagPoleModel;
ADDRLP4 0+8
ADDRGP4 cgs+156680+132
INDIRI4
ASGNI4
line 1982
;1982:	VectorCopy( torso->lightingOrigin, pole.lightingOrigin );
ADDRLP4 0+12
ADDRFP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRB
ASGNB 12
line 1983
;1983:	pole.shadowPlane = torso->shadowPlane;
ADDRLP4 0+24
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1984
;1984:	pole.renderfx = torso->renderfx;
ADDRLP4 0+4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1985
;1985:	CG_PositionEntityOnTag( &pole, torso, torso->hModel, "tag_flag" );
ADDRLP4 0
ARGP4
ADDRLP4 328
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 328
INDIRP4
ARGP4
ADDRLP4 328
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $486
ARGP4
ADDRGP4 CG_PositionEntityOnTag
CALLV
pop
line 1986
;1986:	trap_R_AddRefEntityToScene( &pole );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1989
;1987:
;1988:	// show the flag model
;1989:	memset( &flag, 0, sizeof(flag) );
ADDRLP4 140
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1990
;1990:	flag.hModel = cgs.media.flagFlapModel;
ADDRLP4 140+8
ADDRGP4 cgs+156680+136
INDIRI4
ASGNI4
line 1991
;1991:	flag.customSkin = hSkin;
ADDRLP4 140+108
ADDRFP4 4
INDIRI4
ASGNI4
line 1992
;1992:	VectorCopy( torso->lightingOrigin, flag.lightingOrigin );
ADDRLP4 140+12
ADDRFP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRB
ASGNB 12
line 1993
;1993:	flag.shadowPlane = torso->shadowPlane;
ADDRLP4 140+24
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1994
;1994:	flag.renderfx = torso->renderfx;
ADDRLP4 140+4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1996
;1995:
;1996:	VectorClear(angles);
ADDRLP4 332
CNSTF4 0
ASGNF4
ADDRLP4 280+8
ADDRLP4 332
INDIRF4
ASGNF4
ADDRLP4 280+4
ADDRLP4 332
INDIRF4
ASGNF4
ADDRLP4 280
ADDRLP4 332
INDIRF4
ASGNF4
line 1998
;1997:
;1998:	updateangles = qfalse;
ADDRLP4 312
CNSTI4 0
ASGNI4
line 1999
;1999:	legsAnim = cent->currentState.legsAnim & ~ANIM_TOGGLEBIT;
ADDRLP4 304
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 2000
;2000:	if( legsAnim == LEGS_IDLE || legsAnim == LEGS_IDLECR ) {
ADDRLP4 304
INDIRI4
CNSTI4 22
EQI4 $1093
ADDRLP4 304
INDIRI4
CNSTI4 23
NEI4 $1091
LABELV $1093
line 2001
;2001:		flagAnim = FLAG_STAND;
ADDRLP4 320
CNSTI4 35
ASGNI4
line 2002
;2002:	} else if ( legsAnim == LEGS_WALK || legsAnim == LEGS_WALKCR ) {
ADDRGP4 $1092
JUMPV
LABELV $1091
ADDRLP4 304
INDIRI4
CNSTI4 14
EQI4 $1096
ADDRLP4 304
INDIRI4
CNSTI4 13
NEI4 $1094
LABELV $1096
line 2003
;2003:		flagAnim = FLAG_STAND;
ADDRLP4 320
CNSTI4 35
ASGNI4
line 2004
;2004:		updateangles = qtrue;
ADDRLP4 312
CNSTI4 1
ASGNI4
line 2005
;2005:	} else {
ADDRGP4 $1095
JUMPV
LABELV $1094
line 2006
;2006:		flagAnim = FLAG_RUN;
ADDRLP4 320
CNSTI4 34
ASGNI4
line 2007
;2007:		updateangles = qtrue;
ADDRLP4 312
CNSTI4 1
ASGNI4
line 2008
;2008:	}
LABELV $1095
LABELV $1092
line 2010
;2009:
;2010:	if ( updateangles ) {
ADDRLP4 312
INDIRI4
CNSTI4 0
EQI4 $1097
line 2012
;2011:
;2012:		VectorCopy( cent->currentState.pos.trDelta, dir );
ADDRLP4 292
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 2014
;2013:		// add gravity
;2014:		dir[2] += 100;
ADDRLP4 292+8
ADDRLP4 292+8
INDIRF4
CNSTF4 1120403456
ADDF4
ASGNF4
line 2015
;2015:		VectorNormalize( dir );
ADDRLP4 292
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 2016
;2016:		d = DotProduct(pole.axis[2], dir);
ADDRLP4 308
ADDRLP4 0+28+24
INDIRF4
ADDRLP4 292
INDIRF4
MULF4
ADDRLP4 0+28+24+4
INDIRF4
ADDRLP4 292+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+28+24+8
INDIRF4
ADDRLP4 292+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2018
;2017:		// if there is anough movement orthogonal to the flag pole
;2018:		if (fabs(d) < 0.9) {
ADDRLP4 308
INDIRF4
ARGF4
ADDRLP4 344
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 344
INDIRF4
CNSTF4 1063675494
GEF4 $1110
line 2020
;2019:			//
;2020:			d = DotProduct(pole.axis[0], dir);
ADDRLP4 308
ADDRLP4 0+28
INDIRF4
ADDRLP4 292
INDIRF4
MULF4
ADDRLP4 0+28+4
INDIRF4
ADDRLP4 292+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+28+8
INDIRF4
ADDRLP4 292+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2021
;2021:			if (d > 1.0f) {
ADDRLP4 308
INDIRF4
CNSTF4 1065353216
LEF4 $1119
line 2022
;2022:				d = 1.0f;
ADDRLP4 308
CNSTF4 1065353216
ASGNF4
line 2023
;2023:			}
ADDRGP4 $1120
JUMPV
LABELV $1119
line 2024
;2024:			else if (d < -1.0f) {
ADDRLP4 308
INDIRF4
CNSTF4 3212836864
GEF4 $1121
line 2025
;2025:				d = -1.0f;
ADDRLP4 308
CNSTF4 3212836864
ASGNF4
line 2026
;2026:			}
LABELV $1121
LABELV $1120
line 2027
;2027:			angle = acos(d);
ADDRLP4 308
INDIRF4
ARGF4
ADDRLP4 348
ADDRGP4 acos
CALLF4
ASGNF4
ADDRLP4 324
ADDRLP4 348
INDIRF4
ASGNF4
line 2029
;2028:
;2029:			d = DotProduct(pole.axis[1], dir);
ADDRLP4 308
ADDRLP4 0+28+12
INDIRF4
ADDRLP4 292
INDIRF4
MULF4
ADDRLP4 0+28+12+4
INDIRF4
ADDRLP4 292+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+28+12+8
INDIRF4
ADDRLP4 292+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2030
;2030:			if (d < 0) {
ADDRLP4 308
INDIRF4
CNSTF4 0
GEF4 $1133
line 2031
;2031:				angles[YAW] = 360 - angle * 180 / M_PI;
ADDRLP4 280+4
CNSTF4 1135869952
CNSTF4 1127481344
ADDRLP4 324
INDIRF4
MULF4
CNSTF4 1078530011
DIVF4
SUBF4
ASGNF4
line 2032
;2032:			}
ADDRGP4 $1134
JUMPV
LABELV $1133
line 2033
;2033:			else {
line 2034
;2034:				angles[YAW] = angle * 180 / M_PI;
ADDRLP4 280+4
CNSTF4 1127481344
ADDRLP4 324
INDIRF4
MULF4
CNSTF4 1078530011
DIVF4
ASGNF4
line 2035
;2035:			}
LABELV $1134
line 2036
;2036:			if (angles[YAW] < 0)
ADDRLP4 280+4
INDIRF4
CNSTF4 0
GEF4 $1137
line 2037
;2037:				angles[YAW] += 360;
ADDRLP4 280+4
ADDRLP4 280+4
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
LABELV $1137
line 2038
;2038:			if (angles[YAW] > 360)
ADDRLP4 280+4
INDIRF4
CNSTF4 1135869952
LEF4 $1141
line 2039
;2039:				angles[YAW] -= 360;
ADDRLP4 280+4
ADDRLP4 280+4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
LABELV $1141
line 2044
;2040:
;2041:			//vectoangles( cent->currentState.pos.trDelta, tmpangles );
;2042:			//angles[YAW] = tmpangles[YAW] + 45 - cent->pe.torso.yawAngle;
;2043:			// change the yaw angle
;2044:			CG_SwingAngles( angles[YAW], 25, 90, 0.15f, &cent->pe.flag.yawAngle, &cent->pe.flag.yawing );
ADDRLP4 280+4
INDIRF4
ARGF4
CNSTF4 1103626240
ARGF4
CNSTF4 1119092736
ARGF4
CNSTF4 1041865114
ARGF4
ADDRLP4 352
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 352
INDIRP4
CNSTI4 568
ADDP4
ARGP4
ADDRLP4 352
INDIRP4
CNSTI4 572
ADDP4
ARGP4
ADDRGP4 CG_SwingAngles
CALLV
pop
line 2045
;2045:		}
LABELV $1110
line 2065
;2046:
;2047:		/*
;2048:		d = DotProduct(pole.axis[2], dir);
;2049:		angle = Q_acos(d);
;2050:
;2051:		d = DotProduct(pole.axis[1], dir);
;2052:		if (d < 0) {
;2053:			angle = 360 - angle * 180 / M_PI;
;2054:		}
;2055:		else {
;2056:			angle = angle * 180 / M_PI;
;2057:		}
;2058:		if (angle > 340 && angle < 20) {
;2059:			flagAnim = FLAG_RUNUP;
;2060:		}
;2061:		if (angle > 160 && angle < 200) {
;2062:			flagAnim = FLAG_RUNDOWN;
;2063:		}
;2064:		*/
;2065:	}
LABELV $1097
line 2068
;2066:
;2067:	// set the yaw angle
;2068:	angles[YAW] = cent->pe.flag.yawAngle;
ADDRLP4 280+4
ADDRFP4 0
INDIRP4
CNSTI4 568
ADDP4
INDIRF4
ASGNF4
line 2070
;2069:	// lerp the flag animation frames
;2070:	ci = &cgs.clientinfo[ cent->currentState.clientNum ];
ADDRLP4 316
CNSTI4 1776
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+40960
ADDP4
ASGNP4
line 2071
;2071:	CG_RunLerpFrame( ci, &cent->pe.flag, flagAnim, 1 );
ADDRLP4 316
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
ARGP4
ADDRLP4 320
INDIRI4
ARGI4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_RunLerpFrame
CALLV
pop
line 2072
;2072:	flag.oldframe = cent->pe.flag.oldFrame;
ADDRLP4 140+96
ADDRFP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
ASGNI4
line 2073
;2073:	flag.frame = cent->pe.flag.frame;
ADDRLP4 140+80
ADDRFP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
ASGNI4
line 2074
;2074:	flag.backlerp = cent->pe.flag.backlerp;
ADDRLP4 140+100
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
INDIRF4
ASGNF4
line 2076
;2075:
;2076:	AnglesToAxis( angles, flag.axis );
ADDRLP4 280
ARGP4
ADDRLP4 140+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 2077
;2077:	CG_PositionRotatedEntityOnTag( &flag, &pole, pole.hModel, "tag_flag" );
ADDRLP4 140
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 $486
ARGP4
ADDRGP4 CG_PositionRotatedEntityOnTag
CALLV
pop
line 2079
;2078:
;2079:	trap_R_AddRefEntityToScene( &flag );
ADDRLP4 140
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2080
;2080:}
LABELV $1075
endproc CG_PlayerFlag 356 24
proc CG_PlayerPowerups 16 20
line 2156
;2081:
;2082:
;2083:#ifdef MISSIONPACK // bk001204
;2084:/*
;2085:===============
;2086:CG_PlayerTokens
;2087:===============
;2088:*/
;2089:static void CG_PlayerTokens( centity_t *cent, int renderfx ) {
;2090:	int			tokens, i, j;
;2091:	float		angle;
;2092:	refEntity_t	ent;
;2093:	vec3_t		dir, origin;
;2094:	skulltrail_t *trail;
;2095:	trail = &cg.skulltrails[cent->currentState.number];
;2096:	tokens = cent->currentState.generic1;
;2097:	if ( !tokens ) {
;2098:		trail->numpositions = 0;
;2099:		return;
;2100:	}
;2101:
;2102:	if ( tokens > MAX_SKULLTRAIL ) {
;2103:		tokens = MAX_SKULLTRAIL;
;2104:	}
;2105:
;2106:	// add skulls if there are more than last time
;2107:	for (i = 0; i < tokens - trail->numpositions; i++) {
;2108:		for (j = trail->numpositions; j > 0; j--) {
;2109:			VectorCopy(trail->positions[j-1], trail->positions[j]);
;2110:		}
;2111:		VectorCopy(cent->lerpOrigin, trail->positions[0]);
;2112:	}
;2113:	trail->numpositions = tokens;
;2114:
;2115:	// move all the skulls along the trail
;2116:	VectorCopy(cent->lerpOrigin, origin);
;2117:	for (i = 0; i < trail->numpositions; i++) {
;2118:		VectorSubtract(trail->positions[i], origin, dir);
;2119:		if (VectorNormalize(dir) > 30) {
;2120:			VectorMA(origin, 30, dir, trail->positions[i]);
;2121:		}
;2122:		VectorCopy(trail->positions[i], origin);
;2123:	}
;2124:
;2125:	memset( &ent, 0, sizeof( ent ) );
;2126:	if( cgs.clientinfo[ cent->currentState.clientNum ].team == TEAM_BLUE ) {
;2127:		ent.hModel = cgs.media.redCubeModel;
;2128:	} else {
;2129:		ent.hModel = cgs.media.blueCubeModel;
;2130:	}
;2131:	ent.renderfx = renderfx;
;2132:
;2133:	VectorCopy(cent->lerpOrigin, origin);
;2134:	for (i = 0; i < trail->numpositions; i++) {
;2135:		VectorSubtract(origin, trail->positions[i], ent.axis[0]);
;2136:		ent.axis[0][2] = 0;
;2137:		VectorNormalize(ent.axis[0]);
;2138:		VectorSet(ent.axis[2], 0, 0, 1);
;2139:		CrossProduct(ent.axis[0], ent.axis[2], ent.axis[1]);
;2140:
;2141:		VectorCopy(trail->positions[i], ent.origin);
;2142:		angle = (((cg.time + 500 * MAX_SKULLTRAIL - 500 * i) / 16) & 255) * (M_PI * 2) / 255;
;2143:		ent.origin[2] += sin(angle) * 10;
;2144:		trap_R_AddRefEntityToScene( &ent );
;2145:		VectorCopy(trail->positions[i], origin);
;2146:	}
;2147:}
;2148:#endif
;2149:
;2150:
;2151:/*
;2152:===============
;2153:CG_PlayerPowerups
;2154:===============
;2155:*/
;2156:static void CG_PlayerPowerups( centity_t *cent, refEntity_t *torso ) {
line 2160
;2157:	int		powerups;
;2158:	clientInfo_t	*ci;
;2159:
;2160:	powerups = cent->currentState.powerups;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ASGNI4
line 2161
;2161:	if ( !powerups ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1154
line 2162
;2162:		return;
ADDRGP4 $1153
JUMPV
LABELV $1154
line 2166
;2163:	}
;2164:
;2165:	// quad gives a dlight
;2166:	if ( powerups & ( 1 << PW_QUAD ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1156
line 2167
;2167:		trap_R_AddLightToScene( cent->lerpOrigin, 200 + (rand()&31), 0.2f, 0.2f, 1 );
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 200
ADDI4
CVIF4 4
ARGF4
ADDRLP4 12
CNSTF4 1045220557
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 2168
;2168:	}
LABELV $1156
line 2171
;2169:
;2170:	// flight plays a looped sound
;2171:	if ( powerups & ( 1 << PW_FLIGHT ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $1158
line 2172
;2172:		trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin, cgs.media.flightSound );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 704
ADDP4
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRGP4 cgs+156680+944
INDIRI4
ARGI4
ADDRGP4 trap_S_AddLoopingSound
CALLV
pop
line 2173
;2173:	}
LABELV $1158
line 2175
;2174:
;2175:	ci = &cgs.clientinfo[ cent->currentState.clientNum ];
ADDRLP4 4
CNSTI4 1776
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+40960
ADDP4
ASGNP4
line 2177
;2176:	// redflag
;2177:	if ( powerups & ( 1 << PW_REDFLAG ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $1163
line 2178
;2178:		if (ci->newAnims) {
ADDRLP4 4
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1165
line 2179
;2179:			CG_PlayerFlag( cent, cgs.media.redFlagFlapSkin, torso );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+156680+140
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_PlayerFlag
CALLV
pop
line 2180
;2180:		}
ADDRGP4 $1166
JUMPV
LABELV $1165
line 2181
;2181:		else {
line 2182
;2182:			CG_TrailItem( cent, cgs.media.redFlagModel );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+156680+56
INDIRI4
ARGI4
ADDRGP4 CG_TrailItem
CALLV
pop
line 2183
;2183:		}
LABELV $1166
line 2184
;2184:		trap_R_AddLightToScene( cent->lerpOrigin, 200 + (rand()&31), 1.0, 0.2f, 0.2f );
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 200
ADDI4
CVIF4 4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 12
CNSTF4 1045220557
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 2185
;2185:	}
LABELV $1163
line 2188
;2186:
;2187:	// blueflag
;2188:	if ( powerups & ( 1 << PW_BLUEFLAG ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $1171
line 2189
;2189:		if (ci->newAnims){
ADDRLP4 4
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1173
line 2190
;2190:			CG_PlayerFlag( cent, cgs.media.blueFlagFlapSkin, torso );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+156680+144
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_PlayerFlag
CALLV
pop
line 2191
;2191:		}
ADDRGP4 $1174
JUMPV
LABELV $1173
line 2192
;2192:		else {
line 2193
;2193:			CG_TrailItem( cent, cgs.media.blueFlagModel );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+156680+60
INDIRI4
ARGI4
ADDRGP4 CG_TrailItem
CALLV
pop
line 2194
;2194:		}
LABELV $1174
line 2195
;2195:		trap_R_AddLightToScene( cent->lerpOrigin, 200 + (rand()&31), 0.2f, 0.2f, 1.0 );
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 200
ADDI4
CVIF4 4
ARGF4
ADDRLP4 12
CNSTF4 1045220557
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 2196
;2196:	}
LABELV $1171
line 2199
;2197:
;2198:	// neutralflag
;2199:	if ( powerups & ( 1 << PW_NEUTRALFLAG ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $1179
line 2200
;2200:		if (ci->newAnims) {
ADDRLP4 4
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1181
line 2201
;2201:			CG_PlayerFlag( cent, cgs.media.neutralFlagFlapSkin, torso );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+156680+148
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_PlayerFlag
CALLV
pop
line 2202
;2202:		}
ADDRGP4 $1182
JUMPV
LABELV $1181
line 2203
;2203:		else {
line 2204
;2204:			CG_TrailItem( cent, cgs.media.neutralFlagModel );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+156680+64
INDIRI4
ARGI4
ADDRGP4 CG_TrailItem
CALLV
pop
line 2205
;2205:		}
LABELV $1182
line 2206
;2206:		trap_R_AddLightToScene( cent->lerpOrigin, 200 + (rand()&31), 1.0, 1.0, 1.0 );
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 200
ADDI4
CVIF4 4
ARGF4
ADDRLP4 12
CNSTF4 1065353216
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 2207
;2207:	}
LABELV $1179
line 2210
;2208:
;2209:	// haste leaves smoke trails
;2210:	if ( powerups & ( 1 << PW_HASTE ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $1187
line 2211
;2211:		CG_HasteTrail( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_HasteTrail
CALLV
pop
line 2212
;2212:	}
LABELV $1187
line 2213
;2213:}
LABELV $1153
endproc CG_PlayerPowerups 16 20
proc CG_PlayerFloatSprite 144 12
line 2223
;2214:
;2215:
;2216:/*
;2217:===============
;2218:CG_PlayerFloatSprite
;2219:
;2220:Float a sprite over the player's head
;2221:===============
;2222:*/
;2223:static void CG_PlayerFloatSprite( centity_t *cent, qhandle_t shader ) {
line 2227
;2224:	int				rf;
;2225:	refEntity_t		ent;
;2226:
;2227:	if ( cent->currentState.number == cg.snap->ps.clientNum && !cg.renderingThirdPerson ) {
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $1190
ADDRGP4 cg+107628
INDIRI4
CNSTI4 0
NEI4 $1190
line 2228
;2228:		rf = RF_THIRD_PERSON;		// only show in mirrors
ADDRLP4 140
CNSTI4 2
ASGNI4
line 2229
;2229:	} else {
ADDRGP4 $1191
JUMPV
LABELV $1190
line 2230
;2230:		rf = 0;
ADDRLP4 140
CNSTI4 0
ASGNI4
line 2231
;2231:	}
LABELV $1191
line 2233
;2232:
;2233:	memset( &ent, 0, sizeof( ent ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2234
;2234:	VectorCopy( cent->lerpOrigin, ent.origin );
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRB
ASGNB 12
line 2235
;2235:	ent.origin[2] += 48;
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
CNSTF4 1111490560
ADDF4
ASGNF4
line 2236
;2236:	ent.reType = RT_SPRITE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 2237
;2237:	ent.customShader = shader;
ADDRLP4 0+112
ADDRFP4 4
INDIRI4
ASGNI4
line 2238
;2238:	ent.radius = 10;
ADDRLP4 0+132
CNSTF4 1092616192
ASGNF4
line 2239
;2239:	ent.renderfx = rf;
ADDRLP4 0+4
ADDRLP4 140
INDIRI4
ASGNI4
line 2240
;2240:	ent.shaderRGBA[0] = 255;
ADDRLP4 0+116
CNSTU1 255
ASGNU1
line 2241
;2241:	ent.shaderRGBA[1] = 255;
ADDRLP4 0+116+1
CNSTU1 255
ASGNU1
line 2242
;2242:	ent.shaderRGBA[2] = 255;
ADDRLP4 0+116+2
CNSTU1 255
ASGNU1
line 2243
;2243:	ent.shaderRGBA[3] = 255;
ADDRLP4 0+116+3
CNSTU1 255
ASGNU1
line 2244
;2244:	trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2245
;2245:}
LABELV $1189
endproc CG_PlayerFloatSprite 144 12
proc CG_PlayerSprites 8 8
line 2256
;2246:
;2247:
;2248:
;2249:/*
;2250:===============
;2251:CG_PlayerSprites
;2252:
;2253:Float sprites over the player's head
;2254:===============
;2255:*/
;2256:static void CG_PlayerSprites( centity_t *cent ) {
line 2259
;2257:	int		team;
;2258:
;2259:	if ( cent->currentState.eFlags & EF_CONNECTION ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $1208
line 2260
;2260:		CG_PlayerFloatSprite( cent, cgs.media.connectionShader );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+156680+260
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2261
;2261:		return;
ADDRGP4 $1207
JUMPV
LABELV $1208
line 2264
;2262:	}
;2263:
;2264:	if ( cent->currentState.eFlags & EF_TALK ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $1212
line 2265
;2265:		CG_PlayerFloatSprite( cent, cgs.media.balloonShader );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+156680+256
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2266
;2266:		return;
ADDRGP4 $1207
JUMPV
LABELV $1212
line 2269
;2267:	}
;2268:
;2269:	if ( cent->currentState.eFlags & EF_AWARD_IMPRESSIVE && cg_drawRewards.integer != -1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $1216
ADDRGP4 cg_drawRewards+12
INDIRI4
CNSTI4 -1
EQI4 $1216
line 2270
;2270:		CG_PlayerFloatSprite( cent, cgs.media.medalImpressive );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+156680+576
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2271
;2271:		return;
ADDRGP4 $1207
JUMPV
LABELV $1216
line 2274
;2272:	}
;2273:
;2274:	if ( cent->currentState.eFlags & EF_AWARD_EXCELLENT && cg_drawRewards.integer != -1  ) {
ADDRLP4 4
CNSTI4 8
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
BANDI4
CNSTI4 0
EQI4 $1221
ADDRGP4 cg_drawRewards+12
INDIRI4
CNSTI4 -1
EQI4 $1221
line 2275
;2275:		CG_PlayerFloatSprite( cent, cgs.media.medalExcellent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+156680+580
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2276
;2276:		return;
ADDRGP4 $1207
JUMPV
LABELV $1221
line 2279
;2277:	}
;2278:
;2279:	if ( cent->currentState.eFlags & EF_AWARD_GAUNTLET && cg_drawRewards.integer != -1  ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $1226
ADDRGP4 cg_drawRewards+12
INDIRI4
CNSTI4 -1
EQI4 $1226
line 2280
;2280:		CG_PlayerFloatSprite( cent, cgs.media.medalGauntlet );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+156680+584
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2281
;2281:		return;
ADDRGP4 $1207
JUMPV
LABELV $1226
line 2284
;2282:	}
;2283:
;2284:	if ( cent->currentState.eFlags & EF_AWARD_DEFEND && cg_drawRewards.integer != -1  ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 65536
BANDI4
CNSTI4 0
EQI4 $1231
ADDRGP4 cg_drawRewards+12
INDIRI4
CNSTI4 -1
EQI4 $1231
line 2285
;2285:		CG_PlayerFloatSprite( cent, cgs.media.medalDefend );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+156680+588
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2286
;2286:		return;
ADDRGP4 $1207
JUMPV
LABELV $1231
line 2289
;2287:	}
;2288:
;2289:	if ( cent->currentState.eFlags & EF_AWARD_ASSIST && cg_drawRewards.integer != -1  ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 131072
BANDI4
CNSTI4 0
EQI4 $1236
ADDRGP4 cg_drawRewards+12
INDIRI4
CNSTI4 -1
EQI4 $1236
line 2290
;2290:		CG_PlayerFloatSprite( cent, cgs.media.medalAssist );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+156680+592
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2291
;2291:		return;
ADDRGP4 $1207
JUMPV
LABELV $1236
line 2294
;2292:	}
;2293:
;2294:	if ( cent->currentState.eFlags & EF_AWARD_CAP && cg_drawRewards.integer != -1  ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $1241
ADDRGP4 cg_drawRewards+12
INDIRI4
CNSTI4 -1
EQI4 $1241
line 2295
;2295:		CG_PlayerFloatSprite( cent, cgs.media.medalCapture );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+156680+596
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2296
;2296:		return;
ADDRGP4 $1207
JUMPV
LABELV $1241
line 2299
;2297:	}
;2298:
;2299:	team = cgs.clientinfo[ cent->currentState.clientNum ].team;
ADDRLP4 0
CNSTI4 1776
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
ASGNI4
line 2300
;2300:	if ( !(cent->currentState.eFlags & EF_DEAD) && 
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $1248
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $1248
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $1248
line 2302
;2301:		cg.snap->ps.persistant[PERS_TEAM] == team &&
;2302:		cgs.gametype >= GT_TEAM) {
line 2303
;2303:		if (cg_drawFriend.integer /*== 1*/) {
ADDRGP4 cg_drawFriend+12
INDIRI4
CNSTI4 0
EQI4 $1207
line 2304
;2304:			CG_PlayerFloatSprite( cent, cgs.media.friendShader );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cgs+156680+252
INDIRI4
ARGI4
ADDRGP4 CG_PlayerFloatSprite
CALLV
pop
line 2305
;2305:		/*} else if (cg_drawFriend.integer == 2) {
line 2331
;2306:			int		w, x, y;
;2307:			centity_t	*cg_cent;
;2308:			cg_cent = &cg_entities[ cg.clientNum ];
;2309:
;2310:			x = 240;
;2311:			//y = 320;
;2312:			//vec3_t	mins, maxs;
;2313:			//cent->currentState.apos.
;2314:			//trap_R_ModelBounds(cent->);
;2315:			//w = CG_DrawStrlen( cgs.clientinfo[ cent->currentState.clientNum ].name ) * BIGCHAR_WIDTH;
;2316:			//CG_Printf("%s: %i %i %i\n",cgs.clientinfo[ cent->currentState.clientNum ].name, (int)cent->lerpOrigin[0], (int)cent->lerpOrigin[1], (int)cent->lerpOrigin[2]);
;2317:			//cent->currentState.origin[0];
;2318:			//cent->currentState.origin[1];
;2319:			//cent->currentState.origin[2];
;2320:			if ( (int)cent->lerpOrigin[2] == (int)cg_cent->lerpOrigin[2] ) {
;2321:				y = 320 + 64;
;2322:			} else if ( (int)cent->lerpOrigin[2] > (int)cg_cent->lerpOrigin[2] ) {
;2323:				y = 320 + (cent->lerpOrigin[2] - cg_cent->lerpOrigin[2]);
;2324:			} else {
;2325:				y = 320 - ( (int)cg_cent->lerpOrigin[2] - (int)cent->lerpOrigin[2] );
;2326:			}
;2327:			//cgs.clientinfo[ cent->currentState.clientNum ].name
;2328:			CG_DrawStringExt(x - w / 2, y, cgs.clientinfo[ cent->currentState.clientNum ].name, colorWhite, qfalse, qfalse,
;2329:								BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0 );
;2330:		*/} else {
;2331:			return;
LABELV $1253
line 2333
;2332:		}
;2333:	}
LABELV $1248
line 2334
;2334:}
LABELV $1207
endproc CG_PlayerSprites 8 8
lit
align 4
LABELV $1258
byte 4 3245342720
byte 4 3245342720
byte 4 0
align 4
LABELV $1259
byte 4 1097859072
byte 4 1097859072
byte 4 1073741824
code
proc CG_PlayerShadow 104 44
line 2346
;2335:
;2336:/*
;2337:===============
;2338:CG_PlayerShadow
;2339:
;2340:Returns the Z component of the surface being shadowed
;2341:
;2342:  should it return a full plane instead of a Z?
;2343:===============
;2344:*/
;2345:#define	SHADOW_DISTANCE		128
;2346:static qboolean CG_PlayerShadow( centity_t *cent, float *shadowPlane ) {
line 2347
;2347:	vec3_t		end, mins = {-15, -15, 0}, maxs = {15, 15, 2};
ADDRLP4 72
ADDRGP4 $1258
INDIRB
ASGNB 12
ADDRLP4 84
ADDRGP4 $1259
INDIRB
ASGNB 12
line 2351
;2348:	trace_t		trace;
;2349:	float		alpha;
;2350:
;2351:	*shadowPlane = 0;
ADDRFP4 4
INDIRP4
CNSTF4 0
ASGNF4
line 2353
;2352:
;2353:	if ( cg_shadows.integer == 0 ) {
ADDRGP4 cg_shadows+12
INDIRI4
CNSTI4 0
NEI4 $1260
line 2354
;2354:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1257
JUMPV
LABELV $1260
line 2358
;2355:	}
;2356:
;2357:	// no shadows when invisible
;2358:	if ( cent->currentState.powerups & ( 1 << PW_INVIS ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1263
line 2359
;2359:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1257
JUMPV
LABELV $1263
line 2363
;2360:	}
;2361:
;2362:	// send a trace down from the player to the ground
;2363:	VectorCopy( cent->lerpOrigin, end );
ADDRLP4 60
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRB
ASGNB 12
line 2364
;2364:	end[2] -= SHADOW_DISTANCE;
ADDRLP4 60+8
ADDRLP4 60+8
INDIRF4
CNSTF4 1124073472
SUBF4
ASGNF4
line 2366
;2365:
;2366:	trap_CM_BoxTrace( &trace, cent->lerpOrigin, end, mins, maxs, 0, MASK_PLAYERSOLID );
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
ARGP4
ADDRLP4 60
ARGP4
ADDRLP4 72
ARGP4
ADDRLP4 84
ARGP4
CNSTI4 0
ARGI4
CNSTI4 33619969
ARGI4
ADDRGP4 trap_CM_BoxTrace
CALLV
pop
line 2369
;2367:
;2368:	// no shadow if too high
;2369:	if ( trace.fraction == 1.0 || trace.startsolid || trace.allsolid ) {
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
EQF4 $1271
ADDRLP4 96
CNSTI4 0
ASGNI4
ADDRLP4 0+4
INDIRI4
ADDRLP4 96
INDIRI4
NEI4 $1271
ADDRLP4 0
INDIRI4
ADDRLP4 96
INDIRI4
EQI4 $1266
LABELV $1271
line 2370
;2370:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1257
JUMPV
LABELV $1266
line 2373
;2371:	}
;2372:
;2373:	*shadowPlane = trace.endpos[2] + 1;
ADDRFP4 4
INDIRP4
ADDRLP4 0+12+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2375
;2374:
;2375:	if ( cg_shadows.integer != 1 ) {	// no mark for stencil or projection shadows
ADDRGP4 cg_shadows+12
INDIRI4
CNSTI4 1
EQI4 $1274
line 2376
;2376:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1257
JUMPV
LABELV $1274
line 2380
;2377:	}
;2378:
;2379:	// fade the shadow out with height
;2380:	alpha = 1.0 - trace.fraction;
ADDRLP4 56
CNSTF4 1065353216
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 2387
;2381:
;2382:	// bk0101022 - hack / FPE - bogus planes?
;2383:	//assert( DotProduct( trace.plane.normal, trace.plane.normal ) != 0.0f ) 
;2384:
;2385:	// add the mark as a temporary, so it goes directly to the renderer
;2386:	// without taking a spot in the cg_marks array
;2387:	CG_ImpactMark( cgs.media.shadowMarkShader, trace.endpos, trace.plane.normal, 
ADDRGP4 cgs+156680+400
INDIRI4
ARGI4
ADDRLP4 0+12
ARGP4
ADDRLP4 0+24
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 472
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
CNSTI4 0
ARGI4
CNSTF4 1103101952
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 CG_ImpactMark
CALLV
pop
line 2390
;2388:		cent->pe.legs.yawAngle, alpha,alpha,alpha,1, qfalse, 24, qtrue );
;2389:
;2390:	return qtrue;
CNSTI4 1
RETI4
LABELV $1257
endproc CG_PlayerShadow 104 44
proc CG_PlayerSplash 192 28
line 2401
;2391:}
;2392:
;2393:
;2394:/*
;2395:===============
;2396:CG_PlayerSplash
;2397:
;2398:Draw a mark at the water surface
;2399:===============
;2400:*/
;2401:static void CG_PlayerSplash( centity_t *cent ) {
line 2407
;2402:	vec3_t		start, end;
;2403:	trace_t		trace;
;2404:	int			contents;
;2405:	polyVert_t	verts[4];
;2406:
;2407:	if ( !cg_shadows.integer ) {
ADDRGP4 cg_shadows+12
INDIRI4
CNSTI4 0
NEI4 $1283
line 2408
;2408:		return;
ADDRGP4 $1282
JUMPV
LABELV $1283
line 2411
;2409:	}
;2410:
;2411:	VectorCopy( cent->lerpOrigin, end );
ADDRLP4 164
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRB
ASGNB 12
line 2412
;2412:	end[2] -= 24;
ADDRLP4 164+8
ADDRLP4 164+8
INDIRF4
CNSTF4 1103101952
SUBF4
ASGNF4
line 2416
;2413:
;2414:	// if the feet aren't in liquid, don't make a mark
;2415:	// this won't handle moving water brushes, but they wouldn't draw right anyway...
;2416:	contents = trap_CM_PointContents( end, 0 );
ADDRLP4 164
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 180
ADDRGP4 trap_CM_PointContents
CALLI4
ASGNI4
ADDRLP4 176
ADDRLP4 180
INDIRI4
ASGNI4
line 2417
;2417:	if ( !( contents & ( CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) ) ) {
ADDRLP4 176
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
NEI4 $1287
line 2418
;2418:		return;
ADDRGP4 $1282
JUMPV
LABELV $1287
line 2421
;2419:	}
;2420:
;2421:	VectorCopy( cent->lerpOrigin, start );
ADDRLP4 152
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRB
ASGNB 12
line 2422
;2422:	start[2] += 32;
ADDRLP4 152+8
ADDRLP4 152+8
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 2425
;2423:
;2424:	// if the head isn't out of liquid, don't make a mark
;2425:	contents = trap_CM_PointContents( start, 0 );
ADDRLP4 152
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 184
ADDRGP4 trap_CM_PointContents
CALLI4
ASGNI4
ADDRLP4 176
ADDRLP4 184
INDIRI4
ASGNI4
line 2426
;2426:	if ( contents & ( CONTENTS_SOLID | CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) ) {
ADDRLP4 176
INDIRI4
CNSTI4 57
BANDI4
CNSTI4 0
EQI4 $1290
line 2427
;2427:		return;
ADDRGP4 $1282
JUMPV
LABELV $1290
line 2431
;2428:	}
;2429:
;2430:	// trace down to find the surface
;2431:	trap_CM_BoxTrace( &trace, start, end, NULL, NULL, 0, ( CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) );
ADDRLP4 96
ARGP4
ADDRLP4 152
ARGP4
ADDRLP4 164
ARGP4
ADDRLP4 188
CNSTP4 0
ASGNP4
ADDRLP4 188
INDIRP4
ARGP4
ADDRLP4 188
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 trap_CM_BoxTrace
CALLV
pop
line 2433
;2432:
;2433:	if ( trace.fraction == 1.0 ) {
ADDRLP4 96+8
INDIRF4
CNSTF4 1065353216
NEF4 $1292
line 2434
;2434:		return;
ADDRGP4 $1282
JUMPV
LABELV $1292
line 2438
;2435:	}
;2436:
;2437:	// create a mark polygon
;2438:	VectorCopy( trace.endpos, verts[0].xyz );
ADDRLP4 0
ADDRLP4 96+12
INDIRB
ASGNB 12
line 2439
;2439:	verts[0].xyz[0] -= 32;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 2440
;2440:	verts[0].xyz[1] -= 32;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 2441
;2441:	verts[0].st[0] = 0;
ADDRLP4 0+12
CNSTF4 0
ASGNF4
line 2442
;2442:	verts[0].st[1] = 0;
ADDRLP4 0+12+4
CNSTF4 0
ASGNF4
line 2443
;2443:	verts[0].modulate[0] = 255;
ADDRLP4 0+20
CNSTU1 255
ASGNU1
line 2444
;2444:	verts[0].modulate[1] = 255;
ADDRLP4 0+20+1
CNSTU1 255
ASGNU1
line 2445
;2445:	verts[0].modulate[2] = 255;
ADDRLP4 0+20+2
CNSTU1 255
ASGNU1
line 2446
;2446:	verts[0].modulate[3] = 255;
ADDRLP4 0+20+3
CNSTU1 255
ASGNU1
line 2448
;2447:
;2448:	VectorCopy( trace.endpos, verts[1].xyz );
ADDRLP4 0+24
ADDRLP4 96+12
INDIRB
ASGNB 12
line 2449
;2449:	verts[1].xyz[0] -= 32;
ADDRLP4 0+24
ADDRLP4 0+24
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 2450
;2450:	verts[1].xyz[1] += 32;
ADDRLP4 0+24+4
ADDRLP4 0+24+4
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 2451
;2451:	verts[1].st[0] = 0;
ADDRLP4 0+24+12
CNSTF4 0
ASGNF4
line 2452
;2452:	verts[1].st[1] = 1;
ADDRLP4 0+24+12+4
CNSTF4 1065353216
ASGNF4
line 2453
;2453:	verts[1].modulate[0] = 255;
ADDRLP4 0+24+20
CNSTU1 255
ASGNU1
line 2454
;2454:	verts[1].modulate[1] = 255;
ADDRLP4 0+24+20+1
CNSTU1 255
ASGNU1
line 2455
;2455:	verts[1].modulate[2] = 255;
ADDRLP4 0+24+20+2
CNSTU1 255
ASGNU1
line 2456
;2456:	verts[1].modulate[3] = 255;
ADDRLP4 0+24+20+3
CNSTU1 255
ASGNU1
line 2458
;2457:
;2458:	VectorCopy( trace.endpos, verts[2].xyz );
ADDRLP4 0+48
ADDRLP4 96+12
INDIRB
ASGNB 12
line 2459
;2459:	verts[2].xyz[0] += 32;
ADDRLP4 0+48
ADDRLP4 0+48
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 2460
;2460:	verts[2].xyz[1] += 32;
ADDRLP4 0+48+4
ADDRLP4 0+48+4
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 2461
;2461:	verts[2].st[0] = 1;
ADDRLP4 0+48+12
CNSTF4 1065353216
ASGNF4
line 2462
;2462:	verts[2].st[1] = 1;
ADDRLP4 0+48+12+4
CNSTF4 1065353216
ASGNF4
line 2463
;2463:	verts[2].modulate[0] = 255;
ADDRLP4 0+48+20
CNSTU1 255
ASGNU1
line 2464
;2464:	verts[2].modulate[1] = 255;
ADDRLP4 0+48+20+1
CNSTU1 255
ASGNU1
line 2465
;2465:	verts[2].modulate[2] = 255;
ADDRLP4 0+48+20+2
CNSTU1 255
ASGNU1
line 2466
;2466:	verts[2].modulate[3] = 255;
ADDRLP4 0+48+20+3
CNSTU1 255
ASGNU1
line 2468
;2467:
;2468:	VectorCopy( trace.endpos, verts[3].xyz );
ADDRLP4 0+72
ADDRLP4 96+12
INDIRB
ASGNB 12
line 2469
;2469:	verts[3].xyz[0] += 32;
ADDRLP4 0+72
ADDRLP4 0+72
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 2470
;2470:	verts[3].xyz[1] -= 32;
ADDRLP4 0+72+4
ADDRLP4 0+72+4
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 2471
;2471:	verts[3].st[0] = 1;
ADDRLP4 0+72+12
CNSTF4 1065353216
ASGNF4
line 2472
;2472:	verts[3].st[1] = 0;
ADDRLP4 0+72+12+4
CNSTF4 0
ASGNF4
line 2473
;2473:	verts[3].modulate[0] = 255;
ADDRLP4 0+72+20
CNSTU1 255
ASGNU1
line 2474
;2474:	verts[3].modulate[1] = 255;
ADDRLP4 0+72+20+1
CNSTU1 255
ASGNU1
line 2475
;2475:	verts[3].modulate[2] = 255;
ADDRLP4 0+72+20+2
CNSTU1 255
ASGNU1
line 2476
;2476:	verts[3].modulate[3] = 255;
ADDRLP4 0+72+20+3
CNSTU1 255
ASGNU1
line 2478
;2477:
;2478:	trap_R_AddPolyToScene( cgs.media.wakeMarkShader, 4, verts );
ADDRGP4 cgs+156680+424
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddPolyToScene
CALLV
pop
line 2479
;2479:}
LABELV $1282
endproc CG_PlayerSplash 192 28
export CG_AddRefEntityWithPowerups
proc CG_AddRefEntityWithPowerups 0 4
line 2491
;2480:
;2481:
;2482:
;2483:/*
;2484:===============
;2485:CG_AddRefEntityWithPowerups
;2486:
;2487:Adds a piece with modifications or duplications for powerups
;2488:Also called by CG_Missile for quad rockets, but nobody can tell...
;2489:===============
;2490:*/
;2491:void CG_AddRefEntityWithPowerups( refEntity_t *ent, entityState_t *state, int team ) {
line 2493
;2492:
;2493:	if ( state->powerups & ( 1 << PW_INVIS ) ) {
ADDRFP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1373
line 2494
;2494:		ent->customShader = cgs.media.invisShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+156680+468
INDIRI4
ASGNI4
line 2495
;2495:		trap_R_AddRefEntityToScene( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2496
;2496:	} else {
ADDRGP4 $1374
JUMPV
LABELV $1373
line 2497
;2497:		trap_R_AddRefEntityToScene( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2499
;2498:
;2499:		if ( state->powerups & ( 1 << PW_QUAD ) ) {
ADDRFP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1377
line 2500
;2500:			if (team == TEAM_RED) {
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $1379
line 2501
;2501:				ent->customShader = cgs.media.redQuadShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+156680+460
INDIRI4
ASGNI4
line 2502
;2502:			} else {
ADDRGP4 $1380
JUMPV
LABELV $1379
line 2503
;2503:				ent->customShader = cgs.media.quadShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+156680+456
INDIRI4
ASGNI4
line 2504
;2504:			}
LABELV $1380
line 2505
;2505:			trap_R_AddRefEntityToScene( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2506
;2506:		}
LABELV $1377
line 2507
;2507:		if ( state->powerups & ( 1 << PW_REGEN ) ) {
ADDRFP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $1385
line 2508
;2508:			if ( ( ( cg.time / 100 ) % 10 ) == 1 ) {
ADDRGP4 cg+107604
INDIRI4
CNSTI4 100
DIVI4
CNSTI4 10
MODI4
CNSTI4 1
NEI4 $1387
line 2509
;2509:				ent->customShader = cgs.media.regenShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+156680+472
INDIRI4
ASGNI4
line 2510
;2510:				trap_R_AddRefEntityToScene( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2511
;2511:			}
LABELV $1387
line 2512
;2512:		}
LABELV $1385
line 2513
;2513:		if ( state->powerups & ( 1 << PW_BATTLESUIT ) ) {
ADDRFP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1392
line 2514
;2514:			if ( !state->weapon ) {
ADDRFP4 4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1394
line 2516
;2515:				//Freezetag - add shader to model
;2516:				ent->customShader = cgs.media.freezeShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+156680+448
INDIRI4
ASGNI4
line 2517
;2517:			} else {
ADDRGP4 $1395
JUMPV
LABELV $1394
line 2518
;2518:				ent->customShader = cgs.media.battleSuitShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+156680+476
INDIRI4
ASGNI4
line 2519
;2519:			}
LABELV $1395
line 2520
;2520:			trap_R_AddRefEntityToScene( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 2521
;2521:		}
LABELV $1392
line 2522
;2522:	}
LABELV $1374
line 2523
;2523:}
LABELV $1372
endproc CG_AddRefEntityWithPowerups 0 4
export CG_LightVerts
proc CG_LightVerts 88 16
line 2531
;2524:
;2525:/*
;2526:=================
;2527:CG_LightVerts
;2528:=================
;2529:*/
;2530:int CG_LightVerts( vec3_t normal, int numVerts, polyVert_t *verts )
;2531:{
line 2538
;2532:	int				i, j;
;2533:	float			incoming;
;2534:	vec3_t			ambientLight;
;2535:	vec3_t			lightDir;
;2536:	vec3_t			directedLight;
;2537:
;2538:	trap_R_LightForPoint( verts[0].xyz, ambientLight, directedLight, lightDir );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 24
ARGP4
ADDRGP4 trap_R_LightForPoint
CALLI4
pop
line 2540
;2539:
;2540:	for (i = 0; i < numVerts; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1404
JUMPV
LABELV $1401
line 2541
;2541:		incoming = DotProduct (normal, lightDir);
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 48
INDIRP4
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ADDRLP4 48
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 48
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 24+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2542
;2542:		if ( incoming <= 0 ) {
ADDRLP4 8
INDIRF4
CNSTF4 0
GTF4 $1407
line 2543
;2543:			verts[i].modulate[0] = ambientLight[0];
ADDRLP4 56
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 60
CNSTF4 1325400064
ASGNF4
ADDRLP4 56
INDIRF4
ADDRLP4 60
INDIRF4
LTF4 $1410
ADDRLP4 52
ADDRLP4 56
INDIRF4
ADDRLP4 60
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1411
JUMPV
LABELV $1410
ADDRLP4 52
ADDRLP4 56
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1411
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
ADDRLP4 52
INDIRU4
CVUU1 4
ASGNU1
line 2544
;2544:			verts[i].modulate[1] = ambientLight[1];
ADDRLP4 68
ADDRLP4 12+4
INDIRF4
ASGNF4
ADDRLP4 72
CNSTF4 1325400064
ASGNF4
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
LTF4 $1414
ADDRLP4 64
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1415
JUMPV
LABELV $1414
ADDRLP4 64
ADDRLP4 68
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1415
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 21
ADDP4
ADDRLP4 64
INDIRU4
CVUU1 4
ASGNU1
line 2545
;2545:			verts[i].modulate[2] = ambientLight[2];
ADDRLP4 80
ADDRLP4 12+8
INDIRF4
ASGNF4
ADDRLP4 84
CNSTF4 1325400064
ASGNF4
ADDRLP4 80
INDIRF4
ADDRLP4 84
INDIRF4
LTF4 $1418
ADDRLP4 76
ADDRLP4 80
INDIRF4
ADDRLP4 84
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1419
JUMPV
LABELV $1418
ADDRLP4 76
ADDRLP4 80
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1419
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 22
ADDP4
ADDRLP4 76
INDIRU4
CVUU1 4
ASGNU1
line 2546
;2546:			verts[i].modulate[3] = 255;
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 23
ADDP4
CNSTU1 255
ASGNU1
line 2547
;2547:			continue;
ADDRGP4 $1402
JUMPV
LABELV $1407
line 2549
;2548:		} 
;2549:		j = ( ambientLight[0] + incoming * directedLight[0] );
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 2550
;2550:		if ( j > 255 ) {
ADDRLP4 0
INDIRI4
CNSTI4 255
LEI4 $1420
line 2551
;2551:			j = 255;
ADDRLP4 0
CNSTI4 255
ASGNI4
line 2552
;2552:		}
LABELV $1420
line 2553
;2553:		verts[i].modulate[0] = j;
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 20
ADDP4
ADDRLP4 0
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 2555
;2554:
;2555:		j = ( ambientLight[1] + incoming * directedLight[1] );
ADDRLP4 0
ADDRLP4 12+4
INDIRF4
ADDRLP4 8
INDIRF4
ADDRLP4 36+4
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 2556
;2556:		if ( j > 255 ) {
ADDRLP4 0
INDIRI4
CNSTI4 255
LEI4 $1424
line 2557
;2557:			j = 255;
ADDRLP4 0
CNSTI4 255
ASGNI4
line 2558
;2558:		}
LABELV $1424
line 2559
;2559:		verts[i].modulate[1] = j;
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 21
ADDP4
ADDRLP4 0
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 2561
;2560:
;2561:		j = ( ambientLight[2] + incoming * directedLight[2] );
ADDRLP4 0
ADDRLP4 12+8
INDIRF4
ADDRLP4 8
INDIRF4
ADDRLP4 36+8
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 2562
;2562:		if ( j > 255 ) {
ADDRLP4 0
INDIRI4
CNSTI4 255
LEI4 $1428
line 2563
;2563:			j = 255;
ADDRLP4 0
CNSTI4 255
ASGNI4
line 2564
;2564:		}
LABELV $1428
line 2565
;2565:		verts[i].modulate[2] = j;
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 22
ADDP4
ADDRLP4 0
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 2567
;2566:
;2567:		verts[i].modulate[3] = 255;
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTI4 23
ADDP4
CNSTU1 255
ASGNU1
line 2568
;2568:	}
LABELV $1402
line 2540
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1404
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $1401
line 2569
;2569:	return qtrue;
CNSTI4 1
RETI4
LABELV $1400
endproc CG_LightVerts 88 16
export CG_Player
proc CG_Player 472 28
line 2577
;2570:}
;2571:
;2572:/*
;2573:===============
;2574:CG_Player
;2575:===============
;2576:*/
;2577:void CG_Player( centity_t *cent ) {
line 2598
;2578:	clientInfo_t	*ci;
;2579:	refEntity_t		legs;
;2580:	refEntity_t		torso;
;2581:	refEntity_t		head;
;2582:	int				clientNum;
;2583:	int				renderfx;
;2584:	qboolean		shadow;
;2585:	float			shadowPlane;
;2586:#ifdef MISSIONPACK
;2587:	refEntity_t		skull;
;2588:	refEntity_t		powerup;
;2589:	int				t;
;2590:	float			c;
;2591:	float			angle;
;2592:	vec3_t			dir, angles;
;2593:#endif
;2594:
;2595:	// the client number is stored in clientNum.  It can't be derived
;2596:	// from the entity number, because a single client may have
;2597:	// multiple corpses on the level using the same clientinfo
;2598:	clientNum = cent->currentState.clientNum;
ADDRLP4 428
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 2599
;2599:	if ( clientNum < 0 || clientNum >= MAX_CLIENTS ) {
ADDRLP4 428
INDIRI4
CNSTI4 0
LTI4 $1433
ADDRLP4 428
INDIRI4
CNSTI4 64
LTI4 $1431
LABELV $1433
line 2600
;2600:		CG_Error( "Bad clientNum on player entity");
ADDRGP4 $1434
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 2601
;2601:	}
LABELV $1431
line 2602
;2602:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 420
CNSTI4 1776
ADDRLP4 428
INDIRI4
MULI4
ADDRGP4 cgs+40960
ADDP4
ASGNP4
line 2606
;2603:
;2604:	// it is possible to see corpses from disconnected players that may
;2605:	// not have valid clientinfo
;2606:	if ( !ci->infoValid ) {
ADDRLP4 420
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $1436
line 2607
;2607:		return;
ADDRGP4 $1430
JUMPV
LABELV $1436
line 2611
;2608:	}
;2609:
;2610:	// get the player model information
;2611:	renderfx = 0;
ADDRLP4 424
CNSTI4 0
ASGNI4
line 2612
;2612:	if ( cent->currentState.number == cg.snap->ps.clientNum) {
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $1438
line 2613
;2613:		if (!cg.renderingThirdPerson) {
ADDRGP4 cg+107628
INDIRI4
CNSTI4 0
NEI4 $1441
line 2614
;2614:			renderfx = RF_THIRD_PERSON;			// only draw in mirrors
ADDRLP4 424
CNSTI4 2
ASGNI4
line 2615
;2615:		} else {
ADDRGP4 $1442
JUMPV
LABELV $1441
line 2616
;2616:			if (cg_cameraMode.integer) {
ADDRGP4 cg_cameraMode+12
INDIRI4
CNSTI4 0
EQI4 $1444
line 2617
;2617:				return;
ADDRGP4 $1430
JUMPV
LABELV $1444
line 2619
;2618:			}
;2619:		}
LABELV $1442
line 2620
;2620:	}
LABELV $1438
line 2623
;2621:
;2622:
;2623:	memset( &legs, 0, sizeof(legs) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2624
;2624:	memset( &torso, 0, sizeof(torso) );
ADDRLP4 140
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2625
;2625:	memset( &head, 0, sizeof(head) );
ADDRLP4 280
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2628
;2626:
;2627:	//PM Skin memcpy the colors to the shader, THIS IS IMPORTANT!
;2628:	if ( cg_deadBodyDarken.integer && !cent->currentState.weapon ) {
ADDRLP4 444
CNSTI4 0
ASGNI4
ADDRGP4 cg_deadBodyDarken+12
INDIRI4
ADDRLP4 444
INDIRI4
EQI4 $1447
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ADDRLP4 444
INDIRI4
NEI4 $1447
line 2630
;2629:		//Set the body to grey
;2630:		legs.shaderRGBA[0] = legs.shaderRGBA[1] = legs.shaderRGBA[2] = legs.shaderRGBA[3] = 64;
ADDRLP4 448
CNSTU1 64
ASGNU1
ADDRLP4 0+116+3
ADDRLP4 448
INDIRU1
ASGNU1
ADDRLP4 0+116+2
ADDRLP4 448
INDIRU1
ASGNU1
ADDRLP4 0+116+1
ADDRLP4 448
INDIRU1
ASGNU1
ADDRLP4 0+116
ADDRLP4 448
INDIRU1
ASGNU1
line 2631
;2631:		torso.shaderRGBA[0] = torso.shaderRGBA[1] = torso.shaderRGBA[2] = torso.shaderRGBA[3] = 64;
ADDRLP4 449
CNSTU1 64
ASGNU1
ADDRLP4 140+116+3
ADDRLP4 449
INDIRU1
ASGNU1
ADDRLP4 140+116+2
ADDRLP4 449
INDIRU1
ASGNU1
ADDRLP4 140+116+1
ADDRLP4 449
INDIRU1
ASGNU1
ADDRLP4 140+116
ADDRLP4 449
INDIRU1
ASGNU1
line 2632
;2632:		head.shaderRGBA[0] = head.shaderRGBA[1] = head.shaderRGBA[2] = head.shaderRGBA[3] = 64;
ADDRLP4 450
CNSTU1 64
ASGNU1
ADDRLP4 280+116+3
ADDRLP4 450
INDIRU1
ASGNU1
ADDRLP4 280+116+2
ADDRLP4 450
INDIRU1
ASGNU1
ADDRLP4 280+116+1
ADDRLP4 450
INDIRU1
ASGNU1
ADDRLP4 280+116
ADDRLP4 450
INDIRU1
ASGNU1
line 2633
;2633:	} else if (clientNum == cg.clientNum) { 
ADDRGP4 $1448
JUMPV
LABELV $1447
ADDRLP4 428
INDIRI4
ADDRGP4 cg+4
INDIRI4
NEI4 $1471
line 2634
;2634:		memcpy(legs.shaderRGBA, &cgs.clientinfo[cg.clientNum].colors[3], sizeof(legs.shaderRGBA));
ADDRLP4 0+116
ARGP4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+92+12
ADDP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2635
;2635:		memcpy(torso.shaderRGBA, &cgs.clientinfo[cg.clientNum].colors[2], sizeof(torso.shaderRGBA));
ADDRLP4 140+116
ARGP4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+92+8
ADDP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2636
;2636:		memcpy(head.shaderRGBA, &cgs.clientinfo[cg.clientNum].colors[1], sizeof(head.shaderRGBA));
ADDRLP4 280+116
ARGP4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+92+4
ADDP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2637
;2637:	} else if (cg_forceColors.integer && isTeammate(ci, clientNum) ) {
ADDRGP4 $1472
JUMPV
LABELV $1471
ADDRGP4 cg_forceColors+12
INDIRI4
CNSTI4 0
EQI4 $1492
ADDRLP4 420
INDIRP4
ARGP4
ADDRLP4 428
INDIRI4
ARGI4
ADDRLP4 448
ADDRGP4 isTeammate
CALLI4
ASGNI4
ADDRLP4 448
INDIRI4
CNSTI4 0
EQI4 $1492
line 2638
;2638:		memcpy(legs.shaderRGBA, &cgs.clientinfo[cg.clientNum].colors[3], sizeof(legs.shaderRGBA));
ADDRLP4 0+116
ARGP4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+92+12
ADDP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2639
;2639:		memcpy(torso.shaderRGBA, &cgs.clientinfo[cg.clientNum].colors[2], sizeof(torso.shaderRGBA));
ADDRLP4 140+116
ARGP4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+92+8
ADDP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2640
;2640:		memcpy(head.shaderRGBA, &cgs.clientinfo[cg.clientNum].colors[1], sizeof(head.shaderRGBA));
ADDRLP4 280+116
ARGP4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+92+4
ADDP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2641
;2641:	} else if ( (strlen(cg_TeamColors.string) >= 3) && isTeammate(ci, clientNum) ) {
ADDRGP4 $1493
JUMPV
LABELV $1492
ADDRGP4 cg_TeamColors+16
ARGP4
ADDRLP4 452
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 452
INDIRI4
CNSTI4 3
LTI4 $1513
ADDRLP4 420
INDIRP4
ARGP4
ADDRLP4 428
INDIRI4
ARGI4
ADDRLP4 456
ADDRGP4 isTeammate
CALLI4
ASGNI4
ADDRLP4 456
INDIRI4
CNSTI4 0
EQI4 $1513
line 2642
;2642:		memcpy(legs.shaderRGBA, &cgs.teamColors[3], sizeof(legs.shaderRGBA));
ADDRLP4 0+116
ARGP4
ADDRGP4 cgs+157840+12
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2643
;2643:		memcpy(torso.shaderRGBA, &cgs.teamColors[2], sizeof(torso.shaderRGBA));
ADDRLP4 140+116
ARGP4
ADDRGP4 cgs+157840+8
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2644
;2644:		memcpy(head.shaderRGBA, &cgs.teamColors[1], sizeof(head.shaderRGBA));
ADDRLP4 280+116
ARGP4
ADDRGP4 cgs+157840+4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2645
;2645:	} else if (strlen(cg_EnemyColors.string) >= 3 && isEnemy(ci, clientNum) ) {
ADDRGP4 $1514
JUMPV
LABELV $1513
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 460
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 460
INDIRI4
CNSTI4 3
LTI4 $1528
ADDRLP4 420
INDIRP4
ARGP4
ADDRLP4 428
INDIRI4
ARGI4
ADDRLP4 464
ADDRGP4 isEnemy
CALLI4
ASGNI4
ADDRLP4 464
INDIRI4
CNSTI4 0
EQI4 $1528
line 2646
;2646:		memcpy(legs.shaderRGBA, &cgs.enemyColors[3], sizeof(legs.shaderRGBA));
ADDRLP4 0+116
ARGP4
ADDRGP4 cgs+157820+12
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2647
;2647:		memcpy(torso.shaderRGBA, &cgs.enemyColors[2], sizeof(torso.shaderRGBA));
ADDRLP4 140+116
ARGP4
ADDRGP4 cgs+157820+8
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2648
;2648:		memcpy(head.shaderRGBA, &cgs.enemyColors[1], sizeof(head.shaderRGBA));
ADDRLP4 280+116
ARGP4
ADDRGP4 cgs+157820+4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2649
;2649:	} else {
ADDRGP4 $1529
JUMPV
LABELV $1528
line 2650
;2650:		memcpy(legs.shaderRGBA, &ci->colors[3], sizeof(legs.shaderRGBA));
ADDRLP4 0+116
ARGP4
ADDRLP4 420
INDIRP4
CNSTI4 104
ADDP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2651
;2651:		memcpy(torso.shaderRGBA, &ci->colors[2], sizeof(torso.shaderRGBA));
ADDRLP4 140+116
ARGP4
ADDRLP4 420
INDIRP4
CNSTI4 100
ADDP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2652
;2652:		memcpy(head.shaderRGBA, &ci->colors[1], sizeof(head.shaderRGBA));
ADDRLP4 280+116
ARGP4
ADDRLP4 420
INDIRP4
CNSTI4 96
ADDP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2653
;2653:	}
LABELV $1529
LABELV $1514
LABELV $1493
LABELV $1472
LABELV $1448
line 2657
;2654:
;2655:
;2656:	// get the rotation information
;2657:	CG_PlayerAngles( cent, legs.axis, torso.axis, head.axis );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+28
ARGP4
ADDRLP4 140+28
ARGP4
ADDRLP4 280+28
ARGP4
ADDRGP4 CG_PlayerAngles
CALLV
pop
line 2660
;2658:	
;2659:	// get the animation state (after rotation, to allow feet shuffle)
;2660:	CG_PlayerAnimation( cent, &legs.oldframe, &legs.frame, &legs.backlerp,
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+96
ARGP4
ADDRLP4 0+80
ARGP4
ADDRLP4 0+100
ARGP4
ADDRLP4 140+96
ARGP4
ADDRLP4 140+80
ARGP4
ADDRLP4 140+100
ARGP4
ADDRGP4 CG_PlayerAnimation
CALLV
pop
line 2664
;2661:		 &torso.oldframe, &torso.frame, &torso.backlerp );
;2662:
;2663:	// add the talk baloon or disconnect icon
;2664:	CG_PlayerSprites( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_PlayerSprites
CALLV
pop
line 2667
;2665:
;2666:	// add the shadow
;2667:	shadow = CG_PlayerShadow( cent, &shadowPlane );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 432
ARGP4
ADDRLP4 468
ADDRGP4 CG_PlayerShadow
CALLI4
ASGNI4
ADDRLP4 436
ADDRLP4 468
INDIRI4
ASGNI4
line 2670
;2668:
;2669:	// add a water splash if partially in and out of water
;2670:	CG_PlayerSplash( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_PlayerSplash
CALLV
pop
line 2672
;2671:
;2672:	if ( cg_shadows.integer == 3 && shadow ) {
ADDRGP4 cg_shadows+12
INDIRI4
CNSTI4 3
NEI4 $1558
ADDRLP4 436
INDIRI4
CNSTI4 0
EQI4 $1558
line 2673
;2673:		renderfx |= RF_SHADOW_PLANE;
ADDRLP4 424
ADDRLP4 424
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 2674
;2674:	}
LABELV $1558
line 2675
;2675:	renderfx |= RF_LIGHTING_ORIGIN;			// use the same origin for all
ADDRLP4 424
ADDRLP4 424
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 2684
;2676:#ifdef MISSIONPACK
;2677:	if( cgs.gametype == GT_HARVESTER ) {
;2678:		CG_PlayerTokens( cent, renderfx );
;2679:	}
;2680:#endif
;2681:	//
;2682:	// add the legs
;2683:	//
;2684:	legs.hModel = ci->legsModel;
ADDRLP4 0+8
ADDRLP4 420
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ASGNI4
line 2685
;2685:	legs.customSkin = ci->legsSkin;
ADDRLP4 0+108
ADDRLP4 420
INDIRP4
CNSTI4 580
ADDP4
INDIRI4
ASGNI4
line 2687
;2686:
;2687:	VectorCopy( cent->lerpOrigin, legs.origin );
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRB
ASGNB 12
line 2689
;2688:
;2689:	VectorCopy( cent->lerpOrigin, legs.lightingOrigin );
ADDRLP4 0+12
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRB
ASGNB 12
line 2690
;2690:	legs.shadowPlane = shadowPlane;
ADDRLP4 0+24
ADDRLP4 432
INDIRF4
ASGNF4
line 2691
;2691:	legs.renderfx = renderfx;
ADDRLP4 0+4
ADDRLP4 424
INDIRI4
ASGNI4
line 2692
;2692:	VectorCopy (legs.origin, legs.oldorigin);	// don't positionally lerp at all
ADDRLP4 0+84
ADDRLP4 0+68
INDIRB
ASGNB 12
line 2694
;2693:
;2694:	CG_AddRefEntityWithPowerups( &legs, &cent->currentState, ci->team );
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 420
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_AddRefEntityWithPowerups
CALLV
pop
line 2697
;2695:
;2696:	// if the model failed, allow the default nullmodel to be displayed
;2697:	if (!legs.hModel) {
ADDRLP4 0+8
INDIRI4
CNSTI4 0
NEI4 $1569
line 2698
;2698:		return;
ADDRGP4 $1430
JUMPV
LABELV $1569
line 2704
;2699:	}
;2700:
;2701:	//
;2702:	// add the torso
;2703:	//
;2704:	torso.hModel = ci->torsoModel;
ADDRLP4 140+8
ADDRLP4 420
INDIRP4
CNSTI4 584
ADDP4
INDIRI4
ASGNI4
line 2705
;2705:	if (!torso.hModel) {
ADDRLP4 140+8
INDIRI4
CNSTI4 0
NEI4 $1573
line 2706
;2706:		return;
ADDRGP4 $1430
JUMPV
LABELV $1573
line 2709
;2707:	}
;2708:
;2709:	torso.customSkin = ci->torsoSkin;
ADDRLP4 140+108
ADDRLP4 420
INDIRP4
CNSTI4 588
ADDP4
INDIRI4
ASGNI4
line 2711
;2710:
;2711:	VectorCopy( cent->lerpOrigin, torso.lightingOrigin );
ADDRLP4 140+12
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRB
ASGNB 12
line 2713
;2712:
;2713:	CG_PositionRotatedEntityOnTag( &torso, &legs, ci->legsModel, "tag_torso");
ADDRLP4 140
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 420
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRGP4 $1578
ARGP4
ADDRGP4 CG_PositionRotatedEntityOnTag
CALLV
pop
line 2715
;2714:
;2715:	torso.shadowPlane = shadowPlane;
ADDRLP4 140+24
ADDRLP4 432
INDIRF4
ASGNF4
line 2716
;2716:	torso.renderfx = renderfx;
ADDRLP4 140+4
ADDRLP4 424
INDIRI4
ASGNI4
line 2718
;2717:
;2718:	CG_AddRefEntityWithPowerups( &torso, &cent->currentState, ci->team );
ADDRLP4 140
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 420
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_AddRefEntityWithPowerups
CALLV
pop
line 2927
;2719:
;2720:#ifdef MISSIONPACK
;2721:	if ( cent->currentState.eFlags & EF_KAMIKAZE ) {
;2722:
;2723:		memset( &skull, 0, sizeof(skull) );
;2724:
;2725:		VectorCopy( cent->lerpOrigin, skull.lightingOrigin );
;2726:		skull.shadowPlane = shadowPlane;
;2727:		skull.renderfx = renderfx;
;2728:
;2729:		if ( cent->currentState.eFlags & EF_DEAD ) {
;2730:			// one skull bobbing above the dead body
;2731:			angle = ((cg.time / 7) & 255) * (M_PI * 2) / 255;
;2732:			if (angle > M_PI * 2)
;2733:				angle -= (float)M_PI * 2;
;2734:			dir[0] = sin(angle) * 20;
;2735:			dir[1] = cos(angle) * 20;
;2736:			angle = ((cg.time / 4) & 255) * (M_PI * 2) / 255;
;2737:			dir[2] = 15 + sin(angle) * 8;
;2738:			VectorAdd(torso.origin, dir, skull.origin);
;2739:			
;2740:			dir[2] = 0;
;2741:			VectorCopy(dir, skull.axis[1]);
;2742:			VectorNormalize(skull.axis[1]);
;2743:			VectorSet(skull.axis[2], 0, 0, 1);
;2744:			CrossProduct(skull.axis[1], skull.axis[2], skull.axis[0]);
;2745:
;2746:			skull.hModel = cgs.media.kamikazeHeadModel;
;2747:			trap_R_AddRefEntityToScene( &skull );
;2748:			skull.hModel = cgs.media.kamikazeHeadTrail;
;2749:			trap_R_AddRefEntityToScene( &skull );
;2750:		}
;2751:		else {
;2752:			// three skulls spinning around the player
;2753:			angle = ((cg.time / 4) & 255) * (M_PI * 2) / 255;
;2754:			dir[0] = cos(angle) * 20;
;2755:			dir[1] = sin(angle) * 20;
;2756:			dir[2] = cos(angle) * 20;
;2757:			VectorAdd(torso.origin, dir, skull.origin);
;2758:
;2759:			angles[0] = sin(angle) * 30;
;2760:			angles[1] = (angle * 180 / M_PI) + 90;
;2761:			if (angles[1] > 360)
;2762:				angles[1] -= 360;
;2763:			angles[2] = 0;
;2764:			AnglesToAxis( angles, skull.axis );
;2765:
;2766:			/*
;2767:			dir[2] = 0;
;2768:			VectorInverse(dir);
;2769:			VectorCopy(dir, skull.axis[1]);
;2770:			VectorNormalize(skull.axis[1]);
;2771:			VectorSet(skull.axis[2], 0, 0, 1);
;2772:			CrossProduct(skull.axis[1], skull.axis[2], skull.axis[0]);
;2773:			*/
;2774:
;2775:			skull.hModel = cgs.media.kamikazeHeadModel;
;2776:			trap_R_AddRefEntityToScene( &skull );
;2777:			// flip the trail because this skull is spinning in the other direction
;2778:			VectorInverse(skull.axis[1]);
;2779:			skull.hModel = cgs.media.kamikazeHeadTrail;
;2780:			trap_R_AddRefEntityToScene( &skull );
;2781:
;2782:			angle = ((cg.time / 4) & 255) * (M_PI * 2) / 255 + M_PI;
;2783:			if (angle > M_PI * 2)
;2784:				angle -= (float)M_PI * 2;
;2785:			dir[0] = sin(angle) * 20;
;2786:			dir[1] = cos(angle) * 20;
;2787:			dir[2] = cos(angle) * 20;
;2788:			VectorAdd(torso.origin, dir, skull.origin);
;2789:
;2790:			angles[0] = cos(angle - 0.5 * M_PI) * 30;
;2791:			angles[1] = 360 - (angle * 180 / M_PI);
;2792:			if (angles[1] > 360)
;2793:				angles[1] -= 360;
;2794:			angles[2] = 0;
;2795:			AnglesToAxis( angles, skull.axis );
;2796:
;2797:			/*
;2798:			dir[2] = 0;
;2799:			VectorCopy(dir, skull.axis[1]);
;2800:			VectorNormalize(skull.axis[1]);
;2801:			VectorSet(skull.axis[2], 0, 0, 1);
;2802:			CrossProduct(skull.axis[1], skull.axis[2], skull.axis[0]);
;2803:			*/
;2804:
;2805:			skull.hModel = cgs.media.kamikazeHeadModel;
;2806:			trap_R_AddRefEntityToScene( &skull );
;2807:			skull.hModel = cgs.media.kamikazeHeadTrail;
;2808:			trap_R_AddRefEntityToScene( &skull );
;2809:
;2810:			angle = ((cg.time / 3) & 255) * (M_PI * 2) / 255 + 0.5 * M_PI;
;2811:			if (angle > M_PI * 2)
;2812:				angle -= (float)M_PI * 2;
;2813:			dir[0] = sin(angle) * 20;
;2814:			dir[1] = cos(angle) * 20;
;2815:			dir[2] = 0;
;2816:			VectorAdd(torso.origin, dir, skull.origin);
;2817:			
;2818:			VectorCopy(dir, skull.axis[1]);
;2819:			VectorNormalize(skull.axis[1]);
;2820:			VectorSet(skull.axis[2], 0, 0, 1);
;2821:			CrossProduct(skull.axis[1], skull.axis[2], skull.axis[0]);
;2822:
;2823:			skull.hModel = cgs.media.kamikazeHeadModel;
;2824:			trap_R_AddRefEntityToScene( &skull );
;2825:			skull.hModel = cgs.media.kamikazeHeadTrail;
;2826:			trap_R_AddRefEntityToScene( &skull );
;2827:		}
;2828:	}
;2829:
;2830:	if ( cent->currentState.powerups & ( 1 << PW_GUARD ) ) {
;2831:		memcpy(&powerup, &torso, sizeof(torso));
;2832:		powerup.hModel = cgs.media.guardPowerupModel;
;2833:		powerup.frame = 0;
;2834:		powerup.oldframe = 0;
;2835:		powerup.customSkin = 0;
;2836:		trap_R_AddRefEntityToScene( &powerup );
;2837:	}
;2838:	if ( cent->currentState.powerups & ( 1 << PW_SCOUT ) ) {
;2839:		memcpy(&powerup, &torso, sizeof(torso));
;2840:		powerup.hModel = cgs.media.scoutPowerupModel;
;2841:		powerup.frame = 0;
;2842:		powerup.oldframe = 0;
;2843:		powerup.customSkin = 0;
;2844:		trap_R_AddRefEntityToScene( &powerup );
;2845:	}
;2846:	if ( cent->currentState.powerups & ( 1 << PW_DOUBLER ) ) {
;2847:		memcpy(&powerup, &torso, sizeof(torso));
;2848:		powerup.hModel = cgs.media.doublerPowerupModel;
;2849:		powerup.frame = 0;
;2850:		powerup.oldframe = 0;
;2851:		powerup.customSkin = 0;
;2852:		trap_R_AddRefEntityToScene( &powerup );
;2853:	}
;2854:	if ( cent->currentState.powerups & ( 1 << PW_AMMOREGEN ) ) {
;2855:		memcpy(&powerup, &torso, sizeof(torso));
;2856:		powerup.hModel = cgs.media.ammoRegenPowerupModel;
;2857:		powerup.frame = 0;
;2858:		powerup.oldframe = 0;
;2859:		powerup.customSkin = 0;
;2860:		trap_R_AddRefEntityToScene( &powerup );
;2861:	}
;2862:	if ( cent->currentState.powerups & ( 1 << PW_INVULNERABILITY ) ) {
;2863:		if ( !ci->invulnerabilityStartTime ) {
;2864:			ci->invulnerabilityStartTime = cg.time;
;2865:		}
;2866:		ci->invulnerabilityStopTime = cg.time;
;2867:	}
;2868:	else {
;2869:		ci->invulnerabilityStartTime = 0;
;2870:	}
;2871:	if ( (cent->currentState.powerups & ( 1 << PW_INVULNERABILITY ) ) ||
;2872:		cg.time - ci->invulnerabilityStopTime < 250 ) {
;2873:
;2874:		memcpy(&powerup, &torso, sizeof(torso));
;2875:		powerup.hModel = cgs.media.invulnerabilityPowerupModel;
;2876:		powerup.customSkin = 0;
;2877:		// always draw
;2878:		powerup.renderfx &= ~RF_THIRD_PERSON;
;2879:		VectorCopy(cent->lerpOrigin, powerup.origin);
;2880:
;2881:		if ( cg.time - ci->invulnerabilityStartTime < 250 ) {
;2882:			c = (float) (cg.time - ci->invulnerabilityStartTime) / 250;
;2883:		}
;2884:		else if (cg.time - ci->invulnerabilityStopTime < 250 ) {
;2885:			c = (float) (250 - (cg.time - ci->invulnerabilityStopTime)) / 250;
;2886:		}
;2887:		else {
;2888:			c = 1;
;2889:		}
;2890:		VectorSet( powerup.axis[0], c, 0, 0 );
;2891:		VectorSet( powerup.axis[1], 0, c, 0 );
;2892:		VectorSet( powerup.axis[2], 0, 0, c );
;2893:		trap_R_AddRefEntityToScene( &powerup );
;2894:	}
;2895:
;2896:	t = cg.time - ci->medkitUsageTime;
;2897:	if ( ci->medkitUsageTime && t < 500 ) {
;2898:		memcpy(&powerup, &torso, sizeof(torso));
;2899:		powerup.hModel = cgs.media.medkitUsageModel;
;2900:		powerup.customSkin = 0;
;2901:		// always draw
;2902:		powerup.renderfx &= ~RF_THIRD_PERSON;
;2903:		VectorClear(angles);
;2904:		AnglesToAxis(angles, powerup.axis);
;2905:		VectorCopy(cent->lerpOrigin, powerup.origin);
;2906:		powerup.origin[2] += -24 + (float) t * 80 / 500;
;2907:		if ( t > 400 ) {
;2908:			c = (float) (t - 1000) * 0xff / 100;
;2909:			powerup.shaderRGBA[0] = 0xff - c;
;2910:			powerup.shaderRGBA[1] = 0xff - c;
;2911:			powerup.shaderRGBA[2] = 0xff - c;
;2912:			powerup.shaderRGBA[3] = 0xff - c;
;2913:		}
;2914:		else {
;2915:			powerup.shaderRGBA[0] = 0xff;
;2916:			powerup.shaderRGBA[1] = 0xff;
;2917:			powerup.shaderRGBA[2] = 0xff;
;2918:			powerup.shaderRGBA[3] = 0xff;
;2919:		}
;2920:		trap_R_AddRefEntityToScene( &powerup );
;2921:	}
;2922:#endif // MISSIONPACK
;2923:
;2924:	//
;2925:	// add the head
;2926:	//
;2927:	head.hModel = ci->headModel;
ADDRLP4 280+8
ADDRLP4 420
INDIRP4
CNSTI4 592
ADDP4
INDIRI4
ASGNI4
line 2928
;2928:	if (!head.hModel) {
ADDRLP4 280+8
INDIRI4
CNSTI4 0
NEI4 $1582
line 2929
;2929:		return;
ADDRGP4 $1430
JUMPV
LABELV $1582
line 2931
;2930:	}
;2931:	head.customSkin = ci->headSkin;
ADDRLP4 280+108
ADDRLP4 420
INDIRP4
CNSTI4 596
ADDP4
INDIRI4
ASGNI4
line 2933
;2932:
;2933:	VectorCopy( cent->lerpOrigin, head.lightingOrigin );
ADDRLP4 280+12
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRB
ASGNB 12
line 2935
;2934:
;2935:	CG_PositionRotatedEntityOnTag( &head, &torso, ci->torsoModel, "tag_head");
ADDRLP4 280
ARGP4
ADDRLP4 140
ARGP4
ADDRLP4 420
INDIRP4
CNSTI4 584
ADDP4
INDIRI4
ARGI4
ADDRGP4 $1587
ARGP4
ADDRGP4 CG_PositionRotatedEntityOnTag
CALLV
pop
line 2937
;2936:
;2937:	head.shadowPlane = shadowPlane;
ADDRLP4 280+24
ADDRLP4 432
INDIRF4
ASGNF4
line 2938
;2938:	head.renderfx = renderfx;
ADDRLP4 280+4
ADDRLP4 424
INDIRI4
ASGNI4
line 2940
;2939:
;2940:	CG_AddRefEntityWithPowerups( &head, &cent->currentState, ci->team );
ADDRLP4 280
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 420
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_AddRefEntityWithPowerups
CALLV
pop
line 2942
;2941:
;2942:	CG_BreathPuffs(cent, &head);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 280
ARGP4
ADDRGP4 CG_BreathPuffs
CALLV
pop
line 2950
;2943:#ifdef MISSIONPACK
;2944:	CG_DustTrail(cent);
;2945:#endif
;2946:
;2947:	//
;2948:	// add the gun / barrel / flash
;2949:	//
;2950:	CG_AddPlayerWeapon( &torso, NULL, cent, ci->team );
ADDRLP4 140
ARGP4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 420
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_AddPlayerWeapon
CALLV
pop
line 2953
;2951:
;2952:	// add powerups floating behind the player
;2953:	CG_PlayerPowerups( cent, &torso );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ARGP4
ADDRGP4 CG_PlayerPowerups
CALLV
pop
line 2957
;2954:
;2955://unlagged - client options
;2956:	// add the bounding box (if cg_drawBBox is 1)
;2957:	CG_AddBoundingBox( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddBoundingBox
CALLV
pop
line 2959
;2958://unlagged - client options
;2959:}
LABELV $1430
endproc CG_Player 472 28
export CG_ResetPlayerEntity
proc CG_ResetPlayerEntity 40 12
line 2971
;2960:
;2961:
;2962://=====================================================================
;2963:
;2964:/*
;2965:===============
;2966:CG_ResetPlayerEntity
;2967:
;2968:A player just came into view or teleported, so reset all animation info
;2969:===============
;2970:*/
;2971:void CG_ResetPlayerEntity( centity_t *cent ) {
line 2972
;2972:	cent->errorTime = -99999;		// guarantee no error decay added
ADDRFP4 0
INDIRP4
CNSTI4 636
ADDP4
CNSTI4 -99999
ASGNI4
line 2973
;2973:	cent->extrapolated = qfalse;	
ADDRFP4 0
INDIRP4
CNSTI4 664
ADDP4
CNSTI4 0
ASGNI4
line 2975
;2974:
;2975:	CG_ClearLerpFrame( &cgs.clientinfo[ cent->currentState.clientNum ], &cent->pe.legs, cent->currentState.legsAnim );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
CNSTI4 1776
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+40960
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_ClearLerpFrame
CALLV
pop
line 2976
;2976:	CG_ClearLerpFrame( &cgs.clientinfo[ cent->currentState.clientNum ], &cent->pe.torso, cent->currentState.torsoAnim );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
CNSTI4 1776
ADDRLP4 4
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+40960
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 500
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_ClearLerpFrame
CALLV
pop
line 2978
;2977:
;2978:	BG_EvaluateTrajectory( &cent->currentState.pos, cg.time, cent->lerpOrigin );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 704
ADDP4
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 2979
;2979:	BG_EvaluateTrajectory( &cent->currentState.apos, cg.time, cent->lerpAngles );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 12
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 2981
;2980:
;2981:	VectorCopy( cent->lerpOrigin, cent->rawOrigin );
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 668
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 704
ADDP4
INDIRB
ASGNB 12
line 2982
;2982:	VectorCopy( cent->lerpAngles, cent->rawAngles );
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 680
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 2984
;2983:
;2984:	memset( &cent->pe.legs, 0, sizeof( cent->pe.legs ) );
ADDRFP4 0
INDIRP4
CNSTI4 452
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 48
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2985
;2985:	cent->pe.legs.yawAngle = cent->rawAngles[YAW];
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 472
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 684
ADDP4
INDIRF4
ASGNF4
line 2986
;2986:	cent->pe.legs.yawing = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 476
ADDP4
CNSTI4 0
ASGNI4
line 2987
;2987:	cent->pe.legs.pitchAngle = 0;
ADDRFP4 0
INDIRP4
CNSTI4 480
ADDP4
CNSTF4 0
ASGNF4
line 2988
;2988:	cent->pe.legs.pitching = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 484
ADDP4
CNSTI4 0
ASGNI4
line 2990
;2989:
;2990:	memset( &cent->pe.torso, 0, sizeof( cent->pe.legs ) );
ADDRFP4 0
INDIRP4
CNSTI4 500
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 48
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2991
;2991:	cent->pe.torso.yawAngle = cent->rawAngles[YAW];
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 520
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 684
ADDP4
INDIRF4
ASGNF4
line 2992
;2992:	cent->pe.torso.yawing = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
CNSTI4 0
ASGNI4
line 2993
;2993:	cent->pe.torso.pitchAngle = cent->rawAngles[PITCH];
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 528
ADDP4
ADDRLP4 32
INDIRP4
CNSTI4 680
ADDP4
INDIRF4
ASGNF4
line 2994
;2994:	cent->pe.torso.pitching = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
CNSTI4 0
ASGNI4
line 2996
;2995:
;2996:	if ( cg_debugPosition.integer ) {
ADDRGP4 cg_debugPosition+12
INDIRI4
CNSTI4 0
EQI4 $1595
line 2997
;2997:		CG_Printf("%i ResetPlayerEntity yaw=%i\n", cent->currentState.number, cent->pe.torso.yawAngle );
ADDRGP4 $1598
ARGP4
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
INDIRI4
ARGI4
ADDRLP4 36
INDIRP4
CNSTI4 520
ADDP4
INDIRF4
ARGF4
ADDRGP4 CG_Printf
CALLV
pop
line 2998
;2998:	}
LABELV $1595
line 2999
;2999:}
LABELV $1590
endproc CG_ResetPlayerEntity 40 12
export CG_ParseColors
proc CG_ParseColors 112 12
line 3007
;3000:
;3001:/*
;3002:================
;3003:CG_ParseColors
;3004:Evo:Model:Begin
;3005:================
;3006:*/
;3007:void CG_ParseColors ( int ColorSet, char *colorString, int strLen ) {
line 3011
;3008:	int		i, color;
;3009:	//This was setup to allow the color strings to have multiple value sets, 2,3,4,5
;3010:
;3011:	if ( ColorSet == COLORS ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $1600
line 3012
;3012:		memset( &cgs.clientinfo[cg.clientNum].colors, 0, sizeof(&cgs.clientinfo[cg.clientNum].colors));
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+92
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 3013
;3013:		if ( strLen == 2 ) {
ADDRFP4 8
INDIRI4
CNSTI4 2
NEI4 $1608
line 3017
;3014:			//Set rail colors
;3015:
;3016:			//Color1
;3017:			color = ColorIndex(colorString[0]);
ADDRFP4 4
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 3018
;3018:			cgs.clientinfo[cg.clientNum].colors[0][0] = g_color_table[color][0] * 255;
ADDRLP4 16
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 20
CNSTF4 1325400064
ASGNF4
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
LTF4 $1614
ADDRLP4 12
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1615
JUMPV
LABELV $1614
ADDRLP4 12
ADDRLP4 16
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1615
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+92
ADDP4
ADDRLP4 12
INDIRU4
CVUU1 4
ASGNU1
line 3019
;3019:			cgs.clientinfo[cg.clientNum].colors[0][1] = g_color_table[color][1] * 255;
ADDRLP4 28
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+4
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 32
CNSTF4 1325400064
ASGNF4
ADDRLP4 28
INDIRF4
ADDRLP4 32
INDIRF4
LTF4 $1622
ADDRLP4 24
ADDRLP4 28
INDIRF4
ADDRLP4 32
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1623
JUMPV
LABELV $1622
ADDRLP4 24
ADDRLP4 28
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1623
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+92+1
ADDP4
ADDRLP4 24
INDIRU4
CVUU1 4
ASGNU1
line 3020
;3020:			cgs.clientinfo[cg.clientNum].colors[0][2] = g_color_table[color][2] * 255;
ADDRLP4 40
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+8
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 44
CNSTF4 1325400064
ASGNF4
ADDRLP4 40
INDIRF4
ADDRLP4 44
INDIRF4
LTF4 $1630
ADDRLP4 36
ADDRLP4 40
INDIRF4
ADDRLP4 44
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1631
JUMPV
LABELV $1630
ADDRLP4 36
ADDRLP4 40
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1631
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+92+2
ADDP4
ADDRLP4 36
INDIRU4
CVUU1 4
ASGNU1
line 3021
;3021:			cgs.clientinfo[cg.clientNum].colors[0][3] = g_color_table[color][3] * 255;
ADDRLP4 52
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+12
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 56
CNSTF4 1325400064
ASGNF4
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
LTF4 $1638
ADDRLP4 48
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1639
JUMPV
LABELV $1638
ADDRLP4 48
ADDRLP4 52
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1639
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+92+3
ADDP4
ADDRLP4 48
INDIRU4
CVUU1 4
ASGNU1
line 3024
;3022:
;3023:			//Color2
;3024:			color = ColorIndex(colorString[4]);
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 60
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 60
INDIRI4
ASGNI4
line 3025
;3025:			cgs.clientinfo[cg.clientNum].colors[4][0] = g_color_table[color][0] * 255;
ADDRLP4 68
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 72
CNSTF4 1325400064
ASGNF4
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
LTF4 $1645
ADDRLP4 64
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1646
JUMPV
LABELV $1645
ADDRLP4 64
ADDRLP4 68
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1646
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+92+16
ADDP4
ADDRLP4 64
INDIRU4
CVUU1 4
ASGNU1
line 3026
;3026:			cgs.clientinfo[cg.clientNum].colors[4][1] = g_color_table[color][1] * 255;
ADDRLP4 80
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+4
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 84
CNSTF4 1325400064
ASGNF4
ADDRLP4 80
INDIRF4
ADDRLP4 84
INDIRF4
LTF4 $1654
ADDRLP4 76
ADDRLP4 80
INDIRF4
ADDRLP4 84
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1655
JUMPV
LABELV $1654
ADDRLP4 76
ADDRLP4 80
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1655
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+92+16+1
ADDP4
ADDRLP4 76
INDIRU4
CVUU1 4
ASGNU1
line 3027
;3027:			cgs.clientinfo[cg.clientNum].colors[4][2] = g_color_table[color][2] * 255;
ADDRLP4 92
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+8
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 96
CNSTF4 1325400064
ASGNF4
ADDRLP4 92
INDIRF4
ADDRLP4 96
INDIRF4
LTF4 $1663
ADDRLP4 88
ADDRLP4 92
INDIRF4
ADDRLP4 96
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1664
JUMPV
LABELV $1663
ADDRLP4 88
ADDRLP4 92
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1664
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+92+16+2
ADDP4
ADDRLP4 88
INDIRU4
CVUU1 4
ASGNU1
line 3028
;3028:			cgs.clientinfo[cg.clientNum].colors[4][3] = g_color_table[color][3] * 255;
ADDRLP4 104
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+12
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 108
CNSTF4 1325400064
ASGNF4
ADDRLP4 104
INDIRF4
ADDRLP4 108
INDIRF4
LTF4 $1672
ADDRLP4 100
ADDRLP4 104
INDIRF4
ADDRLP4 108
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1673
JUMPV
LABELV $1672
ADDRLP4 100
ADDRLP4 104
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1673
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+92+16+3
ADDP4
ADDRLP4 100
INDIRU4
CVUU1 4
ASGNU1
line 3030
;3029:
;3030:		} else if ( strLen == 3 ) {
ADDRGP4 $1601
JUMPV
LABELV $1608
ADDRFP4 8
INDIRI4
CNSTI4 3
NEI4 $1674
line 3032
;3031:			//Set head/body/legs
;3032:			for ( i = 0; i < 3; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1676
line 3033
;3033:				color = ColorIndex(colorString[i]);
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 3034
;3034:				cgs.clientinfo[cg.clientNum].colors[i+1][0] = g_color_table[color][0] * 255;
ADDRLP4 16
CNSTI4 4
ASGNI4
ADDRLP4 20
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
ADDRLP4 16
INDIRI4
LSHI4
ADDRGP4 g_color_table
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 24
CNSTF4 1325400064
ASGNF4
ADDRLP4 20
INDIRF4
ADDRLP4 24
INDIRF4
LTF4 $1684
ADDRLP4 12
ADDRLP4 20
INDIRF4
ADDRLP4 24
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1685
JUMPV
LABELV $1684
ADDRLP4 12
ADDRLP4 20
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1685
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRI4
ADDI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+92
ADDP4
ADDP4
ADDRLP4 12
INDIRU4
CVUU1 4
ASGNU1
line 3035
;3035:				cgs.clientinfo[cg.clientNum].colors[i+1][1] = g_color_table[color][1] * 255;
ADDRLP4 32
CNSTI4 4
ASGNI4
ADDRLP4 36
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
ADDRLP4 32
INDIRI4
LSHI4
ADDRGP4 g_color_table+4
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 40
CNSTF4 1325400064
ASGNF4
ADDRLP4 36
INDIRF4
ADDRLP4 40
INDIRF4
LTF4 $1691
ADDRLP4 28
ADDRLP4 36
INDIRF4
ADDRLP4 40
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1692
JUMPV
LABELV $1691
ADDRLP4 28
ADDRLP4 36
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1692
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
INDIRI4
ADDI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+92
ADDP4
ADDP4
CNSTI4 1
ADDP4
ADDRLP4 28
INDIRU4
CVUU1 4
ASGNU1
line 3036
;3036:				cgs.clientinfo[cg.clientNum].colors[i+1][2] = g_color_table[color][2] * 255;
ADDRLP4 48
CNSTI4 4
ASGNI4
ADDRLP4 52
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
ADDRLP4 48
INDIRI4
LSHI4
ADDRGP4 g_color_table+8
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 56
CNSTF4 1325400064
ASGNF4
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
LTF4 $1698
ADDRLP4 44
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1699
JUMPV
LABELV $1698
ADDRLP4 44
ADDRLP4 52
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1699
ADDRLP4 60
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 60
INDIRI4
LSHI4
ADDRLP4 48
INDIRI4
ADDI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+92
ADDP4
ADDP4
ADDRLP4 60
INDIRI4
ADDP4
ADDRLP4 44
INDIRU4
CVUU1 4
ASGNU1
line 3037
;3037:				cgs.clientinfo[cg.clientNum].colors[i+1][3] = g_color_table[color][3] * 255;
ADDRLP4 68
CNSTI4 4
ASGNI4
ADDRLP4 72
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
ADDRLP4 68
INDIRI4
LSHI4
ADDRGP4 g_color_table+12
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 76
CNSTF4 1325400064
ASGNF4
ADDRLP4 72
INDIRF4
ADDRLP4 76
INDIRF4
LTF4 $1705
ADDRLP4 64
ADDRLP4 72
INDIRF4
ADDRLP4 76
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1706
JUMPV
LABELV $1705
ADDRLP4 64
ADDRLP4 72
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1706
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
INDIRI4
ADDI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+92
ADDP4
ADDP4
CNSTI4 3
ADDP4
ADDRLP4 64
INDIRU4
CVUU1 4
ASGNU1
line 3038
;3038:			}
LABELV $1677
line 3032
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $1676
line 3039
;3039:		} else if ( strLen == 4 ) {
ADDRGP4 $1601
JUMPV
LABELV $1674
ADDRFP4 8
INDIRI4
CNSTI4 4
NEI4 $1707
line 3041
;3040:			//Set color1/head/body/legs
;3041:			for ( i = 0; i < 4; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1709
line 3042
;3042:				color = ColorIndex(colorString[i]);
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 3043
;3043:				cgs.clientinfo[cg.clientNum].colors[i][0] = g_color_table[color][0] * 255;
ADDRLP4 16
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 20
CNSTF4 1325400064
ASGNF4
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
LTF4 $1717
ADDRLP4 12
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1718
JUMPV
LABELV $1717
ADDRLP4 12
ADDRLP4 16
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1718
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+92
ADDP4
ADDP4
ADDRLP4 12
INDIRU4
CVUU1 4
ASGNU1
line 3044
;3044:				cgs.clientinfo[cg.clientNum].colors[i][1] = g_color_table[color][1] * 255;
ADDRLP4 28
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+4
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 32
CNSTF4 1325400064
ASGNF4
ADDRLP4 28
INDIRF4
ADDRLP4 32
INDIRF4
LTF4 $1724
ADDRLP4 24
ADDRLP4 28
INDIRF4
ADDRLP4 32
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1725
JUMPV
LABELV $1724
ADDRLP4 24
ADDRLP4 28
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1725
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+92
ADDP4
ADDP4
CNSTI4 1
ADDP4
ADDRLP4 24
INDIRU4
CVUU1 4
ASGNU1
line 3045
;3045:				cgs.clientinfo[cg.clientNum].colors[i][2] = g_color_table[color][2] * 255;
ADDRLP4 40
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+8
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 44
CNSTF4 1325400064
ASGNF4
ADDRLP4 40
INDIRF4
ADDRLP4 44
INDIRF4
LTF4 $1731
ADDRLP4 36
ADDRLP4 40
INDIRF4
ADDRLP4 44
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1732
JUMPV
LABELV $1731
ADDRLP4 36
ADDRLP4 40
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1732
ADDRLP4 48
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 48
INDIRI4
LSHI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+92
ADDP4
ADDP4
ADDRLP4 48
INDIRI4
ADDP4
ADDRLP4 36
INDIRU4
CVUU1 4
ASGNU1
line 3046
;3046:				cgs.clientinfo[cg.clientNum].colors[i][3] = g_color_table[color][3] * 255;
ADDRLP4 56
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+12
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 60
CNSTF4 1325400064
ASGNF4
ADDRLP4 56
INDIRF4
ADDRLP4 60
INDIRF4
LTF4 $1738
ADDRLP4 52
ADDRLP4 56
INDIRF4
ADDRLP4 60
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1739
JUMPV
LABELV $1738
ADDRLP4 52
ADDRLP4 56
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1739
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+92
ADDP4
ADDP4
CNSTI4 3
ADDP4
ADDRLP4 52
INDIRU4
CVUU1 4
ASGNU1
line 3047
;3047:			}
LABELV $1710
line 3041
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $1709
line 3048
;3048:		} else if ( strLen == 5 ) {
ADDRGP4 $1601
JUMPV
LABELV $1707
ADDRFP4 8
INDIRI4
CNSTI4 5
NEI4 $1601
line 3050
;3049:			//Set color1/head/body/legs/color2
;3050:			for ( i = 0; i < 5; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1742
line 3051
;3051:				color = ColorIndex(colorString[i]);
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 3052
;3052:				cgs.clientinfo[cg.clientNum].colors[i][0] = g_color_table[color][0] * 255;
ADDRLP4 16
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 20
CNSTF4 1325400064
ASGNF4
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
LTF4 $1750
ADDRLP4 12
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1751
JUMPV
LABELV $1750
ADDRLP4 12
ADDRLP4 16
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1751
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+92
ADDP4
ADDP4
ADDRLP4 12
INDIRU4
CVUU1 4
ASGNU1
line 3053
;3053:				cgs.clientinfo[cg.clientNum].colors[i][1] = g_color_table[color][1] * 255;
ADDRLP4 28
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+4
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 32
CNSTF4 1325400064
ASGNF4
ADDRLP4 28
INDIRF4
ADDRLP4 32
INDIRF4
LTF4 $1757
ADDRLP4 24
ADDRLP4 28
INDIRF4
ADDRLP4 32
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1758
JUMPV
LABELV $1757
ADDRLP4 24
ADDRLP4 28
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1758
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+92
ADDP4
ADDP4
CNSTI4 1
ADDP4
ADDRLP4 24
INDIRU4
CVUU1 4
ASGNU1
line 3054
;3054:				cgs.clientinfo[cg.clientNum].colors[i][2] = g_color_table[color][2] * 255;
ADDRLP4 40
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+8
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 44
CNSTF4 1325400064
ASGNF4
ADDRLP4 40
INDIRF4
ADDRLP4 44
INDIRF4
LTF4 $1764
ADDRLP4 36
ADDRLP4 40
INDIRF4
ADDRLP4 44
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1765
JUMPV
LABELV $1764
ADDRLP4 36
ADDRLP4 40
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1765
ADDRLP4 48
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 48
INDIRI4
LSHI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+92
ADDP4
ADDP4
ADDRLP4 48
INDIRI4
ADDP4
ADDRLP4 36
INDIRU4
CVUU1 4
ASGNU1
line 3055
;3055:				cgs.clientinfo[cg.clientNum].colors[i][3] = g_color_table[color][3] * 255;
ADDRLP4 56
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+12
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 60
CNSTF4 1325400064
ASGNF4
ADDRLP4 56
INDIRF4
ADDRLP4 60
INDIRF4
LTF4 $1771
ADDRLP4 52
ADDRLP4 56
INDIRF4
ADDRLP4 60
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1772
JUMPV
LABELV $1771
ADDRLP4 52
ADDRLP4 56
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1772
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+92
ADDP4
ADDP4
CNSTI4 3
ADDP4
ADDRLP4 52
INDIRU4
CVUU1 4
ASGNU1
line 3056
;3056:			}
LABELV $1743
line 3050
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 5
LTI4 $1742
line 3057
;3057:		}
line 3058
;3058:	} else if ( ColorSet == ENEMY_COLORS ) {
ADDRGP4 $1601
JUMPV
LABELV $1600
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $1773
line 3059
;3059:		memset( &cgs.enemyColors, 0, sizeof(&cgs.enemyColors));
ADDRGP4 cgs+157820
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 3060
;3060:		if ( strLen == 2 ) {
ADDRFP4 8
INDIRI4
CNSTI4 2
NEI4 $1777
line 3064
;3061:			//Set rail colors
;3062:
;3063:			//Color1
;3064:			color = ColorIndex(colorString[0]);
ADDRFP4 4
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 3065
;3065:			cgs.enemyColors[0][0] = g_color_table[color][0] * 255;
ADDRLP4 16
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 20
CNSTF4 1325400064
ASGNF4
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
LTF4 $1781
ADDRLP4 12
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1782
JUMPV
LABELV $1781
ADDRLP4 12
ADDRLP4 16
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1782
ADDRGP4 cgs+157820
ADDRLP4 12
INDIRU4
CVUU1 4
ASGNU1
line 3066
;3066:			cgs.enemyColors[0][1] = g_color_table[color][1] * 255;
ADDRLP4 28
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+4
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 32
CNSTF4 1325400064
ASGNF4
ADDRLP4 28
INDIRF4
ADDRLP4 32
INDIRF4
LTF4 $1787
ADDRLP4 24
ADDRLP4 28
INDIRF4
ADDRLP4 32
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1788
JUMPV
LABELV $1787
ADDRLP4 24
ADDRLP4 28
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1788
ADDRGP4 cgs+157820+1
ADDRLP4 24
INDIRU4
CVUU1 4
ASGNU1
line 3067
;3067:			cgs.enemyColors[0][2] = g_color_table[color][2] * 255;
ADDRLP4 40
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+8
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 44
CNSTF4 1325400064
ASGNF4
ADDRLP4 40
INDIRF4
ADDRLP4 44
INDIRF4
LTF4 $1793
ADDRLP4 36
ADDRLP4 40
INDIRF4
ADDRLP4 44
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1794
JUMPV
LABELV $1793
ADDRLP4 36
ADDRLP4 40
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1794
ADDRGP4 cgs+157820+2
ADDRLP4 36
INDIRU4
CVUU1 4
ASGNU1
line 3068
;3068:			cgs.enemyColors[0][3] = g_color_table[color][3] * 255;
ADDRLP4 52
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+12
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 56
CNSTF4 1325400064
ASGNF4
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
LTF4 $1799
ADDRLP4 48
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1800
JUMPV
LABELV $1799
ADDRLP4 48
ADDRLP4 52
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1800
ADDRGP4 cgs+157820+3
ADDRLP4 48
INDIRU4
CVUU1 4
ASGNU1
line 3071
;3069:
;3070:			//Color2
;3071:			color = ColorIndex(colorString[4]);
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 60
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 60
INDIRI4
ASGNI4
line 3072
;3072:			cgs.enemyColors[4][0] = g_color_table[color][0] * 255;
ADDRLP4 68
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 72
CNSTF4 1325400064
ASGNF4
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
LTF4 $1804
ADDRLP4 64
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1805
JUMPV
LABELV $1804
ADDRLP4 64
ADDRLP4 68
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1805
ADDRGP4 cgs+157820+16
ADDRLP4 64
INDIRU4
CVUU1 4
ASGNU1
line 3073
;3073:			cgs.enemyColors[4][1] = g_color_table[color][1] * 255;
ADDRLP4 80
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+4
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 84
CNSTF4 1325400064
ASGNF4
ADDRLP4 80
INDIRF4
ADDRLP4 84
INDIRF4
LTF4 $1811
ADDRLP4 76
ADDRLP4 80
INDIRF4
ADDRLP4 84
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1812
JUMPV
LABELV $1811
ADDRLP4 76
ADDRLP4 80
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1812
ADDRGP4 cgs+157820+16+1
ADDRLP4 76
INDIRU4
CVUU1 4
ASGNU1
line 3074
;3074:			cgs.enemyColors[4][2] = g_color_table[color][2] * 255;
ADDRLP4 92
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+8
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 96
CNSTF4 1325400064
ASGNF4
ADDRLP4 92
INDIRF4
ADDRLP4 96
INDIRF4
LTF4 $1818
ADDRLP4 88
ADDRLP4 92
INDIRF4
ADDRLP4 96
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1819
JUMPV
LABELV $1818
ADDRLP4 88
ADDRLP4 92
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1819
ADDRGP4 cgs+157820+16+2
ADDRLP4 88
INDIRU4
CVUU1 4
ASGNU1
line 3075
;3075:			cgs.enemyColors[4][3] = g_color_table[color][3] * 255;
ADDRLP4 104
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+12
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 108
CNSTF4 1325400064
ASGNF4
ADDRLP4 104
INDIRF4
ADDRLP4 108
INDIRF4
LTF4 $1825
ADDRLP4 100
ADDRLP4 104
INDIRF4
ADDRLP4 108
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1826
JUMPV
LABELV $1825
ADDRLP4 100
ADDRLP4 104
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1826
ADDRGP4 cgs+157820+16+3
ADDRLP4 100
INDIRU4
CVUU1 4
ASGNU1
line 3077
;3076:
;3077:		} else if ( strLen == 3 ) {
ADDRGP4 $1774
JUMPV
LABELV $1777
ADDRFP4 8
INDIRI4
CNSTI4 3
NEI4 $1827
line 3079
;3078:			//Set head/body/legs
;3079:			for ( i = 0; i < 3; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1829
line 3080
;3080:				color = ColorIndex(colorString[i]);
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 3081
;3081:				cgs.enemyColors[i+1][0] = g_color_table[color][0] * 255;
ADDRLP4 16
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 20
CNSTF4 1325400064
ASGNF4
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
LTF4 $1836
ADDRLP4 12
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1837
JUMPV
LABELV $1836
ADDRLP4 12
ADDRLP4 16
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1837
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+157820+4
ADDP4
ADDRLP4 12
INDIRU4
CVUU1 4
ASGNU1
line 3082
;3082:				cgs.enemyColors[i+1][1] = g_color_table[color][1] * 255;
ADDRLP4 28
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+4
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 32
CNSTF4 1325400064
ASGNF4
ADDRLP4 28
INDIRF4
ADDRLP4 32
INDIRF4
LTF4 $1843
ADDRLP4 24
ADDRLP4 28
INDIRF4
ADDRLP4 32
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1844
JUMPV
LABELV $1843
ADDRLP4 24
ADDRLP4 28
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1844
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+157820+4+1
ADDP4
ADDRLP4 24
INDIRU4
CVUU1 4
ASGNU1
line 3083
;3083:				cgs.enemyColors[i+1][2] = g_color_table[color][2] * 255;
ADDRLP4 40
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+8
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 44
CNSTF4 1325400064
ASGNF4
ADDRLP4 40
INDIRF4
ADDRLP4 44
INDIRF4
LTF4 $1850
ADDRLP4 36
ADDRLP4 40
INDIRF4
ADDRLP4 44
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1851
JUMPV
LABELV $1850
ADDRLP4 36
ADDRLP4 40
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1851
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+157820+4+2
ADDP4
ADDRLP4 36
INDIRU4
CVUU1 4
ASGNU1
line 3084
;3084:				cgs.enemyColors[i+1][3] = g_color_table[color][3] * 255;
ADDRLP4 52
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+12
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 56
CNSTF4 1325400064
ASGNF4
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
LTF4 $1857
ADDRLP4 48
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1858
JUMPV
LABELV $1857
ADDRLP4 48
ADDRLP4 52
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1858
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+157820+4+3
ADDP4
ADDRLP4 48
INDIRU4
CVUU1 4
ASGNU1
line 3085
;3085:			}
LABELV $1830
line 3079
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $1829
line 3086
;3086:		} else if ( strLen == 4 ) {
ADDRGP4 $1774
JUMPV
LABELV $1827
ADDRFP4 8
INDIRI4
CNSTI4 4
NEI4 $1859
line 3088
;3087:			//Set color1/head/body/legs
;3088:			for ( i = 0; i < 4; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1861
line 3089
;3089:				color = ColorIndex(colorString[i]);
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 3090
;3090:				cgs.enemyColors[i][0] = g_color_table[color][0] * 255;
ADDRLP4 16
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 20
CNSTF4 1325400064
ASGNF4
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
LTF4 $1867
ADDRLP4 12
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1868
JUMPV
LABELV $1867
ADDRLP4 12
ADDRLP4 16
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1868
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+157820
ADDP4
ADDRLP4 12
INDIRU4
CVUU1 4
ASGNU1
line 3091
;3091:				cgs.enemyColors[i][1] = g_color_table[color][1] * 255;
ADDRLP4 28
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+4
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 32
CNSTF4 1325400064
ASGNF4
ADDRLP4 28
INDIRF4
ADDRLP4 32
INDIRF4
LTF4 $1873
ADDRLP4 24
ADDRLP4 28
INDIRF4
ADDRLP4 32
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1874
JUMPV
LABELV $1873
ADDRLP4 24
ADDRLP4 28
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1874
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+157820+1
ADDP4
ADDRLP4 24
INDIRU4
CVUU1 4
ASGNU1
line 3092
;3092:				cgs.enemyColors[i][2] = g_color_table[color][2] * 255;
ADDRLP4 40
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+8
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 44
CNSTF4 1325400064
ASGNF4
ADDRLP4 40
INDIRF4
ADDRLP4 44
INDIRF4
LTF4 $1879
ADDRLP4 36
ADDRLP4 40
INDIRF4
ADDRLP4 44
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1880
JUMPV
LABELV $1879
ADDRLP4 36
ADDRLP4 40
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1880
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+157820+2
ADDP4
ADDRLP4 36
INDIRU4
CVUU1 4
ASGNU1
line 3093
;3093:				cgs.enemyColors[i][3] = g_color_table[color][3] * 255;
ADDRLP4 52
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+12
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 56
CNSTF4 1325400064
ASGNF4
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
LTF4 $1885
ADDRLP4 48
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1886
JUMPV
LABELV $1885
ADDRLP4 48
ADDRLP4 52
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1886
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+157820+3
ADDP4
ADDRLP4 48
INDIRU4
CVUU1 4
ASGNU1
line 3094
;3094:			}
LABELV $1862
line 3088
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $1861
line 3095
;3095:		} else if ( strLen == 5 ) {
ADDRGP4 $1774
JUMPV
LABELV $1859
ADDRFP4 8
INDIRI4
CNSTI4 5
NEI4 $1774
line 3097
;3096:			//Set color1/head/body/legs/color2
;3097:			for ( i = 0; i < 5; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1889
line 3098
;3098:				color = ColorIndex(colorString[i]);
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 3099
;3099:				cgs.enemyColors[i][0] = g_color_table[color][0] * 255;
ADDRLP4 16
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 20
CNSTF4 1325400064
ASGNF4
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
LTF4 $1895
ADDRLP4 12
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1896
JUMPV
LABELV $1895
ADDRLP4 12
ADDRLP4 16
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1896
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+157820
ADDP4
ADDRLP4 12
INDIRU4
CVUU1 4
ASGNU1
line 3100
;3100:				cgs.enemyColors[i][1] = g_color_table[color][1] * 255;
ADDRLP4 28
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+4
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 32
CNSTF4 1325400064
ASGNF4
ADDRLP4 28
INDIRF4
ADDRLP4 32
INDIRF4
LTF4 $1901
ADDRLP4 24
ADDRLP4 28
INDIRF4
ADDRLP4 32
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1902
JUMPV
LABELV $1901
ADDRLP4 24
ADDRLP4 28
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1902
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+157820+1
ADDP4
ADDRLP4 24
INDIRU4
CVUU1 4
ASGNU1
line 3101
;3101:				cgs.enemyColors[i][2] = g_color_table[color][2] * 255;
ADDRLP4 40
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+8
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 44
CNSTF4 1325400064
ASGNF4
ADDRLP4 40
INDIRF4
ADDRLP4 44
INDIRF4
LTF4 $1907
ADDRLP4 36
ADDRLP4 40
INDIRF4
ADDRLP4 44
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1908
JUMPV
LABELV $1907
ADDRLP4 36
ADDRLP4 40
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1908
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+157820+2
ADDP4
ADDRLP4 36
INDIRU4
CVUU1 4
ASGNU1
line 3102
;3102:				cgs.enemyColors[i][3] = g_color_table[color][3] * 255;
ADDRLP4 52
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+12
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 56
CNSTF4 1325400064
ASGNF4
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
LTF4 $1913
ADDRLP4 48
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1914
JUMPV
LABELV $1913
ADDRLP4 48
ADDRLP4 52
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1914
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+157820+3
ADDP4
ADDRLP4 48
INDIRU4
CVUU1 4
ASGNU1
line 3103
;3103:			}
LABELV $1890
line 3097
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 5
LTI4 $1889
line 3104
;3104:		}
line 3105
;3105:	} else if ( ColorSet == TEAM_COLORS ) {
ADDRGP4 $1774
JUMPV
LABELV $1773
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $1915
line 3106
;3106:		memset( &cgs.teamColors, 0, sizeof(&cgs.teamColors));
ADDRGP4 cgs+157840
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 3107
;3107:		if ( strLen == 2 ) {
ADDRFP4 8
INDIRI4
CNSTI4 2
NEI4 $1919
line 3111
;3108:			//Set rail colors
;3109:
;3110:			//Color1
;3111:			color = ColorIndex(colorString[0]);
ADDRFP4 4
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 3112
;3112:			cgs.teamColors[0][0] = g_color_table[color][0] * 255;
ADDRLP4 16
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 20
CNSTF4 1325400064
ASGNF4
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
LTF4 $1923
ADDRLP4 12
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1924
JUMPV
LABELV $1923
ADDRLP4 12
ADDRLP4 16
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1924
ADDRGP4 cgs+157840
ADDRLP4 12
INDIRU4
CVUU1 4
ASGNU1
line 3113
;3113:			cgs.teamColors[0][1] = g_color_table[color][1] * 255;
ADDRLP4 28
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+4
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 32
CNSTF4 1325400064
ASGNF4
ADDRLP4 28
INDIRF4
ADDRLP4 32
INDIRF4
LTF4 $1929
ADDRLP4 24
ADDRLP4 28
INDIRF4
ADDRLP4 32
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1930
JUMPV
LABELV $1929
ADDRLP4 24
ADDRLP4 28
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1930
ADDRGP4 cgs+157840+1
ADDRLP4 24
INDIRU4
CVUU1 4
ASGNU1
line 3114
;3114:			cgs.teamColors[0][2] = g_color_table[color][2] * 255;
ADDRLP4 40
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+8
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 44
CNSTF4 1325400064
ASGNF4
ADDRLP4 40
INDIRF4
ADDRLP4 44
INDIRF4
LTF4 $1935
ADDRLP4 36
ADDRLP4 40
INDIRF4
ADDRLP4 44
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1936
JUMPV
LABELV $1935
ADDRLP4 36
ADDRLP4 40
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1936
ADDRGP4 cgs+157840+2
ADDRLP4 36
INDIRU4
CVUU1 4
ASGNU1
line 3115
;3115:			cgs.teamColors[0][3] = g_color_table[color][3] * 255;
ADDRLP4 52
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+12
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 56
CNSTF4 1325400064
ASGNF4
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
LTF4 $1941
ADDRLP4 48
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1942
JUMPV
LABELV $1941
ADDRLP4 48
ADDRLP4 52
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1942
ADDRGP4 cgs+157840+3
ADDRLP4 48
INDIRU4
CVUU1 4
ASGNU1
line 3118
;3116:
;3117:			//Color2
;3118:			color = ColorIndex(colorString[4]);
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 60
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 60
INDIRI4
ASGNI4
line 3119
;3119:			cgs.teamColors[4][0] = g_color_table[color][0] * 255;
ADDRLP4 68
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 72
CNSTF4 1325400064
ASGNF4
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
LTF4 $1946
ADDRLP4 64
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1947
JUMPV
LABELV $1946
ADDRLP4 64
ADDRLP4 68
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1947
ADDRGP4 cgs+157840+16
ADDRLP4 64
INDIRU4
CVUU1 4
ASGNU1
line 3120
;3120:			cgs.teamColors[4][1] = g_color_table[color][1] * 255;
ADDRLP4 80
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+4
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 84
CNSTF4 1325400064
ASGNF4
ADDRLP4 80
INDIRF4
ADDRLP4 84
INDIRF4
LTF4 $1953
ADDRLP4 76
ADDRLP4 80
INDIRF4
ADDRLP4 84
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1954
JUMPV
LABELV $1953
ADDRLP4 76
ADDRLP4 80
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1954
ADDRGP4 cgs+157840+16+1
ADDRLP4 76
INDIRU4
CVUU1 4
ASGNU1
line 3121
;3121:			cgs.teamColors[4][2] = g_color_table[color][2] * 255;
ADDRLP4 92
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+8
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 96
CNSTF4 1325400064
ASGNF4
ADDRLP4 92
INDIRF4
ADDRLP4 96
INDIRF4
LTF4 $1960
ADDRLP4 88
ADDRLP4 92
INDIRF4
ADDRLP4 96
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1961
JUMPV
LABELV $1960
ADDRLP4 88
ADDRLP4 92
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1961
ADDRGP4 cgs+157840+16+2
ADDRLP4 88
INDIRU4
CVUU1 4
ASGNU1
line 3122
;3122:			cgs.teamColors[4][3] = g_color_table[color][3] * 255;
ADDRLP4 104
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+12
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 108
CNSTF4 1325400064
ASGNF4
ADDRLP4 104
INDIRF4
ADDRLP4 108
INDIRF4
LTF4 $1967
ADDRLP4 100
ADDRLP4 104
INDIRF4
ADDRLP4 108
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1968
JUMPV
LABELV $1967
ADDRLP4 100
ADDRLP4 104
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1968
ADDRGP4 cgs+157840+16+3
ADDRLP4 100
INDIRU4
CVUU1 4
ASGNU1
line 3124
;3123:
;3124:		} else if ( strLen == 3 ) {
ADDRGP4 $1920
JUMPV
LABELV $1919
ADDRFP4 8
INDIRI4
CNSTI4 3
NEI4 $1969
line 3126
;3125:			//Set head/body/legs
;3126:			for ( i = 0; i < 3; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1971
line 3127
;3127:				color = ColorIndex(colorString[i]);
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 3128
;3128:				cgs.teamColors[i+1][0] = g_color_table[color][0] * 255;
ADDRLP4 16
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 20
CNSTF4 1325400064
ASGNF4
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
LTF4 $1978
ADDRLP4 12
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1979
JUMPV
LABELV $1978
ADDRLP4 12
ADDRLP4 16
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1979
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+157840+4
ADDP4
ADDRLP4 12
INDIRU4
CVUU1 4
ASGNU1
line 3129
;3129:				cgs.teamColors[i+1][1] = g_color_table[color][1] * 255;
ADDRLP4 28
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+4
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 32
CNSTF4 1325400064
ASGNF4
ADDRLP4 28
INDIRF4
ADDRLP4 32
INDIRF4
LTF4 $1985
ADDRLP4 24
ADDRLP4 28
INDIRF4
ADDRLP4 32
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1986
JUMPV
LABELV $1985
ADDRLP4 24
ADDRLP4 28
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1986
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+157840+4+1
ADDP4
ADDRLP4 24
INDIRU4
CVUU1 4
ASGNU1
line 3130
;3130:				cgs.teamColors[i+1][2] = g_color_table[color][2] * 255;
ADDRLP4 40
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+8
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 44
CNSTF4 1325400064
ASGNF4
ADDRLP4 40
INDIRF4
ADDRLP4 44
INDIRF4
LTF4 $1992
ADDRLP4 36
ADDRLP4 40
INDIRF4
ADDRLP4 44
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1993
JUMPV
LABELV $1992
ADDRLP4 36
ADDRLP4 40
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1993
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+157840+4+2
ADDP4
ADDRLP4 36
INDIRU4
CVUU1 4
ASGNU1
line 3131
;3131:				cgs.teamColors[i+1][3] = g_color_table[color][3] * 255;
ADDRLP4 52
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+12
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 56
CNSTF4 1325400064
ASGNF4
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
LTF4 $1999
ADDRLP4 48
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $2000
JUMPV
LABELV $1999
ADDRLP4 48
ADDRLP4 52
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $2000
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+157840+4+3
ADDP4
ADDRLP4 48
INDIRU4
CVUU1 4
ASGNU1
line 3132
;3132:			}
LABELV $1972
line 3126
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $1971
line 3133
;3133:		} else if ( strLen == 4 ) {
ADDRGP4 $1970
JUMPV
LABELV $1969
ADDRFP4 8
INDIRI4
CNSTI4 4
NEI4 $2001
line 3135
;3134:			//Set color1/head/body/legs
;3135:			for ( i = 0; i < 4; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2003
line 3136
;3136:				color = ColorIndex(colorString[i]);
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 3137
;3137:				cgs.teamColors[i][0] = g_color_table[color][0] * 255;
ADDRLP4 16
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 20
CNSTF4 1325400064
ASGNF4
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
LTF4 $2009
ADDRLP4 12
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $2010
JUMPV
LABELV $2009
ADDRLP4 12
ADDRLP4 16
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $2010
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+157840
ADDP4
ADDRLP4 12
INDIRU4
CVUU1 4
ASGNU1
line 3138
;3138:				cgs.teamColors[i][1] = g_color_table[color][1] * 255;
ADDRLP4 28
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+4
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 32
CNSTF4 1325400064
ASGNF4
ADDRLP4 28
INDIRF4
ADDRLP4 32
INDIRF4
LTF4 $2015
ADDRLP4 24
ADDRLP4 28
INDIRF4
ADDRLP4 32
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $2016
JUMPV
LABELV $2015
ADDRLP4 24
ADDRLP4 28
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $2016
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+157840+1
ADDP4
ADDRLP4 24
INDIRU4
CVUU1 4
ASGNU1
line 3139
;3139:				cgs.teamColors[i][2] = g_color_table[color][2] * 255;
ADDRLP4 40
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+8
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 44
CNSTF4 1325400064
ASGNF4
ADDRLP4 40
INDIRF4
ADDRLP4 44
INDIRF4
LTF4 $2021
ADDRLP4 36
ADDRLP4 40
INDIRF4
ADDRLP4 44
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $2022
JUMPV
LABELV $2021
ADDRLP4 36
ADDRLP4 40
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $2022
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+157840+2
ADDP4
ADDRLP4 36
INDIRU4
CVUU1 4
ASGNU1
line 3140
;3140:				cgs.teamColors[i][3] = g_color_table[color][3] * 255;
ADDRLP4 52
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+12
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 56
CNSTF4 1325400064
ASGNF4
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
LTF4 $2027
ADDRLP4 48
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $2028
JUMPV
LABELV $2027
ADDRLP4 48
ADDRLP4 52
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $2028
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+157840+3
ADDP4
ADDRLP4 48
INDIRU4
CVUU1 4
ASGNU1
line 3141
;3141:			}
LABELV $2004
line 3135
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2003
line 3142
;3142:		} else if ( strLen == 5 ) {
ADDRGP4 $2002
JUMPV
LABELV $2001
ADDRFP4 8
INDIRI4
CNSTI4 5
NEI4 $2029
line 3144
;3143:			//Set color1/head/body/legs/color2
;3144:			for ( i = 0; i < 5; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2031
line 3145
;3145:				color = ColorIndex(colorString[i]);
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 3146
;3146:				cgs.teamColors[i][0] = g_color_table[color][0] * 255;
ADDRLP4 16
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 20
CNSTF4 1325400064
ASGNF4
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
LTF4 $2037
ADDRLP4 12
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $2038
JUMPV
LABELV $2037
ADDRLP4 12
ADDRLP4 16
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $2038
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+157840
ADDP4
ADDRLP4 12
INDIRU4
CVUU1 4
ASGNU1
line 3147
;3147:				cgs.teamColors[i][1] = g_color_table[color][1] * 255;
ADDRLP4 28
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+4
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 32
CNSTF4 1325400064
ASGNF4
ADDRLP4 28
INDIRF4
ADDRLP4 32
INDIRF4
LTF4 $2043
ADDRLP4 24
ADDRLP4 28
INDIRF4
ADDRLP4 32
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $2044
JUMPV
LABELV $2043
ADDRLP4 24
ADDRLP4 28
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $2044
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+157840+1
ADDP4
ADDRLP4 24
INDIRU4
CVUU1 4
ASGNU1
line 3148
;3148:				cgs.teamColors[i][2] = g_color_table[color][2] * 255;
ADDRLP4 40
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+8
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 44
CNSTF4 1325400064
ASGNF4
ADDRLP4 40
INDIRF4
ADDRLP4 44
INDIRF4
LTF4 $2049
ADDRLP4 36
ADDRLP4 40
INDIRF4
ADDRLP4 44
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $2050
JUMPV
LABELV $2049
ADDRLP4 36
ADDRLP4 40
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $2050
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+157840+2
ADDP4
ADDRLP4 36
INDIRU4
CVUU1 4
ASGNU1
line 3149
;3149:				cgs.teamColors[i][3] = g_color_table[color][3] * 255;
ADDRLP4 52
CNSTF4 1132396544
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+12
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 56
CNSTF4 1325400064
ASGNF4
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
LTF4 $2055
ADDRLP4 48
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $2056
JUMPV
LABELV $2055
ADDRLP4 48
ADDRLP4 52
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $2056
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+157840+3
ADDP4
ADDRLP4 48
INDIRU4
CVUU1 4
ASGNU1
line 3150
;3150:			}
LABELV $2032
line 3144
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 5
LTI4 $2031
line 3151
;3151:		}
LABELV $2029
LABELV $2002
LABELV $1970
LABELV $1920
line 3152
;3152:	}
LABELV $1915
LABELV $1774
LABELV $1601
line 3153
;3153:}//Evo:Model:End
LABELV $1599
endproc CG_ParseColors 112 12
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
import CG_PainEvent
import CG_EntityEvent
import CG_PlaceString
import CG_CheckEvents
import CG_PredictPlayerState
import CG_Trace
import CG_PointContents
import CG_BuildSolidList
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
LABELV $1598
byte 1 37
byte 1 105
byte 1 32
byte 1 82
byte 1 101
byte 1 115
byte 1 101
byte 1 116
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 69
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 121
byte 1 97
byte 1 119
byte 1 61
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $1587
byte 1 116
byte 1 97
byte 1 103
byte 1 95
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $1578
byte 1 116
byte 1 97
byte 1 103
byte 1 95
byte 1 116
byte 1 111
byte 1 114
byte 1 115
byte 1 111
byte 1 0
align 1
LABELV $1434
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 78
byte 1 117
byte 1 109
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $975
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 97
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $904
byte 1 67
byte 1 108
byte 1 97
byte 1 109
byte 1 112
byte 1 32
byte 1 108
byte 1 102
byte 1 45
byte 1 62
byte 1 102
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $870
byte 1 65
byte 1 110
byte 1 105
byte 1 109
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $866
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $838
byte 1 77
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 108
byte 1 111
byte 1 119
byte 1 46
byte 1 32
byte 1 32
byte 1 85
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $797
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $770
byte 1 68
byte 1 66
byte 1 71
byte 1 58
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 45
byte 1 32
byte 1 83
byte 1 107
byte 1 105
byte 1 110
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $743
byte 1 104
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $729
byte 1 68
byte 1 66
byte 1 71
byte 1 58
byte 1 70
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 45
byte 1 32
byte 1 83
byte 1 107
byte 1 105
byte 1 110
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $704
byte 1 68
byte 1 66
byte 1 71
byte 1 58
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 45
byte 1 32
byte 1 83
byte 1 107
byte 1 105
byte 1 110
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $676
byte 1 68
byte 1 66
byte 1 71
byte 1 58
byte 1 69
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 45
byte 1 32
byte 1 83
byte 1 107
byte 1 105
byte 1 110
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $667
byte 1 47
byte 1 0
align 1
LABELV $652
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $650
byte 1 103
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $648
byte 1 103
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $646
byte 1 116
byte 1 108
byte 1 0
align 1
LABELV $644
byte 1 116
byte 1 116
byte 1 0
align 1
LABELV $636
byte 1 116
byte 1 0
align 1
LABELV $634
byte 1 108
byte 1 0
align 1
LABELV $632
byte 1 119
byte 1 0
align 1
LABELV $630
byte 1 104
byte 1 99
byte 1 0
align 1
LABELV $628
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $587
byte 1 99
byte 1 49
byte 1 0
align 1
LABELV $586
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $581
byte 1 110
byte 1 0
align 1
LABELV $571
byte 1 67
byte 1 71
byte 1 95
byte 1 83
byte 1 101
byte 1 116
byte 1 68
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 114
byte 1 101
byte 1 100
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $499
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $486
byte 1 116
byte 1 97
byte 1 103
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $481
byte 1 67
byte 1 71
byte 1 95
byte 1 82
byte 1 101
byte 1 103
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 40
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 41
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $475
byte 1 83
byte 1 111
byte 1 109
byte 1 101
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 116
byte 1 101
byte 1 114
byte 1 114
byte 1 105
byte 1 98
byte 1 108
byte 1 121
byte 1 32
byte 1 119
byte 1 114
byte 1 111
byte 1 110
byte 1 103
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 46
byte 1 10
byte 1 32
byte 1 73
byte 1 116
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 33
byte 1 0
align 1
LABELV $472
byte 1 115
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $426
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $423
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $418
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
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $415
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
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
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $412
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $409
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
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $400
byte 1 83
byte 1 116
byte 1 114
byte 1 111
byte 1 103
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $399
byte 1 80
byte 1 97
byte 1 103
byte 1 97
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $398
byte 1 37
byte 1 115
byte 1 47
byte 1 0
align 1
LABELV $395
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
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $378
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $377
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $367
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
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
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 117
byte 1 112
byte 1 112
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $364
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 117
byte 1 112
byte 1 112
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $363
byte 1 49
byte 1 0
align 1
LABELV $360
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
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $354
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
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
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $351
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $348
byte 1 48
byte 1 0
align 1
LABELV $347
byte 1 114
byte 1 95
byte 1 118
byte 1 101
byte 1 114
byte 1 116
byte 1 101
byte 1 120
byte 1 76
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $338
byte 1 72
byte 1 101
byte 1 97
byte 1 100
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 117
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $335
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $332
byte 1 84
byte 1 111
byte 1 114
byte 1 115
byte 1 111
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 117
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $329
byte 1 117
byte 1 112
byte 1 112
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $326
byte 1 76
byte 1 101
byte 1 103
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 117
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $323
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $322
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $298
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $297
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $287
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 47
byte 1 0
align 1
LABELV $276
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
byte 1 47
byte 1 0
align 1
LABELV $266
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $265
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $259
byte 1 112
byte 1 109
byte 1 0
align 1
LABELV $252
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $251
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $241
byte 1 0
align 1
LABELV $240
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $239
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $230
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $205
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $202
byte 1 102
byte 1 105
byte 1 120
byte 1 101
byte 1 100
byte 1 116
byte 1 111
byte 1 114
byte 1 115
byte 1 111
byte 1 0
align 1
LABELV $199
byte 1 102
byte 1 105
byte 1 120
byte 1 101
byte 1 100
byte 1 108
byte 1 101
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $188
byte 1 115
byte 1 101
byte 1 120
byte 1 0
align 1
LABELV $179
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 111
byte 1 102
byte 1 102
byte 1 115
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $176
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 109
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $175
byte 1 101
byte 1 110
byte 1 101
byte 1 114
byte 1 103
byte 1 121
byte 1 0
align 1
LABELV $172
byte 1 109
byte 1 101
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $169
byte 1 102
byte 1 108
byte 1 101
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $166
byte 1 98
byte 1 111
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $162
byte 1 110
byte 1 111
byte 1 114
byte 1 109
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $161
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $156
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $148
byte 1 70
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
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
LABELV $142
byte 1 85
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 99
byte 1 117
byte 1 115
byte 1 116
byte 1 111
byte 1 109
byte 1 32
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $89
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
LABELV $88
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
LABELV $87
byte 1 42
byte 1 100
byte 1 114
byte 1 111
byte 1 119
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $86
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
LABELV $85
byte 1 42
byte 1 102
byte 1 97
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $84
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
LABELV $83
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
LABELV $82
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
LABELV $81
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
LABELV $80
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
LABELV $79
byte 1 42
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $78
byte 1 42
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $77
byte 1 42
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
