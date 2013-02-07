export CG_Drop_f
code
proc CG_Drop_f 280 16
file "../cg_freeze.c"
line 3
;1:#include "cg_local.h"
;2:
;3:void CG_Drop_f( void ) {
line 9
;4:	char	command[ 128 ];
;5:	char	message[ 128 ];
;6:	gitem_t	*item;
;7:	int	j;
;8:
;9:	if ( cg.snap->ps.persistant[ PERS_TEAM ] == TEAM_SPECTATOR ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $78
line 10
;10:		return;
ADDRGP4 $77
JUMPV
LABELV $78
line 12
;11:	}
;12:	if ( cg.predictedPlayerState.stats[ STAT_HEALTH ] <= 0 ) {
ADDRGP4 cg+107636+184
INDIRI4
CNSTI4 0
GTI4 $81
line 13
;13:		CG_Printf( "You must be alive to use this command.\n" );
ADDRGP4 $85
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 14
;14:		return;
ADDRGP4 $77
JUMPV
LABELV $81
line 16
;15:	}
;16:	trap_Args( message, 128 );
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Args
CALLV
pop
line 17
;17:	item = BG_FindItem( message );
ADDRLP4 4
ARGP4
ADDRLP4 264
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 264
INDIRP4
ASGNP4
line 18
;18:	if ( !item ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $86
line 19
;19:		CG_Printf( "unknown item: %s\n", message );
ADDRGP4 $88
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 20
;20:		return;
ADDRGP4 $77
JUMPV
LABELV $86
line 23
;21:	}
;22:
;23:	if ( !cg_items[ item->giTag ].registered ) {
CNSTI4 24
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_items
ADDP4
INDIRI4
CNSTI4 0
NEI4 $89
line 24
;24:		return;
ADDRGP4 $77
JUMPV
LABELV $89
line 27
;25:	}
;26:
;27:	j = item->giTag;
ADDRLP4 260
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ASGNI4
line 28
;28:	switch ( item->giType ) {
ADDRLP4 268
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 268
INDIRI4
CNSTI4 1
LTI4 $91
ADDRLP4 268
INDIRI4
CNSTI4 6
GTI4 $91
ADDRLP4 268
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $128-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $128
address $94
address $112
address $91
address $91
address $116
address $121
code
LABELV $94
line 30
;29:	case IT_WEAPON:
;30:		if ( cgs.dmflags & 256 ) {
ADDRGP4 cgs+31460
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $95
line 31
;31:			return;
ADDRGP4 $77
JUMPV
LABELV $95
line 33
;32:		}
;33:		if ( !( cg.snap->ps.stats[ STAT_WEAPONS ] & ( 1 << j ) ) ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 260
INDIRI4
LSHI4
BANDI4
CNSTI4 0
NEI4 $98
line 34
;34:			CG_Printf( "Out of item: %s\n", message );
ADDRGP4 $101
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 35
;35:			return;
ADDRGP4 $77
JUMPV
LABELV $98
line 37
;36:		}
;37:		if ( cg.snap->ps.weaponstate != WEAPON_READY ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 0
EQI4 $102
line 38
;38:			return;
ADDRGP4 $77
JUMPV
LABELV $102
line 40
;39:		}
;40:		if ( j == cg.snap->ps.weapon ) {
ADDRLP4 260
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
NEI4 $105
line 41
;41:			return;
ADDRGP4 $77
JUMPV
LABELV $105
line 43
;42:		}
;43:		if ( j <= WP_MACHINEGUN || j == WP_GRAPPLING_HOOK ) {
ADDRLP4 276
ADDRLP4 260
INDIRI4
ASGNI4
ADDRLP4 276
INDIRI4
CNSTI4 2
LEI4 $110
ADDRLP4 276
INDIRI4
CNSTI4 10
NEI4 $108
LABELV $110
line 44
;44:			CG_Printf( "Item is not dropable.\n" );
ADDRGP4 $111
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 45
;45:			return;
ADDRGP4 $77
JUMPV
LABELV $108
LABELV $112
line 48
;46:		}
;47:	case IT_AMMO:
;48:		if ( cg.snap->ps.ammo[ j ] < 1 ) {
ADDRLP4 260
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 420
ADDP4
ADDP4
INDIRI4
CNSTI4 1
GEI4 $92
line 49
;49:			CG_Printf( "Out of item: %s\n", message );
ADDRGP4 $101
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 50
;50:			return;
ADDRGP4 $77
JUMPV
line 52
;51:		}
;52:		break;
LABELV $116
line 54
;53:	case IT_POWERUP:
;54:		if ( cg.snap->ps.powerups[ j ] <= cg.time ) {
ADDRLP4 260
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 356
ADDP4
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
GTI4 $92
line 55
;55:			CG_Printf( "Out of item: %s\n", message );
ADDRGP4 $101
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 56
;56:			return;
ADDRGP4 $77
JUMPV
line 58
;57:		}
;58:		break;
LABELV $121
line 60
;59:	case IT_HOLDABLE:
;60:		if ( j == HI_KAMIKAZE ) {
ADDRLP4 260
INDIRI4
CNSTI4 3
NEI4 $122
line 61
;61:			CG_Printf( "Item is not dropable.\n" );
ADDRGP4 $111
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 62
;62:			return;
ADDRGP4 $77
JUMPV
LABELV $122
line 64
;63:		}
;64:		if ( bg_itemlist[ cg.snap->ps.stats[ STAT_HOLDABLE_ITEM ] ].giTag != j ) {
CNSTI4 52
ADDRGP4 cg+36
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
ADDRLP4 260
INDIRI4
EQI4 $92
line 65
;65:			CG_Printf( "Out of item: %s\n", message );
ADDRGP4 $101
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 66
;66:			return;
ADDRGP4 $77
JUMPV
line 68
;67:		}
;68:		break;
LABELV $91
line 70
;69:	default:
;70:		CG_Printf( "Item is not dropable.\n" );
ADDRGP4 $111
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 71
;71:		return;
ADDRGP4 $77
JUMPV
LABELV $92
line 74
;72:	}
;73:
;74:	Com_sprintf( command, 128, "drop %s", message );
ADDRLP4 132
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $130
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 75
;75:	trap_SendClientCommand( command );
ADDRLP4 132
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 76
;76:}
LABELV $77
endproc CG_Drop_f 280 16
export CG_BodyObituary
proc CG_BodyObituary 76 20
line 78
;77:
;78:void CG_BodyObituary( entityState_t *ent, char *targetName ) {
line 87
;79:	int	target, attacker;
;80:	char	*message;
;81:	char	*message2;
;82:	const char	*attackerInfo;
;83:	char	attackerName[ 32 ];
;84:	gender_t	gender;
;85:	char	*s;
;86:
;87:	target = ent->otherEntityNum;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 88
;88:	attacker = ent->otherEntityNum2;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
line 90
;89:
;90:	attackerInfo = CG_ConfigString( CS_PLAYERS + attacker );
ADDRLP4 32
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 60
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 36
ADDRLP4 60
INDIRP4
ASGNP4
line 91
;91:	if ( !attackerInfo ) return;
ADDRLP4 36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $132
ADDRGP4 $131
JUMPV
LABELV $132
line 92
;92:	Q_strncpyz( attackerName, Info_ValueForKey( attackerInfo, "n" ), sizeof ( attackerName ) - 2 );
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 $134
ARGP4
ADDRLP4 64
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
CNSTI4 30
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 93
;93:	strcat( attackerName, S_COLOR_WHITE );
ADDRLP4 0
ARGP4
ADDRGP4 $135
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 95
;94:
;95:	if ( rand() & 1 ) {
ADDRLP4 68
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $136
line 96
;96:		message = "thawed";
ADDRLP4 44
ADDRGP4 $138
ASGNP4
line 97
;97:		message2 = "like a package of frozen peas";
ADDRLP4 48
ADDRGP4 $139
ASGNP4
line 98
;98:	} else {
ADDRGP4 $137
JUMPV
LABELV $136
line 99
;99:		gender = cgs.clientinfo[ target ].gender;
ADDRLP4 56
CNSTI4 1776
ADDRLP4 40
INDIRI4
MULI4
ADDRGP4 cgs+40960+572
ADDP4
INDIRI4
ASGNI4
line 100
;100:		message = "evicted";
ADDRLP4 44
ADDRGP4 $142
ASGNP4
line 101
;101:		if ( gender == GENDER_FEMALE ) {
ADDRLP4 56
INDIRI4
CNSTI4 1
NEI4 $143
line 102
;102:			message2 = "from her igloo";
ADDRLP4 48
ADDRGP4 $145
ASGNP4
line 103
;103:		} else if ( gender == GENDER_NEUTER ) {
ADDRGP4 $144
JUMPV
LABELV $143
ADDRLP4 56
INDIRI4
CNSTI4 2
NEI4 $146
line 104
;104:			message2 = "from its igloo";
ADDRLP4 48
ADDRGP4 $148
ASGNP4
line 105
;105:		} else {
ADDRGP4 $147
JUMPV
LABELV $146
line 106
;106:			message2 = "from his igloo";
ADDRLP4 48
ADDRGP4 $149
ASGNP4
line 107
;107:		}
LABELV $147
LABELV $144
line 108
;108:	}
LABELV $137
line 110
;109:
;110:	if ( attacker == cg.snap->ps.clientNum ) {
ADDRLP4 32
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $150
line 111
;111:		s = va( "You thawed %s", targetName );
ADDRGP4 $153
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 52
ADDRLP4 72
INDIRP4
ASGNP4
line 112
;112:		CG_CenterPrint( s, SCREEN_HEIGHT * 0.25, BIGCHAR_WIDTH );
ADDRLP4 52
INDIRP4
ARGP4
CNSTI4 120
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 113
;113:	}
LABELV $150
line 114
;114:	if ( target == cg.snap->ps.clientNum ) {
ADDRLP4 40
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $154
line 115
;115:		s = va( "%s unfroze you", attackerName );
ADDRGP4 $157
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 72
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 52
ADDRLP4 72
INDIRP4
ASGNP4
line 116
;116:		CG_CenterPrint( s, SCREEN_HEIGHT * 0.25, BIGCHAR_WIDTH );
ADDRLP4 52
INDIRP4
ARGP4
CNSTI4 120
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 117
;117:	}
LABELV $154
line 118
;118:	CG_Printf( "%s %s %s %s.\n", attackerName, message, targetName, message2 );
ADDRGP4 $158
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 119
;119:}
LABELV $131
endproc CG_BodyObituary 76 20
export Q_Isfreeze
proc Q_Isfreeze 4 0
line 121
;120:
;121:qboolean Q_Isfreeze( int clientNum ) {
line 122
;122:	if ( cg.snap->ps.stats[ STAT_CLIENTS_READY ] & ( 1 << clientNum ) ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
CNSTI4 1
ADDRFP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $160
line 123
;123:		return ( !( cg.warmup || cg.predictedPlayerState.pm_type == PM_INTERMISSION ) );
ADDRGP4 cg+130804
INDIRI4
CNSTI4 0
NEI4 $167
ADDRGP4 cg+107636+4
INDIRI4
CNSTI4 5
EQI4 $167
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $168
JUMPV
LABELV $167
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $168
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $159
JUMPV
LABELV $160
line 125
;124:	}
;125:	return qfalse;
CNSTI4 0
RETI4
LABELV $159
endproc Q_Isfreeze 4 0
export CG_AddGib
proc CG_AddGib 4 4
line 128
;126:}
;127:
;128:void CG_AddGib( localEntity_t *le ) {
line 129
;129:	const qhandle_t	hShader = cgs.media.freezeShader;
ADDRLP4 0
ADDRGP4 cgs+156680+448
INDIRI4
ASGNI4
line 131
;130:
;131:	if ( le->refEntity.customShader == hShader ) {
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $172
line 132
;132:		le->refEntity.customShader = 0;
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
CNSTI4 0
ASGNI4
line 133
;133:		trap_R_AddRefEntityToScene( &le->refEntity );
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 134
;134:		le->refEntity.customShader = hShader;
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 135
;135:	}
LABELV $172
line 136
;136:}
LABELV $169
endproc CG_AddGib 4 4
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
LABELV $158
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $157
byte 1 37
byte 1 115
byte 1 32
byte 1 117
byte 1 110
byte 1 102
byte 1 114
byte 1 111
byte 1 122
byte 1 101
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 0
align 1
LABELV $153
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $149
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 105
byte 1 103
byte 1 108
byte 1 111
byte 1 111
byte 1 0
align 1
LABELV $148
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 32
byte 1 105
byte 1 103
byte 1 108
byte 1 111
byte 1 111
byte 1 0
align 1
LABELV $145
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 105
byte 1 103
byte 1 108
byte 1 111
byte 1 111
byte 1 0
align 1
LABELV $142
byte 1 101
byte 1 118
byte 1 105
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $139
byte 1 108
byte 1 105
byte 1 107
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 97
byte 1 103
byte 1 101
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 122
byte 1 101
byte 1 110
byte 1 32
byte 1 112
byte 1 101
byte 1 97
byte 1 115
byte 1 0
align 1
LABELV $138
byte 1 116
byte 1 104
byte 1 97
byte 1 119
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $135
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $134
byte 1 110
byte 1 0
align 1
LABELV $130
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $111
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $101
byte 1 79
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $88
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $85
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 109
byte 1 117
byte 1 115
byte 1 116
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 97
byte 1 108
byte 1 105
byte 1 118
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 46
byte 1 10
byte 1 0
