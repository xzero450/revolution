// Copyright (C) 1999-2000 Id Software, Inc.
//

// this file holds commands that can be executed by the server console, but not remote clients

#include "g_local.h"


/*
==============================================================================

PACKET FILTERING
 

You can add or remove addresses from the filter list with:

addip <ip>
removeip <ip>

The ip address is specified in dot format, and you can use '*' to match any value
so you can specify an entire class C network with "addip 192.246.40.*"

Removeip will only remove an address specified exactly the same way.  You cannot addip a subnet, then removeip a single host.

listip
Prints the current list of filters.

g_filterban <0 or 1>

If 1 (the default), then ip addresses matching the current list will be prohibited from entering the game.  This is the default setting.

If 0, then only addresses matching the list will be allowed.  This lets you easily set up a private game, or a game that only allows players from your local network.

TTimo NOTE: for persistence, bans are stored in g_banIPs cvar MAX_CVAR_VALUE_STRING
The size of the cvar string buffer is limiting the banning to around 20 masks
this could be improved by putting some g_banIPs2 g_banIps3 etc. maybe
still, you should rely on PB for banning instead

==============================================================================
*/

//typedef struct ipFilter_s
//{
//	unsigned	mask;
//	unsigned	compare;
//} ipFilter_t;
//
//#define	MAX_IPFILTERS	1024
//
//static ipFilter_t	ipFilters[MAX_IPFILTERS];
//static int			numIPFilters;

/*
=================
StringToFilter
=================
*/
//static qboolean StringToFilter (char *s, ipFilter_t *f)
//{
//	char	num[128];
//	int		i, j;
//	byte	b[4];
//	byte	m[4];
//	
//	for (i=0 ; i<4 ; i++)
//	{
//		b[i] = 0;
//		m[i] = 0;
//	}
//	
//	for (i=0 ; i<4 ; i++)
//	{
//		if (*s < '0' || *s > '9')
//		{
//			if (*s == '*') // 'match any'
//			{
//				// b[i] and m[i] to 0
//				s++;
//				if (!*s)
//					break;
//				s++;
//				continue;
//			}
//			G_Printf( "Bad filter address: %s\n", s );
//			return qfalse;
//		}
//		
//		j = 0;
//		while (*s >= '0' && *s <= '9')
//		{
//			num[j++] = *s++;
//		}
//		num[j] = 0;
//		b[i] = atoi(num);
//		m[i] = 255;
//
//		if (!*s)
//			break;
//		s++;
//	}
//	
//	f->mask = *(unsigned *)m;
//	f->compare = *(unsigned *)b;
//	
//	return qtrue;
//}

/*
=================
UpdateIPBans
=================
*/
//static void UpdateIPBans (void)
//{
//	byte	b[4];
//	byte	m[4];
//	int		i,j;
//	char	iplist_final[MAX_CVAR_VALUE_STRING];
//	char	ip[64];
//
//	*iplist_final = 0;
//	for (i = 0 ; i < numIPFilters ; i++)
//	{
//		if (ipFilters[i].compare == 0xffffffff)
//			continue;
//
//		*(unsigned *)b = ipFilters[i].compare;
//		*(unsigned *)m = ipFilters[i].mask;
//		*ip = 0;
//		for (j = 0 ; j < 4 ; j++)
//		{
//			if (m[j]!=255)
//				Q_strcat(ip, sizeof(ip), "*");
//			else
//				Q_strcat(ip, sizeof(ip), va("%i", b[j]));
//			Q_strcat(ip, sizeof(ip), (j<3) ? "." : " ");
//		}		
//		if (strlen(iplist_final)+strlen(ip) < MAX_CVAR_VALUE_STRING)
//		{
//			Q_strcat( iplist_final, sizeof(iplist_final), ip);
//		}
//		else
//		{
//			Com_Printf("g_banIPs overflowed at MAX_CVAR_VALUE_STRING\n");
//			break;
//		}
//	}
//
//	trap_Cvar_Set( "g_banIPs", iplist_final );
//}

/*
=================
G_FilterPacket
=================
*/
//qboolean G_FilterPacket (char *from)
//{
//	int		i;
//	unsigned	in;
//	byte m[4];
//	char *p;
//
//	i = 0;
//	p = from;
//	while (*p && i < 4) {
//		m[i] = 0;
//		while (*p >= '0' && *p <= '9') {
//			m[i] = m[i]*10 + (*p - '0');
//			p++;
//		}
//		if (!*p || *p == ':')
//			break;
//		i++, p++;
//	}
//	
//	in = *(unsigned *)m;
//
//	for (i=0 ; i<numIPFilters ; i++)
//		if ( (in & ipFilters[i].mask) == ipFilters[i].compare)
//			return g_filterBan.integer != 0;
//
//	return g_filterBan.integer == 0;
//}

/*
=================
AddIP
=================
*/
//static void AddIP( char *str )
//{
//	int		i;
//
//	for (i = 0 ; i < numIPFilters ; i++)
//		if (ipFilters[i].compare == 0xffffffff)
//			break;		// free spot
//	if (i == numIPFilters)
//	{
//		if (numIPFilters == MAX_IPFILTERS)
//		{
//			G_Printf ("IP filter list is full\n");
//			return;
//		}
//		numIPFilters++;
//	}
//	
//	if (!StringToFilter (str, &ipFilters[i]))
//		ipFilters[i].compare = 0xffffffffu;
//
//	UpdateIPBans();
//}

/*
=================
G_ProcessIPBans
=================
*/
//void G_ProcessIPBans(void) 
//{
//	char *s, *t;
//	char		str[MAX_CVAR_VALUE_STRING];
//
//	Q_strncpyz( str, g_banIPs.string, sizeof(str) );
//
//	for (t = s = g_banIPs.string; *t; /* */ ) {
//		s = strchr(s, ' ');
//		if (!s)
//			break;
//		while (*s == ' ')
//			*s++ = 0;
//		if (*t)
//			AddIP( t );
//		t = s;
//	}
//}


/*
=================
Svcmd_AddIP_f
=================
*/
//void Svcmd_AddIP_f (void)
//{
//	char		str[MAX_TOKEN_CHARS];
//
//	if ( trap_Argc() < 2 ) {
//		G_Printf("Usage:  addip <ip-mask>\n");
//		return;
//	}
//
//	trap_Argv( 1, str, sizeof( str ) );
//
//	AddIP( str );
//
//}

