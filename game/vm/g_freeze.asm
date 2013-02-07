export is_spectator
code
proc is_spectator 0 0
file "../g_freeze.c"
line 7
;1:#include "g_local.h"
;2:
;3:int	check_time;
;4:static vec3_t	redflag;
;5:static vec3_t	blueflag;
;6:
;7:qboolean is_spectator( gclient_t *client ) {
line 8
;8:	if ( client == NULL ) return qfalse;
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $68
CNSTI4 0
RETI4
ADDRGP4 $67
JUMPV
LABELV $68
line 9
;9:	if ( client->sess.sessionTeam == TEAM_SPECTATOR ) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
CNSTI4 3
NEI4 $70
CNSTI4 1
RETI4
ADDRGP4 $67
JUMPV
LABELV $70
line 10
;10:	if ( client->ps.persistant[ PERS_TEAM ] == TEAM_SPECTATOR ) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 3
NEI4 $72
CNSTI4 1
RETI4
ADDRGP4 $67
JUMPV
LABELV $72
line 11
;11:	if ( client->sess.spectatorState == SPECTATOR_FOLLOW ) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 10196
ADDP4
INDIRI4
CNSTI4 2
NEI4 $74
CNSTI4 1
RETI4
ADDRGP4 $67
JUMPV
LABELV $74
line 12
;12:	return qfalse;
CNSTI4 0
RETI4
LABELV $67
endproc is_spectator 0 0
export Set_spectator
proc Set_spectator 28 8
line 15
;13:}
;14:
;15:qboolean Set_spectator( gentity_t *ent ) {
line 18
;16:	vec3_t	origin, angles;
;17:
;18:	if ( level.intermissiontime ) return qfalse;
ADDRGP4 level+9160
INDIRI4
CNSTI4 0
EQI4 $77
CNSTI4 0
RETI4
ADDRGP4 $76
JUMPV
LABELV $77
line 19
;19:	if ( !ent->freezeState ) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 0
NEI4 $80
CNSTI4 0
RETI4
ADDRGP4 $76
JUMPV
LABELV $80
line 20
;20:	if ( ent->r.svFlags & SVF_BOT ) {
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $82
line 21
;21:		ent->client->respawnTime = INT_MAX;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10332
ADDP4
CNSTI4 2147483647
ASGNI4
line 22
;22:	} else if ( !is_spectator( ent->client ) ) {
ADDRGP4 $83
JUMPV
LABELV $82
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 is_spectator
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $84
line 23
;23:		VectorCopy( ent->r.currentOrigin, origin );
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 24
;24:		angles[ YAW ] = ent->client->ps.stats[ STAT_DEAD_YAW ];
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 25
;25:		angles[ PITCH ] = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 26
;26:		angles[ ROLL ] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 27
;27:		ClientSpawn( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 ClientSpawn
CALLV
pop
line 28
;28:		VectorCopy( origin, ent->client->ps.origin );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 12
INDIRB
ASGNB 12
line 29
;29:		SetClientViewAngle( ent, angles );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 SetClientViewAngle
CALLV
pop
line 30
;30:		ent->client->ps.persistant[ PERS_TEAM ] = TEAM_SPECTATOR;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 260
ADDP4
CNSTI4 3
ASGNI4
line 31
;31:		ent->client->sess.spectatorTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10192
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 32
;32:		ent->client->sess.spectatorState = SPECTATOR_FREE;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10196
ADDP4
CNSTI4 1
ASGNI4
line 33
;33:		ent->client->sess.spectatorClient = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10200
ADDP4
CNSTI4 0
ASGNI4
line 35
;34:
;35:		trap_UnlinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 36
;36:	}
LABELV $84
LABELV $83
line 37
;37:	return qtrue;
CNSTI4 1
RETI4
LABELV $76
endproc Set_spectator 28 8
export Set_Client
proc Set_Client 16 8
line 40
;38:}
;39:
;40:qboolean Set_Client( gentity_t *ent ) {
line 44
;41:	gclient_t	*cl;
;42:	gentity_t	*tent;
;43:
;44:	cl = ent->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 45
;45:	if ( cl->ps.pm_type != PM_SPECTATOR ) return qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $90
CNSTI4 0
RETI4
ADDRGP4 $89
JUMPV
LABELV $90
line 46
;46:	if ( cl->sess.sessionTeam == TEAM_SPECTATOR ) return qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
CNSTI4 3
NEI4 $92
CNSTI4 0
RETI4
ADDRGP4 $89
JUMPV
LABELV $92
line 47
;47:	if ( ent->freezeState ) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 0
EQI4 $94
CNSTI4 0
RETI4
ADDRGP4 $89
JUMPV
LABELV $94
line 49
;48:
;49:	cl->sess.spectatorState = SPECTATOR_NOT;
ADDRLP4 0
INDIRP4
CNSTI4 10196
ADDP4
CNSTI4 0
ASGNI4
line 50
;50:	cl->sess.spectatorClient = 0;
ADDRLP4 0
INDIRP4
CNSTI4 10200
ADDP4
CNSTI4 0
ASGNI4
line 51
;51:	ClientSpawn( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 ClientSpawn
CALLV
pop
line 53
;52:
;53:	tent = G_TempEntity( cl->ps.origin, EV_PLAYER_TELEPORT_IN );
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTI4 42
ARGI4
ADDRLP4 8
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 54
;54:	tent->s.clientNum = ent->s.clientNum;
ADDRLP4 12
CNSTI4 168
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 56
;55:
;56:	return qtrue;
CNSTI4 1
RETI4
LABELV $89
endproc Set_Client 16 8
export respawnSpectator
proc respawnSpectator 4 8
line 59
;57:}
;58:
;59:void respawnSpectator( gentity_t *ent ) {
line 62
;60:	gclient_t	*client;
;61:
;62:	client = ent->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 63
;63:	if ( ent->freezeState ) return;
ADDRFP4 0
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 0
EQI4 $97
ADDRGP4 $96
JUMPV
LABELV $97
line 64
;64:	if ( client->sess.sessionTeam == TEAM_SPECTATOR ) return;
ADDRLP4 0
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
CNSTI4 3
NEI4 $99
ADDRGP4 $96
JUMPV
LABELV $99
line 66
;65:
;66:	if ( level.time > client->respawnTime ) {
ADDRGP4 level+40
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 10332
ADDP4
INDIRI4
LEI4 $101
line 67
;67:		if ( g_forcerespawn.integer > 0 && level.time - client->respawnTime > g_forcerespawn.integer * 1000 ) {
ADDRGP4 g_forcerespawn+12
INDIRI4
CNSTI4 0
LEI4 $104
ADDRGP4 level+40
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 10332
ADDP4
INDIRI4
SUBI4
CNSTI4 1000
ADDRGP4 g_forcerespawn+12
INDIRI4
MULI4
LEI4 $104
line 68
;68:			Cmd_FollowCycle_f( ent, 1 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Cmd_FollowCycle_f
CALLV
pop
line 69
;69:		}
LABELV $104
line 70
;70:	}
LABELV $101
line 71
;71:}
LABELV $96
endproc respawnSpectator 4 8
export Persistant_spectator
proc Persistant_spectator 80 0
line 73
;72:
;73:void Persistant_spectator( gentity_t *ent, gclient_t *cl ) {
line 78
;74:	int	i;
;75:	int	persistant[ MAX_PERSISTANT ];
;76:	int	savedPing;
;77:
;78:	savedPing = ent->client->ps.ping;
ADDRLP4 68
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
ASGNI4
line 79
;79:	for ( i = 0; i < MAX_PERSISTANT; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $110
line 80
;80:		persistant[ i ] = ent->client->ps.persistant[ i ];
ADDRLP4 72
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 72
INDIRI4
ADDRLP4 4
ADDP4
ADDRLP4 72
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 248
ADDP4
ADDP4
INDIRI4
ASGNI4
line 81
;81:	}
LABELV $111
line 79
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $110
line 82
;82:	ent->client->ps = cl->ps;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 468
line 83
;83:	ent->client->ps.ping = savedPing;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 452
ADDP4
ADDRLP4 68
INDIRI4
ASGNI4
line 84
;84:	for ( i = 0; i < MAX_PERSISTANT; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $114
line 85
;85:		switch ( i ) {
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $115
ADDRLP4 0
INDIRI4
CNSTI4 3
EQI4 $115
ADDRLP4 0
INDIRI4
CNSTI4 6
EQI4 $115
ADDRGP4 $118
JUMPV
line 89
;86:		case PERS_HITS:
;87:		case PERS_TEAM:
;88:		case PERS_ATTACKER:
;89:			continue;
LABELV $118
line 91
;90:		}
;91:		ent->client->ps.persistant[ i ] = persistant[ i ];
ADDRLP4 76
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 76
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 248
ADDP4
ADDP4
ADDRLP4 76
INDIRI4
ADDRLP4 4
ADDP4
INDIRI4
ASGNI4
line 92
;92:	}
LABELV $115
line 84
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $114
line 93
;93:}
LABELV $109
endproc Persistant_spectator 80 0
proc FollowClient 4 4
line 95
;94:
;95:static void FollowClient( gentity_t *ent, gentity_t *other ) {
line 96
;96:	if ( ent->target_ent == other ) return;
ADDRFP4 0
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
NEU4 $122
ADDRGP4 $121
JUMPV
LABELV $122
line 97
;97:	if ( is_spectator( ent->target_ent->client ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 is_spectator
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $124
line 98
;98:		ent->target_ent->client->sess.spectatorState = SPECTATOR_FOLLOW;
ADDRFP4 0
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10196
ADDP4
CNSTI4 2
ASGNI4
line 99
;99:		ent->target_ent->client->sess.spectatorClient = other->s.number;
ADDRFP4 0
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10200
ADDP4
ADDRFP4 4
INDIRP4
INDIRI4
ASGNI4
line 100
;100:	}
LABELV $124
line 101
;101:}
LABELV $121
endproc FollowClient 4 4
proc player_free 16 4
line 103
;102:
;103:static void player_free( gentity_t *ent ) {
line 104
;104:	if ( !ent || !ent->inuse || !ent->freezeState) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $130
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $130
ADDRLP4 0
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $127
LABELV $130
line 105
;105:		return;
ADDRGP4 $126
JUMPV
LABELV $127
line 109
;106:	}
;107:
;108:	//Not frozen anymore, setup for respawn
;109:	ent->freezeState = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 888
ADDP4
CNSTI4 0
ASGNI4
line 110
;110:	(g_fastRespawn.integer && !ent->client->pers.fastRespawn)?(ent->client->respawnTime = level.time + 500):(ent->client->respawnTime = level.time + 1700);
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 g_fastRespawn+12
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $135
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $135
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10332
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
ADDRGP4 $136
JUMPV
LABELV $135
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10332
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 1700
ADDI4
ASGNI4
LABELV $136
line 112
;111:
;112:	if ( ent->client->sess.spectatorState == SPECTATOR_FOLLOW ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10196
ADDP4
INDIRI4
CNSTI4 2
NEI4 $137
line 114
;113:		//Stop following whomever and knock'em back a ways
;114:		StopFollowing( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 StopFollowing
CALLV
pop
line 115
;115:		ent->client->ps.pm_flags |= PMF_TIME_KNOCKBACK;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 116
;116:		ent->client->ps.pm_time = 100;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 100
ASGNI4
line 117
;117:	}
LABELV $137
line 119
;118:	//Set the inactivity/forceRespawn timer
;119:	ent->client->inactivityTime = level.time + g_inactivity.integer * 1000;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10336
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 1000
ADDRGP4 g_inactivity+12
INDIRI4
MULI4
ADDI4
ASGNI4
line 120
;120:}
LABELV $126
endproc player_free 16 4
export Body_free
proc Body_free 12 8
line 122
;121:
;122:void Body_free( gentity_t *self ) {
line 126
;123:	int	i;
;124:	gentity_t	*ent;
;125:
;126:	if ( self->freezeState ) {
ADDRFP4 0
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 0
EQI4 $142
line 127
;127:		player_free( self->target_ent );
ADDRFP4 0
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
ARGP4
ADDRGP4 player_free
CALLV
pop
line 128
;128:	}
LABELV $142
line 129
;129:	if ( self->s.eFlags & EF_KAMIKAZE ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $144
line 130
;130:		for ( i = 0; i < MAX_GENTITIES; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $146
line 131
;131:			ent = &g_entities[ i ];
ADDRLP4 0
CNSTI4 896
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 132
;132:			if ( !ent->inuse ) continue;
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $150
ADDRGP4 $147
JUMPV
LABELV $150
line 133
;133:			if ( ent->activator != self ) continue;
ADDRLP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $152
ADDRGP4 $147
JUMPV
LABELV $152
line 134
;134:			if ( strcmp( ent->classname, "kamikaze timer" ) ) continue;
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $156
ARGP4
ADDRLP4 8
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $154
ADDRGP4 $147
JUMPV
LABELV $154
line 135
;135:			G_FreeEntity( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 136
;136:			break;
ADDRGP4 $148
JUMPV
LABELV $147
line 130
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1024
LTI4 $146
LABELV $148
line 138
;137:		}
;138:	}
LABELV $144
line 139
;139:	self->s.powerups = 0;
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTI4 0
ASGNI4
line 140
;140:	G_FreeEntity( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 141
;141:}
LABELV $141
endproc Body_free 12 8
proc Body_Explode 84 32
line 143
;142:
;143:static void Body_Explode( gentity_t *self ) {
line 148
;144:	int	i;
;145:	gentity_t	*e, *tent;
;146:	vec3_t	point;
;147:
;148:	for ( i = 0; i < g_maxclients.integer; i++ ) {
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 $161
JUMPV
LABELV $158
line 149
;149:		e = g_entities + i;
ADDRLP4 0
CNSTI4 896
ADDRLP4 16
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 150
;150:		if ( !e->inuse ) continue;
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $163
ADDRGP4 $159
JUMPV
LABELV $163
line 151
;151:		if ( e->health < 1 ) continue;
ADDRLP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 1
GEI4 $165
ADDRGP4 $159
JUMPV
LABELV $165
line 152
;152:		if ( e->client->sess.sessionTeam != self->spawnflags ) continue;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
EQI4 $167
ADDRGP4 $159
JUMPV
LABELV $167
line 153
;153:		VectorSubtract( self->s.pos.trBase, e->s.pos.trBase, point );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
CNSTI4 24
ASGNI4
ADDRLP4 4
ADDRLP4 24
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 36
CNSTI4 28
ASGNI4
ADDRLP4 4+4
ADDRLP4 24
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 40
CNSTI4 32
ASGNI4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 154
;154:		if ( VectorLength( point ) > 100 ) continue;
ADDRLP4 4
ARGP4
ADDRLP4 44
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 44
INDIRF4
CNSTF4 1120403456
LEF4 $171
ADDRGP4 $159
JUMPV
LABELV $171
line 155
;155:		if ( is_spectator( e->client ) ) continue;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 is_spectator
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $173
ADDRGP4 $159
JUMPV
LABELV $173
line 156
;156:		if ( !self->count ) {
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
NEI4 $175
line 157
;157:			if ( g_dmflags.integer & 1024 || g_gametype.integer == GT_CTF ) {
ADDRGP4 g_dmflags+12
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
NEI4 $181
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $177
LABELV $181
line 158
;158:				self->count = level.time + 2000;
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 159
;159:			} else {
ADDRGP4 $178
JUMPV
LABELV $177
line 160
;160:				self->count = level.time + 3000;
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 161
;161:			}
LABELV $178
line 162
;162:			G_Sound( self, CHAN_AUTO, self->noise_index );
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 52
INDIRP4
CNSTI4 792
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_Sound
CALLV
pop
line 164
;163:
;164:			self->activator = e;
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 165
;165:		} else if ( self->count < level.time ) {
ADDRGP4 $157
JUMPV
LABELV $175
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
ADDRGP4 level+40
INDIRI4
GEI4 $157
line 166
;166:			if ( self->activator == e ) {
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
NEU4 $187
line 167
;167:			} else if ( !self->activator->inuse ) {
ADDRGP4 $188
JUMPV
LABELV $187
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $189
line 168
;168:			} else if ( self->activator->health < 1 ) {
ADDRGP4 $190
JUMPV
LABELV $189
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 1
GEI4 $191
line 169
;169:			} else {
ADDRGP4 $192
JUMPV
LABELV $191
line 170
;170:				VectorSubtract( self->s.pos.trBase, self->activator->s.pos.trBase, point );
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
CNSTI4 24
ASGNI4
ADDRLP4 60
ADDRLP4 52
INDIRP4
CNSTI4 772
ADDP4
ASGNP4
ADDRLP4 4
ADDRLP4 52
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 64
CNSTI4 28
ASGNI4
ADDRLP4 4+4
ADDRLP4 52
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
CNSTI4 32
ASGNI4
ADDRLP4 4+8
ADDRLP4 68
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRF4
ADDRLP4 68
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 171
;171:				if ( VectorLength( point ) > 100 ) {
ADDRLP4 4
ARGP4
ADDRLP4 76
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 76
INDIRF4
CNSTF4 1120403456
LEF4 $195
line 172
;172:				} else if ( is_spectator( self->activator->client ) ) {
ADDRGP4 $196
JUMPV
LABELV $195
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 is_spectator
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
EQI4 $197
line 173
;173:				} else {
ADDRGP4 $198
JUMPV
LABELV $197
line 174
;174:					e = self->activator;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
ASGNP4
line 175
;175:				}
LABELV $198
LABELV $196
line 176
;176:			}
LABELV $192
LABELV $190
LABELV $188
line 178
;177:
;178:			tent = G_TempEntity( self->target_ent->r.currentOrigin, EV_OBITUARY );
ADDRFP4 0
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 60
ARGI4
ADDRLP4 52
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 52
INDIRP4
ASGNP4
line 179
;179:			tent->s.eventParm = MOD_UNKNOWN;
ADDRLP4 20
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 0
ASGNI4
line 180
;180:			tent->s.otherEntityNum = self->target_ent->s.number;
ADDRLP4 20
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
INDIRI4
ASGNI4
line 181
;181:			tent->s.otherEntityNum2 = e->s.number;
ADDRLP4 20
INDIRP4
CNSTI4 144
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 182
;182:			tent->r.svFlags = SVF_BROADCAST;
ADDRLP4 20
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 32
ASGNI4
line 184
;183:
;184:			G_LogPrintf( "Kill: %i %i %i: %s killed %s by %s\n", e->s.number, self->target_ent->s.number, MOD_UNKNOWN, e->client->pers.netname, self->target_ent->client->pers.netname, "MOD_UNKNOWN" );
ADDRGP4 $199
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 60
ADDRFP4 0
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 64
CNSTI4 516
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
ARGP4
ADDRLP4 60
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
ARGP4
ADDRGP4 $200
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 185
;185:			AddScore( e, self->s.pos.trBase, 1 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 187
;186:
;187:			e->client->sess.wins++;
ADDRLP4 68
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10204
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 188
;188:			G_Damage( self, NULL, NULL, NULL, NULL, 100000, DAMAGE_NO_PROTECTION, MOD_TELEFRAG );
ADDRFP4 0
INDIRP4
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
ADDRLP4 76
CNSTP4 0
ASGNP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
CNSTI4 100000
ARGI4
CNSTI4 8
ARGI4
CNSTI4 18
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 189
;189:		}
line 190
;190:		return;
ADDRGP4 $157
JUMPV
LABELV $159
line 148
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $161
ADDRLP4 16
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $158
line 192
;191:	}
;192:	self->count = 0;
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 0
ASGNI4
line 193
;193:}
LABELV $157
endproc Body_Explode 84 32
proc Body_WorldEffects 4196 32
line 195
;194:
;195:static void Body_WorldEffects( gentity_t *self ) {
line 204
;196:	vec3_t	point;
;197:	int	contents;
;198:	int	i, num;
;199:	int	touch[ MAX_GENTITIES ];
;200:	gentity_t	*hit;
;201:	vec3_t	mins, maxs;
;202:	int	previous_waterlevel;
;203:
;204:	VectorCopy( self->r.currentOrigin, point );
ADDRLP4 4136
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 205
;205:	point[ 2 ] -= 23;
ADDRLP4 4136+8
ADDRLP4 4136+8
INDIRF4
CNSTF4 1102577664
SUBF4
ASGNF4
line 207
;206:
;207:	contents = trap_PointContents( point, -1 );
ADDRLP4 4136
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 4152
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 4108
ADDRLP4 4152
INDIRI4
ASGNI4
line 208
;208:	if ( contents & ( CONTENTS_LAVA | CONTENTS_SLIME ) ) {
ADDRLP4 4108
INDIRI4
CNSTI4 24
BANDI4
CNSTI4 0
EQI4 $203
line 209
;209:		if ( level.time - self->timestamp > 5000 ) {
ADDRGP4 level+40
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 640
ADDP4
INDIRI4
SUBI4
CNSTI4 5000
LEI4 $201
line 210
;210:			G_Damage( self, NULL, NULL, NULL, NULL, 100000, DAMAGE_NO_PROTECTION, MOD_TELEFRAG );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4156
CNSTP4 0
ASGNP4
ADDRLP4 4156
INDIRP4
ARGP4
ADDRLP4 4156
INDIRP4
ARGP4
ADDRLP4 4160
CNSTP4 0
ASGNP4
ADDRLP4 4160
INDIRP4
ARGP4
ADDRLP4 4160
INDIRP4
ARGP4
CNSTI4 100000
ARGI4
CNSTI4 8
ARGI4
CNSTI4 18
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 211
;211:		}
line 212
;212:		return;
ADDRGP4 $201
JUMPV
LABELV $203
line 214
;213:	}
;214:	if ( self->s.pos.trType == TR_STATIONARY && contents & CONTENTS_NODROP ) {
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
NEI4 $208
ADDRLP4 4108
INDIRI4
CVIU4 4
CNSTU4 2147483648
BANDU4
CNSTU4 0
EQU4 $208
line 215
;215:		if ( level.time - self->timestamp > 5000 ) {
ADDRGP4 level+40
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 640
ADDP4
INDIRI4
SUBI4
CNSTI4 5000
LEI4 $201
line 216
;216:			Body_free( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Body_free
CALLV
pop
line 217
;217:		}
line 218
;218:		return;
ADDRGP4 $201
JUMPV
LABELV $208
line 221
;219:	}
;220:
;221:	previous_waterlevel = self->waterlevel;
ADDRLP4 4148
ADDRFP4 0
INDIRP4
CNSTI4 788
ADDP4
INDIRI4
ASGNI4
line 222
;222:	self->waterlevel = 0;
ADDRFP4 0
INDIRP4
CNSTI4 788
ADDP4
CNSTI4 0
ASGNI4
line 223
;223:	if ( contents & MASK_WATER ) {
ADDRLP4 4108
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $213
line 224
;224:		self->waterlevel = 3;
ADDRFP4 0
INDIRP4
CNSTI4 788
ADDP4
CNSTI4 3
ASGNI4
line 225
;225:	}
LABELV $213
line 226
;226:	self->watertype = contents;
ADDRFP4 0
INDIRP4
CNSTI4 784
ADDP4
ADDRLP4 4108
INDIRI4
ASGNI4
line 227
;227:	if ( !previous_waterlevel && self->waterlevel ) {
ADDRLP4 4156
CNSTI4 0
ASGNI4
ADDRLP4 4148
INDIRI4
ADDRLP4 4156
INDIRI4
NEI4 $215
ADDRFP4 0
INDIRP4
CNSTI4 788
ADDP4
INDIRI4
ADDRLP4 4156
INDIRI4
EQI4 $215
line 228
;228:		G_AddEvent( self, EV_WATER_TOUCH, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 15
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 229
;229:	}
LABELV $215
line 230
;230:	if ( previous_waterlevel && !self->waterlevel ) {
ADDRLP4 4160
CNSTI4 0
ASGNI4
ADDRLP4 4148
INDIRI4
ADDRLP4 4160
INDIRI4
EQI4 $217
ADDRFP4 0
INDIRP4
CNSTI4 788
ADDP4
INDIRI4
ADDRLP4 4160
INDIRI4
NEI4 $217
line 231
;231:		G_AddEvent( self, EV_WATER_LEAVE, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 16
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 232
;232:	}
LABELV $217
line 234
;233:
;234:	VectorAdd( self->r.currentOrigin, self->r.mins, mins );
ADDRLP4 4164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4112
ADDRLP4 4164
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 4164
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4112+4
ADDRLP4 4164
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 4164
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4168
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4112+8
ADDRLP4 4168
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 4168
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
ADDF4
ASGNF4
line 235
;235:	VectorAdd( self->r.currentOrigin, self->r.maxs, maxs );
ADDRLP4 4172
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4124
ADDRLP4 4172
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 4172
INDIRP4
CNSTI4 448
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4124+4
ADDRLP4 4172
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 4172
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4176
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4124+8
ADDRLP4 4176
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 4176
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
ADDF4
ASGNF4
line 236
;236:	num = trap_EntitiesInBox( mins, maxs, touch, MAX_GENTITIES );
ADDRLP4 4112
ARGP4
ADDRLP4 4124
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 4180
ADDRGP4 trap_EntitiesInBox
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 4180
INDIRI4
ASGNI4
line 238
;237:
;238:	for ( i = 0; i < num; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $226
JUMPV
LABELV $223
line 239
;239:		hit = &g_entities[ touch[ i ] ];
ADDRLP4 0
CNSTI4 896
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 240
;240:		if ( !hit->touch ) {
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $227
line 241
;241:			continue;
ADDRGP4 $224
JUMPV
LABELV $227
line 243
;242:		}
;243:		switch ( hit->s.eType ) {
ADDRLP4 4184
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 4184
INDIRI4
CNSTI4 8
EQI4 $232
ADDRLP4 4184
INDIRI4
CNSTI4 9
EQI4 $237
ADDRGP4 $229
JUMPV
LABELV $232
line 245
;244:		case ET_PUSH_TRIGGER:
;245:			if ( self->s.pos.trDelta[ 2 ] < 100 ) {
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRF4
CNSTF4 1120403456
GEF4 $233
line 246
;246:				G_Sound( self, CHAN_AUTO, G_SoundIndex( "sound/world/jumppad.wav" ) );
ADDRGP4 $235
ARGP4
ADDRLP4 4192
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4192
INDIRI4
ARGI4
ADDRGP4 G_Sound
CALLV
pop
line 247
;247:			}
LABELV $233
line 248
;248:			VectorCopy( hit->s.origin2, self->s.pos.trDelta );
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRB
ASGNB 12
line 250
;249:
;250:			self->s.pos.trType = TR_GRAVITY;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 5
ASGNI4
line 251
;251:			self->s.pos.trTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 252
;252:			break;
ADDRGP4 $230
JUMPV
LABELV $237
line 254
;253:		case ET_TELEPORT_TRIGGER:
;254:			if ( !( hit->spawnflags & 1 ) ) {
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $230
line 255
;255:				G_TempEntity( self->r.currentOrigin, EV_PLAYER_TELEPORT_OUT );
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 43
ARGI4
ADDRGP4 G_TempEntity
CALLP4
pop
line 256
;256:				Body_free( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Body_free
CALLV
pop
line 257
;257:				return;
ADDRGP4 $201
JUMPV
line 259
;258:			}
;259:			break;
LABELV $229
LABELV $230
line 261
;260:		}
;261:	}
LABELV $224
line 238
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $226
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $223
line 262
;262:}
LABELV $201
endproc Body_WorldEffects 4196 32
bss
align 4
LABELV $241
skip 4
code
proc TossBody 24 4
line 266
;263:
;264:void Kamikaze_DeathTimer( gentity_t *self );
;265:
;266:static void TossBody( gentity_t *self ) {
line 270
;267:	int	anim;
;268:	static int	n;
;269:
;270:	self->timestamp = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 640
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 271
;271:	self->nextthink = level.time + 5000;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 5000
ADDI4
ASGNI4
line 277
;272:#ifdef MISSIONPACK
;273:	if ( self->s.eFlags & EF_KAMIKAZE ) {
;274:		Kamikaze_DeathTimer( self );
;275:	}
;276:#endif
;277:	self->s.eFlags |= EF_DEAD;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 278
;278:	self->s.powerups = 0;
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTI4 0
ASGNI4
line 279
;279:	self->r.maxs[ 2 ] = -8;
ADDRFP4 0
INDIRP4
CNSTI4 456
ADDP4
CNSTF4 3238002688
ASGNF4
line 280
;280:	self->r.contents = CONTENTS_CORPSE;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 67108864
ASGNI4
line 281
;281:	self->freezeState = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 888
ADDP4
CNSTI4 0
ASGNI4
line 282
;282:	self->s.weapon = WP_NONE;
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 0
ASGNI4
line 284
;283:
;284:	switch ( n ) {
ADDRLP4 8
ADDRGP4 $241
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $246
ADDRLP4 8
INDIRI4
CNSTI4 1
EQI4 $247
ADDRLP4 8
INDIRI4
CNSTI4 2
EQI4 $248
ADDRGP4 $244
JUMPV
LABELV $246
line 286
;285:	case 0:
;286:		anim = BOTH_DEATH1;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 287
;287:		break;
ADDRGP4 $245
JUMPV
LABELV $247
line 289
;288:	case 1:
;289:		anim = BOTH_DEATH2;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 290
;290:		break;
ADDRGP4 $245
JUMPV
LABELV $248
LABELV $244
line 293
;291:	case 2:
;292:	default:
;293:		anim = BOTH_DEATH3;
ADDRLP4 0
CNSTI4 4
ASGNI4
line 294
;294:		break;
LABELV $245
line 296
;295:	}
;296:	n = ( n + 1 ) % 3;
ADDRLP4 12
ADDRGP4 $241
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 3
MODI4
ASGNI4
line 298
;297:
;298:	self->s.torsoAnim = self->s.legsAnim = anim;
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 16
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
ADDRLP4 16
INDIRP4
CNSTI4 200
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 300
;299:
;300:	if ( !g_blood.integer ) {
ADDRGP4 g_blood+12
INDIRI4
CNSTI4 0
NEI4 $249
line 301
;301:		self->takedamage = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 0
ASGNI4
line 302
;302:	}
LABELV $249
line 304
;303:
;304:	trap_LinkEntity( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 305
;305:}
LABELV $240
endproc TossBody 24 4
proc Body_think 20 4
line 307
;306:
;307:static void Body_think( gentity_t *self ) {
line 308
;308:	self->nextthink = level.time + FRAMETIME;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 311
;309:
;310:	//G_Printf("DBG:Freeze: nextthink set\n");
;311:	if ( !self->target_ent || !self->target_ent->client || !self->target_ent->inuse ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRU4
EQU4 $257
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRU4
EQU4 $257
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $254
LABELV $257
line 312
;312:		Body_free( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Body_free
CALLV
pop
line 314
;313:		//G_Printf("DBG:Freeze: return 1\n");
;314:		return;
ADDRGP4 $252
JUMPV
LABELV $254
line 316
;315:	}
;316:	if ( self->s.otherEntityNum != self->target_ent->s.number ) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
INDIRI4
EQI4 $258
line 317
;317:		Body_free( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Body_free
CALLV
pop
line 319
;318:		//G_Printf("DBG:Freeze: return 2\n");
;319:		return;
ADDRGP4 $252
JUMPV
LABELV $258
line 321
;320:	}
;321:	if ( level.intermissiontime || level.intermissionQueued ) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 level+9160
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $264
ADDRGP4 level+9156
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $260
LABELV $264
line 323
;322:		//G_Printf("DBG:Freeze: return 3 - intermission\n");
;323:		return;
ADDRGP4 $252
JUMPV
LABELV $260
line 325
;324:	}
;325:	if ( level.time - self->timestamp > 150000 || ( ( g_dmflags.integer & 1024 || g_gametype.integer == GT_CTF ) && level.time - self->timestamp > 60000 ) ) {
ADDRGP4 level+40
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 640
ADDP4
INDIRI4
SUBI4
CNSTI4 150000
GTI4 $271
ADDRGP4 g_dmflags+12
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
NEI4 $272
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $265
LABELV $272
ADDRGP4 level+40
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 640
ADDP4
INDIRI4
SUBI4
CNSTI4 60000
LEI4 $265
LABELV $271
line 326
;326:		player_free( self->target_ent );
ADDRFP4 0
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
ARGP4
ADDRGP4 player_free
CALLV
pop
line 327
;327:		TossBody( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 TossBody
CALLV
pop
line 329
;328:		//G_Printf("DBG:Freeze: return 4 - time checks\n");
;329:		return;
ADDRGP4 $252
JUMPV
LABELV $265
line 332
;330:	}
;331:
;332:	if ( self->freezeState ) {
ADDRFP4 0
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 0
EQI4 $273
line 333
;333:		if ( !self->target_ent->freezeState ) {
ADDRFP4 0
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 0
NEI4 $275
line 334
;334:			TossBody( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 TossBody
CALLV
pop
line 336
;335:			//G_Printf("DBG:Freeze: return 5\n");
;336:			return;
ADDRGP4 $252
JUMPV
LABELV $275
line 338
;337:		}
;338:		Body_Explode( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Body_Explode
CALLV
pop
line 339
;339:		if ( self->last_move_time < level.time - 1000 ) {
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
INDIRI4
ADDRGP4 level+40
INDIRI4
CNSTI4 1000
SUBI4
GEI4 $252
line 340
;340:			Body_WorldEffects( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Body_WorldEffects
CALLV
pop
line 341
;341:			self->last_move_time = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 728
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 342
;342:		}
line 344
;343:		//G_Printf("DBG:Freeze: return 6\n");
;344:		return;
ADDRGP4 $252
JUMPV
LABELV $273
line 347
;345:	}
;346:
;347:	if ( level.time - self->timestamp > 6500 ) {
ADDRGP4 level+40
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 640
ADDP4
INDIRI4
SUBI4
CNSTI4 6500
LEI4 $281
line 348
;348:		Body_free( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Body_free
CALLV
pop
line 349
;349:	} else {
ADDRGP4 $282
JUMPV
LABELV $281
line 350
;350:		self->s.pos.trBase[ 2 ] -= 1;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 351
;351:	}
LABELV $282
line 352
;352:}
LABELV $252
endproc Body_think 20 4
proc Body_die 12 8
line 354
;353:
;354:static void Body_die( gentity_t *self, gentity_t *inflictor, gentity_t *attacker, int damage, int mod ) {
line 357
;355:	gentity_t	*tent;
;356:
;357:	if ( self->health > GIB_HEALTH ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 -40
LEI4 $285
line 358
;358:		return;
ADDRGP4 $284
JUMPV
LABELV $285
line 361
;359:	}
;360:
;361:	if ( self->freezeState && !g_blood.integer ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $287
ADDRGP4 g_blood+12
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $287
line 362
;362:		player_free( self->target_ent );
ADDRFP4 0
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
ARGP4
ADDRGP4 player_free
CALLV
pop
line 364
;363:		//G_AddEvent( self, EV_GIB_PLAYER, NULL );
;364:		TossBody( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 TossBody
CALLV
pop
line 365
;365:		return;
ADDRGP4 $284
JUMPV
LABELV $287
line 368
;366:	}
;367:
;368:	tent = G_TempEntity( self->r.currentOrigin, EV_GIB_PLAYER );
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 8
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 369
;369:	if ( self->freezeState ) {
ADDRFP4 0
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 0
EQI4 $290
line 370
;370:		tent->s.eventParm = 255;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 255
ASGNI4
line 371
;371:	}
LABELV $290
line 372
;372:	Body_free( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Body_free
CALLV
pop
line 373
;373:}
LABELV $284
endproc Body_die 12 8
data
align 4
LABELV $293
byte 4 1128792064
bss
align 1
LABELV $296
skip 128
export DamageBody
code
proc DamageBody 1040 12
line 375
;374:
;375:qboolean DamageBody( gentity_t *targ, gentity_t *attacker, vec3_t dir, int mod, int knockback ) {
line 379
;376:	static float	mass = 200;
;377:	vec3_t	kvel;
;378:
;379:	if ( !mass ) {
ADDRGP4 $293
INDIRF4
CNSTF4 0
NEF4 $294
line 383
;380:		char	info[ 1024 ];
;381:		static char	mapname[ 128 ];
;382:
;383:		trap_GetServerinfo( info, sizeof ( info ) );
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetServerinfo
CALLV
pop
line 384
;384:		strncpy( mapname, Info_ValueForKey( info, "mapname" ), sizeof ( mapname ) - 1 );
ADDRLP4 12
ARGP4
ADDRGP4 $297
ARGP4
ADDRLP4 1036
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $296
ARGP4
ADDRLP4 1036
INDIRP4
ARGP4
CNSTI4 127
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 385
;385:		mapname[ sizeof ( mapname ) - 1 ] = '\0';
ADDRGP4 $296+127
CNSTI1 0
ASGNI1
line 386
;386:	}
LABELV $294
line 388
;387:
;388:	if ( attacker->client && targ->freezeState ) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $299
ADDRFP4 0
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 0
EQI4 $299
line 389
;389:		if ( knockback ) {
ADDRFP4 16
INDIRI4
CNSTI4 0
EQI4 $301
line 390
;390:			VectorScale( dir, g_knockback.value * (float) knockback / mass, kvel );
ADDRLP4 12
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 16
ADDRFP4 16
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 20
ADDRGP4 $293
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRP4
INDIRF4
ADDRGP4 g_knockback+8
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDRLP4 20
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 g_knockback+8
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDRLP4 20
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 g_knockback+8
INDIRF4
ADDRFP4 16
INDIRI4
CVIF4 4
MULF4
ADDRGP4 $293
INDIRF4
DIVF4
MULF4
ASGNF4
line 391
;391:			if ( mass == 200 ) kvel[ 2 ] += 24;
ADDRGP4 $293
INDIRF4
CNSTF4 1128792064
NEF4 $308
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
LABELV $308
line 392
;392:			VectorAdd( targ->s.pos.trDelta, kvel, targ->s.pos.trDelta );
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ASGNF4
line 394
;393:
;394:			targ->s.pos.trType = TR_GRAVITY;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 5
ASGNI4
line 395
;395:			targ->s.pos.trTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 397
;396:
;397:			targ->pain_debounce_time = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 720
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 398
;398:		}
LABELV $301
line 399
;399:		if ( mod == MOD_GAUNTLET || mod == MOD_RAILGUN ) {
ADDRLP4 12
ADDRFP4 12
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 2
EQI4 $317
ADDRLP4 12
INDIRI4
CNSTI4 10
NEI4 $315
LABELV $317
line 400
;400:			FollowClient( targ, attacker );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 FollowClient
CALLV
pop
line 401
;401:		}
LABELV $315
line 402
;402:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $292
JUMPV
LABELV $299
line 404
;403:	}
;404:	return qfalse;
CNSTI4 0
RETI4
LABELV $292
endproc DamageBody 1040 12
export is_body
proc is_body 16 8
line 407
;405:}
;406:
;407:qboolean is_body( gentity_t *ent ) {
line 408
;408:	if ( !ent || !ent->inuse ) return qfalse;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $321
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $319
LABELV $321
CNSTI4 0
RETI4
ADDRGP4 $318
JUMPV
LABELV $319
line 409
;409:	return ( ent->classname && !Q_stricmp( ent->classname, "freezebody" ) );
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $324
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $322
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $324
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRGP4 $325
JUMPV
LABELV $324
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $325
ADDRLP4 4
INDIRI4
RETI4
LABELV $318
endproc is_body 16 8
export is_body_freeze
proc is_body_freeze 4 4
line 412
;410:}
;411:
;412:qboolean is_body_freeze( gentity_t *ent ) {
line 413
;413:	if ( is_body( ent ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 is_body
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $327
line 414
;414:		return ent->freezeState;
ADDRFP4 0
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
RETI4
ADDRGP4 $326
JUMPV
LABELV $327
line 416
;415:	}
;416:	return qfalse;
CNSTI4 0
RETI4
LABELV $326
endproc is_body_freeze 4 4
proc CopyToBody 52 8
line 472
;417:}
;418:
;419:#ifdef MISSIONPACK
;420:void G_ExplodeMissile( gentity_t *ent );
;421:
;422:static void ProximityMine_ExplodeOnBody( gentity_t *mine ) {
;423:	gentity_t	*body;
;424:
;425:	if ( !is_body_freeze( mine->enemy ) ) {
;426:		mine->think = G_FreeEntity;
;427:		mine->nextthink = level.time;
;428:		return;
;429:	}
;430:
;431:	body = mine->enemy;
;432:	body->s.eFlags &= ~EF_TICKING;
;433:
;434:	body->s.loopSound = 0;
;435:
;436:	G_SetOrigin( mine, body->s.pos.trBase );
;437:	mine->r.svFlags &= ~SVF_NOCLIENT;
;438:	mine->splashMethodOfDeath = MOD_PROXIMITY_MINE;
;439:	G_ExplodeMissile( mine );
;440:}
;441:
;442:void ProximityMine_Body( gentity_t *mine, gentity_t *body ) {
;443:	if ( mine->s.eFlags & EF_NODRAW )
;444:		return;
;445:
;446:	G_AddEvent( mine, EV_PROXIMITY_MINE_STICK, 0 );
;447:
;448:	if ( body->s.eFlags & EF_TICKING ) {
;449:		body->activator->splashDamage += mine->splashDamage;
;450:		body->activator->splashRadius *= 1.50;
;451:		mine->think = G_FreeEntity;
;452:		mine->nextthink = level.time;
;453:		return;
;454:	}
;455:
;456:	body->s.loopSound = G_SoundIndex( "sound/weapons/proxmine/wstbtick.wav" );
;457:
;458:	body->s.eFlags |= EF_TICKING;
;459:	body->activator = mine;
;460:
;461:	mine->s.eFlags |= EF_NODRAW;
;462:	mine->r.svFlags |= SVF_NOCLIENT;
;463:	mine->s.pos.trType = TR_LINEAR;
;464:	VectorClear( mine->s.pos.trDelta );
;465:
;466:	mine->enemy = body;
;467:	mine->think = ProximityMine_ExplodeOnBody;
;468:	mine->nextthink = level.time + 10 * 1000;
;469:}
;470:#endif
;471:
;472:static void CopyToBody( gentity_t *ent ) {
line 475
;473:	gentity_t	*body;
;474:
;475:	body = G_Spawn();
ADDRLP4 4
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 476
;476:	body->classname = "freezebody";
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $322
ASGNP4
line 477
;477:	body->s = ent->s;
ADDRLP4 0
INDIRP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 208
line 478
;478:	body->s.eFlags = 0;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 0
ASGNI4
line 479
;479:	if ( ent->s.eFlags & EF_KAMIKAZE ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $330
line 480
;480:		body->s.eFlags |= EF_KAMIKAZE;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 481
;481:	}
LABELV $330
line 482
;482:	body->s.powerups = 1 << PW_BATTLESUIT;
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTI4 4
ASGNI4
line 483
;483:	body->s.number = body - g_entities;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 896
DIVI4
ASGNI4
line 484
;484:	body->timestamp = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 640
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 485
;485:	body->physicsObject = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 564
ADDP4
CNSTI4 1
ASGNI4
line 487
;486:
;487:	G_SetOrigin( body, ent->r.currentOrigin );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 488
;488:	body->s.pos.trType = TR_GRAVITY;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 5
ASGNI4
line 489
;489:	body->s.pos.trTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 490
;490:	VectorCopy( ent->client->ps.velocity, body->s.pos.trDelta );
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRB
ASGNB 12
line 491
;491:	body->s.event = 0;
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
CNSTI4 0
ASGNI4
line 493
;492:
;493:	switch ( body->s.legsAnim & ~ANIM_TOGGLEBIT ) {
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 13
LTI4 $334
ADDRLP4 12
INDIRI4
CNSTI4 24
GTI4 $346
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $347-52
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $347
address $337
address $337
address $337
address $337
address $337
address $334
address $334
address $334
address $334
address $337
address $337
address $337
code
LABELV $346
ADDRLP4 12
INDIRI4
CNSTI4 32
EQI4 $337
ADDRLP4 12
INDIRI4
CNSTI4 33
EQI4 $337
ADDRGP4 $334
JUMPV
LABELV $337
line 504
;494:	case LEGS_WALKCR:
;495:	case LEGS_WALK:
;496:	case LEGS_RUN:
;497:	case LEGS_BACK:
;498:	case LEGS_SWIM:
;499:	case LEGS_IDLE:
;500:	case LEGS_IDLECR:
;501:	case LEGS_TURN:
;502:	case LEGS_BACKCR:
;503:	case LEGS_BACKWALK:
;504:		switch ( rand() % 4 ) {
ADDRLP4 28
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 28
INDIRI4
CNSTI4 4
MODI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
LTI4 $338
ADDRLP4 24
INDIRI4
CNSTI4 3
GTI4 $338
ADDRLP4 24
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $345
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $345
address $341
address $342
address $343
address $344
code
LABELV $341
line 506
;505:		case 0:
;506:			body->s.legsAnim = LEGS_JUMP;
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
CNSTI4 18
ASGNI4
line 507
;507:			break;
ADDRGP4 $339
JUMPV
LABELV $342
line 509
;508:		case 1:
;509:			body->s.legsAnim = LEGS_LAND;
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
CNSTI4 19
ASGNI4
line 510
;510:			break;
ADDRGP4 $339
JUMPV
LABELV $343
line 512
;511:		case 2:
;512:			body->s.legsAnim = LEGS_JUMPB;
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
CNSTI4 20
ASGNI4
line 513
;513:			break;
ADDRGP4 $339
JUMPV
LABELV $344
line 515
;514:		case 3:
;515:			body->s.legsAnim = LEGS_LANDB;
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
CNSTI4 21
ASGNI4
line 516
;516:			break;
LABELV $338
LABELV $339
line 518
;517:		}
;518:	}
LABELV $334
line 520
;519:
;520:	body->r.svFlags = ent->r.svFlags;
ADDRLP4 24
CNSTI4 424
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 521
;521:	VectorCopy( ent->r.mins, body->r.mins );
ADDRLP4 28
CNSTI4 436
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRB
ASGNB 12
line 522
;522:	VectorCopy( ent->r.maxs, body->r.maxs );
ADDRLP4 32
CNSTI4 448
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRB
ASGNB 12
line 523
;523:	VectorCopy( ent->r.absmin, body->r.absmin );
ADDRLP4 36
CNSTI4 464
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRB
ASGNB 12
line 524
;524:	VectorCopy( ent->r.absmax, body->r.absmax );
ADDRLP4 40
CNSTI4 476
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRB
ASGNB 12
line 526
;525:
;526:	body->clipmask = MASK_PLAYERSOLID;
ADDRLP4 0
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 33619969
ASGNI4
line 527
;527:	body->r.contents = CONTENTS_BODY;
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 33554432
ASGNI4
line 529
;528:
;529:	body->think = Body_think;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 Body_think
ASGNP4
line 530
;530:	body->nextthink = level.time + FRAMETIME;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 532
;531:
;532:	body->die = Body_die;
ADDRLP4 0
INDIRP4
CNSTI4 716
ADDP4
ADDRGP4 Body_die
ASGNP4
line 533
;533:	body->takedamage = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 1
ASGNI4
line 535
;534:
;535:	body->target_ent = ent;
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 536
;536:	ent->target_ent = body;
ADDRFP4 0
INDIRP4
CNSTI4 668
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 537
;537:	body->s.otherEntityNum = ent->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 539
;538:	//body->noise_index = G_SoundIndex( "sound/player/tankjr/jump1.wav" );
;539:	body->noise_index = G_SoundIndex( "*gasp.wav" );
ADDRGP4 $350
ARGP4
ADDRLP4 44
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 792
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
line 540
;540:	body->freezeState = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 888
ADDP4
CNSTI4 1
ASGNI4
line 541
;541:	body->spawnflags = ent->client->sess.sessionTeam;
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
ASGNI4
line 542
;542:	body->waterlevel = ent->waterlevel;
ADDRLP4 48
CNSTI4 788
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 543
;543:	body->count = 0;
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 0
ASGNI4
line 545
;544:
;545:	trap_LinkEntity( body );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 546
;546:}
LABELV $329
endproc CopyToBody 52 8
proc NearbyBody 40 12
line 548
;547:
;548:static qboolean NearbyBody( gentity_t *targ ) {
line 552
;549:	gentity_t	*spot;
;550:	vec3_t	delta;
;551:
;552:	if ( g_gametype.integer == GT_CTF ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $352
line 553
;553:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $351
JUMPV
LABELV $352
line 556
;554:	}
;555:
;556:	spot = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
ADDRGP4 $356
JUMPV
LABELV $355
line 557
;557:	while ( ( spot = G_Find( spot, FOFS( classname ), "freezebody" ) ) != NULL ) {
line 558
;558:		if ( !spot->freezeState ) continue;
ADDRLP4 0
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 0
NEI4 $358
ADDRGP4 $356
JUMPV
LABELV $358
line 559
;559:		if ( spot->spawnflags != targ->client->sess.sessionTeam ) continue;
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
EQI4 $360
ADDRGP4 $356
JUMPV
LABELV $360
line 560
;560:		VectorSubtract( spot->s.pos.trBase, targ->s.pos.trBase, delta );
ADDRLP4 20
CNSTI4 24
ASGNI4
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 28
CNSTI4 28
ASGNI4
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 32
CNSTI4 32
ASGNI4
ADDRLP4 4+8
ADDRLP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 561
;561:		if ( VectorLength( delta ) > 100 ) continue;
ADDRLP4 4
ARGP4
ADDRLP4 36
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 36
INDIRF4
CNSTF4 1120403456
LEF4 $364
ADDRGP4 $356
JUMPV
LABELV $364
line 562
;562:		if ( level.time - spot->timestamp > 400 ) {
ADDRGP4 level+40
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 640
ADDP4
INDIRI4
SUBI4
CNSTI4 400
LEI4 $366
line 563
;563:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $351
JUMPV
LABELV $366
line 565
;564:		}
;565:	}
LABELV $356
line 557
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 524
ARGI4
ADDRGP4 $322
ARGP4
ADDRLP4 16
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $355
line 566
;566:	return qfalse;
CNSTI4 0
RETI4
LABELV $351
endproc NearbyBody 40 12
export player_freeze
proc player_freeze 60 8
line 569
;567:}
;568:
;569:void player_freeze( gentity_t *self, gentity_t *attacker, int mod ) {
line 571
;570:
;571:	if ( g_gametype.integer < GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
GEI4 $370
line 573
;572:		//if we're not playing a team game, we're not playing freeze
;573:		return;
ADDRGP4 $369
JUMPV
LABELV $370
line 576
;574:	}
;575:
;576:	if ( self != attacker && (OnSameTeam(self, attacker) && !g_friendlyFire.integer) ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
EQU4 $373
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $373
ADDRGP4 g_friendlyFire+12
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $373
line 578
;577:		//can't freeze teammates without friendlyFire
;578:		return;
ADDRGP4 $369
JUMPV
LABELV $373
line 581
;579:	}
;580:
;581:	if ( self != attacker && g_gametype.integer == GT_CTF && redflag && blueflag ) {
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
EQU4 $376
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $376
ADDRLP4 16
CNSTU4 0
ASGNU4
ADDRGP4 redflag
CVPU4 4
ADDRLP4 16
INDIRU4
EQU4 $376
ADDRGP4 blueflag
CVPU4 4
ADDRLP4 16
INDIRU4
EQU4 $376
line 584
;582:		vec3_t	dist1, dist2;
;583:
;584:		VectorSubtract( redflag, self->s.pos.trBase, dist1 );
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
ADDRGP4 redflag
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 20+4
ADDRGP4 redflag+4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 20+8
ADDRGP4 redflag+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
SUBF4
ASGNF4
line 585
;585:		VectorSubtract( blueflag, self->s.pos.trBase, dist2 );
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
ADDRGP4 blueflag
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 32+4
ADDRGP4 blueflag+4
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 32+8
ADDRGP4 blueflag+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
SUBF4
ASGNF4
line 587
;586:
;587:		if ( self->client->sess.sessionTeam == TEAM_RED ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
CNSTI4 1
NEI4 $387
line 588
;588:			if ( VectorLength( dist1 ) < VectorLength( dist2 ) ) {
ADDRLP4 20
ARGP4
ADDRLP4 52
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 32
ARGP4
ADDRLP4 56
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
GEF4 $388
line 589
;589:				return;
ADDRGP4 $369
JUMPV
line 591
;590:			}
;591:		} else if ( self->client->sess.sessionTeam == TEAM_BLUE ) {
LABELV $387
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
CNSTI4 2
NEI4 $391
line 592
;592:			if ( VectorLength( dist2 ) < VectorLength( dist1 ) ) {
ADDRLP4 32
ARGP4
ADDRLP4 52
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 20
ARGP4
ADDRLP4 56
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
GEF4 $393
line 593
;593:				return;
ADDRGP4 $369
JUMPV
LABELV $393
line 595
;594:			}
;595:		}
LABELV $391
LABELV $388
line 596
;596:	}
LABELV $376
line 597
;597:	switch ( mod ) {
ADDRLP4 20
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $369
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
LTI4 $395
LABELV $398
ADDRLP4 28
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 14
LTI4 $395
ADDRLP4 28
INDIRI4
CNSTI4 23
GTI4 $395
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $399-56
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $399
address $369
address $395
address $395
address $369
address $369
address $395
address $395
address $369
address $395
address $369
code
line 610
;598:	case MOD_UNKNOWN:
;599:	case MOD_WATER:
;600:	case MOD_CRUSH:
;601:	case MOD_TELEFRAG:
;602:	//case MOD_FALLING:
;603:	//case MOD_SUICIDE:
;604:	case MOD_TARGET_LASER:
;605:	//case MOD_TRIGGER_HURT:
;606:#ifdef MISSIONPACK
;607:	case MOD_JUICED:
;608:#endif
;609:	case MOD_GRAPPLE:
;610:		return;
LABELV $395
line 613
;611:	}
;612:
;613:	CopyToBody( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CopyToBody
CALLV
pop
line 614
;614:	self->r.maxs[ 2 ] = -8;
ADDRFP4 0
INDIRP4
CNSTI4 456
ADDP4
CNSTF4 3238002688
ASGNF4
line 615
;615:	self->freezeState = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 888
ADDP4
CNSTI4 1
ASGNI4
line 616
;616:	self->freezeThawTime =  level.time + (g_freezeAutothawTime.integer * 1000);
ADDRFP4 0
INDIRP4
CNSTI4 884
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 1000
ADDRGP4 g_freezeAutothawTime+12
INDIRI4
MULI4
ADDI4
ASGNI4
line 617
;617:	check_time = ( level.time - 3000 ) + 200;
ADDRGP4 check_time
ADDRGP4 level+40
INDIRI4
CNSTI4 3000
SUBI4
CNSTI4 200
ADDI4
ASGNI4
line 619
;618:
;619:	self->takedamage = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 0
ASGNI4
line 620
;620:	self->s.eType = ET_INVISIBLE;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 10
ASGNI4
line 621
;621:	self->r.contents = 0;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 622
;622:	self->health = GIB_HEALTH;
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
CNSTI4 -40
ASGNI4
line 624
;623:
;624:	if ( attacker->client && self != attacker && NearbyBody( self ) ) {
ADDRLP4 32
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $404
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CVPU4 4
ADDRLP4 32
INDIRP4
CVPU4 4
EQU4 $404
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 NearbyBody
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $404
line 625
;625:		attacker->client->ps.persistant[ PERS_DEFEND_COUNT ]++;
ADDRLP4 44
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 292
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 626
;626:		attacker->client->ps.eFlags &= ~( EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 48
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 627
;627:		attacker->client->ps.eFlags |= EF_AWARD_DEFEND;
ADDRLP4 52
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTI4 65536
BORI4
ASGNI4
line 628
;628:		attacker->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRFP4 4
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
line 629
;629:	}
LABELV $404
line 630
;630:}
LABELV $369
endproc player_freeze 60 8
export team_wins
proc team_wins 40 12
line 636
;631:
;632:gentity_t *SelectRandomDeathmatchSpawnPoint( void );
;633:
;634:void Team_ForceGesture( int team );
;635:
;636:void team_wins( int team ) {
line 644
;637:	int	i;
;638:	gentity_t	*e;
;639:	char	*teamstr;
;640:	gentity_t	*spawnPoint;
;641:	gclient_t	*cl;
;642:	gentity_t	*te;
;643:
;644:	spawnPoint = SelectRandomDeathmatchSpawnPoint();
ADDRLP4 24
ADDRGP4 SelectRandomDeathmatchSpawnPoint
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 24
INDIRP4
ASGNP4
line 645
;645:	for ( i = 0; i < g_maxclients.integer; i++ ) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $411
JUMPV
LABELV $408
line 646
;646:		e = g_entities + i;
ADDRLP4 4
CNSTI4 896
ADDRLP4 8
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 647
;647:		cl = e->client;
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 648
;648:		if ( !e->inuse ) continue;
ADDRLP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $413
ADDRGP4 $409
JUMPV
LABELV $413
line 649
;649:		if ( e->freezeState ) {
ADDRLP4 4
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 0
EQI4 $415
line 651
;650:			if ( //(!( g_dmflags.integer & 128 ) || 
;651:				(cl->sess.sessionTeam != team && g_freezeRoundRespawn.integer) 
ADDRLP4 0
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
EQI4 $422
ADDRGP4 g_freezeRoundRespawn+12
INDIRI4
CNSTI4 0
NEI4 $421
LABELV $422
ADDRGP4 g_freezeRoundRespawn+12
INDIRI4
CNSTI4 0
NEI4 $409
LABELV $421
line 652
;652:				||!g_freezeRoundRespawn.integer ) {
line 654
;653:				//Body_Explode( e );
;654:				player_free( e );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 player_free
CALLV
pop
line 655
;655:			}
line 656
;656:			continue;
ADDRGP4 $409
JUMPV
LABELV $415
line 659
;657:		}
;658:		//FIXME:4Spike - make all moving clients reset.
;659:		if ( e->health < 1 ) continue;
ADDRLP4 4
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 1
GEI4 $423
ADDRGP4 $409
JUMPV
LABELV $423
line 660
;660:		if ( is_spectator( cl ) ) continue;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 is_spectator
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $425
ADDRGP4 $409
JUMPV
LABELV $425
line 662
;661:
;662:		if ( cl->ps.powerups[ PW_REDFLAG ] ) {
ADDRLP4 0
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
EQI4 $427
line 663
;663:			memset( cl->ps.powerups, 0, sizeof ( cl->ps.powerups ) );
ADDRLP4 0
INDIRP4
CNSTI4 312
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 664
;664:			cl->ps.powerups[ PW_REDFLAG ] = INT_MAX;
ADDRLP4 0
INDIRP4
CNSTI4 340
ADDP4
CNSTI4 2147483647
ASGNI4
line 665
;665:		} else if ( cl->ps.powerups[ PW_BLUEFLAG ] ) {
ADDRGP4 $428
JUMPV
LABELV $427
ADDRLP4 0
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $429
line 666
;666:			memset( cl->ps.powerups, 0, sizeof ( cl->ps.powerups ) );
ADDRLP4 0
INDIRP4
CNSTI4 312
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 667
;667:			cl->ps.powerups[ PW_BLUEFLAG ] = INT_MAX;
ADDRLP4 0
INDIRP4
CNSTI4 344
ADDP4
CNSTI4 2147483647
ASGNI4
line 668
;668:		} else if ( cl->ps.powerups[ PW_NEUTRALFLAG ] ) {
ADDRGP4 $430
JUMPV
LABELV $429
ADDRLP4 0
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $431
line 669
;669:			memset( cl->ps.powerups, 0, sizeof ( cl->ps.powerups ) );
ADDRLP4 0
INDIRP4
CNSTI4 312
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 670
;670:			cl->ps.powerups[ PW_NEUTRALFLAG ] = INT_MAX;
ADDRLP4 0
INDIRP4
CNSTI4 348
ADDP4
CNSTI4 2147483647
ASGNI4
line 671
;671:		} else {
ADDRGP4 $432
JUMPV
LABELV $431
line 672
;672:			memset( cl->ps.powerups, 0, sizeof ( cl->ps.powerups ) );
ADDRLP4 0
INDIRP4
CNSTI4 312
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 673
;673:		}
LABELV $432
LABELV $430
LABELV $428
line 674
;674:	}
LABELV $409
line 645
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $411
ADDRLP4 8
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $408
line 676
;675:
;676:	if ( level.numPlayingClients < 2 || g_gametype.integer == GT_CTF ) {
ADDRGP4 level+122
INDIRU1
CVUI4 1
CNSTI4 2
LTI4 $437
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $433
LABELV $437
line 677
;677:		return;
ADDRGP4 $407
JUMPV
LABELV $433
line 680
;678:	}
;679:
;680:	te = G_TempEntity( vec3_origin, EV_GLOBAL_TEAM_SOUND );
ADDRGP4 vec3_origin
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 28
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 28
INDIRP4
ASGNP4
line 681
;681:	if ( team == TEAM_RED ) {
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $438
line 682
;682:		teamstr = "Red";
ADDRLP4 12
ADDRGP4 $440
ASGNP4
line 683
;683:		te->s.eventParm = GTS_BLUE_CAPTURE;
ADDRLP4 16
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 1
ASGNI4
line 684
;684:		trap_SendServerCommand( -1, va( "cp \""S_COLOR_RED"%s"S_COLOR_WHITE " team scores!\n\"", teamstr ) );
ADDRGP4 $441
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 32
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 685
;685:	} else {
ADDRGP4 $439
JUMPV
LABELV $438
line 686
;686:		teamstr = "Blue";
ADDRLP4 12
ADDRGP4 $442
ASGNP4
line 687
;687:		te->s.eventParm = GTS_RED_CAPTURE;
ADDRLP4 16
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 0
ASGNI4
line 688
;688:		trap_SendServerCommand( -1, va( "cp \""S_COLOR_BLUE"%s"S_COLOR_WHITE " team scores!\n\"", teamstr ) );
ADDRGP4 $443
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 32
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 689
;689:	}
LABELV $439
line 690
;690:	te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 32
ADDRLP4 16
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 692
;691:	
;692:	trap_SendServerCommand( -1, va( "print \"%s team scores!\n\"", teamstr ) );
ADDRGP4 $444
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 694
;693:
;694:	if ( !level.warmupTime ) {
ADDRGP4 level+16
INDIRI4
CNSTI4 0
NEI4 $445
line 696
;695:		//Not in warmup
;696:	AddTeamScore( vec3_origin, team, 1 );
ADDRGP4 vec3_origin
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 AddTeamScore
CALLV
pop
line 697
;697:	}
LABELV $445
line 698
;698:	Team_ForceGesture( team );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 Team_ForceGesture
CALLV
pop
line 700
;699:
;700:	CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 701
;701:}
LABELV $407
endproc team_wins 40 12
proc CalculateScores 20 4
line 703
;702:
;703:static qboolean CalculateScores( int team ) {
line 706
;704:	int	i;
;705:	gentity_t	*e;
;706:	qboolean	modified = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 708
;707:
;708:	for ( i = 0; i < g_maxclients.integer; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $452
JUMPV
LABELV $449
line 709
;709:		e = g_entities + i;
ADDRLP4 0
CNSTI4 896
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 710
;710:		if ( !e->inuse ) continue;
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $454
ADDRGP4 $450
JUMPV
LABELV $454
line 711
;711:		if ( e->client->sess.sessionTeam != team ) continue;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
EQI4 $456
ADDRGP4 $450
JUMPV
LABELV $456
line 712
;712:		if ( e->freezeState ) {
ADDRLP4 0
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 0
EQI4 $458
line 713
;713:			modified = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 714
;714:			continue;
ADDRGP4 $450
JUMPV
LABELV $458
line 716
;715:		}
;716:		if ( e->client->pers.connected == CON_CONNECTING ) continue;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 1
NEI4 $460
ADDRGP4 $450
JUMPV
LABELV $460
line 717
;717:		if ( ( e->health < 1 || is_spectator( e->client ) ) && level.time > e->client->respawnTime ) continue;
ADDRLP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 1
LTI4 $465
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 is_spectator
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $462
LABELV $465
ADDRGP4 level+40
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10332
ADDP4
INDIRI4
LEI4 $462
ADDRGP4 $450
JUMPV
LABELV $462
line 718
;718:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $448
JUMPV
LABELV $450
line 708
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $452
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $449
line 720
;719:	}
;720:	if ( modified ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $466
line 721
;721:		team_wins( OtherTeam( team ) );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 OtherTeam
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 team_wins
CALLV
pop
line 722
;722:	}
LABELV $466
line 723
;723:	return modified;
ADDRLP4 8
INDIRI4
RETI4
LABELV $448
endproc CalculateScores 20 4
export CheckDelay
proc CheckDelay 20 4
line 726
;724:}
;725:
;726:void CheckDelay( void ) {
line 732
;727:	int	i;
;728:	gentity_t	*e;
;729:	int	readyMask;
;730:
;731:	//This is what's prevent 'round restarts' in warmup, maybe?
;732:	readyMask = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 733
;733:	for ( i = 0; i < g_maxclients.integer; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $472
JUMPV
LABELV $469
line 734
;734:		e = g_entities + i;
ADDRLP4 4
CNSTI4 896
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 735
;735:		if ( !e->inuse ) continue;
ADDRLP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $474
ADDRGP4 $470
JUMPV
LABELV $474
line 736
;736:		if ( level.warmupTime != 0 && !e->readyBegin ) continue;
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 level+16
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $476
ADDRLP4 4
INDIRP4
CNSTI4 892
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $476
ADDRGP4 $470
JUMPV
LABELV $476
line 737
;737:		if ( level.warmupTime == 0 && !e->freezeState ) continue;
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 level+16
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $479
ADDRLP4 4
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $479
ADDRGP4 $470
JUMPV
LABELV $479
line 738
;738:		if ( i < 16 ) {
ADDRLP4 0
INDIRI4
CNSTI4 16
GEI4 $482
line 739
;739:			readyMask |= 1 << i;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BORI4
ASGNI4
line 740
;740:		}
LABELV $482
line 741
;741:	}
LABELV $470
line 733
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $472
ADDRLP4 0
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $469
line 742
;742:	for ( i = 0; i < g_maxclients.integer; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $487
JUMPV
LABELV $484
line 743
;743:		e = g_entities + i;
ADDRLP4 4
CNSTI4 896
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 744
;744:		if ( !e->inuse ) continue;
ADDRLP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $489
ADDRGP4 $485
JUMPV
LABELV $489
line 745
;745:		e->client->ps.stats[ STAT_CLIENTS_READY ] = readyMask;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 204
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 746
;746:	}
LABELV $485
line 742
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $487
ADDRLP4 0
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $484
line 748
;747:
;748:	if ( check_time > level.time - 3000 ) {
ADDRGP4 check_time
INDIRI4
ADDRGP4 level+40
INDIRI4
CNSTI4 3000
SUBI4
LEI4 $491
line 749
;749:		return;
ADDRGP4 $468
JUMPV
LABELV $491
line 751
;750:	}
;751:	check_time = level.time;
ADDRGP4 check_time
ADDRGP4 level+40
INDIRI4
ASGNI4
line 753
;752:
;753:	if ( !CalculateScores( TEAM_RED ) ) {
CNSTI4 1
ARGI4
ADDRLP4 12
ADDRGP4 CalculateScores
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $495
line 754
;754:		CalculateScores( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 CalculateScores
CALLI4
pop
line 755
;755:	}
LABELV $495
line 756
;756:}
LABELV $468
endproc CheckDelay 20 4
export locationSpawn
proc locationSpawn 24 8
line 760
;757:
;758:void SP_target_location( gentity_t *self );
;759:
;760:void locationSpawn( gentity_t *ent, gitem_t *item ) {
line 763
;761:	gentity_t	*e;
;762:
;763:	switch ( item->giType ) {
ADDRLP4 4
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
CNSTI4 2
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 12
INDIRI4
LTI4 $498
ADDRLP4 4
INDIRI4
CNSTI4 8
GTI4 $498
ADDRLP4 4
INDIRI4
ADDRLP4 12
INDIRI4
LSHI4
ADDRGP4 $516-8
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $516
address $497
address $502
address $506
address $498
address $498
address $497
address $511
code
line 765
;764:	case IT_AMMO:
;765:		return;
LABELV $502
line 767
;766:	case IT_ARMOR:
;767:		if ( Q_stricmp( item->classname, "item_armor_shard" ) ) {
ADDRFP4 4
INDIRP4
INDIRP4
ARGP4
ADDRGP4 $505
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $497
line 768
;768:			break;
ADDRGP4 $499
JUMPV
line 770
;769:		}
;770:		return;
LABELV $506
line 772
;771:	case IT_HEALTH:
;772:		if ( !Q_stricmp( item->classname, "item_health_mega" ) ) {
ADDRFP4 4
INDIRP4
INDIRP4
ARGP4
ADDRGP4 $509
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $497
line 773
;773:			break;
ADDRGP4 $499
JUMPV
line 775
;774:		}
;775:		return;
line 777
;776:	case IT_PERSISTANT_POWERUP:
;777:		return;
LABELV $511
line 779
;778:	case IT_TEAM:
;779:		if ( item->giTag == PW_BLUEFLAG ) {
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 8
NEI4 $512
line 780
;780:			VectorCopy( ent->r.currentOrigin, blueflag );
ADDRGP4 blueflag
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 781
;781:		} else if ( item->giTag == PW_REDFLAG ) {
ADDRGP4 $513
JUMPV
LABELV $512
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 7
NEI4 $514
line 782
;782:			VectorCopy( ent->r.currentOrigin, redflag );
ADDRGP4 redflag
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 783
;783:		}
LABELV $514
LABELV $513
line 784
;784:	}
LABELV $498
LABELV $499
line 786
;785:
;786:	e = G_Spawn();
ADDRLP4 16
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 787
;787:	e->classname = "target_location";
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $518
ASGNP4
line 788
;788:	e->message = item->pickup_name;
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRP4
ASGNP4
line 789
;789:	e->count = 255;
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 255
ASGNI4
line 790
;790:	VectorCopy( ent->r.currentOrigin, e->s.origin );
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 792
;791:
;792:	SP_target_location( e );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 SP_target_location
CALLV
pop
line 793
;793:}
LABELV $497
endproc locationSpawn 24 8
export InvulnerabilityEffect
proc InvulnerabilityEffect 48 20
line 797
;794:
;795:int RaySphereIntersections( vec3_t origin, float radius, vec3_t point, vec3_t dir, vec3_t intersections[ 2 ] );
;796:
;797:int InvulnerabilityEffect( gentity_t *targ, vec3_t dir, vec3_t point, vec3_t impactpoint, vec3_t bouncedir ) {
line 801
;798:	vec3_t	intersections[ 2 ], vec;
;799:	int	n;
;800:
;801:	if ( !targ->freezeState ) {
ADDRFP4 0
INDIRP4
CNSTI4 888
ADDP4
INDIRI4
CNSTI4 0
NEI4 $520
line 802
;802:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $519
JUMPV
LABELV $520
line 804
;803:	}
;804:	VectorCopy( dir, vec );
ADDRLP4 0
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 805
;805:	VectorInverse( vec );
ADDRLP4 0
ARGP4
ADDRGP4 VectorInverse
CALLV
pop
line 806
;806:	n = RaySphereIntersections( targ->r.currentOrigin, 42, point, vec, intersections );
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ARGP4
CNSTF4 1109917696
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 40
ADDRGP4 RaySphereIntersections
CALLI4
ASGNI4
ADDRLP4 36
ADDRLP4 40
INDIRI4
ASGNI4
line 807
;807:	if ( n > 0 ) {
ADDRLP4 36
INDIRI4
CNSTI4 0
LEI4 $522
line 808
;808:		VectorSubtract( intersections[ 0 ], targ->r.currentOrigin, vec );
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 12+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
SUBF4
ASGNF4
line 809
;809:		if ( impactpoint ) {
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $528
line 810
;810:			VectorCopy( intersections[ 0 ], impactpoint );
ADDRFP4 12
INDIRP4
ADDRLP4 12
INDIRB
ASGNB 12
line 811
;811:		}
LABELV $528
line 812
;812:		if ( bouncedir ) {
ADDRFP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $530
line 813
;813:			VectorCopy( vec, bouncedir );
ADDRFP4 16
INDIRP4
ADDRLP4 0
INDIRB
ASGNB 12
line 814
;814:			VectorNormalize( bouncedir );
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 815
;815:		}
LABELV $530
line 816
;816:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $519
JUMPV
LABELV $522
line 818
;817:	}
;818:	return qfalse;
CNSTI4 0
RETI4
LABELV $519
endproc InvulnerabilityEffect 48 20
import RaySphereIntersections
import SP_target_location
import Team_ForceGesture
import SelectRandomDeathmatchSpawnPoint
import Kamikaze_DeathTimer
bss
align 4
LABELV blueflag
skip 12
align 4
LABELV redflag
skip 12
export check_time
align 4
LABELV check_time
skip 4
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
LABELV $518
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $509
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 95
byte 1 109
byte 1 101
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $505
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 95
byte 1 115
byte 1 104
byte 1 97
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $444
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 33
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $443
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 94
byte 1 52
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 33
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $442
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $441
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 94
byte 1 49
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 33
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $440
byte 1 82
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $350
byte 1 42
byte 1 103
byte 1 97
byte 1 115
byte 1 112
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $322
byte 1 102
byte 1 114
byte 1 101
byte 1 101
byte 1 122
byte 1 101
byte 1 98
byte 1 111
byte 1 100
byte 1 121
byte 1 0
align 1
LABELV $297
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $235
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 47
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 112
byte 1 97
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $200
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 85
byte 1 78
byte 1 75
byte 1 78
byte 1 79
byte 1 87
byte 1 78
byte 1 0
align 1
LABELV $199
byte 1 75
byte 1 105
byte 1 108
byte 1 108
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $156
byte 1 107
byte 1 97
byte 1 109
byte 1 105
byte 1 107
byte 1 97
byte 1 122
byte 1 101
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
