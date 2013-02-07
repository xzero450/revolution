code
proc CG_DrawLoadingIcons 16 20
file "../cg_info.c"
line 21
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_info.c -- display information while data is being loading
;4:
;5:#include "cg_local.h"
;6:
;7:#define MAX_LOADING_PLAYER_ICONS	16
;8:#define MAX_LOADING_ITEM_ICONS		26
;9:
;10:static int			loadingPlayerIconCount;
;11:static int			loadingItemIconCount;
;12:static qhandle_t	loadingPlayerIcons[MAX_LOADING_PLAYER_ICONS];
;13:static qhandle_t	loadingItemIcons[MAX_LOADING_ITEM_ICONS];
;14:
;15:
;16:/*
;17:===================
;18:CG_DrawLoadingIcons
;19:===================
;20:*/
;21:static void CG_DrawLoadingIcons( void ) {
line 25
;22:	int		n;
;23:	int		x, y;
;24:
;25:	for( n = 0; n < loadingPlayerIconCount; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $81
JUMPV
LABELV $78
line 26
;26:		x = 16 + n * 78;
ADDRLP4 8
CNSTI4 78
ADDRLP4 0
INDIRI4
MULI4
CNSTI4 16
ADDI4
ASGNI4
line 27
;27:		y = 324-40;
ADDRLP4 4
CNSTI4 284
ASGNI4
line 28
;28:		CG_DrawPic( x, y, 64, 64, loadingPlayerIcons[n] );
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
CNSTF4 1115684864
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 loadingPlayerIcons
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 29
;29:	}
LABELV $79
line 25
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $81
ADDRLP4 0
INDIRI4
ADDRGP4 loadingPlayerIconCount
INDIRI4
LTI4 $78
line 31
;30:
;31:	for( n = 0; n < loadingItemIconCount; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $85
JUMPV
LABELV $82
line 32
;32:		y = 400-40;
ADDRLP4 4
CNSTI4 360
ASGNI4
line 33
;33:		if( n >= 13 ) {
ADDRLP4 0
INDIRI4
CNSTI4 13
LTI4 $86
line 34
;34:			y += 40;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 40
ADDI4
ASGNI4
line 35
;35:		}
LABELV $86
line 36
;36:		x = 16 + n % 13 * 48;
ADDRLP4 8
CNSTI4 48
ADDRLP4 0
INDIRI4
CNSTI4 13
MODI4
MULI4
CNSTI4 16
ADDI4
ASGNI4
line 37
;37:		CG_DrawPic( x, y, 32, 32, loadingItemIcons[n] );
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
CNSTF4 1107296256
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 loadingItemIcons
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 38
;38:	}
LABELV $83
line 31
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $85
ADDRLP4 0
INDIRI4
ADDRGP4 loadingItemIconCount
INDIRI4
LTI4 $82
line 39
;39:}
LABELV $77
endproc CG_DrawLoadingIcons 16 20
export CG_LoadingString
proc CG_LoadingString 0 12
line 48
;40:
;41:
;42:/*
;43:======================
;44:CG_LoadingString
;45:
;46:======================
;47:*/
;48:void CG_LoadingString( const char *s ) {
line 49
;49:	Q_strncpyz( cg.infoScreenText, s, sizeof( cg.infoScreenText ) );
ADDRGP4 cg+109440
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 51
;50:
;51:	trap_UpdateScreen();
ADDRGP4 trap_UpdateScreen
CALLV
pop
line 52
;52:}
LABELV $88
endproc CG_LoadingString 0 12
export CG_LoadingItem
proc CG_LoadingItem 16 4
line 59
;53:
;54:/*
;55:===================
;56:CG_LoadingItem
;57:===================
;58:*/
;59:void CG_LoadingItem( int itemNum ) {
line 62
;60:	gitem_t		*item;
;61:
;62:	item = &bg_itemlist[itemNum];
ADDRLP4 0
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 64
;63:	
;64:	if ( item->icon && loadingItemIconCount < MAX_LOADING_ITEM_ICONS ) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $92
ADDRGP4 loadingItemIconCount
INDIRI4
CNSTI4 26
GEI4 $92
line 65
;65:		loadingItemIcons[loadingItemIconCount++] = trap_R_RegisterShaderNoMip( item->icon );
ADDRLP4 8
ADDRGP4 loadingItemIconCount
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRP4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 loadingItemIcons
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 66
;66:	}
LABELV $92
line 68
;67:
;68:	CG_LoadingString( item->pickup_name );
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRP4
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 69
;69:}
LABELV $91
endproc CG_LoadingItem 16 4
export CG_LoadingClient
proc CG_LoadingClient 220 20
line 76
;70:
;71:/*
;72:===================
;73:CG_LoadingClient
;74:===================
;75:*/
;76:void CG_LoadingClient( int clientNum ) {
line 83
;77:	const char		*info;
;78:	char			*skin;
;79:	char			personality[MAX_QPATH];
;80:	char			model[MAX_QPATH];
;81:	char			iconName[MAX_QPATH];
;82:
;83:	info = CG_ConfigString( CS_PLAYERS + clientNum );
ADDRFP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 200
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 64
ADDRLP4 200
INDIRP4
ASGNP4
line 85
;84:
;85:	if ( loadingPlayerIconCount < MAX_LOADING_PLAYER_ICONS ) {
ADDRGP4 loadingPlayerIconCount
INDIRI4
CNSTI4 16
GEI4 $95
line 86
;86:		Q_strncpyz( model, Info_ValueForKey( info, "model" ), sizeof( model ) );
ADDRLP4 64
INDIRP4
ARGP4
ADDRGP4 $97
ARGP4
ADDRLP4 204
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 72
ARGP4
ADDRLP4 204
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 87
;87:		skin = Q_strrchr( model, '/' );
ADDRLP4 72
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 208
ADDRGP4 Q_strrchr
CALLP4
ASGNP4
ADDRLP4 68
ADDRLP4 208
INDIRP4
ASGNP4
line 88
;88:		if ( skin ) {
ADDRLP4 68
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $98
line 89
;89:			*skin++ = '\0';
ADDRLP4 212
ADDRLP4 68
INDIRP4
ASGNP4
ADDRLP4 68
ADDRLP4 212
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 212
INDIRP4
CNSTI1 0
ASGNI1
line 90
;90:		} else {
ADDRGP4 $99
JUMPV
LABELV $98
line 91
;91:			skin = "default";
ADDRLP4 68
ADDRGP4 $100
ASGNP4
line 92
;92:		}
LABELV $99
line 94
;93:
;94:		Com_sprintf( iconName, MAX_QPATH, "models/players/%s/icon_%s.tga", model, skin );
ADDRLP4 136
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $101
ARGP4
ADDRLP4 72
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 96
;95:		
;96:		loadingPlayerIcons[loadingPlayerIconCount] = trap_R_RegisterShaderNoMip( iconName );
ADDRLP4 136
ARGP4
ADDRLP4 212
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 loadingPlayerIconCount
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 loadingPlayerIcons
ADDP4
ADDRLP4 212
INDIRI4
ASGNI4
line 97
;97:		if ( !loadingPlayerIcons[loadingPlayerIconCount] ) {
ADDRGP4 loadingPlayerIconCount
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 loadingPlayerIcons
ADDP4
INDIRI4
CNSTI4 0
NEI4 $102
line 98
;98:			Com_sprintf( iconName, MAX_QPATH, "models/players/characters/%s/icon_%s.tga", model, skin );
ADDRLP4 136
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $104
ARGP4
ADDRLP4 72
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 99
;99:			loadingPlayerIcons[loadingPlayerIconCount] = trap_R_RegisterShaderNoMip( iconName );
ADDRLP4 136
ARGP4
ADDRLP4 216
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 loadingPlayerIconCount
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 loadingPlayerIcons
ADDP4
ADDRLP4 216
INDIRI4
ASGNI4
line 100
;100:		}
LABELV $102
line 101
;101:		if ( !loadingPlayerIcons[loadingPlayerIconCount] ) {
ADDRGP4 loadingPlayerIconCount
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 loadingPlayerIcons
ADDP4
INDIRI4
CNSTI4 0
NEI4 $105
line 102
;102:			Com_sprintf( iconName, MAX_QPATH, "models/players/%s/icon_%s.tga", DEFAULT_MODEL, "default" );
ADDRLP4 136
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $101
ARGP4
ADDRGP4 $107
ARGP4
ADDRGP4 $100
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 103
;103:			loadingPlayerIcons[loadingPlayerIconCount] = trap_R_RegisterShaderNoMip( iconName );
ADDRLP4 136
ARGP4
ADDRLP4 216
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 loadingPlayerIconCount
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 loadingPlayerIcons
ADDP4
ADDRLP4 216
INDIRI4
ASGNI4
line 104
;104:		}
LABELV $105
line 105
;105:		if ( loadingPlayerIcons[loadingPlayerIconCount] ) {
ADDRGP4 loadingPlayerIconCount
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 loadingPlayerIcons
ADDP4
INDIRI4
CNSTI4 0
EQI4 $108
line 106
;106:			loadingPlayerIconCount++;
ADDRLP4 216
ADDRGP4 loadingPlayerIconCount
ASGNP4
ADDRLP4 216
INDIRP4
ADDRLP4 216
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 107
;107:		}
LABELV $108
line 108
;108:	}
LABELV $95
line 110
;109:
;110:	Q_strncpyz( personality, Info_ValueForKey( info, "n" ), sizeof(personality) );
ADDRLP4 64
INDIRP4
ARGP4
ADDRGP4 $110
ARGP4
ADDRLP4 204
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRLP4 204
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 111
;111:	Q_CleanStr( personality );
ADDRLP4 0
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 113
;112:
;113:	if( cgs.gametype == GT_SINGLE_PLAYER ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 2
NEI4 $111
line 114
;114:		trap_S_RegisterSound( va( "sound/player/announce/%s.wav", personality ), qtrue );
ADDRGP4 $114
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 208
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 208
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 115
;115:	}
LABELV $111
line 117
;116:
;117:	CG_LoadingString( personality );
ADDRLP4 0
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 118
;118:}
LABELV $94
endproc CG_LoadingClient 220 20
export CG_DrawInformation
proc CG_DrawInformation 1144 36
line 128
;119:
;120:
;121:/*
;122:====================
;123:CG_DrawInformation
;124:
;125:Draw all the status / pacifier stuff during level loading
;126:====================
;127:*/
;128:void CG_DrawInformation( void ) {
line 138
;129:	const char	*s;
;130:	const char	*info;
;131:	const char	*sysInfo;
;132:	int			y;
;133:	int			value;
;134:	qhandle_t	levelshot;
;135:	qhandle_t	detail;
;136:	char		buf[1024];
;137:
;138:	info = CG_ConfigString( CS_SERVERINFO );
CNSTI4 0
ARGI4
ADDRLP4 1052
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 1052
INDIRP4
ASGNP4
line 139
;139:	sysInfo = CG_ConfigString( CS_SYSTEMINFO );
CNSTI4 1
ARGI4
ADDRLP4 1056
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 1044
ADDRLP4 1056
INDIRP4
ASGNP4
line 141
;140:
;141:	s = Info_ValueForKey( info, "mapname" );
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $116
ARGP4
ADDRLP4 1060
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1060
INDIRP4
ASGNP4
line 143
;142:	//For our auto screenshot and record
;143:	memset(autoFile.map, 0, sizeof(autoFile.map));
ADDRGP4 autoFile+1152
ARGP4
CNSTI4 0
ARGI4
CNSTI4 256
ARGI4
ADDRGP4 memset
CALLP4
pop
line 144
;144:	Q_strncpyz(autoFile.map, Info_ValueForKey( info, "mapname" ), sizeof(autoFile.map));
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $116
ARGP4
ADDRLP4 1064
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 autoFile+1152
ARGP4
ADDRLP4 1064
INDIRP4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 146
;145:	//
;146:	levelshot = trap_R_RegisterShaderNoMip( va( "levelshots/%s.tga", s ) );
ADDRGP4 $121
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1068
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1068
INDIRP4
ARGP4
ADDRLP4 1072
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 1040
ADDRLP4 1072
INDIRI4
ASGNI4
line 147
;147:	if ( !levelshot ) {
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $122
line 148
;148:		levelshot = trap_R_RegisterShaderNoMip( "menu/art/unknownmap" );
ADDRGP4 $124
ARGP4
ADDRLP4 1076
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 1040
ADDRLP4 1076
INDIRI4
ASGNI4
line 149
;149:	}
LABELV $122
line 150
;150:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 151
;151:	CG_DrawPic( 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, levelshot );
ADDRLP4 1076
CNSTF4 0
ASGNF4
ADDRLP4 1076
INDIRF4
ARGF4
ADDRLP4 1076
INDIRF4
ARGF4
CNSTF4 1142947840
ARGF4
CNSTF4 1139802112
ARGF4
ADDRLP4 1040
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 154
;152:
;153:	// blend a detail texture over it
;154:	detail = trap_R_RegisterShader( "levelShotDetail" );
ADDRGP4 $125
ARGP4
ADDRLP4 1080
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 1048
ADDRLP4 1080
INDIRI4
ASGNI4
line 155
;155:	trap_R_DrawStretchPic( 0, 0, cgs.glconfig.vidWidth, cgs.glconfig.vidHeight, 0, 0, 2.5, 2, detail );
ADDRLP4 1084
CNSTF4 0
ASGNF4
ADDRLP4 1084
INDIRF4
ARGF4
ADDRLP4 1084
INDIRF4
ARGF4
ADDRGP4 cgs+20100+11304
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 cgs+20100+11308
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 1084
INDIRF4
ARGF4
ADDRLP4 1084
INDIRF4
ARGF4
CNSTF4 1075838976
ARGF4
CNSTF4 1073741824
ARGF4
ADDRLP4 1048
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 158
;156:
;157:	// draw the icons of things as they are loaded
;158:	CG_DrawLoadingIcons();
ADDRGP4 CG_DrawLoadingIcons
CALLV
pop
line 162
;159:
;160:	// the first 150 rows are reserved for the client connection
;161:	// screen to write into
;162:	if ( cg.infoScreenText[0] ) {
ADDRGP4 cg+109440
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $130
line 163
;163:		UI_DrawProportionalString( 320, 128-32, va("Loading... %s", cg.infoScreenText),
ADDRGP4 $133
ARGP4
ADDRGP4 cg+109440
ARGP4
ADDRLP4 1088
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 320
ARGI4
CNSTI4 96
ARGI4
ADDRLP4 1088
INDIRP4
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 165
;164:			UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;165:	} else {
ADDRGP4 $131
JUMPV
LABELV $130
line 166
;166:		UI_DrawProportionalString( 320, 128-32, "Awaiting snapshot...",
CNSTI4 320
ARGI4
CNSTI4 96
ARGI4
ADDRGP4 $135
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 168
;167:			UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;168:	}
LABELV $131
line 172
;169:
;170:	// draw info string information
;171:
;172:	y = 180-32;
ADDRLP4 4
CNSTI4 148
ASGNI4
line 175
;173:
;174:	// don't print server lines if playing a local game
;175:	trap_Cvar_VariableStringBuffer( "sv_running", buf, sizeof( buf ) );
ADDRGP4 $136
ARGP4
ADDRLP4 16
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 176
;176:	if ( !atoi( buf ) ) {
ADDRLP4 16
ARGP4
ADDRLP4 1088
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1088
INDIRI4
CNSTI4 0
NEI4 $137
line 178
;177:		// server hostname
;178:		Q_strncpyz(buf, Info_ValueForKey( info, "sv_hostname" ), 1024);
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $139
ARGP4
ADDRLP4 1092
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 16
ARGP4
ADDRLP4 1092
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 180
;179:		//For our auto screenshot and record
;180:		memset(autoFile.hostname, 0, sizeof(autoFile.hostname));
ADDRGP4 autoFile
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1024
ARGI4
ADDRGP4 memset
CALLP4
pop
line 181
;181:		Q_strncpyz(autoFile.hostname, Info_ValueForKey( info, "sv_hostname" ), sizeof(autoFile.hostname));
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $139
ARGP4
ADDRLP4 1096
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 autoFile
ARGP4
ADDRLP4 1096
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 183
;182:		//
;183:		Q_CleanStr(buf);
ADDRLP4 16
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 184
;184:		UI_DrawProportionalString( 320, y, buf,
CNSTI4 320
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 186
;185:			UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;186:		y += PROP_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 27
ADDI4
ASGNI4
line 189
;187:
;188:		// pure server
;189:		s = Info_ValueForKey( sysInfo, "sv_pure" );
ADDRLP4 1044
INDIRP4
ARGP4
ADDRGP4 $140
ARGP4
ADDRLP4 1100
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1100
INDIRP4
ASGNP4
line 190
;190:		if ( s[0] == '1' ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 49
NEI4 $141
line 191
;191:			UI_DrawProportionalString( 320, y, "Pure Server",
CNSTI4 320
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 $143
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 193
;192:				UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;193:			y += PROP_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 27
ADDI4
ASGNI4
line 194
;194:		}
LABELV $141
line 197
;195:
;196:		// server-specific message of the day
;197:		s = CG_ConfigString( CS_MOTD );
CNSTI4 4
ARGI4
ADDRLP4 1104
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1104
INDIRP4
ASGNP4
line 198
;198:		if ( s[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $144
line 199
;199:			UI_DrawProportionalString( 320, y, s,
CNSTI4 320
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 201
;200:				UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;201:			y += PROP_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 27
ADDI4
ASGNI4
line 202
;202:		}
LABELV $144
line 205
;203:
;204:		// some extra space after hostname and motd
;205:		y += 10;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 10
ADDI4
ASGNI4
line 206
;206:	}
LABELV $137
line 209
;207:
;208:	// map-specific message (long map name)
;209:	s = CG_ConfigString( CS_MESSAGE );
CNSTI4 3
ARGI4
ADDRLP4 1092
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1092
INDIRP4
ASGNP4
line 210
;210:	if ( s[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $146
line 211
;211:		UI_DrawProportionalString( 320, y, s,
CNSTI4 320
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 213
;212:			UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;213:		y += PROP_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 27
ADDI4
ASGNI4
line 214
;214:	}
LABELV $146
line 217
;215:
;216:	// cheats warning
;217:	s = Info_ValueForKey( sysInfo, "sv_cheats" );
ADDRLP4 1044
INDIRP4
ARGP4
ADDRGP4 $148
ARGP4
ADDRLP4 1096
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1096
INDIRP4
ASGNP4
line 218
;218:	if ( s[0] == '1' ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 49
NEI4 $149
line 219
;219:		UI_DrawProportionalString( 320, y, "CHEATS ARE ENABLED",
CNSTI4 320
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 $151
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 221
;220:			UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;221:		y += PROP_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 27
ADDI4
ASGNI4
line 222
;222:	}
LABELV $149
line 225
;223:
;224:	// game type
;225:	switch ( cgs.gametype ) {
ADDRLP4 1100
ADDRGP4 cgs+31456
INDIRI4
ASGNI4
ADDRLP4 1100
INDIRI4
CNSTI4 0
LTI4 $152
ADDRLP4 1100
INDIRI4
CNSTI4 4
GTI4 $152
ADDRLP4 1100
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $175
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $175
address $156
address $160
address $158
address $162
address $168
code
LABELV $156
line 227
;226:	case GT_FFA:
;227:		s = "Free For All";
ADDRLP4 0
ADDRGP4 $157
ASGNP4
line 228
;228:		break;
ADDRGP4 $153
JUMPV
LABELV $158
line 230
;229:	case GT_SINGLE_PLAYER:
;230:		s = "Single Player";
ADDRLP4 0
ADDRGP4 $159
ASGNP4
line 231
;231:		break;
ADDRGP4 $153
JUMPV
LABELV $160
line 233
;232:	case GT_TOURNAMENT:
;233:		s = "Tournament";
ADDRLP4 0
ADDRGP4 $161
ASGNP4
line 234
;234:		break;
ADDRGP4 $153
JUMPV
LABELV $162
line 236
;235:	case GT_TEAM:
;236:		if ( g_gamemode.integer < 4 ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 4
GEI4 $163
line 237
;237:			s = "Team Deathmatch";
ADDRLP4 0
ADDRGP4 $166
ASGNP4
line 238
;238:		} else {
ADDRGP4 $153
JUMPV
LABELV $163
line 239
;239:			s = "Freeze Tag";
ADDRLP4 0
ADDRGP4 $167
ASGNP4
line 240
;240:		}
line 242
;241://freeze
;242:		break;
ADDRGP4 $153
JUMPV
LABELV $168
line 244
;243:	case GT_CTF:
;244:		if ( g_gamemode.integer < 4 ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 4
GEI4 $169
line 245
;245:			s = "Capture The Flag";
ADDRLP4 0
ADDRGP4 $172
ASGNP4
line 246
;246:		} else {
ADDRGP4 $153
JUMPV
LABELV $169
line 247
;247:			s = "Freeze Tag CTF";
ADDRLP4 0
ADDRGP4 $173
ASGNP4
line 248
;248:		}
line 250
;249://freeze
;250:		break;
ADDRGP4 $153
JUMPV
LABELV $152
line 263
;251:#ifdef MISSIONPACK
;252:	case GT_1FCTF:
;253:		s = "One Flag CTF";
;254:		break;
;255:	case GT_OBELISK:
;256:		s = "Overload";
;257:		break;
;258:	case GT_HARVESTER:
;259:		s = "Harvester";
;260:		break;
;261:#endif
;262:	default:
;263:		s = "Unknown Gametype";
ADDRLP4 0
ADDRGP4 $174
ASGNP4
line 264
;264:		break;
LABELV $153
line 266
;265:	}
;266:	UI_DrawProportionalString( 320, y, s,
CNSTI4 320
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 272
;267:
;268:		UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;269:
;270://		UI_CENTER | UI_SMALLFONT | UI_DROPSHADOW, colorRed );
;271://freeze
;272:	y += PROP_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 27
ADDI4
ASGNI4
line 274
;273:		
;274:	value = atoi( Info_ValueForKey( info, "timelimit" ) );
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $176
ARGP4
ADDRLP4 1108
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1108
INDIRP4
ARGP4
ADDRLP4 1112
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 1112
INDIRI4
ASGNI4
line 275
;275:	if ( value ) {
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $177
line 276
;276:		UI_DrawProportionalString( 320, y, va( "timelimit %i", value ),
ADDRGP4 $179
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 1116
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 320
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 1116
INDIRP4
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 278
;277:			UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;278:		y += PROP_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 27
ADDI4
ASGNI4
line 279
;279:	}
LABELV $177
line 283
;280:
;281:
;282:	//if (cgs.gametype < GT_CTF ) {
;283:	if ( (g_gamemode.integer > 3 && cgs.gametype < GT_TEAM) || (g_gamemode.integer < 4 && cgs.gametype < GT_CTF) ) {
ADDRLP4 1116
CNSTI4 3
ASGNI4
ADDRGP4 g_gamemode+12
INDIRI4
ADDRLP4 1116
INDIRI4
LEI4 $187
ADDRGP4 cgs+31456
INDIRI4
ADDRLP4 1116
INDIRI4
LTI4 $186
LABELV $187
ADDRLP4 1120
CNSTI4 4
ASGNI4
ADDRGP4 g_gamemode+12
INDIRI4
ADDRLP4 1120
INDIRI4
GEI4 $180
ADDRGP4 cgs+31456
INDIRI4
ADDRLP4 1120
INDIRI4
GEI4 $180
LABELV $186
line 285
;284://freeze
;285:		value = atoi( Info_ValueForKey( info, "fraglimit" ) );
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $188
ARGP4
ADDRLP4 1124
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1124
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
line 286
;286:		if ( value ) {
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $189
line 287
;287:			UI_DrawProportionalString( 320, y, va( "fraglimit %i", value ),
ADDRGP4 $191
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 1132
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 320
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 1132
INDIRP4
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 289
;288:				UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;289:			y += PROP_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 27
ADDI4
ASGNI4
line 290
;290:		}
LABELV $189
line 291
;291:	}
LABELV $180
line 295
;292:
;293:
;294://	if (cgs.gametype >= GT_CTF) {
;295:	if ( (g_gamemode.integer > 3 && cgs.gametype >= GT_TEAM) || (g_gamemode.integer < 4 && cgs.gametype >= GT_CTF) ) {
ADDRLP4 1124
CNSTI4 3
ASGNI4
ADDRGP4 g_gamemode+12
INDIRI4
ADDRLP4 1124
INDIRI4
LEI4 $199
ADDRGP4 cgs+31456
INDIRI4
ADDRLP4 1124
INDIRI4
GEI4 $198
LABELV $199
ADDRLP4 1128
CNSTI4 4
ASGNI4
ADDRGP4 g_gamemode+12
INDIRI4
ADDRLP4 1128
INDIRI4
GEI4 $192
ADDRGP4 cgs+31456
INDIRI4
ADDRLP4 1128
INDIRI4
LTI4 $192
LABELV $198
line 297
;296://freeze
;297:		value = atoi( Info_ValueForKey( info, "capturelimit" ) );
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $200
ARGP4
ADDRLP4 1132
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1132
INDIRP4
ARGP4
ADDRLP4 1136
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 1136
INDIRI4
ASGNI4
line 298
;298:		if ( value ) {
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $201
line 299
;299:			UI_DrawProportionalString( 320, y, va( "capturelimit %i", value ),
ADDRGP4 $203
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 1140
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 320
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 1140
INDIRP4
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 301
;300:				UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;301:			y += PROP_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 27
ADDI4
ASGNI4
line 302
;302:		}
LABELV $201
line 303
;303:	}
LABELV $192
line 304
;304:}
LABELV $115
endproc CG_DrawInformation 1144 36
bss
align 4
LABELV loadingItemIcons
skip 104
align 4
LABELV loadingPlayerIcons
skip 64
align 4
LABELV loadingItemIconCount
skip 4
align 4
LABELV loadingPlayerIconCount
skip 4
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
LABELV $203
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $200
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $191
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $188
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
LABELV $179
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $176
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
LABELV $174
byte 1 85
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $173
byte 1 70
byte 1 114
byte 1 101
byte 1 101
byte 1 122
byte 1 101
byte 1 32
byte 1 84
byte 1 97
byte 1 103
byte 1 32
byte 1 67
byte 1 84
byte 1 70
byte 1 0
align 1
LABELV $172
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 32
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $167
byte 1 70
byte 1 114
byte 1 101
byte 1 101
byte 1 122
byte 1 101
byte 1 32
byte 1 84
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $166
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 68
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
LABELV $161
byte 1 84
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $159
byte 1 83
byte 1 105
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 32
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $157
byte 1 70
byte 1 114
byte 1 101
byte 1 101
byte 1 32
byte 1 70
byte 1 111
byte 1 114
byte 1 32
byte 1 65
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $151
byte 1 67
byte 1 72
byte 1 69
byte 1 65
byte 1 84
byte 1 83
byte 1 32
byte 1 65
byte 1 82
byte 1 69
byte 1 32
byte 1 69
byte 1 78
byte 1 65
byte 1 66
byte 1 76
byte 1 69
byte 1 68
byte 1 0
align 1
LABELV $148
byte 1 115
byte 1 118
byte 1 95
byte 1 99
byte 1 104
byte 1 101
byte 1 97
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $143
byte 1 80
byte 1 117
byte 1 114
byte 1 101
byte 1 32
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $140
byte 1 115
byte 1 118
byte 1 95
byte 1 112
byte 1 117
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $139
byte 1 115
byte 1 118
byte 1 95
byte 1 104
byte 1 111
byte 1 115
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $136
byte 1 115
byte 1 118
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
LABELV $135
byte 1 65
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 115
byte 1 110
byte 1 97
byte 1 112
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 46
byte 1 46
byte 1 46
byte 1 0
align 1
LABELV $133
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 46
byte 1 46
byte 1 46
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $125
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 83
byte 1 104
byte 1 111
byte 1 116
byte 1 68
byte 1 101
byte 1 116
byte 1 97
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $124
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $121
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $116
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $114
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
byte 1 0
align 1
LABELV $110
byte 1 110
byte 1 0
align 1
LABELV $107
byte 1 115
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $104
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
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $101
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
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $100
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $97
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