/*
=================
Svcmd_MapNum_f
=================
*/
void Svcmd_MapNum_f () {
	// special case for map changes, we want to reset the nextmap setting
	// this allows a player to change maps, but not upset the map rotation
	char	mapName[MAX_QPATH];
	int		mapNum, mapCount;
	char	arg1[MAX_STRING_TOKENS];

	trap_Argv(1, arg1, sizeof(arg1));
	if( ! *arg1) {
		G_Printf( "^1Invalid mapnumber.\n" );
		return;
	}
	mapNum = atoi(arg1);
	if( mapNum == 0 && arg1[0] != '0' ) {
		//since atoi will return 0 if it can't convert, we need to know if it was 0 or just
		//a failed conversion, in which case we should print an error
		G_Printf( "^1Invalid mapnumber.\n" );
		return;
	}

	if(mapNum < 0) {
		G_Printf( "^1Invalid mapnumber, must be greater then zero.\n" );
		return;
	}

	memset(mapName, 0, sizeof(mapName));
	mapCount = FindMapNameForNumber( mapName, mapNum );

	if(mapNum > mapCount) {
		G_Printf( va("^1Invalid mapnumber, must be less then %d.\n", mapCount));
		return;
	}

	trap_SendConsoleCommand( EXEC_APPEND, va("map %s\n", mapName ) );
	return;
}

/*
=================
Svcmd_RemoveIP_f
=================
*/
//void Svcmd_RemoveIP_f (void)
//{
//	ipFilter_t	f;
//	int			i;
//	char		str[MAX_TOKEN_CHARS];
//
//	if ( trap_Argc() < 2 ) {
//		G_Printf("Usage:  sv removeip <ip-mask>\n");
//		return;
//	}
//
//	trap_Argv( 1, str, sizeof( str ) );
//
//	if (!StringToFilter (str, &f))
//		return;
//
//	for (i=0 ; i<numIPFilters ; i++) {
//		if (ipFilters[i].mask == f.mask	&&
//			ipFilters[i].compare == f.compare) {
//			ipFilters[i].compare = 0xffffffffu;
//			G_Printf ("Removed.\n");
//
//			UpdateIPBans();
//			return;
//		}
//	}
//
//	G_Printf ( "Didn't find %s.\n", str );
//}

void Svcmd_BanIP_f(qboolean isBan) {
	int i = 0;
	char		str[128];

	if (isBan) {
		int	timeDiff = getTimeDiff();
		if ( trap_Argc() == 2) {
			//Just ban an IP
			trap_Argv( 1, str, sizeof( str ) );
			for ( i = 0; i < NUM_BANS; i++ ) {
				if ( strlen(bans[i].ip) < 2 && isBan ) {
					Q_strncpyz(bans[i].ip, str, sizeof(bans[i].ip));
					bans[i].time = 0;
					bans[i].type = 1;//Assume perm ban
					Q_strncpyz(bans[i].message, "No Reason Provided", sizeof(bans[i].message));
					G_Printf("Ban slot %i contains %s\n", i, bans[i].ip);
					isBan = qfalse;
				} else {
					bans[i].time -= timeDiff;
				}
				return;
			}
			G_Printf("Unable to add ip ban - Likely because all slots are full.\n");

		} else if ( trap_Argc() < 5 ) {
			G_Printf("Usage:  banip <ip-mask> <time> <ban type-mask> <reason>\n");
			return;
		}
		//Ban an ip
		trap_Argv( 1, str, sizeof( str ) );
		//G_Printf("%s\n", str);
		for ( i = 0; i < NUM_BANS; i++ ) {
			//G_Printf("%i\n", i);
			if ( strlen(bans[i].ip) < 2 && isBan ) {
				//G_Printf("%i: %s\n", i, str);
				Q_strncpyz(bans[i].ip, str, sizeof(bans[i].ip));
				memset(str, 0, sizeof(str));
				trap_Argv( 2, str, sizeof( str ) );
				bans[i].time = atoi(str);
				memset(str, 0, sizeof(str));
				trap_Argv( 3, str, sizeof( str ) );
				bans[i].type = atoi(str);
				Q_strncpyz(bans[i].message, ConcatArgs(4), sizeof(bans[i].message));
				//trap_SendConsoleCommand(EXEC_NOW, va("seta banip%i %s", i, str));
				G_Printf("Ban slot %i contains %s\n", i, bans[i].ip);
				isBan = qfalse;
			} else {
				bans[i].time -= timeDiff;
			}
			return;
		}
		G_Printf("Unable to add ip ban - Likely because all slots are full.\n");
	} else {
		if ( trap_Argc() < 2 ) {
			G_Printf("Usage:  unbanip <ip-mask |or| slot #>\n");
			return;
		}

		trap_Argv( 1, str, sizeof( str ) );
		//G_Printf("%s\n", str);
		for ( i = 0; i < NUM_BANS; i++ ) {
			if ( strlen(str) < 3 ) {
				if ( atoi(str) == i ) {
					memset(&bans[i], 0, sizeof(&bans[i]));
					G_Printf("Unbanned slot number %i\n", i);
					return;
				}
			} else if ( strlen(bans[i].ip) > 2 ) {
				if ( Q_strncmp(str, bans[i].ip, strlen(bans[i].ip)) == 0 ) {
					memset(&bans[i], 0, sizeof(&bans[i]));
					G_Printf("Unbanned ip %s at slot %i\n", str, i );
					return;
				}
			}
		}
		G_Printf("Unable to unban %s\n", str);
	}
}

void Svcmd_ListBanIP_f(void) {
	int i = 0;
//	const char	*var;
//	char	s[128];

	for ( i = 0; i < MAX_SERVER_TASKS; i++ ) {
		//G_Printf("%i\n", i);
		if ( strlen(bans[i].ip) > 2 ) {
			G_Printf("%i: %s %s\n", i, bans[i].ip, bans[i].message);
		}
	}
}

/*
===================
Svcmd_EntityList_f
===================
*/
void	Svcmd_EntityList_f (void) {
	int			e;
	gentity_t		*check;

	check = g_entities+1;
	for (e = 1; e < level.num_entities ; e++, check++) {
		if ( !check->inuse ) {
			continue;
		}
		G_Printf("%3i:", e);
		switch ( check->s.eType ) {
		case ET_GENERAL:
			G_Printf("ET_GENERAL          ");
			break;
		case ET_PLAYER:
			G_Printf("ET_PLAYER           ");
			break;
		case ET_ITEM:
			G_Printf("ET_ITEM             ");
			break;
		case ET_MISSILE:
			G_Printf("ET_MISSILE          ");
			break;
		case ET_MOVER:
			G_Printf("ET_MOVER            ");
			break;
		case ET_BEAM:
			G_Printf("ET_BEAM             ");
			break;
		case ET_PORTAL:
			G_Printf("ET_PORTAL           ");
			break;
		case ET_SPEAKER:
			G_Printf("ET_SPEAKER          ");
			break;
		case ET_PUSH_TRIGGER:
			G_Printf("ET_PUSH_TRIGGER     ");
			break;
		case ET_TELEPORT_TRIGGER:
			G_Printf("ET_TELEPORT_TRIGGER ");
			break;
		case ET_INVISIBLE:
			G_Printf("ET_INVISIBLE        ");
			break;
		case ET_GRAPPLE:
			G_Printf("ET_GRAPPLE          ");
			break;
		default:
			G_Printf("%3i                 ", check->s.eType);
			break;
		}

		if ( check->classname ) {
			G_Printf("%s", check->classname);
		}
		G_Printf("\n");
	}
}

