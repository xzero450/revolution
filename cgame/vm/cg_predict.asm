export CG_BuildSolidList
code
proc CG_BuildSolidList 28 0
file "../cg_predict.c"
line 26
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_predict.c -- this file generates cg.predictedPlayerState by either
;4:// interpolating between snapshots from the server or locally predicting
;5:// ahead the client's movement.
;6:// It also handles local physics interaction, like fragments bouncing off walls
;7:
;8:#include "cg_local.h"
;9:
;10:static	pmove_t		cg_pmove;
;11:
;12:static	int			cg_numSolidEntities;
;13:static	centity_t	*cg_solidEntities[MAX_ENTITIES_IN_SNAPSHOT];
;14:static	int			cg_numTriggerEntities;
;15:static	centity_t	*cg_triggerEntities[MAX_ENTITIES_IN_SNAPSHOT];
;16:
;17:/*
;18:====================
;19:CG_BuildSolidList
;20:
;21:When a new cg.snap has been set, this function builds a sublist
;22:of the entities that are actually solid, to make for more
;23:efficient collision detection
;24:====================
;25:*/
;26:void CG_BuildSolidList( void ) {
line 32
;27:	int			i;
;28:	centity_t	*cent;
;29:	snapshot_t	*snap;
;30:	entityState_t	*ent;
;31:
;32:	cg_numSolidEntities = 0;
ADDRGP4 cg_numSolidEntities
CNSTI4 0
ASGNI4
line 33
;33:	cg_numTriggerEntities = 0;
ADDRGP4 cg_numTriggerEntities
CNSTI4 0
ASGNI4
line 35
;34:
;35:	if ( cg.nextSnap && !cg.nextFrameTeleport && !cg.thisFrameTeleport ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $78
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 cg+107596
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $78
ADDRGP4 cg+107592
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $78
line 36
;36:		snap = cg.nextSnap;
ADDRLP4 12
ADDRGP4 cg+40
INDIRP4
ASGNP4
line 37
;37:	} else {
ADDRGP4 $79
JUMPV
LABELV $78
line 38
;38:		snap = cg.snap;
ADDRLP4 12
ADDRGP4 cg+36
INDIRP4
ASGNP4
line 39
;39:	}
LABELV $79
line 41
;40:
;41:	for ( i = 0 ; i < snap->numEntities ; i++ ) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $88
JUMPV
LABELV $85
line 42
;42:		cent = &cg_entities[ snap->entities[ i ].number ];
ADDRLP4 0
CNSTI4 728
CNSTI4 208
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 12
INDIRP4
CNSTI4 516
ADDP4
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 43
;43:		ent = &cent->currentState;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 45
;44:
;45:		if ( ent->eType == ET_ITEM || ent->eType == ET_PUSH_TRIGGER || ent->eType == ET_TELEPORT_TRIGGER ) {
ADDRLP4 20
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 2
EQI4 $92
ADDRLP4 20
INDIRI4
CNSTI4 8
EQI4 $92
ADDRLP4 20
INDIRI4
CNSTI4 9
NEI4 $89
LABELV $92
line 46
;46:			cg_triggerEntities[cg_numTriggerEntities] = cent;
ADDRGP4 cg_numTriggerEntities
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_triggerEntities
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 47
;47:			cg_numTriggerEntities++;
ADDRLP4 24
ADDRGP4 cg_numTriggerEntities
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 48
;48:			continue;
ADDRGP4 $86
JUMPV
LABELV $89
line 51
;49:		}
;50:
;51:		if ( cent->nextState.solid ) {
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 0
EQI4 $93
line 52
;52:			cg_solidEntities[cg_numSolidEntities] = cent;
ADDRGP4 cg_numSolidEntities
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_solidEntities
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 53
;53:			cg_numSolidEntities++;
ADDRLP4 24
ADDRGP4 cg_numSolidEntities
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 54
;54:			continue;
LABELV $93
line 56
;55:		}
;56:	}
LABELV $86
line 41
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $88
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
LTI4 $85
line 57
;57:}
LABELV $77
endproc CG_BuildSolidList 28 0
proc CG_ClipMoveToEntities 144 36
line 66
;58:
;59:/*
;60:====================
;61:CG_ClipMoveToEntities
;62:
;63:====================
;64:*/
;65:static void CG_ClipMoveToEntities ( const vec3_t start, const vec3_t mins, const vec3_t maxs, const vec3_t end,
;66:							int skipNumber, int mask, trace_t *tr ) {
line 75
;67:	int			i, x, zd, zu;
;68:	trace_t		trace;
;69:	entityState_t	*ent;
;70:	clipHandle_t 	cmodel;
;71:	vec3_t		bmins, bmaxs;
;72:	vec3_t		origin, angles;
;73:	centity_t	*cent;
;74:
;75:	for ( i = 0 ; i < cg_numSolidEntities ; i++ ) {
ADDRLP4 64
CNSTI4 0
ASGNI4
ADDRGP4 $99
JUMPV
LABELV $96
line 76
;76:		cent = cg_solidEntities[ i ];
ADDRLP4 60
ADDRLP4 64
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_solidEntities
ADDP4
INDIRP4
ASGNP4
line 77
;77:		ent = &cent->currentState;
ADDRLP4 0
ADDRLP4 60
INDIRP4
ASGNP4
line 85
;78:
;79:
;80:		//if (!AllowEntityInteraction(cent))
;81:		//	continue;
;82:
;83:
;84:
;85:		if ( ent->number == skipNumber ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRFP4 16
INDIRI4
NEI4 $100
line 86
;86:			continue;
ADDRGP4 $97
JUMPV
LABELV $100
line 89
;87:		}
;88:
;89:		if ( ent->solid == SOLID_BMODEL ) {
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 16777215
NEI4 $102
line 91
;90:			// special value for bmodel
;91:			cmodel = trap_CM_InlineModel( ent->modelindex );
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRLP4 132
ADDRGP4 trap_CM_InlineModel
CALLI4
ASGNI4
ADDRLP4 68
ADDRLP4 132
INDIRI4
ASGNI4
line 92
;92:			VectorCopy( cent->lerpAngles, angles );
ADDRLP4 108
ADDRLP4 60
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 93
;93:			BG_EvaluateTrajectory( &cent->currentState.pos, cg.physicsTime, origin );
ADDRLP4 60
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+107612
INDIRI4
ARGI4
ADDRLP4 96
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 94
;94:		} else {
ADDRGP4 $103
JUMPV
LABELV $102
line 96
;95:			// encoded bbox
;96:			x = (ent->solid & 255);
ADDRLP4 120
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 255
BANDI4
ASGNI4
line 97
;97:			zd = ((ent->solid>>8) & 255);
ADDRLP4 124
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 8
RSHI4
CNSTI4 255
BANDI4
ASGNI4
line 98
;98:			zu = ((ent->solid>>16) & 255) - 32;
ADDRLP4 128
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 16
RSHI4
CNSTI4 255
BANDI4
CNSTI4 32
SUBI4
ASGNI4
line 100
;99:
;100:			bmins[0] = bmins[1] = -x;
ADDRLP4 132
ADDRLP4 120
INDIRI4
NEGI4
CVIF4 4
ASGNF4
ADDRLP4 72+4
ADDRLP4 132
INDIRF4
ASGNF4
ADDRLP4 72
ADDRLP4 132
INDIRF4
ASGNF4
line 101
;101:			bmaxs[0] = bmaxs[1] = x;
ADDRLP4 136
ADDRLP4 120
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 84+4
ADDRLP4 136
INDIRF4
ASGNF4
ADDRLP4 84
ADDRLP4 136
INDIRF4
ASGNF4
line 102
;102:			bmins[2] = -zd;
ADDRLP4 72+8
ADDRLP4 124
INDIRI4
NEGI4
CVIF4 4
ASGNF4
line 103
;103:			bmaxs[2] = zu;
ADDRLP4 84+8
ADDRLP4 128
INDIRI4
CVIF4 4
ASGNF4
line 105
;104:
;105:			cmodel = trap_CM_TempBoxModel( bmins, bmaxs );
ADDRLP4 72
ARGP4
ADDRLP4 84
ARGP4
ADDRLP4 140
ADDRGP4 trap_CM_TempBoxModel
CALLI4
ASGNI4
ADDRLP4 68
ADDRLP4 140
INDIRI4
ASGNI4
line 106
;106:			VectorCopy( vec3_origin, angles );
ADDRLP4 108
ADDRGP4 vec3_origin
INDIRB
ASGNB 12
line 107
;107:			VectorCopy( cent->lerpOrigin, origin );
ADDRLP4 96
ADDRLP4 60
INDIRP4
CNSTI4 704
ADDP4
INDIRB
ASGNB 12
line 108
;108:		}
LABELV $103
line 111
;109:
;110:
;111:		trap_CM_TransformedBoxTrace ( &trace, start, end,
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 68
INDIRI4
ARGI4
ADDRFP4 20
INDIRI4
ARGI4
ADDRLP4 96
ARGP4
ADDRLP4 108
ARGP4
ADDRGP4 trap_CM_TransformedBoxTrace
CALLV
pop
line 114
;112:			mins, maxs, cmodel,  mask, origin, angles);
;113:
;114:		if (trace.allsolid || trace.fraction < tr->fraction) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $112
ADDRLP4 4+8
INDIRF4
ADDRFP4 24
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
GEF4 $109
LABELV $112
line 115
;115:			trace.entityNum = ent->number;
ADDRLP4 4+52
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 116
;116:			*tr = trace;
ADDRFP4 24
INDIRP4
ADDRLP4 4
INDIRB
ASGNB 56
line 117
;117:		} else if (trace.startsolid) {
ADDRGP4 $110
JUMPV
LABELV $109
ADDRLP4 4+4
INDIRI4
CNSTI4 0
EQI4 $114
line 118
;118:			tr->startsolid = qtrue;
ADDRFP4 24
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 1
ASGNI4
line 119
;119:		}
LABELV $114
LABELV $110
line 120
;120:		if ( tr->allsolid ) {
ADDRFP4 24
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $117
line 121
;121:			return;
ADDRGP4 $95
JUMPV
LABELV $117
line 123
;122:		}
;123:	}
LABELV $97
line 75
ADDRLP4 64
ADDRLP4 64
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $99
ADDRLP4 64
INDIRI4
ADDRGP4 cg_numSolidEntities
INDIRI4
LTI4 $96
line 124
;124:}
LABELV $95
endproc CG_ClipMoveToEntities 144 36
export CG_Trace
proc CG_Trace 60 28
line 132
;125:
;126:/*
;127:================
;128:CG_Trace
;129:================
;130:*/
;131:void	CG_Trace( trace_t *result, const vec3_t start, const vec3_t mins, const vec3_t maxs, const vec3_t end, 
;132:					 int skipNumber, int mask ) {
line 135
;133:	trace_t	t;
;134:
;135:	trap_CM_BoxTrace ( &t, start, end, mins, maxs, 0, mask);
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRGP4 trap_CM_BoxTrace
CALLV
pop
line 136
;136:	t.entityNum = t.fraction != 1.0 ? ENTITYNUM_WORLD : ENTITYNUM_NONE;
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
EQF4 $123
ADDRLP4 56
CNSTI4 1022
ASGNI4
ADDRGP4 $124
JUMPV
LABELV $123
ADDRLP4 56
CNSTI4 1023
ASGNI4
LABELV $124
ADDRLP4 0+52
ADDRLP4 56
INDIRI4
ASGNI4
line 138
;137:	// check all other solid models
;138:	CG_ClipMoveToEntities (start, mins, maxs, end, skipNumber, mask, &t);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 20
INDIRI4
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 CG_ClipMoveToEntities
CALLV
pop
line 140
;139:
;140:	*result = t;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRB
ASGNB 56
line 141
;141:}
LABELV $119
endproc CG_Trace 60 28
proc CG_ClipMoveToEntities_Bitmask 148 36
line 159
;142:
;143:
;144:
;145:
;146:
;147:
;148:
;149:
;150:
;151:
;152:/*
;153:====================
;154:CG_ClipMoveToEntities_Bitmask
;155:
;156:====================
;157:*/
;158:static void CG_ClipMoveToEntities_Bitmask ( const vec3_t start, const vec3_t mins, const vec3_t maxs, const vec3_t end,
;159:							int skipNumber, int mask, trace_t *tr ) {
line 169
;160:	int			i, x, zd, zu;
;161:	trace_t		trace;
;162:	entityState_t	*ent;
;163:	clipHandle_t 	cmodel;
;164:	vec3_t		bmins, bmaxs;
;165:	vec3_t		origin, angles;
;166:	centity_t	*cent;
;167:	int			clients;
;168:
;169:	clients = 0;
ADDRLP4 132
CNSTI4 0
ASGNI4
line 171
;170:
;171:	for ( i = 0 ; i < cg_numSolidEntities ; i++ ) {
ADDRLP4 64
CNSTI4 0
ASGNI4
ADDRGP4 $129
JUMPV
LABELV $126
line 172
;172:		cent = cg_solidEntities[ i ];
ADDRLP4 60
ADDRLP4 64
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_solidEntities
ADDP4
INDIRP4
ASGNP4
line 173
;173:		ent = &cent->currentState;
ADDRLP4 0
ADDRLP4 60
INDIRP4
ASGNP4
line 181
;174:
;175:
;176:		//if (!AllowEntityInteraction(cent))
;177:		//	continue;
;178:
;179:
;180:
;181:		if ( ent->number == skipNumber ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRFP4 16
INDIRI4
NEI4 $130
line 182
;182:			continue;
ADDRGP4 $127
JUMPV
LABELV $130
line 185
;183:		}
;184:
;185:		if ( ent->solid == SOLID_BMODEL ) {
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 16777215
NEI4 $132
line 187
;186:			// special value for bmodel
;187:			cmodel = trap_CM_InlineModel( ent->modelindex );
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRLP4 136
ADDRGP4 trap_CM_InlineModel
CALLI4
ASGNI4
ADDRLP4 68
ADDRLP4 136
INDIRI4
ASGNI4
line 188
;188:			VectorCopy( cent->lerpAngles, angles );
ADDRLP4 108
ADDRLP4 60
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 189
;189:			BG_EvaluateTrajectory( &cent->currentState.pos, cg.physicsTime, origin );
ADDRLP4 60
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+107612
INDIRI4
ARGI4
ADDRLP4 96
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 190
;190:		} else {
ADDRGP4 $133
JUMPV
LABELV $132
line 192
;191:			// encoded bbox
;192:			x = (ent->solid & 255);
ADDRLP4 120
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 255
BANDI4
ASGNI4
line 193
;193:			zd = ((ent->solid>>8) & 255);
ADDRLP4 124
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 8
RSHI4
CNSTI4 255
BANDI4
ASGNI4
line 194
;194:			zu = ((ent->solid>>16) & 255) - 32;
ADDRLP4 128
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 16
RSHI4
CNSTI4 255
BANDI4
CNSTI4 32
SUBI4
ASGNI4
line 196
;195:
;196:			bmins[0] = bmins[1] = -x;
ADDRLP4 136
ADDRLP4 120
INDIRI4
NEGI4
CVIF4 4
ASGNF4
ADDRLP4 72+4
ADDRLP4 136
INDIRF4
ASGNF4
ADDRLP4 72
ADDRLP4 136
INDIRF4
ASGNF4
line 197
;197:			bmaxs[0] = bmaxs[1] = x;
ADDRLP4 140
ADDRLP4 120
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 84+4
ADDRLP4 140
INDIRF4
ASGNF4
ADDRLP4 84
ADDRLP4 140
INDIRF4
ASGNF4
line 198
;198:			bmins[2] = -zd;
ADDRLP4 72+8
ADDRLP4 124
INDIRI4
NEGI4
CVIF4 4
ASGNF4
line 199
;199:			bmaxs[2] = zu;
ADDRLP4 84+8
ADDRLP4 128
INDIRI4
CVIF4 4
ASGNF4
line 201
;200:
;201:			cmodel = trap_CM_TempBoxModel( bmins, bmaxs );
ADDRLP4 72
ARGP4
ADDRLP4 84
ARGP4
ADDRLP4 144
ADDRGP4 trap_CM_TempBoxModel
CALLI4
ASGNI4
ADDRLP4 68
ADDRLP4 144
INDIRI4
ASGNI4
line 202
;202:			VectorCopy( vec3_origin, angles );
ADDRLP4 108
ADDRGP4 vec3_origin
INDIRB
ASGNB 12
line 203
;203:			VectorCopy( cent->lerpOrigin, origin );
ADDRLP4 96
ADDRLP4 60
INDIRP4
CNSTI4 704
ADDP4
INDIRB
ASGNB 12
line 204
;204:		}
LABELV $133
line 207
;205:
;206:
;207:		trap_CM_TransformedBoxTrace ( &trace, start, end,
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 68
INDIRI4
ARGI4
ADDRFP4 20
INDIRI4
ARGI4
ADDRLP4 96
ARGP4
ADDRLP4 108
ARGP4
ADDRGP4 trap_CM_TransformedBoxTrace
CALLV
pop
line 210
;208:			mins, maxs, cmodel,  mask, origin, angles);
;209:
;210:		if (trace.allsolid || trace.fraction < tr->fraction) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $142
ADDRLP4 4+8
INDIRF4
ADDRFP4 24
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
GEF4 $139
LABELV $142
line 211
;211:			if (ent->number >= 0 && ent->number < 25)
ADDRLP4 136
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 0
LTI4 $140
ADDRLP4 136
INDIRI4
CNSTI4 25
GEI4 $140
line 212
;212:			{
line 213
;213:				clients |= 1 << ent->number;
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRP4
INDIRI4
LSHI4
BORI4
ASGNI4
line 214
;214:				tr->entityNum = clients;
ADDRFP4 24
INDIRP4
CNSTI4 52
ADDP4
ADDRLP4 132
INDIRI4
ASGNI4
line 215
;215:			}
line 217
;216:			//*tr = trace;
;217:		} else if (trace.startsolid) {
ADDRGP4 $140
JUMPV
LABELV $139
ADDRLP4 4+4
INDIRI4
CNSTI4 0
EQI4 $145
line 218
;218:			tr->startsolid = qtrue;
ADDRFP4 24
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 1
ASGNI4
line 219
;219:		}
LABELV $145
LABELV $140
line 224
;220:
;221:		//if ( trace->allsolid && trace.fraction >= tr->fraction ) {
;222:		//	return;
;223:		//}
;224:	}
LABELV $127
line 171
ADDRLP4 64
ADDRLP4 64
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $129
ADDRLP4 64
INDIRI4
ADDRGP4 cg_numSolidEntities
INDIRI4
LTI4 $126
line 225
;225:}
LABELV $125
endproc CG_ClipMoveToEntities_Bitmask 148 36
lit
align 4
LABELV $149
byte 4 0
skip 8
align 4
LABELV $150
byte 4 0
skip 8
export CG_Trace_Bitmask
code
proc CG_Trace_Bitmask 80 28
line 233
;226:
;227:/*
;228:================
;229:CG_Trace_Bitmask
;230:================
;231:*/
;232:void	CG_Trace_Bitmask( trace_t *result, const vec3_t start, const vec3_t mins, const vec3_t maxs, const vec3_t end, 
;233:					 int skipNumber, int mask ) {
line 236
;234:	trace_t	t;
;235:
;236:	vec3_t lmins = {0};
ADDRLP4 0
ADDRGP4 $149
INDIRB
ASGNB 12
line 237
;237:	vec3_t lmaxs = {0};
ADDRLP4 12
ADDRGP4 $150
INDIRB
ASGNB 12
line 239
;238:
;239:	lmins[0] = mins[0];
ADDRLP4 0
ADDRFP4 8
INDIRP4
INDIRF4
ASGNF4
line 240
;240:	lmins[1] = mins[1];
ADDRLP4 0+4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 241
;241:	lmins[2] = mins[2];
ADDRLP4 0+8
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
line 243
;242:
;243:	lmaxs[0] = maxs[0];
ADDRLP4 12
ADDRFP4 12
INDIRP4
INDIRF4
ASGNF4
line 244
;244:	lmaxs[1] = maxs[1];
ADDRLP4 12+4
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 245
;245:	lmaxs[2] = maxs[2];
ADDRLP4 12+8
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
line 247
;246:
;247:	trap_CM_BoxTrace ( &t, start, end, lmins, lmaxs, 0, mask);
ADDRLP4 24
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 0
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRGP4 trap_CM_BoxTrace
CALLV
pop
line 250
;248:	//t.entityNum = t.fraction != 1.0 ? ENTITYNUM_WORLD : ENTITYNUM_NONE;
;249:	// check all other solid models
;250:	t.entityNum = 0;
ADDRLP4 24+52
CNSTI4 0
ASGNI4
line 251
;251:	CG_ClipMoveToEntities_Bitmask (start, lmins, lmaxs, end, skipNumber, mask, &t);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 20
INDIRI4
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRGP4 CG_ClipMoveToEntities_Bitmask
CALLV
pop
line 253
;252:
;253:	*result = t;
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRB
ASGNB 56
line 254
;254:}
LABELV $148
endproc CG_Trace_Bitmask 80 28
export CG_PointContents
proc CG_PointContents 36 16
line 267
;255:
;256:
;257:
;258:
;259:
;260:
;261:
;262:/*
;263:================
;264:CG_PointContents
;265:================
;266:*/
;267:int		CG_PointContents( const vec3_t point, int passEntityNum ) {
line 274
;268:	int			i;
;269:	entityState_t	*ent;
;270:	centity_t	*cent;
;271:	clipHandle_t cmodel;
;272:	int			contents;
;273:
;274:	contents = trap_CM_PointContents (point, 0);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 20
ADDRGP4 trap_CM_PointContents
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 20
INDIRI4
ASGNI4
line 276
;275:
;276:	for ( i = 0 ; i < cg_numSolidEntities ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $160
JUMPV
LABELV $157
line 277
;277:		cent = cg_solidEntities[ i ];
ADDRLP4 12
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_solidEntities
ADDP4
INDIRP4
ASGNP4
line 279
;278:
;279:		ent = &cent->currentState;
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 281
;280:
;281:		if ( ent->number == passEntityNum ) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $161
line 282
;282:			continue;
ADDRGP4 $158
JUMPV
LABELV $161
line 285
;283:		}
;284:
;285:		if (ent->solid != SOLID_BMODEL) { // special value for bmodel
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 16777215
EQI4 $163
line 286
;286:			continue;
ADDRGP4 $158
JUMPV
LABELV $163
line 289
;287:		}
;288:
;289:		cmodel = trap_CM_InlineModel( ent->modelindex );
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 trap_CM_InlineModel
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 24
INDIRI4
ASGNI4
line 290
;290:		if ( !cmodel ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $165
line 291
;291:			continue;
ADDRGP4 $158
JUMPV
LABELV $165
line 294
;292:		}
;293:
;294:		contents |= trap_CM_TransformedPointContents( point, cmodel, ent->origin, ent->angles );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRLP4 32
ADDRGP4 trap_CM_TransformedPointContents
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 32
INDIRI4
BORI4
ASGNI4
line 295
;295:	}
LABELV $158
line 276
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $160
ADDRLP4 4
INDIRI4
ADDRGP4 cg_numSolidEntities
INDIRI4
LTI4 $157
line 297
;296:
;297:	return contents;
ADDRLP4 16
INDIRI4
RETI4
LABELV $156
endproc CG_PointContents 36 16
proc CG_InterpolatePlayerState 64 12
line 309
;298:}
;299:
;300:
;301:/*
;302:========================
;303:CG_InterpolatePlayerState
;304:
;305:Generates cg.predictedPlayerState by interpolating between
;306:cg.snap->player_state and cg.nextFrame->player_state
;307:========================
;308:*/
;309:static void CG_InterpolatePlayerState( qboolean grabAngles ) {
line 315
;310:	float			f;
;311:	int				i;
;312:	playerState_t	*out;
;313:	snapshot_t		*prev, *next;
;314:
;315:	out = &cg.predictedPlayerState;
ADDRLP4 12
ADDRGP4 cg+107636
ASGNP4
line 316
;316:	prev = cg.snap;
ADDRLP4 4
ADDRGP4 cg+36
INDIRP4
ASGNP4
line 317
;317:	next = cg.nextSnap;
ADDRLP4 8
ADDRGP4 cg+40
INDIRP4
ASGNP4
line 319
;318:
;319:	*out = cg.snap->ps;
ADDRLP4 12
INDIRP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
INDIRB
ASGNB 468
line 322
;320:
;321:	// if we are still allowing local input, short circuit the view angles
;322:	if ( grabAngles ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $172
line 326
;323:		usercmd_t	cmd;
;324:		int			cmdNum;
;325:
;326:		cmdNum = trap_GetCurrentCmdNumber();
ADDRLP4 48
ADDRGP4 trap_GetCurrentCmdNumber
CALLI4
ASGNI4
ADDRLP4 44
ADDRLP4 48
INDIRI4
ASGNI4
line 327
;327:		trap_GetUserCmd( cmdNum, &cmd );
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 20
ARGP4
ADDRGP4 trap_GetUserCmd
CALLI4
pop
line 329
;328:
;329:		PM_UpdateViewAngles( out, &cmd, 0 );
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 PM_UpdateViewAngles
CALLV
pop
line 330
;330:	}
LABELV $172
line 333
;331:
;332:	// if the next frame is a teleport, we can't lerp to it
;333:	if ( cg.nextFrameTeleport ) {
ADDRGP4 cg+107596
INDIRI4
CNSTI4 0
EQI4 $174
line 334
;334:		return;
ADDRGP4 $167
JUMPV
LABELV $174
line 337
;335:	}
;336:
;337:	if ( !next || next->serverTime <= prev->serverTime ) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $179
ADDRLP4 24
CNSTI4 8
ASGNI4
ADDRLP4 8
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
GTI4 $177
LABELV $179
line 338
;338:		return;
ADDRGP4 $167
JUMPV
LABELV $177
line 341
;339:	}
;340:
;341:	f = (float)( cg.time - prev->serverTime ) / ( next->serverTime - prev->serverTime );
ADDRLP4 28
CNSTI4 8
ASGNI4
ADDRLP4 32
ADDRLP4 4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 16
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 32
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 8
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
ADDRLP4 32
INDIRI4
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 343
;342:
;343:	i = next->ps.bobCycle;
ADDRLP4 0
ADDRLP4 8
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
ASGNI4
line 344
;344:	if ( i < prev->ps.bobCycle ) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
GEI4 $181
line 345
;345:		i += 256;		// handle wraparound
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 256
ADDI4
ASGNI4
line 346
;346:	}
LABELV $181
line 347
;347:	out->bobCycle = prev->ps.bobCycle + f * ( i - prev->ps.bobCycle );
ADDRLP4 36
ADDRLP4 4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 36
INDIRI4
CVIF4 4
ADDRLP4 16
INDIRF4
ADDRLP4 0
INDIRI4
ADDRLP4 36
INDIRI4
SUBI4
CVIF4 4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 349
;348:
;349:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $183
line 350
;350:		out->origin[i] = prev->ps.origin[i] + f * (next->ps.origin[i] - prev->ps.origin[i] );
ADDRLP4 40
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 44
CNSTI4 64
ASGNI4
ADDRLP4 48
ADDRLP4 40
INDIRI4
ADDRLP4 4
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 40
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 20
ADDP4
ADDP4
ADDRLP4 48
INDIRF4
ADDRLP4 16
INDIRF4
ADDRLP4 40
INDIRI4
ADDRLP4 8
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
ADDP4
INDIRF4
ADDRLP4 48
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 351
;351:		if ( !grabAngles ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $187
line 352
;352:			out->viewangles[i] = LerpAngle( prev->ps.viewangles[i], next->ps.viewangles[i], f );
ADDRLP4 52
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 56
CNSTI4 196
ASGNI4
ADDRLP4 52
INDIRI4
ADDRLP4 4
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 52
INDIRI4
ADDRLP4 8
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 60
ADDRGP4 LerpAngle
CALLF4
ASGNF4
ADDRLP4 52
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 152
ADDP4
ADDP4
ADDRLP4 60
INDIRF4
ASGNF4
line 353
;353:		}
LABELV $187
line 354
;354:		out->velocity[i] = prev->ps.velocity[i] + 
ADDRLP4 52
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 56
CNSTI4 76
ASGNI4
ADDRLP4 60
ADDRLP4 52
INDIRI4
ADDRLP4 4
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 52
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ADDRLP4 60
INDIRF4
ADDRLP4 16
INDIRF4
ADDRLP4 52
INDIRI4
ADDRLP4 8
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
ADDP4
INDIRF4
ADDRLP4 60
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 356
;355:			f * (next->ps.velocity[i] - prev->ps.velocity[i] );
;356:	}
LABELV $184
line 349
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $183
line 358
;357:
;358:}
LABELV $167
endproc CG_InterpolatePlayerState 64 12
proc CG_TouchItem 20 12
line 365
;359:
;360:/*
;361:===================
;362:CG_TouchItem
;363:===================
;364:*/
;365:static void CG_TouchItem( centity_t *cent ) {
line 369
;366:	gitem_t		*item;
;367:
;368:	//if ( (!cg_predictItems.integer) || (g_gamemode.integer != 0 || g_gamemode.integer != 4) ) {
;369:	if ( !cg_predictItems.integer ) {
ADDRGP4 cg_predictItems+12
INDIRI4
CNSTI4 0
NEI4 $190
line 370
;370:		return;
ADDRGP4 $189
JUMPV
LABELV $190
line 373
;371:	}
;372:
;373:	if ( cent->currentState.eFlags & EF_NODRAW ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $193
line 374
;374:		return;
ADDRGP4 $189
JUMPV
LABELV $193
line 379
;375:	}
;376:
;377:
;378:	//if ( !(cent->currentState.eFlags & EF_NODRAW) ) {
;379:		if ( !BG_PlayerTouchesItem( &cg.predictedPlayerState, &cent->currentState, cg.time ) ) {
ADDRGP4 cg+107636
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 BG_PlayerTouchesItem
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $195
line 380
;380:			return;
ADDRGP4 $189
JUMPV
LABELV $195
line 385
;381:		}
;382:	//}
;383:
;384:	// never pick an item up twice in a prediction
;385:	if ( cent->miscTime == cg.time ) {
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
NEI4 $199
line 386
;386:		return;
ADDRGP4 $189
JUMPV
LABELV $199
line 389
;387:	}
;388:
;389:	if ( !BG_CanItemBeGrabbed( cgs.gametype, &cent->currentState, &cg.predictedPlayerState ) ) {
ADDRGP4 cgs+31456
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cg+107636
ARGP4
ADDRLP4 8
ADDRGP4 BG_CanItemBeGrabbed
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $202
line 390
;390:		return;		// can't hold it
ADDRGP4 $189
JUMPV
LABELV $202
line 393
;391:	}
;392:
;393:	item = &bg_itemlist[ cent->currentState.modelindex ];
ADDRLP4 0
CNSTI4 52
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 405
;394:
;395:	// Special case for flags.  
;396:	// We don't predict touching our own flag
;397:#ifdef MISSIONPACK
;398:	if( cgs.gametype == GT_1FCTF ) {
;399:		if( item->giTag != PW_NEUTRALFLAG ) {
;400:			return;
;401:		}
;402:	}
;403:	if( cgs.gametype == GT_CTF || cgs.gametype == GT_HARVESTER ) {
;404:#else
;405:	if( cgs.gametype == GT_CTF ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
NEI4 $206
line 407
;406:#endif
;407:		if (cg.predictedPlayerState.persistant[PERS_TEAM] == TEAM_RED &&
ADDRGP4 cg+107636+248+12
INDIRI4
CNSTI4 1
NEI4 $209
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 7
NEI4 $209
line 409
;408:			item->giTag == PW_REDFLAG)
;409:			return;
ADDRGP4 $189
JUMPV
LABELV $209
line 410
;410:		if (cg.predictedPlayerState.persistant[PERS_TEAM] == TEAM_BLUE &&
ADDRGP4 cg+107636+248+12
INDIRI4
CNSTI4 2
NEI4 $214
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 8
NEI4 $214
line 412
;411:			item->giTag == PW_BLUEFLAG)
;412:			return;
ADDRGP4 $189
JUMPV
LABELV $214
line 413
;413:	}
LABELV $206
line 415
;414:
;415:	if ( cg.time < cg.naftInterval && cgs.gametype == GT_CTF && cg.lastHeldFlag == item->giTag ) {
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+162048
INDIRI4
GEI4 $219
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
NEI4 $219
ADDRGP4 cg+162052
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $219
line 416
;416:		return;
ADDRGP4 $189
JUMPV
LABELV $219
line 420
;417:	}
;418:
;419:	// grab it
;420:	BG_AddPredictableEventToPlayerstate( EV_ITEM_PICKUP, cent->currentState.modelindex , &cg.predictedPlayerState);
CNSTI4 19
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+107636
ARGP4
ADDRGP4 BG_AddPredictableEventToPlayerstate
CALLV
pop
line 423
;421:
;422:	// remove it from the frame so it won't be drawn
;423:	cent->currentState.eFlags |= EF_NODRAW;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 426
;424:
;425:	// don't touch it again this prediction
;426:	cent->miscTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 429
;427:
;428:	// if its a weapon, give them some predicted ammo so the autoswitch will work
;429:	if ( item->giType == IT_WEAPON ) {
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $227
line 430
;430:		cg.predictedPlayerState.stats[ STAT_WEAPONS ] |= 1 << item->giTag;
ADDRLP4 16
ADDRGP4 cg+107636+184+8
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
LSHI4
BORI4
ASGNI4
line 431
;431:		if ( !cg.predictedPlayerState.ammo[ item->giTag ] ) {
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107636+376
ADDP4
INDIRI4
CNSTI4 0
NEI4 $232
line 432
;432:			cg.predictedPlayerState.ammo[ item->giTag ] = 1;
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107636+376
ADDP4
CNSTI4 1
ASGNI4
line 433
;433:		}
LABELV $232
line 434
;434:	}
LABELV $227
line 435
;435:}
LABELV $189
endproc CG_TouchItem 20 12
proc CG_TouchTriggerPrediction 88 28
line 445
;436:
;437:
;438:/*
;439:=========================
;440:CG_TouchTriggerPrediction
;441:
;442:Predict push triggers and items
;443:=========================
;444:*/
;445:static void CG_TouchTriggerPrediction( void ) {
line 454
;446:	int			i;
;447:	trace_t		trace;
;448:	entityState_t	*ent;
;449:	clipHandle_t cmodel;
;450:	centity_t	*cent;
;451:	qboolean	spectator;
;452:
;453:	// dead clients don't activate triggers
;454:	if ( cg.predictedPlayerState.stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 cg+107636+184
INDIRI4
CNSTI4 0
GTI4 $239
line 455
;455:		return;
ADDRGP4 $238
JUMPV
LABELV $239
line 458
;456:	}
;457:
;458:	spectator = ( cg.predictedPlayerState.pm_type == PM_SPECTATOR );
ADDRGP4 cg+107636+4
INDIRI4
CNSTI4 2
NEI4 $246
ADDRLP4 76
CNSTI4 1
ASGNI4
ADDRGP4 $247
JUMPV
LABELV $246
ADDRLP4 76
CNSTI4 0
ASGNI4
LABELV $247
ADDRLP4 72
ADDRLP4 76
INDIRI4
ASGNI4
line 460
;459:
;460:	if ( cg.predictedPlayerState.pm_type != PM_NORMAL && !spectator ) {
ADDRLP4 80
CNSTI4 0
ASGNI4
ADDRGP4 cg+107636+4
INDIRI4
ADDRLP4 80
INDIRI4
EQI4 $248
ADDRLP4 72
INDIRI4
ADDRLP4 80
INDIRI4
NEI4 $248
line 461
;461:		return;
ADDRGP4 $238
JUMPV
LABELV $248
line 464
;462:	}
;463:
;464:	for ( i = 0 ; i < cg_numTriggerEntities ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $255
JUMPV
LABELV $252
line 465
;465:		cent = cg_triggerEntities[ i ];
ADDRLP4 12
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_triggerEntities
ADDP4
INDIRP4
ASGNP4
line 466
;466:		ent = &cent->currentState;
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 468
;467:
;468:		if ( ent->eType == ET_ITEM && !spectator ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $256
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $256
line 469
;469:			CG_TouchItem( cent );
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 CG_TouchItem
CALLV
pop
line 470
;470:			continue;
ADDRGP4 $253
JUMPV
LABELV $256
line 473
;471:		}
;472:
;473:		if ( ent->solid != SOLID_BMODEL ) {
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 16777215
EQI4 $258
line 474
;474:			continue;
ADDRGP4 $253
JUMPV
LABELV $258
line 477
;475:		}
;476:
;477:		cmodel = trap_CM_InlineModel( ent->modelindex );
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRLP4 84
ADDRGP4 trap_CM_InlineModel
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 84
INDIRI4
ASGNI4
line 478
;478:		if ( !cmodel ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $260
line 479
;479:			continue;
ADDRGP4 $253
JUMPV
LABELV $260
line 482
;480:		}
;481:
;482:		trap_CM_BoxTrace( &trace, cg.predictedPlayerState.origin, cg.predictedPlayerState.origin, 
ADDRLP4 16
ARGP4
ADDRGP4 cg+107636+20
ARGP4
ADDRGP4 cg+107636+20
ARGP4
ADDRGP4 cg_pmove+184
ARGP4
ADDRGP4 cg_pmove+196
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
CNSTI4 -1
ARGI4
ADDRGP4 trap_CM_BoxTrace
CALLV
pop
line 485
;483:			cg_pmove.mins, cg_pmove.maxs, cmodel, -1 );
;484:
;485:		if ( !trace.startsolid ) {
ADDRLP4 16+4
INDIRI4
CNSTI4 0
NEI4 $268
line 486
;486:			continue;
ADDRGP4 $253
JUMPV
LABELV $268
line 489
;487:		}
;488:
;489:		if ( ent->eType == ET_TELEPORT_TRIGGER ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 9
NEI4 $271
line 490
;490:			cg.hyperspace = qtrue;
ADDRGP4 cg+107632
CNSTI4 1
ASGNI4
line 491
;491:		} else if ( ent->eType == ET_PUSH_TRIGGER ) {
ADDRGP4 $272
JUMPV
LABELV $271
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 8
NEI4 $274
line 492
;492:			BG_TouchJumpPad( &cg.predictedPlayerState, ent );
ADDRGP4 cg+107636
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 BG_TouchJumpPad
CALLV
pop
line 493
;493:		}
LABELV $274
LABELV $272
line 494
;494:	}
LABELV $253
line 464
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $255
ADDRLP4 4
INDIRI4
ADDRGP4 cg_numTriggerEntities
INDIRI4
LTI4 $252
line 497
;495:
;496:	// if we didn't touch a jump pad this pmove frame
;497:	if ( cg.predictedPlayerState.jumppad_frame != cg.predictedPlayerState.pmove_framecount ) {
ADDRGP4 cg+107636+460
INDIRI4
ADDRGP4 cg+107636+456
INDIRI4
EQI4 $277
line 498
;498:		cg.predictedPlayerState.jumppad_frame = 0;
ADDRGP4 cg+107636+460
CNSTI4 0
ASGNI4
line 499
;499:		cg.predictedPlayerState.jumppad_ent = 0;
ADDRGP4 cg+107636+448
CNSTI4 0
ASGNI4
line 500
;500:	}
LABELV $277
line 501
;501:}
LABELV $238
endproc CG_TouchTriggerPrediction 88 28
proc IsUnacceptableError 316 8
line 506
;502:
;503://unlagged - optimized prediction
;504:#define ABS(x) ((x) < 0 ? (-(x)) : (x))
;505:
;506:static int IsUnacceptableError( playerState_t *ps, playerState_t *pps ) {
line 510
;507:	vec3_t delta;
;508:	int i;
;509:
;510:	if ( pps->pm_type != ps->pm_type ||
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20
CNSTI4 4
ASGNI4
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
ADDRLP4 24
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
NEI4 $291
ADDRLP4 28
CNSTI4 12
ASGNI4
ADDRLP4 16
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
ADDRLP4 24
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
NEI4 $291
ADDRLP4 32
CNSTI4 16
ASGNI4
ADDRLP4 16
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRI4
ADDRLP4 24
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRI4
EQI4 $288
LABELV $291
line 512
;511:			pps->pm_flags != ps->pm_flags ||
;512:			pps->pm_time != ps->pm_time ) {
line 513
;513:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $287
JUMPV
LABELV $288
line 516
;514:	}
;515:
;516:	VectorSubtract( pps->origin, ps->origin, delta );
ADDRLP4 36
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 40
CNSTI4 20
ASGNI4
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 36
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
ADDRLP4 44
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 48
CNSTI4 24
ASGNI4
ADDRLP4 4+4
ADDRLP4 36
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
ADDRLP4 44
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 52
CNSTI4 28
ASGNI4
ADDRLP4 4+8
ADDRFP4 4
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 517
;517:	if ( VectorLengthSquared( delta ) > 0.1f * 0.1f ) {
ADDRLP4 4
ARGP4
ADDRLP4 56
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 56
INDIRF4
CNSTF4 1008981770
LEF4 $294
line 518
;518:		if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $296
line 519
;519:			CG_Printf("delta: %.2f  ", VectorLength(delta) );
ADDRLP4 4
ARGP4
ADDRLP4 60
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRGP4 $299
ARGP4
ADDRLP4 60
INDIRF4
ARGF4
ADDRGP4 CG_Printf
CALLV
pop
line 520
;520:		}
LABELV $296
line 521
;521:		return 2;
CNSTI4 2
RETI4
ADDRGP4 $287
JUMPV
LABELV $294
line 524
;522:	}
;523:
;524:	VectorSubtract( pps->velocity, ps->velocity, delta );
ADDRLP4 60
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 64
CNSTI4 32
ASGNI4
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 60
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRF4
ADDRLP4 68
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 72
CNSTI4 36
ASGNI4
ADDRLP4 4+4
ADDRLP4 60
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRF4
ADDRLP4 68
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 76
CNSTI4 40
ASGNI4
ADDRLP4 4+8
ADDRFP4 4
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 525
;525:	if ( VectorLengthSquared( delta ) > 0.1f * 0.1f ) {
ADDRLP4 4
ARGP4
ADDRLP4 80
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 80
INDIRF4
CNSTF4 1008981770
LEF4 $302
line 526
;526:		if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $304
line 527
;527:			CG_Printf("delta: %.2f  ", VectorLength(delta) );
ADDRLP4 4
ARGP4
ADDRLP4 84
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRGP4 $299
ARGP4
ADDRLP4 84
INDIRF4
ARGF4
ADDRGP4 CG_Printf
CALLV
pop
line 528
;528:		}
LABELV $304
line 529
;529:		return 3;
CNSTI4 3
RETI4
ADDRGP4 $287
JUMPV
LABELV $302
line 532
;530:	}
;531:
;532:	if ( pps->weaponTime != ps->weaponTime ||
ADDRLP4 84
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 88
CNSTI4 44
ASGNI4
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRI4
ADDRLP4 92
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRI4
NEI4 $314
ADDRLP4 96
CNSTI4 48
ASGNI4
ADDRLP4 84
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
INDIRI4
ADDRLP4 92
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
INDIRI4
NEI4 $314
ADDRLP4 100
CNSTI4 52
ASGNI4
ADDRLP4 84
INDIRP4
ADDRLP4 100
INDIRI4
ADDP4
INDIRI4
ADDRLP4 92
INDIRP4
ADDRLP4 100
INDIRI4
ADDP4
INDIRI4
NEI4 $314
ADDRLP4 104
CNSTI4 56
ASGNI4
ADDRLP4 84
INDIRP4
ADDRLP4 104
INDIRI4
ADDP4
INDIRI4
ADDRLP4 92
INDIRP4
ADDRLP4 104
INDIRI4
ADDP4
INDIRI4
NEI4 $314
ADDRLP4 108
CNSTI4 60
ASGNI4
ADDRLP4 84
INDIRP4
ADDRLP4 108
INDIRI4
ADDP4
INDIRI4
ADDRLP4 92
INDIRP4
ADDRLP4 108
INDIRI4
ADDP4
INDIRI4
NEI4 $314
ADDRLP4 112
CNSTI4 64
ASGNI4
ADDRLP4 84
INDIRP4
ADDRLP4 112
INDIRI4
ADDP4
INDIRI4
ADDRLP4 92
INDIRP4
ADDRLP4 112
INDIRI4
ADDP4
INDIRI4
NEI4 $314
ADDRLP4 116
CNSTI4 68
ASGNI4
ADDRLP4 84
INDIRP4
ADDRLP4 116
INDIRI4
ADDP4
INDIRI4
ADDRLP4 92
INDIRP4
ADDRLP4 116
INDIRI4
ADDP4
INDIRI4
EQI4 $307
LABELV $314
line 538
;533:			pps->gravity != ps->gravity ||
;534:			pps->speed != ps->speed ||
;535:			pps->delta_angles[0] != ps->delta_angles[0] ||
;536:			pps->delta_angles[1] != ps->delta_angles[1] ||
;537:			pps->delta_angles[2] != ps->delta_angles[2] || 
;538:			pps->groundEntityNum != ps->groundEntityNum ) {
line 539
;539:		return 4;
CNSTI4 4
RETI4
ADDRGP4 $287
JUMPV
LABELV $307
line 542
;540:	}
;541:
;542:	if ( pps->legsTimer != ps->legsTimer ||
ADDRLP4 120
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 124
CNSTI4 72
ASGNI4
ADDRLP4 128
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 120
INDIRP4
ADDRLP4 124
INDIRI4
ADDP4
INDIRI4
ADDRLP4 128
INDIRP4
ADDRLP4 124
INDIRI4
ADDP4
INDIRI4
NEI4 $320
ADDRLP4 132
CNSTI4 76
ASGNI4
ADDRLP4 120
INDIRP4
ADDRLP4 132
INDIRI4
ADDP4
INDIRI4
ADDRLP4 128
INDIRP4
ADDRLP4 132
INDIRI4
ADDP4
INDIRI4
NEI4 $320
ADDRLP4 136
CNSTI4 80
ASGNI4
ADDRLP4 120
INDIRP4
ADDRLP4 136
INDIRI4
ADDP4
INDIRI4
ADDRLP4 128
INDIRP4
ADDRLP4 136
INDIRI4
ADDP4
INDIRI4
NEI4 $320
ADDRLP4 140
CNSTI4 84
ASGNI4
ADDRLP4 120
INDIRP4
ADDRLP4 140
INDIRI4
ADDP4
INDIRI4
ADDRLP4 128
INDIRP4
ADDRLP4 140
INDIRI4
ADDP4
INDIRI4
NEI4 $320
ADDRLP4 144
CNSTI4 88
ASGNI4
ADDRLP4 120
INDIRP4
ADDRLP4 144
INDIRI4
ADDP4
INDIRI4
ADDRLP4 128
INDIRP4
ADDRLP4 144
INDIRI4
ADDP4
INDIRI4
EQI4 $315
LABELV $320
line 546
;543:			pps->legsAnim != ps->legsAnim ||
;544:			pps->torsoTimer != ps->torsoTimer ||
;545:			pps->torsoAnim != ps->torsoAnim ||
;546:			pps->movementDir != ps->movementDir ) {
line 547
;547:		return 5;
CNSTI4 5
RETI4
ADDRGP4 $287
JUMPV
LABELV $315
line 550
;548:	}
;549:
;550:	VectorSubtract( pps->grapplePoint, ps->grapplePoint, delta );
ADDRLP4 148
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 152
CNSTI4 92
ASGNI4
ADDRLP4 156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 148
INDIRP4
ADDRLP4 152
INDIRI4
ADDP4
INDIRF4
ADDRLP4 156
INDIRP4
ADDRLP4 152
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 160
CNSTI4 96
ASGNI4
ADDRLP4 4+4
ADDRLP4 148
INDIRP4
ADDRLP4 160
INDIRI4
ADDP4
INDIRF4
ADDRLP4 156
INDIRP4
ADDRLP4 160
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 164
CNSTI4 100
ASGNI4
ADDRLP4 4+8
ADDRFP4 4
INDIRP4
ADDRLP4 164
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 164
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 551
;551:	if ( VectorLengthSquared( delta ) > 0.1f * 0.1f ) {
ADDRLP4 4
ARGP4
ADDRLP4 168
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 168
INDIRF4
CNSTF4 1008981770
LEF4 $323
line 552
;552:		return 6;
CNSTI4 6
RETI4
ADDRGP4 $287
JUMPV
LABELV $323
line 555
;553:	}
;554:
;555:	if ( pps->eFlags != ps->eFlags ) {
ADDRLP4 172
CNSTI4 104
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 172
INDIRI4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 172
INDIRI4
ADDP4
INDIRI4
EQI4 $325
line 556
;556:		return 7;
CNSTI4 7
RETI4
ADDRGP4 $287
JUMPV
LABELV $325
line 559
;557:	}
;558:
;559:	if ( pps->eventSequence != ps->eventSequence ) {
ADDRLP4 176
CNSTI4 108
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 176
INDIRI4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 176
INDIRI4
ADDP4
INDIRI4
EQI4 $327
line 560
;560:		return 8;
CNSTI4 8
RETI4
ADDRGP4 $287
JUMPV
LABELV $327
line 563
;561:	}
;562:
;563:	for ( i = 0; i < MAX_PS_EVENTS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $329
line 564
;564:		if ( pps->events[i] != ps->events[i] ||
ADDRLP4 180
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 184
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 188
CNSTI4 112
ASGNI4
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 180
INDIRI4
ADDRLP4 184
INDIRP4
ADDRLP4 188
INDIRI4
ADDP4
ADDP4
INDIRI4
ADDRLP4 180
INDIRI4
ADDRLP4 192
INDIRP4
ADDRLP4 188
INDIRI4
ADDP4
ADDP4
INDIRI4
NEI4 $335
ADDRLP4 196
CNSTI4 120
ASGNI4
ADDRLP4 180
INDIRI4
ADDRLP4 184
INDIRP4
ADDRLP4 196
INDIRI4
ADDP4
ADDP4
INDIRI4
ADDRLP4 180
INDIRI4
ADDRLP4 192
INDIRP4
ADDRLP4 196
INDIRI4
ADDP4
ADDP4
INDIRI4
EQI4 $333
LABELV $335
line 565
;565:				pps->eventParms[i] != ps->eventParms[i] ) {
line 566
;566:			return 9;
CNSTI4 9
RETI4
ADDRGP4 $287
JUMPV
LABELV $333
line 568
;567:		}
;568:	}
LABELV $330
line 563
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $329
line 570
;569:
;570:	if ( pps->externalEvent != ps->externalEvent ||
ADDRLP4 180
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 184
CNSTI4 128
ASGNI4
ADDRLP4 188
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 180
INDIRP4
ADDRLP4 184
INDIRI4
ADDP4
INDIRI4
ADDRLP4 188
INDIRP4
ADDRLP4 184
INDIRI4
ADDP4
INDIRI4
NEI4 $339
ADDRLP4 192
CNSTI4 132
ASGNI4
ADDRLP4 180
INDIRP4
ADDRLP4 192
INDIRI4
ADDP4
INDIRI4
ADDRLP4 188
INDIRP4
ADDRLP4 192
INDIRI4
ADDP4
INDIRI4
NEI4 $339
ADDRLP4 196
CNSTI4 136
ASGNI4
ADDRLP4 180
INDIRP4
ADDRLP4 196
INDIRI4
ADDP4
INDIRI4
ADDRLP4 188
INDIRP4
ADDRLP4 196
INDIRI4
ADDP4
INDIRI4
EQI4 $336
LABELV $339
line 572
;571:			pps->externalEventParm != ps->externalEventParm ||
;572:			pps->externalEventTime != ps->externalEventTime ) {
line 573
;573:		return 10;
CNSTI4 10
RETI4
ADDRGP4 $287
JUMPV
LABELV $336
line 576
;574:	}
;575:
;576:	if ( pps->clientNum != ps->clientNum ||
ADDRLP4 200
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 204
CNSTI4 140
ASGNI4
ADDRLP4 208
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
INDIRP4
ADDRLP4 204
INDIRI4
ADDP4
INDIRI4
ADDRLP4 208
INDIRP4
ADDRLP4 204
INDIRI4
ADDP4
INDIRI4
NEI4 $343
ADDRLP4 212
CNSTI4 144
ASGNI4
ADDRLP4 200
INDIRP4
ADDRLP4 212
INDIRI4
ADDP4
INDIRI4
ADDRLP4 208
INDIRP4
ADDRLP4 212
INDIRI4
ADDP4
INDIRI4
NEI4 $343
ADDRLP4 216
CNSTI4 148
ASGNI4
ADDRLP4 200
INDIRP4
ADDRLP4 216
INDIRI4
ADDP4
INDIRI4
ADDRLP4 208
INDIRP4
ADDRLP4 216
INDIRI4
ADDP4
INDIRI4
EQI4 $340
LABELV $343
line 578
;577:			pps->weapon != ps->weapon ||
;578:			pps->weaponstate != ps->weaponstate ) {
line 579
;579:		return 11;
CNSTI4 11
RETI4
ADDRGP4 $287
JUMPV
LABELV $340
line 582
;580:	}
;581:
;582:	if ( ABS(pps->viewangles[0] - ps->viewangles[0]) > 1.0f ||
ADDRLP4 232
CNSTI4 152
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 232
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 232
INDIRI4
ADDP4
INDIRF4
SUBF4
CNSTF4 0
GEF4 $350
ADDRLP4 236
CNSTI4 152
ASGNI4
ADDRLP4 220
ADDRFP4 4
INDIRP4
ADDRLP4 236
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 236
INDIRI4
ADDP4
INDIRF4
SUBF4
NEGF4
ASGNF4
ADDRGP4 $351
JUMPV
LABELV $350
ADDRLP4 240
CNSTI4 152
ASGNI4
ADDRLP4 220
ADDRFP4 4
INDIRP4
ADDRLP4 240
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 240
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
LABELV $351
ADDRLP4 220
INDIRF4
CNSTF4 1065353216
GTF4 $352
ADDRLP4 244
CNSTI4 156
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 244
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 244
INDIRI4
ADDP4
INDIRF4
SUBF4
CNSTF4 0
GEF4 $353
ADDRLP4 248
CNSTI4 156
ASGNI4
ADDRLP4 224
ADDRFP4 4
INDIRP4
ADDRLP4 248
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 248
INDIRI4
ADDP4
INDIRF4
SUBF4
NEGF4
ASGNF4
ADDRGP4 $354
JUMPV
LABELV $353
ADDRLP4 252
CNSTI4 156
ASGNI4
ADDRLP4 224
ADDRFP4 4
INDIRP4
ADDRLP4 252
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 252
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
LABELV $354
ADDRLP4 224
INDIRF4
CNSTF4 1065353216
GTF4 $352
ADDRLP4 256
CNSTI4 160
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 256
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 256
INDIRI4
ADDP4
INDIRF4
SUBF4
CNSTF4 0
GEF4 $355
ADDRLP4 260
CNSTI4 160
ASGNI4
ADDRLP4 228
ADDRFP4 4
INDIRP4
ADDRLP4 260
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 260
INDIRI4
ADDP4
INDIRF4
SUBF4
NEGF4
ASGNF4
ADDRGP4 $356
JUMPV
LABELV $355
ADDRLP4 264
CNSTI4 160
ASGNI4
ADDRLP4 228
ADDRFP4 4
INDIRP4
ADDRLP4 264
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 264
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
LABELV $356
ADDRLP4 228
INDIRF4
CNSTF4 1065353216
LEF4 $344
LABELV $352
line 584
;583:			ABS(pps->viewangles[1] - ps->viewangles[1]) > 1.0f ||
;584:			ABS(pps->viewangles[2] - ps->viewangles[2]) > 1.0f ) {
line 585
;585:		return 12;
CNSTI4 12
RETI4
ADDRGP4 $287
JUMPV
LABELV $344
line 588
;586:	}
;587:
;588:	if ( pps->viewheight != ps->viewheight ) {
ADDRLP4 268
CNSTI4 164
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 268
INDIRI4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 268
INDIRI4
ADDP4
INDIRI4
EQI4 $357
line 589
;589:		return 13;
CNSTI4 13
RETI4
ADDRGP4 $287
JUMPV
LABELV $357
line 592
;590:	}
;591:
;592:	if ( pps->damageEvent != ps->damageEvent ||
ADDRLP4 272
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 276
CNSTI4 168
ASGNI4
ADDRLP4 280
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 272
INDIRP4
ADDRLP4 276
INDIRI4
ADDP4
INDIRI4
ADDRLP4 280
INDIRP4
ADDRLP4 276
INDIRI4
ADDP4
INDIRI4
NEI4 $363
ADDRLP4 284
CNSTI4 172
ASGNI4
ADDRLP4 272
INDIRP4
ADDRLP4 284
INDIRI4
ADDP4
INDIRI4
ADDRLP4 280
INDIRP4
ADDRLP4 284
INDIRI4
ADDP4
INDIRI4
NEI4 $363
ADDRLP4 288
CNSTI4 176
ASGNI4
ADDRLP4 272
INDIRP4
ADDRLP4 288
INDIRI4
ADDP4
INDIRI4
ADDRLP4 280
INDIRP4
ADDRLP4 288
INDIRI4
ADDP4
INDIRI4
NEI4 $363
ADDRLP4 292
CNSTI4 180
ASGNI4
ADDRLP4 272
INDIRP4
ADDRLP4 292
INDIRI4
ADDP4
INDIRI4
ADDRLP4 280
INDIRP4
ADDRLP4 292
INDIRI4
ADDP4
INDIRI4
EQI4 $359
LABELV $363
line 595
;593:			pps->damageYaw != ps->damageYaw ||
;594:			pps->damagePitch != ps->damagePitch ||
;595:			pps->damageCount != ps->damageCount ) {
line 596
;596:		return 14;
CNSTI4 14
RETI4
ADDRGP4 $287
JUMPV
LABELV $359
line 599
;597:	}
;598:
;599:	for ( i = 0; i < MAX_STATS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $364
line 600
;600:		if ( pps->stats[i] != ps->stats[i] ) {
ADDRLP4 296
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 300
CNSTI4 184
ASGNI4
ADDRLP4 296
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 300
INDIRI4
ADDP4
ADDP4
INDIRI4
ADDRLP4 296
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 300
INDIRI4
ADDP4
ADDP4
INDIRI4
EQI4 $368
line 601
;601:			return 15;
CNSTI4 15
RETI4
ADDRGP4 $287
JUMPV
LABELV $368
line 603
;602:		}
;603:	}
LABELV $365
line 599
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $364
line 605
;604:
;605:	for ( i = 0; i < MAX_PERSISTANT; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $370
line 606
;606:		if ( pps->persistant[i] != ps->persistant[i] ) {
ADDRLP4 296
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 300
CNSTI4 248
ASGNI4
ADDRLP4 296
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 300
INDIRI4
ADDP4
ADDP4
INDIRI4
ADDRLP4 296
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 300
INDIRI4
ADDP4
ADDP4
INDIRI4
EQI4 $374
line 607
;607:			return 16;
CNSTI4 16
RETI4
ADDRGP4 $287
JUMPV
LABELV $374
line 609
;608:		}
;609:	}
LABELV $371
line 605
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $370
line 611
;610:
;611:	for ( i = 0; i < MAX_POWERUPS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $376
line 612
;612:		if ( pps->powerups[i] != ps->powerups[i] ) {
ADDRLP4 296
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 300
CNSTI4 312
ASGNI4
ADDRLP4 296
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 300
INDIRI4
ADDP4
ADDP4
INDIRI4
ADDRLP4 296
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 300
INDIRI4
ADDP4
ADDP4
INDIRI4
EQI4 $380
line 613
;613:			return 17;
CNSTI4 17
RETI4
ADDRGP4 $287
JUMPV
LABELV $380
line 615
;614:		}
;615:	}
LABELV $377
line 611
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $376
line 617
;616:
;617:	for ( i = 0; i < MAX_WEAPONS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $382
line 618
;618:		if ( pps->ammo[i] != ps->ammo[i] ) {
ADDRLP4 296
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 300
CNSTI4 376
ASGNI4
ADDRLP4 296
INDIRI4
ADDRFP4 4
INDIRP4
ADDRLP4 300
INDIRI4
ADDP4
ADDP4
INDIRI4
ADDRLP4 296
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 300
INDIRI4
ADDP4
ADDP4
INDIRI4
EQI4 $386
line 619
;619:			return 18;
CNSTI4 18
RETI4
ADDRGP4 $287
JUMPV
LABELV $386
line 621
;620:		}
;621:	}
LABELV $383
line 617
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $382
line 623
;622:
;623:	if ( pps->generic1 != ps->generic1 ||
ADDRLP4 296
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 300
CNSTI4 440
ASGNI4
ADDRLP4 304
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 296
INDIRP4
ADDRLP4 300
INDIRI4
ADDP4
INDIRI4
ADDRLP4 304
INDIRP4
ADDRLP4 300
INDIRI4
ADDP4
INDIRI4
NEI4 $391
ADDRLP4 308
CNSTI4 444
ASGNI4
ADDRLP4 296
INDIRP4
ADDRLP4 308
INDIRI4
ADDP4
INDIRI4
ADDRLP4 304
INDIRP4
ADDRLP4 308
INDIRI4
ADDP4
INDIRI4
NEI4 $391
ADDRLP4 312
CNSTI4 448
ASGNI4
ADDRLP4 296
INDIRP4
ADDRLP4 312
INDIRI4
ADDP4
INDIRI4
ADDRLP4 304
INDIRP4
ADDRLP4 312
INDIRI4
ADDP4
INDIRI4
EQI4 $388
LABELV $391
line 625
;624:			pps->loopSound != ps->loopSound ||
;625:			pps->jumppad_ent != ps->jumppad_ent ) {
line 626
;626:		return 19;
CNSTI4 19
RETI4
ADDRGP4 $287
JUMPV
LABELV $388
line 629
;627:	}
;628:
;629:	return 0;
CNSTI4 0
RETI4
LABELV $287
endproc IsUnacceptableError 316 8
export CG_PredictPlayerState
proc CG_PredictPlayerState 612 20
line 659
;630:}
;631://unlagged - optimized prediction
;632:
;633:/*
;634:=================
;635:CG_PredictPlayerState
;636:
;637:Generates cg.predictedPlayerState for the current cg.time
;638:cg.predictedPlayerState is guaranteed to be valid after exiting.
;639:
;640:For demo playback, this will be an interpolation between two valid
;641:playerState_t.
;642:
;643:For normal gameplay, it will be the result of predicted usercmd_t on
;644:top of the most recent playerState_t received from the server.
;645:
;646:Each new snapshot will usually have one or more new usercmd over the last,
;647:but we simulate all unacknowledged commands each time, not just the new ones.
;648:This means that on an internet connection, quite a few pmoves may be issued
;649:each frame.
;650:
;651:OPTIMIZE: don't re-simulate unless the newly arrived snapshot playerState_t
;652:differs from the predicted one.  Would require saving all intermediate
;653:playerState_t during prediction.
;654:
;655:We detect prediction errors and allow them to be decayed off over several frames
;656:to ease the jerk.
;657:=================
;658:*/
;659:void CG_PredictPlayerState( void ) {
line 669
;660:	int			cmdNum, current;
;661:	playerState_t	oldPlayerState;
;662:	qboolean	moved;
;663:	usercmd_t	oldestCmd;
;664:	usercmd_t	latestCmd;
;665:	int			clientsHit;
;666:
;667://unlagged - optimized prediction
;668:	int stateIndex, predictCmd;
;669:	int numPredicted = 0, numPlayedBack = 0; // debug code
ADDRLP4 508
CNSTI4 0
ASGNI4
ADDRLP4 516
CNSTI4 0
ASGNI4
line 672
;670://unlagged - optimized prediction
;671:
;672:	cg.hyperspace = qfalse;	// will be set if touching a trigger_teleport
ADDRGP4 cg+107632
CNSTI4 0
ASGNI4
line 677
;673:
;674:	// if this is the first frame we must guarantee
;675:	// predictedPlayerState is valid even if there is some
;676:	// other error condition
;677:	if ( !cg.validPPS ) {
ADDRGP4 cg+108832
INDIRI4
CNSTI4 0
NEI4 $394
line 678
;678:		cg.validPPS = qtrue;
ADDRGP4 cg+108832
CNSTI4 1
ASGNI4
line 679
;679:		cg.predictedPlayerState = cg.snap->ps;
ADDRGP4 cg+107636
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
INDIRB
ASGNB 468
line 680
;680:	}
LABELV $394
line 683
;681:
;682:	// demo playback just copies the moves
;683:	if ( cg.demoPlayback || (cg.snap->ps.pm_flags & PMF_FOLLOW) ) {
ADDRLP4 548
CNSTI4 0
ASGNI4
ADDRGP4 cg+8
INDIRI4
ADDRLP4 548
INDIRI4
NEI4 $404
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
ADDRLP4 548
INDIRI4
EQI4 $400
LABELV $404
line 684
;684:		CG_InterpolatePlayerState( qfalse );
CNSTI4 0
ARGI4
ADDRGP4 CG_InterpolatePlayerState
CALLV
pop
line 685
;685:		return;
ADDRGP4 $392
JUMPV
LABELV $400
line 689
;686:	}
;687:
;688:	// non-predicting local movement will grab the latest angles
;689:	if ( cg_nopredict.integer || cg_synchronousClients.integer ) {
ADDRLP4 552
CNSTI4 0
ASGNI4
ADDRGP4 cg_nopredict+12
INDIRI4
ADDRLP4 552
INDIRI4
NEI4 $409
ADDRGP4 cg_synchronousClients+12
INDIRI4
ADDRLP4 552
INDIRI4
EQI4 $405
LABELV $409
line 690
;690:		CG_InterpolatePlayerState( qtrue );
CNSTI4 1
ARGI4
ADDRGP4 CG_InterpolatePlayerState
CALLV
pop
line 691
;691:		return;
ADDRGP4 $392
JUMPV
LABELV $405
line 695
;692:	}
;693:
;694:	// prepare for pmove
;695:	cg_pmove.ps = &cg.predictedPlayerState;
ADDRGP4 cg_pmove
ADDRGP4 cg+107636
ASGNP4
line 696
;696:	cg_pmove.trace = CG_Trace;
ADDRGP4 cg_pmove+236
ADDRGP4 CG_Trace
ASGNP4
line 697
;697:	cg_pmove.pointcontents = CG_PointContents;
ADDRGP4 cg_pmove+240
ADDRGP4 CG_PointContents
ASGNP4
line 698
;698:	if ( cg_pmove.ps->pm_type == PM_DEAD ) {
ADDRGP4 cg_pmove
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $413
line 699
;699:		cg_pmove.tracemask = MASK_PLAYERSOLID & ~CONTENTS_BODY;
ADDRGP4 cg_pmove+28
CNSTI4 65537
ASGNI4
line 700
;700:	} else {
ADDRGP4 $414
JUMPV
LABELV $413
line 701
;701:		cg_pmove.tracemask = MASK_PLAYERSOLID;
ADDRGP4 cg_pmove+28
CNSTI4 33619969
ASGNI4
line 702
;702:	}
LABELV $414
line 703
;703:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $417
line 704
;704:		cg_pmove.tracemask &= ~CONTENTS_BODY;	// spectators can fly through bodies
ADDRLP4 556
ADDRGP4 cg_pmove+28
ASGNP4
ADDRLP4 556
INDIRP4
ADDRLP4 556
INDIRP4
INDIRI4
CNSTI4 -33554433
BANDI4
ASGNI4
line 705
;705:	}
LABELV $417
line 706
;706:	cg_pmove.noFootsteps = ( cgs.dmflags & DF_NO_FOOTSTEPS ) > 0;
ADDRGP4 cgs+31460
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
LEI4 $424
ADDRLP4 556
CNSTI4 1
ASGNI4
ADDRGP4 $425
JUMPV
LABELV $424
ADDRLP4 556
CNSTI4 0
ASGNI4
LABELV $425
ADDRGP4 cg_pmove+36
ADDRLP4 556
INDIRI4
ASGNI4
line 709
;707:
;708:	// save the state before the pmove so we can detect transitions
;709:	oldPlayerState = cg.predictedPlayerState;
ADDRLP4 8
ADDRGP4 cg+107636
INDIRB
ASGNB 468
line 711
;710:
;711:	current = trap_GetCurrentCmdNumber();
ADDRLP4 560
ADDRGP4 trap_GetCurrentCmdNumber
CALLI4
ASGNI4
ADDRLP4 476
ADDRLP4 560
INDIRI4
ASGNI4
line 716
;712:
;713:	// if we don't have the commands right after the snapshot, we
;714:	// can't accurately predict a current position, so just freeze at
;715:	// the last good position we had
;716:	cmdNum = current - CMD_BACKUP + 1;
ADDRLP4 0
ADDRLP4 476
INDIRI4
CNSTI4 64
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 717
;717:	trap_GetUserCmd( cmdNum, &oldestCmd );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 520
ARGP4
ADDRGP4 trap_GetUserCmd
CALLI4
pop
line 718
;718:	if ( oldestCmd.serverTime > cg.snap->ps.commandTime 
ADDRLP4 564
ADDRLP4 520
INDIRI4
ASGNI4
ADDRLP4 564
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
LEI4 $427
ADDRLP4 564
INDIRI4
ADDRGP4 cg+107604
INDIRI4
GEI4 $427
line 719
;719:		&& oldestCmd.serverTime < cg.time ) {	// special check for map_restart
line 720
;720:		if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $392
line 721
;721:			CG_Printf ("exceeded PACKET_BACKUP on commands\n");
ADDRGP4 $434
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 722
;722:		}
line 723
;723:		return;
ADDRGP4 $392
JUMPV
LABELV $427
line 727
;724:	}
;725:
;726:	// get the latest command so we can know which commands are from previous map_restarts
;727:	trap_GetUserCmd( current, &latestCmd );
ADDRLP4 476
INDIRI4
ARGI4
ADDRLP4 484
ARGP4
ADDRGP4 trap_GetUserCmd
CALLI4
pop
line 733
;728:
;729:	// get the most recent information we have, even if
;730:	// the server time is beyond our current cg.time,
;731:	// because predicted player positions are going to 
;732:	// be ahead of everything else anyway
;733:	if ( cg.nextSnap && !cg.nextFrameTeleport && !cg.thisFrameTeleport ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $435
ADDRLP4 568
CNSTI4 0
ASGNI4
ADDRGP4 cg+107596
INDIRI4
ADDRLP4 568
INDIRI4
NEI4 $435
ADDRGP4 cg+107592
INDIRI4
ADDRLP4 568
INDIRI4
NEI4 $435
line 734
;734:		cg.predictedPlayerState = cg.nextSnap->ps;
ADDRGP4 cg+107636
ADDRGP4 cg+40
INDIRP4
CNSTI4 44
ADDP4
INDIRB
ASGNB 468
line 735
;735:		cg.physicsTime = cg.nextSnap->serverTime;
ADDRGP4 cg+107612
ADDRGP4 cg+40
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 736
;736:	} else {
ADDRGP4 $436
JUMPV
LABELV $435
line 737
;737:		cg.predictedPlayerState = cg.snap->ps;
ADDRGP4 cg+107636
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
INDIRB
ASGNB 468
line 738
;738:		cg.physicsTime = cg.snap->serverTime;
ADDRGP4 cg+107612
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 739
;739:	}
LABELV $436
line 741
;740:
;741:	if ( pmove_msec.integer < 8 ) {
ADDRGP4 pmove_msec+12
INDIRI4
CNSTI4 8
GEI4 $448
line 742
;742:		trap_Cvar_Set("pmove_msec", "8");
ADDRGP4 $451
ARGP4
ADDRGP4 $452
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 743
;743:	}
ADDRGP4 $449
JUMPV
LABELV $448
line 744
;744:	else if (pmove_msec.integer > 33) {
ADDRGP4 pmove_msec+12
INDIRI4
CNSTI4 33
LEI4 $453
line 745
;745:		trap_Cvar_Set("pmove_msec", "33");
ADDRGP4 $451
ARGP4
ADDRGP4 $456
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 746
;746:	}
LABELV $453
LABELV $449
line 749
;747:
;748:	//cg_pmove.pmove_fixed = pmove_fixed.integer;// | cg_pmove_fixed.integer;
;749:	if ( sv_lock_pmove.integer == 1 ) {
ADDRGP4 sv_lock_pmove+12
INDIRI4
CNSTI4 1
NEI4 $457
line 750
;750:		cg_pmove.pmove_fixed = pmove_fixed.integer;
ADDRGP4 cg_pmove+220
ADDRGP4 pmove_fixed+12
INDIRI4
ASGNI4
line 751
;751:	} else {
ADDRGP4 $458
JUMPV
LABELV $457
line 752
;752:		cg_pmove.pmove_fixed = cg_pmove_fixed.integer;
ADDRGP4 cg_pmove+220
ADDRGP4 cg_pmove_fixed+12
INDIRI4
ASGNI4
line 753
;753:	}
LABELV $458
line 754
;754:	cg_pmove.pmove_msec = pmove_msec.integer;
ADDRGP4 cg_pmove+224
ADDRGP4 pmove_msec+12
INDIRI4
ASGNI4
line 776
;755://unlagged - optimized prediction
;756:	// Like the comments described above, a player's state is entirely
;757:	// re-predicted from the last valid snapshot every client frame, which
;758:	// can be really, really, really slow.  Every old command has to be
;759:	// run again.  For every client frame that is *not* directly after a
;760:	// snapshot, this is unnecessary, since we have no new information.
;761:	// For those, we'll play back the predictions from the last frame and
;762:	// predict only the newest commands.  Essentially, we'll be doing
;763:	// an incremental predict instead of a full predict.
;764:	//
;765:	// If we have a new snapshot, we can compare its player state's command
;766:	// time to the command times in the queue to find a match.  If we find
;767:	// a matching state, and the predicted version has not deviated, we can
;768:	// use the predicted state as a base - and also do an incremental predict.
;769:	//
;770:	// With this method, we get incremental predicts on every client frame
;771:	// except a frame following a new snapshot in which there was a prediction
;772:	// error.  This yeilds anywhere from a 15% to 40% performance increase,
;773:	// depending on how much of a bottleneck the CPU is.
;774:
;775:	// we check for cg_latentCmds because it'll mess up the optimization
;776:	if ( cg_optimizePrediction.integer ) {
ADDRGP4 cg_optimizePrediction+12
INDIRI4
CNSTI4 0
EQI4 $466
line 777
;777:		if ( cg.nextFrameTeleport || cg.thisFrameTeleport ) {
ADDRLP4 572
CNSTI4 0
ASGNI4
ADDRGP4 cg+107596
INDIRI4
ADDRLP4 572
INDIRI4
NEI4 $473
ADDRGP4 cg+107592
INDIRI4
ADDRLP4 572
INDIRI4
EQI4 $469
LABELV $473
line 779
;778:			// do a full predict
;779:			cg.lastPredictedCommand = 0;
ADDRGP4 cg+131144
CNSTI4 0
ASGNI4
line 780
;780:			cg.stateTail = cg.stateHead;
ADDRGP4 cg+162044
ADDRGP4 cg+162040
INDIRI4
ASGNI4
line 781
;781:			predictCmd = current - CMD_BACKUP + 1;
ADDRLP4 512
ADDRLP4 476
INDIRI4
CNSTI4 64
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 782
;782:		}
ADDRGP4 $470
JUMPV
LABELV $469
line 785
;783:		// cg.physicsTime is the current snapshot's serverTime
;784:		// if it's the same as the last one
;785:		else if ( cg.physicsTime == cg.lastServerTime ) {
ADDRGP4 cg+107612
INDIRI4
ADDRGP4 cg+131148
INDIRI4
NEI4 $477
line 787
;786:			// we have no new information, so do an incremental predict
;787:			predictCmd = cg.lastPredictedCommand + 1;
ADDRLP4 512
ADDRGP4 cg+131144
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 788
;788:		}
ADDRGP4 $478
JUMPV
LABELV $477
line 789
;789:		else {
line 793
;790:			// we have a new snapshot
;791:
;792:			int i;
;793:			qboolean error = qtrue;
ADDRLP4 580
CNSTI4 1
ASGNI4
line 796
;794:
;795:			// loop through the saved states queue
;796:			for ( i = cg.stateHead; i != cg.stateTail; i = (i + 1) % NUM_SAVED_STATES ) {
ADDRLP4 576
ADDRGP4 cg+162040
INDIRI4
ASGNI4
ADDRGP4 $485
JUMPV
LABELV $482
line 798
;797:				// if we find a predicted state whose commandTime matches the snapshot player state's commandTime
;798:				if ( cg.savedPmoveStates[i].commandTime == cg.predictedPlayerState.commandTime ) {
CNSTI4 468
ADDRLP4 576
INDIRI4
MULI4
ADDRGP4 cg+131152
ADDP4
INDIRI4
ADDRGP4 cg+107636
INDIRI4
NEI4 $488
line 800
;799:					// make sure the state differences are acceptable
;800:					int errorcode = IsUnacceptableError( &cg.predictedPlayerState, &cg.savedPmoveStates[i] );
ADDRGP4 cg+107636
ARGP4
CNSTI4 468
ADDRLP4 576
INDIRI4
MULI4
ADDRGP4 cg+131152
ADDP4
ARGP4
ADDRLP4 588
ADDRGP4 IsUnacceptableError
CALLI4
ASGNI4
ADDRLP4 584
ADDRLP4 588
INDIRI4
ASGNI4
line 803
;801:
;802:					// too much change?
;803:					if ( errorcode ) {
ADDRLP4 584
INDIRI4
CNSTI4 0
EQI4 $494
line 804
;804:						if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $484
line 805
;805:							CG_Printf("errorcode %d at %d\n", errorcode, cg.time);
ADDRGP4 $499
ARGP4
ADDRLP4 584
INDIRI4
ARGI4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 806
;806:						}
line 808
;807:						// yeah, so do a full predict
;808:						break;
ADDRGP4 $484
JUMPV
LABELV $494
line 812
;809:					}
;810:
;811:					// this one is almost exact, so we'll copy it in as the starting point
;812:					*cg_pmove.ps = cg.savedPmoveStates[i];
ADDRGP4 cg_pmove
INDIRP4
CNSTI4 468
ADDRLP4 576
INDIRI4
MULI4
ADDRGP4 cg+131152
ADDP4
INDIRB
ASGNB 468
line 814
;813:					// advance the head
;814:					cg.stateHead = (i + 1) % NUM_SAVED_STATES;
ADDRGP4 cg+162040
ADDRLP4 576
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 66
MODI4
ASGNI4
line 817
;815:
;816:					// set the next command to predict
;817:					predictCmd = cg.lastPredictedCommand + 1;
ADDRLP4 512
ADDRGP4 cg+131144
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 820
;818:
;819:					// a saved state matched, so flag it
;820:					error = qfalse;
ADDRLP4 580
CNSTI4 0
ASGNI4
line 821
;821:					break;
ADDRGP4 $484
JUMPV
LABELV $488
line 823
;822:				}
;823:			}
LABELV $483
line 796
ADDRLP4 576
ADDRLP4 576
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 66
MODI4
ASGNI4
LABELV $485
ADDRLP4 576
INDIRI4
ADDRGP4 cg+162044
INDIRI4
NEI4 $482
LABELV $484
line 826
;824:
;825:			// if no saved states matched
;826:			if ( error ) {
ADDRLP4 580
INDIRI4
CNSTI4 0
EQI4 $504
line 828
;827:				// do a full predict
;828:				cg.lastPredictedCommand = 0;
ADDRGP4 cg+131144
CNSTI4 0
ASGNI4
line 829
;829:				cg.stateTail = cg.stateHead;
ADDRGP4 cg+162044
ADDRGP4 cg+162040
INDIRI4
ASGNI4
line 830
;830:				predictCmd = current - CMD_BACKUP + 1;
ADDRLP4 512
ADDRLP4 476
INDIRI4
CNSTI4 64
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 831
;831:			}
LABELV $504
line 832
;832:		}
LABELV $478
LABELV $470
line 836
;833:
;834:		// keep track of the server time of the last snapshot so we
;835:		// know when we're starting from a new one in future calls
;836:		cg.lastServerTime = cg.physicsTime;
ADDRGP4 cg+131148
ADDRGP4 cg+107612
INDIRI4
ASGNI4
line 837
;837:		stateIndex = cg.stateHead;
ADDRLP4 4
ADDRGP4 cg+162040
INDIRI4
ASGNI4
line 838
;838:	}
LABELV $466
line 842
;839://unlagged - optimized prediction
;840:
;841:	// run cmds
;842:	moved = qfalse;
ADDRLP4 480
CNSTI4 0
ASGNI4
line 843
;843:	for ( cmdNum = current - CMD_BACKUP + 1 ; cmdNum <= current ; cmdNum++ ) {
ADDRLP4 0
ADDRLP4 476
INDIRI4
CNSTI4 64
SUBI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $515
JUMPV
LABELV $512
line 845
;844:		// get the command
;845:		trap_GetUserCmd( cmdNum, &cg_pmove.cmd );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 cg_pmove+4
ARGP4
ADDRGP4 trap_GetUserCmd
CALLI4
pop
line 847
;846:
;847:		if ( cg_pmove.pmove_fixed ) {
ADDRGP4 cg_pmove+220
INDIRI4
CNSTI4 0
EQI4 $517
line 848
;848:			PM_UpdateViewAngles( cg_pmove.ps, &cg_pmove.cmd, 0 );
ADDRGP4 cg_pmove
INDIRP4
ARGP4
ADDRGP4 cg_pmove+4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 PM_UpdateViewAngles
CALLV
pop
line 849
;849:		}
LABELV $517
line 852
;850:
;851:		// don't do anything if the time is before the snapshot player time
;852:		if ( cg_pmove.cmd.serverTime <= cg.predictedPlayerState.commandTime ) {
ADDRGP4 cg_pmove+4
INDIRI4
ADDRGP4 cg+107636
INDIRI4
GTI4 $521
line 853
;853:			continue;
ADDRGP4 $513
JUMPV
LABELV $521
line 857
;854:		}
;855:
;856:		// don't do anything if the command was from a previous map_restart
;857:		if ( cg_pmove.cmd.serverTime > latestCmd.serverTime ) {
ADDRGP4 cg_pmove+4
INDIRI4
ADDRLP4 484
INDIRI4
LEI4 $525
line 858
;858:			continue;
ADDRGP4 $513
JUMPV
LABELV $525
line 866
;859:		}
;860:
;861:		// check for a prediction error from last frame
;862:		// on a lan, this will often be the exact value
;863:		// from the snapshot, but on a wan we will have
;864:		// to predict several commands to get to the point
;865:		// we want to compare
;866:		if ( cg.predictedPlayerState.commandTime == oldPlayerState.commandTime ) {
ADDRGP4 cg+107636
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $528
line 870
;867:			vec3_t	delta;
;868:			float	len;
;869:
;870:			if ( cg.thisFrameTeleport ) {
ADDRGP4 cg+107592
INDIRI4
CNSTI4 0
EQI4 $531
line 872
;871:				// a teleport will not cause an error decay
;872:				VectorClear( cg.predictedError );
ADDRLP4 588
CNSTF4 0
ASGNF4
ADDRGP4 cg+108840+8
ADDRLP4 588
INDIRF4
ASGNF4
ADDRGP4 cg+108840+4
ADDRLP4 588
INDIRF4
ASGNF4
ADDRGP4 cg+108840
ADDRLP4 588
INDIRF4
ASGNF4
line 873
;873:				if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $539
line 874
;874:					CG_Printf( "PredictionTeleport\n" );
ADDRGP4 $542
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 875
;875:				}
LABELV $539
line 876
;876:				cg.thisFrameTeleport = qfalse;
ADDRGP4 cg+107592
CNSTI4 0
ASGNI4
line 877
;877:			} else {
ADDRGP4 $532
JUMPV
LABELV $531
line 879
;878:				vec3_t	adjusted;
;879:				CG_AdjustPositionForMover( cg.predictedPlayerState.origin, 
ADDRGP4 cg+107636+20
ARGP4
ADDRGP4 cg+107636+68
INDIRI4
ARGI4
ADDRGP4 cg+107612
INDIRI4
ARGI4
ADDRGP4 cg+107608
INDIRI4
ARGI4
ADDRLP4 588
ARGP4
ADDRGP4 CG_AdjustPositionForMover
CALLV
pop
line 882
;880:					cg.predictedPlayerState.groundEntityNum, cg.physicsTime, cg.oldTime, adjusted );
;881:
;882:				if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $550
line 883
;883:					if (!VectorCompare( oldPlayerState.origin, adjusted )) {
ADDRLP4 8+20
ARGP4
ADDRLP4 588
ARGP4
ADDRLP4 600
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 600
INDIRI4
CNSTI4 0
NEI4 $553
line 884
;884:						CG_Printf("prediction error\n");
ADDRGP4 $556
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 885
;885:					}
LABELV $553
line 886
;886:				}
LABELV $550
line 887
;887:				VectorSubtract( oldPlayerState.origin, adjusted, delta );
ADDRLP4 572
ADDRLP4 8+20
INDIRF4
ADDRLP4 588
INDIRF4
SUBF4
ASGNF4
ADDRLP4 572+4
ADDRLP4 8+20+4
INDIRF4
ADDRLP4 588+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 572+8
ADDRLP4 8+20+8
INDIRF4
ADDRLP4 588+8
INDIRF4
SUBF4
ASGNF4
line 888
;888:				len = VectorLength( delta );
ADDRLP4 572
ARGP4
ADDRLP4 600
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 584
ADDRLP4 600
INDIRF4
ASGNF4
line 889
;889:				if ( len > 0.1 ) {
ADDRLP4 584
INDIRF4
CNSTF4 1036831949
LEF4 $566
line 890
;890:					if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $568
line 891
;891:						CG_Printf("Prediction miss: %f\n", len);
ADDRGP4 $571
ARGP4
ADDRLP4 584
INDIRF4
ARGF4
ADDRGP4 CG_Printf
CALLV
pop
line 892
;892:					}
LABELV $568
line 893
;893:					if ( cg_errorDecay.integer ) {
ADDRGP4 cg_errorDecay+12
INDIRI4
CNSTI4 0
EQI4 $572
line 897
;894:						int		t;
;895:						float	f;
;896:
;897:						t = cg.time - cg.predictedErrorTime;
ADDRLP4 608
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+108836
INDIRI4
SUBI4
ASGNI4
line 898
;898:						f = ( cg_errorDecay.value - t ) / cg_errorDecay.value;
ADDRLP4 604
ADDRGP4 cg_errorDecay+8
INDIRF4
ADDRLP4 608
INDIRI4
CVIF4 4
SUBF4
ADDRGP4 cg_errorDecay+8
INDIRF4
DIVF4
ASGNF4
line 899
;899:						if ( f < 0 ) {
ADDRLP4 604
INDIRF4
CNSTF4 0
GEF4 $579
line 900
;900:							f = 0;
ADDRLP4 604
CNSTF4 0
ASGNF4
line 901
;901:						}
LABELV $579
line 902
;902:						if ( f > 0 && cg_showmiss.integer ) {
ADDRLP4 604
INDIRF4
CNSTF4 0
LEF4 $581
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $581
line 903
;903:							CG_Printf("Double prediction decay: %f\n", f);
ADDRGP4 $584
ARGP4
ADDRLP4 604
INDIRF4
ARGF4
ADDRGP4 CG_Printf
CALLV
pop
line 904
;904:						}
LABELV $581
line 905
;905:						VectorScale( cg.predictedError, f, cg.predictedError );
ADDRGP4 cg+108840
ADDRGP4 cg+108840
INDIRF4
ADDRLP4 604
INDIRF4
MULF4
ASGNF4
ADDRGP4 cg+108840+4
ADDRGP4 cg+108840+4
INDIRF4
ADDRLP4 604
INDIRF4
MULF4
ASGNF4
ADDRGP4 cg+108840+8
ADDRGP4 cg+108840+8
INDIRF4
ADDRLP4 604
INDIRF4
MULF4
ASGNF4
line 906
;906:					} else {
ADDRGP4 $573
JUMPV
LABELV $572
line 907
;907:						VectorClear( cg.predictedError );
ADDRLP4 604
CNSTF4 0
ASGNF4
ADDRGP4 cg+108840+8
ADDRLP4 604
INDIRF4
ASGNF4
ADDRGP4 cg+108840+4
ADDRLP4 604
INDIRF4
ASGNF4
ADDRGP4 cg+108840
ADDRLP4 604
INDIRF4
ASGNF4
line 908
;908:					}
LABELV $573
line 909
;909:					VectorAdd( delta, cg.predictedError, cg.predictedError );
ADDRGP4 cg+108840
ADDRLP4 572
INDIRF4
ADDRGP4 cg+108840
INDIRF4
ADDF4
ASGNF4
ADDRGP4 cg+108840+4
ADDRLP4 572+4
INDIRF4
ADDRGP4 cg+108840+4
INDIRF4
ADDF4
ASGNF4
ADDRGP4 cg+108840+8
ADDRLP4 572+8
INDIRF4
ADDRGP4 cg+108840+8
INDIRF4
ADDF4
ASGNF4
line 910
;910:					cg.predictedErrorTime = cg.oldTime;
ADDRGP4 cg+108836
ADDRGP4 cg+107608
INDIRI4
ASGNI4
line 911
;911:				}
LABELV $566
line 912
;912:			}
LABELV $532
line 913
;913:		}
LABELV $528
line 917
;914:
;915:		// don't predict gauntlet firing, which is only supposed to happen
;916:		// when it actually inflicts damage
;917:		cg_pmove.gauntletHit = qfalse;
ADDRGP4 cg_pmove+40
CNSTI4 0
ASGNI4
line 919
;918:
;919:		if ( cg_pmove.pmove_fixed ) {
ADDRGP4 cg_pmove+220
INDIRI4
CNSTI4 0
EQI4 $615
line 920
;920:			cg_pmove.cmd.serverTime = ((cg_pmove.cmd.serverTime + pmove_msec.integer-1) / pmove_msec.integer) * pmove_msec.integer;
ADDRGP4 cg_pmove+4
ADDRGP4 cg_pmove+4
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
line 921
;921:		}
LABELV $615
line 925
;922:
;923:		
;924:
;925:		cg_pmove.cmd.weapon = cg.weaponSelect;
ADDRGP4 cg_pmove+4+20
ADDRGP4 cg+108944
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 932
;926:
;927:
;928:
;929:
;930://unlagged - optimized prediction
;931:		// we check for cg_latentCmds because it'll mess up the optimization
;932:		if ( cg_optimizePrediction.integer ) {
ADDRGP4 cg_optimizePrediction+12
INDIRI4
CNSTI4 0
EQI4 $626
line 934
;933:			// if we need to predict this command, or we've run out of space in the saved states queue
;934:			if ( cmdNum >= predictCmd || (stateIndex + 1) % NUM_SAVED_STATES == cg.stateHead ) {
ADDRLP4 0
INDIRI4
ADDRLP4 512
INDIRI4
GEI4 $632
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 66
MODI4
ADDRGP4 cg+162040
INDIRI4
NEI4 $629
LABELV $632
line 936
;935:				// run the Pmove
;936:				Pmove (&cg_pmove);
ADDRGP4 cg_pmove
ARGP4
ADDRGP4 Pmove
CALLV
pop
line 938
;937:
;938:				numPredicted++; // debug code
ADDRLP4 508
ADDRLP4 508
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 941
;939:
;940:				// record the last predicted command
;941:				cg.lastPredictedCommand = cmdNum;
ADDRGP4 cg+131144
ADDRLP4 0
INDIRI4
ASGNI4
line 944
;942:
;943:				// if we haven't run out of space in the saved states queue
;944:				if ( (stateIndex + 1) % NUM_SAVED_STATES != cg.stateHead ) {
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 66
MODI4
ADDRGP4 cg+162040
INDIRI4
EQI4 $627
line 947
;945:					// save the state for the false case (of cmdNum >= predictCmd)
;946:					// in later calls to this function
;947:					cg.savedPmoveStates[stateIndex] = *cg_pmove.ps;
CNSTI4 468
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cg+131152
ADDP4
ADDRGP4 cg_pmove
INDIRP4
INDIRB
ASGNB 468
line 948
;948:					stateIndex = (stateIndex + 1) % NUM_SAVED_STATES;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 66
MODI4
ASGNI4
line 949
;949:					cg.stateTail = stateIndex;
ADDRGP4 cg+162044
ADDRLP4 4
INDIRI4
ASGNI4
line 950
;950:				}
line 951
;951:			}
ADDRGP4 $627
JUMPV
LABELV $629
line 952
;952:			else {
line 953
;953:				numPlayedBack++; // debug code
ADDRLP4 516
ADDRLP4 516
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 955
;954:
;955:				if ( cg_showmiss.integer && 
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $639
CNSTI4 468
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cg+131152
ADDP4
INDIRI4
ADDRGP4 cg_pmove+4
INDIRI4
EQI4 $639
line 956
;956:						cg.savedPmoveStates[stateIndex].commandTime != cg_pmove.cmd.serverTime) {
line 958
;957:					// this should ONLY happen just after changing the value of pmove_fixed
;958:					CG_Printf( "saved state miss\n" );
ADDRGP4 $644
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 959
;959:				}
LABELV $639
line 962
;960:
;961:				// play back the command from the saved states
;962:				*cg_pmove.ps = cg.savedPmoveStates[stateIndex];
ADDRGP4 cg_pmove
INDIRP4
CNSTI4 468
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cg+131152
ADDP4
INDIRB
ASGNB 468
line 965
;963:
;964:				// go to the next element in the saved states array
;965:				stateIndex = (stateIndex + 1) % NUM_SAVED_STATES;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 66
MODI4
ASGNI4
line 966
;966:			}
line 967
;967:		}
ADDRGP4 $627
JUMPV
LABELV $626
line 968
;968:		else {
line 970
;969:			// run the Pmove
;970:			Pmove (&cg_pmove);
ADDRGP4 cg_pmove
ARGP4
ADDRGP4 Pmove
CALLV
pop
line 972
;971:
;972:			numPredicted++; // debug code
ADDRLP4 508
ADDRLP4 508
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 973
;973:		}
LABELV $627
line 976
;974://unlagged - optimized prediction
;975:
;976:		moved = qtrue;
ADDRLP4 480
CNSTI4 1
ASGNI4
line 979
;977:
;978:		// add push trigger movement effects
;979:		CG_TouchTriggerPrediction();
ADDRGP4 CG_TouchTriggerPrediction
CALLV
pop
line 983
;980:
;981:		// check for predictable events that changed from previous predictions
;982:		//CG_CheckChangedPredictableEvents(&cg.predictedPlayerState);
;983:	}
LABELV $513
line 843
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $515
ADDRLP4 0
INDIRI4
ADDRLP4 476
INDIRI4
LEI4 $512
line 994
;984:
;985://unlagged - optimized prediction
;986:	// do a /condump after a few seconds of this
;987:	//CG_Printf("cg.time: %d, numPredicted: %d, numPlayedBack: %d\n", cg.time, numPredicted, numPlayedBack); // debug code
;988:	// if everything is working right, numPredicted should be 1 more than 98%
;989:	// of the time, meaning only ONE predicted move was done in the frame
;990:	// you should see other values for numPredicted after IsUnacceptableError
;991:	// returns nonzero, and that's it
;992://unlagged - optimized prediction
;993:
;994:	if ( cg_showmiss.integer > 1 ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 1
LEI4 $646
line 995
;995:		CG_Printf( "[%i : %i] ", cg_pmove.cmd.serverTime, cg.time );
ADDRGP4 $649
ARGP4
ADDRGP4 cg_pmove+4
INDIRI4
ARGI4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 996
;996:	}
LABELV $646
line 998
;997:
;998:	if ( !moved ) {
ADDRLP4 480
INDIRI4
CNSTI4 0
NEI4 $652
line 999
;999:		if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $392
line 1000
;1000:			CG_Printf( "not moved\n" );
ADDRGP4 $657
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1001
;1001:		}
line 1002
;1002:		return;
ADDRGP4 $392
JUMPV
LABELV $652
line 1006
;1003:	}
;1004:
;1005:	// adjust for the movement of the groundentity
;1006:	CG_AdjustPositionForMover( cg.predictedPlayerState.origin, 
ADDRGP4 cg+107636+20
ARGP4
ADDRGP4 cg+107636+68
INDIRI4
ARGI4
ADDRGP4 cg+107612
INDIRI4
ARGI4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRGP4 cg+107636+20
ARGP4
ADDRGP4 CG_AdjustPositionForMover
CALLV
pop
line 1010
;1007:		cg.predictedPlayerState.groundEntityNum, 
;1008:		cg.physicsTime, cg.time, cg.predictedPlayerState.origin );
;1009:
;1010:	if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $666
line 1011
;1011:		if (cg.predictedPlayerState.eventSequence > oldPlayerState.eventSequence + MAX_PS_EVENTS) {
ADDRGP4 cg+107636+108
INDIRI4
ADDRLP4 8+108
INDIRI4
CNSTI4 2
ADDI4
LEI4 $669
line 1012
;1012:			CG_Printf("WARNING: dropped event\n");
ADDRGP4 $674
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1013
;1013:		}
LABELV $669
line 1014
;1014:	}
LABELV $666
line 1020
;1015:
;1016:
;1017:	// This is for cg_aimType 2 style aim, but cg_aimType 3
;1018:	// falls back to 2 if it fails due to lag, so still need to send for 3
;1019:
;1020:	if ( (cg_aimType.integer == 2 || cg_aimType.integer == 3) && g_delagHitscan.integer >= 2) {
ADDRGP4 cg_aimType+12
INDIRI4
CNSTI4 2
EQI4 $680
ADDRGP4 cg_aimType+12
INDIRI4
CNSTI4 3
NEI4 $675
LABELV $680
ADDRGP4 g_delagHitscan+12
INDIRI4
CNSTI4 2
LTI4 $675
line 1021
;1021:		clientsHit = CheckFireHitAimType2(); //(pm, &pml);
ADDRLP4 572
ADDRGP4 CheckFireHitAimType2
CALLI4
ASGNI4
ADDRLP4 544
ADDRLP4 572
INDIRI4
ASGNI4
line 1022
;1022:		if (clientsHit) {
ADDRLP4 544
INDIRI4
CNSTI4 0
EQI4 $681
line 1023
;1023:			cg.clientsHit = 1 << (clientsHit - 1);
ADDRLP4 576
CNSTI4 1
ASGNI4
ADDRGP4 cg+162104
ADDRLP4 576
INDIRI4
ADDRLP4 544
INDIRI4
ADDRLP4 576
INDIRI4
SUBI4
LSHI4
ASGNI4
line 1024
;1024:		}
LABELV $681
line 1035
;1025:
;1026:		//clientsHit <<= 4;
;1027:
;1028:		//cg.weaponSelect &= 15;
;1029:
;1030:		//cg.weaponSelect |= clientsHit;
;1031:
;1032:
;1033:		// let the client system know what our weapon and zoom settings are
;1034:		//trap_SetUserCmdValue( cg.weaponSelect, cg.zoomSensitivity );
;1035:		trap_SetUserCmdValue( clientsHit, cg.zoomSensitivity );
ADDRLP4 544
INDIRI4
ARGI4
ADDRGP4 cg+109436
INDIRF4
ARGF4
ADDRGP4 trap_SetUserCmdValue
CALLV
pop
line 1037
;1036:
;1037:	} else {
ADDRGP4 $676
JUMPV
LABELV $675
line 1038
;1038:		trap_SetUserCmdValue( cg.weaponSelect, cg.zoomSensitivity );
ADDRGP4 cg+108944
INDIRI4
ARGI4
ADDRGP4 cg+109436
INDIRF4
ARGF4
ADDRGP4 trap_SetUserCmdValue
CALLV
pop
line 1039
;1039:	}
LABELV $676
line 1045
;1040:
;1041:	/*if ( cgs.dbgrws && cg.weaponSelectLastFrame != cg.weaponSelect ) {
;1042:		CG_Printf("DBGRWS:Should apply a switch this frame. - old:%i new:%i\n", cg.weaponSelectLastFrame, cg.weaponSelect);
;1043:	}*/
;1044:
;1045:	if (cg.weaponSelectLastFrame != cg.weaponSelect && cg_aimType.integer >= 2 && g_delagHitscan.integer >= 2) {
ADDRGP4 cg+108948
INDIRI4
ADDRGP4 cg+108944
INDIRI4
EQI4 $687
ADDRLP4 572
CNSTI4 2
ASGNI4
ADDRGP4 cg_aimType+12
INDIRI4
ADDRLP4 572
INDIRI4
LTI4 $687
ADDRGP4 g_delagHitscan+12
INDIRI4
ADDRLP4 572
INDIRI4
LTI4 $687
line 1046
;1046:		trap_SendClientCommand(va("rws %i\n", cg.weaponSelect));
ADDRGP4 $693
ARGP4
ADDRGP4 cg+108944
INDIRI4
ARGI4
ADDRLP4 576
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 576
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 1047
;1047:		cg.weaponSelectLastFrame = cg.weaponSelect;
ADDRGP4 cg+108948
ADDRGP4 cg+108944
INDIRI4
ASGNI4
line 1048
;1048:	}
LABELV $687
line 1053
;1049:
;1050:
;1051:
;1052:	// fire events and other transition triggered things
;1053:	CG_TransitionPlayerState( &cg.predictedPlayerState, &oldPlayerState );
ADDRGP4 cg+107636
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 CG_TransitionPlayerState
CALLV
pop
line 1057
;1054:
;1055:
;1056:
;1057:	if ( cg_showmiss.integer ) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $698
line 1058
;1058:		if (cg.eventSequence > cg.predictedPlayerState.eventSequence) {
ADDRGP4 cg+108852
INDIRI4
ADDRGP4 cg+107636+108
INDIRI4
LEI4 $701
line 1059
;1059:			CG_Printf("WARNING: double event\n");
ADDRGP4 $706
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1060
;1060:			cg.eventSequence = cg.predictedPlayerState.eventSequence;
ADDRGP4 cg+108852
ADDRGP4 cg+107636+108
INDIRI4
ASGNI4
line 1061
;1061:		}
LABELV $701
line 1062
;1062:	}
LABELV $698
line 1063
;1063:}
LABELV $392
endproc CG_PredictPlayerState 612 20
export G_TimeShiftClientNum
proc G_TimeShiftClientNum 0 0
line 1068
;1064:
;1065:
;1066:
;1067:int G_TimeShiftClientNum( int clientNum, int time, vec3_t currentOrigin, vec3_t mins, vec3_t maxs ) 
;1068:{
line 1069
;1069:	return 0;
CNSTI4 0
RETI4
LABELV $710
endproc G_TimeShiftClientNum 0 0
export G_UnTimeShiftClientNum
proc G_UnTimeShiftClientNum 0 0
line 1073
;1070:}
;1071:
;1072:void G_UnTimeShiftClientNum( int clientNum, vec3_t currentOrigin, vec3_t mins, vec3_t maxs ) 
;1073:{
line 1075
;1074:
;1075:}
LABELV $711
endproc G_UnTimeShiftClientNum 0 0
export G_EraseSaved
proc G_EraseSaved 0 0
line 1079
;1076:
;1077:
;1078:void G_EraseSaved( int clientNum ) 
;1079:{
line 1081
;1080:
;1081:}
LABELV $712
endproc G_EraseSaved 0 0
import CheckFireHitAimType2
bss
align 4
LABELV cg_triggerEntities
skip 1024
align 4
LABELV cg_numTriggerEntities
skip 4
align 4
LABELV cg_solidEntities
skip 1024
align 4
LABELV cg_numSolidEntities
skip 4
align 4
LABELV cg_pmove
skip 244
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
LABELV $706
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 100
byte 1 111
byte 1 117
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $693
byte 1 114
byte 1 119
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $674
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 112
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
align 1
LABELV $657
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $649
byte 1 91
byte 1 37
byte 1 105
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 93
byte 1 32
byte 1 0
align 1
LABELV $644
byte 1 115
byte 1 97
byte 1 118
byte 1 101
byte 1 100
byte 1 32
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $584
byte 1 68
byte 1 111
byte 1 117
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 100
byte 1 101
byte 1 99
byte 1 97
byte 1 121
byte 1 58
byte 1 32
byte 1 37
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $571
byte 1 80
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $556
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 10
byte 1 0
align 1
LABELV $542
byte 1 80
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 84
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $499
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 99
byte 1 111
byte 1 100
byte 1 101
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $456
byte 1 51
byte 1 51
byte 1 0
align 1
LABELV $452
byte 1 56
byte 1 0
align 1
LABELV $451
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
LABELV $434
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 101
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 80
byte 1 65
byte 1 67
byte 1 75
byte 1 69
byte 1 84
byte 1 95
byte 1 66
byte 1 65
byte 1 67
byte 1 75
byte 1 85
byte 1 80
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $299
byte 1 100
byte 1 101
byte 1 108
byte 1 116
byte 1 97
byte 1 58
byte 1 32
byte 1 37
byte 1 46
byte 1 50
byte 1 102
byte 1 32
byte 1 32
byte 1 0
