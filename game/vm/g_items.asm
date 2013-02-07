export Pickup_Powerup
code
proc Pickup_Powerup 132 28
file "../g_items.c"
line 30
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:#include "g_local.h"
;4:#include "bg_promode.h"
;5:
;6:/*
;7:
;8:  Items are any object that a player can touch to gain some effect.
;9:
;10:  Pickup will return the number of seconds until they should respawn.
;11:
;12:  all items should pop when dropped in lava or slime
;13:
;14:  Respawnable items don't actually go away when picked up, they are
;15:  just made invisible and untouchable.  This allows them to ride
;16:  movers and respawn apropriately.
;17:*/
;18:
;19:
;20:#define	RESPAWN_ARMOR		25
;21:#define	RESPAWN_HEALTH		35
;22:#define	RESPAWN_AMMO		40
;23:#define	RESPAWN_HOLDABLE	60
;24:#define	RESPAWN_MEGAHEALTH	35//120
;25:#define	RESPAWN_POWERUP		120
;26:
;27:
;28://======================================================================
;29:
;30:int Pickup_Powerup( gentity_t *ent, gentity_t *other ) {
line 35
;31:	int			quantity;
;32:	int			i;
;33:	gclient_t	*client;
;34:
;35:	if ( other->client->spawnProtection == qtrue) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10824
ADDP4
INDIRI4
CNSTI4 1
NEI4 $68
line 37
;36:		//FIXME: Should we really turn off spawn protection just because we grabbed a power up?
;37:		other->client->spawnProtection = qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10824
ADDP4
CNSTI4 0
ASGNI4
line 38
;38:	}
LABELV $68
line 40
;39:
;40:	if ( !other->client->ps.powerups[ent->item->giTag] ) {
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $70
line 43
;41:		// round timing to seconds to make multiple powerup timers
;42:		// count in sync
;43:		other->client->ps.powerups[ent->item->giTag] = 
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
ADDRGP4 level+40
INDIRI4
ADDRGP4 level+40
INDIRI4
CNSTI4 1000
MODI4
SUBI4
ASGNI4
line 45
;44:			level.time - ( level.time % 1000 );
;45:	}
LABELV $70
line 47
;46:
;47:	if ( ent->count ) {
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $74
line 48
;48:		quantity = ent->count;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ASGNI4
line 49
;49:	} else {
ADDRGP4 $75
JUMPV
LABELV $74
line 50
;50:		quantity = ent->item->quantity;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ASGNI4
line 51
;51:	}
LABELV $75
line 53
;52:
;53:	other->client->ps.powerups[ent->item->giTag] += quantity * 1000;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1000
ADDRLP4 8
INDIRI4
MULI4
ADDI4
ASGNI4
line 56
;54:
;55:	// give any nearby players a "denied" anti-reward
;56:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $79
JUMPV
LABELV $76
line 62
;57:		vec3_t		delta;
;58:		float		len;
;59:		vec3_t		forward;
;60:		trace_t		tr;
;61:
;62:		client = &level.clients[i];
ADDRLP4 0
CNSTI4 10828
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 63
;63:		if ( client == other->client ) {
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
NEU4 $81
line 64
;64:			continue;
ADDRGP4 $77
JUMPV
LABELV $81
line 66
;65:		}
;66:		if ( client->pers.connected == CON_DISCONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $83
line 67
;67:			continue;
ADDRGP4 $77
JUMPV
LABELV $83
line 69
;68:		}
;69:		if ( client->ps.stats[STAT_HEALTH] <= 0 ) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $85
line 70
;70:			continue;
ADDRGP4 $77
JUMPV
LABELV $85
line 75
;71:		}
;72:
;73:    // if same team in team game, no sound
;74:    // cannot use OnSameTeam as it expects to g_entities, not clients
;75:  	if ( g_gametype.integer >= GT_TEAM && other->client->sess.sessionTeam == client->sess.sessionTeam  ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $87
ADDRLP4 100
CNSTI4 10188
ASGNI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ADDRLP4 100
INDIRI4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
ADDRLP4 100
INDIRI4
ADDP4
INDIRI4
NEI4 $87
line 76
;76:      continue;
ADDRGP4 $77
JUMPV
LABELV $87
line 79
;77:    }
;78://freeze
;79:	if ( g_gamemode.integer > 3 ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $90
line 80
;80:		if ( is_spectator( other->client ) ) continue;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 104
ADDRGP4 is_spectator
CALLI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 0
EQI4 $93
ADDRGP4 $77
JUMPV
LABELV $93
line 81
;81:	}
LABELV $90
line 85
;82://freeze
;83:
;84:		// if too far away, no sound
;85:		VectorSubtract( ent->s.pos.trBase, client->ps.origin, delta );
ADDRLP4 104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 108
CNSTI4 24
ASGNI4
ADDRLP4 16
ADDRLP4 104
INDIRP4
ADDRLP4 108
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 104
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 108
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 16+8
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
line 86
;86:		len = VectorNormalize( delta );
ADDRLP4 16
ARGP4
ADDRLP4 116
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 40
ADDRLP4 116
INDIRF4
ASGNF4
line 87
;87:		if ( len > 192 ) {
ADDRLP4 40
INDIRF4
CNSTF4 1128267776
LEF4 $97
line 88
;88:			continue;
ADDRGP4 $77
JUMPV
LABELV $97
line 95
;89:		}
;90:
;91:		// if not facing, no sound
;92:		//if ( g_AdvancedDamage.integer == 0 ) {
;93:			//I personally don't care what direction we're facing
;94:			//Play the sound, players can back into it.
;95:		AngleVectors( client->ps.viewangles, forward, NULL, NULL );
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 120
CNSTP4 0
ASGNP4
ADDRLP4 120
INDIRP4
ARGP4
ADDRLP4 120
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 96
;96:		if ( DotProduct( delta, forward ) < 0.4 ) {
ADDRLP4 16
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ADDRLP4 16+4
INDIRF4
ADDRLP4 28+4
INDIRF4
MULF4
ADDF4
ADDRLP4 16+8
INDIRF4
ADDRLP4 28+8
INDIRF4
MULF4
ADDF4
CNSTF4 1053609165
GEF4 $99
line 97
;97:			continue;
ADDRGP4 $77
JUMPV
LABELV $99
line 102
;98:		}
;99:		//}
;100:
;101:		// if not line of sight, no sound
;102:		trap_Trace( &tr, client->ps.origin, NULL, NULL, ent->s.pos.trBase, ENTITYNUM_NONE, CONTENTS_SOLID );
ADDRLP4 44
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 124
CNSTP4 0
ASGNP4
ADDRLP4 124
INDIRP4
ARGP4
ADDRLP4 124
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 103
;103:		if ( tr.fraction != 1.0 ) {
ADDRLP4 44+8
INDIRF4
CNSTF4 1065353216
EQF4 $105
line 104
;104:			continue;
ADDRGP4 $77
JUMPV
LABELV $105
line 108
;105:		}
;106:
;107:		// anti-reward
;108:		client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_DENIEDREWARD;
ADDRLP4 128
ADDRLP4 0
INDIRP4
CNSTI4 268
ADDP4
ASGNP4
ADDRLP4 128
INDIRP4
ADDRLP4 128
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 109
;109:	}
LABELV $77
line 56
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $79
ADDRLP4 4
INDIRI4
ADDRGP4 level+28
INDIRI4
LTI4 $76
line 112
;110:	//return RESPAWN_POWERUP;
;111:	// CPM: Battle Suit uses different respawn times from the other powerups in cpm
;112:	return (ent->item->giTag == PW_BATTLESUIT) ? cpm_itemrespawnBS : cpm_itemrespawnpowerup; // CPM
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
NEI4 $109
ADDRLP4 16
ADDRGP4 cpm_itemrespawnBS
INDIRI4
ASGNI4
ADDRGP4 $110
JUMPV
LABELV $109
ADDRLP4 16
ADDRGP4 cpm_itemrespawnpowerup
INDIRI4
ASGNI4
LABELV $110
ADDRLP4 16
INDIRI4
RETI4
LABELV $67
endproc Pickup_Powerup 132 28
export Pickup_Holdable
proc Pickup_Holdable 4 0
line 192
;113:}
;114:
;115://======================================================================
;116:
;117:#ifdef MISSIONPACK
;118:int Pickup_PersistantPowerup( gentity_t *ent, gentity_t *other ) {
;119:	int		clientNum;
;120:	char	userinfo[MAX_INFO_STRING];
;121:	float	handicap;
;122:	int		max;
;123:
;124:	other->client->ps.stats[STAT_PERSISTANT_POWERUP] = ent->item - bg_itemlist;
;125:	other->client->persistantPowerup = ent;
;126:
;127:	switch( ent->item->giTag ) {
;128:	case PW_GUARD:
;129:		clientNum = other->client->ps.clientNum;
;130:		trap_GetUserinfo( clientNum, userinfo, sizeof(userinfo) );
;131:		handicap = atof( Info_ValueForKey( userinfo, "handicap" ) );
;132:		if( handicap<=0.0f || handicap>100.0f) {
;133:			handicap = 100.0f;
;134:		}
;135:		max = (int)(2 *  handicap);
;136:
;137:		other->health = max;
;138:		other->client->ps.stats[STAT_HEALTH] = max;
;139:		other->client->ps.stats[STAT_MAX_HEALTH] = max;
;140:		other->client->ps.stats[STAT_ARMOR] = max;
;141:		other->client->pers.maxHealth = max;
;142:
;143:		break;
;144:
;145:	case PW_SCOUT:
;146:		clientNum = other->client->ps.clientNum;
;147:		trap_GetUserinfo( clientNum, userinfo, sizeof(userinfo) );
;148:		handicap = atof( Info_ValueForKey( userinfo, "handicap" ) );
;149:		if( handicap<=0.0f || handicap>100.0f) {
;150:			handicap = 100.0f;
;151:		}
;152:		other->client->pers.maxHealth = handicap;
;153:		other->client->ps.stats[STAT_ARMOR] = 0;
;154:		break;
;155:
;156:	case PW_DOUBLER:
;157:		clientNum = other->client->ps.clientNum;
;158:		trap_GetUserinfo( clientNum, userinfo, sizeof(userinfo) );
;159:		handicap = atof( Info_ValueForKey( userinfo, "handicap" ) );
;160:		if( handicap<=0.0f || handicap>100.0f) {
;161:			handicap = 100.0f;
;162:		}
;163:		other->client->pers.maxHealth = handicap;
;164:		break;
;165:	case PW_AMMOREGEN:
;166:		clientNum = other->client->ps.clientNum;
;167:		trap_GetUserinfo( clientNum, userinfo, sizeof(userinfo) );
;168:		handicap = atof( Info_ValueForKey( userinfo, "handicap" ) );
;169:		if( handicap<=0.0f || handicap>100.0f) {
;170:			handicap = 100.0f;
;171:		}
;172:		other->client->pers.maxHealth = handicap;
;173:		memset(other->client->ammoTimes, 0, sizeof(other->client->ammoTimes));
;174:		break;
;175:	default:
;176:		clientNum = other->client->ps.clientNum;
;177:		trap_GetUserinfo( clientNum, userinfo, sizeof(userinfo) );
;178:		handicap = atof( Info_ValueForKey( userinfo, "handicap" ) );
;179:		if( handicap<=0.0f || handicap>100.0f) {
;180:			handicap = 100.0f;
;181:		}
;182:		other->client->pers.maxHealth = handicap;
;183:		break;
;184:	}
;185:
;186:	return -1;
;187:}
;188:
;189://======================================================================
;190:#endif
;191:
;192:int Pickup_Holdable( gentity_t *ent, gentity_t *other ) {
line 194
;193:
;194:	other->client->ps.stats[STAT_HOLDABLE_ITEM] = ent->item - bg_itemlist;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 188
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
ASGNI4
line 196
;195:
;196:	if( ent->item->giTag == HI_KAMIKAZE ) {
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 3
NEI4 $112
line 197
;197:		other->client->ps.eFlags |= EF_KAMIKAZE;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 198
;198:	}
LABELV $112
line 200
;199:
;200:	return RESPAWN_HOLDABLE;
CNSTI4 60
RETI4
LABELV $111
endproc Pickup_Holdable 4 0
export Add_Ammo
proc Add_Ammo 12 0
line 214
;201:}
;202:
;203:
;204://======================================================================
;205:
;206:/*void Add_Ammo (gentity_t *ent, int weapon, int count)
;207:{
;208:	ent->client->ps.ammo[weapon] += count;
;209:	if ( ent->client->ps.ammo[weapon] > 200 ) {
;210:		ent->client->ps.ammo[weapon] = 200;
;211:	}
;212:}*/
;213:void Add_Ammo (gentity_t *ent, int weapon, int count)
;214:{
line 218
;215:	// CPM: Cap ammo for certain weapons
;216:	int		quantity;
;217:	
;218:	switch (weapon)
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 3
LTI4 $115
ADDRLP4 4
INDIRI4
CNSTI4 7
GTI4 $115
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $122-12
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $122
address $117
address $118
address $119
address $120
address $121
code
line 219
;219:	{
LABELV $117
line 220
;220:		case WP_SHOTGUN: quantity = cpm_SSGmaxammo; break;
ADDRLP4 0
ADDRGP4 cpm_SSGmaxammo
INDIRI4
ASGNI4
ADDRGP4 $116
JUMPV
LABELV $118
line 221
;221:		case WP_GRENADE_LAUNCHER: quantity = cpm_GLmaxammo; break;
ADDRLP4 0
ADDRGP4 cpm_GLmaxammo
INDIRI4
ASGNI4
ADDRGP4 $116
JUMPV
LABELV $119
line 222
;222:		case WP_ROCKET_LAUNCHER: quantity = cpm_RLmaxammo; break;
ADDRLP4 0
ADDRGP4 cpm_RLmaxammo
INDIRI4
ASGNI4
ADDRGP4 $116
JUMPV
LABELV $120
line 223
;223:		case WP_LIGHTNING: quantity = cpm_LGmaxammo; break;
ADDRLP4 0
ADDRGP4 cpm_LGmaxammo
INDIRI4
ASGNI4
ADDRGP4 $116
JUMPV
LABELV $121
line 224
;224:		case WP_RAILGUN: quantity = cpm_RGmaxammo; break;
ADDRLP4 0
ADDRGP4 cpm_RGmaxammo
INDIRI4
ASGNI4
ADDRGP4 $116
JUMPV
LABELV $115
line 225
;225:		default: quantity = 200;
ADDRLP4 0
CNSTI4 200
ASGNI4
line 226
;226:	}
LABELV $116
line 228
;227:
;228:	ent->client->ps.ammo[weapon] += count;
ADDRLP4 8
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
ASGNI4
line 229
;229:	if ( ent->client->ps.ammo[weapon] > quantity ) {
ADDRFP4 4
INDIRI4
CNSTI4 2
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
ADDRLP4 0
INDIRI4
LEI4 $124
line 230
;230:		ent->client->ps.ammo[weapon] = quantity;
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 231
;231:	}
LABELV $124
line 233
;232:	// !CPM
;233:}
LABELV $114
endproc Add_Ammo 12 0
export Pickup_Ammo
proc Pickup_Ammo 16 12
line 236
;234:
;235:int Pickup_Ammo (gentity_t *ent, gentity_t *other)
;236:{
line 239
;237:	int		quantity;
;238:
;239:	if ( ent->count ) {
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $127
line 240
;240:		quantity = ent->count;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ASGNI4
line 241
;241:	} else {
ADDRGP4 $128
JUMPV
LABELV $127
line 244
;242:		//quantity = ent->item->quantity;
;243:		// CPM: Ammo counts from boxes
;244:		switch (ent->item->giTag)
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
CNSTI4 2
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $132
ADDRLP4 4
INDIRI4
ADDRLP4 12
INDIRI4
LTI4 $129
LABELV $134
ADDRLP4 4
INDIRI4
CNSTI4 7
EQI4 $133
ADDRGP4 $129
JUMPV
line 245
;245:		{
LABELV $132
line 246
;246:			case WP_MACHINEGUN: quantity = cpm_MGbox; break;
ADDRLP4 0
ADDRGP4 cpm_MGbox
INDIRF4
CVFI4 4
ASGNI4
ADDRGP4 $130
JUMPV
LABELV $133
line 247
;247:			case WP_RAILGUN: quantity = cpm_RGbox; break;
ADDRLP4 0
ADDRGP4 cpm_RGbox
INDIRI4
ASGNI4
ADDRGP4 $130
JUMPV
LABELV $129
line 248
;248:			default: quantity = ent->item->quantity;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ASGNI4
line 249
;249:		}
LABELV $130
line 251
;250:		// !CPM
;251:	}
LABELV $128
line 253
;252:
;253:	Add_Ammo (other, ent->item->giTag, quantity);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Add_Ammo
CALLV
pop
line 256
;254:
;255:	//return RESPAWN_AMMO;
;256:	return cpm_itemrespawnammo; // CPM
ADDRGP4 cpm_itemrespawnammo
INDIRI4
RETI4
LABELV $126
endproc Pickup_Ammo 16 12
export Pickup_Weapon
proc Pickup_Weapon 8 12
line 262
;257:}
;258:
;259://======================================================================
;260:
;261:
;262:int Pickup_Weapon (gentity_t *ent, gentity_t *other) {
line 265
;263:	int		quantity;
;264:
;265:	if ( ent->count < 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
GEI4 $136
line 266
;266:		quantity = 0; // None for you, sir!
ADDRLP4 0
CNSTI4 0
ASGNI4
line 267
;267:	} else {
ADDRGP4 $137
JUMPV
LABELV $136
line 268
;268:		if ( ent->count ) {
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $138
line 269
;269:			quantity = ent->count;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ASGNI4
line 270
;270:		} else {
ADDRGP4 $139
JUMPV
LABELV $138
line 273
;271:			//quantity = ent->item->quantity;
;272:			// CPM: Ammo counts from weapons
;273:			switch (ent->item->giTag)
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 2
EQI4 $143
ADDRGP4 $140
JUMPV
line 274
;274:			{
LABELV $143
line 275
;275:				case WP_MACHINEGUN: quantity = cpm_MGweapon; break;
ADDRLP4 0
ADDRGP4 cpm_MGweapon
INDIRI4
ASGNI4
ADDRGP4 $141
JUMPV
LABELV $140
line 276
;276:				default: quantity = ent->item->quantity;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ASGNI4
line 277
;277:			}
LABELV $141
line 279
;278:			// !CPM
;279:		}
LABELV $139
line 282
;280:
;281:		// dropped items and teamplay weapons always have full ammo
;282:		if ( ! (ent->flags & FL_DROPPED_ITEM) && g_gametype.integer != GT_TEAM ) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $144
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
EQI4 $144
line 285
;283:			// respawning rules
;284:			// drop the quantity if the already have over the minimum
;285:			if ( other->client->ps.ammo[ ent->item->giTag ] < quantity ) {
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
GEI4 $147
line 286
;286:				quantity = quantity - other->client->ps.ammo[ ent->item->giTag ];
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
SUBI4
ASGNI4
line 287
;287:			} else {
ADDRGP4 $148
JUMPV
LABELV $147
line 288
;288:				quantity = 1;		// only add a single shot
ADDRLP4 0
CNSTI4 1
ASGNI4
line 289
;289:			}
LABELV $148
line 290
;290:		}
LABELV $144
line 291
;291:	}
LABELV $137
line 294
;292:
;293:	// add the weapon
;294:	other->client->ps.stats[STAT_WEAPONS] |= ( 1 << ent->item->giTag );
ADDRLP4 4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 192
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
LSHI4
BORI4
ASGNI4
line 296
;295:
;296:	Add_Ammo( other, ent->item->giTag, quantity );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Add_Ammo
CALLV
pop
line 298
;297:
;298:	if (ent->item->giTag == WP_GRAPPLING_HOOK)
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 10
NEI4 $149
line 299
;299:		other->client->ps.ammo[ent->item->giTag] = -1; // unlimited ammo
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
CNSTI4 -1
ASGNI4
LABELV $149
line 302
;300:
;301:	// team deathmatch has slow weapon respawns
;302:	if ( g_gametype.integer == GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
NEI4 $151
line 303
;303:		return g_weaponTeamRespawn.integer;
ADDRGP4 g_weaponTeamRespawn+12
INDIRI4
RETI4
ADDRGP4 $135
JUMPV
LABELV $151
line 306
;304:	}
;305:
;306:	return g_weaponRespawn.integer;
ADDRGP4 g_weaponRespawn+12
INDIRI4
RETI4
LABELV $135
endproc Pickup_Weapon 8 12
export CPM_HealthDecay
proc CPM_HealthDecay 4 8
line 314
;307:}
;308:
;309:
;310://======================================================================
;311:
;312:// CPM: Megahealth respawn function
;313:void CPM_HealthDecay(gentity_t *ent)
;314:{
line 315
;315:	if (!ent->activator) {
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $157
line 316
;316:		ent->think = RespawnItem;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 RespawnItem
ASGNP4
line 317
;317:		ent->nextthink = level.time + CPM_MEGARESPAWNDELAY * 1000;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 20000
ADDI4
ASGNI4
line 318
;318:		return;
ADDRGP4 $156
JUMPV
LABELV $157
line 321
;319:	}
;320:
;321:	if (strcmp(ent->activator->classname,"player")
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $162
ARGP4
ADDRLP4 0
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $163
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 100
GTI4 $160
LABELV $163
line 322
;322:		|| ent->activator->client->ps.stats[STAT_HEALTH] <= 100) {
line 323
;323:		ent->nextthink = level.time + CPM_MEGARESPAWNDELAY * 1000;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 20000
ADDI4
ASGNI4
line 324
;324:		ent->think = RespawnItem;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 RespawnItem
ASGNP4
line 325
;325:		return;
ADDRGP4 $156
JUMPV
LABELV $160
line 328
;326:	}
;327:
;328:	ent->nextthink = level.time + 1000;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 329
;329:}
LABELV $156
endproc CPM_HealthDecay 4 8
export Pickup_Health
proc Pickup_Health 20 0
line 333
;330:// !CPM
;331:
;332:
;333:int Pickup_Health (gentity_t *ent, gentity_t *other) {
line 344
;334:	int			max;
;335:	int			quantity;
;336:
;337:	// small and mega healths will go over the max
;338:#ifdef MISSIONPACK
;339:	if( other->client && bg_itemlist[other->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_GUARD ) {
;340:		max = other->client->ps.stats[STAT_MAX_HEALTH];
;341:	}
;342:	else
;343:#endif
;344:	if ( ent->item->quantity != 5 && ent->item->quantity != 100 ) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 5
EQI4 $167
ADDRLP4 8
INDIRI4
CNSTI4 100
EQI4 $167
line 345
;345:		max = other->client->ps.stats[STAT_MAX_HEALTH];
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ASGNI4
line 346
;346:	} else {
ADDRGP4 $168
JUMPV
LABELV $167
line 347
;347:		max = other->client->ps.stats[STAT_MAX_HEALTH] * 2;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 348
;348:	}
LABELV $168
line 350
;349:
;350:	if ( ent->count ) {
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $169
line 351
;351:		quantity = ent->count;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ASGNI4
line 352
;352:	} else {
ADDRGP4 $170
JUMPV
LABELV $169
line 353
;353:		quantity = ent->item->quantity;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ASGNI4
line 354
;354:	}
LABELV $170
line 356
;355:
;356:	other->health += quantity;
ADDRLP4 12
ADDRFP4 4
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 358
;357:
;358:	if (other->health > max ) {
ADDRFP4 4
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $171
line 359
;359:		other->health = max;
ADDRFP4 4
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 360
;360:	}
LABELV $171
line 361
;361:	other->client->ps.stats[STAT_HEALTH] = other->health;
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ASGNI4
line 367
;362:
;363:	//if ( ent->item->giTag == 100 ) {		// mega health respawns slow
;364:	//	return RESPAWN_MEGAHEALTH;
;365:	//}
;366:	// CPM: Megahealth system
;367:	if ( ent->item->quantity == 100 ) {		// mega health respawns slow
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 100
NEI4 $173
line 369
;368:		//if (cpm_megastyle)
;369:		if ( g_pro_mode.integer ) {
ADDRGP4 g_pro_mode+12
INDIRI4
CNSTI4 0
EQI4 $175
line 370
;370:			if (g_gametype.integer >= GT_TEAM)
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $178
line 371
;371:				return RESPAWN_MEGAHEALTH;
CNSTI4 35
RETI4
ADDRGP4 $166
JUMPV
LABELV $178
line 372
;372:			ent->think = CPM_HealthDecay;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 CPM_HealthDecay
ASGNP4
line 373
;373:			ent->activator = other;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
ADDRFP4 4
INDIRP4
ASGNP4
line 374
;374:			return 1; // nextthink will be one second
CNSTI4 1
RETI4
ADDRGP4 $166
JUMPV
LABELV $175
line 376
;375:		}
;376:		return RESPAWN_HEALTH; // due to a bug in the vq3 code, this must return health respawn
CNSTI4 35
RETI4
ADDRGP4 $166
JUMPV
LABELV $173
line 383
;377:			// and not megahealth respawn (or else megahealth wont respawn once every 35 seconds
;378:			// on maps like q3dm13)
;379:	}
;380:	// !CPM
;381:
;382:	//return RESPAWN_HEALTH;
;383:	return cpm_itemrespawnhealth; // CPM
ADDRGP4 cpm_itemrespawnhealth
INDIRI4
RETI4
LABELV $166
endproc Pickup_Health 20 0
export Pickup_Armor
proc Pickup_Armor 12 0
line 413
;384:}
;385:
;386://======================================================================
;387:
;388:/*int Pickup_Armor( gentity_t *ent, gentity_t *other ) {
;389:#ifdef MISSIONPACK
;390:	int		upperBound;
;391:
;392:	other->client->ps.stats[STAT_ARMOR] += ent->item->quantity;
;393:
;394:	if( other->client && bg_itemlist[other->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_GUARD ) {
;395:		upperBound = other->client->ps.stats[STAT_MAX_HEALTH];
;396:	}
;397:	else {
;398:		upperBound = other->client->ps.stats[STAT_MAX_HEALTH] * 2;
;399:	}
;400:
;401:	if ( other->client->ps.stats[STAT_ARMOR] > upperBound ) {
;402:		other->client->ps.stats[STAT_ARMOR] = upperBound;
;403:	}
;404:#else
;405:	other->client->ps.stats[STAT_ARMOR] += ent->item->quantity;
;406:	if ( other->client->ps.stats[STAT_ARMOR] > other->client->ps.stats[STAT_MAX_HEALTH] * 2 ) {
;407:		other->client->ps.stats[STAT_ARMOR] = other->client->ps.stats[STAT_MAX_HEALTH] * 2;
;408:	}
;409:#endif
;410:
;411:	return RESPAWN_ARMOR;
;412:}*/
;413:int Pickup_Armor( gentity_t *ent, gentity_t *other ) {
line 415
;414:	// CPM: vq3 armor system
;415:	if (!g_pro_mode.integer) {
ADDRGP4 g_pro_mode+12
INDIRI4
CNSTI4 0
NEI4 $182
line 417
;416:	// !CPM
;417:		other->client->ps.stats[STAT_ARMOR] += ent->item->quantity;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 196
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ADDI4
ASGNI4
line 418
;418:		if ( other->client->ps.stats[STAT_ARMOR] > other->client->ps.stats[STAT_MAX_HEALTH] * 2 ) {
ADDRLP4 4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1
LSHI4
LEI4 $185
line 419
;419:			other->client->ps.stats[STAT_ARMOR] = other->client->ps.stats[STAT_MAX_HEALTH] * 2;
ADDRLP4 8
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 420
;420:		}
LABELV $185
line 422
;421:
;422:		return RESPAWN_ARMOR;
CNSTI4 25
RETI4
ADDRGP4 $181
JUMPV
LABELV $182
line 427
;423:	// CPM
;424:	}
;425:	
;426:	// cpm armor system
;427:	if ( ent->item->quantity == 100 ) { // RA
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 100
NEI4 $187
line 428
;428:		other->client->ps.stats[STAT_ARMOR] = 200;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 196
ADDP4
CNSTI4 200
ASGNI4
line 429
;429:		other->client->ps.stats[STAT_ARMORTYPE] = 2;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 216
ADDP4
CNSTI4 2
ASGNI4
line 430
;430:	} else if ( ent->item->quantity == 50 ) { // YA
ADDRGP4 $188
JUMPV
LABELV $187
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 50
NEI4 $189
line 431
;431:		if (other->client->ps.stats[STAT_ARMORTYPE] == 2) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CNSTI4 2
NEI4 $191
line 432
;432:			other->client->ps.stats[STAT_ARMOR] *= CPM_RAMULTIPLIER;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 196
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTF4 1067450368
ADDRLP4 0
INDIRP4
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 433
;433:		}
LABELV $191
line 435
;434:
;435:		other->client->ps.stats[STAT_ARMOR] += 100;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 196
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 436
;436:		if (other->client->ps.stats[STAT_ARMOR] > 150) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 150
LEI4 $193
line 437
;437:			other->client->ps.stats[STAT_ARMOR] = 150;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 196
ADDP4
CNSTI4 150
ASGNI4
line 438
;438:		}
LABELV $193
line 439
;439:		other->client->ps.stats[STAT_ARMORTYPE] = 1;
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 216
ADDP4
CNSTI4 1
ASGNI4
line 440
;440:	} else {// Shard
ADDRGP4 $190
JUMPV
LABELV $189
line 442
;441:		//G_Printf("DBG: Pickup Shard\n");
;442:		if (other->client->ps.stats[STAT_ARMOR] >= 0) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
LTI4 $195
line 443
;443:			other->client->ps.stats[STAT_ARMORTYPE] = 1; // YA protection
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 216
ADDP4
CNSTI4 1
ASGNI4
line 444
;444:		}
LABELV $195
line 445
;445:		other->client->ps.stats[STAT_ARMOR] += 2;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 196
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 446
;446:	}
LABELV $190
LABELV $188
line 448
;447:
;448:	return RESPAWN_ARMOR; // 25 seconds
CNSTI4 25
RETI4
LABELV $181
endproc Pickup_Armor 12 0
export RespawnItem
proc RespawnItem 28 12
line 459
;449:	// !CPM
;450:}
;451:
;452://======================================================================
;453:
;454:/*
;455:===============
;456:RespawnItem
;457:===============
;458:*/
;459:void RespawnItem( gentity_t *ent ) {
line 461
;460:	// randomly select from teamed entities
;461:	if (ent->team) {
ADDRFP4 0
INDIRP4
CNSTI4 656
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $198
line 466
;462:		gentity_t	*master;
;463:		int	count;
;464:		int choice;
;465:
;466:		if ( !ent->teammaster ) {
ADDRFP4 0
INDIRP4
CNSTI4 780
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $200
line 467
;467:			G_Error( "RespawnItem: bad teammaster");
ADDRGP4 $202
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 468
;468:		}
LABELV $200
line 469
;469:		master = ent->teammaster;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 780
ADDP4
INDIRP4
ASGNP4
line 471
;470:
;471:		for (count = 0, ent = master; ent; ent = ent->teamchain, count++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRFP4 0
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $206
JUMPV
LABELV $203
line 472
;472:			;
LABELV $204
line 471
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $206
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $203
line 474
;473:
;474:		choice = rand() % count;
ADDRLP4 12
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
ADDRLP4 0
INDIRI4
MODI4
ASGNI4
line 476
;475:
;476:		for (count = 0, ent = master; count < choice; ent = ent->teamchain, count++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRFP4 0
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $210
JUMPV
LABELV $207
line 477
;477:			;
LABELV $208
line 476
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $210
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $207
line 478
;478:	}
LABELV $198
line 480
;479:
;480:	ent->r.contents = CONTENTS_TRIGGER;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 1073741824
ASGNI4
line 481
;481:	ent->s.eFlags &= ~EF_NODRAW;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 482
;482:	ent->r.svFlags &= ~SVF_NOCLIENT;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 483
;483:	trap_LinkEntity (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 487
;484:
;485:	//monkk: for flag sacrifice. This may not be reqd. w/ the way Revolution does manual
;486:	//flag return.
;487:	if( ent->item->giTag == PW_REDFLAG || ent->item->giTag == PW_BLUEFLAG || ent->item->giTag == PW_NEUTRALFLAG ) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 7
EQI4 $214
ADDRLP4 8
INDIRI4
CNSTI4 8
EQI4 $214
ADDRLP4 8
INDIRI4
CNSTI4 9
NEI4 $211
LABELV $214
line 488
;488:		ent->s.generic1 = 1;
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
CNSTI4 1
ASGNI4
line 489
;489:	}
LABELV $211
line 491
;490:
;491:	if ( ent->item->giType == IT_POWERUP ) {
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
NEI4 $215
line 496
;492:		// play powerup spawn sound to all clients
;493:		gentity_t	*te;
;494:
;495:		// if the powerup respawn sound should Not be global
;496:		if (ent->speed) {
ADDRFP4 0
INDIRP4
CNSTI4 672
ADDP4
INDIRF4
CNSTF4 0
EQF4 $217
line 497
;497:			te = G_TempEntity( ent->s.pos.trBase, EV_GENERAL_SOUND );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 45
ARGI4
ADDRLP4 16
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 16
INDIRP4
ASGNP4
line 498
;498:		}
ADDRGP4 $218
JUMPV
LABELV $217
line 499
;499:		else {
line 500
;500:			te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_SOUND );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 46
ARGI4
ADDRLP4 16
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 16
INDIRP4
ASGNP4
line 501
;501:		}
LABELV $218
line 502
;502:		te->s.eventParm = G_SoundIndex( "sound/items/poweruprespawn.wav" );
ADDRGP4 $219
ARGP4
ADDRLP4 16
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 503
;503:		te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 20
ADDRLP4 12
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 504
;504:	}
LABELV $215
line 506
;505:
;506:	if ( ent->item->giType == IT_HOLDABLE && ent->item->giTag == HI_KAMIKAZE ) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 6
NEI4 $220
ADDRLP4 12
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 3
NEI4 $220
line 511
;507:		// play powerup spawn sound to all clients
;508:		gentity_t	*te;
;509:
;510:		// if the powerup respawn sound should Not be global
;511:		if (ent->speed) {
ADDRFP4 0
INDIRP4
CNSTI4 672
ADDP4
INDIRF4
CNSTF4 0
EQF4 $222
line 512
;512:			te = G_TempEntity( ent->s.pos.trBase, EV_GENERAL_SOUND );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 45
ARGI4
ADDRLP4 20
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 20
INDIRP4
ASGNP4
line 513
;513:		}
ADDRGP4 $223
JUMPV
LABELV $222
line 514
;514:		else {
line 515
;515:			te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_SOUND );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 46
ARGI4
ADDRLP4 20
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 20
INDIRP4
ASGNP4
line 516
;516:		}
LABELV $223
line 517
;517:		te->s.eventParm = G_SoundIndex( "sound/items/kamikazerespawn.wav" );
ADDRGP4 $224
ARGP4
ADDRLP4 20
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRLP4 16
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 518
;518:		te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 24
ADDRLP4 16
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 519
;519:	}
LABELV $220
line 522
;520:
;521:	// play the normal respawn sound only to nearby clients
;522:	G_AddEvent( ent, EV_ITEM_RESPAWN, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 40
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 524
;523:
;524:	ent->nextthink = 0;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
CNSTI4 0
ASGNI4
line 525
;525:}
LABELV $197
endproc RespawnItem 28 12
export Touch_Item
proc Touch_Item 92 12
line 533
;526:
;527:
;528:/*
;529:===============
;530:Touch_Item
;531:===============
;532:*/
;533:void Touch_Item (gentity_t *ent, gentity_t *other, trace_t *trace) {
line 538
;534:	int			respawn;
;535:	qboolean	predict;
;536:	int			counts[TEAM_NUM_TEAMS];
;537:
;538:	counts[TEAM_BLUE] = TeamCount( -1, TEAM_BLUE );
CNSTI4 -1
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 24
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRLP4 4+8
ADDRLP4 24
INDIRI4
ASGNI4
line 539
;539:	counts[TEAM_RED] = TeamCount( -1, TEAM_RED );
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 28
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRLP4 4+4
ADDRLP4 28
INDIRI4
ASGNI4
line 546
;540:
;541:	/*if ( level.dbgflags && ent->item->giType == IT_TEAM ) {
;542:		G_LogPrintf("DEBUG:Flags: Client %i is touching the %s. \n", other->client->ps.clientNum, ent->item->pickup_name);
;543:		trap_SendServerCommand( other->client->ps.clientNum, va("print \"DEBUG:Flags: You're touching the %s. \n\"", ent->item->pickup_name) );
;544:	}*/
;545:	//G_Printf("DBG: Pickup item\n");											//DBG:Evo:This was commented out before fuxing with the tossflag
;546:	if ( level.time <= other->client->naft[0] /*&& (ent->item->giType == IT_TEAM && ent->item->giTag == other->client->naft[1])*/ ) {
ADDRGP4 level+40
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10244
ADDP4
INDIRI4
GTI4 $228
line 548
;547:		//G_Printf("DBG: NAFT return\n");
;548:		return;
ADDRGP4 $225
JUMPV
LABELV $228
line 552
;549:	}
;550:
;551:	//G_Printf("We're in Touch_Item\n");
;552:	if ( (g_gamemode.integer == 1 || g_gamemode.integer == 3 || g_gamemode.integer == 5) && ent->item->giType != IT_TEAM ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 1
EQI4 $237
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
EQI4 $237
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 5
NEI4 $231
LABELV $237
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
EQI4 $231
line 554
;553:		//G_Printf("instagib return\n");
;554:		return;
ADDRGP4 $225
JUMPV
LABELV $231
line 557
;555:	}
;556:
;557:	if ( ent->s.eFlags & EF_NODRAW && ent->item->giType != IT_TEAM) {
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
CNSTI4 8
ASGNI4
ADDRLP4 32
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $238
ADDRLP4 32
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
EQI4 $238
line 558
;558:		return;
ADDRGP4 $225
JUMPV
LABELV $238
line 561
;559:	}
;560:
;561:	if (!other->client)
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $240
line 562
;562:		return;
ADDRGP4 $225
JUMPV
LABELV $240
line 563
;563:	if (other->health < 1)
ADDRFP4 4
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 1
GEI4 $242
line 564
;564:		return;		// dead people can't pickup
ADDRGP4 $225
JUMPV
LABELV $242
line 567
;565:
;566://freeze
;567:	if ( g_gamemode.integer > 3 ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $244
line 568
;568:		if ( other->freezeState ) {
ADDRFP4 4
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 0
EQI4 $247
line 569
;569:			return;
ADDRGP4 $225
JUMPV
LABELV $247
line 571
;570:		}
;571:	}
LABELV $244
line 576
;572://freeze
;573:
;574:	//G_Printf("Pre flag rules\n");
;575:	//Check to see if it's a valid flag touch for the red team or the blue team.
;576:	if (g_gametype.integer == GT_CTF && g_returnFlag.integer >= 0 && ent->item->giType == IT_TEAM) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $249
ADDRGP4 g_returnFlag+12
INDIRI4
CNSTI4 0
LTI4 $249
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $249
line 579
;577:		//G_Printf("We're touching a flag that would not normally be touched\n");
;578:		//G_Printf("We're in the returnflag touch rules");
;579:		if (other->client->ps.persistant[PERS_TEAM] == TEAM_RED) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 1
NEI4 $253
line 582
;580:		//	G_Printf("Red: We're touching a team flag or a enemy flag\n");
;581:			//These are disallowed touches
;582:			if (ent->item->giTag == PW_REDFLAG && ent->flags & FL_DROPPED_ITEM && g_returnFlag.integer == 1 && other->client->ps.powerups[PW_BLUEFLAG] ||
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 7
NEI4 $264
ADDRLP4 44
CNSTI4 0
ASGNI4
ADDRLP4 40
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
ADDRLP4 44
INDIRI4
EQI4 $264
ADDRGP4 g_returnFlag+12
INDIRI4
CNSTI4 1
NEI4 $264
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
ADDRLP4 44
INDIRI4
NEI4 $276
LABELV $264
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 8
NEI4 $267
ADDRGP4 g_returnFlag+12
INDIRI4
CNSTI4 1
NEI4 $267
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
NEI4 $276
LABELV $267
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 8
NEI4 $269
ADDRLP4 48
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $276
LABELV $269
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 8
NEI4 $271
ADDRLP4 52
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 56
CNSTI4 0
ASGNI4
ADDRLP4 52
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
ADDRLP4 56
INDIRI4
NEI4 $276
ADDRLP4 52
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
ADDRLP4 56
INDIRI4
NEI4 $276
LABELV $271
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 7
NEI4 $275
ADDRLP4 64
CNSTI4 0
ASGNI4
ADDRLP4 60
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
ADDRLP4 64
INDIRI4
NEI4 $275
ADDRLP4 68
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
ADDRLP4 64
INDIRI4
NEI4 $275
ADDRLP4 68
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
ADDRLP4 64
INDIRI4
EQI4 $276
LABELV $275
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 7
NEI4 $278
ADDRLP4 76
CNSTI4 0
ASGNI4
ADDRLP4 72
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 76
INDIRI4
EQI4 $278
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
ADDRLP4 76
INDIRI4
NEI4 $276
LABELV $278
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 7
NEI4 $250
ADDRLP4 84
CNSTI4 0
ASGNI4
ADDRLP4 80
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
ADDRLP4 84
INDIRI4
EQI4 $250
ADDRLP4 88
CNSTI4 2
ASGNI4
ADDRGP4 g_returnFlag+12
INDIRI4
ADDRLP4 88
INDIRI4
NEI4 $250
ADDRLP4 4+4
INDIRI4
ADDRLP4 88
INDIRI4
LTI4 $250
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
ADDRLP4 84
INDIRI4
EQI4 $250
LABELV $276
line 588
;583:				ent->item->giTag == PW_BLUEFLAG && g_returnFlag.integer == 1 && other->client->ps.powerups[PW_REDFLAG] ||
;584:				ent->item->giTag == PW_BLUEFLAG && ent->r.svFlags & SVF_NOCLIENT ||
;585:				ent->item->giTag == PW_BLUEFLAG && (other->client->ps.powerups[PW_BLUEFLAG] || other->client->ps.powerups[PW_REDFLAG]) ||
;586:				ent->item->giTag == PW_REDFLAG && !(ent->flags & FL_DROPPED_ITEM) && !(other->client->ps.powerups[PW_BLUEFLAG] || other->client->ps.powerups[PW_REDFLAG]) ||
;587:				ent->item->giTag == PW_REDFLAG && ent->r.svFlags & SVF_NOCLIENT && other->client->ps.powerups[PW_BLUEFLAG] ||
;588:				ent->item->giTag == PW_REDFLAG && ent->flags & FL_DROPPED_ITEM && g_returnFlag.integer == 2 && counts[TEAM_RED] >= 2 && other->client->ps.powerups[PW_BLUEFLAG]) {
line 592
;589:		//			G_Printf("Red: return\n");
;590:					//I had issues with it allowing these touches..
;591:					//The below if should get rewritten to conform to this, probably, eventually, maybe.
;592:					return;
ADDRGP4 $225
JUMPV
line 594
;593:			}	
;594:		} else if (other->client->ps.persistant[PERS_TEAM] == TEAM_BLUE) {
LABELV $253
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 2
NEI4 $250
line 597
;595:		//	G_Printf("Blue: We're touching a team flag or a enemy flag\n");
;596:			//These are disallowed touches
;597:			if (ent->item->giTag == PW_BLUEFLAG && ent->flags & FL_DROPPED_ITEM && g_returnFlag.integer == 1 && other->client->ps.powerups[PW_REDFLAG] ||
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 8
NEI4 $290
ADDRLP4 44
CNSTI4 0
ASGNI4
ADDRLP4 40
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
ADDRLP4 44
INDIRI4
EQI4 $290
ADDRGP4 g_returnFlag+12
INDIRI4
CNSTI4 1
NEI4 $290
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
ADDRLP4 44
INDIRI4
NEI4 $302
LABELV $290
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 7
NEI4 $293
ADDRGP4 g_returnFlag+12
INDIRI4
CNSTI4 1
NEI4 $293
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
NEI4 $302
LABELV $293
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 7
NEI4 $295
ADDRLP4 48
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $302
LABELV $295
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 7
NEI4 $297
ADDRLP4 52
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 56
CNSTI4 0
ASGNI4
ADDRLP4 52
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
ADDRLP4 56
INDIRI4
NEI4 $302
ADDRLP4 52
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
ADDRLP4 56
INDIRI4
NEI4 $302
LABELV $297
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 8
NEI4 $301
ADDRLP4 64
CNSTI4 0
ASGNI4
ADDRLP4 60
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
ADDRLP4 64
INDIRI4
NEI4 $301
ADDRLP4 68
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
ADDRLP4 64
INDIRI4
NEI4 $301
ADDRLP4 68
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
ADDRLP4 64
INDIRI4
EQI4 $302
LABELV $301
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 8
NEI4 $304
ADDRLP4 76
CNSTI4 0
ASGNI4
ADDRLP4 72
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 76
INDIRI4
EQI4 $304
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
ADDRLP4 76
INDIRI4
NEI4 $302
LABELV $304
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 8
NEI4 $250
ADDRLP4 84
CNSTI4 0
ASGNI4
ADDRLP4 80
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
ADDRLP4 84
INDIRI4
EQI4 $250
ADDRLP4 88
CNSTI4 2
ASGNI4
ADDRGP4 g_returnFlag+12
INDIRI4
ADDRLP4 88
INDIRI4
NEI4 $250
ADDRLP4 4+8
INDIRI4
ADDRLP4 88
INDIRI4
LTI4 $250
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
ADDRLP4 84
INDIRI4
EQI4 $250
LABELV $302
line 603
;598:				ent->item->giTag == PW_REDFLAG && g_returnFlag.integer == 1 && other->client->ps.powerups[PW_BLUEFLAG] ||
;599:				ent->item->giTag == PW_REDFLAG && ent->r.svFlags & SVF_NOCLIENT ||
;600:				ent->item->giTag == PW_REDFLAG && (other->client->ps.powerups[PW_BLUEFLAG] || other->client->ps.powerups[PW_REDFLAG]) ||
;601:				ent->item->giTag == PW_BLUEFLAG && !(ent->flags & FL_DROPPED_ITEM) && !(other->client->ps.powerups[PW_BLUEFLAG] || other->client->ps.powerups[PW_REDFLAG]) ||
;602:				ent->item->giTag == PW_BLUEFLAG && ent->r.svFlags & SVF_NOCLIENT && other->client->ps.powerups[PW_REDFLAG] ||
;603:				ent->item->giTag == PW_BLUEFLAG && ent->flags & FL_DROPPED_ITEM && g_returnFlag.integer == 2 && counts[TEAM_BLUE] >= 2 && other->client->ps.powerups[PW_REDFLAG]) {
line 605
;604:		//			G_Printf("Blue: return\n");
;605:					return;
ADDRGP4 $225
JUMPV
line 607
;606:			}	
;607:		}
line 608
;608:	} else {
LABELV $249
line 610
;609:		//Do the normal touch_item stuff.
;610:		if ( !BG_CanItemBeGrabbed( g_gametype.integer, &ent->s, &other->client->ps )  ) {
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 BG_CanItemBeGrabbed
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $305
line 612
;611:			//G_Printf("DBG: Not touchable\n");
;612:			return;
ADDRGP4 $225
JUMPV
LABELV $305
line 614
;613:		}
;614:	}
LABELV $250
line 616
;615:
;616:	G_LogPrintf( "Item: %i %s\n", other->s.number, ent->item->classname );
ADDRGP4 $308
ARGP4
ADDRFP4 4
INDIRP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 618
;617:
;618:	predict = other->client->pers.predictItemPickup;
ADDRLP4 20
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 504
ADDP4
INDIRI4
ASGNI4
line 621
;619:
;620:	// call the item-specific pickup function
;621:	switch( ent->item->giType ) {
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 1
LTI4 $225
ADDRLP4 40
INDIRI4
CNSTI4 8
GTI4 $225
ADDRLP4 40
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $320-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $320
address $312
address $314
address $315
address $316
address $317
address $319
address $225
address $318
code
LABELV $312
line 623
;622:	case IT_WEAPON:
;623:		respawn = Pickup_Weapon(ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 Pickup_Weapon
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 48
INDIRI4
ASGNI4
line 624
;624:		level.stats_picked |= (1 << ((ent->item->giTag) - 1));
ADDRLP4 52
ADDRGP4 level+10844
ASGNP4
ADDRLP4 56
CNSTI4 1
ASGNI4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRU1
CVUI4 1
ADDRLP4 56
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ADDRLP4 56
INDIRI4
SUBI4
LSHI4
BORI4
CVIU4 4
CVUU1 4
ASGNU1
line 626
;625://		predict = qfalse;
;626:		break;
ADDRGP4 $310
JUMPV
LABELV $314
line 628
;627:	case IT_AMMO:
;628:		respawn = Pickup_Ammo(ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 Pickup_Ammo
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 60
INDIRI4
ASGNI4
line 630
;629://		predict = qfalse;
;630:		break;
ADDRGP4 $310
JUMPV
LABELV $315
line 632
;631:	case IT_ARMOR:
;632:		respawn = Pickup_Armor(ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 Pickup_Armor
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 64
INDIRI4
ASGNI4
line 633
;633:		break;
ADDRGP4 $310
JUMPV
LABELV $316
line 635
;634:	case IT_HEALTH:
;635:		respawn = Pickup_Health(ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 Pickup_Health
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 68
INDIRI4
ASGNI4
line 636
;636:		break;
ADDRGP4 $310
JUMPV
LABELV $317
line 638
;637:	case IT_POWERUP:
;638:		respawn = Pickup_Powerup(ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 Pickup_Powerup
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 72
INDIRI4
ASGNI4
line 639
;639:		predict = qfalse;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 640
;640:		break;
ADDRGP4 $310
JUMPV
LABELV $318
line 648
;641:#ifdef MISSIONPACK
;642:	case IT_PERSISTANT_POWERUP:
;643:		respawn = Pickup_PersistantPowerup(ent, other);
;644:		break;
;645:#endif
;646:	case IT_TEAM:
;647:		//G_Printf("Pickup_Team was called\n");
;648:		respawn = Pickup_Team(ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 Pickup_Team
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 76
INDIRI4
ASGNI4
line 649
;649:		break;
ADDRGP4 $310
JUMPV
LABELV $319
line 651
;650:	case IT_HOLDABLE:
;651:		respawn = Pickup_Holdable(ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 Pickup_Holdable
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 80
INDIRI4
ASGNI4
line 652
;652:		break;
line 654
;653:	default:
;654:		return;
LABELV $310
line 657
;655:	}
;656:
;657:	if ( !respawn ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $322
line 658
;658:		return;
ADDRGP4 $225
JUMPV
LABELV $322
line 663
;659:	}
;660:	
;661:
;662:	// play the normal pickup sound
;663:	if (predict) {
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $324
line 664
;664:		G_AddPredictableEvent( other, EV_ITEM_PICKUP, ent->s.modelindex );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 19
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_AddPredictableEvent
CALLV
pop
line 665
;665:	} else {
ADDRGP4 $325
JUMPV
LABELV $324
line 666
;666:		G_AddEvent( other, EV_ITEM_PICKUP, ent->s.modelindex );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 19
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 667
;667:	}
LABELV $325
line 670
;668:
;669:	// powerup pickups are global broadcasts
;670:	if ( ent->item->giType == IT_POWERUP || ent->item->giType == IT_TEAM) {
ADDRLP4 48
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 5
EQI4 $328
ADDRLP4 48
INDIRI4
CNSTI4 8
NEI4 $326
LABELV $328
line 672
;671:		// if we want the global sound to play
;672:		if (!ent->speed) {
ADDRFP4 0
INDIRP4
CNSTI4 672
ADDP4
INDIRF4
CNSTF4 0
NEF4 $329
line 675
;673:			gentity_t	*te;
;674:
;675:			te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_ITEM_PICKUP );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 20
ARGI4
ADDRLP4 56
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 52
ADDRLP4 56
INDIRP4
ASGNP4
line 676
;676:			te->s.eventParm = ent->s.modelindex;
ADDRLP4 52
INDIRP4
CNSTI4 184
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ASGNI4
line 677
;677:			te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 60
ADDRLP4 52
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 678
;678:		} else {
ADDRGP4 $330
JUMPV
LABELV $329
line 681
;679:			gentity_t	*te;
;680:
;681:			te = G_TempEntity( ent->s.pos.trBase, EV_GLOBAL_ITEM_PICKUP );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 20
ARGI4
ADDRLP4 56
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 52
ADDRLP4 56
INDIRP4
ASGNP4
line 682
;682:			te->s.eventParm = ent->s.modelindex;
ADDRLP4 52
INDIRP4
CNSTI4 184
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ASGNI4
line 684
;683:			// only send this temp entity to a single client
;684:			te->r.svFlags |= SVF_SINGLECLIENT;
ADDRLP4 60
ADDRLP4 52
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 685
;685:			te->r.singleClient = other->s.number;
ADDRLP4 52
INDIRP4
CNSTI4 428
ADDP4
ADDRFP4 4
INDIRP4
INDIRI4
ASGNI4
line 686
;686:		}
LABELV $330
line 687
;687:	}
LABELV $326
line 690
;688:
;689:	// fire item targets
;690:	G_UseTargets (ent, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 G_UseTargets
CALLV
pop
line 693
;691:
;692:	// wait of -1 will not respawn
;693:	if ( ent->wait == -1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 796
ADDP4
INDIRF4
CNSTF4 3212836864
NEF4 $331
line 694
;694:		ent->r.svFlags |= SVF_NOCLIENT;
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 695
;695:		ent->s.eFlags |= EF_NODRAW;
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 696
;696:		ent->r.contents = 0;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 697
;697:		ent->unlinkAfterEvent = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 560
ADDP4
CNSTI4 1
ASGNI4
line 698
;698:		return;
ADDRGP4 $225
JUMPV
LABELV $331
line 703
;699:	}
;700:
;701:	// non zero wait overrides respawn time
;702:	//if ( ent->wait ) {
;703:	if ( ent->wait && ent->think != CPM_HealthDecay) {	// CPM
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 796
ADDP4
INDIRF4
CNSTF4 0
EQF4 $333
ADDRLP4 52
INDIRP4
CNSTI4 692
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 CPM_HealthDecay
CVPU4 4
EQU4 $333
line 704
;704:		respawn = ent->wait;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 796
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 705
;705:	}
LABELV $333
line 708
;706:
;707:	// random can be used to vary the respawn time
;708:	if ( ent->random ) {
ADDRFP4 0
INDIRP4
CNSTI4 800
ADDP4
INDIRF4
CNSTF4 0
EQF4 $335
line 709
;709:		respawn += crandom() * ent->random;
ADDRLP4 56
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1073741824
ADDRLP4 56
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
ADDRFP4 0
INDIRP4
CNSTI4 800
ADDP4
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 710
;710:		if ( respawn < 1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 1
GEI4 $337
line 711
;711:			respawn = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 712
;712:		}
LABELV $337
line 713
;713:	}
LABELV $335
line 716
;714:
;715:	// dropped items will not respawn
;716:	if ( ent->flags & FL_DROPPED_ITEM ) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $339
line 717
;717:		ent->freeAfterEvent = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 1
ASGNI4
line 718
;718:	}
LABELV $339
line 723
;719:
;720:	// picked up items still stay around, they just don't
;721:	// draw anything.  This allows respawnable items
;722:	// to be placed on movers.
;723:	ent->r.svFlags |= SVF_NOCLIENT;
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 724
;724:	ent->s.eFlags |= EF_NODRAW;
ADDRLP4 60
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 725
;725:	ent->r.contents = 0;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 738
;726:
;727:	// ZOID
;728:	// A negative respawn times means to never respawn this item (but don't 
;729:	// delete it).  This is used by items that are respawned by third party 
;730:	// events such as ctf flags
;731:	/*if ( respawn <= 0 ) {
;732:		ent->nextthink = 0;
;733:		ent->think = 0;
;734:	} else {
;735:		ent->nextthink = level.time + respawn * 1000;
;736:		ent->think = RespawnItem;
;737:	}*/
;738:	if ( respawn <= 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $341
line 739
;739:		ent->nextthink = 0;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
CNSTI4 0
ASGNI4
line 740
;740:		ent->think = 0;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
CNSTP4 0
ASGNP4
line 741
;741:	} else {
ADDRGP4 $342
JUMPV
LABELV $341
line 742
;742:		ent->nextthink = level.time + respawn * 1000;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 1000
ADDRLP4 0
INDIRI4
MULI4
ADDI4
ASGNI4
line 743
;743:		if (ent->think != CPM_HealthDecay) ent->think = RespawnItem; // CPM
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 CPM_HealthDecay
CVPU4 4
EQU4 $344
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 RespawnItem
ASGNP4
LABELV $344
line 744
;744:	}
LABELV $342
line 745
;745:	trap_LinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 746
;746:}
LABELV $225
endproc Touch_Item 92 12
export LaunchItem
proc LaunchItem 12 8
line 758
;747:
;748:
;749://======================================================================
;750:
;751:/*
;752:================
;753:LaunchItem
;754:
;755:Spawns an item and tosses it forward
;756:================
;757:*/
;758:gentity_t *LaunchItem( gitem_t *item, vec3_t origin, vec3_t velocity ) {
line 761
;759:	gentity_t	*dropped;
;760:
;761:	dropped = G_Spawn();
ADDRLP4 4
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 763
;762:
;763:	dropped->s.eType = ET_ITEM;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 2
ASGNI4
line 764
;764:	dropped->s.modelindex = item - bg_itemlist;	// store item number in modelindex
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
ASGNI4
line 765
;765:	dropped->s.modelindex2 = 1; // This is non-zero is it's a dropped item
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 1
ASGNI4
line 767
;766:
;767:	dropped->classname = item->classname;
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRFP4 0
INDIRP4
INDIRP4
ASGNP4
line 768
;768:	dropped->item = item;
ADDRLP4 0
INDIRP4
CNSTI4 804
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 769
;769:	VectorSet (dropped->r.mins, -ITEM_RADIUS, -ITEM_RADIUS, -ITEM_RADIUS);
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
CNSTF4 3245342720
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 440
ADDP4
CNSTF4 3245342720
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 444
ADDP4
CNSTF4 3245342720
ASGNF4
line 770
;770:	VectorSet (dropped->r.maxs, ITEM_RADIUS, ITEM_RADIUS, ITEM_RADIUS);
ADDRLP4 0
INDIRP4
CNSTI4 448
ADDP4
CNSTF4 1097859072
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
CNSTF4 1097859072
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 456
ADDP4
CNSTF4 1097859072
ASGNF4
line 771
;771:	dropped->r.contents = CONTENTS_TRIGGER;
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 1073741824
ASGNI4
line 773
;772:
;773:	dropped->touch = Touch_Item;
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
ADDRGP4 Touch_Item
ASGNP4
line 775
;774:
;775:	G_SetOrigin( dropped, origin );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 776
;776:	dropped->s.pos.trType = TR_GRAVITY;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 5
ASGNI4
line 777
;777:	dropped->s.pos.trTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 778
;778:	VectorCopy( velocity, dropped->s.pos.trDelta );
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 8
INDIRP4
INDIRB
ASGNB 12
line 780
;779:
;780:	dropped->s.eFlags |= EF_BOUNCE_HALF;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 8
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
line 784
;781:#ifdef MISSIONPACK
;782:	if ((g_gametype.integer == GT_CTF || g_gametype.integer == GT_1FCTF)			&& item->giType == IT_TEAM) { // Special case for CTF flags
;783:#else
;784:	if (g_gametype.integer == GT_CTF && item->giType == IT_TEAM) { // Special case for CTF flags
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $348
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $348
line 786
;785:#endif
;786:		dropped->think = Team_DroppedFlagThink;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 Team_DroppedFlagThink
ASGNP4
line 787
;787:		dropped->nextthink = level.time + 30000;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 30000
ADDI4
ASGNI4
line 788
;788:		Team_CheckDroppedItem( dropped );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Team_CheckDroppedItem
CALLV
pop
line 789
;789:	} else { // auto-remove after 30 seconds
ADDRGP4 $349
JUMPV
LABELV $348
line 790
;790:		dropped->think = G_FreeEntity;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 G_FreeEntity
ASGNP4
line 791
;791:		dropped->nextthink = level.time + 30000;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 30000
ADDI4
ASGNI4
line 792
;792:	}
LABELV $349
line 794
;793:
;794:	dropped->flags = FL_DROPPED_ITEM;
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
CNSTI4 4096
ASGNI4
line 796
;795:
;796:	trap_LinkEntity (dropped);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 798
;797:
;798:	return dropped;
ADDRLP4 0
INDIRP4
RETP4
LABELV $346
endproc LaunchItem 12 8
export Drop_Item
proc Drop_Item 72 16
line 808
;799:}
;800:
;801:/*
;802:================
;803:Drop_Item
;804:
;805:Spawns an item and tosses it forward
;806:================
;807:*/
;808:gentity_t *Drop_Item( gentity_t *ent, gitem_t *item, float angle, qboolean tossflag ) {
line 812
;809:	vec3_t	velocity;
;810:	vec3_t	angles;
;811:	
;812:	VectorCopy( ent->s.apos.trBase, angles );
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRB
ASGNB 12
line 813
;813:	angles[YAW] += angle;
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRFP4 8
INDIRF4
ADDF4
ASGNF4
line 814
;814:	angles[PITCH] = 0;	// always forward
ADDRLP4 12
CNSTF4 0
ASGNF4
line 816
;815:
;816:	AngleVectors( angles, velocity, NULL, NULL );
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 24
CNSTP4 0
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 817
;817:	VectorScale( velocity, 150, velocity );
ADDRLP4 28
CNSTF4 1125515264
ASGNF4
ADDRLP4 0
ADDRLP4 28
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 28
INDIRF4
ADDRLP4 0+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+8
CNSTF4 1125515264
ADDRLP4 0+8
INDIRF4
MULF4
ASGNF4
line 818
;818:	velocity[2] += 200 + crandom() * 50;
ADDRLP4 32
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1112014848
CNSTF4 1073741824
ADDRLP4 32
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
CNSTF4 1128792064
ADDF4
ADDF4
ASGNF4
line 819
;819:	if ( tossflag ) {
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $360
line 820
;820:		if ( (ent->client->ps.velocity[0] < 300 && ent->client->ps.velocity[0] > -300) &&
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 40
ADDRLP4 36
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ASGNF4
ADDRLP4 44
CNSTF4 1133903872
ASGNF4
ADDRLP4 40
INDIRF4
ADDRLP4 44
INDIRF4
GEF4 $368
ADDRLP4 48
CNSTF4 3281387520
ASGNF4
ADDRLP4 40
INDIRF4
ADDRLP4 48
INDIRF4
LEF4 $368
ADDRLP4 52
ADDRLP4 36
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ASGNF4
ADDRLP4 52
INDIRF4
ADDRLP4 44
INDIRF4
GEF4 $368
ADDRLP4 52
INDIRF4
ADDRLP4 48
INDIRF4
LEF4 $368
ADDRLP4 56
ADDRLP4 36
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ASGNF4
ADDRLP4 56
INDIRF4
ADDRLP4 44
INDIRF4
GEF4 $368
ADDRLP4 56
INDIRF4
ADDRLP4 48
INDIRF4
GTF4 $365
LABELV $368
ADDRGP4 $364
ARGP4
ADDRLP4 60
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $362
LABELV $365
line 822
;821:			(ent->client->ps.velocity[1] < 300 && ent->client->ps.velocity[1] > -300) &&
;822:			(ent->client->ps.velocity[2] < 300 && ent->client->ps.velocity[2] > -300) || !(trap_Cvar_VariableIntegerValue("new_flagtoss")) ) {
line 823
;823:			velocity[2] += 200 + crandom() * 50;
ADDRLP4 64
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1112014848
CNSTF4 1073741824
ADDRLP4 64
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
CNSTF4 1128792064
ADDF4
ADDF4
ASGNF4
line 824
;824:		} else {
ADDRGP4 $363
JUMPV
LABELV $362
line 826
;825:			//Scale the velocity down, otherwise we're grabbing it right away
;826:			VectorScale(ent->client->ps.velocity, 1.2, velocity);
ADDRLP4 64
CNSTF4 1067030938
ASGNF4
ADDRLP4 68
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 64
INDIRF4
ADDRLP4 68
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 64
INDIRF4
ADDRLP4 68
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+8
CNSTF4 1067030938
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
MULF4
ASGNF4
line 827
;827:		}
LABELV $363
line 828
;828:	}
LABELV $360
line 830
;829:	
;830:	return LaunchItem( item, ent->s.pos.trBase, velocity );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 36
ADDRGP4 LaunchItem
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
RETP4
LABELV $353
endproc Drop_Item 72 16
export Use_Item
proc Use_Item 0 4
line 842
;831:
;832:}
;833:
;834:
;835:/*
;836:================
;837:Use_Item
;838:
;839:Respawn the item
;840:================
;841:*/
;842:void Use_Item( gentity_t *ent, gentity_t *other, gentity_t *activator ) {
line 843
;843:	RespawnItem( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 RespawnItem
CALLV
pop
line 844
;844:}
LABELV $372
endproc Use_Item 0 4
export FinishSpawningItem
proc FinishSpawningItem 92 28
line 856
;845:
;846://======================================================================
;847:
;848:/*
;849:================
;850:FinishSpawningItem
;851:
;852:Traces down to find where an item should rest, instead of letting them
;853:free fall from their spawn points
;854:================
;855:*/
;856:void FinishSpawningItem( gentity_t *ent ) {
line 860
;857:	trace_t		tr;
;858:	vec3_t		dest;
;859:
;860:	VectorSet( ent->r.mins, -ITEM_RADIUS, -ITEM_RADIUS, -ITEM_RADIUS );
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
CNSTF4 3245342720
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 440
ADDP4
CNSTF4 3245342720
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
CNSTF4 3245342720
ASGNF4
line 861
;861:	VectorSet( ent->r.maxs, ITEM_RADIUS, ITEM_RADIUS, ITEM_RADIUS );
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
CNSTF4 1097859072
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 452
ADDP4
CNSTF4 1097859072
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 456
ADDP4
CNSTF4 1097859072
ASGNF4
line 863
;862:
;863:	ent->s.eType = ET_ITEM;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 2
ASGNI4
line 864
;864:	ent->s.modelindex = ent->item - bg_itemlist;		// store item number in modelindex
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 160
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
ASGNI4
line 865
;865:	ent->s.modelindex2 = 0; // zero indicates this isn't a dropped item
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 0
ASGNI4
line 867
;866:
;867:	ent->r.contents = CONTENTS_TRIGGER;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 1073741824
ASGNI4
line 868
;868:	ent->touch = Touch_Item;
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
ADDRGP4 Touch_Item
ASGNP4
line 870
;869:	// useing an item causes it to respawn
;870:	ent->use = Use_Item;
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRGP4 Use_Item
ASGNP4
line 872
;871:
;872:	if ( ent->spawnflags & 1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $374
line 874
;873:		// suspended
;874:		G_SetOrigin( ent, ent->s.origin );
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 875
;875:	} else {
ADDRGP4 $375
JUMPV
LABELV $374
line 877
;876:		// drop to floor
;877:		VectorSet( dest, ent->s.origin[0], ent->s.origin[1], ent->s.origin[2] - 4096 );
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
ADDRLP4 72
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ASGNF4
ADDRLP4 56+4
ADDRLP4 72
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ASGNF4
ADDRLP4 56+8
ADDRFP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
CNSTF4 1166016512
SUBF4
ASGNF4
line 878
;878:		trap_Trace( &tr, ent->s.origin, ent->r.mins, ent->r.maxs, dest, ent->s.number, MASK_SOLID );
ADDRLP4 0
ARGP4
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 76
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRLP4 76
INDIRP4
CNSTI4 448
ADDP4
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 76
INDIRP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 879
;879:		if ( tr.startsolid ) {
ADDRLP4 0+4
INDIRI4
CNSTI4 0
EQI4 $378
line 880
;880:			G_Printf ("FinishSpawningItem: %s startsolid at %s\n", ent->classname, vtos(ent->s.origin));
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 80
ADDRGP4 vtos
CALLP4
ASGNP4
ADDRGP4 $381
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRLP4 80
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 881
;881:			G_FreeEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 882
;882:			return;
ADDRGP4 $373
JUMPV
LABELV $378
line 886
;883:		}
;884:
;885:		// allow to ride movers
;886:		ent->s.groundEntityNum = tr.entityNum;
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
ADDRLP4 0+52
INDIRI4
ASGNI4
line 888
;887:
;888:		G_SetOrigin( ent, tr.endpos );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+12
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 889
;889:	}
LABELV $375
line 892
;890:
;891:	// team slaves and targeted items aren't present at start
;892:	if ( ( ent->flags & FL_TEAMSLAVE ) || ent->targetname ) {
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
NEI4 $386
ADDRLP4 72
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $384
LABELV $386
line 893
;893:		ent->s.eFlags |= EF_NODRAW;
ADDRLP4 76
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 894
;894:		ent->r.contents = 0;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 895
;895:		return;
ADDRGP4 $373
JUMPV
LABELV $384
line 900
;896:	}
;897:
;898:	// powerups don't spawn in for a while
;899:	//if ( ent->item->giType == IT_POWERUP && (g_gamemode.integer == 0 || g_gamemode.integer == 2)) {
;900:	if ( ent->item->giType == IT_POWERUP && !cpm_startpowerups && (g_gamemode.integer == 0 || g_gamemode.integer == 2) ) { // CPM
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
NEI4 $387
ADDRLP4 76
CNSTI4 0
ASGNI4
ADDRGP4 cpm_startpowerups
INDIRI4
ADDRLP4 76
INDIRI4
NEI4 $387
ADDRGP4 g_gamemode+12
INDIRI4
ADDRLP4 76
INDIRI4
EQI4 $391
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 2
NEI4 $387
LABELV $391
line 903
;901:		float	respawn;
;902:
;903:		respawn = 45 + crandom() * 15;
ADDRLP4 84
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 80
CNSTF4 1097859072
CNSTF4 1073741824
ADDRLP4 84
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
CNSTF4 1110704128
ADDF4
ASGNF4
line 904
;904:		ent->s.eFlags |= EF_NODRAW;
ADDRLP4 88
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 905
;905:		ent->r.contents = 0;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 906
;906:		ent->nextthink = level.time + respawn * 1000;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
CVIF4 4
CNSTF4 1148846080
ADDRLP4 80
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 907
;907:		ent->think = RespawnItem;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 RespawnItem
ASGNP4
line 908
;908:		return;
ADDRGP4 $373
JUMPV
LABELV $387
line 912
;909:	}
;910:
;911:
;912:	trap_LinkEntity (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 913
;913:}
LABELV $373
endproc FinishSpawningItem 92 28
export Registered
proc Registered 8 0
line 918
;914:
;915:
;916:qboolean	itemRegistered[MAX_ITEMS];
;917://freeze
;918:qboolean Registered( gitem_t *item ) {
line 919
;919:	return ( item && itemRegistered[ item - bg_itemlist ] );
ADDRLP4 4
ADDRFP4 0
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 4
INDIRU4
CNSTU4 0
EQU4 $395
ADDRLP4 4
INDIRU4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
CNSTI4 2
LSHI4
ADDRGP4 itemRegistered
ADDP4
INDIRI4
CNSTI4 0
EQI4 $395
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $396
JUMPV
LABELV $395
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $396
ADDRLP4 0
INDIRI4
RETI4
LABELV $393
endproc Registered 8 0
export G_CheckTeamItems
proc G_CheckTeamItems 20 4
line 928
;920:}
;921://freeze
;922:
;923:/*
;924:==================
;925:G_CheckTeamItems
;926:==================
;927:*/
;928:void G_CheckTeamItems( void ) {
line 931
;929:
;930:	// Set up team stuff
;931:	Team_InitGame();
ADDRGP4 Team_InitGame
CALLV
pop
line 933
;932:
;933:	if( g_gametype.integer == GT_CTF ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $398
line 937
;934:		gitem_t	*item;
;935:
;936:		// check for the two flags
;937:		item = BG_FindItem( "Red Flag" );
ADDRGP4 $401
ARGP4
ADDRLP4 4
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 938
;938:		if ( !item || !itemRegistered[ item - bg_itemlist ] ) {
ADDRLP4 8
ADDRLP4 0
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 8
INDIRU4
CNSTU4 0
EQU4 $404
ADDRLP4 8
INDIRU4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
CNSTI4 2
LSHI4
ADDRGP4 itemRegistered
ADDP4
INDIRI4
CNSTI4 0
NEI4 $402
LABELV $404
line 939
;939:			G_Printf( S_COLOR_YELLOW "WARNING: No team_CTF_redflag in map" );
ADDRGP4 $405
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 940
;940:		}
LABELV $402
line 941
;941:		item = BG_FindItem( "Blue Flag" );
ADDRGP4 $406
ARGP4
ADDRLP4 12
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 942
;942:		if ( !item || !itemRegistered[ item - bg_itemlist ] ) {
ADDRLP4 16
ADDRLP4 0
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 16
INDIRU4
CNSTU4 0
EQU4 $409
ADDRLP4 16
INDIRU4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
CNSTI4 2
LSHI4
ADDRGP4 itemRegistered
ADDP4
INDIRI4
CNSTI4 0
NEI4 $407
LABELV $409
line 943
;943:			G_Printf( S_COLOR_YELLOW "WARNING: No team_CTF_blueflag in map" );
ADDRGP4 $410
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 944
;944:		}
LABELV $407
line 945
;945:	}
LABELV $398
line 1005
;946:#ifdef MISSIONPACK
;947:	if( g_gametype.integer == GT_1FCTF ) {
;948:		gitem_t	*item;
;949:
;950:		// check for all three flags
;951:		item = BG_FindItem( "Red Flag" );
;952:		if ( !item || !itemRegistered[ item - bg_itemlist ] ) {
;953:			G_Printf( S_COLOR_YELLOW "WARNING: No team_CTF_redflag in map" );
;954:		}
;955:		item = BG_FindItem( "Blue Flag" );
;956:		if ( !item || !itemRegistered[ item - bg_itemlist ] ) {
;957:			G_Printf( S_COLOR_YELLOW "WARNING: No team_CTF_blueflag in map" );
;958:		}
;959:		item = BG_FindItem( "Neutral Flag" );
;960:		if ( !item || !itemRegistered[ item - bg_itemlist ] ) {
;961:			G_Printf( S_COLOR_YELLOW "WARNING: No team_CTF_neutralflag in map" );
;962:		}
;963:	}
;964:
;965:	if( g_gametype.integer == GT_OBELISK ) {
;966:		gentity_t	*ent;
;967:
;968:		// check for the two obelisks
;969:		ent = NULL;
;970:		ent = G_Find( ent, FOFS(classname), "team_redobelisk" );
;971:		if( !ent ) {
;972:			G_Printf( S_COLOR_YELLOW "WARNING: No team_redobelisk in map" );
;973:		}
;974:
;975:		ent = NULL;
;976:		ent = G_Find( ent, FOFS(classname), "team_blueobelisk" );
;977:		if( !ent ) {
;978:			G_Printf( S_COLOR_YELLOW "WARNING: No team_blueobelisk in map" );
;979:		}
;980:	}
;981:
;982:	if( g_gametype.integer == GT_HARVESTER ) {
;983:		gentity_t	*ent;
;984:
;985:		// check for all three obelisks
;986:		ent = NULL;
;987:		ent = G_Find( ent, FOFS(classname), "team_redobelisk" );
;988:		if( !ent ) {
;989:			G_Printf( S_COLOR_YELLOW "WARNING: No team_redobelisk in map" );
;990:		}
;991:
;992:		ent = NULL;
;993:		ent = G_Find( ent, FOFS(classname), "team_blueobelisk" );
;994:		if( !ent ) {
;995:			G_Printf( S_COLOR_YELLOW "WARNING: No team_blueobelisk in map" );
;996:		}
;997:
;998:		ent = NULL;
;999:		ent = G_Find( ent, FOFS(classname), "team_neutralobelisk" );
;1000:		if( !ent ) {
;1001:			G_Printf( S_COLOR_YELLOW "WARNING: No team_neutralobelisk in map" );
;1002:		}
;1003:	}
;1004:#endif
;1005:}
LABELV $397
endproc G_CheckTeamItems 20 4
export ClearRegisteredItems
proc ClearRegisteredItems 12 12
line 1012
;1006:
;1007:/*
;1008:==============
;1009:ClearRegisteredItems
;1010:==============
;1011:*/
;1012:void ClearRegisteredItems( void ) {
line 1013
;1013:	memset( itemRegistered, 0, sizeof( itemRegistered ) );
ADDRGP4 itemRegistered
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1024
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1016
;1014:
;1015:	// players always start with the base weapon
;1016:	RegisterItem( BG_FindItemForWeapon( WP_MACHINEGUN ) );
CNSTI4 2
ARGI4
ADDRLP4 0
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 1017
;1017:	RegisterItem( BG_FindItemForWeapon( WP_GAUNTLET ) );
CNSTI4 1
ARGI4
ADDRLP4 4
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 1019
;1018:	//if( weap_enableHook.integer ) {
;1019:		RegisterItem( BG_FindItemForWeapon( WP_GRAPPLING_HOOK ) );
CNSTI4 10
ARGI4
ADDRLP4 8
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 1027
;1020:	//}
;1021:#ifdef MISSIONPACK
;1022:	if( g_gametype.integer == GT_HARVESTER ) {
;1023:		RegisterItem( BG_FindItem( "Red Cube" ) );
;1024:		RegisterItem( BG_FindItem( "Blue Cube" ) );
;1025:	}
;1026:#endif
;1027:}
LABELV $411
endproc ClearRegisteredItems 12 12
export RegisterItem
proc RegisterItem 0 4
line 1036
;1028:
;1029:/*
;1030:===============
;1031:RegisterItem
;1032:
;1033:The item will be added to the precache list
;1034:===============
;1035:*/
;1036:void RegisterItem( gitem_t *item ) {
line 1037
;1037:	if ( !item ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $413
line 1038
;1038:		G_Error( "RegisterItem: NULL" );
ADDRGP4 $415
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 1039
;1039:	}
LABELV $413
line 1040
;1040:	itemRegistered[ item - bg_itemlist ] = qtrue;
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
CNSTI4 2
LSHI4
ADDRGP4 itemRegistered
ADDP4
CNSTI4 1
ASGNI4
line 1041
;1041:}
LABELV $412
endproc RegisterItem 0 4
export SaveRegisteredItems
proc SaveRegisteredItems 268 8
line 1052
;1042:
;1043:
;1044:/*
;1045:===============
;1046:SaveRegisteredItems
;1047:
;1048:Write the needed items to a config string
;1049:so the client will know which ones to precache
;1050:===============
;1051:*/
;1052:void SaveRegisteredItems( void ) {
line 1057
;1053:	char	string[MAX_ITEMS+1];
;1054:	int		i;
;1055:	int		count;
;1056:
;1057:	count = 0;
ADDRLP4 264
CNSTI4 0
ASGNI4
line 1058
;1058:	for ( i = 0 ; i < bg_numItems ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $420
JUMPV
LABELV $417
line 1059
;1059:		if ( itemRegistered[i] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 itemRegistered
ADDP4
INDIRI4
CNSTI4 0
EQI4 $421
line 1060
;1060:			count++;
ADDRLP4 264
ADDRLP4 264
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1061
;1061:			string[i] = '1';
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
CNSTI1 49
ASGNI1
line 1062
;1062:		} else {
ADDRGP4 $422
JUMPV
LABELV $421
line 1063
;1063:			string[i] = '0';
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
CNSTI1 48
ASGNI1
line 1064
;1064:		}
LABELV $422
line 1065
;1065:	}
LABELV $418
line 1058
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $420
ADDRLP4 0
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $417
line 1066
;1066:	string[ bg_numItems ] = 0;
ADDRGP4 bg_numItems
INDIRI4
ADDRLP4 4
ADDP4
CNSTI1 0
ASGNI1
line 1068
;1067:
;1068:	G_Printf( "%i items registered\n", count );
ADDRGP4 $423
ARGP4
ADDRLP4 264
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 1069
;1069:	trap_SetConfigstring(CS_ITEMS, string);
CNSTI4 27
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1070
;1070:}
LABELV $416
endproc SaveRegisteredItems 268 8
export G_ItemDisabled
proc G_ItemDisabled 132 16
line 1077
;1071:
;1072:/*
;1073:============
;1074:G_ItemDisabled
;1075:============
;1076:*/
;1077:int G_ItemDisabled( gitem_t *item ) {
line 1081
;1078:
;1079:	char name[128];
;1080:
;1081:	Com_sprintf(name, sizeof(name), "disable_%s", item->classname);
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $425
ARGP4
ADDRFP4 0
INDIRP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1082
;1082:	return trap_Cvar_VariableIntegerValue( name );
ADDRLP4 0
ARGP4
ADDRLP4 128
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 128
INDIRI4
RETI4
LABELV $424
endproc G_ItemDisabled 132 16
export G_SpawnItem
proc G_SpawnItem 48 12
line 1095
;1083:}
;1084:
;1085:/*
;1086:============
;1087:G_SpawnItem
;1088:
;1089:Sets the clipping size and plants the object on the floor.
;1090:
;1091:Items can't be immediately dropped to floor, because they might
;1092:be on an entity that hasn't spawned yet.
;1093:============
;1094:*/
;1095:void G_SpawnItem (gentity_t *ent, gitem_t *item) {
line 1096
;1096:	G_SpawnFloat( "random", "0", &ent->random );
ADDRGP4 $427
ARGP4
ADDRGP4 $428
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 800
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 1097
;1097:	G_SpawnFloat( "wait", "0", &ent->wait );
ADDRGP4 $429
ARGP4
ADDRGP4 $428
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 796
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 1099
;1098:
;1099:	RegisterItem( item );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 1100
;1100:	if ( G_ItemDisabled(item) )
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 G_ItemDisabled
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $430
line 1101
;1101:		return;
ADDRGP4 $426
JUMPV
LABELV $430
line 1108
;1102:
;1103:	//Monkk: sarcifice. Added this because some decisions on whether to sacrifice
;1104:	//are based on whether the flag is at the base position or not, and in
;1105:	//reactance, this is how we do it. This can be removed if all references in
;1106:	//the sacrifice that use ent->s.generic1 as a guide go too!
;1107:	//TODO: Check this for removal!
;1108:	if( item->giType == IT_TEAM ) {
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $432
line 1110
;1109:	//	G_LogPrintf("DEBUG: Flag: Should spawn a %s \n", item->pickup_name);
;1110:		ent->s.generic1= 1;
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
CNSTI4 1
ASGNI4
line 1111
;1111:	}
LABELV $432
line 1112
;1112:	ent->item = item;
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
ADDRFP4 4
INDIRP4
ASGNP4
line 1115
;1113:	// some movers spawn on the second frame, so delay item
;1114:	// spawns until the third frame so they can ride trains
;1115:	ent->nextthink = level.time + FRAMETIME * 2;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 1116
;1116:	ent->think = FinishSpawningItem;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 FinishSpawningItem
ASGNP4
line 1118
;1117:
;1118:	if ( ((g_gamemode.integer == 1 || g_gamemode.integer == 3 || g_gamemode.integer == 5) && item->giType != IT_TEAM)/* || (g_gamemode.integer == 2 && (ent->item->giType != IT_TEAM || ent->item->giType != IT_WEAPON || ent->item->giType != IT_POWERUP) )*/ ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 1
EQI4 $441
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
EQI4 $441
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 5
NEI4 $435
LABELV $441
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
EQI4 $435
line 1120
;1119:	//	ent->r.svFlags |= SVF_NOCLIENT;
;1120:		ent->s.eFlags |= EF_NODRAW;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 1122
;1121:	//	ent->r.contents = 0;
;1122:	} else { /** Probablay no longer need this **/
ADDRGP4 $436
JUMPV
LABELV $435
line 1126
;1123:		/*if( item->giType == IT_TEAM ) {
;1124:			G_LogPrintf("DEBUG: Flag: We're really spawning a %s \n", item->pickup_name);
;1125:		}*/
;1126:		if ( item->giType == IT_WEAPON || item->giType == IT_AMMO ) {
ADDRLP4 4
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1
EQI4 $444
ADDRLP4 4
INDIRI4
CNSTI4 2
NEI4 $442
LABELV $444
line 1127
;1127:			if ( (!Q_stricmp( item->classname, "ammo_bullets" ) || item->giTag == WP_MACHINEGUN) && !(weap_allowed.integer & 2) ) {
ADDRFP4 4
INDIRP4
INDIRP4
ARGP4
ADDRGP4 $447
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $449
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
NEI4 $445
LABELV $449
ADDRGP4 weap_allowed+12
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $445
line 1128
;1128:				ent->r.svFlags |= SVF_NOCLIENT;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1129
;1129:				ent->s.eFlags |= EF_NODRAW;
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
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 1130
;1130:			} else if ( (!Q_stricmp( item->classname, "ammo_shells" ) || item->giTag == WP_SHOTGUN) && !(weap_allowed.integer & 4) ) {
ADDRGP4 $446
JUMPV
LABELV $445
ADDRFP4 4
INDIRP4
INDIRP4
ARGP4
ADDRGP4 $452
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $454
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 3
NEI4 $450
LABELV $454
ADDRGP4 weap_allowed+12
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
NEI4 $450
line 1131
;1131:				ent->r.svFlags |= SVF_NOCLIENT;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1132
;1132:				ent->s.eFlags |= EF_NODRAW;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 1133
;1133:			} else if ( (!Q_stricmp( item->classname, "ammo_grenades" ) || item->giTag == WP_GRENADE_LAUNCHER) && !(weap_allowed.integer & 8) ) {
ADDRGP4 $451
JUMPV
LABELV $450
ADDRFP4 4
INDIRP4
INDIRP4
ARGP4
ADDRGP4 $457
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $459
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 4
NEI4 $455
LABELV $459
ADDRGP4 weap_allowed+12
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $455
line 1134
;1134:				ent->r.svFlags |= SVF_NOCLIENT;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1135
;1135:				ent->s.eFlags |= EF_NODRAW;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 1136
;1136:			} else if ( (!Q_stricmp( item->classname, "ammo_rockets" ) || item->giTag == WP_ROCKET_LAUNCHER) && !(weap_allowed.integer & 16) ) {
ADDRGP4 $456
JUMPV
LABELV $455
ADDRFP4 4
INDIRP4
INDIRP4
ARGP4
ADDRGP4 $462
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $464
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 5
NEI4 $460
LABELV $464
ADDRGP4 weap_allowed+12
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $460
line 1137
;1137:				ent->r.svFlags |= SVF_NOCLIENT;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1138
;1138:				ent->s.eFlags |= EF_NODRAW;
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 1139
;1139:			} else if ( (!Q_stricmp( item->classname, "ammo_lightning" ) || item->giTag == WP_LIGHTNING) && !(weap_allowed.integer & 32) ) {
ADDRGP4 $461
JUMPV
LABELV $460
ADDRFP4 4
INDIRP4
INDIRP4
ARGP4
ADDRGP4 $467
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $469
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 6
NEI4 $465
LABELV $469
ADDRGP4 weap_allowed+12
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
NEI4 $465
line 1140
;1140:				ent->r.svFlags |= SVF_NOCLIENT;
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
line 1141
;1141:				ent->s.eFlags |= EF_NODRAW;
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
line 1142
;1142:			} else if ( (!Q_stricmp( item->classname, "ammo_slugs" ) || item->giTag == WP_RAILGUN) && !(weap_allowed.integer & 64) ) {
ADDRGP4 $466
JUMPV
LABELV $465
ADDRFP4 4
INDIRP4
INDIRP4
ARGP4
ADDRGP4 $472
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $474
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 7
NEI4 $470
LABELV $474
ADDRGP4 weap_allowed+12
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
NEI4 $470
line 1143
;1143:				ent->r.svFlags |= SVF_NOCLIENT;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1144
;1144:				ent->s.eFlags |= EF_NODRAW;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 1145
;1145:			} else if ( (!Q_stricmp( item->classname, "ammo_cells" ) || item->giTag == WP_PLASMAGUN) && !(weap_allowed.integer & 128) ) {
ADDRGP4 $471
JUMPV
LABELV $470
ADDRFP4 4
INDIRP4
INDIRP4
ARGP4
ADDRGP4 $477
ARGP4
ADDRLP4 32
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $479
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 8
NEI4 $475
LABELV $479
ADDRGP4 weap_allowed+12
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
NEI4 $475
line 1146
;1146:				ent->r.svFlags |= SVF_NOCLIENT;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1147
;1147:				ent->s.eFlags |= EF_NODRAW;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 1148
;1148:			} else if ( (!Q_stricmp( item->classname, "ammo_bfg" ) || item->giTag == WP_BFG) && !(weap_allowed.integer & 256) ) {
ADDRGP4 $476
JUMPV
LABELV $475
ADDRFP4 4
INDIRP4
INDIRP4
ARGP4
ADDRGP4 $482
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $484
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 9
NEI4 $480
LABELV $484
ADDRGP4 weap_allowed+12
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
NEI4 $480
line 1149
;1149:				ent->r.svFlags |= SVF_NOCLIENT;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1150
;1150:				ent->s.eFlags |= EF_NODRAW;
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 1151
;1151:			}/** Probablay no longer need this **/
LABELV $480
LABELV $476
LABELV $471
LABELV $466
LABELV $461
LABELV $456
LABELV $451
LABELV $446
line 1152
;1152:		}
LABELV $442
line 1154
;1153:
;1154:	ent->physicsBounce = 0.50;		// items are bouncy
ADDRFP4 0
INDIRP4
CNSTI4 568
ADDP4
CNSTF4 1056964608
ASGNF4
line 1156
;1155:
;1156:	if ( item->giType == IT_POWERUP && g_gamemode.integer == 0 ) {
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
NEI4 $485
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 0
NEI4 $485
line 1157
;1157:		G_SoundIndex( "sound/items/poweruprespawn.wav" );
ADDRGP4 $219
ARGP4
ADDRGP4 G_SoundIndex
CALLI4
pop
line 1158
;1158:		G_SpawnFloat( "noglobalsound", "0", &ent->speed);
ADDRGP4 $488
ARGP4
ADDRGP4 $428
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 672
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 1159
;1159:	}
LABELV $485
line 1166
;1160:
;1161:#ifdef MISSIONPACK
;1162:	if ( item->giType == IT_PERSISTANT_POWERUP ) {
;1163:		ent->s.generic1 = ent->spawnflags;
;1164:	}
;1165:#endif
;1166:	}
LABELV $436
line 1167
;1167:}
LABELV $426
endproc G_SpawnItem 48 12
export G_BounceItem
proc G_BounceItem 64 12
line 1176
;1168:
;1169:
;1170:/*
;1171:================
;1172:G_BounceItem
;1173:
;1174:================
;1175:*/
;1176:void G_BounceItem( gentity_t *ent, trace_t *trace ) {
line 1182
;1177:	vec3_t	velocity;
;1178:	float	dot;
;1179:	int		hitTime;
;1180:
;1181:	// reflect the velocity on the trace plane
;1182:	hitTime = level.previousTime + ( level.time - level.previousTime ) * trace->fraction;
ADDRLP4 16
ADDRGP4 level+44
INDIRI4
CVIF4 4
ADDRGP4 level+40
INDIRI4
ADDRGP4 level+44
INDIRI4
SUBI4
CVIF4 4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 1183
;1183:	BG_EvaluateTrajectoryDelta( &ent->s.pos, hitTime, velocity );
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BG_EvaluateTrajectoryDelta
CALLV
pop
line 1184
;1184:	dot = DotProduct( velocity, trace->plane.normal );
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1185
;1185:	VectorMA( velocity, -2*dot, trace->plane.normal, ent->s.pos.trDelta );
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 0
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
CNSTF4 3221225472
ADDRLP4 12
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 0+4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 3221225472
ADDRLP4 12
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 0+8
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
CNSTF4 3221225472
ADDRLP4 12
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 1188
;1186:
;1187:	// cut the velocity to keep from bouncing forever
;1188:	VectorScale( ent->s.pos.trDelta, ent->physicsBounce, ent->s.pos.trDelta );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 568
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
ADDRLP4 32
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 568
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
ADDRLP4 40
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 568
ADDP4
INDIRF4
MULF4
ASGNF4
line 1191
;1189:
;1190:	// check for stop
;1191:	if ( trace->plane.normal[2] > 0 && ent->s.pos.trDelta[2] < 40 ) {
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
CNSTF4 0
LEF4 $497
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRF4
CNSTF4 1109393408
GEF4 $497
line 1192
;1192:		trace->endpos[2] += 1.0;	// make sure it is off ground
ADDRLP4 48
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1193
;1193:		SnapVector( trace->endpos );
ADDRLP4 52
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 56
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 60
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 1194
;1194:		G_SetOrigin( ent, trace->endpos );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 1195
;1195:		ent->s.groundEntityNum = trace->entityNum;
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
ASGNI4
line 1197
;1196://freeze
;1197:		if ( g_gamemode.integer > 3 && ent->pain_debounce_time < level.time - 700 ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $489
ADDRFP4 0
INDIRP4
CNSTI4 720
ADDP4
INDIRI4
ADDRGP4 level+40
INDIRI4
CNSTI4 700
SUBI4
GEI4 $489
line 1198
;1198:			ent->pain_debounce_time = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 720
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 1199
;1199:			G_AddEvent( ent, EV_FALL_SHORT, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 10
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 1200
;1200:		}
line 1202
;1201://freeze
;1202:		return;
ADDRGP4 $489
JUMPV
LABELV $497
line 1205
;1203:	}
;1204:
;1205:	VectorAdd( ent->r.currentOrigin, trace->plane.normal, ent->r.currentOrigin);
ADDRLP4 48
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 492
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1206
;1206:	VectorCopy( ent->r.currentOrigin, ent->s.pos.trBase );
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 1207
;1207:	ent->s.pos.trTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 1208
;1208:}
LABELV $489
endproc G_BounceItem 64 12
export G_RunItem
proc G_RunItem 116 28
line 1217
;1209:
;1210:
;1211:/*
;1212:================
;1213:G_RunItem
;1214:
;1215:================
;1216:*/
;1217:void G_RunItem( gentity_t *ent ) {
line 1226
;1218:	vec3_t		origin;
;1219:	trace_t		tr;
;1220:	int			contents;
;1221:	int			mask;
;1222:
;1223:	//G_Printf("G_RunItem:\n");
;1224:
;1225:	// if groundentity has been set to -1, it may have been pushed off an edge
;1226:	if ( ent->s.groundEntityNum == -1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $506
line 1228
;1227:		//G_Printf("ent->s.groundEntityNum == -1\n");
;1228:		if ( ent->s.pos.trType != TR_GRAVITY ) {
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 5
EQI4 $508
line 1230
;1229:		//	G_Printf("ent->s.pos.trType != TR_GRAVITY\n");
;1230:			ent->s.pos.trType = TR_GRAVITY;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 5
ASGNI4
line 1231
;1231:			ent->s.pos.trTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 1232
;1232:		}
LABELV $508
line 1233
;1233:	}
LABELV $506
line 1235
;1234:
;1235:	if ( ent->s.pos.trType == TR_STATIONARY ) {
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
NEI4 $511
line 1238
;1236:		//G_Printf("TR_STATIONARY: G_RunThink( ent );\n");
;1237:		// check think function
;1238:		G_RunThink( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_RunThink
CALLV
pop
line 1239
;1239:		return;
ADDRGP4 $505
JUMPV
LABELV $511
line 1243
;1240:	}
;1241:
;1242:	// get current position
;1243:	BG_EvaluateTrajectory( &ent->s.pos, level.time, origin );
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 level+40
INDIRI4
ARGI4
ADDRLP4 56
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 1246
;1244:
;1245:	// trace a line from the previous position to the current position
;1246:	if ( ent->clipmask ) {
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
CNSTI4 0
EQI4 $514
line 1247
;1247:		mask = ent->clipmask;
ADDRLP4 72
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
ASGNI4
line 1248
;1248:	} else {
ADDRGP4 $515
JUMPV
LABELV $514
line 1249
;1249:		mask = MASK_PLAYERSOLID & ~CONTENTS_BODY;//MASK_SOLID;
ADDRLP4 72
CNSTI4 65537
ASGNI4
line 1250
;1250:	}
LABELV $515
line 1252
;1251://freeze
;1252:	if ( g_gamemode.integer > 3 && is_body_freeze( ent ) )
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $516
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 is_body_freeze
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
EQI4 $516
line 1253
;1253:		trap_Trace( &tr, ent->r.currentOrigin, ent->r.mins, ent->r.maxs, origin, ent->s.number, mask );
ADDRLP4 0
ARGP4
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 80
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRLP4 80
INDIRP4
CNSTI4 448
ADDP4
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 80
INDIRP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
ADDRGP4 $517
JUMPV
LABELV $516
line 1256
;1254:	else
;1255://freeze
;1256:	trap_Trace( &tr, ent->r.currentOrigin, ent->r.mins, ent->r.maxs, origin, 
ADDRLP4 0
ARGP4
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 84
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRLP4 84
INDIRP4
CNSTI4 448
ADDP4
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 84
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
LABELV $517
line 1259
;1257:		ent->r.ownerNum, mask );
;1258:
;1259:	VectorCopy( tr.endpos, ent->r.currentOrigin );
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 0+12
INDIRB
ASGNB 12
line 1261
;1260:
;1261:	if ( tr.startsolid ) {
ADDRLP4 0+4
INDIRI4
CNSTI4 0
EQI4 $520
line 1262
;1262:		tr.fraction = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 1263
;1263:	}
LABELV $520
line 1266
;1264:	
;1265:	//G_Printf("trap_LinkEntity( ent );\n");
;1266:	trap_LinkEntity( ent );	// FIXME: avoid this for stationary?
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 1270
;1267:
;1268:	// check think function
;1269:	//G_Printf("G_RunThink( ent );\n");
;1270:	G_RunThink( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_RunThink
CALLV
pop
line 1272
;1271:
;1272:	if ( tr.fraction == 1 ) {
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
NEF4 $524
line 1273
;1273:		return;
ADDRGP4 $505
JUMPV
LABELV $524
line 1277
;1274:	}
;1275:
;1276:	// if it is in a nodrop volume, remove it
;1277:	contents = trap_PointContents( ent->r.currentOrigin, -1 );
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 88
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 68
ADDRLP4 88
INDIRI4
ASGNI4
line 1282
;1278:
;1279:	//Monkk: flag sacrifice
;1280:	//TODO: Evo check this for freeze...
;1281:	//if ( contents & CONTENTS_NODROP ) {
;1282:	if((contents & (CONTENTS_NODROP | CONTENTS_LAVA | CONTENTS_SLIME) ) || (ent->watertype & (CONTENTS_LAVA | CONTENTS_SLIME)) ) {
ADDRLP4 68
INDIRI4
CVIU4 4
CNSTU4 2147483672
BANDU4
CNSTU4 0
NEU4 $529
ADDRFP4 0
INDIRP4
CNSTI4 784
ADDP4
INDIRI4
CNSTI4 24
BANDI4
CNSTI4 0
EQI4 $527
LABELV $529
line 1283
;1283:		if (g_flagSacrifice.integer != 0 && ent->item && (ent->item->giType == IT_TEAM) && (ent->item->giTag) && (ent->item->giTag == PW_REDFLAG || ent->item->giTag == PW_BLUEFLAG || ent->item->giTag == PW_NEUTRALFLAG) ) {
ADDRLP4 92
CNSTI4 0
ASGNI4
ADDRGP4 g_flagSacrifice+12
INDIRI4
ADDRLP4 92
INDIRI4
EQI4 $530
ADDRLP4 96
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $530
ADDRLP4 100
CNSTI4 8
ASGNI4
ADDRLP4 96
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRLP4 100
INDIRI4
NEI4 $530
ADDRLP4 104
ADDRLP4 96
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ASGNI4
ADDRLP4 104
INDIRI4
ADDRLP4 92
INDIRI4
EQI4 $530
ADDRLP4 104
INDIRI4
CNSTI4 7
EQI4 $534
ADDRLP4 104
INDIRI4
ADDRLP4 100
INDIRI4
EQI4 $534
ADDRLP4 104
INDIRI4
CNSTI4 9
NEI4 $530
LABELV $534
line 1284
;1284:			SpawnFlagAtLastKnownGood(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 SpawnFlagAtLastKnownGood
CALLV
pop
line 1285
;1285:		} else {
ADDRGP4 $505
JUMPV
LABELV $530
line 1286
;1286:			if(ent->item && ent->item->giType == IT_TEAM) {
ADDRLP4 108
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
ASGNP4
ADDRLP4 108
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $535
ADDRLP4 108
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $535
line 1287
;1287:				Team_FreeEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Team_FreeEntity
CALLV
pop
line 1288
;1288:			} else {
ADDRGP4 $505
JUMPV
LABELV $535
line 1290
;1289://freeze
;1290:				if ( g_gamemode.integer > 3 ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $537
line 1291
;1291:					if ( is_body( ent ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 112
ADDRGP4 is_body
CALLI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 0
EQI4 $540
line 1292
;1292:						if ( level.time - ent->timestamp > 10000 ) {
ADDRGP4 level+40
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 640
ADDP4
INDIRI4
SUBI4
CNSTI4 10000
LEI4 $505
line 1293
;1293:							Body_free( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Body_free
CALLV
pop
line 1294
;1294:						}
line 1295
;1295:						return;
ADDRGP4 $505
JUMPV
LABELV $540
line 1297
;1296:					}
;1297:				}
LABELV $537
line 1299
;1298://freeze
;1299:				G_FreeEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 1300
;1300:			}
line 1301
;1301:		}
line 1302
;1302:		return;
ADDRGP4 $505
JUMPV
LABELV $527
line 1305
;1303:	}
;1304:
;1305:	G_BounceItem( ent, &tr );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_BounceItem
CALLV
pop
line 1306
;1306:}
LABELV $505
endproc G_RunItem 116 28
bss
export itemRegistered
align 4
LABELV itemRegistered
skip 1024
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
import ArmorIndex
import Think_Weapon
import SetRespawn
import PrecacheItem
import UseHoldableItem
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
LABELV $488
byte 1 110
byte 1 111
byte 1 103
byte 1 108
byte 1 111
byte 1 98
byte 1 97
byte 1 108
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $482
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 95
byte 1 98
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $477
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 95
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 0
align 1
LABELV $472
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 95
byte 1 115
byte 1 108
byte 1 117
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $467
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 95
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $462
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 95
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $457
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 95
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $452
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 95
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 0
align 1
LABELV $447
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 95
byte 1 98
byte 1 117
byte 1 108
byte 1 108
byte 1 101
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $429
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $428
byte 1 48
byte 1 0
align 1
LABELV $427
byte 1 114
byte 1 97
byte 1 110
byte 1 100
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $425
byte 1 100
byte 1 105
byte 1 115
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 95
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $423
byte 1 37
byte 1 105
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 103
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $415
byte 1 82
byte 1 101
byte 1 103
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 58
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 0
align 1
LABELV $410
byte 1 94
byte 1 51
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 78
byte 1 111
byte 1 32
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
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $406
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $405
byte 1 94
byte 1 51
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 78
byte 1 111
byte 1 32
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
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $401
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $381
byte 1 70
byte 1 105
byte 1 110
byte 1 105
byte 1 115
byte 1 104
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 115
byte 1 111
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $364
byte 1 110
byte 1 101
byte 1 119
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 116
byte 1 111
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $308
byte 1 73
byte 1 116
byte 1 101
byte 1 109
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
LABELV $224
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 107
byte 1 97
byte 1 109
byte 1 105
byte 1 107
byte 1 97
byte 1 122
byte 1 101
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $219
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $202
byte 1 82
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 58
byte 1 32
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 109
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $162
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