gclient_t	*ClientForString( const char *s ) {
	gclient_t	*cl;
	int			i;
	int			idnum;

	// numeric values are just slot numbers
	if ( s[0] >= '0' && s[0] <= '9' ) {
		idnum = atoi( s );
		if ( idnum < 0 || idnum >= level.maxclients ) {
			Com_Printf( "Bad client slot: %i\n", idnum );
			return NULL;
		}

		cl = &level.clients[idnum];
		if ( cl->pers.connected == CON_DISCONNECTED ) {
			G_Printf( "Client %i is not connected\n", idnum );
			return NULL;
		}
		return cl;
	}

	// check for a name match
	for ( i=0 ; i < level.maxclients ; i++ ) {
		cl = &level.clients[i];
		if ( cl->pers.connected == CON_DISCONNECTED ) {
			continue;
		}
		if ( !Q_stricmp( cl->pers.netname, s ) ) {
			return cl;
		}
	}

	G_Printf( "User %s is not on the server\n", s );

	return NULL;
}

/*
===================
Svcmd_ForceTeam_f

forceteam <player> <team>
===================
*/
void	Svcmd_ForceTeam_f( void ) {
	gclient_t	*cl;
	char		str[MAX_TOKEN_CHARS];

	// find the player
	trap_Argv( 1, str, sizeof( str ) );
	cl = ClientForString( str );
	if ( !cl ) {
		return;
	}

	// set the team
	trap_Argv( 2, str, sizeof( str ) );
	SetTeam( &g_entities[cl - level.clients], str, qtrue );
}

/*
===================
Svcmd_mute_f

mute <player>
===================
*/
void Svcmd_mute_f( ) {
	gclient_t	*cl;
	char		str[MAX_TOKEN_CHARS];

	// find the player
	trap_Argv( 1, str, sizeof( str ) );
	cl = ClientForString( str );
	if ( !cl ) {
		return;
	}

	cl->mutestatus = 1;
}

/*
===================
Svcmd_unmute_f

unmute <player>
===================
*/
void Svcmd_unmute_f( ) {
	gclient_t	*cl;
	char		str[MAX_TOKEN_CHARS];

	// find the player
	trap_Argv( 1, str, sizeof( str ) );
	cl = ClientForString( str );
	if ( !cl ) {
		return;
	}

	cl->mutestatus = 0;
}

//char	*ConcatArgs( int start );

/*
==================
Svcmd_addtask_f
==================
*/
void Svcmd_addtask_f ( void ) {
		//tasks_t		tasks;
		char		arg[MAX_STRING_CHARS];
		char		arg1[MAX_TOKEN_CHARS];
		char		arg2[MAX_TOKEN_CHARS];
	//	char		**command[1024];
		int			taskNum;
		int			i, c, len, tlen;
		len = 0;

		if ( trap_Argc() < 4 ) {
			G_Printf("Usage: addtask <task num> <start time> <repeat time> <command>\n");
		}
		//This is a little bloat, not needed truely, but makes life slightly easier
		trap_Argv( 1, arg1, sizeof( arg1 ) );

		taskNum = atoi( arg1 );
		//G_Printf("Task: %i\n", taskNum);
		//Is it a valid task number?
		if ( taskNum < 0 || taskNum > (MAX_SERVER_TASKS - 1) ) {
			//If taskNum is less than 0 or greater than (MAX_SERVER_TASKS - 1)
			//Return due to an invalid taskNum
			return;
		}

		trap_Argv( 2, arg2, sizeof( arg2 ) );
		if ( atoi(arg2) >= -1 ) {
			tasks[taskNum].sv_task_startTime = level.time + (atoi(arg2) * 1000);
			//Set the repeat interval for later use
			trap_Argv( 3, arg2, sizeof( arg2 ) );
			tasks[taskNum].sv_task_repeatTime = atoi( arg2 );
			//G_Printf("Time: %i\n", tasks[taskNum].sv_task_repeatTime);
			if ( tasks[taskNum].sv_task_repeatTime < 0 ) {
				//The repeat time is too low
				tasks[taskNum].sv_task_repeatTime = 0;
				return;
			}

			//Set the next run time right away
			tasks[taskNum].sv_task_runTime = level.time;

			c = trap_Argc();
			for ( i = 4 ; i < c ; i++ ) {
				trap_Argv( i, arg, sizeof( arg ) );
				tlen = strlen( arg );
				if ( len + tlen >= MAX_STRING_CHARS - 1 ) {
					break;
				}
				memcpy( tasks[taskNum].sv_task_command + len, arg, tlen );
				len += tlen;
				if ( i != c - 1 ) {
					//This adds the space back into the char
					tasks[taskNum].sv_task_command[len] = ' ';
					len++;
				}
			}
			return;
		}
}

/*
==================
Svcmd_tasklist_f
==================
*/
void Svcmd_tasklist_f ( void ) {
	int		i;

	G_Printf("^7 TaskNum  StartTime  RepeatTime  Command\n");
	G_Printf("^7-----------------------------------------------------------------------\n");
	for(i = 0; i < MAX_SERVER_TASKS; i++) {
		if ( tasks[i].sv_task_repeatTime > 0 ) {
			G_Printf("^7 %4i     %6i   %6i      %s\n", i, tasks[i].sv_task_startTime, tasks[i].sv_task_repeatTime, tasks[i].sv_task_command);
		}
	}
}

