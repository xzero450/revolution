export trap_Cvar_VariableValue
code
proc trap_Cvar_VariableValue 132 12
file "../g_bot.c"
line 35
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// g_bot.c
;4:
;5:#include "g_local.h"
;6:
;7:
;8:static int		g_numBots;
;9:static char		*g_botInfos[MAX_BOTS];
;10:
;11:
;12:int				g_numArenas;
;13:static char		*g_arenaInfos[MAX_ARENAS];
;14:
;15:
;16:#define BOT_BEGIN_DELAY_BASE		2000
;17:#define BOT_BEGIN_DELAY_INCREMENT	1500
;18:
;19:#define BOT_SPAWN_QUEUE_DEPTH	16
;20:
;21:typedef struct {
;22:	int		clientNum;
;23:	int		spawnTime;
;24:} botSpawnQueue_t;
;25:
;26://static int			botBeginDelay = 0;  // bk001206 - unused, init
;27:static botSpawnQueue_t	botSpawnQueue[BOT_SPAWN_QUEUE_DEPTH];
;28:
;29:vmCvar_t bot_minplayers;
;30:
;31:extern gentity_t	*podium1;
;32:extern gentity_t	*podium2;
;33:extern gentity_t	*podium3;
;34:
;35:float trap_Cvar_VariableValue( const char *var_name ) {
line 38
;36:	char buf[128];
;37:
;38:	trap_Cvar_VariableStringBuffer(var_name, buf, sizeof(buf));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 39
;39:	return atof(buf);
ADDRLP4 0
ARGP4
ADDRLP4 128
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 128
INDIRF4
RETF4
LABELV $68
endproc trap_Cvar_VariableValue 132 12
export G_ParseInfos
proc G_ParseInfos 2084 12
line 49
;40:}
;41:
;42:
;43:
;44:/*
;45:===============
;46:G_ParseInfos
;47:===============
;48:*/
;49:int G_ParseInfos( char *buf, int max, char *infos[] ) {
line 55
;50:	char	*token;
;51:	int		count;
;52:	char	key[MAX_TOKEN_CHARS];
;53:	char	info[MAX_INFO_STRING];
;54:
;55:	count = 0;
ADDRLP4 2052
CNSTI4 0
ASGNI4
ADDRGP4 $71
JUMPV
LABELV $70
line 57
;56:
;57:	while ( 1 ) {
line 58
;58:		token = COM_Parse( &buf );
ADDRFP4 0
ARGP4
ADDRLP4 2056
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2056
INDIRP4
ASGNP4
line 59
;59:		if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $73
line 60
;60:			break;
ADDRGP4 $72
JUMPV
LABELV $73
line 62
;61:		}
;62:		if ( strcmp( token, "{" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $77
ARGP4
ADDRLP4 2060
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 2060
INDIRI4
CNSTI4 0
EQI4 $75
line 63
;63:			Com_Printf( "Missing { in info file\n" );
ADDRGP4 $78
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 64
;64:			break;
ADDRGP4 $72
JUMPV
LABELV $75
line 67
;65:		}
;66:
;67:		if ( count == max ) {
ADDRLP4 2052
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $79
line 68
;68:			Com_Printf( "Max infos exceeded\n" );
ADDRGP4 $81
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 69
;69:			break;
ADDRGP4 $72
JUMPV
LABELV $79
line 72
;70:		}
;71:
;72:		info[0] = '\0';
ADDRLP4 1028
CNSTI1 0
ASGNI1
ADDRGP4 $83
JUMPV
LABELV $82
line 73
;73:		while ( 1 ) {
line 74
;74:			token = COM_ParseExt( &buf, qtrue );
ADDRFP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 2064
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2064
INDIRP4
ASGNP4
line 75
;75:			if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $85
line 76
;76:				Com_Printf( "Unexpected end of info file\n" );
ADDRGP4 $87
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 77
;77:				break;
ADDRGP4 $84
JUMPV
LABELV $85
line 79
;78:			}
;79:			if ( !strcmp( token, "}" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $90
ARGP4
ADDRLP4 2068
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 2068
INDIRI4
CNSTI4 0
NEI4 $88
line 80
;80:				break;
ADDRGP4 $84
JUMPV
LABELV $88
line 82
;81:			}
;82:			Q_strncpyz( key, token, sizeof( key ) );
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 84
;83:
;84:			token = COM_ParseExt( &buf, qfalse );
ADDRFP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 2072
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2072
INDIRP4
ASGNP4
line 85
;85:			if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $91
line 86
;86:				strcpy( token, "<NULL>" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $93
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 87
;87:			}
LABELV $91
line 88
;88:			Info_SetValueForKey( info, key, token );
ADDRLP4 1028
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 89
;89:		}
LABELV $83
line 73
ADDRGP4 $82
JUMPV
LABELV $84
line 91
;90:		//NOTE: extra space for arena number
;91:		infos[count] = G_Alloc(strlen(info) + strlen("\\num\\") + strlen(va("%d", MAX_ARENAS)) + 1);
ADDRLP4 1028
ARGP4
ADDRLP4 2064
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRGP4 $94
ARGP4
ADDRLP4 2068
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRGP4 $95
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 2072
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 2072
INDIRP4
ARGP4
ADDRLP4 2076
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 2064
INDIRI4
ADDRLP4 2068
INDIRI4
ADDI4
ADDRLP4 2076
INDIRI4
ADDI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 2080
ADDRGP4 G_Alloc
CALLP4
ASGNP4
ADDRLP4 2052
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
ADDRLP4 2080
INDIRP4
ASGNP4
line 92
;92:		if (infos[count]) {
ADDRLP4 2052
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $96
line 93
;93:			strcpy(infos[count], info);
ADDRLP4 2052
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1028
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 94
;94:			count++;
ADDRLP4 2052
ADDRLP4 2052
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 95
;95:		}
LABELV $96
line 96
;96:	}
LABELV $71
line 57
ADDRGP4 $70
JUMPV
LABELV $72
line 97
;97:	return count;
ADDRLP4 2052
INDIRI4
RETI4
LABELV $69
endproc G_ParseInfos 2084 12
proc G_LoadArenasFromFile 8216 16
line 105
;98:}
;99:
;100:/*
;101:===============
;102:G_LoadArenasFromFile
;103:===============
;104:*/
;105:static void G_LoadArenasFromFile( char *filename ) {
line 110
;106:	int				len;
;107:	fileHandle_t	f;
;108:	char			buf[MAX_ARENAS_TEXT];
;109:
;110:	len = trap_FS_FOpenFile( filename, &f, FS_READ );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8200
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8200
INDIRI4
ASGNI4
line 111
;111:	if ( !f ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $99
line 112
;112:		trap_Printf( va( S_COLOR_RED "file not found: %s\n", filename ) );
ADDRGP4 $101
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8204
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8204
INDIRP4
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 113
;113:		return;
ADDRGP4 $98
JUMPV
LABELV $99
line 115
;114:	}
;115:	if ( len >= MAX_ARENAS_TEXT ) {
ADDRLP4 0
INDIRI4
CNSTI4 8192
LTI4 $102
line 116
;116:		trap_Printf( va( S_COLOR_RED "file too large: %s is %i, max allowed is %i", filename, len, MAX_ARENAS_TEXT ) );
ADDRGP4 $104
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 8192
ARGI4
ADDRLP4 8204
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8204
INDIRP4
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 117
;117:		trap_FS_FCloseFile( f );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 118
;118:		return;
ADDRGP4 $98
JUMPV
LABELV $102
line 121
;119:	}
;120:
;121:	trap_FS_Read( buf, len, f );
ADDRLP4 8
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 122
;122:	buf[len] = 0;
ADDRLP4 0
INDIRI4
ADDRLP4 8
ADDP4
CNSTI1 0
ASGNI1
line 123
;123:	trap_FS_FCloseFile( f );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 125
;124:
;125:	g_numArenas += G_ParseInfos( buf, MAX_ARENAS - g_numArenas, &g_arenaInfos[g_numArenas] );
ADDRLP4 8
ARGP4
ADDRLP4 8204
ADDRGP4 g_numArenas
ASGNP4
ADDRLP4 8208
ADDRLP4 8204
INDIRP4
INDIRI4
ASGNI4
CNSTI4 1024
ADDRLP4 8208
INDIRI4
SUBI4
ARGI4
ADDRLP4 8208
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_arenaInfos
ADDP4
ARGP4
ADDRLP4 8212
ADDRGP4 G_ParseInfos
CALLI4
ASGNI4
ADDRLP4 8204
INDIRP4
ADDRLP4 8208
INDIRI4
ADDRLP4 8212
INDIRI4
ADDI4
ASGNI4
line 126
;126:}
LABELV $98
endproc G_LoadArenasFromFile 8216 16
proc G_LoadArenas 1460 16
line 133
;127:
;128:/*
;129:===============
;130:G_LoadArenas
;131:===============
;132:*/
;133:static void G_LoadArenas( void ) {
line 142
;134:	int			numdirs;
;135:	vmCvar_t	arenasFile;
;136:	char		filename[128];
;137:	char		dirlist[1024];
;138:	char*		dirptr;
;139:	int			i, n;
;140:	int			dirlen;
;141:
;142:	g_numArenas = 0;
ADDRGP4 g_numArenas
CNSTI4 0
ASGNI4
line 144
;143:
;144:	trap_Cvar_Register( &arenasFile, "g_arenasFile", "", CVAR_INIT|CVAR_ROM );
ADDRLP4 148
ARGP4
ADDRGP4 $106
ARGP4
ADDRGP4 $107
ARGP4
CNSTI4 80
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 145
;145:	if( *arenasFile.string ) {
ADDRLP4 148+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $108
line 146
;146:		G_LoadArenasFromFile(arenasFile.string);
ADDRLP4 148+16
ARGP4
ADDRGP4 G_LoadArenasFromFile
CALLV
pop
line 147
;147:	}
ADDRGP4 $109
JUMPV
LABELV $108
line 148
;148:	else {
line 149
;149:		G_LoadArenasFromFile("scripts/arenas.txt");
ADDRGP4 $112
ARGP4
ADDRGP4 G_LoadArenasFromFile
CALLV
pop
line 150
;150:	}
LABELV $109
line 153
;151:
;152:	// get all arenas from .arena files
;153:	numdirs = trap_FS_GetFileList("scripts", ".arena", dirlist, 1024 );
ADDRGP4 $113
ARGP4
ADDRGP4 $114
ARGP4
ADDRLP4 420
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1444
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 144
ADDRLP4 1444
INDIRI4
ASGNI4
line 154
;154:	dirptr  = dirlist;
ADDRLP4 4
ADDRLP4 420
ASGNP4
line 155
;155:	for (i = 0; i < numdirs; i++, dirptr += dirlen+1) {
ADDRLP4 136
CNSTI4 0
ASGNI4
ADDRGP4 $118
JUMPV
LABELV $115
line 156
;156:		dirlen = strlen(dirptr);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 1448
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 140
ADDRLP4 1448
INDIRI4
ASGNI4
line 157
;157:		strcpy(filename, "scripts/");
ADDRLP4 8
ARGP4
ADDRGP4 $119
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 158
;158:		strcat(filename, dirptr);
ADDRLP4 8
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 159
;159:		G_LoadArenasFromFile(filename);
ADDRLP4 8
ARGP4
ADDRGP4 G_LoadArenasFromFile
CALLV
pop
line 160
;160:	}
LABELV $116
line 155
ADDRLP4 1448
CNSTI4 1
ASGNI4
ADDRLP4 136
ADDRLP4 136
INDIRI4
ADDRLP4 1448
INDIRI4
ADDI4
ASGNI4
ADDRLP4 4
ADDRLP4 140
INDIRI4
ADDRLP4 1448
INDIRI4
ADDI4
ADDRLP4 4
INDIRP4
ADDP4
ASGNP4
LABELV $118
ADDRLP4 136
INDIRI4
ADDRLP4 144
INDIRI4
LTI4 $115
line 161
;161:	trap_Printf( va( "%i arenas parsed\n", g_numArenas ) );
ADDRGP4 $120
ARGP4
ADDRGP4 g_numArenas
INDIRI4
ARGI4
ADDRLP4 1452
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1452
INDIRP4
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 163
;162:	
;163:	for( n = 0; n < g_numArenas; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $124
JUMPV
LABELV $121
line 164
;164:		Info_SetValueForKey( g_arenaInfos[n], "num", va( "%i", n ) );
ADDRGP4 $126
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1456
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_arenaInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $125
ARGP4
ADDRLP4 1456
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 165
;165:	}
LABELV $122
line 163
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $124
ADDRLP4 0
INDIRI4
ADDRGP4 g_numArenas
INDIRI4
LTI4 $121
line 166
;166:}
LABELV $105
endproc G_LoadArenas 1460 16
export G_GetArenaInfoByMap
proc G_GetArenaInfoByMap 12 8
line 174
;167:
;168:
;169:/*
;170:===============
;171:G_GetArenaInfoByNumber
;172:===============
;173:*/
;174:const char *G_GetArenaInfoByMap( const char *map ) {
line 177
;175:	int			n;
;176:
;177:	for( n = 0; n < g_numArenas; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $131
JUMPV
LABELV $128
line 178
;178:		if( Q_stricmp( Info_ValueForKey( g_arenaInfos[n], "map" ), map ) == 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_arenaInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $134
ARGP4
ADDRLP4 4
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $132
line 179
;179:			return g_arenaInfos[n];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_arenaInfos
ADDP4
INDIRP4
RETP4
ADDRGP4 $127
JUMPV
LABELV $132
line 181
;180:		}
;181:	}
LABELV $129
line 177
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $131
ADDRLP4 0
INDIRI4
ADDRGP4 g_numArenas
INDIRI4
LTI4 $128
line 183
;182:
;183:	return NULL;
CNSTP4 0
RETP4
LABELV $127
endproc G_GetArenaInfoByMap 12 8
proc PlayerIntroSound 80 12
line 192
;184:}
;185:
;186:
;187:/*
;188:=================
;189:PlayerIntroSound
;190:=================
;191:*/
;192:static void PlayerIntroSound( const char *modelAndSkin ) {
line 196
;193:	char	model[MAX_QPATH];
;194:	char	*skin;
;195:
;196:	Q_strncpyz( model, modelAndSkin, sizeof(model) );
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 197
;197:	skin = Q_strrchr( model, '/' );
ADDRLP4 4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 68
ADDRGP4 Q_strrchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 68
INDIRP4
ASGNP4
line 198
;198:	if ( skin ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $136
line 199
;199:		*skin++ = '\0';
ADDRLP4 72
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 72
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI1 0
ASGNI1
line 200
;200:	}
ADDRGP4 $137
JUMPV
LABELV $136
line 201
;201:	else {
line 202
;202:		skin = model;
ADDRLP4 0
ADDRLP4 4
ASGNP4
line 203
;203:	}
LABELV $137
line 205
;204:
;205:	if( Q_stricmp( skin, "default" ) == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $140
ARGP4
ADDRLP4 72
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $138
line 206
;206:		skin = model;
ADDRLP4 0
ADDRLP4 4
ASGNP4
line 207
;207:	}
LABELV $138
line 209
;208:
;209:	trap_SendConsoleCommand( EXEC_APPEND, va( "play sound/player/announce/%s.wav\n", skin ) );
ADDRGP4 $141
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 76
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 210
;210:}
LABELV $135
endproc PlayerIntroSound 80 12
export G_AddRandomBot
proc G_AddRandomBot 80 20
line 217
;211:
;212:/*
;213:===============
;214:G_AddRandomBot
;215:===============
;216:*/
;217:void G_AddRandomBot( int team ) {
line 223
;218:	int		i, n, num;
;219:	float	skill;
;220:	char	*value, netname[36], *teamstr;
;221:	gclient_t	*cl;
;222:
;223:	num = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 224
;224:	for ( n = 0; n < g_numBots ; n++ ) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $146
JUMPV
LABELV $143
line 225
;225:		value = Info_ValueForKey( g_botInfos[n], "name" );
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $147
ARGP4
ADDRLP4 64
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 64
INDIRP4
ASGNP4
line 227
;226:		//
;227:		for ( i=0 ; i< g_maxclients.integer ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $151
JUMPV
LABELV $148
line 228
;228:			cl = level.clients + i;
ADDRLP4 0
CNSTI4 10828
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 229
;229:			if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $153
line 230
;230:				continue;
ADDRGP4 $149
JUMPV
LABELV $153
line 232
;231:			}
;232:			if ( !(g_entities[cl->ps.clientNum].r.svFlags & SVF_BOT) ) {
CNSTI4 896
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $155
line 233
;233:				continue;
ADDRGP4 $149
JUMPV
LABELV $155
line 235
;234:			}
;235:			if ( team >= 0 && cl->sess.sessionTeam != team ) {
ADDRLP4 68
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
LTI4 $159
ADDRLP4 0
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
ADDRLP4 68
INDIRI4
EQI4 $159
line 236
;236:				continue;
ADDRGP4 $149
JUMPV
LABELV $159
line 238
;237:			}
;238:			if ( !Q_stricmp( value, cl->pers.netname ) ) {
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
ARGP4
ADDRLP4 72
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $161
line 239
;239:				break;
ADDRGP4 $150
JUMPV
LABELV $161
line 241
;240:			}
;241:		}
LABELV $149
line 227
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $151
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $148
LABELV $150
line 242
;242:		if (i >= g_maxclients.integer) {
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $163
line 243
;243:			num++;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 244
;244:		}
LABELV $163
line 245
;245:	}
LABELV $144
line 224
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $146
ADDRLP4 12
INDIRI4
ADDRGP4 g_numBots
INDIRI4
LTI4 $143
line 246
;246:	num = random() * num;
ADDRLP4 64
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 64
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 16
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 247
;247:	for ( n = 0; n < g_numBots ; n++ ) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $169
JUMPV
LABELV $166
line 248
;248:		value = Info_ValueForKey( g_botInfos[n], "name" );
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $147
ARGP4
ADDRLP4 68
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 68
INDIRP4
ASGNP4
line 250
;249:		//
;250:		for ( i=0 ; i< g_maxclients.integer ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $173
JUMPV
LABELV $170
line 251
;251:			cl = level.clients + i;
ADDRLP4 0
CNSTI4 10828
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 252
;252:			if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $175
line 253
;253:				continue;
ADDRGP4 $171
JUMPV
LABELV $175
line 255
;254:			}
;255:			if ( !(g_entities[cl->ps.clientNum].r.svFlags & SVF_BOT) ) {
CNSTI4 896
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $177
line 256
;256:				continue;
ADDRGP4 $171
JUMPV
LABELV $177
line 258
;257:			}
;258:			if ( team >= 0 && cl->sess.sessionTeam != team ) {
ADDRLP4 72
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
LTI4 $181
ADDRLP4 0
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
ADDRLP4 72
INDIRI4
EQI4 $181
line 259
;259:				continue;
ADDRGP4 $171
JUMPV
LABELV $181
line 261
;260:			}
;261:			if ( !Q_stricmp( value, cl->pers.netname ) ) {
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
ARGP4
ADDRLP4 76
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $183
line 262
;262:				break;
ADDRGP4 $172
JUMPV
LABELV $183
line 264
;263:			}
;264:		}
LABELV $171
line 250
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $173
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $170
LABELV $172
line 265
;265:		if (i >= g_maxclients.integer) {
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $185
line 266
;266:			num--;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 267
;267:			if (num <= 0) {
ADDRLP4 16
INDIRI4
CNSTI4 0
GTI4 $188
line 268
;268:				skill = trap_Cvar_VariableValue( "g_spSkill" );
ADDRGP4 $190
ARGP4
ADDRLP4 72
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 56
ADDRLP4 72
INDIRF4
ASGNF4
line 269
;269:				if (team == TEAM_RED) teamstr = "red";
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $191
ADDRLP4 60
ADDRGP4 $193
ASGNP4
ADDRGP4 $192
JUMPV
LABELV $191
line 270
;270:				else if (team == TEAM_BLUE) teamstr = "blue";
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $194
ADDRLP4 60
ADDRGP4 $196
ASGNP4
ADDRGP4 $195
JUMPV
LABELV $194
line 271
;271:				else teamstr = "";
ADDRLP4 60
ADDRGP4 $107
ASGNP4
LABELV $195
LABELV $192
line 272
;272:				strncpy(netname, value, sizeof(netname)-1);
ADDRLP4 20
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 35
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 273
;273:				netname[sizeof(netname)-1] = '\0';
ADDRLP4 20+35
CNSTI1 0
ASGNI1
line 274
;274:				Q_CleanStr(netname);
ADDRLP4 20
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 275
;275:				trap_SendConsoleCommand( EXEC_INSERT, va("addbot %s %f %s %i\n", netname, skill, teamstr, 0) );
ADDRGP4 $198
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 76
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 1
ARGI4
ADDRLP4 76
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 276
;276:				return;
ADDRGP4 $142
JUMPV
LABELV $188
line 278
;277:			}
;278:		}
LABELV $185
line 279
;279:	}
LABELV $167
line 247
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $169
ADDRLP4 12
INDIRI4
ADDRGP4 g_numBots
INDIRI4
LTI4 $166
line 280
;280:}
LABELV $142
endproc G_AddRandomBot 80 20
export G_RemoveRandomBot
proc G_RemoveRandomBot 52 8
line 287
;281:
;282:/*
;283:===============
;284:G_RemoveRandomBot
;285:===============
;286:*/
;287:int G_RemoveRandomBot( int team ) {
line 292
;288:	int i;
;289:	char netname[36];
;290:	gclient_t	*cl;
;291:
;292:	for ( i=0 ; i< g_maxclients.integer ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $203
JUMPV
LABELV $200
line 293
;293:		cl = level.clients + i;
ADDRLP4 0
CNSTI4 10828
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 294
;294:		if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $205
line 295
;295:			continue;
ADDRGP4 $201
JUMPV
LABELV $205
line 297
;296:		}
;297:		if ( !(g_entities[cl->ps.clientNum].r.svFlags & SVF_BOT) ) {
CNSTI4 896
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $207
line 298
;298:			continue;
ADDRGP4 $201
JUMPV
LABELV $207
line 300
;299:		}
;300:		if ( team >= 0 && cl->sess.sessionTeam != team ) {
ADDRLP4 44
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
LTI4 $211
ADDRLP4 0
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
ADDRLP4 44
INDIRI4
EQI4 $211
line 301
;301:			continue;
ADDRGP4 $201
JUMPV
LABELV $211
line 303
;302:		}
;303:		strcpy(netname, cl->pers.netname);
ADDRLP4 8
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 304
;304:		Q_CleanStr(netname);
ADDRLP4 8
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 305
;305:		trap_SendConsoleCommand( EXEC_INSERT, va("kick %s\n", netname) );
ADDRGP4 $213
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 48
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 1
ARGI4
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 306
;306:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $199
JUMPV
LABELV $201
line 292
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $203
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $200
line 308
;307:	}
;308:	return qfalse;
CNSTI4 0
RETI4
LABELV $199
endproc G_RemoveRandomBot 52 8
export G_CountHumanPlayers
proc G_CountHumanPlayers 16 0
line 316
;309:}
;310:
;311:/*
;312:===============
;313:G_CountHumanPlayers
;314:===============
;315:*/
;316:int G_CountHumanPlayers( int team ) {
line 320
;317:	int i, num;
;318:	gclient_t	*cl;
;319:
;320:	num = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 321
;321:	for ( i=0 ; i< g_maxclients.integer ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $218
JUMPV
LABELV $215
line 322
;322:		cl = level.clients + i;
ADDRLP4 0
CNSTI4 10828
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 323
;323:		if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $220
line 324
;324:			continue;
ADDRGP4 $216
JUMPV
LABELV $220
line 326
;325:		}
;326:		if ( g_entities[cl->ps.clientNum].r.svFlags & SVF_BOT ) {
CNSTI4 896
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $222
line 327
;327:			continue;
ADDRGP4 $216
JUMPV
LABELV $222
line 329
;328:		}
;329:		if ( team >= 0 && cl->sess.sessionTeam != team ) {
ADDRLP4 12
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
LTI4 $226
ADDRLP4 0
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $226
line 330
;330:			continue;
ADDRGP4 $216
JUMPV
LABELV $226
line 332
;331:		}
;332:		num++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 333
;333:	}
LABELV $216
line 321
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $218
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $215
line 334
;334:	return num;
ADDRLP4 8
INDIRI4
RETI4
LABELV $214
endproc G_CountHumanPlayers 16 0
export G_CountBotPlayers
proc G_CountBotPlayers 20 0
line 342
;335:}
;336:
;337:/*
;338:===============
;339:G_CountBotPlayers
;340:===============
;341:*/
;342:int G_CountBotPlayers( int team ) {
line 346
;343:	int i, n, num;
;344:	gclient_t	*cl;
;345:
;346:	num = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 347
;347:	for ( i=0 ; i< g_maxclients.integer ; i++ ) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $232
JUMPV
LABELV $229
line 348
;348:		cl = level.clients + i;
ADDRLP4 4
CNSTI4 10828
ADDRLP4 8
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 349
;349:		if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $234
line 350
;350:			continue;
ADDRGP4 $230
JUMPV
LABELV $234
line 352
;351:		}
;352:		if ( !(g_entities[cl->ps.clientNum].r.svFlags & SVF_BOT) ) {
CNSTI4 896
ADDRLP4 4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $236
line 353
;353:			continue;
ADDRGP4 $230
JUMPV
LABELV $236
line 355
;354:		}
;355:		if ( team >= 0 && cl->sess.sessionTeam != team ) {
ADDRLP4 16
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
LTI4 $240
ADDRLP4 4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $240
line 356
;356:			continue;
ADDRGP4 $230
JUMPV
LABELV $240
line 358
;357:		}
;358:		num++;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 359
;359:	}
LABELV $230
line 347
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $232
ADDRLP4 8
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $229
line 360
;360:	for( n = 0; n < BOT_SPAWN_QUEUE_DEPTH; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $242
line 361
;361:		if( !botSpawnQueue[n].spawnTime ) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue+4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $246
line 362
;362:			continue;
ADDRGP4 $243
JUMPV
LABELV $246
line 364
;363:		}
;364:		if ( botSpawnQueue[n].spawnTime > level.time ) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue+4
ADDP4
INDIRI4
ADDRGP4 level+40
INDIRI4
LEI4 $249
line 365
;365:			continue;
ADDRGP4 $243
JUMPV
LABELV $249
line 367
;366:		}
;367:		num++;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 368
;368:	}
LABELV $243
line 360
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $242
line 369
;369:	return num;
ADDRLP4 12
INDIRI4
RETI4
LABELV $228
endproc G_CountBotPlayers 20 0
bss
align 4
LABELV $254
skip 4
export G_CheckMinimumPlayers
code
proc G_CheckMinimumPlayers 36 4
line 377
;370:}
;371:
;372:/*
;373:===============
;374:G_CheckMinimumPlayers
;375:===============
;376:*/
;377:void G_CheckMinimumPlayers( void ) {
line 382
;378:	int minplayers;
;379:	int humanplayers, botplayers;
;380:	static int checkminimumplayers_time;
;381:
;382:	if (level.intermissiontime) return;
ADDRGP4 level+9160
INDIRI4
CNSTI4 0
EQI4 $255
ADDRGP4 $253
JUMPV
LABELV $255
line 384
;383:	//only check once each 10 seconds
;384:	if (checkminimumplayers_time > level.time - 10000) {
ADDRGP4 $254
INDIRI4
ADDRGP4 level+40
INDIRI4
CNSTI4 10000
SUBI4
LEI4 $258
line 385
;385:		return;
ADDRGP4 $253
JUMPV
LABELV $258
line 387
;386:	}
;387:	checkminimumplayers_time = level.time;
ADDRGP4 $254
ADDRGP4 level+40
INDIRI4
ASGNI4
line 388
;388:	trap_Cvar_Update(&bot_minplayers);
ADDRGP4 bot_minplayers
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 389
;389:	minplayers = bot_minplayers.integer;
ADDRLP4 0
ADDRGP4 bot_minplayers+12
INDIRI4
ASGNI4
line 390
;390:	if (minplayers <= 0) return;
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $263
ADDRGP4 $253
JUMPV
LABELV $263
line 392
;391:
;392:	if (g_gametype.integer >= GT_TEAM) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $265
line 393
;393:		if (minplayers >= g_maxclients.integer / 2) {
ADDRLP4 0
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
CNSTI4 2
DIVI4
LTI4 $268
line 394
;394:			minplayers = (g_maxclients.integer / 2) -1;
ADDRLP4 0
ADDRGP4 g_maxclients+12
INDIRI4
CNSTI4 2
DIVI4
CNSTI4 1
SUBI4
ASGNI4
line 395
;395:		}
LABELV $268
line 397
;396:
;397:		humanplayers = G_CountHumanPlayers( TEAM_RED );
CNSTI4 1
ARGI4
ADDRLP4 12
ADDRGP4 G_CountHumanPlayers
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 398
;398:		botplayers = G_CountBotPlayers(	TEAM_RED );
CNSTI4 1
ARGI4
ADDRLP4 16
ADDRGP4 G_CountBotPlayers
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
ASGNI4
line 400
;399:		//
;400:		if (humanplayers + botplayers < minplayers) {
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
GEI4 $272
line 401
;401:			G_AddRandomBot( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 G_AddRandomBot
CALLV
pop
line 402
;402:		} else if (humanplayers + botplayers > minplayers && botplayers) {
ADDRGP4 $273
JUMPV
LABELV $272
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
LEI4 $274
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $274
line 403
;403:			G_RemoveRandomBot( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 G_RemoveRandomBot
CALLI4
pop
line 404
;404:		}
LABELV $274
LABELV $273
line 406
;405:		//
;406:		humanplayers = G_CountHumanPlayers( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRLP4 24
ADDRGP4 G_CountHumanPlayers
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 24
INDIRI4
ASGNI4
line 407
;407:		botplayers = G_CountBotPlayers( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRLP4 28
ADDRGP4 G_CountBotPlayers
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 28
INDIRI4
ASGNI4
line 409
;408:		//
;409:		if (humanplayers + botplayers < minplayers) {
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
GEI4 $276
line 410
;410:			G_AddRandomBot( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 G_AddRandomBot
CALLV
pop
line 411
;411:		} else if (humanplayers + botplayers > minplayers && botplayers) {
ADDRGP4 $266
JUMPV
LABELV $276
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
LEI4 $266
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $266
line 412
;412:			G_RemoveRandomBot( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 G_RemoveRandomBot
CALLI4
pop
line 413
;413:		}
line 414
;414:	}
ADDRGP4 $266
JUMPV
LABELV $265
line 415
;415:	else if (g_gametype.integer == GT_TOURNAMENT ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $280
line 416
;416:		if (minplayers >= g_maxclients.integer) {
ADDRLP4 0
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $283
line 417
;417:			minplayers = g_maxclients.integer-1;
ADDRLP4 0
ADDRGP4 g_maxclients+12
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 418
;418:		}
LABELV $283
line 419
;419:		humanplayers = G_CountHumanPlayers( -1 );
CNSTI4 -1
ARGI4
ADDRLP4 12
ADDRGP4 G_CountHumanPlayers
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 420
;420:		botplayers = G_CountBotPlayers( -1 );
CNSTI4 -1
ARGI4
ADDRLP4 16
ADDRGP4 G_CountBotPlayers
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
ASGNI4
line 422
;421:		//
;422:		if (humanplayers + botplayers < minplayers) {
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
GEI4 $287
line 423
;423:			G_AddRandomBot( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRGP4 G_AddRandomBot
CALLV
pop
line 424
;424:		} else if (humanplayers + botplayers > minplayers && botplayers) {
ADDRGP4 $281
JUMPV
LABELV $287
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
LEI4 $281
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $281
line 426
;425:			// try to remove spectators first
;426:			if (!G_RemoveRandomBot( TEAM_SPECTATOR )) {
CNSTI4 3
ARGI4
ADDRLP4 24
ADDRGP4 G_RemoveRandomBot
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $281
line 428
;427:				// just remove the bot that is playing
;428:				G_RemoveRandomBot( -1 );
CNSTI4 -1
ARGI4
ADDRGP4 G_RemoveRandomBot
CALLI4
pop
line 429
;429:			}
line 430
;430:		}
line 431
;431:	}
ADDRGP4 $281
JUMPV
LABELV $280
line 432
;432:	else if (g_gametype.integer == GT_FFA) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 0
NEI4 $293
line 433
;433:		if (minplayers >= g_maxclients.integer) {
ADDRLP4 0
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $296
line 434
;434:			minplayers = g_maxclients.integer-1;
ADDRLP4 0
ADDRGP4 g_maxclients+12
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 435
;435:		}
LABELV $296
line 436
;436:		humanplayers = G_CountHumanPlayers( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRLP4 12
ADDRGP4 G_CountHumanPlayers
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 437
;437:		botplayers = G_CountBotPlayers( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRLP4 16
ADDRGP4 G_CountBotPlayers
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
ASGNI4
line 439
;438:		//
;439:		if (humanplayers + botplayers < minplayers) {
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
GEI4 $300
line 440
;440:			G_AddRandomBot( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRGP4 G_AddRandomBot
CALLV
pop
line 441
;441:		} else if (humanplayers + botplayers > minplayers && botplayers) {
ADDRGP4 $301
JUMPV
LABELV $300
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
LEI4 $302
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $302
line 442
;442:			G_RemoveRandomBot( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRGP4 G_RemoveRandomBot
CALLI4
pop
line 443
;443:		}
LABELV $302
LABELV $301
line 444
;444:	}
LABELV $293
LABELV $281
LABELV $266
line 445
;445:}
LABELV $253
endproc G_CheckMinimumPlayers 36 4
export G_CheckBotSpawn
proc G_CheckBotSpawn 1032 12
line 452
;446:
;447:/*
;448:===============
;449:G_CheckBotSpawn
;450:===============
;451:*/
;452:void G_CheckBotSpawn( void ) {
line 456
;453:	int		n;
;454:	char	userinfo[MAX_INFO_VALUE];
;455:
;456:	G_CheckMinimumPlayers();
ADDRGP4 G_CheckMinimumPlayers
CALLV
pop
line 458
;457:
;458:	for( n = 0; n < BOT_SPAWN_QUEUE_DEPTH; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $305
line 459
;459:		if( !botSpawnQueue[n].spawnTime ) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue+4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $309
line 460
;460:			continue;
ADDRGP4 $306
JUMPV
LABELV $309
line 462
;461:		}
;462:		if ( botSpawnQueue[n].spawnTime > level.time ) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue+4
ADDP4
INDIRI4
ADDRGP4 level+40
INDIRI4
LEI4 $312
line 463
;463:			continue;
ADDRGP4 $306
JUMPV
LABELV $312
line 465
;464:		}
;465:		ClientBegin( botSpawnQueue[n].clientNum );
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue
ADDP4
INDIRI4
ARGI4
ADDRGP4 ClientBegin
CALLV
pop
line 466
;466:		botSpawnQueue[n].spawnTime = 0;
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue+4
ADDP4
CNSTI4 0
ASGNI4
line 468
;467:
;468:		if( g_gametype.integer == GT_SINGLE_PLAYER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
NEI4 $317
line 469
;469:			trap_GetUserinfo( botSpawnQueue[n].clientNum, userinfo, sizeof(userinfo) );
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 470
;470:			PlayerIntroSound( Info_ValueForKey (userinfo, "model") );
ADDRLP4 4
ARGP4
ADDRGP4 $320
ARGP4
ADDRLP4 1028
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 PlayerIntroSound
CALLV
pop
line 471
;471:		}
LABELV $317
line 472
;472:	}
LABELV $306
line 458
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $305
line 473
;473:}
LABELV $304
endproc G_CheckBotSpawn 1032 12
proc AddBotToSpawnQueue 4 4
line 481
;474:
;475:
;476:/*
;477:===============
;478:AddBotToSpawnQueue
;479:===============
;480:*/
;481:static void AddBotToSpawnQueue( int clientNum, int delay ) {
line 484
;482:	int		n;
;483:
;484:	for( n = 0; n < BOT_SPAWN_QUEUE_DEPTH; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $322
line 485
;485:		if( !botSpawnQueue[n].spawnTime ) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue+4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $326
line 486
;486:			botSpawnQueue[n].spawnTime = level.time + delay;
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue+4
ADDP4
ADDRGP4 level+40
INDIRI4
ADDRFP4 4
INDIRI4
ADDI4
ASGNI4
line 487
;487:			botSpawnQueue[n].clientNum = clientNum;
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 488
;488:			return;
ADDRGP4 $321
JUMPV
LABELV $326
line 490
;489:		}
;490:	}
LABELV $323
line 484
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $322
line 492
;491:
;492:	G_Printf( S_COLOR_YELLOW "Unable to delay spawn\n" );
ADDRGP4 $331
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 493
;493:	ClientBegin( clientNum );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 ClientBegin
CALLV
pop
line 494
;494:}
LABELV $321
endproc AddBotToSpawnQueue 4 4
export G_RemoveQueuedBotBegin
proc G_RemoveQueuedBotBegin 4 0
line 505
;495:
;496:
;497:/*
;498:===============
;499:G_RemoveQueuedBotBegin
;500:
;501:Called on client disconnect to make sure the delayed spawn
;502:doesn't happen on a freed index
;503:===============
;504:*/
;505:void G_RemoveQueuedBotBegin( int clientNum ) {
line 508
;506:	int		n;
;507:
;508:	for( n = 0; n < BOT_SPAWN_QUEUE_DEPTH; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $333
line 509
;509:		if( botSpawnQueue[n].clientNum == clientNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $337
line 510
;510:			botSpawnQueue[n].spawnTime = 0;
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue+4
ADDP4
CNSTI4 0
ASGNI4
line 511
;511:			return;
ADDRGP4 $332
JUMPV
LABELV $337
line 513
;512:		}
;513:	}
LABELV $334
line 508
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $333
line 514
;514:}
LABELV $332
endproc G_RemoveQueuedBotBegin 4 0
export G_BotConnect
proc G_BotConnect 1336 12
line 522
;515:
;516:
;517:/*
;518:===============
;519:G_BotConnect
;520:===============
;521:*/
;522:qboolean G_BotConnect( int clientNum, qboolean restart ) {
line 526
;523:	bot_settings_t	settings;
;524:	char			userinfo[MAX_INFO_STRING];
;525:
;526:	trap_GetUserinfo( clientNum, userinfo, sizeof(userinfo) );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 528
;527:
;528:	Q_strncpyz( settings.characterfile, Info_ValueForKey( userinfo, "characterfile" ), sizeof(settings.characterfile) );
ADDRLP4 292
ARGP4
ADDRGP4 $341
ARGP4
ADDRLP4 1316
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRLP4 1316
INDIRP4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 529
;529:	settings.skill = atof( Info_ValueForKey( userinfo, "skill" ) );
ADDRLP4 292
ARGP4
ADDRGP4 $343
ARGP4
ADDRLP4 1320
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1320
INDIRP4
ARGP4
ADDRLP4 1324
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 0+144
ADDRLP4 1324
INDIRF4
ASGNF4
line 530
;530:	Q_strncpyz( settings.team, Info_ValueForKey( userinfo, "team" ), sizeof(settings.team) );
ADDRLP4 292
ARGP4
ADDRGP4 $345
ARGP4
ADDRLP4 1328
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0+148
ARGP4
ADDRLP4 1328
INDIRP4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 532
;531:
;532:	if (!BotAISetupClient( clientNum, &settings, restart )) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 1332
ADDRGP4 BotAISetupClient
CALLI4
ASGNI4
ADDRLP4 1332
INDIRI4
CNSTI4 0
NEI4 $347
line 533
;533:		trap_DropClient( clientNum, "BotAISetupClient failed" );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $349
ARGP4
ADDRGP4 trap_DropClient
CALLV
pop
line 534
;534:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $340
JUMPV
LABELV $347
line 537
;535:	}
;536:
;537:	return qtrue;
CNSTI4 1
RETI4
LABELV $340
endproc G_BotConnect 1336 12
proc G_AddBot 1152 20
line 546
;538:}
;539:
;540:
;541:/*
;542:===============
;543:G_AddBot
;544:===============
;545:*/
;546:static void G_AddBot( const char *name, float skill, const char *team, int delay, char *altname) {
line 560
;547:	int				clientNum;
;548:	char			*botinfo;
;549:	gentity_t		*bot;
;550:	char			*key;
;551:	char			*s;
;552:	char			*color1, *color2;
;553:	char			*botname;
;554:	char			*model;
;555:	char			*headmodel;
;556:	char			userinfo[MAX_INFO_STRING];
;557:	char			colors[8];
;558:
;559:	// get the botinfo from bots.txt
;560:	botinfo = G_GetBotInfoByName( name );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1072
ADDRGP4 G_GetBotInfoByName
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 1072
INDIRP4
ASGNP4
line 561
;561:	if ( !botinfo ) {
ADDRLP4 1028
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $351
line 562
;562:		G_Printf( S_COLOR_RED "Error: Bot '%s' not defined\n", name );
ADDRGP4 $353
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 563
;563:		return;
ADDRGP4 $350
JUMPV
LABELV $351
line 567
;564:	}
;565:
;566:	// create the bot's userinfo
;567:	userinfo[0] = '\0';
ADDRLP4 4
CNSTI1 0
ASGNI1
line 569
;568:
;569:	botname = Info_ValueForKey( botinfo, "funname" );
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 $354
ARGP4
ADDRLP4 1076
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1048
ADDRLP4 1076
INDIRP4
ASGNP4
line 570
;570:	if( !botname[0] ) {
ADDRLP4 1048
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $355
line 571
;571:		botname = Info_ValueForKey( botinfo, "name" );
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 $147
ARGP4
ADDRLP4 1080
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1048
ADDRLP4 1080
INDIRP4
ASGNP4
line 572
;572:	}
LABELV $355
line 574
;573:	// check for an alternative name
;574:	if (altname && altname[0]) {
ADDRLP4 1080
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 1080
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $357
ADDRLP4 1080
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $357
line 575
;575:		botname = altname;
ADDRLP4 1048
ADDRFP4 16
INDIRP4
ASGNP4
line 576
;576:	}
LABELV $357
line 577
;577:	Info_SetValueForKey( userinfo, "name", botname );
ADDRLP4 4
ARGP4
ADDRGP4 $147
ARGP4
ADDRLP4 1048
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 578
;578:	Info_SetValueForKey( userinfo, "rate", "25000" );
ADDRLP4 4
ARGP4
ADDRGP4 $359
ARGP4
ADDRGP4 $360
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 579
;579:	Info_SetValueForKey( userinfo, "snaps", "20" );
ADDRLP4 4
ARGP4
ADDRGP4 $361
ARGP4
ADDRGP4 $362
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 580
;580:	Info_SetValueForKey( userinfo, "skill", va("%1.2f", skill) );
ADDRGP4 $363
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 1084
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
ADDRGP4 $343
ARGP4
ADDRLP4 1084
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 582
;581:
;582:	if ( skill >= 1 && skill < 2 ) {
ADDRLP4 1088
ADDRFP4 4
INDIRF4
ASGNF4
ADDRLP4 1088
INDIRF4
CNSTF4 1065353216
LTF4 $364
ADDRLP4 1088
INDIRF4
CNSTF4 1073741824
GEF4 $364
line 583
;583:		Info_SetValueForKey( userinfo, "handicap", "50" );
ADDRLP4 4
ARGP4
ADDRGP4 $366
ARGP4
ADDRGP4 $367
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 584
;584:	}
ADDRGP4 $365
JUMPV
LABELV $364
line 585
;585:	else if ( skill >= 2 && skill < 3 ) {
ADDRLP4 1092
ADDRFP4 4
INDIRF4
ASGNF4
ADDRLP4 1092
INDIRF4
CNSTF4 1073741824
LTF4 $368
ADDRLP4 1092
INDIRF4
CNSTF4 1077936128
GEF4 $368
line 586
;586:		Info_SetValueForKey( userinfo, "handicap", "70" );
ADDRLP4 4
ARGP4
ADDRGP4 $366
ARGP4
ADDRGP4 $370
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 587
;587:	}
ADDRGP4 $369
JUMPV
LABELV $368
line 588
;588:	else if ( skill >= 3 && skill < 4 ) {
ADDRLP4 1096
ADDRFP4 4
INDIRF4
ASGNF4
ADDRLP4 1096
INDIRF4
CNSTF4 1077936128
LTF4 $371
ADDRLP4 1096
INDIRF4
CNSTF4 1082130432
GEF4 $371
line 589
;589:		Info_SetValueForKey( userinfo, "handicap", "90" );
ADDRLP4 4
ARGP4
ADDRGP4 $366
ARGP4
ADDRGP4 $373
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 590
;590:	}
LABELV $371
LABELV $369
LABELV $365
line 592
;591:
;592:	key = "model";
ADDRLP4 0
ADDRGP4 $320
ASGNP4
line 593
;593:	model = Info_ValueForKey( botinfo, key );
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1100
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1040
ADDRLP4 1100
INDIRP4
ASGNP4
line 594
;594:	if ( !*model ) {
ADDRLP4 1040
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $374
line 595
;595:		model = "visor/default";
ADDRLP4 1040
ADDRGP4 $376
ASGNP4
line 596
;596:	}
LABELV $374
line 597
;597:	Info_SetValueForKey( userinfo, key, model );
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1040
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 598
;598:	key = "team_model";
ADDRLP4 0
ADDRGP4 $377
ASGNP4
line 599
;599:	Info_SetValueForKey( userinfo, key, model );
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1040
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 601
;600:
;601:	key = "headmodel";
ADDRLP4 0
ADDRGP4 $378
ASGNP4
line 602
;602:	headmodel = Info_ValueForKey( botinfo, key );
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1104
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1044
ADDRLP4 1104
INDIRP4
ASGNP4
line 603
;603:	if ( !*headmodel ) {
ADDRLP4 1044
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $379
line 604
;604:		headmodel = model;
ADDRLP4 1044
ADDRLP4 1040
INDIRP4
ASGNP4
line 605
;605:	}
LABELV $379
line 606
;606:	Info_SetValueForKey( userinfo, key, headmodel );
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1044
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 607
;607:	key = "team_headmodel";
ADDRLP4 0
ADDRGP4 $381
ASGNP4
line 608
;608:	Info_SetValueForKey( userinfo, key, headmodel );
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1044
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 610
;609:
;610:	key = "gender";
ADDRLP4 0
ADDRGP4 $382
ASGNP4
line 611
;611:	s = Info_ValueForKey( botinfo, key );
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1108
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1036
ADDRLP4 1108
INDIRP4
ASGNP4
line 612
;612:	if ( !*s ) {
ADDRLP4 1036
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $383
line 613
;613:		s = "male";
ADDRLP4 1036
ADDRGP4 $385
ASGNP4
line 614
;614:	}
LABELV $383
line 615
;615:	Info_SetValueForKey( userinfo, "sex", s );
ADDRLP4 4
ARGP4
ADDRGP4 $386
ARGP4
ADDRLP4 1036
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 630
;616:
;617:	/*key = "color1";
;618:	s = Info_ValueForKey( botinfo, key );
;619:	if ( !*s ) {
;620:		s = "4";
;621:	}
;622:	Info_SetValueForKey( userinfo, key, s );
;623:
;624:	key = "color2";
;625:	s = Info_ValueForKey( botinfo, key );
;626:	if ( !*s ) {
;627:		s = "5";
;628:	}
;629:	Info_SetValueForKey( userinfo, key, s );*/
;630:	key = "color1";
ADDRLP4 0
ADDRGP4 $387
ASGNP4
line 631
;631:	color1 = Info_ValueForKey( botinfo, key );
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1112
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1052
ADDRLP4 1112
INDIRP4
ASGNP4
line 632
;632:	if ( !*color1 ) {
ADDRLP4 1052
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $388
line 633
;633:		color1 = "1";
ADDRLP4 1052
ADDRGP4 $390
ASGNP4
line 634
;634:	}
LABELV $388
line 637
;635:	//Info_SetValueForKey( userinfo, key, s );
;636:
;637:	key = "color2";
ADDRLP4 0
ADDRGP4 $391
ASGNP4
line 638
;638:	color2 = Info_ValueForKey( botinfo, key );
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1116
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1056
ADDRLP4 1116
INDIRP4
ASGNP4
line 639
;639:	if ( !*color2 ) {
ADDRLP4 1056
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $392
line 640
;640:		color2 = "6";
ADDRLP4 1056
ADDRGP4 $394
ASGNP4
line 641
;641:	}
LABELV $392
line 645
;642:	//key = "color1";
;643:	//Info_SetValueForKey( userinfo, key, s );
;644:	//PM Skin / Colors for bots.
;645:	Com_sprintf(colors, sizeof(colors), "%s777%s", color1, color2);
ADDRLP4 1064
ARGP4
CNSTI4 8
ARGI4
ADDRGP4 $395
ARGP4
ADDRLP4 1052
INDIRP4
ARGP4
ADDRLP4 1056
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 646
;646:	Info_SetValueForKey( userinfo, "colors", colors );
ADDRLP4 4
ARGP4
ADDRGP4 $396
ARGP4
ADDRLP4 1064
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 648
;647:
;648:	s = Info_ValueForKey(botinfo, "aifile");
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 $397
ARGP4
ADDRLP4 1120
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1036
ADDRLP4 1120
INDIRP4
ASGNP4
line 649
;649:	if (!*s ) {
ADDRLP4 1036
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $398
line 650
;650:		trap_Printf( S_COLOR_RED "Error: bot has no aifile specified\n" );
ADDRGP4 $400
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 651
;651:		return;
ADDRGP4 $350
JUMPV
LABELV $398
line 655
;652:	}
;653:
;654:	// have the server allocate a client slot
;655:	clientNum = trap_BotAllocateClient();
ADDRLP4 1124
ADDRGP4 trap_BotAllocateClient
CALLI4
ASGNI4
ADDRLP4 1032
ADDRLP4 1124
INDIRI4
ASGNI4
line 656
;656:	if ( clientNum == -1 ) {
ADDRLP4 1032
INDIRI4
CNSTI4 -1
NEI4 $401
line 657
;657:		G_Printf( S_COLOR_RED "Unable to add bot.  All player slots are in use.\n" );
ADDRGP4 $403
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 658
;658:		G_Printf( S_COLOR_RED "Start server with more 'open' slots (or check setting of sv_maxclients cvar).\n" );
ADDRGP4 $404
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 659
;659:		return;
ADDRGP4 $350
JUMPV
LABELV $401
line 663
;660:	}
;661:
;662:	// initialize the bot settings
;663:	if( !team || !*team ) {
ADDRLP4 1128
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 1128
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $407
ADDRLP4 1128
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $405
LABELV $407
line 664
;664:		if( g_gametype.integer >= GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $408
line 665
;665:			if( PickTeam(clientNum) == TEAM_RED) {
ADDRLP4 1032
INDIRI4
ARGI4
ADDRLP4 1132
ADDRGP4 PickTeam
CALLI4
ASGNI4
ADDRLP4 1132
INDIRI4
CNSTI4 1
NEI4 $411
line 666
;666:				team = "red";
ADDRFP4 8
ADDRGP4 $193
ASGNP4
line 667
;667:			}
ADDRGP4 $409
JUMPV
LABELV $411
line 668
;668:			else {
line 669
;669:				team = "blue";
ADDRFP4 8
ADDRGP4 $196
ASGNP4
line 670
;670:			}
line 671
;671:		}
ADDRGP4 $409
JUMPV
LABELV $408
line 672
;672:		else {
line 673
;673:			team = "red";
ADDRFP4 8
ADDRGP4 $193
ASGNP4
line 674
;674:		}
LABELV $409
line 675
;675:	}
LABELV $405
line 676
;676:	Info_SetValueForKey( userinfo, "characterfile", Info_ValueForKey( botinfo, "aifile" ) );
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 $397
ARGP4
ADDRLP4 1132
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
ADDRGP4 $341
ARGP4
ADDRLP4 1132
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 677
;677:	Info_SetValueForKey( userinfo, "skill", va( "%5.2f", skill ) );
ADDRGP4 $413
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 1136
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
ADDRGP4 $343
ARGP4
ADDRLP4 1136
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 678
;678:	Info_SetValueForKey( userinfo, "team", team );
ADDRLP4 4
ARGP4
ADDRGP4 $345
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 680
;679:
;680:	bot = &g_entities[ clientNum ];
ADDRLP4 1060
CNSTI4 896
ADDRLP4 1032
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 681
;681:	bot->r.svFlags |= SVF_BOT;
ADDRLP4 1140
ADDRLP4 1060
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 1140
INDIRP4
ADDRLP4 1140
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 682
;682:	bot->inuse = qtrue;
ADDRLP4 1060
INDIRP4
CNSTI4 520
ADDP4
CNSTI4 1
ASGNI4
line 685
;683:
;684:	// register the userinfo
;685:	trap_SetUserinfo( clientNum, userinfo );
ADDRLP4 1032
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_SetUserinfo
CALLV
pop
line 688
;686:
;687:	// have it connect to the game as a normal client
;688:	if ( ClientConnect( clientNum, qtrue, qtrue ) ) {
ADDRLP4 1032
INDIRI4
ARGI4
ADDRLP4 1144
CNSTI4 1
ASGNI4
ADDRLP4 1144
INDIRI4
ARGI4
ADDRLP4 1144
INDIRI4
ARGI4
ADDRLP4 1148
ADDRGP4 ClientConnect
CALLP4
ASGNP4
ADDRLP4 1148
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $414
line 689
;689:		return;
ADDRGP4 $350
JUMPV
LABELV $414
line 692
;690:	}
;691:
;692:	if( delay == 0 ) {
ADDRFP4 12
INDIRI4
CNSTI4 0
NEI4 $416
line 693
;693:		ClientBegin( clientNum );
ADDRLP4 1032
INDIRI4
ARGI4
ADDRGP4 ClientBegin
CALLV
pop
line 694
;694:		return;
ADDRGP4 $350
JUMPV
LABELV $416
line 697
;695:	}
;696:
;697:	AddBotToSpawnQueue( clientNum, delay );
ADDRLP4 1032
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 AddBotToSpawnQueue
CALLV
pop
line 698
;698:}
LABELV $350
endproc G_AddBot 1152 20
export Svcmd_AddBot_f
proc Svcmd_AddBot_f 4112 20
line 706
;699:
;700:
;701:/*
;702:===============
;703:Svcmd_AddBot_f
;704:===============
;705:*/
;706:void Svcmd_AddBot_f( void ) {
line 715
;707:	float			skill;
;708:	int				delay;
;709:	char			name[MAX_TOKEN_CHARS];
;710:	char			altname[MAX_TOKEN_CHARS];
;711:	char			string[MAX_TOKEN_CHARS];
;712:	char			team[MAX_TOKEN_CHARS];
;713:
;714:	// are bots enabled?
;715:	if ( !trap_Cvar_VariableIntegerValue( "bot_enable" ) ) {
ADDRGP4 $421
ARGP4
ADDRLP4 4104
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 4104
INDIRI4
CNSTI4 0
NEI4 $419
line 716
;716:		return;
ADDRGP4 $418
JUMPV
LABELV $419
line 720
;717:	}
;718:
;719:	// name
;720:	trap_Argv( 1, name, sizeof( name ) );
CNSTI4 1
ARGI4
ADDRLP4 1024
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 721
;721:	if ( !name[0] ) {
ADDRLP4 1024
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $422
line 722
;722:		trap_Printf( "Usage: Addbot <botname> [skill 1-5] [team] [msec delay] [altname]\n" );
ADDRGP4 $424
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 723
;723:		return;
ADDRGP4 $418
JUMPV
LABELV $422
line 727
;724:	}
;725:
;726:	// skill
;727:	trap_Argv( 2, string, sizeof( string ) );
CNSTI4 2
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 728
;728:	if ( !string[0] ) {
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $425
line 729
;729:		skill = 4;
ADDRLP4 4096
CNSTF4 1082130432
ASGNF4
line 730
;730:	}
ADDRGP4 $426
JUMPV
LABELV $425
line 731
;731:	else {
line 732
;732:		skill = atof( string );
ADDRLP4 0
ARGP4
ADDRLP4 4108
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 4096
ADDRLP4 4108
INDIRF4
ASGNF4
line 733
;733:	}
LABELV $426
line 736
;734:
;735:	// team
;736:	trap_Argv( 3, team, sizeof( team ) );
CNSTI4 3
ARGI4
ADDRLP4 3072
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 739
;737:
;738:	// delay
;739:	trap_Argv( 4, string, sizeof( string ) );
CNSTI4 4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 740
;740:	if ( !string[0] ) {
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $427
line 741
;741:		delay = 0;
ADDRLP4 4100
CNSTI4 0
ASGNI4
line 742
;742:	}
ADDRGP4 $428
JUMPV
LABELV $427
line 743
;743:	else {
line 744
;744:		delay = atoi( string );
ADDRLP4 0
ARGP4
ADDRLP4 4108
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4100
ADDRLP4 4108
INDIRI4
ASGNI4
line 745
;745:	}
LABELV $428
line 748
;746:
;747:	// alternative name
;748:	trap_Argv( 5, altname, sizeof( altname ) );
CNSTI4 5
ARGI4
ADDRLP4 2048
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 750
;749:
;750:	G_AddBot( name, skill, team, delay, altname );
ADDRLP4 1024
ARGP4
ADDRLP4 4096
INDIRF4
ARGF4
ADDRLP4 3072
ARGP4
ADDRLP4 4100
INDIRI4
ARGI4
ADDRLP4 2048
ARGP4
ADDRGP4 G_AddBot
CALLV
pop
line 754
;751:
;752:	// if this was issued during gameplay and we are playing locally,
;753:	// go ahead and load the bot's media immediately
;754:	if ( level.time - level.startTime > 1000 &&
ADDRGP4 level+40
INDIRI4
ADDRGP4 level+48
INDIRI4
SUBI4
CNSTI4 1000
LEI4 $429
ADDRGP4 $433
ARGP4
ADDRLP4 4108
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 4108
INDIRI4
CNSTI4 0
EQI4 $429
line 755
;755:		trap_Cvar_VariableIntegerValue( "cl_running" ) ) {
line 756
;756:		trap_SendServerCommand( -1, "loaddefered\n" );	// FIXME: spelled wrong, but not changing for demo
CNSTI4 -1
ARGI4
ADDRGP4 $434
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 757
;757:	}
LABELV $429
line 758
;758:}
LABELV $418
endproc Svcmd_AddBot_f 4112 20
export Svcmd_BotList_f
proc Svcmd_BotList_f 4120 20
line 765
;759:
;760:/*
;761:===============
;762:Svcmd_BotList_f
;763:===============
;764:*/
;765:void Svcmd_BotList_f( void ) {
line 772
;766:	int i;
;767:	char name[MAX_TOKEN_CHARS];
;768:	char funname[MAX_TOKEN_CHARS];
;769:	char model[MAX_TOKEN_CHARS];
;770:	char aifile[MAX_TOKEN_CHARS];
;771:
;772:	trap_Printf("^1name             model            aifile              funname\n");
ADDRGP4 $436
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 773
;773:	for (i = 0; i < g_numBots; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $440
JUMPV
LABELV $437
line 774
;774:		strcpy(name, Info_ValueForKey( g_botInfos[i], "name" ));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $147
ARGP4
ADDRLP4 4100
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
ADDRLP4 4100
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 775
;775:		if ( !*name ) {
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $441
line 776
;776:			strcpy(name, "UnnamedPlayer");
ADDRLP4 4
ARGP4
ADDRGP4 $443
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 777
;777:		}
LABELV $441
line 778
;778:		strcpy(funname, Info_ValueForKey( g_botInfos[i], "funname" ));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $354
ARGP4
ADDRLP4 4104
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
ARGP4
ADDRLP4 4104
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 779
;779:		if ( !*funname ) {
ADDRLP4 1028
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $444
line 780
;780:			strcpy(funname, "");
ADDRLP4 1028
ARGP4
ADDRGP4 $107
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 781
;781:		}
LABELV $444
line 782
;782:		strcpy(model, Info_ValueForKey( g_botInfos[i], "model" ));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $320
ARGP4
ADDRLP4 4108
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 2052
ARGP4
ADDRLP4 4108
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 783
;783:		if ( !*model ) {
ADDRLP4 2052
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $446
line 784
;784:			strcpy(model, "visor/default");
ADDRLP4 2052
ARGP4
ADDRGP4 $376
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 785
;785:		}
LABELV $446
line 786
;786:		strcpy(aifile, Info_ValueForKey( g_botInfos[i], "aifile"));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $397
ARGP4
ADDRLP4 4112
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 3076
ARGP4
ADDRLP4 4112
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 787
;787:		if (!*aifile ) {
ADDRLP4 3076
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $448
line 788
;788:			strcpy(aifile, "bots/default_c.c");
ADDRLP4 3076
ARGP4
ADDRGP4 $450
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 789
;789:		}
LABELV $448
line 790
;790:		trap_Printf(va("%-16s %-16s %-20s %-20s\n", name, model, aifile, funname));
ADDRGP4 $451
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 2052
ARGP4
ADDRLP4 3076
ARGP4
ADDRLP4 1028
ARGP4
ADDRLP4 4116
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4116
INDIRP4
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 791
;791:	}
LABELV $438
line 773
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $440
ADDRLP4 0
INDIRI4
ADDRGP4 g_numBots
INDIRI4
LTI4 $437
line 792
;792:}
LABELV $435
endproc Svcmd_BotList_f 4120 20
proc G_SpawnBots 1056 16
line 800
;793:
;794:
;795:/*
;796:===============
;797:G_SpawnBots
;798:===============
;799:*/
;800:static void G_SpawnBots( char *botList, int baseDelay ) {
line 807
;801:	char		*bot;
;802:	char		*p;
;803:	float		skill;
;804:	int			delay;
;805:	char		bots[MAX_INFO_VALUE];
;806:
;807:	podium1 = NULL;
ADDRGP4 podium1
CNSTP4 0
ASGNP4
line 808
;808:	podium2 = NULL;
ADDRGP4 podium2
CNSTP4 0
ASGNP4
line 809
;809:	podium3 = NULL;
ADDRGP4 podium3
CNSTP4 0
ASGNP4
line 811
;810:
;811:	skill = trap_Cvar_VariableValue( "g_spSkill" );
ADDRGP4 $190
ARGP4
ADDRLP4 1040
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 12
ADDRLP4 1040
INDIRF4
ASGNF4
line 812
;812:	if( skill < 1 ) {
ADDRLP4 12
INDIRF4
CNSTF4 1065353216
GEF4 $453
line 813
;813:		trap_Cvar_Set( "g_spSkill", "1" );
ADDRGP4 $190
ARGP4
ADDRGP4 $390
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 814
;814:		skill = 1;
ADDRLP4 12
CNSTF4 1065353216
ASGNF4
line 815
;815:	}
ADDRGP4 $454
JUMPV
LABELV $453
line 816
;816:	else if ( skill > 5 ) {
ADDRLP4 12
INDIRF4
CNSTF4 1084227584
LEF4 $455
line 817
;817:		trap_Cvar_Set( "g_spSkill", "5" );
ADDRGP4 $190
ARGP4
ADDRGP4 $457
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 818
;818:		skill = 5;
ADDRLP4 12
CNSTF4 1084227584
ASGNF4
line 819
;819:	}
LABELV $455
LABELV $454
line 821
;820:
;821:	Q_strncpyz( bots, botList, sizeof(bots) );
ADDRLP4 16
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 822
;822:	p = &bots[0];
ADDRLP4 0
ADDRLP4 16
ASGNP4
line 823
;823:	delay = baseDelay;
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRGP4 $459
JUMPV
line 824
;824:	while( *p ) {
LABELV $461
line 826
;825:		//skip spaces
;826:		while( *p && *p == ' ' ) {
line 827
;827:			p++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 828
;828:		}
LABELV $462
line 826
ADDRLP4 1044
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
EQI4 $464
ADDRLP4 1044
INDIRI4
CNSTI4 32
EQI4 $461
LABELV $464
line 829
;829:		if( !p ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $465
line 830
;830:			break;
ADDRGP4 $460
JUMPV
LABELV $465
line 834
;831:		}
;832:
;833:		// mark start of bot name
;834:		bot = p;
ADDRLP4 8
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 $468
JUMPV
LABELV $467
line 837
;835:
;836:		// skip until space of null
;837:		while( *p && *p != ' ' ) {
line 838
;838:			p++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 839
;839:		}
LABELV $468
line 837
ADDRLP4 1048
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
EQI4 $470
ADDRLP4 1048
INDIRI4
CNSTI4 32
NEI4 $467
LABELV $470
line 840
;840:		if( *p ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $471
line 841
;841:			*p++ = 0;
ADDRLP4 1052
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 1052
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 1052
INDIRP4
CNSTI1 0
ASGNI1
line 842
;842:		}
LABELV $471
line 846
;843:
;844:		// we must add the bot this way, calling G_AddBot directly at this stage
;845:		// does "Bad Things"
;846:		trap_SendConsoleCommand( EXEC_INSERT, va("addbot %s %f free %i\n", bot, skill, delay) );
ADDRGP4 $473
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 1052
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 1
ARGI4
ADDRLP4 1052
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 848
;847:
;848:		delay += BOT_BEGIN_DELAY_INCREMENT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1500
ADDI4
ASGNI4
line 849
;849:	}
LABELV $459
line 824
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $462
LABELV $460
line 850
;850:}
LABELV $452
endproc G_SpawnBots 1056 16
proc G_LoadBotsFromFile 8216 16
line 858
;851:
;852:
;853:/*
;854:===============
;855:G_LoadBotsFromFile
;856:===============
;857:*/
;858:static void G_LoadBotsFromFile( char *filename ) {
line 863
;859:	int				len;
;860:	fileHandle_t	f;
;861:	char			buf[MAX_BOTS_TEXT];
;862:
;863:	len = trap_FS_FOpenFile( filename, &f, FS_READ );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8200
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8200
INDIRI4
ASGNI4
line 864
;864:	if ( !f ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $475
line 865
;865:		trap_Printf( va( S_COLOR_RED "file not found: %s\n", filename ) );
ADDRGP4 $101
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8204
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8204
INDIRP4
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 866
;866:		return;
ADDRGP4 $474
JUMPV
LABELV $475
line 868
;867:	}
;868:	if ( len >= MAX_BOTS_TEXT ) {
ADDRLP4 0
INDIRI4
CNSTI4 8192
LTI4 $477
line 869
;869:		trap_Printf( va( S_COLOR_RED "file too large: %s is %i, max allowed is %i", filename, len, MAX_BOTS_TEXT ) );
ADDRGP4 $104
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 8192
ARGI4
ADDRLP4 8204
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8204
INDIRP4
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 870
;870:		trap_FS_FCloseFile( f );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 871
;871:		return;
ADDRGP4 $474
JUMPV
LABELV $477
line 874
;872:	}
;873:
;874:	trap_FS_Read( buf, len, f );
ADDRLP4 8
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 875
;875:	buf[len] = 0;
ADDRLP4 0
INDIRI4
ADDRLP4 8
ADDP4
CNSTI1 0
ASGNI1
line 876
;876:	trap_FS_FCloseFile( f );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 878
;877:
;878:	g_numBots += G_ParseInfos( buf, MAX_BOTS - g_numBots, &g_botInfos[g_numBots] );
ADDRLP4 8
ARGP4
ADDRLP4 8204
ADDRGP4 g_numBots
ASGNP4
ADDRLP4 8208
ADDRLP4 8204
INDIRP4
INDIRI4
ASGNI4
CNSTI4 1024
ADDRLP4 8208
INDIRI4
SUBI4
ARGI4
ADDRLP4 8208
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
ARGP4
ADDRLP4 8212
ADDRGP4 G_ParseInfos
CALLI4
ASGNI4
ADDRLP4 8204
INDIRP4
ADDRLP4 8208
INDIRI4
ADDRLP4 8212
INDIRI4
ADDI4
ASGNI4
line 879
;879:}
LABELV $474
endproc G_LoadBotsFromFile 8216 16
proc G_LoadBots 1456 16
line 886
;880:
;881:/*
;882:===============
;883:G_LoadBots
;884:===============
;885:*/
;886:static void G_LoadBots( void ) {
line 895
;887:	vmCvar_t	botsFile;
;888:	int			numdirs;
;889:	char		filename[128];
;890:	char		dirlist[1024];
;891:	char*		dirptr;
;892:	int			i;
;893:	int			dirlen;
;894:
;895:	if ( !trap_Cvar_VariableIntegerValue( "bot_enable" ) ) {
ADDRGP4 $421
ARGP4
ADDRLP4 1440
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 1440
INDIRI4
CNSTI4 0
NEI4 $480
line 896
;896:		return;
ADDRGP4 $479
JUMPV
LABELV $480
line 899
;897:	}
;898:
;899:	g_numBots = 0;
ADDRGP4 g_numBots
CNSTI4 0
ASGNI4
line 901
;900:
;901:	trap_Cvar_Register( &botsFile, "g_botsFile", "", CVAR_INIT|CVAR_ROM );
ADDRLP4 144
ARGP4
ADDRGP4 $482
ARGP4
ADDRGP4 $107
ARGP4
CNSTI4 80
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 902
;902:	if( *botsFile.string ) {
ADDRLP4 144+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $483
line 903
;903:		G_LoadBotsFromFile(botsFile.string);
ADDRLP4 144+16
ARGP4
ADDRGP4 G_LoadBotsFromFile
CALLV
pop
line 904
;904:	}
ADDRGP4 $484
JUMPV
LABELV $483
line 905
;905:	else {
line 906
;906:		G_LoadBotsFromFile("scripts/bots.txt");
ADDRGP4 $487
ARGP4
ADDRGP4 G_LoadBotsFromFile
CALLV
pop
line 907
;907:	}
LABELV $484
line 910
;908:
;909:	// get all bots from .bot files
;910:	numdirs = trap_FS_GetFileList("scripts", ".bot", dirlist, 1024 );
ADDRGP4 $113
ARGP4
ADDRGP4 $488
ARGP4
ADDRLP4 416
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1444
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 140
ADDRLP4 1444
INDIRI4
ASGNI4
line 911
;911:	dirptr  = dirlist;
ADDRLP4 0
ADDRLP4 416
ASGNP4
line 912
;912:	for (i = 0; i < numdirs; i++, dirptr += dirlen+1) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $492
JUMPV
LABELV $489
line 913
;913:		dirlen = strlen(dirptr);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1448
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 136
ADDRLP4 1448
INDIRI4
ASGNI4
line 914
;914:		strcpy(filename, "scripts/");
ADDRLP4 4
ARGP4
ADDRGP4 $119
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 915
;915:		strcat(filename, dirptr);
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 916
;916:		G_LoadBotsFromFile(filename);
ADDRLP4 4
ARGP4
ADDRGP4 G_LoadBotsFromFile
CALLV
pop
line 917
;917:	}
LABELV $490
line 912
ADDRLP4 1448
CNSTI4 1
ASGNI4
ADDRLP4 132
ADDRLP4 132
INDIRI4
ADDRLP4 1448
INDIRI4
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 136
INDIRI4
ADDRLP4 1448
INDIRI4
ADDI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
LABELV $492
ADDRLP4 132
INDIRI4
ADDRLP4 140
INDIRI4
LTI4 $489
line 918
;918:	trap_Printf( va( "%i bots parsed\n", g_numBots ) );
ADDRGP4 $493
ARGP4
ADDRGP4 g_numBots
INDIRI4
ARGI4
ADDRLP4 1452
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1452
INDIRP4
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 919
;919:}
LABELV $479
endproc G_LoadBots 1456 16
export G_GetBotInfoByNumber
proc G_GetBotInfoByNumber 8 8
line 928
;920:
;921:
;922:
;923:/*
;924:===============
;925:G_GetBotInfoByNumber
;926:===============
;927:*/
;928:char *G_GetBotInfoByNumber( int num ) {
line 929
;929:	if( num < 0 || num >= g_numBots ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $497
ADDRLP4 0
INDIRI4
ADDRGP4 g_numBots
INDIRI4
LTI4 $495
LABELV $497
line 930
;930:		trap_Printf( va( S_COLOR_RED "Invalid bot number: %i\n", num ) );
ADDRGP4 $498
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 931
;931:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $494
JUMPV
LABELV $495
line 933
;932:	}
;933:	return g_botInfos[num];
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
RETP4
LABELV $494
endproc G_GetBotInfoByNumber 8 8
export G_GetBotInfoByName
proc G_GetBotInfoByName 16 8
line 942
;934:}
;935:
;936:
;937:/*
;938:===============
;939:G_GetBotInfoByName
;940:===============
;941:*/
;942:char *G_GetBotInfoByName( const char *name ) {
line 946
;943:	int		n;
;944:	char	*value;
;945:
;946:	for ( n = 0; n < g_numBots ; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $503
JUMPV
LABELV $500
line 947
;947:		value = Info_ValueForKey( g_botInfos[n], "name" );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $147
ARGP4
ADDRLP4 8
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 948
;948:		if ( !Q_stricmp( value, name ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $504
line 949
;949:			return g_botInfos[n];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
RETP4
ADDRGP4 $499
JUMPV
LABELV $504
line 951
;950:		}
;951:	}
LABELV $501
line 946
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $503
ADDRLP4 0
INDIRI4
ADDRGP4 g_numBots
INDIRI4
LTI4 $500
line 953
;952:
;953:	return NULL;
CNSTP4 0
RETP4
LABELV $499
endproc G_GetBotInfoByName 16 8
export G_InitBots
proc G_InitBots 1148 16
line 961
;954:}
;955:
;956:/*
;957:===============
;958:G_InitBots
;959:===============
;960:*/
;961:void G_InitBots( qboolean restart ) {
line 970
;962:	int			fragLimit;
;963:	int			timeLimit;
;964:	const char	*arenainfo;
;965:	char		*strValue;
;966:	int			basedelay;
;967:	char		map[MAX_QPATH];
;968:	char		serverinfo[MAX_INFO_STRING];
;969:
;970:	G_LoadBots();
ADDRGP4 G_LoadBots
CALLV
pop
line 971
;971:	G_LoadArenas();
ADDRGP4 G_LoadArenas
CALLV
pop
line 973
;972:
;973:	trap_Cvar_Register( &bot_minplayers, "bot_minplayers", "0", CVAR_SERVERINFO );
ADDRGP4 bot_minplayers
ARGP4
ADDRGP4 $507
ARGP4
ADDRGP4 $508
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 975
;974:
;975:	if( g_gametype.integer == GT_SINGLE_PLAYER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
NEI4 $509
line 976
;976:		trap_GetServerinfo( serverinfo, sizeof(serverinfo) );
ADDRLP4 80
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetServerinfo
CALLV
pop
line 977
;977:		Q_strncpyz( map, Info_ValueForKey( serverinfo, "mapname" ), sizeof(map) );
ADDRLP4 80
ARGP4
ADDRGP4 $512
ARGP4
ADDRLP4 1108
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 16
ARGP4
ADDRLP4 1108
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 978
;978:		arenainfo = G_GetArenaInfoByMap( map );
ADDRLP4 16
ARGP4
ADDRLP4 1112
ADDRGP4 G_GetArenaInfoByMap
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 1112
INDIRP4
ASGNP4
line 979
;979:		if ( !arenainfo ) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $513
line 980
;980:			return;
ADDRGP4 $506
JUMPV
LABELV $513
line 983
;981:		}
;982:
;983:		strValue = Info_ValueForKey( arenainfo, "fraglimit" );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $515
ARGP4
ADDRLP4 1116
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1116
INDIRP4
ASGNP4
line 984
;984:		fragLimit = atoi( strValue );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1120
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 1120
INDIRI4
ASGNI4
line 985
;985:		if ( fragLimit ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $516
line 986
;986:			trap_Cvar_Set( "fraglimit", strValue );
ADDRGP4 $515
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 987
;987:		}
ADDRGP4 $517
JUMPV
LABELV $516
line 988
;988:		else {
line 989
;989:			trap_Cvar_Set( "fraglimit", "0" );
ADDRGP4 $515
ARGP4
ADDRGP4 $508
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 990
;990:		}
LABELV $517
line 992
;991:
;992:		strValue = Info_ValueForKey( arenainfo, "timelimit" );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $518
ARGP4
ADDRLP4 1124
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1124
INDIRP4
ASGNP4
line 993
;993:		timeLimit = atoi( strValue );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1128
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 1128
INDIRI4
ASGNI4
line 994
;994:		if ( timeLimit ) {
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $519
line 995
;995:			trap_Cvar_Set( "timelimit", strValue );
ADDRGP4 $518
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 996
;996:		}
ADDRGP4 $520
JUMPV
LABELV $519
line 997
;997:		else {
line 998
;998:			trap_Cvar_Set( "timelimit", "0" );
ADDRGP4 $518
ARGP4
ADDRGP4 $508
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 999
;999:		}
LABELV $520
line 1001
;1000:
;1001:		if ( !fragLimit && !timeLimit ) {
ADDRLP4 1132
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRI4
ADDRLP4 1132
INDIRI4
NEI4 $521
ADDRLP4 12
INDIRI4
ADDRLP4 1132
INDIRI4
NEI4 $521
line 1002
;1002:			trap_Cvar_Set( "fraglimit", "10" );
ADDRGP4 $515
ARGP4
ADDRGP4 $523
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1003
;1003:			trap_Cvar_Set( "timelimit", "0" );
ADDRGP4 $518
ARGP4
ADDRGP4 $508
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1004
;1004:		}
LABELV $521
line 1006
;1005:
;1006:		basedelay = BOT_BEGIN_DELAY_BASE;
ADDRLP4 1104
CNSTI4 2000
ASGNI4
line 1007
;1007:		strValue = Info_ValueForKey( arenainfo, "special" );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $524
ARGP4
ADDRLP4 1136
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1136
INDIRP4
ASGNP4
line 1008
;1008:		if( Q_stricmp( strValue, "training" ) == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $527
ARGP4
ADDRLP4 1140
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1140
INDIRI4
CNSTI4 0
NEI4 $525
line 1009
;1009:			basedelay += 10000;
ADDRLP4 1104
ADDRLP4 1104
INDIRI4
CNSTI4 10000
ADDI4
ASGNI4
line 1010
;1010:		}
LABELV $525
line 1012
;1011:
;1012:		if( !restart ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $528
line 1013
;1013:			G_SpawnBots( Info_ValueForKey( arenainfo, "bots" ), basedelay );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $530
ARGP4
ADDRLP4 1144
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1144
INDIRP4
ARGP4
ADDRLP4 1104
INDIRI4
ARGI4
ADDRGP4 G_SpawnBots
CALLV
pop
line 1014
;1014:		}
LABELV $528
line 1015
;1015:	}
LABELV $509
line 1016
;1016:}
LABELV $506
endproc G_InitBots 1148 16
import podium3
import podium2
import podium1
bss
export bot_minplayers
align 4
LABELV bot_minplayers
skip 272
align 4
LABELV botSpawnQueue
skip 128
align 4
LABELV g_arenaInfos
skip 4096
export g_numArenas
align 4
LABELV g_numArenas
skip 4
align 4
LABELV g_botInfos
skip 4096
align 4
LABELV g_numBots
skip 4
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
LABELV $530
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $527
byte 1 116
byte 1 114
byte 1 97
byte 1 105
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $524
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 105
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $523
byte 1 49
byte 1 48
byte 1 0
align 1
LABELV $518
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $515
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $512
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $508
byte 1 48
byte 1 0
align 1
LABELV $507
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 109
byte 1 105
byte 1 110
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $498
byte 1 94
byte 1 49
byte 1 73
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 98
byte 1 111
byte 1 116
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
byte 1 10
byte 1 0
align 1
LABELV $493
byte 1 37
byte 1 105
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $488
byte 1 46
byte 1 98
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $487
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 47
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 46
byte 1 116
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $482
byte 1 103
byte 1 95
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 70
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $473
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
byte 1 37
byte 1 102
byte 1 32
byte 1 102
byte 1 114
byte 1 101
byte 1 101
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $457
byte 1 53
byte 1 0
align 1
LABELV $451
byte 1 37
byte 1 45
byte 1 49
byte 1 54
byte 1 115
byte 1 32
byte 1 37
byte 1 45
byte 1 49
byte 1 54
byte 1 115
byte 1 32
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 32
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $450
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 47
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 95
byte 1 99
byte 1 46
byte 1 99
byte 1 0
align 1
LABELV $443
byte 1 85
byte 1 110
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 100
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $436
byte 1 94
byte 1 49
byte 1 110
byte 1 97
byte 1 109
byte 1 101
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
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
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
byte 1 97
byte 1 105
byte 1 102
byte 1 105
byte 1 108
byte 1 101
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
byte 1 102
byte 1 117
byte 1 110
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $434
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
byte 1 10
byte 1 0
align 1
LABELV $433
byte 1 99
byte 1 108
byte 1 95
byte 1 114
byte 1 117
byte 1 110
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $424
byte 1 85
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 65
byte 1 100
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 60
byte 1 98
byte 1 111
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 62
byte 1 32
byte 1 91
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 32
byte 1 49
byte 1 45
byte 1 53
byte 1 93
byte 1 32
byte 1 91
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 93
byte 1 32
byte 1 91
byte 1 109
byte 1 115
byte 1 101
byte 1 99
byte 1 32
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 93
byte 1 32
byte 1 91
byte 1 97
byte 1 108
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 93
byte 1 10
byte 1 0
align 1
LABELV $421
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $413
byte 1 37
byte 1 53
byte 1 46
byte 1 50
byte 1 102
byte 1 0
align 1
LABELV $404
byte 1 94
byte 1 49
byte 1 83
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 39
byte 1 111
byte 1 112
byte 1 101
byte 1 110
byte 1 39
byte 1 32
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 115
byte 1 32
byte 1 40
byte 1 111
byte 1 114
byte 1 32
byte 1 99
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 111
byte 1 102
byte 1 32
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
byte 1 32
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 41
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $403
byte 1 94
byte 1 49
byte 1 85
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 97
byte 1 100
byte 1 100
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 46
byte 1 32
byte 1 32
byte 1 65
byte 1 108
byte 1 108
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $400
byte 1 94
byte 1 49
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 58
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 97
byte 1 105
byte 1 102
byte 1 105
byte 1 108
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
byte 1 10
byte 1 0
align 1
LABELV $397
byte 1 97
byte 1 105
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $396
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $395
byte 1 37
byte 1 115
byte 1 55
byte 1 55
byte 1 55
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $394
byte 1 54
byte 1 0
align 1
LABELV $391
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 50
byte 1 0
align 1
LABELV $390
byte 1 49
byte 1 0
align 1
LABELV $387
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 49
byte 1 0
align 1
LABELV $386
byte 1 115
byte 1 101
byte 1 120
byte 1 0
align 1
LABELV $385
byte 1 109
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $382
byte 1 103
byte 1 101
byte 1 110
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $381
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
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
LABELV $378
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
LABELV $377
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $376
byte 1 118
byte 1 105
byte 1 115
byte 1 111
byte 1 114
byte 1 47
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $373
byte 1 57
byte 1 48
byte 1 0
align 1
LABELV $370
byte 1 55
byte 1 48
byte 1 0
align 1
LABELV $367
byte 1 53
byte 1 48
byte 1 0
align 1
LABELV $366
byte 1 104
byte 1 97
byte 1 110
byte 1 100
byte 1 105
byte 1 99
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $363
byte 1 37
byte 1 49
byte 1 46
byte 1 50
byte 1 102
byte 1 0
align 1
LABELV $362
byte 1 50
byte 1 48
byte 1 0
align 1
LABELV $361
byte 1 115
byte 1 110
byte 1 97
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $360
byte 1 50
byte 1 53
byte 1 48
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $359
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $354
byte 1 102
byte 1 117
byte 1 110
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $353
byte 1 94
byte 1 49
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 58
byte 1 32
byte 1 66
byte 1 111
byte 1 116
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 105
byte 1 110
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $349
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
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $345
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $343
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $341
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $331
byte 1 94
byte 1 51
byte 1 85
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $320
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $213
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $198
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
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $196
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $193
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $190
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $147
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $141
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
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
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 117
byte 1 110
byte 1 99
byte 1 101
byte 1 47
byte 1 37
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 10
byte 1 0
align 1
LABELV $140
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $134
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $126
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $125
byte 1 110
byte 1 117
byte 1 109
byte 1 0
align 1
LABELV $120
byte 1 37
byte 1 105
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 115
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $119
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 47
byte 1 0
align 1
LABELV $114
byte 1 46
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 0
align 1
LABELV $113
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $112
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 47
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 115
byte 1 46
byte 1 116
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $107
byte 1 0
align 1
LABELV $106
byte 1 103
byte 1 95
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 115
byte 1 70
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $104
byte 1 94
byte 1 49
byte 1 102
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
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 44
byte 1 32
byte 1 109
byte 1 97
byte 1 120
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $101
byte 1 94
byte 1 49
byte 1 102
byte 1 105
byte 1 108
byte 1 101
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
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $95
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $94
byte 1 92
byte 1 110
byte 1 117
byte 1 109
byte 1 92
byte 1 0
align 1
LABELV $93
byte 1 60
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 62
byte 1 0
align 1
LABELV $90
byte 1 125
byte 1 0
align 1
LABELV $87
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
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $81
byte 1 77
byte 1 97
byte 1 120
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 115
byte 1 32
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 101
byte 1 100
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $78
byte 1 77
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 123
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $77
byte 1 123
byte 1 0
