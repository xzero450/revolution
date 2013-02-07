export CG_InitLocalEntities
code
proc CG_InitLocalEntities 12 12
file "../cg_localents.c"
line 21
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:
;4:// cg_localents.c -- every frame, generate renderer commands for locally
;5:// processed entities, like smoke puffs, gibs, shells, etc.
;6:
;7:#include "cg_local.h"
;8:
;9:#define	MAX_LOCAL_ENTITIES	512
;10:localEntity_t	cg_localEntities[MAX_LOCAL_ENTITIES];
;11:localEntity_t	cg_activeLocalEntities;		// double linked list
;12:localEntity_t	*cg_freeLocalEntities;		// single linked list
;13:
;14:/*
;15:===================
;16:CG_InitLocalEntities
;17:
;18:This is called at startup and for tournement restarts
;19:===================
;20:*/
;21:void	CG_InitLocalEntities( void ) {
line 24
;22:	int		i;
;23:
;24:	memset( cg_localEntities, 0, sizeof( cg_localEntities ) );
ADDRGP4 cg_localEntities
ARGP4
CNSTI4 0
ARGI4
CNSTI4 149504
ARGI4
ADDRGP4 memset
CALLP4
pop
line 25
;25:	cg_activeLocalEntities.next = &cg_activeLocalEntities;
ADDRGP4 cg_activeLocalEntities+4
ADDRGP4 cg_activeLocalEntities
ASGNP4
line 26
;26:	cg_activeLocalEntities.prev = &cg_activeLocalEntities;
ADDRLP4 4
ADDRGP4 cg_activeLocalEntities
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
ASGNP4
line 27
;27:	cg_freeLocalEntities = cg_localEntities;
ADDRGP4 cg_freeLocalEntities
ADDRGP4 cg_localEntities
ASGNP4
line 28
;28:	for ( i = 0 ; i < MAX_LOCAL_ENTITIES - 1 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $79
line 29
;29:		cg_localEntities[i].next = &cg_localEntities[i+1];
ADDRLP4 8
CNSTI4 292
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 8
INDIRI4
ADDRGP4 cg_localEntities+4
ADDP4
ADDRLP4 8
INDIRI4
ADDRGP4 cg_localEntities+292
ADDP4
ASGNP4
line 30
;30:	}
LABELV $80
line 28
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 511
LTI4 $79
line 31
;31:}
LABELV $77
endproc CG_InitLocalEntities 12 12
export CG_FreeLocalEntity
proc CG_FreeLocalEntity 12 4
line 39
;32:
;33:
;34:/*
;35:==================
;36:CG_FreeLocalEntity
;37:==================
;38:*/
;39:void CG_FreeLocalEntity( localEntity_t *le ) {
line 40
;40:	if ( !le->prev ) {
ADDRFP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $86
line 41
;41:		CG_Error( "CG_FreeLocalEntity: not active" );
ADDRGP4 $88
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 42
;42:	}
LABELV $86
line 45
;43:
;44:	// remove from the doubly linked active list
;45:	le->prev->next = le->next;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTI4 4
ASGNI4
ADDRLP4 0
INDIRP4
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRP4
ASGNP4
line 46
;46:	le->next->prev = le->prev;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ADDRLP4 8
INDIRP4
INDIRP4
ASGNP4
line 49
;47:
;48:	// the free list is only singly linked
;49:	le->next = cg_freeLocalEntities;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg_freeLocalEntities
INDIRP4
ASGNP4
line 50
;50:	cg_freeLocalEntities = le;
ADDRGP4 cg_freeLocalEntities
ADDRFP4 0
INDIRP4
ASGNP4
line 51
;51:}
LABELV $85
endproc CG_FreeLocalEntity 12 4
export CG_AllocLocalEntity
proc CG_AllocLocalEntity 8 12
line 60
;52:
;53:/*
;54:===================
;55:CG_AllocLocalEntity
;56:
;57:Will allways succeed, even if it requires freeing an old active entity
;58:===================
;59:*/
;60:localEntity_t	*CG_AllocLocalEntity( void ) {
line 63
;61:	localEntity_t	*le;
;62:
;63:	if ( !cg_freeLocalEntities ) {
ADDRGP4 cg_freeLocalEntities
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $90
line 66
;64:		// no free entities, so free the one at the end of the chain
;65:		// remove the oldest active entity
;66:		CG_FreeLocalEntity( cg_activeLocalEntities.prev );
ADDRGP4 cg_activeLocalEntities
INDIRP4
ARGP4
ADDRGP4 CG_FreeLocalEntity
CALLV
pop
line 67
;67:	}
LABELV $90
line 69
;68:
;69:	le = cg_freeLocalEntities;
ADDRLP4 0
ADDRGP4 cg_freeLocalEntities
INDIRP4
ASGNP4
line 70
;70:	cg_freeLocalEntities = cg_freeLocalEntities->next;
ADDRLP4 4
ADDRGP4 cg_freeLocalEntities
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ASGNP4
line 72
;71:
;72:	memset( le, 0, sizeof( *le ) );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 292
ARGI4
ADDRGP4 memset
CALLP4
pop
line 75
;73:
;74:	// link into the active list
;75:	le->next = cg_activeLocalEntities.next;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg_activeLocalEntities+4
INDIRP4
ASGNP4
line 76
;76:	le->prev = &cg_activeLocalEntities;
ADDRLP4 0
INDIRP4
ADDRGP4 cg_activeLocalEntities
ASGNP4
line 77
;77:	cg_activeLocalEntities.next->prev = le;
ADDRGP4 cg_activeLocalEntities+4
INDIRP4
ADDRLP4 0
INDIRP4
ASGNP4
line 78
;78:	cg_activeLocalEntities.next = le;
ADDRGP4 cg_activeLocalEntities+4
ADDRLP4 0
INDIRP4
ASGNP4
line 79
;79:	return le;
ADDRLP4 0
INDIRP4
RETP4
LABELV $89
endproc CG_AllocLocalEntity 8 12
export CG_BloodTrail
proc CG_BloodTrail 48 48
line 101
;80:}
;81:
;82:
;83:/*
;84:====================================================================================
;85:
;86:FRAGMENT PROCESSING
;87:
;88:A fragment localentity interacts with the environment in some way (hitting walls),
;89:or generates more localentities along a trail.
;90:
;91:====================================================================================
;92:*/
;93:
;94:/*
;95:================
;96:CG_BloodTrail
;97:
;98:Leave expanding blood puffs behind gibs
;99:================
;100:*/
;101:void CG_BloodTrail( localEntity_t *le ) {
line 108
;102:	int		t;
;103:	int		t2;
;104:	int		step;
;105:	vec3_t	newOrigin;
;106:	localEntity_t	*blood;
;107:
;108:	step = 150;
ADDRLP4 20
CNSTI4 150
ASGNI4
line 109
;109:	t = step * ( (cg.time - cg.frametime + step ) / step );
ADDRLP4 0
ADDRLP4 20
INDIRI4
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+107600
INDIRI4
SUBI4
ADDRLP4 20
INDIRI4
ADDI4
ADDRLP4 20
INDIRI4
DIVI4
MULI4
ASGNI4
line 110
;110:	t2 = step * ( cg.time / step );
ADDRLP4 24
ADDRLP4 20
INDIRI4
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 20
INDIRI4
DIVI4
MULI4
ASGNI4
line 112
;111:
;112:	for ( ; t <= t2; t += step ) {
ADDRGP4 $102
JUMPV
LABELV $99
line 113
;113:		BG_EvaluateTrajectory( &le->pos, t, newOrigin );
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 115
;114:
;115:		blood = CG_SmokePuff( newOrigin, vec3_origin, 
ADDRLP4 8
ARGP4
ADDRGP4 vec3_origin
ARGP4
CNSTF4 1101004800
ARGF4
ADDRLP4 36
CNSTF4 1065353216
ASGNF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
CNSTF4 1157234688
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 40
CNSTI4 0
ASGNI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRGP4 cgs+156680+352
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 CG_SmokePuff
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 44
INDIRP4
ASGNP4
line 124
;116:					  20,		// radius
;117:					  1, 1, 1, 1,	// color
;118:					  2000,		// trailTime
;119:					  t,		// startTime
;120:					  0,		// fadeInTime
;121:					  0,		// flags
;122:					  cgs.media.bloodTrailShader );
;123:		// use the optimized version
;124:		blood->leType = LE_FALL_SCALE_FADE;
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 5
ASGNI4
line 126
;125:		// drop a total of 40 units over its lifetime
;126:		blood->pos.trDelta[2] = 40;
ADDRLP4 4
INDIRP4
CNSTI4 64
ADDP4
CNSTF4 1109393408
ASGNF4
line 127
;127:	}
LABELV $100
line 112
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 20
INDIRI4
ADDI4
ASGNI4
LABELV $102
ADDRLP4 0
INDIRI4
ADDRLP4 24
INDIRI4
LEI4 $99
line 128
;128:}
LABELV $95
endproc CG_BloodTrail 48 48
export CG_FragmentBounceMark
proc CG_FragmentBounceMark 20 44
line 136
;129:
;130:
;131:/*
;132:================
;133:CG_FragmentBounceMark
;134:================
;135:*/
;136:void CG_FragmentBounceMark( localEntity_t *le, trace_t *trace ) {
line 139
;137:	int			radius;
;138:
;139:	if ( le->leMarkType == LEMT_BLOOD ) {
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
NEI4 $106
line 141
;140:
;141:		radius = 16 + (rand()&31);
ADDRLP4 4
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 16
ADDI4
ASGNI4
line 143
;142://freeze
;143:		if ( g_gamemode.integer > 3 && le->refEntity.customShader == cgs.media.freezeShader ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $108
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRI4
ADDRGP4 cgs+156680+448
INDIRI4
NEI4 $108
line 144
;144:			CG_ImpactMark( cgs.media.freezeMarkShader, trace->endpos, trace->plane.normal, random() * 360, 1, 1, 1, 1, qtrue, radius, qfalse );
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRGP4 cgs+156680+452
INDIRI4
ARGI4
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTF4 1135869952
ADDRLP4 8
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ARGF4
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 CG_ImpactMark
CALLV
pop
line 145
;145:		} else {
ADDRGP4 $107
JUMPV
LABELV $108
line 147
;146://freeze
;147:			CG_ImpactMark( cgs.media.bloodMarkShader, trace->endpos, trace->plane.normal, random()*360, 1,1,1,1, qtrue, radius, qfalse );
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRGP4 cgs+156680+428
INDIRI4
ARGI4
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTF4 1135869952
ADDRLP4 8
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ARGF4
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 CG_ImpactMark
CALLV
pop
line 148
;148:		}
line 149
;149:	} else if ( le->leMarkType == LEMT_BURN ) {
ADDRGP4 $107
JUMPV
LABELV $106
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
NEI4 $117
line 151
;150:
;151:		radius = 8 + (rand()&15);
ADDRLP4 4
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 15
BANDI4
CNSTI4 8
ADDI4
ASGNI4
line 152
;152:		CG_ImpactMark( cgs.media.burnMarkShader, trace->endpos, trace->plane.normal, random()*360,
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRGP4 cgs+156680+436
INDIRI4
ARGI4
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTF4 1135869952
ADDRLP4 8
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ARGF4
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 CG_ImpactMark
CALLV
pop
line 154
;153:			1,1,1,1, qtrue, radius, qfalse );
;154:	}
LABELV $117
LABELV $107
line 159
;155:
;156:
;157:	// don't allow a fragment to make multiple marks, or they
;158:	// pile up while settling
;159:	le->leMarkType = LEMT_NONE;
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 0
ASGNI4
line 160
;160:}
LABELV $105
endproc CG_FragmentBounceMark 20 44
export CG_FragmentBounceSound
proc CG_FragmentBounceSound 16 16
line 167
;161:
;162:/*
;163:================
;164:CG_FragmentBounceSound
;165:================
;166:*/
;167:void CG_FragmentBounceSound( localEntity_t *le, trace_t *trace ) {
line 168
;168:	if ( le->leBounceSoundType == LEBS_BLOOD ) {
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 1
NEI4 $122
line 170
;169:		// half the gibs will make splat sounds
;170:		if ( rand() & 1 ) {
ADDRLP4 0
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $123
line 171
;171:			int r = rand()&3;
ADDRLP4 12
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
CNSTI4 3
BANDI4
ASGNI4
line 174
;172:			sfxHandle_t	s;
;173:
;174:			if ( r == 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $126
line 175
;175:				s = cgs.media.gibBounce1Sound;
ADDRLP4 8
ADDRGP4 cgs+156680+776
INDIRI4
ASGNI4
line 176
;176:			} else if ( r == 1 ) {
ADDRGP4 $127
JUMPV
LABELV $126
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $130
line 177
;177:				s = cgs.media.gibBounce2Sound;
ADDRLP4 8
ADDRGP4 cgs+156680+780
INDIRI4
ASGNI4
line 178
;178:			} else {
ADDRGP4 $131
JUMPV
LABELV $130
line 179
;179:				s = cgs.media.gibBounce3Sound;
ADDRLP4 8
ADDRGP4 cgs+156680+784
INDIRI4
ASGNI4
line 180
;180:			}
LABELV $131
LABELV $127
line 181
;181:			trap_S_StartSound( trace->endpos, ENTITYNUM_WORLD, CHAN_AUTO, s );
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
CNSTI4 1022
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 182
;182:		}
line 183
;183:	} else if ( le->leBounceSoundType == LEBS_BRASS ) {
ADDRGP4 $123
JUMPV
LABELV $122
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 2
NEI4 $136
line 185
;184:
;185:	}
LABELV $136
LABELV $123
line 189
;186:
;187:	// don't allow a fragment to make multiple bounce sounds,
;188:	// or it gets too noisy as they settle
;189:	le->leBounceSoundType = LEBS_NONE;
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 190
;190:}
LABELV $121
endproc CG_FragmentBounceSound 16 16
export CG_ReflectVelocity
proc CG_ReflectVelocity 56 12
line 198
;191:
;192:
;193:/*
;194:================
;195:CG_ReflectVelocity
;196:================
;197:*/
;198:void CG_ReflectVelocity( localEntity_t *le, trace_t *trace ) {
line 204
;199:	vec3_t	velocity;
;200:	float	dot;
;201:	int		hitTime;
;202:
;203:	// reflect the velocity on the trace plane
;204:	hitTime = cg.time - cg.frametime + cg.frametime * trace->fraction;
ADDRLP4 16
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+107600
INDIRI4
SUBI4
CVIF4 4
ADDRGP4 cg+107600
INDIRI4
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
line 205
;205:	BG_EvaluateTrajectoryDelta( &le->pos, hitTime, velocity );
ADDRFP4 0
INDIRP4
CNSTI4 32
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
line 206
;206:	dot = DotProduct( velocity, trace->plane.normal );
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
line 207
;207:	VectorMA( velocity, -2*dot, trace->plane.normal, le->pos.trDelta );
ADDRFP4 0
INDIRP4
CNSTI4 56
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
CNSTI4 60
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
CNSTI4 64
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
line 209
;208:
;209:	VectorScale( le->pos.trDelta, le->bounceFactor, le->pos.trDelta );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 56
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 104
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
CNSTI4 60
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 104
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
CNSTI4 64
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 104
ADDP4
INDIRF4
MULF4
ASGNF4
line 211
;210:
;211:	VectorCopy( trace->endpos, le->pos.trBase );
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRB
ASGNB 12
line 212
;212:	le->pos.trTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 216
;213:
;214:
;215:	// check for stop, making sure that even on low FPS systems it doesn't bobble
;216:	if ( trace->allsolid || 
ADDRLP4 48
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $151
ADDRLP4 48
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
CNSTF4 0
LEF4 $147
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ASGNF4
ADDRLP4 52
INDIRF4
CNSTF4 1109393408
LTF4 $151
ADDRLP4 52
INDIRF4
ADDRGP4 cg+107600
INDIRI4
NEGI4
CVIF4 4
ADDRLP4 52
INDIRF4
MULF4
GEF4 $147
LABELV $151
line 218
;217:		( trace->plane.normal[2] > 0 && 
;218:		( le->pos.trDelta[2] < 40 || le->pos.trDelta[2] < -cg.frametime * le->pos.trDelta[2] ) ) ) {
line 219
;219:		le->pos.trType = TR_STATIONARY;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTI4 0
ASGNI4
line 220
;220:	} else {
LABELV $147
line 222
;221:
;222:	}
LABELV $148
line 223
;223:}
LABELV $138
endproc CG_ReflectVelocity 56 12
export CG_AddFragment
proc CG_AddFragment 88 28
line 230
;224:
;225:/*
;226:================
;227:CG_AddFragment
;228:================
;229:*/
;230:void CG_AddFragment( localEntity_t *le ) {
line 234
;231:	vec3_t	newOrigin;
;232:	trace_t	trace;
;233:
;234:	if ( le->pos.trType == TR_STATIONARY ) {
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
NEI4 $153
line 239
;235:		// sink into the ground if near the removal time
;236:		int		t;
;237:		float	oldZ;
;238:		
;239:		t = le->endTime - cg.time;
ADDRLP4 68
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
ASGNI4
line 240
;240:		if ( t < SINK_TIME ) {
ADDRLP4 68
INDIRI4
CNSTI4 1000
GEI4 $156
line 244
;241:			// we must use an explicit lighting origin, otherwise the
;242:			// lighting would be lost as soon as the origin went
;243:			// into the ground
;244:			VectorCopy( le->refEntity.origin, le->refEntity.lightingOrigin );
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 164
ADDP4
ADDRLP4 76
INDIRP4
CNSTI4 220
ADDP4
INDIRB
ASGNB 12
line 245
;245:			le->refEntity.renderfx |= RF_LIGHTING_ORIGIN;
ADDRLP4 80
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 246
;246:			oldZ = le->refEntity.origin[2];
ADDRLP4 72
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
ASGNF4
line 247
;247:			le->refEntity.origin[2] -= 16 * ( 1.0 - (float)t / SINK_TIME );
ADDRLP4 84
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRF4
CNSTF4 1098907648
CNSTF4 1065353216
ADDRLP4 68
INDIRI4
CVIF4 4
CNSTF4 1148846080
DIVF4
SUBF4
MULF4
SUBF4
ASGNF4
line 249
;248://freeze
;249:			if ( g_gamemode.integer > 3 ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $158
line 250
;250:			CG_AddGib( le );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddGib
CALLV
pop
line 251
;251:			}
LABELV $158
line 253
;252://freeze
;253:			trap_R_AddRefEntityToScene( &le->refEntity );
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 254
;254:			le->refEntity.origin[2] = oldZ;
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
ADDRLP4 72
INDIRF4
ASGNF4
line 255
;255:		} else {
ADDRGP4 $152
JUMPV
LABELV $156
line 257
;256://freeze
;257:			if ( g_gamemode.integer > 3 ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $161
line 258
;258:			CG_AddGib( le );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddGib
CALLV
pop
line 259
;259:			}
LABELV $161
line 261
;260://freeze
;261:			trap_R_AddRefEntityToScene( &le->refEntity );
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 262
;262:		}
line 264
;263:
;264:		return;
ADDRGP4 $152
JUMPV
LABELV $153
line 268
;265:	}
;266:
;267:	// calculate new position
;268:	BG_EvaluateTrajectory( &le->pos, cg.time, newOrigin );
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 56
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 271
;269:
;270:	// trace a line from previous position to new position
;271:	CG_Trace( &trace, le->refEntity.origin, NULL, NULL, newOrigin, -1, CONTENTS_SOLID );
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
ARGP4
ADDRLP4 68
CNSTP4 0
ASGNP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 56
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 272
;272:	if ( trace.fraction == 1.0 ) {
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
NEF4 $165
line 274
;273:		// still in free fall
;274:		VectorCopy( newOrigin, le->refEntity.origin );
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
ADDRLP4 56
INDIRB
ASGNB 12
line 276
;275:
;276:		if ( le->leFlags & LEF_TUMBLE ) {
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $168
line 279
;277:			vec3_t angles;
;278:
;279:			BG_EvaluateTrajectory( &le->angles, cg.time, angles );
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ARGP4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 72
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 280
;280:			AnglesToAxis( angles, le->refEntity.axis );
ADDRLP4 72
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 281
;281:		}
LABELV $168
line 284
;282:
;283://freeze
;284:		if ( g_gamemode.integer > 3 ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $171
line 285
;285:		CG_AddGib( le );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddGib
CALLV
pop
line 286
;286:		}
LABELV $171
line 288
;287://freeze
;288:		trap_R_AddRefEntityToScene( &le->refEntity );
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 291
;289:
;290:		// add a blood trail
;291:		if ( le->leBounceSoundType == LEBS_BLOOD ) {
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 1
NEI4 $152
line 292
;292:			CG_BloodTrail( le );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_BloodTrail
CALLV
pop
line 293
;293:		}
line 295
;294:
;295:		return;
ADDRGP4 $152
JUMPV
LABELV $165
line 301
;296:	}
;297:
;298:	// if it is in a nodrop zone, remove it
;299:	// this keeps gibs from waiting at the bottom of pits of death
;300:	// and floating levels
;301:	if ( trap_CM_PointContents( trace.endpos, 0 ) & CONTENTS_NODROP ) {
ADDRLP4 0+12
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 72
ADDRGP4 trap_CM_PointContents
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CVIU4 4
CNSTU4 2147483648
BANDU4
CNSTU4 0
EQU4 $176
line 302
;302:		CG_FreeLocalEntity( le );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_FreeLocalEntity
CALLV
pop
line 303
;303:		return;
ADDRGP4 $152
JUMPV
LABELV $176
line 307
;304:	}
;305:
;306:	// leave a mark
;307:	CG_FragmentBounceMark( le, &trace );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_FragmentBounceMark
CALLV
pop
line 310
;308:
;309:	// do a bouncy sound
;310:	CG_FragmentBounceSound( le, &trace );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_FragmentBounceSound
CALLV
pop
line 313
;311:
;312:	// reflect the velocity on the trace plane
;313:	CG_ReflectVelocity( le, &trace );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_ReflectVelocity
CALLV
pop
line 316
;314:
;315://freeze
;316:	if ( g_gamemode.integer > 3 ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $179
line 317
;317:		CG_AddGib( le );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddGib
CALLV
pop
line 318
;318:	}
LABELV $179
line 320
;319://freeze
;320:	trap_R_AddRefEntityToScene( &le->refEntity );
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 321
;321:}
LABELV $152
endproc CG_AddFragment 88 28
export CG_AddFadeRGB
proc CG_AddFadeRGB 60 4
line 337
;322:
;323:/*
;324:=====================================================================
;325:
;326:TRIVIAL LOCAL ENTITIES
;327:
;328:These only do simple scaling or modulation before passing to the renderer
;329:=====================================================================
;330:*/
;331:
;332:/*
;333:====================
;334:CG_AddFadeRGB
;335:====================
;336:*/
;337:void CG_AddFadeRGB( localEntity_t *le ) {
line 341
;338:	refEntity_t *re;
;339:	float c;
;340:
;341:	re = &le->refEntity;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ASGNP4
line 343
;342:
;343:	c = ( le->endTime - cg.time ) * le->lifeRate;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 8
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
MULF4
ASGNF4
line 344
;344:	c *= 0xff;
ADDRLP4 4
CNSTF4 1132396544
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 346
;345:
;346:	re->shaderRGBA[0] = le->color[0] * c;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
ADDRLP4 20
CNSTF4 1325400064
ASGNF4
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
LTF4 $185
ADDRLP4 12
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $186
JUMPV
LABELV $185
ADDRLP4 12
ADDRLP4 16
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $186
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 12
INDIRU4
CVUU1 4
ASGNU1
line 347
;347:	re->shaderRGBA[1] = le->color[1] * c;
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
ADDRLP4 32
CNSTF4 1325400064
ASGNF4
ADDRLP4 28
INDIRF4
ADDRLP4 32
INDIRF4
LTF4 $188
ADDRLP4 24
ADDRLP4 28
INDIRF4
ADDRLP4 32
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $189
JUMPV
LABELV $188
ADDRLP4 24
ADDRLP4 28
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $189
ADDRLP4 0
INDIRP4
CNSTI4 117
ADDP4
ADDRLP4 24
INDIRU4
CVUU1 4
ASGNU1
line 348
;348:	re->shaderRGBA[2] = le->color[2] * c;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
ADDRLP4 44
CNSTF4 1325400064
ASGNF4
ADDRLP4 40
INDIRF4
ADDRLP4 44
INDIRF4
LTF4 $191
ADDRLP4 36
ADDRLP4 40
INDIRF4
ADDRLP4 44
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $192
JUMPV
LABELV $191
ADDRLP4 36
ADDRLP4 40
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $192
ADDRLP4 0
INDIRP4
CNSTI4 118
ADDP4
ADDRLP4 36
INDIRU4
CVUU1 4
ASGNU1
line 349
;349:	re->shaderRGBA[3] = le->color[3] * c;
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
ADDRLP4 56
CNSTF4 1325400064
ASGNF4
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
LTF4 $194
ADDRLP4 48
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $195
JUMPV
LABELV $194
ADDRLP4 48
ADDRLP4 52
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $195
ADDRLP4 0
INDIRP4
CNSTI4 119
ADDP4
ADDRLP4 48
INDIRU4
CVUU1 4
ASGNU1
line 351
;350:
;351:	trap_R_AddRefEntityToScene( re );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 352
;352:}
LABELV $182
endproc CG_AddFadeRGB 60 4
proc CG_AddMoveScaleFade 52 12
line 359
;353:
;354:/*
;355:==================
;356:CG_AddMoveScaleFade
;357:==================
;358:*/
;359:static void CG_AddMoveScaleFade( localEntity_t *le ) {
line 365
;360:	refEntity_t	*re;
;361:	float		c;
;362:	vec3_t		delta;
;363:	float		len;
;364:
;365:	re = &le->refEntity;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ASGNP4
line 367
;366:
;367:	if ( le->fadeInTime > le->startTime && cg.time < le->fadeInTime ) {
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
ADDRLP4 24
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
LEI4 $197
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 28
INDIRI4
GEI4 $197
line 369
;368:		// fade / grow time
;369:		c = 1.0 - (float) ( le->fadeInTime - cg.time ) / ( le->fadeInTime - le->startTime );
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
ADDRLP4 32
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
ASGNI4
ADDRLP4 16
CNSTF4 1065353216
ADDRLP4 36
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 36
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
SUBI4
CVIF4 4
DIVF4
SUBF4
ASGNF4
line 370
;370:	}
ADDRGP4 $198
JUMPV
LABELV $197
line 371
;371:	else {
line 373
;372:		// fade / grow time
;373:		c = ( le->endTime - cg.time ) * le->lifeRate;
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 32
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 32
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
MULF4
ASGNF4
line 374
;374:	}
LABELV $198
line 376
;375:
;376:	re->shaderRGBA[3] = 0xff * c * le->color[3];
ADDRLP4 36
CNSTF4 1132396544
ADDRLP4 16
INDIRF4
MULF4
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 40
CNSTF4 1325400064
ASGNF4
ADDRLP4 36
INDIRF4
ADDRLP4 40
INDIRF4
LTF4 $203
ADDRLP4 32
ADDRLP4 36
INDIRF4
ADDRLP4 40
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $204
JUMPV
LABELV $203
ADDRLP4 32
ADDRLP4 36
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $204
ADDRLP4 0
INDIRP4
CNSTI4 119
ADDP4
ADDRLP4 32
INDIRU4
CVUU1 4
ASGNU1
line 378
;377:
;378:	if ( !( le->leFlags & LEF_PUFF_DONT_SCALE ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $205
line 379
;379:		re->radius = le->radius * ( 1.0 - c ) + 8;
ADDRLP4 0
INDIRP4
CNSTI4 132
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
CNSTF4 1065353216
ADDRLP4 16
INDIRF4
SUBF4
MULF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 380
;380:	}
LABELV $205
line 382
;381:
;382:	BG_EvaluateTrajectory( &le->pos, cg.time, re->origin );
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 386
;383:
;384:	// if the view would be "inside" the sprite, kill the sprite
;385:	// so it doesn't add too much overdraw
;386:	VectorSubtract( re->origin, cg.refdef.vieworg, delta );
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ADDRGP4 cg+109048+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ADDRGP4 cg+109048+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ADDRGP4 cg+109048+24+8
INDIRF4
SUBF4
ASGNF4
line 387
;387:	len = VectorLength( delta );
ADDRLP4 4
ARGP4
ADDRLP4 48
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 48
INDIRF4
ASGNF4
line 388
;388:	if ( len < le->radius ) {
ADDRLP4 20
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
GEF4 $218
line 389
;389:		CG_FreeLocalEntity( le );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_FreeLocalEntity
CALLV
pop
line 390
;390:		return;
ADDRGP4 $196
JUMPV
LABELV $218
line 393
;391:	}
;392:
;393:	trap_R_AddRefEntityToScene( re );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 394
;394:}
LABELV $196
endproc CG_AddMoveScaleFade 52 12
proc CG_AddScaleFade 48 4
line 406
;395:
;396:
;397:/*
;398:===================
;399:CG_AddScaleFade
;400:
;401:For rocket smokes that hang in place, fade out, and are
;402:removed if the view passes through them.
;403:There are often many of these, so it needs to be simple.
;404:===================
;405:*/
;406:static void CG_AddScaleFade( localEntity_t *le, int type ) {
line 412
;407:	refEntity_t	*re;
;408:	float		c;
;409:	vec3_t		delta;
;410:	float		len;
;411:
;412:	re = &le->refEntity;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ASGNP4
line 415
;413:
;414:	// fade / grow time
;415:	c = ( le->endTime - cg.time ) * le->lifeRate;
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 24
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 24
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
MULF4
ASGNF4
line 417
;416:
;417:	re->shaderRGBA[3] = 0xff * c * le->color[3];
ADDRLP4 32
CNSTF4 1132396544
ADDRLP4 16
INDIRF4
MULF4
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 36
CNSTF4 1325400064
ASGNF4
ADDRLP4 32
INDIRF4
ADDRLP4 36
INDIRF4
LTF4 $223
ADDRLP4 28
ADDRLP4 32
INDIRF4
ADDRLP4 36
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $224
JUMPV
LABELV $223
ADDRLP4 28
ADDRLP4 32
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $224
ADDRLP4 0
INDIRP4
CNSTI4 119
ADDP4
ADDRLP4 28
INDIRU4
CVUU1 4
ASGNU1
line 418
;418:	if ( !type ) {//h4x
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $225
line 419
;419:		re->radius = le->radius * ( 1.0 - c ) + 8;
ADDRLP4 0
INDIRP4
CNSTI4 132
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
CNSTF4 1065353216
ADDRLP4 16
INDIRF4
SUBF4
MULF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 420
;420:	} else {
ADDRGP4 $226
JUMPV
LABELV $225
line 421
;421:		re->radius = le->radius;
ADDRLP4 0
INDIRP4
CNSTI4 132
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
ASGNF4
line 422
;422:	}
LABELV $226
line 426
;423:
;424:	// if the view would be "inside" the sprite, kill the sprite
;425:	// so it doesn't add too much overdraw
;426:	VectorSubtract( re->origin, cg.refdef.vieworg, delta );
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ADDRGP4 cg+109048+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ADDRGP4 cg+109048+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ADDRGP4 cg+109048+24+8
INDIRF4
SUBF4
ASGNF4
line 427
;427:	len = VectorLength( delta );
ADDRLP4 4
ARGP4
ADDRLP4 44
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 44
INDIRF4
ASGNF4
line 428
;428:	if ( len < le->radius ) {
ADDRLP4 20
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
GEF4 $237
line 429
;429:		CG_FreeLocalEntity( le );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_FreeLocalEntity
CALLV
pop
line 430
;430:		return;
ADDRGP4 $220
JUMPV
LABELV $237
line 433
;431:	}
;432:
;433:	trap_R_AddRefEntityToScene( re );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 434
;434:}
LABELV $220
endproc CG_AddScaleFade 48 4
proc CG_AddFallScaleFade 52 4
line 447
;435:
;436:
;437:/*
;438:=================
;439:CG_AddFallScaleFade
;440:
;441:This is just an optimized CG_AddMoveScaleFade
;442:For blood mists that drift down, fade out, and are
;443:removed if the view passes through them.
;444:There are often 100+ of these, so it needs to be simple.
;445:=================
;446:*/
;447:static void CG_AddFallScaleFade( localEntity_t *le ) {
line 453
;448:	refEntity_t	*re;
;449:	float		c;
;450:	vec3_t		delta;
;451:	float		len;
;452:
;453:	re = &le->refEntity;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ASGNP4
line 456
;454:
;455:	// fade time
;456:	c = ( le->endTime - cg.time ) * le->lifeRate;
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 24
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
MULF4
ASGNF4
line 458
;457:
;458:	re->shaderRGBA[3] = 0xff * c * le->color[3];
ADDRLP4 32
CNSTF4 1132396544
ADDRLP4 4
INDIRF4
MULF4
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 36
CNSTF4 1325400064
ASGNF4
ADDRLP4 32
INDIRF4
ADDRLP4 36
INDIRF4
LTF4 $242
ADDRLP4 28
ADDRLP4 32
INDIRF4
ADDRLP4 36
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $243
JUMPV
LABELV $242
ADDRLP4 28
ADDRLP4 32
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $243
ADDRLP4 0
INDIRP4
CNSTI4 119
ADDP4
ADDRLP4 28
INDIRU4
CVUU1 4
ASGNU1
line 460
;459:
;460:	re->origin[2] = le->pos.trBase[2] - ( 1.0 - c ) * le->pos.trDelta[2];
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 40
INDIRP4
CNSTI4 52
ADDP4
INDIRF4
CNSTF4 1065353216
ADDRLP4 4
INDIRF4
SUBF4
ADDRLP4 40
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
MULF4
SUBF4
ASGNF4
line 462
;461:
;462:	re->radius = le->radius * ( 1.0 - c ) + 16;
ADDRLP4 0
INDIRP4
CNSTI4 132
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
CNSTF4 1065353216
ADDRLP4 4
INDIRF4
SUBF4
MULF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 466
;463:
;464:	// if the view would be "inside" the sprite, kill the sprite
;465:	// so it doesn't add too much overdraw
;466:	VectorSubtract( re->origin, cg.refdef.vieworg, delta );
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ADDRGP4 cg+109048+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+4
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ADDRGP4 cg+109048+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+8
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ADDRGP4 cg+109048+24+8
INDIRF4
SUBF4
ASGNF4
line 467
;467:	len = VectorLength( delta );
ADDRLP4 8
ARGP4
ADDRLP4 48
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 48
INDIRF4
ASGNF4
line 468
;468:	if ( len < le->radius ) {
ADDRLP4 20
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
GEF4 $254
line 469
;469:		CG_FreeLocalEntity( le );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_FreeLocalEntity
CALLV
pop
line 470
;470:		return;
ADDRGP4 $239
JUMPV
LABELV $254
line 473
;471:	}
;472:
;473:	trap_R_AddRefEntityToScene( re );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 474
;474:}
LABELV $239
endproc CG_AddFallScaleFade 52 4
proc CG_AddExplosion 20 20
line 483
;475:
;476:
;477:
;478:/*
;479:================
;480:CG_AddExplosion
;481:================
;482:*/
;483:static void CG_AddExplosion( localEntity_t *ex ) {
line 486
;484:	refEntity_t	*ent;
;485:
;486:	ent = &ex->refEntity;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ASGNP4
line 489
;487:
;488:	// add the entity
;489:	trap_R_AddRefEntityToScene(ent);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 492
;490:
;491:	// add the dlight
;492:	if ( ex->light ) {
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
INDIRF4
CNSTF4 0
EQF4 $257
line 495
;493:		float		light;
;494:
;495:		light = (float)( cg.time - ex->startTime ) / ( ex->endTime - ex->startTime );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 8
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
ADDRLP4 4
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 12
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 8
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 496
;496:		if ( light < 0.5 ) {
ADDRLP4 4
INDIRF4
CNSTF4 1056964608
GEF4 $260
line 497
;497:			light = 1.0;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 498
;498:		} else {
ADDRGP4 $261
JUMPV
LABELV $260
line 499
;499:			light = 1.0 - ( light - 0.5 ) * 2;
ADDRLP4 4
CNSTF4 1065353216
CNSTF4 1073741824
ADDRLP4 4
INDIRF4
CNSTF4 1056964608
SUBF4
MULF4
SUBF4
ASGNF4
line 500
;500:		}
LABELV $261
line 501
;501:		light = ex->light * light;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 502
;502:		trap_R_AddLightToScene(ent->origin, light, ex->lightColor[0], ex->lightColor[1], ex->lightColor[2] );
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 132
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 136
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 140
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 503
;503:	}
LABELV $257
line 504
;504:}
LABELV $256
endproc CG_AddExplosion 20 20
proc CG_AddSpriteExplosion 180 20
line 511
;505:
;506:/*
;507:================
;508:CG_AddSpriteExplosion
;509:================
;510:*/
;511:static void CG_AddSpriteExplosion( localEntity_t *le ) {
line 515
;512:	refEntity_t	re;
;513:	float c;
;514:
;515:	re = le->refEntity;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
INDIRB
ASGNB 140
line 517
;516:
;517:	c = ( le->endTime - cg.time ) / ( float ) ( le->endTime - le->startTime );
ADDRLP4 144
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 148
ADDRLP4 144
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ASGNI4
ADDRLP4 140
ADDRLP4 148
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 148
INDIRI4
ADDRLP4 144
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 518
;518:	if ( c > 1 ) {
ADDRLP4 140
INDIRF4
CNSTF4 1065353216
LEF4 $264
line 519
;519:		c = 1.0;	// can happen during connection problems
ADDRLP4 140
CNSTF4 1065353216
ASGNF4
line 520
;520:	}
LABELV $264
line 522
;521:
;522:	re.shaderRGBA[0] = 0xff;
ADDRLP4 0+116
CNSTU1 255
ASGNU1
line 523
;523:	re.shaderRGBA[1] = 0xff;
ADDRLP4 0+116+1
CNSTU1 255
ASGNU1
line 524
;524:	re.shaderRGBA[2] = 0xff;
ADDRLP4 0+116+2
CNSTU1 255
ASGNU1
line 525
;525:	re.shaderRGBA[3] = 0xff * c * 0.33;
ADDRLP4 156
CNSTF4 1051260355
CNSTF4 1132396544
ADDRLP4 140
INDIRF4
MULF4
MULF4
ASGNF4
ADDRLP4 160
CNSTF4 1325400064
ASGNF4
ADDRLP4 156
INDIRF4
ADDRLP4 160
INDIRF4
LTF4 $274
ADDRLP4 152
ADDRLP4 156
INDIRF4
ADDRLP4 160
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $275
JUMPV
LABELV $274
ADDRLP4 152
ADDRLP4 156
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $275
ADDRLP4 0+116+3
ADDRLP4 152
INDIRU4
CVUU1 4
ASGNU1
line 527
;526:
;527:	re.reType = RT_SPRITE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 528
;528:	re.radius = 42 * ( 1.0 - c ) + 30;
ADDRLP4 0+132
CNSTF4 1109917696
CNSTF4 1065353216
ADDRLP4 140
INDIRF4
SUBF4
MULF4
CNSTF4 1106247680
ADDF4
ASGNF4
line 530
;529:
;530:	trap_R_AddRefEntityToScene( &re );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 533
;531:
;532:	// add the dlight
;533:	if ( le->light ) {
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
INDIRF4
CNSTF4 0
EQF4 $277
line 536
;534:		float		light;
;535:
;536:		light = (float)( cg.time - le->startTime ) / ( le->endTime - le->startTime );
ADDRLP4 168
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 172
ADDRLP4 168
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
ADDRLP4 164
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 172
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 168
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ADDRLP4 172
INDIRI4
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 537
;537:		if ( light < 0.5 ) {
ADDRLP4 164
INDIRF4
CNSTF4 1056964608
GEF4 $280
line 538
;538:			light = 1.0;
ADDRLP4 164
CNSTF4 1065353216
ASGNF4
line 539
;539:		} else {
ADDRGP4 $281
JUMPV
LABELV $280
line 540
;540:			light = 1.0 - ( light - 0.5 ) * 2;
ADDRLP4 164
CNSTF4 1065353216
CNSTF4 1073741824
ADDRLP4 164
INDIRF4
CNSTF4 1056964608
SUBF4
MULF4
SUBF4
ASGNF4
line 541
;541:		}
LABELV $281
line 542
;542:		light = le->light * light;
ADDRLP4 164
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
INDIRF4
ADDRLP4 164
INDIRF4
MULF4
ASGNF4
line 543
;543:		trap_R_AddLightToScene(re.origin, light, le->lightColor[0], le->lightColor[1], le->lightColor[2] );
ADDRLP4 0+68
ARGP4
ADDRLP4 164
INDIRF4
ARGF4
ADDRLP4 176
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 176
INDIRP4
CNSTI4 132
ADDP4
INDIRF4
ARGF4
ADDRLP4 176
INDIRP4
CNSTI4 136
ADDP4
INDIRF4
ARGF4
ADDRLP4 176
INDIRP4
CNSTI4 140
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 544
;544:	}
LABELV $277
line 545
;545:}
LABELV $262
endproc CG_AddSpriteExplosion 180 20
lit
align 4
LABELV $284
byte 4 0
byte 4 0
byte 4 1065353216
export CG_AddScorePlum
code
proc CG_AddScorePlum 168 12
line 730
;546:
;547:
;548:#ifdef MISSIONPACK
;549:/*
;550:====================
;551:CG_AddKamikaze
;552:====================
;553:*/
;554:void CG_AddKamikaze( localEntity_t *le ) {
;555:	refEntity_t	*re;
;556:	refEntity_t shockwave;
;557:	float		c;
;558:	vec3_t		test, axis[3];
;559:	int			t;
;560:
;561:	re = &le->refEntity;
;562:
;563:	t = cg.time - le->startTime;
;564:	VectorClear( test );
;565:	AnglesToAxis( test, axis );
;566:
;567:	if (t > KAMI_SHOCKWAVE_STARTTIME && t < KAMI_SHOCKWAVE_ENDTIME) {
;568:
;569:		if (!(le->leFlags & LEF_SOUND1)) {
;570://			trap_S_StartSound (re->origin, ENTITYNUM_WORLD, CHAN_AUTO, cgs.media.kamikazeExplodeSound );
;571:			trap_S_StartLocalSound(cgs.media.kamikazeExplodeSound, CHAN_AUTO);
;572:			le->leFlags |= LEF_SOUND1;
;573:		}
;574:		// 1st kamikaze shockwave
;575:		memset(&shockwave, 0, sizeof(shockwave));
;576:		shockwave.hModel = cgs.media.kamikazeShockWave;
;577:		shockwave.reType = RT_MODEL;
;578:		shockwave.shaderTime = re->shaderTime;
;579:		VectorCopy(re->origin, shockwave.origin);
;580:
;581:		c = (float)(t - KAMI_SHOCKWAVE_STARTTIME) / (float)(KAMI_SHOCKWAVE_ENDTIME - KAMI_SHOCKWAVE_STARTTIME);
;582:		VectorScale( axis[0], c * KAMI_SHOCKWAVE_MAXRADIUS / KAMI_SHOCKWAVEMODEL_RADIUS, shockwave.axis[0] );
;583:		VectorScale( axis[1], c * KAMI_SHOCKWAVE_MAXRADIUS / KAMI_SHOCKWAVEMODEL_RADIUS, shockwave.axis[1] );
;584:		VectorScale( axis[2], c * KAMI_SHOCKWAVE_MAXRADIUS / KAMI_SHOCKWAVEMODEL_RADIUS, shockwave.axis[2] );
;585:		shockwave.nonNormalizedAxes = qtrue;
;586:
;587:		if (t > KAMI_SHOCKWAVEFADE_STARTTIME) {
;588:			c = (float)(t - KAMI_SHOCKWAVEFADE_STARTTIME) / (float)(KAMI_SHOCKWAVE_ENDTIME - KAMI_SHOCKWAVEFADE_STARTTIME);
;589:		}
;590:		else {
;591:			c = 0;
;592:		}
;593:		c *= 0xff;
;594:		shockwave.shaderRGBA[0] = 0xff - c;
;595:		shockwave.shaderRGBA[1] = 0xff - c;
;596:		shockwave.shaderRGBA[2] = 0xff - c;
;597:		shockwave.shaderRGBA[3] = 0xff - c;
;598:
;599:		trap_R_AddRefEntityToScene( &shockwave );
;600:	}
;601:
;602:	if (t > KAMI_EXPLODE_STARTTIME && t < KAMI_IMPLODE_ENDTIME) {
;603:		// explosion and implosion
;604:		c = ( le->endTime - cg.time ) * le->lifeRate;
;605:		c *= 0xff;
;606:		re->shaderRGBA[0] = le->color[0] * c;
;607:		re->shaderRGBA[1] = le->color[1] * c;
;608:		re->shaderRGBA[2] = le->color[2] * c;
;609:		re->shaderRGBA[3] = le->color[3] * c;
;610:
;611:		if( t < KAMI_IMPLODE_STARTTIME ) {
;612:			c = (float)(t - KAMI_EXPLODE_STARTTIME) / (float)(KAMI_IMPLODE_STARTTIME - KAMI_EXPLODE_STARTTIME);
;613:		}
;614:		else {
;615:			if (!(le->leFlags & LEF_SOUND2)) {
;616://				trap_S_StartSound (re->origin, ENTITYNUM_WORLD, CHAN_AUTO, cgs.media.kamikazeImplodeSound );
;617:				trap_S_StartLocalSound(cgs.media.kamikazeImplodeSound, CHAN_AUTO);
;618:				le->leFlags |= LEF_SOUND2;
;619:			}
;620:			c = (float)(KAMI_IMPLODE_ENDTIME - t) / (float) (KAMI_IMPLODE_ENDTIME - KAMI_IMPLODE_STARTTIME);
;621:		}
;622:		VectorScale( axis[0], c * KAMI_BOOMSPHERE_MAXRADIUS / KAMI_BOOMSPHEREMODEL_RADIUS, re->axis[0] );
;623:		VectorScale( axis[1], c * KAMI_BOOMSPHERE_MAXRADIUS / KAMI_BOOMSPHEREMODEL_RADIUS, re->axis[1] );
;624:		VectorScale( axis[2], c * KAMI_BOOMSPHERE_MAXRADIUS / KAMI_BOOMSPHEREMODEL_RADIUS, re->axis[2] );
;625:		re->nonNormalizedAxes = qtrue;
;626:
;627:		trap_R_AddRefEntityToScene( re );
;628:		// add the dlight
;629:		trap_R_AddLightToScene( re->origin, c * 1000.0, 1.0, 1.0, c );
;630:	}
;631:
;632:	if (t > KAMI_SHOCKWAVE2_STARTTIME && t < KAMI_SHOCKWAVE2_ENDTIME) {
;633:		// 2nd kamikaze shockwave
;634:		if (le->angles.trBase[0] == 0 &&
;635:			le->angles.trBase[1] == 0 &&
;636:			le->angles.trBase[2] == 0) {
;637:			le->angles.trBase[0] = random() * 360;
;638:			le->angles.trBase[1] = random() * 360;
;639:			le->angles.trBase[2] = random() * 360;
;640:		}
;641:		else {
;642:			c = 0;
;643:		}
;644:		memset(&shockwave, 0, sizeof(shockwave));
;645:		shockwave.hModel = cgs.media.kamikazeShockWave;
;646:		shockwave.reType = RT_MODEL;
;647:		shockwave.shaderTime = re->shaderTime;
;648:		VectorCopy(re->origin, shockwave.origin);
;649:
;650:		test[0] = le->angles.trBase[0];
;651:		test[1] = le->angles.trBase[1];
;652:		test[2] = le->angles.trBase[2];
;653:		AnglesToAxis( test, axis );
;654:
;655:		c = (float)(t - KAMI_SHOCKWAVE2_STARTTIME) / (float)(KAMI_SHOCKWAVE2_ENDTIME - KAMI_SHOCKWAVE2_STARTTIME);
;656:		VectorScale( axis[0], c * KAMI_SHOCKWAVE2_MAXRADIUS / KAMI_SHOCKWAVEMODEL_RADIUS, shockwave.axis[0] );
;657:		VectorScale( axis[1], c * KAMI_SHOCKWAVE2_MAXRADIUS / KAMI_SHOCKWAVEMODEL_RADIUS, shockwave.axis[1] );
;658:		VectorScale( axis[2], c * KAMI_SHOCKWAVE2_MAXRADIUS / KAMI_SHOCKWAVEMODEL_RADIUS, shockwave.axis[2] );
;659:		shockwave.nonNormalizedAxes = qtrue;
;660:
;661:		if (t > KAMI_SHOCKWAVE2FADE_STARTTIME) {
;662:			c = (float)(t - KAMI_SHOCKWAVE2FADE_STARTTIME) / (float)(KAMI_SHOCKWAVE2_ENDTIME - KAMI_SHOCKWAVE2FADE_STARTTIME);
;663:		}
;664:		else {
;665:			c = 0;
;666:		}
;667:		c *= 0xff;
;668:		shockwave.shaderRGBA[0] = 0xff - c;
;669:		shockwave.shaderRGBA[1] = 0xff - c;
;670:		shockwave.shaderRGBA[2] = 0xff - c;
;671:		shockwave.shaderRGBA[3] = 0xff - c;
;672:
;673:		trap_R_AddRefEntityToScene( &shockwave );
;674:	}
;675:}
;676:
;677:/*
;678:===================
;679:CG_AddInvulnerabilityImpact
;680:===================
;681:*/
;682:void CG_AddInvulnerabilityImpact( localEntity_t *le ) {
;683:	trap_R_AddRefEntityToScene( &le->refEntity );
;684:}
;685:
;686:/*
;687:===================
;688:CG_AddInvulnerabilityJuiced
;689:===================
;690:*/
;691:void CG_AddInvulnerabilityJuiced( localEntity_t *le ) {
;692:	int t;
;693:
;694:	t = cg.time - le->startTime;
;695:	if ( t > 3000 ) {
;696:		le->refEntity.axis[0][0] = (float) 1.0 + 0.3 * (t - 3000) / 2000;
;697:		le->refEntity.axis[1][1] = (float) 1.0 + 0.3 * (t - 3000) / 2000;
;698:		le->refEntity.axis[2][2] = (float) 0.7 + 0.3 * (2000 - (t - 3000)) / 2000;
;699:	}
;700:	if ( t > 5000 ) {
;701:		le->endTime = 0;
;702:		CG_GibPlayer( le->refEntity.origin );
;703:	}
;704:	else {
;705:		trap_R_AddRefEntityToScene( &le->refEntity );
;706:	}
;707:}
;708:
;709:/*
;710:===================
;711:CG_AddRefEntity
;712:===================
;713:*/
;714:void CG_AddRefEntity( localEntity_t *le ) {
;715:	if (le->endTime < cg.time) {
;716:		CG_FreeLocalEntity( le );
;717:		return;
;718:	}
;719:	trap_R_AddRefEntityToScene( &le->refEntity );
;720:}
;721:
;722:#endif
;723:/*
;724:===================
;725:CG_AddScorePlum
;726:===================
;727:*/
;728:#define NUMBER_SIZE		8
;729:
;730:void CG_AddScorePlum( localEntity_t *le ) {
line 732
;731:	refEntity_t	*re;
;732:	vec3_t		origin, delta, dir, vec, up = {0, 0, 1};
ADDRLP4 112
ADDRGP4 $284
INDIRB
ASGNB 12
line 736
;733:	float		c, len;
;734:	int			i, score, digits[10], numdigits, negative;
;735:
;736:	re = &le->refEntity;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ASGNP4
line 738
;737:
;738:	c = ( le->endTime - cg.time ) * le->lifeRate;
ADDRLP4 128
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
ADDRLP4 128
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 128
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
MULF4
ASGNF4
line 740
;739:
;740:	score = le->radius;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 741
;741:	if (score < 0) {
ADDRLP4 12
INDIRI4
CNSTI4 0
GEI4 $286
line 742
;742:		re->shaderRGBA[0] = 0xff;
ADDRLP4 8
INDIRP4
CNSTI4 116
ADDP4
CNSTU1 255
ASGNU1
line 743
;743:		re->shaderRGBA[1] = 0x11;
ADDRLP4 8
INDIRP4
CNSTI4 117
ADDP4
CNSTU1 17
ASGNU1
line 744
;744:		re->shaderRGBA[2] = 0x11;
ADDRLP4 8
INDIRP4
CNSTI4 118
ADDP4
CNSTU1 17
ASGNU1
line 745
;745:	}
ADDRGP4 $287
JUMPV
LABELV $286
line 746
;746:	else {
line 747
;747:		re->shaderRGBA[0] = 0xff;
ADDRLP4 8
INDIRP4
CNSTI4 116
ADDP4
CNSTU1 255
ASGNU1
line 748
;748:		re->shaderRGBA[1] = 0xff;
ADDRLP4 8
INDIRP4
CNSTI4 117
ADDP4
CNSTU1 255
ASGNU1
line 749
;749:		re->shaderRGBA[2] = 0xff;
ADDRLP4 8
INDIRP4
CNSTI4 118
ADDP4
CNSTU1 255
ASGNU1
line 750
;750:		if (score >= 50) {
ADDRLP4 12
INDIRI4
CNSTI4 50
LTI4 $288
line 751
;751:			re->shaderRGBA[1] = 0;
ADDRLP4 8
INDIRP4
CNSTI4 117
ADDP4
CNSTU1 0
ASGNU1
line 752
;752:		} else if (score >= 20) {
ADDRGP4 $289
JUMPV
LABELV $288
ADDRLP4 12
INDIRI4
CNSTI4 20
LTI4 $290
line 753
;753:			re->shaderRGBA[0] = re->shaderRGBA[1] = 0;
ADDRLP4 136
CNSTU1 0
ASGNU1
ADDRLP4 8
INDIRP4
CNSTI4 117
ADDP4
ADDRLP4 136
INDIRU1
ASGNU1
ADDRLP4 8
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 136
INDIRU1
ASGNU1
line 754
;754:		} else if (score >= 10) {
ADDRGP4 $291
JUMPV
LABELV $290
ADDRLP4 12
INDIRI4
CNSTI4 10
LTI4 $292
line 755
;755:			re->shaderRGBA[2] = 0;
ADDRLP4 8
INDIRP4
CNSTI4 118
ADDP4
CNSTU1 0
ASGNU1
line 756
;756:		} else if (score >= 2) {
ADDRGP4 $293
JUMPV
LABELV $292
ADDRLP4 12
INDIRI4
CNSTI4 2
LTI4 $294
line 757
;757:			re->shaderRGBA[0] = re->shaderRGBA[2] = 0;
ADDRLP4 136
CNSTU1 0
ASGNU1
ADDRLP4 8
INDIRP4
CNSTI4 118
ADDP4
ADDRLP4 136
INDIRU1
ASGNU1
ADDRLP4 8
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 136
INDIRU1
ASGNU1
line 758
;758:		}
LABELV $294
LABELV $293
LABELV $291
LABELV $289
line 760
;759:
;760:	}
LABELV $287
line 761
;761:	if (c < 0.25)
ADDRLP4 80
INDIRF4
CNSTF4 1048576000
GEF4 $296
line 762
;762:		re->shaderRGBA[3] = 0xff * 4 * c;
ADDRLP4 136
CNSTF4 1149173760
ADDRLP4 80
INDIRF4
MULF4
ASGNF4
ADDRLP4 140
CNSTF4 1325400064
ASGNF4
ADDRLP4 136
INDIRF4
ADDRLP4 140
INDIRF4
LTF4 $299
ADDRLP4 132
ADDRLP4 136
INDIRF4
ADDRLP4 140
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $300
JUMPV
LABELV $299
ADDRLP4 132
ADDRLP4 136
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $300
ADDRLP4 8
INDIRP4
CNSTI4 119
ADDP4
ADDRLP4 132
INDIRU4
CVUU1 4
ASGNU1
ADDRGP4 $297
JUMPV
LABELV $296
line 764
;763:	else
;764:		re->shaderRGBA[3] = 0xff;
ADDRLP4 8
INDIRP4
CNSTI4 119
ADDP4
CNSTU1 255
ASGNU1
LABELV $297
line 766
;765:
;766:	re->radius = NUMBER_SIZE / 2;
ADDRLP4 8
INDIRP4
CNSTI4 132
ADDP4
CNSTF4 1082130432
ASGNF4
line 768
;767:
;768:	VectorCopy(le->pos.trBase, origin);
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRB
ASGNB 12
line 769
;769:	origin[2] += 110 - c * 100;
ADDRLP4 16+8
ADDRLP4 16+8
INDIRF4
CNSTF4 1121714176
CNSTF4 1120403456
ADDRLP4 80
INDIRF4
MULF4
SUBF4
ADDF4
ASGNF4
line 771
;770:
;771:	VectorSubtract(cg.refdef.vieworg, origin, dir);
ADDRLP4 96
ADDRGP4 cg+109048+24
INDIRF4
ADDRLP4 16
INDIRF4
SUBF4
ASGNF4
ADDRLP4 96+4
ADDRGP4 cg+109048+24+4
INDIRF4
ADDRLP4 16+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 96+8
ADDRGP4 cg+109048+24+8
INDIRF4
ADDRLP4 16+8
INDIRF4
SUBF4
ASGNF4
line 772
;772:	CrossProduct(dir, up, vec);
ADDRLP4 96
ARGP4
ADDRLP4 112
ARGP4
ADDRLP4 28
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 773
;773:	VectorNormalize(vec);
ADDRLP4 28
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 775
;774:
;775:	VectorMA(origin, -10 + 20 * sin(c * 2 * M_PI), vec, origin);
CNSTF4 1078530011
CNSTF4 1073741824
ADDRLP4 80
INDIRF4
MULF4
MULF4
ARGF4
ADDRLP4 144
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 16
INDIRF4
ADDRLP4 28
INDIRF4
CNSTF4 1101004800
ADDRLP4 144
INDIRF4
MULF4
CNSTF4 3240099840
ADDF4
MULF4
ADDF4
ASGNF4
CNSTF4 1078530011
CNSTF4 1073741824
ADDRLP4 80
INDIRF4
MULF4
MULF4
ARGF4
ADDRLP4 148
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 28+4
INDIRF4
CNSTF4 1101004800
ADDRLP4 148
INDIRF4
MULF4
CNSTF4 3240099840
ADDF4
MULF4
ADDF4
ASGNF4
CNSTF4 1078530011
CNSTF4 1073741824
ADDRLP4 80
INDIRF4
MULF4
MULF4
ARGF4
ADDRLP4 152
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 28+8
INDIRF4
CNSTF4 1101004800
ADDRLP4 152
INDIRF4
MULF4
CNSTF4 3240099840
ADDF4
MULF4
ADDF4
ASGNF4
line 779
;776:
;777:	// if the view would be "inside" the sprite, kill the sprite
;778:	// so it doesn't add too much overdraw
;779:	VectorSubtract( origin, cg.refdef.vieworg, delta );
ADDRLP4 84
ADDRLP4 16
INDIRF4
ADDRGP4 cg+109048+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 84+4
ADDRLP4 16+4
INDIRF4
ADDRGP4 cg+109048+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 84+8
ADDRLP4 16+8
INDIRF4
ADDRGP4 cg+109048+24+8
INDIRF4
SUBF4
ASGNF4
line 780
;780:	len = VectorLength( delta );
ADDRLP4 84
ARGP4
ADDRLP4 156
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 124
ADDRLP4 156
INDIRF4
ASGNF4
line 781
;781:	if ( len < 20 ) {
ADDRLP4 124
INDIRF4
CNSTF4 1101004800
GEF4 $332
line 782
;782:		CG_FreeLocalEntity( le );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_FreeLocalEntity
CALLV
pop
line 783
;783:		return;
ADDRGP4 $283
JUMPV
LABELV $332
line 786
;784:	}
;785:
;786:	negative = qfalse;
ADDRLP4 108
CNSTI4 0
ASGNI4
line 787
;787:	if (score < 0) {
ADDRLP4 12
INDIRI4
CNSTI4 0
GEI4 $334
line 788
;788:		negative = qtrue;
ADDRLP4 108
CNSTI4 1
ASGNI4
line 789
;789:		score = -score;
ADDRLP4 12
ADDRLP4 12
INDIRI4
NEGI4
ASGNI4
line 790
;790:	}
LABELV $334
line 792
;791:
;792:	for (numdigits = 0; !(numdigits && !score); numdigits++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $339
JUMPV
LABELV $336
line 793
;793:		digits[numdigits] = score % 10;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 40
ADDP4
ADDRLP4 12
INDIRI4
CNSTI4 10
MODI4
ASGNI4
line 794
;794:		score = score / 10;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 10
DIVI4
ASGNI4
line 795
;795:	}
LABELV $337
line 792
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $339
ADDRLP4 160
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 160
INDIRI4
EQI4 $336
ADDRLP4 12
INDIRI4
ADDRLP4 160
INDIRI4
NEI4 $336
line 797
;796:
;797:	if (negative) {
ADDRLP4 108
INDIRI4
CNSTI4 0
EQI4 $340
line 798
;798:		digits[numdigits] = 10;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 40
ADDP4
CNSTI4 10
ASGNI4
line 799
;799:		numdigits++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 800
;800:	}
LABELV $340
line 802
;801:
;802:	for (i = 0; i < numdigits; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $345
JUMPV
LABELV $342
line 803
;803:		VectorMA(origin, (float) (((float) numdigits / 2) - i) * NUMBER_SIZE, vec, re->origin);
ADDRLP4 8
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 16
INDIRF4
ADDRLP4 28
INDIRF4
CNSTF4 1090519040
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1073741824
DIVF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 16+4
INDIRF4
ADDRLP4 28+4
INDIRF4
CNSTF4 1090519040
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1073741824
DIVF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 16+8
INDIRF4
ADDRLP4 28+8
INDIRF4
CNSTF4 1090519040
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1073741824
DIVF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
MULF4
MULF4
ADDF4
ASGNF4
line 804
;804:		re->customShader = cgs.media.numberShaders[digits[numdigits-1-i]];
ADDRLP4 164
CNSTI4 2
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 112
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 4
INDIRI4
SUBI4
ADDRLP4 164
INDIRI4
LSHI4
ADDRLP4 40
ADDP4
INDIRI4
ADDRLP4 164
INDIRI4
LSHI4
ADDRGP4 cgs+156680+356
ADDP4
INDIRI4
ASGNI4
line 805
;805:		trap_R_AddRefEntityToScene( re );
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 806
;806:	}
LABELV $343
line 802
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $345
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
LTI4 $342
line 807
;807:}
LABELV $283
endproc CG_AddScorePlum 168 12
export CG_AddLocalEntities
proc CG_AddLocalEntities 16 8
line 820
;808:
;809:
;810:
;811:
;812://==============================================================================
;813:
;814:/*
;815:===================
;816:CG_AddLocalEntities
;817:
;818:===================
;819:*/
;820:void CG_AddLocalEntities( void ) {
line 825
;821:	localEntity_t	*le, *next;
;822:
;823:	// walk the list backwards, so any new local entities generated
;824:	// (trails, marks, etc) will be present this frame
;825:	le = cg_activeLocalEntities.prev;
ADDRLP4 0
ADDRGP4 cg_activeLocalEntities
INDIRP4
ASGNP4
line 826
;826:	for ( ; le != &cg_activeLocalEntities ; le = next ) {
ADDRGP4 $356
JUMPV
LABELV $353
line 829
;827:		// grab next now, so if the local entity is freed we
;828:		// still have it
;829:		next = le->prev;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 831
;830:
;831:		if ( cg.time >= le->endTime ) {
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
LTI4 $357
line 832
;832:			CG_FreeLocalEntity( le );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_FreeLocalEntity
CALLV
pop
line 833
;833:			continue;
ADDRGP4 $354
JUMPV
LABELV $357
line 835
;834:		}
;835:		switch ( le->leType ) {
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $360
ADDRLP4 8
INDIRI4
CNSTI4 9
GTI4 $360
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $374
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $374
address $361
address $366
address $365
address $367
address $368
address $370
address $369
address $371
address $372
address $373
code
LABELV $360
line 837
;836:		default:
;837:			CG_Error( "Bad leType: %i", le->leType );
ADDRGP4 $363
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 838
;838:			break;
ADDRGP4 $361
JUMPV
line 841
;839:
;840:		case LE_MARK:
;841:			break;
LABELV $365
line 844
;842:
;843:		case LE_SPRITE_EXPLOSION:
;844:			CG_AddSpriteExplosion( le );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddSpriteExplosion
CALLV
pop
line 845
;845:			break;
ADDRGP4 $361
JUMPV
LABELV $366
line 848
;846:
;847:		case LE_EXPLOSION:
;848:			CG_AddExplosion( le );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddExplosion
CALLV
pop
line 849
;849:			break;
ADDRGP4 $361
JUMPV
LABELV $367
line 852
;850:
;851:		case LE_FRAGMENT:			// gibs and brass
;852:			CG_AddFragment( le );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddFragment
CALLV
pop
line 853
;853:			break;
ADDRGP4 $361
JUMPV
LABELV $368
line 856
;854:
;855:		case LE_MOVE_SCALE_FADE:		// water bubbles
;856:			CG_AddMoveScaleFade( le );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddMoveScaleFade
CALLV
pop
line 857
;857:			break;
ADDRGP4 $361
JUMPV
LABELV $369
line 860
;858:
;859:		case LE_FADE_RGB:				// teleporters, railtrails
;860:			CG_AddFadeRGB( le );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddFadeRGB
CALLV
pop
line 861
;861:			break;
ADDRGP4 $361
JUMPV
LABELV $370
line 864
;862:
;863:		case LE_FALL_SCALE_FADE: // gib blood trails
;864:			CG_AddFallScaleFade( le );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddFallScaleFade
CALLV
pop
line 865
;865:			break;
ADDRGP4 $361
JUMPV
LABELV $371
line 868
;866:
;867:		case LE_SCALE_FADE:		// rocket trails
;868:			CG_AddScaleFade( le, 0 );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 CG_AddScaleFade
CALLV
pop
line 869
;869:			break;
ADDRGP4 $361
JUMPV
LABELV $372
line 872
;870:
;871:		case LE_SCALE_FADE2:		// rocket trails
;872:			CG_AddScaleFade( le, 1 );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 CG_AddScaleFade
CALLV
pop
line 873
;873:			break;
ADDRGP4 $361
JUMPV
LABELV $373
line 876
;874:
;875:		case LE_SCOREPLUM:
;876:			CG_AddScorePlum( le );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddScorePlum
CALLV
pop
line 877
;877:			break;
LABELV $361
line 894
;878:
;879:#ifdef MISSIONPACK
;880:		case LE_KAMIKAZE:
;881:			CG_AddKamikaze( le );
;882:			break;
;883:		case LE_INVULIMPACT:
;884:			CG_AddInvulnerabilityImpact( le );
;885:			break;
;886:		case LE_INVULJUICED:
;887:			CG_AddInvulnerabilityJuiced( le );
;888:			break;
;889:		case LE_SHOWREFENTITY:
;890:			CG_AddRefEntity( le );
;891:			break;
;892:#endif
;893:		}
;894:	}
LABELV $354
line 826
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
LABELV $356
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 cg_activeLocalEntities
CVPU4 4
NEU4 $353
line 895
;895:}
LABELV $352
endproc CG_AddLocalEntities 16 8
bss
export cg_freeLocalEntities
align 4
LABELV cg_freeLocalEntities
skip 4
export cg_activeLocalEntities
align 4
LABELV cg_activeLocalEntities
skip 292
export cg_localEntities
align 4
LABELV cg_localEntities
skip 149504
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
LABELV $363
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 108
byte 1 101
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $88
byte 1 67
byte 1 71
byte 1 95
byte 1 70
byte 1 114
byte 1 101
byte 1 101
byte 1 76
byte 1 111
byte 1 99
byte 1 97
byte 1 108
byte 1 69
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 101
byte 1 0
