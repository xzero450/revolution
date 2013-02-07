export CG_PredictWeaponEffects
code
proc CG_PredictWeaponEffects 184 48
file "../cg_unlagged.c"
line 19
;1:#include "cg_local.h"
;2:
;3:// we'll need these prototypes
;4:void CG_ShotgunPattern( vec3_t origin, vec3_t origin2, int seed, int otherEntNum );
;5:void CG_Bullet( vec3_t end, int sourceEntityNum, vec3_t normal, qboolean flesh, int fleshEntityNum );
;6:
;7:// and this as well
;8:#define MACHINEGUN_SPREAD	200
;9:
;10:/*
;11:=======================
;12:CG_PredictWeaponEffects
;13:
;14:Draws predicted effects for the railgun, shotgun, and machinegun.  The
;15:lightning gun is done in CG_LightningBolt, since it was just a matter
;16:of setting the right origin and angles.
;17:=======================
;18:*/
;19:void CG_PredictWeaponEffects( centity_t *cent ) {
line 21
;20:	vec3_t		muzzlePoint, forward, right, up;
;21:	entityState_t *ent = &cent->currentState;
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
line 24
;22:
;23:	// if the client isn't us, forget it
;24:	if ( cent->currentState.number != cg.predictedPlayerState.clientNum ) {
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
EQI4 $78
line 25
;25:		return;
ADDRGP4 $77
JUMPV
LABELV $78
line 29
;26:	}
;27:
;28:	// if it's not switched on server-side, forget it (but still send the appropriate angles for aimtype 4)
;29:	if ( !cgs.delagHitscan ) {
ADDRGP4 cgs+157800
INDIRI4
CNSTI4 0
NEI4 $82
line 31
;30:		//CG_CreateAimtype4FireCmd();
;31:		return;
ADDRGP4 $77
JUMPV
LABELV $82
line 35
;32:	}
;33:	
;34:	// if we've opted out of unlagged
;35:	if (cg_aimType.integer == 0)
ADDRGP4 cg_aimType+12
INDIRI4
CNSTI4 0
NEI4 $85
line 36
;36:	{
line 37
;37:		return;
ADDRGP4 $77
JUMPV
LABELV $85
line 41
;38:	}
;39:
;40:	// get the muzzle point
;41:	VectorCopy( cg.predictedPlayerState.origin, muzzlePoint );
ADDRLP4 0
ADDRGP4 cg+107636+20
INDIRB
ASGNB 12
line 42
;42:	muzzlePoint[2] += cg.predictedPlayerState.viewheight;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRGP4 cg+107636+164
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 45
;43:
;44:	// get forward, right, and up
;45:	AngleVectors( cg.predictedPlayerState.viewangles, forward, right, up );
ADDRGP4 cg+107636+152
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 40
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 46
;46:	VectorMA( muzzlePoint, 14, forward, muzzlePoint );
ADDRLP4 52
CNSTF4 1096810496
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 52
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 52
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1096810496
ADDRLP4 12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 49
;47:
;48:	// was it a rail attack?
;49:	if ( ent->weapon == WP_RAILGUN ) {
ADDRLP4 24
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 7
NEI4 $101
line 52
;50:		//Spike: (byte >> 4) & 0xF
;51:		// do we have it on for the rail gun?
;52:		if ( cg_delag.integer & 1 || cg_delag.integer & 16 ) {
ADDRLP4 56
CNSTI4 0
ASGNI4
ADDRGP4 cg_delag+12
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 56
INDIRI4
NEI4 $107
ADDRGP4 cg_delag+12
INDIRI4
CNSTI4 16
BANDI4
ADDRLP4 56
INDIRI4
EQI4 $102
LABELV $107
line 57
;53:			trace_t trace;
;54:			vec3_t endPoint;
;55:
;56:			// trace forward
;57:			VectorMA( muzzlePoint, 8192, forward, endPoint );
ADDRLP4 128
CNSTF4 1174405120
ASGNF4
ADDRLP4 116
ADDRLP4 0
INDIRF4
ADDRLP4 128
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 116+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 128
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 116+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1174405120
ADDRLP4 12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 62
;58:
;59:			// THIS IS FOR DEBUGGING!
;60:			// you definitely *will* want something like this to test the backward reconciliation
;61:			// to make sure it's working *exactly* right
;62:			if ( cg_debugDelag.integer ) {
ADDRGP4 cg_debugDelag+12
INDIRI4
CNSTI4 0
EQI4 $114
line 64
;63:				// trace forward
;64:				CG_Trace( &trace, muzzlePoint, vec3_origin, vec3_origin, endPoint, cent->currentState.number, CONTENTS_BODY|CONTENTS_SOLID|CONTENTS_PLAYERCLIP );
ADDRLP4 60
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 132
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 132
INDIRP4
ARGP4
ADDRLP4 132
INDIRP4
ARGP4
ADDRLP4 116
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 33619969
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 67
;65:
;66:				// did we hit another player?
;67:				if ( trace.fraction < 1.0f && (trace.contents & CONTENTS_BODY || trace.contents & CONTENTS_PLAYERCLIP) ) {
ADDRLP4 60+8
INDIRF4
CNSTF4 1065353216
GEF4 $117
ADDRLP4 136
CNSTI4 0
ASGNI4
ADDRLP4 60+48
INDIRI4
CNSTI4 33554432
BANDI4
ADDRLP4 136
INDIRI4
NEI4 $122
ADDRLP4 60+48
INDIRI4
CNSTI4 65536
BANDI4
ADDRLP4 136
INDIRI4
EQI4 $117
LABELV $122
line 77
;68:					// if we have two snapshots (we're interpolating)
;69:					/*usercmd_t	cmd;
;70:					int			cmdNum;
;71:
;72:					cmdNum = trap_GetCurrentCmdNumber();
;73:					trap_GetUserCmd( cmdNum, &cmd );
;74:
;75:					CG_Printf("%i\n", (int)cmd.weapon);*/
;76:					
;77:					if ( cg.nextSnap ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $123
line 78
;78:						centity_t *c = &cg_entities[trace.entityNum];
ADDRLP4 140
CNSTI4 728
ADDRLP4 60+52
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 86
;79:						vec3_t origin1, origin2;
;80:
;81:						//trap_SetUserCmdValue( c->currentState.clientNum + 1 , cg.zoomSensitivity );
;82:						//CG_Printf("c->currentState.clientNum: %i -- c->currentState.clientNum + 1: %i\n", c->currentState.clientNum, c->currentState.clientNum + 1);
;83:						//CG_CenterPrint( "Hit!", 380, SMALLCHAR_WIDTH );
;84:
;85:						// figure the two origins used for interpolation
;86:						BG_EvaluateTrajectory( &c->currentState.pos, cg.snap->serverTime, origin1 );
ADDRLP4 140
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
ADDRLP4 144
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 87
;87:						BG_EvaluateTrajectory( &c->nextState.pos, cg.nextSnap->serverTime, origin2 );
ADDRLP4 140
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
ADDRLP4 156
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 92
;88:
;89:						// print some debugging stuff exactly like what the server does
;90:
;91:						// it starts with "Int:" to let you know the target was interpolated
;92:						if ( cg_debugDelag.integer ) {
ADDRGP4 cg_debugDelag+12
INDIRI4
CNSTI4 0
EQI4 $124
line 93
;93:						CG_Printf("^3Int: time: %d, j: %d, k: %d, origin: %0.2f %0.2f %0.2f\n",
ADDRGP4 $132
ARGP4
ADDRGP4 cg+107608
INDIRI4
ARGI4
ADDRLP4 168
CNSTI4 8
ASGNI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 168
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+40
INDIRP4
ADDRLP4 168
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRLP4 172
ADDRLP4 140
INDIRP4
ASGNP4
ADDRLP4 172
INDIRP4
CNSTI4 704
ADDP4
INDIRF4
ARGF4
ADDRLP4 172
INDIRP4
CNSTI4 708
ADDP4
INDIRF4
ARGF4
ADDRLP4 172
INDIRP4
CNSTI4 712
ADDP4
INDIRF4
ARGF4
ADDRGP4 CG_Printf
CALLV
pop
line 96
;94:								cg.oldTime, cg.snap->serverTime, cg.nextSnap->serverTime,
;95:								c->lerpOrigin[0], c->lerpOrigin[1], c->lerpOrigin[2]);
;96:						CG_Printf("^5frac: %0.4f, origin1: %0.2f %0.2f %0.2f, origin2: %0.2f %0.2f %0.2f\n",
ADDRGP4 $136
ARGP4
ADDRGP4 cg+107588
INDIRF4
ARGF4
ADDRLP4 144
INDIRF4
ARGF4
ADDRLP4 144+4
INDIRF4
ARGF4
ADDRLP4 144+8
INDIRF4
ARGF4
ADDRLP4 156
INDIRF4
ARGF4
ADDRLP4 156+4
INDIRF4
ARGF4
ADDRLP4 156+8
INDIRF4
ARGF4
ADDRGP4 CG_Printf
CALLV
pop
line 98
;97:							cg.frameInterpolation, origin1[0], origin1[1], origin1[2], origin2[0], origin2[1], origin2[2]);
;98:						}
line 99
;99:					} else {
ADDRGP4 $124
JUMPV
LABELV $123
line 104
;100:						// we haven't got a next snapshot
;101:						// the client clock has either drifted ahead (seems to happen once per server frame
;102:						// when you play locally) or the client is using timenudge
;103:						// in any case, CG_CalcEntityLerpPositions extrapolated rather than interpolated
;104:						centity_t *c = &cg_entities[trace.entityNum];
ADDRLP4 140
CNSTI4 728
ADDRLP4 60+52
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 112
;105:						vec3_t origin1, origin2;
;106:
;107:						//trap_SetUserCmdValue( c->currentState.clientNum + 1 , cg.zoomSensitivity );
;108:						//CG_Printf("c->currentState.clientNum: %i -- c->currentState.clientNum + 1: %i\n", c->currentState.clientNum, c->currentState.clientNum + 1);
;109:						//CG_Printf("c->nextState.clientNum: %i -- c->nextState.clientNum + 1: %i\n", c->nextState.clientNum, c->nextState.clientNum + 1);
;110:						//CG_CenterPrint( "} else { Hit!", 380, SMALLCHAR_WIDTH );
;111:
;112:						c->currentState.pos.trTime = TR_LINEAR_STOP;
ADDRLP4 140
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 3
ASGNI4
line 113
;113:						c->currentState.pos.trTime = cg.snap->serverTime;
ADDRLP4 140
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 114
;114:						c->currentState.pos.trDuration = 1000 / sv_fps.integer;
ADDRLP4 140
INDIRP4
CNSTI4 20
ADDP4
CNSTI4 1000
ADDRGP4 sv_fps+12
INDIRI4
DIVI4
ASGNI4
line 116
;115:
;116:						BG_EvaluateTrajectory( &c->currentState.pos, cg.snap->serverTime, origin1 );
ADDRLP4 140
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
ADDRLP4 144
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 117
;117:						BG_EvaluateTrajectory( &c->currentState.pos, cg.snap->serverTime + 1000 / sv_fps.integer, origin2 );
ADDRLP4 140
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1000
ADDRGP4 sv_fps+12
INDIRI4
DIVI4
ADDI4
ARGI4
ADDRLP4 156
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 122
;118:
;119:						// print some debugging stuff exactly like what the server does
;120:
;121:						// it starts with "Ext:" to let you know the target was extrapolated
;122:						if ( cg_debugDelag.integer ) {
ADDRGP4 cg_debugDelag+12
INDIRI4
CNSTI4 0
EQI4 $148
line 123
;123:						CG_Printf("^3Ext: time: %d, j: %d, k: %d, origin: %0.2f %0.2f %0.2f\n",
ADDRGP4 $151
ARGP4
ADDRGP4 cg+107608
INDIRI4
ARGI4
ADDRLP4 168
CNSTI4 8
ASGNI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 168
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 168
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRLP4 172
ADDRLP4 140
INDIRP4
ASGNP4
ADDRLP4 172
INDIRP4
CNSTI4 704
ADDP4
INDIRF4
ARGF4
ADDRLP4 172
INDIRP4
CNSTI4 708
ADDP4
INDIRF4
ARGF4
ADDRLP4 172
INDIRP4
CNSTI4 712
ADDP4
INDIRF4
ARGF4
ADDRGP4 CG_Printf
CALLV
pop
line 126
;124:								cg.oldTime, cg.snap->serverTime, cg.snap->serverTime,
;125:								c->lerpOrigin[0], c->lerpOrigin[1], c->lerpOrigin[2]);
;126:						CG_Printf("^5frac: %0.4f, origin1: %0.2f %0.2f %0.2f, origin2: %0.2f %0.2f %0.2f\n",
ADDRGP4 $136
ARGP4
ADDRGP4 cg+107588
INDIRF4
ARGF4
ADDRLP4 144
INDIRF4
ARGF4
ADDRLP4 144+4
INDIRF4
ARGF4
ADDRLP4 144+8
INDIRF4
ARGF4
ADDRLP4 156
INDIRF4
ARGF4
ADDRLP4 156+4
INDIRF4
ARGF4
ADDRLP4 156+8
INDIRF4
ARGF4
ADDRGP4 CG_Printf
CALLV
pop
line 128
;127:							cg.frameInterpolation, origin1[0], origin1[1], origin1[2], origin2[0], origin2[1], origin2[2]);
;128:						}
LABELV $148
line 129
;129:					}
LABELV $124
line 130
;130:				}
LABELV $117
line 131
;131:			}
LABELV $114
line 134
;132:
;133:			// find the rail's end point
;134:			CG_Trace( &trace, muzzlePoint, vec3_origin, vec3_origin, endPoint, cg.predictedPlayerState.clientNum, CONTENTS_SOLID );
ADDRLP4 60
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 132
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 132
INDIRP4
ARGP4
ADDRLP4 132
INDIRP4
ARGP4
ADDRLP4 116
ARGP4
ADDRGP4 cg+107636+140
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 137
;135:
;136:			// do the magic-number adjustment
;137:			VectorMA( muzzlePoint, 4, right, muzzlePoint );
ADDRLP4 136
CNSTF4 1082130432
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 136
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 136
INDIRF4
ADDRLP4 28+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1082130432
ADDRLP4 28+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 138
;138:			VectorMA( muzzlePoint, -1, up, muzzlePoint );
ADDRLP4 140
CNSTF4 3212836864
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 140
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 140
INDIRF4
ADDRLP4 40+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 3212836864
ADDRLP4 40+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 141
;139:
;140:			// draw a rail trail
;141:			CG_RailTrail( &cgs.clientinfo[cent->currentState.number], muzzlePoint, trace.endpos );
CNSTI4 1776
ADDRFP4 0
INDIRP4
INDIRI4
MULI4
ADDRGP4 cgs+40960
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 60+12
ARGP4
ADDRGP4 CG_RailTrail
CALLV
pop
line 145
;142:			//Com_Printf( "Predicted rail trail\n" );
;143:
;144:			// explosion at end if not SURF_NOIMPACT
;145:			if ( !(trace.surfaceFlags & SURF_NOIMPACT) ) {
ADDRLP4 60+44
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $102
line 147
;146:				// predict an explosion
;147:				CG_MissileHitWall( ent->weapon, cg.predictedPlayerState.clientNum, trace.endpos, trace.plane.normal, IMPACTSOUND_DEFAULT );
ADDRLP4 24
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+107636+140
INDIRI4
ARGI4
ADDRLP4 60+12
ARGP4
ADDRLP4 60+24
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 148
;148:			}
line 149
;149:		}
line 167
;150:
;151:		//if ( cg_aimType.integer == 4 ) {
;152:
;153:		//		if (cg.clientsHit) {
;154:		//			totalHit = 0;
;155:
;156:		//			for (i=0;i<32;i++) {
;157:		//				hit[i] = cg.clientsHit & (1 << i);
;158:
;159:		//				if (hit[i]) {
;160:		//					cg.rawPacket.clientsHit[totalHit] = i+1;
;161:		//					totalHit++;
;162:		//				}
;163:		//			}
;164:		//		}
;165:		//	}
;166:		//}
;167:	}
ADDRGP4 $102
JUMPV
LABELV $101
line 169
;168:	// was it a shotgun attack?
;169:	else if ( ent->weapon == WP_SHOTGUN ) {
ADDRLP4 24
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 3
NEI4 $183
line 171
;170:		// do we have it on for the shotgun?
;171:		if ( cg_delag.integer & 1 || cg_delag.integer & 4 ) {
ADDRLP4 56
CNSTI4 0
ASGNI4
ADDRGP4 cg_delag+12
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 56
INDIRI4
NEI4 $189
ADDRGP4 cg_delag+12
INDIRI4
CNSTI4 4
BANDI4
ADDRLP4 56
INDIRI4
EQI4 $184
LABELV $189
line 177
;172:			int contents;
;173:			vec3_t endPoint, v;
;174:
;175:			// do everything like the server does
;176:
;177:			SnapVector( muzzlePoint );
ADDRLP4 0
ADDRLP4 0
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 179
;178:
;179:			VectorScale( forward, 4096, endPoint );
ADDRLP4 88
CNSTF4 1166016512
ASGNF4
ADDRLP4 72
ADDRLP4 88
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ASGNF4
ADDRLP4 72+4
ADDRLP4 88
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 72+8
CNSTF4 1166016512
ADDRLP4 12+8
INDIRF4
MULF4
ASGNF4
line 180
;180:			SnapVector( endPoint );
ADDRLP4 72
ADDRLP4 72
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 72+4
ADDRLP4 72+4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 72+8
ADDRLP4 72+8
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 182
;181:
;182:			VectorSubtract( endPoint, muzzlePoint, v );
ADDRLP4 60
ADDRLP4 72
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 60+4
ADDRLP4 72+4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 60+8
ADDRLP4 72+8
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 183
;183:			VectorNormalize( v );
ADDRLP4 60
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 184
;184:			VectorScale( v, 32, v );
ADDRLP4 92
CNSTF4 1107296256
ASGNF4
ADDRLP4 60
ADDRLP4 92
INDIRF4
ADDRLP4 60
INDIRF4
MULF4
ASGNF4
ADDRLP4 60+4
ADDRLP4 92
INDIRF4
ADDRLP4 60+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 60+8
CNSTF4 1107296256
ADDRLP4 60+8
INDIRF4
MULF4
ASGNF4
line 185
;185:			VectorAdd( muzzlePoint, v, v );
ADDRLP4 60
ADDRLP4 0
INDIRF4
ADDRLP4 60
INDIRF4
ADDF4
ASGNF4
ADDRLP4 60+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 60+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 60+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 60+8
INDIRF4
ADDF4
ASGNF4
line 187
;186:
;187:			if ( cgs.glconfig.hardwareType != GLHW_RAGEPRO ) {
ADDRGP4 cgs+20100+11288
INDIRI4
CNSTI4 3
EQI4 $218
line 191
;188:				// ragepro can't alpha fade, so don't even bother with smoke
;189:				vec3_t			up;
;190:
;191:				contents = trap_CM_PointContents( muzzlePoint, 0 );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 108
ADDRGP4 trap_CM_PointContents
CALLI4
ASGNI4
ADDRLP4 84
ADDRLP4 108
INDIRI4
ASGNI4
line 192
;192:				if ( !( contents & CONTENTS_WATER ) ) {
ADDRLP4 84
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
NEI4 $222
line 193
;193:					VectorSet( up, 0, 0, 8 );
ADDRLP4 112
CNSTF4 0
ASGNF4
ADDRLP4 96
ADDRLP4 112
INDIRF4
ASGNF4
ADDRLP4 96+4
ADDRLP4 112
INDIRF4
ASGNF4
ADDRLP4 96+8
CNSTF4 1090519040
ASGNF4
line 194
;194:					CG_SmokePuff( v, up, 32, 1, 1, 1, 0.33f, 900, cg.time, 0, LEF_PUFF_DONT_SCALE, cgs.media.shotgunSmokePuffShader );
ADDRLP4 60
ARGP4
ADDRLP4 96
ARGP4
CNSTF4 1107296256
ARGF4
ADDRLP4 116
CNSTF4 1065353216
ASGNF4
ADDRLP4 116
INDIRF4
ARGF4
ADDRLP4 116
INDIRF4
ARGF4
ADDRLP4 116
INDIRF4
ARGF4
CNSTF4 1051260355
ARGF4
CNSTF4 1147207680
ARGF4
ADDRGP4 cg+107604
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 cgs+156680+340
INDIRI4
ARGI4
ADDRGP4 CG_SmokePuff
CALLP4
pop
line 195
;195:				}
LABELV $222
line 196
;196:			}
LABELV $218
line 199
;197:
;198:			// do the shotgun pellets
;199:			CG_ShotgunPattern( muzzlePoint, endPoint, cg.oldTime % 256, cg.predictedPlayerState.clientNum );
ADDRLP4 0
ARGP4
ADDRLP4 72
ARGP4
ADDRGP4 cg+107608
INDIRI4
CNSTI4 256
MODI4
ARGI4
ADDRGP4 cg+107636+140
INDIRI4
ARGI4
ADDRGP4 CG_ShotgunPattern
CALLV
pop
line 201
;200:			//Com_Printf( "Predicted shotgun pattern\n" );
;201:		}
line 202
;202:	}
ADDRGP4 $184
JUMPV
LABELV $183
line 204
;203:	// was it a machinegun attack?
;204:	else if ( ent->weapon == WP_MACHINEGUN ) {
ADDRLP4 24
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 2
NEI4 $232
line 206
;205:		// do we have it on for the machinegun?
;206:		if ( cg_delag.integer & 1 || cg_delag.integer & 2 ) {
ADDRLP4 56
CNSTI4 0
ASGNI4
ADDRGP4 cg_delag+12
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 56
INDIRI4
NEI4 $238
ADDRGP4 cg_delag+12
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 56
INDIRI4
EQI4 $234
LABELV $238
line 208
;207:			// the server will use this exact time (it'll be serverTime on that end)
;208:			int seed = cg.oldTime % 256;
ADDRLP4 60
ADDRGP4 cg+107608
INDIRI4
CNSTI4 256
MODI4
ASGNI4
line 217
;209:			float r, u;
;210:			trace_t tr;
;211:			qboolean flesh;
;212:			int fleshEntityNum;
;213:			vec3_t endPoint;
;214:
;215:			// do everything exactly like the server does
;216:
;217:			r = Q_random(&seed) * M_PI * 2.0f;
ADDRLP4 60
ARGP4
ADDRLP4 148
ADDRGP4 Q_random
CALLF4
ASGNF4
ADDRLP4 76
CNSTF4 1073741824
CNSTF4 1078530011
ADDRLP4 148
INDIRF4
MULF4
MULF4
ASGNF4
line 218
;218:			u = sin(r) * Q_crandom(&seed) * MACHINEGUN_SPREAD * 16;
ADDRLP4 76
INDIRF4
ARGF4
ADDRLP4 152
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 60
ARGP4
ADDRLP4 156
ADDRGP4 Q_crandom
CALLF4
ASGNF4
ADDRLP4 136
CNSTF4 1098907648
CNSTF4 1128792064
ADDRLP4 152
INDIRF4
ADDRLP4 156
INDIRF4
MULF4
MULF4
MULF4
ASGNF4
line 219
;219:			r = cos(r) * Q_crandom(&seed) * MACHINEGUN_SPREAD * 16;
ADDRLP4 76
INDIRF4
ARGF4
ADDRLP4 160
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 60
ARGP4
ADDRLP4 164
ADDRGP4 Q_crandom
CALLF4
ASGNF4
ADDRLP4 76
CNSTF4 1098907648
CNSTF4 1128792064
ADDRLP4 160
INDIRF4
ADDRLP4 164
INDIRF4
MULF4
MULF4
MULF4
ASGNF4
line 221
;220:
;221:			VectorMA( muzzlePoint, 8192*16, forward, endPoint );
ADDRLP4 168
CNSTF4 1207959552
ASGNF4
ADDRLP4 64
ADDRLP4 0
INDIRF4
ADDRLP4 168
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 64+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 168
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 64+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1207959552
ADDRLP4 12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 222
;222:			VectorMA( endPoint, r, right, endPoint );
ADDRLP4 172
ADDRLP4 76
INDIRF4
ASGNF4
ADDRLP4 64
ADDRLP4 64
INDIRF4
ADDRLP4 28
INDIRF4
ADDRLP4 172
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 64+4
ADDRLP4 64+4
INDIRF4
ADDRLP4 28+4
INDIRF4
ADDRLP4 172
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 64+8
ADDRLP4 64+8
INDIRF4
ADDRLP4 28+8
INDIRF4
ADDRLP4 76
INDIRF4
MULF4
ADDF4
ASGNF4
line 223
;223:			VectorMA( endPoint, u, up, endPoint );
ADDRLP4 176
ADDRLP4 136
INDIRF4
ASGNF4
ADDRLP4 64
ADDRLP4 64
INDIRF4
ADDRLP4 40
INDIRF4
ADDRLP4 176
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 64+4
ADDRLP4 64+4
INDIRF4
ADDRLP4 40+4
INDIRF4
ADDRLP4 176
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 64+8
ADDRLP4 64+8
INDIRF4
ADDRLP4 40+8
INDIRF4
ADDRLP4 136
INDIRF4
MULF4
ADDF4
ASGNF4
line 225
;224:
;225:			CG_Trace(&tr, muzzlePoint, NULL, NULL, endPoint, cg.predictedPlayerState.clientNum, MASK_SHOT );
ADDRLP4 80
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 180
CNSTP4 0
ASGNP4
ADDRLP4 180
INDIRP4
ARGP4
ADDRLP4 180
INDIRP4
ARGP4
ADDRLP4 64
ARGP4
ADDRGP4 cg+107636+140
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 227
;226:
;227:			if ( tr.surfaceFlags & SURF_NOIMPACT ) {
ADDRLP4 80+44
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $260
line 228
;228:				return;
ADDRGP4 $77
JUMPV
LABELV $260
line 232
;229:			}
;230:
;231:			// snap the endpos to integers, but nudged towards the line
;232:			SnapVectorTowards( tr.endpos, muzzlePoint );
ADDRLP4 80+12
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 SnapVectorTowards
CALLV
pop
line 235
;233:
;234:			// do bullet impact
;235:			if ( tr.entityNum < MAX_CLIENTS ) {
ADDRLP4 80+52
INDIRI4
CNSTI4 64
GEI4 $264
line 236
;236:				flesh = qtrue;
ADDRLP4 140
CNSTI4 1
ASGNI4
line 237
;237:				fleshEntityNum = tr.entityNum;
ADDRLP4 144
ADDRLP4 80+52
INDIRI4
ASGNI4
line 238
;238:			} else {
ADDRGP4 $265
JUMPV
LABELV $264
line 239
;239:				flesh = qfalse;
ADDRLP4 140
CNSTI4 0
ASGNI4
line 240
;240:			}
LABELV $265
line 243
;241:
;242:			// do the bullet impact
;243:			CG_Bullet( tr.endpos, cg.predictedPlayerState.clientNum, tr.plane.normal, flesh, fleshEntityNum );
ADDRLP4 80+12
ARGP4
ADDRGP4 cg+107636+140
INDIRI4
ARGI4
ADDRLP4 80+24
ARGP4
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 144
INDIRI4
ARGI4
ADDRGP4 CG_Bullet
CALLV
pop
line 245
;244:			//Com_Printf( "Predicted bullet\n" );
;245:		}
LABELV $234
line 246
;246:	}
LABELV $232
LABELV $184
LABELV $102
line 247
;247:}
LABELV $77
endproc CG_PredictWeaponEffects 184 48
lit
align 4
LABELV $273
byte 4 3245342720
byte 4 3245342720
byte 4 3250585600
align 4
LABELV $274
byte 4 1097859072
byte 4 1097859072
byte 4 1107296256
export CG_AddBoundingBox
code
proc CG_AddBoundingBox 276 12
line 256
;248:
;249:/*
;250:=================
;251:CG_AddBoundingBox
;252:
;253:Draws a bounding box around a player.  Called from CG_Player.
;254:=================
;255:*/
;256:void CG_AddBoundingBox( centity_t *cent ) {
line 260
;257:	polyVert_t verts[4];
;258:	clientInfo_t *ci;
;259:	int i;
;260:	vec3_t mins = {-15, -15, -24};
ADDRLP4 216
ADDRGP4 $273
INDIRB
ASGNB 12
line 261
;261:	vec3_t maxs = {15, 15, 32};
ADDRLP4 200
ADDRGP4 $274
INDIRB
ASGNB 12
line 266
;262:	float extx, exty, extz;
;263:	vec3_t corners[8];
;264:	qhandle_t bboxShader, bboxShader_nocull;
;265:
;266:	if ( !cg_drawBBox.integer ) {
ADDRGP4 cg_drawBBox+12
INDIRI4
CNSTI4 0
NEI4 $275
line 267
;267:		return;
ADDRGP4 $272
JUMPV
LABELV $275
line 271
;268:	}
;269:
;270:	// don't draw it if it's us in first-person
;271:	if ( cent->currentState.number == cg.predictedPlayerState.clientNum &&
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $278
ADDRGP4 cg+107628
INDIRI4
CNSTI4 0
NEI4 $278
line 272
;272:			!cg.renderingThirdPerson ) {
line 273
;273:		return;
ADDRGP4 $272
JUMPV
LABELV $278
line 277
;274:	}
;275:
;276:	// don't draw it for dead players
;277:	if ( cent->currentState.eFlags & EF_DEAD ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $283
line 278
;278:		return;
ADDRGP4 $272
JUMPV
LABELV $283
line 282
;279:	}
;280:
;281:	// get the shader handles
;282:	bboxShader = trap_R_RegisterShader( "bbox" );
ADDRGP4 $285
ARGP4
ADDRLP4 244
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 228
ADDRLP4 244
INDIRI4
ASGNI4
line 283
;283:	bboxShader_nocull = trap_R_RegisterShader( "bbox_nocull" );
ADDRGP4 $286
ARGP4
ADDRLP4 248
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 212
ADDRLP4 248
INDIRI4
ASGNI4
line 286
;284:
;285:	// if they don't exist, forget it
;286:	if ( !bboxShader || !bboxShader_nocull ) {
ADDRLP4 252
CNSTI4 0
ASGNI4
ADDRLP4 228
INDIRI4
ADDRLP4 252
INDIRI4
EQI4 $289
ADDRLP4 212
INDIRI4
ADDRLP4 252
INDIRI4
NEI4 $287
LABELV $289
line 287
;287:		return;
ADDRGP4 $272
JUMPV
LABELV $287
line 291
;288:	}
;289:
;290:	// get the player's client info
;291:	ci = &cgs.clientinfo[cent->currentState.clientNum];
ADDRLP4 236
CNSTI4 1776
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+40960
ADDP4
ASGNP4
line 294
;292:
;293:	// if it's us
;294:	if ( cent->currentState.number == cg.predictedPlayerState.clientNum ) {
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $291
line 296
;295:		// use the view height
;296:		maxs[2] = cg.predictedPlayerState.viewheight + 6;
ADDRLP4 200+8
ADDRGP4 cg+107636+164
INDIRI4
CNSTI4 6
ADDI4
CVIF4 4
ASGNF4
line 297
;297:	} else {
ADDRGP4 $292
JUMPV
LABELV $291
line 301
;298:		int x, zd, zu;
;299:
;300:		// otherwise grab the encoded bounding box
;301:		x = (cent->currentState.solid & 255);
ADDRLP4 256
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 255
BANDI4
ASGNI4
line 302
;302:		zd = ((cent->currentState.solid>>8) & 255);
ADDRLP4 260
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 8
RSHI4
CNSTI4 255
BANDI4
ASGNI4
line 303
;303:		zu = ((cent->currentState.solid>>16) & 255) - 32;
ADDRLP4 264
ADDRFP4 0
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
line 305
;304:
;305:		mins[0] = mins[1] = -x;
ADDRLP4 268
ADDRLP4 256
INDIRI4
NEGI4
CVIF4 4
ASGNF4
ADDRLP4 216+4
ADDRLP4 268
INDIRF4
ASGNF4
ADDRLP4 216
ADDRLP4 268
INDIRF4
ASGNF4
line 306
;306:		maxs[0] = maxs[1] = x;
ADDRLP4 272
ADDRLP4 256
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 200+4
ADDRLP4 272
INDIRF4
ASGNF4
ADDRLP4 200
ADDRLP4 272
INDIRF4
ASGNF4
line 307
;307:		mins[2] = -zd;
ADDRLP4 216+8
ADDRLP4 260
INDIRI4
NEGI4
CVIF4 4
ASGNF4
line 308
;308:		maxs[2] = zu;
ADDRLP4 200+8
ADDRLP4 264
INDIRI4
CVIF4 4
ASGNF4
line 309
;309:	}
LABELV $292
line 312
;310:
;311:	// get the extents (size)
;312:	extx = maxs[0] - mins[0];
ADDRLP4 232
ADDRLP4 200
INDIRF4
ADDRLP4 216
INDIRF4
SUBF4
ASGNF4
line 313
;313:	exty = maxs[1] - mins[1];
ADDRLP4 240
ADDRLP4 200+4
INDIRF4
ADDRLP4 216+4
INDIRF4
SUBF4
ASGNF4
line 314
;314:	extz = maxs[2] - mins[2];
ADDRLP4 196
ADDRLP4 200+8
INDIRF4
ADDRLP4 216+8
INDIRF4
SUBF4
ASGNF4
line 318
;315:
;316:	
;317:	// set the polygon's texture coordinates
;318:	verts[0].st[0] = 0;
ADDRLP4 4+12
CNSTF4 0
ASGNF4
line 319
;319:	verts[0].st[1] = 0;
ADDRLP4 4+12+4
CNSTF4 0
ASGNF4
line 320
;320:	verts[1].st[0] = 0;
ADDRLP4 4+24+12
CNSTF4 0
ASGNF4
line 321
;321:	verts[1].st[1] = 1;
ADDRLP4 4+24+12+4
CNSTF4 1065353216
ASGNF4
line 322
;322:	verts[2].st[0] = 1;
ADDRLP4 4+48+12
CNSTF4 1065353216
ASGNF4
line 323
;323:	verts[2].st[1] = 1;
ADDRLP4 4+48+12+4
CNSTF4 1065353216
ASGNF4
line 324
;324:	verts[3].st[0] = 1;
ADDRLP4 4+72+12
CNSTF4 1065353216
ASGNF4
line 325
;325:	verts[3].st[1] = 0;
ADDRLP4 4+72+12+4
CNSTF4 0
ASGNF4
line 328
;326:
;327:	// set the polygon's vertex colors
;328:	if ( ci->team == TEAM_RED ) {
ADDRLP4 236
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $324
line 329
;329:		for ( i = 0; i < 4; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $326
line 330
;330:			verts[i].modulate[0] = 160;
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 4+20
ADDP4
CNSTU1 160
ASGNU1
line 331
;331:			verts[i].modulate[1] = 0;
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 4+20+1
ADDP4
CNSTU1 0
ASGNU1
line 332
;332:			verts[i].modulate[2] = 0;
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 4+20+2
ADDP4
CNSTU1 0
ASGNU1
line 333
;333:			verts[i].modulate[3] = 255;
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 4+20+3
ADDP4
CNSTU1 255
ASGNU1
line 334
;334:		}
LABELV $327
line 329
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $326
line 335
;335:	} else if ( ci->team == TEAM_BLUE ) {
ADDRGP4 $325
JUMPV
LABELV $324
ADDRLP4 236
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $337
line 336
;336:		for ( i = 0; i < 4; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $339
line 337
;337:			verts[i].modulate[0] = 0;
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 4+20
ADDP4
CNSTU1 0
ASGNU1
line 338
;338:			verts[i].modulate[1] = 0;
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 4+20+1
ADDP4
CNSTU1 0
ASGNU1
line 339
;339:			verts[i].modulate[2] = 192;
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 4+20+2
ADDP4
CNSTU1 192
ASGNU1
line 340
;340:			verts[i].modulate[3] = 255;
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 4+20+3
ADDP4
CNSTU1 255
ASGNU1
line 341
;341:		}
LABELV $340
line 336
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $339
line 342
;342:	} else {
ADDRGP4 $338
JUMPV
LABELV $337
line 343
;343:		for ( i = 0; i < 4; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $350
line 344
;344:			verts[i].modulate[0] = 0;
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 4+20
ADDP4
CNSTU1 0
ASGNU1
line 345
;345:			verts[i].modulate[1] = 128;
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 4+20+1
ADDP4
CNSTU1 128
ASGNU1
line 346
;346:			verts[i].modulate[2] = 0;
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 4+20+2
ADDP4
CNSTU1 0
ASGNU1
line 347
;347:			verts[i].modulate[3] = 255;
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 4+20+3
ADDP4
CNSTU1 255
ASGNU1
line 348
;348:		}
LABELV $351
line 343
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $350
line 349
;349:	}
LABELV $338
LABELV $325
line 351
;350:
;351:	VectorAdd( cent->lerpOrigin, maxs, corners[3] );
ADDRLP4 100+36
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRF4
ADDRLP4 200
INDIRF4
ADDF4
ASGNF4
ADDRLP4 100+36+4
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
INDIRF4
ADDRLP4 200+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 100+36+8
ADDRFP4 0
INDIRP4
CNSTI4 712
ADDP4
INDIRF4
ADDRLP4 200+8
INDIRF4
ADDF4
ASGNF4
line 353
;352:
;353:	VectorCopy( corners[3], corners[2] );
ADDRLP4 100+24
ADDRLP4 100+36
INDIRB
ASGNB 12
line 354
;354:	corners[2][0] -= extx;
ADDRLP4 100+24
ADDRLP4 100+24
INDIRF4
ADDRLP4 232
INDIRF4
SUBF4
ASGNF4
line 356
;355:
;356:	VectorCopy( corners[2], corners[1] );
ADDRLP4 100+12
ADDRLP4 100+24
INDIRB
ASGNB 12
line 357
;357:	corners[1][1] -= exty;
ADDRLP4 100+12+4
ADDRLP4 100+12+4
INDIRF4
ADDRLP4 240
INDIRF4
SUBF4
ASGNF4
line 359
;358:
;359:	VectorCopy( corners[1], corners[0] );
ADDRLP4 100
ADDRLP4 100+12
INDIRB
ASGNB 12
line 360
;360:	corners[0][0] += extx;
ADDRLP4 100
ADDRLP4 100
INDIRF4
ADDRLP4 232
INDIRF4
ADDF4
ASGNF4
line 362
;361:
;362:	for ( i = 0; i < 4; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $376
line 363
;363:		VectorCopy( corners[i], corners[i + 4] );
ADDRLP4 256
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 256
INDIRI4
ADDRLP4 100+48
ADDP4
ADDRLP4 256
INDIRI4
ADDRLP4 100
ADDP4
INDIRB
ASGNB 12
line 364
;364:		corners[i + 4][2] -= extz;
ADDRLP4 260
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRLP4 100+48+8
ADDP4
ASGNP4
ADDRLP4 260
INDIRP4
ADDRLP4 260
INDIRP4
INDIRF4
ADDRLP4 196
INDIRF4
SUBF4
ASGNF4
line 365
;365:	}
LABELV $377
line 362
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $376
line 368
;366:
;367:	// top
;368:	VectorCopy( corners[0], verts[0].xyz );
ADDRLP4 4
ADDRLP4 100
INDIRB
ASGNB 12
line 369
;369:	VectorCopy( corners[1], verts[1].xyz );
ADDRLP4 4+24
ADDRLP4 100+12
INDIRB
ASGNB 12
line 370
;370:	VectorCopy( corners[2], verts[2].xyz );
ADDRLP4 4+48
ADDRLP4 100+24
INDIRB
ASGNB 12
line 371
;371:	VectorCopy( corners[3], verts[3].xyz );
ADDRLP4 4+72
ADDRLP4 100+36
INDIRB
ASGNB 12
line 372
;372:	trap_R_AddPolyToScene( bboxShader, 4, verts );
ADDRLP4 228
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_R_AddPolyToScene
CALLV
pop
line 375
;373:
;374:	// bottom
;375:	VectorCopy( corners[7], verts[0].xyz );
ADDRLP4 4
ADDRLP4 100+84
INDIRB
ASGNB 12
line 376
;376:	VectorCopy( corners[6], verts[1].xyz );
ADDRLP4 4+24
ADDRLP4 100+72
INDIRB
ASGNB 12
line 377
;377:	VectorCopy( corners[5], verts[2].xyz );
ADDRLP4 4+48
ADDRLP4 100+60
INDIRB
ASGNB 12
line 378
;378:	VectorCopy( corners[4], verts[3].xyz );
ADDRLP4 4+72
ADDRLP4 100+48
INDIRB
ASGNB 12
line 379
;379:	trap_R_AddPolyToScene( bboxShader, 4, verts );
ADDRLP4 228
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_R_AddPolyToScene
CALLV
pop
line 382
;380:
;381:	// top side
;382:	VectorCopy( corners[3], verts[0].xyz );
ADDRLP4 4
ADDRLP4 100+36
INDIRB
ASGNB 12
line 383
;383:	VectorCopy( corners[2], verts[1].xyz );
ADDRLP4 4+24
ADDRLP4 100+24
INDIRB
ASGNB 12
line 384
;384:	VectorCopy( corners[6], verts[2].xyz );
ADDRLP4 4+48
ADDRLP4 100+72
INDIRB
ASGNB 12
line 385
;385:	VectorCopy( corners[7], verts[3].xyz );
ADDRLP4 4+72
ADDRLP4 100+84
INDIRB
ASGNB 12
line 386
;386:	trap_R_AddPolyToScene( bboxShader_nocull, 4, verts );
ADDRLP4 212
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_R_AddPolyToScene
CALLV
pop
line 389
;387:
;388:	// left side
;389:	VectorCopy( corners[2], verts[0].xyz );
ADDRLP4 4
ADDRLP4 100+24
INDIRB
ASGNB 12
line 390
;390:	VectorCopy( corners[1], verts[1].xyz );
ADDRLP4 4+24
ADDRLP4 100+12
INDIRB
ASGNB 12
line 391
;391:	VectorCopy( corners[5], verts[2].xyz );
ADDRLP4 4+48
ADDRLP4 100+60
INDIRB
ASGNB 12
line 392
;392:	VectorCopy( corners[6], verts[3].xyz );
ADDRLP4 4+72
ADDRLP4 100+72
INDIRB
ASGNB 12
line 393
;393:	trap_R_AddPolyToScene( bboxShader_nocull, 4, verts );
ADDRLP4 212
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_R_AddPolyToScene
CALLV
pop
line 396
;394:
;395:	// right side
;396:	VectorCopy( corners[0], verts[0].xyz );
ADDRLP4 4
ADDRLP4 100
INDIRB
ASGNB 12
line 397
;397:	VectorCopy( corners[3], verts[1].xyz );
ADDRLP4 4+24
ADDRLP4 100+36
INDIRB
ASGNB 12
line 398
;398:	VectorCopy( corners[7], verts[2].xyz );
ADDRLP4 4+48
ADDRLP4 100+84
INDIRB
ASGNB 12
line 399
;399:	VectorCopy( corners[4], verts[3].xyz );
ADDRLP4 4+72
ADDRLP4 100+48
INDIRB
ASGNB 12
line 400
;400:	trap_R_AddPolyToScene( bboxShader_nocull, 4, verts );
ADDRLP4 212
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_R_AddPolyToScene
CALLV
pop
line 403
;401:
;402:	// bottom side
;403:	VectorCopy( corners[1], verts[0].xyz );
ADDRLP4 4
ADDRLP4 100+12
INDIRB
ASGNB 12
line 404
;404:	VectorCopy( corners[0], verts[1].xyz );
ADDRLP4 4+24
ADDRLP4 100
INDIRB
ASGNB 12
line 405
;405:	VectorCopy( corners[4], verts[2].xyz );
ADDRLP4 4+48
ADDRLP4 100+48
INDIRB
ASGNB 12
line 406
;406:	VectorCopy( corners[5], verts[3].xyz );
ADDRLP4 4+72
ADDRLP4 100+60
INDIRB
ASGNB 12
line 407
;407:	trap_R_AddPolyToScene( bboxShader_nocull, 4, verts );
ADDRLP4 212
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_R_AddPolyToScene
CALLV
pop
line 408
;408:}
LABELV $272
endproc CG_AddBoundingBox 276 12
export CG_Cvar_ClampInt
proc CG_Cvar_ClampInt 0 16
line 417
;409:
;410:/*
;411:================
;412:CG_Cvar_ClampInt
;413:
;414:Clamps a cvar between two integer values, returns qtrue if it had to.
;415:================
;416:*/
;417:qboolean CG_Cvar_ClampInt( const char *name, vmCvar_t *vmCvar, int min, int max ) {
line 418
;418:	if ( vmCvar->integer > max ) {
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRFP4 12
INDIRI4
LEI4 $423
line 419
;419:		CG_Printf( "Allowed values are %d to %d.\n", min, max );
ADDRGP4 $425
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 421
;420:
;421:		Com_sprintf( vmCvar->string, MAX_CVAR_VALUE_STRING, "%d", max );
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $426
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 422
;422:		vmCvar->value = max;
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 12
INDIRI4
CVIF4 4
ASGNF4
line 423
;423:		vmCvar->integer = max;
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 12
INDIRI4
ASGNI4
line 425
;424:
;425:		trap_Cvar_Set( name, vmCvar->string );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 426
;426:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $422
JUMPV
LABELV $423
line 429
;427:	}
;428:
;429:	if ( vmCvar->integer < min ) {
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRFP4 8
INDIRI4
GEI4 $427
line 430
;430:		CG_Printf( "Allowed values are %d to %d.\n", min, max );
ADDRGP4 $425
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 432
;431:
;432:		Com_sprintf( vmCvar->string, MAX_CVAR_VALUE_STRING, "%d", min );
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $426
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 433
;433:		vmCvar->value = min;
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 8
INDIRI4
CVIF4 4
ASGNF4
line 434
;434:		vmCvar->integer = min;
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 436
;435:
;436:		trap_Cvar_Set( name, vmCvar->string );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 437
;437:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $422
JUMPV
LABELV $427
line 440
;438:	}
;439:
;440:	return qfalse;
CNSTI4 0
RETI4
LABELV $422
endproc CG_Cvar_ClampInt 0 16
import CG_ShotgunPattern
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
LABELV $426
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $425
byte 1 65
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $286
byte 1 98
byte 1 98
byte 1 111
byte 1 120
byte 1 95
byte 1 110
byte 1 111
byte 1 99
byte 1 117
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $285
byte 1 98
byte 1 98
byte 1 111
byte 1 120
byte 1 0
align 1
LABELV $151
byte 1 94
byte 1 51
byte 1 69
byte 1 120
byte 1 116
byte 1 58
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 100
byte 1 44
byte 1 32
byte 1 106
byte 1 58
byte 1 32
byte 1 37
byte 1 100
byte 1 44
byte 1 32
byte 1 107
byte 1 58
byte 1 32
byte 1 37
byte 1 100
byte 1 44
byte 1 32
byte 1 111
byte 1 114
byte 1 105
byte 1 103
byte 1 105
byte 1 110
byte 1 58
byte 1 32
byte 1 37
byte 1 48
byte 1 46
byte 1 50
byte 1 102
byte 1 32
byte 1 37
byte 1 48
byte 1 46
byte 1 50
byte 1 102
byte 1 32
byte 1 37
byte 1 48
byte 1 46
byte 1 50
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $136
byte 1 94
byte 1 53
byte 1 102
byte 1 114
byte 1 97
byte 1 99
byte 1 58
byte 1 32
byte 1 37
byte 1 48
byte 1 46
byte 1 52
byte 1 102
byte 1 44
byte 1 32
byte 1 111
byte 1 114
byte 1 105
byte 1 103
byte 1 105
byte 1 110
byte 1 49
byte 1 58
byte 1 32
byte 1 37
byte 1 48
byte 1 46
byte 1 50
byte 1 102
byte 1 32
byte 1 37
byte 1 48
byte 1 46
byte 1 50
byte 1 102
byte 1 32
byte 1 37
byte 1 48
byte 1 46
byte 1 50
byte 1 102
byte 1 44
byte 1 32
byte 1 111
byte 1 114
byte 1 105
byte 1 103
byte 1 105
byte 1 110
byte 1 50
byte 1 58
byte 1 32
byte 1 37
byte 1 48
byte 1 46
byte 1 50
byte 1 102
byte 1 32
byte 1 37
byte 1 48
byte 1 46
byte 1 50
byte 1 102
byte 1 32
byte 1 37
byte 1 48
byte 1 46
byte 1 50
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $132
byte 1 94
byte 1 51
byte 1 73
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 100
byte 1 44
byte 1 32
byte 1 106
byte 1 58
byte 1 32
byte 1 37
byte 1 100
byte 1 44
byte 1 32
byte 1 107
byte 1 58
byte 1 32
byte 1 37
byte 1 100
byte 1 44
byte 1 32
byte 1 111
byte 1 114
byte 1 105
byte 1 103
byte 1 105
byte 1 110
byte 1 58
byte 1 32
byte 1 37
byte 1 48
byte 1 46
byte 1 50
byte 1 102
byte 1 32
byte 1 37
byte 1 48
byte 1 46
byte 1 50
byte 1 102
byte 1 32
byte 1 37
byte 1 48
byte 1 46
byte 1 50
byte 1 102
byte 1 10
byte 1 0
