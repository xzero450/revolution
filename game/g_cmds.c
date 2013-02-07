// Copyright (C) 1999-2000 Id Software, Inc.
//
#include "g_local.h"

#include "../../ui/menudef.h"			// for the voice chats

/*
==================
DeathmatchScoreboardMessage

This command is no longer bandwith effeceint, 1 string is sent for every set of client data
==================
*/
//byte		str[48] = {0};
void DeathmatchScoreboardMessage( gentity_t *ent ) {
	char		entry[156];//This might be too tight..
	char		string[1400];
	char		*tova;
	int			stringlength;
	int			i, position = 0;
	int			last_send = 0;
	gclient_t	*cl;
	byte		bytez[1400];
	//byte		test[5] = {255, 254, 253, 252, 251};
	int			numSorted, scoreFlags, accuracy, perfect;


	memset(&bytez, 0, sizeof(bytez));
	// send the latest information on all clients
	string[0] = 0;
	stringlength = 0;
	scoreFlags = 0;

	numSorted = level.numConnectedClients;

	//We do this first so we know to memset on the client
	//99 signals memset
	/*trap_SendServerCommand( ent-g_entities, va("scores 99 %i %i %i %i\n", numSorted, 
		level.teamScores[TEAM_RED], level.teamScores[TEAM_BLUE], level.stats_picked) );*/
	
	//These could be moved to the snap to save on bandwidth here
	bytez[position++] = 's';	//Num clients
	bytez[position++] = '1'; //Red score
	bytez[position++] = 's'; //Blue score
	bytez[position++] = ' '; //Weapons picked up for marquee minus gauntlet

	bytez[position++] = numSorted + 40;	//Num clients
	bytez[position++] = level.teamScores[TEAM_RED] + 40; //Red score
	bytez[position++] = level.teamScores[TEAM_BLUE] + 40; //Blue score
	bytez[position++] = level.stats_picked + 40; //Weapons picked up for marquee minus gauntlet

	for (i=0 ; i < numSorted ; i++) {
		int		ping = 0, time = 0, score = 0;

		cl = &level.clients[level.sortedClients[i]];

		if ( cl->pers.connected == CON_CONNECTING ) {
			ping = -1;
		} else {
			//Ping_fix 2 and 3 adjust ping to be "real"
			switch ( gameSettings.ping_fix ) {
				case 2:
					{
						int j;

						for ( j = 0; j < NUM_PING_SAMPLES; j++ ) {
							ping += cl->pers.pingsamples[j];
						}
						ping /= NUM_PING_SAMPLES;
						break;
					}
				case 3:
					ping = cl->ps.ping - cl->pers.ping_fix_adjustment;
					break;
				default:
					ping = cl->ps.ping;
					break;
			}
			ping = ping < 999 ? ping : 999;
		}

		if ( ping != 999 && ping >= 0 && (position + 5) > 1399 && cl->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR ) {
			break; //We're completely out of room.
		} else if ( position + 62 > 1399 ) {
			continue; //Skip over players when we run out of room for them
		}

		if( cl->accuracy_shots ) {
			accuracy = cl->accuracy_hits * 100 / cl->accuracy_shots;
			if ( accuracy > 100 ) {
				accuracy = 100;
			}
		} else {
			accuracy = 0;
		}
		perfect = ( cl->ps.persistant[PERS_RANK] == 0 && cl->ps.persistant[PERS_KILLED] == 0 ) ? 1 : 0;
	
//freeze
		if ( g_gamemode.integer > 3 ) {
			scoreFlags = cl->sess.wins;
		}
//freeze


		//FIXME: All + 64's need to be &= 64

		time = ((level.time - cl->pers.enterTime)/60000);
				bytez[position++] = level.sortedClients[i] + 40;	//ClientNum
		switch ( ping ) {
			case 999:
				//-2
				//G_Printf("DBG:LAG\n");
				bytez[position++] = 127;						//Ping
				bytez[position++] = 127;//Ping
				bytez[position++] = time / 63 + 64;
				bytez[position++] = time % 63 + 64;
				break;
				//When -2 only send the bare minimum to squeeze more into the string because the client has lagged out
			case -1:
				//Connecting
				//When connectiong only send the bare minimum to squeeze more into the string
				//G_Printf("DBG:CONN\n");
				bytez[position++] = 127;						//Ping
				bytez[position++] = 126;						//Ping
				bytez[position++] = time / 63 + 64;
				bytez[position++] = time % 63 + 64;
				break;
			default:
				//Everyone else
				//Send everything for this client
				switch ( cl->ps.persistant[PERS_TEAM] ) {
					case TEAM_SPECTATOR:
						//G_Printf("DBG:SPEC\n");
						//position++;
						bytez[position++] = ping / 63 + 64;				//Ping
						bytez[position++] = ping % 63 + 64;				//Ping
						bytez[position++] = time / 63 + 64;
						bytez[position++] = time % 63 + 64;
						break;
					default: //62
						//G_Printf("DBG:PLAYER\n");
						score = cl->ps.persistant[PERS_SCORE];
						if ( score < 0 ) {
							accuracy += 101;
							score *= -1;
						}

						bytez[position++] = ping / 63 + 64;				//Ping
						bytez[position++] = ping % 63 + 64;				//Ping
						bytez[position++] = time / 63 + 64;
						bytez[position++] = time % 63 + 64;
						bytez[position++] = cl->ps.persistant[PERS_SCORE] / 63 + 64;
						bytez[position++] = cl->ps.persistant[PERS_SCORE] % 63 + 64;
						bytez[position++] = scoreFlags / 63 + 64;
						bytez[position++] = scoreFlags % 63 + 64;
						bytez[position++] = g_entities[level.sortedClients[i]].s.powerups + 40; //This is not gonna work.
						bytez[position++] = accuracy / 63 + 64;
						bytez[position++] = accuracy % 63 + 64;
						bytez[position++] = cl->ps.persistant[PERS_IMPRESSIVE_COUNT] / 63 + 64; //This needs to be sent why?
						bytez[position++] = cl->ps.persistant[PERS_IMPRESSIVE_COUNT] % 63 + 64; // **
						bytez[position++] = cl->ps.persistant[PERS_EXCELLENT_COUNT] / 63 + 64; // **
						bytez[position++] = cl->ps.persistant[PERS_EXCELLENT_COUNT] % 63 + 64; // **
						bytez[position++] = cl->ps.persistant[PERS_GAUNTLET_FRAG_COUNT] / 63 + 64; // **
						bytez[position++] = cl->ps.persistant[PERS_GAUNTLET_FRAG_COUNT] % 63 + 64; // **
						bytez[position++] = cl->ps.persistant[PERS_DEFEND_COUNT] / 63 + 64; // **
						bytez[position++] = cl->ps.persistant[PERS_DEFEND_COUNT] % 63 + 64; // **
						bytez[position++] = cl->ps.persistant[PERS_ASSIST_COUNT] / 63 + 64; // **
						bytez[position++] = cl->ps.persistant[PERS_ASSIST_COUNT] % 63 + 64; // **
						bytez[position++] = perfect + 40; //Move this
						bytez[position++] = cl->ps.persistant[PERS_CAPTURES] / 63 + 64; // **
						bytez[position++] = cl->ps.persistant[PERS_CAPTURES] % 63 + 64; //This needs to be sent why?
						//Weapons
						bytez[position++] = cl->pers.stats_shots[WP_GAUNTLET] / 63 + 64;
						bytez[position++] = cl->pers.stats_shots[WP_GAUNTLET] % 63 + 64;
						bytez[position++] = cl->pers.stats_shots[WP_MACHINEGUN] / 63 + 64;
						bytez[position++] = cl->pers.stats_shots[WP_MACHINEGUN] % 63 + 64;
						bytez[position++] = cl->pers.stats_shots[WP_SHOTGUN] / 63 + 64;
						bytez[position++] = cl->pers.stats_shots[WP_SHOTGUN] % 63 + 64;
						bytez[position++] = cl->pers.stats_shots[WP_GRENADE_LAUNCHER] / 63 + 64;
						bytez[position++] = cl->pers.stats_shots[WP_GRENADE_LAUNCHER] % 63 + 64;
						bytez[position++] = cl->pers.stats_shots[WP_ROCKET_LAUNCHER] / 63 + 64;
						bytez[position++] = cl->pers.stats_shots[WP_ROCKET_LAUNCHER] % 63 + 64;
						bytez[position++] = cl->pers.stats_shots[WP_LIGHTNING] / 63 + 64;
						bytez[position++] = cl->pers.stats_shots[WP_LIGHTNING] % 63 + 64;
						bytez[position++] = cl->pers.stats_shots[WP_RAILGUN] / 63 + 64;
						bytez[position++] = cl->pers.stats_shots[WP_RAILGUN] % 63 + 64;
						bytez[position++] = cl->pers.stats_shots[WP_PLASMAGUN] / 63 + 64;
						bytez[position++] = cl->pers.stats_shots[WP_PLASMAGUN] % 63 + 64;
						bytez[position++] = cl->pers.stats_shots[WP_BFG] / 63 + 64;
						bytez[position++] = cl->pers.stats_shots[WP_BFG] % 63 + 64;
						bytez[position++] = cl->pers.stats_hits[WP_GAUNTLET] / 63 + 64;
						bytez[position++] = cl->pers.stats_hits[WP_GAUNTLET] % 63 + 64;
						bytez[position++] = cl->pers.stats_hits[WP_MACHINEGUN] / 63 + 64;
						bytez[position++] = cl->pers.stats_hits[WP_MACHINEGUN] % 63 + 64;
						bytez[position++] = cl->pers.stats_hits[WP_SHOTGUN] / 63 + 64;
						bytez[position++] = cl->pers.stats_hits[WP_SHOTGUN] % 63 + 64;
						bytez[position++] = cl->pers.stats_hits[WP_GRENADE_LAUNCHER] / 63 + 64;
						bytez[position++] = cl->pers.stats_hits[WP_GRENADE_LAUNCHER] % 63 + 64;
						bytez[position++] = cl->pers.stats_hits[WP_ROCKET_LAUNCHER] / 63 + 64;
						bytez[position++] = cl->pers.stats_hits[WP_ROCKET_LAUNCHER] % 63 + 64;
						bytez[position++] = cl->pers.stats_hits[WP_LIGHTNING] / 63 + 64;
						bytez[position++] = cl->pers.stats_hits[WP_LIGHTNING] % 63 + 64;
						bytez[position++] = cl->pers.stats_hits[WP_RAILGUN] / 63 + 64;
						bytez[position++] = cl->pers.stats_hits[WP_RAILGUN] % 63 + 64;
						bytez[position++] = cl->pers.stats_hits[WP_PLASMAGUN] / 63 + 64;
						bytez[position++] = cl->pers.stats_hits[WP_PLASMAGUN] % 63 + 64;
						bytez[position++] = cl->pers.stats_hits[WP_BFG] / 63 + 64;
						bytez[position++] = cl->pers.stats_hits[WP_BFG] % 63 + 64;
						//
						bytez[position++] = cl->ps.persistant[PERS_KILLED] / 63 + 64; //Not needed
						bytez[position++] = cl->ps.persistant[PERS_KILLED] % 63 + 64; //Not needed
						bytez[position++] = cl->pers.stats_specnum + 40; //Wrong area
						break;
				}
		}
		bytez[position++] = ' ';

		//Com_sprintf (entry, sizeof(entry),
		//	"%i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i",
		//	level.sortedClients[i],							//  1 - 1 byte
		//	cl->ps.persistant[PERS_SCORE],					//  2 - 2 byte
		//	ping,											//  3 - 2 byte && move this to slot 2 -- if it's -1, don't send the rest.
		//	(level.time - cl->pers.enterTime)/60000,		//  4 - 2 byte
		//	scoreFlags,										//  5 - 2 byte
		//	g_entities[level.sortedClients[i]].s.powerups,	//  6 - 1 byte
		//	accuracy,										//  7 - 2 byte && check for removal from message
		//	cl->ps.persistant[PERS_IMPRESSIVE_COUNT],		//  8 - 2 byte
		//	cl->ps.persistant[PERS_EXCELLENT_COUNT],		//  9 - 2 byte
		//	cl->ps.persistant[PERS_GAUNTLET_FRAG_COUNT],	// 10 - 2 byte
		//	cl->ps.persistant[PERS_DEFEND_COUNT],			// 11 - 2 byte
		//	cl->ps.persistant[PERS_ASSIST_COUNT],			// 12 - 2 byte
		//	perfect,										// 13 - 1 byte
		//	cl->ps.persistant[PERS_CAPTURES],				// 14 - 2 byte || we limit capturelimit to 255
		//	cl->pers.stats_shots[WP_GAUNTLET],				// 15 - 2 byte
		//	cl->pers.stats_shots[WP_MACHINEGUN],			// 16 - 2 byte
		//	cl->pers.stats_shots[WP_SHOTGUN],				// 17 - 2 byte
		//	cl->pers.stats_shots[WP_GRENADE_LAUNCHER],		// 18 - 2 byte
		//	cl->pers.stats_shots[WP_ROCKET_LAUNCHER],		// 19 - 2 byte
		//	cl->pers.stats_shots[WP_LIGHTNING],				// 20 - 2 byte
		//	cl->pers.stats_shots[WP_RAILGUN],				// 21 - 2 byte
		//	cl->pers.stats_shots[WP_PLASMAGUN],				// 22 - 2 byte
		//	cl->pers.stats_shots[WP_BFG],					// 23 - 2 byte
		//	cl->pers.stats_hits[WP_GAUNTLET],				// 24 - 2 byte
		//	cl->pers.stats_hits[WP_MACHINEGUN],				// 25 - 2 byte
		//	cl->pers.stats_hits[WP_SHOTGUN],				// 26 - 2 byte
		//	cl->pers.stats_hits[WP_GRENADE_LAUNCHER],		// 27 - 2 byte
		//	cl->pers.stats_hits[WP_ROCKET_LAUNCHER],		// 28 - 2 byte
		//	cl->pers.stats_hits[WP_LIGHTNING],				// 29 - 2 byte
		//	cl->pers.stats_hits[WP_RAILGUN],				// 30 - 2 byte
		//	cl->pers.stats_hits[WP_PLASMAGUN],				// 31 - 2 byte
		//	cl->pers.stats_hits[WP_BFG],					// 32 - 2 byte
		//	cl->pers.stats_deaths,							// 33 - 2 byte
		//	cl->pers.stats_specnum							// 34 - 1 byte
		//	);
		//	last_send++;
		//	trap_SendServerCommand( ent-g_entities, va("scores %s\n", entry ) );
	}

	//G_Printf("^2%s\n", bytez);
	memcpy(string, bytez,sizeof(string));
	//G_Printf("%s\n", bytez);
	//G_Printf("%s\n", string);
	//G_Printf("^5DBG:memcpy: %d %d %d %d %d -- %s\n", (int)str[0], (int)str[1], (int)str[2], (int)str[3], (int)str[4], str);
	trap_SendServerCommand( ent-g_entities, string );
	
}


/*
==================
Cmd_Score_f

Request current scoreboard information
==================
*/
void Cmd_Score_f( gentity_t *ent ) {
	DeathmatchScoreboardMessage( ent );
}



int FindMapNameForNumber( char* mapName, int mapNumber ) {
	char		filelist[5120];// > 410+ maps will show at this setting
	char*		fileptr;
	int			mapCnt, numfiles, filelen;

	numfiles = trap_FS_GetFileList( "maps", "bsp", filelist, sizeof(filelist) );
	fileptr = filelist;
	mapCnt = 0;
	for (mapCnt=0; mapCnt<numfiles; mapCnt++, fileptr += filelen+1)
	{
		filelen = strlen(fileptr);
		if( mapCnt == mapNumber ) {
			COM_StripExtension(fileptr,mapName);
			break;
		}
	}
	return numfiles;
}
/*
==================
Cmd_MapList_f

Request list of maps on the server
==================
*/
void Cmd_MapList_f( gentity_t *ent  ) {
	char		filelist[5120];// > 410+ maps will show at this setting
	char		mapName[MAX_QPATH];
	char		mapList[MAX_MAPLIST_SIZE];
	char*		fileptr;
	char		entry[512];
	int			filelen, numfiles, mapCnt, entryLen, mapListLen, itemCnt;
	char		filter[MAX_QPATH];
	qboolean	filtering;
	//TODO:Evo: send an ugly string to the client to reformat with pretty 25 character columns so it'd easier to read
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
			trap_SendServerCommand(ent-g_entities, mapList);
			mapList[0] = 0;
			Q_strcat(mapList, sizeof(mapList), va("print \"%s",entry));
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
		trap_SendServerCommand(ent-g_entities, mapList);
	}
}

