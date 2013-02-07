export P_DamageFeedback
code
proc P_DamageFeedback 36 12
file "../g_active.c"
line 18
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:
;4:#include "g_local.h"
;5:#include "bg_promode.h" // CPM
;6:
;7:
;8:/*
;9:===============
;10:G_DamageFeedback
;11:
;12:Called just before a snapshot is sent to the given player.
;13:Totals up all damage and generates both the player_state_t
;14:damage values to that client for pain blends and kicks, and
;15:global pain sound events for all clients.
;16:===============
;17:*/
;18:void P_DamageFeedback( gentity_t *player ) {
line 23
;19:	gclient_t	*client;
;20:	float	count;
;21:	vec3_t	angles;
;22:
;23:	client = player->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 24
;24:	if ( client->ps.pm_type == PM_DEAD ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $68
line 25
;25:		return;
ADDRGP4 $67
JUMPV
LABELV $68
line 29
;26:	}
;27:
;28:	// total points of damage shot at the player this frame
;29:	count = client->damage_blood + client->damage_armor;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 10284
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 10280
ADDP4
INDIRI4
ADDI4
CVIF4 4
ASGNF4
line 30
;30:	if ( count == 0 ) {
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $70
line 31
;31:		return;		// didn't take any damage
ADDRGP4 $67
JUMPV
LABELV $70
line 34
;32:	}
;33:
;34:	if ( count > 255 ) {
ADDRLP4 4
INDIRF4
CNSTF4 1132396544
LEF4 $72
line 35
;35:		count = 255;
ADDRLP4 4
CNSTF4 1132396544
ASGNF4
line 36
;36:	}
LABELV $72
line 42
;37:
;38:	// send the information to the client
;39:
;40:	// world damage (falling, slime, etc) uses a special code
;41:	// to make the blend blob centered instead of positional
;42:	if ( client->damage_fromWorld ) {
ADDRLP4 0
INDIRP4
CNSTI4 10304
ADDP4
INDIRI4
CNSTI4 0
EQI4 $74
line 43
;43:		client->ps.damagePitch = 255;
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
CNSTI4 255
ASGNI4
line 44
;44:		client->ps.damageYaw = 255;
ADDRLP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 255
ASGNI4
line 46
;45:
;46:		client->damage_fromWorld = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 10304
ADDP4
CNSTI4 0
ASGNI4
line 47
;47:	} else {
ADDRGP4 $75
JUMPV
LABELV $74
line 48
;48:		vectoangles( client->damage_from, angles );
ADDRLP4 0
INDIRP4
CNSTI4 10292
ADDP4
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 49
;49:		client->ps.damagePitch = angles[PITCH]/360.0 * 256;
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
CNSTF4 1132462080
ADDRLP4 8
INDIRF4
CNSTF4 1135869952
DIVF4
MULF4
CVFI4 4
ASGNI4
line 50
;50:		client->ps.damageYaw = angles[YAW]/360.0 * 256;
ADDRLP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTF4 1132462080
ADDRLP4 8+4
INDIRF4
CNSTF4 1135869952
DIVF4
MULF4
CVFI4 4
ASGNI4
line 51
;51:	}
LABELV $75
line 54
;52:
;53:	// play an apropriate pain sound
;54:	if ( (level.time > player->pain_debounce_time) && !(player->flags & FL_GODMODE) ) {
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 level+40
INDIRI4
ADDRLP4 24
INDIRP4
CNSTI4 720
ADDP4
INDIRI4
LEI4 $77
ADDRLP4 24
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $77
line 55
;55:		player->pain_debounce_time = level.time + 700;
ADDRFP4 0
INDIRP4
CNSTI4 720
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 700
ADDI4
ASGNI4
line 56
;56:		G_AddEvent( player, EV_PAIN, player->health );
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
CNSTI4 56
ARGI4
ADDRLP4 28
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 57
;57:		client->ps.damageEvent++;
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 58
;58:	}
LABELV $77
line 61
;59:
;60:
;61:	client->ps.damageCount = count;
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 4
INDIRF4
CVFI4 4
ASGNI4
line 66
;62:
;63:	//
;64:	// clear totals
;65:	//
;66:	client->damage_blood = 0;
ADDRLP4 0
INDIRP4
CNSTI4 10284
ADDP4
CNSTI4 0
ASGNI4
line 67
;67:	client->damage_armor = 0;
ADDRLP4 0
INDIRP4
CNSTI4 10280
ADDP4
CNSTI4 0
ASGNI4
line 68
;68:	client->damage_knockback = 0;
ADDRLP4 0
INDIRP4
CNSTI4 10288
ADDP4
CNSTI4 0
ASGNI4
line 69
;69:}
LABELV $67
endproc P_DamageFeedback 36 12
export P_WorldEffects
proc P_WorldEffects 40 32
line 80
;70:
;71:
;72:
;73:/*
;74:=============
;75:P_WorldEffects
;76:
;77:Check for lava / slime contents and drowning
;78:=============
;79:*/
;80:void P_WorldEffects( gentity_t *ent ) {
line 84
;81:	qboolean	envirosuit;
;82:	int			waterlevel;
;83:
;84:	if ( ent->client->noclip ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10240
ADDP4
INDIRI4
CNSTI4 0
EQI4 $82
line 85
;85:		ent->client->airOutTime = level.time + 12000;	// don't need air
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10348
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 12000
ADDI4
ASGNI4
line 86
;86:		return;
ADDRGP4 $81
JUMPV
LABELV $82
line 89
;87:	}
;88:
;89:	waterlevel = ent->waterlevel;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 788
ADDP4
INDIRI4
ASGNI4
line 91
;90:
;91:	envirosuit = ent->client->ps.powerups[PW_BATTLESUIT] > level.time;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 320
ADDP4
INDIRI4
ADDRGP4 level+40
INDIRI4
LEI4 $87
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 $88
JUMPV
LABELV $87
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $88
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 96
;92:
;93:	//
;94:	// check for drowning
;95:	//
;96:	if ( waterlevel == 3 ) {
ADDRLP4 0
INDIRI4
CNSTI4 3
NEI4 $89
line 98
;97:		// envirosuit give air
;98:		if ( envirosuit ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $91
line 99
;99:			ent->client->airOutTime = level.time + 10000;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10348
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 10000
ADDI4
ASGNI4
line 100
;100:		}
LABELV $91
line 103
;101:
;102:		// if out of air, start drowning
;103:		if ( ent->client->airOutTime < level.time) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10348
ADDP4
INDIRI4
ADDRGP4 level+40
INDIRI4
GEI4 $90
line 105
;104:			// drown!
;105:			ent->client->airOutTime += 1000;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10348
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 106
;106:			if ( ent->health > 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 0
LEI4 $90
line 108
;107:				// take more damage the longer underwater
;108:				ent->damage += 2;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 109
;109:				if (ent->damage > 15)
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
CNSTI4 15
LEI4 $99
line 110
;110:					ent->damage = 15;
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
CNSTI4 15
ASGNI4
LABELV $99
line 113
;111:
;112:				// play a gurp sound instead of a normal pain sound
;113:				if (ent->health <= ent->damage) {
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRLP4 20
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
GTI4 $101
line 114
;114:					G_Sound(ent, CHAN_VOICE, G_SoundIndex("*drown.wav"));
ADDRGP4 $103
ARGP4
ADDRLP4 24
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 G_Sound
CALLV
pop
line 115
;115:				} else if (rand()&1) {
ADDRGP4 $102
JUMPV
LABELV $101
ADDRLP4 24
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $104
line 116
;116:					G_Sound(ent, CHAN_VOICE, G_SoundIndex("sound/player/gurp1.wav"));
ADDRGP4 $106
ARGP4
ADDRLP4 28
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRGP4 G_Sound
CALLV
pop
line 117
;117:				} else {
ADDRGP4 $105
JUMPV
LABELV $104
line 118
;118:					G_Sound(ent, CHAN_VOICE, G_SoundIndex("sound/player/gurp2.wav"));
ADDRGP4 $107
ARGP4
ADDRLP4 28
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRGP4 G_Sound
CALLV
pop
line 119
;119:				}
LABELV $105
LABELV $102
line 122
;120:
;121:				// don't play a normal pain sound
;122:				ent->pain_debounce_time = level.time + 200;
ADDRFP4 0
INDIRP4
CNSTI4 720
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 124
;123:
;124:				G_Damage (ent, NULL, NULL, NULL, NULL, 
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 32
CNSTP4 0
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 36
CNSTP4 0
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
CNSTI4 14
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 126
;125:					ent->damage, DAMAGE_NO_ARMOR, MOD_WATER);
;126:			}
line 127
;127:		}
line 128
;128:	} else {
ADDRGP4 $90
JUMPV
LABELV $89
line 129
;129:		ent->client->airOutTime = level.time + 12000;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10348
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 12000
ADDI4
ASGNI4
line 130
;130:		ent->damage = 2;
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
CNSTI4 2
ASGNI4
line 131
;131:	}
LABELV $90
line 136
;132:
;133:	//
;134:	// check for sizzle damage (move to pmove?)
;135:	//
;136:	if (waterlevel && 
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $110
ADDRFP4 0
INDIRP4
CNSTI4 784
ADDP4
INDIRI4
CNSTI4 24
BANDI4
ADDRLP4 12
INDIRI4
EQI4 $110
line 137
;137:		(ent->watertype&(CONTENTS_LAVA|CONTENTS_SLIME)) ) {
line 138
;138:		if (ent->health > 0
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 0
LEI4 $112
ADDRLP4 16
INDIRP4
CNSTI4 720
ADDP4
INDIRI4
ADDRGP4 level+40
INDIRI4
GTI4 $112
line 139
;139:			&& ent->pain_debounce_time <= level.time	) {
line 141
;140:
;141:			if ( envirosuit ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $115
line 142
;142:				G_AddEvent( ent, EV_POWERUP_BATTLESUIT, 0 );
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
line 143
;143:			} else {
ADDRGP4 $116
JUMPV
LABELV $115
line 144
;144:				if (ent->watertype & CONTENTS_LAVA) {
ADDRFP4 0
INDIRP4
CNSTI4 784
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $117
line 145
;145:					G_Damage (ent, NULL, NULL, NULL, NULL, 
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
CNSTP4 0
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
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
CNSTI4 30
ADDRLP4 0
INDIRI4
MULI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 147
;146:						30*waterlevel, 0, MOD_LAVA);
;147:				}
LABELV $117
line 149
;148:
;149:				if (ent->watertype & CONTENTS_SLIME) {
ADDRFP4 0
INDIRP4
CNSTI4 784
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $119
line 150
;150:					G_Damage (ent, NULL, NULL, NULL, NULL, 
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
CNSTP4 0
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
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
CNSTI4 10
ADDRLP4 0
INDIRI4
MULI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 15
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 152
;151:						10*waterlevel, 0, MOD_SLIME);
;152:				}
LABELV $119
line 153
;153:			}
LABELV $116
line 154
;154:		}
LABELV $112
line 155
;155:	}
LABELV $110
line 156
;156:}
LABELV $81
endproc P_WorldEffects 40 32
export G_SetClientSound
proc G_SetClientSound 8 0
line 165
;157:
;158:
;159:
;160:/*
;161:===============
;162:G_SetClientSound
;163:===============
;164:*/
;165:void G_SetClientSound( gentity_t *ent ) {
line 172
;166:#ifdef MISSIONPACK
;167:	if( ent->s.eFlags & EF_TICKING ) {
;168:		ent->client->ps.loopSound = G_SoundIndex( "sound/weapons/proxmine/wstbtick.wav");
;169:	}
;170:	else
;171:#endif
;172:	if (ent->waterlevel && (ent->watertype&(CONTENTS_LAVA|CONTENTS_SLIME)) ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 788
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $122
ADDRLP4 0
INDIRP4
CNSTI4 784
ADDP4
INDIRI4
CNSTI4 24
BANDI4
ADDRLP4 4
INDIRI4
EQI4 $122
line 173
;173:		ent->client->ps.loopSound = level.snd_fry;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 444
ADDP4
ADDRGP4 level+388
INDIRI4
ASGNI4
line 174
;174:	} else {
ADDRGP4 $123
JUMPV
LABELV $122
line 175
;175:		ent->client->ps.loopSound = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 444
ADDP4
CNSTI4 0
ASGNI4
line 176
;176:	}
LABELV $123
line 177
;177:}
LABELV $121
endproc G_SetClientSound 8 0
export ClientImpacts
proc ClientImpacts 76 12
line 188
;178:
;179:
;180:
;181://==============================================================
;182:
;183:/*
;184:==============
;185:ClientImpacts
;186:==============
;187:*/
;188:void ClientImpacts( gentity_t *ent, pmove_t *pm ) {
line 193
;189:	int		i, j;
;190:	trace_t	trace;
;191:	gentity_t	*other;
;192:
;193:	memset( &trace, 0, sizeof( trace ) );
ADDRLP4 12
ARGP4
CNSTI4 0
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 memset
CALLP4
pop
line 194
;194:	for (i=0 ; i<pm->numtouch ; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $129
JUMPV
LABELV $126
line 195
;195:		for (j=0 ; j<i ; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $133
JUMPV
LABELV $130
line 196
;196:			if (pm->touchents[j] == pm->touchents[i] ) {
ADDRLP4 68
CNSTI4 2
ASGNI4
ADDRLP4 72
ADDRFP4 4
INDIRP4
CNSTI4 56
ADDP4
ASGNP4
ADDRLP4 0
INDIRI4
ADDRLP4 68
INDIRI4
LSHI4
ADDRLP4 72
INDIRP4
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDRLP4 68
INDIRI4
LSHI4
ADDRLP4 72
INDIRP4
ADDP4
INDIRI4
NEI4 $134
line 197
;197:				break;
ADDRGP4 $132
JUMPV
LABELV $134
line 199
;198:			}
;199:		}
LABELV $131
line 195
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $133
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $130
LABELV $132
line 200
;200:		if (j != i) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $136
line 201
;201:			continue;	// duplicated
ADDRGP4 $127
JUMPV
LABELV $136
line 203
;202:		}
;203:		other = &g_entities[ pm->touchents[i] ];
ADDRLP4 8
CNSTI4 896
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 56
ADDP4
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 212
;204:
;205:		
;206:		/*if (!G_AllowEntityInteraction(ent, other))
;207:		{
;208:			continue;
;209:		}*/
;210:
;211:
;212:		if ( ( ent->r.svFlags & SVF_BOT ) && ( ent->touch ) ) {
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $138
ADDRLP4 68
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $138
line 213
;213:			ent->touch( ent, other, &trace );
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CALLV
pop
line 214
;214:		}
LABELV $138
line 216
;215:
;216:		if ( !other->touch ) {
ADDRLP4 8
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $140
line 217
;217:			continue;
ADDRGP4 $127
JUMPV
LABELV $140
line 220
;218:		}
;219:
;220:		other->touch( other, ent, &trace );
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CALLV
pop
line 221
;221:	}
LABELV $127
line 194
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $129
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
LTI4 $126
line 223
;222:
;223:}
LABELV $125
endproc ClientImpacts 76 12
data
align 4
LABELV $143
byte 4 1109393408
byte 4 1109393408
byte 4 1112539136
export G_TouchTriggers
code
proc G_TouchTriggers 4244 16
line 233
;224:
;225:/*
;226:============
;227:G_TouchTriggers
;228:
;229:Find all trigger entities that ent's current position touches.
;230:Spectators will only interact with teleporters.
;231:============
;232:*/
;233:void	G_TouchTriggers( gentity_t *ent ) {
line 243
;234:	int			i, num;
;235:	int			touch[MAX_GENTITIES];
;236:	gentity_t	*hit;
;237:	trace_t		trace;
;238:	vec3_t		mins, maxs;
;239:	//vec3_t		origin;
;240:	//qboolean	weTouch = qtrue;
;241:	static vec3_t	range = { 40, 40, 52 };//This might be helpful for total control
;242:
;243:	if ( !ent->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $144
line 244
;244:		return;
ADDRGP4 $142
JUMPV
LABELV $144
line 248
;245:	}
;246:
;247:	// dead clients don't activate triggers!
;248:	if ( ent->client->ps.stats[STAT_HEALTH] <= 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $146
line 249
;249:		return;
ADDRGP4 $142
JUMPV
LABELV $146
line 254
;250:	}
;251:
;252:	//Play with range and the mins and maxs in the trap
;253:	//Do we gain anything by doing that?
;254:	VectorSubtract( ent->client->ps.origin, range, mins );
ADDRLP4 4188
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
ASGNP4
ADDRLP4 64
ADDRLP4 4188
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRGP4 $143
INDIRF4
SUBF4
ASGNF4
ADDRLP4 64+4
ADDRLP4 4188
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRGP4 $143+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 64+8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRGP4 $143+8
INDIRF4
SUBF4
ASGNF4
line 255
;255:	VectorAdd( ent->client->ps.origin, range, maxs );
ADDRLP4 4192
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
ASGNP4
ADDRLP4 76
ADDRLP4 4192
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRGP4 $143
INDIRF4
ADDF4
ASGNF4
ADDRLP4 76+4
ADDRLP4 4192
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRGP4 $143+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 76+8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRGP4 $143+8
INDIRF4
ADDF4
ASGNF4
line 257
;256:
;257:	num = trap_EntitiesInBox( mins, maxs, touch, MAX_GENTITIES );
ADDRLP4 64
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 92
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 4196
ADDRGP4 trap_EntitiesInBox
CALLI4
ASGNI4
ADDRLP4 88
ADDRLP4 4196
INDIRI4
ASGNI4
line 260
;258:
;259:	// can't use ent->absmin, because that has a one unit pad
;260:	VectorAdd( ent->client->ps.origin, ent->r.mins, mins );
ADDRLP4 4200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4204
ADDRLP4 4200
INDIRP4
CNSTI4 516
ADDP4
ASGNP4
ADDRLP4 64
ADDRLP4 4204
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 4200
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 64+4
ADDRLP4 4204
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 4200
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4208
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64+8
ADDRLP4 4208
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 4208
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
ADDF4
ASGNF4
line 261
;261:	VectorAdd( ent->client->ps.origin, ent->r.maxs, maxs );
ADDRLP4 4212
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4216
ADDRLP4 4212
INDIRP4
CNSTI4 516
ADDP4
ASGNP4
ADDRLP4 76
ADDRLP4 4216
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 4212
INDIRP4
CNSTI4 448
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 76+4
ADDRLP4 4216
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 4212
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4220
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76+8
ADDRLP4 4220
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 4220
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
ADDF4
ASGNF4
line 264
;262:
;263:	//G_Printf("%i\n", cpm_itemsize);
;264:	for ( i=0 ; i<num ; i++ ) {
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRGP4 $163
JUMPV
LABELV $160
line 265
;265:		hit = &g_entities[touch[i]];
ADDRLP4 0
CNSTI4 896
ADDRLP4 60
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 92
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 267
;266:
;267:		if ( !hit->touch && !ent->touch ) {
ADDRLP4 4224
CNSTI4 704
ASGNI4
ADDRLP4 4228
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
ADDRLP4 4224
INDIRI4
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 4228
INDIRU4
NEU4 $164
ADDRFP4 0
INDIRP4
ADDRLP4 4224
INDIRI4
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 4228
INDIRU4
NEU4 $164
line 268
;268:			continue;
ADDRGP4 $161
JUMPV
LABELV $164
line 270
;269:		}
;270:		if ( !( hit->r.contents & CONTENTS_TRIGGER ) ) {
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
INDIRI4
CNSTI4 1073741824
BANDI4
CNSTI4 0
NEI4 $166
line 271
;271:			continue;
ADDRGP4 $161
JUMPV
LABELV $166
line 279
;272:		}
;273:
;274:		// ignore most entities if a spectator
;275:/*freeze
;276:		if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
;277:freeze*/
;278:		//if ( is_spectator( ent->client ) ) {
;279:		if ( (g_gamemode.integer > 3 && is_spectator(ent->client)) || (g_gamemode.integer < 4 && ent->client->sess.sessionTeam == TEAM_SPECTATOR) ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $173
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 4232
ADDRGP4 is_spectator
CALLI4
ASGNI4
ADDRLP4 4232
INDIRI4
CNSTI4 0
NEI4 $172
LABELV $173
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 4
GEI4 $168
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
CNSTI4 3
NEI4 $168
LABELV $172
line 281
;280://freeze
;281:			if ( hit->s.eType != ET_TELEPORT_TRIGGER &&
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 9
EQI4 $174
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 Touch_DoorTrigger
CVPU4 4
EQU4 $174
line 284
;282:				// this is ugly but adding a new ET_? type will
;283:				// most likely cause network incompatibilities
;284:				hit->touch != Touch_DoorTrigger) {
line 285
;285:				continue;
ADDRGP4 $161
JUMPV
LABELV $174
line 287
;286:			}
;287:		}
LABELV $168
line 296
;288:
;289:		/*if (!G_AllowEntityInteraction(ent, hit))
;290:		{
;291:			continue;
;292:		}*/
;293:
;294:		// use seperate code for determining if an item is picked up
;295:		// so you don't have to actually contact its bounding box
;296:		if ( hit->s.eType == ET_ITEM ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $176
line 297
;297:			memset( &trace, 0, sizeof(trace) );
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 memset
CALLP4
pop
line 299
;298:
;299:			if ( hit->touch ) {
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $178
line 300
;300:				hit->touch (hit, ent, &trace);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CALLV
pop
line 301
;301:			}
LABELV $178
line 311
;302:
;303:
;304:			/***************************
;305:			* There is most likely a
;306:			* much better way of handling
;307:			* this, but this is how I got
;308:			* it working.
;309:			***************************/
;310:			//FIXME: This shouldn't need 2 qboolean's.
;311:			if ( !g_pro_mode.integer && !BG_PlayerTouchesItem( &ent->client->ps, &hit->s, level.time ) ) {
ADDRGP4 g_pro_mode+12
INDIRI4
CNSTI4 0
NEI4 $180
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 level+40
INDIRI4
ARGI4
ADDRLP4 4236
ADDRGP4 BG_PlayerTouchesItem
CALLI4
ASGNI4
ADDRLP4 4236
INDIRI4
CNSTI4 0
NEI4 $180
line 312
;312:				continue;
ADDRGP4 $161
JUMPV
LABELV $180
line 313
;313:			} else if ( g_pro_mode.integer && !BG_ProModePlayerTouchesItem( &ent->client->ps, &hit->s, level.time ) ) {
ADDRGP4 g_pro_mode+12
INDIRI4
CNSTI4 0
EQI4 $177
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 level+40
INDIRI4
ARGI4
ADDRLP4 4240
ADDRGP4 BG_ProModePlayerTouchesItem
CALLI4
ASGNI4
ADDRLP4 4240
INDIRI4
CNSTI4 0
NEI4 $177
line 314
;314:				continue;
ADDRGP4 $161
JUMPV
line 316
;315:			}
;316:		} else {
LABELV $176
line 317
;317:			if ( !trap_EntityContact( mins, maxs, hit ) ) {
ADDRLP4 64
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4236
ADDRGP4 trap_EntityContact
CALLI4
ASGNI4
ADDRLP4 4236
INDIRI4
CNSTI4 0
NEI4 $188
line 318
;318:				continue;
ADDRGP4 $161
JUMPV
LABELV $188
line 320
;319:			}
;320:		}
LABELV $177
line 322
;321:		
;322:		memset( &trace, 0, sizeof(trace) );
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 memset
CALLP4
pop
line 324
;323:
;324:		if ( hit->touch ) {
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $190
line 325
;325:			hit->touch (hit, ent, &trace);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CALLV
pop
line 326
;326:		}
LABELV $190
line 328
;327:
;328:		if ( ( ent->r.svFlags & SVF_BOT ) && ( ent->touch ) ) {
ADDRLP4 4236
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4236
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $192
ADDRLP4 4236
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $192
line 329
;329:			ent->touch( ent, hit, &trace );
ADDRLP4 4240
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4240
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 4240
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CALLV
pop
line 330
;330:		}
LABELV $192
line 331
;331:	}
LABELV $161
line 264
ADDRLP4 60
ADDRLP4 60
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $163
ADDRLP4 60
INDIRI4
ADDRLP4 88
INDIRI4
LTI4 $160
line 334
;332:
;333:	// if we didn't touch a jump pad this pmove frame
;334:	if ( ent->client->ps.jumppad_frame != ent->client->ps.pmove_framecount ) {
ADDRLP4 4224
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4224
INDIRP4
CNSTI4 460
ADDP4
INDIRI4
ADDRLP4 4224
INDIRP4
CNSTI4 456
ADDP4
INDIRI4
EQI4 $194
line 335
;335:		ent->client->ps.jumppad_frame = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 336
;336:		ent->client->ps.jumppad_ent = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 448
ADDP4
CNSTI4 0
ASGNI4
line 337
;337:	}
LABELV $194
line 338
;338:}
LABELV $142
endproc G_TouchTriggers 4244 16
export SpectatorThink
proc SpectatorThink 268 12
line 345
;339:
;340:/*
;341:=================
;342:SpectatorThink
;343:=================
;344:*/
;345:void SpectatorThink( gentity_t *ent, usercmd_t *ucmd ) {
line 350
;346:	pmove_t	pm;
;347:	gclient_t	*client;
;348:	int		ping;
;349:
;350:	client = ent->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 353
;351:	//Ping hack, the real one?
;352:	//G_Printf("Ping_Fix %i\n", gameSettings.ping_fix);
;353:	if ( gameSettings.ping_fix ) {
ADDRGP4 gameSettings+4
INDIRI4
CNSTI4 0
EQI4 $197
line 354
;354:		ping = client->ps.ping;
ADDRLP4 248
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
ASGNI4
line 355
;355:	}
LABELV $197
line 357
;356:
;357:	if ( client->sess.spectatorState != SPECTATOR_FOLLOW ) {
ADDRLP4 0
INDIRP4
CNSTI4 10196
ADDP4
INDIRI4
CNSTI4 2
EQI4 $200
line 358
;358:		client->ps.pm_type = PM_SPECTATOR;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 2
ASGNI4
line 359
;359:		client->ps.speed = 400;	// faster than normal
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 400
ASGNI4
line 362
;360:
;361:		// set up for pmove
;362:		memset (&pm, 0, sizeof(pm));
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 244
ARGI4
ADDRGP4 memset
CALLP4
pop
line 363
;363:		pm.ps = &client->ps;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 364
;364:		pm.cmd = *ucmd;
ADDRLP4 4+4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 24
line 365
;365:		pm.tracemask = MASK_PLAYERSOLID & ~CONTENTS_BODY;	// spectators can fly through bodies
ADDRLP4 4+28
CNSTI4 65537
ASGNI4
line 366
;366:		pm.trace = trap_Trace;
ADDRLP4 4+236
ADDRGP4 trap_Trace
ASGNP4
line 367
;367:		pm.pointcontents = trap_PointContents;
ADDRLP4 4+240
ADDRGP4 trap_PointContents
ASGNP4
line 370
;368:
;369:		// perform a pmove
;370:		Pmove (&pm);
ADDRLP4 4
ARGP4
ADDRGP4 Pmove
CALLV
pop
line 372
;371:		// save results of pmove
;372:		VectorCopy( client->ps.origin, ent->s.origin );
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 374
;373:
;374:		G_TouchTriggers( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_TouchTriggers
CALLV
pop
line 376
;375://		ent->relink = 0;
;376:		trap_UnlinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 377
;377:	}
LABELV $200
line 379
;378:
;379:	if ( gameSettings.ping_fix ) {
ADDRGP4 gameSettings+4
INDIRI4
CNSTI4 0
EQI4 $206
line 380
;380:		client->ps.ping = ping;
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
ADDRLP4 248
INDIRI4
ASGNI4
line 381
;381:	}
LABELV $206
line 383
;382:
;383:	client->oldbuttons = client->buttons;
ADDRLP4 0
INDIRP4
CNSTI4 10260
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 10256
ADDP4
INDIRI4
ASGNI4
line 384
;384:	client->buttons = ucmd->buttons;
ADDRLP4 0
INDIRP4
CNSTI4 10256
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 387
;385:
;386:	// attack button cycles through spectators
;387:	if ( ( client->buttons & BUTTON_ATTACK ) && ! ( client->oldbuttons & BUTTON_ATTACK ) ) {
ADDRLP4 260
CNSTI4 1
ASGNI4
ADDRLP4 264
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 10256
ADDP4
INDIRI4
ADDRLP4 260
INDIRI4
BANDI4
ADDRLP4 264
INDIRI4
EQI4 $209
ADDRLP4 0
INDIRP4
CNSTI4 10260
ADDP4
INDIRI4
ADDRLP4 260
INDIRI4
BANDI4
ADDRLP4 264
INDIRI4
NEI4 $209
line 388
;388:		Cmd_FollowCycle_f( ent, 1 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Cmd_FollowCycle_f
CALLV
pop
line 389
;389:	}
ADDRGP4 $210
JUMPV
LABELV $209
line 391
;390://freeze
;391:	else if (g_gamemode.integer > 3) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $211
line 392
;392:		respawnSpectator( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 respawnSpectator
CALLV
pop
line 393
;393:	}
LABELV $211
LABELV $210
line 396
;394://freeze
;395:	
;396:}
LABELV $196
endproc SpectatorThink 268 12
export ClientInactivityTimer
proc ClientInactivityTimer 12 12
line 407
;397:
;398:
;399:
;400:/*
;401:=================
;402:ClientInactivityTimer
;403:
;404:Returns qfalse if the client is dropped
;405:=================
;406:*/
;407:qboolean ClientInactivityTimer( gclient_t *client ) {
line 408
;408:	if ( ! g_inactivity.integer ) {
ADDRGP4 g_inactivity+12
INDIRI4
CNSTI4 0
NEI4 $215
line 411
;409:		// give everyone some time, so if the operator sets g_inactivity during
;410:		// gameplay, everyone isn't kicked
;411:		client->inactivityTime = level.time + 60 * 1000;
ADDRFP4 0
INDIRP4
CNSTI4 10336
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 60000
ADDI4
ASGNI4
line 412
;412:		client->inactivityWarning = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 10340
ADDP4
CNSTI4 0
ASGNI4
line 413
;413:	} else if ( client->pers.cmd.forwardmove || 
ADDRGP4 $216
JUMPV
LABELV $215
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 493
ADDP4
INDIRI1
CVII4 1
ADDRLP4 4
INDIRI4
NEI4 $223
ADDRLP4 0
INDIRP4
CNSTI4 494
ADDP4
INDIRI1
CVII4 1
ADDRLP4 4
INDIRI4
NEI4 $223
ADDRLP4 0
INDIRP4
CNSTI4 495
ADDP4
INDIRI1
CVII4 1
ADDRLP4 4
INDIRI4
NEI4 $223
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 4
INDIRI4
EQI4 $219
LABELV $223
line 416
;414:		client->pers.cmd.rightmove || 
;415:		client->pers.cmd.upmove ||
;416:		(client->pers.cmd.buttons & BUTTON_ATTACK) ) {
line 417
;417:		client->inactivityTime = level.time + g_inactivity.integer * 1000;
ADDRFP4 0
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
line 418
;418:		client->inactivityWarning = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 10340
ADDP4
CNSTI4 0
ASGNI4
line 419
;419:	} else if ( !client->pers.localClient ) {
ADDRGP4 $220
JUMPV
LABELV $219
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRI4
CNSTI4 0
NEI4 $226
line 421
;420://freeze
;421:		if ( g_gamemode.integer > 3 ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $228
line 422
;422:			if ( g_entities[ client->ps.clientNum ].freezeState ) {
CNSTI4 896
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+888
ADDP4
INDIRI4
CNSTI4 0
EQI4 $231
line 423
;423:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $214
JUMPV
LABELV $231
line 425
;424:			}
;425:		}
LABELV $228
line 427
;426://freeze
;427:		if ( level.time > client->inactivityTime ) {
ADDRGP4 level+40
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 10336
ADDP4
INDIRI4
LEI4 $234
line 431
;428:			//trap_DropClient( client - level.clients, "Dropped due to inactivity" );
;429:			//Hack: We probably should build our own trap_ to do this.
;430:			//trap_SendConsoleCommand(EXEC_NOW, va("forceteam %i s", client->ps.clientNum));
;431:			SetTeam( &g_entities[client - level.clients], "s", qtrue );
CNSTI4 896
ADDRFP4 0
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
ADDRGP4 $237
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 SetTeam
CALLV
pop
line 432
;432:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $214
JUMPV
LABELV $234
line 434
;433:		}
;434:		if ( level.time > client->inactivityTime - 10000 && !client->inactivityWarning ) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 level+40
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 10336
ADDP4
INDIRI4
CNSTI4 10000
SUBI4
LEI4 $238
ADDRLP4 8
INDIRP4
CNSTI4 10340
ADDP4
INDIRI4
CNSTI4 0
NEI4 $238
line 435
;435:			client->inactivityWarning = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 10340
ADDP4
CNSTI4 1
ASGNI4
line 436
;436:			trap_SendServerCommand( client - level.clients, "cp \"Ten seconds until inactivity drop!\n\"" );
ADDRFP4 0
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
ADDRGP4 $241
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 437
;437:		}
LABELV $238
line 438
;438:	}
LABELV $226
LABELV $220
LABELV $216
line 439
;439:	return qtrue;
CNSTI4 1
RETI4
LABELV $214
endproc ClientInactivityTimer 12 12
export ClientTimerActions
proc ClientTimerActions 20 12
line 449
;440:}
;441:
;442:/*
;443:==================
;444:ClientTimerActions
;445:
;446:Actions that happen once a second
;447:==================
;448:*/
;449:void ClientTimerActions( gentity_t *ent, int msec ) {
line 455
;450:	gclient_t	*client;
;451:#ifdef MISSIONPACK
;452:	int			maxHealth;
;453:#endif
;454:
;455:	client = ent->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 456
;456:	client->timeResidual += msec;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 10372
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
ADDRFP4 4
INDIRI4
ADDI4
ASGNI4
ADDRGP4 $244
JUMPV
LABELV $243
line 458
;457:
;458:	while ( client->timeResidual >= 1000 ) {
line 459
;459:		client->timeResidual -= 1000;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 10372
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1000
SUBI4
ASGNI4
line 487
;460:
;461:		// regenerate
;462:#ifdef MISSIONPACK
;463:		if( bg_itemlist[client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_GUARD ) {
;464:			maxHealth = client->ps.stats[STAT_MAX_HEALTH] / 2;
;465:		}
;466:		else if ( client->ps.powerups[PW_REGEN] ) {
;467:			maxHealth = client->ps.stats[STAT_MAX_HEALTH];
;468:		}
;469:		else {
;470:			maxHealth = 0;
;471:		}
;472:		if( maxHealth ) {
;473:			if ( ent->health < maxHealth ) {
;474:				ent->health += 15;
;475:				if ( ent->health > maxHealth * 1.1 ) {
;476:					ent->health = maxHealth * 1.1;
;477:				}
;478:				G_AddEvent( ent, EV_POWERUP_REGEN, 0 );
;479:			} else if ( ent->health < maxHealth * 2) {
;480:				ent->health += 5;
;481:				if ( ent->health > maxHealth * 2 ) {
;482:					ent->health = maxHealth * 2;
;483:				}
;484:				G_AddEvent( ent, EV_POWERUP_REGEN, 0 );
;485:			}
;486:#else
;487:		if ( client->ps.powerups[PW_REGEN] ) {
ADDRLP4 0
INDIRP4
CNSTI4 332
ADDP4
INDIRI4
CNSTI4 0
EQI4 $246
line 488
;488:			if ( ent->health < client->ps.stats[STAT_MAX_HEALTH]) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
GEI4 $248
line 489
;489:				ent->health += 15;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 15
ADDI4
ASGNI4
line 490
;490:				if ( ent->health > client->ps.stats[STAT_MAX_HEALTH] * 1.1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1066192077
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CVIF4 4
MULF4
LEF4 $250
line 491
;491:					ent->health = client->ps.stats[STAT_MAX_HEALTH] * 1.1;
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
CNSTF4 1066192077
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 492
;492:				}
LABELV $250
line 493
;493:				G_AddEvent( ent, EV_POWERUP_REGEN, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 63
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 494
;494:			} else if ( ent->health < client->ps.stats[STAT_MAX_HEALTH] * 2) {
ADDRGP4 $247
JUMPV
LABELV $248
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1
LSHI4
GEI4 $247
line 495
;495:				ent->health += 5;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 5
ADDI4
ASGNI4
line 496
;496:				if ( ent->health > client->ps.stats[STAT_MAX_HEALTH] * 2 ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1
LSHI4
LEI4 $254
line 497
;497:					ent->health = client->ps.stats[STAT_MAX_HEALTH] * 2;
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 498
;498:				}
LABELV $254
line 499
;499:				G_AddEvent( ent, EV_POWERUP_REGEN, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 63
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 500
;500:			}
line 502
;501:#endif
;502:		} else {
ADDRGP4 $247
JUMPV
LABELV $246
line 504
;503:			// count down health when over max
;504:			if ( ent->health > client->ps.stats[STAT_MAX_HEALTH] ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
LEI4 $256
line 505
;505:				ent->health--;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 506
;506:			}
LABELV $256
line 507
;507:		}
LABELV $247
line 511
;508:
;509:		// count down armor when over max
;510:		//if ( client->ps.stats[STAT_ARMOR] > client->ps.stats[STAT_MAX_HEALTH] ) {
;511:		if ( (client->ps.stats[STAT_ARMOR] > client->ps.stats[STAT_MAX_HEALTH]) && !g_pro_mode.integer ) { // CPM
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
LEI4 $258
ADDRGP4 g_pro_mode+12
INDIRI4
CNSTI4 0
NEI4 $258
line 512
;512:			client->ps.stats[STAT_ARMOR]--;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 513
;513:		}
LABELV $258
line 514
;514:	}
LABELV $244
line 458
ADDRLP4 0
INDIRP4
CNSTI4 10372
ADDP4
INDIRI4
CNSTI4 1000
GEI4 $243
line 553
;515:#ifdef MISSIONPACK
;516:	if( bg_itemlist[client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_AMMOREGEN ) {
;517:		int w, max, inc, t, i;
;518:    int weapList[]={WP_MACHINEGUN,WP_SHOTGUN,WP_GRENADE_LAUNCHER,WP_ROCKET_LAUNCHER,WP_LIGHTNING,WP_RAILGUN,WP_PLASMAGUN,WP_BFG,WP_NAILGUN,WP_PROX_LAUNCHER,WP_CHAINGUN};
;519:    int weapCount = sizeof(weapList) / sizeof(int);
;520:		//
;521:    for (i = 0; i < weapCount; i++) {
;522:		  w = weapList[i];
;523:
;524:		  switch(w) {
;525:			  case WP_MACHINEGUN: max = 50; inc = 4; t = 1000; break;
;526:			  case WP_SHOTGUN: max = 10; inc = 1; t = 1500; break;
;527:			  case WP_GRENADE_LAUNCHER: max = 10; inc = 1; t = 2000; break;
;528:			  case WP_ROCKET_LAUNCHER: max = 10; inc = 1; t = 1750; break;
;529:			  case WP_LIGHTNING: max = 50; inc = 5; t = 1500; break;
;530:			  case WP_RAILGUN: max = 10; inc = 1; t = 1750; break;
;531:			  case WP_PLASMAGUN: max = 50; inc = 5; t = 1500; break;
;532:			  case WP_BFG: max = 10; inc = 1; t = 4000; break;
;533:			  case WP_NAILGUN: max = 10; inc = 1; t = 1250; break;
;534:			  case WP_PROX_LAUNCHER: max = 5; inc = 1; t = 2000; break;
;535:			  case WP_CHAINGUN: max = 100; inc = 5; t = 1000; break;
;536:			  default: max = 0; inc = 0; t = 1000; break;
;537:		  }
;538:		  client->ammoTimes[w] += msec;
;539:		  if ( client->ps.ammo[w] >= max ) {
;540:			  client->ammoTimes[w] = 0;
;541:		  }
;542:		  if ( client->ammoTimes[w] >= t ) {
;543:			  while ( client->ammoTimes[w] >= t )
;544:				  client->ammoTimes[w] -= t;
;545:			  client->ps.ammo[w] += inc;
;546:			  if ( client->ps.ammo[w] > max ) {
;547:				  client->ps.ammo[w] = max;
;548:			  }
;549:		  }
;550:    }
;551:	}
;552:#endif
;553:}
LABELV $242
endproc ClientTimerActions 20 12
export ClientIntermissionThink
proc ClientIntermissionThink 24 0
line 560
;554:
;555:/*
;556:====================
;557:ClientIntermissionThink
;558:====================
;559:*/
;560:void ClientIntermissionThink( gclient_t *client ) {
line 561
;561:	client->ps.eFlags &= ~EF_TALK;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 -4097
BANDI4
ASGNI4
line 562
;562:	client->ps.eFlags &= ~EF_FIRING;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -257
BANDI4
ASGNI4
line 567
;563:
;564:	// the level will exit when everyone wants to or after timeouts
;565:
;566:	// swap and latch button actions
;567:	client->oldbuttons = client->buttons;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 10260
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 10256
ADDP4
INDIRI4
ASGNI4
line 568
;568:	client->buttons = client->pers.cmd.buttons;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 10256
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 488
ADDP4
INDIRI4
ASGNI4
line 569
;569:	if ( client->buttons & ( BUTTON_ATTACK | BUTTON_USE_HOLDABLE ) & ( client->oldbuttons ^ client->buttons ) ) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 16
INDIRP4
CNSTI4 10256
ADDP4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 5
BANDI4
ADDRLP4 16
INDIRP4
CNSTI4 10260
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
BXORI4
BANDI4
CNSTI4 0
EQI4 $262
line 571
;570:		// this used to be an ^1 but once a player says ready, it should stick
;571:		client->playerReady = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 10236
ADDP4
CNSTI4 1
ASGNI4
line 572
;572:	}
LABELV $262
line 573
;573:}
LABELV $261
endproc ClientIntermissionThink 24 0
export ClientEvents
proc ClientEvents 96 32
line 584
;574:
;575:
;576:/*
;577:================
;578:ClientEvents
;579:
;580:Events will be passed on to the clients for presentation,
;581:but any server game effects are handled here
;582:================
;583:*/
;584:void ClientEvents( gentity_t *ent, int oldEventSequence ) {
line 587
;585:	int		i, j;
;586:	int		event;
;587:	int		eventParm = 0;
ADDRLP4 32
CNSTI4 0
ASGNI4
line 597
;588:	gclient_t *client;
;589:	int		damage;
;590:	vec3_t	dir;
;591:	vec3_t	origin, angles;
;592:	gitem_t *item;
;593:	gentity_t *drop;
;594:
;595:	
;596:
;597:	client = ent->client;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 599
;598:
;599:	if ( oldEventSequence < client->ps.eventSequence - MAX_PS_EVENTS ) {
ADDRFP4 4
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 2
SUBI4
GEI4 $265
line 600
;600:		oldEventSequence = client->ps.eventSequence - MAX_PS_EVENTS;
ADDRFP4 4
ADDRLP4 8
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 601
;601:	}
LABELV $265
line 602
;602:	for ( i = oldEventSequence ; i < client->ps.eventSequence ; i++ ) {
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
ADDRGP4 $270
JUMPV
LABELV $267
line 603
;603:		event = client->ps.events[ i & (MAX_PS_EVENTS-1) ];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 112
ADDP4
ADDP4
INDIRI4
ASGNI4
line 605
;604:
;605:		switch ( event ) {
ADDRLP4 4
INDIRI4
CNSTI4 23
EQI4 $291
ADDRLP4 4
INDIRI4
CNSTI4 25
EQI4 $292
ADDRLP4 72
CNSTI4 26
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 72
INDIRI4
EQI4 $304
ADDRLP4 4
INDIRI4
ADDRLP4 72
INDIRI4
GTI4 $306
LABELV $305
ADDRLP4 4
INDIRI4
CNSTI4 11
EQI4 $273
ADDRLP4 4
INDIRI4
CNSTI4 12
EQI4 $273
ADDRGP4 $272
JUMPV
LABELV $306
ADDRLP4 4
INDIRI4
CNSTI4 83
EQI4 $287
ADDRGP4 $272
JUMPV
LABELV $273
line 609
;606:		case EV_FALL_MEDIUM:
;607:		case EV_FALL_FAR:
;608:		//case EV_FALL_ADV:
;609:			if ( g_FallingDamage.integer == 0 ) {
ADDRGP4 g_FallingDamage+12
INDIRI4
CNSTI4 0
NEI4 $274
line 610
;610:				break;
ADDRGP4 $272
JUMPV
LABELV $274
line 612
;611:			}
;612:			if ( ent->s.eType != ET_PLAYER ) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 1
EQI4 $277
line 613
;613:				break;		// not in the player model
ADDRGP4 $272
JUMPV
LABELV $277
line 615
;614:			}
;615:			if ( g_dmflags.integer & DF_NO_FALLING ) {
ADDRGP4 g_dmflags+12
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $279
line 616
;616:				break;
ADDRGP4 $272
JUMPV
LABELV $279
line 619
;617:			}
;618:
;619:			if ( event == EV_FALL_FAR ) {
ADDRLP4 4
INDIRI4
CNSTI4 12
NEI4 $282
line 620
;620:				damage = 10;
ADDRLP4 36
CNSTI4 10
ASGNI4
line 621
;621:			} else {
ADDRGP4 $283
JUMPV
LABELV $282
line 622
;622:				damage = 5;
ADDRLP4 36
CNSTI4 5
ASGNI4
line 623
;623:			}	
LABELV $283
line 625
;624:			
;625:			VectorSet (dir, 0, 0, 1);
ADDRLP4 80
CNSTF4 0
ASGNF4
ADDRLP4 16
ADDRLP4 80
INDIRF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 80
INDIRF4
ASGNF4
ADDRLP4 16+8
CNSTF4 1065353216
ASGNF4
line 626
;626:			ent->pain_debounce_time = level.time + 200;	// no normal pain sound
ADDRFP4 0
INDIRP4
CNSTI4 720
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 627
;627:			G_Damage (ent, NULL, NULL, NULL, NULL, damage, 0, MOD_FALLING);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 84
CNSTP4 0
ASGNP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRLP4 88
CNSTP4 0
ASGNP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 36
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 19
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 628
;628:			break;
ADDRGP4 $272
JUMPV
LABELV $287
line 632
;629:
;630:		//monkk:offhand grapple
;631:		case EV_FIRE_GRAPPLE:
;632:			if( weap_enableHook.integer == 1 ) {
ADDRGP4 weap_enableHook+12
INDIRI4
CNSTI4 1
NEI4 $272
line 633
;633:				FireWeaponGrapple( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 FireWeaponGrapple
CALLV
pop
line 634
;634:			}
line 635
;635:			break;
ADDRGP4 $272
JUMPV
LABELV $291
line 641
;636:
;637:		case EV_FIRE_WEAPON:
;638:			//trap_SendServerCommand( ent->client->ps.clientNum, va("print \"DBGRWS:Entered EV_FIRE_WEAPON -- %i\n\"", level.time) );
;639:
;640:			//trap_SendServerCommand( ent->client->ps.clientNum, va("print \"DBGRWS:event: %i, eventParm: %i\n\"", event, eventParm) );
;641:			FireWeapon( ent, eventParm );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 32
INDIRI4
ARGI4
ADDRGP4 FireWeapon
CALLV
pop
line 642
;642:			break;
ADDRGP4 $272
JUMPV
LABELV $292
line 646
;643:
;644:		case EV_USE_ITEM1:		// teleporter
;645:			// drop flags in CTF
;646:			item = NULL;
ADDRLP4 12
CNSTP4 0
ASGNP4
line 647
;647:			j = 0;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 649
;648:
;649:			if ( ent->client->ps.powerups[ PW_REDFLAG ] ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
EQI4 $293
line 650
;650:				item = BG_FindItemForPowerup( PW_REDFLAG );
CNSTI4 7
ARGI4
ADDRLP4 92
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 92
INDIRP4
ASGNP4
line 651
;651:				j = PW_REDFLAG;
ADDRLP4 28
CNSTI4 7
ASGNI4
line 652
;652:			} else if ( ent->client->ps.powerups[ PW_BLUEFLAG ] ) {
ADDRGP4 $294
JUMPV
LABELV $293
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $295
line 653
;653:				item = BG_FindItemForPowerup( PW_BLUEFLAG );
CNSTI4 8
ARGI4
ADDRLP4 92
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 92
INDIRP4
ASGNP4
line 654
;654:				j = PW_BLUEFLAG;
ADDRLP4 28
CNSTI4 8
ASGNI4
line 655
;655:			} else if ( ent->client->ps.powerups[ PW_NEUTRALFLAG ] ) {
ADDRGP4 $296
JUMPV
LABELV $295
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $297
line 656
;656:				item = BG_FindItemForPowerup( PW_NEUTRALFLAG );
CNSTI4 9
ARGI4
ADDRLP4 92
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 92
INDIRP4
ASGNP4
line 657
;657:				j = PW_NEUTRALFLAG;
ADDRLP4 28
CNSTI4 9
ASGNI4
line 658
;658:			}
LABELV $297
LABELV $296
LABELV $294
line 660
;659:
;660:			if ( item ) {
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $299
line 661
;661:				drop = Drop_Item( ent, item, 0, qfalse );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 92
ADDRGP4 Drop_Item
CALLP4
ASGNP4
ADDRLP4 64
ADDRLP4 92
INDIRP4
ASGNP4
line 663
;662:				// decide how many seconds it has left
;663:				drop->count = ( ent->client->ps.powerups[ j ] - level.time ) / 1000;
ADDRLP4 64
INDIRP4
CNSTI4 760
ADDP4
ADDRLP4 28
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
line 664
;664:				if ( drop->count < 1 ) {
ADDRLP4 64
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 1
GEI4 $302
line 665
;665:					drop->count = 1;
ADDRLP4 64
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 1
ASGNI4
line 666
;666:				}
LABELV $302
line 668
;667:
;668:				ent->client->ps.powerups[ j ] = 0;
ADDRLP4 28
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
CNSTI4 0
ASGNI4
line 669
;669:			}
LABELV $299
line 693
;670:
;671:#ifdef MISSIONPACK
;672:			if ( g_gametype.integer == GT_HARVESTER ) {
;673:				if ( ent->client->ps.generic1 > 0 ) {
;674:					if ( ent->client->sess.sessionTeam == TEAM_RED ) {
;675:						item = BG_FindItem( "Blue Cube" );
;676:					} else {
;677:						item = BG_FindItem( "Red Cube" );
;678:					}
;679:					if ( item ) {
;680:						for ( j = 0; j < ent->client->ps.generic1; j++ ) {
;681:							drop = Drop_Item( ent, item, 0, qfalse );
;682:							if ( ent->client->sess.sessionTeam == TEAM_RED ) {
;683:								drop->spawnflags = TEAM_BLUE;
;684:							} else {
;685:								drop->spawnflags = TEAM_RED;
;686:							}
;687:						}
;688:					}
;689:					ent->client->ps.generic1 = 0;
;690:				}
;691:			}
;692:#endif
;693:			SelectSpawnPoint( ent->client->ps.origin, origin, angles );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 40
ARGP4
ADDRLP4 52
ARGP4
ADDRGP4 SelectSpawnPoint
CALLP4
pop
line 694
;694:			TeleportPlayer( ent, origin, angles, qtrue );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
ARGP4
ADDRLP4 52
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 TeleportPlayer
CALLV
pop
line 695
;695:			break;
ADDRGP4 $272
JUMPV
LABELV $304
line 698
;696:
;697:		case EV_USE_ITEM2:		// medkit
;698:			ent->health = ent->client->ps.stats[STAT_MAX_HEALTH] + 25;
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 92
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 25
ADDI4
ASGNI4
line 700
;699:
;700:			break;
line 724
;701:
;702:#ifdef MISSIONPACK
;703:		case EV_USE_ITEM3:		// kamikaze
;704:			// make sure the invulnerability is off
;705:			ent->client->invulnerabilityTime = 0;
;706:			// start the kamikze
;707:			G_StartKamikaze( ent );
;708:			break;
;709:
;710:		case EV_USE_ITEM4:		// portal
;711:			if( ent->client->portalID ) {
;712:				DropPortalSource( ent );
;713:			}
;714:			else {
;715:				DropPortalDestination( ent );
;716:			}
;717:			break;
;718:		case EV_USE_ITEM5:		// invulnerability
;719:			ent->client->invulnerabilityTime = level.time + 10000;
;720:			break;
;721:#endif
;722:
;723:		default:
;724:			break;
LABELV $272
line 726
;725:		}
;726:	}
LABELV $268
line 602
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $270
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
LTI4 $267
line 738
;727:
;728:	//if ( !wait && ent->client->pers.last_Event == EV_FIRE_WEAPON && (
;729:	//	ent->s.weapon == WP_GAUNTLET || ent->s.weapon == WP_MACHINEGUN ||
;730:	//	ent->s.weapon == WP_SHOTGUN || ent->s.weapon == WP_RAILGUN )) {
;731:		//	G_Printf("We should've waited, do hitscan\n");
;732:	//		ent->client->pers.last_Event = -1;
;733:	//		FireWeapon( ent );
;734:	//}
;735:
;736:	//ent->client->pers.wait = qfalse;
;737:
;738:}
LABELV $264
endproc ClientEvents 96 32
export SendPendingPredictableEvents
proc SendPendingPredictableEvents 44 12
line 790
;739:
;740:#ifdef MISSIONPACK
;741:/*
;742:==============
;743:StuckInOtherClient
;744:==============
;745:*/
;746:static int StuckInOtherClient(gentity_t *ent) {
;747:	int i;
;748:	gentity_t	*ent2;
;749:
;750:	ent2 = &g_entities[0];
;751:	for ( i = 0; i < MAX_CLIENTS; i++, ent2++ ) {
;752:		if ( ent2 == ent ) {
;753:			continue;
;754:		}
;755:		if ( !ent2->inuse ) {
;756:			continue;
;757:		}
;758:		if ( !ent2->client ) {
;759:			continue;
;760:		}
;761:		if ( ent2->health <= 0 ) {
;762:			continue;
;763:		}
;764:		//
;765:		if (ent2->r.absmin[0] > ent->r.absmax[0])
;766:			continue;
;767:		if (ent2->r.absmin[1] > ent->r.absmax[1])
;768:			continue;
;769:		if (ent2->r.absmin[2] > ent->r.absmax[2])
;770:			continue;
;771:		if (ent2->r.absmax[0] < ent->r.absmin[0])
;772:			continue;
;773:		if (ent2->r.absmax[1] < ent->r.absmin[1])
;774:			continue;
;775:		if (ent2->r.absmax[2] < ent->r.absmin[2])
;776:			continue;
;777:		return qtrue;
;778:	}
;779:	return qfalse;
;780:}
;781:#endif
;782:
;783:void BotTestSolid(vec3_t origin);
;784:
;785:/*
;786:==============
;787:SendPendingPredictableEvents
;788:==============
;789:*/
;790:void SendPendingPredictableEvents( playerState_t *ps ) {
line 796
;791:	gentity_t *t;
;792:	int event, seq;
;793:	int extEvent, number;
;794:
;795:	// if there are still events pending
;796:	if ( ps->entityEventSequence < ps->eventSequence ) {
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 464
ADDP4
INDIRI4
ADDRLP4 20
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
GEI4 $308
line 799
;797:		// create a temporary entity for this event which is sent to everyone
;798:		// except the client who generated the event
;799:		seq = ps->entityEventSequence & (MAX_PS_EVENTS-1);
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 464
ADDP4
INDIRI4
CNSTI4 1
BANDI4
ASGNI4
line 800
;800:		event = ps->events[ seq ] | ( ( ps->entityEventSequence & 3 ) << 8 );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 24
INDIRP4
CNSTI4 112
ADDP4
ADDP4
INDIRI4
ADDRLP4 24
INDIRP4
CNSTI4 464
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 8
LSHI4
BORI4
ASGNI4
line 802
;801:		// set external event to zero before calling BG_PlayerStateToEntityState
;802:		extEvent = ps->externalEvent;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
INDIRI4
ASGNI4
line 803
;803:		ps->externalEvent = 0;
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
CNSTI4 0
ASGNI4
line 805
;804:		// create temporary entity for event
;805:		t = G_TempEntity( ps->origin, event );
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
line 806
;806:		number = t->s.number;
ADDRLP4 16
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 807
;807:		BG_PlayerStateToEntityState( ps, &t->s, qtrue );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 808
;808:		t->s.number = number;
ADDRLP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ASGNI4
line 809
;809:		t->s.eType = ET_EVENTS + event;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 13
ADDI4
ASGNI4
line 810
;810:		t->s.eFlags |= EF_PLAYER_EVENT;
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 811
;811:		t->s.otherEntityNum = ps->clientNum;
ADDRLP4 36
CNSTI4 140
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
INDIRI4
ASGNI4
line 813
;812:		// send to everyone except the client who generated the event
;813:		t->r.svFlags |= SVF_NOTSINGLECLIENT;
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 814
;814:		t->r.singleClient = ps->clientNum;
ADDRLP4 0
INDIRP4
CNSTI4 428
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 816
;815:		// set back external event
;816:		ps->externalEvent = extEvent;
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 817
;817:	}
LABELV $308
line 818
;818:}
LABELV $307
endproc SendPendingPredictableEvents 44 12
export ClientThink_real
proc ClientThink_real 1348 16
line 833
;819:
;820:/*
;821:==============
;822:ClientThink
;823:
;824:This will be called once for each client frame, which will
;825:usually be a couple times for each server frame on fast clients.
;826:
;827:If "g_synchronousClients 1" is set, this will be called exactly
;828:once for each server frame, which makes for smooth demo recording.
;829:==============
;830:*/
;831://monkk:?performance?
;832:#define SAC_UPDATE_DISTANCE 100
;833:void ClientThink_real( gentity_t *ent, int forced ) {
line 841
;834:	gclient_t	*client;
;835:	pmove_t		pm;
;836:	int			oldEventSequence;
;837:	int			msec;
;838:	usercmd_t	*ucmd;
;839:	vec3_t		v;
;840://	char		buffer[65];
;841:	int			shifted = 0;
ADDRLP4 272
CNSTI4 0
ASGNI4
line 844
;842://	int			team;
;843:
;844:	client = ent->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 847
;845:
;846:	// don't think if the client is not yet connected (and thus not yet spawned in)
;847:	if (client->pers.connected != CON_CONNECTED) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $311
line 848
;848:		return;
ADDRGP4 $310
JUMPV
LABELV $311
line 885
;849:	}
;850:
;851:	/*
;852:	if (client->sess.sessionTeam == TEAM_WARMUP && g_gametype.integer != GT_TOURNAMENT)
;853:	{
;854:		SetTeamInt(ent, PickTeam( -1 ));
;855:	}
;856:
;857:	if (g_gametype.integer >= GT_TEAM)
;858:	{
;859:		if (client->sess.sessionTeam == TEAM_FREE)
;860:		{
;861:			SetTeamInt(ent, PickTeam( -1 ));
;862:		}
;863:	}
;864:	else
;865:	{
;866:		if (client->sess.sessionTeam == TEAM_RED || client->sess.sessionTeam == TEAM_BLUE)
;867:		{
;868:			SetTeamInt(ent, PickTeam( -1 ));
;869:		}
;870:
;871:	}
;872:	*/
;873:
;874:	/*
;875:	// Causes clients to flicker when they have packet loss...
;876:	// commenting out until I get around to finding a way around that issue.
;877:	if (ent)
;878:	{
;879:		ent->r.svFlags &= (~SVF_CLIENTMASK);
;880:	}
;881:	*/
;882:
;883:
;884:	// mark the time, so the connection sprite can be removed
;885:	ucmd = &ent->client->pers.cmd;
ADDRLP4 248
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 472
ADDP4
ASGNP4
line 898
;886:
;887:	//Save the target clientNum and set the weapon we're switching to.
;888:	//ent->client->pers.targ_clientNum = (int)ucmd->weapon;
;889:	//ucmd->weapon |= ent->client->pers.weapon;
;890:	
;891:	/*if ( ent->client->pers.dbgrws && ent->client->hitClient >= 1 ) {
;892:			trap_SendServerCommand( ent-g_entities, va("print \"DBGRWS: Client Firing, claiming hit. Raw: %i at %i\n\"", ucmd->weapon, ucmd->serverTime) );
;893:	}*/
;894:
;895:
;896:	//ucmd->weapon = WEAPON_MASK(ucmd->weapon);
;897:
;898:	if ( gameSettings.ping_fix == 2 ) {
ADDRGP4 gameSettings+4
INDIRI4
CNSTI4 2
NEI4 $313
line 900
;899:		char *s, userinfo[MAX_INFO_STRING];
;900:		int ping = 0, i = 0, oldPing = 0;
ADDRLP4 276
CNSTI4 0
ASGNI4
ADDRLP4 280
CNSTI4 0
ASGNI4
ADDRLP4 284
CNSTI4 0
ASGNI4
line 902
;901:
;902:		trap_GetUserinfo( ent-g_entities, userinfo, sizeof(userinfo) );
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
ADDRLP4 288
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 903
;903:		s = Info_ValueForKey( userinfo, "com_maxfps" );//Get /com_maxfps
ADDRLP4 288
ARGP4
ADDRGP4 $316
ARGP4
ADDRLP4 1316
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1312
ADDRLP4 1316
INDIRP4
ASGNP4
line 904
;904:		i = atoi(s);
ADDRLP4 1312
INDIRP4
ARGP4
ADDRLP4 1320
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 280
ADDRLP4 1320
INDIRI4
ASGNI4
line 906
;905:
;906:		i = (1000 / i);
ADDRLP4 280
CNSTI4 1000
ADDRLP4 280
INDIRI4
DIVI4
ASGNI4
line 907
;907:		oldPing = (client->pers.pingsamples[client->pers.samplehead==0?(NUM_PING_SAMPLES-1):(client->pers.samplehead-1)] + 20);
ADDRLP4 0
INDIRP4
CNSTI4 10148
ADDP4
INDIRI4
CNSTI4 0
NEI4 $318
ADDRLP4 1324
CNSTI4 15
ASGNI4
ADDRGP4 $319
JUMPV
LABELV $318
ADDRLP4 1324
ADDRLP4 0
INDIRP4
CNSTI4 10148
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $319
ADDRLP4 284
ADDRLP4 1324
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 10076
ADDP4
ADDP4
INDIRI4
CNSTI4 20
ADDI4
ASGNI4
line 908
;908:		ping = level.previousTime + client->frameOffset - ucmd->serverTime;
ADDRLP4 276
ADDRGP4 level+44
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 10808
ADDP4
INDIRI4
ADDI4
ADDRLP4 248
INDIRP4
INDIRI4
SUBI4
ASGNI4
line 909
;909:		ping -= i;
ADDRLP4 276
ADDRLP4 276
INDIRI4
ADDRLP4 280
INDIRI4
SUBI4
ASGNI4
line 912
;910:
;911:		//if we weren't recording before, or the current ping isn't 20ms spike or more than the last, but record it if the pingspare was comparable to it.
;912:		if ( ping >= 0 && (!client->pers.pingsamples[0] || ((ping <= oldPing) && (ping <= client->pers.pingspare))) ) {
ADDRLP4 1332
CNSTI4 0
ASGNI4
ADDRLP4 276
INDIRI4
ADDRLP4 1332
INDIRI4
LTI4 $321
ADDRLP4 0
INDIRP4
CNSTI4 10076
ADDP4
INDIRI4
ADDRLP4 1332
INDIRI4
EQI4 $323
ADDRLP4 276
INDIRI4
ADDRLP4 284
INDIRI4
GTI4 $321
ADDRLP4 276
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 10140
ADDP4
INDIRI4
GTI4 $321
LABELV $323
line 913
;913:			client->pers.pingsamples[client->pers.samplehead] = ping;
ADDRLP4 0
INDIRP4
CNSTI4 10148
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 10076
ADDP4
ADDP4
ADDRLP4 276
INDIRI4
ASGNI4
line 914
;914:			client->pers.samplehead++;
ADDRLP4 1344
ADDRLP4 0
INDIRP4
CNSTI4 10148
ADDP4
ASGNP4
ADDRLP4 1344
INDIRP4
ADDRLP4 1344
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 915
;915:			if ( client->pers.samplehead >= NUM_PING_SAMPLES ) {
ADDRLP4 0
INDIRP4
CNSTI4 10148
ADDP4
INDIRI4
CNSTI4 16
LTI4 $324
line 916
;916:				client->pers.samplehead = 0;
ADDRLP4 0
INDIRP4
CNSTI4 10148
ADDP4
CNSTI4 0
ASGNI4
line 917
;917:			}
LABELV $324
line 918
;918:		} 
LABELV $321
line 919
;919:		client->pers.pingspare = ping + 20;
ADDRLP4 0
INDIRP4
CNSTI4 10140
ADDP4
ADDRLP4 276
INDIRI4
CNSTI4 20
ADDI4
ASGNI4
line 920
;920:	}
LABELV $313
line 923
;921:
;922:	// sanity check the command time to prevent speedup cheating
;923:	if ( ucmd->serverTime > level.time + 200 ) {
ADDRLP4 248
INDIRP4
INDIRI4
ADDRGP4 level+40
INDIRI4
CNSTI4 200
ADDI4
LEI4 $326
line 924
;924:		ucmd->serverTime = level.time + 200;
ADDRLP4 248
INDIRP4
ADDRGP4 level+40
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 926
;925://		G_Printf("serverTime <<<<<\n" );
;926:	}
LABELV $326
line 927
;927:	if ( ucmd->serverTime < level.time - 1000 ) {
ADDRLP4 248
INDIRP4
INDIRI4
ADDRGP4 level+40
INDIRI4
CNSTI4 1000
SUBI4
GEI4 $330
line 928
;928:		ucmd->serverTime = level.time - 1000;
ADDRLP4 248
INDIRP4
ADDRGP4 level+40
INDIRI4
CNSTI4 1000
SUBI4
ASGNI4
line 930
;929://		G_Printf("serverTime >>>>>\n" );
;930:	} 
LABELV $330
line 935
;931:
;932:	//unlagged - smooth clients #1
;933:	// keep track of this for later - we'll use this to decide whether or not
;934:	// to send extrapolated positions for this client
;935:	if (!forced || g_smoothClients.integer == 2 ) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $337
ADDRGP4 g_smoothClients+12
INDIRI4
CNSTI4 2
NEI4 $334
LABELV $337
line 936
;936:		ent->client->lastUpdateFrame = level.framenum;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10812
ADDP4
ADDRGP4 level+36
INDIRI4
ASGNI4
line 937
;937:	}
LABELV $334
line 945
;938:	//unlagged - smooth clients #1
;939:
;940:
;941://unlagged - backward reconciliation #4
;942:	// frameOffset should be about the number of milliseconds into a frame 
;943:	// this command packet was received, depending on how fast the server
;944:	// does a G_RunFrame()
;945:	client->frameOffset = trap_Milliseconds() - level.frameStartTime;
ADDRLP4 276
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 10808
ADDP4
ADDRLP4 276
INDIRI4
ADDRGP4 level+9260
INDIRI4
SUBI4
ASGNI4
line 950
;946:
;947:	// save the command time *before* pmove_fixed messes with the serverTime,
;948:	// and *after* lag simulation messes with it :)
;949:	// attackTime will be used for backward reconciliation later (time shift)
;950:	client->attackTime = ucmd->serverTime;
ADDRLP4 0
INDIRP4
CNSTI4 10400
ADDP4
ADDRLP4 248
INDIRP4
INDIRI4
ASGNI4
line 953
;951://unlagged - backward reconciliation #4
;952:
;953:	msec = ucmd->serverTime - client->ps.commandTime;
ADDRLP4 252
ADDRLP4 248
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
SUBI4
ASGNI4
line 956
;954:	// following others may result in bad times, but we still want
;955:	// to check for follow toggles
;956:	if ( msec < 1 && client->sess.spectatorState != SPECTATOR_FOLLOW ) {
ADDRLP4 252
INDIRI4
CNSTI4 1
GEI4 $340
ADDRLP4 0
INDIRP4
CNSTI4 10196
ADDP4
INDIRI4
CNSTI4 2
EQI4 $340
line 957
;957:		return;
ADDRGP4 $310
JUMPV
LABELV $340
line 959
;958:	}
;959:	if ( msec > 200 ) {
ADDRLP4 252
INDIRI4
CNSTI4 200
LEI4 $342
line 960
;960:		msec = 200;
ADDRLP4 252
CNSTI4 200
ASGNI4
line 961
;961:	}
LABELV $342
line 963
;962:
;963:	if ( pmove_msec.integer < 8 ) {
ADDRGP4 pmove_msec+12
INDIRI4
CNSTI4 8
GEI4 $344
line 964
;964:		trap_Cvar_Set("pmove_msec", "8");
ADDRGP4 $347
ARGP4
ADDRGP4 $348
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 965
;965:	}
ADDRGP4 $345
JUMPV
LABELV $344
line 966
;966:	else if (pmove_msec.integer > 33) {
ADDRGP4 pmove_msec+12
INDIRI4
CNSTI4 33
LEI4 $349
line 967
;967:		trap_Cvar_Set("pmove_msec", "33");
ADDRGP4 $347
ARGP4
ADDRGP4 $352
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 968
;968:	}
LABELV $349
LABELV $345
line 970
;969:
;970:	if ( (pmove_fixed.integer && sv_lock_pmove.integer) || client->pers.pmoveFixed ) {
ADDRLP4 280
CNSTI4 0
ASGNI4
ADDRGP4 pmove_fixed+12
INDIRI4
ADDRLP4 280
INDIRI4
EQI4 $358
ADDRGP4 sv_lock_pmove+12
INDIRI4
ADDRLP4 280
INDIRI4
NEI4 $357
LABELV $358
ADDRLP4 0
INDIRP4
CNSTI4 508
ADDP4
INDIRI4
CNSTI4 0
EQI4 $353
LABELV $357
line 971
;971:		ucmd->serverTime = ((ucmd->serverTime + pmove_msec.integer-1) / pmove_msec.integer) * pmove_msec.integer;
ADDRLP4 248
INDIRP4
ADDRLP4 248
INDIRP4
INDIRI4
ADDRGP4 pmove_msec+12
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ADDRGP4 pmove_msec+12
INDIRI4
DIVI4
ADDRGP4 pmove_msec+12
INDIRI4
MULI4
ASGNI4
line 974
;972:		//if (ucmd->serverTime - client->ps.commandTime <= 0)
;973:		//	return;
;974:	}
LABELV $353
line 979
;975:
;976:	//
;977:	// check for exiting intermission
;978:	//
;979:	if ( level.intermissiontime ) {
ADDRGP4 level+9160
INDIRI4
CNSTI4 0
EQI4 $362
line 980
;980:		ClientIntermissionThink( client );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 ClientIntermissionThink
CALLV
pop
line 981
;981:		return;
ADDRGP4 $310
JUMPV
LABELV $362
line 988
;982:	}
;983:
;984:	// spectators don't do much
;985:/*freeze
;986:	if ( client->sess.sessionTeam == TEAM_SPECTATOR ) {
;987:freeze*/
;988:	if ( (g_gamemode.integer > 3 && is_spectator( client )) || (g_gamemode.integer < 4 && client->sess.sessionTeam == TEAM_SPECTATOR) ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $370
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 284
ADDRGP4 is_spectator
CALLI4
ASGNI4
ADDRLP4 284
INDIRI4
CNSTI4 0
NEI4 $369
LABELV $370
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 4
GEI4 $365
ADDRLP4 0
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
CNSTI4 3
NEI4 $365
LABELV $369
line 990
;989://freeze
;990:		if ( client->sess.spectatorState == SPECTATOR_SCOREBOARD ) {
ADDRLP4 0
INDIRP4
CNSTI4 10196
ADDP4
INDIRI4
CNSTI4 3
NEI4 $371
line 991
;991:			return;
ADDRGP4 $310
JUMPV
LABELV $371
line 993
;992:		}
;993:		SpectatorThink( ent, ucmd );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 248
INDIRP4
ARGP4
ADDRGP4 SpectatorThink
CALLV
pop
line 994
;994:		return;
ADDRGP4 $310
JUMPV
LABELV $365
line 998
;995:	}
;996:
;997:	// check for inactivity timer, but never drop the local client of a non-dedicated server
;998:	if ( !ClientInactivityTimer( client ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 288
ADDRGP4 ClientInactivityTimer
CALLI4
ASGNI4
ADDRLP4 288
INDIRI4
CNSTI4 0
NEI4 $373
line 999
;999:		return;
ADDRGP4 $310
JUMPV
LABELV $373
line 1002
;1000:	}
;1001:
;1002:	if ( level.match_timeout == 1 && level.time >= level.match_timein && level.match_time != -1 ) {
ADDRGP4 level+10800
INDIRU1
CVUI4 1
CNSTI4 1
NEI4 $375
ADDRGP4 level+40
INDIRI4
ADDRGP4 level+10804
INDIRI4
LTI4 $375
ADDRGP4 level+10832
INDIRI4
CNSTI4 -1
EQI4 $375
line 1003
;1003:		trap_SendServerCommand( -1, va("cp \"\""));
ADDRGP4 $381
ARGP4
ADDRLP4 292
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 292
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1004
;1004:		level.match_timeout = 0;
ADDRGP4 level+10800
CNSTU1 0
ASGNU1
line 1005
;1005:	} else if ( level.match_timeout == 1 && level.time >= level.match_interval ) { 
ADDRGP4 $376
JUMPV
LABELV $375
ADDRGP4 level+10800
INDIRU1
CVUI4 1
CNSTI4 1
NEI4 $383
ADDRGP4 level+40
INDIRI4
ADDRGP4 level+10808
INDIRI4
LTI4 $383
line 1007
;1006:		int pausesec; 
;1007:		level.match_interval = level.time + 1000;
ADDRGP4 level+10808
ADDRGP4 level+40
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 1008
;1008:		pausesec = (level.match_timein - level.time) / 1000;
ADDRLP4 292
ADDRGP4 level+10804
INDIRI4
ADDRGP4 level+40
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
ASGNI4
line 1009
;1009:		if (level.match_time != -1) {
ADDRGP4 level+10832
INDIRI4
CNSTI4 -1
EQI4 $392
line 1010
;1010:			trap_SendServerCommand( -1, va("cp \"Time out! %i seconds remaining\n\"", pausesec));
ADDRGP4 $395
ARGP4
ADDRLP4 292
INDIRI4
ARGI4
ADDRLP4 296
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 296
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1011
;1011:			if ( g_timelimit.integer ) {
ADDRGP4 g_timelimit+12
INDIRI4
CNSTI4 0
EQI4 $393
line 1013
;1012:				//We have a timelimit, "fake" a later startTime to adjust end time.
;1013:				level.startTime += 1000;
ADDRLP4 300
ADDRGP4 level+48
ASGNP4
ADDRLP4 300
INDIRP4
ADDRLP4 300
INDIRP4
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 1014
;1014:			}
line 1015
;1015:		} else {
ADDRGP4 $393
JUMPV
LABELV $392
line 1016
;1016:			trap_SendServerCommand( -1, va("cp \"Time out!\n\""));
ADDRGP4 $400
ARGP4
ADDRLP4 296
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 296
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1017
;1017:			if ( g_timelimit.integer ) {
ADDRGP4 g_timelimit+12
INDIRI4
CNSTI4 0
EQI4 $401
line 1019
;1018:				//We have a timelimit, "fake" a later startTime to adjust end time.
;1019:				level.startTime += 1000;
ADDRLP4 300
ADDRGP4 level+48
ASGNP4
ADDRLP4 300
INDIRP4
ADDRLP4 300
INDIRP4
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 1020
;1020:			}
LABELV $401
line 1021
;1021:		}
LABELV $393
line 1022
;1022:	}  
LABELV $383
LABELV $376
line 1025
;1023:	//UpdatePlayerLastKnownGood - Monkk added for flag sacrifice
;1024:	if ( //player is alive and has the flag, or in air
;1025:		g_flagSacrifice.integer != 0 &&
ADDRLP4 292
CNSTI4 0
ASGNI4
ADDRGP4 g_flagSacrifice+12
INDIRI4
ADDRLP4 292
INDIRI4
EQI4 $405
ADDRLP4 296
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 300
ADDRLP4 296
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ASGNI4
ADDRLP4 300
INDIRI4
CNSTI4 1023
EQI4 $405
ADDRLP4 296
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ADDRLP4 292
INDIRI4
LEI4 $405
CNSTI4 896
ADDRLP4 300
INDIRI4
MULI4
ADDRGP4 g_entities+524
ADDP4
INDIRP4
ARGP4
ADDRLP4 304
ADDRGP4 ClassnameIsMover
CALLI4
ASGNI4
ADDRLP4 304
INDIRI4
CNSTI4 0
NEI4 $405
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 308
ADDRGP4 PlayerHasFlagPowerup
CALLI4
ASGNI4
ADDRLP4 308
INDIRI4
CNSTI4 0
EQI4 $405
line 1031
;1026:		(ent->client->ps.groundEntityNum != ENTITYNUM_NONE)								&&
;1027:		(ent->health > 0)																&& 
;1028:		(! ClassnameIsMover((&g_entities[ent->client->ps.groundEntityNum])->classname)) &&
;1029:		PlayerHasFlagPowerup(ent, -1)
;1030:		)
;1031:	{ 
line 1032
;1032:		VectorCopy(ent->r.currentOrigin, v);
ADDRLP4 256
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 1033
;1033:		VectorSubtract(v, level.playerLastKnownGood[ent - g_entities][0], v);
ADDRLP4 312
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
ASGNI4
ADDRLP4 256
ADDRLP4 256
INDIRF4
ADDRLP4 312
INDIRI4
ADDRGP4 level+9264
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 256+4
ADDRLP4 256+4
INDIRF4
ADDRLP4 312
INDIRI4
ADDRGP4 level+9264+4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 256+8
ADDRLP4 256+8
INDIRF4
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
ADDRGP4 level+9264+8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1034
;1034:		if( VectorLength(v) >= SAC_UPDATE_DISTANCE ) { 
ADDRLP4 256
ARGP4
ADDRLP4 316
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 316
INDIRF4
CNSTF4 1120403456
LTF4 $418
line 1036
;1035:			//100 units away and not in air
;1036:			int contents = trap_PointContents( ent->r.currentOrigin, -1 );
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 328
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 320
ADDRLP4 328
INDIRI4
ASGNI4
line 1037
;1037:			int touchingNoDrop = ( 
ADDRLP4 320
INDIRI4
CVIU4 4
CNSTU4 2147483672
BANDU4
CNSTU4 0
NEU4 $423
ADDRFP4 0
INDIRP4
CNSTI4 784
ADDP4
INDIRI4
CNSTI4 24
BANDI4
CNSTI4 0
EQI4 $421
LABELV $423
ADDRLP4 332
CNSTI4 1
ASGNI4
ADDRGP4 $422
JUMPV
LABELV $421
ADDRLP4 332
CNSTI4 0
ASGNI4
LABELV $422
ADDRLP4 324
ADDRLP4 332
INDIRI4
ASGNI4
line 1042
;1038:				(contents & (CONTENTS_NODROP | CONTENTS_LAVA | CONTENTS_SLIME) ) ||
;1039:				(ent->watertype & (CONTENTS_LAVA | CONTENTS_SLIME) )
;1040:			);
;1041:
;1042:			if ( ! touchingNoDrop ) { 
ADDRLP4 324
INDIRI4
CNSTI4 0
NEI4 $424
line 1044
;1043:				//it's not on a mover and it's not in a "flag sarcifice zone"
;1044:				VectorCopy(level.playerLastKnownGood[ent - g_entities][0], level.playerLastKnownGood[ent - g_entities][1]);
ADDRLP4 336
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
ASGNI4
ADDRLP4 336
INDIRI4
ADDRGP4 level+9264+12
ADDP4
ADDRLP4 336
INDIRI4
ADDRGP4 level+9264
ADDP4
INDIRB
ASGNB 12
line 1045
;1045:				VectorCopy(ent->r.currentOrigin, level.playerLastKnownGood[ent - g_entities][0]);//copy the ent's current location to LKG
ADDRLP4 340
ADDRFP4 0
INDIRP4
ASGNP4
CNSTI4 24
ADDRLP4 340
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
ADDRLP4 340
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 1046
;1046:			}
LABELV $424
line 1047
;1047:		}
LABELV $418
line 1048
;1048:	}
LABELV $405
line 1051
;1049:
;1050:	// clear the rewards if time
;1051:	if ( level.time > client->rewardTime ) {
ADDRGP4 level+40
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 10344
ADDP4
INDIRI4
LEI4 $430
line 1052
;1052:		client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 312
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 312
INDIRP4
ADDRLP4 312
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 1053
;1053:	}
LABELV $430
line 1056
;1054:
;1055:		// freeze player (RELOAD_FAILED still allowed to move/look)
;1056:	if(level.match_timeout == 1) {
ADDRGP4 level+10800
INDIRU1
CVUI4 1
CNSTI4 1
NEI4 $433
line 1057
;1057:		client->ps.pm_type = PM_FREEZE;
ADDRLP4 312
CNSTI4 4
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 312
INDIRI4
ADDP4
ADDRLP4 312
INDIRI4
ASGNI4
line 1058
;1058:	}
ADDRGP4 $434
JUMPV
LABELV $433
line 1059
;1059:	else if ( client->noclip ) {
ADDRLP4 0
INDIRP4
CNSTI4 10240
ADDP4
INDIRI4
CNSTI4 0
EQI4 $436
line 1060
;1060:		client->ps.pm_type = PM_NOCLIP;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 1
ASGNI4
line 1061
;1061:	} else if ( client->ps.stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 $437
JUMPV
LABELV $436
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $438
line 1062
;1062:		client->ps.pm_type = PM_DEAD;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 3
ASGNI4
line 1063
;1063:	} else {
ADDRGP4 $439
JUMPV
LABELV $438
line 1064
;1064:		client->ps.pm_type = PM_NORMAL;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 1065
;1065:	}
LABELV $439
LABELV $437
LABELV $434
line 1067
;1066:
;1067:	client->ps.gravity = g_gravity.value;
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ADDRGP4 g_gravity+8
INDIRF4
CVFI4 4
ASGNI4
line 1070
;1068:
;1069:	// set speed
;1070:	client->ps.speed = g_speed.value;
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ADDRGP4 g_speed+8
INDIRF4
CVFI4 4
ASGNI4
line 1078
;1071:
;1072:#ifdef MISSIONPACK
;1073:	if( bg_itemlist[client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_SCOUT ) {
;1074:		client->ps.speed *= 1.5;
;1075:	}
;1076:	else
;1077:#endif
;1078:	if ( client->ps.powerups[PW_HASTE] ) {
ADDRLP4 0
INDIRP4
CNSTI4 324
ADDP4
INDIRI4
CNSTI4 0
EQI4 $442
line 1079
;1079:		client->ps.speed *= 1.3;
ADDRLP4 312
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ASGNP4
ADDRLP4 312
INDIRP4
CNSTF4 1067869798
ADDRLP4 312
INDIRP4
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 1080
;1080:	}
LABELV $442
line 1083
;1081:
;1082:	//monkk:grappling hook weapon and offhand grapple
;1083:	switch( weap_enableHook.integer ) {
ADDRLP4 312
ADDRGP4 weap_enableHook+12
INDIRI4
ASGNI4
ADDRLP4 312
INDIRI4
CNSTI4 1
EQI4 $447
ADDRLP4 312
INDIRI4
CNSTI4 2
EQI4 $450
ADDRGP4 $444
JUMPV
LABELV $447
line 1085
;1084:		case 1: //offhand grapple
;1085:			if ( client->hook && !( ucmd->buttons & BUTTON_FIRE_GRAPPLE ) ) {
ADDRLP4 0
INDIRP4
CNSTI4 10364
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $445
ADDRLP4 248
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $445
line 1086
;1086:				Weapon_HookFree(client->hook);
ADDRLP4 0
INDIRP4
CNSTI4 10364
ADDP4
INDIRP4
ARGP4
ADDRGP4 Weapon_HookFree
CALLV
pop
line 1087
;1087:			}
line 1088
;1088:			break;
ADDRGP4 $445
JUMPV
LABELV $450
line 1091
;1089:		case 2: //grapple weapon
;1090:			// Let go of the hook if we aren't firing
;1091:			if ( client->ps.weapon == WP_GRAPPLING_HOOK &&
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 10
NEI4 $445
ADDRLP4 0
INDIRP4
CNSTI4 10364
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $445
ADDRLP4 248
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $445
line 1092
;1092:				client->hook && !( ucmd->buttons & BUTTON_ATTACK ) ) {
line 1093
;1093:				Weapon_HookFree(client->hook);
ADDRLP4 0
INDIRP4
CNSTI4 10364
ADDP4
INDIRP4
ARGP4
ADDRGP4 Weapon_HookFree
CALLV
pop
line 1094
;1094:			}
line 1095
;1095:			break;
LABELV $444
LABELV $445
line 1102
;1096:/*		default: //hook not enabled
;1097:			break;	//don't do a thang
;1098:*/
;1099:	}
;1100:
;1101:	// set up for pmove
;1102:	oldEventSequence = client->ps.eventSequence;
ADDRLP4 268
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ASGNI4
line 1104
;1103:
;1104:	memset (&pm, 0, sizeof(pm));
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 244
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1108
;1105:
;1106:	// check for the hit-scan gauntlet, don't let the action
;1107:	// go through as an attack unless it actually hits something
;1108:	if ( WEAPON_MASK(client->ps.weapon) == WP_GAUNTLET && !( ucmd->buttons & BUTTON_TALK ) &&
ADDRLP4 320
CNSTI4 1
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ADDRLP4 320
INDIRI4
NEI4 $453
ADDRLP4 324
ADDRLP4 248
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
ADDRLP4 328
CNSTI4 0
ASGNI4
ADDRLP4 324
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 328
INDIRI4
NEI4 $453
ADDRLP4 324
INDIRI4
ADDRLP4 320
INDIRI4
BANDI4
ADDRLP4 328
INDIRI4
EQI4 $453
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ADDRLP4 328
INDIRI4
GTI4 $453
line 1109
;1109:		( ucmd->buttons & BUTTON_ATTACK ) && client->ps.weaponTime <= 0 ) {
line 1110
;1110:		pm.gauntletHit = CheckGauntletAttack( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 332
ADDRGP4 CheckGauntletAttack
CALLI4
ASGNI4
ADDRLP4 4+40
ADDRLP4 332
INDIRI4
ASGNI4
line 1111
;1111:		if ( !pm.gauntletHit ) {
ADDRLP4 4+40
INDIRI4
CNSTI4 0
NEI4 $456
line 1112
;1112:			pm.gauntletJump = CheckGauntletJump( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 336
ADDRGP4 CheckGauntletJump
CALLI4
ASGNI4
ADDRLP4 4+44
ADDRLP4 336
INDIRI4
ASGNI4
line 1113
;1113:		}
LABELV $456
line 1114
;1114:	}
LABELV $453
line 1116
;1115:
;1116:	if ( ent->flags & FL_FORCE_GESTURE ) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $460
line 1117
;1117:		ent->flags &= ~FL_FORCE_GESTURE;
ADDRLP4 332
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ASGNP4
ADDRLP4 332
INDIRP4
ADDRLP4 332
INDIRP4
INDIRI4
CNSTI4 -32769
BANDI4
ASGNI4
line 1118
;1118:		ent->client->pers.cmd.buttons |= BUTTON_GESTURE;
ADDRLP4 336
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 488
ADDP4
ASGNP4
ADDRLP4 336
INDIRP4
ADDRLP4 336
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 1119
;1119:	}
LABELV $460
line 1148
;1120:
;1121:#ifdef MISSIONPACK
;1122:	// check for invulnerability expansion before doing the Pmove
;1123:	if (client->ps.powerups[PW_INVULNERABILITY] ) {
;1124:		if ( !(client->ps.pm_flags & PMF_INVULEXPAND) ) {
;1125:			vec3_t mins = { -42, -42, -42 };
;1126:			vec3_t maxs = { 42, 42, 42 };
;1127:			vec3_t oldmins, oldmaxs;
;1128:
;1129:			VectorCopy (ent->r.mins, oldmins);
;1130:			VectorCopy (ent->r.maxs, oldmaxs);
;1131:			// expand
;1132:			VectorCopy (mins, ent->r.mins);
;1133:			VectorCopy (maxs, ent->r.maxs);
;1134:			trap_LinkEntity(ent);
;1135:			// check if this would get anyone stuck in this player
;1136:			if ( !StuckInOtherClient(ent) ) {
;1137:				// set flag so the expanded size will be set in PM_CheckDuck
;1138:				client->ps.pm_flags |= PMF_INVULEXPAND;
;1139:			}
;1140:			// set back
;1141:			VectorCopy (oldmins, ent->r.mins);
;1142:			VectorCopy (oldmaxs, ent->r.maxs);
;1143:			trap_LinkEntity(ent);
;1144:		}
;1145:	}
;1146:#endif
;1147:
;1148:	pm.ps = &client->ps;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 1149
;1149:	pm.cmd = *ucmd;
ADDRLP4 4+4
ADDRLP4 248
INDIRP4
INDIRB
ASGNB 24
line 1150
;1150:	if ( pm.ps->pm_type == PM_DEAD ) {
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $463
line 1151
;1151:		pm.tracemask = MASK_PLAYERSOLID & ~CONTENTS_BODY;
ADDRLP4 4+28
CNSTI4 65537
ASGNI4
line 1152
;1152:	}
ADDRGP4 $464
JUMPV
LABELV $463
line 1153
;1153:	else if ( ent->r.svFlags & SVF_BOT ) {
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $466
line 1154
;1154:		pm.tracemask = MASK_PLAYERSOLID | CONTENTS_BOTCLIP;
ADDRLP4 4+28
CNSTI4 37814273
ASGNI4
line 1155
;1155:	}
ADDRGP4 $467
JUMPV
LABELV $466
line 1156
;1156:	else {
line 1157
;1157:		pm.tracemask = MASK_PLAYERSOLID;
ADDRLP4 4+28
CNSTI4 33619969
ASGNI4
line 1158
;1158:	}
LABELV $467
LABELV $464
line 1159
;1159:	pm.trace = trap_Trace;
ADDRLP4 4+236
ADDRGP4 trap_Trace
ASGNP4
line 1160
;1160:	pm.pointcontents = trap_PointContents;
ADDRLP4 4+240
ADDRGP4 trap_PointContents
ASGNP4
line 1161
;1161:	pm.debugLevel = g_debugMove.integer;
ADDRLP4 4+32
ADDRGP4 g_debugMove+12
INDIRI4
ASGNI4
line 1162
;1162:	pm.noFootsteps = ( g_dmflags.integer & DF_NO_FOOTSTEPS ) > 0;
ADDRGP4 g_dmflags+12
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
LEI4 $477
ADDRLP4 332
CNSTI4 1
ASGNI4
ADDRGP4 $478
JUMPV
LABELV $477
ADDRLP4 332
CNSTI4 0
ASGNI4
LABELV $478
ADDRLP4 4+36
ADDRLP4 332
INDIRI4
ASGNI4
line 1170
;1163:
;1164:	//if ( sv_lock_pmove.integer == 1 ) {
;1165:	//pm.pmove_fixed = pmove_fixed.integer | client->pers.pmoveFixed;
;1166:	//	pm.pmove_fixed = pmove_fixed.integer;
;1167:	//} else {
;1168:	//	pm.pmove_fixed = client->pers.pmoveFixed;
;1169:	//}
;1170:	sv_lock_pmove.integer?(pm.pmove_fixed = pmove_fixed.integer):(pm.pmove_fixed = client->pers.pmoveFixed);
ADDRGP4 sv_lock_pmove+12
INDIRI4
CNSTI4 0
EQI4 $484
ADDRLP4 4+220
ADDRGP4 pmove_fixed+12
INDIRI4
ASGNI4
ADDRGP4 $485
JUMPV
LABELV $484
ADDRLP4 4+220
ADDRLP4 0
INDIRP4
CNSTI4 508
ADDP4
INDIRI4
ASGNI4
LABELV $485
line 1171
;1171:	pm.pmove_msec = pmove_msec.integer;
ADDRLP4 4+224
ADDRGP4 pmove_msec+12
INDIRI4
ASGNI4
line 1173
;1172:
;1173:	VectorCopy( client->ps.origin, client->oldOrigin );
ADDRLP4 0
INDIRP4
CNSTI4 10268
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 1175
;1174:
;1175:	if (g_allowObliterate.integer)
ADDRGP4 g_allowObliterate+12
INDIRI4
CNSTI4 0
EQI4 $488
line 1176
;1176:	{
line 1177
;1177:		pm.timeOfDeath = ent->timeOfDeath;
ADDRLP4 4+228
ADDRFP4 0
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
ASGNI4
line 1178
;1178:	}
ADDRGP4 $489
JUMPV
LABELV $488
line 1180
;1179:	else
;1180:	{
line 1181
;1181:		pm.timeOfDeath = ent->client->pers.cmd.serverTime - 1;
ADDRLP4 4+228
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 472
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1182
;1182:	}
LABELV $489
line 1184
;1183:
;1184:	pm.commandTime = ent->client->pers.cmd.serverTime;
ADDRLP4 4+232
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 472
ADDP4
INDIRI4
ASGNI4
line 1201
;1185:
;1186:#ifdef MISSIONPACK
;1187:	if (level.intermissionQueued != 0 && g_singlePlayer.integer) {
;1188:		if ( level.time - level.intermissionQueued >= 1000  ) {
;1189:			pm.cmd.buttons = 0;
;1190:			pm.cmd.forwardmove = 0;
;1191:			pm.cmd.rightmove = 0;
;1192:			pm.cmd.upmove = 0;
;1193:			if ( level.time - level.intermissionQueued >= 2000 && level.time - level.intermissionQueued <= 2500 ) {
;1194:				trap_SendConsoleCommand( EXEC_APPEND, "centerview\n");
;1195:			}
;1196:			ent->client->ps.pm_type = PM_SPINTERMISSION;
;1197:		}
;1198:	}
;1199:	Pmove (&pm);
;1200:#else
;1201:	Pmove (&pm);
ADDRLP4 4
ARGP4
ADDRGP4 Pmove
CALLV
pop
line 1204
;1202:#endif
;1203:	//We have to run a pmove before we can dump into client->
;1204:		if ( shifted ) {
ADDRLP4 272
INDIRI4
CNSTI4 0
EQI4 $494
line 1205
;1205:			G_UnTimeShiftAllClients( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_UnTimeShiftAllClients
CALLV
pop
line 1206
;1206:		}
LABELV $494
line 1211
;1207:	//ent->client->distance = pm.adDistance;
;1208:	//G_Printf("%i -- %i", ent->client->distance, pm.adDistance );
;1209:
;1210:	// save results of pmove
;1211:	if ( ent->client->ps.eventSequence != oldEventSequence ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ADDRLP4 268
INDIRI4
EQI4 $496
line 1212
;1212:		ent->eventTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 552
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 1213
;1213:	}
LABELV $496
line 1221
;1214://unlagged - smooth clients #2
;1215:	// clients no longer do extrapolation if cg_smoothClients is 1, because
;1216:	// skip correction is all handled server-side now
;1217:	// since that's the case, it makes no sense to store the extra info
;1218:	// in the client's snapshot entity, so let's save a little bandwidth
;1219:
;1220:	//if (!g_unlaggedSmoothClients.integer && g_smoothClients.integer == 1) {
;1221:	if (g_smoothClients.integer == 1) {
ADDRGP4 g_smoothClients+12
INDIRI4
CNSTI4 1
NEI4 $499
line 1222
;1222:		BG_PlayerStateToEntityStateExtraPolate( &ent->client->ps, &ent->s, ent->client->ps.commandTime, qtrue );
ADDRLP4 340
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 344
ADDRLP4 340
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 344
INDIRP4
ARGP4
ADDRLP4 340
INDIRP4
ARGP4
ADDRLP4 344
INDIRP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BG_PlayerStateToEntityStateExtraPolate
CALLV
pop
line 1223
;1223:	} else {
ADDRGP4 $500
JUMPV
LABELV $499
line 1224
;1224:		BG_PlayerStateToEntityState( &ent->client->ps, &ent->s, qtrue );
ADDRLP4 340
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 340
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 340
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 1227
;1225://	}
;1226://unlagged - smooth clients #2
;1227:	}
LABELV $500
line 1228
;1228:	SendPendingPredictableEvents( &ent->client->ps );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRGP4 SendPendingPredictableEvents
CALLV
pop
line 1230
;1229:
;1230:	if ( !( ent->client->ps.eFlags & EF_FIRING ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
NEI4 $502
line 1231
;1231:		client->fireHeld = qfalse;		// for grapple
ADDRLP4 0
INDIRP4
CNSTI4 10360
ADDP4
CNSTI4 0
ASGNI4
line 1232
;1232:	}
LABELV $502
line 1235
;1233:
;1234:	// use the snapped origin for linking so it matches client predicted versions
;1235:	VectorCopy( ent->s.pos.trBase, ent->r.currentOrigin );
ADDRLP4 340
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 340
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 340
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 1237
;1236:
;1237:	VectorCopy (pm.mins, ent->r.mins);
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRLP4 4+184
INDIRB
ASGNB 12
line 1238
;1238:	VectorCopy (pm.maxs, ent->r.maxs);
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
ADDRLP4 4+196
INDIRB
ASGNB 12
line 1240
;1239:
;1240:	ent->waterlevel = pm.waterlevel;
ADDRFP4 0
INDIRP4
CNSTI4 788
ADDP4
ADDRLP4 4+212
INDIRI4
ASGNI4
line 1241
;1241:	ent->watertype = pm.watertype;
ADDRFP4 0
INDIRP4
CNSTI4 784
ADDP4
ADDRLP4 4+208
INDIRI4
ASGNI4
line 1244
;1242:
;1243:	// execute client events
;1244:	if(level.match_timeout == 0) {
ADDRGP4 level+10800
INDIRU1
CVUI4 1
CNSTI4 0
NEI4 $508
line 1245
;1245:		ClientEvents( ent, oldEventSequence );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 268
INDIRI4
ARGI4
ADDRGP4 ClientEvents
CALLV
pop
line 1246
;1246:	}
LABELV $508
line 1249
;1247:
;1248:	// link entity now, after any personal teleporters have been used
;1249:	trap_LinkEntity (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 1250
;1250:	if ( !ent->client->noclip ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10240
ADDP4
INDIRI4
CNSTI4 0
NEI4 $511
line 1251
;1251:		G_TouchTriggers( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_TouchTriggers
CALLV
pop
line 1252
;1252:	}
LABELV $511
line 1255
;1253:
;1254:	// NOTE: now copy the exact origin over otherwise clients can be snapped into solid
;1255:	VectorCopy( ent->client->ps.origin, ent->r.currentOrigin );
ADDRLP4 344
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 344
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 344
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 1258
;1256:
;1257:	//test for solid areas in the AAS file
;1258:	BotTestAAS(ent->r.currentOrigin);
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRGP4 BotTestAAS
CALLV
pop
line 1261
;1259:
;1260:	// touch other objects
;1261:	ClientImpacts( ent, &pm );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 ClientImpacts
CALLV
pop
line 1264
;1262:
;1263:	// save results of triggers and client events
;1264:	if (ent->client->ps.eventSequence != oldEventSequence) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ADDRLP4 268
INDIRI4
EQI4 $513
line 1265
;1265:		ent->eventTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 552
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 1266
;1266:	}
LABELV $513
line 1269
;1267:
;1268:	// swap and latch button actions
;1269:	client->oldbuttons = client->buttons;
ADDRLP4 0
INDIRP4
CNSTI4 10260
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 10256
ADDP4
INDIRI4
ASGNI4
line 1270
;1270:	client->buttons = ucmd->buttons;
ADDRLP4 0
INDIRP4
CNSTI4 10256
ADDP4
ADDRLP4 248
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 1271
;1271:	client->latched_buttons |= client->buttons & ~client->oldbuttons;
ADDRLP4 356
ADDRLP4 0
INDIRP4
CNSTI4 10264
ADDP4
ASGNP4
ADDRLP4 356
INDIRP4
ADDRLP4 356
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 10256
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 10260
ADDP4
INDIRI4
BCOMI4
BANDI4
BORI4
ASGNI4
line 1275
;1272:
;1273:	// check for respawning
;1274:	//FIXME: May not be needed.
;1275:	if ( client->ps.stats[STAT_HEALTH] <= 0 /*&& (g_allowObliterate.integer == 0 ||
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $516
line 1278
;1276:		(g_allowObliterate.integer && pm.timeOfDeath >= pm.commandTime) )*/ ) {
;1277:		// wait for the attack button to be pressed
;1278:		if ( level.time > client->respawnTime ) {
ADDRGP4 level+40
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 10332
ADDP4
INDIRI4
LEI4 $310
line 1280
;1279:			// forcerespawn is to prevent users from waiting out powerups
;1280:			if ( g_forcerespawn.integer > 0 && 
ADDRGP4 g_forcerespawn+12
INDIRI4
CNSTI4 0
LEI4 $521
ADDRGP4 level+40
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 10332
ADDP4
INDIRI4
SUBI4
CNSTI4 1000
ADDRGP4 g_forcerespawn+12
INDIRI4
MULI4
LEI4 $521
line 1281
;1281:				( level.time - client->respawnTime ) > g_forcerespawn.integer * 1000 ) {
line 1282
;1282:				respawn( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 respawn
CALLV
pop
line 1283
;1283:				return;
ADDRGP4 $310
JUMPV
LABELV $521
line 1287
;1284:			}
;1285:		
;1286:			// pressing attack or use is the normal respawn method
;1287:			if ( ucmd->buttons & ( BUTTON_ATTACK | BUTTON_USE_HOLDABLE ) ) {
ADDRLP4 248
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 5
BANDI4
CNSTI4 0
EQI4 $310
line 1288
;1288:				respawn( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 respawn
CALLV
pop
line 1289
;1289:			}
line 1290
;1290:		}
line 1291
;1291:		return;
ADDRGP4 $310
JUMPV
LABELV $516
line 1295
;1292:	}
;1293:
;1294:	// perform once-a-second actions
;1295:	if(level.match_timeout == 0) {
ADDRGP4 level+10800
INDIRU1
CVUI4 1
CNSTI4 0
NEI4 $528
line 1296
;1296:		ClientTimerActions( ent, msec );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 252
INDIRI4
ARGI4
ADDRGP4 ClientTimerActions
CALLV
pop
line 1297
;1297:	}
LABELV $528
line 1298
;1298:}
LABELV $310
endproc ClientThink_real 1348 16
export PlayerHasFlagPowerup
proc PlayerHasFlagPowerup 12 0
line 1300
;1299://Monkk
;1300:qboolean PlayerHasFlagPowerup(gentity_t *ent, int flag) {
line 1301
;1301:	qboolean hasFlag = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1303
;1302:
;1303:	if (! ent || ! ent->client) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
CNSTU4 0
ASGNU4
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRU4
EQU4 $534
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRU4
NEU4 $532
LABELV $534
line 1304
;1304:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $531
JUMPV
LABELV $532
line 1307
;1305:	}
;1306:
;1307:	if (flag == -1) { //search for any flag
ADDRFP4 4
INDIRI4
CNSTI4 -1
NEI4 $535
line 1308
;1308:		if( ent->client->ps.powerups[PW_REDFLAG] ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
EQI4 $537
line 1309
;1309:		} else if( ent->client->ps.powerups[PW_BLUEFLAG] ) {
ADDRGP4 $536
JUMPV
LABELV $537
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $539
line 1313
;1310:#ifdef MISSIONPACK
;1311:		} else if( ent->client->ps.powerups[PW_NEUTRALFLAG] ) {
;1312:#endif
;1313:		} else {
ADDRGP4 $536
JUMPV
LABELV $539
line 1314
;1314:			hasFlag = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1315
;1315:		}
line 1316
;1316:	} else { //just the flag in particular
ADDRGP4 $536
JUMPV
LABELV $535
line 1317
;1317:		hasFlag = (qboolean)(ent->client->ps.powerups[flag]);
ADDRLP4 0
ADDRFP4 4
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
ASGNI4
line 1318
;1318:	}
LABELV $536
line 1320
;1319:
;1320:	return hasFlag;
ADDRLP4 0
INDIRI4
RETI4
LABELV $531
endproc PlayerHasFlagPowerup 12 0
export ClassnameIsMover
proc ClassnameIsMover 28 8
line 1322
;1321:}
;1322:qboolean ClassnameIsMover(char *classname) {
line 1323
;1323:	qboolean rslt = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1325
;1324:	//monkk: hmm... managed to get a null pointer sent in here...
;1325:	if( !classname ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $542
line 1326
;1326:		return qtrue;//monkk: if the classname is null, chances are it can move i think
CNSTI4 1
RETI4
ADDRGP4 $541
JUMPV
LABELV $542
line 1329
;1327:	}
;1328:	if (
;1329:		(strcmp(classname, "func_bobbing"	) == 0) ||
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $546
ARGP4
ADDRLP4 4
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $556
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $547
ARGP4
ADDRLP4 8
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $556
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $548
ARGP4
ADDRLP4 12
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $556
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $549
ARGP4
ADDRLP4 16
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $556
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $550
ARGP4
ADDRLP4 20
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $556
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $551
ARGP4
ADDRLP4 24
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $544
LABELV $556
line 1340
;1330:		//(strcmp(classname, "func_button"	) == 0) ||
;1331:		(strcmp(classname, "func_door"	) == 0) ||
;1332:		//(strcmp(classname, "func_group"	) == 0) ||
;1333:		(strcmp(classname, "func_pendulum") == 0) ||
;1334:		(strcmp(classname, "func_plat"	) == 0) ||
;1335:		(strcmp(classname, "func_rotating") == 0) ||
;1336:		//(strcmp(classname, "func_static"	) == 0) ||
;1337:		//(strcmp(classname, "func_timer"	) == 0) ||
;1338:		(strcmp(classname, "func_train"	) == 0) 
;1339:		)
;1340:	{
line 1341
;1341:		rslt = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1342
;1342:	}
LABELV $544
line 1343
;1343:	return rslt;
ADDRLP4 0
INDIRI4
RETI4
LABELV $541
endproc ClassnameIsMover 28 8
export SpawnFlagAtLastKnownGood
proc SpawnFlagAtLastKnownGood 68 8
line 1345
;1344:}
;1345:void SpawnFlagAtLastKnownGood(gentity_t *flag) { 
line 1350
;1346:	gentity_t	*pEnt;
;1347:	gitem_t		*item; 
;1348:	vec3_t		lastKnownGood;
;1349:	int			flagPowerupIndex, flagCheckCount,flagTeam;
;1350:	qboolean	flagSacrificed = qfalse;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 1355
;1351:
;1352:	//the flag item is calling to sacrifice itself
;1353:	
;1354:	//sets up flagPowerupIndex, flagCheckCount, and finds the pEnt for the player last holding the flag
;1355:	flagSacrificed = qtrue;
ADDRLP4 16
CNSTI4 1
ASGNI4
line 1356
;1356:	flagPowerupIndex = flag->item->giTag;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ASGNI4
line 1357
;1357:	item = flag->item;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
ASGNP4
line 1360
;1358:
;1359:	//determine the power up index for the flag that is thinking
;1360:	flagCheckCount = (flagPowerupIndex==PW_REDFLAG)?0:((flagPowerupIndex==PW_BLUEFLAG)?1:2);
ADDRLP4 0
INDIRI4
CNSTI4 7
NEI4 $560
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRGP4 $561
JUMPV
LABELV $560
ADDRLP4 0
INDIRI4
CNSTI4 8
NEI4 $562
ADDRLP4 40
CNSTI4 1
ASGNI4
ADDRGP4 $563
JUMPV
LABELV $562
ADDRLP4 40
CNSTI4 2
ASGNI4
LABELV $563
ADDRLP4 36
ADDRLP4 40
INDIRI4
ASGNI4
LABELV $561
ADDRLP4 28
ADDRLP4 36
INDIRI4
ASGNI4
line 1362
;1361:	//set the player entity
;1362:	pEnt = &g_entities[flag->flagSacData.lastPickupPlayerEntNum];
ADDRLP4 20
CNSTI4 896
ADDRFP4 0
INDIRP4
CNSTI4 836
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1363
;1363:	trap_UnlinkEntity(flag);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 1366
;1364:
;1365:	//pick an LKG, and don't attempt a sacrifice more then 3 times...
;1366:	switch( flag->flagSacData.sacrificeCount ) {
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $567
ADDRLP4 44
INDIRI4
CNSTI4 1
EQI4 $568
ADDRGP4 $564
JUMPV
LABELV $567
line 1369
;1367:		case 0:
;1368:			//1st attempt, use the players LKG. 
;1369:			VectorCopy(flag->flagSacData.sacrificePos[flag->flagSacData.sacrificeCount], lastKnownGood);
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTI4 12
ADDRLP4 52
INDIRP4
CNSTI4 808
ADDP4
INDIRI4
MULI4
ADDRLP4 52
INDIRP4
CNSTI4 812
ADDP4
ADDP4
INDIRB
ASGNB 12
line 1370
;1370:			break;
ADDRGP4 $565
JUMPV
LABELV $568
line 1373
;1371:		case 1:
;1372:			//2nd attempt, try the secondary LKG
;1373:			trap_SendServerCommand(-1, "print \""S_COLOR_RED"Error: invalid LKG, attempting secondary.\n\"\n");
CNSTI4 -1
ARGI4
ADDRGP4 $569
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1374
;1374:			VectorCopy(flag->flagSacData.sacrificePos[flag->flagSacData.sacrificeCount], lastKnownGood);
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTI4 12
ADDRLP4 56
INDIRP4
CNSTI4 808
ADDP4
INDIRI4
MULI4
ADDRLP4 56
INDIRP4
CNSTI4 812
ADDP4
ADDP4
INDIRB
ASGNB 12
line 1375
;1375:			break;
ADDRGP4 $565
JUMPV
LABELV $564
line 1377
;1376:		default :
;1377:			flagTeam = (flag->item->giTag==PW_REDFLAG)?TEAM_RED:((flag->item->giTag==PW_BLUEFLAG)?TEAM_BLUE:TEAM_FREE);
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 7
NEI4 $572
ADDRLP4 60
CNSTI4 1
ASGNI4
ADDRGP4 $573
JUMPV
LABELV $572
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 8
NEI4 $574
ADDRLP4 64
CNSTI4 2
ASGNI4
ADDRGP4 $575
JUMPV
LABELV $574
ADDRLP4 64
CNSTI4 0
ASGNI4
LABELV $575
ADDRLP4 60
ADDRLP4 64
INDIRI4
ASGNI4
LABELV $573
ADDRLP4 32
ADDRLP4 60
INDIRI4
ASGNI4
line 1379
;1378:			//just return it to the base... something screwy has occured
;1379:			trap_SendServerCommand(-1, "print \""S_COLOR_RED"Error: invalid LKG determination. Flag returned to base\n\"\n");
CNSTI4 -1
ARGI4
ADDRGP4 $576
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1380
;1380:			Team_ReturnFlag( flagTeam );
ADDRLP4 32
INDIRI4
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 1381
;1381:			return;
ADDRGP4 $557
JUMPV
LABELV $565
line 1386
;1382:	}
;1383:
;1384:	//move the falling flag to be the LKG
;1385:	//G_SetOrigin( flag, lastKnownGood );
;1386:	VectorCopy(lastKnownGood, flag->s.pos.trBase);
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 4
INDIRB
ASGNB 12
line 1387
;1387:	VectorCopy(lastKnownGood, flag->r.currentOrigin);
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 4
INDIRB
ASGNB 12
line 1388
;1388:	flag->s.pos.trDuration = 0;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
CNSTI4 0
ASGNI4
line 1389
;1389:	flag->s.pos.trTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 0
ASGNI4
line 1390
;1390:	VectorClear(flag->s.pos.trDelta);
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
CNSTF4 0
ASGNF4
ADDRLP4 52
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 56
INDIRF4
ASGNF4
ADDRLP4 52
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 56
INDIRF4
ASGNF4
ADDRLP4 52
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 56
INDIRF4
ASGNF4
line 1392
;1391:
;1392:	flag->s.pos.trType = TR_GRAVITY;// TR_STATIONARY;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 5
ASGNI4
line 1393
;1393:	trap_LinkEntity(flag);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 1395
;1394:	//set the flag status for the correct flag we dropped
;1395:	Team_CheckDroppedItem(flag);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Team_CheckDroppedItem
CALLV
pop
line 1397
;1396:	//display sacrifice the text and play the sound
;1397:	AnnounceFlagSacrifice(flag);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 AnnounceFlagSacrifice
CALLV
pop
line 1399
;1398:	//increment the sac count
;1399:	flag->flagSacData.sacrificeCount++;
ADDRLP4 60
ADDRFP4 0
INDIRP4
CNSTI4 808
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
line 1401
;1400:
;1401:	return; 
LABELV $557
endproc SpawnFlagAtLastKnownGood 68 8
data
align 4
LABELV sacStart
address $577
align 4
LABELV sacBlueFlag
address $578
align 4
LABELV sacRedFlag
address $579
align 4
LABELV sacNeutralFlag
address $580
align 4
LABELV sacUnknownFlag
address $581
align 4
LABELV sacMid
address $582
align 4
LABELV sacMidBig
address $583
align 4
LABELV sacEnd
address $584
align 4
LABELV sacUnknownLoc
address $585
export AnnounceFlagSacrifice
code
proc AnnounceFlagSacrifice 232 24
line 1412
;1402:} 
;1403:static char *sacStart		= "\""S_COLOR_YELLOW"-- ";
;1404:static char *sacBlueFlag	= S_COLOR_BLUE"BLUE FLAG";
;1405:static char *sacRedFlag		= S_COLOR_RED"RED FLAG";
;1406:static char *sacNeutralFlag = S_COLOR_WHITE"NEUTRAL FLAG";
;1407:static char *sacUnknownFlag = S_COLOR_MAGENTA"UNKNOWN?!? FLAG";
;1408:static char *sacMid			= " "S_COLOR_YELLOW"was SACRIFICED by: "S_COLOR_WHITE;
;1409:static char *sacMidBig		= " "S_COLOR_YELLOW"SACRIFICED near \n";
;1410:static char *sacEnd			= " "S_COLOR_YELLOW"--"S_COLOR_WHITE;
;1411:static char *sacUnknownLoc	= S_COLOR_YELLOW"--Unknown";
;1412:void AnnounceFlagSacrifice(gentity_t *flag) {
line 1415
;1413:	gentity_t	*te;
;1414:	char		name[128];
;1415:	int			flagColor = flag->item->giTag;
ADDRLP4 68
ADDRFP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ASGNI4
line 1418
;1416:	// don't let text be too long for malicious reasons
;1417:	char		location[64];
;1418:	qboolean	locFound = qfalse;
ADDRLP4 64
CNSTI4 0
ASGNI4
line 1421
;1419:
;1420:	//get location message based on location of last known good ent, for that extra level of accuracy
;1421:	locFound = Team_GetLocationMsgByVec(flag->flagSacData.sacrificePos[flag->flagSacData.sacrificeCount], location, sizeof(location));
ADDRLP4 204
ADDRFP4 0
INDIRP4
ASGNP4
CNSTI4 12
ADDRLP4 204
INDIRP4
CNSTI4 808
ADDP4
INDIRI4
MULI4
ADDRLP4 204
INDIRP4
CNSTI4 812
ADDP4
ADDP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 208
ADDRGP4 Team_GetLocationMsgByVec
CALLI4
ASGNI4
ADDRLP4 64
ADDRLP4 208
INDIRI4
ASGNI4
line 1422
;1422:	if ( locFound && location ) {
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $587
ADDRLP4 0
CVPU4 4
CNSTU4 0
EQU4 $587
line 1423
;1423:		Com_sprintf (name, sizeof(name), "%s "S_COLOR_YELLOW"near the %s"S_COLOR_WHITE, flag->flagSacData.sacPlayerName, location);
ADDRLP4 72
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $589
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 840
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1424
;1424:	} else {
ADDRGP4 $588
JUMPV
LABELV $587
line 1425
;1425:		Com_sprintf (name, sizeof(name), S_COLOR_WHITE"%s", flag->flagSacData.sacPlayerName );
ADDRLP4 72
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $590
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 840
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1426
;1426:	}
LABELV $588
line 1433
;1427:
;1428:	//anything meaningful to log... dunno
;1429:	//G_LogPrintf( "flag sacrifice: %s: %s %s\n", player->client->pers.netname, chatText );
;1430:	/*G_Printf("flag sacrifice: %s: %s\n", player->client->pers.netname);
;1431:	G_Printf("location: %s\n", location);*/
;1432:	// send it to all the apropriate clients
;1433:	switch (flagColor) {
ADDRLP4 212
ADDRLP4 68
INDIRI4
ASGNI4
ADDRLP4 212
INDIRI4
CNSTI4 7
EQI4 $593
ADDRLP4 212
INDIRI4
CNSTI4 8
EQI4 $605
ADDRLP4 212
INDIRI4
CNSTI4 9
EQI4 $615
ADDRGP4 $591
JUMPV
LABELV $593
line 1435
;1434:		case PW_REDFLAG :
;1435:			if (g_sacrificeAnnounce.integer & SAC_CONSOLE) {
ADDRGP4 g_sacrificeAnnounce+12
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $594
line 1436
;1436:				trap_SendServerCommand(-1, va("chat %s%s%s%s%s",sacStart,sacRedFlag,sacMid,name,sacEnd));
ADDRGP4 $597
ARGP4
ADDRGP4 sacStart
INDIRP4
ARGP4
ADDRGP4 sacRedFlag
INDIRP4
ARGP4
ADDRGP4 sacMid
INDIRP4
ARGP4
ADDRLP4 72
ARGP4
ADDRGP4 sacEnd
INDIRP4
ARGP4
ADDRLP4 216
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 216
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1437
;1437:			}
LABELV $594
line 1438
;1438:			if (g_sacrificeAnnounce.integer & SAC_SCREEN) {
ADDRGP4 g_sacrificeAnnounce+12
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $592
line 1439
;1439:				trap_SendServerCommand(-1, va(  "cp \"%s%s%s\n\"", sacRedFlag,sacMidBig,(locFound)?location:sacUnknownLoc));
ADDRGP4 $601
ARGP4
ADDRGP4 sacRedFlag
INDIRP4
ARGP4
ADDRGP4 sacMidBig
INDIRP4
ARGP4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $603
ADDRLP4 216
ADDRLP4 0
ASGNP4
ADDRGP4 $604
JUMPV
LABELV $603
ADDRLP4 216
ADDRGP4 sacUnknownLoc
INDIRP4
ASGNP4
LABELV $604
ADDRLP4 216
INDIRP4
ARGP4
ADDRLP4 220
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 220
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1440
;1440:			}
line 1441
;1441:			break;
ADDRGP4 $592
JUMPV
LABELV $605
line 1443
;1442:		case PW_BLUEFLAG :
;1443:			if (g_sacrificeAnnounce.integer & SAC_CONSOLE) {
ADDRGP4 g_sacrificeAnnounce+12
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $606
line 1444
;1444:				trap_SendServerCommand(-1, va("chat %s%s%s%s%s",sacStart,sacBlueFlag,sacMid,name,sacEnd));
ADDRGP4 $597
ARGP4
ADDRGP4 sacStart
INDIRP4
ARGP4
ADDRGP4 sacBlueFlag
INDIRP4
ARGP4
ADDRGP4 sacMid
INDIRP4
ARGP4
ADDRLP4 72
ARGP4
ADDRGP4 sacEnd
INDIRP4
ARGP4
ADDRLP4 216
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 216
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1445
;1445:			}
LABELV $606
line 1446
;1446:			if (g_sacrificeAnnounce.integer & SAC_SCREEN) {
ADDRGP4 g_sacrificeAnnounce+12
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $592
line 1447
;1447:				trap_SendServerCommand(-1, va(  "cp \"%s%s%s\n\"", sacBlueFlag,sacMidBig,(locFound)?location:sacUnknownLoc));
ADDRGP4 $601
ARGP4
ADDRGP4 sacBlueFlag
INDIRP4
ARGP4
ADDRGP4 sacMidBig
INDIRP4
ARGP4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $613
ADDRLP4 216
ADDRLP4 0
ASGNP4
ADDRGP4 $614
JUMPV
LABELV $613
ADDRLP4 216
ADDRGP4 sacUnknownLoc
INDIRP4
ASGNP4
LABELV $614
ADDRLP4 216
INDIRP4
ARGP4
ADDRLP4 220
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 220
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1448
;1448:			}
line 1449
;1449:			break;
ADDRGP4 $592
JUMPV
LABELV $615
line 1451
;1450:		case PW_NEUTRALFLAG :
;1451:			if (g_sacrificeAnnounce.integer & SAC_CONSOLE) {
ADDRGP4 g_sacrificeAnnounce+12
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $616
line 1452
;1452:				trap_SendServerCommand(-1, va("chat %s%s%s%s%s",sacStart,sacNeutralFlag,sacMid,name,sacEnd));
ADDRGP4 $597
ARGP4
ADDRGP4 sacStart
INDIRP4
ARGP4
ADDRGP4 sacNeutralFlag
INDIRP4
ARGP4
ADDRGP4 sacMid
INDIRP4
ARGP4
ADDRLP4 72
ARGP4
ADDRGP4 sacEnd
INDIRP4
ARGP4
ADDRLP4 216
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 216
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1453
;1453:			}
LABELV $616
line 1454
;1454:			if (g_sacrificeAnnounce.integer & SAC_SCREEN) {
ADDRGP4 g_sacrificeAnnounce+12
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $592
line 1455
;1455:				trap_SendServerCommand(-1, va(  "cp \"%s%s%s\n\"", sacNeutralFlag,sacMidBig,(locFound)?location:sacUnknownLoc));
ADDRGP4 $601
ARGP4
ADDRGP4 sacNeutralFlag
INDIRP4
ARGP4
ADDRGP4 sacMidBig
INDIRP4
ARGP4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $623
ADDRLP4 216
ADDRLP4 0
ASGNP4
ADDRGP4 $624
JUMPV
LABELV $623
ADDRLP4 216
ADDRGP4 sacUnknownLoc
INDIRP4
ASGNP4
LABELV $624
ADDRLP4 216
INDIRP4
ARGP4
ADDRLP4 220
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 220
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1456
;1456:			}
line 1457
;1457:			break;
ADDRGP4 $592
JUMPV
LABELV $591
line 1459
;1458:		default :
;1459:			if (g_sacrificeAnnounce.integer & SAC_CONSOLE) {
ADDRGP4 g_sacrificeAnnounce+12
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $625
line 1460
;1460:				trap_SendServerCommand(-1, va("chat %s%s%s%s%s",sacStart,sacUnknownFlag,sacMid,name,sacEnd));
ADDRGP4 $597
ARGP4
ADDRGP4 sacStart
INDIRP4
ARGP4
ADDRGP4 sacUnknownFlag
INDIRP4
ARGP4
ADDRGP4 sacMid
INDIRP4
ARGP4
ADDRLP4 72
ARGP4
ADDRGP4 sacEnd
INDIRP4
ARGP4
ADDRLP4 216
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 216
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1461
;1461:			}
LABELV $625
line 1462
;1462:			if (g_sacrificeAnnounce.integer & SAC_SCREEN) {
ADDRGP4 g_sacrificeAnnounce+12
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $592
line 1463
;1463:				trap_SendServerCommand(-1, va(  "cp \"%s%s%s\n\"", sacUnknownFlag,sacMidBig,(locFound)?location:sacUnknownLoc));
ADDRGP4 $601
ARGP4
ADDRGP4 sacUnknownFlag
INDIRP4
ARGP4
ADDRGP4 sacMidBig
INDIRP4
ARGP4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $632
ADDRLP4 216
ADDRLP4 0
ASGNP4
ADDRGP4 $633
JUMPV
LABELV $632
ADDRLP4 216
ADDRGP4 sacUnknownLoc
INDIRP4
ASGNP4
LABELV $633
ADDRLP4 216
INDIRP4
ARGP4
ADDRLP4 220
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 220
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1464
;1464:			}
line 1465
;1465:			break;
LABELV $592
line 1468
;1466:	}
;1467:
;1468:	if (g_sacrificeAnnounce.integer & SAC_SOUND && (flag->flagSacData.sacrificeCount < 2) ) {
ADDRGP4 g_sacrificeAnnounce+12
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $634
ADDRFP4 0
INDIRP4
CNSTI4 808
ADDP4
INDIRI4
CNSTI4 2
GEI4 $634
line 1469
;1469:		te = G_TempEntity( flag->flagSacData.sacrificePos[flag->flagSacData.sacrificeCount], EV_GLOBAL_SOUND );
ADDRLP4 216
ADDRFP4 0
INDIRP4
ASGNP4
CNSTI4 12
ADDRLP4 216
INDIRP4
CNSTI4 808
ADDP4
INDIRI4
MULI4
ADDRLP4 216
INDIRP4
CNSTI4 812
ADDP4
ADDP4
ARGP4
CNSTI4 46
ARGI4
ADDRLP4 220
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 200
ADDRLP4 220
INDIRP4
ASGNP4
line 1470
;1470:		te->s.eventParm = G_SoundIndex( "sound/teamplay/flagtaken_opponent_01.wav" );
ADDRGP4 $637
ARGP4
ADDRLP4 224
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRLP4 200
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 224
INDIRI4
ASGNI4
line 1471
;1471:		te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 228
ADDRLP4 200
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 228
INDIRP4
ADDRLP4 228
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 1472
;1472:	}
LABELV $634
line 1473
;1473:}
LABELV $586
endproc AnnounceFlagSacrifice 232 24
export StoreClientCommand
proc StoreClientCommand 16 12
line 1475
;1474:
;1475:void StoreClientCommand(int clientNum, usercmd_t* cmd) {
line 1480
;1476:	gentity_t *ent;
;1477://	int			j;
;1478:
;1479:	//Set the game entity of the client
;1480:	ent = g_entities + clientNum;
ADDRLP4 0
CNSTI4 896
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1481
;1481:	ent->client->pers.cmdStackIndex++;//Go to the next command in stack
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 7796
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1483
;1482:
;1483:	if (ent->client->pers.cmdStackIndex > 255)
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 7796
ADDP4
INDIRI4
CNSTI4 255
LEI4 $639
line 1484
;1484:		ent->client->pers.cmdStackIndex = 0;//Loop commands
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 7796
ADDP4
CNSTI4 0
ASGNI4
LABELV $639
line 1487
;1485:
;1486:	//Copy the command to the stack.
;1487:	memcpy( &ent->client->pers.cmdStack[ent->client->pers.cmdStackIndex], cmd, sizeof(usercmd_t) );
ADDRLP4 8
CNSTI4 24
ASGNI4
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 7796
ADDP4
INDIRI4
MULI4
ADDRLP4 12
INDIRP4
CNSTI4 1652
ADDP4
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1488
;1488:}
LABELV $638
endproc StoreClientCommand 16 12
export RetrieveClientCommand
proc RetrieveClientCommand 60 12
line 1494
;1489:
;1490:/***************
;1491:RetrieveClientCommand
;1492:returns qtrue when it finds a command to be executed
;1493:***************/
;1494:qboolean RetrieveClientCommand(int clientNum, usercmd_t* cmd) {
line 1497
;1495:	int			i;
;1496://	int			j;
;1497:	int			count = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 1499
;1498:	gentity_t	*ent;
;1499:	usercmd_t	*tmpCmd = 0;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 1501
;1500:
;1501:	ent = g_entities + clientNum;//Client
ADDRLP4 4
CNSTI4 896
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1502
;1502:	i = ent->client->pers.cmdStackIndex;
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 7796
ADDP4
INDIRI4
ASGNI4
line 1503
;1503:	tmpCmd = &ent->client->pers.cmdStack[i];//Last executed command
ADDRLP4 8
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1652
ADDP4
ADDP4
ASGNP4
line 1507
;1504:
;1505:	
;1506:/**/
;1507:	if ( ent->r.svFlags & SVF_BOT || level.intermissiontime || ent->client->frameAimType == 0 || ent->client->frameAimType == 1  || ent->client->frameAimType == 3) {
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
ADDRLP4 20
INDIRI4
NEI4 $648
ADDRGP4 level+9160
INDIRI4
ADDRLP4 20
INDIRI4
NEI4 $648
ADDRLP4 24
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10388
ADDP4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $648
ADDRLP4 24
INDIRI4
CNSTI4 1
EQI4 $648
ADDRLP4 24
INDIRI4
CNSTI4 3
NEI4 $655
LABELV $648
line 1508
;1508:		if (tmpCmd && tmpCmd->serverTime) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $649
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $649
line 1510
;1509:			//Copy the current command to be executed
;1510:			memcpy( &ent->client->pers.cmd, tmpCmd, sizeof(usercmd_t) );
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 472
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 24
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1511
;1511:			memset( tmpCmd, 0, sizeof(usercmd_t) );//tmpCmd is no longer useful
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 24
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1513
;1512:
;1513:			if ( ent->client->frameAimType != 3 )
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10388
ADDP4
INDIRI4
CNSTI4 3
EQI4 $651
line 1514
;1514:				ent->client->hitClient = 0;//We're not using a client Hitscan so any value is useless
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10380
ADDP4
CNSTI4 0
ASGNI4
LABELV $651
line 1516
;1515:
;1516:			ent->client->lastCmdTime = level.time;//Set the command time to now because we ran now.
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10252
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 1517
;1517:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $641
JUMPV
LABELV $649
line 1519
;1518:		}
;1519:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $641
JUMPV
LABELV $654
line 1523
;1520:	}
;1521:/**/
;1522:
;1523:	while (tmpCmd && tmpCmd->serverTime) {
line 1524
;1524:		i--;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1525
;1525:		count++;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1526
;1526:		if (i < 0)
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $657
line 1527
;1527:			i = 255;
ADDRLP4 0
CNSTI4 255
ASGNI4
LABELV $657
line 1529
;1528:
;1529:		if (i == ent->client->pers.cmdStackIndex) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 7796
ADDP4
INDIRI4
NEI4 $659
line 1531
;1530:			//if we're at the stackIndex go to the next command
;1531:			i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1532
;1532:			if (i > 255) {
ADDRLP4 0
INDIRI4
CNSTI4 255
LEI4 $661
line 1533
;1533:				i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1534
;1534:			}
LABELV $661
line 1536
;1535:
;1536:			tmpCmd = &ent->client->pers.cmdStack[i];//Get the 'next' command
ADDRLP4 8
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1652
ADDP4
ADDP4
ASGNP4
line 1538
;1537:
;1538:			memcpy( &ent->client->pers.cmd, tmpCmd, sizeof(usercmd_t) );//Set the 'next' command to the current one executed
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 472
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 24
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1539
;1539:			memset( tmpCmd, 0, sizeof(usercmd_t) );
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 24
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1541
;1540:
;1541:			ent->client->hitClient = 0;//Reset the hitClient - we'll set it later [fixme: dunno why we couldn't do it now]
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10380
ADDP4
CNSTI4 0
ASGNI4
line 1543
;1542:
;1543:			ent->client->lastCmdTime = level.time;//Set the command time to now because we ran now.
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10252
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 1544
;1544:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $641
JUMPV
LABELV $659
line 1547
;1545:		}
;1546:
;1547:		tmpCmd = &ent->client->pers.cmdStack[i];
ADDRLP4 8
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1652
ADDP4
ADDP4
ASGNP4
line 1548
;1548:	} 
LABELV $655
line 1523
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $664
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $654
LABELV $664
line 1550
;1549:
;1550:	i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1551
;1551:	if (i > 255) {
ADDRLP4 0
INDIRI4
CNSTI4 255
LEI4 $665
line 1552
;1552:		i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1553
;1553:	}
LABELV $665
line 1555
;1554:
;1555:	tmpCmd = &ent->client->pers.cmdStack[i];
ADDRLP4 8
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 1652
ADDP4
ADDP4
ASGNP4
line 1557
;1556:
;1557:	if (tmpCmd && tmpCmd->serverTime) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $667
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $667
line 1558
;1558:		if (ent->r.svFlags & SVF_BOT || level.intermissiontime || ent->client->frameAimType == 0 || ent->client->frameAimType == 1 || ent->client->frameAimType == 3) {
ADDRLP4 40
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
ADDRLP4 40
INDIRI4
NEI4 $675
ADDRGP4 level+9160
INDIRI4
ADDRLP4 40
INDIRI4
NEI4 $675
ADDRLP4 44
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10388
ADDP4
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
ADDRLP4 40
INDIRI4
EQI4 $675
ADDRLP4 44
INDIRI4
CNSTI4 1
EQI4 $675
ADDRLP4 44
INDIRI4
CNSTI4 3
NEI4 $669
LABELV $675
line 1560
;1559:			//Copy the current command to be executed
;1560:			memcpy( &ent->client->pers.cmd, tmpCmd, sizeof(usercmd_t) );
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 472
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 24
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1561
;1561:			memset( tmpCmd, 0, sizeof(usercmd_t) );//tmpCmd is no longer useful
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 24
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1563
;1562:
;1563:			if ( ent->client->frameAimType != 3 )
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10388
ADDP4
INDIRI4
CNSTI4 3
EQI4 $676
line 1564
;1564:				ent->client->hitClient = 0;//We're not using a client Hitscan so any value is useless
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10380
ADDP4
CNSTI4 0
ASGNI4
LABELV $676
line 1566
;1565:
;1566:			ent->client->lastCmdTime = level.time;//Set the command time to now because we ran now.
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10252
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 1567
;1567:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $641
JUMPV
LABELV $669
line 1570
;1568:		}
;1569:
;1570:		if (ent->client->frameAimType == 2 || ent->client->lastCmdTime < level.time - 500 || ent->client->fixLockup > level.time - 500){
ADDRLP4 48
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 10388
ADDP4
INDIRI4
CNSTI4 2
EQI4 $684
ADDRLP4 52
CNSTI4 500
ASGNI4
ADDRLP4 48
INDIRP4
CNSTI4 10252
ADDP4
INDIRI4
ADDRGP4 level+40
INDIRI4
ADDRLP4 52
INDIRI4
SUBI4
LTI4 $684
ADDRLP4 48
INDIRP4
CNSTI4 10396
ADDP4
INDIRI4
ADDRGP4 level+40
INDIRI4
ADDRLP4 52
INDIRI4
SUBI4
LEI4 $679
LABELV $684
line 1571
;1571:			if (ent->client->lastCmdTime < level.time - 500) {
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10252
ADDP4
INDIRI4
ADDRGP4 level+40
INDIRI4
CNSTI4 500
SUBI4
GEI4 $685
line 1573
;1572:				//FIXME: What was this supposed to do?
;1573:				ent->client->fixLockup = level.time;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10396
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 1574
;1574:			}
LABELV $685
line 1577
;1575:
;1576:			//
;1577:			if (count > 1) {
ADDRLP4 12
INDIRI4
CNSTI4 1
LEI4 $689
line 1578
;1578:				i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1579
;1579:				if (i > 255)
ADDRLP4 0
INDIRI4
CNSTI4 255
LEI4 $691
line 1580
;1580:					i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $691
line 1583
;1581:
;1582:				//Set the hitCleint
;1583:				ent->client->hitClient = ent->client->pers.cmdStack[i].weapon;
ADDRLP4 56
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 10380
ADDP4
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 56
INDIRP4
CNSTI4 1652
ADDP4
ADDP4
CNSTI4 20
ADDP4
INDIRU1
CVUI4 1
ASGNI4
line 1585
;1584:
;1585:				tmpCmd->weapon = ent->client->weaponSwitch;
ADDRLP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10820
ADDP4
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 1587
;1586:
;1587:				memcpy( &ent->client->pers.cmd, tmpCmd, sizeof(usercmd_t) );
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 472
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 24
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1588
;1588:				memset( tmpCmd, 0, sizeof(usercmd_t) );
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 24
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1593
;1589:
;1590:
;1591:				// If we've gotten to this point, the client is either using aimType 2, or
;1592:				// we've been forced to use aimType 2 because it's too laggy to use aimType 3
;1593:				ent->client->frameAimType = 2;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10388
ADDP4
CNSTI4 2
ASGNI4
line 1594
;1594:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $641
JUMPV
LABELV $689
line 1595
;1595:			} else {
line 1596
;1596:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $641
JUMPV
LABELV $679
line 1600
;1597:			}
;1598:			/**/
;1599:		}
;1600:	}
LABELV $667
line 1602
;1601:	//Nothing worked out right
;1602:	return qfalse;
CNSTI4 0
RETI4
LABELV $641
endproc RetrieveClientCommand 60 12
export ClientThink
proc ClientThink 40 8
line 1612
;1603:}
;1604://Monkk
;1605:/*
;1606:==================
;1607:ClientThink
;1608:
;1609:A new command has arrived from the client
;1610:==================
;1611:*/
;1612:void ClientThink( int clientNum ) {
line 1616
;1613:	gentity_t *ent;
;1614:	usercmd_t	cmd;
;1615:
;1616:	ent = g_entities + clientNum;
ADDRLP4 0
CNSTI4 896
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1617
;1617:	if (!ent->client)
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $694
line 1618
;1618:		return;
ADDRGP4 $693
JUMPV
LABELV $694
line 1619
;1619:	trap_GetUsercmd( clientNum, &cmd );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_GetUsercmd
CALLV
pop
line 1621
;1620:
;1621:	ent->client->frameAimType = ent->client->sess.aimType;
ADDRLP4 28
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 10388
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 10224
ADDP4
INDIRI4
ASGNI4
line 1634
;1622:	
;1623:
;1624:	//ent->client->pers.targ_clientNum = (int)ent->client->pers.cmd.weapon;
;1625:	//ent->client->pers.last_EventTime = ent->client->pers.cmd.serverTime;
;1626:	//G_Printf("clientNum: %i -- clientNum + 1/: %i", (int)ent->client->pers.cmd.weapon - 1, (int)ent->client->pers.cmd.weapon + 2);
;1627:
;1628://unlagged - smooth clients #1
;1629:	// this is handled differently now
;1630:
;1631:	// mark the time we got info, so we can display the
;1632:	// phone jack if they don't get any for a while
;1633:	//if ( !g_unlaggedSmoothClients.integer ) {
;1634:	if ( g_smoothClients.integer != 2 ) {
ADDRGP4 g_smoothClients+12
INDIRI4
CNSTI4 2
EQI4 $696
line 1635
;1635:		ent->client->lastCmdTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10252
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 1636
;1636:	}
LABELV $696
line 1641
;1637:
;1638://unlagged - smooth clients #1
;1639:
;1640:	/**/
;1641:	StoreClientCommand( clientNum, &cmd );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 StoreClientCommand
CALLV
pop
line 1643
;1642:
;1643:	ent->client->frameAimType = ent->client->sess.aimType;
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 10388
ADDP4
ADDRLP4 32
INDIRP4
CNSTI4 10224
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $701
JUMPV
LABELV $700
line 1645
;1644:
;1645:	while (RetrieveClientCommand( clientNum, &cmd )) {
line 1646
;1646:		if ( !(ent->r.svFlags & SVF_BOT) && !g_synchronousClients.integer ) {
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
ADDRLP4 36
INDIRI4
NEI4 $703
ADDRGP4 g_synchronousClients+12
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $703
line 1648
;1647:
;1648:			ent->client->lastCmdTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10252
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 1652
;1649:
;1650:			//UnlinkUninteractibleEntities(ent);
;1651:
;1652:			ClientThink_real( ent, 0 );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 ClientThink_real
CALLV
pop
line 1656
;1653:
;1654:			//RelinkUninteractibleEntities();
;1655:			
;1656:		}
LABELV $703
line 1657
;1657:	}
LABELV $701
line 1645
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 36
ADDRGP4 RetrieveClientCommand
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $700
line 1676
;1658:	/** /
;1659:
;1660:	memcpy( &ent->client->pers.cmd, &cmd, sizeof(usercmd_t) );
;1661:
;1662:	if ( !(ent->r.svFlags & SVF_BOT) && !g_synchronousClients.integer ) 
;1663:	{
;1664:
;1665:		ent->client->lastCmdTime = level.time;
;1666:
;1667:		UnlinkUninteractibleEntities(ent);
;1668:
;1669:		ClientThink_real( ent, 0 );
;1670:
;1671:		RelinkUninteractibleEntities();
;1672:		
;1673:	}
;1674:
;1675:	/**/
;1676:}
LABELV $693
endproc ClientThink 40 8
export G_RunClient
proc G_RunClient 4 8
line 1679
;1677:
;1678:
;1679:void G_RunClient( gentity_t *ent ) {
line 1680
;1680:	if ( !(ent->r.svFlags & SVF_BOT) && !g_synchronousClients.integer ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
ADDRLP4 0
INDIRI4
NEI4 $708
ADDRGP4 g_synchronousClients+12
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $708
line 1681
;1681:		return;
ADDRGP4 $707
JUMPV
LABELV $708
line 1684
;1682:	}
;1683:	//UnlinkUninteractibleEntities(ent);
;1684:	ent->client->pers.cmd.serverTime = level.time;
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
line 1685
;1685:	ClientThink_real( ent, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 ClientThink_real
CALLV
pop
line 1687
;1686:	//RelinkUninteractibleEntities();
;1687:}
LABELV $707
endproc G_RunClient 4 8
export SpectatorClientEndFrame
proc SpectatorClientEndFrame 36 8
line 1696
;1688:
;1689:
;1690:/*
;1691:==================
;1692:SpectatorClientEndFrame
;1693:
;1694:==================
;1695:*/
;1696:void SpectatorClientEndFrame( gentity_t *ent ) {
line 1700
;1697:	gclient_t	*cl;
;1698:	int			ping;
;1699:
;1700:	if ( gameSettings.ping_fix ) {
ADDRGP4 gameSettings+4
INDIRI4
CNSTI4 0
EQI4 $713
line 1701
;1701:		ping = ent->client->ps.ping;//new!!
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
ASGNI4
line 1702
;1702:	}
LABELV $713
line 1704
;1703:	// if we are doing a chase cam or a remote view, grab the latest info
;1704:	if ( ent->client->sess.spectatorState == SPECTATOR_FOLLOW ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10196
ADDP4
INDIRI4
CNSTI4 2
NEI4 $716
line 1707
;1705:		int		clientNum, flags;
;1706:
;1707:		clientNum = ent->client->sess.spectatorClient;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10200
ADDP4
INDIRI4
ASGNI4
line 1710
;1708:
;1709:		// team follow1 and team follow2 go to whatever clients are playing
;1710:		if ( clientNum == -1 ) {
ADDRLP4 8
INDIRI4
CNSTI4 -1
NEI4 $718
line 1711
;1711:			clientNum = level.follow1;
ADDRLP4 8
ADDRGP4 level+380
INDIRI4
ASGNI4
line 1712
;1712:		} else if ( clientNum == -2 ) {
ADDRGP4 $719
JUMPV
LABELV $718
ADDRLP4 8
INDIRI4
CNSTI4 -2
NEI4 $721
line 1713
;1713:			clientNum = level.follow2;
ADDRLP4 8
ADDRGP4 level+384
INDIRI4
ASGNI4
line 1714
;1714:		}
LABELV $721
LABELV $719
line 1715
;1715:		if ( clientNum >= 0 ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $724
line 1717
;1716:
;1717:			ent->client->pers.stats_specnum = clientNum + 1; // Lucron: specspy
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10064
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1719
;1718:
;1719:			cl = &level.clients[ clientNum ];
ADDRLP4 0
CNSTI4 10828
ADDRLP4 8
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 1723
;1720:/*freeze
;1721:			if ( cl->pers.connected == CON_CONNECTED && cl->sess.sessionTeam != TEAM_SPECTATOR ) {
;1722:freeze*/
;1723:			if ( (g_gamemode.integer > 3 && cl->pers.connected == CON_CONNECTED && !is_spectator( cl )) || 
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $732
ADDRLP4 16
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $732
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
EQI4 $730
LABELV $732
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 4
GEI4 $726
ADDRLP4 24
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $726
ADDRLP4 24
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
CNSTI4 3
EQI4 $726
LABELV $730
line 1724
;1724:				(g_gamemode.integer < 4 && cl->pers.connected == CON_CONNECTED && cl->sess.sessionTeam != TEAM_SPECTATOR) ) {
line 1726
;1725://freeze
;1726:				flags = (cl->ps.eFlags & ~(EF_VOTED | EF_TEAMVOTED)) | (ent->client->ps.eFlags & (EF_VOTED | EF_TEAMVOTED));
ADDRLP4 28
CNSTI4 104
ASGNI4
ADDRLP4 12
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
CNSTI4 -540673
BANDI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
CNSTI4 540672
BANDI4
BORI4
ASGNI4
line 1731
;1727:				//cl->pers.realPing = cl->ps.ping;
;1728:				//ent->client->pers.realPing = ent->client->ps.ping;
;1729:				//G_Printf("%i %i", ent->client->pers.realPing, ent->client->ps.ping);
;1730:/*freeze*/
;1731:				if ( g_gamemode.integer < 4 ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 4
GEI4 $733
line 1732
;1732:				ent->client->ps = cl->ps;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ADDRLP4 0
INDIRP4
INDIRB
ASGNB 468
line 1733
;1733:				/*freeze*/		} else {
ADDRGP4 $734
JUMPV
LABELV $733
line 1734
;1734:				Persistant_spectator( ent, cl );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Persistant_spectator
CALLV
pop
line 1735
;1735:				}
LABELV $734
line 1738
;1736://freeze
;1737:				//G_Printf("%i %i", ent->client->pers.realPing, ent->client->ps.ping);
;1738:				if ( gameSettings.ping_fix ) {
ADDRGP4 gameSettings+4
INDIRI4
CNSTI4 0
EQI4 $736
line 1739
;1739:					ent->client->ps.ping = ping;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 452
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 1740
;1740:				}
LABELV $736
line 1741
;1741:				ent->client->ps.pm_flags |= PMF_FOLLOW;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
line 1742
;1742:				ent->client->ps.eFlags = flags;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1743
;1743:				return;
ADDRGP4 $712
JUMPV
LABELV $726
line 1744
;1744:			} else {
line 1746
;1745:				// drop them to free spectators unless they are dedicated camera followers
;1746:				if ( ent->client->sess.spectatorClient >= 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10200
ADDP4
INDIRI4
CNSTI4 0
LTI4 $725
line 1747
;1747:					/*freeze*/	if ( g_gamemode.integer < 4 ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 4
GEI4 $741
line 1748
;1748:					ent->client->sess.spectatorState = SPECTATOR_FREE;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10196
ADDP4
CNSTI4 1
ASGNI4
line 1749
;1749:					ClientBegin( ent->client - level.clients );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
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
ADDRGP4 ClientBegin
CALLV
pop
line 1750
;1750:					/*freeze*/} else {
ADDRGP4 $725
JUMPV
LABELV $741
line 1751
;1751:					StopFollowing( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 StopFollowing
CALLV
pop
line 1752
;1752:					}
line 1754
;1753://freeze
;1754:				}
line 1755
;1755:			}
line 1756
;1756:		} else {
ADDRGP4 $725
JUMPV
LABELV $724
line 1757
;1757:			ent->client->pers.stats_specnum = 0; //Lucron: specspy
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10064
ADDP4
CNSTI4 0
ASGNI4
line 1758
;1758:		}
LABELV $725
line 1760
;1759:
;1760:	}
LABELV $716
line 1762
;1761:
;1762:	if ( ent->client->sess.spectatorState == SPECTATOR_SCOREBOARD ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10196
ADDP4
INDIRI4
CNSTI4 3
NEI4 $744
line 1763
;1763:		ent->client->ps.pm_flags |= PMF_SCOREBOARD;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 8192
BORI4
ASGNI4
line 1764
;1764:	} else {
ADDRGP4 $745
JUMPV
LABELV $744
line 1765
;1765:		ent->client->ps.pm_flags &= ~PMF_SCOREBOARD;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -8193
BANDI4
ASGNI4
line 1766
;1766:	}
LABELV $745
line 1768
;1767:	//ent->client->ps.ping = ping;
;1768:}
LABELV $712
endproc SpectatorClientEndFrame 36 8
export ClientEndFrame
proc ClientEndFrame 76 16
line 1779
;1769:
;1770:/*
;1771:==============
;1772:ClientEndFrame
;1773:
;1774:Called at the end of each server frame for each connected client
;1775:A fast client will have multiple ClientThink for each ClientEndFrame,
;1776:while a slow client may have multiple ClientEndFrame between ClientThink.
;1777:==============
;1778:*/
;1779:void ClientEndFrame( gentity_t *ent ) {
line 1792
;1780:	int			i;
;1781:	int			clientCmdTime;
;1782:	clientPersistant_t	*pers;
;1783:	usercmd_t	cmd;
;1784:
;1785://unlagged - smooth clients #1
;1786:	int frames;
;1787://unlagged - smooth clients #1
;1788:
;1789:/*freeze
;1790:	if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
;1791:freeze*/
;1792:	ent->client->pers.stats_specnum = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10064
ADDP4
CNSTI4 0
ASGNI4
line 1793
;1793:	if ( ( g_gamemode.integer > 3 && is_spectator( ent->client ) ) || 
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $752
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 is_spectator
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $751
LABELV $752
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 4
GEI4 $747
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
CNSTI4 3
NEI4 $747
LABELV $751
line 1794
;1794:		( g_gamemode.integer < 4 && ent->client->sess.sessionTeam == TEAM_SPECTATOR )) {
line 1796
;1795://freeze
;1796:		SpectatorClientEndFrame( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 SpectatorClientEndFrame
CALLV
pop
line 1797
;1797:		return;
ADDRGP4 $746
JUMPV
LABELV $747
line 1800
;1798:	}
;1799:
;1800:	pers = &ent->client->pers;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
ASGNP4
line 1803
;1801:
;1802:	// turn off any expired powerups
;1803:	for ( i = 0 ; i < MAX_POWERUPS ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $753
line 1805
;1804:		// Make sure we dont let stuff like CTF flags expire.
;1805:		if(level.match_timeout == 1 && ent->client->ps.powerups[i] != INT_MAX) {
ADDRGP4 level+10800
INDIRU1
CVUI4 1
CNSTI4 1
NEI4 $757
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
CNSTI4 2147483647
EQI4 $757
line 1806
;1806:				ent->client->ps.powerups[i] += level.time - level.previousTime;
ADDRLP4 44
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
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
ADDRGP4 level+40
INDIRI4
ADDRGP4 level+44
INDIRI4
SUBI4
ADDI4
ASGNI4
line 1807
;1807:		}
LABELV $757
line 1809
;1808:
;1809:		if ( ent->client->ps.powerups[ i ] < level.time ) {
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
GEI4 $762
line 1810
;1810:			ent->client->ps.powerups[ i ] = 0;
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
CNSTI4 0
ASGNI4
line 1811
;1811:		}
LABELV $762
line 1812
;1812:	}
LABELV $754
line 1803
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $753
line 1833
;1813:
;1814:#ifdef MISSIONPACK
;1815:	// set powerup for player animation
;1816:	if( bg_itemlist[ent->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_GUARD ) {
;1817:		ent->client->ps.powerups[PW_GUARD] = level.time;
;1818:	}
;1819:	if( bg_itemlist[ent->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_SCOUT ) {
;1820:		ent->client->ps.powerups[PW_SCOUT] = level.time;
;1821:	}
;1822:	if( bg_itemlist[ent->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_DOUBLER ) {
;1823:		ent->client->ps.powerups[PW_DOUBLER] = level.time;
;1824:	}
;1825:	if( bg_itemlist[ent->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_AMMOREGEN ) {
;1826:		ent->client->ps.powerups[PW_AMMOREGEN] = level.time;
;1827:	}
;1828:	if ( ent->client->invulnerabilityTime > level.time ) {
;1829:		ent->client->ps.powerups[PW_INVULNERABILITY] = level.time;
;1830:	}
;1831:#endif
;1832:
;1833:		if(level.match_timeout == 1) {
ADDRGP4 level+10800
INDIRU1
CVUI4 1
CNSTI4 1
NEI4 $765
line 1834
;1834:			int time_delta = level.time - level.previousTime;
ADDRLP4 44
ADDRGP4 level+40
INDIRI4
ADDRGP4 level+44
INDIRI4
SUBI4
ASGNI4
line 1836
;1835:
;1836:			ent->client->airOutTime += time_delta;
ADDRLP4 48
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10348
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
ADDRLP4 44
INDIRI4
ADDI4
ASGNI4
line 1837
;1837:			ent->client->inactivityTime += time_delta;
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10336
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
ADDRLP4 44
INDIRI4
ADDI4
ASGNI4
line 1839
;1838:		//	ent->client->pers.connected += time_delta;
;1839:			ent->client->pers.enterTime += time_delta;
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 556
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
ADDRLP4 44
INDIRI4
ADDI4
ASGNI4
line 1840
;1840:			ent->client->pers.teamState.lastreturnedflag += time_delta;
ADDRLP4 60
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 596
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
ADDRLP4 44
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1841
;1841:			ent->client->pers.teamState.lasthurtcarrier += time_delta;
ADDRLP4 64
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 592
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRF4
ADDRLP4 44
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1842
;1842:			ent->client->pers.teamState.lastfraggedcarrier += time_delta;
ADDRLP4 68
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 604
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRF4
ADDRLP4 44
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1843
;1843:			ent->pain_debounce_time += time_delta;
ADDRLP4 72
ADDRFP4 0
INDIRP4
CNSTI4 720
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
ADDRLP4 44
INDIRI4
ADDI4
ASGNI4
line 1845
;1844:
;1845:		}
LABELV $765
line 1859
;1846:
;1847:	// save network bandwidth
;1848:#if 0
;1849:	if ( !g_synchronousClients->integer && ent->client->ps.pm_type == PM_NORMAL ) {
;1850:		// FIXME: this must change eventually for non-sync demo recording
;1851:		VectorClear( ent->client->ps.viewangles );
;1852:	}
;1853:#endif
;1854:
;1855:	//
;1856:	// If the end of unit layout is displayed, don't give
;1857:	// the player any normal movement attributes
;1858:	//
;1859:	if ( level.intermissiontime ) {
ADDRGP4 level+9160
INDIRI4
CNSTI4 0
EQI4 $770
line 1860
;1860:		return;
ADDRGP4 $746
JUMPV
LABELV $770
line 1865
;1861:	}
;1862:
;1863://unlagged - smooth clients #1
;1864:	// see how many frames the client has missed
;1865:	frames = level.framenum - ent->client->lastUpdateFrame - 1;
ADDRLP4 28
ADDRGP4 level+36
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10812
ADDP4
INDIRI4
SUBI4
CNSTI4 1
SUBI4
ASGNI4
line 1868
;1866:
;1867:	// don't extrapolate more than two frames
;1868:	if ( frames > 4 ) {
ADDRLP4 28
INDIRI4
CNSTI4 4
LEI4 $774
line 1869
;1869:		ent->client->frameAimType = 1;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10388
ADDP4
CNSTI4 1
ASGNI4
line 1870
;1870:		clientCmdTime = ent->client->lastCmdTime;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10252
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $777
JUMPV
LABELV $776
line 1872
;1871:
;1872:		while (RetrieveClientCommand( ent->client->ps.clientNum, &cmd )) {
line 1873
;1873:			if ( !(ent->r.svFlags & SVF_BOT) && !g_synchronousClients.integer ) {
ADDRLP4 44
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
ADDRLP4 44
INDIRI4
NEI4 $779
ADDRGP4 g_synchronousClients+12
INDIRI4
ADDRLP4 44
INDIRI4
NEI4 $779
line 1875
;1874:				//UnlinkUninteractibleEntities(ent);
;1875:				ClientThink_real( ent, 1 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 ClientThink_real
CALLV
pop
line 1877
;1876:				//RelinkUninteractibleEntities();
;1877:			}
LABELV $779
line 1878
;1878:		}
LABELV $777
line 1872
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 44
ADDRGP4 RetrieveClientCommand
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $776
line 1880
;1879:		//cmd.weapon = ent->client->weaponSwitch;//trial
;1880:		ent->client->lastCmdTime = clientCmdTime;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10252
ADDP4
ADDRLP4 32
INDIRI4
ASGNI4
line 1881
;1881:	}
LABELV $774
line 1883
;1882:
;1883:	if(level.match_timeout == 0) {
ADDRGP4 level+10800
INDIRU1
CVUI4 1
CNSTI4 0
NEI4 $782
line 1885
;1884:		// burn from lava, etc
;1885:		P_WorldEffects (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 P_WorldEffects
CALLV
pop
line 1888
;1886:
;1887:		// apply all the damage taken this frame
;1888:		P_DamageFeedback (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 P_DamageFeedback
CALLV
pop
line 1889
;1889:	}
LABELV $782
line 1892
;1890:
;1891:	// add the EF_CONNECTION flag if we haven't gotten commands recently
;1892:	if ( g_smoothClients.integer != 2 ) {
ADDRGP4 g_smoothClients+12
INDIRI4
CNSTI4 2
EQI4 $785
line 1893
;1893:		if ( level.time - ent->client->lastCmdTime > 1000 ) {
ADDRGP4 level+40
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10252
ADDP4
INDIRI4
SUBI4
CNSTI4 1000
LEI4 $788
line 1894
;1894:			ent->s.eFlags |= EF_CONNECTION;
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
CNSTI4 8192
BORI4
ASGNI4
line 1895
;1895:		} else {
ADDRGP4 $789
JUMPV
LABELV $788
line 1896
;1896:			ent->s.eFlags &= ~EF_CONNECTION;
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
CNSTI4 -8193
BANDI4
ASGNI4
line 1897
;1897:		}
LABELV $789
line 1898
;1898:	}
LABELV $785
line 1900
;1899:
;1900:	ent->client->ps.stats[STAT_HEALTH] = ent->health;	// FIXME: get rid of ent->health...
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 44
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
ASGNI4
line 1902
;1901:
;1902:	G_SetClientSound (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_SetClientSound
CALLV
pop
line 1911
;1903:
;1904:	// set the latest information
;1905://unlagged - smooth clients #2
;1906:	// clients no longer do extrapolation if cg_smoothClients is 1, because
;1907:	// skip correction is all handled server-side now
;1908:	// since that's the case, it makes no sense to store the extra info
;1909:	// in the client's snapshot entity, so let's save a little bandwidth
;1910:
;1911:	if (g_smoothClients.integer == 1) {
ADDRGP4 g_smoothClients+12
INDIRI4
CNSTI4 1
NEI4 $791
line 1912
;1912:		BG_PlayerStateToEntityStateExtraPolate( &ent->client->ps, &ent->s, ent->client->ps.commandTime, qtrue );
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
ADDRLP4 48
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRLP4 52
INDIRP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BG_PlayerStateToEntityStateExtraPolate
CALLV
pop
line 1913
;1913:	} else {
ADDRGP4 $792
JUMPV
LABELV $791
line 1914
;1914:		BG_PlayerStateToEntityState( &ent->client->ps, &ent->s, qtrue );
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 1915
;1915:	}
LABELV $792
line 1918
;1916://unlagged - smooth clients #2
;1917:
;1918:	SendPendingPredictableEvents( &ent->client->ps );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRGP4 SendPendingPredictableEvents
CALLV
pop
line 1920
;1919:
;1920:	if ( ent->client->lastUpdateFrame != 0 && frames > 400 && ent->client->ps.ping >= 999 ) {
ADDRLP4 48
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 10812
ADDP4
INDIRI4
CNSTI4 0
EQI4 $794
ADDRLP4 28
INDIRI4
CNSTI4 400
LEI4 $794
ADDRLP4 48
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
CNSTI4 999
LTI4 $794
line 1921
;1921:		trap_DropClient( ent->client->ps.clientNum, "No packet flow." );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRGP4 $796
ARGP4
ADDRGP4 trap_DropClient
CALLV
pop
line 1922
;1922:		return;
ADDRGP4 $746
JUMPV
LABELV $794
line 1926
;1923:	}
;1924://unlagged - smooth clients #1
;1925:	//if ( g_unlaggedSmoothClients.integer ) {
;1926:	if ( g_smoothClients.integer == 2 ) {
ADDRGP4 g_smoothClients+12
INDIRI4
CNSTI4 2
NEI4 $797
line 1928
;1927:		// mark as not missing updates initially
;1928:		ent->client->ps.eFlags &= ~EF_CONNECTION;
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTI4 -8193
BANDI4
ASGNI4
line 1931
;1929:
;1930:		// see how many frames the client has missed
;1931:		frames = level.framenum - ent->client->lastUpdateFrame - 1;
ADDRLP4 28
ADDRGP4 level+36
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10812
ADDP4
INDIRI4
SUBI4
CNSTI4 1
SUBI4
ASGNI4
line 1934
;1932:
;1933:		// don't extrapolate more than two frames
;1934:		if ( frames > 4 ) {
ADDRLP4 28
INDIRI4
CNSTI4 4
LEI4 $801
line 1935
;1935:			frames = 4;
ADDRLP4 28
CNSTI4 4
ASGNI4
line 1938
;1936:
;1937:			// if they missed more than two in a row, show the phone jack
;1938:			ent->client->ps.eFlags |= EF_CONNECTION;
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 8192
BORI4
ASGNI4
line 1939
;1939:			ent->s.eFlags |= EF_CONNECTION;
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
CNSTI4 8192
BORI4
ASGNI4
line 1940
;1940:		}
LABELV $801
line 1943
;1941:
;1942:		// did the client miss any frames?
;1943:		if ( frames > 0 && g_smoothClients.integer ) {
ADDRLP4 56
CNSTI4 0
ASGNI4
ADDRLP4 28
INDIRI4
ADDRLP4 56
INDIRI4
LEI4 $803
ADDRGP4 g_smoothClients+12
INDIRI4
ADDRLP4 56
INDIRI4
EQI4 $803
line 1945
;1944:			// yep, missed one or more, so extrapolate the player's movement
;1945:			G_PredictPlayerMove( ent, (float)frames / sv_fps.integer );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
INDIRI4
CVIF4 4
ADDRGP4 sv_fps+12
INDIRI4
CVIF4 4
DIVF4
ARGF4
ADDRGP4 G_PredictPlayerMove
CALLV
pop
line 1947
;1946:			// save network bandwidth
;1947:			SnapVector( ent->s.pos.trBase );
ADDRLP4 60
ADDRFP4 0
INDIRP4
CNSTI4 24
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
ADDRLP4 64
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 68
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 1948
;1948:		}
LABELV $803
line 1949
;1949:	}
LABELV $797
line 1953
;1950://unlagged - smooth clients #1
;1951://unlagged - backward reconciliation #1
;1952:	// store the client's position for backward reconciliation later
;1953:	G_StoreHistory( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_StoreHistory
CALLV
pop
line 1960
;1954://unlagged - backward reconciliation #1
;1955:
;1956:	// set the bit for the reachability area the client is currently in
;1957://	i = trap_AAS_PointReachabilityAreaIndex( ent->client->ps.origin );
;1958://	ent->client->areabits[i >> 3] |= 1 << (i & 7);
;1959:
;1960:}
LABELV $746
endproc ClientEndFrame 76 16
export GetClientMask
proc GetClientMask 12 0
line 2070
;1961:/*
;1962:int G_AllowEntityInteraction(gentity_t *client, gentity_t *ent)
;1963:{
;1964:	int clientNum1 = -1;
;1965:	int clientNum2 = -1;
;1966:	gentity_t *ent1;
;1967:	gentity_t *ent2;
;1968:
;1969:	//int debug = 0;
;1970:
;1971:	//return 1;
;1972:
;1973:	if (!client || !ent)
;1974:		return 0;
;1975:
;1976:
;1977:	if (client->client)
;1978:	{
;1979:		clientNum1 = client->s.number;
;1980:
;1981:	}
;1982:	if (clientNum1 < 0 || clientNum1 >= MAX_CLIENTS)
;1983:	{
;1984:		if (client->parent && client->parent->client)
;1985:		{
;1986:			clientNum1 = client->parent->client->ps.clientNum;
;1987:		}
;1988:	}
;1989:	if (clientNum1 < 0 || clientNum1 >= MAX_CLIENTS)
;1990:	{
;1991:		return 1;
;1992:	}
;1993:
;1994:
;1995:
;1996:	if (ent->client)
;1997:	{
;1998:		clientNum2 = ent->s.number;
;1999:	}
;2000:	if (clientNum2 < 0 || clientNum2 >= MAX_CLIENTS)
;2001:	{
;2002:		if (ent->parent && ent->parent->client)
;2003:		{
;2004:			clientNum2 = ent->parent->client->ps.clientNum;
;2005:		}
;2006:	}
;2007:
;2008:	if (clientNum2 < 0 || clientNum2 >= MAX_CLIENTS)
;2009:	{
;2010:		return 1;
;2011:	}
;2012:
;2013:
;2014:	ent1 = &g_entities[ clientNum1 ];
;2015:	ent2 = &g_entities[ clientNum2 ];
;2016:
;2017:	if (!ent1->client)
;2018:		return 1;
;2019:	if (!ent2->client)
;2020:		return 1;
;2021:
;2022:
;2023:	
;2024:	if (ent1->client->pers.connected != CON_CONNECTED)
;2025:		return 0;
;2026:
;2027:	if (ent2->client->pers.connected != CON_CONNECTED)
;2028:		return 0;
;2029:	
;2030:
;2031:
;2032:	if (clientNum1 == clientNum2)
;2033:		return 1;
;2034:
;2035:
;2036:	
;2037:
;2038:
;2039:	if (ent1->client->sess.sessionTeam == TEAM_SPECTATOR || ent2->client->sess.sessionTeam == TEAM_SPECTATOR)
;2040:	{
;2041:		return 0;
;2042:	}*/
;2043:
;2044:
;2045:/*	if (ent1->client->sess.sessionTeam == TEAM_WARMUP)
;2046:	{
;2047:		if (ent2->client->sess.sessionTeam != TEAM_WARMUP)
;2048:			return 0;
;2049:	}
;2050:
;2051:	if (ent2->client->sess.sessionTeam == TEAM_WARMUP)
;2052:	{
;2053:		if (ent1->client->sess.sessionTeam != TEAM_WARMUP)
;2054:			return 0;
;2055:	}*/
;2056:/*
;2057:	return 1;
;2058:}
;2059:
;2060:
;2061:
;2062:int G_TestCanTouchEnt( int clientNum, int entityNum )
;2063:{
;2064:
;2065:	return G_AllowEntityInteraction ( &g_entities[ clientNum ], &g_entities[ entityNum ] );
;2066:}*/
;2067:
;2068:
;2069:int GetClientMask( team_t team )
;2070:{
line 2075
;2071:	int				i;
;2072:	int				mask;
;2073:	gentity_t		*ent;
;2074:
;2075:	mask = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2077
;2076:
;2077:	for (i = 0; i < 32; i++)
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $808
line 2078
;2078:	{
line 2079
;2079:		ent = &g_entities[i];
ADDRLP4 0
CNSTI4 896
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 2081
;2080:
;2081:		if (!ent)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $812
line 2082
;2082:			continue;
ADDRGP4 $809
JUMPV
LABELV $812
line 2083
;2083:		if (!ent->client)
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $814
line 2084
;2084:			continue;
ADDRGP4 $809
JUMPV
LABELV $814
line 2103
;2085:		//if (ent->client->pers.connected != CON_CONNECTED)
;2086:		//	continue;
;2087:
;2088:					
;2089:
;2090:/*		if (team == TEAM_WARMUP)
;2091:		{
;2092:			if (ent->client->sess.sessionTeam != TEAM_WARMUP)
;2093:				continue;
;2094:		}
;2095:		else 
;2096:		{
;2097:			if (ent->client->sess.sessionTeam == TEAM_WARMUP)
;2098:				continue;
;2099:		}*/
;2100:
;2101:		//trap_SendServerCommandC( i, va("print \"%i\n\"", i) );
;2102:
;2103:		mask |= (1 << ent->client->ps.clientNum);
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
LSHI4
BORI4
ASGNI4
line 2105
;2104:		//mask |= (1 << i);
;2105:	}
LABELV $809
line 2077
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 32
LTI4 $808
line 2107
;2106:
;2107:	return mask;
ADDRLP4 8
INDIRI4
RETI4
LABELV $807
endproc GetClientMask 12 0
export GetClientMaskExclude
proc GetClientMaskExclude 12 0
line 2112
;2108:}
;2109:
;2110:
;2111:int GetClientMaskExclude( team_t team, int exclude )
;2112:{
line 2117
;2113:	int				i;
;2114:	int				mask;
;2115:	gentity_t		*ent;
;2116:
;2117:	mask = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2119
;2118:
;2119:	for (i = 0; i < 32; i++)
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $817
line 2120
;2120:	{
line 2121
;2121:		ent = &g_entities[i];
ADDRLP4 0
CNSTI4 896
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 2123
;2122:
;2123:		if (!ent)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $821
line 2124
;2124:			continue;
ADDRGP4 $818
JUMPV
LABELV $821
line 2125
;2125:		if (!ent->client)
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $823
line 2126
;2126:			continue;
ADDRGP4 $818
JUMPV
LABELV $823
line 2129
;2127:		//if (ent->client->pers.connected != CON_CONNECTED)
;2128:		//	continue;
;2129:		if (ent->client->ps.clientNum == exclude)
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $825
line 2130
;2130:			continue;
ADDRGP4 $818
JUMPV
LABELV $825
line 2143
;2131:/*		if (team == TEAM_WARMUP)
;2132:		{
;2133:			if (ent->client->sess.sessionTeam != TEAM_WARMUP)
;2134:				continue;
;2135:		}
;2136:		else 
;2137:		{
;2138:			if (ent->client->sess.sessionTeam == TEAM_WARMUP)
;2139:				continue;
;2140:		}*/
;2141:
;2142:
;2143:		mask |= (1 << ent->client->ps.clientNum);
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
LSHI4
BORI4
ASGNI4
line 2144
;2144:	}
LABELV $818
line 2119
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 32
LTI4 $817
line 2146
;2145:
;2146:	return mask;
ADDRLP4 8
INDIRI4
RETI4
LABELV $816
endproc GetClientMaskExclude 12 0
import BotTestSolid
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
import NoDropAreaBelow
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
LABELV $796
byte 1 78
byte 1 111
byte 1 32
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 32
byte 1 102
byte 1 108
byte 1 111
byte 1 119
byte 1 46
byte 1 0
align 1
LABELV $637
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 116
byte 1 97
byte 1 107
byte 1 101
byte 1 110
byte 1 95
byte 1 111
byte 1 112
byte 1 112
byte 1 111
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 95
byte 1 48
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $601
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $597
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $590
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $589
byte 1 37
byte 1 115
byte 1 32
byte 1 94
byte 1 51
byte 1 110
byte 1 101
byte 1 97
byte 1 114
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $585
byte 1 94
byte 1 51
byte 1 45
byte 1 45
byte 1 85
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $584
byte 1 32
byte 1 94
byte 1 51
byte 1 45
byte 1 45
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $583
byte 1 32
byte 1 94
byte 1 51
byte 1 83
byte 1 65
byte 1 67
byte 1 82
byte 1 73
byte 1 70
byte 1 73
byte 1 67
byte 1 69
byte 1 68
byte 1 32
byte 1 110
byte 1 101
byte 1 97
byte 1 114
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $582
byte 1 32
byte 1 94
byte 1 51
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 83
byte 1 65
byte 1 67
byte 1 82
byte 1 73
byte 1 70
byte 1 73
byte 1 67
byte 1 69
byte 1 68
byte 1 32
byte 1 98
byte 1 121
byte 1 58
byte 1 32
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $581
byte 1 94
byte 1 54
byte 1 85
byte 1 78
byte 1 75
byte 1 78
byte 1 79
byte 1 87
byte 1 78
byte 1 63
byte 1 33
byte 1 63
byte 1 32
byte 1 70
byte 1 76
byte 1 65
byte 1 71
byte 1 0
align 1
LABELV $580
byte 1 94
byte 1 55
byte 1 78
byte 1 69
byte 1 85
byte 1 84
byte 1 82
byte 1 65
byte 1 76
byte 1 32
byte 1 70
byte 1 76
byte 1 65
byte 1 71
byte 1 0
align 1
LABELV $579
byte 1 94
byte 1 49
byte 1 82
byte 1 69
byte 1 68
byte 1 32
byte 1 70
byte 1 76
byte 1 65
byte 1 71
byte 1 0
align 1
LABELV $578
byte 1 94
byte 1 52
byte 1 66
byte 1 76
byte 1 85
byte 1 69
byte 1 32
byte 1 70
byte 1 76
byte 1 65
byte 1 71
byte 1 0
align 1
LABELV $577
byte 1 34
byte 1 94
byte 1 51
byte 1 45
byte 1 45
byte 1 32
byte 1 0
align 1
LABELV $576
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 94
byte 1 49
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 58
byte 1 32
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 76
byte 1 75
byte 1 71
byte 1 32
byte 1 100
byte 1 101
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 46
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 10
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $569
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 94
byte 1 49
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 58
byte 1 32
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 76
byte 1 75
byte 1 71
byte 1 44
byte 1 32
byte 1 97
byte 1 116
byte 1 116
byte 1 101
byte 1 109
byte 1 112
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 97
byte 1 114
byte 1 121
byte 1 46
byte 1 10
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $551
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 116
byte 1 114
byte 1 97
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $550
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 114
byte 1 111
byte 1 116
byte 1 97
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $549
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $548
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 112
byte 1 101
byte 1 110
byte 1 100
byte 1 117
byte 1 108
byte 1 117
byte 1 109
byte 1 0
align 1
LABELV $547
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $546
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 98
byte 1 111
byte 1 98
byte 1 98
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $400
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 33
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $395
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 33
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 109
byte 1 97
byte 1 105
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $381
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 34
byte 1 0
align 1
LABELV $352
byte 1 51
byte 1 51
byte 1 0
align 1
LABELV $348
byte 1 56
byte 1 0
align 1
LABELV $347
byte 1 112
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 95
byte 1 109
byte 1 115
byte 1 101
byte 1 99
byte 1 0
align 1
LABELV $316
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
LABELV $241
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 84
byte 1 101
byte 1 110
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 115
byte 1 32
byte 1 117
byte 1 110
byte 1 116
byte 1 105
byte 1 108
byte 1 32
byte 1 105
byte 1 110
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 33
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $237
byte 1 115
byte 1 0
align 1
LABELV $107
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
byte 1 103
byte 1 117
byte 1 114
byte 1 112
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $106
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
byte 1 103
byte 1 117
byte 1 114
byte 1 112
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $103
byte 1 42
byte 1 100
byte 1 114
byte 1 111
byte 1 119
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
