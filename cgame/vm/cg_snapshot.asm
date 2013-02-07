code
proc CG_ResetEntity 8 4
file "../cg_snapshot.c"
line 15
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_snapshot.c -- things that happen on snapshot transition,
;4:// not necessarily every single rendered frame
;5:
;6:#include "cg_local.h"
;7:
;8:
;9:
;10:/*
;11:==================
;12:CG_ResetEntity
;13:==================
;14:*/
;15:static void CG_ResetEntity( centity_t *cent ) {
line 18
;16:	// if the previous snapshot this entity was updated in is at least
;17:	// an event window back in time then we can reset the previous event
;18:	if ( cent->snapShotTime < cg.time - EVENT_VALID_MSEC ) {
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 300
SUBI4
GEI4 $78
line 19
;19:		cent->previousEvent = 0;
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
CNSTI4 0
ASGNI4
line 20
;20:	}
LABELV $78
line 22
;21:
;22:	cent->trailTime = cg.snap->serverTime;
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 24
;23:
;24:	VectorCopy (cent->currentState.origin, cent->lerpOrigin);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 25
;25:	VectorCopy (cent->currentState.angles, cent->lerpAngles);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 716
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 26
;26:	if ( cent->currentState.eType == ET_PLAYER ) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 1
NEI4 $82
line 27
;27:		CG_ResetPlayerEntity( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_ResetPlayerEntity
CALLV
pop
line 28
;28:	}
LABELV $82
line 29
;29:}
LABELV $77
endproc CG_ResetEntity 8 4
export CG_TransitionEntity
proc CG_TransitionEntity 4 4
line 40
;30:
;31:/*
;32:===============
;33:CG_TransitionEntity
;34:
;35:cent->nextState is moved to cent->currentState and events are fired
;36:===============
;37:*/
;38://unlagged - early transitioning
;39:// used to be static, now needed to transition entities from within cg_ents.c
;40:void CG_TransitionEntity( centity_t *cent ) {
line 41
;41:	cent->currentState = cent->nextState;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRB
ASGNB 208
line 42
;42:	cent->currentValid = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 420
ADDP4
CNSTI4 1
ASGNI4
line 45
;43:
;44:	// reset if the entity wasn't in the last frame or was teleported
;45:	if ( !cent->interpolate ) {
ADDRFP4 0
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
NEI4 $85
line 46
;46:		CG_ResetEntity( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_ResetEntity
CALLV
pop
line 47
;47:	}
LABELV $85
line 50
;48:
;49:	// clear the next state.  if will be set by the next CG_SetNextSnap
;50:	cent->interpolate = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 416
ADDP4
CNSTI4 0
ASGNI4
line 53
;51:
;52:	// check for events
;53:	CG_CheckEvents( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_CheckEvents
CALLV
pop
line 54
;54:}
LABELV $84
endproc CG_TransitionEntity 4 4
export CG_SetInitialSnapshot
proc CG_SetInitialSnapshot 16 12
line 68
;55:
;56:
;57:/*
;58:==================
;59:CG_SetInitialSnapshot
;60:
;61:This will only happen on the very first snapshot, or
;62:on tourney restarts.  All other times will use 
;63:CG_TransitionSnapshot instead.
;64:
;65:FIXME: Also called by map_restart?
;66:==================
;67:*/
;68:void CG_SetInitialSnapshot( snapshot_t *snap ) {
line 73
;69:	int				i;
;70:	centity_t		*cent;
;71:	entityState_t	*state;
;72:
;73:	cg.snap = snap;
ADDRGP4 cg+36
ADDRFP4 0
INDIRP4
ASGNP4
line 75
;74:
;75:	BG_PlayerStateToEntityState( &snap->ps, &cg_entities[ snap->ps.clientNum ].currentState, qfalse );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 44
ADDP4
ARGP4
CNSTI4 728
ADDRLP4 12
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 78
;76:
;77:	// sort out solid entities
;78:	CG_BuildSolidList();
ADDRGP4 CG_BuildSolidList
CALLV
pop
line 80
;79:
;80:	CG_ExecuteNewServerCommands( snap->serverCommandSequence );
ADDRFP4 0
INDIRP4
CNSTI4 53768
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_ExecuteNewServerCommands
CALLV
pop
line 84
;81:
;82:	// set our local weapon selection pointer to
;83:	// what the server has indicated the current weapon is
;84:	CG_Respawn();
ADDRGP4 CG_Respawn
CALLV
pop
line 86
;85:
;86:	for ( i = 0 ; i < cg.snap->numEntities ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $92
JUMPV
LABELV $89
line 87
;87:		state = &cg.snap->entities[ i ];
ADDRLP4 8
CNSTI4 208
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 516
ADDP4
ADDP4
ASGNP4
line 88
;88:		cent = &cg_entities[ state->number ];
ADDRLP4 0
CNSTI4 728
ADDRLP4 8
INDIRP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 90
;89:
;90:		memcpy(&cent->currentState, state, sizeof(entityState_t));
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 208
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 92
;91:		//cent->currentState = *state;
;92:		cent->interpolate = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 416
ADDP4
CNSTI4 0
ASGNI4
line 93
;93:		cent->currentValid = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 420
ADDP4
CNSTI4 1
ASGNI4
line 95
;94:
;95:		CG_ResetEntity( cent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_ResetEntity
CALLV
pop
line 98
;96:
;97:		// check for events
;98:		CG_CheckEvents( cent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_CheckEvents
CALLV
pop
line 99
;99:	}
LABELV $90
line 86
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $92
ADDRLP4 4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
LTI4 $89
line 100
;100:}
LABELV $87
endproc CG_SetInitialSnapshot 16 12
proc CG_TransitionSnapshot 28 12
line 110
;101:
;102:
;103:/*
;104:===================
;105:CG_TransitionSnapshot
;106:
;107:The transition point from snap to nextSnap has passed
;108:===================
;109:*/
;110:static void CG_TransitionSnapshot( void ) {
line 115
;111:	centity_t			*cent;
;112:	snapshot_t			*oldFrame;
;113:	int					i;
;114:
;115:	if ( !cg.snap ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $96
line 116
;116:		CG_Error( "CG_TransitionSnapshot: NULL cg.snap" );
ADDRGP4 $99
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 117
;117:	}
LABELV $96
line 118
;118:	if ( !cg.nextSnap ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $100
line 119
;119:		CG_Error( "CG_TransitionSnapshot: NULL cg.nextSnap" );
ADDRGP4 $103
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 120
;120:	}
LABELV $100
line 123
;121:
;122:	// execute any server string commands before transitioning entities
;123:	CG_ExecuteNewServerCommands( cg.nextSnap->serverCommandSequence );
ADDRGP4 cg+40
INDIRP4
CNSTI4 53768
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_ExecuteNewServerCommands
CALLV
pop
line 126
;124:
;125:	// if we had a map_restart, set everthing with initial
;126:	if ( !cg.snap ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $105
line 127
;127:	}
LABELV $105
line 130
;128:
;129:	// clear the currentValid flag for all entities in the existing snapshot
;130:	for ( i = 0 ; i < cg.snap->numEntities ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $111
JUMPV
LABELV $108
line 131
;131:		cent = &cg_entities[ cg.snap->entities[ i ].number ];
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
line 132
;132:		cent->currentValid = qfalse;
ADDRLP4 4
INDIRP4
CNSTI4 420
ADDP4
CNSTI4 0
ASGNI4
line 133
;133:	}
LABELV $109
line 130
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $111
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
LTI4 $108
line 136
;134:
;135:	// move nextSnap to snap and do the transitions
;136:	oldFrame = cg.snap;
ADDRLP4 8
ADDRGP4 cg+36
INDIRP4
ASGNP4
line 137
;137:	cg.snap = cg.nextSnap;
ADDRGP4 cg+36
ADDRGP4 cg+40
INDIRP4
ASGNP4
line 139
;138:
;139:	BG_PlayerStateToEntityState( &cg.snap->ps, &cg_entities[ cg.snap->ps.clientNum ].currentState, qfalse );
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ARGP4
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
CNSTI4 0
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 140
;140:	cg_entities[ cg.snap->ps.clientNum ].interpolate = qfalse;
CNSTI4 728
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities+416
ADDP4
CNSTI4 0
ASGNI4
line 142
;141:
;142:	for ( i = 0 ; i < cg.snap->numEntities ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $124
JUMPV
LABELV $121
line 143
;143:		cent = &cg_entities[ cg.snap->entities[ i ].number ];
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
line 144
;144:		CG_TransitionEntity( cent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 CG_TransitionEntity
CALLV
pop
line 147
;145:
;146:		// remember time of snapshot this entity was last updated in
;147:		cent->snapShotTime = cg.snap->serverTime;
ADDRLP4 4
INDIRP4
CNSTI4 448
ADDP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 148
;148:	}
LABELV $122
line 142
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $124
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
LTI4 $121
line 150
;149:
;150:	cg.nextSnap = NULL;
ADDRGP4 cg+40
CNSTP4 0
ASGNP4
line 153
;151:
;152:	// check for playerstate transition events
;153:	if ( oldFrame ) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $129
line 156
;154:		playerState_t	*ops, *ps;
;155:
;156:		ops = &oldFrame->ps;
ADDRLP4 12
ADDRLP4 8
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 157
;157:		ps = &cg.snap->ps;
ADDRLP4 16
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 159
;158:		// teleporting checks are irrespective of prediction
;159:		if ( ( ps->eFlags ^ ops->eFlags ) & EF_TELEPORT_BIT ) {
ADDRLP4 20
CNSTI4 104
ASGNI4
ADDRLP4 16
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
ADDRLP4 12
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
BXORI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $132
line 160
;160:			cg.thisFrameTeleport = qtrue;	// will be cleared by prediction code
ADDRGP4 cg+107592
CNSTI4 1
ASGNI4
line 161
;161:		}
LABELV $132
line 165
;162:
;163:		// if we are not doing client side movement prediction for any
;164:		// reason, then the client events and view changes will be issued now
;165:		if ( cg.demoPlayback || (cg.snap->ps.pm_flags & PMF_FOLLOW)
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRGP4 cg+8
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $143
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
ADDRLP4 24
INDIRI4
NEI4 $143
ADDRGP4 cg_nopredict+12
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $143
ADDRGP4 cg_synchronousClients+12
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $135
LABELV $143
line 166
;166:			|| cg_nopredict.integer || cg_synchronousClients.integer ) {
line 167
;167:			CG_TransitionPlayerState( ps, ops );
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 CG_TransitionPlayerState
CALLV
pop
line 168
;168:		}
LABELV $135
line 169
;169:	}
LABELV $129
line 171
;170:
;171:}
LABELV $95
endproc CG_TransitionSnapshot 28 12
proc CG_SetNextSnap 32 12
line 181
;172:
;173:
;174:/*
;175:===================
;176:CG_SetNextSnap
;177:
;178:A new snapshot has just been read in from the client system.
;179:===================
;180:*/
;181:static void CG_SetNextSnap( snapshot_t *snap ) {
line 186
;182:	int					num;
;183:	entityState_t		*es;
;184:	centity_t			*cent;
;185:
;186:	cg.nextSnap = snap;
ADDRGP4 cg+40
ADDRFP4 0
INDIRP4
ASGNP4
line 188
;187:
;188:	BG_PlayerStateToEntityState( &snap->ps, &cg_entities[ snap->ps.clientNum ].nextState, qfalse );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 44
ADDP4
ARGP4
CNSTI4 728
ADDRLP4 12
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities+208
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 189
;189:	cg_entities[ cg.snap->ps.clientNum ].interpolate = qtrue;
CNSTI4 728
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities+416
ADDP4
CNSTI4 1
ASGNI4
line 192
;190:
;191:	// check for extrapolation errors
;192:	for ( num = 0 ; num < snap->numEntities ; num++ ) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $152
JUMPV
LABELV $149
line 193
;193:		es = &snap->entities[num];
ADDRLP4 4
CNSTI4 208
ADDRLP4 8
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
ADDP4
ASGNP4
line 194
;194:		cent = &cg_entities[ es->number ];
ADDRLP4 0
CNSTI4 728
ADDRLP4 4
INDIRP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 196
;195:
;196:		memcpy(&cent->nextState, es, sizeof(entityState_t));
ADDRLP4 16
CNSTI4 208
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 201
;197:		//cent->nextState = *es;
;198:
;199:		// if this frame is a teleport, or the entity wasn't in the
;200:		// previous frame, don't interpolate
;201:		if ( !cent->currentValid || ( ( cent->currentState.eFlags ^ es->eFlags ) & EF_TELEPORT_BIT )  ) {
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 420
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $155
ADDRLP4 28
CNSTI4 8
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
BXORI4
CNSTI4 4
BANDI4
ADDRLP4 24
INDIRI4
EQI4 $153
LABELV $155
line 202
;202:			cent->interpolate = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 416
ADDP4
CNSTI4 0
ASGNI4
line 203
;203:		} else {
ADDRGP4 $154
JUMPV
LABELV $153
line 204
;204:			cent->interpolate = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 416
ADDP4
CNSTI4 1
ASGNI4
line 205
;205:		}
LABELV $154
line 206
;206:	}
LABELV $150
line 192
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $152
ADDRLP4 8
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
LTI4 $149
line 210
;207:
;208:	// if the next frame is a teleport for the playerstate, we
;209:	// can't interpolate during demos
;210:	if ( cg.snap && ( ( snap->ps.eFlags ^ cg.snap->ps.eFlags ) & EF_TELEPORT_BIT ) ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $156
ADDRLP4 16
CNSTI4 148
ASGNI4
ADDRFP4 0
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
BXORI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $156
line 211
;211:		cg.nextFrameTeleport = qtrue;
ADDRGP4 cg+107596
CNSTI4 1
ASGNI4
line 212
;212:	} else {
ADDRGP4 $157
JUMPV
LABELV $156
line 213
;213:		cg.nextFrameTeleport = qfalse;
ADDRGP4 cg+107596
CNSTI4 0
ASGNI4
line 214
;214:	}
LABELV $157
line 217
;215:
;216:	// if changing follow mode, don't interpolate
;217:	if ( cg.nextSnap->ps.clientNum != cg.snap->ps.clientNum ) {
ADDRLP4 20
CNSTI4 184
ASGNI4
ADDRGP4 cg+40
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
EQI4 $162
line 218
;218:		cg.nextFrameTeleport = qtrue;
ADDRGP4 cg+107596
CNSTI4 1
ASGNI4
line 219
;219:	}
LABELV $162
line 222
;220:
;221:	// if changing server restarts, don't interpolate
;222:	if ( ( cg.nextSnap->snapFlags ^ cg.snap->snapFlags ) & SNAPFLAG_SERVERCOUNT ) {
ADDRGP4 cg+40
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
INDIRI4
BXORI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $167
line 223
;223:		cg.nextFrameTeleport = qtrue;
ADDRGP4 cg+107596
CNSTI4 1
ASGNI4
line 224
;224:	}
LABELV $167
line 227
;225:
;226:	// sort out solid entities
;227:	CG_BuildSolidList();
ADDRGP4 CG_BuildSolidList
CALLV
pop
line 228
;228:}
LABELV $144
endproc CG_SetNextSnap 32 12
proc CG_ReadNextSnapshot 20 12
line 241
;229:
;230:
;231:/*
;232:========================
;233:CG_ReadNextSnapshot
;234:
;235:This is the only place new snapshots are requested
;236:This may increment cgs.processedSnapshotNum multiple
;237:times if the client system fails to return a
;238:valid snapshot.
;239:========================
;240:*/
;241:static snapshot_t *CG_ReadNextSnapshot( void ) {
line 245
;242:	qboolean	r;
;243:	snapshot_t	*dest;
;244:
;245:	if ( cg.latestSnapshotNum > cgs.processedSnapshotNum + 1000 ) {
ADDRGP4 cg+28
INDIRI4
ADDRGP4 cgs+31448
INDIRI4
CNSTI4 1000
ADDI4
LEI4 $181
line 246
;246:		CG_Printf( "WARNING: CG_ReadNextSnapshot: way out of range, %i > %i", 
ADDRGP4 $177
ARGP4
ADDRGP4 cg+28
INDIRI4
ARGI4
ADDRGP4 cgs+31448
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 248
;247:			cg.latestSnapshotNum, cgs.processedSnapshotNum );
;248:	}
ADDRGP4 $181
JUMPV
LABELV $180
line 250
;249:
;250:	while ( cgs.processedSnapshotNum < cg.latestSnapshotNum ) {
line 252
;251:		// decide which of the two slots to load it into
;252:		if ( cg.snap == &cg.activeSnapshots[0] ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
ADDRGP4 cg+44
CVPU4 4
NEU4 $185
line 253
;253:			dest = &cg.activeSnapshots[1];
ADDRLP4 0
ADDRGP4 cg+44+53772
ASGNP4
line 254
;254:		} else {
ADDRGP4 $186
JUMPV
LABELV $185
line 255
;255:			dest = &cg.activeSnapshots[0];
ADDRLP4 0
ADDRGP4 cg+44
ASGNP4
line 256
;256:		}
LABELV $186
line 259
;257:
;258:		// try to read the snapshot from the client system
;259:		cgs.processedSnapshotNum++;
ADDRLP4 8
ADDRGP4 cgs+31448
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 260
;260:		r = trap_GetSnapshot( cgs.processedSnapshotNum, dest );
ADDRGP4 cgs+31448
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 trap_GetSnapshot
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
ASGNI4
line 281
;261:
;262://unlagged - lag simulation #1
;263:		// the client wants latent snaps and the just-read snapshot is valid
;264:		//if ( cg_latentSnaps.integer && r ) {
;265:		//	int i = 0, time = dest->serverTime;
;266:
;267:			// keep grabbing one snapshot earlier until we get to the right time
;268:		//	while ( dest->serverTime > time - cg_latentSnaps.integer * (1000 / sv_fps.integer) ) {
;269:		//		if ( !(r = trap_GetSnapshot( cgs.processedSnapshotNum - i, dest )) ) {
;270:					// the snapshot is not valid, so stop here
;271:		//			break;
;272:		//		}
;273:
;274:				// go back one more
;275:		//		i++;
;276:		//	}
;277:	//	}
;278://unlagged - lag simulation #1
;279:
;280:		// FIXME: why would trap_GetSnapshot return a snapshot with the same server time
;281:		if ( cg.snap && r && dest->serverTime == cg.snap->serverTime ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $194
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $194
ADDRLP4 16
CNSTI4 8
ASGNI4
ADDRLP4 0
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
NEI4 $194
line 283
;282:			//continue;
;283:		}
LABELV $194
line 286
;284:
;285:		// if it succeeded, return
;286:		if ( r ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $198
line 287
;287:			CG_AddLagometerSnapshotInfo( dest );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_AddLagometerSnapshotInfo
CALLV
pop
line 288
;288:			return dest;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $172
JUMPV
LABELV $198
line 297
;289:		}
;290:
;291:		// a GetSnapshot will return failure if the snapshot
;292:		// never arrived, or  is so old that its entities
;293:		// have been shoved off the end of the circular
;294:		// buffer in the client system.
;295:
;296:		// record as a dropped packet
;297:		CG_AddLagometerSnapshotInfo( NULL );
CNSTP4 0
ARGP4
ADDRGP4 CG_AddLagometerSnapshotInfo
CALLV
pop
line 301
;298:
;299:		// If there are additional snapshots, continue trying to
;300:		// read them.
;301:	}
LABELV $181
line 250
ADDRGP4 cgs+31448
INDIRI4
ADDRGP4 cg+28
INDIRI4
LTI4 $180
line 304
;302:
;303:	// nothing left to read
;304:	return NULL;
CNSTP4 0
RETP4
LABELV $172
endproc CG_ReadNextSnapshot 20 12
export CG_ProcessSnapshots
proc CG_ProcessSnapshots 16 8
line 327
;305:}
;306:
;307:
;308:/*
;309:============
;310:CG_ProcessSnapshots
;311:
;312:We are trying to set up a renderable view, so determine
;313:what the simulated time is, and try to get snapshots
;314:both before and after that time if available.
;315:
;316:If we don't have a valid cg.snap after exiting this function,
;317:then a 3D game view cannot be rendered.  This should only happen
;318:right after the initial connection.  After cg.snap has been valid
;319:once, it will never turn invalid.
;320:
;321:Even if cg.snap is valid, cg.nextSnap may not be, if the snapshot
;322:hasn't arrived yet (it becomes an extrapolating situation instead
;323:of an interpolating one)
;324:
;325:============
;326:*/
;327:void CG_ProcessSnapshots( void ) {
line 332
;328:	snapshot_t		*snap;
;329:	int				n;
;330:
;331:	// see what the latest snapshot the client system has is
;332:	trap_GetCurrentSnapshotNumber( &n, &cg.latestSnapshotTime );
ADDRLP4 4
ARGP4
ADDRGP4 cg+32
ARGP4
ADDRGP4 trap_GetCurrentSnapshotNumber
CALLV
pop
line 333
;333:	if ( n != cg.latestSnapshotNum ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+28
INDIRI4
EQI4 $211
line 334
;334:		if ( n < cg.latestSnapshotNum ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+28
INDIRI4
GEI4 $205
line 342
;335:			// this should never happen
;336://unlagged - lag simulation #1
;337:			// this may actually happen with lag simulation going on
;338:		//	if ( cg_latentSnaps.integer ) {
;339:		//		CG_Printf( "WARNING: CG_ProcessSnapshots: n < cg.latestSnapshotNum\n" );
;340:		//	}
;341:		//	else {
;342:				CG_Error( "CG_ProcessSnapshots: n < cg.latestSnapshotNum" );
ADDRGP4 $208
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 345
;343:		//	}
;344://unlagged - lag simulation #1
;345:		}
LABELV $205
line 346
;346:		cg.latestSnapshotNum = n;
ADDRGP4 cg+28
ADDRLP4 4
INDIRI4
ASGNI4
line 347
;347:	}
ADDRGP4 $211
JUMPV
LABELV $210
line 352
;348:
;349:	// If we have yet to receive a snapshot, check for it.
;350:	// Once we have gotten the first snapshot, cg.snap will
;351:	// always have valid data for the rest of the game
;352:	while ( !cg.snap ) {
line 353
;353:		snap = CG_ReadNextSnapshot();
ADDRLP4 8
ADDRGP4 CG_ReadNextSnapshot
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 354
;354:		if ( !snap ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $214
line 356
;355:			// we can't continue until we get a snapshot
;356:			return;
ADDRGP4 $200
JUMPV
LABELV $214
line 361
;357:		}
;358:
;359:		// set our weapon selection to what
;360:		// the playerstate is currently using
;361:		if ( !( snap->snapFlags & SNAPFLAG_NOT_ACTIVE ) ) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $216
line 362
;362:			CG_SetInitialSnapshot( snap );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetInitialSnapshot
CALLV
pop
line 363
;363:		}
LABELV $216
line 364
;364:	}
LABELV $211
line 352
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $210
LABELV $218
line 369
;365:
;366:	// loop until we either have a valid nextSnap with a serverTime
;367:	// greater than cg.time to interpolate towards, or we run
;368:	// out of available snapshots
;369:	do {
line 371
;370:		// if we don't have a nextframe, try and read a new one in
;371:		if ( !cg.nextSnap ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $221
line 372
;372:			snap = CG_ReadNextSnapshot();
ADDRLP4 8
ADDRGP4 CG_ReadNextSnapshot
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 376
;373:
;374:			// if we still don't have a nextframe, we will just have to
;375:			// extrapolate
;376:			if ( !snap ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $224
line 377
;377:				break;
ADDRGP4 $220
JUMPV
LABELV $224
line 380
;378:			}
;379:
;380:			CG_SetNextSnap( snap );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetNextSnap
CALLV
pop
line 384
;381:
;382:
;383:			// if time went backwards, we have a level restart
;384:			if ( cg.nextSnap->serverTime < cg.snap->serverTime ) {
ADDRLP4 12
CNSTI4 8
ASGNI4
ADDRGP4 cg+40
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
GEI4 $226
line 391
;385://unlagged - lag simulation #1
;386:				// this may actually happen with lag simulation going on
;387:				//if ( cg_latentSnaps.integer ) {
;388:				//	CG_Printf( "WARNING: CG_ProcessSnapshots: Server time went backwards\n" );
;389:				//}
;390:				//else {
;391:					CG_Error( "CG_ProcessSnapshots: Server time went backwards" );
ADDRGP4 $230
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 394
;392:				//}
;393://unlagged - lag simulation #1
;394:			}
LABELV $226
line 395
;395:		}
LABELV $221
line 398
;396:
;397:		// if our time is < nextFrame's, we have a nice interpolating state
;398:		if ( cg.time >= cg.snap->serverTime && cg.time < cg.nextSnap->serverTime ) {
ADDRLP4 8
CNSTI4 8
ASGNI4
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRI4
LTI4 $231
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+40
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRI4
GEI4 $231
line 399
;399:			break;
ADDRGP4 $220
JUMPV
LABELV $231
line 403
;400:		}
;401:
;402:		// we have passed the transition from nextFrame to frame
;403:		CG_TransitionSnapshot();
ADDRGP4 CG_TransitionSnapshot
CALLV
pop
line 404
;404:	} while ( 1 );
LABELV $219
ADDRGP4 $218
JUMPV
LABELV $220
line 407
;405:
;406:	// assert our valid conditions upon exiting
;407:	if ( cg.snap == NULL ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $237
line 408
;408:		CG_Error( "CG_ProcessSnapshots: cg.snap == NULL" );
ADDRGP4 $240
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 409
;409:	}
LABELV $237
line 410
;410:	if ( cg.time < cg.snap->serverTime ) {
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
GEI4 $241
line 412
;411:		// this can happen right after a vid_restart
;412:		cg.time = cg.snap->serverTime;
ADDRGP4 cg+107604
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 413
;413:	}
LABELV $241
line 414
;414:	if ( cg.nextSnap != NULL && cg.nextSnap->serverTime <= cg.time ) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $247
ADDRGP4 cg+40
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
GTI4 $247
line 415
;415:		CG_Error( "CG_ProcessSnapshots: cg.nextSnap->serverTime <= cg.time" );
ADDRGP4 $252
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 416
;416:	}
LABELV $247
line 418
;417:
;418:}
LABELV $200
endproc CG_ProcessSnapshots 16 8
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
LABELV $252
byte 1 67
byte 1 71
byte 1 95
byte 1 80
byte 1 114
byte 1 111
byte 1 99
byte 1 101
byte 1 115
byte 1 115
byte 1 83
byte 1 110
byte 1 97
byte 1 112
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 115
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
byte 1 45
byte 1 62
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 32
byte 1 60
byte 1 61
byte 1 32
byte 1 99
byte 1 103
byte 1 46
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $240
byte 1 67
byte 1 71
byte 1 95
byte 1 80
byte 1 114
byte 1 111
byte 1 99
byte 1 101
byte 1 115
byte 1 115
byte 1 83
byte 1 110
byte 1 97
byte 1 112
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 115
byte 1 58
byte 1 32
byte 1 99
byte 1 103
byte 1 46
byte 1 115
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
LABELV $230
byte 1 67
byte 1 71
byte 1 95
byte 1 80
byte 1 114
byte 1 111
byte 1 99
byte 1 101
byte 1 115
byte 1 115
byte 1 83
byte 1 110
byte 1 97
byte 1 112
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 115
byte 1 58
byte 1 32
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 32
byte 1 119
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 119
byte 1 97
byte 1 114
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $208
byte 1 67
byte 1 71
byte 1 95
byte 1 80
byte 1 114
byte 1 111
byte 1 99
byte 1 101
byte 1 115
byte 1 115
byte 1 83
byte 1 110
byte 1 97
byte 1 112
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 115
byte 1 58
byte 1 32
byte 1 110
byte 1 32
byte 1 60
byte 1 32
byte 1 99
byte 1 103
byte 1 46
byte 1 108
byte 1 97
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 83
byte 1 110
byte 1 97
byte 1 112
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 78
byte 1 117
byte 1 109
byte 1 0
align 1
LABELV $177
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 67
byte 1 71
byte 1 95
byte 1 82
byte 1 101
byte 1 97
byte 1 100
byte 1 78
byte 1 101
byte 1 120
byte 1 116
byte 1 83
byte 1 110
byte 1 97
byte 1 112
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 58
byte 1 32
byte 1 119
byte 1 97
byte 1 121
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
byte 1 44
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 62
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $103
byte 1 67
byte 1 71
byte 1 95
byte 1 84
byte 1 114
byte 1 97
byte 1 110
byte 1 115
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 83
byte 1 110
byte 1 97
byte 1 112
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 58
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
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
byte 1 0
align 1
LABELV $99
byte 1 67
byte 1 71
byte 1 95
byte 1 84
byte 1 114
byte 1 97
byte 1 110
byte 1 115
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 83
byte 1 110
byte 1 97
byte 1 112
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 58
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 99
byte 1 103
byte 1 46
byte 1 115
byte 1 110
byte 1 97
byte 1 112
byte 1 0