/*
==================
CheatsOk
==================
*/
qboolean	CheatsOk( gentity_t *ent ) {
	if ( !g_cheats.integer ) {
		trap_SendServerCommand( ent-g_entities, va("print \"Cheats are not enabled on this server.\n\""));
		return qfalse;
	}
	if ( ent->health <= 0 ) {
		trap_SendServerCommand( ent-g_entities, va("print \"You must be alive to use this command.\n\""));
		return qfalse;
	}
	return qtrue;
}

/*
==================
ClientNumberFromString

Returns a player number for either a number or name string
Returns -1 if invalid
==================
*/
int ClientNumberFromString( gentity_t *to, char *s ) {
	gclient_t	*cl;
	int			idnum;
	char		s2[MAX_STRING_CHARS];
	char		n2[MAX_STRING_CHARS];

	// numeric values are just slot numbers
	if (s[0] >= '0' && s[0] <= '9') {
		idnum = atoi( s );
		if ( idnum < 0 || idnum >= level.maxclients ) {
			trap_SendServerCommand( to-g_entities, va("print \"Bad client slot: %i\n\"", idnum));
			return -1;
		}

		cl = &level.clients[idnum];
		if ( cl->pers.connected != CON_CONNECTED ) {
			trap_SendServerCommand( to-g_entities, va("print \"Client %i is not active\n\"", idnum));
			return -1;
		}
		return idnum;
	}

	// check for a name match
	SanitizeString( s, s2 );
	for ( idnum=0,cl=level.clients ; idnum < level.maxclients ; idnum++,cl++ ) {
		if ( cl->pers.connected != CON_CONNECTED ) {
			continue;
		}
		SanitizeString( cl->pers.netname, n2 );
		if ( !strcmp( n2, s2 ) ) {
			return idnum;
		}
	}

	trap_SendServerCommand( to-g_entities, va("print \"User %s is not on the server\n\"", s));
	return -1;
}
/*
==================
Cmd_Weapon_f

==================
*/
void Cmd_Weapon_f ( gentity_t *ent ) {
	char		weapon[MAX_TOKEN_CHARS];
	//char		*weapon;
	int			weaponInt;

	//weapon = ConcatArgs( 1 );
	trap_Argv( 1, weapon, sizeof( weapon ) );
	weaponInt = atoi(weapon);

	/*if ( ent->client->frameAimType <= 2 ) {
		trap_SendServerCommand( ent-g_entities, va("print \"DBGRWS: Weapon:s:%s - Weapon:i:%i\n\"", weapon, weaponInt) );
	}*/

	if (weaponInt >= 0 && weaponInt <= 10) {
		ent->client->weaponSwitch = weaponInt;
	} else {
		ent->client->weaponSwitch = WP_BFG;
	}
}



/*
==================
Cmd_HitClients_f

==================
*/
void Cmd_HitClients_f (gentity_t *ent)
{
	char		*timeStampChar;
	int			timeStamp;
	char		*hitClientsChar;
	int			hitClients;
//	int			i,j;
	usercmd_t	*tmpCmd = 0;
	int			flag = 0;

	char		arg[MAX_TOKEN_CHARS];


	trap_Argv( 1, arg, sizeof( arg ) );


	timeStampChar = arg;
	timeStamp = atoi(timeStampChar);

	hitClientsChar = ConcatArgs( 2 );
	hitClients = atoi(hitClientsChar);

	ent->client->pers.hitTargetsIndex++;

	if (ent->client->pers.hitTargetsIndex > 255)
		ent->client->pers.hitTargetsIndex = 0;

	ent->client->pers.hitTargets[ent->client->pers.hitTargetsIndex].timeIndex = timeStamp;
	ent->client->pers.hitTargets[ent->client->pers.hitTargetsIndex].hitTargets = hitClients;

	/*

	ent->client->hitClient = hitClients;
	ent->client->hitClientTime = timeStamp;

	if (timeStamp)
	{
		for (j=0; j<256; j++)
		{
			if (ent->client->pers.fireStack[j] == timeStamp)
			{
				G_TimeShiftClient(ent, timeStamp, qfalse, ent);

				FireWeapon( ent, 0 );

				G_UnTimeShiftClient(ent);

				return;
			}
		}

	}
	*/

}



/*
==================
Cmd_Give_f

Give items to a client
==================
*/
void Cmd_Give_f (gentity_t *ent)
{
	char		*name;
	gitem_t		*it;
	int			i;
	qboolean	give_all;
	gentity_t		*it_ent;
	trace_t		trace;

	if ( !CheatsOk( ent ) ) {
		return;
	}

	name = ConcatArgs( 1 );

	if (Q_stricmp(name, "all") == 0)
		give_all = qtrue;
	else
		give_all = qfalse;

	if (give_all || Q_stricmp( name, "health") == 0)
	{
		ent->health = ent->client->ps.stats[STAT_MAX_HEALTH];
		if (!give_all)
			return;
	}

	if (give_all || Q_stricmp(name, "weapons") == 0)
	{
		ent->client->ps.stats[STAT_WEAPONS] = (1 << WP_NUM_WEAPONS) - 1 - 
			( 1 << WP_GRAPPLING_HOOK ) - ( 1 << WP_NONE );
		if (!give_all)
			return;
	}

	if (give_all || Q_stricmp(name, "ammo") == 0)
	{
		for ( i = 0 ; i < MAX_WEAPONS ; i++ ) {
			ent->client->ps.ammo[i] = 999;
		}
		if (!give_all)
			return;
	}

	if (give_all || Q_stricmp(name, "armor") == 0)
	{
		ent->client->ps.stats[STAT_ARMOR] = 200;

		if (!give_all)
			return;
	}

	if (Q_stricmp(name, "excellent") == 0) {
		ent->client->ps.persistant[PERS_EXCELLENT_COUNT]++;
		return;
	}
	if (Q_stricmp(name, "impressive") == 0) {
		ent->client->ps.persistant[PERS_IMPRESSIVE_COUNT]++;
		return;
	}
	if (Q_stricmp(name, "gauntletaward") == 0) {
		ent->client->ps.persistant[PERS_GAUNTLET_FRAG_COUNT]++;
		return;
	}
	if (Q_stricmp(name, "defend") == 0) {
		ent->client->ps.persistant[PERS_DEFEND_COUNT]++;
		return;
	}
	if (Q_stricmp(name, "assist") == 0) {
		ent->client->ps.persistant[PERS_ASSIST_COUNT]++;
		return;
	}

	// spawn a specific item right on the player
	if ( !give_all ) {
		it = BG_FindItem (name);
		if (!it) {
			return;
		}

		it_ent = G_Spawn();
		VectorCopy( ent->r.currentOrigin, it_ent->s.origin );
		it_ent->classname = it->classname;
		G_SpawnItem (it_ent, it);
		FinishSpawningItem(it_ent );
		memset( &trace, 0, sizeof( trace ) );
		Touch_Item (it_ent, ent, &trace);
		if (it_ent->inuse) {
			G_FreeEntity( it_ent );
		}
	}
}


/*
==================
Cmd_God_f

Sets client to godmode

argv(0) god
==================
*/
void Cmd_God_f (gentity_t *ent)
{
	char	*msg;

	if ( !CheatsOk( ent ) ) {
		return;
	}

	ent->flags ^= FL_GODMODE;
	if (!(ent->flags & FL_GODMODE) )
		msg = "godmode OFF\n";
	else
		msg = "godmode ON\n";

	trap_SendServerCommand( ent-g_entities, va("print \"%s\"", msg));
}


/*
==================
Cmd_Notarget_f

Sets client to notarget

argv(0) notarget
==================
*/
void Cmd_Notarget_f( gentity_t *ent ) {
	char	*msg;

	if ( !CheatsOk( ent ) ) {
		return;
	}

	ent->flags ^= FL_NOTARGET;
	if (!(ent->flags & FL_NOTARGET) )
		msg = "notarget OFF\n";
	else
		msg = "notarget ON\n";

	trap_SendServerCommand( ent-g_entities, va("print \"%s\"", msg));
}


/*
==================
Cmd_Noclip_f

argv(0) noclip
==================
*/
void Cmd_Noclip_f( gentity_t *ent ) {
	char	*msg;

	if ( !CheatsOk( ent ) ) {
		return;
	}

	if ( ent->client->noclip ) {
		msg = "noclip OFF\n";
	} else {
		msg = "noclip ON\n";
	}
	ent->client->noclip = !ent->client->noclip;

	trap_SendServerCommand( ent-g_entities, va("print \"%s\"", msg));
}


/*
==================
Cmd_LevelShot_f

This is just to help generate the level pictures
for the menus.  It goes to the intermission immediately
and sends over a command to the client to resize the view,
hide the scoreboard, and take a special screenshot
==================
*/
void Cmd_LevelShot_f( gentity_t *ent ) {
	if ( !CheatsOk( ent ) ) {
		return;
	}

	// doesn't work in single player
	if ( g_gametype.integer != 0 ) {
		trap_SendServerCommand( ent-g_entities, 
			"print \"Must be in g_gametype 0 for levelshot\n\"" );
		return;
	}

	BeginIntermission();
	trap_SendServerCommand( ent-g_entities, "clientLevelShot" );
}


/*
==================
Cmd_LevelShot_f

This is just to help generate the level pictures
for the menus.  It goes to the intermission immediately
and sends over a command to the client to resize the view,
hide the scoreboard, and take a special screenshot
==================
*/
void Cmd_TeamTask_f( gentity_t *ent ) {
	char userinfo[MAX_INFO_STRING];
	char		arg[MAX_TOKEN_CHARS];
	int task;
	int client = ent->client - level.clients;

	if ( trap_Argc() != 2 ) {
		return;
	}
	trap_Argv( 1, arg, sizeof( arg ) );
	task = atoi( arg );

	trap_GetUserinfo(client, userinfo, sizeof(userinfo));
	Info_SetValueForKey(userinfo, "teamtask", va("%d", task));
	trap_SetUserinfo(client, userinfo);
	ClientUserinfoChanged(client);
}



/*
=================
Cmd_Kill_f
=================
*/
void Cmd_Kill_f( gentity_t *ent ) {
/*freeze
	if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
freeze*/
	if ( (g_gamemode.integer > 3 && is_spectator( ent->client )) || 
		(g_gamemode.integer < 4 && ent->client->sess.sessionTeam == TEAM_SPECTATOR)) {
//freeze
		return;
	}
	if ( level.match_called == 1 ) {
		return;
	}
	if (ent->health <= 0) {
		return;
	}
	ent->flags &= ~FL_GODMODE;
	ent->client->ps.stats[STAT_HEALTH] = ent->health = -999;

	player_die (ent, ent, ent, 100000, MOD_SUICIDE);
}

/*
=================
BroadCastTeamChange

Let everyone know about a team change
=================
*/
void BroadcastTeamChange( gclient_t *client, int oldTeam )
{
	if ( client->sess.sessionTeam == TEAM_RED ) {
		trap_SendServerCommand( -1, va("cp \"%s" S_COLOR_WHITE " joined the red team.\n\"",
			client->pers.netname) );
	} else if ( client->sess.sessionTeam == TEAM_BLUE ) {
		trap_SendServerCommand( -1, va("cp \"%s" S_COLOR_WHITE " joined the blue team.\n\"",
		client->pers.netname));
	} else if ( client->sess.sessionTeam == TEAM_SPECTATOR && oldTeam != TEAM_SPECTATOR ) {
		trap_SendServerCommand( -1, va("cp \"%s" S_COLOR_WHITE " joined the spectators.\n\"",
		client->pers.netname));
	} else if ( client->sess.sessionTeam == TEAM_FREE ) {
		trap_SendServerCommand( -1, va("cp \"%s" S_COLOR_WHITE " joined the battle.\n\"",
		client->pers.netname));
	}
}

/*
=================
CheckForAutoUnlock
=================
*/
void CheckForAutoUnlock ( int team ) {
	//FIXME: Using a time hack to prevent auto-unlocking on map_restarts
	if ( level.waited[team] >= level.time ) {
		level.waited[team] = 0;
		if ( level.team_Locked[team] && TeamCount(-1, team) == 0 ) {
			level.team_Locked[team] = qfalse;
		}
	} else if ( level.waited[team] == 0 ) {
		level.waited[team] = level.time + 10000;
	}
}

/*
=================
SetTeam
=================
*/
void SetTeam( gentity_t *ent, char *s, qboolean forced ) {
	int					team, oldTeam;
	gclient_t			*client;
	int					clientNum;
	spectatorState_t	specState;
	int					specClient;
	int					teamLeader;

	//
	// see what change is requested
	//
	client = ent->client;
	oldTeam = client->sess.sessionTeam;

	clientNum = client - level.clients;
	specClient = 0;
	specState = SPECTATOR_NOT;
	if ( !Q_stricmp( s, "scoreboard" ) || !Q_stricmp( s, "score" )  ) {
		team = TEAM_SPECTATOR;
		specState = SPECTATOR_SCOREBOARD;
	} else if ( !Q_stricmp( s, "follow1" ) ) {
		team = TEAM_SPECTATOR;
		specState = SPECTATOR_FOLLOW;
		specClient = -1;
	} else if ( !Q_stricmp( s, "follow2" ) ) {
		team = TEAM_SPECTATOR;
		specState = SPECTATOR_FOLLOW;
		specClient = -2;
	} else if ( !Q_stricmp( s, "spectator" ) || !Q_stricmp( s, "s" ) ) {
		team = TEAM_SPECTATOR;
		specState = SPECTATOR_FREE;
	} else if ( g_gametype.integer >= GT_TEAM ) {
		// if running a team game, assign player to one of the teams
		specState = SPECTATOR_NOT;
		if ( !Q_stricmp( s, "red" ) || !Q_stricmp( s, "r" ) ) {
			if ( level.team_Locked[TEAM_RED] == qtrue && !forced ) {
				trap_SendServerCommand( ent->client->ps.clientNum, 
					"cp \"Red team is Locked\n\"" );
				team = oldTeam;
			} else {
				team = TEAM_RED;
			}
		} else if ( !Q_stricmp( s, "blue" ) || !Q_stricmp( s, "b" ) ) {
			if ( level.team_Locked[TEAM_BLUE] == qtrue && !forced ) {
				trap_SendServerCommand( ent->client->ps.clientNum, 
					"cp \"Blue team is Locked\n\"" );
				team = oldTeam;
			} else {
				team = TEAM_BLUE;
			}
		} else {
			// pick the team with the least number of players
			team = PickTeam( clientNum );
		}

		if ( g_teamForceBalance.integer  ) {
			int		counts[TEAM_NUM_TEAMS];

			counts[TEAM_BLUE] = TeamCount( ent->client->ps.clientNum, TEAM_BLUE );
			counts[TEAM_RED] = TeamCount( ent->client->ps.clientNum, TEAM_RED );

			// We allow a spread of two
			if ( team == TEAM_RED && counts[TEAM_RED] - counts[TEAM_BLUE] > 1 ) {
				trap_SendServerCommand( ent->client->ps.clientNum, 
					"cp \"Red team has too many players.\n\"" );
				return; // ignore the request
			}
			if ( team == TEAM_BLUE && counts[TEAM_BLUE] - counts[TEAM_RED] > 1 ) {
				trap_SendServerCommand( ent->client->ps.clientNum, 
					"cp \"Blue team has too many players.\n\"" );
				return; // ignore the request
			}

			// It's ok, the team we are switching to has less or same number of players
		}

	} else {
		// force them to spectators if there aren't any spots free
		team = TEAM_FREE;
	}

	
	// override decision if limiting the players
	if ( (g_gametype.integer == GT_TOURNAMENT)
		&& level.numNonSpectatorClients >= 2 ) {
		team = TEAM_SPECTATOR;
	} else if ( g_maxGameClients.integer > 0 && 
		level.numNonSpectatorClients >= g_maxGameClients.integer ) {
		team = TEAM_SPECTATOR;
	}

	//
	// decide if we will allow the change
	//
	//oldTeam = client->sess.sessionTeam;
	if ( team == oldTeam && team != TEAM_SPECTATOR ) {
		return;
	}

	//
	// execute the team change
	//

	// if the player was dead leave the body
	if ( client->ps.stats[STAT_HEALTH] <= 0 ) {
		CopyToBodyQue(ent);
	}

	// he starts at 'base'
	client->pers.teamState.state = TEAM_BEGIN;
	if ( oldTeam != TEAM_SPECTATOR ) {
		// Kill him (makes sure he loses flags, etc)
		ent->flags &= ~FL_GODMODE;
		ent->client->ps.stats[STAT_HEALTH] = ent->health = 0;
		player_die (ent, ent, ent, 100000, MOD_SUICIDE);

	}
	// they go to the end of the line for tournements
	if ( team == TEAM_SPECTATOR ) {
		client->sess.spectatorTime = level.time;
	}

	if ( level.team_Locked[team] ) {
		//FIXME: Needed fail-safe?
		return;
	}
	client->sess.sessionTeam = team;
	client->sess.spectatorState = specState;
	client->sess.spectatorClient = specClient;

	client->sess.teamLeader = qfalse;
	if ( team == TEAM_RED || team == TEAM_BLUE ) {
		teamLeader = TeamLeader( team );
		// if there is no team leader or the team leader is a bot and this client is not a bot
		if ( teamLeader == -1 || ( !(g_entities[clientNum].r.svFlags & SVF_BOT) && (g_entities[teamLeader].r.svFlags & SVF_BOT) ) ) {
			SetLeader( team, clientNum );
		}
	}
	// make sure there is a team leader on the team the player came from
	if ( oldTeam == TEAM_RED || oldTeam == TEAM_BLUE ) {
		CheckTeamLeader( oldTeam );
	}

	BroadcastTeamChange( client, oldTeam );

	// get and distribute relevent paramters
	ClientUserinfoChanged( clientNum );

	ClientBegin( clientNum );
}