/*
==================
  Svcmd_players_f
==================
*/
void Svcmd_players_f ( void ) {
		int i, idnum, playercount = 0;
		int user_rate, user_snaps, /*user_timenudge,*/ user_maxfps, user_packetdup, user_maxpackets;
		char *s, userinfo[MAX_INFO_STRING], playername[MAX_QPATH];
		char buffer[32];
		int	numColorCodesUsed = 0, ii = 0;
		gclient_t *cl;
		gentity_t *cl_ent;

		//Start fetching data and print it to the console
		G_Printf("\n^3 ID NAME            RATE  SNAPS  MAXFPS  PACKETDUP  MAXPACKETS  AIMTYPE\n");
		G_Printf("^3-----------------------------------------------------------------------------\n");
		for(i=0; i < level.numConnectedClients; i++ ) {

		idnum = level.sortedClients[i];
		cl = &level.clients[idnum]; 
		cl_ent = g_entities + idnum;	

		if ( !( cl_ent->r.svFlags & SVF_BOT ) ) {

		++playercount;

		trap_GetUserinfo( idnum, userinfo, sizeof(userinfo) );

		memset(&playername, 0, sizeof(playername));
		numColorCodesUsed = FixedName(playername, cl->pers.netname, 15);//Fix names in console printing
		memset(&buffer, 0, sizeof(buffer));
		for ( ii = 0; (strlen(playername)-(numColorCodesUsed*2))+strlen(buffer) < 14; ii++ ) {
			buffer[ii] = ' ';
		}

		s = Info_ValueForKey( userinfo, "rate" );//Get /rate
		user_rate = atoi(s);

		s = Info_ValueForKey( userinfo, "snaps" );//Get /snaps
		user_snaps = atoi(s);

		//s = Info_ValueForKey( userinfo, "cl_timeNudge" );//Get /cl_timenudge
		//user_timenudge = atoi(s);

		s = Info_ValueForKey( userinfo, "com_maxfps" );//Get /com_maxfps
		user_maxfps = atoi(s);

		s = Info_ValueForKey( userinfo, "cl_packetdup" );//Get /cl_packetdup
		user_packetdup = atoi(s);

		s = Info_ValueForKey( userinfo, "cl_maxpackets" );//Get /cl_maxpackets
		user_maxpackets = atoi(s);
		
		//Print all the data for the client it was requested from.
		G_Printf("^7%2i  %s%s"S_COLOR_WHITE" %5i%5i%7i%9i%13i%8i/%i\n", 
		idnum, playername, buffer, user_rate, user_snaps, user_maxfps, user_packetdup, user_maxpackets, cl->sess.aimType, g_delagHitscan.integer);

			}

		}
		//Print the bottom of the table, and total number of players connected
		G_Printf("^3---------------------------^7%3d ^3PLAYERS  -------------------------------\n", playercount);


}

/*
==================
Svcmd_MapList_f

Request list of maps on the server
==================
*/
void Svcmd_MapList_f( void ) {
	char		filelist[5120];// > 410+ maps will show at this setting
	char		mapName[MAX_QPATH];
	char		mapList[MAX_MAPLIST_SIZE];
	char*		fileptr;
	char		entry[512];
	int			filelen, numfiles, mapCnt, entryLen, mapListLen, itemCnt;
	char		filter[MAX_QPATH];
	qboolean	filtering;

	trap_Argv(1, filter, sizeof(filter));
	filtering = ( filter && strlen(filter) > 0 );

	numfiles = trap_FS_GetFileList( "maps", "bsp", filelist, sizeof(filelist) );
	fileptr = filelist;
	mapCnt = 0;
	itemCnt = -1;
	memset(entry, 0, sizeof(entry));
	strcpy(mapList, "print \"^3Maps:\n^1=====^7\n" );
	for (mapCnt=0; mapCnt<numfiles; mapCnt++, fileptr += filelen+1)
	{
		filelen = strlen(fileptr);
		COM_StripExtension(fileptr,mapName);

		if( filtering ) {
			if( trap_StringContains(mapName, filter, 0) == -1 )
			{
				continue;
			}
		}
		
		itemCnt++;
		if( itemCnt % 3 < 2 ) {
			Q_strcat(entry, sizeof(entry), va("^3%d:^7%s^3, ", mapCnt, mapName));
			continue;
		}
		Q_strcat(entry, sizeof(entry), va("^3%d:^7%s\n", mapCnt, mapName));
		entryLen = strlen(entry);
		mapListLen = strlen(mapList);
		//-1: null term, -1: null term, +1: end quote, +1: null term
		//if( (mapListLen -1) + (entryLen -1) +1 +1 < MAX_MAPLIST_SIZE )
		if( (mapListLen + entryLen) < MAX_MAPLIST_SIZE - 4 )
		{
			Q_strcat(mapList, sizeof(mapList), entry);
		} else {
			Q_strcat(mapList, sizeof(mapList), "\"\n");
			G_Printf("%s", mapList);
			mapList[0] = 0;
			Q_strcat(mapList, sizeof(mapList), va("%s",entry));
		}
		entry[0] = 0;//clear out entry for next go round
	}
	
	//check to see if we have an entry that was never added to the maplist
	if( itemCnt % 3 < 2 ) {
		int len;
		Q_strcat(mapList, sizeof(mapList), entry);
		//adjust the end of the maplist line to not have a trailing comma and space
		len = strlen(mapList);
		mapList[len - 2] = '\n';
		mapList[len - 1] = 0;
	}

	//adjust numfiles as we were filtering, just in case this might be 
	//extended at some point in the future
	if( filtering ) {
		//adjust it for 1 because we use it as a counter above, not an actual "count"
		numfiles = itemCnt + 1;
	}
	//send the last mapList
	if( numfiles > 0 ) {
		Q_strcat(mapList, sizeof(mapList), "\"\n");
		G_Printf("%s\n", mapList);
	}
}

