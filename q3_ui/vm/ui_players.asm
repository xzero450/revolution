code
proc UI_PlayerInfo_SetWeapon 84 8
file "../ui_players.c"
line 33
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// ui_players.c
;4:
;5:#include "ui_local.h"
;6:
;7:
;8:#define UI_TIMER_GESTURE		2300
;9:#define UI_TIMER_JUMP			1000
;10:#define UI_TIMER_LAND			130
;11:#define UI_TIMER_WEAPON_SWITCH	300
;12:#define UI_TIMER_ATTACK			500
;13:#define	UI_TIMER_MUZZLE_FLASH	20
;14:#define	UI_TIMER_WEAPON_DELAY	250
;15:
;16:#define JUMP_HEIGHT				56
;17:
;18:#define SWINGSPEED				0.3f
;19:
;20:#define SPIN_SPEED				0.9f
;21:#define COAST_TIME				1000
;22:
;23:
;24:static int			dp_realtime;
;25:static float		jumpHeight;
;26:
;27:
;28:/*
;29:===============
;30:UI_PlayerInfo_SetWeapon
;31:===============
;32:*/
;33:static void UI_PlayerInfo_SetWeapon( playerInfo_t *pi, weapon_t weaponNum ) {
line 37
;34:	gitem_t *	item;
;35:	char		path[MAX_QPATH];
;36:
;37:	pi->currentWeapon = weaponNum;
ADDRFP4 0
INDIRP4
CNSTI4 1040
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
LABELV $69
line 39
;38:tryagain:
;39:	pi->realWeapon = weaponNum;
ADDRFP4 0
INDIRP4
CNSTI4 1104
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 40
;40:	pi->weaponModel = 0;
ADDRFP4 0
INDIRP4
CNSTI4 988
ADDP4
CNSTI4 0
ASGNI4
line 41
;41:	pi->barrelModel = 0;
ADDRFP4 0
INDIRP4
CNSTI4 992
ADDP4
CNSTI4 0
ASGNI4
line 42
;42:	pi->flashModel = 0;
ADDRFP4 0
INDIRP4
CNSTI4 996
ADDP4
CNSTI4 0
ASGNI4
line 44
;43:
;44:	if ( weaponNum == WP_NONE ) {
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $70
line 45
;45:		return;
ADDRGP4 $68
JUMPV
LABELV $70
line 48
;46:	}
;47:
;48:	for ( item = bg_itemlist + 1; item->classname ; item++ ) {
ADDRLP4 0
ADDRGP4 bg_itemlist+52
ASGNP4
ADDRGP4 $75
JUMPV
LABELV $72
line 49
;49:		if ( item->giType != IT_WEAPON ) {
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 1
EQI4 $77
line 50
;50:			continue;
ADDRGP4 $73
JUMPV
LABELV $77
line 52
;51:		}
;52:		if ( item->giTag == weaponNum ) {
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $79
line 53
;53:			break;
ADDRGP4 $74
JUMPV
LABELV $79
line 55
;54:		}
;55:	}
LABELV $73
line 48
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ASGNP4
LABELV $75
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $72
LABELV $74
line 57
;56:
;57:	if ( item->classname ) {
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $81
line 58
;58:		pi->weaponModel = trap_R_RegisterModel( item->world_model[0] );
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 988
ADDP4
ADDRLP4 68
INDIRI4
ASGNI4
line 59
;59:	}
LABELV $81
line 61
;60:
;61:	if( pi->weaponModel == 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 988
ADDP4
INDIRI4
CNSTI4 0
NEI4 $83
line 62
;62:		if( weaponNum == WP_MACHINEGUN ) {
ADDRFP4 4
INDIRI4
CNSTI4 2
NEI4 $85
line 63
;63:			weaponNum = WP_NONE;
ADDRFP4 4
CNSTI4 0
ASGNI4
line 64
;64:			goto tryagain;
ADDRGP4 $69
JUMPV
LABELV $85
line 66
;65:		}
;66:		weaponNum = WP_MACHINEGUN;
ADDRFP4 4
CNSTI4 2
ASGNI4
line 67
;67:		goto tryagain;
ADDRGP4 $69
JUMPV
LABELV $83
line 70
;68:	}
;69:
;70:	if ( weaponNum == WP_MACHINEGUN || weaponNum == WP_GAUNTLET || weaponNum == WP_BFG ) {
ADDRLP4 68
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 2
EQI4 $90
ADDRLP4 68
INDIRI4
CNSTI4 1
EQI4 $90
ADDRLP4 68
INDIRI4
CNSTI4 9
NEI4 $87
LABELV $90
line 71
;71:		strcpy( path, item->world_model[0] );
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 72
;72:		COM_StripExtension( path, path );
ADDRLP4 4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 COM_StripExtension
CALLV
pop
line 73
;73:		strcat( path, "_barrel.md3" );
ADDRLP4 4
ARGP4
ADDRGP4 $91
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 74
;74:		pi->barrelModel = trap_R_RegisterModel( path );
ADDRLP4 4
ARGP4
ADDRLP4 72
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 992
ADDP4
ADDRLP4 72
INDIRI4
ASGNI4
line 75
;75:	}
LABELV $87
line 77
;76:
;77:	strcpy( path, item->world_model[0] );
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 78
;78:	COM_StripExtension( path, path );
ADDRLP4 4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 COM_StripExtension
CALLV
pop
line 79
;79:	strcat( path, "_flash.md3" );
ADDRLP4 4
ARGP4
ADDRGP4 $92
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 80
;80:	pi->flashModel = trap_R_RegisterModel( path );
ADDRLP4 4
ARGP4
ADDRLP4 72
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 996
ADDP4
ADDRLP4 72
INDIRI4
ASGNI4
line 82
;81:
;82:	switch( weaponNum ) {
ADDRLP4 76
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 1
LTI4 $93
ADDRLP4 76
INDIRI4
CNSTI4 10
GTI4 $93
ADDRLP4 76
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $106-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $106
address $96
address $97
address $98
address $99
address $100
address $101
address $102
address $103
address $104
address $105
code
LABELV $96
line 84
;83:	case WP_GAUNTLET:
;84:		MAKERGB( pi->flashDlightColor, 0.6f, 0.6f, 1 );
ADDRFP4 0
INDIRP4
CNSTI4 1000
ADDP4
CNSTF4 1058642330
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1004
ADDP4
CNSTF4 1058642330
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1008
ADDP4
CNSTF4 1065353216
ASGNF4
line 85
;85:		break;
ADDRGP4 $94
JUMPV
LABELV $97
line 88
;86:
;87:	case WP_MACHINEGUN:
;88:		MAKERGB( pi->flashDlightColor, 1, 1, 0 );
ADDRFP4 0
INDIRP4
CNSTI4 1000
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1004
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1008
ADDP4
CNSTF4 0
ASGNF4
line 89
;89:		break;
ADDRGP4 $94
JUMPV
LABELV $98
line 92
;90:
;91:	case WP_SHOTGUN:
;92:		MAKERGB( pi->flashDlightColor, 1, 1, 0 );
ADDRFP4 0
INDIRP4
CNSTI4 1000
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1004
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1008
ADDP4
CNSTF4 0
ASGNF4
line 93
;93:		break;
ADDRGP4 $94
JUMPV
LABELV $99
line 96
;94:
;95:	case WP_GRENADE_LAUNCHER:
;96:		MAKERGB( pi->flashDlightColor, 1, 0.7f, 0.5f );
ADDRFP4 0
INDIRP4
CNSTI4 1000
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1004
ADDP4
CNSTF4 1060320051
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1008
ADDP4
CNSTF4 1056964608
ASGNF4
line 97
;97:		break;
ADDRGP4 $94
JUMPV
LABELV $100
line 100
;98:
;99:	case WP_ROCKET_LAUNCHER:
;100:		MAKERGB( pi->flashDlightColor, 1, 0.75f, 0 );
ADDRFP4 0
INDIRP4
CNSTI4 1000
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1004
ADDP4
CNSTF4 1061158912
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1008
ADDP4
CNSTF4 0
ASGNF4
line 101
;101:		break;
ADDRGP4 $94
JUMPV
LABELV $101
line 104
;102:
;103:	case WP_LIGHTNING:
;104:		MAKERGB( pi->flashDlightColor, 0.6f, 0.6f, 1 );
ADDRFP4 0
INDIRP4
CNSTI4 1000
ADDP4
CNSTF4 1058642330
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1004
ADDP4
CNSTF4 1058642330
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1008
ADDP4
CNSTF4 1065353216
ASGNF4
line 105
;105:		break;
ADDRGP4 $94
JUMPV
LABELV $102
line 108
;106:
;107:	case WP_RAILGUN:
;108:		MAKERGB( pi->flashDlightColor, 1, 0.5f, 0 );
ADDRFP4 0
INDIRP4
CNSTI4 1000
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1004
ADDP4
CNSTF4 1056964608
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1008
ADDP4
CNSTF4 0
ASGNF4
line 109
;109:		break;
ADDRGP4 $94
JUMPV
LABELV $103
line 112
;110:
;111:	case WP_PLASMAGUN:
;112:		MAKERGB( pi->flashDlightColor, 0.6f, 0.6f, 1 );
ADDRFP4 0
INDIRP4
CNSTI4 1000
ADDP4
CNSTF4 1058642330
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1004
ADDP4
CNSTF4 1058642330
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1008
ADDP4
CNSTF4 1065353216
ASGNF4
line 113
;113:		break;
ADDRGP4 $94
JUMPV
LABELV $104
line 116
;114:
;115:	case WP_BFG:
;116:		MAKERGB( pi->flashDlightColor, 1, 0.7f, 1 );
ADDRFP4 0
INDIRP4
CNSTI4 1000
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1004
ADDP4
CNSTF4 1060320051
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1008
ADDP4
CNSTF4 1065353216
ASGNF4
line 117
;117:		break;
ADDRGP4 $94
JUMPV
LABELV $105
line 120
;118:
;119:	case WP_GRAPPLING_HOOK:
;120:		MAKERGB( pi->flashDlightColor, 0.6f, 0.6f, 1 );
ADDRFP4 0
INDIRP4
CNSTI4 1000
ADDP4
CNSTF4 1058642330
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1004
ADDP4
CNSTF4 1058642330
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1008
ADDP4
CNSTF4 1065353216
ASGNF4
line 121
;121:		break;
ADDRGP4 $94
JUMPV
LABELV $93
line 124
;122:
;123:	default:
;124:		MAKERGB( pi->flashDlightColor, 1, 1, 1 );
ADDRFP4 0
INDIRP4
CNSTI4 1000
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1004
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1008
ADDP4
CNSTF4 1065353216
ASGNF4
line 125
;125:		break;
LABELV $94
line 127
;126:	}
;127:}
LABELV $68
endproc UI_PlayerInfo_SetWeapon 84 8
proc UI_ForceLegsAnim 8 0
line 135
;128:
;129:
;130:/*
;131:===============
;132:UI_ForceLegsAnim
;133:===============
;134:*/
;135:static void UI_ForceLegsAnim( playerInfo_t *pi, int anim ) {
line 136
;136:	pi->legsAnim = ( ( pi->legsAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT ) | anim;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1044
ADDP4
ASGNP4
ADDRLP4 4
CNSTI4 128
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
BANDI4
ADDRLP4 4
INDIRI4
BXORI4
ADDRFP4 4
INDIRI4
BORI4
ASGNI4
line 138
;137:
;138:	if ( anim == LEGS_JUMP ) {
ADDRFP4 4
INDIRI4
CNSTI4 18
NEI4 $109
line 139
;139:		pi->legsAnimationTimer = UI_TIMER_JUMP;
ADDRFP4 0
INDIRP4
CNSTI4 1080
ADDP4
CNSTI4 1000
ASGNI4
line 140
;140:	}
LABELV $109
line 141
;141:}
LABELV $108
endproc UI_ForceLegsAnim 8 0
proc UI_SetLegsAnim 0 8
line 149
;142:
;143:
;144:/*
;145:===============
;146:UI_SetLegsAnim
;147:===============
;148:*/
;149:static void UI_SetLegsAnim( playerInfo_t *pi, int anim ) {
line 150
;150:	if ( pi->pendingLegsAnim ) {
ADDRFP4 0
INDIRP4
CNSTI4 1068
ADDP4
INDIRI4
CNSTI4 0
EQI4 $112
line 151
;151:		anim = pi->pendingLegsAnim;
ADDRFP4 4
ADDRFP4 0
INDIRP4
CNSTI4 1068
ADDP4
INDIRI4
ASGNI4
line 152
;152:		pi->pendingLegsAnim = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1068
ADDP4
CNSTI4 0
ASGNI4
line 153
;153:	}
LABELV $112
line 154
;154:	UI_ForceLegsAnim( pi, anim );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 UI_ForceLegsAnim
CALLV
pop
line 155
;155:}
LABELV $111
endproc UI_SetLegsAnim 0 8
proc UI_ForceTorsoAnim 12 0
line 163
;156:
;157:
;158:/*
;159:===============
;160:UI_ForceTorsoAnim
;161:===============
;162:*/
;163:static void UI_ForceTorsoAnim( playerInfo_t *pi, int anim ) {
line 164
;164:	pi->torsoAnim = ( ( pi->torsoAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT ) | anim;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1048
ADDP4
ASGNP4
ADDRLP4 4
CNSTI4 128
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
BANDI4
ADDRLP4 4
INDIRI4
BXORI4
ADDRFP4 4
INDIRI4
BORI4
ASGNI4
line 166
;165:
;166:	if ( anim == TORSO_GESTURE ) {
ADDRFP4 4
INDIRI4
CNSTI4 6
NEI4 $115
line 167
;167:		pi->torsoAnimationTimer = UI_TIMER_GESTURE;
ADDRFP4 0
INDIRP4
CNSTI4 1072
ADDP4
CNSTI4 2300
ASGNI4
line 168
;168:	}
LABELV $115
line 170
;169:
;170:	if ( anim == TORSO_ATTACK || anim == TORSO_ATTACK2 ) {
ADDRLP4 8
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 7
EQI4 $119
ADDRLP4 8
INDIRI4
CNSTI4 8
NEI4 $117
LABELV $119
line 171
;171:		pi->torsoAnimationTimer = UI_TIMER_ATTACK;
ADDRFP4 0
INDIRP4
CNSTI4 1072
ADDP4
CNSTI4 500
ASGNI4
line 172
;172:	}
LABELV $117
line 173
;173:}
LABELV $114
endproc UI_ForceTorsoAnim 12 0
proc UI_SetTorsoAnim 0 8
line 181
;174:
;175:
;176:/*
;177:===============
;178:UI_SetTorsoAnim
;179:===============
;180:*/
;181:static void UI_SetTorsoAnim( playerInfo_t *pi, int anim ) {
line 182
;182:	if ( pi->pendingTorsoAnim ) {
ADDRFP4 0
INDIRP4
CNSTI4 1076
ADDP4
INDIRI4
CNSTI4 0
EQI4 $121
line 183
;183:		anim = pi->pendingTorsoAnim;
ADDRFP4 4
ADDRFP4 0
INDIRP4
CNSTI4 1076
ADDP4
INDIRI4
ASGNI4
line 184
;184:		pi->pendingTorsoAnim = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1076
ADDP4
CNSTI4 0
ASGNI4
line 185
;185:	}
LABELV $121
line 187
;186:
;187:	UI_ForceTorsoAnim( pi, anim );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 UI_ForceTorsoAnim
CALLV
pop
line 188
;188:}
LABELV $120
endproc UI_SetTorsoAnim 0 8
proc UI_TorsoSequencing 16 8
line 196
;189:
;190:
;191:/*
;192:===============
;193:UI_TorsoSequencing
;194:===============
;195:*/
;196:static void UI_TorsoSequencing( playerInfo_t *pi ) {
line 199
;197:	int		currentAnim;
;198:
;199:	currentAnim = pi->torsoAnim & ~ANIM_TOGGLEBIT;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1048
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 201
;200:
;201:	if ( pi->weapon != pi->currentWeapon ) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 1052
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 1040
ADDP4
INDIRI4
EQI4 $124
line 202
;202:		if ( currentAnim != TORSO_DROP ) {
ADDRLP4 0
INDIRI4
CNSTI4 9
EQI4 $126
line 203
;203:			pi->torsoAnimationTimer = UI_TIMER_WEAPON_SWITCH;
ADDRFP4 0
INDIRP4
CNSTI4 1072
ADDP4
CNSTI4 300
ASGNI4
line 204
;204:			UI_ForceTorsoAnim( pi, TORSO_DROP );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 9
ARGI4
ADDRGP4 UI_ForceTorsoAnim
CALLV
pop
line 205
;205:		}
LABELV $126
line 206
;206:	}
LABELV $124
line 208
;207:
;208:	if ( pi->torsoAnimationTimer > 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 1072
ADDP4
INDIRI4
CNSTI4 0
LEI4 $128
line 209
;209:		return;
ADDRGP4 $123
JUMPV
LABELV $128
line 212
;210:	}
;211:
;212:	if( currentAnim == TORSO_GESTURE ) {
ADDRLP4 0
INDIRI4
CNSTI4 6
NEI4 $130
line 213
;213:		UI_SetTorsoAnim( pi, TORSO_STAND );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 11
ARGI4
ADDRGP4 UI_SetTorsoAnim
CALLV
pop
line 214
;214:		return;
ADDRGP4 $123
JUMPV
LABELV $130
line 217
;215:	}
;216:
;217:	if( currentAnim == TORSO_ATTACK || currentAnim == TORSO_ATTACK2 ) {
ADDRLP4 0
INDIRI4
CNSTI4 7
EQI4 $134
ADDRLP4 0
INDIRI4
CNSTI4 8
NEI4 $132
LABELV $134
line 218
;218:		UI_SetTorsoAnim( pi, TORSO_STAND );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 11
ARGI4
ADDRGP4 UI_SetTorsoAnim
CALLV
pop
line 219
;219:		return;
ADDRGP4 $123
JUMPV
LABELV $132
line 222
;220:	}
;221:
;222:	if ( currentAnim == TORSO_DROP ) {
ADDRLP4 0
INDIRI4
CNSTI4 9
NEI4 $135
line 223
;223:		UI_PlayerInfo_SetWeapon( pi, pi->weapon );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 1052
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_PlayerInfo_SetWeapon
CALLV
pop
line 224
;224:		pi->torsoAnimationTimer = UI_TIMER_WEAPON_SWITCH;
ADDRFP4 0
INDIRP4
CNSTI4 1072
ADDP4
CNSTI4 300
ASGNI4
line 225
;225:		UI_ForceTorsoAnim( pi, TORSO_RAISE );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 UI_ForceTorsoAnim
CALLV
pop
line 226
;226:		return;
ADDRGP4 $123
JUMPV
LABELV $135
line 229
;227:	}
;228:
;229:	if ( currentAnim == TORSO_RAISE ) {
ADDRLP4 0
INDIRI4
CNSTI4 10
NEI4 $137
line 230
;230:		UI_SetTorsoAnim( pi, TORSO_STAND );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 11
ARGI4
ADDRGP4 UI_SetTorsoAnim
CALLV
pop
line 231
;231:		return;
LABELV $137
line 233
;232:	}
;233:}
LABELV $123
endproc UI_TorsoSequencing 16 8
proc UI_LegsSequencing 8 8
line 241
;234:
;235:
;236:/*
;237:===============
;238:UI_LegsSequencing
;239:===============
;240:*/
;241:static void UI_LegsSequencing( playerInfo_t *pi ) {
line 244
;242:	int		currentAnim;
;243:
;244:	currentAnim = pi->legsAnim & ~ANIM_TOGGLEBIT;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1044
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 246
;245:
;246:	if ( pi->legsAnimationTimer > 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 1080
ADDP4
INDIRI4
CNSTI4 0
LEI4 $140
line 247
;247:		if ( currentAnim == LEGS_JUMP ) {
ADDRLP4 0
INDIRI4
CNSTI4 18
NEI4 $139
line 248
;248:			jumpHeight = JUMP_HEIGHT * sin( M_PI * ( UI_TIMER_JUMP - pi->legsAnimationTimer ) / UI_TIMER_JUMP );
CNSTF4 1078530011
CNSTI4 1000
ADDRFP4 0
INDIRP4
CNSTI4 1080
ADDP4
INDIRI4
SUBI4
CVIF4 4
MULF4
CNSTF4 1148846080
DIVF4
ARGF4
ADDRLP4 4
ADDRGP4 sin
CALLF4
ASGNF4
ADDRGP4 jumpHeight
CNSTF4 1113587712
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 249
;249:		}
line 250
;250:		return;
ADDRGP4 $139
JUMPV
LABELV $140
line 253
;251:	}
;252:
;253:	if ( currentAnim == LEGS_JUMP ) {
ADDRLP4 0
INDIRI4
CNSTI4 18
NEI4 $144
line 254
;254:		UI_ForceLegsAnim( pi, LEGS_LAND );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 19
ARGI4
ADDRGP4 UI_ForceLegsAnim
CALLV
pop
line 255
;255:		pi->legsAnimationTimer = UI_TIMER_LAND;
ADDRFP4 0
INDIRP4
CNSTI4 1080
ADDP4
CNSTI4 130
ASGNI4
line 256
;256:		jumpHeight = 0;
ADDRGP4 jumpHeight
CNSTF4 0
ASGNF4
line 257
;257:		return;
ADDRGP4 $139
JUMPV
LABELV $144
line 260
;258:	}
;259:
;260:	if ( currentAnim == LEGS_LAND ) {
ADDRLP4 0
INDIRI4
CNSTI4 19
NEI4 $146
line 261
;261:		UI_SetLegsAnim( pi, LEGS_IDLE );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 22
ARGI4
ADDRGP4 UI_SetLegsAnim
CALLV
pop
line 262
;262:		return;
LABELV $146
line 264
;263:	}
;264:}
LABELV $139
endproc UI_LegsSequencing 8 8
proc UI_PositionEntityOnTag 84 24
line 273
;265:
;266:
;267:/*
;268:======================
;269:UI_PositionEntityOnTag
;270:======================
;271:*/
;272:static void UI_PositionEntityOnTag( refEntity_t *entity, const refEntity_t *parent, 
;273:							clipHandle_t parentModel, char *tagName ) {
line 278
;274:	int				i;
;275:	orientation_t	lerped;
;276:	
;277:	// lerp the tag
;278:	trap_CM_LerpTag( &lerped, parentModel, parent->oldframe, parent->frame,
ADDRLP4 4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 52
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 96
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ARGI4
CNSTF4 1065353216
ADDRLP4 52
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ARGF4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_CM_LerpTag
CALLI4
pop
line 282
;279:		1.0 - parent->backlerp, tagName );
;280:
;281:	// FIXME: allow origin offsets along tag?
;282:	VectorCopy( parent->origin, entity->origin );
ADDRLP4 56
CNSTI4 68
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
ADDRFP4 4
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRB
ASGNB 12
line 283
;283:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $149
line 284
;284:		VectorMA( entity->origin, lerped.origin[i], parent->axis[i], entity->origin );
ADDRLP4 60
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 68
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRF4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 76
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRF4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 285
;285:	}
LABELV $150
line 283
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $149
line 288
;286:
;287:	// cast away const because of compiler problems
;288:	MatrixMultiply( lerped.axis, ((refEntity_t*)parent)->axis, entity->axis );
ADDRLP4 4+12
ARGP4
ADDRLP4 60
CNSTI4 28
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 60
INDIRI4
ADDP
ARGP4
ADDRFP4 0
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
ARGP4
ADDRGP4 MatrixMultiply
CALLV
pop
line 289
;289:	entity->backlerp = parent->backlerp;
ADDRLP4 64
CNSTI4 100
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
ADDRFP4 4
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRF4
ASGNF4
line 290
;290:}
LABELV $148
endproc UI_PositionEntityOnTag 84 24
proc UI_PositionRotatedEntityOnTag 120 24
line 299
;291:
;292:
;293:/*
;294:======================
;295:UI_PositionRotatedEntityOnTag
;296:======================
;297:*/
;298:static void UI_PositionRotatedEntityOnTag( refEntity_t *entity, const refEntity_t *parent, 
;299:							clipHandle_t parentModel, char *tagName ) {
line 305
;300:	int				i;
;301:	orientation_t	lerped;
;302:	vec3_t			tempAxis[3];
;303:
;304:	// lerp the tag
;305:	trap_CM_LerpTag( &lerped, parentModel, parent->oldframe, parent->frame,
ADDRLP4 4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 88
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 96
ADDP4
INDIRI4
ARGI4
ADDRLP4 88
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ARGI4
CNSTF4 1065353216
ADDRLP4 88
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ARGF4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_CM_LerpTag
CALLI4
pop
line 309
;306:		1.0 - parent->backlerp, tagName );
;307:
;308:	// FIXME: allow origin offsets along tag?
;309:	VectorCopy( parent->origin, entity->origin );
ADDRLP4 92
CNSTI4 68
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
ADDRFP4 4
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRB
ASGNB 12
line 310
;310:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $155
line 311
;311:		VectorMA( entity->origin, lerped.origin[i], parent->axis[i], entity->origin );
ADDRLP4 96
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 96
INDIRP4
ADDRLP4 96
INDIRP4
INDIRF4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 104
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRF4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 112
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRF4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 312
;312:	}
LABELV $156
line 310
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $155
line 315
;313:
;314:	// cast away const because of compiler problems
;315:	MatrixMultiply( entity->axis, ((refEntity_t *)parent)->axis, tempAxis );
ADDRLP4 96
CNSTI4 28
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 96
INDIRI4
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ADDRLP4 96
INDIRI4
ADDP
ARGP4
ADDRLP4 52
ARGP4
ADDRGP4 MatrixMultiply
CALLV
pop
line 316
;316:	MatrixMultiply( lerped.axis, tempAxis, entity->axis );
ADDRLP4 4+12
ARGP4
ADDRLP4 52
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRGP4 MatrixMultiply
CALLV
pop
line 317
;317:}
LABELV $154
endproc UI_PositionRotatedEntityOnTag 120 24
proc UI_SetLerpFrameAnimation 12 8
line 325
;318:
;319:
;320:/*
;321:===============
;322:UI_SetLerpFrameAnimation
;323:===============
;324:*/
;325:static void UI_SetLerpFrameAnimation( playerInfo_t *ci, lerpFrame_t *lf, int newAnimation ) {
line 328
;326:	animation_t	*anim;
;327:
;328:	lf->animationNumber = newAnimation;
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 329
;329:	newAnimation &= ~ANIM_TOGGLEBIT;
ADDRFP4 8
ADDRFP4 8
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 331
;330:
;331:	if ( newAnimation < 0 || newAnimation >= MAX_ANIMATIONS ) {
ADDRLP4 4
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $163
ADDRLP4 4
INDIRI4
CNSTI4 31
LTI4 $161
LABELV $163
line 332
;332:		trap_Error( va("Bad animation number: %i", newAnimation) );
ADDRGP4 $164
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_Error
CALLV
pop
line 333
;333:	}
LABELV $161
line 335
;334:
;335:	anim = &ci->animations[ newAnimation ];
ADDRLP4 0
CNSTI4 28
ADDRFP4 8
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
ADDP4
ASGNP4
line 337
;336:
;337:	lf->animation = anim;
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 338
;338:	lf->animationTime = lf->frameTime + anim->initialLerp;
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ADDI4
ASGNI4
line 339
;339:}
LABELV $160
endproc UI_SetLerpFrameAnimation 12 8
proc UI_RunLerpFrame 32 12
line 347
;340:
;341:
;342:/*
;343:===============
;344:UI_RunLerpFrame
;345:===============
;346:*/
;347:static void UI_RunLerpFrame( playerInfo_t *ci, lerpFrame_t *lf, int newAnimation ) {
line 352
;348:	int			f;
;349:	animation_t	*anim;
;350:
;351:	// see if the animation sequence is switching
;352:	if ( newAnimation != lf->animationNumber || !lf->animation ) {
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRFP4 8
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
NEI4 $168
ADDRLP4 8
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $166
LABELV $168
line 353
;353:		UI_SetLerpFrameAnimation( ci, lf, newAnimation );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 UI_SetLerpFrameAnimation
CALLV
pop
line 354
;354:	}
LABELV $166
line 358
;355:
;356:	// if we have passed the current frame, move it to
;357:	// oldFrame and calculate a new frame
;358:	if ( dp_realtime >= lf->frameTime ) {
ADDRGP4 dp_realtime
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
LTI4 $169
line 359
;359:		lf->oldFrame = lf->frame;
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 360
;360:		lf->oldFrameTime = lf->frameTime;
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 363
;361:
;362:		// get the next frame based on the animation
;363:		anim = lf->animation;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
ASGNP4
line 364
;364:		if ( dp_realtime < lf->animationTime ) {
ADDRGP4 dp_realtime
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
GEI4 $171
line 365
;365:			lf->frameTime = lf->animationTime;		// initial lerp
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ASGNI4
line 366
;366:		} else {
ADDRGP4 $172
JUMPV
LABELV $171
line 367
;367:			lf->frameTime = lf->oldFrameTime + anim->frameLerp;
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 24
CNSTI4 12
ASGNI4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
ADDI4
ASGNI4
line 368
;368:		}
LABELV $172
line 369
;369:		f = ( lf->frameTime - lf->animationTime ) / anim->frameLerp;
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 24
CNSTI4 12
ASGNI4
ADDRLP4 4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
ADDRLP4 20
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
SUBI4
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
DIVI4
ASGNI4
line 370
;370:		if ( f >= anim->numFrames ) {
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LTI4 $173
line 371
;371:			f -= anim->numFrames;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
SUBI4
ASGNI4
line 372
;372:			if ( anim->loopFrames ) {
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 0
EQI4 $175
line 373
;373:				f %= anim->loopFrames;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MODI4
ASGNI4
line 374
;374:				f += anim->numFrames - anim->loopFrames;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
SUBI4
ADDI4
ASGNI4
line 375
;375:			} else {
ADDRGP4 $176
JUMPV
LABELV $175
line 376
;376:				f = anim->numFrames - 1;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 379
;377:				// the animation is stuck at the end, so it
;378:				// can immediately transition to another sequence
;379:				lf->frameTime = dp_realtime;
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRGP4 dp_realtime
INDIRI4
ASGNI4
line 380
;380:			}
LABELV $176
line 381
;381:		}
LABELV $173
line 382
;382:		lf->frame = anim->firstFrame + f;
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 383
;383:		if ( dp_realtime > lf->frameTime ) {
ADDRGP4 dp_realtime
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
LEI4 $177
line 384
;384:			lf->frameTime = dp_realtime;
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRGP4 dp_realtime
INDIRI4
ASGNI4
line 385
;385:		}
LABELV $177
line 386
;386:	}
LABELV $169
line 388
;387:
;388:	if ( lf->frameTime > dp_realtime + 200 ) {
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRGP4 dp_realtime
INDIRI4
CNSTI4 200
ADDI4
LEI4 $179
line 389
;389:		lf->frameTime = dp_realtime;
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRGP4 dp_realtime
INDIRI4
ASGNI4
line 390
;390:	}
LABELV $179
line 392
;391:
;392:	if ( lf->oldFrameTime > dp_realtime ) {
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRGP4 dp_realtime
INDIRI4
LEI4 $181
line 393
;393:		lf->oldFrameTime = dp_realtime;
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 dp_realtime
INDIRI4
ASGNI4
line 394
;394:	}
LABELV $181
line 396
;395:	// calculate current lerp value
;396:	if ( lf->frameTime == lf->oldFrameTime ) {
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
NEI4 $183
line 397
;397:		lf->backlerp = 0;
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 0
ASGNF4
line 398
;398:	} else {
ADDRGP4 $184
JUMPV
LABELV $183
line 399
;399:		lf->backlerp = 1.0 - (float)( dp_realtime - lf->oldFrameTime ) / ( lf->frameTime - lf->oldFrameTime );
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 1065353216
ADDRGP4 dp_realtime
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
CVIF4 4
DIVF4
SUBF4
ASGNF4
line 400
;400:	}
LABELV $184
line 401
;401:}
LABELV $165
endproc UI_RunLerpFrame 32 12
proc UI_PlayerAnimation 16 12
line 410
;402:
;403:
;404:/*
;405:===============
;406:UI_PlayerAnimation
;407:===============
;408:*/
;409:static void UI_PlayerAnimation( playerInfo_t *pi, int *legsOld, int *legs, float *legsBackLerp,
;410:						int *torsoOld, int *torso, float *torsoBackLerp ) {
line 413
;411:
;412:	// legs animation
;413:	pi->legsAnimationTimer -= uis.frametime;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1080
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 uis
INDIRI4
SUBI4
ASGNI4
line 414
;414:	if ( pi->legsAnimationTimer < 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 1080
ADDP4
INDIRI4
CNSTI4 0
GEI4 $186
line 415
;415:		pi->legsAnimationTimer = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1080
ADDP4
CNSTI4 0
ASGNI4
line 416
;416:	}
LABELV $186
line 418
;417:
;418:	UI_LegsSequencing( pi );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 UI_LegsSequencing
CALLV
pop
line 420
;419:
;420:	if ( pi->legs.yawing && ( pi->legsAnim & ~ANIM_TOGGLEBIT ) == LEGS_IDLE ) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $188
ADDRLP4 4
INDIRP4
CNSTI4 1044
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
CNSTI4 22
NEI4 $188
line 421
;421:		UI_RunLerpFrame( pi, &pi->legs, LEGS_TURN );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ARGP4
CNSTI4 24
ARGI4
ADDRGP4 UI_RunLerpFrame
CALLV
pop
line 422
;422:	} else {
ADDRGP4 $189
JUMPV
LABELV $188
line 423
;423:		UI_RunLerpFrame( pi, &pi->legs, pi->legsAnim );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 1044
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_RunLerpFrame
CALLV
pop
line 424
;424:	}
LABELV $189
line 425
;425:	*legsOld = pi->legs.oldFrame;
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 426
;426:	*legs = pi->legs.frame;
ADDRFP4 8
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 427
;427:	*legsBackLerp = pi->legs.backlerp;
ADDRFP4 12
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 430
;428:
;429:	// torso animation
;430:	pi->torsoAnimationTimer -= uis.frametime;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 1072
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRGP4 uis
INDIRI4
SUBI4
ASGNI4
line 431
;431:	if ( pi->torsoAnimationTimer < 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 1072
ADDP4
INDIRI4
CNSTI4 0
GEI4 $190
line 432
;432:		pi->torsoAnimationTimer = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1072
ADDP4
CNSTI4 0
ASGNI4
line 433
;433:	}
LABELV $190
line 435
;434:
;435:	UI_TorsoSequencing( pi );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 UI_TorsoSequencing
CALLV
pop
line 437
;436:
;437:	UI_RunLerpFrame( pi, &pi->torso, pi->torsoAnim );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 64
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 1048
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_RunLerpFrame
CALLV
pop
line 438
;438:	*torsoOld = pi->torso.oldFrame;
ADDRFP4 16
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ASGNI4
line 439
;439:	*torso = pi->torso.frame;
ADDRFP4 20
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
ASGNI4
line 440
;440:	*torsoBackLerp = pi->torso.backlerp;
ADDRFP4 24
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
ASGNF4
line 441
;441:}
LABELV $185
endproc UI_PlayerAnimation 16 12
proc UI_SwingAngles 28 8
line 450
;442:
;443:
;444:/*
;445:==================
;446:UI_SwingAngles
;447:==================
;448:*/
;449:static void UI_SwingAngles( float destination, float swingTolerance, float clampTolerance,
;450:					float speed, float *angle, qboolean *swinging ) {
line 455
;451:	float	swing;
;452:	float	move;
;453:	float	scale;
;454:
;455:	if ( !*swinging ) {
ADDRFP4 20
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $193
line 457
;456:		// see if a swing should be started
;457:		swing = AngleSubtract( *angle, destination );
ADDRFP4 16
INDIRP4
INDIRF4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ASGNF4
line 458
;458:		if ( swing > swingTolerance || swing < -swingTolerance ) {
ADDRLP4 20
ADDRFP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRF4
GTF4 $197
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRF4
NEGF4
GEF4 $195
LABELV $197
line 459
;459:			*swinging = qtrue;
ADDRFP4 20
INDIRP4
CNSTI4 1
ASGNI4
line 460
;460:		}
LABELV $195
line 461
;461:	}
LABELV $193
line 463
;462:
;463:	if ( !*swinging ) {
ADDRFP4 20
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $198
line 464
;464:		return;
ADDRGP4 $192
JUMPV
LABELV $198
line 469
;465:	}
;466:	
;467:	// modify the speed depending on the delta
;468:	// so it doesn't seem so linear
;469:	swing = AngleSubtract( destination, *angle );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ASGNF4
line 470
;470:	scale = fabs( swing );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 16
INDIRF4
ASGNF4
line 471
;471:	if ( scale < swingTolerance * 0.5 ) {
ADDRLP4 4
INDIRF4
CNSTF4 1056964608
ADDRFP4 4
INDIRF4
MULF4
GEF4 $200
line 472
;472:		scale = 0.5;
ADDRLP4 4
CNSTF4 1056964608
ASGNF4
line 473
;473:	} else if ( scale < swingTolerance ) {
ADDRGP4 $201
JUMPV
LABELV $200
ADDRLP4 4
INDIRF4
ADDRFP4 4
INDIRF4
GEF4 $202
line 474
;474:		scale = 1.0;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 475
;475:	} else {
ADDRGP4 $203
JUMPV
LABELV $202
line 476
;476:		scale = 2.0;
ADDRLP4 4
CNSTF4 1073741824
ASGNF4
line 477
;477:	}
LABELV $203
LABELV $201
line 480
;478:
;479:	// swing towards the destination angle
;480:	if ( swing >= 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LTF4 $204
line 481
;481:		move = uis.frametime * scale * speed;
ADDRLP4 8
ADDRGP4 uis
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
MULF4
ADDRFP4 12
INDIRF4
MULF4
ASGNF4
line 482
;482:		if ( move >= swing ) {
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRF4
LTF4 $206
line 483
;483:			move = swing;
ADDRLP4 8
ADDRLP4 0
INDIRF4
ASGNF4
line 484
;484:			*swinging = qfalse;
ADDRFP4 20
INDIRP4
CNSTI4 0
ASGNI4
line 485
;485:		}
LABELV $206
line 486
;486:		*angle = AngleMod( *angle + move );
ADDRLP4 20
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 8
INDIRF4
ADDF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 487
;487:	} else if ( swing < 0 ) {
ADDRGP4 $205
JUMPV
LABELV $204
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $208
line 488
;488:		move = uis.frametime * scale * -speed;
ADDRLP4 8
ADDRGP4 uis
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
MULF4
ADDRFP4 12
INDIRF4
NEGF4
MULF4
ASGNF4
line 489
;489:		if ( move <= swing ) {
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRF4
GTF4 $210
line 490
;490:			move = swing;
ADDRLP4 8
ADDRLP4 0
INDIRF4
ASGNF4
line 491
;491:			*swinging = qfalse;
ADDRFP4 20
INDIRP4
CNSTI4 0
ASGNI4
line 492
;492:		}
LABELV $210
line 493
;493:		*angle = AngleMod( *angle + move );
ADDRLP4 20
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 8
INDIRF4
ADDF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 494
;494:	}
LABELV $208
LABELV $205
line 497
;495:
;496:	// clamp to no more than tolerance
;497:	swing = AngleSubtract( destination, *angle );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 AngleSubtract
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 20
INDIRF4
ASGNF4
line 498
;498:	if ( swing > clampTolerance ) {
ADDRLP4 0
INDIRF4
ADDRFP4 8
INDIRF4
LEF4 $212
line 499
;499:		*angle = AngleMod( destination - (clampTolerance - 1) );
ADDRFP4 0
INDIRF4
ADDRFP4 8
INDIRF4
CNSTF4 1065353216
SUBF4
SUBF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRFP4 16
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 500
;500:	} else if ( swing < -clampTolerance ) {
ADDRGP4 $213
JUMPV
LABELV $212
ADDRLP4 0
INDIRF4
ADDRFP4 8
INDIRF4
NEGF4
GEF4 $214
line 501
;501:		*angle = AngleMod( destination + (clampTolerance - 1) );
ADDRFP4 0
INDIRF4
ADDRFP4 8
INDIRF4
CNSTF4 1065353216
SUBF4
ADDF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRFP4 16
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 502
;502:	}
LABELV $214
LABELV $213
line 503
;503:}
LABELV $192
endproc UI_SwingAngles 28 8
proc UI_MovedirAdjustment 72 16
line 511
;504:
;505:
;506:/*
;507:======================
;508:UI_MovedirAdjustment
;509:======================
;510:*/
;511:static float UI_MovedirAdjustment( playerInfo_t *pi ) {
line 515
;512:	vec3_t		relativeAngles;
;513:	vec3_t		moveVector;
;514:
;515:	VectorSubtract( pi->viewAngles, pi->moveAngles, relativeAngles );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 24
INDIRP4
CNSTI4 1016
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 1028
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 24
INDIRP4
CNSTI4 1020
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 1032
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12+8
ADDRLP4 28
INDIRP4
CNSTI4 1024
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 1036
ADDP4
INDIRF4
SUBF4
ASGNF4
line 516
;516:	AngleVectors( relativeAngles, moveVector, NULL, NULL );
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 32
CNSTP4 0
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 517
;517:	if ( Q_fabs( moveVector[0] ) < 0.01 ) {
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 Q_fabs
CALLF4
ASGNF4
ADDRLP4 36
INDIRF4
CNSTF4 1008981770
GEF4 $219
line 518
;518:		moveVector[0] = 0.0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 519
;519:	}
LABELV $219
line 520
;520:	if ( Q_fabs( moveVector[1] ) < 0.01 ) {
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 Q_fabs
CALLF4
ASGNF4
ADDRLP4 40
INDIRF4
CNSTF4 1008981770
GEF4 $221
line 521
;521:		moveVector[1] = 0.0;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 522
;522:	}
LABELV $221
line 524
;523:
;524:	if ( moveVector[1] == 0 && moveVector[0] > 0 ) {
ADDRLP4 44
CNSTF4 0
ASGNF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 44
INDIRF4
NEF4 $225
ADDRLP4 0
INDIRF4
ADDRLP4 44
INDIRF4
LEF4 $225
line 525
;525:		return 0;
CNSTF4 0
RETF4
ADDRGP4 $216
JUMPV
LABELV $225
line 527
;526:	}
;527:	if ( moveVector[1] < 0 && moveVector[0] > 0 ) {
ADDRLP4 48
CNSTF4 0
ASGNF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 48
INDIRF4
GEF4 $228
ADDRLP4 0
INDIRF4
ADDRLP4 48
INDIRF4
LEF4 $228
line 528
;528:		return 22;
CNSTF4 1102053376
RETF4
ADDRGP4 $216
JUMPV
LABELV $228
line 530
;529:	}
;530:	if ( moveVector[1] < 0 && moveVector[0] == 0 ) {
ADDRLP4 52
CNSTF4 0
ASGNF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 52
INDIRF4
GEF4 $231
ADDRLP4 0
INDIRF4
ADDRLP4 52
INDIRF4
NEF4 $231
line 531
;531:		return 45;
CNSTF4 1110704128
RETF4
ADDRGP4 $216
JUMPV
LABELV $231
line 533
;532:	}
;533:	if ( moveVector[1] < 0 && moveVector[0] < 0 ) {
ADDRLP4 56
CNSTF4 0
ASGNF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 56
INDIRF4
GEF4 $234
ADDRLP4 0
INDIRF4
ADDRLP4 56
INDIRF4
GEF4 $234
line 534
;534:		return -22;
CNSTF4 3249537024
RETF4
ADDRGP4 $216
JUMPV
LABELV $234
line 536
;535:	}
;536:	if ( moveVector[1] == 0 && moveVector[0] < 0 ) {
ADDRLP4 60
CNSTF4 0
ASGNF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 60
INDIRF4
NEF4 $237
ADDRLP4 0
INDIRF4
ADDRLP4 60
INDIRF4
GEF4 $237
line 537
;537:		return 0;
CNSTF4 0
RETF4
ADDRGP4 $216
JUMPV
LABELV $237
line 539
;538:	}
;539:	if ( moveVector[1] > 0 && moveVector[0] < 0 ) {
ADDRLP4 64
CNSTF4 0
ASGNF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 64
INDIRF4
LEF4 $240
ADDRLP4 0
INDIRF4
ADDRLP4 64
INDIRF4
GEF4 $240
line 540
;540:		return 22;
CNSTF4 1102053376
RETF4
ADDRGP4 $216
JUMPV
LABELV $240
line 542
;541:	}
;542:	if ( moveVector[1] > 0 && moveVector[0] == 0 ) {
ADDRLP4 68
CNSTF4 0
ASGNF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 68
INDIRF4
LEF4 $243
ADDRLP4 0
INDIRF4
ADDRLP4 68
INDIRF4
NEF4 $243
line 543
;543:		return  -45;
CNSTF4 3258187776
RETF4
ADDRGP4 $216
JUMPV
LABELV $243
line 546
;544:	}
;545:
;546:	return -22;
CNSTF4 3249537024
RETF4
LABELV $216
endproc UI_MovedirAdjustment 72 16
proc UI_PlayerAngles 80 24
line 555
;547:}
;548:
;549:
;550:/*
;551:===============
;552:UI_PlayerAngles
;553:===============
;554:*/
;555:static void UI_PlayerAngles( playerInfo_t *pi, vec3_t legs[3], vec3_t torso[3], vec3_t head[3] ) {
line 560
;556:	vec3_t		legsAngles, torsoAngles, headAngles;
;557:	float		dest;
;558:	float		adjust;
;559:
;560:	VectorCopy( pi->viewAngles, headAngles );
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 1016
ADDP4
INDIRB
ASGNB 12
line 561
;561:	headAngles[YAW] = AngleMod( headAngles[YAW] );
ADDRLP4 12+4
INDIRF4
ARGF4
ADDRLP4 44
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 44
INDIRF4
ASGNF4
line 562
;562:	VectorClear( legsAngles );
ADDRLP4 48
CNSTF4 0
ASGNF4
ADDRLP4 24+8
ADDRLP4 48
INDIRF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 48
INDIRF4
ASGNF4
ADDRLP4 24
ADDRLP4 48
INDIRF4
ASGNF4
line 563
;563:	VectorClear( torsoAngles );
ADDRLP4 52
CNSTF4 0
ASGNF4
ADDRLP4 0+8
ADDRLP4 52
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 52
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 52
INDIRF4
ASGNF4
line 568
;564:
;565:	// --------- yaw -------------
;566:
;567:	// allow yaw to drift a bit
;568:	if ( ( pi->legsAnim & ~ANIM_TOGGLEBIT ) != LEGS_IDLE 
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
CNSTI4 -129
ASGNI4
ADDRLP4 56
INDIRP4
CNSTI4 1044
ADDP4
INDIRI4
ADDRLP4 60
INDIRI4
BANDI4
CNSTI4 22
NEI4 $255
ADDRLP4 56
INDIRP4
CNSTI4 1048
ADDP4
INDIRI4
ADDRLP4 60
INDIRI4
BANDI4
CNSTI4 11
EQI4 $253
LABELV $255
line 569
;569:		|| ( pi->torsoAnim & ~ANIM_TOGGLEBIT ) != TORSO_STAND  ) {
line 571
;570:		// if not standing still, always point all in the same direction
;571:		pi->torso.yawing = qtrue;	// always center
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 1
ASGNI4
line 572
;572:		pi->torso.pitching = qtrue;	// always center
ADDRFP4 0
INDIRP4
CNSTI4 96
ADDP4
CNSTI4 1
ASGNI4
line 573
;573:		pi->legs.yawing = qtrue;	// always center
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTI4 1
ASGNI4
line 574
;574:	}
LABELV $253
line 577
;575:
;576:	// adjust legs for movement dir
;577:	adjust = UI_MovedirAdjustment( pi );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 UI_MovedirAdjustment
CALLF4
ASGNF4
ADDRLP4 36
ADDRLP4 64
INDIRF4
ASGNF4
line 578
;578:	legsAngles[YAW] = headAngles[YAW] + adjust;
ADDRLP4 24+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
ASGNF4
line 579
;579:	torsoAngles[YAW] = headAngles[YAW] + 0.25 * adjust;
ADDRLP4 0+4
ADDRLP4 12+4
INDIRF4
CNSTF4 1048576000
ADDRLP4 36
INDIRF4
MULF4
ADDF4
ASGNF4
line 583
;580:
;581:
;582:	// torso
;583:	UI_SwingAngles( torsoAngles[YAW], 25, 90, SWINGSPEED, &pi->torso.yawAngle, &pi->torso.yawing );
ADDRLP4 0+4
INDIRF4
ARGF4
CNSTF4 1103626240
ARGF4
CNSTF4 1119092736
ARGF4
CNSTF4 1050253722
ARGF4
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 84
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 88
ADDP4
ARGP4
ADDRGP4 UI_SwingAngles
CALLV
pop
line 584
;584:	UI_SwingAngles( legsAngles[YAW], 40, 90, SWINGSPEED, &pi->legs.yawAngle, &pi->legs.yawing );
ADDRLP4 24+4
INDIRF4
ARGF4
CNSTF4 1109393408
ARGF4
CNSTF4 1119092736
ARGF4
CNSTF4 1050253722
ARGF4
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 UI_SwingAngles
CALLV
pop
line 586
;585:
;586:	torsoAngles[YAW] = pi->torso.yawAngle;
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
ASGNF4
line 587
;587:	legsAngles[YAW] = pi->legs.yawAngle;
ADDRLP4 24+4
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ASGNF4
line 592
;588:
;589:	// --------- pitch -------------
;590:
;591:	// only show a fraction of the pitch angle in the torso
;592:	if ( headAngles[PITCH] > 180 ) {
ADDRLP4 12
INDIRF4
CNSTF4 1127481344
LEF4 $264
line 593
;593:		dest = (-360 + headAngles[PITCH]) * 0.75;
ADDRLP4 40
CNSTF4 1061158912
ADDRLP4 12
INDIRF4
CNSTF4 3283353600
ADDF4
MULF4
ASGNF4
line 594
;594:	} else {
ADDRGP4 $265
JUMPV
LABELV $264
line 595
;595:		dest = headAngles[PITCH] * 0.75;
ADDRLP4 40
CNSTF4 1061158912
ADDRLP4 12
INDIRF4
MULF4
ASGNF4
line 596
;596:	}
LABELV $265
line 597
;597:	UI_SwingAngles( dest, 15, 30, 0.1f, &pi->torso.pitchAngle, &pi->torso.pitching );
ADDRLP4 40
INDIRF4
ARGF4
CNSTF4 1097859072
ARGF4
CNSTF4 1106247680
ARGF4
CNSTF4 1036831949
ARGF4
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 76
INDIRP4
CNSTI4 96
ADDP4
ARGP4
ADDRGP4 UI_SwingAngles
CALLV
pop
line 598
;598:	torsoAngles[PITCH] = pi->torso.pitchAngle;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ASGNF4
line 601
;599:
;600:	// pull the angles back out of the hierarchial chain
;601:	AnglesSubtract( headAngles, torsoAngles, headAngles );
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 AnglesSubtract
CALLV
pop
line 602
;602:	AnglesSubtract( torsoAngles, legsAngles, torsoAngles );
ADDRLP4 0
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 AnglesSubtract
CALLV
pop
line 603
;603:	AnglesToAxis( legsAngles, legs );
ADDRLP4 24
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 604
;604:	AnglesToAxis( torsoAngles, torso );
ADDRLP4 0
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 605
;605:	AnglesToAxis( headAngles, head );
ADDRLP4 12
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 606
;606:}
LABELV $246
endproc UI_PlayerAngles 80 24
proc UI_PlayerFloatSprite 140 12
line 614
;607:
;608:
;609:/*
;610:===============
;611:UI_PlayerFloatSprite
;612:===============
;613:*/
;614:static void UI_PlayerFloatSprite( playerInfo_t *pi, vec3_t origin, qhandle_t shader ) {
line 617
;615:	refEntity_t		ent;
;616:
;617:	memset( &ent, 0, sizeof( ent ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 618
;618:	VectorCopy( origin, ent.origin );
ADDRLP4 0+68
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 619
;619:	ent.origin[2] += 48;
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
CNSTF4 1111490560
ADDF4
ASGNF4
line 620
;620:	ent.reType = RT_SPRITE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 621
;621:	ent.customShader = shader;
ADDRLP4 0+112
ADDRFP4 8
INDIRI4
ASGNI4
line 622
;622:	ent.radius = 10;
ADDRLP4 0+132
CNSTF4 1092616192
ASGNF4
line 623
;623:	ent.renderfx = 0;
ADDRLP4 0+4
CNSTI4 0
ASGNI4
line 624
;624:	trap_R_AddRefEntityToScene( &ent );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 625
;625:}
LABELV $266
endproc UI_PlayerFloatSprite 140 12
export UI_MachinegunSpinAngle
proc UI_MachinegunSpinAngle 28 4
line 633
;626:
;627:
;628:/*
;629:======================
;630:UI_MachinegunSpinAngle
;631:======================
;632:*/
;633:float	UI_MachinegunSpinAngle( playerInfo_t *pi ) {
line 639
;634:	int		delta;
;635:	float	angle;
;636:	float	speed;
;637:	int		torsoAnim;
;638:
;639:	delta = dp_realtime - pi->barrelTime;
ADDRLP4 4
ADDRGP4 dp_realtime
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 1100
ADDP4
INDIRI4
SUBI4
ASGNI4
line 640
;640:	if ( pi->barrelSpinning ) {
ADDRFP4 0
INDIRP4
CNSTI4 1092
ADDP4
INDIRI4
CNSTI4 0
EQI4 $274
line 641
;641:		angle = pi->barrelAngle + delta * SPIN_SPEED;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 1096
ADDP4
INDIRF4
CNSTF4 1063675494
ADDRLP4 4
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 642
;642:	} else {
ADDRGP4 $275
JUMPV
LABELV $274
line 643
;643:		if ( delta > COAST_TIME ) {
ADDRLP4 4
INDIRI4
CNSTI4 1000
LEI4 $276
line 644
;644:			delta = COAST_TIME;
ADDRLP4 4
CNSTI4 1000
ASGNI4
line 645
;645:		}
LABELV $276
line 647
;646:
;647:		speed = 0.5 * ( SPIN_SPEED + (float)( COAST_TIME - delta ) / COAST_TIME );
ADDRLP4 12
CNSTF4 1056964608
CNSTI4 1000
ADDRLP4 4
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1148846080
DIVF4
CNSTF4 1063675494
ADDF4
MULF4
ASGNF4
line 648
;648:		angle = pi->barrelAngle + delta * speed;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 1096
ADDP4
INDIRF4
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
line 649
;649:	}
LABELV $275
line 651
;650:
;651:	torsoAnim = pi->torsoAnim  & ~ANIM_TOGGLEBIT;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1048
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 652
;652:	if( torsoAnim == TORSO_ATTACK2 ) {
ADDRLP4 0
INDIRI4
CNSTI4 8
NEI4 $278
line 653
;653:		torsoAnim = TORSO_ATTACK;
ADDRLP4 0
CNSTI4 7
ASGNI4
line 654
;654:	}
LABELV $278
line 655
;655:	if ( pi->barrelSpinning == !(torsoAnim == TORSO_ATTACK) ) {
ADDRLP4 0
INDIRI4
CNSTI4 7
EQI4 $283
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRGP4 $284
JUMPV
LABELV $283
ADDRLP4 16
CNSTI4 0
ASGNI4
LABELV $284
ADDRFP4 0
INDIRP4
CNSTI4 1092
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $280
line 656
;656:		pi->barrelTime = dp_realtime;
ADDRFP4 0
INDIRP4
CNSTI4 1100
ADDP4
ADDRGP4 dp_realtime
INDIRI4
ASGNI4
line 657
;657:		pi->barrelAngle = AngleMod( angle );
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 1096
ADDP4
ADDRLP4 20
INDIRF4
ASGNF4
line 658
;658:		pi->barrelSpinning = !!(torsoAnim == TORSO_ATTACK);
ADDRLP4 0
INDIRI4
CNSTI4 7
NEI4 $286
ADDRLP4 24
CNSTI4 1
ASGNI4
ADDRGP4 $287
JUMPV
LABELV $286
ADDRLP4 24
CNSTI4 0
ASGNI4
LABELV $287
ADDRFP4 0
INDIRP4
CNSTI4 1092
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 659
;659:	}
LABELV $280
line 661
;660:
;661:	return angle;
ADDRLP4 8
INDIRF4
RETF4
LABELV $273
endproc UI_MachinegunSpinAngle 28 4
lit
align 4
LABELV $289
byte 4 3246391296
byte 4 3246391296
byte 4 3250585600
align 4
LABELV $290
byte 4 1098907648
byte 4 1098907648
byte 4 1107296256
export UI_DrawPlayer
code
proc UI_DrawPlayer 1304 28
line 670
;662:}
;663:
;664:
;665:/*
;666:===============
;667:UI_DrawPlayer
;668:===============
;669:*/
;670:void UI_DrawPlayer( float x, float y, float w, float h, playerInfo_t *pi, int time ) {
line 680
;671:	refdef_t		refdef;
;672:	refEntity_t		legs;
;673:	refEntity_t		torso;
;674:	refEntity_t		head;
;675:	refEntity_t		gun;
;676:	refEntity_t		barrel;
;677:	refEntity_t		flash;
;678:	vec3_t			origin;
;679:	int				renderfx;
;680:	vec3_t			mins = {-16, -16, -24};
ADDRLP4 1084
ADDRGP4 $289
INDIRB
ASGNB 12
line 681
;681:	vec3_t			maxs = {16, 16, 32};
ADDRLP4 1096
ADDRGP4 $290
INDIRB
ASGNB 12
line 685
;682:	float			len;
;683:	float			xx;
;684:
;685:	if ( !pi->legsModel || !pi->torsoModel || !pi->headModel || !pi->animations[0].numFrames ) {
ADDRLP4 1256
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 1260
CNSTI4 0
ASGNI4
ADDRLP4 1256
INDIRP4
INDIRI4
ADDRLP4 1260
INDIRI4
EQI4 $295
ADDRLP4 1256
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ADDRLP4 1260
INDIRI4
EQI4 $295
ADDRLP4 1256
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
ADDRLP4 1260
INDIRI4
EQI4 $295
ADDRLP4 1256
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
ADDRLP4 1260
INDIRI4
NEI4 $291
LABELV $295
line 686
;686:		return;
ADDRGP4 $288
JUMPV
LABELV $291
line 689
;687:	}
;688:
;689:	dp_realtime = time;
ADDRGP4 dp_realtime
ADDRFP4 20
INDIRI4
ASGNI4
line 691
;690:
;691:	if ( pi->pendingWeapon != -1 && dp_realtime > pi->weaponTimer ) {
ADDRLP4 1264
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 1264
INDIRP4
CNSTI4 1060
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $296
ADDRGP4 dp_realtime
INDIRI4
ADDRLP4 1264
INDIRP4
CNSTI4 1064
ADDP4
INDIRI4
LEI4 $296
line 692
;692:		pi->weapon = pi->pendingWeapon;
ADDRLP4 1268
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 1268
INDIRP4
CNSTI4 1052
ADDP4
ADDRLP4 1268
INDIRP4
CNSTI4 1060
ADDP4
INDIRI4
ASGNI4
line 693
;693:		pi->lastWeapon = pi->pendingWeapon;
ADDRLP4 1272
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 1272
INDIRP4
CNSTI4 1056
ADDP4
ADDRLP4 1272
INDIRP4
CNSTI4 1060
ADDP4
INDIRI4
ASGNI4
line 694
;694:		pi->pendingWeapon = -1;
ADDRFP4 16
INDIRP4
CNSTI4 1060
ADDP4
CNSTI4 -1
ASGNI4
line 695
;695:		pi->weaponTimer = 0;
ADDRFP4 16
INDIRP4
CNSTI4 1064
ADDP4
CNSTI4 0
ASGNI4
line 696
;696:		if( pi->currentWeapon != pi->weapon ) {
ADDRLP4 1276
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 1276
INDIRP4
CNSTI4 1040
ADDP4
INDIRI4
ADDRLP4 1276
INDIRP4
CNSTI4 1052
ADDP4
INDIRI4
EQI4 $298
line 697
;697:			trap_S_StartLocalSound( weaponChangeSound, CHAN_LOCAL );
ADDRGP4 weaponChangeSound
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 698
;698:		}
LABELV $298
line 699
;699:	}
LABELV $296
line 701
;700:
;701:	UI_AdjustFrom640( &x, &y, &w, &h );
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRFP4 8
ARGP4
ADDRFP4 12
ARGP4
ADDRGP4 UI_AdjustFrom640
CALLV
pop
line 703
;702:
;703:	y -= jumpHeight;
ADDRFP4 4
ADDRFP4 4
INDIRF4
ADDRGP4 jumpHeight
INDIRF4
SUBF4
ASGNF4
line 705
;704:
;705:	memset( &refdef, 0, sizeof( refdef ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 368
ARGI4
ADDRGP4 memset
CALLP4
pop
line 706
;706:	memset( &legs, 0, sizeof(legs) );
ADDRLP4 380
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 707
;707:	memset( &torso, 0, sizeof(torso) );
ADDRLP4 520
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 708
;708:	memset( &head, 0, sizeof(head) );
ADDRLP4 660
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 710
;709:
;710:	refdef.rdflags = RDF_NOWORLDMODEL;
ADDRLP4 0+76
CNSTI4 1
ASGNI4
line 712
;711:
;712:	AxisClear( refdef.viewaxis );
ADDRLP4 0+36
ARGP4
ADDRGP4 AxisClear
CALLV
pop
line 714
;713:
;714:	refdef.x = x;
ADDRLP4 0
ADDRFP4 0
INDIRF4
CVFI4 4
ASGNI4
line 715
;715:	refdef.y = y;
ADDRLP4 0+4
ADDRFP4 4
INDIRF4
CVFI4 4
ASGNI4
line 716
;716:	refdef.width = w;
ADDRLP4 0+8
ADDRFP4 8
INDIRF4
CVFI4 4
ASGNI4
line 717
;717:	refdef.height = h;
ADDRLP4 0+12
ADDRFP4 12
INDIRF4
CVFI4 4
ASGNI4
line 719
;718:
;719:	refdef.fov_x = (int)((float)refdef.width / 640.0f * 90.0f);
ADDRLP4 0+16
CNSTF4 1119092736
ADDRLP4 0+8
INDIRI4
CVIF4 4
CNSTF4 1142947840
DIVF4
MULF4
CVFI4 4
CVIF4 4
ASGNF4
line 720
;720:	xx = refdef.width / tan( refdef.fov_x / 360 * M_PI );
CNSTF4 1078530011
ADDRLP4 0+16
INDIRF4
CNSTF4 1135869952
DIVF4
MULF4
ARGF4
ADDRLP4 1268
ADDRGP4 tan
CALLF4
ASGNF4
ADDRLP4 1252
ADDRLP4 0+8
INDIRI4
CVIF4 4
ADDRLP4 1268
INDIRF4
DIVF4
ASGNF4
line 721
;721:	refdef.fov_y = atan2( refdef.height, xx );
ADDRLP4 0+12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 1252
INDIRF4
ARGF4
ADDRLP4 1272
ADDRGP4 atan2
CALLF4
ASGNF4
ADDRLP4 0+20
ADDRLP4 1272
INDIRF4
ASGNF4
line 722
;722:	refdef.fov_y *= ( 360 / M_PI );
ADDRLP4 0+20
CNSTF4 1122316001
ADDRLP4 0+20
INDIRF4
MULF4
ASGNF4
line 725
;723:
;724:	// calculate distance so the player nearly fills the box
;725:	len = 0.7 * ( maxs[2] - mins[2] );		
ADDRLP4 1248
CNSTF4 1060320051
ADDRLP4 1096+8
INDIRF4
ADDRLP4 1084+8
INDIRF4
SUBF4
MULF4
ASGNF4
line 726
;726:	origin[0] = len / tan( DEG2RAD(refdef.fov_x) * 0.5 );
CNSTF4 1056964608
CNSTF4 1078530011
ADDRLP4 0+16
INDIRF4
MULF4
CNSTF4 1127481344
DIVF4
MULF4
ARGF4
ADDRLP4 1276
ADDRGP4 tan
CALLF4
ASGNF4
ADDRLP4 368
ADDRLP4 1248
INDIRF4
ADDRLP4 1276
INDIRF4
DIVF4
ASGNF4
line 727
;727:	origin[1] = 0.5 * ( mins[1] + maxs[1] );
ADDRLP4 368+4
CNSTF4 1056964608
ADDRLP4 1084+4
INDIRF4
ADDRLP4 1096+4
INDIRF4
ADDF4
MULF4
ASGNF4
line 728
;728:	origin[2] = -0.5 * ( mins[2] + maxs[2] );
ADDRLP4 368+8
CNSTF4 3204448256
ADDRLP4 1084+8
INDIRF4
ADDRLP4 1096+8
INDIRF4
ADDF4
MULF4
ASGNF4
line 730
;729:
;730:	refdef.time = dp_realtime;
ADDRLP4 0+72
ADDRGP4 dp_realtime
INDIRI4
ASGNI4
line 732
;731:
;732:	trap_R_ClearScene();
ADDRGP4 trap_R_ClearScene
CALLV
pop
line 735
;733:
;734:	// get the rotation information
;735:	UI_PlayerAngles( pi, legs.axis, torso.axis, head.axis );
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 380+28
ARGP4
ADDRLP4 520+28
ARGP4
ADDRLP4 660+28
ARGP4
ADDRGP4 UI_PlayerAngles
CALLV
pop
line 738
;736:	
;737:	// get the animation state (after rotation, to allow feet shuffle)
;738:	UI_PlayerAnimation( pi, &legs.oldframe, &legs.frame, &legs.backlerp,
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 380+96
ARGP4
ADDRLP4 380+80
ARGP4
ADDRLP4 380+100
ARGP4
ADDRLP4 520+96
ARGP4
ADDRLP4 520+80
ARGP4
ADDRLP4 520+100
ARGP4
ADDRGP4 UI_PlayerAnimation
CALLV
pop
line 741
;739:		 &torso.oldframe, &torso.frame, &torso.backlerp );
;740:
;741:	renderfx = RF_LIGHTING_ORIGIN | RF_NOSHADOW;
ADDRLP4 800
CNSTI4 192
ASGNI4
line 746
;742:
;743:	//
;744:	// add the legs
;745:	//
;746:	legs.hModel = pi->legsModel;
ADDRLP4 380+8
ADDRFP4 16
INDIRP4
INDIRI4
ASGNI4
line 747
;747:	legs.customSkin = pi->legsSkin;
ADDRLP4 380+108
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 749
;748:
;749:	VectorCopy( origin, legs.origin );
ADDRLP4 380+68
ADDRLP4 368
INDIRB
ASGNB 12
line 751
;750:
;751:	VectorCopy( origin, legs.lightingOrigin );
ADDRLP4 380+12
ADDRLP4 368
INDIRB
ASGNB 12
line 752
;752:	legs.renderfx = renderfx;
ADDRLP4 380+4
ADDRLP4 800
INDIRI4
ASGNI4
line 753
;753:	VectorCopy (legs.origin, legs.oldorigin);
ADDRLP4 380+84
ADDRLP4 380+68
INDIRB
ASGNB 12
line 755
;754:
;755:	trap_R_AddRefEntityToScene( &legs );
ADDRLP4 380
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 757
;756:
;757:	if (!legs.hModel) {
ADDRLP4 380+8
INDIRI4
CNSTI4 0
NEI4 $338
line 758
;758:		return;
ADDRGP4 $288
JUMPV
LABELV $338
line 764
;759:	}
;760:
;761:	//
;762:	// add the torso
;763:	//
;764:	torso.hModel = pi->torsoModel;
ADDRLP4 520+8
ADDRFP4 16
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ASGNI4
line 765
;765:	if (!torso.hModel) {
ADDRLP4 520+8
INDIRI4
CNSTI4 0
NEI4 $342
line 766
;766:		return;
ADDRGP4 $288
JUMPV
LABELV $342
line 769
;767:	}
;768:
;769:	torso.customSkin = pi->torsoSkin;
ADDRLP4 520+108
ADDRFP4 16
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ASGNI4
line 771
;770:
;771:	VectorCopy( origin, torso.lightingOrigin );
ADDRLP4 520+12
ADDRLP4 368
INDIRB
ASGNB 12
line 773
;772:
;773:	UI_PositionRotatedEntityOnTag( &torso, &legs, pi->legsModel, "tag_torso");
ADDRLP4 520
ARGP4
ADDRLP4 380
ARGP4
ADDRFP4 16
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $347
ARGP4
ADDRGP4 UI_PositionRotatedEntityOnTag
CALLV
pop
line 775
;774:
;775:	torso.renderfx = renderfx;
ADDRLP4 520+4
ADDRLP4 800
INDIRI4
ASGNI4
line 777
;776:
;777:	trap_R_AddRefEntityToScene( &torso );
ADDRLP4 520
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 782
;778:
;779:	//
;780:	// add the head
;781:	//
;782:	head.hModel = pi->headModel;
ADDRLP4 660+8
ADDRFP4 16
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
ASGNI4
line 783
;783:	if (!head.hModel) {
ADDRLP4 660+8
INDIRI4
CNSTI4 0
NEI4 $350
line 784
;784:		return;
ADDRGP4 $288
JUMPV
LABELV $350
line 786
;785:	}
;786:	head.customSkin = pi->headSkin;
ADDRLP4 660+108
ADDRFP4 16
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
ASGNI4
line 788
;787:
;788:	VectorCopy( origin, head.lightingOrigin );
ADDRLP4 660+12
ADDRLP4 368
INDIRB
ASGNB 12
line 790
;789:
;790:	UI_PositionRotatedEntityOnTag( &head, &torso, pi->torsoModel, "tag_head");
ADDRLP4 660
ARGP4
ADDRLP4 520
ARGP4
ADDRFP4 16
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRGP4 $355
ARGP4
ADDRGP4 UI_PositionRotatedEntityOnTag
CALLV
pop
line 792
;791:
;792:	head.renderfx = renderfx;
ADDRLP4 660+4
ADDRLP4 800
INDIRI4
ASGNI4
line 794
;793:
;794:	trap_R_AddRefEntityToScene( &head );
ADDRLP4 660
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 799
;795:
;796:	//
;797:	// add the gun
;798:	//
;799:	if ( pi->currentWeapon != WP_NONE ) {
ADDRFP4 16
INDIRP4
CNSTI4 1040
ADDP4
INDIRI4
CNSTI4 0
EQI4 $357
line 800
;800:		memset( &gun, 0, sizeof(gun) );
ADDRLP4 804
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 801
;801:		gun.hModel = pi->weaponModel;
ADDRLP4 804+8
ADDRFP4 16
INDIRP4
CNSTI4 988
ADDP4
INDIRI4
ASGNI4
line 802
;802:		VectorCopy( origin, gun.lightingOrigin );
ADDRLP4 804+12
ADDRLP4 368
INDIRB
ASGNB 12
line 803
;803:		UI_PositionEntityOnTag( &gun, &torso, pi->torsoModel, "tag_weapon");
ADDRLP4 804
ARGP4
ADDRLP4 520
ARGP4
ADDRFP4 16
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRGP4 $361
ARGP4
ADDRGP4 UI_PositionEntityOnTag
CALLV
pop
line 804
;804:		gun.renderfx = renderfx;
ADDRLP4 804+4
ADDRLP4 800
INDIRI4
ASGNI4
line 805
;805:		trap_R_AddRefEntityToScene( &gun );
ADDRLP4 804
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 806
;806:	}
LABELV $357
line 811
;807:
;808:	//
;809:	// add the spinning barrel
;810:	//
;811:	if ( pi->realWeapon == WP_MACHINEGUN || pi->realWeapon == WP_GAUNTLET || pi->realWeapon == WP_BFG ) {
ADDRLP4 1280
ADDRFP4 16
INDIRP4
CNSTI4 1104
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1280
INDIRI4
CNSTI4 2
EQI4 $366
ADDRLP4 1280
INDIRI4
CNSTI4 1
EQI4 $366
ADDRLP4 1280
INDIRI4
CNSTI4 9
NEI4 $363
LABELV $366
line 814
;812:		vec3_t	angles;
;813:
;814:		memset( &barrel, 0, sizeof(barrel) );
ADDRLP4 944
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 815
;815:		VectorCopy( origin, barrel.lightingOrigin );
ADDRLP4 944+12
ADDRLP4 368
INDIRB
ASGNB 12
line 816
;816:		barrel.renderfx = renderfx;
ADDRLP4 944+4
ADDRLP4 800
INDIRI4
ASGNI4
line 818
;817:
;818:		barrel.hModel = pi->barrelModel;
ADDRLP4 944+8
ADDRFP4 16
INDIRP4
CNSTI4 992
ADDP4
INDIRI4
ASGNI4
line 819
;819:		angles[YAW] = 0;
ADDRLP4 1284+4
CNSTF4 0
ASGNF4
line 820
;820:		angles[PITCH] = 0;
ADDRLP4 1284
CNSTF4 0
ASGNF4
line 821
;821:		angles[ROLL] = UI_MachinegunSpinAngle( pi );
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 1296
ADDRGP4 UI_MachinegunSpinAngle
CALLF4
ASGNF4
ADDRLP4 1284+8
ADDRLP4 1296
INDIRF4
ASGNF4
line 822
;822:		if( pi->realWeapon == WP_GAUNTLET || pi->realWeapon == WP_BFG ) {
ADDRLP4 1300
ADDRFP4 16
INDIRP4
CNSTI4 1104
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1300
INDIRI4
CNSTI4 1
EQI4 $374
ADDRLP4 1300
INDIRI4
CNSTI4 9
NEI4 $372
LABELV $374
line 823
;823:			angles[PITCH] = angles[ROLL];
ADDRLP4 1284
ADDRLP4 1284+8
INDIRF4
ASGNF4
line 824
;824:			angles[ROLL] = 0;
ADDRLP4 1284+8
CNSTF4 0
ASGNF4
line 825
;825:		}
LABELV $372
line 826
;826:		AnglesToAxis( angles, barrel.axis );
ADDRLP4 1284
ARGP4
ADDRLP4 944+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 828
;827:
;828:		UI_PositionRotatedEntityOnTag( &barrel, &gun, pi->weaponModel, "tag_barrel");
ADDRLP4 944
ARGP4
ADDRLP4 804
ARGP4
ADDRFP4 16
INDIRP4
CNSTI4 988
ADDP4
INDIRI4
ARGI4
ADDRGP4 $378
ARGP4
ADDRGP4 UI_PositionRotatedEntityOnTag
CALLV
pop
line 830
;829:
;830:		trap_R_AddRefEntityToScene( &barrel );
ADDRLP4 944
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 831
;831:	}
LABELV $363
line 836
;832:
;833:	//
;834:	// add muzzle flash
;835:	//
;836:	if ( dp_realtime <= pi->muzzleFlashTime ) {
ADDRGP4 dp_realtime
INDIRI4
ADDRFP4 16
INDIRP4
CNSTI4 1012
ADDP4
INDIRI4
GTI4 $379
line 837
;837:		if ( pi->flashModel ) {
ADDRFP4 16
INDIRP4
CNSTI4 996
ADDP4
INDIRI4
CNSTI4 0
EQI4 $381
line 838
;838:			memset( &flash, 0, sizeof(flash) );
ADDRLP4 1108
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 839
;839:			flash.hModel = pi->flashModel;
ADDRLP4 1108+8
ADDRFP4 16
INDIRP4
CNSTI4 996
ADDP4
INDIRI4
ASGNI4
line 840
;840:			VectorCopy( origin, flash.lightingOrigin );
ADDRLP4 1108+12
ADDRLP4 368
INDIRB
ASGNB 12
line 841
;841:			UI_PositionEntityOnTag( &flash, &gun, pi->weaponModel, "tag_flash");
ADDRLP4 1108
ARGP4
ADDRLP4 804
ARGP4
ADDRFP4 16
INDIRP4
CNSTI4 988
ADDP4
INDIRI4
ARGI4
ADDRGP4 $385
ARGP4
ADDRGP4 UI_PositionEntityOnTag
CALLV
pop
line 842
;842:			flash.renderfx = renderfx;
ADDRLP4 1108+4
ADDRLP4 800
INDIRI4
ASGNI4
line 843
;843:			trap_R_AddRefEntityToScene( &flash );
ADDRLP4 1108
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 844
;844:		}
LABELV $381
line 847
;845:
;846:		// make a dlight for the flash
;847:		if ( pi->flashDlightColor[0] || pi->flashDlightColor[1] || pi->flashDlightColor[2] ) {
ADDRLP4 1284
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 1288
CNSTF4 0
ASGNF4
ADDRLP4 1284
INDIRP4
CNSTI4 1000
ADDP4
INDIRF4
ADDRLP4 1288
INDIRF4
NEF4 $390
ADDRLP4 1284
INDIRP4
CNSTI4 1004
ADDP4
INDIRF4
ADDRLP4 1288
INDIRF4
NEF4 $390
ADDRLP4 1284
INDIRP4
CNSTI4 1008
ADDP4
INDIRF4
ADDRLP4 1288
INDIRF4
EQF4 $387
LABELV $390
line 848
;848:			trap_R_AddLightToScene( flash.origin, 200 + (rand()&31), pi->flashDlightColor[0],
ADDRLP4 1292
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1108+68
ARGP4
ADDRLP4 1292
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 200
ADDI4
CVIF4 4
ARGF4
ADDRLP4 1296
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 1296
INDIRP4
CNSTI4 1000
ADDP4
INDIRF4
ARGF4
ADDRLP4 1296
INDIRP4
CNSTI4 1004
ADDP4
INDIRF4
ARGF4
ADDRLP4 1296
INDIRP4
CNSTI4 1008
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 850
;849:				pi->flashDlightColor[1], pi->flashDlightColor[2] );
;850:		}
LABELV $387
line 851
;851:	}
LABELV $379
line 856
;852:
;853:	//
;854:	// add the chat icon
;855:	//
;856:	if ( pi->chat ) {
ADDRFP4 16
INDIRP4
CNSTI4 1084
ADDP4
INDIRI4
CNSTI4 0
EQI4 $392
line 857
;857:		UI_PlayerFloatSprite( pi, origin, trap_R_RegisterShaderNoMip( "sprites/balloon3" ) );
ADDRGP4 $394
ARGP4
ADDRLP4 1284
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 368
ARGP4
ADDRLP4 1284
INDIRI4
ARGI4
ADDRGP4 UI_PlayerFloatSprite
CALLV
pop
line 858
;858:	}
LABELV $392
line 863
;859:
;860:	//
;861:	// add an accent light
;862:	//
;863:	origin[0] -= 100;	// + = behind, - = in front
ADDRLP4 368
ADDRLP4 368
INDIRF4
CNSTF4 1120403456
SUBF4
ASGNF4
line 864
;864:	origin[1] += 100;	// + = left, - = right
ADDRLP4 368+4
ADDRLP4 368+4
INDIRF4
CNSTF4 1120403456
ADDF4
ASGNF4
line 865
;865:	origin[2] += 100;	// + = above, - = below
ADDRLP4 368+8
ADDRLP4 368+8
INDIRF4
CNSTF4 1120403456
ADDF4
ASGNF4
line 866
;866:	trap_R_AddLightToScene( origin, 500, 1.0, 1.0, 1.0 );
ADDRLP4 368
ARGP4
CNSTF4 1140457472
ARGF4
ADDRLP4 1284
CNSTF4 1065353216
ASGNF4
ADDRLP4 1284
INDIRF4
ARGF4
ADDRLP4 1284
INDIRF4
ARGF4
ADDRLP4 1284
INDIRF4
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 868
;867:
;868:	origin[0] -= 100;
ADDRLP4 368
ADDRLP4 368
INDIRF4
CNSTF4 1120403456
SUBF4
ASGNF4
line 869
;869:	origin[1] -= 100;
ADDRLP4 368+4
ADDRLP4 368+4
INDIRF4
CNSTF4 1120403456
SUBF4
ASGNF4
line 870
;870:	origin[2] -= 100;
ADDRLP4 368+8
ADDRLP4 368+8
INDIRF4
CNSTF4 1120403456
SUBF4
ASGNF4
line 871
;871:	trap_R_AddLightToScene( origin, 500, 1.0, 0.0, 0.0 );
ADDRLP4 368
ARGP4
CNSTF4 1140457472
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 1288
CNSTF4 0
ASGNF4
ADDRLP4 1288
INDIRF4
ARGF4
ADDRLP4 1288
INDIRF4
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 873
;872:
;873:	trap_R_RenderScene( &refdef );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_RenderScene
CALLV
pop
line 874
;874:}
LABELV $288
endproc UI_DrawPlayer 1304 28
proc UI_RegisterClientSkin 84 20
line 882
;875:
;876:
;877:/*
;878:==========================
;879:UI_RegisterClientSkin
;880:==========================
;881:*/
;882:static qboolean UI_RegisterClientSkin( playerInfo_t *pi, const char *modelName, const char *skinName ) {
line 885
;883:	char		filename[MAX_QPATH];
;884:
;885:	Com_sprintf( filename, sizeof( filename ), "models/players/%s/lower_%s.skin", modelName, skinName );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $400
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 886
;886:	pi->legsSkin = trap_R_RegisterSkin( filename );
ADDRLP4 0
ARGP4
ADDRLP4 64
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 64
INDIRI4
ASGNI4
line 888
;887:
;888:	Com_sprintf( filename, sizeof( filename ), "models/players/%s/upper_%s.skin", modelName, skinName );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $401
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 889
;889:	pi->torsoSkin = trap_R_RegisterSkin( filename );
ADDRLP4 0
ARGP4
ADDRLP4 68
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
ADDRLP4 68
INDIRI4
ASGNI4
line 891
;890:
;891:	Com_sprintf( filename, sizeof( filename ), "models/players/%s/head_%s.skin", modelName, skinName );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $402
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 892
;892:	pi->headSkin = trap_R_RegisterSkin( filename );
ADDRLP4 0
ARGP4
ADDRLP4 72
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 72
INDIRI4
ASGNI4
line 894
;893:
;894:	if ( !pi->legsSkin || !pi->torsoSkin || !pi->headSkin ) {
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
CNSTI4 0
ASGNI4
ADDRLP4 76
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 80
INDIRI4
EQI4 $406
ADDRLP4 76
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ADDRLP4 80
INDIRI4
EQI4 $406
ADDRLP4 76
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
ADDRLP4 80
INDIRI4
NEI4 $403
LABELV $406
line 895
;895:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $399
JUMPV
LABELV $403
line 898
;896:	}
;897:
;898:	return qtrue;
CNSTI4 1
RETI4
LABELV $399
endproc UI_RegisterClientSkin 84 20
proc UI_ParseAnimationFile 20068 12
line 907
;899:}
;900:
;901:
;902:/*
;903:======================
;904:UI_ParseAnimationFile
;905:======================
;906:*/
;907:static qboolean UI_ParseAnimationFile( const char *filename, animation_t *animations ) {
line 917
;908:	char		*text_p, *prev;
;909:	int			len;
;910:	int			i;
;911:	char		*token;
;912:	float		fps;
;913:	int			skip;
;914:	char		text[20000];
;915:	fileHandle_t	f;
;916:
;917:	memset( animations, 0, sizeof( animation_t ) * MAX_ANIMATIONS );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 868
ARGI4
ADDRGP4 memset
CALLP4
pop
line 920
;918:
;919:	// load the file
;920:	len = trap_FS_FOpenFile( filename, &f, FS_READ );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20028
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 20032
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 20032
INDIRI4
ASGNI4
line 921
;921:	if ( len <= 0 ) {
ADDRLP4 24
INDIRI4
CNSTI4 0
GTI4 $408
line 922
;922:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $407
JUMPV
LABELV $408
line 924
;923:	}
;924:	if ( len >= ( sizeof( text ) - 1 ) ) {
ADDRLP4 24
INDIRI4
CVIU4 4
CNSTU4 19999
LTU4 $410
line 925
;925:		Com_Printf( "File %s too long\n", filename );
ADDRGP4 $412
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 926
;926:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $407
JUMPV
LABELV $410
line 928
;927:	}
;928:	trap_FS_Read( text, len, f );
ADDRLP4 28
ARGP4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 20028
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 929
;929:	text[len] = 0;
ADDRLP4 24
INDIRI4
ADDRLP4 28
ADDP4
CNSTI1 0
ASGNI1
line 930
;930:	trap_FS_FCloseFile( f );
ADDRLP4 20028
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 933
;931:
;932:	// parse the text
;933:	text_p = text;
ADDRLP4 8
ADDRLP4 28
ASGNP4
line 934
;934:	skip = 0;	// quite the compiler warning
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRGP4 $414
JUMPV
LABELV $413
line 937
;935:
;936:	// read optional parameters
;937:	while ( 1 ) {
line 938
;938:		prev = text_p;	// so we can unget
ADDRLP4 16
ADDRLP4 8
INDIRP4
ASGNP4
line 939
;939:		token = COM_Parse( &text_p );
ADDRLP4 8
ARGP4
ADDRLP4 20036
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20036
INDIRP4
ASGNP4
line 940
;940:		if ( !token ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $416
line 941
;941:			break;
ADDRGP4 $415
JUMPV
LABELV $416
line 943
;942:		}
;943:		if ( !Q_stricmp( token, "footsteps" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $420
ARGP4
ADDRLP4 20040
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20040
INDIRI4
CNSTI4 0
NEI4 $418
line 944
;944:			token = COM_Parse( &text_p );
ADDRLP4 8
ARGP4
ADDRLP4 20044
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20044
INDIRP4
ASGNP4
line 945
;945:			if ( !token ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $414
line 946
;946:				break;
ADDRGP4 $415
JUMPV
line 948
;947:			}
;948:			continue;
LABELV $418
line 949
;949:		} else if ( !Q_stricmp( token, "headoffset" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $425
ARGP4
ADDRLP4 20044
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20044
INDIRI4
CNSTI4 0
NEI4 $423
line 950
;950:			for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $426
line 951
;951:				token = COM_Parse( &text_p );
ADDRLP4 8
ARGP4
ADDRLP4 20048
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20048
INDIRP4
ASGNP4
line 952
;952:				if ( !token ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $430
line 953
;953:					break;
ADDRGP4 $414
JUMPV
LABELV $430
line 955
;954:				}
;955:			}
LABELV $427
line 950
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 3
LTI4 $426
line 956
;956:			continue;
ADDRGP4 $414
JUMPV
LABELV $423
line 957
;957:		} else if ( !Q_stricmp( token, "sex" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $434
ARGP4
ADDRLP4 20048
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20048
INDIRI4
CNSTI4 0
NEI4 $432
line 958
;958:			token = COM_Parse( &text_p );
ADDRLP4 8
ARGP4
ADDRLP4 20052
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20052
INDIRP4
ASGNP4
line 959
;959:			if ( !token ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $414
line 960
;960:				break;
ADDRGP4 $415
JUMPV
line 962
;961:			}
;962:			continue;
LABELV $432
line 966
;963:		}
;964:
;965:		// if it is a number, start parsing animations
;966:		if ( token[0] >= '0' && token[0] <= '9' ) {
ADDRLP4 20052
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 20052
INDIRI4
CNSTI4 48
LTI4 $437
ADDRLP4 20052
INDIRI4
CNSTI4 57
GTI4 $437
line 967
;967:			text_p = prev;	// unget the token
ADDRLP4 8
ADDRLP4 16
INDIRP4
ASGNP4
line 968
;968:			break;
ADDRGP4 $415
JUMPV
LABELV $437
line 971
;969:		}
;970:
;971:		Com_Printf( "unknown token '%s' is %s\n", token, filename );
ADDRGP4 $439
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 972
;972:	}
LABELV $414
line 937
ADDRGP4 $413
JUMPV
LABELV $415
line 975
;973:
;974:	// read information for each frame
;975:	for ( i = 0 ; i < MAX_ANIMATIONS ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $440
line 977
;976:
;977:		token = COM_Parse( &text_p );
ADDRLP4 8
ARGP4
ADDRLP4 20036
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20036
INDIRP4
ASGNP4
line 978
;978:		if ( !token ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $444
line 979
;979:			break;
ADDRGP4 $442
JUMPV
LABELV $444
line 981
;980:		}
;981:		animations[i].firstFrame = atoi( token );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20040
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTI4 28
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 4
INDIRP4
ADDP4
ADDRLP4 20040
INDIRI4
ASGNI4
line 983
;982:		// leg only frames are adjusted to not count the upper body only frames
;983:		if ( i == LEGS_WALKCR ) {
ADDRLP4 4
INDIRI4
CNSTI4 13
NEI4 $446
line 984
;984:			skip = animations[LEGS_WALKCR].firstFrame - animations[TORSO_GESTURE].firstFrame;
ADDRLP4 20044
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 20044
INDIRP4
CNSTI4 364
ADDP4
INDIRI4
ADDRLP4 20044
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
SUBI4
ASGNI4
line 985
;985:		}
LABELV $446
line 986
;986:		if ( i >= LEGS_WALKCR ) {
ADDRLP4 4
INDIRI4
CNSTI4 13
LTI4 $448
line 987
;987:			animations[i].firstFrame -= skip;
ADDRLP4 20044
CNSTI4 28
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 4
INDIRP4
ADDP4
ASGNP4
ADDRLP4 20044
INDIRP4
ADDRLP4 20044
INDIRP4
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 988
;988:		}
LABELV $448
line 990
;989:
;990:		token = COM_Parse( &text_p );
ADDRLP4 8
ARGP4
ADDRLP4 20044
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20044
INDIRP4
ASGNP4
line 991
;991:		if ( !token ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $450
line 992
;992:			break;
ADDRGP4 $442
JUMPV
LABELV $450
line 994
;993:		}
;994:		animations[i].numFrames = atoi( token );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20048
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTI4 28
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 4
INDIRP4
ADDP4
CNSTI4 4
ADDP4
ADDRLP4 20048
INDIRI4
ASGNI4
line 996
;995:
;996:		token = COM_Parse( &text_p );
ADDRLP4 8
ARGP4
ADDRLP4 20052
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20052
INDIRP4
ASGNP4
line 997
;997:		if ( !token ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $452
line 998
;998:			break;
ADDRGP4 $442
JUMPV
LABELV $452
line 1000
;999:		}
;1000:		animations[i].loopFrames = atoi( token );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20056
ADDRGP4 atoi
CALLI4
ASGNI4
CNSTI4 28
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 4
INDIRP4
ADDP4
CNSTI4 8
ADDP4
ADDRLP4 20056
INDIRI4
ASGNI4
line 1002
;1001:
;1002:		token = COM_Parse( &text_p );
ADDRLP4 8
ARGP4
ADDRLP4 20060
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20060
INDIRP4
ASGNP4
line 1003
;1003:		if ( !token ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $454
line 1004
;1004:			break;
ADDRGP4 $442
JUMPV
LABELV $454
line 1006
;1005:		}
;1006:		fps = atof( token );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20064
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 12
ADDRLP4 20064
INDIRF4
ASGNF4
line 1007
;1007:		if ( fps == 0 ) {
ADDRLP4 12
INDIRF4
CNSTF4 0
NEF4 $456
line 1008
;1008:			fps = 1;
ADDRLP4 12
CNSTF4 1065353216
ASGNF4
line 1009
;1009:		}
LABELV $456
line 1010
;1010:		animations[i].frameLerp = 1000 / fps;
CNSTI4 28
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 4
INDIRP4
ADDP4
CNSTI4 12
ADDP4
CNSTF4 1148846080
ADDRLP4 12
INDIRF4
DIVF4
CVFI4 4
ASGNI4
line 1011
;1011:		animations[i].initialLerp = 1000 / fps;
CNSTI4 28
ADDRLP4 4
INDIRI4
MULI4
ADDRFP4 4
INDIRP4
ADDP4
CNSTI4 16
ADDP4
CNSTF4 1148846080
ADDRLP4 12
INDIRF4
DIVF4
CVFI4 4
ASGNI4
line 1012
;1012:	}
LABELV $441
line 975
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 31
LTI4 $440
LABELV $442
line 1014
;1013:
;1014:	if ( i != MAX_ANIMATIONS ) {
ADDRLP4 4
INDIRI4
CNSTI4 31
EQI4 $458
line 1015
;1015:		Com_Printf( "Error parsing animation file: %s", filename );
ADDRGP4 $460
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1016
;1016:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $407
JUMPV
LABELV $458
line 1019
;1017:	}
;1018:
;1019:	return qtrue;
CNSTI4 1
RETI4
LABELV $407
endproc UI_ParseAnimationFile 20068 12
export UI_RegisterClientModelname
proc UI_RegisterClientModelname 220 16
line 1028
;1020:}
;1021:
;1022:
;1023:/*
;1024:==========================
;1025:UI_RegisterClientModelname
;1026:==========================
;1027:*/
;1028:qboolean UI_RegisterClientModelname( playerInfo_t *pi, const char *modelSkinName ) {
line 1034
;1029:	char		modelName[MAX_QPATH];
;1030:	char		skinName[MAX_QPATH];
;1031:	char		filename[MAX_QPATH];
;1032:	char		*slash;
;1033:
;1034:	pi->torsoModel = 0;
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTI4 0
ASGNI4
line 1035
;1035:	pi->headModel = 0;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
CNSTI4 0
ASGNI4
line 1037
;1036:
;1037:	if ( !modelSkinName[0] ) {
ADDRFP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $462
line 1038
;1038:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $461
JUMPV
LABELV $462
line 1041
;1039:	}
;1040:
;1041:	Q_strncpyz( modelName, modelSkinName, sizeof( modelName ) );
ADDRLP4 64
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1043
;1042:
;1043:	slash = strchr( modelName, '/' );
ADDRLP4 64
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 196
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 192
ADDRLP4 196
INDIRP4
ASGNP4
line 1044
;1044:	if ( !slash ) {
ADDRLP4 192
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $464
line 1046
;1045:		// modelName did not include a skin name
;1046:		Q_strncpyz( skinName, "default", sizeof( skinName ) );
ADDRLP4 128
ARGP4
ADDRGP4 $466
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1047
;1047:	} else {
ADDRGP4 $465
JUMPV
LABELV $464
line 1048
;1048:		Q_strncpyz( skinName, slash + 1, sizeof( skinName ) );
ADDRLP4 128
ARGP4
ADDRLP4 192
INDIRP4
CNSTI4 1
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1050
;1049:		// truncate modelName
;1050:		*slash = 0;
ADDRLP4 192
INDIRP4
CNSTI1 0
ASGNI1
line 1051
;1051:	}
LABELV $465
line 1055
;1052:
;1053:	// load cmodels before models so filecache works
;1054:
;1055:	Com_sprintf( filename, sizeof( filename ), "models/players/%s/lower.md3", modelName );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $467
ARGP4
ADDRLP4 64
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1056
;1056:	pi->legsModel = trap_R_RegisterModel( filename );
ADDRLP4 0
ARGP4
ADDRLP4 200
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 200
INDIRI4
ASGNI4
line 1057
;1057:	if ( !pi->legsModel ) {
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $468
line 1058
;1058:		Com_Printf( "Failed to load model file %s\n", filename );
ADDRGP4 $470
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1059
;1059:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $461
JUMPV
LABELV $468
line 1062
;1060:	}
;1061:
;1062:	Com_sprintf( filename, sizeof( filename ), "models/players/%s/upper.md3", modelName );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $471
ARGP4
ADDRLP4 64
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1063
;1063:	pi->torsoModel = trap_R_RegisterModel( filename );
ADDRLP4 0
ARGP4
ADDRLP4 204
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
ADDRLP4 204
INDIRI4
ASGNI4
line 1064
;1064:	if ( !pi->torsoModel ) {
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 0
NEI4 $472
line 1065
;1065:		Com_Printf( "Failed to load model file %s\n", filename );
ADDRGP4 $470
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1066
;1066:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $461
JUMPV
LABELV $472
line 1069
;1067:	}
;1068:
;1069:	Com_sprintf( filename, sizeof( filename ), "models/players/%s/head.md3", modelName );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $474
ARGP4
ADDRLP4 64
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1070
;1070:	pi->headModel = trap_R_RegisterModel( filename );
ADDRLP4 0
ARGP4
ADDRLP4 208
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRLP4 208
INDIRI4
ASGNI4
line 1071
;1071:	if ( !pi->headModel ) {
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
CNSTI4 0
NEI4 $475
line 1072
;1072:		Com_Printf( "Failed to load model file %s\n", filename );
ADDRGP4 $470
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1073
;1073:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $461
JUMPV
LABELV $475
line 1077
;1074:	}
;1075:
;1076:	// if any skins failed to load, fall back to default
;1077:	if ( !UI_RegisterClientSkin( pi, modelName, skinName ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 64
ARGP4
ADDRLP4 128
ARGP4
ADDRLP4 212
ADDRGP4 UI_RegisterClientSkin
CALLI4
ASGNI4
ADDRLP4 212
INDIRI4
CNSTI4 0
NEI4 $477
line 1078
;1078:		if ( !UI_RegisterClientSkin( pi, modelName, "default" ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 64
ARGP4
ADDRGP4 $466
ARGP4
ADDRLP4 216
ADDRGP4 UI_RegisterClientSkin
CALLI4
ASGNI4
ADDRLP4 216
INDIRI4
CNSTI4 0
NEI4 $479
line 1079
;1079:			Com_Printf( "Failed to load skin file: %s : %s\n", modelName, skinName );
ADDRGP4 $481
ARGP4
ADDRLP4 64
ARGP4
ADDRLP4 128
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1080
;1080:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $461
JUMPV
LABELV $479
line 1082
;1081:		}
;1082:	}
LABELV $477
line 1085
;1083:
;1084:	// load the animations
;1085:	Com_sprintf( filename, sizeof( filename ), "models/players/%s/animation.cfg", modelName );
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $482
ARGP4
ADDRLP4 64
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1086
;1086:	if ( !UI_ParseAnimationFile( filename, pi->animations ) ) {
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
ARGP4
ADDRLP4 216
ADDRGP4 UI_ParseAnimationFile
CALLI4
ASGNI4
ADDRLP4 216
INDIRI4
CNSTI4 0
NEI4 $483
line 1087
;1087:		Com_Printf( "Failed to load animation file %s\n", filename );
ADDRGP4 $485
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1088
;1088:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $461
JUMPV
LABELV $483
line 1091
;1089:	}
;1090:
;1091:	return qtrue;
CNSTI4 1
RETI4
LABELV $461
endproc UI_RegisterClientModelname 220 16
export UI_PlayerInfo_SetModel
proc UI_PlayerInfo_SetModel 12 12
line 1100
;1092:}
;1093:
;1094:
;1095:/*
;1096:===============
;1097:UI_PlayerInfo_SetModel
;1098:===============
;1099:*/
;1100:void UI_PlayerInfo_SetModel( playerInfo_t *pi, const char *model ) {
line 1101
;1101:	memset( pi, 0, sizeof(*pi) );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1108
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1102
;1102:	UI_RegisterClientModelname( pi, model );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 UI_RegisterClientModelname
CALLI4
pop
line 1103
;1103:	pi->weapon = WP_MACHINEGUN;
ADDRFP4 0
INDIRP4
CNSTI4 1052
ADDP4
CNSTI4 2
ASGNI4
line 1104
;1104:	pi->currentWeapon = pi->weapon;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 1040
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 1052
ADDP4
INDIRI4
ASGNI4
line 1105
;1105:	pi->lastWeapon = pi->weapon;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 1056
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 1052
ADDP4
INDIRI4
ASGNI4
line 1106
;1106:	pi->pendingWeapon = -1;
ADDRFP4 0
INDIRP4
CNSTI4 1060
ADDP4
CNSTI4 -1
ASGNI4
line 1107
;1107:	pi->weaponTimer = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1064
ADDP4
CNSTI4 0
ASGNI4
line 1108
;1108:	pi->chat = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 1084
ADDP4
CNSTI4 0
ASGNI4
line 1109
;1109:	pi->newModel = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 1088
ADDP4
CNSTI4 1
ASGNI4
line 1110
;1110:	UI_PlayerInfo_SetWeapon( pi, pi->weapon );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 1052
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_PlayerInfo_SetWeapon
CALLV
pop
line 1111
;1111:}
LABELV $486
endproc UI_PlayerInfo_SetModel 12 12
export UI_PlayerInfo_SetInfo
proc UI_PlayerInfo_SetInfo 36 8
line 1119
;1112:
;1113:
;1114:/*
;1115:===============
;1116:UI_PlayerInfo_SetInfo
;1117:===============
;1118:*/
;1119:void UI_PlayerInfo_SetInfo( playerInfo_t *pi, int legsAnim, int torsoAnim, vec3_t viewAngles, vec3_t moveAngles, weapon_t weaponNumber, qboolean chat ) {
line 1123
;1120:	int			currentAnim;
;1121:	weapon_t	weaponNum;
;1122:
;1123:	pi->chat = chat;
ADDRFP4 0
INDIRP4
CNSTI4 1084
ADDP4
ADDRFP4 24
INDIRI4
ASGNI4
line 1126
;1124:
;1125:	// view angles
;1126:	VectorCopy( viewAngles, pi->viewAngles );
ADDRFP4 0
INDIRP4
CNSTI4 1016
ADDP4
ADDRFP4 12
INDIRP4
INDIRB
ASGNB 12
line 1129
;1127:
;1128:	// move angles
;1129:	VectorCopy( moveAngles, pi->moveAngles );
ADDRFP4 0
INDIRP4
CNSTI4 1028
ADDP4
ADDRFP4 16
INDIRP4
INDIRB
ASGNB 12
line 1131
;1130:
;1131:	if ( pi->newModel ) {
ADDRFP4 0
INDIRP4
CNSTI4 1088
ADDP4
INDIRI4
CNSTI4 0
EQI4 $488
line 1132
;1132:		pi->newModel = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 1088
ADDP4
CNSTI4 0
ASGNI4
line 1134
;1133:
;1134:		jumpHeight = 0;
ADDRGP4 jumpHeight
CNSTF4 0
ASGNF4
line 1135
;1135:		pi->pendingLegsAnim = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1068
ADDP4
CNSTI4 0
ASGNI4
line 1136
;1136:		UI_ForceLegsAnim( pi, legsAnim );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 UI_ForceLegsAnim
CALLV
pop
line 1137
;1137:		pi->legs.yawAngle = viewAngles[YAW];
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 1138
;1138:		pi->legs.yawing = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTI4 0
ASGNI4
line 1140
;1139:
;1140:		pi->pendingTorsoAnim = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1076
ADDP4
CNSTI4 0
ASGNI4
line 1141
;1141:		UI_ForceTorsoAnim( pi, torsoAnim );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 UI_ForceTorsoAnim
CALLV
pop
line 1142
;1142:		pi->torso.yawAngle = viewAngles[YAW];
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 1143
;1143:		pi->torso.yawing = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 0
ASGNI4
line 1145
;1144:
;1145:		if ( weaponNumber != -1 ) {
ADDRFP4 20
INDIRI4
CNSTI4 -1
EQI4 $487
line 1146
;1146:			pi->weapon = weaponNumber;
ADDRFP4 0
INDIRP4
CNSTI4 1052
ADDP4
ADDRFP4 20
INDIRI4
ASGNI4
line 1147
;1147:			pi->currentWeapon = weaponNumber;
ADDRFP4 0
INDIRP4
CNSTI4 1040
ADDP4
ADDRFP4 20
INDIRI4
ASGNI4
line 1148
;1148:			pi->lastWeapon = weaponNumber;
ADDRFP4 0
INDIRP4
CNSTI4 1056
ADDP4
ADDRFP4 20
INDIRI4
ASGNI4
line 1149
;1149:			pi->pendingWeapon = -1;
ADDRFP4 0
INDIRP4
CNSTI4 1060
ADDP4
CNSTI4 -1
ASGNI4
line 1150
;1150:			pi->weaponTimer = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1064
ADDP4
CNSTI4 0
ASGNI4
line 1151
;1151:			UI_PlayerInfo_SetWeapon( pi, pi->weapon );
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 1052
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_PlayerInfo_SetWeapon
CALLV
pop
line 1152
;1152:		}
line 1154
;1153:
;1154:		return;
ADDRGP4 $487
JUMPV
LABELV $488
line 1158
;1155:	}
;1156:
;1157:	// weapon
;1158:	if ( weaponNumber == -1 ) {
ADDRFP4 20
INDIRI4
CNSTI4 -1
NEI4 $492
line 1159
;1159:		pi->pendingWeapon = -1;
ADDRFP4 0
INDIRP4
CNSTI4 1060
ADDP4
CNSTI4 -1
ASGNI4
line 1160
;1160:		pi->weaponTimer = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1064
ADDP4
CNSTI4 0
ASGNI4
line 1161
;1161:	}
ADDRGP4 $493
JUMPV
LABELV $492
line 1162
;1162:	else if ( weaponNumber != WP_NONE ) {
ADDRFP4 20
INDIRI4
CNSTI4 0
EQI4 $494
line 1163
;1163:		pi->pendingWeapon = weaponNumber;
ADDRFP4 0
INDIRP4
CNSTI4 1060
ADDP4
ADDRFP4 20
INDIRI4
ASGNI4
line 1164
;1164:		pi->weaponTimer = dp_realtime + UI_TIMER_WEAPON_DELAY;
ADDRFP4 0
INDIRP4
CNSTI4 1064
ADDP4
ADDRGP4 dp_realtime
INDIRI4
CNSTI4 250
ADDI4
ASGNI4
line 1165
;1165:	}
LABELV $494
LABELV $493
line 1166
;1166:	weaponNum = pi->lastWeapon;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 1056
ADDP4
INDIRI4
ASGNI4
line 1167
;1167:	pi->weapon = weaponNum;
ADDRFP4 0
INDIRP4
CNSTI4 1052
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 1169
;1168:
;1169:	if ( torsoAnim == BOTH_DEATH1 || legsAnim == BOTH_DEATH1 ) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRFP4 8
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $498
ADDRFP4 4
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $496
LABELV $498
line 1170
;1170:		torsoAnim = legsAnim = BOTH_DEATH1;
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRFP4 4
ADDRLP4 12
INDIRI4
ASGNI4
ADDRFP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 1171
;1171:		pi->weapon = pi->currentWeapon = WP_NONE;
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 16
INDIRP4
CNSTI4 1040
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
ADDRLP4 16
INDIRP4
CNSTI4 1052
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 1172
;1172:		UI_PlayerInfo_SetWeapon( pi, pi->weapon );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 1052
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_PlayerInfo_SetWeapon
CALLV
pop
line 1174
;1173:
;1174:		jumpHeight = 0;
ADDRGP4 jumpHeight
CNSTF4 0
ASGNF4
line 1175
;1175:		pi->pendingLegsAnim = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1068
ADDP4
CNSTI4 0
ASGNI4
line 1176
;1176:		UI_ForceLegsAnim( pi, legsAnim );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 UI_ForceLegsAnim
CALLV
pop
line 1178
;1177:
;1178:		pi->pendingTorsoAnim = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1076
ADDP4
CNSTI4 0
ASGNI4
line 1179
;1179:		UI_ForceTorsoAnim( pi, torsoAnim );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 UI_ForceTorsoAnim
CALLV
pop
line 1181
;1180:
;1181:		return;
ADDRGP4 $487
JUMPV
LABELV $496
line 1185
;1182:	}
;1183:
;1184:	// leg animation
;1185:	currentAnim = pi->legsAnim & ~ANIM_TOGGLEBIT;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1044
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 1186
;1186:	if ( legsAnim != LEGS_JUMP && ( currentAnim == LEGS_JUMP || currentAnim == LEGS_LAND ) ) {
ADDRLP4 12
CNSTI4 18
ASGNI4
ADDRFP4 4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $499
ADDRLP4 0
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $501
ADDRLP4 0
INDIRI4
CNSTI4 19
NEI4 $499
LABELV $501
line 1187
;1187:		pi->pendingLegsAnim = legsAnim;
ADDRFP4 0
INDIRP4
CNSTI4 1068
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 1188
;1188:	}
ADDRGP4 $500
JUMPV
LABELV $499
line 1189
;1189:	else if ( legsAnim != currentAnim ) {
ADDRFP4 4
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $502
line 1190
;1190:		jumpHeight = 0;
ADDRGP4 jumpHeight
CNSTF4 0
ASGNF4
line 1191
;1191:		pi->pendingLegsAnim = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1068
ADDP4
CNSTI4 0
ASGNI4
line 1192
;1192:		UI_ForceLegsAnim( pi, legsAnim );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 UI_ForceLegsAnim
CALLV
pop
line 1193
;1193:	}
LABELV $502
LABELV $500
line 1196
;1194:
;1195:	// torso animation
;1196:	if ( torsoAnim == TORSO_STAND || torsoAnim == TORSO_STAND2 ) {
ADDRLP4 20
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 11
EQI4 $506
ADDRLP4 20
INDIRI4
CNSTI4 12
NEI4 $504
LABELV $506
line 1197
;1197:		if ( weaponNum == WP_NONE || weaponNum == WP_GAUNTLET ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $509
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $507
LABELV $509
line 1198
;1198:			torsoAnim = TORSO_STAND2;
ADDRFP4 8
CNSTI4 12
ASGNI4
line 1199
;1199:		}
ADDRGP4 $508
JUMPV
LABELV $507
line 1200
;1200:		else {
line 1201
;1201:			torsoAnim = TORSO_STAND;
ADDRFP4 8
CNSTI4 11
ASGNI4
line 1202
;1202:		}
LABELV $508
line 1203
;1203:	}
LABELV $504
line 1205
;1204:
;1205:	if ( torsoAnim == TORSO_ATTACK || torsoAnim == TORSO_ATTACK2 ) {
ADDRLP4 24
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 7
EQI4 $512
ADDRLP4 24
INDIRI4
CNSTI4 8
NEI4 $510
LABELV $512
line 1206
;1206:		if ( weaponNum == WP_NONE || weaponNum == WP_GAUNTLET ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $515
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $513
LABELV $515
line 1207
;1207:			torsoAnim = TORSO_ATTACK2;
ADDRFP4 8
CNSTI4 8
ASGNI4
line 1208
;1208:		}
ADDRGP4 $514
JUMPV
LABELV $513
line 1209
;1209:		else {
line 1210
;1210:			torsoAnim = TORSO_ATTACK;
ADDRFP4 8
CNSTI4 7
ASGNI4
line 1211
;1211:		}
LABELV $514
line 1212
;1212:		pi->muzzleFlashTime = dp_realtime + UI_TIMER_MUZZLE_FLASH;
ADDRFP4 0
INDIRP4
CNSTI4 1012
ADDP4
ADDRGP4 dp_realtime
INDIRI4
CNSTI4 20
ADDI4
ASGNI4
line 1214
;1213:		//FIXME play firing sound here
;1214:	}
LABELV $510
line 1216
;1215:
;1216:	currentAnim = pi->torsoAnim & ~ANIM_TOGGLEBIT;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1048
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 1218
;1217:
;1218:	if ( weaponNum != pi->currentWeapon || currentAnim == TORSO_RAISE || currentAnim == TORSO_DROP ) {
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 1040
ADDP4
INDIRI4
NEI4 $519
ADDRLP4 0
INDIRI4
CNSTI4 10
EQI4 $519
ADDRLP4 0
INDIRI4
CNSTI4 9
NEI4 $516
LABELV $519
line 1219
;1219:		pi->pendingTorsoAnim = torsoAnim;
ADDRFP4 0
INDIRP4
CNSTI4 1076
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 1220
;1220:	}
ADDRGP4 $517
JUMPV
LABELV $516
line 1221
;1221:	else if ( ( currentAnim == TORSO_GESTURE || currentAnim == TORSO_ATTACK ) && ( torsoAnim != currentAnim ) ) {
ADDRLP4 0
INDIRI4
CNSTI4 6
EQI4 $522
ADDRLP4 0
INDIRI4
CNSTI4 7
NEI4 $520
LABELV $522
ADDRFP4 8
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $520
line 1222
;1222:		pi->pendingTorsoAnim = torsoAnim;
ADDRFP4 0
INDIRP4
CNSTI4 1076
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 1223
;1223:	}
ADDRGP4 $521
JUMPV
LABELV $520
line 1224
;1224:	else if ( torsoAnim != currentAnim ) {
ADDRFP4 8
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $523
line 1225
;1225:		pi->pendingTorsoAnim = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1076
ADDP4
CNSTI4 0
ASGNI4
line 1226
;1226:		UI_ForceTorsoAnim( pi, torsoAnim );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 UI_ForceTorsoAnim
CALLV
pop
line 1227
;1227:	}
LABELV $523
LABELV $521
LABELV $517
line 1228
;1228:}
LABELV $487
endproc UI_PlayerInfo_SetInfo 36 8
bss
align 4
LABELV jumpHeight
skip 4
align 4
LABELV dp_realtime
skip 4
import UI_RankStatusMenu
import RankStatus_Cache
import UI_SignupMenu
import Signup_Cache
import UI_LoginMenu
import Login_Cache
import UI_RankingsMenu
import Rankings_Cache
import Rankings_DrawPassword
import Rankings_DrawName
import Rankings_DrawText
import UI_InitGameinfo
import UI_SPUnlockMedals_f
import UI_SPUnlock_f
import UI_GetAwardLevel
import UI_LogAwardData
import UI_NewGame
import UI_GetCurrentGame
import UI_CanShowTierVideo
import UI_ShowTierVideo
import UI_TierCompleted
import UI_SetBestScore
import UI_GetBestScore
import UI_GetNumBots
import UI_GetBotInfoByName
import UI_GetBotInfoByNumber
import UI_GetNumSPTiers
import UI_GetNumSPArenas
import UI_GetNumArenas
import UI_GetSpecialArenaInfo
import UI_GetArenaInfoByMap
import UI_GetArenaInfoByNumber
import UI_NetworkOptionsMenu
import UI_NetworkOptionsMenu_Cache
import UI_SoundOptionsMenu
import UI_SoundOptionsMenu_Cache
import UI_DisplayOptionsMenu
import UI_DisplayOptionsMenu_Cache
import UI_SaveConfigMenu
import UI_SaveConfigMenu_Cache
import UI_LoadConfigMenu
import UI_LoadConfig_Cache
import UI_TeamOrdersMenu_Cache
import UI_TeamOrdersMenu_f
import UI_TeamOrdersMenu
import UI_RemoveBotsMenu
import UI_RemoveBots_Cache
import UI_AddBotsMenu
import UI_AddBots_Cache
import trap_SetPbClStatus
import trap_VerifyCDKey
import trap_SetCDKey
import trap_GetCDKey
import trap_MemoryRemaining
import trap_LAN_GetPingInfo
import trap_LAN_GetPing
import trap_LAN_ClearPing
import trap_LAN_ServerStatus
import trap_LAN_GetPingQueueCount
import trap_LAN_GetServerInfo
import trap_LAN_GetServerAddressString
import trap_LAN_GetServerCount
import trap_GetConfigString
import trap_GetGlconfig
import trap_GetClientState
import trap_GetClipboardData
import trap_Key_SetCatcher
import trap_Key_GetCatcher
import trap_Key_ClearStates
import trap_Key_SetOverstrikeMode
import trap_Key_GetOverstrikeMode
import trap_Key_IsDown
import trap_Key_SetBinding
import trap_Key_GetBindingBuf
import trap_Key_KeynumToStringBuf
import trap_S_RegisterSound
import trap_S_StartLocalSound
import trap_CM_LerpTag
import trap_UpdateScreen
import trap_R_DrawStretchPic
import trap_R_SetColor
import trap_R_RenderScene
import trap_R_AddLightToScene
import trap_R_AddPolyToScene
import trap_R_AddRefEntityToScene
import trap_R_ClearScene
import trap_R_RegisterShaderNoMip
import trap_R_RegisterSkin
import trap_R_RegisterModel
import trap_FS_Seek
import trap_FS_GetFileList
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_Cmd_ExecuteText
import trap_Cvar_InfoStringBuffer
import trap_Cvar_Create
import trap_Cvar_Reset
import trap_Cvar_SetValue
import trap_Cvar_VariableStringBuffer
import trap_Cvar_VariableValue
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_Milliseconds
import trap_Error
import trap_Print
import UI_SPSkillMenu_Cache
import UI_SPSkillMenu
import UI_SPPostgameMenu_f
import UI_SPPostgameMenu_Cache
import UI_SPArena_Start
import UI_SPLevelMenu_CustomEvent
import UI_SPLevelMenu_ReInit
import UI_SPLevelMenu_f
import UI_SPLevelMenu
import UI_SPLevelMenu_Cache
import uis
import m_entersound
import UI_StartDemoLoop
import UI_Cvar_VariableString
import UI_Argv
import UI_ForceMenuOff
import UI_PopMenu
import UI_PushMenu
import UI_SetActiveMenu
import UI_IsFullscreen
import UI_DrawTextBox
import UI_AdjustFrom640
import UI_CursorInRect
import UI_DrawChar
import UI_DrawString
import UI_ProportionalStringWidth
import UI_DrawProportionalString_AutoWrapped
import UI_DrawProportionalString
import UI_ProportionalSizeScale
import UI_DrawBannerString
import UI_LerpColor
import UI_SetColor
import UI_UpdateScreen
import UI_DrawRect
import UI_FillRect
import UI_DrawHandlePic
import UI_DrawNamedPic
import UI_ClampCvar
import UI_ConsoleCommand
import UI_Refresh
import UI_MouseEvent
import UI_KeyEvent
import UI_Shutdown
import UI_Init
import DriverInfo_Cache
import GraphicsOptions_Cache
import UI_GraphicsOptionsMenu
import ServerInfo_Cache
import UI_ServerInfoMenu
import UI_BotSelectMenu_Cache
import UI_BotSelectMenu
import ServerOptions_Cache
import StartServer_Cache
import UI_StartServerMenu
import ArenaServers_Cache
import UI_ArenaServersMenu
import SpecifyServer_Cache
import UI_SpecifyServerMenu
import SpecifyLeague_Cache
import UI_SpecifyLeagueMenu
import Preferences_Cache
import UI_PreferencesMenu
import PlayerSettings_Cache
import UI_PlayerSettingsMenu
import PlayerModel_Cache
import UI_PlayerModelMenu
import UI_CDKeyMenu_f
import UI_CDKeyMenu_Cache
import UI_CDKeyMenu
import UI_ModsMenu_Cache
import UI_ModsMenu
import UI_CinematicsMenu_Cache
import UI_CinematicsMenu_f
import UI_CinematicsMenu
import Demos_Cache
import UI_DemosMenu
import Controls_Cache
import UI_ControlsMenu
import UI_DrawConnectScreen
import TeamMain_Cache
import UI_TeamMainMenu
import UI_SetupMenu
import UI_SetupMenu_Cache
import UI_Message
import UI_ConfirmMenu_Style
import UI_ConfirmMenu
import ConfirmMenu_Cache
import UI_InGameMenu
import InGame_Cache
import UI_CreditMenu
import UI_UpdateCvars
import UI_RegisterCvars
import UI_MainMenu
import MenuField_Key
import MenuField_Draw
import MenuField_Init
import MField_Draw
import MField_CharEvent
import MField_KeyDownEvent
import MField_Clear
import ui_medalSounds
import ui_medalPicNames
import ui_medalNames
import text_color_highlight
import text_color_normal
import text_color_disabled
import listbar_color
import list_color
import name_color
import color_dim
import color_main
import color_red
import color_orange
import color_blue
import color_yellow
import color_white
import color_black
import menu_dim_color
import menu_black_color
import menu_red_color
import menu_highlight_color
import menu_dark_color
import menu_grayed_color
import menu_text_color
import weaponChangeSound
import menu_null_sound
import menu_buzz_sound
import menu_out_sound
import menu_move_sound
import menu_in_sound
import ScrollList_Key
import ScrollList_Draw
import Bitmap_Draw
import Bitmap_Init
import Menu_DefaultKey
import Menu_SetCursorToItem
import Menu_SetCursor
import Menu_ActivateItem
import Menu_ItemAtCursor
import Menu_Draw
import Menu_AdjustCursor
import Menu_AddItem
import Menu_Focus
import Menu_Cache
import s_announcer
import ui_cdkeychecked
import ui_cdkey
import ui_server16
import ui_server15
import ui_server14
import ui_server13
import ui_server12
import ui_server11
import ui_server10
import ui_server9
import ui_server8
import ui_server7
import ui_server6
import ui_server5
import ui_server4
import ui_server3
import ui_server2
import ui_server1
import ui_marks
import ui_drawCrosshairNames
import ui_drawCrosshair
import ui_brassTime
import ui_browserShowEmpty
import ui_browserShowFull
import ui_browserSortKey
import ui_browserGameType
import ui_browserMaster
import ui_spSelection
import ui_spSkill
import ui_spVideos
import ui_spAwards
import ui_spScores5
import ui_spScores4
import ui_spScores3
import ui_spScores2
import ui_spScores1
import ui_botsFile
import ui_arenasFile
import ui_ctf_friendly
import ui_ctf_timelimit
import ui_ctf_capturelimit
import ui_team_friendly
import ui_team_timelimit
import ui_team_fraglimit
import ui_tourney_timelimit
import ui_tourney_fraglimit
import ui_ffa_timelimit
import ui_ffa_fraglimit
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
LABELV $485
byte 1 70
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $482
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $481
byte 1 70
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $474
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $471
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 117
byte 1 112
byte 1 112
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $470
byte 1 70
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $467
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $466
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $460
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $439
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $434
byte 1 115
byte 1 101
byte 1 120
byte 1 0
align 1
LABELV $425
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 111
byte 1 102
byte 1 102
byte 1 115
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $420
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
LABELV $412
byte 1 70
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $402
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $401
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 117
byte 1 112
byte 1 112
byte 1 101
byte 1 114
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $400
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $394
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
LABELV $385
byte 1 116
byte 1 97
byte 1 103
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $378
byte 1 116
byte 1 97
byte 1 103
byte 1 95
byte 1 98
byte 1 97
byte 1 114
byte 1 114
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $361
byte 1 116
byte 1 97
byte 1 103
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $355
byte 1 116
byte 1 97
byte 1 103
byte 1 95
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $347
byte 1 116
byte 1 97
byte 1 103
byte 1 95
byte 1 116
byte 1 111
byte 1 114
byte 1 115
byte 1 111
byte 1 0
align 1
LABELV $164
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $92
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $91
byte 1 95
byte 1 98
byte 1 97
byte 1 114
byte 1 114
byte 1 101
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