/*
=================
StopFollowing

If the client being followed leaves the game, or you just want to drop
to free floating spectator mode
=================
*/
void StopFollowing( gentity_t *ent ) {
	ent->client->ps.persistant[ PERS_TEAM ] = TEAM_SPECTATOR;	
	/*freeze*/if ( g_gamemode.integer < 4 ) {
	ent->client->sess.sessionTeam = TEAM_SPECTATOR;	
	}
/*freeze*/
	SetClientViewAngle( ent, ent->client->ps.viewangles );
	ent->client->ps.stats[ STAT_HEALTH ] = ent->health = 100;
	memset( ent->client->ps.powerups, 0, sizeof ( ent->client->ps.powerups ) );
//freeze
	if ( g_gamemode.integer > 3 ) {
	ent->client->sess.spectatorState = SPECTATOR_FREE;
	ent->client->ps.pm_flags &= ~PMF_FOLLOW;
	ent->r.svFlags &= ~SVF_BOT;
	ent->client->ps.clientNum = ent - g_entities;
	}
}

/*
=================
Cmd_Team_f
=================
*/
void Cmd_Team_f( gentity_t *ent ) {
	int			oldTeam = ent->client->sess.sessionTeam;
	char		s[MAX_TOKEN_CHARS];

	if ( ent->client->sess.speconly & 2 && !sv_allowUnnamed.integer ) {
		trap_SendServerCommand( ent-g_entities, "print \"^3You're not allowed to join the game as UnnamedPlayer\n\"");
	}

	if ( trap_Argc() != 2 ) {
		switch ( oldTeam ) {
		case TEAM_BLUE:
			trap_SendServerCommand( ent-g_entities, "print \"Blue team\n\"" );
			break;
		case TEAM_RED:
			trap_SendServerCommand( ent-g_entities, "print \"Red team\n\"" );
			break;
		case TEAM_FREE:
			trap_SendServerCommand( ent-g_entities, "print \"Free team\n\"" );
			break;
		case TEAM_SPECTATOR:
			trap_SendServerCommand( ent-g_entities, "print \"Spectator team\n\"" );
			//FIXME: Add part of auto-unlock here?
			break;
		}
		return;
	}

	if ( ent->client->switchTeamTime > level.time ) {
		trap_SendServerCommand( ent-g_entities, "print \"May not switch teams more than once per 5 seconds.\n\"" );
		return;
	}

	// if they are playing a tournement game, count as a loss
	if ( (g_gametype.integer == GT_TOURNAMENT )
		&& ent->client->sess.sessionTeam == TEAM_FREE ) {
		ent->client->sess.losses++;
	}

//freeze
	if ( g_gamemode.integer > 3 && ent->freezeState ) {
		if ( ent->client->sess.spectatorState == SPECTATOR_FOLLOW ) {
			StopFollowing( ent );
		}
		return;
	}
//freeze
	trap_Argv( 1, s, sizeof( s ) );
	if ( s[0] == 'b' && level.team_Locked[TEAM_BLUE] || atoi(s) == TEAM_BLUE && level.team_Locked[TEAM_BLUE] ) {
		trap_SendServerCommand( ent-g_entities, "print \"Blue team is Locked\n\"" );
		return;
	} else if ( s[0] == 'r' && level.team_Locked[TEAM_RED] || atoi(s) == TEAM_RED && level.team_Locked[TEAM_RED] ) {
		trap_SendServerCommand( ent-g_entities, "print \"Red team is Locked\n\"" );
		return;
	} else if ( level.team_Locked[TEAM_FREE] ) {
		trap_SendServerCommand( ent-g_entities, "print \"Free team is Locked\n\"" );
		return;
	}

	SetTeam( ent, s, qfalse);

	if ( oldTeam != ent->client->sess.sessionTeam )
		ent->client->switchTeamTime = level.time + 5000;
}


/*
=================
Cmd_Follow_f
=================
*/
void Cmd_Follow_f( gentity_t *ent ) {
	int		i;
	char	arg[MAX_TOKEN_CHARS];

	if ( trap_Argc() != 2 ) {
		if ( ent->client->sess.spectatorState == SPECTATOR_FOLLOW ) {
			StopFollowing( ent );
		}
		return;
	}

	trap_Argv( 1, arg, sizeof( arg ) );
	i = ClientNumberFromString( ent, arg );
	if ( i == -1 ) {
		return;
	}

	// can't follow self
	if ( &level.clients[ i ] == ent->client ) {
		return;
	}

	// can't follow another spectator
//freeze
	if ( g_gamemode.integer > 3 ) {
		if ( ent->freezeState && !is_spectator( ent->client ) ) return;
	} else {
		if ( ent->client->sess.sessionTeam != TEAM_SPECTATOR && level.clients[ i ].sess.sessionTeam != ent->client->sess.sessionTeam ) return;
		}
	if ( (g_gamemode.integer > 3 && is_spectator( &level.clients[ i ] )) ||
		(g_gamemode.integer < 4 && level.clients[ i ].sess.sessionTeam == TEAM_SPECTATOR) ) {
/*freeze
	if ( level.clients[ i ].sess.sessionTeam == TEAM_SPECTATOR ) {
freeze*/
		return;
	}

	// if they are playing a tournement game, count as a loss
	if ( (g_gametype.integer == GT_TOURNAMENT )
		&& ent->client->sess.sessionTeam == TEAM_FREE ) {
		ent->client->sess.losses++;
	}

	// first set them to spectator
	if ( ent->client->sess.sessionTeam != TEAM_SPECTATOR ) {
		SetTeam( ent, "spectator", qfalse );
	}

	ent->client->sess.spectatorState = SPECTATOR_FOLLOW;
	ent->client->sess.spectatorClient = i;
}

/*
=================
Cmd_FollowCycle_f
=================
*/
void Cmd_FollowCycle_f( gentity_t *ent, int dir ) {
	int		clientnum;
	int		original;

//freeze
	if ( g_gamemode.integer > 3 ) {
		if ( ent->freezeState && !is_spectator( ent->client ) ) return;
		if ( Set_Client( ent ) ) return;
	}
//freeze
	// if they are playing a tournement game, count as a loss
	if ( (g_gametype.integer == GT_TOURNAMENT )
		&& ent->client->sess.sessionTeam == TEAM_FREE ) {
		ent->client->sess.losses++;
	}
	// first set them to spectator
	if ( ent->client->sess.spectatorState == SPECTATOR_NOT ) {
		SetTeam( ent, "spectator", qfalse );
	}

	if ( dir != 1 && dir != -1 ) {
		G_Error( "Cmd_FollowCycle_f: bad dir %i", dir );
	}

	clientnum = ent->client->sess.spectatorClient;
	original = clientnum;
	do {
		clientnum += dir;
		if ( clientnum >= level.maxclients ) {
			clientnum = 0;
		}
		if ( clientnum < 0 ) {
			clientnum = level.maxclients - 1;
		}

		// can only follow connected clients
		if ( level.clients[ clientnum ].pers.connected != CON_CONNECTED ) {
			continue;
		}

		// can't follow another spectator
//freeze
		if ( g_gamemode.integer > 3 ) {
		if ( &level.clients[ clientnum ] == ent->client ) {
			if ( ent->client->sess.spectatorState == SPECTATOR_FOLLOW ) {
				StopFollowing( ent );
				ent->client->ps.pm_flags |= PMF_TIME_KNOCKBACK;
				ent->client->ps.pm_time = 100;
				return;
			}
		}
		if ( g_entities[ clientnum ].freezeState ) continue;
		} else {
		if ( ent->client->sess.sessionTeam != TEAM_SPECTATOR && level.clients[ clientnum ].sess.sessionTeam != ent->client->sess.sessionTeam ) continue;
		}
		if ( (g_gamemode.integer > 3 && is_spectator( &level.clients[ clientnum ] )) || 
			(g_gamemode.integer < 4 && level.clients[ clientnum ].sess.sessionTeam == TEAM_SPECTATOR) ) {
/*freeze
		if ( level.clients[ clientnum ].sess.sessionTeam == TEAM_SPECTATOR ) {
freeze*/
			continue;
		}

		// this is good, we can use it
		ent->client->sess.spectatorClient = clientnum;
		ent->client->sess.spectatorState = SPECTATOR_FOLLOW;
		return;
	} while ( clientnum != original );

	// leave it where it was
}


/*
==================
G_Say
==================
*/

static void G_SayTo( gentity_t *ent, gentity_t *other, int mode, int color, const char *name, const char *message ) {
	if (!other) {
		return;
	}
	if (!other->inuse) {
		return;
	}
	if (!other->client) {
		return;
	}
	if ( other->client->pers.connected != CON_CONNECTED ) {
		return;
	}
	if ( mode == SAY_TEAM  && other->client->sess.sessionTeam != ent->client->sess.sessionTeam ) { 
	// Spectators can't see say_team chat when used by players in tournament/free-for-all
		return;
	}

	// no chatting to players in tournements
	if ( (g_gametype.integer == GT_TOURNAMENT )
		&& other->client->sess.sessionTeam == TEAM_FREE
		&& ent->client->sess.sessionTeam != TEAM_FREE && g_muteTourneyspecs.integer == 1 ) {
		return;
	}
		//Mute spectators		
	if ((g_gametype.integer != GT_TOURNAMENT && g_muteSpecs.integer == 1)
		&& other->client->sess.sessionTeam != TEAM_SPECTATOR
		&& ent->client->sess.sessionTeam == TEAM_SPECTATOR )	{ 
		return; 
	}

	trap_SendServerCommand( other-g_entities, va("%s \"%s%c%c%s\"", 
		mode == SAY_TEAM ? "tchat" : "chat",
		name, Q_COLOR_ESCAPE, color, message));
}

#define EC		"\x19"

void G_Say( gentity_t *ent, gentity_t *target, int mode, const char *chatText ) {
	int			j;
	gentity_t	*other;
	int			color;
	char		name[64];
	// don't let text be too long for malicious reasons
	char		text[MAX_SAY_TEXT];
	char		location[64];

	/*if ( g_gametype.integer < GT_TEAM && mode == SAY_TEAM ) {
		mode = SAY_ALL;
	}
	No real need to do this anymore.
	*/

	switch ( mode ) {
	default:
	case SAY_ALL:
		G_LogPrintf( "say: %s: %s\n", ent->client->pers.netname, chatText );
		Com_sprintf (name, sizeof(name), "%s%c%c"EC": ", ent->client->pers.netname, Q_COLOR_ESCAPE, COLOR_WHITE );
		color = COLOR_GREEN;
		break;
	case SAY_TEAM:
		G_LogPrintf( "sayteam: %s: %s\n", ent->client->pers.netname, chatText );
		if (Team_GetLocationMsg(ent, location, sizeof(location)))
			Com_sprintf (name, sizeof(name), EC"(%s%c%c"EC") (%s)"EC": ", 
				ent->client->pers.netname, Q_COLOR_ESCAPE, COLOR_WHITE, location);
		else
			Com_sprintf (name, sizeof(name), EC"(%s%c%c"EC")"EC": ", 
				ent->client->pers.netname, Q_COLOR_ESCAPE, COLOR_WHITE );
		color = COLOR_CYAN;
		break;
	case SAY_TELL:
		if (target && g_gametype.integer >= GT_TEAM &&
			target->client->sess.sessionTeam == ent->client->sess.sessionTeam &&
			Team_GetLocationMsg(ent, location, sizeof(location)))
			Com_sprintf (name, sizeof(name), EC"[%s%c%c"EC"] (%s)"EC": ", ent->client->pers.netname, Q_COLOR_ESCAPE, COLOR_WHITE, location );
		else
			Com_sprintf (name, sizeof(name), EC"[%s%c%c"EC"]"EC": ", ent->client->pers.netname, Q_COLOR_ESCAPE, COLOR_WHITE );
		color = COLOR_MAGENTA;
		break;
	}

	Q_strncpyz( text, chatText, sizeof(text) );

	if ( target ) {
		G_SayTo( ent, target, mode, color, name, text );
		return;
	}

	// echo the text to the console
	if ( g_dedicated.integer ) {
		G_Printf( "%s%s\n", name, text);
	}

	// send it to all the apropriate clients
	for (j = 0; j < level.maxclients; j++) {
		other = &g_entities[j];
		G_SayTo( ent, other, mode, color, name, text );
	}
}


/*
==================
Cmd_Say_f
==================
*/
static void Cmd_Say_f( gentity_t *ent, int mode, qboolean arg0 ) {
	char		*p;

	if ( trap_Argc () < 2 && !arg0 ) {
		return;
	}

	if ( ent->client->mutestatus && (mode != SAY_TEAM && g_gametype.integer >= GT_TEAM) ) {
		trap_SendServerCommand( ent-g_entities, "print \"^1You have been muted!\n" );
		return;
	}

	if (arg0) {
		p = ConcatArgs( 0 );
	} else {
		p = ConcatArgs( 1 );
	}

	G_Say( ent, NULL, mode, p );
}

/*
==================
Cmd_Tell_f
==================
*/
static void Cmd_Tell_f( gentity_t *ent ) {
	int			targetNum;
	gentity_t	*target;
	char		*p;
	char		arg[MAX_TOKEN_CHARS];

	if ( trap_Argc () < 2 ) {
		return;
	}

	trap_Argv( 1, arg, sizeof( arg ) );
	targetNum = atoi( arg );
	if ( targetNum < 0 || targetNum >= level.maxclients ) {
		return;
	}

	target = &g_entities[targetNum];
	if ( !target || !target->inuse || !target->client ) {
		return;
	}

	p = ConcatArgs( 2 );

	G_LogPrintf( "tell: %s to %s: %s\n", ent->client->pers.netname, target->client->pers.netname, p );
	G_Say( ent, target, SAY_TELL, p );
	// don't tell to the player self if it was already directed to this player
	// also don't send the chat back to a bot
	if ( ent != target && !(ent->r.svFlags & SVF_BOT)) {
		G_Say( ent, ent, SAY_TELL, p );
	}
}


static void G_VoiceTo( gentity_t *ent, gentity_t *other, int mode, const char *id, qboolean voiceonly ) {
	int color;
	char *cmd;

	if (!other) {
		return;
	}
	if (!other->inuse) {
		return;
	}
	if (!other->client) {
		return;
	}
	if ( mode == SAY_TEAM && !OnSameTeam(ent, other) ) {
		return;
	}
	// no chatting to players in tournements
	if ( (g_gametype.integer == GT_TOURNAMENT )) {
		return;
	}

	if (mode == SAY_TEAM) {
		color = COLOR_CYAN;
		cmd = "vtchat";
	}
	else if (mode == SAY_TELL) {
		color = COLOR_MAGENTA;
		cmd = "vtell";
	}
	else {
		color = COLOR_GREEN;
		cmd = "vchat";
	}

	trap_SendServerCommand( other-g_entities, va("%s %d %d %d %s", cmd, voiceonly, ent->s.number, color, id));
}

void G_Voice( gentity_t *ent, gentity_t *target, int mode, const char *id, qboolean voiceonly ) {
	int			j;
	gentity_t	*other;

	if ( g_gametype.integer < GT_TEAM && mode == SAY_TEAM ) {
		mode = SAY_ALL;
	}

	if ( target ) {
		G_VoiceTo( ent, target, mode, id, voiceonly );
		return;
	}

	// echo the text to the console
	if ( g_dedicated.integer ) {
		G_Printf( "voice: %s %s\n", ent->client->pers.netname, id);
	}

	// send it to all the apropriate clients
	for (j = 0; j < level.maxclients; j++) {
		other = &g_entities[j];
		G_VoiceTo( ent, other, mode, id, voiceonly );
	}
}

