data
export forceModelModificationCount
align 4
LABELV forceModelModificationCount
byte 4 -1
export enemyModelModificationCount
align 4
LABELV enemyModelModificationCount
byte 4 -1
export teamModelModificationCount
align 4
LABELV teamModelModificationCount
byte 4 -1
export colorsModificationCount
align 4
LABELV colorsModificationCount
byte 4 -1
export teamColorsModificationCount
align 4
LABELV teamColorsModificationCount
byte 4 -1
export enemyColorsModificationCount
align 4
LABELV enemyColorsModificationCount
byte 4 -1
export maxFpsModificationCount
align 4
LABELV maxFpsModificationCount
byte 4 -1
export vmMain
code
proc vmMain 16 12
file "../cg_main.c"
line 35
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_main.c -- initialization and primary entry point for cgame
;4:#include "cg_local.h"
;5:#include "..\game\bg_promode.h" // CPM
;6:
;7:#ifdef MISSIONPACK
;8:#include "../ui/ui_shared.h"
;9:// display context for new ui stuff
;10:displayContextDef_t cgDC;
;11:#endif
;12:
;13:int forceModelModificationCount = -1;
;14:int	enemyModelModificationCount = -1;
;15:int teamModelModificationCount = -1;
;16:
;17://PM Skin colors change variables
;18:int	colorsModificationCount = -1;
;19:int	teamColorsModificationCount = -1;
;20:int	enemyColorsModificationCount = -1;
;21:int	maxFpsModificationCount = -1;
;22:
;23:void CG_Init( int serverMessageNum, int serverCommandSequence, int clientNum );
;24:void CG_Shutdown( void );
;25:
;26:
;27:/*
;28:================
;29:vmMain
;30:
;31:This is the only way control passes into the module.
;32:This must be the very first function compiled into the .q3vm file
;33:================
;34:*/
;35:int vmMain( int command, int arg0, int arg1, int arg2, int arg3, int arg4, int arg5, int arg6, int arg7, int arg8, int arg9, int arg10, int arg11  ) {
line 37
;36:
;37:	switch ( command ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $78
ADDRLP4 0
INDIRI4
CNSTI4 8
GTI4 $78
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $90
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $90
address $80
address $81
address $82
address $83
address $84
address $85
address $86
address $87
address $88
code
LABELV $80
line 39
;38:	case CG_INIT:
;39:		CG_Init( arg0, arg1, arg2 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_Init
CALLV
pop
line 40
;40:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $77
JUMPV
LABELV $81
line 42
;41:	case CG_SHUTDOWN:
;42:		CG_Shutdown();
ADDRGP4 CG_Shutdown
CALLV
pop
line 43
;43:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $77
JUMPV
LABELV $82
line 45
;44:	case CG_CONSOLE_COMMAND:
;45:		return CG_ConsoleCommand();
ADDRLP4 4
ADDRGP4 CG_ConsoleCommand
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $77
JUMPV
LABELV $83
line 47
;46:	case CG_DRAW_ACTIVE_FRAME:
;47:		CG_DrawActiveFrame( arg0, arg1, arg2 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_DrawActiveFrame
CALLV
pop
line 48
;48:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $77
JUMPV
LABELV $84
line 50
;49:	case CG_CROSSHAIR_PLAYER:
;50:		return CG_CrosshairPlayer();
ADDRLP4 8
ADDRGP4 CG_CrosshairPlayer
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $77
JUMPV
LABELV $85
line 52
;51:	case CG_LAST_ATTACKER:
;52:		return CG_LastAttacker();
ADDRLP4 12
ADDRGP4 CG_LastAttacker
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
RETI4
ADDRGP4 $77
JUMPV
LABELV $86
line 54
;53:	case CG_KEY_EVENT:
;54:		CG_KeyEvent(arg0, arg1);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 CG_KeyEvent
CALLV
pop
line 55
;55:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $77
JUMPV
LABELV $87
line 61
;56:	case CG_MOUSE_EVENT:
;57:#ifdef MISSIONPACK
;58:		cg.cursorx = cgs.cursorX;
;59:		cg.cursory = cgs.cursorY;
;60:#endif
;61:		CG_MouseEvent(arg0, arg1);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 CG_MouseEvent
CALLV
pop
line 62
;62:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $77
JUMPV
LABELV $88
line 64
;63:	case CG_EVENT_HANDLING:
;64:		CG_EventHandling(arg0);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 CG_EventHandling
CALLV
pop
line 65
;65:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $77
JUMPV
LABELV $78
line 67
;66:	default:
;67:		CG_Error( "vmMain: unknown command %i", command );
ADDRGP4 $89
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 68
;68:		break;
LABELV $79
line 70
;69:	}
;70:	return -1;
CNSTI4 -1
RETI4
LABELV $77
endproc vmMain 16 12
data
export hud_count
align 4
LABELV hud_count
byte 4 0
export max_speed
align 4
LABELV max_speed
byte 4 0
align 4
LABELV cvarTable
address sex
address $92
address $93
byte 4 3
address colors
address $94
address $95
byte 4 3
address color1
address $96
address $97
byte 4 64
address color2
address $98
address $99
byte 4 64
address com_maxfps
address $100
address $101
byte 4 3
address rate
address $102
address $103
byte 4 3
address cg_aimType
address $104
address $105
byte 4 3
address cg_aimNudge
address $106
address $107
byte 4 514
address snaps
address $108
address $109
byte 4 3
address cl_maxpackets
address $110
address $111
byte 4 3
address cl_guid
address $112
address $93
byte 4 2
address g_allowReady
address $113
address $114
byte 4 4
address s_ambient
address $115
address $114
byte 4 1
address cg_ignore
address $116
address $107
byte 4 0
address cg_autoswitch
address $117
address $114
byte 4 1
address cg_drawGun
address $118
address $114
byte 4 1
address cg_zoomFov
address $119
address $120
byte 4 1
address cg_fov
address $121
address $122
byte 4 1
address cg_viewsize
address $123
address $124
byte 4 1
address cg_stereoSeparation
address $125
address $126
byte 4 1
address cg_shadows
address $127
address $114
byte 4 1
address cg_gibs
address $128
address $114
byte 4 1
address cg_draw2D
address $129
address $114
byte 4 1
address cg_drawStatus
address $130
address $114
byte 4 1
address cg_drawTimer
address $131
address $107
byte 4 1
address cg_drawClock
address $132
address $107
byte 4 1
address cg_drawFPS
address $133
address $107
byte 4 1
address cg_drawSnapshot
address $134
address $107
byte 4 1
address cg_draw3dIcons
address $135
address $114
byte 4 1
address cg_drawIcons
address $136
address $114
byte 4 1
address cg_drawAmmoWarning
address $137
address $114
byte 4 1
address cg_drawAttacker
address $138
address $114
byte 4 1
address cg_drawCrosshair
address $139
address $97
byte 4 1
address cg_drawCrosshairNames
address $140
address $114
byte 4 1
address cg_drawRewards
address $141
address $114
byte 4 1
address cg_crosshairSize
address $142
address $143
byte 4 1
address cg_crosshairHealth
address $144
address $107
byte 4 1
address cg_crosshairColor
address $145
address $146
byte 4 1
address cg_crosshairX
address $147
address $107
byte 4 1
address cg_crosshairY
address $148
address $107
byte 4 1
address cg_brassTime
address $149
address $150
byte 4 1
address cg_simpleItems
address $151
address $107
byte 4 1
address cg_addMarks
address $152
address $114
byte 4 1
address cg_lagometer
address $153
address $114
byte 4 1
address cg_railTrailTime
address $154
address $155
byte 4 1
address cg_gun_x
address $156
address $107
byte 4 512
address cg_gun_y
address $157
address $107
byte 4 512
address cg_gun_z
address $158
address $107
byte 4 512
address cg_centertime
address $159
address $160
byte 4 512
address cg_runpitch
address $161
address $162
byte 4 1
address cg_runroll
address $163
address $164
byte 4 1
address cg_bobup
address $165
address $164
byte 4 512
address cg_bobpitch
address $166
address $162
byte 4 1
address cg_bobroll
address $167
address $162
byte 4 1
address cg_swingSpeed
address $168
address $169
byte 4 512
address cg_animSpeed
address $170
address $114
byte 4 512
address cg_debugAnim
address $171
address $107
byte 4 512
address cg_debugPosition
address $172
address $107
byte 4 512
address cg_debugEvents
address $173
address $107
byte 4 512
address cg_errorDecay
address $174
address $124
byte 4 0
address cg_nopredict
address $175
address $107
byte 4 0
address cg_noPlayerAnims
address $176
address $107
byte 4 512
address cg_showmiss
address $177
address $107
byte 4 0
address cg_footsteps
address $178
address $114
byte 4 512
address cg_tracerChance
address $179
address $126
byte 4 512
address cg_tracerWidth
address $180
address $114
byte 4 512
address cg_tracerLength
address $181
address $124
byte 4 512
address cg_thirdPersonRange
address $182
address $183
byte 4 0
address cg_thirdPersonAngle
address $184
address $107
byte 4 0
address cg_thirdPerson
address $185
address $107
byte 4 0
address cg_teamChatTime
address $186
address $103
byte 4 1
address cg_teamChatHeight
address $187
address $107
byte 4 1
address cg_forceModel
address $188
address $107
byte 4 1
address cg_predictItems
address $189
address $114
byte 4 1
address cg_deferPlayers
address $190
address $114
byte 4 1
address cg_drawTeamOverlay
address $191
address $107
byte 4 3
address cg_stats
address $192
address $107
byte 4 0
address cg_drawFriend
address $193
address $114
byte 4 1
address cg_teamChatsOnly
address $194
address $107
byte 4 1
address cg_noVoiceChats
address $195
address $107
byte 4 1
address cg_noVoiceText
address $196
address $107
byte 4 1
address cg_buildScript
address $197
address $107
byte 4 0
address cg_paused
address $198
address $107
byte 4 64
address cg_blood
address $199
address $114
byte 4 1
address cg_synchronousClients
address $200
address $107
byte 4 0
address cg_enableBreath
address $201
address $114
byte 4 0
address cg_cameraOrbit
address $202
address $107
byte 4 512
address cg_cameraOrbitDelay
address $203
address $204
byte 4 1
address cg_timescaleFadeEnd
address $205
address $114
byte 4 0
address cg_timescaleFadeSpeed
address $206
address $107
byte 4 0
address cg_timescale
address $207
address $114
byte 4 0
address cg_scorePlum
address $208
address $114
byte 4 3
address cg_smoothClients
address $209
address $107
byte 4 3
address cg_cameraMode
address $210
address $107
byte 4 512
address pmove_fixed
address $211
address $107
byte 4 0
address pmove_msec
address $212
address $213
byte 4 0
address sv_lock_pmove
address $214
address $107
byte 4 8
address cg_noTaunt
address $215
address $107
byte 4 1
address cg_noProjectileTrail
address $216
address $107
byte 4 1
address cg_smallFont
address $217
address $218
byte 4 1
address cg_bigFont
address $219
address $126
byte 4 1
address cg_railStyle
address $220
address $114
byte 4 1
address cg_oldRocket
address $221
address $114
byte 4 1
address cg_oldPlasma
address $222
address $114
byte 4 1
address cg_trueLightning
address $223
address $224
byte 4 1
address cg_delag
address $225
address $114
byte 4 3
address cg_debugDelag
address $226
address $107
byte 4 514
address cg_drawBBox
address $227
address $107
byte 4 512
address sv_fps
address $228
address $109
byte 4 0
address cg_projectileNudge
address $229
address $107
byte 4 1
address cg_optimizePrediction
address $230
address $114
byte 4 1
address cg_fastRespawn_override
address $231
address $107
byte 4 3
address weap_enableHook
address $232
address $107
byte 4 0
address weap_gauntletCycle
address $233
address $155
byte 4 0
address weap_machinegunCycle
address $234
address $124
byte 4 0
address weap_shotgunCycle
address $235
address $236
byte 4 0
address weap_grenadelauncherCycle
address $237
address $238
byte 4 0
address weap_lightninggunCycle
address $239
address $204
byte 4 0
address weap_rocketlauncherCycle
address $240
address $238
byte 4 0
address weap_railgunCycle
address $241
address $242
byte 4 0
address weap_plasmagunCycle
address $243
address $124
byte 4 0
address weap_bfgCycle
address $244
address $245
byte 4 0
address g_DynamicGauntletCycle
address $246
address $107
byte 4 8
address g_interference
address $247
address $114
byte 4 8
address g_gamemode
address $248
address $107
byte 4 12
address g_delagHitscan
address $249
address $160
byte 4 12
address g_pro_mode
address $250
address $107
byte 4 4
address cg_enemyModel
address $251
address $93
byte 4 1
address cg_teamModel
address $252
address $93
byte 4 1
address cg_forceColors
address $253
address $107
byte 4 1
address cg_EnemyColors
address $254
address $255
byte 4 1
address cg_TeamColors
address $256
address $257
byte 4 1
address cg_deadBodyDarken
address $258
address $114
byte 4 1
address cg_nochatbeep
address $259
address $107
byte 4 1
address cg_noteamchatbeep
address $260
address $107
byte 4 1
address cg_muzzleFlash
address $261
address $114
byte 4 1
address cg_fullWeaponCycle
address $262
address $107
byte 4 1
address cg_drawDeathMessage
address $263
address $114
byte 4 1
address cl_timeNudge
address $264
address $107
byte 4 66
address ch_Speedometer
address $265
address $266
byte 4 1
address ch_OBDetector
address $267
address $268
byte 4 1
address ch_weaponSideBar
address $269
address $270
byte 4 1
address ch_viewKeyPress
address $271
address $272
byte 4 1
address cg_pmove_fixed
address $273
address $107
byte 4 3
address g_fastSwitch
address $274
address $107
byte 4 12
address r_vertexLight
address $275
address $107
byte 4 33
address cl_packetdup
address $276
address $114
byte 4 3
address s_announcer
address $277
address $278
byte 4 1
address cg_fixedTeleporterAngles
address $279
address $107
byte 4 3
address cg_railHum
address $280
address $114
byte 4 1
address cg_adjustTeamColors
address $281
address $107
byte 4 1
address language
address $282
address $283
byte 4 1
address cg_autoScreenshot
address $284
address $107
byte 4 1
address cg_autoRecord
address $285
address $107
byte 4 1
address cg_motdDisplayTime
address $286
address $287
byte 4 1
address ch_file
address $288
address $93
byte 4 1
address cg_crosshairPulse
address $289
address $114
byte 4 1
address cg_oldScoreboard
address $290
address $107
byte 4 1
address ch_shadowOffset
address $291
address $114
byte 4 1
address cg_redName
address $292
address $293
byte 4 1
address cg_blueName
address $294
address $295
byte 4 1
address cg_debugModels
address $296
address $107
byte 4 1
address cg_fontFade
address $297
address $107
byte 4 1
address cg_fallKick
address $298
address $114
byte 4 1
address cg_damageDraw
address $299
address $114
byte 4 1
address cg_smoke_SG
address $300
address $114
byte 4 1
address cg_smokeRadius_GL
address $301
address $302
byte 4 1
address cg_smokeRadius_RL
address $303
address $304
byte 4 1
address cg_smokeGrowth_GL
address $305
address $114
byte 4 1
address cg_smokeGrowth_RL
address $306
address $114
byte 4 1
address cg_lightningImpact
address $307
address $114
byte 4 1
address cg_itemFX
address $308
address $146
byte 4 1
align 4
LABELV cvarTableSize
byte 4 172
export CG_RegisterCvars
code
proc CG_RegisterCvars 1036 16
line 522
;71:}
;72:
;73:
;74:cg_t				cg;
;75:cgs_t				cgs;
;76:centity_t			cg_entities[MAX_GENTITIES];
;77:weaponInfo_t		cg_weapons[MAX_WEAPONS];
;78:itemInfo_t			cg_items[MAX_ITEMS];
;79://Superhud - Being
;80:hud_t				hud[maxHudCommands + 64];//max number of commands maxHudCommands+64 == 66+64 == 130
;81:int					hud_count = 0;
;82:chat_t				chat[MAX_CHATS];
;83://Superhud - End
;84:autoFile_t			autoFile;
;85:lagometer_t			lagometer;
;86:float				max_speed = 0.0f;
;87:
;88:
;89:vmCvar_t	cg_railTrailTime;
;90:vmCvar_t	cg_centertime;
;91:vmCvar_t	cg_runpitch;
;92:vmCvar_t	cg_runroll;
;93:vmCvar_t	cg_bobup;
;94:vmCvar_t	cg_bobpitch;
;95:vmCvar_t	cg_bobroll;
;96:vmCvar_t	cg_swingSpeed;
;97:vmCvar_t	cg_shadows;
;98:vmCvar_t	cg_gibs;
;99:vmCvar_t	cg_drawTimer;
;100:vmCvar_t	cg_drawClock;
;101:vmCvar_t	cg_drawFPS;
;102:vmCvar_t	cg_drawSnapshot;
;103:vmCvar_t	cg_draw3dIcons;
;104:vmCvar_t	cg_drawIcons;
;105:vmCvar_t	cg_drawAmmoWarning;
;106:vmCvar_t	cg_drawCrosshair;
;107:vmCvar_t	cg_drawCrosshairNames;
;108:vmCvar_t	cg_drawRewards;
;109:vmCvar_t	cg_crosshairSize;
;110:vmCvar_t	cg_crosshairX;
;111:vmCvar_t	cg_crosshairY;
;112:vmCvar_t	cg_crosshairColor;
;113:vmCvar_t	cg_crosshairHealth;
;114:vmCvar_t	cg_draw2D;
;115:vmCvar_t	cg_drawStatus;
;116:vmCvar_t	cg_animSpeed;
;117:vmCvar_t	cg_debugAnim;
;118:vmCvar_t	cg_debugPosition;
;119:vmCvar_t	cg_debugEvents;
;120:vmCvar_t	cg_errorDecay;
;121:vmCvar_t	cg_nopredict;
;122:vmCvar_t	cg_noPlayerAnims;
;123:vmCvar_t	cg_showmiss;
;124:vmCvar_t	cg_footsteps;
;125:vmCvar_t	cg_addMarks;
;126:vmCvar_t	cg_brassTime;
;127:vmCvar_t	cg_viewsize;
;128:vmCvar_t	cg_drawGun;
;129:vmCvar_t	cg_gun_frame;
;130:vmCvar_t	cg_gun_x;
;131:vmCvar_t	cg_gun_y;
;132:vmCvar_t	cg_gun_z;
;133:vmCvar_t	cg_tracerChance;
;134:vmCvar_t	cg_tracerWidth;
;135:vmCvar_t	cg_tracerLength;
;136:vmCvar_t	cg_autoswitch;
;137:vmCvar_t	cg_ignore;
;138:vmCvar_t	cg_simpleItems;
;139:vmCvar_t	cg_fov;
;140:vmCvar_t	cg_zoomFov;
;141:vmCvar_t	cg_thirdPerson;
;142:vmCvar_t	cg_thirdPersonRange;
;143:vmCvar_t	cg_thirdPersonAngle;
;144:vmCvar_t	cg_stereoSeparation;
;145:vmCvar_t	cg_lagometer;
;146:vmCvar_t	cg_drawAttacker;
;147:vmCvar_t	cg_synchronousClients;
;148:vmCvar_t 	cg_teamChatTime;
;149:vmCvar_t 	cg_teamChatHeight;
;150:vmCvar_t 	cg_stats;
;151:vmCvar_t 	cg_buildScript;
;152:vmCvar_t 	cg_forceModel;
;153:vmCvar_t	cg_paused;
;154:vmCvar_t	cg_blood;
;155:vmCvar_t	cg_predictItems;
;156:vmCvar_t	cg_deferPlayers;
;157:vmCvar_t	cg_drawTeamOverlay;
;158://vmCvar_t	cg_teamOverlayUserinfo;
;159:vmCvar_t	cg_drawFriend;
;160:vmCvar_t	cg_teamChatsOnly;
;161:vmCvar_t	cg_noVoiceChats;
;162:vmCvar_t	cg_noVoiceText;
;163:vmCvar_t	cg_hudFiles;
;164:vmCvar_t 	cg_scorePlum;
;165:vmCvar_t 	cg_smoothClients;
;166:vmCvar_t	pmove_fixed;
;167:vmCvar_t	cg_pmove_fixed;
;168:vmCvar_t	pmove_msec;
;169:vmCvar_t	sv_lock_pmove;
;170:vmCvar_t	cg_pmove_msec;
;171:vmCvar_t	cg_cameraMode;
;172:vmCvar_t	cg_cameraOrbit;
;173:vmCvar_t	cg_cameraOrbitDelay;
;174:vmCvar_t	cg_timescaleFadeEnd;
;175:vmCvar_t	cg_timescaleFadeSpeed;
;176:vmCvar_t	cg_timescale;
;177:vmCvar_t	cg_smallFont;
;178:vmCvar_t	cg_bigFont;
;179:vmCvar_t	cg_noTaunt;
;180:vmCvar_t	cg_noProjectileTrail;
;181:vmCvar_t	cg_motdDisplayTime;
;182://vmCvar_t	cg_oldRail;
;183:vmCvar_t	cg_railStyle;
;184:vmCvar_t	cg_oldRocket;
;185:vmCvar_t	cg_oldPlasma;
;186:vmCvar_t	cg_trueLightning;
;187:/* Weapon Cycles */
;188:vmCvar_t	weap_enableHook;
;189:vmCvar_t	weap_gauntletCycle;
;190:vmCvar_t	weap_machinegunCycle;
;191:vmCvar_t	weap_shotgunCycle;
;192:vmCvar_t	weap_grenadelauncherCycle;
;193:vmCvar_t	weap_lightninggunCycle;
;194:vmCvar_t	weap_rocketlauncherCycle;
;195:vmCvar_t	weap_railgunCycle;
;196:vmCvar_t	weap_plasmagunCycle;
;197:vmCvar_t	weap_bfgCycle;
;198:vmCvar_t	g_DynamicGauntletCycle;
;199:vmCvar_t	g_interference;
;200:
;201:vmCvar_t	g_delagHitscan;
;202:vmCvar_t	g_gamemode;
;203:vmCvar_t	g_pro_mode;
;204:
;205:vmCvar_t	cg_enemyModel;
;206:vmCvar_t	cg_teamModel;
;207:vmCvar_t	cg_forceColors;
;208:vmCvar_t    cg_EnemyColors;
;209:vmCvar_t	cg_TeamColors;
;210:vmCvar_t	cg_deadBodyDarken;
;211:vmCvar_t	cg_fullWeaponCycle;
;212:vmCvar_t	rate;//Lucron: players command
;213:vmCvar_t	com_maxfps;//Lucron: players command
;214:vmCvar_t	cl_packetdup;//Lucron: players command
;215:vmCvar_t	snaps;//Lucron: players command
;216:vmCvar_t	cl_maxpackets;//Lucron: players command
;217:vmCvar_t	cl_guid;
;218:vmCvar_t	sex;
;219:vmCvar_t	r_vertexLight;//PM Skins -- WE NEED THIS!
;220:vmCvar_t	language;
;221:
;222:vmCvar_t	cg_enableBreath;
;223:#ifdef MISSIONPACK
;224:vmCvar_t 	cg_redTeamName;
;225:vmCvar_t 	cg_blueTeamName;
;226:vmCvar_t	cg_currentSelectedPlayer;
;227:vmCvar_t	cg_currentSelectedPlayerName;
;228:vmCvar_t	cg_singlePlayer;
;229:vmCvar_t	cg_enableDust;
;230:vmCvar_t	cg_singlePlayerActive;
;231:vmCvar_t	cg_recordSPDemo;
;232:vmCvar_t	cg_recordSPDemoName;
;233:vmCvar_t	cg_obeliskRespawnDelay;
;234:#endif
;235://unlagged - client options
;236:vmCvar_t	cg_delag;
;237:vmCvar_t	cg_debugDelag;
;238:vmCvar_t	cg_drawBBox;
;239:vmCvar_t	sv_fps;
;240:vmCvar_t	cg_projectileNudge;
;241:vmCvar_t	cg_optimizePrediction;
;242://unlagged - client options
;243:
;244:vmCvar_t	g_fastSwitch; //Fast weapon switching
;245:vmCvar_t	cg_drawDeathMessage;
;246:vmCvar_t	cg_nochatbeep;
;247:vmCvar_t	cg_noteamchatbeep;
;248://vmCvar_t	cg_newChat;
;249://vmCvar_t	cg_oversampleMouse;
;250:vmCvar_t	cg_muzzleFlash;
;251:
;252:vmCvar_t	cl_timeNudge;//ROM
;253:vmCvar_t	cg_aimType;
;254:vmCvar_t	cg_aimNudge;
;255:vmCvar_t	ch_Speedometer;//Spike's Speedometer
;256:vmCvar_t	ch_OBDetector;//Spike's OB Detector
;257:vmCvar_t	ch_weaponSideBar;
;258:vmCvar_t	ch_viewKeyPress;
;259:vmCvar_t	cg_fastRespawn_override;
;260:vmCvar_t	g_allowReady;
;261:vmCvar_t	colors;//PM Skin color for localclient
;262:vmCvar_t	color1;//Replaced by colors[0]
;263:vmCvar_t	color2;//Replaced by colors[4]
;264:vmCvar_t	s_announcer;
;265:vmCvar_t	cg_fixedTeleporterAngles;
;266:vmCvar_t	cg_railHum;
;267:vmCvar_t	cg_adjustTeamColors;
;268://Superhud - Begin
;269:vmCvar_t	ch_file;
;270://Superhud - End
;271:vmCvar_t	s_ambient;//enable ambiant sounds
;272:vmCvar_t	cg_autoScreenshot;
;273:vmCvar_t	cg_autoRecord;
;274:vmCvar_t	cg_crosshairPulse;
;275:vmCvar_t	cg_oldScoreboard;
;276:vmCvar_t	ch_shadowOffset;
;277:vmCvar_t	cg_redName;
;278:vmCvar_t	cg_blueName;
;279:vmCvar_t	cg_debugModels;
;280:vmCvar_t	cg_fontFade;
;281:
;282://CPMA conforming
;283:vmCvar_t	cg_fallKick;
;284:vmCvar_t	cg_damageDraw;
;285:vmCvar_t	cg_smoke_SG;
;286:vmCvar_t	cg_smokeRadius_GL;
;287:vmCvar_t	cg_smokeRadius_RL;
;288:vmCvar_t	cg_smokeGrowth_GL;
;289:vmCvar_t	cg_smokeGrowth_RL;
;290:vmCvar_t	cg_lightningImpact;
;291:vmCvar_t	cg_itemFX;
;292:
;293:typedef struct {
;294:	vmCvar_t	*vmCvar;
;295:	char		*cvarName;
;296:	char		*defaultString;
;297:	int			cvarFlags;
;298:} cvarTable_t;
;299:
;300:static cvarTable_t cvarTable[] = { // bk001129
;301:	{ &sex, "sex", "", CVAR_ARCHIVE | CVAR_USERINFO },
;302:	{ &colors, "colors", "17776", CVAR_ARCHIVE | CVAR_USERINFO },//PM Skin color for localclient
;303:	{ &color1, "color1", "4", CVAR_ROM },//Replaced by colors[0]
;304:	{ &color2, "color2", "5", CVAR_ROM },//Replaced by colors[4]
;305:	{ &com_maxfps, "com_maxfps", "85", CVAR_ARCHIVE | CVAR_USERINFO },
;306:	{ &rate, "rate", "3000", CVAR_ARCHIVE | CVAR_USERINFO },
;307:	{ &cg_aimType, "cg_aimType", "2", CVAR_ARCHIVE | CVAR_USERINFO  },
;308:	{ &cg_aimNudge, "cg_aimNudge", "0", CVAR_USERINFO | CVAR_CHEAT  },
;309:	{ &snaps, "snaps", "20", CVAR_ARCHIVE | CVAR_USERINFO },
;310:	{ &cl_maxpackets, "cl_maxpackets", "30", CVAR_ARCHIVE | CVAR_USERINFO },
;311:	{ &cl_guid, "cl_guid", "", CVAR_USERINFO },
;312:	{ &g_allowReady, "g_allowReady", "1", CVAR_SERVERINFO },
;313:	{ &s_ambient, "s_ambient", "1", CVAR_ARCHIVE },
;314:	{ &cg_ignore, "cg_ignore", "0", 0 },	// used for debugging
;315:	{ &cg_autoswitch, "cg_autoswitch", "1", CVAR_ARCHIVE },
;316:	{ &cg_drawGun, "cg_drawGun", "1", CVAR_ARCHIVE },
;317:	{ &cg_zoomFov, "cg_zoomfov", "22.5", CVAR_ARCHIVE },
;318:	{ &cg_fov, "cg_fov", "90", CVAR_ARCHIVE },
;319:	{ &cg_viewsize, "cg_viewsize", "100", CVAR_ARCHIVE },
;320:	{ &cg_stereoSeparation, "cg_stereoSeparation", "0.4", CVAR_ARCHIVE  },
;321:	{ &cg_shadows, "cg_shadows", "1", CVAR_ARCHIVE  },
;322:	{ &cg_gibs, "cg_gibs", "1", CVAR_ARCHIVE  },
;323:	{ &cg_draw2D, "cg_draw2D", "1", CVAR_ARCHIVE  },
;324:	{ &cg_drawStatus, "cg_drawStatus", "1", CVAR_ARCHIVE  },
;325:	{ &cg_drawTimer, "cg_drawTimer", "0", CVAR_ARCHIVE  },
;326:	{ &cg_drawClock, "cg_drawClock", "0", CVAR_ARCHIVE  },
;327:	{ &cg_drawFPS, "cg_drawFPS", "0", CVAR_ARCHIVE  },
;328:	{ &cg_drawSnapshot, "cg_drawSnapshot", "0", CVAR_ARCHIVE  },
;329:	{ &cg_draw3dIcons, "cg_draw3dIcons", "1", CVAR_ARCHIVE  },
;330:	{ &cg_drawIcons, "cg_drawIcons", "1", CVAR_ARCHIVE  },
;331:	{ &cg_drawAmmoWarning, "cg_drawAmmoWarning", "1", CVAR_ARCHIVE  },
;332:	{ &cg_drawAttacker, "cg_drawAttacker", "1", CVAR_ARCHIVE  },
;333:	{ &cg_drawCrosshair, "cg_drawCrosshair", "4", CVAR_ARCHIVE },
;334:	{ &cg_drawCrosshairNames, "cg_drawCrosshairNames", "1", CVAR_ARCHIVE },
;335:	{ &cg_drawRewards, "cg_drawRewards", "1", CVAR_ARCHIVE },
;336:	{ &cg_crosshairSize, "cg_crosshairSize", "24", CVAR_ARCHIVE },
;337:	{ &cg_crosshairHealth, "cg_crosshairHealth", "0", CVAR_ARCHIVE },//Was 1
;338:	{ &cg_crosshairColor, "cg_crosshairColor", "7", CVAR_ARCHIVE },
;339:	{ &cg_crosshairX, "cg_crosshairX", "0", CVAR_ARCHIVE },
;340:	{ &cg_crosshairY, "cg_crosshairY", "0", CVAR_ARCHIVE },
;341:	{ &cg_brassTime, "cg_brassTime", "2500", CVAR_ARCHIVE },
;342:	{ &cg_simpleItems, "cg_simpleItems", "0", CVAR_ARCHIVE },
;343:	{ &cg_addMarks, "cg_marks", "1", CVAR_ARCHIVE },
;344:	{ &cg_lagometer, "cg_lagometer", "1", CVAR_ARCHIVE },
;345:	{ &cg_railTrailTime, "cg_railTrailTime", "400", CVAR_ARCHIVE  },
;346:	{ &cg_gun_x, "cg_gunX", "0", CVAR_CHEAT },
;347:	{ &cg_gun_y, "cg_gunY", "0", CVAR_CHEAT },
;348:	{ &cg_gun_z, "cg_gunZ", "0", CVAR_CHEAT },
;349:	{ &cg_centertime, "cg_centertime", "3", CVAR_CHEAT },
;350:	{ &cg_runpitch, "cg_runpitch", "0.002", CVAR_ARCHIVE},
;351:	{ &cg_runroll, "cg_runroll", "0.005", CVAR_ARCHIVE },
;352:	{ &cg_bobup , "cg_bobup", "0.005", CVAR_CHEAT },
;353:	{ &cg_bobpitch, "cg_bobpitch", "0.002", CVAR_ARCHIVE },
;354:	{ &cg_bobroll, "cg_bobroll", "0.002", CVAR_ARCHIVE },
;355:	{ &cg_swingSpeed, "cg_swingSpeed", "0.3", CVAR_CHEAT },
;356:	{ &cg_animSpeed, "cg_animspeed", "1", CVAR_CHEAT },
;357:	{ &cg_debugAnim, "cg_debuganim", "0", CVAR_CHEAT },
;358:	{ &cg_debugPosition, "cg_debugposition", "0", CVAR_CHEAT },
;359:	{ &cg_debugEvents, "cg_debugevents", "0", CVAR_CHEAT },
;360:	{ &cg_errorDecay, "cg_errordecay", "100", 0 },
;361:	{ &cg_nopredict, "cg_nopredict", "0", 0 },
;362:	{ &cg_noPlayerAnims, "cg_noplayeranims", "0", CVAR_CHEAT },
;363:	{ &cg_showmiss, "cg_showmiss", "0", 0 },
;364:	{ &cg_footsteps, "cg_footsteps", "1", CVAR_CHEAT },
;365:	{ &cg_tracerChance, "cg_tracerchance", "0.4", CVAR_CHEAT },
;366:	{ &cg_tracerWidth, "cg_tracerwidth", "1", CVAR_CHEAT },
;367:	{ &cg_tracerLength, "cg_tracerlength", "100", CVAR_CHEAT },
;368:/*freeze
;369:	{ &cg_thirdPersonRange, "cg_thirdPersonRange", "40", CVAR_CHEAT },
;370:	{ &cg_thirdPersonAngle, "cg_thirdPersonAngle", "0", CVAR_CHEAT },
;371:freeze*/
;372:	{ &cg_thirdPersonRange, "cg_thirdPersonRange", "40", 0 },
;373:	{ &cg_thirdPersonAngle, "cg_thirdPersonAngle", "0", 0 },
;374://freeze
;375:	{ &cg_thirdPerson, "cg_thirdPerson", "0", 0 },
;376:	{ &cg_teamChatTime, "cg_teamChatTime", "3000", CVAR_ARCHIVE  },
;377:	{ &cg_teamChatHeight, "cg_teamChatHeight", "0", CVAR_ARCHIVE  },
;378:	{ &cg_forceModel, "cg_forceModel", "0", CVAR_ARCHIVE  },
;379:	{ &cg_predictItems, "cg_predictItems", "1", CVAR_ARCHIVE },
;380:#ifdef MISSIONPACK
;381:	{ &cg_deferPlayers, "cg_deferPlayers", "0", CVAR_ARCHIVE },
;382:#else
;383:	{ &cg_deferPlayers, "cg_deferPlayers", "1", CVAR_ARCHIVE },
;384:#endif
;385:	{ &cg_drawTeamOverlay, "cg_drawTeamOverlay", "0", CVAR_ARCHIVE | CVAR_USERINFO },
;386:	//{ &cg_teamOverlayUserinfo, "teamoverlay", "0", CVAR_ROM | CVAR_USERINFO },
;387:	{ &cg_stats, "cg_stats", "0", 0 },
;388:	{ &cg_drawFriend, "cg_drawFriend", "1", CVAR_ARCHIVE },
;389:	{ &cg_teamChatsOnly, "cg_teamChatsOnly", "0", CVAR_ARCHIVE },
;390:	{ &cg_noVoiceChats, "cg_noVoiceChats", "0", CVAR_ARCHIVE },
;391:	{ &cg_noVoiceText, "cg_noVoiceText", "0", CVAR_ARCHIVE },
;392:	// the following variables are created in other parts of the system,
;393:	// but we also reference them here
;394:	{ &cg_buildScript, "com_buildScript", "0", 0 },	// force loading of all possible data amd error on failures
;395:	{ &cg_paused, "cl_paused", "0", CVAR_ROM },
;396:	{ &cg_blood, "com_blood", "1", CVAR_ARCHIVE },
;397:	{ &cg_synchronousClients, "g_synchronousClients", "0", 0 },	// communicated by systeminfo
;398:	{ &cg_enableBreath, "cg_enableBreath", "1", 0},
;399:#ifdef MISSIONPACK
;400:	{ &cg_redTeamName, "g_redteam", DEFAULT_REDTEAM_NAME, CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_USERINFO },
;401:	{ &cg_blueTeamName, "g_blueteam", DEFAULT_BLUETEAM_NAME, CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_USERINFO },
;402:	{ &cg_currentSelectedPlayer, "cg_currentSelectedPlayer", "0", CVAR_ARCHIVE},
;403:	{ &cg_currentSelectedPlayerName, "cg_currentSelectedPlayerName", "", CVAR_ARCHIVE},
;404:	{ &cg_singlePlayer, "ui_singlePlayerActive", "0", CVAR_USERINFO},
;405:	{ &cg_enableDust, "g_enableDust", "0", CVAR_SERVERINFO},
;406:	{ &cg_singlePlayerActive, "ui_singlePlayerActive", "0", CVAR_USERINFO},
;407:	{ &cg_recordSPDemo, "ui_recordSPDemo", "0", CVAR_ARCHIVE},
;408:	{ &cg_recordSPDemoName, "ui_recordSPDemoName", "", CVAR_ARCHIVE},
;409:	{ &cg_obeliskRespawnDelay, "g_obeliskRespawnDelay", "10", CVAR_SERVERINFO},
;410:	//{ &cg_hudFiles, "cg_hudFiles", "ui/hud.txt", CVAR_ARCHIVE},
;411:#endif
;412:	{ &cg_cameraOrbit, "cg_cameraOrbit", "0", CVAR_CHEAT},
;413:	{ &cg_cameraOrbitDelay, "cg_cameraOrbitDelay", "50", CVAR_ARCHIVE},
;414:	{ &cg_timescaleFadeEnd, "cg_timescaleFadeEnd", "1", 0},
;415:	{ &cg_timescaleFadeSpeed, "cg_timescaleFadeSpeed", "0", 0},
;416:	{ &cg_timescale, "timescale", "1", 0},
;417:	{ &cg_scorePlum, "cg_scorePlums", "1", CVAR_USERINFO | CVAR_ARCHIVE},
;418:	{ &cg_smoothClients, "cg_smoothClients", "0", CVAR_USERINFO | CVAR_ARCHIVE},
;419:	{ &cg_cameraMode, "com_cameraMode", "0", CVAR_CHEAT},
;420:
;421:	{ &pmove_fixed, "pmove_fixed", "0", 0},
;422:	{ &pmove_msec, "pmove_msec", "8", 0},
;423:	{ &sv_lock_pmove, "sv_lock_pmove", "0", CVAR_SYSTEMINFO},
;424:	//{ &sv_max_timeNudge, "sv_max_timeNudge", "0", CVAR_SYSTEMINFO | CVAR_SERVERINFO},
;425:	{ &cg_noTaunt, "cg_noTaunt", "0", CVAR_ARCHIVE},
;426:	{ &cg_noProjectileTrail, "cg_noProjectileTrail", "0", CVAR_ARCHIVE},
;427:	{ &cg_smallFont, "ui_smallFont", "0.25", CVAR_ARCHIVE},
;428:	{ &cg_bigFont, "ui_bigFont", "0.4", CVAR_ARCHIVE},
;429:	{ &cg_railStyle, "cg_railStyle", "1", CVAR_ARCHIVE},
;430:	{ &cg_oldRocket, "cg_oldRocket", "1", CVAR_ARCHIVE},
;431:	{ &cg_oldPlasma, "cg_oldPlasma", "1", CVAR_ARCHIVE},
;432:	{ &cg_trueLightning, "cg_trueLightning", "0.0", CVAR_ARCHIVE},
;433://unlagged - client options
;434:	{ &cg_delag, "cg_delag", "1", CVAR_ARCHIVE | CVAR_USERINFO },
;435:	{ &cg_debugDelag, "cg_debugDelag", "0", CVAR_USERINFO | CVAR_CHEAT },
;436:	{ &cg_drawBBox, "cg_drawBBox", "0", CVAR_CHEAT },
;437:	{ &sv_fps, "sv_fps", "20", 0 },// this will be automagically copied from the server
;438:	{ &cg_projectileNudge, "cg_projectileNudge", "0", CVAR_ARCHIVE },
;439:	{ &cg_optimizePrediction, "cg_optimizePrediction", "1", CVAR_ARCHIVE },
;440:	{ &cg_fastRespawn_override, "cg_fastRespawn_override", "0", CVAR_ARCHIVE | CVAR_USERINFO },
;441:
;442:
;443:		/*Weapon reload cycles*/
;444:	{ &weap_enableHook, "weap_enableHook", "0", 0, },//monkk
;445:	{ &weap_gauntletCycle, "weap_gauntletCycle", "400", 0 },
;446:	{ &weap_machinegunCycle, "weap_machinegunCycle", "100", 0 },
;447:	{ &weap_shotgunCycle, "weap_shotgunCycle", "1000", 0 },
;448:	{ &weap_grenadelauncherCycle, "weap_grenadelauncherCycle", "800", 0 },
;449:	{ &weap_lightninggunCycle, "weap_lightninggunCycle", "50", 0 },
;450:	{ &weap_rocketlauncherCycle, "weap_rocketlauncherCycle", "800", 0 },
;451:	{ &weap_railgunCycle, "weap_railgunCycle", "1500", 0 },
;452:	{ &weap_plasmagunCycle, "weap_plasmagunCycle", "100", 0 },
;453:	{ &weap_bfgCycle, "weap_bfgCycle", "200", 0 },
;454:	{ &g_DynamicGauntletCycle, "g_DynamicGauntletCycle", "0", CVAR_SYSTEMINFO },
;455:	{ &g_interference, "g_interference", "1", CVAR_SYSTEMINFO },
;456:
;457:	//#################################################
;458:	{ &g_gamemode, "g_gamemode", "0", CVAR_SERVERINFO | CVAR_SYSTEMINFO },
;459:	{ &g_delagHitscan, "g_delagHitscan", "3", CVAR_SERVERINFO | CVAR_SYSTEMINFO },
;460:	{ &g_pro_mode, "g_pro_mode", "0", CVAR_SERVERINFO },
;461:	{ &cg_enemyModel, "cg_enemyModel", "", CVAR_ARCHIVE },
;462:	{ &cg_teamModel, "cg_teamModel", "", CVAR_ARCHIVE },
;463:	{ &cg_forceColors, "cg_forceColors", "0", CVAR_ARCHIVE },
;464:	{ &cg_EnemyColors, "cg_EnemyColors", "22222", CVAR_ARCHIVE },
;465:	{ &cg_TeamColors, "cg_TeamColors", "77777", CVAR_ARCHIVE },
;466:	{ &cg_deadBodyDarken, "cg_deadBodyDarken", "1", CVAR_ARCHIVE },
;467:	{ &cg_nochatbeep, "cg_nochatbeep", "0", CVAR_ARCHIVE },
;468:	{ &cg_noteamchatbeep, "cg_noteamchatbeep", "0", CVAR_ARCHIVE },
;469:	//{ &cg_newChat, "cg_newChat", "0", CVAR_ARCHIVE },
;470:	//{ &cg_oversampleMouse, "cg_oversampleMouse", "0", CVAR_ARCHIVE },
;471:	{ &cg_muzzleFlash, "cg_muzzleFlash", "1", CVAR_ARCHIVE },
;472:	{ &cg_fullWeaponCycle, "cg_fullWeaponCycle", "0", CVAR_ARCHIVE },
;473:	{ &cg_drawDeathMessage, "cg_drawDeathMessage", "1", CVAR_ARCHIVE},
;474:	{ &cl_timeNudge, "cl_timeNudge", "0", CVAR_ROM | CVAR_USERINFO },//ROM
;475:	{ &ch_Speedometer, "ch_Speedometer", "0 0 200 350 1", CVAR_ARCHIVE },//Spike's Speedometer
;476:	{ &ch_OBDetector, "ch_OBDetector", "0 250 220 1", CVAR_ARCHIVE },//Spike's OB Detector
;477:	{ &ch_weaponSideBar, "ch_weaponSideBar", "0 9 7 4 7", CVAR_ARCHIVE },//{Display Background_color Width Hieght Spacing}
;478:	{ &ch_viewKeyPress, "ch_viewKeyPress", "0 300 200 0 7 9", CVAR_ARCHIVE },
;479:	{ &cg_pmove_fixed, "cg_pmove_fixed", "0", CVAR_USERINFO | CVAR_ARCHIVE },
;480:	{ &g_fastSwitch, "g_fastSwitch", "0", CVAR_SYSTEMINFO | CVAR_SERVERINFO },
;481:	{ &r_vertexLight, "r_vertexLight", "0", CVAR_ARCHIVE | CVAR_LATCH },//PM Skins -- WE NEED THIS!
;482:	{ &cl_packetdup, "cl_packetdup", "1", CVAR_ARCHIVE | CVAR_USERINFO }, //Lucron players command
;483:	{ &s_announcer, "s_announcer", "feedback", CVAR_ARCHIVE },
;484:	{ &cg_fixedTeleporterAngles, "cg_fixedTeleporterAngles", "0", CVAR_ARCHIVE | CVAR_USERINFO },
;485:	{ &cg_railHum, "cg_railHum", "1", CVAR_ARCHIVE },
;486:	{ &cg_adjustTeamColors, "cg_adjustTeamColors", "0", CVAR_ARCHIVE },
;487:	{ &language, "language", "en", CVAR_ARCHIVE },
;488:	{ &cg_autoScreenshot, "cg_autoScreenshot", "0", CVAR_ARCHIVE },
;489:	{ &cg_autoRecord, "cg_autoRecord", "0", CVAR_ARCHIVE },
;490:	{ &cg_motdDisplayTime, "cg_motdDisplayTime", "10", CVAR_ARCHIVE },
;491:	//Superhud - Begin
;492:	{ &ch_file, "ch_file", "", CVAR_ARCHIVE }, //We'll need to do a strlen check every place we use the superhud.
;493:	//Superhud - End
;494:	{ &cg_crosshairPulse, "cg_crosshairPulse", "1", CVAR_ARCHIVE },
;495:	{ &cg_oldScoreboard, "cg_oldScoreboard", "0", CVAR_ARCHIVE },
;496:	{ &ch_shadowOffset, "ch_shadowOffset", "1", CVAR_ARCHIVE },
;497:	{ &cg_redName, "g_redName", "Ztroggz", CVAR_ARCHIVE },
;498:	{ &cg_blueName, "g_blueName", "Paganz", CVAR_ARCHIVE },
;499:	{ &cg_debugModels, "cg_debugModels", "0", CVAR_ARCHIVE },
;500:	{ &cg_fontFade, "cg_fontFade", "0", CVAR_ARCHIVE },
;501:
;502:	//CPMA
;503:	{ &cg_fallKick, "cg_fallKick", "1", CVAR_ARCHIVE },
;504:	{ &cg_damageDraw, "cg_damageDraw", "1", CVAR_ARCHIVE },
;505:	{ &cg_smoke_SG, "cg_smoke_SG", "1", CVAR_ARCHIVE },
;506:	{ &cg_smokeRadius_GL, "cg_smokeRadius_GL", "32", CVAR_ARCHIVE },
;507:	{ &cg_smokeRadius_RL, "cg_smokeRadius_RL", "64", CVAR_ARCHIVE },
;508:	{ &cg_smokeGrowth_GL, "cg_smokeGrowth_GL", "1", CVAR_ARCHIVE },
;509:	{ &cg_smokeGrowth_RL, "cg_smokeGrowth_RL", "1", CVAR_ARCHIVE },
;510:	{ &cg_lightningImpact, "cg_lightningImpact", "1", CVAR_ARCHIVE },
;511:	{ &cg_itemFX, "cg_itemFX", "7", CVAR_ARCHIVE }
;512:
;513:};
;514:
;515:static int  cvarTableSize = sizeof( cvarTable ) / sizeof( cvarTable[0] );
;516:
;517:/*
;518:=================
;519:CG_RegisterCvars
;520:=================
;521:*/
;522:void CG_RegisterCvars( void ) {
line 527
;523:	int			i;
;524:	cvarTable_t	*cv;
;525:	char		var[MAX_TOKEN_CHARS];
;526:
;527:	for ( i = 0, cv = cvarTable ; i < cvarTableSize ; i++, cv++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
ADDRGP4 cvarTable
ASGNP4
ADDRGP4 $313
JUMPV
LABELV $310
line 528
;528:		trap_Cvar_Register( cv->vmCvar, cv->cvarName,
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 530
;529:			cv->defaultString, cv->cvarFlags );
;530:	}
LABELV $311
line 527
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
LABELV $313
ADDRLP4 4
INDIRI4
ADDRGP4 cvarTableSize
INDIRI4
LTI4 $310
line 533
;531:
;532:	// see if we are also running the server on this machine
;533:	trap_Cvar_VariableStringBuffer( "sv_running", var, sizeof( var ) );
ADDRGP4 $314
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 534
;534:	cgs.localServer = atoi( var );
ADDRLP4 8
ARGP4
ADDRLP4 1032
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+31452
ADDRLP4 1032
INDIRI4
ASGNI4
line 536
;535:
;536:	forceModelModificationCount = cg_forceModel.modificationCount;
ADDRGP4 forceModelModificationCount
ADDRGP4 cg_forceModel+4
INDIRI4
ASGNI4
line 537
;537:	enemyModelModificationCount = cg_enemyModel.modificationCount;
ADDRGP4 enemyModelModificationCount
ADDRGP4 cg_enemyModel+4
INDIRI4
ASGNI4
line 538
;538:	teamModelModificationCount = cg_teamModel.modificationCount;
ADDRGP4 teamModelModificationCount
ADDRGP4 cg_teamModel+4
INDIRI4
ASGNI4
line 541
;539:
;540:
;541:	trap_Cvar_Register(NULL, "model", DEFAULT_MODEL, CVAR_USERINFO | CVAR_ARCHIVE );
CNSTP4 0
ARGP4
ADDRGP4 $319
ARGP4
ADDRGP4 $320
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 542
;542:	trap_Cvar_Register(NULL, "headmodel", DEFAULT_MODEL, CVAR_USERINFO | CVAR_ARCHIVE );
CNSTP4 0
ARGP4
ADDRGP4 $321
ARGP4
ADDRGP4 $320
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 543
;543:	trap_Cvar_Register(NULL, "team_model", DEFAULT_TEAM_MODEL, CVAR_USERINFO | CVAR_ARCHIVE );
CNSTP4 0
ARGP4
ADDRGP4 $322
ARGP4
ADDRGP4 $320
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 544
;544:	trap_Cvar_Register(NULL, "team_headmodel", DEFAULT_TEAM_HEAD, CVAR_USERINFO | CVAR_ARCHIVE );
CNSTP4 0
ARGP4
ADDRGP4 $323
ARGP4
ADDRGP4 $320
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 545
;545:}
LABELV $309
endproc CG_RegisterCvars 1036 16
proc CG_ForceModelChange 32 8
line 552
;546:
;547:/*																																			
;548:===================
;549:CG_ForceModelChange
;550:===================
;551:*/
;552:static void CG_ForceModelChange( int type ) {
line 555
;553:	int		i;
;554:
;555:	for (i=0 ; i<MAX_CLIENTS ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $325
line 558
;556:		const char		*clientInfo;
;557:
;558:		clientInfo = CG_ConfigString( CS_PLAYERS+i );
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 8
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 559
;559:		if ( !clientInfo[0] ) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $329
line 560
;560:			continue;
ADDRGP4 $326
JUMPV
LABELV $329
line 562
;561:		}
;562:		if ( type == 0 || (type == 2 && isTeammate(&cgs.clientinfo[i], i) ) || ( type == 1 && isEnemy(&cgs.clientinfo[i], i) ) ) {
ADDRLP4 12
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $336
ADDRLP4 12
INDIRI4
CNSTI4 2
NEI4 $337
CNSTI4 1776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+40960
ADDP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 isTeammate
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $336
LABELV $337
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $331
CNSTI4 1776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+40960
ADDP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 isEnemy
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $331
LABELV $336
line 563
;563:			CG_NewClientInfo( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_NewClientInfo
CALLV
pop
line 564
;564:		}
LABELV $331
line 565
;565:	}
LABELV $326
line 555
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $325
line 566
;566:}
LABELV $324
endproc CG_ForceModelChange 32 8
proc CG_RegisterAnnouncerSounds 152 16
line 575
;567:
;568:/*
;569:=================
;570:CG_RegisterAnnouncerSounds
;571:
;572:Called to register and re-register custom announcers
;573:=================
;574:*/
;575:static void CG_RegisterAnnouncerSounds( void ) {
line 578
;576:	char	path[MAX_QPATH];
;577:
;578:	memset(path, 0, sizeof(path));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 579
;579:	memset(&cgs.media.oneMinuteSound, 0, sizeof(cgs.media.oneMinuteSound));
ADDRGP4 cgs+156680+820
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 580
;580:	Com_sprintf(path, sizeof(path), "sound/%s/1_minute.wav", s_announcer.string);
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $343
ARGP4
ADDRGP4 s_announcer+16
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 581
;581:	if ( CG_FileExists(path) ) {
ADDRLP4 0
ARGP4
ADDRLP4 64
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $345
line 582
;582:		cgs.media.oneMinuteSound = trap_S_RegisterSound( path, qtrue );
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 68
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+820
ADDRLP4 68
INDIRI4
ASGNI4
line 583
;583:	} else {
ADDRGP4 $346
JUMPV
LABELV $345
line 584
;584:		cgs.media.oneMinuteSound = trap_S_RegisterSound( "sound/feedback/1_minute.wav", qtrue );
ADDRGP4 $351
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 68
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+820
ADDRLP4 68
INDIRI4
ASGNI4
line 585
;585:	}
LABELV $346
line 587
;586:
;587:	memset(path, 0, sizeof(path));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 588
;588:	memset(&cgs.media.fiveMinuteSound, 0, sizeof(cgs.media.fiveMinuteSound));
ADDRGP4 cgs+156680+824
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 589
;589:	Com_sprintf(path, sizeof(path), "sound/%s/5_minute.wav", s_announcer.string);
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $356
ARGP4
ADDRGP4 s_announcer+16
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 590
;590:	if ( CG_FileExists(path) ) {
ADDRLP4 0
ARGP4
ADDRLP4 68
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $358
line 591
;591:		cgs.media.fiveMinuteSound = trap_S_RegisterSound( path, qtrue );
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 72
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+824
ADDRLP4 72
INDIRI4
ASGNI4
line 592
;592:	} else {
ADDRGP4 $359
JUMPV
LABELV $358
line 593
;593:		cgs.media.oneMinuteSound = trap_S_RegisterSound( "sound/feedback/5_minute.wav", qtrue );
ADDRGP4 $364
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 72
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+820
ADDRLP4 72
INDIRI4
ASGNI4
line 594
;594:	}
LABELV $359
line 596
;595:
;596:	memset(path, 0, sizeof(path));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 597
;597:	memset(&cgs.media.suddenDeathSound, 0, sizeof(cgs.media.suddenDeathSound));
ADDRGP4 cgs+156680+828
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 598
;598:	Com_sprintf(path, sizeof(path), "sound/%s/sudden_death.wav", s_announcer.string);
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $369
ARGP4
ADDRGP4 s_announcer+16
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 599
;599:	if ( CG_FileExists(path) ) {
ADDRLP4 0
ARGP4
ADDRLP4 72
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
EQI4 $371
line 600
;600:		cgs.media.suddenDeathSound = trap_S_RegisterSound( path, qtrue );
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 76
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+828
ADDRLP4 76
INDIRI4
ASGNI4
line 601
;601:	} else {
ADDRGP4 $372
JUMPV
LABELV $371
line 602
;602:		cgs.media.oneMinuteSound = trap_S_RegisterSound( "sound/feedback/sudden_death.wav", qtrue );
ADDRGP4 $377
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 76
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+820
ADDRLP4 76
INDIRI4
ASGNI4
line 603
;603:	}
LABELV $372
line 605
;604:
;605:	memset(path, 0, sizeof(path));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 606
;606:	memset(&cgs.media.oneFragSound, 0, sizeof(cgs.media.oneFragSound));
ADDRGP4 cgs+156680+840
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 607
;607:	Com_sprintf(path, sizeof(path), "sound/%s/1_frag.wav", s_announcer.string);
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $382
ARGP4
ADDRGP4 s_announcer+16
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 608
;608:	if ( CG_FileExists(path) ) {
ADDRLP4 0
ARGP4
ADDRLP4 76
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
EQI4 $384
line 609
;609:		cgs.media.oneFragSound = trap_S_RegisterSound( path, qtrue );
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 80
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+840
ADDRLP4 80
INDIRI4
ASGNI4
line 610
;610:	} else {
ADDRGP4 $385
JUMPV
LABELV $384
line 611
;611:		cgs.media.oneMinuteSound = trap_S_RegisterSound( "sound/feedback/1_frag.wav", qtrue );
ADDRGP4 $390
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 80
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+820
ADDRLP4 80
INDIRI4
ASGNI4
line 612
;612:	}
LABELV $385
line 614
;613:
;614:	memset(path, 0, sizeof(path));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 615
;615:	memset(&cgs.media.twoFragSound, 0, sizeof(cgs.media.twoFragSound));
ADDRGP4 cgs+156680+836
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 616
;616:	Com_sprintf(path, sizeof(path), "sound/%s/2_frags.wav", s_announcer.string);
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $395
ARGP4
ADDRGP4 s_announcer+16
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 617
;617:	if ( CG_FileExists(path) ) {
ADDRLP4 0
ARGP4
ADDRLP4 80
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
EQI4 $397
line 618
;618:		cgs.media.twoFragSound = trap_S_RegisterSound( path, qtrue );
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 84
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+836
ADDRLP4 84
INDIRI4
ASGNI4
line 619
;619:	} else {
ADDRGP4 $398
JUMPV
LABELV $397
line 620
;620:		cgs.media.oneMinuteSound = trap_S_RegisterSound( "sound/feedback/2_frags.wav", qtrue );
ADDRGP4 $403
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 84
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+820
ADDRLP4 84
INDIRI4
ASGNI4
line 621
;621:	}
LABELV $398
line 623
;622:
;623:	memset(path, 0, sizeof(path));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 624
;624:	memset(&cgs.media.threeFragSound, 0, sizeof(cgs.media.threeFragSound));
ADDRGP4 cgs+156680+832
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 625
;625:		Com_sprintf(path, sizeof(path), "sound/%s/3_frags.wav", s_announcer.string);
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $408
ARGP4
ADDRGP4 s_announcer+16
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 626
;626:	if ( CG_FileExists(path) ) {
ADDRLP4 0
ARGP4
ADDRLP4 84
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
EQI4 $410
line 627
;627:	cgs.media.threeFragSound = trap_S_RegisterSound( path, qtrue );
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 88
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+832
ADDRLP4 88
INDIRI4
ASGNI4
line 628
;628:	} else {
ADDRGP4 $411
JUMPV
LABELV $410
line 629
;629:		cgs.media.oneMinuteSound = trap_S_RegisterSound( "sound/feedback/3_frags.wav", qtrue );
ADDRGP4 $416
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 88
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+820
ADDRLP4 88
INDIRI4
ASGNI4
line 630
;630:	}
LABELV $411
line 632
;631:
;632:	memset(path, 0, sizeof(path));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 633
;633:	memset(&cgs.media.count3Sound, 0, sizeof(cgs.media.count3Sound));
ADDRGP4 cgs+156680+1052
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 634
;634:	Com_sprintf(path, sizeof(path), "sound/%s/three.wav", s_announcer.string);
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $421
ARGP4
ADDRGP4 s_announcer+16
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 635
;635:	if ( CG_FileExists(path) ) {
ADDRLP4 0
ARGP4
ADDRLP4 88
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
EQI4 $423
line 636
;636:		cgs.media.count3Sound = trap_S_RegisterSound( path, qtrue );
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 92
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+1052
ADDRLP4 92
INDIRI4
ASGNI4
line 637
;637:	} else {
ADDRGP4 $424
JUMPV
LABELV $423
line 638
;638:		cgs.media.oneMinuteSound = trap_S_RegisterSound( "sound/feedback/three.wav", qtrue );
ADDRGP4 $429
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 92
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+820
ADDRLP4 92
INDIRI4
ASGNI4
line 639
;639:	}
LABELV $424
line 641
;640:
;641:	memset(path, 0, sizeof(path));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 642
;642:	memset(&cgs.media.count2Sound, 0, sizeof(cgs.media.count2Sound));
ADDRGP4 cgs+156680+1056
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 643
;643:	Com_sprintf(path, sizeof(path), "sound/%s/two.wav", s_announcer.string);
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $434
ARGP4
ADDRGP4 s_announcer+16
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 644
;644:	if ( CG_FileExists(path) ) {
ADDRLP4 0
ARGP4
ADDRLP4 92
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
EQI4 $436
line 645
;645:		cgs.media.count2Sound = trap_S_RegisterSound( path, qtrue );
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 96
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+1056
ADDRLP4 96
INDIRI4
ASGNI4
line 646
;646:	} else {
ADDRGP4 $437
JUMPV
LABELV $436
line 647
;647:		cgs.media.oneMinuteSound = trap_S_RegisterSound( "sound/feedback/two.wav", qtrue );
ADDRGP4 $442
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 96
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+820
ADDRLP4 96
INDIRI4
ASGNI4
line 648
;648:	}
LABELV $437
line 650
;649:
;650:	memset(path, 0, sizeof(path));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 651
;651:	memset(&cgs.media.count1Sound, 0, sizeof(cgs.media.count1Sound));
ADDRGP4 cgs+156680+1060
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 652
;652:	Com_sprintf(path, sizeof(path), "sound/%s/one.wav", s_announcer.string);
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $447
ARGP4
ADDRGP4 s_announcer+16
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 653
;653:	if ( CG_FileExists(path) ) {
ADDRLP4 0
ARGP4
ADDRLP4 96
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 0
EQI4 $449
line 654
;654:		cgs.media.count1Sound = trap_S_RegisterSound( path, qtrue );
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 100
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+1060
ADDRLP4 100
INDIRI4
ASGNI4
line 655
;655:	} else {
ADDRGP4 $450
JUMPV
LABELV $449
line 656
;656:		cgs.media.oneMinuteSound = trap_S_RegisterSound( "sound/feedback/one.wav", qtrue );
ADDRGP4 $455
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 100
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+820
ADDRLP4 100
INDIRI4
ASGNI4
line 657
;657:	}
LABELV $450
line 659
;658:
;659:	memset(path, 0, sizeof(path));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 660
;660:	memset(&cgs.media.countFightSound, 0, sizeof(cgs.media.countFightSound));
ADDRGP4 cgs+156680+1064
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 661
;661:	Com_sprintf(path, sizeof(path), "sound/%s/fight.wav", s_announcer.string);
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $460
ARGP4
ADDRGP4 s_announcer+16
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 662
;662:	if ( CG_FileExists(path) ) {
ADDRLP4 0
ARGP4
ADDRLP4 100
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
EQI4 $462
line 663
;663:		cgs.media.countFightSound = trap_S_RegisterSound( path, qtrue );
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 104
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+1064
ADDRLP4 104
INDIRI4
ASGNI4
line 664
;664:	} else {
ADDRGP4 $463
JUMPV
LABELV $462
line 665
;665:		cgs.media.oneMinuteSound = trap_S_RegisterSound( "sound/feedback/fight.wav", qtrue );
ADDRGP4 $468
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 104
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+820
ADDRLP4 104
INDIRI4
ASGNI4
line 666
;666:	}
LABELV $463
line 668
;667:
;668:	memset(path, 0, sizeof(path));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 669
;669:	memset(&cgs.media.countPrepareSound, 0, sizeof(cgs.media.countPrepareSound));
ADDRGP4 cgs+156680+1068
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 670
;670:	Com_sprintf(path, sizeof(path), "sound/%s/prepare.wav", s_announcer.string);
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $473
ARGP4
ADDRGP4 s_announcer+16
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 671
;671:	if ( CG_FileExists(path) ) {
ADDRLP4 0
ARGP4
ADDRLP4 104
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 0
EQI4 $475
line 672
;672:		cgs.media.countPrepareSound = trap_S_RegisterSound( path, qtrue );
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 108
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+1068
ADDRLP4 108
INDIRI4
ASGNI4
line 673
;673:	} else {
ADDRGP4 $476
JUMPV
LABELV $475
line 674
;674:		cgs.media.oneMinuteSound = trap_S_RegisterSound( "sound/feedback/prepare.wav", qtrue );
ADDRGP4 $481
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 108
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+820
ADDRLP4 108
INDIRI4
ASGNI4
line 675
;675:	}
LABELV $476
line 677
;676:
;677:	memset(path, 0, sizeof(path));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 678
;678:	memset(&cgs.media.redLeadsSound, 0, sizeof(cgs.media.redLeadsSound));
ADDRGP4 cgs+156680+968
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 679
;679:	Com_sprintf(path, sizeof(path), "sound/%s/redleads.wav", s_announcer.string);
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $486
ARGP4
ADDRGP4 s_announcer+16
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 680
;680:	if ( CG_FileExists(path) ) {
ADDRLP4 0
ARGP4
ADDRLP4 108
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 108
INDIRI4
CNSTI4 0
EQI4 $488
line 681
;681:		cgs.media.redLeadsSound = trap_S_RegisterSound( path, qtrue );
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 112
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+968
ADDRLP4 112
INDIRI4
ASGNI4
line 682
;682:	} else {
ADDRGP4 $489
JUMPV
LABELV $488
line 683
;683:		cgs.media.oneMinuteSound = trap_S_RegisterSound( "sound/feedback/redleads.wav", qtrue );
ADDRGP4 $494
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 112
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+820
ADDRLP4 112
INDIRI4
ASGNI4
line 684
;684:	}
LABELV $489
line 686
;685:
;686:	memset(path, 0, sizeof(path));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 687
;687:	memset(&cgs.media.blueLeadsSound, 0, sizeof(cgs.media.blueLeadsSound));
ADDRGP4 cgs+156680+972
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 688
;688:	Com_sprintf(path, sizeof(path), "sound/%s/blueleads.wav", s_announcer.string);
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $499
ARGP4
ADDRGP4 s_announcer+16
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 689
;689:	if ( CG_FileExists(path) ) {
ADDRLP4 0
ARGP4
ADDRLP4 112
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 0
EQI4 $501
line 690
;690:		cgs.media.blueLeadsSound = trap_S_RegisterSound( path, qtrue );
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 116
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+972
ADDRLP4 116
INDIRI4
ASGNI4
line 691
;691:	} else {
ADDRGP4 $502
JUMPV
LABELV $501
line 692
;692:		cgs.media.oneMinuteSound = trap_S_RegisterSound( "sound/feedback/blueleads.wav", qtrue );
ADDRGP4 $507
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 116
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+820
ADDRLP4 116
INDIRI4
ASGNI4
line 693
;693:	}
LABELV $502
line 695
;694:
;695:	memset(path, 0, sizeof(path));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 696
;696:	memset(&cgs.media.teamsTiedSound, 0, sizeof(cgs.media.teamsTiedSound));
ADDRGP4 cgs+156680+976
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 697
;697:	Com_sprintf(path, sizeof(path), "sound/%s/teamstied.wav", s_announcer.string);
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $512
ARGP4
ADDRGP4 s_announcer+16
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 698
;698:	if ( CG_FileExists(path) ) {
ADDRLP4 0
ARGP4
ADDRLP4 116
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 0
EQI4 $514
line 699
;699:		cgs.media.teamsTiedSound = trap_S_RegisterSound( path, qtrue );
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 120
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+976
ADDRLP4 120
INDIRI4
ASGNI4
line 700
;700:	} else {
ADDRGP4 $515
JUMPV
LABELV $514
line 701
;701:		cgs.media.oneMinuteSound = trap_S_RegisterSound( "sound/feedback/teamstied.wav", qtrue );
ADDRGP4 $520
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 120
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+820
ADDRLP4 120
INDIRI4
ASGNI4
line 702
;702:	}
LABELV $515
line 704
;703:
;704:	memset(path, 0, sizeof(path));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 705
;705:	memset(&cgs.media.impressiveSound, 0, sizeof(cgs.media.impressiveSound));
ADDRGP4 cgs+156680+872
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 706
;706:	Com_sprintf(path, sizeof(path), "sound/%s/impressive.wav", s_announcer.string);
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $525
ARGP4
ADDRGP4 s_announcer+16
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 707
;707:	if ( CG_FileExists(path) ) {
ADDRLP4 0
ARGP4
ADDRLP4 120
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 0
EQI4 $527
line 708
;708:		cgs.media.impressiveSound = trap_S_RegisterSound( path, qtrue );
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 124
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+872
ADDRLP4 124
INDIRI4
ASGNI4
line 709
;709:	} else {
ADDRGP4 $528
JUMPV
LABELV $527
line 710
;710:		cgs.media.oneMinuteSound = trap_S_RegisterSound( "sound/feedback/impressive.wav", qtrue );
ADDRGP4 $533
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 124
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+820
ADDRLP4 124
INDIRI4
ASGNI4
line 711
;711:	}
LABELV $528
line 713
;712:
;713:	memset(path, 0, sizeof(path));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 714
;714:	memset(&cgs.media.excellentSound, 0, sizeof(cgs.media.excellentSound));
ADDRGP4 cgs+156680+876
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 715
;715:	Com_sprintf(path, sizeof(path), "sound/%s/excellent.wav", s_announcer.string);
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $538
ARGP4
ADDRGP4 s_announcer+16
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 716
;716:	if ( CG_FileExists(path) ) {
ADDRLP4 0
ARGP4
ADDRLP4 124
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 0
EQI4 $540
line 717
;717:		cgs.media.excellentSound = trap_S_RegisterSound( path, qtrue );
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 128
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+876
ADDRLP4 128
INDIRI4
ASGNI4
line 718
;718:	} else {
ADDRGP4 $541
JUMPV
LABELV $540
line 719
;719:		cgs.media.oneMinuteSound = trap_S_RegisterSound( "sound/feedback/excellent.wav", qtrue );
ADDRGP4 $546
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 128
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+820
ADDRLP4 128
INDIRI4
ASGNI4
line 720
;720:	}
LABELV $541
line 722
;721:
;722:	memset(path, 0, sizeof(path));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 723
;723:	memset(&cgs.media.deniedSound, 0, sizeof(cgs.media.deniedSound));
ADDRGP4 cgs+156680+880
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 724
;724:	Com_sprintf(path, sizeof(path), "sound/%s/denied.wav", s_announcer.string);
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $551
ARGP4
ADDRGP4 s_announcer+16
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 725
;725:	if ( CG_FileExists(path) ) {
ADDRLP4 0
ARGP4
ADDRLP4 128
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 128
INDIRI4
CNSTI4 0
EQI4 $553
line 726
;726:		cgs.media.deniedSound = trap_S_RegisterSound( path, qtrue );
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 132
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+880
ADDRLP4 132
INDIRI4
ASGNI4
line 727
;727:	} else {
ADDRGP4 $554
JUMPV
LABELV $553
line 728
;728:		cgs.media.oneMinuteSound = trap_S_RegisterSound( "sound/feedback/denied.wav", qtrue );
ADDRGP4 $559
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 132
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+820
ADDRLP4 132
INDIRI4
ASGNI4
line 729
;729:	}
LABELV $554
line 731
;730:
;731:	memset(path, 0, sizeof(path));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 732
;732:	memset(&cgs.media.humiliationSound, 0, sizeof(cgs.media.humiliationSound));
ADDRGP4 cgs+156680+884
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 733
;733:	Com_sprintf(path, sizeof(path), "sound/%s/humiliation.wav", s_announcer.string);
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $564
ARGP4
ADDRGP4 s_announcer+16
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 734
;734:	if ( CG_FileExists(path) ) {
ADDRLP4 0
ARGP4
ADDRLP4 132
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 0
EQI4 $566
line 735
;735:		cgs.media.humiliationSound = trap_S_RegisterSound( path, qtrue );
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 136
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+884
ADDRLP4 136
INDIRI4
ASGNI4
line 736
;736:	} else {
ADDRGP4 $567
JUMPV
LABELV $566
line 737
;737:		cgs.media.oneMinuteSound = trap_S_RegisterSound( "sound/feedback/humiliation.wav", qtrue );
ADDRGP4 $572
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 136
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+820
ADDRLP4 136
INDIRI4
ASGNI4
line 738
;738:	}
LABELV $567
line 740
;739:
;740:	memset(path, 0, sizeof(path));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 741
;741:	memset(&cgs.media.takenLeadSound, 0, sizeof(cgs.media.takenLeadSound));
ADDRGP4 cgs+156680+908
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 742
;742:	Com_sprintf(path, sizeof(path), "sound/%s/takenlead.wav", s_announcer.string);
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $577
ARGP4
ADDRGP4 s_announcer+16
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 743
;743:	if ( CG_FileExists(path) ) {
ADDRLP4 0
ARGP4
ADDRLP4 136
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 0
EQI4 $579
line 744
;744:		cgs.media.takenLeadSound = trap_S_RegisterSound( path, qtrue);
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 140
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+908
ADDRLP4 140
INDIRI4
ASGNI4
line 745
;745:	} else {
ADDRGP4 $580
JUMPV
LABELV $579
line 746
;746:		cgs.media.oneMinuteSound = trap_S_RegisterSound( "sound/feedback/takenlead.wav", qtrue );
ADDRGP4 $585
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 140
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+820
ADDRLP4 140
INDIRI4
ASGNI4
line 747
;747:	}
LABELV $580
line 749
;748:
;749:	memset(path, 0, sizeof(path));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 750
;750:	memset(&cgs.media.tiedLeadSound, 0, sizeof(cgs.media.tiedLeadSound));
ADDRGP4 cgs+156680+912
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 751
;751:	Com_sprintf(path, sizeof(path), "sound/%s/tiedlead.wav", s_announcer.string);
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $590
ARGP4
ADDRGP4 s_announcer+16
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 752
;752:	if ( CG_FileExists(path) ) {
ADDRLP4 0
ARGP4
ADDRLP4 140
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $592
line 753
;753:		cgs.media.tiedLeadSound = trap_S_RegisterSound( path, qtrue);
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 144
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+912
ADDRLP4 144
INDIRI4
ASGNI4
line 754
;754:	} else {
ADDRGP4 $593
JUMPV
LABELV $592
line 755
;755:		cgs.media.oneMinuteSound = trap_S_RegisterSound( "sound/feedback/takenlead.wav", qtrue );
ADDRGP4 $585
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 144
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+820
ADDRLP4 144
INDIRI4
ASGNI4
line 756
;756:	}
LABELV $593
line 758
;757:
;758:	memset(path, 0, sizeof(path));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 759
;759:	memset(&cgs.media.lostLeadSound, 0, sizeof(cgs.media.lostLeadSound));
ADDRGP4 cgs+156680+916
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 760
;760:	Com_sprintf(path, sizeof(path), "sound/%s/lostlead.wav", s_announcer.string);
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $602
ARGP4
ADDRGP4 s_announcer+16
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 761
;761:	if ( CG_FileExists(path) ) {
ADDRLP4 0
ARGP4
ADDRLP4 144
ADDRGP4 CG_FileExists
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $604
line 762
;762:		cgs.media.lostLeadSound = trap_S_RegisterSound( path, qtrue);
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 148
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+916
ADDRLP4 148
INDIRI4
ASGNI4
line 763
;763:	} else {
ADDRGP4 $605
JUMPV
LABELV $604
line 764
;764:		cgs.media.oneMinuteSound = trap_S_RegisterSound( "sound/feedback/lostlead.wav", qtrue );
ADDRGP4 $610
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 148
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+820
ADDRLP4 148
INDIRI4
ASGNI4
line 765
;765:	}
LABELV $605
line 766
;766:}
LABELV $338
endproc CG_RegisterAnnouncerSounds 152 16
data
export cgSoundOff
align 4
LABELV cgSoundOff
byte 4 0
export CG_UpdateCvars
code
proc CG_UpdateCvars 40 16
line 774
;767:
;768:/*
;769:=================
;770:CG_UpdateCvars
;771:=================
;772:*/
;773:qboolean cgSoundOff = qfalse;
;774:void CG_UpdateCvars( void ) {
line 778
;775:	int			i;
;776:	cvarTable_t	*cv;
;777:
;778:	for ( i = 0, cv = cvarTable ; i < cvarTableSize ; i++, cv++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
ADDRGP4 cvarTable
ASGNP4
ADDRGP4 $615
JUMPV
LABELV $612
line 783
;779://unlagged - client options
;780:		// clamp the value between 0 and 999
;781:		// negative values would suck - people could conceivably shoot other
;782:		// players *long* after they had left the area, on purpose
;783:		if ( cv->vmCvar == &cg_aimNudge ) {
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
ADDRGP4 cg_aimNudge
CVPU4 4
NEU4 $616
line 784
;784:			CG_Cvar_ClampInt( cv->cvarName, cv->vmCvar, 0, 999 );
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 999
ARGI4
ADDRGP4 CG_Cvar_ClampInt
CALLI4
pop
line 785
;785:		} else
ADDRGP4 $617
JUMPV
LABELV $616
line 791
;786:		// cl_timenudge less than -50 or greater than 50 doesn't actually
;787:		// do anything more than -50 or 50 (actually the numbers are probably
;788:		// closer to -30 and 30, but 50 is nice and round-ish)
;789:		// might as well not feed the myth, eh?
;790:		//else 
;791:		if ( cv->vmCvar == &cl_timeNudge ) {
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
ADDRGP4 cl_timeNudge
CVPU4 4
NEU4 $618
line 792
;792:			CG_Cvar_ClampInt( cv->cvarName, cv->vmCvar, 0, 0 );
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 CG_Cvar_ClampInt
CALLI4
pop
line 793
;793:		} else if ( cv->vmCvar == &rate ) {
ADDRGP4 $619
JUMPV
LABELV $618
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
ADDRGP4 rate
CVPU4 4
NEU4 $620
line 794
;794:			CG_Cvar_ClampInt( cv->cvarName, cv->vmCvar, cgs.minRate, 99999 );
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRGP4 cgs+157804
INDIRI4
ARGI4
CNSTI4 99999
ARGI4
ADDRGP4 CG_Cvar_ClampInt
CALLI4
pop
line 795
;795:		} else if ( cv->vmCvar == &snaps ) {
ADDRGP4 $621
JUMPV
LABELV $620
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
ADDRGP4 snaps
CVPU4 4
NEU4 $623
line 796
;796:			CG_Cvar_ClampInt( cv->cvarName, cv->vmCvar, sv_fps.integer, 125 );
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRGP4 sv_fps+12
INDIRI4
ARGI4
CNSTI4 125
ARGI4
ADDRGP4 CG_Cvar_ClampInt
CALLI4
pop
line 797
;797:		} else if ( cv->vmCvar == &cg_railHum && cgs.railHum != -2 && cv->vmCvar->integer != cgs.railHum ) {
ADDRGP4 $624
JUMPV
LABELV $623
ADDRLP4 8
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CVPU4 4
ADDRGP4 cg_railHum
CVPU4 4
NEU4 $626
ADDRGP4 cgs+157808
INDIRI4
CNSTI4 -2
EQI4 $626
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRGP4 cgs+157808
INDIRI4
EQI4 $626
line 800
;798:			//This print out is really stupid since clampInt also prints out a message..
;799:			//But it's for euro's that don't understand that allowed 0 to 0 means only 0 is allowed..
;800:			CG_Printf("^7Warning: cg_railHum is locked to %i on this server.\n", cgs.railHum);
ADDRGP4 $630
ARGP4
ADDRGP4 cgs+157808
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 801
;801:			CG_Cvar_ClampInt( cv->cvarName, cv->vmCvar, cgs.railHum, cgs.railHum);
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRGP4 cgs+157808
INDIRI4
ARGI4
ADDRGP4 cgs+157808
INDIRI4
ARGI4
ADDRGP4 CG_Cvar_ClampInt
CALLI4
pop
line 802
;802:		} else if ( cv->vmCvar == &com_maxfps && cv->vmCvar->modificationCount != maxFpsModificationCount ) {
ADDRGP4 $627
JUMPV
LABELV $626
ADDRLP4 12
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CVPU4 4
ADDRGP4 com_maxfps
CVPU4 4
NEU4 $634
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRGP4 maxFpsModificationCount
INDIRI4
EQI4 $634
line 803
;803:			maxFpsModificationCount = cv->vmCvar->modificationCount;
ADDRGP4 maxFpsModificationCount
ADDRLP4 0
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 804
;804:			if ( !(atoi(Info_ValueForKey( CG_ConfigString(CS_SYSTEMINFO), "sv_cheats" ))) ) {
CNSTI4 1
ARGI4
ADDRLP4 16
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 $638
ARGP4
ADDRLP4 20
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $635
line 805
;805:				CG_Cvar_ClampInt( cv->cvarName, cv->vmCvar, 30, 125 );
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
CNSTI4 30
ARGI4
CNSTI4 125
ARGI4
ADDRGP4 CG_Cvar_ClampInt
CALLI4
pop
line 806
;806:			}
line 807
;807:		} else if ( cv->vmCvar == &cl_maxpackets ) {
ADDRGP4 $635
JUMPV
LABELV $634
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
ADDRGP4 cl_maxpackets
CVPU4 4
NEU4 $639
line 808
;808:			CG_Cvar_ClampInt( cv->cvarName, cv->vmCvar, 30, 125 );
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
CNSTI4 30
ARGI4
CNSTI4 125
ARGI4
ADDRGP4 CG_Cvar_ClampInt
CALLI4
pop
line 809
;809:		} else if ( cv->vmCvar == &cg_adjustTeamColors ) {
ADDRGP4 $640
JUMPV
LABELV $639
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
ADDRGP4 cg_adjustTeamColors
CVPU4 4
NEU4 $641
line 810
;810:			CG_Cvar_ClampInt(cv->cvarName, cv->vmCvar, 0, (strlen(cg_TeamColors.string) > strlen(cg_EnemyColors.string)) ? strlen(cg_TeamColors.string) : strlen(cg_EnemyColors.string) );
ADDRGP4 cg_TeamColors+16
ARGP4
ADDRLP4 20
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 24
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
LEI4 $648
ADDRGP4 cg_TeamColors+16
ARGP4
ADDRLP4 28
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 28
INDIRI4
ASGNI4
ADDRGP4 $649
JUMPV
LABELV $648
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 32
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 32
INDIRI4
ASGNI4
LABELV $649
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 CG_Cvar_ClampInt
CALLI4
pop
line 811
;811:		} else if ( cv->vmCvar == &s_announcer) {
ADDRGP4 $642
JUMPV
LABELV $641
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
ADDRGP4 s_announcer
CVPU4 4
NEU4 $650
line 812
;812:			CG_RegisterAnnouncerSounds();
ADDRGP4 CG_RegisterAnnouncerSounds
CALLV
pop
line 813
;813:		}
ADDRGP4 $651
JUMPV
LABELV $650
line 816
;814:
;815://unlagged - client options
;816:		else if( cv->vmCvar == &s_ambient ) {
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
ADDRGP4 s_ambient
CVPU4 4
NEU4 $652
line 817
;817:			if( s_ambient.integer == 0 && !cgSoundOff ) {
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 s_ambient+12
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $654
ADDRGP4 cgSoundOff
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $654
line 818
;818:				trap_S_StopBackgroundTrack();
ADDRGP4 trap_S_StopBackgroundTrack
CALLV
pop
line 819
;819:				cgSoundOff = qtrue;
ADDRGP4 cgSoundOff
CNSTI4 1
ASGNI4
line 820
;820:			}
ADDRGP4 $653
JUMPV
LABELV $654
line 821
;821:			else if( s_ambient.integer != 0 && cgSoundOff ) {
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRGP4 s_ambient+12
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $653
ADDRGP4 cgSoundOff
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $653
line 822
;822:				cgSoundOff = qfalse;
ADDRGP4 cgSoundOff
CNSTI4 0
ASGNI4
line 823
;823:				CG_StartMusic();
ADDRGP4 CG_StartMusic
CALLV
pop
line 824
;824:			}
line 826
;825:		// clamp aimtype to acceptable values
;826:		} else if ( cv->vmCvar == &cg_aimType ) {
ADDRGP4 $653
JUMPV
LABELV $652
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
ADDRGP4 cg_aimType
CVPU4 4
NEU4 $660
line 827
;827:			CG_Cvar_ClampInt( cv->cvarName, cv->vmCvar, 0, 3 );
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 CG_Cvar_ClampInt
CALLI4
pop
line 828
;828:		}
LABELV $660
LABELV $653
LABELV $651
LABELV $642
LABELV $640
LABELV $635
LABELV $627
LABELV $624
LABELV $621
LABELV $619
LABELV $617
line 830
;829:
;830:		trap_Cvar_Update( cv->vmCvar );
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 831
;831:	}
LABELV $613
line 778
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
LABELV $615
ADDRLP4 4
INDIRI4
ADDRGP4 cvarTableSize
INDIRI4
LTI4 $612
line 851
;832:
;833:	// check for modications here
;834:
;835:	// If team overlay is on, ask for updates from the server.  If its off,
;836:	// let the server know so we don't receive it
;837:	//if ( drawTeamOverlayModificationCount != cg_drawTeamOverlay.modificationCount ) {
;838:	//	drawTeamOverlayModificationCount = cg_drawTeamOverlay.modificationCount;
;839:
;840:	// Make sure this doesn't have adverse effects
;841:	//	if ( cg_drawTeamOverlay.integer > 0 ) {
;842:	//		trap_Cvar_Set( "teamoverlay", "1" );
;843:	//	} else {
;844:	//		trap_Cvar_Set( "teamoverlay", "0" );
;845:		//}
;846:		// FIXME E3 HACK
;847:		//trap_Cvar_Set( "teamoverlay", "1" );
;848:	//}
;849:
;850:	//PM Skin color cvars modification checks
;851:	if ( colorsModificationCount != colors.modificationCount ) {
ADDRGP4 colorsModificationCount
INDIRI4
ADDRGP4 colors+4
INDIRI4
EQI4 $662
line 852
;852:		colorsModificationCount = colors.modificationCount;
ADDRGP4 colorsModificationCount
ADDRGP4 colors+4
INDIRI4
ASGNI4
line 854
;853:		//Do a strlen check, can't be less than 5
;854:		if ( strlen(colors.string) != 5 ) {
ADDRGP4 colors+16
ARGP4
ADDRLP4 8
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 5
EQI4 $666
line 855
;855:			CG_Printf("^3Error: Colors must have 5 values\n^3Resetting to default\n");
ADDRGP4 $669
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 856
;856:			trap_Cvar_Set( "Colors", "17776" );
ADDRGP4 $670
ARGP4
ADDRGP4 $95
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 857
;857:		}
LABELV $666
line 858
;858:		CG_ParseColors(COLORS, colors.string, strlen(colors.string) );
ADDRGP4 colors+16
ARGP4
ADDRLP4 12
ADDRGP4 strlen
CALLI4
ASGNI4
CNSTI4 0
ARGI4
ADDRGP4 colors+16
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 CG_ParseColors
CALLV
pop
line 859
;859:	}
LABELV $662
line 860
;860:	if ( teamColorsModificationCount != cg_TeamColors.modificationCount ) {
ADDRGP4 teamColorsModificationCount
INDIRI4
ADDRGP4 cg_TeamColors+4
INDIRI4
EQI4 $673
line 861
;861:		teamColorsModificationCount = cg_TeamColors.modificationCount;
ADDRGP4 teamColorsModificationCount
ADDRGP4 cg_TeamColors+4
INDIRI4
ASGNI4
line 862
;862:		if ( strlen(cg_TeamColors.string) && (strlen(cg_TeamColors.string) < 2 || strlen(cg_TeamColors.string) > 5) ) {
ADDRGP4 cg_TeamColors+16
ARGP4
ADDRLP4 8
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $677
ADDRGP4 cg_TeamColors+16
ARGP4
ADDRLP4 12
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 2
LTI4 $682
ADDRGP4 cg_TeamColors+16
ARGP4
ADDRLP4 16
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 5
LEI4 $677
LABELV $682
line 863
;863:			CG_Printf("^3Error: cg_TeamColors must have a minimum of 2 values and a maximum of 5 values\n^3Resetting to default\n");
ADDRGP4 $683
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 864
;864:			trap_Cvar_Set( "cg_TeamColors", "77777" );
ADDRGP4 $256
ARGP4
ADDRGP4 $257
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 865
;865:		}
LABELV $677
line 866
;866:		CG_ParseColors(TEAM_COLORS, cg_TeamColors.string, strlen(cg_TeamColors.string) );
ADDRGP4 cg_TeamColors+16
ARGP4
ADDRLP4 20
ADDRGP4 strlen
CALLI4
ASGNI4
CNSTI4 1
ARGI4
ADDRGP4 cg_TeamColors+16
ARGP4
ADDRLP4 20
INDIRI4
ARGI4
ADDRGP4 CG_ParseColors
CALLV
pop
line 867
;867:	}
LABELV $673
line 868
;868:	if ( enemyColorsModificationCount != cg_EnemyColors.modificationCount ) {
ADDRGP4 enemyColorsModificationCount
INDIRI4
ADDRGP4 cg_EnemyColors+4
INDIRI4
EQI4 $686
line 869
;869:		enemyColorsModificationCount = cg_EnemyColors.modificationCount;
ADDRGP4 enemyColorsModificationCount
ADDRGP4 cg_EnemyColors+4
INDIRI4
ASGNI4
line 870
;870:		if ( strlen(cg_EnemyColors.string) && (strlen(cg_EnemyColors.string) < 2 || strlen(cg_EnemyColors.string) > 5) ) {
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 8
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $690
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 12
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 2
LTI4 $695
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 16
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 5
LEI4 $690
LABELV $695
line 871
;871:			CG_Printf("^3Error: cg_EnemyColors must have a minimum of 2 values and a maximum of 5 values\n^3Resetting to default\n");
ADDRGP4 $696
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 872
;872:			trap_Cvar_Set( "cg_EnemyColors", "77777" );
ADDRGP4 $254
ARGP4
ADDRGP4 $257
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 873
;873:		}
LABELV $690
line 874
;874:		CG_ParseColors(ENEMY_COLORS, cg_EnemyColors.string, strlen(cg_EnemyColors.string) );
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 20
ADDRGP4 strlen
CALLI4
ASGNI4
CNSTI4 2
ARGI4
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 20
INDIRI4
ARGI4
ADDRGP4 CG_ParseColors
CALLV
pop
line 875
;875:	}
LABELV $686
line 879
;876:	//PM Skin color cvars modification checks <- end
;877:
;878:	// if force model changed
;879:	if ( forceModelModificationCount != cg_forceModel.modificationCount ) {
ADDRGP4 forceModelModificationCount
INDIRI4
ADDRGP4 cg_forceModel+4
INDIRI4
EQI4 $699
line 880
;880:		forceModelModificationCount = cg_forceModel.modificationCount;
ADDRGP4 forceModelModificationCount
ADDRGP4 cg_forceModel+4
INDIRI4
ASGNI4
line 881
;881:		CG_ForceModelChange( 0 );
CNSTI4 0
ARGI4
ADDRGP4 CG_ForceModelChange
CALLV
pop
line 882
;882:	}
LABELV $699
line 884
;883:	//Evo:Model:Begin
;884:	if ( enemyModelModificationCount != cg_enemyModel.modificationCount ) {
ADDRGP4 enemyModelModificationCount
INDIRI4
ADDRGP4 cg_enemyModel+4
INDIRI4
EQI4 $703
line 885
;885:		enemyModelModificationCount = cg_enemyModel.modificationCount;
ADDRGP4 enemyModelModificationCount
ADDRGP4 cg_enemyModel+4
INDIRI4
ASGNI4
line 886
;886:		CG_ForceModelChange( 1 );
CNSTI4 1
ARGI4
ADDRGP4 CG_ForceModelChange
CALLV
pop
line 887
;887:	}
LABELV $703
line 888
;888:	if ( teamModelModificationCount != cg_teamModel.modificationCount ) {
ADDRGP4 teamModelModificationCount
INDIRI4
ADDRGP4 cg_teamModel+4
INDIRI4
EQI4 $707
line 889
;889:		teamModelModificationCount = cg_teamModel.modificationCount;
ADDRGP4 teamModelModificationCount
ADDRGP4 cg_teamModel+4
INDIRI4
ASGNI4
line 890
;890:		CG_ForceModelChange( 2 );
CNSTI4 2
ARGI4
ADDRGP4 CG_ForceModelChange
CALLV
pop
line 891
;891:	}
LABELV $707
line 892
;892:}
LABELV $611
endproc CG_UpdateCvars 40 16
export CG_CrosshairPlayer
proc CG_CrosshairPlayer 0 0
line 894
;893:
;894:int CG_CrosshairPlayer( void ) {
line 895
;895:	if ( cg.time > ( cg.crosshairClientTime + 1000 ) ) {
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+130552
INDIRI4
CNSTI4 1000
ADDI4
LEI4 $712
line 896
;896:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $711
JUMPV
LABELV $712
line 898
;897:	}
;898:	return cg.crosshairClientNum;
ADDRGP4 cg+130548
INDIRI4
RETI4
LABELV $711
endproc CG_CrosshairPlayer 0 0
export CG_LastAttacker
proc CG_LastAttacker 0 0
line 901
;899:}
;900:
;901:int CG_LastAttacker( void ) {
line 902
;902:	if ( !cg.attackerTime ) {
ADDRGP4 cg+130564
INDIRI4
CNSTI4 0
NEI4 $718
line 903
;903:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $717
JUMPV
LABELV $718
line 905
;904:	}
;905:	return cg.snap->ps.persistant[PERS_ATTACKER];
ADDRGP4 cg+36
INDIRP4
CNSTI4 316
ADDP4
INDIRI4
RETI4
LABELV $717
endproc CG_LastAttacker 0 0
export CG_Printf
proc CG_Printf 1028 12
line 908
;906:}
;907:
;908:void QDECL CG_Printf( const char *msg, ... ) {
line 912
;909:	va_list		argptr;
;910:	char		text[1024];
;911:
;912:	va_start (argptr, msg);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 913
;913:	vsprintf (text, msg, argptr);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 914
;914:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 916
;915:
;916:	trap_Print( text );
ADDRLP4 4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 917
;917:}
LABELV $722
endproc CG_Printf 1028 12
export CG_Error
proc CG_Error 1028 12
line 919
;918:
;919:void QDECL CG_Error( const char *msg, ... ) {
line 923
;920:	va_list		argptr;
;921:	char		text[1024];
;922:
;923:	va_start (argptr, msg);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 924
;924:	vsprintf (text, msg, argptr);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 925
;925:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 927
;926:
;927:	trap_Error( text );
ADDRLP4 4
ARGP4
ADDRGP4 trap_Error
CALLV
pop
line 928
;928:}
LABELV $724
endproc CG_Error 1028 12
export Com_Error
proc Com_Error 1028 12
line 933
;929:
;930:#ifndef CGAME_HARD_LINKED
;931:// this is only here so the functions in q_shared.c and bg_*.c can link (FIXME)
;932:
;933:void QDECL Com_Error( int level, const char *error, ... ) {
line 937
;934:	va_list		argptr;
;935:	char		text[1024];
;936:
;937:	va_start (argptr, error);
ADDRLP4 0
ADDRFP4 4+4
ASGNP4
line 938
;938:	vsprintf (text, error, argptr);
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 939
;939:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 941
;940:
;941:	CG_Error( "%s", text);
ADDRGP4 $728
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 942
;942:}
LABELV $726
endproc Com_Error 1028 12
export Com_Printf
proc Com_Printf 1028 12
line 944
;943:
;944:void QDECL Com_Printf( const char *msg, ... ) {
line 948
;945:	va_list		argptr;
;946:	char		text[1024];
;947:
;948:	va_start (argptr, msg);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 949
;949:	vsprintf (text, msg, argptr);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 950
;950:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 952
;951:
;952:	CG_Printf ("%s", text);
ADDRGP4 $728
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 953
;953:}
LABELV $729
endproc Com_Printf 1028 12
bss
align 1
LABELV $732
skip 1024
export CG_Argv
code
proc CG_Argv 0 12
line 962
;954:
;955:#endif
;956:
;957:/*
;958:================
;959:CG_Argv
;960:================
;961:*/
;962:const char *CG_Argv( int arg ) {
line 965
;963:	static char	buffer[MAX_STRING_CHARS];
;964:
;965:	trap_Argv( arg, buffer, sizeof( buffer ) );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $732
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 967
;966:
;967:	return buffer;
ADDRGP4 $732
RETP4
LABELV $731
endproc CG_Argv 0 12
proc CG_RegisterItemSounds 96 12
line 980
;968:}
;969:
;970:
;971://========================================================================
;972:
;973:/*
;974:=================
;975:CG_RegisterItemSounds
;976:
;977:The server says this item is used on this level
;978:=================
;979:*/
;980:static void CG_RegisterItemSounds( int itemNum ) {
line 986
;981:	gitem_t			*item;
;982:	char			data[MAX_QPATH];
;983:	char			*s, *start;
;984:	int				len;
;985:
;986:	item = &bg_itemlist[ itemNum ];
ADDRLP4 76
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 988
;987:
;988:	if( item->pickup_sound ) {
ADDRLP4 76
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $734
line 989
;989:		trap_S_RegisterSound( item->pickup_sound, qfalse );
ADDRLP4 76
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 990
;990:	}
LABELV $734
line 993
;991:
;992:	// parse the space seperated precache string for other media
;993:	s = item->sounds;
ADDRLP4 0
ADDRLP4 76
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
ASGNP4
line 994
;994:	if (!s || !s[0])
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $738
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $740
LABELV $738
line 995
;995:		return;
ADDRGP4 $733
JUMPV
LABELV $739
line 997
;996:
;997:	while (*s) {
line 998
;998:		start = s;
ADDRLP4 72
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 $743
JUMPV
LABELV $742
line 999
;999:		while (*s && *s != ' ') {
line 1000
;1000:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1001
;1001:		}
LABELV $743
line 999
ADDRLP4 84
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
EQI4 $745
ADDRLP4 84
INDIRI4
CNSTI4 32
NEI4 $742
LABELV $745
line 1003
;1002:
;1003:		len = s-start;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 72
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 1004
;1004:		if (len >= MAX_QPATH || len < 5) {
ADDRLP4 4
INDIRI4
CNSTI4 64
GEI4 $748
ADDRLP4 4
INDIRI4
CNSTI4 5
GEI4 $746
LABELV $748
line 1005
;1005:			CG_Error( "PrecacheItem: %s has bad precache string", 
ADDRGP4 $749
ARGP4
ADDRLP4 76
INDIRP4
INDIRP4
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 1007
;1006:				item->classname);
;1007:			return;
ADDRGP4 $733
JUMPV
LABELV $746
line 1009
;1008:		}
;1009:		memcpy (data, start, len);
ADDRLP4 8
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1010
;1010:		data[len] = 0;
ADDRLP4 4
INDIRI4
ADDRLP4 8
ADDP4
CNSTI1 0
ASGNI1
line 1011
;1011:		if ( *s ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $750
line 1012
;1012:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1013
;1013:		}
LABELV $750
line 1015
;1014:
;1015:		if ( !strcmp(data+len-3, "wav" )) {
ADDRLP4 4
INDIRI4
ADDRLP4 8-3
ADDP4
ARGP4
ADDRGP4 $755
ARGP4
ADDRLP4 92
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
NEI4 $752
line 1016
;1016:			trap_S_RegisterSound( data, qfalse );
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 1017
;1017:		}
LABELV $752
line 1018
;1018:	}
LABELV $740
line 997
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $739
line 1019
;1019:}
LABELV $733
endproc CG_RegisterItemSounds 96 12
proc CG_RegisterSounds 492 16
line 1028
;1020:
;1021:/*
;1022:=================
;1023:CG_RegisterSounds
;1024:
;1025:called during a precache command
;1026:=================
;1027:*/
;1028:static void CG_RegisterSounds( void ) {
line 1042
;1029:	int		i;
;1030:	char	items[MAX_ITEMS+1];
;1031:	char	name[MAX_QPATH];
;1032:	const char	*soundName;
;1033:
;1034:	//Com_sprintf(path, sizeof(path), "feedback");
;1035:	// voice commands
;1036:
;1037:#ifdef MISSIONPACK
;1038:
;1039:	CG_LoadVoiceChats();
;1040:
;1041:#endif
;1042:	CG_RegisterAnnouncerSounds();
ADDRGP4 CG_RegisterAnnouncerSounds
CALLV
pop
line 1058
;1043:	/*cgs.media.oneMinuteSound = trap_S_RegisterSound( "sound/feedback/1_minute.wav", qtrue );
;1044:	cgs.media.fiveMinuteSound = trap_S_RegisterSound( "sound/feedback/5_minute.wav", qtrue );
;1045:	cgs.media.suddenDeathSound = trap_S_RegisterSound( "sound/feedback/sudden_death.wav", qtrue );
;1046:	cgs.media.oneFragSound = trap_S_RegisterSound( "sound/feedback/1_frag.wav", qtrue );
;1047:	cgs.media.twoFragSound = trap_S_RegisterSound( "sound/feedback/2_frags.wav", qtrue );
;1048:	cgs.media.threeFragSound = trap_S_RegisterSound( "sound/feedback/3_frags.wav", qtrue );
;1049:	cgs.media.count3Sound = trap_S_RegisterSound( "sound/feedback/three.wav", qtrue );
;1050:	cgs.media.count2Sound = trap_S_RegisterSound( "sound/feedback/two.wav", qtrue );
;1051:	cgs.media.count1Sound = trap_S_RegisterSound( "sound/feedback/one.wav", qtrue );
;1052:	cgs.media.countFightSound = trap_S_RegisterSound( "sound/feedback/fight.wav", qtrue );
;1053:	cgs.media.countPrepareSound = trap_S_RegisterSound( "sound/feedback/prepare.wav", qtrue );*/
;1054:#ifdef MISSIONPACK
;1055:	cgs.media.countPrepareTeamSound = trap_S_RegisterSound( "sound/feedback/prepare_team.wav", qtrue );
;1056:#endif
;1057:
;1058:	if ( cgs.gametype >= GT_TEAM || cg_buildScript.integer ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
GEI4 $761
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $757
LABELV $761
line 1060
;1059:
;1060:		cgs.media.captureAwardSound = trap_S_RegisterSound( "sound/teamplay/flagcapture_yourteam.wav", qtrue );
ADDRGP4 $764
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 332
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+956
ADDRLP4 332
INDIRI4
ASGNI4
line 1074
;1061:
;1062:		/*memset(path, 0, sizeof(path));
;1063:		Com_sprintf(path, sizeof(path), "sound/%s/redleads.wav", s_announcer.string);
;1064:		cgs.media.redLeadsSound = trap_S_RegisterSound( path, qtrue );
;1065:
;1066:		memset(path, 0, sizeof(path));
;1067:		Com_sprintf(path, sizeof(path), "sound/%s/blueleads.wav", s_announcer.string);
;1068:		cgs.media.blueLeadsSound = trap_S_RegisterSound( path, qtrue );
;1069:
;1070:		memset(path, 0, sizeof(path));
;1071:		Com_sprintf(path, sizeof(path), "sound/%s/teamstied.wav", s_announcer.string);
;1072:		cgs.media.teamsTiedSound = trap_S_RegisterSound( path, qtrue );*/
;1073:
;1074:		cgs.media.hitTeamSound = trap_S_RegisterSound( "sound/feedback/hit_teammate.wav", qtrue );
ADDRGP4 $767
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 336
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+868
ADDRLP4 336
INDIRI4
ASGNI4
line 1076
;1075:
;1076:		cgs.media.redScoredSound = trap_S_RegisterSound( "sound/teamplay/voc_red_scores.wav", qtrue );
ADDRGP4 $770
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 340
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+960
ADDRLP4 340
INDIRI4
ASGNI4
line 1077
;1077:		cgs.media.blueScoredSound = trap_S_RegisterSound( "sound/teamplay/voc_blue_scores.wav", qtrue );
ADDRGP4 $773
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 344
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+964
ADDRLP4 344
INDIRI4
ASGNI4
line 1079
;1078:
;1079:		cgs.media.captureYourTeamSound = trap_S_RegisterSound( "sound/teamplay/flagcapture_yourteam.wav", qtrue );
ADDRGP4 $764
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 348
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+980
ADDRLP4 348
INDIRI4
ASGNI4
line 1080
;1080:		cgs.media.captureOpponentSound = trap_S_RegisterSound( "sound/teamplay/flagcapture_opponent.wav", qtrue );
ADDRGP4 $778
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 352
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+984
ADDRLP4 352
INDIRI4
ASGNI4
line 1082
;1081:
;1082:		cgs.media.returnYourTeamSound = trap_S_RegisterSound( "sound/teamplay/flagreturn_yourteam.wav", qtrue );
ADDRGP4 $781
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 356
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+988
ADDRLP4 356
INDIRI4
ASGNI4
line 1083
;1083:		cgs.media.returnOpponentSound = trap_S_RegisterSound( "sound/teamplay/flagreturn_opponent.wav", qtrue );
ADDRGP4 $784
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 360
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+992
ADDRLP4 360
INDIRI4
ASGNI4
line 1085
;1084:
;1085:		cgs.media.takenYourTeamSound = trap_S_RegisterSound( "sound/teamplay/flagtaken_yourteam.wav", qtrue );
ADDRGP4 $787
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 364
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+996
ADDRLP4 364
INDIRI4
ASGNI4
line 1086
;1086:		cgs.media.takenOpponentSound = trap_S_RegisterSound( "sound/teamplay/flagtaken_opponent.wav", qtrue );
ADDRGP4 $790
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 368
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+1000
ADDRLP4 368
INDIRI4
ASGNI4
line 1087
;1087:		cgs.media.pickedUpYourTeamSound = trap_S_RegisterSound( "sound/teamplay/flagtk_red.wav", qtrue );
ADDRGP4 $793
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 372
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+1004
ADDRLP4 372
INDIRI4
ASGNI4
line 1089
;1088:
;1089:		if ( cgs.gametype == GT_CTF || cg_buildScript.integer ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
EQI4 $798
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $794
LABELV $798
line 1090
;1090:			cgs.media.redFlagReturnedSound = trap_S_RegisterSound( "sound/teamplay/voc_red_returned.wav", qtrue );
ADDRGP4 $801
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 376
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+1008
ADDRLP4 376
INDIRI4
ASGNI4
line 1091
;1091:			cgs.media.blueFlagReturnedSound = trap_S_RegisterSound( "sound/teamplay/voc_blue_returned.wav", qtrue );
ADDRGP4 $804
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 380
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+1012
ADDRLP4 380
INDIRI4
ASGNI4
line 1092
;1092:			cgs.media.enemyTookYourFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_enemy_flag.wav", qtrue );
ADDRGP4 $807
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 384
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+1020
ADDRLP4 384
INDIRI4
ASGNI4
line 1093
;1093:			cgs.media.yourTeamTookEnemyFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_team_flag.wav", qtrue );
ADDRGP4 $810
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 388
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+1028
ADDRLP4 388
INDIRI4
ASGNI4
line 1094
;1094:		}
LABELV $794
line 1113
;1095:
;1096:#ifdef MISSIONPACK
;1097:		if ( cgs.gametype == GT_1FCTF || cg_buildScript.integer ) {
;1098:			// FIXME: get a replacement for this sound ?
;1099:			cgs.media.neutralFlagReturnedSound = trap_S_RegisterSound( "sound/teamplay/flagreturn_opponent.wav", qtrue );
;1100:			cgs.media.yourTeamTookTheFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_team_1flag.wav", qtrue );
;1101:			cgs.media.enemyTookTheFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_enemy_1flag.wav", qtrue );
;1102:		}
;1103:
;1104:		if ( cgs.gametype == GT_1FCTF || cgs.gametype == GT_CTF || cg_buildScript.integer ) {
;1105:			cgs.media.youHaveFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_you_flag.wav", qtrue );
;1106:			cgs.media.holyShitSound = trap_S_RegisterSound("sound/feedback/voc_holyshit.wav", qtrue);
;1107:		}
;1108:
;1109:		if ( cgs.gametype == GT_OBELISK || cg_buildScript.integer ) {
;1110:			cgs.media.yourBaseIsUnderAttackSound = trap_S_RegisterSound( "sound/teamplay/voc_base_attack.wav", qtrue );
;1111:		}
;1112:#else
;1113:		cgs.media.youHaveFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_you_flag.wav", qtrue );
ADDRGP4 $813
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 376
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+1036
ADDRLP4 376
INDIRI4
ASGNI4
line 1114
;1114:		cgs.media.holyShitSound = trap_S_RegisterSound("sound/feedback/voc_holyshit.wav", qtrue);
ADDRGP4 $816
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 380
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+1044
ADDRLP4 380
INDIRI4
ASGNI4
line 1115
;1115:		cgs.media.neutralFlagReturnedSound = trap_S_RegisterSound( "sound/teamplay/flagreturn_opponent.wav", qtrue );
ADDRGP4 $784
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 384
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+1016
ADDRLP4 384
INDIRI4
ASGNI4
line 1116
;1116:		cgs.media.yourTeamTookTheFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_team_1flag.wav", qtrue );
ADDRGP4 $821
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 388
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+1032
ADDRLP4 388
INDIRI4
ASGNI4
line 1117
;1117:		cgs.media.enemyTookTheFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_enemy_1flag.wav", qtrue );
ADDRGP4 $824
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 392
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+1024
ADDRLP4 392
INDIRI4
ASGNI4
line 1119
;1118:#endif
;1119:	}
LABELV $757
line 1121
;1120:
;1121:	cgs.media.grappleSound = trap_S_RegisterSound("sound/weapons/melee/fstrun.wav", qfalse);
ADDRGP4 $827
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 332
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+600
ADDRLP4 332
INDIRI4
ASGNI4
line 1122
;1122:	cgs.media.tracerSound = trap_S_RegisterSound( "sound/weapons/machinegun/buletby1.wav", qfalse );
ADDRGP4 $830
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 336
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+608
ADDRLP4 336
INDIRI4
ASGNI4
line 1123
;1123:	cgs.media.selectSound = trap_S_RegisterSound( "sound/weapons/change.wav", qfalse );
ADDRGP4 $833
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 340
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+612
ADDRLP4 340
INDIRI4
ASGNI4
line 1124
;1124:	cgs.media.wearOffSound = trap_S_RegisterSound( "sound/items/wearoff.wav", qfalse );
ADDRGP4 $836
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 344
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+620
ADDRLP4 344
INDIRI4
ASGNI4
line 1125
;1125:	cgs.media.useNothingSound = trap_S_RegisterSound( "sound/items/use_nothing.wav", qfalse );
ADDRGP4 $839
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 348
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+616
ADDRLP4 348
INDIRI4
ASGNI4
line 1126
;1126:	cgs.media.gibSound = trap_S_RegisterSound( "sound/player/gibsplt1.wav", qfalse );
ADDRGP4 $842
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 352
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+772
ADDRLP4 352
INDIRI4
ASGNI4
line 1127
;1127:	cgs.media.gibBounce1Sound = trap_S_RegisterSound( "sound/player/gibimp1.wav", qfalse );
ADDRGP4 $845
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 356
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+776
ADDRLP4 356
INDIRI4
ASGNI4
line 1128
;1128:	cgs.media.gibBounce2Sound = trap_S_RegisterSound( "sound/player/gibimp2.wav", qfalse );
ADDRGP4 $848
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 360
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+780
ADDRLP4 360
INDIRI4
ASGNI4
line 1129
;1129:	cgs.media.gibBounce3Sound = trap_S_RegisterSound( "sound/player/gibimp3.wav", qfalse );
ADDRGP4 $851
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 364
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+784
ADDRLP4 364
INDIRI4
ASGNI4
line 1148
;1130:
;1131:#ifdef MISSIONPACK
;1132:	cgs.media.useInvulnerabilitySound = trap_S_RegisterSound( "sound/items/invul_activate.wav", qfalse );
;1133:	cgs.media.invulnerabilityImpactSound1 = trap_S_RegisterSound( "sound/items/invul_impact_01.wav", qfalse );
;1134:	cgs.media.invulnerabilityImpactSound2 = trap_S_RegisterSound( "sound/items/invul_impact_02.wav", qfalse );
;1135:	cgs.media.invulnerabilityImpactSound3 = trap_S_RegisterSound( "sound/items/invul_impact_03.wav", qfalse );
;1136:	cgs.media.invulnerabilityJuicedSound = trap_S_RegisterSound( "sound/items/invul_juiced.wav", qfalse );
;1137:	cgs.media.obeliskHitSound1 = trap_S_RegisterSound( "sound/items/obelisk_hit_01.wav", qfalse );
;1138:	cgs.media.obeliskHitSound2 = trap_S_RegisterSound( "sound/items/obelisk_hit_02.wav", qfalse );
;1139:	cgs.media.obeliskHitSound3 = trap_S_RegisterSound( "sound/items/obelisk_hit_03.wav", qfalse );
;1140:	cgs.media.obeliskRespawnSound = trap_S_RegisterSound( "sound/items/obelisk_respawn.wav", qfalse );
;1141:
;1142:	cgs.media.ammoregenSound = trap_S_RegisterSound("sound/items/cl_ammoregen.wav", qfalse);
;1143:	cgs.media.doublerSound = trap_S_RegisterSound("sound/items/cl_doubler.wav", qfalse);
;1144:	cgs.media.guardSound = trap_S_RegisterSound("sound/items/cl_guard.wav", qfalse);
;1145:	cgs.media.scoutSound = trap_S_RegisterSound("sound/items/cl_scout.wav", qfalse);
;1146:#endif
;1147:
;1148:	cgs.media.teleInSound = trap_S_RegisterSound( "sound/world/telein.wav", qfalse );
ADDRGP4 $854
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 368
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+788
ADDRLP4 368
INDIRI4
ASGNI4
line 1149
;1149:	cgs.media.teleOutSound = trap_S_RegisterSound( "sound/world/teleout.wav", qfalse );
ADDRGP4 $857
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 372
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+792
ADDRLP4 372
INDIRI4
ASGNI4
line 1150
;1150:	cgs.media.respawnSound = trap_S_RegisterSound( "sound/items/respawn1.wav", qfalse );
ADDRGP4 $860
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 376
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+800
ADDRLP4 376
INDIRI4
ASGNI4
line 1152
;1151:
;1152:	cgs.media.noAmmoSound = trap_S_RegisterSound( "sound/weapons/noammo.wav", qfalse );
ADDRGP4 $863
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 380
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+796
ADDRLP4 380
INDIRI4
ASGNI4
line 1154
;1153:
;1154:	cgs.media.talkSound = trap_S_RegisterSound( "sound/player/talk.wav", qfalse );
ADDRGP4 $866
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 384
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+804
ADDRLP4 384
INDIRI4
ASGNI4
line 1155
;1155:	cgs.media.landSound = trap_S_RegisterSound( "sound/player/land1.wav", qfalse);
ADDRGP4 $869
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 388
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+808
ADDRLP4 388
INDIRI4
ASGNI4
line 1159
;1156:
;1157:	//cgs.media.hitSound = trap_S_RegisterSound( "sound/feedback/hit.wav", qfalse );
;1158:	// CPM: Hit tones
;1159:	cgs.media.hitSound[0] = trap_S_RegisterSound( "sound/feedback/hitlowest.wav", qfalse );
ADDRGP4 $872
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 392
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+844
ADDRLP4 392
INDIRI4
ASGNI4
line 1160
;1160:	cgs.media.hitSound[1] = trap_S_RegisterSound( "sound/feedback/hitlow.wav", qfalse );
ADDRGP4 $876
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 396
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+844+4
ADDRLP4 396
INDIRI4
ASGNI4
line 1161
;1161:	cgs.media.hitSound[2] = trap_S_RegisterSound( "sound/feedback/hit.wav", qfalse );
ADDRGP4 $880
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 400
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+844+8
ADDRLP4 400
INDIRI4
ASGNI4
line 1162
;1162:	cgs.media.hitSound[3] = trap_S_RegisterSound( "sound/feedback/hithigh.wav", qfalse );
ADDRGP4 $884
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 404
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+844+12
ADDRLP4 404
INDIRI4
ASGNI4
line 1186
;1163:	// end
;1164:
;1165:#ifdef MISSIONPACK
;1166:	cgs.media.hitSoundHighArmor = trap_S_RegisterSound( "sound/feedback/hithi.wav", qfalse );
;1167:	cgs.media.hitSoundLowArmor = trap_S_RegisterSound( "sound/feedback/hitlo.wav", qfalse );
;1168:#endif
;1169:
;1170:	/*memset(path, 0, sizeof(path));
;1171:	Com_sprintf(path, sizeof(path), "sound/%s/impressive.wav", s_announcer.string);
;1172:	cgs.media.impressiveSound = trap_S_RegisterSound( path, qtrue );
;1173:
;1174:	memset(path, 0, sizeof(path));
;1175:	Com_sprintf(path, sizeof(path), "sound/%s/excellent.wav", s_announcer.string);
;1176:	cgs.media.excellentSound = trap_S_RegisterSound( path, qtrue );
;1177:
;1178:	memset(path, 0, sizeof(path));
;1179:	Com_sprintf(path, sizeof(path), "sound/%s/denied.wav", s_announcer.string);
;1180:	cgs.media.deniedSound = trap_S_RegisterSound( path, qtrue );
;1181:
;1182:	memset(path, 0, sizeof(path));
;1183:	Com_sprintf(path, sizeof(path), "sound/%s/humiliation.wav", s_announcer.string);
;1184:	cgs.media.humiliationSound = trap_S_RegisterSound( path, qtrue );*/
;1185:
;1186:	cgs.media.assistSound = trap_S_RegisterSound( "sound/feedback/assist.wav", qtrue );
ADDRGP4 $887
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 408
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+888
ADDRLP4 408
INDIRI4
ASGNI4
line 1187
;1187:	cgs.media.defendSound = trap_S_RegisterSound( "sound/feedback/defense.wav", qtrue );
ADDRGP4 $890
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 412
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+892
ADDRLP4 412
INDIRI4
ASGNI4
line 1212
;1188:#ifdef MISSIONPACK
;1189:	cgs.media.firstImpressiveSound = trap_S_RegisterSound( "sound/feedback/first_impressive.wav", qtrue );
;1190:	cgs.media.firstExcellentSound = trap_S_RegisterSound( "sound/feedback/first_excellent.wav", qtrue );
;1191:	cgs.media.firstHumiliationSound = trap_S_RegisterSound( "sound/feedback/first_gauntlet.wav", qtrue );
;1192:#endif
;1193:
;1194:	/*memset(path, 0, sizeof(path));
;1195:	Com_sprintf(path, sizeof(path), "sound/%s/takenlead.wav", s_announcer.string);
;1196:	cgs.media.takenLeadSound = trap_S_RegisterSound( path, qtrue);
;1197:
;1198:	memset(path, 0, sizeof(path));
;1199:	Com_sprintf(path, sizeof(path), "sound/%s/tiedlead.wav", s_announcer.string);
;1200:	cgs.media.tiedLeadSound = trap_S_RegisterSound( path, qtrue);
;1201:
;1202:	memset(path, 0, sizeof(path));
;1203:	Com_sprintf(path, sizeof(path), "sound/%s/lostlead.wav", s_announcer.string);
;1204:	cgs.media.lostLeadSound = trap_S_RegisterSound( path, qtrue);*/
;1205:
;1206:#ifdef MISSIONPACK
;1207:	cgs.media.voteNow = trap_S_RegisterSound( "sound/feedback/vote_now.wav", qtrue);
;1208:	cgs.media.votePassed = trap_S_RegisterSound( "sound/feedback/vote_passed.wav", qtrue);
;1209:	cgs.media.voteFailed = trap_S_RegisterSound( "sound/feedback/vote_failed.wav", qtrue);
;1210:#endif
;1211:
;1212:	cgs.media.watrInSound = trap_S_RegisterSound( "sound/player/watr_in.wav", qfalse);
ADDRGP4 $893
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 416
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+932
ADDRLP4 416
INDIRI4
ASGNI4
line 1213
;1213:	cgs.media.watrOutSound = trap_S_RegisterSound( "sound/player/watr_out.wav", qfalse);
ADDRGP4 $896
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 420
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+936
ADDRLP4 420
INDIRI4
ASGNI4
line 1214
;1214:	cgs.media.watrUnSound = trap_S_RegisterSound( "sound/player/watr_un.wav", qfalse);
ADDRGP4 $899
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 424
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+940
ADDRLP4 424
INDIRI4
ASGNI4
line 1216
;1215:
;1216:	cgs.media.jumpPadSound = trap_S_RegisterSound ("sound/world/jumppad.wav", qfalse );
ADDRGP4 $902
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 428
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+816
ADDRLP4 428
INDIRI4
ASGNI4
line 1218
;1217:
;1218:	for (i=0 ; i<4 ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $903
line 1219
;1219:		Com_sprintf (name, sizeof(name), "sound/player/footsteps/step%i.wav", i+1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $907
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1220
;1220:		cgs.media.footsteps[FOOTSTEP_NORMAL][i] = trap_S_RegisterSound (name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 432
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+156680+624
ADDP4
ADDRLP4 432
INDIRI4
ASGNI4
line 1222
;1221:
;1222:		Com_sprintf (name, sizeof(name), "sound/player/footsteps/boot%i.wav", i+1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $910
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1223
;1223:		cgs.media.footsteps[FOOTSTEP_BOOT][i] = trap_S_RegisterSound (name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 436
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+156680+624+16
ADDP4
ADDRLP4 436
INDIRI4
ASGNI4
line 1225
;1224:
;1225:		Com_sprintf (name, sizeof(name), "sound/player/footsteps/flesh%i.wav", i+1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $914
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1226
;1226:		cgs.media.footsteps[FOOTSTEP_FLESH][i] = trap_S_RegisterSound (name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 440
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+156680+624+32
ADDP4
ADDRLP4 440
INDIRI4
ASGNI4
line 1228
;1227:
;1228:		Com_sprintf (name, sizeof(name), "sound/player/footsteps/mech%i.wav", i+1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $918
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1229
;1229:		cgs.media.footsteps[FOOTSTEP_MECH][i] = trap_S_RegisterSound (name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 444
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+156680+624+48
ADDP4
ADDRLP4 444
INDIRI4
ASGNI4
line 1231
;1230:
;1231:		Com_sprintf (name, sizeof(name), "sound/player/footsteps/energy%i.wav", i+1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $922
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1232
;1232:		cgs.media.footsteps[FOOTSTEP_ENERGY][i] = trap_S_RegisterSound (name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 448
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+156680+624+64
ADDP4
ADDRLP4 448
INDIRI4
ASGNI4
line 1234
;1233:
;1234:		Com_sprintf (name, sizeof(name), "sound/player/footsteps/splash%i.wav", i+1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $926
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1235
;1235:		cgs.media.footsteps[FOOTSTEP_SPLASH][i] = trap_S_RegisterSound (name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 452
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+156680+624+96
ADDP4
ADDRLP4 452
INDIRI4
ASGNI4
line 1237
;1236:
;1237:		Com_sprintf (name, sizeof(name), "sound/player/footsteps/clank%i.wav", i+1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $930
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1238
;1238:		cgs.media.footsteps[FOOTSTEP_METAL][i] = trap_S_RegisterSound (name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 456
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+156680+624+80
ADDP4
ADDRLP4 456
INDIRI4
ASGNI4
line 1239
;1239:	}
LABELV $904
line 1218
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $903
line 1242
;1240:
;1241:	// only register the items that the server says we need
;1242:	strcpy( items, CG_ConfigString( CS_ITEMS ) );
CNSTI4 27
ARGI4
ADDRLP4 432
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 72
ARGP4
ADDRLP4 432
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1244
;1243:
;1244:	for ( i = 1 ; i < bg_numItems ; i++ ) {
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $937
JUMPV
LABELV $934
line 1246
;1245://		if ( items[ i ] == '1' || cg_buildScript.integer ) {
;1246:			CG_RegisterItemSounds( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_RegisterItemSounds
CALLV
pop
line 1248
;1247://		}
;1248:	}
LABELV $935
line 1244
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $937
ADDRLP4 0
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $934
line 1250
;1249:
;1250:	for ( i = 1 ; i < MAX_SOUNDS ; i++ ) {
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $938
line 1251
;1251:		soundName = CG_ConfigString( CS_SOUNDS+i );
ADDRLP4 0
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 436
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 68
ADDRLP4 436
INDIRP4
ASGNP4
line 1252
;1252:		if ( !soundName[0] ) {
ADDRLP4 68
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $942
line 1253
;1253:			break;
ADDRGP4 $940
JUMPV
LABELV $942
line 1255
;1254:		}
;1255:		if ( soundName[0] == '*' ) {
ADDRLP4 68
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $944
line 1256
;1256:			continue;	// custom sound
ADDRGP4 $939
JUMPV
LABELV $944
line 1258
;1257:		}
;1258:		cgs.gameSounds[i] = trap_S_RegisterSound( soundName, qfalse );
ADDRLP4 68
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 440
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35836
ADDP4
ADDRLP4 440
INDIRI4
ASGNI4
line 1259
;1259:	}
LABELV $939
line 1250
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 256
LTI4 $938
LABELV $940
line 1262
;1260:
;1261:	// FIXME: only needed with item
;1262:	cgs.media.flightSound = trap_S_RegisterSound( "sound/items/flight.wav", qfalse );
ADDRGP4 $949
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 436
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+944
ADDRLP4 436
INDIRI4
ASGNI4
line 1263
;1263:	cgs.media.medkitSound = trap_S_RegisterSound ("sound/items/use_medkit.wav", qfalse);
ADDRGP4 $952
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 440
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+948
ADDRLP4 440
INDIRI4
ASGNI4
line 1264
;1264:	cgs.media.quadSound = trap_S_RegisterSound("sound/items/damage3.wav", qfalse);
ADDRGP4 $955
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 444
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+604
ADDRLP4 444
INDIRI4
ASGNI4
line 1265
;1265:	cgs.media.sfx_ric1 = trap_S_RegisterSound ("sound/weapons/machinegun/ric1.wav", qfalse);
ADDRGP4 $958
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 448
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+748
ADDRLP4 448
INDIRI4
ASGNI4
line 1266
;1266:	cgs.media.sfx_ric2 = trap_S_RegisterSound ("sound/weapons/machinegun/ric2.wav", qfalse);
ADDRGP4 $961
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 452
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+752
ADDRLP4 452
INDIRI4
ASGNI4
line 1267
;1267:	cgs.media.sfx_ric3 = trap_S_RegisterSound ("sound/weapons/machinegun/ric3.wav", qfalse);
ADDRGP4 $964
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 456
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+756
ADDRLP4 456
INDIRI4
ASGNI4
line 1268
;1268:	cgs.media.sfx_railg = trap_S_RegisterSound ("sound/weapons/railgun/railgf1a.wav", qfalse);
ADDRGP4 $967
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 460
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+760
ADDRLP4 460
INDIRI4
ASGNI4
line 1269
;1269:	cgs.media.sfx_rockexp = trap_S_RegisterSound ("sound/weapons/rocket/rocklx1a.wav", qfalse);
ADDRGP4 $970
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 464
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+764
ADDRLP4 464
INDIRI4
ASGNI4
line 1270
;1270:	cgs.media.sfx_plasmaexp = trap_S_RegisterSound ("sound/weapons/plasma/plasmx1a.wav", qfalse);
ADDRGP4 $973
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 468
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+768
ADDRLP4 468
INDIRI4
ASGNI4
line 1293
;1271:#ifdef MISSIONPACK
;1272:	cgs.media.sfx_proxexp = trap_S_RegisterSound( "sound/weapons/proxmine/wstbexpl.wav" , qfalse);
;1273:	cgs.media.sfx_nghit = trap_S_RegisterSound( "sound/weapons/nailgun/wnalimpd.wav" , qfalse);
;1274:	cgs.media.sfx_nghitflesh = trap_S_RegisterSound( "sound/weapons/nailgun/wnalimpl.wav" , qfalse);
;1275:	cgs.media.sfx_nghitmetal = trap_S_RegisterSound( "sound/weapons/nailgun/wnalimpm.wav", qfalse );
;1276:	cgs.media.sfx_chghit = trap_S_RegisterSound( "sound/weapons/vulcan/wvulimpd.wav", qfalse );
;1277:	cgs.media.sfx_chghitflesh = trap_S_RegisterSound( "sound/weapons/vulcan/wvulimpl.wav", qfalse );
;1278:	cgs.media.sfx_chghitmetal = trap_S_RegisterSound( "sound/weapons/vulcan/wvulimpm.wav", qfalse );
;1279:	cgs.media.weaponHoverSound = trap_S_RegisterSound( "sound/weapons/weapon_hover.wav", qfalse );
;1280:	cgs.media.kamikazeExplodeSound = trap_S_RegisterSound( "sound/items/kam_explode.wav", qfalse );
;1281:	cgs.media.kamikazeImplodeSound = trap_S_RegisterSound( "sound/items/kam_implode.wav", qfalse );
;1282:	cgs.media.kamikazeFarSound = trap_S_RegisterSound( "sound/items/kam_explode_far.wav", qfalse );
;1283:	cgs.media.winnerSound = trap_S_RegisterSound( "sound/feedback/voc_youwin.wav", qfalse );
;1284:	cgs.media.loserSound = trap_S_RegisterSound( "sound/feedback/voc_youlose.wav", qfalse );
;1285:	cgs.media.youSuckSound = trap_S_RegisterSound( "sound/misc/yousuck.wav", qfalse );
;1286:
;1287:	cgs.media.wstbimplSound = trap_S_RegisterSound("sound/weapons/proxmine/wstbimpl.wav", qfalse);
;1288:	cgs.media.wstbimpmSound = trap_S_RegisterSound("sound/weapons/proxmine/wstbimpm.wav", qfalse);
;1289:	cgs.media.wstbimpdSound = trap_S_RegisterSound("sound/weapons/proxmine/wstbimpd.wav", qfalse);
;1290:	cgs.media.wstbactvSound = trap_S_RegisterSound("sound/weapons/proxmine/wstbactv.wav", qfalse);
;1291:#endif
;1292:
;1293:	cgs.media.regenSound = trap_S_RegisterSound("sound/items/regen.wav", qfalse);
ADDRGP4 $976
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 472
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+1084
ADDRLP4 472
INDIRI4
ASGNI4
line 1294
;1294:	cgs.media.protectSound = trap_S_RegisterSound("sound/items/protect3.wav", qfalse);
ADDRGP4 $979
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 476
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+1088
ADDRLP4 476
INDIRI4
ASGNI4
line 1295
;1295:	cgs.media.n_healthSound = trap_S_RegisterSound("sound/items/n_health.wav", qfalse );
ADDRGP4 $982
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 480
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+1092
ADDRLP4 480
INDIRI4
ASGNI4
line 1296
;1296:	cgs.media.hgrenb1aSound = trap_S_RegisterSound("sound/weapons/grenade/hgrenb1a.wav", qfalse);
ADDRGP4 $985
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 484
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+1096
ADDRLP4 484
INDIRI4
ASGNI4
line 1297
;1297:	cgs.media.hgrenb2aSound = trap_S_RegisterSound("sound/weapons/grenade/hgrenb2a.wav", qfalse);
ADDRGP4 $988
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 488
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+1100
ADDRLP4 488
INDIRI4
ASGNI4
line 1327
;1298:
;1299:#ifdef MISSIONPACK
;1300:	trap_S_RegisterSound("sound/player/james/death1.wav", qfalse );
;1301:	trap_S_RegisterSound("sound/player/james/death2.wav", qfalse );
;1302:	trap_S_RegisterSound("sound/player/james/death3.wav", qfalse );
;1303:	trap_S_RegisterSound("sound/player/james/jump1.wav", qfalse );
;1304:	trap_S_RegisterSound("sound/player/james/pain25_1.wav", qfalse );
;1305:	trap_S_RegisterSound("sound/player/james/pain75_1.wav", qfalse );
;1306:	trap_S_RegisterSound("sound/player/james/pain100_1.wav", qfalse );
;1307:	trap_S_RegisterSound("sound/player/james/falling1.wav", qfalse );
;1308:	trap_S_RegisterSound("sound/player/james/gasp.wav", qfalse );
;1309:	trap_S_RegisterSound("sound/player/james/drown.wav", qfalse );
;1310:	trap_S_RegisterSound("sound/player/james/fall1.wav", qfalse );
;1311:	trap_S_RegisterSound("sound/player/james/taunt.wav", qfalse );
;1312:
;1313:	trap_S_RegisterSound("sound/player/janet/death1.wav", qfalse );
;1314:	trap_S_RegisterSound("sound/player/janet/death2.wav", qfalse );
;1315:	trap_S_RegisterSound("sound/player/janet/death3.wav", qfalse );
;1316:	trap_S_RegisterSound("sound/player/janet/jump1.wav", qfalse );
;1317:	trap_S_RegisterSound("sound/player/janet/pain25_1.wav", qfalse );
;1318:	trap_S_RegisterSound("sound/player/janet/pain75_1.wav", qfalse );
;1319:	trap_S_RegisterSound("sound/player/janet/pain100_1.wav", qfalse );
;1320:	trap_S_RegisterSound("sound/player/janet/falling1.wav", qfalse );
;1321:	trap_S_RegisterSound("sound/player/janet/gasp.wav", qfalse );
;1322:	trap_S_RegisterSound("sound/player/janet/drown.wav", qfalse );
;1323:	trap_S_RegisterSound("sound/player/janet/fall1.wav", qfalse );
;1324:	trap_S_RegisterSound("sound/player/janet/taunt.wav", qfalse );
;1325:#endif
;1326:
;1327:}
LABELV $756
endproc CG_RegisterSounds 492 16
data
align 4
LABELV $990
address $991
address $992
address $993
address $994
address $995
address $996
address $997
address $998
address $999
address $1000
address $1001
code
proc CG_RegisterGraphics 612 16
line 1340
;1328:
;1329:
;1330://===================================================================================
;1331:
;1332:
;1333:/*
;1334:=================
;1335:CG_RegisterGraphics
;1336:
;1337:This function may execute for a couple of minutes with a slow disk.
;1338:=================
;1339:*/
;1340:static void CG_RegisterGraphics( void ) {
line 1358
;1341:	int			i;
;1342:	char		items[MAX_ITEMS+1];
;1343:	static char		*sb_nums[11] = {
;1344:		"gfx/2d/numbers/zero_32b",
;1345:		"gfx/2d/numbers/one_32b",
;1346:		"gfx/2d/numbers/two_32b",
;1347:		"gfx/2d/numbers/three_32b",
;1348:		"gfx/2d/numbers/four_32b",
;1349:		"gfx/2d/numbers/five_32b",
;1350:		"gfx/2d/numbers/six_32b",
;1351:		"gfx/2d/numbers/seven_32b",
;1352:		"gfx/2d/numbers/eight_32b",
;1353:		"gfx/2d/numbers/nine_32b",
;1354:		"gfx/2d/numbers/minus_32b",
;1355:	};
;1356:
;1357:	// clear any references to old media
;1358:	memset( &cg.refdef, 0, sizeof( cg.refdef ) );
ADDRGP4 cg+109048
ARGP4
CNSTI4 0
ARGI4
CNSTI4 368
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1359
;1359:	trap_R_ClearScene();
ADDRGP4 trap_R_ClearScene
CALLV
pop
line 1361
;1360:
;1361:	CG_LoadingString( cgs.mapname );
ADDRGP4 cgs+31484
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 1363
;1362:
;1363:	trap_R_LoadWorldMap( cgs.mapname );
ADDRGP4 cgs+31484
ARGP4
ADDRGP4 trap_R_LoadWorldMap
CALLV
pop
line 1366
;1364:
;1365:	// precache status bar pics
;1366:	CG_LoadingString( "game media" );
ADDRGP4 $1006
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 1368
;1367:
;1368:	for ( i=0 ; i<11 ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1007
line 1369
;1369:		cgs.media.numberShaders[i] = trap_R_RegisterShader( sb_nums[i] );
ADDRLP4 264
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 264
INDIRI4
ADDRGP4 $990
ADDP4
INDIRP4
ARGP4
ADDRLP4 268
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
ADDRGP4 cgs+156680+356
ADDP4
ADDRLP4 268
INDIRI4
ASGNI4
line 1370
;1370:	}
LABELV $1008
line 1368
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 11
LTI4 $1007
line 1372
;1371:
;1372:	cgs.media.botSkillShaders[0] = trap_R_RegisterShader( "menu/art/skill1.tga" );
ADDRGP4 $1015
ARGP4
ADDRLP4 264
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+404
ADDRLP4 264
INDIRI4
ASGNI4
line 1373
;1373:	cgs.media.botSkillShaders[1] = trap_R_RegisterShader( "menu/art/skill2.tga" );
ADDRGP4 $1019
ARGP4
ADDRLP4 268
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+404+4
ADDRLP4 268
INDIRI4
ASGNI4
line 1374
;1374:	cgs.media.botSkillShaders[2] = trap_R_RegisterShader( "menu/art/skill3.tga" );
ADDRGP4 $1023
ARGP4
ADDRLP4 272
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+404+8
ADDRLP4 272
INDIRI4
ASGNI4
line 1375
;1375:	cgs.media.botSkillShaders[3] = trap_R_RegisterShader( "menu/art/skill4.tga" );
ADDRGP4 $1027
ARGP4
ADDRLP4 276
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+404+12
ADDRLP4 276
INDIRI4
ASGNI4
line 1376
;1376:	cgs.media.botSkillShaders[4] = trap_R_RegisterShader( "menu/art/skill5.tga" );
ADDRGP4 $1031
ARGP4
ADDRLP4 280
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+404+16
ADDRLP4 280
INDIRI4
ASGNI4
line 1378
;1377:
;1378:	cgs.media.viewBloodShader = trap_R_RegisterShader( "viewBloodBlend" );
ADDRGP4 $1034
ARGP4
ADDRLP4 284
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+268
ADDRLP4 284
INDIRI4
ASGNI4
line 1380
;1379:
;1380:	cgs.media.deferShader = trap_R_RegisterShaderNoMip( "gfx/2d/defer.tga" );
ADDRGP4 $1037
ARGP4
ADDRLP4 288
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+156680+184
ADDRLP4 288
INDIRI4
ASGNI4
line 1382
;1381:
;1382:	cgs.media.scoreboardName = trap_R_RegisterShaderNoMip( "menu/tab/name.tga" );
ADDRGP4 $1040
ARGP4
ADDRLP4 292
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+156680+552
ADDRLP4 292
INDIRI4
ASGNI4
line 1383
;1383:	cgs.media.scoreboardPing = trap_R_RegisterShaderNoMip( "menu/tab/ping.tga" );
ADDRGP4 $1043
ARGP4
ADDRLP4 296
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+156680+556
ADDRLP4 296
INDIRI4
ASGNI4
line 1384
;1384:	cgs.media.scoreboardScore = trap_R_RegisterShaderNoMip( "menu/tab/score.tga" );
ADDRGP4 $1046
ARGP4
ADDRLP4 300
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+156680+560
ADDRLP4 300
INDIRI4
ASGNI4
line 1385
;1385:	cgs.media.scoreboardTime = trap_R_RegisterShaderNoMip( "menu/tab/time.tga" );
ADDRGP4 $1049
ARGP4
ADDRLP4 304
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+156680+564
ADDRLP4 304
INDIRI4
ASGNI4
line 1386
;1386:	cgs.media.scoreboardTeamnameRed = trap_R_RegisterShaderNoMip( "menu/tab/teamnamered.tga" );
ADDRGP4 $1052
ARGP4
ADDRLP4 308
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+156680+568
ADDRLP4 308
INDIRI4
ASGNI4
line 1387
;1387:	cgs.media.scoreboardTeamnameBlue = trap_R_RegisterShaderNoMip( "menu/tab/teamnameblue.tga" );
ADDRGP4 $1055
ARGP4
ADDRLP4 312
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+156680+572
ADDRLP4 312
INDIRI4
ASGNI4
line 1389
;1388:
;1389:	cgs.media.smokePuffShader = trap_R_RegisterShader( "smokePuff" );
ADDRGP4 $1058
ARGP4
ADDRLP4 316
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+332
ADDRLP4 316
INDIRI4
ASGNI4
line 1390
;1390:	cgs.media.smokePuffRageProShader = trap_R_RegisterShader( "smokePuffRagePro" );
ADDRGP4 $1061
ARGP4
ADDRLP4 320
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+336
ADDRLP4 320
INDIRI4
ASGNI4
line 1391
;1391:	cgs.media.shotgunSmokePuffShader = trap_R_RegisterShader( "shotgunSmokePuff" );
ADDRGP4 $1064
ARGP4
ADDRLP4 324
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+340
ADDRLP4 324
INDIRI4
ASGNI4
line 1396
;1392:#ifdef MISSIONPACK
;1393:	cgs.media.nailPuffShader = trap_R_RegisterShader( "nailtrail" );
;1394:	cgs.media.blueProxMine = trap_R_RegisterModel( "models/weaphits/proxmineb.md3" );
;1395:#endif
;1396:	cgs.media.plasmaBallShader = trap_R_RegisterShader( "sprites/plasma1" );
ADDRGP4 $1067
ARGP4
ADDRLP4 328
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+344
ADDRLP4 328
INDIRI4
ASGNI4
line 1397
;1397:	cgs.media.bloodTrailShader = trap_R_RegisterShader( "bloodTrail" );
ADDRGP4 $1070
ARGP4
ADDRLP4 332
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+352
ADDRLP4 332
INDIRI4
ASGNI4
line 1398
;1398:	cgs.media.lagometerShader = trap_R_RegisterShader("lagometer" );
ADDRGP4 $1073
ARGP4
ADDRLP4 336
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+320
ADDRLP4 336
INDIRI4
ASGNI4
line 1399
;1399:	cgs.media.connectionShader = trap_R_RegisterShader( "disconnected" );
ADDRGP4 $1076
ARGP4
ADDRLP4 340
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+260
ADDRLP4 340
INDIRI4
ASGNI4
line 1401
;1400:
;1401:	cgs.media.waterBubbleShader = trap_R_RegisterShader( "waterBubble" );
ADDRGP4 $1079
ARGP4
ADDRLP4 344
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+348
ADDRLP4 344
INDIRI4
ASGNI4
line 1403
;1402:
;1403:	cgs.media.tracerShader = trap_R_RegisterShader( "gfx/misc/tracer" );
ADDRGP4 $1082
ARGP4
ADDRLP4 348
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+272
ADDRLP4 348
INDIRI4
ASGNI4
line 1404
;1404:	cgs.media.selectShader = trap_R_RegisterShader( "gfx/2d/select" );
ADDRGP4 $1085
ARGP4
ADDRLP4 352
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+264
ADDRLP4 352
INDIRI4
ASGNI4
line 1406
;1405:
;1406:	for ( i = 0 ; i < NUM_CROSSHAIRS ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1086
line 1407
;1407:		cgs.media.crosshairShader[i] = trap_R_RegisterShader( va("gfx/2d/crosshair%c", 'a'+i) );
ADDRGP4 $1092
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 97
ADDI4
ARGI4
ADDRLP4 360
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 360
INDIRP4
ARGP4
ADDRLP4 364
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+156680+276
ADDP4
ADDRLP4 364
INDIRI4
ASGNI4
line 1408
;1408:	}
LABELV $1087
line 1406
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 11
LTI4 $1086
line 1410
;1409:
;1410:	cgs.media.backTileShader = trap_R_RegisterShader( "gfx/2d/backtile" );
ADDRGP4 $1095
ARGP4
ADDRLP4 356
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+324
ADDRLP4 356
INDIRI4
ASGNI4
line 1411
;1411:	cgs.media.noammoShader = trap_R_RegisterShader( "icons/noammo" );
ADDRGP4 $1098
ARGP4
ADDRLP4 360
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+328
ADDRLP4 360
INDIRI4
ASGNI4
line 1414
;1412:
;1413:	// powerup shaders
;1414:	cgs.media.quadShader = trap_R_RegisterShader("powerups/quad" );
ADDRGP4 $1101
ARGP4
ADDRLP4 364
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+456
ADDRLP4 364
INDIRI4
ASGNI4
line 1415
;1415:	cgs.media.quadWeaponShader = trap_R_RegisterShader("powerups/quadWeapon" );
ADDRGP4 $1104
ARGP4
ADDRLP4 368
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+464
ADDRLP4 368
INDIRI4
ASGNI4
line 1416
;1416:	cgs.media.battleSuitShader = trap_R_RegisterShader("powerups/battleSuit" );
ADDRGP4 $1107
ARGP4
ADDRLP4 372
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+476
ADDRLP4 372
INDIRI4
ASGNI4
line 1417
;1417:	cgs.media.battleWeaponShader = trap_R_RegisterShader("powerups/battleWeapon" );
ADDRGP4 $1110
ARGP4
ADDRLP4 376
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+480
ADDRLP4 376
INDIRI4
ASGNI4
line 1418
;1418:	cgs.media.invisShader = trap_R_RegisterShader("powerups/invisibility" );
ADDRGP4 $1113
ARGP4
ADDRLP4 380
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+468
ADDRLP4 380
INDIRI4
ASGNI4
line 1419
;1419:	cgs.media.regenShader = trap_R_RegisterShader("powerups/regen" );
ADDRGP4 $1116
ARGP4
ADDRLP4 384
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+472
ADDRLP4 384
INDIRI4
ASGNI4
line 1420
;1420:	cgs.media.hastePuffShader = trap_R_RegisterShader("hasteSmokePuff" );
ADDRGP4 $1119
ARGP4
ADDRLP4 388
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+484
ADDRLP4 388
INDIRI4
ASGNI4
line 1422
;1421://freeze
;1422:	cgs.media.freezeShader = trap_R_RegisterShader( "freezeShader" );
ADDRGP4 $1122
ARGP4
ADDRLP4 392
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+448
ADDRLP4 392
INDIRI4
ASGNI4
line 1423
;1423:	cgs.media.freezeMarkShader = trap_R_RegisterShader( "freezeMarkShader" );
ADDRGP4 $1125
ARGP4
ADDRLP4 396
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+452
ADDRLP4 396
INDIRI4
ASGNI4
line 1429
;1424://freeze
;1425:
;1426:#ifdef MISSIONPACK
;1427:	if ( cgs.gametype == GT_CTF || cgs.gametype == GT_1FCTF || cgs.gametype == GT_HARVESTER || cg_buildScript.integer ) {
;1428:#else
;1429:	if ( cgs.gametype == GT_CTF || cg_buildScript.integer ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
EQI4 $1130
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $1126
LABELV $1130
line 1431
;1430:#endif
;1431:		cgs.media.redCubeModel = trap_R_RegisterModel( "models/powerups/orb/r_orb.md3" );
ADDRGP4 $1133
ARGP4
ADDRLP4 400
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+156680+40
ADDRLP4 400
INDIRI4
ASGNI4
line 1432
;1432:		cgs.media.blueCubeModel = trap_R_RegisterModel( "models/powerups/orb/b_orb.md3" );
ADDRGP4 $1136
ARGP4
ADDRLP4 404
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+156680+44
ADDRLP4 404
INDIRI4
ASGNI4
line 1433
;1433:		cgs.media.redCubeIcon = trap_R_RegisterShader( "icons/skull_red" );
ADDRGP4 $1139
ARGP4
ADDRLP4 408
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+48
ADDRLP4 408
INDIRI4
ASGNI4
line 1434
;1434:		cgs.media.blueCubeIcon = trap_R_RegisterShader( "icons/skull_blue" );
ADDRGP4 $1142
ARGP4
ADDRLP4 412
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+52
ADDRLP4 412
INDIRI4
ASGNI4
line 1435
;1435:	}
LABELV $1126
line 1440
;1436:
;1437:#ifdef MISSIONPACK
;1438:	if ( cgs.gametype == GT_CTF || cgs.gametype == GT_1FCTF || cgs.gametype == GT_HARVESTER || cg_buildScript.integer ) {
;1439:#else
;1440:	if ( cgs.gametype == GT_CTF || cg_buildScript.integer ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
EQI4 $1147
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $1143
LABELV $1147
line 1442
;1441:#endif
;1442:		cgs.media.redFlagModel = trap_R_RegisterModel( "models/flags/r_flag.md3" );
ADDRGP4 $1150
ARGP4
ADDRLP4 400
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+156680+56
ADDRLP4 400
INDIRI4
ASGNI4
line 1443
;1443:		cgs.media.blueFlagModel = trap_R_RegisterModel( "models/flags/b_flag.md3" );
ADDRGP4 $1153
ARGP4
ADDRLP4 404
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+156680+60
ADDRLP4 404
INDIRI4
ASGNI4
line 1444
;1444:		cgs.media.redFlagShader[0] = trap_R_RegisterShaderNoMip( "icons/iconf_red1" );
ADDRGP4 $1156
ARGP4
ADDRLP4 408
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+156680+68
ADDRLP4 408
INDIRI4
ASGNI4
line 1445
;1445:		cgs.media.redFlagShader[1] = trap_R_RegisterShaderNoMip( "icons/iconf_red2" );
ADDRGP4 $1160
ARGP4
ADDRLP4 412
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+156680+68+4
ADDRLP4 412
INDIRI4
ASGNI4
line 1446
;1446:		cgs.media.redFlagShader[2] = trap_R_RegisterShaderNoMip( "icons/iconf_red3" );
ADDRGP4 $1164
ARGP4
ADDRLP4 416
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+156680+68+8
ADDRLP4 416
INDIRI4
ASGNI4
line 1447
;1447:		cgs.media.redFlagShader[3] = trap_R_RegisterShaderNoMip( "icons/iconf_red4" );
ADDRGP4 $1168
ARGP4
ADDRLP4 420
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+156680+68+12
ADDRLP4 420
INDIRI4
ASGNI4
line 1448
;1448:		cgs.media.blueFlagShader[0] = trap_R_RegisterShaderNoMip( "icons/iconf_blu1" );
ADDRGP4 $1171
ARGP4
ADDRLP4 424
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+156680+84
ADDRLP4 424
INDIRI4
ASGNI4
line 1449
;1449:		cgs.media.blueFlagShader[1] = trap_R_RegisterShaderNoMip( "icons/iconf_blu2" );
ADDRGP4 $1175
ARGP4
ADDRLP4 428
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+156680+84+4
ADDRLP4 428
INDIRI4
ASGNI4
line 1450
;1450:		cgs.media.blueFlagShader[2] = trap_R_RegisterShaderNoMip( "icons/iconf_blu3" );
ADDRGP4 $1179
ARGP4
ADDRLP4 432
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+156680+84+8
ADDRLP4 432
INDIRI4
ASGNI4
line 1451
;1451:		cgs.media.blueFlagShader[3] = trap_R_RegisterShaderNoMip( "icons/iconf_blu4" );
ADDRGP4 $1183
ARGP4
ADDRLP4 436
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+156680+84+12
ADDRLP4 436
INDIRI4
ASGNI4
line 1452
;1452:		cgs.media.whiteFlagShader[0] = trap_R_RegisterShaderNoMip( "icons/iconf_fla1" );
ADDRGP4 $1186
ARGP4
ADDRLP4 440
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+156680+100
ADDRLP4 440
INDIRI4
ASGNI4
line 1453
;1453:		cgs.media.whiteFlagShader[1] = trap_R_RegisterShaderNoMip( "icons/iconf_fla2" );
ADDRGP4 $1190
ARGP4
ADDRLP4 444
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+156680+100+4
ADDRLP4 444
INDIRI4
ASGNI4
line 1454
;1454:		cgs.media.whiteFlagShader[2] = trap_R_RegisterShaderNoMip( "icons/iconf_fla3" );
ADDRGP4 $1194
ARGP4
ADDRLP4 448
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+156680+100+8
ADDRLP4 448
INDIRI4
ASGNI4
line 1455
;1455:		cgs.media.whiteFlagShader[3] = trap_R_RegisterShaderNoMip( "icons/iconf_fla4" );
ADDRGP4 $1198
ARGP4
ADDRLP4 452
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+156680+100+12
ADDRLP4 452
INDIRI4
ASGNI4
line 1468
;1456:#ifdef MISSIONPACK
;1457:		cgs.media.flagPoleModel = trap_R_RegisterModel( "models/flag2/flagpole.md3" );
;1458:		cgs.media.flagFlapModel = trap_R_RegisterModel( "models/flag2/flagflap3.md3" );
;1459:
;1460:		cgs.media.redFlagFlapSkin = trap_R_RegisterSkin( "models/flag2/red.skin" );
;1461:		cgs.media.blueFlagFlapSkin = trap_R_RegisterSkin( "models/flag2/blue.skin" );
;1462:		cgs.media.neutralFlagFlapSkin = trap_R_RegisterSkin( "models/flag2/white.skin" );
;1463:
;1464:		cgs.media.redFlagBaseModel = trap_R_RegisterModel( "models/mapobjects/flagbase/red_base.md3" );
;1465:		cgs.media.blueFlagBaseModel = trap_R_RegisterModel( "models/mapobjects/flagbase/blue_base.md3" );
;1466:		cgs.media.neutralFlagBaseModel = trap_R_RegisterModel( "models/mapobjects/flagbase/ntrl_base.md3" );
;1467:#endif
;1468:	}
LABELV $1143
line 1497
;1469:
;1470:#ifdef MISSIONPACK
;1471:	if ( cgs.gametype == GT_1FCTF || cg_buildScript.integer ) {
;1472:		cgs.media.neutralFlagModel = trap_R_RegisterModel( "models/flags/n_flag.md3" );
;1473:		cgs.media.flagShader[0] = trap_R_RegisterShaderNoMip( "icons/iconf_neutral1" );
;1474:		cgs.media.flagShader[1] = trap_R_RegisterShaderNoMip( "icons/iconf_red2" );
;1475:		cgs.media.flagShader[2] = trap_R_RegisterShaderNoMip( "icons/iconf_blu2" );
;1476:		cgs.media.flagShader[3] = trap_R_RegisterShaderNoMip( "icons/iconf_neutral3" );
;1477:	}
;1478:
;1479:	if ( cgs.gametype == GT_OBELISK || cg_buildScript.integer ) {
;1480:		cgs.media.overloadBaseModel = trap_R_RegisterModel( "models/powerups/overload_base.md3" );
;1481:		cgs.media.overloadTargetModel = trap_R_RegisterModel( "models/powerups/overload_target.md3" );
;1482:		cgs.media.overloadLightsModel = trap_R_RegisterModel( "models/powerups/overload_lights.md3" );
;1483:		cgs.media.overloadEnergyModel = trap_R_RegisterModel( "models/powerups/overload_energy.md3" );
;1484:	}
;1485:
;1486:	if ( cgs.gametype == GT_HARVESTER || cg_buildScript.integer ) {
;1487:		cgs.media.harvesterModel = trap_R_RegisterModel( "models/powerups/harvester/harvester.md3" );
;1488:		cgs.media.harvesterRedSkin = trap_R_RegisterSkin( "models/powerups/harvester/red.skin" );
;1489:		cgs.media.harvesterBlueSkin = trap_R_RegisterSkin( "models/powerups/harvester/blue.skin" );
;1490:		cgs.media.harvesterNeutralModel = trap_R_RegisterModel( "models/powerups/obelisk/obelisk.md3" );
;1491:	}
;1492:
;1493:	cgs.media.redKamikazeShader = trap_R_RegisterShader( "models/weaphits/kamikred" );
;1494:	cgs.media.dustPuffShader = trap_R_RegisterShader("hasteSmokePuff" );
;1495:#endif
;1496:
;1497:	if ( cgs.gametype >= GT_TEAM || cg_buildScript.integer ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
GEI4 $1203
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $1199
LABELV $1203
line 1498
;1498:		cgs.media.friendShader = trap_R_RegisterShader( "sprites/foe" );
ADDRGP4 $1206
ARGP4
ADDRLP4 400
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+252
ADDRLP4 400
INDIRI4
ASGNI4
line 1499
;1499:		cgs.media.redQuadShader = trap_R_RegisterShader("powerups/blueflag" );
ADDRGP4 $1209
ARGP4
ADDRLP4 404
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+460
ADDRLP4 404
INDIRI4
ASGNI4
line 1500
;1500:		cgs.media.teamStatusBar = trap_R_RegisterShader( "gfx/2d/colorbar.tga" );
ADDRGP4 $1212
ARGP4
ADDRLP4 408
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+180
ADDRLP4 408
INDIRI4
ASGNI4
line 1504
;1501:#ifdef MISSIONPACK
;1502:		cgs.media.blueKamikazeShader = trap_R_RegisterShader( "models/weaphits/kamikblu" );
;1503:#endif
;1504:	}
LABELV $1199
line 1506
;1505:
;1506:	cgs.media.armorModel = trap_R_RegisterModel( "models/powerups/armor/armor_yel.md3" );
ADDRGP4 $1215
ARGP4
ADDRLP4 400
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+156680+164
ADDRLP4 400
INDIRI4
ASGNI4
line 1507
;1507:	cgs.media.armorIcon  = trap_R_RegisterShaderNoMip( "icons/iconr_yellow" );
ADDRGP4 $1218
ARGP4
ADDRLP4 404
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+156680+168
ADDRLP4 404
INDIRI4
ASGNI4
line 1509
;1508:	// CPM: Register red armor
;1509:	cgs.media.armorModelRA = trap_R_RegisterModel( "models/powerups/armor/armor_red.md3" );
ADDRGP4 $1221
ARGP4
ADDRLP4 408
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+156680+172
ADDRLP4 408
INDIRI4
ASGNI4
line 1510
;1510:	cgs.media.armorIconRA  = trap_R_RegisterShaderNoMip( "icons/iconr_red" );
ADDRGP4 $1224
ARGP4
ADDRLP4 412
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+156680+176
ADDRLP4 412
INDIRI4
ASGNI4
line 1513
;1511:	// !CPM
;1512:
;1513:	cgs.media.machinegunBrassModel = trap_R_RegisterModel( "models/weapons2/shells/m_shell.md3" );
ADDRGP4 $1227
ARGP4
ADDRLP4 416
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+156680+232
ADDRLP4 416
INDIRI4
ASGNI4
line 1514
;1514:	cgs.media.shotgunBrassModel = trap_R_RegisterModel( "models/weapons2/shells/s_shell.md3" );
ADDRGP4 $1230
ARGP4
ADDRLP4 420
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+156680+236
ADDRLP4 420
INDIRI4
ASGNI4
line 1516
;1515:
;1516:	cgs.media.gibAbdomen = trap_R_RegisterModel( "models/gibs/abdomen.md3" );
ADDRGP4 $1233
ARGP4
ADDRLP4 424
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+156680+188
ADDRLP4 424
INDIRI4
ASGNI4
line 1517
;1517:	cgs.media.gibArm = trap_R_RegisterModel( "models/gibs/arm.md3" );
ADDRGP4 $1236
ARGP4
ADDRLP4 428
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+156680+192
ADDRLP4 428
INDIRI4
ASGNI4
line 1518
;1518:	cgs.media.gibChest = trap_R_RegisterModel( "models/gibs/chest.md3" );
ADDRGP4 $1239
ARGP4
ADDRLP4 432
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+156680+196
ADDRLP4 432
INDIRI4
ASGNI4
line 1519
;1519:	cgs.media.gibFist = trap_R_RegisterModel( "models/gibs/fist.md3" );
ADDRGP4 $1242
ARGP4
ADDRLP4 436
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+156680+200
ADDRLP4 436
INDIRI4
ASGNI4
line 1520
;1520:	cgs.media.gibFoot = trap_R_RegisterModel( "models/gibs/foot.md3" );
ADDRGP4 $1245
ARGP4
ADDRLP4 440
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+156680+204
ADDRLP4 440
INDIRI4
ASGNI4
line 1521
;1521:	cgs.media.gibForearm = trap_R_RegisterModel( "models/gibs/forearm.md3" );
ADDRGP4 $1248
ARGP4
ADDRLP4 444
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+156680+208
ADDRLP4 444
INDIRI4
ASGNI4
line 1522
;1522:	cgs.media.gibIntestine = trap_R_RegisterModel( "models/gibs/intestine.md3" );
ADDRGP4 $1251
ARGP4
ADDRLP4 448
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+156680+212
ADDRLP4 448
INDIRI4
ASGNI4
line 1523
;1523:	cgs.media.gibLeg = trap_R_RegisterModel( "models/gibs/leg.md3" );
ADDRGP4 $1254
ARGP4
ADDRLP4 452
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+156680+216
ADDRLP4 452
INDIRI4
ASGNI4
line 1524
;1524:	cgs.media.gibSkull = trap_R_RegisterModel( "models/gibs/skull.md3" );
ADDRGP4 $1257
ARGP4
ADDRLP4 456
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+156680+220
ADDRLP4 456
INDIRI4
ASGNI4
line 1525
;1525:	cgs.media.gibBrain = trap_R_RegisterModel( "models/gibs/brain.md3" );
ADDRGP4 $1260
ARGP4
ADDRLP4 460
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+156680+224
ADDRLP4 460
INDIRI4
ASGNI4
line 1527
;1526:
;1527:	cgs.media.smoke2 = trap_R_RegisterModel( "models/weapons2/shells/s_shell.md3" );
ADDRGP4 $1230
ARGP4
ADDRLP4 464
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+156680+228
ADDRLP4 464
INDIRI4
ASGNI4
line 1529
;1528:
;1529:	cgs.media.balloonShader = trap_R_RegisterShader( "sprites/balloon3" );
ADDRGP4 $1265
ARGP4
ADDRLP4 468
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+256
ADDRLP4 468
INDIRI4
ASGNI4
line 1531
;1530:
;1531:	cgs.media.bloodExplosionShader = trap_R_RegisterShader( "bloodExplosion" );
ADDRGP4 $1268
ARGP4
ADDRLP4 472
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+536
ADDRLP4 472
INDIRI4
ASGNI4
line 1533
;1532:
;1533:	cgs.media.bulletFlashModel = trap_R_RegisterModel("models/weaphits/bullet.md3");
ADDRGP4 $1271
ARGP4
ADDRLP4 476
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+156680+496
ADDRLP4 476
INDIRI4
ASGNI4
line 1534
;1534:	cgs.media.ringFlashModel = trap_R_RegisterModel("models/weaphits/ring02.md3");
ADDRGP4 $1274
ARGP4
ADDRLP4 480
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+156680+500
ADDRLP4 480
INDIRI4
ASGNI4
line 1535
;1535:	cgs.media.dishFlashModel = trap_R_RegisterModel("models/weaphits/boom01.md3");
ADDRGP4 $1277
ARGP4
ADDRLP4 484
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+156680+504
ADDRLP4 484
INDIRI4
ASGNI4
line 1539
;1536:#ifdef MISSIONPACK
;1537:	cgs.media.teleportEffectModel = trap_R_RegisterModel( "models/powerups/pop.md3" );
;1538:#else
;1539:	cgs.media.teleportEffectModel = trap_R_RegisterModel( "models/misc/telep.md3" );
ADDRGP4 $1280
ARGP4
ADDRLP4 488
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+156680+540
ADDRLP4 488
INDIRI4
ASGNI4
line 1540
;1540:	cgs.media.teleportEffectShader = trap_R_RegisterShader( "teleportEffect" );
ADDRGP4 $1283
ARGP4
ADDRLP4 492
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+544
ADDRLP4 492
INDIRI4
ASGNI4
line 1558
;1541:#endif
;1542:#ifdef MISSIONPACK
;1543:	cgs.media.kamikazeEffectModel = trap_R_RegisterModel( "models/weaphits/kamboom2.md3" );
;1544:	cgs.media.kamikazeShockWave = trap_R_RegisterModel( "models/weaphits/kamwave.md3" );
;1545:	cgs.media.kamikazeHeadModel = trap_R_RegisterModel( "models/powerups/kamikazi.md3" );
;1546:	cgs.media.kamikazeHeadTrail = trap_R_RegisterModel( "models/powerups/trailtest.md3" );
;1547:	cgs.media.guardPowerupModel = trap_R_RegisterModel( "models/powerups/guard_player.md3" );
;1548:	cgs.media.scoutPowerupModel = trap_R_RegisterModel( "models/powerups/scout_player.md3" );
;1549:	cgs.media.doublerPowerupModel = trap_R_RegisterModel( "models/powerups/doubler_player.md3" );
;1550:	cgs.media.ammoRegenPowerupModel = trap_R_RegisterModel( "models/powerups/ammo_player.md3" );
;1551:	cgs.media.invulnerabilityImpactModel = trap_R_RegisterModel( "models/powerups/shield/impact.md3" );
;1552:	cgs.media.invulnerabilityJuicedModel = trap_R_RegisterModel( "models/powerups/shield/juicer.md3" );
;1553:	cgs.media.medkitUsageModel = trap_R_RegisterModel( "models/powerups/regen.md3" );
;1554:	cgs.media.heartShader = trap_R_RegisterShaderNoMip( "ui/assets/statusbar/selectedhealth.tga" );
;1555:
;1556:#endif
;1557:
;1558:	cgs.media.invulnerabilityPowerupModel = trap_R_RegisterModel( "models/powerups/shield/shield.md3" );
ADDRGP4 $1286
ARGP4
ADDRLP4 496
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+156680+548
ADDRLP4 496
INDIRI4
ASGNI4
line 1559
;1559:	cgs.media.medalImpressive = trap_R_RegisterShaderNoMip( "medal_impressive" );
ADDRGP4 $1289
ARGP4
ADDRLP4 500
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+156680+576
ADDRLP4 500
INDIRI4
ASGNI4
line 1560
;1560:	cgs.media.medalExcellent = trap_R_RegisterShaderNoMip( "medal_excellent" );
ADDRGP4 $1292
ARGP4
ADDRLP4 504
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+156680+580
ADDRLP4 504
INDIRI4
ASGNI4
line 1561
;1561:	cgs.media.medalGauntlet = trap_R_RegisterShaderNoMip( "medal_gauntlet" );
ADDRGP4 $1295
ARGP4
ADDRLP4 508
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+156680+584
ADDRLP4 508
INDIRI4
ASGNI4
line 1562
;1562:	cgs.media.medalDefend = trap_R_RegisterShaderNoMip( "medal_defend" );
ADDRGP4 $1298
ARGP4
ADDRLP4 512
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+156680+588
ADDRLP4 512
INDIRI4
ASGNI4
line 1563
;1563:	cgs.media.medalAssist = trap_R_RegisterShaderNoMip( "medal_assist" );
ADDRGP4 $1301
ARGP4
ADDRLP4 516
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+156680+592
ADDRLP4 516
INDIRI4
ASGNI4
line 1564
;1564:	cgs.media.medalCapture = trap_R_RegisterShaderNoMip( "medal_capture" );
ADDRGP4 $1304
ARGP4
ADDRLP4 520
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+156680+596
ADDRLP4 520
INDIRI4
ASGNI4
line 1567
;1565:
;1566:
;1567:	memset( cg_items, 0, sizeof( cg_items ) );
ADDRGP4 cg_items
ARGP4
CNSTI4 0
ARGI4
CNSTI4 6144
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1568
;1568:	memset( cg_weapons, 0, sizeof( cg_weapons ) );
ADDRGP4 cg_weapons
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1571
;1569:
;1570:	// only register the items that the server says we need
;1571:	strcpy( items, CG_ConfigString( CS_ITEMS) );
CNSTI4 27
ARGI4
ADDRLP4 524
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
ADDRLP4 524
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1573
;1572:
;1573:	for ( i = 1 ; i < bg_numItems ; i++ ) {
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $1308
JUMPV
LABELV $1305
line 1574
;1574:		if ( items[ i ] == '1' || cg_buildScript.integer ) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
INDIRI1
CVII4 1
CNSTI4 49
EQI4 $1312
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $1309
LABELV $1312
line 1575
;1575:			CG_LoadingItem( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_LoadingItem
CALLV
pop
line 1576
;1576:			CG_RegisterItemVisuals( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_RegisterItemVisuals
CALLV
pop
line 1577
;1577:		}
LABELV $1309
line 1578
;1578:	}
LABELV $1306
line 1573
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1308
ADDRLP4 0
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $1305
line 1581
;1579:
;1580:	// wall marks
;1581:	cgs.media.bulletMarkShader = trap_R_RegisterShader( "gfx/damage/bullet_mrk" );
ADDRGP4 $1315
ARGP4
ADDRLP4 528
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+432
ADDRLP4 528
INDIRI4
ASGNI4
line 1582
;1582:	cgs.media.burnMarkShader = trap_R_RegisterShader( "gfx/damage/burn_med_mrk" );
ADDRGP4 $1318
ARGP4
ADDRLP4 532
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+436
ADDRLP4 532
INDIRI4
ASGNI4
line 1583
;1583:	cgs.media.holeMarkShader = trap_R_RegisterShader( "gfx/damage/hole_lg_mrk" );
ADDRGP4 $1321
ARGP4
ADDRLP4 536
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+440
ADDRLP4 536
INDIRI4
ASGNI4
line 1584
;1584:	cgs.media.energyMarkShader = trap_R_RegisterShader( "gfx/damage/plasma_mrk" );
ADDRGP4 $1324
ARGP4
ADDRLP4 540
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+444
ADDRLP4 540
INDIRI4
ASGNI4
line 1585
;1585:	cgs.media.shadowMarkShader = trap_R_RegisterShader( "markShadow" );
ADDRGP4 $1327
ARGP4
ADDRLP4 544
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+400
ADDRLP4 544
INDIRI4
ASGNI4
line 1586
;1586:	cgs.media.wakeMarkShader = trap_R_RegisterShader( "wake" );
ADDRGP4 $1330
ARGP4
ADDRLP4 548
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+424
ADDRLP4 548
INDIRI4
ASGNI4
line 1587
;1587:	cgs.media.bloodMarkShader = trap_R_RegisterShader( "bloodMark" );
ADDRGP4 $1333
ARGP4
ADDRLP4 552
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+428
ADDRLP4 552
INDIRI4
ASGNI4
line 1590
;1588:
;1589:	// register the inline models
;1590:	cgs.numInlineModels = trap_CM_NumInlineModels();
ADDRLP4 556
ADDRGP4 trap_CM_NumInlineModels
CALLI4
ASGNI4
ADDRGP4 cgs+36860
ADDRLP4 556
INDIRI4
ASGNI4
line 1591
;1591:	for ( i = 1 ; i < cgs.numInlineModels ; i++ ) {
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $1338
JUMPV
LABELV $1335
line 1596
;1592:		char	name[10];
;1593:		vec3_t			mins, maxs;
;1594:		int				j;
;1595:
;1596:		Com_sprintf( name, sizeof(name), "*%i", i );
ADDRLP4 588
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $1340
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1597
;1597:		cgs.inlineDrawModel[i] = trap_R_RegisterModel( name );
ADDRLP4 588
ARGP4
ADDRLP4 600
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+36864
ADDP4
ADDRLP4 600
INDIRI4
ASGNI4
line 1598
;1598:		trap_R_ModelBounds( cgs.inlineDrawModel[i], mins, maxs );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+36864
ADDP4
INDIRI4
ARGI4
ADDRLP4 564
ARGP4
ADDRLP4 576
ARGP4
ADDRGP4 trap_R_ModelBounds
CALLV
pop
line 1599
;1599:		for ( j = 0 ; j < 3 ; j++ ) {
ADDRLP4 560
CNSTI4 0
ASGNI4
LABELV $1343
line 1600
;1600:			cgs.inlineModelMidpoints[i][j] = mins[j] + 0.5 * ( maxs[j] - mins[j] );
ADDRLP4 604
ADDRLP4 560
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 608
ADDRLP4 604
INDIRI4
ADDRLP4 564
ADDP4
INDIRF4
ASGNF4
ADDRLP4 604
INDIRI4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+37888
ADDP4
ADDP4
ADDRLP4 608
INDIRF4
CNSTF4 1056964608
ADDRLP4 604
INDIRI4
ADDRLP4 576
ADDP4
INDIRF4
ADDRLP4 608
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 1601
;1601:		}
LABELV $1344
line 1599
ADDRLP4 560
ADDRLP4 560
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 560
INDIRI4
CNSTI4 3
LTI4 $1343
line 1602
;1602:	}
LABELV $1336
line 1591
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1338
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+36860
INDIRI4
LTI4 $1335
line 1605
;1603:
;1604:	// register all the server specified models
;1605:	for (i=1 ; i<MAX_MODELS ; i++) {
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $1348
line 1608
;1606:		const char		*modelName;
;1607:
;1608:		modelName = CG_ConfigString( CS_MODELS+i );
ADDRLP4 0
INDIRI4
CNSTI4 32
ADDI4
ARGI4
ADDRLP4 564
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 560
ADDRLP4 564
INDIRP4
ASGNP4
line 1609
;1609:		if ( !modelName[0] ) {
ADDRLP4 560
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1352
line 1610
;1610:			break;
ADDRGP4 $1350
JUMPV
LABELV $1352
line 1612
;1611:		}
;1612:		cgs.gameModels[i] = trap_R_RegisterModel( modelName );
ADDRLP4 560
INDIRP4
ARGP4
ADDRLP4 568
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+34812
ADDP4
ADDRLP4 568
INDIRI4
ASGNI4
line 1613
;1613:	}
LABELV $1349
line 1605
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 256
LTI4 $1348
LABELV $1350
line 1641
;1614:
;1615:#ifdef MISSIONPACK
;1616:	// new stuff
;1617:	cgs.media.patrolShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/patrol.tga");
;1618:	cgs.media.assaultShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/assault.tga");
;1619:	cgs.media.campShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/camp.tga");
;1620:	cgs.media.followShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/follow.tga");
;1621:	cgs.media.defendShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/defend.tga");
;1622:	cgs.media.teamLeaderShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/team_leader.tga");
;1623:	cgs.media.retrieveShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/retrieve.tga");
;1624:	cgs.media.escortShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/escort.tga");
;1625:	cgs.media.cursor = trap_R_RegisterShaderNoMip( "menu/art/3_cursor2" );
;1626:	cgs.media.sizeCursor = trap_R_RegisterShaderNoMip( "ui/assets/sizecursor.tga" );
;1627:	cgs.media.selectCursor = trap_R_RegisterShaderNoMip( "ui/assets/selectcursor.tga" );
;1628:	cgs.media.flagShaders[0] = trap_R_RegisterShaderNoMip("ui/assets/statusbar/flag_in_base.tga");
;1629:	cgs.media.flagShaders[1] = trap_R_RegisterShaderNoMip("ui/assets/statusbar/flag_capture.tga");
;1630:	cgs.media.flagShaders[2] = trap_R_RegisterShaderNoMip("ui/assets/statusbar/flag_missing.tga");
;1631:
;1632:	trap_R_RegisterModel( "models/players/james/lower.md3" );
;1633:	trap_R_RegisterModel( "models/players/james/upper.md3" );
;1634:	trap_R_RegisterModel( "models/players/heads/james/james.md3" );
;1635:
;1636:	trap_R_RegisterModel( "models/players/janet/lower.md3" );
;1637:	trap_R_RegisterModel( "models/players/janet/upper.md3" );
;1638:	trap_R_RegisterModel( "models/players/heads/janet/janet.md3" );
;1639:
;1640:#endif
;1641:	CG_ClearParticles ();
ADDRGP4 CG_ClearParticles
CALLV
pop
line 1654
;1642:/*
;1643:	for (i=1; i<MAX_PARTICLES_AREAS; i++)
;1644:	{
;1645:		{
;1646:			int rval;
;1647:
;1648:			rval = CG_NewParticleArea ( CS_PARTICLES + i);
;1649:			if (!rval)
;1650:				break;
;1651:		}
;1652:	}
;1653:*/
;1654:}
LABELV $989
endproc CG_RegisterGraphics 612 16
export CG_BuildSpectatorString
proc CG_BuildSpectatorString 12 12
line 1664
;1655:
;1656:
;1657:
;1658:/*																																			
;1659:=======================
;1660:CG_BuildSpectatorString
;1661:
;1662:=======================
;1663:*/
;1664:void CG_BuildSpectatorString() {
line 1666
;1665:	int i;
;1666:	cg.spectatorList[0] = 0;
ADDRGP4 cg+120512
CNSTI1 0
ASGNI1
line 1667
;1667:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1357
line 1668
;1668:		if (cgs.clientinfo[i].infoValid && cgs.clientinfo[i].team == TEAM_SPECTATOR ) {
ADDRLP4 4
CNSTI4 1776
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+40960
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1361
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1361
line 1669
;1669:			Q_strcat(cg.spectatorList, sizeof(cg.spectatorList), va("%s     ", cgs.clientinfo[i].name));
ADDRGP4 $1368
ARGP4
CNSTI4 1776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+40960+4
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 cg+120512
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 1670
;1670:		}
LABELV $1361
line 1671
;1671:	}
LABELV $1358
line 1667
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $1357
line 1672
;1672:	i = strlen(cg.spectatorList);
ADDRGP4 cg+120512
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 1673
;1673:	if (i != cg.spectatorLen) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+121536
INDIRI4
EQI4 $1372
line 1674
;1674:		cg.spectatorLen = i;
ADDRGP4 cg+121536
ADDRLP4 0
INDIRI4
ASGNI4
line 1675
;1675:		cg.spectatorWidth = -1;
ADDRGP4 cg+121540
CNSTF4 3212836864
ASGNF4
line 1676
;1676:	}
LABELV $1372
line 1677
;1677:}
LABELV $1355
endproc CG_BuildSpectatorString 12 12
proc CG_RegisterClients 12 4
line 1685
;1678:
;1679:
;1680:/*																																			
;1681:===================
;1682:CG_RegisterClients
;1683:===================
;1684:*/
;1685:static void CG_RegisterClients( void ) {
line 1688
;1686:	int		i;
;1687:
;1688:	CG_LoadingClient(cg.clientNum);
ADDRGP4 cg+4
INDIRI4
ARGI4
ADDRGP4 CG_LoadingClient
CALLV
pop
line 1689
;1689:	CG_NewClientInfo(cg.clientNum);
ADDRGP4 cg+4
INDIRI4
ARGI4
ADDRGP4 CG_NewClientInfo
CALLV
pop
line 1691
;1690:
;1691:	for (i=0 ; i<MAX_CLIENTS ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1380
line 1694
;1692:		const char		*clientInfo;
;1693:
;1694:		if (cg.clientNum == i) {
ADDRGP4 cg+4
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $1384
line 1695
;1695:			continue;
ADDRGP4 $1381
JUMPV
LABELV $1384
line 1698
;1696:		}
;1697:
;1698:		clientInfo = CG_ConfigString( CS_PLAYERS+i );
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 8
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 1699
;1699:		if ( !clientInfo[0]) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1387
line 1700
;1700:			continue;
ADDRGP4 $1381
JUMPV
LABELV $1387
line 1702
;1701:		}
;1702:		CG_LoadingClient( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_LoadingClient
CALLV
pop
line 1703
;1703:		CG_NewClientInfo( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_NewClientInfo
CALLV
pop
line 1704
;1704:	}
LABELV $1381
line 1691
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $1380
line 1705
;1705:	CG_BuildSpectatorString();
ADDRGP4 CG_BuildSpectatorString
CALLV
pop
line 1706
;1706:}
LABELV $1377
endproc CG_RegisterClients 12 4
export CG_ConfigString
proc CG_ConfigString 4 8
line 1715
;1707:
;1708://===========================================================================
;1709:
;1710:/*
;1711:=================
;1712:CG_ConfigString
;1713:=================
;1714:*/
;1715:const char *CG_ConfigString( int index ) {
line 1716
;1716:	if ( index < 0 || index >= MAX_CONFIGSTRINGS ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1392
ADDRLP4 0
INDIRI4
CNSTI4 1024
LTI4 $1390
LABELV $1392
line 1717
;1717:		CG_Error( "CG_ConfigString: bad index: %i", index );
ADDRGP4 $1393
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 1718
;1718:	}
LABELV $1390
line 1719
;1719:	return cgs.gameState.stringData + cgs.gameState.stringOffsets[ index ];
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs
ADDP4
INDIRI4
ADDRGP4 cgs+4096
ADDP4
RETP4
LABELV $1389
endproc CG_ConfigString 4 8
export CG_StartMusic
proc CG_StartMusic 144 12
line 1730
;1720:}
;1721:
;1722://==================================================================
;1723:
;1724:/*
;1725:======================
;1726:CG_StartMusic
;1727:
;1728:======================
;1729:*/
;1730:void CG_StartMusic( void ) {
line 1735
;1731:	char	*s;
;1732:	char	parm1[MAX_QPATH], parm2[MAX_QPATH];
;1733:
;1734:	//monkk:kill ambient sounds
;1735:	if( s_ambient.integer == 0 ) {
ADDRGP4 s_ambient+12
INDIRI4
CNSTI4 0
NEI4 $1396
line 1736
;1736:		return;
ADDRGP4 $1395
JUMPV
LABELV $1396
line 1740
;1737:	}
;1738:
;1739:	// start the background music
;1740:	s = (char *)CG_ConfigString( CS_MUSIC );
CNSTI4 2
ARGI4
ADDRLP4 132
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 132
INDIRP4
ASGNP4
line 1741
;1741:	Q_strncpyz( parm1, COM_Parse( &s ), sizeof( parm1 ) );
ADDRLP4 0
ARGP4
ADDRLP4 136
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
ADDRLP4 136
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1742
;1742:	Q_strncpyz( parm2, COM_Parse( &s ), sizeof( parm2 ) );
ADDRLP4 0
ARGP4
ADDRLP4 140
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 68
ARGP4
ADDRLP4 140
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1744
;1743:
;1744:	trap_S_StartBackgroundTrack( parm1, parm2 );
ADDRLP4 4
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 trap_S_StartBackgroundTrack
CALLV
pop
line 1745
;1745:}
LABELV $1395
endproc CG_StartMusic 144 12
export CG_Init
proc CG_Init 84 12
line 2424
;1746:#ifdef MISSIONPACK
;1747:char *CG_GetMenuBuffer(const char *filename) {
;1748:	int	len;
;1749:	fileHandle_t	f;
;1750:	static char buf[MAX_MENUFILE];
;1751:
;1752:	len = trap_FS_FOpenFile( filename, &f, FS_READ );
;1753:	if ( !f ) {
;1754:		trap_Print( va( S_COLOR_RED "menu file not found: %s, using default\n", filename ) );
;1755:		return NULL;
;1756:	}
;1757:	if ( len >= MAX_MENUFILE ) {
;1758:		trap_Print( va( S_COLOR_RED "menu file too large: %s is %i, max allowed is %i", filename, len, MAX_MENUFILE ) );
;1759:		trap_FS_FCloseFile( f );
;1760:		return NULL;
;1761:	}
;1762:
;1763:	trap_FS_Read( buf, len, f );
;1764:	buf[len] = 0;
;1765:	trap_FS_FCloseFile( f );
;1766:
;1767:	return buf;
;1768:}
;1769:
;1770://
;1771:// ==============================
;1772:// new hud stuff ( mission pack )
;1773:// ==============================
;1774://
;1775:qboolean CG_Asset_Parse(int handle) {
;1776:	pc_token_t token;
;1777:	const char *tempStr;
;1778:
;1779:	if (!trap_PC_ReadToken(handle, &token))
;1780:		return qfalse;
;1781:	if (Q_stricmp(token.string, "{") != 0) {
;1782:		return qfalse;
;1783:	}
;1784:    
;1785:	while ( 1 ) {
;1786:		if (!trap_PC_ReadToken(handle, &token))
;1787:			return qfalse;
;1788:
;1789:		if (Q_stricmp(token.string, "}") == 0) {
;1790:			return qtrue;
;1791:		}
;1792:
;1793:		// font
;1794:		if (Q_stricmp(token.string, "font") == 0) {
;1795:			int pointSize;
;1796:			if (!PC_String_Parse(handle, &tempStr) || !PC_Int_Parse(handle, &pointSize)) {
;1797:				return qfalse;
;1798:			}
;1799:			cgDC.registerFont(tempStr, pointSize, &cgDC.Assets.textFont);
;1800:			continue;
;1801:		}
;1802:
;1803:		// smallFont
;1804:		if (Q_stricmp(token.string, "smallFont") == 0) {
;1805:			int pointSize;
;1806:			if (!PC_String_Parse(handle, &tempStr) || !PC_Int_Parse(handle, &pointSize)) {
;1807:				return qfalse;
;1808:			}
;1809:			cgDC.registerFont(tempStr, pointSize, &cgDC.Assets.smallFont);
;1810:			continue;
;1811:		}
;1812:
;1813:		// font
;1814:		if (Q_stricmp(token.string, "bigfont") == 0) {
;1815:			int pointSize;
;1816:			if (!PC_String_Parse(handle, &tempStr) || !PC_Int_Parse(handle, &pointSize)) {
;1817:				return qfalse;
;1818:			}
;1819:			cgDC.registerFont(tempStr, pointSize, &cgDC.Assets.bigFont);
;1820:			continue;
;1821:		}
;1822:
;1823:		// gradientbar
;1824:		if (Q_stricmp(token.string, "gradientbar") == 0) {
;1825:			if (!PC_String_Parse(handle, &tempStr)) {
;1826:				return qfalse;
;1827:			}
;1828:			cgDC.Assets.gradientBar = trap_R_RegisterShaderNoMip(tempStr);
;1829:			continue;
;1830:		}
;1831:
;1832:		// enterMenuSound
;1833:		if (Q_stricmp(token.string, "menuEnterSound") == 0) {
;1834:			if (!PC_String_Parse(handle, &tempStr)) {
;1835:				return qfalse;
;1836:			}
;1837:			cgDC.Assets.menuEnterSound = trap_S_RegisterSound( tempStr, qfalse );
;1838:			continue;
;1839:		}
;1840:
;1841:		// exitMenuSound
;1842:		if (Q_stricmp(token.string, "menuExitSound") == 0) {
;1843:			if (!PC_String_Parse(handle, &tempStr)) {
;1844:				return qfalse;
;1845:			}
;1846:			cgDC.Assets.menuExitSound = trap_S_RegisterSound( tempStr, qfalse );
;1847:			continue;
;1848:		}
;1849:
;1850:		// itemFocusSound
;1851:		if (Q_stricmp(token.string, "itemFocusSound") == 0) {
;1852:			if (!PC_String_Parse(handle, &tempStr)) {
;1853:				return qfalse;
;1854:			}
;1855:			cgDC.Assets.itemFocusSound = trap_S_RegisterSound( tempStr, qfalse );
;1856:			continue;
;1857:		}
;1858:
;1859:		// menuBuzzSound
;1860:		if (Q_stricmp(token.string, "menuBuzzSound") == 0) {
;1861:			if (!PC_String_Parse(handle, &tempStr)) {
;1862:				return qfalse;
;1863:			}
;1864:			cgDC.Assets.menuBuzzSound = trap_S_RegisterSound( tempStr, qfalse );
;1865:			continue;
;1866:		}
;1867:
;1868:		if (Q_stricmp(token.string, "cursor") == 0) {
;1869:			if (!PC_String_Parse(handle, &cgDC.Assets.cursorStr)) {
;1870:				return qfalse;
;1871:			}
;1872:			cgDC.Assets.cursor = trap_R_RegisterShaderNoMip( cgDC.Assets.cursorStr);
;1873:			continue;
;1874:		}
;1875:
;1876:		if (Q_stricmp(token.string, "fadeClamp") == 0) {
;1877:			if (!PC_Float_Parse(handle, &cgDC.Assets.fadeClamp)) {
;1878:				return qfalse;
;1879:			}
;1880:			continue;
;1881:		}
;1882:
;1883:		if (Q_stricmp(token.string, "fadeCycle") == 0) {
;1884:			if (!PC_Int_Parse(handle, &cgDC.Assets.fadeCycle)) {
;1885:				return qfalse;
;1886:			}
;1887:			continue;
;1888:		}
;1889:
;1890:		if (Q_stricmp(token.string, "fadeAmount") == 0) {
;1891:			if (!PC_Float_Parse(handle, &cgDC.Assets.fadeAmount)) {
;1892:				return qfalse;
;1893:			}
;1894:			continue;
;1895:		}
;1896:
;1897:		if (Q_stricmp(token.string, "shadowX") == 0) {
;1898:			if (!PC_Float_Parse(handle, &cgDC.Assets.shadowX)) {
;1899:				return qfalse;
;1900:			}
;1901:			continue;
;1902:		}
;1903:
;1904:		if (Q_stricmp(token.string, "shadowY") == 0) {
;1905:			if (!PC_Float_Parse(handle, &cgDC.Assets.shadowY)) {
;1906:				return qfalse;
;1907:			}
;1908:			continue;
;1909:		}
;1910:
;1911:		if (Q_stricmp(token.string, "shadowColor") == 0) {
;1912:			if (!PC_Color_Parse(handle, &cgDC.Assets.shadowColor)) {
;1913:				return qfalse;
;1914:			}
;1915:			cgDC.Assets.shadowFadeClamp = cgDC.Assets.shadowColor[3];
;1916:			continue;
;1917:		}
;1918:	}
;1919:	return qfalse; // bk001204 - why not?
;1920:}
;1921:
;1922:void CG_ParseMenu(const char *menuFile) {
;1923:	pc_token_t token;
;1924:	int handle;
;1925:
;1926:	handle = trap_PC_LoadSource(menuFile);
;1927:	if (!handle)
;1928:		handle = trap_PC_LoadSource("ui/testhud.menu");
;1929:	if (!handle)
;1930:		return;
;1931:
;1932:	while ( 1 ) {
;1933:		if (!trap_PC_ReadToken( handle, &token )) {
;1934:			break;
;1935:		}
;1936:
;1937:		//if ( Q_stricmp( token, "{" ) ) {
;1938:		//	Com_Printf( "Missing { in menu file\n" );
;1939:		//	break;
;1940:		//}
;1941:
;1942:		//if ( menuCount == MAX_MENUS ) {
;1943:		//	Com_Printf( "Too many menus!\n" );
;1944:		//	break;
;1945:		//}
;1946:
;1947:		if ( token.string[0] == '}' ) {
;1948:			break;
;1949:		}
;1950:
;1951:		if (Q_stricmp(token.string, "assetGlobalDef") == 0) {
;1952:			if (CG_Asset_Parse(handle)) {
;1953:				continue;
;1954:			} else {
;1955:				break;
;1956:			}
;1957:		}
;1958:
;1959:
;1960:		if (Q_stricmp(token.string, "menudef") == 0) {
;1961:			// start a new menu
;1962:			Menu_New(handle);
;1963:		}
;1964:	}
;1965:	trap_PC_FreeSource(handle);
;1966:}
;1967:
;1968:qboolean CG_Load_Menu(char **p) {
;1969:	char *token;
;1970:
;1971:	token = COM_ParseExt(p, qtrue);
;1972:
;1973:	if (token[0] != '{') {
;1974:		return qfalse;
;1975:	}
;1976:
;1977:	while ( 1 ) {
;1978:
;1979:		token = COM_ParseExt(p, qtrue);
;1980:    
;1981:		if (Q_stricmp(token, "}") == 0) {
;1982:			return qtrue;
;1983:		}
;1984:
;1985:		if ( !token || token[0] == 0 ) {
;1986:			return qfalse;
;1987:		}
;1988:
;1989:		CG_ParseMenu(token); 
;1990:	}
;1991:	return qfalse;
;1992:}
;1993:
;1994:
;1995:
;1996:void CG_LoadMenus(const char *menuFile) {
;1997:	char	*token;
;1998:	char *p;
;1999:	int	len, start;
;2000:	fileHandle_t	f;
;2001:	static char buf[MAX_MENUDEFFILE];
;2002:
;2003:	start = trap_Milliseconds();
;2004:
;2005:	len = trap_FS_FOpenFile( menuFile, &f, FS_READ );
;2006:	if ( !f ) {
;2007:		trap_Error( va( S_COLOR_YELLOW "menu file not found: %s, using default\n", menuFile ) );
;2008:		len = trap_FS_FOpenFile( "ui/hud.txt", &f, FS_READ );
;2009:		if (!f) {
;2010:			trap_Error( va( S_COLOR_RED "default menu file not found: ui/hud.txt, unable to continue!\n", menuFile ) );
;2011:		}
;2012:	}
;2013:
;2014:	if ( len >= MAX_MENUDEFFILE ) {
;2015:		trap_Error( va( S_COLOR_RED "menu file too large: %s is %i, max allowed is %i", menuFile, len, MAX_MENUDEFFILE ) );
;2016:		trap_FS_FCloseFile( f );
;2017:		return;
;2018:	}
;2019:
;2020:	trap_FS_Read( buf, len, f );
;2021:	buf[len] = 0;
;2022:	trap_FS_FCloseFile( f );
;2023:	
;2024:	COM_Compress(buf);
;2025:
;2026:	Menu_Reset();
;2027:
;2028:	p = buf;
;2029:
;2030:	while ( 1 ) {
;2031:		token = COM_ParseExt( &p, qtrue );
;2032:		if( !token || token[0] == 0 || token[0] == '}') {
;2033:			break;
;2034:		}
;2035:
;2036:		//if ( Q_stricmp( token, "{" ) ) {
;2037:		//	Com_Printf( "Missing { in menu file\n" );
;2038:		//	break;
;2039:		//}
;2040:
;2041:		//if ( menuCount == MAX_MENUS ) {
;2042:		//	Com_Printf( "Too many menus!\n" );
;2043:		//	break;
;2044:		//}
;2045:
;2046:		if ( Q_stricmp( token, "}" ) == 0 ) {
;2047:			break;
;2048:		}
;2049:
;2050:		if (Q_stricmp(token, "loadmenu") == 0) {
;2051:			if (CG_Load_Menu(&p)) {
;2052:				continue;
;2053:			} else {
;2054:				break;
;2055:			}
;2056:		}
;2057:	}
;2058:
;2059:	Com_Printf("UI menu load time = %d milli seconds\n", trap_Milliseconds() - start);
;2060:
;2061:}
;2062:
;2063:
;2064:
;2065:static qboolean CG_OwnerDrawHandleKey(int ownerDraw, int flags, float *special, int key) {
;2066:	return qfalse;
;2067:}
;2068:
;2069:
;2070:static int CG_FeederCount(float feederID) {
;2071:	int i, count;
;2072:	count = 0;
;2073:	if (feederID == FEEDER_REDTEAM_LIST) {
;2074:		for (i = 0; i < cg.numScores; i++) {
;2075:			if (cg.scores[i].team == TEAM_RED) {
;2076:				count++;
;2077:			}
;2078:		}
;2079:	} else if (feederID == FEEDER_BLUETEAM_LIST) {
;2080:		for (i = 0; i < cg.numScores; i++) {
;2081:			if (cg.scores[i].team == TEAM_BLUE) {
;2082:				count++;
;2083:			}
;2084:		}
;2085:	} else if (feederID == FEEDER_SCOREBOARD) {
;2086:		return cg.numScores;
;2087:	}
;2088:	return count;
;2089:}
;2090:
;2091:
;2092:void CG_SetScoreSelection(void *p) {
;2093:	menuDef_t *menu = (menuDef_t*)p;
;2094:	playerState_t *ps = &cg.snap->ps;
;2095:	int i, red, blue;
;2096:	red = blue = 0;
;2097:	for (i = 0; i < cg.numScores; i++) {
;2098:		if (cg.scores[i].team == TEAM_RED) {
;2099:			red++;
;2100:		} else if (cg.scores[i].team == TEAM_BLUE) {
;2101:			blue++;
;2102:		}
;2103:		if (ps->clientNum == cg.scores[i].client) {
;2104:			cg.selectedScore = i;
;2105:		}
;2106:	}
;2107:
;2108:	if (menu == NULL) {
;2109:		// just interested in setting the selected score
;2110:		return;
;2111:	}
;2112:
;2113:	if ( cgs.gametype >= GT_TEAM ) {
;2114:		int feeder = FEEDER_REDTEAM_LIST;
;2115:		i = red;
;2116:		if (cg.scores[cg.selectedScore].team == TEAM_BLUE) {
;2117:			feeder = FEEDER_BLUETEAM_LIST;
;2118:			i = blue;
;2119:		}
;2120:		Menu_SetFeederSelection(menu, feeder, i, NULL);
;2121:	} else {
;2122:		Menu_SetFeederSelection(menu, FEEDER_SCOREBOARD, cg.selectedScore, NULL);
;2123:	}
;2124:}
;2125:
;2126:// FIXME: might need to cache this info
;2127:static clientInfo_t * CG_InfoFromScoreIndex(int index, int team, int *scoreIndex) {
;2128:	int i, count;
;2129:	if ( cgs.gametype >= GT_TEAM ) {
;2130:		count = 0;
;2131:		for (i = 0; i < cg.numScores; i++) {
;2132:			if (cg.scores[i].team == team) {
;2133:				if (count == index) {
;2134:					*scoreIndex = i;
;2135:					return &cgs.clientinfo[cg.scores[i].client];
;2136:				}
;2137:				count++;
;2138:			}
;2139:		}
;2140:	}
;2141:	*scoreIndex = index;
;2142:	return &cgs.clientinfo[ cg.scores[index].client ];
;2143:}
;2144:
;2145:static const char *CG_FeederItemText(float feederID, int index, int column, qhandle_t *handle) {
;2146:	gitem_t *item;
;2147:	int scoreIndex = 0;
;2148:	clientInfo_t *info = NULL;
;2149:	int team = -1;
;2150:	score_t *sp = NULL;
;2151:
;2152:	*handle = -1;
;2153:
;2154:	if (feederID == FEEDER_REDTEAM_LIST) {
;2155:		team = TEAM_RED;
;2156:	} else if (feederID == FEEDER_BLUETEAM_LIST) {
;2157:		team = TEAM_BLUE;
;2158:	}
;2159:
;2160:	info = CG_InfoFromScoreIndex(index, team, &scoreIndex);
;2161:	sp = &cg.scores[scoreIndex];
;2162:
;2163:	if (info && info->infoValid) {
;2164:		switch (column) {
;2165:			case 0:
;2166:				if ( info->powerups & ( 1 << PW_NEUTRALFLAG ) ) {
;2167:					item = BG_FindItemForPowerup( PW_NEUTRALFLAG );
;2168:					*handle = cg_items[ ITEM_INDEX(item) ].icon;
;2169:				} else if ( info->powerups & ( 1 << PW_REDFLAG ) ) {
;2170:					item = BG_FindItemForPowerup( PW_REDFLAG );
;2171:					*handle = cg_items[ ITEM_INDEX(item) ].icon;
;2172:				} else if ( info->powerups & ( 1 << PW_BLUEFLAG ) ) {
;2173:					item = BG_FindItemForPowerup( PW_BLUEFLAG );
;2174:					*handle = cg_items[ ITEM_INDEX(item) ].icon;
;2175:				} else {
;2176:					if ( info->botSkill > 0 && info->botSkill <= 5 ) {
;2177:						*handle = cgs.media.botSkillShaders[ info->botSkill - 1 ];
;2178:					} else if ( info->handicap < 100 ) {
;2179:					return va("%i", info->handicap );
;2180:					}
;2181:				}
;2182:			break;
;2183:			case 1:
;2184:				if (team == -1) {
;2185:					return "";
;2186:				} else {
;2187://freeze
;2188:					if ( Q_Isfreeze( sp->client ) )
;2189:						*handle = cgs.media.noammoShader;
;2190:					else
;2191://freeze
;2192:					*handle = CG_StatusHandle(info->teamTask);
;2193:				}
;2194:		  break;
;2195:			case 2:
;2196:				if ( cg.snap->ps.stats[ STAT_CLIENTS_READY ] & ( 1 << sp->client ) ) {
;2197://freeze
;2198:					if ( !Q_Isfreeze( sp->client ) )
;2199://freeze
;2200:					return "Ready";
;2201:				}
;2202:				if (team == -1) {
;2203:					if (cgs.gametype == GT_TOURNAMENT) {
;2204:						return va("%i/%i", info->wins, info->losses);
;2205:					} else if (info->infoValid && info->team == TEAM_SPECTATOR ) {
;2206:						return "Spectator";
;2207:					} else {
;2208:						return "";
;2209:					}
;2210:				} else {
;2211://freeze
;2212:					if ( cgs.gametype == GT_TEAM || cgs.gametype == GT_CTF ) {
;2213:						return va( "%i %s", sp->scoreFlags, info->teamLeader ? "L" : "" );
;2214:					}
;2215://freeze
;2216:					if (info->teamLeader) {
;2217:						return "Leader";
;2218:					}
;2219:				}
;2220:			break;
;2221:			case 3:
;2222:				return info->name;
;2223:			break;
;2224:			case 4:
;2225:				return va("%i", info->score);
;2226:			break;
;2227:			case 5:
;2228:				return va("%4i", sp->time);
;2229:			break;
;2230:			case 6:
;2231:				if ( sp->ping == -1 ) {
;2232:					return "connecting";
;2233:				} 
;2234:				return va("%4i", sp->ping);
;2235:			break;
;2236:		}
;2237:	}
;2238:
;2239:	return "";
;2240:}
;2241:
;2242:static qhandle_t CG_FeederItemImage(float feederID, int index) {
;2243:	return 0;
;2244:}
;2245:
;2246:static void CG_FeederSelection(float feederID, int index) {
;2247:	if ( cgs.gametype >= GT_TEAM ) {
;2248:		int i, count;
;2249:		int team = (feederID == FEEDER_REDTEAM_LIST) ? TEAM_RED : TEAM_BLUE;
;2250:		count = 0;
;2251:		for (i = 0; i < cg.numScores; i++) {
;2252:			if (cg.scores[i].team == team) {
;2253:				if (index == count) {
;2254:					cg.selectedScore = i;
;2255:				}
;2256:				count++;
;2257:			}
;2258:		}
;2259:	} else {
;2260:		cg.selectedScore = index;
;2261:	}
;2262:}
;2263:#endif
;2264:
;2265:#ifdef MISSIONPACK // bk001204 - only needed there
;2266:static float CG_Cvar_Get(const char *cvar) {
;2267:	char buff[128];
;2268:	memset(buff, 0, sizeof(buff));
;2269:	trap_Cvar_VariableStringBuffer(cvar, buff, sizeof(buff));
;2270:	return atof(buff);
;2271:}
;2272:#endif
;2273:
;2274:#ifdef MISSIONPACK
;2275:void CG_Text_PaintWithCursor(float x, float y, float scale, vec4_t color, const char *text, int cursorPos, char cursor, int limit, int style) {
;2276:	CG_Text_Paint(x, y, scale, color, text, 0, limit, style);
;2277:}
;2278:
;2279:static int CG_OwnerDrawWidth(int ownerDraw, float scale) {
;2280:	switch (ownerDraw) {
;2281:	  case CG_GAME_TYPE:
;2282:			return CG_Text_Width(CG_GameTypeString(), scale, 0);
;2283:	  case CG_GAME_STATUS:
;2284:			return CG_Text_Width(CG_GetGameStatusText(), scale, 0);
;2285:			break;
;2286:	  case CG_KILLER:
;2287:			return CG_Text_Width(CG_GetKillerText(), scale, 0);
;2288:			break;
;2289:	  case CG_RED_NAME:
;2290:			return CG_Text_Width(cg_redTeamName.string, scale, 0);
;2291:			break;
;2292:	  case CG_BLUE_NAME:
;2293:			return CG_Text_Width(cg_blueTeamName.string, scale, 0);
;2294:			break;
;2295:
;2296:
;2297:	}
;2298:	return 0;
;2299:}
;2300:
;2301:static int CG_PlayCinematic(const char *name, float x, float y, float w, float h) {
;2302:  return trap_CIN_PlayCinematic(name, x, y, w, h, CIN_loop);
;2303:}
;2304:
;2305:static void CG_StopCinematic(int handle) {
;2306:  trap_CIN_StopCinematic(handle);
;2307:}
;2308:
;2309:static void CG_DrawCinematic(int handle, float x, float y, float w, float h) {
;2310:  trap_CIN_SetExtents(handle, x, y, w, h);
;2311:  trap_CIN_DrawCinematic(handle);
;2312:}
;2313:
;2314:static void CG_RunCinematicFrame(int handle) {
;2315:  trap_CIN_RunCinematic(handle);
;2316:}
;2317:
;2318:/*
;2319:=================
;2320:CG_LoadHudMenu();
;2321:
;2322:=================
;2323:*/
;2324:void CG_LoadHudMenu() {
;2325:	char buff[1024];
;2326:	const char *hudSet;
;2327:
;2328:	cgDC.registerShaderNoMip = &trap_R_RegisterShaderNoMip;
;2329:	cgDC.setColor = &trap_R_SetColor;
;2330:	cgDC.drawHandlePic = &CG_DrawPic;
;2331:	cgDC.drawStretchPic = &trap_R_DrawStretchPic;
;2332:	cgDC.drawText = &CG_Text_Paint;
;2333:	cgDC.textWidth = &CG_Text_Width;
;2334:	cgDC.textHeight = &CG_Text_Height;
;2335:	cgDC.registerModel = &trap_R_RegisterModel;
;2336:	cgDC.modelBounds = &trap_R_ModelBounds;
;2337:	cgDC.fillRect = &CG_FillRect;
;2338:	cgDC.drawRect = &CG_DrawRect;   
;2339:	cgDC.drawSides = &CG_DrawSides;
;2340:	cgDC.drawTopBottom = &CG_DrawTopBottom;
;2341:	cgDC.clearScene = &trap_R_ClearScene;
;2342:	cgDC.addRefEntityToScene = &trap_R_AddRefEntityToScene;
;2343:	cgDC.renderScene = &trap_R_RenderScene;
;2344:	cgDC.registerFont = &trap_R_RegisterFont;
;2345:	cgDC.ownerDrawItem = &CG_OwnerDraw;
;2346:	cgDC.getValue = &CG_GetValue;
;2347:	cgDC.ownerDrawVisible = &CG_OwnerDrawVisible;
;2348:	cgDC.runScript = &CG_RunMenuScript;
;2349:	cgDC.getTeamColor = &CG_GetTeamColor;
;2350:	cgDC.setCVar = trap_Cvar_Set;
;2351:	cgDC.getCVarString = trap_Cvar_VariableStringBuffer;
;2352:	cgDC.getCVarValue = CG_Cvar_Get;
;2353:	cgDC.drawTextWithCursor = &CG_Text_PaintWithCursor;
;2354:	//cgDC.setOverstrikeMode = &trap_Key_SetOverstrikeMode;
;2355:	//cgDC.getOverstrikeMode = &trap_Key_GetOverstrikeMode;
;2356:	cgDC.startLocalSound = &trap_S_StartLocalSound;
;2357:	cgDC.ownerDrawHandleKey = &CG_OwnerDrawHandleKey;
;2358:	cgDC.feederCount = &CG_FeederCount;
;2359:	cgDC.feederItemImage = &CG_FeederItemImage;
;2360:	cgDC.feederItemText = &CG_FeederItemText;
;2361:	cgDC.feederSelection = &CG_FeederSelection;
;2362:	//cgDC.setBinding = &trap_Key_SetBinding;
;2363:	//cgDC.getBindingBuf = &trap_Key_GetBindingBuf;
;2364:	//cgDC.keynumToStringBuf = &trap_Key_KeynumToStringBuf;
;2365:	//cgDC.executeText = &trap_Cmd_ExecuteText;
;2366:	cgDC.Error = &Com_Error; 
;2367:	cgDC.Print = &Com_Printf; 
;2368:	cgDC.ownerDrawWidth = &CG_OwnerDrawWidth;
;2369:	//cgDC.Pause = &CG_Pause;
;2370:	cgDC.registerSound = &trap_S_RegisterSound;
;2371:	cgDC.startBackgroundTrack = &trap_S_StartBackgroundTrack;
;2372:	cgDC.stopBackgroundTrack = &trap_S_StopBackgroundTrack;
;2373:	cgDC.playCinematic = &CG_PlayCinematic;
;2374:	cgDC.stopCinematic = &CG_StopCinematic;
;2375:	cgDC.drawCinematic = &CG_DrawCinematic;
;2376:	cgDC.runCinematicFrame = &CG_RunCinematicFrame;
;2377:	
;2378:	Init_Display(&cgDC);
;2379:
;2380:	Menu_Reset();
;2381:	
;2382:	trap_Cvar_VariableStringBuffer("cg_hudFiles", buff, sizeof(buff));
;2383:	hudSet = buff;
;2384:	if (hudSet[0] == '\0') {
;2385:		hudSet = "ui/hud.txt";
;2386:	}
;2387:
;2388:	CG_LoadMenus(hudSet);
;2389:}
;2390:
;2391:void CG_AssetCache() {
;2392:	//if (Assets.textFont == NULL) {
;2393:	//  trap_R_RegisterFont("fonts/arial.ttf", 72, &Assets.textFont);
;2394:	//}
;2395:	//Assets.background = trap_R_RegisterShaderNoMip( ASSET_BACKGROUND );
;2396:	//Com_Printf("Menu Size: %i bytes\n", sizeof(Menus));
;2397:	cgDC.Assets.gradientBar = trap_R_RegisterShaderNoMip( ASSET_GRADIENTBAR );
;2398:	cgDC.Assets.fxBasePic = trap_R_RegisterShaderNoMip( ART_FX_BASE );
;2399:	cgDC.Assets.fxPic[0] = trap_R_RegisterShaderNoMip( ART_FX_RED );
;2400:	cgDC.Assets.fxPic[1] = trap_R_RegisterShaderNoMip( ART_FX_YELLOW );
;2401:	cgDC.Assets.fxPic[2] = trap_R_RegisterShaderNoMip( ART_FX_GREEN );
;2402:	cgDC.Assets.fxPic[3] = trap_R_RegisterShaderNoMip( ART_FX_TEAL );
;2403:	cgDC.Assets.fxPic[4] = trap_R_RegisterShaderNoMip( ART_FX_BLUE );
;2404:	cgDC.Assets.fxPic[5] = trap_R_RegisterShaderNoMip( ART_FX_CYAN );
;2405:	cgDC.Assets.fxPic[6] = trap_R_RegisterShaderNoMip( ART_FX_WHITE );
;2406:	cgDC.Assets.scrollBar = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR );
;2407:	cgDC.Assets.scrollBarArrowDown = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR_ARROWDOWN );
;2408:	cgDC.Assets.scrollBarArrowUp = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR_ARROWUP );
;2409:	cgDC.Assets.scrollBarArrowLeft = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR_ARROWLEFT );
;2410:	cgDC.Assets.scrollBarArrowRight = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR_ARROWRIGHT );
;2411:	cgDC.Assets.scrollBarThumb = trap_R_RegisterShaderNoMip( ASSET_SCROLL_THUMB );
;2412:	cgDC.Assets.sliderBar = trap_R_RegisterShaderNoMip( ASSET_SLIDER_BAR );
;2413:	cgDC.Assets.sliderThumb = trap_R_RegisterShaderNoMip( ASSET_SLIDER_THUMB );
;2414:}
;2415:#endif
;2416:/*
;2417:=================
;2418:CG_Init
;2419:
;2420:Called after every level change or subsystem restart
;2421:Will perform callbacks to make the loading info screen update.
;2422:=================
;2423:*/
;2424:void CG_Init( int serverMessageNum, int serverCommandSequence, int clientNum ) {
line 2428
;2425:	const char	*s;
;2426:
;2427:	// clear everything
;2428:	memset( &cgs, 0, sizeof( cgs ) );
ADDRGP4 cgs
ARGP4
CNSTI4 0
ARGI4
CNSTI4 157876
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2429
;2429:	memset( &cg, 0, sizeof( cg ) );
ADDRGP4 cg
ARGP4
CNSTI4 0
ARGI4
CNSTI4 170860
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2430
;2430:	memset( cg_entities, 0, sizeof(cg_entities) );
ADDRGP4 cg_entities
ARGP4
CNSTI4 0
ARGI4
CNSTI4 745472
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2431
;2431:	memset( cg_weapons, 0, sizeof(cg_weapons) );
ADDRGP4 cg_weapons
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2432
;2432:	memset( cg_items, 0, sizeof(cg_items) );
ADDRGP4 cg_items
ARGP4
CNSTI4 0
ARGI4
CNSTI4 6144
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2433
;2433:	memset( autoFile.date, 0, sizeof(autoFile.date) );
ADDRGP4 autoFile+1024
ARGP4
CNSTI4 0
ARGI4
CNSTI4 128
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2434
;2434:	memset( chat, 0, sizeof(chat) );
ADDRGP4 chat
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2080
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2436
;2435:
;2436:	cg.clientNum = clientNum;
ADDRGP4 cg+4
ADDRFP4 8
INDIRI4
ASGNI4
line 2438
;2437:
;2438:	cgs.autoScreenshotTaken = qfalse; //Enable autoScreenshots <-- this will probably happen after alt + enter/tab to cause multiple screenshots
ADDRGP4 cgs+157860
CNSTI4 0
ASGNI4
line 2439
;2439:	cgs.autoRecording = qfalse;
ADDRGP4 cgs+157864
CNSTI4 0
ASGNI4
line 2440
;2440:	cgs.stopRecording = 0;
ADDRGP4 cgs+157868
CNSTI4 0
ASGNI4
line 2441
;2441:	cgs.takeScreenshot = 0;
ADDRGP4 cgs+157872
CNSTI4 0
ASGNI4
line 2443
;2442:
;2443:	cgs.processedSnapshotNum = serverMessageNum;
ADDRGP4 cgs+31448
ADDRFP4 0
INDIRI4
ASGNI4
line 2444
;2444:	cgs.serverCommandSequence = serverCommandSequence;
ADDRGP4 cgs+31444
ADDRFP4 4
INDIRI4
ASGNI4
line 2447
;2445:
;2446:	// load a few needed things before we do any screen updates
;2447:	cgs.media.charsetShader		= trap_R_RegisterShader( "gfx/2d/bigchars" );
ADDRGP4 $1410
ARGP4
ADDRLP4 4
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680
ADDRLP4 4
INDIRI4
ASGNI4
line 2448
;2448:	cgs.media.charsetCPMA		= trap_R_RegisterShader( "fonts/cpma" );
ADDRGP4 $1413
ARGP4
ADDRLP4 8
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+4
ADDRLP4 8
INDIRI4
ASGNI4
line 2449
;2449:	cgs.media.charsetThreewave	= trap_R_RegisterShader( "fonts/threewave" );
ADDRGP4 $1416
ARGP4
ADDRLP4 12
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+8
ADDRLP4 12
INDIRI4
ASGNI4
line 2450
;2450:	cgs.media.charsetOSP		= trap_R_RegisterShader( "fonts/osp" );
ADDRGP4 $1419
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+12
ADDRLP4 16
INDIRI4
ASGNI4
line 2451
;2451:	cgs.media.charsetRevolution = trap_R_RegisterShader( "fonts/revolution" );
ADDRGP4 $1422
ARGP4
ADDRLP4 20
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+16
ADDRLP4 20
INDIRI4
ASGNI4
line 2452
;2452:	cgs.media.whiteShader		= trap_R_RegisterShader( "white" );
ADDRGP4 $1425
ARGP4
ADDRLP4 24
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+36
ADDRLP4 24
INDIRI4
ASGNI4
line 2453
;2453:	cgs.media.charsetProp		= trap_R_RegisterShaderNoMip( "menu/art/font1_prop.tga" );
ADDRGP4 $1428
ARGP4
ADDRLP4 28
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+156680+20
ADDRLP4 28
INDIRI4
ASGNI4
line 2454
;2454:	cgs.media.charsetPropGlow	= trap_R_RegisterShaderNoMip( "menu/art/font1_prop_glo.tga" );
ADDRGP4 $1431
ARGP4
ADDRLP4 32
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+156680+24
ADDRLP4 32
INDIRI4
ASGNI4
line 2455
;2455:	cgs.media.charsetPropB		= trap_R_RegisterShaderNoMip( "menu/art/font2_prop.tga" );
ADDRGP4 $1434
ARGP4
ADDRLP4 36
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+156680+28
ADDRLP4 36
INDIRI4
ASGNI4
line 2456
;2456:	cgs.media.charsetPropC		= trap_R_RegisterShader( "fonts/idblock" );
ADDRGP4 $1437
ARGP4
ADDRLP4 40
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+32
ADDRLP4 40
INDIRI4
ASGNI4
line 2457
;2457:	cgs.railHum = -2;//Incase it's not a dedicated server.
ADDRGP4 cgs+157808
CNSTI4 -2
ASGNI4
line 2459
;2458:
;2459:	CG_RegisterCvars();
ADDRGP4 CG_RegisterCvars
CALLV
pop
line 2461
;2460:
;2461:	CG_InitConsoleCommands();
ADDRGP4 CG_InitConsoleCommands
CALLV
pop
line 2463
;2462:
;2463:	SET_WEAPON(cg.weaponSelect, WP_MACHINEGUN);
ADDRGP4 cg+108944
CNSTI4 2
ASGNI4
line 2465
;2464:
;2465:	cgs.flags[TEAM_RED-1] = cgs.flags[TEAM_BLUE-1] = -1; // For compatibily, default to unset for
ADDRLP4 44
CNSTI4 -1
ASGNI4
ADDRGP4 cgs+34796+4
ADDRLP4 44
INDIRI4
ASGNI4
ADDRGP4 cgs+34796
ADDRLP4 44
INDIRI4
ASGNI4
line 2466
;2466:	cgs.flagStatus = -1;
ADDRGP4 cgs+34804
CNSTI4 -1
ASGNI4
line 2468
;2467:	// old servers
;2468:	cg.naftInterval = 0;
ADDRGP4 cg+162048
CNSTI4 0
ASGNI4
line 2469
;2469:	cg.lastHeldFlag = -16;//-16 isn't an item.. garunteed.
ADDRGP4 cg+162052
CNSTI4 -16
ASGNI4
line 2470
;2470:	cg.clockInterval = 0;
ADDRGP4 cg+162056
CNSTI4 0
ASGNI4
line 2471
;2471:	cg.score_time = 0;
ADDRGP4 cg+162064
CNSTI4 0
ASGNI4
line 2472
;2472:	cg.score_weapon = 1;
ADDRGP4 cg+162060
CNSTI4 1
ASGNI4
line 2473
;2473:	cgs.autoRecording = qfalse;
ADDRGP4 cgs+157864
CNSTI4 0
ASGNI4
line 2474
;2474:	cg.alternateHandicap = qfalse;
ADDRGP4 cg+162068
CNSTI4 0
ASGNI4
line 2478
;2475:
;2476:
;2477:	// get the rendering configuration from the client system
;2478:	trap_GetGlconfig( &cgs.glconfig );
ADDRGP4 cgs+20100
ARGP4
ADDRGP4 trap_GetGlconfig
CALLV
pop
line 2479
;2479:	cgs.screenXScale = cgs.glconfig.vidWidth / 640.0;
ADDRGP4 cgs+31432
ADDRGP4 cgs+20100+11304
INDIRI4
CVIF4 4
CNSTF4 1142947840
DIVF4
ASGNF4
line 2480
;2480:	cgs.screenYScale = cgs.glconfig.vidHeight / 480.0;
ADDRGP4 cgs+31436
ADDRGP4 cgs+20100+11308
INDIRI4
CVIF4 4
CNSTF4 1139802112
DIVF4
ASGNF4
line 2483
;2481:
;2482:	// get the gamestate from the client system
;2483:	trap_GetGameState( &cgs.gameState );
ADDRGP4 cgs
ARGP4
ADDRGP4 trap_GetGameState
CALLV
pop
line 2486
;2484:
;2485:	// check version
;2486:	s = CG_ConfigString( CS_GAME_VERSION );
CNSTI4 20
ARGI4
ADDRLP4 48
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 48
INDIRP4
ASGNP4
line 2487
;2487:	if ( strcmp( s, GAME_VERSION ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1460
ARGP4
ADDRLP4 52
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $1458
line 2488
;2488:		CG_Error( "Client/Server game mismatch: %s/%s", GAME_VERSION, s );
ADDRGP4 $1461
ARGP4
ADDRGP4 $1460
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 2489
;2489:	}
LABELV $1458
line 2491
;2490:
;2491:	s = CG_ConfigString( CS_LEVEL_START_TIME );
CNSTI4 21
ARGI4
ADDRLP4 56
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 56
INDIRP4
ASGNP4
line 2492
;2492:	cgs.levelStartTime = atoi( s );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+34784
ADDRLP4 60
INDIRI4
ASGNI4
line 2494
;2493:
;2494:	CG_ParseServerinfo();
ADDRGP4 CG_ParseServerinfo
CALLV
pop
line 2497
;2495:
;2496:	// CPM: Setup according to the pro mode settings
;2497:	s = CG_ConfigString( CS_PRO_MODE );
CNSTI4 16
ARGI4
ADDRLP4 64
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 64
INDIRP4
ASGNP4
line 2498
;2498:	CPM_UpdateSettings( (atoi(s)) ? ((cgs.gametype == GT_TEAM) ? 2 : 1) : 0 );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
EQI4 $1466
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
NEI4 $1468
ADDRLP4 72
CNSTI4 2
ASGNI4
ADDRGP4 $1469
JUMPV
LABELV $1468
ADDRLP4 72
CNSTI4 1
ASGNI4
LABELV $1469
ADDRLP4 68
ADDRLP4 72
INDIRI4
ASGNI4
ADDRGP4 $1467
JUMPV
LABELV $1466
ADDRLP4 68
CNSTI4 0
ASGNI4
LABELV $1467
ADDRLP4 68
INDIRI4
ARGI4
ADDRGP4 CPM_UpdateSettings
CALLV
pop
line 2502
;2499:	// !CPM
;2500:
;2501:	// load the new map
;2502:	CG_LoadingString( "collision map" );
ADDRGP4 $1470
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 2504
;2503:
;2504:	trap_CM_LoadMap( cgs.mapname );
ADDRGP4 cgs+31484
ARGP4
ADDRGP4 trap_CM_LoadMap
CALLV
pop
line 2510
;2505:
;2506:#ifdef MISSIONPACK
;2507:	String_Init();
;2508:#endif
;2509:
;2510:	cg.loading = qtrue;		// force players to load instead of defer
ADDRGP4 cg+20
CNSTI4 1
ASGNI4
line 2512
;2511:
;2512:	CG_LoadingString( "sounds" );
ADDRGP4 $1473
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 2514
;2513:
;2514:	CG_RegisterSounds();
ADDRGP4 CG_RegisterSounds
CALLV
pop
line 2516
;2515:
;2516:	CG_LoadingString( "graphics" );
ADDRGP4 $1474
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 2518
;2517:
;2518:	CG_RegisterGraphics();
ADDRGP4 CG_RegisterGraphics
CALLV
pop
line 2520
;2519:
;2520:	CG_LoadingString( "clients" );
ADDRGP4 $1475
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 2522
;2521:
;2522:	CG_RegisterClients();		// if low on memory, some clients will be deferred
ADDRGP4 CG_RegisterClients
CALLV
pop
line 2529
;2523:
;2524:#ifdef MISSIONPACK
;2525:	CG_AssetCache();
;2526:	CG_LoadHudMenu();      // load new hud stuff
;2527:#endif
;2528:
;2529:	cg.loading = qfalse;	// future players will be deferred
ADDRGP4 cg+20
CNSTI4 0
ASGNI4
line 2531
;2530:
;2531:	CG_InitLocalEntities();
ADDRGP4 CG_InitLocalEntities
CALLV
pop
line 2533
;2532:
;2533:	CG_InitMarkPolys();
ADDRGP4 CG_InitMarkPolys
CALLV
pop
line 2536
;2534:
;2535:	// remove the last loading update
;2536:	cg.infoScreenText[0] = 0;
ADDRGP4 cg+109440
CNSTI1 0
ASGNI1
line 2539
;2537:
;2538:	// Make sure we have update values (scores)
;2539:	CG_SetConfigValues();
ADDRGP4 CG_SetConfigValues
CALLV
pop
line 2541
;2540:
;2541:	CG_StartMusic();
ADDRGP4 CG_StartMusic
CALLV
pop
line 2543
;2542:
;2543:	CG_LoadingString( "" );
ADDRGP4 $93
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 2549
;2544:
;2545:#ifdef MISSIONPACK
;2546:	CG_InitTeamChat();
;2547:#endif
;2548:
;2549:	CG_ShaderStateChanged();
ADDRGP4 CG_ShaderStateChanged
CALLV
pop
line 2551
;2550:
;2551:	trap_S_ClearLoopingSounds( qtrue );
CNSTI4 1
ARGI4
ADDRGP4 trap_S_ClearLoopingSounds
CALLV
pop
line 2553
;2552:
;2553:	if ( strlen(ch_file.string) ) {
ADDRGP4 ch_file+16
ARGP4
ADDRLP4 80
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
EQI4 $1478
line 2555
;2554:		//Load the superhud
;2555:		trap_SendConsoleCommand("reloadHUD");
ADDRGP4 $1481
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 2556
;2556:	}
LABELV $1478
line 2557
;2557:}
LABELV $1399
endproc CG_Init 84 12
export CG_Shutdown
proc CG_Shutdown 0 0
line 2566
;2558:
;2559:/*
;2560:=================
;2561:CG_Shutdown
;2562:
;2563:Called before every level change or subsystem restart
;2564:=================
;2565:*/
;2566:void CG_Shutdown( void ) {
line 2569
;2567:	// some mods may need to do cleanup work here,
;2568:	// like closing files or archiving session data
;2569:}
LABELV $1482
endproc CG_Shutdown 0 0
export CG_EventHandling
proc CG_EventHandling 0 0
line 2582
;2570:
;2571:/*
;2572:==================
;2573:CG_EventHandling
;2574:==================
;2575: type 0 - no event handling
;2576:      1 - team menu
;2577:      2 - hud editor
;2578:
;2579:*/
;2580:#ifndef MISSIONPACK
;2581:
;2582:void CG_EventHandling(int type) {
line 2583
;2583:}
LABELV $1483
endproc CG_EventHandling 0 0
export CG_KeyEvent
proc CG_KeyEvent 0 0
line 2585
;2584:
;2585:void CG_KeyEvent(int key, qboolean down) {
line 2586
;2586:}
LABELV $1484
endproc CG_KeyEvent 0 0
export CG_MouseEvent
proc CG_MouseEvent 0 4
line 2588
;2587:
;2588:void CG_MouseEvent(int x, int y) {
line 2589
;2589:	CG_Printf("MouseEvent\n");
ADDRGP4 $1486
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 2590
;2590:}
LABELV $1485
endproc CG_MouseEvent 0 4
export CheckFireHitAimType2
proc CheckFireHitAimType2 128 28
line 2598
;2591:
;2592:#endif
;2593:
;2594:
;2595:
;2596:
;2597:
;2598:int CheckFireHitAimType2() {
line 2608
;2599:	vec3_t		forward;
;2600:
;2601:	vec3_t		muzzle;
;2602://	vec3_t		start;
;2603:	vec3_t		end;
;2604:	trace_t		trace;
;2605:
;2606:	//cg_entities[0].currentState.
;2607:
;2608:	VectorCopy( cg.refdef.vieworg, muzzle );
ADDRLP4 0
ADDRGP4 cg+109048+24
INDIRB
ASGNB 12
line 2609
;2609:	AngleVectors( cg.refdefViewAngles, forward, NULL, NULL );
ADDRGP4 cg+109416
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 92
CNSTP4 0
ASGNP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 2610
;2610:	VectorMA( muzzle, 14, forward, muzzle );
ADDRLP4 96
CNSTF4 1096810496
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 96
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 96
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
line 2613
;2611:
;2612:	//FIXME: Get these settings from the server so they're not static
;2613:	VectorMA (muzzle, cg.weaponSelect==WP_GAUNTLET?(32):(cg.weaponSelect==WP_LIGHTNING?(LIGHTNING_RANGE):(8192)), forward, end);
ADDRGP4 cg+108944
INDIRI4
CNSTI4 1
NEI4 $1515
ADDRLP4 100
CNSTI4 32
ASGNI4
ADDRGP4 $1516
JUMPV
LABELV $1515
ADDRGP4 cg+108944
INDIRI4
CNSTI4 6
NEI4 $1517
ADDRLP4 104
CNSTI4 768
ASGNI4
ADDRGP4 $1518
JUMPV
LABELV $1517
ADDRLP4 104
CNSTI4 8192
ASGNI4
LABELV $1518
ADDRLP4 100
ADDRLP4 104
INDIRI4
ASGNI4
LABELV $1516
ADDRLP4 80
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
ADDRLP4 100
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+108944
INDIRI4
CNSTI4 1
NEI4 $1519
ADDRLP4 108
CNSTI4 32
ASGNI4
ADDRGP4 $1520
JUMPV
LABELV $1519
ADDRGP4 cg+108944
INDIRI4
CNSTI4 6
NEI4 $1521
ADDRLP4 112
CNSTI4 768
ASGNI4
ADDRGP4 $1522
JUMPV
LABELV $1521
ADDRLP4 112
CNSTI4 8192
ASGNI4
LABELV $1522
ADDRLP4 108
ADDRLP4 112
INDIRI4
ASGNI4
LABELV $1520
ADDRLP4 80+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 12+4
INDIRF4
ADDRLP4 108
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+108944
INDIRI4
CNSTI4 1
NEI4 $1523
ADDRLP4 116
CNSTI4 32
ASGNI4
ADDRGP4 $1524
JUMPV
LABELV $1523
ADDRGP4 cg+108944
INDIRI4
CNSTI4 6
NEI4 $1525
ADDRLP4 120
CNSTI4 768
ASGNI4
ADDRGP4 $1526
JUMPV
LABELV $1525
ADDRLP4 120
CNSTI4 8192
ASGNI4
LABELV $1526
ADDRLP4 116
ADDRLP4 120
INDIRI4
ASGNI4
LABELV $1524
ADDRLP4 80+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 12+8
INDIRF4
ADDRLP4 116
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 2615
;2614:
;2615:	CG_Trace (&trace, muzzle, NULL, NULL, end, cg.snap->ps.clientNum, MASK_SHOT );
ADDRLP4 24
ARGP4
ADDRLP4 0
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
ADDRLP4 80
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 2621
;2616:
;2617:	//CG_Printf( "Using Client: %d for server sync\n", trace.entityNum );
;2618:
;2619:	//return 4;
;2620:
;2621:	if ( trace.entityNum == cg.snap->ps.clientNum ) {
ADDRLP4 24+52
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $1528
line 2622
;2622:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1487
JUMPV
LABELV $1528
line 2625
;2623:	}
;2624:
;2625:	if (trace.entityNum >= 0 && trace.entityNum < MAX_CLIENTS) {
ADDRLP4 24+52
INDIRI4
CNSTI4 0
LTI4 $1532
ADDRLP4 24+52
INDIRI4
CNSTI4 64
GEI4 $1532
line 2627
;2626:		// add 1 to the client num, so we can still use 0 as a fail value.
;2627:		return (trace.entityNum + 1);
ADDRLP4 24+52
INDIRI4
CNSTI4 1
ADDI4
RETI4
ADDRGP4 $1487
JUMPV
LABELV $1532
line 2630
;2628:	}
;2629:
;2630:	return 0;
CNSTI4 0
RETI4
LABELV $1487
endproc CheckFireHitAimType2 128 28
bss
export cg_pmove_msec
align 4
LABELV cg_pmove_msec
skip 272
export cg_hudFiles
align 4
LABELV cg_hudFiles
skip 272
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
import CG_GetSelectedScore
import CG_SetScoreSelection
import CG_RankRunFrame
import CG_LoadMenus
import CG_Cvar_ClampInt
import CG_AddBoundingBox
import CG_PredictWeaponEffects
import CG_GetFadeTime
export cg_itemFX
align 4
LABELV cg_itemFX
skip 272
export cg_lightningImpact
align 4
LABELV cg_lightningImpact
skip 272
export cg_smokeGrowth_RL
align 4
LABELV cg_smokeGrowth_RL
skip 272
export cg_smokeGrowth_GL
align 4
LABELV cg_smokeGrowth_GL
skip 272
export cg_smokeRadius_RL
align 4
LABELV cg_smokeRadius_RL
skip 272
export cg_smokeRadius_GL
align 4
LABELV cg_smokeRadius_GL
skip 272
export cg_smoke_SG
align 4
LABELV cg_smoke_SG
skip 272
export cg_damageDraw
align 4
LABELV cg_damageDraw
skip 272
export cg_fallKick
align 4
LABELV cg_fallKick
skip 272
export cg_fontFade
align 4
LABELV cg_fontFade
skip 272
export cg_debugModels
align 4
LABELV cg_debugModels
skip 272
export cg_blueName
align 4
LABELV cg_blueName
skip 272
export cg_redName
align 4
LABELV cg_redName
skip 272
export ch_shadowOffset
align 4
LABELV ch_shadowOffset
skip 272
export cg_oldScoreboard
align 4
LABELV cg_oldScoreboard
skip 272
export cg_crosshairPulse
align 4
LABELV cg_crosshairPulse
skip 272
export cg_autoRecord
align 4
LABELV cg_autoRecord
skip 272
export cg_autoScreenshot
align 4
LABELV cg_autoScreenshot
skip 272
export s_ambient
align 4
LABELV s_ambient
skip 272
export s_announcer
align 4
LABELV s_announcer
skip 272
export cg_noteamchatbeep
align 4
LABELV cg_noteamchatbeep
skip 272
export cg_nochatbeep
align 4
LABELV cg_nochatbeep
skip 272
export cg_railHum
align 4
LABELV cg_railHum
skip 272
export cg_fixedTeleporterAngles
align 4
LABELV cg_fixedTeleporterAngles
skip 272
export cg_fastRespawn_override
align 4
LABELV cg_fastRespawn_override
skip 272
export cg_muzzleFlash
align 4
LABELV cg_muzzleFlash
skip 272
export cg_drawDeathMessage
align 4
LABELV cg_drawDeathMessage
skip 272
export cg_aimNudge
align 4
LABELV cg_aimNudge
skip 272
export cg_aimType
align 4
LABELV cg_aimType
skip 272
export cg_fullWeaponCycle
align 4
LABELV cg_fullWeaponCycle
skip 272
export cl_timeNudge
align 4
LABELV cl_timeNudge
skip 272
export sex
align 4
LABELV sex
skip 272
export ch_viewKeyPress
align 4
LABELV ch_viewKeyPress
skip 272
export ch_weaponSideBar
align 4
LABELV ch_weaponSideBar
skip 272
export ch_OBDetector
align 4
LABELV ch_OBDetector
skip 272
export ch_Speedometer
align 4
LABELV ch_Speedometer
skip 272
export ch_file
align 4
LABELV ch_file
skip 272
export language
align 4
LABELV language
skip 272
export cg_motdDisplayTime
align 4
LABELV cg_motdDisplayTime
skip 272
export cg_optimizePrediction
align 4
LABELV cg_optimizePrediction
skip 272
export cg_projectileNudge
align 4
LABELV cg_projectileNudge
skip 272
export sv_fps
align 4
LABELV sv_fps
skip 272
export cg_drawBBox
align 4
LABELV cg_drawBBox
skip 272
export cg_debugDelag
align 4
LABELV cg_debugDelag
skip 272
export cg_delag
align 4
LABELV cg_delag
skip 272
export cl_guid
align 4
LABELV cl_guid
skip 272
export cl_maxpackets
align 4
LABELV cl_maxpackets
skip 272
export snaps
align 4
LABELV snaps
skip 272
export com_maxfps
align 4
LABELV com_maxfps
skip 272
export cl_packetdup
align 4
LABELV cl_packetdup
skip 272
export rate
align 4
LABELV rate
skip 272
export color2
align 4
LABELV color2
skip 272
export color1
align 4
LABELV color1
skip 272
export colors
align 4
LABELV colors
skip 272
export r_vertexLight
align 4
LABELV r_vertexLight
skip 272
export cg_deadBodyDarken
align 4
LABELV cg_deadBodyDarken
skip 272
export cg_adjustTeamColors
align 4
LABELV cg_adjustTeamColors
skip 272
export cg_TeamColors
align 4
LABELV cg_TeamColors
skip 272
export cg_EnemyColors
align 4
LABELV cg_EnemyColors
skip 272
export cg_forceColors
align 4
LABELV cg_forceColors
skip 272
export cg_teamModel
align 4
LABELV cg_teamModel
skip 272
export cg_enemyModel
align 4
LABELV cg_enemyModel
skip 272
import g_allowHandicap
export g_pro_mode
align 4
LABELV g_pro_mode
skip 272
export g_delagHitscan
align 4
LABELV g_delagHitscan
skip 272
export g_gamemode
align 4
LABELV g_gamemode
skip 272
export g_allowReady
align 4
LABELV g_allowReady
skip 272
export g_fastSwitch
align 4
LABELV g_fastSwitch
skip 272
export g_interference
align 4
LABELV g_interference
skip 272
export g_DynamicGauntletCycle
align 4
LABELV g_DynamicGauntletCycle
skip 272
export weap_bfgCycle
align 4
LABELV weap_bfgCycle
skip 272
export weap_plasmagunCycle
align 4
LABELV weap_plasmagunCycle
skip 272
export weap_railgunCycle
align 4
LABELV weap_railgunCycle
skip 272
export weap_rocketlauncherCycle
align 4
LABELV weap_rocketlauncherCycle
skip 272
export weap_lightninggunCycle
align 4
LABELV weap_lightninggunCycle
skip 272
export weap_grenadelauncherCycle
align 4
LABELV weap_grenadelauncherCycle
skip 272
export weap_shotgunCycle
align 4
LABELV weap_shotgunCycle
skip 272
export weap_machinegunCycle
align 4
LABELV weap_machinegunCycle
skip 272
export weap_gauntletCycle
align 4
LABELV weap_gauntletCycle
skip 272
export weap_enableHook
align 4
LABELV weap_enableHook
skip 272
export cg_enableBreath
align 4
LABELV cg_enableBreath
skip 272
export cg_trueLightning
align 4
LABELV cg_trueLightning
skip 272
export cg_oldPlasma
align 4
LABELV cg_oldPlasma
skip 272
export cg_oldRocket
align 4
LABELV cg_oldRocket
skip 272
export cg_railStyle
align 4
LABELV cg_railStyle
skip 272
export cg_noProjectileTrail
align 4
LABELV cg_noProjectileTrail
skip 272
export cg_noTaunt
align 4
LABELV cg_noTaunt
skip 272
export cg_bigFont
align 4
LABELV cg_bigFont
skip 272
export cg_smallFont
align 4
LABELV cg_smallFont
skip 272
export cg_cameraMode
align 4
LABELV cg_cameraMode
skip 272
export cg_timescale
align 4
LABELV cg_timescale
skip 272
export cg_timescaleFadeSpeed
align 4
LABELV cg_timescaleFadeSpeed
skip 272
export cg_timescaleFadeEnd
align 4
LABELV cg_timescaleFadeEnd
skip 272
export cg_cameraOrbitDelay
align 4
LABELV cg_cameraOrbitDelay
skip 272
export cg_cameraOrbit
align 4
LABELV cg_cameraOrbit
skip 272
export cg_pmove_fixed
align 4
LABELV cg_pmove_fixed
skip 272
export sv_lock_pmove
align 4
LABELV sv_lock_pmove
skip 272
export pmove_msec
align 4
LABELV pmove_msec
skip 272
export pmove_fixed
align 4
LABELV pmove_fixed
skip 272
export cg_smoothClients
align 4
LABELV cg_smoothClients
skip 272
export cg_scorePlum
align 4
LABELV cg_scorePlum
skip 272
export cg_noVoiceText
align 4
LABELV cg_noVoiceText
skip 272
export cg_noVoiceChats
align 4
LABELV cg_noVoiceChats
skip 272
export cg_teamChatsOnly
align 4
LABELV cg_teamChatsOnly
skip 272
export cg_drawFriend
align 4
LABELV cg_drawFriend
skip 272
export cg_deferPlayers
align 4
LABELV cg_deferPlayers
skip 272
export cg_predictItems
align 4
LABELV cg_predictItems
skip 272
export cg_blood
align 4
LABELV cg_blood
skip 272
export cg_paused
align 4
LABELV cg_paused
skip 272
export cg_buildScript
align 4
LABELV cg_buildScript
skip 272
export cg_forceModel
align 4
LABELV cg_forceModel
skip 272
export cg_stats
align 4
LABELV cg_stats
skip 272
export cg_teamChatHeight
align 4
LABELV cg_teamChatHeight
skip 272
export cg_teamChatTime
align 4
LABELV cg_teamChatTime
skip 272
export cg_synchronousClients
align 4
LABELV cg_synchronousClients
skip 272
export cg_drawAttacker
align 4
LABELV cg_drawAttacker
skip 272
export cg_lagometer
align 4
LABELV cg_lagometer
skip 272
export cg_stereoSeparation
align 4
LABELV cg_stereoSeparation
skip 272
export cg_thirdPerson
align 4
LABELV cg_thirdPerson
skip 272
export cg_thirdPersonAngle
align 4
LABELV cg_thirdPersonAngle
skip 272
export cg_thirdPersonRange
align 4
LABELV cg_thirdPersonRange
skip 272
export cg_zoomFov
align 4
LABELV cg_zoomFov
skip 272
export cg_fov
align 4
LABELV cg_fov
skip 272
export cg_simpleItems
align 4
LABELV cg_simpleItems
skip 272
export cg_ignore
align 4
LABELV cg_ignore
skip 272
export cg_autoswitch
align 4
LABELV cg_autoswitch
skip 272
export cg_tracerLength
align 4
LABELV cg_tracerLength
skip 272
export cg_tracerWidth
align 4
LABELV cg_tracerWidth
skip 272
export cg_tracerChance
align 4
LABELV cg_tracerChance
skip 272
export cg_viewsize
align 4
LABELV cg_viewsize
skip 272
export cg_drawGun
align 4
LABELV cg_drawGun
skip 272
export cg_gun_z
align 4
LABELV cg_gun_z
skip 272
export cg_gun_y
align 4
LABELV cg_gun_y
skip 272
export cg_gun_x
align 4
LABELV cg_gun_x
skip 272
export cg_gun_frame
align 4
LABELV cg_gun_frame
skip 272
export cg_brassTime
align 4
LABELV cg_brassTime
skip 272
export cg_addMarks
align 4
LABELV cg_addMarks
skip 272
export cg_footsteps
align 4
LABELV cg_footsteps
skip 272
export cg_showmiss
align 4
LABELV cg_showmiss
skip 272
export cg_noPlayerAnims
align 4
LABELV cg_noPlayerAnims
skip 272
export cg_nopredict
align 4
LABELV cg_nopredict
skip 272
export cg_errorDecay
align 4
LABELV cg_errorDecay
skip 272
export cg_railTrailTime
align 4
LABELV cg_railTrailTime
skip 272
export cg_debugEvents
align 4
LABELV cg_debugEvents
skip 272
export cg_debugPosition
align 4
LABELV cg_debugPosition
skip 272
export cg_debugAnim
align 4
LABELV cg_debugAnim
skip 272
export cg_animSpeed
align 4
LABELV cg_animSpeed
skip 272
export cg_draw2D
align 4
LABELV cg_draw2D
skip 272
export cg_drawStatus
align 4
LABELV cg_drawStatus
skip 272
export cg_crosshairHealth
align 4
LABELV cg_crosshairHealth
skip 272
export cg_crosshairColor
align 4
LABELV cg_crosshairColor
skip 272
export cg_crosshairSize
align 4
LABELV cg_crosshairSize
skip 272
export cg_crosshairY
align 4
LABELV cg_crosshairY
skip 272
export cg_crosshairX
align 4
LABELV cg_crosshairX
skip 272
export cg_drawTeamOverlay
align 4
LABELV cg_drawTeamOverlay
skip 272
export cg_drawRewards
align 4
LABELV cg_drawRewards
skip 272
export cg_drawCrosshairNames
align 4
LABELV cg_drawCrosshairNames
skip 272
export cg_drawCrosshair
align 4
LABELV cg_drawCrosshair
skip 272
export cg_drawAmmoWarning
align 4
LABELV cg_drawAmmoWarning
skip 272
export cg_drawIcons
align 4
LABELV cg_drawIcons
skip 272
export cg_draw3dIcons
align 4
LABELV cg_draw3dIcons
skip 272
export cg_drawSnapshot
align 4
LABELV cg_drawSnapshot
skip 272
export cg_drawFPS
align 4
LABELV cg_drawFPS
skip 272
export cg_drawClock
align 4
LABELV cg_drawClock
skip 272
export cg_drawTimer
align 4
LABELV cg_drawTimer
skip 272
export cg_gibs
align 4
LABELV cg_gibs
skip 272
export cg_shadows
align 4
LABELV cg_shadows
skip 272
export cg_swingSpeed
align 4
LABELV cg_swingSpeed
skip 272
export cg_bobroll
align 4
LABELV cg_bobroll
skip 272
export cg_bobpitch
align 4
LABELV cg_bobpitch
skip 272
export cg_bobup
align 4
LABELV cg_bobup
skip 272
export cg_runroll
align 4
LABELV cg_runroll
skip 272
export cg_runpitch
align 4
LABELV cg_runpitch
skip 272
export cg_centertime
align 4
LABELV cg_centertime
skip 272
export chat
align 4
LABELV chat
skip 2080
export autoFile
align 4
LABELV autoFile
skip 1408
export hud
align 4
LABELV hud
skip 66528
import cg_markPolys
export cg_items
align 4
LABELV cg_items
skip 6144
export cg_weapons
align 4
LABELV cg_weapons
skip 2176
export cg_entities
align 4
LABELV cg_entities
skip 745472
export cg
align 4
LABELV cg
skip 170860
export cgs
align 4
LABELV cgs
skip 157876
export lagometer
align 4
LABELV lagometer
skip 1544
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
LABELV $1486
byte 1 77
byte 1 111
byte 1 117
byte 1 115
byte 1 101
byte 1 69
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $1481
byte 1 114
byte 1 101
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 72
byte 1 85
byte 1 68
byte 1 0
align 1
LABELV $1475
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $1474
byte 1 103
byte 1 114
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 99
byte 1 115
byte 1 0
align 1
LABELV $1473
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $1470
byte 1 99
byte 1 111
byte 1 108
byte 1 108
byte 1 105
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $1461
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 47
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 109
byte 1 105
byte 1 115
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1460
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 113
byte 1 51
byte 1 45
byte 1 49
byte 1 0
align 1
LABELV $1437
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 115
byte 1 47
byte 1 105
byte 1 100
byte 1 98
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $1434
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 50
byte 1 95
byte 1 112
byte 1 114
byte 1 111
byte 1 112
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1431
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 49
byte 1 95
byte 1 112
byte 1 114
byte 1 111
byte 1 112
byte 1 95
byte 1 103
byte 1 108
byte 1 111
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1428
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 49
byte 1 95
byte 1 112
byte 1 114
byte 1 111
byte 1 112
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1425
byte 1 119
byte 1 104
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $1422
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 115
byte 1 47
byte 1 114
byte 1 101
byte 1 118
byte 1 111
byte 1 108
byte 1 117
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1419
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 115
byte 1 47
byte 1 111
byte 1 115
byte 1 112
byte 1 0
align 1
LABELV $1416
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 115
byte 1 47
byte 1 116
byte 1 104
byte 1 114
byte 1 101
byte 1 101
byte 1 119
byte 1 97
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $1413
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 115
byte 1 47
byte 1 99
byte 1 112
byte 1 109
byte 1 97
byte 1 0
align 1
LABELV $1410
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 98
byte 1 105
byte 1 103
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $1393
byte 1 67
byte 1 71
byte 1 95
byte 1 67
byte 1 111
byte 1 110
byte 1 102
byte 1 105
byte 1 103
byte 1 83
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 32
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 105
byte 1 110
byte 1 100
byte 1 101
byte 1 120
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1368
byte 1 37
byte 1 115
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $1340
byte 1 42
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1333
byte 1 98
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 77
byte 1 97
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $1330
byte 1 119
byte 1 97
byte 1 107
byte 1 101
byte 1 0
align 1
LABELV $1327
byte 1 109
byte 1 97
byte 1 114
byte 1 107
byte 1 83
byte 1 104
byte 1 97
byte 1 100
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $1324
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 95
byte 1 109
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $1321
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 47
byte 1 104
byte 1 111
byte 1 108
byte 1 101
byte 1 95
byte 1 108
byte 1 103
byte 1 95
byte 1 109
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $1318
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 47
byte 1 98
byte 1 117
byte 1 114
byte 1 110
byte 1 95
byte 1 109
byte 1 101
byte 1 100
byte 1 95
byte 1 109
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $1315
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 47
byte 1 98
byte 1 117
byte 1 108
byte 1 108
byte 1 101
byte 1 116
byte 1 95
byte 1 109
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $1304
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $1301
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 97
byte 1 115
byte 1 115
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $1298
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $1295
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 103
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $1292
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $1289
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 105
byte 1 109
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $1286
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 115
byte 1 104
byte 1 105
byte 1 101
byte 1 108
byte 1 100
byte 1 47
byte 1 115
byte 1 104
byte 1 105
byte 1 101
byte 1 108
byte 1 100
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1283
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 69
byte 1 102
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $1280
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1277
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 116
byte 1 115
byte 1 47
byte 1 98
byte 1 111
byte 1 111
byte 1 109
byte 1 48
byte 1 49
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1274
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 116
byte 1 115
byte 1 47
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 48
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1271
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 116
byte 1 115
byte 1 47
byte 1 98
byte 1 117
byte 1 108
byte 1 108
byte 1 101
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1268
byte 1 98
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 69
byte 1 120
byte 1 112
byte 1 108
byte 1 111
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1265
byte 1 115
byte 1 112
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 115
byte 1 47
byte 1 98
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 111
byte 1 110
byte 1 51
byte 1 0
align 1
LABELV $1260
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 98
byte 1 114
byte 1 97
byte 1 105
byte 1 110
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1257
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 115
byte 1 107
byte 1 117
byte 1 108
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1254
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 108
byte 1 101
byte 1 103
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1251
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 105
byte 1 110
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1248
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 102
byte 1 111
byte 1 114
byte 1 101
byte 1 97
byte 1 114
byte 1 109
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1245
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1242
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 102
byte 1 105
byte 1 115
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1239
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 101
byte 1 115
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1236
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 97
byte 1 114
byte 1 109
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1233
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 97
byte 1 98
byte 1 100
byte 1 111
byte 1 109
byte 1 101
byte 1 110
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1230
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 50
byte 1 47
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 47
byte 1 115
byte 1 95
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1227
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 50
byte 1 47
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 47
byte 1 109
byte 1 95
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1224
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 114
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $1221
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 47
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1218
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 114
byte 1 95
byte 1 121
byte 1 101
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $1215
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 47
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 95
byte 1 121
byte 1 101
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1212
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 98
byte 1 97
byte 1 114
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1209
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $1206
byte 1 115
byte 1 112
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 115
byte 1 47
byte 1 102
byte 1 111
byte 1 101
byte 1 0
align 1
LABELV $1198
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 52
byte 1 0
align 1
LABELV $1194
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 51
byte 1 0
align 1
LABELV $1190
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 50
byte 1 0
align 1
LABELV $1186
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 49
byte 1 0
align 1
LABELV $1183
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 52
byte 1 0
align 1
LABELV $1179
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 51
byte 1 0
align 1
LABELV $1175
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 50
byte 1 0
align 1
LABELV $1171
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 49
byte 1 0
align 1
LABELV $1168
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 52
byte 1 0
align 1
LABELV $1164
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1160
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 50
byte 1 0
align 1
LABELV $1156
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 49
byte 1 0
align 1
LABELV $1153
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 47
byte 1 98
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1150
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 47
byte 1 114
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1142
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 115
byte 1 107
byte 1 117
byte 1 108
byte 1 108
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $1139
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 115
byte 1 107
byte 1 117
byte 1 108
byte 1 108
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $1136
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 111
byte 1 114
byte 1 98
byte 1 47
byte 1 98
byte 1 95
byte 1 111
byte 1 114
byte 1 98
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1133
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 111
byte 1 114
byte 1 98
byte 1 47
byte 1 114
byte 1 95
byte 1 111
byte 1 114
byte 1 98
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1125
byte 1 102
byte 1 114
byte 1 101
byte 1 101
byte 1 122
byte 1 101
byte 1 77
byte 1 97
byte 1 114
byte 1 107
byte 1 83
byte 1 104
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1122
byte 1 102
byte 1 114
byte 1 101
byte 1 101
byte 1 122
byte 1 101
byte 1 83
byte 1 104
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1119
byte 1 104
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 83
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 80
byte 1 117
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $1116
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 114
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $1113
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 105
byte 1 110
byte 1 118
byte 1 105
byte 1 115
byte 1 105
byte 1 98
byte 1 105
byte 1 108
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $1110
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 87
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1107
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 83
byte 1 117
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $1104
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 113
byte 1 117
byte 1 97
byte 1 100
byte 1 87
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1101
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 113
byte 1 117
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $1098
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 110
byte 1 111
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $1095
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 116
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $1092
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 37
byte 1 99
byte 1 0
align 1
LABELV $1085
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $1082
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 116
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1079
byte 1 119
byte 1 97
byte 1 116
byte 1 101
byte 1 114
byte 1 66
byte 1 117
byte 1 98
byte 1 98
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $1076
byte 1 100
byte 1 105
byte 1 115
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $1073
byte 1 108
byte 1 97
byte 1 103
byte 1 111
byte 1 109
byte 1 101
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1070
byte 1 98
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 84
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $1067
byte 1 115
byte 1 112
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 49
byte 1 0
align 1
LABELV $1064
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 83
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 80
byte 1 117
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $1061
byte 1 115
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 80
byte 1 117
byte 1 102
byte 1 102
byte 1 82
byte 1 97
byte 1 103
byte 1 101
byte 1 80
byte 1 114
byte 1 111
byte 1 0
align 1
LABELV $1058
byte 1 115
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 80
byte 1 117
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $1055
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 116
byte 1 97
byte 1 98
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1052
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 116
byte 1 97
byte 1 98
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1049
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 116
byte 1 97
byte 1 98
byte 1 47
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1046
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 116
byte 1 97
byte 1 98
byte 1 47
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1043
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 116
byte 1 97
byte 1 98
byte 1 47
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1040
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 116
byte 1 97
byte 1 98
byte 1 47
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1037
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1034
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 66
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 66
byte 1 108
byte 1 101
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $1031
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 53
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1027
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 52
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1023
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 51
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1019
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 50
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1015
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 49
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1006
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 109
byte 1 101
byte 1 100
byte 1 105
byte 1 97
byte 1 0
align 1
LABELV $1001
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 109
byte 1 105
byte 1 110
byte 1 117
byte 1 115
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $1000
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 110
byte 1 105
byte 1 110
byte 1 101
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $999
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 101
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $998
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 115
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $997
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 115
byte 1 105
byte 1 120
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $996
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 102
byte 1 105
byte 1 118
byte 1 101
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $995
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 102
byte 1 111
byte 1 117
byte 1 114
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $994
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 116
byte 1 104
byte 1 114
byte 1 101
byte 1 101
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $993
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 116
byte 1 119
byte 1 111
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $992
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 111
byte 1 110
byte 1 101
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $991
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 122
byte 1 101
byte 1 114
byte 1 111
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $988
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 47
byte 1 104
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 98
byte 1 50
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $985
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 47
byte 1 104
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 98
byte 1 49
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $982
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 110
byte 1 95
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $979
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 112
byte 1 114
byte 1 111
byte 1 116
byte 1 101
byte 1 99
byte 1 116
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $976
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 114
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $973
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 120
byte 1 49
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $970
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 47
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 108
byte 1 120
byte 1 49
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $967
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 47
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 102
byte 1 49
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $964
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 101
byte 1 103
byte 1 117
byte 1 110
byte 1 47
byte 1 114
byte 1 105
byte 1 99
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $961
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 101
byte 1 103
byte 1 117
byte 1 110
byte 1 47
byte 1 114
byte 1 105
byte 1 99
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $958
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 101
byte 1 103
byte 1 117
byte 1 110
byte 1 47
byte 1 114
byte 1 105
byte 1 99
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $955
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $952
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 117
byte 1 115
byte 1 101
byte 1 95
byte 1 109
byte 1 101
byte 1 100
byte 1 107
byte 1 105
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $949
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $930
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 99
byte 1 108
byte 1 97
byte 1 110
byte 1 107
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $926
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 115
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $922
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 101
byte 1 110
byte 1 101
byte 1 114
byte 1 103
byte 1 121
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $918
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 109
byte 1 101
byte 1 99
byte 1 104
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $914
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 101
byte 1 115
byte 1 104
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $910
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 111
byte 1 111
byte 1 116
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $907
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $902
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
LABELV $899
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 119
byte 1 97
byte 1 116
byte 1 114
byte 1 95
byte 1 117
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $896
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 119
byte 1 97
byte 1 116
byte 1 114
byte 1 95
byte 1 111
byte 1 117
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $893
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 119
byte 1 97
byte 1 116
byte 1 114
byte 1 95
byte 1 105
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $890
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
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $887
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
byte 1 115
byte 1 115
byte 1 105
byte 1 115
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $884
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
byte 1 104
byte 1 105
byte 1 116
byte 1 104
byte 1 105
byte 1 103
byte 1 104
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $880
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
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $876
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
byte 1 104
byte 1 105
byte 1 116
byte 1 108
byte 1 111
byte 1 119
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $872
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
byte 1 104
byte 1 105
byte 1 116
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 115
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $869
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 108
byte 1 97
byte 1 110
byte 1 100
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $866
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 116
byte 1 97
byte 1 108
byte 1 107
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $863
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 110
byte 1 111
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $860
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $857
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
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 111
byte 1 117
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $854
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
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 105
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $851
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 105
byte 1 109
byte 1 112
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $848
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 105
byte 1 109
byte 1 112
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $845
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 105
byte 1 109
byte 1 112
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $842
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 112
byte 1 108
byte 1 116
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $839
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 117
byte 1 115
byte 1 101
byte 1 95
byte 1 110
byte 1 111
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $836
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 114
byte 1 111
byte 1 102
byte 1 102
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $833
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $830
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 101
byte 1 103
byte 1 117
byte 1 110
byte 1 47
byte 1 98
byte 1 117
byte 1 108
byte 1 101
byte 1 116
byte 1 98
byte 1 121
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $827
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 109
byte 1 101
byte 1 108
byte 1 101
byte 1 101
byte 1 47
byte 1 102
byte 1 115
byte 1 116
byte 1 114
byte 1 117
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $824
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 95
byte 1 49
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $821
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 49
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $816
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
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 104
byte 1 111
byte 1 108
byte 1 121
byte 1 115
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $813
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 121
byte 1 111
byte 1 117
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $810
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $807
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $804
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 95
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $801
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 95
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $793
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 116
byte 1 107
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $790
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 116
byte 1 97
byte 1 107
byte 1 101
byte 1 110
byte 1 95
byte 1 111
byte 1 112
byte 1 112
byte 1 111
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $787
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 116
byte 1 97
byte 1 107
byte 1 101
byte 1 110
byte 1 95
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $784
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 95
byte 1 111
byte 1 112
byte 1 112
byte 1 111
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $781
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 95
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $778
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 95
byte 1 111
byte 1 112
byte 1 112
byte 1 111
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $773
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $770
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $767
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
byte 1 104
byte 1 105
byte 1 116
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 109
byte 1 97
byte 1 116
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $764
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 95
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $755
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $749
byte 1 80
byte 1 114
byte 1 101
byte 1 99
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 112
byte 1 114
byte 1 101
byte 1 99
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 32
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $728
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $696
byte 1 94
byte 1 51
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 58
byte 1 32
byte 1 99
byte 1 103
byte 1 95
byte 1 69
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 67
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 115
byte 1 32
byte 1 109
byte 1 117
byte 1 115
byte 1 116
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 105
byte 1 109
byte 1 117
byte 1 109
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 50
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 115
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 109
byte 1 97
byte 1 120
byte 1 105
byte 1 109
byte 1 117
byte 1 109
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 53
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 115
byte 1 10
byte 1 94
byte 1 51
byte 1 82
byte 1 101
byte 1 115
byte 1 101
byte 1 116
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $683
byte 1 94
byte 1 51
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 58
byte 1 32
byte 1 99
byte 1 103
byte 1 95
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 67
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 115
byte 1 32
byte 1 109
byte 1 117
byte 1 115
byte 1 116
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 105
byte 1 109
byte 1 117
byte 1 109
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 50
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 115
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 109
byte 1 97
byte 1 120
byte 1 105
byte 1 109
byte 1 117
byte 1 109
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 53
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 115
byte 1 10
byte 1 94
byte 1 51
byte 1 82
byte 1 101
byte 1 115
byte 1 101
byte 1 116
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $670
byte 1 67
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $669
byte 1 94
byte 1 51
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 58
byte 1 32
byte 1 67
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 115
byte 1 32
byte 1 109
byte 1 117
byte 1 115
byte 1 116
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 53
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 115
byte 1 10
byte 1 94
byte 1 51
byte 1 82
byte 1 101
byte 1 115
byte 1 101
byte 1 116
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $638
byte 1 115
byte 1 118
byte 1 95
byte 1 99
byte 1 104
byte 1 101
byte 1 97
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $630
byte 1 94
byte 1 55
byte 1 87
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 32
byte 1 99
byte 1 103
byte 1 95
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 72
byte 1 117
byte 1 109
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $610
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
byte 1 108
byte 1 111
byte 1 115
byte 1 116
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $602
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 108
byte 1 111
byte 1 115
byte 1 116
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $590
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 116
byte 1 105
byte 1 101
byte 1 100
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $585
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
byte 1 116
byte 1 97
byte 1 107
byte 1 101
byte 1 110
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $577
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 116
byte 1 97
byte 1 107
byte 1 101
byte 1 110
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $572
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
byte 1 104
byte 1 117
byte 1 109
byte 1 105
byte 1 108
byte 1 105
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $564
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 104
byte 1 117
byte 1 109
byte 1 105
byte 1 108
byte 1 105
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $559
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
byte 1 100
byte 1 101
byte 1 110
byte 1 105
byte 1 101
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $551
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 100
byte 1 101
byte 1 110
byte 1 105
byte 1 101
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $546
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
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $538
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $533
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
byte 1 105
byte 1 109
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 118
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $525
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 105
byte 1 109
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 118
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $520
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
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 115
byte 1 116
byte 1 105
byte 1 101
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $512
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 115
byte 1 116
byte 1 105
byte 1 101
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $507
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
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $499
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $494
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
byte 1 114
byte 1 101
byte 1 100
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $486
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 114
byte 1 101
byte 1 100
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $481
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
byte 1 112
byte 1 114
byte 1 101
byte 1 112
byte 1 97
byte 1 114
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $473
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 112
byte 1 114
byte 1 101
byte 1 112
byte 1 97
byte 1 114
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $468
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
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $460
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $455
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
byte 1 111
byte 1 110
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $447
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 111
byte 1 110
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $442
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
byte 1 116
byte 1 119
byte 1 111
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $434
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 116
byte 1 119
byte 1 111
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $429
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
byte 1 116
byte 1 104
byte 1 114
byte 1 101
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $421
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 116
byte 1 104
byte 1 114
byte 1 101
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $416
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
byte 1 51
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $408
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 51
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $403
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
byte 1 50
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $395
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 50
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $390
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
byte 1 49
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $382
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 49
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $377
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
byte 1 115
byte 1 117
byte 1 100
byte 1 100
byte 1 101
byte 1 110
byte 1 95
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $369
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 115
byte 1 117
byte 1 100
byte 1 100
byte 1 101
byte 1 110
byte 1 95
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $364
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
byte 1 53
byte 1 95
byte 1 109
byte 1 105
byte 1 110
byte 1 117
byte 1 116
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $356
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 53
byte 1 95
byte 1 109
byte 1 105
byte 1 110
byte 1 117
byte 1 116
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $351
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
byte 1 49
byte 1 95
byte 1 109
byte 1 105
byte 1 110
byte 1 117
byte 1 116
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $343
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 49
byte 1 95
byte 1 109
byte 1 105
byte 1 110
byte 1 117
byte 1 116
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $323
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $322
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $321
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $320
byte 1 115
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $319
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $314
byte 1 115
byte 1 118
byte 1 95
byte 1 114
byte 1 117
byte 1 110
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $308
byte 1 99
byte 1 103
byte 1 95
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 70
byte 1 88
byte 1 0
align 1
LABELV $307
byte 1 99
byte 1 103
byte 1 95
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 73
byte 1 109
byte 1 112
byte 1 97
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $306
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 71
byte 1 114
byte 1 111
byte 1 119
byte 1 116
byte 1 104
byte 1 95
byte 1 82
byte 1 76
byte 1 0
align 1
LABELV $305
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 71
byte 1 114
byte 1 111
byte 1 119
byte 1 116
byte 1 104
byte 1 95
byte 1 71
byte 1 76
byte 1 0
align 1
LABELV $304
byte 1 54
byte 1 52
byte 1 0
align 1
LABELV $303
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 82
byte 1 97
byte 1 100
byte 1 105
byte 1 117
byte 1 115
byte 1 95
byte 1 82
byte 1 76
byte 1 0
align 1
LABELV $302
byte 1 51
byte 1 50
byte 1 0
align 1
LABELV $301
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 82
byte 1 97
byte 1 100
byte 1 105
byte 1 117
byte 1 115
byte 1 95
byte 1 71
byte 1 76
byte 1 0
align 1
LABELV $300
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 95
byte 1 83
byte 1 71
byte 1 0
align 1
LABELV $299
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 68
byte 1 114
byte 1 97
byte 1 119
byte 1 0
align 1
LABELV $298
byte 1 99
byte 1 103
byte 1 95
byte 1 102
byte 1 97
byte 1 108
byte 1 108
byte 1 75
byte 1 105
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $297
byte 1 99
byte 1 103
byte 1 95
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 70
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $296
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 0
align 1
LABELV $295
byte 1 80
byte 1 97
byte 1 103
byte 1 97
byte 1 110
byte 1 122
byte 1 0
align 1
LABELV $294
byte 1 103
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $293
byte 1 90
byte 1 116
byte 1 114
byte 1 111
byte 1 103
byte 1 103
byte 1 122
byte 1 0
align 1
LABELV $292
byte 1 103
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $291
byte 1 99
byte 1 104
byte 1 95
byte 1 115
byte 1 104
byte 1 97
byte 1 100
byte 1 111
byte 1 119
byte 1 79
byte 1 102
byte 1 102
byte 1 115
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $290
byte 1 99
byte 1 103
byte 1 95
byte 1 111
byte 1 108
byte 1 100
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 98
byte 1 111
byte 1 97
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $289
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 80
byte 1 117
byte 1 108
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $288
byte 1 99
byte 1 104
byte 1 95
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $287
byte 1 49
byte 1 48
byte 1 0
align 1
LABELV $286
byte 1 99
byte 1 103
byte 1 95
byte 1 109
byte 1 111
byte 1 116
byte 1 100
byte 1 68
byte 1 105
byte 1 115
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $285
byte 1 99
byte 1 103
byte 1 95
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 82
byte 1 101
byte 1 99
byte 1 111
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $284
byte 1 99
byte 1 103
byte 1 95
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 83
byte 1 99
byte 1 114
byte 1 101
byte 1 101
byte 1 110
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $283
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $282
byte 1 108
byte 1 97
byte 1 110
byte 1 103
byte 1 117
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $281
byte 1 99
byte 1 103
byte 1 95
byte 1 97
byte 1 100
byte 1 106
byte 1 117
byte 1 115
byte 1 116
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 67
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $280
byte 1 99
byte 1 103
byte 1 95
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 72
byte 1 117
byte 1 109
byte 1 0
align 1
LABELV $279
byte 1 99
byte 1 103
byte 1 95
byte 1 102
byte 1 105
byte 1 120
byte 1 101
byte 1 100
byte 1 84
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 101
byte 1 114
byte 1 65
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $278
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $277
byte 1 115
byte 1 95
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 117
byte 1 110
byte 1 99
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $276
byte 1 99
byte 1 108
byte 1 95
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 100
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $275
byte 1 114
byte 1 95
byte 1 118
byte 1 101
byte 1 114
byte 1 116
byte 1 101
byte 1 120
byte 1 76
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $274
byte 1 103
byte 1 95
byte 1 102
byte 1 97
byte 1 115
byte 1 116
byte 1 83
byte 1 119
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $273
byte 1 99
byte 1 103
byte 1 95
byte 1 112
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 95
byte 1 102
byte 1 105
byte 1 120
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $272
byte 1 48
byte 1 32
byte 1 51
byte 1 48
byte 1 48
byte 1 32
byte 1 50
byte 1 48
byte 1 48
byte 1 32
byte 1 48
byte 1 32
byte 1 55
byte 1 32
byte 1 57
byte 1 0
align 1
LABELV $271
byte 1 99
byte 1 104
byte 1 95
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 75
byte 1 101
byte 1 121
byte 1 80
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $270
byte 1 48
byte 1 32
byte 1 57
byte 1 32
byte 1 55
byte 1 32
byte 1 52
byte 1 32
byte 1 55
byte 1 0
align 1
LABELV $269
byte 1 99
byte 1 104
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 83
byte 1 105
byte 1 100
byte 1 101
byte 1 66
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $268
byte 1 48
byte 1 32
byte 1 50
byte 1 53
byte 1 48
byte 1 32
byte 1 50
byte 1 50
byte 1 48
byte 1 32
byte 1 49
byte 1 0
align 1
LABELV $267
byte 1 99
byte 1 104
byte 1 95
byte 1 79
byte 1 66
byte 1 68
byte 1 101
byte 1 116
byte 1 101
byte 1 99
byte 1 116
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $266
byte 1 48
byte 1 32
byte 1 48
byte 1 32
byte 1 50
byte 1 48
byte 1 48
byte 1 32
byte 1 51
byte 1 53
byte 1 48
byte 1 32
byte 1 49
byte 1 0
align 1
LABELV $265
byte 1 99
byte 1 104
byte 1 95
byte 1 83
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 111
byte 1 109
byte 1 101
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $264
byte 1 99
byte 1 108
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 78
byte 1 117
byte 1 100
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $263
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 68
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 77
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $262
byte 1 99
byte 1 103
byte 1 95
byte 1 102
byte 1 117
byte 1 108
byte 1 108
byte 1 87
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 67
byte 1 121
byte 1 99
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $261
byte 1 99
byte 1 103
byte 1 95
byte 1 109
byte 1 117
byte 1 122
byte 1 122
byte 1 108
byte 1 101
byte 1 70
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $260
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 98
byte 1 101
byte 1 101
byte 1 112
byte 1 0
align 1
LABELV $259
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 98
byte 1 101
byte 1 101
byte 1 112
byte 1 0
align 1
LABELV $258
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 97
byte 1 100
byte 1 66
byte 1 111
byte 1 100
byte 1 121
byte 1 68
byte 1 97
byte 1 114
byte 1 107
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $257
byte 1 55
byte 1 55
byte 1 55
byte 1 55
byte 1 55
byte 1 0
align 1
LABELV $256
byte 1 99
byte 1 103
byte 1 95
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 67
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $255
byte 1 50
byte 1 50
byte 1 50
byte 1 50
byte 1 50
byte 1 0
align 1
LABELV $254
byte 1 99
byte 1 103
byte 1 95
byte 1 69
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 67
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $253
byte 1 99
byte 1 103
byte 1 95
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 67
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $252
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $251
byte 1 99
byte 1 103
byte 1 95
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $250
byte 1 103
byte 1 95
byte 1 112
byte 1 114
byte 1 111
byte 1 95
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $249
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 103
byte 1 72
byte 1 105
byte 1 116
byte 1 115
byte 1 99
byte 1 97
byte 1 110
byte 1 0
align 1
LABELV $248
byte 1 103
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $247
byte 1 103
byte 1 95
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 102
byte 1 101
byte 1 114
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $246
byte 1 103
byte 1 95
byte 1 68
byte 1 121
byte 1 110
byte 1 97
byte 1 109
byte 1 105
byte 1 99
byte 1 71
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 67
byte 1 121
byte 1 99
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $245
byte 1 50
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $244
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 95
byte 1 98
byte 1 102
byte 1 103
byte 1 67
byte 1 121
byte 1 99
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $243
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 103
byte 1 117
byte 1 110
byte 1 67
byte 1 121
byte 1 99
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $242
byte 1 49
byte 1 53
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $241
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 95
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 67
byte 1 121
byte 1 99
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $240
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 95
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 108
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 67
byte 1 121
byte 1 99
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $239
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 95
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 103
byte 1 117
byte 1 110
byte 1 67
byte 1 121
byte 1 99
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $238
byte 1 56
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $237
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 95
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 117
byte 1 110
byte 1 99
byte 1 104
byte 1 101
byte 1 114
byte 1 67
byte 1 121
byte 1 99
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $236
byte 1 49
byte 1 48
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $235
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 95
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 67
byte 1 121
byte 1 99
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $234
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 95
byte 1 109
byte 1 97
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 101
byte 1 103
byte 1 117
byte 1 110
byte 1 67
byte 1 121
byte 1 99
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $233
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 95
byte 1 103
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 67
byte 1 121
byte 1 99
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $232
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 95
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 72
byte 1 111
byte 1 111
byte 1 107
byte 1 0
align 1
LABELV $231
byte 1 99
byte 1 103
byte 1 95
byte 1 102
byte 1 97
byte 1 115
byte 1 116
byte 1 82
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 95
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 114
byte 1 105
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $230
byte 1 99
byte 1 103
byte 1 95
byte 1 111
byte 1 112
byte 1 116
byte 1 105
byte 1 109
byte 1 105
byte 1 122
byte 1 101
byte 1 80
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $229
byte 1 99
byte 1 103
byte 1 95
byte 1 112
byte 1 114
byte 1 111
byte 1 106
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 108
byte 1 101
byte 1 78
byte 1 117
byte 1 100
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $228
byte 1 115
byte 1 118
byte 1 95
byte 1 102
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $227
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 66
byte 1 66
byte 1 111
byte 1 120
byte 1 0
align 1
LABELV $226
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 68
byte 1 101
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $225
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $224
byte 1 48
byte 1 46
byte 1 48
byte 1 0
align 1
LABELV $223
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 114
byte 1 117
byte 1 101
byte 1 76
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $222
byte 1 99
byte 1 103
byte 1 95
byte 1 111
byte 1 108
byte 1 100
byte 1 80
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 0
align 1
LABELV $221
byte 1 99
byte 1 103
byte 1 95
byte 1 111
byte 1 108
byte 1 100
byte 1 82
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $220
byte 1 99
byte 1 103
byte 1 95
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 83
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $219
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 105
byte 1 103
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $218
byte 1 48
byte 1 46
byte 1 50
byte 1 53
byte 1 0
align 1
LABELV $217
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 109
byte 1 97
byte 1 108
byte 1 108
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $216
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 80
byte 1 114
byte 1 111
byte 1 106
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 108
byte 1 101
byte 1 84
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $215
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 84
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $214
byte 1 115
byte 1 118
byte 1 95
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 95
byte 1 112
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $213
byte 1 56
byte 1 0
align 1
LABELV $212
byte 1 112
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 95
byte 1 109
byte 1 115
byte 1 101
byte 1 99
byte 1 0
align 1
LABELV $211
byte 1 112
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 95
byte 1 102
byte 1 105
byte 1 120
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $210
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 99
byte 1 97
byte 1 109
byte 1 101
byte 1 114
byte 1 97
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $209
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 109
byte 1 111
byte 1 111
byte 1 116
byte 1 104
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $208
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 80
byte 1 108
byte 1 117
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $207
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
LABELV $206
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 115
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 70
byte 1 97
byte 1 100
byte 1 101
byte 1 83
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $205
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 115
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 70
byte 1 97
byte 1 100
byte 1 101
byte 1 69
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $204
byte 1 53
byte 1 48
byte 1 0
align 1
LABELV $203
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 97
byte 1 109
byte 1 101
byte 1 114
byte 1 97
byte 1 79
byte 1 114
byte 1 98
byte 1 105
byte 1 116
byte 1 68
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $202
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 97
byte 1 109
byte 1 101
byte 1 114
byte 1 97
byte 1 79
byte 1 114
byte 1 98
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $201
byte 1 99
byte 1 103
byte 1 95
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 66
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $200
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
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $199
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 98
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 0
align 1
LABELV $198
byte 1 99
byte 1 108
byte 1 95
byte 1 112
byte 1 97
byte 1 117
byte 1 115
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $197
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 83
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 0
align 1
LABELV $196
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 86
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 84
byte 1 101
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $195
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 86
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 67
byte 1 104
byte 1 97
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $194
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 67
byte 1 104
byte 1 97
byte 1 116
byte 1 115
byte 1 79
byte 1 110
byte 1 108
byte 1 121
byte 1 0
align 1
LABELV $193
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 70
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $192
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $191
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 79
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $190
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $189
byte 1 99
byte 1 103
byte 1 95
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $188
byte 1 99
byte 1 103
byte 1 95
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $187
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 67
byte 1 104
byte 1 97
byte 1 116
byte 1 72
byte 1 101
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $186
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 67
byte 1 104
byte 1 97
byte 1 116
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $185
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 104
byte 1 105
byte 1 114
byte 1 100
byte 1 80
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $184
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 104
byte 1 105
byte 1 114
byte 1 100
byte 1 80
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 65
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $183
byte 1 52
byte 1 48
byte 1 0
align 1
LABELV $182
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 104
byte 1 105
byte 1 114
byte 1 100
byte 1 80
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 82
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $181
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 114
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $180
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 114
byte 1 119
byte 1 105
byte 1 100
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $179
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 114
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $178
byte 1 99
byte 1 103
byte 1 95
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $177
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 104
byte 1 111
byte 1 119
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $176
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $175
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $174
byte 1 99
byte 1 103
byte 1 95
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 100
byte 1 101
byte 1 99
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $173
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $172
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 112
byte 1 111
byte 1 115
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $171
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 0
align 1
LABELV $170
byte 1 99
byte 1 103
byte 1 95
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $169
byte 1 48
byte 1 46
byte 1 51
byte 1 0
align 1
LABELV $168
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 119
byte 1 105
byte 1 110
byte 1 103
byte 1 83
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $167
byte 1 99
byte 1 103
byte 1 95
byte 1 98
byte 1 111
byte 1 98
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $166
byte 1 99
byte 1 103
byte 1 95
byte 1 98
byte 1 111
byte 1 98
byte 1 112
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $165
byte 1 99
byte 1 103
byte 1 95
byte 1 98
byte 1 111
byte 1 98
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $164
byte 1 48
byte 1 46
byte 1 48
byte 1 48
byte 1 53
byte 1 0
align 1
LABELV $163
byte 1 99
byte 1 103
byte 1 95
byte 1 114
byte 1 117
byte 1 110
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $162
byte 1 48
byte 1 46
byte 1 48
byte 1 48
byte 1 50
byte 1 0
align 1
LABELV $161
byte 1 99
byte 1 103
byte 1 95
byte 1 114
byte 1 117
byte 1 110
byte 1 112
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $160
byte 1 51
byte 1 0
align 1
LABELV $159
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $158
byte 1 99
byte 1 103
byte 1 95
byte 1 103
byte 1 117
byte 1 110
byte 1 90
byte 1 0
align 1
LABELV $157
byte 1 99
byte 1 103
byte 1 95
byte 1 103
byte 1 117
byte 1 110
byte 1 89
byte 1 0
align 1
LABELV $156
byte 1 99
byte 1 103
byte 1 95
byte 1 103
byte 1 117
byte 1 110
byte 1 88
byte 1 0
align 1
LABELV $155
byte 1 52
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $154
byte 1 99
byte 1 103
byte 1 95
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 84
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $153
byte 1 99
byte 1 103
byte 1 95
byte 1 108
byte 1 97
byte 1 103
byte 1 111
byte 1 109
byte 1 101
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $152
byte 1 99
byte 1 103
byte 1 95
byte 1 109
byte 1 97
byte 1 114
byte 1 107
byte 1 115
byte 1 0
align 1
LABELV $151
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 105
byte 1 109
byte 1 112
byte 1 108
byte 1 101
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $150
byte 1 50
byte 1 53
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $149
byte 1 99
byte 1 103
byte 1 95
byte 1 98
byte 1 114
byte 1 97
byte 1 115
byte 1 115
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $148
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 89
byte 1 0
align 1
LABELV $147
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 88
byte 1 0
align 1
LABELV $146
byte 1 55
byte 1 0
align 1
LABELV $145
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 67
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $144
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $143
byte 1 50
byte 1 52
byte 1 0
align 1
LABELV $142
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 83
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $141
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 82
byte 1 101
byte 1 119
byte 1 97
byte 1 114
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $140
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 67
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $139
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 67
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 0
align 1
LABELV $138
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 65
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $137
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 65
byte 1 109
byte 1 109
byte 1 111
byte 1 87
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $136
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 73
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $135
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 51
byte 1 100
byte 1 73
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $134
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 83
byte 1 110
byte 1 97
byte 1 112
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $133
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 70
byte 1 80
byte 1 83
byte 1 0
align 1
LABELV $132
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 67
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $131
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $130
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $129
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 50
byte 1 68
byte 1 0
align 1
LABELV $128
byte 1 99
byte 1 103
byte 1 95
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 0
align 1
LABELV $127
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 104
byte 1 97
byte 1 100
byte 1 111
byte 1 119
byte 1 115
byte 1 0
align 1
LABELV $126
byte 1 48
byte 1 46
byte 1 52
byte 1 0
align 1
LABELV $125
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 101
byte 1 111
byte 1 83
byte 1 101
byte 1 112
byte 1 97
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $124
byte 1 49
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $123
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
LABELV $122
byte 1 57
byte 1 48
byte 1 0
align 1
LABELV $121
byte 1 99
byte 1 103
byte 1 95
byte 1 102
byte 1 111
byte 1 118
byte 1 0
align 1
LABELV $120
byte 1 50
byte 1 50
byte 1 46
byte 1 53
byte 1 0
align 1
LABELV $119
byte 1 99
byte 1 103
byte 1 95
byte 1 122
byte 1 111
byte 1 111
byte 1 109
byte 1 102
byte 1 111
byte 1 118
byte 1 0
align 1
LABELV $118
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 71
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $117
byte 1 99
byte 1 103
byte 1 95
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 115
byte 1 119
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $116
byte 1 99
byte 1 103
byte 1 95
byte 1 105
byte 1 103
byte 1 110
byte 1 111
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $115
byte 1 115
byte 1 95
byte 1 97
byte 1 109
byte 1 98
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $114
byte 1 49
byte 1 0
align 1
LABELV $113
byte 1 103
byte 1 95
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 82
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 0
align 1
LABELV $112
byte 1 99
byte 1 108
byte 1 95
byte 1 103
byte 1 117
byte 1 105
byte 1 100
byte 1 0
align 1
LABELV $111
byte 1 51
byte 1 48
byte 1 0
align 1
LABELV $110
byte 1 99
byte 1 108
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $109
byte 1 50
byte 1 48
byte 1 0
align 1
LABELV $108
byte 1 115
byte 1 110
byte 1 97
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $107
byte 1 48
byte 1 0
align 1
LABELV $106
byte 1 99
byte 1 103
byte 1 95
byte 1 97
byte 1 105
byte 1 109
byte 1 78
byte 1 117
byte 1 100
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $105
byte 1 50
byte 1 0
align 1
LABELV $104
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
LABELV $103
byte 1 51
byte 1 48
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $102
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $101
byte 1 56
byte 1 53
byte 1 0
align 1
LABELV $100
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 102
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $99
byte 1 53
byte 1 0
align 1
LABELV $98
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 50
byte 1 0
align 1
LABELV $97
byte 1 52
byte 1 0
align 1
LABELV $96
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 49
byte 1 0
align 1
LABELV $95
byte 1 49
byte 1 55
byte 1 55
byte 1 55
byte 1 54
byte 1 0
align 1
LABELV $94
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $93
byte 1 0
align 1
LABELV $92
byte 1 115
byte 1 101
byte 1 120
byte 1 0
align 1
LABELV $89
byte 1 118
byte 1 109
byte 1 77
byte 1 97
byte 1 105
byte 1 110
byte 1 58
byte 1 32
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 105
byte 1 0
