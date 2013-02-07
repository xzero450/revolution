data
align 4
LABELV master_items
address $68
address $69
address $70
byte 4 0
align 4
LABELV servertype_items
address $71
address $72
address $73
address $74
address $75
byte 4 0
align 4
LABELV sortkey_items
address $76
address $77
address $78
address $79
address $80
byte 4 0
align 4
LABELV gamenames
address $81
address $82
address $83
address $84
address $85
address $86
address $87
address $88
address $89
address $90
address $91
address $92
address $93
byte 4 0
align 4
LABELV netnames
address $93
address $94
address $95
byte 4 0
align 1
LABELV quake3worldMessage
byte 1 86
byte 1 105
byte 1 115
byte 1 105
byte 1 116
byte 1 32
byte 1 119
byte 1 119
byte 1 119
byte 1 46
byte 1 113
byte 1 117
byte 1 97
byte 1 107
byte 1 101
byte 1 51
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 46
byte 1 99
byte 1 111
byte 1 109
byte 1 32
byte 1 45
byte 1 32
byte 1 78
byte 1 101
byte 1 119
byte 1 115
byte 1 44
byte 1 32
byte 1 67
byte 1 111
byte 1 109
byte 1 109
byte 1 117
byte 1 110
byte 1 105
byte 1 116
byte 1 121
byte 1 44
byte 1 32
byte 1 69
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 44
byte 1 32
byte 1 70
byte 1 105
byte 1 108
byte 1 101
byte 1 115
byte 1 0
export punkbuster_items
align 4
LABELV punkbuster_items
address $96
address $97
byte 4 0
export punkbuster_msg
align 4
LABELV punkbuster_msg
address $98
address $99
address $100
address $101
byte 4 0
code
proc ArenaServers_MaxPing 8 4
file "../ui_servers2.c"
line 238
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:/*
;4:=======================================================================
;5:
;6:MULTIPLAYER MENU (SERVER BROWSER)
;7:
;8:=======================================================================
;9:*/
;10:
;11:
;12:#include "ui_local.h"
;13:
;14:
;15:#define MAX_GLOBALSERVERS		128
;16:#define MAX_PINGREQUESTS		32
;17:#define MAX_ADDRESSLENGTH		64
;18:#define MAX_HOSTNAMELENGTH		22
;19:#define MAX_MAPNAMELENGTH		16
;20:#define MAX_LISTBOXITEMS		128
;21:#define MAX_LOCALSERVERS		128
;22:#define MAX_STATUSLENGTH		64
;23:#define MAX_LEAGUELENGTH		28
;24:#define MAX_LISTBOXWIDTH		68
;25:
;26:#define ART_BACK0				"menu/art/back_0"
;27:#define ART_BACK1				"menu/art/back_1"
;28:#define ART_CREATE0				"menu/art/create_0"
;29:#define ART_CREATE1				"menu/art/create_1"
;30:#define ART_SPECIFY0			"menu/art/specify_0"
;31:#define ART_SPECIFY1			"menu/art/specify_1"
;32:#define ART_REFRESH0			"menu/art/refresh_0"
;33:#define ART_REFRESH1			"menu/art/refresh_1"
;34:#define ART_CONNECT0			"menu/art/fight_0"
;35:#define ART_CONNECT1			"menu/art/fight_1"
;36:#define ART_ARROWS0				"menu/art/arrows_vert_0"
;37:#define ART_ARROWS_UP			"menu/art/arrows_vert_top"
;38:#define ART_ARROWS_DOWN			"menu/art/arrows_vert_bot"
;39:#define ART_UNKNOWNMAP			"menu/art/unknownmap"
;40:#define ART_REMOVE0				"menu/art/delete_0"
;41:#define ART_REMOVE1				"menu/art/delete_1"
;42:#define ART_PUNKBUSTER		"menu/art/pblogo"
;43:
;44:#define ID_MASTER			10
;45:#define ID_GAMETYPE			11
;46:#define ID_SORTKEY			12
;47:#define ID_SHOW_FULL		13
;48:#define ID_SHOW_EMPTY		14
;49:#define ID_LIST				15
;50:#define ID_SCROLL_UP		16
;51:#define ID_SCROLL_DOWN		17
;52:#define ID_BACK				18
;53:#define ID_REFRESH			19
;54:#define ID_SPECIFY			20
;55:#define ID_CREATE			21
;56:#define ID_CONNECT			22
;57:#define ID_REMOVE			23
;58:#define ID_PUNKBUSTER 24
;59:
;60:#define GR_LOGO				30
;61:#define GR_LETTERS			31
;62:
;63:#define AS_LOCAL			0
;64:#define AS_MPLAYER			1
;65:#define AS_GLOBAL			2
;66:#define AS_FAVORITES		3
;67:
;68:#define SORT_HOST			0
;69:#define SORT_MAP			1
;70:#define SORT_CLIENTS		2
;71:#define SORT_GAME			3
;72:#define SORT_PING			4
;73:
;74:#define GAMES_ALL			0
;75:#define GAMES_FFA			1
;76:#define GAMES_TEAMPLAY		2
;77:#define GAMES_TOURNEY		3
;78:#define GAMES_CTF			4
;79:
;80:static const char *master_items[] = {
;81:	"Local",
;82:	"Internet",
;83:	"Favorites",
;84:	0
;85:};
;86:
;87:static const char *servertype_items[] = {
;88:	"All",
;89:	"Free For All",
;90:	"Team Deathmatch",
;91:	"Tournament",
;92:	"Capture the Flag",
;93:	0
;94:};
;95:
;96:static const char *sortkey_items[] = {
;97:	"Server Name",
;98:	"Map Name",
;99:	"Open Player Spots",
;100:	"Game Type",
;101:	"Ping Time",
;102:	0
;103:};
;104:
;105:static char* gamenames[] = {
;106:	"DM ",	// deathmatch
;107:	"1v1",	// tournament
;108:	"SP ",	// single player
;109:	"Team DM",	// team deathmatch
;110:	"CTF",	// capture the flag
;111:	"One Flag CTF",		// one flag ctf
;112:	"OverLoad",				// Overload
;113:	"Harvester",			// Harvester
;114:	"Rocket Arena 3",	// Rocket Arena 3
;115:	"Q3F",						// Q3F
;116:	"Urban Terror",		// Urban Terror
;117:	"OSP",						// Orange Smoothie Productions
;118:	"???",			// unknown
;119:	0
;120:};
;121:
;122:static char* netnames[] = {
;123:	"???",
;124:	"UDP",
;125:	"IPX",
;126:	NULL
;127:};
;128:
;129:static char quake3worldMessage[] = "Visit www.quake3world.com - News, Community, Events, Files";
;130:
;131:const char* punkbuster_items[] = {
;132:	"Disabled",
;133:	"Enabled",
;134:	NULL
;135:};
;136:
;137:const char* punkbuster_msg[] = {
;138:	"PunkBuster will be",
;139:	"disabled the next time",
;140:	"Quake III Arena",
;141:	"is started.",
;142:	NULL
;143:};
;144:
;145:typedef struct {
;146:	char	adrstr[MAX_ADDRESSLENGTH];
;147:	int		start;
;148:} pinglist_t;
;149:
;150:typedef struct servernode_s {
;151:	char	adrstr[MAX_ADDRESSLENGTH];
;152:	char	hostname[MAX_HOSTNAMELENGTH+3];
;153:	char	mapname[MAX_MAPNAMELENGTH];
;154:	int		numclients;
;155:	int		maxclients;
;156:	int		pingtime;
;157:	int		gametype;
;158:	char	gamename[12];
;159:	int		nettype;
;160:	int		minPing;
;161:	int		maxPing;
;162:	qboolean bPB;
;163:
;164:} servernode_t; 
;165:
;166:typedef struct {
;167:	char			buff[MAX_LISTBOXWIDTH];
;168:	servernode_t*	servernode;
;169:} table_t;
;170:
;171:typedef struct {
;172:	menuframework_s		menu;
;173:
;174:	menutext_s			banner;
;175:
;176:	menulist_s			master;
;177:	menulist_s			gametype;
;178:	menulist_s			sortkey;
;179:	menuradiobutton_s	showfull;
;180:	menuradiobutton_s	showempty;
;181:
;182:	menulist_s			list;
;183:	menubitmap_s		mappic;
;184:	menubitmap_s		arrows;
;185:	menubitmap_s		up;
;186:	menubitmap_s		down;
;187:	menutext_s			status;
;188:	menutext_s			statusbar;
;189:
;190:	menubitmap_s		remove;
;191:	menubitmap_s		back;
;192:	menubitmap_s		refresh;
;193:	menubitmap_s		specify;
;194:	menubitmap_s		create;
;195:	menubitmap_s		go;
;196:
;197:	pinglist_t			pinglist[MAX_PINGREQUESTS];
;198:	table_t				table[MAX_LISTBOXITEMS];
;199:	char*				items[MAX_LISTBOXITEMS];
;200:	int					numqueriedservers;
;201:	int					*numservers;
;202:	servernode_t		*serverlist;	
;203:	int					currentping;
;204:	qboolean			refreshservers;
;205:	int					nextpingtime;
;206:	int					maxservers;
;207:	int					refreshtime;
;208:	char				favoriteaddresses[MAX_FAVORITESERVERS][MAX_ADDRESSLENGTH];
;209:	int					numfavoriteaddresses;
;210:
;211:	menulist_s		punkbuster;
;212:	menubitmap_s	pblogo;
;213:} arenaservers_t;
;214:
;215:static arenaservers_t	g_arenaservers;
;216:
;217:
;218:static servernode_t		g_globalserverlist[MAX_GLOBALSERVERS];
;219:static int				g_numglobalservers;
;220:static servernode_t		g_localserverlist[MAX_LOCALSERVERS];
;221:static int				g_numlocalservers;
;222:static servernode_t		g_favoriteserverlist[MAX_FAVORITESERVERS];
;223:static int				g_numfavoriteservers;
;224:static servernode_t		g_mplayerserverlist[MAX_GLOBALSERVERS];
;225:static int				g_nummplayerservers;
;226:static int				g_servertype;
;227:static int				g_gametype;
;228:static int				g_sortkey;
;229:static int				g_emptyservers;
;230:static int				g_fullservers;
;231:
;232:
;233:/*
;234:=================
;235:ArenaServers_MaxPing
;236:=================
;237:*/
;238:static int ArenaServers_MaxPing( void ) {
line 241
;239:	int		maxPing;
;240:
;241:	maxPing = (int)trap_Cvar_VariableValue( "cl_maxPing" );
ADDRGP4 $106
ARGP4
ADDRLP4 4
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
CVFI4 4
ASGNI4
line 242
;242:	if( maxPing < 100 ) {
ADDRLP4 0
INDIRI4
CNSTI4 100
GEI4 $107
line 243
;243:		maxPing = 100;
ADDRLP4 0
CNSTI4 100
ASGNI4
line 244
;244:	}
LABELV $107
line 245
;245:	return maxPing;
ADDRLP4 0
INDIRI4
RETI4
LABELV $105
endproc ArenaServers_MaxPing 8 4
proc ArenaServers_Compare 68 8
line 254
;246:}
;247:
;248:
;249:/*
;250:=================
;251:ArenaServers_Compare
;252:=================
;253:*/
;254:static int QDECL ArenaServers_Compare( const void *arg1, const void *arg2 ) {
line 260
;255:	float			f1;
;256:	float			f2;
;257:	servernode_t*	t1;
;258:	servernode_t*	t2;
;259:
;260:	t1 = (servernode_t *)arg1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 261
;261:	t2 = (servernode_t *)arg2;
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
line 263
;262:
;263:	switch( g_sortkey ) {
ADDRLP4 16
ADDRGP4 g_sortkey
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
LTI4 $110
ADDRLP4 16
INDIRI4
CNSTI4 4
GTI4 $110
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $133
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $133
address $112
address $113
address $114
address $123
address $128
code
LABELV $112
line 265
;264:	case SORT_HOST:
;265:		return Q_stricmp( t1->hostname, t2->hostname );
ADDRLP4 20
CNSTI4 64
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
RETI4
ADDRGP4 $109
JUMPV
LABELV $113
line 268
;266:
;267:	case SORT_MAP:
;268:		return Q_stricmp( t1->mapname, t2->mapname );
ADDRLP4 28
CNSTI4 89
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
ARGP4
ADDRLP4 32
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
RETI4
ADDRGP4 $109
JUMPV
LABELV $114
line 271
;269:
;270:	case SORT_CLIENTS:
;271:		f1 = t1->maxclients - t1->numclients;
ADDRLP4 36
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 36
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
ADDRLP4 36
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 272
;272:		if( f1 < 0 ) {
ADDRLP4 8
INDIRF4
CNSTF4 0
GEF4 $115
line 273
;273:			f1 = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 274
;274:		}
LABELV $115
line 276
;275:
;276:		f2 = t2->maxclients - t2->numclients;
ADDRLP4 40
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 40
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
ADDRLP4 40
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 277
;277:		if( f2 < 0 ) {
ADDRLP4 12
INDIRF4
CNSTF4 0
GEF4 $117
line 278
;278:			f2 = 0;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 279
;279:		}
LABELV $117
line 281
;280:
;281:		if( f1 < f2 ) {
ADDRLP4 8
INDIRF4
ADDRLP4 12
INDIRF4
GEF4 $119
line 282
;282:			return 1;
CNSTI4 1
RETI4
ADDRGP4 $109
JUMPV
LABELV $119
line 284
;283:		}
;284:		if( f1 == f2 ) {
ADDRLP4 8
INDIRF4
ADDRLP4 12
INDIRF4
NEF4 $121
line 285
;285:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $109
JUMPV
LABELV $121
line 287
;286:		}
;287:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $109
JUMPV
LABELV $123
line 290
;288:
;289:	case SORT_GAME:
;290:		if( t1->gametype < t2->gametype ) {
ADDRLP4 44
CNSTI4 120
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRI4
GEI4 $124
line 291
;291:			return -1;
CNSTI4 -1
RETI4
ADDRGP4 $109
JUMPV
LABELV $124
line 293
;292:		}
;293:		if( t1->gametype == t2->gametype ) {
ADDRLP4 48
CNSTI4 120
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRI4
NEI4 $126
line 294
;294:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $109
JUMPV
LABELV $126
line 296
;295:		}
;296:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $109
JUMPV
LABELV $128
line 299
;297:
;298:	case SORT_PING:
;299:		if( t1->pingtime < t2->pingtime ) {
ADDRLP4 52
CNSTI4 116
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRI4
GEI4 $129
line 300
;300:			return -1;
CNSTI4 -1
RETI4
ADDRGP4 $109
JUMPV
LABELV $129
line 302
;301:		}
;302:		if( t1->pingtime > t2->pingtime ) {
ADDRLP4 56
CNSTI4 116
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRI4
LEI4 $131
line 303
;303:			return 1;
CNSTI4 1
RETI4
ADDRGP4 $109
JUMPV
LABELV $131
line 305
;304:		}
;305:		return Q_stricmp( t1->hostname, t2->hostname );
ADDRLP4 60
CNSTI4 64
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
ARGP4
ADDRLP4 64
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
RETI4
ADDRGP4 $109
JUMPV
LABELV $110
line 308
;306:	}
;307:
;308:	return 0;
CNSTI4 0
RETI4
LABELV $109
endproc ArenaServers_Compare 68 8
proc ArenaServers_Go 8 8
line 317
;309:}
;310:
;311:
;312:/*
;313:=================
;314:ArenaServers_Go
;315:=================
;316:*/
;317:static void ArenaServers_Go( void ) {
line 320
;318:	servernode_t*	servernode;
;319:
;320:	servernode = g_arenaservers.table[g_arenaservers.list.curvalue].servernode;
ADDRLP4 0
CNSTI4 72
ADDRGP4 g_arenaservers+776+64
INDIRI4
MULI4
ADDRGP4 g_arenaservers+4072+68
ADDP4
INDIRP4
ASGNP4
line 321
;321:	if( servernode ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $139
line 322
;322:		trap_Cmd_ExecuteText( EXEC_APPEND, va( "connect %s\n", servernode->adrstr ) );
ADDRGP4 $141
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 323
;323:	}
LABELV $139
line 324
;324:}
LABELV $134
endproc ArenaServers_Go 8 8
bss
align 1
LABELV $143
skip 64
code
proc ArenaServers_UpdatePicture 4 16
line 332
;325:
;326:
;327:/*
;328:=================
;329:ArenaServers_UpdatePicture
;330:=================
;331:*/
;332:static void ArenaServers_UpdatePicture( void ) {
line 336
;333:	static char		picname[64];
;334:	servernode_t*	servernodeptr;
;335:
;336:	if( !g_arenaservers.list.numitems ) {
ADDRGP4 g_arenaservers+776+68
INDIRI4
CNSTI4 0
NEI4 $144
line 337
;337:		g_arenaservers.mappic.generic.name = NULL;
ADDRGP4 g_arenaservers+872+4
CNSTP4 0
ASGNP4
line 338
;338:	}
ADDRGP4 $145
JUMPV
LABELV $144
line 339
;339:	else {
line 340
;340:		servernodeptr = g_arenaservers.table[g_arenaservers.list.curvalue].servernode;
ADDRLP4 0
CNSTI4 72
ADDRGP4 g_arenaservers+776+64
INDIRI4
MULI4
ADDRGP4 g_arenaservers+4072+68
ADDP4
INDIRP4
ASGNP4
line 341
;341:		Com_sprintf( picname, sizeof(picname), "levelshots/%s.tga", servernodeptr->mapname );
ADDRGP4 $143
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $154
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 89
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 342
;342:		g_arenaservers.mappic.generic.name = picname;
ADDRGP4 g_arenaservers+872+4
ADDRGP4 $143
ASGNP4
line 344
;343:	
;344:	}
LABELV $145
line 347
;345:
;346:	// force shader update during draw
;347:	g_arenaservers.mappic.shader = 0;
ADDRGP4 g_arenaservers+872+68
CNSTI4 0
ASGNI4
line 348
;348:}
LABELV $142
endproc ArenaServers_UpdatePicture 4 16
proc ArenaServers_UpdateMenu 68 48
line 356
;349:
;350:
;351:/*
;352:=================
;353:ArenaServers_UpdateMenu
;354:=================
;355:*/
;356:static void ArenaServers_UpdateMenu( void ) {
line 365
;357:	int				i;
;358:	int				j;
;359:	int				count;
;360:	char*			buff;
;361:	servernode_t*	servernodeptr;
;362:	table_t*		tableptr;
;363:	char			*pingColor;
;364:
;365:	if( g_arenaservers.numqueriedservers > 0 ) {
ADDRGP4 g_arenaservers+13800
INDIRI4
CNSTI4 0
LEI4 $160
line 367
;366:		// servers found
;367:		if( g_arenaservers.refreshservers && ( g_arenaservers.currentping <= g_arenaservers.numqueriedservers ) ) {
ADDRGP4 g_arenaservers+13816
INDIRI4
CNSTI4 0
EQI4 $163
ADDRGP4 g_arenaservers+13812
INDIRI4
ADDRGP4 g_arenaservers+13800
INDIRI4
GTI4 $163
line 369
;368:			// show progress
;369:			Com_sprintf( g_arenaservers.status.string, MAX_STATUSLENGTH, "%d of %d Arena Servers.", g_arenaservers.currentping, g_arenaservers.numqueriedservers);
ADDRGP4 g_arenaservers+1224+60
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $170
ARGP4
ADDRGP4 g_arenaservers+13812
INDIRI4
ARGI4
ADDRGP4 g_arenaservers+13800
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 370
;370:			g_arenaservers.statusbar.string  = "Press SPACE to stop";
ADDRGP4 g_arenaservers+1296+60
ADDRGP4 $175
ASGNP4
line 371
;371:			qsort( g_arenaservers.serverlist, *g_arenaservers.numservers, sizeof( servernode_t ), ArenaServers_Compare);
ADDRGP4 g_arenaservers+13808
INDIRP4
ARGP4
ADDRGP4 g_arenaservers+13804
INDIRP4
INDIRI4
ARGI4
CNSTI4 152
ARGI4
ADDRGP4 ArenaServers_Compare
ARGP4
ADDRGP4 qsort
CALLV
pop
line 372
;372:		}
ADDRGP4 $161
JUMPV
LABELV $163
line 373
;373:		else {
line 375
;374:			// all servers pinged - enable controls
;375:			g_arenaservers.master.generic.flags		&= ~QMF_GRAYED;
ADDRLP4 28
ADDRGP4 g_arenaservers+360+44
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRU4
CNSTU4 4294959103
BANDU4
ASGNU4
line 376
;376:			g_arenaservers.gametype.generic.flags	&= ~QMF_GRAYED;
ADDRLP4 32
ADDRGP4 g_arenaservers+456+44
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRU4
CNSTU4 4294959103
BANDU4
ASGNU4
line 377
;377:			g_arenaservers.sortkey.generic.flags	&= ~QMF_GRAYED;
ADDRLP4 36
ADDRGP4 g_arenaservers+552+44
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRU4
CNSTU4 4294959103
BANDU4
ASGNU4
line 378
;378:			g_arenaservers.showempty.generic.flags	&= ~QMF_GRAYED;
ADDRLP4 40
ADDRGP4 g_arenaservers+712+44
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRU4
CNSTU4 4294959103
BANDU4
ASGNU4
line 379
;379:			g_arenaservers.showfull.generic.flags	&= ~QMF_GRAYED;
ADDRLP4 44
ADDRGP4 g_arenaservers+648+44
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRU4
CNSTU4 4294959103
BANDU4
ASGNU4
line 380
;380:			g_arenaservers.list.generic.flags		&= ~QMF_GRAYED;
ADDRLP4 48
ADDRGP4 g_arenaservers+776+44
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRU4
CNSTU4 4294959103
BANDU4
ASGNU4
line 381
;381:			g_arenaservers.refresh.generic.flags	&= ~QMF_GRAYED;
ADDRLP4 52
ADDRGP4 g_arenaservers+1544+44
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRU4
CNSTU4 4294959103
BANDU4
ASGNU4
line 382
;382:			g_arenaservers.go.generic.flags			&= ~QMF_GRAYED;
ADDRLP4 56
ADDRGP4 g_arenaservers+1808+44
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRU4
CNSTU4 4294959103
BANDU4
ASGNU4
line 383
;383:			g_arenaservers.punkbuster.generic.flags &= ~QMF_GRAYED;
ADDRLP4 60
ADDRGP4 g_arenaservers+14860+44
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRU4
CNSTU4 4294959103
BANDU4
ASGNU4
line 386
;384:
;385:			// update status bar
;386:			if( g_servertype == AS_GLOBAL || g_servertype == AS_MPLAYER ) {
ADDRLP4 64
ADDRGP4 g_servertype
INDIRI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 2
EQI4 $198
ADDRLP4 64
INDIRI4
CNSTI4 1
NEI4 $196
LABELV $198
line 387
;387:				g_arenaservers.statusbar.string = quake3worldMessage;
ADDRGP4 g_arenaservers+1296+60
ADDRGP4 quake3worldMessage
ASGNP4
line 388
;388:			}
ADDRGP4 $161
JUMPV
LABELV $196
line 389
;389:			else {
line 390
;390:				g_arenaservers.statusbar.string = "";
ADDRGP4 g_arenaservers+1296+60
ADDRGP4 $203
ASGNP4
line 391
;391:			}
line 393
;392:
;393:		}
line 394
;394:	}
ADDRGP4 $161
JUMPV
LABELV $160
line 395
;395:	else {
line 397
;396:		// no servers found
;397:		if( g_arenaservers.refreshservers ) {
ADDRGP4 g_arenaservers+13816
INDIRI4
CNSTI4 0
EQI4 $204
line 398
;398:			strcpy( g_arenaservers.status.string,"Scanning For Servers." );
ADDRGP4 g_arenaservers+1224+60
INDIRP4
ARGP4
ADDRGP4 $209
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 399
;399:			g_arenaservers.statusbar.string = "Press SPACE to stop";
ADDRGP4 g_arenaservers+1296+60
ADDRGP4 $175
ASGNP4
line 402
;400:
;401:			// disable controls during refresh
;402:			g_arenaservers.master.generic.flags		|= QMF_GRAYED;
ADDRLP4 28
ADDRGP4 g_arenaservers+360+44
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 403
;403:			g_arenaservers.gametype.generic.flags	|= QMF_GRAYED;
ADDRLP4 32
ADDRGP4 g_arenaservers+456+44
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 404
;404:			g_arenaservers.sortkey.generic.flags	|= QMF_GRAYED;
ADDRLP4 36
ADDRGP4 g_arenaservers+552+44
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 405
;405:			g_arenaservers.showempty.generic.flags	|= QMF_GRAYED;
ADDRLP4 40
ADDRGP4 g_arenaservers+712+44
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 406
;406:			g_arenaservers.showfull.generic.flags	|= QMF_GRAYED;
ADDRLP4 44
ADDRGP4 g_arenaservers+648+44
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 407
;407:			g_arenaservers.list.generic.flags		|= QMF_GRAYED;
ADDRLP4 48
ADDRGP4 g_arenaservers+776+44
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 408
;408:			g_arenaservers.refresh.generic.flags	|= QMF_GRAYED;
ADDRLP4 52
ADDRGP4 g_arenaservers+1544+44
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 409
;409:			g_arenaservers.go.generic.flags			|= QMF_GRAYED;
ADDRLP4 56
ADDRGP4 g_arenaservers+1808+44
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 410
;410:			g_arenaservers.punkbuster.generic.flags |= QMF_GRAYED;
ADDRLP4 60
ADDRGP4 g_arenaservers+14860+44
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 411
;411:		}
ADDRGP4 $205
JUMPV
LABELV $204
line 412
;412:		else {
line 413
;413:			if( g_arenaservers.numqueriedservers < 0 ) {
ADDRGP4 g_arenaservers+13800
INDIRI4
CNSTI4 0
GEI4 $230
line 414
;414:				strcpy(g_arenaservers.status.string,"No Response From Master Server." );
ADDRGP4 g_arenaservers+1224+60
INDIRP4
ARGP4
ADDRGP4 $235
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 415
;415:			}
ADDRGP4 $231
JUMPV
LABELV $230
line 416
;416:			else {
line 417
;417:				strcpy(g_arenaservers.status.string,"No Servers Found." );
ADDRGP4 g_arenaservers+1224+60
INDIRP4
ARGP4
ADDRGP4 $238
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 418
;418:			}
LABELV $231
line 421
;419:
;420:			// update status bar
;421:			if( g_servertype == AS_GLOBAL || g_servertype == AS_MPLAYER ) {
ADDRLP4 28
ADDRGP4 g_servertype
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 2
EQI4 $241
ADDRLP4 28
INDIRI4
CNSTI4 1
NEI4 $239
LABELV $241
line 422
;422:				g_arenaservers.statusbar.string = quake3worldMessage;
ADDRGP4 g_arenaservers+1296+60
ADDRGP4 quake3worldMessage
ASGNP4
line 423
;423:			}
ADDRGP4 $240
JUMPV
LABELV $239
line 424
;424:			else {
line 425
;425:				g_arenaservers.statusbar.string = "";
ADDRGP4 g_arenaservers+1296+60
ADDRGP4 $203
ASGNP4
line 426
;426:			}
LABELV $240
line 429
;427:
;428:			// end of refresh - set control state
;429:			g_arenaservers.master.generic.flags		&= ~QMF_GRAYED;
ADDRLP4 32
ADDRGP4 g_arenaservers+360+44
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRU4
CNSTU4 4294959103
BANDU4
ASGNU4
line 430
;430:			g_arenaservers.gametype.generic.flags	&= ~QMF_GRAYED;
ADDRLP4 36
ADDRGP4 g_arenaservers+456+44
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRU4
CNSTU4 4294959103
BANDU4
ASGNU4
line 431
;431:			g_arenaservers.sortkey.generic.flags	&= ~QMF_GRAYED;
ADDRLP4 40
ADDRGP4 g_arenaservers+552+44
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRU4
CNSTU4 4294959103
BANDU4
ASGNU4
line 432
;432:			g_arenaservers.showempty.generic.flags	&= ~QMF_GRAYED;
ADDRLP4 44
ADDRGP4 g_arenaservers+712+44
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRU4
CNSTU4 4294959103
BANDU4
ASGNU4
line 433
;433:			g_arenaservers.showfull.generic.flags	&= ~QMF_GRAYED;
ADDRLP4 48
ADDRGP4 g_arenaservers+648+44
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRU4
CNSTU4 4294959103
BANDU4
ASGNU4
line 434
;434:			g_arenaservers.list.generic.flags		|= QMF_GRAYED;
ADDRLP4 52
ADDRGP4 g_arenaservers+776+44
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 435
;435:			g_arenaservers.refresh.generic.flags	&= ~QMF_GRAYED;
ADDRLP4 56
ADDRGP4 g_arenaservers+1544+44
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRU4
CNSTU4 4294959103
BANDU4
ASGNU4
line 436
;436:			g_arenaservers.go.generic.flags			|= QMF_GRAYED;
ADDRLP4 60
ADDRGP4 g_arenaservers+1808+44
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 437
;437:			g_arenaservers.punkbuster.generic.flags &= ~QMF_GRAYED;
ADDRLP4 64
ADDRGP4 g_arenaservers+14860+44
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRU4
CNSTU4 4294959103
BANDU4
ASGNU4
line 438
;438:		}
LABELV $205
line 441
;439:
;440:		// zero out list box
;441:		g_arenaservers.list.numitems = 0;
ADDRGP4 g_arenaservers+776+68
CNSTI4 0
ASGNI4
line 442
;442:		g_arenaservers.list.curvalue = 0;
ADDRGP4 g_arenaservers+776+64
CNSTI4 0
ASGNI4
line 443
;443:		g_arenaservers.list.top      = 0;
ADDRGP4 g_arenaservers+776+72
CNSTI4 0
ASGNI4
line 446
;444:
;445:		// update picture
;446:		ArenaServers_UpdatePicture();
ADDRGP4 ArenaServers_UpdatePicture
CALLV
pop
line 447
;447:		return;
ADDRGP4 $159
JUMPV
LABELV $161
line 451
;448:	}
;449:
;450:	// build list box strings - apply culling filters
;451:	servernodeptr = g_arenaservers.serverlist;
ADDRLP4 0
ADDRGP4 g_arenaservers+13808
INDIRP4
ASGNP4
line 452
;452:	count         = *g_arenaservers.numservers;
ADDRLP4 24
ADDRGP4 g_arenaservers+13804
INDIRP4
INDIRI4
ASGNI4
line 453
;453:	for( i = 0, j = 0; i < count; i++, servernodeptr++ ) {
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRLP4 12
ADDRLP4 28
INDIRI4
ASGNI4
ADDRLP4 8
ADDRLP4 28
INDIRI4
ASGNI4
ADDRGP4 $275
JUMPV
LABELV $272
line 454
;454:		tableptr = &g_arenaservers.table[j];
ADDRLP4 4
CNSTI4 72
ADDRLP4 8
INDIRI4
MULI4
ADDRGP4 g_arenaservers+4072
ADDP4
ASGNP4
line 455
;455:		tableptr->servernode = servernodeptr;
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 456
;456:		buff = tableptr->buff;
ADDRLP4 16
ADDRLP4 4
INDIRP4
ASGNP4
line 459
;457:
;458:		// can only cull valid results
;459:		if( !g_emptyservers && !servernodeptr->numclients ) {
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRGP4 g_emptyservers
INDIRI4
ADDRLP4 32
INDIRI4
NEI4 $277
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ADDRLP4 32
INDIRI4
NEI4 $277
line 460
;460:			continue;
ADDRGP4 $273
JUMPV
LABELV $277
line 463
;461:		}
;462:
;463:		if( !g_fullservers && ( servernodeptr->numclients == servernodeptr->maxclients ) ) {
ADDRGP4 g_fullservers
INDIRI4
CNSTI4 0
NEI4 $279
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
NEI4 $279
line 464
;464:			continue;
ADDRGP4 $273
JUMPV
LABELV $279
line 467
;465:		}
;466:
;467:		switch( g_gametype ) {
ADDRLP4 40
ADDRGP4 g_gametype
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
LTI4 $281
ADDRLP4 40
INDIRI4
CNSTI4 4
GTI4 $281
ADDRLP4 40
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $296
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $296
address $282
address $284
address $287
address $290
address $293
code
line 469
;468:		case GAMES_ALL:
;469:			break;
LABELV $284
line 472
;470:
;471:		case GAMES_FFA:
;472:			if( servernodeptr->gametype != GT_FFA ) {
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
CNSTI4 0
EQI4 $282
line 473
;473:				continue;
ADDRGP4 $273
JUMPV
line 475
;474:			}
;475:			break;
LABELV $287
line 478
;476:
;477:		case GAMES_TEAMPLAY:
;478:			if( servernodeptr->gametype != GT_TEAM ) {
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
CNSTI4 3
EQI4 $282
line 479
;479:				continue;
ADDRGP4 $273
JUMPV
line 481
;480:			}
;481:			break;
LABELV $290
line 484
;482:
;483:		case GAMES_TOURNEY:
;484:			if( servernodeptr->gametype != GT_TOURNAMENT ) {
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
CNSTI4 1
EQI4 $282
line 485
;485:				continue;
ADDRGP4 $273
JUMPV
line 487
;486:			}
;487:			break;
LABELV $293
line 490
;488:
;489:		case GAMES_CTF:
;490:			if( servernodeptr->gametype != GT_CTF ) {
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
CNSTI4 4
EQI4 $282
line 491
;491:				continue;
ADDRGP4 $273
JUMPV
line 493
;492:			}
;493:			break;
LABELV $281
LABELV $282
line 496
;494:		}
;495:
;496:		if( servernodeptr->pingtime < servernodeptr->minPing ) {
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
GEI4 $297
line 497
;497:			pingColor = S_COLOR_BLUE;
ADDRLP4 20
ADDRGP4 $299
ASGNP4
line 498
;498:		}
ADDRGP4 $298
JUMPV
LABELV $297
line 499
;499:		else if( servernodeptr->maxPing && servernodeptr->pingtime > servernodeptr->maxPing ) {
ADDRLP4 52
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $300
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
ADDRLP4 52
INDIRI4
LEI4 $300
line 500
;500:			pingColor = S_COLOR_BLUE;
ADDRLP4 20
ADDRGP4 $299
ASGNP4
line 501
;501:		}
ADDRGP4 $301
JUMPV
LABELV $300
line 502
;502:		else if( servernodeptr->pingtime < 200 ) {
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
CNSTI4 200
GEI4 $302
line 503
;503:			pingColor = S_COLOR_GREEN;
ADDRLP4 20
ADDRGP4 $304
ASGNP4
line 504
;504:		}
ADDRGP4 $303
JUMPV
LABELV $302
line 505
;505:		else if( servernodeptr->pingtime < 400 ) {
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
CNSTI4 400
GEI4 $305
line 506
;506:			pingColor = S_COLOR_YELLOW;
ADDRLP4 20
ADDRGP4 $307
ASGNP4
line 507
;507:		}
ADDRGP4 $306
JUMPV
LABELV $305
line 508
;508:		else {
line 509
;509:			pingColor = S_COLOR_RED;
ADDRLP4 20
ADDRGP4 $308
ASGNP4
line 510
;510:		}
LABELV $306
LABELV $303
LABELV $301
LABELV $298
line 512
;511:
;512:		Com_sprintf( buff, MAX_LISTBOXWIDTH, "%-20.20s %-12.12s %2d/%2d %-8.8s %3s %s%3d " S_COLOR_YELLOW "%s", 
ADDRLP4 16
INDIRP4
ARGP4
CNSTI4 68
ARGI4
ADDRGP4 $309
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 89
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 124
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 136
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 netnames
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 0
EQI4 $313
ADDRLP4 56
ADDRGP4 $310
ASGNP4
ADDRGP4 $314
JUMPV
LABELV $313
ADDRLP4 56
ADDRGP4 $311
ASGNP4
LABELV $314
ADDRLP4 56
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 516
;513:			servernodeptr->hostname, servernodeptr->mapname, servernodeptr->numclients,
;514: 			servernodeptr->maxclients, servernodeptr->gamename,
;515:			netnames[servernodeptr->nettype], pingColor, servernodeptr->pingtime, servernodeptr->bPB ? "Yes" : "No" );
;516:		j++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 517
;517:	}
LABELV $273
line 453
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
ASGNP4
LABELV $275
ADDRLP4 12
INDIRI4
ADDRLP4 24
INDIRI4
LTI4 $272
line 519
;518:
;519:	g_arenaservers.list.numitems = j;
ADDRGP4 g_arenaservers+776+68
ADDRLP4 8
INDIRI4
ASGNI4
line 520
;520:	g_arenaservers.list.curvalue = 0;
ADDRGP4 g_arenaservers+776+64
CNSTI4 0
ASGNI4
line 521
;521:	g_arenaservers.list.top      = 0;
ADDRGP4 g_arenaservers+776+72
CNSTI4 0
ASGNI4
line 524
;522:
;523:	// update picture
;524:	ArenaServers_UpdatePicture();
ADDRGP4 ArenaServers_UpdatePicture
CALLV
pop
line 525
;525:}
LABELV $159
endproc ArenaServers_UpdateMenu 68 48
proc ArenaServers_Remove 24 12
line 534
;526:
;527:
;528:/*
;529:=================
;530:ArenaServers_Remove
;531:=================
;532:*/
;533:static void ArenaServers_Remove( void )
;534:{
line 539
;535:	int				i;
;536:	servernode_t*	servernodeptr;
;537:	table_t*		tableptr;
;538:
;539:	if (!g_arenaservers.list.numitems)
ADDRGP4 g_arenaservers+776+68
INDIRI4
CNSTI4 0
NEI4 $322
line 540
;540:		return;
ADDRGP4 $321
JUMPV
LABELV $322
line 546
;541:
;542:	// remove selected item from display list
;543:	// items are in scattered order due to sort and cull
;544:	// perform delete on list box contents, resync all lists
;545:
;546:	tableptr      = &g_arenaservers.table[g_arenaservers.list.curvalue];
ADDRLP4 8
CNSTI4 72
ADDRGP4 g_arenaservers+776+64
INDIRI4
MULI4
ADDRGP4 g_arenaservers+4072
ADDP4
ASGNP4
line 547
;547:	servernodeptr = tableptr->servernode;
ADDRLP4 4
ADDRLP4 8
INDIRP4
CNSTI4 68
ADDP4
INDIRP4
ASGNP4
line 550
;548:
;549:	// find address in master list
;550:	for (i=0; i<g_arenaservers.numfavoriteaddresses; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $332
JUMPV
LABELV $329
line 551
;551:		if (!Q_stricmp(g_arenaservers.favoriteaddresses[i],servernodeptr->adrstr))
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 g_arenaservers+13832
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $334
line 552
;552:				break;
ADDRGP4 $331
JUMPV
LABELV $334
LABELV $330
line 550
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $332
ADDRLP4 0
INDIRI4
ADDRGP4 g_arenaservers+14856
INDIRI4
LTI4 $329
LABELV $331
line 555
;553:
;554:	// delete address from master list
;555:	if (i <= g_arenaservers.numfavoriteaddresses-1)
ADDRLP4 0
INDIRI4
ADDRGP4 g_arenaservers+14856
INDIRI4
CNSTI4 1
SUBI4
GTI4 $337
line 556
;556:	{
line 557
;557:		if (i < g_arenaservers.numfavoriteaddresses-1)
ADDRLP4 0
INDIRI4
ADDRGP4 g_arenaservers+14856
INDIRI4
CNSTI4 1
SUBI4
GEI4 $340
line 558
;558:		{
line 560
;559:			// shift items up
;560:			memcpy( &g_arenaservers.favoriteaddresses[i], &g_arenaservers.favoriteaddresses[i+1], (g_arenaservers.numfavoriteaddresses - i - 1)*sizeof(MAX_ADDRESSLENGTH));
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRGP4 g_arenaservers+13832
ADDP4
ARGP4
ADDRLP4 20
INDIRI4
ADDRGP4 g_arenaservers+13832+64
ADDP4
ARGP4
ADDRGP4 g_arenaservers+14856
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 1
SUBI4
CVIU4 4
CNSTI4 2
LSHU4
CVUI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 561
;561:		}
LABELV $340
line 562
;562:		g_arenaservers.numfavoriteaddresses--;
ADDRLP4 16
ADDRGP4 g_arenaservers+14856
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 563
;563:	}	
LABELV $337
line 566
;564:
;565:	// find address in server list
;566:	for (i=0; i<g_numfavoriteservers; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $351
JUMPV
LABELV $348
line 567
;567:		if (&g_favoriteserverlist[i] == servernodeptr)
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_favoriteserverlist
ADDP4
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
NEU4 $352
line 568
;568:				break;
ADDRGP4 $350
JUMPV
LABELV $352
LABELV $349
line 566
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $351
ADDRLP4 0
INDIRI4
ADDRGP4 g_numfavoriteservers
INDIRI4
LTI4 $348
LABELV $350
line 571
;569:
;570:	// delete address from server list
;571:	if (i <= g_numfavoriteservers-1)
ADDRLP4 0
INDIRI4
ADDRGP4 g_numfavoriteservers
INDIRI4
CNSTI4 1
SUBI4
GTI4 $354
line 572
;572:	{
line 573
;573:		if (i < g_numfavoriteservers-1)
ADDRLP4 0
INDIRI4
ADDRGP4 g_numfavoriteservers
INDIRI4
CNSTI4 1
SUBI4
GEI4 $356
line 574
;574:		{
line 576
;575:			// shift items up
;576:			memcpy( &g_favoriteserverlist[i], &g_favoriteserverlist[i+1], (g_numfavoriteservers - i - 1)*sizeof(servernode_t));
ADDRLP4 20
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRGP4 g_favoriteserverlist
ADDP4
ARGP4
ADDRLP4 20
INDIRI4
ADDRGP4 g_favoriteserverlist+152
ADDP4
ARGP4
CNSTU4 152
ADDRGP4 g_numfavoriteservers
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 1
SUBI4
CVIU4 4
MULU4
CVUI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 577
;577:		}
LABELV $356
line 578
;578:		g_numfavoriteservers--;
ADDRLP4 16
ADDRGP4 g_numfavoriteservers
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 579
;579:	}	
LABELV $354
line 581
;580:
;581:	g_arenaservers.numqueriedservers = g_arenaservers.numfavoriteaddresses;
ADDRGP4 g_arenaservers+13800
ADDRGP4 g_arenaservers+14856
INDIRI4
ASGNI4
line 582
;582:	g_arenaservers.currentping       = g_arenaservers.numfavoriteaddresses;
ADDRGP4 g_arenaservers+13812
ADDRGP4 g_arenaservers+14856
INDIRI4
ASGNI4
line 583
;583:}
LABELV $321
endproc ArenaServers_Remove 24 12
proc ArenaServers_Insert 84 12
line 592
;584:
;585:
;586:/*
;587:=================
;588:ArenaServers_Insert
;589:=================
;590:*/
;591:static void ArenaServers_Insert( char* adrstr, char* info, int pingtime )
;592:{
line 598
;593:	servernode_t*	servernodeptr;
;594:	char*			s;
;595:	int				i;
;596:
;597:
;598:	if ((pingtime >= ArenaServers_MaxPing()) && (g_servertype != AS_FAVORITES))
ADDRLP4 12
ADDRGP4 ArenaServers_MaxPing
CALLI4
ASGNI4
ADDRFP4 8
INDIRI4
ADDRLP4 12
INDIRI4
LTI4 $364
ADDRGP4 g_servertype
INDIRI4
CNSTI4 3
EQI4 $364
line 599
;599:	{
line 601
;600:		// slow global or local servers do not get entered
;601:		return;
ADDRGP4 $363
JUMPV
LABELV $364
line 604
;602:	}
;603:
;604:	if (*g_arenaservers.numservers >= g_arenaservers.maxservers) {
ADDRGP4 g_arenaservers+13804
INDIRP4
INDIRI4
ADDRGP4 g_arenaservers+13824
INDIRI4
LTI4 $366
line 606
;605:		// list full;
;606:		servernodeptr = g_arenaservers.serverlist+(*g_arenaservers.numservers)-1;
ADDRLP4 0
CNSTI4 152
ADDRGP4 g_arenaservers+13804
INDIRP4
INDIRI4
MULI4
ADDRGP4 g_arenaservers+13808
INDIRP4
ADDP4
CNSTI4 -152
ADDP4
ASGNP4
line 607
;607:	} else {
ADDRGP4 $367
JUMPV
LABELV $366
line 609
;608:		// next slot
;609:		servernodeptr = g_arenaservers.serverlist+(*g_arenaservers.numservers);
ADDRLP4 0
CNSTI4 152
ADDRGP4 g_arenaservers+13804
INDIRP4
INDIRI4
MULI4
ADDRGP4 g_arenaservers+13808
INDIRP4
ADDP4
ASGNP4
line 610
;610:		(*g_arenaservers.numservers)++;
ADDRLP4 16
ADDRGP4 g_arenaservers+13804
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 611
;611:	}
LABELV $367
line 613
;612:
;613:	Q_strncpyz( servernodeptr->adrstr, adrstr, MAX_ADDRESSLENGTH );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 615
;614:
;615:	Q_strncpyz( servernodeptr->hostname, Info_ValueForKey( info, "hostname"), MAX_HOSTNAMELENGTH );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $375
ARGP4
ADDRLP4 16
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
CNSTI4 22
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 616
;616:	Q_CleanStr( servernodeptr->hostname );
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 617
;617:	Q_strupr( servernodeptr->hostname );
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 619
;618:
;619:	Q_strncpyz( servernodeptr->mapname, Info_ValueForKey( info, "mapname"), MAX_MAPNAMELENGTH );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $376
ARGP4
ADDRLP4 20
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 89
ADDP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 620
;620:	Q_CleanStr( servernodeptr->mapname );
ADDRLP4 0
INDIRP4
CNSTI4 89
ADDP4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 621
;621:	Q_strupr( servernodeptr->mapname );
ADDRLP4 0
INDIRP4
CNSTI4 89
ADDP4
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 623
;622:
;623:	servernodeptr->numclients = atoi( Info_ValueForKey( info, "clients") );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $377
ARGP4
ADDRLP4 24
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 624
;624:	servernodeptr->maxclients = atoi( Info_ValueForKey( info, "sv_maxclients") );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $378
ARGP4
ADDRLP4 32
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 625
;625:	servernodeptr->pingtime   = pingtime;
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 626
;626:	servernodeptr->minPing    = atoi( Info_ValueForKey( info, "minPing") );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $379
ARGP4
ADDRLP4 40
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
line 627
;627:	servernodeptr->maxPing    = atoi( Info_ValueForKey( info, "maxPing") );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $380
ARGP4
ADDRLP4 48
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
ADDRLP4 52
INDIRI4
ASGNI4
line 628
;628:	servernodeptr->bPB = atoi( Info_ValueForKey( info, "punkbuster") );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $381
ARGP4
ADDRLP4 56
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
ADDRLP4 60
INDIRI4
ASGNI4
line 646
;629:
;630:	/*
;631:	s = Info_ValueForKey( info, "nettype" );
;632:	for (i=0; ;i++)
;633:	{
;634:		if (!netnames[i])
;635:		{
;636:			servernodeptr->nettype = 0;
;637:			break;
;638:		}
;639:		else if (!Q_stricmp( netnames[i], s ))
;640:		{
;641:			servernodeptr->nettype = i;
;642:			break;
;643:		}
;644:	}
;645:	*/
;646:	servernodeptr->nettype = atoi(Info_ValueForKey(info, "nettype"));
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $382
ARGP4
ADDRLP4 64
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 136
ADDP4
ADDRLP4 68
INDIRI4
ASGNI4
line 648
;647:
;648:	s = Info_ValueForKey( info, "game");
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $383
ARGP4
ADDRLP4 72
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 72
INDIRP4
ASGNP4
line 649
;649:	i = atoi( Info_ValueForKey( info, "gametype") );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $384
ARGP4
ADDRLP4 76
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 80
INDIRI4
ASGNI4
line 650
;650:	if( i < 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $385
line 651
;651:		i = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 652
;652:	}
ADDRGP4 $386
JUMPV
LABELV $385
line 653
;653:	else if( i > 11 ) {
ADDRLP4 4
INDIRI4
CNSTI4 11
LEI4 $387
line 654
;654:		i = 12;
ADDRLP4 4
CNSTI4 12
ASGNI4
line 655
;655:	}
LABELV $387
LABELV $386
line 656
;656:	if( *s ) {
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $389
line 657
;657:		servernodeptr->gametype = i;//-1;
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 658
;658:		Q_strncpyz( servernodeptr->gamename, s, sizeof(servernodeptr->gamename) );
ADDRLP4 0
INDIRP4
CNSTI4 124
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 659
;659:	}
ADDRGP4 $390
JUMPV
LABELV $389
line 660
;660:	else {
line 661
;661:		servernodeptr->gametype = i;
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 662
;662:		Q_strncpyz( servernodeptr->gamename, gamenames[i], sizeof(servernodeptr->gamename) );
ADDRLP4 0
INDIRP4
CNSTI4 124
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gamenames
ADDP4
INDIRP4
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 663
;663:	}
LABELV $390
line 664
;664:}
LABELV $363
endproc ArenaServers_Insert 84 12
export ArenaServers_InsertFavorites
proc ArenaServers_InsertFavorites 1040 12
line 675
;665:
;666:
;667:/*
;668:=================
;669:ArenaServers_InsertFavorites
;670:
;671:Insert nonresponsive address book entries into display lists.
;672:=================
;673:*/
;674:void ArenaServers_InsertFavorites( void )
;675:{
line 681
;676:	int		i;
;677:	int		j;
;678:	char	info[MAX_INFO_STRING];
;679:
;680:	// resync existing results with new or deleted cvars
;681:	info[0] = '\0';
ADDRLP4 8
CNSTI1 0
ASGNI1
line 682
;682:	Info_SetValueForKey( info, "hostname", "No Response" );
ADDRLP4 8
ARGP4
ADDRGP4 $375
ARGP4
ADDRGP4 $392
ARGP4
ADDRGP4 Info_SetValueForKey
CALLV
pop
line 683
;683:	for (i=0; i<g_arenaservers.numfavoriteaddresses; i++)
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $396
JUMPV
LABELV $393
line 684
;684:	{
line 686
;685:		// find favorite address in refresh list
;686:		for (j=0; j<g_numfavoriteservers; j++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $401
JUMPV
LABELV $398
line 687
;687:			if (!Q_stricmp(g_arenaservers.favoriteaddresses[i],g_favoriteserverlist[j].adrstr))
ADDRLP4 4
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 g_arenaservers+13832
ADDP4
ARGP4
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_favoriteserverlist
ADDP4
ARGP4
ADDRLP4 1032
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
NEI4 $402
line 688
;688:				break;
ADDRGP4 $400
JUMPV
LABELV $402
LABELV $399
line 686
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $401
ADDRLP4 0
INDIRI4
ADDRGP4 g_numfavoriteservers
INDIRI4
LTI4 $398
LABELV $400
line 690
;689:
;690:		if ( j >= g_numfavoriteservers)
ADDRLP4 0
INDIRI4
ADDRGP4 g_numfavoriteservers
INDIRI4
LTI4 $405
line 691
;691:		{
line 693
;692:			// not in list, add it
;693:			ArenaServers_Insert( g_arenaservers.favoriteaddresses[i], info, ArenaServers_MaxPing() );
ADDRLP4 1036
ADDRGP4 ArenaServers_MaxPing
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 g_arenaservers+13832
ADDP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRGP4 ArenaServers_Insert
CALLV
pop
line 694
;694:		}
LABELV $405
line 695
;695:	}
LABELV $394
line 683
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $396
ADDRLP4 4
INDIRI4
ADDRGP4 g_arenaservers+14856
INDIRI4
LTI4 $393
line 696
;696:}
LABELV $391
endproc ArenaServers_InsertFavorites 1040 12
export ArenaServers_LoadFavorites
proc ArenaServers_LoadFavorites 3552 12
line 707
;697:
;698:
;699:/*
;700:=================
;701:ArenaServers_LoadFavorites
;702:
;703:Load cvar address book entries into local lists.
;704:=================
;705:*/
;706:void ArenaServers_LoadFavorites( void )
;707:{
line 716
;708:	int				i;
;709:	int				j;
;710:	int				numtempitems;
;711:	char			emptyinfo[MAX_INFO_STRING];
;712:	char			adrstr[MAX_ADDRESSLENGTH];
;713:	servernode_t	templist[MAX_FAVORITESERVERS];
;714:	qboolean		found;
;715:
;716:	found        = qfalse;
ADDRLP4 2508
CNSTI4 0
ASGNI4
line 717
;717:	emptyinfo[0] = '\0';
ADDRLP4 2512
CNSTI1 0
ASGNI1
line 720
;718:
;719:	// copy the old
;720:	memcpy( templist, g_favoriteserverlist, sizeof(servernode_t)*MAX_FAVORITESERVERS );
ADDRLP4 72
ARGP4
ADDRGP4 g_favoriteserverlist
ARGP4
CNSTI4 2432
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 721
;721:	numtempitems = g_numfavoriteservers;
ADDRLP4 68
ADDRGP4 g_numfavoriteservers
INDIRI4
ASGNI4
line 724
;722:
;723:	// clear the current for sync
;724:	memset( g_favoriteserverlist, 0, sizeof(servernode_t)*MAX_FAVORITESERVERS );
ADDRGP4 g_favoriteserverlist
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2432
ARGI4
ADDRGP4 memset
CALLP4
pop
line 725
;725:	g_numfavoriteservers = 0;
ADDRGP4 g_numfavoriteservers
CNSTI4 0
ASGNI4
line 728
;726:
;727:	// resync existing results with new or deleted cvars
;728:	for (i=0; i<MAX_FAVORITESERVERS; i++)
ADDRLP4 2504
CNSTI4 0
ASGNI4
LABELV $409
line 729
;729:	{
line 730
;730:		trap_Cvar_VariableStringBuffer( va("server%d",i+1), adrstr, MAX_ADDRESSLENGTH );
ADDRGP4 $413
ARGP4
ADDRLP4 2504
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 3536
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 3536
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 731
;731:		if (!adrstr[0])
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $414
line 732
;732:			continue;
ADDRGP4 $410
JUMPV
LABELV $414
line 736
;733:
;734:		// quick sanity check to avoid slow domain name resolving
;735:		// first character must be numeric
;736:		if (adrstr[0] < '0' || adrstr[0] > '9')
ADDRLP4 3540
ADDRLP4 4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 3540
INDIRI4
CNSTI4 48
LTI4 $418
ADDRLP4 3540
INDIRI4
CNSTI4 57
LEI4 $416
LABELV $418
line 737
;737:			continue;
ADDRGP4 $410
JUMPV
LABELV $416
line 742
;738:
;739:		// favorite server addresses must be maintained outside refresh list
;740:		// this mimics local and global netadr's stored in client
;741:		// these can be fetched to fill ping list
;742:		strcpy( g_arenaservers.favoriteaddresses[g_numfavoriteservers], adrstr );
ADDRGP4 g_numfavoriteservers
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 g_arenaservers+13832
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 745
;743:
;744:		// find this server in the old list
;745:		for (j=0; j<numtempitems; j++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $423
JUMPV
LABELV $420
line 746
;746:			if (!Q_stricmp( templist[j].adrstr, adrstr ))
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 72
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 3544
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 3544
INDIRI4
CNSTI4 0
NEI4 $424
line 747
;747:				break;
ADDRGP4 $422
JUMPV
LABELV $424
LABELV $421
line 745
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $423
ADDRLP4 0
INDIRI4
ADDRLP4 68
INDIRI4
LTI4 $420
LABELV $422
line 749
;748:
;749:		if (j < numtempitems)
ADDRLP4 0
INDIRI4
ADDRLP4 68
INDIRI4
GEI4 $426
line 750
;750:		{
line 752
;751:			// found server - add exisiting results
;752:			memcpy( &g_favoriteserverlist[g_numfavoriteservers], &templist[j], sizeof(servernode_t) );
ADDRLP4 3548
CNSTI4 152
ASGNI4
ADDRLP4 3548
INDIRI4
ADDRGP4 g_numfavoriteservers
INDIRI4
MULI4
ADDRGP4 g_favoriteserverlist
ADDP4
ARGP4
ADDRLP4 3548
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 72
ADDP4
ARGP4
ADDRLP4 3548
INDIRI4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 753
;753:			found = qtrue;
ADDRLP4 2508
CNSTI4 1
ASGNI4
line 754
;754:		}
ADDRGP4 $427
JUMPV
LABELV $426
line 756
;755:		else
;756:		{
line 758
;757:			// add new server
;758:			Q_strncpyz( g_favoriteserverlist[g_numfavoriteservers].adrstr, adrstr, MAX_ADDRESSLENGTH );
CNSTI4 152
ADDRGP4 g_numfavoriteservers
INDIRI4
MULI4
ADDRGP4 g_favoriteserverlist
ADDP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 759
;759:			g_favoriteserverlist[g_numfavoriteservers].pingtime = ArenaServers_MaxPing();
ADDRLP4 3548
ADDRGP4 ArenaServers_MaxPing
CALLI4
ASGNI4
CNSTI4 152
ADDRGP4 g_numfavoriteservers
INDIRI4
MULI4
ADDRGP4 g_favoriteserverlist+116
ADDP4
ADDRLP4 3548
INDIRI4
ASGNI4
line 760
;760:		}
LABELV $427
line 762
;761:
;762:		g_numfavoriteservers++;
ADDRLP4 3548
ADDRGP4 g_numfavoriteservers
ASGNP4
ADDRLP4 3548
INDIRP4
ADDRLP4 3548
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 763
;763:	}
LABELV $410
line 728
ADDRLP4 2504
ADDRLP4 2504
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 2504
INDIRI4
CNSTI4 16
LTI4 $409
line 765
;764:
;765:	g_arenaservers.numfavoriteaddresses = g_numfavoriteservers;
ADDRGP4 g_arenaservers+14856
ADDRGP4 g_numfavoriteservers
INDIRI4
ASGNI4
line 767
;766:
;767:	if (!found)
ADDRLP4 2508
INDIRI4
CNSTI4 0
NEI4 $430
line 768
;768:	{
line 771
;769:		// no results were found, reset server list
;770:		// list will be automatically refreshed when selected
;771:		g_numfavoriteservers = 0;
ADDRGP4 g_numfavoriteservers
CNSTI4 0
ASGNI4
line 772
;772:	}
LABELV $430
line 773
;773:}
LABELV $408
endproc ArenaServers_LoadFavorites 3552 12
proc ArenaServers_StopRefresh 0 16
line 782
;774:
;775:
;776:/*
;777:=================
;778:ArenaServers_StopRefresh
;779:=================
;780:*/
;781:static void ArenaServers_StopRefresh( void )
;782:{
line 783
;783:	if (!g_arenaservers.refreshservers)
ADDRGP4 g_arenaservers+13816
INDIRI4
CNSTI4 0
NEI4 $433
line 785
;784:		// not currently refreshing
;785:		return;
ADDRGP4 $432
JUMPV
LABELV $433
line 787
;786:
;787:	g_arenaservers.refreshservers = qfalse;
ADDRGP4 g_arenaservers+13816
CNSTI4 0
ASGNI4
line 789
;788:
;789:	if (g_servertype == AS_FAVORITES)
ADDRGP4 g_servertype
INDIRI4
CNSTI4 3
NEI4 $437
line 790
;790:	{
line 792
;791:		// nonresponsive favorites must be shown
;792:		ArenaServers_InsertFavorites();
ADDRGP4 ArenaServers_InsertFavorites
CALLV
pop
line 793
;793:	}
LABELV $437
line 796
;794:
;795:	// final tally
;796:	if (g_arenaservers.numqueriedservers >= 0)
ADDRGP4 g_arenaservers+13800
INDIRI4
CNSTI4 0
LTI4 $439
line 797
;797:	{
line 798
;798:		g_arenaservers.currentping       = *g_arenaservers.numservers;
ADDRGP4 g_arenaservers+13812
ADDRGP4 g_arenaservers+13804
INDIRP4
INDIRI4
ASGNI4
line 799
;799:		g_arenaservers.numqueriedservers = *g_arenaservers.numservers; 
ADDRGP4 g_arenaservers+13800
ADDRGP4 g_arenaservers+13804
INDIRP4
INDIRI4
ASGNI4
line 800
;800:	}
LABELV $439
line 803
;801:	
;802:	// sort
;803:	qsort( g_arenaservers.serverlist, *g_arenaservers.numservers, sizeof( servernode_t ), ArenaServers_Compare);
ADDRGP4 g_arenaservers+13808
INDIRP4
ARGP4
ADDRGP4 g_arenaservers+13804
INDIRP4
INDIRI4
ARGI4
CNSTI4 152
ARGI4
ADDRGP4 ArenaServers_Compare
ARGP4
ADDRGP4 qsort
CALLV
pop
line 805
;804:
;805:	ArenaServers_UpdateMenu();
ADDRGP4 ArenaServers_UpdateMenu
CALLV
pop
line 806
;806:}
LABELV $432
endproc ArenaServers_StopRefresh 0 16
proc ArenaServers_DoRefresh 1120 16
line 815
;807:
;808:
;809:/*
;810:=================
;811:ArenaServers_DoRefresh
;812:=================
;813:*/
;814:static void ArenaServers_DoRefresh( void )
;815:{
line 823
;816:	int		i;
;817:	int		j;
;818:	int		time;
;819:	int		maxPing;
;820:	char	adrstr[MAX_ADDRESSLENGTH];
;821:	char	info[MAX_INFO_STRING];
;822:
;823:	if (uis.realtime < g_arenaservers.refreshtime)
ADDRGP4 uis+4
INDIRI4
ADDRGP4 g_arenaservers+13828
INDIRI4
GEI4 $449
line 824
;824:	{
line 825
;825:	  if (g_servertype != AS_FAVORITES) {
ADDRGP4 g_servertype
INDIRI4
CNSTI4 3
EQI4 $453
line 826
;826:			if (g_servertype == AS_LOCAL) {
ADDRGP4 g_servertype
INDIRI4
CNSTI4 0
NEI4 $455
line 827
;827:				if (!trap_LAN_GetServerCount(g_servertype)) {
ADDRGP4 g_servertype
INDIRI4
ARGI4
ADDRLP4 1104
ADDRGP4 trap_LAN_GetServerCount
CALLI4
ASGNI4
ADDRLP4 1104
INDIRI4
CNSTI4 0
NEI4 $457
line 828
;828:					return;
ADDRGP4 $448
JUMPV
LABELV $457
line 830
;829:				}
;830:			}
LABELV $455
line 831
;831:			if (trap_LAN_GetServerCount(g_servertype) < 0) {
ADDRGP4 g_servertype
INDIRI4
ARGI4
ADDRLP4 1104
ADDRGP4 trap_LAN_GetServerCount
CALLI4
ASGNI4
ADDRLP4 1104
INDIRI4
CNSTI4 0
GEI4 $459
line 833
;832:			  // still waiting for response
;833:			  return;
ADDRGP4 $448
JUMPV
LABELV $459
line 835
;834:			}
;835:	  }
LABELV $453
line 836
;836:	}
LABELV $449
line 838
;837:
;838:	if (uis.realtime < g_arenaservers.nextpingtime)
ADDRGP4 uis+4
INDIRI4
ADDRGP4 g_arenaservers+13820
INDIRI4
GEI4 $461
line 839
;839:	{
line 841
;840:		// wait for time trigger
;841:		return;
ADDRGP4 $448
JUMPV
LABELV $461
line 845
;842:	}
;843:
;844:	// trigger at 10Hz intervals
;845:	g_arenaservers.nextpingtime = uis.realtime + 10;
ADDRGP4 g_arenaservers+13820
ADDRGP4 uis+4
INDIRI4
CNSTI4 10
ADDI4
ASGNI4
line 848
;846:
;847:	// process ping results
;848:	maxPing = ArenaServers_MaxPing();
ADDRLP4 1104
ADDRGP4 ArenaServers_MaxPing
CALLI4
ASGNI4
ADDRLP4 76
ADDRLP4 1104
INDIRI4
ASGNI4
line 849
;849:	for (i=0; i<MAX_PINGREQUESTS; i++)
ADDRLP4 68
CNSTI4 0
ASGNI4
LABELV $467
line 850
;850:	{
line 851
;851:		trap_LAN_GetPing( i, adrstr, MAX_ADDRESSLENGTH, &time );
ADDRLP4 68
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 72
ARGP4
ADDRGP4 trap_LAN_GetPing
CALLV
pop
line 852
;852:		if (!adrstr[0])
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $471
line 853
;853:		{
line 855
;854:			// ignore empty or pending pings
;855:			continue;
ADDRGP4 $468
JUMPV
LABELV $471
line 859
;856:		}
;857:
;858:		// find ping result in our local list
;859:		for (j=0; j<MAX_PINGREQUESTS; j++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $473
line 860
;860:			if (!Q_stricmp( adrstr, g_arenaservers.pinglist[j].adrstr ))
ADDRLP4 4
ARGP4
CNSTI4 68
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_arenaservers+1896
ADDP4
ARGP4
ADDRLP4 1108
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1108
INDIRI4
CNSTI4 0
NEI4 $477
line 861
;861:				break;
ADDRGP4 $475
JUMPV
LABELV $477
LABELV $474
line 859
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $473
LABELV $475
line 863
;862:
;863:		if (j < MAX_PINGREQUESTS)
ADDRLP4 0
INDIRI4
CNSTI4 32
GEI4 $480
line 864
;864:		{
line 866
;865:			// found it
;866:			if (!time)
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $482
line 867
;867:			{
line 868
;868:				time = uis.realtime - g_arenaservers.pinglist[j].start;
ADDRLP4 72
ADDRGP4 uis+4
INDIRI4
CNSTI4 68
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_arenaservers+1896+64
ADDP4
INDIRI4
SUBI4
ASGNI4
line 869
;869:				if (time < maxPing)
ADDRLP4 72
INDIRI4
ADDRLP4 76
INDIRI4
GEI4 $487
line 870
;870:				{
line 872
;871:					// still waiting
;872:					continue;
ADDRGP4 $468
JUMPV
LABELV $487
line 874
;873:				}
;874:			}
LABELV $482
line 876
;875:
;876:			if (time > maxPing)
ADDRLP4 72
INDIRI4
ADDRLP4 76
INDIRI4
LEI4 $489
line 877
;877:			{
line 879
;878:				// stale it out
;879:				info[0] = '\0';
ADDRLP4 80
CNSTI1 0
ASGNI1
line 880
;880:				time    = maxPing;
ADDRLP4 72
ADDRLP4 76
INDIRI4
ASGNI4
line 881
;881:			}
ADDRGP4 $490
JUMPV
LABELV $489
line 883
;882:			else
;883:			{
line 884
;884:				trap_LAN_GetPingInfo( i, info, MAX_INFO_STRING );
ADDRLP4 68
INDIRI4
ARGI4
ADDRLP4 80
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_LAN_GetPingInfo
CALLV
pop
line 885
;885:			}
LABELV $490
line 888
;886:
;887:			// insert ping results
;888:			ArenaServers_Insert( adrstr, info, time );
ADDRLP4 4
ARGP4
ADDRLP4 80
ARGP4
ADDRLP4 72
INDIRI4
ARGI4
ADDRGP4 ArenaServers_Insert
CALLV
pop
line 891
;889:
;890:			// clear this query from internal list
;891:			g_arenaservers.pinglist[j].adrstr[0] = '\0';
CNSTI4 68
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_arenaservers+1896
ADDP4
CNSTI1 0
ASGNI1
line 892
;892:   		}
LABELV $480
line 895
;893:
;894:		// clear this query from external list
;895:		trap_LAN_ClearPing( i );
ADDRLP4 68
INDIRI4
ARGI4
ADDRGP4 trap_LAN_ClearPing
CALLV
pop
line 896
;896:	}
LABELV $468
line 849
ADDRLP4 68
ADDRLP4 68
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 32
LTI4 $467
line 900
;897:
;898:	// get results of servers query
;899:	// counts can increase as servers respond
;900:	if (g_servertype == AS_FAVORITES) {
ADDRGP4 g_servertype
INDIRI4
CNSTI4 3
NEI4 $492
line 901
;901:	  g_arenaservers.numqueriedservers = g_arenaservers.numfavoriteaddresses;
ADDRGP4 g_arenaservers+13800
ADDRGP4 g_arenaservers+14856
INDIRI4
ASGNI4
line 902
;902:	} else {
ADDRGP4 $493
JUMPV
LABELV $492
line 903
;903:	  g_arenaservers.numqueriedservers = trap_LAN_GetServerCount(g_servertype);
ADDRGP4 g_servertype
INDIRI4
ARGI4
ADDRLP4 1108
ADDRGP4 trap_LAN_GetServerCount
CALLI4
ASGNI4
ADDRGP4 g_arenaservers+13800
ADDRLP4 1108
INDIRI4
ASGNI4
line 904
;904:	}
LABELV $493
line 911
;905:
;906://	if (g_arenaservers.numqueriedservers > g_arenaservers.maxservers)
;907://		g_arenaservers.numqueriedservers = g_arenaservers.maxservers;
;908:
;909:	// send ping requests in reasonable bursts
;910:	// iterate ping through all found servers
;911:	for (i=0; i<MAX_PINGREQUESTS && g_arenaservers.currentping < g_arenaservers.numqueriedservers; i++)
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRGP4 $500
JUMPV
LABELV $497
line 912
;912:	{
line 913
;913:		if (trap_LAN_GetPingQueueCount() >= MAX_PINGREQUESTS)
ADDRLP4 1108
ADDRGP4 trap_LAN_GetPingQueueCount
CALLI4
ASGNI4
ADDRLP4 1108
INDIRI4
CNSTI4 32
LTI4 $503
line 914
;914:		{
line 916
;915:			// ping queue is full
;916:			break;
ADDRGP4 $499
JUMPV
LABELV $503
line 920
;917:		}
;918:
;919:		// find empty slot
;920:		for (j=0; j<MAX_PINGREQUESTS; j++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $505
line 921
;921:			if (!g_arenaservers.pinglist[j].adrstr[0])
CNSTI4 68
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_arenaservers+1896
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $509
line 922
;922:				break;
ADDRGP4 $507
JUMPV
LABELV $509
LABELV $506
line 920
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $505
LABELV $507
line 924
;923:
;924:		if (j >= MAX_PINGREQUESTS)
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $512
line 926
;925:			// no empty slots available yet - wait for timeout
;926:			break;
ADDRGP4 $499
JUMPV
LABELV $512
line 930
;927:
;928:		// get an address to ping
;929:
;930:		if (g_servertype == AS_FAVORITES) {
ADDRGP4 g_servertype
INDIRI4
CNSTI4 3
NEI4 $514
line 931
;931:		  strcpy( adrstr, g_arenaservers.favoriteaddresses[g_arenaservers.currentping] ); 		
ADDRLP4 4
ARGP4
ADDRGP4 g_arenaservers+13812
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 g_arenaservers+13832
ADDP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 932
;932:		} else {
ADDRGP4 $515
JUMPV
LABELV $514
line 933
;933:		  trap_LAN_GetServerAddressString(g_servertype, g_arenaservers.currentping, adrstr, MAX_ADDRESSLENGTH );
ADDRGP4 g_servertype
INDIRI4
ARGI4
ADDRGP4 g_arenaservers+13812
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_LAN_GetServerAddressString
CALLV
pop
line 934
;934:		}
LABELV $515
line 936
;935:
;936:		strcpy( g_arenaservers.pinglist[j].adrstr, adrstr );
CNSTI4 68
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_arenaservers+1896
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 937
;937:		g_arenaservers.pinglist[j].start = uis.realtime;
CNSTI4 68
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_arenaservers+1896+64
ADDP4
ADDRGP4 uis+4
INDIRI4
ASGNI4
line 939
;938:
;939:		trap_Cmd_ExecuteText( EXEC_NOW, va( "ping %s\n", adrstr )  );
ADDRGP4 $523
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1112
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 0
ARGI4
ADDRLP4 1112
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 942
;940:		
;941:		// advance to next server
;942:		g_arenaservers.currentping++;
ADDRLP4 1116
ADDRGP4 g_arenaservers+13812
ASGNP4
ADDRLP4 1116
INDIRP4
ADDRLP4 1116
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 943
;943:	}
LABELV $498
line 911
ADDRLP4 68
ADDRLP4 68
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $500
ADDRLP4 68
INDIRI4
CNSTI4 32
GEI4 $525
ADDRGP4 g_arenaservers+13812
INDIRI4
ADDRGP4 g_arenaservers+13800
INDIRI4
LTI4 $497
LABELV $525
LABELV $499
line 945
;944:
;945:	if (!trap_LAN_GetPingQueueCount())
ADDRLP4 1108
ADDRGP4 trap_LAN_GetPingQueueCount
CALLI4
ASGNI4
ADDRLP4 1108
INDIRI4
CNSTI4 0
NEI4 $526
line 946
;946:	{
line 948
;947:		// all pings completed
;948:		ArenaServers_StopRefresh();
ADDRGP4 ArenaServers_StopRefresh
CALLV
pop
line 949
;949:		return;
ADDRGP4 $448
JUMPV
LABELV $526
line 953
;950:	}
;951:
;952:	// update the user interface with ping status
;953:	ArenaServers_UpdateMenu();
ADDRGP4 ArenaServers_UpdateMenu
CALLV
pop
line 954
;954:}
LABELV $448
endproc ArenaServers_DoRefresh 1120 16
proc ArenaServers_StartRefresh 88 16
line 963
;955:
;956:
;957:/*
;958:=================
;959:ArenaServers_StartRefresh
;960:=================
;961:*/
;962:static void ArenaServers_StartRefresh( void )
;963:{
line 967
;964:	int		i;
;965:	char	myargs[32], protocol[32];
;966:
;967:	memset( g_arenaservers.serverlist, 0, g_arenaservers.maxservers*sizeof(table_t) );
ADDRGP4 g_arenaservers+13808
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTU4 72
ADDRGP4 g_arenaservers+13824
INDIRI4
CVIU4 4
MULU4
CVUI4 4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 969
;968:
;969:	for (i=0; i<MAX_PINGREQUESTS; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $531
line 970
;970:	{
line 971
;971:		g_arenaservers.pinglist[i].adrstr[0] = '\0';
CNSTI4 68
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_arenaservers+1896
ADDP4
CNSTI1 0
ASGNI1
line 972
;972:		trap_LAN_ClearPing( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 trap_LAN_ClearPing
CALLV
pop
line 973
;973:	}
LABELV $532
line 969
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $531
line 975
;974:
;975:	g_arenaservers.refreshservers    = qtrue;
ADDRGP4 g_arenaservers+13816
CNSTI4 1
ASGNI4
line 976
;976:	g_arenaservers.currentping       = 0;
ADDRGP4 g_arenaservers+13812
CNSTI4 0
ASGNI4
line 977
;977:	g_arenaservers.nextpingtime      = 0;
ADDRGP4 g_arenaservers+13820
CNSTI4 0
ASGNI4
line 978
;978:	*g_arenaservers.numservers       = 0;
ADDRGP4 g_arenaservers+13804
INDIRP4
CNSTI4 0
ASGNI4
line 979
;979:	g_arenaservers.numqueriedservers = 0;
ADDRGP4 g_arenaservers+13800
CNSTI4 0
ASGNI4
line 982
;980:
;981:	// allow max 5 seconds for responses
;982:	g_arenaservers.refreshtime = uis.realtime + 5000;
ADDRGP4 g_arenaservers+13828
ADDRGP4 uis+4
INDIRI4
CNSTI4 5000
ADDI4
ASGNI4
line 985
;983:
;984:	// place menu in zeroed state
;985:	ArenaServers_UpdateMenu();
ADDRGP4 ArenaServers_UpdateMenu
CALLV
pop
line 987
;986:
;987:	if( g_servertype == AS_LOCAL ) {
ADDRGP4 g_servertype
INDIRI4
CNSTI4 0
NEI4 $543
line 988
;988:		trap_Cmd_ExecuteText( EXEC_APPEND, "localservers\n" );
CNSTI4 2
ARGI4
ADDRGP4 $545
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 989
;989:		return;
ADDRGP4 $528
JUMPV
LABELV $543
line 992
;990:	}
;991:
;992:	if( g_servertype == AS_GLOBAL || g_servertype == AS_MPLAYER ) {
ADDRLP4 68
ADDRGP4 g_servertype
INDIRI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 2
EQI4 $548
ADDRLP4 68
INDIRI4
CNSTI4 1
NEI4 $546
LABELV $548
line 993
;993:		if( g_servertype == AS_GLOBAL ) {
ADDRGP4 g_servertype
INDIRI4
CNSTI4 2
NEI4 $549
line 994
;994:			i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 995
;995:		}
ADDRGP4 $550
JUMPV
LABELV $549
line 996
;996:		else {
line 997
;997:			i = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 998
;998:		}
LABELV $550
line 1000
;999:
;1000:		switch( g_arenaservers.gametype.curvalue ) {
ADDRLP4 72
ADDRGP4 g_arenaservers+456+64
INDIRI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
LTI4 $551
ADDRLP4 72
INDIRI4
CNSTI4 4
GTI4 $551
ADDRLP4 72
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $564
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $564
address $555
address $556
address $558
address $560
address $562
code
LABELV $551
LABELV $555
line 1003
;1001:		default:
;1002:		case GAMES_ALL:
;1003:			myargs[0] = 0;
ADDRLP4 36
CNSTI1 0
ASGNI1
line 1004
;1004:			break;
ADDRGP4 $552
JUMPV
LABELV $556
line 1007
;1005:
;1006:		case GAMES_FFA:
;1007:			strcpy( myargs, " ffa" );
ADDRLP4 36
ARGP4
ADDRGP4 $557
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1008
;1008:			break;
ADDRGP4 $552
JUMPV
LABELV $558
line 1011
;1009:
;1010:		case GAMES_TEAMPLAY:
;1011:			strcpy( myargs, " team" );
ADDRLP4 36
ARGP4
ADDRGP4 $559
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1012
;1012:			break;
ADDRGP4 $552
JUMPV
LABELV $560
line 1015
;1013:
;1014:		case GAMES_TOURNEY:
;1015:			strcpy( myargs, " tourney" );
ADDRLP4 36
ARGP4
ADDRGP4 $561
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1016
;1016:			break;
ADDRGP4 $552
JUMPV
LABELV $562
line 1019
;1017:
;1018:		case GAMES_CTF:
;1019:			strcpy( myargs, " ctf" );
ADDRLP4 36
ARGP4
ADDRGP4 $563
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1020
;1020:			break;
LABELV $552
line 1024
;1021:		}
;1022:
;1023:
;1024:		if (g_emptyservers) {
ADDRGP4 g_emptyservers
INDIRI4
CNSTI4 0
EQI4 $565
line 1025
;1025:			strcat(myargs, " empty");
ADDRLP4 36
ARGP4
ADDRGP4 $567
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 1026
;1026:		}
LABELV $565
line 1028
;1027:
;1028:		if (g_fullservers) {
ADDRGP4 g_fullservers
INDIRI4
CNSTI4 0
EQI4 $568
line 1029
;1029:			strcat(myargs, " full");
ADDRLP4 36
ARGP4
ADDRGP4 $570
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 1030
;1030:		}
LABELV $568
line 1032
;1031:
;1032:		protocol[0] = '\0';
ADDRLP4 4
CNSTI1 0
ASGNI1
line 1033
;1033:		trap_Cvar_VariableStringBuffer( "debug_protocol", protocol, sizeof(protocol) );
ADDRGP4 $571
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1034
;1034:		if (strlen(protocol)) {
ADDRLP4 4
ARGP4
ADDRLP4 76
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
EQI4 $572
line 1035
;1035:			trap_Cmd_ExecuteText( EXEC_APPEND, va( "globalservers %d %s%s\n", i, protocol, myargs ));
ADDRGP4 $574
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 80
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 80
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 1036
;1036:		}
ADDRGP4 $573
JUMPV
LABELV $572
line 1037
;1037:		else {
line 1038
;1038:			trap_Cmd_ExecuteText( EXEC_APPEND, va( "globalservers %d %d%s\n", i, (int)trap_Cvar_VariableValue( "protocol" ), myargs ) );
ADDRGP4 $576
ARGP4
ADDRLP4 80
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRGP4 $575
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 80
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 36
ARGP4
ADDRLP4 84
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 84
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 1039
;1039:		}
LABELV $573
line 1040
;1040:	}
LABELV $546
line 1041
;1041:}
LABELV $528
endproc ArenaServers_StartRefresh 88 16
export ArenaServers_SaveChanges
proc ArenaServers_SaveChanges 12 8
line 1050
;1042:
;1043:
;1044:/*
;1045:=================
;1046:ArenaServers_SaveChanges
;1047:=================
;1048:*/
;1049:void ArenaServers_SaveChanges( void )
;1050:{
line 1053
;1051:	int	i;
;1052:
;1053:	for (i=0; i<g_arenaservers.numfavoriteaddresses; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $581
JUMPV
LABELV $578
line 1054
;1054:		trap_Cvar_Set( va("server%d",i+1), g_arenaservers.favoriteaddresses[i] );
ADDRGP4 $413
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 g_arenaservers+13832
ADDP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
LABELV $579
line 1053
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $581
ADDRLP4 0
INDIRI4
ADDRGP4 g_arenaservers+14856
INDIRI4
LTI4 $578
line 1056
;1055:
;1056:	for (; i<MAX_FAVORITESERVERS; i++)
ADDRGP4 $587
JUMPV
LABELV $584
line 1057
;1057:		trap_Cvar_Set( va("server%d",i+1), "" );
ADDRGP4 $413
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $203
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
LABELV $585
line 1056
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $587
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $584
line 1058
;1058:}
LABELV $577
endproc ArenaServers_SaveChanges 12 8
export ArenaServers_Sort
proc ArenaServers_Sort 0 16
line 1066
;1059:
;1060:
;1061:/*
;1062:=================
;1063:ArenaServers_Sort
;1064:=================
;1065:*/
;1066:void ArenaServers_Sort( int type ) {
line 1067
;1067:	if( g_sortkey == type ) {
ADDRGP4 g_sortkey
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $589
line 1068
;1068:		return;
ADDRGP4 $588
JUMPV
LABELV $589
line 1071
;1069:	}
;1070:
;1071:	g_sortkey = type;
ADDRGP4 g_sortkey
ADDRFP4 0
INDIRI4
ASGNI4
line 1072
;1072:	qsort( g_arenaservers.serverlist, *g_arenaservers.numservers, sizeof( servernode_t ), ArenaServers_Compare);
ADDRGP4 g_arenaservers+13808
INDIRP4
ARGP4
ADDRGP4 g_arenaservers+13804
INDIRP4
INDIRI4
ARGI4
CNSTI4 152
ARGI4
ADDRGP4 ArenaServers_Compare
ARGP4
ADDRGP4 qsort
CALLV
pop
line 1073
;1073:}
LABELV $588
endproc ArenaServers_Sort 0 16
export ArenaServers_SetType
proc ArenaServers_SetType 20 8
line 1082
;1074:
;1075:
;1076:/*
;1077:=================
;1078:ArenaServers_SetType
;1079:=================
;1080:*/
;1081:void ArenaServers_SetType( int type )
;1082:{
line 1083
;1083:	if (g_servertype == type)
ADDRGP4 g_servertype
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $594
line 1084
;1084:		return;
ADDRGP4 $593
JUMPV
LABELV $594
line 1086
;1085:
;1086:	g_servertype = type;
ADDRGP4 g_servertype
ADDRFP4 0
INDIRI4
ASGNI4
line 1088
;1087:
;1088:	switch( type ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $596
ADDRLP4 0
INDIRI4
CNSTI4 3
GTI4 $596
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $622
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $622
address $598
address $616
address $604
address $610
code
LABELV $596
LABELV $598
line 1091
;1089:	default:
;1090:	case AS_LOCAL:
;1091:		g_arenaservers.remove.generic.flags |= (QMF_INACTIVE|QMF_HIDDEN);
ADDRLP4 4
ADDRGP4 g_arenaservers+1368+44
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRU4
CNSTU4 20480
BORU4
ASGNU4
line 1092
;1092:		g_arenaservers.serverlist = g_localserverlist;
ADDRGP4 g_arenaservers+13808
ADDRGP4 g_localserverlist
ASGNP4
line 1093
;1093:		g_arenaservers.numservers = &g_numlocalservers;
ADDRGP4 g_arenaservers+13804
ADDRGP4 g_numlocalservers
ASGNP4
line 1094
;1094:		g_arenaservers.maxservers = MAX_LOCALSERVERS;
ADDRGP4 g_arenaservers+13824
CNSTI4 128
ASGNI4
line 1095
;1095:		break;
ADDRGP4 $597
JUMPV
LABELV $604
line 1098
;1096:
;1097:	case AS_GLOBAL:
;1098:		g_arenaservers.remove.generic.flags |= (QMF_INACTIVE|QMF_HIDDEN);
ADDRLP4 8
ADDRGP4 g_arenaservers+1368+44
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU4
CNSTU4 20480
BORU4
ASGNU4
line 1099
;1099:		g_arenaservers.serverlist = g_globalserverlist;
ADDRGP4 g_arenaservers+13808
ADDRGP4 g_globalserverlist
ASGNP4
line 1100
;1100:		g_arenaservers.numservers = &g_numglobalservers;
ADDRGP4 g_arenaservers+13804
ADDRGP4 g_numglobalservers
ASGNP4
line 1101
;1101:		g_arenaservers.maxservers = MAX_GLOBALSERVERS;
ADDRGP4 g_arenaservers+13824
CNSTI4 128
ASGNI4
line 1102
;1102:		break;
ADDRGP4 $597
JUMPV
LABELV $610
line 1105
;1103:
;1104:	case AS_FAVORITES:
;1105:		g_arenaservers.remove.generic.flags &= ~(QMF_INACTIVE|QMF_HIDDEN);
ADDRLP4 12
ADDRGP4 g_arenaservers+1368+44
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRU4
CNSTU4 4294946815
BANDU4
ASGNU4
line 1106
;1106:		g_arenaservers.serverlist = g_favoriteserverlist;
ADDRGP4 g_arenaservers+13808
ADDRGP4 g_favoriteserverlist
ASGNP4
line 1107
;1107:		g_arenaservers.numservers = &g_numfavoriteservers;
ADDRGP4 g_arenaservers+13804
ADDRGP4 g_numfavoriteservers
ASGNP4
line 1108
;1108:		g_arenaservers.maxservers = MAX_FAVORITESERVERS;
ADDRGP4 g_arenaservers+13824
CNSTI4 16
ASGNI4
line 1109
;1109:		break;
ADDRGP4 $597
JUMPV
LABELV $616
line 1112
;1110:
;1111:	case AS_MPLAYER:
;1112:		g_arenaservers.remove.generic.flags |= (QMF_INACTIVE|QMF_HIDDEN);
ADDRLP4 16
ADDRGP4 g_arenaservers+1368+44
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRU4
CNSTU4 20480
BORU4
ASGNU4
line 1113
;1113:		g_arenaservers.serverlist = g_mplayerserverlist;
ADDRGP4 g_arenaservers+13808
ADDRGP4 g_mplayerserverlist
ASGNP4
line 1114
;1114:		g_arenaservers.numservers = &g_nummplayerservers;
ADDRGP4 g_arenaservers+13804
ADDRGP4 g_nummplayerservers
ASGNP4
line 1115
;1115:		g_arenaservers.maxservers = MAX_GLOBALSERVERS;
ADDRGP4 g_arenaservers+13824
CNSTI4 128
ASGNI4
line 1116
;1116:		break;
LABELV $597
line 1120
;1117:		
;1118:	}
;1119:
;1120:	if( !*g_arenaservers.numservers ) {
ADDRGP4 g_arenaservers+13804
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $623
line 1121
;1121:		ArenaServers_StartRefresh();
ADDRGP4 ArenaServers_StartRefresh
CALLV
pop
line 1122
;1122:	}
ADDRGP4 $624
JUMPV
LABELV $623
line 1123
;1123:	else {
line 1125
;1124:		// avoid slow operation, use existing results
;1125:		g_arenaservers.currentping       = *g_arenaservers.numservers;
ADDRGP4 g_arenaservers+13812
ADDRGP4 g_arenaservers+13804
INDIRP4
INDIRI4
ASGNI4
line 1126
;1126:		g_arenaservers.numqueriedservers = *g_arenaservers.numservers; 
ADDRGP4 g_arenaservers+13800
ADDRGP4 g_arenaservers+13804
INDIRP4
INDIRI4
ASGNI4
line 1127
;1127:		ArenaServers_UpdateMenu();
ADDRGP4 ArenaServers_UpdateMenu
CALLV
pop
line 1128
;1128:	}
LABELV $624
line 1129
;1129:	strcpy(g_arenaservers.status.string,"hit refresh to update");
ADDRGP4 g_arenaservers+1224+60
INDIRP4
ARGP4
ADDRGP4 $632
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1130
;1130:}
LABELV $593
endproc ArenaServers_SetType 20 8
proc Punkbuster_ConfirmEnable 8 12
line 1137
;1131:
;1132:/*
;1133:=================
;1134:PunkBuster_Confirm
;1135:=================
;1136:*/
;1137:static void Punkbuster_ConfirmEnable( qboolean result ) {
line 1138
;1138:	if (result)
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $634
line 1139
;1139:	{		
line 1140
;1140:		trap_SetPbClStatus(1);
CNSTI4 1
ARGI4
ADDRGP4 trap_SetPbClStatus
CALLV
pop
line 1141
;1141:	}
LABELV $634
line 1142
;1142:	g_arenaservers.punkbuster.curvalue = Com_Clamp( 0, 1, trap_Cvar_VariableValue( "cl_punkbuster" ) );
ADDRGP4 $638
ARGP4
ADDRLP4 0
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 g_arenaservers+14860+64
ADDRLP4 4
INDIRF4
CVFI4 4
ASGNI4
line 1143
;1143:}
LABELV $633
endproc Punkbuster_ConfirmEnable 8 12
proc Punkbuster_ConfirmDisable 8 12
line 1145
;1144:
;1145:static void Punkbuster_ConfirmDisable( qboolean result ) {
line 1146
;1146:	if (result)
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $640
line 1147
;1147:	{
line 1148
;1148:		trap_SetPbClStatus(0);
CNSTI4 0
ARGI4
ADDRGP4 trap_SetPbClStatus
CALLV
pop
line 1149
;1149:		UI_Message( punkbuster_msg );
ADDRGP4 punkbuster_msg
ARGP4
ADDRGP4 UI_Message
CALLV
pop
line 1150
;1150:	}
LABELV $640
line 1151
;1151:	g_arenaservers.punkbuster.curvalue = Com_Clamp( 0, 1, trap_Cvar_VariableValue( "cl_punkbuster" ) );
ADDRGP4 $638
ARGP4
ADDRLP4 0
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 g_arenaservers+14860+64
ADDRLP4 4
INDIRF4
CVFI4 4
ASGNI4
line 1152
;1152:}
LABELV $639
endproc Punkbuster_ConfirmDisable 8 12
proc ArenaServers_Event 12 16
line 1159
;1153:
;1154:/*
;1155:=================
;1156:ArenaServers_Event
;1157:=================
;1158:*/
;1159:static void ArenaServers_Event( void* ptr, int event ) {
line 1163
;1160:	int		id;
;1161:	int value;
;1162:
;1163:	id = ((menucommon_s*)ptr)->id;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1165
;1164:
;1165:	if( event != QM_ACTIVATED && id != ID_LIST ) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $645
ADDRLP4 0
INDIRI4
CNSTI4 15
EQI4 $645
line 1166
;1166:		return;
ADDRGP4 $644
JUMPV
LABELV $645
line 1169
;1167:	}
;1168:
;1169:	switch( id ) {
ADDRLP4 0
INDIRI4
CNSTI4 10
LTI4 $647
ADDRLP4 0
INDIRI4
CNSTI4 24
GTI4 $647
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $699-40
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $699
address $649
address $655
address $661
address $667
address $673
address $679
address $682
address $684
address $686
address $687
address $688
address $689
address $690
address $691
address $692
code
LABELV $649
line 1171
;1170:	case ID_MASTER:
;1171:		value = g_arenaservers.master.curvalue;
ADDRLP4 4
ADDRGP4 g_arenaservers+360+64
INDIRI4
ASGNI4
line 1172
;1172:		if (value >= 1)
ADDRLP4 4
INDIRI4
CNSTI4 1
LTI4 $652
line 1173
;1173:		{
line 1174
;1174:			value++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1175
;1175:		}
LABELV $652
line 1176
;1176:		trap_Cvar_SetValue( "ui_browserMaster", value );
ADDRGP4 $654
ARGP4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1177
;1177:		ArenaServers_SetType( value );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 ArenaServers_SetType
CALLV
pop
line 1178
;1178:		break;
ADDRGP4 $648
JUMPV
LABELV $655
line 1181
;1179:
;1180:	case ID_GAMETYPE:
;1181:		trap_Cvar_SetValue( "ui_browserGameType", g_arenaservers.gametype.curvalue );
ADDRGP4 $656
ARGP4
ADDRGP4 g_arenaservers+456+64
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1182
;1182:		g_gametype = g_arenaservers.gametype.curvalue;
ADDRGP4 g_gametype
ADDRGP4 g_arenaservers+456+64
INDIRI4
ASGNI4
line 1183
;1183:		ArenaServers_UpdateMenu();
ADDRGP4 ArenaServers_UpdateMenu
CALLV
pop
line 1184
;1184:		break;
ADDRGP4 $648
JUMPV
LABELV $661
line 1187
;1185:
;1186:	case ID_SORTKEY:
;1187:		trap_Cvar_SetValue( "ui_browserSortKey", g_arenaservers.sortkey.curvalue );
ADDRGP4 $662
ARGP4
ADDRGP4 g_arenaservers+552+64
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1188
;1188:		ArenaServers_Sort( g_arenaservers.sortkey.curvalue );
ADDRGP4 g_arenaservers+552+64
INDIRI4
ARGI4
ADDRGP4 ArenaServers_Sort
CALLV
pop
line 1189
;1189:		ArenaServers_UpdateMenu();
ADDRGP4 ArenaServers_UpdateMenu
CALLV
pop
line 1190
;1190:		break;
ADDRGP4 $648
JUMPV
LABELV $667
line 1193
;1191:
;1192:	case ID_SHOW_FULL:
;1193:		trap_Cvar_SetValue( "ui_browserShowFull", g_arenaservers.showfull.curvalue );
ADDRGP4 $668
ARGP4
ADDRGP4 g_arenaservers+648+60
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1194
;1194:		g_fullservers = g_arenaservers.showfull.curvalue;
ADDRGP4 g_fullservers
ADDRGP4 g_arenaservers+648+60
INDIRI4
ASGNI4
line 1195
;1195:		ArenaServers_UpdateMenu();
ADDRGP4 ArenaServers_UpdateMenu
CALLV
pop
line 1196
;1196:		break;
ADDRGP4 $648
JUMPV
LABELV $673
line 1199
;1197:
;1198:	case ID_SHOW_EMPTY:
;1199:		trap_Cvar_SetValue( "ui_browserShowEmpty", g_arenaservers.showempty.curvalue );
ADDRGP4 $674
ARGP4
ADDRGP4 g_arenaservers+712+60
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 1200
;1200:		g_emptyservers = g_arenaservers.showempty.curvalue;
ADDRGP4 g_emptyservers
ADDRGP4 g_arenaservers+712+60
INDIRI4
ASGNI4
line 1201
;1201:		ArenaServers_UpdateMenu();
ADDRGP4 ArenaServers_UpdateMenu
CALLV
pop
line 1202
;1202:		break;
ADDRGP4 $648
JUMPV
LABELV $679
line 1205
;1203:
;1204:	case ID_LIST:
;1205:		if( event == QM_GOTFOCUS ) {
ADDRFP4 4
INDIRI4
CNSTI4 1
NEI4 $648
line 1206
;1206:			ArenaServers_UpdatePicture();
ADDRGP4 ArenaServers_UpdatePicture
CALLV
pop
line 1207
;1207:		}
line 1208
;1208:		break;
ADDRGP4 $648
JUMPV
LABELV $682
line 1211
;1209:
;1210:	case ID_SCROLL_UP:
;1211:		ScrollList_Key( &g_arenaservers.list, K_UPARROW );
ADDRGP4 g_arenaservers+776
ARGP4
CNSTI4 132
ARGI4
ADDRGP4 ScrollList_Key
CALLI4
pop
line 1212
;1212:		break;
ADDRGP4 $648
JUMPV
LABELV $684
line 1215
;1213:
;1214:	case ID_SCROLL_DOWN:
;1215:		ScrollList_Key( &g_arenaservers.list, K_DOWNARROW );
ADDRGP4 g_arenaservers+776
ARGP4
CNSTI4 133
ARGI4
ADDRGP4 ScrollList_Key
CALLI4
pop
line 1216
;1216:		break;
ADDRGP4 $648
JUMPV
LABELV $686
line 1219
;1217:
;1218:	case ID_BACK:
;1219:		ArenaServers_StopRefresh();
ADDRGP4 ArenaServers_StopRefresh
CALLV
pop
line 1220
;1220:		ArenaServers_SaveChanges();
ADDRGP4 ArenaServers_SaveChanges
CALLV
pop
line 1221
;1221:		UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 1222
;1222:		break;
ADDRGP4 $648
JUMPV
LABELV $687
line 1225
;1223:
;1224:	case ID_REFRESH:
;1225:		ArenaServers_StartRefresh();
ADDRGP4 ArenaServers_StartRefresh
CALLV
pop
line 1226
;1226:		break;
ADDRGP4 $648
JUMPV
LABELV $688
line 1229
;1227:
;1228:	case ID_SPECIFY:
;1229:		UI_SpecifyServerMenu();
ADDRGP4 UI_SpecifyServerMenu
CALLV
pop
line 1230
;1230:		break;
ADDRGP4 $648
JUMPV
LABELV $689
line 1233
;1231:
;1232:	case ID_CREATE:
;1233:		UI_StartServerMenu( qtrue );
CNSTI4 1
ARGI4
ADDRGP4 UI_StartServerMenu
CALLV
pop
line 1234
;1234:		break;
ADDRGP4 $648
JUMPV
LABELV $690
line 1237
;1235:
;1236:	case ID_CONNECT:
;1237:		ArenaServers_Go();
ADDRGP4 ArenaServers_Go
CALLV
pop
line 1238
;1238:		break;
ADDRGP4 $648
JUMPV
LABELV $691
line 1241
;1239:
;1240:	case ID_REMOVE:
;1241:		ArenaServers_Remove();
ADDRGP4 ArenaServers_Remove
CALLV
pop
line 1242
;1242:		ArenaServers_UpdateMenu();
ADDRGP4 ArenaServers_UpdateMenu
CALLV
pop
line 1243
;1243:		break;
ADDRGP4 $648
JUMPV
LABELV $692
line 1246
;1244:	
;1245:	case ID_PUNKBUSTER:
;1246:		if (g_arenaservers.punkbuster.curvalue)			
ADDRGP4 g_arenaservers+14860+64
INDIRI4
CNSTI4 0
EQI4 $693
line 1247
;1247:		{
line 1248
;1248:			UI_ConfirmMenu_Style( "Enable Punkbuster?",  UI_CENTER|UI_INVERSE|UI_SMALLFONT, (voidfunc_f)NULL, Punkbuster_ConfirmEnable );
ADDRGP4 $697
ARGP4
CNSTI4 8209
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 Punkbuster_ConfirmEnable
ARGP4
ADDRGP4 UI_ConfirmMenu_Style
CALLV
pop
line 1249
;1249:		}
ADDRGP4 $648
JUMPV
LABELV $693
line 1251
;1250:		else
;1251:		{
line 1252
;1252:			UI_ConfirmMenu_Style( "Disable Punkbuster?", UI_CENTER|UI_INVERSE|UI_SMALLFONT, (voidfunc_f)NULL, Punkbuster_ConfirmDisable );
ADDRGP4 $698
ARGP4
CNSTI4 8209
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 Punkbuster_ConfirmDisable
ARGP4
ADDRGP4 UI_ConfirmMenu_Style
CALLV
pop
line 1253
;1253:		}
line 1254
;1254:		break;
LABELV $647
LABELV $648
line 1256
;1255:	}
;1256:}
LABELV $644
endproc ArenaServers_Event 12 16
proc ArenaServers_MenuDraw 0 4
line 1265
;1257:
;1258:
;1259:/*
;1260:=================
;1261:ArenaServers_MenuDraw
;1262:=================
;1263:*/
;1264:static void ArenaServers_MenuDraw( void )
;1265:{
line 1266
;1266:	if (g_arenaservers.refreshservers)
ADDRGP4 g_arenaservers+13816
INDIRI4
CNSTI4 0
EQI4 $702
line 1267
;1267:		ArenaServers_DoRefresh();
ADDRGP4 ArenaServers_DoRefresh
CALLV
pop
LABELV $702
line 1269
;1268:
;1269:	Menu_Draw( &g_arenaservers.menu );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 Menu_Draw
CALLV
pop
line 1270
;1270:}
LABELV $701
endproc ArenaServers_MenuDraw 0 4
proc ArenaServers_MenuKey 16 8
line 1278
;1271:
;1272:
;1273:/*
;1274:=================
;1275:ArenaServers_MenuKey
;1276:=================
;1277:*/
;1278:static sfxHandle_t ArenaServers_MenuKey( int key ) {
line 1279
;1279:	if( key == K_SPACE  && g_arenaservers.refreshservers ) {
ADDRFP4 0
INDIRI4
CNSTI4 32
NEI4 $706
ADDRGP4 g_arenaservers+13816
INDIRI4
CNSTI4 0
EQI4 $706
line 1280
;1280:		ArenaServers_StopRefresh();	
ADDRGP4 ArenaServers_StopRefresh
CALLV
pop
line 1281
;1281:		return menu_move_sound;
ADDRGP4 menu_move_sound
INDIRI4
RETI4
ADDRGP4 $705
JUMPV
LABELV $706
line 1284
;1282:	}
;1283:
;1284:	if( ( key == K_DEL || key == K_KP_DEL ) && ( g_servertype == AS_FAVORITES ) &&
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 140
EQI4 $712
ADDRLP4 0
INDIRI4
CNSTI4 171
NEI4 $709
LABELV $712
ADDRGP4 g_servertype
INDIRI4
CNSTI4 3
NEI4 $709
ADDRGP4 g_arenaservers
ARGP4
ADDRLP4 4
ADDRGP4 Menu_ItemAtCursor
CALLP4
ASGNP4
ADDRGP4 g_arenaservers+776
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
NEU4 $709
line 1285
;1285:		( Menu_ItemAtCursor( &g_arenaservers.menu) == &g_arenaservers.list ) ) {
line 1286
;1286:		ArenaServers_Remove();
ADDRGP4 ArenaServers_Remove
CALLV
pop
line 1287
;1287:		ArenaServers_UpdateMenu();
ADDRGP4 ArenaServers_UpdateMenu
CALLV
pop
line 1288
;1288:		return menu_move_sound;
ADDRGP4 menu_move_sound
INDIRI4
RETI4
ADDRGP4 $705
JUMPV
LABELV $709
line 1291
;1289:	}
;1290:
;1291:	if( key == K_MOUSE2 || key == K_ESCAPE ) {
ADDRLP4 8
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 179
EQI4 $715
ADDRLP4 8
INDIRI4
CNSTI4 27
NEI4 $713
LABELV $715
line 1292
;1292:		ArenaServers_StopRefresh();
ADDRGP4 ArenaServers_StopRefresh
CALLV
pop
line 1293
;1293:		ArenaServers_SaveChanges();
ADDRGP4 ArenaServers_SaveChanges
CALLV
pop
line 1294
;1294:	}
LABELV $713
line 1297
;1295:
;1296:
;1297:	return Menu_DefaultKey( &g_arenaservers.menu, key );
ADDRGP4 g_arenaservers
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 Menu_DefaultKey
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
RETI4
LABELV $705
endproc ArenaServers_MenuKey 16 8
bss
align 1
LABELV $717
skip 64
code
proc ArenaServers_MenuInit 44 16
line 1306
;1298:}
;1299:
;1300:
;1301:/*
;1302:=================
;1303:ArenaServers_MenuInit
;1304:=================
;1305:*/
;1306:static void ArenaServers_MenuInit( void ) {
line 1314
;1307:	int			i;
;1308:	int			type;
;1309:	int			y;
;1310:	int			value;
;1311:	static char	statusbuffer[MAX_STATUSLENGTH];
;1312:
;1313:	// zero set all our globals
;1314:	memset( &g_arenaservers, 0 ,sizeof(arenaservers_t) );
ADDRGP4 g_arenaservers
ARGP4
CNSTI4 0
ARGI4
CNSTI4 15044
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1316
;1315:
;1316:	ArenaServers_Cache();
ADDRGP4 ArenaServers_Cache
CALLV
pop
line 1318
;1317:
;1318:	g_arenaservers.menu.fullscreen = qtrue;
ADDRGP4 g_arenaservers+280
CNSTI4 1
ASGNI4
line 1319
;1319:	g_arenaservers.menu.wrapAround = qtrue;
ADDRGP4 g_arenaservers+276
CNSTI4 1
ASGNI4
line 1320
;1320:	g_arenaservers.menu.draw       = ArenaServers_MenuDraw;
ADDRGP4 g_arenaservers+268
ADDRGP4 ArenaServers_MenuDraw
ASGNP4
line 1321
;1321:	g_arenaservers.menu.key        = ArenaServers_MenuKey;
ADDRGP4 g_arenaservers+272
ADDRGP4 ArenaServers_MenuKey
ASGNP4
line 1323
;1322:
;1323:	g_arenaservers.banner.generic.type  = MTYPE_BTEXT;
ADDRGP4 g_arenaservers+288
CNSTI4 10
ASGNI4
line 1324
;1324:	g_arenaservers.banner.generic.flags = QMF_CENTER_JUSTIFY;
ADDRGP4 g_arenaservers+288+44
CNSTU4 8
ASGNU4
line 1325
;1325:	g_arenaservers.banner.generic.x	    = 320;
ADDRGP4 g_arenaservers+288+12
CNSTI4 320
ASGNI4
line 1326
;1326:	g_arenaservers.banner.generic.y	    = 16;
ADDRGP4 g_arenaservers+288+16
CNSTI4 16
ASGNI4
line 1327
;1327:	g_arenaservers.banner.string  		= "ARENA SERVERS";
ADDRGP4 g_arenaservers+288+60
ADDRGP4 $731
ASGNP4
line 1328
;1328:	g_arenaservers.banner.style  	    = UI_CENTER;
ADDRGP4 g_arenaservers+288+64
CNSTI4 1
ASGNI4
line 1329
;1329:	g_arenaservers.banner.color  	    = color_white;
ADDRGP4 g_arenaservers+288+68
ADDRGP4 color_white
ASGNP4
line 1331
;1330:
;1331:	y = 80;
ADDRLP4 4
CNSTI4 80
ASGNI4
line 1332
;1332:	g_arenaservers.master.generic.type			= MTYPE_SPINCONTROL;
ADDRGP4 g_arenaservers+360
CNSTI4 3
ASGNI4
line 1333
;1333:	g_arenaservers.master.generic.name			= "Servers:";
ADDRGP4 g_arenaservers+360+4
ADDRGP4 $739
ASGNP4
line 1334
;1334:	g_arenaservers.master.generic.flags			= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 g_arenaservers+360+44
CNSTU4 258
ASGNU4
line 1335
;1335:	g_arenaservers.master.generic.callback		= ArenaServers_Event;
ADDRGP4 g_arenaservers+360+48
ADDRGP4 ArenaServers_Event
ASGNP4
line 1336
;1336:	g_arenaservers.master.generic.id			= ID_MASTER;
ADDRGP4 g_arenaservers+360+8
CNSTI4 10
ASGNI4
line 1337
;1337:	g_arenaservers.master.generic.x				= 320;
ADDRGP4 g_arenaservers+360+12
CNSTI4 320
ASGNI4
line 1338
;1338:	g_arenaservers.master.generic.y				= y;
ADDRGP4 g_arenaservers+360+16
ADDRLP4 4
INDIRI4
ASGNI4
line 1339
;1339:	g_arenaservers.master.itemnames				= master_items;
ADDRGP4 g_arenaservers+360+76
ADDRGP4 master_items
ASGNP4
line 1341
;1340:
;1341:	y += SMALLCHAR_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 1342
;1342:	g_arenaservers.gametype.generic.type		= MTYPE_SPINCONTROL;
ADDRGP4 g_arenaservers+456
CNSTI4 3
ASGNI4
line 1343
;1343:	g_arenaservers.gametype.generic.name		= "Game Type:";
ADDRGP4 g_arenaservers+456+4
ADDRGP4 $755
ASGNP4
line 1344
;1344:	g_arenaservers.gametype.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 g_arenaservers+456+44
CNSTU4 258
ASGNU4
line 1345
;1345:	g_arenaservers.gametype.generic.callback	= ArenaServers_Event;
ADDRGP4 g_arenaservers+456+48
ADDRGP4 ArenaServers_Event
ASGNP4
line 1346
;1346:	g_arenaservers.gametype.generic.id			= ID_GAMETYPE;
ADDRGP4 g_arenaservers+456+8
CNSTI4 11
ASGNI4
line 1347
;1347:	g_arenaservers.gametype.generic.x			= 320;
ADDRGP4 g_arenaservers+456+12
CNSTI4 320
ASGNI4
line 1348
;1348:	g_arenaservers.gametype.generic.y			= y;
ADDRGP4 g_arenaservers+456+16
ADDRLP4 4
INDIRI4
ASGNI4
line 1349
;1349:	g_arenaservers.gametype.itemnames			= servertype_items;
ADDRGP4 g_arenaservers+456+76
ADDRGP4 servertype_items
ASGNP4
line 1351
;1350:
;1351:	y += SMALLCHAR_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 1352
;1352:	g_arenaservers.sortkey.generic.type			= MTYPE_SPINCONTROL;
ADDRGP4 g_arenaservers+552
CNSTI4 3
ASGNI4
line 1353
;1353:	g_arenaservers.sortkey.generic.name			= "Sort By:";
ADDRGP4 g_arenaservers+552+4
ADDRGP4 $771
ASGNP4
line 1354
;1354:	g_arenaservers.sortkey.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 g_arenaservers+552+44
CNSTU4 258
ASGNU4
line 1355
;1355:	g_arenaservers.sortkey.generic.callback		= ArenaServers_Event;
ADDRGP4 g_arenaservers+552+48
ADDRGP4 ArenaServers_Event
ASGNP4
line 1356
;1356:	g_arenaservers.sortkey.generic.id			= ID_SORTKEY;
ADDRGP4 g_arenaservers+552+8
CNSTI4 12
ASGNI4
line 1357
;1357:	g_arenaservers.sortkey.generic.x			= 320;
ADDRGP4 g_arenaservers+552+12
CNSTI4 320
ASGNI4
line 1358
;1358:	g_arenaservers.sortkey.generic.y			= y;
ADDRGP4 g_arenaservers+552+16
ADDRLP4 4
INDIRI4
ASGNI4
line 1359
;1359:	g_arenaservers.sortkey.itemnames			= sortkey_items;
ADDRGP4 g_arenaservers+552+76
ADDRGP4 sortkey_items
ASGNP4
line 1361
;1360:
;1361:	y += SMALLCHAR_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 1362
;1362:	g_arenaservers.showfull.generic.type		= MTYPE_RADIOBUTTON;
ADDRGP4 g_arenaservers+648
CNSTI4 5
ASGNI4
line 1363
;1363:	g_arenaservers.showfull.generic.name		= "Show Full:";
ADDRGP4 g_arenaservers+648+4
ADDRGP4 $787
ASGNP4
line 1364
;1364:	g_arenaservers.showfull.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 g_arenaservers+648+44
CNSTU4 258
ASGNU4
line 1365
;1365:	g_arenaservers.showfull.generic.callback	= ArenaServers_Event;
ADDRGP4 g_arenaservers+648+48
ADDRGP4 ArenaServers_Event
ASGNP4
line 1366
;1366:	g_arenaservers.showfull.generic.id			= ID_SHOW_FULL;
ADDRGP4 g_arenaservers+648+8
CNSTI4 13
ASGNI4
line 1367
;1367:	g_arenaservers.showfull.generic.x			= 320;
ADDRGP4 g_arenaservers+648+12
CNSTI4 320
ASGNI4
line 1368
;1368:	g_arenaservers.showfull.generic.y			= y;
ADDRGP4 g_arenaservers+648+16
ADDRLP4 4
INDIRI4
ASGNI4
line 1370
;1369:
;1370:	y += SMALLCHAR_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 1371
;1371:	g_arenaservers.showempty.generic.type		= MTYPE_RADIOBUTTON;
ADDRGP4 g_arenaservers+712
CNSTI4 5
ASGNI4
line 1372
;1372:	g_arenaservers.showempty.generic.name		= "Show Empty:";
ADDRGP4 g_arenaservers+712+4
ADDRGP4 $801
ASGNP4
line 1373
;1373:	g_arenaservers.showempty.generic.flags		= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 g_arenaservers+712+44
CNSTU4 258
ASGNU4
line 1374
;1374:	g_arenaservers.showempty.generic.callback	= ArenaServers_Event;
ADDRGP4 g_arenaservers+712+48
ADDRGP4 ArenaServers_Event
ASGNP4
line 1375
;1375:	g_arenaservers.showempty.generic.id			= ID_SHOW_EMPTY;
ADDRGP4 g_arenaservers+712+8
CNSTI4 14
ASGNI4
line 1376
;1376:	g_arenaservers.showempty.generic.x			= 320;
ADDRGP4 g_arenaservers+712+12
CNSTI4 320
ASGNI4
line 1377
;1377:	g_arenaservers.showempty.generic.y			= y;
ADDRGP4 g_arenaservers+712+16
ADDRLP4 4
INDIRI4
ASGNI4
line 1379
;1378:
;1379:	y += 3 * SMALLCHAR_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 48
ADDI4
ASGNI4
line 1380
;1380:	g_arenaservers.list.generic.type			= MTYPE_SCROLLLIST;
ADDRGP4 g_arenaservers+776
CNSTI4 8
ASGNI4
line 1381
;1381:	g_arenaservers.list.generic.flags			= QMF_HIGHLIGHT_IF_FOCUS;
ADDRGP4 g_arenaservers+776+44
CNSTU4 128
ASGNU4
line 1382
;1382:	g_arenaservers.list.generic.id				= ID_LIST;
ADDRGP4 g_arenaservers+776+8
CNSTI4 15
ASGNI4
line 1383
;1383:	g_arenaservers.list.generic.callback		= ArenaServers_Event;
ADDRGP4 g_arenaservers+776+48
ADDRGP4 ArenaServers_Event
ASGNP4
line 1384
;1384:	g_arenaservers.list.generic.x				= 72;
ADDRGP4 g_arenaservers+776+12
CNSTI4 72
ASGNI4
line 1385
;1385:	g_arenaservers.list.generic.y				= y;
ADDRGP4 g_arenaservers+776+16
ADDRLP4 4
INDIRI4
ASGNI4
line 1386
;1386:	g_arenaservers.list.width					= MAX_LISTBOXWIDTH;
ADDRGP4 g_arenaservers+776+80
CNSTI4 68
ASGNI4
line 1387
;1387:	g_arenaservers.list.height					= 11;
ADDRGP4 g_arenaservers+776+84
CNSTI4 11
ASGNI4
line 1388
;1388:	g_arenaservers.list.itemnames				= (const char **)g_arenaservers.items;
ADDRGP4 g_arenaservers+776+76
ADDRGP4 g_arenaservers+13288
ASGNP4
line 1389
;1389:	for( i = 0; i < MAX_LISTBOXITEMS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $830
line 1390
;1390:		g_arenaservers.items[i] = g_arenaservers.table[i].buff;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_arenaservers+13288
ADDP4
CNSTI4 72
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_arenaservers+4072
ADDP4
ASGNP4
line 1391
;1391:	}
LABELV $831
line 1389
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 128
LTI4 $830
line 1393
;1392:
;1393:	g_arenaservers.mappic.generic.type			= MTYPE_BITMAP;
ADDRGP4 g_arenaservers+872
CNSTI4 6
ASGNI4
line 1394
;1394:	g_arenaservers.mappic.generic.flags			= QMF_LEFT_JUSTIFY|QMF_INACTIVE;
ADDRGP4 g_arenaservers+872+44
CNSTU4 16388
ASGNU4
line 1395
;1395:	g_arenaservers.mappic.generic.x				= 72;
ADDRGP4 g_arenaservers+872+12
CNSTI4 72
ASGNI4
line 1396
;1396:	g_arenaservers.mappic.generic.y				= 80;
ADDRGP4 g_arenaservers+872+16
CNSTI4 80
ASGNI4
line 1397
;1397:	g_arenaservers.mappic.width					= 128;
ADDRGP4 g_arenaservers+872+76
CNSTI4 128
ASGNI4
line 1398
;1398:	g_arenaservers.mappic.height				= 96;
ADDRGP4 g_arenaservers+872+80
CNSTI4 96
ASGNI4
line 1399
;1399:	g_arenaservers.mappic.errorpic				= ART_UNKNOWNMAP;
ADDRGP4 g_arenaservers+872+64
ADDRGP4 $849
ASGNP4
line 1401
;1400:
;1401:	g_arenaservers.arrows.generic.type			= MTYPE_BITMAP;
ADDRGP4 g_arenaservers+960
CNSTI4 6
ASGNI4
line 1402
;1402:	g_arenaservers.arrows.generic.name			= ART_ARROWS0;
ADDRGP4 g_arenaservers+960+4
ADDRGP4 $853
ASGNP4
line 1403
;1403:	g_arenaservers.arrows.generic.flags			= QMF_LEFT_JUSTIFY|QMF_INACTIVE;
ADDRGP4 g_arenaservers+960+44
CNSTU4 16388
ASGNU4
line 1404
;1404:	g_arenaservers.arrows.generic.callback		= ArenaServers_Event;
ADDRGP4 g_arenaservers+960+48
ADDRGP4 ArenaServers_Event
ASGNP4
line 1405
;1405:	g_arenaservers.arrows.generic.x				= 512+48;
ADDRGP4 g_arenaservers+960+12
CNSTI4 560
ASGNI4
line 1406
;1406:	g_arenaservers.arrows.generic.y				= 240-64+16;
ADDRGP4 g_arenaservers+960+16
CNSTI4 192
ASGNI4
line 1407
;1407:	g_arenaservers.arrows.width					= 64;
ADDRGP4 g_arenaservers+960+76
CNSTI4 64
ASGNI4
line 1408
;1408:	g_arenaservers.arrows.height				= 128;
ADDRGP4 g_arenaservers+960+80
CNSTI4 128
ASGNI4
line 1410
;1409:
;1410:	g_arenaservers.up.generic.type				= MTYPE_BITMAP;
ADDRGP4 g_arenaservers+1048
CNSTI4 6
ASGNI4
line 1411
;1411:	g_arenaservers.up.generic.flags				= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_MOUSEONLY;
ADDRGP4 g_arenaservers+1048+44
CNSTU4 2308
ASGNU4
line 1412
;1412:	g_arenaservers.up.generic.callback			= ArenaServers_Event;
ADDRGP4 g_arenaservers+1048+48
ADDRGP4 ArenaServers_Event
ASGNP4
line 1413
;1413:	g_arenaservers.up.generic.id				= ID_SCROLL_UP;
ADDRGP4 g_arenaservers+1048+8
CNSTI4 16
ASGNI4
line 1414
;1414:	g_arenaservers.up.generic.x					= 512+48;
ADDRGP4 g_arenaservers+1048+12
CNSTI4 560
ASGNI4
line 1415
;1415:	g_arenaservers.up.generic.y					= 240-64+16;
ADDRGP4 g_arenaservers+1048+16
CNSTI4 192
ASGNI4
line 1416
;1416:	g_arenaservers.up.width						= 64;
ADDRGP4 g_arenaservers+1048+76
CNSTI4 64
ASGNI4
line 1417
;1417:	g_arenaservers.up.height					= 64;
ADDRGP4 g_arenaservers+1048+80
CNSTI4 64
ASGNI4
line 1418
;1418:	g_arenaservers.up.focuspic					= ART_ARROWS_UP;
ADDRGP4 g_arenaservers+1048+60
ADDRGP4 $883
ASGNP4
line 1420
;1419:
;1420:	g_arenaservers.down.generic.type			= MTYPE_BITMAP;
ADDRGP4 g_arenaservers+1136
CNSTI4 6
ASGNI4
line 1421
;1421:	g_arenaservers.down.generic.flags			= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS|QMF_MOUSEONLY;
ADDRGP4 g_arenaservers+1136+44
CNSTU4 2308
ASGNU4
line 1422
;1422:	g_arenaservers.down.generic.callback		= ArenaServers_Event;
ADDRGP4 g_arenaservers+1136+48
ADDRGP4 ArenaServers_Event
ASGNP4
line 1423
;1423:	g_arenaservers.down.generic.id				= ID_SCROLL_DOWN;
ADDRGP4 g_arenaservers+1136+8
CNSTI4 17
ASGNI4
line 1424
;1424:	g_arenaservers.down.generic.x				= 512+48;
ADDRGP4 g_arenaservers+1136+12
CNSTI4 560
ASGNI4
line 1425
;1425:	g_arenaservers.down.generic.y				= 240+16;
ADDRGP4 g_arenaservers+1136+16
CNSTI4 256
ASGNI4
line 1426
;1426:	g_arenaservers.down.width					= 64;
ADDRGP4 g_arenaservers+1136+76
CNSTI4 64
ASGNI4
line 1427
;1427:	g_arenaservers.down.height					= 64;
ADDRGP4 g_arenaservers+1136+80
CNSTI4 64
ASGNI4
line 1428
;1428:	g_arenaservers.down.focuspic				= ART_ARROWS_DOWN;
ADDRGP4 g_arenaservers+1136+60
ADDRGP4 $901
ASGNP4
line 1430
;1429:
;1430:	y = 376;
ADDRLP4 4
CNSTI4 376
ASGNI4
line 1431
;1431:	g_arenaservers.status.generic.type		= MTYPE_TEXT;
ADDRGP4 g_arenaservers+1224
CNSTI4 7
ASGNI4
line 1432
;1432:	g_arenaservers.status.generic.x			= 320;
ADDRGP4 g_arenaservers+1224+12
CNSTI4 320
ASGNI4
line 1433
;1433:	g_arenaservers.status.generic.y			= y;
ADDRGP4 g_arenaservers+1224+16
ADDRLP4 4
INDIRI4
ASGNI4
line 1434
;1434:	g_arenaservers.status.string			= statusbuffer;
ADDRGP4 g_arenaservers+1224+60
ADDRGP4 $717
ASGNP4
line 1435
;1435:	g_arenaservers.status.style				= UI_CENTER|UI_SMALLFONT;
ADDRGP4 g_arenaservers+1224+64
CNSTI4 17
ASGNI4
line 1436
;1436:	g_arenaservers.status.color				= menu_text_color;
ADDRGP4 g_arenaservers+1224+68
ADDRGP4 menu_text_color
ASGNP4
line 1438
;1437:
;1438:	y += SMALLCHAR_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 1439
;1439:	g_arenaservers.statusbar.generic.type   = MTYPE_TEXT;
ADDRGP4 g_arenaservers+1296
CNSTI4 7
ASGNI4
line 1440
;1440:	g_arenaservers.statusbar.generic.x	    = 320;
ADDRGP4 g_arenaservers+1296+12
CNSTI4 320
ASGNI4
line 1441
;1441:	g_arenaservers.statusbar.generic.y	    = y;
ADDRGP4 g_arenaservers+1296+16
ADDRLP4 4
INDIRI4
ASGNI4
line 1442
;1442:	g_arenaservers.statusbar.string	        = "";
ADDRGP4 g_arenaservers+1296+60
ADDRGP4 $203
ASGNP4
line 1443
;1443:	g_arenaservers.statusbar.style	        = UI_CENTER|UI_SMALLFONT;
ADDRGP4 g_arenaservers+1296+64
CNSTI4 17
ASGNI4
line 1444
;1444:	g_arenaservers.statusbar.color	        = text_color_normal;
ADDRGP4 g_arenaservers+1296+68
ADDRGP4 text_color_normal
ASGNP4
line 1446
;1445:
;1446:	g_arenaservers.remove.generic.type		= MTYPE_BITMAP;
ADDRGP4 g_arenaservers+1368
CNSTI4 6
ASGNI4
line 1447
;1447:	g_arenaservers.remove.generic.name		= ART_REMOVE0;
ADDRGP4 g_arenaservers+1368+4
ADDRGP4 $927
ASGNP4
line 1448
;1448:	g_arenaservers.remove.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 g_arenaservers+1368+44
CNSTU4 260
ASGNU4
line 1449
;1449:	g_arenaservers.remove.generic.callback	= ArenaServers_Event;
ADDRGP4 g_arenaservers+1368+48
ADDRGP4 ArenaServers_Event
ASGNP4
line 1450
;1450:	g_arenaservers.remove.generic.id		= ID_REMOVE;
ADDRGP4 g_arenaservers+1368+8
CNSTI4 23
ASGNI4
line 1451
;1451:	g_arenaservers.remove.generic.x			= 450;
ADDRGP4 g_arenaservers+1368+12
CNSTI4 450
ASGNI4
line 1452
;1452:	g_arenaservers.remove.generic.y			= 86;
ADDRGP4 g_arenaservers+1368+16
CNSTI4 86
ASGNI4
line 1453
;1453:	g_arenaservers.remove.width				= 96;
ADDRGP4 g_arenaservers+1368+76
CNSTI4 96
ASGNI4
line 1454
;1454:	g_arenaservers.remove.height			= 48;
ADDRGP4 g_arenaservers+1368+80
CNSTI4 48
ASGNI4
line 1455
;1455:	g_arenaservers.remove.focuspic			= ART_REMOVE1;
ADDRGP4 g_arenaservers+1368+60
ADDRGP4 $944
ASGNP4
line 1457
;1456:
;1457:	g_arenaservers.back.generic.type		= MTYPE_BITMAP;
ADDRGP4 g_arenaservers+1456
CNSTI4 6
ASGNI4
line 1458
;1458:	g_arenaservers.back.generic.name		= ART_BACK0;
ADDRGP4 g_arenaservers+1456+4
ADDRGP4 $948
ASGNP4
line 1459
;1459:	g_arenaservers.back.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 g_arenaservers+1456+44
CNSTU4 260
ASGNU4
line 1460
;1460:	g_arenaservers.back.generic.callback	= ArenaServers_Event;
ADDRGP4 g_arenaservers+1456+48
ADDRGP4 ArenaServers_Event
ASGNP4
line 1461
;1461:	g_arenaservers.back.generic.id			= ID_BACK;
ADDRGP4 g_arenaservers+1456+8
CNSTI4 18
ASGNI4
line 1462
;1462:	g_arenaservers.back.generic.x			= 0;
ADDRGP4 g_arenaservers+1456+12
CNSTI4 0
ASGNI4
line 1463
;1463:	g_arenaservers.back.generic.y			= 480-64;
ADDRGP4 g_arenaservers+1456+16
CNSTI4 416
ASGNI4
line 1464
;1464:	g_arenaservers.back.width				= 128;
ADDRGP4 g_arenaservers+1456+76
CNSTI4 128
ASGNI4
line 1465
;1465:	g_arenaservers.back.height				= 64;
ADDRGP4 g_arenaservers+1456+80
CNSTI4 64
ASGNI4
line 1466
;1466:	g_arenaservers.back.focuspic			= ART_BACK1;
ADDRGP4 g_arenaservers+1456+60
ADDRGP4 $965
ASGNP4
line 1468
;1467:
;1468:	g_arenaservers.specify.generic.type	    = MTYPE_BITMAP;
ADDRGP4 g_arenaservers+1632
CNSTI4 6
ASGNI4
line 1469
;1469:	g_arenaservers.specify.generic.name		= ART_SPECIFY0;
ADDRGP4 g_arenaservers+1632+4
ADDRGP4 $969
ASGNP4
line 1470
;1470:	g_arenaservers.specify.generic.flags    = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 g_arenaservers+1632+44
CNSTU4 260
ASGNU4
line 1471
;1471:	g_arenaservers.specify.generic.callback = ArenaServers_Event;
ADDRGP4 g_arenaservers+1632+48
ADDRGP4 ArenaServers_Event
ASGNP4
line 1472
;1472:	g_arenaservers.specify.generic.id	    = ID_SPECIFY;
ADDRGP4 g_arenaservers+1632+8
CNSTI4 20
ASGNI4
line 1473
;1473:	g_arenaservers.specify.generic.x		= 128;
ADDRGP4 g_arenaservers+1632+12
CNSTI4 128
ASGNI4
line 1474
;1474:	g_arenaservers.specify.generic.y		= 480-64;
ADDRGP4 g_arenaservers+1632+16
CNSTI4 416
ASGNI4
line 1475
;1475:	g_arenaservers.specify.width  		    = 128;
ADDRGP4 g_arenaservers+1632+76
CNSTI4 128
ASGNI4
line 1476
;1476:	g_arenaservers.specify.height  		    = 64;
ADDRGP4 g_arenaservers+1632+80
CNSTI4 64
ASGNI4
line 1477
;1477:	g_arenaservers.specify.focuspic         = ART_SPECIFY1;
ADDRGP4 g_arenaservers+1632+60
ADDRGP4 $986
ASGNP4
line 1479
;1478:
;1479:	g_arenaservers.refresh.generic.type		= MTYPE_BITMAP;
ADDRGP4 g_arenaservers+1544
CNSTI4 6
ASGNI4
line 1480
;1480:	g_arenaservers.refresh.generic.name		= ART_REFRESH0;
ADDRGP4 g_arenaservers+1544+4
ADDRGP4 $990
ASGNP4
line 1481
;1481:	g_arenaservers.refresh.generic.flags	= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 g_arenaservers+1544+44
CNSTU4 260
ASGNU4
line 1482
;1482:	g_arenaservers.refresh.generic.callback	= ArenaServers_Event;
ADDRGP4 g_arenaservers+1544+48
ADDRGP4 ArenaServers_Event
ASGNP4
line 1483
;1483:	g_arenaservers.refresh.generic.id		= ID_REFRESH;
ADDRGP4 g_arenaservers+1544+8
CNSTI4 19
ASGNI4
line 1484
;1484:	g_arenaservers.refresh.generic.x		= 256;
ADDRGP4 g_arenaservers+1544+12
CNSTI4 256
ASGNI4
line 1485
;1485:	g_arenaservers.refresh.generic.y		= 480-64;
ADDRGP4 g_arenaservers+1544+16
CNSTI4 416
ASGNI4
line 1486
;1486:	g_arenaservers.refresh.width			= 128;
ADDRGP4 g_arenaservers+1544+76
CNSTI4 128
ASGNI4
line 1487
;1487:	g_arenaservers.refresh.height			= 64;
ADDRGP4 g_arenaservers+1544+80
CNSTI4 64
ASGNI4
line 1488
;1488:	g_arenaservers.refresh.focuspic			= ART_REFRESH1;
ADDRGP4 g_arenaservers+1544+60
ADDRGP4 $1007
ASGNP4
line 1490
;1489:
;1490:	g_arenaservers.create.generic.type		= MTYPE_BITMAP;
ADDRGP4 g_arenaservers+1720
CNSTI4 6
ASGNI4
line 1491
;1491:	g_arenaservers.create.generic.name		= ART_CREATE0;
ADDRGP4 g_arenaservers+1720+4
ADDRGP4 $1011
ASGNP4
line 1492
;1492:	g_arenaservers.create.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 g_arenaservers+1720+44
CNSTU4 260
ASGNU4
line 1493
;1493:	g_arenaservers.create.generic.callback	= ArenaServers_Event;
ADDRGP4 g_arenaservers+1720+48
ADDRGP4 ArenaServers_Event
ASGNP4
line 1494
;1494:	g_arenaservers.create.generic.id		= ID_CREATE;
ADDRGP4 g_arenaservers+1720+8
CNSTI4 21
ASGNI4
line 1495
;1495:	g_arenaservers.create.generic.x			= 384;
ADDRGP4 g_arenaservers+1720+12
CNSTI4 384
ASGNI4
line 1496
;1496:	g_arenaservers.create.generic.y			= 480-64;
ADDRGP4 g_arenaservers+1720+16
CNSTI4 416
ASGNI4
line 1497
;1497:	g_arenaservers.create.width				= 128;
ADDRGP4 g_arenaservers+1720+76
CNSTI4 128
ASGNI4
line 1498
;1498:	g_arenaservers.create.height			= 64;
ADDRGP4 g_arenaservers+1720+80
CNSTI4 64
ASGNI4
line 1499
;1499:	g_arenaservers.create.focuspic			= ART_CREATE1;
ADDRGP4 g_arenaservers+1720+60
ADDRGP4 $1028
ASGNP4
line 1501
;1500:
;1501:	g_arenaservers.go.generic.type			= MTYPE_BITMAP;
ADDRGP4 g_arenaservers+1808
CNSTI4 6
ASGNI4
line 1502
;1502:	g_arenaservers.go.generic.name			= ART_CONNECT0;
ADDRGP4 g_arenaservers+1808+4
ADDRGP4 $1032
ASGNP4
line 1503
;1503:	g_arenaservers.go.generic.flags			= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 g_arenaservers+1808+44
CNSTU4 272
ASGNU4
line 1504
;1504:	g_arenaservers.go.generic.callback		= ArenaServers_Event;
ADDRGP4 g_arenaservers+1808+48
ADDRGP4 ArenaServers_Event
ASGNP4
line 1505
;1505:	g_arenaservers.go.generic.id			= ID_CONNECT;
ADDRGP4 g_arenaservers+1808+8
CNSTI4 22
ASGNI4
line 1506
;1506:	g_arenaservers.go.generic.x				= 640;
ADDRGP4 g_arenaservers+1808+12
CNSTI4 640
ASGNI4
line 1507
;1507:	g_arenaservers.go.generic.y				= 480-64;
ADDRGP4 g_arenaservers+1808+16
CNSTI4 416
ASGNI4
line 1508
;1508:	g_arenaservers.go.width					= 128;
ADDRGP4 g_arenaservers+1808+76
CNSTI4 128
ASGNI4
line 1509
;1509:	g_arenaservers.go.height				= 64;
ADDRGP4 g_arenaservers+1808+80
CNSTI4 64
ASGNI4
line 1510
;1510:	g_arenaservers.go.focuspic				= ART_CONNECT1;
ADDRGP4 g_arenaservers+1808+60
ADDRGP4 $1049
ASGNP4
line 1512
;1511:
;1512:	g_arenaservers.punkbuster.generic.type			= MTYPE_SPINCONTROL;
ADDRGP4 g_arenaservers+14860
CNSTI4 3
ASGNI4
line 1513
;1513:	g_arenaservers.punkbuster.generic.name			= "Punkbuster:";
ADDRGP4 g_arenaservers+14860+4
ADDRGP4 $1053
ASGNP4
line 1514
;1514:	g_arenaservers.punkbuster.generic.flags			= QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 g_arenaservers+14860+44
CNSTU4 258
ASGNU4
line 1515
;1515:	g_arenaservers.punkbuster.generic.callback		= ArenaServers_Event;
ADDRGP4 g_arenaservers+14860+48
ADDRGP4 ArenaServers_Event
ASGNP4
line 1516
;1516:	g_arenaservers.punkbuster.generic.id			= ID_PUNKBUSTER;
ADDRGP4 g_arenaservers+14860+8
CNSTI4 24
ASGNI4
line 1517
;1517:	g_arenaservers.punkbuster.generic.x				= 480+32;
ADDRGP4 g_arenaservers+14860+12
CNSTI4 512
ASGNI4
line 1518
;1518:	g_arenaservers.punkbuster.generic.y				= 144;
ADDRGP4 g_arenaservers+14860+16
CNSTI4 144
ASGNI4
line 1519
;1519:	g_arenaservers.punkbuster.itemnames				= punkbuster_items;
ADDRGP4 g_arenaservers+14860+76
ADDRGP4 punkbuster_items
ASGNP4
line 1521
;1520:	
;1521:	g_arenaservers.pblogo.generic.type			= MTYPE_BITMAP;
ADDRGP4 g_arenaservers+14956
CNSTI4 6
ASGNI4
line 1522
;1522:	g_arenaservers.pblogo.generic.name			= ART_PUNKBUSTER;
ADDRGP4 g_arenaservers+14956+4
ADDRGP4 $1069
ASGNP4
line 1523
;1523:	g_arenaservers.pblogo.generic.flags			= QMF_LEFT_JUSTIFY|QMF_INACTIVE;
ADDRGP4 g_arenaservers+14956+44
CNSTU4 16388
ASGNU4
line 1524
;1524:	g_arenaservers.pblogo.generic.x				= 526;
ADDRGP4 g_arenaservers+14956+12
CNSTI4 526
ASGNI4
line 1525
;1525:	g_arenaservers.pblogo.generic.y				= 176;
ADDRGP4 g_arenaservers+14956+16
CNSTI4 176
ASGNI4
line 1526
;1526:	g_arenaservers.pblogo.width					= 32;
ADDRGP4 g_arenaservers+14956+76
CNSTI4 32
ASGNI4
line 1527
;1527:	g_arenaservers.pblogo.height				= 16;
ADDRGP4 g_arenaservers+14956+80
CNSTI4 16
ASGNI4
line 1528
;1528:	g_arenaservers.pblogo.errorpic				= ART_UNKNOWNMAP;
ADDRGP4 g_arenaservers+14956+64
ADDRGP4 $849
ASGNP4
line 1530
;1529:	
;1530:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.banner );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+288
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1532
;1531:
;1532:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.master );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+360
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1533
;1533:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.gametype );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+456
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1534
;1534:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.sortkey );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+552
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1535
;1535:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.showfull);
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+648
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1536
;1536:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.showempty );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+712
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1538
;1537:
;1538:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.mappic );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+872
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1539
;1539:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.list );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+776
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1540
;1540:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.status );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+1224
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1541
;1541:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.statusbar );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+1296
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1542
;1542:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.arrows );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+960
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1543
;1543:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.up );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+1048
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1544
;1544:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.down );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+1136
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1546
;1545:
;1546:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.remove );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+1368
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1547
;1547:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.back );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+1456
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1548
;1548:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.specify );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+1632
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1549
;1549:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.refresh );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+1544
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1550
;1550:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.create );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+1720
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1551
;1551:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.go );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+1808
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1553
;1552:
;1553:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.punkbuster );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+14860
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1554
;1554:	Menu_AddItem( &g_arenaservers.menu, (void*) &g_arenaservers.pblogo );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 g_arenaservers+14956
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 1556
;1555:	
;1556:	ArenaServers_LoadFavorites();
ADDRGP4 ArenaServers_LoadFavorites
CALLV
pop
line 1558
;1557:
;1558:	g_servertype = Com_Clamp( 0, 3, ui_browserMaster.integer );
CNSTF4 0
ARGF4
CNSTF4 1077936128
ARGF4
ADDRGP4 ui_browserMaster+12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 16
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 g_servertype
ADDRLP4 16
INDIRF4
CVFI4 4
ASGNI4
line 1560
;1559:	// hack to get rid of MPlayer stuff
;1560:	value = g_servertype;
ADDRLP4 8
ADDRGP4 g_servertype
INDIRI4
ASGNI4
line 1561
;1561:	if (value >= 1)
ADDRLP4 8
INDIRI4
CNSTI4 1
LTI4 $1104
line 1562
;1562:		value--;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $1104
line 1563
;1563:	g_arenaservers.master.curvalue = value;
ADDRGP4 g_arenaservers+360+64
ADDRLP4 8
INDIRI4
ASGNI4
line 1565
;1564:
;1565:	g_gametype = Com_Clamp( 0, 4, ui_browserGameType.integer );
CNSTF4 0
ARGF4
CNSTF4 1082130432
ARGF4
ADDRGP4 ui_browserGameType+12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 g_gametype
ADDRLP4 20
INDIRF4
CVFI4 4
ASGNI4
line 1566
;1566:	g_arenaservers.gametype.curvalue = g_gametype;
ADDRGP4 g_arenaservers+456+64
ADDRGP4 g_gametype
INDIRI4
ASGNI4
line 1568
;1567:
;1568:	g_sortkey = Com_Clamp( 0, 4, ui_browserSortKey.integer );
CNSTF4 0
ARGF4
CNSTF4 1082130432
ARGF4
ADDRGP4 ui_browserSortKey+12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 g_sortkey
ADDRLP4 24
INDIRF4
CVFI4 4
ASGNI4
line 1569
;1569:	g_arenaservers.sortkey.curvalue = g_sortkey;
ADDRGP4 g_arenaservers+552+64
ADDRGP4 g_sortkey
INDIRI4
ASGNI4
line 1571
;1570:
;1571:	g_fullservers = Com_Clamp( 0, 1, ui_browserShowFull.integer );
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 ui_browserShowFull+12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 28
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 g_fullservers
ADDRLP4 28
INDIRF4
CVFI4 4
ASGNI4
line 1572
;1572:	g_arenaservers.showfull.curvalue = g_fullservers;
ADDRGP4 g_arenaservers+648+60
ADDRGP4 g_fullservers
INDIRI4
ASGNI4
line 1574
;1573:
;1574:	g_emptyservers = Com_Clamp( 0, 1, ui_browserShowEmpty.integer );
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRGP4 ui_browserShowEmpty+12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 32
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 g_emptyservers
ADDRLP4 32
INDIRF4
CVFI4 4
ASGNI4
line 1575
;1575:	g_arenaservers.showempty.curvalue = g_emptyservers;
ADDRGP4 g_arenaservers+712+60
ADDRGP4 g_emptyservers
INDIRI4
ASGNI4
line 1577
;1576:	
;1577:	g_arenaservers.punkbuster.curvalue = Com_Clamp( 0, 1, trap_Cvar_VariableValue( "cl_punkbuster" ) );
ADDRGP4 $638
ARGP4
ADDRLP4 36
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 g_arenaservers+14860+64
ADDRLP4 40
INDIRF4
CVFI4 4
ASGNI4
line 1580
;1578:
;1579:	// force to initial state and refresh
;1580:	type = g_servertype;
ADDRLP4 12
ADDRGP4 g_servertype
INDIRI4
ASGNI4
line 1581
;1581:	g_servertype = -1;
ADDRGP4 g_servertype
CNSTI4 -1
ASGNI4
line 1582
;1582:	ArenaServers_SetType( type );
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 ArenaServers_SetType
CALLV
pop
line 1584
;1583:
;1584:	trap_Cvar_Register(NULL, "debug_protocol", "", 0 );
CNSTP4 0
ARGP4
ADDRGP4 $571
ARGP4
ADDRGP4 $203
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1585
;1585:}
LABELV $716
endproc ArenaServers_MenuInit 44 16
export ArenaServers_Cache
proc ArenaServers_Cache 0 4
line 1593
;1586:
;1587:
;1588:/*
;1589:=================
;1590:ArenaServers_Cache
;1591:=================
;1592:*/
;1593:void ArenaServers_Cache( void ) {
line 1594
;1594:	trap_R_RegisterShaderNoMip( ART_BACK0 );
ADDRGP4 $948
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1595
;1595:	trap_R_RegisterShaderNoMip( ART_BACK1 );
ADDRGP4 $965
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1596
;1596:	trap_R_RegisterShaderNoMip( ART_CREATE0 );
ADDRGP4 $1011
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1597
;1597:	trap_R_RegisterShaderNoMip( ART_CREATE1 );
ADDRGP4 $1028
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1598
;1598:	trap_R_RegisterShaderNoMip( ART_SPECIFY0 );
ADDRGP4 $969
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1599
;1599:	trap_R_RegisterShaderNoMip( ART_SPECIFY1 );
ADDRGP4 $986
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1600
;1600:	trap_R_RegisterShaderNoMip( ART_REFRESH0 );
ADDRGP4 $990
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1601
;1601:	trap_R_RegisterShaderNoMip( ART_REFRESH1 );
ADDRGP4 $1007
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1602
;1602:	trap_R_RegisterShaderNoMip( ART_CONNECT0 );
ADDRGP4 $1032
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1603
;1603:	trap_R_RegisterShaderNoMip( ART_CONNECT1 );
ADDRGP4 $1049
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1604
;1604:	trap_R_RegisterShaderNoMip( ART_ARROWS0  );
ADDRGP4 $853
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1605
;1605:	trap_R_RegisterShaderNoMip( ART_ARROWS_UP );
ADDRGP4 $883
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1606
;1606:	trap_R_RegisterShaderNoMip( ART_ARROWS_DOWN );
ADDRGP4 $901
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1607
;1607:	trap_R_RegisterShaderNoMip( ART_UNKNOWNMAP );
ADDRGP4 $849
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1608
;1608:	trap_R_RegisterShaderNoMip( ART_PUNKBUSTER );
ADDRGP4 $1069
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 1609
;1609:}
LABELV $1122
endproc ArenaServers_Cache 0 4
export UI_ArenaServersMenu
proc UI_ArenaServersMenu 0 4
line 1617
;1610:
;1611:
;1612:/*
;1613:=================
;1614:UI_ArenaServersMenu
;1615:=================
;1616:*/
;1617:void UI_ArenaServersMenu( void ) {
line 1618
;1618:	ArenaServers_MenuInit();
ADDRGP4 ArenaServers_MenuInit
CALLV
pop
line 1619
;1619:	UI_PushMenu( &g_arenaservers.menu );
ADDRGP4 g_arenaservers
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 1620
;1620:}						  
LABELV $1123
endproc UI_ArenaServersMenu 0 4
bss
align 4
LABELV g_fullservers
skip 4
align 4
LABELV g_emptyservers
skip 4
align 4
LABELV g_sortkey
skip 4
align 4
LABELV g_gametype
skip 4
align 4
LABELV g_servertype
skip 4
align 4
LABELV g_nummplayerservers
skip 4
align 4
LABELV g_mplayerserverlist
skip 19456
align 4
LABELV g_numfavoriteservers
skip 4
align 4
LABELV g_favoriteserverlist
skip 2432
align 4
LABELV g_numlocalservers
skip 4
align 4
LABELV g_localserverlist
skip 19456
align 4
LABELV g_numglobalservers
skip 4
align 4
LABELV g_globalserverlist
skip 19456
align 4
LABELV g_arenaservers
skip 15044
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
import UI_MainMenu
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
LABELV $1069
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 112
byte 1 98
byte 1 108
byte 1 111
byte 1 103
byte 1 111
byte 1 0
align 1
LABELV $1053
byte 1 80
byte 1 117
byte 1 110
byte 1 107
byte 1 98
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 58
byte 1 0
align 1
LABELV $1049
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $1032
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $1028
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 99
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 101
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $1011
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 99
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 101
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $1007
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 114
byte 1 101
byte 1 102
byte 1 114
byte 1 101
byte 1 115
byte 1 104
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $990
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 114
byte 1 101
byte 1 102
byte 1 114
byte 1 101
byte 1 115
byte 1 104
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $986
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 105
byte 1 102
byte 1 121
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $969
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 105
byte 1 102
byte 1 121
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $965
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $948
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $944
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 100
byte 1 101
byte 1 108
byte 1 101
byte 1 116
byte 1 101
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $927
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 100
byte 1 101
byte 1 108
byte 1 101
byte 1 116
byte 1 101
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $901
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 97
byte 1 114
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 95
byte 1 118
byte 1 101
byte 1 114
byte 1 116
byte 1 95
byte 1 98
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $883
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 97
byte 1 114
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 95
byte 1 118
byte 1 101
byte 1 114
byte 1 116
byte 1 95
byte 1 116
byte 1 111
byte 1 112
byte 1 0
align 1
LABELV $853
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 97
byte 1 114
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 95
byte 1 118
byte 1 101
byte 1 114
byte 1 116
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $849
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
LABELV $801
byte 1 83
byte 1 104
byte 1 111
byte 1 119
byte 1 32
byte 1 69
byte 1 109
byte 1 112
byte 1 116
byte 1 121
byte 1 58
byte 1 0
align 1
LABELV $787
byte 1 83
byte 1 104
byte 1 111
byte 1 119
byte 1 32
byte 1 70
byte 1 117
byte 1 108
byte 1 108
byte 1 58
byte 1 0
align 1
LABELV $771
byte 1 83
byte 1 111
byte 1 114
byte 1 116
byte 1 32
byte 1 66
byte 1 121
byte 1 58
byte 1 0
align 1
LABELV $755
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 58
byte 1 0
align 1
LABELV $739
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 58
byte 1 0
align 1
LABELV $731
byte 1 65
byte 1 82
byte 1 69
byte 1 78
byte 1 65
byte 1 32
byte 1 83
byte 1 69
byte 1 82
byte 1 86
byte 1 69
byte 1 82
byte 1 83
byte 1 0
align 1
LABELV $698
byte 1 68
byte 1 105
byte 1 115
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 80
byte 1 117
byte 1 110
byte 1 107
byte 1 98
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 63
byte 1 0
align 1
LABELV $697
byte 1 69
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 80
byte 1 117
byte 1 110
byte 1 107
byte 1 98
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 63
byte 1 0
align 1
LABELV $674
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 101
byte 1 114
byte 1 83
byte 1 104
byte 1 111
byte 1 119
byte 1 69
byte 1 109
byte 1 112
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $668
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 101
byte 1 114
byte 1 83
byte 1 104
byte 1 111
byte 1 119
byte 1 70
byte 1 117
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $662
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 101
byte 1 114
byte 1 83
byte 1 111
byte 1 114
byte 1 116
byte 1 75
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $656
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 101
byte 1 114
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
LABELV $654
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 101
byte 1 114
byte 1 77
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $638
byte 1 99
byte 1 108
byte 1 95
byte 1 112
byte 1 117
byte 1 110
byte 1 107
byte 1 98
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $632
byte 1 104
byte 1 105
byte 1 116
byte 1 32
byte 1 114
byte 1 101
byte 1 102
byte 1 114
byte 1 101
byte 1 115
byte 1 104
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 117
byte 1 112
byte 1 100
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $576
byte 1 112
byte 1 114
byte 1 111
byte 1 116
byte 1 111
byte 1 99
byte 1 111
byte 1 108
byte 1 0
align 1
LABELV $575
byte 1 103
byte 1 108
byte 1 111
byte 1 98
byte 1 97
byte 1 108
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $574
byte 1 103
byte 1 108
byte 1 111
byte 1 98
byte 1 97
byte 1 108
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $571
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 95
byte 1 112
byte 1 114
byte 1 111
byte 1 116
byte 1 111
byte 1 99
byte 1 111
byte 1 108
byte 1 0
align 1
LABELV $570
byte 1 32
byte 1 102
byte 1 117
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $567
byte 1 32
byte 1 101
byte 1 109
byte 1 112
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $563
byte 1 32
byte 1 99
byte 1 116
byte 1 102
byte 1 0
align 1
LABELV $561
byte 1 32
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $559
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $557
byte 1 32
byte 1 102
byte 1 102
byte 1 97
byte 1 0
align 1
LABELV $545
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 108
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $523
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
LABELV $413
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $392
byte 1 78
byte 1 111
byte 1 32
byte 1 82
byte 1 101
byte 1 115
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $384
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
LABELV $383
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $382
byte 1 110
byte 1 101
byte 1 116
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $381
byte 1 112
byte 1 117
byte 1 110
byte 1 107
byte 1 98
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $380
byte 1 109
byte 1 97
byte 1 120
byte 1 80
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $379
byte 1 109
byte 1 105
byte 1 110
byte 1 80
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $378
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
LABELV $377
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $376
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $375
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
LABELV $311
byte 1 78
byte 1 111
byte 1 0
align 1
LABELV $310
byte 1 89
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $309
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 46
byte 1 50
byte 1 48
byte 1 115
byte 1 32
byte 1 37
byte 1 45
byte 1 49
byte 1 50
byte 1 46
byte 1 49
byte 1 50
byte 1 115
byte 1 32
byte 1 37
byte 1 50
byte 1 100
byte 1 47
byte 1 37
byte 1 50
byte 1 100
byte 1 32
byte 1 37
byte 1 45
byte 1 56
byte 1 46
byte 1 56
byte 1 115
byte 1 32
byte 1 37
byte 1 51
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 37
byte 1 51
byte 1 100
byte 1 32
byte 1 94
byte 1 51
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $308
byte 1 94
byte 1 49
byte 1 0
align 1
LABELV $307
byte 1 94
byte 1 51
byte 1 0
align 1
LABELV $304
byte 1 94
byte 1 50
byte 1 0
align 1
LABELV $299
byte 1 94
byte 1 52
byte 1 0
align 1
LABELV $238
byte 1 78
byte 1 111
byte 1 32
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 70
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 46
byte 1 0
align 1
LABELV $235
byte 1 78
byte 1 111
byte 1 32
byte 1 82
byte 1 101
byte 1 115
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 101
byte 1 32
byte 1 70
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 77
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 46
byte 1 0
align 1
LABELV $209
byte 1 83
byte 1 99
byte 1 97
byte 1 110
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 70
byte 1 111
byte 1 114
byte 1 32
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 46
byte 1 0
align 1
LABELV $203
byte 1 0
align 1
LABELV $175
byte 1 80
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 32
byte 1 83
byte 1 80
byte 1 65
byte 1 67
byte 1 69
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 115
byte 1 116
byte 1 111
byte 1 112
byte 1 0
align 1
LABELV $170
byte 1 37
byte 1 100
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 65
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 32
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 46
byte 1 0
align 1
LABELV $154
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
LABELV $141
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $106
byte 1 99
byte 1 108
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 80
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $101
byte 1 105
byte 1 115
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 101
byte 1 100
byte 1 46
byte 1 0
align 1
LABELV $100
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
byte 1 0
align 1
LABELV $99
byte 1 100
byte 1 105
byte 1 115
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $98
byte 1 80
byte 1 117
byte 1 110
byte 1 107
byte 1 66
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 119
byte 1 105
byte 1 108
byte 1 108
byte 1 32
byte 1 98
byte 1 101
byte 1 0
align 1
LABELV $97
byte 1 69
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $96
byte 1 68
byte 1 105
byte 1 115
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $95
byte 1 73
byte 1 80
byte 1 88
byte 1 0
align 1
LABELV $94
byte 1 85
byte 1 68
byte 1 80
byte 1 0
align 1
LABELV $93
byte 1 63
byte 1 63
byte 1 63
byte 1 0
align 1
LABELV $92
byte 1 79
byte 1 83
byte 1 80
byte 1 0
align 1
LABELV $91
byte 1 85
byte 1 114
byte 1 98
byte 1 97
byte 1 110
byte 1 32
byte 1 84
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $90
byte 1 81
byte 1 51
byte 1 70
byte 1 0
align 1
LABELV $89
byte 1 82
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 32
byte 1 65
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 32
byte 1 51
byte 1 0
align 1
LABELV $88
byte 1 72
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $87
byte 1 79
byte 1 118
byte 1 101
byte 1 114
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $86
byte 1 79
byte 1 110
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 67
byte 1 84
byte 1 70
byte 1 0
align 1
LABELV $85
byte 1 67
byte 1 84
byte 1 70
byte 1 0
align 1
LABELV $84
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 68
byte 1 77
byte 1 0
align 1
LABELV $83
byte 1 83
byte 1 80
byte 1 32
byte 1 0
align 1
LABELV $82
byte 1 49
byte 1 118
byte 1 49
byte 1 0
align 1
LABELV $81
byte 1 68
byte 1 77
byte 1 32
byte 1 0
align 1
LABELV $80
byte 1 80
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $79
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $78
byte 1 79
byte 1 112
byte 1 101
byte 1 110
byte 1 32
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 83
byte 1 112
byte 1 111
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $77
byte 1 77
byte 1 97
byte 1 112
byte 1 32
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $76
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $75
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $74
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
LABELV $73
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
LABELV $72
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
LABELV $71
byte 1 65
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $70
byte 1 70
byte 1 97
byte 1 118
byte 1 111
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $69
byte 1 73
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 110
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $68
byte 1 76
byte 1 111
byte 1 99
byte 1 97
byte 1 108
byte 1 0