/*
==================
Cmd_Voice_f
==================
*/
static void Cmd_Voice_f( gentity_t *ent, int mode, qboolean arg0, qboolean voiceonly ) {
	char		*p;

	if ( trap_Argc () < 2 && !arg0 ) {
		return;
	}

	if (arg0)
	{
		p = ConcatArgs( 0 );
	}
	else
	{
		p = ConcatArgs( 1 );
	}

	G_Voice( ent, NULL, mode, p, voiceonly );
}

/*
==================
Cmd_VoiceTell_f
==================
*/
static void Cmd_VoiceTell_f( gentity_t *ent, qboolean voiceonly ) {
	int			targetNum;
	gentity_t	*target;
	char		*id;
	char		arg[MAX_TOKEN_CHARS];

	if ( trap_Argc () < 2 ) {
		return;
	}

	trap_Argv( 1, arg, sizeof( arg ) );
	targetNum = atoi( arg );
	if ( targetNum < 0 || targetNum >= level.maxclients ) {
		return;
	}

	target = &g_entities[targetNum];
	if ( !target || !target->inuse || !target->client ) {
		return;
	}

	id = ConcatArgs( 2 );

	G_LogPrintf( "vtell: %s to %s: %s\n", ent->client->pers.netname, target->client->pers.netname, id );
	G_Voice( ent, target, SAY_TELL, id, voiceonly );
	// don't tell to the player self if it was already directed to this player
	// also don't send the chat back to a bot
	if ( ent != target && !(ent->r.svFlags & SVF_BOT)) {
		G_Voice( ent, ent, SAY_TELL, id, voiceonly );
	}
}


/*
==================
Cmd_VoiceTaunt_f
==================
*/
static void Cmd_VoiceTaunt_f( gentity_t *ent ) {
	gentity_t *who;
	int i;

	if (!ent->client) {
		return;
	}

	// insult someone who just killed you
	if (ent->enemy && ent->enemy->client && ent->enemy->client->lastkilled_client == ent->s.number) {
		// i am a dead corpse
		if (!(ent->enemy->r.svFlags & SVF_BOT)) {
			G_Voice( ent, ent->enemy, SAY_TELL, VOICECHAT_DEATHINSULT, qfalse );
		}
		if (!(ent->r.svFlags & SVF_BOT)) {
			G_Voice( ent, ent,        SAY_TELL, VOICECHAT_DEATHINSULT, qfalse );
		}
		ent->enemy = NULL;
		return;
	}
	// insult someone you just killed
	if (ent->client->lastkilled_client >= 0 && ent->client->lastkilled_client != ent->s.number) {
		who = g_entities + ent->client->lastkilled_client;
		if (who->client) {
			// who is the person I just killed
			if (who->client->lasthurt_mod == MOD_GAUNTLET) {
				if (!(who->r.svFlags & SVF_BOT)) {
					G_Voice( ent, who, SAY_TELL, VOICECHAT_KILLGAUNTLET, qfalse );	// and I killed them with a gauntlet
				}
				if (!(ent->r.svFlags & SVF_BOT)) {
					G_Voice( ent, ent, SAY_TELL, VOICECHAT_KILLGAUNTLET, qfalse );
				}
			} else {
				if (!(who->r.svFlags & SVF_BOT)) {
					G_Voice( ent, who, SAY_TELL, VOICECHAT_KILLINSULT, qfalse );	// and I killed them with something else
				}
				if (!(ent->r.svFlags & SVF_BOT)) {
					G_Voice( ent, ent, SAY_TELL, VOICECHAT_KILLINSULT, qfalse );
				}
			}
			ent->client->lastkilled_client = -1;
			return;
		}
	}

	if (g_gametype.integer >= GT_TEAM) {
		// praise a team mate who just got a reward
		for(i = 0; i < MAX_CLIENTS; i++) {
			who = g_entities + i;
			if (who->client && who != ent && who->client->sess.sessionTeam == ent->client->sess.sessionTeam) {
				if (who->client->rewardTime > level.time) {
					if (!(who->r.svFlags & SVF_BOT)) {
						G_Voice( ent, who, SAY_TELL, VOICECHAT_PRAISE, qfalse );
					}
					if (!(ent->r.svFlags & SVF_BOT)) {
						G_Voice( ent, ent, SAY_TELL, VOICECHAT_PRAISE, qfalse );
					}
					return;
				}
			}
		}
	}

	// just say something
	G_Voice( ent, NULL, SAY_ALL, VOICECHAT_TAUNT, qfalse );
}



static char	*gc_orders[] = {
	"hold your position",
	"hold this position",
	"come here",
	"cover me",
	"guard location",
	"search and destroy",
	"report"
};

void Cmd_GameCommand_f( gentity_t *ent ) {
	int		player;
	int		order;
	char	str[MAX_TOKEN_CHARS];

	trap_Argv( 1, str, sizeof( str ) );
	player = atoi( str );
	trap_Argv( 2, str, sizeof( str ) );
	order = atoi( str );

	if ( player < 0 || player >= MAX_CLIENTS ) {
		return;
	}
	if ( order < 0 || order > sizeof(gc_orders)/sizeof(char *) ) {
		return;
	}
	G_Say( ent, &g_entities[player], SAY_TELL, gc_orders[order] );
	G_Say( ent, ent, SAY_TELL, gc_orders[order] );
}

/*
==================
Cmd_Where_f
==================
*/
void Cmd_Where_f( gentity_t *ent ) {
	trap_SendServerCommand( ent-g_entities, va("print \"%s\n\"", vtos( ent->s.origin ) ) );
}

static const char *gameNames[] = {
	"Free For All",
	"Tournament",
	"Single Player",
	"Team Deathmatch",
	"Capture the Flag",
	"One Flag CTF",
	"Overload",
	"Harvester"
};

/*
==================
Cmd_Quickmodes_f
==================
*/
void Cmd_Quickmodes_f( gentity_t *ent) {
	char	modeList[MAX_QUICKMODE_LIST_SIZE];

	trap_Cvar_VariableStringBuffer( "__quickmodes", modeList, sizeof(modeList) );
	//G_Printf("DBG: Quickmodes %s\n", modeList);
	trap_SendServerCommand( ent-g_entities, va("print \"%s\n\"", modeList) );
}

/*
==================
Cmd_Teams_f
Primarily for debugging
lock/unlock teams
==================
*/
void Cmd_Teams_f(  gentity_t *ent ) {
	//FIXME: Bandwidth consumption.
	trap_SendServerCommand( ent-g_entities, "print \""S_COLOR_YELLOW"Team  Count  Locked Status\n---------------------------\n\"" );
	if ( g_gametype.integer >= GT_TEAM ) {
		trap_SendServerCommand( ent-g_entities, va("print \""S_COLOR_YELLOW"Red   %3i      %5s\n\"",TeamCount(-1, TEAM_RED), (level.team_Locked[TEAM_RED]?("Locked"):("Unlocked")) ) );
		trap_SendServerCommand( ent-g_entities, va("print \""S_COLOR_YELLOW"Blue  %3i      %5s\n\"",TeamCount(-1, TEAM_BLUE), (level.team_Locked[TEAM_BLUE]?("Locked"):("Unlocked")) ) );
		trap_SendServerCommand( ent-g_entities, va("print \""S_COLOR_YELLOW"Spec  %3i\n\"",TeamCount(-1, TEAM_SPECTATOR) ) );
	} else {
		trap_SendServerCommand( ent-g_entities, va("print \""S_COLOR_YELLOW"Free  %3i      %5s\n\"",TeamCount(-1, TEAM_FREE), (level.team_Locked[TEAM_FREE]?("Locked"):("Unlocked")) ) );
		trap_SendServerCommand( ent-g_entities, va("print \""S_COLOR_YELLOW"Spec  %3i\n\"",TeamCount(-1, TEAM_SPECTATOR) ) );
	}
}

/*
==================
CheckVote
==================
*/
void CheckVote( void ) {
	// ATVI Q3 1.32 Patch #9, WNF
	if ( level.voteYes > level.numVotingClients/2 || ( level.match_called == 1 && level.numVotingClients == 2) ) {
		gentity_t	*tempEnt;

		tempEnt = G_TempEntity( NULL, EV_GLOBAL_SOUND );
		tempEnt->s.eventParm = G_SoundIndex( "sound/world/klaxon2.wav" );
		tempEnt->r.svFlags |= SVF_BROADCAST;
		// execute the command, then remove the vote
		trap_SendServerCommand( -1, "print \"Vote passed.\n\"" );
		level.voteYes = 128;
		if ( level.match_called == 1 ) {
			level.match_called = 0;
			if ( g_gametype.integer >= GT_TEAM ) {
				level.match_team[level.voteTeam]++;
				level.voteTeam = -1;
			}
			if ( level.match_time == 0 ) {
				level.match_time = g_timeOutLength.integer;
			}
			Cmd_Timeout_f(level.match_time);
		} else if ( level.match_called == -1 ) {
			//level.match_called = 0;
			if ( level.match_timeinGrace == 0 ) {
				level.match_timeinGrace = g_timeInGrace.integer;
			}
			Cmd_Timein_f(level.match_timeinGrace);
		} else {
			level.voteExecuteTime = level.time + 3000;
		}
	} else if ( level.voteNo >= level.numVotingClients/2 ) {
		// same behavior as a timeout
		trap_SendServerCommand( -1, "print \"Vote failed.\n\"" );
	} else {
		// still waiting for a majority
		return;
	}
	//level.voteTime = 0;
	//trap_SetConfigstring( CS_VOTE_TIME, "" );
	trap_SendServerCommand( -1, "vt -1\n" );
}