/*
=================
Svcmd_Quickmodes_f
=================
*/
void Svcmd_Quickmodes_f ( void ) {
	char	modeList[MAX_QUICKMODE_LIST_SIZE];
	char	arg1[64];

	trap_Argv( 1, arg1, sizeof(arg1) );
	
	if ( !arg1[0] ) {
		trap_Cvar_VariableStringBuffer( "__quickmodes", modeList, sizeof(modeList) );
		G_Printf("%s", modeList);
	} else {
		trap_SendConsoleCommand( EXEC_NOW, va("exec config/quickmodes/%s.cfg \n", arg1) );
	}

}
/*
==================
Scvmd_Teams_f
Primarily for debugging
lock/unlock teams
==================
*/
//FIXME: It's redundant having duplicate commands on the server, even if one is client and the other isn't.
void Svcmd_Teams_f( void ) {
	G_Printf(""S_COLOR_YELLOW"Team  Count  Locked Status\n---------------------------\n" );
	if ( g_gametype.integer >= GT_TEAM ) {
		G_Printf(""S_COLOR_YELLOW"Red   %3i      %5s\n",TeamCount(-1, TEAM_RED), (level.team_Locked[TEAM_RED]?("Locked"):("Unlocked")) );
		G_Printf(""S_COLOR_YELLOW"Blue  %3i      %5s\n",TeamCount(-1, TEAM_BLUE), (level.team_Locked[TEAM_BLUE]?("Locked"):("Unlocked")) );
		G_Printf(""S_COLOR_YELLOW"Spec  %3i\n",TeamCount(-1, TEAM_SPECTATOR) );
	} else {
		G_Printf(""S_COLOR_YELLOW"Free  %3i      %5s\n",TeamCount(-1, TEAM_FREE), (level.team_Locked[TEAM_FREE]?("Locked"):("Unlocked")) );
		G_Printf(""S_COLOR_YELLOW"Spec  %3i\n",TeamCount(-1, TEAM_SPECTATOR) );
	}
}
//FIXME: Locking and unlocking could be handled through the same function
/*
=================
Svcmd_lockteam_f
=================
*/
void Svcmd_lockteam_f ( void ) {
	char		str[MAX_TOKEN_CHARS];

	if (!g_allowLockedTeams.integer) {
		G_Printf("Not allowed to lockTeams\n");
		return;
	}


	trap_Argv( 1, str, sizeof( str ) );
	//G_Printf("DBG: lockteam: %s\n", str);
	if ( str[0] == 'b' || atoi(str) == TEAM_BLUE ) {
		level.team_Locked[TEAM_BLUE] = qtrue;
	} else if ( str[0] == 'r' || atoi(str) == TEAM_RED ) {
		level.team_Locked[TEAM_RED] = qtrue;
	} else if (str[0] == 'f' || atoi(str) == TEAM_FREE ) {
		level.team_Locked[TEAM_FREE] = qtrue;
	} else {
		G_Printf("Usage: lockTeam <team name>\n");
	}
}

/*
=================
Svcmd_unlockteam_f
=================
*/
void Svcmd_unlockteam_f ( void ) {
	char		str[MAX_TOKEN_CHARS];

		trap_Argv( 1, str, sizeof( str ) );
		if ( str[0] == 'b' || atoi(str) == TEAM_BLUE ) {
			level.team_Locked[TEAM_BLUE] = qfalse;
		} else if ( str[0] == 'r' || atoi(str) == TEAM_RED ) {
			level.team_Locked[TEAM_RED] = qfalse;
		} else if (str[0] == 'f' || atoi(str) == TEAM_FREE ) {
			level.team_Locked[TEAM_FREE] = qfalse;
		} else {
			G_Printf("Usage: unlockTeam <team name>\n");
		}
}

/*
=================
Svcmd_AdjustGameSettings_f

This is here to eliminate all the trap_'s that were being used.
The end result is less load to the server every time a shot is fired.
=================
*/
void Svcmd_AdjustGameSettings_f ( byte gs_type, byte gs_wep_num, byte gs_setting_num, char *value, char *name ) {
	int gs_setting_value = -1;//No values can have -1 because it's used to specify unset for now. -- Should be a qboolean

	if ( strlen(value) && trap_Argc() > 1) {
		//G_Printf("dbg: %s %i -- %i %i", value, trap_Argc());
		gs_setting_value = atoi(value);
	}

	switch ( gs_type ) {
		case GS_GLOBAL:
			switch ( gs_setting_num ) {
				case GS_ALLOW_TOSSFLAG:
					if ( gs_setting_value < 0 ) {
						G_Printf("%s is set to %i\n", name, gameSettings.allowTossflag);
					} else {
						gs_setting_value == 0?(gameSettings.allowTossflag = qfalse):(gameSettings.allowTossflag = qtrue);
					}
					break;
				case GS_SPAWN_ARMOR:
					if ( gs_setting_value < 0 ) {
						G_Printf("%s is set to %i\n", name, gameSettings.spawn_armor);
					} else {
						gameSettings.spawn_armor = gs_setting_value;
					}
					break;
				case GS_SPAWN_HEALTH:
					if ( gs_setting_value < 0 ) {
						G_Printf("%s is set to %i\n", name, gameSettings.spawn_health);
					} else {
						gameSettings.spawn_health = gs_setting_value;
					}
					break;
				case GS_PING_FIX:
					if ( gs_setting_value < 0 ) {
						G_Printf("%s is set to %i\n", name, gameSettings.ping_fix);
					} else {
						gameSettings.ping_fix = gs_setting_value;
						//G_Printf(" %i\n",gameSettings.ping_fix);
					}
					break;
			}
			break;
		case GS_MISSILE:
			if ( gs_setting_num < 0 ) {
				G_Printf("%s is set to %i\n", name, gameSettings.missiles[gs_wep_num][gs_setting_num]);
			} else {
				gameSettings.missiles[gs_wep_num][gs_setting_num] = gs_setting_value;
			}
			break;
		case GS_HITSCAN:
			if ( gs_setting_value < 0 ) {
				G_Printf("%s is set to %i\n", name, gameSettings.hitscans[gs_wep_num][gs_setting_num]);
			} else {
				gameSettings.hitscans[gs_wep_num][gs_setting_num] = gs_setting_value;
			}
			break;
		case GS_POWERUPS:
			if ( gs_setting_value < 0 ) {
				G_Printf("%s is set to %i\n", name, gameSettings.quadfactor_radius);
			} else {
				gameSettings.quadfactor_radius = gs_setting_value;
			}
			break;
		case GS_HOOK_SPEED:
			if ( gs_setting_value < 0 ) {
				G_Printf("%s is set to %i\n", name, gameSettings.hook_speed);
			} else {
				gameSettings.hook_speed = gs_setting_value;
			}
			break;
	}
}

/*
=================
Help
=================
*/

