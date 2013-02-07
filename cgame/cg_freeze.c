#include "cg_local.h"

void CG_Drop_f( void ) {
	char	command[ 128 ];
	char	message[ 128 ];
	gitem_t	*item;
	int	j;

	if ( cg.snap->ps.persistant[ PERS_TEAM ] == TEAM_SPECTATOR ) {
		return;
	}
	if ( cg.predictedPlayerState.stats[ STAT_HEALTH ] <= 0 ) {
		CG_Printf( "You must be alive to use this command.\n" );
		return;
	}
	trap_Args( message, 128 );
	item = BG_FindItem( message );
	if ( !item ) {
		CG_Printf( "unknown item: %s\n", message );
		return;
	}

	if ( !cg_items[ item->giTag ].registered ) {
		return;
	}

	j = item->giTag;
	switch ( item->giType ) {
	case IT_WEAPON:
		if ( cgs.dmflags & 256 ) {
			return;
		}
		if ( !( cg.snap->ps.stats[ STAT_WEAPONS ] & ( 1 << j ) ) ) {
			CG_Printf( "Out of item: %s\n", message );
			return;
		}
		if ( cg.snap->ps.weaponstate != WEAPON_READY ) {
			return;
		}
		if ( j == cg.snap->ps.weapon ) {
			return;
		}
		if ( j <= WP_MACHINEGUN || j == WP_GRAPPLING_HOOK ) {
			CG_Printf( "Item is not dropable.\n" );
			return;
		}
	case IT_AMMO:
		if ( cg.snap->ps.ammo[ j ] < 1 ) {
			CG_Printf( "Out of item: %s\n", message );
			return;
		}
		break;
	case IT_POWERUP:
		if ( cg.snap->ps.powerups[ j ] <= cg.time ) {
			CG_Printf( "Out of item: %s\n", message );
			return;
		}
		break;
	case IT_HOLDABLE:
		if ( j == HI_KAMIKAZE ) {
			CG_Printf( "Item is not dropable.\n" );
			return;
		}
		if ( bg_itemlist[ cg.snap->ps.stats[ STAT_HOLDABLE_ITEM ] ].giTag != j ) {
			CG_Printf( "Out of item: %s\n", message );
			return;
		}
		break;
	default:
		CG_Printf( "Item is not dropable.\n" );
		return;
	}

	Com_sprintf( command, 128, "drop %s", message );
	trap_SendClientCommand( command );
}

void CG_BodyObituary( entityState_t *ent, char *targetName ) {
	int	target, attacker;
	char	*message;
	char	*message2;
	const char	*attackerInfo;
	char	attackerName[ 32 ];
	gender_t	gender;
	char	*s;

	target = ent->otherEntityNum;
	attacker = ent->otherEntityNum2;

	attackerInfo = CG_ConfigString( CS_PLAYERS + attacker );
	if ( !attackerInfo ) return;
	Q_strncpyz( attackerName, Info_ValueForKey( attackerInfo, "n" ), sizeof ( attackerName ) - 2 );
	strcat( attackerName, S_COLOR_WHITE );

	if ( rand() & 1 ) {
		message = "thawed";
		message2 = "like a package of frozen peas";
	} else {
		gender = cgs.clientinfo[ target ].gender;
		message = "evicted";
		if ( gender == GENDER_FEMALE ) {
			message2 = "from her igloo";
		} else if ( gender == GENDER_NEUTER ) {
			message2 = "from its igloo";
		} else {
			message2 = "from his igloo";
		}
	}

	if ( attacker == cg.snap->ps.clientNum ) {
		s = va( "You thawed %s", targetName );
		CG_CenterPrint( s, SCREEN_HEIGHT * 0.25, BIGCHAR_WIDTH );
	}
	if ( target == cg.snap->ps.clientNum ) {
		s = va( "%s unfroze you", attackerName );
		CG_CenterPrint( s, SCREEN_HEIGHT * 0.25, BIGCHAR_WIDTH );
	}
	CG_Printf( "%s %s %s %s.\n", attackerName, message, targetName, message2 );
}

qboolean Q_Isfreeze( int clientNum ) {
	if ( cg.snap->ps.stats[ STAT_CLIENTS_READY ] & ( 1 << clientNum ) ) {
		return ( !( cg.warmup || cg.predictedPlayerState.pm_type == PM_INTERMISSION ) );
	}
	return qfalse;
}

void CG_AddGib( localEntity_t *le ) {
	const qhandle_t	hShader = cgs.media.freezeShader;

	if ( le->refEntity.customShader == hShader ) {
		le->refEntity.customShader = 0;
		trap_R_AddRefEntityToScene( &le->refEntity );
		le->refEntity.customShader = hShader;
	}
}