/*
==================
Cmd_CallVote_f
==================
*/
void Cmd_CallVote_f( gentity_t *ent ) {
	int		i;
	char	arg1[MAX_STRING_TOKENS];
	char	arg2[MAX_STRING_TOKENS];
	char	cvarName[128];

	level.voteTeam = ent->client->sess.sessionTeam;


	if ( !g_allowVote.integer ) {
		trap_SendServerCommand( ent-g_entities, "print \"Voting not allowed here.\n\"" );
		return;
	}

	if ( level.voteTime ) {
		trap_SendServerCommand( ent-g_entities, "print \"A vote is already in progress.\n\"" );
		return;
	}
	
	if ( level.voteExecuteTime != 0 ) {
		trap_SendServerCommand( ent-g_entities, "print \"A vote is in the progress of executing.\n\"" );
		return;
	}
	if ( ent->client->pers.voteCount >= MAX_VOTE_COUNT ) {
		trap_SendServerCommand( ent-g_entities, "print \"You have called the maximum number of votes.\n\"" );
		return;
	}
	if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
		trap_SendServerCommand( ent-g_entities, "print \"Not allowed to call a vote as spectator.\n\"" );
		return;
	}

	// make sure it is a valid command to vote on
	trap_Argv( 1, arg1, sizeof( arg1 ) );
	trap_Argv( 2, arg2, sizeof( arg2 ) );

	Com_sprintf(cvarName, sizeof(cvarName), "disable_%s", arg1);
	if( trap_Cvar_VariableIntegerValue(cvarName) ) {
		trap_SendServerCommand( ent-g_entities, va("print \"callvote for %s is disabled.\n\"",arg1) );
		return;
	}


	if( strchr( arg1, ';' ) || strchr( arg2, ';' ) ) {
		trap_SendServerCommand( ent-g_entities, "print \"Invalid vote string.\n\"" );
		return;
	}

	if ( level.intermissiontime && !( !Q_stricmp(arg1, "map") || !Q_stricmp(arg1, "map_restart") 
		|| !Q_stricmp(arg1, "nextmap") || !Q_stricmp(arg1, "previousmap") ) ) {
			//If not an allowed intermission vote, ignore it during intermission.
			return;
	}

	if ( //if not equal to any of these
	   Q_stricmp( arg1, "map_restart" )					&& Q_stricmp( arg1, "previousmap" )		
	&& Q_stricmp( arg1, "nextmap" )						&& Q_stricmp( arg1, "map" )
	&& Q_stricmp( arg1, "g_gametype" )					&& Q_stricmp( arg1, "kick" )
	&& Q_stricmp( arg1, "clientkick" )					&& Q_stricmp( arg1, "g_warmup" )
	&& Q_stricmp( arg1, "timelimit" )					&& Q_stricmp( arg1, "fraglimit" )
	&& Q_stricmp( arg1, "g_muteSpecs" )					&& Q_stricmp( arg1, "g_muteTourneyspecs" )
	&& Q_stricmp( arg1, "weap_plasmagunCycle" )			&& Q_stricmp( arg1, "weap_railgunCycle" )
	&& Q_stricmp( arg1, "weap_rocketlauncherCycle" )	&& Q_stricmp( arg1, "weap_lightninggunCycle" )
	&& Q_stricmp( arg1, "weap_grenadelauncherCycle" )	&& Q_stricmp( arg1, "weap_shotgunCycle" )
	&& Q_stricmp( arg1, "weap_machinegunCycle" )		&& Q_stricmp( arg1, "weap_bfgCycle" )
	&& Q_stricmp( arg1, "g_DynamicRailgunCycle" )		&& Q_stricmp( arg1, "g_RailJumping" )
	&& Q_stricmp( arg1, "g_railgunKnockback" )			&& Q_stricmp( arg1, "g_StaticKnockback" )
	&& Q_stricmp( arg1, "g_returnFlag" )				&& Q_stricmp( arg1, "g_SelfDamage" )
	&& Q_stricmp( arg1, "g_FallingDamage" )				&& Q_stricmp( arg1, "timeout" )
	&& Q_stricmp( arg1, "timein" )						&& Q_stricmp( arg1, "g_gamemode" )
	&& Q_stricmp( arg1, "g_pro_mode" )					&& Q_stricmp( arg1, "g_IU_ctf_Sounds" )
	&& Q_stricmp( arg1, "g_teamKnockback" )				&& Q_stricmp( arg1, "mapnum" )
	&& Q_stricmp( arg1, "quickmode" )
	) {
		char	string[MAX_STRING_TOKENS];
		//int		stringLen;
		int		totalStringLen = 0;

		memset(cvarName, 0, sizeof(cvarName));
		memset(string, 0, sizeof(string));

		if ( strlen(arg1) ) {
			trap_SendServerCommand( ent-g_entities, "print \"Invalid vote string.\n\"" );
		}
		
		/***************************************************************
		This is some pretty ugly shit, and the end print out isn't too
		much better. This is a step in the correct direction, however
		These should be aligned into columns, 3 total. That being done
		would require padding:
		Com_sprintf(destVar, size, "%30s", cvarName);
		or something like that. Which would make this even more of a
		pain to work with.

		FIXED: But it's painfully slow and ugly.
		****************************************************************/
		if( !(trap_Cvar_VariableIntegerValue("disable_map_restart")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "map_restart");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_mapnum")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "mapnum");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_weap_plasmagunCycle")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "weap_plasmagunCycle");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_previousmap")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "previousmap");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_nextmap")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "nextmap");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_weap_railgunCycle")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "weap_railgunCycle");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_map")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "map");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_g_gametype")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "g_gametype");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_weap_rocketlauncherCycle")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "weap_rocketlauncherCycle");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_kick")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "kick");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_clientkick")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "clientkick");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_weap_lightninggunCycle")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "weap_lightninggunCycle");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_g_warmup")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "g_warmup");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_timelimit")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "timelimit");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_weap_grenadelauncherCycle")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "weap_grenadelauncherCycle");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_fraglimit")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "fraglimit");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_g_muteSpecs")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "g_muteSpecs");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_weap_shotgunCycle")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "weap_shotgunCycle");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_g_muteTourneyspecs")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "g_muteTourneyspecs");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_g_DynamicRailgunCycle")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "g_DynamicRailgunCycle");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_weap_machinegunCycle")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "weap_machinegunCycle");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_g_RailJumping")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "g_RailJumping");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_g_railgunKnockback")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "g_railgunKnockback");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_weap_bfgCycle")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "weap_bfgCycle");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_g_staticKnockback")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "g_staticKnockback");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_g_returnFlag")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "g_returnFlag");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_g_selfDamage")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "g_selfDamage");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_g_FallingDamage")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "g_FallingDamage");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_timeout")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "timeout");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_timein")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "timein");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_g_gamemode")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "g_gamemode");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_g_pro_mode")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "g_pro_mode");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_g_IU_ctf_Sounds")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "g_IU_ctf_Sounds");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_g_teamKnockback")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "g_teamKnockback");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_quickmode")) ) {
			Com_sprintf(string, sizeof(string), "%s %s", string, "quickmode");
		}

		//trap_SendServerCommand( ent-g_entities, va("print \"%s\"", string));
		trap_SendServerCommand( ent-g_entities, va("vtc \"%s\n\0\"", string));
		return;
	}

	// if there is still a vote to be executed
	if ( level.voteExecuteTime ) {
		level.voteExecuteTime = 0;
		trap_SendConsoleCommand( EXEC_APPEND, va("%s\n", level.voteString ) );
	}

	// special case for g_gametype, check for bad values
	if ( !Q_stricmp( arg1, "g_gametype" ) ) {
		i = atoi( arg2 );
		if( i == GT_SINGLE_PLAYER || i < GT_FFA || i >= GT_MAX_GAME_TYPE) {
			trap_SendServerCommand( ent-g_entities, "print \"Invalid gametype.\n\"" );
			return;
		}

		Com_sprintf( level.voteString, sizeof( level.voteString ), "%s %d", arg1, i );
	} else if ( !Q_stricmp( arg1, "map" ) ) {
		// special case for map changes, we want to reset the nextmap setting
		// this allows a player to change maps, but not upset the map rotation
		char	s[MAX_STRING_CHARS];
		
		//We also want to do stuff for previousmap.
		trap_Cvar_VariableStringBuffer( "previousmap", s, sizeof(s) );
		if (*s) {
			Com_sprintf( level.voteString, sizeof( level.voteString ), "%s %s; set previousmap \"%s\"", arg1, arg2, s );
		} else {
			Com_sprintf( level.voteString, sizeof( level.voteString ), "%s %s", arg1, arg2 );
		}
	} else if ( !Q_stricmp( arg1, "mapnum" ) ) { //monkk
		// special case for map changes, we want to reset the nextmap setting
		// this allows a player to change maps, but not upset the map rotation
		char	s[MAX_STRING_CHARS];
		char	mapName[MAX_QPATH];
		int		mapNum, mapCount;

		if( ! *arg2) {
			trap_SendServerCommand( ent-g_entities, "print \"^1Invalid mapnumber.\n\"" );
			return;
		}
		mapNum = atoi(arg2);
		if( mapNum == 0 && arg2[0] != '0' ) {
			//since atoi will return 0 if it can't convert, we need to know if it was 0 or just
			//a failed conversion, in which case we should print an error
			trap_SendServerCommand( ent-g_entities, "print \"^1Invalid mapnumber.\n\"" );
			return;
		}

		if(mapNum < 0) {
			trap_SendServerCommand( ent-g_entities, "print \"^1Invalid mapnumber, must be greater then zero.\n\"" );
			return;
		}

		memset(mapName, 0, sizeof(mapName));
		mapCount = FindMapNameForNumber( mapName, mapNum );

		if(mapNum > mapCount) {
			trap_SendServerCommand( ent-g_entities, 
				va("print \"^1Invalid mapnumber, must be less then %d.\n\"", mapCount));
			return;
		}
		trap_Cvar_VariableStringBuffer( "nextmap", s, sizeof(s) );
		if (*s) {
			Com_sprintf( level.voteString, sizeof( level.voteString ), "%s %s; set nextmap \"%s\"", arg1, arg2, s );
		} else {
			Com_sprintf( level.voteString, sizeof( level.voteString ), "%s %s", arg1, arg2 );
		}
	} else if ( !Q_stricmp( arg1, "nextmap" ) ) {
		char	s[MAX_STRING_CHARS];

		trap_Cvar_VariableStringBuffer( "nextmap", s, sizeof(s) );
		if (!*s) {
			trap_SendServerCommand( ent-g_entities, "print \"nextmap not set.\n\"" );
			return;
		}
		Com_sprintf( level.voteString, sizeof( level.voteString ), "vstr nextmap");
	} else if ( !Q_stricmp( arg1, "previousmap" ) ) {
		char	s[MAX_STRING_CHARS];

		trap_Cvar_VariableStringBuffer( "previousmap", s, sizeof(s) );
		if (!*s) {
			trap_SendServerCommand( ent-g_entities, "print \"previousmap not set.\n\"" );
			return;
		}
		Com_sprintf( level.voteString, sizeof( level.voteString ), "vstr previousmap");
	} else if ( !Q_stricmp( arg1, "timeout" ) ) {
			level.match_time = atoi(arg2);
		if ( level.match_team[ent->client->sess.sessionTeam] > g_timeOutLimit.integer ) {
			trap_SendServerCommand( ent-g_entities, "print \"No time outs remaining\n\"");
			return;
		}
		level.match_called = 1;
	//	Cmd_Timeout_f( ent );
		Com_sprintf( level.voteString, sizeof( level.voteString ), "%s \"%s\"", arg1, arg2 );
		//Com_sprintf( level.voteDisplayString, sizeof( level.voteDisplayString ), "%s", level.voteString );
	} else if ( !Q_stricmp( arg1, "timein" ) ) {
		if ( level.match_timeout != 1 ) {
			trap_SendServerCommand( ent-g_entities, "print \"No time out in progress\n\"");
			return;
		}
		level.match_called = -1;
		level.match_timeinGrace = atoi(arg2);
		Com_sprintf( level.voteString, sizeof( level.voteString ), "%s \"%s\"", arg1, arg2 );
		//Com_sprintf( level.voteDisplayString, sizeof( level.voteDisplayString ), "%s", level.voteString );
	} else {
		if ( (Q_stricmp (arg1, "full_weapons") == 0) || (Q_stricmp (arg1, "rnr") == 0) || 
		 (Q_stricmp (arg1, "instagib") == 0) || (Q_stricmp (arg1, "classic_instagib") == 0) ||
		 (Q_stricmp (arg1, "hybrid_instagib") == 0) ) {
			 //set arg2 to arg1
			//Com_sprintf( arg2, sizeof( arg2), "%s", arg1);
			//set arg1 to exec
			//Com_sprintf( arg1, sizeof( arg1), "exec", 0);
			Com_sprintf( level.voteString, sizeof( level.voteString ), "exec \"%s\"", arg1, arg2 );
		} else {
			Com_sprintf( level.voteString, sizeof( level.voteString ), "%s %s", arg1, arg2 );
		}
	}

	Com_sprintf( level.voteDisplayString, sizeof( level.voteDisplayString ), "%s", level.voteString );
	G_Printf("%s\n", level.voteDisplayString);
	trap_SendServerCommand( -1, va("print \"%s called a vote.\n\"", ent->client->pers.netname ) );

	// start the voting, the caller autoamtically votes yes
	level.voteTime = level.time;
	level.voteYes = 1;
	level.voteNo = 0;

	for ( i = 0 ; i < level.maxclients ; i++ ) {
		level.clients[i].ps.eFlags &= ~EF_VOTED;
	}
	ent->client->ps.eFlags |= EF_VOTED;

	trap_SendServerCommand( -1, va("vt \"%i %s\"", level.voteTime, level.voteDisplayString) );
	CheckVote();
}

/*
==================
Cmd_Vote_f
==================
*/
void Cmd_Vote_f( gentity_t *ent ) {
	char		msg[64];

	if ( !level.voteTime ) {
		trap_SendServerCommand( ent-g_entities, "print \"No vote in progress.\n\"" );
		return;
	}
	if ( ent->client->ps.eFlags & EF_VOTED ) {
		trap_SendServerCommand( ent-g_entities, "print \"Vote already cast.\n\"" );
		return;
	}
	if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
		trap_SendServerCommand( ent-g_entities, "print \"Not allowed to vote as spectator.\n\"" );
		return;
	}

	trap_SendServerCommand( ent-g_entities, "print \"Vote cast.\n\"" );

	ent->client->ps.eFlags |= EF_VOTED;

	trap_Argv( 1, msg, sizeof( msg ) );

	if ( msg[0] == 'y' || msg[1] == 'Y' || msg[1] == '1' ) {
		level.voteYes++;
		//trap_SetConfigstring( CS_VOTE_YES, va("%i", level.voteYes ) );
	} else {
		level.voteNo++;
		//trap_SetConfigstring( CS_VOTE_NO, va("%i", level.voteNo ) );	
	}

	trap_SendServerCommand( -1, va("vt \"%i %i\"", level.voteYes, level.voteNo) );

	CheckVote();

	// a majority will be determined in CheckVote, which will also account
	// for players entering or leaving
}

/*
==================
CheckTeamVote
==================
*/
void CheckTeamVote( int cs_offset ) {

	if ( level.time - level.teamVoteTime[cs_offset] >= VOTE_TIME ) {
		trap_SendServerCommand( -1, "print \"Team vote failed.\n\"" );
	} else {
		if ( level.teamVoteYes[cs_offset] > level.numteamVotingClients[cs_offset]/2 ) {
			// execute the command, then remove the vote
			trap_SendServerCommand( -1, "print \"Team vote passed.\n\"" );
			level.teamVoteYes[cs_offset] = 128;
			//
			if(!Q_stricmp("lockteam", level.teamVoteString[cs_offset]))
			{
				//lock the team
				if(cs_offset == TEAM_RED-1)
					trap_SendConsoleCommand(EXEC_NOW, "lockteam r\n");
				else
					trap_SendConsoleCommand(EXEC_NOW, "lockteam b\n");
			}
			else if(!Q_stricmp("unlockteam", level.teamVoteString[cs_offset]))
			{
				//unlock the team
				if(cs_offset == TEAM_RED-1)
					trap_SendConsoleCommand(EXEC_NOW, "unlockteam r\n");
				else
					trap_SendConsoleCommand(EXEC_NOW, "unlockteam b\n");
			}
/*			if ( !Q_strncmp( "leader", level.teamVoteString[cs_offset], 6) ) {
				//set the team leader
				SetLeader(team, atoi(level.teamVoteString[cs_offset] + 7));
			//} else if ( !Q_strncmp( "lockTeam", level.teamVoteString[cs_offset], 8) ) {
			//	level.team_Locked[team] = qtrue;//Team is locked.
			//} else if ( !Q_strncmp( "unlockTeam", level.teamVoteString[cs_offset], 10) ) {
			//	level.team_Locked[team] = qfalse;//Team is unlocked.
			} else {
				if ( !Q_strncmp( "timeout", level.teamVoteString[cs_offset], 7 ) ) {
					if ( g_gametype.integer >= GT_TEAM ) {
						level.match_team[level.voteTeam]++;
						level.voteTeam = -1;
					}
				}
				trap_SendConsoleCommand( EXEC_APPEND, va("%s\n", level.teamVoteString[cs_offset] ) );
			}
*/		} else if ( level.teamVoteNo[cs_offset] >= level.numteamVotingClients[cs_offset]/2 ) {
			// same behavior as a timeout
			trap_SendServerCommand( -1, "print \"Team vote failed.\n\"" );
		} else {
			// still waiting for a majority
			return;
		}
	}
	//level.teamVoteTime[cs_offset] = 0;
	trap_SendServerCommand( -1, va("tv \"%i -1\n\"", cs_offset) );
	//trap_SetConfigstring( CS_TEAMVOTE_TIME + cs_offset, "" );

}

/*
==================
Cmd_CallTeamVote_f
==================
*/
void Cmd_CallTeamVote_f( gentity_t *ent ) {
#if 0
	int		i, team, cs_offset;
	char	arg1[MAX_STRING_TOKENS];
	char	arg2[MAX_STRING_TOKENS];
	char	cvarName[128];

	team = ent->client->sess.sessionTeam;
	if ( team == TEAM_RED )
		cs_offset = 0;
	else if ( team == TEAM_BLUE )
		cs_offset = 1;
	else
		return;

	if ( !g_allowVote.integer ) {
		trap_SendServerCommand( ent-g_entities, "print \"Voting not allowed here.\n\"" );
		return;
	}

	if ( level.teamVoteTime[cs_offset] ) {
		trap_SendServerCommand( ent-g_entities, "print \"A team vote is already in progress.\n\"" );
		return;
	}
	if ( ent->client->pers.teamVoteCount >= MAX_VOTE_COUNT ) {
		trap_SendServerCommand( ent-g_entities, "print \"You have called the maximum number of team votes.\n\"" );
		return;
	}
	if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
		trap_SendServerCommand( ent-g_entities, "print \"Not allowed to call a vote as spectator.\n\"" );
		return;
	}

	// make sure it is a valid command to vote on
	trap_Argv( 1, arg1, sizeof( arg1 ) );

	Com_sprintf(cvarName, sizeof(cvarName), "disable_%s", arg1);
	if( trap_Cvar_VariableIntegerValue(cvarName) ) {
		trap_SendServerCommand( ent-g_entities, va("print \"callvote for %s is disabled.\n\"",arg1) );
		return;
	}

	arg2[0] = '\0';
	for ( i = 2; i < trap_Argc(); i++ ) {
		if (i > 2)
			strcat(arg2, " ");
		trap_Argv( i, &arg2[strlen(arg2)], sizeof( arg2 ) - strlen(arg2) );
	}

	if( strchr( arg1, ';' ) || strchr( arg2, ';' ) ) {
		trap_SendServerCommand( ent-g_entities, "print \"Invalid vote string.\n\"" );
		return;
	}

	if ( !Q_stricmp( arg1, "leader" ) ) {
		char netname[MAX_NETNAME], leader[MAX_NETNAME];

		if ( !arg2[0] ) {
			i = ent->client->ps.clientNum;
		} else {
			// numeric values are just slot numbers
			for (i = 0; i < 3; i++) {
				if ( !arg2[i] || arg2[i] < '0' || arg2[i] > '9' )
					break;
			}
			if ( i >= 3 || !arg2[i]) {
				i = atoi( arg2 );
				if ( i < 0 || i >= level.maxclients ) {
					trap_SendServerCommand( ent-g_entities, va("print \"Bad client slot: %i\n\"", i) );
					return;
				}

				if ( !g_entities[i].inuse ) {
					trap_SendServerCommand( ent-g_entities, va("print \"Client %i is not active\n\"", i) );
					return;
				}
			} else {
				Q_strncpyz(leader, arg2, sizeof(leader));
				Q_CleanStr(leader);
				for ( i = 0 ; i < level.maxclients ; i++ ) {
					if ( level.clients[i].pers.connected == CON_DISCONNECTED )
						continue;
					if (level.clients[i].sess.sessionTeam != team)
						continue;
					Q_strncpyz(netname, level.clients[i].pers.netname, sizeof(netname));
					Q_CleanStr(netname);
					if ( !Q_stricmp(netname, leader) ) {
						break;
					}
				}
				if ( i >= level.maxclients ) {
					trap_SendServerCommand( ent-g_entities, va("print \"%s is not a valid player on your team.\n\"", arg2) );
					return;
				}
			}
		}
		Com_sprintf(arg2, sizeof(arg2), "%d", i);
	} else if ( !Q_stricmp( arg1, "timeout" ) ) {
		//if ( strlen(arg2) >= 1 ) {
			//int	time;
			level.match_time = atoi(arg2);
		//} else {
		//	level.match_time = 0;
		//}
		if ( level.match_team[ent->client->sess.sessionTeam] > g_timeOutLimit.integer ) {
			trap_SendServerCommand( ent-g_entities, "print \"No time outs remaining\n\"");
			return;
		}
		level.match_called = 1;
	//	Cmd_Timeout_f( ent );
		Com_sprintf( level.teamVoteString[cs_offset], sizeof( level.teamVoteString[cs_offset] ), "%s \"%s\"", arg1, arg2 );
		Com_sprintf( level.voteDisplayString, sizeof( level.voteDisplayString ), "%s", level.teamVoteString[cs_offset] );
	} else if ( !Q_stricmp( arg1, "timein" ) ) {
	} else if ( !Q_stricmp( arg1, "lockTeam" ) ) {
		Com_sprintf( level.teamVoteString[cs_offset], sizeof( level.teamVoteString[cs_offset] ), "%s %i", arg1, team );
	} else if ( !Q_stricmp( arg1, "unlockTeam" ) ) {
		Com_sprintf( level.teamVoteString[cs_offset], sizeof( level.teamVoteString[cs_offset] ), "%s %i", arg1, team );
	} else {
		char	string[2048];
		int		stringLen;
		int		totalStringLen = 0;

		memset(cvarName, 0, sizeof(cvarName));
		memset(string, 0, sizeof(string));
		trap_SendServerCommand( ent-g_entities, "print \"Invalid vote string.\n\"" );
		//trap_SendServerCommand( ent-g_entities, "print \"Team vote commands are: leader <player>, lockTeam, unlockTeam.\n\"" );
		
		if( !(trap_Cvar_VariableIntegerValue("disable_lead")) ) {
			Com_sprintf(cvarName, 128, "%30s", "leader <player>,");
			stringLen = strlen(cvarName);
			strcpy(string + totalStringLen, cvarName);
			totalStringLen += stringLen;
			memset(cvarName, 0, sizeof(cvarName));
			string[totalStringLen] = ' ';
			totalStringLen++;
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_lockTeam")) ) {
			Com_sprintf(cvarName, 128, "%30s", "lockTeam,");
			stringLen = strlen(cvarName);
			strcpy(string + totalStringLen, cvarName);
			totalStringLen += stringLen;
			memset(cvarName, 0, sizeof(cvarName));
			string[totalStringLen] = ' ';
			totalStringLen++;
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_unlockTeam")) ) {
			Com_sprintf(cvarName, 128, "%30s", "unlockTeam,");
			stringLen = strlen(cvarName);
			strcpy(string + totalStringLen, cvarName);
			totalStringLen += stringLen;
			memset(cvarName, 0, sizeof(cvarName));
			string[totalStringLen] = ' ';
			totalStringLen++;
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_timeout")) ) {
			Com_sprintf(cvarName, 128, "%30s", "timeout <n>,");
			stringLen = strlen(cvarName);
			strcpy(string + totalStringLen, cvarName);
			totalStringLen += stringLen;
			memset(cvarName, 0, sizeof(cvarName));
			string[totalStringLen] = ' ';
			totalStringLen++;
		}
		trap_SendServerCommand( ent-g_entities, va("print \"Vote commands are: %s\n\"", string));
		return;
	}

	Com_sprintf( level.teamVoteString[cs_offset], sizeof( level.teamVoteString[cs_offset] ), "%s %s", arg1, arg2 );

	for ( i = 0 ; i < level.maxclients ; i++ ) {
		if ( level.clients[i].pers.connected == CON_DISCONNECTED )
			continue;
		if (level.clients[i].sess.sessionTeam == team)
			trap_SendServerCommand( i, va("print \"%s called a team vote.\n\"", ent->client->pers.netname ) );
	}

	// start the voting, the caller autoamtically votes yes
	level.teamVoteTime[cs_offset] = level.time;
	level.teamVoteYes[cs_offset] = 1;
	level.teamVoteNo[cs_offset] = 0;

	for ( i = 0 ; i < level.maxclients ; i++ ) {
		if (level.clients[i].sess.sessionTeam == team)
			level.clients[i].ps.eFlags &= ~EF_TEAMVOTED;
	}
	ent->client->ps.eFlags |= EF_TEAMVOTED;