void Svcmd_Help_f(void)
{
//	char			*text_p, *prev;
	int				length = 0;//, linelength = 0;
//	int				j = 0, m = 0, l = 0, k = 0;
//	char			*line;
//	char			explanation[256];
//	char			checkChar[128];
	char			text[MAX_HELP_FILE_SIZE];
	char			filename[MAX_QPATH];
	char			arg1[128];
	char			tmp[513];
	char			*token, *ptr;
//	qboolean		helpList = qfalse;
//	char			newLine[32];
	fileHandle_t	f;
	int				i;

	trap_Argv(1, arg1, sizeof(arg1));

	Com_sprintf(filename, sizeof(filename), "config/help/server/en.help.cfg");

	if((length = trap_FS_FOpenFile(filename, &f, FS_READ)) <= 0)
	{
		Com_Printf(""S_COLOR_RED"Loading en.help.cfg failed! Failed to open the file\n");
		return;
	}

	if(length >= MAX_HELP_FILE_SIZE)
	{
		Com_Printf(""S_COLOR_RED"Loading en.help.cfg failed! File too large\n");
		return;
	}

	trap_FS_Read(text, length, f);
	text[length] = '\0';
	trap_FS_FCloseFile(f);

	if(!arg1[0])
	{
		//list all the available help commands
		if(!(token = HelpParse(arg1, text, qtrue)))
		{
			Com_Printf(""S_COLOR_RED"ERROR: Failed to read the help file\n", arg1);
			return;
		}

		length = strlen(token);
		if(length > 512)
		{
			//Com_Printf seems to have a limit to the length of a string that can be output
			//so we play it safe and break the output into 512 character chunks
			Com_Printf(""S_COLOR_CYAN"The following commands/cvars are available:\n");
			ptr = token;
			for(i = 0; i < (length / 512); i++)
			{
				if(i != ((length / 512) - 1))
				{
					memcpy(tmp, ptr, 512);
					tmp[512] = '\0';
				}
				else
				{
					memcpy(tmp, ptr, length - (i * 512));
					tmp[length - (i * 512)] = '\0';
				}

				Com_Printf(""S_COLOR_CYAN"%s", tmp);
				ptr += 512;
			}

			Com_Printf("\n");
		}
		else
			Com_Printf(""S_COLOR_CYAN"The following commands/cvars are available:\n%s\n", token);

		Com_Printf(""S_COLOR_CYAN"\n%s %s\n", GAMEVERSION, BUILDINFO);
		Com_Printf(""S_COLOR_CYAN"Usage: \\help command \n");
	}
	else
	{
		//list only the specified help command
		if(!(token = HelpParse(arg1, text, qfalse)))
		{
			Com_Printf(""S_COLOR_RED"ERROR: Command %s not found\n", arg1);
			return;
		}

		Com_Printf(""S_COLOR_CYAN"%s\n", token);
	}

#if 0
		char		*text_p, *prev;
		int			length = 0, linelength = 0;
		int			j = 0, m = 0, l = 0, k = 0;
		char		*line;
		char		explanation[256];
		char		checkChar[128];
		char		text[20000];
		char		filename[MAX_QPATH];
		char		arg1[128];
		char		*token;
		qboolean	helpList = qfalse;
		char		newLine[32];

		fileHandle_t	f;

		trap_Argv( 1, arg1, sizeof(arg1));

		Com_sprintf(filename, sizeof(filename), "config/help/server/en.help.cfg");

		length = trap_FS_FOpenFile( filename, &f, FS_READ );
		if ( length <= 0 ) {
			return;
		}

		trap_FS_Read( text, length, f );
		text[length] = 0;
		trap_FS_FCloseFile( f );
		//memset(&print, 0, sizeof(print));
		memset(&explanation, 0, sizeof(explanation));
		text_p = text;
			
		if ( strlen(arg1) == 0 && !( Q_stricmp(arg1, "help_list") == 0 ) ) {
			token = stristr(text_p, "help_list");
			helpList = qtrue;
		} else {
			token = stristr(text_p, arg1);	
		}
		
		if ( !helpList ) {
			Com_sprintf(explanation, sizeof(explanation), HelpParse(token));
			if ( strlen(explanation) < 3 ) {//No possible way this could be valid
				memset(explanation, 0, sizeof(explanation) );
				//Com_sprintf(explanation, sizeof(explanation), HelpParse("help_list"));
				token = stristr(text_p, "help_list");
				helpList = qtrue;
				G_Printf(""S_COLOR_RED"ERROR: Command %s not found.\n", arg1);
			}
		} /*else*/
		if ( helpList ) {
			qboolean	insertNewline = qfalse;
			qboolean	foundStart = qfalse;
			qboolean	foundEnd = qfalse;
			qboolean	start = qfalse;

			while ( 1 ) {
				prev = text_p; //so we can unget
				line = COM_Parse(&token);


				if ( (line[j - 1] == '{' || line[0] == '{') && !foundStart ) {
					foundStart = qtrue;
				}

				if ( foundStart ) {//This is consuming, but safe-ish
					memset(&checkChar, 0, sizeof(checkChar));
					Com_sprintf(checkChar, sizeof(checkChar), line );
					for ( l = 0; l != strlen(checkChar); l++ ) {
						if ( checkChar[l] == '}' ) {
							foundEnd = qtrue; //Use this to break the while loop
							break;//break this loop, no need to continue
						}
					}
				}

				if ( foundEnd ) {
					break;
				}

				if ( start ) {
					//This is a very good example of laziness
					//FixedName to align things, then point line to it..
					if ( m < 2 ) {
						m++;
						FixedName( newLine, line, 26 );
						line = newLine;//Re-pointer to avoid changing a bunch of code.
					} else {
						m = 0;
						insertNewline = qtrue;
					}
					j = strlen(newLine);

					if ( linelength + j > 1024 ) {
						//This voids the string limit to make sure all the columns get lined up.
						//Not exactly safe, careful for endless loops
						G_Printf("%s", explanation);
						memset(&explanation, 0, sizeof(explanation));
						linelength = 0;
					}
					linelength += j;
					Q_strcat(explanation, sizeof(explanation), va("%s", line));

					if ( insertNewline ) {
						k++;
						insertNewline = qfalse;
					//	linelength++;
					//	Q_strcat(explanation, sizeof(explanation), " ");
					//	linelength++;
					//	explanation[linelength] = '\n';
						/* Trying this */
						//Ideally we should do this, print every time we want a new line
						//for some reason it'd only add a new line 5 times, then stop.
						//This works around that.
						G_Printf("%s\n", explanation);
						memset(&explanation, 0, sizeof(explanation));
						linelength = 0;
					}

				}

				if ( foundStart && !start ) {
					start = qtrue;
				}
			}
		}
		
		G_Printf("%s\n", explanation);
		if ( helpList ) {
			G_Printf("\n %s %s\n", GAMEVERSION, BUILDINFO);
		}
#endif
}

/*
void Svcmd_ForceFlagSpawn_f( void ) {
	int i = 0;
	int j = 0;

	for ( i = 0; i < MAX_GENTITIES; i++ ) {
		if ( level.gentities[i].item && level.gentities[i].item->giType == IT_TEAM && level.gentities[i].item->giTag == PW_BLUEFLAG ) {
			j = i;
			break;
		}
	}

	//if ( !G_CallSpawn( &level.gentities[i] ) ) {
	//	G_FreeEntity( &level.gentities[i] );
	//}
	level.gentities[i].s.eFlags & ~EF_NODRAW;
}*/


