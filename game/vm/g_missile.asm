export G_BounceMissile
code
proc G_BounceMissile 40 12
file "../g_missile.c"
line 14
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:#include "g_local.h"
;4:#include "bg_promode.h"
;5:
;6:#define	MISSILE_PRESTEP_TIME	50
;7:
;8:/*
;9:================
;10:G_BounceMissile
;11:
;12:================
;13:*/
;14:void G_BounceMissile( gentity_t *ent, trace_t *trace ) {
line 20
;15:	vec3_t	velocity;
;16:	float	dot;
;17:	int		hitTime;
;18:
;19:	// reflect the velocity on the trace plane
;20:	hitTime = level.previousTime + ( level.time - level.previousTime ) * trace->fraction;
ADDRLP4 16
ADDRGP4 level+44
INDIRI4
CVIF4 4
ADDRGP4 level+40
INDIRI4
ADDRGP4 level+44
INDIRI4
SUBI4
CVIF4 4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 21
;21:	BG_EvaluateTrajectoryDelta( &ent->s.pos, hitTime, velocity );
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BG_EvaluateTrajectoryDelta
CALLV
pop
line 22
;22:	dot = DotProduct( velocity, trace->plane.normal );
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 23
;23:	VectorMA( velocity, -2*dot, trace->plane.normal, ent->s.pos.trDelta );
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 0
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
CNSTF4 3221225472
ADDRLP4 12
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 0+4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 3221225472
ADDRLP4 12
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 0+8
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
CNSTF4 3221225472
ADDRLP4 12
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 25
;24:
;25:	if ( ent->s.eFlags & EF_BOUNCE_HALF ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $75
line 26
;26:		VectorScale( ent->s.pos.trDelta, 0.65, ent->s.pos.trDelta );
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTF4 1059481190
ADDRLP4 24
INDIRP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTF4 1059481190
ADDRLP4 28
INDIRP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTF4 1059481190
ADDRLP4 32
INDIRP4
INDIRF4
MULF4
ASGNF4
line 28
;27:		// check for stop
;28:		if ( trace->plane.normal[2] > 0.2 && VectorLength( ent->s.pos.trDelta ) < 40 ) {
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
CNSTF4 1045220557
LEF4 $77
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 36
INDIRF4
CNSTF4 1109393408
GEF4 $77
line 29
;29:			G_SetOrigin( ent, trace->endpos );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 30
;30:			return;
ADDRGP4 $67
JUMPV
LABELV $77
line 32
;31:		}
;32:	}
LABELV $75
line 34
;33:
;34:	VectorAdd( ent->r.currentOrigin, trace->plane.normal, ent->r.currentOrigin);
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 492
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDF4
ASGNF4
line 35
;35:	VectorCopy( ent->r.currentOrigin, ent->s.pos.trBase );
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 36
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 36
;36:	ent->s.pos.trTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+40
INDIRI4
ASGNI4
line 37
;37:}
LABELV $67
endproc G_BounceMissile 40 12
export G_ExplodeMissile
proc G_ExplodeMissile 44 24
line 47
;38:
;39:
;40:/*
;41:================
;42:G_ExplodeMissile
;43:
;44:Explode a missile without an impact
;45:================
;46:*/
;47:void G_ExplodeMissile( gentity_t *ent ) {
line 51
;48:	vec3_t		dir;
;49:	vec3_t		origin;
;50:
;51:	BG_EvaluateTrajectory( &ent->s.pos, level.time, origin );
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 level+40
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 52
;52:	SnapVector( origin );
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
line 53
;53:	G_SetOrigin( ent, origin );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 56
;54:
;55:	// we don't have a valid direction, so just point straight up
;56:	dir[0] = dir[1] = 0;
ADDRLP4 24
CNSTF4 0
ASGNF4
ADDRLP4 12+4
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 24
INDIRF4
ASGNF4
line 57
;57:	dir[2] = 1;
ADDRLP4 12+8
CNSTF4 1065353216
ASGNF4
line 59
;58:
;59:	ent->s.eType = ET_GENERAL;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 60
;60:	G_AddEvent( ent, EV_MISSILE_MISS, DirToByte( dir ) );
ADDRLP4 12
ARGP4
ADDRLP4 28
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 51
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 62
;61:
;62:	ent->freeAfterEvent = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 1
ASGNI4
line 65
;63:
;64:	// splash damage
;65:	if ( ent->splashDamage ) {
ADDRFP4 0
INDIRP4
CNSTI4 744
ADDP4
INDIRI4
CNSTI4 0
EQI4 $88
line 66
;66:		if( G_RadiusDamage( ent->r.currentOrigin, ent->parent, ent->splashDamage, ent->splashRadius, ent
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 600
ADDP4
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 744
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 748
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 756
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 G_RadiusDamage
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $90
line 67
;67:			, ent->splashMethodOfDeath ) ) {
line 68
;68:			g_entities[ent->r.ownerNum].client->accuracy_hits++;
ADDRLP4 40
CNSTI4 896
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 10316
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 69
;69:		}
LABELV $90
line 70
;70:	}
LABELV $88
line 72
;71:
;72:	trap_LinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 73
;73:}
LABELV $80
endproc G_ExplodeMissile 44 24
export G_MissileImpact
proc G_MissileImpact 68 32
line 253
;74:
;75:
;76:#ifdef MISSIONPACK
;77:/*
;78:================
;79:ProximityMine_Explode
;80:================
;81:*/
;82:static void ProximityMine_Explode( gentity_t *mine ) {
;83:	G_ExplodeMissile( mine );
;84:	// if the prox mine has a trigger free it
;85:	if (mine->activator) {
;86:		G_FreeEntity(mine->activator);
;87:		mine->activator = NULL;
;88:	}
;89:}
;90:
;91:/*
;92:================
;93:ProximityMine_Die
;94:================
;95:*/
;96:static void ProximityMine_Die( gentity_t *ent, gentity_t *inflictor, gentity_t *attacker, int damage, int mod ) {
;97:	ent->think = ProximityMine_Explode;
;98:	ent->nextthink = level.time + 1;
;99:}
;100:
;101:/*
;102:================
;103:ProximityMine_Trigger
;104:================
;105:*/
;106:void ProximityMine_Trigger( gentity_t *trigger, gentity_t *other, trace_t *trace ) {
;107:	vec3_t		v;
;108:	gentity_t	*mine;
;109:
;110:	if( !other->client ) {
;111:		return;
;112:	}
;113:
;114:	// trigger is a cube, do a distance test now to act as if it's a sphere
;115:	VectorSubtract( trigger->s.pos.trBase, other->s.pos.trBase, v );
;116:	if( VectorLength( v ) > trigger->parent->splashRadius ) {
;117:		return;
;118:	}
;119:
;120:
;121:	if ( g_gametype.integer >= GT_TEAM ) {
;122:		// don't trigger same team mines
;123:		if (trigger->parent->s.generic1 == other->client->sess.sessionTeam) {
;124:			return;
;125:		}
;126:	}
;127:
;128:	// ok, now check for ability to damage so we don't get triggered thru walls, closed doors, etc...
;129:	if( !CanDamage( other, trigger->s.pos.trBase ) ) {
;130:		return;
;131:	}
;132:
;133:	// trigger the mine!
;134:	mine = trigger->parent;
;135:	mine->s.loopSound = 0;
;136:	G_AddEvent( mine, EV_PROXIMITY_MINE_TRIGGER, 0 );
;137:	mine->nextthink = level.time + 500;
;138:
;139:	G_FreeEntity( trigger );
;140:}
;141:
;142:/*
;143:================
;144:ProximityMine_Activate
;145:================
;146:*/
;147:static void ProximityMine_Activate( gentity_t *ent ) {
;148:	gentity_t	*trigger;
;149:	float		r;
;150:
;151:	ent->think = ProximityMine_Explode;
;152:	ent->nextthink = level.time + g_proxMineTimeout.integer;
;153:
;154:	ent->takedamage = qtrue;
;155:	ent->health = 1;
;156:	ent->die = ProximityMine_Die;
;157:
;158:	ent->s.loopSound = G_SoundIndex( "sound/weapons/proxmine/wstbtick.wav" );
;159:
;160:	// build the proximity trigger
;161:	trigger = G_Spawn ();
;162:
;163:	trigger->classname = "proxmine_trigger";
;164:
;165:	r = ent->splashRadius;
;166:	VectorSet( trigger->r.mins, -r, -r, -r );
;167:	VectorSet( trigger->r.maxs, r, r, r );
;168:
;169:	G_SetOrigin( trigger, ent->s.pos.trBase );
;170:
;171:	trigger->parent = ent;
;172:	trigger->r.contents = CONTENTS_TRIGGER;
;173:	trigger->touch = ProximityMine_Trigger;
;174:
;175:	trap_LinkEntity (trigger);
;176:
;177:	// set pointer to trigger so the entity can be freed when the mine explodes
;178:	ent->activator = trigger;
;179:}
;180:
;181:/*
;182:================
;183:ProximityMine_ExplodeOnPlayer
;184:================
;185:*/
;186:static void ProximityMine_ExplodeOnPlayer( gentity_t *mine ) {
;187:	gentity_t	*player;
;188:
;189:	player = mine->enemy;
;190:	player->client->ps.eFlags &= ~EF_TICKING;
;191:
;192:	if ( player->client->invulnerabilityTime > level.time ) {
;193:		G_Damage( player, mine->parent, mine->parent, vec3_origin, mine->s.origin, 1000, DAMAGE_NO_KNOCKBACK, MOD_JUICED );
;194:		player->client->invulnerabilityTime = 0;
;195:		G_TempEntity( player->client->ps.origin, EV_JUICED );
;196:	}
;197:	else {
;198:		G_SetOrigin( mine, player->s.pos.trBase );
;199:		// make sure the explosion gets to the client
;200:		mine->r.svFlags &= ~SVF_NOCLIENT;
;201:		mine->splashMethodOfDeath = MOD_PROXIMITY_MINE;
;202:		G_ExplodeMissile( mine );
;203:	}
;204:}
;205:
;206:/*
;207:================
;208:ProximityMine_Player
;209:================
;210:*/
;211:static void ProximityMine_Player( gentity_t *mine, gentity_t *player ) {
;212:	if( mine->s.eFlags & EF_NODRAW ) {
;213:		return;
;214:	}
;215:
;216:	G_AddEvent( mine, EV_PROXIMITY_MINE_STICK, 0 );
;217:
;218:	if( player->s.eFlags & EF_TICKING ) {
;219:		player->activator->splashDamage += mine->splashDamage;
;220:		player->activator->splashRadius *= 1.50;
;221:		mine->think = G_FreeEntity;
;222:		mine->nextthink = level.time;
;223:		return;
;224:	}
;225:
;226:	player->client->ps.eFlags |= EF_TICKING;
;227:	player->activator = mine;
;228:
;229:	mine->s.eFlags |= EF_NODRAW;
;230:	mine->r.svFlags |= SVF_NOCLIENT;
;231:	mine->s.pos.trType = TR_LINEAR;
;232:	VectorClear( mine->s.pos.trDelta );
;233:
;234:	mine->enemy = player;
;235:	mine->think = ProximityMine_ExplodeOnPlayer;
;236:	if ( player->client->invulnerabilityTime > level.time ) {
;237:		mine->nextthink = level.time + 2 * 1000;
;238:	}
;239:	else {
;240:		mine->nextthink = level.time + 10 * 1000;
;241:	}
;242:}
;243://freeze
;244:void ProximityMine_Body( gentity_t *mine, gentity_t *body );
;245://freeze
;246:#endif
;247:
;248:/*
;249:================
;250:G_MissileImpact
;251:================
;252:*/
;253:void G_MissileImpact( gentity_t *ent, trace_t *trace ) {
line 255
;254:	gentity_t		*other;
;255:	qboolean		hitClient = qfalse;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 266
;256:#ifdef MISSIONPACK
;257:	vec3_t			forward, impactpoint, bouncedir;
;258:	int				eFlags;
;259://freeze
;260:#else
;261:	//vec3_t	forward, impactpoint, bouncedir;
;262:	//int	eFlags;
;263://freeze
;264:#endif
;265:	vec3_t			vec2; // CPM
;266:	other = &g_entities[trace->entityNum];
ADDRLP4 0
CNSTI4 896
ADDRFP4 4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 269
;267:
;268:	// CPM: copy velocity for special radius damage
;269:	BG_EvaluateTrajectoryDelta( &ent->s.pos, level.time, vec2);
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 level+40
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BG_EvaluateTrajectoryDelta
CALLV
pop
line 273
;270:	// !CPM
;271:
;272:	// check for bounce
;273:	if ( !other->takedamage &&
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
NEI4 $95
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 48
BANDI4
ADDRLP4 20
INDIRI4
EQI4 $95
line 274
;274:		( ent->s.eFlags & ( EF_BOUNCE | EF_BOUNCE_HALF ) ) ) {
line 275
;275:		G_BounceMissile( ent, trace );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 G_BounceMissile
CALLV
pop
line 276
;276:		G_AddEvent( ent, EV_GRENADE_BOUNCE, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 44
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 277
;277:		return;
ADDRGP4 $93
JUMPV
LABELV $95
line 304
;278:	}
;279:
;280:#ifdef MISSIONPACK
;281:	if ( other->takedamage ) {
;282:		if ( G_AllowEntityInteraction(other, ent) )
;283:		{
;284:		if ( ent->s.weapon != WP_PROX_LAUNCHER ) {
;285:			if ( other->client && other->client->invulnerabilityTime > level.time ) {
;286:				//
;287:				VectorCopy( ent->s.pos.trDelta, forward );
;288:				VectorNormalize( forward );
;289:				if (G_InvulnerabilityEffect( other, forward, ent->s.pos.trBase, impactpoint, bouncedir )) {
;290:					VectorCopy( bouncedir, trace->plane.normal );
;291:					eFlags = ent->s.eFlags & EF_BOUNCE_HALF;
;292:					ent->s.eFlags &= ~EF_BOUNCE_HALF;
;293:					G_BounceMissile( ent, trace );
;294:					ent->s.eFlags |= eFlags;
;295:				}
;296:				ent->target_ent = other;
;297:				return;
;298:			}
;299:		}
;300:	}
;301:	}
;302:#endif
;303:	// impact damage
;304:	if (other->takedamage) {
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
EQI4 $97
line 308
;305:		// FIXME: wrong damage direction?
;306:		//if ( G_AllowEntityInteraction(other, ent) )
;307:		//{
;308:		if ( ent->damage ) {
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
CNSTI4 0
EQI4 $99
line 311
;309:			vec3_t	velocity;
;310:
;311:			if( LogAccuracyHit( other, &g_entities[ent->r.ownerNum] ) ) {
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 896
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 LogAccuracyHit
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $101
line 312
;312:				g_entities[ent->r.ownerNum].client->accuracy_hits++;
ADDRLP4 40
CNSTI4 896
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 10316
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 313
;313:				hitClient = qtrue;
ADDRLP4 16
CNSTI4 1
ASGNI4
line 314
;314:			}
LABELV $101
line 315
;315:			BG_EvaluateTrajectoryDelta( &ent->s.pos, level.time, velocity );
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 level+40
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRGP4 BG_EvaluateTrajectoryDelta
CALLV
pop
line 316
;316:			if ( VectorLength( velocity ) == 0 ) {
ADDRLP4 24
ARGP4
ADDRLP4 40
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 40
INDIRF4
CNSTF4 0
NEF4 $105
line 317
;317:				velocity[2] = 1;	// stepped on a grenade
ADDRLP4 24+8
CNSTF4 1065353216
ASGNF4
line 318
;318:			}
LABELV $105
line 320
;319:
;320:			G_Damage (other, ent, &g_entities[ent->r.ownerNum], velocity,
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
ARGP4
CNSTI4 896
ADDRLP4 44
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 44
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 44
INDIRP4
CNSTI4 740
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 44
INDIRP4
CNSTI4 752
ADDP4
INDIRI4
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 323
;321:				ent->s.origin, ent->damage, 
;322:				0, ent->methodOfDeath);
;323:			}
LABELV $99
line 324
;324:		}
LABELV $97
line 370
;325:	//}
;326:
;327:#ifdef MISSIONPACK
;328:	if( ent->s.weapon == WP_PROX_LAUNCHER ) {
;329:		if( ent->s.pos.trType != TR_GRAVITY ) {
;330:			return;
;331:		}
;332:
;333:		// if it's a player, stick it on to them (flag them and remove this entity)
;334:		if( other->s.eType == ET_PLAYER && other->health > 0 ) {
;335:			ProximityMine_Player( ent, other );
;336:			return;
;337:		}
;338://freeze
;339:		if ( is_body_freeze( other ) ) {
;340:			ProximityMine_Body( ent, other );
;341:			return;
;342:		}
;343://freeze
;344:
;345:		SnapVectorTowards( trace->endpos, ent->s.pos.trBase );
;346:		G_SetOrigin( ent, trace->endpos );
;347:		ent->s.pos.trType = TR_STATIONARY;
;348:		VectorClear( ent->s.pos.trDelta );
;349:
;350:		G_AddEvent( ent, EV_PROXIMITY_MINE_STICK, trace->surfaceFlags );
;351:
;352:		ent->think = ProximityMine_Activate;
;353:		ent->nextthink = level.time + 2000;
;354:
;355:		vectoangles( trace->plane.normal, ent->s.angles );
;356:		ent->s.angles[0] += 90;
;357:
;358:		// link the prox mine to the other entity
;359:		ent->enemy = other;
;360:		ent->die = ProximityMine_Die;
;361:		VectorCopy(trace->plane.normal, ent->movedir);
;362:		VectorSet(ent->r.mins, -4, -4, -4);
;363:		VectorSet(ent->r.maxs, 4, 4, 4);
;364:		trap_LinkEntity(ent);
;365:
;366:		return;
;367:	}
;368:#endif
;369:
;370:	if (!strcmp(ent->classname, "hook")) {
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $110
ARGP4
ADDRLP4 24
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $108
line 374
;371:		gentity_t *nent;
;372:		vec3_t v;
;373:
;374:		nent = G_Spawn();
ADDRLP4 44
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 28
ADDRLP4 44
INDIRP4
ASGNP4
line 375
;375:		if ( other->takedamage && other->client /*&& G_AllowEntityInteraction(ent->parent, other)*/) {
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
EQI4 $111
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $111
line 377
;376:
;377:			G_AddEvent( nent, EV_MISSILE_HIT, DirToByte( trace->plane.normal ) );
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 52
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRLP4 28
INDIRP4
ARGP4
CNSTI4 50
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 378
;378:			nent->s.otherEntityNum = other->s.number;
ADDRLP4 28
INDIRP4
CNSTI4 140
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 380
;379:
;380:			ent->enemy = other;
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 382
;381:
;382:			v[0] = other->r.currentOrigin[0] + (other->r.mins[0] + other->r.maxs[0]) * 0.5;
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
CNSTF4 1056964608
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 448
ADDP4
INDIRF4
ADDF4
MULF4
ADDF4
ASGNF4
line 383
;383:			v[1] = other->r.currentOrigin[1] + (other->r.mins[1] + other->r.maxs[1]) * 0.5;
ADDRLP4 32+4
ADDRLP4 0
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
CNSTF4 1056964608
ADDRLP4 0
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
ADDF4
MULF4
ADDF4
ASGNF4
line 384
;384:			v[2] = other->r.currentOrigin[2] + (other->r.mins[2] + other->r.maxs[2]) * 0.5;
ADDRLP4 32+8
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
CNSTF4 1056964608
ADDRLP4 0
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
ADDF4
MULF4
ADDF4
ASGNF4
line 386
;385:
;386:			SnapVectorTowards( v, ent->s.pos.trBase );	// save net bandwidth
ADDRLP4 32
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 SnapVectorTowards
CALLV
pop
line 387
;387:		} else {
ADDRGP4 $112
JUMPV
LABELV $111
line 388
;388:			VectorCopy(trace->endpos, v);
ADDRLP4 32
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRB
ASGNB 12
line 389
;389:			G_AddEvent( nent, EV_MISSILE_MISS, DirToByte( trace->plane.normal ) );
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 52
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRLP4 28
INDIRP4
ARGP4
CNSTI4 51
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 390
;390:			ent->enemy = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
CNSTP4 0
ASGNP4
line 391
;391:		}
LABELV $112
line 393
;392:
;393:		SnapVectorTowards( v, ent->s.pos.trBase );	// save net bandwidth
ADDRLP4 32
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 SnapVectorTowards
CALLV
pop
line 395
;394:
;395:		nent->freeAfterEvent = qtrue;
ADDRLP4 28
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 1
ASGNI4
line 397
;396:		// change over to a normal entity right at the point of impact
;397:		nent->s.eType = ET_GENERAL;
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 398
;398:		ent->s.eType = ET_GRAPPLE;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 11
ASGNI4
line 400
;399:
;400:		G_SetOrigin( ent, v );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 32
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 401
;401:		G_SetOrigin( nent, v );
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 32
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 403
;402:
;403:		ent->think = Weapon_HookThink;
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 Weapon_HookThink
ASGNP4
line 404
;404:		ent->nextthink = level.time + FRAMETIME;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 406
;405:
;406:		ent->parent->client->ps.pm_flags |= PMF_GRAPPLE_PULL;
ADDRLP4 52
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
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 407
;407:		VectorCopy( ent->r.currentOrigin, ent->parent->client->ps.grapplePoint);
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 600
ADDP4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 56
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 409
;408:
;409:		trap_LinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 410
;410:		trap_LinkEntity( nent );
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 412
;411:
;412:		return;
ADDRGP4 $93
JUMPV
LABELV $108
line 418
;413:	}
;414:
;415:	// is it cheaper in bandwidth to just remove this ent and create a new
;416:	// one, rather than changing the missile into the explosion?
;417:
;418:	if ( other->takedamage && other->client /*&& G_AllowEntityInteraction(other, ent)*/) {
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
EQI4 $116
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $116
line 419
;419:		G_AddEvent( ent, EV_MISSILE_HIT, DirToByte( trace->plane.normal ) );
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 32
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 50
ARGI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 420
;420:		ent->s.otherEntityNum = other->s.number;
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 421
;421:	} else if( trace->surfaceFlags & SURF_METALSTEPS ) {
ADDRGP4 $117
JUMPV
LABELV $116
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $118
line 422
;422:		G_AddEvent( ent, EV_MISSILE_MISS_METAL, DirToByte( trace->plane.normal ) );
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 32
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 52
ARGI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 423
;423:	} else {
ADDRGP4 $119
JUMPV
LABELV $118
line 424
;424:		G_AddEvent( ent, EV_MISSILE_MISS, DirToByte( trace->plane.normal ) );
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 32
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 51
ARGI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 425
;425:	}
LABELV $119
LABELV $117
line 427
;426:
;427:	ent->freeAfterEvent = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 556
ADDP4
CNSTI4 1
ASGNI4
line 430
;428:
;429:	// change over to a normal entity right at the point of impact
;430:	ent->s.eType = ET_GENERAL;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 432
;431:
;432:	SnapVectorTowards( trace->endpos, ent->s.pos.trBase );	// save net bandwidth
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 SnapVectorTowards
CALLV
pop
line 434
;433:
;434:	G_SetOrigin( ent, trace->endpos );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 437
;435:
;436:	// splash damage (doesn't apply to person directly hit)
;437:	if ( ent->splashDamage ) {
ADDRFP4 0
INDIRP4
CNSTI4 744
ADDP4
INDIRI4
CNSTI4 0
EQI4 $120
line 440
;438:		// CPM: check new radius damage rules
;439:		//if (cpm_radiusdamagefix)
;440:		if ( g_pro_mode.integer ) {
ADDRGP4 g_pro_mode+12
INDIRI4
CNSTI4 0
EQI4 $122
line 443
;441:			// find "viewpoint" for explosion
;442:			// backtrace 10 units
;443:			VectorNormalize(vec2);
ADDRLP4 4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 444
;444:			VectorScale(vec2, 10, vec2);
ADDRLP4 32
CNSTF4 1092616192
ASGNF4
ADDRLP4 4
ADDRLP4 32
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 32
INDIRF4
ADDRLP4 4+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 4+8
CNSTF4 1092616192
ADDRLP4 4+8
INDIRF4
MULF4
ASGNF4
line 445
;445:			VectorSubtract(trace->endpos, vec2, vec2);
ADDRLP4 36
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 36
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 36
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 4+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 4+8
INDIRF4
SUBF4
ASGNF4
line 447
;446:			// use new radius damage
;447:			if( CPM_RadiusDamage( trace->endpos, ent->parent, ent->splashDamage, ent->splashRadius, 
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 600
ADDP4
INDIRP4
ARGP4
ADDRLP4 40
INDIRP4
CNSTI4 744
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 748
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 40
INDIRP4
CNSTI4 756
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 44
ADDRGP4 CPM_RadiusDamage
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $123
line 448
;448:				other, ent->splashMethodOfDeath, vec2 ) ) {
line 449
;449:				if( !hitClient ) {
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $123
line 451
;450:					//g_entities[ent->r.ownerNum].client->ps.persistant[PERS_ACCURACY_HITS]++;
;451:					g_entities[ent->r.ownerNum].client->accuracy_hits++;
ADDRLP4 48
CNSTI4 896
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 10316
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 452
;452:				}
line 453
;453:			}
line 454
;454:		}
ADDRGP4 $123
JUMPV
LABELV $122
line 456
;455:		else
;456:		{
line 458
;457:		// !CPM
;458:			if( G_RadiusDamage( trace->endpos, ent->parent, ent->splashDamage, ent->splashRadius, 
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 600
ADDP4
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 744
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 748
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 756
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 G_RadiusDamage
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $138
line 459
;459:				other, ent->splashMethodOfDeath ) ) {
line 460
;460:				if( !hitClient ) {
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $140
line 461
;461:					g_entities[ent->r.ownerNum].client->accuracy_hits++;
ADDRLP4 40
CNSTI4 896
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 10316
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 462
;462:				}
LABELV $140
line 463
;463:			}
LABELV $138
line 464
;464:		}
LABELV $123
line 465
;465:	}
LABELV $120
line 467
;466:
;467:	trap_LinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 468
;468:}
LABELV $93
endproc G_MissileImpact 68 32
export G_RunMissile
proc G_RunMissile 96 28
line 475
;469:
;470:/*
;471:================
;472:G_RunMissile
;473:================
;474:*/
;475:void G_RunMissile( gentity_t *ent ) {
line 481
;476:	vec3_t		origin;
;477:	trace_t		tr;
;478:	int			passent;
;479:
;480:	// get current position
;481:	BG_EvaluateTrajectory( &ent->s.pos, level.time, origin );
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 level+40
INDIRI4
ARGI4
ADDRLP4 60
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 484
;482:
;483:	// if this missile bounced off an invulnerability sphere
;484:	if ( ent->target_ent ) {
ADDRFP4 0
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $145
line 485
;485:		passent = ent->target_ent->s.number;
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 668
ADDP4
INDIRP4
INDIRI4
ASGNI4
line 486
;486:	}
ADDRGP4 $146
JUMPV
LABELV $145
line 493
;487:#ifdef MISSIONPACK
;488:	// prox mines that left the owner bbox will attach to anything, even the owner
;489:	else if (ent->s.weapon == WP_PROX_LAUNCHER && ent->count) {
;490:		passent = ENTITYNUM_NONE;
;491:	}
;492:#endif
;493:	else {
line 495
;494:		// ignore interactions with the missile owner
;495:		passent = ent->r.ownerNum;
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
ASGNI4
line 496
;496:	}
LABELV $146
line 499
;497:		//UnlinkUninteractibleEntities(ent);
;498:	// trace a line from the previous position to the current position
;499:	trap_Trace( &tr, ent->r.currentOrigin, ent->r.mins, ent->r.maxs, origin, passent, ent->clipmask );
ADDRLP4 0
ARGP4
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 448
ADDP4
ARGP4
ADDRLP4 60
ARGP4
ADDRLP4 56
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 501
;500:
;501:	if ( tr.startsolid || tr.allsolid ) {
ADDRLP4 76
CNSTI4 0
ASGNI4
ADDRLP4 0+4
INDIRI4
ADDRLP4 76
INDIRI4
NEI4 $150
ADDRLP4 0
INDIRI4
ADDRLP4 76
INDIRI4
EQI4 $147
LABELV $150
line 503
;502:		// make sure the tr.entityNum is set to the entity we're stuck in
;503:		trap_Trace( &tr, ent->r.currentOrigin, ent->r.mins, ent->r.maxs, ent->r.currentOrigin, passent, ent->clipmask );
ADDRLP4 0
ARGP4
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
ADDRLP4 80
INDIRP4
CNSTI4 488
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRLP4 80
INDIRP4
CNSTI4 436
ADDP4
ARGP4
ADDRLP4 80
INDIRP4
CNSTI4 448
ADDP4
ARGP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRLP4 56
INDIRI4
ARGI4
ADDRLP4 80
INDIRP4
CNSTI4 572
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 504
;504:		tr.fraction = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 505
;505:	}
ADDRGP4 $148
JUMPV
LABELV $147
line 506
;506:	else {
line 507
;507:		VectorCopy( tr.endpos, ent->r.currentOrigin );
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 0+12
INDIRB
ASGNB 12
line 508
;508:	}
LABELV $148
line 511
;509:
;510:		//RelinkUninteractibleEntities();
;511:	trap_LinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 513
;512:
;513:	if ( tr.fraction != 1 ) {
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
EQF4 $153
line 515
;514:		// never explode or bounce on sky
;515:		if ( tr.surfaceFlags & SURF_NOIMPACT && ent->splashMethodOfDeath != MOD_XX_RAILJUMP) {
ADDRLP4 0+44
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $156
ADDRFP4 0
INDIRP4
CNSTI4 756
ADDP4
INDIRI4
CNSTI4 24
EQI4 $156
line 517
;516:			// If grapple, reset owner
;517:			if (ent->parent && ent->parent->client && ent->parent->client->hook == ent) {
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
ADDRLP4 80
INDIRP4
CNSTI4 600
ADDP4
INDIRP4
ASGNP4
ADDRLP4 88
CNSTU4 0
ASGNU4
ADDRLP4 84
INDIRP4
CVPU4 4
ADDRLP4 88
INDIRU4
EQU4 $159
ADDRLP4 92
ADDRLP4 84
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CVPU4 4
ADDRLP4 88
INDIRU4
EQU4 $159
ADDRLP4 92
INDIRP4
CNSTI4 10364
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 80
INDIRP4
CVPU4 4
NEU4 $159
line 518
;518:				ent->parent->client->hook = NULL;
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
line 519
;519:			}
LABELV $159
line 520
;520:			G_FreeEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 521
;521:			return;
ADDRGP4 $143
JUMPV
LABELV $156
line 523
;522:		}
;523:		G_MissileImpact( ent, &tr );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_MissileImpact
CALLV
pop
line 524
;524:		if ( ent->s.eType != ET_MISSILE ) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
EQI4 $161
line 525
;525:			return;		// exploded
ADDRGP4 $143
JUMPV
LABELV $161
line 527
;526:		}
;527:	}
LABELV $153
line 539
;528:#ifdef MISSIONPACK
;529:	// if the prox mine wasn't yet outside the player body
;530:	if (ent->s.weapon == WP_PROX_LAUNCHER && !ent->count) {
;531:		// check if the prox mine is outside the owner bbox
;532:		trap_Trace( &tr, ent->r.currentOrigin, ent->r.mins, ent->r.maxs, ent->r.currentOrigin, ENTITYNUM_NONE, ent->clipmask );
;533:		if (!tr.startsolid || tr.entityNum != ent->r.ownerNum) {
;534:			ent->count = 1;
;535:		}
;536:	}
;537:#endif
;538:	// check think function after bouncing
;539:	G_RunThink( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_RunThink
CALLV
pop
line 540
;540:}
LABELV $143
endproc G_RunMissile 96 28
export fire_plasma
proc fire_plasma 24 4
line 551
;541:
;542:
;543://=============================================================================
;544:
;545:/*
;546:=================
;547:fire_plasma
;548:
;549:=================
;550:*/
;551:gentity_t *fire_plasma (gentity_t *self, vec3_t start, vec3_t dir) {
line 562
;552:	gentity_t	*bolt;
;553:
;554:	/* Ideally we should make some messy looking if's so we don't need these variables */
;555:	//WP_DEFAULTS
;556:	//int	radius = 20;
;557:	//int	damage = 20;
;558:	//int	splash_damage = 15;
;559:	//int	speed = 2000;
;560:	//int	time = 10000;
;561:
;562:	VectorNormalize (dir);
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 564
;563:
;564:	bolt = G_Spawn();
ADDRLP4 4
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 565
;565:	bolt->classname = "plasma";
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $164
ASGNP4
line 566
;566:	bolt->nextthink = level.time + gameSettings.missiles[GS_PLASMA][GS_TIME];
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
ADDRGP4 gameSettings+24+40+16
INDIRI4
ADDI4
ASGNI4
line 567
;567:	bolt->think = G_ExplodeMissile;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 G_ExplodeMissile
ASGNP4
line 568
;568:	bolt->s.eType = ET_MISSILE;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 3
ASGNI4
line 569
;569:	bolt->r.svFlags = SVF_USE_CURRENT_ORIGIN;
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 128
ASGNI4
line 570
;570:	bolt->s.weapon = WP_PLASMAGUN;
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 8
ASGNI4
line 571
;571:	bolt->r.ownerNum = self->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 574
;572://unlagged - projectile nudge
;573:	// we'll need this for nudging projectiles later
;574:	bolt->s.otherEntityNum = self->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 576
;575://unlagged - projectile nudge
;576:	bolt->parent = self;
ADDRLP4 0
INDIRP4
CNSTI4 600
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 577
;577:	bolt->damage = gameSettings.missiles[GS_PLASMA][GS_DAMAGE];
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
ADDRGP4 gameSettings+24+40
INDIRI4
ASGNI4
line 579
;578:	//bolt->damage = cpm_PGdmg; // CPM
;579:	bolt->splashDamage = gameSettings.missiles[GS_PLASMA][GS_SPLASH_DAMAGE];
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
ADDRGP4 gameSettings+24+40+8
INDIRI4
ASGNI4
line 580
;580:	(gameSettings.quadfactor_radius && self->client->ps.powerups[PW_QUAD])?
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 gameSettings+144
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $183
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 316
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $183
ADDRLP4 0
INDIRP4
CNSTI4 748
ADDP4
ADDRGP4 gameSettings+24+40+4
INDIRI4
CVIF4 4
ADDRGP4 g_quadfactor+8
INDIRF4
MULF4
CVFI4 4
ASGNI4
ADDRGP4 $184
JUMPV
LABELV $183
ADDRLP4 0
INDIRP4
CNSTI4 748
ADDP4
ADDRGP4 gameSettings+24+40+4
INDIRI4
ASGNI4
LABELV $184
line 582
;581:		(bolt->splashRadius = gameSettings.missiles[GS_PLASMA][GS_RADIUS] * g_quadfactor.value):(bolt->splashRadius = gameSettings.missiles[GS_PLASMA][GS_RADIUS]);
;582:	bolt->methodOfDeath = MOD_PLASMA;
ADDRLP4 0
INDIRP4
CNSTI4 752
ADDP4
CNSTI4 8
ASGNI4
line 583
;583:	bolt->splashMethodOfDeath = MOD_PLASMA_SPLASH;
ADDRLP4 0
INDIRP4
CNSTI4 756
ADDP4
CNSTI4 9
ASGNI4
line 584
;584:	bolt->clipmask = MASK_SHOT;
ADDRLP4 0
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 100663297
ASGNI4
line 585
;585:	bolt->target_ent = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
CNSTP4 0
ASGNP4
line 587
;586:
;587:	bolt->s.pos.trType = TR_LINEAR;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 2
ASGNI4
line 588
;588:	bolt->s.pos.trTime = level.time - MISSILE_PRESTEP_TIME;		// move a bit on the very first frame
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 50
SUBI4
ASGNI4
line 589
;589:	VectorCopy( start, bolt->s.pos.trBase );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 590
;590:	VectorScale( dir, gameSettings.missiles[GS_PLASMA][GS_SPEED], bolt->s.pos.trDelta );
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 8
INDIRP4
INDIRF4
ADDRGP4 gameSettings+24+40+12
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 gameSettings+24+40+12
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 gameSettings+24+40+12
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 591
;591:	SnapVector( bolt->s.pos.trDelta );			// save net bandwidth
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 36
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
CNSTI4 40
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
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 593
;592:
;593:	VectorCopy (start, bolt->r.currentOrigin);
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 595
;594:
;595:	return bolt;
ADDRLP4 0
INDIRP4
RETP4
LABELV $163
endproc fire_plasma 24 4
export fire_grenade
proc fire_grenade 24 4
line 606
;596:}	
;597:
;598://=============================================================================
;599:
;600:
;601:/*
;602:=================
;603:fire_grenade
;604:=================
;605:*/
;606:gentity_t *fire_grenade (gentity_t *self, vec3_t start, vec3_t dir) {
line 617
;607:	gentity_t	*bolt;
;608:
;609:	/* Ideally we should make some messy looking if's so we don't need these variables */
;610:	//WP_DEFAULTS
;611:	//int	radius = 150;
;612:	//int	damage = 100;
;613:	//int	splash_damage = 100;
;614:	//int	speed = 700;
;615:	//int time = 2500;
;616:
;617:	VectorNormalize (dir);
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 619
;618:
;619:	bolt = G_Spawn();
ADDRLP4 4
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 620
;620:	bolt->classname = "grenade";
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $196
ASGNP4
line 621
;621:	bolt->nextthink = level.time + gameSettings.missiles[GS_GRENADE][GS_TIME];
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
ADDRGP4 gameSettings+24+16
INDIRI4
ADDI4
ASGNI4
line 622
;622:	bolt->think = G_ExplodeMissile;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 G_ExplodeMissile
ASGNP4
line 623
;623:	bolt->s.eType = ET_MISSILE;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 3
ASGNI4
line 624
;624:	bolt->r.svFlags = SVF_USE_CURRENT_ORIGIN;
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 128
ASGNI4
line 625
;625:	bolt->s.weapon = WP_GRENADE_LAUNCHER;
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 4
ASGNI4
line 626
;626:	bolt->s.eFlags = EF_BOUNCE_HALF;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 32
ASGNI4
line 627
;627:	bolt->r.ownerNum = self->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 630
;628://unlagged - projectile nudge
;629:	// we'll need this for nudging projectiles later
;630:	bolt->s.otherEntityNum = self->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 632
;631://unlagged - projectile nudge
;632:	bolt->parent = self;
ADDRLP4 0
INDIRP4
CNSTI4 600
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 633
;633:	bolt->damage = gameSettings.missiles[GS_GRENADE][GS_DAMAGE];
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
ADDRGP4 gameSettings+24
INDIRI4
ASGNI4
line 634
;634:	bolt->splashDamage = gameSettings.missiles[GS_GRENADE][GS_SPLASH_DAMAGE];
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
ADDRGP4 gameSettings+24+8
INDIRI4
ASGNI4
line 635
;635:	(gameSettings.quadfactor_radius && self->client->ps.powerups[PW_QUAD])?
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 gameSettings+144
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $210
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 316
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $210
ADDRLP4 0
INDIRP4
CNSTI4 748
ADDP4
ADDRGP4 gameSettings+24+4
INDIRI4
CVIF4 4
ADDRGP4 g_quadfactor+8
INDIRF4
MULF4
CVFI4 4
ASGNI4
ADDRGP4 $211
JUMPV
LABELV $210
ADDRLP4 0
INDIRP4
CNSTI4 748
ADDP4
ADDRGP4 gameSettings+24+4
INDIRI4
ASGNI4
LABELV $211
line 637
;636:		(bolt->splashRadius = gameSettings.missiles[GS_GRENADE][GS_RADIUS] * g_quadfactor.value):(bolt->splashRadius = gameSettings.missiles[GS_GRENADE][GS_RADIUS]);
;637:	bolt->methodOfDeath = MOD_GRENADE;
ADDRLP4 0
INDIRP4
CNSTI4 752
ADDP4
CNSTI4 4
ASGNI4
line 638
;638:	bolt->splashMethodOfDeath = MOD_GRENADE_SPLASH;
ADDRLP4 0
INDIRP4
CNSTI4 756
ADDP4
CNSTI4 5
ASGNI4
line 639
;639:	bolt->clipmask = MASK_SHOT;
ADDRLP4 0
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 100663297
ASGNI4
line 640
;640:	bolt->target_ent = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
CNSTP4 0
ASGNP4
line 642
;641:
;642:	bolt->s.pos.trType = TR_GRAVITY;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 5
ASGNI4
line 643
;643:	bolt->s.pos.trTime = level.time - MISSILE_PRESTEP_TIME;		// move a bit on the very first frame
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 50
SUBI4
ASGNI4
line 644
;644:	VectorCopy( start, bolt->s.pos.trBase );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 645
;645:	VectorScale( dir, gameSettings.missiles[GS_GRENADE][GS_SPEED], bolt->s.pos.trDelta );
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 8
INDIRP4
INDIRF4
ADDRGP4 gameSettings+24+12
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 gameSettings+24+12
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 gameSettings+24+12
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 646
;646:	SnapVector( bolt->s.pos.trDelta );			// save net bandwidth
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 36
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
CNSTI4 40
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
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 648
;647:
;648:	VectorCopy (start, bolt->r.currentOrigin);
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 650
;649:
;650:	return bolt;
ADDRLP4 0
INDIRP4
RETP4
LABELV $195
endproc fire_grenade 24 4
export fire_bfg
proc fire_bfg 24 4
line 661
;651:}
;652:
;653://=============================================================================
;654:
;655:
;656:/*
;657:=================
;658:fire_bfg
;659:=================
;660:*/
;661:gentity_t *fire_bfg (gentity_t *self, vec3_t start, vec3_t dir) {
line 672
;662:	gentity_t	*bolt;
;663:
;664:	/* Ideally we should make some messy looking if's so we don't need these variables */
;665:	//WP_DEFAULTS
;666:	//int	radius = 120;
;667:	//int	damage = 100;
;668:	//int	splash_damage = 100;
;669:	//int	speed = 2000;
;670:	//int time = 10000;
;671:
;672:	VectorNormalize (dir);
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 674
;673:
;674:	bolt = G_Spawn();
ADDRLP4 4
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 675
;675:	bolt->classname = "bfg";
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $220
ASGNP4
line 676
;676:	bolt->nextthink = level.time + gameSettings.missiles[GS_BFG][GS_TIME];
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
ADDRGP4 gameSettings+24+60+16
INDIRI4
ADDI4
ASGNI4
line 677
;677:	bolt->think = G_ExplodeMissile;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 G_ExplodeMissile
ASGNP4
line 678
;678:	bolt->s.eType = ET_MISSILE;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 3
ASGNI4
line 679
;679:	bolt->r.svFlags = SVF_USE_CURRENT_ORIGIN;
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 128
ASGNI4
line 680
;680:	bolt->s.weapon = WP_BFG;
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 9
ASGNI4
line 681
;681:	bolt->r.ownerNum = self->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 684
;682://unlagged - projectile nudge
;683:	// we'll need this for nudging projectiles later
;684:	bolt->s.otherEntityNum = self->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 686
;685://unlagged - projectile nudge
;686:	bolt->parent = self;
ADDRLP4 0
INDIRP4
CNSTI4 600
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 687
;687:	bolt->damage = gameSettings.missiles[GS_BFG][GS_DAMAGE];
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
ADDRGP4 gameSettings+24+60
INDIRI4
ASGNI4
line 688
;688:	bolt->splashDamage = gameSettings.missiles[GS_BFG][GS_SPLASH_DAMAGE];
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
ADDRGP4 gameSettings+24+60+8
INDIRI4
ASGNI4
line 689
;689:	(gameSettings.quadfactor_radius && self->client->ps.powerups[PW_QUAD])?
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 gameSettings+144
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $239
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 316
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $239
ADDRLP4 0
INDIRP4
CNSTI4 748
ADDP4
ADDRGP4 gameSettings+24+60+4
INDIRI4
CVIF4 4
ADDRGP4 g_quadfactor+8
INDIRF4
MULF4
CVFI4 4
ASGNI4
ADDRGP4 $240
JUMPV
LABELV $239
ADDRLP4 0
INDIRP4
CNSTI4 748
ADDP4
ADDRGP4 gameSettings+24+60+4
INDIRI4
ASGNI4
LABELV $240
line 691
;690:		(bolt->splashRadius = gameSettings.missiles[GS_BFG][GS_RADIUS] * g_quadfactor.value):(bolt->splashRadius = gameSettings.missiles[GS_BFG][GS_RADIUS]);
;691:	bolt->methodOfDeath = MOD_BFG;
ADDRLP4 0
INDIRP4
CNSTI4 752
ADDP4
CNSTI4 12
ASGNI4
line 692
;692:	bolt->splashMethodOfDeath = MOD_BFG_SPLASH;
ADDRLP4 0
INDIRP4
CNSTI4 756
ADDP4
CNSTI4 13
ASGNI4
line 693
;693:	bolt->clipmask = MASK_SHOT;
ADDRLP4 0
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 100663297
ASGNI4
line 694
;694:	bolt->target_ent = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
CNSTP4 0
ASGNP4
line 696
;695:
;696:	bolt->s.pos.trType = TR_LINEAR;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 2
ASGNI4
line 697
;697:	bolt->s.pos.trTime = level.time - MISSILE_PRESTEP_TIME;		// move a bit on the very first frame
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 50
SUBI4
ASGNI4
line 698
;698:	VectorCopy( start, bolt->s.pos.trBase );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 699
;699:	VectorScale( dir, gameSettings.missiles[GS_BFG][GS_SPEED], bolt->s.pos.trDelta );
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 8
INDIRP4
INDIRF4
ADDRGP4 gameSettings+24+60+12
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 gameSettings+24+60+12
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 gameSettings+24+60+12
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 700
;700:	SnapVector( bolt->s.pos.trDelta );			// save net bandwidth
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 36
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
CNSTI4 40
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
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 701
;701:	VectorCopy (start, bolt->r.currentOrigin);
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 703
;702:
;703:	return bolt;
ADDRLP4 0
INDIRP4
RETP4
LABELV $219
endproc fire_bfg 24 4
export fire_rocket
proc fire_rocket 24 4
line 714
;704:}
;705:
;706://=============================================================================
;707:
;708:
;709:/*
;710:=================
;711:fire_rocket
;712:=================
;713:*/
;714:gentity_t *fire_rocket (gentity_t *self, vec3_t start, vec3_t dir) {
line 725
;715:	gentity_t	*bolt;
;716:
;717:	/* Ideally we should make some messy looking if's so we don't need these variables */
;718:	//WP_DEFAULTS
;719:	//int	radius = 120;
;720:	//int	damage = 100;
;721:	//int	splash_damage = 100;
;722:	//int	speed = 900;
;723:	//int time = 15000;
;724:
;725:	VectorNormalize (dir);
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 727
;726:
;727:	bolt = G_Spawn();
ADDRLP4 4
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 728
;728:	bolt->classname = "rocket";
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $252
ASGNP4
line 729
;729:	bolt->nextthink = level.time + gameSettings.missiles[GS_ROCKET][GS_TIME];
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
ADDRGP4 gameSettings+24+20+16
INDIRI4
ADDI4
ASGNI4
line 730
;730:	bolt->think = G_ExplodeMissile;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 G_ExplodeMissile
ASGNP4
line 731
;731:	bolt->s.eType = ET_MISSILE;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 3
ASGNI4
line 732
;732:	bolt->r.svFlags = SVF_USE_CURRENT_ORIGIN;
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 128
ASGNI4
line 733
;733:	bolt->s.weapon = WP_ROCKET_LAUNCHER;
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 5
ASGNI4
line 734
;734:	bolt->r.ownerNum = self->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 737
;735://unlagged - projectile nudge
;736:	// we'll need this for nudging projectiles later
;737:	bolt->s.otherEntityNum = self->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 739
;738://unlagged - projectile nudge
;739:	bolt->parent = self;
ADDRLP4 0
INDIRP4
CNSTI4 600
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 740
;740:	bolt->damage = gameSettings.missiles[GS_ROCKET][GS_DAMAGE];
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
ADDRGP4 gameSettings+24+20
INDIRI4
ASGNI4
line 741
;741:	bolt->splashDamage = gameSettings.missiles[GS_ROCKET][GS_SPLASH_DAMAGE];
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
ADDRGP4 gameSettings+24+20+8
INDIRI4
ASGNI4
line 742
;742:	(gameSettings.quadfactor_radius && self->client->ps.powerups[PW_QUAD])?
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 gameSettings+144
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $271
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 316
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $271
ADDRLP4 0
INDIRP4
CNSTI4 748
ADDP4
ADDRGP4 gameSettings+24+20+4
INDIRI4
CVIF4 4
ADDRGP4 g_quadfactor+8
INDIRF4
MULF4
CVFI4 4
ASGNI4
ADDRGP4 $272
JUMPV
LABELV $271
ADDRLP4 0
INDIRP4
CNSTI4 748
ADDP4
ADDRGP4 gameSettings+24+20+4
INDIRI4
ASGNI4
LABELV $272
line 744
;743:		(bolt->splashRadius = gameSettings.missiles[GS_ROCKET][GS_RADIUS] * g_quadfactor.value):(bolt->splashRadius = gameSettings.missiles[GS_ROCKET][GS_RADIUS]);
;744:	bolt->methodOfDeath = MOD_ROCKET;
ADDRLP4 0
INDIRP4
CNSTI4 752
ADDP4
CNSTI4 6
ASGNI4
line 745
;745:	bolt->splashMethodOfDeath = MOD_ROCKET_SPLASH;
ADDRLP4 0
INDIRP4
CNSTI4 756
ADDP4
CNSTI4 7
ASGNI4
line 746
;746:	bolt->clipmask = MASK_SHOT;
ADDRLP4 0
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 100663297
ASGNI4
line 747
;747:	bolt->target_ent = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
CNSTP4 0
ASGNP4
line 749
;748:
;749:	bolt->s.pos.trType = TR_LINEAR;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 2
ASGNI4
line 750
;750:	bolt->s.pos.trTime = level.time - MISSILE_PRESTEP_TIME;		// move a bit on the very first frame
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 50
SUBI4
ASGNI4
line 751
;751:	VectorCopy( start, bolt->s.pos.trBase );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 753
;752:	//VectorScale( dir, 900, bolt->s.pos.trDelta );
;753:	VectorScale( dir, gameSettings.missiles[GS_ROCKET][GS_SPEED], bolt->s.pos.trDelta );
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 8
INDIRP4
INDIRF4
ADDRGP4 gameSettings+24+20+12
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 gameSettings+24+20+12
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 gameSettings+24+20+12
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 755
;754:	//VectorScale( dir, cpm_RLspeed, bolt->s.pos.trDelta ); // CPM
;755:	SnapVector( bolt->s.pos.trDelta );			// save net bandwidth
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 36
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
CNSTI4 40
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
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 756
;756:	VectorCopy (start, bolt->r.currentOrigin);
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 758
;757:
;758:	return bolt;
ADDRLP4 0
INDIRP4
RETP4
LABELV $251
endproc fire_rocket 24 4
export fire_grapple
proc fire_grapple 24 4
line 769
;759:}
;760:
;761://=============================================================================
;762:
;763:
;764:/*
;765:=================
;766:fire_grapple
;767:=================
;768:*/
;769:gentity_t *fire_grapple (gentity_t *self, vec3_t start, vec3_t dir) {
line 779
;770:	gentity_t	*hook;
;771://unlagged - grapple
;772:	int hooktime;
;773://unlagged - grapple
;774:
;775:	/* Ideally we should make some messy looking if's so we don't need these variables */
;776:	//WP_DEFAULTS
;777:	//int	speed = 800;
;778:
;779:	VectorNormalize (dir);
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 782
;780:
;781:
;782:	hook = G_Spawn();
ADDRLP4 8
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 783
;783:	hook->classname = "hook";
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $110
ASGNP4
line 784
;784:	hook->nextthink = level.time + 10000;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+40
INDIRI4
CNSTI4 10000
ADDI4
ASGNI4
line 785
;785:	hook->think = Weapon_HookFree;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 Weapon_HookFree
ASGNP4
line 786
;786:	hook->s.eType = ET_MISSILE;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 3
ASGNI4
line 787
;787:	hook->r.svFlags = SVF_USE_CURRENT_ORIGIN;
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 128
ASGNI4
line 788
;788:	hook->s.weapon = WP_GRAPPLING_HOOK;
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 10
ASGNI4
line 789
;789:	hook->r.ownerNum = self->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 790
;790:	hook->methodOfDeath = MOD_GRAPPLE;
ADDRLP4 0
INDIRP4
CNSTI4 752
ADDP4
CNSTI4 23
ASGNI4
line 791
;791:	hook->clipmask = MASK_SHOT;
ADDRLP4 0
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 100663297
ASGNI4
line 792
;792:	hook->parent = self;
ADDRLP4 0
INDIRP4
CNSTI4 600
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 793
;793:	hook->target_ent = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 668
ADDP4
CNSTP4 0
ASGNP4
line 797
;794:
;795://unlagged - grapple
;796:	// we might want this later
;797:	hook->s.otherEntityNum = self->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 802
;798:
;799:	// setting the projectile base time back makes the hook's first
;800:	// step larger
;801:
;802:	if ( self->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $285
line 803
;803:		hooktime = self->client->pers.cmd.serverTime + 50;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 472
ADDP4
INDIRI4
CNSTI4 50
ADDI4
ASGNI4
line 804
;804:	}
ADDRGP4 $286
JUMPV
LABELV $285
line 805
;805:	else {
line 806
;806:		hooktime = level.time - MISSILE_PRESTEP_TIME;
ADDRLP4 4
ADDRGP4 level+40
INDIRI4
CNSTI4 50
SUBI4
ASGNI4
line 807
;807:	}
LABELV $286
line 809
;808:
;809:	hook->s.pos.trTime = hooktime;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 812
;810://unlagged - grapple
;811:
;812:	hook->s.pos.trType = TR_LINEAR;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 2
ASGNI4
line 816
;813://unlagged - grapple
;814:	//hook->s.pos.trTime = level.time - MISSILE_PRESTEP_TIME;		// move a bit on the very first frame
;815://unlagged - grapple
;816:	hook->s.otherEntityNum = self->s.number; // use to match beam in client
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 817
;817:	VectorCopy( start, hook->s.pos.trBase );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 818
;818:	VectorScale( dir, gameSettings.hook_speed, hook->s.pos.trDelta );
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 8
INDIRP4
INDIRF4
ADDRGP4 gameSettings+20
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 gameSettings+20
INDIRI4
CVIF4 4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 gameSettings+20
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 819
;819:	SnapVector( hook->s.pos.trDelta );			// save net bandwidth
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 36
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
CNSTI4 40
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
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 820
;820:	VectorCopy (start, hook->r.currentOrigin);
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 822
;821:
;822:	self->client->hook = hook;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 10364
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 824
;823:
;824:	return hook;
ADDRLP4 0
INDIRP4
RETP4
LABELV $283
endproc fire_grapple 24 4
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
import fire_railgun
import fire_blaster
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
LABELV $252
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $220
byte 1 98
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $196
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $164
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 0
align 1
LABELV $110
byte 1 104
byte 1 111
byte 1 111
byte 1 107
byte 1 0