#endif
	int		i, team, cs_offset;
	char	arg1[MAX_STRING_TOKENS];
	char	arg2[MAX_STRING_TOKENS];
	char	cvarName[128];

	team = ent->client->sess.sessionTeam;
	if ( team == TEAM_RED )
		cs_offset = 0;
	else if ( team == TEAM_BLUE )
		cs_offset = 1;
	else
		return;

	level.voteTeam = ent->client->sess.sessionTeam;


	if ( !g_allowVote.integer ) {
		trap_SendServerCommand( ent-g_entities, "print \"Voting not allowed here.\n\"" );
		return;
	}

	if ( level.voteTime ) {
		trap_SendServerCommand( ent-g_entities, "print \"A vote is already in progress.\n\"" );
		return;
	}
	
	if ( level.voteExecuteTime != 0 ) {
		trap_SendServerCommand( ent-g_entities, "print \"A vote is in the progress of executing.\n\"" );
		return;
	}
	if ( ent->client->pers.voteCount >= MAX_VOTE_COUNT ) {
		trap_SendServerCommand( ent-g_entities, "print \"You have called the maximum number of votes.\n\"" );
		return;
	}
	if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
		trap_SendServerCommand( ent-g_entities, "print \"Not allowed to call a vote as spectator.\n\"" );
		return;
	}

	// make sure it is a valid command to vote on
	trap_Argv( 1, arg1, sizeof( arg1 ) );
	trap_Argv( 2, arg2, sizeof( arg2 ) );

	Com_sprintf(cvarName, sizeof(cvarName), "disable_%s", arg1);
	if( trap_Cvar_VariableIntegerValue(cvarName) ) {
		trap_SendServerCommand( ent-g_entities, va("print \"callvote for %s is disabled.\n\"",arg1) );
		return;
	}


	if( strchr( arg1, ';' ) || strchr( arg2, ';' ) ) {
		trap_SendServerCommand( ent-g_entities, "print \"Invalid vote string.\n\"" );
		return;
	}

	//FIXME: for g_allowLockedTeams

	if ( //if not equal to any of these
		Q_stricmp(arg1, "lockteam") && Q_stricmp(arg1, "unlockteam") &&
		Q_stricmp(arg1, "timeout") && Q_stricmp(arg1, "timein") &&
		Q_stricmp(arg1, "leader")
	) {
		char	string[MAX_STRING_TOKENS];
		//int		stringLen;
		int		totalStringLen = 0;

		memset(cvarName, 0, sizeof(cvarName));
		memset(string, 0, sizeof(string));

		if ( strlen(arg1) ) {
			trap_SendServerCommand( ent-g_entities, "print \"Invalid vote string.\n\"" );
		}
		
		/***************************************************************
		This is some pretty ugly shit, and the end print out isn't too
		much better. This is a step in the correct direction, however
		These should be aligned into columns, 3 total. That being done
		would require padding:
		Com_sprintf(destVar, size, "%30s", cvarName);
		or something like that. Which would make this even more of a
		pain to work with.

		FIXED: But it's painfully slow and ugly.
		****************************************************************/

		//if ( g_allowLockedTeams.integer ) {//FIXME: for g_allowLockedTeams

		//	if( !(trap_Cvar_VariableIntegerValue("disable_lockteam")) ) {
		//		Com_sprintf(string, sizeof(string), "%s %s", string, "lockteam");
		//	}
		//	if( !(trap_Cvar_VariableIntegerValue("disable_unlockteam")) ) {
		//		Com_sprintf(string, sizeof(string), "%s %s", string, "unlockteam");
		//	}
		//}
		if( !(trap_Cvar_VariableIntegerValue("disable_timeout")) ) {
				Com_sprintf(string, sizeof(string), "%s %s", string, "timeout");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_timein")) ) {
				Com_sprintf(string, sizeof(string), "%s %s", string, "timein");
		}
		if( !(trap_Cvar_VariableIntegerValue("disable_leader")) ) {
				Com_sprintf(string, sizeof(string), "%s %s", string, "leader");
		}

		trap_SendServerCommand( ent-g_entities, va("vtc \"%s\n\0\"", string));
		return;
	}

	// if there is still a vote to be executed
	if ( level.voteExecuteTime ) {
		level.voteExecuteTime = 0;
		trap_SendConsoleCommand( EXEC_APPEND, va("%s\n", level.voteString ) );
	}



	if ( !Q_stricmp( arg1, "leader" ) ) {
		char netname[MAX_NETNAME], leader[MAX_NETNAME];

		if ( !arg2[0] ) {
			i = ent->client->ps.clientNum;
		} else {
			// numeric values are just slot numbers
			for (i = 0; i < 3; i++) {
				if ( !arg2[i] || arg2[i] < '0' || arg2[i] > '9' )
					break;
			}
			if ( i >= 3 || !arg2[i]) {
				i = atoi( arg2 );
				if ( i < 0 || i >= level.maxclients ) {
					trap_SendServerCommand( ent-g_entities, va("print \"Bad client slot: %i\n\"", i) );
					return;
				}

				if ( !g_entities[i].inuse ) {
					trap_SendServerCommand( ent-g_entities, va("print \"Client %i is not active\n\"", i) );
					return;
				}
			} else {
				Q_strncpyz(leader, arg2, sizeof(leader));
				Q_CleanStr(leader);
				for ( i = 0 ; i < level.maxclients ; i++ ) {
					if ( level.clients[i].pers.connected == CON_DISCONNECTED )
						continue;
					if (level.clients[i].sess.sessionTeam != team)
						continue;
					Q_strncpyz(netname, level.clients[i].pers.netname, sizeof(netname));
					Q_CleanStr(netname);
					if ( !Q_stricmp(netname, leader) ) {
						break;
					}
				}
				if ( i >= level.maxclients ) {
					trap_SendServerCommand( ent-g_entities, va("print \"%s is not a valid player on your team.\n\"", arg2) );
					return;
				}
			}
		}
		Com_sprintf(arg2, sizeof(arg2), "%d", i);
	} else if ( !Q_stricmp( arg1, "timeout" ) ) {
			level.match_time = atoi(arg2);
		if ( level.match_team[ent->client->sess.sessionTeam] > g_timeOutLimit.integer ) {
			trap_SendServerCommand( ent-g_entities, "print \"No time outs remaining\n\"");
			return;
		}
		level.match_called = 1;
		Com_sprintf( level.teamVoteString[cs_offset], sizeof( level.teamVoteString[cs_offset] ), "%s \"%s\"", arg1, arg2 );
		//Com_sprintf( level.voteDisplayString, sizeof( level.voteDisplayString ), "%s", level.teamVoteString[cs_offset] );
	} else if ( !Q_stricmp( arg1, "timein" ) ) {
		if ( level.match_timeout != 1 ) {
			trap_SendServerCommand( ent-g_entities, "print \"No time out in progress\n\"");
			return;
		}
		level.match_called = -1;
		level.match_timeinGrace = atoi(arg2);
		Com_sprintf( level.teamVoteString[cs_offset], sizeof( level.teamVoteString[cs_offset] ), "%s \"%s\"", arg1, arg2 );
	} else {
		Com_sprintf( level.teamVoteString[cs_offset], sizeof( level.teamVoteString[cs_offset] ), "%s", arg1 );
	}


	// start the voting, the caller autoamtically votes yes
	level.teamVoteTime[cs_offset] = level.time;
	level.teamVoteYes[cs_offset] = 1;
	level.teamVoteNo[cs_offset] = 0;

	for ( i = 0 ; i < level.maxclients ; i++ ) {
		if (level.clients[i].sess.sessionTeam == team)	{
			trap_SendServerCommand( level.clients[i].ps.clientNum, va("print \"%s called a team vote.\n\"", ent->client->pers.netname ) );
			level.clients[i].ps.eFlags &= ~EF_TEAMVOTED;
		}
	}

	ent->client->ps.eFlags |= EF_TEAMVOTED;

//	trap_SendServerCommand( -1, va("vt \"%i %s\"", level.voteTime, level.voteDisplayString) );
	G_Printf("tv %i %i %s\n", cs_offset, level.teamVoteTime[cs_offset], level.teamVoteString[cs_offset]);
	trap_SendServerCommand( -1, va("tv \"%i %i %s \"", cs_offset, level.teamVoteTime[cs_offset], level.teamVoteString[cs_offset]) );

	CheckTeamVote(cs_offset);
	//trap_SetConfigstring( CS_TEAMVOTE_TIME + cs_offset, va("%i", level.teamVoteTime[cs_offset] ) );
	//trap_SetConfigstring( CS_TEAMVOTE_STRING + cs_offset, level.teamVoteString[cs_offset] );
	//trap_SetConfigstring( CS_TEAMVOTE_YES + cs_offset, va("%i", level.teamVoteYes[cs_offset] ) );
	//trap_SetConfigstring( CS_TEAMVOTE_NO + cs_offset, va("%i", level.teamVoteNo[cs_offset] ) );
}

/*
==================
Cmd_TeamVote_f
==================
*/
void Cmd_TeamVote_f( gentity_t *ent ) {
	int			team, cs_offset;
	char		msg[64];

	team = ent->client->sess.sessionTeam;
	if ( team == TEAM_RED )
		cs_offset = 0;
	else if ( team == TEAM_BLUE )
		cs_offset = 1;
	else
		return;

	if ( !level.teamVoteTime[cs_offset] ) {
		trap_SendServerCommand( ent-g_entities, "print \"No team vote in progress.\n\"" );
		return;
	}
	if ( ent->client->ps.eFlags & EF_TEAMVOTED ) {
		trap_SendServerCommand( ent-g_entities, "print \"Team vote already cast.\n\"" );
		return;
	}
	if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
		trap_SendServerCommand( ent-g_entities, "print \"Not allowed to vote as spectator.\n\"" );
		return;
	}

	trap_SendServerCommand( ent-g_entities, "print \"Team vote cast.\n\"" );

	ent->client->ps.eFlags |= EF_TEAMVOTED;

	trap_Argv( 1, msg, sizeof( msg ) );

	if ( msg[0] == 'y' || msg[1] == 'Y' || msg[1] == '1' ) {
		level.teamVoteYes[cs_offset]++;
		//trap_SetConfigstring( CS_TEAMVOTE_YES + cs_offset, va("%i", level.teamVoteYes[cs_offset] ) );
	} else {
		level.teamVoteNo[cs_offset]++;
		//trap_SetConfigstring( CS_TEAMVOTE_NO + cs_offset, va("%i", level.teamVoteNo[cs_offset] ) );	
	}

	trap_SendServerCommand( -1, va("vt \"%i %i %i\n\"", cs_offset, level.teamVoteYes[cs_offset], level.teamVoteNo[cs_offset]) );
	CheckTeamVote(cs_offset);
	// a majority will be determined in TeamCheckVote, which will also account
	// for players entering or leaving
}


/*
=================
Cmd_SetViewpos_f
=================
*/
void Cmd_SetViewpos_f( gentity_t *ent ) {
	vec3_t		origin, angles;
	char		buffer[MAX_TOKEN_CHARS];
	int			i;

	if ( !g_cheats.integer ) {
		trap_SendServerCommand( ent-g_entities, va("print \"Cheats are not enabled on this server.\n\""));
		return;
	}
	if ( trap_Argc() != 5 ) {
		trap_SendServerCommand( ent-g_entities, va("print \"usage: setviewpos x y z yaw\n\""));
		return;
	}

	VectorClear( angles );
	for ( i = 0 ; i < 3 ; i++ ) {
		trap_Argv( i + 1, buffer, sizeof( buffer ) );
		origin[i] = atof( buffer );
	}

	trap_Argv( 4, buffer, sizeof( buffer ) );
	angles[YAW] = atof( buffer );

	TeleportPlayer( ent, origin, angles, qtrue );
}



