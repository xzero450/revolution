export CG_InitMarkPolys
code
proc CG_InitMarkPolys 12 12
file "../cg_marks.c"
line 28
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_marks.c -- wall marks
;4:
;5:#include "cg_local.h"
;6:
;7:/*
;8:===================================================================
;9:
;10:MARK POLYS
;11:
;12:===================================================================
;13:*/
;14:
;15:
;16:markPoly_t	cg_activeMarkPolys;			// double linked list
;17:markPoly_t	*cg_freeMarkPolys;			// single linked list
;18:markPoly_t	cg_markPolys[MAX_MARK_POLYS];//Added *4
;19:static		int	markTotal;
;20:
;21:/*
;22:===================
;23:CG_InitMarkPolys
;24:
;25:This is called at startup and for tournement restarts
;26:===================
;27:*/
;28:void	CG_InitMarkPolys( void ) {
line 31
;29:	int		i;
;30:
;31:	memset( cg_markPolys, 0, sizeof(cg_markPolys) );
ADDRGP4 cg_markPolys
ARGP4
CNSTI4 0
ARGI4
CNSTI4 73728
ARGI4
ADDRGP4 memset
CALLP4
pop
line 33
;32:
;33:	cg_activeMarkPolys.nextMark = &cg_activeMarkPolys;
ADDRGP4 cg_activeMarkPolys+4
ADDRGP4 cg_activeMarkPolys
ASGNP4
line 34
;34:	cg_activeMarkPolys.prevMark = &cg_activeMarkPolys;
ADDRLP4 4
ADDRGP4 cg_activeMarkPolys
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
ASGNP4
line 35
;35:	cg_freeMarkPolys = cg_markPolys;
ADDRGP4 cg_freeMarkPolys
ADDRGP4 cg_markPolys
ASGNP4
line 36
;36:	for ( i = 0 ; i < MAX_MARK_POLYS - 1 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $79
line 37
;37:		cg_markPolys[i].nextMark = &cg_markPolys[i+1];
ADDRLP4 8
CNSTI4 288
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 8
INDIRI4
ADDRGP4 cg_markPolys+4
ADDP4
ADDRLP4 8
INDIRI4
ADDRGP4 cg_markPolys+288
ADDP4
ASGNP4
line 38
;38:	}
LABELV $80
line 36
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 255
LTI4 $79
line 39
;39:}
LABELV $77
endproc CG_InitMarkPolys 12 12
export CG_FreeMarkPoly
proc CG_FreeMarkPoly 12 4
line 47
;40:
;41:
;42:/*
;43:==================
;44:CG_FreeMarkPoly
;45:==================
;46:*/
;47:void CG_FreeMarkPoly( markPoly_t *le ) {
line 48
;48:	if ( !le->prevMark ) {
ADDRFP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $86
line 49
;49:		CG_Error( "CG_FreeLocalEntity: not active" );
ADDRGP4 $88
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 50
;50:	}
LABELV $86
line 53
;51:
;52:	// remove from the doubly linked active list
;53:	le->prevMark->nextMark = le->nextMark;
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
line 54
;54:	le->nextMark->prevMark = le->prevMark;
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
line 57
;55:
;56:	// the free list is only singly linked
;57:	le->nextMark = cg_freeMarkPolys;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg_freeMarkPolys
INDIRP4
ASGNP4
line 58
;58:	cg_freeMarkPolys = le;
ADDRGP4 cg_freeMarkPolys
ADDRFP4 0
INDIRP4
ASGNP4
line 59
;59:}
LABELV $85
endproc CG_FreeMarkPoly 12 4
export CG_AllocMark
proc CG_AllocMark 12 12
line 68
;60:
;61:/*
;62:===================
;63:CG_AllocMark
;64:
;65:Will allways succeed, even if it requires freeing an old active mark
;66:===================
;67:*/
;68:markPoly_t	*CG_AllocMark( void ) {
line 72
;69:	markPoly_t	*le;
;70:	int time;
;71:
;72:	if ( !cg_freeMarkPolys ) {
ADDRGP4 cg_freeMarkPolys
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $90
line 75
;73:		// no free entities, so free the one at the end of the chain
;74:		// remove the oldest active entity
;75:		time = cg_activeMarkPolys.prevMark->time;
ADDRLP4 4
ADDRGP4 cg_activeMarkPolys
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $93
JUMPV
LABELV $92
line 76
;76:		while (cg_activeMarkPolys.prevMark && time == cg_activeMarkPolys.prevMark->time) {
line 77
;77:			CG_FreeMarkPoly( cg_activeMarkPolys.prevMark );
ADDRGP4 cg_activeMarkPolys
INDIRP4
ARGP4
ADDRGP4 CG_FreeMarkPoly
CALLV
pop
line 78
;78:		}
LABELV $93
line 76
ADDRLP4 8
ADDRGP4 cg_activeMarkPolys
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $95
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
EQI4 $92
LABELV $95
line 79
;79:	}
LABELV $90
line 81
;80:
;81:	le = cg_freeMarkPolys;
ADDRLP4 0
ADDRGP4 cg_freeMarkPolys
INDIRP4
ASGNP4
line 82
;82:	cg_freeMarkPolys = cg_freeMarkPolys->nextMark;
ADDRLP4 8
ADDRGP4 cg_freeMarkPolys
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ASGNP4
line 84
;83:
;84:	memset( le, 0, sizeof( *le ) );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 288
ARGI4
ADDRGP4 memset
CALLP4
pop
line 87
;85:
;86:	// link into the active list
;87:	le->nextMark = cg_activeMarkPolys.nextMark;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg_activeMarkPolys+4
INDIRP4
ASGNP4
line 88
;88:	le->prevMark = &cg_activeMarkPolys;
ADDRLP4 0
INDIRP4
ADDRGP4 cg_activeMarkPolys
ASGNP4
line 89
;89:	cg_activeMarkPolys.nextMark->prevMark = le;
ADDRGP4 cg_activeMarkPolys+4
INDIRP4
ADDRLP4 0
INDIRP4
ASGNP4
line 90
;90:	cg_activeMarkPolys.nextMark = le;
ADDRGP4 cg_activeMarkPolys+4
ADDRLP4 0
INDIRP4
ASGNP4
line 91
;91:	return le;
ADDRLP4 0
INDIRP4
RETP4
LABELV $89
endproc CG_AllocMark 12 12
export CG_ImpactMark
proc CG_ImpactMark 6088 28
line 112
;92:}
;93:
;94:
;95:
;96:/*
;97:=================
;98:CG_ImpactMark
;99:
;100:origin should be a point within a unit of the plane
;101:dir should be the plane normal
;102:
;103:temporary marks will not be stored or randomly oriented, but immediately
;104:passed to the renderer.
;105:=================
;106:*/
;107:#define	MAX_MARK_FRAGMENTS	128
;108:#define	MAX_MARK_POINTS		384
;109:
;110:void CG_ImpactMark( qhandle_t markShader, const vec3_t origin, const vec3_t dir, 
;111:				   float orientation, float red, float green, float blue, float alpha,
;112:				   qboolean alphaFade, float radius, qboolean temporary ) {
line 123
;113:	vec3_t			axis[3];
;114:	float			texCoordScale;
;115:	vec3_t			originalPoints[4];
;116:	byte			colors[4];
;117:	int				i, j;
;118:	int				numFragments;
;119:	markFragment_t	markFragments[MAX_MARK_FRAGMENTS], *mf;
;120:	vec3_t			markPoints[MAX_MARK_POINTS];
;121:	vec3_t			projection;
;122:
;123:	if ( !cg_addMarks.integer ) {
ADDRGP4 cg_addMarks+12
INDIRI4
CNSTI4 0
NEI4 $100
line 124
;124:		return;
ADDRGP4 $99
JUMPV
LABELV $100
line 127
;125:	}
;126:
;127:	if ( radius <= 0 ) {
ADDRFP4 36
INDIRF4
CNSTF4 0
GTF4 $103
line 128
;128:		CG_Error( "CG_ImpactMark called with <= 0 radius" );
ADDRGP4 $105
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 129
;129:	}
LABELV $103
line 136
;130:
;131:	//if ( markTotal >= MAX_MARK_POLYS ) {
;132:	//	return;
;133:	//}
;134:
;135:	// create the texture axis
;136:	VectorNormalize2( dir, axis[0] );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 VectorNormalize2
CALLF4
pop
line 137
;137:	PerpendicularVector( axis[1], axis[0] );
ADDRLP4 0+12
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 PerpendicularVector
CALLV
pop
line 138
;138:	RotatePointAroundVector( axis[2], axis[0], axis[1], orientation );
ADDRLP4 0+24
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 0+12
ARGP4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 RotatePointAroundVector
CALLV
pop
line 139
;139:	CrossProduct( axis[0], axis[2], axis[1] );
ADDRLP4 0
ARGP4
ADDRLP4 0+24
ARGP4
ADDRLP4 0+12
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 141
;140:
;141:	texCoordScale = 0.5 * 1.0 / radius;
ADDRLP4 48
CNSTF4 1056964608
ADDRFP4 36
INDIRF4
DIVF4
ASGNF4
line 144
;142:
;143:	// create the full polygon
;144:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 44
CNSTI4 0
ASGNI4
LABELV $111
line 145
;145:		originalPoints[0][i] = origin[i] - radius * axis[1][i] - radius * axis[2][i];
ADDRLP4 5752
ADDRLP4 44
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 5756
ADDRFP4 36
INDIRF4
ASGNF4
ADDRLP4 5752
INDIRI4
ADDRLP4 4664
ADDP4
ADDRLP4 5752
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRLP4 5756
INDIRF4
ADDRLP4 5752
INDIRI4
ADDRLP4 0+12
ADDP4
INDIRF4
MULF4
SUBF4
ADDRLP4 5756
INDIRF4
ADDRLP4 5752
INDIRI4
ADDRLP4 0+24
ADDP4
INDIRF4
MULF4
SUBF4
ASGNF4
line 146
;146:		originalPoints[1][i] = origin[i] + radius * axis[1][i] - radius * axis[2][i];
ADDRLP4 5760
ADDRLP4 44
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 5764
ADDRFP4 36
INDIRF4
ASGNF4
ADDRLP4 5760
INDIRI4
ADDRLP4 4664+12
ADDP4
ADDRLP4 5760
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRLP4 5764
INDIRF4
ADDRLP4 5760
INDIRI4
ADDRLP4 0+12
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 5764
INDIRF4
ADDRLP4 5760
INDIRI4
ADDRLP4 0+24
ADDP4
INDIRF4
MULF4
SUBF4
ASGNF4
line 147
;147:		originalPoints[2][i] = origin[i] + radius * axis[1][i] + radius * axis[2][i];
ADDRLP4 5768
ADDRLP4 44
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 5772
ADDRFP4 36
INDIRF4
ASGNF4
ADDRLP4 5768
INDIRI4
ADDRLP4 4664+24
ADDP4
ADDRLP4 5768
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRLP4 5772
INDIRF4
ADDRLP4 5768
INDIRI4
ADDRLP4 0+12
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 5772
INDIRF4
ADDRLP4 5768
INDIRI4
ADDRLP4 0+24
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 148
;148:		originalPoints[3][i] = origin[i] - radius * axis[1][i] + radius * axis[2][i];
ADDRLP4 5776
ADDRLP4 44
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 5780
ADDRFP4 36
INDIRF4
ASGNF4
ADDRLP4 5776
INDIRI4
ADDRLP4 4664+36
ADDP4
ADDRLP4 5776
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRLP4 5780
INDIRF4
ADDRLP4 5776
INDIRI4
ADDRLP4 0+12
ADDP4
INDIRF4
MULF4
SUBF4
ADDRLP4 5780
INDIRF4
ADDRLP4 5776
INDIRI4
ADDRLP4 0+24
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 149
;149:	}
LABELV $112
line 144
ADDRLP4 44
ADDRLP4 44
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 3
LTI4 $111
line 152
;150:
;151:	// get the fragments
;152:	VectorScale( dir, -20, projection );
ADDRLP4 5752
CNSTF4 3248488448
ASGNF4
ADDRLP4 5756
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 4716
ADDRLP4 5752
INDIRF4
ADDRLP4 5756
INDIRP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 4716+4
ADDRLP4 5752
INDIRF4
ADDRLP4 5756
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 4716+8
CNSTF4 3248488448
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ASGNF4
line 153
;153:	numFragments = trap_CM_MarkFragments( 4, (void *)originalPoints,
CNSTI4 4
ARGI4
ADDRLP4 4664
ARGP4
ADDRLP4 4716
ARGP4
CNSTI4 384
ARGI4
ADDRLP4 56
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 4728
ARGP4
ADDRLP4 5760
ADDRGP4 trap_CM_MarkFragments
CALLI4
ASGNI4
ADDRLP4 4712
ADDRLP4 5760
INDIRI4
ASGNI4
line 157
;154:					projection, MAX_MARK_POINTS, markPoints[0],
;155:					MAX_MARK_FRAGMENTS, markFragments );
;156:
;157:	colors[0] = red * 255;
ADDRLP4 5768
CNSTF4 1132396544
ADDRFP4 16
INDIRF4
MULF4
ASGNF4
ADDRLP4 5772
CNSTF4 1325400064
ASGNF4
ADDRLP4 5768
INDIRF4
ADDRLP4 5772
INDIRF4
LTF4 $129
ADDRLP4 5764
ADDRLP4 5768
INDIRF4
ADDRLP4 5772
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $130
JUMPV
LABELV $129
ADDRLP4 5764
ADDRLP4 5768
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $130
ADDRLP4 52
ADDRLP4 5764
INDIRU4
CVUU1 4
ASGNU1
line 158
;158:	colors[1] = green * 255;
ADDRLP4 5780
CNSTF4 1132396544
ADDRFP4 20
INDIRF4
MULF4
ASGNF4
ADDRLP4 5784
CNSTF4 1325400064
ASGNF4
ADDRLP4 5780
INDIRF4
ADDRLP4 5784
INDIRF4
LTF4 $133
ADDRLP4 5776
ADDRLP4 5780
INDIRF4
ADDRLP4 5784
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $134
JUMPV
LABELV $133
ADDRLP4 5776
ADDRLP4 5780
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $134
ADDRLP4 52+1
ADDRLP4 5776
INDIRU4
CVUU1 4
ASGNU1
line 159
;159:	colors[2] = blue * 255;
ADDRLP4 5792
CNSTF4 1132396544
ADDRFP4 24
INDIRF4
MULF4
ASGNF4
ADDRLP4 5796
CNSTF4 1325400064
ASGNF4
ADDRLP4 5792
INDIRF4
ADDRLP4 5796
INDIRF4
LTF4 $137
ADDRLP4 5788
ADDRLP4 5792
INDIRF4
ADDRLP4 5796
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $138
JUMPV
LABELV $137
ADDRLP4 5788
ADDRLP4 5792
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $138
ADDRLP4 52+2
ADDRLP4 5788
INDIRU4
CVUU1 4
ASGNU1
line 160
;160:	colors[3] = alpha * 255;
ADDRLP4 5804
CNSTF4 1132396544
ADDRFP4 28
INDIRF4
MULF4
ASGNF4
ADDRLP4 5808
CNSTF4 1325400064
ASGNF4
ADDRLP4 5804
INDIRF4
ADDRLP4 5808
INDIRF4
LTF4 $141
ADDRLP4 5800
ADDRLP4 5804
INDIRF4
ADDRLP4 5808
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $142
JUMPV
LABELV $141
ADDRLP4 5800
ADDRLP4 5804
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $142
ADDRLP4 52+3
ADDRLP4 5800
INDIRU4
CVUU1 4
ASGNU1
line 162
;161:
;162:	for ( i = 0, mf = markFragments ; i < numFragments ; i++, mf++ ) {
ADDRLP4 44
CNSTI4 0
ASGNI4
ADDRLP4 40
ADDRLP4 4728
ASGNP4
ADDRGP4 $146
JUMPV
LABELV $143
line 169
;163:		polyVert_t	*v;
;164:		polyVert_t	verts[MAX_VERTS_ON_POLY];
;165:		markPoly_t	*mark;
;166:
;167:		// we have an upper limit on the complexity of polygons
;168:		// that we store persistantly
;169:		if ( mf->numPoints > MAX_VERTS_ON_POLY ) {
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 10
LEI4 $147
line 170
;170:			mf->numPoints = MAX_VERTS_ON_POLY;
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 10
ASGNI4
line 171
;171:		}
LABELV $147
line 172
;172:		for ( j = 0, v = verts ; j < mf->numPoints ; j++, v++ ) {
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 5812
ADDRLP4 5820
ASGNP4
ADDRGP4 $152
JUMPV
LABELV $149
line 175
;173:			vec3_t		delta;
;174:
;175:			VectorCopy( markPoints[mf->firstPoint + j], v->xyz );
ADDRLP4 5812
INDIRP4
CNSTI4 12
ADDRLP4 40
INDIRP4
INDIRI4
ADDRLP4 36
INDIRI4
ADDI4
MULI4
ADDRLP4 56
ADDP4
INDIRB
ASGNB 12
line 177
;176:
;177:			VectorSubtract( v->xyz, origin, delta );
ADDRLP4 6076
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 6060
ADDRLP4 5812
INDIRP4
INDIRF4
ADDRLP4 6076
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 6080
CNSTI4 4
ASGNI4
ADDRLP4 6060+4
ADDRLP4 5812
INDIRP4
ADDRLP4 6080
INDIRI4
ADDP4
INDIRF4
ADDRLP4 6076
INDIRP4
ADDRLP4 6080
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 6084
CNSTI4 8
ASGNI4
ADDRLP4 6060+8
ADDRLP4 5812
INDIRP4
ADDRLP4 6084
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
ADDRLP4 6084
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 178
;178:			v->st[0] = 0.5 + DotProduct( delta, axis[1] ) * texCoordScale;
ADDRLP4 5812
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 6060
INDIRF4
ADDRLP4 0+12
INDIRF4
MULF4
ADDRLP4 6060+4
INDIRF4
ADDRLP4 0+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 6060+8
INDIRF4
ADDRLP4 0+12+8
INDIRF4
MULF4
ADDF4
ADDRLP4 48
INDIRF4
MULF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 179
;179:			v->st[1] = 0.5 + DotProduct( delta, axis[2] ) * texCoordScale;
ADDRLP4 5812
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 6060
INDIRF4
ADDRLP4 0+24
INDIRF4
MULF4
ADDRLP4 6060+4
INDIRF4
ADDRLP4 0+24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 6060+8
INDIRF4
ADDRLP4 0+24+8
INDIRF4
MULF4
ADDF4
ADDRLP4 48
INDIRF4
MULF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 180
;180:			*(int *)v->modulate = *(int *)colors;
ADDRLP4 5812
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 52
INDIRI4
ASGNI4
line 181
;181:		}
LABELV $150
line 172
ADDRLP4 36
ADDRLP4 36
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 5812
ADDRLP4 5812
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
LABELV $152
ADDRLP4 36
INDIRI4
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LTI4 $149
line 184
;182:
;183:		// if it is a temporary (shadow) mark, add it immediately and forget about it
;184:		if ( temporary ) {
ADDRFP4 40
INDIRI4
CNSTI4 0
EQI4 $169
line 185
;185:			trap_R_AddPolyToScene( markShader, mf->numPoints, verts );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ARGI4
ADDRLP4 5820
ARGP4
ADDRGP4 trap_R_AddPolyToScene
CALLV
pop
line 186
;186:			continue;
ADDRGP4 $144
JUMPV
LABELV $169
line 190
;187:		}
;188:
;189:		// otherwise save it persistantly
;190:		mark = CG_AllocMark();
ADDRLP4 6060
ADDRGP4 CG_AllocMark
CALLP4
ASGNP4
ADDRLP4 5816
ADDRLP4 6060
INDIRP4
ASGNP4
line 191
;191:		mark->time = cg.time;
ADDRLP4 5816
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 192
;192:		mark->alphaFade = alphaFade;
ADDRLP4 5816
INDIRP4
CNSTI4 16
ADDP4
ADDRFP4 32
INDIRI4
ASGNI4
line 193
;193:		mark->markShader = markShader;
ADDRLP4 5816
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 194
;194:		mark->poly.numVerts = mf->numPoints;
ADDRLP4 5816
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 195
;195:		mark->color[0] = red;
ADDRLP4 5816
INDIRP4
CNSTI4 20
ADDP4
ADDRFP4 16
INDIRF4
ASGNF4
line 196
;196:		mark->color[1] = green;
ADDRLP4 5816
INDIRP4
CNSTI4 24
ADDP4
ADDRFP4 20
INDIRF4
ASGNF4
line 197
;197:		mark->color[2] = blue;
ADDRLP4 5816
INDIRP4
CNSTI4 28
ADDP4
ADDRFP4 24
INDIRF4
ASGNF4
line 198
;198:		mark->color[3] = alpha;
ADDRLP4 5816
INDIRP4
CNSTI4 32
ADDP4
ADDRFP4 28
INDIRF4
ASGNF4
line 199
;199:		memcpy( mark->verts, verts, mf->numPoints * sizeof( verts[0] ) );
ADDRLP4 5816
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRLP4 5820
ARGP4
CNSTU4 24
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CVIU4 4
MULU4
CVUI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 200
;200:		markTotal++;
ADDRLP4 6064
ADDRGP4 markTotal
ASGNP4
ADDRLP4 6064
INDIRP4
ADDRLP4 6064
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 201
;201:	}
LABELV $144
line 162
ADDRLP4 44
ADDRLP4 44
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 40
ADDRLP4 40
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
LABELV $146
ADDRLP4 44
INDIRI4
ADDRLP4 4712
INDIRI4
LTI4 $143
line 202
;202:}
LABELV $99
endproc CG_ImpactMark 6088 28
export CG_AddMarks
proc CG_AddMarks 88 12
line 213
;203:
;204:
;205:/*
;206:===============
;207:CG_AddMarks
;208:===============
;209:*/
;210:#define	MARK_TOTAL_TIME		10000
;211:#define	MARK_FADE_TIME		1000
;212:
;213:void CG_AddMarks( void ) {
line 219
;214:	int			j;
;215:	markPoly_t	*mp, *next;
;216:	int			t;
;217:	int			fade;
;218:
;219:	if ( !cg_addMarks.integer ) {
ADDRGP4 cg_addMarks+12
INDIRI4
CNSTI4 0
NEI4 $173
line 220
;220:		return;
ADDRGP4 $172
JUMPV
LABELV $173
line 223
;221:	}
;222:
;223:	mp = cg_activeMarkPolys.nextMark;
ADDRLP4 0
ADDRGP4 cg_activeMarkPolys+4
INDIRP4
ASGNP4
line 224
;224:	for ( ; mp != &cg_activeMarkPolys ; mp = next ) {
ADDRGP4 $180
JUMPV
LABELV $177
line 227
;225:		// grab next now, so if the local entity is freed we
;226:		// still have it
;227:		next = mp->nextMark;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ASGNP4
line 230
;228:
;229:		// see if it is time to completely remove it
;230:		if ( ( cg.time > mp->time + MARK_TOTAL_TIME && cg_addMarks.integer == 1 ) ||
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 10000
ADDI4
LEI4 $193
ADDRGP4 cg_addMarks+12
INDIRI4
CNSTI4 1
EQI4 $194
LABELV $193
ADDRLP4 20
CNSTI4 1000
ASGNI4
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
ADDRGP4 cg_addMarks+12
INDIRI4
MULI4
ADDI4
LEI4 $196
ADDRGP4 cg_addMarks+12
INDIRI4
CNSTI4 1
LEI4 $196
ADDRGP4 cg_addMarks+12
INDIRI4
ADDRLP4 20
INDIRI4
LTI4 $194
LABELV $196
ADDRLP4 24
CNSTI4 1000
ASGNI4
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
ADDRGP4 cg_addMarks+12
INDIRI4
MULI4
CNSTI4 1000000
SUBI4
ADDI4
LEI4 $181
ADDRGP4 cg_addMarks+12
INDIRI4
ADDRLP4 24
INDIRI4
LTI4 $181
LABELV $194
line 232
;231:			( cg.time > mp->time + (cg_addMarks.integer * 1000) && cg_addMarks.integer > 1 && cg_addMarks.integer < 1000 ) ||
;232:			( cg.time > mp->time + ((cg_addMarks.integer - 1000) * 1000) && cg_addMarks.integer >= 1000) ) {
line 233
;233:			CG_FreeMarkPoly( mp );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_FreeMarkPoly
CALLV
pop
line 234
;234:			continue;
ADDRGP4 $178
JUMPV
LABELV $181
line 238
;235:		}
;236:
;237:		// fade out the energy bursts
;238:		if ( mp->markShader == cgs.media.energyMarkShader ) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRGP4 cgs+156680+444
INDIRI4
NEI4 $197
line 239
;239:			fade = 450 - 450 * ( (cg.time - mp->time ) / 3000.0 );
ADDRLP4 28
CNSTF4 1138819072
ASGNF4
ADDRLP4 8
ADDRLP4 28
INDIRF4
ADDRLP4 28
INDIRF4
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1161527296
DIVF4
MULF4
SUBF4
CVFI4 4
ASGNI4
line 240
;240:			if ( fade < 255 ) {
ADDRLP4 8
INDIRI4
CNSTI4 255
GEI4 $202
line 241
;241:				if ( fade < 0 ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
GEI4 $204
line 242
;242:					fade = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 243
;243:				}
LABELV $204
line 244
;244:				if ( mp->verts[0].modulate[0] != 0 ) {
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRU1
CVUI4 1
CNSTI4 0
EQI4 $206
line 245
;245:					for ( j = 0 ; j < mp->poly.numVerts ; j++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $211
JUMPV
LABELV $208
line 246
;246:						mp->verts[j].modulate[0] = mp->color[0] * fade;
ADDRLP4 40
CNSTI4 20
ASGNI4
ADDRLP4 44
ADDRLP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
ADDRLP4 8
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 48
CNSTF4 1325400064
ASGNF4
ADDRLP4 44
INDIRF4
ADDRLP4 48
INDIRF4
LTF4 $213
ADDRLP4 32
ADDRLP4 44
INDIRF4
ADDRLP4 48
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $214
JUMPV
LABELV $213
ADDRLP4 32
ADDRLP4 44
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $214
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ADDP4
ADDRLP4 40
INDIRI4
ADDP4
ADDRLP4 32
INDIRU4
CVUU1 4
ASGNU1
line 247
;247:						mp->verts[j].modulate[1] = mp->color[1] * fade;
ADDRLP4 60
CNSTI4 24
ASGNI4
ADDRLP4 64
ADDRLP4 0
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRF4
ADDRLP4 8
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 68
CNSTF4 1325400064
ASGNF4
ADDRLP4 64
INDIRF4
ADDRLP4 68
INDIRF4
LTF4 $216
ADDRLP4 52
ADDRLP4 64
INDIRF4
ADDRLP4 68
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $217
JUMPV
LABELV $216
ADDRLP4 52
ADDRLP4 64
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $217
ADDRLP4 60
INDIRI4
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ADDP4
CNSTI4 21
ADDP4
ADDRLP4 52
INDIRU4
CVUU1 4
ASGNU1
line 248
;248:						mp->verts[j].modulate[2] = mp->color[2] * fade;
ADDRLP4 80
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 8
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 84
CNSTF4 1325400064
ASGNF4
ADDRLP4 80
INDIRF4
ADDRLP4 84
INDIRF4
LTF4 $219
ADDRLP4 72
ADDRLP4 80
INDIRF4
ADDRLP4 84
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $220
JUMPV
LABELV $219
ADDRLP4 72
ADDRLP4 80
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $220
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ADDP4
CNSTI4 22
ADDP4
ADDRLP4 72
INDIRU4
CVUU1 4
ASGNU1
line 249
;249:					}
LABELV $209
line 245
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $211
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
LTI4 $208
line 250
;250:				}
LABELV $206
line 251
;251:			}
LABELV $202
line 252
;252:		}
LABELV $197
line 255
;253:
;254:		// fade all marks out with time
;255:		if ( cg_addMarks.integer == 1 || cg_addMarks.integer > 1000) {
ADDRGP4 cg_addMarks+12
INDIRI4
CNSTI4 1
EQI4 $225
ADDRGP4 cg_addMarks+12
INDIRI4
CNSTI4 1000
LEI4 $221
LABELV $225
line 257
;256:			//Do normal fade timing
;257:			t = mp->time + MARK_TOTAL_TIME - cg.time;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 10000
ADDI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
ASGNI4
line 258
;258:		} else if ( cg_addMarks.integer > 1 && cg_addMarks.integer < 1000 ) {
ADDRGP4 $222
JUMPV
LABELV $221
ADDRGP4 cg_addMarks+12
INDIRI4
CNSTI4 1
LEI4 $227
ADDRGP4 cg_addMarks+12
INDIRI4
CNSTI4 1000
GEI4 $227
line 260
;259:			//Time corrected fading
;260:			t = (mp->time + (cg_addMarks.integer * 1000)) + MARK_TOTAL_TIME - cg.time;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1000
ADDRGP4 cg_addMarks+12
INDIRI4
MULI4
ADDI4
CNSTI4 10000
ADDI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
ASGNI4
line 261
;261:		}
LABELV $227
LABELV $222
line 262
;262:		if ( t < MARK_FADE_TIME ) {
ADDRLP4 12
INDIRI4
CNSTI4 1000
GEI4 $233
line 263
;263:			fade = 255 * t / MARK_FADE_TIME;
ADDRLP4 8
CNSTI4 255
ADDRLP4 12
INDIRI4
MULI4
CNSTI4 1000
DIVI4
ASGNI4
line 264
;264:			if ( mp->alphaFade ) {
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
EQI4 $235
line 265
;265:				for ( j = 0 ; j < mp->poly.numVerts ; j++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $240
JUMPV
LABELV $237
line 266
;266:					mp->verts[j].modulate[3] = fade;
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ADDP4
CNSTI4 23
ADDP4
ADDRLP4 8
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 267
;267:				}
LABELV $238
line 265
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $240
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
LTI4 $237
line 268
;268:			} else {
ADDRGP4 $236
JUMPV
LABELV $235
line 269
;269:				for ( j = 0 ; j < mp->poly.numVerts ; j++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $244
JUMPV
LABELV $241
line 270
;270:					mp->verts[j].modulate[0] = mp->color[0] * fade;
ADDRLP4 36
CNSTI4 20
ASGNI4
ADDRLP4 40
ADDRLP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
ADDRLP4 8
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 44
CNSTF4 1325400064
ASGNF4
ADDRLP4 40
INDIRF4
ADDRLP4 44
INDIRF4
LTF4 $246
ADDRLP4 28
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
ADDRGP4 $247
JUMPV
LABELV $246
ADDRLP4 28
ADDRLP4 40
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $247
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ADDP4
ADDRLP4 36
INDIRI4
ADDP4
ADDRLP4 28
INDIRU4
CVUU1 4
ASGNU1
line 271
;271:					mp->verts[j].modulate[1] = mp->color[1] * fade;
ADDRLP4 56
CNSTI4 24
ASGNI4
ADDRLP4 60
ADDRLP4 0
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
ADDRLP4 8
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 64
CNSTF4 1325400064
ASGNF4
ADDRLP4 60
INDIRF4
ADDRLP4 64
INDIRF4
LTF4 $249
ADDRLP4 48
ADDRLP4 60
INDIRF4
ADDRLP4 64
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $250
JUMPV
LABELV $249
ADDRLP4 48
ADDRLP4 60
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $250
ADDRLP4 56
INDIRI4
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ADDP4
CNSTI4 21
ADDP4
ADDRLP4 48
INDIRU4
CVUU1 4
ASGNU1
line 272
;272:					mp->verts[j].modulate[2] = mp->color[2] * fade;
ADDRLP4 76
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 8
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 80
CNSTF4 1325400064
ASGNF4
ADDRLP4 76
INDIRF4
ADDRLP4 80
INDIRF4
LTF4 $252
ADDRLP4 68
ADDRLP4 76
INDIRF4
ADDRLP4 80
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $253
JUMPV
LABELV $252
ADDRLP4 68
ADDRLP4 76
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $253
CNSTI4 24
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ADDP4
CNSTI4 22
ADDP4
ADDRLP4 68
INDIRU4
CVUU1 4
ASGNU1
line 273
;273:				}
LABELV $242
line 269
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $244
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
LTI4 $241
line 274
;274:			}
LABELV $236
line 275
;275:		}
LABELV $233
line 278
;276:
;277:
;278:		trap_R_AddPolyToScene( mp->markShader, mp->poly.numVerts, mp->verts );
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRGP4 trap_R_AddPolyToScene
CALLV
pop
line 279
;279:	}
LABELV $178
line 224
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
LABELV $180
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 cg_activeMarkPolys
CVPU4 4
NEU4 $177
line 280
;280:}
LABELV $172
endproc CG_AddMarks 88 12
data
align 4
LABELV shaderAnimNames
address $255
byte 4 0
skip 120
align 4
LABELV shaderAnimCounts
byte 4 23
skip 124
align 4
LABELV shaderAnimSTRatio
byte 4 1065353216
skip 124
export cl_numparticles
align 4
LABELV cl_numparticles
byte 4 1024
export initparticles
align 4
LABELV initparticles
byte 4 0
export CG_ClearParticles
code
proc CG_ClearParticles 28 12
line 384
;281:
;282:// cg_particles.c  
;283:
;284:#define BLOODRED	2
;285:#define EMISIVEFADE	3
;286:#define GREY75		4
;287:
;288:typedef struct particle_s
;289:{
;290:	struct particle_s	*next;
;291:
;292:	float		time;
;293:	float		endtime;
;294:
;295:	vec3_t		org;
;296:	vec3_t		vel;
;297:	vec3_t		accel;
;298:	int			color;
;299:	float		colorvel;
;300:	float		alpha;
;301:	float		alphavel;
;302:	int			type;
;303:	qhandle_t	pshader;
;304:	
;305:	float		height;
;306:	float		width;
;307:				
;308:	float		endheight;
;309:	float		endwidth;
;310:	
;311:	float		start;
;312:	float		end;
;313:
;314:	float		startfade;
;315:	qboolean	rotate;
;316:	int			snum;
;317:	
;318:	qboolean	link;
;319:
;320:	// Ridah
;321:	int			shaderAnim;
;322:	int			roll;
;323:
;324:	int			accumroll;
;325:
;326:} cparticle_t;
;327:
;328:typedef enum
;329:{
;330:	P_NONE,
;331:	P_WEATHER,
;332:	P_FLAT,
;333:	P_SMOKE,
;334:	P_ROTATE,
;335:	P_WEATHER_TURBULENT,
;336:	P_ANIM,	// Ridah
;337:	P_BAT,
;338:	P_BLEED,
;339:	P_FLAT_SCALEUP,
;340:	P_FLAT_SCALEUP_FADE,
;341:	P_WEATHER_FLURRY,
;342:	P_SMOKE_IMPACT,
;343:	P_BUBBLE,
;344:	P_BUBBLE_TURBULENT,
;345:	P_SPRITE
;346:} particle_type_t;
;347:
;348:#define	MAX_SHADER_ANIMS		32
;349:#define	MAX_SHADER_ANIM_FRAMES	64
;350:
;351:static char *shaderAnimNames[MAX_SHADER_ANIMS] = {
;352:	"explode1",
;353:	NULL
;354:};
;355:static qhandle_t shaderAnims[MAX_SHADER_ANIMS][MAX_SHADER_ANIM_FRAMES];
;356:static int	shaderAnimCounts[MAX_SHADER_ANIMS] = {
;357:	23
;358:};
;359:static float	shaderAnimSTRatio[MAX_SHADER_ANIMS] = {
;360:	1.0f
;361:};
;362:static int	numShaderAnims;
;363:// done.
;364:
;365:#define		PARTICLE_GRAVITY	40
;366:#define		MAX_PARTICLES	1024
;367:
;368:cparticle_t	*active_particles, *free_particles;
;369:cparticle_t	particles[MAX_PARTICLES];
;370:int		cl_numparticles = MAX_PARTICLES;
;371:
;372:qboolean		initparticles = qfalse;
;373:vec3_t			pvforward, pvright, pvup;
;374:vec3_t			rforward, rright, rup;
;375:
;376:float			oldtime;
;377:
;378:/*
;379:===============
;380:CL_ClearParticles
;381:===============
;382:*/
;383:void CG_ClearParticles (void)
;384:{
line 387
;385:	int		i;
;386:
;387:	memset( particles, 0, sizeof(particles) );
ADDRGP4 particles
ARGP4
CNSTI4 0
ARGI4
CNSTI4 126976
ARGI4
ADDRGP4 memset
CALLP4
pop
line 389
;388:
;389:	free_particles = &particles[0];
ADDRGP4 free_particles
ADDRGP4 particles
ASGNP4
line 390
;390:	active_particles = NULL;
ADDRGP4 active_particles
CNSTP4 0
ASGNP4
line 392
;391:
;392:	for (i=0 ;i<cl_numparticles ; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $260
JUMPV
LABELV $257
line 393
;393:	{
line 394
;394:		particles[i].next = &particles[i+1];
ADDRLP4 4
CNSTI4 124
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRGP4 particles
ADDP4
ADDRLP4 4
INDIRI4
ADDRGP4 particles+124
ADDP4
ASGNP4
line 395
;395:		particles[i].type = 0;
CNSTI4 124
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 particles+64
ADDP4
CNSTI4 0
ASGNI4
line 396
;396:	}
LABELV $258
line 392
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $260
ADDRLP4 0
INDIRI4
ADDRGP4 cl_numparticles
INDIRI4
LTI4 $257
line 397
;397:	particles[cl_numparticles-1].next = NULL;
CNSTI4 124
ADDRGP4 cl_numparticles
INDIRI4
MULI4
ADDRGP4 particles-124
ADDP4
CNSTP4 0
ASGNP4
line 399
;398:
;399:	oldtime = cg.time;
ADDRGP4 oldtime
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ASGNF4
line 402
;400:
;401:	// Ridah, init the shaderAnims
;402:	for (i=0; shaderAnimNames[i]; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $268
JUMPV
LABELV $265
line 405
;403:		int j;
;404:
;405:		for (j=0; j<shaderAnimCounts[i]; j++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $272
JUMPV
LABELV $269
line 406
;406:			shaderAnims[i][j] = trap_R_RegisterShader( va("%s%i", shaderAnimNames[i], j+1) );
ADDRGP4 $273
ARGP4
ADDRLP4 12
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 12
INDIRI4
LSHI4
ADDRGP4 shaderAnimNames
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 12
INDIRI4
LSHI4
ADDRLP4 0
INDIRI4
CNSTI4 8
LSHI4
ADDRGP4 shaderAnims
ADDP4
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 407
;407:		}
LABELV $270
line 405
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $272
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 shaderAnimCounts
ADDP4
INDIRI4
LTI4 $269
line 408
;408:	}
LABELV $266
line 402
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $268
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 shaderAnimNames
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $265
line 409
;409:	numShaderAnims = i;
ADDRGP4 numShaderAnims
ADDRLP4 0
INDIRI4
ASGNI4
line 412
;410:	// done.
;411:
;412:	initparticles = qtrue;
ADDRGP4 initparticles
CNSTI4 1
ASGNI4
line 413
;413:}
LABELV $256
endproc CG_ClearParticles 28 12
export CG_AddParticleToScene
proc CG_AddParticleToScene 472 16
line 422
;414:
;415:
;416:/*
;417:=====================
;418:CG_AddParticleToScene
;419:=====================
;420:*/
;421:void CG_AddParticleToScene (cparticle_t *p, vec3_t org, float alpha)
;422:{
line 435
;423:
;424:	vec3_t		point;
;425:	polyVert_t	verts[4];
;426:	float		width;
;427:	float		height;
;428:	float		time, time2;
;429:	float		ratio;
;430:	float		invratio;
;431:	vec3_t		color;
;432:	polyVert_t	TRIverts[3];
;433:	vec3_t		rright2, rup2;
;434:
;435:	if (p->type == P_WEATHER || p->type == P_WEATHER_TURBULENT || p->type == P_WEATHER_FLURRY
ADDRLP4 240
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ASGNI4
ADDRLP4 240
INDIRI4
CNSTI4 1
EQI4 $280
ADDRLP4 240
INDIRI4
CNSTI4 5
EQI4 $280
ADDRLP4 240
INDIRI4
CNSTI4 11
EQI4 $280
ADDRLP4 240
INDIRI4
CNSTI4 13
EQI4 $280
ADDRLP4 240
INDIRI4
CNSTI4 14
NEI4 $275
LABELV $280
line 437
;436:		|| p->type == P_BUBBLE || p->type == P_BUBBLE_TURBULENT)
;437:	{// create a front facing polygon
line 439
;438:			
;439:		if (p->type != P_WEATHER_FLURRY)
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
CNSTI4 11
EQI4 $281
line 440
;440:		{
line 441
;441:			if (p->type == P_BUBBLE || p->type == P_BUBBLE_TURBULENT)
ADDRLP4 244
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ASGNI4
ADDRLP4 244
INDIRI4
CNSTI4 13
EQI4 $285
ADDRLP4 244
INDIRI4
CNSTI4 14
NEI4 $283
LABELV $285
line 442
;442:			{
line 443
;443:				if (org[2] > p->end)			
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
LEF4 $284
line 444
;444:				{	
line 445
;445:					p->time = cg.time;	
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ASGNF4
line 446
;446:					VectorCopy (org, p->org); // Ridah, fixes rare snow flakes that flicker on the ground
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 448
;447:									
;448:					p->org[2] = ( p->start + crandom () * 4 );
ADDRLP4 248
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 252
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 252
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 252
INDIRP4
CNSTI4 88
ADDP4
INDIRF4
CNSTF4 1082130432
CNSTF4 1073741824
ADDRLP4 248
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
ASGNF4
line 451
;449:					
;450:					
;451:					if (p->type == P_BUBBLE_TURBULENT)
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
CNSTI4 14
NEI4 $284
line 452
;452:					{
line 453
;453:						p->vel[0] = crandom() * 4;
ADDRLP4 256
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 1082130432
CNSTF4 1073741824
ADDRLP4 256
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
ASGNF4
line 454
;454:						p->vel[1] = crandom() * 4;
ADDRLP4 260
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1082130432
CNSTF4 1073741824
ADDRLP4 260
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
ASGNF4
line 455
;455:					}
line 457
;456:				
;457:				}
line 458
;458:			}
ADDRGP4 $284
JUMPV
LABELV $283
line 460
;459:			else
;460:			{
line 461
;461:				if (org[2] < p->end)			
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
GEF4 $291
line 462
;462:				{	
line 463
;463:					p->time = cg.time;	
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ASGNF4
line 464
;464:					VectorCopy (org, p->org); // Ridah, fixes rare snow flakes that flicker on the ground
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
ADDRGP4 $295
JUMPV
LABELV $294
line 467
;465:									
;466:					while (p->org[2] < p->end) 
;467:					{
line 468
;468:						p->org[2] += (p->start - p->end); 
ADDRLP4 248
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 252
ADDRLP4 248
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 252
INDIRP4
ADDRLP4 252
INDIRP4
INDIRF4
ADDRLP4 248
INDIRP4
CNSTI4 88
ADDP4
INDIRF4
ADDRLP4 248
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ADDF4
ASGNF4
line 469
;469:					}
LABELV $295
line 466
ADDRLP4 248
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 248
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 248
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
LTF4 $294
line 472
;470:					
;471:					
;472:					if (p->type == P_WEATHER_TURBULENT)
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
CNSTI4 5
NEI4 $297
line 473
;473:					{
line 474
;474:						p->vel[0] = crandom() * 16;
ADDRLP4 252
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 1098907648
CNSTF4 1073741824
ADDRLP4 252
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
ASGNF4
line 475
;475:						p->vel[1] = crandom() * 16;
ADDRLP4 256
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1098907648
CNSTF4 1073741824
ADDRLP4 256
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
ASGNF4
line 476
;476:					}
LABELV $297
line 478
;477:				
;478:				}
LABELV $291
line 479
;479:			}
LABELV $284
line 483
;480:			
;481:
;482:			// Rafael snow pvs check
;483:			if (!p->link)
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 0
NEI4 $299
line 484
;484:				return;
ADDRGP4 $274
JUMPV
LABELV $299
line 486
;485:
;486:			p->alpha = 1;
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 1065353216
ASGNF4
line 487
;487:		}
LABELV $281
line 490
;488:		
;489:		// Ridah, had to do this or MAX_POLYS is being exceeded in village1.bsp
;490:		if (Distance( cg.snap->ps.origin, org ) > 1024) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 64
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 244
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 244
INDIRF4
CNSTF4 1149239296
LEF4 $301
line 491
;491:			return;
ADDRGP4 $274
JUMPV
LABELV $301
line 495
;492:		}
;493:		// done.
;494:	
;495:		if (p->type == P_BUBBLE || p->type == P_BUBBLE_TURBULENT)
ADDRLP4 248
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ASGNI4
ADDRLP4 248
INDIRI4
CNSTI4 13
EQI4 $306
ADDRLP4 248
INDIRI4
CNSTI4 14
NEI4 $304
LABELV $306
line 496
;496:		{
line 497
;497:			VectorMA (org, -p->height, pvup, point);	
ADDRLP4 252
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 256
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 252
INDIRP4
INDIRF4
ADDRGP4 pvup
INDIRF4
ADDRLP4 256
INDIRP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 252
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 pvup+4
INDIRF4
ADDRLP4 256
INDIRP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 pvup+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 498
;498:			VectorMA (point, -p->width, pvright, point);	
ADDRLP4 260
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRGP4 pvright
INDIRF4
ADDRLP4 260
INDIRP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRGP4 pvright+4
INDIRF4
ADDRLP4 260
INDIRP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRGP4 pvright+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 499
;499:			VectorCopy (point, verts[0].xyz);	
ADDRLP4 12
ADDRLP4 0
INDIRB
ASGNB 12
line 500
;500:			verts[0].st[0] = 0;	
ADDRLP4 12+12
CNSTF4 0
ASGNF4
line 501
;501:			verts[0].st[1] = 0;	
ADDRLP4 12+12+4
CNSTF4 0
ASGNF4
line 502
;502:			verts[0].modulate[0] = 255;	
ADDRLP4 12+20
CNSTU1 255
ASGNU1
line 503
;503:			verts[0].modulate[1] = 255;	
ADDRLP4 12+20+1
CNSTU1 255
ASGNU1
line 504
;504:			verts[0].modulate[2] = 255;	
ADDRLP4 12+20+2
CNSTU1 255
ASGNU1
line 505
;505:			verts[0].modulate[3] = 255 * p->alpha;	
ADDRLP4 268
CNSTF4 1132396544
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 272
CNSTF4 1325400064
ASGNF4
ADDRLP4 268
INDIRF4
ADDRLP4 272
INDIRF4
LTF4 $328
ADDRLP4 264
ADDRLP4 268
INDIRF4
ADDRLP4 272
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $329
JUMPV
LABELV $328
ADDRLP4 264
ADDRLP4 268
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $329
ADDRLP4 12+20+3
ADDRLP4 264
INDIRU4
CVUU1 4
ASGNU1
line 507
;506:
;507:			VectorMA (org, -p->height, pvup, point);	
ADDRLP4 276
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 280
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 276
INDIRP4
INDIRF4
ADDRGP4 pvup
INDIRF4
ADDRLP4 280
INDIRP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 276
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 pvup+4
INDIRF4
ADDRLP4 280
INDIRP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 pvup+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 508
;508:			VectorMA (point, p->width, pvright, point);	
ADDRLP4 284
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRGP4 pvright
INDIRF4
ADDRLP4 284
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRGP4 pvright+4
INDIRF4
ADDRLP4 284
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRGP4 pvright+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 509
;509:			VectorCopy (point, verts[1].xyz);	
ADDRLP4 12+24
ADDRLP4 0
INDIRB
ASGNB 12
line 510
;510:			verts[1].st[0] = 0;	
ADDRLP4 12+24+12
CNSTF4 0
ASGNF4
line 511
;511:			verts[1].st[1] = 1;	
ADDRLP4 12+24+12+4
CNSTF4 1065353216
ASGNF4
line 512
;512:			verts[1].modulate[0] = 255;	
ADDRLP4 12+24+20
CNSTU1 255
ASGNU1
line 513
;513:			verts[1].modulate[1] = 255;	
ADDRLP4 12+24+20+1
CNSTU1 255
ASGNU1
line 514
;514:			verts[1].modulate[2] = 255;	
ADDRLP4 12+24+20+2
CNSTU1 255
ASGNU1
line 515
;515:			verts[1].modulate[3] = 255 * p->alpha;	
ADDRLP4 292
CNSTF4 1132396544
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 296
CNSTF4 1325400064
ASGNF4
ADDRLP4 292
INDIRF4
ADDRLP4 296
INDIRF4
LTF4 $358
ADDRLP4 288
ADDRLP4 292
INDIRF4
ADDRLP4 296
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $359
JUMPV
LABELV $358
ADDRLP4 288
ADDRLP4 292
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $359
ADDRLP4 12+24+20+3
ADDRLP4 288
INDIRU4
CVUU1 4
ASGNU1
line 517
;516:
;517:			VectorMA (org, p->height, pvup, point);	
ADDRLP4 300
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 304
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 300
INDIRP4
INDIRF4
ADDRGP4 pvup
INDIRF4
ADDRLP4 304
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 300
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 pvup+4
INDIRF4
ADDRLP4 304
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 pvup+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 518
;518:			VectorMA (point, p->width, pvright, point);	
ADDRLP4 308
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRGP4 pvright
INDIRF4
ADDRLP4 308
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRGP4 pvright+4
INDIRF4
ADDRLP4 308
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRGP4 pvright+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 519
;519:			VectorCopy (point, verts[2].xyz);	
ADDRLP4 12+48
ADDRLP4 0
INDIRB
ASGNB 12
line 520
;520:			verts[2].st[0] = 1;	
ADDRLP4 12+48+12
CNSTF4 1065353216
ASGNF4
line 521
;521:			verts[2].st[1] = 1;	
ADDRLP4 12+48+12+4
CNSTF4 1065353216
ASGNF4
line 522
;522:			verts[2].modulate[0] = 255;	
ADDRLP4 12+48+20
CNSTU1 255
ASGNU1
line 523
;523:			verts[2].modulate[1] = 255;	
ADDRLP4 12+48+20+1
CNSTU1 255
ASGNU1
line 524
;524:			verts[2].modulate[2] = 255;	
ADDRLP4 12+48+20+2
CNSTU1 255
ASGNU1
line 525
;525:			verts[2].modulate[3] = 255 * p->alpha;	
ADDRLP4 316
CNSTF4 1132396544
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 320
CNSTF4 1325400064
ASGNF4
ADDRLP4 316
INDIRF4
ADDRLP4 320
INDIRF4
LTF4 $388
ADDRLP4 312
ADDRLP4 316
INDIRF4
ADDRLP4 320
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $389
JUMPV
LABELV $388
ADDRLP4 312
ADDRLP4 316
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $389
ADDRLP4 12+48+20+3
ADDRLP4 312
INDIRU4
CVUU1 4
ASGNU1
line 527
;526:
;527:			VectorMA (org, p->height, pvup, point);	
ADDRLP4 324
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 328
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 324
INDIRP4
INDIRF4
ADDRGP4 pvup
INDIRF4
ADDRLP4 328
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 324
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 pvup+4
INDIRF4
ADDRLP4 328
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 pvup+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 528
;528:			VectorMA (point, -p->width, pvright, point);	
ADDRLP4 332
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRGP4 pvright
INDIRF4
ADDRLP4 332
INDIRP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRGP4 pvright+4
INDIRF4
ADDRLP4 332
INDIRP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRGP4 pvright+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 529
;529:			VectorCopy (point, verts[3].xyz);	
ADDRLP4 12+72
ADDRLP4 0
INDIRB
ASGNB 12
line 530
;530:			verts[3].st[0] = 1;	
ADDRLP4 12+72+12
CNSTF4 1065353216
ASGNF4
line 531
;531:			verts[3].st[1] = 0;	
ADDRLP4 12+72+12+4
CNSTF4 0
ASGNF4
line 532
;532:			verts[3].modulate[0] = 255;	
ADDRLP4 12+72+20
CNSTU1 255
ASGNU1
line 533
;533:			verts[3].modulate[1] = 255;	
ADDRLP4 12+72+20+1
CNSTU1 255
ASGNU1
line 534
;534:			verts[3].modulate[2] = 255;	
ADDRLP4 12+72+20+2
CNSTU1 255
ASGNU1
line 535
;535:			verts[3].modulate[3] = 255 * p->alpha;	
ADDRLP4 340
CNSTF4 1132396544
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 344
CNSTF4 1325400064
ASGNF4
ADDRLP4 340
INDIRF4
ADDRLP4 344
INDIRF4
LTF4 $418
ADDRLP4 336
ADDRLP4 340
INDIRF4
ADDRLP4 344
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $419
JUMPV
LABELV $418
ADDRLP4 336
ADDRLP4 340
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $419
ADDRLP4 12+72+20+3
ADDRLP4 336
INDIRU4
CVUU1 4
ASGNU1
line 536
;536:		}
ADDRGP4 $276
JUMPV
LABELV $304
line 538
;537:		else
;538:		{
line 539
;539:			VectorMA (org, -p->height, pvup, point);	
ADDRLP4 252
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 256
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 252
INDIRP4
INDIRF4
ADDRGP4 pvup
INDIRF4
ADDRLP4 256
INDIRP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 252
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 pvup+4
INDIRF4
ADDRLP4 256
INDIRP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 pvup+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 540
;540:			VectorMA (point, -p->width, pvright, point);	
ADDRLP4 260
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRGP4 pvright
INDIRF4
ADDRLP4 260
INDIRP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRGP4 pvright+4
INDIRF4
ADDRLP4 260
INDIRP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRGP4 pvright+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 541
;541:			VectorCopy( point, TRIverts[0].xyz );
ADDRLP4 108
ADDRLP4 0
INDIRB
ASGNB 12
line 542
;542:			TRIverts[0].st[0] = 1;
ADDRLP4 108+12
CNSTF4 1065353216
ASGNF4
line 543
;543:			TRIverts[0].st[1] = 0;
ADDRLP4 108+12+4
CNSTF4 0
ASGNF4
line 544
;544:			TRIverts[0].modulate[0] = 255;
ADDRLP4 108+20
CNSTU1 255
ASGNU1
line 545
;545:			TRIverts[0].modulate[1] = 255;
ADDRLP4 108+20+1
CNSTU1 255
ASGNU1
line 546
;546:			TRIverts[0].modulate[2] = 255;
ADDRLP4 108+20+2
CNSTU1 255
ASGNU1
line 547
;547:			TRIverts[0].modulate[3] = 255 * p->alpha;	
ADDRLP4 268
CNSTF4 1132396544
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 272
CNSTF4 1325400064
ASGNF4
ADDRLP4 268
INDIRF4
ADDRLP4 272
INDIRF4
LTF4 $441
ADDRLP4 264
ADDRLP4 268
INDIRF4
ADDRLP4 272
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $442
JUMPV
LABELV $441
ADDRLP4 264
ADDRLP4 268
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $442
ADDRLP4 108+20+3
ADDRLP4 264
INDIRU4
CVUU1 4
ASGNU1
line 549
;548:
;549:			VectorMA (org, p->height, pvup, point);	
ADDRLP4 276
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 280
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 276
INDIRP4
INDIRF4
ADDRGP4 pvup
INDIRF4
ADDRLP4 280
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 276
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 pvup+4
INDIRF4
ADDRLP4 280
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 pvup+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 550
;550:			VectorMA (point, -p->width, pvright, point);	
ADDRLP4 284
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRGP4 pvright
INDIRF4
ADDRLP4 284
INDIRP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRGP4 pvright+4
INDIRF4
ADDRLP4 284
INDIRP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRGP4 pvright+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 551
;551:			VectorCopy (point, TRIverts[1].xyz);	
ADDRLP4 108+24
ADDRLP4 0
INDIRB
ASGNB 12
line 552
;552:			TRIverts[1].st[0] = 0;
ADDRLP4 108+24+12
CNSTF4 0
ASGNF4
line 553
;553:			TRIverts[1].st[1] = 0;
ADDRLP4 108+24+12+4
CNSTF4 0
ASGNF4
line 554
;554:			TRIverts[1].modulate[0] = 255;
ADDRLP4 108+24+20
CNSTU1 255
ASGNU1
line 555
;555:			TRIverts[1].modulate[1] = 255;
ADDRLP4 108+24+20+1
CNSTU1 255
ASGNU1
line 556
;556:			TRIverts[1].modulate[2] = 255;
ADDRLP4 108+24+20+2
CNSTU1 255
ASGNU1
line 557
;557:			TRIverts[1].modulate[3] = 255 * p->alpha;	
ADDRLP4 292
CNSTF4 1132396544
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 296
CNSTF4 1325400064
ASGNF4
ADDRLP4 292
INDIRF4
ADDRLP4 296
INDIRF4
LTF4 $471
ADDRLP4 288
ADDRLP4 292
INDIRF4
ADDRLP4 296
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $472
JUMPV
LABELV $471
ADDRLP4 288
ADDRLP4 292
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $472
ADDRLP4 108+24+20+3
ADDRLP4 288
INDIRU4
CVUU1 4
ASGNU1
line 559
;558:
;559:			VectorMA (org, p->height, pvup, point);	
ADDRLP4 300
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 304
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 300
INDIRP4
INDIRF4
ADDRGP4 pvup
INDIRF4
ADDRLP4 304
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 300
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 pvup+4
INDIRF4
ADDRLP4 304
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 pvup+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 560
;560:			VectorMA (point, p->width, pvright, point);	
ADDRLP4 308
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRGP4 pvright
INDIRF4
ADDRLP4 308
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRGP4 pvright+4
INDIRF4
ADDRLP4 308
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRGP4 pvright+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 561
;561:			VectorCopy (point, TRIverts[2].xyz);	
ADDRLP4 108+48
ADDRLP4 0
INDIRB
ASGNB 12
line 562
;562:			TRIverts[2].st[0] = 0;
ADDRLP4 108+48+12
CNSTF4 0
ASGNF4
line 563
;563:			TRIverts[2].st[1] = 1;
ADDRLP4 108+48+12+4
CNSTF4 1065353216
ASGNF4
line 564
;564:			TRIverts[2].modulate[0] = 255;
ADDRLP4 108+48+20
CNSTU1 255
ASGNU1
line 565
;565:			TRIverts[2].modulate[1] = 255;
ADDRLP4 108+48+20+1
CNSTU1 255
ASGNU1
line 566
;566:			TRIverts[2].modulate[2] = 255;
ADDRLP4 108+48+20+2
CNSTU1 255
ASGNU1
line 567
;567:			TRIverts[2].modulate[3] = 255 * p->alpha;	
ADDRLP4 316
CNSTF4 1132396544
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 320
CNSTF4 1325400064
ASGNF4
ADDRLP4 316
INDIRF4
ADDRLP4 320
INDIRF4
LTF4 $501
ADDRLP4 312
ADDRLP4 316
INDIRF4
ADDRLP4 320
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $502
JUMPV
LABELV $501
ADDRLP4 312
ADDRLP4 316
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $502
ADDRLP4 108+48+20+3
ADDRLP4 312
INDIRU4
CVUU1 4
ASGNU1
line 568
;568:		}
line 570
;569:	
;570:	}
ADDRGP4 $276
JUMPV
LABELV $275
line 571
;571:	else if (p->type == P_SPRITE)
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
CNSTI4 15
NEI4 $503
line 572
;572:	{
line 576
;573:		vec3_t	rr, ru;
;574:		vec3_t	rotate_ang;
;575:
;576:		VectorSet (color, 1.0, 1.0, 0.5);
ADDRLP4 280
CNSTF4 1065353216
ASGNF4
ADDRLP4 184
ADDRLP4 280
INDIRF4
ASGNF4
ADDRLP4 184+4
ADDRLP4 280
INDIRF4
ASGNF4
ADDRLP4 184+8
CNSTF4 1056964608
ASGNF4
line 577
;577:		time = cg.time - p->time;
ADDRLP4 232
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 578
;578:		time2 = p->endtime - p->time;
ADDRLP4 284
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 236
ADDRLP4 284
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 284
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 579
;579:		ratio = time / time2;
ADDRLP4 200
ADDRLP4 232
INDIRF4
ADDRLP4 236
INDIRF4
DIVF4
ASGNF4
line 581
;580:
;581:		width = p->width + ( ratio * ( p->endwidth - p->width) );
ADDRLP4 288
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 292
ADDRLP4 288
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ASGNF4
ADDRLP4 196
ADDRLP4 292
INDIRF4
ADDRLP4 200
INDIRF4
ADDRLP4 288
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
ADDRLP4 292
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 582
;582:		height = p->height + ( ratio * ( p->endheight - p->height) );
ADDRLP4 296
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 300
ADDRLP4 296
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ASGNF4
ADDRLP4 180
ADDRLP4 300
INDIRF4
ADDRLP4 200
INDIRF4
ADDRLP4 296
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
ADDRLP4 300
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 584
;583:
;584:		if (p->roll) {
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
CNSTI4 0
EQI4 $508
line 585
;585:			vectoangles( cg.refdef.viewaxis[0], rotate_ang );
ADDRGP4 cg+109048+36
ARGP4
ADDRLP4 268
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 586
;586:			rotate_ang[ROLL] += p->roll;
ADDRLP4 268+8
ADDRLP4 268+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 587
;587:			AngleVectors ( rotate_ang, NULL, rr, ru);
ADDRLP4 268
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 256
ARGP4
ADDRLP4 244
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 588
;588:		}
LABELV $508
line 590
;589:
;590:		if (p->roll) {
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
CNSTI4 0
EQI4 $513
line 591
;591:			VectorMA (org, -height, ru, point);	
ADDRLP4 304
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 308
ADDRLP4 180
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0
ADDRLP4 304
INDIRP4
INDIRF4
ADDRLP4 244
INDIRF4
ADDRLP4 308
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 304
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 244+4
INDIRF4
ADDRLP4 308
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 244+8
INDIRF4
ADDRLP4 180
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 592
;592:			VectorMA (point, -width, rr, point);	
ADDRLP4 312
ADDRLP4 196
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 256
INDIRF4
ADDRLP4 312
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 256+4
INDIRF4
ADDRLP4 312
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 256+8
INDIRF4
ADDRLP4 196
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 593
;593:		} else {
ADDRGP4 $514
JUMPV
LABELV $513
line 594
;594:			VectorMA (org, -height, pvup, point);	
ADDRLP4 304
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 308
ADDRLP4 180
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0
ADDRLP4 304
INDIRP4
INDIRF4
ADDRGP4 pvup
INDIRF4
ADDRLP4 308
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 304
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 pvup+4
INDIRF4
ADDRLP4 308
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 pvup+8
INDIRF4
ADDRLP4 180
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 595
;595:			VectorMA (point, -width, pvright, point);	
ADDRLP4 312
ADDRLP4 196
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRGP4 pvright
INDIRF4
ADDRLP4 312
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRGP4 pvright+4
INDIRF4
ADDRLP4 312
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRGP4 pvright+8
INDIRF4
ADDRLP4 196
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 596
;596:		}
LABELV $514
line 597
;597:		VectorCopy (point, verts[0].xyz);	
ADDRLP4 12
ADDRLP4 0
INDIRB
ASGNB 12
line 598
;598:		verts[0].st[0] = 0;	
ADDRLP4 12+12
CNSTF4 0
ASGNF4
line 599
;599:		verts[0].st[1] = 0;	
ADDRLP4 12+12+4
CNSTF4 0
ASGNF4
line 600
;600:		verts[0].modulate[0] = 255;	
ADDRLP4 12+20
CNSTU1 255
ASGNU1
line 601
;601:		verts[0].modulate[1] = 255;	
ADDRLP4 12+20+1
CNSTU1 255
ASGNU1
line 602
;602:		verts[0].modulate[2] = 255;	
ADDRLP4 12+20+2
CNSTU1 255
ASGNU1
line 603
;603:		verts[0].modulate[3] = 255;
ADDRLP4 12+20+3
CNSTU1 255
ASGNU1
line 605
;604:
;605:		if (p->roll) {
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
CNSTI4 0
EQI4 $545
line 606
;606:			VectorMA (point, 2*height, ru, point);	
ADDRLP4 304
CNSTF4 1073741824
ADDRLP4 180
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 244
INDIRF4
ADDRLP4 304
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 244+4
INDIRF4
ADDRLP4 304
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 244+8
INDIRF4
CNSTF4 1073741824
ADDRLP4 180
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 607
;607:		} else {
ADDRGP4 $546
JUMPV
LABELV $545
line 608
;608:			VectorMA (point, 2*height, pvup, point);	
ADDRLP4 304
CNSTF4 1073741824
ADDRLP4 180
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRGP4 pvup
INDIRF4
ADDRLP4 304
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRGP4 pvup+4
INDIRF4
ADDRLP4 304
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRGP4 pvup+8
INDIRF4
CNSTF4 1073741824
ADDRLP4 180
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 609
;609:		}
LABELV $546
line 610
;610:		VectorCopy (point, verts[1].xyz);	
ADDRLP4 12+24
ADDRLP4 0
INDIRB
ASGNB 12
line 611
;611:		verts[1].st[0] = 0;	
ADDRLP4 12+24+12
CNSTF4 0
ASGNF4
line 612
;612:		verts[1].st[1] = 1;	
ADDRLP4 12+24+12+4
CNSTF4 1065353216
ASGNF4
line 613
;613:		verts[1].modulate[0] = 255;	
ADDRLP4 12+24+20
CNSTU1 255
ASGNU1
line 614
;614:		verts[1].modulate[1] = 255;	
ADDRLP4 12+24+20+1
CNSTU1 255
ASGNU1
line 615
;615:		verts[1].modulate[2] = 255;	
ADDRLP4 12+24+20+2
CNSTU1 255
ASGNU1
line 616
;616:		verts[1].modulate[3] = 255;	
ADDRLP4 12+24+20+3
CNSTU1 255
ASGNU1
line 618
;617:
;618:		if (p->roll) {
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
CNSTI4 0
EQI4 $576
line 619
;619:			VectorMA (point, 2*width, rr, point);	
ADDRLP4 304
CNSTF4 1073741824
ADDRLP4 196
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 256
INDIRF4
ADDRLP4 304
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 256+4
INDIRF4
ADDRLP4 304
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 256+8
INDIRF4
CNSTF4 1073741824
ADDRLP4 196
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 620
;620:		} else {
ADDRGP4 $577
JUMPV
LABELV $576
line 621
;621:			VectorMA (point, 2*width, pvright, point);	
ADDRLP4 304
CNSTF4 1073741824
ADDRLP4 196
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRGP4 pvright
INDIRF4
ADDRLP4 304
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRGP4 pvright+4
INDIRF4
ADDRLP4 304
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRGP4 pvright+8
INDIRF4
CNSTF4 1073741824
ADDRLP4 196
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 622
;622:		}
LABELV $577
line 623
;623:		VectorCopy (point, verts[2].xyz);	
ADDRLP4 12+48
ADDRLP4 0
INDIRB
ASGNB 12
line 624
;624:		verts[2].st[0] = 1;	
ADDRLP4 12+48+12
CNSTF4 1065353216
ASGNF4
line 625
;625:		verts[2].st[1] = 1;	
ADDRLP4 12+48+12+4
CNSTF4 1065353216
ASGNF4
line 626
;626:		verts[2].modulate[0] = 255;	
ADDRLP4 12+48+20
CNSTU1 255
ASGNU1
line 627
;627:		verts[2].modulate[1] = 255;	
ADDRLP4 12+48+20+1
CNSTU1 255
ASGNU1
line 628
;628:		verts[2].modulate[2] = 255;	
ADDRLP4 12+48+20+2
CNSTU1 255
ASGNU1
line 629
;629:		verts[2].modulate[3] = 255;	
ADDRLP4 12+48+20+3
CNSTU1 255
ASGNU1
line 631
;630:
;631:		if (p->roll) {
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
CNSTI4 0
EQI4 $607
line 632
;632:			VectorMA (point, -2*height, ru, point);	
ADDRLP4 304
CNSTF4 3221225472
ADDRLP4 180
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 244
INDIRF4
ADDRLP4 304
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 244+4
INDIRF4
ADDRLP4 304
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 244+8
INDIRF4
CNSTF4 3221225472
ADDRLP4 180
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 633
;633:		} else {
ADDRGP4 $608
JUMPV
LABELV $607
line 634
;634:			VectorMA (point, -2*height, pvup, point);	
ADDRLP4 304
CNSTF4 3221225472
ADDRLP4 180
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRGP4 pvup
INDIRF4
ADDRLP4 304
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRGP4 pvup+4
INDIRF4
ADDRLP4 304
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRGP4 pvup+8
INDIRF4
CNSTF4 3221225472
ADDRLP4 180
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 635
;635:		}
LABELV $608
line 636
;636:		VectorCopy (point, verts[3].xyz);	
ADDRLP4 12+72
ADDRLP4 0
INDIRB
ASGNB 12
line 637
;637:		verts[3].st[0] = 1;	
ADDRLP4 12+72+12
CNSTF4 1065353216
ASGNF4
line 638
;638:		verts[3].st[1] = 0;	
ADDRLP4 12+72+12+4
CNSTF4 0
ASGNF4
line 639
;639:		verts[3].modulate[0] = 255;	
ADDRLP4 12+72+20
CNSTU1 255
ASGNU1
line 640
;640:		verts[3].modulate[1] = 255;	
ADDRLP4 12+72+20+1
CNSTU1 255
ASGNU1
line 641
;641:		verts[3].modulate[2] = 255;	
ADDRLP4 12+72+20+2
CNSTU1 255
ASGNU1
line 642
;642:		verts[3].modulate[3] = 255;	
ADDRLP4 12+72+20+3
CNSTU1 255
ASGNU1
line 643
;643:	}
ADDRGP4 $504
JUMPV
LABELV $503
line 644
;644:	else if (p->type == P_SMOKE || p->type == P_SMOKE_IMPACT)
ADDRLP4 244
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ASGNI4
ADDRLP4 244
INDIRI4
CNSTI4 3
EQI4 $640
ADDRLP4 244
INDIRI4
CNSTI4 12
NEI4 $638
LABELV $640
line 645
;645:	{// create a front rotating facing polygon
line 647
;646:
;647:		if ( p->type == P_SMOKE_IMPACT && Distance( cg.snap->ps.origin, org ) > 1024) {
ADDRLP4 248
CNSTI4 64
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 248
INDIRI4
ADDP4
INDIRI4
CNSTI4 12
NEI4 $641
ADDRGP4 cg+36
INDIRP4
ADDRLP4 248
INDIRI4
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 252
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 252
INDIRF4
CNSTF4 1149239296
LEF4 $641
line 648
;648:			return;
ADDRGP4 $274
JUMPV
LABELV $641
line 651
;649:		}
;650:
;651:		if (p->color == BLOODRED)
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 2
NEI4 $644
line 652
;652:			VectorSet (color, 0.22f, 0.0f, 0.0f);
ADDRLP4 184
CNSTF4 1046562734
ASGNF4
ADDRLP4 184+4
CNSTF4 0
ASGNF4
ADDRLP4 184+8
CNSTF4 0
ASGNF4
ADDRGP4 $645
JUMPV
LABELV $644
line 653
;653:		else if (p->color == GREY75)
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 4
NEI4 $648
line 654
;654:		{
line 658
;655:			float	len;
;656:			float	greyit;
;657:			float	val;
;658:			len = Distance (cg.snap->ps.origin, org);
ADDRGP4 cg+36
INDIRP4
CNSTI4 64
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 268
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 260
ADDRLP4 268
INDIRF4
ASGNF4
line 659
;659:			if (!len)
ADDRLP4 260
INDIRF4
CNSTF4 0
NEF4 $651
line 660
;660:				len = 1;
ADDRLP4 260
CNSTF4 1065353216
ASGNF4
LABELV $651
line 662
;661:
;662:			val = 4096/len;
ADDRLP4 264
CNSTF4 1166016512
ADDRLP4 260
INDIRF4
DIVF4
ASGNF4
line 663
;663:			greyit = 0.25 * val;
ADDRLP4 256
CNSTF4 1048576000
ADDRLP4 264
INDIRF4
MULF4
ASGNF4
line 664
;664:			if (greyit > 0.5)
ADDRLP4 256
INDIRF4
CNSTF4 1056964608
LEF4 $653
line 665
;665:				greyit = 0.5;
ADDRLP4 256
CNSTF4 1056964608
ASGNF4
LABELV $653
line 667
;666:
;667:			VectorSet (color, greyit, greyit, greyit);
ADDRLP4 272
ADDRLP4 256
INDIRF4
ASGNF4
ADDRLP4 184
ADDRLP4 272
INDIRF4
ASGNF4
ADDRLP4 184+4
ADDRLP4 272
INDIRF4
ASGNF4
ADDRLP4 184+8
ADDRLP4 256
INDIRF4
ASGNF4
line 668
;668:		}
ADDRGP4 $649
JUMPV
LABELV $648
line 670
;669:		else
;670:			VectorSet (color, 1.0, 1.0, 1.0);
ADDRLP4 256
CNSTF4 1065353216
ASGNF4
ADDRLP4 184
ADDRLP4 256
INDIRF4
ASGNF4
ADDRLP4 184+4
ADDRLP4 256
INDIRF4
ASGNF4
ADDRLP4 184+8
CNSTF4 1065353216
ASGNF4
LABELV $649
LABELV $645
line 672
;671:
;672:		time = cg.time - p->time;
ADDRLP4 232
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 673
;673:		time2 = p->endtime - p->time;
ADDRLP4 260
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 236
ADDRLP4 260
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 260
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 674
;674:		ratio = time / time2;
ADDRLP4 200
ADDRLP4 232
INDIRF4
ADDRLP4 236
INDIRF4
DIVF4
ASGNF4
line 676
;675:		
;676:		if (cg.time > p->startfade)
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ADDRFP4 0
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
LEF4 $660
line 677
;677:		{
line 678
;678:			invratio = 1 - ( (cg.time - p->startfade) / (p->endtime - p->startfade) );
ADDRLP4 264
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 268
ADDRLP4 264
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ASGNF4
ADDRLP4 204
CNSTF4 1065353216
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ADDRLP4 268
INDIRF4
SUBF4
ADDRLP4 264
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 268
INDIRF4
SUBF4
DIVF4
SUBF4
ASGNF4
line 680
;679:
;680:			if (p->color == EMISIVEFADE)
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 3
NEI4 $664
line 681
;681:			{
line 683
;682:				float fval;
;683:				fval = (invratio * invratio);
ADDRLP4 276
ADDRLP4 204
INDIRF4
ASGNF4
ADDRLP4 272
ADDRLP4 276
INDIRF4
ADDRLP4 276
INDIRF4
MULF4
ASGNF4
line 684
;684:				if (fval < 0)
ADDRLP4 272
INDIRF4
CNSTF4 0
GEF4 $666
line 685
;685:					fval = 0;
ADDRLP4 272
CNSTF4 0
ASGNF4
LABELV $666
line 686
;686:				VectorSet (color, fval , fval , fval );
ADDRLP4 280
ADDRLP4 272
INDIRF4
ASGNF4
ADDRLP4 184
ADDRLP4 280
INDIRF4
ASGNF4
ADDRLP4 184+4
ADDRLP4 280
INDIRF4
ASGNF4
ADDRLP4 184+8
ADDRLP4 272
INDIRF4
ASGNF4
line 687
;687:			}
LABELV $664
line 688
;688:			invratio *= p->alpha;
ADDRLP4 204
ADDRLP4 204
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
INDIRF4
MULF4
ASGNF4
line 689
;689:		}
ADDRGP4 $661
JUMPV
LABELV $660
line 691
;690:		else 
;691:			invratio = 1 * p->alpha;
ADDRLP4 204
CNSTF4 1065353216
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
INDIRF4
MULF4
ASGNF4
LABELV $661
line 693
;692:
;693:		if ( cgs.glconfig.hardwareType == GLHW_RAGEPRO )
ADDRGP4 cgs+20100+11288
INDIRI4
CNSTI4 3
NEI4 $670
line 694
;694:			invratio = 1;
ADDRLP4 204
CNSTF4 1065353216
ASGNF4
LABELV $670
line 696
;695:
;696:		if (invratio > 1)
ADDRLP4 204
INDIRF4
CNSTF4 1065353216
LEF4 $674
line 697
;697:			invratio = 1;
ADDRLP4 204
CNSTF4 1065353216
ASGNF4
LABELV $674
line 699
;698:	
;699:		width = p->width + ( ratio * ( p->endwidth - p->width) );
ADDRLP4 264
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 268
ADDRLP4 264
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ASGNF4
ADDRLP4 196
ADDRLP4 268
INDIRF4
ADDRLP4 200
INDIRF4
ADDRLP4 264
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
ADDRLP4 268
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 700
;700:		height = p->height + ( ratio * ( p->endheight - p->height) );
ADDRLP4 272
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 276
ADDRLP4 272
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ASGNF4
ADDRLP4 180
ADDRLP4 276
INDIRF4
ADDRLP4 200
INDIRF4
ADDRLP4 272
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
ADDRLP4 276
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 702
;701:
;702:		if (p->type != P_SMOKE_IMPACT)
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
CNSTI4 12
EQI4 $676
line 703
;703:		{
line 706
;704:			vec3_t temp;
;705:
;706:			vectoangles (rforward, temp);
ADDRGP4 rforward
ARGP4
ADDRLP4 280
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 707
;707:			p->accumroll += p->roll;
ADDRLP4 292
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 296
ADDRLP4 292
INDIRP4
CNSTI4 120
ADDP4
ASGNP4
ADDRLP4 296
INDIRP4
ADDRLP4 296
INDIRP4
INDIRI4
ADDRLP4 292
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
ADDI4
ASGNI4
line 708
;708:			temp[ROLL] += p->accumroll * 0.1;
ADDRLP4 280+8
ADDRLP4 280+8
INDIRF4
CNSTF4 1036831949
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 709
;709:			AngleVectors ( temp, NULL, rright2, rup2);
ADDRLP4 280
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 208
ARGP4
ADDRLP4 220
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 710
;710:		}
ADDRGP4 $677
JUMPV
LABELV $676
line 712
;711:		else
;712:		{
line 713
;713:			VectorCopy (rright, rright2);
ADDRLP4 208
ADDRGP4 rright
INDIRB
ASGNB 12
line 714
;714:			VectorCopy (rup, rup2);
ADDRLP4 220
ADDRGP4 rup
INDIRB
ASGNB 12
line 715
;715:		}
LABELV $677
line 717
;716:		
;717:		if (p->rotate)
ADDRFP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRI4
CNSTI4 0
EQI4 $679
line 718
;718:		{
line 719
;719:			VectorMA (org, -height, rup2, point);	
ADDRLP4 280
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 284
ADDRLP4 180
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0
ADDRLP4 280
INDIRP4
INDIRF4
ADDRLP4 220
INDIRF4
ADDRLP4 284
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 280
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 220+4
INDIRF4
ADDRLP4 284
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 220+8
INDIRF4
ADDRLP4 180
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 720
;720:			VectorMA (point, -width, rright2, point);	
ADDRLP4 288
ADDRLP4 196
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 208
INDIRF4
ADDRLP4 288
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 208+4
INDIRF4
ADDRLP4 288
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 208+8
INDIRF4
ADDRLP4 196
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 721
;721:		}
ADDRGP4 $680
JUMPV
LABELV $679
line 723
;722:		else
;723:		{
line 724
;724:			VectorMA (org, -p->height, pvup, point);	
ADDRLP4 280
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 284
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 280
INDIRP4
INDIRF4
ADDRGP4 pvup
INDIRF4
ADDRLP4 284
INDIRP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 280
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 pvup+4
INDIRF4
ADDRLP4 284
INDIRP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 pvup+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 725
;725:			VectorMA (point, -p->width, pvright, point);	
ADDRLP4 288
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRGP4 pvright
INDIRF4
ADDRLP4 288
INDIRP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRGP4 pvright+4
INDIRF4
ADDRLP4 288
INDIRP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRGP4 pvright+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 726
;726:		}
LABELV $680
line 727
;727:		VectorCopy (point, verts[0].xyz);	
ADDRLP4 12
ADDRLP4 0
INDIRB
ASGNB 12
line 728
;728:		verts[0].st[0] = 0;	
ADDRLP4 12+12
CNSTF4 0
ASGNF4
line 729
;729:		verts[0].st[1] = 0;	
ADDRLP4 12+12+4
CNSTF4 0
ASGNF4
line 730
;730:		verts[0].modulate[0] = 255 * color[0];	
ADDRLP4 284
CNSTF4 1132396544
ADDRLP4 184
INDIRF4
MULF4
ASGNF4
ADDRLP4 288
CNSTF4 1325400064
ASGNF4
ADDRLP4 284
INDIRF4
ADDRLP4 288
INDIRF4
LTF4 $706
ADDRLP4 280
ADDRLP4 284
INDIRF4
ADDRLP4 288
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $707
JUMPV
LABELV $706
ADDRLP4 280
ADDRLP4 284
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $707
ADDRLP4 12+20
ADDRLP4 280
INDIRU4
CVUU1 4
ASGNU1
line 731
;731:		verts[0].modulate[1] = 255 * color[1];	
ADDRLP4 296
CNSTF4 1132396544
ADDRLP4 184+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 300
CNSTF4 1325400064
ASGNF4
ADDRLP4 296
INDIRF4
ADDRLP4 300
INDIRF4
LTF4 $712
ADDRLP4 292
ADDRLP4 296
INDIRF4
ADDRLP4 300
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $713
JUMPV
LABELV $712
ADDRLP4 292
ADDRLP4 296
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $713
ADDRLP4 12+20+1
ADDRLP4 292
INDIRU4
CVUU1 4
ASGNU1
line 732
;732:		verts[0].modulate[2] = 255 * color[2];	
ADDRLP4 308
CNSTF4 1132396544
ADDRLP4 184+8
INDIRF4
MULF4
ASGNF4
ADDRLP4 312
CNSTF4 1325400064
ASGNF4
ADDRLP4 308
INDIRF4
ADDRLP4 312
INDIRF4
LTF4 $718
ADDRLP4 304
ADDRLP4 308
INDIRF4
ADDRLP4 312
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $719
JUMPV
LABELV $718
ADDRLP4 304
ADDRLP4 308
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $719
ADDRLP4 12+20+2
ADDRLP4 304
INDIRU4
CVUU1 4
ASGNU1
line 733
;733:		verts[0].modulate[3] = 255 * invratio;	
ADDRLP4 320
CNSTF4 1132396544
ADDRLP4 204
INDIRF4
MULF4
ASGNF4
ADDRLP4 324
CNSTF4 1325400064
ASGNF4
ADDRLP4 320
INDIRF4
ADDRLP4 324
INDIRF4
LTF4 $723
ADDRLP4 316
ADDRLP4 320
INDIRF4
ADDRLP4 324
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $724
JUMPV
LABELV $723
ADDRLP4 316
ADDRLP4 320
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $724
ADDRLP4 12+20+3
ADDRLP4 316
INDIRU4
CVUU1 4
ASGNU1
line 735
;734:
;735:		if (p->rotate)
ADDRFP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRI4
CNSTI4 0
EQI4 $725
line 736
;736:		{
line 737
;737:			VectorMA (org, -height, rup2, point);	
ADDRLP4 328
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 332
ADDRLP4 180
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0
ADDRLP4 328
INDIRP4
INDIRF4
ADDRLP4 220
INDIRF4
ADDRLP4 332
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 328
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 220+4
INDIRF4
ADDRLP4 332
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 220+8
INDIRF4
ADDRLP4 180
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 738
;738:			VectorMA (point, width, rright2, point);	
ADDRLP4 336
ADDRLP4 196
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 208
INDIRF4
ADDRLP4 336
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 208+4
INDIRF4
ADDRLP4 336
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 208+8
INDIRF4
ADDRLP4 196
INDIRF4
MULF4
ADDF4
ASGNF4
line 739
;739:		}
ADDRGP4 $726
JUMPV
LABELV $725
line 741
;740:		else
;741:		{
line 742
;742:			VectorMA (org, -p->height, pvup, point);	
ADDRLP4 328
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 332
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 328
INDIRP4
INDIRF4
ADDRGP4 pvup
INDIRF4
ADDRLP4 332
INDIRP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 328
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 pvup+4
INDIRF4
ADDRLP4 332
INDIRP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 pvup+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 743
;743:			VectorMA (point, p->width, pvright, point);	
ADDRLP4 336
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRGP4 pvright
INDIRF4
ADDRLP4 336
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRGP4 pvright+4
INDIRF4
ADDRLP4 336
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRGP4 pvright+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 744
;744:		}
LABELV $726
line 745
;745:		VectorCopy (point, verts[1].xyz);	
ADDRLP4 12+24
ADDRLP4 0
INDIRB
ASGNB 12
line 746
;746:		verts[1].st[0] = 0;	
ADDRLP4 12+24+12
CNSTF4 0
ASGNF4
line 747
;747:		verts[1].st[1] = 1;	
ADDRLP4 12+24+12+4
CNSTF4 1065353216
ASGNF4
line 748
;748:		verts[1].modulate[0] = 255 * color[0];	
ADDRLP4 332
CNSTF4 1132396544
ADDRLP4 184
INDIRF4
MULF4
ASGNF4
ADDRLP4 336
CNSTF4 1325400064
ASGNF4
ADDRLP4 332
INDIRF4
ADDRLP4 336
INDIRF4
LTF4 $756
ADDRLP4 328
ADDRLP4 332
INDIRF4
ADDRLP4 336
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $757
JUMPV
LABELV $756
ADDRLP4 328
ADDRLP4 332
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $757
ADDRLP4 12+24+20
ADDRLP4 328
INDIRU4
CVUU1 4
ASGNU1
line 749
;749:		verts[1].modulate[1] = 255 * color[1];	
ADDRLP4 344
CNSTF4 1132396544
ADDRLP4 184+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 348
CNSTF4 1325400064
ASGNF4
ADDRLP4 344
INDIRF4
ADDRLP4 348
INDIRF4
LTF4 $763
ADDRLP4 340
ADDRLP4 344
INDIRF4
ADDRLP4 348
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $764
JUMPV
LABELV $763
ADDRLP4 340
ADDRLP4 344
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $764
ADDRLP4 12+24+20+1
ADDRLP4 340
INDIRU4
CVUU1 4
ASGNU1
line 750
;750:		verts[1].modulate[2] = 255 * color[2];	
ADDRLP4 356
CNSTF4 1132396544
ADDRLP4 184+8
INDIRF4
MULF4
ASGNF4
ADDRLP4 360
CNSTF4 1325400064
ASGNF4
ADDRLP4 356
INDIRF4
ADDRLP4 360
INDIRF4
LTF4 $770
ADDRLP4 352
ADDRLP4 356
INDIRF4
ADDRLP4 360
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $771
JUMPV
LABELV $770
ADDRLP4 352
ADDRLP4 356
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $771
ADDRLP4 12+24+20+2
ADDRLP4 352
INDIRU4
CVUU1 4
ASGNU1
line 751
;751:		verts[1].modulate[3] = 255 * invratio;	
ADDRLP4 368
CNSTF4 1132396544
ADDRLP4 204
INDIRF4
MULF4
ASGNF4
ADDRLP4 372
CNSTF4 1325400064
ASGNF4
ADDRLP4 368
INDIRF4
ADDRLP4 372
INDIRF4
LTF4 $776
ADDRLP4 364
ADDRLP4 368
INDIRF4
ADDRLP4 372
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $777
JUMPV
LABELV $776
ADDRLP4 364
ADDRLP4 368
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $777
ADDRLP4 12+24+20+3
ADDRLP4 364
INDIRU4
CVUU1 4
ASGNU1
line 753
;752:
;753:		if (p->rotate)
ADDRFP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRI4
CNSTI4 0
EQI4 $778
line 754
;754:		{
line 755
;755:			VectorMA (org, height, rup2, point);	
ADDRLP4 376
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 376
INDIRP4
INDIRF4
ADDRLP4 220
INDIRF4
ADDRLP4 180
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 376
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 220+4
INDIRF4
ADDRLP4 180
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 220+8
INDIRF4
ADDRLP4 180
INDIRF4
MULF4
ADDF4
ASGNF4
line 756
;756:			VectorMA (point, width, rright2, point);	
ADDRLP4 384
ADDRLP4 196
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 208
INDIRF4
ADDRLP4 384
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 208+4
INDIRF4
ADDRLP4 384
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 208+8
INDIRF4
ADDRLP4 196
INDIRF4
MULF4
ADDF4
ASGNF4
line 757
;757:		}
ADDRGP4 $779
JUMPV
LABELV $778
line 759
;758:		else
;759:		{
line 760
;760:			VectorMA (org, p->height, pvup, point);	
ADDRLP4 376
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 380
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 376
INDIRP4
INDIRF4
ADDRGP4 pvup
INDIRF4
ADDRLP4 380
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 376
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 pvup+4
INDIRF4
ADDRLP4 380
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 pvup+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 761
;761:			VectorMA (point, p->width, pvright, point);	
ADDRLP4 384
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRGP4 pvright
INDIRF4
ADDRLP4 384
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRGP4 pvright+4
INDIRF4
ADDRLP4 384
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRGP4 pvright+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 762
;762:		}
LABELV $779
line 763
;763:		VectorCopy (point, verts[2].xyz);	
ADDRLP4 12+48
ADDRLP4 0
INDIRB
ASGNB 12
line 764
;764:		verts[2].st[0] = 1;	
ADDRLP4 12+48+12
CNSTF4 1065353216
ASGNF4
line 765
;765:		verts[2].st[1] = 1;	
ADDRLP4 12+48+12+4
CNSTF4 1065353216
ASGNF4
line 766
;766:		verts[2].modulate[0] = 255 * color[0];	
ADDRLP4 380
CNSTF4 1132396544
ADDRLP4 184
INDIRF4
MULF4
ASGNF4
ADDRLP4 384
CNSTF4 1325400064
ASGNF4
ADDRLP4 380
INDIRF4
ADDRLP4 384
INDIRF4
LTF4 $809
ADDRLP4 376
ADDRLP4 380
INDIRF4
ADDRLP4 384
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $810
JUMPV
LABELV $809
ADDRLP4 376
ADDRLP4 380
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $810
ADDRLP4 12+48+20
ADDRLP4 376
INDIRU4
CVUU1 4
ASGNU1
line 767
;767:		verts[2].modulate[1] = 255 * color[1];	
ADDRLP4 392
CNSTF4 1132396544
ADDRLP4 184+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 396
CNSTF4 1325400064
ASGNF4
ADDRLP4 392
INDIRF4
ADDRLP4 396
INDIRF4
LTF4 $816
ADDRLP4 388
ADDRLP4 392
INDIRF4
ADDRLP4 396
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $817
JUMPV
LABELV $816
ADDRLP4 388
ADDRLP4 392
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $817
ADDRLP4 12+48+20+1
ADDRLP4 388
INDIRU4
CVUU1 4
ASGNU1
line 768
;768:		verts[2].modulate[2] = 255 * color[2];	
ADDRLP4 404
CNSTF4 1132396544
ADDRLP4 184+8
INDIRF4
MULF4
ASGNF4
ADDRLP4 408
CNSTF4 1325400064
ASGNF4
ADDRLP4 404
INDIRF4
ADDRLP4 408
INDIRF4
LTF4 $823
ADDRLP4 400
ADDRLP4 404
INDIRF4
ADDRLP4 408
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $824
JUMPV
LABELV $823
ADDRLP4 400
ADDRLP4 404
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $824
ADDRLP4 12+48+20+2
ADDRLP4 400
INDIRU4
CVUU1 4
ASGNU1
line 769
;769:		verts[2].modulate[3] = 255 * invratio;	
ADDRLP4 416
CNSTF4 1132396544
ADDRLP4 204
INDIRF4
MULF4
ASGNF4
ADDRLP4 420
CNSTF4 1325400064
ASGNF4
ADDRLP4 416
INDIRF4
ADDRLP4 420
INDIRF4
LTF4 $829
ADDRLP4 412
ADDRLP4 416
INDIRF4
ADDRLP4 420
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $830
JUMPV
LABELV $829
ADDRLP4 412
ADDRLP4 416
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $830
ADDRLP4 12+48+20+3
ADDRLP4 412
INDIRU4
CVUU1 4
ASGNU1
line 771
;770:
;771:		if (p->rotate)
ADDRFP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRI4
CNSTI4 0
EQI4 $831
line 772
;772:		{
line 773
;773:			VectorMA (org, height, rup2, point);	
ADDRLP4 424
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 424
INDIRP4
INDIRF4
ADDRLP4 220
INDIRF4
ADDRLP4 180
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 424
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 220+4
INDIRF4
ADDRLP4 180
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 220+8
INDIRF4
ADDRLP4 180
INDIRF4
MULF4
ADDF4
ASGNF4
line 774
;774:			VectorMA (point, -width, rright2, point);	
ADDRLP4 432
ADDRLP4 196
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 208
INDIRF4
ADDRLP4 432
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 208+4
INDIRF4
ADDRLP4 432
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 208+8
INDIRF4
ADDRLP4 196
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 775
;775:		}
ADDRGP4 $832
JUMPV
LABELV $831
line 777
;776:		else
;777:		{
line 778
;778:			VectorMA (org, p->height, pvup, point);	
ADDRLP4 424
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 428
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 424
INDIRP4
INDIRF4
ADDRGP4 pvup
INDIRF4
ADDRLP4 428
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 424
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 pvup+4
INDIRF4
ADDRLP4 428
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 pvup+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 779
;779:			VectorMA (point, -p->width, pvright, point);	
ADDRLP4 432
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRGP4 pvright
INDIRF4
ADDRLP4 432
INDIRP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRGP4 pvright+4
INDIRF4
ADDRLP4 432
INDIRP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRGP4 pvright+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 780
;780:		}
LABELV $832
line 781
;781:		VectorCopy (point, verts[3].xyz);	
ADDRLP4 12+72
ADDRLP4 0
INDIRB
ASGNB 12
line 782
;782:		verts[3].st[0] = 1;	
ADDRLP4 12+72+12
CNSTF4 1065353216
ASGNF4
line 783
;783:		verts[3].st[1] = 0;	
ADDRLP4 12+72+12+4
CNSTF4 0
ASGNF4
line 784
;784:		verts[3].modulate[0] = 255 * color[0];	
ADDRLP4 428
CNSTF4 1132396544
ADDRLP4 184
INDIRF4
MULF4
ASGNF4
ADDRLP4 432
CNSTF4 1325400064
ASGNF4
ADDRLP4 428
INDIRF4
ADDRLP4 432
INDIRF4
LTF4 $862
ADDRLP4 424
ADDRLP4 428
INDIRF4
ADDRLP4 432
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $863
JUMPV
LABELV $862
ADDRLP4 424
ADDRLP4 428
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $863
ADDRLP4 12+72+20
ADDRLP4 424
INDIRU4
CVUU1 4
ASGNU1
line 785
;785:		verts[3].modulate[1] = 255 * color[1];	
ADDRLP4 440
CNSTF4 1132396544
ADDRLP4 184+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 444
CNSTF4 1325400064
ASGNF4
ADDRLP4 440
INDIRF4
ADDRLP4 444
INDIRF4
LTF4 $869
ADDRLP4 436
ADDRLP4 440
INDIRF4
ADDRLP4 444
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $870
JUMPV
LABELV $869
ADDRLP4 436
ADDRLP4 440
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $870
ADDRLP4 12+72+20+1
ADDRLP4 436
INDIRU4
CVUU1 4
ASGNU1
line 786
;786:		verts[3].modulate[2] = 255 * color[2];	
ADDRLP4 452
CNSTF4 1132396544
ADDRLP4 184+8
INDIRF4
MULF4
ASGNF4
ADDRLP4 456
CNSTF4 1325400064
ASGNF4
ADDRLP4 452
INDIRF4
ADDRLP4 456
INDIRF4
LTF4 $876
ADDRLP4 448
ADDRLP4 452
INDIRF4
ADDRLP4 456
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $877
JUMPV
LABELV $876
ADDRLP4 448
ADDRLP4 452
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $877
ADDRLP4 12+72+20+2
ADDRLP4 448
INDIRU4
CVUU1 4
ASGNU1
line 787
;787:		verts[3].modulate[3] = 255  * invratio;	
ADDRLP4 464
CNSTF4 1132396544
ADDRLP4 204
INDIRF4
MULF4
ASGNF4
ADDRLP4 468
CNSTF4 1325400064
ASGNF4
ADDRLP4 464
INDIRF4
ADDRLP4 468
INDIRF4
LTF4 $882
ADDRLP4 460
ADDRLP4 464
INDIRF4
ADDRLP4 468
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $883
JUMPV
LABELV $882
ADDRLP4 460
ADDRLP4 464
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $883
ADDRLP4 12+72+20+3
ADDRLP4 460
INDIRU4
CVUU1 4
ASGNU1
line 789
;788:		
;789:	}
ADDRGP4 $639
JUMPV
LABELV $638
line 790
;790:	else if (p->type == P_BLEED)
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
CNSTI4 8
NEI4 $884
line 791
;791:	{
line 796
;792:		vec3_t	rr, ru;
;793:		vec3_t	rotate_ang;
;794:		float	alpha;
;795:
;796:		alpha = p->alpha;
ADDRLP4 272
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
INDIRF4
ASGNF4
line 798
;797:		
;798:		if ( cgs.glconfig.hardwareType == GLHW_RAGEPRO )
ADDRGP4 cgs+20100+11288
INDIRI4
CNSTI4 3
NEI4 $886
line 799
;799:			alpha = 1;
ADDRLP4 272
CNSTF4 1065353216
ASGNF4
LABELV $886
line 801
;800:
;801:		if (p->roll) 
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
CNSTI4 0
EQI4 $890
line 802
;802:		{
line 803
;803:			vectoangles( cg.refdef.viewaxis[0], rotate_ang );
ADDRGP4 cg+109048+36
ARGP4
ADDRLP4 276
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 804
;804:			rotate_ang[ROLL] += p->roll;
ADDRLP4 276+8
ADDRLP4 276+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 805
;805:			AngleVectors ( rotate_ang, NULL, rr, ru);
ADDRLP4 276
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 248
ARGP4
ADDRLP4 260
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 806
;806:		}
ADDRGP4 $891
JUMPV
LABELV $890
line 808
;807:		else
;808:		{
line 809
;809:			VectorCopy (pvup, ru);
ADDRLP4 260
ADDRGP4 pvup
INDIRB
ASGNB 12
line 810
;810:			VectorCopy (pvright, rr);
ADDRLP4 248
ADDRGP4 pvright
INDIRB
ASGNB 12
line 811
;811:		}
LABELV $891
line 813
;812:
;813:		VectorMA (org, -p->height, ru, point);	
ADDRLP4 288
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 292
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 288
INDIRP4
INDIRF4
ADDRLP4 260
INDIRF4
ADDRLP4 292
INDIRP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 288
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 260+4
INDIRF4
ADDRLP4 292
INDIRP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 260+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 814
;814:		VectorMA (point, -p->width, rr, point);	
ADDRLP4 296
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 248
INDIRF4
ADDRLP4 296
INDIRP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 248+4
INDIRF4
ADDRLP4 296
INDIRP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 248+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 815
;815:		VectorCopy (point, verts[0].xyz);	
ADDRLP4 12
ADDRLP4 0
INDIRB
ASGNB 12
line 816
;816:		verts[0].st[0] = 0;	
ADDRLP4 12+12
CNSTF4 0
ASGNF4
line 817
;817:		verts[0].st[1] = 0;	
ADDRLP4 12+12+4
CNSTF4 0
ASGNF4
line 818
;818:		verts[0].modulate[0] = 111;	
ADDRLP4 12+20
CNSTU1 111
ASGNU1
line 819
;819:		verts[0].modulate[1] = 19;	
ADDRLP4 12+20+1
CNSTU1 19
ASGNU1
line 820
;820:		verts[0].modulate[2] = 9;	
ADDRLP4 12+20+2
CNSTU1 9
ASGNU1
line 821
;821:		verts[0].modulate[3] = 255 * alpha;	
ADDRLP4 304
CNSTF4 1132396544
ADDRLP4 272
INDIRF4
MULF4
ASGNF4
ADDRLP4 308
CNSTF4 1325400064
ASGNF4
ADDRLP4 304
INDIRF4
ADDRLP4 308
INDIRF4
LTF4 $916
ADDRLP4 300
ADDRLP4 304
INDIRF4
ADDRLP4 308
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $917
JUMPV
LABELV $916
ADDRLP4 300
ADDRLP4 304
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $917
ADDRLP4 12+20+3
ADDRLP4 300
INDIRU4
CVUU1 4
ASGNU1
line 823
;822:
;823:		VectorMA (org, -p->height, ru, point);	
ADDRLP4 312
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 316
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 312
INDIRP4
INDIRF4
ADDRLP4 260
INDIRF4
ADDRLP4 316
INDIRP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 312
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 260+4
INDIRF4
ADDRLP4 316
INDIRP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 260+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 824
;824:		VectorMA (point, p->width, rr, point);	
ADDRLP4 320
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 248
INDIRF4
ADDRLP4 320
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 248+4
INDIRF4
ADDRLP4 320
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 248+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 825
;825:		VectorCopy (point, verts[1].xyz);	
ADDRLP4 12+24
ADDRLP4 0
INDIRB
ASGNB 12
line 826
;826:		verts[1].st[0] = 0;	
ADDRLP4 12+24+12
CNSTF4 0
ASGNF4
line 827
;827:		verts[1].st[1] = 1;	
ADDRLP4 12+24+12+4
CNSTF4 1065353216
ASGNF4
line 828
;828:		verts[1].modulate[0] = 111;	
ADDRLP4 12+24+20
CNSTU1 111
ASGNU1
line 829
;829:		verts[1].modulate[1] = 19;	
ADDRLP4 12+24+20+1
CNSTU1 19
ASGNU1
line 830
;830:		verts[1].modulate[2] = 9;	
ADDRLP4 12+24+20+2
CNSTU1 9
ASGNU1
line 831
;831:		verts[1].modulate[3] = 255 * alpha;	
ADDRLP4 328
CNSTF4 1132396544
ADDRLP4 272
INDIRF4
MULF4
ASGNF4
ADDRLP4 332
CNSTF4 1325400064
ASGNF4
ADDRLP4 328
INDIRF4
ADDRLP4 332
INDIRF4
LTF4 $946
ADDRLP4 324
ADDRLP4 328
INDIRF4
ADDRLP4 332
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $947
JUMPV
LABELV $946
ADDRLP4 324
ADDRLP4 328
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $947
ADDRLP4 12+24+20+3
ADDRLP4 324
INDIRU4
CVUU1 4
ASGNU1
line 833
;832:
;833:		VectorMA (org, p->height, ru, point);	
ADDRLP4 336
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 340
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 336
INDIRP4
INDIRF4
ADDRLP4 260
INDIRF4
ADDRLP4 340
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 336
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 260+4
INDIRF4
ADDRLP4 340
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 260+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 834
;834:		VectorMA (point, p->width, rr, point);	
ADDRLP4 344
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 248
INDIRF4
ADDRLP4 344
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 248+4
INDIRF4
ADDRLP4 344
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 248+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 835
;835:		VectorCopy (point, verts[2].xyz);	
ADDRLP4 12+48
ADDRLP4 0
INDIRB
ASGNB 12
line 836
;836:		verts[2].st[0] = 1;	
ADDRLP4 12+48+12
CNSTF4 1065353216
ASGNF4
line 837
;837:		verts[2].st[1] = 1;	
ADDRLP4 12+48+12+4
CNSTF4 1065353216
ASGNF4
line 838
;838:		verts[2].modulate[0] = 111;	
ADDRLP4 12+48+20
CNSTU1 111
ASGNU1
line 839
;839:		verts[2].modulate[1] = 19;	
ADDRLP4 12+48+20+1
CNSTU1 19
ASGNU1
line 840
;840:		verts[2].modulate[2] = 9;	
ADDRLP4 12+48+20+2
CNSTU1 9
ASGNU1
line 841
;841:		verts[2].modulate[3] = 255 * alpha;	
ADDRLP4 352
CNSTF4 1132396544
ADDRLP4 272
INDIRF4
MULF4
ASGNF4
ADDRLP4 356
CNSTF4 1325400064
ASGNF4
ADDRLP4 352
INDIRF4
ADDRLP4 356
INDIRF4
LTF4 $976
ADDRLP4 348
ADDRLP4 352
INDIRF4
ADDRLP4 356
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $977
JUMPV
LABELV $976
ADDRLP4 348
ADDRLP4 352
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $977
ADDRLP4 12+48+20+3
ADDRLP4 348
INDIRU4
CVUU1 4
ASGNU1
line 843
;842:
;843:		VectorMA (org, p->height, ru, point);	
ADDRLP4 360
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 364
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 360
INDIRP4
INDIRF4
ADDRLP4 260
INDIRF4
ADDRLP4 364
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 360
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 260+4
INDIRF4
ADDRLP4 364
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 260+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 844
;844:		VectorMA (point, -p->width, rr, point);	
ADDRLP4 368
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 248
INDIRF4
ADDRLP4 368
INDIRP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 248+4
INDIRF4
ADDRLP4 368
INDIRP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 248+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 845
;845:		VectorCopy (point, verts[3].xyz);	
ADDRLP4 12+72
ADDRLP4 0
INDIRB
ASGNB 12
line 846
;846:		verts[3].st[0] = 1;	
ADDRLP4 12+72+12
CNSTF4 1065353216
ASGNF4
line 847
;847:		verts[3].st[1] = 0;	
ADDRLP4 12+72+12+4
CNSTF4 0
ASGNF4
line 848
;848:		verts[3].modulate[0] = 111;	
ADDRLP4 12+72+20
CNSTU1 111
ASGNU1
line 849
;849:		verts[3].modulate[1] = 19;	
ADDRLP4 12+72+20+1
CNSTU1 19
ASGNU1
line 850
;850:		verts[3].modulate[2] = 9;	
ADDRLP4 12+72+20+2
CNSTU1 9
ASGNU1
line 851
;851:		verts[3].modulate[3] = 255 * alpha;	
ADDRLP4 376
CNSTF4 1132396544
ADDRLP4 272
INDIRF4
MULF4
ASGNF4
ADDRLP4 380
CNSTF4 1325400064
ASGNF4
ADDRLP4 376
INDIRF4
ADDRLP4 380
INDIRF4
LTF4 $1006
ADDRLP4 372
ADDRLP4 376
INDIRF4
ADDRLP4 380
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1007
JUMPV
LABELV $1006
ADDRLP4 372
ADDRLP4 376
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1007
ADDRLP4 12+72+20+3
ADDRLP4 372
INDIRU4
CVUU1 4
ASGNU1
line 853
;852:
;853:	}
ADDRGP4 $885
JUMPV
LABELV $884
line 854
;854:	else if (p->type == P_FLAT_SCALEUP)
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
CNSTI4 9
NEI4 $1008
line 855
;855:	{
line 859
;856:		float width, height;
;857:		float sinR, cosR;
;858:
;859:		if (p->color == BLOODRED)
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1010
line 860
;860:			VectorSet (color, 1, 1, 1);
ADDRLP4 264
CNSTF4 1065353216
ASGNF4
ADDRLP4 184
ADDRLP4 264
INDIRF4
ASGNF4
ADDRLP4 184+4
ADDRLP4 264
INDIRF4
ASGNF4
ADDRLP4 184+8
CNSTF4 1065353216
ASGNF4
ADDRGP4 $1011
JUMPV
LABELV $1010
line 862
;861:		else
;862:			VectorSet (color, 0.5, 0.5, 0.5);
ADDRLP4 268
CNSTF4 1056964608
ASGNF4
ADDRLP4 184
ADDRLP4 268
INDIRF4
ASGNF4
ADDRLP4 184+4
ADDRLP4 268
INDIRF4
ASGNF4
ADDRLP4 184+8
CNSTF4 1056964608
ASGNF4
LABELV $1011
line 864
;863:		
;864:		time = cg.time - p->time;
ADDRLP4 232
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 865
;865:		time2 = p->endtime - p->time;
ADDRLP4 272
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 236
ADDRLP4 272
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 272
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 866
;866:		ratio = time / time2;
ADDRLP4 200
ADDRLP4 232
INDIRF4
ADDRLP4 236
INDIRF4
DIVF4
ASGNF4
line 868
;867:
;868:		width = p->width + ( ratio * ( p->endwidth - p->width) );
ADDRLP4 276
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 280
ADDRLP4 276
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ASGNF4
ADDRLP4 256
ADDRLP4 280
INDIRF4
ADDRLP4 200
INDIRF4
ADDRLP4 276
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
ADDRLP4 280
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 869
;869:		height = p->height + ( ratio * ( p->endheight - p->height) );
ADDRLP4 284
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 288
ADDRLP4 284
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ASGNF4
ADDRLP4 260
ADDRLP4 288
INDIRF4
ADDRLP4 200
INDIRF4
ADDRLP4 284
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
ADDRLP4 288
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 871
;870:
;871:		if (width > p->endwidth)
ADDRLP4 256
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
LEF4 $1017
line 872
;872:			width = p->endwidth;
ADDRLP4 256
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
ASGNF4
LABELV $1017
line 874
;873:
;874:		if (height > p->endheight)
ADDRLP4 260
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
LEF4 $1019
line 875
;875:			height = p->endheight;
ADDRLP4 260
ADDRFP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
ASGNF4
LABELV $1019
line 877
;876:
;877:		sinR = height * sin(DEG2RAD(p->roll)) * sqrt(2);
CNSTF4 1078530011
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
CVIF4 4
MULF4
CNSTF4 1127481344
DIVF4
ARGF4
ADDRLP4 292
ADDRGP4 sin
CALLF4
ASGNF4
CNSTF4 1073741824
ARGF4
ADDRLP4 296
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 248
ADDRLP4 260
INDIRF4
ADDRLP4 292
INDIRF4
MULF4
ADDRLP4 296
INDIRF4
MULF4
ASGNF4
line 878
;878:		cosR = width * cos(DEG2RAD(p->roll)) * sqrt(2);
CNSTF4 1078530011
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
CVIF4 4
MULF4
CNSTF4 1127481344
DIVF4
ARGF4
ADDRLP4 300
ADDRGP4 cos
CALLF4
ASGNF4
CNSTF4 1073741824
ARGF4
ADDRLP4 304
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 252
ADDRLP4 256
INDIRF4
ADDRLP4 300
INDIRF4
MULF4
ADDRLP4 304
INDIRF4
MULF4
ASGNF4
line 880
;879:
;880:		VectorCopy (org, verts[0].xyz);	
ADDRLP4 12
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 881
;881:		verts[0].xyz[0] -= sinR;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 248
INDIRF4
SUBF4
ASGNF4
line 882
;882:		verts[0].xyz[1] -= cosR;
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 252
INDIRF4
SUBF4
ASGNF4
line 883
;883:		verts[0].st[0] = 0;	
ADDRLP4 12+12
CNSTF4 0
ASGNF4
line 884
;884:		verts[0].st[1] = 0;	
ADDRLP4 12+12+4
CNSTF4 0
ASGNF4
line 885
;885:		verts[0].modulate[0] = 255 * color[0];	
ADDRLP4 312
CNSTF4 1132396544
ADDRLP4 184
INDIRF4
MULF4
ASGNF4
ADDRLP4 316
CNSTF4 1325400064
ASGNF4
ADDRLP4 312
INDIRF4
ADDRLP4 316
INDIRF4
LTF4 $1027
ADDRLP4 308
ADDRLP4 312
INDIRF4
ADDRLP4 316
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1028
JUMPV
LABELV $1027
ADDRLP4 308
ADDRLP4 312
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1028
ADDRLP4 12+20
ADDRLP4 308
INDIRU4
CVUU1 4
ASGNU1
line 886
;886:		verts[0].modulate[1] = 255 * color[1];	
ADDRLP4 324
CNSTF4 1132396544
ADDRLP4 184+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 328
CNSTF4 1325400064
ASGNF4
ADDRLP4 324
INDIRF4
ADDRLP4 328
INDIRF4
LTF4 $1033
ADDRLP4 320
ADDRLP4 324
INDIRF4
ADDRLP4 328
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1034
JUMPV
LABELV $1033
ADDRLP4 320
ADDRLP4 324
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1034
ADDRLP4 12+20+1
ADDRLP4 320
INDIRU4
CVUU1 4
ASGNU1
line 887
;887:		verts[0].modulate[2] = 255 * color[2];	
ADDRLP4 336
CNSTF4 1132396544
ADDRLP4 184+8
INDIRF4
MULF4
ASGNF4
ADDRLP4 340
CNSTF4 1325400064
ASGNF4
ADDRLP4 336
INDIRF4
ADDRLP4 340
INDIRF4
LTF4 $1039
ADDRLP4 332
ADDRLP4 336
INDIRF4
ADDRLP4 340
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1040
JUMPV
LABELV $1039
ADDRLP4 332
ADDRLP4 336
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1040
ADDRLP4 12+20+2
ADDRLP4 332
INDIRU4
CVUU1 4
ASGNU1
line 888
;888:		verts[0].modulate[3] = 255;	
ADDRLP4 12+20+3
CNSTU1 255
ASGNU1
line 890
;889:
;890:		VectorCopy (org, verts[1].xyz);	
ADDRLP4 12+24
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 891
;891:		verts[1].xyz[0] -= cosR;	
ADDRLP4 12+24
ADDRLP4 12+24
INDIRF4
ADDRLP4 252
INDIRF4
SUBF4
ASGNF4
line 892
;892:		verts[1].xyz[1] += sinR;	
ADDRLP4 12+24+4
ADDRLP4 12+24+4
INDIRF4
ADDRLP4 248
INDIRF4
ADDF4
ASGNF4
line 893
;893:		verts[1].st[0] = 0;	
ADDRLP4 12+24+12
CNSTF4 0
ASGNF4
line 894
;894:		verts[1].st[1] = 1;	
ADDRLP4 12+24+12+4
CNSTF4 1065353216
ASGNF4
line 895
;895:		verts[1].modulate[0] = 255 * color[0];	
ADDRLP4 348
CNSTF4 1132396544
ADDRLP4 184
INDIRF4
MULF4
ASGNF4
ADDRLP4 352
CNSTF4 1325400064
ASGNF4
ADDRLP4 348
INDIRF4
ADDRLP4 352
INDIRF4
LTF4 $1055
ADDRLP4 344
ADDRLP4 348
INDIRF4
ADDRLP4 352
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1056
JUMPV
LABELV $1055
ADDRLP4 344
ADDRLP4 348
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1056
ADDRLP4 12+24+20
ADDRLP4 344
INDIRU4
CVUU1 4
ASGNU1
line 896
;896:		verts[1].modulate[1] = 255 * color[1];	
ADDRLP4 360
CNSTF4 1132396544
ADDRLP4 184+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 364
CNSTF4 1325400064
ASGNF4
ADDRLP4 360
INDIRF4
ADDRLP4 364
INDIRF4
LTF4 $1062
ADDRLP4 356
ADDRLP4 360
INDIRF4
ADDRLP4 364
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1063
JUMPV
LABELV $1062
ADDRLP4 356
ADDRLP4 360
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1063
ADDRLP4 12+24+20+1
ADDRLP4 356
INDIRU4
CVUU1 4
ASGNU1
line 897
;897:		verts[1].modulate[2] = 255 * color[2];	
ADDRLP4 372
CNSTF4 1132396544
ADDRLP4 184+8
INDIRF4
MULF4
ASGNF4
ADDRLP4 376
CNSTF4 1325400064
ASGNF4
ADDRLP4 372
INDIRF4
ADDRLP4 376
INDIRF4
LTF4 $1069
ADDRLP4 368
ADDRLP4 372
INDIRF4
ADDRLP4 376
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1070
JUMPV
LABELV $1069
ADDRLP4 368
ADDRLP4 372
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1070
ADDRLP4 12+24+20+2
ADDRLP4 368
INDIRU4
CVUU1 4
ASGNU1
line 898
;898:		verts[1].modulate[3] = 255;	
ADDRLP4 12+24+20+3
CNSTU1 255
ASGNU1
line 900
;899:
;900:		VectorCopy (org, verts[2].xyz);	
ADDRLP4 12+48
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 901
;901:		verts[2].xyz[0] += sinR;	
ADDRLP4 12+48
ADDRLP4 12+48
INDIRF4
ADDRLP4 248
INDIRF4
ADDF4
ASGNF4
line 902
;902:		verts[2].xyz[1] += cosR;	
ADDRLP4 12+48+4
ADDRLP4 12+48+4
INDIRF4
ADDRLP4 252
INDIRF4
ADDF4
ASGNF4
line 903
;903:		verts[2].st[0] = 1;	
ADDRLP4 12+48+12
CNSTF4 1065353216
ASGNF4
line 904
;904:		verts[2].st[1] = 1;	
ADDRLP4 12+48+12+4
CNSTF4 1065353216
ASGNF4
line 905
;905:		verts[2].modulate[0] = 255 * color[0];	
ADDRLP4 384
CNSTF4 1132396544
ADDRLP4 184
INDIRF4
MULF4
ASGNF4
ADDRLP4 388
CNSTF4 1325400064
ASGNF4
ADDRLP4 384
INDIRF4
ADDRLP4 388
INDIRF4
LTF4 $1086
ADDRLP4 380
ADDRLP4 384
INDIRF4
ADDRLP4 388
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1087
JUMPV
LABELV $1086
ADDRLP4 380
ADDRLP4 384
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1087
ADDRLP4 12+48+20
ADDRLP4 380
INDIRU4
CVUU1 4
ASGNU1
line 906
;906:		verts[2].modulate[1] = 255 * color[1];	
ADDRLP4 396
CNSTF4 1132396544
ADDRLP4 184+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 400
CNSTF4 1325400064
ASGNF4
ADDRLP4 396
INDIRF4
ADDRLP4 400
INDIRF4
LTF4 $1093
ADDRLP4 392
ADDRLP4 396
INDIRF4
ADDRLP4 400
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1094
JUMPV
LABELV $1093
ADDRLP4 392
ADDRLP4 396
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1094
ADDRLP4 12+48+20+1
ADDRLP4 392
INDIRU4
CVUU1 4
ASGNU1
line 907
;907:		verts[2].modulate[2] = 255 * color[2];	
ADDRLP4 408
CNSTF4 1132396544
ADDRLP4 184+8
INDIRF4
MULF4
ASGNF4
ADDRLP4 412
CNSTF4 1325400064
ASGNF4
ADDRLP4 408
INDIRF4
ADDRLP4 412
INDIRF4
LTF4 $1100
ADDRLP4 404
ADDRLP4 408
INDIRF4
ADDRLP4 412
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1101
JUMPV
LABELV $1100
ADDRLP4 404
ADDRLP4 408
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1101
ADDRLP4 12+48+20+2
ADDRLP4 404
INDIRU4
CVUU1 4
ASGNU1
line 908
;908:		verts[2].modulate[3] = 255;	
ADDRLP4 12+48+20+3
CNSTU1 255
ASGNU1
line 910
;909:
;910:		VectorCopy (org, verts[3].xyz);	
ADDRLP4 12+72
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 911
;911:		verts[3].xyz[0] += cosR;	
ADDRLP4 12+72
ADDRLP4 12+72
INDIRF4
ADDRLP4 252
INDIRF4
ADDF4
ASGNF4
line 912
;912:		verts[3].xyz[1] -= sinR;	
ADDRLP4 12+72+4
ADDRLP4 12+72+4
INDIRF4
ADDRLP4 248
INDIRF4
SUBF4
ASGNF4
line 913
;913:		verts[3].st[0] = 1;	
ADDRLP4 12+72+12
CNSTF4 1065353216
ASGNF4
line 914
;914:		verts[3].st[1] = 0;	
ADDRLP4 12+72+12+4
CNSTF4 0
ASGNF4
line 915
;915:		verts[3].modulate[0] = 255 * color[0];	
ADDRLP4 420
CNSTF4 1132396544
ADDRLP4 184
INDIRF4
MULF4
ASGNF4
ADDRLP4 424
CNSTF4 1325400064
ASGNF4
ADDRLP4 420
INDIRF4
ADDRLP4 424
INDIRF4
LTF4 $1117
ADDRLP4 416
ADDRLP4 420
INDIRF4
ADDRLP4 424
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1118
JUMPV
LABELV $1117
ADDRLP4 416
ADDRLP4 420
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1118
ADDRLP4 12+72+20
ADDRLP4 416
INDIRU4
CVUU1 4
ASGNU1
line 916
;916:		verts[3].modulate[1] = 255 * color[1];	
ADDRLP4 432
CNSTF4 1132396544
ADDRLP4 184+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 436
CNSTF4 1325400064
ASGNF4
ADDRLP4 432
INDIRF4
ADDRLP4 436
INDIRF4
LTF4 $1124
ADDRLP4 428
ADDRLP4 432
INDIRF4
ADDRLP4 436
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1125
JUMPV
LABELV $1124
ADDRLP4 428
ADDRLP4 432
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1125
ADDRLP4 12+72+20+1
ADDRLP4 428
INDIRU4
CVUU1 4
ASGNU1
line 917
;917:		verts[3].modulate[2] = 255 * color[2];	
ADDRLP4 444
CNSTF4 1132396544
ADDRLP4 184+8
INDIRF4
MULF4
ASGNF4
ADDRLP4 448
CNSTF4 1325400064
ASGNF4
ADDRLP4 444
INDIRF4
ADDRLP4 448
INDIRF4
LTF4 $1131
ADDRLP4 440
ADDRLP4 444
INDIRF4
ADDRLP4 448
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1132
JUMPV
LABELV $1131
ADDRLP4 440
ADDRLP4 444
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1132
ADDRLP4 12+72+20+2
ADDRLP4 440
INDIRU4
CVUU1 4
ASGNU1
line 918
;918:		verts[3].modulate[3] = 255;		
ADDRLP4 12+72+20+3
CNSTU1 255
ASGNU1
line 919
;919:	}
ADDRGP4 $1009
JUMPV
LABELV $1008
line 920
;920:	else if (p->type == P_FLAT)
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1136
line 921
;921:	{
line 923
;922:
;923:		VectorCopy (org, verts[0].xyz);	
ADDRLP4 12
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 924
;924:		verts[0].xyz[0] -= p->height;	
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
SUBF4
ASGNF4
line 925
;925:		verts[0].xyz[1] -= p->width;	
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
SUBF4
ASGNF4
line 926
;926:		verts[0].st[0] = 0;	
ADDRLP4 12+12
CNSTF4 0
ASGNF4
line 927
;927:		verts[0].st[1] = 0;	
ADDRLP4 12+12+4
CNSTF4 0
ASGNF4
line 928
;928:		verts[0].modulate[0] = 255;	
ADDRLP4 12+20
CNSTU1 255
ASGNU1
line 929
;929:		verts[0].modulate[1] = 255;	
ADDRLP4 12+20+1
CNSTU1 255
ASGNU1
line 930
;930:		verts[0].modulate[2] = 255;	
ADDRLP4 12+20+2
CNSTU1 255
ASGNU1
line 931
;931:		verts[0].modulate[3] = 255;	
ADDRLP4 12+20+3
CNSTU1 255
ASGNU1
line 933
;932:
;933:		VectorCopy (org, verts[1].xyz);	
ADDRLP4 12+24
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 934
;934:		verts[1].xyz[0] -= p->height;	
ADDRLP4 12+24
ADDRLP4 12+24
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
SUBF4
ASGNF4
line 935
;935:		verts[1].xyz[1] += p->width;	
ADDRLP4 12+24+4
ADDRLP4 12+24+4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ADDF4
ASGNF4
line 936
;936:		verts[1].st[0] = 0;	
ADDRLP4 12+24+12
CNSTF4 0
ASGNF4
line 937
;937:		verts[1].st[1] = 1;	
ADDRLP4 12+24+12+4
CNSTF4 1065353216
ASGNF4
line 938
;938:		verts[1].modulate[0] = 255;	
ADDRLP4 12+24+20
CNSTU1 255
ASGNU1
line 939
;939:		verts[1].modulate[1] = 255;	
ADDRLP4 12+24+20+1
CNSTU1 255
ASGNU1
line 940
;940:		verts[1].modulate[2] = 255;	
ADDRLP4 12+24+20+2
CNSTU1 255
ASGNU1
line 941
;941:		verts[1].modulate[3] = 255;	
ADDRLP4 12+24+20+3
CNSTU1 255
ASGNU1
line 943
;942:
;943:		VectorCopy (org, verts[2].xyz);	
ADDRLP4 12+48
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 944
;944:		verts[2].xyz[0] += p->height;	
ADDRLP4 12+48
ADDRLP4 12+48
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ADDF4
ASGNF4
line 945
;945:		verts[2].xyz[1] += p->width;	
ADDRLP4 12+48+4
ADDRLP4 12+48+4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ADDF4
ASGNF4
line 946
;946:		verts[2].st[0] = 1;	
ADDRLP4 12+48+12
CNSTF4 1065353216
ASGNF4
line 947
;947:		verts[2].st[1] = 1;	
ADDRLP4 12+48+12+4
CNSTF4 1065353216
ASGNF4
line 948
;948:		verts[2].modulate[0] = 255;	
ADDRLP4 12+48+20
CNSTU1 255
ASGNU1
line 949
;949:		verts[2].modulate[1] = 255;	
ADDRLP4 12+48+20+1
CNSTU1 255
ASGNU1
line 950
;950:		verts[2].modulate[2] = 255;	
ADDRLP4 12+48+20+2
CNSTU1 255
ASGNU1
line 951
;951:		verts[2].modulate[3] = 255;	
ADDRLP4 12+48+20+3
CNSTU1 255
ASGNU1
line 953
;952:
;953:		VectorCopy (org, verts[3].xyz);	
ADDRLP4 12+72
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 954
;954:		verts[3].xyz[0] += p->height;	
ADDRLP4 12+72
ADDRLP4 12+72
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ADDF4
ASGNF4
line 955
;955:		verts[3].xyz[1] -= p->width;	
ADDRLP4 12+72+4
ADDRLP4 12+72+4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
SUBF4
ASGNF4
line 956
;956:		verts[3].st[0] = 1;	
ADDRLP4 12+72+12
CNSTF4 1065353216
ASGNF4
line 957
;957:		verts[3].st[1] = 0;	
ADDRLP4 12+72+12+4
CNSTF4 0
ASGNF4
line 958
;958:		verts[3].modulate[0] = 255;	
ADDRLP4 12+72+20
CNSTU1 255
ASGNU1
line 959
;959:		verts[3].modulate[1] = 255;	
ADDRLP4 12+72+20+1
CNSTU1 255
ASGNU1
line 960
;960:		verts[3].modulate[2] = 255;	
ADDRLP4 12+72+20+2
CNSTU1 255
ASGNU1
line 961
;961:		verts[3].modulate[3] = 255;	
ADDRLP4 12+72+20+3
CNSTU1 255
ASGNU1
line 963
;962:
;963:	}
ADDRGP4 $1137
JUMPV
LABELV $1136
line 965
;964:	// Ridah
;965:	else if (p->type == P_ANIM) {
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
CNSTI4 6
NEI4 $1209
line 970
;966:		vec3_t	rr, ru;
;967:		vec3_t	rotate_ang;
;968:		int i, j;
;969:
;970:		time = cg.time - p->time;
ADDRLP4 232
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 971
;971:		time2 = p->endtime - p->time;
ADDRLP4 292
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 236
ADDRLP4 292
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 292
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 972
;972:		ratio = time / time2;
ADDRLP4 200
ADDRLP4 232
INDIRF4
ADDRLP4 236
INDIRF4
DIVF4
ASGNF4
line 973
;973:		if (ratio >= 1.0f) {
ADDRLP4 200
INDIRF4
CNSTF4 1065353216
LTF4 $1212
line 974
;974:			ratio = 0.9999f;
ADDRLP4 200
CNSTF4 1065351538
ASGNF4
line 975
;975:		}
LABELV $1212
line 977
;976:
;977:		width = p->width + ( ratio * ( p->endwidth - p->width) );
ADDRLP4 296
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 300
ADDRLP4 296
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ASGNF4
ADDRLP4 196
ADDRLP4 300
INDIRF4
ADDRLP4 200
INDIRF4
ADDRLP4 296
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
ADDRLP4 300
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 978
;978:		height = p->height + ( ratio * ( p->endheight - p->height) );
ADDRLP4 304
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 308
ADDRLP4 304
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ASGNF4
ADDRLP4 180
ADDRLP4 308
INDIRF4
ADDRLP4 200
INDIRF4
ADDRLP4 304
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
ADDRLP4 308
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 981
;979:
;980:		// if we are "inside" this sprite, don't draw
;981:		if (Distance( cg.snap->ps.origin, org ) < width/1.5) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 64
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 312
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 312
INDIRF4
ADDRLP4 196
INDIRF4
CNSTF4 1069547520
DIVF4
GEF4 $1214
line 982
;982:			return;
ADDRGP4 $274
JUMPV
LABELV $1214
line 985
;983:		}
;984:
;985:		i = p->shaderAnim;
ADDRLP4 272
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
ASGNI4
line 986
;986:		j = (int)floor(ratio * shaderAnimCounts[p->shaderAnim]);
ADDRLP4 200
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 shaderAnimCounts
ADDP4
INDIRI4
CVIF4 4
MULF4
ARGF4
ADDRLP4 316
ADDRGP4 floor
CALLF4
ASGNF4
ADDRLP4 276
ADDRLP4 316
INDIRF4
CVFI4 4
ASGNI4
line 987
;987:		p->pshader = shaderAnims[i][j];
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 276
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 272
INDIRI4
CNSTI4 8
LSHI4
ADDRGP4 shaderAnims
ADDP4
ADDP4
INDIRI4
ASGNI4
line 989
;988:
;989:		if (p->roll) {
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1217
line 990
;990:			vectoangles( cg.refdef.viewaxis[0], rotate_ang );
ADDRGP4 cg+109048+36
ARGP4
ADDRLP4 280
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 991
;991:			rotate_ang[ROLL] += p->roll;
ADDRLP4 280+8
ADDRLP4 280+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 992
;992:			AngleVectors ( rotate_ang, NULL, rr, ru);
ADDRLP4 280
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 260
ARGP4
ADDRLP4 248
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 993
;993:		}
LABELV $1217
line 995
;994:
;995:		if (p->roll) {
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1222
line 996
;996:			VectorMA (org, -height, ru, point);	
ADDRLP4 320
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 324
ADDRLP4 180
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0
ADDRLP4 320
INDIRP4
INDIRF4
ADDRLP4 248
INDIRF4
ADDRLP4 324
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 320
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 248+4
INDIRF4
ADDRLP4 324
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 248+8
INDIRF4
ADDRLP4 180
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 997
;997:			VectorMA (point, -width, rr, point);	
ADDRLP4 328
ADDRLP4 196
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 260
INDIRF4
ADDRLP4 328
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 260+4
INDIRF4
ADDRLP4 328
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 260+8
INDIRF4
ADDRLP4 196
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 998
;998:		} else {
ADDRGP4 $1223
JUMPV
LABELV $1222
line 999
;999:			VectorMA (org, -height, pvup, point);	
ADDRLP4 320
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 324
ADDRLP4 180
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0
ADDRLP4 320
INDIRP4
INDIRF4
ADDRGP4 pvup
INDIRF4
ADDRLP4 324
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 320
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 pvup+4
INDIRF4
ADDRLP4 324
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 pvup+8
INDIRF4
ADDRLP4 180
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 1000
;1000:			VectorMA (point, -width, pvright, point);	
ADDRLP4 328
ADDRLP4 196
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRGP4 pvright
INDIRF4
ADDRLP4 328
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRGP4 pvright+4
INDIRF4
ADDRLP4 328
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRGP4 pvright+8
INDIRF4
ADDRLP4 196
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 1001
;1001:		}
LABELV $1223
line 1002
;1002:		VectorCopy (point, verts[0].xyz);	
ADDRLP4 12
ADDRLP4 0
INDIRB
ASGNB 12
line 1003
;1003:		verts[0].st[0] = 0;	
ADDRLP4 12+12
CNSTF4 0
ASGNF4
line 1004
;1004:		verts[0].st[1] = 0;	
ADDRLP4 12+12+4
CNSTF4 0
ASGNF4
line 1005
;1005:		verts[0].modulate[0] = 255;	
ADDRLP4 12+20
CNSTU1 255
ASGNU1
line 1006
;1006:		verts[0].modulate[1] = 255;	
ADDRLP4 12+20+1
CNSTU1 255
ASGNU1
line 1007
;1007:		verts[0].modulate[2] = 255;	
ADDRLP4 12+20+2
CNSTU1 255
ASGNU1
line 1008
;1008:		verts[0].modulate[3] = 255;
ADDRLP4 12+20+3
CNSTU1 255
ASGNU1
line 1010
;1009:
;1010:		if (p->roll) {
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1254
line 1011
;1011:			VectorMA (point, 2*height, ru, point);	
ADDRLP4 320
CNSTF4 1073741824
ADDRLP4 180
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 248
INDIRF4
ADDRLP4 320
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 248+4
INDIRF4
ADDRLP4 320
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 248+8
INDIRF4
CNSTF4 1073741824
ADDRLP4 180
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 1012
;1012:		} else {
ADDRGP4 $1255
JUMPV
LABELV $1254
line 1013
;1013:			VectorMA (point, 2*height, pvup, point);	
ADDRLP4 320
CNSTF4 1073741824
ADDRLP4 180
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRGP4 pvup
INDIRF4
ADDRLP4 320
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRGP4 pvup+4
INDIRF4
ADDRLP4 320
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRGP4 pvup+8
INDIRF4
CNSTF4 1073741824
ADDRLP4 180
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 1014
;1014:		}
LABELV $1255
line 1015
;1015:		VectorCopy (point, verts[1].xyz);	
ADDRLP4 12+24
ADDRLP4 0
INDIRB
ASGNB 12
line 1016
;1016:		verts[1].st[0] = 0;	
ADDRLP4 12+24+12
CNSTF4 0
ASGNF4
line 1017
;1017:		verts[1].st[1] = 1;	
ADDRLP4 12+24+12+4
CNSTF4 1065353216
ASGNF4
line 1018
;1018:		verts[1].modulate[0] = 255;	
ADDRLP4 12+24+20
CNSTU1 255
ASGNU1
line 1019
;1019:		verts[1].modulate[1] = 255;	
ADDRLP4 12+24+20+1
CNSTU1 255
ASGNU1
line 1020
;1020:		verts[1].modulate[2] = 255;	
ADDRLP4 12+24+20+2
CNSTU1 255
ASGNU1
line 1021
;1021:		verts[1].modulate[3] = 255;	
ADDRLP4 12+24+20+3
CNSTU1 255
ASGNU1
line 1023
;1022:
;1023:		if (p->roll) {
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1285
line 1024
;1024:			VectorMA (point, 2*width, rr, point);	
ADDRLP4 320
CNSTF4 1073741824
ADDRLP4 196
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 260
INDIRF4
ADDRLP4 320
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 260+4
INDIRF4
ADDRLP4 320
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 260+8
INDIRF4
CNSTF4 1073741824
ADDRLP4 196
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 1025
;1025:		} else {
ADDRGP4 $1286
JUMPV
LABELV $1285
line 1026
;1026:			VectorMA (point, 2*width, pvright, point);	
ADDRLP4 320
CNSTF4 1073741824
ADDRLP4 196
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRGP4 pvright
INDIRF4
ADDRLP4 320
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRGP4 pvright+4
INDIRF4
ADDRLP4 320
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRGP4 pvright+8
INDIRF4
CNSTF4 1073741824
ADDRLP4 196
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 1027
;1027:		}
LABELV $1286
line 1028
;1028:		VectorCopy (point, verts[2].xyz);	
ADDRLP4 12+48
ADDRLP4 0
INDIRB
ASGNB 12
line 1029
;1029:		verts[2].st[0] = 1;	
ADDRLP4 12+48+12
CNSTF4 1065353216
ASGNF4
line 1030
;1030:		verts[2].st[1] = 1;	
ADDRLP4 12+48+12+4
CNSTF4 1065353216
ASGNF4
line 1031
;1031:		verts[2].modulate[0] = 255;	
ADDRLP4 12+48+20
CNSTU1 255
ASGNU1
line 1032
;1032:		verts[2].modulate[1] = 255;	
ADDRLP4 12+48+20+1
CNSTU1 255
ASGNU1
line 1033
;1033:		verts[2].modulate[2] = 255;	
ADDRLP4 12+48+20+2
CNSTU1 255
ASGNU1
line 1034
;1034:		verts[2].modulate[3] = 255;	
ADDRLP4 12+48+20+3
CNSTU1 255
ASGNU1
line 1036
;1035:
;1036:		if (p->roll) {
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1316
line 1037
;1037:			VectorMA (point, -2*height, ru, point);	
ADDRLP4 320
CNSTF4 3221225472
ADDRLP4 180
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 248
INDIRF4
ADDRLP4 320
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 248+4
INDIRF4
ADDRLP4 320
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 248+8
INDIRF4
CNSTF4 3221225472
ADDRLP4 180
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 1038
;1038:		} else {
ADDRGP4 $1317
JUMPV
LABELV $1316
line 1039
;1039:			VectorMA (point, -2*height, pvup, point);	
ADDRLP4 320
CNSTF4 3221225472
ADDRLP4 180
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRGP4 pvup
INDIRF4
ADDRLP4 320
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRGP4 pvup+4
INDIRF4
ADDRLP4 320
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRGP4 pvup+8
INDIRF4
CNSTF4 3221225472
ADDRLP4 180
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 1040
;1040:		}
LABELV $1317
line 1041
;1041:		VectorCopy (point, verts[3].xyz);	
ADDRLP4 12+72
ADDRLP4 0
INDIRB
ASGNB 12
line 1042
;1042:		verts[3].st[0] = 1;	
ADDRLP4 12+72+12
CNSTF4 1065353216
ASGNF4
line 1043
;1043:		verts[3].st[1] = 0;	
ADDRLP4 12+72+12+4
CNSTF4 0
ASGNF4
line 1044
;1044:		verts[3].modulate[0] = 255;	
ADDRLP4 12+72+20
CNSTU1 255
ASGNU1
line 1045
;1045:		verts[3].modulate[1] = 255;	
ADDRLP4 12+72+20+1
CNSTU1 255
ASGNU1
line 1046
;1046:		verts[3].modulate[2] = 255;	
ADDRLP4 12+72+20+2
CNSTU1 255
ASGNU1
line 1047
;1047:		verts[3].modulate[3] = 255;	
ADDRLP4 12+72+20+3
CNSTU1 255
ASGNU1
line 1048
;1048:	}
LABELV $1209
LABELV $1137
LABELV $1009
LABELV $885
LABELV $639
LABELV $504
LABELV $276
line 1051
;1049:	// done.
;1050:	
;1051:	if (!p->pshader) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1347
line 1054
;1052:// (SA) temp commented out for DM
;1053://		CG_Printf ("CG_AddParticleToScene type %d p->pshader == ZERO\n", p->type);
;1054:		return;
ADDRGP4 $274
JUMPV
LABELV $1347
line 1057
;1055:	}
;1056:
;1057:	if (p->type == P_WEATHER || p->type == P_WEATHER_TURBULENT || p->type == P_WEATHER_FLURRY)
ADDRLP4 248
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ASGNI4
ADDRLP4 248
INDIRI4
CNSTI4 1
EQI4 $1352
ADDRLP4 248
INDIRI4
CNSTI4 5
EQI4 $1352
ADDRLP4 248
INDIRI4
CNSTI4 11
NEI4 $1349
LABELV $1352
line 1058
;1058:		trap_R_AddPolyToScene( p->pshader, 3, TRIverts );
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 108
ARGP4
ADDRGP4 trap_R_AddPolyToScene
CALLV
pop
ADDRGP4 $1350
JUMPV
LABELV $1349
line 1060
;1059:	else
;1060:		trap_R_AddPolyToScene( p->pshader, 4, verts );
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRLP4 12
ARGP4
ADDRGP4 trap_R_AddPolyToScene
CALLV
pop
LABELV $1350
line 1062
;1061:
;1062:}
LABELV $274
endproc CG_AddParticleToScene 472 16
data
align 4
LABELV roll
byte 4 0
export CG_AddParticles
code
proc CG_AddParticles 96 16
line 1073
;1063:
;1064:// Ridah, made this static so it doesn't interfere with other files
;1065:static float roll = 0.0;
;1066:
;1067:/*
;1068:===============
;1069:CG_AddParticles
;1070:===============
;1071:*/
;1072:void CG_AddParticles (void)
;1073:{
line 1083
;1074:	cparticle_t		*p, *next;
;1075:	float			alpha;
;1076:	float			time, time2;
;1077:	vec3_t			org;
;1078:	int				color;
;1079:	cparticle_t		*active, *tail;
;1080:	int				type;
;1081:	vec3_t			rotate_ang;
;1082:
;1083:	if (!initparticles)
ADDRGP4 initparticles
INDIRI4
CNSTI4 0
NEI4 $1354
line 1084
;1084:		CG_ClearParticles ();
ADDRGP4 CG_ClearParticles
CALLV
pop
LABELV $1354
line 1086
;1085:
;1086:	VectorCopy( cg.refdef.viewaxis[0], pvforward );
ADDRGP4 pvforward
ADDRGP4 cg+109048+36
INDIRB
ASGNB 12
line 1087
;1087:	VectorCopy( cg.refdef.viewaxis[1], pvright );
ADDRGP4 pvright
ADDRGP4 cg+109048+36+12
INDIRB
ASGNB 12
line 1088
;1088:	VectorCopy( cg.refdef.viewaxis[2], pvup );
ADDRGP4 pvup
ADDRGP4 cg+109048+36+24
INDIRB
ASGNB 12
line 1090
;1089:
;1090:	vectoangles( cg.refdef.viewaxis[0], rotate_ang );
ADDRGP4 cg+109048+36
ARGP4
ADDRLP4 48
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 1091
;1091:	roll += ((cg.time - oldtime) * 0.1) ;
ADDRLP4 60
ADDRGP4 roll
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
CNSTF4 1036831949
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ADDRGP4 oldtime
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 1092
;1092:	rotate_ang[ROLL] += (roll*0.9);
ADDRLP4 48+8
ADDRLP4 48+8
INDIRF4
CNSTF4 1063675494
ADDRGP4 roll
INDIRF4
MULF4
ADDF4
ASGNF4
line 1093
;1093:	AngleVectors ( rotate_ang, rforward, rright, rup);
ADDRLP4 48
ARGP4
ADDRGP4 rforward
ARGP4
ADDRGP4 rright
ARGP4
ADDRGP4 rup
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 1095
;1094:	
;1095:	oldtime = cg.time;
ADDRGP4 oldtime
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ASGNF4
line 1097
;1096:
;1097:	active = NULL;
ADDRLP4 44
CNSTP4 0
ASGNP4
line 1098
;1098:	tail = NULL;
ADDRLP4 28
CNSTP4 0
ASGNP4
line 1100
;1099:
;1100:	for (p=active_particles ; p ; p=next)
ADDRLP4 0
ADDRGP4 active_particles
INDIRP4
ASGNP4
ADDRGP4 $1372
JUMPV
LABELV $1369
line 1101
;1101:	{
line 1103
;1102:
;1103:		next = p->next;
ADDRLP4 32
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 1105
;1104:
;1105:		time = (cg.time - p->time)*0.001;
ADDRLP4 4
CNSTF4 981668463
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
MULF4
ASGNF4
line 1107
;1106:
;1107:		alpha = p->alpha + time*p->alphavel;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1108
;1108:		if (alpha <= 0)
ADDRLP4 8
INDIRF4
CNSTF4 0
GTF4 $1374
line 1109
;1109:		{	// faded out
line 1110
;1110:			p->next = free_particles;
ADDRLP4 0
INDIRP4
ADDRGP4 free_particles
INDIRP4
ASGNP4
line 1111
;1111:			free_particles = p;
ADDRGP4 free_particles
ADDRLP4 0
INDIRP4
ASGNP4
line 1112
;1112:			p->type = 0;
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 0
ASGNI4
line 1113
;1113:			p->color = 0;
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 1114
;1114:			p->alpha = 0;
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 0
ASGNF4
line 1115
;1115:			continue;
ADDRGP4 $1370
JUMPV
LABELV $1374
line 1118
;1116:		}
;1117:
;1118:		if (p->type == P_SMOKE || p->type == P_ANIM || p->type == P_BLEED || p->type == P_SMOKE_IMPACT)
ADDRLP4 68
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 3
EQI4 $1380
ADDRLP4 68
INDIRI4
CNSTI4 6
EQI4 $1380
ADDRLP4 68
INDIRI4
CNSTI4 8
EQI4 $1380
ADDRLP4 68
INDIRI4
CNSTI4 12
NEI4 $1376
LABELV $1380
line 1119
;1119:		{
line 1120
;1120:			if (cg.time > p->endtime)
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
LEF4 $1381
line 1121
;1121:			{
line 1122
;1122:				p->next = free_particles;
ADDRLP4 0
INDIRP4
ADDRGP4 free_particles
INDIRP4
ASGNP4
line 1123
;1123:				free_particles = p;
ADDRGP4 free_particles
ADDRLP4 0
INDIRP4
ASGNP4
line 1124
;1124:				p->type = 0;
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 0
ASGNI4
line 1125
;1125:				p->color = 0;
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 1126
;1126:				p->alpha = 0;
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 0
ASGNF4
line 1128
;1127:			
;1128:				continue;
ADDRGP4 $1370
JUMPV
LABELV $1381
line 1131
;1129:			}
;1130:
;1131:		}
LABELV $1376
line 1133
;1132:
;1133:		if (p->type == P_WEATHER_FLURRY)
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
CNSTI4 11
NEI4 $1384
line 1134
;1134:		{
line 1135
;1135:			if (cg.time > p->endtime)
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
LEF4 $1386
line 1136
;1136:			{
line 1137
;1137:				p->next = free_particles;
ADDRLP4 0
INDIRP4
ADDRGP4 free_particles
INDIRP4
ASGNP4
line 1138
;1138:				free_particles = p;
ADDRGP4 free_particles
ADDRLP4 0
INDIRP4
ASGNP4
line 1139
;1139:				p->type = 0;
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 0
ASGNI4
line 1140
;1140:				p->color = 0;
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 1141
;1141:				p->alpha = 0;
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 0
ASGNF4
line 1143
;1142:			
;1143:				continue;
ADDRGP4 $1370
JUMPV
LABELV $1386
line 1145
;1144:			}
;1145:		}
LABELV $1384
line 1148
;1146:
;1147:
;1148:		if (p->type == P_FLAT_SCALEUP_FADE)
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
CNSTI4 10
NEI4 $1389
line 1149
;1149:		{
line 1150
;1150:			if (cg.time > p->endtime)
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
LEF4 $1391
line 1151
;1151:			{
line 1152
;1152:				p->next = free_particles;
ADDRLP4 0
INDIRP4
ADDRGP4 free_particles
INDIRP4
ASGNP4
line 1153
;1153:				free_particles = p;
ADDRGP4 free_particles
ADDRLP4 0
INDIRP4
ASGNP4
line 1154
;1154:				p->type = 0;
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 0
ASGNI4
line 1155
;1155:				p->color = 0;
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 1156
;1156:				p->alpha = 0;
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 0
ASGNF4
line 1157
;1157:				continue;
ADDRGP4 $1370
JUMPV
LABELV $1391
line 1160
;1158:			}
;1159:
;1160:		}
LABELV $1389
line 1162
;1161:
;1162:		if ((p->type == P_BAT || p->type == P_SPRITE) && p->endtime < 0) {
ADDRLP4 72
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 7
EQI4 $1396
ADDRLP4 72
INDIRI4
CNSTI4 15
NEI4 $1394
LABELV $1396
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 0
GEF4 $1394
line 1164
;1163:			// temporary sprite
;1164:			CG_AddParticleToScene (p, p->org, alpha);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 8
INDIRF4
ARGF4
ADDRGP4 CG_AddParticleToScene
CALLV
pop
line 1165
;1165:			p->next = free_particles;
ADDRLP4 0
INDIRP4
ADDRGP4 free_particles
INDIRP4
ASGNP4
line 1166
;1166:			free_particles = p;
ADDRGP4 free_particles
ADDRLP4 0
INDIRP4
ASGNP4
line 1167
;1167:			p->type = 0;
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 0
ASGNI4
line 1168
;1168:			p->color = 0;
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 1169
;1169:			p->alpha = 0;
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 0
ASGNF4
line 1170
;1170:			continue;
ADDRGP4 $1370
JUMPV
LABELV $1394
line 1173
;1171:		}
;1172:
;1173:		p->next = NULL;
ADDRLP4 0
INDIRP4
CNSTP4 0
ASGNP4
line 1174
;1174:		if (!tail)
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1397
line 1175
;1175:			active = tail = p;
ADDRLP4 28
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 44
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 $1398
JUMPV
LABELV $1397
line 1177
;1176:		else
;1177:		{
line 1178
;1178:			tail->next = p;
ADDRLP4 28
INDIRP4
ADDRLP4 0
INDIRP4
ASGNP4
line 1179
;1179:			tail = p;
ADDRLP4 28
ADDRLP4 0
INDIRP4
ASGNP4
line 1180
;1180:		}
LABELV $1398
line 1182
;1181:
;1182:		if (alpha > 1.0)
ADDRLP4 8
INDIRF4
CNSTF4 1065353216
LEF4 $1399
line 1183
;1183:			alpha = 1;
ADDRLP4 8
CNSTF4 1065353216
ASGNF4
LABELV $1399
line 1185
;1184:
;1185:		color = p->color;
ADDRLP4 36
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
ASGNI4
line 1187
;1186:
;1187:		time2 = time*time;
ADDRLP4 12
ADDRLP4 4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 1189
;1188:
;1189:		org[0] = p->org[0] + p->vel[0]*time + p->accel[0]*time2;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ADDF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
line 1190
;1190:		org[1] = p->org[1] + p->vel[1]*time + p->accel[1]*time2;
ADDRLP4 16+4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ADDF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
line 1191
;1191:		org[2] = p->org[2] + p->vel[2]*time + p->accel[2]*time2;
ADDRLP4 16+8
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ADDF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
line 1193
;1192:
;1193:		type = p->type;
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ASGNI4
line 1195
;1194:
;1195:		CG_AddParticleToScene (p, org, alpha);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 8
INDIRF4
ARGF4
ADDRGP4 CG_AddParticleToScene
CALLV
pop
line 1196
;1196:	}
LABELV $1370
line 1100
ADDRLP4 0
ADDRLP4 32
INDIRP4
ASGNP4
LABELV $1372
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1369
line 1198
;1197:
;1198:	active_particles = active;
ADDRGP4 active_particles
ADDRLP4 44
INDIRP4
ASGNP4
line 1199
;1199:}
LABELV $1353
endproc CG_AddParticles 96 16
export CG_ParticleSnowFlurry
proc CG_ParticleSnowFlurry 68 4
line 1207
;1200:
;1201:/*
;1202:======================
;1203:CG_AddParticles
;1204:======================
;1205:*/
;1206:void CG_ParticleSnowFlurry (qhandle_t pshader, centity_t *cent)
;1207:{
line 1209
;1208:	cparticle_t	*p;
;1209:	qboolean turb = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 1211
;1210:
;1211:	if (!pshader)
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $1404
line 1212
;1212:		CG_Printf ("CG_ParticleSnowFlurry pshader == ZERO!\n");
ADDRGP4 $1406
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1404
line 1214
;1213:
;1214:	if (!free_particles)
ADDRGP4 free_particles
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1407
line 1215
;1215:		return;
ADDRGP4 $1403
JUMPV
LABELV $1407
line 1216
;1216:	p = free_particles;
ADDRLP4 0
ADDRGP4 free_particles
INDIRP4
ASGNP4
line 1217
;1217:	free_particles = p->next;
ADDRGP4 free_particles
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 1218
;1218:	p->next = active_particles;
ADDRLP4 0
INDIRP4
ADDRGP4 active_particles
INDIRP4
ASGNP4
line 1219
;1219:	active_particles = p;
ADDRGP4 active_particles
ADDRLP4 0
INDIRP4
ASGNP4
line 1220
;1220:	p->time = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ASGNF4
line 1221
;1221:	p->color = 0;
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 1222
;1222:	p->alpha = 0.90f;
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 1063675494
ASGNF4
line 1223
;1223:	p->alphavel = 0;
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 0
ASGNF4
line 1225
;1224:
;1225:	p->start = cent->currentState.origin2[0];
ADDRLP4 0
INDIRP4
CNSTI4 88
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 104
ADDP4
INDIRF4
ASGNF4
line 1226
;1226:	p->end = cent->currentState.origin2[1];
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 108
ADDP4
INDIRF4
ASGNF4
line 1228
;1227:	
;1228:	p->endtime = cg.time + cent->currentState.time;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ADDI4
CVIF4 4
ASGNF4
line 1229
;1229:	p->startfade = cg.time + cent->currentState.time2;
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
ADDI4
CVIF4 4
ASGNF4
line 1231
;1230:	
;1231:	p->pshader = pshader;
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 1233
;1232:	
;1233:	if (rand()%100 > 90)
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 100
MODI4
CNSTI4 90
LEI4 $1412
line 1234
;1234:	{
line 1235
;1235:		p->height = 32;
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
CNSTF4 1107296256
ASGNF4
line 1236
;1236:		p->width = 32;
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
CNSTF4 1107296256
ASGNF4
line 1237
;1237:		p->alpha = 0.10f;
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 1036831949
ASGNF4
line 1238
;1238:	}
ADDRGP4 $1413
JUMPV
LABELV $1412
line 1240
;1239:	else
;1240:	{
line 1241
;1241:		p->height = 1;
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
CNSTF4 1065353216
ASGNF4
line 1242
;1242:		p->width = 1;
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
CNSTF4 1065353216
ASGNF4
line 1243
;1243:	}
LABELV $1413
line 1245
;1244:
;1245:	p->vel[2] = -20;
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 3248488448
ASGNF4
line 1247
;1246:
;1247:	p->type = P_WEATHER_FLURRY;
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 11
ASGNI4
line 1249
;1248:	
;1249:	if (turb)
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $1414
line 1250
;1250:		p->vel[2] = -10;
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 3240099840
ASGNF4
LABELV $1414
line 1252
;1251:	
;1252:	VectorCopy(cent->currentState.origin, p->org);
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 1254
;1253:
;1254:	p->org[0] = p->org[0];
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ASGNF4
line 1255
;1255:	p->org[1] = p->org[1];
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
ASGNF4
line 1256
;1256:	p->org[2] = p->org[2];
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
ASGNF4
line 1258
;1257:
;1258:	p->vel[0] = p->vel[1] = 0;
ADDRLP4 28
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 28
INDIRF4
ASGNF4
line 1260
;1259:	
;1260:	p->accel[0] = p->accel[1] = p->accel[2] = 0;
ADDRLP4 36
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 36
INDIRF4
ASGNF4
line 1262
;1261:
;1262:	p->vel[0] += cent->currentState.angles[0] * 32 + (crandom() * 16);
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 44
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
CNSTF4 1107296256
ADDRFP4 4
INDIRP4
CNSTI4 116
ADDP4
INDIRF4
MULF4
CNSTF4 1098907648
CNSTF4 1073741824
ADDRLP4 40
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
ADDF4
ASGNF4
line 1263
;1263:	p->vel[1] += cent->currentState.angles[1] * 32 + (crandom() * 16);
ADDRLP4 48
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 52
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRF4
CNSTF4 1107296256
ADDRFP4 4
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
MULF4
CNSTF4 1098907648
CNSTF4 1073741824
ADDRLP4 48
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
ADDF4
ASGNF4
line 1264
;1264:	p->vel[2] += cent->currentState.angles[2];
ADDRLP4 56
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1266
;1265:
;1266:	if (turb)
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $1416
line 1267
;1267:	{
line 1268
;1268:		p->accel[0] = crandom () * 16;
ADDRLP4 60
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1098907648
CNSTF4 1073741824
ADDRLP4 60
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
ASGNF4
line 1269
;1269:		p->accel[1] = crandom () * 16;
ADDRLP4 64
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1098907648
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
ASGNF4
line 1270
;1270:	}
LABELV $1416
line 1272
;1271:
;1272:}
LABELV $1403
endproc CG_ParticleSnowFlurry 68 4
export CG_ParticleSnow
proc CG_ParticleSnow 56 4
line 1275
;1273:
;1274:void CG_ParticleSnow (qhandle_t pshader, vec3_t origin, vec3_t origin2, int turb, float range, int snum)
;1275:{
line 1278
;1276:	cparticle_t	*p;
;1277:
;1278:	if (!pshader)
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $1419
line 1279
;1279:		CG_Printf ("CG_ParticleSnow pshader == ZERO!\n");
ADDRGP4 $1421
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1419
line 1281
;1280:
;1281:	if (!free_particles)
ADDRGP4 free_particles
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1422
line 1282
;1282:		return;
ADDRGP4 $1418
JUMPV
LABELV $1422
line 1283
;1283:	p = free_particles;
ADDRLP4 0
ADDRGP4 free_particles
INDIRP4
ASGNP4
line 1284
;1284:	free_particles = p->next;
ADDRGP4 free_particles
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 1285
;1285:	p->next = active_particles;
ADDRLP4 0
INDIRP4
ADDRGP4 active_particles
INDIRP4
ASGNP4
line 1286
;1286:	active_particles = p;
ADDRGP4 active_particles
ADDRLP4 0
INDIRP4
ASGNP4
line 1287
;1287:	p->time = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ASGNF4
line 1288
;1288:	p->color = 0;
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 1289
;1289:	p->alpha = 0.40f;
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 1053609165
ASGNF4
line 1290
;1290:	p->alphavel = 0;
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 0
ASGNF4
line 1291
;1291:	p->start = origin[2];
ADDRLP4 0
INDIRP4
CNSTI4 88
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
line 1292
;1292:	p->end = origin2[2];
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
line 1293
;1293:	p->pshader = pshader;
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 1294
;1294:	p->height = 1;
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
CNSTF4 1065353216
ASGNF4
line 1295
;1295:	p->width = 1;
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
CNSTF4 1065353216
ASGNF4
line 1297
;1296:	
;1297:	p->vel[2] = -50;
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 3259498496
ASGNF4
line 1299
;1298:
;1299:	if (turb)
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $1425
line 1300
;1300:	{
line 1301
;1301:		p->type = P_WEATHER_TURBULENT;
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 5
ASGNI4
line 1302
;1302:		p->vel[2] = -50 * 1.3;
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 3263299584
ASGNF4
line 1303
;1303:	}
ADDRGP4 $1426
JUMPV
LABELV $1425
line 1305
;1304:	else
;1305:	{
line 1306
;1306:		p->type = P_WEATHER;
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 1
ASGNI4
line 1307
;1307:	}
LABELV $1426
line 1309
;1308:	
;1309:	VectorCopy(origin, p->org);
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 1311
;1310:
;1311:	p->org[0] = p->org[0] + ( crandom() * range);
ADDRLP4 4
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
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
ADDRFP4 16
INDIRF4
MULF4
ADDF4
ASGNF4
line 1312
;1312:	p->org[1] = p->org[1] + ( crandom() * range);
ADDRLP4 12
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
CNSTF4 1073741824
ADDRLP4 12
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
ADDRFP4 16
INDIRF4
MULF4
ADDF4
ASGNF4
line 1313
;1313:	p->org[2] = p->org[2] + ( crandom() * (p->start - p->end)); 
ADDRLP4 20
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
CNSTF4 1073741824
ADDRLP4 20
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
ADDRLP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 1315
;1314:
;1315:	p->vel[0] = p->vel[1] = 0;
ADDRLP4 36
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 36
INDIRF4
ASGNF4
line 1317
;1316:	
;1317:	p->accel[0] = p->accel[1] = p->accel[2] = 0;
ADDRLP4 44
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 44
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 44
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 44
INDIRF4
ASGNF4
line 1319
;1318:
;1319:	if (turb)
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $1427
line 1320
;1320:	{
line 1321
;1321:		p->vel[0] = crandom() * 16;
ADDRLP4 48
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 1098907648
CNSTF4 1073741824
ADDRLP4 48
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
ASGNF4
line 1322
;1322:		p->vel[1] = crandom() * 16;
ADDRLP4 52
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1098907648
CNSTF4 1073741824
ADDRLP4 52
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
ASGNF4
line 1323
;1323:	}
LABELV $1427
line 1326
;1324:
;1325:	// Rafael snow pvs check
;1326:	p->snum = snum;
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDRFP4 20
INDIRI4
ASGNI4
line 1327
;1327:	p->link = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
CNSTI4 1
ASGNI4
line 1329
;1328:
;1329:}
LABELV $1418
endproc CG_ParticleSnow 56 4
export CG_ParticleBubble
proc CG_ParticleBubble 68 4
line 1332
;1330:
;1331:void CG_ParticleBubble (qhandle_t pshader, vec3_t origin, vec3_t origin2, int turb, float range, int snum)
;1332:{
line 1336
;1333:	cparticle_t	*p;
;1334:	float		randsize;
;1335:
;1336:	if (!pshader)
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $1430
line 1337
;1337:		CG_Printf ("CG_ParticleSnow pshader == ZERO!\n");
ADDRGP4 $1421
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1430
line 1339
;1338:
;1339:	if (!free_particles)
ADDRGP4 free_particles
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1432
line 1340
;1340:		return;
ADDRGP4 $1429
JUMPV
LABELV $1432
line 1341
;1341:	p = free_particles;
ADDRLP4 0
ADDRGP4 free_particles
INDIRP4
ASGNP4
line 1342
;1342:	free_particles = p->next;
ADDRGP4 free_particles
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 1343
;1343:	p->next = active_particles;
ADDRLP4 0
INDIRP4
ADDRGP4 active_particles
INDIRP4
ASGNP4
line 1344
;1344:	active_particles = p;
ADDRGP4 active_particles
ADDRLP4 0
INDIRP4
ASGNP4
line 1345
;1345:	p->time = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ASGNF4
line 1346
;1346:	p->color = 0;
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 1347
;1347:	p->alpha = 0.40f;
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 1053609165
ASGNF4
line 1348
;1348:	p->alphavel = 0;
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 0
ASGNF4
line 1349
;1349:	p->start = origin[2];
ADDRLP4 0
INDIRP4
CNSTI4 88
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
line 1350
;1350:	p->end = origin2[2];
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
line 1351
;1351:	p->pshader = pshader;
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 1353
;1352:	
;1353:	randsize = 1 + (crandom() * 0.5);
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4
CNSTF4 1056964608
CNSTF4 1073741824
ADDRLP4 8
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
CNSTF4 1065353216
ADDF4
ASGNF4
line 1355
;1354:	
;1355:	p->height = randsize;
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 1356
;1356:	p->width = randsize;
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 1358
;1357:	
;1358:	p->vel[2] = 50 + ( crandom() * 10 );
ADDRLP4 12
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1092616192
CNSTF4 1073741824
ADDRLP4 12
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
CNSTF4 1112014848
ADDF4
ASGNF4
line 1360
;1359:
;1360:	if (turb)
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $1435
line 1361
;1361:	{
line 1362
;1362:		p->type = P_BUBBLE_TURBULENT;
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 14
ASGNI4
line 1363
;1363:		p->vel[2] = 50 * 1.3;
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1115815936
ASGNF4
line 1364
;1364:	}
ADDRGP4 $1436
JUMPV
LABELV $1435
line 1366
;1365:	else
;1366:	{
line 1367
;1367:		p->type = P_BUBBLE;
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 13
ASGNI4
line 1368
;1368:	}
LABELV $1436
line 1370
;1369:	
;1370:	VectorCopy(origin, p->org);
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 1372
;1371:
;1372:	p->org[0] = p->org[0] + ( crandom() * range);
ADDRLP4 16
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
CNSTF4 1073741824
ADDRLP4 16
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
ADDRFP4 16
INDIRF4
MULF4
ADDF4
ASGNF4
line 1373
;1373:	p->org[1] = p->org[1] + ( crandom() * range);
ADDRLP4 24
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
CNSTF4 1073741824
ADDRLP4 24
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
ADDRFP4 16
INDIRF4
MULF4
ADDF4
ASGNF4
line 1374
;1374:	p->org[2] = p->org[2] + ( crandom() * (p->start - p->end)); 
ADDRLP4 32
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 36
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRF4
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
ADDRLP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 1376
;1375:
;1376:	p->vel[0] = p->vel[1] = 0;
ADDRLP4 48
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 48
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 48
INDIRF4
ASGNF4
line 1378
;1377:	
;1378:	p->accel[0] = p->accel[1] = p->accel[2] = 0;
ADDRLP4 56
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 56
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 56
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 56
INDIRF4
ASGNF4
line 1380
;1379:
;1380:	if (turb)
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $1437
line 1381
;1381:	{
line 1382
;1382:		p->vel[0] = crandom() * 4;
ADDRLP4 60
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 1082130432
CNSTF4 1073741824
ADDRLP4 60
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
ASGNF4
line 1383
;1383:		p->vel[1] = crandom() * 4;
ADDRLP4 64
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1082130432
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
ASGNF4
line 1384
;1384:	}
LABELV $1437
line 1387
;1385:
;1386:	// Rafael snow pvs check
;1387:	p->snum = snum;
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDRFP4 20
INDIRI4
ASGNI4
line 1388
;1388:	p->link = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
CNSTI4 1
ASGNI4
line 1390
;1389:
;1390:}
LABELV $1429
endproc CG_ParticleBubble 68 4
export CG_ParticleSmoke
proc CG_ParticleSmoke 28 4
line 1393
;1391:
;1392:void CG_ParticleSmoke (qhandle_t pshader, centity_t *cent)
;1393:{
line 1399
;1394:
;1395:	// using cent->density = enttime
;1396:	//		 cent->frame = startfade
;1397:	cparticle_t	*p;
;1398:
;1399:	if (!pshader)
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $1440
line 1400
;1400:		CG_Printf ("CG_ParticleSmoke == ZERO!\n");
ADDRGP4 $1442
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1440
line 1402
;1401:
;1402:	if (!free_particles)
ADDRGP4 free_particles
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1443
line 1403
;1403:		return;
ADDRGP4 $1439
JUMPV
LABELV $1443
line 1404
;1404:	p = free_particles;
ADDRLP4 0
ADDRGP4 free_particles
INDIRP4
ASGNP4
line 1405
;1405:	free_particles = p->next;
ADDRGP4 free_particles
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 1406
;1406:	p->next = active_particles;
ADDRLP4 0
INDIRP4
ADDRGP4 active_particles
INDIRP4
ASGNP4
line 1407
;1407:	active_particles = p;
ADDRGP4 active_particles
ADDRLP4 0
INDIRP4
ASGNP4
line 1408
;1408:	p->time = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ASGNF4
line 1410
;1409:	
;1410:	p->endtime = cg.time + cent->currentState.time;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ADDI4
CVIF4 4
ASGNF4
line 1411
;1411:	p->startfade = cg.time + cent->currentState.time2;
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
ADDI4
CVIF4 4
ASGNF4
line 1413
;1412:	
;1413:	p->color = 0;
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 1414
;1414:	p->alpha = 1.0;
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 1065353216
ASGNF4
line 1415
;1415:	p->alphavel = 0;
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 0
ASGNF4
line 1416
;1416:	p->start = cent->currentState.origin[2];
ADDRLP4 0
INDIRP4
CNSTI4 88
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ASGNF4
line 1417
;1417:	p->end = cent->currentState.origin2[2];
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 112
ADDP4
INDIRF4
ASGNF4
line 1418
;1418:	p->pshader = pshader;
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 1419
;1419:	p->rotate = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
CNSTI4 0
ASGNI4
line 1420
;1420:	p->height = 8;
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
CNSTF4 1090519040
ASGNF4
line 1421
;1421:	p->width = 8;
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
CNSTF4 1090519040
ASGNF4
line 1422
;1422:	p->endheight = 32;
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
CNSTF4 1107296256
ASGNF4
line 1423
;1423:	p->endwidth = 32;
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
CNSTF4 1107296256
ASGNF4
line 1424
;1424:	p->type = P_SMOKE;
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 3
ASGNI4
line 1426
;1425:	
;1426:	VectorCopy(cent->currentState.origin, p->org);
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 1428
;1427:
;1428:	p->vel[0] = p->vel[1] = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
line 1429
;1429:	p->accel[0] = p->accel[1] = p->accel[2] = 0;
ADDRLP4 16
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
line 1431
;1430:
;1431:	p->vel[2] = 5;
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1084227584
ASGNF4
line 1433
;1432:
;1433:	if (cent->currentState.frame == 1)// reverse gravity	
ADDRFP4 4
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1448
line 1434
;1434:		p->vel[2] *= -1;
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTF4 3212836864
ADDRLP4 20
INDIRP4
INDIRF4
MULF4
ASGNF4
LABELV $1448
line 1436
;1435:
;1436:	p->roll = 8 + (crandom() * 4);
ADDRLP4 24
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
CNSTF4 1082130432
CNSTF4 1073741824
ADDRLP4 24
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
CNSTF4 1090519040
ADDF4
CVFI4 4
ASGNI4
line 1437
;1437:}
LABELV $1439
endproc CG_ParticleSmoke 28 4
export CG_ParticleBulletDebris
proc CG_ParticleBulletDebris 16 0
line 1441
;1438:
;1439:
;1440:void CG_ParticleBulletDebris (vec3_t org, vec3_t vel, int duration)
;1441:{
line 1445
;1442:
;1443:	cparticle_t	*p;
;1444:
;1445:	if (!free_particles)
ADDRGP4 free_particles
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1451
line 1446
;1446:		return;
ADDRGP4 $1450
JUMPV
LABELV $1451
line 1447
;1447:	p = free_particles;
ADDRLP4 0
ADDRGP4 free_particles
INDIRP4
ASGNP4
line 1448
;1448:	free_particles = p->next;
ADDRGP4 free_particles
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 1449
;1449:	p->next = active_particles;
ADDRLP4 0
INDIRP4
ADDRGP4 active_particles
INDIRP4
ASGNP4
line 1450
;1450:	active_particles = p;
ADDRGP4 active_particles
ADDRLP4 0
INDIRP4
ASGNP4
line 1451
;1451:	p->time = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ASGNF4
line 1453
;1452:	
;1453:	p->endtime = cg.time + duration;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
CVIF4 4
ASGNF4
line 1454
;1454:	p->startfade = cg.time + duration/2;
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 8
INDIRI4
CNSTI4 2
DIVI4
ADDI4
CVIF4 4
ASGNF4
line 1456
;1455:	
;1456:	p->color = EMISIVEFADE;
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 3
ASGNI4
line 1457
;1457:	p->alpha = 1.0;
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 1065353216
ASGNF4
line 1458
;1458:	p->alphavel = 0;
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 0
ASGNF4
line 1460
;1459:
;1460:	p->height = 0.5;
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
CNSTF4 1056964608
ASGNF4
line 1461
;1461:	p->width = 0.5;
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
CNSTF4 1056964608
ASGNF4
line 1462
;1462:	p->endheight = 0.5;
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
CNSTF4 1056964608
ASGNF4
line 1463
;1463:	p->endwidth = 0.5;
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
CNSTF4 1056964608
ASGNF4
line 1465
;1464:
;1465:	p->pshader = cgs.media.tracerShader;
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ADDRGP4 cgs+156680+272
INDIRI4
ASGNI4
line 1467
;1466:
;1467:	p->type = P_SMOKE;
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 3
ASGNI4
line 1469
;1468:	
;1469:	VectorCopy(org, p->org);
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 1471
;1470:
;1471:	p->vel[0] = vel[0];
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRFP4 4
INDIRP4
INDIRF4
ASGNF4
line 1472
;1472:	p->vel[1] = vel[1];
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 1473
;1473:	p->vel[2] = vel[2];
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
line 1474
;1474:	p->accel[0] = p->accel[1] = p->accel[2] = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
line 1476
;1475:
;1476:	p->accel[2] = -60;
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTF4 3262119936
ASGNF4
line 1477
;1477:	p->vel[2] += -20;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
CNSTF4 3248488448
ADDF4
ASGNF4
line 1479
;1478:	
;1479:}
LABELV $1450
endproc CG_ParticleBulletDebris 16 0
export CG_ParticleExplosion
proc CG_ParticleExplosion 16 8
line 1488
;1480:
;1481:/*
;1482:======================
;1483:CG_ParticleExplosion
;1484:======================
;1485:*/
;1486:
;1487:void CG_ParticleExplosion (char *animStr, vec3_t origin, vec3_t vel, int duration, int sizeStart, int sizeEnd)
;1488:{
line 1492
;1489:	cparticle_t	*p;
;1490:	int anim;
;1491:
;1492:	if (animStr < (char *)10)
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 10
GEU4 $1459
line 1493
;1493:		CG_Error( "CG_ParticleExplosion: animStr is probably an index rather than a string" );
ADDRGP4 $1461
ARGP4
ADDRGP4 CG_Error
CALLV
pop
LABELV $1459
line 1496
;1494:
;1495:	// find the animation string
;1496:	for (anim=0; shaderAnimNames[anim]; anim++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1465
JUMPV
LABELV $1462
line 1497
;1497:		if (!Q_stricmp( animStr, shaderAnimNames[anim] ))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 shaderAnimNames
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $1466
line 1498
;1498:			break;
ADDRGP4 $1464
JUMPV
LABELV $1466
line 1499
;1499:	}
LABELV $1463
line 1496
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1465
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 shaderAnimNames
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1462
LABELV $1464
line 1500
;1500:	if (!shaderAnimNames[anim]) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 shaderAnimNames
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1468
line 1501
;1501:		CG_Error("CG_ParticleExplosion: unknown animation string: %s\n", animStr);
ADDRGP4 $1470
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 1502
;1502:		return;
ADDRGP4 $1458
JUMPV
LABELV $1468
line 1505
;1503:	}
;1504:
;1505:	if (!free_particles)
ADDRGP4 free_particles
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1471
line 1506
;1506:		return;
ADDRGP4 $1458
JUMPV
LABELV $1471
line 1507
;1507:	p = free_particles;
ADDRLP4 4
ADDRGP4 free_particles
INDIRP4
ASGNP4
line 1508
;1508:	free_particles = p->next;
ADDRGP4 free_particles
ADDRLP4 4
INDIRP4
INDIRP4
ASGNP4
line 1509
;1509:	p->next = active_particles;
ADDRLP4 4
INDIRP4
ADDRGP4 active_particles
INDIRP4
ASGNP4
line 1510
;1510:	active_particles = p;
ADDRGP4 active_particles
ADDRLP4 4
INDIRP4
ASGNP4
line 1511
;1511:	p->time = cg.time;
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ASGNF4
line 1512
;1512:	p->alpha = 0.5;
ADDRLP4 4
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 1056964608
ASGNF4
line 1513
;1513:	p->alphavel = 0;
ADDRLP4 4
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 0
ASGNF4
line 1515
;1514:
;1515:	if (duration < 0) {
ADDRFP4 12
INDIRI4
CNSTI4 0
GEI4 $1474
line 1516
;1516:		duration *= -1;
ADDRFP4 12
CNSTI4 -1
ADDRFP4 12
INDIRI4
MULI4
ASGNI4
line 1517
;1517:		p->roll = 0;
ADDRLP4 4
INDIRP4
CNSTI4 116
ADDP4
CNSTI4 0
ASGNI4
line 1518
;1518:	} else {
ADDRGP4 $1475
JUMPV
LABELV $1474
line 1519
;1519:		p->roll = crandom()*179;
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 116
ADDP4
CNSTF4 1127415808
CNSTF4 1073741824
ADDRLP4 8
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
CVFI4 4
ASGNI4
line 1520
;1520:	}
LABELV $1475
line 1522
;1521:
;1522:	p->shaderAnim = anim;
ADDRLP4 4
INDIRP4
CNSTI4 112
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1524
;1523:
;1524:	p->width = sizeStart;
ADDRLP4 4
INDIRP4
CNSTI4 76
ADDP4
ADDRFP4 16
INDIRI4
CVIF4 4
ASGNF4
line 1525
;1525:	p->height = sizeStart*shaderAnimSTRatio[anim];	// for sprites that are stretch in either direction
ADDRLP4 4
INDIRP4
CNSTI4 72
ADDP4
ADDRFP4 16
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 shaderAnimSTRatio
ADDP4
INDIRF4
MULF4
ASGNF4
line 1527
;1526:
;1527:	p->endheight = sizeEnd;
ADDRLP4 4
INDIRP4
CNSTI4 80
ADDP4
ADDRFP4 20
INDIRI4
CVIF4 4
ASGNF4
line 1528
;1528:	p->endwidth = sizeEnd*shaderAnimSTRatio[anim];
ADDRLP4 4
INDIRP4
CNSTI4 84
ADDP4
ADDRFP4 20
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 shaderAnimSTRatio
ADDP4
INDIRF4
MULF4
ASGNF4
line 1530
;1529:
;1530:	p->endtime = cg.time + duration;
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 12
INDIRI4
ADDI4
CVIF4 4
ASGNF4
line 1532
;1531:
;1532:	p->type = P_ANIM;
ADDRLP4 4
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 6
ASGNI4
line 1534
;1533:
;1534:	VectorCopy( origin, p->org );
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 1535
;1535:	VectorCopy( vel, p->vel );
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
ADDRFP4 8
INDIRP4
INDIRB
ASGNB 12
line 1536
;1536:	VectorClear( p->accel );
ADDRLP4 12
CNSTF4 0
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
line 1538
;1537:
;1538:}
LABELV $1458
endproc CG_ParticleExplosion 16 8
export CG_AddParticleShrapnel
proc CG_AddParticleShrapnel 0 0
line 1542
;1539:
;1540:// Rafael Shrapnel
;1541:void CG_AddParticleShrapnel (localEntity_t *le)
;1542:{
line 1543
;1543:	return;
LABELV $1477
endproc CG_AddParticleShrapnel 0 0
export CG_NewParticleArea
proc CG_NewParticleArea 92 24
line 1548
;1544:}
;1545:// done.
;1546:
;1547:int CG_NewParticleArea (int num)
;1548:{
line 1555
;1549:	// const char *str;
;1550:	char *str;
;1551:	char *token;
;1552:	int type;
;1553:	vec3_t origin, origin2;
;1554:	int		i;
;1555:	float range = 0;
ADDRLP4 40
CNSTF4 0
ASGNF4
line 1560
;1556:	int turb;
;1557:	int	numparticles;
;1558:	int	snum;
;1559:	
;1560:	str = (char *) CG_ConfigString (num);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 56
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 56
INDIRP4
ASGNP4
line 1561
;1561:	if (!str[0])
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1479
line 1562
;1562:		return (0);
CNSTI4 0
RETI4
ADDRGP4 $1478
JUMPV
LABELV $1479
line 1565
;1563:	
;1564:	// returns type 128 64 or 32
;1565:	token = COM_Parse (&str);
ADDRLP4 8
ARGP4
ADDRLP4 60
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 60
INDIRP4
ASGNP4
line 1566
;1566:	type = atoi (token);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 36
ADDRLP4 64
INDIRI4
ASGNI4
line 1568
;1567:	
;1568:	if (type == 1)
ADDRLP4 36
INDIRI4
CNSTI4 1
NEI4 $1481
line 1569
;1569:		range = 128;
ADDRLP4 40
CNSTF4 1124073472
ASGNF4
ADDRGP4 $1482
JUMPV
LABELV $1481
line 1570
;1570:	else if (type == 2)
ADDRLP4 36
INDIRI4
CNSTI4 2
NEI4 $1483
line 1571
;1571:		range = 64;
ADDRLP4 40
CNSTF4 1115684864
ASGNF4
ADDRGP4 $1484
JUMPV
LABELV $1483
line 1572
;1572:	else if (type == 3)
ADDRLP4 36
INDIRI4
CNSTI4 3
NEI4 $1485
line 1573
;1573:		range = 32;
ADDRLP4 40
CNSTF4 1107296256
ASGNF4
ADDRGP4 $1486
JUMPV
LABELV $1485
line 1574
;1574:	else if (type == 0)
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $1487
line 1575
;1575:		range = 256;
ADDRLP4 40
CNSTF4 1132462080
ASGNF4
ADDRGP4 $1488
JUMPV
LABELV $1487
line 1576
;1576:	else if (type == 4)
ADDRLP4 36
INDIRI4
CNSTI4 4
NEI4 $1489
line 1577
;1577:		range = 8;
ADDRLP4 40
CNSTF4 1090519040
ASGNF4
ADDRGP4 $1490
JUMPV
LABELV $1489
line 1578
;1578:	else if (type == 5)
ADDRLP4 36
INDIRI4
CNSTI4 5
NEI4 $1491
line 1579
;1579:		range = 16;
ADDRLP4 40
CNSTF4 1098907648
ASGNF4
ADDRGP4 $1492
JUMPV
LABELV $1491
line 1580
;1580:	else if (type == 6)
ADDRLP4 36
INDIRI4
CNSTI4 6
NEI4 $1493
line 1581
;1581:		range = 32;
ADDRLP4 40
CNSTF4 1107296256
ASGNF4
ADDRGP4 $1494
JUMPV
LABELV $1493
line 1582
;1582:	else if (type == 7)
ADDRLP4 36
INDIRI4
CNSTI4 7
NEI4 $1495
line 1583
;1583:		range = 64;
ADDRLP4 40
CNSTF4 1115684864
ASGNF4
LABELV $1495
LABELV $1494
LABELV $1492
LABELV $1490
LABELV $1488
LABELV $1486
LABELV $1484
LABELV $1482
line 1586
;1584:
;1585:
;1586:	for (i=0; i<3; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1497
line 1587
;1587:	{
line 1588
;1588:		token = COM_Parse (&str);
ADDRLP4 8
ARGP4
ADDRLP4 68
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 68
INDIRP4
ASGNP4
line 1589
;1589:		origin[i] = atof (token);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
ADDP4
ADDRLP4 72
INDIRF4
ASGNF4
line 1590
;1590:	}
LABELV $1498
line 1586
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $1497
line 1592
;1591:
;1592:	for (i=0; i<3; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1501
line 1593
;1593:	{
line 1594
;1594:		token = COM_Parse (&str);
ADDRLP4 8
ARGP4
ADDRLP4 68
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 68
INDIRP4
ASGNP4
line 1595
;1595:		origin2[i] = atof (token);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 24
ADDP4
ADDRLP4 72
INDIRF4
ASGNF4
line 1596
;1596:	}
LABELV $1502
line 1592
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $1501
line 1598
;1597:		
;1598:	token = COM_Parse (&str);
ADDRLP4 8
ARGP4
ADDRLP4 68
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 68
INDIRP4
ASGNP4
line 1599
;1599:	numparticles = atoi (token);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 48
ADDRLP4 72
INDIRI4
ASGNI4
line 1601
;1600:	
;1601:	token = COM_Parse (&str);
ADDRLP4 8
ARGP4
ADDRLP4 76
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 76
INDIRP4
ASGNP4
line 1602
;1602:	turb = atoi (token);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 44
ADDRLP4 80
INDIRI4
ASGNI4
line 1604
;1603:
;1604:	token = COM_Parse (&str);
ADDRLP4 8
ARGP4
ADDRLP4 84
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 84
INDIRP4
ASGNP4
line 1605
;1605:	snum = atoi (token);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 88
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 52
ADDRLP4 88
INDIRI4
ASGNI4
line 1607
;1606:	
;1607:	for (i=0; i<numparticles; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1508
JUMPV
LABELV $1505
line 1608
;1608:	{
line 1609
;1609:		if (type >= 4)
ADDRLP4 36
INDIRI4
CNSTI4 4
LTI4 $1509
line 1610
;1610:			CG_ParticleBubble (cgs.media.waterBubbleShader, origin, origin2, turb, range, snum);
ADDRGP4 cgs+156680+348
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 52
INDIRI4
ARGI4
ADDRGP4 CG_ParticleBubble
CALLV
pop
ADDRGP4 $1510
JUMPV
LABELV $1509
line 1612
;1611:		else
;1612:			CG_ParticleSnow (cgs.media.waterBubbleShader, origin, origin2, turb, range, snum);
ADDRGP4 cgs+156680+348
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 52
INDIRI4
ARGI4
ADDRGP4 CG_ParticleSnow
CALLV
pop
LABELV $1510
line 1613
;1613:	}
LABELV $1506
line 1607
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1508
ADDRLP4 0
INDIRI4
ADDRLP4 48
INDIRI4
LTI4 $1505
line 1615
;1614:
;1615:	return (1);
CNSTI4 1
RETI4
LABELV $1478
endproc CG_NewParticleArea 92 24
export CG_SnowLink
proc CG_SnowLink 16 0
line 1619
;1616:}
;1617:
;1618:void	CG_SnowLink (centity_t *cent, qboolean particleOn)
;1619:{
line 1623
;1620:	cparticle_t		*p, *next;
;1621:	int id;
;1622:
;1623:	id = cent->currentState.frame;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ASGNI4
line 1625
;1624:
;1625:	for (p=active_particles ; p ; p=next)
ADDRLP4 0
ADDRGP4 active_particles
INDIRP4
ASGNP4
ADDRGP4 $1519
JUMPV
LABELV $1516
line 1626
;1626:	{
line 1627
;1627:		next = p->next;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 1629
;1628:		
;1629:		if (p->type == P_WEATHER || p->type == P_WEATHER_TURBULENT)
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 1
EQI4 $1522
ADDRLP4 12
INDIRI4
CNSTI4 5
NEI4 $1520
LABELV $1522
line 1630
;1630:		{
line 1631
;1631:			if (p->snum == id)
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $1523
line 1632
;1632:			{
line 1633
;1633:				if (particleOn)
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $1525
line 1634
;1634:					p->link = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
CNSTI4 1
ASGNI4
ADDRGP4 $1526
JUMPV
LABELV $1525
line 1636
;1635:				else
;1636:					p->link = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
CNSTI4 0
ASGNI4
LABELV $1526
line 1637
;1637:			}
LABELV $1523
line 1638
;1638:		}
LABELV $1520
line 1640
;1639:
;1640:	}
LABELV $1517
line 1625
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
LABELV $1519
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1516
line 1641
;1641:}
LABELV $1515
endproc CG_SnowLink 16 0
export CG_ParticleImpactSmokePuff
proc CG_ParticleImpactSmokePuff 24 4
line 1644
;1642:
;1643:void CG_ParticleImpactSmokePuff (qhandle_t pshader, vec3_t origin)
;1644:{
line 1647
;1645:	cparticle_t	*p;
;1646:
;1647:	if (!pshader)
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $1528
line 1648
;1648:		CG_Printf ("CG_ParticleImpactSmokePuff pshader == ZERO!\n");
ADDRGP4 $1530
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1528
line 1650
;1649:
;1650:	if (!free_particles)
ADDRGP4 free_particles
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1531
line 1651
;1651:		return;
ADDRGP4 $1527
JUMPV
LABELV $1531
line 1652
;1652:	p = free_particles;
ADDRLP4 0
ADDRGP4 free_particles
INDIRP4
ASGNP4
line 1653
;1653:	free_particles = p->next;
ADDRGP4 free_particles
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 1654
;1654:	p->next = active_particles;
ADDRLP4 0
INDIRP4
ADDRGP4 active_particles
INDIRP4
ASGNP4
line 1655
;1655:	active_particles = p;
ADDRGP4 active_particles
ADDRLP4 0
INDIRP4
ASGNP4
line 1656
;1656:	p->time = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ASGNF4
line 1657
;1657:	p->alpha = 0.25;
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 1048576000
ASGNF4
line 1658
;1658:	p->alphavel = 0;
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 0
ASGNF4
line 1659
;1659:	p->roll = crandom()*179;
ADDRLP4 4
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
CNSTF4 1127415808
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
CVFI4 4
ASGNI4
line 1661
;1660:
;1661:	p->pshader = pshader;
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 1663
;1662:
;1663:	p->endtime = cg.time + 1000;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 1000
ADDI4
CVIF4 4
ASGNF4
line 1664
;1664:	p->startfade = cg.time + 100;
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 100
ADDI4
CVIF4 4
ASGNF4
line 1666
;1665:
;1666:	p->width = rand()%4 + 8;
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 4
MODI4
CNSTI4 8
ADDI4
CVIF4 4
ASGNF4
line 1667
;1667:	p->height = rand()%4 + 8;
ADDRLP4 12
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 12
INDIRI4
CNSTI4 4
MODI4
CNSTI4 8
ADDI4
CVIF4 4
ASGNF4
line 1669
;1668:
;1669:	p->endheight = p->height *2;
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
CNSTF4 1073741824
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
MULF4
ASGNF4
line 1670
;1670:	p->endwidth = p->width * 2;
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
CNSTF4 1073741824
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
MULF4
ASGNF4
line 1672
;1671:
;1672:	p->endtime = cg.time + 500;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 500
ADDI4
CVIF4 4
ASGNF4
line 1674
;1673:
;1674:	p->type = P_SMOKE_IMPACT;
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 12
ASGNI4
line 1676
;1675:
;1676:	VectorCopy( origin, p->org );
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 1677
;1677:	VectorSet(p->vel, 0, 0, 20);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1101004800
ASGNF4
line 1678
;1678:	VectorSet(p->accel, 0, 0, 20);
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTF4 1101004800
ASGNF4
line 1680
;1679:
;1680:	p->rotate = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
CNSTI4 1
ASGNI4
line 1681
;1681:}
LABELV $1527
endproc CG_ParticleImpactSmokePuff 24 4
export CG_Particle_Bleed
proc CG_Particle_Bleed 24 4
line 1684
;1682:
;1683:void CG_Particle_Bleed (qhandle_t pshader, vec3_t start, vec3_t dir, int fleshEntityNum, int duration)
;1684:{
line 1687
;1685:	cparticle_t	*p;
;1686:
;1687:	if (!pshader)
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $1538
line 1688
;1688:		CG_Printf ("CG_Particle_Bleed pshader == ZERO!\n");
ADDRGP4 $1540
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1538
line 1690
;1689:
;1690:	if (!free_particles)
ADDRGP4 free_particles
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1541
line 1691
;1691:		return;
ADDRGP4 $1537
JUMPV
LABELV $1541
line 1692
;1692:	p = free_particles;
ADDRLP4 0
ADDRGP4 free_particles
INDIRP4
ASGNP4
line 1693
;1693:	free_particles = p->next;
ADDRGP4 free_particles
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 1694
;1694:	p->next = active_particles;
ADDRLP4 0
INDIRP4
ADDRGP4 active_particles
INDIRP4
ASGNP4
line 1695
;1695:	active_particles = p;
ADDRGP4 active_particles
ADDRLP4 0
INDIRP4
ASGNP4
line 1696
;1696:	p->time = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ASGNF4
line 1697
;1697:	p->alpha = 1.0;
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 1065353216
ASGNF4
line 1698
;1698:	p->alphavel = 0;
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 0
ASGNF4
line 1699
;1699:	p->roll = 0;
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
CNSTI4 0
ASGNI4
line 1701
;1700:
;1701:	p->pshader = pshader;
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 1703
;1702:
;1703:	p->endtime = cg.time + duration;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 16
INDIRI4
ADDI4
CVIF4 4
ASGNF4
line 1705
;1704:	
;1705:	if (fleshEntityNum)
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $1545
line 1706
;1706:		p->startfade = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ASGNF4
ADDRGP4 $1546
JUMPV
LABELV $1545
line 1708
;1707:	else
;1708:		p->startfade = cg.time + 100;
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 100
ADDI4
CVIF4 4
ASGNF4
LABELV $1546
line 1710
;1709:
;1710:	p->width = 4;
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
CNSTF4 1082130432
ASGNF4
line 1711
;1711:	p->height = 4;
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
CNSTF4 1082130432
ASGNF4
line 1713
;1712:
;1713:	p->endheight = 4+rand()%3;
ADDRLP4 4
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 3
MODI4
CNSTI4 4
ADDI4
CVIF4 4
ASGNF4
line 1714
;1714:	p->endwidth = p->endheight;
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
ASGNF4
line 1716
;1715:
;1716:	p->type = P_SMOKE;
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 3
ASGNI4
line 1718
;1717:
;1718:	VectorCopy( start, p->org );
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 1719
;1719:	p->vel[0] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 0
ASGNF4
line 1720
;1720:	p->vel[1] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 0
ASGNF4
line 1721
;1721:	p->vel[2] = -20;
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 3248488448
ASGNF4
line 1722
;1722:	VectorClear( p->accel );
ADDRLP4 16
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
line 1724
;1723:
;1724:	p->rotate = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
CNSTI4 0
ASGNI4
line 1726
;1725:
;1726:	p->roll = rand()%179;
ADDRLP4 20
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 20
INDIRI4
CNSTI4 179
MODI4
ASGNI4
line 1728
;1727:	
;1728:	p->color = BLOODRED;
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 2
ASGNI4
line 1729
;1729:	p->alpha = 0.75;
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 1061158912
ASGNF4
line 1731
;1730:
;1731:}
LABELV $1537
endproc CG_Particle_Bleed 24 4
export CG_Particle_OilParticle
proc CG_Particle_OilParticle 36 4
line 1734
;1732:
;1733:void CG_Particle_OilParticle (qhandle_t pshader, centity_t *cent)
;1734:{
line 1741
;1735:	cparticle_t	*p;
;1736:
;1737:	int			time;
;1738:	int			time2;
;1739:	float		ratio;
;1740:
;1741:	float	duration = 1500;
ADDRLP4 16
CNSTF4 1153138688
ASGNF4
line 1743
;1742:
;1743:	time = cg.time;
ADDRLP4 8
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1744
;1744:	time2 = cg.time + cent->currentState.time;
ADDRLP4 12
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ADDI4
ASGNI4
line 1746
;1745:
;1746:	ratio =(float)1 - ((float)time / (float)time2);
ADDRLP4 4
CNSTF4 1065353216
ADDRLP4 8
INDIRI4
CVIF4 4
ADDRLP4 12
INDIRI4
CVIF4 4
DIVF4
SUBF4
ASGNF4
line 1748
;1747:
;1748:	if (!pshader)
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $1552
line 1749
;1749:		CG_Printf ("CG_Particle_OilParticle == ZERO!\n");
ADDRGP4 $1554
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1552
line 1751
;1750:
;1751:	if (!free_particles)
ADDRGP4 free_particles
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1555
line 1752
;1752:		return;
ADDRGP4 $1549
JUMPV
LABELV $1555
line 1753
;1753:	p = free_particles;
ADDRLP4 0
ADDRGP4 free_particles
INDIRP4
ASGNP4
line 1754
;1754:	free_particles = p->next;
ADDRGP4 free_particles
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 1755
;1755:	p->next = active_particles;
ADDRLP4 0
INDIRP4
ADDRGP4 active_particles
INDIRP4
ASGNP4
line 1756
;1756:	active_particles = p;
ADDRGP4 active_particles
ADDRLP4 0
INDIRP4
ASGNP4
line 1757
;1757:	p->time = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ASGNF4
line 1758
;1758:	p->alpha = 1.0;
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 1065353216
ASGNF4
line 1759
;1759:	p->alphavel = 0;
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 0
ASGNF4
line 1760
;1760:	p->roll = 0;
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
CNSTI4 0
ASGNI4
line 1762
;1761:
;1762:	p->pshader = pshader;
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 1764
;1763:
;1764:	p->endtime = cg.time + duration;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ADDRLP4 16
INDIRF4
ADDF4
ASGNF4
line 1766
;1765:	
;1766:	p->startfade = p->endtime;
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
line 1768
;1767:
;1768:	p->width = 1;
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
CNSTF4 1065353216
ASGNF4
line 1769
;1769:	p->height = 3;
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
CNSTF4 1077936128
ASGNF4
line 1771
;1770:
;1771:	p->endheight = 3;
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
CNSTF4 1077936128
ASGNF4
line 1772
;1772:	p->endwidth = 1;
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
CNSTF4 1065353216
ASGNF4
line 1774
;1773:
;1774:	p->type = P_SMOKE;
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 3
ASGNI4
line 1776
;1775:
;1776:	VectorCopy(cent->currentState.origin, p->org );	
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 1778
;1777:	
;1778:	p->vel[0] = (cent->currentState.origin2[0] * (16 * ratio));
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 104
ADDP4
INDIRF4
CNSTF4 1098907648
ADDRLP4 4
INDIRF4
MULF4
MULF4
ASGNF4
line 1779
;1779:	p->vel[1] = (cent->currentState.origin2[1] * (16 * ratio));
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 108
ADDP4
INDIRF4
CNSTF4 1098907648
ADDRLP4 4
INDIRF4
MULF4
MULF4
ASGNF4
line 1780
;1780:	p->vel[2] = (cent->currentState.origin2[2]);
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 112
ADDP4
INDIRF4
ASGNF4
line 1782
;1781:
;1782:	p->snum = 1.0f;
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
CNSTI4 1
ASGNI4
line 1784
;1783:
;1784:	VectorClear( p->accel );
ADDRLP4 28
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 28
INDIRF4
ASGNF4
line 1786
;1785:
;1786:	p->accel[2] = -20;
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTF4 3248488448
ASGNF4
line 1788
;1787:
;1788:	p->rotate = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
CNSTI4 0
ASGNI4
line 1790
;1789:
;1790:	p->roll = rand()%179;
ADDRLP4 32
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 32
INDIRI4
CNSTI4 179
MODI4
ASGNI4
line 1792
;1791:	
;1792:	p->alpha = 0.75;
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 1061158912
ASGNF4
line 1794
;1793:
;1794:}
LABELV $1549
endproc CG_Particle_OilParticle 36 4
export CG_Particle_OilSlick
proc CG_Particle_OilSlick 36 4
line 1798
;1795:
;1796:
;1797:void CG_Particle_OilSlick (qhandle_t pshader, centity_t *cent)
;1798:{
line 1801
;1799:	cparticle_t	*p;
;1800:	
;1801:  	if (!pshader)
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $1560
line 1802
;1802:		CG_Printf ("CG_Particle_OilSlick == ZERO!\n");
ADDRGP4 $1562
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1560
line 1804
;1803:
;1804:	if (!free_particles)
ADDRGP4 free_particles
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1563
line 1805
;1805:		return;
ADDRGP4 $1559
JUMPV
LABELV $1563
line 1806
;1806:	p = free_particles;
ADDRLP4 0
ADDRGP4 free_particles
INDIRP4
ASGNP4
line 1807
;1807:	free_particles = p->next;
ADDRGP4 free_particles
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 1808
;1808:	p->next = active_particles;
ADDRLP4 0
INDIRP4
ADDRGP4 active_particles
INDIRP4
ASGNP4
line 1809
;1809:	active_particles = p;
ADDRGP4 active_particles
ADDRLP4 0
INDIRP4
ASGNP4
line 1810
;1810:	p->time = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ASGNF4
line 1812
;1811:	
;1812:	if (cent->currentState.angles2[2])
ADDRFP4 4
INDIRP4
CNSTI4 136
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1566
line 1813
;1813:		p->endtime = cg.time + cent->currentState.angles2[2];
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ADDRFP4 4
INDIRP4
CNSTI4 136
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRGP4 $1567
JUMPV
LABELV $1566
line 1815
;1814:	else
;1815:		p->endtime = cg.time + 60000;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 60000
ADDI4
CVIF4 4
ASGNF4
LABELV $1567
line 1817
;1816:
;1817:	p->startfade = p->endtime;
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
line 1819
;1818:
;1819:	p->alpha = 1.0;
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 1065353216
ASGNF4
line 1820
;1820:	p->alphavel = 0;
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 0
ASGNF4
line 1821
;1821:	p->roll = 0;
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
CNSTI4 0
ASGNI4
line 1823
;1822:
;1823:	p->pshader = pshader;
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 1825
;1824:
;1825:	if (cent->currentState.angles2[0] || cent->currentState.angles2[1])
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
CNSTF4 0
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 128
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
NEF4 $1572
ADDRLP4 8
INDIRP4
CNSTI4 132
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
EQF4 $1570
LABELV $1572
line 1826
;1826:	{
line 1827
;1827:		p->width = cent->currentState.angles2[0];
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 128
ADDP4
INDIRF4
ASGNF4
line 1828
;1828:		p->height = cent->currentState.angles2[0];
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 128
ADDP4
INDIRF4
ASGNF4
line 1830
;1829:
;1830:		p->endheight = cent->currentState.angles2[1];
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 132
ADDP4
INDIRF4
ASGNF4
line 1831
;1831:		p->endwidth = cent->currentState.angles2[1];
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 132
ADDP4
INDIRF4
ASGNF4
line 1832
;1832:	}
ADDRGP4 $1571
JUMPV
LABELV $1570
line 1834
;1833:	else
;1834:	{
line 1835
;1835:		p->width = 8;
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
CNSTF4 1090519040
ASGNF4
line 1836
;1836:		p->height = 8;
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
CNSTF4 1090519040
ASGNF4
line 1838
;1837:
;1838:		p->endheight = 16;
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
CNSTF4 1098907648
ASGNF4
line 1839
;1839:		p->endwidth = 16;
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
CNSTF4 1098907648
ASGNF4
line 1840
;1840:	}
LABELV $1571
line 1842
;1841:
;1842:	p->type = P_FLAT_SCALEUP;
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 9
ASGNI4
line 1844
;1843:
;1844:	p->snum = 1.0;
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
CNSTI4 1
ASGNI4
line 1846
;1845:
;1846:	VectorCopy(cent->currentState.origin, p->org );
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 1848
;1847:	
;1848:	p->org[2]+= 0.55 + (crandom() * 0.5);
ADDRLP4 16
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
CNSTF4 1056964608
CNSTF4 1073741824
ADDRLP4 16
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
CNSTF4 1057803469
ADDF4
ADDF4
ASGNF4
line 1850
;1849:
;1850:	p->vel[0] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 0
ASGNF4
line 1851
;1851:	p->vel[1] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 0
ASGNF4
line 1852
;1852:	p->vel[2] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 0
ASGNF4
line 1853
;1853:	VectorClear( p->accel );
ADDRLP4 28
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 28
INDIRF4
ASGNF4
line 1855
;1854:
;1855:	p->rotate = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
CNSTI4 0
ASGNI4
line 1857
;1856:
;1857:	p->roll = rand()%179;
ADDRLP4 32
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 32
INDIRI4
CNSTI4 179
MODI4
ASGNI4
line 1859
;1858:	
;1859:	p->alpha = 0.75;
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 1061158912
ASGNF4
line 1861
;1860:
;1861:}
LABELV $1559
endproc CG_Particle_OilSlick 36 4
export CG_OilSlickRemove
proc CG_OilSlickRemove 16 4
line 1864
;1862:
;1863:void CG_OilSlickRemove (centity_t *cent)
;1864:{
line 1868
;1865:	cparticle_t		*p, *next;
;1866:	int				id;
;1867:
;1868:	id = 1.0f;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 1870
;1869:
;1870:	if (!id)
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $1574
line 1871
;1871:		CG_Printf ("CG_OilSlickRevove NULL id\n");
ADDRGP4 $1576
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1574
line 1873
;1872:
;1873:	for (p=active_particles ; p ; p=next)
ADDRLP4 0
ADDRGP4 active_particles
INDIRP4
ASGNP4
ADDRGP4 $1580
JUMPV
LABELV $1577
line 1874
;1874:	{
line 1875
;1875:		next = p->next;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 1877
;1876:		
;1877:		if (p->type == P_FLAT_SCALEUP)
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
CNSTI4 9
NEI4 $1581
line 1878
;1878:		{
line 1879
;1879:			if (p->snum == id)
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $1583
line 1880
;1880:			{
line 1881
;1881:				p->endtime = cg.time + 100;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 100
ADDI4
CVIF4 4
ASGNF4
line 1882
;1882:				p->startfade = p->endtime;
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
line 1883
;1883:				p->type = P_FLAT_SCALEUP_FADE;
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 10
ASGNI4
line 1885
;1884:
;1885:			}
LABELV $1583
line 1886
;1886:		}
LABELV $1581
line 1888
;1887:
;1888:	}
LABELV $1578
line 1873
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
LABELV $1580
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1577
line 1889
;1889:}
LABELV $1573
endproc CG_OilSlickRemove 16 4
export ValidBloodPool
proc ValidBloodPool 196 28
line 1892
;1890:
;1891:qboolean ValidBloodPool (vec3_t start)
;1892:{
line 1903
;1893:#define EXTRUDE_DIST	0.5
;1894:
;1895:	vec3_t	angles;
;1896:	vec3_t	right, up;
;1897:	vec3_t	this_pos, x_pos, center_pos, end_pos;
;1898:	float	x, y;
;1899:	float	fwidth, fheight;
;1900:	trace_t	trace;
;1901:	vec3_t	normal;
;1902:
;1903:	fwidth = 16;
ADDRLP4 152
CNSTF4 1098907648
ASGNF4
line 1904
;1904:	fheight = 16;
ADDRLP4 120
CNSTF4 1098907648
ASGNF4
line 1906
;1905:
;1906:	VectorSet (normal, 0, 0, 1);
ADDRLP4 168
CNSTF4 0
ASGNF4
ADDRLP4 96
ADDRLP4 168
INDIRF4
ASGNF4
ADDRLP4 96+4
ADDRLP4 168
INDIRF4
ASGNF4
ADDRLP4 96+8
CNSTF4 1065353216
ASGNF4
line 1908
;1907:
;1908:	vectoangles (normal, angles);
ADDRLP4 96
ARGP4
ADDRLP4 156
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 1909
;1909:	AngleVectors (angles, NULL, right, up);
ADDRLP4 156
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 140
ARGP4
ADDRLP4 108
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 1911
;1910:
;1911:	VectorMA (start, EXTRUDE_DIST, normal, center_pos);
ADDRLP4 172
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 176
CNSTF4 1056964608
ASGNF4
ADDRLP4 128
ADDRLP4 172
INDIRP4
INDIRF4
ADDRLP4 176
INDIRF4
ADDRLP4 96
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 128+4
ADDRLP4 172
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 176
INDIRF4
ADDRLP4 96+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 128+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1056964608
ADDRLP4 96+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1913
;1912:
;1913:	for (x= -fwidth/2; x<fwidth; x+= fwidth)
ADDRLP4 124
ADDRLP4 152
INDIRF4
NEGF4
CNSTF4 1073741824
DIVF4
ASGNF4
ADDRGP4 $1596
JUMPV
LABELV $1593
line 1914
;1914:	{
line 1915
;1915:		VectorMA (center_pos, x, right, x_pos);
ADDRLP4 84
ADDRLP4 128
INDIRF4
ADDRLP4 140
INDIRF4
ADDRLP4 124
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 84+4
ADDRLP4 128+4
INDIRF4
ADDRLP4 140+4
INDIRF4
ADDRLP4 124
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 84+8
ADDRLP4 128+8
INDIRF4
ADDRLP4 140+8
INDIRF4
ADDRLP4 124
INDIRF4
MULF4
ADDF4
ASGNF4
line 1917
;1916:
;1917:		for (y= -fheight/2; y<fheight; y+= fheight)
ADDRLP4 12
ADDRLP4 120
INDIRF4
NEGF4
CNSTF4 1073741824
DIVF4
ASGNF4
ADDRGP4 $1606
JUMPV
LABELV $1603
line 1918
;1918:		{
line 1919
;1919:			VectorMA (x_pos, y, up, this_pos);
ADDRLP4 0
ADDRLP4 84
INDIRF4
ADDRLP4 108
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 84+4
INDIRF4
ADDRLP4 108+4
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 84+8
INDIRF4
ADDRLP4 108+8
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
line 1920
;1920:			VectorMA (this_pos, -EXTRUDE_DIST*2, normal, end_pos);
ADDRLP4 188
CNSTF4 3212836864
ASGNF4
ADDRLP4 16
ADDRLP4 0
INDIRF4
ADDRLP4 188
INDIRF4
ADDRLP4 96
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 188
INDIRF4
ADDRLP4 96+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 0+8
INDIRF4
CNSTF4 3212836864
ADDRLP4 96+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1922
;1921:			
;1922:			CG_Trace (&trace, this_pos, NULL, NULL, end_pos, -1, CONTENTS_SOLID);
ADDRLP4 28
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 192
CNSTP4 0
ASGNP4
ADDRLP4 192
INDIRP4
ARGP4
ADDRLP4 192
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 1925
;1923:
;1924:			
;1925:			if (trace.entityNum < (MAX_ENTITIES - 1)) // may only land on world
ADDRLP4 28+52
INDIRI4
CNSTI4 1022
GEI4 $1619
line 1926
;1926:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1586
JUMPV
LABELV $1619
line 1928
;1927:
;1928:			if (!(!trace.startsolid && trace.fraction < 1))
ADDRLP4 28+4
INDIRI4
CNSTI4 0
NEI4 $1626
ADDRLP4 28+8
INDIRF4
CNSTF4 1065353216
LTF4 $1622
LABELV $1626
line 1929
;1929:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1586
JUMPV
LABELV $1622
line 1931
;1930:		
;1931:		}
LABELV $1604
line 1917
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 120
INDIRF4
ADDF4
ASGNF4
LABELV $1606
ADDRLP4 12
INDIRF4
ADDRLP4 120
INDIRF4
LTF4 $1603
line 1932
;1932:	}
LABELV $1594
line 1913
ADDRLP4 124
ADDRLP4 124
INDIRF4
ADDRLP4 152
INDIRF4
ADDF4
ASGNF4
LABELV $1596
ADDRLP4 124
INDIRF4
ADDRLP4 152
INDIRF4
LTF4 $1593
line 1934
;1933:
;1934:	return qtrue;
CNSTI4 1
RETI4
LABELV $1586
endproc ValidBloodPool 196 28
export CG_BloodPool
proc CG_BloodPool 48 4
line 1938
;1935:}
;1936:
;1937:void CG_BloodPool (localEntity_t *le, qhandle_t pshader, trace_t *tr)
;1938:{	
line 1944
;1939:	cparticle_t	*p;
;1940:	qboolean	legit;
;1941:	vec3_t		start;
;1942:	float		rndSize;
;1943:	
;1944:	if (!pshader)
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $1628
line 1945
;1945:		CG_Printf ("CG_BloodPool pshader == ZERO!\n");
ADDRGP4 $1630
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1628
line 1947
;1946:
;1947:	if (!free_particles)
ADDRGP4 free_particles
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1631
line 1948
;1948:		return;
ADDRGP4 $1627
JUMPV
LABELV $1631
line 1950
;1949:	
;1950:	VectorCopy (tr->endpos, start);
ADDRLP4 8
ADDRFP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRB
ASGNB 12
line 1951
;1951:	legit = ValidBloodPool (start);
ADDRLP4 8
ARGP4
ADDRLP4 24
ADDRGP4 ValidBloodPool
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 24
INDIRI4
ASGNI4
line 1953
;1952:
;1953:	if (!legit) 
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $1633
line 1954
;1954:		return;
ADDRGP4 $1627
JUMPV
LABELV $1633
line 1956
;1955:
;1956:	p = free_particles;
ADDRLP4 0
ADDRGP4 free_particles
INDIRP4
ASGNP4
line 1957
;1957:	free_particles = p->next;
ADDRGP4 free_particles
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 1958
;1958:	p->next = active_particles;
ADDRLP4 0
INDIRP4
ADDRGP4 active_particles
INDIRP4
ASGNP4
line 1959
;1959:	active_particles = p;
ADDRGP4 active_particles
ADDRLP4 0
INDIRP4
ASGNP4
line 1960
;1960:	p->time = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ASGNF4
line 1962
;1961:	
;1962:	p->endtime = cg.time + 3000;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 3000
ADDI4
CVIF4 4
ASGNF4
line 1963
;1963:	p->startfade = p->endtime;
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
line 1965
;1964:
;1965:	p->alpha = 1.0;
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 1065353216
ASGNF4
line 1966
;1966:	p->alphavel = 0;
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 0
ASGNF4
line 1967
;1967:	p->roll = 0;
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
CNSTI4 0
ASGNI4
line 1969
;1968:
;1969:	p->pshader = pshader;
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 1971
;1970:
;1971:	rndSize = 0.4 + random()*0.6;
ADDRLP4 32
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4
CNSTF4 1058642330
ADDRLP4 32
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
CNSTF4 1053609165
ADDF4
ASGNF4
line 1973
;1972:
;1973:	p->width = 8*rndSize;
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
CNSTF4 1090519040
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 1974
;1974:	p->height = 8*rndSize;
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
CNSTF4 1090519040
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 1976
;1975:
;1976:	p->endheight = 16*rndSize;
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
CNSTF4 1098907648
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 1977
;1977:	p->endwidth = 16*rndSize;
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
CNSTF4 1098907648
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 1979
;1978:	
;1979:	p->type = P_FLAT_SCALEUP;
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 9
ASGNI4
line 1981
;1980:
;1981:	VectorCopy(start, p->org );
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 8
INDIRB
ASGNB 12
line 1983
;1982:	
;1983:	p->vel[0] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 0
ASGNF4
line 1984
;1984:	p->vel[1] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 0
ASGNF4
line 1985
;1985:	p->vel[2] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 0
ASGNF4
line 1986
;1986:	VectorClear( p->accel );
ADDRLP4 40
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 40
INDIRF4
ASGNF4
line 1988
;1987:
;1988:	p->rotate = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
CNSTI4 0
ASGNI4
line 1990
;1989:
;1990:	p->roll = rand()%179;
ADDRLP4 44
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 44
INDIRI4
CNSTI4 179
MODI4
ASGNI4
line 1992
;1991:	
;1992:	p->alpha = 0.75;
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 1061158912
ASGNF4
line 1994
;1993:	
;1994:	p->color = BLOODRED;
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 2
ASGNI4
line 1995
;1995:}
LABELV $1627
endproc CG_BloodPool 48 4
export CG_ParticleBloodCloud
proc CG_ParticleBloodCloud 84 16
line 2001
;1996:
;1997:#define NORMALSIZE	16
;1998:#define LARGESIZE	32
;1999:
;2000:void CG_ParticleBloodCloud (centity_t *cent, vec3_t origin, vec3_t dir)
;2001:{
line 2010
;2002:	float	length;
;2003:	float	dist;
;2004:	float	crittersize;
;2005:	vec3_t	angles, forward;
;2006:	vec3_t	point;
;2007:	cparticle_t	*p;
;2008:	int		i;
;2009:	
;2010:	dist = 0;
ADDRLP4 36
CNSTF4 0
ASGNF4
line 2012
;2011:
;2012:	length = VectorLength (dir);
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 40
ADDRLP4 56
INDIRF4
ASGNF4
line 2013
;2013:	vectoangles (dir, angles);
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 44
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2014
;2014:	AngleVectors (angles, forward, NULL, NULL);
ADDRLP4 44
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 60
CNSTP4 0
ASGNP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 2016
;2015:
;2016:	crittersize = LARGESIZE;
ADDRLP4 16
CNSTF4 1107296256
ASGNF4
line 2018
;2017:
;2018:	if (length)
ADDRLP4 40
INDIRF4
CNSTF4 0
EQF4 $1638
line 2019
;2019:		dist = length / crittersize;
ADDRLP4 36
ADDRLP4 40
INDIRF4
ADDRLP4 16
INDIRF4
DIVF4
ASGNF4
LABELV $1638
line 2021
;2020:
;2021:	if (dist < 1)
ADDRLP4 36
INDIRF4
CNSTF4 1065353216
GEF4 $1640
line 2022
;2022:		dist = 1;
ADDRLP4 36
CNSTF4 1065353216
ASGNF4
LABELV $1640
line 2024
;2023:
;2024:	VectorCopy (origin, point);
ADDRLP4 4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 2026
;2025:
;2026:	for (i=0; i<dist; i++)
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRGP4 $1645
JUMPV
LABELV $1642
line 2027
;2027:	{
line 2028
;2028:		VectorMA (point, crittersize, forward, point);	
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 20
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 4+4
INDIRF4
ADDRLP4 20+4
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRLP4 20+8
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDF4
ASGNF4
line 2030
;2029:		
;2030:		if (!free_particles)
ADDRGP4 free_particles
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1652
line 2031
;2031:			return;
ADDRGP4 $1637
JUMPV
LABELV $1652
line 2033
;2032:
;2033:		p = free_particles;
ADDRLP4 0
ADDRGP4 free_particles
INDIRP4
ASGNP4
line 2034
;2034:		free_particles = p->next;
ADDRGP4 free_particles
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 2035
;2035:		p->next = active_particles;
ADDRLP4 0
INDIRP4
ADDRGP4 active_particles
INDIRP4
ASGNP4
line 2036
;2036:		active_particles = p;
ADDRGP4 active_particles
ADDRLP4 0
INDIRP4
ASGNP4
line 2038
;2037:
;2038:		p->time = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ASGNF4
line 2039
;2039:		p->alpha = 1.0;
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 1065353216
ASGNF4
line 2040
;2040:		p->alphavel = 0;
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 0
ASGNF4
line 2041
;2041:		p->roll = 0;
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
CNSTI4 0
ASGNI4
line 2043
;2042:
;2043:		p->pshader = cgs.media.smokePuffShader;
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ADDRGP4 cgs+156680+332
INDIRI4
ASGNI4
line 2045
;2044:
;2045:		p->endtime = cg.time + 350 + (crandom() * 100);
ADDRLP4 68
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 350
ADDI4
CVIF4 4
CNSTF4 1120403456
CNSTF4 1073741824
ADDRLP4 68
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
ASGNF4
line 2047
;2046:		
;2047:		p->startfade = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ASGNF4
line 2049
;2048:		
;2049:		p->width = LARGESIZE;
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
CNSTF4 1107296256
ASGNF4
line 2050
;2050:		p->height = LARGESIZE;
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
CNSTF4 1107296256
ASGNF4
line 2051
;2051:		p->endheight = LARGESIZE;
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
CNSTF4 1107296256
ASGNF4
line 2052
;2052:		p->endwidth = LARGESIZE;
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
CNSTF4 1107296256
ASGNF4
line 2054
;2053:
;2054:		p->type = P_SMOKE;
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 3
ASGNI4
line 2056
;2055:
;2056:		VectorCopy( origin, p->org );
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 2058
;2057:		
;2058:		p->vel[0] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 0
ASGNF4
line 2059
;2059:		p->vel[1] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 0
ASGNF4
line 2060
;2060:		p->vel[2] = -1;
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 3212836864
ASGNF4
line 2062
;2061:		
;2062:		VectorClear( p->accel );
ADDRLP4 76
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 76
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 76
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 76
INDIRF4
ASGNF4
line 2064
;2063:
;2064:		p->rotate = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
CNSTI4 0
ASGNI4
line 2066
;2065:
;2066:		p->roll = rand()%179;
ADDRLP4 80
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 80
INDIRI4
CNSTI4 179
MODI4
ASGNI4
line 2068
;2067:		
;2068:		p->color = BLOODRED;
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 2
ASGNI4
line 2070
;2069:		
;2070:		p->alpha = 0.75;
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 1061158912
ASGNF4
line 2072
;2071:		
;2072:	}
LABELV $1643
line 2026
ADDRLP4 32
ADDRLP4 32
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1645
ADDRLP4 32
INDIRI4
CVIF4 4
ADDRLP4 36
INDIRF4
LTF4 $1642
line 2075
;2073:
;2074:	
;2075:}
LABELV $1637
endproc CG_ParticleBloodCloud 84 16
export CG_ParticleSparks
proc CG_ParticleSparks 60 0
line 2078
;2076:
;2077:void CG_ParticleSparks (vec3_t org, vec3_t vel, int duration, float x, float y, float speed)
;2078:{
line 2081
;2079:	cparticle_t	*p;
;2080:
;2081:	if (!free_particles)
ADDRGP4 free_particles
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1660
line 2082
;2082:		return;
ADDRGP4 $1659
JUMPV
LABELV $1660
line 2083
;2083:	p = free_particles;
ADDRLP4 0
ADDRGP4 free_particles
INDIRP4
ASGNP4
line 2084
;2084:	free_particles = p->next;
ADDRGP4 free_particles
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 2085
;2085:	p->next = active_particles;
ADDRLP4 0
INDIRP4
ADDRGP4 active_particles
INDIRP4
ASGNP4
line 2086
;2086:	active_particles = p;
ADDRGP4 active_particles
ADDRLP4 0
INDIRP4
ASGNP4
line 2087
;2087:	p->time = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ASGNF4
line 2089
;2088:	
;2089:	p->endtime = cg.time + duration;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
CVIF4 4
ASGNF4
line 2090
;2090:	p->startfade = cg.time + duration/2;
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 8
INDIRI4
CNSTI4 2
DIVI4
ADDI4
CVIF4 4
ASGNF4
line 2092
;2091:	
;2092:	p->color = EMISIVEFADE;
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 3
ASGNI4
line 2093
;2093:	p->alpha = 0.4f;
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 1053609165
ASGNF4
line 2094
;2094:	p->alphavel = 0;
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 0
ASGNF4
line 2096
;2095:
;2096:	p->height = 0.5;
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
CNSTF4 1056964608
ASGNF4
line 2097
;2097:	p->width = 0.5;
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
CNSTF4 1056964608
ASGNF4
line 2098
;2098:	p->endheight = 0.5;
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
CNSTF4 1056964608
ASGNF4
line 2099
;2099:	p->endwidth = 0.5;
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
CNSTF4 1056964608
ASGNF4
line 2101
;2100:
;2101:	p->pshader = cgs.media.tracerShader;
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ADDRGP4 cgs+156680+272
INDIRI4
ASGNI4
line 2103
;2102:
;2103:	p->type = P_SMOKE;
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 3
ASGNI4
line 2105
;2104:	
;2105:	VectorCopy(org, p->org);
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 2107
;2106:
;2107:	p->org[0] += (crandom() * x);
ADDRLP4 4
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
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
ADDRFP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
line 2108
;2108:	p->org[1] += (crandom() * y);
ADDRLP4 12
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
CNSTF4 1073741824
ADDRLP4 12
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
ADDRFP4 16
INDIRF4
MULF4
ADDF4
ASGNF4
line 2110
;2109:
;2110:	p->vel[0] = vel[0];
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRFP4 4
INDIRP4
INDIRF4
ASGNF4
line 2111
;2111:	p->vel[1] = vel[1];
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 2112
;2112:	p->vel[2] = vel[2];
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
line 2114
;2113:
;2114:	p->accel[0] = p->accel[1] = p->accel[2] = 0;
ADDRLP4 24
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 24
INDIRF4
ASGNF4
line 2116
;2115:
;2116:	p->vel[0] += (crandom() * 4);
ADDRLP4 28
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRF4
CNSTF4 1082130432
CNSTF4 1073741824
ADDRLP4 28
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
ASGNF4
line 2117
;2117:	p->vel[1] += (crandom() * 4);
ADDRLP4 36
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRF4
CNSTF4 1082130432
CNSTF4 1073741824
ADDRLP4 36
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
ASGNF4
line 2118
;2118:	p->vel[2] += (20 + (crandom() * 10)) * speed;	
ADDRLP4 44
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 48
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRF4
CNSTF4 1092616192
CNSTF4 1073741824
ADDRLP4 44
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
CNSTF4 1101004800
ADDF4
ADDRFP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
line 2120
;2119:
;2120:	p->accel[0] = crandom () * 4;
ADDRLP4 52
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1082130432
CNSTF4 1073741824
ADDRLP4 52
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
ASGNF4
line 2121
;2121:	p->accel[1] = crandom () * 4;
ADDRLP4 56
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1082130432
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
MULF4
ASGNF4
line 2123
;2122:	
;2123:}
LABELV $1659
endproc CG_ParticleSparks 60 0
export CG_ParticleDust
proc CG_ParticleDust 120 16
line 2126
;2124:
;2125:void CG_ParticleDust (centity_t *cent, vec3_t origin, vec3_t dir)
;2126:{
line 2135
;2127:	float	length;
;2128:	float	dist;
;2129:	float	crittersize;
;2130:	vec3_t	angles, forward;
;2131:	vec3_t	point;
;2132:	cparticle_t	*p;
;2133:	int		i;
;2134:	
;2135:	dist = 0;
ADDRLP4 40
CNSTF4 0
ASGNF4
line 2137
;2136:
;2137:	VectorNegate (dir, dir);
ADDRLP4 56
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 60
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 64
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRF4
NEGF4
ASGNF4
line 2138
;2138:	length = VectorLength (dir);
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 32
ADDRLP4 68
INDIRF4
ASGNF4
line 2139
;2139:	vectoangles (dir, angles);
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 44
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2140
;2140:	AngleVectors (angles, forward, NULL, NULL);
ADDRLP4 44
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 72
CNSTP4 0
ASGNP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 2142
;2141:
;2142:	crittersize = LARGESIZE;
ADDRLP4 16
CNSTF4 1107296256
ASGNF4
line 2144
;2143:
;2144:	if (length)
ADDRLP4 32
INDIRF4
CNSTF4 0
EQF4 $1668
line 2145
;2145:		dist = length / crittersize;
ADDRLP4 40
ADDRLP4 32
INDIRF4
ADDRLP4 16
INDIRF4
DIVF4
ASGNF4
LABELV $1668
line 2147
;2146:
;2147:	if (dist < 1)
ADDRLP4 40
INDIRF4
CNSTF4 1065353216
GEF4 $1670
line 2148
;2148:		dist = 1;
ADDRLP4 40
CNSTF4 1065353216
ASGNF4
LABELV $1670
line 2150
;2149:
;2150:	VectorCopy (origin, point);
ADDRLP4 4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 2152
;2151:
;2152:	for (i=0; i<dist; i++)
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRGP4 $1675
JUMPV
LABELV $1672
line 2153
;2153:	{
line 2154
;2154:		VectorMA (point, crittersize, forward, point);	
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 20
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 4+4
INDIRF4
ADDRLP4 20+4
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRLP4 20+8
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDF4
ASGNF4
line 2156
;2155:				
;2156:		if (!free_particles)
ADDRGP4 free_particles
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1682
line 2157
;2157:			return;
ADDRGP4 $1667
JUMPV
LABELV $1682
line 2159
;2158:
;2159:		p = free_particles;
ADDRLP4 0
ADDRGP4 free_particles
INDIRP4
ASGNP4
line 2160
;2160:		free_particles = p->next;
ADDRGP4 free_particles
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 2161
;2161:		p->next = active_particles;
ADDRLP4 0
INDIRP4
ADDRGP4 active_particles
INDIRP4
ASGNP4
line 2162
;2162:		active_particles = p;
ADDRGP4 active_particles
ADDRLP4 0
INDIRP4
ASGNP4
line 2164
;2163:
;2164:		p->time = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ASGNF4
line 2165
;2165:		p->alpha = 5.0;
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 1084227584
ASGNF4
line 2166
;2166:		p->alphavel = 0;
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 0
ASGNF4
line 2167
;2167:		p->roll = 0;
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
CNSTI4 0
ASGNI4
line 2169
;2168:
;2169:		p->pshader = cgs.media.smokePuffShader;
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ADDRGP4 cgs+156680+332
INDIRI4
ASGNI4
line 2172
;2170:
;2171:		// RF, stay around for long enough to expand and dissipate naturally
;2172:		if (length)
ADDRLP4 32
INDIRF4
CNSTF4 0
EQF4 $1687
line 2173
;2173:			p->endtime = cg.time + 4500 + (crandom() * 3500);
ADDRLP4 80
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 4500
ADDI4
CVIF4 4
CNSTF4 1163575296
CNSTF4 1073741824
ADDRLP4 80
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
ASGNF4
ADDRGP4 $1688
JUMPV
LABELV $1687
line 2175
;2174:		else
;2175:			p->endtime = cg.time + 750 + (crandom() * 500);
ADDRLP4 84
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 750
ADDI4
CVIF4 4
CNSTF4 1140457472
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
ADDF4
ASGNF4
LABELV $1688
line 2177
;2176:		
;2177:		p->startfade = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ASGNF4
line 2179
;2178:		
;2179:		p->width = LARGESIZE;
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
CNSTF4 1107296256
ASGNF4
line 2180
;2180:		p->height = LARGESIZE;
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
CNSTF4 1107296256
ASGNF4
line 2183
;2181:
;2182:		// RF, expand while falling
;2183:		p->endheight = LARGESIZE*3.0;
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
CNSTF4 1119879168
ASGNF4
line 2184
;2184:		p->endwidth = LARGESIZE*3.0;
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
CNSTF4 1119879168
ASGNF4
line 2186
;2185:
;2186:		if (!length)
ADDRLP4 32
INDIRF4
CNSTF4 0
NEF4 $1692
line 2187
;2187:		{
line 2188
;2188:			p->width *= 0.2f;
ADDRLP4 88
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTF4 1045220557
ADDRLP4 88
INDIRP4
INDIRF4
MULF4
ASGNF4
line 2189
;2189:			p->height *= 0.2f;
ADDRLP4 92
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTF4 1045220557
ADDRLP4 92
INDIRP4
INDIRF4
MULF4
ASGNF4
line 2191
;2190:
;2191:			p->endheight = NORMALSIZE;
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
CNSTF4 1098907648
ASGNF4
line 2192
;2192:			p->endwidth = NORMALSIZE;
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
CNSTF4 1098907648
ASGNF4
line 2193
;2193:		}
LABELV $1692
line 2195
;2194:
;2195:		p->type = P_SMOKE;
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 3
ASGNI4
line 2197
;2196:
;2197:		VectorCopy( point, p->org );
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 4
INDIRB
ASGNB 12
line 2199
;2198:		
;2199:		p->vel[0] = crandom()*6;
ADDRLP4 88
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 1086324736
CNSTF4 1073741824
ADDRLP4 88
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
ASGNF4
line 2200
;2200:		p->vel[1] = crandom()*6;
ADDRLP4 92
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1086324736
CNSTF4 1073741824
ADDRLP4 92
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
ASGNF4
line 2201
;2201:		p->vel[2] = random()*20;
ADDRLP4 96
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1101004800
ADDRLP4 96
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ASGNF4
line 2204
;2202:
;2203:		// RF, add some gravity/randomness
;2204:		p->accel[0] = crandom()*3;
ADDRLP4 100
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1077936128
CNSTF4 1073741824
ADDRLP4 100
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
ASGNF4
line 2205
;2205:		p->accel[1] = crandom()*3;
ADDRLP4 104
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1077936128
CNSTF4 1073741824
ADDRLP4 104
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
ASGNF4
line 2206
;2206:		p->accel[2] = -PARTICLE_GRAVITY*0.4;
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTF4 3246391296
ASGNF4
line 2208
;2207:
;2208:		VectorClear( p->accel );
ADDRLP4 112
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 112
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 112
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 112
INDIRF4
ASGNF4
line 2210
;2209:
;2210:		p->rotate = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
CNSTI4 0
ASGNI4
line 2212
;2211:
;2212:		p->roll = rand()%179;
ADDRLP4 116
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 116
INDIRI4
CNSTI4 179
MODI4
ASGNI4
line 2214
;2213:		
;2214:		p->alpha = 0.75;
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 1061158912
ASGNF4
line 2216
;2215:		
;2216:	}
LABELV $1673
line 2152
ADDRLP4 36
ADDRLP4 36
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1675
ADDRLP4 36
INDIRI4
CVIF4 4
ADDRLP4 40
INDIRF4
LTF4 $1672
line 2219
;2217:
;2218:	
;2219:}
LABELV $1667
endproc CG_ParticleDust 120 16
export CG_ParticleMisc
proc CG_ParticleMisc 8 4
line 2222
;2220:
;2221:void CG_ParticleMisc (qhandle_t pshader, vec3_t origin, int size, int duration, float alpha)
;2222:{
line 2225
;2223:	cparticle_t	*p;
;2224:
;2225:	if (!pshader)
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $1695
line 2226
;2226:		CG_Printf ("CG_ParticleImpactSmokePuff pshader == ZERO!\n");
ADDRGP4 $1530
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $1695
line 2228
;2227:
;2228:	if (!free_particles)
ADDRGP4 free_particles
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1697
line 2229
;2229:		return;
ADDRGP4 $1694
JUMPV
LABELV $1697
line 2231
;2230:
;2231:	p = free_particles;
ADDRLP4 0
ADDRGP4 free_particles
INDIRP4
ASGNP4
line 2232
;2232:	free_particles = p->next;
ADDRGP4 free_particles
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 2233
;2233:	p->next = active_particles;
ADDRLP4 0
INDIRP4
ADDRGP4 active_particles
INDIRP4
ASGNP4
line 2234
;2234:	active_particles = p;
ADDRGP4 active_particles
ADDRLP4 0
INDIRP4
ASGNP4
line 2235
;2235:	p->time = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ASGNF4
line 2236
;2236:	p->alpha = 1.0;
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 1065353216
ASGNF4
line 2237
;2237:	p->alphavel = 0;
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 0
ASGNF4
line 2238
;2238:	p->roll = rand()%179;
ADDRLP4 4
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 179
MODI4
ASGNI4
line 2240
;2239:
;2240:	p->pshader = pshader;
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 2242
;2241:
;2242:	if (duration > 0)
ADDRFP4 12
INDIRI4
CNSTI4 0
LEI4 $1700
line 2243
;2243:		p->endtime = cg.time + duration;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 12
INDIRI4
ADDI4
CVIF4 4
ASGNF4
ADDRGP4 $1701
JUMPV
LABELV $1700
line 2245
;2244:	else
;2245:		p->endtime = duration;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 12
INDIRI4
CVIF4 4
ASGNF4
LABELV $1701
line 2247
;2246:
;2247:	p->startfade = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ASGNF4
line 2249
;2248:
;2249:	p->width = size;
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
ADDRFP4 8
INDIRI4
CVIF4 4
ASGNF4
line 2250
;2250:	p->height = size;
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
ADDRFP4 8
INDIRI4
CVIF4 4
ASGNF4
line 2252
;2251:
;2252:	p->endheight = size;
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
ADDRFP4 8
INDIRI4
CVIF4 4
ASGNF4
line 2253
;2253:	p->endwidth = size;
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
ADDRFP4 8
INDIRI4
CVIF4 4
ASGNF4
line 2255
;2254:
;2255:	p->type = P_SPRITE;
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 15
ASGNI4
line 2257
;2256:
;2257:	VectorCopy( origin, p->org );
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 2259
;2258:
;2259:	p->rotate = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
CNSTI4 0
ASGNI4
line 2260
;2260:}
LABELV $1694
endproc CG_ParticleMisc 8 4
bss
export oldtime
align 4
LABELV oldtime
skip 4
export rup
align 4
LABELV rup
skip 12
export rright
align 4
LABELV rright
skip 12
export rforward
align 4
LABELV rforward
skip 12
export pvup
align 4
LABELV pvup
skip 12
export pvright
align 4
LABELV pvright
skip 12
export pvforward
align 4
LABELV pvforward
skip 12
export particles
align 4
LABELV particles
skip 126976
export free_particles
align 4
LABELV free_particles
skip 4
export active_particles
align 4
LABELV active_particles
skip 4
align 4
LABELV numShaderAnims
skip 4
align 4
LABELV shaderAnims
skip 8192
align 4
LABELV markTotal
skip 4
export cg_freeMarkPolys
align 4
LABELV cg_freeMarkPolys
skip 4
export cg_activeMarkPolys
align 4
LABELV cg_activeMarkPolys
skip 288
import trap_Trace
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
export cg_markPolys
align 4
LABELV cg_markPolys
skip 73728
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
LABELV $1630
byte 1 67
byte 1 71
byte 1 95
byte 1 66
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 80
byte 1 111
byte 1 111
byte 1 108
byte 1 32
byte 1 112
byte 1 115
byte 1 104
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 32
byte 1 61
byte 1 61
byte 1 32
byte 1 90
byte 1 69
byte 1 82
byte 1 79
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $1576
byte 1 67
byte 1 71
byte 1 95
byte 1 79
byte 1 105
byte 1 108
byte 1 83
byte 1 108
byte 1 105
byte 1 99
byte 1 107
byte 1 82
byte 1 101
byte 1 118
byte 1 111
byte 1 118
byte 1 101
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 105
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1562
byte 1 67
byte 1 71
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 116
byte 1 105
byte 1 99
byte 1 108
byte 1 101
byte 1 95
byte 1 79
byte 1 105
byte 1 108
byte 1 83
byte 1 108
byte 1 105
byte 1 99
byte 1 107
byte 1 32
byte 1 61
byte 1 61
byte 1 32
byte 1 90
byte 1 69
byte 1 82
byte 1 79
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $1554
byte 1 67
byte 1 71
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 116
byte 1 105
byte 1 99
byte 1 108
byte 1 101
byte 1 95
byte 1 79
byte 1 105
byte 1 108
byte 1 80
byte 1 97
byte 1 114
byte 1 116
byte 1 105
byte 1 99
byte 1 108
byte 1 101
byte 1 32
byte 1 61
byte 1 61
byte 1 32
byte 1 90
byte 1 69
byte 1 82
byte 1 79
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $1540
byte 1 67
byte 1 71
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 116
byte 1 105
byte 1 99
byte 1 108
byte 1 101
byte 1 95
byte 1 66
byte 1 108
byte 1 101
byte 1 101
byte 1 100
byte 1 32
byte 1 112
byte 1 115
byte 1 104
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 32
byte 1 61
byte 1 61
byte 1 32
byte 1 90
byte 1 69
byte 1 82
byte 1 79
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $1530
byte 1 67
byte 1 71
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 116
byte 1 105
byte 1 99
byte 1 108
byte 1 101
byte 1 73
byte 1 109
byte 1 112
byte 1 97
byte 1 99
byte 1 116
byte 1 83
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 80
byte 1 117
byte 1 102
byte 1 102
byte 1 32
byte 1 112
byte 1 115
byte 1 104
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 32
byte 1 61
byte 1 61
byte 1 32
byte 1 90
byte 1 69
byte 1 82
byte 1 79
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $1470
byte 1 67
byte 1 71
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 116
byte 1 105
byte 1 99
byte 1 108
byte 1 101
byte 1 69
byte 1 120
byte 1 112
byte 1 108
byte 1 111
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 58
byte 1 32
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $1461
byte 1 67
byte 1 71
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 116
byte 1 105
byte 1 99
byte 1 108
byte 1 101
byte 1 69
byte 1 120
byte 1 112
byte 1 108
byte 1 111
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 58
byte 1 32
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 83
byte 1 116
byte 1 114
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 112
byte 1 114
byte 1 111
byte 1 98
byte 1 97
byte 1 98
byte 1 108
byte 1 121
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 105
byte 1 110
byte 1 100
byte 1 101
byte 1 120
byte 1 32
byte 1 114
byte 1 97
byte 1 116
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 110
byte 1 32
byte 1 97
byte 1 32
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $1442
byte 1 67
byte 1 71
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 116
byte 1 105
byte 1 99
byte 1 108
byte 1 101
byte 1 83
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 32
byte 1 61
byte 1 61
byte 1 32
byte 1 90
byte 1 69
byte 1 82
byte 1 79
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $1421
byte 1 67
byte 1 71
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 116
byte 1 105
byte 1 99
byte 1 108
byte 1 101
byte 1 83
byte 1 110
byte 1 111
byte 1 119
byte 1 32
byte 1 112
byte 1 115
byte 1 104
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 32
byte 1 61
byte 1 61
byte 1 32
byte 1 90
byte 1 69
byte 1 82
byte 1 79
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $1406
byte 1 67
byte 1 71
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 116
byte 1 105
byte 1 99
byte 1 108
byte 1 101
byte 1 83
byte 1 110
byte 1 111
byte 1 119
byte 1 70
byte 1 108
byte 1 117
byte 1 114
byte 1 114
byte 1 121
byte 1 32
byte 1 112
byte 1 115
byte 1 104
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 32
byte 1 61
byte 1 61
byte 1 32
byte 1 90
byte 1 69
byte 1 82
byte 1 79
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $273
byte 1 37
byte 1 115
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $255
byte 1 101
byte 1 120
byte 1 112
byte 1 108
byte 1 111
byte 1 100
byte 1 101
byte 1 49
byte 1 0
align 1
LABELV $105
byte 1 67
byte 1 71
byte 1 95
byte 1 73
byte 1 109
byte 1 112
byte 1 97
byte 1 99
byte 1 116
byte 1 77
byte 1 97
byte 1 114
byte 1 107
byte 1 32
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 60
byte 1 61
byte 1 32
byte 1 48
byte 1 32
byte 1 114
byte 1 97
byte 1 100
byte 1 105
byte 1 117
byte 1 115
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
