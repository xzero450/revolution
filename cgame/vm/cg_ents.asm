export CG_PositionEntityOnTag
code
proc CG_PositionEntityOnTag 84 24
file "../cg_ents.c"
line 17
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_ents.c -- present snapshot entities, happens every single frame
;4:
;5:#include "cg_local.h"
;6:
;7:
;8:/*
;9:======================
;10:CG_PositionEntityOnTag
;11:
;12:Modifies the entities position and axis by the given
;13:tag location
;14:======================
;15:*/
;16:void CG_PositionEntityOnTag( refEntity_t *entity, const refEntity_t *parent, 
;17:							qhandle_t parentModel, char *tagName ) {
line 22
;18:	int				i;
;19:	orientation_t	lerped;
;20:	
;21:	// lerp the tag
;22:	trap_R_LerpTag( &lerped, parentModel, parent->oldframe, parent->frame,
ADDRLP4 4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 52
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 96
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ARGI4
CNSTF4 1065353216
ADDRLP4 52
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ARGF4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_LerpTag
CALLI4
pop
line 26
;23:		1.0 - parent->backlerp, tagName );
;24:
;25:	// FIXME: allow origin offsets along tag?
;26:	VectorCopy( parent->origin, entity->origin );
ADDRLP4 56
CNSTI4 68
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
ADDRFP4 4
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRB
ASGNB 12
line 27
;27:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $78
line 28
;28:		VectorMA( entity->origin, lerped.origin[i], parent->axis[i], entity->origin );
ADDRLP4 60
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 68
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRF4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 76
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRF4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 29
;29:	}
LABELV $79
line 27
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $78
line 32
;30:
;31:	// had to cast away the const to avoid compiler problems...
;32:	MatrixMultiply( lerped.axis, ((refEntity_t *)parent)->axis, entity->axis );
ADDRLP4 4+12
ARGP4
ADDRLP4 60
CNSTI4 28
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 60
INDIRI4
ADDP
ARGP4
ADDRFP4 0
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
ARGP4
ADDRGP4 MatrixMultiply
CALLV
pop
line 33
;33:	entity->backlerp = parent->backlerp;
ADDRLP4 64
CNSTI4 100
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
ADDRFP4 4
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 34
;34:}
LABELV $77
endproc CG_PositionEntityOnTag 84 24
export CG_PositionRotatedEntityOnTag
proc CG_PositionRotatedEntityOnTag 120 24
line 46
;35:
;36:
;37:/*
;38:======================
;39:CG_PositionRotatedEntityOnTag
;40:
;41:Modifies the entities position and axis by the given
;42:tag location
;43:======================
;44:*/
;45:void CG_PositionRotatedEntityOnTag( refEntity_t *entity, const refEntity_t *parent, 
;46:							qhandle_t parentModel, char *tagName ) {
line 53
;47:	int				i;
;48:	orientation_t	lerped;
;49:	vec3_t			tempAxis[3];
;50:
;51://AxisClear( entity->axis );
;52:	// lerp the tag
;53:	trap_R_LerpTag( &lerped, parentModel, parent->oldframe, parent->frame,
ADDRLP4 4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 88
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 96
ADDP4
INDIRI4
ARGI4
ADDRLP4 88
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ARGI4
CNSTF4 1065353216
ADDRLP4 88
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ARGF4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_LerpTag
CALLI4
pop
line 57
;54:		1.0 - parent->backlerp, tagName );
;55:
;56:	// FIXME: allow origin offsets along tag?
;57:	VectorCopy( parent->origin, entity->origin );
ADDRLP4 92
CNSTI4 68
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
ADDRFP4 4
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRB
ASGNB 12
line 58
;58:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $84
line 59
;59:		VectorMA( entity->origin, lerped.origin[i], parent->axis[i], entity->origin );
ADDRLP4 96
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 96
INDIRP4
ADDRLP4 96
INDIRP4
INDIRF4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 104
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRF4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 112
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRF4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 60
;60:	}
LABELV $85
line 58
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $84
line 63
;61:
;62:	// had to cast away the const to avoid compiler problems...
;63:	MatrixMultiply( entity->axis, lerped.axis, tempAxis );
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRLP4 4+12
ARGP4
ADDRLP4 52
ARGP4
ADDRGP4 MatrixMultiply
CALLV
pop
line 64
;64:	MatrixMultiply( tempAxis, ((refEntity_t *)parent)->axis, entity->axis );
ADDRLP4 52
ARGP4
ADDRLP4 96
CNSTI4 28
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 96
INDIRI4
ADDP
ARGP4
ADDRFP4 0
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
ARGP4
ADDRGP4 MatrixMultiply
CALLV
pop
line 65
;65:}
LABELV $83
endproc CG_PositionRotatedEntityOnTag 120 24
export CG_SetEntitySoundPosition
proc CG_SetEntitySoundPosition 24 8
line 84
;66:
;67:
;68:
;69:/*
;70:==========================================================================
;71:
;72:FUNCTIONS CALLED EACH FRAME
;73:
;74:==========================================================================
;75:*/
;76:
;77:/*
;78:======================
;79:CG_SetEntitySoundPosition
;80:
;81:Also called by event processing code
;82:======================
;83:*/
;84:void CG_SetEntitySoundPosition( centity_t *cent ) {
line 85
;85:	if ( cent->currentState.solid == SOLID_BMODEL ) {
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 16777215
NEI4 $90
line 89
;86:		vec3_t	origin;
;87:		float	*v;
;88:
;89:		v = cgs.inlineModelMidpoints[ cent->currentState.modelindex ];
ADDRLP4 12
CNSTI4 12
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+37888
ADDP4
ASGNP4
line 90
;90:		VectorAdd( cent->lerpOrigin, v, origin );
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 12
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
CNSTI4 704
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 16
INDIRP4
CNSTI4 708
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 712
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
ASGNF4
line 91
;91:		trap_S_UpdateEntityPosition( cent->currentState.number, origin );
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_S_UpdateEntityPosition
CALLV
pop
line 92
;92:	} else {
ADDRGP4 $91
JUMPV
LABELV $90
line 93
;93:		trap_S_UpdateEntityPosition( cent->currentState.number, cent->lerpOrigin );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
ARGP4
ADDRGP4 trap_S_UpdateEntityPosition
CALLV
pop
line 94
;94:	}
LABELV $91
line 95
;95:}
LABELV $89
endproc CG_SetEntitySoundPosition 24 8
proc CG_EntityEffects 20 20
line 104
;96:
;97:/*
;98:==================
;99:CG_EntityEffects
;100:
;101:Add continuous entity effects, like local entity emission and lighting
;102:==================
;103:*/
;104:static void CG_EntityEffects( centity_t *cent ) {
line 107
;105:
;106:	// update sound origins
;107:	CG_SetEntitySoundPosition( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetEntitySoundPosition
CALLV
pop
line 109
;108:
;109:	if( s_ambient.integer != 0 ) {
ADDRGP4 s_ambient+12
INDIRI4
CNSTI4 0
EQI4 $96
line 111
;110:		// add loop sound
;111:		if ( cent->currentState.loopSound ) {
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRI4
CNSTI4 0
EQI4 $99
line 112
;112:			if (cent->currentState.eType != ET_SPEAKER) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 7
EQI4 $101
line 113
;113:				trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin, 
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35836
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_AddLoopingSound
CALLV
pop
line 115
;114:					cgs.gameSounds[ cent->currentState.loopSound ] );
;115:			} else {
ADDRGP4 $102
JUMPV
LABELV $101
line 116
;116:				trap_S_AddRealLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin, 
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35836
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_AddRealLoopingSound
CALLV
pop
line 118
;117:					cgs.gameSounds[ cent->currentState.loopSound ] );
;118:			}
LABELV $102
line 119
;119:		}
LABELV $99
line 120
;120:	}
LABELV $96
line 123
;121:
;122:	// constant light glow
;123:	if ( cent->currentState.constantLight ) {
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
INDIRI4
CNSTI4 0
EQI4 $105
line 127
;124:		int		cl;
;125:		int		i, r, g, b;
;126:
;127:		cl = cent->currentState.constantLight;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
INDIRI4
ASGNI4
line 128
;128:		r = cl & 255;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 255
BANDI4
ASGNI4
line 129
;129:		g = ( cl >> 8 ) & 255;
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 8
RSHI4
CNSTI4 255
BANDI4
ASGNI4
line 130
;130:		b = ( cl >> 16 ) & 255;
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 16
RSHI4
CNSTI4 255
BANDI4
ASGNI4
line 131
;131:		i = ( ( cl >> 24 ) & 255 ) * 4;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 24
RSHI4
CNSTI4 255
BANDI4
CNSTI4 2
LSHI4
ASGNI4
line 132
;132:		trap_R_AddLightToScene( cent->lerpOrigin, i, r, g, b );
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
ARGP4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 133
;133:	}
LABELV $105
line 135
;134:
;135:}
LABELV $95
endproc CG_EntityEffects 20 20
proc CG_General 144 12
line 143
;136:
;137:
;138:/*
;139:==================
;140:CG_General
;141:==================
;142:*/
;143:static void CG_General( centity_t *cent ) {
line 147
;144:	refEntity_t			ent;
;145:	entityState_t		*s1;
;146:
;147:	s1 = &cent->currentState;
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
line 150
;148:
;149:	// if set to invisible, skip
;150:	if (!s1->modelindex) {
ADDRLP4 140
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 0
NEI4 $108
line 151
;151:		return;
ADDRGP4 $107
JUMPV
LABELV $108
line 154
;152:	}
;153:
;154:	memset (&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 158
;155:
;156:	// set frame
;157:
;158:	ent.frame = s1->frame;
ADDRLP4 0+80
ADDRLP4 140
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ASGNI4
line 159
;159:	ent.oldframe = ent.frame;
ADDRLP4 0+96
ADDRLP4 0+80
INDIRI4
ASGNI4
line 160
;160:	ent.backlerp = 0;
ADDRLP4 0+100
CNSTF4 0
ASGNF4
line 162
;161:
;162:	VectorCopy( cent->lerpOrigin, ent.origin);
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRB
ASGNB 12
line 163
;163:	VectorCopy( cent->lerpOrigin, ent.oldorigin);
ADDRLP4 0+84
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRB
ASGNB 12
line 165
;164:
;165:	ent.hModel = cgs.gameModels[s1->modelindex];
ADDRLP4 0+8
ADDRLP4 140
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+34812
ADDP4
INDIRI4
ASGNI4
line 168
;166:
;167:	// player model
;168:	if (s1->number == cg.snap->ps.clientNum) {
ADDRLP4 140
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $118
line 169
;169:		ent.renderfx |= RF_THIRD_PERSON;	// only draw from mirrors
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 170
;170:	}
LABELV $118
line 173
;171:
;172:	// convert angles to axis
;173:	AnglesToAxis( cent->lerpAngles, ent.axis );
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 176
;174:
;175:	// add to refresh list
;176:	trap_R_AddRefEntityToScene (&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 177
;177:}
LABELV $107
endproc CG_General 144 12
proc CG_Speaker 16 16
line 186
;178:
;179:/*
;180:==================
;181:CG_Speaker
;182:
;183:Speaker entities can automatically play sounds
;184:==================
;185:*/
;186:static void CG_Speaker( centity_t *cent ) {
line 187
;187:	if( s_ambient.integer == 0 ) {
ADDRGP4 s_ambient+12
INDIRI4
CNSTI4 0
NEI4 $124
line 188
;188:		trap_S_StopLoopingSound(cent->currentState.number);
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StopLoopingSound
CALLV
pop
line 189
;189:		return;
ADDRGP4 $123
JUMPV
LABELV $124
line 192
;190:	}
;191:
;192:	if ( ! cent->currentState.clientNum ) {	// FIXME: use something other than clientNum...
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 0
NEI4 $127
line 193
;193:		return;		// not auto triggering
ADDRGP4 $123
JUMPV
LABELV $127
line 196
;194:	}
;195:
;196:	if ( cg.time < cent->miscTime ) {
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
INDIRI4
GEI4 $129
line 197
;197:		return;
ADDRGP4 $123
JUMPV
LABELV $129
line 200
;198:	}
;199:
;200:	trap_S_StartSound (NULL, cent->currentState.number, CHAN_ITEM, cgs.gameSounds[cent->currentState.eventParm] );
CNSTP4 0
ARGP4
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35836
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 204
;201:
;202:	//	ent->s.frame = ent->wait * 10;
;203:	//	ent->s.clientNum = ent->random * 10;
;204:	cent->miscTime = cg.time + cent->currentState.frame * 100 + cent->currentState.clientNum * 100 * crandom();
ADDRLP4 4
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
CNSTI4 100
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 444
ADDP4
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 12
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
MULI4
ADDI4
CVIF4 4
ADDRLP4 12
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
MULI4
CVIF4 4
CNSTF4 1073741824
ADDRLP4 4
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
ADDF4
CVFI4 4
ASGNI4
line 205
;205:}
LABELV $123
endproc CG_Speaker 16 16
proc CG_Item 208 12
line 212
;206:
;207:/*
;208:==================
;209:CG_Item
;210:==================
;211:*/
;212:static void CG_Item( centity_t *cent ) {
line 221
;213:	refEntity_t		ent;
;214:	entityState_t	*es;
;215:	gitem_t			*item;
;216:	int				msec;
;217:	float			frac;
;218:	float			scale;
;219:	weaponInfo_t	*wi;
;220:
;221:	es = &cent->currentState;
ADDRLP4 144
ADDRFP4 0
INDIRP4
ASGNP4
line 222
;222:	if ( es->modelindex >= bg_numItems ) {
ADDRLP4 144
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $135
line 223
;223:		CG_Error( "Bad item index %i on entity", es->modelindex );
ADDRGP4 $137
ARGP4
ADDRLP4 144
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 224
;224:	}
LABELV $135
line 227
;225:
;226:	// if set to invisible, skip
;227:	if ( !es->modelindex || ( es->eFlags & EF_NODRAW ) ) {
ADDRLP4 168
CNSTI4 0
ASGNI4
ADDRLP4 144
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ADDRLP4 168
INDIRI4
EQI4 $140
ADDRLP4 144
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 128
BANDI4
ADDRLP4 168
INDIRI4
EQI4 $138
LABELV $140
line 228
;228:		return;
ADDRGP4 $134
JUMPV
LABELV $138
line 231
;229:	}
;230:
;231:	item = &bg_itemlist[ es->modelindex ];
ADDRLP4 140
CNSTI4 52
ADDRLP4 144
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 232
;232:	if ( cg_simpleItems.integer && item->giType != IT_TEAM ) {
ADDRGP4 cg_simpleItems+12
INDIRI4
CNSTI4 0
EQI4 $141
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
EQI4 $141
line 233
;233:		memset( &ent, 0, sizeof( ent ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 234
;234:		ent.reType = RT_SPRITE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 235
;235:		VectorCopy( cent->lerpOrigin, ent.origin );
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRB
ASGNB 12
line 236
;236:		ent.radius = 14;
ADDRLP4 0+132
CNSTF4 1096810496
ASGNF4
line 237
;237:		ent.customShader = cg_items[es->modelindex].icon;
ADDRLP4 0+112
CNSTI4 24
ADDRLP4 144
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_items+20
ADDP4
INDIRI4
ASGNI4
line 238
;238:		ent.shaderRGBA[0] = 255;
ADDRLP4 0+116
CNSTU1 255
ASGNU1
line 239
;239:		ent.shaderRGBA[1] = 255;
ADDRLP4 0+116+1
CNSTU1 255
ASGNU1
line 240
;240:		ent.shaderRGBA[2] = 255;
ADDRLP4 0+116+2
CNSTU1 255
ASGNU1
line 241
;241:		ent.shaderRGBA[3] = 255;
ADDRLP4 0+116+3
CNSTU1 255
ASGNU1
line 242
;242:		trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 243
;243:		return;
ADDRGP4 $134
JUMPV
LABELV $141
line 247
;244:	}
;245:
;246:	// items bob up and down continuously
;247:	if ( cg_itemFX.integer & 1 ) {
ADDRGP4 cg_itemFX+12
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $155
line 248
;248:		scale = 0.005 + cent->currentState.number * 0.00001;
ADDRLP4 160
CNSTF4 925353388
ADDRFP4 0
INDIRP4
INDIRI4
CVIF4 4
MULF4
CNSTF4 1000593162
ADDF4
ASGNF4
line 249
;249:		cent->lerpOrigin[2] += 4 + cos( ( cg.time + 1000 ) *  scale ) * 4;
ADDRGP4 cg+107604
INDIRI4
CNSTI4 1000
ADDI4
CVIF4 4
ADDRLP4 160
INDIRF4
MULF4
ARGF4
ADDRLP4 172
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 176
ADDRFP4 0
INDIRP4
CNSTI4 712
ADDP4
ASGNP4
ADDRLP4 176
INDIRP4
ADDRLP4 176
INDIRP4
INDIRF4
CNSTF4 1082130432
ADDRLP4 172
INDIRF4
MULF4
CNSTF4 1082130432
ADDF4
ADDF4
ASGNF4
line 250
;250:	} else {
ADDRGP4 $156
JUMPV
LABELV $155
line 251
;251:		scale = 0;
ADDRLP4 160
CNSTF4 0
ASGNF4
line 252
;252:		cent->lerpOrigin[2] += 4 + cos( ( cg.time + 1000 ) *  scale ) * 4;
ADDRGP4 cg+107604
INDIRI4
CNSTI4 1000
ADDI4
CVIF4 4
ADDRLP4 160
INDIRF4
MULF4
ARGF4
ADDRLP4 172
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 176
ADDRFP4 0
INDIRP4
CNSTI4 712
ADDP4
ASGNP4
ADDRLP4 176
INDIRP4
ADDRLP4 176
INDIRP4
INDIRF4
CNSTF4 1082130432
ADDRLP4 172
INDIRF4
MULF4
CNSTF4 1082130432
ADDF4
ADDF4
ASGNF4
line 253
;253:	}
LABELV $156
line 255
;254:
;255:	memset (&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 259
;256:
;257:	// autorotate at one of two speeds
;258:	//itemFx & 2 could've been done here I guess.. 
;259:	if ( item->giType == IT_HEALTH ) {
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 4
NEI4 $160
line 260
;260:		VectorCopy( cg.autoAnglesFast, cent->lerpAngles );
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ADDRGP4 cg+109000
INDIRB
ASGNB 12
line 261
;261:		AxisCopy( cg.autoAxisFast, ent.axis );
ADDRGP4 cg+109012
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AxisCopy
CALLV
pop
line 262
;262:	} else {
ADDRGP4 $161
JUMPV
LABELV $160
line 263
;263:		VectorCopy( cg.autoAngles, cent->lerpAngles );
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ADDRGP4 cg+108952
INDIRB
ASGNB 12
line 264
;264:		AxisCopy( cg.autoAxis, ent.axis );
ADDRGP4 cg+108964
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AxisCopy
CALLV
pop
line 265
;265:	}
LABELV $161
line 267
;266:
;267:	wi = NULL;
ADDRLP4 152
CNSTP4 0
ASGNP4
line 271
;268:	// the weapons have their origin where they attatch to player
;269:	// models, so we need to offset them or they will rotate
;270:	// eccentricly
;271:	if ( item->giType == IT_WEAPON ) {
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $168
line 272
;272:		wi = &cg_weapons[item->giTag];
ADDRLP4 152
CNSTI4 136
ADDRLP4 140
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons
ADDP4
ASGNP4
line 273
;273:		cent->lerpOrigin[0] -= 
ADDRLP4 172
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
ASGNP4
ADDRLP4 172
INDIRP4
ADDRLP4 172
INDIRP4
INDIRF4
ADDRLP4 152
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 0+28
INDIRF4
MULF4
ADDRLP4 152
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0+28+12
INDIRF4
MULF4
ADDF4
ADDRLP4 152
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0+28+24
INDIRF4
MULF4
ADDF4
SUBF4
ASGNF4
line 277
;274:			wi->weaponMidpoint[0] * ent.axis[0][0] +
;275:			wi->weaponMidpoint[1] * ent.axis[1][0] +
;276:			wi->weaponMidpoint[2] * ent.axis[2][0];
;277:		cent->lerpOrigin[1] -= 
ADDRLP4 180
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ASGNP4
ADDRLP4 180
INDIRP4
ADDRLP4 180
INDIRP4
INDIRF4
ADDRLP4 152
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 0+28+4
INDIRF4
MULF4
ADDRLP4 152
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0+28+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 152
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0+28+24+4
INDIRF4
MULF4
ADDF4
SUBF4
ASGNF4
line 281
;278:			wi->weaponMidpoint[0] * ent.axis[0][1] +
;279:			wi->weaponMidpoint[1] * ent.axis[1][1] +
;280:			wi->weaponMidpoint[2] * ent.axis[2][1];
;281:		cent->lerpOrigin[2] -= 
ADDRLP4 188
ADDRFP4 0
INDIRP4
CNSTI4 712
ADDP4
ASGNP4
ADDRLP4 188
INDIRP4
ADDRLP4 188
INDIRP4
INDIRF4
ADDRLP4 152
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 0+28+8
INDIRF4
MULF4
ADDRLP4 152
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0+28+12+8
INDIRF4
MULF4
ADDF4
ADDRLP4 152
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0+28+24+8
INDIRF4
MULF4
ADDF4
SUBF4
ASGNF4
line 286
;282:			wi->weaponMidpoint[0] * ent.axis[0][2] +
;283:			wi->weaponMidpoint[1] * ent.axis[1][2] +
;284:			wi->weaponMidpoint[2] * ent.axis[2][2];
;285:
;286:		cent->lerpOrigin[2] += 8;	// an extra height boost
ADDRLP4 196
ADDRFP4 0
INDIRP4
CNSTI4 712
ADDP4
ASGNP4
ADDRLP4 196
INDIRP4
ADDRLP4 196
INDIRP4
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 287
;287:	}
LABELV $168
line 289
;288:
;289:	ent.hModel = cg_items[es->modelindex].models[0];
ADDRLP4 0+8
CNSTI4 24
ADDRLP4 144
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_items+4
ADDP4
INDIRI4
ASGNI4
line 291
;290:
;291:	VectorCopy( cent->lerpOrigin, ent.origin);
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRB
ASGNB 12
line 292
;292:	VectorCopy( cent->lerpOrigin, ent.oldorigin);
ADDRLP4 0+84
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRB
ASGNB 12
line 294
;293:
;294:	ent.nonNormalizedAxes = qfalse;
ADDRLP4 0+64
CNSTI4 0
ASGNI4
line 297
;295:
;296:	// if just respawned, slowly scale up
;297:	msec = cg.time - cent->miscTime;
ADDRLP4 156
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
INDIRI4
SUBI4
ASGNI4
line 298
;298:	if ( msec >= 0 && msec < ITEM_SCALEUP_TIME && cg_itemFX.integer & 4 ) {
ADDRLP4 176
CNSTI4 0
ASGNI4
ADDRLP4 156
INDIRI4
ADDRLP4 176
INDIRI4
LTI4 $197
ADDRLP4 156
INDIRI4
CNSTI4 1000
GEI4 $197
ADDRGP4 cg_itemFX+12
INDIRI4
CNSTI4 4
BANDI4
ADDRLP4 176
INDIRI4
EQI4 $197
line 299
;299:		frac = (float)msec / ITEM_SCALEUP_TIME;
ADDRLP4 148
ADDRLP4 156
INDIRI4
CVIF4 4
CNSTF4 1148846080
DIVF4
ASGNF4
line 300
;300:		VectorScale( ent.axis[0], frac, ent.axis[0] );
ADDRLP4 0+28
ADDRLP4 0+28
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+4
ADDRLP4 0+28+4
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+8
ADDRLP4 0+28+8
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
line 301
;301:		VectorScale( ent.axis[1], frac, ent.axis[1] );
ADDRLP4 0+28+12
ADDRLP4 0+28+12
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+4
ADDRLP4 0+28+12+4
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+8
ADDRLP4 0+28+12+8
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
line 302
;302:		VectorScale( ent.axis[2], frac, ent.axis[2] );
ADDRLP4 0+28+24
ADDRLP4 0+28+24
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+24+4
ADDRLP4 0+28+24+4
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+24+8
ADDRLP4 0+28+24+8
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
line 303
;303:		ent.nonNormalizedAxes = qtrue;
ADDRLP4 0+64
CNSTI4 1
ASGNI4
line 304
;304:	} else {
ADDRGP4 $198
JUMPV
LABELV $197
line 305
;305:		frac = 1.0;
ADDRLP4 148
CNSTF4 1065353216
ASGNF4
line 306
;306:	}
LABELV $198
line 310
;307:
;308:	// items without glow textures need to keep a minimum light value
;309:	// so they are always visible
;310:	if ( ( item->giType == IT_WEAPON ) ||
ADDRLP4 180
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 1
EQI4 $245
ADDRLP4 180
INDIRI4
CNSTI4 3
NEI4 $243
LABELV $245
line 311
;311:		 ( item->giType == IT_ARMOR ) ) {
line 312
;312:		ent.renderfx |= RF_MINLIGHT;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 313
;313:	}
LABELV $243
line 316
;314:
;315:	// increase the size of the weapons when they are presented as items
;316:	if ( item->giType == IT_WEAPON ) {
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $247
line 317
;317:		VectorScale( ent.axis[0], 1.5, ent.axis[0] );
ADDRLP4 0+28
CNSTF4 1069547520
ADDRLP4 0+28
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+4
CNSTF4 1069547520
ADDRLP4 0+28+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+8
CNSTF4 1069547520
ADDRLP4 0+28+8
INDIRF4
MULF4
ASGNF4
line 318
;318:		VectorScale( ent.axis[1], 1.5, ent.axis[1] );
ADDRLP4 0+28+12
CNSTF4 1069547520
ADDRLP4 0+28+12
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+4
CNSTF4 1069547520
ADDRLP4 0+28+12+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+8
CNSTF4 1069547520
ADDRLP4 0+28+12+8
INDIRF4
MULF4
ASGNF4
line 319
;319:		VectorScale( ent.axis[2], 1.5, ent.axis[2] );
ADDRLP4 0+28+24
CNSTF4 1069547520
ADDRLP4 0+28+24
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+24+4
CNSTF4 1069547520
ADDRLP4 0+28+24+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+24+8
CNSTF4 1069547520
ADDRLP4 0+28+24+8
INDIRF4
MULF4
ASGNF4
line 320
;320:		ent.nonNormalizedAxes = qtrue;
ADDRLP4 0+64
CNSTI4 1
ASGNI4
line 324
;321:#ifdef MISSIONPACK
;322:		trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin, cgs.media.weaponHoverSound );
;323:#endif
;324:	}
LABELV $247
line 336
;325:
;326:#ifdef MISSIONPACK
;327:	if ( item->giType == IT_HOLDABLE && item->giTag == HI_KAMIKAZE ) {
;328:		VectorScale( ent.axis[0], 2, ent.axis[0] );
;329:		VectorScale( ent.axis[1], 2, ent.axis[1] );
;330:		VectorScale( ent.axis[2], 2, ent.axis[2] );
;331:		ent.nonNormalizedAxes = qtrue;
;332:	}
;333:#endif
;334:
;335:	// add to refresh list
;336:	trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 360
;337:
;338:#ifdef MISSIONPACK
;339:	if ( item->giType == IT_WEAPON && wi->barrelModel ) {
;340:		refEntity_t	barrel;
;341:
;342:		memset( &barrel, 0, sizeof( barrel ) );
;343:
;344:		barrel.hModel = wi->barrelModel;
;345:
;346:		VectorCopy( ent.lightingOrigin, barrel.lightingOrigin );
;347:		barrel.shadowPlane = ent.shadowPlane;
;348:		barrel.renderfx = ent.renderfx;
;349:
;350:		CG_PositionRotatedEntityOnTag( &barrel, &ent, wi->weaponModel, "tag_barrel" );
;351:
;352:		AxisCopy( ent.axis, barrel.axis );
;353:		barrel.nonNormalizedAxes = ent.nonNormalizedAxes;
;354:
;355:		trap_R_AddRefEntityToScene( &barrel );
;356:	}
;357:#endif
;358:
;359:	// accompanying rings / spheres for powerups
;360:	if ( !cg_simpleItems.integer )  {
ADDRGP4 cg_simpleItems+12
INDIRI4
CNSTI4 0
NEI4 $292
line 363
;361:		vec3_t spinAngles;
;362:
;363:		VectorClear( spinAngles );
ADDRLP4 196
CNSTF4 0
ASGNF4
ADDRLP4 184+8
ADDRLP4 196
INDIRF4
ASGNF4
ADDRLP4 184+4
ADDRLP4 196
INDIRF4
ASGNF4
ADDRLP4 184
ADDRLP4 196
INDIRF4
ASGNF4
line 365
;364:
;365:		if ( item->giType == IT_HEALTH || item->giType == IT_POWERUP ) {
ADDRLP4 200
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 200
INDIRI4
CNSTI4 4
EQI4 $299
ADDRLP4 200
INDIRI4
CNSTI4 5
NEI4 $297
LABELV $299
line 366
;366:			if ( ( ent.hModel = cg_items[es->modelindex].models[1] ) != 0 ) {
ADDRLP4 204
CNSTI4 24
ADDRLP4 144
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_items+4+4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0+8
ADDRLP4 204
INDIRI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 0
EQI4 $300
line 367
;367:				if ( item->giType == IT_POWERUP ) {
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
NEI4 $305
line 368
;368:					ent.origin[2] += 12;
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
CNSTF4 1094713344
ADDF4
ASGNF4
line 369
;369:					spinAngles[1] = ( cg.time & 1023 ) * 360 / -1024.0f;
ADDRLP4 184+4
CNSTI4 360
ADDRGP4 cg+107604
INDIRI4
CNSTI4 1023
BANDI4
MULI4
CVIF4 4
CNSTF4 3296722944
DIVF4
ASGNF4
line 370
;370:				}
LABELV $305
line 371
;371:				AnglesToAxis( spinAngles, ent.axis );
ADDRLP4 184
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 374
;372:				
;373:				// scale up if respawning
;374:				if ( frac != 1.0 ) {
ADDRLP4 148
INDIRF4
CNSTF4 1065353216
EQF4 $312
line 375
;375:					VectorScale( ent.axis[0], frac, ent.axis[0] );
ADDRLP4 0+28
ADDRLP4 0+28
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+4
ADDRLP4 0+28+4
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+8
ADDRLP4 0+28+8
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
line 376
;376:					VectorScale( ent.axis[1], frac, ent.axis[1] );
ADDRLP4 0+28+12
ADDRLP4 0+28+12
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+4
ADDRLP4 0+28+12+4
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+12+8
ADDRLP4 0+28+12+8
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
line 377
;377:					VectorScale( ent.axis[2], frac, ent.axis[2] );
ADDRLP4 0+28+24
ADDRLP4 0+28+24
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+24+4
ADDRLP4 0+28+24+4
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+24+8
ADDRLP4 0+28+24+8
INDIRF4
ADDRLP4 148
INDIRF4
MULF4
ASGNF4
line 378
;378:					ent.nonNormalizedAxes = qtrue;
ADDRLP4 0+64
CNSTI4 1
ASGNI4
line 379
;379:				}
LABELV $312
line 380
;380:				trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 381
;381:			}
LABELV $300
line 382
;382:		}
LABELV $297
line 383
;383:	}
LABELV $292
line 384
;384:}
LABELV $134
endproc CG_Item 208 12
proc CG_Missile 164 20
line 393
;385:
;386://============================================================================
;387:
;388:/*
;389:===============
;390:CG_Missile
;391:===============
;392:*/
;393:static void CG_Missile( centity_t *cent ) {
line 399
;394:	refEntity_t			ent;
;395:	entityState_t		*s1;
;396:	const weaponInfo_t		*weapon;
;397://	int	col;
;398:	
;399:	if ( cent->currentState.weapon == WP_RAILGUN ) {
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 7
NEI4 $358
line 400
;400:		return;
ADDRGP4 $357
JUMPV
LABELV $358
line 403
;401:	}
;402:
;403:	s1 = &cent->currentState;
ADDRLP4 144
ADDRFP4 0
INDIRP4
ASGNP4
line 404
;404:	if ( s1->weapon > WP_NUM_WEAPONS ) {
ADDRLP4 144
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 11
LEI4 $360
line 405
;405:		s1->weapon = 0;
ADDRLP4 144
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 0
ASGNI4
line 406
;406:	}
LABELV $360
line 407
;407:	weapon = &cg_weapons[s1->weapon];
ADDRLP4 140
CNSTI4 136
ADDRLP4 144
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons
ADDP4
ASGNP4
line 410
;408:
;409:	// calculate the axis
;410:	VectorCopy( s1->angles, cent->lerpAngles);
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ADDRLP4 144
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 413
;411:
;412:	// add trails
;413:	if ( weapon->missileTrailFunc ) 
ADDRLP4 140
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $362
line 414
;414:	{
line 415
;415:		weapon->missileTrailFunc( cent, weapon );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
INDIRP4
ARGP4
ADDRLP4 140
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 416
;416:	}
LABELV $362
line 435
;417:/*
;418:	if ( cent->currentState.modelindex == TEAM_RED ) {
;419:		col = 1;
;420:	}
;421:	else if ( cent->currentState.modelindex == TEAM_BLUE ) {
;422:		col = 2;
;423:	}
;424:	else {
;425:		col = 0;
;426:	}
;427:
;428:	// add dynamic light
;429:	if ( weapon->missileDlight ) {
;430:		trap_R_AddLightToScene(cent->lerpOrigin, weapon->missileDlight, 
;431:			weapon->missileDlightColor[col][0], weapon->missileDlightColor[col][1], weapon->missileDlightColor[col][2] );
;432:	}
;433:*/
;434:	// add dynamic light
;435:	if ( weapon->missileDlight ) {
ADDRLP4 140
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
CNSTF4 0
EQF4 $364
line 436
;436:		trap_R_AddLightToScene(cent->lerpOrigin, weapon->missileDlight, 
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
ARGP4
ADDRLP4 140
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ARGF4
ADDRLP4 140
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ARGF4
ADDRLP4 140
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ARGF4
ADDRLP4 140
INDIRP4
CNSTI4 104
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 438
;437:			weapon->missileDlightColor[0], weapon->missileDlightColor[1], weapon->missileDlightColor[2] );
;438:	}
LABELV $364
line 441
;439:
;440:	// add missile sound
;441:	if ( weapon->missileSound ) {
ADDRLP4 140
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 0
EQI4 $366
line 444
;442:		vec3_t	velocity;
;443:
;444:		BG_EvaluateTrajectoryDelta( &cent->currentState.pos, cg.time, velocity );
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 148
ARGP4
ADDRGP4 BG_EvaluateTrajectoryDelta
CALLV
pop
line 446
;445:
;446:		trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, velocity, weapon->missileSound );
ADDRLP4 160
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 160
INDIRP4
INDIRI4
ARGI4
ADDRLP4 160
INDIRP4
CNSTI4 704
ADDP4
ARGP4
ADDRLP4 148
ARGP4
ADDRLP4 140
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_AddLoopingSound
CALLV
pop
line 447
;447:	}
LABELV $366
line 450
;448:
;449:	// create the render entity
;450:	memset (&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 451
;451:	VectorCopy( cent->lerpOrigin, ent.origin);
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRB
ASGNB 12
line 452
;452:	VectorCopy( cent->lerpOrigin, ent.oldorigin);
ADDRLP4 0+84
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRB
ASGNB 12
line 454
;453:
;454:	if ( cent->currentState.weapon == WP_PLASMAGUN ) {
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 8
NEI4 $371
line 455
;455:		ent.reType = RT_SPRITE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 456
;456:		ent.radius = 16;
ADDRLP4 0+132
CNSTF4 1098907648
ASGNF4
line 457
;457:		ent.rotation = 0;
ADDRLP4 0+136
CNSTF4 0
ASGNF4
line 458
;458:		ent.customShader = cgs.media.plasmaBallShader;
ADDRLP4 0+112
ADDRGP4 cgs+156680+344
INDIRI4
ASGNI4
line 459
;459:		trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 460
;460:		return;
ADDRGP4 $357
JUMPV
LABELV $371
line 464
;461:	}
;462:
;463:	// flicker between two skins
;464:	ent.skinNum = cg.clientFrame & 1;
ADDRLP4 0+104
ADDRGP4 cg
INDIRI4
CNSTI4 1
BANDI4
ASGNI4
line 465
;465:	ent.hModel = weapon->missileModel;
ADDRLP4 0+8
ADDRLP4 140
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ASGNI4
line 466
;466:	ent.renderfx = weapon->missileRenderfx | RF_NOSHADOW;
ADDRLP4 0+4
ADDRLP4 140
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 477
;467:
;468:#ifdef MISSIONPACK
;469:	if ( cent->currentState.weapon == WP_PROX_LAUNCHER ) {
;470:		if (s1->generic1 == TEAM_BLUE) {
;471:			ent.hModel = cgs.media.blueProxMine;
;472:		}
;473:	}
;474:#endif
;475:
;476:	// convert direction of travel into axis
;477:	if ( VectorNormalize2( s1->pos.trDelta, ent.axis[0] ) == 0 ) {
ADDRLP4 144
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRLP4 0+28
ARGP4
ADDRLP4 148
ADDRGP4 VectorNormalize2
CALLF4
ASGNF4
ADDRLP4 148
INDIRF4
CNSTF4 0
NEF4 $381
line 478
;478:		ent.axis[0][2] = 1;
ADDRLP4 0+28+8
CNSTF4 1065353216
ASGNF4
line 479
;479:	}
LABELV $381
line 482
;480:
;481:	// spin as it moves
;482:	if ( s1->pos.trType != TR_STATIONARY ) {
ADDRLP4 144
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
EQI4 $386
line 483
;483:		RotateAroundDirection( ent.axis, cg.time / 4 );
ADDRLP4 0+28
ARGP4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 4
DIVI4
CVIF4 4
ARGF4
ADDRGP4 RotateAroundDirection
CALLV
pop
line 484
;484:	} else {
ADDRGP4 $387
JUMPV
LABELV $386
line 491
;485:#ifdef MISSIONPACK
;486:		if ( s1->weapon == WP_PROX_LAUNCHER ) {
;487:			AnglesToAxis( cent->lerpAngles, ent.axis );
;488:		}
;489:		else
;490:#endif
;491:		{
line 492
;492:			RotateAroundDirection( ent.axis, s1->time );
ADDRLP4 0+28
ARGP4
ADDRLP4 144
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 RotateAroundDirection
CALLV
pop
line 493
;493:		}
line 494
;494:	}
LABELV $387
line 497
;495:
;496:	// add to refresh list, possibly with quad glow
;497:	CG_AddRefEntityWithPowerups( &ent, s1, TEAM_FREE );
ADDRLP4 0
ARGP4
ADDRLP4 144
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 CG_AddRefEntityWithPowerups
CALLV
pop
line 498
;498:}
LABELV $357
endproc CG_Missile 164 20
proc CG_Grapple 152 16
line 507
;499:
;500:/*
;501:===============
;502:CG_Grapple
;503:
;504:This is called when the grapple is sitting up against the wall
;505:===============
;506:*/
;507:static void CG_Grapple( centity_t *cent ) {
line 512
;508:	refEntity_t			ent;
;509:	entityState_t		*s1;
;510:	const weaponInfo_t		*weapon;
;511:
;512:	s1 = &cent->currentState;
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
line 513
;513:	if ( s1->weapon > WP_NUM_WEAPONS ) {
ADDRLP4 140
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 11
LEI4 $392
line 514
;514:		s1->weapon = 0;
ADDRLP4 140
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 0
ASGNI4
line 515
;515:	}
LABELV $392
line 516
;516:	weapon = &cg_weapons[s1->weapon];
ADDRLP4 144
CNSTI4 136
ADDRLP4 140
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons
ADDP4
ASGNP4
line 519
;517:
;518:	// calculate the axis
;519:	VectorCopy( s1->angles, cent->lerpAngles);
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ADDRLP4 140
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 528
;520:
;521:#if 0 // FIXME add grapple pull sound here..?
;522:	// add missile sound
;523:	if ( weapon->missileSound ) {
;524:		trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin, weapon->missileSound );
;525:	}
;526:#endif
;527:
;528:	if (weap_enableHook.integer == 1) {
ADDRGP4 weap_enableHook+12
INDIRI4
CNSTI4 1
NEI4 $394
line 529
;529:		trap_S_AddLoopingSound(cent->currentState.number, cent->lerpOrigin, vec3_origin, cgs.media.grappleSound);
ADDRLP4 148
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 148
INDIRP4
INDIRI4
ARGI4
ADDRLP4 148
INDIRP4
CNSTI4 704
ADDP4
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRGP4 cgs+156680+600
INDIRI4
ARGI4
ADDRGP4 trap_S_AddLoopingSound
CALLV
pop
line 530
;530:	}
LABELV $394
line 533
;531:
;532:	// Will draw cable if needed
;533:	CG_GrappleTrail ( cent, weapon );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 144
INDIRP4
ARGP4
ADDRGP4 CG_GrappleTrail
CALLV
pop
line 536
;534:
;535:	// create the render entity
;536:	memset (&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 537
;537:	VectorCopy( cent->lerpOrigin, ent.origin);
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRB
ASGNB 12
line 538
;538:	VectorCopy( cent->lerpOrigin, ent.oldorigin);
ADDRLP4 0+84
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRB
ASGNB 12
line 541
;539:
;540:	// flicker between two skins
;541:	ent.skinNum = cg.clientFrame & 1;
ADDRLP4 0+104
ADDRGP4 cg
INDIRI4
CNSTI4 1
BANDI4
ASGNI4
line 542
;542:	ent.hModel = weapon->missileModel;
ADDRLP4 0+8
ADDRLP4 144
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ASGNI4
line 543
;543:	ent.renderfx = weapon->missileRenderfx | RF_NOSHADOW;
ADDRLP4 0+4
ADDRLP4 144
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 546
;544:
;545:	// convert direction of travel into axis
;546:	if ( VectorNormalize2( s1->pos.trDelta, ent.axis[0] ) == 0 ) {
ADDRLP4 140
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRLP4 0+28
ARGP4
ADDRLP4 148
ADDRGP4 VectorNormalize2
CALLF4
ASGNF4
ADDRLP4 148
INDIRF4
CNSTF4 0
NEF4 $404
line 547
;547:		ent.axis[0][2] = 1;
ADDRLP4 0+28+8
CNSTF4 1065353216
ASGNF4
line 548
;548:	}
LABELV $404
line 550
;549:
;550:	trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 551
;551:}
LABELV $391
endproc CG_Grapple 152 16
proc CG_Mover 144 12
line 558
;552:
;553:/*
;554:===============
;555:CG_Mover
;556:===============
;557:*/
;558:static void CG_Mover( centity_t *cent ) {
line 562
;559:	refEntity_t			ent;
;560:	entityState_t		*s1;
;561:
;562:	s1 = &cent->currentState;
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
line 565
;563:
;564:	// create the render entity
;565:	memset (&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 566
;566:	VectorCopy( cent->lerpOrigin, ent.origin);
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRB
ASGNB 12
line 567
;567:	VectorCopy( cent->lerpOrigin, ent.oldorigin);
ADDRLP4 0+84
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRB
ASGNB 12
line 568
;568:	AnglesToAxis( cent->lerpAngles, ent.axis );
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 570
;569:
;570:	ent.renderfx = RF_NOSHADOW;
ADDRLP4 0+4
CNSTI4 64
ASGNI4
line 573
;571:
;572:	// flicker between two skins (FIXME?)
;573:	ent.skinNum = ( cg.time >> 6 ) & 1;
ADDRLP4 0+104
ADDRGP4 cg+107604
INDIRI4
CNSTI4 6
RSHI4
CNSTI4 1
BANDI4
ASGNI4
line 576
;574:
;575:	// get the model, either as a bmodel or a modelindex
;576:	if ( s1->solid == SOLID_BMODEL ) {
ADDRLP4 140
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 16777215
NEI4 $416
line 577
;577:		ent.hModel = cgs.inlineDrawModel[s1->modelindex];
ADDRLP4 0+8
ADDRLP4 140
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+36864
ADDP4
INDIRI4
ASGNI4
line 578
;578:	} else {
ADDRGP4 $417
JUMPV
LABELV $416
line 579
;579:		ent.hModel = cgs.gameModels[s1->modelindex];
ADDRLP4 0+8
ADDRLP4 140
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+34812
ADDP4
INDIRI4
ASGNI4
line 580
;580:	}
LABELV $417
line 583
;581:
;582:	// add to refresh list
;583:	trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 586
;584:
;585:	// add the secondary model
;586:	if ( s1->modelindex2 ) {
ADDRLP4 140
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 0
EQI4 $422
line 587
;587:		ent.skinNum = 0;
ADDRLP4 0+104
CNSTI4 0
ASGNI4
line 588
;588:		ent.hModel = cgs.gameModels[s1->modelindex2];
ADDRLP4 0+8
ADDRLP4 140
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+34812
ADDP4
INDIRI4
ASGNI4
line 589
;589:		trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 590
;590:	}
LABELV $422
line 592
;591:
;592:}
LABELV $409
endproc CG_Mover 144 12
export CG_Beam
proc CG_Beam 144 12
line 601
;593:
;594:/*
;595:===============
;596:CG_Beam
;597:
;598:Also called as an event
;599:===============
;600:*/
;601:void CG_Beam( centity_t *cent ) {
line 605
;602:	refEntity_t			ent;
;603:	entityState_t		*s1;
;604:
;605:	s1 = &cent->currentState;
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
line 608
;606:
;607:	// create the render entity
;608:	memset (&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 609
;609:	VectorCopy( s1->pos.trBase, ent.origin );
ADDRLP4 0+68
ADDRLP4 140
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 610
;610:	VectorCopy( s1->origin2, ent.oldorigin );
ADDRLP4 0+84
ADDRLP4 140
INDIRP4
CNSTI4 104
ADDP4
INDIRB
ASGNB 12
line 611
;611:	AxisClear( ent.axis );
ADDRLP4 0+28
ARGP4
ADDRGP4 AxisClear
CALLV
pop
line 612
;612:	ent.reType = RT_BEAM;
ADDRLP4 0
CNSTI4 3
ASGNI4
line 614
;613:
;614:	ent.renderfx = RF_NOSHADOW;
ADDRLP4 0+4
CNSTI4 64
ASGNI4
line 617
;615:
;616:	// add to refresh list
;617:	trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 618
;618:}
LABELV $427
endproc CG_Beam 144 12
proc CG_Portal 144 12
line 626
;619:
;620:
;621:/*
;622:===============
;623:CG_Portal
;624:===============
;625:*/
;626:static void CG_Portal( centity_t *cent ) {
line 630
;627:	refEntity_t			ent;
;628:	entityState_t		*s1;
;629:
;630:	s1 = &cent->currentState;
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
line 633
;631:
;632:	// create the render entity
;633:	memset (&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 634
;634:	VectorCopy( cent->lerpOrigin, ent.origin );
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRB
ASGNB 12
line 635
;635:	VectorCopy( s1->origin2, ent.oldorigin );
ADDRLP4 0+84
ADDRLP4 140
INDIRP4
CNSTI4 104
ADDP4
INDIRB
ASGNB 12
line 636
;636:	ByteToDir( s1->eventParm, ent.axis[0] );
ADDRLP4 140
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 0+28
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 637
;637:	PerpendicularVector( ent.axis[1], ent.axis[0] );
ADDRLP4 0+28+12
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 PerpendicularVector
CALLV
pop
line 641
;638:
;639:	// negating this tends to get the directions like they want
;640:	// we really should have a camera roll value
;641:	VectorSubtract( vec3_origin, ent.axis[1], ent.axis[1] );
ADDRLP4 0+28+12
ADDRGP4 vec3_origin
INDIRF4
ADDRLP4 0+28+12
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+28+12+4
ADDRGP4 vec3_origin+4
INDIRF4
ADDRLP4 0+28+12+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+28+12+8
ADDRGP4 vec3_origin+8
INDIRF4
ADDRLP4 0+28+12+8
INDIRF4
SUBF4
ASGNF4
line 643
;642:
;643:	CrossProduct( ent.axis[0], ent.axis[1], ent.axis[2] );
ADDRLP4 0+28
ARGP4
ADDRLP4 0+28+12
ARGP4
ADDRLP4 0+28+24
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 644
;644:	ent.reType = RT_PORTALSURFACE;
ADDRLP4 0
CNSTI4 7
ASGNI4
line 645
;645:	ent.oldframe = s1->powerups;
ADDRLP4 0+96
ADDRLP4 140
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ASGNI4
line 646
;646:	ent.frame = s1->frame;		// rotation speed
ADDRLP4 0+80
ADDRLP4 140
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ASGNI4
line 647
;647:	ent.skinNum = s1->clientNum/256.0 * 360;	// roll offset
ADDRLP4 0+104
CNSTF4 1135869952
ADDRLP4 140
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1132462080
DIVF4
MULF4
CVFI4 4
ASGNI4
line 650
;648:
;649:	// add to refresh list
;650:	trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 651
;651:}
LABELV $432
endproc CG_Portal 144 12
export CG_AdjustPositionForMover
proc CG_AdjustPositionForMover 92 12
line 661
;652:
;653:
;654:/*
;655:=========================
;656:CG_AdjustPositionForMover
;657:
;658:Also called by client movement prediction code
;659:=========================
;660:*/
;661:void CG_AdjustPositionForMover( const vec3_t in, int moverNum, int fromTime, int toTime, vec3_t out ) {
line 666
;662:	centity_t	*cent;
;663:	vec3_t	oldOrigin, origin, deltaOrigin;
;664:	vec3_t	oldAngles, angles, deltaAngles;
;665:
;666:	if ( moverNum <= 0 || moverNum >= ENTITYNUM_MAX_NORMAL ) {
ADDRLP4 76
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
LEI4 $468
ADDRLP4 76
INDIRI4
CNSTI4 1022
LTI4 $466
LABELV $468
line 667
;667:		VectorCopy( in, out );
ADDRFP4 16
INDIRP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 668
;668:		return;
ADDRGP4 $465
JUMPV
LABELV $466
line 671
;669:	}
;670:
;671:	cent = &cg_entities[ moverNum ];
ADDRLP4 0
CNSTI4 728
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 672
;672:	if ( cent->currentState.eType != ET_MOVER ) {
ADDRLP4 80
CNSTI4 4
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
INDIRI4
ADDRLP4 80
INDIRI4
EQI4 $469
line 673
;673:		VectorCopy( in, out );
ADDRFP4 16
INDIRP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 674
;674:		return;
ADDRGP4 $465
JUMPV
LABELV $469
line 677
;675:	}
;676:
;677:	BG_EvaluateTrajectory( &cent->currentState.pos, fromTime, oldOrigin );
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 678
;678:	BG_EvaluateTrajectory( &cent->currentState.apos, fromTime, oldAngles );
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 40
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 680
;679:
;680:	BG_EvaluateTrajectory( &cent->currentState.pos, toTime, origin );
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 681
;681:	BG_EvaluateTrajectory( &cent->currentState.apos, toTime, angles );
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 52
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 683
;682:
;683:	VectorSubtract( origin, oldOrigin, deltaOrigin );
ADDRLP4 4
ADDRLP4 28
INDIRF4
ADDRLP4 16
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 28+4
INDIRF4
ADDRLP4 16+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 28+8
INDIRF4
ADDRLP4 16+8
INDIRF4
SUBF4
ASGNF4
line 684
;684:	VectorSubtract( angles, oldAngles, deltaAngles );
ADDRLP4 64
ADDRLP4 52
INDIRF4
ADDRLP4 40
INDIRF4
SUBF4
ASGNF4
ADDRLP4 64+4
ADDRLP4 52+4
INDIRF4
ADDRLP4 40+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 64+8
ADDRLP4 52+8
INDIRF4
ADDRLP4 40+8
INDIRF4
SUBF4
ASGNF4
line 686
;685:
;686:	VectorAdd( in, deltaOrigin, out );
ADDRFP4 16
INDIRP4
ADDRFP4 0
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84
CNSTI4 4
ASGNI4
ADDRFP4 16
INDIRP4
ADDRLP4 84
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 84
INDIRI4
ADDP4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 88
CNSTI4 8
ASGNI4
ADDRFP4 16
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDF4
ASGNF4
line 689
;687:
;688:	// FIXME: origin change when on a rotating object
;689:}
LABELV $465
endproc CG_AdjustPositionForMover 92 12
proc CG_InterpolateEntityPosition 44 12
line 697
;690:
;691:
;692:/*
;693:=============================
;694:CG_InterpolateEntityPosition
;695:=============================
;696:*/
;697:static void CG_InterpolateEntityPosition( centity_t *cent ) {
line 703
;698:	vec3_t		current, next;
;699:	float		f;
;700:
;701:	// it would be an internal error to find an entity that interpolates without
;702:	// a snapshot ahead of the current one
;703:	if ( cg.nextSnap == NULL ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $486
line 704
;704:		CG_Error( "CG_InterpoateEntityPosition: cg.nextSnap == NULL" );
ADDRGP4 $489
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 705
;705:	}
LABELV $486
line 707
;706:
;707:	f = cg.frameInterpolation;
ADDRLP4 24
ADDRGP4 cg+107588
INDIRF4
ASGNF4
line 711
;708:
;709:	// this will linearize a sine or parabolic curve, but it is important
;710:	// to not extrapolate player positions if more recent data is available
;711:	BG_EvaluateTrajectory( &cent->currentState.pos, cg.snap->serverTime, current );
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 712
;712:	BG_EvaluateTrajectory( &cent->nextState.pos, cg.nextSnap->serverTime, next );
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
ARGP4
ADDRGP4 cg+40
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 714
;713:
;714:	cent->lerpOrigin[0] = current[0] + f * ( next[0] - current[0] );
ADDRLP4 28
ADDRLP4 0
INDIRF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
ADDRLP4 28
INDIRF4
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDRLP4 28
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 715
;715:	cent->lerpOrigin[1] = current[1] + f * ( next[1] - current[1] );
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRLP4 0+4
INDIRF4
ADDRLP4 24
INDIRF4
ADDRLP4 12+4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 716
;716:	cent->lerpOrigin[2] = current[2] + f * ( next[2] - current[2] );
ADDRFP4 0
INDIRP4
CNSTI4 712
ADDP4
ADDRLP4 0+8
INDIRF4
ADDRLP4 24
INDIRF4
ADDRLP4 12+8
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 718
;717:
;718:	BG_EvaluateTrajectory( &cent->currentState.apos, cg.snap->serverTime, current );
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 719
;719:	BG_EvaluateTrajectory( &cent->nextState.apos, cg.nextSnap->serverTime, next );
ADDRFP4 0
INDIRP4
CNSTI4 256
ADDP4
ARGP4
ADDRGP4 cg+40
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 721
;720:
;721:	cent->lerpAngles[0] = LerpAngle( current[0], next[0], f );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 32
ADDRGP4 LerpAngle
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ADDRLP4 32
INDIRF4
ASGNF4
line 722
;722:	cent->lerpAngles[1] = LerpAngle( current[1], next[1], f );
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 LerpAngle
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 720
ADDP4
ADDRLP4 36
INDIRF4
ASGNF4
line 723
;723:	cent->lerpAngles[2] = LerpAngle( current[2], next[2], f );
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 12+8
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 LerpAngle
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 724
ADDP4
ADDRLP4 40
INDIRF4
ASGNF4
line 725
;724:
;725:}
LABELV $485
endproc CG_InterpolateEntityPosition 44 12
proc CG_CalcEntityLerpPositions 120 28
line 733
;726:
;727:/*
;728:===============
;729:CG_CalcEntityLerpPositions
;730:
;731:===============
;732:*/
;733:static void CG_CalcEntityLerpPositions( centity_t *cent ) {
line 736
;734://unlagged - projectile nudge
;735:	// this will be set to how far forward projectiles will be extrapolated
;736:	int timeshift = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 745
;737://unlagged - projectile nudge
;738:
;739://unlagged - smooth clients #2
;740:	// this is done server-side now - cg_smoothClients is undefined
;741:	// players will always be TR_INTERPOLATE
;742:
;743:	// if this player does not want to see extrapolated players
;744:	//if ( !g_unlaggedSmoothClients.integer && !cg_smoothClients.integer ) {
;745:	if ( !cg_smoothClients.integer ) {
ADDRGP4 cg_smoothClients+12
INDIRI4
CNSTI4 0
NEI4 $506
line 747
;746:		// make sure the clients use TR_INTERPOLATE
;747:		if ( cent->currentState.number < MAX_CLIENTS ) {
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 64
GEI4 $509
line 748
;748:			cent->currentState.pos.trType = TR_INTERPOLATE;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 1
ASGNI4
line 749
;749:			cent->nextState.pos.trType = TR_INTERPOLATE;
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
CNSTI4 1
ASGNI4
line 750
;750:		}
LABELV $509
line 751
;751:	}
LABELV $506
line 755
;752:
;753://unlagged - smooth clients #2
;754:
;755:	if ( cent->interpolate && cent->currentState.pos.trType == TR_INTERPOLATE ) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
EQI4 $511
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
NEI4 $511
line 756
;756:		CG_InterpolateEntityPosition( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_InterpolateEntityPosition
CALLV
pop
line 757
;757:		return;
ADDRGP4 $505
JUMPV
LABELV $511
line 762
;758:	}
;759:
;760:	// first see if we can interpolate between two snaps for
;761:	// linear extrapolated clients
;762:	if ( cent->interpolate && cent->currentState.pos.trType == TR_LINEAR_STOP &&
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
EQI4 $513
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 3
NEI4 $513
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 64
GEI4 $513
line 763
;763:			cent->currentState.number < MAX_CLIENTS) {
line 764
;764:		CG_InterpolateEntityPosition( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_InterpolateEntityPosition
CALLV
pop
line 765
;765:		return;
ADDRGP4 $505
JUMPV
LABELV $513
line 772
;766:	}
;767:
;768://unlagged - timenudge extrapolation
;769:	// interpolating failed (probably no nextSnap), so extrapolate
;770:	// this can also happen if the teleport bit is flipped, but that
;771:	// won't be noticeable
;772:	if ( cent->currentState.number < MAX_CLIENTS &&
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 64
GEI4 $515
ADDRLP4 12
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
EQI4 $515
line 773
;773:			cent->currentState.clientNum != cg.predictedPlayerState.clientNum ) {
line 774
;774:		cent->currentState.pos.trType = TR_LINEAR_STOP;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 3
ASGNI4
line 775
;775:		cent->currentState.pos.trTime = cg.snap->serverTime;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 776
;776:		cent->currentState.pos.trDuration = 1000 / sv_fps.integer;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
CNSTI4 1000
ADDRGP4 sv_fps+12
INDIRI4
DIVI4
ASGNI4
line 777
;777:	}
LABELV $515
line 782
;778://unlagged - timenudge extrapolation
;779:
;780://unlagged - projectile nudge
;781:	// if it's a missile but not a grappling hook
;782:	if ( cent->currentState.eType == ET_MISSILE && cent->currentState.weapon != WP_GRAPPLING_HOOK ) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $521
ADDRLP4 16
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 10
EQI4 $521
line 784
;783:		// if it's one of ours
;784:		if ( cent->currentState.otherEntityNum == cg.clientNum ) {
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ADDRGP4 cg+4
INDIRI4
NEI4 $523
line 788
;785:			// extrapolate one server frame's worth - this will correct for tiny
;786:			// visual inconsistencies introduced by backward-reconciling all players
;787:			// one server frame before running projectiles
;788:			timeshift = 1000 / sv_fps.integer;
ADDRLP4 0
CNSTI4 1000
ADDRGP4 sv_fps+12
INDIRI4
DIVI4
ASGNI4
line 789
;789:		}
ADDRGP4 $524
JUMPV
LABELV $523
line 791
;790:		// if it's not, and it's not a grenade launcher
;791:		else if ( cent->currentState.weapon != WP_GRENADE_LAUNCHER ) {
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 4
EQI4 $527
line 793
;792:			// extrapolate based on cg_projectileNudge
;793:			timeshift = cg_projectileNudge.integer + 1000 / sv_fps.integer;
ADDRLP4 0
ADDRGP4 cg_projectileNudge+12
INDIRI4
CNSTI4 1000
ADDRGP4 sv_fps+12
INDIRI4
DIVI4
ADDI4
ASGNI4
line 794
;794:		}
LABELV $527
LABELV $524
line 795
;795:	}
LABELV $521
line 800
;796:
;797:	// just use the current frame and evaluate as best we can
;798://	BG_EvaluateTrajectory( &cent->currentState.pos, cg.time, cent->lerpOrigin );
;799://	BG_EvaluateTrajectory( &cent->currentState.apos, cg.time, cent->lerpAngles );
;800:	BG_EvaluateTrajectory( &cent->currentState.pos, cg.time + timeshift, cent->lerpOrigin );
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ARGI4
ADDRLP4 20
INDIRP4
CNSTI4 704
ADDP4
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 801
;801:	BG_EvaluateTrajectory( &cent->currentState.apos, cg.time + timeshift, cent->lerpAngles );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ARGI4
ADDRLP4 24
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 804
;802:
;803:	// if there's a time shift
;804:	if ( timeshift != 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $533
line 808
;805:		trace_t tr;
;806:		vec3_t lastOrigin;
;807:
;808:		BG_EvaluateTrajectory( &cent->currentState.pos, cg.time, lastOrigin );
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 810
;809:
;810:		CG_Trace( &tr, lastOrigin, vec3_origin, vec3_origin, cent->lerpOrigin, cent->currentState.number, MASK_SHOT );
ADDRLP4 40
ARGP4
ADDRLP4 28
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
ADDRLP4 100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 704
ADDP4
ARGP4
ADDRLP4 100
INDIRP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 813
;811:
;812:		// don't let the projectile go through the floor
;813:		if ( tr.fraction < 1.0f ) {
ADDRLP4 40+8
INDIRF4
CNSTF4 1065353216
GEF4 $536
line 814
;814:			cent->lerpOrigin[0] = lastOrigin[0] + tr.fraction * ( cent->lerpOrigin[0] - lastOrigin[0] );
ADDRLP4 104
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
ASGNP4
ADDRLP4 108
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 104
INDIRP4
ADDRLP4 108
INDIRF4
ADDRLP4 40+8
INDIRF4
ADDRLP4 104
INDIRP4
INDIRF4
ADDRLP4 108
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 815
;815:			cent->lerpOrigin[1] = lastOrigin[1] + tr.fraction * ( cent->lerpOrigin[1] - lastOrigin[1] );
ADDRLP4 112
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 28+4
INDIRF4
ADDRLP4 40+8
INDIRF4
ADDRLP4 112
INDIRP4
INDIRF4
ADDRLP4 28+4
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 816
;816:			cent->lerpOrigin[2] = lastOrigin[2] + tr.fraction * ( cent->lerpOrigin[2] - lastOrigin[2] );
ADDRLP4 116
ADDRFP4 0
INDIRP4
CNSTI4 712
ADDP4
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 28+8
INDIRF4
ADDRLP4 40+8
INDIRF4
ADDRLP4 116
INDIRP4
INDIRF4
ADDRLP4 28+8
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 817
;817:		}
LABELV $536
line 818
;818:	}
LABELV $533
line 824
;819://unlagged - projectile nudge
;820:
;821:
;822:	// adjust for riding a mover if it wasn't rolled into the predicted
;823:	// player state
;824:	if ( cent != &cg.predictedPlayerEntity ) {
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 cg+108104
CVPU4 4
EQU4 $546
line 825
;825:		CG_AdjustPositionForMover( cent->lerpOrigin, cent->currentState.groundEntityNum, 
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
ADDRLP4 28
INDIRP4
CNSTI4 704
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 32
INDIRP4
ARGP4
ADDRGP4 CG_AdjustPositionForMover
CALLV
pop
line 827
;826:		cg.snap->serverTime, cg.time, cent->lerpOrigin );
;827:	}
LABELV $546
line 828
;828:}
LABELV $505
endproc CG_CalcEntityLerpPositions 120 28
proc CG_TeamBase 140 12
line 835
;829:
;830:/*
;831:===============
;832:CG_TeamBase
;833:===============
;834:*/
;835:static void CG_TeamBase( centity_t *cent ) {
line 844
;836:	refEntity_t model;
;837:#ifdef MISSIONPACK
;838:	vec3_t angles;
;839:	int t, h;
;840:	float c;
;841:
;842:	if ( cgs.gametype == GT_CTF || cgs.gametype == GT_1FCTF ) {
;843:#else
;844:	if ( cgs.gametype == GT_CTF) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
NEI4 $552
line 847
;845:#endif
;846:		// show the flag base
;847:		memset(&model, 0, sizeof(model));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 848
;848:		model.reType = RT_MODEL;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 849
;849:		VectorCopy( cent->lerpOrigin, model.lightingOrigin );
ADDRLP4 0+12
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRB
ASGNB 12
line 850
;850:		VectorCopy( cent->lerpOrigin, model.origin );
ADDRLP4 0+68
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRB
ASGNB 12
line 851
;851:		AnglesToAxis( cent->currentState.angles, model.axis );
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 852
;852:		if ( cent->currentState.modelindex == TEAM_RED ) {
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 1
NEI4 $558
line 853
;853:			model.hModel = cgs.media.redFlagBaseModel;
ADDRLP4 0+8
ADDRGP4 cgs+156680+152
INDIRI4
ASGNI4
line 854
;854:		}
ADDRGP4 $559
JUMPV
LABELV $558
line 855
;855:		else if ( cent->currentState.modelindex == TEAM_BLUE ) {
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 2
NEI4 $563
line 856
;856:			model.hModel = cgs.media.blueFlagBaseModel;
ADDRLP4 0+8
ADDRGP4 cgs+156680+156
INDIRI4
ASGNI4
line 857
;857:		}
ADDRGP4 $564
JUMPV
LABELV $563
line 858
;858:		else {
line 859
;859:			model.hModel = cgs.media.neutralFlagBaseModel;
ADDRLP4 0+8
ADDRGP4 cgs+156680+160
INDIRI4
ASGNI4
line 860
;860:		}
LABELV $564
LABELV $559
line 861
;861:		trap_R_AddRefEntityToScene( &model );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 862
;862:	}
LABELV $552
line 981
;863:#ifdef MISSIONPACK
;864:	else if ( cgs.gametype == GT_OBELISK ) {
;865:		// show the obelisk
;866:		memset(&model, 0, sizeof(model));
;867:		model.reType = RT_MODEL;
;868:		VectorCopy( cent->lerpOrigin, model.lightingOrigin );
;869:		VectorCopy( cent->lerpOrigin, model.origin );
;870:		AnglesToAxis( cent->currentState.angles, model.axis );
;871:
;872:		model.hModel = cgs.media.overloadBaseModel;
;873:		trap_R_AddRefEntityToScene( &model );
;874:		// if hit
;875:		if ( cent->currentState.frame == 1) {
;876:			// show hit model
;877:			// modelindex2 is the health value of the obelisk
;878:			c = cent->currentState.modelindex2;
;879:			model.shaderRGBA[0] = 0xff;
;880:			model.shaderRGBA[1] = c;
;881:			model.shaderRGBA[2] = c;
;882:			model.shaderRGBA[3] = 0xff;
;883:			//
;884:			model.hModel = cgs.media.overloadEnergyModel;
;885:			trap_R_AddRefEntityToScene( &model );
;886:		}
;887:		// if respawning
;888:		if ( cent->currentState.frame == 2) {
;889:			if ( !cent->miscTime ) {
;890:				cent->miscTime = cg.time;
;891:			}
;892:			t = cg.time - cent->miscTime;
;893:			h = (cg_obeliskRespawnDelay.integer - 5) * 1000;
;894:			//
;895:			if (t > h) {
;896:				c = (float) (t - h) / h;
;897:				if (c > 1)
;898:					c = 1;
;899:			}
;900:			else {
;901:				c = 0;
;902:			}
;903:			// show the lights
;904:			AnglesToAxis( cent->currentState.angles, model.axis );
;905:			//
;906:			model.shaderRGBA[0] = c * 0xff;
;907:			model.shaderRGBA[1] = c * 0xff;
;908:			model.shaderRGBA[2] = c * 0xff;
;909:			model.shaderRGBA[3] = c * 0xff;
;910:
;911:			model.hModel = cgs.media.overloadLightsModel;
;912:			trap_R_AddRefEntityToScene( &model );
;913:			// show the target
;914:			if (t > h) {
;915:				if ( !cent->muzzleFlashTime ) {
;916:					trap_S_StartSound (cent->lerpOrigin, ENTITYNUM_NONE, CHAN_BODY,  cgs.media.obeliskRespawnSound);
;917:					cent->muzzleFlashTime = 1;
;918:				}
;919:				VectorCopy(cent->currentState.angles, angles);
;920:				angles[YAW] += (float) 16 * acos(1-c) * 180 / M_PI;
;921:				AnglesToAxis( angles, model.axis );
;922:
;923:				VectorScale( model.axis[0], c, model.axis[0]);
;924:				VectorScale( model.axis[1], c, model.axis[1]);
;925:				VectorScale( model.axis[2], c, model.axis[2]);
;926:
;927:				model.shaderRGBA[0] = 0xff;
;928:				model.shaderRGBA[1] = 0xff;
;929:				model.shaderRGBA[2] = 0xff;
;930:				model.shaderRGBA[3] = 0xff;
;931:				//
;932:				model.origin[2] += 56;
;933:				model.hModel = cgs.media.overloadTargetModel;
;934:				trap_R_AddRefEntityToScene( &model );
;935:			}
;936:			else {
;937:				//FIXME: show animated smoke
;938:			}
;939:		}
;940:		else {
;941:			cent->miscTime = 0;
;942:			cent->muzzleFlashTime = 0;
;943:			// modelindex2 is the health value of the obelisk
;944:			c = cent->currentState.modelindex2;
;945:			model.shaderRGBA[0] = 0xff;
;946:			model.shaderRGBA[1] = c;
;947:			model.shaderRGBA[2] = c;
;948:			model.shaderRGBA[3] = 0xff;
;949:			// show the lights
;950:			model.hModel = cgs.media.overloadLightsModel;
;951:			trap_R_AddRefEntityToScene( &model );
;952:			// show the target
;953:			model.origin[2] += 56;
;954:			model.hModel = cgs.media.overloadTargetModel;
;955:			trap_R_AddRefEntityToScene( &model );
;956:		}
;957:	}
;958:	else if ( cgs.gametype == GT_HARVESTER ) {
;959:		// show harvester model
;960:		memset(&model, 0, sizeof(model));
;961:		model.reType = RT_MODEL;
;962:		VectorCopy( cent->lerpOrigin, model.lightingOrigin );
;963:		VectorCopy( cent->lerpOrigin, model.origin );
;964:		AnglesToAxis( cent->currentState.angles, model.axis );
;965:
;966:		if ( cent->currentState.modelindex == TEAM_RED ) {
;967:			model.hModel = cgs.media.harvesterModel;
;968:			model.customSkin = cgs.media.harvesterRedSkin;
;969:		}
;970:		else if ( cent->currentState.modelindex == TEAM_BLUE ) {
;971:			model.hModel = cgs.media.harvesterModel;
;972:			model.customSkin = cgs.media.harvesterBlueSkin;
;973:		}
;974:		else {
;975:			model.hModel = cgs.media.harvesterNeutralModel;
;976:			model.customSkin = 0;
;977:		}
;978:		trap_R_AddRefEntityToScene( &model );
;979:	}
;980:#endif
;981:}
LABELV $551
endproc CG_TeamBase 140 12
proc CG_AddCEntity 8 8
line 989
;982:
;983:/*
;984:===============
;985:CG_AddCEntity
;986:
;987:===============
;988:*/
;989:static void CG_AddCEntity( centity_t *cent ) {
line 991
;990:	// event-only entities will have been dealt with already
;991:	if ( cent->currentState.eType >= ET_EVENTS ) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
LTI4 $572
line 992
;992:		return;
ADDRGP4 $571
JUMPV
LABELV $572
line 996
;993:	}
;994:
;995:	// calculate the current origin
;996:	CG_CalcEntityLerpPositions( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_CalcEntityLerpPositions
CALLV
pop
line 999
;997:
;998:	// add automatic effects
;999:	CG_EntityEffects( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_EntityEffects
CALLV
pop
line 1001
;1000:
;1001:	switch ( cent->currentState.eType ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $574
ADDRLP4 0
INDIRI4
CNSTI4 12
GTI4 $574
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $589
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $589
address $579
address $580
address $581
address $582
address $583
address $584
address $585
address $586
address $575
address $575
address $575
address $587
address $588
code
LABELV $574
line 1003
;1002:	default:
;1003:		CG_Error( "Bad entity type: %i\n", cent->currentState.eType );
ADDRGP4 $577
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 1004
;1004:		break;
ADDRGP4 $575
JUMPV
line 1008
;1005:	case ET_INVISIBLE:
;1006:	case ET_PUSH_TRIGGER:
;1007:	case ET_TELEPORT_TRIGGER:
;1008:		break;
LABELV $579
line 1010
;1009:	case ET_GENERAL:
;1010:		CG_General( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_General
CALLV
pop
line 1011
;1011:		break;
ADDRGP4 $575
JUMPV
LABELV $580
line 1013
;1012:	case ET_PLAYER:
;1013:		CG_Player( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Player
CALLV
pop
line 1014
;1014:		break;
ADDRGP4 $575
JUMPV
LABELV $581
line 1016
;1015:	case ET_ITEM:
;1016:		CG_Item( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Item
CALLV
pop
line 1017
;1017:		break;
ADDRGP4 $575
JUMPV
LABELV $582
line 1019
;1018:	case ET_MISSILE:
;1019:		CG_Missile( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Missile
CALLV
pop
line 1020
;1020:		break;
ADDRGP4 $575
JUMPV
LABELV $583
line 1022
;1021:	case ET_MOVER:
;1022:		CG_Mover( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Mover
CALLV
pop
line 1023
;1023:		break;
ADDRGP4 $575
JUMPV
LABELV $584
line 1025
;1024:	case ET_BEAM:
;1025:		CG_Beam( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Beam
CALLV
pop
line 1026
;1026:		break;
ADDRGP4 $575
JUMPV
LABELV $585
line 1028
;1027:	case ET_PORTAL:
;1028:		CG_Portal( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Portal
CALLV
pop
line 1029
;1029:		break;
ADDRGP4 $575
JUMPV
LABELV $586
line 1031
;1030:	case ET_SPEAKER:
;1031:		CG_Speaker( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Speaker
CALLV
pop
line 1032
;1032:		break;
ADDRGP4 $575
JUMPV
LABELV $587
line 1034
;1033:	case ET_GRAPPLE:
;1034:		CG_Grapple( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Grapple
CALLV
pop
line 1035
;1035:		break;
ADDRGP4 $575
JUMPV
LABELV $588
line 1037
;1036:	case ET_TEAM:
;1037:		CG_TeamBase( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_TeamBase
CALLV
pop
line 1038
;1038:		break;
LABELV $575
line 1040
;1039:	}
;1040:}
LABELV $571
endproc CG_AddCEntity 8 8
export CG_AddPacketEntities
proc CG_AddPacketEntities 20 12
line 1048
;1041:
;1042:/*
;1043:===============
;1044:CG_AddPacketEntities
;1045:
;1046:===============
;1047:*/
;1048:void CG_AddPacketEntities( void ) {
line 1054
;1049:	int					num;
;1050:	centity_t			*cent;
;1051:	playerState_t		*ps;
;1052:
;1053:	// set cg.frameInterpolation
;1054:	if ( cg.nextSnap ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $591
line 1057
;1055:		int		delta;
;1056:
;1057:		delta = (cg.nextSnap->serverTime - cg.snap->serverTime);
ADDRLP4 16
CNSTI4 8
ASGNI4
ADDRLP4 12
ADDRGP4 cg+40
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
SUBI4
ASGNI4
line 1058
;1058:		if ( delta == 0 ) {
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $596
line 1059
;1059:			cg.frameInterpolation = 0;
ADDRGP4 cg+107588
CNSTF4 0
ASGNF4
line 1060
;1060:		} else {
ADDRGP4 $592
JUMPV
LABELV $596
line 1061
;1061:			cg.frameInterpolation = (float)( cg.time - cg.snap->serverTime ) / delta;
ADDRGP4 cg+107588
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 12
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 1062
;1062:		}
line 1063
;1063:	} else {
ADDRGP4 $592
JUMPV
LABELV $591
line 1064
;1064:		cg.frameInterpolation = 0;	// actually, it should never be used, because 
ADDRGP4 cg+107588
CNSTF4 0
ASGNF4
line 1066
;1065:									// no entities should be marked as interpolating
;1066:	}
LABELV $592
line 1069
;1067:
;1068:	// the auto-rotating items will all have the same axis
;1069:	if ( !(cg_itemFX.integer & 2) ) {
ADDRGP4 cg_itemFX+12
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $603
line 1070
;1070:		cg.autoAngles[0] = 0;
ADDRGP4 cg+108952
CNSTF4 0
ASGNF4
line 1071
;1071:		cg.autoAngles[1] = 0;
ADDRGP4 cg+108952+4
CNSTF4 0
ASGNF4
line 1072
;1072:		cg.autoAngles[2] = 0;
ADDRGP4 cg+108952+8
CNSTF4 0
ASGNF4
line 1074
;1073:
;1074:		cg.autoAnglesFast[0] = 0;
ADDRGP4 cg+109000
CNSTF4 0
ASGNF4
line 1075
;1075:		cg.autoAnglesFast[1] = 0;
ADDRGP4 cg+109000+4
CNSTF4 0
ASGNF4
line 1076
;1076:		cg.autoAnglesFast[2] = 0;
ADDRGP4 cg+109000+8
CNSTF4 0
ASGNF4
line 1077
;1077:	} else {
ADDRGP4 $604
JUMPV
LABELV $603
line 1078
;1078:		cg.autoAngles[0] = 0;
ADDRGP4 cg+108952
CNSTF4 0
ASGNF4
line 1079
;1079:		cg.autoAngles[1] = ( cg.time & 2047 ) * 360 / 2048.0;
ADDRGP4 cg+108952+4
CNSTI4 360
ADDRGP4 cg+107604
INDIRI4
CNSTI4 2047
BANDI4
MULI4
CVIF4 4
CNSTF4 1157627904
DIVF4
ASGNF4
line 1080
;1080:		cg.autoAngles[2] = 0;
ADDRGP4 cg+108952+8
CNSTF4 0
ASGNF4
line 1082
;1081:
;1082:		cg.autoAnglesFast[0] = 0;
ADDRGP4 cg+109000
CNSTF4 0
ASGNF4
line 1083
;1083:		cg.autoAnglesFast[1] = ( cg.time & 1023 ) * 360 / 1024.0f;
ADDRGP4 cg+109000+4
CNSTI4 360
ADDRGP4 cg+107604
INDIRI4
CNSTI4 1023
BANDI4
MULI4
CVIF4 4
CNSTF4 1149239296
DIVF4
ASGNF4
line 1084
;1084:		cg.autoAnglesFast[2] = 0;
ADDRGP4 cg+109000+8
CNSTF4 0
ASGNF4
line 1085
;1085:	}
LABELV $604
line 1087
;1086:
;1087:	AnglesToAxis( cg.autoAngles, cg.autoAxis );
ADDRGP4 cg+108952
ARGP4
ADDRGP4 cg+108964
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1088
;1088:	AnglesToAxis( cg.autoAnglesFast, cg.autoAxisFast );
ADDRGP4 cg+109000
ARGP4
ADDRGP4 cg+109012
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1091
;1089:
;1090:	// generate and add the entity from the playerstate
;1091:	ps = &cg.predictedPlayerState;
ADDRLP4 8
ADDRGP4 cg+107636
ASGNP4
line 1092
;1092:	BG_PlayerStateToEntityState( ps, &cg.predictedPlayerEntity.currentState, qfalse );
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 cg+108104
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 1093
;1093:	CG_AddCEntity( &cg.predictedPlayerEntity );
ADDRGP4 cg+108104
ARGP4
ADDRGP4 CG_AddCEntity
CALLV
pop
line 1096
;1094:
;1095:	// lerp the non-predicted value for lightning gun origins
;1096:	CG_CalcEntityLerpPositions( &cg_entities[ cg.snap->ps.clientNum ] );
CNSTI4 728
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ARGP4
ADDRGP4 CG_CalcEntityLerpPositions
CALLV
pop
line 1099
;1097:
;1098://unlagged - early transitioning
;1099:	if ( cg.nextSnap ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $636
line 1102
;1100:		// pre-add some of the entities sent over by the server
;1101:		// we have data for them and they don't need to interpolate
;1102:		for ( num = 0 ; num < cg.nextSnap->numEntities ; num++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $642
JUMPV
LABELV $639
line 1103
;1103:			cent = &cg_entities[ cg.nextSnap->entities[ num ].number ];
ADDRLP4 0
CNSTI4 728
CNSTI4 208
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cg+40
INDIRP4
CNSTI4 516
ADDP4
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 1104
;1104:			if ( cent->nextState.eType == ET_MISSILE || cent->nextState.eType == ET_GENERAL ) {
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 3
EQI4 $647
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $645
LABELV $647
line 1106
;1105:				// transition it immediately and add it
;1106:				CG_TransitionEntity( cent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_TransitionEntity
CALLV
pop
line 1107
;1107:				cent->interpolate = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 416
ADDP4
CNSTI4 1
ASGNI4
line 1108
;1108:				CG_AddCEntity( cent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddCEntity
CALLV
pop
line 1109
;1109:			}
LABELV $645
line 1110
;1110:		}
LABELV $640
line 1102
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $642
ADDRLP4 4
INDIRI4
ADDRGP4 cg+40
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
LTI4 $639
line 1111
;1111:	}
LABELV $636
line 1115
;1112://unlagged - early transitioning
;1113:
;1114:	// add each entity sent over by the server
;1115:	for ( num = 0 ; num < cg.snap->numEntities ; num++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $651
JUMPV
LABELV $648
line 1116
;1116:		cent = &cg_entities[ cg.snap->entities[ num ].number ];
ADDRLP4 0
CNSTI4 728
CNSTI4 208
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 516
ADDP4
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 1121
;1117:		// only accept events from myself for now.
;1118:		//if (!AllowEntityInteraction(cent))
;1119:		//	continue;
;1120://unlagged - early transitioning
;1121:		if ( !cg.nextSnap || cent->nextState.eType != ET_MISSILE && cent->nextState.eType != ET_GENERAL ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $657
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 3
EQI4 $654
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $654
LABELV $657
line 1123
;1122://unlagged - early transitioning
;1123:			CG_AddCEntity( cent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddCEntity
CALLV
pop
line 1124
;1124:		}
LABELV $654
line 1125
;1125:	}
LABELV $649
line 1115
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $651
ADDRLP4 4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
LTI4 $648
line 1126
;1126:}
LABELV $590
endproc CG_AddPacketEntities 20 12
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
import CG_CheckChangedPredictableEvents
import CG_TransitionPlayerState
import CG_Respawn
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
LABELV $577
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $489
byte 1 67
byte 1 71
byte 1 95
byte 1 73
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 112
byte 1 111
byte 1 97
byte 1 116
byte 1 101
byte 1 69
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 80
byte 1 111
byte 1 115
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 58
byte 1 32
byte 1 99
byte 1 103
byte 1 46
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 83
byte 1 110
byte 1 97
byte 1 112
byte 1 32
byte 1 61
byte 1 61
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 0
align 1
LABELV $137
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 105
byte 1 110
byte 1 100
byte 1 101
byte 1 120
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 0