/*
=================
Cmd_Stats_f
=================
*/
void Cmd_Stats_f( int clientNum ) {
/*
	int max, n, i;

	max = trap_AAS_PointReachabilityAreaIndex( NULL );

	n = 0;
	for ( i = 0; i < max; i++ ) {
		if ( ent->client->areabits[i >> 3] & (1 << (i & 7)) )
			n++;
	}

	//trap_SendServerCommand( ent-g_entities, va("print \"visited %d of %d areas\n\"", n, max));
	trap_SendServerCommand( ent-g_entities, va("print \"%d%% level coverage\n\"", n * 100 / max));
*/

	int			i;
	char		newname[36];


	if ( g_entities[clientNum].client->pers.stats_nextAllowedPrint > level.time ) {
		//We've already completed the print in the last 3 seconds
		//So don't print again.
		return;
	}

	trap_SendServerCommand( clientNum, va("print \"\n\""));

	if ( g_gamemode.integer == 0 || g_gamemode.integer == 2 || g_gamemode.integer == 4 || ((g_gamemode.integer == 1 || g_gamemode.integer == 5) && !(weap_allowed.integer == 64 || weap_allowed.integer == 65)) ) {
		if ( g_gametype.integer == GT_CTF ) {
				trap_SendServerCommand( clientNum, va("print \""S_COLOR_WHITE"Player \n  Gt      Mg     Sg      Gl    Rl     Lg     Rg     Pg     BFG  Returns/Caps\n\""));
			} else {
				trap_SendServerCommand( clientNum, va("print \""S_COLOR_WHITE"Player \n  Gt      Mg     Sg      Gl    Rl     Lg     Rg     Pg     BFG  Frags\n\""));
			}
			trap_SendServerCommand( clientNum, va("print \""S_COLOR_WHITE"-----------------------------------------------------------------------------\n\""));
		//for ( i = 0; i < MAX_CLIENTS; i++ ) {
		for ( i = 0; i < g_maxclients.integer; i++ ) {
			if ( level.clients[i].pers.connected == CON_CONNECTED) {
				if (level.clients[i].sess.sessionTeam != TEAM_SPECTATOR ) {
					trap_SendServerCommand( clientNum, va("print \""S_COLOR_WHITE"%s"S_COLOR_WHITE" \n%3.2f %3.2f %3.2f %3.2f %3.2f %3.2f %3.2f %3.2f %3.2f",
					level.clients[i].pers.netname,
					(float)level.clients[i].pers.stats_hits[WP_GAUNTLET] / (float)(level.clients[i].pers.stats_shots[WP_GAUNTLET] + .0001) * 100.00f,
					(float)level.clients[i].pers.stats_hits[WP_MACHINEGUN] / (float)(level.clients[i].pers.stats_shots[WP_MACHINEGUN] + .0001) * 100.01f,
					(float)level.clients[i].pers.stats_hits[WP_SHOTGUN] / (float)(level.clients[i].pers.stats_shots[WP_SHOTGUN] + .0001) * 100.01f,
					(float)level.clients[i].pers.stats_hits[WP_GRENADE_LAUNCHER] / (float)(level.clients[i].pers.stats_shots[WP_GRENADE_LAUNCHER] + .0001) * 100.01f,
					(float)level.clients[i].pers.stats_hits[WP_ROCKET_LAUNCHER] / (float)(level.clients[i].pers.stats_shots[WP_ROCKET_LAUNCHER] + .0001) * 100.01f,
					(float)level.clients[i].pers.stats_hits[WP_LIGHTNING] / (float)(level.clients[i].pers.stats_shots[WP_LIGHTNING] + .0001) * 100.01f,
					(float)level.clients[i].pers.stats_hits[WP_RAILGUN] / (float)(level.clients[i].pers.stats_shots[WP_RAILGUN] + .0001) * 100.01f,
					(float)level.clients[i].pers.stats_hits[WP_PLASMAGUN] / (float)(level.clients[i].pers.stats_shots[WP_PLASMAGUN] + .0001) * 100.01f,
					(float)level.clients[i].pers.stats_hits[WP_BFG] / (float)(level.clients[i].pers.stats_shots[WP_BFG] + .0001) * 100.01f
					));
					if (g_gametype.integer == GT_CTF) {
						trap_SendServerCommand( clientNum, va("print \""S_COLOR_WHITE"  %i/%i\n\"", level.clients[i].pers.stats_flags[3], level.clients[i].pers.stats_flags[4]));
					} else {
						trap_SendServerCommand( clientNum, va("print \""S_COLOR_WHITE"   %i\n\"", level.clients[i].pers.stats_frags[WP_GAUNTLET] + level.clients[i].pers.stats_frags[WP_MACHINEGUN] +
							level.clients[i].pers.stats_frags[WP_SHOTGUN] + level.clients[i].pers.stats_frags[WP_ROCKET_LAUNCHER] + level.clients[i].pers.stats_frags[WP_LIGHTNING] + 
							level.clients[i].pers.stats_frags[WP_RAILGUN] + level.clients[i].pers.stats_frags[WP_PLASMAGUN] + level.clients[i].pers.stats_hits[WP_BFG]));
					}
				}
			}
		}
	} else if ( (g_gamemode.integer == 1 || g_gamemode.integer == 5) && (weap_allowed.integer == 64 || weap_allowed.integer == 65) ) {
		//instagib
		if ( g_gametype.integer == GT_CTF ) {
			trap_SendServerCommand( clientNum, va("print \""S_COLOR_WHITE"Player                Hits  Shots  Accuracy  Railjumps  Frags  Returns/Caps\n\""));
		} else {
			trap_SendServerCommand( clientNum, va("print \""S_COLOR_WHITE"Player                 Hits  Shots  Accuracy  Railjumps  Frags\n\""));
		}
		trap_SendServerCommand( clientNum, va("print \""S_COLOR_WHITE"-----------------------------------------------------------------------------\n\""));
		//for ( i = 0; i < MAX_CLIENTS; i++ ) {
		for ( i = 0; i < g_maxclients.integer; i++ ) {
			if ( level.clients[i].pers.connected == CON_CONNECTED) {
				if (level.clients[i].pers.stats_shots[WP_RAILGUN] > 0 || level.clients[i].pers.stats_railjumps > 0) {
					char buffer[32];
					int	numColorCodesUsed = 0, ii = 0;
					memset(&newname, 0, sizeof(newname));
					numColorCodesUsed = FixedName( newname, level.clients[i].pers.netname, 22);
					memset(&buffer, 0, sizeof(buffer));
					for ( ii = 0; (strlen(newname)-(numColorCodesUsed*2))+strlen(buffer) < 22; ii++ ) {
						buffer[ii] = ' ';
					}
					if ( g_gametype.integer == GT_CTF ) {
						trap_SendServerCommand( clientNum, va("print \""S_COLOR_WHITE"%s%s"S_COLOR_WHITE" %4i  %4i    %3.2f   %5i     %4i      %3i  %3i\n", newname, buffer, level.clients[i].pers.stats_hits[WP_RAILGUN],
							level.clients[i].pers.stats_shots[WP_RAILGUN], (float)level.clients[i].pers.stats_hits[WP_RAILGUN] / (float)(level.clients[i].pers.stats_shots[WP_RAILGUN] + .0001) * 100.01f,
							level.clients[i].pers.stats_railjumps, level.clients[i].pers.stats_frags[WP_RAILGUN] + level.clients[i].pers.stats_frags[WP_GAUNTLET],
							level.clients[i].pers.stats_flags[3], level.clients[i].pers.stats_flags[4]));
					} else {
						trap_SendServerCommand( clientNum, va("print \""S_COLOR_WHITE"%s%s"S_COLOR_WHITE" %4i  %4i    %3.2f   %5i     %4i\n", newname, buffer, level.clients[i].pers.stats_hits[WP_RAILGUN],
							level.clients[i].pers.stats_shots[WP_RAILGUN], (float)level.clients[i].pers.stats_hits[WP_RAILGUN] / (float)(level.clients[i].pers.stats_shots[WP_RAILGUN] + .0001) * 100.01f,
							level.clients[i].pers.stats_railjumps, level.clients[i].pers.stats_frags[WP_RAILGUN] + level.clients[i].pers.stats_frags[WP_GAUNTLET] ));
					}
				}
			}
		}
	} else if ( g_gamemode.integer == 3 ) {
		//Rockets and Rails
		trap_SendServerCommand( -1, va("print \""S_COLOR_WHITE"Player                 Hits  Shots   Rl     Rg      Damage\n\""));
			trap_SendServerCommand( -1, va("print \""S_COLOR_WHITE"-----------------------------------------------------------------------------\n\""));
			//for ( i = 0; i < MAX_CLIENTS; i++ ) {
			for ( i = 0; i < g_maxclients.integer; i++ ) {
				if ( level.clients[i].pers.connected == CON_CONNECTED) {
					if (level.clients[i].pers.stats_shots[WP_RAILGUN] > 0 ) {
						char buffer[32];
						int	numColorCodesUsed = 0, ii = 0;
						memset(&newname, 0, sizeof(newname));
						numColorCodesUsed = FixedName( newname, level.clients[i].pers.netname, 22);
						memset(&buffer, 0, sizeof(buffer));
						for ( ii = 0; (strlen(newname)-(numColorCodesUsed*2))+strlen(buffer) < 22; ii++ ) {
							buffer[ii] = ' ';
						}
							trap_SendServerCommand( clientNum, va("print \""S_COLOR_WHITE"%s%s"S_COLOR_WHITE" %4i  %4i    %3.2f %3.2f   %8i\n\"", newname, buffer, level.clients[i].pers.stats_hits[WP_RAILGUN] + level.clients[i].pers.stats_hits[WP_ROCKET_LAUNCHER],
								level.clients[i].pers.stats_shots[WP_RAILGUN] + level.clients[i].pers.stats_shots[WP_ROCKET_LAUNCHER],
								(float)level.clients[i].pers.stats_hits[WP_ROCKET_LAUNCHER] / (float)(level.clients[i].pers.stats_shots[WP_ROCKET_LAUNCHER] + .0001) * 100.01f,
								(float)level.clients[i].pers.stats_hits[WP_RAILGUN] / (float)(level.clients[i].pers.stats_shots[WP_RAILGUN] + .0001) * 100.01f,
								level.clients[i].pers.stats_totaldamage));
					}
				}
			}
	} else {
		trap_SendServerCommand( clientNum, va("print \""S_COLOR_RED"There was an error in stats. It was unable to find a stats board for your game configuration\nReport this issue with the current configuration to q3.revolution@gmail.com\n\""));
	}
	trap_SendServerCommand( clientNum, va("print \"\n\n\""));

	//Prevent printing twice?
	g_entities[clientNum].client->pers.stats_nextAllowedPrint = level.time + 3000;

}


/*
=================
Cmd_MuteStatus_f
=================
*/
void Cmd_MuteStatus_f( gentity_t *ent ) {

	if ( g_gametype.integer != 1 ) {
		switch (g_muteSpecs.integer) {
			case 1: 
			trap_SendServerCommand( ent-g_entities, "print \"Spectators are currently mute to players.\n\"" );
			break;
			default:
			trap_SendServerCommand( ent-g_entities, "print \"Spectators are not muted.\n\"" );
			break;
		}
		return;
	}
	
		if ( g_gametype.integer == 1 ) {
			
		switch (g_muteTourneyspecs.integer) {
			case 1: 
				trap_SendServerCommand( ent-g_entities, "print \"Tournament spectators are currently mute to players.\n\"" );
			break;
			default:
				trap_SendServerCommand( ent-g_entities, "print \"Tournament spectators are not muted.\n\"" );
			break;
		}
		return;
	}

}

/*
=================
Cmd_TossFlag_f
=================
*/

void Cmd_TossFlag_f( gentity_t *ent ) { 
	gitem_t		*item;
	float		angle = 0;
	gentity_t	*drop;

	//FIXME: Broken in promode
	if (level.match_timeout == 1/* || g_pro_mode.integer == 1*/) {
		return;
	} else if( !gameSettings.allowTossflag ) {
		return;
	}

	if ( ent->client->ps.powerups[PW_REDFLAG] ) {
		//trap_SendServerCommand( -1, " print \"DBG: toss red flag.\n\"");
		item = BG_FindItemForPowerup( PW_REDFLAG );
		ent->client->ps.powerups[PW_REDFLAG] = 0;
		ent->client->naft[1] = PW_REDFLAG;
	} else if ( ent->client->ps.powerups[PW_BLUEFLAG] ) {
		//trap_SendServerCommand( -1, " print \"DBG: toss blue flag.\n\"");
		item = BG_FindItemForPowerup( PW_BLUEFLAG );
		ent->client->ps.powerups[PW_BLUEFLAG] = 0;
		ent->client->naft[1] = PW_BLUEFLAG;
	} else {
		//trap_SendServerCommand( -1, " print \"return.\n\"");
		return;
	}

	
	ent->client->naft[0] = (level.time + 700);

	drop = Drop_Item( ent, item, angle, qtrue );
	//drop = Drop_ItemFlag( ent, item, angle );
//	angle += 45;


	//}
}

/*
=================
ReadyCheck()
We check the status of totalReady against numPlayingClients
=================
*/
void ReadyCheck ( void ) {
	
	if ( (level.totalReady == level.numPlayingClients ||
		g_allowReady.integer >= 2 && level.totalReady >= level.numPlayingClients * (g_allowReady.integer * .01)) && level.warmupTime != -1 ) {
			if ( g_readyGrace.integer >= 2 ) {
					trap_SendServerCommand( -1, ("cp \"All players are now ready.\n\""));
				}
			level.warmupTime = level.time + (g_readyGrace.integer * 1000);
			trap_SetConfigstring( CS_WARMUP, va("%i", level.warmupTime) );
			return;
	}
	if ( level.totalReady != level.numPlayingClients && level.warmupTime != -1 && level.warmupTime != level.originalWarmupTime ) {
			level.warmupTime = level.originalWarmupTime;
			trap_SetConfigstring( CS_WARMUP, va("%i", level.warmupTime) );
			return;
	}
}

/*
=================
Ready
=================
*/
void Cmd_Ready_f ( gentity_t *ent ) {

	if ( (level.warmupTime - level.time >= 5000) && !level.clients[ent-g_entities].playerReady) {
		int readyMask = 0;
		int i;

		level.totalReady++;
		level.clients[ent-g_entities].playerReady = qtrue;
		//FIXME: Send a command to clients to tag this client as ready.

		for (i=0 ; i< g_maxclients.integer ; i++) {
			if ( level.clients[i].pers.connected != CON_CONNECTED ) {
				continue;
			}
			if ( g_entities[level.clients[i].ps.clientNum].r.svFlags & SVF_BOT ) {
				continue;
			}

			if ( level.clients[i].playerReady ) {
				if ( i < 32 ) {
					readyMask |= 1 << i;
				}
			}
		}

		for (i=0 ; i< g_maxclients.integer ; i++) {
			if ( level.clients[i].pers.connected != CON_CONNECTED ) {
				continue;
			}
			level.clients[i].ps.stats[STAT_CLIENTS_READY] = readyMask;
		}
		trap_SendServerCommand( -1, va("rd %i\n\"", ent-g_entities) );
		//trap_SendServerCommand( -1, va("cp \"%s" S_COLOR_WHITE " is now ready.\n\"", ent->client->pers.netname) );
	}
	ReadyCheck();
}

/*
=================
Notready
=================
*/
void Cmd_Notready_f ( gentity_t *ent ) {
	//G_Printf("Not ready: %i %i",ent-g_entities, level.clients[ent-g_entities].playerReady);
	if ( level.clients[ent-g_entities].playerReady ) {
		int readyMask = 0;
		int i;

		level.totalReady--;
		level.clients[ent-g_entities].playerReady = qfalse;
		//FIXME: Send a command to clients to untag this client as ready.
		for (i=0 ; i< g_maxclients.integer ; i++) {
			if ( level.clients[i].pers.connected != CON_CONNECTED ) {
				continue;
			}
			if ( g_entities[level.clients[i].ps.clientNum].r.svFlags & SVF_BOT ) {
				continue;
			}

			if ( level.clients[i].playerReady ) {
				if ( i < 32 ) {
					readyMask |= 1 << i;
				}
			}
		}

		for (i=0 ; i< g_maxclients.integer ; i++) {
			if ( level.clients[i].pers.connected != CON_CONNECTED ) {
				continue;
			}
			level.clients[i].ps.stats[STAT_CLIENTS_READY] = readyMask;
		}
		trap_SendServerCommand( -1, va("nrd %i\n\"", ent-g_entities) );
		//trap_SendServerCommand( -1, va("cp \"%s" S_COLOR_WHITE " is not ready.\n\"", ent->client->pers.netname) );
	}
	ReadyCheck();
}

/*
=================
TimeOut
=================
*/
void Cmd_Timeout_f( int time ) {
	if (level.match_timeout == 0 ) {
		level.match_timeout = 1;
		level.match_timein = 0;
		if ( time != -1 ) {
			level.match_timein = level.time + (time * 1000)/*( g_timeOutLength.integer * 1000)*/;
		}
	} else {
		return;
	}
}

/*
=================
TimeIn
=================
*/
void Cmd_Timein_f( int time  ) {
	if (level.match_timeout == 1 ) {
		level.match_timein = level.time + (time * 1000);
		//level.match_timeout = 0;
		//level.match_timein = 0;
		//level.match_time = 0;
		//level.match_timein = level.time + (time * 1000)/*( g_timeOutLength.integer * 1000)*/;
		//trap_SendServerCommand( -1, va("cp \"Time in!\n\""));
	} else {
		return;
	}
}

/*
==================
  cmd_players_f
==================
*/
void cmd_players_f ( gentity_t *ent ) {
		int i, idnum, playercount = 0;
		int user_rate, /*user_snaps, user_timenudge,*/ user_maxfps, user_packetdup, user_maxpackets;
		char *s, userinfo[MAX_INFO_STRING], playername[MAX_QPATH];
		char buffer[32];
		int	numColorCodesUsed = 0, ii = 0;
		gclient_t *cl;
		gentity_t *cl_ent;

		//Start fetching data and print it to the console
		trap_SendServerCommand( ent-g_entities, va("print \"\n^3 ID NAME            RATE   MAXFPS  PACKETDUP  MAXPACKETS  AIMTYPE\n\""));
		trap_SendServerCommand( ent-g_entities, va("print \"^3-----------------------------------------------------------------------\n\""));
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

		//s = Info_ValueForKey( userinfo, "snaps" );//Get /snaps
		//user_snaps = atoi(s);

		//s = Info_ValueForKey( userinfo, "cl_timeNudge" );//Get /cl_timenudge
		//user_timenudge = atoi(s);

		s = Info_ValueForKey( userinfo, "com_maxfps" );//Get /com_maxfps
		user_maxfps = atoi(s);

		s = Info_ValueForKey( userinfo, "cl_packetdup" );//Get /cl_packetdup
		user_packetdup = atoi(s);

		s = Info_ValueForKey( userinfo, "cl_maxpackets" );//Get /cl_maxpackets
		user_maxpackets = atoi(s);
		
		//Print all the data for the client it was requested from.
		trap_SendServerCommand( ent-g_entities, va("print \"^7%2i  %s%s"S_COLOR_WHITE" %5i%7i%9i%13i%8i/%i\n\"",
		idnum, playername, buffer, user_rate, user_maxfps, user_packetdup, user_maxpackets, cl->sess.aimType, g_delagHitscan.integer));

			}

		}
		//Print the bottom of the table, and total number of players connected
		trap_SendServerCommand( ent-g_entities, va("print \"^3---------------------------^7%3d ^3PLAYERS  -------------------------------\n\"", playercount));
}

