export CG_CheckAmmo
code
proc CG_CheckAmmo 20 8
file "../cg_playerstate.c"
line 18
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_playerstate.c -- this file acts on changes in a new playerState_t
;4:// With normal play, this will be done after local prediction, but when
;5:// following another player or playing back a demo, it will be checked
;6:// when the snapshot transitions like all the other entities
;7:
;8:#include "cg_local.h"
;9:#include "../game/bg_promode.h"
;10:
;11:/*
;12:==============
;13:CG_CheckAmmo
;14:
;15:If the ammo has gone low enough to generate the warning, play a sound
;16:==============
;17:*/
;18:void CG_CheckAmmo( void ) {
line 25
;19:	int		i;
;20:	int		total;
;21:	int		previous;
;22:	int		weapons;
;23:
;24:	// see about how many seconds of ammo we have remaining
;25:	weapons = cg.snap->ps.stats[ STAT_WEAPONS ];
ADDRLP4 8
ADDRGP4 cg+36
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
ASGNI4
line 26
;26:	total = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 27
;27:	for ( i = WP_MACHINEGUN ; i < WP_NUM_WEAPONS ; i++ ) {
ADDRLP4 0
CNSTI4 2
ASGNI4
LABELV $79
line 28
;28:		if ( ! ( weapons & ( 1 << i ) ) ) {
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
NEI4 $83
line 29
;29:			continue;
ADDRGP4 $80
JUMPV
LABELV $83
line 31
;30:		}
;31:		switch ( i ) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $85
ADDRLP4 0
INDIRI4
CNSTI4 7
GTI4 $85
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $90-12
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $90
address $87
address $87
address $87
address $85
address $87
code
LABELV $87
line 39
;32:		case WP_ROCKET_LAUNCHER:
;33:		case WP_GRENADE_LAUNCHER:
;34:		case WP_RAILGUN:
;35:		case WP_SHOTGUN:
;36:#ifdef MISSIONPACK
;37:		case WP_PROX_LAUNCHER:
;38:#endif
;39:			total += cg.snap->ps.ammo[i] * 1000;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1000
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 420
ADDP4
ADDP4
INDIRI4
MULI4
ADDI4
ASGNI4
line 40
;40:			break;
ADDRGP4 $86
JUMPV
LABELV $85
line 42
;41:		default:
;42:			total += cg.snap->ps.ammo[i] * 200;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 200
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 420
ADDP4
ADDP4
INDIRI4
MULI4
ADDI4
ASGNI4
line 43
;43:			break;
LABELV $86
line 45
;44:		}
;45:		if ( total >= 5000 ) {
ADDRLP4 4
INDIRI4
CNSTI4 5000
LTI4 $92
line 46
;46:			cg.lowAmmoWarning = 0;
ADDRGP4 cg+130540
CNSTI4 0
ASGNI4
line 47
;47:			return;
ADDRGP4 $77
JUMPV
LABELV $92
line 49
;48:		}
;49:	}
LABELV $80
line 27
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 11
LTI4 $79
line 51
;50:
;51:	previous = cg.lowAmmoWarning;
ADDRLP4 12
ADDRGP4 cg+130540
INDIRI4
ASGNI4
line 53
;52:
;53:	if ( total == 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $96
line 54
;54:		cg.lowAmmoWarning = 2;
ADDRGP4 cg+130540
CNSTI4 2
ASGNI4
line 55
;55:	} else {
ADDRGP4 $97
JUMPV
LABELV $96
line 56
;56:		cg.lowAmmoWarning = 1;
ADDRGP4 cg+130540
CNSTI4 1
ASGNI4
line 57
;57:	}
LABELV $97
line 60
;58:
;59:	// play a sound on transitions
;60:	if ( cg.lowAmmoWarning != previous ) {
ADDRGP4 cg+130540
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $100
line 61
;61:		trap_S_StartLocalSound( cgs.media.noAmmoSound, CHAN_LOCAL_SOUND );
ADDRGP4 cgs+156680+796
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 62
;62:	}
LABELV $100
line 63
;63:}
LABELV $77
endproc CG_CheckAmmo 20 8
export CG_DamageFeedback
proc CG_DamageFeedback 72 16
line 70
;64:
;65:/*
;66:==============
;67:CG_DamageFeedback
;68:==============
;69:*/
;70:void CG_DamageFeedback( int yawByte, int pitchByte, int damage ) {
line 81
;71:	float		left, front, up;
;72:	float		kick;
;73:	int			health;
;74:	float		scale;
;75:	vec3_t		dir;
;76:	vec3_t		angles;
;77:	float		dist;
;78:	float		yaw, pitch;
;79:
;80:	// show the attacking player's head and name in corner
;81:	cg.attackerTime = cg.time;
ADDRGP4 cg+130564
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 84
;82:
;83:	// the lower on health you are, the greater the view kick will be
;84:	health = cg.snap->ps.stats[STAT_HEALTH];
ADDRLP4 20
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ASGNI4
line 85
;85:	if ( health < 40 ) {
ADDRLP4 20
INDIRI4
CNSTI4 40
GEI4 $109
line 86
;86:		scale = 1;
ADDRLP4 28
CNSTF4 1065353216
ASGNF4
line 87
;87:	} else {
ADDRGP4 $110
JUMPV
LABELV $109
line 88
;88:		scale = 40.0 / health;
ADDRLP4 28
CNSTF4 1109393408
ADDRLP4 20
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 89
;89:	}
LABELV $110
line 90
;90:	kick = damage * scale;
ADDRLP4 12
ADDRFP4 8
INDIRI4
CVIF4 4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 92
;91:
;92:	if (kick < 5)
ADDRLP4 12
INDIRF4
CNSTF4 1084227584
GEF4 $111
line 93
;93:		kick = 5;
ADDRLP4 12
CNSTF4 1084227584
ASGNF4
LABELV $111
line 94
;94:	if (kick > 10)
ADDRLP4 12
INDIRF4
CNSTF4 1092616192
LEF4 $113
line 95
;95:		kick = 10;
ADDRLP4 12
CNSTF4 1092616192
ASGNF4
LABELV $113
line 98
;96:
;97:	// if yaw and pitch are both 255, make the damage always centered (falling, etc)
;98:	if ( yawByte == 255 && pitchByte == 255 ) {
ADDRLP4 60
CNSTI4 255
ASGNI4
ADDRFP4 0
INDIRI4
ADDRLP4 60
INDIRI4
NEI4 $115
ADDRFP4 4
INDIRI4
ADDRLP4 60
INDIRI4
NEI4 $115
line 99
;99:		cg.damageX = 0;
ADDRGP4 cg+130844
CNSTF4 0
ASGNF4
line 100
;100:		cg.damageY = 0;
ADDRGP4 cg+130848
CNSTF4 0
ASGNF4
line 101
;101:		cg.v_dmg_roll = 0;
ADDRGP4 cg+130892
CNSTF4 0
ASGNF4
line 102
;102:		cg.v_dmg_pitch = -kick;
ADDRGP4 cg+130888
ADDRLP4 12
INDIRF4
NEGF4
ASGNF4
line 103
;103:	} else {
ADDRGP4 $116
JUMPV
LABELV $115
line 105
;104:		// positional
;105:		pitch = pitchByte / 255.0 * 360;
ADDRLP4 56
CNSTF4 1135869952
ADDRFP4 4
INDIRI4
CVIF4 4
CNSTF4 1132396544
DIVF4
MULF4
ASGNF4
line 106
;106:		yaw = yawByte / 255.0 * 360;
ADDRLP4 52
CNSTF4 1135869952
ADDRFP4 0
INDIRI4
CVIF4 4
CNSTF4 1132396544
DIVF4
MULF4
ASGNF4
line 108
;107:
;108:		angles[PITCH] = pitch;
ADDRLP4 32
ADDRLP4 56
INDIRF4
ASGNF4
line 109
;109:		angles[YAW] = yaw;
ADDRLP4 32+4
ADDRLP4 52
INDIRF4
ASGNF4
line 110
;110:		angles[ROLL] = 0;
ADDRLP4 32+8
CNSTF4 0
ASGNF4
line 112
;111:
;112:		AngleVectors( angles, dir, NULL, NULL );
ADDRLP4 32
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 64
CNSTP4 0
ASGNP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 113
;113:		VectorSubtract( vec3_origin, dir, dir );
ADDRLP4 0
ADDRGP4 vec3_origin
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRGP4 vec3_origin+4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 vec3_origin+8
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 115
;114:
;115:		front = DotProduct (dir, cg.refdef.viewaxis[0] );
ADDRLP4 16
ADDRLP4 0
INDIRF4
ADDRGP4 cg+109048+36
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRGP4 cg+109048+36+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRGP4 cg+109048+36+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 116
;116:		left = DotProduct (dir, cg.refdef.viewaxis[1] );
ADDRLP4 24
ADDRLP4 0
INDIRF4
ADDRGP4 cg+109048+36+12
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRGP4 cg+109048+36+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRGP4 cg+109048+36+12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 117
;117:		up = DotProduct (dir, cg.refdef.viewaxis[2] );
ADDRLP4 48
ADDRLP4 0
INDIRF4
ADDRGP4 cg+109048+36+24
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRGP4 cg+109048+36+24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRGP4 cg+109048+36+24+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 119
;118:
;119:		dir[0] = front;
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 120
;120:		dir[1] = left;
ADDRLP4 0+4
ADDRLP4 24
INDIRF4
ASGNF4
line 121
;121:		dir[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 122
;122:		dist = VectorLength( dir );
ADDRLP4 0
ARGP4
ADDRLP4 68
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 44
ADDRLP4 68
INDIRF4
ASGNF4
line 123
;123:		if ( dist < 0.1 ) {
ADDRLP4 44
INDIRF4
CNSTF4 1036831949
GEF4 $167
line 124
;124:			dist = 0.1f;
ADDRLP4 44
CNSTF4 1036831949
ASGNF4
line 125
;125:		}
LABELV $167
line 127
;126:
;127:		cg.v_dmg_roll = kick * left;
ADDRGP4 cg+130892
ADDRLP4 12
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ASGNF4
line 129
;128:		
;129:		cg.v_dmg_pitch = -kick * front;
ADDRGP4 cg+130888
ADDRLP4 12
INDIRF4
NEGF4
ADDRLP4 16
INDIRF4
MULF4
ASGNF4
line 131
;130:
;131:		if ( front <= 0.1 ) {
ADDRLP4 16
INDIRF4
CNSTF4 1036831949
GTF4 $171
line 132
;132:			front = 0.1f;
ADDRLP4 16
CNSTF4 1036831949
ASGNF4
line 133
;133:		}
LABELV $171
line 134
;134:		cg.damageX = -left / front;
ADDRGP4 cg+130844
ADDRLP4 24
INDIRF4
NEGF4
ADDRLP4 16
INDIRF4
DIVF4
ASGNF4
line 135
;135:		cg.damageY = up / dist;
ADDRGP4 cg+130848
ADDRLP4 48
INDIRF4
ADDRLP4 44
INDIRF4
DIVF4
ASGNF4
line 136
;136:	}
LABELV $116
line 139
;137:
;138:	// clamp the position
;139:	if ( cg.damageX > 1.0 ) {
ADDRGP4 cg+130844
INDIRF4
CNSTF4 1065353216
LEF4 $175
line 140
;140:		cg.damageX = 1.0;
ADDRGP4 cg+130844
CNSTF4 1065353216
ASGNF4
line 141
;141:	}
LABELV $175
line 142
;142:	if ( cg.damageX < - 1.0 ) {
ADDRGP4 cg+130844
INDIRF4
CNSTF4 3212836864
GEF4 $179
line 143
;143:		cg.damageX = -1.0;
ADDRGP4 cg+130844
CNSTF4 3212836864
ASGNF4
line 144
;144:	}
LABELV $179
line 146
;145:
;146:	if ( cg.damageY > 1.0 ) {
ADDRGP4 cg+130848
INDIRF4
CNSTF4 1065353216
LEF4 $183
line 147
;147:		cg.damageY = 1.0;
ADDRGP4 cg+130848
CNSTF4 1065353216
ASGNF4
line 148
;148:	}
LABELV $183
line 149
;149:	if ( cg.damageY < - 1.0 ) {
ADDRGP4 cg+130848
INDIRF4
CNSTF4 3212836864
GEF4 $187
line 150
;150:		cg.damageY = -1.0;
ADDRGP4 cg+130848
CNSTF4 3212836864
ASGNF4
line 151
;151:	}
LABELV $187
line 154
;152:
;153:	// don't let the screen flashes vary as much
;154:	if ( kick > 10 ) {
ADDRLP4 12
INDIRF4
CNSTF4 1092616192
LEF4 $191
line 155
;155:		kick = 10;
ADDRLP4 12
CNSTF4 1092616192
ASGNF4
line 156
;156:	}
LABELV $191
line 157
;157:	cg.damageValue = kick;
ADDRGP4 cg+130852
ADDRLP4 12
INDIRF4
ASGNF4
line 158
;158:	cg.v_dmg_time = cg.time + DAMAGE_TIME;
ADDRGP4 cg+130884
ADDRGP4 cg+107604
INDIRI4
CNSTI4 500
ADDI4
CVIF4 4
ASGNF4
line 159
;159:	cg.damageTime = cg.snap->serverTime;
ADDRGP4 cg+130840
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 160
;160:}
LABELV $105
endproc CG_DamageFeedback 72 16
export CG_Respawn
proc CG_Respawn 0 0
line 172
;161:
;162:
;163:
;164:
;165:/*
;166:================
;167:CG_Respawn
;168:
;169:A respawn happened this snapshot
;170:================
;171:*/
;172:void CG_Respawn( void ) {
line 174
;173:	// no error decay on player movement
;174:	cg.thisFrameTeleport = qtrue;
ADDRGP4 cg+107592
CNSTI4 1
ASGNI4
line 177
;175:
;176:	// display weapons available
;177:	cg.weaponSelectTime = cg.time;
ADDRGP4 cg+130828
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 180
;178:
;179:	// select the weapon the server says we are using
;180:	SET_WEAPON(cg.weaponSelect, cg.snap->ps.weapon);
ADDRGP4 cg+108944
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ASGNI4
line 181
;181:}
LABELV $198
endproc CG_Respawn 0 0
export CG_CheckPlayerstateEvents
proc CG_CheckPlayerstateEvents 52 8
line 190
;182:
;183:extern char *eventnames[];
;184:
;185:/*
;186:==============
;187:CG_CheckPlayerstateEvents
;188:==============
;189:*/
;190:void CG_CheckPlayerstateEvents( playerState_t *ps, playerState_t *ops ) {
line 195
;191:	int			i;
;192:	int			event;
;193:	centity_t	*cent;
;194:
;195:	if ( ps->externalEvent && ps->externalEvent != ops->externalEvent ) {
ADDRLP4 12
CNSTI4 128
ASGNI4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $205
ADDRLP4 16
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
EQI4 $205
line 196
;196:		cent = &cg_entities[ ps->clientNum ];
ADDRLP4 4
CNSTI4 728
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 197
;197:		cent->currentState.event = ps->externalEvent;
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
INDIRI4
ASGNI4
line 198
;198:		cent->currentState.eventParm = ps->externalEventParm;
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 132
ADDP4
INDIRI4
ASGNI4
line 199
;199:		CG_EntityEvent( cent, cent->lerpOrigin );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 704
ADDP4
ARGP4
ADDRGP4 CG_EntityEvent
CALLV
pop
line 200
;200:	}
LABELV $205
line 202
;201:
;202:	cent = &cg.predictedPlayerEntity; // cg_entities[ ps->clientNum ];
ADDRLP4 4
ADDRGP4 cg+108104
ASGNP4
line 204
;203:	// go through the predictable events buffer
;204:	for ( i = ps->eventSequence - MAX_PS_EVENTS ; i < ps->eventSequence ; i++ ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
ADDRGP4 $211
JUMPV
LABELV $208
line 206
;205:		// if we have a new predictable event
;206:		if ( i >= ops->eventSequence
ADDRLP4 24
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 28
INDIRI4
GEI4 $214
ADDRLP4 32
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 28
INDIRI4
ADDRLP4 32
INDIRI4
SUBI4
LEI4 $212
ADDRLP4 36
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 32
INDIRI4
LSHI4
ASGNI4
ADDRLP4 40
CNSTI4 112
ASGNI4
ADDRLP4 36
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
ADDRLP4 24
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ADDP4
INDIRI4
EQI4 $212
LABELV $214
line 209
;207:			// or the server told us to play another event instead of a predicted event we already issued
;208:			// or something the server told us changed our prediction causing a different event
;209:			|| (i > ops->eventSequence - MAX_PS_EVENTS && ps->events[i & (MAX_PS_EVENTS-1)] != ops->events[i & (MAX_PS_EVENTS-1)]) ) {
line 211
;210:
;211:			event = ps->events[ i & (MAX_PS_EVENTS-1) ];
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDP4
INDIRI4
ASGNI4
line 212
;212:			cent->currentState.event = event;
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 213
;213:			cent->currentState.eventParm = ps->eventParms[ i & (MAX_PS_EVENTS-1) ];
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
ADDP4
INDIRI4
ASGNI4
line 214
;214:			CG_EntityEvent( cent, cent->lerpOrigin );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 704
ADDP4
ARGP4
ADDRGP4 CG_EntityEvent
CALLV
pop
line 216
;215:
;216:			cg.predictableEvents[ i & (MAX_PREDICTED_EVENTS-1) ] = event;
ADDRLP4 0
INDIRI4
CNSTI4 15
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cg+108856
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 218
;217:
;218:			cg.eventSequence++;
ADDRLP4 48
ADDRGP4 cg+108852
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 219
;219:		}
LABELV $212
line 220
;220:	}
LABELV $209
line 204
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $211
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
LTI4 $208
line 221
;221:}
LABELV $204
endproc CG_CheckPlayerstateEvents 52 8
export CG_CheckChangedPredictableEvents
proc CG_CheckChangedPredictableEvents 24 8
line 228
;222:
;223:/*
;224:==================
;225:CG_CheckChangedPredictableEvents
;226:==================
;227:*/
;228:void CG_CheckChangedPredictableEvents( playerState_t *ps ) {
line 233
;229:	int i;
;230:	int event;
;231:	centity_t	*cent;
;232:
;233:	cent = &cg.predictedPlayerEntity;
ADDRLP4 4
ADDRGP4 cg+108104
ASGNP4
line 234
;234:	for ( i = ps->eventSequence - MAX_PS_EVENTS ; i < ps->eventSequence ; i++ ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
ADDRGP4 $222
JUMPV
LABELV $219
line 236
;235:		//
;236:		if (i >= cg.eventSequence) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+108852
INDIRI4
LTI4 $223
line 237
;237:			continue;
ADDRGP4 $220
JUMPV
LABELV $223
line 240
;238:		}
;239:		// if this event is not further back in than the maximum predictable events we remember
;240:		if (i > cg.eventSequence - MAX_PREDICTED_EVENTS) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+108852
INDIRI4
CNSTI4 16
SUBI4
LEI4 $226
line 242
;241:			// if the new playerstate event is different from a previously predicted one
;242:			if ( ps->events[i & (MAX_PS_EVENTS-1)] != cg.predictableEvents[i & (MAX_PREDICTED_EVENTS-1) ] ) {
ADDRLP4 16
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 16
INDIRI4
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 15
BANDI4
ADDRLP4 16
INDIRI4
LSHI4
ADDRGP4 cg+108856
ADDP4
INDIRI4
EQI4 $229
line 244
;243:
;244:				event = ps->events[ i & (MAX_PS_EVENTS-1) ];
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDP4
INDIRI4
ASGNI4
line 245
;245:				cent->currentState.event = event;
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 246
;246:				cent->currentState.eventParm = ps->eventParms[ i & (MAX_PS_EVENTS-1) ];
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
ADDP4
INDIRI4
ASGNI4
line 247
;247:				CG_EntityEvent( cent, cent->lerpOrigin );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 704
ADDP4
ARGP4
ADDRGP4 CG_EntityEvent
CALLV
pop
line 249
;248:
;249:				cg.predictableEvents[ i & (MAX_PREDICTED_EVENTS-1) ] = event;
ADDRLP4 0
INDIRI4
CNSTI4 15
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cg+108856
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 251
;250:
;251:				if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $233
line 252
;252:					CG_Printf("WARNING: changed predicted event\n");
ADDRGP4 $236
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 253
;253:				}
LABELV $233
line 254
;254:			}
LABELV $229
line 255
;255:		}
LABELV $226
line 256
;256:	}
LABELV $220
line 234
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $222
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
LTI4 $219
line 257
;257:}
LABELV $217
endproc CG_CheckChangedPredictableEvents 24 8
proc pushReward 4 0
line 264
;258:
;259:/*
;260:==================
;261:pushReward
;262:==================
;263:*/
;264:static void pushReward(sfxHandle_t sfx, qhandle_t shader, int rewardCount) {
line 265
;265:	if (cg.rewardStack < (MAX_REWARDSTACK-1)) {
ADDRGP4 cg+130572
INDIRI4
CNSTI4 9
GEI4 $238
line 266
;266:		cg.rewardStack++;
ADDRLP4 0
ADDRGP4 cg+130572
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 267
;267:		cg.rewardSound[cg.rewardStack] = sfx;
ADDRGP4 cg+130572
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+130660
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 268
;268:		cg.rewardShader[cg.rewardStack] = shader;
ADDRGP4 cg+130572
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+130620
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 269
;269:		cg.rewardCount[cg.rewardStack] = rewardCount;
ADDRGP4 cg+130572
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+130580
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 270
;270:	}
LABELV $238
line 271
;271:}
LABELV $237
endproc pushReward 4 0
export CG_CheckLocalSounds
proc CG_CheckLocalSounds 72 12
line 278
;272:
;273:/*
;274:==================
;275:CG_CheckLocalSounds
;276:==================
;277:*/
;278:void CG_CheckLocalSounds( playerState_t *ps, playerState_t *ops ) {
line 283
;279:	int			highScore, /*health, armor,*/ reward;
;280:	sfxHandle_t sfx;
;281:
;282:	// don't play the sounds if the player just changed teams
;283:	if ( ps->persistant[PERS_TEAM] != ops->persistant[PERS_TEAM] ) {
ADDRLP4 12
CNSTI4 260
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
EQI4 $249
line 284
;284:		return;
ADDRGP4 $248
JUMPV
LABELV $249
line 308
;285:	}
;286:
;287:	// hit changes
;288:/*	if ( ps->persistant[PERS_HITS] > ops->persistant[PERS_HITS] ) {
;289:		armor  = ps->persistant[PERS_ATTACKEE_ARMOR] & 0xff;
;290:		health = ps->persistant[PERS_ATTACKEE_ARMOR] >> 8;
;291:#ifdef MISSIONPACK
;292:		if (armor > 50 ) {
;293:			trap_S_StartLocalSound( cgs.media.hitSoundHighArmor, CHAN_LOCAL_SOUND );
;294:		} else if (armor || health > 100) {
;295:			trap_S_StartLocalSound( cgs.media.hitSoundLowArmor, CHAN_LOCAL_SOUND );
;296:		} else {
;297:			trap_S_StartLocalSound( cgs.media.hitSound, CHAN_LOCAL_SOUND );
;298:		}
;299:#else
;300:		trap_S_StartLocalSound( cgs.media.hitSound, CHAN_LOCAL_SOUND );
;301:#endif
;302:	} else if ( ps->persistant[PERS_HITS] < ops->persistant[PERS_HITS] ) {
;303:		trap_S_StartLocalSound( cgs.media.hitTeamSound, CHAN_LOCAL_SOUND );
;304:	}*/
;305:
;306:	// hit changes
;307:	// CPM: Hit tones	
;308:	if (g_pro_mode.integer)
ADDRGP4 g_pro_mode+12
INDIRI4
CNSTI4 0
EQI4 $251
line 309
;309:	{
line 312
;310:		int delta;
;311:
;312:		delta = ps->persistant[PERS_HITS] - ops->persistant[PERS_HITS];
ADDRLP4 20
CNSTI4 252
ASGNI4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
SUBI4
ASGNI4
line 314
;313:
;314:		if (delta > 75)
ADDRLP4 16
INDIRI4
CNSTI4 75
LEI4 $254
line 315
;315:			trap_S_StartLocalSound( cgs.media.hitSound[3], CHAN_LOCAL_SOUND );
ADDRGP4 cgs+156680+844+12
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
ADDRGP4 $252
JUMPV
LABELV $254
line 316
;316:		else if (delta > 50)
ADDRLP4 16
INDIRI4
CNSTI4 50
LEI4 $259
line 317
;317:			trap_S_StartLocalSound( cgs.media.hitSound[2], CHAN_LOCAL_SOUND );
ADDRGP4 cgs+156680+844+8
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
ADDRGP4 $252
JUMPV
LABELV $259
line 318
;318:		else if (delta > 25)
ADDRLP4 16
INDIRI4
CNSTI4 25
LEI4 $264
line 319
;319:			trap_S_StartLocalSound( cgs.media.hitSound[1], CHAN_LOCAL_SOUND );
ADDRGP4 cgs+156680+844+4
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
ADDRGP4 $252
JUMPV
LABELV $264
line 320
;320:		else if (delta > 0)
ADDRLP4 16
INDIRI4
CNSTI4 0
LEI4 $269
line 321
;321:			trap_S_StartLocalSound( cgs.media.hitSound[0], CHAN_LOCAL_SOUND );
ADDRGP4 cgs+156680+844
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
ADDRGP4 $252
JUMPV
LABELV $269
line 322
;322:		else if (delta < 0)
ADDRLP4 16
INDIRI4
CNSTI4 0
GEI4 $252
line 323
;323:			trap_S_StartLocalSound( cgs.media.hitTeamSound, CHAN_LOCAL_SOUND );
ADDRGP4 cgs+156680+868
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 324
;324:	} else {
ADDRGP4 $252
JUMPV
LABELV $251
line 325
;325:		if ( ps->persistant[PERS_HITS] > ops->persistant[PERS_HITS] ) {
ADDRLP4 16
CNSTI4 252
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
LEI4 $277
line 326
;326:			trap_S_StartLocalSound( cgs.media.hitSound[2], CHAN_LOCAL_SOUND );
ADDRGP4 cgs+156680+844+8
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 327
;327:		} else if ( ps->persistant[PERS_HITS] < ops->persistant[PERS_HITS] ) {
ADDRGP4 $278
JUMPV
LABELV $277
ADDRLP4 20
CNSTI4 252
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
GEI4 $282
line 328
;328:			trap_S_StartLocalSound( cgs.media.hitTeamSound, CHAN_LOCAL_SOUND );
ADDRGP4 cgs+156680+868
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 329
;329:		}
LABELV $282
LABELV $278
line 330
;330:	}
LABELV $252
line 333
;331:
;332:	// health changes of more than -1 should make pain sounds
;333:	if ( ps->stats[STAT_HEALTH] < ops->stats[STAT_HEALTH] - 1 ) {
ADDRLP4 16
CNSTI4 184
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
CNSTI4 1
SUBI4
GEI4 $286
line 334
;334:		if ( ps->stats[STAT_HEALTH] > 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LEI4 $288
line 335
;335:			CG_PainEvent( &cg.predictedPlayerEntity, ps->stats[STAT_HEALTH] );
ADDRGP4 cg+108104
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_PainEvent
CALLV
pop
line 336
;336:		}
LABELV $288
line 337
;337:	}
LABELV $286
line 341
;338:
;339:
;340:	// if we are going into the intermission, don't start any voices
;341:	if ( cg.intermissionStarted ) {
ADDRGP4 cg+24
INDIRI4
CNSTI4 0
EQI4 $291
line 342
;342:		return;
ADDRGP4 $248
JUMPV
LABELV $291
line 346
;343:	}
;344:
;345:	// reward sounds
;346:	reward = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 347
;347:	if (ps->persistant[PERS_CAPTURES] != ops->persistant[PERS_CAPTURES]) {
ADDRLP4 20
CNSTI4 304
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
EQI4 $294
line 348
;348:		pushReward(cgs.media.captureAwardSound, cgs.media.medalCapture, ps->persistant[PERS_CAPTURES]);
ADDRGP4 cgs+156680+956
INDIRI4
ARGI4
ADDRGP4 cgs+156680+596
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
ARGI4
ADDRGP4 pushReward
CALLV
pop
line 349
;349:		reward = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 351
;350:		//Com_Printf("capture\n");
;351:	}
LABELV $294
line 352
;352:	if (ps->persistant[PERS_IMPRESSIVE_COUNT] != ops->persistant[PERS_IMPRESSIVE_COUNT]) {
ADDRLP4 24
CNSTI4 284
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
EQI4 $300
line 360
;353:#ifdef MISSIONPACK
;354:		if (ps->persistant[PERS_IMPRESSIVE_COUNT] == 1) {
;355:			sfx = cgs.media.firstImpressiveSound;
;356:		} else {
;357:			sfx = cgs.media.impressiveSound;
;358:		}
;359:#else
;360:		sfx = cgs.media.impressiveSound;
ADDRLP4 4
ADDRGP4 cgs+156680+872
INDIRI4
ASGNI4
line 362
;361:#endif
;362:		pushReward(sfx, cgs.media.medalImpressive, ps->persistant[PERS_IMPRESSIVE_COUNT]);
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 cgs+156680+576
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
ARGI4
ADDRGP4 pushReward
CALLV
pop
line 363
;363:		reward = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 365
;364:		//Com_Printf("impressive\n");
;365:	}
LABELV $300
line 366
;366:	if (ps->persistant[PERS_EXCELLENT_COUNT] != ops->persistant[PERS_EXCELLENT_COUNT]) {
ADDRLP4 28
CNSTI4 288
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
EQI4 $306
line 374
;367:#ifdef MISSIONPACK
;368:		if (ps->persistant[PERS_EXCELLENT_COUNT] == 1) {
;369:			sfx = cgs.media.firstExcellentSound;
;370:		} else {
;371:			sfx = cgs.media.excellentSound;
;372:		}
;373:#else
;374:		sfx = cgs.media.excellentSound;
ADDRLP4 4
ADDRGP4 cgs+156680+876
INDIRI4
ASGNI4
line 376
;375:#endif
;376:		pushReward(sfx, cgs.media.medalExcellent, ps->persistant[PERS_EXCELLENT_COUNT]);
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 cgs+156680+580
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
ARGI4
ADDRGP4 pushReward
CALLV
pop
line 377
;377:		reward = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 379
;378:		//Com_Printf("excellent\n");
;379:	}
LABELV $306
line 380
;380:	if (ps->persistant[PERS_GAUNTLET_FRAG_COUNT] != ops->persistant[PERS_GAUNTLET_FRAG_COUNT]) {
ADDRLP4 32
CNSTI4 300
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRI4
EQI4 $312
line 388
;381:#ifdef MISSIONPACK
;382:		if (ops->persistant[PERS_GAUNTLET_FRAG_COUNT] == 1) {
;383:			sfx = cgs.media.firstHumiliationSound;
;384:		} else {
;385:			sfx = cgs.media.humiliationSound;
;386:		}
;387:#else
;388:		sfx = cgs.media.humiliationSound;
ADDRLP4 4
ADDRGP4 cgs+156680+884
INDIRI4
ASGNI4
line 390
;389:#endif
;390:		pushReward(sfx, cgs.media.medalGauntlet, ps->persistant[PERS_GAUNTLET_FRAG_COUNT]);
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 cgs+156680+584
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 300
ADDP4
INDIRI4
ARGI4
ADDRGP4 pushReward
CALLV
pop
line 391
;391:		reward = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 393
;392:		//Com_Printf("guantlet frag\n");
;393:	}
LABELV $312
line 394
;394:	if (ps->persistant[PERS_DEFEND_COUNT] != ops->persistant[PERS_DEFEND_COUNT]) {
ADDRLP4 36
CNSTI4 292
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRI4
EQI4 $318
line 395
;395:		pushReward(cgs.media.defendSound, cgs.media.medalDefend, ps->persistant[PERS_DEFEND_COUNT]);
ADDRGP4 cgs+156680+892
INDIRI4
ARGI4
ADDRGP4 cgs+156680+588
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ARGI4
ADDRGP4 pushReward
CALLV
pop
line 396
;396:		reward = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 398
;397:		//Com_Printf("defend\n");
;398:	}
LABELV $318
line 399
;399:	if (ps->persistant[PERS_ASSIST_COUNT] != ops->persistant[PERS_ASSIST_COUNT]) {
ADDRLP4 40
CNSTI4 296
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRI4
EQI4 $324
line 400
;400:		pushReward(cgs.media.assistSound, cgs.media.medalAssist, ps->persistant[PERS_ASSIST_COUNT]);
ADDRGP4 cgs+156680+888
INDIRI4
ARGI4
ADDRGP4 cgs+156680+592
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRI4
ARGI4
ADDRGP4 pushReward
CALLV
pop
line 401
;401:		reward = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 403
;402:		//Com_Printf("assist\n");
;403:	}
LABELV $324
line 405
;404:	// if any of the player event bits changed
;405:	if (ps->persistant[PERS_PLAYEREVENTS] != ops->persistant[PERS_PLAYEREVENTS]) {
ADDRLP4 44
CNSTI4 268
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRI4
EQI4 $330
line 406
;406:		if ((ps->persistant[PERS_PLAYEREVENTS] & PLAYEREVENT_DENIEDREWARD) !=
ADDRLP4 48
CNSTI4 268
ASGNI4
ADDRLP4 52
CNSTI4 1
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRI4
ADDRLP4 52
INDIRI4
BANDI4
ADDRFP4 4
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRI4
ADDRLP4 52
INDIRI4
BANDI4
EQI4 $332
line 407
;407:				(ops->persistant[PERS_PLAYEREVENTS] & PLAYEREVENT_DENIEDREWARD)) {
line 408
;408:			trap_S_StartLocalSound( cgs.media.deniedSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+156680+880
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 409
;409:		}
ADDRGP4 $333
JUMPV
LABELV $332
line 410
;410:		else if ((ps->persistant[PERS_PLAYEREVENTS] & PLAYEREVENT_GAUNTLETREWARD) !=
ADDRLP4 56
CNSTI4 268
ASGNI4
ADDRLP4 60
CNSTI4 2
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRI4
ADDRLP4 60
INDIRI4
BANDI4
ADDRFP4 4
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRI4
ADDRLP4 60
INDIRI4
BANDI4
EQI4 $336
line 411
;411:				(ops->persistant[PERS_PLAYEREVENTS] & PLAYEREVENT_GAUNTLETREWARD)) {
line 412
;412:			trap_S_StartLocalSound( cgs.media.humiliationSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+156680+884
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 413
;413:		}
ADDRGP4 $337
JUMPV
LABELV $336
line 414
;414:		else if ((ps->persistant[PERS_PLAYEREVENTS] & PLAYEREVENT_HOLYSHIT) !=
ADDRLP4 64
CNSTI4 268
ASGNI4
ADDRLP4 68
CNSTI4 4
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRI4
ADDRLP4 68
INDIRI4
BANDI4
ADDRFP4 4
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRI4
ADDRLP4 68
INDIRI4
BANDI4
EQI4 $340
line 415
;415:				(ops->persistant[PERS_PLAYEREVENTS] & PLAYEREVENT_HOLYSHIT)) {
line 416
;416:			trap_S_StartLocalSound( cgs.media.holyShitSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+156680+1044
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 417
;417:		}
LABELV $340
LABELV $337
LABELV $333
line 418
;418:		reward = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 419
;419:	}
LABELV $330
line 422
;420:
;421:	// check for flag pickup
;422:	if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $344
line 423
;423:		if ((ps->powerups[PW_REDFLAG] != ops->powerups[PW_REDFLAG] && ps->powerups[PW_REDFLAG]) ||
ADDRLP4 48
CNSTI4 340
ASGNI4
ADDRLP4 52
ADDRFP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRI4
EQI4 $350
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $351
LABELV $350
ADDRLP4 56
CNSTI4 344
ASGNI4
ADDRLP4 60
ADDRFP4 0
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 60
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRI4
EQI4 $352
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $351
LABELV $352
ADDRLP4 64
CNSTI4 348
ASGNI4
ADDRLP4 68
ADDRFP4 0
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 68
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRI4
EQI4 $347
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $347
LABELV $351
line 426
;424:			(ps->powerups[PW_BLUEFLAG] != ops->powerups[PW_BLUEFLAG] && ps->powerups[PW_BLUEFLAG]) ||
;425:			(ps->powerups[PW_NEUTRALFLAG] != ops->powerups[PW_NEUTRALFLAG] && ps->powerups[PW_NEUTRALFLAG]) )
;426:		{
line 427
;427:			trap_S_StartLocalSound( cgs.media.youHaveFlagSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+156680+1036
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 428
;428:		}
LABELV $347
line 429
;429:	}
LABELV $344
line 432
;430:
;431:	// lead changes
;432:	if (!reward) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $355
line 434
;433:		//
;434:		if ( !cg.warmup ) {
ADDRGP4 cg+130804
INDIRI4
CNSTI4 0
NEI4 $357
line 436
;435:			// never play lead changes during warmup
;436:			if ( ps->persistant[PERS_RANK] != ops->persistant[PERS_RANK] ) {
ADDRLP4 48
CNSTI4 256
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRI4
EQI4 $360
line 437
;437:				if ( cgs.gametype < GT_TEAM) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
GEI4 $362
line 438
;438:					if (  ps->persistant[PERS_RANK] == 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 0
NEI4 $365
line 439
;439:						CG_AddBufferedSound(cgs.media.takenLeadSound);
ADDRGP4 cgs+156680+908
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 440
;440:					} else if ( ps->persistant[PERS_RANK] == RANK_TIED_FLAG ) {
ADDRGP4 $366
JUMPV
LABELV $365
ADDRFP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 16384
NEI4 $369
line 441
;441:						CG_AddBufferedSound(cgs.media.tiedLeadSound);
ADDRGP4 cgs+156680+912
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 442
;442:					} else if ( ( ops->persistant[PERS_RANK] & ~RANK_TIED_FLAG ) == 0 ) {
ADDRGP4 $370
JUMPV
LABELV $369
ADDRFP4 4
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 -16385
BANDI4
CNSTI4 0
NEI4 $373
line 443
;443:						CG_AddBufferedSound(cgs.media.lostLeadSound);
ADDRGP4 cgs+156680+916
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 444
;444:					}
LABELV $373
LABELV $370
LABELV $366
line 445
;445:				}
LABELV $362
line 446
;446:			}
LABELV $360
line 447
;447:		}
LABELV $357
line 448
;448:	}
LABELV $355
line 451
;449:
;450:	// timelimit warnings
;451:	if ( cgs.timelimit > 0 ) {
ADDRGP4 cgs+31476
INDIRI4
CNSTI4 0
LEI4 $377
line 454
;452:		int		msec;
;453:
;454:		msec = cg.time - cgs.levelStartTime;
ADDRLP4 48
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cgs+34784
INDIRI4
SUBI4
ASGNI4
line 455
;455:		if ( !( cg.timelimitWarnings & 4 ) && msec > ( cgs.timelimit * 60 + 2 ) * 1000 ) {
ADDRGP4 cg+107616
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
NEI4 $382
ADDRLP4 48
INDIRI4
CNSTI4 1000
CNSTI4 60
ADDRGP4 cgs+31476
INDIRI4
MULI4
MULI4
CNSTI4 2000
ADDI4
LEI4 $382
line 456
;456:			cg.timelimitWarnings |= 1 | 2 | 4;
ADDRLP4 52
ADDRGP4 cg+107616
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTI4 7
BORI4
ASGNI4
line 457
;457:			trap_S_StartLocalSound( cgs.media.suddenDeathSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+156680+828
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 458
;458:		}
ADDRGP4 $383
JUMPV
LABELV $382
line 459
;459:		else if ( !( cg.timelimitWarnings & 2 ) && msec > (cgs.timelimit - 1) * 60 * 1000 ) {
ADDRGP4 cg+107616
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $389
ADDRLP4 48
INDIRI4
CNSTI4 1000
CNSTI4 60
ADDRGP4 cgs+31476
INDIRI4
MULI4
MULI4
CNSTI4 60000
SUBI4
LEI4 $389
line 460
;460:			cg.timelimitWarnings |= 1 | 2;
ADDRLP4 52
ADDRGP4 cg+107616
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTI4 3
BORI4
ASGNI4
line 461
;461:			trap_S_StartLocalSound( cgs.media.oneMinuteSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+156680+820
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 462
;462:		}
ADDRGP4 $390
JUMPV
LABELV $389
line 463
;463:		else if ( cgs.timelimit > 5 && !( cg.timelimitWarnings & 1 ) && msec > (cgs.timelimit - 5) * 60 * 1000 ) {
ADDRGP4 cgs+31476
INDIRI4
CNSTI4 5
LEI4 $396
ADDRGP4 cg+107616
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $396
ADDRLP4 48
INDIRI4
CNSTI4 1000
CNSTI4 60
ADDRGP4 cgs+31476
INDIRI4
MULI4
MULI4
CNSTI4 300000
SUBI4
LEI4 $396
line 464
;464:			cg.timelimitWarnings |= 1;
ADDRLP4 52
ADDRGP4 cg+107616
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 465
;465:			trap_S_StartLocalSound( cgs.media.fiveMinuteSound, CHAN_ANNOUNCER );
ADDRGP4 cgs+156680+824
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 466
;466:		}
LABELV $396
LABELV $390
LABELV $383
line 467
;467:	}
LABELV $377
line 473
;468:
;469:	// fraglimit warnings
;470:/*freeze
;471:	if ( cgs.fraglimit > 0 && cgs.gametype < GT_CTF) {
;472:freeze*/
;473:	if ( (g_gamemode.integer > 3 && cgs.fraglimit > 0 && cgs.gametype < GT_TEAM) || 
ADDRLP4 48
CNSTI4 3
ASGNI4
ADDRGP4 g_gamemode+12
INDIRI4
ADDRLP4 48
INDIRI4
LEI4 $413
ADDRGP4 cgs+31468
INDIRI4
CNSTI4 0
LEI4 $413
ADDRGP4 cgs+31456
INDIRI4
ADDRLP4 48
INDIRI4
LTI4 $411
LABELV $413
ADDRLP4 52
CNSTI4 4
ASGNI4
ADDRGP4 g_gamemode+12
INDIRI4
ADDRLP4 52
INDIRI4
GEI4 $404
ADDRGP4 cgs+31456
INDIRI4
ADDRLP4 52
INDIRI4
GEI4 $404
LABELV $411
line 474
;474:		 (g_gamemode.integer < 4 && cgs.gametype < GT_CTF) ) {
line 476
;475://freeze
;476:		highScore = cgs.scores1;
ADDRLP4 8
ADDRGP4 cgs+34788
INDIRI4
ASGNI4
line 477
;477:		if ( !( cg.fraglimitWarnings & 4 ) && highScore == (cgs.fraglimit - 1) ) {
ADDRGP4 cg+107620
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
NEI4 $415
ADDRLP4 8
INDIRI4
ADDRGP4 cgs+31468
INDIRI4
CNSTI4 1
SUBI4
NEI4 $415
line 478
;478:			cg.fraglimitWarnings |= 1 | 2 | 4;
ADDRLP4 56
ADDRGP4 cg+107620
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 7
BORI4
ASGNI4
line 479
;479:			CG_AddBufferedSound(cgs.media.oneFragSound);
ADDRGP4 cgs+156680+840
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 480
;480:		}
ADDRGP4 $416
JUMPV
LABELV $415
line 481
;481:		else if ( cgs.fraglimit > 2 && !( cg.fraglimitWarnings & 2 ) && highScore == (cgs.fraglimit - 2) ) {
ADDRLP4 56
CNSTI4 2
ASGNI4
ADDRGP4 cgs+31468
INDIRI4
ADDRLP4 56
INDIRI4
LEI4 $422
ADDRGP4 cg+107620
INDIRI4
ADDRLP4 56
INDIRI4
BANDI4
CNSTI4 0
NEI4 $422
ADDRLP4 8
INDIRI4
ADDRGP4 cgs+31468
INDIRI4
ADDRLP4 56
INDIRI4
SUBI4
NEI4 $422
line 482
;482:			cg.fraglimitWarnings |= 1 | 2;
ADDRLP4 60
ADDRGP4 cg+107620
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 3
BORI4
ASGNI4
line 483
;483:			CG_AddBufferedSound(cgs.media.twoFragSound);
ADDRGP4 cgs+156680+836
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 484
;484:		}
ADDRGP4 $423
JUMPV
LABELV $422
line 485
;485:		else if ( cgs.fraglimit > 3 && !( cg.fraglimitWarnings & 1 ) && highScore == (cgs.fraglimit - 3) ) {
ADDRLP4 60
CNSTI4 3
ASGNI4
ADDRGP4 cgs+31468
INDIRI4
ADDRLP4 60
INDIRI4
LEI4 $430
ADDRGP4 cg+107620
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $430
ADDRLP4 8
INDIRI4
ADDRGP4 cgs+31468
INDIRI4
ADDRLP4 60
INDIRI4
SUBI4
NEI4 $430
line 486
;486:			cg.fraglimitWarnings |= 1;
ADDRLP4 64
ADDRGP4 cg+107620
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 487
;487:			CG_AddBufferedSound(cgs.media.threeFragSound);
ADDRGP4 cgs+156680+832
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 488
;488:		}
LABELV $430
LABELV $423
LABELV $416
line 489
;489:	}
LABELV $404
line 490
;490:}
LABELV $248
endproc CG_CheckLocalSounds 72 12
export CG_TransitionPlayerState
proc CG_TransitionPlayerState 24 12
line 498
;491:
;492:/*
;493:===============
;494:CG_TransitionPlayerState
;495:
;496:===============
;497:*/
;498:void CG_TransitionPlayerState( playerState_t *ps, playerState_t *ops ) {
line 500
;499:	// check for changing follow mode
;500:	if ( ps->clientNum != ops->clientNum ) {
ADDRLP4 0
CNSTI4 140
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRI4
ADDP4
INDIRI4
EQI4 $439
line 501
;501:		cg.thisFrameTeleport = qtrue;
ADDRGP4 cg+107592
CNSTI4 1
ASGNI4
line 503
;502:		// make sure we don't get any unwanted transition effects
;503:		*ops = *ps;
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 468
line 504
;504:	}
LABELV $439
line 507
;505:
;506:	// damage events (player is getting wounded)
;507:	if ( ps->damageEvent != ops->damageEvent && ps->damageCount ) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
CNSTI4 168
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRI4
EQI4 $442
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 0
EQI4 $442
line 508
;508:		CG_DamageFeedback( ps->damageYaw, ps->damagePitch, ps->damageCount );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DamageFeedback
CALLV
pop
line 509
;509:	}
LABELV $442
line 512
;510:
;511:	// respawning
;512:	if ( ps->persistant[PERS_SPAWN_COUNT] != ops->persistant[PERS_SPAWN_COUNT] ) {
ADDRLP4 12
CNSTI4 264
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
EQI4 $444
line 513
;513:		CG_Respawn();
ADDRGP4 CG_Respawn
CALLV
pop
line 514
;514:	}
LABELV $444
line 516
;515:
;516:	if ( cg.mapRestart ) {
ADDRGP4 cg+107624
INDIRI4
CNSTI4 0
EQI4 $446
line 517
;517:		CG_Respawn();
ADDRGP4 CG_Respawn
CALLV
pop
line 518
;518:		cg.mapRestart = qfalse;
ADDRGP4 cg+107624
CNSTI4 0
ASGNI4
line 519
;519:	}
LABELV $446
line 521
;520:
;521:	if ( cg.snap->ps.pm_type != PM_INTERMISSION 
ADDRGP4 cg+36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 5
EQI4 $450
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 3
EQI4 $450
line 522
;522:		&& ps->persistant[PERS_TEAM] != TEAM_SPECTATOR ) {
line 523
;523:		CG_CheckLocalSounds( ps, ops );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_CheckLocalSounds
CALLV
pop
line 524
;524:	}
LABELV $450
line 527
;525:
;526:	// check for going low on ammo
;527:	CG_CheckAmmo();
ADDRGP4 CG_CheckAmmo
CALLV
pop
line 530
;528:
;529:	// run events
;530:	CG_CheckPlayerstateEvents( ps, ops );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_CheckPlayerstateEvents
CALLV
pop
line 533
;531:
;532:	// smooth the ducking viewheight change
;533:	if ( ps->viewheight != ops->viewheight ) {
ADDRLP4 16
CNSTI4 164
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
EQI4 $453
line 534
;534:		cg.duckChange = ps->viewheight - ops->viewheight;
ADDRLP4 20
CNSTI4 164
ASGNI4
ADDRGP4 cg+108928
ADDRFP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 535
;535:		cg.duckTime = cg.time;
ADDRGP4 cg+108932
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 536
;536:	}
LABELV $453
line 537
;537:}
LABELV $438
endproc CG_TransitionPlayerState 24 12
import eventnames
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
import CG_DrawInformation
import CG_LoadingClient
import CG_LoadingItem
import CG_LoadingString
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
LABELV $236
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 10
byte 1 0
