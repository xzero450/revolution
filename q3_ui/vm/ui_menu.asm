code
proc MainMenu_ExitAction 0 0
file "../ui_menu.c"
line 60
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:/*
;4:=======================================================================
;5:
;6:MAIN MENU
;7:
;8:=======================================================================
;9:*/
;10:
;11:
;12:#include "ui_local.h"
;13:
;14:
;15:#define ID_SINGLEPLAYER			10
;16:#define ID_MULTIPLAYER			11
;17:#define ID_SETUP				12
;18:#define ID_DEMOS				13
;19:#define ID_CINEMATICS			14
;20:#define ID_TEAMARENA			15
;21:#define ID_MODS					16
;22:#define ID_EXIT					17
;23:#define ID_CUSTOM				25
;24:
;25:// #define MAIN_BANNER_MODEL				"models/mapobjects/banner/banner5.md3"
;26://#define MAIN_BANNER_MODEL				""
;27:#define MAIN_MENU_VERTICAL_SPACING		34
;28:
;29:
;30:typedef struct {
;31:	menuframework_s	menu;
;32:
;33:	menutext_s		singleplayer;
;34:	menutext_s		multiplayer;
;35:	menutext_s		setup;
;36:	menutext_s		demos;
;37:	menutext_s		cinematics;
;38:	menutext_s		teamArena;
;39:	menutext_s		mods;
;40:	menutext_s		exit;
;41:
;42:	//qhandle_t		bannerModel;
;43:} mainmenu_t;
;44:
;45:
;46:static mainmenu_t s_main;
;47:
;48:typedef struct {
;49:	menuframework_s menu;	
;50:	char errorMessage[4096];
;51:} errorMessage_t;
;52:
;53:static errorMessage_t s_errorMessage;
;54:
;55:/*
;56:=================
;57:MainMenu_ExitAction
;58:=================
;59:*/
;60:static void MainMenu_ExitAction( qboolean result ) {
line 61
;61:	if( !result ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $71
line 62
;62:		return;
ADDRGP4 $70
JUMPV
LABELV $71
line 64
;63:	}
;64:	UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 65
;65:	UI_CreditMenu();
ADDRGP4 UI_CreditMenu
CALLV
pop
line 66
;66:}
LABELV $70
endproc MainMenu_ExitAction 0 0
export Main_MenuEvent
proc Main_MenuEvent 8 12
line 75
;67:
;68:
;69:
;70:/*
;71:=================
;72:Main_MenuEvent
;73:=================
;74:*/
;75:void Main_MenuEvent (void* ptr, int event) {
line 76
;76:	if( event != QM_ACTIVATED ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $74
line 77
;77:		return;
ADDRGP4 $73
JUMPV
LABELV $74
line 80
;78:	}
;79:
;80:	switch( ((menucommon_s*)ptr)->id ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 10
LTI4 $76
ADDRLP4 0
INDIRI4
CNSTI4 17
GTI4 $76
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $91-40
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $91
address $79
address $80
address $81
address $82
address $83
address $85
address $84
address $89
code
LABELV $79
line 82
;81:	case ID_SINGLEPLAYER:
;82:		UI_SPLevelMenu();
ADDRGP4 UI_SPLevelMenu
CALLV
pop
line 83
;83:		break;
ADDRGP4 $77
JUMPV
LABELV $80
line 86
;84:
;85:	case ID_MULTIPLAYER:
;86:		UI_ArenaServersMenu();
ADDRGP4 UI_ArenaServersMenu
CALLV
pop
line 87
;87:		break;
ADDRGP4 $77
JUMPV
LABELV $81
line 90
;88:
;89:	case ID_SETUP:
;90:		UI_SetupMenu();
ADDRGP4 UI_SetupMenu
CALLV
pop
line 91
;91:		break;
ADDRGP4 $77
JUMPV
LABELV $82
line 94
;92:
;93:	case ID_DEMOS:
;94:		UI_DemosMenu();
ADDRGP4 UI_DemosMenu
CALLV
pop
line 95
;95:		break;
ADDRGP4 $77
JUMPV
LABELV $83
line 98
;96:
;97:	case ID_CINEMATICS:
;98:		UI_CinematicsMenu();
ADDRGP4 UI_CinematicsMenu
CALLV
pop
line 99
;99:		break;
ADDRGP4 $77
JUMPV
LABELV $84
line 102
;100:
;101:	case ID_MODS:
;102:		UI_ModsMenu();
ADDRGP4 UI_ModsMenu
CALLV
pop
line 103
;103:		break;
ADDRGP4 $77
JUMPV
LABELV $85
line 106
;104:
;105:	case ID_TEAMARENA:
;106:		trap_Cvar_Set( "fs_game", "missionpack");
ADDRGP4 $86
ARGP4
ADDRGP4 $87
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 107
;107:		trap_Cmd_ExecuteText( EXEC_APPEND, "vid_restart;" );
CNSTI4 2
ARGI4
ADDRGP4 $88
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 108
;108:		break;
ADDRGP4 $77
JUMPV
LABELV $89
line 111
;109:
;110:	case ID_EXIT:
;111:		UI_ConfirmMenu( "EXIT GAME?", NULL, MainMenu_ExitAction );
ADDRGP4 $90
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 MainMenu_ExitAction
ARGP4
ADDRGP4 UI_ConfirmMenu
CALLV
pop
line 112
;112:		break;
LABELV $76
LABELV $77
line 114
;113:	}
;114:}
LABELV $73
endproc Main_MenuEvent 8 12
export ErrorMessage_Key
proc ErrorMessage_Key 0 8
line 127
;115:
;116:
;117:/*
;118:===============
;119:MainMenu_Cache
;120:===============
;121:*/ /*
;122:void MainMenu_Cache( void ) {
;123:	s_main.bannerModel = trap_R_RegisterModel( MAIN_BANNER_MODEL );
;124:} */
;125:
;126:sfxHandle_t ErrorMessage_Key(int key)
;127:{
line 128
;128:	trap_Cvar_Set( "com_errorMessage", "" );
ADDRGP4 $94
ARGP4
ADDRGP4 $95
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 129
;129:	UI_MainMenu();
ADDRGP4 UI_MainMenu
CALLV
pop
line 130
;130:	return (menu_null_sound);
ADDRGP4 menu_null_sound
INDIRI4
RETI4
LABELV $93
endproc ErrorMessage_Key 0 8
lit
align 4
LABELV $97
byte 4 0
byte 4 1061158912
byte 4 1065353216
byte 4 1065353216
code
proc Main_MenuDraw 420 28
line 140
;131:}
;132:
;133:/*
;134:===============
;135:Main_MenuDraw
;136:TTimo: this function is common to the main menu and errorMessage menu
;137:===============
;138:*/
;139:
;140:static void Main_MenuDraw( void ) {
line 147
;141:	refdef_t		refdef;
;142://	refEntity_t		ent;
;143:	vec3_t			origin;
;144://	vec3_t			angles;
;145:	float			adjust;
;146:	float			x, y, w, h;
;147:	vec4_t			color = {0.00f, 0.75f, 1.00f, 1.00f};//{0.27f, 0.72f, 0.87f, 1}
ADDRLP4 400
ADDRGP4 $97
INDIRB
ASGNB 16
line 151
;148:
;149:	// setup the refdef
;150:
;151:	memset( &refdef, 0, sizeof( refdef ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 368
ARGI4
ADDRGP4 memset
CALLP4
pop
line 153
;152:
;153:	refdef.rdflags = RDF_NOWORLDMODEL;
ADDRLP4 0+76
CNSTI4 1
ASGNI4
line 155
;154:
;155:	AxisClear( refdef.viewaxis );
ADDRLP4 0+36
ARGP4
ADDRGP4 AxisClear
CALLV
pop
line 157
;156:
;157:	x = 0;
ADDRLP4 384
CNSTF4 0
ASGNF4
line 158
;158:	y = 0;
ADDRLP4 388
CNSTF4 0
ASGNF4
line 159
;159:	w = 640;
ADDRLP4 392
CNSTF4 1142947840
ASGNF4
line 160
;160:	h = 120;
ADDRLP4 396
CNSTF4 1123024896
ASGNF4
line 161
;161:	UI_AdjustFrom640( &x, &y, &w, &h );
ADDRLP4 384
ARGP4
ADDRLP4 388
ARGP4
ADDRLP4 392
ARGP4
ADDRLP4 396
ARGP4
ADDRGP4 UI_AdjustFrom640
CALLV
pop
line 162
;162:	refdef.x = x;
ADDRLP4 0
ADDRLP4 384
INDIRF4
CVFI4 4
ASGNI4
line 163
;163:	refdef.y = y;
ADDRLP4 0+4
ADDRLP4 388
INDIRF4
CVFI4 4
ASGNI4
line 164
;164:	refdef.width = w;
ADDRLP4 0+8
ADDRLP4 392
INDIRF4
CVFI4 4
ASGNI4
line 165
;165:	refdef.height = h;
ADDRLP4 0+12
ADDRLP4 396
INDIRF4
CVFI4 4
ASGNI4
line 167
;166:
;167:	adjust = 0; // JDC: Kenneth asked me to stop this 1.0 * sin( (float)uis.realtime / 1000 );
ADDRLP4 380
CNSTF4 0
ASGNF4
line 168
;168:	refdef.fov_x = 60 + adjust;
ADDRLP4 0+16
ADDRLP4 380
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 169
;169:	refdef.fov_y = 19.6875 + adjust;
ADDRLP4 0+20
ADDRLP4 380
INDIRF4
CNSTF4 1100840960
ADDF4
ASGNF4
line 171
;170:
;171:	refdef.time = uis.realtime;
ADDRLP4 0+72
ADDRGP4 uis+4
INDIRI4
ASGNI4
line 173
;172:
;173:	origin[0] = 300;
ADDRLP4 368
CNSTF4 1133903872
ASGNF4
line 174
;174:	origin[1] = 0;
ADDRLP4 368+4
CNSTF4 0
ASGNF4
line 175
;175:	origin[2] = -32;
ADDRLP4 368+8
CNSTF4 3254779904
ASGNF4
line 177
;176:
;177:	trap_R_ClearScene();
ADDRGP4 trap_R_ClearScene
CALLV
pop
line 196
;178:
;179:	// add the model
;180:/*
;181:	memset( &ent, 0, sizeof(ent) );
;182:
;183:	adjust = 5.0 * sin( (float)uis.realtime / 5000 );
;184:	VectorSet( angles, 0, 180 + adjust, 0 );
;185:	AnglesToAxis( angles, ent.axis );
;186:	ent.hModel = s_main.bannerModel;
;187:	VectorCopy( origin, ent.origin );
;188:	VectorCopy( origin, ent.lightingOrigin );
;189:	ent.renderfx = RF_LIGHTING_ORIGIN | RF_NOSHADOW;
;190:	VectorCopy( ent.origin, ent.oldorigin );
;191:
;192:	trap_R_AddRefEntityToScene( &ent );
;193:
;194:	trap_R_RenderScene( &refdef );
;195:*/
;196:	if (strlen(s_errorMessage.errorMessage)) {
ADDRGP4 s_errorMessage+288
ARGP4
ADDRLP4 416
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 416
INDIRI4
CNSTI4 0
EQI4 $109
line 197
;197:		UI_DrawProportionalString_AutoWrapped( 320, 192, 600, 20, s_errorMessage.errorMessage, UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, menu_text_color );
CNSTI4 320
ARGI4
CNSTI4 192
ARGI4
CNSTI4 600
ARGI4
CNSTI4 20
ARGI4
ADDRGP4 s_errorMessage+288
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 menu_text_color
ARGP4
ADDRGP4 UI_DrawProportionalString_AutoWrapped
CALLV
pop
line 198
;198:	} else {
ADDRGP4 $110
JUMPV
LABELV $109
line 200
;199:		// standard menu drawing
;200:		Menu_Draw( &s_main.menu );		
ADDRGP4 s_main
ARGP4
ADDRGP4 Menu_Draw
CALLV
pop
line 201
;201:	}
LABELV $110
line 203
;202:
;203:	if (uis.demoversion) {
ADDRGP4 uis+11444
INDIRI4
CNSTI4 0
EQI4 $113
line 204
;204:		UI_DrawProportionalString( 320, 372, "DEMO      FOR MATURE AUDIENCES      DEMO", UI_CENTER|UI_SMALLFONT, 0.75, color );
CNSTI4 320
ARGI4
CNSTI4 372
ARGI4
ADDRGP4 $116
ARGP4
CNSTI4 17
ARGI4
CNSTF4 1061158912
ARGF4
ADDRLP4 400
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 205
;205:		UI_DrawString( 320, 400, "Quake III Arena(c) 1999-2000, Id Software, Inc.  All Rights Reserved", UI_CENTER|UI_SMALLFONT, color );
CNSTI4 320
ARGI4
CNSTI4 400
ARGI4
ADDRGP4 $117
ARGP4
CNSTI4 17
ARGI4
ADDRLP4 400
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 206
;206:	} else {
ADDRGP4 $114
JUMPV
LABELV $113
line 207
;207:		UI_DrawString( 320, 450, "Quake III Arena(c) 1999-2000, Id Software, Inc.  All Rights Reserved", UI_CENTER|UI_SMALLFONT, color );
CNSTI4 320
ARGI4
CNSTI4 450
ARGI4
ADDRGP4 $117
ARGP4
CNSTI4 17
ARGI4
ADDRLP4 400
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 208
;208:	}
LABELV $114
line 209
;209:}
LABELV $96
endproc Main_MenuDraw 420 28
proc UI_TeamArenaExists 2084 16
line 217
;210:
;211:
;212:/*
;213:===============
;214:UI_TeamArenaExists
;215:===============
;216:*/
;217:static qboolean UI_TeamArenaExists( void ) {
line 225
;218:	int		numdirs;
;219:	char	dirlist[2048];
;220:	char	*dirptr;
;221:  char  *descptr;
;222:	int		i;
;223:	int		dirlen;
;224:
;225:	numdirs = trap_FS_GetFileList( "$modlist", "", dirlist, sizeof(dirlist) );
ADDRGP4 $119
ARGP4
ADDRGP4 $95
ARGP4
ADDRLP4 20
ARGP4
CNSTI4 2048
ARGI4
ADDRLP4 2068
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 2068
INDIRI4
ASGNI4
line 226
;226:	dirptr  = dirlist;
ADDRLP4 0
ADDRLP4 20
ASGNP4
line 227
;227:	for( i = 0; i < numdirs; i++ ) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $123
JUMPV
LABELV $120
line 228
;228:		dirlen = strlen( dirptr ) + 1;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 2072
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 2072
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 229
;229:    descptr = dirptr + dirlen;
ADDRLP4 12
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
line 230
;230:		if (Q_stricmp(dirptr, "missionpack") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $87
ARGP4
ADDRLP4 2076
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2076
INDIRI4
CNSTI4 0
NEI4 $124
line 231
;231:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $118
JUMPV
LABELV $124
line 233
;232:		}
;233:    dirptr += dirlen + strlen(descptr) + 1;
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 2080
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ADDRLP4 2080
INDIRI4
ADDI4
CNSTI4 1
ADDI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
line 234
;234:	}
LABELV $121
line 227
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $123
ADDRLP4 8
INDIRI4
ADDRLP4 16
INDIRI4
LTI4 $120
line 235
;235:	return qfalse;
CNSTI4 0
RETI4
LABELV $118
endproc UI_TeamArenaExists 2084 16
export UI_MainMenu
proc UI_MainMenu 40 12
line 248
;236:}
;237:
;238:
;239:/*
;240:===============
;241:UI_MainMenu
;242:
;243:The main menu only comes up when not in a game,
;244:so make sure that the attract loop server is down
;245:and that local cinematics are killed
;246:===============
;247:*/
;248:void UI_MainMenu( void ) {
line 250
;249:	int		y;
;250:	qboolean teamArena = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 251
;251:	int		style = UI_CENTER | UI_DROPSHADOW;
ADDRLP4 4
CNSTI4 2049
ASGNI4
line 253
;252:
;253:	trap_Cvar_Set( "sv_killserver", "1" );
ADDRGP4 $127
ARGP4
ADDRGP4 $128
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 255
;254:
;255:	if( !uis.demoversion && !ui_cdkeychecked.integer ) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 uis+11444
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $129
ADDRGP4 ui_cdkeychecked+12
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $129
line 258
;256:		char	key[17];
;257:
;258:		trap_GetCDKey( key, sizeof(key) );
ADDRLP4 16
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 trap_GetCDKey
CALLV
pop
line 259
;259:		if( trap_VerifyCDKey( key, NULL ) == qfalse ) {
ADDRLP4 16
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 36
ADDRGP4 trap_VerifyCDKey
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $133
line 260
;260:			UI_CDKeyMenu();
ADDRGP4 UI_CDKeyMenu
CALLV
pop
line 261
;261:			return;
ADDRGP4 $126
JUMPV
LABELV $133
line 263
;262:		}
;263:	}
LABELV $129
line 265
;264:	
;265:	memset( &s_main, 0 ,sizeof(mainmenu_t) );
ADDRGP4 s_main
ARGP4
CNSTI4 0
ARGI4
CNSTI4 864
ARGI4
ADDRGP4 memset
CALLP4
pop
line 266
;266:	memset( &s_errorMessage, 0 ,sizeof(errorMessage_t) );
ADDRGP4 s_errorMessage
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4384
ARGI4
ADDRGP4 memset
CALLP4
pop
line 271
;267:
;268:	// com_errorMessage would need that too
;269:	//MainMenu_Cache();
;270:	
;271:	trap_Cvar_VariableStringBuffer( "com_errorMessage", s_errorMessage.errorMessage, sizeof(s_errorMessage.errorMessage) );
ADDRGP4 $94
ARGP4
ADDRGP4 s_errorMessage+288
ARGP4
CNSTI4 4096
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 272
;272:	if (strlen(s_errorMessage.errorMessage))
ADDRGP4 s_errorMessage+288
ARGP4
ADDRLP4 16
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $137
line 273
;273:	{	
line 274
;274:		s_errorMessage.menu.draw = Main_MenuDraw;
ADDRGP4 s_errorMessage+268
ADDRGP4 Main_MenuDraw
ASGNP4
line 275
;275:		s_errorMessage.menu.key = ErrorMessage_Key;
ADDRGP4 s_errorMessage+272
ADDRGP4 ErrorMessage_Key
ASGNP4
line 276
;276:		s_errorMessage.menu.fullscreen = qtrue;
ADDRGP4 s_errorMessage+280
CNSTI4 1
ASGNI4
line 277
;277:		s_errorMessage.menu.wrapAround = qtrue;
ADDRGP4 s_errorMessage+276
CNSTI4 1
ASGNI4
line 278
;278:		s_errorMessage.menu.showlogo = qtrue;		
ADDRGP4 s_errorMessage+284
CNSTI4 1
ASGNI4
line 280
;279:
;280:		trap_Key_SetCatcher( KEYCATCH_UI );
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 281
;281:		uis.menusp = 0;
ADDRGP4 uis+16
CNSTI4 0
ASGNI4
line 282
;282:		UI_PushMenu ( &s_errorMessage.menu );
ADDRGP4 s_errorMessage
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 284
;283:		
;284:		return;
ADDRGP4 $126
JUMPV
LABELV $137
line 287
;285:	}
;286:
;287:	s_main.menu.draw = Main_MenuDraw;
ADDRGP4 s_main+268
ADDRGP4 Main_MenuDraw
ASGNP4
line 288
;288:	s_main.menu.fullscreen = qtrue;
ADDRGP4 s_main+280
CNSTI4 1
ASGNI4
line 289
;289:	s_main.menu.wrapAround = qtrue;
ADDRGP4 s_main+276
CNSTI4 1
ASGNI4
line 290
;290:	s_main.menu.showlogo = qtrue;
ADDRGP4 s_main+284
CNSTI4 1
ASGNI4
line 292
;291:
;292:	y = 138;
ADDRLP4 0
CNSTI4 138
ASGNI4
line 293
;293:	s_main.singleplayer.generic.type		= MTYPE_PTEXT;
ADDRGP4 s_main+288
CNSTI4 9
ASGNI4
line 294
;294:	s_main.singleplayer.generic.flags		= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_main+288+44
CNSTU4 264
ASGNU4
line 295
;295:	s_main.singleplayer.generic.x			= 122;
ADDRGP4 s_main+288+12
CNSTI4 122
ASGNI4
line 296
;296:	s_main.singleplayer.generic.y			= y;
ADDRGP4 s_main+288+16
ADDRLP4 0
INDIRI4
ASGNI4
line 299
;297:	//s_main.singleplayer.generic.id			= ID_SINGLEPLAYER;
;298:	//s_main.singleplayer.generic.callback	= Main_MenuEvent; 
;299:	s_main.singleplayer.generic.id			= ID_CUSTOM;
ADDRGP4 s_main+288+8
CNSTI4 25
ASGNI4
line 300
;300:	s_main.singleplayer.generic.callback	= UI_SPLevelMenu_CustomEvent;
ADDRGP4 s_main+288+48
ADDRGP4 UI_SPLevelMenu_CustomEvent
ASGNP4
line 301
;301:	s_main.singleplayer.string				= "SINGLE PLAYER";
ADDRGP4 s_main+288+60
ADDRGP4 $163
ASGNP4
line 302
;302:	s_main.singleplayer.color				= color_main;
ADDRGP4 s_main+288+68
ADDRGP4 color_main
ASGNP4
line 303
;303:	s_main.singleplayer.style				= style;
ADDRGP4 s_main+288+64
ADDRLP4 4
INDIRI4
ASGNI4
line 305
;304:
;305:	y += MAIN_MENU_VERTICAL_SPACING;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 34
ADDI4
ASGNI4
line 306
;306:	s_main.multiplayer.generic.type			= MTYPE_PTEXT;
ADDRGP4 s_main+360
CNSTI4 9
ASGNI4
line 307
;307:	s_main.multiplayer.generic.flags		= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_main+360+44
CNSTU4 264
ASGNU4
line 308
;308:	s_main.multiplayer.generic.x			= 110;
ADDRGP4 s_main+360+12
CNSTI4 110
ASGNI4
line 309
;309:	s_main.multiplayer.generic.y			= y;
ADDRGP4 s_main+360+16
ADDRLP4 0
INDIRI4
ASGNI4
line 310
;310:	s_main.multiplayer.generic.id			= ID_MULTIPLAYER;
ADDRGP4 s_main+360+8
CNSTI4 11
ASGNI4
line 311
;311:	s_main.multiplayer.generic.callback		= Main_MenuEvent; 
ADDRGP4 s_main+360+48
ADDRGP4 Main_MenuEvent
ASGNP4
line 312
;312:	s_main.multiplayer.string				= "MULTIPLAYER";
ADDRGP4 s_main+360+60
ADDRGP4 $181
ASGNP4
line 313
;313:	s_main.multiplayer.color				= color_main;
ADDRGP4 s_main+360+68
ADDRGP4 color_main
ASGNP4
line 314
;314:	s_main.multiplayer.style				= style;
ADDRGP4 s_main+360+64
ADDRLP4 4
INDIRI4
ASGNI4
line 316
;315:
;316:	y += MAIN_MENU_VERTICAL_SPACING;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 34
ADDI4
ASGNI4
line 317
;317:	s_main.setup.generic.type				= MTYPE_PTEXT;
ADDRGP4 s_main+432
CNSTI4 9
ASGNI4
line 318
;318:	s_main.setup.generic.flags				= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_main+432+44
CNSTU4 264
ASGNU4
line 319
;319:	s_main.setup.generic.x					= 55;
ADDRGP4 s_main+432+12
CNSTI4 55
ASGNI4
line 320
;320:	s_main.setup.generic.y					= y;
ADDRGP4 s_main+432+16
ADDRLP4 0
INDIRI4
ASGNI4
line 321
;321:	s_main.setup.generic.id					= ID_SETUP;
ADDRGP4 s_main+432+8
CNSTI4 12
ASGNI4
line 322
;322:	s_main.setup.generic.callback			= Main_MenuEvent; 
ADDRGP4 s_main+432+48
ADDRGP4 Main_MenuEvent
ASGNP4
line 323
;323:	s_main.setup.string						= "SETUP";
ADDRGP4 s_main+432+60
ADDRGP4 $199
ASGNP4
line 324
;324:	s_main.setup.color						= color_main;
ADDRGP4 s_main+432+68
ADDRGP4 color_main
ASGNP4
line 325
;325:	s_main.setup.style						= style;
ADDRGP4 s_main+432+64
ADDRLP4 4
INDIRI4
ASGNI4
line 327
;326:
;327:	y += MAIN_MENU_VERTICAL_SPACING;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 34
ADDI4
ASGNI4
line 328
;328:	s_main.demos.generic.type				= MTYPE_PTEXT;
ADDRGP4 s_main+504
CNSTI4 9
ASGNI4
line 329
;329:	s_main.demos.generic.flags				= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_main+504+44
CNSTU4 264
ASGNU4
line 330
;330:	s_main.demos.generic.x					= 60;
ADDRGP4 s_main+504+12
CNSTI4 60
ASGNI4
line 331
;331:	s_main.demos.generic.y					= y;
ADDRGP4 s_main+504+16
ADDRLP4 0
INDIRI4
ASGNI4
line 332
;332:	s_main.demos.generic.id					= ID_DEMOS;
ADDRGP4 s_main+504+8
CNSTI4 13
ASGNI4
line 333
;333:	s_main.demos.generic.callback			= Main_MenuEvent; 
ADDRGP4 s_main+504+48
ADDRGP4 Main_MenuEvent
ASGNP4
line 334
;334:	s_main.demos.string						= "DEMOS";
ADDRGP4 s_main+504+60
ADDRGP4 $217
ASGNP4
line 335
;335:	s_main.demos.color						= color_main;
ADDRGP4 s_main+504+68
ADDRGP4 color_main
ASGNP4
line 336
;336:	s_main.demos.style						= style;
ADDRGP4 s_main+504+64
ADDRLP4 4
INDIRI4
ASGNI4
line 338
;337:
;338:	y += MAIN_MENU_VERTICAL_SPACING;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 34
ADDI4
ASGNI4
line 339
;339:	s_main.cinematics.generic.type			= MTYPE_PTEXT;
ADDRGP4 s_main+576
CNSTI4 9
ASGNI4
line 340
;340:	s_main.cinematics.generic.flags			= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_main+576+44
CNSTU4 264
ASGNU4
line 341
;341:	s_main.cinematics.generic.x				= 100;
ADDRGP4 s_main+576+12
CNSTI4 100
ASGNI4
line 342
;342:	s_main.cinematics.generic.y				= y;
ADDRGP4 s_main+576+16
ADDRLP4 0
INDIRI4
ASGNI4
line 343
;343:	s_main.cinematics.generic.id			= ID_CINEMATICS;
ADDRGP4 s_main+576+8
CNSTI4 14
ASGNI4
line 344
;344:	s_main.cinematics.generic.callback		= Main_MenuEvent; 
ADDRGP4 s_main+576+48
ADDRGP4 Main_MenuEvent
ASGNP4
line 345
;345:	s_main.cinematics.string				= "CINEMATICS";
ADDRGP4 s_main+576+60
ADDRGP4 $235
ASGNP4
line 346
;346:	s_main.cinematics.color					= color_main;
ADDRGP4 s_main+576+68
ADDRGP4 color_main
ASGNP4
line 347
;347:	s_main.cinematics.style					= style;
ADDRGP4 s_main+576+64
ADDRLP4 4
INDIRI4
ASGNI4
line 363
;348:
;349:	/*if (UI_TeamArenaExists()) {
;350:		teamArena = qtrue;
;351:		y += MAIN_MENU_VERTICAL_SPACING;
;352:		s_main.teamArena.generic.type			= MTYPE_PTEXT;
;353:		s_main.teamArena.generic.flags			= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
;354:		s_main.teamArena.generic.x				= 320;
;355:		s_main.teamArena.generic.y				= y;
;356:		s_main.teamArena.generic.id				= ID_TEAMARENA;
;357:		s_main.teamArena.generic.callback		= Main_MenuEvent; 
;358:		s_main.teamArena.string					= "TEAM ARENA";
;359:		s_main.teamArena.color					= color_main;
;360:		s_main.teamArena.style					= style;
;361:	}*/
;362:
;363:	y += MAIN_MENU_VERTICAL_SPACING;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 34
ADDI4
ASGNI4
line 364
;364:	s_main.mods.generic.type			= MTYPE_PTEXT;
ADDRGP4 s_main+720
CNSTI4 9
ASGNI4
line 365
;365:	s_main.mods.generic.flags			= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_main+720+44
CNSTU4 264
ASGNU4
line 366
;366:	s_main.mods.generic.x				= 52;
ADDRGP4 s_main+720+12
CNSTI4 52
ASGNI4
line 367
;367:	s_main.mods.generic.y				= y;
ADDRGP4 s_main+720+16
ADDRLP4 0
INDIRI4
ASGNI4
line 368
;368:	s_main.mods.generic.id				= ID_MODS;
ADDRGP4 s_main+720+8
CNSTI4 16
ASGNI4
line 369
;369:	s_main.mods.generic.callback		= Main_MenuEvent; 
ADDRGP4 s_main+720+48
ADDRGP4 Main_MenuEvent
ASGNP4
line 370
;370:	s_main.mods.string					= "MODS";
ADDRGP4 s_main+720+60
ADDRGP4 $253
ASGNP4
line 371
;371:	s_main.mods.color					= color_main;
ADDRGP4 s_main+720+68
ADDRGP4 color_main
ASGNP4
line 372
;372:	s_main.mods.style					= style;
ADDRGP4 s_main+720+64
ADDRLP4 4
INDIRI4
ASGNI4
line 374
;373:
;374:	y += MAIN_MENU_VERTICAL_SPACING;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 34
ADDI4
ASGNI4
line 375
;375:	s_main.exit.generic.type				= MTYPE_PTEXT;
ADDRGP4 s_main+792
CNSTI4 9
ASGNI4
line 376
;376:	s_main.exit.generic.flags				= QMF_CENTER_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_main+792+44
CNSTU4 264
ASGNU4
line 377
;377:	s_main.exit.generic.x					= 40;
ADDRGP4 s_main+792+12
CNSTI4 40
ASGNI4
line 378
;378:	s_main.exit.generic.y					= y;
ADDRGP4 s_main+792+16
ADDRLP4 0
INDIRI4
ASGNI4
line 379
;379:	s_main.exit.generic.id					= ID_EXIT;
ADDRGP4 s_main+792+8
CNSTI4 17
ASGNI4
line 380
;380:	s_main.exit.generic.callback			= Main_MenuEvent; 
ADDRGP4 s_main+792+48
ADDRGP4 Main_MenuEvent
ASGNP4
line 381
;381:	s_main.exit.string						= "EXIT";
ADDRGP4 s_main+792+60
ADDRGP4 $271
ASGNP4
line 382
;382:	s_main.exit.color						= color_main;
ADDRGP4 s_main+792+68
ADDRGP4 color_main
ASGNP4
line 383
;383:	s_main.exit.style						= style;
ADDRGP4 s_main+792+64
ADDRLP4 4
INDIRI4
ASGNI4
line 385
;384:
;385:	Menu_AddItem( &s_main.menu,	&s_main.singleplayer );
ADDRGP4 s_main
ARGP4
ADDRGP4 s_main+288
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 386
;386:	Menu_AddItem( &s_main.menu,	&s_main.multiplayer );
ADDRGP4 s_main
ARGP4
ADDRGP4 s_main+360
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 387
;387:	Menu_AddItem( &s_main.menu,	&s_main.setup );
ADDRGP4 s_main
ARGP4
ADDRGP4 s_main+432
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 388
;388:	Menu_AddItem( &s_main.menu,	&s_main.demos );
ADDRGP4 s_main
ARGP4
ADDRGP4 s_main+504
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 389
;389:	Menu_AddItem( &s_main.menu,	&s_main.cinematics );
ADDRGP4 s_main
ARGP4
ADDRGP4 s_main+576
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 393
;390:	/*if (teamArena) {
;391:		Menu_AddItem( &s_main.menu,	&s_main.teamArena );
;392:	}*/
;393:	Menu_AddItem( &s_main.menu,	&s_main.mods );
ADDRGP4 s_main
ARGP4
ADDRGP4 s_main+720
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 394
;394:	Menu_AddItem( &s_main.menu,	&s_main.exit );             
ADDRGP4 s_main
ARGP4
ADDRGP4 s_main+792
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 396
;395:
;396:	trap_Key_SetCatcher( KEYCATCH_UI );
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 397
;397:	uis.menusp = 0;
ADDRGP4 uis+16
CNSTI4 0
ASGNI4
line 398
;398:	UI_PushMenu ( &s_main.menu );
ADDRGP4 s_main
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 400
;399:		
;400:}
LABELV $126
endproc UI_MainMenu 40 12
bss
align 4
LABELV s_errorMessage
skip 4384
align 4
LABELV s_main
skip 864
import UI_RankStatusMenu
import RankStatus_Cache
import UI_SignupMenu
import Signup_Cache
import UI_LoginMenu
import Login_Cache
import UI_RankingsMenu
import Rankings_Cache
import Rankings_DrawPassword
import Rankings_DrawName
import Rankings_DrawText
import UI_InitGameinfo
import UI_SPUnlockMedals_f
import UI_SPUnlock_f
import UI_GetAwardLevel
import UI_LogAwardData
import UI_NewGame
import UI_GetCurrentGame
import UI_CanShowTierVideo
import UI_ShowTierVideo
import UI_TierCompleted
import UI_SetBestScore
import UI_GetBestScore
import UI_GetNumBots
import UI_GetBotInfoByName
import UI_GetBotInfoByNumber
import UI_GetNumSPTiers
import UI_GetNumSPArenas
import UI_GetNumArenas
import UI_GetSpecialArenaInfo
import UI_GetArenaInfoByMap
import UI_GetArenaInfoByNumber
import UI_NetworkOptionsMenu
import UI_NetworkOptionsMenu_Cache
import UI_SoundOptionsMenu
import UI_SoundOptionsMenu_Cache
import UI_DisplayOptionsMenu
import UI_DisplayOptionsMenu_Cache
import UI_SaveConfigMenu
import UI_SaveConfigMenu_Cache
import UI_LoadConfigMenu
import UI_LoadConfig_Cache
import UI_TeamOrdersMenu_Cache
import UI_TeamOrdersMenu_f
import UI_TeamOrdersMenu
import UI_RemoveBotsMenu
import UI_RemoveBots_Cache
import UI_AddBotsMenu
import UI_AddBots_Cache
import trap_SetPbClStatus
import trap_VerifyCDKey
import trap_SetCDKey
import trap_GetCDKey
import trap_MemoryRemaining
import trap_LAN_GetPingInfo
import trap_LAN_GetPing
import trap_LAN_ClearPing
import trap_LAN_ServerStatus
import trap_LAN_GetPingQueueCount
import trap_LAN_GetServerInfo
import trap_LAN_GetServerAddressString
import trap_LAN_GetServerCount
import trap_GetConfigString
import trap_GetGlconfig
import trap_GetClientState
import trap_GetClipboardData
import trap_Key_SetCatcher
import trap_Key_GetCatcher
import trap_Key_ClearStates
import trap_Key_SetOverstrikeMode
import trap_Key_GetOverstrikeMode
import trap_Key_IsDown
import trap_Key_SetBinding
import trap_Key_GetBindingBuf
import trap_Key_KeynumToStringBuf
import trap_S_RegisterSound
import trap_S_StartLocalSound
import trap_CM_LerpTag
import trap_UpdateScreen
import trap_R_DrawStretchPic
import trap_R_SetColor
import trap_R_RenderScene
import trap_R_AddLightToScene
import trap_R_AddPolyToScene
import trap_R_AddRefEntityToScene
import trap_R_ClearScene
import trap_R_RegisterShaderNoMip
import trap_R_RegisterSkin
import trap_R_RegisterModel
import trap_FS_Seek
import trap_FS_GetFileList
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_Cmd_ExecuteText
import trap_Cvar_InfoStringBuffer
import trap_Cvar_Create
import trap_Cvar_Reset
import trap_Cvar_SetValue
import trap_Cvar_VariableStringBuffer
import trap_Cvar_VariableValue
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_Milliseconds
import trap_Error
import trap_Print
import UI_SPSkillMenu_Cache
import UI_SPSkillMenu
import UI_SPPostgameMenu_f
import UI_SPPostgameMenu_Cache
import UI_SPArena_Start
import UI_SPLevelMenu_CustomEvent
import UI_SPLevelMenu_ReInit
import UI_SPLevelMenu_f
import UI_SPLevelMenu
import UI_SPLevelMenu_Cache
import uis
import m_entersound
import UI_StartDemoLoop
import UI_Cvar_VariableString
import UI_Argv
import UI_ForceMenuOff
import UI_PopMenu
import UI_PushMenu
import UI_SetActiveMenu
import UI_IsFullscreen
import UI_DrawTextBox
import UI_AdjustFrom640
import UI_CursorInRect
import UI_DrawChar
import UI_DrawString
import UI_ProportionalStringWidth
import UI_DrawProportionalString_AutoWrapped
import UI_DrawProportionalString
import UI_ProportionalSizeScale
import UI_DrawBannerString
import UI_LerpColor
import UI_SetColor
import UI_UpdateScreen
import UI_DrawRect
import UI_FillRect
import UI_DrawHandlePic
import UI_DrawNamedPic
import UI_ClampCvar
import UI_ConsoleCommand
import UI_Refresh
import UI_MouseEvent
import UI_KeyEvent
import UI_Shutdown
import UI_Init
import UI_RegisterClientModelname
import UI_PlayerInfo_SetInfo
import UI_PlayerInfo_SetModel
import UI_DrawPlayer
import DriverInfo_Cache
import GraphicsOptions_Cache
import UI_GraphicsOptionsMenu
import ServerInfo_Cache
import UI_ServerInfoMenu
import UI_BotSelectMenu_Cache
import UI_BotSelectMenu
import ServerOptions_Cache
import StartServer_Cache
import UI_StartServerMenu
import ArenaServers_Cache
import UI_ArenaServersMenu
import SpecifyServer_Cache
import UI_SpecifyServerMenu
import SpecifyLeague_Cache
import UI_SpecifyLeagueMenu
import Preferences_Cache
import UI_PreferencesMenu
import PlayerSettings_Cache
import UI_PlayerSettingsMenu
import PlayerModel_Cache
import UI_PlayerModelMenu
import UI_CDKeyMenu_f
import UI_CDKeyMenu_Cache
import UI_CDKeyMenu
import UI_ModsMenu_Cache
import UI_ModsMenu
import UI_CinematicsMenu_Cache
import UI_CinematicsMenu_f
import UI_CinematicsMenu
import Demos_Cache
import UI_DemosMenu
import Controls_Cache
import UI_ControlsMenu
import UI_DrawConnectScreen
import TeamMain_Cache
import UI_TeamMainMenu
import UI_SetupMenu
import UI_SetupMenu_Cache
import UI_Message
import UI_ConfirmMenu_Style
import UI_ConfirmMenu
import ConfirmMenu_Cache
import UI_InGameMenu
import InGame_Cache
import UI_CreditMenu
import UI_UpdateCvars
import UI_RegisterCvars
import MenuField_Key
import MenuField_Draw
import MenuField_Init
import MField_Draw
import MField_CharEvent
import MField_KeyDownEvent
import MField_Clear
import ui_medalSounds
import ui_medalPicNames
import ui_medalNames
import text_color_highlight
import text_color_normal
import text_color_disabled
import listbar_color
import list_color
import name_color
import color_dim
import color_main
import color_red
import color_orange
import color_blue
import color_yellow
import color_white
import color_black
import menu_dim_color
import menu_black_color
import menu_red_color
import menu_highlight_color
import menu_dark_color
import menu_grayed_color
import menu_text_color
import weaponChangeSound
import menu_null_sound
import menu_buzz_sound
import menu_out_sound
import menu_move_sound
import menu_in_sound
import ScrollList_Key
import ScrollList_Draw
import Bitmap_Draw
import Bitmap_Init
import Menu_DefaultKey
import Menu_SetCursorToItem
import Menu_SetCursor
import Menu_ActivateItem
import Menu_ItemAtCursor
import Menu_Draw
import Menu_AdjustCursor
import Menu_AddItem
import Menu_Focus
import Menu_Cache
import s_announcer
import ui_cdkeychecked
import ui_cdkey
import ui_server16
import ui_server15
import ui_server14
import ui_server13
import ui_server12
import ui_server11
import ui_server10
import ui_server9
import ui_server8
import ui_server7
import ui_server6
import ui_server5
import ui_server4
import ui_server3
import ui_server2
import ui_server1
import ui_marks
import ui_drawCrosshairNames
import ui_drawCrosshair
import ui_brassTime
import ui_browserShowEmpty
import ui_browserShowFull
import ui_browserSortKey
import ui_browserGameType
import ui_browserMaster
import ui_spSelection
import ui_spSkill
import ui_spVideos
import ui_spAwards
import ui_spScores5
import ui_spScores4
import ui_spScores3
import ui_spScores2
import ui_spScores1
import ui_botsFile
import ui_arenasFile
import ui_ctf_friendly
import ui_ctf_timelimit
import ui_ctf_capturelimit
import ui_team_friendly
import ui_team_timelimit
import ui_team_fraglimit
import ui_tourney_timelimit
import ui_tourney_fraglimit
import ui_ffa_timelimit
import ui_ffa_fraglimit
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
LABELV $271
byte 1 69
byte 1 88
byte 1 73
byte 1 84
byte 1 0
align 1
LABELV $253
byte 1 77
byte 1 79
byte 1 68
byte 1 83
byte 1 0
align 1
LABELV $235
byte 1 67
byte 1 73
byte 1 78
byte 1 69
byte 1 77
byte 1 65
byte 1 84
byte 1 73
byte 1 67
byte 1 83
byte 1 0
align 1
LABELV $217
byte 1 68
byte 1 69
byte 1 77
byte 1 79
byte 1 83
byte 1 0
align 1
LABELV $199
byte 1 83
byte 1 69
byte 1 84
byte 1 85
byte 1 80
byte 1 0
align 1
LABELV $181
byte 1 77
byte 1 85
byte 1 76
byte 1 84
byte 1 73
byte 1 80
byte 1 76
byte 1 65
byte 1 89
byte 1 69
byte 1 82
byte 1 0
align 1
LABELV $163
byte 1 83
byte 1 73
byte 1 78
byte 1 71
byte 1 76
byte 1 69
byte 1 32
byte 1 80
byte 1 76
byte 1 65
byte 1 89
byte 1 69
byte 1 82
byte 1 0
align 1
LABELV $128
byte 1 49
byte 1 0
align 1
LABELV $127
byte 1 115
byte 1 118
byte 1 95
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $119
byte 1 36
byte 1 109
byte 1 111
byte 1 100
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $117
byte 1 81
byte 1 117
byte 1 97
byte 1 107
byte 1 101
byte 1 32
byte 1 73
byte 1 73
byte 1 73
byte 1 32
byte 1 65
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 40
byte 1 99
byte 1 41
byte 1 32
byte 1 49
byte 1 57
byte 1 57
byte 1 57
byte 1 45
byte 1 50
byte 1 48
byte 1 48
byte 1 48
byte 1 44
byte 1 32
byte 1 73
byte 1 100
byte 1 32
byte 1 83
byte 1 111
byte 1 102
byte 1 116
byte 1 119
byte 1 97
byte 1 114
byte 1 101
byte 1 44
byte 1 32
byte 1 73
byte 1 110
byte 1 99
byte 1 46
byte 1 32
byte 1 32
byte 1 65
byte 1 108
byte 1 108
byte 1 32
byte 1 82
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 115
byte 1 32
byte 1 82
byte 1 101
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $116
byte 1 68
byte 1 69
byte 1 77
byte 1 79
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 70
byte 1 79
byte 1 82
byte 1 32
byte 1 77
byte 1 65
byte 1 84
byte 1 85
byte 1 82
byte 1 69
byte 1 32
byte 1 65
byte 1 85
byte 1 68
byte 1 73
byte 1 69
byte 1 78
byte 1 67
byte 1 69
byte 1 83
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 68
byte 1 69
byte 1 77
byte 1 79
byte 1 0
align 1
LABELV $95
byte 1 0
align 1
LABELV $94
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 77
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $90
byte 1 69
byte 1 88
byte 1 73
byte 1 84
byte 1 32
byte 1 71
byte 1 65
byte 1 77
byte 1 69
byte 1 63
byte 1 0
align 1
LABELV $88
byte 1 118
byte 1 105
byte 1 100
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 59
byte 1 0
align 1
LABELV $87
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $86
byte 1 102
byte 1 115
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