/*
==================
  cmd_speconly_f
==================
*/
void cmd_speconly_f ( gentity_t *ent ) {
	(ent->client->sess.speconly & 1)?(ent->client->sess.speconly &= ~1):(ent->client->sess.speconly |= 1);

	if (ent->client->sess.speconly & 1) {
		trap_SendServerCommand( ent-g_entities, "print \"^3You are now set to specatate only.\"");
		return;
	}
	trap_SendServerCommand( ent-g_entities, "print \"^3You are not set to only specatate.\"");
}

/*
==================
Cmd_motd_f
==================
*/
void Cmd_motd_f( gentity_t *ent ) {
	trap_SendServerCommand( ent-g_entities, va("motd \"%s\" \"%s\" \"%s\" \"%s\" \"%s\" \"%s\" \"%s\" \"%s\"", 
		sv_motd1.string,
		sv_motd2.string,
		sv_motd3.string,
		sv_motd4.string,
		sv_motd5.string,
		sv_motd6.string,
		sv_motd7.string,
		sv_motd8.string) );
}

void Cmd_Admin_f( gentity_t *ent ) {
	char	arg1[MAX_TOKEN_CHARS], arg2[MAX_TOKEN_CHARS];
	char	/*clientpass[128],*/ cvarName[128], ip[24];
	char	*s, clientsinfo[MAX_INFO_STRING];
//	char	*found, sanitizedname[128], sanitizedarg[128];

//	gclient_t	*cl;

	trap_Argv( 1, arg1, sizeof( arg1 ) );
	trap_Argv( 2, arg2, sizeof( arg2 ) );
	

	if ( strlen(g_AdminPassword.string) == 0 || !ent->client->sess.isAdmin ) {
		trap_SendServerCommand( ent-g_entities, va("print \"Access denied.\n\"") );
		return;
	}

	if ( Q_stricmp(arg1, "adminpassword") == 0 ||
		Q_stricmp(arg1, "rconpassword") == 0 ||
		Q_stricmp(arg1, "rcon") == 0 || Q_stricmp(arg1, "sets") == 0 ||
		Q_stricmp(arg1, "set") == 0 || Q_stricmp(arg1, "seta") == 0 ||
		Q_stricmp(arg1, "setu") == 0) {
			trap_SendServerCommand( ent-g_entities, va("print \"Unavailable command.\n\"") );
		return;
	}
	
	trap_GetUserinfo( ent-g_entities, clientsinfo, sizeof(clientsinfo) );

	s = Info_ValueForKey (clientsinfo, "ip");
	//atoi(s);
	strcpy(ip, s);

	/* Moved to AdminPasswrd_f to remove the clientinfo cvar.
	s = Info_ValueForKey( clientsinfo, "adminPassword" );
	//atoi(s);
	strcpy(clientpass, s);

	if ( Q_stricmp(g_AdminPassword.string, clientpass) == 0 ) {
		ent->client->sess.isAdmin = 1;
	} else {
		ent->client->sess.isAdmin = 0;
		trap_SendServerCommand( ent-g_entities, va("print \"Insufficient user privileges.\n\"") );
		return;
	}*/
	
	/*if ( Q_stricmp(arg1, "find") == 0 ) {
		SanitizeString(arg2, sanitizedarg);				
		for(i = 0; i < level.maxclients; i++) {
			cl = &level.clients[i];
			SanitizeString(cl->pers.netname, sanitizedname);
			Q_CleanStr(sanitizedname);
			found = strstr(sanitizedname, sanitizedarg);					
			if( found != 0) {
				trap_SendServerCommand( ent->client->ps.clientNum, va("print \"%s[%i]\n\"", sanitizedname, cl->ps.clientNum ));
			}
		}
		return;
	} this just finds a player from a partial search and then prints out the slot number along with the full name */


	
	Com_sprintf(cvarName, sizeof(cvarName), "disable_admin_%s", arg1);


	if ( !trap_Cvar_VariableIntegerValue(cvarName) ) { //pain-in-the-ass
		trap_SendConsoleCommand( EXEC_NOW, va("%s %s", arg1, arg2) );
		//G_Printf("Admin command ([%i][%i]%s): %s %s\n", ent->client->ps.clientNum, ent->client->pers.netname, arg1, arg2 );
		//G_LogPrintF prints to console also
		G_LogPrintf("Admin command ([%i][%s]%s): %s %s\n", ent-g_entities, ip, ent->client->pers.netname, arg1, arg2 ); //For server log
		
	} else {			
		trap_SendServerCommand( ent-g_entities, va("print \"Admin: %s can not be changed.\n\"", arg1) );
		return;
	}

}

void Cmd_AdminPassword_f( gentity_t *ent ) {
	char	arg1[MAX_TOKEN_CHARS];
	char	*s, ip[24], clientsinfo[MAX_INFO_STRING];

	if ( strlen(g_AdminPassword.string) == 0 || !ent->client ) {
		return;
	}

	trap_Argv( 1, arg1, sizeof( arg1 ) );

	trap_GetUserinfo( ent-g_entities, clientsinfo, sizeof(clientsinfo) );
	s = Info_ValueForKey (clientsinfo, "ip");
	strcpy(ip, s);

	G_LogPrintf("Admin Login Attempt ([%i][%s])\n", ent-g_entities, ip); //For server log

	if ( Q_stricmp(g_AdminPassword.string, arg1) == 0 ) {
		ent->client->sess.isAdmin = qtrue;
	} else {
		ent->client->sess.isAdmin = qfalse;
	}
}

/*
=================
Save/Load
=================
*/
void Cmd_LoadPos_f( gentity_t *ent, char *arg1 ) {

	if (g_allowSave.integer == 0)
		return;
	if (ent->health <= 0)
		return;
	if (level.match_timeout == 1)
		return;
	if ( !Q_stricmp(arg1, "save") ) {
		VectorCopy( ent->client->ps.viewangles, ent->client->pers.load.angles );
		VectorCopy( ent->client->ps.origin, ent->client->pers.load.origin );
		ent->client->pers.load.hasSaved = qtrue;
	}
	if ( !Q_stricmp(arg1, "load") && ent->client->pers.load.hasSaved ) {
		TeleportPlayer( ent, ent->client->pers.load.origin, ent->client->pers.load.angles, qfalse );
	}

}

/*
=================
ClientCommand
=================
*/
void ClientCommand( int clientNum ) {
	gentity_t *ent;
	char	cmd[MAX_TOKEN_CHARS];

	ent = g_entities + clientNum;
	if ( !ent->client ) {
		return;		// not fully in game yet
	}


	trap_Argv( 0, cmd, sizeof( cmd ) );

	if (Q_stricmp (cmd, "say") == 0) {
		if ( !ent->client->pers.altConsoleSayMode ) {
			Cmd_Say_f (ent, SAY_ALL, qfalse);
		} else {
			Cmd_Say_f (ent, SAY_TEAM, qfalse);
		}
		return;
	}
	if (Q_stricmp (cmd, "say_team") == 0) {
		if ( !ent->client->pers.altConsoleSayMode ) {
			Cmd_Say_f (ent, SAY_TEAM, qfalse);
		} else {
			Cmd_Say_f (ent, SAY_ALL, qfalse);
		}
		return;
	}
	if (Q_stricmp (cmd, "tell") == 0) {
		Cmd_Tell_f ( ent );
		return;
	}
	if (Q_stricmp (cmd, "vsay") == 0) {
		Cmd_Voice_f (ent, SAY_ALL, qfalse, qfalse);
		return;
	}
	if (Q_stricmp (cmd, "vsay_team") == 0) {
		Cmd_Voice_f (ent, SAY_TEAM, qfalse, qfalse);
		return;
	}
	if (Q_stricmp (cmd, "vtell") == 0) {
		Cmd_VoiceTell_f ( ent, qfalse );
		return;
	}
	if (Q_stricmp (cmd, "vosay") == 0) {
		Cmd_Voice_f (ent, SAY_ALL, qfalse, qtrue);
		return;
	}
	if (Q_stricmp (cmd, "vosay_team") == 0) {
		Cmd_Voice_f (ent, SAY_TEAM, qfalse, qtrue);
		return;
	}
	if (Q_stricmp (cmd, "votell") == 0) {
		Cmd_VoiceTell_f ( ent, qtrue );
		return;
	}
	if (Q_stricmp (cmd, "vtaunt") == 0) {
		Cmd_VoiceTaunt_f ( ent );
		return;
	}
	if (Q_stricmp (cmd, "score") == 0) {
		Cmd_Score_f (ent);
		return;
	}
	if (Q_stricmp (cmd, "mutestatus") == 0) {
		Cmd_MuteStatus_f (ent);
		return;
	}
	if (Q_stricmp (cmd, "callvote") == 0) {
		Cmd_CallVote_f (ent);
		return;
	}
	if (Q_stricmp (cmd, "vote") == 0) {
		if ( level.voteTime && level.voteYes != 128 && !(ent->client->ps.eFlags & EF_VOTED) ) {
			Cmd_Vote_f (ent);
			return;
		} else if ( ((level.teamVoteTime[TEAM_RED-1] && level.teamVoteYes[TEAM_RED-1] != 128 && ent->client->sess.sessionTeam == TEAM_RED)
				|| ( level.teamVoteTime[TEAM_BLUE-1] && level.teamVoteYes[TEAM_BLUE-1] != 128  && ent->client->sess.sessionTeam == TEAM_BLUE)) &&
				!(ent->client->ps.eFlags & EF_TEAMVOTED)) {
					Cmd_TeamVote_f (ent);
					return;
		} else {
			trap_SendServerCommand( ent-g_entities, "print \"No vote in progress.\n\"" );
			return;
		}
		
	}
	if (Q_stricmp (cmd, "admin") == 0) {
		Cmd_Admin_f (ent);
		return;
	}
	if (Q_stricmp (cmd, "adminPassword") == 0) {
		Cmd_AdminPassword_f (ent);
		return;
	}
	if (Q_stricmp (cmd, "players") == 0) {
		cmd_players_f (ent);
		return;
	}
	if (Q_stricmp (cmd, "speconly") == 0) {
		cmd_speconly_f (ent);
		return;
	}
	if (Q_stricmp (cmd, "rws") == 0) {

		if ( level.intermissiontime ) {
			return;
		}

		Cmd_Weapon_f( ent );
		return;
	}

	if (Q_stricmp (cmd, "stats") == 0) {
		Cmd_Stats_f( ent-g_entities );
		return;
	}

	if (Q_stricmp (cmd, "quickmodes") == 0) {
		Cmd_Quickmodes_f( ent );
		return;
	}

	if (Q_stricmp (cmd, "teams") == 0) {
		Cmd_Teams_f( ent );
		return;
	}

	if (Q_stricmp (cmd, "lock") == 0) {
		if (level.intermissiontime || ent->client->sess.sessionTeam == TEAM_SPECTATOR || level.team_Locked[ent->client->sess.sessionTeam] || !g_allowLockedTeams.integer ) {
			//Don't spam it in intermission, team is spectator, already locked, or not allowed to lock
			return;
		}
		level.team_Locked[ent->client->sess.sessionTeam] = qtrue;
		return;
	}

	if (Q_stricmp (cmd, "unlock") == 0) {
		if (level.intermissiontime || ent->client->sess.sessionTeam == TEAM_SPECTATOR || !level.team_Locked[ent->client->sess.sessionTeam] ) {
			//Don't spam it in intermission, team is spectator, or isn't locked
			return;
		}
		level.team_Locked[ent->client->sess.sessionTeam] = qfalse;
		return;
	}

	if (Q_stricmp (cmd, "motd") == 0) {
		Cmd_motd_f (ent);
		return;
	}

	if ( Q_stricmp(cmd, "altConsoleSayMode") == 0 ) {
		ent->client->pers.altConsoleSayMode?(ent->client->pers.altConsoleSayMode = qfalse):(ent->client->pers.altConsoleSayMode = qtrue);
		return;
	}



	/*if ( Q_stricmp( cmd, "dbgrws") == 0 ) {
		if ( !ent->client->pers.dbgrws ) {
			ent->client->pers.dbgrws = qtrue;
		} else {
			ent->client->pers.dbgrws = qfalse;
		}
	}*/

	/*if ( Q_stricmp( cmd, "dbgflags" ) == 0 ) {
		int i = 0;
		int	j = 0;

		if ( !level.dbgflags ) {
			level.dbgflags = qtrue;
		} else {
			level.dbgflags = qfalse;
		}
		//I'll probably have to add to this to add all kinds of spew about the flag.
		for ( i = 0; i < MAX_GENTITIES; i++ ) {
			if ( level.gentities[i].item && level.gentities[i].item->giType == IT_TEAM &&
				( level.gentities[i].item->giTag == PW_REDFLAG || level.gentities[i].item->giTag == PW_BLUEFLAG ) ) {
				j++;
			}
			if ( j == 2 ) {
				break;
			}
		}

		trap_SendServerCommand( ent-g_entities, va("print \"DBG:Flag: Found %i flags.\n\"", j) );
	}*/


	// ignore all other commands when at intermission
	if (level.intermissiontime) {
		Cmd_Say_f (ent, qfalse, qtrue);
		return;
	}

	if (Q_stricmp (cmd, "give") == 0)
		Cmd_Give_f (ent);
	else if (Q_stricmp (cmd, "god") == 0)
		Cmd_God_f (ent);
	else if (Q_stricmp (cmd, "notarget") == 0)
		Cmd_Notarget_f (ent);
	else if (Q_stricmp (cmd, "noclip") == 0)
		Cmd_Noclip_f (ent);
	else if (Q_stricmp (cmd, "kill") == 0)
		Cmd_Kill_f (ent);
	else if (Q_stricmp (cmd, "teamtask") == 0)
		Cmd_TeamTask_f (ent);
	else if (Q_stricmp (cmd, "levelshot") == 0)
		Cmd_LevelShot_f (ent);
	else if (Q_stricmp (cmd, "follow") == 0)
		Cmd_Follow_f (ent);
	else if (Q_stricmp (cmd, "follownext") == 0)
		Cmd_FollowCycle_f (ent, 1);
	else if (Q_stricmp (cmd, "followprev") == 0)
		Cmd_FollowCycle_f (ent, -1);
	else if (Q_stricmp (cmd, "team") == 0)
		Cmd_Team_f (ent);
	else if (Q_stricmp (cmd, "where") == 0)
		Cmd_Where_f (ent);
	else if (Q_stricmp (cmd, "callteamvote") == 0)
		Cmd_CallTeamVote_f (ent);
	else if (Q_stricmp (cmd, "teamvote") == 0)
		Cmd_TeamVote_f (ent);
	else if (Q_stricmp (cmd, "gc") == 0)
		Cmd_GameCommand_f( ent );
	else if (Q_stricmp (cmd, "setviewpos") == 0)
		Cmd_SetViewpos_f( ent );
	//Ready!!
	else if (Q_stricmp (cmd, "ready") == 0)
		Cmd_Ready_f( ent );
	//Notready!!
	else if (Q_stricmp (cmd, "notready") == 0)
		Cmd_Notready_f( ent );
	else if (Q_stricmp (cmd, "tossflag") == 0)
		Cmd_TossFlag_f( ent );
	else if (Q_stricmp (cmd, "maplist") == 0)
		Cmd_MapList_f( ent );
	else if (Q_stricmp (cmd, "save") == 0)
		Cmd_LoadPos_f( ent, cmd );
	else if (Q_stricmp (cmd, "load") == 0)
		Cmd_LoadPos_f( ent, cmd );

	//else if (Q_stricmp (cmd, "WeaponSwitch") == 0)
	//	Cmd_WeaponSwitch_f( ent );
	//else if (Q_stricmp (cmd, "timeout") == 0)
	//	Cmd_Timeout_f( void );
	else
		trap_SendServerCommand( clientNum, va("print \"unknown cmd %s\n\"", cmd ) );
}
