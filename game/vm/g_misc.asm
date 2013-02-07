export SP_info_camp
code
proc SP_info_camp 4 8
file "../g_misc.c"
line 16
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// g_misc.c
;4:
;5:#include "g_local.h"
;6:
;7:
;8:/*QUAKED func_group (0 0 0) ?
;9:Used to group brushes together just for editor convenience.  They are turned into normal brushes by the utilities.
;10:*/
;11:
;12:
;13:/*QUAKED info_camp (0 0.5 0) (-4 -4 -4) (4 4 4)
;14:Used as a positional target for calculations in the utilities (spotlights, etc), but removed during gameplay.
;15:*/
;16:void SP_info_camp( gentity_t *self ) {
line 17
;17:	G_SetOrigin( self, self->s.origin );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 18
;18:}
LABELV $67
endproc SP_info_camp 4 8
export SP_info_null
proc SP_info_null 0 4
line 24
;19:
;20:
;21:/*QUAKED info_null (0 0.5 0) (-4 -4 -4) (4 4 4)
;22:Used as a positional target for calculations in the utilities (spotlights, etc), but removed during gameplay.
;23:*/
;24:void SP_info_null( gentity_t *self ) {
line 25
;25:	G_FreeEntity( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 26
;26:}
LABELV $68
endproc SP_info_null 0 4
export SP_info_notnull
proc SP_info_notnull 4 8
line 33
;27:
;28:
;29:/*QUAKED info_notnull (0 0.5 0) (-4 -4 -4) (4 4 4)
;30:Used as a positional target for in-game calculation, like jumppad targets.
;31:target_position does the same thing
;32:*/
;33:void SP_info_notnull( gentity_t *self ){
line 34
;34:	G_SetOrigin( self, self->s.origin );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 35
;35:}
LABELV $69
endproc SP_info_notnull 4 8
export SP_light
proc SP_light 0 4
line 45
;36:
;37:
;38:/*QUAKED light (0 1 0) (-8 -8 -8) (8 8 8) linear
;39:Non-displayed light.
;40:"light" overrides the default 300 intensity.
;41:Linear checbox gives linear falloff instead of inverse square
;42:Lights pointed at a target will be spotlights.
;43:"radius" overrides the default 64 unit radius of a spotlight at the target point.
;44:*/
;45:void SP_light( gentity_t *self ) {
line 46
;46:	G_FreeEntity( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 47
;47:}
LABELV $70
endproc SP_light 0 4
export TeleportPlayer
proc TeleportPlayer 32 16
line 59
;48:
;49:
;50:
;51:/*
;52:=================================================================================
;53:
;54:TELEPORTERS
;55:
;56:=================================================================================
;57:*/
;58:
;59:void TeleportPlayer( gentity_t *player, vec3_t origin, vec3_t angles, qboolean spit ) {
line 67
;60:	gentity_t	*tent;
;61:
;62:	// use temp events at source and destination to prevent the effect
;63:	// from getting dropped by a second player event
;64:/*freeze
;65:	if ( player->client->sess.sessionTeam != TEAM_SPECTATOR ) {
;66:freeze*/
;67:	if ( (g_gamemode.integer > 3 && !is_spectator( player->client )) ||
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $77
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 is_spectator
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $76
LABELV $77
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 4
GEI4 $72
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
CNSTI4 3
EQI4 $72
LABELV $76
line 68
;68:		 (g_gamemode.integer < 4 && player->client->sess.sessionTeam != TEAM_SPECTATOR) ) {
line 70
;69://freeze
;70:		tent = G_TempEntity( player->client->ps.origin, EV_PLAYER_TELEPORT_OUT );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTI4 43
ARGI4
ADDRLP4 8
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 71
;71:		tent->s.clientNum = player->s.clientNum;
ADDRLP4 12
CNSTI4 168
ASGNI4
ADDRLP4 0
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
line 73
;72:
;73:		tent = G_TempEntity( origin, EV_PLAYER_TELEPORT_IN );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 42
ARGI4
ADDRLP4 16
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 74
;74:		tent->s.clientNum = player->s.clientNum;
ADDRLP4 20
CNSTI4 168
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 75
;75:	}
LABELV $72
line 79
;76:
;77:	// unlink to make sure it can't possibly interfere with G_KillBox
;78:	//player->relink = 0;
;79:	trap_UnlinkEntity (player);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 81
;80:
;81:	VectorCopy ( origin, player->client->ps.origin );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 82
;82:	player->client->ps.origin[2] += 1;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 85
;83:
;84:	// spit the player out
;85:	if (spit == qtrue) {
ADDRFP4 12
INDIRI4
CNSTI4 1
NEI4 $78
line 86
;86:		AngleVectors( angles, player->client->ps.velocity, NULL, NULL );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 12
CNSTP4 0
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 87
;87:		VectorScale( player->client->ps.velocity, 400, player->client->ps.velocity );
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTF4 1137180672
ADDRLP4 16
INDIRP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTF4 1137180672
ADDRLP4 20
INDIRP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTF4 1137180672
ADDRLP4 24
INDIRP4
INDIRF4
MULF4
ASGNF4
line 88
;88:		player->client->ps.pm_time = 160;		// hold time
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 160
ASGNI4
line 89
;89:		player->client->ps.pm_flags |= PMF_TIME_KNOCKBACK;
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 90
;90:	}
LABELV $78
line 93
;91:
;92:	// toggle the teleport bit so the client knows to not lerp
;93:	player->client->ps.eFlags ^= EF_TELEPORT_BIT;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 97
;94:
;95://unlagged - backward reconciliation #3
;96:	// we don't want players being backward-reconciled back through teleporters
;97:	G_ResetHistory( player );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_ResetHistory
CALLV
pop
line 101
;98://unlagged - backward reconciliation #3
;99:
;100:	// set angles
;101:	if (player->client->pers.fixedTeleporterAngles == qfalse)
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 620
ADDP4
INDIRI4
CNSTI4 0
NEI4 $80
line 102
;102:		SetClientViewAngle( player, angles );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 SetClientViewAngle
CALLV
pop
LABELV $80
line 108
;103:
;104:	// kill anything at the destination
;105:/*freeze
;106:	if ( player->client->sess.sessionTeam != TEAM_SPECTATOR ) {
;107:freeze*/
;108:	if ( (g_gamemode.integer > 3 && !is_spectator( player->client )) ||
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $87
ADDRFP4 0
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
EQI4 $86
LABELV $87
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 4
GEI4 $82
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
CNSTI4 3
EQI4 $82
LABELV $86
line 109
;109:		 (g_gamemode.integer < 4 && player->client->sess.sessionTeam != TEAM_SPECTATOR) ) {
line 111
;110://freeze
;111:		G_KillBox (player);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_KillBox
CALLV
pop
line 112
;112:	}
LABELV $82
line 115
;113:
;114:	// save results of pmove
;115:	BG_PlayerStateToEntityState( &player->client->ps, &player->s, qtrue );
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 118
;116:
;117:	// use the precise origin for linking
;118:	VectorCopy( player->client->ps.origin, player->r.currentOrigin );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 123
;119:
;120:/*freeze
;121:	if ( player->client->sess.sessionTeam != TEAM_SPECTATOR ) {
;122:freeze*/
;123:	if ( (g_gamemode.integer > 3 && !is_spectator( player->client )) ||
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $93
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 is_spectator
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $92
LABELV $93
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 4
GEI4 $88
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10188
ADDP4
INDIRI4
CNSTI4 3
EQI4 $88
LABELV $92
line 124
;124:		 (g_gamemode.integer < 4 && player->client->sess.sessionTeam != TEAM_SPECTATOR) ) {
line 126
;125://freeze
;126:		trap_LinkEntity (player);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 127
;127:	}
LABELV $88
line 128
;128:}
LABELV $71
endproc TeleportPlayer 32 16
export SP_misc_teleporter_dest
proc SP_misc_teleporter_dest 0 0
line 136
;129:
;130:
;131:/*QUAKED misc_teleporter_dest (1 0 0) (-32 -32 -24) (32 32 -16)
;132:Point teleporters at these.
;133:Now that we don't have teleport destination pads, this is just
;134:an info_notnull
;135:*/
;136:void SP_misc_teleporter_dest( gentity_t *ent ) {
line 137
;137:}
LABELV $94
endproc SP_misc_teleporter_dest 0 0
export SP_misc_model
proc SP_misc_model 0 4
line 145
;138:
;139:
;140://===========================================================
;141:
;142:/*QUAKED misc_model (1 0 0) (-16 -16 -16) (16 16 16)
;143:"model"		arbitrary .md3 file to display
;144:*/
;145:void SP_misc_model( gentity_t *ent ) {
line 156
;146:
;147:#if 0
;148:	ent->s.modelindex = G_ModelIndex( ent->model );
;149:	VectorSet (ent->mins, -16, -16, -16);
;150:	VectorSet (ent->maxs, 16, 16, 16);
;151:	trap_LinkEntity (ent);
;152:
;153:	G_SetOrigin( ent, ent->s.origin );
;154:	VectorCopy( ent->s.angles, ent->s.apos.trBase );
;155:#else
;156:	G_FreeEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 158
;157:#endif
;158:}
LABELV $95
endproc SP_misc_model 0 4
export locateCamera
proc locateCamera 52 8
line 162
;159:
;160://===========================================================
;161:
;162:void locateCamera( gentity_t *ent ) {
line 167
;163:	vec3_t		dir;
;164:	gentity_t	*target;
;165:	gentity_t	*owner;
;166:
;167:	owner = G_PickTarget( ent->target );
ADDRFP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 G_PickTarget
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 168
;168:	if ( !owner ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $97
line 169
;169:		G_Printf( "Couldn't find target for misc_partal_surface\n" );
ADDRGP4 $99
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 170
;170:		G_FreeEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 171
;171:		return;
ADDRGP4 $96
JUMPV
LABELV $97
line 173
;172:	}
;173:	ent->r.ownerNum = owner->s.number;
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 176
;174:
;175:	// frame holds the rotate speed
;176:	if ( owner->spawnflags & 1 ) {
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $100
line 177
;177:		ent->s.frame = 25;
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 25
ASGNI4
line 178
;178:	} else if ( owner->spawnflags & 2 ) {
ADDRGP4 $101
JUMPV
LABELV $100
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $102
line 179
;179:		ent->s.frame = 75;
ADDRFP4 0
INDIRP4
CNSTI4 172
ADDP4
CNSTI4 75
ASGNI4
line 180
;180:	}
LABELV $102
LABELV $101
line 183
;181:
;182:	// swing camera ?
;183:	if ( owner->spawnflags & 4 ) {
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $104
line 185
;184:		// set to 0 for no rotation at all
;185:		ent->s.powerups = 0;
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTI4 0
ASGNI4
line 186
;186:	}
ADDRGP4 $105
JUMPV
LABELV $104
line 187
;187:	else {
line 188
;188:		ent->s.powerups = 1;
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTI4 1
ASGNI4
line 189
;189:	}
LABELV $105
line 192
;190:
;191:	// clientNum holds the rotate offset
;192:	ent->s.clientNum = owner->s.clientNum;
ADDRLP4 24
CNSTI4 168
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 194
;193:
;194:	VectorCopy( owner->s.origin, ent->s.origin2 );
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 197
;195:
;196:	// see if the portal_camera has a target
;197:	target = G_PickTarget( owner->target );
ADDRLP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 G_PickTarget
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 28
INDIRP4
ASGNP4
line 198
;198:	if ( target ) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $106
line 199
;199:		VectorSubtract( target->s.origin, owner->s.origin, dir );
ADDRLP4 36
CNSTI4 92
ASGNI4
ADDRLP4 4
ADDRLP4 16
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
ADDRLP4 44
CNSTI4 96
ASGNI4
ADDRLP4 4+4
ADDRLP4 16
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 48
CNSTI4 100
ASGNI4
ADDRLP4 4+8
ADDRLP4 16
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 200
;200:		VectorNormalize( dir );
ADDRLP4 4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 201
;201:	} else {
ADDRGP4 $107
JUMPV
LABELV $106
line 202
;202:		G_SetMovedir( owner->s.angles, dir );
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_SetMovedir
CALLV
pop
line 203
;203:	}
LABELV $107
line 205
;204:
;205:	ent->s.eventParm = DirToByte( dir );
ADDRLP4 4
ARGP4
ADDRLP4 32
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 32
INDIRI4
ASGNI4
line 206
;206:}
LABELV $96
endproc locateCamera 52 8
export SP_misc_portal_surface
proc SP_misc_portal_surface 20 4
line 212
;207:
;208:/*QUAKED misc_portal_surface (0 0 1) (-8 -8 -8) (8 8 8)
;209:The portal surface nearest this entity will show a view from the targeted misc_portal_camera, or a mirror view if untargeted.
;210:This must be within 64 world units of the surface!
;211:*/
;212:void SP_misc_portal_surface(gentity_t *ent) {
line 213
;213:	VectorClear( ent->r.mins );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 444
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 440
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 214
;214:	VectorClear( ent->r.maxs );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
CNSTF4 0
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 456
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 452
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 448
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
line 215
;215:	trap_LinkEntity (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 217
;216:
;217:	ent->r.svFlags = SVF_PORTAL;
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 64
ASGNI4
line 218
;218:	ent->s.eType = ET_PORTAL;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 6
ASGNI4
line 220
;219:
;220:	if ( !ent->target ) {
ADDRFP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $111
line 221
;221:		VectorCopy( ent->s.origin, ent->s.origin2 );
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 222
;222:	} else {
ADDRGP4 $112
JUMPV
LABELV $111
line 223
;223:		ent->think = locateCamera;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 locateCamera
ASGNP4
line 224
;224:		ent->nextthink = level.time + 100;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 225
;225:	}
LABELV $112
line 226
;226:}
LABELV $110
endproc SP_misc_portal_surface 20 4
export SP_misc_portal_camera
proc SP_misc_portal_camera 20 12
line 232
;227:
;228:/*QUAKED misc_portal_camera (0 0 1) (-8 -8 -8) (8 8 8) slowrotate fastrotate noswing
;229:The target for a misc_portal_director.  You can set either angles or target another entity to determine the direction of view.
;230:"roll" an angle modifier to orient the camera around the target vector;
;231:*/
;232:void SP_misc_portal_camera(gentity_t *ent) {
line 235
;233:	float	roll;
;234:
;235:	VectorClear( ent->r.mins );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 444
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 440
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 436
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
line 236
;236:	VectorClear( ent->r.maxs );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
CNSTF4 0
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 456
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 452
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 448
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
line 237
;237:	trap_LinkEntity (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 239
;238:
;239:	G_SpawnFloat( "roll", "0", &roll );
ADDRGP4 $115
ARGP4
ADDRGP4 $116
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnFloat
CALLI4
pop
line 241
;240:
;241:	ent->s.clientNum = roll/360.0 * 256;
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
CNSTF4 1132462080
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
DIVF4
MULF4
CVFI4 4
ASGNI4
line 242
;242:}
LABELV $114
endproc SP_misc_portal_camera 20 12
export Use_Shooter
proc Use_Shooter 76 12
line 252
;243:
;244:/*
;245:======================================================================
;246:
;247:  SHOOTERS
;248:
;249:======================================================================
;250:*/
;251:
;252:void Use_Shooter( gentity_t *ent, gentity_t *other, gentity_t *activator ) {
line 258
;253:	vec3_t		dir;
;254:	float		deg;
;255:	vec3_t		up, right;
;256:
;257:	// see if we have a target
;258:	if ( ent->enemy ) {
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $118
line 259
;259:		VectorSubtract( ent->enemy->r.currentOrigin, ent->s.origin, dir );
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
ADDRLP4 40
INDIRP4
CNSTI4 768
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 44
INDIRP4
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 44
INDIRP4
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 48
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 260
;260:		VectorNormalize( dir );
ADDRLP4 0
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 261
;261:	} else {
ADDRGP4 $119
JUMPV
LABELV $118
line 262
;262:		VectorCopy( ent->movedir, dir );
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 676
ADDP4
INDIRB
ASGNB 12
line 263
;263:	}
LABELV $119
line 266
;264:
;265:	// randomize a bit
;266:	PerpendicularVector( up, dir );
ADDRLP4 16
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 PerpendicularVector
CALLV
pop
line 267
;267:	CrossProduct( up, dir, right );
ADDRLP4 16
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 28
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 269
;268:
;269:	deg = crandom() * ent->random;
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12
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
ADDRFP4 0
INDIRP4
CNSTI4 800
ADDP4
INDIRF4
MULF4
ASGNF4
line 270
;270:	VectorMA( dir, deg, up, dir );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 16+4
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 16+8
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
line 272
;271:
;272:	deg = crandom() * ent->random;
ADDRLP4 48
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12
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
ADDRFP4 0
INDIRP4
CNSTI4 800
ADDP4
INDIRF4
MULF4
ASGNF4
line 273
;273:	VectorMA( dir, deg, right, dir );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 28
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 28+4
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 28+8
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
line 275
;274:
;275:	VectorNormalize( dir );
ADDRLP4 0
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 277
;276:
;277:	switch ( ent->s.weapon ) {
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 4
EQI4 $137
ADDRLP4 56
INDIRI4
CNSTI4 5
EQI4 $138
ADDRLP4 56
INDIRI4
CNSTI4 8
EQI4 $139
ADDRGP4 $134
JUMPV
LABELV $137
line 279
;278:	case WP_GRENADE_LAUNCHER:
;279:		fire_grenade( ent, ent->s.origin, dir );
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 fire_grenade
CALLP4
pop
line 280
;280:		break;
ADDRGP4 $135
JUMPV
LABELV $138
line 282
;281:	case WP_ROCKET_LAUNCHER:
;282:		fire_rocket( ent, ent->s.origin, dir );
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 fire_rocket
CALLP4
pop
line 283
;283:		break;
ADDRGP4 $135
JUMPV
LABELV $139
line 285
;284:	case WP_PLASMAGUN:
;285:		fire_plasma( ent, ent->s.origin, dir );
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 fire_plasma
CALLP4
pop
line 286
;286:		break;
LABELV $134
LABELV $135
line 289
;287:	}
;288:
;289:	G_AddEvent( ent, EV_FIRE_WEAPON, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 23
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 290
;290:}
LABELV $117
endproc Use_Shooter 76 12
proc InitShooter_Finish 8 4
line 293
;291:
;292:
;293:static void InitShooter_Finish( gentity_t *ent ) {
line 294
;294:	ent->enemy = G_PickTarget( ent->target );
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 G_PickTarget
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 768
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 295
;295:	ent->think = 0;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
CNSTP4 0
ASGNP4
line 296
;296:	ent->nextthink = 0;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
CNSTI4 0
ASGNI4
line 297
;297:}
LABELV $140
endproc InitShooter_Finish 8 4
export InitShooter
proc InitShooter 16 8
line 299
;298:
;299:void InitShooter( gentity_t *ent, int weapon ) {
line 300
;300:	ent->use = Use_Shooter;
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
ADDRGP4 Use_Shooter
ASGNP4
line 301
;301:	ent->s.weapon = weapon;
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 303
;302:
;303:	RegisterItem( BG_FindItemForWeapon( weapon ) );
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 RegisterItem
CALLV
pop
line 305
;304:
;305:	G_SetMovedir( ent->s.angles, ent->movedir );
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 676
ADDP4
ARGP4
ADDRGP4 G_SetMovedir
CALLV
pop
line 307
;306:
;307:	if ( !ent->random ) {
ADDRFP4 0
INDIRP4
CNSTI4 800
ADDP4
INDIRF4
CNSTF4 0
NEF4 $142
line 308
;308:		ent->random = 1.0;
ADDRFP4 0
INDIRP4
CNSTI4 800
ADDP4
CNSTF4 1065353216
ASGNF4
line 309
;309:	}
LABELV $142
line 310
;310:	ent->random = sin( M_PI * ent->random / 180 );
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 800
ADDP4
ASGNP4
CNSTF4 1078530011
ADDRLP4 8
INDIRP4
INDIRF4
MULF4
CNSTF4 1127481344
DIVF4
ARGF4
ADDRLP4 12
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 8
INDIRP4
ADDRLP4 12
INDIRF4
ASGNF4
line 312
;311:	// target might be a moving object, so we can't set movedir for it
;312:	if ( ent->target ) {
ADDRFP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $144
line 313
;313:		ent->think = InitShooter_Finish;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 InitShooter_Finish
ASGNP4
line 314
;314:		ent->nextthink = level.time + 500;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 315
;315:	}
LABELV $144
line 316
;316:	trap_LinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 317
;317:}
LABELV $141
endproc InitShooter 16 8
export SP_shooter_rocket
proc SP_shooter_rocket 0 8
line 323
;318:
;319:/*QUAKED shooter_rocket (1 0 0) (-16 -16 -16) (16 16 16)
;320:Fires at either the target or the current direction.
;321:"random" the number of degrees of deviance from the taget. (1.0 default)
;322:*/
;323:void SP_shooter_rocket( gentity_t *ent ) {
line 324
;324:	InitShooter( ent, WP_ROCKET_LAUNCHER );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 InitShooter
CALLV
pop
line 325
;325:}
LABELV $147
endproc SP_shooter_rocket 0 8
export SP_shooter_plasma
proc SP_shooter_plasma 0 8
line 331
;326:
;327:/*QUAKED shooter_plasma (1 0 0) (-16 -16 -16) (16 16 16)
;328:Fires at either the target or the current direction.
;329:"random" is the number of degrees of deviance from the taget. (1.0 default)
;330:*/
;331:void SP_shooter_plasma( gentity_t *ent ) {
line 332
;332:	InitShooter( ent, WP_PLASMAGUN);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 8
ARGI4
ADDRGP4 InitShooter
CALLV
pop
line 333
;333:}
LABELV $148
endproc SP_shooter_plasma 0 8
export SP_shooter_grenade
proc SP_shooter_grenade 0 8
line 339
;334:
;335:/*QUAKED shooter_grenade (1 0 0) (-16 -16 -16) (16 16 16)
;336:Fires at either the target or the current direction.
;337:"random" is the number of degrees of deviance from the taget. (1.0 default)
;338:*/
;339:void SP_shooter_grenade( gentity_t *ent ) {
line 340
;340:	InitShooter( ent, WP_GRENADE_LAUNCHER);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 InitShooter
CALLV
pop
line 341
;341:}
LABELV $149
endproc SP_shooter_grenade 0 8
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
LABELV $116
byte 1 48
byte 1 0
align 1
LABELV $115
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $99
byte 1 67
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 102
byte 1 105
byte 1 110
byte 1 100
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 95
byte 1 112
byte 1 97
byte 1 114
byte 1 116
byte 1 97
byte 1 108
byte 1 95
byte 1 115
byte 1 117
byte 1 114
byte 1 102
byte 1 97
byte 1 99
byte 1 101
byte 1 10
byte 1 0
