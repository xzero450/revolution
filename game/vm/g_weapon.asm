export G_BounceProjectile
code
proc G_BounceProjectile 64 4
file "../g_weapon.c"
line 23
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// g_weapon.c 
;4:// perform the server side effects of a weapon firing
;5:
;6:#include "g_local.h"
;7:#include "bg_promode.h"
;8:
;9:static	float	s_quadFactor;
;10:static	vec3_t	forward, right, up;
;11:static	vec3_t	muzzle;
;12:
;13:extern void G_ExplodeMissile( gentity_t *ent );
;14:int ComputeNewTimeShift(gentity_t *ent, int range, int clientHitHum);
;15:
;16:#define NUM_NAILSHOTS 15
;17:
;18:/*
;19:================
;20:G_BounceProjectile
;21:================
;22:*/
;23:void G_BounceProjectile( vec3_t start, vec3_t impact, vec3_t dir, vec3_t endout ) {
line 27
;24:	vec3_t v, newv;
;25:	float dot;
;26:
;27:	VectorSubtract( impact, start, v );
ADDRLP4 28
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 32
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 36
CNSTI4 4
ASGNI4
ADDRLP4 0+4
ADDRLP4 28
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 40
CNSTI4 8
ASGNI4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 28
;28:	dot = DotProduct( v, dir );
ADDRLP4 44
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 0
INDIRF4
ADDRLP4 44
INDIRP4
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 29
;29:	VectorMA( v, -2*dot, dir, newv );
ADDRLP4 48
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 52
CNSTF4 3221225472
ADDRLP4 24
INDIRF4
MULF4
ASGNF4
ADDRLP4 12
ADDRLP4 0
INDIRF4
ADDRLP4 48
INDIRP4
INDIRF4
ADDRLP4 52
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 52
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 0+8
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 3221225472
ADDRLP4 24
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 31
;30:
;31:	VectorNormalize(newv);
ADDRLP4 12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 32
;32:	VectorMA(impact, 8192, newv, endout);
ADDRFP4 12
INDIRP4
ADDRFP4 4
INDIRP4
INDIRF4
CNSTF4 1174405120
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 56
CNSTI4 4
ASGNI4
ADDRFP4 12
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
ADDRFP4 4
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
CNSTF4 1174405120
ADDRLP4 12+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 60
CNSTI4 8
ASGNI4
ADDRFP4 12
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
ADDRFP4 4
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRF4
CNSTF4 1174405120
ADDRLP4 12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 33
;33:}
LABELV $67
endproc G_BounceProjectile 64 4
export Weapon_Gauntlet
proc Weapon_Gauntlet 0 0
line 44
;34:
;35:
;36:/*
;37:======================================================================
;38:
;39:GAUNTLET
;40:
;41:======================================================================
;42:*/
;43:
;44:void Weapon_Gauntlet( gentity_t *ent ) {
line 46
;45:
;46:}
LABELV $78
endproc Weapon_Gauntlet 0 0
export CheckGauntletAttack
proc CheckGauntletAttack 124 32
line 53
;47:
;48:/*
;49:===============
;50:CheckGauntletAttack
;51:===============
;52:*/
;53:qboolean CheckGauntletAttack( gentity_t *ent ) {
line 58
;54:	trace_t		tr;
;55:	vec3_t		end;
;56:	gentity_t	*tent;
;57:	gentity_t	*traceEnt;
;58:	int			damage = gameSettings.hitscans[GS_GAUNTLET][GS_DAMAGE];
ADDRLP4 4
ADDRGP4 gameSettings+104
INDIRI4
ASGNI4
line 60
;59:	// mod code start
;60:	int			hitNothing = 0;
ADDRLP4 88
CNSTI4 0
ASGNI4
line 61
;61:	int			timeshift = 0;
ADDRLP4 76
CNSTI4 0
ASGNI4
line 62
;62:	int			clientHitNum = 0;
ADDRLP4 80
CNSTI4 0
ASGNI4
line 63
;63:	int			shifted = 0;
ADDRLP4 92
CNSTI4 0
ASGNI4
line 65
;64:
;65:	++ent->client->pers.stats_shots[WP_GAUNTLET];
ADDRLP4 96
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9860
ADDP4
ASGNP4
ADDRLP4 96
INDIRP4
ADDRLP4 96
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 70
;66:
;67:		//unlagged - backward reconciliation #2
;68:	// put them back
;69:		//Do this for railjumping?
;70:	G_UndoTimeShiftFor( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_UndoTimeShiftFor
CALLV
pop
line 73
;71:	//unlagged - backward reconciliation #2
;72:	// set aiming directions
;73:	AngleVectors (ent->client->ps.viewangles, forward, right, up);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRGP4 right
ARGP4
ADDRGP4 up
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 75
;74:
;75:	CalcMuzzlePoint ( ent, forward, right, up, muzzle );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRGP4 right
ARGP4
ADDRGP4 up
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 CalcMuzzlePoint
CALLV
pop
line 77
;76:
;77:	VectorMA (muzzle, gameSettings.hitscans[GS_GAUNTLET][GS_RANGE], forward, end);
ADDRLP4 64
ADDRGP4 muzzle
INDIRF4
ADDRGP4 forward
INDIRF4
ADDRGP4 gameSettings+104+4
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
ADDRLP4 64+4
ADDRGP4 muzzle+4
INDIRF4
ADDRGP4 forward+4
INDIRF4
ADDRGP4 gameSettings+104+4
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
ADDRLP4 64+8
ADDRGP4 muzzle+8
INDIRF4
ADDRGP4 forward+8
INDIRF4
ADDRGP4 gameSettings+104+4
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 80
;78:	//VectorMA (muzzle, 32, forward, end);
;79:
;80:	if (ent->client->frameAimType >= 2 ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10388
ADDP4
INDIRI4
CNSTI4 2
LTI4 $93
line 81
;81:		clientHitNum = GetClientTarget(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 GetClientTarget
CALLI4
ASGNI4
ADDRLP4 80
ADDRLP4 100
INDIRI4
ASGNI4
line 82
;82:		timeshift = ComputeNewTimeShift(ent, gameSettings.hitscans[GS_LIGHTNING][GS_RANGE], clientHitNum);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 gameSettings+104+24+4
INDIRI4
ARGI4
ADDRLP4 80
INDIRI4
ARGI4
ADDRLP4 104
ADDRGP4 ComputeNewTimeShift
CALLI4
ASGNI4
ADDRLP4 76
ADDRLP4 104
INDIRI4
ASGNI4
line 84
;83:
;84:		if ( timeshift == 0 ) {
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $98
line 85
;85:			hitNothing = 1;
ADDRLP4 88
CNSTI4 1
ASGNI4
line 86
;86:		}
LABELV $98
line 88
;87:
;88:		if (timeshift == -1 || timeshift == 1) {
ADDRLP4 76
INDIRI4
CNSTI4 -1
EQI4 $102
ADDRLP4 76
INDIRI4
CNSTI4 1
NEI4 $100
LABELV $102
line 89
;89:			if( LogAccuracyHit( &g_entities[clientHitNum], ent ) ) {			
CNSTI4 896
ADDRLP4 80
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 112
ADDRGP4 LogAccuracyHit
CALLI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 0
EQI4 $103
line 90
;90:				ent->client->accuracy_hits++;
ADDRLP4 116
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10316
ADDP4
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 116
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 91
;91:			}
LABELV $103
line 92
;92:			G_Damage (&g_entities[clientHitNum], ent, ent, forward, end, damage, 0, MOD_LIGHTNING);
CNSTI4 896
ADDRLP4 80
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 116
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 116
INDIRP4
ARGP4
ADDRLP4 116
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 64
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 11
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 93
;93:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $79
JUMPV
LABELV $100
line 95
;94:		}
;95:	}
LABELV $93
line 97
;96:
;97:	trap_Trace (&tr, muzzle, NULL, NULL, end, ent->s.number, MASK_SHOT);
ADDRLP4 8
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRLP4 100
CNSTP4 0
ASGNP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 64
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 98
;98:	if ( tr.surfaceFlags & SURF_NOIMPACT ) {
ADDRLP4 8+44
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $105
line 99
;99:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $79
JUMPV
LABELV $105
line 102
;100:	}
;101:
;102:	traceEnt = &g_entities[ tr.entityNum ];
ADDRLP4 0
CNSTI4 896
ADDRLP4 8+52
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 105
;103:
;104:	// send blood impact
;105:	if ( traceEnt->takedamage && traceEnt->client ) {
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
EQI4 $109
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $109
line 106
;106:		tent = G_TempEntity( tr.endpos, EV_MISSILE_HIT );
ADDRLP4 8+12
ARGP4
CNSTI4 50
ARGI4
ADDRLP4 108
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 84
ADDRLP4 108
INDIRP4
ASGNP4
line 107
;107:		tent->s.otherEntityNum = traceEnt->s.number;
ADDRLP4 84
INDIRP4
CNSTI4 140
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 108
;108:		tent->s.eventParm = DirToByte( tr.plane.normal );
ADDRLP4 8+24
ARGP4
ADDRLP4 112
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRLP4 84
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 112
INDIRI4
ASGNI4
line 109
;109:		tent->s.weapon = ent->s.weapon;
ADDRLP4 116
CNSTI4 192
ASGNI4
ADDRLP4 84
INDIRP4
ADDRLP4 116
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 116
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 110
;110:	}
LABELV $109
line 112
;111:
;112:	if ( !traceEnt->takedamage) {
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
NEI4 $113
line 113
;113:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $79
JUMPV
LABELV $113
line 118
;114:	}
;115:	//unlagged - backward reconciliation #2
;116:	// put them back
;117:		//Do this for railjumping?
;118:	G_UndoTimeShiftFor( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_UndoTimeShiftFor
CALLV
pop
line 121
;119:	//unlagged - backward reconciliation #2
;120:
;121:	if (ent->client->ps.powerups[PW_QUAD] ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 316
ADDP4
INDIRI4
CNSTI4 0
EQI4 $115
line 122
;122:		G_AddEvent( ent, EV_POWERUP_QUAD, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 61
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 123
;123:		s_quadFactor = g_quadfactor.value;
ADDRGP4 s_quadFactor
ADDRGP4 g_quadfactor+8
INDIRF4
ASGNF4
line 124
;124:	} else {
ADDRGP4 $116
JUMPV
LABELV $115
line 125
;125:		s_quadFactor = 1;
ADDRGP4 s_quadFactor
CNSTF4 1065353216
ASGNF4
line 126
;126:	}
LABELV $116
line 134
;127:#ifdef MISSIONPACK
;128:	if( ent->client->persistantPowerup && ent->client->persistantPowerup->item && ent->client->persistantPowerup->item->giTag == PW_DOUBLER ) {
;129:		s_quadFactor *= 2;
;130:	}
;131:#endif
;132:
;133:
;134:	damage = gameSettings.hitscans[GS_GAUNTLET][GS_DAMAGE] * s_quadFactor;
ADDRLP4 4
ADDRGP4 gameSettings+104
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 136
;135:	//if ( traceEnt->client ) {
;136:		++ent->client->pers.stats_hits[WP_GAUNTLET];
ADDRLP4 108
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9904
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 137
;137:		ent->client->pers.stats_damage[WP_GAUNTLET] += damage;
ADDRLP4 112
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9952
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 138
;138:		ent->client->pers.stats_totaldamage += damage;
ADDRLP4 116
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9944
ADDP4
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 116
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 140
;139:	//}
;140:	G_Damage( traceEnt, ent, ent, forward, tr.endpos,
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 120
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 120
INDIRP4
ARGP4
ADDRLP4 120
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 8+12
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 143
;141:		damage, 0, MOD_GAUNTLET );
;142:
;143:	return qtrue;
CNSTI4 1
RETI4
LABELV $79
endproc CheckGauntletAttack 124 32
export CheckGauntletJump
proc CheckGauntletJump 180 28
line 151
;144:}
;145:
;146:/*
;147:===============
;148:CheckGauntletJump
;149:===============
;150:*/
;151:qboolean CheckGauntletJump( gentity_t *ent ) {
line 159
;152:	vec3_t		end;
;153:	gentity_t	*traceEnt;
;154:	vec3_t		v;
;155:	float		dist, points;
;156:	int			j;
;157:	trace_t		trace;
;158:	vec3_t		dir;//XX rj
;159:	memcpy( dir, forward, sizeof(dir) );
ADDRLP4 84
ARGP4
ADDRGP4 forward
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 162
;160:
;161:
;162:	if ( !g_gauntletJumping.integer ) {
ADDRGP4 g_gauntletJumping+12
INDIRI4
CNSTI4 0
NEI4 $121
line 163
;163:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $120
JUMPV
LABELV $121
line 166
;164:	}
;165:
;166:	++ent->client->pers.stats_shots[WP_GAUNTLET];
ADDRLP4 108
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9860
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 168
;167:
;168:	AngleVectors (ent->client->ps.viewangles, forward, right, up);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRGP4 right
ARGP4
ADDRGP4 up
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 169
;169:	CalcMuzzlePoint ( ent, forward, right, up, muzzle );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRGP4 right
ARGP4
ADDRGP4 up
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 CalcMuzzlePoint
CALLV
pop
line 170
;170:	VectorMA (muzzle, 8192, forward, end);
ADDRLP4 112
CNSTF4 1174405120
ASGNF4
ADDRLP4 72
ADDRGP4 muzzle
INDIRF4
ADDRLP4 112
INDIRF4
ADDRGP4 forward
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 72+4
ADDRGP4 muzzle+4
INDIRF4
ADDRLP4 112
INDIRF4
ADDRGP4 forward+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 72+8
ADDRGP4 muzzle+8
INDIRF4
CNSTF4 1174405120
ADDRGP4 forward+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 171
;171:	trap_Trace (&trace, muzzle, NULL, NULL, end, ent->s.number, MASK_SHOT);
ADDRLP4 4
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRLP4 116
CNSTP4 0
ASGNP4
ADDRLP4 116
INDIRP4
ARGP4
ADDRLP4 116
INDIRP4
ARGP4
ADDRLP4 72
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 173
;172:
;173:	traceEnt = &g_entities[ trace.entityNum ];
ADDRLP4 104
CNSTI4 896
ADDRLP4 4+52
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 175
;174:
;175:	if ( trace.entityNum < 64 ) { //We hit a client in the trace, not valid.
ADDRLP4 4+52
INDIRI4
CNSTI4 64
GEI4 $131
line 176
;176:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $120
JUMPV
LABELV $131
line 179
;177:	}
;178:
;179:	if ( g_gauntletjumpRadius.integer >= 1 && g_gauntletJumping.integer > 0 ) {
ADDRGP4 g_gauntletjumpRadius+12
INDIRI4
CNSTI4 1
LTI4 $134
ADDRGP4 g_gauntletJumping+12
INDIRI4
CNSTI4 0
LEI4 $134
line 180
;180:		for ( j = 0 ; j < 3 ; j++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $138
line 181
;181:			if ( trace.endpos[j] < ent->r.absmin[j] ) {
ADDRLP4 120
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 120
INDIRI4
ADDRLP4 4+12
ADDP4
INDIRF4
ADDRLP4 120
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 464
ADDP4
ADDP4
INDIRF4
GEF4 $142
line 182
;182:				v[j] = ent->r.absmin[j] - trace.endpos[j];
ADDRLP4 124
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 124
INDIRI4
ADDRLP4 60
ADDP4
ADDRLP4 124
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 464
ADDP4
ADDP4
INDIRF4
ADDRLP4 124
INDIRI4
ADDRLP4 4+12
ADDP4
INDIRF4
SUBF4
ASGNF4
line 183
;183:			} else if ( trace.endpos[j] > ent->r.absmax[j] ) {
ADDRGP4 $143
JUMPV
LABELV $142
ADDRLP4 124
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 124
INDIRI4
ADDRLP4 4+12
ADDP4
INDIRF4
ADDRLP4 124
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRF4
LEF4 $146
line 184
;184:				v[j] = trace.endpos[j] - ent->r.absmax[j];
ADDRLP4 128
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 128
INDIRI4
ADDRLP4 60
ADDP4
ADDRLP4 128
INDIRI4
ADDRLP4 4+12
ADDP4
INDIRF4
ADDRLP4 128
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 185
;185:			} else {
ADDRGP4 $147
JUMPV
LABELV $146
line 186
;186:				v[j] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 60
ADDP4
CNSTF4 0
ASGNF4
line 187
;187:			}
LABELV $147
LABELV $143
line 188
;188:		}
LABELV $139
line 180
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $138
line 190
;189:
;190:		dist = VectorLength( v );
ADDRLP4 60
ARGP4
ADDRLP4 120
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 100
ADDRLP4 120
INDIRF4
ASGNF4
line 192
;191:
;192:		g_StaticKnockback.integer?(points = g_gauntletKnockback.integer):(points = g_gauntletKnockback.integer * ( 1.0 - dist / g_gauntletjumpRadius.integer ));
ADDRGP4 g_StaticKnockback+12
INDIRI4
CNSTI4 0
EQI4 $155
ADDRLP4 96
ADDRGP4 g_gauntletKnockback+12
INDIRI4
CVIF4 4
ASGNF4
ADDRGP4 $156
JUMPV
LABELV $155
ADDRLP4 96
ADDRGP4 g_gauntletKnockback+12
INDIRI4
CVIF4 4
CNSTF4 1065353216
ADDRLP4 100
INDIRF4
ADDRGP4 g_gauntletjumpRadius+12
INDIRI4
CVIF4 4
DIVF4
SUBF4
MULF4
ASGNF4
LABELV $156
line 193
;193:		if ( dist <= g_gauntletjumpRadius.integer ) {
ADDRLP4 100
INDIRF4
ADDRGP4 g_gauntletjumpRadius+12
INDIRI4
CVIF4 4
GTF4 $157
line 194
;194:			if ( g_gauntletJumping.integer == 2  ) {
ADDRGP4 g_gauntletJumping+12
INDIRI4
CNSTI4 2
NEI4 $160
line 199
;195:				//Monkk's railjumping code
;196:					vec3_t	kvel, inverseRailPath;
;197:					float	mass;
;198:
;199:					mass = 200;
ADDRLP4 148
CNSTF4 1128792064
ASGNF4
line 201
;200:
;201:					VectorCopy(forward, inverseRailPath);
ADDRLP4 136
ADDRGP4 forward
INDIRB
ASGNB 12
line 202
;202:					VectorInverse(inverseRailPath);
ADDRLP4 136
ARGP4
ADDRGP4 VectorInverse
CALLV
pop
line 203
;203:					VectorScale ( inverseRailPath, g_knockback.value * (points - 1) / mass, kvel);//Subract 1 for Quad's IU1.2 "feel"
ADDRLP4 152
ADDRLP4 96
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
ADDRLP4 156
ADDRLP4 148
INDIRF4
ASGNF4
ADDRLP4 124
ADDRLP4 136
INDIRF4
ADDRGP4 g_knockback+8
INDIRF4
ADDRLP4 152
INDIRF4
MULF4
ADDRLP4 156
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 124+4
ADDRLP4 136+4
INDIRF4
ADDRGP4 g_knockback+8
INDIRF4
ADDRLP4 152
INDIRF4
MULF4
ADDRLP4 156
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 124+8
ADDRLP4 136+8
INDIRF4
ADDRGP4 g_knockback+8
INDIRF4
ADDRLP4 96
INDIRF4
CNSTF4 1065353216
SUBF4
MULF4
ADDRLP4 148
INDIRF4
DIVF4
MULF4
ASGNF4
line 204
;204:					VectorAdd (ent->client->ps.velocity, kvel, ent->client->ps.velocity);
ADDRLP4 160
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 160
INDIRP4
ADDRLP4 160
INDIRP4
INDIRF4
ADDRLP4 124
INDIRF4
ADDF4
ASGNF4
ADDRLP4 164
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 164
INDIRP4
ADDRLP4 164
INDIRP4
INDIRF4
ADDRLP4 124+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 168
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 168
INDIRP4
ADDRLP4 168
INDIRP4
INDIRF4
ADDRLP4 124+8
INDIRF4
ADDF4
ASGNF4
line 206
;205:
;206:					if ( !ent->client->ps.pm_time ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
NEI4 $172
line 208
;207:						int		t;
;208:						t = (points - 1) * 2;//Subract 1 for Quad's IU1.2 "feel"
ADDRLP4 172
CNSTF4 1073741824
ADDRLP4 96
INDIRF4
CNSTF4 1065353216
SUBF4
MULF4
CVFI4 4
ASGNI4
line 210
;209:
;210:						if ( t < 50 ) {
ADDRLP4 172
INDIRI4
CNSTI4 50
GEI4 $174
line 211
;211:							t = 50;
ADDRLP4 172
CNSTI4 50
ASGNI4
line 212
;212:						}
LABELV $174
line 213
;213:						if ( t > 200 ) {
ADDRLP4 172
INDIRI4
CNSTI4 200
LEI4 $176
line 214
;214:							t = 200;
ADDRLP4 172
CNSTI4 200
ASGNI4
line 215
;215:						}
LABELV $176
line 216
;216:						ent->client->ps.pm_time = t;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 172
INDIRI4
ASGNI4
line 217
;217:						ent->client->ps.pm_flags |= PMF_TIME_KNOCKBACK;
ADDRLP4 176
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 176
INDIRP4
ADDRLP4 176
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 218
;218:					}
LABELV $172
line 219
;219:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $120
JUMPV
LABELV $160
line 220
;220:			} else if ( g_gauntletJumping.integer == 3 || g_gauntletJumping.integer == 4 ) {//XoneXfer
ADDRGP4 g_gauntletJumping+12
INDIRI4
CNSTI4 3
EQI4 $182
ADDRGP4 g_gauntletJumping+12
INDIRI4
CNSTI4 4
NEI4 $178
LABELV $182
line 226
;221:				gentity_t	*bolt;//XX rj
;222:				
;223:				/* RailJump style 4 is possibly closer to IU than anything... */
;224:				
;225:
;226:				bolt = G_Spawn();
ADDRLP4 128
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 124
ADDRLP4 128
INDIRP4
ASGNP4
line 227
;227:				bolt->classname = "rocket";
ADDRLP4 124
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $183
ASGNP4
line 228
;228:				bolt->nextthink = level.time + 2000;
ADDRLP4 124
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 230
;229:				//bolt->nextthink = level.time;//Think now <-- Evo did it.
;230:				bolt->think = G_ExplodeMissile;
ADDRLP4 124
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 G_ExplodeMissile
ASGNP4
line 233
;231:				
;232:				
;233:				bolt->s.eType = ET_MISSILE;
ADDRLP4 124
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 3
ASGNI4
line 234
;234:				bolt->r.svFlags = SVF_USE_CURRENT_ORIGIN;
ADDRLP4 124
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 128
ASGNI4
line 235
;235:				bolt->r.svFlags = SVF_NOCLIENT;
ADDRLP4 124
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 1
ASGNI4
line 236
;236:				bolt->s.eFlags |= EF_NODRAW ;
ADDRLP4 132
ADDRLP4 124
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 132
INDIRP4
ADDRLP4 132
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 237
;237:				bolt->s.weapon = WP_ROCKET_LAUNCHER;
ADDRLP4 124
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 5
ASGNI4
line 238
;238:				bolt->r.ownerNum = ent->s.number;
ADDRLP4 124
INDIRP4
CNSTI4 512
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 239
;239:				bolt->parent = ent;
ADDRLP4 124
INDIRP4
CNSTI4 600
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 240
;240:				bolt->damage = g_gauntletKnockback.integer;
ADDRLP4 124
INDIRP4
CNSTI4 740
ADDP4
ADDRGP4 g_gauntletKnockback+12
INDIRI4
ASGNI4
line 241
;241:				bolt->splashDamage = g_gauntletKnockback.integer;
ADDRLP4 124
INDIRP4
CNSTI4 744
ADDP4
ADDRGP4 g_gauntletKnockback+12
INDIRI4
ASGNI4
line 242
;242:				bolt->splashRadius = g_gauntletjumpRadius.integer;//was 120
ADDRLP4 124
INDIRP4
CNSTI4 748
ADDP4
ADDRGP4 g_gauntletjumpRadius+12
INDIRI4
ASGNI4
line 243
;243:				bolt->methodOfDeath = MOD_XX_RAILJUMP;
ADDRLP4 124
INDIRP4
CNSTI4 752
ADDP4
CNSTI4 24
ASGNI4
line 244
;244:				bolt->splashMethodOfDeath = MOD_XX_RAILJUMP;
ADDRLP4 124
INDIRP4
CNSTI4 756
ADDP4
CNSTI4 24
ASGNI4
line 245
;245:				bolt->clipmask = MASK_SHOT;
ADDRLP4 124
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 100663297
ASGNI4
line 246
;246:				bolt->target_ent = NULL;
ADDRLP4 124
INDIRP4
CNSTI4 668
ADDP4
CNSTP4 0
ASGNP4
line 248
;247:				
;248:				bolt->s.pos.trType = TR_LINEAR;
ADDRLP4 124
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 2
ASGNI4
line 250
;249:				//bolt->s.pos.trTime = level.time - 50;		// move a bit on the very first frame
;250:				VectorCopy( muzzle, bolt->s.pos.trBase );
ADDRLP4 124
INDIRP4
CNSTI4 24
ADDP4
ADDRGP4 muzzle
INDIRB
ASGNB 12
line 251
;251:				VectorScale( dir, (g_RailJumping.integer == 3 ? (900) : (50000)), bolt->s.pos.trDelta );
ADDRGP4 g_RailJumping+12
INDIRI4
CNSTI4 3
NEI4 $196
ADDRLP4 136
CNSTI4 900
ASGNI4
ADDRGP4 $197
JUMPV
LABELV $196
ADDRLP4 136
CNSTI4 50000
ASGNI4
LABELV $197
ADDRLP4 124
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 84
INDIRF4
ADDRLP4 136
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRGP4 g_RailJumping+12
INDIRI4
CNSTI4 3
NEI4 $198
ADDRLP4 140
CNSTI4 900
ASGNI4
ADDRGP4 $199
JUMPV
LABELV $198
ADDRLP4 140
CNSTI4 50000
ASGNI4
LABELV $199
ADDRLP4 124
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 84+4
INDIRF4
ADDRLP4 140
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRGP4 g_RailJumping+12
INDIRI4
CNSTI4 3
NEI4 $200
ADDRLP4 144
CNSTI4 900
ASGNI4
ADDRGP4 $201
JUMPV
LABELV $200
ADDRLP4 144
CNSTI4 50000
ASGNI4
LABELV $201
ADDRLP4 124
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 84+8
INDIRF4
ADDRLP4 144
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 252
;252:				SnapVector( bolt->s.pos.trDelta );			// save net bandwidth
ADDRLP4 148
ADDRLP4 124
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 148
INDIRP4
ADDRLP4 148
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 152
ADDRLP4 124
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 152
INDIRP4
ADDRLP4 152
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 156
ADDRLP4 124
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 156
INDIRP4
ADDRLP4 156
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 253
;253:				VectorCopy (muzzle, bolt->r.currentOrigin);
ADDRLP4 124
INDIRP4
CNSTI4 488
ADDP4
ADDRGP4 muzzle
INDIRB
ASGNB 12
line 255
;254:				
;255:				VectorSet(bolt->r.mins, 0, 0, 0);
ADDRLP4 124
INDIRP4
CNSTI4 436
ADDP4
CNSTF4 0
ASGNF4
ADDRLP4 124
INDIRP4
CNSTI4 440
ADDP4
CNSTF4 0
ASGNF4
ADDRLP4 124
INDIRP4
CNSTI4 444
ADDP4
CNSTF4 0
ASGNF4
line 256
;256:				VectorCopy(bolt->r.mins, bolt->r.absmin);
ADDRLP4 148
ADDRLP4 124
INDIRP4
ASGNP4
ADDRLP4 148
INDIRP4
CNSTI4 464
ADDP4
ADDRLP4 148
INDIRP4
CNSTI4 436
ADDP4
INDIRB
ASGNB 12
line 257
;257:				VectorSet(bolt->r.maxs, 0, 0, 0);
ADDRLP4 124
INDIRP4
CNSTI4 448
ADDP4
CNSTF4 0
ASGNF4
ADDRLP4 124
INDIRP4
CNSTI4 452
ADDP4
CNSTF4 0
ASGNF4
ADDRLP4 124
INDIRP4
CNSTI4 456
ADDP4
CNSTF4 0
ASGNF4
line 258
;258:				VectorCopy(bolt->r.maxs, bolt->r.absmax);
ADDRLP4 152
ADDRLP4 124
INDIRP4
ASGNP4
ADDRLP4 152
INDIRP4
CNSTI4 476
ADDP4
ADDRLP4 152
INDIRP4
CNSTI4 448
ADDP4
INDIRB
ASGNB 12
line 259
;259:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $120
JUMPV
LABELV $178
line 260
;260:			} else {//Revolution
line 263
;261:				vec3_t	kvel;
;262:				float	mass;
;263:				mass = 200;
ADDRLP4 136
CNSTF4 1128792064
ASGNF4
line 265
;264:
;265:				VectorSubtract (ent->r.currentOrigin, muzzle, end);
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
ADDRLP4 140
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRGP4 muzzle
INDIRF4
SUBF4
ASGNF4
ADDRLP4 72+4
ADDRLP4 140
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRGP4 muzzle+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 72+8
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRGP4 muzzle+8
INDIRF4
SUBF4
ASGNF4
line 268
;266:				// push the center of mass higher than the origin so players
;267:				// get knocked into the air more
;268:				end[2] += 26;
ADDRLP4 72+8
ADDRLP4 72+8
INDIRF4
CNSTF4 1104150528
ADDF4
ASGNF4
line 270
;269:
;270:				VectorNormalize(end);
ADDRLP4 72
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 271
;271:				VectorScale ( end, g_knockback.value * points / mass, kvel);
ADDRLP4 144
ADDRLP4 96
INDIRF4
ASGNF4
ADDRLP4 148
ADDRLP4 136
INDIRF4
ASGNF4
ADDRLP4 124
ADDRLP4 72
INDIRF4
ADDRGP4 g_knockback+8
INDIRF4
ADDRLP4 144
INDIRF4
MULF4
ADDRLP4 148
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 124+4
ADDRLP4 72+4
INDIRF4
ADDRGP4 g_knockback+8
INDIRF4
ADDRLP4 144
INDIRF4
MULF4
ADDRLP4 148
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 124+8
ADDRLP4 72+8
INDIRF4
ADDRGP4 g_knockback+8
INDIRF4
ADDRLP4 96
INDIRF4
MULF4
ADDRLP4 136
INDIRF4
DIVF4
MULF4
ASGNF4
line 272
;272:				VectorAdd (ent->client->ps.velocity, kvel, ent->client->ps.velocity);
ADDRLP4 152
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 152
INDIRP4
ADDRLP4 152
INDIRP4
INDIRF4
ADDRLP4 124
INDIRF4
ADDF4
ASGNF4
ADDRLP4 156
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 156
INDIRP4
ADDRLP4 156
INDIRP4
INDIRF4
ADDRLP4 124+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 160
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 160
INDIRP4
ADDRLP4 160
INDIRP4
INDIRF4
ADDRLP4 124+8
INDIRF4
ADDF4
ASGNF4
line 274
;273:
;274:				if ( !ent->client->ps.pm_time ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
NEI4 $216
line 276
;275:					int		t;
;276:					t = points * 2;
ADDRLP4 164
CNSTF4 1073741824
ADDRLP4 96
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 278
;277:
;278:					if ( t < 50 ) {
ADDRLP4 164
INDIRI4
CNSTI4 50
GEI4 $218
line 279
;279:						t = 50;
ADDRLP4 164
CNSTI4 50
ASGNI4
line 280
;280:					}
LABELV $218
line 281
;281:					if ( t > 200 ) {
ADDRLP4 164
INDIRI4
CNSTI4 200
LEI4 $220
line 282
;282:						t = 200;
ADDRLP4 164
CNSTI4 200
ASGNI4
line 283
;283:					}
LABELV $220
line 284
;284:					ent->client->ps.pm_time = t;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 164
INDIRI4
ASGNI4
line 285
;285:					ent->client->ps.pm_flags |= PMF_TIME_KNOCKBACK;
ADDRLP4 168
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 168
INDIRP4
ADDRLP4 168
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 286
;286:				}
LABELV $216
line 287
;287:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $120
JUMPV
LABELV $157
line 290
;288:			}
;289:		}
;290:	}
LABELV $134
line 292
;291:
;292:	return qfalse;
CNSTI4 0
RETI4
LABELV $120
endproc CheckGauntletJump 180 28
export Bullet_Fire
proc Bullet_Fire 180 32
line 338
;293:}
;294:
;295:
;296:/*
;297:======================================================================
;298:
;299:MACHINEGUN
;300:
;301:======================================================================
;302:*/
;303:
;304:/*
;305:======================
;306:SnapVectorTowards
;307:
;308:Round a vector to integers for more efficient network
;309:transmission, but make sure that it rounds towards a given point
;310:rather than blindly truncating.  This prevents it from truncating 
;311:into a wall.
;312:======================
;313:*/
;314://unlagged - attack prediction #3
;315:// moved to q_shared.c
;316:/*
;317:void SnapVectorTowards( vec3_t v, vec3_t to ) {
;318:	int		i;
;319:
;320:	for ( i = 0 ; i < 3 ; i++ ) {
;321:		if ( to[i] <= v[i] ) {
;322:			v[i] = (int)v[i];
;323:		} else {
;324:			v[i] = (int)v[i] + 1;
;325:		}
;326:	}
;327:}
;328:*/
;329://unlagged - attack prediction #3
;330:
;331:#ifdef MISSIONPACK
;332:#define CHAINGUN_SPREAD		600
;333:#endif
;334:#define MACHINEGUN_SPREAD	200
;335:#define	MACHINEGUN_DAMAGE	7
;336:#define	MACHINEGUN_TEAM_DAMAGE	5		// wimpier MG in teamplay
;337:
;338:void Bullet_Fire (gentity_t *ent, float spread, int damage ) {
line 351
;339:	trace_t		tr;
;340:	vec3_t		end;
;341:#ifdef MISSIONPACK
;342:	vec3_t		impactpoint, bouncedir;
;343:#endif
;344:	float		r;
;345:	float		u;
;346:	gentity_t	*tent;
;347:	gentity_t	*traceEnt;
;348:	int			i, passent;
;349://unlagged - attack prediction #2
;350:	// we have to use something now that the client knows in advance
;351:	int			seed = ent->client->attackTime % 256;
ADDRLP4 92
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10400
ADDP4
INDIRI4
CNSTI4 256
MODI4
ASGNI4
line 353
;352://unlagged - attack prediction #2
;353:	int			unlinked = 0;
ADDRLP4 108
CNSTI4 0
ASGNI4
line 357
;354:	int			timeshiftResult;
;355://	gentity_t	*unlinkedEntities[10];
;356:	int			clientEnt;
;357:	int			hitNothing = 0;
ADDRLP4 104
CNSTI4 0
ASGNI4
line 358
;358:	int			shifted = 0;
ADDRLP4 112
CNSTI4 0
ASGNI4
line 362
;359:
;360:    //NT - shift other clients back to the client's idea of the server
;361:    // time to compensate for lag
;362:	++ent->client->pers.stats_shots[WP_MACHINEGUN];
ADDRLP4 116
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9864
ADDP4
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 116
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 364
;363:
;364:	damage *= s_quadFactor;
ADDRFP4 8
ADDRFP4 8
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 375
;365:
;366:
;367:
;368://unlagged - attack prediction #2
;369:	// this has to match what's on the client
;370:/*
;371:	r = random() * M_PI * 2.0f;
;372:	u = sin(r) * crandom() * spread * 16;
;373:	r = cos(r) * crandom() * spread * 16;
;374:*/
;375:	r = Q_random(&seed) * M_PI * 2.0f;
ADDRLP4 92
ARGP4
ADDRLP4 120
ADDRGP4 Q_random
CALLF4
ASGNF4
ADDRLP4 84
CNSTF4 1073741824
CNSTF4 1078530011
ADDRLP4 120
INDIRF4
MULF4
MULF4
ASGNF4
line 376
;376:	u = sin(r) * Q_crandom(&seed) * spread * 16;
ADDRLP4 84
INDIRF4
ARGF4
ADDRLP4 124
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 92
ARGP4
ADDRLP4 128
ADDRGP4 Q_crandom
CALLF4
ASGNF4
ADDRLP4 88
CNSTF4 1098907648
ADDRLP4 124
INDIRF4
ADDRLP4 128
INDIRF4
MULF4
ADDRFP4 4
INDIRF4
MULF4
MULF4
ASGNF4
line 377
;377:	r = cos(r) * Q_crandom(&seed) * spread * 16;
ADDRLP4 84
INDIRF4
ARGF4
ADDRLP4 132
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 92
ARGP4
ADDRLP4 136
ADDRGP4 Q_crandom
CALLF4
ASGNF4
ADDRLP4 84
CNSTF4 1098907648
ADDRLP4 132
INDIRF4
ADDRLP4 136
INDIRF4
MULF4
ADDRFP4 4
INDIRF4
MULF4
MULF4
ASGNF4
line 379
;378://unlagged - attack prediction #2
;379:	VectorMA (muzzle, 8192*16, forward, end);
ADDRLP4 140
CNSTF4 1207959552
ASGNF4
ADDRLP4 64
ADDRGP4 muzzle
INDIRF4
ADDRLP4 140
INDIRF4
ADDRGP4 forward
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 64+4
ADDRGP4 muzzle+4
INDIRF4
ADDRLP4 140
INDIRF4
ADDRGP4 forward+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 64+8
ADDRGP4 muzzle+8
INDIRF4
CNSTF4 1207959552
ADDRGP4 forward+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 380
;380:	VectorMA (end, r, right, end);
ADDRLP4 64
ADDRLP4 64
INDIRF4
ADDRGP4 right
INDIRF4
ADDRLP4 84
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 64+4
ADDRLP4 64+4
INDIRF4
ADDRGP4 right+4
INDIRF4
ADDRLP4 84
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 64+8
ADDRLP4 64+8
INDIRF4
ADDRGP4 right+8
INDIRF4
ADDRLP4 84
INDIRF4
MULF4
ADDF4
ASGNF4
line 381
;381:	VectorMA (end, u, up, end);
ADDRLP4 64
ADDRLP4 64
INDIRF4
ADDRGP4 up
INDIRF4
ADDRLP4 88
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 64+4
ADDRLP4 64+4
INDIRF4
ADDRGP4 up+4
INDIRF4
ADDRLP4 88
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 64+8
ADDRLP4 64+8
INDIRF4
ADDRGP4 up+8
INDIRF4
ADDRLP4 88
INDIRF4
MULF4
ADDF4
ASGNF4
line 383
;382:
;383:	 if (ent->client->frameAimType >= 2) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10388
ADDP4
INDIRI4
CNSTI4 2
LTI4 $241
line 384
;384:			clientEnt = GetClientTarget(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 152
ADDRGP4 GetClientTarget
CALLI4
ASGNI4
ADDRLP4 100
ADDRLP4 152
INDIRI4
ASGNI4
line 385
;385:		timeshiftResult = ComputeNewTimeShift(ent, 8192*16, clientEnt);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 131072
ARGI4
ADDRLP4 100
INDIRI4
ARGI4
ADDRLP4 156
ADDRGP4 ComputeNewTimeShift
CALLI4
ASGNI4
ADDRLP4 96
ADDRLP4 156
INDIRI4
ASGNI4
line 387
;386:
;387:		if (timeshiftResult == 0) {
ADDRLP4 96
INDIRI4
CNSTI4 0
NEI4 $243
line 388
;388:			hitNothing = 1;
ADDRLP4 104
CNSTI4 1
ASGNI4
line 389
;389:		}
LABELV $243
line 391
;390:
;391:		if (timeshiftResult == -1) {
ADDRLP4 96
INDIRI4
CNSTI4 -1
NEI4 $245
line 392
;392:			traceEnt = &g_entities[clientEnt];
ADDRLP4 0
CNSTI4 896
ADDRLP4 100
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 393
;393:			if ( traceEnt->takedamage /*&& G_AllowEntityInteraction(ent, traceEnt)*/) {
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
EQI4 $247
line 394
;394:				if (traceEnt->client) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $249
line 395
;395:					tent = G_TempEntity( tr.endpos, EV_BULLET_HIT_FLESH );
ADDRLP4 4+12
ARGP4
CNSTI4 48
ARGI4
ADDRLP4 160
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 60
ADDRLP4 160
INDIRP4
ASGNP4
line 396
;396:					tent->s.eventParm = traceEnt->s.number;
ADDRLP4 60
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 397
;397:					tent->s.clientNum = ent->s.number;
ADDRLP4 60
INDIRP4
CNSTI4 168
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 398
;398:					tent->s.otherEntityNum = ent->s.number;
ADDRLP4 60
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 400
;399:
;400:					if (ent && ent->client) {
ADDRLP4 164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 168
CNSTU4 0
ASGNU4
ADDRLP4 164
INDIRP4
CVPU4 4
ADDRLP4 168
INDIRU4
EQU4 $252
ADDRLP4 164
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 168
INDIRU4
EQU4 $252
line 401
;401:						tent->r.svFlags |= SVF_CLIENTMASK;
ADDRLP4 172
ADDRLP4 60
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 172
INDIRP4
ADDRLP4 172
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 402
;402:						tent->r.singleClient = GetClientMask(ent->client->sess.sessionTeam);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
ARGI4
ADDRLP4 176
ADDRGP4 GetClientMask
CALLI4
ASGNI4
ADDRLP4 60
INDIRP4
CNSTI4 428
ADDP4
ADDRLP4 176
INDIRI4
ASGNI4
line 403
;403:					}
LABELV $252
line 405
;404:
;405:					if( LogAccuracyHit( traceEnt, ent ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 172
ADDRGP4 LogAccuracyHit
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
EQI4 $254
line 406
;406:						ent->client->accuracy_hits++;
ADDRLP4 176
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10316
ADDP4
ASGNP4
ADDRLP4 176
INDIRP4
ADDRLP4 176
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 407
;407:					}
LABELV $254
line 408
;408:				}
LABELV $249
line 410
;409:
;410:				G_Damage( traceEnt, ent, ent, forward, tr.endpos,
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 160
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 160
INDIRP4
ARGP4
ADDRLP4 160
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 4+12
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 412
;411:					damage, 0, MOD_MACHINEGUN);
;412:			}
LABELV $247
line 413
;413:		}
LABELV $245
line 414
;414:	}
LABELV $241
line 417
;415:
;416:
;417:	passent = ent->s.number;
ADDRLP4 80
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 418
;418:	for (i = 0; i < 10; i++) {
ADDRLP4 76
CNSTI4 0
ASGNI4
LABELV $257
line 422
;419:
;420://unlagged - backward reconciliation #2
;421:		// backward-reconcile the other clients
;422:		G_DoTimeShiftFor( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_DoTimeShiftFor
CALLV
pop
line 425
;423://unlagged - backward reconciliation #2
;424:
;425:		trap_Trace (&tr, muzzle, NULL, NULL, end, passent, MASK_SHOT);
ADDRLP4 4
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRLP4 152
CNSTP4 0
ASGNP4
ADDRLP4 152
INDIRP4
ARGP4
ADDRLP4 152
INDIRP4
ARGP4
ADDRLP4 64
ARGP4
ADDRLP4 80
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 429
;426:
;427://unlagged - backward reconciliation #2
;428:		// put them back
;429:		G_UndoTimeShiftFor( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_UndoTimeShiftFor
CALLV
pop
line 432
;430://unlagged - backward reconciliation #2
;431:
;432:		if ( tr.surfaceFlags & SURF_NOIMPACT ) {
ADDRLP4 4+44
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $261
line 433
;433:			return;
ADDRGP4 $222
JUMPV
LABELV $261
line 436
;434:		}
;435:
;436:		traceEnt = &g_entities[ tr.entityNum ];
ADDRLP4 0
CNSTI4 896
ADDRLP4 4+52
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 439
;437:
;438:		// snap the endpos to integers, but nudged towards the line
;439:		SnapVectorTowards( tr.endpos, muzzle );
ADDRLP4 4+12
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 SnapVectorTowards
CALLV
pop
line 442
;440:
;441:		// send bullet impact
;442:		if ( traceEnt->takedamage && traceEnt->client ) {
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
EQI4 $266
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $266
line 443
;443:			tent = G_TempEntity( tr.endpos, EV_BULLET_HIT_FLESH );
ADDRLP4 4+12
ARGP4
CNSTI4 48
ARGI4
ADDRLP4 160
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 60
ADDRLP4 160
INDIRP4
ASGNP4
line 444
;444:			tent->s.eventParm = traceEnt->s.number;
ADDRLP4 60
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 448
;445://unlagged - attack prediction #2
;446:			// we need the client number to determine whether or not to
;447:			// suppress this event
;448:			tent->s.clientNum = ent->s.clientNum;
ADDRLP4 164
CNSTI4 168
ASGNI4
ADDRLP4 60
INDIRP4
ADDRLP4 164
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 164
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 450
;449://unlagged - attack prediction #2
;450:			if( LogAccuracyHit( traceEnt, ent ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 168
ADDRGP4 LogAccuracyHit
CALLI4
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 0
EQI4 $267
line 451
;451:				ent->client->accuracy_hits++;
ADDRLP4 172
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10316
ADDP4
ASGNP4
ADDRLP4 172
INDIRP4
ADDRLP4 172
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 452
;452:			}
line 454
;453://freeze
;454:		} else if ( g_gamemode.integer > 3 && is_body( traceEnt ) ) {
ADDRGP4 $267
JUMPV
LABELV $266
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $271
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 160
ADDRGP4 is_body
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
EQI4 $271
line 455
;455:			tent = G_TempEntity( tr.endpos, EV_BULLET_HIT_FLESH );
ADDRLP4 4+12
ARGP4
CNSTI4 48
ARGI4
ADDRLP4 164
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 60
ADDRLP4 164
INDIRP4
ASGNP4
line 456
;456:			tent->s.eventParm = traceEnt->s.number;
ADDRLP4 60
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 458
;457://freeze
;458:		} else {
ADDRGP4 $272
JUMPV
LABELV $271
line 459
;459:			tent = G_TempEntity( tr.endpos, EV_BULLET_HIT_WALL );
ADDRLP4 4+12
ARGP4
CNSTI4 49
ARGI4
ADDRLP4 164
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 60
ADDRLP4 164
INDIRP4
ASGNP4
line 460
;460:			tent->s.eventParm = DirToByte( tr.plane.normal );
ADDRLP4 4+24
ARGP4
ADDRLP4 168
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRLP4 60
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 168
INDIRI4
ASGNI4
line 464
;461://unlagged - attack prediction #2
;462:			// we need the client number to determine whether or not to
;463:			// suppress this event
;464:			tent->s.clientNum = ent->s.clientNum;
ADDRLP4 172
CNSTI4 168
ASGNI4
ADDRLP4 60
INDIRP4
ADDRLP4 172
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 172
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 466
;465://unlagged - attack prediction #2
;466:		}
LABELV $272
LABELV $267
line 467
;467:		tent->s.otherEntityNum = ent->s.number;
ADDRLP4 60
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 469
;468:
;469:		if ( traceEnt->takedamage) {
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
EQI4 $259
line 486
;470:#ifdef MISSIONPACK
;471:			if ( traceEnt->client && traceEnt->client->invulnerabilityTime > level.time ) {
;472:				if (G_InvulnerabilityEffect( traceEnt, forward, tr.endpos, impactpoint, bouncedir )) {
;473:					G_BounceProjectile( muzzle, impactpoint, bouncedir, end );
;474:					VectorCopy( impactpoint, muzzle );
;475:					// the player can hit him/herself with the bounced rail
;476:					passent = ENTITYNUM_NONE;
;477:				}
;478:				else {
;479:					VectorCopy( tr.endpos, muzzle );
;480:					passent = traceEnt->s.number;
;481:				}
;482:				continue;
;483:			}
;484:			else {
;485:#endif
;486:				if ( traceEnt->client ) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $279
line 487
;487:					++ent->client->pers.stats_hits[WP_MACHINEGUN];
ADDRLP4 164
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9908
ADDP4
ASGNP4
ADDRLP4 164
INDIRP4
ADDRLP4 164
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 488
;488:					ent->client->pers.stats_damage[WP_MACHINEGUN] += damage;
ADDRLP4 168
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9956
ADDP4
ASGNP4
ADDRLP4 168
INDIRP4
ADDRLP4 168
INDIRP4
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
ASGNI4
line 489
;489:					ent->client->pers.stats_totaldamage += damage;
ADDRLP4 172
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9944
ADDP4
ASGNP4
ADDRLP4 172
INDIRP4
ADDRLP4 172
INDIRP4
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
ASGNI4
line 490
;490:				}
LABELV $279
line 491
;491:				G_Damage( traceEnt, ent, ent, forward, tr.endpos,
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 164
INDIRP4
ARGP4
ADDRLP4 164
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 4+12
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 496
;492:					damage, 0, MOD_MACHINEGUN);
;493:#ifdef MISSIONPACK
;494:			}
;495:#endif
;496:		}
line 497
;497:		break;
ADDRGP4 $259
JUMPV
LABELV $258
line 418
ADDRLP4 76
ADDRLP4 76
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 10
LTI4 $257
LABELV $259
line 499
;498:	}
;499:}
LABELV $222
endproc Bullet_Fire 180 32
export BFG_Fire
proc BFG_Fire 20 12
line 510
;500:
;501:
;502:/*
;503:======================================================================
;504:
;505:BFG
;506:
;507:======================================================================
;508:*/
;509:
;510:void BFG_Fire ( gentity_t *ent ) {
line 513
;511:	gentity_t	*m;
;512:
;513:	++ent->client->pers.stats_shots[WP_BFG];
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9892
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 515
;514:
;515:	m = fire_bfg (ent, muzzle, forward);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 8
ADDRGP4 fire_bfg
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 516
;516:	m->damage *= s_quadFactor;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 517
;517:	m->splashDamage *= s_quadFactor;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 520
;518:
;519://	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
;520:}
LABELV $282
endproc BFG_Fire 20 12
export ShotgunPellet
proc ShotgunPellet 112 32
line 535
;521:
;522:
;523:/*
;524:======================================================================
;525:
;526:SHOTGUN
;527:
;528:======================================================================
;529:*/
;530:
;531:// DEFAULT_SHOTGUN_SPREAD and DEFAULT_SHOTGUN_COUNT	are in bg_public.h, because
;532:// client predicts same spreads
;533:#define	DEFAULT_SHOTGUN_DAMAGE	10
;534:
;535:qboolean ShotgunPellet( vec3_t start, vec3_t end, gentity_t *ent ) {
line 543
;536:	trace_t		tr;
;537:	int			damage, i, passent;
;538:	gentity_t	*traceEnt;
;539:#ifdef MISSIONPACK
;540:	vec3_t		impactpoint, bouncedir;
;541:#endif
;542:	vec3_t		tr_start, tr_end;
;543:	int			unlinked = 0;
ADDRLP4 96
CNSTI4 0
ASGNI4
line 550
;544://	gentity_t	*unlinkedEntities[10];
;545:
;546:	/* Ideally we should make some messy looking if's so we don't need these variables */
;547:	//WP_DEFAULTS
;548:	//int	damage = cpm_SSGdmg;
;549:
;550:	passent = ent->s.number;
ADDRLP4 92
ADDRFP4 8
INDIRP4
INDIRI4
ASGNI4
line 551
;551:	VectorCopy( start, tr_start );
ADDRLP4 64
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 552
;552:	VectorCopy( end, tr_end );
ADDRLP4 76
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 553
;553:	for (i = 0; i < 10; i++) {
ADDRLP4 60
CNSTI4 0
ASGNI4
LABELV $284
line 554
;554:		trap_Trace (&tr, tr_start, NULL, NULL, tr_end, 128, MASK_SHOT);
ADDRLP4 0
ARGP4
ADDRLP4 64
ARGP4
ADDRLP4 100
CNSTP4 0
ASGNP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 76
ARGP4
CNSTI4 128
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 555
;555:		traceEnt = &g_entities[ tr.entityNum ];
ADDRLP4 56
CNSTI4 896
ADDRLP4 0+52
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 558
;556:
;557:		// send bullet impact
;558:		if (  tr.surfaceFlags & SURF_NOIMPACT ) {
ADDRLP4 0+44
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $289
line 559
;559:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $283
JUMPV
LABELV $289
line 562
;560:		}
;561:
;562:		if ( traceEnt->takedamage) {
ADDRLP4 56
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
EQI4 $292
line 564
;563:			//damage = DEFAULT_SHOTGUN_DAMAGE * s_quadFactor;
;564:			damage = gameSettings.hitscans[GS_SHOTGUN][GS_DAMAGE] * s_quadFactor; // CPM
ADDRLP4 88
ADDRGP4 gameSettings+104+16
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 591
;565:#ifdef MISSIONPACK
;566:			if ( traceEnt->client && traceEnt->client->invulnerabilityTime > level.time ) {
;567:				if (G_InvulnerabilityEffect( traceEnt, forward, tr.endpos, impactpoint, bouncedir )) {
;568:					G_BounceProjectile( tr_start, impactpoint, bouncedir, tr_end );
;569:					VectorCopy( impactpoint, tr_start );
;570:					// the player can hit him/herself with the bounced rail
;571:					passent = ENTITYNUM_NONE;
;572:				}
;573:				else {
;574:					VectorCopy( tr.endpos, tr_start );
;575:					passent = traceEnt->s.number;
;576:				}
;577:				continue;
;578:			}
;579:			else {
;580:				G_Damage( traceEnt, ent, ent, forward, tr.endpos,
;581:					damage, 0, MOD_SHOTGUN);
;582:				if( LogAccuracyHit( traceEnt, ent ) ) {
;583:					return qtrue;
;584:				}
;585:			}
;586:#else		
;587:			//if ( traceEnt->client ) {
;588:			//	ent->client->pers.stats_damage[WP_SHOTGUN] += damage;
;589:			//	ent->client->pers.stats_totaldamage += damage;
;590:			//}
;591:			G_Damage( traceEnt, ent, ent, forward, tr.endpos,	damage, 0, MOD_SHOTGUN);
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 104
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 104
INDIRP4
ARGP4
ADDRLP4 104
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 0+12
ARGP4
ADDRLP4 88
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 592
;592:				if( LogAccuracyHit( traceEnt, ent ) ) {
ADDRLP4 56
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 108
ADDRGP4 LogAccuracyHit
CALLI4
ASGNI4
ADDRLP4 108
INDIRI4
CNSTI4 0
EQI4 $297
line 593
;593:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $283
JUMPV
LABELV $297
line 596
;594:		}
;595:#endif
;596:		}
LABELV $292
line 597
;597:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $283
JUMPV
LABELV $285
line 553
ADDRLP4 60
ADDRLP4 60
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 10
LTI4 $284
line 599
;598:	}
;599:	return qfalse;
CNSTI4 0
RETI4
LABELV $283
endproc ShotgunPellet 112 32
export ShotgunPattern
proc ShotgunPattern 112 12
line 603
;600:}
;601:
;602:// this should match CG_ShotgunPattern
;603:void ShotgunPattern( vec3_t origin, vec3_t origin2, int seed, gentity_t *ent ) {
line 609
;604:	int			i;
;605:	float		r, u;
;606:	vec3_t		end;
;607:	vec3_t		forward, right, up;
;608:	int			oldScore;
;609:	qboolean	hitClient = qfalse;
ADDRLP4 60
CNSTI4 0
ASGNI4
line 618
;610:
;611://unlagged - attack prediction #2
;612:	// use this for testing
;613:	//Com_Printf( "Server seed: %d\n", seed );
;614://unlagged - attack prediction #2
;615:
;616:	// mod code start
;617:
;618:	int	shifted = 0;
ADDRLP4 68
CNSTI4 0
ASGNI4
line 624
;619:
;620:	// mod code end
;621:
;622:	// derive the right and up vectors from the forward vector, because
;623:	// the client won't have any other information
;624:	VectorNormalize2( origin2, forward );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 VectorNormalize2
CALLF4
pop
line 625
;625:	PerpendicularVector( right, forward );
ADDRLP4 32
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 PerpendicularVector
CALLV
pop
line 626
;626:	CrossProduct( forward, right, up );
ADDRLP4 20
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 44
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 628
;627:
;628:	oldScore = ent->client->ps.persistant[PERS_SCORE];
ADDRLP4 64
ADDRFP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
ASGNI4
line 635
;629:
;630:	// mod code start
;631:
;632:	
;633://unlagged - backward reconciliation #2
;634:	// backward-reconcile the other clients
;635:	G_DoTimeShiftFor( ent );
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 G_DoTimeShiftFor
CALLV
pop
line 652
;636://unlagged - backward reconciliation #2
;637:
;638:
;639:
;640:    //NT - shift other clients back to the client's idea of the server
;641:    // time to compensate for lag
;642:/*
;643:	if ( g_delagHitscan.integer && ent->client && ent->client->frameAimType != 0 && 
;644:        !(ent->r.svFlags & SVF_BOT) ) {
;645:        G_TimeShiftAllClients( GetClientServerTime(ent), ent );
;646:		shifted = 1;
;647:    }
;648:*/
;649:	// mod code end
;650:
;651:	// generate the "random" spread pattern
;652:	for ( i = 0 ; i < DEFAULT_SHOTGUN_COUNT ; i++ ) {
ADDRLP4 56
CNSTI4 0
ASGNI4
LABELV $300
line 654
;653:	//for ( i = 0 ; i < cpm_SSGcount ; i++ ) { // CPM
;654:		r = Q_crandom( &seed ) * DEFAULT_SHOTGUN_SPREAD * 16;
ADDRFP4 8
ARGP4
ADDRLP4 72
ADDRGP4 Q_crandom
CALLF4
ASGNF4
ADDRLP4 12
CNSTF4 1098907648
CNSTF4 1143930880
ADDRLP4 72
INDIRF4
MULF4
MULF4
ASGNF4
line 655
;655:		u = Q_crandom( &seed ) * DEFAULT_SHOTGUN_SPREAD * 16;
ADDRFP4 8
ARGP4
ADDRLP4 76
ADDRGP4 Q_crandom
CALLF4
ASGNF4
ADDRLP4 16
CNSTF4 1098907648
CNSTF4 1143930880
ADDRLP4 76
INDIRF4
MULF4
MULF4
ASGNF4
line 658
;656:	//	r = Q_crandom( &seed ) * cpm_SSGspread;  // CPM
;657:	//	u = Q_crandom( &seed ) * cpm_SSGspread;  // CPM
;658:		VectorMA( origin, 8192 * 16, forward, end);
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
CNSTF4 1207959552
ASGNF4
ADDRLP4 0
ADDRLP4 80
INDIRP4
INDIRF4
ADDRLP4 84
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 80
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 84
INDIRF4
ADDRLP4 20+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1207959552
ADDRLP4 20+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 659
;659:		VectorMA (end, r, right, end);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 32
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 32+4
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 32+8
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
line 660
;660:		VectorMA (end, u, up, end);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 44
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 44+4
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 44+8
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDF4
ASGNF4
line 661
;661:		++ent->client->pers.stats_shots[WP_SHOTGUN];
ADDRLP4 96
ADDRFP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9868
ADDP4
ASGNP4
ADDRLP4 96
INDIRP4
ADDRLP4 96
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 662
;662:		if( ShotgunPellet( origin, end, ent ) && !hitClient ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 ShotgunPellet
CALLI4
ASGNI4
ADDRLP4 104
CNSTI4 0
ASGNI4
ADDRLP4 100
INDIRI4
ADDRLP4 104
INDIRI4
EQI4 $320
ADDRLP4 60
INDIRI4
ADDRLP4 104
INDIRI4
NEI4 $320
line 663
;663:			hitClient = qtrue;
ADDRLP4 60
CNSTI4 1
ASGNI4
line 664
;664:			if ( ent->client ) {
ADDRFP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $322
line 665
;665:				++ent->client->pers.stats_hits[WP_SHOTGUN];
ADDRLP4 108
ADDRFP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9912
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 666
;666:			}
LABELV $322
line 667
;667:			ent->client->accuracy_hits++;
ADDRLP4 108
ADDRFP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10316
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 668
;668:		}
LABELV $320
line 669
;669:	}
LABELV $301
line 652
ADDRLP4 56
ADDRLP4 56
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 11
LTI4 $300
line 675
;670:	
;671:	// mod code start
;672:
;673://unlagged - backward reconciliation #2
;674:	// put them back
;675:	G_UndoTimeShiftFor( ent );
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 G_UndoTimeShiftFor
CALLV
pop
line 685
;676://unlagged - backward reconciliation #2
;677:	
;678:    //NT - move the clients back to their proper positions
;679:
;680:    //if ( shifted ) {
;681:    //    G_UnTimeShiftAllClients( ent );
;682:    //}
;683:
;684:	// mod code end
;685:}
LABELV $299
endproc ShotgunPattern 112 12
export weapon_supershotgun_fire
proc weapon_supershotgun_fire 24 16
line 688
;686:
;687:
;688:void weapon_supershotgun_fire (gentity_t *ent) {
line 694
;689:	gentity_t		*tent;
;690:
;691:	//ComputeNewTimeShift(ent, 4096);
;692:
;693:	// send shotgun blast
;694:	tent = G_TempEntity( muzzle, EV_SHOTGUN );
ADDRGP4 muzzle
ARGP4
CNSTI4 54
ARGI4
ADDRLP4 4
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 695
;695:	VectorScale( forward, 4096, tent->s.origin2 );
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
CNSTF4 1166016512
ADDRGP4 forward
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
CNSTF4 1166016512
ADDRGP4 forward+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
CNSTF4 1166016512
ADDRGP4 forward+8
INDIRF4
MULF4
ASGNF4
line 696
;696:	SnapVector( tent->s.origin2 );
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 700
;697://unlagged - attack prediction #2
;698:	// this has to be something the client can predict now
;699:	//tent->s.eventParm = rand() & 255;		// seed for spread pattern
;700:	tent->s.eventParm = ent->client->attackTime % 256; // seed for spread pattern
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10400
ADDP4
INDIRI4
CNSTI4 256
MODI4
ASGNI4
line 702
;701://unlagged - attack prediction #2
;702:	tent->s.otherEntityNum = ent->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 703
;703:	tent->s.clientNum = ent->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 706
;704:
;705:
;706:	if (ent && ent->client)
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
CNSTU4 0
ASGNU4
ADDRLP4 8
INDIRP4
CVPU4 4
ADDRLP4 12
INDIRU4
EQU4 $327
ADDRLP4 8
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 12
INDIRU4
EQU4 $327
line 707
;707:	{
line 708
;708:		tent->r.svFlags |= SVF_CLIENTMASK;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 424
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
line 709
;709:		tent->r.singleClient = GetClientMask(ent->client->sess.sessionTeam);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 GetClientMask
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 428
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 710
;710:	}
LABELV $327
line 712
;711:
;712:	ShotgunPattern( tent->s.pos.trBase, tent->s.origin2, tent->s.eventParm, ent );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 ShotgunPattern
CALLV
pop
line 713
;713:}
LABELV $324
endproc weapon_supershotgun_fire 24 16
export weapon_grenadelauncher_fire
proc weapon_grenadelauncher_fire 24 12
line 724
;714:
;715:
;716:/*
;717:======================================================================
;718:
;719:GRENADE LAUNCHER
;720:
;721:======================================================================
;722:*/
;723:
;724:void weapon_grenadelauncher_fire (gentity_t *ent) {
line 727
;725:	gentity_t	*m;
;726:
;727:	++ent->client->pers.stats_shots[WP_GRENADE_LAUNCHER];
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9872
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 729
;728:	// extra vertical velocity
;729:	forward[2] += 0.2f;
ADDRLP4 8
ADDRGP4 forward+8
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 730
;730:	VectorNormalize( forward );
ADDRGP4 forward
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 732
;731:
;732:	m = fire_grenade (ent, muzzle, forward);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 12
ADDRGP4 fire_grenade
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 733
;733:	m->damage *= s_quadFactor;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 734
;734:	m->splashDamage *= s_quadFactor;
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 737
;735:
;736://	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
;737:}
LABELV $329
endproc weapon_grenadelauncher_fire 24 12
export Weapon_RocketLauncher_Fire
proc Weapon_RocketLauncher_Fire 20 12
line 747
;738:
;739:/*
;740:======================================================================
;741:
;742:ROCKET
;743:
;744:======================================================================
;745:*/
;746:
;747:void Weapon_RocketLauncher_Fire (gentity_t *ent) {
line 750
;748:	gentity_t	*m;
;749:
;750:	++ent->client->pers.stats_shots[WP_ROCKET_LAUNCHER];
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9876
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 752
;751:
;752:	m = fire_rocket (ent, muzzle, forward);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 8
ADDRGP4 fire_rocket
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 753
;753:	m->damage *= s_quadFactor;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 754
;754:	m->splashDamage *= s_quadFactor;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 757
;755:
;756://	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
;757:}
LABELV $331
endproc Weapon_RocketLauncher_Fire 20 12
export Weapon_Plasmagun_Fire
proc Weapon_Plasmagun_Fire 20 12
line 768
;758:
;759:
;760:/*
;761:======================================================================
;762:
;763:PLASMA GUN
;764:
;765:======================================================================
;766:*/
;767:
;768:void Weapon_Plasmagun_Fire (gentity_t *ent) {
line 771
;769:	gentity_t	*m;
;770:
;771:	++ent->client->pers.stats_shots[WP_PLASMAGUN];
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9888
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 773
;772:
;773:	m = fire_plasma (ent, muzzle, forward);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 8
ADDRGP4 fire_plasma
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 774
;774:	m->damage *= s_quadFactor;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 775
;775:	m->splashDamage *= s_quadFactor;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 778
;776:
;777://	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
;778:}
LABELV $332
endproc Weapon_Plasmagun_Fire 20 12
export dot
proc dot 28 0
line 793
;779:
;780:/*
;781:======================================================================
;782:
;783:RAILGUN
;784:
;785:======================================================================
;786:*/
;787:#define	MAX_RAIL_HITS	4
;788:
;789://
;790:// Mod code start
;791://
;792:
;793:int dot(vec3_t A, vec3_t B, vec3_t C) {
line 798
;794:    double AB[2];
;795:    double BC[2];
;796:	double dot;
;797:
;798:    AB[0] = B[0]-A[0];
ADDRLP4 0
ADDRFP4 4
INDIRP4
INDIRF4
ADDRFP4 0
INDIRP4
INDIRF4
SUBF4
ASGNF4
line 799
;799:    AB[1] = B[1]-A[1];
ADDRLP4 20
CNSTI4 4
ASGNI4
ADDRLP4 0+4
ADDRFP4 4
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 800
;800:    BC[0] = C[0]-B[0];
ADDRLP4 8
ADDRFP4 8
INDIRP4
INDIRF4
ADDRFP4 4
INDIRP4
INDIRF4
SUBF4
ASGNF4
line 801
;801:    BC[1] = C[1]-B[1];
ADDRLP4 24
CNSTI4 4
ASGNI4
ADDRLP4 8+4
ADDRFP4 8
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 803
;802:
;803:    dot = AB[0] * BC[0] + AB[1] * BC[1];
ADDRLP4 16
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 8+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 805
;804:
;805:    return dot;
ADDRLP4 16
INDIRF4
CVFI4 4
RETI4
LABELV $333
endproc dot 28 0
export cross
proc cross 28 0
line 808
;806:}
;807://Compute the cross product AB x AC
;808:double cross(vec3_t A, vec3_t B, vec3_t C) {
line 813
;809:    double AB[2];
;810:    double AC[2];
;811:	double cross;
;812:
;813:    AB[0] = B[0]-A[0];
ADDRLP4 0
ADDRFP4 4
INDIRP4
INDIRF4
ADDRFP4 0
INDIRP4
INDIRF4
SUBF4
ASGNF4
line 814
;814:    AB[1] = B[1]-A[1];
ADDRLP4 20
CNSTI4 4
ASGNI4
ADDRLP4 0+4
ADDRFP4 4
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 815
;815:    AC[0] = C[0]-A[0];
ADDRLP4 8
ADDRFP4 8
INDIRP4
INDIRF4
ADDRFP4 0
INDIRP4
INDIRF4
SUBF4
ASGNF4
line 816
;816:    AC[1] = C[1]-A[1];
ADDRLP4 24
CNSTI4 4
ASGNI4
ADDRLP4 8+4
ADDRFP4 8
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 818
;817:
;818:    cross = AB[0] * AC[1] - AB[1] * AC[0];
ADDRLP4 16
ADDRLP4 0
INDIRF4
ADDRLP4 8+4
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 8
INDIRF4
MULF4
SUBF4
ASGNF4
line 820
;819:
;820:    return cross;
ADDRLP4 16
INDIRF4
RETF4
LABELV $338
endproc cross 28 0
export distance
proc distance 24 4
line 823
;821:}
;822://Compute the distance from A to B
;823:double distance(vec3_t A, vec3_t B){
line 824
;824:    double d1 = A[0] - B[0];
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRF4
ADDRFP4 4
INDIRP4
INDIRF4
SUBF4
ASGNF4
line 825
;825:    double d2 = A[1] - B[1];
ADDRLP4 8
CNSTI4 4
ASGNI4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 826
;826:    return sqrt(d1*d1+d2*d2);
ADDRLP4 0
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDRLP4 4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 20
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 20
INDIRF4
RETF4
LABELV $343
endproc distance 24 4
export linePointDist
proc linePointDist 36 12
line 830
;827:}
;828://Compute the distance from AB to C
;829://if isSegment is true, AB is a segment, not a line.
;830:double linePointDist(vec3_t A, vec3_t B, vec3_t C, int isSegment) {
line 833
;831:	double dot1;
;832:	double dot2;
;833:    double dist = cross(A,B,C) / distance(A,B);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 cross
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 distance
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRLP4 16
INDIRF4
DIVF4
ASGNF4
line 835
;834:
;835:    if(isSegment) {
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $345
line 836
;836:        dot1 = dot(A,B,C);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 dot
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 20
INDIRI4
CVIF4 4
ASGNF4
line 837
;837:        if(dot1 > 0)
ADDRLP4 4
INDIRF4
CNSTF4 0
LEF4 $347
line 838
;838:			return distance(B,C);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 distance
CALLF4
ASGNF4
ADDRLP4 24
INDIRF4
RETF4
ADDRGP4 $344
JUMPV
LABELV $347
line 840
;839:
;840:        dot2 = dot(B,A,C);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 dot
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 28
INDIRI4
CVIF4 4
ASGNF4
line 841
;841:        if(dot2 > 0)
ADDRLP4 8
INDIRF4
CNSTF4 0
LEF4 $349
line 842
;842:			return distance(A,C);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 distance
CALLF4
ASGNF4
ADDRLP4 32
INDIRF4
RETF4
ADDRGP4 $344
JUMPV
LABELV $349
line 843
;843:    }
LABELV $345
line 844
;844:    return abs(dist);
ADDRLP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 20
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CVIF4 4
RETF4
LABELV $344
endproc linePointDist 36 12
export GetClientServerTime
proc GetClientServerTime 16 0
line 848
;845:}
;846:
;847:
;848:int GetClientServerTime(gentity_t* ent) {
line 849
;849:	int ttime = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 851
;850:
;851:	if (!ent || !ent->client)
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
CNSTU4 0
ASGNU4
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRU4
EQU4 $354
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRU4
NEU4 $352
LABELV $354
line 852
;852:		return level.time;
ADDRGP4 level+40
INDIRI4
RETI4
ADDRGP4 $351
JUMPV
LABELV $352
line 854
;853:
;854:	if (ent->client->frameAimType == 0)
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10388
ADDP4
INDIRI4
CNSTI4 0
NEI4 $356
line 855
;855:	{
line 856
;856:		return level.previousTime + ent->client->frameOffset;
ADDRGP4 level+44
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10808
ADDP4
INDIRI4
ADDI4
RETI4
ADDRGP4 $351
JUMPV
LABELV $356
line 859
;857:	}
;858:
;859:	if (ent->client->frameAimType == 1)
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10388
ADDP4
INDIRI4
CNSTI4 1
NEI4 $359
line 860
;860:	{
line 861
;861:		return ent->client->attackTime + ent->client->pers.cmdTimeNudge;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 10400
ADDP4
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 10072
ADDP4
INDIRI4
ADDI4
RETI4
ADDRGP4 $351
JUMPV
LABELV $359
line 867
;862:		
;863:	}
;864:
;865:	//ttime = ent->client->pers.cmd.serverTime + ent->client->sess.ServertimeNudge;
;866:
;867:	ttime = ent->client->attackTime + ent->client->pers.cmdTimeNudge;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
CNSTI4 10400
ADDP4
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 10072
ADDP4
INDIRI4
ADDI4
ASGNI4
line 881
;868:
;869:	/*
;870:	//trap_SendServerCommandC( ent->client->ps.clientNum, va("print \"GetClientServerTime: %i, %i, %i\n\"", level.time, level.time - ent->client->sess.aimNudge, ent->client->sess.aimNudge));
;871:	if (level.time - ent->client->sess.aimNudge > level.time)
;872:	{
;873:		return level.previousTime + ent->client->frameOffset;
;874:	}
;875:	else
;876:	{
;877:		return level.time - ent->client->sess.aimNudge;
;878:	}
;879:	*/
;880:
;881:	if (ttime > level.time)
ADDRLP4 0
INDIRI4
ADDRGP4 level+40
INDIRI4
LEI4 $361
line 882
;882:		ttime = level.time;
ADDRLP4 0
ADDRGP4 level+40
INDIRI4
ASGNI4
LABELV $361
line 884
;883:
;884:	return ttime;
ADDRLP4 0
INDIRI4
RETI4
LABELV $351
endproc GetClientServerTime 16 0
export ValidateHitAimType2
proc ValidateHitAimType2 140 28
line 888
;885:}
;886:
;887:int ValidateHitAimType2(gentity_t *ent, int clientHitNum, int range)
;888:{
line 893
;889:	trace_t		trace;
;890:	vec3_t		end;
;891:	//vec3_t		mins;
;892:	//vec3_t		maxs;
;893:	gentity_t *oent = &g_entities[clientHitNum];
ADDRLP4 4
CNSTI4 896
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 895
;894:	int time;
;895:	int hitTarget = 0;
ADDRLP4 88
CNSTI4 0
ASGNI4
line 896
;896:	int timeOffset = 9999;
ADDRLP4 92
CNSTI4 9999
ASGNI4
line 897
;897:	int bestTime = GetClientServerTime(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 112
ADDRGP4 GetClientServerTime
CALLI4
ASGNI4
ADDRLP4 72
ADDRLP4 112
INDIRI4
ASGNI4
line 898
;898:	int bestTimeOffset = 9999;
ADDRLP4 96
CNSTI4 9999
ASGNI4
line 899
;899:	double closestDistance = 9999;
ADDRLP4 12
CNSTF4 1176255488
ASGNF4
line 900
;900:	double dist = 9999;
ADDRLP4 8
CNSTF4 1176255488
ASGNF4
line 903
;901:	//int timeOffsetAtClosest = GetClientServerTime(ent);
;902:
;903:	int counter = 0;
ADDRLP4 100
CNSTI4 0
ASGNI4
line 904
;904:	int counter1 = 0;
ADDRLP4 104
CNSTI4 0
ASGNI4
line 905
;905:	int counter2 = 0;
ADDRLP4 108
CNSTI4 0
ASGNI4
line 907
;906:
;907:	if (!range)
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $366
line 908
;908:		range = 8192;
ADDRFP4 8
CNSTI4 8192
ASGNI4
LABELV $366
line 910
;909:
;910:	VectorMA (muzzle, range, forward, end);
ADDRLP4 116
ADDRFP4 8
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 76
ADDRGP4 muzzle
INDIRF4
ADDRGP4 forward
INDIRF4
ADDRLP4 116
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 76+4
ADDRGP4 muzzle+4
INDIRF4
ADDRGP4 forward+4
INDIRF4
ADDRLP4 116
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 76+8
ADDRGP4 muzzle+8
INDIRF4
ADDRGP4 forward+8
INDIRF4
ADDRFP4 8
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 912
;911:
;912:	if (!oent || !ent)
ADDRLP4 120
CNSTU4 0
ASGNU4
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRLP4 120
INDIRU4
EQU4 $376
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRLP4 120
INDIRU4
NEU4 $374
LABELV $376
line 913
;913:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $365
JUMPV
LABELV $374
line 916
;914:
;915:
;916:	G_DoTimeShiftFor( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_DoTimeShiftFor
CALLV
pop
line 918
;917:
;918:	trap_Trace (&trace, muzzle, NULL, NULL, end, 128, MASK_SHOT );
ADDRLP4 16
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRLP4 124
CNSTP4 0
ASGNP4
ADDRLP4 124
INDIRP4
ARGP4
ADDRLP4 124
INDIRP4
ARGP4
ADDRLP4 76
ARGP4
CNSTI4 128
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 920
;919:
;920:	if (trace.entityNum == clientHitNum) {
ADDRLP4 16+52
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $377
line 921
;921:		return GetClientServerTime(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 128
ADDRGP4 GetClientServerTime
CALLI4
ASGNI4
ADDRLP4 128
INDIRI4
RETI4
ADDRGP4 $365
JUMPV
LABELV $377
line 923
;922:	}
;923:	G_UndoTimeShiftFor( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_UndoTimeShiftFor
CALLV
pop
line 928
;924:
;925:
;926:	// FIXME: Temporary fix for DENIED issues due to geometry
;927:	// This opens up the potential for a shoot through walls exploit
;928:	trap_Trace (&trace, muzzle, NULL, NULL, end, 128, 0 );
ADDRLP4 16
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRLP4 128
CNSTP4 0
ASGNP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRLP4 76
ARGP4
CNSTI4 128
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 933
;929:	//trap_Trace (&trace, muzzle, NULL, NULL, end, 128, MASK_SOLID );
;930:		
;931:
;932:
;933:	for (time = level.time; time >= level.time-(NUM_CLIENT_HISTORY*(1000/sv_fps.integer)); time -= 25) {
ADDRLP4 0
ADDRGP4 level+40
INDIRI4
ASGNI4
ADDRGP4 $383
JUMPV
LABELV $380
line 936
;934:
;935:		//G_TimeShiftAllClients(time, ent);
;936:		G_TimeShiftClient(oent, time, qfalse, oent);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_TimeShiftClient
CALLV
pop
line 938
;937:
;938:		dist = linePointDist(muzzle, trace.endpos, g_entities[clientHitNum].r.currentOrigin, 1);
ADDRGP4 muzzle
ARGP4
ADDRLP4 16+12
ARGP4
CNSTI4 896
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 g_entities+208+280
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 136
ADDRGP4 linePointDist
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 136
INDIRF4
ASGNF4
line 941
;939:
;940:		//G_UnTimeShiftAllClients(ent);
;941:		G_UnTimeShiftClient(oent);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_UnTimeShiftClient
CALLV
pop
line 943
;942:
;943:		if (dist < closestDistance) {
ADDRLP4 8
INDIRF4
ADDRLP4 12
INDIRF4
GEF4 $390
line 944
;944:			closestDistance = dist;
ADDRLP4 12
ADDRLP4 8
INDIRF4
ASGNF4
line 946
;945:			//timeOffsetAtClosest = time - GetClientServerTime(ent);
;946:			bestTime = time;
ADDRLP4 72
ADDRLP4 0
INDIRI4
ASGNI4
line 947
;947:		}
LABELV $390
line 948
;948:	}
LABELV $381
line 933
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 25
SUBI4
ASGNI4
LABELV $383
ADDRLP4 0
INDIRI4
ADDRGP4 level+40
INDIRI4
CNSTI4 9
CNSTI4 1000
ADDRGP4 sv_fps+12
INDIRI4
DIVI4
MULI4
SUBI4
GEI4 $380
line 951
;949:
;950:	// Don't force kills for gauntlet, as it would allow a larger gauntlet range.
;951:	if (closestDistance < 100 /*&& range > 100*/) {
ADDRLP4 12
INDIRF4
CNSTF4 1120403456
GEF4 $392
line 952
;952:		ent->client->sess.ServertimeNudge = bestTime - ent->client->pers.cmd.serverTime;
ADDRLP4 132
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 132
INDIRP4
CNSTI4 10232
ADDP4
ADDRLP4 72
INDIRI4
ADDRLP4 132
INDIRP4
CNSTI4 472
ADDP4
INDIRI4
SUBI4
ASGNI4
line 953
;953:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $365
JUMPV
LABELV $392
line 956
;954:	}
;955:
;956:	return -2;
CNSTI4 -2
RETI4
LABELV $365
endproc ValidateHitAimType2 140 28
export GetClientTarget
proc GetClientTarget 0 0
line 959
;957:}
;958:
;959:int GetClientTarget(gentity_t *ent) {
line 961
;960:	
;961:	if (ent->r.svFlags & SVF_BOT) {
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $395
line 962
;962:		return -2;
CNSTI4 -2
RETI4
ADDRGP4 $394
JUMPV
LABELV $395
line 966
;963:	}
;964:
;965:	
;966:	if (ent->client->hitClient == 0) { // Client said they missed
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10380
ADDP4
INDIRI4
CNSTI4 0
NEI4 $397
line 968
;967:		//G_Printf("Client %i said miss\n", ent->client->ps.clientNum);
;968:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $394
JUMPV
LABELV $397
line 969
;969:	} else {
line 973
;970:		// client said they hit this person. Still need to verify to prevent hackers.
;971:		// Need to subtract 1 to get real client number, since 0 is used to represent a miss.
;972:		//G_Printf("Client %i said hit: %i -- %i\n", ent->client->ps.clientNum, ent->client->hitClient, ent->client->hitClient - 1);
;973:		return ent->client->hitClient - 1;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10380
ADDP4
INDIRI4
CNSTI4 1
SUBI4
RETI4
LABELV $394
endproc GetClientTarget 0 0
export ComputeNewTimeShift
proc ComputeNewTimeShift 24 12
line 991
;974:	}
;975:}
;976:
;977:/**********************
;978:ComputeNewTimeShift
;979:-
;980:returns:
;981:0	client said they missed
;982:1	client hit
;983:2	this is a bot, bots don't use timeshift
;984:3	this client uses old style aim, or isn't unlagged
;985:-1	client said they hit, and it's close enough that it's probably true
;986:-2	client said they hit, but server says they're not shooting in the 
;987:	right direction... could be lag related, or an attempted cheater
;988:**********************/
;989:
;990:
;991:int ComputeNewTimeShift(gentity_t *ent, int range, int clientHitNum) {
line 992
;992:	int timeshift = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 995
;993:	//int clientHitNum = 0;
;994:
;995:	if (!ent || !ent->client)
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
CNSTU4 0
ASGNU4
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRU4
EQU4 $402
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRU4
NEU4 $400
LABELV $402
line 996
;996:		return 3;
CNSTI4 3
RETI4
ADDRGP4 $399
JUMPV
LABELV $400
line 998
;997:
;998:	if (ent->r.svFlags & SVF_BOT) {
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $403
line 999
;999:		return 2;
CNSTI4 2
RETI4
ADDRGP4 $399
JUMPV
LABELV $403
line 1000
;1000:	} else {
line 1008
;1001:		/*if (ent->client->frameAimType == 0 || ent->client->frameAimType == 1) {
;1002:			return 3;
;1003:		}*/
;1004:		
;1005:		//clientHitNum = GetClientTarget(ent);
;1006:
;1007:		// Client said they missed, so return
;1008:		if (clientHitNum < 0) {
ADDRFP4 8
INDIRI4
CNSTI4 0
GEI4 $405
line 1009
;1009:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $399
JUMPV
LABELV $405
line 1012
;1010:		}
;1011:
;1012:		if (ent->client->frameAimType >= 2) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10388
ADDP4
INDIRI4
CNSTI4 2
LTI4 $407
line 1013
;1013:			if (clientHitNum >= 0 && clientHitNum < MAX_CLIENTS) {
ADDRLP4 12
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
LTI4 $409
ADDRLP4 12
INDIRI4
CNSTI4 64
GEI4 $409
line 1015
;1014:				// don't bother trying to find a way to hit yourself, but still try to hit other clients
;1015:				if (clientHitNum == ent->client->ps.clientNum) {
ADDRFP4 8
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
NEI4 $411
line 1016
;1016:					return 1;
CNSTI4 1
RETI4
ADDRGP4 $399
JUMPV
LABELV $411
line 1020
;1017:				}
;1018:
;1019:				// valid client number
;1020:				timeshift = ValidateHitAimType2(ent, clientHitNum, range);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 ValidateHitAimType2
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 16
INDIRI4
ASGNI4
line 1021
;1021:				if (timeshift == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $413
line 1022
;1022:					return -1;
CNSTI4 -1
RETI4
ADDRGP4 $399
JUMPV
LABELV $413
line 1024
;1023:				}
;1024:				if (timeshift == -2) {
ADDRLP4 0
INDIRI4
CNSTI4 -2
NEI4 $415
line 1025
;1025:					if (ent->client->ps.weapon == WP_RAILGUN) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 7
NEI4 $417
line 1026
;1026:						trap_SendServerCommand( ent-g_entities, va("miss \"%i\"", clientHitNum) );
ADDRGP4 $419
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 896
DIVI4
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1027
;1027:					}
LABELV $417
line 1028
;1028:					return -2;
CNSTI4 -2
RETI4
ADDRGP4 $399
JUMPV
LABELV $415
line 1030
;1029:				}
;1030:			}
LABELV $409
line 1031
;1031:		}
LABELV $407
line 1032
;1032:	}
line 1034
;1033:
;1034:	return 1;
CNSTI4 1
RETI4
LABELV $399
endproc ComputeNewTimeShift 24 12
export weapon_railgun_fire
proc weapon_railgun_fire 304 32
line 1049
;1035:}
;1036:
;1037://
;1038:// Mod code end
;1039://
;1040:
;1041:
;1042:/*
;1043:=================
;1044:weapon_railgun_fire
;1045:=================
;1046:*/
;1047://#define	MAX_RAIL_HITS	4
;1048://#define	ADV_MAX_RAIL_HITS	18
;1049:void weapon_railgun_fire (gentity_t *ent) {
line 1070
;1050:	vec3_t		end;
;1051:	vec3_t		v;
;1052:
;1053:#ifdef MISSIONPACK
;1054:	vec3_t impactpoint, bouncedir;
;1055://freeze
;1056:#else
;1057://	vec3_t	impactpoint, bouncedir;
;1058://freeze
;1059:#endif
;1060:	trace_t		trace;//MonkK
;1061:	gentity_t	*tent;
;1062:	gentity_t	*traceEnt;
;1063:	float		dist, points;
;1064:	int			damage;
;1065:	int			i, j;
;1066:	int			hits;
;1067:	int			unlinked;
;1068:	int			passent;
;1069:	// mod code start
;1070:	int			RJFired = 0;
ADDRLP4 160
CNSTI4 0
ASGNI4
line 1072
;1071:	int			clientHitNum;
;1072:	int			noStatPenalty = 0;
ADDRLP4 164
CNSTI4 0
ASGNI4
line 1073
;1073:	int			hitNothing = 0;
ADDRLP4 152
CNSTI4 0
ASGNI4
line 1074
;1074:	int			shifted = 0;
ADDRLP4 168
CNSTI4 0
ASGNI4
line 1075
;1075:	int			numWalls = 0;
ADDRLP4 172
CNSTI4 0
ASGNI4
line 1081
;1076:	int			timeshift;
;1077:	// mod code end
;1078:	int			lastTraceIndex;
;1079:	gentity_t	*unlinkedEntities[MAX_RAIL_HITS];
;1080:	vec3_t		dir;//XX rj
;1081:	memcpy( dir, forward, sizeof(dir) );
ADDRLP4 128
ARGP4
ADDRGP4 forward
ARGP4
CNSTI4 12
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1083
;1082:
;1083:	++ent->client->pers.stats_shots[WP_RAILGUN];
ADDRLP4 180
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9884
ADDP4
ASGNP4
ADDRLP4 180
INDIRP4
ADDRLP4 180
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1085
;1084:
;1085:	damage = gameSettings.hitscans[GS_RAILGUN][GS_DAMAGE] * s_quadFactor;
ADDRLP4 112
ADDRGP4 gameSettings+104+32
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 1091
;1086:
;1087://unlagged - backward reconciliation #2
;1088:	// backward-reconcile the other clients
;1089:	//G_DoTimeShiftFor( ent );
;1090://unlagged - backward reconciliation #2
;1091:	VectorMA (muzzle, gameSettings.hitscans[GS_RAILGUN][GS_RANGE], forward, end);
ADDRLP4 92
ADDRGP4 muzzle
INDIRF4
ADDRGP4 forward
INDIRF4
ADDRGP4 gameSettings+104+32+4
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
ADDRLP4 92+4
ADDRGP4 muzzle+4
INDIRF4
ADDRGP4 forward+4
INDIRF4
ADDRGP4 gameSettings+104+32+4
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
ADDRLP4 92+8
ADDRGP4 muzzle+8
INDIRF4
ADDRGP4 forward+8
INDIRF4
ADDRGP4 gameSettings+104+32+4
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 1094
;1092:
;1093:	// trace only against the solids, so the railgun will go through people
;1094:	unlinked = hits = 0;
ADDRLP4 184
CNSTI4 0
ASGNI4
ADDRLP4 108
ADDRLP4 184
INDIRI4
ASGNI4
ADDRLP4 60
ADDRLP4 184
INDIRI4
ASGNI4
line 1095
;1095:	lastTraceIndex = -1;
ADDRLP4 176
CNSTI4 -1
ASGNI4
line 1096
;1096:	passent = ent->s.number;
ADDRLP4 104
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 1098
;1097:
;1098:	if (ent->client->frameAimType >= 2) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10388
ADDP4
INDIRI4
CNSTI4 2
LTI4 $438
line 1100
;1099:		//Don't waste time doing this for aimType 1 or 0
;1100:		clientHitNum = GetClientTarget(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 188
ADDRGP4 GetClientTarget
CALLI4
ASGNI4
ADDRLP4 140
ADDRLP4 188
INDIRI4
ASGNI4
line 1102
;1101:
;1102:		if ( g_allowObliterate.integer == 2 ) {
ADDRGP4 g_allowObliterate+12
INDIRI4
CNSTI4 2
NEI4 $440
line 1103
;1103:			trap_SendServerCommand(-1, va("print \"RailFired: %i - ToD: %i - Hit: %i\n\"",level.time, ent->timeOfDeath, clientHitNum ));
ADDRGP4 $443
ARGP4
ADDRGP4 level+40
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
ARGI4
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 192
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 192
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1104
;1104:		}
LABELV $440
line 1106
;1105:
;1106:		timeshift = ComputeNewTimeShift(ent, 0, clientHitNum);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 192
ADDRGP4 ComputeNewTimeShift
CALLI4
ASGNI4
ADDRLP4 144
ADDRLP4 192
INDIRI4
ASGNI4
line 1108
;1107:
;1108:		if ( timeshift == 0 ) {
ADDRLP4 144
INDIRI4
CNSTI4 0
NEI4 $445
line 1109
;1109:			hitNothing = 1;
ADDRLP4 152
CNSTI4 1
ASGNI4
line 1110
;1110:		}
LABELV $445
line 1111
;1111:		if (timeshift == -1 /*&& clientHitNum >= 0 && clientHitNum < 32*/) { // force kill
ADDRLP4 144
INDIRI4
CNSTI4 -1
NEI4 $447
line 1112
;1112:			i = clientHitNum;
ADDRLP4 68
ADDRLP4 140
INDIRI4
ASGNI4
line 1114
;1113:
;1114:			if ( g_entities[i].takedamage /*&& G_AllowEntityInteraction(ent, &g_entities[i])*/ ){
CNSTI4 896
ADDRLP4 68
INDIRI4
MULI4
ADDRGP4 g_entities+736
ADDP4
INDIRI4
CNSTI4 0
EQI4 $449
line 1115
;1115:				if ( LogAccuracyHit( &g_entities[i], ent ) ) {
CNSTI4 896
ADDRLP4 68
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 196
ADDRGP4 LogAccuracyHit
CALLI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 0
EQI4 $452
line 1116
;1116:					hits++;
ADDRLP4 108
ADDRLP4 108
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1117
;1117:				}
LABELV $452
line 1118
;1118:				G_Damage (&g_entities[i], ent, ent, forward, end, damage, 0, MOD_RAILGUN);
CNSTI4 896
ADDRLP4 68
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
INDIRP4
ARGP4
ADDRLP4 200
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 92
ARGP4
ADDRLP4 112
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 10
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 1121
;1119:						
;1120:				// unlink this entity, so the next trace will go past it
;1121:				trap_UnlinkEntity( &g_entities[i] );
CNSTI4 896
ADDRLP4 68
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 1122
;1122:				unlinkedEntities[unlinked] = &g_entities[i];
ADDRLP4 60
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 72
ADDP4
CNSTI4 896
ADDRLP4 68
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1123
;1123:				unlinked++;
ADDRLP4 60
ADDRLP4 60
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1124
;1124:			}
LABELV $449
line 1125
;1125:		}
LABELV $447
line 1126
;1126:	}
LABELV $438
line 1128
;1127:
;1128:	G_DoTimeShiftFor( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_DoTimeShiftFor
CALLV
pop
LABELV $454
line 1129
;1129:	do {
line 1130
;1130:		trap_Trace (&trace, muzzle, NULL, NULL, end, passent, MASK_SHOT );
ADDRLP4 0
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRLP4 188
CNSTP4 0
ASGNP4
ADDRLP4 188
INDIRP4
ARGP4
ADDRLP4 188
INDIRP4
ARGP4
ADDRLP4 92
ARGP4
ADDRLP4 104
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1132
;1131:
;1132:		if ( trace.entityNum >= ENTITYNUM_MAX_NORMAL ) {
ADDRLP4 0+52
INDIRI4
CNSTI4 1022
LTI4 $457
line 1133
;1133:			break;
ADDRGP4 $456
JUMPV
LABELV $457
line 1136
;1134:		}
;1135:
;1136:		traceEnt = &g_entities[ trace.entityNum ];
ADDRLP4 56
CNSTI4 896
ADDRLP4 0+52
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1138
;1137:		
;1138:		if ( traceEnt->takedamage ) {
ADDRLP4 56
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
EQI4 $461
line 1168
;1139:
;1140:#ifdef MISSIONPACK
;1141:			if ( traceEnt->client && traceEnt->client->invulnerabilityTime > level.time ) {
;1142:				if ( G_InvulnerabilityEffect( traceEnt, forward, trace.endpos, impactpoint, bouncedir ) ) {
;1143:					G_BounceProjectile( muzzle, impactpoint, bouncedir, end );
;1144:					// snap the endpos to integers to save net bandwidth, but nudged towards the line
;1145:					SnapVectorTowards( trace.endpos, muzzle );
;1146:					// send railgun beam effect
;1147:					tent = G_TempEntity( trace.endpos, EV_RAILTRAIL );
;1148:					// set player number for custom colors on the railtrail
;1149:					tent->s.clientNum = ent->s.clientNum;
;1150:					VectorCopy( muzzle, tent->s.origin2 );
;1151:					// move origin a bit to come closer to the drawn gun muzzle
;1152:					VectorMA( tent->s.origin2, 4, right, tent->s.origin2 );
;1153:					VectorMA( tent->s.origin2, -1, up, tent->s.origin2 );
;1154:					tent->s.eventParm = 255;	// don't make the explosion at the end
;1155:					//
;1156:					VectorCopy( impactpoint, muzzle );
;1157:					// the player can hit him/herself with the bounced rail
;1158:					passent = ENTITYNUM_NONE;
;1159:				}
;1160:			}
;1161:			else {
;1162:				if( LogAccuracyHit( traceEnt, ent ) ) {
;1163:					hits++;
;1164:				}
;1165:				G_Damage (traceEnt, ent, ent, forward, trace.endpos, damage, 0, MOD_RAILGUN);
;1166:			}
;1167:#else	
;1168:				if( LogAccuracyHit( traceEnt, ent ) ) {
ADDRLP4 56
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 192
ADDRGP4 LogAccuracyHit
CALLI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 0
EQI4 $463
line 1169
;1169:					hits++;
ADDRLP4 108
ADDRLP4 108
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1170
;1170:				}
LABELV $463
line 1171
;1171:				G_Damage (traceEnt, ent, ent, forward, trace.endpos, damage, 0, MOD_RAILGUN);		
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 196
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 196
INDIRP4
ARGP4
ADDRLP4 196
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 0+12
ARGP4
ADDRLP4 112
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 10
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 1173
;1172:#endif	
;1173:		}
LABELV $461
line 1175
;1174:
;1175:		if ( trace.contents & CONTENTS_SOLID ) {
ADDRLP4 0+48
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $466
line 1176
;1176:			break;		// we hit something solid enough to stop the beam
ADDRGP4 $456
JUMPV
LABELV $466
line 1180
;1177:		}
;1178:
;1179:		// unlink this entity, so the next trace will go past it
;1180:		trap_UnlinkEntity( traceEnt );
ADDRLP4 56
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 1181
;1181:		unlinkedEntities[unlinked] = traceEnt;
ADDRLP4 60
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 72
ADDP4
ADDRLP4 56
INDIRP4
ASGNP4
line 1182
;1182:		unlinked++;
ADDRLP4 60
ADDRLP4 60
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1184
;1183:		
;1184:	} while ( unlinked < MAX_RAIL_HITS );
LABELV $455
ADDRLP4 60
INDIRI4
CNSTI4 4
LTI4 $454
LABELV $456
line 1185
;1185:	G_UndoTimeShiftFor( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_UndoTimeShiftFor
CALLV
pop
line 1188
;1186:
;1187:	// link back in any entities we unlinked
;1188:	for ( i = 0 ; i < unlinked ; i++ ) {
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRGP4 $472
JUMPV
LABELV $469
line 1189
;1189:		trap_LinkEntity( unlinkedEntities[i] );
ADDRLP4 68
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 72
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 1190
;1190:	}
LABELV $470
line 1188
ADDRLP4 68
ADDRLP4 68
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $472
ADDRLP4 68
INDIRI4
ADDRLP4 60
INDIRI4
LTI4 $469
line 1193
;1191:
;1192:	//Do stats
;1193:	ent->client->pers.stats_hits[WP_RAILGUN] += hits;
ADDRLP4 188
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9928
ADDP4
ASGNP4
ADDRLP4 188
INDIRP4
ADDRLP4 188
INDIRP4
INDIRI4
ADDRLP4 108
INDIRI4
ADDI4
ASGNI4
line 1194
;1194:	ent->client->pers.stats_damage[WP_RAILGUN] += (hits * damage);
ADDRLP4 192
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9976
ADDP4
ASGNP4
ADDRLP4 192
INDIRP4
ADDRLP4 192
INDIRP4
INDIRI4
ADDRLP4 108
INDIRI4
ADDRLP4 112
INDIRI4
MULI4
ADDI4
ASGNI4
line 1195
;1195:	ent->client->pers.stats_totaldamage += (hits * damage);
ADDRLP4 196
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9944
ADDP4
ASGNP4
ADDRLP4 196
INDIRP4
ADDRLP4 196
INDIRP4
INDIRI4
ADDRLP4 108
INDIRI4
ADDRLP4 112
INDIRI4
MULI4
ADDI4
ASGNI4
line 1200
;1196:
;1197:	// the final trace endpos will be the terminal point of the rail trail
;1198:
;1199:	// snap the endpos to integers to save net bandwidth, but nudged towards the line
;1200:	SnapVectorTowards( trace.endpos, muzzle );
ADDRLP4 0+12
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 SnapVectorTowards
CALLV
pop
line 1203
;1201:
;1202:	// send railgun beam effect
;1203:	tent = G_TempEntity( trace.endpos, EV_RAILTRAIL );
ADDRLP4 0+12
ARGP4
CNSTI4 53
ARGI4
ADDRLP4 200
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 88
ADDRLP4 200
INDIRP4
ASGNP4
line 1206
;1204:
;1205:	// set player number for custom colors on the railtrail
;1206:	tent->s.clientNum = ent->s.clientNum;
ADDRLP4 204
CNSTI4 168
ASGNI4
ADDRLP4 88
INDIRP4
ADDRLP4 204
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 204
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 1208
;1207:
;1208:	VectorCopy( muzzle, tent->s.origin2 );
ADDRLP4 88
INDIRP4
CNSTI4 104
ADDP4
ADDRGP4 muzzle
INDIRB
ASGNB 12
line 1210
;1209:	// move origin a bit to come closer to the drawn gun muzzle
;1210:	VectorMA( tent->s.origin2, 4, right, tent->s.origin2 );
ADDRLP4 208
ADDRLP4 88
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 208
INDIRP4
ADDRLP4 208
INDIRP4
INDIRF4
CNSTF4 1082130432
ADDRGP4 right
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 212
ADDRLP4 88
INDIRP4
CNSTI4 108
ADDP4
ASGNP4
ADDRLP4 212
INDIRP4
ADDRLP4 212
INDIRP4
INDIRF4
CNSTF4 1082130432
ADDRGP4 right+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 216
ADDRLP4 88
INDIRP4
CNSTI4 112
ADDP4
ASGNP4
ADDRLP4 216
INDIRP4
ADDRLP4 216
INDIRP4
INDIRF4
CNSTF4 1082130432
ADDRGP4 right+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1211
;1211:	VectorMA( tent->s.origin2, -1, up, tent->s.origin2 );
ADDRLP4 220
ADDRLP4 88
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 220
INDIRP4
ADDRLP4 220
INDIRP4
INDIRF4
CNSTF4 3212836864
ADDRGP4 up
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 224
ADDRLP4 88
INDIRP4
CNSTI4 108
ADDP4
ASGNP4
ADDRLP4 224
INDIRP4
ADDRLP4 224
INDIRP4
INDIRF4
CNSTF4 3212836864
ADDRGP4 up+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 228
ADDRLP4 88
INDIRP4
CNSTI4 112
ADDP4
ASGNP4
ADDRLP4 228
INDIRP4
ADDRLP4 228
INDIRP4
INDIRF4
CNSTF4 3212836864
ADDRGP4 up+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1214
;1212:
;1213:	// no explosion at end if SURF_NOIMPACT, but still make the trail
;1214:	if ( trace.surfaceFlags & SURF_NOIMPACT ) {
ADDRLP4 0+44
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $479
line 1215
;1215:		tent->s.eventParm = 255;	// don't make the explosion at the end
ADDRLP4 88
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 255
ASGNI4
line 1216
;1216:	} else {
ADDRGP4 $480
JUMPV
LABELV $479
line 1217
;1217:		tent->s.eventParm = DirToByte( trace.plane.normal );
ADDRLP4 0+24
ARGP4
ADDRLP4 232
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRLP4 88
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 232
INDIRI4
ASGNI4
line 1218
;1218:	}
LABELV $480
line 1219
;1219:	tent->s.clientNum = ent->s.clientNum;
ADDRLP4 232
CNSTI4 168
ASGNI4
ADDRLP4 88
INDIRP4
ADDRLP4 232
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 232
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 1222
;1220:
;1221:	// give the shooter a reward sound if they have made two railgun hits in a row
;1222:	if ( hits == 0 ) {
ADDRLP4 108
INDIRI4
CNSTI4 0
NEI4 $483
line 1224
;1223:		// complete miss
;1224:		ent->client->accurateCount = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10308
ADDP4
CNSTI4 0
ASGNI4
line 1225
;1225:	} else {
ADDRGP4 $484
JUMPV
LABELV $483
line 1227
;1226:		// check for "impressive" reward sound
;1227:		ent->client->accurateCount += hits;
ADDRLP4 236
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10308
ADDP4
ASGNP4
ADDRLP4 236
INDIRP4
ADDRLP4 236
INDIRP4
INDIRI4
ADDRLP4 108
INDIRI4
ADDI4
ASGNI4
line 1228
;1228:		if ( ent->client->accurateCount >= 2 && 
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10308
ADDP4
INDIRI4
CNSTI4 2
LTI4 $485
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 1
EQI4 $485
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 5
EQI4 $485
line 1229
;1229:			!(g_gamemode.integer == 1 || g_gamemode.integer == 5) ) {
line 1230
;1230:			ent->client->accurateCount -= 2;
ADDRLP4 240
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10308
ADDP4
ASGNP4
ADDRLP4 240
INDIRP4
ADDRLP4 240
INDIRP4
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 1231
;1231:			ent->client->ps.persistant[PERS_IMPRESSIVE_COUNT]++;
ADDRLP4 244
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 284
ADDP4
ASGNP4
ADDRLP4 244
INDIRP4
ADDRLP4 244
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1233
;1232:			// add the sprite over the player's head
;1233:			ent->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 248
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 248
INDIRP4
ADDRLP4 248
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 1234
;1234:			ent->client->ps.eFlags |= EF_AWARD_IMPRESSIVE;
ADDRLP4 252
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 252
INDIRP4
ADDRLP4 252
INDIRP4
INDIRI4
CNSTI4 32768
BORI4
ASGNI4
line 1235
;1235:			ent->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10344
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 1236
;1236:		} else if ( ent->client->accurateCount >= 3 && 
ADDRGP4 $486
JUMPV
LABELV $485
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10308
ADDP4
INDIRI4
CNSTI4 3
LTI4 $490
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 1
EQI4 $494
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 5
NEI4 $490
LABELV $494
line 1237
;1237:			(g_gamemode.integer == 1 || g_gamemode.integer == 5) ) {
line 1240
;1238:				gentity_t	*tempEnt2;
;1239:				//FIXME: Evo: This probably needs to get broken to work with s_announcer
;1240:				tempEnt2 = G_TempEntity( ent->s.origin, EV_GLOBAL_SOUND );
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
CNSTI4 46
ARGI4
ADDRLP4 244
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 240
ADDRLP4 244
INDIRP4
ASGNP4
line 1241
;1241:				tempEnt2->s.eventParm = G_SoundIndex( "sound/feedback/accuracy.wav" );
ADDRGP4 $495
ARGP4
ADDRLP4 248
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRLP4 240
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 248
INDIRI4
ASGNI4
line 1242
;1242:				tempEnt2->r.svFlags |= SVF_BROADCAST;
ADDRLP4 252
ADDRLP4 240
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 252
INDIRP4
ADDRLP4 252
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 1244
;1243:
;1244:				ent->client->accurateCount = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10308
ADDP4
CNSTI4 0
ASGNI4
line 1245
;1245:				trap_SendServerCommand( -1, va("print \"%s" S_COLOR_CYAN " got an accuracy!\n\"", ent->client->pers.netname) );
ADDRGP4 $496
ARGP4
ADDRLP4 256
CNSTI4 516
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 256
INDIRI4
ADDP4
INDIRP4
ADDRLP4 256
INDIRI4
ADDP4
ARGP4
ADDRLP4 260
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 260
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1247
;1246:			//trap_SendServerCommand(-1, "play \"sound/feedback/accuracy.wav");
;1247:		}
LABELV $490
LABELV $486
line 1248
;1248:		ent->client->accuracy_hits++;
ADDRLP4 240
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10316
ADDP4
ASGNP4
ADDRLP4 240
INDIRP4
ADDRLP4 240
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1249
;1249:	}
LABELV $484
line 1251
;1250:	//Should we do this before determining who got killed?
;1251:	if ( g_RailJumping.integer >= 1 && g_RailjumpRadius.integer >= 1 ) {
ADDRLP4 236
CNSTI4 1
ASGNI4
ADDRGP4 g_RailJumping+12
INDIRI4
ADDRLP4 236
INDIRI4
LTI4 $497
ADDRGP4 g_RailjumpRadius+12
INDIRI4
ADDRLP4 236
INDIRI4
LTI4 $497
line 1252
;1252:		for ( j = 0 ; j < 3 ; j++ ) {
ADDRLP4 64
CNSTI4 0
ASGNI4
LABELV $501
line 1253
;1253:			if ( trace.endpos[j] < ent->r.absmin[j] ) {
ADDRLP4 240
ADDRLP4 64
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 240
INDIRI4
ADDRLP4 0+12
ADDP4
INDIRF4
ADDRLP4 240
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 464
ADDP4
ADDP4
INDIRF4
GEF4 $505
line 1254
;1254:				v[j] = ent->r.absmin[j] - trace.endpos[j];
ADDRLP4 244
ADDRLP4 64
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 244
INDIRI4
ADDRLP4 116
ADDP4
ADDRLP4 244
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 464
ADDP4
ADDP4
INDIRF4
ADDRLP4 244
INDIRI4
ADDRLP4 0+12
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1255
;1255:			} else if ( trace.endpos[j] > ent->r.absmax[j] ) {
ADDRGP4 $506
JUMPV
LABELV $505
ADDRLP4 244
ADDRLP4 64
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 244
INDIRI4
ADDRLP4 0+12
ADDP4
INDIRF4
ADDRLP4 244
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRF4
LEF4 $509
line 1256
;1256:				v[j] = trace.endpos[j] - ent->r.absmax[j];
ADDRLP4 248
ADDRLP4 64
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 248
INDIRI4
ADDRLP4 116
ADDP4
ADDRLP4 248
INDIRI4
ADDRLP4 0+12
ADDP4
INDIRF4
ADDRLP4 248
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1257
;1257:			} else {
ADDRGP4 $510
JUMPV
LABELV $509
line 1258
;1258:				v[j] = 0;
ADDRLP4 64
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 116
ADDP4
CNSTF4 0
ASGNF4
line 1259
;1259:			}
LABELV $510
LABELV $506
line 1260
;1260:		}
LABELV $502
line 1252
ADDRLP4 64
ADDRLP4 64
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 3
LTI4 $501
line 1262
;1261:
;1262:		dist = VectorLength( v );
ADDRLP4 116
ARGP4
ADDRLP4 240
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 148
ADDRLP4 240
INDIRF4
ASGNF4
line 1263
;1263:		if ( dist <= g_RailjumpRadius.integer ) {
ADDRLP4 148
INDIRF4
ADDRGP4 g_RailjumpRadius+12
INDIRI4
CVIF4 4
GTF4 $513
line 1264
;1264:			if ( hits == 0 ) {//only subtract from shots when we didn't hit anything :/
ADDRLP4 108
INDIRI4
CNSTI4 0
NEI4 $516
line 1265
;1265:				ent->client->pers.stats_shots[WP_RAILGUN]--;
ADDRLP4 244
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9884
ADDP4
ASGNP4
ADDRLP4 244
INDIRP4
ADDRLP4 244
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1266
;1266:			}
LABELV $516
line 1267
;1267:			++ent->client->pers.stats_railjumps;
ADDRLP4 244
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9992
ADDP4
ASGNP4
ADDRLP4 244
INDIRP4
ADDRLP4 244
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1269
;1268:
;1269:			if ( g_DynamicRailgunCycle.integer >= 1 ) {
ADDRGP4 g_DynamicRailgunCycle+12
INDIRI4
CNSTI4 1
LTI4 $518
line 1270
;1270:				ent->client->ps.weaponTime = g_DynamicRailgunCycle.integer;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 44
ADDP4
ADDRGP4 g_DynamicRailgunCycle+12
INDIRI4
ASGNI4
line 1271
;1271:			}
LABELV $518
line 1273
;1272:
;1273:			g_StaticKnockback.integer?(points = g_railgunKnockback.integer):(points = g_railgunKnockback.integer * ( 1.0 - dist / g_RailjumpRadius.integer ));
ADDRGP4 g_StaticKnockback+12
INDIRI4
CNSTI4 0
EQI4 $527
ADDRLP4 156
ADDRGP4 g_railgunKnockback+12
INDIRI4
CVIF4 4
ASGNF4
ADDRGP4 $528
JUMPV
LABELV $527
ADDRLP4 156
ADDRGP4 g_railgunKnockback+12
INDIRI4
CVIF4 4
CNSTF4 1065353216
ADDRLP4 148
INDIRF4
ADDRGP4 g_RailjumpRadius+12
INDIRI4
CVIF4 4
DIVF4
SUBF4
MULF4
ASGNF4
LABELV $528
line 1275
;1274:
;1275:			if (g_RailJumping.integer == 2 ) {//Monkk's railjumping code
ADDRGP4 g_RailJumping+12
INDIRI4
CNSTI4 2
NEI4 $529
line 1278
;1276:				vec3_t	kvel, inverseRailPath;
;1277:				float	mass;
;1278:				mass = 200;
ADDRLP4 272
CNSTF4 1128792064
ASGNF4
line 1280
;1279:
;1280:				VectorCopy(forward, inverseRailPath);
ADDRLP4 260
ADDRGP4 forward
INDIRB
ASGNB 12
line 1281
;1281:				if ( !g_fixMuzzleBug.integer ) {
ADDRGP4 g_fixMuzzleBug+12
INDIRI4
CNSTI4 0
NEI4 $532
line 1282
;1282:					VectorInverse(inverseRailPath);
ADDRLP4 260
ARGP4
ADDRGP4 VectorInverse
CALLV
pop
line 1283
;1283:				}
LABELV $532
line 1284
;1284:				VectorScale ( inverseRailPath, g_knockback.value * (points - 1) / mass, kvel);//Subract 1 for Quad's IU1.2 "feel"
ADDRLP4 276
ADDRLP4 156
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
ADDRLP4 280
ADDRLP4 272
INDIRF4
ASGNF4
ADDRLP4 248
ADDRLP4 260
INDIRF4
ADDRGP4 g_knockback+8
INDIRF4
ADDRLP4 276
INDIRF4
MULF4
ADDRLP4 280
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 248+4
ADDRLP4 260+4
INDIRF4
ADDRGP4 g_knockback+8
INDIRF4
ADDRLP4 276
INDIRF4
MULF4
ADDRLP4 280
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 248+8
ADDRLP4 260+8
INDIRF4
ADDRGP4 g_knockback+8
INDIRF4
ADDRLP4 156
INDIRF4
CNSTF4 1065353216
SUBF4
MULF4
ADDRLP4 272
INDIRF4
DIVF4
MULF4
ASGNF4
line 1285
;1285:				VectorAdd (ent->client->ps.velocity, kvel, ent->client->ps.velocity);
ADDRLP4 284
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 284
INDIRP4
ADDRLP4 284
INDIRP4
INDIRF4
ADDRLP4 248
INDIRF4
ADDF4
ASGNF4
ADDRLP4 288
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 288
INDIRP4
ADDRLP4 288
INDIRP4
INDIRF4
ADDRLP4 248+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 292
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 292
INDIRP4
ADDRLP4 292
INDIRP4
INDIRF4
ADDRLP4 248+8
INDIRF4
ADDF4
ASGNF4
line 1287
;1286:
;1287:				if ( !ent->client->ps.pm_time ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
NEI4 $530
line 1289
;1288:					int		t;
;1289:					t = (points - 1) * 2;//was knockback | Subract 1 for Quad's IU1.2 "feel"
ADDRLP4 296
CNSTF4 1073741824
ADDRLP4 156
INDIRF4
CNSTF4 1065353216
SUBF4
MULF4
CVFI4 4
ASGNI4
line 1291
;1290:
;1291:					if ( t < 50 ) {
ADDRLP4 296
INDIRI4
CNSTI4 50
GEI4 $546
line 1292
;1292:						t = 50;
ADDRLP4 296
CNSTI4 50
ASGNI4
line 1293
;1293:					}
LABELV $546
line 1294
;1294:					if ( t > 200 ) {
ADDRLP4 296
INDIRI4
CNSTI4 200
LEI4 $548
line 1295
;1295:						t = 200;
ADDRLP4 296
CNSTI4 200
ASGNI4
line 1296
;1296:					}
LABELV $548
line 1297
;1297:					ent->client->ps.pm_time = t;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 296
INDIRI4
ASGNI4
line 1298
;1298:					ent->client->ps.pm_flags |= PMF_TIME_KNOCKBACK;
ADDRLP4 300
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 300
INDIRP4
ADDRLP4 300
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 1299
;1299:				}
line 1300
;1300:			} else if ( g_RailJumping.integer == 3 || g_RailJumping.integer == 4 ) {//XoneXfer
ADDRGP4 $530
JUMPV
LABELV $529
ADDRGP4 g_RailJumping+12
INDIRI4
CNSTI4 3
EQI4 $554
ADDRGP4 g_RailJumping+12
INDIRI4
CNSTI4 4
NEI4 $550
LABELV $554
line 1306
;1301:				gentity_t	*bolt;//XX rj
;1302:				
;1303:				/* RailJump style 4 is possibly closer to IU than anything... */
;1304:				
;1305:
;1306:				bolt = G_Spawn();
ADDRLP4 252
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 248
ADDRLP4 252
INDIRP4
ASGNP4
line 1307
;1307:				bolt->classname = "rocket";
ADDRLP4 248
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $183
ASGNP4
line 1308
;1308:				bolt->nextthink = level.time + 2000;
ADDRLP4 248
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 1310
;1309:				//bolt->nextthink = level.time;//Think now <-- Evo did it.
;1310:				bolt->think = G_ExplodeMissile;
ADDRLP4 248
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 G_ExplodeMissile
ASGNP4
line 1313
;1311:				
;1312:				
;1313:				bolt->s.eType = ET_MISSILE;
ADDRLP4 248
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 3
ASGNI4
line 1314
;1314:				bolt->r.svFlags = SVF_USE_CURRENT_ORIGIN;
ADDRLP4 248
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 128
ASGNI4
line 1315
;1315:				bolt->r.svFlags = SVF_NOCLIENT;
ADDRLP4 248
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 1
ASGNI4
line 1316
;1316:				bolt->s.eFlags |= EF_NODRAW ;
ADDRLP4 256
ADDRLP4 248
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 256
INDIRP4
ADDRLP4 256
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 1317
;1317:				bolt->s.weapon = WP_ROCKET_LAUNCHER;
ADDRLP4 248
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 5
ASGNI4
line 1318
;1318:				bolt->r.ownerNum = ent->s.number;
ADDRLP4 248
INDIRP4
CNSTI4 512
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 1319
;1319:				bolt->parent = ent;
ADDRLP4 248
INDIRP4
CNSTI4 600
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 1320
;1320:				bolt->damage = g_railgunKnockback.integer;
ADDRLP4 248
INDIRP4
CNSTI4 740
ADDP4
ADDRGP4 g_railgunKnockback+12
INDIRI4
ASGNI4
line 1321
;1321:				bolt->splashDamage = g_railgunKnockback.integer;
ADDRLP4 248
INDIRP4
CNSTI4 744
ADDP4
ADDRGP4 g_railgunKnockback+12
INDIRI4
ASGNI4
line 1322
;1322:				bolt->splashRadius = g_RailjumpRadius.integer;//was 120
ADDRLP4 248
INDIRP4
CNSTI4 748
ADDP4
ADDRGP4 g_RailjumpRadius+12
INDIRI4
ASGNI4
line 1323
;1323:				bolt->methodOfDeath = MOD_XX_RAILJUMP;
ADDRLP4 248
INDIRP4
CNSTI4 752
ADDP4
CNSTI4 24
ASGNI4
line 1324
;1324:				bolt->splashMethodOfDeath = MOD_XX_RAILJUMP;
ADDRLP4 248
INDIRP4
CNSTI4 756
ADDP4
CNSTI4 24
ASGNI4
line 1325
;1325:				bolt->clipmask = MASK_SHOT;
ADDRLP4 248
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 100663297
ASGNI4
line 1326
;1326:				bolt->target_ent = NULL;
ADDRLP4 248
INDIRP4
CNSTI4 668
ADDP4
CNSTP4 0
ASGNP4
line 1328
;1327:				
;1328:				bolt->s.pos.trType = TR_LINEAR;
ADDRLP4 248
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 2
ASGNI4
line 1330
;1329:				//bolt->s.pos.trTime = level.time - 50;		// move a bit on the very first frame
;1330:				VectorCopy( muzzle, bolt->s.pos.trBase );
ADDRLP4 248
INDIRP4
CNSTI4 24
ADDP4
ADDRGP4 muzzle
INDIRB
ASGNB 12
line 1331
;1331:				VectorScale( dir, (g_RailJumping.integer == 3 ? (900) : (50000)), bolt->s.pos.trDelta );
ADDRGP4 g_RailJumping+12
INDIRI4
CNSTI4 3
NEI4 $567
ADDRLP4 260
CNSTI4 900
ASGNI4
ADDRGP4 $568
JUMPV
LABELV $567
ADDRLP4 260
CNSTI4 50000
ASGNI4
LABELV $568
ADDRLP4 248
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 128
INDIRF4
ADDRLP4 260
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRGP4 g_RailJumping+12
INDIRI4
CNSTI4 3
NEI4 $569
ADDRLP4 264
CNSTI4 900
ASGNI4
ADDRGP4 $570
JUMPV
LABELV $569
ADDRLP4 264
CNSTI4 50000
ASGNI4
LABELV $570
ADDRLP4 248
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 128+4
INDIRF4
ADDRLP4 264
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRGP4 g_RailJumping+12
INDIRI4
CNSTI4 3
NEI4 $571
ADDRLP4 268
CNSTI4 900
ASGNI4
ADDRGP4 $572
JUMPV
LABELV $571
ADDRLP4 268
CNSTI4 50000
ASGNI4
LABELV $572
ADDRLP4 248
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 128+8
INDIRF4
ADDRLP4 268
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 1332
;1332:				SnapVector( bolt->s.pos.trDelta );			// save net bandwidth
ADDRLP4 272
ADDRLP4 248
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 272
INDIRP4
ADDRLP4 272
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 276
ADDRLP4 248
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 276
INDIRP4
ADDRLP4 276
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 280
ADDRLP4 248
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 280
INDIRP4
ADDRLP4 280
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 1333
;1333:				VectorCopy (muzzle, bolt->r.currentOrigin);
ADDRLP4 248
INDIRP4
CNSTI4 488
ADDP4
ADDRGP4 muzzle
INDIRB
ASGNB 12
line 1335
;1334:				
;1335:				VectorSet(bolt->r.mins, 0, 0, 0);
ADDRLP4 248
INDIRP4
CNSTI4 436
ADDP4
CNSTF4 0
ASGNF4
ADDRLP4 248
INDIRP4
CNSTI4 440
ADDP4
CNSTF4 0
ASGNF4
ADDRLP4 248
INDIRP4
CNSTI4 444
ADDP4
CNSTF4 0
ASGNF4
line 1336
;1336:				VectorCopy(bolt->r.mins, bolt->r.absmin);
ADDRLP4 272
ADDRLP4 248
INDIRP4
ASGNP4
ADDRLP4 272
INDIRP4
CNSTI4 464
ADDP4
ADDRLP4 272
INDIRP4
CNSTI4 436
ADDP4
INDIRB
ASGNB 12
line 1337
;1337:				VectorSet(bolt->r.maxs, 0, 0, 0);
ADDRLP4 248
INDIRP4
CNSTI4 448
ADDP4
CNSTF4 0
ASGNF4
ADDRLP4 248
INDIRP4
CNSTI4 452
ADDP4
CNSTF4 0
ASGNF4
ADDRLP4 248
INDIRP4
CNSTI4 456
ADDP4
CNSTF4 0
ASGNF4
line 1338
;1338:				VectorCopy(bolt->r.maxs, bolt->r.absmax);
ADDRLP4 276
ADDRLP4 248
INDIRP4
ASGNP4
ADDRLP4 276
INDIRP4
CNSTI4 476
ADDP4
ADDRLP4 276
INDIRP4
CNSTI4 448
ADDP4
INDIRB
ASGNB 12
line 1339
;1339:			} else {//Revolution
ADDRGP4 $551
JUMPV
LABELV $550
line 1343
;1340:				//New
;1341:				vec3_t	kvel;
;1342:				float	mass;
;1343:				mass = 200;
ADDRLP4 260
CNSTF4 1128792064
ASGNF4
line 1345
;1344:
;1345:				VectorSubtract (ent->r.currentOrigin, muzzle, end);
ADDRLP4 264
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
ADDRLP4 264
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRGP4 muzzle
INDIRF4
SUBF4
ASGNF4
ADDRLP4 92+4
ADDRLP4 264
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRGP4 muzzle+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 92+8
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRGP4 muzzle+8
INDIRF4
SUBF4
ASGNF4
line 1348
;1346:				// push the center of mass higher than the origin so players
;1347:				// get knocked into the air more
;1348:				end[2] += 26;
ADDRLP4 92+8
ADDRLP4 92+8
INDIRF4
CNSTF4 1104150528
ADDF4
ASGNF4
line 1350
;1349:
;1350:				VectorNormalize(end);
ADDRLP4 92
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 1351
;1351:				VectorScale ( end, g_knockback.value * points / mass, kvel);
ADDRLP4 268
ADDRLP4 156
INDIRF4
ASGNF4
ADDRLP4 272
ADDRLP4 260
INDIRF4
ASGNF4
ADDRLP4 248
ADDRLP4 92
INDIRF4
ADDRGP4 g_knockback+8
INDIRF4
ADDRLP4 268
INDIRF4
MULF4
ADDRLP4 272
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 248+4
ADDRLP4 92+4
INDIRF4
ADDRGP4 g_knockback+8
INDIRF4
ADDRLP4 268
INDIRF4
MULF4
ADDRLP4 272
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 248+8
ADDRLP4 92+8
INDIRF4
ADDRGP4 g_knockback+8
INDIRF4
ADDRLP4 156
INDIRF4
MULF4
ADDRLP4 260
INDIRF4
DIVF4
MULF4
ASGNF4
line 1352
;1352:				VectorAdd (ent->client->ps.velocity, kvel, ent->client->ps.velocity);
ADDRLP4 276
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 276
INDIRP4
ADDRLP4 276
INDIRP4
INDIRF4
ADDRLP4 248
INDIRF4
ADDF4
ASGNF4
ADDRLP4 280
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 280
INDIRP4
ADDRLP4 280
INDIRP4
INDIRF4
ADDRLP4 248+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 284
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 284
INDIRP4
ADDRLP4 284
INDIRP4
INDIRF4
ADDRLP4 248+8
INDIRF4
ADDF4
ASGNF4
line 1354
;1353:
;1354:				if ( !ent->client->ps.pm_time ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
NEI4 $587
line 1356
;1355:					int		t;
;1356:					t = points * 2;
ADDRLP4 288
CNSTF4 1073741824
ADDRLP4 156
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 1358
;1357:
;1358:					if ( t < 50 ) {
ADDRLP4 288
INDIRI4
CNSTI4 50
GEI4 $589
line 1359
;1359:						t = 50;
ADDRLP4 288
CNSTI4 50
ASGNI4
line 1360
;1360:					}
LABELV $589
line 1361
;1361:					if ( t > 200 ) {
ADDRLP4 288
INDIRI4
CNSTI4 200
LEI4 $591
line 1362
;1362:						t = 200;
ADDRLP4 288
CNSTI4 200
ASGNI4
line 1363
;1363:					}
LABELV $591
line 1364
;1364:					ent->client->ps.pm_time = t;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 288
INDIRI4
ASGNI4
line 1365
;1365:					ent->client->ps.pm_flags |= PMF_TIME_KNOCKBACK;
ADDRLP4 292
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 292
INDIRP4
ADDRLP4 292
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 1366
;1366:				}
LABELV $587
line 1367
;1367:			}
LABELV $551
LABELV $530
line 1368
;1368:		}
LABELV $513
line 1369
;1369:	}
LABELV $497
line 1370
;1370:}
LABELV $420
endproc weapon_railgun_fire 304 32
export Weapon_GrapplingHook_Fire
proc Weapon_GrapplingHook_Fire 4 12
line 1382
;1371:
;1372:
;1373:/*
;1374:======================================================================
;1375:
;1376:GRAPPLING HOOK
;1377:
;1378:======================================================================
;1379:*/
;1380:
;1381:void Weapon_GrapplingHook_Fire (gentity_t *ent)
;1382:{
line 1387
;1383://freeze
;1384://	AngleVectors( ent->client->ps.viewangles, forward, right, up );
;1385://	CalcMuzzlePoint( ent, forward, right, up, muzzle );
;1386://freeze
;1387:	if (!ent->client->fireHeld && !ent->client->hook)
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 10360
ADDP4
INDIRI4
CNSTI4 0
NEI4 $594
ADDRLP4 0
INDIRP4
CNSTI4 10364
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $594
line 1388
;1388:		fire_grapple (ent, muzzle, forward);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 forward
ARGP4
ADDRGP4 fire_grapple
CALLP4
pop
LABELV $594
line 1390
;1389:
;1390:	ent->client->fireHeld = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10360
ADDP4
CNSTI4 1
ASGNI4
line 1391
;1391:}
LABELV $593
endproc Weapon_GrapplingHook_Fire 4 12
export Weapon_HookFree
proc Weapon_HookFree 4 4
line 1394
;1392:
;1393:void Weapon_HookFree (gentity_t *ent)
;1394:{
line 1398
;1395://freeze
;1396:	//ent->parent->timestamp = level.time;
;1397://freeze
;1398:	ent->parent->client->hook = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 600
ADDP4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10364
ADDP4
CNSTP4 0
ASGNP4
line 1399
;1399:	ent->parent->client->ps.pm_flags &= ~PMF_GRAPPLE_PULL;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 600
ADDP4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
line 1400
;1400:	G_FreeEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 1401
;1401:}
LABELV $596
endproc Weapon_HookFree 4 4
export Weapon_HookThink
proc Weapon_HookThink 36 8
line 1404
;1402:
;1403:void Weapon_HookThink (gentity_t *ent)
;1404:{
line 1405
;1405:	if (ent->enemy) {
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $598
line 1408
;1406:		vec3_t v, oldorigin;
;1407:
;1408:		VectorCopy(ent->r.currentOrigin, oldorigin);
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 1409
;1409:		v[0] = ent->enemy->r.currentOrigin[0] + (ent->enemy->r.mins[0] + ent->enemy->r.maxs[0]) * 0.5;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
CNSTF4 1056964608
ADDRLP4 24
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 448
ADDP4
INDIRF4
ADDF4
MULF4
ADDF4
ASGNF4
line 1410
;1410:		v[1] = ent->enemy->r.currentOrigin[1] + (ent->enemy->r.mins[1] + ent->enemy->r.maxs[1]) * 0.5;
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
ASGNP4
ADDRLP4 0+4
ADDRLP4 28
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
CNSTF4 1056964608
ADDRLP4 28
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
ADDF4
MULF4
ADDF4
ASGNF4
line 1411
;1411:		v[2] = ent->enemy->r.currentOrigin[2] + (ent->enemy->r.mins[2] + ent->enemy->r.maxs[2]) * 0.5;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 32
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
CNSTF4 1056964608
ADDRLP4 32
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
ADDF4
MULF4
ADDF4
ASGNF4
line 1412
;1412:		SnapVectorTowards( v, oldorigin );	// save net bandwidth
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 SnapVectorTowards
CALLV
pop
line 1414
;1413:
;1414:		G_SetOrigin( ent, v );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 1415
;1415:	}
LABELV $598
line 1417
;1416:
;1417:	VectorCopy( ent->r.currentOrigin, ent->parent->client->ps.grapplePoint);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 600
ADDP4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 1418
;1418:}
LABELV $597
endproc Weapon_HookThink 36 8
export Weapon_LightningFire
proc Weapon_LightningFire 144 32
line 1428
;1419:
;1420:/*
;1421:======================================================================
;1422:
;1423:LIGHTNING GUN
;1424:
;1425:======================================================================
;1426:*/
;1427:
;1428:void Weapon_LightningFire( gentity_t *ent ) {
line 1436
;1429:	trace_t		tr;
;1430:	vec3_t		end;
;1431:#ifdef MISSIONPACK
;1432:	vec3_t impactpoint, bouncedir;
;1433:#endif
;1434:	gentity_t	*traceEnt, *tent;
;1435:	int			damage, i, passent;
;1436:	int			unlinked = 0;
ADDRLP4 100
CNSTI4 0
ASGNI4
line 1440
;1437://	gentity_t	*unlinkedEntities[10];
;1438:	
;1439:	// mod code start
;1440:	int			hitNothing = 0;
ADDRLP4 96
CNSTI4 0
ASGNI4
line 1441
;1441:	int			timeshift = 0;
ADDRLP4 88
CNSTI4 0
ASGNI4
line 1442
;1442:	int			clientHitNum = 0;
ADDRLP4 92
CNSTI4 0
ASGNI4
line 1443
;1443:	int			shifted = 0;
ADDRLP4 104
CNSTI4 0
ASGNI4
line 1446
;1444:
;1445:	
;1446:	++ent->client->pers.stats_shots[WP_LIGHTNING];
ADDRLP4 108
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9880
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1449
;1447://unlagged - server options
;1448:	// this is configurable now
;1449:	damage = gameSettings.hitscans[GS_LIGHTNING][GS_DAMAGE] * s_quadFactor;
ADDRLP4 80
ADDRGP4 gameSettings+104+24
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 1452
;1450:
;1451:
;1452:	if (ent->client->frameAimType >= 2 ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10388
ADDP4
INDIRI4
CNSTI4 2
LTI4 $605
line 1453
;1453:		clientHitNum = GetClientTarget(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 112
ADDRGP4 GetClientTarget
CALLI4
ASGNI4
ADDRLP4 92
ADDRLP4 112
INDIRI4
ASGNI4
line 1454
;1454:		timeshift = ComputeNewTimeShift(ent, gameSettings.hitscans[GS_LIGHTNING][GS_RANGE], clientHitNum);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 gameSettings+104+24+4
INDIRI4
ARGI4
ADDRLP4 92
INDIRI4
ARGI4
ADDRLP4 116
ADDRGP4 ComputeNewTimeShift
CALLI4
ASGNI4
ADDRLP4 88
ADDRLP4 116
INDIRI4
ASGNI4
line 1456
;1455:
;1456:		if ( timeshift == 0 ) {
ADDRLP4 88
INDIRI4
CNSTI4 0
NEI4 $610
line 1457
;1457:			hitNothing = 1;
ADDRLP4 96
CNSTI4 1
ASGNI4
line 1458
;1458:		}
LABELV $610
line 1460
;1459:
;1460:		if (timeshift == -1 || timeshift == 1) {
ADDRLP4 88
INDIRI4
CNSTI4 -1
EQI4 $614
ADDRLP4 88
INDIRI4
CNSTI4 1
NEI4 $612
LABELV $614
line 1461
;1461:			if( LogAccuracyHit( &g_entities[clientHitNum], ent ) ) {
CNSTI4 896
ADDRLP4 92
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 124
ADDRGP4 LogAccuracyHit
CALLI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 0
EQI4 $615
line 1462
;1462:				ent->client->accuracy_hits++;
ADDRLP4 128
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10316
ADDP4
ASGNP4
ADDRLP4 128
INDIRP4
ADDRLP4 128
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1463
;1463:				++ent->client->pers.stats_hits[WP_LIGHTNING];
ADDRLP4 132
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9924
ADDP4
ASGNP4
ADDRLP4 132
INDIRP4
ADDRLP4 132
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1464
;1464:				ent->client->pers.stats_damage[WP_LIGHTNING] += damage;
ADDRLP4 136
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9972
ADDP4
ASGNP4
ADDRLP4 136
INDIRP4
ADDRLP4 136
INDIRP4
INDIRI4
ADDRLP4 80
INDIRI4
ADDI4
ASGNI4
line 1465
;1465:				ent->client->pers.stats_totaldamage += damage;
ADDRLP4 140
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9944
ADDP4
ASGNP4
ADDRLP4 140
INDIRP4
ADDRLP4 140
INDIRP4
INDIRI4
ADDRLP4 80
INDIRI4
ADDI4
ASGNI4
line 1466
;1466:			}
LABELV $615
line 1467
;1467:			G_Damage (&g_entities[clientHitNum], ent, ent, forward, end, damage, 0, MOD_LIGHTNING);
CNSTI4 896
ADDRLP4 92
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 128
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 60
ARGP4
ADDRLP4 80
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 11
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 1468
;1468:			return;
ADDRGP4 $602
JUMPV
LABELV $612
line 1470
;1469:		}
;1470:	}
LABELV $605
line 1475
;1471:	// mod code end
;1472:
;1473://unlagged - server options
;1474:
;1475:	passent = ent->s.number;
ADDRLP4 84
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 1476
;1476:	for (i = 0; i < 10; i++) {
ADDRLP4 76
CNSTI4 0
ASGNI4
LABELV $617
line 1477
;1477:		VectorMA( muzzle, gameSettings.hitscans[GS_LIGHTNING][GS_RANGE], forward, end );
ADDRLP4 60
ADDRGP4 muzzle
INDIRF4
ADDRGP4 forward
INDIRF4
ADDRGP4 gameSettings+104+24+4
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
ADDRLP4 60+4
ADDRGP4 muzzle+4
INDIRF4
ADDRGP4 forward+4
INDIRF4
ADDRGP4 gameSettings+104+24+4
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
ADDRLP4 60+8
ADDRGP4 muzzle+8
INDIRF4
ADDRGP4 forward+8
INDIRF4
ADDRGP4 gameSettings+104+24+4
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 1481
;1478:
;1479://unlagged - backward reconciliation #2
;1480:	// backward-reconcile the other clients
;1481:	G_DoTimeShiftFor( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_DoTimeShiftFor
CALLV
pop
line 1484
;1482://unlagged - backward reconciliation #2
;1483:
;1484:		trap_Trace (&tr, muzzle, NULL, NULL, end, passent, MASK_SHOT);
ADDRLP4 4
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRLP4 112
CNSTP4 0
ASGNP4
ADDRLP4 112
INDIRP4
ARGP4
ADDRLP4 112
INDIRP4
ARGP4
ADDRLP4 60
ARGP4
ADDRLP4 84
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1488
;1485:
;1486://unlagged - backward reconciliation #2
;1487:	// put them back
;1488:	G_UndoTimeShiftFor( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_UndoTimeShiftFor
CALLV
pop
line 1504
;1489://unlagged - backward reconciliation #2
;1490:
;1491:#ifdef MISSIONPACK
;1492:		// if not the first trace (the lightning bounced of an invulnerability sphere)
;1493:		if (i) {
;1494:			// add bounced off lightning bolt temp entity
;1495:			// the first lightning bolt is a cgame only visual
;1496:			//
;1497:			tent = G_TempEntity( muzzle, EV_LIGHTNINGBOLT );
;1498:			tent->s.clientNum = ent->s.number;
;1499:			VectorCopy( tr.endpos, end );
;1500:			SnapVector( end );
;1501:			VectorCopy( end, tent->s.origin2 );
;1502:		}
;1503:#endif
;1504:		if ( tr.entityNum == ENTITYNUM_NONE ) {
ADDRLP4 4+52
INDIRI4
CNSTI4 1023
NEI4 $636
line 1505
;1505:			return;
ADDRGP4 $602
JUMPV
LABELV $636
line 1508
;1506:		}
;1507:
;1508:		traceEnt = &g_entities[ tr.entityNum ];
ADDRLP4 0
CNSTI4 896
ADDRLP4 4+52
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1510
;1509:
;1510:		if ( traceEnt->takedamage /*&& G_AllowEntityInteraction(ent, traceEnt)*/ ) {
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
EQI4 $640
line 1532
;1511:#ifdef MISSIONPACK
;1512:			if ( traceEnt->client && traceEnt->client->invulnerabilityTime > level.time ) {
;1513:				if (G_InvulnerabilityEffect( traceEnt, forward, tr.endpos, impactpoint, bouncedir )) {
;1514:					G_BounceProjectile( muzzle, impactpoint, bouncedir, end );
;1515:					VectorCopy( impactpoint, muzzle );
;1516:					VectorSubtract( end, impactpoint, forward );
;1517:					VectorNormalize(forward);
;1518:					// the player can hit him/herself with the bounced lightning
;1519:					passent = ENTITYNUM_NONE;
;1520:				}
;1521:				else {
;1522:					VectorCopy( tr.endpos, muzzle );
;1523:					passent = traceEnt->s.number;
;1524:				}
;1525:				continue;
;1526:			}
;1527:			else {
;1528:				G_Damage( traceEnt, ent, ent, forward, tr.endpos,
;1529:					damage, 0, MOD_LIGHTNING);
;1530:			}
;1531:#else
;1532:			if ( traceEnt->client ) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $642
line 1533
;1533:				++ent->client->pers.stats_hits[WP_LIGHTNING];
ADDRLP4 116
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9924
ADDP4
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 116
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1534
;1534:				ent->client->pers.stats_damage[WP_LIGHTNING] += damage;
ADDRLP4 120
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9972
ADDP4
ASGNP4
ADDRLP4 120
INDIRP4
ADDRLP4 120
INDIRP4
INDIRI4
ADDRLP4 80
INDIRI4
ADDI4
ASGNI4
line 1535
;1535:				ent->client->pers.stats_totaldamage += damage;
ADDRLP4 124
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 9944
ADDP4
ASGNP4
ADDRLP4 124
INDIRP4
ADDRLP4 124
INDIRP4
INDIRI4
ADDRLP4 80
INDIRI4
ADDI4
ASGNI4
line 1536
;1536:			}
LABELV $642
line 1537
;1537:				G_Damage( traceEnt, ent, ent, forward, tr.endpos,
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 116
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 116
INDIRP4
ARGP4
ADDRLP4 116
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 4+12
ARGP4
ADDRLP4 80
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 11
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 1540
;1538:					damage, 0, MOD_LIGHTNING);
;1539:#endif
;1540:		}
LABELV $640
line 1542
;1541:
;1542:		if ( traceEnt->takedamage && traceEnt->client ) {
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
EQI4 $645
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $645
line 1543
;1543:			tent = G_TempEntity( tr.endpos, EV_MISSILE_HIT );
ADDRLP4 4+12
ARGP4
CNSTI4 50
ARGI4
ADDRLP4 120
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 72
ADDRLP4 120
INDIRP4
ASGNP4
line 1544
;1544:			tent->s.otherEntityNum = traceEnt->s.number;
ADDRLP4 72
INDIRP4
CNSTI4 140
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 1545
;1545:			tent->s.eventParm = DirToByte( tr.plane.normal );
ADDRLP4 4+24
ARGP4
ADDRLP4 124
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRLP4 72
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 124
INDIRI4
ASGNI4
line 1546
;1546:			tent->s.weapon = ent->s.weapon;
ADDRLP4 128
CNSTI4 192
ASGNI4
ADDRLP4 72
INDIRP4
ADDRLP4 128
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 128
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 1547
;1547:			if( LogAccuracyHit( traceEnt, ent ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 132
ADDRGP4 LogAccuracyHit
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 0
EQI4 $619
line 1548
;1548:				ent->client->accuracy_hits++;
ADDRLP4 136
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10316
ADDP4
ASGNP4
ADDRLP4 136
INDIRP4
ADDRLP4 136
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1549
;1549:			}
line 1551
;1550://freeze
;1551:		} else if ( g_gamemode.integer > 3 && is_body( traceEnt ) ) {
ADDRGP4 $619
JUMPV
LABELV $645
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $651
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 120
ADDRGP4 is_body
CALLI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 0
EQI4 $651
line 1552
;1552:			tent = G_TempEntity( tr.endpos, EV_MISSILE_HIT );
ADDRLP4 4+12
ARGP4
CNSTI4 50
ARGI4
ADDRLP4 124
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 72
ADDRLP4 124
INDIRP4
ASGNP4
line 1553
;1553:			tent->s.otherEntityNum = traceEnt->s.number;
ADDRLP4 72
INDIRP4
CNSTI4 140
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 1554
;1554:			tent->s.eventParm = DirToByte( tr.plane.normal );
ADDRLP4 4+24
ARGP4
ADDRLP4 128
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRLP4 72
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 128
INDIRI4
ASGNI4
line 1555
;1555:			tent->s.weapon = ent->s.weapon;
ADDRLP4 132
CNSTI4 192
ASGNI4
ADDRLP4 72
INDIRP4
ADDRLP4 132
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 132
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 1557
;1556://freeze
;1557:		} else if ( !( tr.surfaceFlags & SURF_NOIMPACT ) ) {
ADDRGP4 $619
JUMPV
LABELV $651
ADDRLP4 4+44
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $619
line 1558
;1558:			tent = G_TempEntity( tr.endpos, EV_MISSILE_MISS );
ADDRLP4 4+12
ARGP4
CNSTI4 51
ARGI4
ADDRLP4 124
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 72
ADDRLP4 124
INDIRP4
ASGNP4
line 1559
;1559:			tent->s.eventParm = DirToByte( tr.plane.normal );
ADDRLP4 4+24
ARGP4
ADDRLP4 128
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRLP4 72
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 128
INDIRI4
ASGNI4
line 1560
;1560:		}
line 1562
;1561:
;1562:		break;
ADDRGP4 $619
JUMPV
LABELV $618
line 1476
ADDRLP4 76
ADDRLP4 76
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 10
LTI4 $617
LABELV $619
line 1564
;1563:	}
;1564:}
LABELV $602
endproc Weapon_LightningFire 144 32
export LogAccuracyHit
proc LogAccuracyHit 4 8
line 1621
;1565:
;1566:#ifdef MISSIONPACK
;1567:/*
;1568:======================================================================
;1569:
;1570:NAILGUN
;1571:
;1572:======================================================================
;1573:*/
;1574:
;1575:void Weapon_Nailgun_Fire (gentity_t *ent) {
;1576:	gentity_t	*m;
;1577:	int			count;
;1578:
;1579:	for( count = 0; count < NUM_NAILSHOTS; count++ ) {
;1580:		m = fire_nail (ent, muzzle, forward, right, up );
;1581:		m->damage *= s_quadFactor;
;1582:		m->splashDamage *= s_quadFactor;
;1583:	}
;1584:
;1585://	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
;1586:}
;1587:
;1588:
;1589:/*
;1590:======================================================================
;1591:
;1592:PROXIMITY MINE LAUNCHER
;1593:
;1594:======================================================================
;1595:*/
;1596:
;1597:void weapon_proxlauncher_fire (gentity_t *ent) {
;1598:	gentity_t	*m;
;1599:
;1600:	// extra vertical velocity
;1601:	forward[2] += 0.2f;
;1602:	VectorNormalize( forward );
;1603:
;1604:	m = fire_prox (ent, muzzle, forward);
;1605:	m->damage *= s_quadFactor;
;1606:	m->splashDamage *= s_quadFactor;
;1607:
;1608://	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
;1609:}
;1610:
;1611:#endif
;1612:
;1613://======================================================================
;1614:
;1615:
;1616:/*
;1617:===============
;1618:LogAccuracyHit
;1619:===============
;1620:*/
;1621:qboolean LogAccuracyHit( gentity_t *target, gentity_t *attacker ) {
line 1622
;1622:	if( !target->takedamage ) {
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
NEI4 $662
line 1623
;1623:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $661
JUMPV
LABELV $662
line 1631
;1624:	}
;1625:
;1626:	/*if ( !G_AllowEntityInteraction(attacker, target) )
;1627:	{
;1628:		return qfalse;
;1629:	}*/
;1630:
;1631:	if ( target == attacker ) {
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
NEU4 $664
line 1632
;1632:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $661
JUMPV
LABELV $664
line 1635
;1633:	}
;1634:
;1635:	if( !target->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $666
line 1636
;1636:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $661
JUMPV
LABELV $666
line 1639
;1637:	}
;1638:
;1639:	if( !attacker->client ) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $668
line 1640
;1640:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $661
JUMPV
LABELV $668
line 1643
;1641:	}
;1642:
;1643:	if( target->client->ps.stats[STAT_HEALTH] <= 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $670
line 1644
;1644:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $661
JUMPV
LABELV $670
line 1647
;1645:	}
;1646:
;1647:	if ( OnSameTeam( target, attacker ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $672
line 1648
;1648:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $661
JUMPV
LABELV $672
line 1651
;1649:	}
;1650:
;1651:	return qtrue;
CNSTI4 1
RETI4
LABELV $661
endproc LogAccuracyHit 4 8
export G_ProjectSource
proc G_ProjectSource 20 0
line 1657
;1652:}
;1653:
;1654://#define MUZZLE	14
;1655://14
;1656:// ripped from qfusion
;1657:void G_ProjectSource ( vec3_t point, vec3_t distance, vec3_t forward, vec3_t right, vec3_t result ) {
line 1658
;1658:   result[0] = point[0] + forward[0] * distance[0] + right[0] * distance[1];
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 16
INDIRP4
ADDRFP4 0
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
INDIRF4
MULF4
ADDF4
ADDRFP4 12
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1659
;1659:   result[1] = point[1] + forward[1] * distance[0] + right[1] * distance[1];
ADDRLP4 4
CNSTI4 4
ASGNI4
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 16
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
ADDRFP4 8
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
INDIRF4
MULF4
ADDF4
ADDRFP4 12
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
ADDRLP4 4
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1660
;1660:   result[2] = point[2] + forward[2] * distance[0] + right[2] * distance[1] + distance[2];
ADDRLP4 12
CNSTI4 8
ASGNI4
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 16
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
ADDRFP4 8
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
INDIRF4
MULF4
ADDF4
ADDRFP4 12
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 16
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1661
;1661:}
LABELV $674
endproc G_ProjectSource 20 0
export CalcMuzzlePoint
proc CalcMuzzlePoint 24 20
line 1669
;1662:/*
;1663:===============
;1664:CalcMuzzlePoint
;1665:
;1666:set muzzle location relative to pivoting eye
;1667:===============
;1668:*/
;1669:void CalcMuzzlePoint ( gentity_t *ent, vec3_t forward, vec3_t right, vec3_t up, vec3_t muzzlePoint ) {
line 1670
;1670:	if ( g_fixMuzzleBug.integer ) {
ADDRGP4 g_fixMuzzleBug+12
INDIRI4
CNSTI4 0
EQI4 $676
line 1674
;1671:		vec3_t start;
;1672:		vec3_t offset;
;1673:
;1674:		AngleVectors (ent->client->ps.viewangles, forward, right, NULL);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 1675
;1675:		VectorSet(offset, 0-5, 0, 0+20);
ADDRLP4 0
CNSTF4 3231711232
ASGNF4
ADDRLP4 0+4
CNSTF4 0
ASGNF4
ADDRLP4 0+8
CNSTF4 1101004800
ASGNF4
line 1676
;1676:		G_ProjectSource (ent->client->ps.origin, offset, forward, right, start);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 G_ProjectSource
CALLV
pop
line 1677
;1677:		VectorCopy( start, muzzlePoint );
ADDRFP4 16
INDIRP4
ADDRLP4 12
INDIRB
ASGNB 12
line 1678
;1678:	} else {
ADDRGP4 $677
JUMPV
LABELV $676
line 1679
;1679:		VectorCopy( ent->s.pos.trBase, muzzlePoint );
ADDRFP4 16
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 1680
;1680:		muzzlePoint[2] += ent->client->ps.viewheight;
ADDRLP4 0
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1681
;1681:		VectorMA( muzzlePoint, 14, forward, muzzlePoint );
ADDRLP4 4
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
CNSTF4 1096810496
ADDRFP4 4
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 8
CNSTI4 4
ASGNI4
ADDRLP4 12
ADDRFP4 16
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
CNSTF4 1096810496
ADDRFP4 4
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 16
CNSTI4 8
ASGNI4
ADDRLP4 20
ADDRFP4 16
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
CNSTF4 1096810496
ADDRFP4 4
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1682
;1682:	}
LABELV $677
line 1684
;1683:	// snap to integer coordinates for more efficient network bandwidth usage
;1684:	SnapVector( muzzlePoint );
ADDRLP4 0
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 4
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 8
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 1685
;1685:}
LABELV $675
endproc CalcMuzzlePoint 24 20
export CalcMuzzlePointOrigin
proc CalcMuzzlePointOrigin 24 20
line 1694
;1686:
;1687:/*
;1688:===============
;1689:CalcMuzzlePointOrigin
;1690:
;1691:set muzzle location relative to pivoting eye
;1692:===============
;1693:*/
;1694:void CalcMuzzlePointOrigin ( gentity_t *ent, vec3_t origin, vec3_t forward, vec3_t right, vec3_t up, vec3_t muzzlePoint ) {
line 1695
;1695:	if ( g_fixMuzzleBug.integer ) {
ADDRGP4 g_fixMuzzleBug+12
INDIRI4
CNSTI4 0
EQI4 $682
line 1699
;1696:		vec3_t start;
;1697:		vec3_t offset;
;1698:
;1699:		AngleVectors (ent->client->ps.viewangles, forward, right, NULL);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 1700
;1700:		VectorSet(offset, 0-5, 0, 0+20);
ADDRLP4 0
CNSTF4 3231711232
ASGNF4
ADDRLP4 0+4
CNSTF4 0
ASGNF4
ADDRLP4 0+8
CNSTF4 1101004800
ASGNF4
line 1701
;1701:		G_ProjectSource (ent->client->ps.origin, offset, forward, right, start);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 G_ProjectSource
CALLV
pop
line 1702
;1702:		VectorCopy( start, muzzlePoint );
ADDRFP4 20
INDIRP4
ADDRLP4 12
INDIRB
ASGNB 12
line 1703
;1703:	} else {
ADDRGP4 $683
JUMPV
LABELV $682
line 1704
;1704:		VectorCopy( ent->s.pos.trBase, muzzlePoint );
ADDRFP4 20
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 1705
;1705:		muzzlePoint[2] += ent->client->ps.viewheight;
ADDRLP4 0
ADDRFP4 20
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1706
;1706:		VectorMA( muzzlePoint, 14, forward, muzzlePoint );
ADDRLP4 4
ADDRFP4 20
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
CNSTF4 1096810496
ADDRFP4 8
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 8
CNSTI4 4
ASGNI4
ADDRLP4 12
ADDRFP4 20
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
CNSTF4 1096810496
ADDRFP4 8
INDIRP4
ADDRLP4 8
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 16
CNSTI4 8
ASGNI4
ADDRLP4 20
ADDRFP4 20
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
CNSTF4 1096810496
ADDRFP4 8
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1707
;1707:	}
LABELV $683
line 1709
;1708:	// snap to integer coordinates for more efficient network bandwidth usage
;1709:	SnapVector( muzzlePoint );
ADDRLP4 0
ADDRFP4 20
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 4
ADDRFP4 20
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 8
ADDRFP4 20
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 1710
;1710:}
LABELV $681
endproc CalcMuzzlePointOrigin 24 20
export FireWeaponGrapple
proc FireWeaponGrapple 4 24
line 1712
;1711:
;1712:void FireWeaponGrapple( gentity_t *ent) {
line 1716
;1713:	//server won't accecpt the client command unless the mod_enableHook == 1
;1714:
;1715:	// set aiming directions
;1716:	AngleVectors (ent->client->ps.viewangles, forward, right, up);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRGP4 right
ARGP4
ADDRGP4 up
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 1718
;1717:
;1718:	CalcMuzzlePointOrigin ( ent, ent->client->oldOrigin, forward, right, up, muzzle );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10268
ADDP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRGP4 right
ARGP4
ADDRGP4 up
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 CalcMuzzlePointOrigin
CALLV
pop
line 1720
;1719:
;1720:	if( ent->client->buttons & BUTTON_FIRE_GRAPPLE ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10256
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $688
line 1721
;1721:		Weapon_GrapplingHook_Fire( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_GrapplingHook_Fire
CALLV
pop
line 1722
;1722:	}
LABELV $688
line 1723
;1723:}
LABELV $687
endproc FireWeaponGrapple 4 24
export FireWeapon
proc FireWeapon 16 24
line 1731
;1724:
;1725:
;1726:/*
;1727:===============
;1728:FireWeapon
;1729:===============
;1730:*/
;1731:void FireWeapon( gentity_t *ent, int evtParm ) {
line 1732
;1732:	if (ent->client->ps.powerups[PW_QUAD] ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 316
ADDP4
INDIRI4
CNSTI4 0
EQI4 $691
line 1733
;1733:		s_quadFactor = g_quadfactor.value;
ADDRGP4 s_quadFactor
ADDRGP4 g_quadfactor+8
INDIRF4
ASGNF4
line 1734
;1734:	} else {
ADDRGP4 $692
JUMPV
LABELV $691
line 1735
;1735:		s_quadFactor = 1;
ADDRGP4 s_quadFactor
CNSTF4 1065353216
ASGNF4
line 1736
;1736:	}
LABELV $692
line 1744
;1737:#ifdef MISSIONPACK
;1738:	if( ent->client->persistantPowerup && ent->client->persistantPowerup->item && ent->client->persistantPowerup->item->giTag == PW_DOUBLER ) {
;1739:		s_quadFactor *= 2;
;1740:	}
;1741:#endif
;1742:
;1743:	// track shots taken for accuracy tracking.  Grapple is not a weapon and gauntet is just not tracked
;1744:	if( ent->s.weapon != WP_GRAPPLING_HOOK && ent->s.weapon != WP_GAUNTLET ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 10
EQI4 $694
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $694
line 1752
;1745:#ifdef MISSIONPACK
;1746:		if( ent->s.weapon == WP_NAILGUN ) {
;1747:			ent->client->accuracy_shots += NUM_NAILSHOTS;
;1748:		} else {
;1749:			ent->client->accuracy_shots++;
;1750:		}
;1751:#else
;1752:		ent->client->accuracy_shots++;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10312
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1754
;1753:#endif
;1754:	}
LABELV $694
line 1756
;1755:
;1756:	if ( g_spawnProtection.integer && ent->client->spawnProtection == qtrue ) {
ADDRGP4 g_spawnProtection+12
INDIRI4
CNSTI4 0
EQI4 $696
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10824
ADDP4
INDIRI4
CNSTI4 1
NEI4 $696
line 1757
;1757:		ent->client->ps.powerups[PW_BATTLESUIT] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 320
ADDP4
CNSTI4 0
ASGNI4
line 1758
;1758:		ent->client->spawnProtection = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10824
ADDP4
CNSTI4 0
ASGNI4
line 1759
;1759:	}
LABELV $696
line 1761
;1760:	// set aiming directions
;1761:	AngleVectors (ent->client->ps.viewangles, forward, right, up);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRGP4 right
ARGP4
ADDRGP4 up
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 1763
;1762:
;1763:	CalcMuzzlePointOrigin ( ent, ent->client->oldOrigin, forward, right, up, muzzle );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10268
ADDP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRGP4 right
ARGP4
ADDRGP4 up
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 CalcMuzzlePointOrigin
CALLV
pop
line 1768
;1764:	//It's the same thing.. need to port it?
;1765:	//CalcMuzzlePoint ( ent, ent->client->oldOrigin, forward, right, up, muzzle );
;1766:
;1767:	// fire the specific weapon
;1768:	switch( ent->s.weapon ) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 1
LTI4 $700
ADDRLP4 8
INDIRI4
CNSTI4 10
GTI4 $700
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $720-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $720
address $702
address $705
address $704
address $714
address $715
address $703
address $717
address $716
address $718
address $719
code
LABELV $702
line 1770
;1769:	case WP_GAUNTLET:
;1770:			Weapon_Gauntlet( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_Gauntlet
CALLV
pop
line 1771
;1771:		break;
ADDRGP4 $700
JUMPV
LABELV $703
line 1773
;1772:	case WP_LIGHTNING:
;1773:		Weapon_LightningFire( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_LightningFire
CALLV
pop
line 1774
;1774:		break;
ADDRGP4 $700
JUMPV
LABELV $704
line 1776
;1775:	case WP_SHOTGUN:
;1776:			weapon_supershotgun_fire( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 weapon_supershotgun_fire
CALLV
pop
line 1777
;1777:		break;
ADDRGP4 $700
JUMPV
LABELV $705
line 1785
;1778:	case WP_MACHINEGUN:
;1779:		/*if ( g_gametype.integer != GT_TEAM ) {
;1780:			Bullet_Fire( ent, MACHINEGUN_SPREAD, MACHINEGUN_DAMAGE );
;1781:		} else {
;1782:			Bullet_Fire( ent, MACHINEGUN_SPREAD, MACHINEGUN_TEAM_DAMAGE );
;1783:		}
;1784:		break;*/
;1785:		if ( g_gametype.integer != GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
EQI4 $706
line 1786
;1786:			Bullet_Fire( ent, MACHINEGUN_SPREAD, gameSettings.hitscans[GS_MACHINEGUN][GS_DAMAGE] ); // CPM
ADDRFP4 0
INDIRP4
ARGP4
CNSTF4 1128792064
ARGF4
ADDRGP4 gameSettings+104+8
INDIRI4
ARGI4
ADDRGP4 Bullet_Fire
CALLV
pop
line 1787
;1787:		} else {
ADDRGP4 $700
JUMPV
LABELV $706
line 1788
;1788:			Bullet_Fire( ent, MACHINEGUN_SPREAD, gameSettings.hitscans[GS_MACHINEGUN][GS_RANGE] ); // CPM
ADDRFP4 0
INDIRP4
ARGP4
CNSTF4 1128792064
ARGF4
ADDRGP4 gameSettings+104+8+4
INDIRI4
ARGI4
ADDRGP4 Bullet_Fire
CALLV
pop
line 1789
;1789:		}
line 1790
;1790:		break;
ADDRGP4 $700
JUMPV
LABELV $714
line 1792
;1791:	case WP_GRENADE_LAUNCHER:
;1792:		weapon_grenadelauncher_fire( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 weapon_grenadelauncher_fire
CALLV
pop
line 1793
;1793:		break;
ADDRGP4 $700
JUMPV
LABELV $715
line 1795
;1794:	case WP_ROCKET_LAUNCHER:
;1795:		Weapon_RocketLauncher_Fire( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_RocketLauncher_Fire
CALLV
pop
line 1796
;1796:		break;
ADDRGP4 $700
JUMPV
LABELV $716
line 1798
;1797:	case WP_PLASMAGUN:
;1798:		Weapon_Plasmagun_Fire( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_Plasmagun_Fire
CALLV
pop
line 1799
;1799:		break;
ADDRGP4 $700
JUMPV
LABELV $717
line 1801
;1800:	case WP_RAILGUN:
;1801:		weapon_railgun_fire( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 weapon_railgun_fire
CALLV
pop
line 1802
;1802:		break;
ADDRGP4 $700
JUMPV
LABELV $718
line 1804
;1803:	case WP_BFG:
;1804:		BFG_Fire( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BFG_Fire
CALLV
pop
line 1805
;1805:		break;
ADDRGP4 $700
JUMPV
LABELV $719
line 1807
;1806:	case WP_GRAPPLING_HOOK:
;1807:		Weapon_GrapplingHook_Fire( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_GrapplingHook_Fire
CALLV
pop
line 1808
;1808:		break;
line 1822
;1809:#ifdef MISSIONPACK
;1810:	case WP_NAILGUN:
;1811:		Weapon_Nailgun_Fire( ent );
;1812:		break;
;1813:	case WP_PROX_LAUNCHER:
;1814:		weapon_proxlauncher_fire( ent );
;1815:		break;
;1816:	case WP_CHAINGUN:
;1817:		Bullet_Fire( ent, CHAINGUN_SPREAD, MACHINEGUN_DAMAGE );
;1818:		break;
;1819:#endif
;1820:	default:
;1821:// FIXME		G_Error( "Bad ent->s.weapon" );
;1822:		break;
LABELV $700
line 1824
;1823:	}
;1824:}
LABELV $690
endproc FireWeapon 16 24
import GetClientMask
import G_ExplodeMissile
bss
align 4
LABELV muzzle
skip 12
align 4
LABELV up
skip 12
align 4
LABELV right
skip 12
align 4
LABELV forward
skip 12
align 4
LABELV s_quadFactor
skip 4
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
import pm_friction
import pm_accelerate
import cpm_pm_wishspeed
import cpm_pm_strafeaccelerate
import cpm_pm_aircontrol
import cpm_pm_airstopaccelerate
import cpm_pm_jump_z
import CPM_UpdateSettings
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
import TeleportPlayer
import trigger_teleporter_touch
import Touch_DoorTrigger
import G_RunMover
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
LABELV $496
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 94
byte 1 53
byte 1 32
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 97
byte 1 99
byte 1 99
byte 1 117
byte 1 114
byte 1 97
byte 1 99
byte 1 121
byte 1 33
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $495
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 97
byte 1 99
byte 1 99
byte 1 117
byte 1 114
byte 1 97
byte 1 99
byte 1 121
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $443
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 82
byte 1 97
byte 1 105
byte 1 108
byte 1 70
byte 1 105
byte 1 114
byte 1 101
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 45
byte 1 32
byte 1 84
byte 1 111
byte 1 68
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 45
byte 1 32
byte 1 72
byte 1 105
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $419
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 32
byte 1 34
byte 1 37
byte 1 105
byte 1 34
byte 1 0
align 1
LABELV $183
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 0
