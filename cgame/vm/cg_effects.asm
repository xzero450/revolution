export CG_BubbleTrail
code
proc CG_BubbleTrail 96 4
file "../cg_effects.c"
line 16
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_effects.c -- these functions generate localentities, usually as a result
;4:// of event processing
;5:
;6:#include "cg_local.h"
;7:
;8:
;9:/*
;10:==================
;11:CG_BubbleTrail
;12:
;13:Bullets shot underwater
;14:==================
;15:*/
;16:void CG_BubbleTrail( vec3_t start, vec3_t end, float spacing ) {
line 22
;17:	vec3_t		move;
;18:	vec3_t		vec;
;19:	float		len;
;20:	int			i;
;21:
;22:	if ( cg_noProjectileTrail.integer ) {
ADDRGP4 cg_noProjectileTrail+12
INDIRI4
CNSTI4 0
EQI4 $78
line 23
;23:		return;
ADDRGP4 $77
JUMPV
LABELV $78
line 26
;24:	}
;25:
;26:	VectorCopy (start, move);
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 27
;27:	VectorSubtract (end, start, vec);
ADDRLP4 32
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 36
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 40
CNSTI4 4
ASGNI4
ADDRLP4 12+4
ADDRLP4 32
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
CNSTI4 8
ASGNI4
ADDRLP4 12+8
ADDRFP4 4
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
line 28
;28:	len = VectorNormalize (vec);
ADDRLP4 12
ARGP4
ADDRLP4 48
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 48
INDIRF4
ASGNF4
line 31
;29:
;30:	// advance a random amount first
;31:	i = rand() % (int)spacing;
ADDRLP4 52
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 52
INDIRI4
ADDRFP4 8
INDIRF4
CVFI4 4
MODI4
ASGNI4
line 32
;32:	VectorMA( move, i, vec, move );
ADDRLP4 56
ADDRLP4 24
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
ADDRLP4 56
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 12+4
INDIRF4
ADDRLP4 56
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 12+8
INDIRF4
ADDRLP4 24
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 34
;33:
;34:	VectorScale (vec, spacing, vec);
ADDRLP4 60
ADDRFP4 8
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 60
INDIRF4
MULF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 60
INDIRF4
MULF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
ADDRFP4 8
INDIRF4
MULF4
ASGNF4
line 36
;35:
;36:	for ( ; i < len; i += spacing ) {
ADDRGP4 $96
JUMPV
LABELV $93
line 40
;37:		localEntity_t	*le;
;38:		refEntity_t		*re;
;39:
;40:		le = CG_AllocLocalEntity();
ADDRLP4 72
ADDRGP4 CG_AllocLocalEntity
CALLP4
ASGNP4
ADDRLP4 64
ADDRLP4 72
INDIRP4
ASGNP4
line 41
;41:		le->leFlags = LEF_PUFF_DONT_SCALE;
ADDRLP4 64
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 1
ASGNI4
line 42
;42:		le->leType = LE_MOVE_SCALE_FADE;
ADDRLP4 64
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 4
ASGNI4
line 43
;43:		le->startTime = cg.time;
ADDRLP4 64
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 44
;44:		le->endTime = cg.time + 1000 + random() * 250;
ADDRLP4 76
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 64
INDIRP4
CNSTI4 20
ADDP4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 1000
ADDI4
CVIF4 4
CNSTF4 1132068864
ADDRLP4 76
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 45
;45:		le->lifeRate = 1.0 / ( le->endTime - le->startTime );
ADDRLP4 64
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1065353216
ADDRLP4 64
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ADDRLP4 64
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 47
;46:
;47:		re = &le->refEntity;
ADDRLP4 68
ADDRLP4 64
INDIRP4
CNSTI4 152
ADDP4
ASGNP4
line 48
;48:		re->shaderTime = cg.time / 1000.0f;
ADDRLP4 68
INDIRP4
CNSTI4 128
ADDP4
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
CNSTF4 1148846080
DIVF4
ASGNF4
line 50
;49:
;50:		re->reType = RT_SPRITE;
ADDRLP4 68
INDIRP4
CNSTI4 2
ASGNI4
line 51
;51:		re->rotation = 0;
ADDRLP4 68
INDIRP4
CNSTI4 136
ADDP4
CNSTF4 0
ASGNF4
line 52
;52:		re->radius = 3;
ADDRLP4 68
INDIRP4
CNSTI4 132
ADDP4
CNSTF4 1077936128
ASGNF4
line 53
;53:		re->customShader = cgs.media.waterBubbleShader;
ADDRLP4 68
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+156680+348
INDIRI4
ASGNI4
line 54
;54:		re->shaderRGBA[0] = 0xff;
ADDRLP4 68
INDIRP4
CNSTI4 116
ADDP4
CNSTU1 255
ASGNU1
line 55
;55:		re->shaderRGBA[1] = 0xff;
ADDRLP4 68
INDIRP4
CNSTI4 117
ADDP4
CNSTU1 255
ASGNU1
line 56
;56:		re->shaderRGBA[2] = 0xff;
ADDRLP4 68
INDIRP4
CNSTI4 118
ADDP4
CNSTU1 255
ASGNU1
line 57
;57:		re->shaderRGBA[3] = 0xff;
ADDRLP4 68
INDIRP4
CNSTI4 119
ADDP4
CNSTU1 255
ASGNU1
line 59
;58:
;59:		le->color[3] = 1.0;
ADDRLP4 64
INDIRP4
CNSTI4 120
ADDP4
CNSTF4 1065353216
ASGNF4
line 61
;60:
;61:		le->pos.trType = TR_LINEAR;
ADDRLP4 64
INDIRP4
CNSTI4 32
ADDP4
CNSTI4 2
ASGNI4
line 62
;62:		le->pos.trTime = cg.time;
ADDRLP4 64
INDIRP4
CNSTI4 36
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 63
;63:		VectorCopy( move, le->pos.trBase );
ADDRLP4 64
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 0
INDIRB
ASGNB 12
line 64
;64:		le->pos.trDelta[0] = crandom()*5;
ADDRLP4 84
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 64
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 1084227584
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
ASGNF4
line 65
;65:		le->pos.trDelta[1] = crandom()*5;
ADDRLP4 88
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 64
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 1084227584
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
line 66
;66:		le->pos.trDelta[2] = crandom()*5 + 6;
ADDRLP4 92
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 64
INDIRP4
CNSTI4 64
ADDP4
CNSTF4 1084227584
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
CNSTF4 1086324736
ADDF4
ASGNF4
line 68
;67:
;68:		VectorAdd (move, vec, move);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 12+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 12+8
INDIRF4
ADDF4
ASGNF4
line 69
;69:	}
LABELV $94
line 36
ADDRLP4 24
ADDRLP4 24
INDIRI4
CVIF4 4
ADDRFP4 8
INDIRF4
ADDF4
CVFI4 4
ASGNI4
LABELV $96
ADDRLP4 24
INDIRI4
CVIF4 4
ADDRLP4 28
INDIRF4
LTF4 $93
line 70
;70:}
LABELV $77
endproc CG_BubbleTrail 96 4
data
align 4
LABELV $110
byte 4 146
export CG_SmokePuff
code
proc CG_SmokePuff 52 4
line 86
;71:
;72:/*
;73:=====================
;74:CG_SmokePuff
;75:
;76:Adds a smoke puff or blood trail localEntity.
;77:=====================
;78:*/
;79:localEntity_t *CG_SmokePuff( const vec3_t p, const vec3_t vel, 
;80:				   float radius,
;81:				   float r, float g, float b, float a,
;82:				   float duration,
;83:				   int startTime,
;84:				   int fadeInTime,
;85:				   int leFlags,
;86:				   qhandle_t hShader ) {
line 92
;87:	static int	seed = 0x92;
;88:	localEntity_t	*le;
;89:	refEntity_t		*re;
;90://	int fadeInTime = startTime + duration / 2;
;91:
;92:	le = CG_AllocLocalEntity();
ADDRLP4 8
ADDRGP4 CG_AllocLocalEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 93
;93:	le->leFlags = leFlags;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 40
INDIRI4
ASGNI4
line 94
;94:	le->radius = radius;
ADDRLP4 0
INDIRP4
CNSTI4 124
ADDP4
ADDRFP4 8
INDIRF4
ASGNF4
line 96
;95:
;96:	re = &le->refEntity;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
ASGNP4
line 97
;97:	re->rotation = Q_random( &seed ) * 360;
ADDRGP4 $110
ARGP4
ADDRLP4 12
ADDRGP4 Q_random
CALLF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 136
ADDP4
CNSTF4 1135869952
ADDRLP4 12
INDIRF4
MULF4
ASGNF4
line 98
;98:	re->radius = radius;
ADDRLP4 4
INDIRP4
CNSTI4 132
ADDP4
ADDRFP4 8
INDIRF4
ASGNF4
line 99
;99:	re->shaderTime = startTime / 1000.0f;
ADDRLP4 4
INDIRP4
CNSTI4 128
ADDP4
ADDRFP4 32
INDIRI4
CVIF4 4
CNSTF4 1148846080
DIVF4
ASGNF4
line 101
;100:
;101:	le->leType = LE_MOVE_SCALE_FADE;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 4
ASGNI4
line 102
;102:	le->startTime = startTime;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRFP4 32
INDIRI4
ASGNI4
line 103
;103:	le->fadeInTime = fadeInTime;
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRFP4 36
INDIRI4
ASGNI4
line 104
;104:	le->endTime = startTime + duration;
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRFP4 32
INDIRI4
CVIF4 4
ADDRFP4 28
INDIRF4
ADDF4
CVFI4 4
ASGNI4
line 105
;105:	if ( fadeInTime > startTime ) {
ADDRFP4 36
INDIRI4
ADDRFP4 32
INDIRI4
LEI4 $111
line 106
;106:		le->lifeRate = 1.0 / ( le->endTime - le->fadeInTime );
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1065353216
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 107
;107:	} else {
ADDRGP4 $112
JUMPV
LABELV $111
line 108
;108:		le->lifeRate = 1.0 / ( le->endTime - le->startTime );
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1065353216
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 109
;109:	}
LABELV $112
line 110
;110:	le->color[0] = r;
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
ADDRFP4 12
INDIRF4
ASGNF4
line 111
;111:	le->color[1] = g; 
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRFP4 16
INDIRF4
ASGNF4
line 112
;112:	le->color[2] = b;
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ADDRFP4 20
INDIRF4
ASGNF4
line 113
;113:	le->color[3] = a;
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
ADDRFP4 24
INDIRF4
ASGNF4
line 116
;114:
;115:
;116:	le->pos.trType = TR_LINEAR;
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTI4 2
ASGNI4
line 117
;117:	le->pos.trTime = startTime;
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 32
INDIRI4
ASGNI4
line 118
;118:	VectorCopy( vel, le->pos.trDelta );
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 119
;119:	VectorCopy( p, le->pos.trBase );
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 121
;120:
;121:	VectorCopy( p, re->origin );
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 122
;122:	re->customShader = hShader;
ADDRLP4 4
INDIRP4
CNSTI4 112
ADDP4
ADDRFP4 44
INDIRI4
ASGNI4
line 125
;123:
;124:	// rage pro can't alpha fade, so use a different shader
;125:	if ( cgs.glconfig.hardwareType == GLHW_RAGEPRO ) {
ADDRGP4 cgs+20100+11288
INDIRI4
CNSTI4 3
NEI4 $113
line 126
;126:		re->customShader = cgs.media.smokePuffRageProShader;
ADDRLP4 4
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+156680+336
INDIRI4
ASGNI4
line 127
;127:		re->shaderRGBA[0] = 0xff;
ADDRLP4 4
INDIRP4
CNSTI4 116
ADDP4
CNSTU1 255
ASGNU1
line 128
;128:		re->shaderRGBA[1] = 0xff;
ADDRLP4 4
INDIRP4
CNSTI4 117
ADDP4
CNSTU1 255
ASGNU1
line 129
;129:		re->shaderRGBA[2] = 0xff;
ADDRLP4 4
INDIRP4
CNSTI4 118
ADDP4
CNSTU1 255
ASGNU1
line 130
;130:		re->shaderRGBA[3] = 0xff;
ADDRLP4 4
INDIRP4
CNSTI4 119
ADDP4
CNSTU1 255
ASGNU1
line 131
;131:	} else {
ADDRGP4 $114
JUMPV
LABELV $113
line 132
;132:		re->shaderRGBA[0] = le->color[0] * 0xff;
ADDRLP4 20
CNSTF4 1132396544
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 24
CNSTF4 1325400064
ASGNF4
ADDRLP4 20
INDIRF4
ADDRLP4 24
INDIRF4
LTF4 $120
ADDRLP4 16
ADDRLP4 20
INDIRF4
ADDRLP4 24
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $121
JUMPV
LABELV $120
ADDRLP4 16
ADDRLP4 20
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $121
ADDRLP4 4
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 16
INDIRU4
CVUU1 4
ASGNU1
line 133
;133:		re->shaderRGBA[1] = le->color[1] * 0xff;
ADDRLP4 32
CNSTF4 1132396544
ADDRLP4 0
INDIRP4
CNSTI4 112
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
LTF4 $123
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
ADDRGP4 $124
JUMPV
LABELV $123
ADDRLP4 28
ADDRLP4 32
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $124
ADDRLP4 4
INDIRP4
CNSTI4 117
ADDP4
ADDRLP4 28
INDIRU4
CVUU1 4
ASGNU1
line 134
;134:		re->shaderRGBA[2] = le->color[2] * 0xff;
ADDRLP4 44
CNSTF4 1132396544
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 48
CNSTF4 1325400064
ASGNF4
ADDRLP4 44
INDIRF4
ADDRLP4 48
INDIRF4
LTF4 $126
ADDRLP4 40
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
ADDRGP4 $127
JUMPV
LABELV $126
ADDRLP4 40
ADDRLP4 44
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $127
ADDRLP4 4
INDIRP4
CNSTI4 118
ADDP4
ADDRLP4 40
INDIRU4
CVUU1 4
ASGNU1
line 135
;135:		re->shaderRGBA[3] = 0xff;
ADDRLP4 4
INDIRP4
CNSTI4 119
ADDP4
CNSTU1 255
ASGNU1
line 136
;136:	}
LABELV $114
line 138
;137:
;138:	re->reType = RT_SPRITE;
ADDRLP4 4
INDIRP4
CNSTI4 2
ASGNI4
line 139
;139:	re->radius = le->radius;
ADDRLP4 4
INDIRP4
CNSTI4 132
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
ASGNF4
line 141
;140:
;141:	return le;
ADDRLP4 0
INDIRP4
RETP4
LABELV $109
endproc CG_SmokePuff 52 4
export CG_SpawnEffect
proc CG_SpawnEffect 28 4
line 151
;142:}
;143:
;144:/*
;145:==================
;146:CG_SpawnEffect
;147:
;148:Player teleporting in or out
;149:==================
;150:*/
;151:void CG_SpawnEffect( vec3_t org ) {
line 155
;152:	localEntity_t	*le;
;153:	refEntity_t		*re;
;154:
;155:	le = CG_AllocLocalEntity();
ADDRLP4 8
ADDRGP4 CG_AllocLocalEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 156
;156:	le->leFlags = 0;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 157
;157:	le->leType = LE_FADE_RGB;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 6
ASGNI4
line 158
;158:	le->startTime = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 159
;159:	le->endTime = cg.time + 500;
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 160
;160:	le->lifeRate = 1.0 / ( le->endTime - le->startTime );
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1065353216
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 162
;161:
;162:	le->color[0] = le->color[1] = le->color[2] = le->color[3] = 1.0;
ADDRLP4 20
CNSTF4 1065353216
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
ADDRLP4 20
INDIRF4
ASGNF4
line 164
;163:
;164:	re = &le->refEntity;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
ASGNP4
line 166
;165:
;166:	re->reType = RT_MODEL;
ADDRLP4 4
INDIRP4
CNSTI4 0
ASGNI4
line 167
;167:	re->shaderTime = cg.time / 1000.0f;
ADDRLP4 4
INDIRP4
CNSTI4 128
ADDP4
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
CNSTF4 1148846080
DIVF4
ASGNF4
line 170
;168:
;169:#ifndef MISSIONPACK
;170:	re->customShader = cgs.media.teleportEffectShader;
ADDRLP4 4
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+156680+544
INDIRI4
ASGNI4
line 172
;171:#endif
;172:	re->hModel = cgs.media.teleportEffectModel;
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 cgs+156680+540
INDIRI4
ASGNI4
line 173
;173:	AxisClear( re->axis );
ADDRLP4 4
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRGP4 AxisClear
CALLV
pop
line 175
;174:
;175:	VectorCopy( org, re->origin );
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 179
;176:#ifdef MISSIONPACK
;177:	re->origin[2] += 16;
;178:#else
;179:	re->origin[2] -= 24;
ADDRLP4 24
ADDRLP4 4
INDIRP4
CNSTI4 76
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
CNSTF4 1103101952
SUBF4
ASGNF4
line 181
;180:#endif
;181:}
LABELV $128
endproc CG_SpawnEffect 28 4
bss
align 4
LABELV $137
skip 12
export CG_ScorePlum
code
proc CG_ScorePlum 48 8
line 366
;182:
;183:
;184:#ifdef MISSIONPACK
;185:/*
;186:===============
;187:CG_LightningBoltBeam
;188:===============
;189:*/
;190:void CG_LightningBoltBeam( vec3_t start, vec3_t end ) {
;191:	localEntity_t	*le;
;192:	refEntity_t		*beam;
;193:
;194:	le = CG_AllocLocalEntity();
;195:	le->leFlags = 0;
;196:	le->leType = LE_SHOWREFENTITY;
;197:	le->startTime = cg.time;
;198:	le->endTime = cg.time + 50;
;199:
;200:	beam = &le->refEntity;
;201:
;202:	VectorCopy( start, beam->origin );
;203:	// this is the end point
;204:	VectorCopy( end, beam->oldorigin );
;205:
;206:	beam->reType = RT_LIGHTNING;
;207:	beam->customShader = cgs.media.lightningShader;
;208:}
;209:
;210:/*
;211:==================
;212:CG_KamikazeEffect
;213:==================
;214:*/
;215:void CG_KamikazeEffect( vec3_t org ) {
;216:	localEntity_t	*le;
;217:	refEntity_t		*re;
;218:
;219:	le = CG_AllocLocalEntity();
;220:	le->leFlags = 0;
;221:	le->leType = LE_KAMIKAZE;
;222:	le->startTime = cg.time;
;223:	le->endTime = cg.time + 3000;//2250;
;224:	le->lifeRate = 1.0 / ( le->endTime - le->startTime );
;225:
;226:	le->color[0] = le->color[1] = le->color[2] = le->color[3] = 1.0;
;227:
;228:	VectorClear(le->angles.trBase);
;229:
;230:	re = &le->refEntity;
;231:
;232:	re->reType = RT_MODEL;
;233:	re->shaderTime = cg.time / 1000.0f;
;234:
;235:	re->hModel = cgs.media.kamikazeEffectModel;
;236:
;237:	VectorCopy( org, re->origin );
;238:
;239:}
;240:
;241:/*
;242:==================
;243:CG_ObeliskExplode
;244:==================
;245:*/
;246:void CG_ObeliskExplode( vec3_t org, int entityNum ) {
;247:	localEntity_t	*le;
;248:	vec3_t origin;
;249:
;250:	// create an explosion
;251:	VectorCopy( org, origin );
;252:	origin[2] += 64;
;253:	le = CG_MakeExplosion( origin, vec3_origin,
;254:						   cgs.media.dishFlashModel,
;255:						   cgs.media.rocketExplosionShader,
;256:						   600, qtrue );
;257:	le->light = 300;
;258:	le->lightColor[0] = 1;
;259:	le->lightColor[1] = 0.75;
;260:	le->lightColor[2] = 0.0;
;261:}
;262:
;263:/*
;264:==================
;265:CG_ObeliskPain
;266:==================
;267:*/
;268:void CG_ObeliskPain( vec3_t org ) {
;269:	float r;
;270:	sfxHandle_t sfx;
;271:
;272:	// hit sound
;273:	r = rand() & 3;
;274:	if ( r < 2 ) {
;275:		sfx = cgs.media.obeliskHitSound1;
;276:	} else if ( r == 2 ) {
;277:		sfx = cgs.media.obeliskHitSound2;
;278:	} else {
;279:		sfx = cgs.media.obeliskHitSound3;
;280:	}
;281:	trap_S_StartSound ( org, ENTITYNUM_NONE, CHAN_BODY, sfx );
;282:}
;283:
;284:
;285:/*
;286:==================
;287:CG_InvulnerabilityImpact
;288:==================
;289:*/
;290:void CG_InvulnerabilityImpact( vec3_t org, vec3_t angles ) {
;291:	localEntity_t	*le;
;292:	refEntity_t		*re;
;293:	int				r;
;294:	sfxHandle_t		sfx;
;295:
;296:	le = CG_AllocLocalEntity();
;297:	le->leFlags = 0;
;298:	le->leType = LE_INVULIMPACT;
;299:	le->startTime = cg.time;
;300:	le->endTime = cg.time + 1000;
;301:	le->lifeRate = 1.0 / ( le->endTime - le->startTime );
;302:
;303:	le->color[0] = le->color[1] = le->color[2] = le->color[3] = 1.0;
;304:
;305:	re = &le->refEntity;
;306:
;307:	re->reType = RT_MODEL;
;308:	re->shaderTime = cg.time / 1000.0f;
;309:
;310:	re->hModel = cgs.media.invulnerabilityImpactModel;
;311:
;312:	VectorCopy( org, re->origin );
;313:	AnglesToAxis( angles, re->axis );
;314:
;315:	r = rand() & 3;
;316:	if ( r < 2 ) {
;317:		sfx = cgs.media.invulnerabilityImpactSound1;
;318:	} else if ( r == 2 ) {
;319:		sfx = cgs.media.invulnerabilityImpactSound2;
;320:	} else {
;321:		sfx = cgs.media.invulnerabilityImpactSound3;
;322:	}
;323:	trap_S_StartSound (org, ENTITYNUM_NONE, CHAN_BODY, sfx );
;324:}
;325:
;326:/*
;327:==================
;328:CG_InvulnerabilityJuiced
;329:==================
;330:*/
;331:void CG_InvulnerabilityJuiced( vec3_t org ) {
;332:	localEntity_t	*le;
;333:	refEntity_t		*re;
;334:	vec3_t			angles;
;335:
;336:	le = CG_AllocLocalEntity();
;337:	le->leFlags = 0;
;338:	le->leType = LE_INVULJUICED;
;339:	le->startTime = cg.time;
;340:	le->endTime = cg.time + 10000;
;341:	le->lifeRate = 1.0 / ( le->endTime - le->startTime );
;342:
;343:	le->color[0] = le->color[1] = le->color[2] = le->color[3] = 1.0;
;344:
;345:	re = &le->refEntity;
;346:
;347:	re->reType = RT_MODEL;
;348:	re->shaderTime = cg.time / 1000.0f;
;349:
;350:	re->hModel = cgs.media.invulnerabilityJuicedModel;
;351:
;352:	VectorCopy( org, re->origin );
;353:	VectorClear(angles);
;354:	AnglesToAxis( angles, re->axis );
;355:
;356:	trap_S_StartSound (org, ENTITYNUM_NONE, CHAN_BODY, cgs.media.invulnerabilityJuicedSound );
;357:}
;358:
;359:#endif
;360:
;361:/*
;362:==================
;363:CG_ScorePlum
;364:==================
;365:*/
;366:void CG_ScorePlum( int client, vec3_t org, int score ) {
line 373
;367:	localEntity_t	*le;
;368:	refEntity_t		*re;
;369:	vec3_t			angles;
;370:	static vec3_t lastPos;
;371:
;372:	// only visualize for the client that scored
;373:	if (client != cg.predictedPlayerState.clientNum || cg_scorePlum.integer == 0) {
ADDRFP4 0
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $143
ADDRGP4 cg_scorePlum+12
INDIRI4
CNSTI4 0
NEI4 $138
LABELV $143
line 374
;374:		return;
ADDRGP4 $136
JUMPV
LABELV $138
line 377
;375:	}
;376:
;377:	le = CG_AllocLocalEntity();
ADDRLP4 20
ADDRGP4 CG_AllocLocalEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 378
;378:	le->leFlags = 0;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 379
;379:	le->leType = LE_SCOREPLUM;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 9
ASGNI4
line 380
;380:	le->startTime = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 381
;381:	le->endTime = cg.time + 4000;
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 4000
ADDI4
ASGNI4
line 382
;382:	le->lifeRate = 1.0 / ( le->endTime - le->startTime );
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1065353216
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 385
;383:
;384:	
;385:	le->color[0] = le->color[1] = le->color[2] = le->color[3] = 1.0;
ADDRLP4 32
CNSTF4 1065353216
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
ADDRLP4 32
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 32
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRLP4 32
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
ADDRLP4 32
INDIRF4
ASGNF4
line 386
;386:	le->radius = score;
ADDRLP4 0
INDIRP4
CNSTI4 124
ADDP4
ADDRFP4 8
INDIRI4
CVIF4 4
ASGNF4
line 388
;387:	
;388:	VectorCopy( org, le->pos.trBase );
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 389
;389:	if (org[2] >= lastPos[2] - 20 && org[2] <= lastPos[2] + 20) {
ADDRLP4 36
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
ADDRLP4 40
CNSTF4 1101004800
ASGNF4
ADDRLP4 36
INDIRF4
ADDRGP4 $137+8
INDIRF4
ADDRLP4 40
INDIRF4
SUBF4
LTF4 $146
ADDRLP4 36
INDIRF4
ADDRGP4 $137+8
INDIRF4
ADDRLP4 40
INDIRF4
ADDF4
GTF4 $146
line 390
;390:		le->pos.trBase[2] -= 20;
ADDRLP4 44
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
CNSTF4 1101004800
SUBF4
ASGNF4
line 391
;391:	}
LABELV $146
line 394
;392:
;393:	//CG_Printf( "Plum origin %i %i %i -- %i\n", (int)org[0], (int)org[1], (int)org[2], (int)Distance(org, lastPos));
;394:	VectorCopy(org, lastPos);
ADDRGP4 $137
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 397
;395:
;396:
;397:	re = &le->refEntity;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
ASGNP4
line 399
;398:
;399:	re->reType = RT_SPRITE;
ADDRLP4 4
INDIRP4
CNSTI4 2
ASGNI4
line 400
;400:	re->radius = 16;
ADDRLP4 4
INDIRP4
CNSTI4 132
ADDP4
CNSTF4 1098907648
ASGNF4
line 402
;401:
;402:	VectorClear(angles);
ADDRLP4 44
CNSTF4 0
ASGNF4
ADDRLP4 8+8
ADDRLP4 44
INDIRF4
ASGNF4
ADDRLP4 8+4
ADDRLP4 44
INDIRF4
ASGNF4
ADDRLP4 8
ADDRLP4 44
INDIRF4
ASGNF4
line 403
;403:	AnglesToAxis( angles, re->axis );
ADDRLP4 8
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 404
;404:}
LABELV $136
endproc CG_ScorePlum 48 8
export CG_MakeExplosion
proc CG_MakeExplosion 60 8
line 414
;405:
;406:
;407:/*
;408:====================
;409:CG_MakeExplosion
;410:====================
;411:*/
;412:localEntity_t *CG_MakeExplosion( vec3_t origin, vec3_t dir, 
;413:								qhandle_t hModel, qhandle_t shader,
;414:								int msec, qboolean isSprite ) {
line 420
;415:	float			ang;
;416:	localEntity_t	*ex;
;417:	int				offset;
;418:	vec3_t			tmpVec, newOrigin;
;419:
;420:	if ( msec <= 0 ) {
ADDRFP4 16
INDIRI4
CNSTI4 0
GTI4 $153
line 421
;421:		CG_Error( "CG_MakeExplosion: msec = %i", msec );
ADDRGP4 $155
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 422
;422:	}
LABELV $153
line 425
;423:
;424:	// skew the time a bit so they aren't all in sync
;425:	offset = rand() & 63;
ADDRLP4 36
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 36
INDIRI4
CNSTI4 63
BANDI4
ASGNI4
line 427
;426:
;427:	ex = CG_AllocLocalEntity();
ADDRLP4 40
ADDRGP4 CG_AllocLocalEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 40
INDIRP4
ASGNP4
line 428
;428:	if ( isSprite ) {
ADDRFP4 20
INDIRI4
CNSTI4 0
EQI4 $156
line 429
;429:		ex->leType = LE_SPRITE_EXPLOSION;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 2
ASGNI4
line 432
;430:
;431:		// randomly rotate sprite orientation
;432:		ex->refEntity.rotation = rand() % 360;
ADDRLP4 44
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRLP4 44
INDIRI4
CNSTI4 360
MODI4
CVIF4 4
ASGNF4
line 433
;433:		VectorScale( dir, 16, tmpVec );
ADDRLP4 48
CNSTF4 1098907648
ASGNF4
ADDRLP4 52
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 48
INDIRF4
ADDRLP4 52
INDIRP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 48
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 16+8
CNSTF4 1098907648
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ASGNF4
line 434
;434:		VectorAdd( tmpVec, origin, newOrigin );
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRF4
ADDRLP4 56
INDIRP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 16+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
ASGNF4
line 435
;435:	} else {
ADDRGP4 $157
JUMPV
LABELV $156
line 436
;436:		ex->leType = LE_EXPLOSION;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 1
ASGNI4
line 437
;437:		VectorCopy( origin, newOrigin );
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 440
;438:
;439:		// set axis with random rotate
;440:		if ( !dir ) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $164
line 441
;441:			AxisClear( ex->refEntity.axis );
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRGP4 AxisClear
CALLV
pop
line 442
;442:		} else {
ADDRGP4 $165
JUMPV
LABELV $164
line 443
;443:			ang = rand() % 360;
ADDRLP4 44
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 44
INDIRI4
CNSTI4 360
MODI4
CVIF4 4
ASGNF4
line 444
;444:			VectorCopy( dir, ex->refEntity.axis[0] );
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 445
;445:			RotateAroundDirection( ex->refEntity.axis, ang );
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 32
INDIRF4
ARGF4
ADDRGP4 RotateAroundDirection
CALLV
pop
line 446
;446:		}
LABELV $165
line 447
;447:	}
LABELV $157
line 449
;448:
;449:	ex->startTime = cg.time - offset;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 28
INDIRI4
SUBI4
ASGNI4
line 450
;450:	ex->endTime = ex->startTime + msec;
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ADDRFP4 16
INDIRI4
ADDI4
ASGNI4
line 453
;451:
;452:	// bias the time so all shader effects start correctly
;453:	ex->refEntity.shaderTime = ex->startTime / 1000.0f;
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1148846080
DIVF4
ASGNF4
line 455
;454:
;455:	ex->refEntity.hModel = hModel;
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 456
;456:	ex->refEntity.customShader = shader;
ADDRLP4 0
INDIRP4
CNSTI4 264
ADDP4
ADDRFP4 12
INDIRI4
ASGNI4
line 459
;457:
;458:	// set origin
;459:	VectorCopy( newOrigin, ex->refEntity.origin );
ADDRLP4 0
INDIRP4
CNSTI4 220
ADDP4
ADDRLP4 4
INDIRB
ASGNB 12
line 460
;460:	VectorCopy( newOrigin, ex->refEntity.oldorigin );
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
ADDRLP4 4
INDIRB
ASGNB 12
line 462
;461:
;462:	ex->color[0] = ex->color[1] = ex->color[2] = 1.0;
ADDRLP4 56
CNSTF4 1065353216
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 56
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRLP4 56
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
ADDRLP4 56
INDIRF4
ASGNF4
line 464
;463:
;464:	return ex;
ADDRLP4 0
INDIRP4
RETP4
LABELV $152
endproc CG_MakeExplosion 60 8
export CG_Bleed
proc CG_Bleed 20 0
line 475
;465:}
;466:
;467:
;468:/*
;469:=================
;470:CG_Bleed
;471:
;472:This is the spurt of blood when a character gets hit
;473:=================
;474:*/
;475:void CG_Bleed( vec3_t origin, int entityNum ) {
line 478
;476:	localEntity_t	*ex;
;477:
;478:	if ( !cg_blood.integer ) {
ADDRGP4 cg_blood+12
INDIRI4
CNSTI4 0
NEI4 $168
line 479
;479:		return;
ADDRGP4 $167
JUMPV
LABELV $168
line 482
;480:	}
;481:
;482:	ex = CG_AllocLocalEntity();
ADDRLP4 4
ADDRGP4 CG_AllocLocalEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 483
;483:	ex->leType = LE_EXPLOSION;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 1
ASGNI4
line 485
;484:
;485:	ex->startTime = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 486
;486:	ex->endTime = ex->startTime + 500;
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 488
;487:	
;488:	VectorCopy ( origin, ex->refEntity.origin);
ADDRLP4 0
INDIRP4
CNSTI4 220
ADDP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 489
;489:	ex->refEntity.reType = RT_SPRITE;
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
CNSTI4 2
ASGNI4
line 490
;490:	ex->refEntity.rotation = rand() % 360;
ADDRLP4 12
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDRLP4 12
INDIRI4
CNSTI4 360
MODI4
CVIF4 4
ASGNF4
line 491
;491:	ex->refEntity.radius = 24;
ADDRLP4 0
INDIRP4
CNSTI4 284
ADDP4
CNSTF4 1103101952
ASGNF4
line 493
;492:
;493:	ex->refEntity.customShader = cgs.media.bloodExplosionShader;
ADDRLP4 0
INDIRP4
CNSTI4 264
ADDP4
ADDRGP4 cgs+156680+536
INDIRI4
ASGNI4
line 496
;494:
;495:	// don't show player's own blood in view
;496:	if ( entityNum == cg.snap->ps.clientNum ) {
ADDRFP4 4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $174
line 497
;497:		ex->refEntity.renderfx |= RF_THIRD_PERSON;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 498
;498:	}
LABELV $174
line 499
;499:}
LABELV $167
endproc CG_Bleed 20 0
export CG_LaunchGib
proc CG_LaunchGib 32 8
line 508
;500:
;501:
;502:
;503:/*
;504:==================
;505:CG_LaunchGib
;506:==================
;507:*/
;508:void CG_LaunchGib( vec3_t origin, vec3_t velocity, qhandle_t hModel ) {
line 516
;509:	localEntity_t	*le;
;510:	refEntity_t		*re;
;511://freeze
;512:	int	num;
;513:	centity_t	*cent;
;514://freeze
;515:
;516:	le = CG_AllocLocalEntity();
ADDRLP4 16
ADDRGP4 CG_AllocLocalEntity
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 16
INDIRP4
ASGNP4
line 517
;517:	re = &le->refEntity;
ADDRLP4 12
ADDRLP4 8
INDIRP4
CNSTI4 152
ADDP4
ASGNP4
line 519
;518:
;519:	le->leType = LE_FRAGMENT;
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 3
ASGNI4
line 520
;520:	le->startTime = cg.time;
ADDRLP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 521
;521:	le->endTime = (cg_gibs.integer == -1)? cg.time : le->startTime + 5000 + random() * 3000;
ADDRGP4 cg_gibs+12
INDIRI4
CNSTI4 -1
NEI4 $182
ADDRLP4 20
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ASGNF4
ADDRGP4 $183
JUMPV
LABELV $182
ADDRLP4 24
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 8
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 5000
ADDI4
CVIF4 4
CNSTF4 1161527296
ADDRLP4 24
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
LABELV $183
ADDRLP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 20
INDIRF4
CVFI4 4
ASGNI4
line 523
;522:
;523:	VectorCopy( origin, re->origin );
ADDRLP4 12
INDIRP4
CNSTI4 68
ADDP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 524
;524:	AxisCopy( axisDefault, re->axis );
ADDRGP4 axisDefault
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRGP4 AxisCopy
CALLV
pop
line 525
;525:	re->hModel = hModel;
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 527
;526:
;527:	le->pos.trType = TR_GRAVITY;
ADDRLP4 8
INDIRP4
CNSTI4 32
ADDP4
CNSTI4 5
ASGNI4
line 528
;528:	VectorCopy( origin, le->pos.trBase );
ADDRLP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 529
;529:	VectorCopy( velocity, le->pos.trDelta );
ADDRLP4 8
INDIRP4
CNSTI4 56
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 530
;530:	le->pos.trTime = cg.time;
ADDRLP4 8
INDIRP4
CNSTI4 36
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 532
;531:
;532:	le->bounceFactor = 0.6f;
ADDRLP4 8
INDIRP4
CNSTI4 104
ADDP4
CNSTF4 1058642330
ASGNF4
line 534
;533:
;534:	le->leBounceSoundType = LEBS_BLOOD;
ADDRLP4 8
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 1
ASGNI4
line 535
;535:	le->leMarkType = LEMT_BLOOD;
ADDRLP4 8
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 2
ASGNI4
line 537
;536://freeze
;537:	if ( g_gamemode.integer > 3 ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $185
line 538
;538:		for ( num = 0; num < cg.snap->numEntities; num++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $191
JUMPV
LABELV $188
line 539
;539:			cent = &cg_entities[ cg.snap->entities[ num ].number ];
ADDRLP4 4
CNSTI4 728
CNSTI4 208
ADDRLP4 0
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
line 540
;540:			if ( cent->currentState.eventParm != 255 ) continue;
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 255
EQI4 $194
ADDRGP4 $189
JUMPV
LABELV $194
line 541
;541:			if ( VectorCompare( cent->lerpOrigin, origin ) ) {
ADDRLP4 4
INDIRP4
CNSTI4 704
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $196
line 542
;542:				re->customShader = cgs.media.freezeShader;
ADDRLP4 12
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+156680+448
INDIRI4
ASGNI4
line 543
;543:				break;
ADDRGP4 $190
JUMPV
LABELV $196
line 545
;544:			}
;545:		}
LABELV $189
line 538
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $191
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
LTI4 $188
LABELV $190
line 546
;546:	}
LABELV $185
line 548
;547://freeze
;548:}
LABELV $177
endproc CG_LaunchGib 32 8
export CG_GibPlayer
proc CG_GibPlayer 148 12
line 559
;549:
;550:/*
;551:===================
;552:CG_GibPlayer
;553:
;554:Generated a bunch of gibs launching out from the bodies location
;555:===================
;556:*/
;557:#define	GIB_VELOCITY	250
;558:#define	GIB_JUMP		250
;559:void CG_GibPlayer( vec3_t playerOrigin ) {
line 562
;560:	vec3_t	origin, velocity;
;561:
;562:	if ( !cg_blood.integer ) {
ADDRGP4 cg_blood+12
INDIRI4
CNSTI4 0
NEI4 $201
line 563
;563:		return;
ADDRGP4 $200
JUMPV
LABELV $201
line 566
;564:	}
;565:
;566:	VectorCopy( playerOrigin, origin );
ADDRLP4 12
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 567
;567:	velocity[0] = crandom()*GIB_VELOCITY;
ADDRLP4 24
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
CNSTF4 1132068864
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
ASGNF4
line 568
;568:	velocity[1] = crandom()*GIB_VELOCITY;
ADDRLP4 28
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+4
CNSTF4 1132068864
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
ASGNF4
line 569
;569:	velocity[2] = GIB_JUMP + crandom()*GIB_VELOCITY;
ADDRLP4 32
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+8
CNSTF4 1132068864
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
CNSTF4 1132068864
ADDF4
ASGNF4
line 570
;570:	if ( rand() & 1 ) {
ADDRLP4 36
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $206
line 571
;571:		CG_LaunchGib( origin, velocity, cgs.media.gibSkull );
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 cgs+156680+220
INDIRI4
ARGI4
ADDRGP4 CG_LaunchGib
CALLV
pop
line 572
;572:	} else {
ADDRGP4 $207
JUMPV
LABELV $206
line 573
;573:		CG_LaunchGib( origin, velocity, cgs.media.gibBrain );
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 cgs+156680+224
INDIRI4
ARGI4
ADDRGP4 CG_LaunchGib
CALLV
pop
line 574
;574:	}
LABELV $207
line 577
;575:
;576:	// allow gibs to be turned off for speed
;577:	if ( cg_gibs.integer < 1) {
ADDRGP4 cg_gibs+12
INDIRI4
CNSTI4 1
GEI4 $212
line 578
;578:		return;
ADDRGP4 $200
JUMPV
LABELV $212
line 581
;579:	}
;580:
;581:	VectorCopy( playerOrigin, origin );
ADDRLP4 12
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 582
;582:	velocity[0] = crandom()*GIB_VELOCITY;
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
CNSTF4 1132068864
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
ASGNF4
line 583
;583:	velocity[1] = crandom()*GIB_VELOCITY;
ADDRLP4 44
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+4
CNSTF4 1132068864
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
ASGNF4
line 584
;584:	velocity[2] = GIB_JUMP + crandom()*GIB_VELOCITY;
ADDRLP4 48
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+8
CNSTF4 1132068864
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
CNSTF4 1132068864
ADDF4
ASGNF4
line 585
;585:	CG_LaunchGib( origin, velocity, cgs.media.gibAbdomen );
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 cgs+156680+188
INDIRI4
ARGI4
ADDRGP4 CG_LaunchGib
CALLV
pop
line 587
;586:
;587:	VectorCopy( playerOrigin, origin );
ADDRLP4 12
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 588
;588:	velocity[0] = crandom()*GIB_VELOCITY;
ADDRLP4 52
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
CNSTF4 1132068864
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
line 589
;589:	velocity[1] = crandom()*GIB_VELOCITY;
ADDRLP4 56
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+4
CNSTF4 1132068864
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
line 590
;590:	velocity[2] = GIB_JUMP + crandom()*GIB_VELOCITY;
ADDRLP4 60
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+8
CNSTF4 1132068864
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
CNSTF4 1132068864
ADDF4
ASGNF4
line 591
;591:	CG_LaunchGib( origin, velocity, cgs.media.gibArm );
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 cgs+156680+192
INDIRI4
ARGI4
ADDRGP4 CG_LaunchGib
CALLV
pop
line 593
;592:
;593:	VectorCopy( playerOrigin, origin );
ADDRLP4 12
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 594
;594:	velocity[0] = crandom()*GIB_VELOCITY;
ADDRLP4 64
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
CNSTF4 1132068864
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
line 595
;595:	velocity[1] = crandom()*GIB_VELOCITY;
ADDRLP4 68
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+4
CNSTF4 1132068864
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
ASGNF4
line 596
;596:	velocity[2] = GIB_JUMP + crandom()*GIB_VELOCITY;
ADDRLP4 72
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+8
CNSTF4 1132068864
CNSTF4 1073741824
ADDRLP4 72
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
CNSTF4 1132068864
ADDF4
ASGNF4
line 597
;597:	CG_LaunchGib( origin, velocity, cgs.media.gibChest );
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 cgs+156680+196
INDIRI4
ARGI4
ADDRGP4 CG_LaunchGib
CALLV
pop
line 599
;598:
;599:	VectorCopy( playerOrigin, origin );
ADDRLP4 12
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 600
;600:	velocity[0] = crandom()*GIB_VELOCITY;
ADDRLP4 76
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
CNSTF4 1132068864
CNSTF4 1073741824
ADDRLP4 76
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
line 601
;601:	velocity[1] = crandom()*GIB_VELOCITY;
ADDRLP4 80
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+4
CNSTF4 1132068864
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
ASGNF4
line 602
;602:	velocity[2] = GIB_JUMP + crandom()*GIB_VELOCITY;
ADDRLP4 84
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+8
CNSTF4 1132068864
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
CNSTF4 1132068864
ADDF4
ASGNF4
line 603
;603:	CG_LaunchGib( origin, velocity, cgs.media.gibFist );
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 cgs+156680+200
INDIRI4
ARGI4
ADDRGP4 CG_LaunchGib
CALLV
pop
line 605
;604:
;605:	VectorCopy( playerOrigin, origin );
ADDRLP4 12
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 606
;606:	velocity[0] = crandom()*GIB_VELOCITY;
ADDRLP4 88
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
CNSTF4 1132068864
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
line 607
;607:	velocity[1] = crandom()*GIB_VELOCITY;
ADDRLP4 92
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+4
CNSTF4 1132068864
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
line 608
;608:	velocity[2] = GIB_JUMP + crandom()*GIB_VELOCITY;
ADDRLP4 96
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+8
CNSTF4 1132068864
CNSTF4 1073741824
ADDRLP4 96
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
CNSTF4 1132068864
ADDF4
ASGNF4
line 609
;609:	CG_LaunchGib( origin, velocity, cgs.media.gibFoot );
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 cgs+156680+204
INDIRI4
ARGI4
ADDRGP4 CG_LaunchGib
CALLV
pop
line 611
;610:
;611:	VectorCopy( playerOrigin, origin );
ADDRLP4 12
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 612
;612:	velocity[0] = crandom()*GIB_VELOCITY;
ADDRLP4 100
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
CNSTF4 1132068864
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
line 613
;613:	velocity[1] = crandom()*GIB_VELOCITY;
ADDRLP4 104
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+4
CNSTF4 1132068864
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
line 614
;614:	velocity[2] = GIB_JUMP + crandom()*GIB_VELOCITY;
ADDRLP4 108
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+8
CNSTF4 1132068864
CNSTF4 1073741824
ADDRLP4 108
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
CNSTF4 1132068864
ADDF4
ASGNF4
line 615
;615:	CG_LaunchGib( origin, velocity, cgs.media.gibForearm );
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 cgs+156680+208
INDIRI4
ARGI4
ADDRGP4 CG_LaunchGib
CALLV
pop
line 617
;616:
;617:	VectorCopy( playerOrigin, origin );
ADDRLP4 12
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 618
;618:	velocity[0] = crandom()*GIB_VELOCITY;
ADDRLP4 112
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
CNSTF4 1132068864
CNSTF4 1073741824
ADDRLP4 112
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
line 619
;619:	velocity[1] = crandom()*GIB_VELOCITY;
ADDRLP4 116
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+4
CNSTF4 1132068864
CNSTF4 1073741824
ADDRLP4 116
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
line 620
;620:	velocity[2] = GIB_JUMP + crandom()*GIB_VELOCITY;
ADDRLP4 120
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+8
CNSTF4 1132068864
CNSTF4 1073741824
ADDRLP4 120
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
CNSTF4 1132068864
ADDF4
ASGNF4
line 621
;621:	CG_LaunchGib( origin, velocity, cgs.media.gibIntestine );
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 cgs+156680+212
INDIRI4
ARGI4
ADDRGP4 CG_LaunchGib
CALLV
pop
line 623
;622:
;623:	VectorCopy( playerOrigin, origin );
ADDRLP4 12
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 624
;624:	velocity[0] = crandom()*GIB_VELOCITY;
ADDRLP4 124
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
CNSTF4 1132068864
CNSTF4 1073741824
ADDRLP4 124
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
line 625
;625:	velocity[1] = crandom()*GIB_VELOCITY;
ADDRLP4 128
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+4
CNSTF4 1132068864
CNSTF4 1073741824
ADDRLP4 128
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
line 626
;626:	velocity[2] = GIB_JUMP + crandom()*GIB_VELOCITY;
ADDRLP4 132
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+8
CNSTF4 1132068864
CNSTF4 1073741824
ADDRLP4 132
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
CNSTF4 1132068864
ADDF4
ASGNF4
line 627
;627:	CG_LaunchGib( origin, velocity, cgs.media.gibLeg );
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 cgs+156680+216
INDIRI4
ARGI4
ADDRGP4 CG_LaunchGib
CALLV
pop
line 629
;628:
;629:	VectorCopy( playerOrigin, origin );
ADDRLP4 12
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 630
;630:	velocity[0] = crandom()*GIB_VELOCITY;
ADDRLP4 136
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
CNSTF4 1132068864
CNSTF4 1073741824
ADDRLP4 136
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
line 631
;631:	velocity[1] = crandom()*GIB_VELOCITY;
ADDRLP4 140
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+4
CNSTF4 1132068864
CNSTF4 1073741824
ADDRLP4 140
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
line 632
;632:	velocity[2] = GIB_JUMP + crandom()*GIB_VELOCITY;
ADDRLP4 144
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+8
CNSTF4 1132068864
CNSTF4 1073741824
ADDRLP4 144
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
CNSTF4 1132068864
ADDF4
ASGNF4
line 633
;633:	CG_LaunchGib( origin, velocity, cgs.media.gibLeg );
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 cgs+156680+216
INDIRI4
ARGI4
ADDRGP4 CG_LaunchGib
CALLV
pop
line 634
;634:}
LABELV $200
endproc CG_GibPlayer 148 12
export CG_LaunchExplode
proc CG_LaunchExplode 20 8
line 641
;635:
;636:/*
;637:==================
;638:CG_LaunchGib
;639:==================
;640:*/
;641:void CG_LaunchExplode( vec3_t origin, vec3_t velocity, qhandle_t hModel ) {
line 645
;642:	localEntity_t	*le;
;643:	refEntity_t		*re;
;644:
;645:	le = CG_AllocLocalEntity();
ADDRLP4 8
ADDRGP4 CG_AllocLocalEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 646
;646:	re = &le->refEntity;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
ASGNP4
line 648
;647:
;648:	le->leType = LE_FRAGMENT;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 3
ASGNI4
line 649
;649:	le->startTime = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 650
;650:	le->endTime = (cg_gibs.integer == -1)? cg.time : le->startTime + 10000 + random() * 6000;
ADDRGP4 cg_gibs+12
INDIRI4
CNSTI4 -1
NEI4 $256
ADDRLP4 12
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ASGNF4
ADDRGP4 $257
JUMPV
LABELV $256
ADDRLP4 16
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 10000
ADDI4
CVIF4 4
CNSTF4 1169915904
ADDRLP4 16
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
LABELV $257
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 12
INDIRF4
CVFI4 4
ASGNI4
line 652
;651:
;652:	VectorCopy( origin, re->origin );
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 653
;653:	AxisCopy( axisDefault, re->axis );
ADDRGP4 axisDefault
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRGP4 AxisCopy
CALLV
pop
line 654
;654:	re->hModel = hModel;
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 656
;655:
;656:	le->pos.trType = TR_GRAVITY;
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTI4 5
ASGNI4
line 657
;657:	VectorCopy( origin, le->pos.trBase );
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 658
;658:	VectorCopy( velocity, le->pos.trDelta );
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 659
;659:	le->pos.trTime = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 661
;660:
;661:	le->bounceFactor = 0.1f;
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
CNSTF4 1036831949
ASGNF4
line 663
;662:
;663:	le->leBounceSoundType = LEBS_BRASS;
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 2
ASGNI4
line 664
;664:	le->leMarkType = LEMT_NONE;
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 0
ASGNI4
line 665
;665:}
LABELV $251
endproc CG_LaunchExplode 20 8
export CG_BigExplode
proc CG_BigExplode 92 12
line 676
;666:
;667:#define	EXP_VELOCITY	100
;668:#define	EXP_JUMP		150
;669:/*
;670:===================
;671:CG_GibPlayer
;672:
;673:Generated a bunch of gibs launching out from the bodies location
;674:===================
;675:*/
;676:void CG_BigExplode( vec3_t playerOrigin ) {
line 679
;677:	vec3_t	origin, velocity;
;678:
;679:	if ( !cg_blood.integer ) {
ADDRGP4 cg_blood+12
INDIRI4
CNSTI4 0
NEI4 $260
line 680
;680:		return;
ADDRGP4 $259
JUMPV
LABELV $260
line 683
;681:	}
;682:
;683:	VectorCopy( playerOrigin, origin );
ADDRLP4 12
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 684
;684:	velocity[0] = crandom()*EXP_VELOCITY;
ADDRLP4 24
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
CNSTF4 1120403456
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
ASGNF4
line 685
;685:	velocity[1] = crandom()*EXP_VELOCITY;
ADDRLP4 28
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+4
CNSTF4 1120403456
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
ASGNF4
line 686
;686:	velocity[2] = EXP_JUMP + crandom()*EXP_VELOCITY;
ADDRLP4 32
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+8
CNSTF4 1120403456
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
CNSTF4 1125515264
ADDF4
ASGNF4
line 687
;687:	CG_LaunchExplode( origin, velocity, cgs.media.smoke2 );
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 cgs+156680+228
INDIRI4
ARGI4
ADDRGP4 CG_LaunchExplode
CALLV
pop
line 689
;688:
;689:	VectorCopy( playerOrigin, origin );
ADDRLP4 12
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 690
;690:	velocity[0] = crandom()*EXP_VELOCITY;
ADDRLP4 36
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
CNSTF4 1120403456
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
ASGNF4
line 691
;691:	velocity[1] = crandom()*EXP_VELOCITY;
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+4
CNSTF4 1120403456
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
ASGNF4
line 692
;692:	velocity[2] = EXP_JUMP + crandom()*EXP_VELOCITY;
ADDRLP4 44
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+8
CNSTF4 1120403456
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
CNSTF4 1125515264
ADDF4
ASGNF4
line 693
;693:	CG_LaunchExplode( origin, velocity, cgs.media.smoke2 );
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 cgs+156680+228
INDIRI4
ARGI4
ADDRGP4 CG_LaunchExplode
CALLV
pop
line 695
;694:
;695:	VectorCopy( playerOrigin, origin );
ADDRLP4 12
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 696
;696:	velocity[0] = crandom()*EXP_VELOCITY*1.5;
ADDRLP4 48
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
CNSTF4 1069547520
CNSTF4 1120403456
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
MULF4
ASGNF4
line 697
;697:	velocity[1] = crandom()*EXP_VELOCITY*1.5;
ADDRLP4 52
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+4
CNSTF4 1069547520
CNSTF4 1120403456
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
MULF4
ASGNF4
line 698
;698:	velocity[2] = EXP_JUMP + crandom()*EXP_VELOCITY;
ADDRLP4 56
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+8
CNSTF4 1120403456
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
CNSTF4 1125515264
ADDF4
ASGNF4
line 699
;699:	CG_LaunchExplode( origin, velocity, cgs.media.smoke2 );
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 cgs+156680+228
INDIRI4
ARGI4
ADDRGP4 CG_LaunchExplode
CALLV
pop
line 701
;700:
;701:	VectorCopy( playerOrigin, origin );
ADDRLP4 12
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 702
;702:	velocity[0] = crandom()*EXP_VELOCITY*2.0;
ADDRLP4 60
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 64
CNSTF4 1073741824
ASGNF4
ADDRLP4 0
ADDRLP4 64
INDIRF4
CNSTF4 1120403456
ADDRLP4 64
INDIRF4
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
MULF4
ASGNF4
line 703
;703:	velocity[1] = crandom()*EXP_VELOCITY*2.0;
ADDRLP4 68
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 72
CNSTF4 1073741824
ASGNF4
ADDRLP4 0+4
ADDRLP4 72
INDIRF4
CNSTF4 1120403456
ADDRLP4 72
INDIRF4
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
MULF4
ASGNF4
line 704
;704:	velocity[2] = EXP_JUMP + crandom()*EXP_VELOCITY;
ADDRLP4 76
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+8
CNSTF4 1120403456
CNSTF4 1073741824
ADDRLP4 76
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
CNSTF4 1125515264
ADDF4
ASGNF4
line 705
;705:	CG_LaunchExplode( origin, velocity, cgs.media.smoke2 );
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 cgs+156680+228
INDIRI4
ARGI4
ADDRGP4 CG_LaunchExplode
CALLV
pop
line 707
;706:
;707:	VectorCopy( playerOrigin, origin );
ADDRLP4 12
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 708
;708:	velocity[0] = crandom()*EXP_VELOCITY*2.5;
ADDRLP4 80
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
CNSTF4 1075838976
CNSTF4 1120403456
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
MULF4
ASGNF4
line 709
;709:	velocity[1] = crandom()*EXP_VELOCITY*2.5;
ADDRLP4 84
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+4
CNSTF4 1075838976
CNSTF4 1120403456
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
MULF4
ASGNF4
line 710
;710:	velocity[2] = EXP_JUMP + crandom()*EXP_VELOCITY;
ADDRLP4 88
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+8
CNSTF4 1120403456
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
CNSTF4 1125515264
ADDF4
ASGNF4
line 711
;711:	CG_LaunchExplode( origin, velocity, cgs.media.smoke2 );
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 cgs+156680+228
INDIRI4
ARGI4
ADDRGP4 CG_LaunchExplode
CALLV
pop
line 712
;712:}
LABELV $259
endproc CG_BigExplode 92 12
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
LABELV $155
byte 1 67
byte 1 71
byte 1 95
byte 1 77
byte 1 97
byte 1 107
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
byte 1 109
byte 1 115
byte 1 101
byte 1 99
byte 1 32
byte 1 61
byte 1 32
byte 1 37
byte 1 105
byte 1 0
