export Team_InitGame
code
proc Team_InitGame 4 12
file "../g_team.c"
line 25
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:
;4:#include "g_local.h"
;5:
;6:
;7:typedef struct teamgame_s {
;8:	float			last_flag_capture;
;9:	int				last_capture_team;
;10:	flagStatus_t	redStatus;	// CTF
;11:	flagStatus_t	blueStatus;	// CTF
;12:	flagStatus_t	flagStatus;	// One Flag CTF
;13:	int				redTakenTime;
;14:	int				blueTakenTime;
;15:	int				redObeliskAttackedTime;
;16:	int				blueObeliskAttackedTime;
;17:} teamgame_t;
;18:
;19:teamgame_t teamgame;
;20:
;21:gentity_t	*neutralObelisk;
;22:
;23:void Team_SetFlagStatus( int team, flagStatus_t status );
;24:
;25:void Team_InitGame( void ) {
line 26
;26:	memset(&teamgame, 0, sizeof teamgame);
ADDRGP4 teamgame
ARGP4
CNSTI4 0
ARGI4
CNSTI4 36
ARGI4
ADDRGP4 memset
CALLP4
pop
line 28
;27:
;28:	switch( g_gametype.integer ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
EQI4 $71
ADDRGP4 $69
JUMPV
LABELV $71
line 30
;29:	case GT_CTF:
;30:		teamgame.redStatus = teamgame.blueStatus = -1; // Invalid to force update
ADDRLP4 0
CNSTI4 -1
ASGNI4
ADDRGP4 teamgame+12
ADDRLP4 0
INDIRI4
ASGNI4
ADDRGP4 teamgame+8
ADDRLP4 0
INDIRI4
ASGNI4
line 31
;31:		Team_SetFlagStatus( TEAM_RED, FLAG_ATBASE );
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Team_SetFlagStatus
CALLV
pop
line 32
;32:		Team_SetFlagStatus( TEAM_BLUE, FLAG_ATBASE );
CNSTI4 2
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Team_SetFlagStatus
CALLV
pop
line 33
;33:		break;
line 41
;34:#ifdef MISSIONPACK
;35:	case GT_1FCTF:
;36:		teamgame.flagStatus = -1; // Invalid to force update
;37:		Team_SetFlagStatus( TEAM_FREE, FLAG_ATBASE );
;38:		break;
;39:#endif
;40:	default:
;41:		break;
LABELV $69
line 43
;42:	}
;43:}
LABELV $67
endproc Team_InitGame 4 12
export OtherTeam
proc OtherTeam 0 0
line 45
;44:
;45:int OtherTeam(int team) {
line 46
;46:	if (team==TEAM_RED)
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $75
line 47
;47:		return TEAM_BLUE;
CNSTI4 2
RETI4
ADDRGP4 $74
JUMPV
LABELV $75
line 48
;48:	else if (team==TEAM_BLUE)
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $77
line 49
;49:		return TEAM_RED;
CNSTI4 1
RETI4
ADDRGP4 $74
JUMPV
LABELV $77
line 50
;50:	return team;
ADDRFP4 0
INDIRI4
RETI4
LABELV $74
endproc OtherTeam 0 0
export TeamName
proc TeamName 0 0
line 53
;51:}
;52:
;53:const char *TeamName(int team)  {
line 54
;54:	if (team==TEAM_RED)
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $80
line 55
;55:		return "RED";
ADDRGP4 $82
RETP4
ADDRGP4 $79
JUMPV
LABELV $80
line 56
;56:	else if (team==TEAM_BLUE)
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $83
line 57
;57:		return "BLUE";
ADDRGP4 $85
RETP4
ADDRGP4 $79
JUMPV
LABELV $83
line 58
;58:	else if (team==TEAM_SPECTATOR)
ADDRFP4 0
INDIRI4
CNSTI4 3
NEI4 $86
line 59
;59:		return "SPECTATOR";
ADDRGP4 $88
RETP4
ADDRGP4 $79
JUMPV
LABELV $86
line 60
;60:	return "FREE";
ADDRGP4 $89
RETP4
LABELV $79
endproc TeamName 0 0
export OtherTeamName
proc OtherTeamName 0 0
line 63
;61:}
;62:
;63:const char *OtherTeamName(int team) {
line 64
;64:	if (team==TEAM_RED)
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $91
line 65
;65:		return "BLUE";
ADDRGP4 $85
RETP4
ADDRGP4 $90
JUMPV
LABELV $91
line 66
;66:	else if (team==TEAM_BLUE)
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $93
line 67
;67:		return "RED";
ADDRGP4 $82
RETP4
ADDRGP4 $90
JUMPV
LABELV $93
line 68
;68:	else if (team==TEAM_SPECTATOR)
ADDRFP4 0
INDIRI4
CNSTI4 3
NEI4 $95
line 69
;69:		return "SPECTATOR";
ADDRGP4 $88
RETP4
ADDRGP4 $90
JUMPV
LABELV $95
line 70
;70:	return "FREE";
ADDRGP4 $89
RETP4
LABELV $90
endproc OtherTeamName 0 0
export TeamColorString
proc TeamColorString 0 0
line 73
;71:}
;72:
;73:const char *TeamColorString(int team) {
line 74
;74:	if (team==TEAM_RED)
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $98
line 75
;75:		return S_COLOR_RED;
ADDRGP4 $100
RETP4
ADDRGP4 $97
JUMPV
LABELV $98
line 76
;76:	else if (team==TEAM_BLUE)
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $101
line 77
;77:		return S_COLOR_BLUE;
ADDRGP4 $103
RETP4
ADDRGP4 $97
JUMPV
LABELV $101
line 78
;78:	else if (team==TEAM_SPECTATOR)
ADDRFP4 0
INDIRI4
CNSTI4 3
NEI4 $104
line 79
;79:		return S_COLOR_YELLOW;
ADDRGP4 $106
RETP4
ADDRGP4 $97
JUMPV
LABELV $104
line 80
;80:	return S_COLOR_WHITE;
ADDRGP4 $107
RETP4
LABELV $97
endproc TeamColorString 0 0
export PrintMsg
proc PrintMsg 1048 12
line 84
;81:}
;82:
;83:// NULL for everyone
;84:void QDECL PrintMsg( gentity_t *ent, const char *fmt, ... ) {
line 89
;85:	char		msg[1024];
;86:	va_list		argptr;
;87:	char		*p;
;88:	
;89:	va_start (argptr,fmt);
ADDRLP4 1028
ADDRFP4 4+4
ASGNP4
line 90
;90:	if (vsprintf (msg, fmt, argptr) > sizeof(msg)) {
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 1032
ADDRGP4 vsprintf
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CVIU4 4
CNSTU4 1024
LEU4 $110
line 91
;91:		G_Error ( "PrintMsg overrun" );
ADDRGP4 $112
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 92
;92:	}
LABELV $110
line 93
;93:	va_end (argptr);
ADDRLP4 1028
CNSTP4 0
ASGNP4
ADDRGP4 $114
JUMPV
LABELV $113
line 97
;94:
;95:	// double quotes are bad
;96:	while ((p = strchr(msg, '"')) != NULL)
;97:		*p = '\'';
ADDRLP4 0
INDIRP4
CNSTI1 39
ASGNI1
LABELV $114
line 96
ADDRLP4 4
ARGP4
CNSTI4 34
ARGI4
ADDRLP4 1036
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1036
INDIRP4
ASGNP4
ADDRLP4 1036
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $113
line 99
;98:
;99:	trap_SendServerCommand ( ( (ent == NULL) ? -1 : ent-g_entities ), va("print \"%s\"", msg ));
ADDRGP4 $117
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1044
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $118
ADDRLP4 1040
CNSTI4 -1
ASGNI4
ADDRGP4 $119
JUMPV
LABELV $118
ADDRLP4 1040
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 896
DIVI4
ASGNI4
LABELV $119
ADDRLP4 1040
INDIRI4
ARGI4
ADDRLP4 1044
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 100
;100:}
LABELV $108
endproc PrintMsg 1048 12
export AddTeamScore
proc AddTeamScore 16 8
line 110
;101:
;102:/*
;103:==============
;104:AddTeamScore
;105:
;106: used for gametype > GT_TEAM
;107: for gametype GT_TEAM the level.teamScores is updated in AddScore in g_combat.c
;108:==============
;109:*/
;110:void AddTeamScore(vec3_t origin, int team, int score) {
line 113
;111:	gentity_t	*te;
;112:
;113:	te = G_TempEntity(origin, EV_GLOBAL_TEAM_SOUND );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 4
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 114
;114:	te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 116
;115:
;116:	if ( team == TEAM_RED ) {
ADDRFP4 4
INDIRI4
CNSTI4 1
NEI4 $121
line 117
;117:		if ( level.teamScores[ TEAM_RED ] + score == level.teamScores[ TEAM_BLUE ] ) {
ADDRGP4 level+88+4
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
ADDRGP4 level+88+8
INDIRI4
NEI4 $123
line 119
;118:			//teams are tied sound
;119:			te->s.eventParm = GTS_TEAMS_ARE_TIED;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 12
ASGNI4
line 120
;120:		}
ADDRGP4 $122
JUMPV
LABELV $123
line 121
;121:		else if ( level.teamScores[ TEAM_RED ] <= level.teamScores[ TEAM_BLUE ] &&
ADDRGP4 level+88+4
INDIRI4
ADDRGP4 level+88+8
INDIRI4
GTI4 $129
ADDRGP4 level+88+4
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
ADDRGP4 level+88+8
INDIRI4
LEI4 $129
line 122
;122:					level.teamScores[ TEAM_RED ] + score > level.teamScores[ TEAM_BLUE ]) {
line 124
;123:			// red took the lead sound
;124:			te->s.eventParm = GTS_REDTEAM_TOOK_LEAD;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 10
ASGNI4
line 125
;125:		}
ADDRGP4 $122
JUMPV
LABELV $129
line 126
;126:		else {
line 128
;127:			// red scored sound
;128:			te->s.eventParm = GTS_REDTEAM_SCORED;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 8
ASGNI4
line 129
;129:		}
line 130
;130:	}
ADDRGP4 $122
JUMPV
LABELV $121
line 131
;131:	else {
line 132
;132:		if ( level.teamScores[ TEAM_BLUE ] + score == level.teamScores[ TEAM_RED ] ) {
ADDRGP4 level+88+8
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
ADDRGP4 level+88+4
INDIRI4
NEI4 $139
line 134
;133:			//teams are tied sound
;134:			te->s.eventParm = GTS_TEAMS_ARE_TIED;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 12
ASGNI4
line 135
;135:		}
ADDRGP4 $140
JUMPV
LABELV $139
line 136
;136:		else if ( level.teamScores[ TEAM_BLUE ] <= level.teamScores[ TEAM_RED ] &&
ADDRGP4 level+88+8
INDIRI4
ADDRGP4 level+88+4
INDIRI4
GTI4 $145
ADDRGP4 level+88+8
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
ADDRGP4 level+88+4
INDIRI4
LEI4 $145
line 137
;137:					level.teamScores[ TEAM_BLUE ] + score > level.teamScores[ TEAM_RED ]) {
line 139
;138:			// blue took the lead sound
;139:			te->s.eventParm = GTS_BLUETEAM_TOOK_LEAD;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 11
ASGNI4
line 140
;140:		}
ADDRGP4 $146
JUMPV
LABELV $145
line 141
;141:		else {
line 143
;142:			// blue scored sound
;143:			te->s.eventParm = GTS_BLUETEAM_SCORED;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 9
ASGNI4
line 144
;144:		}
LABELV $146
LABELV $140
line 145
;145:	}
LABELV $122
line 146
;146:	level.teamScores[ team ] += score;
ADDRLP4 12
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+88
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
ASGNI4
line 147
;147:}
LABELV $120
endproc AddTeamScore 16 8
export OnSameTeam
proc OnSameTeam 16 0
line 154
;148:
;149:/*
;150:==============
;151:OnSameTeam
;152:==============
;153:*/
;154:qboolean OnSameTeam( gentity_t *ent1, gentity_t *ent2 ) {
line 155
;155:	if ( !ent1->client || !ent2->client ) {
ADDRLP4 0
CNSTI4 516
ASGNI4
ADDRLP4 4
CNSTU4 0
ASGNU4
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRU4
EQU4 $159
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRU4
NEU4 $157
LABELV $159
line 156
;156:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $156
JUMPV
LABELV $157
line 159
;157:	}
;158:
;159:	if ( g_gametype.integer < GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
GEI4 $160
line 160
;160:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $156
JUMPV
LABELV $160
line 163
;161:	}
;162:
;163:	if ( ent1->client->sess.sessionTeam == ent2->client->sess.sessionTeam ) {
ADDRLP4 8
CNSTI4 516
ASGNI4
ADDRLP4 12
CNSTI4 10188
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
NEI4 $163
line 164
;164:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $156
JUMPV
LABELV $163
line 167
;165:	}
;166:
;167:	return qfalse;
CNSTI4 0
RETI4
LABELV $156
endproc OnSameTeam 16 0
data
align 1
LABELV ctfFlagStatusRemap
byte 1 48
byte 1 49
byte 1 42
byte 1 42
byte 1 50
byte 1 51
align 1
LABELV oneFlagStatusRemap
byte 1 48
byte 1 49
byte 1 50
byte 1 51
byte 1 52
byte 1 42
export Team_SetFlagStatus
code
proc Team_SetFlagStatus 12 8
line 174
;168:}
;169:
;170:
;171:static char ctfFlagStatusRemap[] = { '0', '1', '*', '*', '2', '3' };
;172:static char oneFlagStatusRemap[] = { '0', '1', '2', '3', '4', '*' };
;173:
;174:void Team_SetFlagStatus( int team, flagStatus_t status ) {
line 175
;175:	qboolean modified = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 177
;176:
;177:	switch( team ) {
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $178
ADDRLP4 4
INDIRI4
CNSTI4 1
EQI4 $168
ADDRLP4 4
INDIRI4
CNSTI4 2
EQI4 $173
ADDRGP4 $166
JUMPV
LABELV $168
line 179
;178:	case TEAM_RED:	// CTF
;179:		if( teamgame.redStatus != status ) {
ADDRGP4 teamgame+8
INDIRI4
ADDRFP4 4
INDIRI4
EQI4 $167
line 180
;180:			teamgame.redStatus = status;
ADDRGP4 teamgame+8
ADDRFP4 4
INDIRI4
ASGNI4
line 181
;181:			modified = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 182
;182:		}
line 183
;183:		break;
ADDRGP4 $167
JUMPV
LABELV $173
line 186
;184:
;185:	case TEAM_BLUE:	// CTF
;186:		if( teamgame.blueStatus != status ) {
ADDRGP4 teamgame+12
INDIRI4
ADDRFP4 4
INDIRI4
EQI4 $167
line 187
;187:			teamgame.blueStatus = status;
ADDRGP4 teamgame+12
ADDRFP4 4
INDIRI4
ASGNI4
line 188
;188:			modified = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 189
;189:		}
line 190
;190:		break;
ADDRGP4 $167
JUMPV
LABELV $178
line 193
;191:
;192:	case TEAM_FREE:	// One Flag CTF
;193:		if( teamgame.flagStatus != status ) {
ADDRGP4 teamgame+16
INDIRI4
ADDRFP4 4
INDIRI4
EQI4 $167
line 194
;194:			teamgame.flagStatus = status;
ADDRGP4 teamgame+16
ADDRFP4 4
INDIRI4
ASGNI4
line 195
;195:			modified = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 196
;196:		}
line 197
;197:		break;
LABELV $166
LABELV $167
line 200
;198:	}
;199:
;200:	if( modified ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $183
line 203
;201:		char st[4];
;202:
;203:		if( g_gametype.integer == GT_CTF ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $185
line 204
;204:			st[0] = ctfFlagStatusRemap[teamgame.redStatus];
ADDRLP4 8
ADDRGP4 teamgame+8
INDIRI4
ADDRGP4 ctfFlagStatusRemap
ADDP4
INDIRI1
ASGNI1
line 205
;205:			st[1] = ctfFlagStatusRemap[teamgame.blueStatus];
ADDRLP4 8+1
ADDRGP4 teamgame+12
INDIRI4
ADDRGP4 ctfFlagStatusRemap
ADDP4
INDIRI1
ASGNI1
line 206
;206:			st[2] = 0;
ADDRLP4 8+2
CNSTI1 0
ASGNI1
line 207
;207:		}
ADDRGP4 $186
JUMPV
LABELV $185
line 208
;208:		else {		// GT_1FCTF
line 209
;209:			st[0] = oneFlagStatusRemap[teamgame.flagStatus];
ADDRLP4 8
ADDRGP4 teamgame+16
INDIRI4
ADDRGP4 oneFlagStatusRemap
ADDP4
INDIRI1
ASGNI1
line 210
;210:			st[1] = 0;
ADDRLP4 8+1
CNSTI1 0
ASGNI1
line 211
;211:		}
LABELV $186
line 213
;212:
;213:		trap_SetConfigstring( CS_FLAGSTATUS, st );
CNSTI4 23
ARGI4
ADDRLP4 8
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 214
;214:	}
LABELV $183
line 215
;215:}
LABELV $165
endproc Team_SetFlagStatus 12 8
export Team_CheckDroppedItem
proc Team_CheckDroppedItem 0 8
line 217
;216:
;217:void Team_CheckDroppedItem( gentity_t *dropped ) {
line 218
;218:	if( dropped->item->giTag == PW_REDFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 7
NEI4 $195
line 219
;219:		Team_SetFlagStatus( TEAM_RED, FLAG_DROPPED );
CNSTI4 1
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 Team_SetFlagStatus
CALLV
pop
line 220
;220:	}
ADDRGP4 $196
JUMPV
LABELV $195
line 221
;221:	else if( dropped->item->giTag == PW_BLUEFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 8
NEI4 $197
line 222
;222:		Team_SetFlagStatus( TEAM_BLUE, FLAG_DROPPED );
CNSTI4 2
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 Team_SetFlagStatus
CALLV
pop
line 223
;223:	}
ADDRGP4 $198
JUMPV
LABELV $197
line 224
;224:	else if( dropped->item->giTag == PW_NEUTRALFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 9
NEI4 $199
line 225
;225:		Team_SetFlagStatus( TEAM_FREE, FLAG_DROPPED );
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 Team_SetFlagStatus
CALLV
pop
line 226
;226:	}
LABELV $199
LABELV $198
LABELV $196
line 227
;227:}
LABELV $194
endproc Team_CheckDroppedItem 0 8
export Team_ForceGesture
proc Team_ForceGesture 12 0
line 234
;228:
;229:/*
;230:================
;231:Team_ForceGesture
;232:================
;233:*/
;234:void Team_ForceGesture(int team) {
line 238
;235:	int i;
;236:	gentity_t *ent;
;237:
;238:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $202
line 239
;239:		ent = &g_entities[i];
ADDRLP4 0
CNSTI4 896
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 240
;240:		if (!ent->inuse)
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $206
line 241
;241:			continue;
ADDRGP4 $203
JUMPV
LABELV $206
line 242
;242:		if (!ent->client)
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $208
line 243
;243:			continue;
ADDRGP4 $203
JUMPV
LABELV $208
line 244
;244:		if (ent->client->sess.sessionTeam != team)
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
EQI4 $210
line 245
;245:			continue;
ADDRGP4 $203
JUMPV
LABELV $210
line 247
;246:		//
;247:		ent->flags |= FL_FORCE_GESTURE;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 32768
BORI4
ASGNI4
line 248
;248:	}
LABELV $203
line 238
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 64
LTI4 $202
line 249
;249:}
LABELV $201
endproc Team_ForceGesture 12 0
export Team_FragBonuses
proc Team_FragBonuses 276 16
line 261
;250:
;251:/*
;252:================
;253:Team_FragBonuses
;254:
;255:Calculate the bonuses for flag defense, flag carrier defense, etc.
;256:Note that bonuses are not cumulative.  You get one, they are in importance
;257:order.
;258:================
;259:*/
;260:void Team_FragBonuses(gentity_t *targ, gentity_t *inflictor, gentity_t *attacker)
;261:{
line 267
;262:	int i;
;263:	gentity_t *ent;
;264:	int flag_pw, enemy_flag_pw;
;265:	int otherteam;
;266:	int tokens;
;267:	gentity_t *flag, *carrier = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 273
;268:	char *c;
;269:	vec3_t v1, v2;
;270:	int team;
;271:
;272:	// no bonus for fragging yourself or team mates
;273:	if (!targ->client || !attacker->client || targ == attacker || OnSameTeam(targ, attacker))
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
CNSTI4 516
ASGNI4
ADDRLP4 72
CNSTU4 0
ASGNU4
ADDRLP4 64
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 72
INDIRU4
EQU4 $217
ADDRLP4 76
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 72
INDIRU4
EQU4 $217
ADDRLP4 64
INDIRP4
CVPU4 4
ADDRLP4 76
INDIRP4
CVPU4 4
EQU4 $217
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
EQI4 $213
LABELV $217
line 274
;274:		return;
ADDRGP4 $212
JUMPV
LABELV $213
line 276
;275:
;276:	team = targ->client->sess.sessionTeam;
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
ASGNI4
line 277
;277:	otherteam = OtherTeam(targ->client->sess.sessionTeam);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
ARGI4
ADDRLP4 84
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 84
INDIRI4
ASGNI4
line 278
;278:	if (otherteam < 0)
ADDRLP4 20
INDIRI4
CNSTI4 0
GEI4 $218
line 279
;279:		return; // whoever died isn't on a team
ADDRGP4 $212
JUMPV
LABELV $218
line 282
;280:
;281:	// same team, if the flag at base, check to he has the enemy flag
;282:	if (team == TEAM_RED) {
ADDRLP4 52
INDIRI4
CNSTI4 1
NEI4 $220
line 283
;283:		flag_pw = PW_REDFLAG;
ADDRLP4 16
CNSTI4 7
ASGNI4
line 284
;284:		enemy_flag_pw = PW_BLUEFLAG;
ADDRLP4 60
CNSTI4 8
ASGNI4
line 285
;285:	} else {
ADDRGP4 $221
JUMPV
LABELV $220
line 286
;286:		flag_pw = PW_BLUEFLAG;
ADDRLP4 16
CNSTI4 8
ASGNI4
line 287
;287:		enemy_flag_pw = PW_REDFLAG;
ADDRLP4 60
CNSTI4 7
ASGNI4
line 288
;288:	}
LABELV $221
line 290
;289:
;290:	if (g_gametype.integer == GT_1FCTF) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 5
NEI4 $222
line 291
;291:		enemy_flag_pw = PW_NEUTRALFLAG;
ADDRLP4 60
CNSTI4 9
ASGNI4
line 292
;292:	} 
LABELV $222
line 295
;293:
;294:	// did the attacker frag the flag carrier?
;295:	tokens = 0;
ADDRLP4 56
CNSTI4 0
ASGNI4
line 301
;296:#ifdef MISSIONPACK
;297:	if( g_gametype.integer == GT_HARVESTER ) {
;298:		tokens = targ->client->ps.generic1;
;299:	}
;300:#endif
;301:	if (targ->client->ps.powerups[enemy_flag_pw]) {
ADDRLP4 60
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $225
line 302
;302:		attacker->client->pers.teamState.lastfraggedcarrier = level.time;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 604
ADDP4
ADDRGP4 level+40
INDIRI4
CVIF4 4
ASGNF4
line 303
;303:		AddScore(attacker, targ->r.currentOrigin, CTF_FRAG_CARRIER_BONUS);
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 304
;304:		attacker->client->pers.teamState.fragcarrier++;
ADDRLP4 88
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 584
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 305
;305:		PrintMsg(NULL, "%s" S_COLOR_WHITE " fragged %s's flag carrier!\n",
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 92
ADDRGP4 TeamName
CALLP4
ASGNP4
CNSTP4 0
ARGP4
ADDRGP4 $228
ARGP4
ADDRLP4 96
CNSTI4 516
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
ARGP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 307
;306:			attacker->client->pers.netname, TeamName(team));
;307:		G_LogPrintf("Kill_Carrier: %i\n", attacker - g_entities);
ADDRGP4 $229
ARGP4
ADDRFP4 8
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 896
DIVI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 311
;308:
;309:		// the target had the flag, clear the hurt carrier
;310:		// field on the other team
;311:		for (i = 0; i < g_maxclients.integer; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $233
JUMPV
LABELV $230
line 312
;312:			ent = g_entities + i;
ADDRLP4 12
CNSTI4 896
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 313
;313:			if (ent->inuse && ent->client->sess.sessionTeam == otherteam)
ADDRLP4 12
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $235
ADDRLP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
NEI4 $235
line 314
;314:				ent->client->pers.teamState.lasthurtcarrier = 0;
ADDRLP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 592
ADDP4
CNSTF4 0
ASGNF4
LABELV $235
line 315
;315:		}
LABELV $231
line 311
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $233
ADDRLP4 0
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $230
line 316
;316:		return;
ADDRGP4 $212
JUMPV
LABELV $225
line 320
;317:	}
;318:
;319:	// did the attacker frag a head carrier? other->client->ps.generic1
;320:	if (tokens) {
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $237
line 321
;321:		attacker->client->pers.teamState.lastfraggedcarrier = level.time;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 604
ADDP4
ADDRGP4 level+40
INDIRI4
CVIF4 4
ASGNF4
line 322
;322:		AddScore(attacker, targ->r.currentOrigin, CTF_FRAG_CARRIER_BONUS * tokens * tokens);
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 56
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 56
INDIRI4
MULI4
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 323
;323:		attacker->client->pers.teamState.fragcarrier++;
ADDRLP4 92
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 584
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 324
;324:		PrintMsg(NULL, "%s" S_COLOR_WHITE " fragged %s's skull carrier!\n",
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 96
ADDRGP4 TeamName
CALLP4
ASGNP4
CNSTP4 0
ARGP4
ADDRGP4 $240
ARGP4
ADDRLP4 100
CNSTI4 516
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 100
INDIRI4
ADDP4
INDIRP4
ADDRLP4 100
INDIRI4
ADDP4
ARGP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 329
;325:			attacker->client->pers.netname, TeamName(team));
;326:
;327:		// the target had the flag, clear the hurt carrier
;328:		// field on the other team
;329:		for (i = 0; i < g_maxclients.integer; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $244
JUMPV
LABELV $241
line 330
;330:			ent = g_entities + i;
ADDRLP4 12
CNSTI4 896
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 331
;331:			if (ent->inuse && ent->client->sess.sessionTeam == otherteam)
ADDRLP4 12
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $246
ADDRLP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
NEI4 $246
line 332
;332:				ent->client->pers.teamState.lasthurtcarrier = 0;
ADDRLP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 592
ADDP4
CNSTF4 0
ASGNF4
LABELV $246
line 333
;333:		}
LABELV $242
line 329
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $244
ADDRLP4 0
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $241
line 334
;334:		return;
ADDRGP4 $212
JUMPV
LABELV $237
line 337
;335:	}
;336:
;337:	if (targ->client->pers.teamState.lasthurtcarrier &&
ADDRLP4 88
CNSTI4 516
ASGNI4
ADDRLP4 92
ADDRFP4 0
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRP4
CNSTI4 592
ADDP4
INDIRF4
ASGNF4
ADDRLP4 92
INDIRF4
CNSTF4 0
EQF4 $248
ADDRGP4 level+40
INDIRI4
CVIF4 4
ADDRLP4 92
INDIRF4
SUBF4
CNSTF4 1174011904
GEF4 $248
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $248
line 339
;338:		level.time - targ->client->pers.teamState.lasthurtcarrier < CTF_CARRIER_DANGER_PROTECT_TIMEOUT &&
;339:		!attacker->client->ps.powerups[flag_pw]) {
line 342
;340:		// attacker is on the same team as the flag carrier and
;341:		// fragged a guy who hurt our flag carrier
;342:		AddScore(attacker, targ->r.currentOrigin, CTF_CARRIER_DANGER_PROTECT_BONUS);
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 343
;343:		G_LogPrintf("Hurt_Carrier_Defend: %i\n", attacker - g_entities);
ADDRGP4 $251
ARGP4
ADDRFP4 8
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 896
DIVI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 345
;344:
;345:		attacker->client->pers.teamState.carrierdefense++;
ADDRLP4 96
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 576
ADDP4
ASGNP4
ADDRLP4 96
INDIRP4
ADDRLP4 96
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 346
;346:		targ->client->pers.teamState.lasthurtcarrier = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 592
ADDP4
CNSTF4 0
ASGNF4
line 348
;347:
;348:		attacker->client->ps.persistant[PERS_DEFEND_COUNT]++;
ADDRLP4 100
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 292
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 349
;349:		team = attacker->client->sess.sessionTeam;
ADDRLP4 52
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
ASGNI4
line 351
;350:		// add the sprite over the player's head
;351:		attacker->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 104
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 352
;352:		attacker->client->ps.eFlags |= EF_AWARD_DEFEND;
ADDRLP4 108
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRI4
CNSTI4 65536
BORI4
ASGNI4
line 353
;353:		attacker->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10344
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 355
;354:
;355:		return;
ADDRGP4 $212
JUMPV
LABELV $248
line 358
;356:	}
;357:
;358:	if (targ->client->pers.teamState.lasthurtcarrier &&
ADDRLP4 96
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 592
ADDP4
INDIRF4
ASGNF4
ADDRLP4 96
INDIRF4
CNSTF4 0
EQF4 $253
ADDRGP4 level+40
INDIRI4
CVIF4 4
ADDRLP4 96
INDIRF4
SUBF4
CNSTF4 1174011904
GEF4 $253
line 359
;359:		level.time - targ->client->pers.teamState.lasthurtcarrier < CTF_CARRIER_DANGER_PROTECT_TIMEOUT) {
line 361
;360:		// attacker is on the same team as the skull carrier and
;361:		AddScore(attacker, targ->r.currentOrigin, CTF_CARRIER_DANGER_PROTECT_BONUS);
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 362
;362:		G_LogPrintf("Hurt_Carrier_Defend: %i\n", attacker - g_entities);
ADDRGP4 $251
ARGP4
ADDRFP4 8
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 896
DIVI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 364
;363:
;364:		attacker->client->pers.teamState.carrierdefense++;
ADDRLP4 100
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 576
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 365
;365:		targ->client->pers.teamState.lasthurtcarrier = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 592
ADDP4
CNSTF4 0
ASGNF4
line 367
;366:
;367:		attacker->client->ps.persistant[PERS_DEFEND_COUNT]++;
ADDRLP4 104
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 292
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 368
;368:		team = attacker->client->sess.sessionTeam;
ADDRLP4 52
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
ASGNI4
line 370
;369:		// add the sprite over the player's head
;370:		attacker->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 108
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 371
;371:		attacker->client->ps.eFlags |= EF_AWARD_DEFEND;
ADDRLP4 112
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRI4
CNSTI4 65536
BORI4
ASGNI4
line 372
;372:		attacker->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10344
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 374
;373:
;374:		return;
ADDRGP4 $212
JUMPV
LABELV $253
line 401
;375:	}
;376:
;377:	// flag and flag carrier area defense bonuses
;378:
;379:	// we have to find the flag and carrier entities
;380:
;381:#ifdef MISSIONPACK	
;382:	if( g_gametype.integer == GT_OBELISK ) {
;383:		// find the team obelisk
;384:		switch (attacker->client->sess.sessionTeam) {
;385:		case TEAM_RED:
;386:			c = "team_redobelisk";
;387:			break;
;388:		case TEAM_BLUE:
;389:			c = "team_blueobelisk";
;390:			break;		
;391:		default:
;392:			return;
;393:		}
;394:		
;395:	} else if (g_gametype.integer == GT_HARVESTER ) {
;396:		// find the center obelisk
;397:		c = "team_neutralobelisk";
;398:	} else {
;399:#endif
;400:	// find the flag
;401:	switch (attacker->client->sess.sessionTeam) {
ADDRLP4 100
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 1
EQI4 $260
ADDRLP4 100
INDIRI4
CNSTI4 2
EQI4 $262
ADDRGP4 $212
JUMPV
LABELV $260
line 403
;402:	case TEAM_RED:
;403:		c = "team_CTF_redflag";
ADDRLP4 24
ADDRGP4 $261
ASGNP4
line 404
;404:		break;
ADDRGP4 $258
JUMPV
LABELV $262
line 406
;405:	case TEAM_BLUE:
;406:		c = "team_CTF_blueflag";
ADDRLP4 24
ADDRGP4 $263
ASGNP4
line 407
;407:		break;		
line 409
;408:	default:
;409:		return;
LABELV $258
line 412
;410:	}
;411:	// find attacker's team's flag carrier
;412:	for (i = 0; i < g_maxclients.integer; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $267
JUMPV
LABELV $264
line 413
;413:		carrier = g_entities + i;
ADDRLP4 4
CNSTI4 896
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 414
;414:		if (carrier->inuse && carrier->client->ps.powerups[flag_pw])
ADDRLP4 112
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
ADDRLP4 112
INDIRI4
EQI4 $269
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ADDRLP4 112
INDIRI4
EQI4 $269
line 415
;415:			break;
ADDRGP4 $266
JUMPV
LABELV $269
line 416
;416:		carrier = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 417
;417:	}
LABELV $265
line 412
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $267
ADDRLP4 0
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $264
LABELV $266
line 421
;418:#ifdef MISSIONPACK
;419:	}
;420:#endif
;421:	flag = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
ADDRGP4 $272
JUMPV
LABELV $271
line 422
;422:	while ((flag = G_Find (flag, FOFS(classname), c)) != NULL) {
line 423
;423:		if (!(flag->flags & FL_DROPPED_ITEM))
ADDRLP4 8
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $274
line 424
;424:			break;
ADDRGP4 $273
JUMPV
LABELV $274
line 425
;425:	}
LABELV $272
line 422
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 108
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 108
INDIRP4
ASGNP4
ADDRLP4 108
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $271
LABELV $273
line 427
;426:
;427:	if (!flag)
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $276
line 428
;428:		return; // can't find attacker's flag
ADDRGP4 $212
JUMPV
LABELV $276
line 433
;429:
;430:	// ok we have the attackers flag and a pointer to the carrier
;431:
;432:	// check to see if we are defending the base's flag
;433:	VectorSubtract(targ->r.currentOrigin, flag->r.currentOrigin, v1);
ADDRLP4 112
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 116
CNSTI4 488
ASGNI4
ADDRLP4 28
ADDRLP4 112
INDIRP4
ADDRLP4 116
INDIRI4
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
ADDRLP4 116
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 124
CNSTI4 492
ASGNI4
ADDRLP4 28+4
ADDRLP4 112
INDIRP4
ADDRLP4 124
INDIRI4
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
ADDRLP4 124
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 128
CNSTI4 496
ASGNI4
ADDRLP4 28+8
ADDRFP4 0
INDIRP4
ADDRLP4 128
INDIRI4
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
ADDRLP4 128
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 434
;434:	VectorSubtract(attacker->r.currentOrigin, flag->r.currentOrigin, v2);
ADDRLP4 132
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 136
CNSTI4 488
ASGNI4
ADDRLP4 40
ADDRLP4 132
INDIRP4
ADDRLP4 136
INDIRI4
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
ADDRLP4 136
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144
CNSTI4 492
ASGNI4
ADDRLP4 40+4
ADDRLP4 132
INDIRP4
ADDRLP4 144
INDIRI4
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
ADDRLP4 144
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 148
CNSTI4 496
ASGNI4
ADDRLP4 40+8
ADDRFP4 8
INDIRP4
ADDRLP4 148
INDIRI4
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
ADDRLP4 148
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 436
;435:
;436:	if ( ( ( VectorLength(v1) < CTF_TARGET_PROTECT_RADIUS &&
ADDRLP4 28
ARGP4
ADDRLP4 152
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 152
INDIRF4
CNSTF4 1148846080
GEF4 $285
ADDRLP4 156
CNSTI4 488
ASGNI4
ADDRLP4 8
INDIRP4
ADDRLP4 156
INDIRI4
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ADDRLP4 156
INDIRI4
ADDP4
ARGP4
ADDRLP4 160
ADDRGP4 trap_InPVS
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
NEI4 $284
LABELV $285
ADDRLP4 40
ARGP4
ADDRLP4 164
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 164
INDIRF4
CNSTF4 1148846080
GEF4 $282
ADDRLP4 168
CNSTI4 488
ASGNI4
ADDRLP4 8
INDIRP4
ADDRLP4 168
INDIRI4
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
ADDRLP4 168
INDIRI4
ADDP4
ARGP4
ADDRLP4 172
ADDRGP4 trap_InPVS
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
EQI4 $282
LABELV $284
ADDRLP4 176
CNSTI4 516
ASGNI4
ADDRLP4 180
CNSTI4 10188
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 176
INDIRI4
ADDP4
INDIRP4
ADDRLP4 180
INDIRI4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 176
INDIRI4
ADDP4
INDIRP4
ADDRLP4 180
INDIRI4
ADDP4
INDIRI4
EQI4 $282
line 440
;437:		trap_InPVS(flag->r.currentOrigin, targ->r.currentOrigin ) ) ||
;438:		( VectorLength(v2) < CTF_TARGET_PROTECT_RADIUS &&
;439:		trap_InPVS(flag->r.currentOrigin, attacker->r.currentOrigin ) ) ) &&
;440:		attacker->client->sess.sessionTeam != targ->client->sess.sessionTeam) {
line 443
;441:
;442:		// we defended the base flag
;443:		AddScore(attacker, targ->r.currentOrigin, CTF_FLAG_DEFENSE_BONUS);
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 444
;444:		attacker->client->pers.teamState.basedefense++;
ADDRLP4 184
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 572
ADDP4
ASGNP4
ADDRLP4 184
INDIRP4
ADDRLP4 184
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 445
;445:		G_LogPrintf("Defend_Flag: %i\n", attacker - g_entities);
ADDRGP4 $286
ARGP4
ADDRFP4 8
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 896
DIVI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 447
;446:
;447:		attacker->client->ps.persistant[PERS_DEFEND_COUNT]++;
ADDRLP4 188
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 292
ADDP4
ASGNP4
ADDRLP4 188
INDIRP4
ADDRLP4 188
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 449
;448:		// add the sprite over the player's head
;449:		attacker->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 192
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 192
INDIRP4
ADDRLP4 192
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 450
;450:		attacker->client->ps.eFlags |= EF_AWARD_DEFEND;
ADDRLP4 196
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 196
INDIRP4
ADDRLP4 196
INDIRP4
INDIRI4
CNSTI4 65536
BORI4
ASGNI4
line 451
;451:		attacker->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10344
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 453
;452:
;453:		return;
ADDRGP4 $212
JUMPV
LABELV $282
line 456
;454:	}
;455:
;456:	if (carrier && carrier != attacker) {
ADDRLP4 184
ADDRLP4 4
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 184
INDIRU4
CNSTU4 0
EQU4 $288
ADDRLP4 184
INDIRU4
ADDRFP4 8
INDIRP4
CVPU4 4
EQU4 $288
line 457
;457:		VectorSubtract(targ->r.currentOrigin, carrier->r.currentOrigin, v1);
ADDRLP4 188
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 192
CNSTI4 488
ASGNI4
ADDRLP4 28
ADDRLP4 188
INDIRP4
ADDRLP4 192
INDIRI4
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
ADDRLP4 192
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 200
CNSTI4 492
ASGNI4
ADDRLP4 28+4
ADDRLP4 188
INDIRP4
ADDRLP4 200
INDIRI4
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
ADDRLP4 200
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 204
CNSTI4 496
ASGNI4
ADDRLP4 28+8
ADDRFP4 0
INDIRP4
ADDRLP4 204
INDIRI4
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
ADDRLP4 204
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 458
;458:		VectorSubtract(attacker->r.currentOrigin, carrier->r.currentOrigin, v1);
ADDRLP4 208
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 212
CNSTI4 488
ASGNI4
ADDRLP4 28
ADDRLP4 208
INDIRP4
ADDRLP4 212
INDIRI4
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
ADDRLP4 212
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 220
CNSTI4 492
ASGNI4
ADDRLP4 28+4
ADDRLP4 208
INDIRP4
ADDRLP4 220
INDIRI4
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
ADDRLP4 220
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 224
CNSTI4 496
ASGNI4
ADDRLP4 28+8
ADDRFP4 8
INDIRP4
ADDRLP4 224
INDIRI4
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
ADDRLP4 224
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 460
;459:
;460:		if ( ( ( VectorLength(v1) < CTF_ATTACKER_PROTECT_RADIUS &&
ADDRLP4 28
ARGP4
ADDRLP4 228
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 228
INDIRF4
CNSTF4 1148846080
GEF4 $297
ADDRLP4 232
CNSTI4 488
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 232
INDIRI4
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ADDRLP4 232
INDIRI4
ADDP4
ARGP4
ADDRLP4 236
ADDRGP4 trap_InPVS
CALLI4
ASGNI4
ADDRLP4 236
INDIRI4
CNSTI4 0
NEI4 $296
LABELV $297
ADDRLP4 40
ARGP4
ADDRLP4 240
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 240
INDIRF4
CNSTF4 1148846080
GEF4 $294
ADDRLP4 244
CNSTI4 488
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 244
INDIRI4
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
ADDRLP4 244
INDIRI4
ADDP4
ARGP4
ADDRLP4 248
ADDRGP4 trap_InPVS
CALLI4
ASGNI4
ADDRLP4 248
INDIRI4
CNSTI4 0
EQI4 $294
LABELV $296
ADDRLP4 252
CNSTI4 516
ASGNI4
ADDRLP4 256
CNSTI4 10188
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 252
INDIRI4
ADDP4
INDIRP4
ADDRLP4 256
INDIRI4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 252
INDIRI4
ADDP4
INDIRP4
ADDRLP4 256
INDIRI4
ADDP4
INDIRI4
EQI4 $294
line 464
;461:			trap_InPVS(carrier->r.currentOrigin, targ->r.currentOrigin ) ) ||
;462:			( VectorLength(v2) < CTF_ATTACKER_PROTECT_RADIUS &&
;463:				trap_InPVS(carrier->r.currentOrigin, attacker->r.currentOrigin ) ) ) &&
;464:			attacker->client->sess.sessionTeam != targ->client->sess.sessionTeam) {
line 465
;465:			AddScore(attacker, targ->r.currentOrigin, CTF_CARRIER_PROTECT_BONUS);
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 466
;466:			attacker->client->pers.teamState.carrierdefense++;
ADDRLP4 260
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 576
ADDP4
ASGNP4
ADDRLP4 260
INDIRP4
ADDRLP4 260
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 468
;467:
;468:			attacker->client->ps.persistant[PERS_DEFEND_COUNT]++;
ADDRLP4 264
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 292
ADDP4
ASGNP4
ADDRLP4 264
INDIRP4
ADDRLP4 264
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 470
;469:			// add the sprite over the player's head
;470:			attacker->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 268
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 268
INDIRP4
ADDRLP4 268
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 471
;471:			attacker->client->ps.eFlags |= EF_AWARD_DEFEND;
ADDRLP4 272
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 272
INDIRP4
ADDRLP4 272
INDIRP4
INDIRI4
CNSTI4 65536
BORI4
ASGNI4
line 472
;472:			attacker->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10344
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 474
;473:
;474:			return;
LABELV $294
line 476
;475:		}
;476:	}
LABELV $288
line 477
;477:}
LABELV $212
endproc Team_FragBonuses 276 16
export Team_CheckHurtCarrier
proc Team_CheckHurtCarrier 36 0
line 488
;478:
;479:/*
;480:================
;481:Team_CheckHurtCarrier
;482:
;483:Check to see if attacker hurt the flag carrier.  Needed when handing out bonuses for assistance to flag
;484:carrier defense.
;485:================
;486:*/
;487:void Team_CheckHurtCarrier(gentity_t *targ, gentity_t *attacker)
;488:{
line 491
;489:	int flag_pw;
;490:
;491:	if (!targ->client || !attacker->client)
ADDRLP4 4
CNSTI4 516
ASGNI4
ADDRLP4 8
CNSTU4 0
ASGNU4
ADDRFP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRU4
EQU4 $302
ADDRFP4 4
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRU4
NEU4 $300
LABELV $302
line 492
;492:		return;
ADDRGP4 $299
JUMPV
LABELV $300
line 494
;493:
;494:	if (targ->client->sess.sessionTeam == TEAM_RED)
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
CNSTI4 1
NEI4 $303
line 495
;495:		flag_pw = PW_BLUEFLAG;
ADDRLP4 0
CNSTI4 8
ASGNI4
ADDRGP4 $304
JUMPV
LABELV $303
line 497
;496:	else
;497:		flag_pw = PW_REDFLAG;
ADDRLP4 0
CNSTI4 7
ASGNI4
LABELV $304
line 500
;498:
;499:	// flags
;500:	if (targ->client->ps.powerups[flag_pw] &&
ADDRLP4 12
CNSTI4 516
ASGNI4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $305
ADDRLP4 20
CNSTI4 10188
ASGNI4
ADDRLP4 16
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
EQI4 $305
line 502
;501:		targ->client->sess.sessionTeam != attacker->client->sess.sessionTeam)
;502:		attacker->client->pers.teamState.lasthurtcarrier = level.time;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 592
ADDP4
ADDRGP4 level+40
INDIRI4
CVIF4 4
ASGNF4
LABELV $305
line 505
;503:
;504:	// skulls
;505:	if (targ->client->ps.generic1 &&
ADDRLP4 24
CNSTI4 516
ASGNI4
ADDRLP4 28
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
CNSTI4 0
EQI4 $308
ADDRLP4 32
CNSTI4 10188
ASGNI4
ADDRLP4 28
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRI4
EQI4 $308
line 507
;506:		targ->client->sess.sessionTeam != attacker->client->sess.sessionTeam)
;507:		attacker->client->pers.teamState.lasthurtcarrier = level.time;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 592
ADDP4
ADDRGP4 level+40
INDIRI4
CVIF4 4
ASGNF4
LABELV $308
line 508
;508:}
LABELV $299
endproc Team_CheckHurtCarrier 36 0
export Team_ResetFlag
proc Team_ResetFlag 20 12
line 511
;509:
;510:
;511:gentity_t *Team_ResetFlag( int team ) {
line 513
;512:	char *c;
;513:	gentity_t *ent, *rent = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 515
;514:
;515:	switch (team) {
ADDRLP4 12
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $316
ADDRLP4 12
INDIRI4
CNSTI4 1
EQI4 $314
ADDRLP4 12
INDIRI4
CNSTI4 2
EQI4 $315
ADDRGP4 $312
JUMPV
LABELV $314
line 517
;516:	case TEAM_RED:
;517:		c = "team_CTF_redflag";
ADDRLP4 4
ADDRGP4 $261
ASGNP4
line 518
;518:		break;
ADDRGP4 $313
JUMPV
LABELV $315
line 520
;519:	case TEAM_BLUE:
;520:		c = "team_CTF_blueflag";
ADDRLP4 4
ADDRGP4 $263
ASGNP4
line 521
;521:		break;
ADDRGP4 $313
JUMPV
LABELV $316
line 523
;522:	case TEAM_FREE:
;523:		c = "team_CTF_neutralflag";
ADDRLP4 4
ADDRGP4 $317
ASGNP4
line 524
;524:		break;
ADDRGP4 $313
JUMPV
LABELV $312
line 526
;525:	default:
;526:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $311
JUMPV
LABELV $313
line 529
;527:	}
;528:
;529:	ent = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
ADDRGP4 $319
JUMPV
LABELV $318
line 530
;530:	while ((ent = G_Find (ent, FOFS(classname), c)) != NULL) {
line 531
;531:		if (ent->flags & FL_DROPPED_ITEM)
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $321
line 532
;532:			G_FreeEntity(ent);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
ADDRGP4 $322
JUMPV
LABELV $321
line 533
;533:		else {
line 534
;534:			rent = ent;
ADDRLP4 8
ADDRLP4 0
INDIRP4
ASGNP4
line 535
;535:			RespawnItem(ent);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 RespawnItem
CALLV
pop
line 536
;536:		}
LABELV $322
line 537
;537:	}
LABELV $319
line 530
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $318
line 540
;538:	
;539:	//level.flag_pickupTime[team] = 0;
;540:	Team_SetFlagStatus( team, FLAG_ATBASE );
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Team_SetFlagStatus
CALLV
pop
line 542
;541:
;542:	return rent;
ADDRLP4 8
INDIRP4
RETP4
LABELV $311
endproc Team_ResetFlag 20 12
export Team_ResetFlags
proc Team_ResetFlags 0 4
line 545
;543:}
;544:
;545:void Team_ResetFlags( void ) {
line 546
;546:	if( g_gametype.integer == GT_CTF ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $324
line 547
;547:		Team_ResetFlag( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 Team_ResetFlag
CALLP4
pop
line 548
;548:		Team_ResetFlag( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 Team_ResetFlag
CALLP4
pop
line 549
;549:	}
LABELV $324
line 555
;550:#ifdef MISSIONPACK
;551:	else if( g_gametype.integer == GT_1FCTF ) {
;552:		Team_ResetFlag( TEAM_FREE );
;553:	}
;554:#endif
;555:}
LABELV $323
endproc Team_ResetFlags 0 4
export Team_ReturnFlagSound
proc Team_ReturnFlagSound 12 8
line 557
;556:
;557:void Team_ReturnFlagSound( gentity_t *ent, int team ) {
line 560
;558:	gentity_t	*te;
;559:
;560:	if (ent == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $328
line 561
;561:		G_Printf ("Warning:  NULL passed to Team_ReturnFlagSound\n");
ADDRGP4 $330
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 562
;562:		return;
ADDRGP4 $327
JUMPV
LABELV $328
line 565
;563:	}
;564:
;565:	te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_TEAM_SOUND );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 4
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 566
;566:	if( team == TEAM_BLUE ) {
ADDRFP4 4
INDIRI4
CNSTI4 2
NEI4 $331
line 567
;567:		te->s.eventParm = GTS_RED_RETURN;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 2
ASGNI4
line 568
;568:	}
ADDRGP4 $332
JUMPV
LABELV $331
line 569
;569:	else {
line 570
;570:		te->s.eventParm = GTS_BLUE_RETURN;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 3
ASGNI4
line 571
;571:	}
LABELV $332
line 572
;572:	te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 573
;573:}
LABELV $327
endproc Team_ReturnFlagSound 12 8
export Team_TakeFlagSound
proc Team_TakeFlagSound 16 8
line 575
;574:
;575:void Team_TakeFlagSound( gentity_t *ent, int team ) {
line 578
;576:	gentity_t	*te;
;577:
;578:	if (ent == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $334
line 579
;579:		G_Printf ("Warning:  NULL passed to Team_TakeFlagSound\n");
ADDRGP4 $336
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 580
;580:		return;
ADDRGP4 $333
JUMPV
LABELV $334
line 585
;581:	}
;582:
;583:	// only play sound when the flag was at the base
;584:	// or not picked up the last 10 seconds
;585:	switch(team) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1
EQI4 $339
ADDRLP4 4
INDIRI4
CNSTI4 2
EQI4 $349
ADDRGP4 $337
JUMPV
LABELV $339
line 587
;586:		case TEAM_RED:
;587:			if( teamgame.blueStatus != FLAG_ATBASE ) {
ADDRGP4 teamgame+12
INDIRI4
CNSTI4 0
EQI4 $340
line 588
;588:				if (teamgame.blueTakenTime > level.time - 10000)
ADDRGP4 teamgame+24
INDIRI4
ADDRGP4 level+40
INDIRI4
CNSTI4 10000
SUBI4
LEI4 $343
line 589
;589:					return;
ADDRGP4 $333
JUMPV
LABELV $343
line 590
;590:			}
LABELV $340
line 591
;591:			teamgame.blueTakenTime = level.time;
ADDRGP4 teamgame+24
ADDRGP4 level+40
INDIRI4
ASGNI4
line 592
;592:			break;
ADDRGP4 $338
JUMPV
LABELV $349
line 595
;593:
;594:		case TEAM_BLUE:	// CTF
;595:			if( teamgame.redStatus != FLAG_ATBASE ) {
ADDRGP4 teamgame+8
INDIRI4
CNSTI4 0
EQI4 $350
line 596
;596:				if (teamgame.redTakenTime > level.time - 10000)
ADDRGP4 teamgame+20
INDIRI4
ADDRGP4 level+40
INDIRI4
CNSTI4 10000
SUBI4
LEI4 $353
line 597
;597:					return;
ADDRGP4 $333
JUMPV
LABELV $353
line 598
;598:			}
LABELV $350
line 599
;599:			teamgame.redTakenTime = level.time;
ADDRGP4 teamgame+20
ADDRGP4 level+40
INDIRI4
ASGNI4
line 600
;600:			break;
LABELV $337
LABELV $338
line 603
;601:	}
;602:
;603:	te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_TEAM_SOUND );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 8
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 604
;604:	if( team == TEAM_BLUE ) {
ADDRFP4 4
INDIRI4
CNSTI4 2
NEI4 $359
line 605
;605:		te->s.eventParm = GTS_RED_TAKEN;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 4
ASGNI4
line 606
;606:	}
ADDRGP4 $360
JUMPV
LABELV $359
line 607
;607:	else {
line 608
;608:		te->s.eventParm = GTS_BLUE_TAKEN;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 5
ASGNI4
line 609
;609:	}
LABELV $360
line 610
;610:	te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 611
;611:}
LABELV $333
endproc Team_TakeFlagSound 16 8
export Team_CaptureFlagSound
proc Team_CaptureFlagSound 12 8
line 613
;612:
;613:void Team_CaptureFlagSound( gentity_t *ent, int team ) {
line 616
;614:	gentity_t	*te;
;615:
;616:	if (ent == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $362
line 617
;617:		G_Printf ("Warning:  NULL passed to Team_CaptureFlagSound\n");
ADDRGP4 $364
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 618
;618:		return;
ADDRGP4 $361
JUMPV
LABELV $362
line 621
;619:	}
;620:
;621:	te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_TEAM_SOUND );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 4
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 622
;622:	if( team == TEAM_BLUE ) {
ADDRFP4 4
INDIRI4
CNSTI4 2
NEI4 $365
line 623
;623:		te->s.eventParm = GTS_BLUE_CAPTURE;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 1
ASGNI4
line 624
;624:	}
ADDRGP4 $366
JUMPV
LABELV $365
line 625
;625:	else {
line 626
;626:		te->s.eventParm = GTS_RED_CAPTURE;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 0
ASGNI4
line 627
;627:	}
LABELV $366
line 628
;628:	te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 629
;629:}
LABELV $361
endproc Team_CaptureFlagSound 12 8
export Team_ReturnFlag
proc Team_ReturnFlag 8 12
line 631
;630:
;631:void Team_ReturnFlag( int team ) {
line 632
;632:	Team_ReturnFlagSound(Team_ResetFlag(team), team);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 Team_ResetFlag
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 Team_ReturnFlagSound
CALLV
pop
line 633
;633:	if( team == TEAM_FREE ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $368
line 634
;634:		PrintMsg(NULL, "The flag has returned!\n" );
CNSTP4 0
ARGP4
ADDRGP4 $370
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 635
;635:	} else {
ADDRGP4 $369
JUMPV
LABELV $368
line 636
;636:		level.flag_pickupTime[team] = 0;
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+9244
ADDP4
CNSTI4 0
ASGNI4
line 637
;637:		PrintMsg(NULL, "The %s flag has returned!\n", TeamName(team));
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 TeamName
CALLP4
ASGNP4
CNSTP4 0
ARGP4
ADDRGP4 $372
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 638
;638:	}
LABELV $369
line 639
;639:}
LABELV $367
endproc Team_ReturnFlag 8 12
export Team_FreeEntity
proc Team_FreeEntity 0 4
line 641
;640:
;641:void Team_FreeEntity( gentity_t *ent ) {
line 642
;642:	if( ent->item->giTag == PW_REDFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 7
NEI4 $374
line 643
;643:		Team_ReturnFlag( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 644
;644:	}
ADDRGP4 $375
JUMPV
LABELV $374
line 645
;645:	else if( ent->item->giTag == PW_BLUEFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 8
NEI4 $376
line 646
;646:		Team_ReturnFlag( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 647
;647:	}
ADDRGP4 $377
JUMPV
LABELV $376
line 648
;648:	else if( ent->item->giTag == PW_NEUTRALFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 9
NEI4 $378
line 649
;649:		Team_ReturnFlag( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 650
;650:	}
LABELV $378
LABELV $377
LABELV $375
line 651
;651:}
LABELV $373
endproc Team_FreeEntity 0 4
export Team_DroppedFlagThink
proc Team_DroppedFlagThink 8 8
line 662
;652:
;653:/*
;654:==============
;655:Team_DroppedFlagThink
;656:
;657:Automatically set in Launch_Item if the item is one of the flags
;658:
;659:Flags are unique in that if they are dropped, the base flag must be respawned when they time out
;660:==============
;661:*/
;662:void Team_DroppedFlagThink(gentity_t *ent) {
line 663
;663:	int		team = TEAM_FREE;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 665
;664:
;665:	if( ent->item->giTag == PW_REDFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 7
NEI4 $381
line 666
;666:		team = TEAM_RED;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 667
;667:	}
ADDRGP4 $382
JUMPV
LABELV $381
line 668
;668:	else if( ent->item->giTag == PW_BLUEFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 8
NEI4 $383
line 669
;669:		team = TEAM_BLUE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 670
;670:	}
ADDRGP4 $384
JUMPV
LABELV $383
line 671
;671:	else if( ent->item->giTag == PW_NEUTRALFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 9
NEI4 $385
line 672
;672:		team = TEAM_FREE;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 673
;673:	}
LABELV $385
LABELV $384
LABELV $382
line 675
;674:
;675:	Team_ReturnFlagSound( Team_ResetFlag( team ), team );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 Team_ResetFlag
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Team_ReturnFlagSound
CALLV
pop
line 677
;676:	// Reset Flag will delete this entity
;677:}
LABELV $380
endproc Team_DroppedFlagThink 8 8
export Team_TouchOurFlag
proc Team_TouchOurFlag 116 24
line 686
;678:
;679:
;680:/*
;681:==============
;682:Team_TouchOurFlag
;683:==============
;684:*/
;685:int Team_TouchOurFlag(gentity_t *ent, gentity_t *other, int team)
;686:{
line 689
;687:	int			i;
;688:	gentity_t	*player;
;689:	gclient_t	*cl = other->client;
ADDRLP4 8
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 694
;690:	int			enemy_flag, team_flag, enemy_team;
;691:	int			counts[TEAM_NUM_TEAMS];
;692:	int			captureTime, captureTimeSec, captureTimeMin;
;693:
;694:	counts[team] = TeamCount(-1, team);
CNSTI4 -1
ARGI4
ADDRLP4 52
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 56
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
ADDRLP4 56
INDIRI4
ASGNI4
line 702
;695:
;696:#ifdef MISSIONPACK
;697:	if(g_gametype.integer == GT_1FCTF)
;698:		enemy_flag = PW_NEUTRALFLAG;
;699:	else
;700:	{
;701:#endif
;702:		if(cl->sess.sessionTeam == TEAM_RED)
ADDRLP4 8
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
CNSTI4 1
NEI4 $388
line 703
;703:		{
line 704
;704:			enemy_flag = PW_BLUEFLAG;
ADDRLP4 20
CNSTI4 8
ASGNI4
line 705
;705:			team_flag = PW_REDFLAG;
ADDRLP4 24
CNSTI4 7
ASGNI4
line 706
;706:			enemy_team = TEAM_BLUE;
ADDRLP4 28
CNSTI4 2
ASGNI4
line 707
;707:		}
ADDRGP4 $389
JUMPV
LABELV $388
line 710
;708:		else
;709://		else if(cl->sess.sessionTeam == TEAM_RED)
;710:		{
line 711
;711:			enemy_flag = PW_REDFLAG;
ADDRLP4 20
CNSTI4 7
ASGNI4
line 712
;712:			team_flag = PW_BLUEFLAG;
ADDRLP4 24
CNSTI4 8
ASGNI4
line 713
;713:			enemy_team = TEAM_RED;
ADDRLP4 28
CNSTI4 1
ASGNI4
line 714
;714:		}
LABELV $389
line 716
;715:
;716:		if(ent->flags & FL_DROPPED_ITEM)
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $390
line 717
;717:		{
line 719
;718:			//flag isn't at home
;719:			if(!cl->ps.powerups[team_flag] && !cl->ps.powerups[enemy_flag])
ADDRLP4 60
CNSTI4 2
ASGNI4
ADDRLP4 64
ADDRLP4 8
INDIRP4
CNSTI4 312
ADDP4
ASGNP4
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRLP4 24
INDIRI4
ADDRLP4 60
INDIRI4
LSHI4
ADDRLP4 64
INDIRP4
ADDP4
INDIRI4
ADDRLP4 68
INDIRI4
NEI4 $392
ADDRLP4 20
INDIRI4
ADDRLP4 60
INDIRI4
LSHI4
ADDRLP4 64
INDIRP4
ADDP4
INDIRI4
ADDRLP4 68
INDIRI4
NEI4 $392
line 720
;720:			{
line 722
;721:				//not holding any flag yet
;722:				if(((g_returnFlag.integer == 2) && (counts[team] >= 2)) || (g_returnFlag.integer == 1))
ADDRLP4 72
CNSTI4 2
ASGNI4
ADDRGP4 g_returnFlag+12
INDIRI4
ADDRLP4 72
INDIRI4
NEI4 $399
ADDRFP4 8
INDIRI4
ADDRLP4 72
INDIRI4
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
ADDRLP4 72
INDIRI4
GEI4 $398
LABELV $399
ADDRGP4 g_returnFlag+12
INDIRI4
CNSTI4 1
NEI4 $394
LABELV $398
line 723
;723:				{
line 725
;724:					//manually return the flag
;725:					if(team == TEAM_RED)
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $400
line 726
;726:						cl->ps.powerups[PW_REDFLAG] = INT_MAX;	//flags never expire
ADDRLP4 8
INDIRP4
CNSTI4 340
ADDP4
CNSTI4 2147483647
ASGNI4
ADDRGP4 $401
JUMPV
LABELV $400
line 728
;727:					else
;728:						cl->ps.powerups[PW_BLUEFLAG] = INT_MAX;	//flags never expire
ADDRLP4 8
INDIRP4
CNSTI4 344
ADDP4
CNSTI4 2147483647
ASGNI4
LABELV $401
line 731
;729:
;730:					//send global sound when your team picks your dropped flag
;731:					if(g_IU_ctf_sounds.integer)
ADDRGP4 g_IU_ctf_sounds+12
INDIRI4
CNSTI4 0
EQI4 $402
line 732
;732:					{
line 734
;733:						gentity_t *te;
;734:						te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_TEAM_SOUND );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 80
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 76
ADDRLP4 80
INDIRP4
ASGNP4
line 735
;735:						te->s.eventParm = GTS_PICKED_UP_DROP_TEAM_FLAG;
ADDRLP4 76
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 14
ASGNI4
line 736
;736:						te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 84
ADDRLP4 76
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 737
;737:					}
LABELV $402
line 739
;738:
;739:					trap_SendServerCommand(-1, va("print \"%s" S_COLOR_WHITE " is returning the %s flag!\n", cl->pers.netname, TeamName(team)));
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 76
ADDRGP4 TeamName
CALLP4
ASGNP4
ADDRGP4 $405
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 516
ADDP4
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 80
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 740
;740:					cl->pers.stats_flags[1]++;					//stats team touches
ADDRLP4 84
ADDRLP4 8
INDIRP4
CNSTI4 10048
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 741
;741:					G_LogPrintf("Flag_Pickup: %i\n", other - g_entities);
ADDRGP4 $406
ARGP4
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 896
DIVI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 744
;742:
;743:					//for monkk's flag sacrifice
;744:					if(g_flagSacrifice.integer != 0)
ADDRGP4 g_flagSacrifice+12
INDIRI4
CNSTI4 0
EQI4 $407
line 745
;745:						other->flagSacData.sacrificeCount = 0;
ADDRFP4 4
INDIRP4
CNSTI4 808
ADDP4
CNSTI4 0
ASGNI4
LABELV $407
line 747
;746:
;747:					Team_SetFlagStatus( team, FLAG_RETURNING );
ADDRFP4 8
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 Team_SetFlagStatus
CALLV
pop
line 750
;748://					G_Printf("Pick up flag for manual returning\n");
;749:
;750:					return -1;
CNSTI4 -1
RETI4
ADDRGP4 $387
JUMPV
LABELV $394
line 753
;751:				}
;752:				else
;753:				{
line 755
;754:					//teleport the flag back home
;755:					cl->pers.stats_flags[1]++;					//stats team touches
ADDRLP4 76
ADDRLP4 8
INDIRP4
CNSTI4 10048
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 756
;756:					cl->pers.stats_flags[3]++;					//stats return
ADDRLP4 80
ADDRLP4 8
INDIRP4
CNSTI4 10056
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 758
;757:
;758:					PrintMsg(NULL, "%s" S_COLOR_WHITE " returned the %s flag!\n", cl->pers.netname, TeamName(team));
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 84
ADDRGP4 TeamName
CALLP4
ASGNP4
CNSTP4 0
ARGP4
ADDRGP4 $410
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 516
ADDP4
ARGP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 759
;759:					cl->ps.powerups[team_flag] = 0;
ADDRLP4 24
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 312
ADDP4
ADDP4
CNSTI4 0
ASGNI4
line 760
;760:					AddScore(other, ent->r.currentOrigin, CTF_RECOVERY_BONUS);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 761
;761:					other->client->pers.teamState.flagrecovery++;
ADDRLP4 88
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 580
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 762
;762:					other->client->pers.teamState.lastreturnedflag = level.time;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 596
ADDP4
ADDRGP4 level+40
INDIRI4
CVIF4 4
ASGNF4
line 765
;763:
;764:					//ResetFlag will remove this entity! We must return zero
;765:					Team_ReturnFlagSound(Team_ResetFlag(team), team);
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 92
ADDRGP4 Team_ResetFlag
CALLP4
ASGNP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Team_ReturnFlagSound
CALLV
pop
line 766
;766:					G_LogPrintf("Flag_Return: %i\n", other - g_entities);
ADDRGP4 $412
ARGP4
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 896
DIVI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 769
;767://					G_Printf("return our flag(Team_ResetFlag)\n");
;768:
;769:					return 0;
CNSTI4 0
RETI4
ADDRGP4 $387
JUMPV
LABELV $392
line 772
;770:				}
;771:			}
;772:			else if((g_returnFlag.integer == 2) && (counts[team] < 2) || (g_returnFlag.integer == 0))
ADDRLP4 72
CNSTI4 2
ASGNI4
ADDRGP4 g_returnFlag+12
INDIRI4
ADDRLP4 72
INDIRI4
NEI4 $418
ADDRFP4 8
INDIRI4
ADDRLP4 72
INDIRI4
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
ADDRLP4 72
INDIRI4
LTI4 $417
LABELV $418
ADDRGP4 g_returnFlag+12
INDIRI4
CNSTI4 0
NEI4 $391
LABELV $417
line 773
;773:			{
line 775
;774:				//teleport the flag back home
;775:				cl->pers.stats_flags[1]++;					//stats team touches
ADDRLP4 76
ADDRLP4 8
INDIRP4
CNSTI4 10048
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 776
;776:				cl->pers.stats_flags[3]++;					//stats return
ADDRLP4 80
ADDRLP4 8
INDIRP4
CNSTI4 10056
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 778
;777:
;778:				PrintMsg(NULL, "%s" S_COLOR_WHITE " returned the %s flag!\n", cl->pers.netname, TeamName(team));
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 84
ADDRGP4 TeamName
CALLP4
ASGNP4
CNSTP4 0
ARGP4
ADDRGP4 $410
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 516
ADDP4
ARGP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 779
;779:				cl->ps.powerups[team_flag] = 0;
ADDRLP4 24
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 312
ADDP4
ADDP4
CNSTI4 0
ASGNI4
line 780
;780:				AddScore(other, ent->r.currentOrigin, CTF_RECOVERY_BONUS);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 781
;781:				other->client->pers.teamState.flagrecovery++;
ADDRLP4 88
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 580
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 782
;782:				other->client->pers.teamState.lastreturnedflag = level.time;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 596
ADDP4
ADDRGP4 level+40
INDIRI4
CVIF4 4
ASGNF4
line 785
;783:
;784:				//ResetFlag will remove this entity! We must return zero
;785:				Team_ReturnFlagSound(Team_ResetFlag(team), team);
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 92
ADDRGP4 Team_ResetFlag
CALLP4
ASGNP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Team_ReturnFlagSound
CALLV
pop
line 786
;786:				G_LogPrintf("Flag_Return: %i\n", other - g_entities);
ADDRGP4 $412
ARGP4
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 896
DIVI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 789
;787://				G_Printf("return our flag(Team_ResetFlag)\n");
;788:
;789:				return 0;
CNSTI4 0
RETI4
ADDRGP4 $387
JUMPV
line 791
;790:			}
;791:		}
LABELV $390
line 792
;792:		else if(cl->ps.powerups[team_flag])
ADDRLP4 24
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $420
line 793
;793:		{
line 795
;794:			//the flag was returned to home manually
;795:			cl->pers.stats_flags[1]++;					//stats team touches
ADDRLP4 60
ADDRLP4 8
INDIRP4
CNSTI4 10048
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 796
;796:			cl->pers.stats_flags[3]++;					//stats return
ADDRLP4 64
ADDRLP4 8
INDIRP4
CNSTI4 10056
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 798
;797:
;798:			PrintMsg(NULL, "%s" S_COLOR_WHITE " returned the %s flag!\n", cl->pers.netname, TeamName(team));
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 68
ADDRGP4 TeamName
CALLP4
ASGNP4
CNSTP4 0
ARGP4
ADDRGP4 $410
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 516
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 799
;799:			cl->ps.powerups[team_flag] = 0;
ADDRLP4 24
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 312
ADDP4
ADDP4
CNSTI4 0
ASGNI4
line 800
;800:			AddScore(other, ent->r.currentOrigin, CTF_RECOVERY_BONUS);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 801
;801:			other->client->pers.teamState.flagrecovery++;
ADDRLP4 72
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 580
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 802
;802:			other->client->pers.teamState.lastreturnedflag = level.time;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 596
ADDP4
ADDRGP4 level+40
INDIRI4
CVIF4 4
ASGNF4
line 805
;803:
;804:			//ResetFlag will remove this entity! We must return zero
;805:			Team_ReturnFlagSound(Team_ResetFlag(team), team);
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 76
ADDRGP4 Team_ResetFlag
CALLP4
ASGNP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Team_ReturnFlagSound
CALLV
pop
line 806
;806:			G_LogPrintf("Flag_Return: %i\n", other - g_entities);
ADDRGP4 $412
ARGP4
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 896
DIVI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 809
;807://			G_Printf("return our flag(Team_ResetFlag)\n");
;808:
;809:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $387
JUMPV
LABELV $420
LABELV $391
line 816
;810:		}
;811:#ifdef MISSIONPACK
;812:	}
;813:#endif
;814:
;815:	//flag is home, if the player has the enemy flag, he's capped
;816:	if(!cl->ps.powerups[enemy_flag])
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $423
line 817
;817:	{
line 821
;818://		G_Printf("no enemy flag\n");
;819://		G_Printf("%i\n", cl->ps.clientNum);
;820://		G_Printf("Team: %i Enemy: %i\n", cl->ps.powerups[team_flag], cl->ps.powerups[enemy_flag]);
;821:		return 0;										//we don't have the flag
CNSTI4 0
RETI4
ADDRGP4 $387
JUMPV
LABELV $423
line 830
;822:	}
;823:
;824:#ifdef MISSIONPACK
;825:	if(g_gametype.integer == GT_1FCTF)
;826:		PrintMsg(NULL, "%s" S_COLOR_WHITE " captured the flag!\n", cl->pers.netname);
;827:	else
;828:	{
;829:#endif
;830:		PrintMsg(NULL, "%s" S_COLOR_WHITE " captured the %s flag!\n", cl->pers.netname, TeamName(OtherTeam(team)));
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRLP4 64
ADDRGP4 TeamName
CALLP4
ASGNP4
CNSTP4 0
ARGP4
ADDRGP4 $425
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 516
ADDP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 831
;831:		captureTime = (level.time - level.flag_pickupTime[enemy_team]);
ADDRLP4 16
ADDRGP4 level+40
INDIRI4
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+9244
ADDP4
INDIRI4
SUBI4
ASGNI4
line 832
;832:		captureTimeSec = captureTime / 1000;
ADDRLP4 12
ADDRLP4 16
INDIRI4
CNSTI4 1000
DIVI4
ASGNI4
line 833
;833:		captureTime -= (captureTimeSec * 1000);
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1000
ADDRLP4 12
INDIRI4
MULI4
SUBI4
ASGNI4
line 834
;834:		if(captureTimeSec > 60)
ADDRLP4 12
INDIRI4
CNSTI4 60
LEI4 $428
line 835
;835:		{
line 836
;836:			captureTimeMin = captureTimeSec / 60;
ADDRLP4 48
ADDRLP4 12
INDIRI4
CNSTI4 60
DIVI4
ASGNI4
line 837
;837:			captureTimeSec -= captureTimeMin * 60;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 60
ADDRLP4 48
INDIRI4
MULI4
SUBI4
ASGNI4
line 838
;838:			PrintMsg(NULL, "" S_COLOR_CYAN "The %s team captured the flag in %i:%i.%i\n", TeamName(team), captureTimeMin, captureTimeSec, captureTime);
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 68
ADDRGP4 TeamName
CALLP4
ASGNP4
CNSTP4 0
ARGP4
ADDRGP4 $430
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 PrintMsg
CALLV
pop
line 839
;839:		}
ADDRGP4 $429
JUMPV
LABELV $428
line 841
;840:		else
;841:			PrintMsg(NULL, "" S_COLOR_CYAN "The %s team captured the flag in %i.%i\n", TeamName(team), captureTimeSec, captureTime);
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 68
ADDRGP4 TeamName
CALLP4
ASGNP4
CNSTP4 0
ARGP4
ADDRGP4 $431
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 PrintMsg
CALLV
pop
LABELV $429
line 847
;842:
;843:#ifdef MISSIONPACK
;844:	}
;845:#endif
;846:
;847:	cl->pers.stats_flags[4] += 1;								//stats captures
ADDRLP4 72
ADDRLP4 8
INDIRP4
CNSTI4 10060
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 851
;848:
;849:	//freeze
;850:	//----------------
;851:	if((g_gamemode.integer > 3) && (g_gametype.integer == GT_CTF))
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $432
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $432
line 852
;852:		team_wins(team);
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 team_wins
CALLV
pop
LABELV $432
line 857
;853:
;854:	//----------------
;855:	//freeze
;856:
;857:	cl->ps.powerups[enemy_flag] = 0;
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 312
ADDP4
ADDP4
CNSTI4 0
ASGNI4
line 859
;858:
;859:	teamgame.last_flag_capture = level.time;
ADDRGP4 teamgame
ADDRGP4 level+40
INDIRI4
CVIF4 4
ASGNF4
line 860
;860:	teamgame.last_capture_team = team;
ADDRGP4 teamgame+4
ADDRFP4 8
INDIRI4
ASGNI4
line 863
;861:
;862:	//increase the team's score
;863:	AddTeamScore(ent->s.pos.trBase, other->client->sess.sessionTeam, 1);
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 AddTeamScore
CALLV
pop
line 864
;864:	Team_ForceGesture(other->client->sess.sessionTeam);
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
ARGI4
ADDRGP4 Team_ForceGesture
CALLV
pop
line 866
;865:
;866:	G_LogPrintf("Flag_Capture: %i\n", other - g_entities);
ADDRGP4 $438
ARGP4
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 896
DIVI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 867
;867:	G_LogPrintf("TeamScore: 1 %i RED\n", level.teamScores[TEAM_RED]);
ADDRGP4 $439
ARGP4
ADDRGP4 level+88+4
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 868
;868:	G_LogPrintf("TeamScore: 2 %i BLUE\n", level.teamScores[TEAM_BLUE]);
ADDRGP4 $442
ARGP4
ADDRGP4 level+88+8
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 870
;869:
;870:	other->client->pers.teamState.captures++;
ADDRLP4 76
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 568
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 873
;871:
;872:	//add the sprite over the player's head
;873:	other->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP);
ADDRLP4 80
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 874
;874:	other->client->ps.eFlags |= EF_AWARD_CAP;
ADDRLP4 84
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 875
;875:	other->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10344
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 876
;876:	other->client->ps.persistant[PERS_CAPTURES]++;
ADDRLP4 88
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 304
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 879
;877:
;878:	//other gets another 10 frag bonus
;879:	AddScore(other, ent->r.currentOrigin, CTF_CAPTURE_BONUS);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 881
;880:
;881:	Team_CaptureFlagSound(ent, team);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Team_CaptureFlagSound
CALLV
pop
line 884
;882:
;883:	//let's do the player loop, hand out the bonuses
;884:	for(i = 0; i < g_maxclients.integer; i++)
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $449
JUMPV
LABELV $446
line 885
;885:	{
line 886
;886:		player = &g_entities[i];
ADDRLP4 0
CNSTI4 896
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 887
;887:		if(!player->inuse)
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $451
line 888
;888:			continue;
ADDRGP4 $447
JUMPV
LABELV $451
line 890
;889:
;890:		if(player->client->sess.sessionTeam != cl->sess.sessionTeam)
ADDRLP4 92
CNSTI4 10188
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRI4
ADDRLP4 8
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRI4
EQI4 $453
line 891
;891:			player->client->pers.teamState.lasthurtcarrier = -5;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 592
ADDP4
CNSTF4 3231711232
ASGNF4
ADDRGP4 $454
JUMPV
LABELV $453
line 892
;892:		else if(player->client->sess.sessionTeam == cl->sess.sessionTeam)
ADDRLP4 96
CNSTI4 10188
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
INDIRI4
ADDRLP4 8
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
INDIRI4
NEI4 $455
line 893
;893:		{
line 894
;894:			if(player != other)
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
EQU4 $457
line 895
;895:				AddScore(player, ent->r.currentOrigin, CTF_TEAM_BONUS);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 AddScore
CALLV
pop
LABELV $457
line 898
;896:
;897:			//award extra points for capture assists
;898:			if((player->client->pers.teamState.lastreturnedflag + CTF_RETURN_FLAG_ASSIST_TIMEOUT) > level.time)
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 596
ADDP4
INDIRF4
CNSTF4 1176256512
ADDF4
ADDRGP4 level+40
INDIRI4
CVIF4 4
LEF4 $459
line 899
;899:			{
line 900
;900:				AddScore(player, ent->r.currentOrigin, CTF_RETURN_FLAG_ASSIST_BONUS);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 901
;901:				other->client->pers.teamState.assists++;
ADDRLP4 100
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 588
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 902
;902:				G_LogPrintf("Flag_Assist_Return: %i\n", other - g_entities);
ADDRGP4 $462
ARGP4
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 896
DIVI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 904
;903:
;904:				player->client->ps.persistant[PERS_ASSIST_COUNT]++;
ADDRLP4 104
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 296
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 907
;905:
;906:				//add the sprite over the player's head
;907:				player->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP);
ADDRLP4 108
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 908
;908:				player->client->ps.eFlags |= EF_AWARD_ASSIST;
ADDRLP4 112
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRI4
CNSTI4 131072
BORI4
ASGNI4
line 909
;909:				player->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10344
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 911
;910:
;911:			}
ADDRGP4 $460
JUMPV
LABELV $459
line 912
;912:			else if (player->client->pers.teamState.lastfraggedcarrier + CTF_FRAG_CARRIER_ASSIST_TIMEOUT > level.time)
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 604
ADDP4
INDIRF4
CNSTF4 1176256512
ADDF4
ADDRGP4 level+40
INDIRI4
CVIF4 4
LEF4 $464
line 913
;913:			{
line 914
;914:				AddScore(player, ent->r.currentOrigin, CTF_FRAG_CARRIER_ASSIST_BONUS);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 915
;915:				other->client->pers.teamState.assists++;
ADDRLP4 100
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 588
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 916
;916:				player->client->ps.persistant[PERS_ASSIST_COUNT]++;
ADDRLP4 104
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 296
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 919
;917:
;918:				//add the sprite over the player's head
;919:				player->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP);
ADDRLP4 108
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 920
;920:				player->client->ps.eFlags |= EF_AWARD_ASSIST;
ADDRLP4 112
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRI4
CNSTI4 131072
BORI4
ASGNI4
line 921
;921:				player->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10344
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 922
;922:			}
LABELV $464
LABELV $460
line 923
;923:		}
LABELV $455
LABELV $454
line 924
;924:	}
LABELV $447
line 884
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $449
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $446
line 926
;925:
;926:	Team_ResetFlags();
ADDRGP4 Team_ResetFlags
CALLV
pop
line 928
;927:
;928:	CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 932
;929:
;930://	G_Printf("Should've captured by now\n");
;931:
;932:	return 0;													//do not respawn this automatically
CNSTI4 0
RETI4
LABELV $387
endproc Team_TouchOurFlag 116 24
export Team_TouchEnemyFlag
proc Team_TouchEnemyFlag 40 16
line 1117
;933:
;934:/*
;935:#ifdef MISSIONPACK
;936:	if( g_gametype.integer == GT_1FCTF ) {
;937:		enemy_flag = PW_NEUTRALFLAG;
;938:	}
;939:	else {
;940:#endif
;941:	if (cl->sess.sessionTeam == TEAM_RED) {
;942:		enemy_flag = PW_BLUEFLAG;
;943:		team_flag = PW_REDFLAG;
;944:		enemy_team = TEAM_BLUE;
;945:	} else {
;946://	} else if ( cl->sess.sessionTeam == TEAM_RED ) {
;947:		enemy_flag = PW_REDFLAG;
;948:		team_flag = PW_BLUEFLAG;
;949:		enemy_team = TEAM_RED;
;950:	}
;951:
;952:	trap_SendServerCommand( -1, va("print \"DBG:TouchOurFlag: clientNum: %i -- team: %i\n\"", other->client->ps.clientNum, team));
;953:	trap_SendServerCommand( -1, va("print \"DBG:TouchOurFlag: enemy: %i -- ourFlag: %i -- theirFlag: %i\n\"", enemy_team, team_flag, enemy_flag));
;954:
;955:	if ((ent->flags & FL_DROPPED_ITEM) && ((g_returnFlag.integer == 2 && counts[team] >= 2 && !other->client->ps.powerups[team_flag]) || (g_returnFlag.integer == 1 && !other->client->ps.powerups[team_flag]))) {
;956:		//Return the flag manually.
;957:		trap_SendServerCommand( -1, va("print \"DBG:Return manually\n\""));
;958:		if (team == TEAM_RED) {
;959:			cl->ps.powerups[PW_REDFLAG] = INT_MAX; // flags never expire
;960:		} else {
;961:			cl->ps.powerups[PW_BLUEFLAG] = INT_MAX; // flags never expire
;962:		}
;963:
;964:		//send  global sound when your team picks your dropped flag
;965:		if ( g_IU_ctf_sounds.integer ) {
;966:			gentity_t	*te;
;967:
;968:			te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_TEAM_SOUND );
;969:			te->s.eventParm = GTS_PICKED_UP_DROP_TEAM_FLAG;
;970:			te->r.svFlags |= SVF_BROADCAST;
;971:		}
;972:		
;973:		trap_SendServerCommand( -1, va("print \"%s" S_COLOR_WHITE " is returning the %s flag!\n", 
;974:			cl->pers.netname, TeamName(team)) );
;975:
;976:		cl->pers.stats_flags[1]++;//Stats team touches
;977:		G_LogPrintf("Flag_Pickup: %i\n", other - g_entities);
;978:		//monkk for flag sacrifice
;979:		if( g_flagSacrifice.integer != 0 )
;980:		{
;981:			other->flagSacData.sacrificeCount = 0;
;982:		}
;983:		//end monkk
;984:		Team_SetFlagStatus( team, FLAG_RETURNING );
;985:		//G_Printf("Pick up flag for manual returning\n");
;986:		return -1;
;987:	} else if ( ent->flags & FL_DROPPED_ITEM || cl->ps.powerups[team_flag] ) {
;988:		trap_SendServerCommand( -1, va("print \"DBG: Auto return\n\""));
;989:		cl->pers.stats_flags[1]++;//Stats team touches
;990:		cl->pers.stats_flags[3]++;//Stats return
;991:		// hey, its not home.  return it by teleporting it back
;992:		PrintMsg( NULL, "%s" S_COLOR_WHITE " returned the %s flag!\n", 
;993:			cl->pers.netname, TeamName(team));
;994:		cl->ps.powerups[team_flag] = 0;
;995:		AddScore(other, ent->r.currentOrigin, CTF_RECOVERY_BONUS);
;996:		other->client->pers.teamState.flagrecovery++;
;997:		other->client->pers.teamState.lastreturnedflag = level.time;
;998:		//ResetFlag will remove this entity!  We must return zero
;999:		Team_ReturnFlagSound(Team_ResetFlag(team), team);
;1000:		G_LogPrintf("Flag_Return: %i\n", other - g_entities);
;1001:		//G_Printf("return our flag(Team_ResetFlag)\n");
;1002:		return 0;
;1003:	} else {
;1004:#ifdef MISSIONPACK
;1005:	}
;1006:#endif
;1007:
;1008:	// the flag is at home base.  if the player has the enemy
;1009:	// flag, he's just won!
;1010:	if (!cl->ps.powerups[enemy_flag]) {
;1011:		//G_Printf("no enemy flag\n");
;1012:		//G_Printf("%i\n", cl->ps.clientNum);
;1013:		//G_Printf("Team: %i Enemy: %i\n", cl->ps.powerups[team_flag], cl->ps.powerups[enemy_flag]);
;1014:		return 0; // We don't have the flag
;1015:	}
;1016:
;1017:#ifdef MISSIONPACK
;1018:	if( g_gametype.integer == GT_1FCTF ) {
;1019:		PrintMsg( NULL, "%s" S_COLOR_WHITE " captured the flag!\n", cl->pers.netname );
;1020:	} else {
;1021:#endif
;1022:
;1023:	PrintMsg( NULL, "%s" S_COLOR_WHITE " captured the %s flag!\n", cl->pers.netname, TeamName(OtherTeam(team)));
;1024:	captureTime = (level.time - level.flag_pickupTime[enemy_team]);
;1025:	captureTimeSec = captureTime / 1000;
;1026:	captureTime -= (captureTimeSec * 1000);
;1027:	if ( captureTimeSec > 60 ) {
;1028:		captureTimeMin = captureTimeSec / 60;
;1029:		captureTimeSec -= captureTimeMin * 60;
;1030:		PrintMsg( NULL, "" S_COLOR_CYAN "The %s team captured the flag in %i:%i.%i\n", TeamName(team), captureTimeMin, captureTimeSec, captureTime);
;1031:	} else {
;1032:		PrintMsg( NULL, "" S_COLOR_CYAN "The %s team captured the flag in %i.%i\n", TeamName(team), captureTimeSec, captureTime);
;1033:	}
;1034:
;1035:#ifdef MISSIONPACK
;1036:	}
;1037:#endif
;1038:	cl->pers.stats_flags[4] += 1;//Stats Captures
;1039://freeze
;1040:	if ( g_gamemode.integer > 3 && g_gametype.integer == GT_CTF ) {
;1041:		team_wins( team );
;1042:	}
;1043://freeze
;1044:	cl->ps.powerups[enemy_flag] = 0;
;1045:
;1046:	teamgame.last_flag_capture = level.time;
;1047:	teamgame.last_capture_team = team;
;1048:
;1049:	// Increase the team's score
;1050:	AddTeamScore(ent->s.pos.trBase, other->client->sess.sessionTeam, 1);
;1051:	Team_ForceGesture(other->client->sess.sessionTeam);
;1052:
;1053:	G_LogPrintf("Flag_Capture: %i\n", other - g_entities);
;1054:	G_LogPrintf("TeamScore: 1 %i RED\n", level.teamScores[ TEAM_RED ]);
;1055:	G_LogPrintf("TeamScore: 2 %i BLUE\n", level.teamScores[ TEAM_BLUE ]);
;1056:
;1057:	other->client->pers.teamState.captures++;
;1058:	// add the sprite over the player's head
;1059:	other->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
;1060:	other->client->ps.eFlags |= EF_AWARD_CAP;
;1061:	other->client->rewardTime = level.time + REWARD_SPRITE_TIME;
;1062:	other->client->ps.persistant[PERS_CAPTURES]++;
;1063:
;1064:	// other gets another 10 frag bonus
;1065:	AddScore(other, ent->r.currentOrigin, CTF_CAPTURE_BONUS);
;1066:
;1067:	Team_CaptureFlagSound( ent, team );
;1068:
;1069:	// Ok, let's do the player loop, hand out the bonuses
;1070:	for (i = 0; i < g_maxclients.integer; i++) {
;1071:		player = &g_entities[i];
;1072:		if (!player->inuse)
;1073:			continue;
;1074:
;1075:		if (player->client->sess.sessionTeam !=
;1076:			cl->sess.sessionTeam) {
;1077:			player->client->pers.teamState.lasthurtcarrier = -5;
;1078:		} else if (player->client->sess.sessionTeam ==
;1079:			cl->sess.sessionTeam) {
;1080:			if (player != other)
;1081:				AddScore(player, ent->r.currentOrigin, CTF_TEAM_BONUS);
;1082:			// award extra points for capture assists
;1083:			if (player->client->pers.teamState.lastreturnedflag + 
;1084:				CTF_RETURN_FLAG_ASSIST_TIMEOUT > level.time) {
;1085:				AddScore (player, ent->r.currentOrigin, CTF_RETURN_FLAG_ASSIST_BONUS);
;1086:				other->client->pers.teamState.assists++;
;1087:				G_LogPrintf("Flag_Assist_Return: %i\n", other - g_entities);
;1088:
;1089:				player->client->ps.persistant[PERS_ASSIST_COUNT]++;
;1090:				// add the sprite over the player's head
;1091:				player->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
;1092:				player->client->ps.eFlags |= EF_AWARD_ASSIST;
;1093:				player->client->rewardTime = level.time + REWARD_SPRITE_TIME;
;1094:
;1095:			} else if (player->client->pers.teamState.lastfraggedcarrier + 
;1096:				CTF_FRAG_CARRIER_ASSIST_TIMEOUT > level.time) {
;1097:				AddScore(player, ent->r.currentOrigin, CTF_FRAG_CARRIER_ASSIST_BONUS);
;1098:				other->client->pers.teamState.assists++;
;1099:				player->client->ps.persistant[PERS_ASSIST_COUNT]++;
;1100:				// add the sprite over the player's head
;1101:				player->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
;1102:				player->client->ps.eFlags |= EF_AWARD_ASSIST;
;1103:				player->client->rewardTime = level.time + REWARD_SPRITE_TIME;
;1104:			}
;1105:		}
;1106:	}
;1107:	Team_ResetFlags();
;1108:
;1109:	CalculateRanks();
;1110:
;1111:	//G_Printf("Should've captured by now\n");
;1112:	return 0; // Do not respawn this automatically
;1113:	}
;1114:*/
;1115:}
;1116:
;1117:int Team_TouchEnemyFlag( gentity_t *ent, gentity_t *other, int team ) {
line 1118
;1118:	gclient_t *cl = other->client;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 1132
;1119:	qboolean		BaseFlag;
;1120:	//int			team_flag, enemy_flag;
;1121:
;1122:	//if (cl->sess.sessionTeam == TEAM_RED) {
;1123:	//	enemy_flag = PW_BLUEFLAG;
;1124:	//	team_flag = PW_REDFLAG;
;1125:	//	enemy_team = TEAM_BLUE;
;1126:	//} else if ( cl->sess.sessionTeam == TEAM_RED ) {
;1127:	//	enemy_flag = PW_REDFLAG;
;1128:	//	team_flag = PW_BLUEFLAG;
;1129:	//	enemy_team = TEAM_RED;
;1130:	//}
;1131:
;1132:	BaseFlag = (ent->s.modelindex2 == 0);
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 0
NEI4 $470
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 $471
JUMPV
LABELV $470
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $471
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 1133
;1133:	if (!(ent->flags & FL_DROPPED_ITEM)) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $472
line 1134
;1134:		level.flag_pickupTime[team] = level.time;
ADDRFP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+9244
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 1135
;1135:	}
LABELV $472
line 1152
;1136:
;1137:#ifdef MISSIONPACK
;1138:	if( g_gametype.integer == GT_1FCTF ) {
;1139:		PrintMsg (NULL, "%s" S_COLOR_WHITE " got the flag!\n", other->client->pers.netname );
;1140:
;1141:		cl->ps.powerups[PW_NEUTRALFLAG] = INT_MAX; // flags never expire
;1142:
;1143:		if( team == TEAM_RED ) {
;1144:			Team_SetFlagStatus( TEAM_FREE, FLAG_TAKEN_RED );
;1145:		}
;1146:		else {
;1147:			Team_SetFlagStatus( TEAM_FREE, FLAG_TAKEN_BLUE );
;1148:		}
;1149:	}
;1150:	else{
;1151:#endif
;1152:		PrintMsg (NULL, "%s" S_COLOR_WHITE " got the %s flag!\n",
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 TeamName
CALLP4
ASGNP4
CNSTP4 0
ARGP4
ADDRGP4 $476
ARGP4
ADDRLP4 16
CNSTI4 516
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 1156
;1153:			other->client->pers.netname, TeamName(team));
;1154:		//cl->ps.powerups[enemy_flag] = INT_MAX;
;1155:
;1156:		if (team == TEAM_RED)
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $477
line 1158
;1157:		//if (team == TEAM_BLUE)
;1158:			cl->ps.powerups[PW_REDFLAG] = INT_MAX; // flags never expire
ADDRLP4 0
INDIRP4
CNSTI4 340
ADDP4
CNSTI4 2147483647
ASGNI4
ADDRGP4 $478
JUMPV
LABELV $477
line 1160
;1159:		else
;1160:			cl->ps.powerups[PW_BLUEFLAG] = INT_MAX; // flags never expire
ADDRLP4 0
INDIRP4
CNSTI4 344
ADDP4
CNSTI4 2147483647
ASGNI4
LABELV $478
line 1162
;1161:
;1162:		Team_SetFlagStatus( team, FLAG_TAKEN );
ADDRFP4 8
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 Team_SetFlagStatus
CALLV
pop
line 1167
;1163:#ifdef MISSIONPACK
;1164:	}
;1165:#endif
;1166:	
;1167:	if( g_flagSacrifice.integer != 0 ) {
ADDRGP4 g_flagSacrifice+12
INDIRI4
CNSTI4 0
EQI4 $479
line 1168
;1168:		other->flagSacData.sacrificeCount = 0;//monkk flag sacrifice
ADDRFP4 4
INDIRP4
CNSTI4 808
ADDP4
CNSTI4 0
ASGNI4
line 1172
;1169:		//set the player's LKG just in case they manage to grab the flag and fly off the map without touching the ground
;1170:		//setting it to the origin of the flag item lest it is in a hard to reach place that encourges further sacrifices
;1171:		//during retrieval
;1172:		VectorCopy(ent->r.currentOrigin, level.playerLastKnownGood[other - g_entities][0]);
CNSTI4 24
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 896
DIVI4
MULI4
ADDRGP4 level+9264
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 1173
;1173:		VectorCopy(ent->r.currentOrigin, level.playerLastKnownGood[other - g_entities][1]);
CNSTI4 24
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 896
DIVI4
MULI4
ADDRGP4 level+9264+12
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 1174
;1174:	}
LABELV $479
line 1178
;1175://	Team_TakeFlagSound( ent, team );
;1176:	//send  global sound when your team picks up your dropped flag
;1177:	//Team_TakeFlagSound( ent, team );
;1178:	cl->pers.stats_flags[2]++;//Stats enemy touches
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 10052
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1180
;1179:
;1180:	AddScore(other, ent->r.currentOrigin, CTF_FLAG_BONUS);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 1181
;1181:	cl->pers.teamState.flagsince = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 600
ADDP4
ADDRGP4 level+40
INDIRI4
CVIF4 4
ASGNF4
line 1182
;1182:	Team_TakeFlagSound( ent, team );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Team_TakeFlagSound
CALLV
pop
line 1183
;1183:	G_LogPrintf("Flag_Pickup: %i\n", other - g_entities);
ADDRGP4 $406
ARGP4
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 896
DIVI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1186
;1184:	//This either fixes the disappearing flag bug,  or breaks manual flag return
;1185:	//if we're not lucky, it does neither.
;1186:	if (BaseFlag && !level.baseFlagSet[team]) {
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $486
ADDRFP4 8
INDIRI4
ADDRGP4 level+10880
ADDP4
INDIRU1
CVUI4 1
ADDRLP4 24
INDIRI4
NEI4 $486
line 1190
;1187:	//	G_Printf("%i\n", cl->ps.clientNum);
;1188:	//	level.flag_pickupTime[team] = level.time;
;1189:		//G_Printf("BaseFlag\n");
;1190:		ent->r.svFlags	|= SVF_NOCLIENT;
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1191
;1191:		ent->s.eFlags	|= EF_NODRAW;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 1192
;1192:		ent->r.contents	|= CONTENTS_TRANSLUCENT;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 536870912
BORI4
ASGNI4
line 1193
;1193:		ent->s.generic1 = 0;
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
CNSTI4 0
ASGNI4
line 1195
;1194:		//return.
;1195:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $468
JUMPV
LABELV $486
line 1198
;1196:	}
;1197:	//G_Printf("!BaseFlag\n");
;1198:	return -1; // Do not respawn this automatically, but do delete it if it was FL_DROPPED
CNSTI4 -1
RETI4
LABELV $468
endproc Team_TouchEnemyFlag 40 16
export Pickup_Team
proc Pickup_Team 20 12
line 1201
;1199:}
;1200:
;1201:int Pickup_Team( gentity_t *ent, gentity_t *other ) {
line 1203
;1202:	int team;
;1203:	gclient_t *cl = other->client;
ADDRLP4 4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 1222
;1204:
;1205:#ifdef MISSIONPACK
;1206:	if( g_gametype.integer == GT_OBELISK ) {
;1207:		// there are no team items that can be picked up in obelisk
;1208:		G_FreeEntity( ent );
;1209:		return 0;
;1210:	}
;1211:
;1212:	if( g_gametype.integer == GT_HARVESTER ) {
;1213:		// the only team items that can be picked up in harvester are the cubes
;1214:		if( ent->spawnflags != cl->sess.sessionTeam ) {
;1215:			cl->ps.generic1 += 1;
;1216:		}
;1217:		G_FreeEntity( ent );
;1218:		return 0;
;1219:	}
;1220:#endif
;1221:	// figure out what team this flag is
;1222:	if( strcmp(ent->classname, "team_CTF_redflag") == 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $261
ARGP4
ADDRLP4 8
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $490
line 1223
;1223:		team = TEAM_RED;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1224
;1224:	}
ADDRGP4 $491
JUMPV
LABELV $490
line 1225
;1225:	else if( strcmp(ent->classname, "team_CTF_blueflag") == 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $263
ARGP4
ADDRLP4 12
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $492
line 1226
;1226:		team = TEAM_BLUE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 1227
;1227:	}
ADDRGP4 $493
JUMPV
LABELV $492
line 1233
;1228:#ifdef MISSIONPACK
;1229:	else if( strcmp(ent->classname, "team_CTF_neutralflag") == 0  ) {
;1230:		team = TEAM_FREE;
;1231:	}
;1232:#endif
;1233:	else {
line 1234
;1234:		PrintMsg ( other, "Don't know what team the flag is on.\n");
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $494
ARGP4
ADDRGP4 PrintMsg
CALLV
pop
line 1235
;1235:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $489
JUMPV
LABELV $493
LABELV $491
line 1249
;1236:	}
;1237:#ifdef MISSIONPACK
;1238:	if( g_gametype.integer == GT_1FCTF ) {
;1239:		if( team == TEAM_FREE ) {
;1240:			return Team_TouchEnemyFlag( ent, other, cl->sess.sessionTeam );
;1241:		}
;1242:		if( team != cl->sess.sessionTeam) {
;1243:			return Team_TouchOurFlag( ent, other, cl->sess.sessionTeam );
;1244:		}
;1245:		return 0;
;1246:	}
;1247:#endif
;1248:	// GT_CTF
;1249:	if( team == cl->sess.sessionTeam) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
NEI4 $495
line 1251
;1250:	//	G_Printf("Team_TouchOurFlag\n");
;1251:		return Team_TouchOurFlag( ent, other, team );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 Team_TouchOurFlag
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
RETI4
ADDRGP4 $489
JUMPV
LABELV $495
line 1254
;1252:	}
;1253:	//G_Printf("Team_TouchEnemyFlag\n");
;1254:	return Team_TouchEnemyFlag( ent, other, team );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 Team_TouchEnemyFlag
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
RETI4
LABELV $489
endproc Pickup_Team 20 12
export Team_GetLocation
proc Team_GetLocation 56 8
line 1265
;1255:}
;1256:
;1257:/*
;1258:===========
;1259:Team_GetLocation
;1260:
;1261:Report a location for the player. Uses placed nearby target_location entities
;1262:============
;1263:*/
;1264:gentity_t *Team_GetLocation(gentity_t *ent)
;1265:{
line 1270
;1266:	gentity_t		*eloc, *best;
;1267:	float			bestlen, len;
;1268:	vec3_t			origin;
;1269:
;1270:	best = NULL;
ADDRLP4 24
CNSTP4 0
ASGNP4
line 1271
;1271:	bestlen = 3*8192.0*8192.0;
ADDRLP4 20
CNSTF4 1296039936
ASGNF4
line 1274
;1272:
;1273://freeze
;1274:	if ( g_gamemode.integer > 3 && ent->freezeState && is_body( ent->target_ent ) ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $498
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 0
EQI4 $498
ADDRLP4 28
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 is_body
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $498
line 1275
;1275:		VectorCopy( ent->target_ent->r.currentOrigin, origin );
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 1276
;1276:	} else
ADDRGP4 $499
JUMPV
LABELV $498
line 1278
;1277://freeze
;1278:	VectorCopy( ent->r.currentOrigin, origin );
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
LABELV $499
line 1280
;1279:
;1280:	for (eloc = level.locationHead; eloc; eloc = eloc->nextTrain) {
ADDRLP4 0
ADDRGP4 level+9204
INDIRP4
ASGNP4
ADDRGP4 $504
JUMPV
LABELV $501
line 1281
;1281:		len = ( origin[0] - eloc->r.currentOrigin[0] ) * ( origin[0] - eloc->r.currentOrigin[0] )
ADDRLP4 40
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 44
ADDRLP4 0
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ASGNF4
ADDRLP4 48
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ASGNF4
ADDRLP4 16
ADDRLP4 40
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
ADDRLP4 4+4
INDIRF4
ADDRLP4 44
INDIRF4
SUBF4
ADDRLP4 4+4
INDIRF4
ADDRLP4 44
INDIRF4
SUBF4
MULF4
ADDF4
ADDRLP4 4+8
INDIRF4
ADDRLP4 48
INDIRF4
SUBF4
ADDRLP4 4+8
INDIRF4
ADDRLP4 48
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 1285
;1282:			+ ( origin[1] - eloc->r.currentOrigin[1] ) * ( origin[1] - eloc->r.currentOrigin[1] )
;1283:			+ ( origin[2] - eloc->r.currentOrigin[2] ) * ( origin[2] - eloc->r.currentOrigin[2] );
;1284:
;1285:		if ( len > bestlen ) {
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
LEF4 $510
line 1286
;1286:			continue;
ADDRGP4 $502
JUMPV
LABELV $510
line 1289
;1287:		}
;1288:
;1289:		if ( !trap_InPVS( origin, eloc->r.currentOrigin ) ) {
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 52
ADDRGP4 trap_InPVS
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $512
line 1290
;1290:			continue;
ADDRGP4 $502
JUMPV
LABELV $512
line 1293
;1291:		}
;1292:
;1293:		bestlen = len;
ADDRLP4 20
ADDRLP4 16
INDIRF4
ASGNF4
line 1294
;1294:		best = eloc;
ADDRLP4 24
ADDRLP4 0
INDIRP4
ASGNP4
line 1295
;1295:	}
LABELV $502
line 1280
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 604
ADDP4
INDIRP4
ASGNP4
LABELV $504
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $501
line 1297
;1296:
;1297:	return best;
ADDRLP4 24
INDIRP4
RETP4
LABELV $497
endproc Team_GetLocation 56 8
export Team_GetLocationByVec
proc Team_GetLocationByVec 40 8
line 1301
;1298:}
;1299:
;1300:gentity_t *Team_GetLocationByVec(vec3_t origin)
;1301:{
line 1305
;1302:	gentity_t		*eloc, *best;
;1303:	float			bestlen, len;
;1304:
;1305:	best = NULL;
ADDRLP4 12
CNSTP4 0
ASGNP4
line 1306
;1306:	bestlen = 3*8192.0*8192.0;
ADDRLP4 8
CNSTF4 1296039936
ASGNF4
line 1308
;1307:
;1308:	for (eloc = level.locationHead; eloc; eloc = eloc->nextTrain) {
ADDRLP4 0
ADDRGP4 level+9204
INDIRP4
ASGNP4
ADDRGP4 $518
JUMPV
LABELV $515
line 1309
;1309:		len = ( origin[0] - eloc->r.currentOrigin[0] ) * ( origin[0] - eloc->r.currentOrigin[0] )
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 16
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 28
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 32
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4
ADDRLP4 24
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ADDRLP4 28
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ADDF4
ADDRLP4 32
INDIRF4
ADDRLP4 32
INDIRF4
MULF4
ADDF4
ASGNF4
line 1313
;1310:			+ ( origin[1] - eloc->r.currentOrigin[1] ) * ( origin[1] - eloc->r.currentOrigin[1] )
;1311:			+ ( origin[2] - eloc->r.currentOrigin[2] ) * ( origin[2] - eloc->r.currentOrigin[2] );
;1312:
;1313:		if ( len > bestlen ) {
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $520
line 1314
;1314:			continue;
ADDRGP4 $516
JUMPV
LABELV $520
line 1317
;1315:		}
;1316:
;1317:		if ( !trap_InPVS( origin, eloc->r.currentOrigin ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 trap_InPVS
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $522
line 1318
;1318:			continue;
ADDRGP4 $516
JUMPV
LABELV $522
line 1321
;1319:		}
;1320:
;1321:		bestlen = len;
ADDRLP4 8
ADDRLP4 4
INDIRF4
ASGNF4
line 1322
;1322:		best = eloc;
ADDRLP4 12
ADDRLP4 0
INDIRP4
ASGNP4
line 1323
;1323:	}
LABELV $516
line 1308
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 604
ADDP4
INDIRP4
ASGNP4
LABELV $518
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $515
line 1325
;1324:
;1325:	return best;
ADDRLP4 12
INDIRP4
RETP4
LABELV $514
endproc Team_GetLocationByVec 40 8
export Team_GetLocationMsg
proc Team_GetLocationMsg 12 24
line 1336
;1326:}
;1327://end monkk
;1328:/*
;1329:===========
;1330:Team_GetLocation
;1331:
;1332:Report a location for the player. Uses placed nearby target_location entities
;1333:============
;1334:*/
;1335:qboolean Team_GetLocationMsg(gentity_t *ent, char *loc, int loclen)
;1336:{
line 1339
;1337:	gentity_t *best;
;1338:
;1339:	best = Team_GetLocation( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Team_GetLocation
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1341
;1340:	
;1341:	if (!best)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $525
line 1342
;1342:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $524
JUMPV
LABELV $525
line 1344
;1343:
;1344:	if (best->count) {
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $527
line 1345
;1345:		if (best->count < 0)
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
GEI4 $529
line 1346
;1346:			best->count = 0;
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 0
ASGNI4
LABELV $529
line 1347
;1347:		if (best->count > 7)
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 7
LEI4 $531
line 1348
;1348:			best->count = 7;
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 7
ASGNI4
LABELV $531
line 1349
;1349:		Com_sprintf(loc, loclen, "%c%c%s" S_COLOR_WHITE, Q_COLOR_ESCAPE, best->count + '0', best->message );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 $533
ARGP4
CNSTI4 94
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 48
ADDI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1350
;1350:	} else
ADDRGP4 $528
JUMPV
LABELV $527
line 1351
;1351:		Com_sprintf(loc, loclen, "%s", best->message);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 $534
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
LABELV $528
line 1353
;1352:
;1353:	return qtrue;
CNSTI4 1
RETI4
LABELV $524
endproc Team_GetLocationMsg 12 24
export Team_GetLocationMsgByVec
proc Team_GetLocationMsgByVec 20 24
line 1357
;1354:}
;1355://monkk
;1356:qboolean Team_GetLocationMsgByVec(vec3_t origin, char *loc, int loclen)
;1357:{
line 1360
;1358:	gentity_t *best;
;1359:
;1360:	best = Team_GetLocationByVec( origin );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Team_GetLocationByVec
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1362
;1361:	
;1362:	if (!best || !best->message)
ADDRLP4 12
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 12
INDIRU4
EQU4 $538
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 12
INDIRU4
NEU4 $536
LABELV $538
line 1363
;1363:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $535
JUMPV
LABELV $536
line 1365
;1364:
;1365:	if (best->count) {
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $539
line 1366
;1366:		if (best->count < 0)
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
GEI4 $541
line 1367
;1367:			best->count = 0;
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 0
ASGNI4
LABELV $541
line 1368
;1368:		if (best->count > 7)
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 7
LEI4 $543
line 1369
;1369:			best->count = 7;
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 7
ASGNI4
LABELV $543
line 1370
;1370:		Com_sprintf(loc, loclen, "%c%c%s" S_COLOR_WHITE, Q_COLOR_ESCAPE, best->count + '0', best->message );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 $533
ARGP4
CNSTI4 94
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 48
ADDI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1371
;1371:	} else
ADDRGP4 $540
JUMPV
LABELV $539
line 1372
;1372:		Com_sprintf(loc, loclen, "%s", best->message);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 $534
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
LABELV $540
line 1374
;1373:
;1374:	return qtrue;
CNSTI4 1
RETI4
LABELV $535
endproc Team_GetLocationMsgByVec 20 24
export SelectRandomTeamSpawnPoint
proc SelectRandomTeamSpawnPoint 152 12
line 1388
;1375:}
;1376://end monkk
;1377:
;1378:/*---------------------------------------------------------------------------*/
;1379:
;1380:/*
;1381:================
;1382:SelectRandomDeathmatchSpawnPoint
;1383:
;1384:go to a random point that doesn't telefrag
;1385:================
;1386:*/
;1387:#define	MAX_TEAM_SPAWN_POINTS	32
;1388:gentity_t *SelectRandomTeamSpawnPoint( int teamstate, team_t team ) {
line 1395
;1389:	gentity_t	*spot;
;1390:	int			count;
;1391:	int			selection;
;1392:	gentity_t	*spots[MAX_TEAM_SPAWN_POINTS];
;1393:	char		*classname;
;1394:
;1395:	if (teamstate == TEAM_BEGIN) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $546
line 1396
;1396:		if (team == TEAM_RED)
ADDRFP4 4
INDIRI4
CNSTI4 1
NEI4 $548
line 1397
;1397:			classname = "team_CTF_redplayer";
ADDRLP4 8
ADDRGP4 $550
ASGNP4
ADDRGP4 $547
JUMPV
LABELV $548
line 1398
;1398:		else if (team == TEAM_BLUE)
ADDRFP4 4
INDIRI4
CNSTI4 2
NEI4 $551
line 1399
;1399:			classname = "team_CTF_blueplayer";
ADDRLP4 8
ADDRGP4 $553
ASGNP4
ADDRGP4 $547
JUMPV
LABELV $551
line 1401
;1400:		else
;1401:			return NULL;
CNSTP4 0
RETP4
ADDRGP4 $545
JUMPV
line 1402
;1402:	} else {
LABELV $546
line 1403
;1403:		if (team == TEAM_RED)
ADDRFP4 4
INDIRI4
CNSTI4 1
NEI4 $554
line 1404
;1404:			classname = "team_CTF_redspawn";
ADDRLP4 8
ADDRGP4 $556
ASGNP4
ADDRGP4 $555
JUMPV
LABELV $554
line 1405
;1405:		else if (team == TEAM_BLUE)
ADDRFP4 4
INDIRI4
CNSTI4 2
NEI4 $557
line 1406
;1406:			classname = "team_CTF_bluespawn";
ADDRLP4 8
ADDRGP4 $559
ASGNP4
ADDRGP4 $558
JUMPV
LABELV $557
line 1408
;1407:		else
;1408:			return NULL;
CNSTP4 0
RETP4
ADDRGP4 $545
JUMPV
LABELV $558
LABELV $555
line 1409
;1409:	}
LABELV $547
line 1410
;1410:	count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1412
;1411:
;1412:	spot = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
ADDRGP4 $561
JUMPV
LABELV $560
line 1414
;1413:
;1414:	while ((spot = G_Find (spot, FOFS(classname), classname)) != NULL) {
line 1415
;1415:		if ( SpotWouldTelefrag( spot ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 144
ADDRGP4 SpotWouldTelefrag
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $563
line 1416
;1416:			continue;
ADDRGP4 $561
JUMPV
LABELV $563
line 1418
;1417:		}
;1418:		spots[ count ] = spot;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 1419
;1419:		if (++count == MAX_TEAM_SPAWN_POINTS)
ADDRLP4 148
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
ADDRLP4 148
INDIRI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 32
NEI4 $565
line 1420
;1420:			break;
ADDRGP4 $562
JUMPV
LABELV $565
line 1421
;1421:	}
LABELV $561
line 1414
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 144
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 144
INDIRP4
ASGNP4
ADDRLP4 144
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $560
LABELV $562
line 1423
;1422:
;1423:	if ( !count ) {	// no spots that won't telefrag
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $567
line 1424
;1424:		return G_Find( NULL, FOFS(classname), classname);
CNSTP4 0
ARGP4
CNSTI4 524
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 148
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 148
INDIRP4
RETP4
ADDRGP4 $545
JUMPV
LABELV $567
line 1427
;1425:	}
;1426:
;1427:	selection = rand() % count;
ADDRLP4 148
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 140
ADDRLP4 148
INDIRI4
ADDRLP4 4
INDIRI4
MODI4
ASGNI4
line 1428
;1428:	return spots[ selection ];
ADDRLP4 140
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
ADDP4
INDIRP4
RETP4
LABELV $545
endproc SelectRandomTeamSpawnPoint 152 12
export SelectCTFSpawnPoint
proc SelectCTFSpawnPoint 12 12
line 1438
;1429:}
;1430:
;1431:
;1432:/*
;1433:===========
;1434:SelectCTFSpawnPoint
;1435:
;1436:============
;1437:*/
;1438:gentity_t *SelectCTFSpawnPoint ( team_t team, int teamstate, vec3_t origin, vec3_t angles ) {
line 1441
;1439:	gentity_t	*spot;
;1440:
;1441:	spot = SelectRandomTeamSpawnPoint ( teamstate, team );
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 SelectRandomTeamSpawnPoint
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1443
;1442:
;1443:	if (!spot) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $570
line 1444
;1444:		return SelectSpawnPoint( vec3_origin, origin, angles );
ADDRGP4 vec3_origin
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 SelectSpawnPoint
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
RETP4
ADDRGP4 $569
JUMPV
LABELV $570
line 1447
;1445:	}
;1446:
;1447:	VectorCopy (spot->s.origin, origin);
ADDRFP4 8
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 1448
;1448:	origin[2] += 9;
ADDRLP4 8
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CNSTF4 1091567616
ADDF4
ASGNF4
line 1449
;1449:	VectorCopy (spot->s.angles, angles);
ADDRFP4 12
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 1451
;1450:
;1451:	return spot;
ADDRLP4 0
INDIRP4
RETP4
LABELV $569
endproc SelectCTFSpawnPoint 12 12
proc SortClients 0 0
line 1456
;1452:}
;1453:
;1454:/*---------------------------------------------------------------------------*/
;1455:
;1456:static int QDECL SortClients( const void *a, const void *b ) {
line 1457
;1457:	return *(int *)a - *(int *)b;
ADDRFP4 0
INDIRP4
INDIRI4
ADDRFP4 4
INDIRP4
INDIRI4
SUBI4
RETI4
LABELV $572
endproc SortClients 0 0
export TeamplayInfoMessage
proc TeamplayInfoMessage 9404 36
line 1470
;1458:}
;1459:
;1460:
;1461:/*
;1462:==================
;1463:TeamplayLocationsMessage
;1464:
;1465:Format:
;1466:	clientNum location health armor weapon powerups
;1467:
;1468:==================
;1469:*/
;1470:void TeamplayInfoMessage( gentity_t *ent ) {
line 1480
;1471:	char		entry[1024];
;1472:	char		string[8192];
;1473:	int			stringlength;
;1474:	int			i, j;
;1475:	gentity_t	*player;
;1476:	int			cnt;
;1477:	int			h, a;
;1478:	int			clients[TEAM_MAXOVERLAY];
;1479:
;1480:	if ( ! ent->client->pers.teamInfo )
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 0
NEI4 $574
line 1481
;1481:		return;
ADDRGP4 $573
JUMPV
LABELV $574
line 1486
;1482:
;1483:	// figure out what client should be on the display
;1484:	// we are limited to 8, but we want to use the top eight players
;1485:	// but in client order (so they don't keep changing position on the overlay)
;1486:	for (i = 0, cnt = 0; i < g_maxclients.integer && cnt < TEAM_MAXOVERLAY; i++) {
ADDRLP4 9372
CNSTI4 0
ASGNI4
ADDRLP4 4
ADDRLP4 9372
INDIRI4
ASGNI4
ADDRLP4 8
ADDRLP4 9372
INDIRI4
ASGNI4
ADDRGP4 $579
JUMPV
LABELV $576
line 1487
;1487:		player = g_entities + level.sortedClients[i];
ADDRLP4 0
CNSTI4 896
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+124
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1488
;1488:		if (player->inuse && player->client->sess.sessionTeam == 
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $582
ADDRLP4 9380
CNSTI4 516
ASGNI4
ADDRLP4 9384
CNSTI4 10188
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 9380
INDIRI4
ADDP4
INDIRP4
ADDRLP4 9384
INDIRI4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 9380
INDIRI4
ADDP4
INDIRP4
ADDRLP4 9384
INDIRI4
ADDP4
INDIRI4
NEI4 $582
line 1489
;1489:			ent->client->sess.sessionTeam ) {
line 1490
;1490:			clients[cnt++] = level.sortedClients[i];
ADDRLP4 9388
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 8
ADDRLP4 9388
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 9392
CNSTI4 2
ASGNI4
ADDRLP4 9388
INDIRI4
ADDRLP4 9392
INDIRI4
LSHI4
ADDRLP4 9244
ADDP4
ADDRLP4 4
INDIRI4
ADDRLP4 9392
INDIRI4
LSHI4
ADDRGP4 level+124
ADDP4
INDIRI4
ASGNI4
line 1491
;1491:		}
LABELV $582
line 1492
;1492:	}
LABELV $577
line 1486
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $579
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
GEI4 $585
ADDRLP4 8
INDIRI4
CNSTI4 32
LTI4 $576
LABELV $585
line 1495
;1493:
;1494:	// We have the top eight players, sort them by clientNum
;1495:	qsort( clients, cnt, sizeof( clients[0] ), SortClients );
ADDRLP4 9244
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 SortClients
ARGP4
ADDRGP4 qsort
CALLV
pop
line 1498
;1496:
;1497:	// send the latest information on all clients
;1498:	string[0] = 0;
ADDRLP4 1052
CNSTI1 0
ASGNI1
line 1499
;1499:	stringlength = 0;
ADDRLP4 1044
CNSTI4 0
ASGNI4
line 1501
;1500:
;1501:	for (i = 0, cnt = 0; i < g_maxclients.integer && cnt < TEAM_MAXOVERLAY; i++) {
ADDRLP4 9376
CNSTI4 0
ASGNI4
ADDRLP4 4
ADDRLP4 9376
INDIRI4
ASGNI4
ADDRLP4 8
ADDRLP4 9376
INDIRI4
ASGNI4
ADDRGP4 $589
JUMPV
LABELV $586
line 1502
;1502:		player = g_entities + i;
ADDRLP4 0
CNSTI4 896
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1503
;1503:		if (player->inuse && player->client->sess.sessionTeam == 
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $591
ADDRLP4 9384
CNSTI4 516
ASGNI4
ADDRLP4 9388
CNSTI4 10188
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 9384
INDIRI4
ADDP4
INDIRP4
ADDRLP4 9388
INDIRI4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 9384
INDIRI4
ADDP4
INDIRP4
ADDRLP4 9388
INDIRI4
ADDP4
INDIRI4
NEI4 $591
line 1504
;1504:			ent->client->sess.sessionTeam ) {
line 1506
;1505:
;1506:			h = player->client->ps.stats[STAT_HEALTH];
ADDRLP4 1036
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 1507
;1507:			a = player->client->ps.stats[STAT_ARMOR];
ADDRLP4 1040
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
line 1508
;1508:			if (h < 0) h = 0;
ADDRLP4 1036
INDIRI4
CNSTI4 0
GEI4 $593
ADDRLP4 1036
CNSTI4 0
ASGNI4
LABELV $593
line 1509
;1509:			if (a < 0) a = 0;
ADDRLP4 1040
INDIRI4
CNSTI4 0
GEI4 $595
ADDRLP4 1040
CNSTI4 0
ASGNI4
LABELV $595
line 1511
;1510://freeze
;1511:			if ( g_gamemode.integer > 3 && player->freezeState ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $597
ADDRLP4 0
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 0
EQI4 $597
line 1512
;1512:				h = a = 0;
ADDRLP4 9392
CNSTI4 0
ASGNI4
ADDRLP4 1040
ADDRLP4 9392
INDIRI4
ASGNI4
ADDRLP4 1036
ADDRLP4 9392
INDIRI4
ASGNI4
line 1513
;1513:			}
LABELV $597
line 1516
;1514://freeze
;1515:
;1516:			Com_sprintf (entry, sizeof(entry),
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $600
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 9396
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 9396
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
ARGI4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 1040
INDIRI4
ARGI4
ADDRLP4 9396
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1521
;1517:				" %i %i %i %i %i %i", 
;1518://				level.sortedClients[i], player->client->pers.teamState.location, h, a, 
;1519:				i, player->client->pers.teamState.location, h, a, 
;1520:				player->client->ps.weapon, player->s.powerups);
;1521:			j = strlen(entry);
ADDRLP4 12
ARGP4
ADDRLP4 9400
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1048
ADDRLP4 9400
INDIRI4
ASGNI4
line 1522
;1522:			if (stringlength + j > sizeof(string))
ADDRLP4 1044
INDIRI4
ADDRLP4 1048
INDIRI4
ADDI4
CVIU4 4
CNSTU4 8192
LEU4 $601
line 1523
;1523:				break;
ADDRGP4 $588
JUMPV
LABELV $601
line 1524
;1524:			strcpy (string + stringlength, entry);
ADDRLP4 1044
INDIRI4
ADDRLP4 1052
ADDP4
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1525
;1525:			stringlength += j;
ADDRLP4 1044
ADDRLP4 1044
INDIRI4
ADDRLP4 1048
INDIRI4
ADDI4
ASGNI4
line 1526
;1526:			cnt++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1527
;1527:		}
LABELV $591
line 1528
;1528:	}
LABELV $587
line 1501
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $589
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
GEI4 $603
ADDRLP4 8
INDIRI4
CNSTI4 32
LTI4 $586
LABELV $603
LABELV $588
line 1530
;1529:
;1530:	trap_SendServerCommand( ent-g_entities, va("tinfo %i %s", cnt, string) );
ADDRGP4 $604
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 1052
ARGP4
ADDRLP4 9380
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 896
DIVI4
ARGI4
ADDRLP4 9380
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1531
;1531:}
LABELV $573
endproc TeamplayInfoMessage 9404 36
export CheckTeamStatus
proc CheckTeamStatus 24 4
line 1533
;1532:
;1533:void CheckTeamStatus(void) {
line 1537
;1534:	int i;
;1535:	gentity_t *loc, *ent;
;1536:
;1537:	if (level.time - level.lastTeamLocationTime > TEAM_LOCATION_UPDATE_TIME) {
ADDRGP4 level+40
INDIRI4
ADDRGP4 level+104
INDIRI4
SUBI4
CNSTI4 1000
LEI4 $606
line 1539
;1538:
;1539:		level.lastTeamLocationTime = level.time;
ADDRGP4 level+104
ADDRGP4 level+40
INDIRI4
ASGNI4
line 1542
;1540:
;1541:		//FIXME: This shouldn't be like this, it should be for the one team required..
;1542:		CheckForAutoUnlock(TEAM_RED);
CNSTI4 1
ARGI4
ADDRGP4 CheckForAutoUnlock
CALLV
pop
line 1543
;1543:		CheckForAutoUnlock(TEAM_BLUE);
CNSTI4 2
ARGI4
ADDRGP4 CheckForAutoUnlock
CALLV
pop
line 1544
;1544:		CheckForAutoUnlock(TEAM_FREE);
CNSTI4 0
ARGI4
ADDRGP4 CheckForAutoUnlock
CALLV
pop
line 1546
;1545:
;1546:		for (i = 0; i < g_maxclients.integer; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $615
JUMPV
LABELV $612
line 1547
;1547:			ent = g_entities + i;
ADDRLP4 0
CNSTI4 896
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1549
;1548:
;1549:			if ( ent->client->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $617
line 1550
;1550:				continue;
ADDRGP4 $613
JUMPV
LABELV $617
line 1553
;1551:			}
;1552:
;1553:			if (ent->inuse && (ent->client->sess.sessionTeam == TEAM_RED ||	ent->client->sess.sessionTeam == TEAM_BLUE)) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $619
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 1
EQI4 $621
ADDRLP4 16
INDIRI4
CNSTI4 2
NEI4 $619
LABELV $621
line 1554
;1554:				loc = Team_GetLocation( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 Team_GetLocation
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 20
INDIRP4
ASGNP4
line 1555
;1555:				if (loc)
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $622
line 1556
;1556:					ent->client->pers.teamState.location = loc->health;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 564
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $623
JUMPV
LABELV $622
line 1558
;1557:				else
;1558:					ent->client->pers.teamState.location = 0;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 564
ADDP4
CNSTI4 0
ASGNI4
LABELV $623
line 1559
;1559:			}
LABELV $619
line 1560
;1560:		}
LABELV $613
line 1546
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $615
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $612
line 1562
;1561:
;1562:		for (i = 0; i < g_maxclients.integer; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $627
JUMPV
LABELV $624
line 1563
;1563:			ent = g_entities + i;
ADDRLP4 0
CNSTI4 896
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1565
;1564:
;1565:			if ( ent->client->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $629
line 1566
;1566:				continue;
ADDRGP4 $625
JUMPV
LABELV $629
line 1569
;1567:			}
;1568:
;1569:			if (ent->inuse && (ent->client->sess.sessionTeam == TEAM_RED ||	ent->client->sess.sessionTeam == TEAM_BLUE)) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $631
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 1
EQI4 $633
ADDRLP4 16
INDIRI4
CNSTI4 2
NEI4 $631
LABELV $633
line 1570
;1570:				TeamplayInfoMessage( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 TeamplayInfoMessage
CALLV
pop
line 1571
;1571:			}
LABELV $631
line 1572
;1572:		}
LABELV $625
line 1562
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $627
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $624
line 1573
;1573:	}
LABELV $606
line 1574
;1574:}
LABELV $605
endproc CheckTeamStatus 24 4
export SP_team_CTF_redplayer
proc SP_team_CTF_redplayer 4 0
line 1581
;1575:
;1576:/*-----------------------------------------------------------------*/
;1577:
;1578:/*QUAKED team_CTF_redplayer (1 0 0) (-16 -16 -16) (16 16 32)
;1579:Only in CTF games.  Red players spawn here at game start.
;1580:*/
;1581:void SP_team_CTF_redplayer( gentity_t *ent ) {
line 1583
;1582://freeze
;1583:	if ( g_gamemode.integer > 3 && g_gametype.integer == GT_TEAM ) {
ADDRLP4 0
CNSTI4 3
ASGNI4
ADDRGP4 g_gamemode+12
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $635
ADDRGP4 g_gametype+12
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $635
line 1584
;1584:		ent->classname = "info_player_deathmatch";
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $639
ASGNP4
line 1585
;1585:	}
LABELV $635
line 1587
;1586://freeze
;1587:}
LABELV $634
endproc SP_team_CTF_redplayer 4 0
export SP_team_CTF_blueplayer
proc SP_team_CTF_blueplayer 4 0
line 1593
;1588:
;1589:
;1590:/*QUAKED team_CTF_blueplayer (0 0 1) (-16 -16 -16) (16 16 32)
;1591:Only in CTF games.  Blue players spawn here at game start.
;1592:*/
;1593:void SP_team_CTF_blueplayer( gentity_t *ent ) {
line 1595
;1594://freeze
;1595:	if ( g_gamemode.integer > 3 && g_gametype.integer == GT_TEAM ) {
ADDRLP4 0
CNSTI4 3
ASGNI4
ADDRGP4 g_gamemode+12
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $641
ADDRGP4 g_gametype+12
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $641
line 1596
;1596:		ent->classname = "info_player_deathmatch";
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $639
ASGNP4
line 1597
;1597:	}
LABELV $641
line 1599
;1598://freeze
;1599:}
LABELV $640
endproc SP_team_CTF_blueplayer 4 0
export SP_team_CTF_redspawn
proc SP_team_CTF_redspawn 0 0
line 1606
;1600:
;1601:
;1602:/*QUAKED team_CTF_redspawn (1 0 0) (-16 -16 -24) (16 16 32)
;1603:potential spawning position for red team in CTF games.
;1604:Targets will be fired when someone spawns in on them.
;1605:*/
;1606:void SP_team_CTF_redspawn(gentity_t *ent) {
line 1607
;1607:}
LABELV $645
endproc SP_team_CTF_redspawn 0 0
export SP_team_CTF_bluespawn
proc SP_team_CTF_bluespawn 0 0
line 1613
;1608:
;1609:/*QUAKED team_CTF_bluespawn (0 0 1) (-16 -16 -24) (16 16 32)
;1610:potential spawning position for blue team in CTF games.
;1611:Targets will be fired when someone spawns in on them.
;1612:*/
;1613:void SP_team_CTF_bluespawn(gentity_t *ent) {
line 1614
;1614:}
LABELV $646
endproc SP_team_CTF_bluespawn 0 0
bss
export neutralObelisk
align 4
LABELV neutralObelisk
skip 4
export teamgame
align 4
LABELV teamgame
skip 36
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
LABELV $639
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $604
byte 1 116
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $600
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
LABELV $559
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $556
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $553
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $550
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $534
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $533
byte 1 37
byte 1 99
byte 1 37
byte 1 99
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $494
byte 1 68
byte 1 111
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 32
byte 1 119
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 110
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $476
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $462
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 95
byte 1 65
byte 1 115
byte 1 115
byte 1 105
byte 1 115
byte 1 116
byte 1 95
byte 1 82
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $442
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 50
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 66
byte 1 76
byte 1 85
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $439
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 49
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 82
byte 1 69
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $438
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 95
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $431
byte 1 94
byte 1 53
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 37
byte 1 105
byte 1 46
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $430
byte 1 94
byte 1 53
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 37
byte 1 105
byte 1 46
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $425
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $412
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 95
byte 1 82
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $410
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $406
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 95
byte 1 80
byte 1 105
byte 1 99
byte 1 107
byte 1 117
byte 1 112
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $405
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 105
byte 1 115
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
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $372
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $370
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $364
byte 1 87
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 32
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 83
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $336
byte 1 87
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 32
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 84
byte 1 97
byte 1 107
byte 1 101
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 83
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $330
byte 1 87
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 32
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 82
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 83
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $317
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 110
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $286
byte 1 68
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 95
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $263
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $261
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $251
byte 1 72
byte 1 117
byte 1 114
byte 1 116
byte 1 95
byte 1 67
byte 1 97
byte 1 114
byte 1 114
byte 1 105
byte 1 101
byte 1 114
byte 1 95
byte 1 68
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $240
byte 1 37
byte 1 115
byte 1 94
byte 1 55
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
byte 1 39
byte 1 115
byte 1 32
byte 1 115
byte 1 107
byte 1 117
byte 1 108
byte 1 108
byte 1 32
byte 1 99
byte 1 97
byte 1 114
byte 1 114
byte 1 105
byte 1 101
byte 1 114
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $229
byte 1 75
byte 1 105
byte 1 108
byte 1 108
byte 1 95
byte 1 67
byte 1 97
byte 1 114
byte 1 114
byte 1 105
byte 1 101
byte 1 114
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $228
byte 1 37
byte 1 115
byte 1 94
byte 1 55
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
byte 1 39
byte 1 115
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 99
byte 1 97
byte 1 114
byte 1 114
byte 1 105
byte 1 101
byte 1 114
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $117
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $112
byte 1 80
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 77
byte 1 115
byte 1 103
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 114
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $107
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $106
byte 1 94
byte 1 51
byte 1 0
align 1
LABELV $103
byte 1 94
byte 1 52
byte 1 0
align 1
LABELV $100
byte 1 94
byte 1 49
byte 1 0
align 1
LABELV $89
byte 1 70
byte 1 82
byte 1 69
byte 1 69
byte 1 0
align 1
LABELV $88
byte 1 83
byte 1 80
byte 1 69
byte 1 67
byte 1 84
byte 1 65
byte 1 84
byte 1 79
byte 1 82
byte 1 0
align 1
LABELV $85
byte 1 66
byte 1 76
byte 1 85
byte 1 69
byte 1 0
align 1
LABELV $82
byte 1 82
byte 1 69
byte 1 68
byte 1 0
