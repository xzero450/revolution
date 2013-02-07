export CG_TestModel_f
code
proc CG_TestModel_f 36 12
file "../cg_view.c"
line 51
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_view.c -- setup all the parameters (position, angle, etc)
;4:// for a 3D rendering
;5:#include "cg_local.h"
;6:
;7:
;8:/*
;9:=============================================================================
;10:
;11:  MODEL TESTING
;12:
;13:The viewthing and gun positioning tools from Q2 have been integrated and
;14:enhanced into a single model testing facility.
;15:
;16:Model viewing can begin with either "testmodel <modelname>" or "testgun <modelname>".
;17:
;18:The names must be the full pathname after the basedir, like 
;19:"models/weapons/v_launch/tris.md3" or "players/male/tris.md3"
;20:
;21:Testmodel will create a fake entity 100 units in front of the current view
;22:position, directly facing the viewer.  It will remain immobile, so you can
;23:move around it to view it from different angles.
;24:
;25:Testgun will cause the model to follow the player around and supress the real
;26:view weapon model.  The default frame 0 of most guns is completely off screen,
;27:so you will probably have to cycle a couple frames to see it.
;28:
;29:"nextframe", "prevframe", "nextskin", and "prevskin" commands will change the
;30:frame or skin of the testmodel.  These are bound to F5, F6, F7, and F8 in
;31:q3default.cfg.
;32:
;33:If a gun is being tested, the "gun_x", "gun_y", and "gun_z" variables will let
;34:you adjust the positioning.
;35:
;36:Note that none of the model testing features update while the game is paused, so
;37:it may be convenient to test with deathmatch set to 1 so that bringing down the
;38:console doesn't pause the game.
;39:
;40:=============================================================================
;41:*/
;42:
;43:/*
;44:=================
;45:CG_TestModel_f
;46:
;47:Creates an entity in front of the current position, which
;48:can then be moved around
;49:=================
;50:*/
;51:void CG_TestModel_f (void) {
line 54
;52:	vec3_t		angles;
;53:
;54:	memset( &cg.testModelEntity, 0, sizeof(cg.testModelEntity) );
ADDRGP4 cg+130936
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 55
;55:	if ( trap_Argc() < 2 ) {
ADDRLP4 12
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 2
GEI4 $80
line 56
;56:		return;
ADDRGP4 $77
JUMPV
LABELV $80
line 59
;57:	}
;58:
;59:	Q_strncpyz (cg.testModelName, CG_Argv( 1 ), MAX_QPATH );
CNSTI4 1
ARGI4
ADDRLP4 16
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRGP4 cg+131076
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 60
;60:	cg.testModelEntity.hModel = trap_R_RegisterModel( cg.testModelName );
ADDRGP4 cg+131076
ARGP4
ADDRLP4 20
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cg+130936+8
ADDRLP4 20
INDIRI4
ASGNI4
line 62
;61:
;62:	if ( trap_Argc() == 3 ) {
ADDRLP4 24
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 3
NEI4 $86
line 63
;63:		cg.testModelEntity.backlerp = atof( CG_Argv( 2 ) );
CNSTI4 2
ARGI4
ADDRLP4 28
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 atof
CALLF4
ASGNF4
ADDRGP4 cg+130936+100
ADDRLP4 32
INDIRF4
ASGNF4
line 64
;64:		cg.testModelEntity.frame = 1;
ADDRGP4 cg+130936+80
CNSTI4 1
ASGNI4
line 65
;65:		cg.testModelEntity.oldframe = 0;
ADDRGP4 cg+130936+96
CNSTI4 0
ASGNI4
line 66
;66:	}
LABELV $86
line 67
;67:	if (! cg.testModelEntity.hModel ) {
ADDRGP4 cg+130936+8
INDIRI4
CNSTI4 0
NEI4 $94
line 68
;68:		CG_Printf( "Can't register model\n" );
ADDRGP4 $98
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 69
;69:		return;
ADDRGP4 $77
JUMPV
LABELV $94
line 72
;70:	}
;71:
;72:	VectorMA( cg.refdef.vieworg, 100, cg.refdef.viewaxis[0], cg.testModelEntity.origin );
ADDRGP4 cg+130936+68
ADDRGP4 cg+109048+24
INDIRF4
CNSTF4 1120403456
ADDRGP4 cg+109048+36
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+130936+68+4
ADDRGP4 cg+109048+24+4
INDIRF4
CNSTF4 1120403456
ADDRGP4 cg+109048+36+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+130936+68+8
ADDRGP4 cg+109048+24+8
INDIRF4
CNSTF4 1120403456
ADDRGP4 cg+109048+36+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 74
;73:
;74:	angles[PITCH] = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 75
;75:	angles[YAW] = 180 + cg.refdefViewAngles[1];
ADDRLP4 0+4
ADDRGP4 cg+109416+4
INDIRF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 76
;76:	angles[ROLL] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 78
;77:
;78:	AnglesToAxis( angles, cg.testModelEntity.axis );
ADDRLP4 0
ARGP4
ADDRGP4 cg+130936+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 79
;79:	cg.testGun = qfalse;
ADDRGP4 cg+131140
CNSTI4 0
ASGNI4
line 80
;80:}
LABELV $77
endproc CG_TestModel_f 36 12
export CG_TestGun_f
proc CG_TestGun_f 0 0
line 89
;81:
;82:/*
;83:=================
;84:CG_TestGun_f
;85:
;86:Replaces the current view weapon with the given model
;87:=================
;88:*/
;89:void CG_TestGun_f (void) {
line 90
;90:	CG_TestModel_f();
ADDRGP4 CG_TestModel_f
CALLV
pop
line 91
;91:	cg.testGun = qtrue;
ADDRGP4 cg+131140
CNSTI4 1
ASGNI4
line 92
;92:	cg.testModelEntity.renderfx = RF_MINLIGHT | RF_DEPTHHACK | RF_FIRST_PERSON;
ADDRGP4 cg+130936+4
CNSTI4 13
ASGNI4
line 93
;93:}
LABELV $130
endproc CG_TestGun_f 0 0
export CG_TestModelNextFrame_f
proc CG_TestModelNextFrame_f 4 8
line 96
;94:
;95:
;96:void CG_TestModelNextFrame_f (void) {
line 97
;97:	cg.testModelEntity.frame++;
ADDRLP4 0
ADDRGP4 cg+130936+80
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 98
;98:	CG_Printf( "frame %i\n", cg.testModelEntity.frame );
ADDRGP4 $137
ARGP4
ADDRGP4 cg+130936+80
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 99
;99:}
LABELV $134
endproc CG_TestModelNextFrame_f 4 8
export CG_TestModelPrevFrame_f
proc CG_TestModelPrevFrame_f 4 8
line 101
;100:
;101:void CG_TestModelPrevFrame_f (void) {
line 102
;102:	cg.testModelEntity.frame--;
ADDRLP4 0
ADDRGP4 cg+130936+80
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 103
;103:	if ( cg.testModelEntity.frame < 0 ) {
ADDRGP4 cg+130936+80
INDIRI4
CNSTI4 0
GEI4 $143
line 104
;104:		cg.testModelEntity.frame = 0;
ADDRGP4 cg+130936+80
CNSTI4 0
ASGNI4
line 105
;105:	}
LABELV $143
line 106
;106:	CG_Printf( "frame %i\n", cg.testModelEntity.frame );
ADDRGP4 $137
ARGP4
ADDRGP4 cg+130936+80
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 107
;107:}
LABELV $140
endproc CG_TestModelPrevFrame_f 4 8
export CG_TestModelNextSkin_f
proc CG_TestModelNextSkin_f 4 8
line 109
;108:
;109:void CG_TestModelNextSkin_f (void) {
line 110
;110:	cg.testModelEntity.skinNum++;
ADDRLP4 0
ADDRGP4 cg+130936+104
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 111
;111:	CG_Printf( "skin %i\n", cg.testModelEntity.skinNum );
ADDRGP4 $154
ARGP4
ADDRGP4 cg+130936+104
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 112
;112:}
LABELV $151
endproc CG_TestModelNextSkin_f 4 8
export CG_TestModelPrevSkin_f
proc CG_TestModelPrevSkin_f 4 8
line 114
;113:
;114:void CG_TestModelPrevSkin_f (void) {
line 115
;115:	cg.testModelEntity.skinNum--;
ADDRLP4 0
ADDRGP4 cg+130936+104
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 116
;116:	if ( cg.testModelEntity.skinNum < 0 ) {
ADDRGP4 cg+130936+104
INDIRI4
CNSTI4 0
GEI4 $160
line 117
;117:		cg.testModelEntity.skinNum = 0;
ADDRGP4 cg+130936+104
CNSTI4 0
ASGNI4
line 118
;118:	}
LABELV $160
line 119
;119:	CG_Printf( "skin %i\n", cg.testModelEntity.skinNum );
ADDRGP4 $154
ARGP4
ADDRGP4 cg+130936+104
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 120
;120:}
LABELV $157
endproc CG_TestModelPrevSkin_f 4 8
proc CG_AddTestModel 32 4
line 122
;121:
;122:static void CG_AddTestModel (void) {
line 126
;123:	int		i;
;124:
;125:	// re-register the model, because the level may have changed
;126:	cg.testModelEntity.hModel = trap_R_RegisterModel( cg.testModelName );
ADDRGP4 cg+131076
ARGP4
ADDRLP4 4
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cg+130936+8
ADDRLP4 4
INDIRI4
ASGNI4
line 127
;127:	if (! cg.testModelEntity.hModel ) {
ADDRGP4 cg+130936+8
INDIRI4
CNSTI4 0
NEI4 $172
line 128
;128:		CG_Printf ("Can't register model\n");
ADDRGP4 $98
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 129
;129:		return;
ADDRGP4 $168
JUMPV
LABELV $172
line 133
;130:	}
;131:
;132:	// if testing a gun, set the origin reletive to the view origin
;133:	if ( cg.testGun ) {
ADDRGP4 cg+131140
INDIRI4
CNSTI4 0
EQI4 $176
line 134
;134:		VectorCopy( cg.refdef.vieworg, cg.testModelEntity.origin );
ADDRGP4 cg+130936+68
ADDRGP4 cg+109048+24
INDIRB
ASGNB 12
line 135
;135:		VectorCopy( cg.refdef.viewaxis[0], cg.testModelEntity.axis[0] );
ADDRGP4 cg+130936+28
ADDRGP4 cg+109048+36
INDIRB
ASGNB 12
line 136
;136:		VectorCopy( cg.refdef.viewaxis[1], cg.testModelEntity.axis[1] );
ADDRGP4 cg+130936+28+12
ADDRGP4 cg+109048+36+12
INDIRB
ASGNB 12
line 137
;137:		VectorCopy( cg.refdef.viewaxis[2], cg.testModelEntity.axis[2] );
ADDRGP4 cg+130936+28+24
ADDRGP4 cg+109048+36+24
INDIRB
ASGNB 12
line 140
;138:
;139:		// allow the position to be adjusted
;140:		for (i=0 ; i<3 ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $199
line 141
;141:			cg.testModelEntity.origin[i] += cg.refdef.viewaxis[0][i] * cg_gun_x.value;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 12
ADDRLP4 8
INDIRI4
ADDRGP4 cg+130936+68
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRLP4 8
INDIRI4
ADDRGP4 cg+109048+36
ADDP4
INDIRF4
ADDRGP4 cg_gun_x+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 142
;142:			cg.testModelEntity.origin[i] += cg.refdef.viewaxis[1][i] * cg_gun_y.value;
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 20
ADDRLP4 16
INDIRI4
ADDRGP4 cg+130936+68
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 16
INDIRI4
ADDRGP4 cg+109048+36+12
ADDP4
INDIRF4
ADDRGP4 cg_gun_y+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 143
;143:			cg.testModelEntity.origin[i] += cg.refdef.viewaxis[2][i] * cg_gun_z.value;
ADDRLP4 24
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 28
ADDRLP4 24
INDIRI4
ADDRGP4 cg+130936+68
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 24
INDIRI4
ADDRGP4 cg+109048+36+24
ADDP4
INDIRF4
ADDRGP4 cg_gun_z+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 144
;144:		}
LABELV $200
line 140
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
line 145
;145:	}
LABELV $176
line 147
;146:
;147:	trap_R_AddRefEntityToScene( &cg.testModelEntity );
ADDRGP4 cg+130936
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 148
;148:}
LABELV $168
endproc CG_AddTestModel 32 4
proc CG_CalcVrect 12 8
line 162
;149:
;150:
;151:
;152://============================================================================
;153:
;154:
;155:/*
;156:=================
;157:CG_CalcVrect
;158:
;159:Sets the coordinates of the rendered window
;160:=================
;161:*/
;162:static void CG_CalcVrect (void) {
line 166
;163:	int		size;
;164:
;165:	// the intermission should allways be full screen
;166:	if ( cg.snap->ps.pm_type == PM_INTERMISSION ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 5
NEI4 $222
line 167
;167:		size = 100;
ADDRLP4 0
CNSTI4 100
ASGNI4
line 168
;168:	} else {
ADDRGP4 $223
JUMPV
LABELV $222
line 170
;169:		// bound normal viewsize
;170:		if (cg_viewsize.integer < 30) {
ADDRGP4 cg_viewsize+12
INDIRI4
CNSTI4 30
GEI4 $225
line 171
;171:			trap_Cvar_Set ("cg_viewsize","30");
ADDRGP4 $228
ARGP4
ADDRGP4 $229
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 172
;172:			size = 30;
ADDRLP4 0
CNSTI4 30
ASGNI4
line 173
;173:		} else if (cg_viewsize.integer > 100) {
ADDRGP4 $226
JUMPV
LABELV $225
ADDRGP4 cg_viewsize+12
INDIRI4
CNSTI4 100
LEI4 $230
line 174
;174:			trap_Cvar_Set ("cg_viewsize","100");
ADDRGP4 $228
ARGP4
ADDRGP4 $233
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 175
;175:			size = 100;
ADDRLP4 0
CNSTI4 100
ASGNI4
line 176
;176:		} else {
ADDRGP4 $231
JUMPV
LABELV $230
line 177
;177:			size = cg_viewsize.integer;
ADDRLP4 0
ADDRGP4 cg_viewsize+12
INDIRI4
ASGNI4
line 178
;178:		}
LABELV $231
LABELV $226
line 180
;179:
;180:	}
LABELV $223
line 181
;181:	cg.refdef.width = cgs.glconfig.vidWidth*size/100;
ADDRGP4 cg+109048+8
ADDRGP4 cgs+20100+11304
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
CNSTI4 100
DIVI4
ASGNI4
line 182
;182:	cg.refdef.width &= ~1;
ADDRLP4 4
ADDRGP4 cg+109048+8
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 184
;183:
;184:	cg.refdef.height = cgs.glconfig.vidHeight*size/100;
ADDRGP4 cg+109048+12
ADDRGP4 cgs+20100+11308
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
CNSTI4 100
DIVI4
ASGNI4
line 185
;185:	cg.refdef.height &= ~1;
ADDRLP4 8
ADDRGP4 cg+109048+12
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 187
;186:
;187:	cg.refdef.x = (cgs.glconfig.vidWidth - cg.refdef.width)/2;
ADDRGP4 cg+109048
ADDRGP4 cgs+20100+11304
INDIRI4
ADDRGP4 cg+109048+8
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ASGNI4
line 188
;188:	cg.refdef.y = (cgs.glconfig.vidHeight - cg.refdef.height)/2;
ADDRGP4 cg+109048+4
ADDRGP4 cgs+20100+11308
INDIRI4
ADDRGP4 cg+109048+12
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ASGNI4
line 189
;189:}
LABELV $221
endproc CG_CalcVrect 12 8
data
align 4
LABELV $259
byte 4 3229614080
byte 4 3229614080
byte 4 3229614080
align 4
LABELV $260
byte 4 1082130432
byte 4 1082130432
byte 4 1082130432
code
proc CG_OffsetThirdPersonView 188 28
line 201
;190:
;191://==============================================================================
;192:
;193:
;194:/*
;195:===============
;196:CG_OffsetThirdPersonView
;197:
;198:===============
;199:*/
;200:#define	FOCUS_DISTANCE	512
;201:static void CG_OffsetThirdPersonView( void ) {
line 212
;202:	vec3_t		forward, right, up;
;203:	vec3_t		view;
;204:	vec3_t		focusAngles;
;205:	trace_t		trace;
;206:	static vec3_t	mins = { -4, -4, -4 };
;207:	static vec3_t	maxs = { 4, 4, 4 };
;208:	vec3_t		focusPoint;
;209:	float		focusDist;
;210:	float		forwardScale, sideScale;
;211:
;212:	cg.refdef.vieworg[2] += cg.predictedPlayerState.viewheight;
ADDRLP4 140
ADDRGP4 cg+109048+24+8
ASGNP4
ADDRLP4 140
INDIRP4
ADDRLP4 140
INDIRP4
INDIRF4
ADDRGP4 cg+107636+164
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 214
;213:
;214:	VectorCopy( cg.refdefViewAngles, focusAngles );
ADDRLP4 48
ADDRGP4 cg+109416
INDIRB
ASGNB 12
line 217
;215:
;216:	// if dead, look at killer
;217:	if ( cg.predictedPlayerState.stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 cg+107636+184
INDIRI4
CNSTI4 0
GTI4 $267
line 218
;218:		focusAngles[YAW] = cg.predictedPlayerState.stats[STAT_DEAD_YAW];
ADDRLP4 48+4
ADDRGP4 cg+107636+184+16
INDIRI4
CVIF4 4
ASGNF4
line 219
;219:		cg.refdefViewAngles[YAW] = cg.predictedPlayerState.stats[STAT_DEAD_YAW];
ADDRGP4 cg+109416+4
ADDRGP4 cg+107636+184+16
INDIRI4
CVIF4 4
ASGNF4
line 220
;220:	}
LABELV $267
line 222
;221:
;222:	if ( focusAngles[PITCH] > 45 ) {
ADDRLP4 48
INDIRF4
CNSTF4 1110704128
LEF4 $280
line 223
;223:		focusAngles[PITCH] = 45;		// don't go too far overhead
ADDRLP4 48
CNSTF4 1110704128
ASGNF4
line 224
;224:	}
LABELV $280
line 225
;225:	AngleVectors( focusAngles, forward, NULL, NULL );
ADDRLP4 48
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 144
CNSTP4 0
ASGNP4
ADDRLP4 144
INDIRP4
ARGP4
ADDRLP4 144
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 227
;226:
;227:	VectorMA( cg.refdef.vieworg, FOCUS_DISTANCE, forward, focusPoint );
ADDRLP4 148
CNSTF4 1140850688
ASGNF4
ADDRLP4 12
ADDRGP4 cg+109048+24
INDIRF4
ADDRLP4 148
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRGP4 cg+109048+24+4
INDIRF4
ADDRLP4 148
INDIRF4
ADDRLP4 24+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRGP4 cg+109048+24+8
INDIRF4
CNSTF4 1140850688
ADDRLP4 24+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 229
;228:
;229:	VectorCopy( cg.refdef.vieworg, view );
ADDRLP4 0
ADDRGP4 cg+109048+24
INDIRB
ASGNB 12
line 231
;230:
;231:	view[2] += 8;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 233
;232:
;233:	cg.refdefViewAngles[PITCH] *= 0.5;
ADDRLP4 152
ADDRGP4 cg+109416
ASGNP4
ADDRLP4 152
INDIRP4
CNSTF4 1056964608
ADDRLP4 152
INDIRP4
INDIRF4
MULF4
ASGNF4
line 235
;234:
;235:	AngleVectors( cg.refdefViewAngles, forward, right, up );
ADDRGP4 cg+109416
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 128
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 237
;236:
;237:	forwardScale = cos( cg_thirdPersonAngle.value / 180 * M_PI );
CNSTF4 1078530011
ADDRGP4 cg_thirdPersonAngle+8
INDIRF4
CNSTF4 1127481344
DIVF4
MULF4
ARGF4
ADDRLP4 156
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 60
ADDRLP4 156
INDIRF4
ASGNF4
line 238
;238:	sideScale = sin( cg_thirdPersonAngle.value / 180 * M_PI );
CNSTF4 1078530011
ADDRGP4 cg_thirdPersonAngle+8
INDIRF4
CNSTF4 1127481344
DIVF4
MULF4
ARGF4
ADDRLP4 160
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 64
ADDRLP4 160
INDIRF4
ASGNF4
line 239
;239:	VectorMA( view, -cg_thirdPersonRange.value * forwardScale, forward, view );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 24
INDIRF4
ADDRGP4 cg_thirdPersonRange+8
INDIRF4
NEGF4
ADDRLP4 60
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 24+4
INDIRF4
ADDRGP4 cg_thirdPersonRange+8
INDIRF4
NEGF4
ADDRLP4 60
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 24+8
INDIRF4
ADDRGP4 cg_thirdPersonRange+8
INDIRF4
NEGF4
ADDRLP4 60
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 240
;240:	VectorMA( view, -cg_thirdPersonRange.value * sideScale, right, view );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 36
INDIRF4
ADDRGP4 cg_thirdPersonRange+8
INDIRF4
NEGF4
ADDRLP4 64
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDRGP4 cg_thirdPersonRange+8
INDIRF4
NEGF4
ADDRLP4 64
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDRGP4 cg_thirdPersonRange+8
INDIRF4
NEGF4
ADDRLP4 64
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 245
;241:
;242:	// trace a ray from the origin to the viewpoint to make sure the view isn't
;243:	// in a solid block.  Use an 8 by 8 block to prevent the view from near clipping anything
;244:
;245:	if (!cg_cameraMode.integer) {
ADDRGP4 cg_cameraMode+12
INDIRI4
CNSTI4 0
NEI4 $319
line 246
;246:		CG_Trace( &trace, cg.refdef.vieworg, mins, maxs, view, cg.predictedPlayerState.clientNum, MASK_SOLID );
ADDRLP4 72
ARGP4
ADDRGP4 cg+109048+24
ARGP4
ADDRGP4 $259
ARGP4
ADDRGP4 $260
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 cg+107636+140
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 248
;247:
;248:		if ( trace.fraction != 1.0 ) {
ADDRLP4 72+8
INDIRF4
CNSTF4 1065353216
EQF4 $326
line 249
;249:			VectorCopy( trace.endpos, view );
ADDRLP4 0
ADDRLP4 72+12
INDIRB
ASGNB 12
line 250
;250:			view[2] += (1.0 - trace.fraction) * 32;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1107296256
CNSTF4 1065353216
ADDRLP4 72+8
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 254
;251:			// try another trace to this position, because a tunnel may have the ceiling
;252:			// close enogh that this is poking out
;253:
;254:			CG_Trace( &trace, cg.refdef.vieworg, mins, maxs, view, cg.predictedPlayerState.clientNum, MASK_SOLID );
ADDRLP4 72
ARGP4
ADDRGP4 cg+109048+24
ARGP4
ADDRGP4 $259
ARGP4
ADDRGP4 $260
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 cg+107636+140
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 255
;255:			VectorCopy( trace.endpos, view );
ADDRLP4 0
ADDRLP4 72+12
INDIRB
ASGNB 12
line 256
;256:		}
LABELV $326
line 257
;257:	}
LABELV $319
line 260
;258:
;259:
;260:	VectorCopy( view, cg.refdef.vieworg );
ADDRGP4 cg+109048+24
ADDRLP4 0
INDIRB
ASGNB 12
line 263
;261:
;262:	// select pitch to look at focus point from vieword
;263:	VectorSubtract( focusPoint, cg.refdef.vieworg, focusPoint );
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRGP4 cg+109048+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRGP4 cg+109048+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
ADDRGP4 cg+109048+24+8
INDIRF4
SUBF4
ASGNF4
line 264
;264:	focusDist = sqrt( focusPoint[0] * focusPoint[0] + focusPoint[1] * focusPoint[1] );
ADDRLP4 172
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 172
INDIRF4
ADDRLP4 172
INDIRF4
MULF4
ADDRLP4 12+4
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 176
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 68
ADDRLP4 176
INDIRF4
ASGNF4
line 265
;265:	if ( focusDist < 1 ) {
ADDRLP4 68
INDIRF4
CNSTF4 1065353216
GEF4 $353
line 266
;266:		focusDist = 1;	// should never happen
ADDRLP4 68
CNSTF4 1065353216
ASGNF4
line 267
;267:	}
LABELV $353
line 268
;268:	cg.refdefViewAngles[PITCH] = -180 / M_PI * atan2( focusPoint[2], focusDist );
ADDRLP4 12+8
INDIRF4
ARGF4
ADDRLP4 68
INDIRF4
ARGF4
ADDRLP4 180
ADDRGP4 atan2
CALLF4
ASGNF4
ADDRGP4 cg+109416
CNSTF4 3261411041
ADDRLP4 180
INDIRF4
MULF4
ASGNF4
line 269
;269:	cg.refdefViewAngles[YAW] -= cg_thirdPersonAngle.value;
ADDRLP4 184
ADDRGP4 cg+109416+4
ASGNP4
ADDRLP4 184
INDIRP4
ADDRLP4 184
INDIRP4
INDIRF4
ADDRGP4 cg_thirdPersonAngle+8
INDIRF4
SUBF4
ASGNF4
line 270
;270:}
LABELV $258
endproc CG_OffsetThirdPersonView 188 28
proc CG_StepOffset 8 0
line 274
;271:
;272:
;273:// this causes a compiler bug on mac MrC compiler
;274:static void CG_StepOffset( void ) {
line 278
;275:	int		timeDelta;
;276:	
;277:	// smooth out stair climbing
;278:	timeDelta = cg.time - cg.stepTime;
ADDRLP4 0
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+108924
INDIRI4
SUBI4
ASGNI4
line 279
;279:	if ( timeDelta < STEP_TIME ) {
ADDRLP4 0
INDIRI4
CNSTI4 200
GEI4 $363
line 280
;280:		cg.refdef.vieworg[2] -= cg.stepChange 
ADDRLP4 4
ADDRGP4 cg+109048+24+8
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRGP4 cg+108920
INDIRF4
CNSTI4 200
ADDRLP4 0
INDIRI4
SUBI4
CVIF4 4
MULF4
CNSTF4 1128792064
DIVF4
SUBF4
ASGNF4
line 282
;281:			* (STEP_TIME - timeDelta) / STEP_TIME;
;282:	}
LABELV $363
line 283
;283:}
LABELV $360
endproc CG_StepOffset 8 0
proc CG_OffsetFirstPersonView 96 0
line 291
;284:
;285:/*
;286:===============
;287:CG_OffsetFirstPersonView
;288:
;289:===============
;290:*/
;291:static void CG_OffsetFirstPersonView( void ) {
line 304
;292:	float			*origin;
;293:	float			*angles;
;294:	float			bob;
;295:	float			ratio;
;296:	float			delta;
;297:	float			speed;
;298:	float			f;
;299:	vec3_t			predictedVelocity;
;300:	int				timeDelta;
;301:	
;302:	//CG_Printf("Orgin:%3.3f - %3.3f - %3.3f\n", cg.refdef.vieworg[0], cg.refdef.vieworg[1], cg.refdef.vieworg[2]);
;303:	//CG_Printf("Angles:%3.3f - %3.3f - %3.3f\n", cg.refdefViewAngles[0], cg.refdefViewAngles[1], cg.refdefViewAngles[2]);
;304:	if ( cg.snap->ps.pm_type == PM_INTERMISSION ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 5
NEI4 $370
line 305
;305:		return;
ADDRGP4 $369
JUMPV
LABELV $370
line 308
;306:	}
;307:
;308:	origin = cg.refdef.vieworg;
ADDRLP4 8
ADDRGP4 cg+109048+24
ASGNP4
line 309
;309:	angles = cg.refdefViewAngles;
ADDRLP4 4
ADDRGP4 cg+109416
ASGNP4
line 312
;310:
;311:	// if dead, fix the angle and don't add any kick
;312:	if ( cg.snap->ps.stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
GTI4 $376
line 313
;313:		angles[ROLL] = 40;
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1109393408
ASGNF4
line 314
;314:		angles[PITCH] = -15;
ADDRLP4 4
INDIRP4
CNSTF4 3245342720
ASGNF4
line 315
;315:		angles[YAW] = cg.snap->ps.stats[STAT_DEAD_YAW];
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 316
;316:		origin[2] += cg.predictedPlayerState.viewheight;
ADDRLP4 44
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
ADDRGP4 cg+107636+164
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 317
;317:		return;
ADDRGP4 $369
JUMPV
LABELV $376
line 321
;318:	}
;319:
;320:	// add angles based on weapon kick
;321:	VectorAdd (angles, cg.kick_angles, angles);
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRGP4 cg+130896
INDIRF4
ADDF4
ASGNF4
ADDRLP4 48
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRF4
ADDRGP4 cg+130896+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 52
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRF4
ADDRGP4 cg+130896+8
INDIRF4
ADDF4
ASGNF4
line 324
;322:
;323:	// add angles based on damage kick
;324:	if ( cg.damageTime ) {
ADDRGP4 cg+130840
INDIRF4
CNSTF4 0
EQF4 $387
line 325
;325:		ratio = cg.time - cg.damageTime;
ADDRLP4 32
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ADDRGP4 cg+130840
INDIRF4
SUBF4
ASGNF4
line 326
;326:		if ( ratio < DAMAGE_DEFLECT_TIME ) {
ADDRLP4 32
INDIRF4
CNSTF4 1120403456
GEF4 $392
line 327
;327:			ratio /= DAMAGE_DEFLECT_TIME;
ADDRLP4 32
ADDRLP4 32
INDIRF4
CNSTF4 1120403456
DIVF4
ASGNF4
line 328
;328:			angles[PITCH] += ratio * cg.v_dmg_pitch;
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDRGP4 cg+130888
INDIRF4
MULF4
ADDF4
ASGNF4
line 329
;329:			angles[ROLL] += ratio * cg.v_dmg_roll;
ADDRLP4 60
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDRGP4 cg+130892
INDIRF4
MULF4
ADDF4
ASGNF4
line 330
;330:		} else {
ADDRGP4 $393
JUMPV
LABELV $392
line 331
;331:			ratio = 1.0 - ( ratio - DAMAGE_DEFLECT_TIME ) / DAMAGE_RETURN_TIME;
ADDRLP4 32
CNSTF4 1065353216
ADDRLP4 32
INDIRF4
CNSTF4 1120403456
SUBF4
CNSTF4 1137180672
DIVF4
SUBF4
ASGNF4
line 332
;332:			if ( ratio > 0 ) {
ADDRLP4 32
INDIRF4
CNSTF4 0
LEF4 $396
line 333
;333:				angles[PITCH] += ratio * cg.v_dmg_pitch;
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDRGP4 cg+130888
INDIRF4
MULF4
ADDF4
ASGNF4
line 334
;334:				angles[ROLL] += ratio * cg.v_dmg_roll;
ADDRLP4 60
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDRGP4 cg+130892
INDIRF4
MULF4
ADDF4
ASGNF4
line 335
;335:			}
LABELV $396
line 336
;336:		}
LABELV $393
line 337
;337:	}
LABELV $387
line 348
;338:
;339:	// add pitch based on fall kick
;340:#if 0
;341:	ratio = ( cg.time - cg.landTime) / FALL_TIME;
;342:	if (ratio < 0)
;343:		ratio = 0;
;344:	angles[PITCH] += ratio * cg.fall_value;
;345:#endif
;346:
;347:	// add angles based on velocity
;348:	VectorCopy( cg.predictedPlayerState.velocity, predictedVelocity );
ADDRLP4 12
ADDRGP4 cg+107636+32
INDIRB
ASGNB 12
line 350
;349:
;350:	delta = DotProduct ( predictedVelocity, cg.refdef.viewaxis[0]);
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRGP4 cg+109048+36
INDIRF4
MULF4
ADDRLP4 12+4
INDIRF4
ADDRGP4 cg+109048+36+4
INDIRF4
MULF4
ADDF4
ADDRLP4 12+8
INDIRF4
ADDRGP4 cg+109048+36+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 351
;351:	angles[PITCH] += delta * cg_runpitch.value;
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDRGP4 cg_runpitch+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 353
;352:	
;353:	delta = DotProduct ( predictedVelocity, cg.refdef.viewaxis[1]);
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRGP4 cg+109048+36+12
INDIRF4
MULF4
ADDRLP4 12+4
INDIRF4
ADDRGP4 cg+109048+36+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 12+8
INDIRF4
ADDRGP4 cg+109048+36+12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 354
;354:	angles[ROLL] -= delta * cg_runroll.value;
ADDRLP4 60
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDRGP4 cg_runroll+8
INDIRF4
MULF4
SUBF4
ASGNF4
line 359
;355:
;356:	// add angles based on bob
;357:
;358:	// make sure the bob is visible even at low speeds
;359:	speed = cg.xyspeed > 200 ? cg.xyspeed : 200;
ADDRGP4 cg+130928
INDIRF4
CNSTF4 1128792064
LEF4 $430
ADDRLP4 64
ADDRGP4 cg+130928
INDIRF4
ASGNF4
ADDRGP4 $431
JUMPV
LABELV $430
ADDRLP4 64
CNSTF4 1128792064
ASGNF4
LABELV $431
ADDRLP4 28
ADDRLP4 64
INDIRF4
ASGNF4
line 361
;360:
;361:	delta = cg.bobfracsin * cg_bobpitch.value * speed;
ADDRLP4 0
ADDRGP4 cg+130920
INDIRF4
ADDRGP4 cg_bobpitch+8
INDIRF4
MULF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 362
;362:	if (cg.predictedPlayerState.pm_flags & PMF_DUCKED)
ADDRGP4 cg+107636+12
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $434
line 363
;363:		delta *= 3;		// crouching
ADDRLP4 0
CNSTF4 1077936128
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
LABELV $434
line 364
;364:	angles[PITCH] += delta;
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
line 365
;365:	delta = cg.bobfracsin * cg_bobroll.value * speed;
ADDRLP4 0
ADDRGP4 cg+130920
INDIRF4
ADDRGP4 cg_bobroll+8
INDIRF4
MULF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 366
;366:	if (cg.predictedPlayerState.pm_flags & PMF_DUCKED)
ADDRGP4 cg+107636+12
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $440
line 367
;367:		delta *= 3;		// crouching accentuates roll
ADDRLP4 0
CNSTF4 1077936128
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
LABELV $440
line 368
;368:	if (cg.bobcycle & 1)
ADDRGP4 cg+130924
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $444
line 369
;369:		delta = -delta;
ADDRLP4 0
ADDRLP4 0
INDIRF4
NEGF4
ASGNF4
LABELV $444
line 370
;370:	angles[ROLL] += delta;
ADDRLP4 72
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
line 375
;371:
;372://===================================
;373:
;374:	// add view height
;375:	origin[2] += cg.predictedPlayerState.viewheight;
ADDRLP4 76
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRF4
ADDRGP4 cg+107636+164
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 378
;376:
;377:	// smooth out duck height changes
;378:	timeDelta = cg.time - cg.duckTime;
ADDRLP4 36
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+108932
INDIRI4
SUBI4
ASGNI4
line 379
;379:	if ( timeDelta < DUCK_TIME) {
ADDRLP4 36
INDIRI4
CNSTI4 100
GEI4 $451
line 380
;380:		cg.refdef.vieworg[2] -= cg.duckChange 
ADDRLP4 80
ADDRGP4 cg+109048+24+8
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRF4
ADDRGP4 cg+108928
INDIRF4
CNSTI4 100
ADDRLP4 36
INDIRI4
SUBI4
CVIF4 4
MULF4
CNSTF4 1120403456
DIVF4
SUBF4
ASGNF4
line 382
;381:			* (DUCK_TIME - timeDelta) / DUCK_TIME;
;382:	}
LABELV $451
line 385
;383:
;384:	// add bob height
;385:	bob = cg.bobfracsin * cg.xyspeed * cg_bobup.value;
ADDRLP4 24
ADDRGP4 cg+130920
INDIRF4
ADDRGP4 cg+130928
INDIRF4
MULF4
ADDRGP4 cg_bobup+8
INDIRF4
MULF4
ASGNF4
line 386
;386:	if (bob > 6) {
ADDRLP4 24
INDIRF4
CNSTF4 1086324736
LEF4 $460
line 387
;387:		bob = 6;
ADDRLP4 24
CNSTF4 1086324736
ASGNF4
line 388
;388:	}
LABELV $460
line 390
;389:
;390:	origin[2] += bob;
ADDRLP4 80
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRF4
ADDRLP4 24
INDIRF4
ADDF4
ASGNF4
line 394
;391:
;392:
;393:	// add fall height
;394:	delta = cg.time - cg.landTime;
ADDRLP4 0
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+108940
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 395
;395:	if ( delta < LAND_DEFLECT_TIME ) {
ADDRLP4 0
INDIRF4
CNSTF4 1125515264
GEF4 $464
line 396
;396:		f = delta / LAND_DEFLECT_TIME;
ADDRLP4 40
ADDRLP4 0
INDIRF4
CNSTF4 1125515264
DIVF4
ASGNF4
line 397
;397:		cg.refdef.vieworg[2] += cg.landChange * f;
ADDRLP4 84
ADDRGP4 cg+109048+24+8
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRF4
ADDRGP4 cg+108936
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
ADDF4
ASGNF4
line 398
;398:	} else if ( delta < LAND_DEFLECT_TIME + LAND_RETURN_TIME ) {
ADDRGP4 $465
JUMPV
LABELV $464
ADDRLP4 0
INDIRF4
CNSTF4 1138819072
GEF4 $470
line 399
;399:		delta -= LAND_DEFLECT_TIME;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1125515264
SUBF4
ASGNF4
line 400
;400:		f = 1.0 - ( delta / LAND_RETURN_TIME );
ADDRLP4 40
CNSTF4 1065353216
ADDRLP4 0
INDIRF4
CNSTF4 1133903872
DIVF4
SUBF4
ASGNF4
line 401
;401:		cg.refdef.vieworg[2] += cg.landChange * f;
ADDRLP4 84
ADDRGP4 cg+109048+24+8
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRF4
ADDRGP4 cg+108936
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
ADDF4
ASGNF4
line 402
;402:	}
LABELV $470
LABELV $465
line 405
;403:
;404:	// add step offset
;405:	CG_StepOffset();
ADDRGP4 CG_StepOffset
CALLV
pop
line 409
;406:
;407:	// add kick offset
;408:
;409:	VectorAdd (origin, cg.kick_origin, origin);
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRGP4 cg+130908
INDIRF4
ADDF4
ASGNF4
ADDRLP4 88
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRF4
ADDRGP4 cg+130908+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 92
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRF4
ADDRGP4 cg+130908+8
INDIRF4
ADDF4
ASGNF4
line 423
;410:
;411:	// pivot the eye based on a neck length
;412:#if 0
;413:	{
;414:#define	NECK_LENGTH		8
;415:	vec3_t			forward, up;
;416: 
;417:	cg.refdef.vieworg[2] -= NECK_LENGTH;
;418:	AngleVectors( cg.refdefViewAngles, forward, NULL, up );
;419:	VectorMA( cg.refdef.vieworg, 3, forward, cg.refdef.vieworg );
;420:	VectorMA( cg.refdef.vieworg, NECK_LENGTH, up, cg.refdef.vieworg );
;421:	}
;422:#endif
;423:}
LABELV $369
endproc CG_OffsetFirstPersonView 96 0
export CG_ZoomDown_f
proc CG_ZoomDown_f 0 0
line 427
;424:
;425://======================================================================
;426:
;427:void CG_ZoomDown_f( void ) { 
line 428
;428:	if ( cg.zoomed ) {
ADDRGP4 cg+109428
INDIRI4
CNSTI4 0
EQI4 $482
line 429
;429:		return;
ADDRGP4 $481
JUMPV
LABELV $482
line 431
;430:	}
;431:	cg.zoomed = qtrue;
ADDRGP4 cg+109428
CNSTI4 1
ASGNI4
line 432
;432:	cg.zoomTime = cg.time;
ADDRGP4 cg+109432
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 433
;433:}
LABELV $481
endproc CG_ZoomDown_f 0 0
export CG_ZoomUp_f
proc CG_ZoomUp_f 0 0
line 435
;434:
;435:void CG_ZoomUp_f( void ) { 
line 436
;436:	if ( !cg.zoomed ) {
ADDRGP4 cg+109428
INDIRI4
CNSTI4 0
NEI4 $489
line 437
;437:		return;
ADDRGP4 $488
JUMPV
LABELV $489
line 439
;438:	}
;439:	cg.zoomed = qfalse;
ADDRGP4 cg+109428
CNSTI4 0
ASGNI4
line 440
;440:	cg.zoomTime = cg.time;
ADDRGP4 cg+109432
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 441
;441:}
LABELV $488
endproc CG_ZoomUp_f 0 0
proc CG_CalcFov 52 8
line 454
;442:
;443:
;444:/*
;445:====================
;446:CG_CalcFov
;447:
;448:Fixed fov at intermissions, otherwise account for fov variable and zooms.
;449:====================
;450:*/
;451:#define	WAVE_AMPLITUDE	1
;452:#define	WAVE_FREQUENCY	0.4
;453:
;454:static int CG_CalcFov( void ) {
line 464
;455:	float	x;
;456:	float	phase;
;457:	float	v;
;458:	int		contents;
;459:	float	fov_x, fov_y;
;460:	float	zoomFov;
;461:	float	f;
;462:	int		inwater;
;463:
;464:	if ( cg.predictedPlayerState.pm_type == PM_INTERMISSION ) {
ADDRGP4 cg+107636+4
INDIRI4
CNSTI4 5
NEI4 $496
line 466
;465:		// if in intermission, use a fixed value
;466:		fov_x = 90;
ADDRLP4 0
CNSTF4 1119092736
ASGNF4
line 467
;467:	} else {
ADDRGP4 $497
JUMPV
LABELV $496
line 469
;468:		// user selectable
;469:		if ( cgs.dmflags & DF_FIXED_FOV ) {
ADDRGP4 cgs+31460
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $500
line 471
;470:			// dmflag to prevent wide fov for all clients
;471:			fov_x = 90;
ADDRLP4 0
CNSTF4 1119092736
ASGNF4
line 472
;472:		} else {
ADDRGP4 $501
JUMPV
LABELV $500
line 473
;473:			fov_x = cg_fov.value;
ADDRLP4 0
ADDRGP4 cg_fov+8
INDIRF4
ASGNF4
line 474
;474:			if ( fov_x < 1 ) {
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
GEF4 $504
line 475
;475:				fov_x = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 476
;476:			} else if ( fov_x > 160 ) {
ADDRGP4 $505
JUMPV
LABELV $504
ADDRLP4 0
INDIRF4
CNSTF4 1126170624
LEF4 $506
line 477
;477:				fov_x = 160;
ADDRLP4 0
CNSTF4 1126170624
ASGNF4
line 478
;478:			}
LABELV $506
LABELV $505
line 479
;479:		}
LABELV $501
line 482
;480:
;481:		// account for zooms
;482:		zoomFov = cg_zoomFov.value;
ADDRLP4 8
ADDRGP4 cg_zoomFov+8
INDIRF4
ASGNF4
line 483
;483:		if ( zoomFov < 1 ) {
ADDRLP4 8
INDIRF4
CNSTF4 1065353216
GEF4 $509
line 484
;484:			zoomFov = 1;
ADDRLP4 8
CNSTF4 1065353216
ASGNF4
line 485
;485:		} else if ( zoomFov > 160 ) {
ADDRGP4 $510
JUMPV
LABELV $509
ADDRLP4 8
INDIRF4
CNSTF4 1126170624
LEF4 $511
line 486
;486:			zoomFov = 160;
ADDRLP4 8
CNSTF4 1126170624
ASGNF4
line 487
;487:		}
LABELV $511
LABELV $510
line 489
;488:
;489:		if ( cg.zoomed ) {
ADDRGP4 cg+109428
INDIRI4
CNSTI4 0
EQI4 $513
line 490
;490:			f = ( cg.time - cg.zoomTime ) / (float)ZOOM_TIME;
ADDRLP4 28
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+109432
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1125515264
DIVF4
ASGNF4
line 491
;491:			if ( f > 1.0 ) {
ADDRLP4 28
INDIRF4
CNSTF4 1065353216
LEF4 $518
line 492
;492:				fov_x = zoomFov;
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 493
;493:			} else {
ADDRGP4 $514
JUMPV
LABELV $518
line 494
;494:				fov_x = fov_x + f * ( zoomFov - fov_x );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 28
INDIRF4
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 495
;495:			}
line 496
;496:		} else {
ADDRGP4 $514
JUMPV
LABELV $513
line 497
;497:			f = ( cg.time - cg.zoomTime ) / (float)ZOOM_TIME;
ADDRLP4 28
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+109432
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1125515264
DIVF4
ASGNF4
line 498
;498:			if ( f > 1.0 ) {
ADDRLP4 28
INDIRF4
CNSTF4 1065353216
LEF4 $522
line 499
;499:				fov_x = fov_x;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ASGNF4
line 500
;500:			} else {
ADDRGP4 $523
JUMPV
LABELV $522
line 501
;501:				fov_x = zoomFov + f * ( fov_x - zoomFov );
ADDRLP4 36
ADDRLP4 8
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 36
INDIRF4
ADDRLP4 28
INDIRF4
ADDRLP4 0
INDIRF4
ADDRLP4 36
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 502
;502:			}
LABELV $523
line 503
;503:		}
LABELV $514
line 504
;504:	}
LABELV $497
line 506
;505:
;506:	x = cg.refdef.width / tan( fov_x / 360 * M_PI );
CNSTF4 1078530011
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
DIVF4
MULF4
ARGF4
ADDRLP4 36
ADDRGP4 tan
CALLF4
ASGNF4
ADDRLP4 12
ADDRGP4 cg+109048+8
INDIRI4
CVIF4 4
ADDRLP4 36
INDIRF4
DIVF4
ASGNF4
line 507
;507:	fov_y = atan2( cg.refdef.height, x );
ADDRGP4 cg+109048+12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 atan2
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 40
INDIRF4
ASGNF4
line 508
;508:	fov_y = fov_y * 360 / M_PI;
ADDRLP4 4
CNSTF4 1135869952
ADDRLP4 4
INDIRF4
MULF4
CNSTF4 1078530011
DIVF4
ASGNF4
line 511
;509:
;510:	// warp if underwater
;511:	contents = CG_PointContents( cg.refdef.vieworg, -1 );
ADDRGP4 cg+109048+24
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 44
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 44
INDIRI4
ASGNI4
line 512
;512:	if ( contents & ( CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) ){
ADDRLP4 16
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $530
line 513
;513:		phase = cg.time / 1000.0 * WAVE_FREQUENCY * M_PI * 2;
ADDRLP4 32
CNSTF4 1073741824
CNSTF4 1078530011
CNSTF4 1053609165
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
CNSTF4 1148846080
DIVF4
MULF4
MULF4
MULF4
ASGNF4
line 514
;514:		v = WAVE_AMPLITUDE * sin( phase );
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 48
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 24
CNSTF4 1065353216
ADDRLP4 48
INDIRF4
MULF4
ASGNF4
line 515
;515:		fov_x += v;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 24
INDIRF4
ADDF4
ASGNF4
line 516
;516:		fov_y -= v;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 24
INDIRF4
SUBF4
ASGNF4
line 517
;517:		inwater = qtrue;
ADDRLP4 20
CNSTI4 1
ASGNI4
line 518
;518:	}
ADDRGP4 $531
JUMPV
LABELV $530
line 519
;519:	else {
line 520
;520:		inwater = qfalse;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 521
;521:	}
LABELV $531
line 525
;522:
;523:
;524:	// set it
;525:	cg.refdef.fov_x = fov_x;
ADDRGP4 cg+109048+16
ADDRLP4 0
INDIRF4
ASGNF4
line 526
;526:	cg.refdef.fov_y = fov_y;
ADDRGP4 cg+109048+20
ADDRLP4 4
INDIRF4
ASGNF4
line 528
;527:
;528:	if ( !cg.zoomed ) {
ADDRGP4 cg+109428
INDIRI4
CNSTI4 0
NEI4 $537
line 529
;529:		cg.zoomSensitivity = 1;
ADDRGP4 cg+109436
CNSTF4 1065353216
ASGNF4
line 530
;530:	} else {
ADDRGP4 $538
JUMPV
LABELV $537
line 531
;531:		cg.zoomSensitivity = cg.refdef.fov_y / 75.0;
ADDRGP4 cg+109436
ADDRGP4 cg+109048+20
INDIRF4
CNSTF4 1117126656
DIVF4
ASGNF4
line 532
;532:	}
LABELV $538
line 534
;533:
;534:	return inwater;
ADDRLP4 20
INDIRI4
RETI4
LABELV $495
endproc CG_CalcFov 52 8
proc CG_DamageBlendBlob 164 12
line 545
;535:}
;536:
;537:
;538:
;539:/*
;540:===============
;541:CG_DamageBlendBlob
;542:
;543:===============
;544:*/
;545:static void CG_DamageBlendBlob( void ) {
line 550
;546:	int			t;
;547:	int			maxTime;
;548:	refEntity_t		ent;
;549:
;550:	if ( !cg_damageDraw.integer ) {
ADDRGP4 cg_damageDraw+12
INDIRI4
CNSTI4 0
NEI4 $545
line 551
;551:		return;
ADDRGP4 $544
JUMPV
LABELV $545
line 554
;552:	}
;553:
;554:	if ( !cg.damageValue ) {
ADDRGP4 cg+130852
INDIRF4
CNSTF4 0
NEF4 $548
line 555
;555:		return;
ADDRGP4 $544
JUMPV
LABELV $548
line 563
;556:	}
;557:
;558:	//if (cg.cameraMode) {
;559:	//	return;
;560:	//}
;561:
;562:	// ragePro systems can't fade blends, so don't obscure the screen
;563:	if ( cgs.glconfig.hardwareType == GLHW_RAGEPRO ) {
ADDRGP4 cgs+20100+11288
INDIRI4
CNSTI4 3
NEI4 $551
line 564
;564:		return;
ADDRGP4 $544
JUMPV
LABELV $551
line 567
;565:	}
;566:
;567:	maxTime = DAMAGE_TIME;
ADDRLP4 144
CNSTI4 500
ASGNI4
line 568
;568:	t = cg.time - cg.damageTime;
ADDRLP4 140
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ADDRGP4 cg+130840
INDIRF4
SUBF4
CVFI4 4
ASGNI4
line 569
;569:	if ( t <= 0 || t >= maxTime ) {
ADDRLP4 140
INDIRI4
CNSTI4 0
LEI4 $559
ADDRLP4 140
INDIRI4
ADDRLP4 144
INDIRI4
LTI4 $557
LABELV $559
line 570
;570:		return;
ADDRGP4 $544
JUMPV
LABELV $557
line 574
;571:	}
;572:
;573:
;574:	memset( &ent, 0, sizeof( ent ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 575
;575:	ent.reType = RT_SPRITE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 576
;576:	ent.renderfx = RF_FIRST_PERSON;
ADDRLP4 0+4
CNSTI4 4
ASGNI4
line 578
;577:
;578:	VectorMA( cg.refdef.vieworg, 8, cg.refdef.viewaxis[0], ent.origin );
ADDRLP4 0+68
ADDRGP4 cg+109048+24
INDIRF4
CNSTF4 1090519040
ADDRGP4 cg+109048+36
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+4
ADDRGP4 cg+109048+24+4
INDIRF4
CNSTF4 1090519040
ADDRGP4 cg+109048+36+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+8
ADDRGP4 cg+109048+24+8
INDIRF4
CNSTF4 1090519040
ADDRGP4 cg+109048+36+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 579
;579:	VectorMA( ent.origin, cg.damageX * -8, cg.refdef.viewaxis[1], ent.origin );
ADDRLP4 0+68
ADDRLP4 0+68
INDIRF4
ADDRGP4 cg+109048+36+12
INDIRF4
CNSTF4 3238002688
ADDRGP4 cg+130844
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+4
ADDRLP4 0+68+4
INDIRF4
ADDRGP4 cg+109048+36+12+4
INDIRF4
CNSTF4 3238002688
ADDRGP4 cg+130844
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
ADDRGP4 cg+109048+36+12+8
INDIRF4
CNSTF4 3238002688
ADDRGP4 cg+130844
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 580
;580:	VectorMA( ent.origin, cg.damageY * 8, cg.refdef.viewaxis[2], ent.origin );
ADDRLP4 0+68
ADDRLP4 0+68
INDIRF4
ADDRGP4 cg+109048+36+24
INDIRF4
CNSTF4 1090519040
ADDRGP4 cg+130848
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+4
ADDRLP4 0+68+4
INDIRF4
ADDRGP4 cg+109048+36+24+4
INDIRF4
CNSTF4 1090519040
ADDRGP4 cg+130848
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
ADDRGP4 cg+109048+36+24+8
INDIRF4
CNSTF4 1090519040
ADDRGP4 cg+130848
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 582
;581:
;582:	ent.radius = cg.damageValue * 3;
ADDRLP4 0+132
CNSTF4 1077936128
ADDRGP4 cg+130852
INDIRF4
MULF4
ASGNF4
line 583
;583:	ent.customShader = cgs.media.viewBloodShader;
ADDRLP4 0+112
ADDRGP4 cgs+156680+268
INDIRI4
ASGNI4
line 584
;584:	ent.shaderRGBA[0] = 255;
ADDRLP4 0+116
CNSTU1 255
ASGNU1
line 585
;585:	ent.shaderRGBA[1] = 255;
ADDRLP4 0+116+1
CNSTU1 255
ASGNU1
line 586
;586:	ent.shaderRGBA[2] = 255;
ADDRLP4 0+116+2
CNSTU1 255
ASGNU1
line 587
;587:	ent.shaderRGBA[3] = 200 * ( 1.0 - ((float)t / maxTime) );
ADDRLP4 156
CNSTF4 1128792064
CNSTF4 1065353216
ADDRLP4 140
INDIRI4
CVIF4 4
ADDRLP4 144
INDIRI4
CVIF4 4
DIVF4
SUBF4
MULF4
ASGNF4
ADDRLP4 160
CNSTF4 1325400064
ASGNF4
ADDRLP4 156
INDIRF4
ADDRLP4 160
INDIRF4
LTF4 $643
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
ADDRGP4 $644
JUMPV
LABELV $643
ADDRLP4 152
ADDRLP4 156
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $644
ADDRLP4 0+116+3
ADDRLP4 152
INDIRU4
CVUU1 4
ASGNU1
line 588
;588:	trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 589
;589:}
LABELV $544
endproc CG_DamageBlendBlob 164 12
proc CG_CalcViewValues 40 12
line 599
;590:
;591:
;592:/*
;593:===============
;594:CG_CalcViewValues
;595:
;596:Sets cg.refdef view values
;597:===============
;598:*/
;599:static int CG_CalcViewValues( void ) {
line 602
;600:	playerState_t	*ps;
;601:
;602:	memset( &cg.refdef, 0, sizeof( cg.refdef ) );
ADDRGP4 cg+109048
ARGP4
CNSTI4 0
ARGI4
CNSTI4 368
ARGI4
ADDRGP4 memset
CALLP4
pop
line 609
;603:
;604:	// strings for in game rendering
;605:	// Q_strncpyz( cg.refdef.text[0], "Park Ranger", sizeof(cg.refdef.text[0]) );
;606:	// Q_strncpyz( cg.refdef.text[1], "19", sizeof(cg.refdef.text[1]) );
;607:
;608:	// calculate size of 3D view
;609:	CG_CalcVrect();
ADDRGP4 CG_CalcVrect
CALLV
pop
line 611
;610:
;611:	ps = &cg.predictedPlayerState;
ADDRLP4 0
ADDRGP4 cg+107636
ASGNP4
line 627
;612:/*
;613:	if (cg.cameraMode) {
;614:		vec3_t origin, angles;
;615:		if (trap_getCameraInfo(cg.time, &origin, &angles)) {
;616:			VectorCopy(origin, cg.refdef.vieworg);
;617:			angles[ROLL] = 0;
;618:			VectorCopy(angles, cg.refdefViewAngles);
;619:			AnglesToAxis( cg.refdefViewAngles, cg.refdef.viewaxis );
;620:			return CG_CalcFov();
;621:		} else {
;622:			cg.cameraMode = qfalse;
;623:		}
;624:	}
;625:*/
;626:	// intermission view
;627:	if ( ps->pm_type == PM_INTERMISSION ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 5
NEI4 $649
line 628
;628:		VectorCopy( ps->origin, cg.refdef.vieworg );
ADDRGP4 cg+109048+24
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 629
;629:		VectorCopy( ps->viewangles, cg.refdefViewAngles );
ADDRGP4 cg+109416
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
INDIRB
ASGNB 12
line 630
;630:		AnglesToAxis( cg.refdefViewAngles, cg.refdef.viewaxis );
ADDRGP4 cg+109416
ARGP4
ADDRGP4 cg+109048+36
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 631
;631:		return CG_CalcFov();
ADDRLP4 4
ADDRGP4 CG_CalcFov
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $645
JUMPV
LABELV $649
line 634
;632:	}
;633:
;634:	cg.bobcycle = ( ps->bobCycle & 128 ) >> 7;
ADDRGP4 cg+130924
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 7
RSHI4
ASGNI4
line 635
;635:	cg.bobfracsin = fabs( sin( ( ps->bobCycle & 127 ) / 127.0 * M_PI ) );
CNSTF4 1078530011
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 127
BANDI4
CVIF4 4
CNSTF4 1123942400
DIVF4
MULF4
ARGF4
ADDRLP4 4
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRGP4 cg+130920
ADDRLP4 8
INDIRF4
ASGNF4
line 636
;636:	cg.xyspeed = sqrt( ps->velocity[0] * ps->velocity[0] +
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ASGNF4
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ASGNF4
ADDRLP4 16
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDRLP4 20
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 24
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRGP4 cg+130928
ADDRLP4 24
INDIRF4
ASGNF4
line 640
;637:		ps->velocity[1] * ps->velocity[1] );
;638:
;639:
;640:	VectorCopy( ps->origin, cg.refdef.vieworg );
ADDRGP4 cg+109048+24
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 641
;641:	VectorCopy( ps->viewangles, cg.refdefViewAngles );
ADDRGP4 cg+109416
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
INDIRB
ASGNB 12
line 643
;642:
;643:	if (cg_cameraOrbit.integer) {
ADDRGP4 cg_cameraOrbit+12
INDIRI4
CNSTI4 0
EQI4 $663
line 644
;644:		if (cg.time > cg.nextOrbitTime) {
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+130932
INDIRI4
LEI4 $666
line 645
;645:			cg.nextOrbitTime = cg.time + cg_cameraOrbitDelay.integer;
ADDRGP4 cg+130932
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg_cameraOrbitDelay+12
INDIRI4
ADDI4
ASGNI4
line 646
;646:			cg_thirdPersonAngle.value += cg_cameraOrbit.value;
ADDRLP4 28
ADDRGP4 cg_thirdPersonAngle+8
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRGP4 cg_cameraOrbit+8
INDIRF4
ADDF4
ASGNF4
line 647
;647:		}
LABELV $666
line 648
;648:	}
LABELV $663
line 650
;649:	// add error decay
;650:	if ( cg_errorDecay.value > 0 ) {
ADDRGP4 cg_errorDecay+8
INDIRF4
CNSTF4 0
LEF4 $675
line 654
;651:		int		t;
;652:		float	f;
;653:
;654:		t = cg.time - cg.predictedErrorTime;
ADDRLP4 32
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+108836
INDIRI4
SUBI4
ASGNI4
line 655
;655:		f = ( cg_errorDecay.value - t ) / cg_errorDecay.value;
ADDRLP4 28
ADDRGP4 cg_errorDecay+8
INDIRF4
ADDRLP4 32
INDIRI4
CVIF4 4
SUBF4
ADDRGP4 cg_errorDecay+8
INDIRF4
DIVF4
ASGNF4
line 656
;656:		if ( f > 0 && f < 1 ) {
ADDRLP4 36
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 36
INDIRF4
CNSTF4 0
LEF4 $682
ADDRLP4 36
INDIRF4
CNSTF4 1065353216
GEF4 $682
line 657
;657:			VectorMA( cg.refdef.vieworg, f, cg.predictedError, cg.refdef.vieworg );
ADDRGP4 cg+109048+24
ADDRGP4 cg+109048+24
INDIRF4
ADDRGP4 cg+108840
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+109048+24+4
ADDRGP4 cg+109048+24+4
INDIRF4
ADDRGP4 cg+108840+4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+109048+24+8
ADDRGP4 cg+109048+24+8
INDIRF4
ADDRGP4 cg+108840+8
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ADDF4
ASGNF4
line 658
;658:		} else {
ADDRGP4 $683
JUMPV
LABELV $682
line 659
;659:			cg.predictedErrorTime = 0;
ADDRGP4 cg+108836
CNSTI4 0
ASGNI4
line 660
;660:		}
LABELV $683
line 661
;661:	}
LABELV $675
line 663
;662:
;663:	if ( cg.renderingThirdPerson ) {
ADDRGP4 cg+107628
INDIRI4
CNSTI4 0
EQI4 $706
line 665
;664:		// back away from character
;665:		CG_OffsetThirdPersonView();
ADDRGP4 CG_OffsetThirdPersonView
CALLV
pop
line 666
;666:	} else {
ADDRGP4 $707
JUMPV
LABELV $706
line 668
;667:		// offset for local bobbing and kicks
;668:		CG_OffsetFirstPersonView();
ADDRGP4 CG_OffsetFirstPersonView
CALLV
pop
line 669
;669:	}
LABELV $707
line 672
;670:
;671:	// position eye reletive to origin
;672:	AnglesToAxis( cg.refdefViewAngles, cg.refdef.viewaxis );
ADDRGP4 cg+109416
ARGP4
ADDRGP4 cg+109048+36
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 674
;673:
;674:	if ( cg.hyperspace ) {
ADDRGP4 cg+107632
INDIRI4
CNSTI4 0
EQI4 $712
line 675
;675:		cg.refdef.rdflags |= RDF_NOWORLDMODEL | RDF_HYPERSPACE;
ADDRLP4 28
ADDRGP4 cg+109048+76
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 5
BORI4
ASGNI4
line 676
;676:	}
LABELV $712
line 679
;677:
;678:	// field of view
;679:	return CG_CalcFov();
ADDRLP4 28
ADDRGP4 CG_CalcFov
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
RETI4
LABELV $645
endproc CG_CalcViewValues 40 12
proc CG_PowerupTimerSounds 16 16
line 688
;680:}
;681:
;682:
;683:/*
;684:=====================
;685:CG_PowerupTimerSounds
;686:=====================
;687:*/
;688:static void CG_PowerupTimerSounds( void ) {
line 693
;689:	int		i;
;690:	int		t;
;691:
;692:	// powerup timers going away
;693:	for ( i = 0 ; i < MAX_POWERUPS ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $718
line 694
;694:		t = cg.snap->ps.powerups[i];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 356
ADDP4
ADDP4
INDIRI4
ASGNI4
line 695
;695:		if ( t <= cg.time ) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+107604
INDIRI4
GTI4 $723
line 696
;696:			continue;
ADDRGP4 $719
JUMPV
LABELV $723
line 698
;697:		}
;698:		if ( t - cg.time >= POWERUP_BLINKS * POWERUP_BLINK_TIME ) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CNSTI4 5000
LTI4 $726
line 699
;699:			continue;
ADDRGP4 $719
JUMPV
LABELV $726
line 701
;700:		}
;701:		if ( ( t - cg.time ) / POWERUP_BLINK_TIME != ( t - cg.oldTime ) / POWERUP_BLINK_TIME ) {
ADDRLP4 12
CNSTI4 1000
ASGNI4
ADDRLP4 0
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
ADDRLP4 12
INDIRI4
DIVI4
ADDRLP4 0
INDIRI4
ADDRGP4 cg+107608
INDIRI4
SUBI4
ADDRLP4 12
INDIRI4
DIVI4
EQI4 $729
line 702
;702:			trap_S_StartSound( NULL, cg.snap->ps.clientNum, CHAN_ITEM, cgs.media.wearOffSound );
CNSTP4 0
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 cgs+156680+620
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 703
;703:		}
LABELV $729
line 704
;704:	}
LABELV $719
line 693
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 16
LTI4 $718
line 705
;705:}
LABELV $717
endproc CG_PowerupTimerSounds 16 16
export CG_AddBufferedSound
proc CG_AddBufferedSound 4 0
line 712
;706:
;707:/*
;708:=====================
;709:CG_AddBufferedSound
;710:=====================
;711:*/
;712:void CG_AddBufferedSound( sfxHandle_t sfx ) {
line 713
;713:	if ( !sfx )
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $737
line 714
;714:		return;
ADDRGP4 $736
JUMPV
LABELV $737
line 715
;715:	cg.soundBuffer[cg.soundBufferIn] = sfx;
ADDRGP4 cg+130700
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+130712
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 716
;716:	cg.soundBufferIn = (cg.soundBufferIn + 1) % MAX_SOUNDBUFFER;
ADDRGP4 cg+130700
ADDRGP4 cg+130700
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 20
MODI4
ASGNI4
line 717
;717:	if (cg.soundBufferIn == cg.soundBufferOut) {
ADDRGP4 cg+130700
INDIRI4
ADDRGP4 cg+130704
INDIRI4
NEI4 $743
line 718
;718:		cg.soundBufferOut++;
ADDRLP4 0
ADDRGP4 cg+130704
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 719
;719:	}
LABELV $743
line 720
;720:}
LABELV $736
endproc CG_AddBufferedSound 4 0
proc CG_PlayBufferedSounds 0 8
line 727
;721:
;722:/*
;723:=====================
;724:CG_PlayBufferedSounds
;725:=====================
;726:*/
;727:static void CG_PlayBufferedSounds( void ) {
line 728
;728:	if ( cg.soundTime < cg.time ) {
ADDRGP4 cg+130708
INDIRI4
ADDRGP4 cg+107604
INDIRI4
GEI4 $749
line 729
;729:		if (cg.soundBufferOut != cg.soundBufferIn && cg.soundBuffer[cg.soundBufferOut]) {
ADDRGP4 cg+130704
INDIRI4
ADDRGP4 cg+130700
INDIRI4
EQI4 $753
ADDRGP4 cg+130704
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+130712
ADDP4
INDIRI4
CNSTI4 0
EQI4 $753
line 730
;730:			trap_S_StartLocalSound(cg.soundBuffer[cg.soundBufferOut], CHAN_ANNOUNCER);
ADDRGP4 cg+130704
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+130712
ADDP4
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 731
;731:			cg.soundBuffer[cg.soundBufferOut] = 0;
ADDRGP4 cg+130704
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+130712
ADDP4
CNSTI4 0
ASGNI4
line 732
;732:			cg.soundBufferOut = (cg.soundBufferOut + 1) % MAX_SOUNDBUFFER;
ADDRGP4 cg+130704
ADDRGP4 cg+130704
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 20
MODI4
ASGNI4
line 733
;733:			cg.soundTime = cg.time + 750;
ADDRGP4 cg+130708
ADDRGP4 cg+107604
INDIRI4
CNSTI4 750
ADDI4
ASGNI4
line 734
;734:		}
LABELV $753
line 735
;735:	}
LABELV $749
line 736
;736:}
LABELV $748
endproc CG_PlayBufferedSounds 0 8
export CG_DrawActiveFrame
proc CG_DrawActiveFrame 80 32
line 747
;737:
;738://=========================================================================
;739:
;740:/*
;741:=================
;742:CG_DrawActiveFrame
;743:
;744:Generates and draws a game scene and status information at the given time.
;745:=================
;746:*/
;747:void CG_DrawActiveFrame( int serverTime, stereoFrame_t stereoView, qboolean demoPlayback ) {
line 749
;748:	int		inwater;
;749:	int			clientsHit = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 751
;750:
;751:	cg.clientsHit = 0;
ADDRGP4 cg+162104
CNSTI4 0
ASGNI4
line 752
;752:	cg.time = serverTime;
ADDRGP4 cg+107604
ADDRFP4 0
INDIRI4
ASGNI4
line 759
;753:
;754://unlagged - lag simulation #1
;755:	// adjust the clock to reflect latent snaps
;756:	//cg.time -= cg_latentSnaps.integer * (1000 / sv_fps.integer);
;757://unlagged - lag simulation #1
;758:
;759:	cg.demoPlayback = demoPlayback;
ADDRGP4 cg+8
ADDRFP4 8
INDIRI4
ASGNI4
line 762
;760:
;761:	// update cvars
;762:	CG_UpdateCvars();
ADDRGP4 CG_UpdateCvars
CALLV
pop
line 766
;763:
;764:	// if we are only updating the screen as a loading
;765:	// pacifier, don't even try to read snapshots
;766:	if ( cg.infoScreenText[0] != 0 ) {
ADDRGP4 cg+109440
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $771
line 767
;767:		CG_DrawInformation();
ADDRGP4 CG_DrawInformation
CALLV
pop
line 768
;768:		return;
ADDRGP4 $767
JUMPV
LABELV $771
line 771
;769:	}
;770:
;771:	if (cg_aimType.integer > 3 || cg_aimType.integer < 0 )
ADDRGP4 cg_aimType+12
INDIRI4
CNSTI4 3
GTI4 $778
ADDRGP4 cg_aimType+12
INDIRI4
CNSTI4 0
GEI4 $774
LABELV $778
line 772
;772:	{
line 773
;773:		trap_Cvar_Set("cg_aimType", "2");
ADDRGP4 $779
ARGP4
ADDRGP4 $780
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 774
;774:		cg_aimType.integer = 2;
ADDRGP4 cg_aimType+12
CNSTI4 2
ASGNI4
line 775
;775:	}
LABELV $774
line 782
;776:
;777:	//memset(&cg.rawPacket, 0, sizeof(aimtype4packet_t));
;778:
;779:	// any looped sounds will be respecified as entities
;780:	// are added to the render list
;781:	//CG_Printf("Before ClearLoopSounds: %i -- %i\n", cgs.clientinfo[cg.clientNum].powerups, cgs.clientinfo[cg.clientNum].score);
;782:	trap_S_ClearLoopingSounds(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 trap_S_ClearLoopingSounds
CALLV
pop
line 787
;783:	//CG_Printf("After ClearLoopSounds: %i -- %i\n", cgs.clientinfo[cg.clientNum].powerups, cgs.clientinfo[cg.clientNum].score);
;784:
;785:	// clear all the render lists
;786:	//CG_Printf("Before ClearScene: %i -- %i\n", cgs.clientinfo[cg.clientNum].powerups, cgs.clientinfo[cg.clientNum].score);
;787:	trap_R_ClearScene();
ADDRGP4 trap_R_ClearScene
CALLV
pop
line 792
;788:	//CG_Printf("After ClearScene: %i -- %i\n", cgs.clientinfo[cg.clientNum].powerups, cgs.clientinfo[cg.clientNum].score);
;789:
;790:	// set up cg.snap and possibly cg.nextSnap
;791:	//CG_Printf("Before CG_ProcessSnapshot: %i -- %i\n", cgs.clientinfo[cg.clientNum].powerups, cgs.clientinfo[cg.clientNum].score);
;792:	CG_ProcessSnapshots();
ADDRGP4 CG_ProcessSnapshots
CALLV
pop
line 797
;793:	//CG_Printf("After CG_ProcessSnapshot: %i -- %i\n", cgs.clientinfo[cg.clientNum].powerups, cgs.clientinfo[cg.clientNum].score);
;794:
;795:	// if we haven't received any snapshots yet, all
;796:	// we can draw is the information screen
;797:	if ( !cg.snap || ( cg.snap->snapFlags & SNAPFLAG_NOT_ACTIVE ) ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $786
ADDRGP4 cg+36
INDIRP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $782
LABELV $786
line 798
;798:		CG_DrawInformation();
ADDRGP4 CG_DrawInformation
CALLV
pop
line 799
;799:		return;
ADDRGP4 $767
JUMPV
LABELV $782
line 808
;800:	}
;801:
;802:	// let the client system know what our weapon and zoom settings are
;803:	// Can't change weapons without this.
;804:	//CG_Printf("%i\n", cg.weaponSelect);
;805:	// trap_SetUserCmdValue( cg.weaponSelect, cg.zoomSensitivity );
;806:
;807:	// this counter will be bumped for every valid scene we generate
;808:	cg.clientFrame++;
ADDRLP4 8
ADDRGP4 cg
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 811
;809:
;810:	// update cg.predictedPlayerState
;811:	CG_PredictPlayerState();
ADDRGP4 CG_PredictPlayerState
CALLV
pop
line 815
;812:	//CG_Printf("Begin CG_PredictPlayerState: %i -- %i\n", cgs.clientinfo[cg.clientNum].powerups, cgs.clientinfo[cg.clientNum].score);
;813:
;814:	// decide on third person view
;815:	cg.renderingThirdPerson = cg_thirdPerson.integer || (cg.snap->ps.stats[STAT_HEALTH] <= 0);
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 cg_thirdPerson+12
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $793
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
GTI4 $791
LABELV $793
ADDRLP4 12
CNSTI4 1
ASGNI4
ADDRGP4 $792
JUMPV
LABELV $791
ADDRLP4 12
CNSTI4 0
ASGNI4
LABELV $792
ADDRGP4 cg+107628
ADDRLP4 12
INDIRI4
ASGNI4
line 818
;816:
;817:	// build cg.refdef
;818:	inwater = CG_CalcViewValues();
ADDRLP4 20
ADDRGP4 CG_CalcViewValues
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 20
INDIRI4
ASGNI4
line 821
;819:
;820:	// first person blend blobs, done after AnglesToAxis
;821:	if ( !cg.renderingThirdPerson ) {
ADDRGP4 cg+107628
INDIRI4
CNSTI4 0
NEI4 $794
line 822
;822:		CG_DamageBlendBlob();
ADDRGP4 CG_DamageBlendBlob
CALLV
pop
line 823
;823:	}
LABELV $794
line 826
;824:
;825:	// build the render lists
;826:	if ( !cg.hyperspace ) {
ADDRGP4 cg+107632
INDIRI4
CNSTI4 0
NEI4 $797
line 827
;827:		CG_AddPacketEntities();			// adter calcViewValues, so predicted player state is correct
ADDRGP4 CG_AddPacketEntities
CALLV
pop
line 828
;828:		CG_AddMarks();
ADDRGP4 CG_AddMarks
CALLV
pop
line 829
;829:		CG_AddParticles ();
ADDRGP4 CG_AddParticles
CALLV
pop
line 830
;830:		CG_AddLocalEntities();
ADDRGP4 CG_AddLocalEntities
CALLV
pop
line 831
;831:	}
LABELV $797
line 832
;832:	CG_AddViewWeapon( &cg.predictedPlayerState );
ADDRGP4 cg+107636
ARGP4
ADDRGP4 CG_AddViewWeapon
CALLV
pop
line 835
;833:
;834:	// add buffered sounds
;835:	CG_PlayBufferedSounds();
ADDRGP4 CG_PlayBufferedSounds
CALLV
pop
line 838
;836:
;837:	// play buffered voice chats
;838:	CG_PlayBufferedVoiceChats();
ADDRGP4 CG_PlayBufferedVoiceChats
CALLV
pop
line 841
;839:
;840:	// finish up the rest of the refdef
;841:	if ( cg.testModelEntity.hModel ) {
ADDRGP4 cg+130936+8
INDIRI4
CNSTI4 0
EQI4 $801
line 842
;842:		CG_AddTestModel();
ADDRGP4 CG_AddTestModel
CALLV
pop
line 843
;843:	}
LABELV $801
line 844
;844:	cg.refdef.time = cg.time;
ADDRGP4 cg+109048+72
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 845
;845:	memcpy( cg.refdef.areamask, cg.snap->areamask, sizeof( cg.refdef.areamask ) );
ADDRGP4 cg+109048+80
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 12
ADDP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 848
;846:
;847:	// warning sounds when powerup is wearing off
;848:	CG_PowerupTimerSounds();
ADDRGP4 CG_PowerupTimerSounds
CALLV
pop
line 851
;849:
;850:	// update audio positions
;851:	trap_S_Respatialize( cg.snap->ps.clientNum, cg.refdef.vieworg, cg.refdef.viewaxis, inwater );
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+109048+24
ARGP4
ADDRGP4 cg+109048+36
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 trap_S_Respatialize
CALLV
pop
line 854
;852:
;853:	// make sure the lagometerSample and frame timing isn't done twice when in stereo
;854:	if ( stereoView != STEREO_RIGHT ) {
ADDRFP4 4
INDIRI4
CNSTI4 2
EQI4 $818
line 855
;855:		cg.frametime = cg.time - cg.oldTime;
ADDRGP4 cg+107600
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+107608
INDIRI4
SUBI4
ASGNI4
line 856
;856:		if ( cg.frametime < 0 ) {
ADDRGP4 cg+107600
INDIRI4
CNSTI4 0
GEI4 $823
line 857
;857:			cg.frametime = 0;
ADDRGP4 cg+107600
CNSTI4 0
ASGNI4
line 858
;858:		}
LABELV $823
line 859
;859:		cg.oldTime = cg.time;
ADDRGP4 cg+107608
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 860
;860:		CG_AddLagometerFrameInfo();
ADDRGP4 CG_AddLagometerFrameInfo
CALLV
pop
line 861
;861:	}
LABELV $818
line 862
;862:	if (cg_timescale.value != cg_timescaleFadeEnd.value) {
ADDRGP4 cg_timescale+8
INDIRF4
ADDRGP4 cg_timescaleFadeEnd+8
INDIRF4
EQF4 $829
line 863
;863:		if (cg_timescale.value < cg_timescaleFadeEnd.value) {
ADDRGP4 cg_timescale+8
INDIRF4
ADDRGP4 cg_timescaleFadeEnd+8
INDIRF4
GEF4 $833
line 864
;864:			cg_timescale.value += cg_timescaleFadeSpeed.value * ((float)cg.frametime) / 1000;
ADDRLP4 24
ADDRGP4 cg_timescale+8
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
ADDRGP4 cg_timescaleFadeSpeed+8
INDIRF4
ADDRGP4 cg+107600
INDIRI4
CVIF4 4
MULF4
CNSTF4 1148846080
DIVF4
ADDF4
ASGNF4
line 865
;865:			if (cg_timescale.value > cg_timescaleFadeEnd.value)
ADDRGP4 cg_timescale+8
INDIRF4
ADDRGP4 cg_timescaleFadeEnd+8
INDIRF4
LEF4 $834
line 866
;866:				cg_timescale.value = cg_timescaleFadeEnd.value;
ADDRGP4 cg_timescale+8
ADDRGP4 cg_timescaleFadeEnd+8
INDIRF4
ASGNF4
line 867
;867:		}
ADDRGP4 $834
JUMPV
LABELV $833
line 868
;868:		else {
line 869
;869:			cg_timescale.value -= cg_timescaleFadeSpeed.value * ((float)cg.frametime) / 1000;
ADDRLP4 24
ADDRGP4 cg_timescale+8
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
ADDRGP4 cg_timescaleFadeSpeed+8
INDIRF4
ADDRGP4 cg+107600
INDIRI4
CVIF4 4
MULF4
CNSTF4 1148846080
DIVF4
SUBF4
ASGNF4
line 870
;870:			if (cg_timescale.value < cg_timescaleFadeEnd.value)
ADDRGP4 cg_timescale+8
INDIRF4
ADDRGP4 cg_timescaleFadeEnd+8
INDIRF4
GEF4 $849
line 871
;871:				cg_timescale.value = cg_timescaleFadeEnd.value;
ADDRGP4 cg_timescale+8
ADDRGP4 cg_timescaleFadeEnd+8
INDIRF4
ASGNF4
LABELV $849
line 872
;872:		}
LABELV $834
line 873
;873:		if (cg_timescaleFadeSpeed.value) {
ADDRGP4 cg_timescaleFadeSpeed+8
INDIRF4
CNSTF4 0
EQF4 $855
line 874
;874:			trap_Cvar_Set("timescale", va("%f", cg_timescale.value));
ADDRGP4 $859
ARGP4
ADDRGP4 cg_timescale+8
INDIRF4
ARGF4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $858
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 875
;875:		}
LABELV $855
line 876
;876:	}
LABELV $829
line 879
;877:
;878:	// actually issue the rendering calls
;879:	CG_DrawActive( stereoView );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 CG_DrawActive
CALLV
pop
line 885
;880:	//CG_Printf("End DrawActiveFrame: %i -- %i\n", cgs.clientinfo[cg.clientNum].powerups, cgs.clientinfo[cg.clientNum].score);
;881:
;882:	//Auto recording
;883:	/* NEED TO CLEAN THE HOSTNAME STRING */
;884:	//FIXME: Should do 1 date/time fetch and just use cg.time to increment it -- for all time referencing functions.
;885:	if ( cg_autoRecord.integer && !cgs.autoRecording && cg_autoRecord.integer && cg.warmup >= 0 && cg.warmup < 5 && cg.predictedPlayerState.pm_type != PM_INTERMISSION ) {
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRGP4 cg_autoRecord+12
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $861
ADDRGP4 cgs+157864
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $861
ADDRGP4 cg_autoRecord+12
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $861
ADDRGP4 cg+130804
INDIRI4
ADDRLP4 24
INDIRI4
LTI4 $861
ADDRLP4 28
CNSTI4 5
ASGNI4
ADDRGP4 cg+130804
INDIRI4
ADDRLP4 28
INDIRI4
GEI4 $861
ADDRGP4 cg+107636+4
INDIRI4
ADDRLP4 28
INDIRI4
EQI4 $861
line 886
;886:		char	*Hn = Q_CleanString( autoFile.hostname );
ADDRGP4 autoFile
ARGP4
ADDRLP4 72
ADDRGP4 Q_CleanString
CALLP4
ASGNP4
ADDRLP4 68
ADDRLP4 72
INDIRP4
ASGNP4
line 889
;887:		qtime_t	qtm;
;888:		//Month.Day.Year--Hostname-Mapname-HH.MM
;889:		trap_RealTime(&qtm);
ADDRLP4 32
ARGP4
ADDRGP4 trap_RealTime
CALLI4
pop
line 890
;890:		cgs.autoRecording = qtrue;
ADDRGP4 cgs+157864
CNSTI4 1
ASGNI4
line 891
;891:		trap_SendConsoleCommand( va("g_synchronousclients 1\nrecord %i.%i.%i--%s-%s-%02i.%02i\ng_synchronousclients 0\n", qtm.tm_mon, qtm.tm_mday, (qtm.tm_year + 1900), Hn, autoFile.map, qtm.tm_hour, qtm.tm_min) );
ADDRGP4 $871
ARGP4
ADDRLP4 32+16
INDIRI4
ARGI4
ADDRLP4 32+12
INDIRI4
ARGI4
ADDRLP4 32+20
INDIRI4
CNSTI4 1900
ADDI4
ARGI4
ADDRLP4 68
INDIRP4
ARGP4
ADDRGP4 autoFile+1152
ARGP4
ADDRLP4 32+8
INDIRI4
ARGI4
ADDRLP4 32+4
INDIRI4
ARGI4
ADDRLP4 76
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 892
;892:	}
LABELV $861
line 894
;893:
;894:	if ( cg.alarmSet ) //Don't waste the extra CPU cycle.
ADDRGP4 cg+162084
INDIRI4
CNSTI4 0
EQI4 $878
line 895
;895:		CG_Alarm();
ADDRGP4 CG_Alarm
CALLV
pop
LABELV $878
line 897
;896:
;897:	if ( cg_stats.integer ) {
ADDRGP4 cg_stats+12
INDIRI4
CNSTI4 0
EQI4 $881
line 898
;898:		CG_Printf( "cg.clientFrame:%i\n", cg.clientFrame );
ADDRGP4 $884
ARGP4
ADDRGP4 cg
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 899
;899:	}
LABELV $881
line 902
;900:
;901:
;902:}
LABELV $767
endproc CG_DrawActiveFrame 80 32
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
LABELV $884
byte 1 99
byte 1 103
byte 1 46
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 70
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 58
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $871
byte 1 103
byte 1 95
byte 1 115
byte 1 121
byte 1 110
byte 1 99
byte 1 104
byte 1 114
byte 1 111
byte 1 110
byte 1 111
byte 1 117
byte 1 115
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 32
byte 1 49
byte 1 10
byte 1 114
byte 1 101
byte 1 99
byte 1 111
byte 1 114
byte 1 100
byte 1 32
byte 1 37
byte 1 105
byte 1 46
byte 1 37
byte 1 105
byte 1 46
byte 1 37
byte 1 105
byte 1 45
byte 1 45
byte 1 37
byte 1 115
byte 1 45
byte 1 37
byte 1 115
byte 1 45
byte 1 37
byte 1 48
byte 1 50
byte 1 105
byte 1 46
byte 1 37
byte 1 48
byte 1 50
byte 1 105
byte 1 10
byte 1 103
byte 1 95
byte 1 115
byte 1 121
byte 1 110
byte 1 99
byte 1 104
byte 1 114
byte 1 111
byte 1 110
byte 1 111
byte 1 117
byte 1 115
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 32
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $859
byte 1 37
byte 1 102
byte 1 0
align 1
LABELV $858
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 115
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $780
byte 1 50
byte 1 0
align 1
LABELV $779
byte 1 99
byte 1 103
byte 1 95
byte 1 97
byte 1 105
byte 1 109
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $233
byte 1 49
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $229
byte 1 51
byte 1 48
byte 1 0
align 1
LABELV $228
byte 1 99
byte 1 103
byte 1 95
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $154
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $137
byte 1 102
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $98
byte 1 67
byte 1 97
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 114
byte 1 101
byte 1 103
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 10
byte 1 0
