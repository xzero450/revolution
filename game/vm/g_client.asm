data
align 4
LABELV playerMins
byte 4 3245342720
byte 4 3245342720
byte 4 3250585600
align 4
LABELV playerMaxs
byte 4 1097859072
byte 4 1097859072
byte 4 1107296256
export SP_info_player_deathmatch
code
proc SP_info_player_deathmatch 8 12
file "../g_client.c"
line 18
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:#include "g_local.h"
;4:#include "bg_promode.h"
;5:
;6:// g_client.c -- client functions that don't happen every frame
;7:
;8:static vec3_t	playerMins = {-15, -15, -24};
;9:static vec3_t	playerMaxs = {15, 15, 32};
;10:
;11:/*QUAKED info_player_deathmatch (1 0 1) (-16 -16 -24) (16 16 32) initial
;12:potential spawning position for deathmatch games.
;13:The first time a player enters the game, they will be at an 'initial' spot.
;14:Targets will be fired when someone spawns in on them.
;15:"nobots" will prevent bots from using this spot.
;16:"nohumans" will prevent non-bots from using this spot.
;17:*/
;18:void SP_info_player_deathmatch( gentity_t *ent ) {
line 21
;19:	int		i;
;20:
;21:	G_SpawnInt( "nobots", "0", &i);
ADDRGP4 $68
ARGP4
ADDRGP4 $69
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnInt
CALLI4
pop
line 22
;22:	if ( i ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $70
line 23
;23:		ent->flags |= FL_NO_BOTS;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 8192
BORI4
ASGNI4
line 24
;24:	}
LABELV $70
line 25
;25:	G_SpawnInt( "nohumans", "0", &i );
ADDRGP4 $72
ARGP4
ADDRGP4 $69
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnInt
CALLI4
pop
line 26
;26:	if ( i ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $73
line 27
;27:		ent->flags |= FL_NO_HUMANS;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
line 28
;28:	}
LABELV $73
line 29
;29:}
LABELV $67
endproc SP_info_player_deathmatch 8 12
export SP_info_player_start
proc SP_info_player_start 0 4
line 34
;30:
;31:/*QUAKED info_player_start (1 0 0) (-16 -16 -24) (16 16 32)
;32:equivelant to info_player_deathmatch
;33:*/
;34:void SP_info_player_start(gentity_t *ent) {
line 35
;35:	ent->classname = "info_player_deathmatch";
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $76
ASGNP4
line 36
;36:	SP_info_player_deathmatch( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 SP_info_player_deathmatch
CALLV
pop
line 37
;37:}
LABELV $75
endproc SP_info_player_start 0 4
export SP_info_player_intermission
proc SP_info_player_intermission 0 0
line 42
;38:
;39:/*QUAKED info_player_intermission (1 0 1) (-16 -16 -24) (16 16 32)
;40:The intermission will be viewed from this point.  Target an info_notnull for the view direction.
;41:*/
;42:void SP_info_player_intermission( gentity_t *ent ) {
line 44
;43:
;44:}
LABELV $77
endproc SP_info_player_intermission 0 0
export SpotWouldTelefrag
proc SpotWouldTelefrag 4144 16
line 62
;45:
;46:
;47:
;48:/*
;49:=======================================================================
;50:
;51:  SelectSpawnPoint
;52:
;53:=======================================================================
;54:*/
;55:
;56:/*
;57:================
;58:SpotWouldTelefrag
;59:
;60:================
;61:*/
;62:qboolean SpotWouldTelefrag( gentity_t *spot ) {
line 68
;63:	int			i, num;
;64:	int			touch[MAX_GENTITIES];
;65:	gentity_t	*hit;
;66:	vec3_t		mins, maxs;
;67:
;68:	VectorAdd( spot->s.origin, playerMins, mins );
ADDRLP4 4132
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4108
ADDRLP4 4132
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRGP4 playerMins
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4108+4
ADDRLP4 4132
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRGP4 playerMins+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4108+8
ADDRFP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRGP4 playerMins+8
INDIRF4
ADDF4
ASGNF4
line 69
;69:	VectorAdd( spot->s.origin, playerMaxs, maxs );
ADDRLP4 4136
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4120
ADDRLP4 4136
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRGP4 playerMaxs
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4120+4
ADDRLP4 4136
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRGP4 playerMaxs+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4120+8
ADDRFP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRGP4 playerMaxs+8
INDIRF4
ADDF4
ASGNF4
line 70
;70:	num = trap_EntitiesInBox( mins, maxs, touch, MAX_GENTITIES );
ADDRLP4 4108
ARGP4
ADDRLP4 4120
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 4140
ADDRGP4 trap_EntitiesInBox
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 4140
INDIRI4
ASGNI4
line 72
;71:
;72:	for (i=0 ; i<num ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $90
JUMPV
LABELV $87
line 73
;73:		hit = &g_entities[touch[i]];
ADDRLP4 4
CNSTI4 896
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 75
;74:		//if ( hit->client && hit->client->ps.stats[STAT_HEALTH] > 0 ) {
;75:		if ( hit->client) {
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $91
line 76
;76:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $78
JUMPV
LABELV $91
line 79
;77:		}
;78:
;79:	}
LABELV $88
line 72
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $90
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $87
line 81
;80:
;81:	return qfalse;
CNSTI4 0
RETI4
LABELV $78
endproc SpotWouldTelefrag 4144 16
export SelectNearestDeathmatchSpawnPoint
proc SelectNearestDeathmatchSpawnPoint 40 12
line 92
;82:}
;83:
;84:/*
;85:================
;86:SelectNearestDeathmatchSpawnPoint
;87:
;88:Find the spot that we DON'T want to use
;89:================
;90:*/
;91:#define	MAX_SPAWN_POINTS	128
;92:gentity_t *SelectNearestDeathmatchSpawnPoint( vec3_t from ) {
line 98
;93:	gentity_t	*spot;
;94:	vec3_t		delta;
;95:	float		dist, nearestDist;
;96:	gentity_t	*nearestSpot;
;97:
;98:	nearestDist = 999999;
ADDRLP4 20
CNSTF4 1232348144
ASGNF4
line 99
;99:	nearestSpot = NULL;
ADDRLP4 24
CNSTP4 0
ASGNP4
line 100
;100:	spot = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
ADDRGP4 $95
JUMPV
LABELV $94
line 102
;101:
;102:	while ((spot = G_Find (spot, FOFS(classname), "info_player_deathmatch")) != NULL) {
line 104
;103:
;104:		VectorSubtract( spot->s.origin, from, delta );
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 105
;105:		dist = VectorLength( delta );
ADDRLP4 4
ARGP4
ADDRLP4 36
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 36
INDIRF4
ASGNF4
line 106
;106:		if ( dist < nearestDist ) {
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
GEF4 $99
line 107
;107:			nearestDist = dist;
ADDRLP4 20
ADDRLP4 16
INDIRF4
ASGNF4
line 108
;108:			nearestSpot = spot;
ADDRLP4 24
ADDRLP4 0
INDIRP4
ASGNP4
line 109
;109:		}
LABELV $99
line 110
;110:	}
LABELV $95
line 102
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRGP4 $76
ARGP4
ADDRLP4 28
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $94
line 112
;111:
;112:	return nearestSpot;
ADDRLP4 24
INDIRP4
RETP4
LABELV $93
endproc SelectNearestDeathmatchSpawnPoint 40 12
export SelectRandomDeathmatchSpawnPoint
proc SelectRandomDeathmatchSpawnPoint 532 12
line 124
;113:}
;114:
;115:
;116:/*
;117:================
;118:SelectRandomDeathmatchSpawnPoint
;119:
;120:go to a random point that doesn't telefrag
;121:================
;122:*/
;123:#define	MAX_SPAWN_POINTS	128
;124:gentity_t *SelectRandomDeathmatchSpawnPoint( void ) {
line 130
;125:	gentity_t	*spot;
;126:	int			count;
;127:	int			selection;
;128:	gentity_t	*spots[MAX_SPAWN_POINTS];
;129:
;130:	count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 131
;131:	spot = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
ADDRGP4 $103
JUMPV
LABELV $102
line 133
;132:
;133:	while ((spot = G_Find (spot, FOFS(classname), "info_player_deathmatch")) != NULL) {
line 134
;134:		if ( SpotWouldTelefrag( spot ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 524
ADDRGP4 SpotWouldTelefrag
CALLI4
ASGNI4
ADDRLP4 524
INDIRI4
CNSTI4 0
EQI4 $105
line 135
;135:			continue;
ADDRGP4 $103
JUMPV
LABELV $105
line 137
;136:		}
;137:		spots[ count ] = spot;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 138
;138:		count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 139
;139:	}
LABELV $103
line 133
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRGP4 $76
ARGP4
ADDRLP4 524
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 524
INDIRP4
ASGNP4
ADDRLP4 524
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $102
line 141
;140:
;141:	if ( !count ) {	// no spots that won't telefrag
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $107
line 142
;142:		return G_Find( NULL, FOFS(classname), "info_player_deathmatch");
CNSTP4 0
ARGP4
CNSTI4 524
ARGI4
ADDRGP4 $76
ARGP4
ADDRLP4 528
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 528
INDIRP4
RETP4
ADDRGP4 $101
JUMPV
LABELV $107
line 145
;143:	}
;144:
;145:	selection = rand() % count;
ADDRLP4 528
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 520
ADDRLP4 528
INDIRI4
ADDRLP4 4
INDIRI4
MODI4
ASGNI4
line 146
;146:	return spots[ selection ];
ADDRLP4 520
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
INDIRP4
RETP4
LABELV $101
endproc SelectRandomDeathmatchSpawnPoint 532 12
export SelectRandomFurthestSpawnPoint
proc SelectRandomFurthestSpawnPoint 572 12
line 156
;147:}
;148:
;149:/*
;150:===========
;151:SelectRandomFurthestSpawnPoint
;152:
;153:Chooses a player start, deathmatch start, etc
;154:============
;155:*/
;156:gentity_t *SelectRandomFurthestSpawnPoint ( vec3_t avoidPoint, vec3_t origin, vec3_t angles ) {
line 164
;157:	gentity_t	*spot;
;158:	vec3_t		delta;
;159:	float		dist;
;160:	float		list_dist[64];
;161:	gentity_t	*list_spot[64];
;162:	int			numSpots, rnd, i, j;
;163:
;164:	numSpots = 0;
ADDRLP4 520
CNSTI4 0
ASGNI4
line 165
;165:	spot = NULL;
ADDRLP4 528
CNSTP4 0
ASGNP4
ADDRGP4 $111
JUMPV
LABELV $110
line 167
;166:
;167:	while ((spot = G_Find (spot, FOFS(classname), "info_player_deathmatch")) != NULL) {
line 168
;168:		if ( SpotWouldTelefrag( spot ) ) {
ADDRLP4 528
INDIRP4
ARGP4
ADDRLP4 548
ADDRGP4 SpotWouldTelefrag
CALLI4
ASGNI4
ADDRLP4 548
INDIRI4
CNSTI4 0
EQI4 $113
line 169
;169:			continue;
ADDRGP4 $111
JUMPV
LABELV $113
line 171
;170:		}
;171:		VectorSubtract( spot->s.origin, avoidPoint, delta );
ADDRLP4 556
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 532
ADDRLP4 528
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRLP4 556
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 532+4
ADDRLP4 528
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRLP4 556
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 532+8
ADDRLP4 528
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 172
;172:		dist = VectorLength( delta );
ADDRLP4 532
ARGP4
ADDRLP4 560
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 524
ADDRLP4 560
INDIRF4
ASGNF4
line 173
;173:		for (i = 0; i < numSpots; i++) {
ADDRLP4 516
CNSTI4 0
ASGNI4
ADDRGP4 $120
JUMPV
LABELV $117
line 174
;174:			if ( dist > list_dist[i] ) {
ADDRLP4 524
INDIRF4
ADDRLP4 516
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
LEF4 $121
line 175
;175:				if ( numSpots >= 64 )
ADDRLP4 520
INDIRI4
CNSTI4 64
LTI4 $123
line 176
;176:					numSpots = 64-1;
ADDRLP4 520
CNSTI4 63
ASGNI4
LABELV $123
line 177
;177:				for (j = numSpots; j > i; j--) {
ADDRLP4 0
ADDRLP4 520
INDIRI4
ASGNI4
ADDRGP4 $128
JUMPV
LABELV $125
line 178
;178:					list_dist[j] = list_dist[j-1];
ADDRLP4 564
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 564
INDIRI4
ADDRLP4 4
ADDP4
ADDRLP4 564
INDIRI4
ADDRLP4 4-4
ADDP4
INDIRF4
ASGNF4
line 179
;179:					list_spot[j] = list_spot[j-1];
ADDRLP4 568
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 568
INDIRI4
ADDRLP4 260
ADDP4
ADDRLP4 568
INDIRI4
ADDRLP4 260-4
ADDP4
INDIRP4
ASGNP4
line 180
;180:				}
LABELV $126
line 177
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $128
ADDRLP4 0
INDIRI4
ADDRLP4 516
INDIRI4
GTI4 $125
line 181
;181:				list_dist[i] = dist;
ADDRLP4 516
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ADDRLP4 524
INDIRF4
ASGNF4
line 182
;182:				list_spot[i] = spot;
ADDRLP4 516
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 260
ADDP4
ADDRLP4 528
INDIRP4
ASGNP4
line 183
;183:				numSpots++;
ADDRLP4 520
ADDRLP4 520
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 184
;184:				if (numSpots > 64)
ADDRLP4 520
INDIRI4
CNSTI4 64
LEI4 $119
line 185
;185:					numSpots = 64;
ADDRLP4 520
CNSTI4 64
ASGNI4
line 186
;186:				break;
ADDRGP4 $119
JUMPV
LABELV $121
line 188
;187:			}
;188:		}
LABELV $118
line 173
ADDRLP4 516
ADDRLP4 516
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $120
ADDRLP4 516
INDIRI4
ADDRLP4 520
INDIRI4
LTI4 $117
LABELV $119
line 189
;189:		if (i >= numSpots && numSpots < 64) {
ADDRLP4 516
INDIRI4
ADDRLP4 520
INDIRI4
LTI4 $133
ADDRLP4 520
INDIRI4
CNSTI4 64
GEI4 $133
line 190
;190:			list_dist[numSpots] = dist;
ADDRLP4 520
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ADDRLP4 524
INDIRF4
ASGNF4
line 191
;191:			list_spot[numSpots] = spot;
ADDRLP4 520
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 260
ADDP4
ADDRLP4 528
INDIRP4
ASGNP4
line 192
;192:			numSpots++;
ADDRLP4 520
ADDRLP4 520
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 193
;193:		}
LABELV $133
line 194
;194:	}
LABELV $111
line 167
ADDRLP4 528
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRGP4 $76
ARGP4
ADDRLP4 548
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 528
ADDRLP4 548
INDIRP4
ASGNP4
ADDRLP4 548
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $110
line 195
;195:	if (!numSpots) {
ADDRLP4 520
INDIRI4
CNSTI4 0
NEI4 $135
line 196
;196:		spot = G_Find( NULL, FOFS(classname), "info_player_deathmatch");
CNSTP4 0
ARGP4
CNSTI4 524
ARGI4
ADDRGP4 $76
ARGP4
ADDRLP4 552
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 528
ADDRLP4 552
INDIRP4
ASGNP4
line 197
;197:		if (!spot)
ADDRLP4 528
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $137
line 198
;198:			G_Error( "Couldn't find a spawn point" );
ADDRGP4 $139
ARGP4
ADDRGP4 G_Error
CALLV
pop
LABELV $137
line 199
;199:		VectorCopy (spot->s.origin, origin);
ADDRFP4 4
INDIRP4
ADDRLP4 528
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 200
;200:		origin[2] += 9;
ADDRLP4 556
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 556
INDIRP4
ADDRLP4 556
INDIRP4
INDIRF4
CNSTF4 1091567616
ADDF4
ASGNF4
line 201
;201:		VectorCopy (spot->s.angles, angles);
ADDRFP4 8
INDIRP4
ADDRLP4 528
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 202
;202:		return spot;
ADDRLP4 528
INDIRP4
RETP4
ADDRGP4 $109
JUMPV
LABELV $135
line 206
;203:	}
;204:
;205:	// select a random spot from the spawn points furthest away
;206:	rnd = random() * (numSpots / 2);
ADDRLP4 552
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 544
ADDRLP4 552
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 520
INDIRI4
CNSTI4 2
DIVI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 208
;207:
;208:	VectorCopy (list_spot[rnd]->s.origin, origin);
ADDRFP4 4
INDIRP4
ADDRLP4 544
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 260
ADDP4
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 209
;209:	origin[2] += 9;
ADDRLP4 556
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 556
INDIRP4
ADDRLP4 556
INDIRP4
INDIRF4
CNSTF4 1091567616
ADDF4
ASGNF4
line 210
;210:	VectorCopy (list_spot[rnd]->s.angles, angles);
ADDRFP4 8
INDIRP4
ADDRLP4 544
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 260
ADDP4
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 212
;211:
;212:	return list_spot[rnd];
ADDRLP4 544
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 260
ADDP4
INDIRP4
RETP4
LABELV $109
endproc SelectRandomFurthestSpawnPoint 572 12
export SelectSpawnPoint
proc SelectSpawnPoint 4 12
line 222
;213:}
;214:
;215:/*
;216:===========
;217:SelectSpawnPoint
;218:
;219:Chooses a player start, deathmatch start, etc
;220:============
;221:*/
;222:gentity_t *SelectSpawnPoint ( vec3_t avoidPoint, vec3_t origin, vec3_t angles ) {
line 223
;223:	return SelectRandomFurthestSpawnPoint( avoidPoint, origin, angles );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 SelectRandomFurthestSpawnPoint
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
RETP4
LABELV $140
endproc SelectSpawnPoint 4 12
export SelectInitialSpawnPoint
proc SelectInitialSpawnPoint 20 12
line 262
;224:
;225:	/*
;226:	gentity_t	*spot;
;227:	gentity_t	*nearestSpot;
;228:
;229:	nearestSpot = SelectNearestDeathmatchSpawnPoint( avoidPoint );
;230:
;231:	spot = SelectRandomDeathmatchSpawnPoint ( );
;232:	if ( spot == nearestSpot ) {
;233:		// roll again if it would be real close to point of death
;234:		spot = SelectRandomDeathmatchSpawnPoint ( );
;235:		if ( spot == nearestSpot ) {
;236:			// last try
;237:			spot = SelectRandomDeathmatchSpawnPoint ( );
;238:		}		
;239:	}
;240:
;241:	// find a single player start spot
;242:	if (!spot) {
;243:		G_Error( "Couldn't find a spawn point" );
;244:	}
;245:
;246:	VectorCopy (spot->s.origin, origin);
;247:	origin[2] += 9;
;248:	VectorCopy (spot->s.angles, angles);
;249:
;250:	return spot;
;251:	*/
;252:}
;253:
;254:/*
;255:===========
;256:SelectInitialSpawnPoint
;257:
;258:Try to find a spawn point marked 'initial', otherwise
;259:use normal spawn selection.
;260:============
;261:*/
;262:gentity_t *SelectInitialSpawnPoint( vec3_t origin, vec3_t angles ) {
line 265
;263:	gentity_t	*spot;
;264:
;265:	spot = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
ADDRGP4 $143
JUMPV
LABELV $142
line 266
;266:	while ((spot = G_Find (spot, FOFS(classname), "info_player_deathmatch")) != NULL) {
line 267
;267:		if ( spot->spawnflags & 1 ) {
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $145
line 268
;268:			break;
ADDRGP4 $144
JUMPV
LABELV $145
line 270
;269:		}
;270:	}
LABELV $143
line 266
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRGP4 $76
ARGP4
ADDRLP4 4
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $142
LABELV $144
line 272
;271:
;272:	if ( !spot || SpotWouldTelefrag( spot ) ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $149
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 SpotWouldTelefrag
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $147
LABELV $149
line 273
;273:		return SelectSpawnPoint( vec3_origin, origin, angles );
ADDRGP4 vec3_origin
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 SelectSpawnPoint
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
RETP4
ADDRGP4 $141
JUMPV
LABELV $147
line 276
;274:	}
;275:
;276:	VectorCopy (spot->s.origin, origin);
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 277
;277:	origin[2] += 9;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
CNSTF4 1091567616
ADDF4
ASGNF4
line 278
;278:	VectorCopy (spot->s.angles, angles);
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 280
;279:
;280:	return spot;
ADDRLP4 0
INDIRP4
RETP4
LABELV $141
endproc SelectInitialSpawnPoint 20 12
export SelectSpectatorSpawnPoint
proc SelectSpectatorSpawnPoint 0 0
line 289
;281:}
;282:
;283:/*
;284:===========
;285:SelectSpectatorSpawnPoint
;286:
;287:============
;288:*/
;289:gentity_t *SelectSpectatorSpawnPoint( vec3_t origin, vec3_t angles ) {
line 290
;290:	FindIntermissionPoint();
ADDRGP4 FindIntermissionPoint
CALLV
pop
line 292
;291:
;292:	VectorCopy( level.intermission_origin, origin );
ADDRFP4 0
INDIRP4
ADDRGP4 level+9176
INDIRB
ASGNB 12
line 293
;293:	VectorCopy( level.intermission_angle, angles );
ADDRFP4 4
INDIRP4
ADDRGP4 level+9188
INDIRB
ASGNB 12
line 295
;294:
;295:	return NULL;
CNSTP4 0
RETP4
LABELV $150
endproc SelectSpectatorSpawnPoint 0 0
export InitBodyQue
proc InitBodyQue 12 0
line 311
;296:}
;297:
;298:/*
;299:=======================================================================
;300:
;301:BODYQUE
;302:
;303:=======================================================================
;304:*/
;305:
;306:/*
;307:===============
;308:InitBodyQue
;309:===============
;310:*/
;311:void InitBodyQue (void) {
line 315
;312:	int		i;
;313:	gentity_t	*ent;
;314:
;315:	level.bodyQueIndex = 0;
ADDRGP4 level+9208
CNSTI4 0
ASGNI4
line 316
;316:	for (i=0; i<BODY_QUEUE_SIZE ; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $155
line 317
;317:		ent = G_Spawn();
ADDRLP4 8
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 318
;318:		ent->classname = "bodyque";
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $159
ASGNP4
line 319
;319:		ent->neverFree = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 532
ADDP4
CNSTI4 1
ASGNI4
line 320
;320:		level.bodyQue[i] = ent;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+9212
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 321
;321:	}
LABELV $156
line 316
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 8
LTI4 $155
line 322
;322:}
LABELV $153
endproc InitBodyQue 12 0
export BodySink
proc BodySink 4 4
line 331
;323:
;324:/*
;325:=============
;326:BodySink
;327:
;328:After sitting around for five seconds, fall into the ground and dissapear
;329:=============
;330:*/
;331:void BodySink( gentity_t *ent ) {
line 332
;332:	if ( level.time - ent->timestamp > 6500 ) {
ADDRGP4 level+40
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 640
ADDP4
INDIRI4
SUBI4
CNSTI4 6500
LEI4 $162
line 335
;333:		// the body ques are never actually freed, they are just unlinked
;334:		//ent->relink = 0;
;335:		trap_UnlinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 336
;336:		ent->physicsObject = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
CNSTI4 0
ASGNI4
line 337
;337:		return;	
ADDRGP4 $161
JUMPV
LABELV $162
line 339
;338:	}
;339:	ent->nextthink = level.time + 100;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 340
;340:	ent->s.pos.trBase[2] -= 1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 341
;341:}
LABELV $161
endproc BodySink 4 4
export CopyToBodyQue
proc CopyToBodyQue 48 8
line 351
;342:
;343:/*
;344:=============
;345:CopyToBodyQue
;346:
;347:A player is respawning, so make an entity that looks
;348:just like the existing corpse to leave behind.
;349:=============
;350:*/
;351:void CopyToBodyQue( gentity_t *ent ) {
line 360
;352:#ifdef MISSIONPACK
;353:	gentity_t	*e;
;354:	int i;
;355:#endif
;356:	gentity_t		*body;
;357:	int			contents;
;358:
;359:	//ent->relink = 0;
;360:	trap_UnlinkEntity (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 363
;361:
;362:	// if client is in a nodrop area, don't leave the body
;363:	contents = trap_PointContents( ent->s.origin, -1 );
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 8
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 364
;364:	if ( contents & CONTENTS_NODROP ) {
ADDRLP4 4
INDIRI4
CVIU4 4
CNSTU4 2147483648
BANDU4
CNSTU4 0
EQU4 $167
line 365
;365:		return;
ADDRGP4 $166
JUMPV
LABELV $167
line 369
;366:	}
;367:
;368:	// grab a body que and cycle to the next one
;369:	body = level.bodyQue[ level.bodyQueIndex ];
ADDRLP4 0
ADDRGP4 level+9208
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+9212
ADDP4
INDIRP4
ASGNP4
line 370
;370:	level.bodyQueIndex = (level.bodyQueIndex + 1) % BODY_QUEUE_SIZE;
ADDRGP4 level+9208
ADDRGP4 level+9208
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 8
MODI4
ASGNI4
line 373
;371:
;372:	//body->relink = 0;
;373:	trap_UnlinkEntity (body);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 375
;374:
;375:	body->s = ent->s;
ADDRLP4 0
INDIRP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 208
line 376
;376:	body->s.eFlags = EF_DEAD;		// clear EF_TALK, etc
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 1
ASGNI4
line 395
;377:#ifdef MISSIONPACK
;378:	if ( ent->s.eFlags & EF_KAMIKAZE ) {
;379:		body->s.eFlags |= EF_KAMIKAZE;
;380:
;381:		// check if there is a kamikaze timer around for this owner
;382:		for (i = 0; i < MAX_GENTITIES; i++) {
;383:			e = &g_entities[i];
;384:			if (!e->inuse)
;385:				continue;
;386:			if (e->activator != ent)
;387:				continue;
;388:			if (strcmp(e->classname, "kamikaze timer"))
;389:				continue;
;390:			e->activator = body;
;391:			break;
;392:		}
;393:	}
;394:#endif
;395:	body->s.powerups = 0;	// clear powerups
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTI4 0
ASGNI4
line 396
;396:	body->s.loopSound = 0;	// clear lava burning
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
CNSTI4 0
ASGNI4
line 397
;397:	body->s.number = body - g_entities;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 896
DIVI4
ASGNI4
line 398
;398:	body->timestamp = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 640
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 399
;399:	body->physicsObject = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 564
ADDP4
CNSTI4 1
ASGNI4
line 400
;400:	body->physicsBounce = 0;		// don't bounce
ADDRLP4 0
INDIRP4
CNSTI4 568
ADDP4
CNSTF4 0
ASGNF4
line 401
;401:	if ( body->s.groundEntityNum == ENTITYNUM_NONE ) {
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 1023
NEI4 $174
line 402
;402:		body->s.pos.trType = TR_GRAVITY;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 5
ASGNI4
line 403
;403:		body->s.pos.trTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 404
;404:		VectorCopy( ent->client->ps.velocity, body->s.pos.trDelta );
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRB
ASGNB 12
line 405
;405:	} else {
ADDRGP4 $175
JUMPV
LABELV $174
line 406
;406:		body->s.pos.trType = TR_STATIONARY;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 407
;407:	}
LABELV $175
line 408
;408:	body->s.event = 0;
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
CNSTI4 0
ASGNI4
line 412
;409:
;410:	// change the animation to the last-frame only, so the sequence
;411:	// doesn't repeat anew for the body
;412:	switch ( body->s.legsAnim & ~ANIM_TOGGLEBIT ) {
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
LTI4 $177
ADDRLP4 16
INDIRI4
CNSTI4 5
GTI4 $177
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $183
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $183
address $180
address $180
address $181
address $181
address $182
address $182
code
LABELV $180
line 415
;413:	case BOTH_DEATH1:
;414:	case BOTH_DEAD1:
;415:		body->s.torsoAnim = body->s.legsAnim = BOTH_DEAD1;
ADDRLP4 28
CNSTI4 1
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 416
;416:		break;
ADDRGP4 $178
JUMPV
LABELV $181
line 419
;417:	case BOTH_DEATH2:
;418:	case BOTH_DEAD2:
;419:		body->s.torsoAnim = body->s.legsAnim = BOTH_DEAD2;
ADDRLP4 36
CNSTI4 3
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 420
;420:		break;
ADDRGP4 $178
JUMPV
LABELV $182
LABELV $177
line 424
;421:	case BOTH_DEATH3:
;422:	case BOTH_DEAD3:
;423:	default:
;424:		body->s.torsoAnim = body->s.legsAnim = BOTH_DEAD3;
ADDRLP4 44
CNSTI4 5
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
line 425
;425:		break;
LABELV $178
line 428
;426:	}
;427:
;428:	body->r.svFlags = ent->r.svFlags;
ADDRLP4 24
CNSTI4 424
ASGNI4
ADDRLP4 0
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
line 429
;429:	VectorCopy (ent->r.mins, body->r.mins);
ADDRLP4 28
CNSTI4 436
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRB
ASGNB 12
line 430
;430:	VectorCopy (ent->r.maxs, body->r.maxs);
ADDRLP4 32
CNSTI4 448
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRB
ASGNB 12
line 431
;431:	VectorCopy (ent->r.absmin, body->r.absmin);
ADDRLP4 36
CNSTI4 464
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRB
ASGNB 12
line 432
;432:	VectorCopy (ent->r.absmax, body->r.absmax);
ADDRLP4 40
CNSTI4 476
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRB
ASGNB 12
line 434
;433:
;434:	body->clipmask = CONTENTS_SOLID | CONTENTS_PLAYERCLIP;
ADDRLP4 0
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 65537
ASGNI4
line 435
;435:	body->r.contents = CONTENTS_CORPSE;
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 67108864
ASGNI4
line 436
;436:	body->r.ownerNum = ent->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 438
;437:
;438:	body->nextthink = level.time + 5000;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 5000
ADDI4
ASGNI4
line 439
;439:	body->think = BodySink;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 BodySink
ASGNP4
line 441
;440:
;441:	body->die = body_die;
ADDRLP4 0
INDIRP4
CNSTI4 716
ADDP4
ADDRGP4 body_die
ASGNP4
line 444
;442:
;443:	// don't take more damage if already gibbed
;444:	if ( ent->health <= GIB_HEALTH ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 -40
GTI4 $185
line 445
;445:		body->takedamage = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 0
ASGNI4
line 446
;446:	} else {
ADDRGP4 $186
JUMPV
LABELV $185
line 447
;447:		body->takedamage = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 1
ASGNI4
line 448
;448:	}
LABELV $186
line 451
;449:
;450:
;451:	VectorCopy ( body->s.pos.trBase, body->r.currentOrigin );
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 452
;452:	trap_LinkEntity (body);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 453
;453:}
LABELV $166
endproc CopyToBodyQue 48 8
export SetClientViewAngle
proc SetClientViewAngle 16 0
line 464
;454:
;455://======================================================================
;456:
;457:
;458:/*
;459:==================
;460:SetClientViewAngle
;461:
;462:==================
;463:*/
;464:void SetClientViewAngle( gentity_t *ent, vec3_t angle ) {
line 468
;465:	int			i;
;466:
;467:	// set the delta angle
;468:	for (i=0 ; i<3 ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $188
line 471
;469:		int		cmdAngle;
;470:
;471:		cmdAngle = ANGLE2SHORT(angle[i]);
ADDRLP4 4
CNSTF4 1199570944
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
MULF4
CNSTF4 1135869952
DIVF4
CVFI4 4
CNSTI4 65535
BANDI4
ASGNI4
line 472
;472:		ent->client->ps.delta_angles[i] = cmdAngle - ent->client->pers.cmd.angles[i];
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 56
ADDP4
ADDP4
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRI4
SUBI4
ASGNI4
line 473
;473:	}
LABELV $189
line 468
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $188
line 474
;474:	VectorCopy( angle, ent->s.angles );
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 475
;475:	VectorCopy (ent->s.angles, ent->client->ps.viewangles);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 152
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 476
;476:}
LABELV $187
endproc SetClientViewAngle 16 0
export respawn
proc respawn 12 8
line 483
;477:
;478:/*
;479:================
;480:respawn
;481:================
;482:*/
;483:void respawn( gentity_t *ent ) {
line 487
;484:	gentity_t	*tent;
;485:
;486://freeze
;487:	if ( g_gamemode.integer > 3 ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $193
line 488
;488:		if ( Set_spectator( ent ) ) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Set_spectator
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $196
ADDRGP4 $192
JUMPV
LABELV $196
line 489
;489:	}
LABELV $193
line 491
;490://freeze
;491:	CopyToBodyQue (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CopyToBodyQue
CALLV
pop
line 492
;492:	ClientSpawn(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 ClientSpawn
CALLV
pop
line 495
;493:
;494:	// add a teleportation effect
;495:	tent = G_TempEntity( ent->client->ps.origin, EV_PLAYER_TELEPORT_IN );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTI4 42
ARGI4
ADDRLP4 4
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 496
;496:	tent->s.clientNum = ent->s.clientNum;
ADDRLP4 8
CNSTI4 168
ASGNI4
ADDRLP4 0
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
line 497
;497:}
LABELV $192
endproc respawn 12 8
export TeamCount
proc TeamCount 8 0
line 506
;498:
;499:/*
;500:================
;501:TeamCount
;502:
;503:Returns number of players on a team
;504:================
;505:*/
;506:team_t TeamCount( int ignoreClientNum, int team ) {
line 508
;507:	int		i;
;508:	int		count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 510
;509:
;510:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $202
JUMPV
LABELV $199
line 511
;511:		if ( i == ignoreClientNum ) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $204
line 512
;512:			continue;
ADDRGP4 $200
JUMPV
LABELV $204
line 514
;513:		}
;514:		if ( level.clients[i].pers.connected == CON_DISCONNECTED ) {
CNSTI4 10828
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $206
line 515
;515:			continue;
ADDRGP4 $200
JUMPV
LABELV $206
line 517
;516:		}
;517:		if ( level.clients[i].sess.sessionTeam == team ) {
CNSTI4 10828
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 10188
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $208
line 518
;518:			count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 519
;519:		}
LABELV $208
line 520
;520:	}
LABELV $200
line 510
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $202
ADDRLP4 0
INDIRI4
ADDRGP4 level+28
INDIRI4
LTI4 $199
line 522
;521:
;522:	return count;
ADDRLP4 4
INDIRI4
RETI4
LABELV $198
endproc TeamCount 8 0
export TeamLeader
proc TeamLeader 4 0
line 532
;523:}
;524:
;525:/*
;526:================
;527:TeamLeader
;528:
;529:Returns the client number of the team leader
;530:================
;531:*/
;532:int TeamLeader( int team ) {
line 535
;533:	int		i;
;534:
;535:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $214
JUMPV
LABELV $211
line 536
;536:		if ( level.clients[i].pers.connected == CON_DISCONNECTED ) {
CNSTI4 10828
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $216
line 537
;537:			continue;
ADDRGP4 $212
JUMPV
LABELV $216
line 539
;538:		}
;539:		if ( level.clients[i].sess.sessionTeam == team ) {
CNSTI4 10828
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 10188
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $218
line 540
;540:			if ( level.clients[i].sess.teamLeader )
CNSTI4 10828
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 10212
ADDP4
INDIRI4
CNSTI4 0
EQI4 $220
line 541
;541:				return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $210
JUMPV
LABELV $220
line 542
;542:		}
LABELV $218
line 543
;543:	}
LABELV $212
line 535
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $214
ADDRLP4 0
INDIRI4
ADDRGP4 level+28
INDIRI4
LTI4 $211
line 545
;544:
;545:	return -1;
CNSTI4 -1
RETI4
LABELV $210
endproc TeamLeader 4 0
export PickTeam
proc PickTeam 24 8
line 555
;546:}
;547:
;548:
;549:/*
;550:================
;551:PickTeam
;552:
;553:================
;554:*/
;555:team_t PickTeam( int ignoreClientNum ) {
line 558
;556:	int		counts[TEAM_NUM_TEAMS];
;557:
;558:	counts[TEAM_BLUE] = TeamCount( ignoreClientNum, TEAM_BLUE );
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 16
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRLP4 0+8
ADDRLP4 16
INDIRI4
ASGNI4
line 559
;559:	counts[TEAM_RED] = TeamCount( ignoreClientNum, TEAM_RED );
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 20
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRLP4 0+4
ADDRLP4 20
INDIRI4
ASGNI4
line 561
;560:
;561:	if ( counts[TEAM_BLUE] > counts[TEAM_RED] ) {
ADDRLP4 0+8
INDIRI4
ADDRLP4 0+4
INDIRI4
LEI4 $225
line 562
;562:		return TEAM_RED;
CNSTI4 1
RETI4
ADDRGP4 $222
JUMPV
LABELV $225
line 564
;563:	}
;564:	if ( counts[TEAM_RED] > counts[TEAM_BLUE] ) {
ADDRLP4 0+4
INDIRI4
ADDRLP4 0+8
INDIRI4
LEI4 $229
line 565
;565:		return TEAM_BLUE;
CNSTI4 2
RETI4
ADDRGP4 $222
JUMPV
LABELV $229
line 568
;566:	}
;567:	// equal team count, so join the team with the lowest score
;568:	if ( level.teamScores[TEAM_BLUE] > level.teamScores[TEAM_RED] ) {
ADDRGP4 level+88+8
INDIRI4
ADDRGP4 level+88+4
INDIRI4
LEI4 $233
line 569
;569:		return TEAM_RED;
CNSTI4 1
RETI4
ADDRGP4 $222
JUMPV
LABELV $233
line 571
;570:	}
;571:	return TEAM_BLUE;
CNSTI4 2
RETI4
LABELV $222
endproc PickTeam 24 8
proc ClientCleanName 40 12
line 672
;572:}
;573:
;574:/*
;575:===========
;576:ForceClientSkin
;577:
;578:Forces a client's skin (for teamplay)
;579:===========
;580:*/
;581:/*
;582:static void ForceClientSkin( gclient_t *client, char *model, const char *skin ) {
;583:	char *p;
;584:
;585:	if ((p = Q_strrchr(model, '/')) != 0) {
;586:		*p = 0;
;587:	}
;588:
;589:	Q_strcat(model, MAX_QPATH, "/");
;590:	Q_strcat(model, MAX_QPATH, skin);
;591:}
;592:*/
;593:
;594:/*
;595:===========
;596:ParseBadNames
;597:We can't get any closer to CG_ParseAnimationFile, this damn thing better work
;598:===========
;599:*/ /*
;600:void ParseBadNames (char *p,  int outSize ) {
;601:	char		*text_p, *prev;
;602:		int			length;//, i, j;
;603:		char		*name;//, *Value;
;604:		//char		filePath[MAX_QPATH + 20];
;605:		int			skip;
;606:		char		text[20000];
;607:		char		filename[MAX_QPATH];
;608:		fileHandle_t	f;
;609:
;610:		// load the file
;611:		Com_sprintf(filename, sizeof(filename), "config/badnames.cfg");
;612:		length = trap_FS_FOpenFile( filename, &f, FS_READ );
;613:		if ( length <= 0 ) {
;614:			return;
;615:		}
;616:		if ( length >= sizeof( text ) - 1 ) {
;617:			G_Printf( "File too long\n" );
;618:			G_LogPrintf("BadNames.cfg is too long\n");
;619:			return;
;620:		}
;621:
;622:		if ( length < 3) {
;623:			return;
;624:		}
;625:
;626:		//memset(&text, 0, sizeof(text));
;627:		//memset(&text[0], 0, sizeof(text));
;628:		trap_FS_Read( text, length, f );
;629:		text[length] = 0;
;630:		trap_FS_FCloseFile( f );
;631:
;632:		// parse the text
;633:		text_p = text;
;634:		skip = 0;
;635:
;636:		// read optional parameters
;637:		while ( 1 ) {
;638:			prev = text_p;	// so we can unget
;639:			name = COM_Parse( &text_p );
;640:
;641:			//G_Printf("%s -- ", Name );
;642:
;643:			if ( !name || name == 0 ) {
;644:				//FIXME: This doesn't work
;645:				G_LogPrintf("*WORKING* BadNames: String is NULL\n");
;646:				break;
;647:			}
;648:
;649:			if ( strlen( name ) < 1 ) {
;650:				G_LogPrintf("*WARNING* BadNames: String length is less than 1\n");
;651:					break;
;652:			}
;653:			if ( strlen( name ) > MAX_NETNAME ) {
;654:				G_LogPrintf("*ERROR* BadNames: String length is too big\n");
;655:				break;
;656:			}
;657:
;658:		
;659:			if ( !Q_stricmp(p, name) ) {
;660:				Q_strncpyz( p, "UnnamedPlayer", outSize );
;661:				break;
;662:			}
;663:			//G_Printf("Loop -");
;664:		}
;665:} */
;666:
;667:/*
;668:===========
;669:ClientCheckName
;670:============
;671:*/
;672:static void ClientCleanName( const char *in, char *out, int outSize ) {
line 680
;673:	int		len, colorlessLen;
;674:	char	ch;
;675:	char	*p;
;676:	int		spaces;
;677:	//qboolean	parseBadNames = qtrue;
;678:
;679:	//save room for trailing null byte
;680:	outSize--;
ADDRFP4 8
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 682
;681:
;682:	len = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 683
;683:	colorlessLen = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 684
;684:	p = out;
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
line 685
;685:	*p = 0;
ADDRLP4 12
INDIRP4
CNSTI1 0
ASGNI1
line 686
;686:	spaces = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $241
JUMPV
LABELV $240
line 688
;687:
;688:	while( 1 ) {
line 689
;689:		ch = *in++;
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 20
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
INDIRI1
ASGNI1
line 690
;690:		if( !ch ) {
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $243
line 691
;691:			break;
ADDRGP4 $242
JUMPV
LABELV $243
line 695
;692:		}
;693:
;694:		// don't allow leading spaces
;695:		if( !*p && ch == ' ' ) {
ADDRLP4 12
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $245
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 32
NEI4 $245
line 696
;696:			continue;
ADDRGP4 $241
JUMPV
LABELV $245
line 700
;697:		}
;698:
;699:		// check colors
;700:		if( ch == Q_COLOR_ESCAPE ) {
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $247
line 702
;701:			// solo trailing carat is not a color prefix
;702:			if( !*in ) {
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $249
line 703
;703:				break;
ADDRGP4 $242
JUMPV
LABELV $249
line 713
;704:			}
;705:
;706:			// don't allow black in a name, period
;707:			//if( ColorIndex(*in) == 0 ) {
;708:			//	in++;
;709:			//	continue;
;710:			//}
;711:
;712:			// make sure room in dest for both chars
;713:			if( len > outSize - 2 ) {
ADDRLP4 4
INDIRI4
ADDRFP4 8
INDIRI4
CNSTI4 2
SUBI4
LEI4 $251
line 714
;714:				break;
ADDRGP4 $242
JUMPV
LABELV $251
line 717
;715:			}
;716:
;717:			*out++ = ch;
ADDRLP4 24
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 4
ADDRLP4 24
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 0
INDIRI1
ASGNI1
line 718
;718:			*out++ = *in++;
ADDRLP4 28
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 36
CNSTI4 1
ASGNI4
ADDRFP4 4
ADDRLP4 28
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ASGNP4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 32
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI1
ASGNI1
line 719
;719:			len += 2;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 720
;720:			continue;
ADDRGP4 $241
JUMPV
LABELV $247
line 724
;721:		}
;722:
;723:		// don't allow too many consecutive spaces
;724:		if( ch == ' ' ) {
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 32
NEI4 $253
line 725
;725:			spaces++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 726
;726:			if( spaces > 3 ) {
ADDRLP4 8
INDIRI4
CNSTI4 3
LEI4 $254
line 727
;727:				continue;
ADDRGP4 $241
JUMPV
line 729
;728:			}
;729:		}
LABELV $253
line 730
;730:		else {
line 731
;731:			spaces = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 732
;732:		}
LABELV $254
line 734
;733:
;734:		if( len > outSize - 1 ) {
ADDRLP4 4
INDIRI4
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
LEI4 $257
line 735
;735:			break;
ADDRGP4 $242
JUMPV
LABELV $257
line 738
;736:		}
;737:
;738:		*out++ = ch;
ADDRLP4 24
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 4
ADDRLP4 24
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 0
INDIRI1
ASGNI1
line 739
;739:		colorlessLen++;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 740
;740:		len++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 741
;741:	}
LABELV $241
line 688
ADDRGP4 $240
JUMPV
LABELV $242
line 742
;742:	*out = 0;
ADDRFP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 745
;743:
;744:	// don't allow empty names
;745:	if( *p == 0 || colorlessLen == 0 || !Q_stricmp(p,"all") || !Q_stricmp(p,"allbots") ) {
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRLP4 12
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 24
INDIRI4
EQI4 $265
ADDRLP4 16
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $265
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $261
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $265
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $262
ARGP4
ADDRLP4 32
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $259
LABELV $265
line 746
;746:		Q_strncpyz( p, "UnnamedPlayer", outSize );
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $266
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 748
;747:		//parseBadNames = qfalse;
;748:	}
LABELV $259
line 754
;749:/*
;750:	if ( parseBadNames && CG_FileExists("config/badnames.cfg") && !(trap_Cvar_VariableIntegerValue("disable_badnames")) ) {
;751:		//disallowed names.. This should be a seperate config that gets parsed.
;752:		ParseBadNames(p, outSize);
;753:	} */
;754:}
LABELV $239
endproc ClientCleanName 40 12
export ClientUserinfoChanged
proc ClientUserinfoChanged 5476 56
line 768
;755:
;756:
;757:/*
;758:===========
;759:ClientUserInfoChanged
;760:
;761:Called from ClientConnect when the player first connects and
;762:directly by the server system when the player updates a userinfo variable.
;763:
;764:The game can override any of the settings and call trap_SetUserinfo
;765:if desired.
;766:============
;767:*/
;768:void ClientUserinfoChanged( int clientNum ) {
line 783
;769:	gentity_t *ent;
;770:	int		teamTask, teamLeader, team, health;
;771:	char	*s;
;772:	char	model[MAX_QPATH];
;773:	char	headModel[MAX_QPATH];
;774:	char	oldname[MAX_STRING_CHARS];
;775:	gclient_t	*client;
;776:	char	c1[MAX_INFO_STRING];
;777://	char	c2[MAX_INFO_STRING];Evo:Model
;778:	char	redTeam[MAX_INFO_STRING];
;779:	char	blueTeam[MAX_INFO_STRING];
;780:	char	userinfo[MAX_INFO_STRING];
;781:	char	sex[32];
;782:
;783:	ent = g_entities + clientNum;
ADDRLP4 1032
CNSTI4 896
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 784
;784:	client = ent->client;
ADDRLP4 0
ADDRLP4 1032
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 786
;785:
;786:	trap_GetUserinfo( clientNum, userinfo, sizeof( userinfo ) );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 789
;787:
;788:	// check for malformed or illegal info strings
;789:	if ( !Info_Validate(userinfo) ) {
ADDRLP4 8
ARGP4
ADDRLP4 5308
ADDRGP4 Info_Validate
CALLI4
ASGNI4
ADDRLP4 5308
INDIRI4
CNSTI4 0
NEI4 $268
line 790
;790:		strcpy (userinfo, "\\name\\badinfo");
ADDRLP4 8
ARGP4
ADDRGP4 $270
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 791
;791:	}
LABELV $268
line 794
;792:
;793:	// check for local client
;794:	s = Info_ValueForKey( userinfo, "ip" );
ADDRLP4 8
ARGP4
ADDRGP4 $271
ARGP4
ADDRLP4 5312
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 5312
INDIRP4
ASGNP4
line 795
;795:	if ( !strcmp( s, "localhost" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $274
ARGP4
ADDRLP4 5316
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 5316
INDIRI4
CNSTI4 0
NEI4 $272
line 796
;796:		client->pers.localClient = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
CNSTI4 1
ASGNI4
line 797
;797:	}
LABELV $272
line 800
;798:
;799:	// check the item prediction
;800:	s = Info_ValueForKey( userinfo, "cg_predictItems" );
ADDRLP4 8
ARGP4
ADDRGP4 $275
ARGP4
ADDRLP4 5320
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 5320
INDIRP4
ASGNP4
line 801
;801:	if ( !atoi( s ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 5324
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 5324
INDIRI4
CNSTI4 0
NEI4 $276
line 802
;802:		client->pers.predictItemPickup = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 504
ADDP4
CNSTI4 0
ASGNI4
line 803
;803:	} else {
ADDRGP4 $277
JUMPV
LABELV $276
line 804
;804:		client->pers.predictItemPickup = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 504
ADDP4
CNSTI4 1
ASGNI4
line 805
;805:	}
LABELV $277
line 821
;806:
;807://unlagged - client options
;808:	// see if the player has opted out
;809:	//s = Info_ValueForKey( userinfo, "cg_delag" );
;810:	//if ( !atoi( s ) ) {
;811:	//	client->pers.delag = 0;
;812:	//} else {
;813:	//	client->pers.delag = atoi( s );
;814:	//}
;815:
;816:	// see if the player is nudging his shots
;817:	//s = Info_ValueForKey( userinfo, "cg_cmdTimeNudge" );
;818:	//client->pers.cmdTimeNudge = atoi( s );
;819:
;820:	// see if the player wants to debug the backward reconciliation
;821:	s = Info_ValueForKey( userinfo, "cg_debugDelag" );
ADDRLP4 8
ARGP4
ADDRGP4 $278
ARGP4
ADDRLP4 5328
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 5328
INDIRP4
ASGNP4
line 822
;822:	if ( !atoi( s ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 5332
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 5332
INDIRI4
CNSTI4 0
NEI4 $279
line 823
;823:		client->pers.debugDelag = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 10068
ADDP4
CNSTI4 0
ASGNI4
line 824
;824:	}
ADDRGP4 $280
JUMPV
LABELV $279
line 825
;825:	else {
line 826
;826:		client->pers.debugDelag = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 10068
ADDP4
CNSTI4 1
ASGNI4
line 827
;827:	}
LABELV $280
line 841
;828:
;829:	// see if the player is simulating incoming latency
;830:	//s = Info_ValueForKey( userinfo, "cg_latentSnaps" );
;831:	//client->pers.latentSnaps = atoi( s );
;832:
;833:	// see if the player is simulating outgoing latency
;834:	//s = Info_ValueForKey( userinfo, "cg_latentCmds" );
;835:	//client->pers.latentCmds = atoi( s );
;836:
;837:	// see if the player is simulating outgoing packet loss
;838:	//s = Info_ValueForKey( userinfo, "cg_plOut" );
;839:	//client->pers.plOut = atoi( s );
;840://unlagged - client options
;841:	s = Info_ValueForKey( userinfo, "cg_fixedTeleporterAngles" );
ADDRLP4 8
ARGP4
ADDRGP4 $281
ARGP4
ADDRLP4 5336
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 5336
INDIRP4
ASGNP4
line 842
;842:	if ( !atoi( s ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 5340
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 5340
INDIRI4
CNSTI4 0
NEI4 $282
line 843
;843:		client->pers.fixedTeleporterAngles = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 620
ADDP4
CNSTI4 0
ASGNI4
line 844
;844:	} else {
ADDRGP4 $283
JUMPV
LABELV $282
line 845
;845:		client->pers.fixedTeleporterAngles = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 620
ADDP4
CNSTI4 1
ASGNI4
line 846
;846:	}
LABELV $283
line 849
;847:
;848:	// set name
;849:	Q_strncpyz ( oldname, client->pers.netname, sizeof( oldname ) );
ADDRLP4 1164
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 850
;850:	s = Info_ValueForKey (userinfo, "name");
ADDRLP4 8
ARGP4
ADDRGP4 $284
ARGP4
ADDRLP4 5344
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 5344
INDIRP4
ASGNP4
line 851
;851:	ClientCleanName( s, client->pers.netname, sizeof(client->pers.netname) );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientCleanName
CALLV
pop
line 853
;852:
;853:	if ( !sv_allowUnnamed.integer ) { 
ADDRGP4 sv_allowUnnamed+12
INDIRI4
CNSTI4 0
NEI4 $285
line 854
;854:		if ( Q_stricmp(client->pers.netname, "UnnamedPlayer") == 0 ) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
ARGP4
ADDRGP4 $266
ARGP4
ADDRLP4 5348
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 5348
INDIRI4
CNSTI4 0
NEI4 $288
line 855
;855:			client->sess.speconly |= 2;
ADDRLP4 5352
ADDRLP4 0
INDIRP4
CNSTI4 10220
ADDP4
ASGNP4
ADDRLP4 5352
INDIRP4
ADDRLP4 5352
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 856
;856:		} else if ( client->sess.speconly & 2 ) {
ADDRGP4 $289
JUMPV
LABELV $288
ADDRLP4 0
INDIRP4
CNSTI4 10220
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $290
line 857
;857:			client->sess.speconly &= ~2;
ADDRLP4 5352
ADDRLP4 0
INDIRP4
CNSTI4 10220
ADDP4
ASGNP4
ADDRLP4 5352
INDIRP4
ADDRLP4 5352
INDIRP4
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 858
;858:		}
LABELV $290
LABELV $289
line 859
;859:	}
LABELV $285
line 861
;860:
;861:	Q_strncpyz( sex, Info_ValueForKey (userinfo, "sex"), sizeof( sex ) );
ADDRLP4 8
ARGP4
ADDRGP4 $292
ARGP4
ADDRLP4 5348
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 2188
ARGP4
ADDRLP4 5348
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 864
;862:	//ClientCleanName( s, client->pers.netname, sizeof(client->pers.netname) );
;863:
;864:	if ( client->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRLP4 0
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
CNSTI4 3
NEI4 $293
line 865
;865:		if ( client->sess.spectatorState == SPECTATOR_SCOREBOARD ) {
ADDRLP4 0
INDIRP4
CNSTI4 10196
ADDP4
INDIRI4
CNSTI4 3
NEI4 $295
line 866
;866:			Q_strncpyz( client->pers.netname, "scoreboard", sizeof(client->pers.netname) );
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
ARGP4
ADDRGP4 $297
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 867
;867:		}
LABELV $295
line 868
;868:	}
LABELV $293
line 870
;869:
;870:	if ( client->pers.connected == CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $298
line 871
;871:		if ( strcmp( oldname, client->pers.netname ) ) {
ADDRLP4 1164
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
ARGP4
ADDRLP4 5352
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 5352
INDIRI4
CNSTI4 0
EQI4 $300
line 872
;872:			trap_SendServerCommand( -1, va("print \"%s" S_COLOR_WHITE " renamed to %s\n\"", oldname, 
ADDRGP4 $302
ARGP4
ADDRLP4 1164
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
ARGP4
ADDRLP4 5356
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 5356
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 874
;873:				client->pers.netname) );
;874:		}
LABELV $300
line 875
;875:	}
LABELV $298
line 889
;876:
;877:	// set max health
;878:#ifdef MISSIONPACK
;879:	if (client->ps.powerups[PW_GUARD]) {
;880:		client->pers.maxHealth = 200;
;881:	} else {
;882:		health = atoi( Info_ValueForKey( userinfo, "handicap" ) );
;883:		client->pers.maxHealth = health;
;884:		if ( client->pers.maxHealth < 1 || client->pers.maxHealth > 100 ) {
;885:			client->pers.maxHealth = 100;
;886:		}
;887:	}
;888:#else
;889:	health = atoi( Info_ValueForKey( userinfo, "handicap" ) );
ADDRLP4 8
ARGP4
ADDRGP4 $303
ARGP4
ADDRLP4 5352
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 5352
INDIRP4
ARGP4
ADDRLP4 5356
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 2228
ADDRLP4 5356
INDIRI4
ASGNI4
line 890
;890:	client->pers.maxHealth = health;
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
ADDRLP4 2228
INDIRI4
ASGNI4
line 891
;891:	if ( gameSettings.spawn_health > 0 && gameSettings.spawn_health != 100 ) {
ADDRGP4 gameSettings+16
INDIRI4
CNSTI4 0
LEI4 $304
ADDRGP4 gameSettings+16
INDIRI4
CNSTI4 100
EQI4 $304
line 892
;892:		client->pers.maxHealth = gameSettings.spawn_health;
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
ADDRGP4 gameSettings+16
INDIRI4
ASGNI4
line 893
;893:	} else
ADDRGP4 $305
JUMPV
LABELV $304
line 894
;894:	if ( client->pers.maxHealth < 1 || client->pers.maxHealth > 100 || g_pro_mode.integer || !g_allowHandicap.integer) {
ADDRLP4 5360
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
INDIRI4
ASGNI4
ADDRLP4 5360
INDIRI4
CNSTI4 1
LTI4 $315
ADDRLP4 5360
INDIRI4
CNSTI4 100
GTI4 $315
ADDRLP4 5364
CNSTI4 0
ASGNI4
ADDRGP4 g_pro_mode+12
INDIRI4
ADDRLP4 5364
INDIRI4
NEI4 $315
ADDRGP4 g_allowHandicap+12
INDIRI4
ADDRLP4 5364
INDIRI4
NEI4 $309
LABELV $315
line 895
;895:			(client->pers.maxHealth = 100);
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
CNSTI4 100
ASGNI4
line 896
;896:	}
LABELV $309
LABELV $305
line 898
;897:#endif
;898:	client->ps.stats[STAT_MAX_HEALTH] = client->pers.maxHealth;
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
INDIRI4
ASGNI4
line 901
;899:
;900:	// set model
;901:	if( g_gametype.integer >= GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $316
line 902
;902:		Q_strncpyz( model, Info_ValueForKey (userinfo, "team_model"), sizeof( model ) );
ADDRLP4 8
ARGP4
ADDRGP4 $319
ARGP4
ADDRLP4 5372
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1036
ARGP4
ADDRLP4 5372
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 903
;903:		Q_strncpyz( headModel, Info_ValueForKey (userinfo, "team_headmodel"), sizeof( headModel ) );
ADDRLP4 8
ARGP4
ADDRGP4 $320
ARGP4
ADDRLP4 5376
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1100
ARGP4
ADDRLP4 5376
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 904
;904:	} else {
ADDRGP4 $317
JUMPV
LABELV $316
line 905
;905:		Q_strncpyz( model, Info_ValueForKey (userinfo, "model"), sizeof( model ) );
ADDRLP4 8
ARGP4
ADDRGP4 $321
ARGP4
ADDRLP4 5372
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1036
ARGP4
ADDRLP4 5372
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 906
;906:		Q_strncpyz( headModel, Info_ValueForKey (userinfo, "headmodel"), sizeof( headModel ) );
ADDRLP4 8
ARGP4
ADDRGP4 $322
ARGP4
ADDRLP4 5376
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1100
ARGP4
ADDRLP4 5376
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 907
;907:	}
LABELV $317
line 910
;908:
;909:	// bots set their team a few frames later
;910:	if (g_gametype.integer >= GT_TEAM && g_entities[clientNum].r.svFlags & SVF_BOT) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $323
CNSTI4 896
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $323
line 911
;911:		s = Info_ValueForKey( userinfo, "team" );
ADDRLP4 8
ARGP4
ADDRGP4 $328
ARGP4
ADDRLP4 5372
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 5372
INDIRP4
ASGNP4
line 912
;912:		if ( !Q_stricmp( s, "red" ) || !Q_stricmp( s, "r" ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $331
ARGP4
ADDRLP4 5376
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 5376
INDIRI4
CNSTI4 0
EQI4 $333
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $332
ARGP4
ADDRLP4 5380
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 5380
INDIRI4
CNSTI4 0
NEI4 $329
LABELV $333
line 913
;913:			team = TEAM_RED;
ADDRLP4 3256
CNSTI4 1
ASGNI4
line 914
;914:		} else if ( !Q_stricmp( s, "blue" ) || !Q_stricmp( s, "b" ) ) {
ADDRGP4 $324
JUMPV
LABELV $329
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $336
ARGP4
ADDRLP4 5384
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 5384
INDIRI4
CNSTI4 0
EQI4 $338
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $337
ARGP4
ADDRLP4 5388
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 5388
INDIRI4
CNSTI4 0
NEI4 $334
LABELV $338
line 915
;915:			team = TEAM_BLUE;
ADDRLP4 3256
CNSTI4 2
ASGNI4
line 916
;916:		} else {
ADDRGP4 $324
JUMPV
LABELV $334
line 918
;917:			// pick the team with the least number of players
;918:			team = PickTeam( clientNum );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 5392
ADDRGP4 PickTeam
CALLI4
ASGNI4
ADDRLP4 3256
ADDRLP4 5392
INDIRI4
ASGNI4
line 919
;919:		}
line 920
;920:	}
ADDRGP4 $324
JUMPV
LABELV $323
line 921
;921:	else {
line 922
;922:		team = client->sess.sessionTeam;
ADDRLP4 3256
ADDRLP4 0
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
ASGNI4
line 923
;923:	}
LABELV $324
line 959
;924:
;925:/*	NOTE: all client side now
;926:
;927:	// team
;928:	switch( team ) {
;929:	case TEAM_RED:
;930:		ForceClientSkin(client, model, "red");
;931://		ForceClientSkin(client, headModel, "red");
;932:		break;
;933:	case TEAM_BLUE:
;934:		ForceClientSkin(client, model, "blue");
;935://		ForceClientSkin(client, headModel, "blue");
;936:		break;
;937:	}
;938:	// don't ever use a default skin in teamplay, it would just waste memory
;939:	// however bots will always join a team but they spawn in as spectator
;940:	if ( g_gametype.integer >= GT_TEAM && team == TEAM_SPECTATOR) {
;941:		ForceClientSkin(client, model, "red");
;942://		ForceClientSkin(client, headModel, "red");
;943:	}
;944:*/
;945:
;946:#ifdef MISSIONPACK
;947:	if (g_gametype.integer >= GT_TEAM) {
;948:		client->pers.teamInfo = qtrue;
;949:	} else {
;950:		s = Info_ValueForKey( userinfo, "cg_drawTeamOverlay" );
;951:		if ( ! *s || atoi( s ) != 0 ) {
;952:			client->pers.teamInfo = qtrue;
;953:		} else {
;954:			client->pers.teamInfo = qfalse;
;955:		}
;956:	}
;957:#else
;958:	// teamInfo
;959:	s = Info_ValueForKey( userinfo, "cg_drawTeamOverlay" );
ADDRLP4 8
ARGP4
ADDRGP4 $339
ARGP4
ADDRLP4 5372
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 5372
INDIRP4
ASGNP4
line 960
;960:	if ( ! *s || atoi( s ) != 0 ) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $342
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 5380
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 5380
INDIRI4
CNSTI4 0
EQI4 $340
LABELV $342
line 961
;961:		client->pers.teamInfo = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 616
ADDP4
CNSTI4 1
ASGNI4
line 962
;962:	} else {
ADDRGP4 $341
JUMPV
LABELV $340
line 963
;963:		client->pers.teamInfo = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 616
ADDP4
CNSTI4 0
ASGNI4
line 964
;964:	}
LABELV $341
line 967
;965:#endif
;966:	
;967:	s = Info_ValueForKey( userinfo, "cg_pmove_fixed" );
ADDRLP4 8
ARGP4
ADDRGP4 $343
ARGP4
ADDRLP4 5384
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 5384
INDIRP4
ASGNP4
line 968
;968:	if ( !*s || atoi( s ) == 0 ) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $346
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 5392
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 5392
INDIRI4
CNSTI4 0
NEI4 $344
LABELV $346
line 969
;969:		client->pers.pmoveFixed = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 508
ADDP4
CNSTI4 0
ASGNI4
line 970
;970:	} else {
ADDRGP4 $345
JUMPV
LABELV $344
line 971
;971:		client->pers.pmoveFixed = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 508
ADDP4
CNSTI4 1
ASGNI4
line 972
;972:	}
LABELV $345
line 974
;973:
;974:	s = Info_ValueForKey( userinfo, "cg_fastRespawn_override" );
ADDRLP4 8
ARGP4
ADDRGP4 $347
ARGP4
ADDRLP4 5396
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 5396
INDIRP4
ASGNP4
line 975
;975:	if ( !*s || atoi( s ) == 0 ) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $350
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 5404
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 5404
INDIRI4
CNSTI4 0
NEI4 $348
LABELV $350
line 976
;976:		client->pers.fastRespawn = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
CNSTI4 0
ASGNI4
line 977
;977:	} else {
ADDRGP4 $349
JUMPV
LABELV $348
line 978
;978:		client->pers.fastRespawn = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
CNSTI4 1
ASGNI4
line 979
;979:	}
LABELV $349
line 983
;980:	
;981:
;982:	// team task (0 = none, 1 = offence, 2 = defence)
;983:	teamTask = atoi(Info_ValueForKey(userinfo, "teamtask"));
ADDRLP4 8
ARGP4
ADDRGP4 $351
ARGP4
ADDRLP4 5408
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 5408
INDIRP4
ARGP4
ADDRLP4 5412
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 2220
ADDRLP4 5412
INDIRI4
ASGNI4
line 985
;984:	// team Leader (1 = leader, 0 is normal player)
;985:	teamLeader = client->sess.teamLeader;
ADDRLP4 2224
ADDRLP4 0
INDIRP4
CNSTI4 10212
ADDP4
INDIRI4
ASGNI4
line 987
;986:
;987:	s = Info_ValueForKey (userinfo, "cl_maxpackets"); //FIXME: atoi once?
ADDRLP4 8
ARGP4
ADDRGP4 $352
ARGP4
ADDRLP4 5416
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 5416
INDIRP4
ASGNP4
line 988
;988:	ent->client->pers.ping_fix_adjustment = atoi(s)>=80?(15):(0.3 * atoi(s) - 9);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 5424
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 5424
INDIRI4
CNSTI4 80
LTI4 $354
ADDRLP4 5420
CNSTF4 1097859072
ASGNF4
ADDRGP4 $355
JUMPV
LABELV $354
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 5428
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 5420
CNSTF4 1050253722
ADDRLP4 5428
INDIRI4
CVIF4 4
MULF4
CNSTF4 1091567616
SUBF4
ASGNF4
LABELV $355
ADDRLP4 1032
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10144
ADDP4
ADDRLP4 5420
INDIRF4
CVFI4 4
ASGNI4
line 991
;989:
;990:	// see if the player is nudging his shots
;991:	s = Info_ValueForKey( userinfo, "cg_aimNudge" );
ADDRLP4 8
ARGP4
ADDRGP4 $356
ARGP4
ADDRLP4 5432
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 5432
INDIRP4
ASGNP4
line 992
;992:	client->pers.cmdTimeNudge = atoi( s );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 5436
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 10072
ADDP4
ADDRLP4 5436
INDIRI4
ASGNI4
line 993
;993:	client->sess.aimType = atoi(Info_ValueForKey( userinfo, "cg_aimType" ));
ADDRLP4 8
ARGP4
ADDRGP4 $357
ARGP4
ADDRLP4 5440
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 5440
INDIRP4
ARGP4
ADDRLP4 5444
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 10224
ADDP4
ADDRLP4 5444
INDIRI4
ASGNI4
line 994
;994:	if (client->sess.aimType > g_delagHitscan.integer) {
ADDRLP4 0
INDIRP4
CNSTI4 10224
ADDP4
INDIRI4
ADDRGP4 g_delagHitscan+12
INDIRI4
LEI4 $358
line 995
;995:		client->sess.aimType = g_delagHitscan.integer;
ADDRLP4 0
INDIRP4
CNSTI4 10224
ADDP4
ADDRGP4 g_delagHitscan+12
INDIRI4
ASGNI4
line 996
;996:	} else
ADDRGP4 $359
JUMPV
LABELV $358
line 997
;997:	if (client->sess.aimType < 0  || client->sess.aimType > 3 ) {
ADDRLP4 5448
ADDRLP4 0
INDIRP4
CNSTI4 10224
ADDP4
INDIRI4
ASGNI4
ADDRLP4 5448
INDIRI4
CNSTI4 0
LTI4 $364
ADDRLP4 5448
INDIRI4
CNSTI4 3
LEI4 $362
LABELV $364
line 998
;998:		if ( ent->r.svFlags & SVF_BOT ) {
ADDRLP4 1032
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $365
line 999
;999:			client->sess.aimType = 0;
ADDRLP4 0
INDIRP4
CNSTI4 10224
ADDP4
CNSTI4 0
ASGNI4
line 1000
;1000:		} else {
ADDRGP4 $366
JUMPV
LABELV $365
line 1001
;1001:			client->sess.aimType = 2;
ADDRLP4 0
INDIRP4
CNSTI4 10224
ADDP4
CNSTI4 2
ASGNI4
line 1002
;1002:		}
LABELV $366
line 1003
;1003:	}
LABELV $362
LABELV $359
line 1009
;1004:	//Evo:Model:colors
;1005:	/*if ( ent->r.svFlags & SVF_BOT ) {
;1006:		strcpy(c1, Info_ValueForKey( userinfo, "color1" ));
;1007:		strcpy(c2, Info_ValueForKey( userinfo, "color2" ));
;1008:	} else {*/
;1009:		strcpy(c1, Info_ValueForKey( userinfo, "colors" ));
ADDRLP4 8
ARGP4
ADDRGP4 $367
ARGP4
ADDRLP4 5452
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 2232
ARGP4
ADDRLP4 5452
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1013
;1010:	//}
;1011:	
;1012:
;1013:	strcpy(redTeam, Info_ValueForKey( userinfo, "g_redteam" ));
ADDRLP4 8
ARGP4
ADDRGP4 $368
ARGP4
ADDRLP4 5456
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 3260
ARGP4
ADDRLP4 5456
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1014
;1014:	strcpy(blueTeam, Info_ValueForKey( userinfo, "g_blueteam" ));
ADDRLP4 8
ARGP4
ADDRGP4 $369
ARGP4
ADDRLP4 5460
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4284
ARGP4
ADDRLP4 5460
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1018
;1015:
;1016:	// send over a subset of the userinfo keys so other clients can
;1017:	// print scoreboards, display models, and play custom sounds
;1018:	if ( ent->r.svFlags & SVF_BOT ) {
ADDRLP4 1032
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $370
line 1019
;1019:		s = va("n\\%s\\t\\%i\\model\\%s\\hmodel\\%s\\c1\\%s\\hc\\%i\\w\\%i\\l\\%i\\skill\\%s\\tt\\%d\\tl\\%d",
ADDRLP4 8
ARGP4
ADDRGP4 $373
ARGP4
ADDRLP4 5464
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $372
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
ARGP4
ADDRLP4 3256
INDIRI4
ARGI4
ADDRLP4 1036
ARGP4
ADDRLP4 1100
ARGP4
ADDRLP4 2232
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 10204
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 10208
ADDP4
INDIRI4
ARGI4
ADDRLP4 5464
INDIRP4
ARGP4
ADDRLP4 2220
INDIRI4
ARGI4
ADDRLP4 2224
INDIRI4
ARGI4
ADDRLP4 5472
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 5472
INDIRP4
ASGNP4
line 1023
;1020:			client->pers.netname, team, model, headModel, c1,
;1021:			client->pers.maxHealth, client->sess.wins, client->sess.losses,
;1022:			Info_ValueForKey( userinfo, "skill" ), teamTask, teamLeader );
;1023:	} else {
ADDRGP4 $371
JUMPV
LABELV $370
line 1024
;1024:		s = va("n\\%s\\t\\%i\\model\\%s\\hmodel\\%s\\g_redteam\\%s\\g_blueteam\\%s\\c1\\%s\\hc\\%i\\w\\%i\\l\\%i\\tt\\%d\\tl\\%d\\sex\\%s",
ADDRGP4 $374
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
ARGI4
ADDRLP4 1036
ARGP4
ADDRLP4 1100
ARGP4
ADDRLP4 3260
ARGP4
ADDRLP4 4284
ARGP4
ADDRLP4 2232
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 10204
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 10208
ADDP4
INDIRI4
ARGI4
ADDRLP4 2220
INDIRI4
ARGI4
ADDRLP4 2224
INDIRI4
ARGI4
ADDRLP4 2188
ARGP4
ADDRLP4 5468
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 5468
INDIRP4
ASGNP4
line 1027
;1025:			client->pers.netname, client->sess.sessionTeam, model, headModel, redTeam, blueTeam, c1, 
;1026:			client->pers.maxHealth, client->sess.wins, client->sess.losses, teamTask, teamLeader, sex);
;1027:	}
LABELV $371
line 1029
;1028:
;1029:	trap_SetConfigstring( CS_PLAYERS+clientNum, s );
ADDRFP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1032
;1030:
;1031:	// this is not the userinfo, more like the configstring actually
;1032:	G_LogPrintf( "ClientUserinfoChanged: %i %s\n", clientNum, s );
ADDRGP4 $375
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1033
;1033:}
LABELV $267
endproc ClientUserinfoChanged 5476 56
export CheckBans
proc CheckBans 24 4
line 1056
;1034:
;1035:
;1036:/*
;1037:===========
;1038:ClientConnect
;1039:
;1040:Called when a player begins connecting to the server.
;1041:Called again for every map change or tournement restart.
;1042:
;1043:The session information will be valid after exit.
;1044:
;1045:Return NULL if the client should be allowed, otherwise return
;1046:a string with the reason for denial.
;1047:
;1048:Otherwise, the client will be sent the current gamestate
;1049:and will eventually get to ClientBegin.
;1050:
;1051:firstTime will be qtrue the very first time a client connects
;1052:to the server machine, but qfalse on map changes and tournement
;1053:restarts.
;1054:============
;1055:*/
;1056:int CheckBans( char *ip ) {
line 1057
;1057:	int i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1058
;1058:	int j = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1060
;1059:
;1060:	for (i = 0; i < NUM_BANS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $377
line 1061
;1061:		if ( strlen(bans[i].ip) > 2) {
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bans
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 2
LEI4 $381
line 1062
;1062:			for ( j = 0; j <= strlen(bans[i].ip); j++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $386
JUMPV
LABELV $383
line 1064
;1063:				//G_Printf("%i - %i -- %s - %s\n", strlen(bans[i].ip), j, ip[j], bans[i].ip[j] );
;1064:				if ( bans[i].ip[j] == '*' ) {
ADDRLP4 4
INDIRI4
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bans
ADDP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $387
line 1066
;1065:					//G_Printf("foundSubNet\n");
;1066:					if ( bans[i].time > 0 ) {
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bans+16
ADDP4
INDIRI4
CNSTI4 0
LEI4 $389
line 1067
;1067:						if ( bans[i].time - getTimeDiff() <= 0 ) {
ADDRLP4 12
ADDRGP4 getTimeDiff
CALLI4
ASGNI4
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bans+16
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
SUBI4
CNSTI4 0
GTI4 $392
line 1068
;1068:							break;
ADDRGP4 $385
JUMPV
LABELV $392
line 1070
;1069:						}
;1070:					}
LABELV $389
line 1071
;1071:					return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $376
JUMPV
LABELV $387
line 1072
;1072:				} else if ( ip[j] == bans[i].ip[j]) {
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ADDRLP4 4
INDIRI4
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bans
ADDP4
ADDP4
INDIRI1
CVII4 1
NEI4 $395
line 1073
;1073:					if ( j == strlen(bans[i].ip)-1 ) {
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bans
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 16
INDIRI4
CNSTI4 1
SUBI4
NEI4 $396
line 1075
;1074:						//G_Printf("Ban matched and no subnet added\n");
;1075:						if ( bans[i].time > 0 ) {
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bans+16
ADDP4
INDIRI4
CNSTI4 0
LEI4 $399
line 1076
;1076:							if ( bans[i].time - getTimeDiff() <= 0 ) {
ADDRLP4 20
ADDRGP4 getTimeDiff
CALLI4
ASGNI4
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bans+16
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
CNSTI4 0
GTI4 $402
line 1077
;1077:								break;
ADDRGP4 $385
JUMPV
LABELV $402
line 1079
;1078:							}
;1079:						}
LABELV $399
line 1080
;1080:						return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $376
JUMPV
line 1082
;1081:					}
;1082:				} else if (ip[j] != bans[i].ip[j]) {
LABELV $395
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ADDRLP4 4
INDIRI4
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bans
ADDP4
ADDP4
INDIRI1
CVII4 1
EQI4 $405
line 1083
;1083:					break;
ADDRGP4 $385
JUMPV
LABELV $405
LABELV $396
line 1085
;1084:				}
;1085:			}
LABELV $384
line 1062
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $386
CNSTI4 152
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bans
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 12
INDIRI4
LEI4 $383
LABELV $385
line 1086
;1086:		}
LABELV $381
line 1087
;1087:	}
LABELV $378
line 1060
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $377
line 1088
;1088:	return -1;
CNSTI4 -1
RETI4
LABELV $376
endproc CheckBans 24 4
bss
align 1
LABELV $414
skip 1024
export ClientConnect
code
proc ClientConnect 1228 56
line 1091
;1089:}
;1090:
;1091:char *ClientConnect( int clientNum, qboolean firstTime, qboolean isBot ) {
line 1098
;1092:	char		*value;
;1093://	char		*areabits;
;1094:	gclient_t	*client;
;1095:	char		userinfo[MAX_INFO_STRING];
;1096:	gentity_t	*ent;
;1097:	char		ip[128];
;1098:	int			ban = -1;
ADDRLP4 12
CNSTI4 -1
ASGNI4
line 1100
;1099:
;1100:	ent = &g_entities[ clientNum ];
ADDRLP4 4
CNSTI4 896
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1104
;1101:
;1102:	//Set bots to ready and normal clients to notready
;1103:	
;1104:	if (isBot) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $408
line 1105
;1105:		level.clients[ent-g_entities].playerReady = qtrue;
CNSTI4 10828
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 896
DIVI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 10236
ADDP4
CNSTI4 1
ASGNI4
line 1106
;1106:		level.totalReady++;
ADDRLP4 1168
ADDRGP4 level+32
ASGNP4
ADDRLP4 1168
INDIRP4
ADDRLP4 1168
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1107
;1107:	} else {
ADDRGP4 $409
JUMPV
LABELV $408
line 1108
;1108:		level.clients[ent-g_entities].playerReady = qfalse;
CNSTI4 10828
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 896
DIVI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 10236
ADDP4
CNSTI4 0
ASGNI4
line 1109
;1109:	}
LABELV $409
line 1110
;1110:	trap_GetUserinfo( clientNum, userinfo, sizeof( userinfo ) );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 1116
;1111:
;1112: 	// IP filtering
;1113: 	// https://zerowing.idsoftware.com/bugzilla/show_bug.cgi?id=500
;1114: 	// recommanding PB based IP / GUID banning, the builtin system is pretty limited
;1115: 	// check to see if they are on the banned IP list
;1116:	value = Info_ValueForKey (userinfo, "ip");
ADDRLP4 16
ARGP4
ADDRGP4 $271
ARGP4
ADDRLP4 1168
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 1168
INDIRP4
ASGNP4
line 1118
;1117:	//ip = Info_ValueForKey (userinfo, "ip");
;1118:	Com_sprintf(ip, 128, value);
ADDRLP4 1040
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1123
;1119:	/*if ( G_FilterPacket( value ) ) {
;1120:		return "You are banned from this server.";
;1121:	}*/
;1122:
;1123:	ban = CheckBans(ip);
ADDRLP4 1040
ARGP4
ADDRLP4 1172
ADDRGP4 CheckBans
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 1172
INDIRI4
ASGNI4
line 1124
;1124:	if ( ban >= 0 && bans[ban].type & 1) {
ADDRLP4 1180
CNSTI4 0
ASGNI4
ADDRLP4 12
INDIRI4
ADDRLP4 1180
INDIRI4
LTI4 $411
CNSTI4 152
ADDRLP4 12
INDIRI4
MULI4
ADDRGP4 bans+20
ADDP4
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 1180
INDIRI4
EQI4 $411
line 1128
;1125:		static char banMessage[1024];
;1126:		//char *msg;
;1127:
;1128:		Com_sprintf(banMessage, sizeof(banMessage), "You have been banned:\n%s", bans[ban].message);
ADDRGP4 $414
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $415
ARGP4
CNSTI4 152
ADDRLP4 12
INDIRI4
MULI4
ADDRGP4 bans+24
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1133
;1129:		//return sv_banMsg.string;
;1130:		/*trap_DropClient(clientNum, banMessage);
;1131:		return NULL;*/
;1132:		//msg = banMessage;
;1133:		return banMessage;
ADDRGP4 $414
RETP4
ADDRGP4 $407
JUMPV
LABELV $411
line 1140
;1134:	}
;1135:
;1136:  // we don't check password for bots and local client
;1137:  // NOTE: local client <-> "ip" "localhost"
;1138:  //   this means this client is not running in our current process
;1139:	//if ( (!( ent->r.svFlags & SVF_BOT ) || !isBot) && (strcmp(value, "localhost") != 0)) {
;1140:	if ( !isBot && (strcmp(value, "localhost") != 0) ) {
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $417
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $274
ARGP4
ADDRLP4 1184
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1184
INDIRI4
CNSTI4 0
EQI4 $417
line 1142
;1141:		// check for a password
;1142:		value = Info_ValueForKey (userinfo, "password");
ADDRLP4 16
ARGP4
ADDRGP4 $419
ARGP4
ADDRLP4 1188
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 1188
INDIRP4
ASGNP4
line 1143
;1143:		if ( g_password.string[0] && Q_stricmp( g_password.string, "none" ) &&
ADDRGP4 g_password+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $420
ADDRGP4 g_password+16
ARGP4
ADDRGP4 $424
ARGP4
ADDRLP4 1192
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1192
INDIRI4
CNSTI4 0
EQI4 $420
ADDRGP4 g_password+16
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1196
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1196
INDIRI4
CNSTI4 0
EQI4 $420
line 1144
;1144:			strcmp( g_password.string, value) != 0) {
line 1145
;1145:			return "Invalid password";
ADDRGP4 $426
RETP4
ADDRGP4 $407
JUMPV
LABELV $420
line 1147
;1146:		}
;1147:	}
LABELV $417
line 1150
;1148:
;1149:	// they can connect
;1150:	ent->client = level.clients + clientNum;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
CNSTI4 10828
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 1151
;1151:	client = ent->client;
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 1153
;1152:
;1153:	if ( ban >= 0 && bans[ban].type & 2 ) {
ADDRLP4 1192
CNSTI4 0
ASGNI4
ADDRLP4 12
INDIRI4
ADDRLP4 1192
INDIRI4
LTI4 $427
CNSTI4 152
ADDRLP4 12
INDIRI4
MULI4
ADDRGP4 bans+20
ADDP4
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 1192
INDIRI4
EQI4 $427
line 1154
;1154:		client->sess.speconly |= 2;
ADDRLP4 1196
ADDRLP4 0
INDIRP4
CNSTI4 10220
ADDP4
ASGNP4
ADDRLP4 1196
INDIRP4
ADDRLP4 1196
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 1155
;1155:	}
LABELV $427
line 1157
;1156:
;1157:	if ( !isBot ) {
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $430
line 1158
;1158:		value = Info_ValueForKey (userinfo, "cl_maxpackets"); //FIXME: atoi once?
ADDRLP4 16
ARGP4
ADDRGP4 $352
ARGP4
ADDRLP4 1196
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 1196
INDIRP4
ASGNP4
line 1159
;1159:		ent->client->pers.ping_fix_adjustment = atoi(value)>=80?(15):(0.3 * atoi(value) - 9);
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1204
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1204
INDIRI4
CNSTI4 80
LTI4 $433
ADDRLP4 1200
CNSTF4 1097859072
ASGNF4
ADDRGP4 $434
JUMPV
LABELV $433
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1208
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1200
CNSTF4 1050253722
ADDRLP4 1208
INDIRI4
CVIF4 4
MULF4
CNSTF4 1091567616
SUBF4
ASGNF4
LABELV $434
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10144
ADDP4
ADDRLP4 1200
INDIRF4
CVFI4 4
ASGNI4
line 1160
;1160:	}
LABELV $430
line 1162
;1161:
;1162:	ent->client->naft[0] = ent->client->naft[1] = 0;
ADDRLP4 1196
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1200
CNSTI4 0
ASGNI4
ADDRLP4 1196
INDIRP4
CNSTI4 10248
ADDP4
ADDRLP4 1200
INDIRI4
ASGNI4
ADDRLP4 1196
INDIRP4
CNSTI4 10244
ADDP4
ADDRLP4 1200
INDIRI4
ASGNI4
line 1166
;1163:
;1164://	areabits = client->areabits;
;1165:
;1166:	memset( client, 0, sizeof(*client) );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 10828
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1168
;1167:
;1168:	client->pers.connected = CON_CONNECTING;
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
CNSTI4 1
ASGNI4
line 1171
;1169:
;1170:	// read or initialize the session data
;1171:	if ( isBot || firstTime || (level.newSession && !( (g_gametype.integer == GT_CTF || g_gametype.integer == GT_TEAM) && (level.gt == GT_CTF || level.gt == GT_TEAM) ) )) {
ADDRLP4 1204
CNSTI4 0
ASGNI4
ADDRFP4 8
INDIRI4
ADDRLP4 1204
INDIRI4
NEI4 $444
ADDRFP4 4
INDIRI4
ADDRLP4 1204
INDIRI4
NEI4 $444
ADDRGP4 level+108
INDIRI4
ADDRLP4 1204
INDIRI4
EQI4 $435
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
EQI4 $445
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
NEI4 $444
LABELV $445
ADDRGP4 level+112
INDIRU1
CVUI4 1
CNSTI4 4
EQI4 $435
ADDRGP4 level+112
INDIRU1
CVUI4 1
CNSTI4 3
EQI4 $435
LABELV $444
line 1172
;1172:		G_InitSessionData( client, userinfo );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRGP4 G_InitSessionData
CALLV
pop
line 1173
;1173:	} //else {
LABELV $435
line 1181
;1174:		//client->sess.losses = 0;
;1175:		//client->sess.wins = 0;
;1176:		//client->sess.teamLeader = qfalse;
;1177:		//client->sess.spectatorClient = 0;//-1?
;1178:		//client->sess.spectatorState = SPECTATOR_FREE;//SPECTATOR_NOT?
;1179:		//client->sess.spectatorTime = 0;
;1180:	//}
;1181:	G_ReadSessionData( client );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_ReadSessionData
CALLV
pop
line 1183
;1182://freeze
;1183:	if ( g_gamemode.integer > 3 ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $446
line 1184
;1184:		if ( g_gametype.integer != GT_TOURNAMENT ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
EQI4 $449
line 1185
;1185:			client->sess.wins = 0;
ADDRLP4 0
INDIRP4
CNSTI4 10204
ADDP4
CNSTI4 0
ASGNI4
line 1186
;1186:		}
LABELV $449
line 1187
;1187:		ent->freezeState = qfalse;
ADDRLP4 4
INDIRP4
CNSTI4 888
ADDP4
CNSTI4 0
ASGNI4
line 1188
;1188:		ent->readyBegin = qfalse;
ADDRLP4 4
INDIRP4
CNSTI4 892
ADDP4
CNSTI4 0
ASGNI4
line 1189
;1189:	}
LABELV $446
line 1192
;1190://freeze
;1191:
;1192:	if( isBot ) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $452
line 1193
;1193:		ent->r.svFlags |= SVF_BOT;
ADDRLP4 1208
ADDRLP4 4
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 1208
INDIRP4
ADDRLP4 1208
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 1194
;1194:		ent->inuse = qtrue;
ADDRLP4 4
INDIRP4
CNSTI4 520
ADDP4
CNSTI4 1
ASGNI4
line 1195
;1195:		if( !G_BotConnect( clientNum, !firstTime ) ) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $457
ADDRLP4 1212
CNSTI4 1
ASGNI4
ADDRGP4 $458
JUMPV
LABELV $457
ADDRLP4 1212
CNSTI4 0
ASGNI4
LABELV $458
ADDRLP4 1212
INDIRI4
ARGI4
ADDRLP4 1216
ADDRGP4 G_BotConnect
CALLI4
ASGNI4
ADDRLP4 1216
INDIRI4
CNSTI4 0
NEI4 $454
line 1196
;1196:			return "BotConnectfailed";
ADDRGP4 $459
RETP4
ADDRGP4 $407
JUMPV
LABELV $454
line 1198
;1197:		}
;1198:	}
LABELV $452
line 1201
;1199:
;1200:	// get and distribute relevent paramters
;1201:	if (!isBot) {
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $460
line 1202
;1202:		sscanf(ip, "%d.%d.%d.%d", &client->pers.ip[0], &client->pers.ip[1], &client->pers.ip[2], &client->pers.ip[3]);
ADDRLP4 1040
ARGP4
ADDRGP4 $462
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 10152
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 10153
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 10154
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 10155
ADDP4
ARGP4
ADDRGP4 sscanf
CALLI4
pop
line 1203
;1203:		value = Info_ValueForKey( userinfo, "cl_guid" );
ADDRLP4 16
ARGP4
ADDRGP4 $463
ARGP4
ADDRLP4 1212
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 1212
INDIRP4
ASGNP4
line 1204
;1204:		G_LogPrintf( "ClientDetails: ip\\%s\\id\\%i\\guid\\%s\n", ip, clientNum, value);
ADDRGP4 $464
ARGP4
ADDRLP4 1040
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1205
;1205:	}
LABELV $460
line 1206
;1206:	G_LogPrintf( "ClientConnect: %i\n", clientNum );
ADDRGP4 $465
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1207
;1207:	ClientUserinfoChanged( clientNum );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLV
pop
line 1210
;1208:
;1209:	// don't do the "xxx connected" messages if they were caried over from previous level
;1210:	if ( firstTime ) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $466
line 1211
;1211:		trap_SendServerCommand( -1, va("print \"%s" S_COLOR_WHITE " connected\n\"", client->pers.netname) );
ADDRGP4 $468
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
ARGP4
ADDRLP4 1208
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 1208
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1212
;1212:	}
LABELV $466
line 1214
;1213:
;1214:	if ( g_gametype.integer >= GT_TEAM &&
ADDRLP4 1208
CNSTI4 3
ASGNI4
ADDRGP4 g_gametype+12
INDIRI4
ADDRLP4 1208
INDIRI4
LTI4 $469
ADDRLP4 0
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
ADDRLP4 1208
INDIRI4
EQI4 $469
line 1215
;1215:		client->sess.sessionTeam != TEAM_SPECTATOR ) {
line 1216
;1216:		BroadcastTeamChange( client, -1 );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 BroadcastTeamChange
CALLV
pop
line 1217
;1217:	}
LABELV $469
line 1220
;1218:
;1219:	// count current clients and rank for scoreboard
;1220:	CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 1229
;1221:
;1222:	// for statistics
;1223://	client->areabits = areabits;
;1224://	if ( !client->areabits )
;1225://		client->areabits = G_Alloc( (trap_AAS_PointReachabilityAreaIndex( NULL ) + 7) / 8 );
;1226:
;1227://unlagged - backward reconciliation #5
;1228:	// announce it
;1229:	if ( firstTime ) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $472
line 1230
;1230:		if ( g_delagHitscan.integer == 1 ) {
ADDRGP4 g_delagHitscan+12
INDIRI4
CNSTI4 1
NEI4 $474
line 1231
;1231:			trap_SendServerCommand( clientNum, "print \"This server is Unlagged: full lag compensation is ON!\n\"" );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $477
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1232
;1232:		} else {
ADDRGP4 $475
JUMPV
LABELV $474
line 1233
;1233:			trap_SendServerCommand( clientNum, "print \"This server is Unlagged: full lag compensation is OFF!\n\"" );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $478
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1234
;1234:		}
LABELV $475
line 1237
;1235://unlagged - backward reconciliation #5
;1236:
;1237:		trap_SendServerCommand( ent-g_entities, va("motd \"%s\" \"%s\" \"%s\" \"%s\" \"%s\" \"%s\" \"%s\" \"%s\"", 
ADDRGP4 $479
ARGP4
ADDRGP4 sv_motd1+16
ARGP4
ADDRGP4 sv_motd2+16
ARGP4
ADDRGP4 sv_motd3+16
ARGP4
ADDRGP4 sv_motd4+16
ARGP4
ADDRGP4 sv_motd5+16
ARGP4
ADDRGP4 sv_motd6+16
ARGP4
ADDRGP4 sv_motd7+16
ARGP4
ADDRGP4 sv_motd8+16
ARGP4
ADDRLP4 1212
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 896
DIVI4
ARGI4
ADDRLP4 1212
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1249
;1238:			sv_motd1.string,
;1239:			sv_motd2.string,
;1240:			sv_motd3.string,
;1241:			sv_motd4.string,
;1242:			sv_motd5.string,
;1243:			sv_motd6.string,
;1244:			sv_motd7.string,
;1245:			sv_motd8.string) );
;1246:
;1247:	//Mod messages
;1248:	//if ( firstTime ) {
;1249:		trap_SendServerCommand( clientNum, va("print \"This server is running %s %s\nPlease visit http://www.quake-revolution.net for details. Please also post questions, comments, suggestions, or bug reports on the forums -Thanks.\n\"", GAMEVERSION, BUILDINFO) );
ADDRGP4 $488
ARGP4
ADDRGP4 $489
ARGP4
ADDRGP4 $490
ARGP4
ADDRLP4 1216
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1216
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1250
;1250:	}
LABELV $472
line 1252
;1251:
;1252:	if ( g_muteTourneyspecs.integer == 0 && g_gametype.integer == 1 ) {
ADDRGP4 g_muteTourneyspecs+12
INDIRI4
CNSTI4 0
NEI4 $491
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $491
line 1253
;1253:		trap_SendServerCommand( clientNum, "print \"Tournament spectators are not muted.\n\"" );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $495
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1254
;1254:	}
LABELV $491
line 1255
;1255:	if ( g_muteSpecs.integer == 1 && g_gametype.integer != 1 ) {
ADDRLP4 1212
CNSTI4 1
ASGNI4
ADDRGP4 g_muteSpecs+12
INDIRI4
ADDRLP4 1212
INDIRI4
NEI4 $496
ADDRGP4 g_gametype+12
INDIRI4
ADDRLP4 1212
INDIRI4
EQI4 $496
line 1256
;1256:		trap_SendServerCommand( clientNum, "print \"Spectators are muted.\n\"" );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $500
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1257
;1257:	}
LABELV $496
line 1263
;1258:
;1259:	//#################
;1260:	//# Send client cvar information
;1261:	//if ( g_dedicated.integer ) {
;1262:	//FIXME: sv_Fps doesn't need to be sent anymore
;1263:		trap_SendServerCommand( clientNum, va("connUCv %i %i %i %i %i %i %i %i %i %i %i %i %i\n",
ADDRGP4 $501
ARGP4
ADDRGP4 sv_minRate+12
INDIRI4
ARGI4
ADDRGP4 sv_lock_cg_railHum_to+12
INDIRI4
ARGI4
ADDRGP4 weap_gauntletCycle+12
INDIRI4
ARGI4
ADDRGP4 weap_machinegunCycle+12
INDIRI4
ARGI4
ADDRGP4 weap_shotgunCycle+12
INDIRI4
ARGI4
ADDRGP4 weap_grenadelauncherCycle+12
INDIRI4
ARGI4
ADDRGP4 weap_lightninggunCycle+12
INDIRI4
ARGI4
ADDRGP4 weap_rocketlauncherCycle+12
INDIRI4
ARGI4
ADDRGP4 weap_railgunCycle+12
INDIRI4
ARGI4
ADDRGP4 weap_plasmagunCycle+12
INDIRI4
ARGI4
ADDRGP4 weap_bfgCycle+12
INDIRI4
ARGI4
ADDRGP4 g_DynamicGauntletCycle+12
INDIRI4
ARGI4
ADDRGP4 weap_allowed+12
INDIRI4
ARGI4
ADDRLP4 1216
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1216
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1282
;1264:			sv_minRate.integer,
;1265:			sv_lock_cg_railHum_to.integer,
;1266:			weap_gauntletCycle.integer,
;1267:			weap_machinegunCycle.integer,
;1268:			weap_shotgunCycle.integer,
;1269:			weap_grenadelauncherCycle.integer,
;1270:			weap_lightninggunCycle.integer,
;1271:			weap_rocketlauncherCycle.integer,
;1272:			weap_railgunCycle.integer,
;1273:			weap_plasmagunCycle.integer,
;1274:			weap_bfgCycle.integer,
;1275:			g_DynamicGauntletCycle.integer,
;1276:			weap_allowed.integer) );
;1277:	//}
;1278:	//#
;1279:	//#################
;1280:
;1281:		//Send vote information of one is in progress..
;1282:		if (level.voteTime) {
ADDRGP4 level+2444
INDIRI4
CNSTI4 0
EQI4 $515
line 1283
;1283:			trap_SendServerCommand( clientNum, va("vt \"%i %s\n\"", level.voteTime, level.voteDisplayString) );
ADDRGP4 $518
ARGP4
ADDRGP4 level+2444
INDIRI4
ARGI4
ADDRGP4 level+1420
ARGP4
ADDRLP4 1220
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1220
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1284
;1284:			trap_SendServerCommand( clientNum, va("vt \"%i %i\n\"", level.voteYes, level.voteNo) );
ADDRGP4 $521
ARGP4
ADDRGP4 level+2452
INDIRU1
CVUI4 1
ARGI4
ADDRGP4 level+2453
INDIRU1
CVUI4 1
ARGI4
ADDRLP4 1224
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1224
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1285
;1285:		} else if (level.teamVoteTime[TEAM_RED-1]) {
ADDRGP4 $516
JUMPV
LABELV $515
ADDRGP4 level+4504
INDIRI4
CNSTI4 0
EQI4 $524
line 1286
;1286:			trap_SendServerCommand( clientNum, va("tv \"%i %i %i\n\"", TEAM_RED-1, level.teamVoteTime[TEAM_RED-1], level.teamVoteString[TEAM_RED-1]) );
ADDRGP4 $527
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 level+4504
INDIRI4
ARGI4
ADDRGP4 level+2455
ARGP4
ADDRLP4 1220
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1220
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1287
;1287:			trap_SendServerCommand( clientNum, va("tv \"%i %i %i\n\"", TEAM_RED-1, level.teamVoteYes[TEAM_RED-1], level.teamVoteNo[TEAM_RED-1]) );
ADDRGP4 $527
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 level+4512
INDIRI4
ARGI4
ADDRGP4 level+4520
INDIRI4
ARGI4
ADDRLP4 1224
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1224
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1288
;1288:		} else if (level.teamVoteTime[TEAM_BLUE-1]) {
ADDRGP4 $525
JUMPV
LABELV $524
ADDRGP4 level+4504+4
INDIRI4
CNSTI4 0
EQI4 $532
line 1289
;1289:			trap_SendServerCommand( clientNum, va("tv \"%i %i %i\n\"", TEAM_BLUE-1, level.teamVoteTime[TEAM_BLUE-1], level.teamVoteString[TEAM_BLUE-1]) );
ADDRGP4 $527
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 level+4504+4
INDIRI4
ARGI4
ADDRGP4 level+2455+1024
ARGP4
ADDRLP4 1220
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1220
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1290
;1290:			trap_SendServerCommand( clientNum, va("tv \"%i %i %i\n\"", TEAM_BLUE-1, level.teamVoteYes[TEAM_BLUE-1], level.teamVoteNo[TEAM_BLUE-1]) );
ADDRGP4 $527
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 level+4512+4
INDIRI4
ARGI4
ADDRGP4 level+4520+4
INDIRI4
ARGI4
ADDRLP4 1224
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1224
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1291
;1291:		}
LABELV $532
LABELV $525
LABELV $516
line 1294
;1292:
;1293:
;1294:	return NULL;
CNSTP4 0
RETP4
LABELV $407
endproc ClientConnect 1228 56
export ClientBegin
proc ClientBegin 28 12
line 1306
;1295:}
;1296:
;1297:/*
;1298:===========
;1299:ClientBegin
;1300:
;1301:called when a client has finished connecting, and is ready
;1302:to be placed into the level.  This will happen every level load,
;1303:and on transition between teams, but doesn't happen on respawns
;1304:============
;1305:*/
;1306:void ClientBegin( int clientNum ) {
line 1312
;1307:	gentity_t	*ent;
;1308:	gclient_t	*client;
;1309:	gentity_t	*tent;
;1310:	int			flags;
;1311:
;1312:	ent = g_entities + clientNum;
ADDRLP4 4
CNSTI4 896
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1314
;1313:
;1314:	client = level.clients + clientNum;
ADDRLP4 0
CNSTI4 10828
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 1316
;1315:
;1316:	if ( ent->r.linked ) {
ADDRLP4 4
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
EQI4 $545
line 1318
;1317:		//ent->relink = 0;
;1318:		trap_UnlinkEntity( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 1319
;1319:	}
LABELV $545
line 1320
;1320:	G_InitGentity( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_InitGentity
CALLV
pop
line 1321
;1321:	ent->touch = 0;
ADDRLP4 4
INDIRP4
CNSTI4 704
ADDP4
CNSTP4 0
ASGNP4
line 1322
;1322:	ent->pain = 0;
ADDRLP4 4
INDIRP4
CNSTI4 712
ADDP4
CNSTP4 0
ASGNP4
line 1323
;1323:	ent->client = client;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 1325
;1324:
;1325:	client->pers.connected = CON_CONNECTED;
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
CNSTI4 2
ASGNI4
line 1326
;1326:	client->pers.enterTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 1327
;1327:	client->pers.teamState.state = TEAM_BEGIN;
ADDRLP4 0
INDIRP4
CNSTI4 560
ADDP4
CNSTI4 0
ASGNI4
line 1335
;1328:	//client->pers.last_Event = -1;
;1329:
;1330:	// save eflags around this, because changing teams will
;1331:	// cause this to happen with a valid entity, and we
;1332:	// want to make sure the teleport bit is set right
;1333:	// so the viewpoint doesn't interpolate through the
;1334:	// world to the new position
;1335:	flags = client->ps.eFlags;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
ASGNI4
line 1336
;1336:	memset( &client->ps, 0, sizeof( client->ps ) );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 468
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1337
;1337:	client->ps.eFlags = flags;
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 1340
;1338:
;1339:	// locate ent at a spawn point
;1340:	ClientSpawn( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 ClientSpawn
CALLV
pop
line 1342
;1341:
;1342:	if ( client->sess.sessionTeam != TEAM_SPECTATOR ) {
ADDRLP4 0
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
CNSTI4 3
EQI4 $548
line 1344
;1343:		// send event
;1344:		tent = G_TempEntity( ent->client->ps.origin, EV_PLAYER_TELEPORT_IN );
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTI4 42
ARGI4
ADDRLP4 16
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 16
INDIRP4
ASGNP4
line 1345
;1345:		tent->s.clientNum = ent->s.clientNum;
ADDRLP4 20
CNSTI4 168
ASGNI4
ADDRLP4 12
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
ADDRLP4 4
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 1347
;1346:
;1347:		if ( g_gametype.integer != GT_TOURNAMENT  ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
EQI4 $550
line 1348
;1348:			trap_SendServerCommand( -1, va("print \"%s" S_COLOR_WHITE " entered the game\n\"", client->pers.netname) );
ADDRGP4 $553
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1349
;1349:		}
LABELV $550
line 1350
;1350:	}
LABELV $548
line 1351
;1351:	G_LogPrintf( "ClientBegin: %i\n", clientNum );
ADDRGP4 $554
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1354
;1352:
;1353:	// count current clients and rank for scoreboard
;1354:	CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 1355
;1355:}
LABELV $544
endproc ClientBegin 28 12
export ClientSpawn
proc ClientSpawn 10972 16
line 1366
;1356:
;1357:/*
;1358:===========
;1359:ClientSpawn
;1360:
;1361:Called every time a client is placed fresh in the world:
;1362:after the first ClientBegin, and after each respawn
;1363:Initializes all non-persistant parts of playerState
;1364:============
;1365:*/
;1366:void ClientSpawn(gentity_t *ent) {
line 1382
;1367:	int		index;
;1368:	vec3_t	spawn_origin, spawn_angles;
;1369:	gclient_t	*client;
;1370:	int		i;
;1371:	clientPersistant_t	saved;
;1372:	clientSession_t		savedSess;
;1373:	int		persistant[MAX_PERSISTANT];
;1374:	gentity_t	*spawnPoint;
;1375:	int		flags;
;1376:	int		savedPing;
;1377://	char	*savedAreaBits;
;1378:	int		accuracy_hits, accuracy_shots;
;1379:	int		eventSequence;
;1380:	char	userinfo[MAX_INFO_STRING];
;1381:
;1382:	index = ent - g_entities;
ADDRLP4 100
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
line 1383
;1383:	client = ent->client;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 1385
;1384:
;1385:	ent->deathCounted = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 876
ADDP4
CNSTI4 0
ASGNI4
line 1390
;1386:
;1387:	// find a spawn point
;1388:	// do it before setting health back up, so farthest
;1389:	// ranging doesn't count this client
;1390:	if ( client->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRLP4 4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
CNSTI4 3
NEI4 $556
line 1391
;1391:		spawnPoint = SelectSpectatorSpawnPoint ( 
ADDRLP4 76
ARGP4
ADDRLP4 88
ARGP4
ADDRLP4 10916
ADDRGP4 SelectSpectatorSpawnPoint
CALLP4
ASGNP4
ADDRLP4 72
ADDRLP4 10916
INDIRP4
ASGNP4
line 1393
;1392:						spawn_origin, spawn_angles);
;1393:	} else if (g_gametype.integer >= GT_CTF ) {
ADDRGP4 $557
JUMPV
LABELV $556
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
LTI4 $558
line 1395
;1394:		// all base oriented team games use the CTF spawn points
;1395:		spawnPoint = SelectCTFSpawnPoint ( 
ADDRLP4 4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ARGI4
ADDRLP4 76
ARGP4
ADDRLP4 88
ARGP4
ADDRLP4 10920
ADDRGP4 SelectCTFSpawnPoint
CALLP4
ASGNP4
ADDRLP4 72
ADDRLP4 10920
INDIRP4
ASGNP4
line 1399
;1396:						client->sess.sessionTeam, 
;1397:						client->pers.teamState.state, 
;1398:						spawn_origin, spawn_angles);
;1399:	} else {
ADDRGP4 $559
JUMPV
LABELV $558
LABELV $561
line 1400
;1400:		do {
line 1402
;1401:			// the first spawn should be at a good looking spot
;1402:			if ( !client->pers.initialSpawn && client->pers.localClient ) {
ADDRLP4 10920
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 500
ADDP4
INDIRI4
ADDRLP4 10920
INDIRI4
NEI4 $564
ADDRLP4 4
INDIRP4
CNSTI4 496
ADDP4
INDIRI4
ADDRLP4 10920
INDIRI4
EQI4 $564
line 1403
;1403:				client->pers.initialSpawn = qtrue;
ADDRLP4 4
INDIRP4
CNSTI4 500
ADDP4
CNSTI4 1
ASGNI4
line 1404
;1404:				spawnPoint = SelectInitialSpawnPoint( spawn_origin, spawn_angles );
ADDRLP4 76
ARGP4
ADDRLP4 88
ARGP4
ADDRLP4 10924
ADDRGP4 SelectInitialSpawnPoint
CALLP4
ASGNP4
ADDRLP4 72
ADDRLP4 10924
INDIRP4
ASGNP4
line 1405
;1405:			} else {
ADDRGP4 $565
JUMPV
LABELV $564
line 1407
;1406:				// don't spawn near existing origin if possible
;1407:				spawnPoint = SelectSpawnPoint ( 
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 88
ARGP4
ADDRLP4 10924
ADDRGP4 SelectSpawnPoint
CALLP4
ASGNP4
ADDRLP4 72
ADDRLP4 10924
INDIRP4
ASGNP4
line 1410
;1408:					client->ps.origin, 
;1409:					spawn_origin, spawn_angles);
;1410:			}
LABELV $565
line 1414
;1411:
;1412:			// Tim needs to prevent bots from spawning at the initial point
;1413:			// on q3dm0...
;1414:			if ( ( spawnPoint->flags & FL_NO_BOTS ) && ( ent->r.svFlags & SVF_BOT ) ) {
ADDRLP4 10924
CNSTI4 0
ASGNI4
ADDRLP4 72
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
ADDRLP4 10924
INDIRI4
EQI4 $566
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
ADDRLP4 10924
INDIRI4
EQI4 $566
line 1415
;1415:				continue;	// try again
ADDRGP4 $562
JUMPV
LABELV $566
line 1418
;1416:			}
;1417:			// just to be symetric, we have a nohumans option...
;1418:			if ( ( spawnPoint->flags & FL_NO_HUMANS ) && !( ent->r.svFlags & SVF_BOT ) ) {
ADDRLP4 10928
CNSTI4 0
ASGNI4
ADDRLP4 72
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
ADDRLP4 10928
INDIRI4
EQI4 $563
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
ADDRLP4 10928
INDIRI4
NEI4 $563
line 1419
;1419:				continue;	// try again
line 1422
;1420:			}
;1421:
;1422:			break;
LABELV $562
line 1424
;1423:
;1424:		} while ( 1 );
ADDRGP4 $561
JUMPV
LABELV $563
line 1425
;1425:	}
LABELV $559
LABELV $557
line 1426
;1426:	client->pers.teamState.state = TEAM_ACTIVE;
ADDRLP4 4
INDIRP4
CNSTI4 560
ADDP4
CNSTI4 1
ASGNI4
line 1429
;1427:
;1428:	// always clear the kamikaze flag
;1429:	ent->s.eFlags &= ~EF_KAMIKAZE;
ADDRLP4 10916
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 10916
INDIRP4
ADDRLP4 10916
INDIRP4
INDIRI4
CNSTI4 -513
BANDI4
ASGNI4
line 1433
;1430:
;1431:	// toggle the teleport bit so the client knows to not lerp
;1432:	// and never clear the voted flag
;1433:	flags = ent->client->ps.eFlags & (EF_TELEPORT_BIT | EF_VOTED | EF_TEAMVOTED);
ADDRLP4 104
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 540676
BANDI4
ASGNI4
line 1434
;1434:	flags ^= EF_TELEPORT_BIT;
ADDRLP4 104
ADDRLP4 104
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 1438
;1435:
;1436://unlagged - backward reconciliation #3
;1437:	// we don't want players being backward-reconciled to the place they died
;1438:	G_ResetHistory( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_ResetHistory
CALLV
pop
line 1440
;1439:	// and this is as good a time as any to clear the saved state
;1440:	ent->client->saved.leveltime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10804
ADDP4
CNSTI4 0
ASGNI4
line 1445
;1441://unlagged - backward reconciliation #3
;1442:
;1443:	// clear everything but the persistant data
;1444:
;1445:	saved = client->pers;
ADDRLP4 1132
ADDRLP4 4
INDIRP4
CNSTI4 468
ADDP4
INDIRB
ASGNB 9720
line 1446
;1446:	savedSess = client->sess;
ADDRLP4 10852
ADDRLP4 4
INDIRP4
CNSTI4 10188
ADDP4
INDIRB
ASGNB 48
line 1447
;1447:	savedPing = client->ps.ping;
ADDRLP4 10900
ADDRLP4 4
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
ASGNI4
line 1449
;1448://	savedAreaBits = client->areabits;
;1449:	accuracy_hits = client->accuracy_hits;
ADDRLP4 10904
ADDRLP4 4
INDIRP4
CNSTI4 10316
ADDP4
INDIRI4
ASGNI4
line 1450
;1450:	accuracy_shots = client->accuracy_shots;
ADDRLP4 10908
ADDRLP4 4
INDIRP4
CNSTI4 10312
ADDP4
INDIRI4
ASGNI4
line 1451
;1451:	for ( i = 0 ; i < MAX_PERSISTANT ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $570
line 1452
;1452:		persistant[i] = client->ps.persistant[i];
ADDRLP4 10920
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 10920
INDIRI4
ADDRLP4 8
ADDP4
ADDRLP4 10920
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 248
ADDP4
ADDP4
INDIRI4
ASGNI4
line 1453
;1453:	}
LABELV $571
line 1451
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $570
line 1454
;1454:	eventSequence = client->ps.eventSequence;
ADDRLP4 10912
ADDRLP4 4
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ASGNI4
line 1456
;1455:
;1456:	memset (client, 0, sizeof(*client)); // bk FIXME: Com_Memset?
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 10828
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1458
;1457:
;1458:	client->pers = saved;
ADDRLP4 4
INDIRP4
CNSTI4 468
ADDP4
ADDRLP4 1132
INDIRB
ASGNB 9720
line 1459
;1459:	client->sess = savedSess;
ADDRLP4 4
INDIRP4
CNSTI4 10188
ADDP4
ADDRLP4 10852
INDIRB
ASGNB 48
line 1460
;1460:	client->ps.ping = savedPing;
ADDRLP4 4
INDIRP4
CNSTI4 452
ADDP4
ADDRLP4 10900
INDIRI4
ASGNI4
line 1462
;1461://	client->areabits = savedAreaBits;
;1462:	client->accuracy_hits = accuracy_hits;
ADDRLP4 4
INDIRP4
CNSTI4 10316
ADDP4
ADDRLP4 10904
INDIRI4
ASGNI4
line 1463
;1463:	client->accuracy_shots = accuracy_shots;
ADDRLP4 4
INDIRP4
CNSTI4 10312
ADDP4
ADDRLP4 10908
INDIRI4
ASGNI4
line 1464
;1464:	client->lastkilled_client = -1;
ADDRLP4 4
INDIRP4
CNSTI4 10320
ADDP4
CNSTI4 -1
ASGNI4
line 1466
;1465:
;1466:	for ( i = 0 ; i < MAX_PERSISTANT ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $574
line 1467
;1467:		client->ps.persistant[i] = persistant[i];
ADDRLP4 10920
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 10920
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 248
ADDP4
ADDP4
ADDRLP4 10920
INDIRI4
ADDRLP4 8
ADDP4
INDIRI4
ASGNI4
line 1468
;1468:	}
LABELV $575
line 1466
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $574
line 1469
;1469:	client->ps.eventSequence = eventSequence;
ADDRLP4 4
INDIRP4
CNSTI4 108
ADDP4
ADDRLP4 10912
INDIRI4
ASGNI4
line 1471
;1470:	// increment the spawncount so the client will detect the respawn
;1471:	client->ps.persistant[PERS_SPAWN_COUNT]++;
ADDRLP4 10920
ADDRLP4 4
INDIRP4
CNSTI4 264
ADDP4
ASGNP4
ADDRLP4 10920
INDIRP4
ADDRLP4 10920
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1472
;1472:	client->ps.persistant[PERS_TEAM] = client->sess.sessionTeam;
ADDRLP4 4
INDIRP4
CNSTI4 260
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
ASGNI4
line 1474
;1473:
;1474:	client->airOutTime = level.time + 12000;
ADDRLP4 4
INDIRP4
CNSTI4 10348
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 12000
ADDI4
ASGNI4
line 1476
;1475:
;1476:	trap_GetUserinfo( index, userinfo, sizeof(userinfo) );
ADDRLP4 100
INDIRI4
ARGI4
ADDRLP4 108
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 1478
;1477:	// set max health
;1478:	client->pers.maxHealth = atoi( Info_ValueForKey( userinfo, "handicap" ) );
ADDRLP4 108
ARGP4
ADDRGP4 $303
ARGP4
ADDRLP4 10928
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 10928
INDIRP4
ARGP4
ADDRLP4 10932
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 552
ADDP4
ADDRLP4 10932
INDIRI4
ASGNI4
line 1479
;1479:	if ( client->pers.maxHealth < 1 || client->pers.maxHealth > 100 ) {
ADDRLP4 10936
ADDRLP4 4
INDIRP4
CNSTI4 552
ADDP4
INDIRI4
ASGNI4
ADDRLP4 10936
INDIRI4
CNSTI4 1
LTI4 $581
ADDRLP4 10936
INDIRI4
CNSTI4 100
LEI4 $579
LABELV $581
line 1480
;1480:		client->pers.maxHealth = 100;
ADDRLP4 4
INDIRP4
CNSTI4 552
ADDP4
CNSTI4 100
ASGNI4
line 1481
;1481:	}
LABELV $579
line 1483
;1482:	//FIXME: Better method?
;1483:	client->ps.stats[STAT_ARMOR] = gameSettings.spawn_armor;
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
ADDRGP4 gameSettings+12
INDIRI4
ASGNI4
line 1488
;1484:
;1485:	
;1486:	//client->ps.stats[STAT_MAX_HEALTH] = trap_Cvar_VariableIntegerValue("spawn_health");
;1487:
;1488:	client->ps.stats[STAT_MAX_HEALTH] = client->pers.maxHealth;
ADDRLP4 4
INDIRP4
CNSTI4 208
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 552
ADDP4
INDIRI4
ASGNI4
line 1489
;1489:	client->ps.eFlags = flags;
ADDRLP4 4
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 104
INDIRI4
ASGNI4
line 1491
;1490:
;1491:	ent->s.groundEntityNum = ENTITYNUM_NONE;
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 1023
ASGNI4
line 1492
;1492:	ent->client = &level.clients[index];
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
CNSTI4 10828
ADDRLP4 100
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 1493
;1493:	ent->takedamage = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 1
ASGNI4
line 1494
;1494:	ent->inuse = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
CNSTI4 1
ASGNI4
line 1495
;1495:	ent->classname = "player";
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $583
ASGNP4
line 1496
;1496:	ent->r.contents = CONTENTS_BODY;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 33554432
ASGNI4
line 1497
;1497:	ent->clipmask = MASK_PLAYERSOLID;
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 33619969
ASGNI4
line 1498
;1498:	ent->die = player_die;
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ADDRGP4 player_die
ASGNP4
line 1499
;1499:	ent->waterlevel = 0;
ADDRFP4 0
INDIRP4
CNSTI4 788
ADDP4
CNSTI4 0
ASGNI4
line 1500
;1500:	ent->watertype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 784
ADDP4
CNSTI4 0
ASGNI4
line 1501
;1501:	ent->flags = 0;
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
CNSTI4 0
ASGNI4
line 1503
;1502:	
;1503:	VectorCopy (playerMins, ent->r.mins);
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRGP4 playerMins
INDIRB
ASGNB 12
line 1504
;1504:	VectorCopy (playerMaxs, ent->r.maxs);
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
ADDRGP4 playerMaxs
INDIRB
ASGNB 12
line 1506
;1505:
;1506:	client->ps.clientNum = index;
ADDRLP4 4
INDIRP4
CNSTI4 140
ADDP4
ADDRLP4 100
INDIRI4
ASGNI4
line 1509
;1507:
;1508:	//Instagib or InstaFreeze or Railz or Rockets'n'Rails
;1509:	if ( g_gamemode.integer != 0 && g_gamemode.integer != 4 ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 0
EQI4 $584
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 4
EQI4 $584
line 1511
;1510:		//If it's an allowed weapon and it's after any possible change, they can have it.
;1511:		int i = 0;
ADDRLP4 10944
CNSTI4 0
ASGNI4
line 1512
;1512:		for ( i = WP_GAUNTLET; i < WP_BFG + 1; i++ ) {
ADDRLP4 10944
CNSTI4 1
ASGNI4
LABELV $588
line 1513
;1513:			if ( weap_allowed.integer & (1 << (i - 1)) ) {
ADDRLP4 10948
CNSTI4 1
ASGNI4
ADDRGP4 weap_allowed+12
INDIRI4
ADDRLP4 10948
INDIRI4
ADDRLP4 10944
INDIRI4
ADDRLP4 10948
INDIRI4
SUBI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $592
line 1514
;1514:				client->ps.stats[STAT_WEAPONS] |= ( 1 << i );
ADDRLP4 10952
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
ASGNP4
ADDRLP4 10952
INDIRP4
ADDRLP4 10952
INDIRP4
INDIRI4
CNSTI4 1
ADDRLP4 10944
INDIRI4
LSHI4
BORI4
ASGNI4
line 1515
;1515:				level.stats_picked |= 1 << (i - 1);
ADDRLP4 10956
ADDRGP4 level+10844
ASGNP4
ADDRLP4 10960
CNSTI4 1
ASGNI4
ADDRLP4 10956
INDIRP4
ADDRLP4 10956
INDIRP4
INDIRU1
CVUI4 1
ADDRLP4 10960
INDIRI4
ADDRLP4 10944
INDIRI4
ADDRLP4 10960
INDIRI4
SUBI4
LSHI4
BORI4
CVIU4 4
CVUU1 4
ASGNU1
line 1516
;1516:				if ( g_gamemode.integer == 2 ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 2
NEI4 $596
line 1517
;1517:					client->ps.ammo[i] = 25;
ADDRLP4 10944
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
CNSTI4 25
ASGNI4
line 1518
;1518:				} else {
ADDRGP4 $597
JUMPV
LABELV $596
line 1519
;1519:					client->ps.ammo[i] = INFINITE;
ADDRLP4 10944
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
CNSTI4 1000000
ASGNI4
line 1520
;1520:				}
LABELV $597
line 1521
;1521:			}
LABELV $592
line 1522
;1522:		}
LABELV $589
line 1512
ADDRLP4 10944
ADDRLP4 10944
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 10944
INDIRI4
CNSTI4 10
LTI4 $588
line 1523
;1523:	} else {
ADDRGP4 $585
JUMPV
LABELV $584
line 1525
;1524:		//Normal baseq3 or freeze
;1525:		if ( weap_allowed.integer & 1 ) {
ADDRGP4 weap_allowed+12
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $599
line 1526
;1526:			client->ps.stats[STAT_WEAPONS] |= ( 1 << WP_GAUNTLET );
ADDRLP4 10944
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
ASGNP4
ADDRLP4 10944
INDIRP4
ADDRLP4 10944
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 1527
;1527:			client->ps.ammo[WP_GAUNTLET] = -1;
ADDRLP4 4
INDIRP4
CNSTI4 380
ADDP4
CNSTI4 -1
ASGNI4
line 1528
;1528:			level.stats_picked |= (1 << (WP_GAUNTLET - 1));
ADDRLP4 10948
ADDRGP4 level+10844
ASGNP4
ADDRLP4 10948
INDIRP4
ADDRLP4 10948
INDIRP4
INDIRU1
CVUI4 1
CNSTI4 1
BORI4
CVIU4 4
CVUU1 4
ASGNU1
line 1529
;1529:		}
LABELV $599
line 1531
;1530:
;1531:		if ( weap_allowed.integer & 2 ) {
ADDRGP4 weap_allowed+12
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $603
line 1532
;1532:			client->ps.stats[STAT_WEAPONS] |= ( 1 << WP_MACHINEGUN );
ADDRLP4 10944
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
ASGNP4
ADDRLP4 10944
INDIRP4
ADDRLP4 10944
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 1533
;1533:			level.stats_picked |= (1 << (WP_MACHINEGUN - 1));
ADDRLP4 10948
ADDRGP4 level+10844
ASGNP4
ADDRLP4 10948
INDIRP4
ADDRLP4 10948
INDIRP4
INDIRU1
CVUI4 1
CNSTI4 2
BORI4
CVIU4 4
CVUU1 4
ASGNU1
line 1535
;1534:
;1535:			if ( g_gamemode.integer == 1 || g_gamemode.integer == 5 ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 1
EQI4 $611
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 5
NEI4 $607
LABELV $611
line 1536
;1536:				client->ps.ammo[WP_MACHINEGUN] = INFINITE;
ADDRLP4 4
INDIRP4
CNSTI4 384
ADDP4
CNSTI4 1000000
ASGNI4
line 1537
;1537:			} else if ( g_gametype.integer == GT_TEAM ) {
ADDRGP4 $608
JUMPV
LABELV $607
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
NEI4 $612
line 1538
;1538:				client->ps.ammo[WP_MACHINEGUN] = 50;
ADDRLP4 4
INDIRP4
CNSTI4 384
ADDP4
CNSTI4 50
ASGNI4
line 1539
;1539:			} else {
ADDRGP4 $613
JUMPV
LABELV $612
line 1540
;1540:				client->ps.ammo[WP_MACHINEGUN] = cpm_MGweapon; // CPM
ADDRLP4 4
INDIRP4
CNSTI4 384
ADDP4
ADDRGP4 cpm_MGweapon
INDIRI4
ASGNI4
line 1541
;1541:			}
LABELV $613
LABELV $608
line 1542
;1542:		}
LABELV $603
line 1543
;1543:	}
LABELV $585
line 1545
;1544:
;1545:	if( weap_enableHook.integer != 0 ) {
ADDRGP4 weap_enableHook+12
INDIRI4
CNSTI4 0
EQI4 $615
line 1546
;1546:		client->ps.ammo[WP_GRAPPLING_HOOK] = -1;
ADDRLP4 4
INDIRP4
CNSTI4 416
ADDP4
CNSTI4 -1
ASGNI4
line 1547
;1547:		if( weap_enableHook.integer == 2 ) {//only give the hook weapon when hook mode is 2
ADDRGP4 weap_enableHook+12
INDIRI4
CNSTI4 2
NEI4 $618
line 1548
;1548:			client->ps.stats[STAT_WEAPONS] |= ( 1 << WP_GRAPPLING_HOOK );
ADDRLP4 10944
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
ASGNP4
ADDRLP4 10944
INDIRP4
ADDRLP4 10944
INDIRP4
INDIRI4
CNSTI4 1024
BORI4
ASGNI4
line 1549
;1549:		}
LABELV $618
line 1550
;1550:	}
LABELV $615
line 1552
;1551:
;1552:	if ( g_spawnProtection.integer ) {
ADDRGP4 g_spawnProtection+12
INDIRI4
CNSTI4 0
EQI4 $621
line 1553
;1553:		client->ps.powerups[PW_BATTLESUIT] = level.time + g_spawnProtection.integer * 1000;
ADDRLP4 4
INDIRP4
CNSTI4 320
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 1000
ADDRGP4 g_spawnProtection+12
INDIRI4
MULI4
ADDI4
ASGNI4
line 1554
;1554:		client->spawnProtection = qtrue;
ADDRLP4 4
INDIRP4
CNSTI4 10824
ADDP4
CNSTI4 1
ASGNI4
line 1555
;1555:	}
LABELV $621
line 1556
;1556:	client->firstframe = 1;
ADDRLP4 4
INDIRP4
CNSTI4 10392
ADDP4
CNSTI4 1
ASGNI4
line 1557
;1557:	client->ps.ammo[WP_GRAPPLING_HOOK] = -1;
ADDRLP4 4
INDIRP4
CNSTI4 416
ADDP4
CNSTI4 -1
ASGNI4
line 1561
;1558:
;1559:	// health will count down towards max_health
;1560:	//ent->health = client->ps.stats[STAT_HEALTH] = client->ps.stats[STAT_MAX_HEALTH] + 25;
;1561:	ent->health = client->ps.stats[STAT_HEALTH] = client->ps.stats[STAT_MAX_HEALTH] * cpm_respawnhealth; // CPM
ADDRLP4 10948
ADDRLP4 4
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 cpm_respawnhealth
INDIRF4
MULF4
CVFI4 4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 10948
INDIRI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 10948
INDIRI4
ASGNI4
line 1563
;1562:
;1563:	G_SetOrigin( ent, spawn_origin );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 76
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 1564
;1564:	VectorCopy( spawn_origin, client->ps.origin );
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 76
INDIRB
ASGNB 12
line 1567
;1565:
;1566:	// the respawned flag will be cleared after the attack and jump keys come up
;1567:	client->ps.pm_flags |= PMF_RESPAWNED;
ADDRLP4 10952
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 10952
INDIRP4
ADDRLP4 10952
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 1569
;1568:
;1569:	trap_GetUsercmd( client - level.clients, &ent->client->pers.cmd );
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRGP4 level
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 10828
DIVI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 472
ADDP4
ARGP4
ADDRGP4 trap_GetUsercmd
CALLV
pop
line 1570
;1570:	SetClientViewAngle( ent, spawn_angles );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 88
ARGP4
ADDRGP4 SetClientViewAngle
CALLV
pop
line 1575
;1571:
;1572:/*freeze
;1573:	if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
;1574:freeze*/
;1575:	if ( ( g_gamemode.integer > 3 && is_spectator( client ) ) || 
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $631
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 10956
ADDRGP4 is_spectator
CALLI4
ASGNI4
ADDRLP4 10956
INDIRI4
CNSTI4 0
NEI4 $630
LABELV $631
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 4
GEI4 $626
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
CNSTI4 3
NEI4 $626
LABELV $630
line 1576
;1576:		( g_gamemode.integer < 4 && ent->client->sess.sessionTeam == TEAM_SPECTATOR ) ) {
line 1579
;1577://freeze
;1578:
;1579:	} else {
ADDRGP4 $627
JUMPV
LABELV $626
line 1580
;1580:		G_KillBox( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_KillBox
CALLV
pop
line 1581
;1581:		trap_LinkEntity (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 1584
;1582:
;1583:		// force the base weapon up
;1584:		client->ps.weapon = WP_MACHINEGUN;
ADDRLP4 4
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 2
ASGNI4
line 1585
;1585:		client->ps.weaponstate = WEAPON_READY;
ADDRLP4 4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 1587
;1586:
;1587:	}
LABELV $627
line 1590
;1588:
;1589:	// don't allow full run speed for a bit
;1590:	client->ps.pm_flags |= PMF_TIME_KNOCKBACK;
ADDRLP4 10960
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 10960
INDIRP4
ADDRLP4 10960
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 1591
;1591:	client->ps.pm_time = 100;
ADDRLP4 4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 100
ASGNI4
line 1593
;1592:
;1593:	client->respawnTime = level.time;
ADDRLP4 4
INDIRP4
CNSTI4 10332
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 1594
;1594:	client->inactivityTime = level.time + g_inactivity.integer * 1000;
ADDRLP4 4
INDIRP4
CNSTI4 10336
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 1000
ADDRGP4 g_inactivity+12
INDIRI4
MULI4
ADDI4
ASGNI4
line 1595
;1595:	client->latched_buttons = 0;
ADDRLP4 4
INDIRP4
CNSTI4 10264
ADDP4
CNSTI4 0
ASGNI4
line 1598
;1596:
;1597:	// set default animations
;1598:	client->ps.torsoAnim = TORSO_STAND;
ADDRLP4 4
INDIRP4
CNSTI4 84
ADDP4
CNSTI4 11
ASGNI4
line 1599
;1599:	client->ps.legsAnim = LEGS_IDLE;
ADDRLP4 4
INDIRP4
CNSTI4 76
ADDP4
CNSTI4 22
ASGNI4
line 1601
;1600:
;1601:	if ( level.intermissiontime ) {
ADDRGP4 level+9160
INDIRI4
CNSTI4 0
EQI4 $635
line 1602
;1602:		MoveClientToIntermission( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 MoveClientToIntermission
CALLV
pop
line 1603
;1603:	} else {
ADDRGP4 $636
JUMPV
LABELV $635
line 1605
;1604:		// fire the targets of the spawn point
;1605:		G_UseTargets( spawnPoint, ent );
ADDRLP4 72
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_UseTargets
CALLV
pop
line 1609
;1606:
;1607:		// select the highest weapon number available, after any
;1608:		// spawn given items have fired
;1609:		client->ps.weapon = 1;
ADDRLP4 4
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 1
ASGNI4
line 1610
;1610:		for ( i = WP_NUM_WEAPONS - 1 ; i > 0 ; i-- ) {
ADDRLP4 0
CNSTI4 10
ASGNI4
LABELV $638
line 1611
;1611:			if ( client->ps.stats[STAT_WEAPONS] & ( 1 << i ) ) {
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $642
line 1612
;1612:				client->ps.weapon = i;
ADDRLP4 4
INDIRP4
CNSTI4 144
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1613
;1613:				break;
ADDRGP4 $640
JUMPV
LABELV $642
line 1615
;1614:			}
;1615:		}
LABELV $639
line 1610
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $638
LABELV $640
line 1617
;1616://freeze
;1617:		if ( g_gamemode.integer == 4 && client->ps.stats[ STAT_WEAPONS ] & ( 1 << WP_ROCKET_LAUNCHER ) ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 4
NEI4 $644
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $644
line 1618
;1618:			client->ps.weapon = WP_ROCKET_LAUNCHER;
ADDRLP4 4
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 5
ASGNI4
line 1619
;1619:		}
LABELV $644
line 1628
;1620:/*
;1621:		if ( g_startArmor.integer > 0 ) {
;1622:			client->ps.stats[ STAT_ARMOR ] += g_startArmor.integer;
;1623:			if ( client->ps.stats[ STAT_ARMOR ] > client->ps.stats[ STAT_MAX_HEALTH ] * 2 ) {
;1624:				client->ps.stats[ STAT_ARMOR ] = client->ps.stats[ STAT_MAX_HEALTH ] * 2;
;1625:			}
;1626:		}*/
;1627://freeze
;1628:	}
LABELV $636
line 1632
;1629:
;1630:	// run a client frame to drop exactly to the floor,
;1631:	// initialize animations and other things
;1632:	client->ps.commandTime = level.time - 100;
ADDRLP4 4
INDIRP4
ADDRGP4 level+40
INDIRI4
CNSTI4 100
SUBI4
ASGNI4
line 1633
;1633:	ent->client->pers.cmd.serverTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 472
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 1634
;1634:	ClientThink( ent-g_entities );
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
ADDRGP4 ClientThink
CALLV
pop
line 1640
;1635:
;1636:	// positively link the client, even if the command times are weird
;1637:/*freeze
;1638:	if ( ent->client->sess.sessionTeam != TEAM_SPECTATOR ) {
;1639:freeze*/
;1640:	if ( (g_gamemode.integer > 3 && !is_spectator( client )) || 
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $654
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 10964
ADDRGP4 is_spectator
CALLI4
ASGNI4
ADDRLP4 10964
INDIRI4
CNSTI4 0
EQI4 $653
LABELV $654
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 4
GEI4 $649
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
CNSTI4 3
EQI4 $649
LABELV $653
line 1641
;1641:		(g_gamemode.integer < 4 && ent->client->sess.sessionTeam != TEAM_SPECTATOR) ) {
line 1643
;1642://freeze
;1643:		BG_PlayerStateToEntityState( &client->ps, &ent->s, qtrue );
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 1644
;1644:		VectorCopy( ent->client->ps.origin, ent->r.currentOrigin );
ADDRLP4 10968
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 10968
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 10968
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 1645
;1645:		trap_LinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 1646
;1646:	}
LABELV $649
line 1649
;1647:
;1648:	// run the presend to set anything else
;1649:	ClientEndFrame( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 ClientEndFrame
CALLV
pop
line 1652
;1650:
;1651:	// clear entity state values
;1652:	BG_PlayerStateToEntityState( &client->ps, &ent->s, qtrue );
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 1653
;1653:}
LABELV $555
endproc ClientSpawn 10972 16
export ClientDisconnect
proc ClientDisconnect 32 8
line 1668
;1654:
;1655:
;1656:/*
;1657:===========
;1658:ClientDisconnect
;1659:
;1660:Called when a player drops from the server.
;1661:Will not be called between levels.
;1662:
;1663:This should NOT be called directly by any game logic,
;1664:call trap_DropClient(), which will call this and do
;1665:server system housekeeping.
;1666:============
;1667:*/
;1668:void ClientDisconnect( int clientNum ) {
line 1679
;1669:	gentity_t	*ent;
;1670:	gentity_t	*tent;
;1671:	int			i, team;
;1672:
;1673:	// mod code start
;1674://	char		buffer[100];
;1675:	// mod code end
;1676:
;1677:
;1678:	//FIXME: This shouldn't be like this, it should be for the one team required..
;1679:	CheckForAutoUnlock(TEAM_RED);
CNSTI4 1
ARGI4
ADDRGP4 CheckForAutoUnlock
CALLV
pop
line 1680
;1680:	CheckForAutoUnlock(TEAM_BLUE);
CNSTI4 2
ARGI4
ADDRGP4 CheckForAutoUnlock
CALLV
pop
line 1681
;1681:	CheckForAutoUnlock(TEAM_FREE);
CNSTI4 0
ARGI4
ADDRGP4 CheckForAutoUnlock
CALLV
pop
line 1685
;1682:
;1683:	// cleanup if we are kicking a bot that
;1684:	// hasn't spawned yet
;1685:	G_RemoveQueuedBotBegin( clientNum );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 G_RemoveQueuedBotBegin
CALLV
pop
line 1687
;1686:
;1687:	ent = g_entities + clientNum;
ADDRLP4 4
CNSTI4 896
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1688
;1688:	if ( !ent->client ) {
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $656
line 1689
;1689:		return;
ADDRGP4 $655
JUMPV
LABELV $656
line 1691
;1690:	}
;1691:	if ( level.clients[ent-g_entities].playerReady&& level.warmupTime >= 1 ) {
CNSTI4 10828
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 896
DIVI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 10236
ADDP4
INDIRI4
CNSTI4 0
EQI4 $658
ADDRGP4 level+16
INDIRI4
CNSTI4 1
LTI4 $658
line 1692
;1692:		level.totalReady--;
ADDRLP4 16
ADDRGP4 level+32
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1693
;1693:	}
LABELV $658
line 1695
;1694:
;1695:	team = ent->client->sess.sessionTeam;
ADDRLP4 8
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
ASGNI4
line 1698
;1696:
;1697:	// stop any following clients
;1698:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $665
JUMPV
LABELV $662
line 1702
;1699:/*freeze
;1700:		if ( level.clients[i].sess.sessionTeam == TEAM_SPECTATOR
;1701:freeze*/
;1702:		if ( (g_gamemode.integer > 3 && is_spectator( &level.clients[ i ]) || 
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $672
CNSTI4 10828
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 is_spectator
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $671
LABELV $672
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 4
GEI4 $667
CNSTI4 10828
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 10188
ADDP4
INDIRI4
CNSTI4 3
NEI4 $667
LABELV $671
ADDRLP4 20
CNSTI4 10828
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 10196
ADDP4
INDIRI4
CNSTI4 2
NEI4 $667
ADDRLP4 20
INDIRP4
CNSTI4 10200
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $667
line 1706
;1703:			(g_gamemode.integer < 4 && level.clients[i].sess.sessionTeam == TEAM_SPECTATOR) )
;1704://freeze
;1705:			&& level.clients[i].sess.spectatorState == SPECTATOR_FOLLOW
;1706:			&& level.clients[i].sess.spectatorClient == clientNum ) {
line 1707
;1707:			StopFollowing( &g_entities[i] );
CNSTI4 896
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRGP4 StopFollowing
CALLV
pop
line 1708
;1708:		}
LABELV $667
line 1709
;1709:	}
LABELV $663
line 1698
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $665
ADDRLP4 0
INDIRI4
ADDRGP4 level+28
INDIRI4
LTI4 $662
line 1712
;1710:
;1711:	// send effect if they were completely connected
;1712:	if ( ent->client->pers.connected == CON_CONNECTED 
ADDRLP4 16
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $673
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $678
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 is_spectator
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $677
LABELV $678
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 4
GEI4 $673
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
CNSTI4 3
EQI4 $673
LABELV $677
line 1716
;1713:/*freeze
;1714:		&& ent->client->sess.sessionTeam != TEAM_SPECTATOR ) {
;1715:freeze*/
;1716:		&& ((g_gamemode.integer > 3 && !is_spectator( ent->client )) || (g_gamemode.integer < 4 && ent->client->sess.sessionTeam != TEAM_SPECTATOR)) ) {
line 1718
;1717://freeze
;1718:		tent = G_TempEntity( ent->client->ps.origin, EV_PLAYER_TELEPORT_OUT );
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTI4 43
ARGI4
ADDRLP4 24
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 24
INDIRP4
ASGNP4
line 1719
;1719:		tent->s.clientNum = ent->s.clientNum;
ADDRLP4 28
CNSTI4 168
ASGNI4
ADDRLP4 12
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
ADDRLP4 4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 1723
;1720:
;1721:		// They don't get to take powerups with them!
;1722:		// Especially important for stuff like CTF flags
;1723:		TossClientItems( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 TossClientItems
CALLV
pop
line 1731
;1724:#ifdef MISSIONPACK
;1725:		TossClientPersistantPowerups( ent );
;1726:		if( g_gametype.integer == GT_HARVESTER ) {
;1727:			TossClientCubes( ent );
;1728:		}
;1729:#endif
;1730:
;1731:	}
LABELV $673
line 1733
;1732:
;1733:	G_LogPrintf( "ClientDisconnect: %i\n", clientNum );
ADDRGP4 $679
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1736
;1734:
;1735:	// if we are playing in tourney mode and losing, give a win to the other player
;1736:	if ( (g_gametype.integer == GT_TOURNAMENT )
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $680
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRGP4 level+9160
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $680
ADDRGP4 level+16
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $680
ADDRGP4 level+124+4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $680
line 1738
;1737:		&& !level.intermissiontime
;1738:		&& !level.warmupTime && level.sortedClients[1] == clientNum ) {
line 1739
;1739:		level.clients[ level.sortedClients[0] ].sess.wins++;
ADDRLP4 28
CNSTI4 10828
ADDRGP4 level+124
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 10204
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1740
;1740:		ClientUserinfoChanged( level.sortedClients[0] );
ADDRGP4 level+124
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLV
pop
line 1741
;1741:	}
LABELV $680
line 1744
;1742:
;1743:	//ent->relink = 0;
;1744:	trap_UnlinkEntity (ent);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 1745
;1745:	ent->s.modelindex = 0;
ADDRLP4 4
INDIRP4
CNSTI4 160
ADDP4
CNSTI4 0
ASGNI4
line 1746
;1746:	ent->inuse = qfalse;
ADDRLP4 4
INDIRP4
CNSTI4 520
ADDP4
CNSTI4 0
ASGNI4
line 1747
;1747:	ent->classname = "disconnected";
ADDRLP4 4
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $689
ASGNP4
line 1748
;1748:	ent->client->pers.connected = CON_DISCONNECTED;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
CNSTI4 0
ASGNI4
line 1749
;1749:	ent->client->ps.persistant[PERS_TEAM] = TEAM_FREE;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 260
ADDP4
CNSTI4 0
ASGNI4
line 1750
;1750:	ent->client->sess.sessionTeam = TEAM_FREE;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
CNSTI4 0
ASGNI4
line 1751
;1751:	CheckForAutoUnlock(team); //Check for autounlock
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 CheckForAutoUnlock
CALLV
pop
line 1753
;1752:
;1753:	trap_SetConfigstring( CS_PLAYERS + clientNum, "");
ADDRFP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRGP4 $690
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1755
;1754:
;1755:	CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 1757
;1756:
;1757:	if ( ent->r.svFlags & SVF_BOT ) {
ADDRLP4 4
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $691
line 1758
;1758:		BotAIShutdownClient( clientNum, qfalse );
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 BotAIShutdownClient
CALLI4
pop
line 1759
;1759:	}
LABELV $691
line 1760
;1760:}
LABELV $655
endproc ClientDisconnect 32 8
import cpm_lavafrequency
import cpm_slimedamage
import cpm_lavadamage
import cpm_itemsize
import cpm_hittones
import cpm_startpowerups
import cpm_itemrespawnammo
import cpm_itemrespawnBS
import cpm_itemrespawnpowerup
import cpm_itemrespawnhealth
import cpm_knockback_z
import cpm_respawnhealth
import cpm_BSprotection
import CPM_CanGrabArmor
import cpm_armorsystem
import cpm_outofammodelay
import cpm_weaponraise
import cpm_weapondrop
import cpm_RGchange
import cpm_RGbox
import cpm_RGmaxammo
import cpm_LGmaxammo
import cpm_LGknockback
import cpm_RLmaxammo
import cpm_RLspeed
import cpm_GLmaxammo
import cpm_GLreload
import CPM_CanGrabAmmo
import cpm_SSGmaxammo
import cpm_SSGknockback
import cpm_SSGdmg
import cpm_MGweapon
import cpm_MGdmg_tp
import cpm_MGdmg
import cpm_MGbox
import cpm_Gauntletknockback
import CPM_PM_Aircontrol
import pm_friction
import pm_accelerate
import cpm_pm_wishspeed
import cpm_pm_strafeaccelerate
import cpm_pm_aircontrol
import cpm_pm_airstopaccelerate
import cpm_pm_jump_z
import CPM_UpdateSettings
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
import CalculateRanks
import AddScore
import player_die
import InitClientResp
import InitClientPersistant
import BeginIntermission
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
LABELV $690
byte 1 0
align 1
LABELV $689
byte 1 100
byte 1 105
byte 1 115
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $679
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 68
byte 1 105
byte 1 115
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $583
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $554
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 66
byte 1 101
byte 1 103
byte 1 105
byte 1 110
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $553
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
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $527
byte 1 116
byte 1 118
byte 1 32
byte 1 34
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $521
byte 1 118
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $518
byte 1 118
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $501
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 85
byte 1 67
byte 1 118
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
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $500
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 83
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 97
byte 1 116
byte 1 111
byte 1 114
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 109
byte 1 117
byte 1 116
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $495
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
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
byte 1 32
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 97
byte 1 116
byte 1 111
byte 1 114
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 109
byte 1 117
byte 1 116
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $490
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
LABELV $489
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
LABELV $488
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 84
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 114
byte 1 117
byte 1 110
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 80
byte 1 108
byte 1 101
byte 1 97
byte 1 115
byte 1 101
byte 1 32
byte 1 118
byte 1 105
byte 1 115
byte 1 105
byte 1 116
byte 1 32
byte 1 104
byte 1 116
byte 1 116
byte 1 112
byte 1 58
byte 1 47
byte 1 47
byte 1 119
byte 1 119
byte 1 119
byte 1 46
byte 1 113
byte 1 117
byte 1 97
byte 1 107
byte 1 101
byte 1 45
byte 1 114
byte 1 101
byte 1 118
byte 1 111
byte 1 108
byte 1 117
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 46
byte 1 110
byte 1 101
byte 1 116
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 46
byte 1 32
byte 1 80
byte 1 108
byte 1 101
byte 1 97
byte 1 115
byte 1 101
byte 1 32
byte 1 97
byte 1 108
byte 1 115
byte 1 111
byte 1 32
byte 1 112
byte 1 111
byte 1 115
byte 1 116
byte 1 32
byte 1 113
byte 1 117
byte 1 101
byte 1 115
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 115
byte 1 44
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 44
byte 1 32
byte 1 115
byte 1 117
byte 1 103
byte 1 103
byte 1 101
byte 1 115
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 115
byte 1 44
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 98
byte 1 117
byte 1 103
byte 1 32
byte 1 114
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 115
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 117
byte 1 109
byte 1 115
byte 1 32
byte 1 45
byte 1 84
byte 1 104
byte 1 97
byte 1 110
byte 1 107
byte 1 115
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $479
byte 1 109
byte 1 111
byte 1 116
byte 1 100
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $478
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 84
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 85
byte 1 110
byte 1 108
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 58
byte 1 32
byte 1 102
byte 1 117
byte 1 108
byte 1 108
byte 1 32
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 101
byte 1 110
byte 1 115
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 79
byte 1 70
byte 1 70
byte 1 33
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $477
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 84
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 85
byte 1 110
byte 1 108
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 58
byte 1 32
byte 1 102
byte 1 117
byte 1 108
byte 1 108
byte 1 32
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 101
byte 1 110
byte 1 115
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 79
byte 1 78
byte 1 33
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $468
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
byte 1 34
byte 1 0
align 1
LABELV $465
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 67
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $464
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 68
byte 1 101
byte 1 116
byte 1 97
byte 1 105
byte 1 108
byte 1 115
byte 1 58
byte 1 32
byte 1 105
byte 1 112
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 105
byte 1 100
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 103
byte 1 117
byte 1 105
byte 1 100
byte 1 92
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $463
byte 1 99
byte 1 108
byte 1 95
byte 1 103
byte 1 117
byte 1 105
byte 1 100
byte 1 0
align 1
LABELV $462
byte 1 37
byte 1 100
byte 1 46
byte 1 37
byte 1 100
byte 1 46
byte 1 37
byte 1 100
byte 1 46
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $459
byte 1 66
byte 1 111
byte 1 116
byte 1 67
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $426
byte 1 73
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 119
byte 1 111
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $424
byte 1 110
byte 1 111
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $419
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 119
byte 1 111
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $415
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 98
byte 1 101
byte 1 101
byte 1 110
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 110
byte 1 101
byte 1 100
byte 1 58
byte 1 10
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $375
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 85
byte 1 115
byte 1 101
byte 1 114
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 67
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $374
byte 1 110
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 116
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 104
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 103
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 92
byte 1 37
byte 1 115
byte 1 92
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
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 99
byte 1 49
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 104
byte 1 99
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 119
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 108
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 116
byte 1 116
byte 1 92
byte 1 37
byte 1 100
byte 1 92
byte 1 116
byte 1 108
byte 1 92
byte 1 37
byte 1 100
byte 1 92
byte 1 115
byte 1 101
byte 1 120
byte 1 92
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $373
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $372
byte 1 110
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 116
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 104
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 99
byte 1 49
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 104
byte 1 99
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 119
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 108
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 116
byte 1 116
byte 1 92
byte 1 37
byte 1 100
byte 1 92
byte 1 116
byte 1 108
byte 1 92
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $369
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
LABELV $368
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
LABELV $367
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $357
byte 1 99
byte 1 103
byte 1 95
byte 1 97
byte 1 105
byte 1 109
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $356
byte 1 99
byte 1 103
byte 1 95
byte 1 97
byte 1 105
byte 1 109
byte 1 78
byte 1 117
byte 1 100
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $352
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
LABELV $351
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $347
byte 1 99
byte 1 103
byte 1 95
byte 1 102
byte 1 97
byte 1 115
byte 1 116
byte 1 82
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 95
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 114
byte 1 105
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $343
byte 1 99
byte 1 103
byte 1 95
byte 1 112
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 95
byte 1 102
byte 1 105
byte 1 120
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $339
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 79
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $337
byte 1 98
byte 1 0
align 1
LABELV $336
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $332
byte 1 114
byte 1 0
align 1
LABELV $331
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $328
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $322
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
LABELV $321
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $320
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
LABELV $319
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
LABELV $303
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
LABELV $302
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
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $297
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 98
byte 1 111
byte 1 97
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $292
byte 1 115
byte 1 101
byte 1 120
byte 1 0
align 1
LABELV $284
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $281
byte 1 99
byte 1 103
byte 1 95
byte 1 102
byte 1 105
byte 1 120
byte 1 101
byte 1 100
byte 1 84
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 101
byte 1 114
byte 1 65
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $278
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 68
byte 1 101
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $275
byte 1 99
byte 1 103
byte 1 95
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $274
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 108
byte 1 104
byte 1 111
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $271
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $270
byte 1 92
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 92
byte 1 98
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 0
align 1
LABELV $266
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
LABELV $262
byte 1 97
byte 1 108
byte 1 108
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $261
byte 1 97
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $159
byte 1 98
byte 1 111
byte 1 100
byte 1 121
byte 1 113
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $139
byte 1 67
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 102
byte 1 105
byte 1 110
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 32
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $76
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
LABELV $72
byte 1 110
byte 1 111
byte 1 104
byte 1 117
byte 1 109
byte 1 97
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $69
byte 1 48
byte 1 0
align 1
LABELV $68
byte 1 110
byte 1 111
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 0