/*
=================
ConsoleCommand

=================
*/
qboolean	ConsoleCommand( void ) {
	char	cmd[MAX_TOKEN_CHARS];

	trap_Argv( 0, cmd, sizeof( cmd ) );

	if ( Q_stricmp (cmd, "entitylist") == 0 ) {
		Svcmd_EntityList_f();
		return qtrue;
	}

	if ( Q_stricmp (cmd, "forceteam") == 0 ) {
		Svcmd_ForceTeam_f();
		return qtrue;
	}

	if (Q_stricmp (cmd, "game_memory") == 0) {
		Svcmd_GameMem_f();
		return qtrue;
	}

	if (Q_stricmp (cmd, "addbot") == 0) {
		Svcmd_AddBot_f();
		return qtrue;
	}

	if (Q_stricmp (cmd, "botlist") == 0) {
		Svcmd_BotList_f();
		return qtrue;
	}

	if (Q_stricmp (cmd, "abort_podium") == 0) {
		Svcmd_AbortPodium_f();
		return qtrue;
	}
/*
	if (Q_stricmp (cmd, "addip") == 0) {
		Svcmd_AddIP_f();
		return qtrue;
	}

	if (Q_stricmp (cmd, "removeip") == 0) {
		Svcmd_RemoveIP_f();
		return qtrue;
	}

	if (Q_stricmp (cmd, "listip") == 0) {
		trap_SendConsoleCommand( EXEC_NOW, "g_banIPs\n" );
		return qtrue;
	}
*/
	if (Q_stricmp (cmd, "banip") == 0 || Q_stricmp (cmd, "addip") == 0) {
		Svcmd_BanIP_f(qtrue);
		return qtrue;
	}

	if (Q_stricmp (cmd, "unbanip") == 0 || Q_stricmp (cmd, "removeip") == 0) {
		Svcmd_BanIP_f(qfalse);
		return qtrue;
	}

	if (Q_stricmp (cmd, "listbanips") == 0 || Q_stricmp (cmd, "listip") == 0) {
		Svcmd_ListBanIP_f();
		return qtrue;
	}

	if (Q_stricmp (cmd, "writeban") == 0) {
		G_WriteBans();
		return qtrue;
	}

	if (Q_stricmp (cmd, "players") == 0) {
		Svcmd_players_f();
		return qtrue;
	}

	if (Q_stricmp (cmd, "timeout") == 0) {
		char		str[MAX_TOKEN_CHARS];

		trap_Argv( 1, str, sizeof( str ) );
		level.match_time = atoi(str);
		if ( level.match_time == 0 ) {
			level.match_time = g_timeOutLength.integer;
		}
		Cmd_Timeout_f(level.match_time);
		return qtrue;
	}

	if (Q_stricmp (cmd, "timein") == 0) {
		char		str[MAX_TOKEN_CHARS];

		trap_Argv( 1, str, sizeof( str ) );
		level.match_time = atoi(str);
		if ( level.match_time == 0 ) {
			level.match_time = g_timeInGrace.integer;
		}
		Cmd_Timein_f(level.match_time);
		return qtrue;
	}

	if ( Q_stricmp (cmd, "lockteam") == 0 || Q_stricmp (cmd, "lock") == 0  ) {
		Svcmd_lockteam_f();
		return qtrue;
	}

	if ( Q_stricmp (cmd, "unlockteam") == 0 || Q_stricmp (cmd, "unlock") == 0 ) {
		Svcmd_unlockteam_f();
		return qtrue;
	}

	if ( Q_stricmp (cmd, "addtask") == 0 ) {
		G_LogPrintf( "Time: %i -- %s\n", level.time, ConcatArgs(0) );
		Svcmd_addtask_f();
		return qtrue;
	}

	if ( Q_stricmp (cmd, "removetask") == 0 ) {
		char		str[MAX_TOKEN_CHARS];
		int			taskNum;
		G_LogPrintf( "Time: %i -- %s\n", level.time, ConcatArgs(0) );
		trap_Argv(1, str, sizeof(str));
		if ( Q_stricmp ( str, "all" ) == 0 ) {
			memset(&tasks, 0, sizeof(&tasks));
			return qtrue;
		}
		taskNum = atoi(str);
		if ( taskNum < 0 || taskNum > (MAX_SERVER_TASKS - 1) ) {
			return qfalse;
		}
		memset( &(tasks[taskNum]), 0, sizeof(tasks[taskNum]) );
		return qtrue;
	}

	if ( Q_stricmp ( cmd, "removealltasks") == 0 ) {
		memset(&tasks, 0 ,sizeof(&tasks));
		return qtrue;
	}

	//monkk
	if (Q_stricmp (cmd, "mapnum") == 0) {
		Svcmd_MapNum_f();
		return qtrue;
	}

	if ( Q_stricmp (cmd, "maplist") == 0 ) {
		Svcmd_MapList_f();
		return qtrue;
	}

	if ( (Q_stricmp (cmd, "quickmodes") == 0) || (Q_stricmp (cmd, "quickmode") == 0) ) {
		Svcmd_Quickmodes_f();
		return qtrue;
	}

	if ( (Q_stricmp(cmd, "teams") == 0) ) {
		Svcmd_Teams_f();
		return qtrue;
	}

	/*****************
	//FIXME: The following are junk
	******************/
	if ( (Q_stricmp (cmd, "spawn_armor") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS] = "0";

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_GLOBAL, 0, GS_SPAWN_ARMOR, str2 , str );
		return qtrue;
	}
	
	if ( (Q_stricmp (cmd, "spawn_health") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_GLOBAL, 0, GS_SPAWN_HEALTH, str2 , str );
		return qtrue;
	}

	if ( (Q_stricmp (cmd, "hook_speed") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_HOOK_SPEED, 0, 0, str2 , str );
		return qtrue;
	}
	if ( (Q_stricmp (cmd, "quadfactor_radius") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_POWERUPS, 0, 0, str2 , str );
		return qtrue;
	}
	if ( (Q_stricmp (cmd, "allow_tossflag") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_GLOBAL, 0, GS_ALLOW_TOSSFLAG, str2 , str );
		return qtrue;
	}
	if ( (Q_stricmp (cmd, "rocket_radius") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_ROCKET, GS_RADIUS, str2 , str );
		return qtrue;
	}
	if ( (Q_stricmp (cmd, "rocket_damage") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_ROCKET, GS_DAMAGE, str2 , str );
		return qtrue;
	}
	if ( (Q_stricmp (cmd, "rocket_splash_damage") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_ROCKET, GS_SPLASH_DAMAGE, str2 , str );
		return qtrue;
	}
	if ( (Q_stricmp (cmd, "rocket_speed") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_ROCKET, GS_SPEED, str2 , str );
		return qtrue;
	}
	if ( (Q_stricmp (cmd, "rocket_time") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_ROCKET, GS_TIME, str2 , str );
		return qtrue;
	}
	if ( (Q_stricmp (cmd, "bfg_radius") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_BFG, GS_RADIUS, str2 , str );
		return qtrue;
	}
	if ( (Q_stricmp (cmd, "bfg_damage") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_BFG, GS_DAMAGE, str2 , str );
		return qtrue;
	}
	if ( (Q_stricmp (cmd, "bfg_splash_damage") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_BFG, GS_SPLASH_DAMAGE, str2 , str );
		return qtrue;
	}
	if ( (Q_stricmp (cmd, "bfg_speed") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_BFG, GS_SPEED, str2 , str );
		return qtrue;
	}
	if ( (Q_stricmp (cmd, "bfg_time") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_BFG, GS_TIME, str2 , str );
		return qtrue;
	}
	if ( (Q_stricmp (cmd, "grenade_radius") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_GRENADE, GS_RADIUS, str2 , str );
		return qtrue;
	}
	if ( (Q_stricmp (cmd, "grenade_damage") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_GRENADE, GS_DAMAGE, str2 , str );
		return qtrue;
	}
	if ( (Q_stricmp (cmd, "grenade_splash_damage") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_GRENADE, GS_SPLASH_DAMAGE, str2 , str );
		return qtrue;
	}
	if ( (Q_stricmp (cmd, "grenade_speed") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_GRENADE, GS_SPEED, str2 , str );
		return qtrue;
	}
	if ( (Q_stricmp (cmd, "grenade_time") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_GRENADE, GS_TIME, str2 , str );
		return qtrue;
	}
	if ( (Q_stricmp (cmd, "plasma_radius") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_PLASMA, GS_RADIUS, str2 , str );
		return qtrue;
	}
	if ( (Q_stricmp (cmd, "plasma_damage") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_PLASMA, GS_DAMAGE, str2 , str );
		return qtrue;
	}
	if ( (Q_stricmp (cmd, "plasma_splash_damage") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_PLASMA, GS_SPLASH_DAMAGE, str2 , str );
		return qtrue;
	}
	if ( (Q_stricmp (cmd, "plasma_speed") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_PLASMA, GS_SPEED, str2 , str );
		return qtrue;
	}
	if ( (Q_stricmp (cmd, "plasma_time") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_MISSILE, GS_PLASMA, GS_TIME, str2 , str );
		return qtrue;
	}
	if ( (Q_stricmp (cmd, "gauntlet_damage") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_HITSCAN, GS_GAUNTLET, GS_DAMAGE, str2 , str );
		return qtrue;
	}
	if ( (Q_stricmp (cmd, "gauntlet_range") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_HITSCAN, GS_GAUNTLET, GS_RANGE, str2 , str );
		return qtrue;
	}
	if ( (Q_stricmp (cmd, "shotgun_damage") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_HITSCAN, GS_SHOTGUN, GS_DAMAGE, str2 , str );
		return qtrue;
	}
	if ( (Q_stricmp (cmd, "railgun_damage") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_HITSCAN, GS_RAILGUN, GS_DAMAGE, str2 , str );
		return qtrue;
	}
	if ( (Q_stricmp (cmd, "railgun_range") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_HITSCAN, GS_RAILGUN, GS_RANGE, str2 , str );
		return qtrue;
	}
	if ( (Q_stricmp (cmd, "lightning_damage") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_HITSCAN, GS_LIGHTNING, GS_DAMAGE, str2 , str );
		return qtrue;
	}
	if ( (Q_stricmp (cmd, "lightning_range") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_HITSCAN, GS_LIGHTNING, GS_RANGE, str2 , str );
		return qtrue;
	}
	
	if ( (Q_stricmp (cmd, "machinegun_damage") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_HITSCAN, GS_MACHINEGUN, GS_DAMAGE, str2 , str );
		return qtrue;
	}
	
	if ( (Q_stricmp (cmd, "machinegun_teamplay_damage") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_HITSCAN, GS_MACHINEGUN, GS_RANGE, str2 , str );
		return qtrue;
	}

	if ( (Q_stricmp (cmd, "ping_fix") == 0) ) {
		char		str[MAX_TOKEN_CHARS];
		char		str2[MAX_TOKEN_CHARS];

		trap_Argv( 0, str, sizeof( str ) );
		trap_Argv( 1, str2, sizeof( str2 ) );
		Svcmd_AdjustGameSettings_f(GS_GLOBAL, 0, GS_PING_FIX, str2 , str );
		return qtrue;
	}

	/*****************
	//FIXME: The previous are junk
	******************/

	/*if ( (Q_stricmp (cmd, "forceFlagSpawn") == 0) ) {
		Svcmd_ForceFlagSpawn_f();
		return qtrue;
	}*/


	if ( Q_stricmp ( cmd, "playsound") == 0 ) {
		char		sound[MAX_TOKEN_CHARS];
		gentity_t	*tempEnt;

		trap_Argv(1, sound, sizeof(sound));
		if ( strlen(sound) > 4 ) { //.wav == 4
			if ( G_SoundIndex( sound ) ) { //If it's valid..
				tempEnt = G_TempEntity( NULL, EV_GLOBAL_SOUND );
				tempEnt->s.eventParm = G_SoundIndex( sound );
				tempEnt->r.svFlags |= SVF_BROADCAST;
			}
		} else {
			return qfalse;
		}
		
		return qtrue;
	}

	if ( (Q_stricmp( cmd, "tasks") == 0) || (Q_stricmp(cmd, "tasklist") == 0) ) {
		Svcmd_tasklist_f();
		return qtrue;
	}

	if ( Q_stricmp (cmd, "help") == 0 ) {
		Svcmd_Help_f();
		return qtrue;
	}

	if ( Q_stricmp (cmd, "mute") == 0 ) {
		Svcmd_mute_f();
		return qtrue;
	}

	if ( Q_stricmp (cmd, "unmute") == 0 ) {
		Svcmd_unmute_f();
		return qtrue;
	}

	if (g_dedicated.integer) {
		//char	message[1024];
		if (Q_stricmp (cmd, "say") == 0) {
			//message = ConcatArgs(1);
			//G_LogPrintf( "say: server: %s\n", message );
			G_LogPrintf( "say: server: %s\n", ConcatArgs(1) );
			G_Printf( "say: server: %s\n", ConcatArgs(1) );
			trap_SendServerCommand( -1, va("chat \"server%c%c%s\"", Q_COLOR_ESCAPE, COLOR_GREEN, ConcatArgs(1)));
			//trap_SendServerCommand( -1, va("print \"server: %s\n\"", ConcatArgs(1) ) );
			return qtrue;
		}
		// everything else will also be printed as a say command
		trap_SendServerCommand( -1, va("print \"server: %s", ConcatArgs(0) ) );
		G_Printf("\n");
		return qtrue;
	}

	return qfalse;
}

