data
export pm_stopspeed
align 4
LABELV pm_stopspeed
byte 4 1120403456
export pm_duckScale
align 4
LABELV pm_duckScale
byte 4 1048576000
export pm_swimScale
align 4
LABELV pm_swimScale
byte 4 1056964608
export pm_wadeScale
align 4
LABELV pm_wadeScale
byte 4 1060320051
export pm_accelerate
align 4
LABELV pm_accelerate
byte 4 1092616192
export pm_airaccelerate
align 4
LABELV pm_airaccelerate
byte 4 1065353216
export pm_wateraccelerate
align 4
LABELV pm_wateraccelerate
byte 4 1082130432
export pm_flyaccelerate
align 4
LABELV pm_flyaccelerate
byte 4 1090519040
export pm_friction
align 4
LABELV pm_friction
byte 4 1086324736
export pm_waterfriction
align 4
LABELV pm_waterfriction
byte 4 1065353216
export pm_flightfriction
align 4
LABELV pm_flightfriction
byte 4 1077936128
export pm_spectatorfriction
align 4
LABELV pm_spectatorfriction
byte 4 1084227584
export c_pmove
align 4
LABELV c_pmove
byte 4 0
export PM_AddEvent
code
proc PM_AddEvent 0 12
file "../../game/bg_pmove.c"
line 39
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// bg_pmove.c -- both games player movement code
;4:// takes a playerstate and a usercmd as input and returns a modifed playerstate
;5:
;6:#include "q_shared.h"
;7:#include "bg_public.h"
;8:#include "bg_local.h"
;9:#include "bg_promode.h"
;10:
;11:pmove_t		*pm;
;12:pml_t		pml;
;13:
;14:// movement parameters
;15:float	pm_stopspeed = 100.0f;
;16:float	pm_duckScale = 0.25f;
;17:float	pm_swimScale = 0.50f;
;18:float	pm_wadeScale = 0.70f;
;19:
;20:float	pm_accelerate = 10.0f;
;21:float	pm_airaccelerate = 1.0f;
;22:float	pm_wateraccelerate = 4.0f;
;23:float	pm_flyaccelerate = 8.0f;
;24:
;25:float	pm_friction = 6.0f;
;26:float	pm_waterfriction = 1.0f;
;27:float	pm_flightfriction = 3.0f;
;28:float	pm_spectatorfriction = 5.0f;
;29:
;30:int		c_pmove = 0;
;31:
;32:
;33:/*
;34:===============
;35:PM_AddEvent
;36:
;37:===============
;38:*/
;39:void PM_AddEvent( int newEvent ) {
line 40
;40:	BG_AddPredictableEventToPlayerstate( newEvent, 0, pm->ps );
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 pm
INDIRP4
INDIRP4
ARGP4
ADDRGP4 BG_AddPredictableEventToPlayerstate
CALLV
pop
line 41
;41:}
LABELV $42
endproc PM_AddEvent 0 12
export PM_AddTouchEnt
proc PM_AddTouchEnt 12 0
line 48
;42:
;43:/*
;44:===============
;45:PM_AddTouchEnt
;46:===============
;47:*/
;48:void PM_AddTouchEnt( int entityNum ) {
line 51
;49:	int		i;
;50:
;51:	if ( entityNum == ENTITYNUM_WORLD ) {
ADDRFP4 0
INDIRI4
CNSTI4 1022
NEI4 $44
line 52
;52:		return;
ADDRGP4 $43
JUMPV
LABELV $44
line 54
;53:	}
;54:	if ( pm->numtouch == MAXTOUCH ) {
ADDRGP4 pm
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 32
NEI4 $46
line 55
;55:		return;
ADDRGP4 $43
JUMPV
LABELV $46
line 59
;56:	}
;57:
;58:	// see if it is already added
;59:	for ( i = 0 ; i < pm->numtouch ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $51
JUMPV
LABELV $48
line 60
;60:		if ( pm->touchents[ i ] == entityNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pm
INDIRP4
CNSTI4 56
ADDP4
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $52
line 61
;61:			return;
ADDRGP4 $43
JUMPV
LABELV $52
line 63
;62:		}
;63:	}
LABELV $49
line 59
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $51
ADDRLP4 0
INDIRI4
ADDRGP4 pm
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
LTI4 $48
line 66
;64:
;65:	// add it
;66:	pm->touchents[pm->numtouch] = entityNum;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 56
ADDP4
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 67
;67:	pm->numtouch++;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
CNSTI4 52
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 68
;68:}
LABELV $43
endproc PM_AddTouchEnt 12 0
proc PM_StartTorsoAnim 8 0
line 75
;69:
;70:/*
;71:===================
;72:PM_StartTorsoAnim
;73:===================
;74:*/
;75:static void PM_StartTorsoAnim( int anim ) {
line 76
;76:	if ( pm->ps->pm_type >= PM_DEAD ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
LTI4 $55
line 77
;77:		return;
ADDRGP4 $54
JUMPV
LABELV $55
line 79
;78:	}
;79:	pm->ps->torsoAnim = ( ( pm->ps->torsoAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT )
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 84
ADDP4
ASGNP4
ADDRLP4 4
CNSTI4 128
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
BANDI4
ADDRLP4 4
INDIRI4
BXORI4
ADDRFP4 0
INDIRI4
BORI4
ASGNI4
line 81
;80:		| anim;
;81:}
LABELV $54
endproc PM_StartTorsoAnim 8 0
proc PM_StartLegsAnim 8 0
line 82
;82:static void PM_StartLegsAnim( int anim ) {
line 83
;83:	if ( pm->ps->pm_type >= PM_DEAD ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
LTI4 $58
line 84
;84:		return;
ADDRGP4 $57
JUMPV
LABELV $58
line 86
;85:	}
;86:	if ( pm->ps->legsTimer > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
LEI4 $60
line 87
;87:		return;		// a high priority animation is running
ADDRGP4 $57
JUMPV
LABELV $60
line 89
;88:	}
;89:	pm->ps->legsAnim = ( ( pm->ps->legsAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT )
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 76
ADDP4
ASGNP4
ADDRLP4 4
CNSTI4 128
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
BANDI4
ADDRLP4 4
INDIRI4
BXORI4
ADDRFP4 0
INDIRI4
BORI4
ASGNI4
line 91
;90:		| anim;
;91:}
LABELV $57
endproc PM_StartLegsAnim 8 0
proc PM_ContinueLegsAnim 0 4
line 93
;92:
;93:static void PM_ContinueLegsAnim( int anim ) {
line 94
;94:	if ( ( pm->ps->legsAnim & ~ANIM_TOGGLEBIT ) == anim ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ADDRFP4 0
INDIRI4
NEI4 $63
line 95
;95:		return;
ADDRGP4 $62
JUMPV
LABELV $63
line 97
;96:	}
;97:	if ( pm->ps->legsTimer > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
LEI4 $65
line 98
;98:		return;		// a high priority animation is running
ADDRGP4 $62
JUMPV
LABELV $65
line 100
;99:	}
;100:	PM_StartLegsAnim( anim );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 PM_StartLegsAnim
CALLV
pop
line 101
;101:}
LABELV $62
endproc PM_ContinueLegsAnim 0 4
proc PM_ContinueTorsoAnim 0 4
line 103
;102:
;103:static void PM_ContinueTorsoAnim( int anim ) {
line 104
;104:	if ( ( pm->ps->torsoAnim & ~ANIM_TOGGLEBIT ) == anim ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ADDRFP4 0
INDIRI4
NEI4 $68
line 105
;105:		return;
ADDRGP4 $67
JUMPV
LABELV $68
line 107
;106:	}
;107:	if ( pm->ps->torsoTimer > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
LEI4 $70
line 108
;108:		return;		// a high priority animation is running
ADDRGP4 $67
JUMPV
LABELV $70
line 110
;109:	}
;110:	PM_StartTorsoAnim( anim );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 111
;111:}
LABELV $67
endproc PM_ContinueTorsoAnim 0 4
proc PM_ForceLegsAnim 0 4
line 113
;112:
;113:static void PM_ForceLegsAnim( int anim ) {
line 114
;114:	pm->ps->legsTimer = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 115
;115:	PM_StartLegsAnim( anim );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 PM_StartLegsAnim
CALLV
pop
line 116
;116:}
LABELV $72
endproc PM_ForceLegsAnim 0 4
export PM_ClipVelocity
proc PM_ClipVelocity 32 0
line 126
;117:
;118:
;119:/*
;120:==================
;121:PM_ClipVelocity
;122:
;123:Slide off of the impacting surface
;124:==================
;125:*/
;126:void PM_ClipVelocity( vec3_t in, vec3_t normal, vec3_t out, float overbounce ) {
line 131
;127:	float	backoff;
;128:	float	change;
;129:	int		i;
;130:	
;131:	backoff = DotProduct (in, normal);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20
CNSTI4 4
ASGNI4
ADDRLP4 24
CNSTI4 8
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRP4
INDIRF4
ADDRLP4 16
INDIRP4
INDIRF4
MULF4
ADDRLP4 12
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 12
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 133
;132:	
;133:	if ( backoff < 0 ) {
ADDRLP4 8
INDIRF4
CNSTF4 0
GEF4 $74
line 134
;134:		backoff *= overbounce;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRFP4 12
INDIRF4
MULF4
ASGNF4
line 135
;135:	} else {
ADDRGP4 $75
JUMPV
LABELV $74
line 136
;136:		backoff /= overbounce;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRFP4 12
INDIRF4
DIVF4
ASGNF4
line 137
;137:	}
LABELV $75
line 139
;138:
;139:	for ( i=0 ; i<3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $76
line 140
;140:		change = normal[i]*backoff;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
MULF4
ASGNF4
line 141
;141:		out[i] = in[i] - change;
ADDRLP4 28
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 28
INDIRI4
ADDRFP4 8
INDIRP4
ADDP4
ADDRLP4 28
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
line 142
;142:	}
LABELV $77
line 139
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $76
line 143
;143:}
LABELV $73
endproc PM_ClipVelocity 32 0
proc PM_Friction 48 4
line 153
;144:
;145:
;146:/*
;147:==================
;148:PM_Friction
;149:
;150:Handles both ground friction and water friction
;151:==================
;152:*/
;153:static void PM_Friction( void ) {
line 159
;154:	vec3_t	vec;
;155:	float	*vel;
;156:	float	speed, newspeed, control;
;157:	float	drop;
;158:	
;159:	vel = pm->ps->velocity;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
line 161
;160:	
;161:	VectorCopy( vel, vec );
ADDRLP4 16
ADDRLP4 0
INDIRP4
INDIRB
ASGNB 12
line 162
;162:	if ( pml.walking ) {
ADDRGP4 pml+44
INDIRI4
CNSTI4 0
EQI4 $81
line 163
;163:		vec[2] = 0;	// ignore slope movement
ADDRLP4 16+8
CNSTF4 0
ASGNF4
line 164
;164:	}
LABELV $81
line 166
;165:
;166:	speed = VectorLength(vec);
ADDRLP4 16
ARGP4
ADDRLP4 32
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 32
INDIRF4
ASGNF4
line 167
;167:	if (speed < 1) {
ADDRLP4 8
INDIRF4
CNSTF4 1065353216
GEF4 $85
line 168
;168:		vel[0] = 0;
ADDRLP4 0
INDIRP4
CNSTF4 0
ASGNF4
line 169
;169:		vel[1] = 0;		// allow sinking underwater
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 0
ASGNF4
line 171
;170:		// FIXME: still have z friction underwater?
;171:		return;
ADDRGP4 $80
JUMPV
LABELV $85
line 174
;172:	}
;173:
;174:	drop = 0;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 177
;175:
;176:	// apply ground friction
;177:	if ( pm->waterlevel <= 1 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 1
GTI4 $87
line 178
;178:		if ( pml.walking && !(pml.groundTrace.surfaceFlags & SURF_SLICK) ) {
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRGP4 pml+44
INDIRI4
ADDRLP4 36
INDIRI4
EQI4 $89
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 36
INDIRI4
NEI4 $89
line 180
;179:			// if getting knocked back, no friction
;180:			if ( ! (pm->ps->pm_flags & PMF_TIME_KNOCKBACK) ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
NEI4 $94
line 181
;181:				control = speed < pm_stopspeed ? pm_stopspeed : speed;
ADDRLP4 8
INDIRF4
ADDRGP4 pm_stopspeed
INDIRF4
GEF4 $97
ADDRLP4 40
ADDRGP4 pm_stopspeed
INDIRF4
ASGNF4
ADDRGP4 $98
JUMPV
LABELV $97
ADDRLP4 40
ADDRLP4 8
INDIRF4
ASGNF4
LABELV $98
ADDRLP4 28
ADDRLP4 40
INDIRF4
ASGNF4
line 182
;182:				drop += control*pm_friction*pml.frametime;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 28
INDIRF4
ADDRGP4 pm_friction
INDIRF4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 183
;183:			}
LABELV $94
line 184
;184:		}
LABELV $89
line 185
;185:	}
LABELV $87
line 188
;186:
;187:	// apply water friction even if just wading
;188:	if ( pm->waterlevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 0
EQI4 $100
line 189
;189:		drop += speed*pm_waterfriction*pm->waterlevel*pml.frametime;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
ADDRGP4 pm_waterfriction
INDIRF4
MULF4
ADDRGP4 pm
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CVIF4 4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 190
;190:	}
LABELV $100
line 193
;191:
;192:	// apply flying friction
;193:	if ( pm->ps->powerups[PW_FLIGHT]) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 0
EQI4 $103
line 194
;194:		drop += speed*pm_flightfriction*pml.frametime;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
ADDRGP4 pm_flightfriction
INDIRF4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 195
;195:	}
LABELV $103
line 197
;196:
;197:	if ( pm->ps->pm_type == PM_SPECTATOR) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $106
line 198
;198:		drop += speed*pm_spectatorfriction*pml.frametime;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
ADDRGP4 pm_spectatorfriction
INDIRF4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 199
;199:	}
LABELV $106
line 202
;200:
;201:	// scale the velocity
;202:	newspeed = speed - drop;
ADDRLP4 4
ADDRLP4 8
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ASGNF4
line 203
;203:	if (newspeed < 0) {
ADDRLP4 4
INDIRF4
CNSTF4 0
GEF4 $109
line 204
;204:		newspeed = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 205
;205:	}
LABELV $109
line 206
;206:	newspeed /= speed;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
DIVF4
ASGNF4
line 208
;207:
;208:	vel[0] = vel[0] * newspeed;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 209
;209:	vel[1] = vel[1] * newspeed;
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 210
;210:	vel[2] = vel[2] * newspeed;
ADDRLP4 44
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 211
;211:}
LABELV $80
endproc PM_Friction 48 4
proc PM_Accelerate 32 0
line 221
;212:
;213:
;214:/*
;215:==============
;216:PM_Accelerate
;217:
;218:Handles user intended acceleration
;219:==============
;220:*/
;221:static void PM_Accelerate( vec3_t wishdir, float wishspeed, float accel ) {
line 227
;222:#if 1
;223:	// q2 style
;224:	int			i;
;225:	float		addspeed, accelspeed, currentspeed;
;226:
;227:	currentspeed = DotProduct (pm->ps->velocity, wishdir);
ADDRLP4 16
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 16
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
INDIRF4
MULF4
ADDRLP4 16
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 16
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 228
;228:	addspeed = wishspeed - currentspeed;
ADDRLP4 8
ADDRFP4 4
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ASGNF4
line 229
;229:	if (addspeed <= 0) {
ADDRLP4 8
INDIRF4
CNSTF4 0
GTF4 $112
line 230
;230:		return;
ADDRGP4 $111
JUMPV
LABELV $112
line 232
;231:	}
;232:	accelspeed = accel*pml.frametime*wishspeed;
ADDRLP4 4
ADDRFP4 8
INDIRF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDRFP4 4
INDIRF4
MULF4
ASGNF4
line 233
;233:	if (accelspeed > addspeed) {
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $115
line 234
;234:		accelspeed = addspeed;
ADDRLP4 4
ADDRLP4 8
INDIRF4
ASGNF4
line 235
;235:	}
LABELV $115
line 237
;236:	
;237:	for (i=0 ; i<3 ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $117
line 238
;238:		pm->ps->velocity[i] += accelspeed*wishdir[i];	
ADDRLP4 24
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 28
ADDRLP4 24
INDIRI4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 24
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 239
;239:	}
LABELV $118
line 237
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $117
line 258
;240:#else
;241:	// proper way (avoids strafe jump maxspeed bug), but feels bad
;242:	vec3_t		wishVelocity;
;243:	vec3_t		pushDir;
;244:	float		pushLen;
;245:	float		canPush;
;246:
;247:	VectorScale( wishdir, wishspeed, wishVelocity );
;248:	VectorSubtract( wishVelocity, pm->ps->velocity, pushDir );
;249:	pushLen = VectorNormalize( pushDir );
;250:
;251:	canPush = accel*pml.frametime*wishspeed;
;252:	if (canPush > pushLen) {
;253:		canPush = pushLen;
;254:	}
;255:
;256:	VectorMA( pm->ps->velocity, canPush, pushDir, pm->ps->velocity );
;257:#endif
;258:}
LABELV $111
endproc PM_Accelerate 32 0
proc PM_CmdScale 44 4
line 271
;259:
;260:
;261:
;262:/*
;263:============
;264:PM_CmdScale
;265:
;266:Returns the scale factor to apply to cmd movements
;267:This allows the clients to use axial -127 to 127 values for all directions
;268:without getting a sqrt(2) distortion in speed.
;269:============
;270:*/
;271:static float PM_CmdScale( usercmd_t *cmd ) {
line 276
;272:	int		max;
;273:	float	total;
;274:	float	scale;
;275:
;276:	max = abs( cmd->forwardmove );
ADDRFP4 0
INDIRP4
CNSTI4 21
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 12
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 277
;277:	if ( abs( cmd->rightmove ) > max ) {
ADDRFP4 0
INDIRP4
CNSTI4 22
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 16
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $122
line 278
;278:		max = abs( cmd->rightmove );
ADDRFP4 0
INDIRP4
CNSTI4 22
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 20
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 20
INDIRI4
ASGNI4
line 279
;279:	}
LABELV $122
line 280
;280:	if ( abs( cmd->upmove ) > max ) {
ADDRFP4 0
INDIRP4
CNSTI4 23
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 20
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $124
line 281
;281:		max = abs( cmd->upmove );
ADDRFP4 0
INDIRP4
CNSTI4 23
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 24
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 24
INDIRI4
ASGNI4
line 282
;282:	}
LABELV $124
line 283
;283:	if ( !max ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $126
line 284
;284:		return 0;
CNSTF4 0
RETF4
ADDRGP4 $121
JUMPV
LABELV $126
line 287
;285:	}
;286:
;287:	total = sqrt( cmd->forwardmove * cmd->forwardmove
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 21
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 32
ADDRLP4 24
INDIRP4
CNSTI4 22
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 36
ADDRLP4 24
INDIRP4
CNSTI4 23
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 28
INDIRI4
ADDRLP4 28
INDIRI4
MULI4
ADDRLP4 32
INDIRI4
ADDRLP4 32
INDIRI4
MULI4
ADDI4
ADDRLP4 36
INDIRI4
ADDRLP4 36
INDIRI4
MULI4
ADDI4
CVIF4 4
ARGF4
ADDRLP4 40
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 40
INDIRF4
ASGNF4
line 289
;288:		+ cmd->rightmove * cmd->rightmove + cmd->upmove * cmd->upmove );
;289:	scale = (float)pm->ps->speed * max / ( 127.0 * total );
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRI4
CVIF4 4
MULF4
CNSTF4 1123942400
ADDRLP4 4
INDIRF4
MULF4
DIVF4
ASGNF4
line 291
;290:
;291:	return scale;
ADDRLP4 8
INDIRF4
RETF4
LABELV $121
endproc PM_CmdScale 44 4
proc PM_SetMovementDir 72 0
line 303
;292:}
;293:
;294:
;295:/*
;296:================
;297:PM_SetMovementDir
;298:
;299:Determine the rotation of the legs reletive
;300:to the facing dir
;301:================
;302:*/
;303:static void PM_SetMovementDir( void ) {
line 304
;304:	if ( pm->cmd.forwardmove || pm->cmd.rightmove ) {
ADDRLP4 0
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 4
INDIRI4
NEI4 $131
ADDRLP4 0
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 4
INDIRI4
EQI4 $129
LABELV $131
line 305
;305:		if ( pm->cmd.rightmove == 0 && pm->cmd.forwardmove > 0 ) {
ADDRLP4 8
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 12
INDIRI4
NEI4 $132
ADDRLP4 8
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 12
INDIRI4
LEI4 $132
line 306
;306:			pm->ps->movementDir = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 0
ASGNI4
line 307
;307:		} else if ( pm->cmd.rightmove < 0 && pm->cmd.forwardmove > 0 ) {
ADDRGP4 $130
JUMPV
LABELV $132
ADDRLP4 16
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 16
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 20
INDIRI4
GEI4 $134
ADDRLP4 16
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 20
INDIRI4
LEI4 $134
line 308
;308:			pm->ps->movementDir = 1;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 1
ASGNI4
line 309
;309:		} else if ( pm->cmd.rightmove < 0 && pm->cmd.forwardmove == 0 ) {
ADDRGP4 $130
JUMPV
LABELV $134
ADDRLP4 24
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRLP4 24
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 28
INDIRI4
GEI4 $136
ADDRLP4 24
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 28
INDIRI4
NEI4 $136
line 310
;310:			pm->ps->movementDir = 2;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 2
ASGNI4
line 311
;311:		} else if ( pm->cmd.rightmove < 0 && pm->cmd.forwardmove < 0 ) {
ADDRGP4 $130
JUMPV
LABELV $136
ADDRLP4 32
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 36
INDIRI4
GEI4 $138
ADDRLP4 32
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 36
INDIRI4
GEI4 $138
line 312
;312:			pm->ps->movementDir = 3;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 3
ASGNI4
line 313
;313:		} else if ( pm->cmd.rightmove == 0 && pm->cmd.forwardmove < 0 ) {
ADDRGP4 $130
JUMPV
LABELV $138
ADDRLP4 40
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 44
CNSTI4 0
ASGNI4
ADDRLP4 40
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 44
INDIRI4
NEI4 $140
ADDRLP4 40
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 44
INDIRI4
GEI4 $140
line 314
;314:			pm->ps->movementDir = 4;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 4
ASGNI4
line 315
;315:		} else if ( pm->cmd.rightmove > 0 && pm->cmd.forwardmove < 0 ) {
ADDRGP4 $130
JUMPV
LABELV $140
ADDRLP4 48
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRLP4 48
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 52
INDIRI4
LEI4 $142
ADDRLP4 48
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 52
INDIRI4
GEI4 $142
line 316
;316:			pm->ps->movementDir = 5;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 5
ASGNI4
line 317
;317:		} else if ( pm->cmd.rightmove > 0 && pm->cmd.forwardmove == 0 ) {
ADDRGP4 $130
JUMPV
LABELV $142
ADDRLP4 56
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRLP4 56
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 60
INDIRI4
LEI4 $144
ADDRLP4 56
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 60
INDIRI4
NEI4 $144
line 318
;318:			pm->ps->movementDir = 6;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 6
ASGNI4
line 319
;319:		} else if ( pm->cmd.rightmove > 0 && pm->cmd.forwardmove > 0 ) {
ADDRGP4 $130
JUMPV
LABELV $144
ADDRLP4 64
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRLP4 64
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 68
INDIRI4
LEI4 $130
ADDRLP4 64
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 68
INDIRI4
LEI4 $130
line 320
;320:			pm->ps->movementDir = 7;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 7
ASGNI4
line 321
;321:		}
line 322
;322:	} else {
ADDRGP4 $130
JUMPV
LABELV $129
line 326
;323:		// if they aren't actively going directly sideways,
;324:		// change the animation to the diagonal so they
;325:		// don't stop too crooked
;326:		if ( pm->ps->movementDir == 2 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 2
NEI4 $148
line 327
;327:			pm->ps->movementDir = 1;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 1
ASGNI4
line 328
;328:		} else if ( pm->ps->movementDir == 6 ) {
ADDRGP4 $149
JUMPV
LABELV $148
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 6
NEI4 $150
line 329
;329:			pm->ps->movementDir = 7;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 7
ASGNI4
line 330
;330:		} 
LABELV $150
LABELV $149
line 331
;331:	}
LABELV $130
line 332
;332:}
LABELV $128
endproc PM_SetMovementDir 72 0
proc PM_CheckJump 8 4
line 340
;333:
;334:
;335:/*
;336:=============
;337:PM_CheckJump
;338:=============
;339:*/
;340:static qboolean PM_CheckJump( void ) {
line 341
;341:	if ( pm->ps->pm_flags & PMF_RESPAWNED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $153
line 342
;342:		return qfalse;		// don't allow jump until all buttons are up
CNSTI4 0
RETI4
ADDRGP4 $152
JUMPV
LABELV $153
line 345
;343:	}
;344:
;345:	if ( pm->cmd.upmove < 10 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CNSTI4 10
GEI4 $155
line 347
;346:		// not holding jump
;347:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $152
JUMPV
LABELV $155
line 351
;348:	}
;349:
;350:	// must wait for jump to be released
;351:	if ( pm->ps->pm_flags & PMF_JUMP_HELD ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $157
line 353
;352:		// clear upmove so cmdscale doesn't lower running speed
;353:		pm->cmd.upmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
CNSTI1 0
ASGNI1
line 354
;354:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $152
JUMPV
LABELV $157
line 357
;355:	}
;356:
;357:	pml.groundPlane = qfalse;		// jumping away
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 358
;358:	pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 359
;359:	pm->ps->pm_flags |= PMF_JUMP_HELD;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 361
;360:
;361:	pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 362
;362:	pm->ps->velocity[2] = JUMP_VELOCITY;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1132920832
ASGNF4
line 364
;363:	// CPM: check for double-jump
;364:		if (g_pro_mode.integer) {
ADDRGP4 g_pro_mode+12
INDIRI4
CNSTI4 0
EQI4 $161
line 365
;365:			if (pm->ps->stats[STAT_JUMPTIME] > 0) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 0
LEI4 $164
line 366
;366:				pm->ps->velocity[2] += cpm_pm_jump_z;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRGP4 cpm_pm_jump_z
INDIRF4
ADDF4
ASGNF4
line 367
;367:			}
LABELV $164
line 369
;368:
;369:			pm->ps->stats[STAT_JUMPTIME] = 400;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 212
ADDP4
CNSTI4 400
ASGNI4
line 370
;370:		}
LABELV $161
line 372
;371:	// !CPM
;372:	PM_AddEvent( EV_JUMP );
CNSTI4 14
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 374
;373:
;374:	if ( pm->cmd.forwardmove >= 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LTI4 $166
line 375
;375:		PM_ForceLegsAnim( LEGS_JUMP );
CNSTI4 18
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 376
;376:		pm->ps->pm_flags &= ~PMF_BACKWARDS_JUMP;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -9
BANDI4
ASGNI4
line 377
;377:	} else {
ADDRGP4 $167
JUMPV
LABELV $166
line 378
;378:		PM_ForceLegsAnim( LEGS_JUMPB );
CNSTI4 20
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 379
;379:		pm->ps->pm_flags |= PMF_BACKWARDS_JUMP;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 380
;380:	}
LABELV $167
line 382
;381:
;382:	return qtrue;
CNSTI4 1
RETI4
LABELV $152
endproc PM_CheckJump 8 4
proc PM_CheckWaterJump 56 8
line 390
;383:}
;384:
;385:/*
;386:=============
;387:PM_CheckWaterJump
;388:=============
;389:*/
;390:static qboolean	PM_CheckWaterJump( void ) {
line 395
;391:	vec3_t	spot;
;392:	int		cont;
;393:	vec3_t	flatforward;
;394:
;395:	if (pm->ps->pm_time) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
EQI4 $169
line 396
;396:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $168
JUMPV
LABELV $169
line 400
;397:	}
;398:
;399:	// check for water jump
;400:	if ( pm->waterlevel != 2 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 2
EQI4 $171
line 401
;401:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $168
JUMPV
LABELV $171
line 404
;402:	}
;403:
;404:	flatforward[0] = pml.forward[0];
ADDRLP4 12
ADDRGP4 pml
INDIRF4
ASGNF4
line 405
;405:	flatforward[1] = pml.forward[1];
ADDRLP4 12+4
ADDRGP4 pml+4
INDIRF4
ASGNF4
line 406
;406:	flatforward[2] = 0;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 407
;407:	VectorNormalize (flatforward);
ADDRLP4 12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 409
;408:
;409:	VectorMA (pm->ps->origin, 30, flatforward, spot);
ADDRLP4 28
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 32
CNSTF4 1106247680
ASGNF4
ADDRLP4 0
ADDRLP4 28
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 28
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 1106247680
ADDRLP4 12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 410
;410:	spot[2] += 4;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1082130432
ADDF4
ASGNF4
line 411
;411:	cont = pm->pointcontents (spot, pm->ps->clientNum );
ADDRLP4 0
ARGP4
ADDRLP4 36
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
ADDRLP4 36
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 40
INDIRI4
ASGNI4
line 412
;412:	if ( !(cont & CONTENTS_SOLID) ) {
ADDRLP4 24
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $181
line 413
;413:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $168
JUMPV
LABELV $181
line 416
;414:	}
;415:
;416:	spot[2] += 16;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 417
;417:	cont = pm->pointcontents (spot, pm->ps->clientNum );
ADDRLP4 0
ARGP4
ADDRLP4 44
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
ADDRLP4 44
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 48
INDIRI4
ASGNI4
line 418
;418:	if ( cont ) {
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $184
line 419
;419:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $168
JUMPV
LABELV $184
line 423
;420:	}
;421:
;422:	// jump out of water
;423:	VectorScale (pml.forward, 200, pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1128792064
ADDRGP4 pml
INDIRF4
MULF4
ASGNF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1128792064
ADDRGP4 pml+4
INDIRF4
MULF4
ASGNF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1128792064
ADDRGP4 pml+8
INDIRF4
MULF4
ASGNF4
line 424
;424:	pm->ps->velocity[2] = 350;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1135542272
ASGNF4
line 426
;425:
;426:	pm->ps->pm_flags |= PMF_TIME_WATERJUMP;
ADDRLP4 52
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 427
;427:	pm->ps->pm_time = 2000;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 2000
ASGNI4
line 429
;428:
;429:	return qtrue;
CNSTI4 1
RETI4
LABELV $168
endproc PM_CheckWaterJump 56 8
proc PM_WaterJumpMove 12 4
line 442
;430:}
;431:
;432://============================================================================
;433:
;434:
;435:/*
;436:===================
;437:PM_WaterJumpMove
;438:
;439:Flying out of the water
;440:===================
;441:*/
;442:static void PM_WaterJumpMove( void ) {
line 445
;443:	// waterjump has no control, but falls
;444:
;445:	PM_StepSlideMove( qtrue );
CNSTI4 1
ARGI4
ADDRGP4 PM_StepSlideMove
CALLV
pop
line 447
;446:
;447:	pm->ps->velocity[2] -= pm->ps->gravity * pml.frametime;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pml+36
INDIRF4
MULF4
SUBF4
ASGNF4
line 448
;448:	if (pm->ps->velocity[2] < 0) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CNSTF4 0
GEF4 $190
line 450
;449:		// cancel as soon as we are falling down again
;450:		pm->ps->pm_flags &= ~PMF_ALL_TIMES;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -353
BANDI4
ASGNI4
line 451
;451:		pm->ps->pm_time = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 0
ASGNI4
line 452
;452:	}
LABELV $190
line 453
;453:}
LABELV $188
endproc PM_WaterJumpMove 12 4
proc PM_WaterMove 76 16
line 461
;454:
;455:/*
;456:===================
;457:PM_WaterMove
;458:
;459:===================
;460:*/
;461:static void PM_WaterMove( void ) {
line 469
;462:	int		i;
;463:	vec3_t	wishvel;
;464:	float	wishspeed;
;465:	vec3_t	wishdir;
;466:	float	scale;
;467:	float	vel;
;468:
;469:	if ( PM_CheckWaterJump() ) {
ADDRLP4 40
ADDRGP4 PM_CheckWaterJump
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $193
line 470
;470:		PM_WaterJumpMove();
ADDRGP4 PM_WaterJumpMove
CALLV
pop
line 471
;471:		return;
ADDRGP4 $192
JUMPV
LABELV $193
line 487
;472:	}
;473:#if 0
;474:	// jump = head for surface
;475:	if ( pm->cmd.upmove >= 10 ) {
;476:		if (pm->ps->velocity[2] > -300) {
;477:			if ( pm->watertype == CONTENTS_WATER ) {
;478:				pm->ps->velocity[2] = 100;
;479:			} else if (pm->watertype == CONTENTS_SLIME) {
;480:				pm->ps->velocity[2] = 80;
;481:			} else {
;482:				pm->ps->velocity[2] = 50;
;483:			}
;484:		}
;485:	}
;486:#endif
;487:	PM_Friction ();
ADDRGP4 PM_Friction
CALLV
pop
line 489
;488:
;489:	scale = PM_CmdScale( &pm->cmd );
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 44
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 44
INDIRF4
ASGNF4
line 493
;490:	//
;491:	// user intentions
;492:	//
;493:	if ( !scale ) {
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $195
line 494
;494:		wishvel[0] = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 495
;495:		wishvel[1] = 0;
ADDRLP4 8+4
CNSTF4 0
ASGNF4
line 496
;496:		wishvel[2] = -60;		// sink towards bottom
ADDRLP4 8+8
CNSTF4 3262119936
ASGNF4
line 497
;497:	} else {
ADDRGP4 $196
JUMPV
LABELV $195
line 498
;498:		for (i=0 ; i<3 ; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $199
line 499
;499:			wishvel[i] = scale * pml.forward[i]*pm->cmd.forwardmove + scale * pml.right[i]*pm->cmd.rightmove;
ADDRLP4 48
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 56
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 48
INDIRI4
ADDRLP4 8
ADDP4
ADDRLP4 4
INDIRF4
ADDRLP4 48
INDIRI4
ADDRGP4 pml
ADDP4
INDIRF4
MULF4
ADDRLP4 56
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDRLP4 4
INDIRF4
ADDRLP4 48
INDIRI4
ADDRGP4 pml+12
ADDP4
INDIRF4
MULF4
ADDRLP4 56
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDF4
ASGNF4
LABELV $200
line 498
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $199
line 501
;500:
;501:		wishvel[2] += scale * pm->cmd.upmove;
ADDRLP4 8+8
ADDRLP4 8+8
INDIRF4
ADDRLP4 4
INDIRF4
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDF4
ASGNF4
line 502
;502:	}
LABELV $196
line 504
;503:
;504:	VectorCopy (wishvel, wishdir);
ADDRLP4 24
ADDRLP4 8
INDIRB
ASGNB 12
line 505
;505:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 24
ARGP4
ADDRLP4 48
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 48
INDIRF4
ASGNF4
line 507
;506:
;507:	if ( wishspeed > pm->ps->speed * pm_swimScale ) {
ADDRLP4 20
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pm_swimScale
INDIRF4
MULF4
LEF4 $205
line 508
;508:		wishspeed = pm->ps->speed * pm_swimScale;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pm_swimScale
INDIRF4
MULF4
ASGNF4
line 509
;509:	}
LABELV $205
line 511
;510:
;511:	PM_Accelerate (wishdir, wishspeed, pm_wateraccelerate);
ADDRLP4 24
ARGP4
ADDRLP4 20
INDIRF4
ARGF4
ADDRGP4 pm_wateraccelerate
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 514
;512:
;513:	// make sure we can go up slopes easily under water
;514:	if ( pml.groundPlane && DotProduct( pm->ps->velocity, pml.groundTrace.plane.normal ) < 0 ) {
ADDRGP4 pml+48
INDIRI4
CNSTI4 0
EQI4 $207
ADDRLP4 52
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRGP4 pml+52+24
INDIRF4
MULF4
ADDRLP4 52
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRGP4 pml+52+24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 52
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRGP4 pml+52+24+8
INDIRF4
MULF4
ADDF4
CNSTF4 0
GEF4 $207
line 515
;515:		vel = VectorLength(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 56
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 36
ADDRLP4 56
INDIRF4
ASGNF4
line 517
;516:		// slide along the ground plane
;517:		PM_ClipVelocity (pm->ps->velocity, pml.groundTrace.plane.normal, 
ADDRLP4 60
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 520
;518:			pm->ps->velocity, OVERCLIP );
;519:
;520:		VectorNormalize(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 521
;521:		VectorScale(pm->ps->velocity, vel, pm->ps->velocity);
ADDRLP4 64
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ASGNF4
ADDRLP4 68
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ASGNF4
ADDRLP4 72
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ASGNF4
line 522
;522:	}
LABELV $207
line 524
;523:
;524:	PM_SlideMove( qfalse );
CNSTI4 0
ARGI4
ADDRGP4 PM_SlideMove
CALLI4
pop
line 525
;525:}
LABELV $192
endproc PM_WaterMove 76 16
proc PM_FlyMove 52 12
line 550
;526:
;527:#ifdef MISSIONPACK
;528:/*
;529:===================
;530:PM_InvulnerabilityMove
;531:
;532:Only with the invulnerability powerup
;533:===================
;534:*/
;535:static void PM_InvulnerabilityMove( void ) {
;536:	pm->cmd.forwardmove = 0;
;537:	pm->cmd.rightmove = 0;
;538:	pm->cmd.upmove = 0;
;539:	VectorClear(pm->ps->velocity);
;540:}
;541:#endif
;542:
;543:/*
;544:===================
;545:PM_FlyMove
;546:
;547:Only with the flight powerup
;548:===================
;549:*/
;550:static void PM_FlyMove( void ) {
line 558
;551:	int		i;
;552:	vec3_t	wishvel;
;553:	float	wishspeed;
;554:	vec3_t	wishdir;
;555:	float	scale;
;556:
;557:	// normal slowdown
;558:	PM_Friction ();
ADDRGP4 PM_Friction
CALLV
pop
line 560
;559:
;560:	scale = PM_CmdScale( &pm->cmd );
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 36
INDIRF4
ASGNF4
line 564
;561:	//
;562:	// user intentions
;563:	//
;564:	if ( !scale ) {
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $221
line 565
;565:		wishvel[0] = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 566
;566:		wishvel[1] = 0;
ADDRLP4 8+4
CNSTF4 0
ASGNF4
line 567
;567:		wishvel[2] = 0;
ADDRLP4 8+8
CNSTF4 0
ASGNF4
line 568
;568:	} else {
ADDRGP4 $222
JUMPV
LABELV $221
line 569
;569:		for (i=0 ; i<3 ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $225
line 570
;570:			wishvel[i] = scale * pml.forward[i]*pm->cmd.forwardmove + scale * pml.right[i]*pm->cmd.rightmove;
ADDRLP4 40
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 48
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 40
INDIRI4
ADDRLP4 8
ADDP4
ADDRLP4 4
INDIRF4
ADDRLP4 40
INDIRI4
ADDRGP4 pml
ADDP4
INDIRF4
MULF4
ADDRLP4 48
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDRLP4 4
INDIRF4
ADDRLP4 40
INDIRI4
ADDRGP4 pml+12
ADDP4
INDIRF4
MULF4
ADDRLP4 48
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDF4
ASGNF4
line 571
;571:		}
LABELV $226
line 569
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $225
line 573
;572:
;573:		wishvel[2] += scale * pm->cmd.upmove;
ADDRLP4 8+8
ADDRLP4 8+8
INDIRF4
ADDRLP4 4
INDIRF4
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDF4
ASGNF4
line 574
;574:	}
LABELV $222
line 576
;575:
;576:	VectorCopy (wishvel, wishdir);
ADDRLP4 20
ADDRLP4 8
INDIRB
ASGNB 12
line 577
;577:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 20
ARGP4
ADDRLP4 40
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 32
ADDRLP4 40
INDIRF4
ASGNF4
line 579
;578:
;579:	PM_Accelerate (wishdir, wishspeed, pm_flyaccelerate);
ADDRLP4 20
ARGP4
ADDRLP4 32
INDIRF4
ARGF4
ADDRGP4 pm_flyaccelerate
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 581
;580:
;581:	PM_StepSlideMove( qfalse );
CNSTI4 0
ARGI4
ADDRGP4 PM_StepSlideMove
CALLV
pop
line 582
;582:}
LABELV $220
endproc PM_FlyMove 52 12
proc PM_AirMove 96 16
line 591
;583:
;584:
;585:/*
;586:===================
;587:PM_AirMove
;588:
;589:===================
;590:*/
;591:static void PM_AirMove( void ) {
line 602
;592:	int			i;
;593:	vec3_t		wishvel;
;594:	float		fmove, smove;
;595:	vec3_t		wishdir;
;596:	float		wishspeed;
;597:	float		scale;
;598:	float		accel; // CPM
;599:	float		wishspeed2; // CPM
;600:	usercmd_t	cmd;
;601:
;602:	PM_Friction();
ADDRGP4 PM_Friction
CALLV
pop
line 604
;603:
;604:	fmove = pm->cmd.forwardmove;
ADDRLP4 16
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 605
;605:	smove = pm->cmd.rightmove;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 607
;606:
;607:	cmd = pm->cmd;
ADDRLP4 48
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
INDIRB
ASGNB 24
line 608
;608:	scale = PM_CmdScale( &cmd );
ADDRLP4 48
ARGP4
ADDRLP4 76
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 44
ADDRLP4 76
INDIRF4
ASGNF4
line 611
;609:
;610:	// set the movementDir so clients can rotate the legs for strafing
;611:	PM_SetMovementDir();
ADDRGP4 PM_SetMovementDir
CALLV
pop
line 614
;612:
;613:	// project moves down to flat plane
;614:	pml.forward[2] = 0;
ADDRGP4 pml+8
CNSTF4 0
ASGNF4
line 615
;615:	pml.right[2] = 0;
ADDRGP4 pml+12+8
CNSTF4 0
ASGNF4
line 616
;616:	VectorNormalize (pml.forward);
ADDRGP4 pml
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 617
;617:	VectorNormalize (pml.right);
ADDRGP4 pml+12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 619
;618:
;619:	for ( i = 0 ; i < 2 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $236
line 620
;620:		wishvel[i] = pml.forward[i]*fmove + pml.right[i]*smove;
ADDRLP4 80
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 80
INDIRI4
ADDRLP4 4
ADDP4
ADDRLP4 80
INDIRI4
ADDRGP4 pml
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDRLP4 80
INDIRI4
ADDRGP4 pml+12
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
line 621
;621:	}
LABELV $237
line 619
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $236
line 622
;622:	wishvel[2] = 0;
ADDRLP4 4+8
CNSTF4 0
ASGNF4
line 624
;623:
;624:	VectorCopy (wishvel, wishdir);
ADDRLP4 24
ADDRLP4 4
INDIRB
ASGNB 12
line 625
;625:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 24
ARGP4
ADDRLP4 80
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 36
ADDRLP4 80
INDIRF4
ASGNF4
line 626
;626:	wishspeed *= scale;
ADDRLP4 36
ADDRLP4 36
INDIRF4
ADDRLP4 44
INDIRF4
MULF4
ASGNF4
line 629
;627:
;628:	// CPM: Air Control
;629:	wishspeed2 = wishspeed;
ADDRLP4 72
ADDRLP4 36
INDIRF4
ASGNF4
line 630
;630:	if (DotProduct(pm->ps->velocity, wishdir) < 0) {
ADDRLP4 84
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ADDRLP4 84
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 84
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 24+8
INDIRF4
MULF4
ADDF4
CNSTF4 0
GEF4 $242
line 631
;631:		accel = cpm_pm_airstopaccelerate;
ADDRLP4 40
ADDRGP4 cpm_pm_airstopaccelerate
INDIRF4
ASGNF4
line 632
;632:	} else {
ADDRGP4 $243
JUMPV
LABELV $242
line 633
;633:		accel = pm_airaccelerate;
ADDRLP4 40
ADDRGP4 pm_airaccelerate
INDIRF4
ASGNF4
line 634
;634:	}
LABELV $243
line 635
;635:	if ((pm->ps->movementDir == 2 || pm->ps->movementDir == -2 || pm->ps->movementDir == 10) || 
ADDRLP4 88
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 2
EQI4 $250
ADDRLP4 88
INDIRI4
CNSTI4 -2
EQI4 $250
ADDRLP4 88
INDIRI4
CNSTI4 10
EQI4 $250
ADDRLP4 88
INDIRI4
CNSTI4 6
EQI4 $250
ADDRLP4 88
INDIRI4
CNSTI4 -6
EQI4 $250
ADDRLP4 88
INDIRI4
CNSTI4 14
NEI4 $246
LABELV $250
line 636
;636:		(pm->ps->movementDir == 6 || pm->ps->movementDir == -6 || pm->ps->movementDir == 14)) {
line 637
;637:		if (wishspeed > cpm_pm_wishspeed) {
ADDRLP4 36
INDIRF4
ADDRGP4 cpm_pm_wishspeed
INDIRF4
LEF4 $251
line 638
;638:			wishspeed = cpm_pm_wishspeed;
ADDRLP4 36
ADDRGP4 cpm_pm_wishspeed
INDIRF4
ASGNF4
line 639
;639:		}
LABELV $251
line 640
;640:		accel = cpm_pm_strafeaccelerate;
ADDRLP4 40
ADDRGP4 cpm_pm_strafeaccelerate
INDIRF4
ASGNF4
line 641
;641:	}
LABELV $246
line 647
;642:	// !CPM
;643:
;644:	// not on ground, so little effect on velocity
;645:	//PM_Accelerate (wishdir, wishspeed, pm_airaccelerate);
;646:	// CPM: Air control
;647:	PM_Accelerate (wishdir, wishspeed, accel);
ADDRLP4 24
ARGP4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 648
;648:	if (g_pro_mode.integer)
ADDRGP4 g_pro_mode+12
INDIRI4
CNSTI4 0
EQI4 $253
line 649
;649:		CPM_PM_Aircontrol (pm, wishdir, wishspeed2);
ADDRGP4 pm
INDIRP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 72
INDIRF4
ARGF4
ADDRGP4 CPM_PM_Aircontrol
CALLV
pop
LABELV $253
line 655
;650:	// !CPM
;651:
;652:	// we may have a ground plane that is very steep, even
;653:	// though we don't have a groundentity
;654:	// slide along the steep plane
;655:	if ( pml.groundPlane ) {
ADDRGP4 pml+48
INDIRI4
CNSTI4 0
EQI4 $256
line 656
;656:		PM_ClipVelocity (pm->ps->velocity, pml.groundTrace.plane.normal, 
ADDRLP4 92
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRLP4 92
INDIRP4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 658
;657:			pm->ps->velocity, OVERCLIP );
;658:	}
LABELV $256
line 670
;659:
;660:#if 0
;661:	//ZOID:  If we are on the grapple, try stair-stepping
;662:	//this allows a player to use the grapple to pull himself
;663:	//over a ledge
;664:	if (pm->ps->pm_flags & PMF_GRAPPLE_PULL)
;665:		PM_StepSlideMove ( qtrue );
;666:	else
;667:		PM_SlideMove ( qtrue );
;668:#endif
;669:
;670:	PM_StepSlideMove ( qtrue );
CNSTI4 1
ARGI4
ADDRGP4 PM_StepSlideMove
CALLV
pop
line 671
;671:}
LABELV $231
endproc PM_AirMove 96 16
proc PM_GrappleMove 52 4
line 679
;672:
;673:/*
;674:===================
;675:PM_GrappleMove
;676:
;677:===================
;678:*/
;679:static void PM_GrappleMove( void ) {
line 683
;680:	vec3_t vel, v;
;681:	float vlen;
;682:
;683:	VectorScale(pml.forward, -16, v);
ADDRLP4 28
CNSTF4 3246391296
ASGNF4
ADDRLP4 12
ADDRLP4 28
INDIRF4
ADDRGP4 pml
INDIRF4
MULF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 28
INDIRF4
ADDRGP4 pml+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 12+8
CNSTF4 3246391296
ADDRGP4 pml+8
INDIRF4
MULF4
ASGNF4
line 684
;684:	VectorAdd(pm->ps->grapplePoint, v, v);
ADDRLP4 32
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 32
INDIRP4
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 32
INDIRP4
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRLP4 12+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRLP4 12+8
INDIRF4
ADDF4
ASGNF4
line 685
;685:	VectorSubtract(v, pm->ps->origin, vel);
ADDRLP4 36
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRLP4 36
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 36
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 12+8
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
line 686
;686:	vlen = VectorLength(vel);
ADDRLP4 0
ARGP4
ADDRLP4 40
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 40
INDIRF4
ASGNF4
line 687
;687:	VectorNormalize( vel );
ADDRLP4 0
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 689
;688:
;689:	if (vlen <= 100)
ADDRLP4 24
INDIRF4
CNSTF4 1120403456
GTF4 $274
line 690
;690:		VectorScale(vel, 10 * vlen, vel);
ADDRLP4 44
CNSTF4 1092616192
ADDRLP4 24
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 44
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 44
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1092616192
ADDRLP4 24
INDIRF4
MULF4
MULF4
ASGNF4
ADDRGP4 $275
JUMPV
LABELV $274
line 692
;691:	else
;692:		VectorScale(vel, 800, vel);
ADDRLP4 48
CNSTF4 1145569280
ASGNF4
ADDRLP4 0
ADDRLP4 48
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 48
INDIRF4
ADDRLP4 0+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+8
CNSTF4 1145569280
ADDRLP4 0+8
INDIRF4
MULF4
ASGNF4
LABELV $275
line 694
;693:
;694:	VectorCopy(vel, pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 0
INDIRB
ASGNB 12
line 696
;695:
;696:	pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 697
;697:}
LABELV $261
endproc PM_GrappleMove 52 4
proc PM_WalkMove 128 16
line 705
;698:
;699:/*
;700:===================
;701:PM_WalkMove
;702:
;703:===================
;704:*/
;705:static void PM_WalkMove( void ) {
line 716
;706:	int			i;
;707:	vec3_t		wishvel;
;708:	float		fmove, smove;
;709:	vec3_t		wishdir;
;710:	float		wishspeed;
;711:	float		scale;
;712:	usercmd_t	cmd;
;713:	float		accelerate;
;714:	float		vel;
;715:
;716:	if ( pm->waterlevel > 2 && DotProduct( pml.forward, pml.groundTrace.plane.normal ) > 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 2
LEI4 $286
ADDRGP4 pml
INDIRF4
ADDRGP4 pml+52+24
INDIRF4
MULF4
ADDRGP4 pml+4
INDIRF4
ADDRGP4 pml+52+24+4
INDIRF4
MULF4
ADDF4
ADDRGP4 pml+8
INDIRF4
ADDRGP4 pml+52+24+8
INDIRF4
MULF4
ADDF4
CNSTF4 0
LEF4 $286
line 718
;717:		// begin swimming
;718:		PM_WaterMove();
ADDRGP4 PM_WaterMove
CALLV
pop
line 719
;719:		return;
ADDRGP4 $285
JUMPV
LABELV $286
line 723
;720:	}
;721:
;722:
;723:	if ( PM_CheckJump () ) {
ADDRLP4 76
ADDRGP4 PM_CheckJump
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
EQI4 $298
line 725
;724:		// jumped away
;725:		if ( pm->waterlevel > 1 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 1
LEI4 $300
line 726
;726:			PM_WaterMove();
ADDRGP4 PM_WaterMove
CALLV
pop
line 727
;727:		} else {
ADDRGP4 $285
JUMPV
LABELV $300
line 728
;728:			PM_AirMove();
ADDRGP4 PM_AirMove
CALLV
pop
line 729
;729:		}
line 730
;730:		return;
ADDRGP4 $285
JUMPV
LABELV $298
line 733
;731:	}
;732:
;733:	PM_Friction ();
ADDRGP4 PM_Friction
CALLV
pop
line 735
;734:
;735:	fmove = pm->cmd.forwardmove;
ADDRLP4 16
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 736
;736:	smove = pm->cmd.rightmove;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 738
;737:
;738:	cmd = pm->cmd;
ADDRLP4 48
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
INDIRB
ASGNB 24
line 739
;739:	scale = PM_CmdScale( &cmd );
ADDRLP4 48
ARGP4
ADDRLP4 80
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 44
ADDRLP4 80
INDIRF4
ASGNF4
line 742
;740:
;741:	// set the movementDir so clients can rotate the legs for strafing
;742:	PM_SetMovementDir();
ADDRGP4 PM_SetMovementDir
CALLV
pop
line 745
;743:
;744:	// project moves down to flat plane
;745:	pml.forward[2] = 0;
ADDRGP4 pml+8
CNSTF4 0
ASGNF4
line 746
;746:	pml.right[2] = 0;
ADDRGP4 pml+12+8
CNSTF4 0
ASGNF4
line 749
;747:
;748:	// project the forward and right directions onto the ground plane
;749:	PM_ClipVelocity (pml.forward, pml.groundTrace.plane.normal, pml.forward, OVERCLIP );
ADDRLP4 84
ADDRGP4 pml
ASGNP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRLP4 84
INDIRP4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 750
;750:	PM_ClipVelocity (pml.right, pml.groundTrace.plane.normal, pml.right, OVERCLIP );
ADDRGP4 pml+12
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRGP4 pml+12
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 752
;751:	//
;752:	VectorNormalize (pml.forward);
ADDRGP4 pml
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 753
;753:	VectorNormalize (pml.right);
ADDRGP4 pml+12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 755
;754:
;755:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $312
line 756
;756:		wishvel[i] = pml.forward[i]*fmove + pml.right[i]*smove;
ADDRLP4 88
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 88
INDIRI4
ADDRLP4 4
ADDP4
ADDRLP4 88
INDIRI4
ADDRGP4 pml
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDRLP4 88
INDIRI4
ADDRGP4 pml+12
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
line 757
;757:	}
LABELV $313
line 755
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $312
line 761
;758:	// when going up or down slopes the wish velocity should Not be zero
;759://	wishvel[2] = 0;
;760:
;761:	VectorCopy (wishvel, wishdir);
ADDRLP4 32
ADDRLP4 4
INDIRB
ASGNB 12
line 762
;762:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 32
ARGP4
ADDRLP4 88
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 88
INDIRF4
ASGNF4
line 763
;763:	wishspeed *= scale;
ADDRLP4 24
ADDRLP4 24
INDIRF4
ADDRLP4 44
INDIRF4
MULF4
ASGNF4
line 766
;764:
;765:	// clamp the speed lower if ducking
;766:	if ( pm->ps->pm_flags & PMF_DUCKED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $317
line 767
;767:		if ( wishspeed > pm->ps->speed * pm_duckScale ) {
ADDRLP4 24
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pm_duckScale
INDIRF4
MULF4
LEF4 $319
line 768
;768:			wishspeed = pm->ps->speed * pm_duckScale;
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pm_duckScale
INDIRF4
MULF4
ASGNF4
line 769
;769:		}
LABELV $319
line 770
;770:	}
LABELV $317
line 773
;771:
;772:	// clamp the speed lower if wading or walking on the bottom
;773:	if ( pm->waterlevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 0
EQI4 $321
line 776
;774:		float	waterScale;
;775:
;776:		waterScale = pm->waterlevel / 3.0;
ADDRLP4 92
ADDRGP4 pm
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1077936128
DIVF4
ASGNF4
line 777
;777:		waterScale = 1.0 - ( 1.0 - pm_swimScale ) * waterScale;
ADDRLP4 96
CNSTF4 1065353216
ASGNF4
ADDRLP4 92
ADDRLP4 96
INDIRF4
ADDRLP4 96
INDIRF4
ADDRGP4 pm_swimScale
INDIRF4
SUBF4
ADDRLP4 92
INDIRF4
MULF4
SUBF4
ASGNF4
line 778
;778:		if ( wishspeed > pm->ps->speed * waterScale ) {
ADDRLP4 24
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 92
INDIRF4
MULF4
LEF4 $323
line 779
;779:			wishspeed = pm->ps->speed * waterScale;
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 92
INDIRF4
MULF4
ASGNF4
line 780
;780:		}
LABELV $323
line 781
;781:	}
LABELV $321
line 785
;782:
;783:	// when a player gets hit, they temporarily lose
;784:	// full control, which allows them to be moved a bit
;785:	if ( ( pml.groundTrace.surfaceFlags & SURF_SLICK ) || pm->ps->pm_flags & PMF_TIME_KNOCKBACK ) {
ADDRLP4 92
CNSTI4 0
ASGNI4
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 92
INDIRI4
NEI4 $329
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 64
BANDI4
ADDRLP4 92
INDIRI4
EQI4 $325
LABELV $329
line 786
;786:		accelerate = pm_airaccelerate;
ADDRLP4 72
ADDRGP4 pm_airaccelerate
INDIRF4
ASGNF4
line 787
;787:	} else {
ADDRGP4 $326
JUMPV
LABELV $325
line 788
;788:		accelerate = pm_accelerate;
ADDRLP4 72
ADDRGP4 pm_accelerate
INDIRF4
ASGNF4
line 789
;789:	}
LABELV $326
line 791
;790:
;791:	PM_Accelerate (wishdir, wishspeed, accelerate);
ADDRLP4 32
ARGP4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 796
;792:
;793:	//Com_Printf("velocity = %1.1f %1.1f %1.1f\n", pm->ps->velocity[0], pm->ps->velocity[1], pm->ps->velocity[2]);
;794:	//Com_Printf("velocity1 = %1.1f\n", VectorLength(pm->ps->velocity));
;795:
;796:	if ( ( pml.groundTrace.surfaceFlags & SURF_SLICK ) || pm->ps->pm_flags & PMF_TIME_KNOCKBACK ) {
ADDRLP4 96
CNSTI4 0
ASGNI4
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 96
INDIRI4
NEI4 $334
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 64
BANDI4
ADDRLP4 96
INDIRI4
EQI4 $330
LABELV $334
line 797
;797:		pm->ps->velocity[2] -= pm->ps->gravity * pml.frametime;
ADDRLP4 100
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 104
ADDRLP4 100
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRF4
ADDRLP4 100
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pml+36
INDIRF4
MULF4
SUBF4
ASGNF4
line 798
;798:	} else {
LABELV $330
line 801
;799:		// don't reset the z velocity for slopes
;800://		pm->ps->velocity[2] = 0;
;801:	}
LABELV $331
line 803
;802:
;803:	vel = VectorLength(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 100
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 100
INDIRF4
ASGNF4
line 806
;804:
;805:	// slide along the ground plane
;806:	PM_ClipVelocity (pm->ps->velocity, pml.groundTrace.plane.normal, 
ADDRLP4 104
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRLP4 104
INDIRP4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 810
;807:		pm->ps->velocity, OVERCLIP );
;808:
;809:	// don't decrease velocity when going up or down a slope
;810:	VectorNormalize(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 811
;811:	VectorScale(pm->ps->velocity, vel, pm->ps->velocity);
ADDRLP4 108
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
ADDRLP4 112
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
ADDRLP4 116
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 116
INDIRP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 814
;812:
;813:	// don't do anything if standing still
;814:	if (!pm->ps->velocity[0] && !pm->ps->velocity[1]) {
ADDRLP4 120
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 124
CNSTF4 0
ASGNF4
ADDRLP4 120
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 124
INDIRF4
NEF4 $338
ADDRLP4 120
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 124
INDIRF4
NEF4 $338
line 815
;815:		return;
ADDRGP4 $285
JUMPV
LABELV $338
line 818
;816:	}
;817:
;818:	PM_StepSlideMove( qfalse );
CNSTI4 0
ARGI4
ADDRGP4 PM_StepSlideMove
CALLV
pop
line 822
;819:
;820:	//Com_Printf("velocity2 = %1.1f\n", VectorLength(pm->ps->velocity));
;821:
;822:}
LABELV $285
endproc PM_WalkMove 128 16
proc PM_DeadMove 20 4
line 830
;823:
;824:
;825:/*
;826:==============
;827:PM_DeadMove
;828:==============
;829:*/
;830:static void PM_DeadMove( void ) {
line 833
;831:	float	forward;
;832:
;833:	if ( !pml.walking ) {
ADDRGP4 pml+44
INDIRI4
CNSTI4 0
NEI4 $341
line 834
;834:		return;
ADDRGP4 $340
JUMPV
LABELV $341
line 839
;835:	}
;836:
;837:	// extra friction
;838:
;839:	forward = VectorLength (pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 840
;840:	forward -= 20;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1101004800
SUBF4
ASGNF4
line 841
;841:	if ( forward <= 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
GTF4 $344
line 842
;842:		VectorClear (pm->ps->velocity);
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 12
CNSTF4 0
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
line 843
;843:	} else {
ADDRGP4 $345
JUMPV
LABELV $344
line 844
;844:		VectorNormalize (pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 845
;845:		VectorScale (pm->ps->velocity, forward, pm->ps->velocity);
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
ADDRLP4 16
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 846
;846:	}
LABELV $345
line 847
;847:}
LABELV $340
endproc PM_DeadMove 20 4
proc PM_NoclipMove 104 12
line 855
;848:
;849:
;850:/*
;851:===============
;852:PM_NoclipMove
;853:===============
;854:*/
;855:static void PM_NoclipMove( void ) {
line 864
;856:	float	speed, drop, friction, control, newspeed;
;857:	int			i;
;858:	vec3_t		wishvel;
;859:	float		fmove, smove;
;860:	vec3_t		wishdir;
;861:	float		wishspeed;
;862:	float		scale;
;863:
;864:	pm->ps->viewheight = DEFAULT_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 26
ASGNI4
line 868
;865:
;866:	// friction
;867:
;868:	speed = VectorLength (pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 64
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 64
INDIRF4
ASGNF4
line 869
;869:	if (speed < 1)
ADDRLP4 24
INDIRF4
CNSTF4 1065353216
GEF4 $347
line 870
;870:	{
line 871
;871:		VectorCopy (vec3_origin, pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ADDRGP4 vec3_origin
INDIRB
ASGNB 12
line 872
;872:	}
ADDRGP4 $348
JUMPV
LABELV $347
line 874
;873:	else
;874:	{
line 875
;875:		drop = 0;
ADDRLP4 52
CNSTF4 0
ASGNF4
line 877
;876:
;877:		friction = pm_friction*1.5;	// extra friction
ADDRLP4 56
CNSTF4 1069547520
ADDRGP4 pm_friction
INDIRF4
MULF4
ASGNF4
line 878
;878:		control = speed < pm_stopspeed ? pm_stopspeed : speed;
ADDRLP4 24
INDIRF4
ADDRGP4 pm_stopspeed
INDIRF4
GEF4 $350
ADDRLP4 68
ADDRGP4 pm_stopspeed
INDIRF4
ASGNF4
ADDRGP4 $351
JUMPV
LABELV $350
ADDRLP4 68
ADDRLP4 24
INDIRF4
ASGNF4
LABELV $351
ADDRLP4 60
ADDRLP4 68
INDIRF4
ASGNF4
line 879
;879:		drop += control*friction*pml.frametime;
ADDRLP4 52
ADDRLP4 52
INDIRF4
ADDRLP4 60
INDIRF4
ADDRLP4 56
INDIRF4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 882
;880:
;881:		// scale the velocity
;882:		newspeed = speed - drop;
ADDRLP4 28
ADDRLP4 24
INDIRF4
ADDRLP4 52
INDIRF4
SUBF4
ASGNF4
line 883
;883:		if (newspeed < 0)
ADDRLP4 28
INDIRF4
CNSTF4 0
GEF4 $353
line 884
;884:			newspeed = 0;
ADDRLP4 28
CNSTF4 0
ASGNF4
LABELV $353
line 885
;885:		newspeed /= speed;
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 24
INDIRF4
DIVF4
ASGNF4
line 887
;886:
;887:		VectorScale (pm->ps->velocity, newspeed, pm->ps->velocity);
ADDRLP4 72
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
ADDRLP4 80
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 888
;888:	}
LABELV $348
line 891
;889:
;890:	// accelerate
;891:	scale = PM_CmdScale( &pm->cmd );
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 68
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 48
ADDRLP4 68
INDIRF4
ASGNF4
line 893
;892:
;893:	fmove = pm->cmd.forwardmove;
ADDRLP4 16
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 894
;894:	smove = pm->cmd.rightmove;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 896
;895:	
;896:	for (i=0 ; i<3 ; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $355
line 897
;897:		wishvel[i] = pml.forward[i]*fmove + pml.right[i]*smove;
ADDRLP4 72
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 72
INDIRI4
ADDRLP4 4
ADDP4
ADDRLP4 72
INDIRI4
ADDRGP4 pml
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDRLP4 72
INDIRI4
ADDRGP4 pml+12
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $356
line 896
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $355
line 898
;898:	wishvel[2] += pm->cmd.upmove;
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ADDF4
ASGNF4
line 900
;899:
;900:	VectorCopy (wishvel, wishdir);
ADDRLP4 32
ADDRLP4 4
INDIRB
ASGNB 12
line 901
;901:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 32
ARGP4
ADDRLP4 76
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 44
ADDRLP4 76
INDIRF4
ASGNF4
line 902
;902:	wishspeed *= scale;
ADDRLP4 44
ADDRLP4 44
INDIRF4
ADDRLP4 48
INDIRF4
MULF4
ASGNF4
line 904
;903:
;904:	PM_Accelerate( wishdir, wishspeed, pm_accelerate );
ADDRLP4 32
ARGP4
ADDRLP4 44
INDIRF4
ARGF4
ADDRGP4 pm_accelerate
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 907
;905:
;906:	// move
;907:	VectorMA (pm->ps->origin, pml.frametime, pm->ps->velocity, pm->ps->origin);
ADDRLP4 80
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 84
ADDRLP4 80
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 88
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 92
ADDRLP4 88
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRF4
ADDRLP4 88
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 96
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 100
ADDRLP4 96
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRF4
ADDRLP4 96
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 908
;908:}
LABELV $346
endproc PM_NoclipMove 104 12
proc PM_FootstepForSurface 0 0
line 919
;909:
;910://============================================================================
;911:
;912:/*
;913:================
;914:PM_FootstepForSurface
;915:
;916:Returns an event number apropriate for the groundsurface
;917:================
;918:*/
;919:static int PM_FootstepForSurface( void ) {
line 920
;920:	if ( pml.groundTrace.surfaceFlags & SURF_NOSTEPS ) {
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $365
line 921
;921:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $364
JUMPV
LABELV $365
line 923
;922:	}
;923:	if ( pml.groundTrace.surfaceFlags & SURF_METALSTEPS ) {
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $369
line 924
;924:		return EV_FOOTSTEP_METAL;
CNSTI4 2
RETI4
ADDRGP4 $364
JUMPV
LABELV $369
line 926
;925:	}
;926:	return EV_FOOTSTEP;
CNSTI4 1
RETI4
LABELV $364
endproc PM_FootstepForSurface 0 0
proc PM_CrashLand 56 4
line 937
;927:}
;928:
;929:
;930:/*
;931:=================
;932:PM_CrashLand
;933:
;934:Check for hard landings that generate sound events
;935:=================
;936:*/
;937:static void PM_CrashLand( void ) {
line 945
;938:	float		delta;
;939:	float		dist;
;940:	float		vel, acc;
;941:	float		t;
;942:	float		a, b, c, den;
;943:
;944:	// decide which landing animation to use
;945:	if ( pm->ps->pm_flags & PMF_BACKWARDS_JUMP ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $374
line 946
;946:		PM_ForceLegsAnim( LEGS_LANDB );
CNSTI4 21
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 947
;947:	} else {
ADDRGP4 $375
JUMPV
LABELV $374
line 948
;948:		PM_ForceLegsAnim( LEGS_LAND );
CNSTI4 19
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 949
;949:	}
LABELV $375
line 951
;950:
;951:	pm->ps->legsTimer = TIMER_LAND;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 130
ASGNI4
line 954
;952:
;953:	// calculate the exact velocity on landing
;954:	dist = pm->ps->origin[2] - pml.previous_origin[2];
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRGP4 pml+112+8
INDIRF4
SUBF4
ASGNF4
line 955
;955:	vel = pml.previous_velocity[2];
ADDRLP4 8
ADDRGP4 pml+124+8
INDIRF4
ASGNF4
line 956
;956:	acc = -pm->ps->gravity;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
NEGI4
CVIF4 4
ASGNF4
line 958
;957:
;958:	a = acc / 2;
ADDRLP4 16
ADDRLP4 12
INDIRF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 959
;959:	b = vel;
ADDRLP4 4
ADDRLP4 8
INDIRF4
ASGNF4
line 960
;960:	c = -dist;
ADDRLP4 32
ADDRLP4 24
INDIRF4
NEGF4
ASGNF4
line 962
;961:
;962:	den =  b * b - 4 * a * c;
ADDRLP4 20
ADDRLP4 4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
CNSTF4 1082130432
ADDRLP4 16
INDIRF4
MULF4
ADDRLP4 32
INDIRF4
MULF4
SUBF4
ASGNF4
line 963
;963:	if ( den < 0 ) {
ADDRLP4 20
INDIRF4
CNSTF4 0
GEF4 $380
line 964
;964:		return;
ADDRGP4 $373
JUMPV
LABELV $380
line 966
;965:	}
;966:	t = (-b - sqrt( den ) ) / ( 2 * a );
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 4
INDIRF4
NEGF4
ADDRLP4 40
INDIRF4
SUBF4
CNSTF4 1073741824
ADDRLP4 16
INDIRF4
MULF4
DIVF4
ASGNF4
line 968
;967:
;968:	delta = vel + t * acc;
ADDRLP4 0
ADDRLP4 8
INDIRF4
ADDRLP4 28
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
line 969
;969:	delta = delta*delta * 0.0001;
ADDRLP4 0
CNSTF4 953267991
ADDRLP4 0
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
MULF4
ASGNF4
line 972
;970:
;971:	// ducking while falling doubles damage
;972:	if ( pm->ps->pm_flags & PMF_DUCKED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $382
line 973
;973:		delta *= 2;
ADDRLP4 0
CNSTF4 1073741824
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 974
;974:	}
LABELV $382
line 977
;975:
;976:	// never take falling damage if completely underwater
;977:	if ( pm->waterlevel == 3 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 3
NEI4 $384
line 978
;978:		return;
ADDRGP4 $373
JUMPV
LABELV $384
line 982
;979:	}
;980:
;981:	// reduce falling damage if there is standing water
;982:	if ( pm->waterlevel == 2 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 2
NEI4 $386
line 983
;983:		delta *= 0.25;
ADDRLP4 0
CNSTF4 1048576000
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 984
;984:	}
LABELV $386
line 985
;985:	if ( pm->waterlevel == 1 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 1
NEI4 $388
line 986
;986:		delta *= 0.5;
ADDRLP4 0
CNSTF4 1056964608
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 987
;987:	}
LABELV $388
line 989
;988:
;989:	if ( delta < 1 ) {
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
GEF4 $390
line 990
;990:		return;
ADDRGP4 $373
JUMPV
LABELV $390
line 997
;991:	}
;992:
;993:	// create a local entity event to play the sound
;994:
;995:	// SURF_NODAMAGE is used for bounce pads where you don't ever
;996:	// want to take damage or play a crunch sound
;997:	if ( !(pml.groundTrace.surfaceFlags & SURF_NODAMAGE) )  {
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $392
line 998
;998:		if ( pm->ps->stats[STAT_HEALTH] > 0 ) { //If you're dead, why do falling stuff?
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LEI4 $396
line 1012
;999:			/*if ( g_AdvancedDamage.integer == 1 ) {
;1000:				if ( delta > 39 ) {
;1001:					pm->adDistance = (int)delta;
;1002://					pm->ad[pm->ps->clientNum]->distance = (int)delta;
;1003:					//ad->damage = ((int)delta) \ 8;
;1004:					PM_AddEvent( EV_FALL_ADV );
;1005:					return;
;1006:				} else if ( delta > 7 ) {
;1007:					PM_AddEvent( EV_FALL_SHORT );
;1008:				} else {
;1009:					PM_AddEvent( PM_FootstepForSurface() );
;1010:				}
;1011:			} else {*/
;1012:				 if ( delta > 60 ) {
ADDRLP4 0
INDIRF4
CNSTF4 1114636288
LEF4 $398
line 1013
;1013:					PM_AddEvent( EV_FALL_FAR );
CNSTI4 12
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1014
;1014:				} else if ( delta > 40 ) {
ADDRGP4 $397
JUMPV
LABELV $398
ADDRLP4 0
INDIRF4
CNSTF4 1109393408
LEF4 $400
line 1017
;1015:					// this is a pain grunt, so don't play it if dead
;1016:				//if ( pm->ps->stats[STAT_HEALTH] > 0 ) {
;1017:					PM_AddEvent( EV_FALL_MEDIUM );
CNSTI4 11
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1019
;1018:				//}
;1019:				} else if ( delta > 7 ) {
ADDRGP4 $397
JUMPV
LABELV $400
ADDRLP4 0
INDIRF4
CNSTF4 1088421888
LEF4 $402
line 1020
;1020:					PM_AddEvent( EV_FALL_SHORT );
CNSTI4 10
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1024
;1021:				//} else {
;1022:				//	PM_AddEvent( PM_FootstepForSurface() );
;1023:				//}
;1024:				} else if (!pm->noFootsteps){
ADDRGP4 $397
JUMPV
LABELV $402
ADDRGP4 pm
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 0
NEI4 $397
line 1025
;1025:					PM_AddEvent( PM_FootstepForSurface() );
ADDRLP4 48
ADDRGP4 PM_FootstepForSurface
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1026
;1026:				}
line 1028
;1027:			//}
;1028:		} else {//subtract 40 from the players health so they gib upon landing
ADDRGP4 $397
JUMPV
LABELV $396
line 1029
;1029:			pm->ps->stats[STAT_HEALTH] -= 40;
ADDRLP4 48
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 184
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 40
SUBI4
ASGNI4
line 1030
;1030:			if ( delta > 40 && (pm->ps->stats[STAT_HEALTH] > -40 && pm->ps->stats[STAT_HEALTH] < 1) ) {
ADDRLP4 0
INDIRF4
CNSTF4 1109393408
LEF4 $406
ADDRLP4 52
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 -40
LEI4 $406
ADDRLP4 52
INDIRI4
CNSTI4 1
GEI4 $406
line 1031
;1031:				PM_AddEvent( EV_GIB_PLAYER );
CNSTI4 64
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1032
;1032:			}
LABELV $406
line 1033
;1033:		}
LABELV $397
line 1034
;1034:	}
LABELV $392
line 1037
;1035:
;1036:	// start footstep cycle over
;1037:	pm->ps->bobCycle = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 0
ASGNI4
line 1038
;1038:}
LABELV $373
endproc PM_CrashLand 56 4
proc PM_CorrectAllSolid 36 28
line 1061
;1039:
;1040:/*
;1041:=============
;1042:PM_CheckStuck
;1043:=============
;1044:*/
;1045:/*
;1046:void PM_CheckStuck(void) {
;1047:	trace_t trace;
;1048:
;1049:	pm->trace (&trace, pm->ps->origin, pm->mins, pm->maxs, pm->ps->origin, pm->ps->clientNum, pm->tracemask);
;1050:	if (trace.allsolid) {
;1051:		//int shit = qtrue;
;1052:	}
;1053:}
;1054:*/
;1055:
;1056:/*
;1057:=============
;1058:PM_CorrectAllSolid
;1059:=============
;1060:*/
;1061:static int PM_CorrectAllSolid( trace_t *trace ) {
line 1065
;1062:	int			i, j, k;
;1063:	vec3_t		point;
;1064:
;1065:	if ( pm->debugLevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $409
line 1066
;1066:		Com_Printf("%i:allsolid\n", c_pmove);
ADDRGP4 $411
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1067
;1067:	}
LABELV $409
line 1070
;1068:
;1069:	// jitter around
;1070:	for (i = -1; i <= 1; i++) {
ADDRLP4 20
CNSTI4 -1
ASGNI4
LABELV $412
line 1071
;1071:		for (j = -1; j <= 1; j++) {
ADDRLP4 16
CNSTI4 -1
ASGNI4
LABELV $416
line 1072
;1072:			for (k = -1; k <= 1; k++) {
ADDRLP4 12
CNSTI4 -1
ASGNI4
LABELV $420
line 1073
;1073:				VectorCopy(pm->ps->origin, point);
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 1074
;1074:				point[0] += (float) i;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1075
;1075:				point[1] += (float) j;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 16
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1076
;1076:				point[2] += (float) k;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 12
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1077
;1077:				pm->trace (trace, point, pm->mins, pm->maxs, point, pm->ps->clientNum, pm->tracemask);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 24
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 184
ADDP4
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 196
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 24
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
CALLV
pop
line 1078
;1078:				if ( !trace->allsolid ) {
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $426
line 1079
;1079:					point[0] = pm->ps->origin[0];
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
line 1080
;1080:					point[1] = pm->ps->origin[1];
ADDRLP4 0+4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1081
;1081:					point[2] = pm->ps->origin[2] - 0.25;
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 1048576000
SUBF4
ASGNF4
line 1083
;1082:
;1083:					pm->trace (trace, pm->ps->origin, pm->mins, pm->maxs, point, pm->ps->clientNum, pm->tracemask);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 32
ADDRLP4 28
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 184
ADDP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 196
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
CALLV
pop
line 1084
;1084:					pml.groundTrace = *trace;
ADDRGP4 pml+52
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 56
line 1085
;1085:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $408
JUMPV
LABELV $426
line 1087
;1086:				}
;1087:			}
LABELV $421
line 1072
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 1
LEI4 $420
line 1088
;1088:		}
LABELV $417
line 1071
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 1
LEI4 $416
line 1089
;1089:	}
LABELV $413
line 1070
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 1
LEI4 $412
line 1091
;1090:
;1091:	pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 1092
;1092:	pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 1093
;1093:	pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1095
;1094:
;1095:	return qfalse;
CNSTI4 0
RETI4
LABELV $408
endproc PM_CorrectAllSolid 36 28
proc PM_GroundTraceMissed 80 28
line 1106
;1096:}
;1097:
;1098:
;1099:/*
;1100:=============
;1101:PM_GroundTraceMissed
;1102:
;1103:The ground trace didn't hit a surface, so we are in freefall
;1104:=============
;1105:*/
;1106:static void PM_GroundTraceMissed( void ) {
line 1110
;1107:	trace_t		trace;
;1108:	vec3_t		point;
;1109:
;1110:	if ( pm->ps->groundEntityNum != ENTITYNUM_NONE ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1023
EQI4 $434
line 1112
;1111:		// we just transitioned into freefall
;1112:		if ( pm->debugLevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $436
line 1113
;1113:			Com_Printf("%i:lift\n", c_pmove);
ADDRGP4 $438
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1114
;1114:		}
LABELV $436
line 1118
;1115:
;1116:		// if they aren't in a jumping animation and the ground is a ways away, force into it
;1117:		// if we didn't do the trace, the player would be backflipping down staircases
;1118:		VectorCopy( pm->ps->origin, point );
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 1119
;1119:		point[2] -= 64;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1115684864
SUBF4
ASGNF4
line 1121
;1120:
;1121:		pm->trace (&trace, pm->ps->origin, pm->mins, pm->maxs, point, pm->ps->clientNum, pm->tracemask);
ADDRLP4 12
ARGP4
ADDRLP4 68
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 72
ADDRLP4 68
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 184
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 196
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
CALLV
pop
line 1122
;1122:		if ( trace.fraction == 1.0 ) {
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
NEF4 $440
line 1123
;1123:			if ( pm->cmd.forwardmove >= 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LTI4 $443
line 1124
;1124:				PM_ForceLegsAnim( LEGS_JUMP );
CNSTI4 18
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 1125
;1125:				pm->ps->pm_flags &= ~PMF_BACKWARDS_JUMP;
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 -9
BANDI4
ASGNI4
line 1126
;1126:			} else {
ADDRGP4 $444
JUMPV
LABELV $443
line 1127
;1127:				PM_ForceLegsAnim( LEGS_JUMPB );
CNSTI4 20
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 1128
;1128:				pm->ps->pm_flags |= PMF_BACKWARDS_JUMP;
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 1129
;1129:			}
LABELV $444
line 1130
;1130:		}
LABELV $440
line 1131
;1131:	}
LABELV $434
line 1133
;1132:
;1133:	pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 1134
;1134:	pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 1135
;1135:	pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1136
;1136:}
LABELV $433
endproc PM_GroundTraceMissed 80 28
proc PM_GroundTrace 88 28
line 1144
;1137:
;1138:
;1139:/*
;1140:=============
;1141:PM_GroundTrace
;1142:=============
;1143:*/
;1144:static void PM_GroundTrace( void ) {
line 1148
;1145:	vec3_t		point;
;1146:	trace_t		trace;
;1147:
;1148:	point[0] = pm->ps->origin[0];
ADDRLP4 56
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
line 1149
;1149:	point[1] = pm->ps->origin[1];
ADDRLP4 56+4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1150
;1150:	point[2] = pm->ps->origin[2] - 0.25;
ADDRLP4 56+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 1048576000
SUBF4
ASGNF4
line 1152
;1151:
;1152:	pm->trace (&trace, pm->ps->origin, pm->mins, pm->maxs, point, pm->ps->clientNum, pm->tracemask);
ADDRLP4 0
ARGP4
ADDRLP4 68
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 72
ADDRLP4 68
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 184
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 196
ADDP4
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
CALLV
pop
line 1153
;1153:	pml.groundTrace = trace;
ADDRGP4 pml+52
ADDRLP4 0
INDIRB
ASGNB 56
line 1156
;1154:
;1155:	// do something corrective if the trace starts in a solid...
;1156:	if ( trace.allsolid ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $451
line 1157
;1157:		if ( !PM_CorrectAllSolid(&trace) )
ADDRLP4 0
ARGP4
ADDRLP4 76
ADDRGP4 PM_CorrectAllSolid
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $453
line 1158
;1158:			return;
ADDRGP4 $447
JUMPV
LABELV $453
line 1159
;1159:	}
LABELV $451
line 1162
;1160:
;1161:	// if the trace didn't hit anything, we are in free fall
;1162:	if ( trace.fraction == 1.0 ) {
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
NEF4 $455
line 1163
;1163:		PM_GroundTraceMissed();
ADDRGP4 PM_GroundTraceMissed
CALLV
pop
line 1164
;1164:		pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 1165
;1165:		pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1166
;1166:		return;
ADDRGP4 $447
JUMPV
LABELV $455
line 1170
;1167:	}
;1168:
;1169:	// check if getting thrown off the ground
;1170:	if ( pm->ps->velocity[2] > 0 && DotProduct( pm->ps->velocity, trace.plane.normal ) > 10 ) {
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 80
ADDRLP4 76
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ASGNF4
ADDRLP4 80
INDIRF4
CNSTF4 0
LEF4 $460
ADDRLP4 76
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0+24
INDIRF4
MULF4
ADDRLP4 76
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 0+24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 80
INDIRF4
ADDRLP4 0+24+8
INDIRF4
MULF4
ADDF4
CNSTF4 1092616192
LEF4 $460
line 1171
;1171:		if ( pm->debugLevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $467
line 1172
;1172:			Com_Printf("%i:kickoff\n", c_pmove);
ADDRGP4 $469
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1173
;1173:		}
LABELV $467
line 1175
;1174:		// go into jump animation
;1175:		if ( pm->cmd.forwardmove >= 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LTI4 $470
line 1176
;1176:			PM_ForceLegsAnim( LEGS_JUMP );
CNSTI4 18
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 1177
;1177:			pm->ps->pm_flags &= ~PMF_BACKWARDS_JUMP;
ADDRLP4 84
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 -9
BANDI4
ASGNI4
line 1178
;1178:		} else {
ADDRGP4 $471
JUMPV
LABELV $470
line 1179
;1179:			PM_ForceLegsAnim( LEGS_JUMPB );
CNSTI4 20
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 1180
;1180:			pm->ps->pm_flags |= PMF_BACKWARDS_JUMP;
ADDRLP4 84
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 1181
;1181:		}
LABELV $471
line 1183
;1182:
;1183:		pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 1184
;1184:		pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 1185
;1185:		pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1186
;1186:		return;
ADDRGP4 $447
JUMPV
LABELV $460
line 1190
;1187:	}
;1188:	
;1189:	// slopes that are too steep will not be considered onground
;1190:	if ( trace.plane.normal[2] < MIN_WALK_NORMAL ) {
ADDRLP4 0+24+8
INDIRF4
CNSTF4 1060320051
GEF4 $474
line 1191
;1191:		if ( pm->debugLevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $478
line 1192
;1192:			Com_Printf("%i:steep\n", c_pmove);
ADDRGP4 $480
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1193
;1193:		}
LABELV $478
line 1196
;1194:		// FIXME: if they can't slide down the slope, let them
;1195:		// walk (sharp crevices)
;1196:		pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 1197
;1197:		pml.groundPlane = qtrue;
ADDRGP4 pml+48
CNSTI4 1
ASGNI4
line 1198
;1198:		pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1199
;1199:		return;
ADDRGP4 $447
JUMPV
LABELV $474
line 1202
;1200:	}
;1201:
;1202:	pml.groundPlane = qtrue;
ADDRGP4 pml+48
CNSTI4 1
ASGNI4
line 1203
;1203:	pml.walking = qtrue;
ADDRGP4 pml+44
CNSTI4 1
ASGNI4
line 1206
;1204:
;1205:	// hitting solid ground will end a waterjump
;1206:	if (pm->ps->pm_flags & PMF_TIME_WATERJUMP)
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $485
line 1207
;1207:	{
line 1208
;1208:		pm->ps->pm_flags &= ~(PMF_TIME_WATERJUMP | PMF_TIME_LAND);
ADDRLP4 84
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 -289
BANDI4
ASGNI4
line 1209
;1209:		pm->ps->pm_time = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 0
ASGNI4
line 1210
;1210:	}
LABELV $485
line 1212
;1211:
;1212:	if ( pm->ps->groundEntityNum == ENTITYNUM_NONE ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1023
NEI4 $487
line 1214
;1213:		// just hit the ground
;1214:		if ( pm->debugLevel ) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $489
line 1215
;1215:			Com_Printf("%i:Land\n", c_pmove);
ADDRGP4 $491
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1216
;1216:		}
LABELV $489
line 1218
;1217:		
;1218:		PM_CrashLand();
ADDRGP4 PM_CrashLand
CALLV
pop
line 1221
;1219:
;1220:		// don't do landing time if we were just going down a slope
;1221:		if ( pml.previous_velocity[2] < -200 ) {
ADDRGP4 pml+124+8
INDIRF4
CNSTF4 3276275712
GEF4 $492
line 1223
;1222:			// don't allow another jump for a little while
;1223:			pm->ps->pm_flags |= PMF_TIME_LAND;
ADDRLP4 84
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 1224
;1224:			pm->ps->pm_time = 250;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 250
ASGNI4
line 1225
;1225:		}
LABELV $492
line 1226
;1226:	}
LABELV $487
line 1228
;1227:
;1228:	pm->ps->groundEntityNum = trace.entityNum;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 0+52
INDIRI4
ASGNI4
line 1233
;1229:
;1230:	// don't reset the z velocity for slopes
;1231://	pm->ps->velocity[2] = 0;
;1232:
;1233:	PM_AddTouchEnt( trace.entityNum );
ADDRLP4 0+52
INDIRI4
ARGI4
ADDRGP4 PM_AddTouchEnt
CALLV
pop
line 1234
;1234:}
LABELV $447
endproc PM_GroundTrace 88 28
proc PM_SetWaterLevel 48 8
line 1242
;1235:
;1236:
;1237:/*
;1238:=============
;1239:PM_SetWaterLevel	FIXME: avoid this twice?  certainly if not moving
;1240:=============
;1241:*/
;1242:static void PM_SetWaterLevel( void ) {
line 1251
;1243:	vec3_t		point;
;1244:	int			cont;
;1245:	int			sample1;
;1246:	int			sample2;
;1247:
;1248:	//
;1249:	// get waterlevel, accounting for ducking
;1250:	//
;1251:	pm->waterlevel = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 212
ADDP4
CNSTI4 0
ASGNI4
line 1252
;1252:	pm->watertype = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
CNSTI4 0
ASGNI4
line 1254
;1253:
;1254:	point[0] = pm->ps->origin[0];
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
line 1255
;1255:	point[1] = pm->ps->origin[1];
ADDRLP4 0+4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1256
;1256:	point[2] = pm->ps->origin[2] + MINS_Z + 1;	
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 3250585600
ADDF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1257
;1257:	cont = pm->pointcontents( point, pm->ps->clientNum );
ADDRLP4 0
ARGP4
ADDRLP4 24
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 28
INDIRI4
ASGNI4
line 1259
;1258:
;1259:	if ( cont & MASK_WATER ) {
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $501
line 1260
;1260:		sample2 = pm->ps->viewheight - MINS_Z;
ADDRLP4 16
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 -24
SUBI4
ASGNI4
line 1261
;1261:		sample1 = sample2 / 2;
ADDRLP4 20
ADDRLP4 16
INDIRI4
CNSTI4 2
DIVI4
ASGNI4
line 1263
;1262:
;1263:		pm->watertype = cont;
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1264
;1264:		pm->waterlevel = 1;
ADDRGP4 pm
INDIRP4
CNSTI4 212
ADDP4
CNSTI4 1
ASGNI4
line 1265
;1265:		point[2] = pm->ps->origin[2] + MINS_Z + sample1;
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 3250585600
ADDF4
ADDRLP4 20
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1266
;1266:		cont = pm->pointcontents (point, pm->ps->clientNum );
ADDRLP4 0
ARGP4
ADDRLP4 32
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ADDRLP4 32
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 36
INDIRI4
ASGNI4
line 1267
;1267:		if ( cont & MASK_WATER ) {
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $504
line 1268
;1268:			pm->waterlevel = 2;
ADDRGP4 pm
INDIRP4
CNSTI4 212
ADDP4
CNSTI4 2
ASGNI4
line 1269
;1269:			point[2] = pm->ps->origin[2] + MINS_Z + sample2;
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 3250585600
ADDF4
ADDRLP4 16
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1270
;1270:			cont = pm->pointcontents (point, pm->ps->clientNum );
ADDRLP4 0
ARGP4
ADDRLP4 40
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
ADDRLP4 40
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 44
INDIRI4
ASGNI4
line 1271
;1271:			if ( cont & MASK_WATER ){
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $507
line 1272
;1272:				pm->waterlevel = 3;
ADDRGP4 pm
INDIRP4
CNSTI4 212
ADDP4
CNSTI4 3
ASGNI4
line 1273
;1273:			}
LABELV $507
line 1274
;1274:		}
LABELV $504
line 1275
;1275:	}
LABELV $501
line 1277
;1276:
;1277:}
LABELV $498
endproc PM_SetWaterLevel 48 8
proc PM_CheckDuck 76 28
line 1287
;1278:
;1279:/*
;1280:==============
;1281:PM_CheckDuck
;1282:
;1283:Sets mins, maxs, and pm->ps->viewheight
;1284:==============
;1285:*/
;1286:static void PM_CheckDuck (void)
;1287:{
line 1290
;1288:	trace_t	trace;
;1289:
;1290:	if ( pm->ps->powerups[PW_INVULNERABILITY] ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 368
ADDP4
INDIRI4
CNSTI4 0
EQI4 $510
line 1291
;1291:		if ( pm->ps->pm_flags & PMF_INVULEXPAND ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $512
line 1293
;1292:			// invulnerability sphere has a 42 units radius
;1293:			VectorSet( pm->mins, -42, -42, -42 );
ADDRGP4 pm
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 3257401344
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 3257401344
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 3257401344
ASGNF4
line 1294
;1294:			VectorSet( pm->maxs, 42, 42, 42 );
ADDRGP4 pm
INDIRP4
CNSTI4 196
ADDP4
CNSTF4 1109917696
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 1109917696
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
CNSTF4 1109917696
ASGNF4
line 1295
;1295:		}
ADDRGP4 $513
JUMPV
LABELV $512
line 1296
;1296:		else {
line 1297
;1297:			VectorSet( pm->mins, -15, -15, MINS_Z );
ADDRGP4 pm
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 3245342720
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 3245342720
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 3250585600
ASGNF4
line 1298
;1298:			VectorSet( pm->maxs, 15, 15, 16 );
ADDRGP4 pm
INDIRP4
CNSTI4 196
ADDP4
CNSTF4 1097859072
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 1097859072
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
CNSTF4 1098907648
ASGNF4
line 1299
;1299:		}
LABELV $513
line 1300
;1300:		pm->ps->pm_flags |= PMF_DUCKED;
ADDRLP4 56
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
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
line 1301
;1301:		pm->ps->viewheight = CROUCH_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 12
ASGNI4
line 1302
;1302:		return;
ADDRGP4 $509
JUMPV
LABELV $510
line 1304
;1303:	}
;1304:	pm->ps->pm_flags &= ~PMF_INVULEXPAND;
ADDRLP4 56
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 -16385
BANDI4
ASGNI4
line 1306
;1305:
;1306:	pm->mins[0] = -15;
ADDRGP4 pm
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 3245342720
ASGNF4
line 1307
;1307:	pm->mins[1] = -15;
ADDRGP4 pm
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 3245342720
ASGNF4
line 1309
;1308:
;1309:	pm->maxs[0] = 15;
ADDRGP4 pm
INDIRP4
CNSTI4 196
ADDP4
CNSTF4 1097859072
ASGNF4
line 1310
;1310:	pm->maxs[1] = 15;
ADDRGP4 pm
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 1097859072
ASGNF4
line 1312
;1311:
;1312:	pm->mins[2] = MINS_Z;
ADDRGP4 pm
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 3250585600
ASGNF4
line 1314
;1313:
;1314:	if (pm->ps->pm_type == PM_DEAD /*&& pm->timeOfDeath < pm->commandTime*/ )
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $514
line 1315
;1315:	{
line 1316
;1316:		pm->maxs[2] = -8;
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
CNSTF4 3238002688
ASGNF4
line 1317
;1317:		pm->ps->viewheight = DEAD_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 -16
ASGNI4
line 1318
;1318:		return;
ADDRGP4 $509
JUMPV
LABELV $514
line 1321
;1319:	}
;1320:
;1321:	if (pm->cmd.upmove < 0)
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $516
line 1322
;1322:	{	// duck
line 1323
;1323:		pm->ps->pm_flags |= PMF_DUCKED;
ADDRLP4 60
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1324
;1324:	}
ADDRGP4 $517
JUMPV
LABELV $516
line 1326
;1325:	else
;1326:	{	// stand up if possible
line 1327
;1327:		if (pm->ps->pm_flags & PMF_DUCKED)
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $518
line 1328
;1328:		{
line 1330
;1329:			// try to stand up
;1330:			pm->maxs[2] = 32;
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
CNSTF4 1107296256
ASGNF4
line 1331
;1331:			pm->trace (&trace, pm->ps->origin, pm->mins, pm->maxs, pm->ps->origin, pm->ps->clientNum, pm->tracemask );
ADDRLP4 0
ARGP4
ADDRLP4 60
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 64
ADDRLP4 60
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 68
ADDRLP4 64
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 184
ADDP4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 196
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
CALLV
pop
line 1332
;1332:			if (!trace.allsolid)
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $520
line 1333
;1333:				pm->ps->pm_flags &= ~PMF_DUCKED;
ADDRLP4 72
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
LABELV $520
line 1334
;1334:		}
LABELV $518
line 1335
;1335:	}
LABELV $517
line 1337
;1336:
;1337:	if (pm->ps->pm_flags & PMF_DUCKED)
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $522
line 1338
;1338:	{
line 1339
;1339:		pm->maxs[2] = 16;
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
CNSTF4 1098907648
ASGNF4
line 1340
;1340:		pm->ps->viewheight = CROUCH_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 12
ASGNI4
line 1341
;1341:	}
ADDRGP4 $523
JUMPV
LABELV $522
line 1343
;1342:	else
;1343:	{
line 1344
;1344:		pm->maxs[2] = 32;
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
CNSTF4 1107296256
ASGNF4
line 1345
;1345:		pm->ps->viewheight = DEFAULT_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 26
ASGNI4
line 1346
;1346:	}
LABELV $523
line 1347
;1347:}
LABELV $509
endproc PM_CheckDuck 76 28
proc PM_Footsteps 52 4
line 1359
;1348:
;1349:
;1350:
;1351://===================================================================
;1352:
;1353:
;1354:/*
;1355:===============
;1356:PM_Footsteps
;1357:===============
;1358:*/
;1359:static void PM_Footsteps( void ) {
line 1368
;1360:	float		bobmove;
;1361:	int			old;
;1362:	qboolean	footstep;
;1363:
;1364:	//
;1365:	// calculate speed and cycle to be used for
;1366:	// all cyclic walking effects
;1367:	//
;1368:	pm->xyspeed = sqrt( pm->ps->velocity[0] * pm->ps->velocity[0]
ADDRLP4 12
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 12
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 16
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ASGNF4
ADDRLP4 24
ADDRLP4 16
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ASGNF4
ADDRLP4 20
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDRLP4 24
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 28
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 216
ADDP4
ADDRLP4 28
INDIRF4
ASGNF4
line 1371
;1369:		+  pm->ps->velocity[1] * pm->ps->velocity[1] );
;1370:
;1371:	if ( pm->ps->groundEntityNum == ENTITYNUM_NONE ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1023
NEI4 $525
line 1373
;1372:
;1373:		if ( pm->ps->powerups[PW_INVULNERABILITY] ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 368
ADDP4
INDIRI4
CNSTI4 0
EQI4 $527
line 1374
;1374:			PM_ContinueLegsAnim( LEGS_IDLECR );
CNSTI4 23
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1375
;1375:		}
LABELV $527
line 1377
;1376:		// airborne leaves position in cycle intact, but doesn't advance
;1377:		if ( pm->waterlevel > 1 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 1
LEI4 $524
line 1378
;1378:			PM_ContinueLegsAnim( LEGS_SWIM );
CNSTI4 17
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1379
;1379:		}
line 1380
;1380:		return;
ADDRGP4 $524
JUMPV
LABELV $525
line 1384
;1381:	}
;1382:
;1383:	// if not trying to move
;1384:	if ( !pm->cmd.forwardmove && !pm->cmd.rightmove ) {
ADDRLP4 32
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ADDRLP4 36
INDIRI4
NEI4 $531
ADDRLP4 32
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 36
INDIRI4
NEI4 $531
line 1385
;1385:		if (  pm->xyspeed < 5 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
CNSTF4 1084227584
GEF4 $524
line 1386
;1386:			pm->ps->bobCycle = 0;	// start at beginning of cycle again
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 0
ASGNI4
line 1387
;1387:			if ( pm->ps->pm_flags & PMF_DUCKED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $535
line 1388
;1388:				PM_ContinueLegsAnim( LEGS_IDLECR );
CNSTI4 23
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1389
;1389:			} else {
ADDRGP4 $524
JUMPV
LABELV $535
line 1390
;1390:				PM_ContinueLegsAnim( LEGS_IDLE );
CNSTI4 22
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1391
;1391:			}
line 1392
;1392:		}
line 1393
;1393:		return;
ADDRGP4 $524
JUMPV
LABELV $531
line 1397
;1394:	}
;1395:	
;1396:
;1397:	footstep = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 1399
;1398:
;1399:	if ( pm->ps->pm_flags & PMF_DUCKED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $537
line 1400
;1400:		bobmove = 0.5;	// ducked characters bob much faster
ADDRLP4 4
CNSTF4 1056964608
ASGNF4
line 1401
;1401:		if ( pm->ps->pm_flags & PMF_BACKWARDS_RUN ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $539
line 1402
;1402:			PM_ContinueLegsAnim( LEGS_BACKCR );
CNSTI4 32
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1403
;1403:		}
ADDRGP4 $538
JUMPV
LABELV $539
line 1404
;1404:		else {
line 1405
;1405:			PM_ContinueLegsAnim( LEGS_WALKCR );
CNSTI4 13
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1406
;1406:		}
line 1418
;1407:		// ducked characters never play footsteps
;1408:	/*
;1409:	} else 	if ( pm->ps->pm_flags & PMF_BACKWARDS_RUN ) {
;1410:		if ( !( pm->cmd.buttons & BUTTON_WALKING ) ) {
;1411:			bobmove = 0.4;	// faster speeds bob faster
;1412:			footstep = qtrue;
;1413:		} else {
;1414:			bobmove = 0.3;
;1415:		}
;1416:		PM_ContinueLegsAnim( LEGS_BACK );
;1417:	*/
;1418:	} else {
ADDRGP4 $538
JUMPV
LABELV $537
line 1419
;1419:		if ( !( pm->cmd.buttons & BUTTON_WALKING ) ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $541
line 1420
;1420:			bobmove = 0.4f;	// faster speeds bob faster
ADDRLP4 4
CNSTF4 1053609165
ASGNF4
line 1421
;1421:			if ( pm->ps->pm_flags & PMF_BACKWARDS_RUN ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $543
line 1422
;1422:				PM_ContinueLegsAnim( LEGS_BACK );
CNSTI4 16
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1423
;1423:			}
ADDRGP4 $544
JUMPV
LABELV $543
line 1424
;1424:			else {
line 1425
;1425:				PM_ContinueLegsAnim( LEGS_RUN );
CNSTI4 15
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1426
;1426:			}
LABELV $544
line 1427
;1427:			footstep = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 1428
;1428:		} else {
ADDRGP4 $542
JUMPV
LABELV $541
line 1429
;1429:			bobmove = 0.3f;	// walking bobs slow
ADDRLP4 4
CNSTF4 1050253722
ASGNF4
line 1430
;1430:			if ( pm->ps->pm_flags & PMF_BACKWARDS_RUN ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $545
line 1431
;1431:				PM_ContinueLegsAnim( LEGS_BACKWALK );
CNSTI4 33
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1432
;1432:			}
ADDRGP4 $546
JUMPV
LABELV $545
line 1433
;1433:			else {
line 1434
;1434:				PM_ContinueLegsAnim( LEGS_WALK );
CNSTI4 14
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1435
;1435:			}
LABELV $546
line 1436
;1436:		}
LABELV $542
line 1437
;1437:	}
LABELV $538
line 1440
;1438:
;1439:	// check for footstep / splash sounds
;1440:	old = pm->ps->bobCycle;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1441
;1441:	pm->ps->bobCycle = (int)( old + bobmove * pml.msec ) & 255;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
ADDRGP4 pml+40
INDIRI4
CVIF4 4
MULF4
ADDF4
CVFI4 4
CNSTI4 255
BANDI4
ASGNI4
line 1444
;1442:
;1443:	// if we just crossed a cycle boundary, play an apropriate footstep event
;1444:	if ( ( ( old + 64 ) ^ ( pm->ps->bobCycle + 64 ) ) & 128 ) {
ADDRLP4 40
CNSTI4 64
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 40
INDIRI4
ADDI4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRLP4 40
INDIRI4
ADDI4
BXORI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $548
line 1445
;1445:		if ( pm->waterlevel == 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 0
NEI4 $550
line 1447
;1446:			// on ground will only play sounds if running
;1447:			if ( footstep && !pm->noFootsteps ) {
ADDRLP4 44
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRI4
ADDRLP4 44
INDIRI4
EQI4 $551
ADDRGP4 pm
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRLP4 44
INDIRI4
NEI4 $551
line 1448
;1448:				PM_AddEvent( PM_FootstepForSurface() );
ADDRLP4 48
ADDRGP4 PM_FootstepForSurface
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1449
;1449:			}
line 1450
;1450:		} else if ( pm->waterlevel == 1 ) {
ADDRGP4 $551
JUMPV
LABELV $550
ADDRGP4 pm
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 1
NEI4 $554
line 1452
;1451:			// splashing
;1452:			PM_AddEvent( EV_FOOTSPLASH );
CNSTI4 3
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1453
;1453:		} else if ( pm->waterlevel == 2 ) {
ADDRGP4 $555
JUMPV
LABELV $554
ADDRGP4 pm
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 2
NEI4 $556
line 1455
;1454:			// wading / swimming at surface
;1455:			PM_AddEvent( EV_SWIM );
CNSTI4 5
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1456
;1456:		} else if ( pm->waterlevel == 3 ) {
ADDRGP4 $557
JUMPV
LABELV $556
ADDRGP4 pm
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 3
NEI4 $558
line 1459
;1457:			// no sound when completely underwater
;1458:
;1459:		}
LABELV $558
LABELV $557
LABELV $555
LABELV $551
line 1460
;1460:	}
LABELV $548
line 1461
;1461:}
LABELV $524
endproc PM_Footsteps 52 4
proc PM_WaterEvents 16 4
line 1470
;1462:
;1463:/*
;1464:==============
;1465:PM_WaterEvents
;1466:
;1467:Generate sound events for entering and leaving water
;1468:==============
;1469:*/
;1470:static void PM_WaterEvents( void ) {		// FIXME?
line 1474
;1471:	//
;1472:	// if just entered a water volume, play a sound
;1473:	//
;1474:	if (!pml.previous_waterlevel && pm->waterlevel) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 pml+136
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $561
ADDRGP4 pm
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $561
line 1475
;1475:		PM_AddEvent( EV_WATER_TOUCH );
CNSTI4 15
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1476
;1476:	}
LABELV $561
line 1481
;1477:
;1478:	//
;1479:	// if just completely exited a water volume, play a sound
;1480:	//
;1481:	if (pml.previous_waterlevel && !pm->waterlevel) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 pml+136
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $564
ADDRGP4 pm
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $564
line 1482
;1482:		PM_AddEvent( EV_WATER_LEAVE );
CNSTI4 16
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1483
;1483:	}
LABELV $564
line 1488
;1484:
;1485:	//
;1486:	// check for head just going under water
;1487:	//
;1488:	if (pml.previous_waterlevel != 3 && pm->waterlevel == 3) {
ADDRLP4 8
CNSTI4 3
ASGNI4
ADDRGP4 pml+136
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $567
ADDRGP4 pm
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $567
line 1489
;1489:		PM_AddEvent( EV_WATER_UNDER );
CNSTI4 17
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1490
;1490:	}
LABELV $567
line 1495
;1491:
;1492:	//
;1493:	// check for head just coming out of water
;1494:	//
;1495:	if (pml.previous_waterlevel == 3 && pm->waterlevel != 3) {
ADDRLP4 12
CNSTI4 3
ASGNI4
ADDRGP4 pml+136
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $570
ADDRGP4 pm
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $570
line 1496
;1496:		PM_AddEvent( EV_WATER_CLEAR );
CNSTI4 18
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1497
;1497:	}
LABELV $570
line 1498
;1498:}
LABELV $560
endproc PM_WaterEvents 16 4
proc PM_BeginWeaponChange 8 4
line 1506
;1499:
;1500:
;1501:/*
;1502:===============
;1503:PM_BeginWeaponChange
;1504:===============
;1505:*/
;1506:static void PM_BeginWeaponChange( int weapon ) {
line 1507
;1507:	if ( weapon <= WP_NONE || weapon >= WP_NUM_WEAPONS ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $576
ADDRLP4 0
INDIRI4
CNSTI4 11
LTI4 $574
LABELV $576
line 1508
;1508:		return;
ADDRGP4 $573
JUMPV
LABELV $574
line 1511
;1509:	}
;1510:
;1511:	if ( !( pm->ps->stats[STAT_WEAPONS] & ( 1 << weapon ) ) ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 1
ADDRFP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
NEI4 $577
line 1512
;1512:		return;
ADDRGP4 $573
JUMPV
LABELV $577
line 1515
;1513:	}
;1514:	
;1515:	if ( pm->ps->weaponstate == WEAPON_DROPPING ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 2
NEI4 $579
line 1516
;1516:		return;
ADDRGP4 $573
JUMPV
LABELV $579
line 1520
;1517:	}
;1518:	
;1519:	//Com_Printf("%i\n", pm->weapon);
;1520:	PM_AddEvent( EV_CHANGE_WEAPON );
CNSTI4 22
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1521
;1521:	pm->ps->weaponstate = WEAPON_DROPPING;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 2
ASGNI4
line 1523
;1522:	////Fast weapon switching
;1523:	if ( g_fastSwitch.integer == 1 ) {
ADDRGP4 g_fastSwitch+12
INDIRI4
CNSTI4 1
NEI4 $581
line 1524
;1524:		pm->ps->weaponTime += 0;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
ASGNI4
line 1525
;1525:	} else {
ADDRGP4 $582
JUMPV
LABELV $581
line 1526
;1526:		pm->ps->weaponTime += 200;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 1528
;1527:		//pm->ps->weaponTime += cpm_weapondrop; // CPM
;1528:	}
LABELV $582
line 1530
;1529:
;1530:	PM_StartTorsoAnim( TORSO_DROP );
CNSTI4 9
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1531
;1531:}
LABELV $573
endproc PM_BeginWeaponChange 8 4
proc PM_FinishWeaponChange 12 4
line 1539
;1532:
;1533:
;1534:/*
;1535:===============
;1536:PM_FinishWeaponChange
;1537:===============
;1538:*/
;1539:static void PM_FinishWeaponChange( void ) {
line 1542
;1540:	int		weapon;
;1541:
;1542:	weapon = pm->cmd.weapon;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
CNSTI4 24
ADDP4
INDIRU1
CVUI4 1
ASGNI4
line 1545
;1543:	//weapon = pm->weapon;
;1544:	//Com_Printf("%i\n", pm->weapon);
;1545:	if ( weapon < WP_NONE || weapon >= WP_NUM_WEAPONS ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $587
ADDRLP4 0
INDIRI4
CNSTI4 11
LTI4 $585
LABELV $587
line 1546
;1546:		weapon = WP_NONE;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1547
;1547:	}
LABELV $585
line 1549
;1548:
;1549:	if ( !( pm->ps->stats[STAT_WEAPONS] & ( 1 << weapon ) ) ) {
ADDRGP4 pm
INDIRP4
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
NEI4 $588
line 1550
;1550:		weapon = WP_NONE;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1551
;1551:	}
LABELV $588
line 1553
;1552:
;1553:	pm->ps->weapon = weapon;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1554
;1554:	pm->ps->weaponstate = WEAPON_RAISING;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 1
ASGNI4
line 1557
;1555:	
;1556:	//Fast weapon switching
;1557:	if ( g_fastSwitch.integer == 1 ) {
ADDRGP4 g_fastSwitch+12
INDIRI4
CNSTI4 1
NEI4 $590
line 1558
;1558:		pm->ps->weaponTime += 0;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ASGNI4
line 1559
;1559:	} else {
ADDRGP4 $591
JUMPV
LABELV $590
line 1560
;1560:		pm->ps->weaponTime += 250;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 250
ADDI4
ASGNI4
line 1562
;1561:		//pm->ps->weaponTime += cpm_weaponraise; // CPM
;1562:	}
LABELV $591
line 1564
;1563:
;1564:	PM_StartTorsoAnim( TORSO_RAISE );
CNSTI4 10
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1565
;1565:}
LABELV $584
endproc PM_FinishWeaponChange 12 4
proc PM_TorsoAnimation 0 4
line 1574
;1566:
;1567:
;1568:/*
;1569:==============
;1570:PM_TorsoAnimation
;1571:
;1572:==============
;1573:*/
;1574:static void PM_TorsoAnimation( void ) {
line 1575
;1575:	if ( pm->ps->weaponstate == WEAPON_READY ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 0
NEI4 $594
line 1576
;1576:		if ( pm->ps->weapon == WP_GAUNTLET ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
NEI4 $596
line 1577
;1577:			PM_ContinueTorsoAnim( TORSO_STAND2 );
CNSTI4 12
ARGI4
ADDRGP4 PM_ContinueTorsoAnim
CALLV
pop
line 1578
;1578:		} else {
ADDRGP4 $593
JUMPV
LABELV $596
line 1579
;1579:			PM_ContinueTorsoAnim( TORSO_STAND );
CNSTI4 11
ARGI4
ADDRGP4 PM_ContinueTorsoAnim
CALLV
pop
line 1580
;1580:		}
line 1581
;1581:		return;
LABELV $594
line 1583
;1582:	}
;1583:}
LABELV $593
endproc PM_TorsoAnimation 0 4
proc PM_Weapon 32 4
line 1593
;1584:
;1585:
;1586:/*
;1587:==============
;1588:PM_Weapon
;1589:
;1590:Generates weapon events and modifes the weapon counter
;1591:==============
;1592:*/
;1593:static void PM_Weapon( void ) {
line 1598
;1594:	int		addTime;
;1595:	int		weapon;
;1596://	int		clientsHit;
;1597:
;1598:	weapon = pm->cmd.weapon;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
CNSTI4 24
ADDP4
INDIRU1
CVUI4 1
ASGNI4
line 1601
;1599:
;1600:	// don't allow attack until all buttons are up
;1601:	if ( pm->ps->pm_flags & PMF_RESPAWNED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $599
line 1602
;1602:		return;
ADDRGP4 $598
JUMPV
LABELV $599
line 1606
;1603:	}
;1604:
;1605:	// ignore if spectator
;1606:	if ( pm->ps->persistant[PERS_TEAM] == TEAM_SPECTATOR ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 3
NEI4 $601
line 1607
;1607:		return;
ADDRGP4 $598
JUMPV
LABELV $601
line 1612
;1608:	}
;1609:
;1610:	// check for dead player
;1611:	//Com_Printf("DBG: PM_Weapon: Health: %i ToD: %i CmdTime: %i\n", pm->ps->stats[STAT_HEALTH], pm->timeOfDeath, pm->commandTime);
;1612:	if ( pm->ps->stats[STAT_HEALTH] <= 0 /*&& pm->timeOfDeath < pm->commandTime*/ ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $603
line 1614
;1613:		//Com_Printf("DBG: Set weapon to none\n");
;1614:		pm->ps->weapon = WP_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 0
ASGNI4
line 1615
;1615:		return;
ADDRGP4 $598
JUMPV
LABELV $603
line 1619
;1616:	}
;1617:
;1618:	//monkk: offhand grapple
;1619:	if( weap_enableHook.integer == 1 ) {//offhand grapple mode
ADDRGP4 weap_enableHook+12
INDIRI4
CNSTI4 1
NEI4 $605
line 1620
;1620:		if ( pm->cmd.buttons & BUTTON_FIRE_GRAPPLE ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $608
line 1621
;1621:			PM_AddEvent( EV_FIRE_GRAPPLE );
CNSTI4 83
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1622
;1622:		}
LABELV $608
line 1623
;1623:	}
LABELV $605
line 1626
;1624:
;1625:	// check for item using
;1626:	if ( pm->cmd.buttons & BUTTON_USE_HOLDABLE ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $610
line 1627
;1627:		if ( ! ( pm->ps->pm_flags & PMF_USE_ITEM_HELD ) ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
NEI4 $611
line 1628
;1628:			if ( bg_itemlist[pm->ps->stats[STAT_HOLDABLE_ITEM]].giTag == HI_MEDKIT
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
CNSTI4 52
ADDRLP4 8
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 2
NEI4 $614
ADDRLP4 8
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 25
ADDI4
LTI4 $614
line 1629
;1629:				&& pm->ps->stats[STAT_HEALTH] >= (pm->ps->stats[STAT_MAX_HEALTH] + 25) ) {
line 1631
;1630:				// don't use medkit if at max health
;1631:			} else {
ADDRGP4 $598
JUMPV
LABELV $614
line 1632
;1632:				pm->ps->pm_flags |= PMF_USE_ITEM_HELD;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1024
BORI4
ASGNI4
line 1633
;1633:				PM_AddEvent( EV_USE_ITEM0 + bg_itemlist[pm->ps->stats[STAT_HOLDABLE_ITEM]].giTag );
CNSTI4 52
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 24
ADDI4
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1634
;1634:				pm->ps->stats[STAT_HOLDABLE_ITEM] = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 188
ADDP4
CNSTI4 0
ASGNI4
line 1635
;1635:			}
line 1636
;1636:			return;
ADDRGP4 $598
JUMPV
line 1638
;1637:		}
;1638:	} else {
LABELV $610
line 1639
;1639:		pm->ps->pm_flags &= ~PMF_USE_ITEM_HELD;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -1025
BANDI4
ASGNI4
line 1640
;1640:	}
LABELV $611
line 1644
;1641:
;1642:
;1643:	// make weapon function
;1644:	if ( pm->ps->weaponTime > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LEI4 $618
line 1645
;1645:		pm->ps->weaponTime -= pml.msec;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRGP4 pml+40
INDIRI4
SUBI4
ASGNI4
line 1646
;1646:	}
LABELV $618
line 1651
;1647:
;1648:	// check for weapon change
;1649:	// can't change if weapon is firing, but can change
;1650:	// again if lowering or raising
;1651:	if ( pm->ps->weaponTime <= 0 || pm->ps->weaponstate != WEAPON_FIRING ) {
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LEI4 $623
ADDRLP4 8
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 3
EQI4 $621
LABELV $623
line 1652
;1652:		if ( pm->ps->weapon != WEAPON_MASK(pm->cmd.weapon) ) {
ADDRLP4 12
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 24
ADDP4
INDIRU1
CVUI4 1
EQI4 $624
line 1653
;1653:			PM_BeginWeaponChange( WEAPON_MASK(pm->cmd.weapon) );
ADDRGP4 pm
INDIRP4
CNSTI4 24
ADDP4
INDIRU1
CVUI4 1
ARGI4
ADDRGP4 PM_BeginWeaponChange
CALLV
pop
line 1656
;1654:	//	if ( pm->ps->weapon != pm->weapon ) {
;1655:	//		PM_BeginWeaponChange( pm->weapon );
;1656:		}
LABELV $624
line 1657
;1657:	}
LABELV $621
line 1659
;1658:
;1659:	if ( pm->ps->weaponTime > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LEI4 $626
line 1660
;1660:		return;
ADDRGP4 $598
JUMPV
LABELV $626
line 1664
;1661:	}
;1662:
;1663:	// change weapon if time
;1664:	if ( pm->ps->weaponstate == WEAPON_DROPPING ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 2
NEI4 $628
line 1665
;1665:		PM_FinishWeaponChange();
ADDRGP4 PM_FinishWeaponChange
CALLV
pop
line 1666
;1666:		return;
ADDRGP4 $598
JUMPV
LABELV $628
line 1669
;1667:	}
;1668:
;1669:	if ( pm->ps->weaponstate == WEAPON_RAISING ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 1
NEI4 $630
line 1670
;1670:		pm->ps->weaponstate = WEAPON_READY;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 1671
;1671:		if ( pm->ps->weapon == WP_GAUNTLET ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
NEI4 $632
line 1672
;1672:			PM_StartTorsoAnim( TORSO_STAND2 );
CNSTI4 12
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1673
;1673:		} else {
ADDRGP4 $598
JUMPV
LABELV $632
line 1674
;1674:			PM_StartTorsoAnim( TORSO_STAND );
CNSTI4 11
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1675
;1675:		}
line 1676
;1676:		return;
ADDRGP4 $598
JUMPV
LABELV $630
line 1680
;1677:	}
;1678:
;1679:	// check for fire
;1680:	if ( ! (pm->cmd.buttons & BUTTON_ATTACK) ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $634
line 1681
;1681:		pm->ps->weaponTime = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 0
ASGNI4
line 1682
;1682:		pm->ps->weaponstate = WEAPON_READY;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 1683
;1683:		return;
ADDRGP4 $598
JUMPV
LABELV $634
line 1687
;1684:	}
;1685:
;1686:	// start the animation even if out of ammo
;1687:	if ( pm->ps->weapon == WP_GAUNTLET ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
NEI4 $636
line 1689
;1688:		// the guantlet only "fires" when it actually hits something
;1689:		if ( !pm->gauntletHit && !pm->gauntletJump ) {
ADDRLP4 12
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $638
ADDRLP4 12
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $638
line 1690
;1690:			pm->ps->weaponTime = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 0
ASGNI4
line 1691
;1691:			pm->ps->weaponstate = WEAPON_READY;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 1692
;1692:			return;
ADDRGP4 $598
JUMPV
LABELV $638
line 1694
;1693:		}
;1694:		PM_StartTorsoAnim( TORSO_ATTACK2 );
CNSTI4 8
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1695
;1695:	} else {
ADDRGP4 $637
JUMPV
LABELV $636
line 1696
;1696:		PM_StartTorsoAnim( TORSO_ATTACK );
CNSTI4 7
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1697
;1697:	}
LABELV $637
line 1699
;1698:
;1699:	pm->ps->weaponstate = WEAPON_FIRING;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 3
ASGNI4
line 1702
;1700:
;1701:	// check for out of ammo
;1702:	if ( ! pm->ps->ammo[ pm->ps->weapon ] ) {
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $640
line 1703
;1703:		PM_AddEvent( EV_NOAMMO );
CNSTI4 21
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1705
;1704:		//pm->ps->weaponTime += 500;
;1705:		pm->ps->weaponTime += cpm_outofammodelay; // CPM: Shorter delay in pro mode
ADDRLP4 16
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 cpm_outofammodelay
INDIRF4
ADDF4
CVFI4 4
ASGNI4
line 1706
;1706:		return;
ADDRGP4 $598
JUMPV
LABELV $640
line 1710
;1707:	}
;1708:
;1709:	// take an ammo away if not infinite
;1710:	if ( pm->ps->ammo[ pm->ps->weapon ] != -1 ) {
ADDRLP4 16
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $642
line 1711
;1711:		pm->ps->ammo[ pm->ps->weapon ]--;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 20
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
INDIRP4
CNSTI4 376
ADDP4
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1712
;1712:	}
LABELV $642
line 1715
;1713:
;1714:	// fire weapon
;1715:	PM_AddEvent( EV_FIRE_WEAPON );
CNSTI4 23
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1717
;1716:
;1717:	switch( pm->ps->weapon ) {
ADDRLP4 20
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 1
LTI4 $644
ADDRLP4 20
INDIRI4
CNSTI4 10
GTI4 $644
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $670-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $670
address $647
address $657
address $655
address $659
address $661
address $653
address $665
address $663
address $667
address $669
code
LABELV $644
LABELV $647
line 1720
;1718:	default:
;1719:	case WP_GAUNTLET:
;1720:		if ( pm->gauntletJump && g_DynamicGauntletCycle.integer > 0 ) {
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRGP4 pm
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
EQI4 $648
ADDRGP4 g_DynamicGauntletCycle+12
INDIRI4
ADDRLP4 28
INDIRI4
LEI4 $648
line 1721
;1721:			addTime = g_DynamicGauntletCycle.integer;
ADDRLP4 0
ADDRGP4 g_DynamicGauntletCycle+12
INDIRI4
ASGNI4
line 1722
;1722:		} else {
ADDRGP4 $645
JUMPV
LABELV $648
line 1723
;1723:			addTime = weap_gauntletCycle.integer;
ADDRLP4 0
ADDRGP4 weap_gauntletCycle+12
INDIRI4
ASGNI4
line 1724
;1724:		}
line 1725
;1725:		break;
ADDRGP4 $645
JUMPV
LABELV $653
line 1727
;1726:	case WP_LIGHTNING:
;1727:		addTime = weap_lightninggunCycle.integer;
ADDRLP4 0
ADDRGP4 weap_lightninggunCycle+12
INDIRI4
ASGNI4
line 1728
;1728:		break;
ADDRGP4 $645
JUMPV
LABELV $655
line 1730
;1729:	case WP_SHOTGUN:
;1730:		addTime = weap_shotgunCycle.integer;
ADDRLP4 0
ADDRGP4 weap_shotgunCycle+12
INDIRI4
ASGNI4
line 1731
;1731:		break;
ADDRGP4 $645
JUMPV
LABELV $657
line 1733
;1732:	case WP_MACHINEGUN:
;1733:		addTime = weap_machinegunCycle.integer;
ADDRLP4 0
ADDRGP4 weap_machinegunCycle+12
INDIRI4
ASGNI4
line 1734
;1734:		break;
ADDRGP4 $645
JUMPV
LABELV $659
line 1736
;1735:	case WP_GRENADE_LAUNCHER:
;1736:		addTime = weap_grenadelauncherCycle.integer;
ADDRLP4 0
ADDRGP4 weap_grenadelauncherCycle+12
INDIRI4
ASGNI4
line 1737
;1737:		break;
ADDRGP4 $645
JUMPV
LABELV $661
line 1739
;1738:	case WP_ROCKET_LAUNCHER:
;1739:		addTime = weap_rocketlauncherCycle.integer;
ADDRLP4 0
ADDRGP4 weap_rocketlauncherCycle+12
INDIRI4
ASGNI4
line 1740
;1740:		break;
ADDRGP4 $645
JUMPV
LABELV $663
line 1742
;1741:	case WP_PLASMAGUN:
;1742:		addTime = weap_plasmagunCycle.integer;
ADDRLP4 0
ADDRGP4 weap_plasmagunCycle+12
INDIRI4
ASGNI4
line 1743
;1743:		break;
ADDRGP4 $645
JUMPV
LABELV $665
line 1745
;1744:	case WP_RAILGUN:
;1745:		addTime = weap_railgunCycle.integer;
ADDRLP4 0
ADDRGP4 weap_railgunCycle+12
INDIRI4
ASGNI4
line 1749
;1746:		//addTime = cpm_RGchange; // CPM
;1747:		//pm->ps->stats[STAT_RAILTIME] = 1500; // CPM
;1748://		pm->ps->stats[STAT_RAILTIME] = weap_railgunCycle.integer;
;1749:		break;
ADDRGP4 $645
JUMPV
LABELV $667
line 1751
;1750:	case WP_BFG:
;1751:		addTime = weap_bfgCycle.integer;
ADDRLP4 0
ADDRGP4 weap_bfgCycle+12
INDIRI4
ASGNI4
line 1752
;1752:		break;
ADDRGP4 $645
JUMPV
LABELV $669
line 1754
;1753:	case WP_GRAPPLING_HOOK:
;1754:		addTime = 400;
ADDRLP4 0
CNSTI4 400
ASGNI4
line 1755
;1755:		break;
LABELV $645
line 1784
;1756:#ifdef MISSIONPACK
;1757:	case WP_NAILGUN:
;1758:		addTime = 1000;
;1759:		break;
;1760:	case WP_PROX_LAUNCHER:
;1761:		addTime = 800;
;1762:		break;
;1763:	case WP_CHAINGUN:
;1764:		addTime = 30;
;1765:		break;
;1766:#endif
;1767:	}
;1768:
;1769:#ifdef MISSIONPACK
;1770:	if( bg_itemlist[pm->ps->stats[STAT_PERSISTANT_POWERUP]].giTag == PW_SCOUT ) {
;1771:		addTime /= 1.5;
;1772:	}
;1773:	else
;1774:	if( bg_itemlist[pm->ps->stats[STAT_PERSISTANT_POWERUP]].giTag == PW_AMMOREGEN ) {
;1775:		addTime /= 1.3;
;1776:  }
;1777:  else
;1778:#endif
;1779:	//if ( pm->ps->powerups[PW_HASTE] ) {
;1780:	//	addTime /= 1.3;
;1781:	//	pm->ps->stats[STAT_RAILTIME] /= 1.3; // CPM
;1782:	//}
;1783:
;1784:	pm->ps->weaponTime += addTime;
ADDRLP4 28
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 1785
;1785:}
LABELV $598
endproc PM_Weapon 32 4
proc PM_Animate 0 4
line 1793
;1786:
;1787:/*
;1788:================
;1789:PM_Animate
;1790:================
;1791:*/
;1792:
;1793:static void PM_Animate( void ) {
line 1794
;1794:	if ( pm->cmd.buttons & BUTTON_GESTURE ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $673
line 1795
;1795:		if ( pm->ps->torsoTimer == 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
NEI4 $675
line 1796
;1796:			PM_StartTorsoAnim( TORSO_GESTURE );
CNSTI4 6
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1797
;1797:			pm->ps->torsoTimer = TIMER_GESTURE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 2294
ASGNI4
line 1798
;1798:			PM_AddEvent( EV_TAUNT );
CNSTI4 76
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1799
;1799:		}
LABELV $675
line 1832
;1800:#ifdef MISSIONPACK
;1801:	} else if ( pm->cmd.buttons & BUTTON_GETFLAG ) {
;1802:		if ( pm->ps->torsoTimer == 0 ) {
;1803:			PM_StartTorsoAnim( TORSO_GETFLAG );
;1804:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
;1805:		}
;1806:	} else if ( pm->cmd.buttons & BUTTON_GUARDBASE ) {
;1807:		if ( pm->ps->torsoTimer == 0 ) {
;1808:			PM_StartTorsoAnim( TORSO_GUARDBASE );
;1809:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
;1810:		}
;1811:	} else if ( pm->cmd.buttons & BUTTON_PATROL ) {
;1812:		if ( pm->ps->torsoTimer == 0 ) {
;1813:			PM_StartTorsoAnim( TORSO_PATROL );
;1814:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
;1815:		}
;1816:	} else if ( pm->cmd.buttons & BUTTON_FOLLOWME ) {
;1817:		if ( pm->ps->torsoTimer == 0 ) {
;1818:			PM_StartTorsoAnim( TORSO_FOLLOWME );
;1819:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
;1820:		}
;1821:	} else if ( pm->cmd.buttons & BUTTON_AFFIRMATIVE ) {
;1822:		if ( pm->ps->torsoTimer == 0 ) {
;1823:			PM_StartTorsoAnim( TORSO_AFFIRMATIVE);
;1824:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
;1825:		}
;1826:	} else if ( pm->cmd.buttons & BUTTON_NEGATIVE ) {
;1827:		if ( pm->ps->torsoTimer == 0 ) {
;1828:			PM_StartTorsoAnim( TORSO_NEGATIVE );
;1829:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
;1830:		}
;1831:#endif
;1832:	}
LABELV $673
line 1833
;1833:}
LABELV $672
endproc PM_Animate 0 4
proc PM_DropTimers 4 0
line 1841
;1834:
;1835:
;1836:/*
;1837:================
;1838:PM_DropTimers
;1839:================
;1840:*/
;1841:static void PM_DropTimers( void ) {
line 1843
;1842:	// drop misc timing counter
;1843:	if ( pm->ps->pm_time ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
EQI4 $678
line 1844
;1844:		if ( pml.msec >= pm->ps->pm_time ) {
ADDRGP4 pml+40
INDIRI4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
LTI4 $680
line 1845
;1845:			pm->ps->pm_flags &= ~PMF_ALL_TIMES;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 -353
BANDI4
ASGNI4
line 1846
;1846:			pm->ps->pm_time = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 0
ASGNI4
line 1847
;1847:		} else {
ADDRGP4 $681
JUMPV
LABELV $680
line 1848
;1848:			pm->ps->pm_time -= pml.msec;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 pml+40
INDIRI4
SUBI4
ASGNI4
line 1849
;1849:		}
LABELV $681
line 1850
;1850:	}
LABELV $678
line 1853
;1851:
;1852:	// drop animation counter
;1853:	if ( pm->ps->legsTimer > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
LEI4 $684
line 1854
;1854:		pm->ps->legsTimer -= pml.msec;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 pml+40
INDIRI4
SUBI4
ASGNI4
line 1855
;1855:		if ( pm->ps->legsTimer < 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
GEI4 $687
line 1856
;1856:			pm->ps->legsTimer = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 1857
;1857:		}
LABELV $687
line 1858
;1858:	}
LABELV $684
line 1860
;1859:
;1860:	if ( pm->ps->torsoTimer > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
LEI4 $689
line 1861
;1861:		pm->ps->torsoTimer -= pml.msec;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 pml+40
INDIRI4
SUBI4
ASGNI4
line 1862
;1862:		if ( pm->ps->torsoTimer < 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
GEI4 $692
line 1863
;1863:			pm->ps->torsoTimer = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 0
ASGNI4
line 1864
;1864:		}
LABELV $692
line 1865
;1865:	}
LABELV $689
line 1866
;1866:}
LABELV $677
endproc PM_DropTimers 4 0
export PM_UpdateViewAngles
proc PM_UpdateViewAngles 36 0
line 1876
;1867:
;1868:/*
;1869:================
;1870:PM_UpdateViewAngles
;1871:
;1872:This can be used as another entry point when only the viewangles
;1873:are being updated isntead of a full move
;1874:================
;1875:*/
;1876:void PM_UpdateViewAngles( playerState_t *ps, const usercmd_t *cmd, int timeOfDeath ) {
line 1880
;1877:	short		temp;
;1878:	int		i;
;1879:
;1880:	if ( ps->pm_type == PM_INTERMISSION || ps->pm_type == PM_SPINTERMISSION ) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 5
EQI4 $697
ADDRLP4 8
INDIRI4
CNSTI4 6
NEI4 $695
LABELV $697
line 1881
;1881:		return;		// no view changes at all
ADDRGP4 $694
JUMPV
LABELV $695
line 1884
;1882:	}
;1883:
;1884:	if ( ps->pm_type == PM_FREEZE ) {
ADDRLP4 12
CNSTI4 4
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $698
line 1885
;1885:		return; // no view changes at all during a time out
ADDRGP4 $694
JUMPV
LABELV $698
line 1888
;1886:	}
;1887:
;1888:	if ( ps->pm_type != PM_SPECTATOR && ps->stats[STAT_HEALTH] <= 0 && (!timeOfDeath || timeOfDeath < ps->commandTime)) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $700
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 16
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
GTI4 $700
ADDRLP4 24
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $702
ADDRLP4 24
INDIRI4
ADDRLP4 16
INDIRP4
INDIRI4
GEI4 $700
LABELV $702
line 1889
;1889:		return;		// no view changes at all
ADDRGP4 $694
JUMPV
LABELV $700
line 1893
;1890:	}
;1891:
;1892:	// circularly clamp the angles with deltas
;1893:	for (i=0 ; i<3 ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $703
line 1894
;1894:		temp = cmd->angles[i] + ps->delta_angles[i];
ADDRLP4 28
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4
ADDRLP4 28
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
ADDP4
INDIRI4
ADDI4
CVII2 4
ASGNI2
line 1895
;1895:		if ( i == PITCH ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $707
line 1897
;1896:			// don't let the player look up or down more than 90 degrees
;1897:			if ( temp > 16000 ) {
ADDRLP4 4
INDIRI2
CVII4 2
CNSTI4 16000
LEI4 $709
line 1898
;1898:				ps->delta_angles[i] = 16000 - cmd->angles[i];
ADDRLP4 32
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 32
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
ADDP4
CNSTI4 16000
ADDRLP4 32
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
INDIRI4
SUBI4
ASGNI4
line 1899
;1899:				temp = 16000;
ADDRLP4 4
CNSTI2 16000
ASGNI2
line 1900
;1900:			} else if ( temp < -16000 ) {
ADDRGP4 $710
JUMPV
LABELV $709
ADDRLP4 4
INDIRI2
CVII4 2
CNSTI4 -16000
GEI4 $711
line 1901
;1901:				ps->delta_angles[i] = -16000 - cmd->angles[i];
ADDRLP4 32
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 32
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
ADDP4
CNSTI4 -16000
ADDRLP4 32
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
INDIRI4
SUBI4
ASGNI4
line 1902
;1902:				temp = -16000;
ADDRLP4 4
CNSTI2 -16000
ASGNI2
line 1903
;1903:			}
LABELV $711
LABELV $710
line 1904
;1904:		}
LABELV $707
line 1905
;1905:		ps->viewangles[i] = SHORT2ANGLE(temp);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ADDP4
CNSTF4 1001652224
ADDRLP4 4
INDIRI2
CVII4 2
CVIF4 4
MULF4
ASGNF4
line 1906
;1906:	}
LABELV $704
line 1893
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $703
line 1908
;1907:
;1908:}
LABELV $694
endproc PM_UpdateViewAngles 36 0
export PmoveSingle
proc PmoveSingle 108 16
line 1919
;1909:
;1910:
;1911:/*
;1912:================
;1913:PmoveSingle
;1914:
;1915:================
;1916:*/
;1917:void trap_SnapVector( float *v );
;1918:
;1919:void PmoveSingle (pmove_t *pmove) {
line 1920
;1920:	pm = pmove;
ADDRGP4 pm
ADDRFP4 0
INDIRP4
ASGNP4
line 1924
;1921:
;1922:#ifndef QAGAME
;1923:
;1924:	pm->timeOfDeath = pm->commandTime - 1;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1930
;1925:
;1926:#endif
;1927:
;1928:	// this counter lets us debug movement problems with a journal
;1929:	// by setting a conditional breakpoint fot the previous frame
;1930:	c_pmove++;
ADDRLP4 4
ADDRGP4 c_pmove
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1933
;1931:
;1932:	// clear results
;1933:	pm->numtouch = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 1934
;1934:	pm->watertype = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 208
ADDP4
CNSTI4 0
ASGNI4
line 1935
;1935:	pm->waterlevel = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 212
ADDP4
CNSTI4 0
ASGNI4
line 1936
;1936:	pm->cmd.weapon = WEAPON_MASK(pm->cmd.weapon);
ADDRLP4 8
ADDRGP4 pm
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRU1
ASGNU1
line 1938
;1937:
;1938:	if ( pm->ps->stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $714
line 1939
;1939:		pm->tracemask &= ~CONTENTS_BODY;	// corpses can fly through bodies
ADDRLP4 12
ADDRGP4 pm
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 -33554433
BANDI4
ASGNI4
line 1940
;1940:	}
LABELV $714
line 1942
;1941:
;1942:	if(!g_interference.integer)
ADDRGP4 g_interference+12
INDIRI4
CNSTI4 0
NEI4 $716
line 1943
;1943:		pm->tracemask &= ~CONTENTS_BODY;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 -33554433
BANDI4
ASGNI4
LABELV $716
line 1947
;1944:
;1945:	// make sure walking button is clear if they are running, to avoid
;1946:	// proxy no-footsteps cheats
;1947:	if ( abs( pm->cmd.forwardmove ) > 64 || abs( pm->cmd.rightmove ) > 64 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 16
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 64
GTI4 $721
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 20
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 64
LEI4 $719
LABELV $721
line 1948
;1948:		pm->cmd.buttons &= ~BUTTON_WALKING;
ADDRLP4 24
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
line 1949
;1949:	}
LABELV $719
line 1952
;1950:
;1951:	// set the talk balloon flag
;1952:	if ( pm->cmd.buttons & BUTTON_TALK ) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $722
line 1953
;1953:		pm->ps->eFlags |= EF_TALK;
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
line 1954
;1954:	} else {
ADDRGP4 $723
JUMPV
LABELV $722
line 1955
;1955:		pm->ps->eFlags &= ~EF_TALK;
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 -4097
BANDI4
ASGNI4
line 1956
;1956:	}
LABELV $723
line 1959
;1957:
;1958:	// set the firing flag for continuous beam weapons
;1959:	if ( !(pm->ps->pm_flags & PMF_RESPAWNED) && pm->ps->pm_type != PM_INTERMISSION
ADDRLP4 24
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRLP4 28
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 512
BANDI4
ADDRLP4 32
INDIRI4
NEI4 $724
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 5
EQI4 $724
ADDRLP4 24
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 32
INDIRI4
EQI4 $724
ADDRLP4 28
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 28
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
ADDRLP4 32
INDIRI4
EQI4 $724
line 1960
;1960:		&& ( pm->cmd.buttons & BUTTON_ATTACK ) && pm->ps->ammo[ pm->ps->weapon ] ) {
line 1961
;1961:		pm->ps->eFlags |= EF_FIRING;
ADDRLP4 36
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 1962
;1962:	} else {
ADDRGP4 $725
JUMPV
LABELV $724
line 1963
;1963:		pm->ps->eFlags &= ~EF_FIRING;
ADDRLP4 36
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 -257
BANDI4
ASGNI4
line 1964
;1964:	}
LABELV $725
line 1967
;1965:
;1966:	// clear the respawned flag if attack and use are cleared
;1967:	if ( pm->ps->stats[STAT_HEALTH] > 0 && 
ADDRLP4 36
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 40
CNSTI4 0
ASGNI4
ADDRLP4 36
INDIRP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRLP4 40
INDIRI4
LEI4 $726
ADDRLP4 36
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 5
BANDI4
ADDRLP4 40
INDIRI4
NEI4 $726
line 1968
;1968:		!( pm->cmd.buttons & (BUTTON_ATTACK | BUTTON_USE_HOLDABLE) ) ) {
line 1969
;1969:		pm->ps->pm_flags &= ~PMF_RESPAWNED;
ADDRLP4 44
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 -513
BANDI4
ASGNI4
line 1970
;1970:	}
LABELV $726
line 1975
;1971:
;1972:	// if talk button is down, dissallow all other input
;1973:	// this is to prevent any possible intercept proxy from
;1974:	// adding fake talk balloons
;1975:	if ( pmove->cmd.buttons & BUTTON_TALK ) {
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $728
line 1978
;1976:		// keep the talk button set tho for when the cmd.serverTime > 66 msec
;1977:		// and the same cmd is used multiple times in Pmove
;1978:		pmove->cmd.buttons = BUTTON_TALK;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
CNSTI4 2
ASGNI4
line 1979
;1979:		pmove->cmd.forwardmove = 0;
ADDRFP4 0
INDIRP4
CNSTI4 25
ADDP4
CNSTI1 0
ASGNI1
line 1980
;1980:		pmove->cmd.rightmove = 0;
ADDRFP4 0
INDIRP4
CNSTI4 26
ADDP4
CNSTI1 0
ASGNI1
line 1981
;1981:		pmove->cmd.upmove = 0;
ADDRFP4 0
INDIRP4
CNSTI4 27
ADDP4
CNSTI1 0
ASGNI1
line 1982
;1982:	}
LABELV $728
line 1985
;1983:
;1984:	// clear all pmove local vars
;1985:	memset (&pml, 0, sizeof(pml));
ADDRGP4 pml
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1988
;1986:
;1987:	// determine the time
;1988:	pml.msec = pmove->cmd.serverTime - pm->ps->commandTime;
ADDRGP4 pml+40
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRGP4 pm
INDIRP4
INDIRP4
INDIRI4
SUBI4
ASGNI4
line 1989
;1989:	if ( pml.msec < 1 ) {
ADDRGP4 pml+40
INDIRI4
CNSTI4 1
GEI4 $731
line 1990
;1990:		pml.msec = 1;
ADDRGP4 pml+40
CNSTI4 1
ASGNI4
line 1991
;1991:	} else if ( pml.msec > 200 ) {
ADDRGP4 $732
JUMPV
LABELV $731
ADDRGP4 pml+40
INDIRI4
CNSTI4 200
LEI4 $735
line 1992
;1992:		pml.msec = 200;
ADDRGP4 pml+40
CNSTI4 200
ASGNI4
line 1993
;1993:	}
LABELV $735
LABELV $732
line 1994
;1994:	pm->ps->commandTime = pmove->cmd.serverTime;
ADDRGP4 pm
INDIRP4
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1997
;1995:
;1996:	// save old org in case we get stuck
;1997:	VectorCopy (pm->ps->origin, pml.previous_origin);
ADDRGP4 pml+112
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 2000
;1998:
;1999:	// save old velocity for crashlanding
;2000:	VectorCopy (pm->ps->velocity, pml.previous_velocity);
ADDRGP4 pml+124
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
INDIRB
ASGNB 12
line 2002
;2001:
;2002:	pml.frametime = pml.msec * 0.001;
ADDRGP4 pml+36
CNSTF4 981668463
ADDRGP4 pml+40
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 2005
;2003:
;2004:	// update the viewangles
;2005:	PM_UpdateViewAngles( pm->ps, &pm->cmd, pm->timeOfDeath );
ADDRLP4 44
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
INDIRP4
ARGP4
ADDRLP4 44
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 44
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ARGI4
ADDRGP4 PM_UpdateViewAngles
CALLV
pop
line 2007
;2006:
;2007:	AngleVectors (pm->ps->viewangles, pml.forward, pml.right, pml.up);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 pml
ARGP4
ADDRGP4 pml+12
ARGP4
ADDRGP4 pml+24
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 2009
;2008:
;2009:	if ( pm->cmd.upmove < 10 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CNSTI4 10
GEI4 $745
line 2011
;2010:		// not holding jump
;2011:		pm->ps->pm_flags &= ~PMF_JUMP_HELD;
ADDRLP4 48
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 2012
;2012:	}
LABELV $745
line 2015
;2013:
;2014:	// decide if backpedaling animations should be used
;2015:	if ( pm->cmd.forwardmove < 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $747
line 2016
;2016:		pm->ps->pm_flags |= PMF_BACKWARDS_RUN;
ADDRLP4 48
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 2017
;2017:	} else if ( pm->cmd.forwardmove > 0 || ( pm->cmd.forwardmove == 0 && pm->cmd.rightmove ) ) {
ADDRGP4 $748
JUMPV
LABELV $747
ADDRLP4 48
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 52
ADDRLP4 48
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 56
CNSTI4 0
ASGNI4
ADDRLP4 52
INDIRI4
ADDRLP4 56
INDIRI4
GTI4 $751
ADDRLP4 52
INDIRI4
ADDRLP4 56
INDIRI4
NEI4 $749
ADDRLP4 48
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ADDRLP4 56
INDIRI4
EQI4 $749
LABELV $751
line 2018
;2018:		pm->ps->pm_flags &= ~PMF_BACKWARDS_RUN;
ADDRLP4 60
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
line 2019
;2019:	}
LABELV $749
LABELV $748
line 2026
;2020:
;2021:	/*
;2022:	This little hack allows us to "see" what keys the client is pressing by any client without
;2023:	adding any "real" extra network bandwidth. We are capable of squeezing 1 extra flag into this int
;2024:	(assuming q3 uses 16 bit int's).
;2025:	*/
;2026:	if ( pm->cmd.forwardmove > 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LEI4 $752
line 2027
;2027:		pm->ps->pm_flags |= PMF_FORWARD_KEY_PRESSED;
ADDRLP4 60
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 2029
;2028:		//Com_Printf("DBG: Setting forward");
;2029:	} else if ( pm->ps->pm_flags & PMF_FORWARD_KEY_PRESSED ) {
ADDRGP4 $753
JUMPV
LABELV $752
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $754
line 2030
;2030:		pm->ps->pm_flags &= ~PMF_FORWARD_KEY_PRESSED;
ADDRLP4 60
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 -5
BANDI4
ASGNI4
line 2032
;2031:		//Com_Printf("DBG: Removing forward");
;2032:	}
LABELV $754
LABELV $753
line 2034
;2033:
;2034:	if ( pm->cmd.forwardmove < 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $756
line 2035
;2035:		pm->ps->pm_flags |= PMF_BACKWARD_KEY_PRESSED;
ADDRLP4 60
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
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
line 2037
;2036:		//Com_Printf("DBG: Setting backward");
;2037:	} else if ( pm->ps->pm_flags & PMF_BACKWARD_KEY_PRESSED ) {
ADDRGP4 $757
JUMPV
LABELV $756
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $758
line 2038
;2038:		pm->ps->pm_flags &= ~PMF_BACKWARD_KEY_PRESSED;
ADDRLP4 60
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 2040
;2039:		//Com_Printf("DBG: Removing backward");
;2040:	}
LABELV $758
LABELV $757
line 2042
;2041:
;2042:	if ( pm->cmd.rightmove > 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LEI4 $760
line 2043
;2043:		pm->ps->pm_flags |= PMF_MOVE_RIGHT_KEY_PRESSED;
ADDRLP4 60
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 32768
BORI4
ASGNI4
line 2045
;2044:		//Com_Printf("DBG: Setting right");
;2045:	} else {
ADDRGP4 $761
JUMPV
LABELV $760
line 2046
;2046:		pm->ps->pm_flags &= ~PMF_MOVE_RIGHT_KEY_PRESSED;
ADDRLP4 60
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 -32769
BANDI4
ASGNI4
line 2048
;2047:		//Com_Printf("DBG: Removing right");
;2048:	}
LABELV $761
line 2050
;2049:
;2050:	if ( pm->cmd.rightmove < 0 ) {
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $762
line 2051
;2051:		pm->ps->eFlags |= EF_MOVE_LEFT_KEY_PRESSED;
ADDRLP4 60
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
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
line 2053
;2052:		//Com_Printf("DBG: Setting left");
;2053:	} else if ( pm->ps->eFlags & EF_MOVE_LEFT_KEY_PRESSED ) {
ADDRGP4 $763
JUMPV
LABELV $762
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $764
line 2054
;2054:		pm->ps->eFlags &= ~EF_MOVE_LEFT_KEY_PRESSED;
ADDRLP4 60
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 -33
BANDI4
ASGNI4
line 2056
;2055:		//Com_Printf("DBG: Removing left");
;2056:	}
LABELV $764
LABELV $763
line 2059
;2057:	//End Hack
;2058:
;2059:	if ( pm->ps->pm_type >= PM_DEAD && (!pm->timeOfDeath || pm->timeOfDeath < pm->ps->commandTime) ) {
ADDRLP4 60
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 64
ADDRLP4 60
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
LTI4 $766
ADDRLP4 68
ADDRLP4 60
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $768
ADDRLP4 68
INDIRI4
ADDRLP4 64
INDIRP4
INDIRI4
GEI4 $766
LABELV $768
line 2060
;2060:		pm->cmd.forwardmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
CNSTI1 0
ASGNI1
line 2061
;2061:		pm->cmd.rightmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
CNSTI1 0
ASGNI1
line 2062
;2062:		pm->cmd.upmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
CNSTI1 0
ASGNI1
line 2063
;2063:	}
LABELV $766
line 2065
;2064:
;2065:	if ( pm->ps->pm_type == PM_SPECTATOR ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $769
line 2066
;2066:		PM_CheckDuck ();
ADDRGP4 PM_CheckDuck
CALLV
pop
line 2067
;2067:		PM_FlyMove ();
ADDRGP4 PM_FlyMove
CALLV
pop
line 2068
;2068:		PM_DropTimers ();
ADDRGP4 PM_DropTimers
CALLV
pop
line 2069
;2069:		return;
ADDRGP4 $713
JUMPV
LABELV $769
line 2072
;2070:	}
;2071:
;2072:	if ( pm->ps->pm_type == PM_NOCLIP ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 1
NEI4 $771
line 2073
;2073:		PM_NoclipMove ();
ADDRGP4 PM_NoclipMove
CALLV
pop
line 2074
;2074:		PM_DropTimers ();
ADDRGP4 PM_DropTimers
CALLV
pop
line 2075
;2075:		return;
ADDRGP4 $713
JUMPV
LABELV $771
line 2078
;2076:	}
;2077:
;2078:	if (pm->ps->pm_type == PM_FREEZE) {
ADDRLP4 72
CNSTI4 4
ASGNI4
ADDRGP4 pm
INDIRP4
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRI4
ADDRLP4 72
INDIRI4
NEI4 $773
line 2079
;2079:		return;		// no movement at all
ADDRGP4 $713
JUMPV
LABELV $773
line 2082
;2080:	}
;2081:
;2082:	if ( pm->ps->pm_type == PM_INTERMISSION || pm->ps->pm_type == PM_SPINTERMISSION) {
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 5
EQI4 $777
ADDRLP4 76
INDIRI4
CNSTI4 6
NEI4 $775
LABELV $777
line 2083
;2083:		return;		// no movement at all
ADDRGP4 $713
JUMPV
LABELV $775
line 2087
;2084:	}
;2085:
;2086:	// set watertype, and waterlevel
;2087:	PM_SetWaterLevel();
ADDRGP4 PM_SetWaterLevel
CALLV
pop
line 2088
;2088:	pml.previous_waterlevel = pmove->waterlevel;
ADDRGP4 pml+136
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ASGNI4
line 2091
;2089:
;2090:	// set mins, maxs, and viewheight
;2091:	PM_CheckDuck ();
ADDRGP4 PM_CheckDuck
CALLV
pop
line 2094
;2092:
;2093:	// set groundentity
;2094:	PM_GroundTrace();
ADDRGP4 PM_GroundTrace
CALLV
pop
line 2096
;2095:
;2096:	if ( pm->ps->pm_type == PM_DEAD && (!pm->timeOfDeath || pm->timeOfDeath < pm->ps->commandTime)) {
ADDRLP4 80
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 84
ADDRLP4 80
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $779
ADDRLP4 88
ADDRLP4 80
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
EQI4 $781
ADDRLP4 88
INDIRI4
ADDRLP4 84
INDIRP4
INDIRI4
GEI4 $779
LABELV $781
line 2097
;2097:		PM_DeadMove ();
ADDRGP4 PM_DeadMove
CALLV
pop
line 2098
;2098:	}
LABELV $779
line 2100
;2099:
;2100:	PM_DropTimers();
ADDRGP4 PM_DropTimers
CALLV
pop
line 2103
;2101:
;2102:	// CPM: Double-jump timer
;2103:		if (pm->ps->stats[STAT_JUMPTIME] > 0) pm->ps->stats[STAT_JUMPTIME] -= pml.msec;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 0
LEI4 $782
ADDRLP4 92
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 212
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRI4
ADDRGP4 pml+40
INDIRI4
SUBI4
ASGNI4
LABELV $782
line 2111
;2104:	// !CPM
;2105:
;2106:#ifdef MISSIONPACK
;2107:	if ( pm->ps->powerups[PW_INVULNERABILITY] ) {
;2108:		PM_InvulnerabilityMove();
;2109:	} else
;2110:#endif
;2111:	if ( pm->ps->powerups[PW_FLIGHT] ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 0
EQI4 $785
line 2113
;2112:		// flight powerup doesn't allow jump and has different friction
;2113:		PM_FlyMove();
ADDRGP4 PM_FlyMove
CALLV
pop
line 2114
;2114:	} else if (pm->ps->pm_flags & PMF_GRAPPLE_PULL) {
ADDRGP4 $786
JUMPV
LABELV $785
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $787
line 2115
;2115:		PM_GrappleMove();
ADDRGP4 PM_GrappleMove
CALLV
pop
line 2117
;2116:		// We can wiggle a bit
;2117:		PM_AirMove();
ADDRGP4 PM_AirMove
CALLV
pop
line 2118
;2118:	} else if (pm->ps->pm_flags & PMF_TIME_WATERJUMP) {
ADDRGP4 $788
JUMPV
LABELV $787
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $789
line 2119
;2119:		PM_WaterJumpMove();
ADDRGP4 PM_WaterJumpMove
CALLV
pop
line 2120
;2120:	} else if ( pm->waterlevel > 1 ) {
ADDRGP4 $790
JUMPV
LABELV $789
ADDRGP4 pm
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 1
LEI4 $791
line 2122
;2121:		// swimming
;2122:		PM_WaterMove();
ADDRGP4 PM_WaterMove
CALLV
pop
line 2123
;2123:	} else if ( pml.walking ) {
ADDRGP4 $792
JUMPV
LABELV $791
ADDRGP4 pml+44
INDIRI4
CNSTI4 0
EQI4 $793
line 2125
;2124:		// walking on ground
;2125:		PM_WalkMove();
ADDRGP4 PM_WalkMove
CALLV
pop
line 2126
;2126:	} else {
ADDRGP4 $794
JUMPV
LABELV $793
line 2128
;2127:		// airborne
;2128:		PM_AirMove();
ADDRGP4 PM_AirMove
CALLV
pop
line 2129
;2129:	}
LABELV $794
LABELV $792
LABELV $790
LABELV $788
LABELV $786
line 2133
;2130:
;2131:	//Walks and airmoves done, we can check jump for key press view hack
;2132:	//Fix this shit Evo
;2133:	if ( pm->cmd.upmove > 0 && !(pm->ps->movementDir > 7) ) {
ADDRLP4 96
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LEI4 $796
ADDRLP4 96
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 7
GTI4 $796
line 2134
;2134:		pm->ps->movementDir += 8;
ADDRLP4 100
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRI4
CNSTI4 8
ADDI4
ASGNI4
line 2135
;2135:	}
LABELV $796
line 2136
;2136:	if ( pm->cmd.upmove <= 0 && pm->ps->movementDir > 7 ) {
ADDRLP4 100
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GTI4 $798
ADDRLP4 100
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 7
LEI4 $798
line 2137
;2137:		pm->ps->movementDir -= 8;
ADDRLP4 104
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 2138
;2138:	}
LABELV $798
line 2141
;2139:	//End Hack
;2140:
;2141:	PM_Animate();
ADDRGP4 PM_Animate
CALLV
pop
line 2144
;2142:
;2143:	// set groundentity, watertype, and waterlevel
;2144:	PM_GroundTrace();
ADDRGP4 PM_GroundTrace
CALLV
pop
line 2145
;2145:	PM_SetWaterLevel();
ADDRGP4 PM_SetWaterLevel
CALLV
pop
line 2148
;2146:
;2147:	// weapons
;2148:	PM_Weapon();
ADDRGP4 PM_Weapon
CALLV
pop
line 2151
;2149:
;2150:	// torso animation
;2151:	PM_TorsoAnimation();
ADDRGP4 PM_TorsoAnimation
CALLV
pop
line 2154
;2152:
;2153:	// footstep events / legs animations
;2154:	PM_Footsteps();
ADDRGP4 PM_Footsteps
CALLV
pop
line 2157
;2155:
;2156:	// entering / leaving water splashes
;2157:	PM_WaterEvents();
ADDRGP4 PM_WaterEvents
CALLV
pop
line 2160
;2158:
;2159:	// snap some parts of playerstate to save network bandwidth
;2160:	trap_SnapVector( pm->ps->velocity );
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 trap_SnapVector
CALLV
pop
line 2161
;2161:}
LABELV $713
endproc PmoveSingle 108 16
export Pmove
proc Pmove 16 4
line 2171
;2162:
;2163:
;2164:/*
;2165:================
;2166:Pmove
;2167:
;2168:Can be called by either the server or the client
;2169:================
;2170:*/
;2171:void Pmove (pmove_t *pmove) {
line 2174
;2172:	int			finalTime;
;2173:
;2174:	finalTime = pmove->cmd.serverTime;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 2180
;2175:
;2176:	//if (!pmove->ad || !pmove->ad->distance) {
;2177://		pmove->ad[pm->ps->clientNum]->distance = 0;
;2178:	//}
;2179:
;2180:	if ( finalTime < pmove->ps->commandTime ) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
INDIRP4
INDIRI4
GEI4 $801
line 2181
;2181:		return;	// should not happen
ADDRGP4 $800
JUMPV
LABELV $801
line 2184
;2182:	}
;2183:
;2184:	if ( finalTime > pmove->ps->commandTime + 1000 ) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
INDIRP4
INDIRI4
CNSTI4 1000
ADDI4
LEI4 $803
line 2185
;2185:		pmove->ps->commandTime = finalTime - 1000;
ADDRFP4 0
INDIRP4
INDIRP4
ADDRLP4 0
INDIRI4
CNSTI4 1000
SUBI4
ASGNI4
line 2186
;2186:	}
LABELV $803
line 2188
;2187:
;2188:	pmove->ps->pmove_framecount = (pmove->ps->pmove_framecount+1) & ((1<<PS_PMOVEFRAMECOUNTBITS)-1);
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRP4
CNSTI4 456
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 63
BANDI4
ASGNI4
ADDRGP4 $806
JUMPV
LABELV $805
line 2192
;2189:
;2190:	// chop the move up if it is too long, to prevent framerate
;2191:	// dependent behavior
;2192:	while ( pmove->ps->commandTime != finalTime ) {
line 2195
;2193:		int		msec;
;2194:
;2195:		msec = finalTime - pmove->ps->commandTime;
ADDRLP4 8
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
INDIRP4
INDIRI4
SUBI4
ASGNI4
line 2197
;2196:
;2197:		if ( pmove->pmove_fixed ) {
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CNSTI4 0
EQI4 $808
line 2198
;2198:			if ( msec > pmove->pmove_msec ) {
ADDRLP4 8
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRI4
LEI4 $809
line 2199
;2199:				msec = pmove->pmove_msec;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRI4
ASGNI4
line 2200
;2200:			}
line 2201
;2201:		}
ADDRGP4 $809
JUMPV
LABELV $808
line 2202
;2202:		else {
line 2203
;2203:			if ( msec > 66 ) {
ADDRLP4 8
INDIRI4
CNSTI4 66
LEI4 $812
line 2204
;2204:				msec = 66;
ADDRLP4 8
CNSTI4 66
ASGNI4
line 2205
;2205:			}
LABELV $812
line 2206
;2206:		}
LABELV $809
line 2207
;2207:		pmove->cmd.serverTime = pmove->ps->commandTime + msec;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 12
INDIRP4
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
ASGNI4
line 2208
;2208:		PmoveSingle( pmove );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 PmoveSingle
CALLV
pop
line 2210
;2209:
;2210:		if ( pmove->ps->pm_flags & PMF_JUMP_HELD ) {
ADDRFP4 0
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $814
line 2211
;2211:			pmove->cmd.upmove = 20;
ADDRFP4 0
INDIRP4
CNSTI4 27
ADDP4
CNSTI1 20
ASGNI1
line 2212
;2212:		}
LABELV $814
line 2213
;2213:	}
LABELV $806
line 2192
ADDRFP4 0
INDIRP4
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $805
line 2217
;2214:
;2215:	//PM_CheckStuck();
;2216:
;2217:}
LABELV $800
endproc Pmove 16 4
export BG_CanItemBeGrabbed
proc BG_CanItemBeGrabbed 36 8
line 2227
;2218:
;2219:/*
;2220:================
;2221:BG_CanItemBeGrabbed
;2222:
;2223:Returns false if the item should not be picked up.
;2224:This needs to be the same for client side prediction and server use.
;2225:================
;2226:*/
;2227:qboolean BG_CanItemBeGrabbed( int gametype, const entityState_t *ent, const playerState_t *ps ) {
line 2233
;2228:	gitem_t	*item;
;2229:#ifdef MISSIONPACK
;2230:	int		upperBound;
;2231:#endif
;2232:
;2233:	if ( ent->modelindex < 1 || ent->modelindex >= bg_numItems ) {
ADDRLP4 4
ADDRFP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1
LTI4 $819
ADDRLP4 4
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $817
LABELV $819
line 2234
;2234:		Com_Error( ERR_DROP, "BG_CanItemBeGrabbed: index out of range" );
CNSTI4 1
ARGI4
ADDRGP4 $820
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 2235
;2235:	}
LABELV $817
line 2237
;2236:
;2237:	item = &bg_itemlist[ent->modelindex];
ADDRLP4 0
CNSTI4 52
ADDRFP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 2239
;2238:
;2239:	switch( item->giType ) {
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $822
ADDRLP4 8
INDIRI4
CNSTI4 8
GTI4 $822
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $858
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $858
address $856
address $824
address $825
address $826
address $827
address $835
address $853
address $822
address $836
code
LABELV $824
line 2241
;2240:	case IT_WEAPON:
;2241:		return qtrue;	// weapons are always picked up
CNSTI4 1
RETI4
ADDRGP4 $816
JUMPV
LABELV $825
line 2250
;2242:
;2243:	/*case IT_AMMO:
;2244:		if ( ps->ammo[ item->giTag ] >= 200 ) {
;2245:			return qfalse;		// can't hold any more
;2246:		}
;2247:		return qtrue;*/
;2248:	case IT_AMMO:
;2249:		// CPM: Check max ammo values
;2250:		return CPM_CanGrabAmmo(item, ps);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 CPM_CanGrabAmmo
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
RETI4
ADDRGP4 $816
JUMPV
LABELV $826
line 2271
;2251:		// !CPM;
;2252:
;2253:	case IT_ARMOR:
;2254:#ifdef MISSIONPACK
;2255:		if( bg_itemlist[ps->stats[STAT_PERSISTANT_POWERUP]].giTag == PW_SCOUT ) {
;2256:			return qfalse;
;2257:		}
;2258:
;2259:		// we also clamp armor to the maxhealth for handicapping
;2260:		if( bg_itemlist[ps->stats[STAT_PERSISTANT_POWERUP]].giTag == PW_GUARD ) {
;2261:			upperBound = ps->stats[STAT_MAX_HEALTH];
;2262:		}
;2263:		else {
;2264:			upperBound = ps->stats[STAT_MAX_HEALTH] * 2;
;2265:		}
;2266:
;2267:		if ( ps->stats[STAT_ARMOR] >= upperBound ) {
;2268:			return qfalse;
;2269:		}
;2270:#else
;2271:		return CPM_CanGrabArmor(item, ps);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 CPM_CanGrabArmor
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $816
JUMPV
LABELV $827
line 2287
;2272:		//if ( ps->stats[STAT_ARMOR] >= ps->stats[STAT_MAX_HEALTH] * 2 ) {
;2273:		//	return qfalse;
;2274:		//}
;2275:#endif
;2276:		//return qtrue;
;2277:
;2278:	case IT_HEALTH:
;2279:		// small and mega healths will go over the max, otherwise
;2280:		// don't pick up if already at max
;2281:#ifdef MISSIONPACK
;2282:		if( bg_itemlist[ps->stats[STAT_PERSISTANT_POWERUP]].giTag == PW_GUARD ) {
;2283:			upperBound = ps->stats[STAT_MAX_HEALTH];
;2284:		}
;2285:		else
;2286:#endif
;2287:		if ( item->quantity == 5 || item->quantity == 100 ) {
ADDRLP4 24
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 5
EQI4 $830
ADDRLP4 24
INDIRI4
CNSTI4 100
NEI4 $828
LABELV $830
line 2288
;2288:			if ( ps->stats[STAT_HEALTH] >= ps->stats[STAT_MAX_HEALTH] * 2 ) {
ADDRLP4 28
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRLP4 28
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1
LSHI4
LTI4 $831
line 2289
;2289:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $816
JUMPV
LABELV $831
line 2291
;2290:			}
;2291:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $816
JUMPV
LABELV $828
line 2294
;2292:		}
;2293:
;2294:		if ( ps->stats[STAT_HEALTH] >= ps->stats[STAT_MAX_HEALTH] ) {
ADDRLP4 28
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRLP4 28
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
LTI4 $833
line 2295
;2295:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $816
JUMPV
LABELV $833
line 2297
;2296:		}
;2297:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $816
JUMPV
LABELV $835
line 2300
;2298:
;2299:	case IT_POWERUP:
;2300:		return qtrue;	// powerups are always picked up
CNSTI4 1
RETI4
ADDRGP4 $816
JUMPV
LABELV $836
line 2338
;2301:
;2302:#ifdef MISSIONPACK
;2303:	case IT_PERSISTANT_POWERUP:
;2304:		// can only hold one item at a time
;2305:		if ( ps->stats[STAT_PERSISTANT_POWERUP] ) {
;2306:			return qfalse;
;2307:		}
;2308:
;2309:		// check team only
;2310:		if( ( ent->generic1 & 2 ) && ( ps->persistant[PERS_TEAM] != TEAM_RED ) ) {
;2311:			return qfalse;
;2312:		}
;2313:		if( ( ent->generic1 & 4 ) && ( ps->persistant[PERS_TEAM] != TEAM_BLUE ) ) {
;2314:			return qfalse;
;2315:		}
;2316:
;2317:		return qtrue;
;2318:#endif
;2319:
;2320:	case IT_TEAM: // team items, such as flags
;2321:#ifdef MISSIONPACK		
;2322:		if( gametype == GT_1FCTF ) {
;2323:			// neutral flag can always be picked up
;2324:			if( item->giTag == PW_NEUTRALFLAG ) {
;2325:				return qtrue;
;2326:			}
;2327:			if (ps->persistant[PERS_TEAM] == TEAM_RED) {
;2328:				if (item->giTag == PW_BLUEFLAG  && ps->powerups[PW_NEUTRALFLAG] ) {
;2329:					return qtrue;
;2330:				}
;2331:			} else if (ps->persistant[PERS_TEAM] == TEAM_BLUE) {
;2332:				if (item->giTag == PW_REDFLAG  && ps->powerups[PW_NEUTRALFLAG] ) {
;2333:					return qtrue;
;2334:				}
;2335:			}
;2336:		}
;2337:#endif
;2338:		if( gametype == GT_CTF ) {
ADDRFP4 0
INDIRI4
CNSTI4 4
NEI4 $837
line 2342
;2339:			// ent->modelindex2 is non-zero on items if they are dropped
;2340:			// we need to know this because we can pick up our dropped flag (and return it)
;2341:			// but we can't pick up our flag at base
;2342:			if (ps->persistant[PERS_TEAM] == TEAM_RED) {
ADDRFP4 8
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 1
NEI4 $839
line 2343
;2343:				if (item->giTag == PW_BLUEFLAG ||
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 8
EQI4 $844
ADDRLP4 32
INDIRI4
CNSTI4 7
NEI4 $845
ADDRFP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 0
NEI4 $844
LABELV $845
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 7
NEI4 $840
ADDRFP4 8
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $840
LABELV $844
line 2346
;2344:					(item->giTag == PW_REDFLAG && ent->modelindex2) ||
;2345:					(item->giTag == PW_REDFLAG && ps->powerups[PW_BLUEFLAG]) )
;2346:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $816
JUMPV
line 2347
;2347:			} else if (ps->persistant[PERS_TEAM] == TEAM_BLUE) {
LABELV $839
ADDRFP4 8
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 2
NEI4 $846
line 2348
;2348:				if (item->giTag == PW_REDFLAG ||
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 7
EQI4 $851
ADDRLP4 32
INDIRI4
CNSTI4 8
NEI4 $852
ADDRFP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 0
NEI4 $851
LABELV $852
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 8
NEI4 $848
ADDRFP4 8
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
EQI4 $848
LABELV $851
line 2351
;2349:					(item->giTag == PW_BLUEFLAG && ent->modelindex2) ||
;2350:					(item->giTag == PW_BLUEFLAG && ps->powerups[PW_REDFLAG]) )
;2351:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $816
JUMPV
LABELV $848
line 2352
;2352:			}
LABELV $846
LABELV $840
line 2353
;2353:		}
LABELV $837
line 2360
;2354:
;2355:#ifdef MISSIONPACK
;2356:		if( gametype == GT_HARVESTER ) {
;2357:			return qtrue;
;2358:		}
;2359:#endif
;2360:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $816
JUMPV
LABELV $853
line 2364
;2361:
;2362:	case IT_HOLDABLE:
;2363:		// can only hold one item at a time
;2364:		if ( ps->stats[STAT_HOLDABLE_ITEM] ) {
ADDRFP4 8
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 0
EQI4 $854
line 2365
;2365:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $816
JUMPV
LABELV $854
line 2367
;2366:		}
;2367:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $816
JUMPV
LABELV $856
line 2370
;2368:
;2369:        case IT_BAD:
;2370:            Com_Error( ERR_DROP, "BG_CanItemBeGrabbed: IT_BAD" );
CNSTI4 1
ARGI4
ADDRGP4 $857
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 2377
;2371:        default:
;2372:#ifndef Q3_VM
;2373:#ifndef NDEBUG // bk0001204
;2374:          Com_Printf("BG_CanItemBeGrabbed: unknown enum %d\n", item->giType );
;2375:#endif
;2376:#endif
;2377:         break;
LABELV $822
line 2380
;2378:	}
;2379:
;2380:	return qfalse;
CNSTI4 0
RETI4
LABELV $816
endproc BG_CanItemBeGrabbed 36 8
import trap_SnapVector
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
import cpm_pm_wishspeed
import cpm_pm_strafeaccelerate
import cpm_pm_aircontrol
import cpm_pm_airstopaccelerate
import cpm_pm_jump_z
import CPM_UpdateSettings
import g_allowReady
import g_fastSwitch
import g_interference
import g_pro_mode
import g_delagHitscan
import g_gamemode
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
import PM_StepSlideMove
import PM_SlideMove
bss
export pml
align 4
LABELV pml
skip 140
export pm
align 4
LABELV pm
skip 4
import BG_ProModePlayerTouchesItem
import BG_PlayerTouchesItem
import BG_PlayerStateToEntityStateExtraPolate
import BG_PlayerStateToEntityState
import BG_TouchJumpPad
import BG_AddPredictableEventToPlayerstate
import BG_EvaluateTrajectoryDelta
import BG_EvaluateTrajectory
import BG_FindItemForHoldable
import BG_FindItemForPowerup
import BG_FindItemForWeapon
import BG_FindItem
import bg_numItems
import bg_itemlist
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
LABELV $857
byte 1 66
byte 1 71
byte 1 95
byte 1 67
byte 1 97
byte 1 110
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 66
byte 1 101
byte 1 71
byte 1 114
byte 1 97
byte 1 98
byte 1 98
byte 1 101
byte 1 100
byte 1 58
byte 1 32
byte 1 73
byte 1 84
byte 1 95
byte 1 66
byte 1 65
byte 1 68
byte 1 0
align 1
LABELV $820
byte 1 66
byte 1 71
byte 1 95
byte 1 67
byte 1 97
byte 1 110
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 66
byte 1 101
byte 1 71
byte 1 114
byte 1 97
byte 1 98
byte 1 98
byte 1 101
byte 1 100
byte 1 58
byte 1 32
byte 1 105
byte 1 110
byte 1 100
byte 1 101
byte 1 120
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $491
byte 1 37
byte 1 105
byte 1 58
byte 1 76
byte 1 97
byte 1 110
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $480
byte 1 37
byte 1 105
byte 1 58
byte 1 115
byte 1 116
byte 1 101
byte 1 101
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $469
byte 1 37
byte 1 105
byte 1 58
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 111
byte 1 102
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $438
byte 1 37
byte 1 105
byte 1 58
byte 1 108
byte 1 105
byte 1 102
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $411
byte 1 37
byte 1 105
byte 1 58
byte 1 97
byte 1 108
byte 1 108
byte 1 115
byte 1 111
byte 1 108
byte 1 105
byte 1 100
byte 1 10
byte 1 0
