export G_TestEntityPosition
code
proc G_TestEntityPosition 68 28
file "../g_mover.c"
line 33
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:
;4:#include "g_local.h"
;5:
;6:
;7:
;8:/*
;9:===============================================================================
;10:
;11:PUSHMOVE
;12:
;13:===============================================================================
;14:*/
;15:
;16:void MatchTeam( gentity_t *teamLeader, int moverState, int time );
;17:
;18:typedef struct {
;19:	gentity_t	*ent;
;20:	vec3_t	origin;
;21:	vec3_t	angles;
;22:	float	deltayaw;
;23:} pushed_t;
;24:pushed_t	pushed[MAX_GENTITIES], *pushed_p;
;25:
;26:
;27:/*
;28:============
;29:G_TestEntityPosition
;30:
;31:============
;32:*/
;33:gentity_t	*G_TestEntityPosition( gentity_t *ent ) {
line 37
;34:	trace_t	tr;
;35:	int		mask;
;36:
;37:	if ( ent->clipmask ) {
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
CNSTI4 0
EQI4 $69
line 38
;38:		mask = ent->clipmask;
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
ASGNI4
line 39
;39:	} else {
ADDRGP4 $70
JUMPV
LABELV $69
line 40
;40:		mask = MASK_SOLID;
ADDRLP4 56
CNSTI4 1
ASGNI4
line 41
;41:	}
LABELV $70
line 42
;42:	if ( ent->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $71
line 43
;43:		trap_Trace( &tr, ent->client->ps.origin, ent->r.mins, ent->r.maxs, ent->client->ps.origin, ent->s.number, mask );
ADDRLP4 0
ARGP4
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
ADDRLP4 60
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 448
ADDP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 44
;44:	} else {
ADDRGP4 $72
JUMPV
LABELV $71
line 45
;45:		trap_Trace( &tr, ent->s.pos.trBase, ent->r.mins, ent->r.maxs, ent->s.pos.trBase, ent->s.number, mask );
ADDRLP4 0
ARGP4
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
ADDRLP4 60
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 448
ADDP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 46
;46:	}
LABELV $72
line 48
;47:	
;48:	if (tr.startsolid)
ADDRLP4 0+4
INDIRI4
CNSTI4 0
EQI4 $73
line 49
;49:		return &g_entities[ tr.entityNum ];
CNSTI4 896
ADDRLP4 0+52
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
RETP4
ADDRGP4 $68
JUMPV
LABELV $73
line 51
;50:		
;51:	return NULL;
CNSTP4 0
RETP4
LABELV $68
endproc G_TestEntityPosition 68 28
export G_CreateRotationMatrix
proc G_CreateRotationMatrix 4 16
line 59
;52:}
;53:
;54:/*
;55:================
;56:G_CreateRotationMatrix
;57:================
;58:*/
;59:void G_CreateRotationMatrix(vec3_t angles, vec3_t matrix[3]) {
line 60
;60:	AngleVectors(angles, matrix[0], matrix[1], matrix[2]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 61
;61:	VectorInverse(matrix[1]);
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 VectorInverse
CALLV
pop
line 62
;62:}
LABELV $77
endproc G_CreateRotationMatrix 4 16
export G_TransposeMatrix
proc G_TransposeMatrix 24 0
line 69
;63:
;64:/*
;65:================
;66:G_TransposeMatrix
;67:================
;68:*/
;69:void G_TransposeMatrix(vec3_t matrix[3], vec3_t transpose[3]) {
line 71
;70:	int i, j;
;71:	for (i = 0; i < 3; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $79
line 72
;72:		for (j = 0; j < 3; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $83
line 73
;73:			transpose[i][j] = matrix[j][i];
ADDRLP4 12
CNSTI4 2
ASGNI4
ADDRLP4 16
CNSTI4 12
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 12
INDIRI4
LSHI4
ADDRLP4 16
INDIRI4
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 4
INDIRP4
ADDP4
ADDP4
ADDRLP4 4
INDIRI4
ADDRLP4 12
INDIRI4
LSHI4
ADDRLP4 16
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
ADDP4
ADDP4
INDIRF4
ASGNF4
line 74
;74:		}
LABELV $84
line 72
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $83
line 75
;75:	}
LABELV $80
line 71
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 3
LTI4 $79
line 76
;76:}
LABELV $78
endproc G_TransposeMatrix 24 0
export G_RotatePoint
proc G_RotatePoint 24 0
line 83
;77:
;78:/*
;79:================
;80:G_RotatePoint
;81:================
;82:*/
;83:void G_RotatePoint(vec3_t point, vec3_t matrix[3]) {
line 86
;84:	vec3_t tvec;
;85:
;86:	VectorCopy(point, tvec);
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 87
;87:	point[0] = DotProduct(matrix[0], tvec);
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 0
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
MULF4
ADDF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 88
;88:	point[1] = DotProduct(matrix[1], tvec);
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDRLP4 16
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
MULF4
ADDF4
ADDRLP4 16
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 89
;89:	point[2] = DotProduct(matrix[2], tvec);
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDRLP4 20
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
MULF4
ADDF4
ADDRLP4 20
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 90
;90:}
LABELV $87
endproc G_RotatePoint 24 0
export G_TryPushingEntity
proc G_TryPushingEntity 172 8
line 99
;91:
;92:/*
;93:==================
;94:G_TryPushingEntity
;95:
;96:Returns qfalse if the move is blocked
;97:==================
;98:*/
;99:qboolean	G_TryPushingEntity( gentity_t *check, gentity_t *pusher, vec3_t move, vec3_t amove ) {
line 106
;100:	vec3_t		matrix[3], transpose[3];
;101:	vec3_t		org, org2, move2;
;102:	gentity_t	*block;
;103:
;104:	// EF_MOVER_STOP will just stop when contacting another entity
;105:	// instead of pushing it, but entities can still ride on top of it
;106:	if ( ( pusher->s.eFlags & EF_MOVER_STOP ) && 
ADDRLP4 112
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 112
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $95
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ADDRLP4 112
INDIRP4
INDIRI4
EQI4 $95
line 107
;107:		check->s.groundEntityNum != pusher->s.number ) {
line 108
;108:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $94
JUMPV
LABELV $95
line 112
;109:	}
;110:
;111:	// save off the old position
;112:	if (pushed_p > &pushed[MAX_GENTITIES]) {
ADDRGP4 pushed_p
INDIRP4
CVPU4 4
ADDRGP4 pushed+32768
CVPU4 4
LEU4 $97
line 113
;113:		G_Error( "pushed_p > &pushed[MAX_GENTITIES]" );
ADDRGP4 $100
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 114
;114:	}
LABELV $97
line 115
;115:	pushed_p->ent = check;
ADDRGP4 pushed_p
INDIRP4
ADDRFP4 0
INDIRP4
ASGNP4
line 116
;116:	VectorCopy (check->s.pos.trBase, pushed_p->origin);
ADDRGP4 pushed_p
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 117
;117:	VectorCopy (check->s.apos.trBase, pushed_p->angles);
ADDRGP4 pushed_p
INDIRP4
CNSTI4 16
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRB
ASGNB 12
line 118
;118:	if ( check->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $101
line 119
;119:		pushed_p->deltayaw = check->client->ps.delta_angles[YAW];
ADDRGP4 pushed_p
INDIRP4
CNSTI4 28
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 120
;120:		VectorCopy (check->client->ps.origin, pushed_p->origin);
ADDRGP4 pushed_p
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 121
;121:	}
LABELV $101
line 122
;122:	pushed_p++;
ADDRLP4 116
ADDRGP4 pushed_p
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 116
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
line 126
;123:
;124:	// try moving the contacted entity 
;125:	// figure movement due to the pusher's amove
;126:	G_CreateRotationMatrix( amove, transpose );
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 76
ARGP4
ADDRGP4 G_CreateRotationMatrix
CALLV
pop
line 127
;127:	G_TransposeMatrix( transpose, matrix );
ADDRLP4 76
ARGP4
ADDRLP4 40
ARGP4
ADDRGP4 G_TransposeMatrix
CALLV
pop
line 128
;128:	if ( check->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $103
line 129
;129:		VectorSubtract (check->client->ps.origin, pusher->r.currentOrigin, org);
ADDRLP4 120
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
ASGNP4
ADDRLP4 124
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 120
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 124
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 120
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 124
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
SUBF4
ASGNF4
line 130
;130:	}
ADDRGP4 $104
JUMPV
LABELV $103
line 131
;131:	else {
line 132
;132:		VectorSubtract (check->s.pos.trBase, pusher->r.currentOrigin, org);
ADDRLP4 120
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 124
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 120
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 124
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 120
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 124
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
SUBF4
ASGNF4
line 133
;133:	}
LABELV $104
line 134
;134:	VectorCopy( org, org2 );
ADDRLP4 24
ADDRLP4 12
INDIRB
ASGNB 12
line 135
;135:	G_RotatePoint( org2, matrix );
ADDRLP4 24
ARGP4
ADDRLP4 40
ARGP4
ADDRGP4 G_RotatePoint
CALLV
pop
line 136
;136:	VectorSubtract (org2, org, move2);
ADDRLP4 0
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 24+4
INDIRF4
ADDRLP4 12+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 24+8
INDIRF4
ADDRLP4 12+8
INDIRF4
SUBF4
ASGNF4
line 138
;137:	// add movement
;138:	VectorAdd (check->s.pos.trBase, move, check->s.pos.trBase);
ADDRLP4 120
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 120
INDIRP4
ADDRLP4 120
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 124
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 124
INDIRP4
ADDRLP4 124
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 128
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 128
INDIRP4
ADDRLP4 128
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
ASGNF4
line 139
;139:	VectorAdd (check->s.pos.trBase, move2, check->s.pos.trBase);
ADDRLP4 132
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 132
INDIRP4
ADDRLP4 132
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
ADDRLP4 136
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 136
INDIRP4
ADDRLP4 136
INDIRP4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 140
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 140
INDIRP4
ADDRLP4 140
INDIRP4
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ASGNF4
line 140
;140:	if ( check->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $117
line 141
;141:		VectorAdd (check->client->ps.origin, move, check->client->ps.origin);
ADDRLP4 144
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 144
INDIRP4
ADDRLP4 144
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 148
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 148
INDIRP4
ADDRLP4 148
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 152
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 152
INDIRP4
ADDRLP4 152
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
ASGNF4
line 142
;142:		VectorAdd (check->client->ps.origin, move2, check->client->ps.origin);
ADDRLP4 156
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 156
INDIRP4
ADDRLP4 156
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
ADDRLP4 160
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 160
INDIRP4
ADDRLP4 160
INDIRP4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 164
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 164
INDIRP4
ADDRLP4 164
INDIRP4
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ASGNF4
line 144
;143:		// make sure the client's view rotates when on a rotating mover
;144:		check->client->ps.delta_angles[YAW] += ANGLE2SHORT(amove[YAW]);
ADDRLP4 168
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 60
ADDP4
ASGNP4
ADDRLP4 168
INDIRP4
ADDRLP4 168
INDIRP4
INDIRI4
CNSTF4 1199570944
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
CNSTF4 1135869952
DIVF4
CVFI4 4
CNSTI4 65535
BANDI4
ADDI4
ASGNI4
line 145
;145:	}
LABELV $117
line 148
;146:
;147:	// may have pushed them off an edge
;148:	if ( check->s.groundEntityNum != pusher->s.number ) {
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
INDIRI4
EQI4 $121
line 149
;149:		check->s.groundEntityNum = -1;
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 -1
ASGNI4
line 150
;150:	}
LABELV $121
line 152
;151:
;152:	block = G_TestEntityPosition( check );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 144
ADDRGP4 G_TestEntityPosition
CALLP4
ASGNP4
ADDRLP4 36
ADDRLP4 144
INDIRP4
ASGNP4
line 153
;153:	if (!block) {
ADDRLP4 36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $123
line 155
;154:		// pushed ok
;155:		if ( check->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $125
line 156
;156:			VectorCopy( check->client->ps.origin, check->r.currentOrigin );
ADDRLP4 148
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 148
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 148
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 157
;157:		} else {
ADDRGP4 $126
JUMPV
LABELV $125
line 158
;158:			VectorCopy( check->s.pos.trBase, check->r.currentOrigin );
ADDRLP4 148
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 148
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 148
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 159
;159:		}
LABELV $126
line 160
;160:		trap_LinkEntity (check);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 161
;161:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $94
JUMPV
LABELV $123
line 167
;162:	}
;163:
;164:	// if it is ok to leave in the old position, do it
;165:	// this is only relevent for riding entities, not pushed
;166:	// Sliding trapdoors can cause this.
;167:	VectorCopy( (pushed_p-1)->origin, check->s.pos.trBase);
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRGP4 pushed_p
INDIRP4
CNSTI4 -28
ADDP4
INDIRB
ASGNB 12
line 168
;168:	if ( check->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $127
line 169
;169:		VectorCopy( (pushed_p-1)->origin, check->client->ps.origin);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ADDRGP4 pushed_p
INDIRP4
CNSTI4 -28
ADDP4
INDIRB
ASGNB 12
line 170
;170:	}
LABELV $127
line 171
;171:	VectorCopy( (pushed_p-1)->angles, check->s.apos.trBase );
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
ADDRGP4 pushed_p
INDIRP4
CNSTI4 -16
ADDP4
INDIRB
ASGNB 12
line 172
;172:	block = G_TestEntityPosition (check);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 148
ADDRGP4 G_TestEntityPosition
CALLP4
ASGNP4
ADDRLP4 36
ADDRLP4 148
INDIRP4
ASGNP4
line 173
;173:	if ( !block ) {
ADDRLP4 36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $129
line 174
;174:		check->s.groundEntityNum = -1;
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 -1
ASGNI4
line 175
;175:		pushed_p--;
ADDRLP4 152
ADDRGP4 pushed_p
ASGNP4
ADDRLP4 152
INDIRP4
ADDRLP4 152
INDIRP4
INDIRP4
CNSTI4 -32
ADDP4
ASGNP4
line 176
;176:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $94
JUMPV
LABELV $129
line 180
;177:	}
;178:
;179:	// blocked
;180:	return qfalse;
CNSTI4 0
RETI4
LABELV $94
endproc G_TryPushingEntity 172 8
export G_CheckProxMinePosition
proc G_CheckProxMinePosition 108 28
line 188
;181:}
;182:
;183:/*
;184:==================
;185:G_CheckProxMinePosition
;186:==================
;187:*/
;188:qboolean G_CheckProxMinePosition( gentity_t *check ) {
line 192
;189:	vec3_t		start, end;
;190:	trace_t	tr;
;191:
;192:	VectorMA(check->s.pos.trBase, 0.125, check->movedir, start);
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
CNSTF4 1040187392
ASGNF4
ADDRLP4 0
ADDRLP4 80
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 84
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 676
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 80
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 84
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 680
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 88
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
CNSTF4 1040187392
ADDRLP4 88
INDIRP4
CNSTI4 684
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 193
;193:	VectorMA(check->s.pos.trBase, 2, check->movedir, end);
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 96
CNSTF4 1073741824
ASGNF4
ADDRLP4 12
ADDRLP4 92
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 96
INDIRF4
ADDRLP4 92
INDIRP4
CNSTI4 676
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 92
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 96
INDIRF4
ADDRLP4 92
INDIRP4
CNSTI4 680
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12+8
ADDRLP4 100
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
CNSTF4 1073741824
ADDRLP4 100
INDIRP4
CNSTI4 684
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 194
;194:	trap_Trace( &tr, start, NULL, NULL, end, check->s.number, MASK_SOLID );
ADDRLP4 24
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 104
CNSTP4 0
ASGNP4
ADDRLP4 104
INDIRP4
ARGP4
ADDRLP4 104
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 196
;195:	
;196:	if (tr.startsolid || tr.fraction < 1)
ADDRLP4 24+4
INDIRI4
CNSTI4 0
NEI4 $140
ADDRLP4 24+8
INDIRF4
CNSTF4 1065353216
GEF4 $136
LABELV $140
line 197
;197:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $131
JUMPV
LABELV $136
line 199
;198:
;199:	return qtrue;
CNSTI4 1
RETI4
LABELV $131
endproc G_CheckProxMinePosition 108 28
export G_TryPushingProxMine
proc G_TryPushingProxMine 120 16
line 207
;200:}
;201:
;202:/*
;203:==================
;204:G_TryPushingProxMine
;205:==================
;206:*/
;207:qboolean G_TryPushingProxMine( gentity_t *check, gentity_t *pusher, vec3_t move, vec3_t amove ) {
line 213
;208:	vec3_t		forward, right, up;
;209:	vec3_t		org, org2, move2;
;210:	int ret;
;211:
;212:	// we need this for pushing things later
;213:	VectorSubtract (vec3_origin, amove, org);
ADDRLP4 76
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 0
ADDRGP4 vec3_origin
INDIRF4
ADDRLP4 76
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRGP4 vec3_origin+4
INDIRF4
ADDRLP4 76
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 vec3_origin+8
INDIRF4
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 214
;214:	AngleVectors (org, forward, right, up);
ADDRLP4 0
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 48
ARGP4
ADDRLP4 60
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 217
;215:
;216:	// try moving the contacted entity 
;217:	VectorAdd (check->s.pos.trBase, move, check->s.pos.trBase);
ADDRLP4 80
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 88
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
ASGNF4
line 220
;218:
;219:	// figure movement due to the pusher's amove
;220:	VectorSubtract (check->s.pos.trBase, pusher->r.currentOrigin, org);
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 96
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 92
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 96
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 92
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 96
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
SUBF4
ASGNF4
line 221
;221:	org2[0] = DotProduct (org, forward);
ADDRLP4 12
ADDRLP4 0
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 36+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRLP4 36+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 222
;222:	org2[1] = -DotProduct (org, right);
ADDRLP4 12+4
ADDRLP4 0
INDIRF4
ADDRLP4 48
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 48+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRLP4 48+8
INDIRF4
MULF4
ADDF4
NEGF4
ASGNF4
line 223
;223:	org2[2] = DotProduct (org, up);
ADDRLP4 12+8
ADDRLP4 0
INDIRF4
ADDRLP4 60
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 60+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRLP4 60+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 224
;224:	VectorSubtract (org2, org, move2);
ADDRLP4 24
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+8
ADDRLP4 12+8
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 225
;225:	VectorAdd (check->s.pos.trBase, move2, check->s.pos.trBase);
ADDRLP4 100
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRF4
ADDRLP4 24
INDIRF4
ADDF4
ASGNF4
ADDRLP4 104
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRF4
ADDRLP4 24+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 108
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRF4
ADDRLP4 24+8
INDIRF4
ADDF4
ASGNF4
line 227
;226:
;227:	ret = G_CheckProxMinePosition( check );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 112
ADDRGP4 G_CheckProxMinePosition
CALLI4
ASGNI4
ADDRLP4 72
ADDRLP4 112
INDIRI4
ASGNI4
line 228
;228:	if (ret) {
ADDRLP4 72
INDIRI4
CNSTI4 0
EQI4 $170
line 229
;229:		VectorCopy( check->s.pos.trBase, check->r.currentOrigin );
ADDRLP4 116
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 116
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 116
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 230
;230:		trap_LinkEntity (check);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 231
;231:	}
LABELV $170
line 232
;232:	return ret;
ADDRLP4 72
INDIRI4
RETI4
LABELV $141
endproc G_TryPushingProxMine 120 16
export G_MoverPush
proc G_MoverPush 4240 32
line 246
;233:}
;234:
;235:void G_ExplodeMissile( gentity_t *ent );
;236:
;237:/*
;238:============
;239:G_MoverPush
;240:
;241:Objects need to be moved back on a failed push,
;242:otherwise riders would continue to slide.
;243:If qfalse is returned, *obstacle will be the blocking entity
;244:============
;245:*/
;246:qboolean G_MoverPush( gentity_t *pusher, vec3_t move, vec3_t amove, gentity_t **obstacle ) {
line 255
;247:	int			i, e;
;248:	gentity_t	*check;
;249:	vec3_t		mins, maxs;
;250:	pushed_t	*p;
;251:	int			entityList[MAX_GENTITIES];
;252:	int			listedEntities;
;253:	vec3_t		totalMins, totalMaxs;
;254:
;255:	*obstacle = NULL;
ADDRFP4 12
INDIRP4
CNSTP4 0
ASGNP4
line 260
;256:
;257:
;258:	// mins/maxs are the bounds at the destination
;259:	// totalMins / totalMaxs are the bounds for the entire move
;260:	if ( pusher->r.currentAngles[0] || pusher->r.currentAngles[1] || pusher->r.currentAngles[2]
ADDRLP4 4164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4168
CNSTF4 0
ASGNF4
ADDRLP4 4164
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
ADDRLP4 4168
INDIRF4
NEF4 $179
ADDRLP4 4164
INDIRP4
CNSTI4 504
ADDP4
INDIRF4
ADDRLP4 4168
INDIRF4
NEF4 $179
ADDRLP4 4164
INDIRP4
CNSTI4 508
ADDP4
INDIRF4
ADDRLP4 4168
INDIRF4
NEF4 $179
ADDRLP4 4172
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 4172
INDIRP4
INDIRF4
ADDRLP4 4168
INDIRF4
NEF4 $179
ADDRLP4 4172
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4168
INDIRF4
NEF4 $179
ADDRLP4 4172
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 4168
INDIRF4
EQF4 $173
LABELV $179
line 261
;261:		|| amove[0] || amove[1] || amove[2] ) {
line 264
;262:		float		radius;
;263:
;264:		radius = RadiusFromBounds( pusher->r.mins, pusher->r.maxs );
ADDRLP4 4180
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4180
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRLP4 4180
INDIRP4
CNSTI4 448
ADDP4
ARGP4
ADDRLP4 4184
ADDRGP4 RadiusFromBounds
CALLF4
ASGNF4
ADDRLP4 4176
ADDRLP4 4184
INDIRF4
ASGNF4
line 265
;265:		for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $180
line 266
;266:			mins[i] = pusher->r.currentOrigin[i] + move[i] - radius;
ADDRLP4 4188
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4188
INDIRI4
ADDRLP4 16
ADDP4
ADDRLP4 4188
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDP4
INDIRF4
ADDRLP4 4188
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDF4
ADDRLP4 4176
INDIRF4
SUBF4
ASGNF4
line 267
;267:			maxs[i] = pusher->r.currentOrigin[i] + move[i] + radius;
ADDRLP4 4192
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4192
INDIRI4
ADDRLP4 28
ADDP4
ADDRLP4 4192
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDP4
INDIRF4
ADDRLP4 4192
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDF4
ADDRLP4 4176
INDIRF4
ADDF4
ASGNF4
line 268
;268:			totalMins[i] = mins[i] - move[i];
ADDRLP4 4196
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4196
INDIRI4
ADDRLP4 4140
ADDP4
ADDRLP4 4196
INDIRI4
ADDRLP4 16
ADDP4
INDIRF4
ADDRLP4 4196
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 269
;269:			totalMaxs[i] = maxs[i] - move[i];
ADDRLP4 4200
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4200
INDIRI4
ADDRLP4 4152
ADDP4
ADDRLP4 4200
INDIRI4
ADDRLP4 28
ADDP4
INDIRF4
ADDRLP4 4200
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 270
;270:		}
LABELV $181
line 265
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 3
LTI4 $180
line 271
;271:	} else {
ADDRGP4 $174
JUMPV
LABELV $173
line 272
;272:		for (i=0 ; i<3 ; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $184
line 273
;273:			mins[i] = pusher->r.absmin[i] + move[i];
ADDRLP4 4176
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4176
INDIRI4
ADDRLP4 16
ADDP4
ADDRLP4 4176
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 464
ADDP4
ADDP4
INDIRF4
ADDRLP4 4176
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDF4
ASGNF4
line 274
;274:			maxs[i] = pusher->r.absmax[i] + move[i];
ADDRLP4 4180
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4180
INDIRI4
ADDRLP4 28
ADDP4
ADDRLP4 4180
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRF4
ADDRLP4 4180
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDF4
ASGNF4
line 275
;275:		}
LABELV $185
line 272
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 3
LTI4 $184
line 277
;276:
;277:		VectorCopy( pusher->r.absmin, totalMins );
ADDRLP4 4140
ADDRFP4 0
INDIRP4
CNSTI4 464
ADDP4
INDIRB
ASGNB 12
line 278
;278:		VectorCopy( pusher->r.absmax, totalMaxs );
ADDRLP4 4152
ADDRFP4 0
INDIRP4
CNSTI4 476
ADDP4
INDIRB
ASGNB 12
line 279
;279:		for (i=0 ; i<3 ; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $188
line 280
;280:			if ( move[i] > 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
CNSTF4 0
LEF4 $192
line 281
;281:				totalMaxs[i] += move[i];
ADDRLP4 4176
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4180
ADDRLP4 4176
INDIRI4
ADDRLP4 4152
ADDP4
ASGNP4
ADDRLP4 4180
INDIRP4
ADDRLP4 4180
INDIRP4
INDIRF4
ADDRLP4 4176
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDF4
ASGNF4
line 282
;282:			} else {
ADDRGP4 $193
JUMPV
LABELV $192
line 283
;283:				totalMins[i] += move[i];
ADDRLP4 4176
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4180
ADDRLP4 4176
INDIRI4
ADDRLP4 4140
ADDP4
ASGNP4
ADDRLP4 4180
INDIRP4
ADDRLP4 4180
INDIRP4
INDIRF4
ADDRLP4 4176
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDF4
ASGNF4
line 284
;284:			}
LABELV $193
line 285
;285:		}
LABELV $189
line 279
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 3
LTI4 $188
line 286
;286:	}
LABELV $174
line 290
;287:
;288:	// unlink the pusher so we don't get it in the entityList
;289:	//pusher->relink = 0;
;290:	trap_UnlinkEntity( pusher );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 292
;291:
;292:	listedEntities = trap_EntitiesInBox( totalMins, totalMaxs, entityList, MAX_GENTITIES );
ADDRLP4 4140
ARGP4
ADDRLP4 4152
ARGP4
ADDRLP4 40
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 4176
ADDRGP4 trap_EntitiesInBox
CALLI4
ASGNI4
ADDRLP4 4136
ADDRLP4 4176
INDIRI4
ASGNI4
line 295
;293:
;294:	// move the pusher to it's final position
;295:	VectorAdd( pusher->r.currentOrigin, move, pusher->r.currentOrigin );
ADDRLP4 4180
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ASGNP4
ADDRLP4 4180
INDIRP4
ADDRLP4 4180
INDIRP4
INDIRF4
ADDRFP4 4
INDIRP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4184
ADDRFP4 0
INDIRP4
CNSTI4 492
ADDP4
ASGNP4
ADDRLP4 4184
INDIRP4
ADDRLP4 4184
INDIRP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4188
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
ASGNP4
ADDRLP4 4188
INDIRP4
ADDRLP4 4188
INDIRP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
ASGNF4
line 296
;296:	VectorAdd( pusher->r.currentAngles, amove, pusher->r.currentAngles );
ADDRLP4 4192
ADDRFP4 0
INDIRP4
CNSTI4 500
ADDP4
ASGNP4
ADDRLP4 4192
INDIRP4
ADDRLP4 4192
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4196
ADDRFP4 0
INDIRP4
CNSTI4 504
ADDP4
ASGNP4
ADDRLP4 4196
INDIRP4
ADDRLP4 4196
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4200
ADDRFP4 0
INDIRP4
CNSTI4 508
ADDP4
ASGNP4
ADDRLP4 4200
INDIRP4
ADDRLP4 4200
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
ASGNF4
line 297
;297:	trap_LinkEntity( pusher );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 300
;298:
;299:	// see if any solid entities are inside the final position
;300:	for ( e = 0 ; e < listedEntities ; e++ ) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $197
JUMPV
LABELV $194
line 301
;301:		check = &g_entities[ entityList[ e ] ];
ADDRLP4 8
CNSTI4 896
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 40
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 340
;302:
;303:#ifdef MISSIONPACK
;304:		if ( check->s.eType == ET_MISSILE ) {
;305:			// if it is a prox mine
;306:			if ( !strcmp(check->classname, "prox mine") ) {
;307:				// if this prox mine is attached to this mover try to move it with the pusher
;308:				if ( check->enemy == pusher ) {
;309:					if (!G_TryPushingProxMine( check, pusher, move, amove )) {
;310:						//explode
;311:						check->s.loopSound = 0;
;312:						G_AddEvent( check, EV_PROXIMITY_MINE_TRIGGER, 0 );
;313:						G_ExplodeMissile(check);
;314:						if (check->activator) {
;315:							G_FreeEntity(check->activator);
;316:							check->activator = NULL;
;317:						}
;318:						//G_Printf("prox mine explodes\n");
;319:					}
;320:				}
;321:				else {
;322:					//check if the prox mine is crushed by the mover
;323:					if (!G_CheckProxMinePosition( check )) {
;324:						//explode
;325:						check->s.loopSound = 0;
;326:						G_AddEvent( check, EV_PROXIMITY_MINE_TRIGGER, 0 );
;327:						G_ExplodeMissile(check);
;328:						if (check->activator) {
;329:							G_FreeEntity(check->activator);
;330:							check->activator = NULL;
;331:						}
;332:						//G_Printf("prox mine explodes\n");
;333:					}
;334:				}
;335:				continue;
;336:			}
;337:		}
;338:#endif
;339:		// only push items and players
;340:		if ( check->s.eType != ET_ITEM && check->s.eType != ET_PLAYER && !check->physicsObject ) {
ADDRLP4 4208
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 4208
INDIRI4
CNSTI4 2
EQI4 $198
ADDRLP4 4208
INDIRI4
CNSTI4 1
EQI4 $198
ADDRLP4 8
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
CNSTI4 0
NEI4 $198
line 341
;341:			continue;
ADDRGP4 $195
JUMPV
LABELV $198
line 345
;342:		}
;343:
;344:		// if the entity is standing on the pusher, it will definitely be moved
;345:		if ( check->s.groundEntityNum != pusher->s.number ) {
ADDRLP4 8
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
INDIRI4
EQI4 $200
line 347
;346:			// see if the ent needs to be tested
;347:			if ( check->r.absmin[0] >= maxs[0]
ADDRLP4 8
INDIRP4
CNSTI4 464
ADDP4
INDIRF4
ADDRLP4 28
INDIRF4
GEF4 $212
ADDRLP4 8
INDIRP4
CNSTI4 468
ADDP4
INDIRF4
ADDRLP4 28+4
INDIRF4
GEF4 $212
ADDRLP4 8
INDIRP4
CNSTI4 472
ADDP4
INDIRF4
ADDRLP4 28+8
INDIRF4
GEF4 $212
ADDRLP4 8
INDIRP4
CNSTI4 476
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
LEF4 $212
ADDRLP4 8
INDIRP4
CNSTI4 480
ADDP4
INDIRF4
ADDRLP4 16+4
INDIRF4
LEF4 $212
ADDRLP4 8
INDIRP4
CNSTI4 484
ADDP4
INDIRF4
ADDRLP4 16+8
INDIRF4
GTF4 $202
LABELV $212
line 352
;348:			|| check->r.absmin[1] >= maxs[1]
;349:			|| check->r.absmin[2] >= maxs[2]
;350:			|| check->r.absmax[0] <= mins[0]
;351:			|| check->r.absmax[1] <= mins[1]
;352:			|| check->r.absmax[2] <= mins[2] ) {
line 353
;353:				continue;
ADDRGP4 $195
JUMPV
LABELV $202
line 357
;354:			}
;355:			// see if the ent's bbox is inside the pusher's final position
;356:			// this does allow a fast moving object to pass through a thin entity...
;357:			if (!G_TestEntityPosition (check)) {
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 4216
ADDRGP4 G_TestEntityPosition
CALLP4
ASGNP4
ADDRLP4 4216
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $213
line 358
;358:				continue;
ADDRGP4 $195
JUMPV
LABELV $213
line 360
;359:			}
;360:		}
LABELV $200
line 363
;361:
;362:		// the entity needs to be pushed
;363:		if ( G_TryPushingEntity( check, pusher, move, amove ) ) {
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4212
ADDRGP4 G_TryPushingEntity
CALLI4
ASGNI4
ADDRLP4 4212
INDIRI4
CNSTI4 0
EQI4 $215
line 364
;364:			continue;
ADDRGP4 $195
JUMPV
LABELV $215
line 370
;365:		}
;366:
;367:		// the move was blocked an entity
;368:
;369:		// bobbing entities are instant-kill and never get blocked
;370:		if ( pusher->s.pos.trType == TR_SINE || pusher->s.apos.trType == TR_SINE ) {
ADDRLP4 4216
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4220
CNSTI4 4
ASGNI4
ADDRLP4 4216
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 4220
INDIRI4
EQI4 $219
ADDRLP4 4216
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
ADDRLP4 4220
INDIRI4
NEI4 $217
LABELV $219
line 371
;371:			G_Damage( check, pusher, pusher, NULL, NULL, 99999, 0, MOD_CRUSH );
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 4224
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4224
INDIRP4
ARGP4
ADDRLP4 4224
INDIRP4
ARGP4
ADDRLP4 4228
CNSTP4 0
ASGNP4
ADDRLP4 4228
INDIRP4
ARGP4
ADDRLP4 4228
INDIRP4
ARGP4
CNSTI4 99999
ARGI4
CNSTI4 0
ARGI4
CNSTI4 17
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 372
;372:			continue;
ADDRGP4 $195
JUMPV
LABELV $217
line 377
;373:		}
;374:
;375:		
;376:		// save off the obstacle so we can call the block function (crush, etc)
;377:		*obstacle = check;
ADDRFP4 12
INDIRP4
ADDRLP4 8
INDIRP4
ASGNP4
line 382
;378:
;379:		// move back any entities we already moved
;380:		// go backwards, so if the same entity was pushed
;381:		// twice, it goes back to the original position
;382:		for ( p=pushed_p-1 ; p>=pushed ; p-- ) {
ADDRLP4 0
ADDRGP4 pushed_p
INDIRP4
CNSTI4 -32
ADDP4
ASGNP4
ADDRGP4 $223
JUMPV
LABELV $220
line 383
;383:			VectorCopy (p->origin, p->ent->s.pos.trBase);
ADDRLP4 0
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRB
ASGNB 12
line 384
;384:			VectorCopy (p->angles, p->ent->s.apos.trBase);
ADDRLP4 0
INDIRP4
INDIRP4
CNSTI4 60
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRB
ASGNB 12
line 385
;385:			if ( p->ent->client ) {
ADDRLP4 0
INDIRP4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $224
line 386
;386:				p->ent->client->ps.delta_angles[YAW] = p->deltayaw;
ADDRLP4 0
INDIRP4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 60
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 387
;387:				VectorCopy (p->origin, p->ent->client->ps.origin);
ADDRLP4 0
INDIRP4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRB
ASGNB 12
line 388
;388:			}
LABELV $224
line 389
;389:			trap_LinkEntity (p->ent);
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 390
;390:		}
LABELV $221
line 382
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 -32
ADDP4
ASGNP4
LABELV $223
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 pushed
CVPU4 4
GEU4 $220
line 391
;391:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $172
JUMPV
LABELV $195
line 300
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $197
ADDRLP4 12
INDIRI4
ADDRLP4 4136
INDIRI4
LTI4 $194
line 394
;392:	}
;393:
;394:	return qtrue;
CNSTI4 1
RETI4
LABELV $172
endproc G_MoverPush 4240 32
export G_MoverTeam
proc G_MoverTeam 72 16
line 403
;395:}
;396:
;397:
;398:/*
;399:=================
;400:G_MoverTeam
;401:=================
;402:*/
;403:void G_MoverTeam( gentity_t *ent ) {
line 408
;404:	vec3_t		move, amove;
;405:	gentity_t	*part, *obstacle;
;406:	vec3_t		origin, angles;
;407:
;408:	obstacle = NULL;
ADDRLP4 52
CNSTP4 0
ASGNP4
line 413
;409:
;410:	// make sure all team slaves can move before commiting
;411:	// any moves or calling any think functions
;412:	// if the move is blocked, all moved objects will be backed out
;413:	pushed_p = pushed;
ADDRGP4 pushed_p
ADDRGP4 pushed
ASGNP4
line 414
;414:	for (part = ent ; part ; part=part->teamchain) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $230
JUMPV
LABELV $227
line 416
;415:		// get current position
;416:		BG_EvaluateTrajectory( &part->s.pos, level.time, origin );
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 level+40
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 417
;417:		BG_EvaluateTrajectory( &part->s.apos, level.time, angles );
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRGP4 level+40
INDIRI4
ARGI4
ADDRLP4 40
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 418
;418:		VectorSubtract( origin, part->r.currentOrigin, move );
ADDRLP4 4
ADDRLP4 28
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 28+4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 28+8
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
SUBF4
ASGNF4
line 419
;419:		VectorSubtract( angles, part->r.currentAngles, amove );
ADDRLP4 16
ADDRLP4 40
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 40+4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 504
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 40+8
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 508
ADDP4
INDIRF4
SUBF4
ASGNF4
line 420
;420:		if ( !G_MoverPush( part, move, amove, &obstacle ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 52
ARGP4
ADDRLP4 64
ADDRGP4 G_MoverPush
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
NEI4 $241
line 421
;421:			break;	// move was blocked
ADDRGP4 $229
JUMPV
LABELV $241
line 423
;422:		}
;423:	}
LABELV $228
line 414
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRP4
ASGNP4
LABELV $230
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $227
LABELV $229
line 425
;424:
;425:	if (part) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $243
line 427
;426:		// go back to the previous position
;427:		for ( part = ent ; part ; part = part->teamchain ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $248
JUMPV
LABELV $245
line 428
;428:			part->s.pos.trTime += level.time - level.previousTime;
ADDRLP4 56
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
ADDRGP4 level+40
INDIRI4
ADDRGP4 level+44
INDIRI4
SUBI4
ADDI4
ASGNI4
line 429
;429:			part->s.apos.trTime += level.time - level.previousTime;
ADDRLP4 60
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
ADDRGP4 level+40
INDIRI4
ADDRGP4 level+44
INDIRI4
SUBI4
ADDI4
ASGNI4
line 430
;430:			BG_EvaluateTrajectory( &part->s.pos, level.time, part->r.currentOrigin );
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 level+40
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 431
;431:			BG_EvaluateTrajectory( &part->s.apos, level.time, part->r.currentAngles );
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRGP4 level+40
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 500
ADDP4
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 432
;432:			trap_LinkEntity( part );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 433
;433:		}
LABELV $246
line 427
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRP4
ASGNP4
LABELV $248
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $245
line 436
;434:
;435:		// if the pusher has a "blocked" function, call it
;436:		if (ent->blocked) {
ADDRFP4 0
INDIRP4
CNSTI4 700
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $226
line 437
;437:			ent->blocked( ent, obstacle );
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 56
INDIRP4
CNSTI4 700
ADDP4
INDIRP4
CALLV
pop
line 438
;438:		}
line 439
;439:		return;
ADDRGP4 $226
JUMPV
LABELV $243
line 443
;440:	}
;441:
;442:	// the move succeeded
;443:	for ( part = ent ; part ; part = part->teamchain ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $260
JUMPV
LABELV $257
line 445
;444:		// call the reached function if time is at or past end point
;445:		if ( part->s.pos.trType == TR_LINEAR_STOP ) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 3
NEI4 $261
line 446
;446:			if ( level.time >= part->s.pos.trTime + part->s.pos.trDuration ) {
ADDRGP4 level+40
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ADDI4
LTI4 $263
line 447
;447:				if ( part->reached ) {
ADDRLP4 0
INDIRP4
CNSTI4 696
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $266
line 448
;448:					part->reached( part );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 696
ADDP4
INDIRP4
CALLV
pop
line 449
;449:				}
LABELV $266
line 450
;450:			}
LABELV $263
line 451
;451:		}
LABELV $261
line 452
;452:	}
LABELV $258
line 443
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRP4
ASGNP4
LABELV $260
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $257
line 453
;453:}
LABELV $226
endproc G_MoverTeam 72 16
export G_RunMover
proc G_RunMover 12 4
line 461
;454:
;455:/*
;456:================
;457:G_RunMover
;458:
;459:================
;460:*/
;461:void G_RunMover( gentity_t *ent ) {
line 464
;462:	// if not a team captain, don't do anything, because
;463:	// the captain will handle everything
;464:	if ( ent->flags & FL_TEAMSLAVE ) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $269
line 465
;465:		return;
ADDRGP4 $268
JUMPV
LABELV $269
line 469
;466:	}
;467:
;468:	// if stationary at one of the positions, don't move anything
;469:	if ( ent->s.pos.trType != TR_STATIONARY || ent->s.apos.trType != TR_STATIONARY ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $273
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $271
LABELV $273
line 470
;470:		if(level.match_timeout == 0) 
ADDRGP4 level+10800
INDIRU1
CVUI4 1
CNSTI4 0
NEI4 $274
line 471
;471:		G_MoverTeam( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_MoverTeam
CALLV
pop
ADDRGP4 $275
JUMPV
LABELV $274
line 473
;472:		else 
;473:			ent->s.pos.trTime += level.time - level.previousTime;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRGP4 level+40
INDIRI4
ADDRGP4 level+44
INDIRI4
SUBI4
ADDI4
ASGNI4
LABELV $275
line 474
;474:	}
LABELV $271
line 477
;475:
;476:	// check think function
;477:	G_RunThink( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_RunThink
CALLV
pop
line 478
;478:}
LABELV $268
endproc G_RunMover 12 4
export SetMoverState
proc SetMoverState 56 12
line 495
;479:
;480:/*
;481:============================================================================
;482:
;483:GENERAL MOVERS
;484:
;485:Doors, plats, and buttons are all binary (two position) movers
;486:Pos1 is "at rest", pos2 is "activated"
;487:============================================================================
;488:*/
;489:
;490:/*
;491:===============
;492:SetMoverState
;493:===============
;494:*/
;495:void SetMoverState( gentity_t *ent, moverState_t moverState, int time ) {
line 499
;496:	vec3_t			delta;
;497:	float			f;
;498:
;499:	ent->moverState = moverState;
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 501
;500:
;501:	ent->s.pos.trTime = time;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 502
;502:	switch( moverState ) {
ADDRLP4 16
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
LTI4 $280
ADDRLP4 16
INDIRI4
CNSTI4 3
GTI4 $280
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $295
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $295
address $283
address $284
address $285
address $290
code
LABELV $283
line 504
;503:	case MOVER_POS1:
;504:		VectorCopy( ent->pos1, ent->s.pos.trBase );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 612
ADDP4
INDIRB
ASGNB 12
line 505
;505:		ent->s.pos.trType = TR_STATIONARY;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 506
;506:		break;
ADDRGP4 $281
JUMPV
LABELV $284
line 508
;507:	case MOVER_POS2:
;508:		VectorCopy( ent->pos2, ent->s.pos.trBase );
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 624
ADDP4
INDIRB
ASGNB 12
line 509
;509:		ent->s.pos.trType = TR_STATIONARY;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 510
;510:		break;
ADDRGP4 $281
JUMPV
LABELV $285
line 512
;511:	case MOVER_1TO2:
;512:		VectorCopy( ent->pos1, ent->s.pos.trBase );
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 32
INDIRP4
CNSTI4 612
ADDP4
INDIRB
ASGNB 12
line 513
;513:		VectorSubtract( ent->pos2, ent->pos1, delta );
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 36
INDIRP4
CNSTI4 624
ADDP4
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 612
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 36
INDIRP4
CNSTI4 628
ADDP4
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 616
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 40
INDIRP4
CNSTI4 632
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 620
ADDP4
INDIRF4
SUBF4
ASGNF4
line 514
;514:		f = 1000.0 / ent->s.pos.trDuration;
ADDRLP4 12
CNSTF4 1148846080
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 515
;515:		VectorScale( delta, f, ent->s.pos.trDelta );
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 0+4
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 0+8
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ASGNF4
line 516
;516:		ent->s.pos.trType = TR_LINEAR_STOP;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 3
ASGNI4
line 517
;517:		break;
ADDRGP4 $281
JUMPV
LABELV $290
line 519
;518:	case MOVER_2TO1:
;519:		VectorCopy( ent->pos2, ent->s.pos.trBase );
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 44
INDIRP4
CNSTI4 624
ADDP4
INDIRB
ASGNB 12
line 520
;520:		VectorSubtract( ent->pos1, ent->pos2, delta );
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 48
INDIRP4
CNSTI4 612
ADDP4
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 624
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 48
INDIRP4
CNSTI4 616
ADDP4
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 628
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 52
INDIRP4
CNSTI4 620
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 632
ADDP4
INDIRF4
SUBF4
ASGNF4
line 521
;521:		f = 1000.0 / ent->s.pos.trDuration;
ADDRLP4 12
CNSTF4 1148846080
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 522
;522:		VectorScale( delta, f, ent->s.pos.trDelta );
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 0+4
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 0+8
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ASGNF4
line 523
;523:		ent->s.pos.trType = TR_LINEAR_STOP;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 3
ASGNI4
line 524
;524:		break;
LABELV $280
LABELV $281
line 526
;525:	}
;526:	BG_EvaluateTrajectory( &ent->s.pos, level.time, ent->r.currentOrigin );	
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 level+40
INDIRI4
ARGI4
ADDRLP4 24
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 527
;527:	trap_LinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 528
;528:}
LABELV $279
endproc SetMoverState 56 12
export MatchTeam
proc MatchTeam 4 12
line 538
;529:
;530:/*
;531:================
;532:MatchTeam
;533:
;534:All entities in a mover team will move from pos1 to pos2
;535:in the same amount of time
;536:================
;537:*/
;538:void MatchTeam( gentity_t *teamLeader, int moverState, int time ) {
line 541
;539:	gentity_t		*slave;
;540:
;541:	for ( slave = teamLeader ; slave ; slave = slave->teamchain ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $301
JUMPV
LABELV $298
line 542
;542:		SetMoverState( slave, moverState, time );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 SetMoverState
CALLV
pop
line 543
;543:	}
LABELV $299
line 541
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRP4
ASGNP4
LABELV $301
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $298
line 544
;544:}
LABELV $297
endproc MatchTeam 4 12
export ReturnToPos1
proc ReturnToPos1 8 12
line 553
;545:
;546:
;547:
;548:/*
;549:================
;550:ReturnToPos1
;551:================
;552:*/
;553:void ReturnToPos1( gentity_t *ent ) {
line 554
;554:	MatchTeam( ent, MOVER_2TO1, level.time );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 level+40
INDIRI4
ARGI4
ADDRGP4 MatchTeam
CALLV
pop
line 557
;555:
;556:	// looping sound
;557:	ent->s.loopSound = ent->soundLoop;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 596
ADDP4
INDIRI4
ASGNI4
line 560
;558:
;559:	// starting sound
;560:	if ( ent->sound2to1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 588
ADDP4
INDIRI4
CNSTI4 0
EQI4 $304
line 561
;561:		G_AddEvent( ent, EV_GENERAL_SOUND, ent->sound2to1 );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 45
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 588
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 562
;562:	}
LABELV $304
line 563
;563:}
LABELV $302
endproc ReturnToPos1 8 12
export Reached_BinaryMover
proc Reached_BinaryMover 12 12
line 571
;564:
;565:
;566:/*
;567:================
;568:Reached_BinaryMover
;569:================
;570:*/
;571:void Reached_BinaryMover( gentity_t *ent ) {
line 574
;572:
;573:	// stop the looping sound
;574:	ent->s.loopSound = ent->soundLoop;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 596
ADDP4
INDIRI4
ASGNI4
line 576
;575:
;576:	if ( ent->moverState == MOVER_1TO2 ) {
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
CNSTI4 2
NEI4 $307
line 578
;577:		// reached pos2
;578:		SetMoverState( ent, MOVER_POS2, level.time );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 level+40
INDIRI4
ARGI4
ADDRGP4 SetMoverState
CALLV
pop
line 581
;579:
;580:		// play sound
;581:		if ( ent->soundPos2 ) {
ADDRFP4 0
INDIRP4
CNSTI4 592
ADDP4
INDIRI4
CNSTI4 0
EQI4 $310
line 582
;582:			G_AddEvent( ent, EV_GENERAL_SOUND, ent->soundPos2 );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 45
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 592
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 583
;583:		}
LABELV $310
line 586
;584:
;585:		// return to pos1 after a delay
;586:		ent->think = ReturnToPos1;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 ReturnToPos1
ASGNP4
line 587
;587:		ent->nextthink = level.time + ent->wait;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRP4
CNSTI4 796
ADDP4
INDIRF4
ADDF4
CVFI4 4
ASGNI4
line 590
;588:
;589:		// fire targets
;590:		if ( !ent->activator ) {
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $313
line 591
;591:			ent->activator = ent;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 772
ADDP4
ADDRLP4 8
INDIRP4
ASGNP4
line 592
;592:		}
LABELV $313
line 593
;593:		G_UseTargets( ent, ent->activator );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_UseTargets
CALLV
pop
line 594
;594:	} else if ( ent->moverState == MOVER_2TO1 ) {
ADDRGP4 $308
JUMPV
LABELV $307
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
CNSTI4 3
NEI4 $315
line 596
;595:		// reached pos1
;596:		SetMoverState( ent, MOVER_POS1, level.time );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 level+40
INDIRI4
ARGI4
ADDRGP4 SetMoverState
CALLV
pop
line 599
;597:
;598:		// play sound
;599:		if ( ent->soundPos1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 580
ADDP4
INDIRI4
CNSTI4 0
EQI4 $318
line 600
;600:			G_AddEvent( ent, EV_GENERAL_SOUND, ent->soundPos1 );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 45
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 580
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 601
;601:		}
LABELV $318
line 604
;602:
;603:		// close areaportals
;604:		if ( ent->teammaster == ent || !ent->teammaster ) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 4
INDIRP4
CNSTI4 780
ADDP4
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 8
INDIRU4
ADDRLP4 4
INDIRP4
CVPU4 4
EQU4 $322
ADDRLP4 8
INDIRU4
CNSTU4 0
NEU4 $316
LABELV $322
line 605
;605:			trap_AdjustAreaPortalState( ent, qfalse );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_AdjustAreaPortalState
CALLV
pop
line 606
;606:		}
line 607
;607:	} else {
ADDRGP4 $316
JUMPV
LABELV $315
line 608
;608:		G_Error( "Reached_BinaryMover: bad moverState" );
ADDRGP4 $323
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 609
;609:	}
LABELV $316
LABELV $308
line 610
;610:}
LABELV $306
endproc Reached_BinaryMover 12 12
export Use_BinaryMover
proc Use_BinaryMover 20 12
line 618
;611:
;612:
;613:/*
;614:================
;615:Use_BinaryMover
;616:================
;617:*/
;618:void Use_BinaryMover( gentity_t *ent, gentity_t *other, gentity_t *activator ) {
line 623
;619:	int		total;
;620:	int		partial;
;621:
;622:	// only the master should be used
;623:	if ( ent->flags & FL_TEAMSLAVE ) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $325
line 624
;624:		Use_BinaryMover( ent->teammaster, other, activator );
ADDRFP4 0
INDIRP4
CNSTI4 780
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Use_BinaryMover
CALLV
pop
line 625
;625:		return;
ADDRGP4 $324
JUMPV
LABELV $325
line 628
;626:	}
;627:
;628:	ent->activator = activator;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
ADDRFP4 8
INDIRP4
ASGNP4
line 630
;629:
;630:	if ( ent->moverState == MOVER_POS1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
CNSTI4 0
NEI4 $327
line 633
;631:		// start moving 50 msec later, becase if this was player
;632:		// triggered, level.time hasn't been advanced yet
;633:		MatchTeam( ent, MOVER_1TO2, level.time + 50 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 level+40
INDIRI4
CNSTI4 50
ADDI4
ARGI4
ADDRGP4 MatchTeam
CALLV
pop
line 636
;634:
;635:		// starting sound
;636:		if ( ent->sound1to2 ) {
ADDRFP4 0
INDIRP4
CNSTI4 584
ADDP4
INDIRI4
CNSTI4 0
EQI4 $330
line 637
;637:			G_AddEvent( ent, EV_GENERAL_SOUND, ent->sound1to2 );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 45
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 584
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 638
;638:		}
LABELV $330
line 641
;639:
;640:		// looping sound
;641:		ent->s.loopSound = ent->soundLoop;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 156
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 596
ADDP4
INDIRI4
ASGNI4
line 644
;642:
;643:		// open areaportal
;644:		if ( ent->teammaster == ent || !ent->teammaster ) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 12
INDIRP4
CNSTI4 780
ADDP4
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 16
INDIRU4
ADDRLP4 12
INDIRP4
CVPU4 4
EQU4 $334
ADDRLP4 16
INDIRU4
CNSTU4 0
NEU4 $324
LABELV $334
line 645
;645:			trap_AdjustAreaPortalState( ent, qtrue );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 trap_AdjustAreaPortalState
CALLV
pop
line 646
;646:		}
line 647
;647:		return;
ADDRGP4 $324
JUMPV
LABELV $327
line 651
;648:	}
;649:
;650:	// if all the way up, just delay before coming down
;651:	if ( ent->moverState == MOVER_POS2 ) {
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
CNSTI4 1
NEI4 $335
line 652
;652:		ent->nextthink = level.time + ent->wait;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
CVIF4 4
ADDRLP4 8
INDIRP4
CNSTI4 796
ADDP4
INDIRF4
ADDF4
CVFI4 4
ASGNI4
line 653
;653:		return;
ADDRGP4 $324
JUMPV
LABELV $335
line 657
;654:	}
;655:
;656:	// only partway down before reversing
;657:	if ( ent->moverState == MOVER_2TO1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
CNSTI4 3
NEI4 $338
line 658
;658:		total = ent->s.pos.trDuration;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ASGNI4
line 659
;659:		partial = level.time - ent->s.pos.trTime;
ADDRLP4 4
ADDRGP4 level+40
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
SUBI4
ASGNI4
line 660
;660:		if ( partial > total ) {
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $341
line 661
;661:			partial = total;
ADDRLP4 4
ADDRLP4 0
INDIRI4
ASGNI4
line 662
;662:		}
LABELV $341
line 664
;663:
;664:		MatchTeam( ent, MOVER_1TO2, level.time - ( total - partial ) );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 level+40
INDIRI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
SUBI4
ARGI4
ADDRGP4 MatchTeam
CALLV
pop
line 666
;665:
;666:		if ( ent->sound1to2 ) {
ADDRFP4 0
INDIRP4
CNSTI4 584
ADDP4
INDIRI4
CNSTI4 0
EQI4 $324
line 667
;667:			G_AddEvent( ent, EV_GENERAL_SOUND, ent->sound1to2 );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 45
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 584
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 668
;668:		}
line 669
;669:		return;
ADDRGP4 $324
JUMPV
LABELV $338
line 673
;670:	}
;671:
;672:	// only partway up before reversing
;673:	if ( ent->moverState == MOVER_1TO2 ) {
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
CNSTI4 2
NEI4 $346
line 674
;674:		total = ent->s.pos.trDuration;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ASGNI4
line 675
;675:		partial = level.time - ent->s.pos.trTime;
ADDRLP4 4
ADDRGP4 level+40
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
SUBI4
ASGNI4
line 676
;676:		if ( partial > total ) {
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $349
line 677
;677:			partial = total;
ADDRLP4 4
ADDRLP4 0
INDIRI4
ASGNI4
line 678
;678:		}
LABELV $349
line 680
;679:
;680:		MatchTeam( ent, MOVER_2TO1, level.time - ( total - partial ) );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 level+40
INDIRI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
SUBI4
ARGI4
ADDRGP4 MatchTeam
CALLV
pop
line 682
;681:
;682:		if ( ent->sound2to1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 588
ADDP4
INDIRI4
CNSTI4 0
EQI4 $324
line 683
;683:			G_AddEvent( ent, EV_GENERAL_SOUND, ent->sound2to1 );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 45
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 588
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 684
;684:		}
line 685
;685:		return;
LABELV $346
line 687
;686:	}
;687:}
LABELV $324
endproc Use_BinaryMover 20 12
export InitMover
proc InitMover 100 12
line 699
;688:
;689:
;690:
;691:/*
;692:================
;693:InitMover
;694:
;695:"pos1", "pos2", and "speed" should be set before calling,
;696:so the movement delta can be calculated
;697:================
;698:*/
;699:void InitMover( gentity_t *ent ) {
line 709
;700:	vec3_t		move;
;701:	float		distance;
;702:	float		light;
;703:	vec3_t		color;
;704:	qboolean	lightSet, colorSet;
;705:	char		*sound;
;706:
;707:	// if the "model2" key is set, use a seperate model
;708:	// for drawing, but clip against the brushes
;709:	if ( ent->model2 ) {
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $355
line 710
;710:		ent->s.modelindex2 = G_ModelIndex( ent->model2 );
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 544
ADDP4
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 G_ModelIndex
CALLI4
ASGNI4
ADDRLP4 44
INDIRP4
CNSTI4 164
ADDP4
ADDRLP4 48
INDIRI4
ASGNI4
line 711
;711:	}
LABELV $355
line 714
;712:
;713:	// if the "loopsound" key is set, use a constant looping sound when moving
;714:	if ( G_SpawnString( "noise", "100", &sound ) ) {
ADDRGP4 $359
ARGP4
ADDRGP4 $360
ARGP4
ADDRLP4 40
ARGP4
ADDRLP4 44
ADDRGP4 G_SpawnString
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $357
line 715
;715:		ent->s.loopSound = G_SoundIndex( sound );
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
ADDRLP4 48
INDIRI4
ASGNI4
line 716
;716:	}
LABELV $357
line 719
;717:
;718:	// if the "color" or "light" keys are set, setup constantLight
;719:	lightSet = G_SpawnFloat( "light", "100", &light );
ADDRGP4 $361
ARGP4
ADDRGP4 $360
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 48
ADDRGP4 G_SpawnFloat
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 48
INDIRI4
ASGNI4
line 720
;720:	colorSet = G_SpawnVector( "color", "1 1 1", color );
ADDRGP4 $362
ARGP4
ADDRGP4 $363
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 52
ADDRGP4 G_SpawnVector
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 52
INDIRI4
ASGNI4
line 721
;721:	if ( lightSet || colorSet ) {
ADDRLP4 56
CNSTI4 0
ASGNI4
ADDRLP4 28
INDIRI4
ADDRLP4 56
INDIRI4
NEI4 $366
ADDRLP4 32
INDIRI4
ADDRLP4 56
INDIRI4
EQI4 $364
LABELV $366
line 724
;722:		int		r, g, b, i;
;723:
;724:		r = color[0] * 255;
ADDRLP4 60
CNSTF4 1132396544
ADDRLP4 12
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 725
;725:		if ( r > 255 ) {
ADDRLP4 60
INDIRI4
CNSTI4 255
LEI4 $367
line 726
;726:			r = 255;
ADDRLP4 60
CNSTI4 255
ASGNI4
line 727
;727:		}
LABELV $367
line 728
;728:		g = color[1] * 255;
ADDRLP4 64
CNSTF4 1132396544
ADDRLP4 12+4
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 729
;729:		if ( g > 255 ) {
ADDRLP4 64
INDIRI4
CNSTI4 255
LEI4 $370
line 730
;730:			g = 255;
ADDRLP4 64
CNSTI4 255
ASGNI4
line 731
;731:		}
LABELV $370
line 732
;732:		b = color[2] * 255;
ADDRLP4 68
CNSTF4 1132396544
ADDRLP4 12+8
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 733
;733:		if ( b > 255 ) {
ADDRLP4 68
INDIRI4
CNSTI4 255
LEI4 $373
line 734
;734:			b = 255;
ADDRLP4 68
CNSTI4 255
ASGNI4
line 735
;735:		}
LABELV $373
line 736
;736:		i = light / 4;
ADDRLP4 72
ADDRLP4 36
INDIRF4
CNSTF4 1082130432
DIVF4
CVFI4 4
ASGNI4
line 737
;737:		if ( i > 255 ) {
ADDRLP4 72
INDIRI4
CNSTI4 255
LEI4 $375
line 738
;738:			i = 255;
ADDRLP4 72
CNSTI4 255
ASGNI4
line 739
;739:		}
LABELV $375
line 740
;740:		ent->s.constantLight = r | ( g << 8 ) | ( b << 16 ) | ( i << 24 );
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ADDRLP4 60
INDIRI4
ADDRLP4 64
INDIRI4
CNSTI4 8
LSHI4
BORI4
ADDRLP4 68
INDIRI4
CNSTI4 16
LSHI4
BORI4
ADDRLP4 72
INDIRI4
CNSTI4 24
LSHI4
BORI4
ASGNI4
line 741
;741:	}
LABELV $364
line 744
;742:
;743:
;744:	ent->use = Use_BinaryMover;
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRGP4 Use_BinaryMover
ASGNP4
line 745
;745:	ent->reached = Reached_BinaryMover;
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 Reached_BinaryMover
ASGNP4
line 747
;746:
;747:	ent->moverState = MOVER_POS1;
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
CNSTI4 0
ASGNI4
line 748
;748:	ent->r.svFlags = SVF_USE_CURRENT_ORIGIN;
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 128
ASGNI4
line 749
;749:	ent->s.eType = ET_MOVER;
ADDRLP4 60
CNSTI4 4
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
ADDRLP4 60
INDIRI4
ASGNI4
line 750
;750:	VectorCopy (ent->pos1, ent->r.currentOrigin);
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 64
INDIRP4
CNSTI4 612
ADDP4
INDIRB
ASGNB 12
line 751
;751:	trap_LinkEntity (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 753
;752:
;753:	ent->s.pos.trType = TR_STATIONARY;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 754
;754:	VectorCopy( ent->pos1, ent->s.pos.trBase );
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 612
ADDP4
INDIRB
ASGNB 12
line 757
;755:
;756:	// calculate time to reach second position from speed
;757:	VectorSubtract( ent->pos2, ent->pos1, move );
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 72
INDIRP4
CNSTI4 624
ADDP4
INDIRF4
ADDRLP4 72
INDIRP4
CNSTI4 612
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 72
INDIRP4
CNSTI4 628
ADDP4
INDIRF4
ADDRLP4 72
INDIRP4
CNSTI4 616
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 76
INDIRP4
CNSTI4 632
ADDP4
INDIRF4
ADDRLP4 76
INDIRP4
CNSTI4 620
ADDP4
INDIRF4
SUBF4
ASGNF4
line 758
;758:	distance = VectorLength( move );
ADDRLP4 0
ARGP4
ADDRLP4 80
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 80
INDIRF4
ASGNF4
line 759
;759:	if ( ! ent->speed ) {
ADDRFP4 0
INDIRP4
CNSTI4 672
ADDP4
INDIRF4
CNSTF4 0
NEF4 $379
line 760
;760:		ent->speed = 100;
ADDRFP4 0
INDIRP4
CNSTI4 672
ADDP4
CNSTF4 1120403456
ASGNF4
line 761
;761:	}
LABELV $379
line 762
;762:	VectorScale( move, ent->speed, ent->s.pos.trDelta );
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 0
INDIRF4
ADDRLP4 84
INDIRP4
CNSTI4 672
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 0+4
INDIRF4
ADDRLP4 88
INDIRP4
CNSTI4 672
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 0+8
INDIRF4
ADDRLP4 92
INDIRP4
CNSTI4 672
ADDP4
INDIRF4
MULF4
ASGNF4
line 763
;763:	ent->s.pos.trDuration = distance * 1000 / ent->speed;
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 1148846080
ADDRLP4 24
INDIRF4
MULF4
ADDRLP4 96
INDIRP4
CNSTI4 672
ADDP4
INDIRF4
DIVF4
CVFI4 4
ASGNI4
line 764
;764:	if ( ent->s.pos.trDuration <= 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 0
GTI4 $383
line 765
;765:		ent->s.pos.trDuration = 1;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
CNSTI4 1
ASGNI4
line 766
;766:	}
LABELV $383
line 767
;767:}
LABELV $354
endproc InitMover 100 12
export Blocked_Door
proc Blocked_Door 8 32
line 786
;768:
;769:
;770:/*
;771:===============================================================================
;772:
;773:DOOR
;774:
;775:A use can be triggered either by a touch function, by being shot, or by being
;776:targeted by another entity.
;777:
;778:===============================================================================
;779:*/
;780:
;781:/*
;782:================
;783:Blocked_Door
;784:================
;785:*/
;786:void Blocked_Door( gentity_t *ent, gentity_t *other ) {
line 788
;787:	// remove anything other than a client
;788:	if ( !other->client ) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $386
line 790
;789:		// except CTF flags!!!!
;790:		if( other->s.eType == ET_ITEM && other->item->giType == IT_TEAM ) {
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $388
ADDRLP4 0
INDIRP4
CNSTI4 804
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $388
line 791
;791:			Team_DroppedFlagThink( other );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Team_DroppedFlagThink
CALLV
pop
line 792
;792:			return;
ADDRGP4 $385
JUMPV
LABELV $388
line 795
;793:		}
;794://freeze
;795:		if ( g_gamemode.integer > 3 && is_body( other ) ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $390
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 is_body
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $390
line 796
;796:			Body_free( other );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Body_free
CALLV
pop
line 797
;797:			return;
ADDRGP4 $385
JUMPV
LABELV $390
line 800
;798:		}
;799://freeze
;800:		G_TempEntity( other->s.origin, EV_ITEM_POP );
ADDRFP4 4
INDIRP4
CNSTI4 92
ADDP4
ARGP4
CNSTI4 41
ARGI4
ADDRGP4 G_TempEntity
CALLP4
pop
line 801
;801:		G_FreeEntity( other );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 802
;802:		return;
ADDRGP4 $385
JUMPV
LABELV $386
line 805
;803:	}
;804:
;805:	if ( ent->damage ) {
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
CNSTI4 0
EQI4 $393
line 806
;806:		G_Damage( other, ent, ent, NULL, NULL, ent->damage, 0, MOD_CRUSH );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
CNSTP4 0
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 17
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 807
;807:	}
LABELV $393
line 808
;808:	if ( ent->spawnflags & 4 ) {
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $395
line 809
;809:		return;		// crushers don't reverse
ADDRGP4 $385
JUMPV
LABELV $395
line 813
;810:	}
;811:
;812:	// reverse direction
;813:	Use_BinaryMover( ent, ent, other );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Use_BinaryMover
CALLV
pop
line 814
;814:}
LABELV $385
endproc Blocked_Door 8 32
proc Touch_DoorTriggerSpectator 72 16
line 821
;815:
;816:/*
;817:================
;818:Touch_DoorTriggerSpectator
;819:================
;820:*/
;821:static void Touch_DoorTriggerSpectator( gentity_t *ent, gentity_t *other, trace_t *trace ) {
line 825
;822:	int i, axis;
;823:	vec3_t origin, dir, angles;
;824:
;825:	axis = ent->count;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ASGNI4
line 826
;826:	VectorClear(dir);
ADDRLP4 44
CNSTF4 0
ASGNF4
ADDRLP4 20+8
ADDRLP4 44
INDIRF4
ASGNF4
ADDRLP4 20+4
ADDRLP4 44
INDIRF4
ASGNF4
ADDRLP4 20
ADDRLP4 44
INDIRF4
ASGNF4
line 827
;827:	if (fabs(other->s.origin[axis] - ent->r.absmax[axis]) <
ADDRLP4 48
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 48
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 92
ADDP4
ADDP4
INDIRF4
ADDRLP4 48
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRF4
SUBF4
ARGF4
ADDRLP4 52
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 56
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 56
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 92
ADDP4
ADDP4
INDIRF4
ADDRLP4 56
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 464
ADDP4
ADDP4
INDIRF4
SUBF4
ARGF4
ADDRLP4 60
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 52
INDIRF4
ADDRLP4 60
INDIRF4
GEF4 $400
line 828
;828:		fabs(other->s.origin[axis] - ent->r.absmin[axis])) {
line 829
;829:		origin[axis] = ent->r.absmin[axis] - 10;
ADDRLP4 64
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 64
INDIRI4
ADDRLP4 8
ADDP4
ADDRLP4 64
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 464
ADDP4
ADDP4
INDIRF4
CNSTF4 1092616192
SUBF4
ASGNF4
line 830
;830:		dir[axis] = -1;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
ADDP4
CNSTF4 3212836864
ASGNF4
line 831
;831:	}
ADDRGP4 $401
JUMPV
LABELV $400
line 832
;832:	else {
line 833
;833:		origin[axis] = ent->r.absmax[axis] + 10;
ADDRLP4 64
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 64
INDIRI4
ADDRLP4 8
ADDP4
ADDRLP4 64
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
line 834
;834:		dir[axis] = 1;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
ADDP4
CNSTF4 1065353216
ASGNF4
line 835
;835:	}
LABELV $401
line 836
;836:	for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $402
line 837
;837:		if (i == axis) continue;
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $406
ADDRGP4 $403
JUMPV
LABELV $406
line 838
;838:		origin[i] = (ent->r.absmin[i] + ent->r.absmax[i]) * 0.5;
ADDRLP4 64
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRI4
ADDRLP4 8
ADDP4
CNSTF4 1056964608
ADDRLP4 64
INDIRI4
ADDRLP4 68
INDIRP4
CNSTI4 464
ADDP4
ADDP4
INDIRF4
ADDRLP4 64
INDIRI4
ADDRLP4 68
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRF4
ADDF4
MULF4
ASGNF4
line 839
;839:	}
LABELV $403
line 836
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $402
line 840
;840:	vectoangles(dir, angles);
ADDRLP4 20
ARGP4
ADDRLP4 32
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 841
;841:	TeleportPlayer(other, origin, angles, qtrue );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 32
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 TeleportPlayer
CALLV
pop
line 842
;842:}
LABELV $397
endproc Touch_DoorTriggerSpectator 72 16
export Touch_DoorTrigger
proc Touch_DoorTrigger 16 12
line 849
;843:
;844:/*
;845:================
;846:Touch_DoorTrigger
;847:================
;848:*/
;849:void Touch_DoorTrigger( gentity_t *ent, gentity_t *other, trace_t *trace ) {
line 853
;850:/*freeze
;851:	if ( other->client && other->client->sess.sessionTeam == TEAM_SPECTATOR ) {
;852:freeze*/
;853:	if ( (g_gamemode.integer > 3 && other->client && is_spectator( other->client )) || 
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $415
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $415
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 is_spectator
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $413
LABELV $415
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 4
GEI4 $409
ADDRLP4 8
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $409
ADDRLP4 8
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
CNSTI4 3
NEI4 $409
LABELV $413
line 854
;854:		 (g_gamemode.integer < 4 && other->client && other->client->sess.sessionTeam == TEAM_SPECTATOR) ) {
line 857
;855://freeze
;856:		// if the door is not open and not opening
;857:		if ( ent->parent->moverState != MOVER_1TO2 &&
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 600
ADDP4
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 2
EQI4 $410
ADDRLP4 12
INDIRI4
CNSTI4 1
EQI4 $410
line 858
;858:			ent->parent->moverState != MOVER_POS2) {
line 859
;859:			Touch_DoorTriggerSpectator( ent, other, trace );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Touch_DoorTriggerSpectator
CALLV
pop
line 860
;860:		}
line 861
;861:	}
ADDRGP4 $410
JUMPV
LABELV $409
line 862
;862:	else if ( ent->parent->moverState != MOVER_1TO2 ) {
ADDRFP4 0
INDIRP4
CNSTI4 600
ADDP4
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
CNSTI4 2
EQI4 $418
line 863
;863:		Use_BinaryMover( ent->parent, ent, other );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 600
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Use_BinaryMover
CALLV
pop
line 864
;864:	}
LABELV $418
LABELV $410
line 865
;865:}
LABELV $408
endproc Touch_DoorTrigger 16 12
export Think_SpawnNewDoorTrigger
proc Think_SpawnNewDoorTrigger 52 12
line 876
;866:
;867:
;868:/*
;869:======================
;870:Think_SpawnNewDoorTrigger
;871:
;872:All of the parts of a door have been spawned, so create
;873:a trigger that encloses all of them
;874:======================
;875:*/
;876:void Think_SpawnNewDoorTrigger( gentity_t *ent ) {
line 882
;877:	gentity_t		*other;
;878:	vec3_t		mins, maxs;
;879:	int			i, best;
;880:
;881:	// set all of the slaves as shootable
;882:	for ( other = ent ; other ; other = other->teamchain ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $424
JUMPV
LABELV $421
line 883
;883:		other->takedamage = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 1
ASGNI4
line 884
;884:	}
LABELV $422
line 882
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRP4
ASGNP4
LABELV $424
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $421
line 887
;885:
;886:	// find the bounds of everything on the team
;887:	VectorCopy (ent->r.absmin, mins);
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 464
ADDP4
INDIRB
ASGNB 12
line 888
;888:	VectorCopy (ent->r.absmax, maxs);
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 476
ADDP4
INDIRB
ASGNB 12
line 890
;889:
;890:	for (other = ent->teamchain ; other ; other=other->teamchain) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRP4
ASGNP4
ADDRGP4 $428
JUMPV
LABELV $425
line 891
;891:		AddPointToBounds (other->r.absmin, mins, maxs);
ADDRLP4 0
INDIRP4
CNSTI4 464
ADDP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 AddPointToBounds
CALLV
pop
line 892
;892:		AddPointToBounds (other->r.absmax, mins, maxs);
ADDRLP4 0
INDIRP4
CNSTI4 476
ADDP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 AddPointToBounds
CALLV
pop
line 893
;893:	}
LABELV $426
line 890
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRP4
ASGNP4
LABELV $428
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $425
line 896
;894:
;895:	// find the thinnest axis, which will be the one we expand
;896:	best = 0;
ADDRLP4 32
CNSTI4 0
ASGNI4
line 897
;897:	for ( i = 1 ; i < 3 ; i++ ) {
ADDRLP4 4
CNSTI4 1
ASGNI4
LABELV $429
line 898
;898:		if ( maxs[i] - mins[i] < maxs[best] - mins[best] ) {
ADDRLP4 36
CNSTI4 2
ASGNI4
ADDRLP4 40
ADDRLP4 4
INDIRI4
ADDRLP4 36
INDIRI4
LSHI4
ASGNI4
ADDRLP4 44
ADDRLP4 32
INDIRI4
ADDRLP4 36
INDIRI4
LSHI4
ASGNI4
ADDRLP4 40
INDIRI4
ADDRLP4 20
ADDP4
INDIRF4
ADDRLP4 40
INDIRI4
ADDRLP4 8
ADDP4
INDIRF4
SUBF4
ADDRLP4 44
INDIRI4
ADDRLP4 20
ADDP4
INDIRF4
ADDRLP4 44
INDIRI4
ADDRLP4 8
ADDP4
INDIRF4
SUBF4
GEF4 $433
line 899
;899:			best = i;
ADDRLP4 32
ADDRLP4 4
INDIRI4
ASGNI4
line 900
;900:		}
LABELV $433
line 901
;901:	}
LABELV $430
line 897
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 3
LTI4 $429
line 902
;902:	maxs[best] += 120;
ADDRLP4 36
ADDRLP4 32
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 903
;903:	mins[best] -= 120;
ADDRLP4 40
ADDRLP4 32
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRF4
CNSTF4 1123024896
SUBF4
ASGNF4
line 906
;904:
;905:	// create a trigger with this size
;906:	other = G_Spawn ();
ADDRLP4 44
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 44
INDIRP4
ASGNP4
line 907
;907:	other->classname = "door_trigger";
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $435
ASGNP4
line 908
;908:	VectorCopy (mins, other->r.mins);
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRLP4 8
INDIRB
ASGNB 12
line 909
;909:	VectorCopy (maxs, other->r.maxs);
ADDRLP4 0
INDIRP4
CNSTI4 448
ADDP4
ADDRLP4 20
INDIRB
ASGNB 12
line 910
;910:	other->parent = ent;
ADDRLP4 0
INDIRP4
CNSTI4 600
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 911
;911:	other->r.contents = CONTENTS_TRIGGER;
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 1073741824
ASGNI4
line 912
;912:	other->touch = Touch_DoorTrigger;
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
ADDRGP4 Touch_DoorTrigger
ASGNP4
line 914
;913:	// remember the thinnest axis
;914:	other->count = best;
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
ADDRLP4 32
INDIRI4
ASGNI4
line 915
;915:	trap_LinkEntity (other);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 917
;916:
;917:	MatchTeam( ent, ent->moverState, level.time );
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRLP4 48
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRGP4 level+40
INDIRI4
ARGI4
ADDRGP4 MatchTeam
CALLV
pop
line 918
;918:}
LABELV $420
endproc Think_SpawnNewDoorTrigger 52 12
export Think_MatchTeam
proc Think_MatchTeam 4 12
line 920
;919:
;920:void Think_MatchTeam( gentity_t *ent ) {
line 921
;921:	MatchTeam( ent, ent->moverState, level.time );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRGP4 level+40
INDIRI4
ARGI4
ADDRGP4 MatchTeam
CALLV
pop
line 922
;922:}
LABELV $437
endproc Think_MatchTeam 4 12
export SP_func_door
proc SP_func_door 112 12
line 941
;923:
;924:
;925:/*QUAKED func_door (0 .5 .8) ? START_OPEN x CRUSHER
;926:TOGGLE		wait in both the start and end states for a trigger event.
;927:START_OPEN	the door to moves to its destination when spawned, and operate in reverse.  It is used to temporarily or permanently close off an area when triggered (not useful for touch or takedamage doors).
;928:NOMONSTER	monsters will not trigger this door
;929:
;930:"model2"	.md3 model to also draw
;931:"angle"		determines the opening direction
;932:"targetname" if set, no touch field will be spawned and a remote button or trigger field activates the door.
;933:"speed"		movement speed (100 default)
;934:"wait"		wait before returning (3 default, -1 = never return)
;935:"lip"		lip remaining at end of move (8 default)
;936:"dmg"		damage to inflict when blocked (2 default)
;937:"color"		constantLight color
;938:"light"		constantLight radius
;939:"health"	if set, the door must be shot open
;940:*/
;941:void SP_func_door (gentity_t *ent) {
line 947
;942:	vec3_t	abs_movedir;
;943:	float	distance;
;944:	vec3_t	size;
;945:	float	lip;
;946:
;947:	ent->sound1to2 = ent->sound2to1 = G_SoundIndex("sound/movers/doors/dr1_strt.wav");
ADDRGP4 $440
ARGP4
ADDRLP4 32
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 588
ADDP4
ADDRLP4 32
INDIRI4
ASGNI4
ADDRLP4 36
INDIRP4
CNSTI4 584
ADDP4
ADDRLP4 32
INDIRI4
ASGNI4
line 948
;948:	ent->soundPos1 = ent->soundPos2 = G_SoundIndex("sound/movers/doors/dr1_end.wav");
ADDRGP4 $441
ARGP4
ADDRLP4 40
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 592
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
ADDRLP4 44
INDIRP4
CNSTI4 580
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 950
;949:
;950:	ent->blocked = Blocked_Door;
ADDRFP4 0
INDIRP4
CNSTI4 700
ADDP4
ADDRGP4 Blocked_Door
ASGNP4
line 953
;951:
;952:	// default speed of 400
;953:	if (!ent->speed)
ADDRFP4 0
INDIRP4
CNSTI4 672
ADDP4
INDIRF4
CNSTF4 0
NEF4 $442
line 954
;954:		ent->speed = 400;
ADDRFP4 0
INDIRP4
CNSTI4 672
ADDP4
CNSTF4 1137180672
ASGNF4
LABELV $442
line 957
;955:
;956:	// default wait of 2 seconds
;957:	if (!ent->wait)
ADDRFP4 0
INDIRP4
CNSTI4 796
ADDP4
INDIRF4
CNSTF4 0
NEF4 $444
line 958
;958:		ent->wait = 2;
ADDRFP4 0
INDIRP4
CNSTI4 796
ADDP4
CNSTF4 1073741824
ASGNF4
LABELV $444
line 959
;959:	ent->wait *= 1000;
ADDRLP4 48
ADDRFP4 0
INDIRP4
CNSTI4 796
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTF4 1148846080
ADDRLP4 48
INDIRP4
INDIRF4
MULF4
ASGNF4
line 962
;960:
;961:	// default lip of 8 units
;962:	G_SpawnFloat( "lip", "8", &lip );
ADDRGP4 $446
ARGP4
ADDRGP4 $447
ARGP4
ADDRLP4 28
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 965
;963:
;964:	// default damage of 2 points
;965:	G_SpawnInt( "dmg", "2", &ent->damage );
ADDRGP4 $448
ARGP4
ADDRGP4 $449
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
ARGP4
ADDRGP4 G_SpawnInt
CALLI4
pop
line 968
;966:
;967:	// first position at start
;968:	VectorCopy( ent->s.origin, ent->pos1 );
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 612
ADDP4
ADDRLP4 52
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 971
;969:
;970:	// calculate second position
;971:	trap_SetBrushModel( ent, ent->model );
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 56
INDIRP4
CNSTI4 540
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_SetBrushModel
CALLV
pop
line 972
;972:	G_SetMovedir (ent->s.angles, ent->movedir);
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 676
ADDP4
ARGP4
ADDRGP4 G_SetMovedir
CALLV
pop
line 973
;973:	abs_movedir[0] = fabs(ent->movedir[0]);
ADDRFP4 0
INDIRP4
CNSTI4 676
ADDP4
INDIRF4
ARGF4
ADDRLP4 64
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 64
INDIRF4
ASGNF4
line 974
;974:	abs_movedir[1] = fabs(ent->movedir[1]);
ADDRFP4 0
INDIRP4
CNSTI4 680
ADDP4
INDIRF4
ARGF4
ADDRLP4 68
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 68
INDIRF4
ASGNF4
line 975
;975:	abs_movedir[2] = fabs(ent->movedir[2]);
ADDRFP4 0
INDIRP4
CNSTI4 684
ADDP4
INDIRF4
ARGF4
ADDRLP4 72
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 72
INDIRF4
ASGNF4
line 976
;976:	VectorSubtract( ent->r.maxs, ent->r.mins, size );
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 76
INDIRP4
CNSTI4 448
ADDP4
INDIRF4
ADDRLP4 76
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 76
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
ADDRLP4 76
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12+8
ADDRLP4 80
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
SUBF4
ASGNF4
line 977
;977:	distance = DotProduct( abs_movedir, size ) - lip;
ADDRLP4 24
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRLP4 12+8
INDIRF4
MULF4
ADDF4
ADDRLP4 28
INDIRF4
SUBF4
ASGNF4
line 978
;978:	VectorMA( ent->pos1, distance, ent->movedir, ent->pos2 );
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 624
ADDP4
ADDRLP4 84
INDIRP4
CNSTI4 612
ADDP4
INDIRF4
ADDRLP4 84
INDIRP4
CNSTI4 676
ADDP4
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 628
ADDP4
ADDRLP4 88
INDIRP4
CNSTI4 616
ADDP4
INDIRF4
ADDRLP4 88
INDIRP4
CNSTI4 680
ADDP4
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 632
ADDP4
ADDRLP4 92
INDIRP4
CNSTI4 620
ADDP4
INDIRF4
ADDRLP4 92
INDIRP4
CNSTI4 684
ADDP4
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ADDF4
ASGNF4
line 981
;979:
;980:	// if "start_open", reverse position 1 and 2
;981:	if ( ent->spawnflags & 1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $458
line 984
;982:		vec3_t	temp;
;983:
;984:		VectorCopy( ent->pos2, temp );
ADDRLP4 96
ADDRFP4 0
INDIRP4
CNSTI4 624
ADDP4
INDIRB
ASGNB 12
line 985
;985:		VectorCopy( ent->s.origin, ent->pos2 );
ADDRLP4 108
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 108
INDIRP4
CNSTI4 624
ADDP4
ADDRLP4 108
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 986
;986:		VectorCopy( temp, ent->pos1 );
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
ADDRLP4 96
INDIRB
ASGNB 12
line 987
;987:	}
LABELV $458
line 989
;988:
;989:	InitMover( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 InitMover
CALLV
pop
line 991
;990:
;991:	ent->nextthink = level.time + FRAMETIME;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 993
;992:
;993:	if ( ! (ent->flags & FL_TEAMSLAVE ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
NEI4 $461
line 996
;994:		int health;
;995:
;996:		G_SpawnInt( "health", "0", &health );
ADDRGP4 $463
ARGP4
ADDRGP4 $464
ARGP4
ADDRLP4 96
ARGP4
ADDRGP4 G_SpawnInt
CALLI4
pop
line 997
;997:		if ( health ) {
ADDRLP4 96
INDIRI4
CNSTI4 0
EQI4 $465
line 998
;998:			ent->takedamage = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 1
ASGNI4
line 999
;999:		}
LABELV $465
line 1000
;1000:		if ( ent->targetname || health ) {
ADDRFP4 0
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $469
ADDRLP4 96
INDIRI4
CNSTI4 0
EQI4 $467
LABELV $469
line 1002
;1001:			// non touch/shoot doors
;1002:			ent->think = Think_MatchTeam;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 Think_MatchTeam
ASGNP4
line 1003
;1003:		} else {
ADDRGP4 $468
JUMPV
LABELV $467
line 1004
;1004:			ent->think = Think_SpawnNewDoorTrigger;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 Think_SpawnNewDoorTrigger
ASGNP4
line 1005
;1005:		}
LABELV $468
line 1006
;1006:	}
LABELV $461
line 1009
;1007:
;1008:
;1009:}
LABELV $439
endproc SP_func_door 112 12
export Touch_Plat
proc Touch_Plat 4 0
line 1026
;1010:
;1011:/*
;1012:===============================================================================
;1013:
;1014:PLAT
;1015:
;1016:===============================================================================
;1017:*/
;1018:
;1019:/*
;1020:==============
;1021:Touch_Plat
;1022:
;1023:Don't allow decent if a living player is on it
;1024:===============
;1025:*/
;1026:void Touch_Plat( gentity_t *ent, gentity_t *other, trace_t *trace ) {
line 1027
;1027:	if ( !other->client || other->client->ps.stats[STAT_HEALTH] <= 0 ) {
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $473
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $471
LABELV $473
line 1028
;1028:		return;
ADDRGP4 $470
JUMPV
LABELV $471
line 1032
;1029:	}
;1030:
;1031:	// delay return-to-pos1 by one second
;1032:	if ( ent->moverState == MOVER_POS2 ) {
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
CNSTI4 1
NEI4 $474
line 1033
;1033:		ent->nextthink = level.time + 1000;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 1034
;1034:	}
LABELV $474
line 1035
;1035:}
LABELV $470
endproc Touch_Plat 4 0
export Touch_PlatCenterTrigger
proc Touch_PlatCenterTrigger 4 12
line 1044
;1036:
;1037:/*
;1038:==============
;1039:Touch_PlatCenterTrigger
;1040:
;1041:If the plat is at the bottom position, start it going up
;1042:===============
;1043:*/
;1044:void Touch_PlatCenterTrigger(gentity_t *ent, gentity_t *other, trace_t *trace ) {
line 1045
;1045:	if ( !other->client ) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $478
line 1046
;1046:		return;
ADDRGP4 $477
JUMPV
LABELV $478
line 1049
;1047:	}
;1048:
;1049:	if ( ent->parent->moverState == MOVER_POS1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 600
ADDP4
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
CNSTI4 0
NEI4 $480
line 1050
;1050:		Use_BinaryMover( ent->parent, ent, other );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 600
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Use_BinaryMover
CALLV
pop
line 1051
;1051:	}
LABELV $480
line 1052
;1052:}
LABELV $477
endproc Touch_PlatCenterTrigger 4 12
export SpawnPlatTrigger
proc SpawnPlatTrigger 60 4
line 1064
;1053:
;1054:
;1055:/*
;1056:================
;1057:SpawnPlatTrigger
;1058:
;1059:Spawn a trigger in the middle of the plat's low position
;1060:Elevator cars require that the trigger extend through the entire low position,
;1061:not just sit on top of it.
;1062:================
;1063:*/
;1064:void SpawnPlatTrigger( gentity_t *ent ) {
line 1070
;1065:	gentity_t	*trigger;
;1066:	vec3_t	tmin, tmax;
;1067:
;1068:	// the middle trigger will be a thin trigger just
;1069:	// above the starting position
;1070:	trigger = G_Spawn();
ADDRLP4 28
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
line 1071
;1071:	trigger->classname = "plat_trigger";
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $483
ASGNP4
line 1072
;1072:	trigger->touch = Touch_PlatCenterTrigger;
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
ADDRGP4 Touch_PlatCenterTrigger
ASGNP4
line 1073
;1073:	trigger->r.contents = CONTENTS_TRIGGER;
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 1073741824
ASGNI4
line 1074
;1074:	trigger->parent = ent;
ADDRLP4 0
INDIRP4
CNSTI4 600
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 1076
;1075:	
;1076:	tmin[0] = ent->pos1[0] + ent->r.mins[0] + 33;
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 32
INDIRP4
CNSTI4 612
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
ADDF4
CNSTF4 1107558400
ADDF4
ASGNF4
line 1077
;1077:	tmin[1] = ent->pos1[1] + ent->r.mins[1] + 33;
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4+4
ADDRLP4 36
INDIRP4
CNSTI4 616
ADDP4
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
ADDF4
CNSTF4 1107558400
ADDF4
ASGNF4
line 1078
;1078:	tmin[2] = ent->pos1[2] + ent->r.mins[2];
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4+8
ADDRLP4 40
INDIRP4
CNSTI4 620
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1080
;1079:
;1080:	tmax[0] = ent->pos1[0] + ent->r.maxs[0] - 33;
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 44
INDIRP4
CNSTI4 612
ADDP4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 448
ADDP4
INDIRF4
ADDF4
CNSTF4 1107558400
SUBF4
ASGNF4
line 1081
;1081:	tmax[1] = ent->pos1[1] + ent->r.maxs[1] - 33;
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16+4
ADDRLP4 48
INDIRP4
CNSTI4 616
ADDP4
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
ADDF4
CNSTF4 1107558400
SUBF4
ASGNF4
line 1082
;1082:	tmax[2] = ent->pos1[2] + ent->r.maxs[2] + 8;
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16+8
ADDRLP4 52
INDIRP4
CNSTI4 620
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 1084
;1083:
;1084:	if ( tmax[0] <= tmin[0] ) {
ADDRLP4 16
INDIRF4
ADDRLP4 4
INDIRF4
GTF4 $488
line 1085
;1085:		tmin[0] = ent->pos1[0] + (ent->r.mins[0] + ent->r.maxs[0]) *0.5;
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 56
INDIRP4
CNSTI4 612
ADDP4
INDIRF4
CNSTF4 1056964608
ADDRLP4 56
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 448
ADDP4
INDIRF4
ADDF4
MULF4
ADDF4
ASGNF4
line 1086
;1086:		tmax[0] = tmin[0] + 1;
ADDRLP4 16
ADDRLP4 4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1087
;1087:	}
LABELV $488
line 1088
;1088:	if ( tmax[1] <= tmin[1] ) {
ADDRLP4 16+4
INDIRF4
ADDRLP4 4+4
INDIRF4
GTF4 $490
line 1089
;1089:		tmin[1] = ent->pos1[1] + (ent->r.mins[1] + ent->r.maxs[1]) *0.5;
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4+4
ADDRLP4 56
INDIRP4
CNSTI4 616
ADDP4
INDIRF4
CNSTF4 1056964608
ADDRLP4 56
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
ADDF4
MULF4
ADDF4
ASGNF4
line 1090
;1090:		tmax[1] = tmin[1] + 1;
ADDRLP4 16+4
ADDRLP4 4+4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1091
;1091:	}
LABELV $490
line 1093
;1092:	
;1093:	VectorCopy (tmin, trigger->r.mins);
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRLP4 4
INDIRB
ASGNB 12
line 1094
;1094:	VectorCopy (tmax, trigger->r.maxs);
ADDRLP4 0
INDIRP4
CNSTI4 448
ADDP4
ADDRLP4 16
INDIRB
ASGNB 12
line 1096
;1095:
;1096:	trap_LinkEntity (trigger);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 1097
;1097:}
LABELV $482
endproc SpawnPlatTrigger 60 4
export SP_func_plat
proc SP_func_plat 56 12
line 1111
;1098:
;1099:
;1100:/*QUAKED func_plat (0 .5 .8) ?
;1101:Plats are always drawn in the extended position so they will light correctly.
;1102:
;1103:"lip"		default 8, protrusion above rest position
;1104:"height"	total height of movement, defaults to model height
;1105:"speed"		overrides default 200.
;1106:"dmg"		overrides default 2
;1107:"model2"	.md3 model to also draw
;1108:"color"		constantLight color
;1109:"light"		constantLight radius
;1110:*/
;1111:void SP_func_plat (gentity_t *ent) {
line 1114
;1112:	float		lip, height;
;1113:
;1114:	ent->sound1to2 = ent->sound2to1 = G_SoundIndex("sound/movers/plats/pt1_strt.wav");
ADDRGP4 $498
ARGP4
ADDRLP4 8
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 588
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 584
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 1115
;1115:	ent->soundPos1 = ent->soundPos2 = G_SoundIndex("sound/movers/plats/pt1_end.wav");
ADDRGP4 $499
ARGP4
ADDRLP4 16
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 592
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
ADDRLP4 20
INDIRP4
CNSTI4 580
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1117
;1116:
;1117:	VectorClear (ent->s.angles);
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
CNSTF4 0
ASGNF4
ADDRLP4 24
INDIRP4
CNSTI4 124
ADDP4
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 24
INDIRP4
CNSTI4 120
ADDP4
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 24
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 28
INDIRF4
ASGNF4
line 1119
;1118:
;1119:	G_SpawnFloat( "speed", "200", &ent->speed );
ADDRGP4 $500
ARGP4
ADDRGP4 $501
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 672
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 1120
;1120:	G_SpawnInt( "dmg", "2", &ent->damage );
ADDRGP4 $448
ARGP4
ADDRGP4 $449
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
ARGP4
ADDRGP4 G_SpawnInt
CALLI4
pop
line 1121
;1121:	G_SpawnFloat( "wait", "1", &ent->wait );
ADDRGP4 $502
ARGP4
ADDRGP4 $503
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 796
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 1122
;1122:	G_SpawnFloat( "lip", "8", &lip );
ADDRGP4 $446
ARGP4
ADDRGP4 $447
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 1124
;1123:
;1124:	ent->wait = 1000;
ADDRFP4 0
INDIRP4
CNSTI4 796
ADDP4
CNSTF4 1148846080
ASGNF4
line 1127
;1125:
;1126:	// create second position
;1127:	trap_SetBrushModel( ent, ent->model );
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 540
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_SetBrushModel
CALLV
pop
line 1129
;1128:
;1129:	if ( !G_SpawnFloat( "height", "0", &height ) ) {
ADDRGP4 $506
ARGP4
ADDRGP4 $464
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 36
ADDRGP4 G_SpawnFloat
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $504
line 1130
;1130:		height = (ent->r.maxs[2] - ent->r.mins[2]) - lip;
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 40
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
SUBF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
line 1131
;1131:	}
LABELV $504
line 1134
;1132:
;1133:	// pos1 is the rest (bottom) position, pos2 is the top
;1134:	VectorCopy( ent->s.origin, ent->pos2 );
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 624
ADDP4
ADDRLP4 40
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 1135
;1135:	VectorCopy( ent->pos2, ent->pos1 );
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 612
ADDP4
ADDRLP4 44
INDIRP4
CNSTI4 624
ADDP4
INDIRB
ASGNB 12
line 1136
;1136:	ent->pos1[2] -= height;
ADDRLP4 48
ADDRFP4 0
INDIRP4
CNSTI4 620
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
line 1138
;1137:
;1138:	InitMover( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 InitMover
CALLV
pop
line 1142
;1139:
;1140:	// touch function keeps the plat from returning while
;1141:	// a live player is standing on it
;1142:	ent->touch = Touch_Plat;
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
ADDRGP4 Touch_Plat
ASGNP4
line 1144
;1143:
;1144:	ent->blocked = Blocked_Door;
ADDRFP4 0
INDIRP4
CNSTI4 700
ADDP4
ADDRGP4 Blocked_Door
ASGNP4
line 1146
;1145:
;1146:	ent->parent = ent;	// so it can be treated as a door
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 600
ADDP4
ADDRLP4 52
INDIRP4
ASGNP4
line 1149
;1147:
;1148:	// spawn the trigger if one hasn't been custom made
;1149:	if ( !ent->targetname ) {
ADDRFP4 0
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $507
line 1150
;1150:		SpawnPlatTrigger(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 SpawnPlatTrigger
CALLV
pop
line 1151
;1151:	}
LABELV $507
line 1152
;1152:}
LABELV $497
endproc SP_func_plat 56 12
export Touch_Button
proc Touch_Button 4 12
line 1169
;1153:
;1154:
;1155:/*
;1156:===============================================================================
;1157:
;1158:BUTTON
;1159:
;1160:===============================================================================
;1161:*/
;1162:
;1163:/*
;1164:==============
;1165:Touch_Button
;1166:
;1167:===============
;1168:*/
;1169:void Touch_Button(gentity_t *ent, gentity_t *other, trace_t *trace ) {
line 1170
;1170:	if ( !other->client ) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $510
line 1171
;1171:		return;
ADDRGP4 $509
JUMPV
LABELV $510
line 1174
;1172:	}
;1173:
;1174:	if ( ent->moverState == MOVER_POS1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
CNSTI4 0
NEI4 $512
line 1175
;1175:		Use_BinaryMover( ent, other, other );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Use_BinaryMover
CALLV
pop
line 1176
;1176:	}
LABELV $512
line 1177
;1177:}
LABELV $509
endproc Touch_Button 4 12
export SP_func_button
proc SP_func_button 84 12
line 1193
;1178:
;1179:
;1180:/*QUAKED func_button (0 .5 .8) ?
;1181:When a button is touched, it moves some distance in the direction of it's angle, triggers all of it's targets, waits some time, then returns to it's original position where it can be triggered again.
;1182:
;1183:"model2"	.md3 model to also draw
;1184:"angle"		determines the opening direction
;1185:"target"	all entities with a matching targetname will be used
;1186:"speed"		override the default 40 speed
;1187:"wait"		override the default 1 second wait (-1 = never return)
;1188:"lip"		override the default 4 pixel lip remaining at end of move
;1189:"health"	if set, the button must be killed instead of touched
;1190:"color"		constantLight color
;1191:"light"		constantLight radius
;1192:*/
;1193:void SP_func_button( gentity_t *ent ) {
line 1199
;1194:	vec3_t		abs_movedir;
;1195:	float		distance;
;1196:	vec3_t		size;
;1197:	float		lip;
;1198:
;1199:	ent->sound1to2 = G_SoundIndex("sound/movers/switches/butn2.wav");
ADDRGP4 $515
ARGP4
ADDRLP4 32
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 584
ADDP4
ADDRLP4 32
INDIRI4
ASGNI4
line 1201
;1200:	
;1201:	if ( !ent->speed ) {
ADDRFP4 0
INDIRP4
CNSTI4 672
ADDP4
INDIRF4
CNSTF4 0
NEF4 $516
line 1202
;1202:		ent->speed = 40;
ADDRFP4 0
INDIRP4
CNSTI4 672
ADDP4
CNSTF4 1109393408
ASGNF4
line 1203
;1203:	}
LABELV $516
line 1205
;1204:
;1205:	if ( !ent->wait ) {
ADDRFP4 0
INDIRP4
CNSTI4 796
ADDP4
INDIRF4
CNSTF4 0
NEF4 $518
line 1206
;1206:		ent->wait = 1;
ADDRFP4 0
INDIRP4
CNSTI4 796
ADDP4
CNSTF4 1065353216
ASGNF4
line 1207
;1207:	}
LABELV $518
line 1208
;1208:	ent->wait *= 1000;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 796
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTF4 1148846080
ADDRLP4 36
INDIRP4
INDIRF4
MULF4
ASGNF4
line 1211
;1209:
;1210:	// first position
;1211:	VectorCopy( ent->s.origin, ent->pos1 );
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 612
ADDP4
ADDRLP4 40
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 1214
;1212:
;1213:	// calculate second position
;1214:	trap_SetBrushModel( ent, ent->model );
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 44
INDIRP4
CNSTI4 540
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_SetBrushModel
CALLV
pop
line 1216
;1215:
;1216:	G_SpawnFloat( "lip", "4", &lip );
ADDRGP4 $446
ARGP4
ADDRGP4 $520
ARGP4
ADDRLP4 28
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 1218
;1217:
;1218:	G_SetMovedir( ent->s.angles, ent->movedir );
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRLP4 48
INDIRP4
CNSTI4 676
ADDP4
ARGP4
ADDRGP4 G_SetMovedir
CALLV
pop
line 1219
;1219:	abs_movedir[0] = fabs(ent->movedir[0]);
ADDRFP4 0
INDIRP4
CNSTI4 676
ADDP4
INDIRF4
ARGF4
ADDRLP4 52
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 52
INDIRF4
ASGNF4
line 1220
;1220:	abs_movedir[1] = fabs(ent->movedir[1]);
ADDRFP4 0
INDIRP4
CNSTI4 680
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 56
INDIRF4
ASGNF4
line 1221
;1221:	abs_movedir[2] = fabs(ent->movedir[2]);
ADDRFP4 0
INDIRP4
CNSTI4 684
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 60
INDIRF4
ASGNF4
line 1222
;1222:	VectorSubtract( ent->r.maxs, ent->r.mins, size );
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 64
INDIRP4
CNSTI4 448
ADDP4
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 64
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12+8
ADDRLP4 68
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
ADDRLP4 68
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1223
;1223:	distance = abs_movedir[0] * size[0] + abs_movedir[1] * size[1] + abs_movedir[2] * size[2] - lip;
ADDRLP4 24
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRLP4 12+8
INDIRF4
MULF4
ADDF4
ADDRLP4 28
INDIRF4
SUBF4
ASGNF4
line 1224
;1224:	VectorMA (ent->pos1, distance, ent->movedir, ent->pos2);
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 624
ADDP4
ADDRLP4 72
INDIRP4
CNSTI4 612
ADDP4
INDIRF4
ADDRLP4 72
INDIRP4
CNSTI4 676
ADDP4
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 628
ADDP4
ADDRLP4 76
INDIRP4
CNSTI4 616
ADDP4
INDIRF4
ADDRLP4 76
INDIRP4
CNSTI4 680
ADDP4
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 632
ADDP4
ADDRLP4 80
INDIRP4
CNSTI4 620
ADDP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 684
ADDP4
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ADDF4
ASGNF4
line 1226
;1225:
;1226:	if (ent->health) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 0
EQI4 $529
line 1228
;1227:		// shootable button
;1228:		ent->takedamage = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 1
ASGNI4
line 1229
;1229:	} else {
ADDRGP4 $530
JUMPV
LABELV $529
line 1231
;1230:		// touchable button
;1231:		ent->touch = Touch_Button;
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
ADDRGP4 Touch_Button
ASGNP4
line 1232
;1232:	}
LABELV $530
line 1234
;1233:
;1234:	InitMover( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 InitMover
CALLV
pop
line 1235
;1235:}
LABELV $514
endproc SP_func_button 84 12
export Think_BeginMoving
proc Think_BeginMoving 0 0
line 1259
;1236:
;1237:
;1238:
;1239:/*
;1240:===============================================================================
;1241:
;1242:TRAIN
;1243:
;1244:===============================================================================
;1245:*/
;1246:
;1247:
;1248:#define TRAIN_START_ON		1
;1249:#define TRAIN_TOGGLE		2
;1250:#define TRAIN_BLOCK_STOPS	4
;1251:
;1252:/*
;1253:===============
;1254:Think_BeginMoving
;1255:
;1256:The wait time at a corner has completed, so start moving again
;1257:===============
;1258:*/
;1259:void Think_BeginMoving( gentity_t *ent ) {
line 1260
;1260:	ent->s.pos.trTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 1261
;1261:	ent->s.pos.trType = TR_LINEAR_STOP;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 3
ASGNI4
line 1262
;1262:}
LABELV $531
endproc Think_BeginMoving 0 0
export Reached_Train
proc Reached_Train 48 12
line 1269
;1263:
;1264:/*
;1265:===============
;1266:Reached_Train
;1267:===============
;1268:*/
;1269:void Reached_Train( gentity_t *ent ) {
line 1276
;1270:	gentity_t		*next;
;1271:	float			speed;
;1272:	vec3_t			move;
;1273:	float			length;
;1274:
;1275:	// copy the apropriate values
;1276:	next = ent->nextTrain;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
INDIRP4
ASGNP4
line 1277
;1277:	if ( !next || !next->nextTrain ) {
ADDRLP4 28
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 28
INDIRU4
EQU4 $536
ADDRLP4 0
INDIRP4
CNSTI4 604
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 28
INDIRU4
NEU4 $534
LABELV $536
line 1278
;1278:		return;		// just stop
ADDRGP4 $533
JUMPV
LABELV $534
line 1282
;1279:	}
;1280:
;1281:	// fire all other targets
;1282:	G_UseTargets( next, NULL );
ADDRLP4 0
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 G_UseTargets
CALLV
pop
line 1285
;1283:
;1284:	// set the new trajectory
;1285:	ent->nextTrain = next->nextTrain;
ADDRLP4 32
CNSTI4 604
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRP4
ASGNP4
line 1286
;1286:	VectorCopy( next->s.origin, ent->pos1 );
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 1287
;1287:	VectorCopy( next->nextTrain->s.origin, ent->pos2 );
ADDRFP4 0
INDIRP4
CNSTI4 624
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 604
ADDP4
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 1290
;1288:
;1289:	// if the path_corner has a speed, use that
;1290:	if ( next->speed ) {
ADDRLP4 0
INDIRP4
CNSTI4 672
ADDP4
INDIRF4
CNSTF4 0
EQF4 $537
line 1291
;1291:		speed = next->speed;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 672
ADDP4
INDIRF4
ASGNF4
line 1292
;1292:	} else {
ADDRGP4 $538
JUMPV
LABELV $537
line 1294
;1293:		// otherwise use the train's speed
;1294:		speed = ent->speed;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 672
ADDP4
INDIRF4
ASGNF4
line 1295
;1295:	}
LABELV $538
line 1296
;1296:	if ( speed < 1 ) {
ADDRLP4 16
INDIRF4
CNSTF4 1065353216
GEF4 $539
line 1297
;1297:		speed = 1;
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
line 1298
;1298:	}
LABELV $539
line 1301
;1299:
;1300:	// calculate duration
;1301:	VectorSubtract( ent->pos2, ent->pos1, move );
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 36
INDIRP4
CNSTI4 624
ADDP4
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 612
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 36
INDIRP4
CNSTI4 628
ADDP4
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 616
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4+8
ADDRLP4 40
INDIRP4
CNSTI4 632
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 620
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1302
;1302:	length = VectorLength( move );
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
line 1304
;1303:
;1304:	ent->s.pos.trDuration = length * 1000 / speed;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 1148846080
ADDRLP4 20
INDIRF4
MULF4
ADDRLP4 16
INDIRF4
DIVF4
CVFI4 4
ASGNI4
line 1307
;1305:
;1306:	// looping sound
;1307:	ent->s.loopSound = next->soundLoop;
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 596
ADDP4
INDIRI4
ASGNI4
line 1310
;1308:
;1309:	// start it going
;1310:	SetMoverState( ent, MOVER_1TO2, level.time );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 level+40
INDIRI4
ARGI4
ADDRGP4 SetMoverState
CALLV
pop
line 1313
;1311:
;1312:	// if there is a "wait" value on the target, don't start moving yet
;1313:	if ( next->wait ) {
ADDRLP4 0
INDIRP4
CNSTI4 796
ADDP4
INDIRF4
CNSTF4 0
EQF4 $544
line 1314
;1314:		ent->nextthink = level.time + next->wait * 1000;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
CVIF4 4
CNSTF4 1148846080
ADDRLP4 0
INDIRP4
CNSTI4 796
ADDP4
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 1315
;1315:		ent->think = Think_BeginMoving;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 Think_BeginMoving
ASGNP4
line 1316
;1316:		ent->s.pos.trType = TR_STATIONARY;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 1317
;1317:	}
LABELV $544
line 1318
;1318:}
LABELV $533
endproc Reached_Train 48 12
export Think_SetupTrainTargets
proc Think_SetupTrainTargets 28 12
line 1328
;1319:
;1320:
;1321:/*
;1322:===============
;1323:Think_SetupTrainTargets
;1324:
;1325:Link all the corners together
;1326:===============
;1327:*/
;1328:void Think_SetupTrainTargets( gentity_t *ent ) {
line 1331
;1329:	gentity_t		*path, *next, *start;
;1330:
;1331:	ent->nextTrain = G_Find( NULL, FOFS(targetname), ent->target );
CNSTP4 0
ARGP4
CNSTI4 652
ARGI4
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 604
ADDP4
ADDRLP4 16
INDIRP4
ASGNP4
line 1332
;1332:	if ( !ent->nextTrain ) {
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $548
line 1333
;1333:		G_Printf( "func_train at %s with an unfound target\n",
ADDRFP4 0
INDIRP4
CNSTI4 464
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 vtos
CALLP4
ASGNP4
ADDRGP4 $550
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 1335
;1334:			vtos(ent->r.absmin) );
;1335:		return;
ADDRGP4 $547
JUMPV
LABELV $548
line 1338
;1336:	}
;1337:
;1338:	start = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 1339
;1339:	for ( path = ent->nextTrain ; path != start ; path = next ) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
INDIRP4
ASGNP4
ADDRGP4 $554
JUMPV
LABELV $551
line 1340
;1340:		if ( !start ) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $555
line 1341
;1341:			start = path;
ADDRLP4 8
ADDRLP4 4
INDIRP4
ASGNP4
line 1342
;1342:		}
LABELV $555
line 1344
;1343:
;1344:		if ( !path->target ) {
ADDRLP4 4
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $557
line 1345
;1345:			G_Printf( "Train corner at %s without a target\n",
ADDRLP4 4
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 vtos
CALLP4
ASGNP4
ADDRGP4 $559
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 1347
;1346:				vtos(path->s.origin) );
;1347:			return;
ADDRGP4 $547
JUMPV
LABELV $557
line 1353
;1348:		}
;1349:
;1350:		// find a path_corner among the targets
;1351:		// there may also be other targets that get fired when the corner
;1352:		// is reached
;1353:		next = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
LABELV $560
line 1354
;1354:		do {
line 1355
;1355:			next = G_Find( next, FOFS(targetname), path->target );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 652
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 648
ADDP4
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
line 1356
;1356:			if ( !next ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $563
line 1357
;1357:				G_Printf( "Train corner at %s without a target path_corner\n",
ADDRLP4 4
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 24
ADDRGP4 vtos
CALLP4
ASGNP4
ADDRGP4 $565
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 1359
;1358:					vtos(path->s.origin) );
;1359:				return;
ADDRGP4 $547
JUMPV
LABELV $563
line 1361
;1360:			}
;1361:		} while ( strcmp( next->classname, "path_corner" ) );
LABELV $561
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $566
ARGP4
ADDRLP4 20
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $560
line 1363
;1362:
;1363:		path->nextTrain = next;
ADDRLP4 4
INDIRP4
CNSTI4 604
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 1364
;1364:	}
LABELV $552
line 1339
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
LABELV $554
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRP4
CVPU4 4
NEU4 $551
line 1367
;1365:
;1366:	// start the train moving from the first corner
;1367:	Reached_Train( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Reached_Train
CALLV
pop
line 1368
;1368:}
LABELV $547
endproc Think_SetupTrainTargets 28 12
export SP_path_corner
proc SP_path_corner 4 8
line 1378
;1369:
;1370:
;1371:
;1372:/*QUAKED path_corner (.5 .3 0) (-8 -8 -8) (8 8 8)
;1373:Train path corners.
;1374:Target: next path corner and other targets to fire
;1375:"speed" speed to move to the next corner
;1376:"wait" seconds to wait before behining move to next corner
;1377:*/
;1378:void SP_path_corner( gentity_t *self ) {
line 1379
;1379:	if ( !self->targetname ) {
ADDRFP4 0
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $568
line 1380
;1380:		G_Printf ("path_corner with no targetname at %s\n", vtos(self->s.origin));
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 vtos
CALLP4
ASGNP4
ADDRGP4 $570
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 1381
;1381:		G_FreeEntity( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 1382
;1382:		return;
LABELV $568
line 1385
;1383:	}
;1384:	// path corners don't need to be linked in
;1385:}
LABELV $567
endproc SP_path_corner 4 8
export SP_func_train
proc SP_func_train 12 8
line 1401
;1386:
;1387:
;1388:
;1389:/*QUAKED func_train (0 .5 .8) ? START_ON TOGGLE BLOCK_STOPS
;1390:A train is a mover that moves between path_corner target points.
;1391:Trains MUST HAVE AN ORIGIN BRUSH.
;1392:The train spawns at the first target it is pointing at.
;1393:"model2"	.md3 model to also draw
;1394:"speed"		default 100
;1395:"dmg"		default	2
;1396:"noise"		looping sound to play when the train is in motion
;1397:"target"	next path corner
;1398:"color"		constantLight color
;1399:"light"		constantLight radius
;1400:*/
;1401:void SP_func_train (gentity_t *self) {
line 1402
;1402:	VectorClear (self->s.angles);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 124
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 1404
;1403:
;1404:	if (self->spawnflags & TRAIN_BLOCK_STOPS) {
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $572
line 1405
;1405:		self->damage = 0;
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
CNSTI4 0
ASGNI4
line 1406
;1406:	} else {
ADDRGP4 $573
JUMPV
LABELV $572
line 1407
;1407:		if (!self->damage) {
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
CNSTI4 0
NEI4 $574
line 1408
;1408:			self->damage = 2;
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
CNSTI4 2
ASGNI4
line 1409
;1409:		}
LABELV $574
line 1410
;1410:	}
LABELV $573
line 1412
;1411:
;1412:	if ( !self->speed ) {
ADDRFP4 0
INDIRP4
CNSTI4 672
ADDP4
INDIRF4
CNSTF4 0
NEF4 $576
line 1413
;1413:		self->speed = 100;
ADDRFP4 0
INDIRP4
CNSTI4 672
ADDP4
CNSTF4 1120403456
ASGNF4
line 1414
;1414:	}
LABELV $576
line 1416
;1415:
;1416:	if ( !self->target ) {
ADDRFP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $578
line 1417
;1417:		G_Printf ("func_train without a target at %s\n", vtos(self->r.absmin));
ADDRFP4 0
INDIRP4
CNSTI4 464
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 vtos
CALLP4
ASGNP4
ADDRGP4 $580
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 1418
;1418:		G_FreeEntity( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 1419
;1419:		return;
ADDRGP4 $571
JUMPV
LABELV $578
line 1422
;1420:	}
;1421:
;1422:	trap_SetBrushModel( self, self->model );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 540
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_SetBrushModel
CALLV
pop
line 1423
;1423:	InitMover( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 InitMover
CALLV
pop
line 1425
;1424:
;1425:	self->reached = Reached_Train;
ADDRFP4 0
INDIRP4
CNSTI4 696
ADDP4
ADDRGP4 Reached_Train
ASGNP4
line 1429
;1426:
;1427:	// start trains on the second frame, to make sure their targets have had
;1428:	// a chance to spawn
;1429:	self->nextthink = level.time + FRAMETIME;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 1430
;1430:	self->think = Think_SetupTrainTargets;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 Think_SetupTrainTargets
ASGNP4
line 1431
;1431:}
LABELV $571
endproc SP_func_train 12 8
export SP_func_static
proc SP_func_static 12 8
line 1448
;1432:
;1433:/*
;1434:===============================================================================
;1435:
;1436:STATIC
;1437:
;1438:===============================================================================
;1439:*/
;1440:
;1441:
;1442:/*QUAKED func_static (0 .5 .8) ?
;1443:A bmodel that just sits there, doing nothing.  Can be used for conditional walls and models.
;1444:"model2"	.md3 model to also draw
;1445:"color"		constantLight color
;1446:"light"		constantLight radius
;1447:*/
;1448:void SP_func_static( gentity_t *ent ) {
line 1449
;1449:	trap_SetBrushModel( ent, ent->model );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 540
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_SetBrushModel
CALLV
pop
line 1450
;1450:	InitMover( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 InitMover
CALLV
pop
line 1451
;1451:	VectorCopy( ent->s.origin, ent->s.pos.trBase );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 1452
;1452:	VectorCopy( ent->s.origin, ent->r.currentOrigin );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 1453
;1453:}
LABELV $582
endproc SP_func_static 12 8
export SP_func_rotating
proc SP_func_rotating 16 8
line 1476
;1454:
;1455:
;1456:/*
;1457:===============================================================================
;1458:
;1459:ROTATING
;1460:
;1461:===============================================================================
;1462:*/
;1463:
;1464:
;1465:/*QUAKED func_rotating (0 .5 .8) ? START_ON - X_AXIS Y_AXIS
;1466:You need to have an origin brush as part of this entity.  The center of that brush will be
;1467:the point around which it is rotated. It will rotate around the Z axis by default.  You can
;1468:check either the X_AXIS or Y_AXIS box to change that.
;1469:
;1470:"model2"	.md3 model to also draw
;1471:"speed"		determines how fast it moves; default value is 100.
;1472:"dmg"		damage to inflict when blocked (2 default)
;1473:"color"		constantLight color
;1474:"light"		constantLight radius
;1475:*/
;1476:void SP_func_rotating (gentity_t *ent) {
line 1477
;1477:	if ( !ent->speed ) {
ADDRFP4 0
INDIRP4
CNSTI4 672
ADDP4
INDIRF4
CNSTF4 0
NEF4 $584
line 1478
;1478:		ent->speed = 100;
ADDRFP4 0
INDIRP4
CNSTI4 672
ADDP4
CNSTF4 1120403456
ASGNF4
line 1479
;1479:	}
LABELV $584
line 1482
;1480:
;1481:	// set the axis of rotation
;1482:	ent->s.apos.trType = TR_LINEAR;
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 2
ASGNI4
line 1483
;1483:	if ( ent->spawnflags & 4 ) {
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $586
line 1484
;1484:		ent->s.apos.trDelta[2] = ent->speed;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 672
ADDP4
INDIRF4
ASGNF4
line 1485
;1485:	} else if ( ent->spawnflags & 8 ) {
ADDRGP4 $587
JUMPV
LABELV $586
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $588
line 1486
;1486:		ent->s.apos.trDelta[0] = ent->speed;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 672
ADDP4
INDIRF4
ASGNF4
line 1487
;1487:	} else {
ADDRGP4 $589
JUMPV
LABELV $588
line 1488
;1488:		ent->s.apos.trDelta[1] = ent->speed;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 672
ADDP4
INDIRF4
ASGNF4
line 1489
;1489:	}
LABELV $589
LABELV $587
line 1491
;1490:
;1491:	if (!ent->damage) {
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
CNSTI4 0
NEI4 $590
line 1492
;1492:		ent->damage = 2;
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
CNSTI4 2
ASGNI4
line 1493
;1493:	}
LABELV $590
line 1495
;1494:
;1495:	trap_SetBrushModel( ent, ent->model );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 540
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_SetBrushModel
CALLV
pop
line 1496
;1496:	InitMover( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 InitMover
CALLV
pop
line 1498
;1497:
;1498:	VectorCopy( ent->s.origin, ent->s.pos.trBase );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 1499
;1499:	VectorCopy( ent->s.pos.trBase, ent->r.currentOrigin );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 1500
;1500:	VectorCopy( ent->s.apos.trBase, ent->r.currentAngles );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 500
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 60
ADDP4
INDIRB
ASGNB 12
line 1502
;1501:
;1502:	trap_LinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 1503
;1503:}
LABELV $583
endproc SP_func_rotating 16 8
export SP_func_bobbing
proc SP_func_bobbing 28 12
line 1525
;1504:
;1505:
;1506:/*
;1507:===============================================================================
;1508:
;1509:BOBBING
;1510:
;1511:===============================================================================
;1512:*/
;1513:
;1514:
;1515:/*QUAKED func_bobbing (0 .5 .8) ? X_AXIS Y_AXIS
;1516:Normally bobs on the Z axis
;1517:"model2"	.md3 model to also draw
;1518:"height"	amplitude of bob (32 default)
;1519:"speed"		seconds to complete a bob cycle (4 default)
;1520:"phase"		the 0.0 to 1.0 offset in the cycle to start at
;1521:"dmg"		damage to inflict when blocked (2 default)
;1522:"color"		constantLight color
;1523:"light"		constantLight radius
;1524:*/
;1525:void SP_func_bobbing (gentity_t *ent) {
line 1529
;1526:	float		height;
;1527:	float		phase;
;1528:
;1529:	G_SpawnFloat( "speed", "4", &ent->speed );
ADDRGP4 $500
ARGP4
ADDRGP4 $520
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 672
ADDP4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 1530
;1530:	G_SpawnFloat( "height", "32", &height );
ADDRGP4 $506
ARGP4
ADDRGP4 $593
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 1531
;1531:	G_SpawnInt( "dmg", "2", &ent->damage );
ADDRGP4 $448
ARGP4
ADDRGP4 $449
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
ARGP4
ADDRGP4 G_SpawnInt
CALLI4
pop
line 1532
;1532:	G_SpawnFloat( "phase", "0", &phase );
ADDRGP4 $594
ARGP4
ADDRGP4 $464
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 1534
;1533:
;1534:	trap_SetBrushModel( ent, ent->model );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 540
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_SetBrushModel
CALLV
pop
line 1535
;1535:	InitMover( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 InitMover
CALLV
pop
line 1537
;1536:
;1537:	VectorCopy( ent->s.origin, ent->s.pos.trBase );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 1538
;1538:	VectorCopy( ent->s.origin, ent->r.currentOrigin );
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 1540
;1539:
;1540:	ent->s.pos.trDuration = ent->speed * 1000;
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 1148846080
ADDRLP4 20
INDIRP4
CNSTI4 672
ADDP4
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 1541
;1541:	ent->s.pos.trTime = ent->s.pos.trDuration * phase;
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 1542
;1542:	ent->s.pos.trType = TR_SINE;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 4
ASGNI4
line 1545
;1543:
;1544:	// set the axis of bobbing
;1545:	if ( ent->spawnflags & 1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $595
line 1546
;1546:		ent->s.pos.trDelta[0] = height;
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 0
INDIRF4
ASGNF4
line 1547
;1547:	} else if ( ent->spawnflags & 2 ) {
ADDRGP4 $596
JUMPV
LABELV $595
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $597
line 1548
;1548:		ent->s.pos.trDelta[1] = height;
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 0
INDIRF4
ASGNF4
line 1549
;1549:	} else {
ADDRGP4 $598
JUMPV
LABELV $597
line 1550
;1550:		ent->s.pos.trDelta[2] = height;
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 0
INDIRF4
ASGNF4
line 1551
;1551:	}
LABELV $598
LABELV $596
line 1552
;1552:}
LABELV $592
endproc SP_func_bobbing 28 12
export SP_func_pendulum
proc SP_func_pendulum 44 12
line 1574
;1553:
;1554:/*
;1555:===============================================================================
;1556:
;1557:PENDULUM
;1558:
;1559:===============================================================================
;1560:*/
;1561:
;1562:
;1563:/*QUAKED func_pendulum (0 .5 .8) ?
;1564:You need to have an origin brush as part of this entity.
;1565:Pendulums always swing north / south on unrotated models.  Add an angles field to the model to allow rotation in other directions.
;1566:Pendulum frequency is a physical constant based on the length of the beam and gravity.
;1567:"model2"	.md3 model to also draw
;1568:"speed"		the number of degrees each way the pendulum swings, (30 default)
;1569:"phase"		the 0.0 to 1.0 offset in the cycle to start at
;1570:"dmg"		damage to inflict when blocked (2 default)
;1571:"color"		constantLight color
;1572:"light"		constantLight radius
;1573:*/
;1574:void SP_func_pendulum(gentity_t *ent) {
line 1580
;1575:	float		freq;
;1576:	float		length;
;1577:	float		phase;
;1578:	float		speed;
;1579:
;1580:	G_SpawnFloat( "speed", "30", &speed );
ADDRGP4 $500
ARGP4
ADDRGP4 $600
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 1581
;1581:	G_SpawnInt( "dmg", "2", &ent->damage );
ADDRGP4 $448
ARGP4
ADDRGP4 $449
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
ARGP4
ADDRGP4 G_SpawnInt
CALLI4
pop
line 1582
;1582:	G_SpawnFloat( "phase", "0", &phase );
ADDRGP4 $594
ARGP4
ADDRGP4 $464
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 1584
;1583:
;1584:	trap_SetBrushModel( ent, ent->model );
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 540
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_SetBrushModel
CALLV
pop
line 1587
;1585:
;1586:	// find pendulum length
;1587:	length = fabs( ent->r.mins[2] );
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 20
INDIRF4
ASGNF4
line 1588
;1588:	if ( length < 8 ) {
ADDRLP4 0
INDIRF4
CNSTF4 1090519040
GEF4 $601
line 1589
;1589:		length = 8;
ADDRLP4 0
CNSTF4 1090519040
ASGNF4
line 1590
;1590:	}
LABELV $601
line 1592
;1591:
;1592:	freq = 1 / ( M_PI * 2 ) * sqrt( g_gravity.value / ( 3 * length ) );
ADDRGP4 g_gravity+8
INDIRF4
CNSTF4 1077936128
ADDRLP4 0
INDIRF4
MULF4
DIVF4
ARGF4
ADDRLP4 24
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 4
CNSTF4 1042479491
ADDRLP4 24
INDIRF4
MULF4
ASGNF4
line 1594
;1593:
;1594:	ent->s.pos.trDuration = ( 1000 / freq );
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 1148846080
ADDRLP4 4
INDIRF4
DIVF4
CVFI4 4
ASGNI4
line 1596
;1595:
;1596:	InitMover( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 InitMover
CALLV
pop
line 1598
;1597:
;1598:	VectorCopy( ent->s.origin, ent->s.pos.trBase );
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 1599
;1599:	VectorCopy( ent->s.origin, ent->r.currentOrigin );
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 32
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 1601
;1600:
;1601:	VectorCopy( ent->s.angles, ent->s.apos.trBase );
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 60
ADDP4
ADDRLP4 36
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 1603
;1602:
;1603:	ent->s.apos.trDuration = 1000 / freq;
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 1148846080
ADDRLP4 4
INDIRF4
DIVF4
CVFI4 4
ASGNI4
line 1604
;1604:	ent->s.apos.trTime = ent->s.apos.trDuration * phase;
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 52
ADDP4
ADDRLP4 40
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 8
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 1605
;1605:	ent->s.apos.trType = TR_SINE;
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 4
ASGNI4
line 1606
;1606:	ent->s.apos.trDelta[2] = speed;
ADDRFP4 0
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
line 1607
;1607:}
LABELV $599
endproc SP_func_pendulum 44 12
import G_ExplodeMissile
bss
export pushed_p
align 4
LABELV pushed_p
skip 4
export pushed
align 4
LABELV pushed
skip 32768
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
LABELV $600
byte 1 51
byte 1 48
byte 1 0
align 1
LABELV $594
byte 1 112
byte 1 104
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $593
byte 1 51
byte 1 50
byte 1 0
align 1
LABELV $580
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
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $570
byte 1 112
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 99
byte 1 111
byte 1 114
byte 1 110
byte 1 101
byte 1 114
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $566
byte 1 112
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 99
byte 1 111
byte 1 114
byte 1 110
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $565
byte 1 84
byte 1 114
byte 1 97
byte 1 105
byte 1 110
byte 1 32
byte 1 99
byte 1 111
byte 1 114
byte 1 110
byte 1 101
byte 1 114
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 112
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 99
byte 1 111
byte 1 114
byte 1 110
byte 1 101
byte 1 114
byte 1 10
byte 1 0
align 1
LABELV $559
byte 1 84
byte 1 114
byte 1 97
byte 1 105
byte 1 110
byte 1 32
byte 1 99
byte 1 111
byte 1 114
byte 1 110
byte 1 101
byte 1 114
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $550
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
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 117
byte 1 110
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $520
byte 1 52
byte 1 0
align 1
LABELV $515
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 115
byte 1 119
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 101
byte 1 115
byte 1 47
byte 1 98
byte 1 117
byte 1 116
byte 1 110
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $506
byte 1 104
byte 1 101
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $503
byte 1 49
byte 1 0
align 1
LABELV $502
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $501
byte 1 50
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $500
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $499
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 115
byte 1 47
byte 1 112
byte 1 116
byte 1 49
byte 1 95
byte 1 101
byte 1 110
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $498
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 115
byte 1 47
byte 1 112
byte 1 116
byte 1 49
byte 1 95
byte 1 115
byte 1 116
byte 1 114
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $483
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 95
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $464
byte 1 48
byte 1 0
align 1
LABELV $463
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $449
byte 1 50
byte 1 0
align 1
LABELV $448
byte 1 100
byte 1 109
byte 1 103
byte 1 0
align 1
LABELV $447
byte 1 56
byte 1 0
align 1
LABELV $446
byte 1 108
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $441
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 100
byte 1 114
byte 1 49
byte 1 95
byte 1 101
byte 1 110
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $440
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 115
byte 1 47
byte 1 100
byte 1 114
byte 1 49
byte 1 95
byte 1 115
byte 1 116
byte 1 114
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $435
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 95
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $363
byte 1 49
byte 1 32
byte 1 49
byte 1 32
byte 1 49
byte 1 0
align 1
LABELV $362
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $361
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $360
byte 1 49
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $359
byte 1 110
byte 1 111
byte 1 105
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $323
byte 1 82
byte 1 101
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 100
byte 1 95
byte 1 66
byte 1 105
byte 1 110
byte 1 97
byte 1 114
byte 1 121
byte 1 77
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 58
byte 1 32
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $100
byte 1 112
byte 1 117
byte 1 115
byte 1 104
byte 1 101
byte 1 100
byte 1 95
byte 1 112
byte 1 32
byte 1 62
byte 1 32
byte 1 38
byte 1 112
byte 1 117
byte 1 115
byte 1 104
byte 1 101
byte 1 100
byte 1 91
byte 1 77
byte 1 65
byte 1 88
byte 1 95
byte 1 71
byte 1 69
byte 1 78
byte 1 84
byte 1 73
byte 1 84
byte 1 73
byte 1 69
byte 1 83
byte 1 93
byte 1 0
