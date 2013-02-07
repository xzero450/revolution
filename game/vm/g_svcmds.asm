export Svcmd_MapNum_f
code
proc Svcmd_MapNum_f 1108 12
file "../g_svcmds.c"
line 264
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:
;4:// this file holds commands that can be executed by the server console, but not remote clients
;5:
;6:#include "g_local.h"
;7:
;8:
;9:/*
;10:==============================================================================
;11:
;12:PACKET FILTERING
;13: 
;14:
;15:You can add or remove addresses from the filter list with:
;16:
;17:addip <ip>
;18:removeip <ip>
;19:
;20:The ip address is specified in dot format, and you can use '*' to match any value
;21:so you can specify an entire class C network with "addip 192.246.40.*"
;22:
;23:Removeip will only remove an address specified exactly the same way.  You cannot addip a subnet, then removeip a single host.
;24:
;25:listip
;26:Prints the current list of filters.
;27:
;28:g_filterban <0 or 1>
;29:
;30:If 1 (the default), then ip addresses matching the current list will be prohibited from entering the game.  This is the default setting.
;31:
;32:If 0, then only addresses matching the list will be allowed.  This lets you easily set up a private game, or a game that only allows players from your local network.
;33:
;34:TTimo NOTE: for persistence, bans are stored in g_banIPs cvar MAX_CVAR_VALUE_STRING
;35:The size of the cvar string buffer is limiting the banning to around 20 masks
;36:this could be improved by putting some g_banIPs2 g_banIps3 etc. maybe
;37:still, you should rely on PB for banning instead
;38:
;39:==============================================================================
;40:*/
;41:
;42://typedef struct ipFilter_s
;43://{
;44://	unsigned	mask;
;45://	unsigned	compare;
;46://} ipFilter_t;
;47://
;48://#define	MAX_IPFILTERS	1024
;49://
;50://static ipFilter_t	ipFilters[MAX_IPFILTERS];
;51://static int			numIPFilters;
;52:
;53:/*
;54:=================
;55:StringToFilter
;56:=================
;57:*/
;58://static qboolean StringToFilter (char *s, ipFilter_t *f)
;59://{
;60://	char	num[128];
;61://	int		i, j;
;62://	byte	b[4];
;63://	byte	m[4];
;64://	
;65://	for (i=0 ; i<4 ; i++)
;66://	{
;67://		b[i] = 0;
;68://		m[i] = 0;
;69://	}
;70://	
;71://	for (i=0 ; i<4 ; i++)
;72://	{
;73://		if (*s < '0' || *s > '9')
;74://		{
;75://			if (*s == '*') // 'match any'
;76://			{
;77://				// b[i] and m[i] to 0
;78://				s++;
;79://				if (!*s)
;80://					break;
;81://				s++;
;82://				continue;
;83://			}
;84://			G_Printf( "Bad filter address: %s\n", s );
;85://			return qfalse;
;86://		}
;87://		
;88://		j = 0;
;89://		while (*s >= '0' && *s <= '9')
;90://		{
;91://			num[j++] = *s++;
;92://		}
;93://		num[j] = 0;
;94://		b[i] = atoi(num);
;95://		m[i] = 255;
;96://
;97://		if (!*s)
;98://			break;
;99://		s++;
;100://	}
;101://	
;102://	f->mask = *(unsigned *)m;
;103://	f->compare = *(unsigned *)b;
;104://	
;105://	return qtrue;
;106://}
;107:
;108:/*
;109:=================
;110:UpdateIPBans
;111:=================
;112:*/
;113://static void UpdateIPBans (void)
;114://{
;115://	byte	b[4];
;116://	byte	m[4];
;117://	int		i,j;
;118://	char	iplist_final[MAX_CVAR_VALUE_STRING];
;119://	char	ip[64];
;120://
;121://	*iplist_final = 0;
;122://	for (i = 0 ; i < numIPFilters ; i++)
;123://	{
;124://		if (ipFilters[i].compare == 0xffffffff)
;125://			continue;
;126://
;127://		*(unsigned *)b = ipFilters[i].compare;
;128://		*(unsigned *)m = ipFilters[i].mask;
;129://		*ip = 0;
;130://		for (j = 0 ; j < 4 ; j++)
;131://		{
;132://			if (m[j]!=255)
;133://				Q_strcat(ip, sizeof(ip), "*");
;134://			else
;135://				Q_strcat(ip, sizeof(ip), va("%i", b[j]));
;136://			Q_strcat(ip, sizeof(ip), (j<3) ? "." : " ");
;137://		}		
;138://		if (strlen(iplist_final)+strlen(ip) < MAX_CVAR_VALUE_STRING)
;139://		{
;140://			Q_strcat( iplist_final, sizeof(iplist_final), ip);
;141://		}
;142://		else
;143://		{
;144://			Com_Printf("g_banIPs overflowed at MAX_CVAR_VALUE_STRING\n");
;145://			break;
;146://		}
;147://	}
;148://
;149://	trap_Cvar_Set( "g_banIPs", iplist_final );
;150://}
;151:
;152:/*
;153:=================
;154:G_FilterPacket
;155:=================
;156:*/
;157://qboolean G_FilterPacket (char *from)
;158://{
;159://	int		i;
;160://	unsigned	in;
;161://	byte m[4];
;162://	char *p;
;163://
;164://	i = 0;
;165://	p = from;
;166://	while (*p && i < 4) {
;167://		m[i] = 0;
;168://		while (*p >= '0' && *p <= '9') {
;169://			m[i] = m[i]*10 + (*p - '0');
;170://			p++;
;171://		}
;172://		if (!*p || *p == ':')
;173://			break;
;174://		i++, p++;
;175://	}
;176://	
;177://	in = *(unsigned *)m;
;178://
;179://	for (i=0 ; i<numIPFilters ; i++)
;180://		if ( (in & ipFilters[i].mask) == ipFilters[i].compare)
;181://			return g_filterBan.integer != 0;
;182://
;183://	return g_filterBan.integer == 0;
;184://}
;185:
;186:/*
;187:=================
;188:AddIP
;189:=================
;190:*/
;191://static void AddIP( char *str )
;192://{
;193://	int		i;
;194://
;195://	for (i = 0 ; i < numIPFilters ; i++)
;196://		if (ipFilters[i].compare == 0xffffffff)
;197://			break;		// free spot
;198://	if (i == numIPFilters)
;199://	{
;200://		if (numIPFilters == MAX_IPFILTERS)
;201://		{
;202://			G_Printf ("IP filter list is full\n");
;203://			return;
;204://		}
;205://		numIPFilters++;
;206://	}
;207://	
;208://	if (!StringToFilter (str, &ipFilters[i]))
;209://		ipFilters[i].compare = 0xffffffffu;
;210://
;211://	UpdateIPBans();
;212://}
;213:
;214:/*
;215:=================
;216:G_ProcessIPBans
;217:=================
;218:*/
;219://void G_ProcessIPBans(void) 
;220://{
;221://	char *s, *t;
;222://	char		str[MAX_CVAR_VALUE_STRING];
;223://
;224://	Q_strncpyz( str, g_banIPs.string, sizeof(str) );
;225://
;226://	for (t = s = g_banIPs.string; *t; /* */ ) {
;227://		s = strchr(s, ' ');
;228://		if (!s)
;229://			break;
;230://		while (*s == ' ')
;231://			*s++ = 0;
;232://		if (*t)
;233://			AddIP( t );
;234://		t = s;
;235://	}
;236://}
;237:
;238:
;239:/*
;240:=================
;241:Svcmd_AddIP_f
;242:=================
;243:*/
;244://void Svcmd_AddIP_f (void)
;245://{
;246://	char		str[MAX_TOKEN_CHARS];
;247://
;248://	if ( trap_Argc() < 2 ) {
;249://		G_Printf("Usage:  addip <ip-mask>\n");
;250://		return;
;251://	}
;252://
;253://	trap_Argv( 1, str, sizeof( str ) );
;254://
;255://	AddIP( str );
;256://
;257://}
;258:
;259:/*
;260:=================
;261:Svcmd_MapNum_f
;262:=================
;263:*/
;264:void Svcmd_MapNum_f () {
line 271
;265:	// special case for map changes, we want to reset the nextmap setting
;266:	// this allows a player to change maps, but not upset the map rotation
;267:	char	mapName[MAX_QPATH];
;268:	int		mapNum, mapCount;
;269:	char	arg1[MAX_STRING_TOKENS];
;270:
;271:	trap_Argv(1, arg1, sizeof(arg1));
CNSTI4 1
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 272
;272:	if( ! *arg1) {
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $68
line 273
;273:		G_Printf( "^1Invalid mapnumber.\n" );
ADDRGP4 $70
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 274
;274:		return;
ADDRGP4 $67
JUMPV
LABELV $68
line 276
;275:	}
;276:	mapNum = atoi(arg1);
ADDRLP4 4
ARGP4
ADDRLP4 1096
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 1096
INDIRI4
ASGNI4
line 277
;277:	if( mapNum == 0 && arg1[0] != '0' ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $71
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 48
EQI4 $71
line 280
;278:		//since atoi will return 0 if it can't convert, we need to know if it was 0 or just
;279:		//a failed conversion, in which case we should print an error
;280:		G_Printf( "^1Invalid mapnumber.\n" );
ADDRGP4 $70
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 281
;281:		return;
ADDRGP4 $67
JUMPV
LABELV $71
line 284
;282:	}
;283:
;284:	if(mapNum < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $73
line 285
;285:		G_Printf( "^1Invalid mapnumber, must be greater then zero.\n" );
ADDRGP4 $75
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 286
;286:		return;
ADDRGP4 $67
JUMPV
LABELV $73
line 289
;287:	}
;288:
;289:	memset(mapName, 0, sizeof(mapName));
ADDRLP4 1028
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 290
;290:	mapCount = FindMapNameForNumber( mapName, mapNum );
ADDRLP4 1028
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1100
ADDRGP4 FindMapNameForNumber
CALLI4
ASGNI4
ADDRLP4 1092
ADDRLP4 1100
INDIRI4
ASGNI4
line 292
;291:
;292:	if(mapNum > mapCount) {
ADDRLP4 0
INDIRI4
ADDRLP4 1092
INDIRI4
LEI4 $76
line 293
;293:		G_Printf( va("^1Invalid mapnumber, must be less then %d.\n", mapCount));
ADDRGP4 $78
ARGP4
ADDRLP4 1092
INDIRI4
ARGI4
ADDRLP4 1104
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1104
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 294
;294:		return;
ADDRGP4 $67
JUMPV
LABELV $76
line 297
;295:	}
;296:
;297:	trap_SendConsoleCommand( EXEC_APPEND, va("map %s\n", mapName ) );
ADDRGP4 $79
ARGP4
ADDRLP4 1028
ARGP4
ADDRLP4 1104
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1104
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 298
;298:	return;
LABELV $67
endproc Svcmd_MapNum_f 1108 12
export Svcmd_BanIP_f
proc Svcmd_BanIP_f 168 12
line 336
;299:}
;300:
;301:/*
;302:=================
;303:Svcmd_RemoveIP_f
;304:=================
;305:*/
;306://void Svcmd_RemoveIP_f (void)
;307://{
;308://	ipFilter_t	f;
;309://	int			i;
;310://	char		str[MAX_TOKEN_CHARS];
;311://
;312://	if ( trap_Argc() < 2 ) {
;313://		G_Printf("Usage:  sv removeip <ip-mask>\n");
;314://		return;
;315://	}
;316://
;317://	trap_Argv( 1, str, sizeof( str ) );
;318://
;319://	if (!StringToFilter (str, &f))
;320://		return;
;321://
;322://	for (i=0 ; i<numIPFilters ; i++) {
;323://		if (ipFilters[i].mask == f.mask	&&
;324://			ipFilters[i].compare == f.compare) {
;325://			ipFilters[i].compare = 0xffffffffu;
;326://			G_Printf ("Removed.\n");
;327://
;328://			UpdateIPBans();
;329://			return;
;330://		}
;331://	}
;332://
;333://	G_Printf ( "Didn't find %s.\n", str );
;334://}
;335:
;336:void Svcmd_BanIP_f(qboolean isBan) {
line 337
;337:	int i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 340
;338:	char		str[128];
;339:
;340:	if (isBan) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $81
line 341
;341:		int	timeDiff = getTimeDiff();
ADDRLP4 136
ADDRGP4 getTimeDiff
CALLI4
ASGNI4
ADDRLP4 132
ADDRLP4 136
INDIRI4
ASGNI4
line 342
;342:		if ( trap_Argc() == 2) {
ADDRLP4 140
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 2
NEI4 $83
line 344
;343:			//Just ban an IP
;344:			trap_Argv( 1, str, sizeof( str ) );
CNSTI4 1
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 345
;345:			for ( i = 0; i < NUM_BANS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $85
line 346
;346:				if ( strlen(bans[i].ip) < 2 && isBan ) {
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bans
ADDP4
ARGP4
ADDRLP4 144
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 2
GEI4 $89
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $89
line 347
;347:					Q_strncpyz(bans[i].ip, str, sizeof(bans[i].ip));
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bans
ADDP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 348
;348:					bans[i].time = 0;
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bans+16
ADDP4
CNSTI4 0
ASGNI4
line 349
;349:					bans[i].type = 1;//Assume perm ban
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bans+20
ADDP4
CNSTI4 1
ASGNI4
line 350
;350:					Q_strncpyz(bans[i].message, "No Reason Provided", sizeof(bans[i].message));
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bans+24
ADDP4
ARGP4
ADDRGP4 $94
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 351
;351:					G_Printf("Ban slot %i contains %s\n", i, bans[i].ip);
ADDRGP4 $96
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bans
ADDP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 352
;352:					isBan = qfalse;
ADDRFP4 0
CNSTI4 0
ASGNI4
line 353
;353:				} else {
ADDRGP4 $80
JUMPV
LABELV $89
line 354
;354:					bans[i].time -= timeDiff;
ADDRLP4 148
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bans+16
ADDP4
ASGNP4
ADDRLP4 148
INDIRP4
ADDRLP4 148
INDIRP4
INDIRI4
ADDRLP4 132
INDIRI4
SUBI4
ASGNI4
line 355
;355:				}
line 356
;356:				return;
ADDRGP4 $80
JUMPV
LABELV $86
line 345
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $85
line 358
;357:			}
;358:			G_Printf("Unable to add ip ban - Likely because all slots are full.\n");
ADDRGP4 $98
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 360
;359:
;360:		} else if ( trap_Argc() < 5 ) {
ADDRGP4 $84
JUMPV
LABELV $83
ADDRLP4 144
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 5
GEI4 $99
line 361
;361:			G_Printf("Usage:  banip <ip-mask> <time> <ban type-mask> <reason>\n");
ADDRGP4 $101
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 362
;362:			return;
ADDRGP4 $80
JUMPV
LABELV $99
LABELV $84
line 365
;363:		}
;364:		//Ban an ip
;365:		trap_Argv( 1, str, sizeof( str ) );
CNSTI4 1
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 367
;366:		//G_Printf("%s\n", str);
;367:		for ( i = 0; i < NUM_BANS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $102
line 369
;368:			//G_Printf("%i\n", i);
;369:			if ( strlen(bans[i].ip) < 2 && isBan ) {
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bans
ADDP4
ARGP4
ADDRLP4 148
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 2
GEI4 $106
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $106
line 371
;370:				//G_Printf("%i: %s\n", i, str);
;371:				Q_strncpyz(bans[i].ip, str, sizeof(bans[i].ip));
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bans
ADDP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 372
;372:				memset(str, 0, sizeof(str));
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 128
ARGI4
ADDRGP4 memset
CALLP4
pop
line 373
;373:				trap_Argv( 2, str, sizeof( str ) );
CNSTI4 2
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 374
;374:				bans[i].time = atoi(str);
ADDRLP4 4
ARGP4
ADDRLP4 152
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bans+16
ADDP4
ADDRLP4 152
INDIRI4
ASGNI4
line 375
;375:				memset(str, 0, sizeof(str));
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 128
ARGI4
ADDRGP4 memset
CALLP4
pop
line 376
;376:				trap_Argv( 3, str, sizeof( str ) );
CNSTI4 3
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 377
;377:				bans[i].type = atoi(str);
ADDRLP4 4
ARGP4
ADDRLP4 156
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bans+20
ADDP4
ADDRLP4 156
INDIRI4
ASGNI4
line 378
;378:				Q_strncpyz(bans[i].message, ConcatArgs(4), sizeof(bans[i].message));
CNSTI4 4
ARGI4
ADDRLP4 160
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bans+24
ADDP4
ARGP4
ADDRLP4 160
INDIRP4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 380
;379:				//trap_SendConsoleCommand(EXEC_NOW, va("seta banip%i %s", i, str));
;380:				G_Printf("Ban slot %i contains %s\n", i, bans[i].ip);
ADDRGP4 $96
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bans
ADDP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 381
;381:				isBan = qfalse;
ADDRFP4 0
CNSTI4 0
ASGNI4
line 382
;382:			} else {
ADDRGP4 $80
JUMPV
LABELV $106
line 383
;383:				bans[i].time -= timeDiff;
ADDRLP4 152
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bans+16
ADDP4
ASGNP4
ADDRLP4 152
INDIRP4
ADDRLP4 152
INDIRP4
INDIRI4
ADDRLP4 132
INDIRI4
SUBI4
ASGNI4
line 384
;384:			}
line 385
;385:			return;
ADDRGP4 $80
JUMPV
LABELV $103
line 367
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $102
line 387
;386:		}
;387:		G_Printf("Unable to add ip ban - Likely because all slots are full.\n");
ADDRGP4 $98
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 388
;388:	} else {
ADDRGP4 $82
JUMPV
LABELV $81
line 389
;389:		if ( trap_Argc() < 2 ) {
ADDRLP4 132
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 2
GEI4 $113
line 390
;390:			G_Printf("Usage:  unbanip <ip-mask |or| slot #>\n");
ADDRGP4 $115
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 391
;391:			return;
ADDRGP4 $80
JUMPV
LABELV $113
line 394
;392:		}
;393:
;394:		trap_Argv( 1, str, sizeof( str ) );
CNSTI4 1
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 396
;395:		//G_Printf("%s\n", str);
;396:		for ( i = 0; i < NUM_BANS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $116
line 397
;397:			if ( strlen(str) < 3 ) {
ADDRLP4 4
ARGP4
ADDRLP4 136
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 3
GEI4 $120
line 398
;398:				if ( atoi(str) == i ) {
ADDRLP4 4
ARGP4
ADDRLP4 140
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $121
line 399
;399:					memset(&bans[i], 0, sizeof(&bans[i]));
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bans
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 400
;400:					G_Printf("Unbanned slot number %i\n", i);
ADDRGP4 $124
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 401
;401:					return;
ADDRGP4 $80
JUMPV
line 403
;402:				}
;403:			} else if ( strlen(bans[i].ip) > 2 ) {
LABELV $120
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bans
ADDP4
ARGP4
ADDRLP4 140
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 2
LEI4 $125
line 404
;404:				if ( Q_strncmp(str, bans[i].ip, strlen(bans[i].ip)) == 0 ) {
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bans
ADDP4
ARGP4
ADDRLP4 144
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ARGP4
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bans
ADDP4
ARGP4
ADDRLP4 144
INDIRI4
ARGI4
ADDRLP4 148
ADDRGP4 Q_strncmp
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $127
line 405
;405:					memset(&bans[i], 0, sizeof(&bans[i]));
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bans
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 406
;406:					G_Printf("Unbanned ip %s at slot %i\n", str, i );
ADDRGP4 $129
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 407
;407:					return;
ADDRGP4 $80
JUMPV
LABELV $127
line 409
;408:				}
;409:			}
LABELV $125
LABELV $121
line 410
;410:		}
LABELV $117
line 396
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $116
line 411
;411:		G_Printf("Unable to unban %s\n", str);
ADDRGP4 $130
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 412
;412:	}
LABELV $82
line 413
;413:}
LABELV $80
endproc Svcmd_BanIP_f 168 12
export Svcmd_ListBanIP_f
proc Svcmd_ListBanIP_f 16 16
line 415
;414:
;415:void Svcmd_ListBanIP_f(void) {
line 416
;416:	int i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 420
;417://	const char	*var;
;418://	char	s[128];
;419:
;420:	for ( i = 0; i < MAX_SERVER_TASKS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $132
line 422
;421:		//G_Printf("%i\n", i);
;422:		if ( strlen(bans[i].ip) > 2 ) {
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bans
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LEI4 $136
line 423
;423:			G_Printf("%i: %s %s\n", i, bans[i].ip, bans[i].message);
ADDRGP4 $138
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 12
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRGP4 bans
ADDP4
ARGP4
ADDRLP4 12
INDIRI4
ADDRGP4 bans+24
ADDP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 424
;424:		}
LABELV $136
line 425
;425:	}
LABELV $133
line 420
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $132
line 426
;426:}
LABELV $131
endproc Svcmd_ListBanIP_f 16 16
export Svcmd_EntityList_f
proc Svcmd_EntityList_f 16 8
line 433
;427:
;428:/*
;429:===================
;430:Svcmd_EntityList_f
;431:===================
;432:*/
;433:void	Svcmd_EntityList_f (void) {
line 437
;434:	int			e;
;435:	gentity_t		*check;
;436:
;437:	check = g_entities+1;
ADDRLP4 0
ADDRGP4 g_entities+896
ASGNP4
line 438
;438:	for (e = 1; e < level.num_entities ; e++, check++) {
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRGP4 $145
JUMPV
LABELV $142
line 439
;439:		if ( !check->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $147
line 440
;440:			continue;
ADDRGP4 $143
JUMPV
LABELV $147
line 442
;441:		}
;442:		G_Printf("%3i:", e);
ADDRGP4 $149
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 443
;443:		switch ( check->s.eType ) {
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $150
ADDRLP4 8
INDIRI4
CNSTI4 11
GTI4 $150
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $178
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $178
address $153
address $155
address $157
address $159
address $161
address $163
address $165
address $167
address $169
address $171
address $173
address $175
code
LABELV $153
line 445
;444:		case ET_GENERAL:
;445:			G_Printf("ET_GENERAL          ");
ADDRGP4 $154
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 446
;446:			break;
ADDRGP4 $151
JUMPV
LABELV $155
line 448
;447:		case ET_PLAYER:
;448:			G_Printf("ET_PLAYER           ");
ADDRGP4 $156
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 449
;449:			break;
ADDRGP4 $151
JUMPV
LABELV $157
line 451
;450:		case ET_ITEM:
;451:			G_Printf("ET_ITEM             ");
ADDRGP4 $158
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 452
;452:			break;
ADDRGP4 $151
JUMPV
LABELV $159
line 454
;453:		case ET_MISSILE:
;454:			G_Printf("ET_MISSILE          ");
ADDRGP4 $160
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 455
;455:			break;
ADDRGP4 $151
JUMPV
LABELV $161
line 457
;456:		case ET_MOVER:
;457:			G_Printf("ET_MOVER            ");
ADDRGP4 $162
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 458
;458:			break;
ADDRGP4 $151
JUMPV
LABELV $163
line 460
;459:		case ET_BEAM:
;460:			G_Printf("ET_BEAM             ");
ADDRGP4 $164
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 461
;461:			break;
ADDRGP4 $151
JUMPV
LABELV $165
line 463
;462:		case ET_PORTAL:
;463:			G_Printf("ET_PORTAL           ");
ADDRGP4 $166
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 464
;464:			break;
ADDRGP4 $151
JUMPV
LABELV $167
line 466
;465:		case ET_SPEAKER:
;466:			G_Printf("ET_SPEAKER          ");
ADDRGP4 $168
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 467
;467:			break;
ADDRGP4 $151
JUMPV
LABELV $169
line 469
;468:		case ET_PUSH_TRIGGER:
;469:			G_Printf("ET_PUSH_TRIGGER     ");
ADDRGP4 $170
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 470
;470:			break;
ADDRGP4 $151
JUMPV
LABELV $171
line 472
;471:		case ET_TELEPORT_TRIGGER:
;472:			G_Printf("ET_TELEPORT_TRIGGER ");
ADDRGP4 $172
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 473
;473:			break;
ADDRGP4 $151
JUMPV
LABELV $173
line 475
;474:		case ET_INVISIBLE:
;475:			G_Printf("ET_INVISIBLE        ");
ADDRGP4 $174
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 476
;476:			break;
ADDRGP4 $151
JUMPV
LABELV $175
line 478
;477:		case ET_GRAPPLE:
;478:			G_Printf("ET_GRAPPLE          ");
ADDRGP4 $176
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 479
;479:			break;
ADDRGP4 $151
JUMPV
LABELV $150
line 481
;480:		default:
;481:			G_Printf("%3i                 ", check->s.eType);
ADDRGP4 $177
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 482
;482:			break;
LABELV $151
line 485
;483:		}
;484:
;485:		if ( check->classname ) {
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $179
line 486
;486:			G_Printf("%s", check->classname);
ADDRGP4 $181
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 487
;487:		}
LABELV $179
line 488
;488:		G_Printf("\n");
ADDRGP4 $182
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 489
;489:	}
LABELV $143
line 438
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 896
ADDP4
ASGNP4
LABELV $145
ADDRLP4 4
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $142
line 490
;490:}
LABELV $140
endproc Svcmd_EntityList_f 16 8
export ClientForString
proc ClientForString 24 8
line 492
;491:
;492:gclient_t	*ClientForString( const char *s ) {
line 498
;493:	gclient_t	*cl;
;494:	int			i;
;495:	int			idnum;
;496:
;497:	// numeric values are just slot numbers
;498:	if ( s[0] >= '0' && s[0] <= '9' ) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 48
LTI4 $184
ADDRLP4 12
INDIRI4
CNSTI4 57
GTI4 $184
line 499
;499:		idnum = atoi( s );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 16
INDIRI4
ASGNI4
line 500
;500:		if ( idnum < 0 || idnum >= level.maxclients ) {
ADDRLP4 20
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
LTI4 $189
ADDRLP4 20
INDIRI4
ADDRGP4 level+28
INDIRI4
LTI4 $186
LABELV $189
line 501
;501:			Com_Printf( "Bad client slot: %i\n", idnum );
ADDRGP4 $190
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 502
;502:			return NULL;
CNSTP4 0
RETP4
ADDRGP4 $183
JUMPV
LABELV $186
line 505
;503:		}
;504:
;505:		cl = &level.clients[idnum];
ADDRLP4 0
CNSTI4 10828
ADDRLP4 8
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 506
;506:		if ( cl->pers.connected == CON_DISCONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $191
line 507
;507:			G_Printf( "Client %i is not connected\n", idnum );
ADDRGP4 $193
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 508
;508:			return NULL;
CNSTP4 0
RETP4
ADDRGP4 $183
JUMPV
LABELV $191
line 510
;509:		}
;510:		return cl;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $183
JUMPV
LABELV $184
line 514
;511:	}
;512:
;513:	// check for a name match
;514:	for ( i=0 ; i < level.maxclients ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $197
JUMPV
LABELV $194
line 515
;515:		cl = &level.clients[i];
ADDRLP4 0
CNSTI4 10828
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 516
;516:		if ( cl->pers.connected == CON_DISCONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $199
line 517
;517:			continue;
ADDRGP4 $195
JUMPV
LABELV $199
line 519
;518:		}
;519:		if ( !Q_stricmp( cl->pers.netname, s ) ) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $201
line 520
;520:			return cl;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $183
JUMPV
LABELV $201
line 522
;521:		}
;522:	}
LABELV $195
line 514
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $197
ADDRLP4 4
INDIRI4
ADDRGP4 level+28
INDIRI4
LTI4 $194
line 524
;523:
;524:	G_Printf( "User %s is not on the server\n", s );
ADDRGP4 $203
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 526
;525:
;526:	return NULL;
CNSTP4 0
RETP4
LABELV $183
endproc ClientForString 24 8
export Svcmd_ForceTeam_f
proc Svcmd_ForceTeam_f 1032 12
line 536
;527:}
;528:
;529:/*
;530:===================
;531:Svcmd_ForceTeam_f
;532:
;533:forceteam <player> <team>
;534:===================
;535:*/
;536:void	Svcmd_ForceTeam_f( void ) {
line 541
;537:	gclient_t	*cl;
;538:	char		str[MAX_TOKEN_CHARS];
;539:
;540:	// find the player
;541:	trap_Argv( 1, str, sizeof( str ) );
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 542
;542:	cl = ClientForString( str );
ADDRLP4 0
ARGP4
ADDRLP4 1028
ADDRGP4 ClientForString
CALLP4
ASGNP4
ADDRLP4 1024
ADDRLP4 1028
INDIRP4
ASGNP4
line 543
;543:	if ( !cl ) {
ADDRLP4 1024
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $205
line 544
;544:		return;
ADDRGP4 $204
JUMPV
LABELV $205
line 548
;545:	}
;546:
;547:	// set the team
;548:	trap_Argv( 2, str, sizeof( str ) );
CNSTI4 2
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 549
;549:	SetTeam( &g_entities[cl - level.clients], str, qtrue );
CNSTI4 896
ADDRLP4 1024
INDIRP4
CVPU4 4
ADDRGP4 level
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 10828
DIVI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 SetTeam
CALLV
pop
line 550
;550:}
LABELV $204
endproc Svcmd_ForceTeam_f 1032 12
export Svcmd_mute_f
proc Svcmd_mute_f 1032 12
line 559
;551:
;552:/*
;553:===================
;554:Svcmd_mute_f
;555:
;556:mute <player>
;557:===================
;558:*/
;559:void Svcmd_mute_f( ) {
line 564
;560:	gclient_t	*cl;
;561:	char		str[MAX_TOKEN_CHARS];
;562:
;563:	// find the player
;564:	trap_Argv( 1, str, sizeof( str ) );
CNSTI4 1
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 565
;565:	cl = ClientForString( str );
ADDRLP4 4
ARGP4
ADDRLP4 1028
ADDRGP4 ClientForString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1028
INDIRP4
ASGNP4
line 566
;566:	if ( !cl ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $208
line 567
;567:		return;
ADDRGP4 $207
JUMPV
LABELV $208
line 570
;568:	}
;569:
;570:	cl->mutestatus = 1;
ADDRLP4 0
INDIRP4
CNSTI4 10816
ADDP4
CNSTI4 1
ASGNI4
line 571
;571:}
LABELV $207
endproc Svcmd_mute_f 1032 12
export Svcmd_unmute_f
proc Svcmd_unmute_f 1032 12
line 580
;572:
;573:/*
;574:===================
;575:Svcmd_unmute_f
;576:
;577:unmute <player>
;578:===================
;579:*/
;580:void Svcmd_unmute_f( ) {
line 585
;581:	gclient_t	*cl;
;582:	char		str[MAX_TOKEN_CHARS];
;583:
;584:	// find the player
;585:	trap_Argv( 1, str, sizeof( str ) );
CNSTI4 1
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 586
;586:	cl = ClientForString( str );
ADDRLP4 4
ARGP4
ADDRLP4 1028
ADDRGP4 ClientForString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1028
INDIRP4
ASGNP4
line 587
;587:	if ( !cl ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $211
line 588
;588:		return;
ADDRGP4 $210
JUMPV
LABELV $211
line 591
;589:	}
;590:
;591:	cl->mutestatus = 0;
ADDRLP4 0
INDIRP4
CNSTI4 10816
ADDP4
CNSTI4 0
ASGNI4
line 592
;592:}
LABELV $210
endproc Svcmd_unmute_f 1032 12
export Svcmd_addtask_f
proc Svcmd_addtask_f 3124 12
line 601
;593:
;594://char	*ConcatArgs( int start );
;595:
;596:/*
;597:==================
;598:Svcmd_addtask_f
;599:==================
;600:*/
;601:void Svcmd_addtask_f ( void ) {
line 609
;602:		//tasks_t		tasks;
;603:		char		arg[MAX_STRING_CHARS];
;604:		char		arg1[MAX_TOKEN_CHARS];
;605:		char		arg2[MAX_TOKEN_CHARS];
;606:	//	char		**command[1024];
;607:		int			taskNum;
;608:		int			i, c, len, tlen;
;609:		len = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 611
;610:
;611:		if ( trap_Argc() < 4 ) {
ADDRLP4 3092
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 3092
INDIRI4
CNSTI4 4
GEI4 $214
line 612
;612:			G_Printf("Usage: addtask <task num> <start time> <repeat time> <command>\n");
ADDRGP4 $216
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 613
;613:		}
LABELV $214
line 615
;614:		//This is a little bloat, not needed truely, but makes life slightly easier
;615:		trap_Argv( 1, arg1, sizeof( arg1 ) );
CNSTI4 1
ARGI4
ADDRLP4 2068
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 617
;616:
;617:		taskNum = atoi( arg1 );
ADDRLP4 2068
ARGP4
ADDRLP4 3096
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1036
ADDRLP4 3096
INDIRI4
ASGNI4
line 620
;618:		//G_Printf("Task: %i\n", taskNum);
;619:		//Is it a valid task number?
;620:		if ( taskNum < 0 || taskNum > (MAX_SERVER_TASKS - 1) ) {
ADDRLP4 1036
INDIRI4
CNSTI4 0
LTI4 $219
ADDRLP4 1036
INDIRI4
CNSTI4 15
LEI4 $217
LABELV $219
line 623
;621:			//If taskNum is less than 0 or greater than (MAX_SERVER_TASKS - 1)
;622:			//Return due to an invalid taskNum
;623:			return;
ADDRGP4 $213
JUMPV
LABELV $217
line 626
;624:		}
;625:
;626:		trap_Argv( 2, arg2, sizeof( arg2 ) );
CNSTI4 2
ARGI4
ADDRLP4 1044
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 627
;627:		if ( atoi(arg2) >= -1 ) {
ADDRLP4 1044
ARGP4
ADDRLP4 3104
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 3104
INDIRI4
CNSTI4 -1
LTI4 $220
line 628
;628:			tasks[taskNum].sv_task_startTime = level.time + (atoi(arg2) * 1000);
ADDRLP4 1044
ARGP4
ADDRLP4 3108
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTI4 396
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 tasks
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 1000
ADDRLP4 3108
INDIRI4
MULI4
ADDI4
ASGNI4
line 630
;629:			//Set the repeat interval for later use
;630:			trap_Argv( 3, arg2, sizeof( arg2 ) );
CNSTI4 3
ARGI4
ADDRLP4 1044
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 631
;631:			tasks[taskNum].sv_task_repeatTime = atoi( arg2 );
ADDRLP4 1044
ARGP4
ADDRLP4 3112
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTI4 396
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 tasks+8
ADDP4
ADDRLP4 3112
INDIRI4
ASGNI4
line 633
;632:			//G_Printf("Time: %i\n", tasks[taskNum].sv_task_repeatTime);
;633:			if ( tasks[taskNum].sv_task_repeatTime < 0 ) {
CNSTI4 396
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 tasks+8
ADDP4
INDIRI4
CNSTI4 0
GEI4 $224
line 635
;634:				//The repeat time is too low
;635:				tasks[taskNum].sv_task_repeatTime = 0;
CNSTI4 396
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 tasks+8
ADDP4
CNSTI4 0
ASGNI4
line 636
;636:				return;
ADDRGP4 $213
JUMPV
LABELV $224
line 640
;637:			}
;638:
;639:			//Set the next run time right away
;640:			tasks[taskNum].sv_task_runTime = level.time;
CNSTI4 396
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 tasks+4
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 642
;641:
;642:			c = trap_Argc();
ADDRLP4 3116
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 1040
ADDRLP4 3116
INDIRI4
ASGNI4
line 643
;643:			for ( i = 4 ; i < c ; i++ ) {
ADDRLP4 4
CNSTI4 4
ASGNI4
ADDRGP4 $233
JUMPV
LABELV $230
line 644
;644:				trap_Argv( i, arg, sizeof( arg ) );
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 645
;645:				tlen = strlen( arg );
ADDRLP4 8
ARGP4
ADDRLP4 3120
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1032
ADDRLP4 3120
INDIRI4
ASGNI4
line 646
;646:				if ( len + tlen >= MAX_STRING_CHARS - 1 ) {
ADDRLP4 0
INDIRI4
ADDRLP4 1032
INDIRI4
ADDI4
CNSTI4 1023
LTI4 $234
line 647
;647:					break;
ADDRGP4 $213
JUMPV
LABELV $234
line 649
;648:				}
;649:				memcpy( tasks[taskNum].sv_task_command + len, arg, tlen );
ADDRLP4 0
INDIRI4
CNSTI4 396
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 tasks+12
ADDP4
ADDP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 1032
INDIRI4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 650
;650:				len += tlen;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 1032
INDIRI4
ADDI4
ASGNI4
line 651
;651:				if ( i != c - 1 ) {
ADDRLP4 4
INDIRI4
ADDRLP4 1040
INDIRI4
CNSTI4 1
SUBI4
EQI4 $237
line 653
;652:					//This adds the space back into the char
;653:					tasks[taskNum].sv_task_command[len] = ' ';
ADDRLP4 0
INDIRI4
CNSTI4 396
ADDRLP4 1036
INDIRI4
MULI4
ADDRGP4 tasks+12
ADDP4
ADDP4
CNSTI1 32
ASGNI1
line 654
;654:					len++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 655
;655:				}
LABELV $237
line 656
;656:			}
LABELV $231
line 643
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $233
ADDRLP4 4
INDIRI4
ADDRLP4 1040
INDIRI4
LTI4 $230
line 657
;657:			return;
LABELV $220
line 659
;658:		}
;659:}
LABELV $213
endproc Svcmd_addtask_f 3124 12
export Svcmd_tasklist_f
proc Svcmd_tasklist_f 12 20
line 666
;660:
;661:/*
;662:==================
;663:Svcmd_tasklist_f
;664:==================
;665:*/
;666:void Svcmd_tasklist_f ( void ) {
line 669
;667:	int		i;
;668:
;669:	G_Printf("^7 TaskNum  StartTime  RepeatTime  Command\n");
ADDRGP4 $241
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 670
;670:	G_Printf("^7-----------------------------------------------------------------------\n");
ADDRGP4 $242
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 671
;671:	for(i = 0; i < MAX_SERVER_TASKS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $243
line 672
;672:		if ( tasks[i].sv_task_repeatTime > 0 ) {
CNSTI4 396
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 tasks+8
ADDP4
INDIRI4
CNSTI4 0
LEI4 $247
line 673
;673:			G_Printf("^7 %4i     %6i   %6i      %s\n", i, tasks[i].sv_task_startTime, tasks[i].sv_task_repeatTime, tasks[i].sv_task_command);
ADDRGP4 $250
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
CNSTI4 396
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 8
INDIRI4
ADDRGP4 tasks
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ADDRGP4 tasks+8
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ADDRGP4 tasks+12
ADDP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 674
;674:		}
LABELV $247
line 675
;675:	}
LABELV $244
line 671
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $243
line 676
;676:}
LABELV $240
endproc Svcmd_tasklist_f 12 20
export Svcmd_players_f
proc Svcmd_players_f 1224 44
line 683
;677:
;678:/*
;679:==================
;680:  Svcmd_players_f
;681:==================
;682:*/
;683:void Svcmd_players_f ( void ) {
line 684
;684:		int i, idnum, playercount = 0;
ADDRLP4 1168
CNSTI4 0
ASGNI4
line 688
;685:		int user_rate, user_snaps, /*user_timenudge,*/ user_maxfps, user_packetdup, user_maxpackets;
;686:		char *s, userinfo[MAX_INFO_STRING], playername[MAX_QPATH];
;687:		char buffer[32];
;688:		int	numColorCodesUsed = 0, ii = 0;
ADDRLP4 100
CNSTI4 0
ASGNI4
ADDRLP4 32
CNSTI4 0
ASGNI4
line 693
;689:		gclient_t *cl;
;690:		gentity_t *cl_ent;
;691:
;692:		//Start fetching data and print it to the console
;693:		G_Printf("\n^3 ID NAME            RATE  SNAPS  MAXFPS  PACKETDUP  MAXPACKETS  AIMTYPE\n");
ADDRGP4 $254
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 694
;694:		G_Printf("^3-----------------------------------------------------------------------------\n");
ADDRGP4 $255
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 695
;695:		for(i=0; i < level.numConnectedClients; i++ ) {
ADDRLP4 1136
CNSTI4 0
ASGNI4
ADDRGP4 $259
JUMPV
LABELV $256
line 697
;696:
;697:		idnum = level.sortedClients[i];
ADDRLP4 108
ADDRLP4 1136
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+124
ADDP4
INDIRI4
ASGNI4
line 698
;698:		cl = &level.clients[idnum]; 
ADDRLP4 1140
CNSTI4 10828
ADDRLP4 108
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 699
;699:		cl_ent = g_entities + idnum;	
ADDRLP4 1144
CNSTI4 896
ADDRLP4 108
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 701
;700:
;701:		if ( !( cl_ent->r.svFlags & SVF_BOT ) ) {
ADDRLP4 1144
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $262
line 703
;702:
;703:		++playercount;
ADDRLP4 1168
ADDRLP4 1168
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 705
;704:
;705:		trap_GetUserinfo( idnum, userinfo, sizeof(userinfo) );
ADDRLP4 108
INDIRI4
ARGI4
ADDRLP4 112
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 707
;706:
;707:		memset(&playername, 0, sizeof(playername));
ADDRLP4 36
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 708
;708:		numColorCodesUsed = FixedName(playername, cl->pers.netname, 15);//Fix names in console printing
ADDRLP4 36
ARGP4
ADDRLP4 1140
INDIRP4
CNSTI4 516
ADDP4
ARGP4
CNSTI4 15
ARGI4
ADDRLP4 1172
ADDRGP4 FixedName
CALLI4
ASGNI4
ADDRLP4 100
ADDRLP4 1172
INDIRI4
ASGNI4
line 709
;709:		memset(&buffer, 0, sizeof(buffer));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 32
ARGI4
ADDRGP4 memset
CALLP4
pop
line 710
;710:		for ( ii = 0; (strlen(playername)-(numColorCodesUsed*2))+strlen(buffer) < 14; ii++ ) {
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRGP4 $267
JUMPV
LABELV $264
line 711
;711:			buffer[ii] = ' ';
ADDRLP4 32
INDIRI4
ADDRLP4 0
ADDP4
CNSTI1 32
ASGNI1
line 712
;712:		}
LABELV $265
line 710
ADDRLP4 32
ADDRLP4 32
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $267
ADDRLP4 36
ARGP4
ADDRLP4 1176
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ARGP4
ADDRLP4 1180
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1176
INDIRI4
ADDRLP4 100
INDIRI4
CNSTI4 1
LSHI4
SUBI4
ADDRLP4 1180
INDIRI4
ADDI4
CNSTI4 14
LTI4 $264
line 714
;713:
;714:		s = Info_ValueForKey( userinfo, "rate" );//Get /rate
ADDRLP4 112
ARGP4
ADDRGP4 $268
ARGP4
ADDRLP4 1184
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 104
ADDRLP4 1184
INDIRP4
ASGNP4
line 715
;715:		user_rate = atoi(s);
ADDRLP4 104
INDIRP4
ARGP4
ADDRLP4 1188
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1148
ADDRLP4 1188
INDIRI4
ASGNI4
line 717
;716:
;717:		s = Info_ValueForKey( userinfo, "snaps" );//Get /snaps
ADDRLP4 112
ARGP4
ADDRGP4 $269
ARGP4
ADDRLP4 1192
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 104
ADDRLP4 1192
INDIRP4
ASGNP4
line 718
;718:		user_snaps = atoi(s);
ADDRLP4 104
INDIRP4
ARGP4
ADDRLP4 1196
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1152
ADDRLP4 1196
INDIRI4
ASGNI4
line 723
;719:
;720:		//s = Info_ValueForKey( userinfo, "cl_timeNudge" );//Get /cl_timenudge
;721:		//user_timenudge = atoi(s);
;722:
;723:		s = Info_ValueForKey( userinfo, "com_maxfps" );//Get /com_maxfps
ADDRLP4 112
ARGP4
ADDRGP4 $270
ARGP4
ADDRLP4 1200
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 104
ADDRLP4 1200
INDIRP4
ASGNP4
line 724
;724:		user_maxfps = atoi(s);
ADDRLP4 104
INDIRP4
ARGP4
ADDRLP4 1204
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1156
ADDRLP4 1204
INDIRI4
ASGNI4
line 726
;725:
;726:		s = Info_ValueForKey( userinfo, "cl_packetdup" );//Get /cl_packetdup
ADDRLP4 112
ARGP4
ADDRGP4 $271
ARGP4
ADDRLP4 1208
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 104
ADDRLP4 1208
INDIRP4
ASGNP4
line 727
;727:		user_packetdup = atoi(s);
ADDRLP4 104
INDIRP4
ARGP4
ADDRLP4 1212
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1160
ADDRLP4 1212
INDIRI4
ASGNI4
line 729
;728:
;729:		s = Info_ValueForKey( userinfo, "cl_maxpackets" );//Get /cl_maxpackets
ADDRLP4 112
ARGP4
ADDRGP4 $272
ARGP4
ADDRLP4 1216
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 104
ADDRLP4 1216
INDIRP4
ASGNP4
line 730
;730:		user_maxpackets = atoi(s);
ADDRLP4 104
INDIRP4
ARGP4
ADDRLP4 1220
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1164
ADDRLP4 1220
INDIRI4
ASGNI4
line 733
;731:		
;732:		//Print all the data for the client it was requested from.
;733:		G_Printf("^7%2i  %s%s"S_COLOR_WHITE" %5i%5i%7i%9i%13i%8i/%i\n", 
ADDRGP4 $273
ARGP4
ADDRLP4 108
INDIRI4
ARGI4
ADDRLP4 36
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 1148
INDIRI4
ARGI4
ADDRLP4 1152
INDIRI4
ARGI4
ADDRLP4 1156
INDIRI4
ARGI4
ADDRLP4 1160
INDIRI4
ARGI4
ADDRLP4 1164
INDIRI4
ARGI4
ADDRLP4 1140
INDIRP4
CNSTI4 10224
ADDP4
INDIRI4
ARGI4
ADDRGP4 g_delagHitscan+12
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 736
;734:		idnum, playername, buffer, user_rate, user_snaps, user_maxfps, user_packetdup, user_maxpackets, cl->sess.aimType, g_delagHitscan.integer);
;735:
;736:			}
LABELV $262
line 738
;737:
;738:		}
LABELV $257
line 695
ADDRLP4 1136
ADDRLP4 1136
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $259
ADDRLP4 1136
INDIRI4
ADDRGP4 level+120
INDIRU1
CVUI4 1
LTI4 $256
line 740
;739:		//Print the bottom of the table, and total number of players connected
;740:		G_Printf("^3---------------------------^7%3d ^3PLAYERS  -------------------------------\n", playercount);
ADDRGP4 $275
ARGP4
ADDRLP4 1168
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 743
;741:
;742:
;743:}
LABELV $253
endproc Svcmd_players_f 1224 44
export Svcmd_MapList_f
proc Svcmd_MapList_f 6824 16
line 752
;744:
;745:/*
;746:==================
;747:Svcmd_MapList_f
;748:
;749:Request list of maps on the server
;750:==================
;751:*/
;752:void Svcmd_MapList_f( void ) {
line 762
;753:	char		filelist[5120];// > 410+ maps will show at this setting
;754:	char		mapName[MAX_QPATH];
;755:	char		mapList[MAX_MAPLIST_SIZE];
;756:	char*		fileptr;
;757:	char		entry[512];
;758:	int			filelen, numfiles, mapCnt, entryLen, mapListLen, itemCnt;
;759:	char		filter[MAX_QPATH];
;760:	qboolean	filtering;
;761:
;762:	trap_Argv(1, filter, sizeof(filter));
CNSTI4 1
ARGI4
ADDRLP4 1608
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 763
;763:	filtering = ( filter && strlen(filter) > 0 );
ADDRLP4 1608
CVPU4 4
CNSTU4 0
EQU4 $278
ADDRLP4 1608
ARGP4
ADDRLP4 6796
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 6796
INDIRI4
CNSTI4 0
LEI4 $278
ADDRLP4 6792
CNSTI4 1
ASGNI4
ADDRGP4 $279
JUMPV
LABELV $278
ADDRLP4 6792
CNSTI4 0
ASGNI4
LABELV $279
ADDRLP4 1604
ADDRLP4 6792
INDIRI4
ASGNI4
line 765
;764:
;765:	numfiles = trap_FS_GetFileList( "maps", "bsp", filelist, sizeof(filelist) );
ADDRGP4 $280
ARGP4
ADDRGP4 $281
ARGP4
ADDRLP4 1672
ARGP4
CNSTI4 5120
ARGI4
ADDRLP4 6800
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 1600
ADDRLP4 6800
INDIRI4
ASGNI4
line 766
;766:	fileptr = filelist;
ADDRLP4 1516
ADDRLP4 1672
ASGNP4
line 767
;767:	mapCnt = 0;
ADDRLP4 1512
CNSTI4 0
ASGNI4
line 768
;768:	itemCnt = -1;
ADDRLP4 1584
CNSTI4 -1
ASGNI4
line 769
;769:	memset(entry, 0, sizeof(entry));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 512
ARGI4
ADDRGP4 memset
CALLP4
pop
line 770
;770:	strcpy(mapList, "print \"^3Maps:\n^1=====^7\n" );
ADDRLP4 512
ARGP4
ADDRGP4 $282
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 771
;771:	for (mapCnt=0; mapCnt<numfiles; mapCnt++, fileptr += filelen+1)
ADDRLP4 1512
CNSTI4 0
ASGNI4
ADDRGP4 $286
JUMPV
LABELV $283
line 772
;772:	{
line 773
;773:		filelen = strlen(fileptr);
ADDRLP4 1516
INDIRP4
ARGP4
ADDRLP4 6804
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1588
ADDRLP4 6804
INDIRI4
ASGNI4
line 774
;774:		COM_StripExtension(fileptr,mapName);
ADDRLP4 1516
INDIRP4
ARGP4
ADDRLP4 1520
ARGP4
ADDRGP4 COM_StripExtension
CALLV
pop
line 776
;775:
;776:		if( filtering ) {
ADDRLP4 1604
INDIRI4
CNSTI4 0
EQI4 $287
line 777
;777:			if( trap_StringContains(mapName, filter, 0) == -1 )
ADDRLP4 1520
ARGP4
ADDRLP4 1608
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 6808
ADDRGP4 trap_StringContains
CALLI4
ASGNI4
ADDRLP4 6808
INDIRI4
CNSTI4 -1
NEI4 $289
line 778
;778:			{
line 779
;779:				continue;
ADDRGP4 $284
JUMPV
LABELV $289
line 781
;780:			}
;781:		}
LABELV $287
line 783
;782:		
;783:		itemCnt++;
ADDRLP4 1584
ADDRLP4 1584
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 784
;784:		if( itemCnt % 3 < 2 ) {
ADDRLP4 1584
INDIRI4
CNSTI4 3
MODI4
CNSTI4 2
GEI4 $291
line 785
;785:			Q_strcat(entry, sizeof(entry), va("^3%d:^7%s^3, ", mapCnt, mapName));
ADDRGP4 $293
ARGP4
ADDRLP4 1512
INDIRI4
ARGI4
ADDRLP4 1520
ARGP4
ADDRLP4 6808
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
CNSTI4 512
ARGI4
ADDRLP4 6808
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 786
;786:			continue;
ADDRGP4 $284
JUMPV
LABELV $291
line 788
;787:		}
;788:		Q_strcat(entry, sizeof(entry), va("^3%d:^7%s\n", mapCnt, mapName));
ADDRGP4 $294
ARGP4
ADDRLP4 1512
INDIRI4
ARGI4
ADDRLP4 1520
ARGP4
ADDRLP4 6808
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
CNSTI4 512
ARGI4
ADDRLP4 6808
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 789
;789:		entryLen = strlen(entry);
ADDRLP4 0
ARGP4
ADDRLP4 6812
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1592
ADDRLP4 6812
INDIRI4
ASGNI4
line 790
;790:		mapListLen = strlen(mapList);
ADDRLP4 512
ARGP4
ADDRLP4 6816
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1596
ADDRLP4 6816
INDIRI4
ASGNI4
line 793
;791:		//-1: null term, -1: null term, +1: end quote, +1: null term
;792:		//if( (mapListLen -1) + (entryLen -1) +1 +1 < MAX_MAPLIST_SIZE )
;793:		if( (mapListLen + entryLen) < MAX_MAPLIST_SIZE - 4 )
ADDRLP4 1596
INDIRI4
ADDRLP4 1592
INDIRI4
ADDI4
CNSTI4 996
GEI4 $295
line 794
;794:		{
line 795
;795:			Q_strcat(mapList, sizeof(mapList), entry);
ADDRLP4 512
ARGP4
CNSTI4 1000
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 796
;796:		} else {
ADDRGP4 $296
JUMPV
LABELV $295
line 797
;797:			Q_strcat(mapList, sizeof(mapList), "\"\n");
ADDRLP4 512
ARGP4
CNSTI4 1000
ARGI4
ADDRGP4 $297
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 798
;798:			G_Printf("%s", mapList);
ADDRGP4 $181
ARGP4
ADDRLP4 512
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 799
;799:			mapList[0] = 0;
ADDRLP4 512
CNSTI1 0
ASGNI1
line 800
;800:			Q_strcat(mapList, sizeof(mapList), va("%s",entry));
ADDRGP4 $181
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 6820
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 512
ARGP4
CNSTI4 1000
ARGI4
ADDRLP4 6820
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 801
;801:		}
LABELV $296
line 802
;802:		entry[0] = 0;//clear out entry for next go round
ADDRLP4 0
CNSTI1 0
ASGNI1
line 803
;803:	}
LABELV $284
line 771
ADDRLP4 6804
CNSTI4 1
ASGNI4
ADDRLP4 1512
ADDRLP4 1512
INDIRI4
ADDRLP4 6804
INDIRI4
ADDI4
ASGNI4
ADDRLP4 1516
ADDRLP4 1588
INDIRI4
ADDRLP4 6804
INDIRI4
ADDI4
ADDRLP4 1516
INDIRP4
ADDP4
ASGNP4
LABELV $286
ADDRLP4 1512
INDIRI4
ADDRLP4 1600
INDIRI4
LTI4 $283
line 806
;804:	
;805:	//check to see if we have an entry that was never added to the maplist
;806:	if( itemCnt % 3 < 2 ) {
ADDRLP4 1584
INDIRI4
CNSTI4 3
MODI4
CNSTI4 2
GEI4 $298
line 808
;807:		int len;
;808:		Q_strcat(mapList, sizeof(mapList), entry);
ADDRLP4 512
ARGP4
CNSTI4 1000
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 810
;809:		//adjust the end of the maplist line to not have a trailing comma and space
;810:		len = strlen(mapList);
ADDRLP4 512
ARGP4
ADDRLP4 6812
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 6808
ADDRLP4 6812
INDIRI4
ASGNI4
line 811
;811:		mapList[len - 2] = '\n';
ADDRLP4 6808
INDIRI4
ADDRLP4 512-2
ADDP4
CNSTI1 10
ASGNI1
line 812
;812:		mapList[len - 1] = 0;
ADDRLP4 6808
INDIRI4
ADDRLP4 512-1
ADDP4
CNSTI1 0
ASGNI1
line 813
;813:	}
LABELV $298
line 817
;814:
;815:	//adjust numfiles as we were filtering, just in case this might be 
;816:	//extended at some point in the future
;817:	if( filtering ) {
ADDRLP4 1604
INDIRI4
CNSTI4 0
EQI4 $302
line 819
;818:		//adjust it for 1 because we use it as a counter above, not an actual "count"
;819:		numfiles = itemCnt + 1;
ADDRLP4 1600
ADDRLP4 1584
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 820
;820:	}
LABELV $302
line 822
;821:	//send the last mapList
;822:	if( numfiles > 0 ) {
ADDRLP4 1600
INDIRI4
CNSTI4 0
LEI4 $304
line 823
;823:		Q_strcat(mapList, sizeof(mapList), "\"\n");
ADDRLP4 512
ARGP4
CNSTI4 1000
ARGI4
ADDRGP4 $297
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 824
;824:		G_Printf("%s\n", mapList);
ADDRGP4 $306
ARGP4
ADDRLP4 512
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 825
;825:	}
LABELV $304
line 826
;826:}
LABELV $276
endproc Svcmd_MapList_f 6824 16
export Svcmd_Quickmodes_f
proc Svcmd_Quickmodes_f 1368 12
line 833
;827:
;828:/*
;829:=================
;830:Svcmd_Quickmodes_f
;831:=================
;832:*/
;833:void Svcmd_Quickmodes_f ( void ) {
line 837
;834:	char	modeList[MAX_QUICKMODE_LIST_SIZE];
;835:	char	arg1[64];
;836:
;837:	trap_Argv( 1, arg1, sizeof(arg1) );
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 839
;838:	
;839:	if ( !arg1[0] ) {
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $308
line 840
;840:		trap_Cvar_VariableStringBuffer( "__quickmodes", modeList, sizeof(modeList) );
ADDRGP4 $310
ARGP4
ADDRLP4 64
ARGP4
CNSTI4 1300
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 841
;841:		G_Printf("%s", modeList);
ADDRGP4 $181
ARGP4
ADDRLP4 64
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 842
;842:	} else {
ADDRGP4 $309
JUMPV
LABELV $308
line 843
;843:		trap_SendConsoleCommand( EXEC_NOW, va("exec config/quickmodes/%s.cfg \n", arg1) );
ADDRGP4 $311
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 1364
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 0
ARGI4
ADDRLP4 1364
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 844
;844:	}
LABELV $309
line 846
;845:
;846:}
LABELV $307
endproc Svcmd_Quickmodes_f 1368 12
export Svcmd_Teams_f
proc Svcmd_Teams_f 20 12
line 855
;847:/*
;848:==================
;849:Scvmd_Teams_f
;850:Primarily for debugging
;851:lock/unlock teams
;852:==================
;853:*/
;854://FIXME: It's redundant having duplicate commands on the server, even if one is client and the other isn't.
;855:void Svcmd_Teams_f( void ) {
line 856
;856:	G_Printf(""S_COLOR_YELLOW"Team  Count  Locked Status\n---------------------------\n" );
ADDRGP4 $313
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 857
;857:	if ( g_gametype.integer >= GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $314
line 858
;858:		G_Printf(""S_COLOR_YELLOW"Red   %3i      %5s\n",TeamCount(-1, TEAM_RED), (level.team_Locked[TEAM_RED]?("Locked"):("Unlocked")) );
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 4
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRGP4 $317
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 level+10864+4
INDIRI4
CNSTI4 0
EQI4 $323
ADDRLP4 0
ADDRGP4 $320
ASGNP4
ADDRGP4 $324
JUMPV
LABELV $323
ADDRLP4 0
ADDRGP4 $321
ASGNP4
LABELV $324
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 859
;859:		G_Printf(""S_COLOR_YELLOW"Blue  %3i      %5s\n",TeamCount(-1, TEAM_BLUE), (level.team_Locked[TEAM_BLUE]?("Locked"):("Unlocked")) );
CNSTI4 -1
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 12
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRGP4 $325
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 level+10864+8
INDIRI4
CNSTI4 0
EQI4 $329
ADDRLP4 8
ADDRGP4 $320
ASGNP4
ADDRGP4 $330
JUMPV
LABELV $329
ADDRLP4 8
ADDRGP4 $321
ASGNP4
LABELV $330
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 860
;860:		G_Printf(""S_COLOR_YELLOW"Spec  %3i\n",TeamCount(-1, TEAM_SPECTATOR) );
CNSTI4 -1
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 16
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRGP4 $331
ARGP4
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 861
;861:	} else {
ADDRGP4 $315
JUMPV
LABELV $314
line 862
;862:		G_Printf(""S_COLOR_YELLOW"Free  %3i      %5s\n",TeamCount(-1, TEAM_FREE), (level.team_Locked[TEAM_FREE]?("Locked"):("Unlocked")) );
CNSTI4 -1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRGP4 $332
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 level+10864
INDIRI4
CNSTI4 0
EQI4 $335
ADDRLP4 0
ADDRGP4 $320
ASGNP4
ADDRGP4 $336
JUMPV
LABELV $335
ADDRLP4 0
ADDRGP4 $321
ASGNP4
LABELV $336
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 863
;863:		G_Printf(""S_COLOR_YELLOW"Spec  %3i\n",TeamCount(-1, TEAM_SPECTATOR) );
CNSTI4 -1
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 8
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRGP4 $331
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 864
;864:	}
LABELV $315
line 865
;865:}
LABELV $312
endproc Svcmd_Teams_f 20 12
export Svcmd_lockteam_f
proc Svcmd_lockteam_f 1036 12
line 872
;866://FIXME: Locking and unlocking could be handled through the same function
;867:/*
;868:=================
;869:Svcmd_lockteam_f
;870:=================
;871:*/
;872:void Svcmd_lockteam_f ( void ) {
line 875
;873:	char		str[MAX_TOKEN_CHARS];
;874:
;875:	if (!g_allowLockedTeams.integer) {
ADDRGP4 g_allowLockedTeams+12
INDIRI4
CNSTI4 0
NEI4 $338
line 876
;876:		G_Printf("Not allowed to lockTeams\n");
ADDRGP4 $341
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 877
;877:		return;
ADDRGP4 $337
JUMPV
LABELV $338
line 881
;878:	}
;879:
;880:
;881:	trap_Argv( 1, str, sizeof( str ) );
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 883
;882:	//G_Printf("DBG: lockteam: %s\n", str);
;883:	if ( str[0] == 'b' || atoi(str) == TEAM_BLUE ) {
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 98
EQI4 $344
ADDRLP4 0
ARGP4
ADDRLP4 1024
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 2
NEI4 $342
LABELV $344
line 884
;884:		level.team_Locked[TEAM_BLUE] = qtrue;
ADDRGP4 level+10864+8
CNSTI4 1
ASGNI4
line 885
;885:	} else if ( str[0] == 'r' || atoi(str) == TEAM_RED ) {
ADDRGP4 $343
JUMPV
LABELV $342
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 114
EQI4 $349
ADDRLP4 0
ARGP4
ADDRLP4 1028
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 1
NEI4 $347
LABELV $349
line 886
;886:		level.team_Locked[TEAM_RED] = qtrue;
ADDRGP4 level+10864+4
CNSTI4 1
ASGNI4
line 887
;887:	} else if (str[0] == 'f' || atoi(str) == TEAM_FREE ) {
ADDRGP4 $348
JUMPV
LABELV $347
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 102
EQI4 $354
ADDRLP4 0
ARGP4
ADDRLP4 1032
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
NEI4 $352
LABELV $354
line 888
;888:		level.team_Locked[TEAM_FREE] = qtrue;
ADDRGP4 level+10864
CNSTI4 1
ASGNI4
line 889
;889:	} else {
ADDRGP4 $353
JUMPV
LABELV $352
line 890
;890:		G_Printf("Usage: lockTeam <team name>\n");
ADDRGP4 $356
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 891
;891:	}
LABELV $353
LABELV $348
LABELV $343
line 892
;892:}
LABELV $337
endproc Svcmd_lockteam_f 1036 12
export Svcmd_unlockteam_f
proc Svcmd_unlockteam_f 1036 12
line 899
;893:
;894:/*
;895:=================
;896:Svcmd_unlockteam_f
;897:=================
;898:*/
;899:void Svcmd_unlockteam_f ( void ) {
line 902
;900:	char		str[MAX_TOKEN_CHARS];
;901:
;902:		trap_Argv( 1, str, sizeof( str ) );
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 903
;903:		if ( str[0] == 'b' || atoi(str) == TEAM_BLUE ) {
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 98
EQI4 $360
ADDRLP4 0
ARGP4
ADDRLP4 1024
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 2
NEI4 $358
LABELV $360
line 904
;904:			level.team_Locked[TEAM_BLUE] = qfalse;
ADDRGP4 level+10864+8
CNSTI4 0
ASGNI4
line 905
;905:		} else if ( str[0] == 'r' || atoi(str) == TEAM_RED ) {
ADDRGP4 $359
JUMPV
LABELV $358
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 114
EQI4 $365
ADDRLP4 0
ARGP4
ADDRLP4 1028
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 1
NEI4 $363
LABELV $365
line 906
;906:			level.team_Locked[TEAM_RED] = qfalse;
ADDRGP4 level+10864+4
CNSTI4 0
ASGNI4
line 907
;907:		} else if (str[0] == 'f' || atoi(str) == TEAM_FREE ) {
ADDRGP4 $364
JUMPV
LABELV $363
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 102
EQI4 $370
ADDRLP4 0
ARGP4
ADDRLP4 1032
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
NEI4 $368
LABELV $370
line 908
;908:			level.team_Locked[TEAM_FREE] = qfalse;
ADDRGP4 level+10864
CNSTI4 0
ASGNI4
line 909
;909:		} else {
ADDRGP4 $369
JUMPV
LABELV $368
line 910
;910:			G_Printf("Usage: unlockTeam <team name>\n");
ADDRGP4 $372
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 911
;911:		}
LABELV $369
LABELV $364
LABELV $359
line 912
;912:}
LABELV $357
endproc Svcmd_unlockteam_f 1036 12
export Svcmd_AdjustGameSettings_f
proc Svcmd_AdjustGameSettings_f 28 12
ADDRFP4 0
ADDRFP4 0
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
ADDRFP4 4
ADDRFP4 4
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
ADDRFP4 8
ADDRFP4 8
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 922
;913:
;914:/*
;915:=================
;916:Svcmd_AdjustGameSettings_f
;917:
;918:This is here to eliminate all the trap_'s that were being used.
;919:The end result is less load to the server every time a shot is fired.
;920:=================
;921:*/
;922:void Svcmd_AdjustGameSettings_f ( byte gs_type, byte gs_wep_num, byte gs_setting_num, char *value, char *name ) {
line 923
;923:	int gs_setting_value = -1;//No values can have -1 because it's used to specify unset for now. -- Should be a qboolean
ADDRLP4 0
CNSTI4 -1
ASGNI4
line 925
;924:
;925:	if ( strlen(value) && trap_Argc() > 1) {
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $374
ADDRLP4 8
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 1
LEI4 $374
line 927
;926:		//G_Printf("dbg: %s %i -- %i %i", value, trap_Argc());
;927:		gs_setting_value = atoi(value);
ADDRFP4 12
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
line 928
;928:	}
LABELV $374
line 930
;929:
;930:	switch ( gs_type ) {
ADDRLP4 12
ADDRFP4 0
INDIRU1
CVUI4 1
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
LTI4 $376
ADDRLP4 12
INDIRI4
CNSTI4 4
GTI4 $376
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $429
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $429
address $379
address $409
address $414
address $419
address $424
code
LABELV $379
line 932
;931:		case GS_GLOBAL:
;932:			switch ( gs_setting_num ) {
ADDRLP4 20
ADDRFP4 8
INDIRU1
CVUI4 1
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
LTI4 $377
ADDRLP4 20
INDIRI4
CNSTI4 3
GTI4 $377
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $408
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $408
address $383
address $393
address $398
address $403
code
LABELV $383
line 934
;933:				case GS_ALLOW_TOSSFLAG:
;934:					if ( gs_setting_value < 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $384
line 935
;935:						G_Printf("%s is set to %i\n", name, gameSettings.allowTossflag);
ADDRGP4 $386
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 gameSettings+8
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 936
;936:					} else {
ADDRGP4 $377
JUMPV
LABELV $384
line 937
;937:						gs_setting_value == 0?(gameSettings.allowTossflag = qfalse):(gameSettings.allowTossflag = qtrue);
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $391
ADDRGP4 gameSettings+8
CNSTI4 0
ASGNI4
ADDRGP4 $392
JUMPV
LABELV $391
ADDRGP4 gameSettings+8
CNSTI4 1
ASGNI4
LABELV $392
line 938
;938:					}
line 939
;939:					break;
ADDRGP4 $377
JUMPV
LABELV $393
line 941
;940:				case GS_SPAWN_ARMOR:
;941:					if ( gs_setting_value < 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $394
line 942
;942:						G_Printf("%s is set to %i\n", name, gameSettings.spawn_armor);
ADDRGP4 $386
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 gameSettings+12
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 943
;943:					} else {
ADDRGP4 $377
JUMPV
LABELV $394
line 944
;944:						gameSettings.spawn_armor = gs_setting_value;
ADDRGP4 gameSettings+12
ADDRLP4 0
INDIRI4
ASGNI4
line 945
;945:					}
line 946
;946:					break;
ADDRGP4 $377
JUMPV
LABELV $398
line 948
;947:				case GS_SPAWN_HEALTH:
;948:					if ( gs_setting_value < 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $399
line 949
;949:						G_Printf("%s is set to %i\n", name, gameSettings.spawn_health);
ADDRGP4 $386
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 gameSettings+16
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 950
;950:					} else {
ADDRGP4 $377
JUMPV
LABELV $399
line 951
;951:						gameSettings.spawn_health = gs_setting_value;
ADDRGP4 gameSettings+16
ADDRLP4 0
INDIRI4
ASGNI4
line 952
;952:					}
line 953
;953:					break;
ADDRGP4 $377
JUMPV
LABELV $403
line 955
;954:				case GS_PING_FIX:
;955:					if ( gs_setting_value < 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $404
line 956
;956:						G_Printf("%s is set to %i\n", name, gameSettings.ping_fix);
ADDRGP4 $386
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 gameSettings+4
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 957
;957:					} else {
ADDRGP4 $377
JUMPV
LABELV $404
line 958
;958:						gameSettings.ping_fix = gs_setting_value;
ADDRGP4 gameSettings+4
ADDRLP4 0
INDIRI4
ASGNI4
line 960
;959:						//G_Printf(" %i\n",gameSettings.ping_fix);
;960:					}
line 961
;961:					break;
line 963
;962:			}
;963:			break;
ADDRGP4 $377
JUMPV
LABELV $409
line 965
;964:		case GS_MISSILE:
;965:			if ( gs_setting_num < 0 ) {
ADDRFP4 8
INDIRU1
CVUI4 1
CNSTI4 0
GEI4 $410
line 966
;966:				G_Printf("%s is set to %i\n", name, gameSettings.missiles[gs_wep_num][gs_setting_num]);
ADDRGP4 $386
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 8
INDIRU1
CVUI4 1
CNSTI4 2
LSHI4
CNSTI4 20
ADDRFP4 4
INDIRU1
CVUI4 1
MULI4
ADDRGP4 gameSettings+24
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 967
;967:			} else {
ADDRGP4 $377
JUMPV
LABELV $410
line 968
;968:				gameSettings.missiles[gs_wep_num][gs_setting_num] = gs_setting_value;
ADDRFP4 8
INDIRU1
CVUI4 1
CNSTI4 2
LSHI4
CNSTI4 20
ADDRFP4 4
INDIRU1
CVUI4 1
MULI4
ADDRGP4 gameSettings+24
ADDP4
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 969
;969:			}
line 970
;970:			break;
ADDRGP4 $377
JUMPV
LABELV $414
line 972
;971:		case GS_HITSCAN:
;972:			if ( gs_setting_value < 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $415
line 973
;973:				G_Printf("%s is set to %i\n", name, gameSettings.hitscans[gs_wep_num][gs_setting_num]);
ADDRGP4 $386
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 8
INDIRU1
CVUI4 1
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRU1
CVUI4 1
CNSTI4 3
LSHI4
ADDRGP4 gameSettings+104
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 974
;974:			} else {
ADDRGP4 $377
JUMPV
LABELV $415
line 975
;975:				gameSettings.hitscans[gs_wep_num][gs_setting_num] = gs_setting_value;
ADDRFP4 8
INDIRU1
CVUI4 1
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRU1
CVUI4 1
CNSTI4 3
LSHI4
ADDRGP4 gameSettings+104
ADDP4
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 976
;976:			}
line 977
;977:			break;
ADDRGP4 $377
JUMPV
LABELV $419
line 979
;978:		case GS_POWERUPS:
;979:			if ( gs_setting_value < 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $420
line 980
;980:				G_Printf("%s is set to %i\n", name, gameSettings.quadfactor_radius);
ADDRGP4 $386
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 gameSettings+144
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 981
;981:			} else {
ADDRGP4 $377
JUMPV
LABELV $420
line 982
;982:				gameSettings.quadfactor_radius = gs_setting_value;
ADDRGP4 gameSettings+144
ADDRLP4 0
INDIRI4
ASGNI4
line 983
;983:			}
line 984
;984:			break;
ADDRGP4 $377
JUMPV
LABELV $424
line 986
;985:		case GS_HOOK_SPEED:
;986:			if ( gs_setting_value < 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $425
line 987
;987:				G_Printf("%s is set to %i\n", name, gameSettings.hook_speed);
ADDRGP4 $386
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 gameSettings+20
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 988
;988:			} else {
ADDRGP4 $377
JUMPV
LABELV $425
line 989
;989:				gameSettings.hook_speed = gs_setting_value;
ADDRGP4 gameSettings+20
ADDRLP4 0
INDIRI4
ASGNI4
line 990
;990:			}
line 991
;991:			break;
LABELV $376
LABELV $377
line 993
;992:	}
;993:}
LABELV $373
endproc Svcmd_AdjustGameSettings_f 28 12
export Svcmd_Help_f
proc Svcmd_Help_f 17124 12
line 1002
;994:
;995:/*
;996:=================
;997:Help
;998:=================
;999:*/
;1000:
;1001:void Svcmd_Help_f(void)
;1002:{
line 1004
;1003://	char			*text_p, *prev;
;1004:	int				length = 0;//, linelength = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1019
;1005://	int				j = 0, m = 0, l = 0, k = 0;
;1006://	char			*line;
;1007://	char			explanation[256];
;1008://	char			checkChar[128];
;1009:	char			text[MAX_HELP_FILE_SIZE];
;1010:	char			filename[MAX_QPATH];
;1011:	char			arg1[128];
;1012:	char			tmp[513];
;1013:	char			*token, *ptr;
;1014://	qboolean		helpList = qfalse;
;1015://	char			newLine[32];
;1016:	fileHandle_t	f;
;1017:	int				i;
;1018:
;1019:	trap_Argv(1, arg1, sizeof(arg1));
CNSTI4 1
ARGI4
ADDRLP4 528
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1021
;1020:
;1021:	Com_sprintf(filename, sizeof(filename), "config/help/server/en.help.cfg");
ADDRLP4 17040
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $431
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1023
;1022:
;1023:	if((length = trap_FS_FOpenFile(filename, &f, FS_READ)) <= 0)
ADDRLP4 17040
ARGP4
ADDRLP4 17104
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 17112
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 17112
INDIRI4
ASGNI4
ADDRLP4 17112
INDIRI4
CNSTI4 0
GTI4 $432
line 1024
;1024:	{
line 1025
;1025:		Com_Printf(""S_COLOR_RED"Loading en.help.cfg failed! Failed to open the file\n");
ADDRGP4 $434
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1026
;1026:		return;
ADDRGP4 $430
JUMPV
LABELV $432
line 1029
;1027:	}
;1028:
;1029:	if(length >= MAX_HELP_FILE_SIZE)
ADDRLP4 0
INDIRI4
CNSTI4 16384
LTI4 $435
line 1030
;1030:	{
line 1031
;1031:		Com_Printf(""S_COLOR_RED"Loading en.help.cfg failed! File too large\n");
ADDRGP4 $437
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1032
;1032:		return;
ADDRGP4 $430
JUMPV
LABELV $435
line 1035
;1033:	}
;1034:
;1035:	trap_FS_Read(text, length, f);
ADDRLP4 656
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 17104
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 1036
;1036:	text[length] = '\0';
ADDRLP4 0
INDIRI4
ADDRLP4 656
ADDP4
CNSTI1 0
ASGNI1
line 1037
;1037:	trap_FS_FCloseFile(f);
ADDRLP4 17104
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 1039
;1038:
;1039:	if(!arg1[0])
ADDRLP4 528
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $438
line 1040
;1040:	{
line 1042
;1041:		//list all the available help commands
;1042:		if(!(token = HelpParse(arg1, text, qtrue)))
ADDRLP4 528
ARGP4
ADDRLP4 656
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 17116
ADDRGP4 HelpParse
CALLP4
ASGNP4
ADDRLP4 17108
ADDRLP4 17116
INDIRP4
ASGNP4
ADDRLP4 17116
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $440
line 1043
;1043:		{
line 1044
;1044:			Com_Printf(""S_COLOR_RED"ERROR: Failed to read the help file\n", arg1);
ADDRGP4 $442
ARGP4
ADDRLP4 528
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1045
;1045:			return;
ADDRGP4 $430
JUMPV
LABELV $440
line 1048
;1046:		}
;1047:
;1048:		length = strlen(token);
ADDRLP4 17108
INDIRP4
ARGP4
ADDRLP4 17120
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 17120
INDIRI4
ASGNI4
line 1049
;1049:		if(length > 512)
ADDRLP4 0
INDIRI4
CNSTI4 512
LEI4 $443
line 1050
;1050:		{
line 1053
;1051:			//Com_Printf seems to have a limit to the length of a string that can be output
;1052:			//so we play it safe and break the output into 512 character chunks
;1053:			Com_Printf(""S_COLOR_CYAN"The following commands/cvars are available:\n");
ADDRGP4 $445
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1054
;1054:			ptr = token;
ADDRLP4 524
ADDRLP4 17108
INDIRP4
ASGNP4
line 1055
;1055:			for(i = 0; i < (length / 512); i++)
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $449
JUMPV
LABELV $446
line 1056
;1056:			{
line 1057
;1057:				if(i != ((length / 512) - 1))
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 512
DIVI4
CNSTI4 1
SUBI4
EQI4 $450
line 1058
;1058:				{
line 1059
;1059:					memcpy(tmp, ptr, 512);
ADDRLP4 8
ARGP4
ADDRLP4 524
INDIRP4
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1060
;1060:					tmp[512] = '\0';
ADDRLP4 8+512
CNSTI1 0
ASGNI1
line 1061
;1061:				}
ADDRGP4 $451
JUMPV
LABELV $450
line 1063
;1062:				else
;1063:				{
line 1064
;1064:					memcpy(tmp, ptr, length - (i * 512));
ADDRLP4 8
ARGP4
ADDRLP4 524
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 9
LSHI4
SUBI4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1065
;1065:					tmp[length - (i * 512)] = '\0';
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 9
LSHI4
SUBI4
ADDRLP4 8
ADDP4
CNSTI1 0
ASGNI1
line 1066
;1066:				}
LABELV $451
line 1068
;1067:
;1068:				Com_Printf(""S_COLOR_CYAN"%s", tmp);
ADDRGP4 $453
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1069
;1069:				ptr += 512;
ADDRLP4 524
ADDRLP4 524
INDIRP4
CNSTI4 512
ADDP4
ASGNP4
line 1070
;1070:			}
LABELV $447
line 1055
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $449
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 512
DIVI4
LTI4 $446
line 1072
;1071:
;1072:			Com_Printf("\n");
ADDRGP4 $182
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1073
;1073:		}
ADDRGP4 $444
JUMPV
LABELV $443
line 1075
;1074:		else
;1075:			Com_Printf(""S_COLOR_CYAN"The following commands/cvars are available:\n%s\n", token);
ADDRGP4 $454
ARGP4
ADDRLP4 17108
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
LABELV $444
line 1077
;1076:
;1077:		Com_Printf(""S_COLOR_CYAN"\n%s %s\n", GAMEVERSION, BUILDINFO);
ADDRGP4 $455
ARGP4
ADDRGP4 $456
ARGP4
ADDRGP4 $457
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1078
;1078:		Com_Printf(""S_COLOR_CYAN"Usage: \\help command \n");
ADDRGP4 $458
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1079
;1079:	}
ADDRGP4 $439
JUMPV
LABELV $438
line 1081
;1080:	else
;1081:	{
line 1083
;1082:		//list only the specified help command
;1083:		if(!(token = HelpParse(arg1, text, qfalse)))
ADDRLP4 528
ARGP4
ADDRLP4 656
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 17116
ADDRGP4 HelpParse
CALLP4
ASGNP4
ADDRLP4 17108
ADDRLP4 17116
INDIRP4
ASGNP4
ADDRLP4 17116
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $459
line 1084
;1084:		{
line 1085
;1085:			Com_Printf(""S_COLOR_RED"ERROR: Command %s not found\n", arg1);
ADDRGP4 $461
ARGP4
ADDRLP4 528
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1086
;1086:			return;
ADDRGP4 $430
JUMPV
LABELV $459
line 1089
;1087:		}
;1088:
;1089:		Com_Printf(""S_COLOR_CYAN"%s\n", token);
ADDRGP4 $462
ARGP4
ADDRLP4 17108
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1090
;1090:	}
LABELV $439
line 1223
;1091:
;1092:#if 0
;1093:		char		*text_p, *prev;
;1094:		int			length = 0, linelength = 0;
;1095:		int			j = 0, m = 0, l = 0, k = 0;
;1096:		char		*line;
;1097:		char		explanation[256];
;1098:		char		checkChar[128];
;1099:		char		text[20000];
;1100:		char		filename[MAX_QPATH];
;1101:		char		arg1[128];
;1102:		char		*token;
;1103:		qboolean	helpList = qfalse;
;1104:		char		newLine[32];
;1105:
;1106:		fileHandle_t	f;
;1107:
;1108:		trap_Argv( 1, arg1, sizeof(arg1));
;1109:
;1110:		Com_sprintf(filename, sizeof(filename), "config/help/server/en.help.cfg");
;1111:
;1112:		length = trap_FS_FOpenFile( filename, &f, FS_READ );
;1113:		if ( length <= 0 ) {
;1114:			return;
;1115:		}
;1116:
;1117:		trap_FS_Read( text, length, f );
;1118:		text[length] = 0;
;1119:		trap_FS_FCloseFile( f );
;1120:		//memset(&print, 0, sizeof(print));
;1121:		memset(&explanation, 0, sizeof(explanation));
;1122:		text_p = text;
;1123:			
;1124:		if ( strlen(arg1) == 0 && !( Q_stricmp(arg1, "help_list") == 0 ) ) {
;1125:			token = stristr(text_p, "help_list");
;1126:			helpList = qtrue;
;1127:		} else {
;1128:			token = stristr(text_p, arg1);	
;1129:		}
;1130:		
;1131:		if ( !helpList ) {
;1132:			Com_sprintf(explanation, sizeof(explanation), HelpParse(token));
;1133:			if ( strlen(explanation) < 3 ) {//No possible way this could be valid
;1134:				memset(explanation, 0, sizeof(explanation) );
;1135:				//Com_sprintf(explanation, sizeof(explanation), HelpParse("help_list"));
;1136:				token = stristr(text_p, "help_list");
;1137:				helpList = qtrue;
;1138:				G_Printf(""S_COLOR_RED"ERROR: Command %s not found.\n", arg1);
;1139:			}
;1140:		} /*else*/
;1141:		if ( helpList ) {
;1142:			qboolean	insertNewline = qfalse;
;1143:			qboolean	foundStart = qfalse;
;1144:			qboolean	foundEnd = qfalse;
;1145:			qboolean	start = qfalse;
;1146:
;1147:			while ( 1 ) {
;1148:				prev = text_p; //so we can unget
;1149:				line = COM_Parse(&token);
;1150:
;1151:
;1152:				if ( (line[j - 1] == '{' || line[0] == '{') && !foundStart ) {
;1153:					foundStart = qtrue;
;1154:				}
;1155:
;1156:				if ( foundStart ) {//This is consuming, but safe-ish
;1157:					memset(&checkChar, 0, sizeof(checkChar));
;1158:					Com_sprintf(checkChar, sizeof(checkChar), line );
;1159:					for ( l = 0; l != strlen(checkChar); l++ ) {
;1160:						if ( checkChar[l] == '}' ) {
;1161:							foundEnd = qtrue; //Use this to break the while loop
;1162:							break;//break this loop, no need to continue
;1163:						}
;1164:					}
;1165:				}
;1166:
;1167:				if ( foundEnd ) {
;1168:					break;
;1169:				}
;1170:
;1171:				if ( start ) {
;1172:					//This is a very good example of laziness
;1173:					//FixedName to align things, then point line to it..
;1174:					if ( m < 2 ) {
;1175:						m++;
;1176:						FixedName( newLine, line, 26 );
;1177:						line = newLine;//Re-pointer to avoid changing a bunch of code.
;1178:					} else {
;1179:						m = 0;
;1180:						insertNewline = qtrue;
;1181:					}
;1182:					j = strlen(newLine);
;1183:
;1184:					if ( linelength + j > 1024 ) {
;1185:						//This voids the string limit to make sure all the columns get lined up.
;1186:						//Not exactly safe, careful for endless loops
;1187:						G_Printf("%s", explanation);
;1188:						memset(&explanation, 0, sizeof(explanation));
;1189:						linelength = 0;
;1190:					}
;1191:					linelength += j;
;1192:					Q_strcat(explanation, sizeof(explanation), va("%s", line));
;1193:
;1194:					if ( insertNewline ) {
;1195:						k++;
;1196:						insertNewline = qfalse;
;1197:					//	linelength++;
;1198:					//	Q_strcat(explanation, sizeof(explanation), " ");
;1199:					//	linelength++;
;1200:					//	explanation[linelength] = '\n';
;1201:						/* Trying this */
;1202:						//Ideally we should do this, print every time we want a new line
;1203:						//for some reason it'd only add a new line 5 times, then stop.
;1204:						//This works around that.
;1205:						G_Printf("%s\n", explanation);
;1206:						memset(&explanation, 0, sizeof(explanation));
;1207:						linelength = 0;
;1208:					}
;1209:
;1210:				}
;1211:
;1212:				if ( foundStart && !start ) {
;1213:					start = qtrue;
;1214:				}
;1215:			}
;1216:		}
;1217:		
;1218:		G_Printf("%s\n", explanation);
;1219:		if ( helpList ) {
;1220:			G_Printf("\n %s %s\n", GAMEVERSION, BUILDINFO);
;1221:		}
;1222:#endif
;1223:}
LABELV $430
endproc Svcmd_Help_f 17124 12
lit
align 1
LABELV $568
byte 1 48
byte 1 0
skip 1022
export ConsoleCommand
code
proc ConsoleCommand 3328 20
line 1250
;1224:
;1225:/*
;1226:void Svcmd_ForceFlagSpawn_f( void ) {
;1227:	int i = 0;
;1228:	int j = 0;
;1229:
;1230:	for ( i = 0; i < MAX_GENTITIES; i++ ) {
;1231:		if ( level.gentities[i].item && level.gentities[i].item->giType == IT_TEAM && level.gentities[i].item->giTag == PW_BLUEFLAG ) {
;1232:			j = i;
;1233:			break;
;1234:		}
;1235:	}
;1236:
;1237:	//if ( !G_CallSpawn( &level.gentities[i] ) ) {
;1238:	//	G_FreeEntity( &level.gentities[i] );
;1239:	//}
;1240:	level.gentities[i].s.eFlags & ~EF_NODRAW;
;1241:}*/
;1242:
;1243:
;1244:/*
;1245:=================
;1246:ConsoleCommand
;1247:
;1248:=================
;1249:*/
;1250:qboolean	ConsoleCommand( void ) {
line 1253
;1251:	char	cmd[MAX_TOKEN_CHARS];
;1252:
;1253:	trap_Argv( 0, cmd, sizeof( cmd ) );
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1255
;1254:
;1255:	if ( Q_stricmp (cmd, "entitylist") == 0 ) {
ADDRLP4 0
ARGP4
ADDRGP4 $466
ARGP4
ADDRLP4 1024
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 0
NEI4 $464
line 1256
;1256:		Svcmd_EntityList_f();
ADDRGP4 Svcmd_EntityList_f
CALLV
pop
line 1257
;1257:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $464
line 1260
;1258:	}
;1259:
;1260:	if ( Q_stricmp (cmd, "forceteam") == 0 ) {
ADDRLP4 0
ARGP4
ADDRGP4 $469
ARGP4
ADDRLP4 1028
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 0
NEI4 $467
line 1261
;1261:		Svcmd_ForceTeam_f();
ADDRGP4 Svcmd_ForceTeam_f
CALLV
pop
line 1262
;1262:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $467
line 1265
;1263:	}
;1264:
;1265:	if (Q_stricmp (cmd, "game_memory") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $472
ARGP4
ADDRLP4 1032
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
NEI4 $470
line 1266
;1266:		Svcmd_GameMem_f();
ADDRGP4 Svcmd_GameMem_f
CALLV
pop
line 1267
;1267:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $470
line 1270
;1268:	}
;1269:
;1270:	if (Q_stricmp (cmd, "addbot") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $475
ARGP4
ADDRLP4 1036
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $473
line 1271
;1271:		Svcmd_AddBot_f();
ADDRGP4 Svcmd_AddBot_f
CALLV
pop
line 1272
;1272:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $473
line 1275
;1273:	}
;1274:
;1275:	if (Q_stricmp (cmd, "botlist") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $478
ARGP4
ADDRLP4 1040
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $476
line 1276
;1276:		Svcmd_BotList_f();
ADDRGP4 Svcmd_BotList_f
CALLV
pop
line 1277
;1277:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $476
line 1280
;1278:	}
;1279:
;1280:	if (Q_stricmp (cmd, "abort_podium") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $481
ARGP4
ADDRLP4 1044
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $479
line 1281
;1281:		Svcmd_AbortPodium_f();
ADDRGP4 Svcmd_AbortPodium_f
CALLV
pop
line 1282
;1282:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $479
line 1300
;1283:	}
;1284:/*
;1285:	if (Q_stricmp (cmd, "addip") == 0) {
;1286:		Svcmd_AddIP_f();
;1287:		return qtrue;
;1288:	}
;1289:
;1290:	if (Q_stricmp (cmd, "removeip") == 0) {
;1291:		Svcmd_RemoveIP_f();
;1292:		return qtrue;
;1293:	}
;1294:
;1295:	if (Q_stricmp (cmd, "listip") == 0) {
;1296:		trap_SendConsoleCommand( EXEC_NOW, "g_banIPs\n" );
;1297:		return qtrue;
;1298:	}
;1299:*/
;1300:	if (Q_stricmp (cmd, "banip") == 0 || Q_stricmp (cmd, "addip") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $484
ARGP4
ADDRLP4 1048
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
EQI4 $486
ADDRLP4 0
ARGP4
ADDRGP4 $485
ARGP4
ADDRLP4 1052
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
NEI4 $482
LABELV $486
line 1301
;1301:		Svcmd_BanIP_f(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 Svcmd_BanIP_f
CALLV
pop
line 1302
;1302:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $482
line 1305
;1303:	}
;1304:
;1305:	if (Q_stricmp (cmd, "unbanip") == 0 || Q_stricmp (cmd, "removeip") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $489
ARGP4
ADDRLP4 1056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
EQI4 $491
ADDRLP4 0
ARGP4
ADDRGP4 $490
ARGP4
ADDRLP4 1060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
NEI4 $487
LABELV $491
line 1306
;1306:		Svcmd_BanIP_f(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 Svcmd_BanIP_f
CALLV
pop
line 1307
;1307:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $487
line 1310
;1308:	}
;1309:
;1310:	if (Q_stricmp (cmd, "listbanips") == 0 || Q_stricmp (cmd, "listip") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $494
ARGP4
ADDRLP4 1064
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 0
EQI4 $496
ADDRLP4 0
ARGP4
ADDRGP4 $495
ARGP4
ADDRLP4 1068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1068
INDIRI4
CNSTI4 0
NEI4 $492
LABELV $496
line 1311
;1311:		Svcmd_ListBanIP_f();
ADDRGP4 Svcmd_ListBanIP_f
CALLV
pop
line 1312
;1312:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $492
line 1315
;1313:	}
;1314:
;1315:	if (Q_stricmp (cmd, "writeban") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $499
ARGP4
ADDRLP4 1072
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1072
INDIRI4
CNSTI4 0
NEI4 $497
line 1316
;1316:		G_WriteBans();
ADDRGP4 G_WriteBans
CALLV
pop
line 1317
;1317:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $497
line 1320
;1318:	}
;1319:
;1320:	if (Q_stricmp (cmd, "players") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $502
ARGP4
ADDRLP4 1076
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1076
INDIRI4
CNSTI4 0
NEI4 $500
line 1321
;1321:		Svcmd_players_f();
ADDRGP4 Svcmd_players_f
CALLV
pop
line 1322
;1322:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $500
line 1325
;1323:	}
;1324:
;1325:	if (Q_stricmp (cmd, "timeout") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $505
ARGP4
ADDRLP4 1080
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1080
INDIRI4
CNSTI4 0
NEI4 $503
line 1328
;1326:		char		str[MAX_TOKEN_CHARS];
;1327:
;1328:		trap_Argv( 1, str, sizeof( str ) );
CNSTI4 1
ARGI4
ADDRLP4 1084
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1329
;1329:		level.match_time = atoi(str);
ADDRLP4 1084
ARGP4
ADDRLP4 2108
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 level+10832
ADDRLP4 2108
INDIRI4
ASGNI4
line 1330
;1330:		if ( level.match_time == 0 ) {
ADDRGP4 level+10832
INDIRI4
CNSTI4 0
NEI4 $507
line 1331
;1331:			level.match_time = g_timeOutLength.integer;
ADDRGP4 level+10832
ADDRGP4 g_timeOutLength+12
INDIRI4
ASGNI4
line 1332
;1332:		}
LABELV $507
line 1333
;1333:		Cmd_Timeout_f(level.match_time);
ADDRGP4 level+10832
INDIRI4
ARGI4
ADDRGP4 Cmd_Timeout_f
CALLV
pop
line 1334
;1334:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $503
line 1337
;1335:	}
;1336:
;1337:	if (Q_stricmp (cmd, "timein") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $515
ARGP4
ADDRLP4 1084
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1084
INDIRI4
CNSTI4 0
NEI4 $513
line 1340
;1338:		char		str[MAX_TOKEN_CHARS];
;1339:
;1340:		trap_Argv( 1, str, sizeof( str ) );
CNSTI4 1
ARGI4
ADDRLP4 1088
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1341
;1341:		level.match_time = atoi(str);
ADDRLP4 1088
ARGP4
ADDRLP4 2112
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 level+10832
ADDRLP4 2112
INDIRI4
ASGNI4
line 1342
;1342:		if ( level.match_time == 0 ) {
ADDRGP4 level+10832
INDIRI4
CNSTI4 0
NEI4 $517
line 1343
;1343:			level.match_time = g_timeInGrace.integer;
ADDRGP4 level+10832
ADDRGP4 g_timeInGrace+12
INDIRI4
ASGNI4
line 1344
;1344:		}
LABELV $517
line 1345
;1345:		Cmd_Timein_f(level.match_time);
ADDRGP4 level+10832
INDIRI4
ARGI4
ADDRGP4 Cmd_Timein_f
CALLV
pop
line 1346
;1346:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $513
line 1349
;1347:	}
;1348:
;1349:	if ( Q_stricmp (cmd, "lockteam") == 0 || Q_stricmp (cmd, "lock") == 0  ) {
ADDRLP4 0
ARGP4
ADDRGP4 $525
ARGP4
ADDRLP4 1088
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1088
INDIRI4
CNSTI4 0
EQI4 $527
ADDRLP4 0
ARGP4
ADDRGP4 $526
ARGP4
ADDRLP4 1092
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1092
INDIRI4
CNSTI4 0
NEI4 $523
LABELV $527
line 1350
;1350:		Svcmd_lockteam_f();
ADDRGP4 Svcmd_lockteam_f
CALLV
pop
line 1351
;1351:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $523
line 1354
;1352:	}
;1353:
;1354:	if ( Q_stricmp (cmd, "unlockteam") == 0 || Q_stricmp (cmd, "unlock") == 0 ) {
ADDRLP4 0
ARGP4
ADDRGP4 $530
ARGP4
ADDRLP4 1096
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1096
INDIRI4
CNSTI4 0
EQI4 $532
ADDRLP4 0
ARGP4
ADDRGP4 $531
ARGP4
ADDRLP4 1100
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1100
INDIRI4
CNSTI4 0
NEI4 $528
LABELV $532
line 1355
;1355:		Svcmd_unlockteam_f();
ADDRGP4 Svcmd_unlockteam_f
CALLV
pop
line 1356
;1356:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $528
line 1359
;1357:	}
;1358:
;1359:	if ( Q_stricmp (cmd, "addtask") == 0 ) {
ADDRLP4 0
ARGP4
ADDRGP4 $535
ARGP4
ADDRLP4 1104
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1104
INDIRI4
CNSTI4 0
NEI4 $533
line 1360
;1360:		G_LogPrintf( "Time: %i -- %s\n", level.time, ConcatArgs(0) );
CNSTI4 0
ARGI4
ADDRLP4 1108
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
ADDRGP4 $536
ARGP4
ADDRGP4 level+40
INDIRI4
ARGI4
ADDRLP4 1108
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1361
;1361:		Svcmd_addtask_f();
ADDRGP4 Svcmd_addtask_f
CALLV
pop
line 1362
;1362:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $533
line 1365
;1363:	}
;1364:
;1365:	if ( Q_stricmp (cmd, "removetask") == 0 ) {
ADDRLP4 0
ARGP4
ADDRGP4 $540
ARGP4
ADDRLP4 1108
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1108
INDIRI4
CNSTI4 0
NEI4 $538
line 1368
;1366:		char		str[MAX_TOKEN_CHARS];
;1367:		int			taskNum;
;1368:		G_LogPrintf( "Time: %i -- %s\n", level.time, ConcatArgs(0) );
CNSTI4 0
ARGI4
ADDRLP4 2140
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
ADDRGP4 $536
ARGP4
ADDRGP4 level+40
INDIRI4
ARGI4
ADDRLP4 2140
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1369
;1369:		trap_Argv(1, str, sizeof(str));
CNSTI4 1
ARGI4
ADDRLP4 1116
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1370
;1370:		if ( Q_stricmp ( str, "all" ) == 0 ) {
ADDRLP4 1116
ARGP4
ADDRGP4 $544
ARGP4
ADDRLP4 2144
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2144
INDIRI4
CNSTI4 0
NEI4 $542
line 1371
;1371:			memset(&tasks, 0, sizeof(&tasks));
ADDRGP4 tasks
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1372
;1372:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $542
line 1374
;1373:		}
;1374:		taskNum = atoi(str);
ADDRLP4 1116
ARGP4
ADDRLP4 2148
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1112
ADDRLP4 2148
INDIRI4
ASGNI4
line 1375
;1375:		if ( taskNum < 0 || taskNum > (MAX_SERVER_TASKS - 1) ) {
ADDRLP4 2152
ADDRLP4 1112
INDIRI4
ASGNI4
ADDRLP4 2152
INDIRI4
CNSTI4 0
LTI4 $547
ADDRLP4 2152
INDIRI4
CNSTI4 15
LEI4 $545
LABELV $547
line 1376
;1376:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $463
JUMPV
LABELV $545
line 1378
;1377:		}
;1378:		memset( &(tasks[taskNum]), 0, sizeof(tasks[taskNum]) );
ADDRLP4 2156
CNSTI4 396
ASGNI4
ADDRLP4 2156
INDIRI4
ADDRLP4 1112
INDIRI4
MULI4
ADDRGP4 tasks
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 2156
INDIRI4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1379
;1379:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $538
line 1382
;1380:	}
;1381:
;1382:	if ( Q_stricmp ( cmd, "removealltasks") == 0 ) {
ADDRLP4 0
ARGP4
ADDRGP4 $550
ARGP4
ADDRLP4 1112
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1112
INDIRI4
CNSTI4 0
NEI4 $548
line 1383
;1383:		memset(&tasks, 0 ,sizeof(&tasks));
ADDRGP4 tasks
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1384
;1384:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $548
line 1388
;1385:	}
;1386:
;1387:	//monkk
;1388:	if (Q_stricmp (cmd, "mapnum") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $553
ARGP4
ADDRLP4 1116
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1116
INDIRI4
CNSTI4 0
NEI4 $551
line 1389
;1389:		Svcmd_MapNum_f();
ADDRGP4 Svcmd_MapNum_f
CALLV
pop
line 1390
;1390:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $551
line 1393
;1391:	}
;1392:
;1393:	if ( Q_stricmp (cmd, "maplist") == 0 ) {
ADDRLP4 0
ARGP4
ADDRGP4 $556
ARGP4
ADDRLP4 1120
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1120
INDIRI4
CNSTI4 0
NEI4 $554
line 1394
;1394:		Svcmd_MapList_f();
ADDRGP4 Svcmd_MapList_f
CALLV
pop
line 1395
;1395:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $554
line 1398
;1396:	}
;1397:
;1398:	if ( (Q_stricmp (cmd, "quickmodes") == 0) || (Q_stricmp (cmd, "quickmode") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $559
ARGP4
ADDRLP4 1124
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1124
INDIRI4
CNSTI4 0
EQI4 $561
ADDRLP4 0
ARGP4
ADDRGP4 $560
ARGP4
ADDRLP4 1128
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1128
INDIRI4
CNSTI4 0
NEI4 $557
LABELV $561
line 1399
;1399:		Svcmd_Quickmodes_f();
ADDRGP4 Svcmd_Quickmodes_f
CALLV
pop
line 1400
;1400:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $557
line 1403
;1401:	}
;1402:
;1403:	if ( (Q_stricmp(cmd, "teams") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $564
ARGP4
ADDRLP4 1132
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1132
INDIRI4
CNSTI4 0
NEI4 $562
line 1404
;1404:		Svcmd_Teams_f();
ADDRGP4 Svcmd_Teams_f
CALLV
pop
line 1405
;1405:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $562
line 1411
;1406:	}
;1407:
;1408:	/*****************
;1409:	//FIXME: The following are junk
;1410:	******************/
;1411:	if ( (Q_stricmp (cmd, "spawn_armor") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $567
ARGP4
ADDRLP4 1136
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1136
INDIRI4
CNSTI4 0
NEI4 $565
line 1413
;1412:		char		str[MAX_TOKEN_CHARS];
;1413:		char		str2[MAX_TOKEN_CHARS] = "0";
ADDRLP4 1140
ADDRGP4 $568
INDIRB
ASGNB 1024
line 1415
;1414:
;1415:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 2164
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1416
;1416:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 1140
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1417
;1417:		Svcmd_AdjustGameSettings_f(GS_GLOBAL, 0, GS_SPAWN_ARMOR, str2 , str );
ADDRLP4 3188
CNSTI4 0
ASGNI4
ADDRLP4 3188
INDIRI4
ARGI4
ADDRLP4 3188
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 1140
ARGP4
ADDRLP4 2164
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1418
;1418:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $565
line 1421
;1419:	}
;1420:	
;1421:	if ( (Q_stricmp (cmd, "spawn_health") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $571
ARGP4
ADDRLP4 1140
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1140
INDIRI4
CNSTI4 0
NEI4 $569
line 1425
;1422:		char		str[MAX_TOKEN_CHARS];
;1423:		char		str2[MAX_TOKEN_CHARS];
;1424:
;1425:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1144
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1426
;1426:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2168
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1427
;1427:		Svcmd_AdjustGameSettings_f(GS_GLOBAL, 0, GS_SPAWN_HEALTH, str2 , str );
ADDRLP4 3192
CNSTI4 0
ASGNI4
ADDRLP4 3192
INDIRI4
ARGI4
ADDRLP4 3192
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 2168
ARGP4
ADDRLP4 1144
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1428
;1428:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $569
line 1431
;1429:	}
;1430:
;1431:	if ( (Q_stricmp (cmd, "hook_speed") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $574
ARGP4
ADDRLP4 1144
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1144
INDIRI4
CNSTI4 0
NEI4 $572
line 1435
;1432:		char		str[MAX_TOKEN_CHARS];
;1433:		char		str2[MAX_TOKEN_CHARS];
;1434:
;1435:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1148
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1436
;1436:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2172
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1437
;1437:		Svcmd_AdjustGameSettings_f(GS_HOOK_SPEED, 0, 0, str2 , str );
CNSTI4 4
ARGI4
ADDRLP4 3196
CNSTI4 0
ASGNI4
ADDRLP4 3196
INDIRI4
ARGI4
ADDRLP4 3196
INDIRI4
ARGI4
ADDRLP4 2172
ARGP4
ADDRLP4 1148
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1438
;1438:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $572
line 1440
;1439:	}
;1440:	if ( (Q_stricmp (cmd, "quadfactor_radius") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $577
ARGP4
ADDRLP4 1148
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1148
INDIRI4
CNSTI4 0
NEI4 $575
line 1444
;1441:		char		str[MAX_TOKEN_CHARS];
;1442:		char		str2[MAX_TOKEN_CHARS];
;1443:
;1444:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1152
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1445
;1445:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2176
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1446
;1446:		Svcmd_AdjustGameSettings_f(GS_POWERUPS, 0, 0, str2 , str );
CNSTI4 3
ARGI4
ADDRLP4 3200
CNSTI4 0
ASGNI4
ADDRLP4 3200
INDIRI4
ARGI4
ADDRLP4 3200
INDIRI4
ARGI4
ADDRLP4 2176
ARGP4
ADDRLP4 1152
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1447
;1447:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $575
line 1449
;1448:	}
;1449:	if ( (Q_stricmp (cmd, "allow_tossflag") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $580
ARGP4
ADDRLP4 1152
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1152
INDIRI4
CNSTI4 0
NEI4 $578
line 1453
;1450:		char		str[MAX_TOKEN_CHARS];
;1451:		char		str2[MAX_TOKEN_CHARS];
;1452:
;1453:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1156
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1454
;1454:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2180
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1455
;1455:		Svcmd_AdjustGameSettings_f(GS_GLOBAL, 0, GS_ALLOW_TOSSFLAG, str2 , str );
ADDRLP4 3204
CNSTI4 0
ASGNI4
ADDRLP4 3204
INDIRI4
ARGI4
ADDRLP4 3204
INDIRI4
ARGI4
ADDRLP4 3204
INDIRI4
ARGI4
ADDRLP4 2180
ARGP4
ADDRLP4 1156
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1456
;1456:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $578
line 1458
;1457:	}
;1458:	if ( (Q_stricmp (cmd, "rocket_radius") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $583
ARGP4
ADDRLP4 1156
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1156
INDIRI4
CNSTI4 0
NEI4 $581
line 1462
;1459:		char		str[MAX_TOKEN_CHARS];
;1460:		char		str2[MAX_TOKEN_CHARS];
;1461:
;1462:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1160
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1463
;1463:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2184
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1464
;1464:		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_ROCKET, GS_RADIUS, str2 , str );
ADDRLP4 3208
CNSTI4 1
ASGNI4
ADDRLP4 3208
INDIRI4
ARGI4
ADDRLP4 3208
INDIRI4
ARGI4
ADDRLP4 3208
INDIRI4
ARGI4
ADDRLP4 2184
ARGP4
ADDRLP4 1160
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1465
;1465:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $581
line 1467
;1466:	}
;1467:	if ( (Q_stricmp (cmd, "rocket_damage") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $586
ARGP4
ADDRLP4 1160
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1160
INDIRI4
CNSTI4 0
NEI4 $584
line 1471
;1468:		char		str[MAX_TOKEN_CHARS];
;1469:		char		str2[MAX_TOKEN_CHARS];
;1470:
;1471:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1164
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1472
;1472:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2188
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1473
;1473:		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_ROCKET, GS_DAMAGE, str2 , str );
ADDRLP4 3212
CNSTI4 1
ASGNI4
ADDRLP4 3212
INDIRI4
ARGI4
ADDRLP4 3212
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 2188
ARGP4
ADDRLP4 1164
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1474
;1474:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $584
line 1476
;1475:	}
;1476:	if ( (Q_stricmp (cmd, "rocket_splash_damage") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $589
ARGP4
ADDRLP4 1164
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1164
INDIRI4
CNSTI4 0
NEI4 $587
line 1480
;1477:		char		str[MAX_TOKEN_CHARS];
;1478:		char		str2[MAX_TOKEN_CHARS];
;1479:
;1480:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1168
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1481
;1481:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2192
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1482
;1482:		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_ROCKET, GS_SPLASH_DAMAGE, str2 , str );
ADDRLP4 3216
CNSTI4 1
ASGNI4
ADDRLP4 3216
INDIRI4
ARGI4
ADDRLP4 3216
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 2192
ARGP4
ADDRLP4 1168
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1483
;1483:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $587
line 1485
;1484:	}
;1485:	if ( (Q_stricmp (cmd, "rocket_speed") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $592
ARGP4
ADDRLP4 1168
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1168
INDIRI4
CNSTI4 0
NEI4 $590
line 1489
;1486:		char		str[MAX_TOKEN_CHARS];
;1487:		char		str2[MAX_TOKEN_CHARS];
;1488:
;1489:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1172
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1490
;1490:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2196
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1491
;1491:		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_ROCKET, GS_SPEED, str2 , str );
ADDRLP4 3220
CNSTI4 1
ASGNI4
ADDRLP4 3220
INDIRI4
ARGI4
ADDRLP4 3220
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 2196
ARGP4
ADDRLP4 1172
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1492
;1492:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $590
line 1494
;1493:	}
;1494:	if ( (Q_stricmp (cmd, "rocket_time") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $595
ARGP4
ADDRLP4 1172
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1172
INDIRI4
CNSTI4 0
NEI4 $593
line 1498
;1495:		char		str[MAX_TOKEN_CHARS];
;1496:		char		str2[MAX_TOKEN_CHARS];
;1497:
;1498:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1176
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1499
;1499:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2200
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1500
;1500:		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_ROCKET, GS_TIME, str2 , str );
ADDRLP4 3224
CNSTI4 1
ASGNI4
ADDRLP4 3224
INDIRI4
ARGI4
ADDRLP4 3224
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRLP4 2200
ARGP4
ADDRLP4 1176
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1501
;1501:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $593
line 1503
;1502:	}
;1503:	if ( (Q_stricmp (cmd, "bfg_radius") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $598
ARGP4
ADDRLP4 1176
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1176
INDIRI4
CNSTI4 0
NEI4 $596
line 1507
;1504:		char		str[MAX_TOKEN_CHARS];
;1505:		char		str2[MAX_TOKEN_CHARS];
;1506:
;1507:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1180
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1508
;1508:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2204
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1509
;1509:		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_BFG, GS_RADIUS, str2 , str );
ADDRLP4 3228
CNSTI4 1
ASGNI4
ADDRLP4 3228
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 3228
INDIRI4
ARGI4
ADDRLP4 2204
ARGP4
ADDRLP4 1180
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1510
;1510:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $596
line 1512
;1511:	}
;1512:	if ( (Q_stricmp (cmd, "bfg_damage") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $601
ARGP4
ADDRLP4 1180
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1180
INDIRI4
CNSTI4 0
NEI4 $599
line 1516
;1513:		char		str[MAX_TOKEN_CHARS];
;1514:		char		str2[MAX_TOKEN_CHARS];
;1515:
;1516:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1184
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1517
;1517:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2208
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1518
;1518:		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_BFG, GS_DAMAGE, str2 , str );
CNSTI4 1
ARGI4
CNSTI4 3
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 2208
ARGP4
ADDRLP4 1184
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1519
;1519:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $599
line 1521
;1520:	}
;1521:	if ( (Q_stricmp (cmd, "bfg_splash_damage") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $604
ARGP4
ADDRLP4 1184
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1184
INDIRI4
CNSTI4 0
NEI4 $602
line 1525
;1522:		char		str[MAX_TOKEN_CHARS];
;1523:		char		str2[MAX_TOKEN_CHARS];
;1524:
;1525:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1188
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1526
;1526:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2212
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1527
;1527:		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_BFG, GS_SPLASH_DAMAGE, str2 , str );
CNSTI4 1
ARGI4
CNSTI4 3
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 2212
ARGP4
ADDRLP4 1188
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1528
;1528:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $602
line 1530
;1529:	}
;1530:	if ( (Q_stricmp (cmd, "bfg_speed") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $607
ARGP4
ADDRLP4 1188
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1188
INDIRI4
CNSTI4 0
NEI4 $605
line 1534
;1531:		char		str[MAX_TOKEN_CHARS];
;1532:		char		str2[MAX_TOKEN_CHARS];
;1533:
;1534:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1192
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1535
;1535:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2216
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1536
;1536:		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_BFG, GS_SPEED, str2 , str );
CNSTI4 1
ARGI4
ADDRLP4 3240
CNSTI4 3
ASGNI4
ADDRLP4 3240
INDIRI4
ARGI4
ADDRLP4 3240
INDIRI4
ARGI4
ADDRLP4 2216
ARGP4
ADDRLP4 1192
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1537
;1537:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $605
line 1539
;1538:	}
;1539:	if ( (Q_stricmp (cmd, "bfg_time") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $610
ARGP4
ADDRLP4 1192
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1192
INDIRI4
CNSTI4 0
NEI4 $608
line 1543
;1540:		char		str[MAX_TOKEN_CHARS];
;1541:		char		str2[MAX_TOKEN_CHARS];
;1542:
;1543:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1196
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1544
;1544:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2220
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1545
;1545:		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_BFG, GS_TIME, str2 , str );
CNSTI4 1
ARGI4
CNSTI4 3
ARGI4
CNSTI4 4
ARGI4
ADDRLP4 2220
ARGP4
ADDRLP4 1196
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1546
;1546:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $608
line 1548
;1547:	}
;1548:	if ( (Q_stricmp (cmd, "grenade_radius") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $613
ARGP4
ADDRLP4 1196
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1196
INDIRI4
CNSTI4 0
NEI4 $611
line 1552
;1549:		char		str[MAX_TOKEN_CHARS];
;1550:		char		str2[MAX_TOKEN_CHARS];
;1551:
;1552:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1200
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1553
;1553:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2224
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1554
;1554:		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_GRENADE, GS_RADIUS, str2 , str );
ADDRLP4 3248
CNSTI4 1
ASGNI4
ADDRLP4 3248
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 3248
INDIRI4
ARGI4
ADDRLP4 2224
ARGP4
ADDRLP4 1200
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1555
;1555:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $611
line 1557
;1556:	}
;1557:	if ( (Q_stricmp (cmd, "grenade_damage") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $616
ARGP4
ADDRLP4 1200
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1200
INDIRI4
CNSTI4 0
NEI4 $614
line 1561
;1558:		char		str[MAX_TOKEN_CHARS];
;1559:		char		str2[MAX_TOKEN_CHARS];
;1560:
;1561:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1204
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1562
;1562:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2228
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1563
;1563:		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_GRENADE, GS_DAMAGE, str2 , str );
CNSTI4 1
ARGI4
ADDRLP4 3252
CNSTI4 0
ASGNI4
ADDRLP4 3252
INDIRI4
ARGI4
ADDRLP4 3252
INDIRI4
ARGI4
ADDRLP4 2228
ARGP4
ADDRLP4 1204
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1564
;1564:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $614
line 1566
;1565:	}
;1566:	if ( (Q_stricmp (cmd, "grenade_splash_damage") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $619
ARGP4
ADDRLP4 1204
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1204
INDIRI4
CNSTI4 0
NEI4 $617
line 1570
;1567:		char		str[MAX_TOKEN_CHARS];
;1568:		char		str2[MAX_TOKEN_CHARS];
;1569:
;1570:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1208
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1571
;1571:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2232
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1572
;1572:		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_GRENADE, GS_SPLASH_DAMAGE, str2 , str );
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 2232
ARGP4
ADDRLP4 1208
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1573
;1573:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $617
line 1575
;1574:	}
;1575:	if ( (Q_stricmp (cmd, "grenade_speed") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $622
ARGP4
ADDRLP4 1208
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1208
INDIRI4
CNSTI4 0
NEI4 $620
line 1579
;1576:		char		str[MAX_TOKEN_CHARS];
;1577:		char		str2[MAX_TOKEN_CHARS];
;1578:
;1579:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1212
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1580
;1580:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2236
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1581
;1581:		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_GRENADE, GS_SPEED, str2 , str );
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 2236
ARGP4
ADDRLP4 1212
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1582
;1582:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $620
line 1584
;1583:	}
;1584:	if ( (Q_stricmp (cmd, "grenade_time") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $625
ARGP4
ADDRLP4 1212
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1212
INDIRI4
CNSTI4 0
NEI4 $623
line 1588
;1585:		char		str[MAX_TOKEN_CHARS];
;1586:		char		str2[MAX_TOKEN_CHARS];
;1587:
;1588:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1216
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1589
;1589:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2240
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1590
;1590:		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_GRENADE, GS_TIME, str2 , str );
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRLP4 2240
ARGP4
ADDRLP4 1216
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1591
;1591:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $623
line 1593
;1592:	}
;1593:	if ( (Q_stricmp (cmd, "plasma_radius") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $628
ARGP4
ADDRLP4 1216
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1216
INDIRI4
CNSTI4 0
NEI4 $626
line 1597
;1594:		char		str[MAX_TOKEN_CHARS];
;1595:		char		str2[MAX_TOKEN_CHARS];
;1596:
;1597:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1220
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1598
;1598:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2244
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1599
;1599:		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_PLASMA, GS_RADIUS, str2 , str );
ADDRLP4 3268
CNSTI4 1
ASGNI4
ADDRLP4 3268
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 3268
INDIRI4
ARGI4
ADDRLP4 2244
ARGP4
ADDRLP4 1220
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1600
;1600:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $626
line 1602
;1601:	}
;1602:	if ( (Q_stricmp (cmd, "plasma_damage") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $631
ARGP4
ADDRLP4 1220
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1220
INDIRI4
CNSTI4 0
NEI4 $629
line 1606
;1603:		char		str[MAX_TOKEN_CHARS];
;1604:		char		str2[MAX_TOKEN_CHARS];
;1605:
;1606:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1224
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1607
;1607:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2248
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1608
;1608:		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_PLASMA, GS_DAMAGE, str2 , str );
CNSTI4 1
ARGI4
CNSTI4 2
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 2248
ARGP4
ADDRLP4 1224
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1609
;1609:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $629
line 1611
;1610:	}
;1611:	if ( (Q_stricmp (cmd, "plasma_splash_damage") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $634
ARGP4
ADDRLP4 1224
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1224
INDIRI4
CNSTI4 0
NEI4 $632
line 1615
;1612:		char		str[MAX_TOKEN_CHARS];
;1613:		char		str2[MAX_TOKEN_CHARS];
;1614:
;1615:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1228
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1616
;1616:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2252
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1617
;1617:		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_PLASMA, GS_SPLASH_DAMAGE, str2 , str );
CNSTI4 1
ARGI4
ADDRLP4 3276
CNSTI4 2
ASGNI4
ADDRLP4 3276
INDIRI4
ARGI4
ADDRLP4 3276
INDIRI4
ARGI4
ADDRLP4 2252
ARGP4
ADDRLP4 1228
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1618
;1618:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $632
line 1620
;1619:	}
;1620:	if ( (Q_stricmp (cmd, "plasma_speed") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $637
ARGP4
ADDRLP4 1228
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1228
INDIRI4
CNSTI4 0
NEI4 $635
line 1624
;1621:		char		str[MAX_TOKEN_CHARS];
;1622:		char		str2[MAX_TOKEN_CHARS];
;1623:
;1624:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1232
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1625
;1625:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2256
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1626
;1626:		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_PLASMA, GS_SPEED, str2 , str );
CNSTI4 1
ARGI4
CNSTI4 2
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 2256
ARGP4
ADDRLP4 1232
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1627
;1627:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $635
line 1629
;1628:	}
;1629:	if ( (Q_stricmp (cmd, "plasma_time") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $640
ARGP4
ADDRLP4 1232
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1232
INDIRI4
CNSTI4 0
NEI4 $638
line 1633
;1630:		char		str[MAX_TOKEN_CHARS];
;1631:		char		str2[MAX_TOKEN_CHARS];
;1632:
;1633:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1236
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1634
;1634:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2260
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1635
;1635:		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_PLASMA, GS_TIME, str2 , str );
CNSTI4 1
ARGI4
CNSTI4 2
ARGI4
CNSTI4 4
ARGI4
ADDRLP4 2260
ARGP4
ADDRLP4 1236
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1636
;1636:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $638
line 1638
;1637:	}
;1638:	if ( (Q_stricmp (cmd, "gauntlet_damage") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $643
ARGP4
ADDRLP4 1236
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1236
INDIRI4
CNSTI4 0
NEI4 $641
line 1642
;1639:		char		str[MAX_TOKEN_CHARS];
;1640:		char		str2[MAX_TOKEN_CHARS];
;1641:
;1642:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1240
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1643
;1643:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2264
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1644
;1644:		Svcmd_AdjustGameSettings_f(GS_HITSCAN, GS_GAUNTLET, GS_DAMAGE, str2 , str );
CNSTI4 2
ARGI4
ADDRLP4 3288
CNSTI4 0
ASGNI4
ADDRLP4 3288
INDIRI4
ARGI4
ADDRLP4 3288
INDIRI4
ARGI4
ADDRLP4 2264
ARGP4
ADDRLP4 1240
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1645
;1645:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $641
line 1647
;1646:	}
;1647:	if ( (Q_stricmp (cmd, "gauntlet_range") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $646
ARGP4
ADDRLP4 1240
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1240
INDIRI4
CNSTI4 0
NEI4 $644
line 1651
;1648:		char		str[MAX_TOKEN_CHARS];
;1649:		char		str2[MAX_TOKEN_CHARS];
;1650:
;1651:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1244
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1652
;1652:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2268
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1653
;1653:		Svcmd_AdjustGameSettings_f(GS_HITSCAN, GS_GAUNTLET, GS_RANGE, str2 , str );
CNSTI4 2
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 2268
ARGP4
ADDRLP4 1244
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1654
;1654:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $644
line 1656
;1655:	}
;1656:	if ( (Q_stricmp (cmd, "shotgun_damage") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $649
ARGP4
ADDRLP4 1244
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1244
INDIRI4
CNSTI4 0
NEI4 $647
line 1660
;1657:		char		str[MAX_TOKEN_CHARS];
;1658:		char		str2[MAX_TOKEN_CHARS];
;1659:
;1660:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1248
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1661
;1661:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2272
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1662
;1662:		Svcmd_AdjustGameSettings_f(GS_HITSCAN, GS_SHOTGUN, GS_DAMAGE, str2 , str );
ADDRLP4 3296
CNSTI4 2
ASGNI4
ADDRLP4 3296
INDIRI4
ARGI4
ADDRLP4 3296
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 2272
ARGP4
ADDRLP4 1248
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1663
;1663:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $647
line 1665
;1664:	}
;1665:	if ( (Q_stricmp (cmd, "railgun_damage") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $652
ARGP4
ADDRLP4 1248
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1248
INDIRI4
CNSTI4 0
NEI4 $650
line 1669
;1666:		char		str[MAX_TOKEN_CHARS];
;1667:		char		str2[MAX_TOKEN_CHARS];
;1668:
;1669:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1252
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1670
;1670:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2276
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1671
;1671:		Svcmd_AdjustGameSettings_f(GS_HITSCAN, GS_RAILGUN, GS_DAMAGE, str2 , str );
CNSTI4 2
ARGI4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 2276
ARGP4
ADDRLP4 1252
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1672
;1672:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $650
line 1674
;1673:	}
;1674:	if ( (Q_stricmp (cmd, "railgun_range") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $655
ARGP4
ADDRLP4 1252
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1252
INDIRI4
CNSTI4 0
NEI4 $653
line 1678
;1675:		char		str[MAX_TOKEN_CHARS];
;1676:		char		str2[MAX_TOKEN_CHARS];
;1677:
;1678:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1256
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1679
;1679:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2280
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1680
;1680:		Svcmd_AdjustGameSettings_f(GS_HITSCAN, GS_RAILGUN, GS_RANGE, str2 , str );
CNSTI4 2
ARGI4
CNSTI4 4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 2280
ARGP4
ADDRLP4 1256
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1681
;1681:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $653
line 1683
;1682:	}
;1683:	if ( (Q_stricmp (cmd, "lightning_damage") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $658
ARGP4
ADDRLP4 1256
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1256
INDIRI4
CNSTI4 0
NEI4 $656
line 1687
;1684:		char		str[MAX_TOKEN_CHARS];
;1685:		char		str2[MAX_TOKEN_CHARS];
;1686:
;1687:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1260
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1688
;1688:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2284
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1689
;1689:		Svcmd_AdjustGameSettings_f(GS_HITSCAN, GS_LIGHTNING, GS_DAMAGE, str2 , str );
CNSTI4 2
ARGI4
CNSTI4 3
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 2284
ARGP4
ADDRLP4 1260
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1690
;1690:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $656
line 1692
;1691:	}
;1692:	if ( (Q_stricmp (cmd, "lightning_range") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $661
ARGP4
ADDRLP4 1260
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1260
INDIRI4
CNSTI4 0
NEI4 $659
line 1696
;1693:		char		str[MAX_TOKEN_CHARS];
;1694:		char		str2[MAX_TOKEN_CHARS];
;1695:
;1696:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1264
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1697
;1697:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2288
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1698
;1698:		Svcmd_AdjustGameSettings_f(GS_HITSCAN, GS_LIGHTNING, GS_RANGE, str2 , str );
CNSTI4 2
ARGI4
CNSTI4 3
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 2288
ARGP4
ADDRLP4 1264
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1699
;1699:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $659
line 1702
;1700:	}
;1701:	
;1702:	if ( (Q_stricmp (cmd, "machinegun_damage") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $664
ARGP4
ADDRLP4 1264
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1264
INDIRI4
CNSTI4 0
NEI4 $662
line 1706
;1703:		char		str[MAX_TOKEN_CHARS];
;1704:		char		str2[MAX_TOKEN_CHARS];
;1705:
;1706:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1268
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1707
;1707:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2292
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1708
;1708:		Svcmd_AdjustGameSettings_f(GS_HITSCAN, GS_MACHINEGUN, GS_DAMAGE, str2 , str );
CNSTI4 2
ARGI4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 2292
ARGP4
ADDRLP4 1268
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1709
;1709:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $662
line 1712
;1710:	}
;1711:	
;1712:	if ( (Q_stricmp (cmd, "machinegun_teamplay_damage") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $667
ARGP4
ADDRLP4 1268
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1268
INDIRI4
CNSTI4 0
NEI4 $665
line 1716
;1713:		char		str[MAX_TOKEN_CHARS];
;1714:		char		str2[MAX_TOKEN_CHARS];
;1715:
;1716:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1272
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1717
;1717:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2296
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1718
;1718:		Svcmd_AdjustGameSettings_f(GS_HITSCAN, GS_MACHINEGUN, GS_RANGE, str2 , str );
CNSTI4 2
ARGI4
ADDRLP4 3320
CNSTI4 1
ASGNI4
ADDRLP4 3320
INDIRI4
ARGI4
ADDRLP4 3320
INDIRI4
ARGI4
ADDRLP4 2296
ARGP4
ADDRLP4 1272
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1719
;1719:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $665
line 1722
;1720:	}
;1721:
;1722:	if ( (Q_stricmp (cmd, "ping_fix") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $670
ARGP4
ADDRLP4 1272
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1272
INDIRI4
CNSTI4 0
NEI4 $668
line 1726
;1723:		char		str[MAX_TOKEN_CHARS];
;1724:		char		str2[MAX_TOKEN_CHARS];
;1725:
;1726:		trap_Argv( 0, str, sizeof( str ) );
CNSTI4 0
ARGI4
ADDRLP4 1276
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1727
;1727:		trap_Argv( 1, str2, sizeof( str2 ) );
CNSTI4 1
ARGI4
ADDRLP4 2300
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1728
;1728:		Svcmd_AdjustGameSettings_f(GS_GLOBAL, 0, GS_PING_FIX, str2 , str );
ADDRLP4 3324
CNSTI4 0
ASGNI4
ADDRLP4 3324
INDIRI4
ARGI4
ADDRLP4 3324
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 2300
ARGP4
ADDRLP4 1276
ARGP4
ADDRGP4 Svcmd_AdjustGameSettings_f
CALLV
pop
line 1729
;1729:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $668
line 1742
;1730:	}
;1731:
;1732:	/*****************
;1733:	//FIXME: The previous are junk
;1734:	******************/
;1735:
;1736:	/*if ( (Q_stricmp (cmd, "forceFlagSpawn") == 0) ) {
;1737:		Svcmd_ForceFlagSpawn_f();
;1738:		return qtrue;
;1739:	}*/
;1740:
;1741:
;1742:	if ( Q_stricmp ( cmd, "playsound") == 0 ) {
ADDRLP4 0
ARGP4
ADDRGP4 $673
ARGP4
ADDRLP4 1276
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1276
INDIRI4
CNSTI4 0
NEI4 $671
line 1746
;1743:		char		sound[MAX_TOKEN_CHARS];
;1744:		gentity_t	*tempEnt;
;1745:
;1746:		trap_Argv(1, sound, sizeof(sound));
CNSTI4 1
ARGI4
ADDRLP4 1280
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1747
;1747:		if ( strlen(sound) > 4 ) { //.wav == 4
ADDRLP4 1280
ARGP4
ADDRLP4 2308
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 2308
INDIRI4
CNSTI4 4
LEI4 $674
line 1748
;1748:			if ( G_SoundIndex( sound ) ) { //If it's valid..
ADDRLP4 1280
ARGP4
ADDRLP4 2312
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRLP4 2312
INDIRI4
CNSTI4 0
EQI4 $675
line 1749
;1749:				tempEnt = G_TempEntity( NULL, EV_GLOBAL_SOUND );
CNSTP4 0
ARGP4
CNSTI4 46
ARGI4
ADDRLP4 2316
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 2304
ADDRLP4 2316
INDIRP4
ASGNP4
line 1750
;1750:				tempEnt->s.eventParm = G_SoundIndex( sound );
ADDRLP4 1280
ARGP4
ADDRLP4 2320
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRLP4 2304
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 2320
INDIRI4
ASGNI4
line 1751
;1751:				tempEnt->r.svFlags |= SVF_BROADCAST;
ADDRLP4 2324
ADDRLP4 2304
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 2324
INDIRP4
ADDRLP4 2324
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 1752
;1752:			}
line 1753
;1753:		} else {
ADDRGP4 $675
JUMPV
LABELV $674
line 1754
;1754:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $463
JUMPV
LABELV $675
line 1757
;1755:		}
;1756:		
;1757:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $671
line 1760
;1758:	}
;1759:
;1760:	if ( (Q_stricmp( cmd, "tasks") == 0) || (Q_stricmp(cmd, "tasklist") == 0) ) {
ADDRLP4 0
ARGP4
ADDRGP4 $680
ARGP4
ADDRLP4 1280
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1280
INDIRI4
CNSTI4 0
EQI4 $682
ADDRLP4 0
ARGP4
ADDRGP4 $681
ARGP4
ADDRLP4 1284
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1284
INDIRI4
CNSTI4 0
NEI4 $678
LABELV $682
line 1761
;1761:		Svcmd_tasklist_f();
ADDRGP4 Svcmd_tasklist_f
CALLV
pop
line 1762
;1762:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $678
line 1765
;1763:	}
;1764:
;1765:	if ( Q_stricmp (cmd, "help") == 0 ) {
ADDRLP4 0
ARGP4
ADDRGP4 $685
ARGP4
ADDRLP4 1288
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1288
INDIRI4
CNSTI4 0
NEI4 $683
line 1766
;1766:		Svcmd_Help_f();
ADDRGP4 Svcmd_Help_f
CALLV
pop
line 1767
;1767:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $683
line 1770
;1768:	}
;1769:
;1770:	if ( Q_stricmp (cmd, "mute") == 0 ) {
ADDRLP4 0
ARGP4
ADDRGP4 $688
ARGP4
ADDRLP4 1292
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1292
INDIRI4
CNSTI4 0
NEI4 $686
line 1771
;1771:		Svcmd_mute_f();
ADDRGP4 Svcmd_mute_f
CALLV
pop
line 1772
;1772:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $686
line 1775
;1773:	}
;1774:
;1775:	if ( Q_stricmp (cmd, "unmute") == 0 ) {
ADDRLP4 0
ARGP4
ADDRGP4 $691
ARGP4
ADDRLP4 1296
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1296
INDIRI4
CNSTI4 0
NEI4 $689
line 1776
;1776:		Svcmd_unmute_f();
ADDRGP4 Svcmd_unmute_f
CALLV
pop
line 1777
;1777:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $689
line 1780
;1778:	}
;1779:
;1780:	if (g_dedicated.integer) {
ADDRGP4 g_dedicated+12
INDIRI4
CNSTI4 0
EQI4 $692
line 1782
;1781:		//char	message[1024];
;1782:		if (Q_stricmp (cmd, "say") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $697
ARGP4
ADDRLP4 1300
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1300
INDIRI4
CNSTI4 0
NEI4 $695
line 1785
;1783:			//message = ConcatArgs(1);
;1784:			//G_LogPrintf( "say: server: %s\n", message );
;1785:			G_LogPrintf( "say: server: %s\n", ConcatArgs(1) );
CNSTI4 1
ARGI4
ADDRLP4 1304
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
ADDRGP4 $698
ARGP4
ADDRLP4 1304
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1786
;1786:			G_Printf( "say: server: %s\n", ConcatArgs(1) );
CNSTI4 1
ARGI4
ADDRLP4 1308
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
ADDRGP4 $698
ARGP4
ADDRLP4 1308
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 1787
;1787:			trap_SendServerCommand( -1, va("chat \"server%c%c%s\"", Q_COLOR_ESCAPE, COLOR_GREEN, ConcatArgs(1)));
CNSTI4 1
ARGI4
ADDRLP4 1312
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
ADDRGP4 $699
ARGP4
CNSTI4 94
ARGI4
CNSTI4 50
ARGI4
ADDRLP4 1312
INDIRP4
ARGP4
ADDRLP4 1316
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 1316
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1789
;1788:			//trap_SendServerCommand( -1, va("print \"server: %s\n\"", ConcatArgs(1) ) );
;1789:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $695
line 1792
;1790:		}
;1791:		// everything else will also be printed as a say command
;1792:		trap_SendServerCommand( -1, va("print \"server: %s", ConcatArgs(0) ) );
CNSTI4 0
ARGI4
ADDRLP4 1304
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
ADDRGP4 $700
ARGP4
ADDRLP4 1304
INDIRP4
ARGP4
ADDRLP4 1308
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 1308
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1793
;1793:		G_Printf("\n");
ADDRGP4 $182
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 1794
;1794:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $463
JUMPV
LABELV $692
line 1797
;1795:	}
;1796:
;1797:	return qfalse;
CNSTI4 0
RETI4
LABELV $463
endproc ConsoleCommand 3328 20
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
LABELV $700
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $699
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 34
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 37
byte 1 99
byte 1 37
byte 1 99
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $698
byte 1 115
byte 1 97
byte 1 121
byte 1 58
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $697
byte 1 115
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $691
byte 1 117
byte 1 110
byte 1 109
byte 1 117
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $688
byte 1 109
byte 1 117
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $685
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 0
align 1
LABELV $681
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $680
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 115
byte 1 0
align 1
LABELV $673
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $670
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 95
byte 1 102
byte 1 105
byte 1 120
byte 1 0
align 1
LABELV $667
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
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 95
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $664
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
byte 1 95
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $661
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 95
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $658
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 95
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $655
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 95
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $652
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 95
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $649
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 95
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $646
byte 1 103
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 95
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $643
byte 1 103
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 95
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $640
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $637
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 95
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $634
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 95
byte 1 115
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 95
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $631
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 95
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $628
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 95
byte 1 114
byte 1 97
byte 1 100
byte 1 105
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $625
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $622
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 95
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $619
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 95
byte 1 115
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 95
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $616
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 95
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $613
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 95
byte 1 114
byte 1 97
byte 1 100
byte 1 105
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $610
byte 1 98
byte 1 102
byte 1 103
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $607
byte 1 98
byte 1 102
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $604
byte 1 98
byte 1 102
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 95
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $601
byte 1 98
byte 1 102
byte 1 103
byte 1 95
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $598
byte 1 98
byte 1 102
byte 1 103
byte 1 95
byte 1 114
byte 1 97
byte 1 100
byte 1 105
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $595
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $592
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 95
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $589
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 95
byte 1 115
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 95
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $586
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 95
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $583
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 95
byte 1 114
byte 1 97
byte 1 100
byte 1 105
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $580
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 95
byte 1 116
byte 1 111
byte 1 115
byte 1 115
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $577
byte 1 113
byte 1 117
byte 1 97
byte 1 100
byte 1 102
byte 1 97
byte 1 99
byte 1 116
byte 1 111
byte 1 114
byte 1 95
byte 1 114
byte 1 97
byte 1 100
byte 1 105
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $574
byte 1 104
byte 1 111
byte 1 111
byte 1 107
byte 1 95
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $571
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 95
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $567
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 95
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $564
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $560
byte 1 113
byte 1 117
byte 1 105
byte 1 99
byte 1 107
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $559
byte 1 113
byte 1 117
byte 1 105
byte 1 99
byte 1 107
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $556
byte 1 109
byte 1 97
byte 1 112
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $553
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 117
byte 1 109
byte 1 0
align 1
LABELV $550
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 97
byte 1 108
byte 1 108
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 115
byte 1 0
align 1
LABELV $544
byte 1 97
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $540
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $536
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 45
byte 1 45
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $535
byte 1 97
byte 1 100
byte 1 100
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $531
byte 1 117
byte 1 110
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $530
byte 1 117
byte 1 110
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $526
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $525
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $515
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $505
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 111
byte 1 117
byte 1 116
byte 1 0
align 1
LABELV $502
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $499
byte 1 119
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 98
byte 1 97
byte 1 110
byte 1 0
align 1
LABELV $495
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $494
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 98
byte 1 97
byte 1 110
byte 1 105
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $490
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $489
byte 1 117
byte 1 110
byte 1 98
byte 1 97
byte 1 110
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $485
byte 1 97
byte 1 100
byte 1 100
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $484
byte 1 98
byte 1 97
byte 1 110
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $481
byte 1 97
byte 1 98
byte 1 111
byte 1 114
byte 1 116
byte 1 95
byte 1 112
byte 1 111
byte 1 100
byte 1 105
byte 1 117
byte 1 109
byte 1 0
align 1
LABELV $478
byte 1 98
byte 1 111
byte 1 116
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $475
byte 1 97
byte 1 100
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $472
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 95
byte 1 109
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 0
align 1
LABELV $469
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $466
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $462
byte 1 94
byte 1 53
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $461
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 67
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 115
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
byte 1 10
byte 1 0
align 1
LABELV $458
byte 1 94
byte 1 53
byte 1 85
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 92
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $457
byte 1 50
byte 1 46
byte 1 48
byte 1 48
byte 1 91
byte 1 67
byte 1 104
byte 1 105
byte 1 50
byte 1 93
byte 1 32
byte 1 45
byte 1 32
byte 1 66
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 32
byte 1 68
byte 1 97
byte 1 116
byte 1 101
byte 1 58
byte 1 32
byte 1 83
byte 1 101
byte 1 112
byte 1 116
byte 1 101
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 32
byte 1 53
byte 1 44
byte 1 32
byte 1 50
byte 1 48
byte 1 48
byte 1 57
byte 1 0
align 1
LABELV $456
byte 1 82
byte 1 101
byte 1 118
byte 1 111
byte 1 108
byte 1 117
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $455
byte 1 94
byte 1 53
byte 1 10
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $454
byte 1 94
byte 1 53
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 115
byte 1 47
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 97
byte 1 118
byte 1 97
byte 1 105
byte 1 108
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 58
byte 1 10
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $453
byte 1 94
byte 1 53
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $445
byte 1 94
byte 1 53
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 115
byte 1 47
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 97
byte 1 118
byte 1 97
byte 1 105
byte 1 108
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 58
byte 1 10
byte 1 0
align 1
LABELV $442
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
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
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $437
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
byte 1 101
byte 1 110
byte 1 46
byte 1 104
byte 1 101
byte 1 108
byte 1 112
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
LABELV $434
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
byte 1 101
byte 1 110
byte 1 46
byte 1 104
byte 1 101
byte 1 108
byte 1 112
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
LABELV $431
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 105
byte 1 103
byte 1 47
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 47
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 47
byte 1 101
byte 1 110
byte 1 46
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $386
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $372
byte 1 85
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 117
byte 1 110
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 60
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 62
byte 1 10
byte 1 0
align 1
LABELV $356
byte 1 85
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 60
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 62
byte 1 10
byte 1 0
align 1
LABELV $341
byte 1 78
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $332
byte 1 94
byte 1 51
byte 1 70
byte 1 114
byte 1 101
byte 1 101
byte 1 32
byte 1 32
byte 1 37
byte 1 51
byte 1 105
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 37
byte 1 53
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $331
byte 1 94
byte 1 51
byte 1 83
byte 1 112
byte 1 101
byte 1 99
byte 1 32
byte 1 32
byte 1 37
byte 1 51
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $325
byte 1 94
byte 1 51
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 32
byte 1 37
byte 1 51
byte 1 105
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 37
byte 1 53
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $321
byte 1 85
byte 1 110
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $320
byte 1 76
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $317
byte 1 94
byte 1 51
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 32
byte 1 32
byte 1 37
byte 1 51
byte 1 105
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 37
byte 1 53
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $313
byte 1 94
byte 1 51
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 32
byte 1 67
byte 1 111
byte 1 117
byte 1 110
byte 1 116
byte 1 32
byte 1 32
byte 1 76
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 32
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 10
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 10
byte 1 0
align 1
LABELV $311
byte 1 101
byte 1 120
byte 1 101
byte 1 99
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 105
byte 1 103
byte 1 47
byte 1 113
byte 1 117
byte 1 105
byte 1 99
byte 1 107
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $310
byte 1 95
byte 1 95
byte 1 113
byte 1 117
byte 1 105
byte 1 99
byte 1 107
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $306
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $297
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $294
byte 1 94
byte 1 51
byte 1 37
byte 1 100
byte 1 58
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $293
byte 1 94
byte 1 51
byte 1 37
byte 1 100
byte 1 58
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 94
byte 1 51
byte 1 44
byte 1 32
byte 1 0
align 1
LABELV $282
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 94
byte 1 51
byte 1 77
byte 1 97
byte 1 112
byte 1 115
byte 1 58
byte 1 10
byte 1 94
byte 1 49
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 94
byte 1 55
byte 1 10
byte 1 0
align 1
LABELV $281
byte 1 98
byte 1 115
byte 1 112
byte 1 0
align 1
LABELV $280
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $275
byte 1 94
byte 1 51
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 94
byte 1 55
byte 1 37
byte 1 51
byte 1 100
byte 1 32
byte 1 94
byte 1 51
byte 1 80
byte 1 76
byte 1 65
byte 1 89
byte 1 69
byte 1 82
byte 1 83
byte 1 32
byte 1 32
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 10
byte 1 0
align 1
LABELV $273
byte 1 94
byte 1 55
byte 1 37
byte 1 50
byte 1 105
byte 1 32
byte 1 32
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 37
byte 1 53
byte 1 105
byte 1 37
byte 1 53
byte 1 105
byte 1 37
byte 1 55
byte 1 105
byte 1 37
byte 1 57
byte 1 105
byte 1 37
byte 1 49
byte 1 51
byte 1 105
byte 1 37
byte 1 56
byte 1 105
byte 1 47
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $272
byte 1 99
byte 1 108
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $271
byte 1 99
byte 1 108
byte 1 95
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 100
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $270
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 102
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $269
byte 1 115
byte 1 110
byte 1 97
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $268
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $255
byte 1 94
byte 1 51
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 10
byte 1 0
align 1
LABELV $254
byte 1 10
byte 1 94
byte 1 51
byte 1 32
byte 1 73
byte 1 68
byte 1 32
byte 1 78
byte 1 65
byte 1 77
byte 1 69
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
byte 1 82
byte 1 65
byte 1 84
byte 1 69
byte 1 32
byte 1 32
byte 1 83
byte 1 78
byte 1 65
byte 1 80
byte 1 83
byte 1 32
byte 1 32
byte 1 77
byte 1 65
byte 1 88
byte 1 70
byte 1 80
byte 1 83
byte 1 32
byte 1 32
byte 1 80
byte 1 65
byte 1 67
byte 1 75
byte 1 69
byte 1 84
byte 1 68
byte 1 85
byte 1 80
byte 1 32
byte 1 32
byte 1 77
byte 1 65
byte 1 88
byte 1 80
byte 1 65
byte 1 67
byte 1 75
byte 1 69
byte 1 84
byte 1 83
byte 1 32
byte 1 32
byte 1 65
byte 1 73
byte 1 77
byte 1 84
byte 1 89
byte 1 80
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $250
byte 1 94
byte 1 55
byte 1 32
byte 1 37
byte 1 52
byte 1 105
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 37
byte 1 54
byte 1 105
byte 1 32
byte 1 32
byte 1 32
byte 1 37
byte 1 54
byte 1 105
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $242
byte 1 94
byte 1 55
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 10
byte 1 0
align 1
LABELV $241
byte 1 94
byte 1 55
byte 1 32
byte 1 84
byte 1 97
byte 1 115
byte 1 107
byte 1 78
byte 1 117
byte 1 109
byte 1 32
byte 1 32
byte 1 83
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 32
byte 1 32
byte 1 82
byte 1 101
byte 1 112
byte 1 101
byte 1 97
byte 1 116
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 32
byte 1 32
byte 1 67
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $216
byte 1 85
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 97
byte 1 100
byte 1 100
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 32
byte 1 60
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 32
byte 1 110
byte 1 117
byte 1 109
byte 1 62
byte 1 32
byte 1 60
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 62
byte 1 32
byte 1 60
byte 1 114
byte 1 101
byte 1 112
byte 1 101
byte 1 97
byte 1 116
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 62
byte 1 32
byte 1 60
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 62
byte 1 10
byte 1 0
align 1
LABELV $203
byte 1 85
byte 1 115
byte 1 101
byte 1 114
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 10
byte 1 0
align 1
LABELV $193
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $190
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
byte 1 32
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $182
byte 1 10
byte 1 0
align 1
LABELV $181
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $177
byte 1 37
byte 1 51
byte 1 105
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
LABELV $176
byte 1 69
byte 1 84
byte 1 95
byte 1 71
byte 1 82
byte 1 65
byte 1 80
byte 1 80
byte 1 76
byte 1 69
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
LABELV $174
byte 1 69
byte 1 84
byte 1 95
byte 1 73
byte 1 78
byte 1 86
byte 1 73
byte 1 83
byte 1 73
byte 1 66
byte 1 76
byte 1 69
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
LABELV $172
byte 1 69
byte 1 84
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
byte 1 84
byte 1 82
byte 1 73
byte 1 71
byte 1 71
byte 1 69
byte 1 82
byte 1 32
byte 1 0
align 1
LABELV $170
byte 1 69
byte 1 84
byte 1 95
byte 1 80
byte 1 85
byte 1 83
byte 1 72
byte 1 95
byte 1 84
byte 1 82
byte 1 73
byte 1 71
byte 1 71
byte 1 69
byte 1 82
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $168
byte 1 69
byte 1 84
byte 1 95
byte 1 83
byte 1 80
byte 1 69
byte 1 65
byte 1 75
byte 1 69
byte 1 82
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
LABELV $166
byte 1 69
byte 1 84
byte 1 95
byte 1 80
byte 1 79
byte 1 82
byte 1 84
byte 1 65
byte 1 76
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
LABELV $164
byte 1 69
byte 1 84
byte 1 95
byte 1 66
byte 1 69
byte 1 65
byte 1 77
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
LABELV $162
byte 1 69
byte 1 84
byte 1 95
byte 1 77
byte 1 79
byte 1 86
byte 1 69
byte 1 82
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
LABELV $160
byte 1 69
byte 1 84
byte 1 95
byte 1 77
byte 1 73
byte 1 83
byte 1 83
byte 1 73
byte 1 76
byte 1 69
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
LABELV $158
byte 1 69
byte 1 84
byte 1 95
byte 1 73
byte 1 84
byte 1 69
byte 1 77
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
LABELV $156
byte 1 69
byte 1 84
byte 1 95
byte 1 80
byte 1 76
byte 1 65
byte 1 89
byte 1 69
byte 1 82
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
LABELV $154
byte 1 69
byte 1 84
byte 1 95
byte 1 71
byte 1 69
byte 1 78
byte 1 69
byte 1 82
byte 1 65
byte 1 76
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
LABELV $149
byte 1 37
byte 1 51
byte 1 105
byte 1 58
byte 1 0
align 1
LABELV $138
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $130
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
byte 1 117
byte 1 110
byte 1 98
byte 1 97
byte 1 110
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $129
byte 1 85
byte 1 110
byte 1 98
byte 1 97
byte 1 110
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 112
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $124
byte 1 85
byte 1 110
byte 1 98
byte 1 97
byte 1 110
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 32
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $115
byte 1 85
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 32
byte 1 117
byte 1 110
byte 1 98
byte 1 97
byte 1 110
byte 1 105
byte 1 112
byte 1 32
byte 1 60
byte 1 105
byte 1 112
byte 1 45
byte 1 109
byte 1 97
byte 1 115
byte 1 107
byte 1 32
byte 1 124
byte 1 111
byte 1 114
byte 1 124
byte 1 32
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 32
byte 1 35
byte 1 62
byte 1 10
byte 1 0
align 1
LABELV $101
byte 1 85
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 105
byte 1 112
byte 1 32
byte 1 60
byte 1 105
byte 1 112
byte 1 45
byte 1 109
byte 1 97
byte 1 115
byte 1 107
byte 1 62
byte 1 32
byte 1 60
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 62
byte 1 32
byte 1 60
byte 1 98
byte 1 97
byte 1 110
byte 1 32
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 45
byte 1 109
byte 1 97
byte 1 115
byte 1 107
byte 1 62
byte 1 32
byte 1 60
byte 1 114
byte 1 101
byte 1 97
byte 1 115
byte 1 111
byte 1 110
byte 1 62
byte 1 10
byte 1 0
align 1
LABELV $98
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
byte 1 105
byte 1 112
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 32
byte 1 45
byte 1 32
byte 1 76
byte 1 105
byte 1 107
byte 1 101
byte 1 108
byte 1 121
byte 1 32
byte 1 98
byte 1 101
byte 1 99
byte 1 97
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 97
byte 1 108
byte 1 108
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
byte 1 102
byte 1 117
byte 1 108
byte 1 108
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $96
byte 1 66
byte 1 97
byte 1 110
byte 1 32
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 116
byte 1 97
byte 1 105
byte 1 110
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $94
byte 1 78
byte 1 111
byte 1 32
byte 1 82
byte 1 101
byte 1 97
byte 1 115
byte 1 111
byte 1 110
byte 1 32
byte 1 80
byte 1 114
byte 1 111
byte 1 118
byte 1 105
byte 1 100
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $79
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $78
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
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 44
byte 1 32
byte 1 109
byte 1 117
byte 1 115
byte 1 116
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 108
byte 1 101
byte 1 115
byte 1 115
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 110
byte 1 32
byte 1 37
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $75
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
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 44
byte 1 32
byte 1 109
byte 1 117
byte 1 115
byte 1 116
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 110
byte 1 32
byte 1 122
byte 1 101
byte 1 114
byte 1 111
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $70
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
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 46
byte 1 10
byte 1 0
