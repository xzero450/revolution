export ScorePlum
code
proc ScorePlum 12 8
file "../g_combat.c"
line 14
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// g_combat.c
;4:
;5:#include "g_local.h"
;6:#include "bg_promode.h"
;7:
;8:
;9:/*
;10:============
;11:ScorePlum
;12:============
;13:*/
;14:void ScorePlum( gentity_t *ent, vec3_t origin, int score ) {
line 17
;15:	gentity_t *plum;
;16:
;17:	plum = G_TempEntity( origin, EV_SCOREPLUM );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 65
ARGI4
ADDRLP4 4
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 19
;18:	// only send this temp entity to a single client
;19:	plum->r.svFlags |= SVF_SINGLECLIENT;
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
CNSTI4 256
BORI4
ASGNI4
line 20
;20:	plum->r.singleClient = ent->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 428
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 22
;21:	//
;22:	plum->s.otherEntityNum = ent->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 23
;23:	plum->s.time = score;
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 24
;24:}
LABELV $67
endproc ScorePlum 12 8
export AddScore
proc AddScore 8 12
line 33
;25:
;26:/*
;27:============
;28:AddScore
;29:
;30:Adds score to both the client and his team
;31:============
;32:*/
;33:void AddScore( gentity_t *ent, vec3_t origin, int score ) {
line 34
;34:	if ( !ent->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $69
line 35
;35:		return;
ADDRGP4 $68
JUMPV
LABELV $69
line 38
;36:	}
;37:	// no scoring during pre-match warmup
;38:	if ( level.warmupTime ) {
ADDRGP4 level+16
INDIRI4
CNSTI4 0
EQI4 $71
line 39
;39:		return;
ADDRGP4 $68
JUMPV
LABELV $71
line 42
;40:	}
;41:	// show score plum
;42:	ScorePlum(ent, origin, score);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 ScorePlum
CALLV
pop
line 44
;43:	//
;44:	ent->client->ps.persistant[PERS_SCORE] += score;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 248
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
ASGNI4
line 47
;45:/*freeze*/
;46://encasing this if may have caused freezetag to blow up :S
;47:	if ( g_gamemode.integer < 4 && g_gametype.integer == GT_TEAM )
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 4
GEI4 $74
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
NEI4 $74
line 48
;48:		level.teamScores[ ent->client->ps.persistant[PERS_TEAM] ] += score;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+88
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
ASGNI4
LABELV $74
line 50
;49:/*freeze*/
;50:	CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 51
;51:}
LABELV $68
endproc AddScore 8 12
export TossClientItems
proc TossClientItems 60 16
line 60
;52:
;53:/*
;54:=================
;55:TossClientItems
;56:
;57:Toss the weapon and powerups for the killed player
;58:=================
;59:*/
;60:void TossClientItems( gentity_t *self ) {
line 68
;61:	gitem_t		*item;
;62:	int			weapon;
;63:	float		angle;
;64:	int			i;
;65:	gentity_t	*drop;
;66:
;67:	// drop the weapon if not a gauntlet or machinegun
;68:	weapon = self->s.weapon;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
line 74
;69:
;70:	// make a special check to see if they are changing to a new
;71:	// weapon that isn't the mg or gauntlet.  Without this, a client
;72:	// can pick up a weapon, be killed, and not drop the weapon because
;73:	// their weapon change hasn't completed yet and they are still holding the MG.
;74:	if ( weapon == WP_MACHINEGUN || weapon == WP_GRAPPLING_HOOK ) {
ADDRLP4 12
INDIRI4
CNSTI4 2
EQI4 $82
ADDRLP4 12
INDIRI4
CNSTI4 10
NEI4 $80
LABELV $82
line 75
;75:		if ( self->client->ps.weaponstate == WEAPON_DROPPING ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 2
NEI4 $83
line 77
;76:			//Weapon Switching Conversion
;77:			weapon = self->client->pers.cmd.weapon;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 492
ADDP4
INDIRU1
CVUI4 1
ASGNI4
line 79
;78:			//weapon = self->client->pers.weapon;
;79:		}
LABELV $83
line 80
;80:		if ( !( self->client->ps.stats[STAT_WEAPONS] & ( 1 << weapon ) ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 12
INDIRI4
LSHI4
BANDI4
CNSTI4 0
NEI4 $85
line 81
;81:			weapon = WP_NONE;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 82
;82:		}
LABELV $85
line 83
;83:	}
LABELV $80
line 85
;84:	
;85:	if ( weapon > WP_MACHINEGUN && weapon != WP_GRAPPLING_HOOK && 
ADDRLP4 28
CNSTI4 2
ASGNI4
ADDRLP4 12
INDIRI4
ADDRLP4 28
INDIRI4
LEI4 $87
ADDRLP4 12
INDIRI4
CNSTI4 10
EQI4 $87
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRLP4 12
INDIRI4
ADDRLP4 28
INDIRI4
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
ADDRLP4 32
INDIRI4
EQI4 $87
ADDRGP4 g_gamemode+12
INDIRI4
ADDRLP4 32
INDIRI4
EQI4 $91
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 4
NEI4 $87
LABELV $91
line 87
;86:								//Allow dropping of weapons in baseq3 and railz.
;87:		self->client->ps.ammo[ weapon ] && (g_gamemode.integer == 0 || g_gamemode.integer == 4) ) {
line 89
;88:		// find the item type for this weapon
;89:		item = BG_FindItemForWeapon( weapon );
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 36
INDIRP4
ASGNP4
line 92
;90:
;91:		// spawn the item
;92:		Drop_Item( self, item, 0, qfalse );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 Drop_Item
CALLP4
pop
line 93
;93:	}
LABELV $87
line 96
;94:
;95:	// drop all the powerups if not in teamplay
;96:	if ( (g_gamemode.integer < 5 && g_gametype.integer != GT_TEAM)) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 5
GEI4 $92
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
EQI4 $92
line 101
;97:		//Drop them with advanced damage
;98:/*freeze*/
;99:		//if ( g_gamemode.integer < 4 && g_gametype.integer != GT_TEAM ) {
;100:/*freeze*/
;101:	{
line 102
;102:		for ( i = 1; i < HI_NUM_HOLDABLE; i++ ) {
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $96
line 103
;103:			if ( i == HI_KAMIKAZE ) continue;
ADDRLP4 0
INDIRI4
CNSTI4 3
NEI4 $100
ADDRGP4 $97
JUMPV
LABELV $100
line 104
;104:			if ( bg_itemlist[ self->client->ps.stats[ STAT_HOLDABLE_ITEM ] ].giTag == i ) {
CNSTI4 52
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $102
line 105
;105:				item = BG_FindItemForHoldable( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 BG_FindItemForHoldable
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 36
INDIRP4
ASGNP4
line 106
;106:				if ( !item ) break;
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $105
ADDRGP4 $98
JUMPV
LABELV $105
line 107
;107:				drop = Drop_Item( self, item, 45, qfalse );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 1110704128
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 40
ADDRGP4 Drop_Item
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 40
INDIRP4
ASGNP4
line 108
;108:				break;
ADDRGP4 $98
JUMPV
LABELV $102
line 110
;109:			}
;110:		}
LABELV $97
line 102
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 6
LTI4 $96
LABELV $98
line 111
;111:	}
line 113
;112://freeze
;113:		angle = 45;
ADDRLP4 16
CNSTF4 1110704128
ASGNF4
line 114
;114:		for ( i = 1 ; i < PW_NUM_POWERUPS ; i++ ) {
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $107
line 115
;115:			if ( self->client->ps.powerups[ i ] > level.time ) {
ADDRLP4 0
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
ADDRGP4 level+40
INDIRI4
LEI4 $111
line 116
;116:				item = BG_FindItemForPowerup( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 36
INDIRP4
ASGNP4
line 117
;117:				if ( !item ) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $114
line 118
;118:					continue;
ADDRGP4 $108
JUMPV
LABELV $114
line 120
;119:				}
;120:				drop = Drop_Item( self, item, angle, qfalse );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 16
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 40
ADDRGP4 Drop_Item
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 40
INDIRP4
ASGNP4
line 122
;121:				// decide how many seconds it has left
;122:				drop->count = ( self->client->ps.powerups[ i ] - level.time ) / 1000;
ADDRLP4 8
INDIRP4
CNSTI4 760
ADDP4
ADDRLP4 0
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
ADDRGP4 level+40
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
ASGNI4
line 123
;123:				if ( drop->count < 1 ) {
ADDRLP4 8
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 1
GEI4 $117
line 124
;124:					drop->count = 1;
ADDRLP4 8
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 1
ASGNI4
line 125
;125:				}
LABELV $117
line 126
;126:				angle += 45;
ADDRLP4 16
ADDRLP4 16
INDIRF4
CNSTF4 1110704128
ADDF4
ASGNF4
line 130
;127:			
;128:				//if it's a flag, set it's sacrifice positions in case we will need them
;129:				if( 
;130:					g_flagSacrifice.integer != 0 &&
ADDRGP4 g_flagSacrifice+12
INDIRI4
CNSTI4 0
EQI4 $119
ADDRLP4 48
CNSTI4 8
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRLP4 48
INDIRI4
NEI4 $119
ADDRLP4 52
ADDRLP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 7
EQI4 $123
ADDRLP4 52
INDIRI4
ADDRLP4 48
INDIRI4
EQI4 $123
ADDRLP4 52
INDIRI4
CNSTI4 9
NEI4 $119
LABELV $123
line 133
;131:					item->giType == IT_TEAM && 
;132:					(item->giTag == PW_REDFLAG || item->giTag == PW_BLUEFLAG || item->giTag == PW_NEUTRALFLAG)
;133:				) {
line 134
;134:					VectorCopy(level.playerLastKnownGood[self - g_entities][0], drop->flagSacData.sacrificePos[0]);
ADDRLP4 8
INDIRP4
CNSTI4 812
ADDP4
CNSTI4 24
ADDRFP4 0
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
INDIRB
ASGNB 12
line 135
;135:					VectorCopy(level.playerLastKnownGood[self - g_entities][1], drop->flagSacData.sacrificePos[1]);
ADDRLP4 8
INDIRP4
CNSTI4 824
ADDP4
CNSTI4 24
ADDRFP4 0
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
INDIRB
ASGNB 12
line 136
;136:					Com_sprintf(drop->flagSacData.sacPlayerName, sizeof(drop->flagSacData.sacPlayerName), self->client->pers.netname);
ADDRLP4 8
INDIRP4
CNSTI4 840
ADDP4
ARGP4
CNSTI4 36
ARGI4
ADDRLP4 56
CNSTI4 516
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 138
;137:					//also set the other sac data... damn stateless q3 items...
;138:					drop->flagSacData.sacrificeCount = 0;
ADDRLP4 8
INDIRP4
CNSTI4 808
ADDP4
CNSTI4 0
ASGNI4
line 139
;139:					drop->flagSacData.lastPickupPlayerEntNum = self - g_entities;
ADDRLP4 8
INDIRP4
CNSTI4 836
ADDP4
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
line 141
;140:					//TODO: CHECK THIS MAY NOT BE RQUD. FOR REVOLUTION 
;141:					drop->s.generic1 = 0;//BG_CanTouchItem() uses this to determine if the flag is on the base
ADDRLP4 8
INDIRP4
CNSTI4 204
ADDP4
CNSTI4 0
ASGNI4
line 142
;142:				}
LABELV $119
line 143
;143:			}
LABELV $111
line 144
;144:		}
LABELV $108
line 114
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 15
LTI4 $107
line 145
;145:	}
LABELV $92
line 147
;146:	//}
;147:}
LABELV $79
endproc TossClientItems 60 16
export LookAtKiller
proc LookAtKiller 52 4
line 237
;148:
;149:#ifdef MISSIONPACK
;150:
;151:/*
;152:=================
;153:TossClientCubes
;154:=================
;155:*/
;156:extern gentity_t	*neutralObelisk;
;157:
;158:void TossClientCubes( gentity_t *self ) {
;159:	gitem_t		*item;
;160:	gentity_t	*drop;
;161:	vec3_t		velocity;
;162:	vec3_t		angles;
;163:	vec3_t		origin;
;164:
;165:	self->client->ps.generic1 = 0;
;166:
;167:	// this should never happen but we should never
;168:	// get the server to crash due to skull being spawned in
;169:	if (!G_EntitiesFree()) {
;170:		return;
;171:	}
;172:
;173:	if( self->client->sess.sessionTeam == TEAM_RED ) {
;174:		item = BG_FindItem( "Red Cube" );
;175:	}
;176:	else {
;177:		item = BG_FindItem( "Blue Cube" );
;178:	}
;179:
;180:	angles[YAW] = (float)(level.time % 360);
;181:	angles[PITCH] = 0;	// always forward
;182:	angles[ROLL] = 0;
;183:
;184:	AngleVectors( angles, velocity, NULL, NULL );
;185:	VectorScale( velocity, 150, velocity );
;186:	velocity[2] += 200 + crandom() * 50;
;187:
;188:	if( neutralObelisk ) {
;189:		VectorCopy( neutralObelisk->s.pos.trBase, origin );
;190:		origin[2] += 44;
;191:	} else {
;192:		VectorClear( origin ) ;
;193:	}
;194:
;195:	drop = LaunchItem( item, origin, velocity );
;196:
;197:	drop->nextthink = level.time + g_cubeTimeout.integer * 1000;
;198:	drop->think = G_FreeEntity;
;199:	drop->spawnflags = self->client->sess.sessionTeam;
;200:}
;201:
;202:
;203:/*
;204:=================
;205:TossClientPersistantPowerups
;206:=================
;207:*/
;208:void TossClientPersistantPowerups( gentity_t *ent ) {
;209:	gentity_t	*powerup;
;210:
;211:	if( !ent->client ) {
;212:		return;
;213:	}
;214:
;215:	if( !ent->client->persistantPowerup ) {
;216:		return;
;217:	}
;218:
;219:	powerup = ent->client->persistantPowerup;
;220:
;221:	powerup->r.svFlags &= ~SVF_NOCLIENT;
;222:	powerup->s.eFlags &= ~EF_NODRAW;
;223:	powerup->r.contents = CONTENTS_TRIGGER;
;224:	trap_LinkEntity( powerup );
;225:
;226:	ent->client->ps.stats[STAT_PERSISTANT_POWERUP] = 0;
;227:	ent->client->persistantPowerup = NULL;
;228:}
;229:#endif
;230:
;231:
;232:/*
;233:==================
;234:LookAtKiller
;235:==================
;236:*/
;237:void LookAtKiller( gentity_t *self, gentity_t *inflictor, gentity_t *attacker ) {
line 241
;238:	vec3_t		dir;
;239:	vec3_t		angles;
;240:
;241:	if ( attacker && attacker != self ) {
ADDRLP4 24
ADDRFP4 8
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 24
INDIRU4
CNSTU4 0
EQU4 $128
ADDRLP4 24
INDIRU4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $128
line 242
;242:		VectorSubtract (attacker->s.pos.trBase, self->s.pos.trBase, dir);
ADDRLP4 28
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 32
CNSTI4 24
ASGNI4
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ADDRLP4 36
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 40
CNSTI4 28
ASGNI4
ADDRLP4 0+4
ADDRLP4 28
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
ADDRLP4 36
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 44
CNSTI4 32
ASGNI4
ADDRLP4 0+8
ADDRFP4 8
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 243
;243:	} else if ( inflictor && inflictor != self ) {
ADDRGP4 $129
JUMPV
LABELV $128
ADDRLP4 28
ADDRFP4 4
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 28
INDIRU4
CNSTU4 0
EQU4 $132
ADDRLP4 28
INDIRU4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $132
line 244
;244:		VectorSubtract (inflictor->s.pos.trBase, self->s.pos.trBase, dir);
ADDRLP4 32
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 36
CNSTI4 24
ASGNI4
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 44
CNSTI4 28
ASGNI4
ADDRLP4 0+4
ADDRLP4 32
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 48
CNSTI4 32
ASGNI4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 245
;245:	} else {
ADDRGP4 $133
JUMPV
LABELV $132
line 246
;246:		self->client->ps.stats[STAT_DEAD_YAW] = self->s.angles[YAW];
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 200
ADDP4
ADDRLP4 32
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 247
;247:		return;
ADDRGP4 $127
JUMPV
LABELV $133
LABELV $129
line 250
;248:	}
;249:
;250:	self->client->ps.stats[STAT_DEAD_YAW] = vectoyaw ( dir );
ADDRLP4 0
ARGP4
ADDRLP4 32
ADDRGP4 vectoyaw
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 200
ADDP4
ADDRLP4 32
INDIRF4
CVFI4 4
ASGNI4
line 252
;251:
;252:	angles[YAW] = vectoyaw ( dir );
ADDRLP4 0
ARGP4
ADDRLP4 36
ADDRGP4 vectoyaw
CALLF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 36
INDIRF4
ASGNF4
line 253
;253:	angles[PITCH] = 0; 
ADDRLP4 12
CNSTF4 0
ASGNF4
line 254
;254:	angles[ROLL] = 0;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 255
;255:}
LABELV $127
endproc LookAtKiller 52 4
export GibEntity
proc GibEntity 12 12
line 262
;256:
;257:/*
;258:==================
;259:GibEntity
;260:==================
;261:*/
;262:void GibEntity( gentity_t *self, int killer ) {
line 267
;263:	gentity_t *ent;
;264:	int i;
;265:
;266:	//if this entity still has kamikaze
;267:	if (self->s.eFlags & EF_KAMIKAZE) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $139
line 269
;268:		// check if there is a kamikaze timer around for this owner
;269:		for (i = 0; i < MAX_GENTITIES; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $141
line 270
;270:			ent = &g_entities[i];
ADDRLP4 0
CNSTI4 896
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 271
;271:			if (!ent->inuse)
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $145
line 272
;272:				continue;
ADDRGP4 $142
JUMPV
LABELV $145
line 273
;273:			if (ent->activator != self)
ADDRLP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $147
line 274
;274:				continue;
ADDRGP4 $142
JUMPV
LABELV $147
line 275
;275:			if (strcmp(ent->classname, "kamikaze timer"))
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $151
ARGP4
ADDRLP4 8
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $149
line 276
;276:				continue;
ADDRGP4 $142
JUMPV
LABELV $149
line 277
;277:			G_FreeEntity(ent);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 278
;278:			break;
ADDRGP4 $143
JUMPV
LABELV $142
line 269
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1024
LTI4 $141
LABELV $143
line 280
;279:		}
;280:	}
LABELV $139
line 281
;281:	G_AddEvent( self, EV_GIB_PLAYER, killer );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 282
;282:	self->takedamage = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 0
ASGNI4
line 283
;283:	self->s.eType = ET_INVISIBLE;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 10
ASGNI4
line 284
;284:	self->r.contents = 0;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 285
;285:}
LABELV $138
endproc GibEntity 12 12
export body_die
proc body_die 0 8
line 292
;286:
;287:/*
;288:==================
;289:body_die
;290:==================
;291:*/
;292:void body_die( gentity_t *self, gentity_t *inflictor, gentity_t *attacker, int damage, int meansOfDeath ) {
line 293
;293:	if ( self->health > GIB_HEALTH ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 -40
LEI4 $153
line 294
;294:		return;
ADDRGP4 $152
JUMPV
LABELV $153
line 296
;295:	}
;296:	if ( !g_blood.integer ) {
ADDRGP4 g_blood+12
INDIRI4
CNSTI4 0
NEI4 $155
line 297
;297:		self->health = GIB_HEALTH+1;
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
CNSTI4 -39
ASGNI4
line 298
;298:		return;
ADDRGP4 $152
JUMPV
LABELV $155
line 301
;299:	}
;300:
;301:	GibEntity( self, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 GibEntity
CALLV
pop
line 302
;302:}
LABELV $152
endproc body_die 0 8
data
export modNames
align 4
LABELV modNames
address $158
address $159
address $160
address $161
address $162
address $163
address $164
address $165
address $166
address $167
address $168
address $169
address $170
address $171
address $172
address $173
address $174
address $175
address $176
address $177
address $178
address $179
address $180
address $181
export CheckAlmostCapture
code
proc CheckAlmostCapture 56 12
line 376
;303:
;304:
;305:// these are just for logging, the client prints its own messages
;306:char	*modNames[] = {
;307:	"MOD_UNKNOWN",
;308:	"MOD_SHOTGUN",
;309:	"MOD_GAUNTLET",
;310:	"MOD_MACHINEGUN",
;311:	"MOD_GRENADE",
;312:	"MOD_GRENADE_SPLASH",
;313:	"MOD_ROCKET",
;314:	"MOD_ROCKET_SPLASH",
;315:	"MOD_PLASMA",
;316:	"MOD_PLASMA_SPLASH",
;317:	"MOD_RAILGUN",
;318:	"MOD_LIGHTNING",
;319:	"MOD_BFG",
;320:	"MOD_BFG_SPLASH",
;321:	"MOD_WATER",
;322:	"MOD_SLIME",
;323:	"MOD_LAVA",
;324:	"MOD_CRUSH",
;325:	"MOD_TELEFRAG",
;326:	"MOD_FALLING",
;327:	"MOD_SUICIDE",
;328:	"MOD_TARGET_LASER",
;329:	"MOD_TRIGGER_HURT",
;330:#ifdef MISSIONPACK
;331:	"MOD_NAIL",
;332:	"MOD_CHAINGUN",
;333:	"MOD_PROXIMITY_MINE",
;334:	"MOD_KAMIKAZE",
;335:	"MOD_JUICED",
;336:#endif
;337:	"MOD_GRAPPLE"
;338:};
;339:
;340:#ifdef MISSIONPACK
;341:/*
;342:==================
;343:Kamikaze_DeathActivate
;344:==================
;345:*/
;346:void Kamikaze_DeathActivate( gentity_t *ent ) {
;347:	G_StartKamikaze(ent);
;348:	G_FreeEntity(ent);
;349:}
;350:
;351:/*
;352:==================
;353:Kamikaze_DeathTimer
;354:==================
;355:*/
;356:void Kamikaze_DeathTimer( gentity_t *self ) {
;357:	gentity_t *ent;
;358:
;359:	ent = G_Spawn();
;360:	ent->classname = "kamikaze timer";
;361:	VectorCopy(self->s.pos.trBase, ent->s.pos.trBase);
;362:	ent->r.svFlags |= SVF_NOCLIENT;
;363:	ent->think = Kamikaze_DeathActivate;
;364:	ent->nextthink = level.time + 5 * 1000;
;365:
;366:	ent->activator = self;
;367:}
;368:
;369:#endif
;370:
;371:/*
;372:==================
;373:CheckAlmostCapture
;374:==================
;375:*/
;376:void CheckAlmostCapture( gentity_t *self, gentity_t *attacker ) {
line 382
;377:	gentity_t	*ent;
;378:	vec3_t		dir;
;379:	char		*classname;
;380:
;381:	// if this player was carrying a flag
;382:	if ( self->client->ps.powerups[PW_REDFLAG] ||
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRLP4 20
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $186
ADDRLP4 20
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $186
ADDRLP4 20
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $183
LABELV $186
line 384
;383:		self->client->ps.powerups[PW_BLUEFLAG] ||
;384:		self->client->ps.powerups[PW_NEUTRALFLAG] ) {
line 386
;385:		// get the goal flag this player should have been going for
;386:		if ( g_gametype.integer == GT_CTF ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $187
line 387
;387:			if ( self->client->sess.sessionTeam == TEAM_BLUE ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
CNSTI4 2
NEI4 $190
line 388
;388:				classname = "team_CTF_blueflag";
ADDRLP4 4
ADDRGP4 $192
ASGNP4
line 389
;389:			}
ADDRGP4 $188
JUMPV
LABELV $190
line 390
;390:			else {
line 391
;391:				classname = "team_CTF_redflag";
ADDRLP4 4
ADDRGP4 $193
ASGNP4
line 392
;392:			}
line 393
;393:		}
ADDRGP4 $188
JUMPV
LABELV $187
line 394
;394:		else {
line 395
;395:			if ( self->client->sess.sessionTeam == TEAM_BLUE ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
CNSTI4 2
NEI4 $194
line 396
;396:				classname = "team_CTF_redflag";
ADDRLP4 4
ADDRGP4 $193
ASGNP4
line 397
;397:			}
ADDRGP4 $195
JUMPV
LABELV $194
line 398
;398:			else {
line 399
;399:				classname = "team_CTF_blueflag";
ADDRLP4 4
ADDRGP4 $192
ASGNP4
line 400
;400:			}
LABELV $195
line 401
;401:		}
LABELV $188
line 402
;402:		ent = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
LABELV $196
line 404
;403:		do
;404:		{
line 405
;405:			ent = G_Find(ent, FOFS(classname), classname);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
line 406
;406:		} while (ent && (ent->flags & FL_DROPPED_ITEM));
LABELV $197
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $199
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $196
LABELV $199
line 408
;407:		// if we found the destination flag and it's not picked up
;408:		if (ent && !(ent->r.svFlags & SVF_NOCLIENT) ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $200
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $200
line 410
;409:			// if the player was *very* close
;410:			VectorSubtract( self->client->ps.origin, ent->s.origin, dir );
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
ASGNP4
ADDRLP4 8
ADDRLP4 36
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+4
ADDRLP4 36
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 411
;411:			if ( VectorLength(dir) < 200 ) {
ADDRLP4 8
ARGP4
ADDRLP4 44
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 44
INDIRF4
CNSTF4 1128792064
GEF4 $204
line 412
;412:				self->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_HOLYSHIT;
ADDRLP4 48
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 268
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 413
;413:				if ( attacker->client ) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $206
line 414
;414:					attacker->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_HOLYSHIT;
ADDRLP4 52
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 268
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 415
;415:				}
LABELV $206
line 416
;416:			}
LABELV $204
line 417
;417:		}
LABELV $200
line 418
;418:	}
LABELV $183
line 419
;419:}
LABELV $182
endproc CheckAlmostCapture 56 12
export CheckAlmostScored
proc CheckAlmostScored 44 12
line 426
;420:
;421:/*
;422:==================
;423:CheckAlmostScored
;424:==================
;425:*/
;426:void CheckAlmostScored( gentity_t *self, gentity_t *attacker ) {
line 432
;427:	gentity_t	*ent;
;428:	vec3_t		dir;
;429:	char		*classname;
;430:
;431:	// if the player was carrying cubes
;432:	if ( self->client->ps.generic1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
CNSTI4 0
EQI4 $209
line 433
;433:		if ( self->client->sess.sessionTeam == TEAM_BLUE ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
CNSTI4 2
NEI4 $211
line 434
;434:			classname = "team_redobelisk";
ADDRLP4 16
ADDRGP4 $213
ASGNP4
line 435
;435:		}
ADDRGP4 $212
JUMPV
LABELV $211
line 436
;436:		else {
line 437
;437:			classname = "team_blueobelisk";
ADDRLP4 16
ADDRGP4 $214
ASGNP4
line 438
;438:		}
LABELV $212
line 439
;439:		ent = G_Find(NULL, FOFS(classname), classname);
CNSTP4 0
ARGP4
CNSTI4 524
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 441
;440:		// if we found the destination obelisk
;441:		if ( ent ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $215
line 443
;442:			// if the player was *very* close
;443:			VectorSubtract( self->client->ps.origin, ent->s.origin, dir );
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
ASGNP4
ADDRLP4 28
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 24
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 444
;444:			if ( VectorLength(dir) < 200 ) {
ADDRLP4 4
ARGP4
ADDRLP4 32
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 32
INDIRF4
CNSTF4 1128792064
GEF4 $219
line 445
;445:				self->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_HOLYSHIT;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 268
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 446
;446:				if ( attacker->client ) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $221
line 447
;447:					attacker->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_HOLYSHIT;
ADDRLP4 40
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 268
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 448
;448:				}
LABELV $221
line 449
;449:			}
LABELV $219
line 450
;450:		}
LABELV $215
line 451
;451:	}
LABELV $209
line 452
;452:}
LABELV $208
endproc CheckAlmostScored 44 12
bss
align 4
LABELV $334
skip 4
export player_die
code
proc player_die 116 28
line 459
;453:
;454:/*
;455:==================
;456:player_die
;457:==================
;458:*/
;459:void player_die( gentity_t *self, gentity_t *inflictor, gentity_t *attacker, int damage, int meansOfDeath ) {
line 467
;460:	gentity_t	*ent;
;461:	int			anim;
;462:	int			contents;
;463:	int			killer;
;464:	int			i;
;465:	char		*killerName, *obit;
;466:
;467:	if ( self->client->ps.pm_type == PM_DEAD ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $224
line 468
;468:		return;
ADDRGP4 $223
JUMPV
LABELV $224
line 471
;469:	}
;470:
;471:	if ( level.intermissiontime ) {
ADDRGP4 level+9160
INDIRI4
CNSTI4 0
EQI4 $226
line 472
;472:		return;
ADDRGP4 $223
JUMPV
LABELV $226
line 477
;473:	}
;474:
;475://unlagged - backward reconciliation #2
;476:	// make sure the body shows up in the client's current position
;477:	G_UnTimeShiftClient( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_UnTimeShiftClient
CALLV
pop
line 481
;478://unlagged - backward reconciliation #2
;479:
;480:	// check for an almost capture
;481:	CheckAlmostCapture( self, attacker );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 CheckAlmostCapture
CALLV
pop
line 483
;482:	// check for a player that almost brought in cubes
;483:	CheckAlmostScored( self, attacker );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 CheckAlmostScored
CALLV
pop
line 485
;484:
;485:	if (self->client && self->client->hook) {
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 32
CNSTU4 0
ASGNU4
ADDRLP4 28
INDIRP4
CVPU4 4
ADDRLP4 32
INDIRU4
EQU4 $229
ADDRLP4 28
INDIRP4
CNSTI4 10364
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 32
INDIRU4
EQU4 $229
line 486
;486:		Weapon_HookFree(self->client->hook);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10364
ADDP4
INDIRP4
ARGP4
ADDRGP4 Weapon_HookFree
CALLV
pop
line 487
;487:	}
LABELV $229
line 495
;488:#ifdef MISSIONPACK
;489:	if ((self->client->ps.eFlags & EF_TICKING) && self->activator) {
;490:		self->client->ps.eFlags &= ~EF_TICKING;
;491:		self->activator->think = G_FreeEntity;
;492:		self->activator->nextthink = level.time;
;493:	}
;494:#endif
;495:	self->client->ps.pm_type = PM_DEAD;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 3
ASGNI4
line 497
;496:
;497:	if ( attacker ) {
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $231
line 498
;498:		killer = attacker->s.number;
ADDRLP4 4
ADDRFP4 8
INDIRP4
INDIRI4
ASGNI4
line 499
;499:		if ( attacker->client ) {
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $233
line 500
;500:			killerName = attacker->client->pers.netname;
ADDRLP4 36
CNSTI4 516
ASGNI4
ADDRLP4 16
ADDRFP4 8
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ASGNP4
line 501
;501:		} else {
ADDRGP4 $232
JUMPV
LABELV $233
line 502
;502:			killerName = "<non-client>";
ADDRLP4 16
ADDRGP4 $235
ASGNP4
line 503
;503:		}
line 504
;504:	} else {
ADDRGP4 $232
JUMPV
LABELV $231
line 505
;505:		killer = ENTITYNUM_WORLD;
ADDRLP4 4
CNSTI4 1022
ASGNI4
line 506
;506:		killerName = "<world>";
ADDRLP4 16
ADDRGP4 $236
ASGNP4
line 507
;507:	}
LABELV $232
line 509
;508:
;509:	if ( killer < 0 || killer >= MAX_CLIENTS ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $239
ADDRLP4 4
INDIRI4
CNSTI4 64
LTI4 $237
LABELV $239
line 510
;510:		killer = ENTITYNUM_WORLD;
ADDRLP4 4
CNSTI4 1022
ASGNI4
line 511
;511:		killerName = "<world>";
ADDRLP4 16
ADDRGP4 $236
ASGNP4
line 512
;512:	}
LABELV $237
line 514
;513:
;514:	if ( meansOfDeath < 0 || meansOfDeath >= sizeof( modNames ) / sizeof( modNames[0] ) ) {
ADDRLP4 40
ADDRFP4 16
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
LTI4 $242
ADDRLP4 40
INDIRI4
CVIU4 4
CNSTU4 24
LTU4 $240
LABELV $242
line 515
;515:		obit = "<bad obituary>";
ADDRLP4 20
ADDRGP4 $243
ASGNP4
line 516
;516:	} else {
ADDRGP4 $241
JUMPV
LABELV $240
line 517
;517:		obit = modNames[ meansOfDeath ];
ADDRLP4 20
ADDRFP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 modNames
ADDP4
INDIRP4
ASGNP4
line 518
;518:	}
LABELV $241
line 520
;519:
;520:	G_LogPrintf("Kill: %i %i %i: %s killed %s by %s\n", 
ADDRGP4 $244
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 48
CNSTI4 516
ASGNI4
ADDRLP4 44
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 525
;521:		killer, self->s.number, meansOfDeath, killerName, 
;522:		self->client->pers.netname, obit );
;523:
;524:	// broadcast the death event to everyone
;525:	ent = G_TempEntity( self->r.currentOrigin, EV_OBITUARY );
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 60
ARGI4
ADDRLP4 52
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 52
INDIRP4
ASGNP4
line 526
;526:	ent->s.eventParm = meansOfDeath;
ADDRLP4 8
INDIRP4
CNSTI4 184
ADDP4
ADDRFP4 16
INDIRI4
ASGNI4
line 527
;527:	ent->s.otherEntityNum = self->s.number;
ADDRLP4 8
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 528
;528:	ent->s.otherEntityNum2 = killer;
ADDRLP4 8
INDIRP4
CNSTI4 144
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 529
;529:	ent->r.svFlags = SVF_BROADCAST;	// send to everyone
ADDRLP4 8
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 32
ASGNI4
line 531
;530:
;531:	self->enemy = attacker;
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
ADDRFP4 8
INDIRP4
ASGNP4
line 533
;532:
;533:	self->client->ps.persistant[PERS_KILLED]++;
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 280
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 535
;534:
;535:	if (attacker && attacker->client) {
ADDRLP4 60
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 64
CNSTU4 0
ASGNU4
ADDRLP4 60
INDIRP4
CVPU4 4
ADDRLP4 64
INDIRU4
EQU4 $245
ADDRLP4 60
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 64
INDIRU4
EQU4 $245
line 536
;536:		attacker->client->lastkilled_client = self->s.number;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10320
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 538
;537:
;538:		if ( attacker == self || OnSameTeam (self, attacker ) ) {
ADDRLP4 68
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CVPU4 4
ADDRLP4 72
INDIRP4
CVPU4 4
EQU4 $249
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
EQI4 $247
LABELV $249
line 539
;539:			AddScore( attacker, self->r.currentOrigin, -1 );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 540
;540:		} else {
ADDRGP4 $246
JUMPV
LABELV $247
line 543
;541:			//Stats
;542:			//Weapon frags, total frags, and FPH use this.
;543:			if ( meansOfDeath == MOD_MACHINEGUN ) {
ADDRFP4 16
INDIRI4
CNSTI4 3
NEI4 $250
line 544
;544:				++attacker->client->pers.stats_frags[WP_MACHINEGUN];
ADDRLP4 80
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10004
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
line 545
;545:			} else if ( meansOfDeath == MOD_SHOTGUN ) {
ADDRGP4 $251
JUMPV
LABELV $250
ADDRFP4 16
INDIRI4
CNSTI4 1
NEI4 $252
line 546
;546:				++attacker->client->pers.stats_frags[WP_SHOTGUN];
ADDRLP4 80
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10008
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
line 547
;547:			} else if ( meansOfDeath == MOD_GRENADE || meansOfDeath == MOD_GRENADE_SPLASH ) {
ADDRGP4 $253
JUMPV
LABELV $252
ADDRLP4 80
ADDRFP4 16
INDIRI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 4
EQI4 $256
ADDRLP4 80
INDIRI4
CNSTI4 5
NEI4 $254
LABELV $256
line 548
;548:				++attacker->client->pers.stats_frags[WP_GRENADE_LAUNCHER];
ADDRLP4 84
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10012
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
line 549
;549:			} else if ( meansOfDeath == MOD_ROCKET || meansOfDeath == MOD_ROCKET_SPLASH ) {
ADDRGP4 $255
JUMPV
LABELV $254
ADDRLP4 84
ADDRFP4 16
INDIRI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 6
EQI4 $259
ADDRLP4 84
INDIRI4
CNSTI4 7
NEI4 $257
LABELV $259
line 550
;550:				++attacker->client->pers.stats_frags[WP_ROCKET_LAUNCHER];
ADDRLP4 88
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10016
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
line 551
;551:			} else if ( meansOfDeath == MOD_PLASMA || meansOfDeath == MOD_PLASMA_SPLASH ) {
ADDRGP4 $258
JUMPV
LABELV $257
ADDRLP4 88
ADDRFP4 16
INDIRI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 8
EQI4 $262
ADDRLP4 88
INDIRI4
CNSTI4 9
NEI4 $260
LABELV $262
line 552
;552:				++attacker->client->pers.stats_frags[WP_PLASMAGUN];
ADDRLP4 92
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10028
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
line 553
;553:			} else if ( meansOfDeath == MOD_LIGHTNING ) {
ADDRGP4 $261
JUMPV
LABELV $260
ADDRFP4 16
INDIRI4
CNSTI4 11
NEI4 $263
line 554
;554:				++attacker->client->pers.stats_frags[WP_LIGHTNING];
ADDRLP4 92
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10020
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
line 555
;555:			} else if ( meansOfDeath == MOD_RAILGUN ) {
ADDRGP4 $264
JUMPV
LABELV $263
ADDRFP4 16
INDIRI4
CNSTI4 10
NEI4 $265
line 556
;556:				++attacker->client->pers.stats_frags[WP_RAILGUN];
ADDRLP4 92
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10024
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
line 557
;557:			} else if ( meansOfDeath == MOD_BFG || meansOfDeath == MOD_BFG_SPLASH ) {
ADDRGP4 $266
JUMPV
LABELV $265
ADDRLP4 92
ADDRFP4 16
INDIRI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 12
EQI4 $269
ADDRLP4 92
INDIRI4
CNSTI4 13
NEI4 $267
LABELV $269
line 558
;558:				++attacker->client->pers.stats_frags[WP_BFG];
ADDRLP4 96
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10032
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
line 559
;559:			}
LABELV $267
LABELV $266
LABELV $264
LABELV $261
LABELV $258
LABELV $255
LABELV $253
LABELV $251
line 560
;560:			AddScore( attacker, self->r.currentOrigin, 1 );
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
line 562
;561:
;562:			if( meansOfDeath == MOD_GAUNTLET ) {
ADDRFP4 16
INDIRI4
CNSTI4 2
NEI4 $270
line 563
;563:				++attacker->client->pers.stats_frags[WP_GAUNTLET];
ADDRLP4 96
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10000
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
line 566
;564:				
;565:				// play humiliation on player
;566:				attacker->client->ps.persistant[PERS_GAUNTLET_FRAG_COUNT]++;
ADDRLP4 100
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 300
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
line 569
;567:
;568:				// add the sprite over the player's head
;569:				attacker->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
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
line 570
;570:				attacker->client->ps.eFlags |= EF_AWARD_GAUNTLET;
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
CNSTI4 64
BORI4
ASGNI4
line 571
;571:				attacker->client->rewardTime = level.time + REWARD_SPRITE_TIME;
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
line 574
;572:
;573:				// also play humiliation on target
;574:				self->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_GAUNTLETREWARD;
ADDRLP4 112
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 268
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRI4
CNSTI4 2
BXORI4
ASGNI4
line 575
;575:			}
LABELV $270
line 579
;576:
;577:			// check for two kills in a short amount of time
;578:			// if this is close enough to the last kill, give a reward sound
;579:			if ( level.time - attacker->client->lastKillTime < CARNAGE_REWARD_TIME ) {
ADDRGP4 level+40
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10352
ADDP4
INDIRI4
SUBI4
CNSTI4 3000
GEI4 $273
line 581
;580:				// play excellent on player
;581:				attacker->client->ps.persistant[PERS_EXCELLENT_COUNT]++;
ADDRLP4 96
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 288
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
line 584
;582:
;583:				// add the sprite over the player's head
;584:				attacker->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 100
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 585
;585:				attacker->client->ps.eFlags |= EF_AWARD_EXCELLENT;
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
CNSTI4 8
BORI4
ASGNI4
line 586
;586:				attacker->client->rewardTime = level.time + REWARD_SPRITE_TIME;
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
line 587
;587:			}
LABELV $273
line 588
;588:			attacker->client->lastKillTime = level.time;
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10352
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 590
;589:
;590:		}
line 591
;591:	} else {
ADDRGP4 $246
JUMPV
LABELV $245
line 592
;592:		AddScore( self, self->r.currentOrigin, -1 );
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 593
;593:	}
LABELV $246
line 596
;594:
;595:	// Add team bonuses
;596:	Team_FragBonuses(self, inflictor, attacker);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Team_FragBonuses
CALLV
pop
line 599
;597:
;598:	// if I committed suicide, the flag does not fall, it returns.
;599:	if (meansOfDeath == MOD_SUICIDE && g_returnFlag.integer == 0 && g_flagSacrifice.integer == 0) {
ADDRFP4 16
INDIRI4
CNSTI4 20
NEI4 $278
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRGP4 g_returnFlag+12
INDIRI4
ADDRLP4 68
INDIRI4
NEI4 $278
ADDRGP4 g_flagSacrifice+12
INDIRI4
ADDRLP4 68
INDIRI4
NEI4 $278
line 600
;600:		if ( self->client->ps.powerups[PW_NEUTRALFLAG] ) {		// only happens in One Flag CTF
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $282
line 601
;601:			Team_ReturnFlag( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 602
;602:			self->client->ps.powerups[PW_NEUTRALFLAG] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 348
ADDP4
CNSTI4 0
ASGNI4
line 603
;603:		}
ADDRGP4 $283
JUMPV
LABELV $282
line 604
;604:		else if ( self->client->ps.powerups[PW_REDFLAG] ) {		// only happens in standard CTF
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
EQI4 $284
line 605
;605:			Team_ReturnFlag( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 606
;606:			self->client->ps.powerups[PW_REDFLAG] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 340
ADDP4
CNSTI4 0
ASGNI4
line 607
;607:		}
ADDRGP4 $285
JUMPV
LABELV $284
line 608
;608:		else if ( self->client->ps.powerups[PW_BLUEFLAG] ) {	// only happens in standard CTF
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $286
line 609
;609:			Team_ReturnFlag( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 610
;610:			self->client->ps.powerups[PW_BLUEFLAG] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 344
ADDP4
CNSTI4 0
ASGNI4
line 611
;611:		}
LABELV $286
LABELV $285
LABELV $283
line 625
;612:/*	} else {
;613:		gitem_t		*item;
;614:		//Toss the flag
;615:		//FIXME:forceTossflagOnTeamSwitch We shouldn't need this.
;616:		if ( self->client->ps.powerups[PW_REDFLAG] ) {
;617:			item = BG_FindItemForPowerup( PW_REDFLAG );
;618:			ent->client->ps.powerups[PW_REDFLAG] = 0;
;619:		} else if ( self->client->ps.powerups[PW_BLUEFLAG] ) {
;620:			item = BG_FindItemForPowerup( PW_BLUEFLAG );
;621:			ent->client->ps.powerups[PW_BLUEFLAG] = 0;
;622:		}
;623:
;624:		Drop_Item( ent, item, 0, qtrue );*/
;625:	}
LABELV $278
line 627
;626:
;627:	if( g_flagSacrifice.integer == 0 ) {
ADDRGP4 g_flagSacrifice+12
INDIRI4
CNSTI4 0
NEI4 $288
line 629
;628:		// if client is in a nodrop area, don't drop anything (but return CTF flags!)
;629:		contents = trap_PointContents( self->r.currentOrigin, -1 );
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 72
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 72
INDIRI4
ASGNI4
line 630
;630:		if ( !( contents & CONTENTS_NODROP )) {
ADDRLP4 12
INDIRI4
CVIU4 4
CNSTU4 2147483648
BANDU4
CNSTU4 0
NEU4 $291
line 631
;631:			TossClientItems( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 TossClientItems
CALLV
pop
line 632
;632:		}
ADDRGP4 $289
JUMPV
LABELV $291
line 633
;633:		else {
line 634
;634:			if ( self->client->ps.powerups[PW_NEUTRALFLAG] ) {		// only happens in One Flag CTF
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $293
line 635
;635:				Team_ReturnFlag( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 636
;636:			}
ADDRGP4 $289
JUMPV
LABELV $293
line 637
;637:			else if ( self->client->ps.powerups[PW_REDFLAG] ) {		// only happens in standard CTF
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
EQI4 $295
line 638
;638:				Team_ReturnFlag( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 639
;639:			}
ADDRGP4 $289
JUMPV
LABELV $295
line 640
;640:			else if ( self->client->ps.powerups[PW_BLUEFLAG] ) {	// only happens in standard CTF
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $289
line 641
;641:				Team_ReturnFlag( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 642
;642:			}
line 643
;643:		}
line 644
;644:	} else {
ADDRGP4 $289
JUMPV
LABELV $288
line 645
;645:		TossClientItems(self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 TossClientItems
CALLV
pop
line 646
;646:	}
LABELV $289
line 647
;647:	contents = trap_PointContents( self->r.currentOrigin, -1 );
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 72
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 72
INDIRI4
ASGNI4
line 655
;648:#ifdef MISSIONPACK
;649:	TossClientPersistantPowerups( self );
;650:	if( g_gametype.integer == GT_HARVESTER ) {
;651:		TossClientCubes( self );
;652:	}
;653:#endif
;654:
;655:	Cmd_Score_f( self );		// show scores
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Cmd_Score_f
CALLV
pop
line 658
;656:	// send updated scores to any clients that are following this one,
;657:	// or they would get stale scoreboards
;658:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $302
JUMPV
LABELV $299
line 661
;659:		gclient_t	*client;
;660:
;661:		client = &level.clients[i];
ADDRLP4 76
CNSTI4 10828
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 662
;662:		if ( client->pers.connected != CON_CONNECTED ) {
ADDRLP4 76
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $304
line 663
;663:			continue;
ADDRGP4 $300
JUMPV
LABELV $304
line 668
;664:		}
;665:/*freeze
;666:		if ( client->sess.sessionTeam != TEAM_SPECTATOR ) {
;667:freeze*/
;668:		if ( (g_gamemode.integer > 3 && !is_spectator( client )) || 
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $311
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 is_spectator
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
EQI4 $310
LABELV $311
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 4
GEI4 $306
ADDRLP4 76
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
CNSTI4 3
EQI4 $306
LABELV $310
line 669
;669:			(g_gamemode.integer < 4 && client->sess.sessionTeam != TEAM_SPECTATOR) ) {
line 671
;670://freeze
;671:			continue;
ADDRGP4 $300
JUMPV
LABELV $306
line 673
;672:		}
;673:		if ( client->sess.spectatorClient == self->s.number ) {
ADDRLP4 76
INDIRP4
CNSTI4 10200
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
INDIRI4
NEI4 $312
line 674
;674:			Cmd_Score_f( g_entities + i );
CNSTI4 896
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRGP4 Cmd_Score_f
CALLV
pop
line 675
;675:		}
LABELV $312
line 676
;676:	}
LABELV $300
line 658
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $302
ADDRLP4 0
INDIRI4
ADDRGP4 level+28
INDIRI4
LTI4 $299
line 678
;677:
;678:	self->takedamage = qtrue;	// can still be gibbed
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 1
ASGNI4
line 680
;679:
;680:	self->s.weapon = WP_NONE;
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 0
ASGNI4
line 681
;681:	self->s.powerups = 0;
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTI4 0
ASGNI4
line 682
;682:	self->r.contents = CONTENTS_CORPSE;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 67108864
ASGNI4
line 684
;683:
;684:	self->s.angles[0] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
CNSTF4 0
ASGNF4
line 685
;685:	self->s.angles[2] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
CNSTF4 0
ASGNF4
line 686
;686:	LookAtKiller (self, inflictor, attacker);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 LookAtKiller
CALLV
pop
line 688
;687:
;688:	VectorCopy( self->s.angles, self->client->ps.viewangles );
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 152
ADDP4
ADDRLP4 76
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 690
;689:
;690:	self->s.loopSound = 0;
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
CNSTI4 0
ASGNI4
line 692
;691:
;692:	self->timeOfDeath = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 880
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 695
;693:
;694:/*freeze*/
;695:	if ( g_gamemode.integer < 4 ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 4
GEI4 $315
line 696
;696:		self->r.maxs[2] = -8;
ADDRFP4 0
INDIRP4
CNSTI4 456
ADDP4
CNSTF4 3238002688
ASGNF4
line 697
;697:	}
LABELV $315
line 702
;698:/*freeze*/
;699:
;700:	// don't allow respawn until the death anim is done
;701:	// g_forcerespawn may force spawning at some later time
;702:	if ( g_fastRespawn.integer == 1 && !self->client->pers.fastRespawn ) {
ADDRGP4 g_fastRespawn+12
INDIRI4
CNSTI4 1
NEI4 $318
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
CNSTI4 0
NEI4 $318
line 703
;703:		self->client->respawnTime = level.time + 500;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10332
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 705
;704:		//self->client->respawnTime = level.time + cpm_clientrespawndelay; // CPM
;705:	} else {
ADDRGP4 $319
JUMPV
LABELV $318
line 706
;706:		self->client->respawnTime = level.time + 1700;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10332
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 1700
ADDI4
ASGNI4
line 707
;707:	}
LABELV $319
line 710
;708:
;709:	// remove powerups
;710:	memset( self->client->ps.powerups, 0, sizeof(self->client->ps.powerups) );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 713
;711:
;712://freeze
;713:	if ( g_gamemode.integer > 3 ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $323
line 714
;714:		player_freeze( self, attacker, meansOfDeath );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 player_freeze
CALLV
pop
line 715
;715:		if ( self->freezeState ) {
ADDRFP4 0
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 0
EQI4 $326
line 716
;716:			G_AddEvent( self, EV_DEATH1 + ( rand() % 3 ), killer );
ADDRLP4 80
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 80
INDIRI4
CNSTI4 3
MODI4
CNSTI4 57
ADDI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 717
;717:			trap_LinkEntity( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 718
;718:			return;
ADDRGP4 $223
JUMPV
LABELV $326
line 720
;719:		}
;720:		self->r.maxs[ 2 ] = -8;
ADDRFP4 0
INDIRP4
CNSTI4 456
ADDP4
CNSTF4 3238002688
ASGNF4
line 721
;721:	}
LABELV $323
line 724
;722://freeze
;723:	// never gib in a nodrop
;724:	if ( (self->health <= GIB_HEALTH && !(contents & CONTENTS_NODROP) && g_blood.integer) || meansOfDeath == MOD_SUICIDE) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 -40
GTI4 $333
ADDRLP4 12
INDIRI4
CVIU4 4
CNSTU4 2147483648
BANDU4
CNSTU4 0
NEU4 $333
ADDRGP4 g_blood+12
INDIRI4
CNSTI4 0
NEI4 $331
LABELV $333
ADDRFP4 16
INDIRI4
CNSTI4 20
NEI4 $328
LABELV $331
line 726
;725:		// gib death
;726:		GibEntity( self, killer );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 GibEntity
CALLV
pop
line 727
;727:	} else {
ADDRGP4 $329
JUMPV
LABELV $328
line 731
;728:		// normal death
;729:		static int i;
;730:
;731:		switch ( i ) {
ADDRLP4 80
ADDRGP4 $334
INDIRI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
EQI4 $337
ADDRLP4 80
INDIRI4
CNSTI4 1
EQI4 $338
ADDRLP4 80
INDIRI4
CNSTI4 2
EQI4 $339
ADDRGP4 $335
JUMPV
LABELV $337
line 733
;732:		case 0:
;733:			anim = BOTH_DEATH1;
ADDRLP4 24
CNSTI4 0
ASGNI4
line 734
;734:			break;
ADDRGP4 $336
JUMPV
LABELV $338
line 736
;735:		case 1:
;736:			anim = BOTH_DEATH2;
ADDRLP4 24
CNSTI4 2
ASGNI4
line 737
;737:			break;
ADDRGP4 $336
JUMPV
LABELV $339
LABELV $335
line 740
;738:		case 2:
;739:		default:
;740:			anim = BOTH_DEATH3;
ADDRLP4 24
CNSTI4 4
ASGNI4
line 741
;741:			break;
LABELV $336
line 746
;742:		}
;743:
;744:		// for the no-blood option, we need to prevent the health
;745:		// from going to gib level
;746:		if ( self->health <= GIB_HEALTH ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 -40
GTI4 $340
line 747
;747:			self->health = GIB_HEALTH+1;
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
CNSTI4 -39
ASGNI4
line 748
;748:		}
LABELV $340
line 750
;749:
;750:		self->client->ps.legsAnim = 
ADDRLP4 84
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 76
ADDP4
ASGNP4
ADDRLP4 88
CNSTI4 128
ASGNI4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
ADDRLP4 88
INDIRI4
BANDI4
ADDRLP4 88
INDIRI4
BXORI4
ADDRLP4 24
INDIRI4
BORI4
ASGNI4
line 752
;751:			( ( self->client->ps.legsAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT ) | anim;
;752:		self->client->ps.torsoAnim = 
ADDRLP4 92
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 84
ADDP4
ASGNP4
ADDRLP4 96
CNSTI4 128
ASGNI4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRI4
ADDRLP4 96
INDIRI4
BANDI4
ADDRLP4 96
INDIRI4
BXORI4
ADDRLP4 24
INDIRI4
BORI4
ASGNI4
line 755
;753:			( ( self->client->ps.torsoAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT ) | anim;
;754:
;755:		G_AddEvent( self, EV_DEATH1 + i, killer );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $334
INDIRI4
CNSTI4 57
ADDI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 758
;756:
;757:		// the body can still be gibbed
;758:		self->die = body_die;
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ADDRGP4 body_die
ASGNP4
line 761
;759:
;760:		// globally cycle through the different death animations
;761:		i = ( i + 1 ) % 3;
ADDRLP4 100
ADDRGP4 $334
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 3
MODI4
ASGNI4
line 768
;762:
;763:#ifdef MISSIONPACK
;764:		if (self->s.eFlags & EF_KAMIKAZE) {
;765:			Kamikaze_DeathTimer( self );
;766:		}
;767:#endif
;768:	}
LABELV $329
line 770
;769:
;770:	trap_LinkEntity (self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 772
;771:
;772:}
LABELV $223
endproc player_die 116 28
export CheckArmor
proc CheckArmor 32 4
line 781
;773:
;774:
;775:/*
;776:================
;777:CheckArmor
;778:================
;779:*/
;780:int CheckArmor (gentity_t *ent, int damage, int dflags)
;781:{
line 787
;782:	gclient_t	*client;
;783:	int			save;
;784:	int			count;
;785:	float		type; // CPM
;786:
;787:	if (!damage)
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $343
line 788
;788:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $342
JUMPV
LABELV $343
line 790
;789:
;790:	client = ent->client;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 792
;791:
;792:	if (!client)
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $345
line 793
;793:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $342
JUMPV
LABELV $345
line 795
;794:
;795:	if (dflags & DAMAGE_NO_ARMOR)
ADDRFP4 8
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $347
line 796
;796:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $342
JUMPV
LABELV $347
line 799
;797:
;798:	// armor
;799:	count = client->ps.stats[STAT_ARMOR];
ADDRLP4 8
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
line 800
;800:	type = g_pro_mode.integer ? ( (client->ps.stats[STAT_ARMORTYPE] <= 1) ?
ADDRGP4 g_pro_mode+12
INDIRI4
CNSTI4 0
EQI4 $352
ADDRLP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CNSTI4 1
GTI4 $354
ADDRLP4 20
CNSTF4 1058642330
ASGNF4
ADDRGP4 $355
JUMPV
LABELV $354
ADDRLP4 20
CNSTF4 1061158912
ASGNF4
LABELV $355
ADDRLP4 16
ADDRLP4 20
INDIRF4
ASGNF4
ADDRGP4 $353
JUMPV
LABELV $352
ADDRLP4 16
CNSTF4 1059648963
ASGNF4
LABELV $353
ADDRLP4 12
ADDRLP4 16
INDIRF4
ASGNF4
line 803
;801:		CPM_YAPROTECTION : CPM_RAPROTECTION) : ARMOR_PROTECTION; // CPM
;802:	//save = ceil( damage * ARMOR_PROTECTION );
;803:	save = ceil( damage * type ); // CPM
ADDRFP4 4
INDIRI4
CVIF4 4
ADDRLP4 12
INDIRF4
MULF4
ARGF4
ADDRLP4 24
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 24
INDIRF4
CVFI4 4
ASGNI4
line 804
;804:	if (save >= count)
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $356
line 805
;805:		save = count;
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
LABELV $356
line 807
;806:
;807:	if (!save)
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $358
line 808
;808:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $342
JUMPV
LABELV $358
line 810
;809:
;810:	client->ps.stats[STAT_ARMOR] -= save;
ADDRLP4 28
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
ASGNI4
line 812
;811:
;812:	return save;
ADDRLP4 0
INDIRI4
RETI4
LABELV $342
endproc CheckArmor 32 4
export RaySphereIntersections
proc RaySphereIntersections 96 4
line 820
;813:}
;814:
;815:/*
;816:================
;817:RaySphereIntersections
;818:================
;819:*/
;820:int RaySphereIntersections( vec3_t origin, float radius, vec3_t point, vec3_t dir, vec3_t intersections[2] ) {
line 829
;821:	float b, c, d, t;
;822:
;823:	//	| origin - (point + t * dir) | = radius
;824:	//	a = dir[0]^2 + dir[1]^2 + dir[2]^2;
;825:	//	b = 2 * (dir[0] * (point[0] - origin[0]) + dir[1] * (point[1] - origin[1]) + dir[2] * (point[2] - origin[2]));
;826:	//	c = (point[0] - origin[0])^2 + (point[1] - origin[1])^2 + (point[2] - origin[2])^2 - radius^2;
;827:
;828:	// normalize dir so a = 1
;829:	VectorNormalize(dir);
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 830
;830:	b = 2 * (dir[0] * (point[0] - origin[0]) + dir[1] * (point[1] - origin[1]) + dir[2] * (point[2] - origin[2]));
ADDRLP4 16
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 20
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
CNSTI4 4
ASGNI4
ADDRLP4 32
CNSTI4 8
ASGNI4
ADDRLP4 4
CNSTF4 1073741824
ADDRLP4 16
INDIRP4
INDIRF4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 24
INDIRP4
INDIRF4
SUBF4
MULF4
ADDRLP4 16
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
SUBF4
MULF4
ADDF4
ADDRLP4 16
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
SUBF4
MULF4
ADDF4
MULF4
ASGNF4
line 831
;831:	c = (point[0] - origin[0]) * (point[0] - origin[0]) +
ADDRLP4 36
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
ADDRLP4 36
INDIRP4
INDIRF4
ADDRLP4 40
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 48
CNSTI4 4
ASGNI4
ADDRLP4 52
ADDRLP4 36
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 56
CNSTI4 8
ASGNI4
ADDRLP4 60
ADDRLP4 36
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 64
ADDRFP4 4
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 44
INDIRF4
ADDRLP4 44
INDIRF4
MULF4
ADDRLP4 52
INDIRF4
ADDRLP4 52
INDIRF4
MULF4
ADDF4
ADDRLP4 60
INDIRF4
ADDRLP4 60
INDIRF4
MULF4
ADDF4
ADDRLP4 64
INDIRF4
ADDRLP4 64
INDIRF4
MULF4
SUBF4
ASGNF4
line 836
;832:		(point[1] - origin[1]) * (point[1] - origin[1]) +
;833:		(point[2] - origin[2]) * (point[2] - origin[2]) -
;834:		radius * radius;
;835:
;836:	d = b * b - 4 * c;
ADDRLP4 8
ADDRLP4 4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
CNSTF4 1082130432
ADDRLP4 12
INDIRF4
MULF4
SUBF4
ASGNF4
line 837
;837:	if (d > 0) {
ADDRLP4 8
INDIRF4
CNSTF4 0
LEF4 $361
line 838
;838:		t = (- b + sqrt(d)) / 2;
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 72
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
NEGF4
ADDRLP4 72
INDIRF4
ADDF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 839
;839:		VectorMA(point, t, dir, intersections[0]);
ADDRFP4 16
INDIRP4
ADDRFP4 8
INDIRP4
INDIRF4
ADDRFP4 12
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 76
CNSTI4 4
ASGNI4
ADDRFP4 16
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
ADDRFP4 8
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 80
CNSTI4 8
ASGNI4
ADDRFP4 16
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
ADDRFP4 8
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 840
;840:		t = (- b - sqrt(d)) / 2;
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 84
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
NEGF4
ADDRLP4 84
INDIRF4
SUBF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 841
;841:		VectorMA(point, t, dir, intersections[1]);
ADDRFP4 16
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 8
INDIRP4
INDIRF4
ADDRFP4 12
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 88
CNSTI4 4
ASGNI4
ADDRFP4 16
INDIRP4
CNSTI4 16
ADDP4
ADDRFP4 8
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 92
CNSTI4 8
ASGNI4
ADDRFP4 16
INDIRP4
CNSTI4 20
ADDP4
ADDRFP4 8
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 842
;842:		return 2;
CNSTI4 2
RETI4
ADDRGP4 $360
JUMPV
LABELV $361
line 844
;843:	}
;844:	else if (d == 0) {
ADDRLP4 8
INDIRF4
CNSTF4 0
NEF4 $363
line 845
;845:		t = (- b ) / 2;
ADDRLP4 0
ADDRLP4 4
INDIRF4
NEGF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 846
;846:		VectorMA(point, t, dir, intersections[0]);
ADDRFP4 16
INDIRP4
ADDRFP4 8
INDIRP4
INDIRF4
ADDRFP4 12
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 72
CNSTI4 4
ASGNI4
ADDRFP4 16
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
ADDRFP4 8
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 76
CNSTI4 8
ASGNI4
ADDRFP4 16
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
ADDRFP4 8
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 847
;847:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $360
JUMPV
LABELV $363
line 849
;848:	}
;849:	return 0;
CNSTI4 0
RETI4
LABELV $360
endproc RaySphereIntersections 96 4
export G_Damage
proc G_Damage 156 20
line 916
;850:}
;851:
;852:#ifdef MISSIONPACK
;853:/*
;854:================
;855:G_InvulnerabilityEffect
;856:================
;857:*/
;858:int G_InvulnerabilityEffect( gentity_t *targ, vec3_t dir, vec3_t point, vec3_t impactpoint, vec3_t bouncedir ) {
;859:	gentity_t	*impact;
;860:	vec3_t		intersections[2], vec;
;861:	int			n;
;862:
;863:	if ( !targ->client ) {
;864:		return qfalse;
;865:	}
;866:	VectorCopy(dir, vec);
;867:	VectorInverse(vec);
;868:	// sphere model radius = 42 units
;869:	n = RaySphereIntersections( targ->client->ps.origin, 42, point, vec, intersections);
;870:	if (n > 0) {
;871:		impact = G_TempEntity( targ->client->ps.origin, EV_INVUL_IMPACT );
;872:		VectorSubtract(intersections[0], targ->client->ps.origin, vec);
;873:		vectoangles(vec, impact->s.angles);
;874:		impact->s.angles[0] += 90;
;875:		if (impact->s.angles[0] > 360)
;876:			impact->s.angles[0] -= 360;
;877:		if ( impactpoint ) {
;878:			VectorCopy( intersections[0], impactpoint );
;879:		}
;880:		if ( bouncedir ) {
;881:			VectorCopy( vec, bouncedir );
;882:			VectorNormalize( bouncedir );
;883:		}
;884:		return qtrue;
;885:	}
;886:	else {
;887:		return qfalse;
;888:	}
;889:}
;890:#endif
;891:/*
;892:============
;893:T_Damage
;894:
;895:targ		entity that is being damaged
;896:inflictor	entity that is causing the damage
;897:attacker	entity that caused the inflictor to damage targ
;898:	example: targ=monster, inflictor=rocket, attacker=player
;899:
;900:dir			direction of the attack for knockback
;901:point		point at which the damage is being inflicted, used for headshots
;902:damage		amount of damage being inflicted
;903:knockback	force to be applied against targ as a result of the damage
;904:
;905:inflictor, attacker, dir, and point can be NULL for environmental effects
;906:
;907:dflags		these flags are used to control how T_Damage works
;908:	DAMAGE_RADIUS			damage was indirect (from a nearby explosion)
;909:	DAMAGE_NO_ARMOR			armor does not protect from this damage
;910:	DAMAGE_NO_KNOCKBACK		do not affect velocity, just view angles
;911:	DAMAGE_NO_PROTECTION	kills godmode, armor, everything
;912:============
;913:*/
;914:
;915:void G_Damage( gentity_t *targ, gentity_t *inflictor, gentity_t *attacker,
;916:			   vec3_t dir, vec3_t point, int damage, int dflags, int mod ) {
line 927
;917:	gclient_t	*client;
;918:	int			take;
;919:	int			save;
;920:	int			asave;
;921:	int			knockback;
;922:	int			max;
;923:#ifdef MISSIONPACK
;924:	vec3_t		bouncedir, impactpoint;
;925:#endif
;926:
;927:	if (!targ->takedamage) {
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
NEI4 $366
line 928
;928:		return;
ADDRGP4 $365
JUMPV
LABELV $366
line 933
;929:	}
;930:
;931:	// the intermission has allready been qualified for, so don't
;932:	// allow any extra scoring
;933:	if ( level.intermissionQueued ) {
ADDRGP4 level+9156
INDIRI4
CNSTI4 0
EQI4 $368
line 934
;934:		return;
ADDRGP4 $365
JUMPV
LABELV $368
line 946
;935:	}
;936:#ifdef MISSIONPACK
;937:	if ( targ->client && mod != MOD_JUICED) {
;938:		if ( targ->client->invulnerabilityTime > level.time) {
;939:			if ( dir && point ) {
;940:				G_InvulnerabilityEffect( targ, dir, point, impactpoint, bouncedir );
;941:			}
;942:			return;
;943:		}
;944:	}
;945:#endif
;946:	if ( !inflictor ) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $371
line 947
;947:		inflictor = &g_entities[ENTITYNUM_WORLD];
ADDRFP4 4
ADDRGP4 g_entities+915712
ASGNP4
line 948
;948:	}
LABELV $371
line 949
;949:	if ( !attacker ) {
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $374
line 950
;950:		attacker = &g_entities[ENTITYNUM_WORLD];
ADDRFP4 8
ADDRGP4 g_entities+915712
ASGNP4
line 951
;951:	}
LABELV $374
line 954
;952:
;953:	// shootable doors / buttons don't actually have any health
;954:	if ( targ->s.eType == ET_MOVER ) {
ADDRLP4 24
CNSTI4 4
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $377
line 955
;955:		if ( targ->use && targ->moverState == MOVER_POS1 ) {
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $365
ADDRLP4 28
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
CNSTI4 0
NEI4 $365
line 956
;956:			targ->use( targ, inflictor, attacker );
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 708
ADDP4
INDIRP4
CALLV
pop
line 957
;957:		}
line 958
;958:		return;
ADDRGP4 $365
JUMPV
LABELV $377
line 967
;959:	}
;960:#ifdef MISSIONPACK
;961:	if( g_gametype.integer == GT_OBELISK && CheckObeliskAttack( targ, attacker ) ) {
;962:		return;
;963:	}
;964:#endif
;965:	// reduce damage by the attacker's handicap value
;966:	// unless they are rocket jumping
;967:	if ( attacker->client && attacker != targ ) {
ADDRLP4 28
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $381
ADDRLP4 28
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $381
line 968
;968:		max = attacker->client->ps.stats[STAT_MAX_HEALTH];
ADDRLP4 20
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ASGNI4
line 974
;969:#ifdef MISSIONPACK
;970:		if( bg_itemlist[attacker->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_GUARD ) {
;971:			max /= 2;
;972:		}
;973:#endif
;974:		damage = damage * max / 100;
ADDRFP4 20
ADDRFP4 20
INDIRI4
ADDRLP4 20
INDIRI4
MULI4
CNSTI4 100
DIVI4
ASGNI4
line 975
;975:	}
LABELV $381
line 977
;976:
;977:	client = targ->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 979
;978:
;979:	if ( client ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $383
line 980
;980:		if ( client->noclip ) {
ADDRLP4 0
INDIRP4
CNSTI4 10240
ADDP4
INDIRI4
CNSTI4 0
EQI4 $385
line 981
;981:			return;
ADDRGP4 $365
JUMPV
LABELV $385
line 983
;982:		}
;983:	}
LABELV $383
line 987
;984:
;985:	//Stats
;986:	//Make sure target isn't us, and target is a client (because it could be an entity, such as a door)
;987:	if ( mod == MOD_GRENADE || mod == MOD_GRENADE_SPLASH && targ != attacker && targ->client ) {
ADDRLP4 32
ADDRFP4 28
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 4
EQI4 $389
ADDRLP4 32
INDIRI4
CNSTI4 5
NEI4 $387
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CVPU4 4
ADDRFP4 8
INDIRP4
CVPU4 4
EQU4 $387
ADDRLP4 36
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $387
LABELV $389
line 988
;988:		if ( !dflags & DAMAGE_RADIUS ) {
ADDRFP4 24
INDIRI4
CNSTI4 0
NEI4 $393
ADDRLP4 40
CNSTI4 1
ASGNI4
ADDRGP4 $394
JUMPV
LABELV $393
ADDRLP4 40
CNSTI4 0
ASGNI4
LABELV $394
ADDRLP4 40
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $390
line 989
;989:			attacker->client->pers.stats_hits[WP_GRENADE_LAUNCHER]++;
ADDRLP4 44
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9916
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 990
;990:		}
LABELV $390
line 991
;991:		attacker->client->pers.stats_damage[WP_GRENADE_LAUNCHER] += damage;
ADDRLP4 44
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9964
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
ADDRFP4 20
INDIRI4
ADDI4
ASGNI4
line 992
;992:		attacker->client->pers.stats_totaldamage += damage;
ADDRLP4 48
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9944
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
ADDRFP4 20
INDIRI4
ADDI4
ASGNI4
line 993
;993:	} else if ( mod == MOD_ROCKET || mod == MOD_ROCKET_SPLASH && targ != attacker && targ->client ) {
ADDRGP4 $388
JUMPV
LABELV $387
ADDRLP4 40
ADDRFP4 28
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 6
EQI4 $397
ADDRLP4 40
INDIRI4
CNSTI4 7
NEI4 $395
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CVPU4 4
ADDRFP4 8
INDIRP4
CVPU4 4
EQU4 $395
ADDRLP4 44
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $395
LABELV $397
line 994
;994:		if ( !dflags & DAMAGE_RADIUS ) {
ADDRFP4 24
INDIRI4
CNSTI4 0
NEI4 $401
ADDRLP4 48
CNSTI4 1
ASGNI4
ADDRGP4 $402
JUMPV
LABELV $401
ADDRLP4 48
CNSTI4 0
ASGNI4
LABELV $402
ADDRLP4 48
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $398
line 995
;995:			attacker->client->pers.stats_hits[WP_ROCKET_LAUNCHER]++;
ADDRLP4 52
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9920
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 996
;996:		}
LABELV $398
line 997
;997:		attacker->client->pers.stats_damage[WP_ROCKET_LAUNCHER] += damage;
ADDRLP4 52
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9968
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
ADDRFP4 20
INDIRI4
ADDI4
ASGNI4
line 998
;998:		attacker->client->pers.stats_totaldamage += damage;
ADDRLP4 56
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9944
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
ADDRFP4 20
INDIRI4
ADDI4
ASGNI4
line 999
;999:	} else if ( mod == MOD_PLASMA || mod == MOD_PLASMA_SPLASH && targ != attacker && targ->client ) {
ADDRGP4 $396
JUMPV
LABELV $395
ADDRLP4 48
ADDRFP4 28
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 8
EQI4 $405
ADDRLP4 48
INDIRI4
CNSTI4 9
NEI4 $403
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CVPU4 4
ADDRFP4 8
INDIRP4
CVPU4 4
EQU4 $403
ADDRLP4 52
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $403
LABELV $405
line 1000
;1000:		if ( !dflags & DAMAGE_RADIUS ) {
ADDRFP4 24
INDIRI4
CNSTI4 0
NEI4 $409
ADDRLP4 56
CNSTI4 1
ASGNI4
ADDRGP4 $410
JUMPV
LABELV $409
ADDRLP4 56
CNSTI4 0
ASGNI4
LABELV $410
ADDRLP4 56
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $406
line 1001
;1001:			attacker->client->pers.stats_hits[WP_PLASMAGUN]++;
ADDRLP4 60
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9932
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
line 1002
;1002:		}
LABELV $406
line 1003
;1003:		attacker->client->pers.stats_damage[WP_PLASMAGUN] += damage;
ADDRLP4 60
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9980
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
ADDRFP4 20
INDIRI4
ADDI4
ASGNI4
line 1004
;1004:		attacker->client->pers.stats_totaldamage += damage;
ADDRLP4 64
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9944
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
ADDRFP4 20
INDIRI4
ADDI4
ASGNI4
line 1005
;1005:	} else if ( mod == MOD_BFG || mod == MOD_BFG_SPLASH && targ != attacker && targ->client ) {
ADDRGP4 $404
JUMPV
LABELV $403
ADDRLP4 56
ADDRFP4 28
INDIRI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 12
EQI4 $413
ADDRLP4 56
INDIRI4
CNSTI4 13
NEI4 $411
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CVPU4 4
ADDRFP4 8
INDIRP4
CVPU4 4
EQU4 $411
ADDRLP4 60
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $411
LABELV $413
line 1006
;1006:		if ( !dflags & DAMAGE_RADIUS ) {
ADDRFP4 24
INDIRI4
CNSTI4 0
NEI4 $417
ADDRLP4 64
CNSTI4 1
ASGNI4
ADDRGP4 $418
JUMPV
LABELV $417
ADDRLP4 64
CNSTI4 0
ASGNI4
LABELV $418
ADDRLP4 64
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $414
line 1007
;1007:			attacker->client->pers.stats_hits[WP_BFG]++;
ADDRLP4 68
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9936
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1008
;1008:		}
LABELV $414
line 1009
;1009:		attacker->client->pers.stats_damage[WP_BFG] += damage;
ADDRLP4 68
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9984
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
ADDRFP4 20
INDIRI4
ADDI4
ASGNI4
line 1010
;1010:		attacker->client->pers.stats_totaldamage += damage;
ADDRLP4 72
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9944
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
ADDRFP4 20
INDIRI4
ADDI4
ASGNI4
line 1011
;1011:	}
LABELV $411
LABELV $404
LABELV $396
LABELV $388
line 1013
;1012:
;1013:	if ( !dir ) {
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $419
line 1014
;1014:		dflags |= DAMAGE_NO_KNOCKBACK;
ADDRFP4 24
ADDRFP4 24
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 1015
;1015:	} else {
ADDRGP4 $420
JUMPV
LABELV $419
line 1016
;1016:		VectorNormalize(dir);
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 1017
;1017:	}
LABELV $420
line 1019
;1018:
;1019:	if ( attacker->client && g_friendlyFire.integer == 0 && 
ADDRLP4 64
CNSTI4 516
ASGNI4
ADDRLP4 68
ADDRFP4 8
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $421
ADDRLP4 72
CNSTI4 0
ASGNI4
ADDRGP4 g_friendlyFire+12
INDIRI4
ADDRLP4 72
INDIRI4
NEI4 $421
ADDRLP4 76
CNSTI4 10188
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRI4
ADDRLP4 68
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRI4
NEI4 $421
ADDRFP4 28
INDIRI4
CNSTI4 10
NEI4 $421
ADDRGP4 g_teamKnockback+12
INDIRI4
ADDRLP4 72
INDIRI4
LTI4 $421
line 1021
;1020:		targ->client->sess.sessionTeam == attacker->client->sess.sessionTeam && 
;1021:		mod == MOD_RAILGUN && g_teamKnockback.integer >= 0) {
line 1022
;1022:			knockback = g_teamKnockback.integer;
ADDRLP4 4
ADDRGP4 g_teamKnockback+12
INDIRI4
ASGNI4
line 1023
;1023:	} else {
ADDRGP4 $422
JUMPV
LABELV $421
line 1024
;1024:			knockback = damage;
ADDRLP4 4
ADDRFP4 20
INDIRI4
ASGNI4
line 1025
;1025:	}
LABELV $422
line 1026
;1026:	if ( knockback > 200 && (targ != attacker && attacker->s.weapon != WP_RAILGUN) ) {
ADDRLP4 4
INDIRI4
CNSTI4 200
LEI4 $426
ADDRLP4 80
ADDRFP4 8
INDIRP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRLP4 80
INDIRP4
CVPU4 4
EQU4 $426
ADDRLP4 80
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 7
EQI4 $426
line 1028
;1027:		//This allows us to go over the 200 limit knockback when railjumping.
;1028:		knockback = 200;
ADDRLP4 4
CNSTI4 200
ASGNI4
line 1029
;1029:	}
LABELV $426
line 1031
;1030:
;1031:	if ( targ->flags & FL_NO_KNOCKBACK ) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $428
line 1032
;1032:		knockback = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1033
;1033:	}
LABELV $428
line 1034
;1034:	if ( dflags & DAMAGE_NO_KNOCKBACK ) {
ADDRFP4 24
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $430
line 1035
;1035:		knockback = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1036
;1036:	}
LABELV $430
line 1038
;1037:
;1038:	if ((mod == MOD_XX_RAILJUMP && targ != attacker) || (targ != attacker && !g_interference.integer)) {
ADDRFP4 28
INDIRI4
CNSTI4 24
NEI4 $436
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 8
INDIRP4
CVPU4 4
NEU4 $435
LABELV $436
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 8
INDIRP4
CVPU4 4
EQU4 $432
ADDRGP4 g_interference+12
INDIRI4
CNSTI4 0
NEI4 $432
LABELV $435
line 1040
;1039:		//players that aren't the attacker shouldn't railjump.
;1040:		return;
ADDRGP4 $365
JUMPV
LABELV $432
line 1043
;1041:	}
;1042:
;1043:	if ( client && client->ps.powerups[PW_BATTLESUIT] && client->spawnProtection == qtrue &&
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $437
ADDRLP4 0
INDIRP4
CNSTI4 320
ADDP4
INDIRI4
CNSTI4 0
EQI4 $437
ADDRLP4 88
CNSTI4 1
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 10824
ADDP4
INDIRI4
ADDRLP4 88
INDIRI4
NEI4 $437
ADDRLP4 92
ADDRFP4 28
INDIRI4
ASGNI4
ADDRLP4 92
INDIRI4
ADDRLP4 88
INDIRI4
LTI4 $437
ADDRLP4 92
INDIRI4
CNSTI4 13
GTI4 $437
ADDRLP4 92
INDIRI4
CNSTI4 23
EQI4 $437
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 8
INDIRP4
CVPU4 4
EQU4 $437
line 1044
;1044:		(mod >= MOD_SHOTGUN && mod <= MOD_BFG_SPLASH && mod != MOD_GRAPPLE) && targ != attacker) {
line 1045
;1045:		G_AddEvent( targ, EV_POWERUP_BATTLESUIT, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 62
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 1046
;1046:		return;
ADDRGP4 $365
JUMPV
LABELV $437
line 1050
;1047:	}
;1048:
;1049:	// figure momentum add, even if the damage won't be taken
;1050:	if ( knockback && targ->client ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $439
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $439
line 1055
;1051:		vec3_t	kvel;
;1052:		float	mass;
;1053:
;1054:		// CPM: Custom weapon knockbacks
;1055:		float	scale = 1;
ADDRLP4 108
CNSTF4 1065353216
ASGNF4
line 1057
;1056:
;1057:		if ( mod == MOD_XX_RAILJUMP && g_StaticKnockback.integer ) {
ADDRFP4 28
INDIRI4
CNSTI4 24
NEI4 $441
ADDRGP4 g_StaticKnockback+12
INDIRI4
CNSTI4 0
EQI4 $441
line 1059
;1058:			//enforce a staticknockback
;1059:			knockback = g_railgunKnockback.integer;
ADDRLP4 4
ADDRGP4 g_railgunKnockback+12
INDIRI4
ASGNI4
line 1060
;1060:		}
LABELV $441
line 1062
;1061:
;1062:		if ( (targ == attacker) && (mod == MOD_ROCKET_SPLASH || mod == MOD_XX_RAILJUMP) ) {
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 8
INDIRP4
CVPU4 4
NEU4 $445
ADDRLP4 116
ADDRFP4 28
INDIRI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 7
EQI4 $447
ADDRLP4 116
INDIRI4
CNSTI4 24
NEI4 $445
LABELV $447
line 1063
;1063:			scale = 1;
ADDRLP4 108
CNSTF4 1065353216
ASGNF4
line 1064
;1064:		} else {
ADDRGP4 $446
JUMPV
LABELV $445
line 1065
;1065:			switch( mod ) {
ADDRLP4 120
ADDRFP4 28
INDIRI4
ASGNI4
ADDRLP4 124
CNSTI4 1
ASGNI4
ADDRLP4 120
INDIRI4
ADDRLP4 124
INDIRI4
EQI4 $451
ADDRLP4 120
INDIRI4
CNSTI4 2
EQI4 $450
ADDRLP4 120
INDIRI4
ADDRLP4 124
INDIRI4
LTI4 $448
LABELV $453
ADDRFP4 28
INDIRI4
CNSTI4 11
EQI4 $452
ADDRGP4 $448
JUMPV
LABELV $450
line 1066
;1066:				case MOD_GAUNTLET: scale = cpm_Gauntletknockback; break;
ADDRLP4 108
ADDRGP4 cpm_Gauntletknockback
INDIRF4
ASGNF4
ADDRGP4 $449
JUMPV
LABELV $451
line 1067
;1067:				case MOD_SHOTGUN: scale = cpm_SSGknockback; break;
ADDRLP4 108
ADDRGP4 cpm_SSGknockback
INDIRF4
ASGNF4
ADDRGP4 $449
JUMPV
LABELV $452
line 1070
;1068:				//case MOD_ROCKET: scale = cpm_RLknockback; break;
;1069:				//case MOD_ROCKET_SPLASH: scale = cpm_RLsplashknockback; break;
;1070:				case MOD_LIGHTNING: scale = cpm_LGknockback; break;
ADDRLP4 108
ADDRGP4 cpm_LGknockback
INDIRF4
ASGNF4
LABELV $448
line 1072
;1071:				//case MOD_PLASMA: scale = cpm_PGknockback; break;
;1072:				default:;
line 1073
;1073:			}
LABELV $449
line 1074
;1074:		}
LABELV $446
line 1077
;1075:		// !CPM
;1076:
;1077:		mass = 200;
ADDRLP4 112
CNSTF4 1128792064
ASGNF4
line 1080
;1078:
;1079:		//VectorScale (dir, g_knockback.value * (float)knockback / mass, kvel);
;1080:		VectorScale (dir, scale * g_knockback.value * (float)knockback / mass, kvel); // CPM
ADDRLP4 120
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 124
ADDRLP4 108
INDIRF4
ASGNF4
ADDRLP4 128
ADDRLP4 4
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 132
ADDRLP4 112
INDIRF4
ASGNF4
ADDRLP4 96
ADDRLP4 120
INDIRP4
INDIRF4
ADDRLP4 124
INDIRF4
ADDRGP4 g_knockback+8
INDIRF4
MULF4
ADDRLP4 128
INDIRF4
MULF4
ADDRLP4 132
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 96+4
ADDRLP4 120
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 124
INDIRF4
ADDRGP4 g_knockback+8
INDIRF4
MULF4
ADDRLP4 128
INDIRF4
MULF4
ADDRLP4 132
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 96+8
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 108
INDIRF4
ADDRGP4 g_knockback+8
INDIRF4
MULF4
ADDRLP4 4
INDIRI4
CVIF4 4
MULF4
ADDRLP4 112
INDIRF4
DIVF4
MULF4
ASGNF4
line 1081
;1081:		VectorAdd (targ->client->ps.velocity, kvel, targ->client->ps.velocity);
ADDRLP4 136
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 136
INDIRP4
ADDRLP4 136
INDIRP4
INDIRF4
ADDRLP4 96
INDIRF4
ADDF4
ASGNF4
ADDRLP4 140
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 140
INDIRP4
ADDRLP4 140
INDIRP4
INDIRF4
ADDRLP4 96+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 144
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 144
INDIRP4
ADDRLP4 144
INDIRP4
INDIRF4
ADDRLP4 96+8
INDIRF4
ADDF4
ASGNF4
line 1085
;1082:
;1083:		// set the timer so that the other client can't cancel
;1084:		// out the movement immediately
;1085:		if ( !targ->client->ps.pm_time ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
NEI4 $461
line 1088
;1086:			int		t;
;1087:
;1088:			t = knockback * 2;
ADDRLP4 148
ADDRLP4 4
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 1089
;1089:			if ( t < 50 ) {
ADDRLP4 148
INDIRI4
CNSTI4 50
GEI4 $463
line 1090
;1090:				t = 50;
ADDRLP4 148
CNSTI4 50
ASGNI4
line 1091
;1091:			}
LABELV $463
line 1092
;1092:			if ( t > 200 ) {
ADDRLP4 148
INDIRI4
CNSTI4 200
LEI4 $465
line 1093
;1093:				t = 200;
ADDRLP4 148
CNSTI4 200
ASGNI4
line 1094
;1094:			}
LABELV $465
line 1095
;1095:			targ->client->ps.pm_time = t;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 148
INDIRI4
ASGNI4
line 1096
;1096:			targ->client->ps.pm_flags |= PMF_TIME_KNOCKBACK;
ADDRLP4 152
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 152
INDIRP4
ADDRLP4 152
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 1097
;1097:		}
LABELV $461
line 1098
;1098:	}
LABELV $439
line 1100
;1099:
;1100:	if ( mod == MOD_XX_RAILJUMP ) {
ADDRFP4 28
INDIRI4
CNSTI4 24
NEI4 $467
line 1102
;1101:		//Return because we've applied knockback, no need to do damage or anything.
;1102:		return;
ADDRGP4 $365
JUMPV
LABELV $467
line 1106
;1103:	}
;1104:
;1105:	// check for completely getting out of the damage
;1106:	if ( !(dflags & DAMAGE_NO_PROTECTION) ) {
ADDRFP4 24
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $469
line 1113
;1107:
;1108:		// if TF_NO_FRIENDLY_FIRE is set, don't do damage to the target
;1109:		// if the attacker was on the same team
;1110:#ifdef MISSIONPACK
;1111:		if ( mod != MOD_JUICED && targ != attacker && !(dflags & DAMAGE_NO_TEAM_PROTECTION) && OnSameTeam (targ, attacker)  ) {
;1112:#else	
;1113:		if ( targ != attacker && OnSameTeam (targ, attacker)  ) {
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 100
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CVPU4 4
ADDRLP4 100
INDIRP4
CVPU4 4
EQU4 $471
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 104
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 0
EQI4 $471
line 1115
;1114:#endif
;1115:			if ( !g_friendlyFire.integer ) {
ADDRGP4 g_friendlyFire+12
INDIRI4
CNSTI4 0
NEI4 $473
line 1116
;1116:				return;
ADDRGP4 $365
JUMPV
LABELV $473
line 1118
;1117:			}
;1118:		}
LABELV $471
line 1131
;1119:#ifdef MISSIONPACK
;1120:		if (mod == MOD_PROXIMITY_MINE) {
;1121:			if (inflictor && inflictor->parent && OnSameTeam(targ, inflictor->parent)) {
;1122:				return;
;1123:			}
;1124:			if (targ == attacker) {
;1125:				return;
;1126:			}
;1127:		}
;1128:#endif
;1129:
;1130:		// check for godmode
;1131:		if ( targ->flags & FL_GODMODE ) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $476
line 1132
;1132:			return;
ADDRGP4 $365
JUMPV
LABELV $476
line 1135
;1133:		}
;1134://freeze
;1135:		if ( g_gamemode.integer > 3 ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $478
line 1136
;1136:			if ( client ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $481
line 1137
;1137:				if ( targ != attacker && level.time - client->respawnTime < 1000 ) return;
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 8
INDIRP4
CVPU4 4
EQU4 $482
ADDRGP4 level+40
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 10332
ADDP4
INDIRI4
SUBI4
CNSTI4 1000
GEI4 $482
ADDRGP4 $365
JUMPV
line 1138
;1138:			} else {
LABELV $481
line 1139
;1139:				if ( DamageBody( targ, attacker, dir, mod, knockback ) ) return;
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 28
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 108
ADDRGP4 DamageBody
CALLI4
ASGNI4
ADDRLP4 108
INDIRI4
CNSTI4 0
EQI4 $486
ADDRGP4 $365
JUMPV
LABELV $486
line 1140
;1140:			}
LABELV $482
line 1141
;1141:		}
LABELV $478
line 1143
;1142://freeze
;1143:	}
LABELV $469
line 1147
;1144:
;1145:	// battlesuit protects from all radius damage (but takes knockback)
;1146:	// and protects 50% against all damage
;1147:	if ( client && client->ps.powerups[PW_BATTLESUIT] ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $488
ADDRLP4 0
INDIRP4
CNSTI4 320
ADDP4
INDIRI4
CNSTI4 0
EQI4 $488
line 1148
;1148:		G_AddEvent( targ, EV_POWERUP_BATTLESUIT, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 62
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 1149
;1149:		if ( ( dflags & DAMAGE_RADIUS ) || ( mod == MOD_FALLING ) ) {
ADDRFP4 24
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $492
ADDRFP4 28
INDIRI4
CNSTI4 19
NEI4 $490
LABELV $492
line 1150
;1150:			return;
ADDRGP4 $365
JUMPV
LABELV $490
line 1153
;1151:		}
;1152:		//damage *= 0.5;
;1153:		damage *= cpm_BSprotection; // CPM: Better protection in cpm
ADDRFP4 20
ADDRFP4 20
INDIRI4
CVIF4 4
ADDRGP4 cpm_BSprotection
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 1154
;1154:	}
LABELV $488
line 1157
;1155:
;1156:	// add to the attacker's hit counter (if the target isn't a general entity like a prox mine)
;1157:	if ( attacker->client && targ != attacker && targ->health > 0
ADDRLP4 100
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $493
ADDRLP4 104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 104
INDIRP4
CVPU4 4
ADDRLP4 100
INDIRP4
CVPU4 4
EQU4 $493
ADDRLP4 108
CNSTI4 0
ASGNI4
ADDRLP4 104
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRLP4 108
INDIRI4
LEI4 $493
ADDRLP4 112
ADDRLP4 104
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 3
EQI4 $493
ADDRLP4 112
INDIRI4
ADDRLP4 108
INDIRI4
EQI4 $493
line 1159
;1158:			&& targ->s.eType != ET_MISSILE
;1159:			&& targ->s.eType != ET_GENERAL) {
line 1160
;1160:		if ( OnSameTeam( targ, attacker ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 116
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 0
EQI4 $495
line 1161
;1161:			attacker->client->ps.persistant[PERS_HITS]--;
ADDRLP4 120
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 252
ADDP4
ASGNP4
ADDRLP4 120
INDIRP4
ADDRLP4 120
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1162
;1162:		} else {
ADDRGP4 $496
JUMPV
LABELV $495
line 1163
;1163:			attacker->client->ps.persistant[PERS_HITS]++;
ADDRLP4 120
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 252
ADDP4
ASGNP4
ADDRLP4 120
INDIRP4
ADDRLP4 120
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1164
;1164:		}
LABELV $496
line 1165
;1165:		attacker->client->ps.persistant[PERS_ATTACKEE_ARMOR] = (targ->health<<8)|(client->ps.stats[STAT_ARMOR]);
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 276
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 8
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
BORI4
ASGNI4
line 1166
;1166:	}
LABELV $493
line 1170
;1167:
;1168:	// always give half damage if hurting self
;1169:	// calculated after knockback, so rocket jumping works
;1170:	if ( targ == attacker) {
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 8
INDIRP4
CVPU4 4
NEU4 $497
line 1171
;1171:		damage *= 0.5;
ADDRFP4 20
CNSTF4 1056964608
ADDRFP4 20
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 1172
;1172:	}
LABELV $497
line 1174
;1173:
;1174:	if ( damage < 1 ) {
ADDRFP4 20
INDIRI4
CNSTI4 1
GEI4 $499
line 1175
;1175:		damage = 1;
ADDRFP4 20
CNSTI4 1
ASGNI4
line 1176
;1176:	}
LABELV $499
line 1177
;1177:	take = damage;
ADDRLP4 8
ADDRFP4 20
INDIRI4
ASGNI4
line 1178
;1178:	save = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 1181
;1179:
;1180:	// save some from armor
;1181:	if ( ((g_SelfDamage.integer == -1 || g_SelfDamage.integer == 0) && targ != attacker ) || g_SelfDamage.integer == 1) {
ADDRGP4 g_SelfDamage+12
INDIRI4
CNSTI4 -1
EQI4 $508
ADDRGP4 g_SelfDamage+12
INDIRI4
CNSTI4 0
NEI4 $507
LABELV $508
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 8
INDIRP4
CVPU4 4
NEU4 $506
LABELV $507
ADDRGP4 g_SelfDamage+12
INDIRI4
CNSTI4 1
NEI4 $501
LABELV $506
line 1182
;1182:		asave = CheckArmor (targ, take, dflags);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRLP4 116
ADDRGP4 CheckArmor
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 116
INDIRI4
ASGNI4
line 1183
;1183:		take -= asave;
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRI4
SUBI4
ASGNI4
line 1184
;1184:	}
LABELV $501
line 1189
;1185:
;1186:	// add to the damage inflicted on a player this frame
;1187:	// the total will be turned into screen blends and view angle kicks
;1188:	// at the end of the frame
;1189:	if ( client ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $509
line 1190
;1190:		if ( attacker ) {
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $511
line 1191
;1191:			client->ps.persistant[PERS_ATTACKER] = attacker->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
ADDRFP4 8
INDIRP4
INDIRI4
ASGNI4
line 1192
;1192:		} else {
ADDRGP4 $512
JUMPV
LABELV $511
line 1193
;1193:			client->ps.persistant[PERS_ATTACKER] = ENTITYNUM_WORLD;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
CNSTI4 1022
ASGNI4
line 1194
;1194:		}
LABELV $512
line 1196
;1195:
;1196:		client->damage_armor += asave;
ADDRLP4 116
ADDRLP4 0
INDIRP4
CNSTI4 10280
ADDP4
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 116
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
ADDI4
ASGNI4
line 1197
;1197:		client->damage_blood += take;
ADDRLP4 120
ADDRLP4 0
INDIRP4
CNSTI4 10284
ADDP4
ASGNP4
ADDRLP4 120
INDIRP4
ADDRLP4 120
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
ASGNI4
line 1198
;1198:		client->damage_knockback += knockback;
ADDRLP4 124
ADDRLP4 0
INDIRP4
CNSTI4 10288
ADDP4
ASGNP4
ADDRLP4 124
INDIRP4
ADDRLP4 124
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 1200
;1199:
;1200:		if ( dir ) {
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $513
line 1201
;1201:			VectorCopy ( dir, client->damage_from );
ADDRLP4 0
INDIRP4
CNSTI4 10292
ADDP4
ADDRFP4 12
INDIRP4
INDIRB
ASGNB 12
line 1202
;1202:			client->damage_fromWorld = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 10304
ADDP4
CNSTI4 0
ASGNI4
line 1203
;1203:		} else {
ADDRGP4 $514
JUMPV
LABELV $513
line 1204
;1204:			VectorCopy ( targ->r.currentOrigin, client->damage_from );
ADDRLP4 0
INDIRP4
CNSTI4 10292
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 1205
;1205:			client->damage_fromWorld = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 10304
ADDP4
CNSTI4 1
ASGNI4
line 1206
;1206:		}
LABELV $514
line 1207
;1207:	}
LABELV $509
line 1213
;1208:
;1209:	// See if it's the player hurting the emeny flag carrier
;1210:#ifdef MISSIONPACK
;1211:	if( g_gametype.integer == GT_CTF || g_gametype.integer == GT_1FCTF ) {
;1212:#else	
;1213:	if( g_gametype.integer == GT_CTF) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $515
line 1215
;1214:#endif
;1215:		Team_CheckHurtCarrier(targ, attacker);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Team_CheckHurtCarrier
CALLV
pop
line 1216
;1216:	}
LABELV $515
line 1218
;1217:
;1218:	if (targ->client) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $518
line 1220
;1219:		// set the last client who damaged the target
;1220:		targ->client->lasthurt_client = attacker->s.number;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10324
ADDP4
ADDRFP4 8
INDIRP4
INDIRI4
ASGNI4
line 1221
;1221:		targ->client->lasthurt_mod = mod;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10328
ADDP4
ADDRFP4 28
INDIRI4
ASGNI4
line 1222
;1222:	}
LABELV $518
line 1225
;1223:
;1224:	// do the damage
;1225:	if (take) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $520
line 1226
;1226:		if (g_SelfDamage.integer == 0 && (targ == attacker) || (attacker->s.weapon == WP_RAILGUN && (dflags & DAMAGE_RADIUS))) {
ADDRGP4 g_SelfDamage+12
INDIRI4
CNSTI4 0
NEI4 $526
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 8
INDIRP4
CVPU4 4
EQU4 $525
LABELV $526
ADDRFP4 8
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 7
NEI4 $522
ADDRFP4 24
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $522
LABELV $525
line 1227
;1227:			return;
ADDRGP4 $365
JUMPV
LABELV $522
line 1232
;1228:		}
;1229:		//If we're playing instagib, gib anything that isn't us, and is a direct hit.
;1230:		//but if we don't meet all of those, "take" damage like normal.
;1231:		//Same for Rocket and Rails(3) and insta-freeze(5)
;1232:		if ( ((g_allowHandicap.integer && (attacker->client->pers.maxHealth == 100 || (targ->health - take < 1))) || !g_allowHandicap.integer ) && (g_gamemode.integer == 1 || g_gamemode.integer == 3 || g_gamemode.integer == 5) && 
ADDRGP4 g_allowHandicap+12
INDIRI4
CNSTI4 0
EQI4 $535
ADDRFP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 552
ADDP4
INDIRI4
CNSTI4 100
EQI4 $534
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
CNSTI4 1
LTI4 $534
LABELV $535
ADDRGP4 g_allowHandicap+12
INDIRI4
CNSTI4 0
NEI4 $527
LABELV $534
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 1
EQI4 $537
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
EQI4 $537
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 5
NEI4 $527
LABELV $537
ADDRLP4 116
ADDRFP4 28
INDIRI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 0
LEI4 $527
ADDRLP4 116
INDIRI4
CNSTI4 12
GTI4 $527
ADDRLP4 116
INDIRI4
CNSTI4 7
EQI4 $527
ADDRLP4 116
INDIRI4
CNSTI4 5
EQI4 $527
ADDRLP4 116
INDIRI4
CNSTI4 9
EQI4 $527
line 1233
;1233:			( mod > MOD_UNKNOWN && mod <= MOD_BFG && mod != MOD_ROCKET_SPLASH && mod != MOD_GRENADE_SPLASH && mod != MOD_PLASMA_SPLASH ) ) {
line 1235
;1234:			//Hack: It makes it easier to work with knockback and stuff
;1235:			targ->health = -666;
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
CNSTI4 -666
ASGNI4
line 1237
;1236:			//Devilish code. =D
;1237:		} else {
ADDRGP4 $528
JUMPV
LABELV $527
line 1238
;1238:			targ->health = targ->health - take;
ADDRLP4 120
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 120
INDIRP4
ADDRLP4 120
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ASGNI4
line 1239
;1239:		}
LABELV $528
line 1240
;1240:		if ( targ->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $538
line 1241
;1241:			targ->client->ps.stats[STAT_HEALTH] = targ->health;
ADDRLP4 120
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 120
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 120
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ASGNI4
line 1242
;1242:		}
LABELV $538
line 1244
;1243:			
;1244:		if ( targ->health <= 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 0
GTI4 $540
line 1246
;1245:			
;1246:			if ( client ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $542
line 1247
;1247:				if ( !targ->deathCounted ) {
ADDRFP4 0
INDIRP4
CNSTI4 876
ADDP4
INDIRI4
CNSTI4 0
NEI4 $544
line 1248
;1248:					targ->deathCounted = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 876
ADDP4
CNSTI4 1
ASGNI4
line 1249
;1249:					targ->client->pers.stats_deaths++;
ADDRLP4 120
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10040
ADDP4
ASGNP4
ADDRLP4 120
INDIRP4
ADDRLP4 120
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1250
;1250:				}
LABELV $544
line 1251
;1251:				targ->flags |= FL_NO_KNOCKBACK;
ADDRLP4 120
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ASGNP4
ADDRLP4 120
INDIRP4
ADDRLP4 120
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 1252
;1252:			}
LABELV $542
line 1254
;1253:
;1254:			if (targ->health < -999)
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 -999
GEI4 $546
line 1255
;1255:				targ->health = -999;
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
CNSTI4 -999
ASGNI4
LABELV $546
line 1257
;1256:
;1257:			targ->enemy = attacker;
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
ADDRFP4 8
INDIRP4
ASGNP4
line 1258
;1258:			targ->die (targ, inflictor, attacker, take, mod);
ADDRLP4 120
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 120
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRFP4 28
INDIRI4
ARGI4
ADDRLP4 120
INDIRP4
CNSTI4 716
ADDP4
INDIRP4
CALLV
pop
line 1259
;1259:			return;
ADDRGP4 $365
JUMPV
LABELV $540
line 1260
;1260:		} else if ( targ->pain ) {
ADDRFP4 0
INDIRP4
CNSTI4 712
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $548
line 1261
;1261:			targ->pain (targ, attacker, take);
ADDRLP4 120
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 120
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 120
INDIRP4
CNSTI4 712
ADDP4
INDIRP4
CALLV
pop
line 1262
;1262:		}
LABELV $548
line 1263
;1263:	}
LABELV $520
line 1265
;1264:
;1265:}
LABELV $365
endproc G_Damage 156 20
export CanDamage
proc CanDamage 112 28
line 1276
;1266:
;1267:
;1268:/*
;1269:============
;1270:CanDamage
;1271:
;1272:Returns qtrue if the inflictor can directly damage the target.  Used for
;1273:explosions and melee attacks.
;1274:============
;1275:*/
;1276:qboolean CanDamage (gentity_t *targ, vec3_t origin) {
line 1283
;1277:	vec3_t	dest;
;1278:	trace_t	tr;
;1279:	vec3_t	midpoint;
;1280:
;1281:	// use the midpoint of the bounds instead of the origin, because
;1282:	// bmodels may have their origin is 0,0,0
;1283:	VectorAdd (targ->r.absmin, targ->r.absmax, midpoint);
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 80
INDIRP4
CNSTI4 464
ADDP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 476
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 80
INDIRP4
CNSTI4 468
ADDP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 480
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12+8
ADDRLP4 84
INDIRP4
CNSTI4 472
ADDP4
INDIRF4
ADDRLP4 84
INDIRP4
CNSTI4 484
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1284
;1284:	VectorScale (midpoint, 0.5, midpoint);
ADDRLP4 88
CNSTF4 1056964608
ASGNF4
ADDRLP4 12
ADDRLP4 88
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 88
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 12+8
CNSTF4 1056964608
ADDRLP4 12+8
INDIRF4
MULF4
ASGNF4
line 1286
;1285:
;1286:	VectorCopy (midpoint, dest);
ADDRLP4 0
ADDRLP4 12
INDIRB
ASGNB 12
line 1287
;1287:	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 92
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1288
;1288:	if (tr.fraction == 1.0 || tr.entityNum == targ->s.number)
ADDRLP4 24+8
INDIRF4
CNSTF4 1065353216
EQF4 $561
ADDRLP4 24+52
INDIRI4
ADDRFP4 0
INDIRP4
INDIRI4
NEI4 $557
LABELV $561
line 1289
;1289:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $550
JUMPV
LABELV $557
line 1293
;1290:
;1291:	// this should probably check in the plane of projection, 
;1292:	// rather than in world coordinate, and also include Z
;1293:	VectorCopy (midpoint, dest);
ADDRLP4 0
ADDRLP4 12
INDIRB
ASGNB 12
line 1294
;1294:	dest[0] += 15.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 1295
;1295:	dest[1] += 15.0;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 1296
;1296:	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 96
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1297
;1297:	if (tr.fraction == 1.0)
ADDRLP4 24+8
INDIRF4
CNSTF4 1065353216
NEF4 $563
line 1298
;1298:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $550
JUMPV
LABELV $563
line 1300
;1299:
;1300:	VectorCopy (midpoint, dest);
ADDRLP4 0
ADDRLP4 12
INDIRB
ASGNB 12
line 1301
;1301:	dest[0] += 15.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 1302
;1302:	dest[1] -= 15.0;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1097859072
SUBF4
ASGNF4
line 1303
;1303:	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1304
;1304:	if (tr.fraction == 1.0)
ADDRLP4 24+8
INDIRF4
CNSTF4 1065353216
NEF4 $567
line 1305
;1305:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $550
JUMPV
LABELV $567
line 1307
;1306:
;1307:	VectorCopy (midpoint, dest);
ADDRLP4 0
ADDRLP4 12
INDIRB
ASGNB 12
line 1308
;1308:	dest[0] -= 15.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1097859072
SUBF4
ASGNF4
line 1309
;1309:	dest[1] += 15.0;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 1310
;1310:	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 104
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 104
INDIRP4
ARGP4
ADDRLP4 104
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1311
;1311:	if (tr.fraction == 1.0)
ADDRLP4 24+8
INDIRF4
CNSTF4 1065353216
NEF4 $571
line 1312
;1312:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $550
JUMPV
LABELV $571
line 1314
;1313:
;1314:	VectorCopy (midpoint, dest);
ADDRLP4 0
ADDRLP4 12
INDIRB
ASGNB 12
line 1315
;1315:	dest[0] -= 15.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1097859072
SUBF4
ASGNF4
line 1316
;1316:	dest[1] -= 15.0;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1097859072
SUBF4
ASGNF4
line 1317
;1317:	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 108
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 108
INDIRP4
ARGP4
ADDRLP4 108
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1318
;1318:	if (tr.fraction == 1.0)
ADDRLP4 24+8
INDIRF4
CNSTF4 1065353216
NEF4 $575
line 1319
;1319:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $550
JUMPV
LABELV $575
line 1322
;1320:
;1321:
;1322:	return qfalse;
CNSTI4 0
RETI4
LABELV $550
endproc CanDamage 112 28
export G_RadiusDamage
proc G_RadiusDamage 4196 32
line 1332
;1323:}
;1324:
;1325:
;1326:/*
;1327:============
;1328:G_RadiusDamage
;1329:============
;1330:*/
;1331:qboolean G_RadiusDamage ( vec3_t origin, gentity_t *attacker, float damage, float radius,
;1332:					 gentity_t *ignore, int mod) {
line 1341
;1333:	float		points, dist;
;1334:	gentity_t	*ent;
;1335:	int			entityList[MAX_GENTITIES];
;1336:	int			numListedEntities;
;1337:	vec3_t		mins, maxs;
;1338:	vec3_t		v;
;1339:	vec3_t		dir;
;1340:	int			i, e;
;1341:	qboolean	hitClient = qfalse;
ADDRLP4 4168
CNSTI4 0
ASGNI4
line 1343
;1342:
;1343:	if ( radius < 1 ) {
ADDRFP4 12
INDIRF4
CNSTF4 1065353216
GEF4 $579
line 1344
;1344:		radius = 1;
ADDRFP4 12
CNSTF4 1065353216
ASGNF4
line 1345
;1345:	}
LABELV $579
line 1347
;1346:
;1347:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $581
line 1348
;1348:		mins[i] = origin[i] - radius;
ADDRLP4 4172
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4172
INDIRI4
ADDRLP4 4144
ADDP4
ADDRLP4 4172
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRFP4 12
INDIRF4
SUBF4
ASGNF4
line 1349
;1349:		maxs[i] = origin[i] + radius;
ADDRLP4 4176
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4176
INDIRI4
ADDRLP4 4156
ADDP4
ADDRLP4 4176
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRFP4 12
INDIRF4
ADDF4
ASGNF4
line 1350
;1350:	}
LABELV $582
line 1347
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $581
line 1352
;1351:
;1352:	numListedEntities = trap_EntitiesInBox( mins, maxs, entityList, MAX_GENTITIES );
ADDRLP4 4144
ARGP4
ADDRLP4 4156
ARGP4
ADDRLP4 44
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 4172
ADDRGP4 trap_EntitiesInBox
CALLI4
ASGNI4
ADDRLP4 4140
ADDRLP4 4172
INDIRI4
ASGNI4
line 1354
;1353:
;1354:	for ( e = 0 ; e < numListedEntities ; e++ ) {
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRGP4 $588
JUMPV
LABELV $585
line 1355
;1355:		ent = &g_entities[entityList[ e ]];
ADDRLP4 4
CNSTI4 896
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 44
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1357
;1356:
;1357:		if (ent == ignore)
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRFP4 16
INDIRP4
CVPU4 4
NEU4 $589
line 1358
;1358:			continue;
ADDRGP4 $586
JUMPV
LABELV $589
line 1359
;1359:		if (!ent->takedamage)
ADDRLP4 4
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
NEI4 $591
line 1360
;1360:			continue;
ADDRGP4 $586
JUMPV
LABELV $591
line 1366
;1361:
;1362:		//if (!G_AllowEntityInteraction(attacker, ent))
;1363:		//	continue;
;1364:
;1365:		// find the distance from the edge of the bounding box
;1366:		for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $593
line 1367
;1367:			if ( origin[i] < ent->r.absmin[i] ) {
ADDRLP4 4176
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4176
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 4176
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 464
ADDP4
ADDP4
INDIRF4
GEF4 $597
line 1368
;1368:				v[i] = ent->r.absmin[i] - origin[i];
ADDRLP4 4180
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4180
INDIRI4
ADDRLP4 8
ADDP4
ADDRLP4 4180
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 464
ADDP4
ADDP4
INDIRF4
ADDRLP4 4180
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1369
;1369:			} else if ( origin[i] > ent->r.absmax[i] ) {
ADDRGP4 $598
JUMPV
LABELV $597
ADDRLP4 4180
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4180
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 4180
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRF4
LEF4 $599
line 1370
;1370:				v[i] = origin[i] - ent->r.absmax[i];
ADDRLP4 4184
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4184
INDIRI4
ADDRLP4 8
ADDP4
ADDRLP4 4184
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 4184
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1371
;1371:			} else {
ADDRGP4 $600
JUMPV
LABELV $599
line 1372
;1372:				v[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
CNSTF4 0
ASGNF4
line 1373
;1373:			}
LABELV $600
LABELV $598
line 1374
;1374:		}
LABELV $594
line 1366
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $593
line 1376
;1375:
;1376:		dist = VectorLength( v );
ADDRLP4 8
ARGP4
ADDRLP4 4176
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 4176
INDIRF4
ASGNF4
line 1377
;1377:		if ( dist >= radius ) {
ADDRLP4 24
INDIRF4
ADDRFP4 12
INDIRF4
LTF4 $601
line 1378
;1378:			continue;
ADDRGP4 $586
JUMPV
LABELV $601
line 1382
;1379:		}
;1380:		
;1381:
;1382:		points = damage * ( 1.0 - dist / radius );
ADDRLP4 40
ADDRFP4 8
INDIRF4
CNSTF4 1065353216
ADDRLP4 24
INDIRF4
ADDRFP4 12
INDIRF4
DIVF4
SUBF4
MULF4
ASGNF4
line 1385
;1383:
;1384:
;1385:		if( (CanDamage (ent, origin)) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4180
ADDRGP4 CanDamage
CALLI4
ASGNI4
ADDRLP4 4180
INDIRI4
CNSTI4 0
EQI4 $603
line 1386
;1386:			if( LogAccuracyHit( ent, attacker ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4184
ADDRGP4 LogAccuracyHit
CALLI4
ASGNI4
ADDRLP4 4184
INDIRI4
CNSTI4 0
EQI4 $605
line 1387
;1387:				hitClient = qtrue;
ADDRLP4 4168
CNSTI4 1
ASGNI4
line 1388
;1388:			}
LABELV $605
line 1389
;1389:			VectorSubtract (ent->r.currentOrigin, origin, dir);
ADDRLP4 4192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 4
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 4192
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 28+4
ADDRLP4 4
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 4192
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 28+8
ADDRLP4 4
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1394
;1390:			// push the center of mass higher than the origin so players
;1391:			// get knocked into the air more
;1392:			//dir[2] += 24;
;1393:			// CPM: Add some extra knockback
;1394:			if (ent == attacker) { // rjumps are same as in normal Q3A
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
NEU4 $609
line 1395
;1395:				dir[2] +=24;
ADDRLP4 28+8
ADDRLP4 28+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 1396
;1396:			} else {
ADDRGP4 $610
JUMPV
LABELV $609
line 1397
;1397:				dir[2] += cpm_knockback_z; //24;
ADDRLP4 28+8
ADDRLP4 28+8
INDIRF4
ADDRGP4 cpm_knockback_z
INDIRF4
ADDF4
ASGNF4
line 1398
;1398:			}
LABELV $610
line 1400
;1399:			// !CPM
;1400:			G_Damage (ent, NULL, attacker, dir, origin, (int)points, DAMAGE_RADIUS, mod);
ADDRLP4 4
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
INDIRF4
CVFI4 4
ARGI4
CNSTI4 1
ARGI4
ADDRFP4 20
INDIRI4
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 1401
;1401:		}
LABELV $603
line 1402
;1402:	}
LABELV $586
line 1354
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $588
ADDRLP4 20
INDIRI4
ADDRLP4 4140
INDIRI4
LTI4 $585
line 1404
;1403:
;1404:	return hitClient;
ADDRLP4 4168
INDIRI4
RETI4
LABELV $578
endproc G_RadiusDamage 4196 32
export CPM_RadiusDamage
proc CPM_RadiusDamage 4256 32
line 1408
;1405:}
;1406:// New radius damage function (called if radiusDamageFix is enabled)
;1407:qboolean CPM_RadiusDamage( vec3_t origin, gentity_t *attacker, float damage, float radius,
;1408:					 gentity_t *ignore, int mod, vec3_t viewpoint ) {
line 1417
;1409:	float		points, dist;
;1410:	gentity_t	*ent;
;1411:	int			entityList[MAX_GENTITIES];
;1412:	int			numListedEntities;
;1413:	vec3_t		mins, maxs;
;1414:	vec3_t		v;
;1415:	vec3_t		dir;
;1416:	int			i, e;
;1417:	qboolean	hitClient = qfalse;
ADDRLP4 4224
CNSTI4 0
ASGNI4
line 1420
;1418:	trace_t		tr;
;1419:
;1420:	if ( radius < 1 ) {
ADDRFP4 12
INDIRF4
CNSTF4 1065353216
GEF4 $614
line 1421
;1421:		radius = 1;
ADDRFP4 12
CNSTF4 1065353216
ASGNF4
line 1422
;1422:	}
LABELV $614
line 1424
;1423:
;1424:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $616
line 1425
;1425:		mins[i] = origin[i] - radius;
ADDRLP4 4228
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4228
INDIRI4
ADDRLP4 4200
ADDP4
ADDRLP4 4228
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRFP4 12
INDIRF4
SUBF4
ASGNF4
line 1426
;1426:		maxs[i] = origin[i] + radius;
ADDRLP4 4232
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4232
INDIRI4
ADDRLP4 4212
ADDP4
ADDRLP4 4232
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRFP4 12
INDIRF4
ADDF4
ASGNF4
line 1427
;1427:	}
LABELV $617
line 1424
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $616
line 1429
;1428:
;1429:	numListedEntities = trap_EntitiesInBox( mins, maxs, entityList, MAX_GENTITIES );
ADDRLP4 4200
ARGP4
ADDRLP4 4212
ARGP4
ADDRLP4 100
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 4228
ADDRGP4 trap_EntitiesInBox
CALLI4
ASGNI4
ADDRLP4 4196
ADDRLP4 4228
INDIRI4
ASGNI4
line 1431
;1430:
;1431:	for ( e = 0 ; e < numListedEntities ; e++ ) {
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRGP4 $623
JUMPV
LABELV $620
line 1432
;1432:		ent = &g_entities[entityList[ e ]];
ADDRLP4 4
CNSTI4 896
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 100
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1434
;1433:
;1434:		if (ent == ignore)
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRFP4 16
INDIRP4
CVPU4 4
NEU4 $624
line 1435
;1435:			continue;
ADDRGP4 $621
JUMPV
LABELV $624
line 1436
;1436:		if (!ent->takedamage)
ADDRLP4 4
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
NEI4 $626
line 1437
;1437:			continue;
ADDRGP4 $621
JUMPV
LABELV $626
line 1440
;1438:
;1439:		// find the distance from the edge of the bounding box
;1440:		for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $628
line 1441
;1441:			if ( origin[i] < ent->r.absmin[i] ) {
ADDRLP4 4232
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4232
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 4232
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 464
ADDP4
ADDP4
INDIRF4
GEF4 $632
line 1442
;1442:				v[i] = ent->r.absmin[i] - origin[i];
ADDRLP4 4236
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4236
INDIRI4
ADDRLP4 8
ADDP4
ADDRLP4 4236
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 464
ADDP4
ADDP4
INDIRF4
ADDRLP4 4236
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1443
;1443:			} else if ( origin[i] > ent->r.absmax[i] ) {
ADDRGP4 $633
JUMPV
LABELV $632
ADDRLP4 4236
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4236
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 4236
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRF4
LEF4 $634
line 1444
;1444:				v[i] = origin[i] - ent->r.absmax[i];
ADDRLP4 4240
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4240
INDIRI4
ADDRLP4 8
ADDP4
ADDRLP4 4240
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 4240
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1445
;1445:			} else {
ADDRGP4 $635
JUMPV
LABELV $634
line 1446
;1446:				v[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
CNSTF4 0
ASGNF4
line 1447
;1447:			}
LABELV $635
LABELV $633
line 1448
;1448:		}
LABELV $629
line 1440
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $628
line 1450
;1449:
;1450:		dist = VectorLength( v );
ADDRLP4 8
ARGP4
ADDRLP4 4232
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 4232
INDIRF4
ASGNF4
line 1451
;1451:		if ( dist >= radius ) {
ADDRLP4 24
INDIRF4
ADDRFP4 12
INDIRF4
LTF4 $636
line 1452
;1452:			continue;
ADDRGP4 $621
JUMPV
LABELV $636
line 1456
;1453:		}
;1454:
;1455:		// Make sure the ent is visible from the viewpoint! // KHAILE
;1456:		trap_Trace (&tr, viewpoint, NULL, NULL, ent->r.currentOrigin, ENTITYNUM_NONE, MASK_SOLID);		
ADDRLP4 40
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
ADDRLP4 4236
CNSTP4 0
ASGNP4
ADDRLP4 4236
INDIRP4
ARGP4
ADDRLP4 4236
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1457
;1457:		if ( tr.fraction != 1.0 ) {
ADDRLP4 40+8
INDIRF4
CNSTF4 1065353216
EQF4 $638
line 1458
;1458:			continue;		// we hit something solid enough to stop the blast
ADDRGP4 $621
JUMPV
LABELV $638
line 1462
;1459:		}		
;1460:		// !KHAILE
;1461:
;1462:		points = damage * ( 1.0 - dist / radius );
ADDRLP4 96
ADDRFP4 8
INDIRF4
CNSTF4 1065353216
ADDRLP4 24
INDIRF4
ADDRFP4 12
INDIRF4
DIVF4
SUBF4
MULF4
ASGNF4
line 1464
;1463:
;1464:		if( CanDamage (ent, origin) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4240
ADDRGP4 CanDamage
CALLI4
ASGNI4
ADDRLP4 4240
INDIRI4
CNSTI4 0
EQI4 $641
line 1465
;1465:			if( LogAccuracyHit( ent, attacker ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4244
ADDRGP4 LogAccuracyHit
CALLI4
ASGNI4
ADDRLP4 4244
INDIRI4
CNSTI4 0
EQI4 $643
line 1466
;1466:				hitClient = qtrue;
ADDRLP4 4224
CNSTI4 1
ASGNI4
line 1467
;1467:			}
LABELV $643
line 1468
;1468:			VectorSubtract (ent->r.currentOrigin, origin, dir);
ADDRLP4 4252
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 4
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 4252
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 28+4
ADDRLP4 4
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 4252
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 28+8
ADDRLP4 4
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1472
;1469:			// push the center of mass higher than the origin so players
;1470:			// get knocked into the air more
;1471:			// CPM: Add some extra knockback
;1472:			if (ent == attacker) { // rjumps are same as in normal Q3A
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
NEU4 $647
line 1473
;1473:				dir[2] +=24;
ADDRLP4 28+8
ADDRLP4 28+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 1474
;1474:			} else {
ADDRGP4 $648
JUMPV
LABELV $647
line 1475
;1475:				dir[2] += cpm_knockback_z; //24;
ADDRLP4 28+8
ADDRLP4 28+8
INDIRF4
ADDRGP4 cpm_knockback_z
INDIRF4
ADDF4
ASGNF4
line 1476
;1476:			}
LABELV $648
line 1478
;1477:			// !CPM
;1478:			G_Damage (ent, NULL, attacker, dir, origin, (int)points, DAMAGE_RADIUS, mod);
ADDRLP4 4
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 96
INDIRF4
CVFI4 4
ARGI4
CNSTI4 1
ARGI4
ADDRFP4 20
INDIRI4
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 1479
;1479:		}
LABELV $641
line 1480
;1480:	}
LABELV $621
line 1431
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $623
ADDRLP4 20
INDIRI4
ADDRLP4 4196
INDIRI4
LTI4 $620
line 1482
;1481:
;1482:	return hitClient;
ADDRLP4 4224
INDIRI4
RETI4
LABELV $613
endproc CPM_RadiusDamage 4256 32
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
import G_InvulnerabilityEffect
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
LABELV $244
byte 1 75
byte 1 105
byte 1 108
byte 1 108
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $243
byte 1 60
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 111
byte 1 98
byte 1 105
byte 1 116
byte 1 117
byte 1 97
byte 1 114
byte 1 121
byte 1 62
byte 1 0
align 1
LABELV $236
byte 1 60
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 62
byte 1 0
align 1
LABELV $235
byte 1 60
byte 1 110
byte 1 111
byte 1 110
byte 1 45
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 62
byte 1 0
align 1
LABELV $214
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $213
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $193
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
LABELV $192
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
LABELV $181
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 71
byte 1 82
byte 1 65
byte 1 80
byte 1 80
byte 1 76
byte 1 69
byte 1 0
align 1
LABELV $180
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 84
byte 1 82
byte 1 73
byte 1 71
byte 1 71
byte 1 69
byte 1 82
byte 1 95
byte 1 72
byte 1 85
byte 1 82
byte 1 84
byte 1 0
align 1
LABELV $179
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 84
byte 1 65
byte 1 82
byte 1 71
byte 1 69
byte 1 84
byte 1 95
byte 1 76
byte 1 65
byte 1 83
byte 1 69
byte 1 82
byte 1 0
align 1
LABELV $178
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 83
byte 1 85
byte 1 73
byte 1 67
byte 1 73
byte 1 68
byte 1 69
byte 1 0
align 1
LABELV $177
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 70
byte 1 65
byte 1 76
byte 1 76
byte 1 73
byte 1 78
byte 1 71
byte 1 0
align 1
LABELV $176
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 84
byte 1 69
byte 1 76
byte 1 69
byte 1 70
byte 1 82
byte 1 65
byte 1 71
byte 1 0
align 1
LABELV $175
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 67
byte 1 82
byte 1 85
byte 1 83
byte 1 72
byte 1 0
align 1
LABELV $174
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 76
byte 1 65
byte 1 86
byte 1 65
byte 1 0
align 1
LABELV $173
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 83
byte 1 76
byte 1 73
byte 1 77
byte 1 69
byte 1 0
align 1
LABELV $172
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 87
byte 1 65
byte 1 84
byte 1 69
byte 1 82
byte 1 0
align 1
LABELV $171
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 66
byte 1 70
byte 1 71
byte 1 95
byte 1 83
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 72
byte 1 0
align 1
LABELV $170
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 66
byte 1 70
byte 1 71
byte 1 0
align 1
LABELV $169
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 76
byte 1 73
byte 1 71
byte 1 72
byte 1 84
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 0
align 1
LABELV $168
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 82
byte 1 65
byte 1 73
byte 1 76
byte 1 71
byte 1 85
byte 1 78
byte 1 0
align 1
LABELV $167
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 77
byte 1 65
byte 1 95
byte 1 83
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 72
byte 1 0
align 1
LABELV $166
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 77
byte 1 65
byte 1 0
align 1
LABELV $165
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 82
byte 1 79
byte 1 67
byte 1 75
byte 1 69
byte 1 84
byte 1 95
byte 1 83
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 72
byte 1 0
align 1
LABELV $164
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 82
byte 1 79
byte 1 67
byte 1 75
byte 1 69
byte 1 84
byte 1 0
align 1
LABELV $163
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 71
byte 1 82
byte 1 69
byte 1 78
byte 1 65
byte 1 68
byte 1 69
byte 1 95
byte 1 83
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 72
byte 1 0
align 1
LABELV $162
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 71
byte 1 82
byte 1 69
byte 1 78
byte 1 65
byte 1 68
byte 1 69
byte 1 0
align 1
LABELV $161
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 77
byte 1 65
byte 1 67
byte 1 72
byte 1 73
byte 1 78
byte 1 69
byte 1 71
byte 1 85
byte 1 78
byte 1 0
align 1
LABELV $160
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 71
byte 1 65
byte 1 85
byte 1 78
byte 1 84
byte 1 76
byte 1 69
byte 1 84
byte 1 0
align 1
LABELV $159
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 83
byte 1 72
byte 1 79
byte 1 84
byte 1 71
byte 1 85
byte 1 78
byte 1 0
align 1
LABELV $158
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 85
byte 1 78
byte 1 75
byte 1 78
byte 1 79
byte 1 87
byte 1 78
byte 1 0
align 1
LABELV $151
byte 1 107
byte 1 97
byte 1 109
byte 1 105
byte 1 107
byte 1 97
byte 1 122
byte 1 101
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
