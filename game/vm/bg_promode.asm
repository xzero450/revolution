data
export cpm_pm_airstopaccelerate
align 4
LABELV cpm_pm_airstopaccelerate
byte 4 1065353216
export cpm_pm_aircontrol
align 4
LABELV cpm_pm_aircontrol
byte 4 0
export cpm_pm_strafeaccelerate
align 4
LABELV cpm_pm_strafeaccelerate
byte 4 1065353216
export cpm_pm_wishspeed
align 4
LABELV cpm_pm_wishspeed
byte 4 1137180672
export cpm_Gauntletknockback
align 4
LABELV cpm_Gauntletknockback
byte 4 1065353216
export cpm_MGbox
align 4
LABELV cpm_MGbox
byte 4 1112014848
export cpm_MGdmg
align 4
LABELV cpm_MGdmg
byte 4 1088421888
export cpm_MGdmg_tp
align 4
LABELV cpm_MGdmg_tp
byte 4 1084227584
export cpm_MGweapon
align 4
LABELV cpm_MGweapon
byte 4 100
export cpm_SSGdmg
align 4
LABELV cpm_SSGdmg
byte 4 1092616192
export cpm_SSGknockback
align 4
LABELV cpm_SSGknockback
byte 4 1065353216
export cpm_SSGmaxammo
align 4
LABELV cpm_SSGmaxammo
byte 4 200
export cpm_GLreload
align 4
LABELV cpm_GLreload
byte 4 1145569280
export cpm_GLmaxammo
align 4
LABELV cpm_GLmaxammo
byte 4 200
export cpm_RLspeed
align 4
LABELV cpm_RLspeed
byte 4 1147207680
export cpm_RLmaxammo
align 4
LABELV cpm_RLmaxammo
byte 4 200
export cpm_LGknockback
align 4
LABELV cpm_LGknockback
byte 4 1065353216
export cpm_LGmaxammo
align 4
LABELV cpm_LGmaxammo
byte 4 200
export cpm_RGmaxammo
align 4
LABELV cpm_RGmaxammo
byte 4 200
export cpm_RGbox
align 4
LABELV cpm_RGbox
byte 4 10
export cpm_weapondrop
align 4
LABELV cpm_weapondrop
byte 4 1128792064
export cpm_weaponraise
align 4
LABELV cpm_weaponraise
byte 4 1132068864
export cpm_outofammodelay
align 4
LABELV cpm_outofammodelay
byte 4 1140457472
export cpm_armorsystem
align 4
LABELV cpm_armorsystem
byte 4 0
export cpm_BSprotection
align 4
LABELV cpm_BSprotection
byte 4 1056964608
export cpm_respawnhealth
align 4
LABELV cpm_respawnhealth
byte 4 1067450368
export cpm_knockback_z
align 4
LABELV cpm_knockback_z
byte 4 1103101952
export cpm_itemrespawnhealth
align 4
LABELV cpm_itemrespawnhealth
byte 4 35
export cpm_itemrespawnpowerup
align 4
LABELV cpm_itemrespawnpowerup
byte 4 120
export cpm_itemrespawnammo
align 4
LABELV cpm_itemrespawnammo
byte 4 40
export cpm_startpowerups
align 4
LABELV cpm_startpowerups
byte 4 0
export cpm_itemrespawnBS
align 4
LABELV cpm_itemrespawnBS
byte 4 120
export cpm_hittones
align 4
LABELV cpm_hittones
byte 4 0
export cpm_itemsize
align 4
LABELV cpm_itemsize
byte 4 36
export cpm_lavadamage
align 4
LABELV cpm_lavadamage
byte 4 1106247680
export cpm_slimedamage
align 4
LABELV cpm_slimedamage
byte 4 1092616192
export cpm_lavafrequency
align 4
LABELV cpm_lavafrequency
byte 4 1143930880
export CPM_UpdateSettings
code
proc CPM_UpdateSettings 0 0
file "../bg_promode.c"
line 102
;1:
;2:#include "q_shared.h"
;3:#include "bg_public.h"
;4:#include "bg_local.h"
;5:#include "bg_promode.h"
;6:
;7:float cpm_pm_jump_z;
;8:
;9:// Physics
;10:float	cpm_pm_airstopaccelerate = 1;
;11:float	cpm_pm_aircontrol = 0;
;12:float	cpm_pm_strafeaccelerate = 1;
;13:float	cpm_pm_wishspeed = 400;
;14:
;15:// Gauntlet
;16:float	cpm_Gauntletknockback = 1;
;17:
;18:// Machinegun
;19:float	cpm_MGbox = 50;
;20:float	cpm_MGdmg = 7;
;21:float	cpm_MGdmg_tp = 5;
;22:int		cpm_MGweapon = 100;
;23:
;24:// Shotgun
;25:float	cpm_SSGdmg = 10;
;26://float	cpm_SSGspread = 700;
;27://int		cpm_SSGcount = 11;
;28:float	cpm_SSGknockback = 1;
;29:int		cpm_SSGmaxammo = 200;
;30:
;31:// Grenade Launcher
;32:float	cpm_GLreload = 800;
;33:int		cpm_GLmaxammo = 200;
;34:
;35:// Rocket Launcher
;36:float	cpm_RLspeed = 900;
;37:int		cpm_RLmaxammo = 200;
;38://float	cpm_RLsplashknockback = 1;
;39://float	cpm_RLknockback = 1;
;40:
;41:// Lightning Gun
;42:float	cpm_LGknockback = 1;
;43:int		cpm_LGmaxammo = 200;
;44:
;45:// Railgun
;46:int		cpm_RGmaxammo = 200;
;47:int		cpm_RGbox = 10;
;48:float	cpm_RGchange;
;49:
;50:// Plasma Gun
;51://float	cpm_PGdmg = 20;
;52://float	cpm_PGknockback = 1;
;53:
;54:// Weapon switching
;55:float	cpm_weapondrop = 200;
;56:float	cpm_weaponraise = 250;
;57:float	cpm_outofammodelay = 500;
;58:
;59:// Armor system
;60:int		cpm_armorsystem = 0;
;61:
;62:// Battle Suit
;63:float	cpm_BSprotection = 0.5;
;64:
;65:// Respawn Health
;66:float	cpm_respawnhealth = 1.25;
;67:
;68:// Backpacks
;69://int		cpm_backpacks = 0;
;70:
;71:// Radius Damage Fix
;72://int		cpm_radiusdamagefix = 0;
;73:
;74:// Z Knockback
;75:float	cpm_knockback_z = 24;
;76:
;77:// Respawn Times
;78:int		cpm_itemrespawnhealth = 35;
;79:int		cpm_itemrespawnpowerup = 120;
;80:int		cpm_itemrespawnammo = 40;
;81:int		cpm_startpowerups = 0;
;82:int		cpm_itemrespawnBS = 120;
;83:
;84:// Megahealth
;85://int		cpm_megastyle = 0;
;86:
;87:// Respawn delay
;88://float	cpm_clientrespawndelay = 1700;
;89:
;90:// Hit tones
;91:int		cpm_hittones = 0;
;92:
;93:// Item size
;94:int		cpm_itemsize = 36;
;95:
;96:// Lava damage
;97:float	cpm_lavadamage = 30;
;98:float	cpm_slimedamage = 10;
;99:float	cpm_lavafrequency = 700;
;100:
;101:void CPM_UpdateSettings(int num)
;102:{
line 106
;103:	// num = 0: normal quake 3
;104:	// num = 1: pro mode
;105:
;106:	cpm_pm_jump_z = 0; // turn off double-jump in vq3
ADDRGP4 cpm_pm_jump_z
CNSTF4 0
ASGNF4
line 109
;107:
;108:	// Physics
;109:	cpm_pm_airstopaccelerate = 1;
ADDRGP4 cpm_pm_airstopaccelerate
CNSTF4 1065353216
ASGNF4
line 110
;110:	cpm_pm_aircontrol = 0;
ADDRGP4 cpm_pm_aircontrol
CNSTF4 0
ASGNF4
line 111
;111:	cpm_pm_strafeaccelerate = 1;
ADDRGP4 cpm_pm_strafeaccelerate
CNSTF4 1065353216
ASGNF4
line 112
;112:	cpm_pm_wishspeed = 400;
ADDRGP4 cpm_pm_wishspeed
CNSTF4 1137180672
ASGNF4
line 113
;113:	pm_accelerate = 10;
ADDRGP4 pm_accelerate
CNSTF4 1092616192
ASGNF4
line 114
;114:	pm_friction = 6;
ADDRGP4 pm_friction
CNSTF4 1086324736
ASGNF4
line 117
;115:
;116:	// vq3 Gauntlet
;117:	cpm_Gauntletknockback = 1;
ADDRGP4 cpm_Gauntletknockback
CNSTF4 1065353216
ASGNF4
line 120
;118:
;119:	// vq3 machine gun settings
;120:	cpm_MGbox = 50;
ADDRGP4 cpm_MGbox
CNSTF4 1112014848
ASGNF4
line 121
;121:	cpm_MGdmg = 7;
ADDRGP4 cpm_MGdmg
CNSTF4 1088421888
ASGNF4
line 122
;122:	cpm_MGdmg_tp = 5;
ADDRGP4 cpm_MGdmg_tp
CNSTF4 1084227584
ASGNF4
line 123
;123:	cpm_MGweapon = 100;
ADDRGP4 cpm_MGweapon
CNSTI4 100
ASGNI4
line 126
;124:
;125:	// vq3 ssg settings
;126:	cpm_SSGdmg = 10;
ADDRGP4 cpm_SSGdmg
CNSTF4 1092616192
ASGNF4
line 129
;127:	//cpm_SSGspread = 700;
;128:	//cpm_SSGcount = 11;
;129:	cpm_SSGknockback = 1;
ADDRGP4 cpm_SSGknockback
CNSTF4 1065353216
ASGNF4
line 130
;130:	cpm_SSGmaxammo = 200;
ADDRGP4 cpm_SSGmaxammo
CNSTI4 200
ASGNI4
line 133
;131:
;132:	// vq3 GL settings
;133:	cpm_GLreload = 800;
ADDRGP4 cpm_GLreload
CNSTF4 1145569280
ASGNF4
line 134
;134:	cpm_GLmaxammo = 200;
ADDRGP4 cpm_GLmaxammo
CNSTI4 200
ASGNI4
line 137
;135:
;136:	// vq3 Rocket Launcher
;137:	cpm_RLspeed = 900;
ADDRGP4 cpm_RLspeed
CNSTF4 1147207680
ASGNF4
line 138
;138:	cpm_RLmaxammo = 200;
ADDRGP4 cpm_RLmaxammo
CNSTI4 200
ASGNI4
line 143
;139:	//cpm_RLsplashknockback = 1;
;140:	//cpm_RLknockback = 1;
;141:
;142:	// vq3 Lightning Gun
;143:	cpm_LGknockback = 1;
ADDRGP4 cpm_LGknockback
CNSTF4 1065353216
ASGNF4
line 144
;144:	cpm_LGmaxammo = 200;
ADDRGP4 cpm_LGmaxammo
CNSTI4 200
ASGNI4
line 147
;145:
;146:	// vq3 Railgun
;147:	cpm_RGmaxammo = 200;
ADDRGP4 cpm_RGmaxammo
CNSTI4 200
ASGNI4
line 148
;148:	cpm_RGbox = 10;
ADDRGP4 cpm_RGbox
CNSTI4 10
ASGNI4
line 149
;149:	cpm_RGchange = 1500;
ADDRGP4 cpm_RGchange
CNSTF4 1153138688
ASGNF4
line 156
;150:
;151:	// vq3 Plasma Gun
;152:	//cpm_PGdmg = 20;
;153:	//cpm_PGknockback = 1;
;154:
;155:	// vq3 Weapon switching
;156:	cpm_weapondrop = 200;
ADDRGP4 cpm_weapondrop
CNSTF4 1128792064
ASGNF4
line 157
;157:	cpm_weaponraise = 250;
ADDRGP4 cpm_weaponraise
CNSTF4 1132068864
ASGNF4
line 158
;158:	cpm_outofammodelay = 500;
ADDRGP4 cpm_outofammodelay
CNSTF4 1140457472
ASGNF4
line 161
;159:
;160:	// Armor system
;161:	cpm_armorsystem = 0;
ADDRGP4 cpm_armorsystem
CNSTI4 0
ASGNI4
line 164
;162:
;163:	// vq3 Battle Suit
;164:	cpm_BSprotection = 0.5;
ADDRGP4 cpm_BSprotection
CNSTF4 1056964608
ASGNF4
line 167
;165:
;166:	// vq3 Respawn Health
;167:	cpm_respawnhealth = 1.25;
ADDRGP4 cpm_respawnhealth
CNSTF4 1067450368
ASGNF4
line 176
;168:
;169:	// Backpacks
;170:	//cpm_backpacks = 0;
;171:
;172:	// Radius Damage Fix
;173:	//cpm_radiusdamagefix = 0;
;174:
;175:	// Z Knockback
;176:	cpm_knockback_z = 24;
ADDRGP4 cpm_knockback_z
CNSTF4 1103101952
ASGNF4
line 179
;177:
;178:	// Respawn Times
;179:	cpm_itemrespawnhealth = 35;
ADDRGP4 cpm_itemrespawnhealth
CNSTI4 35
ASGNI4
line 180
;180:	cpm_itemrespawnpowerup = 120;
ADDRGP4 cpm_itemrespawnpowerup
CNSTI4 120
ASGNI4
line 181
;181:	cpm_itemrespawnammo = 40;
ADDRGP4 cpm_itemrespawnammo
CNSTI4 40
ASGNI4
line 182
;182:	cpm_startpowerups = 0;
ADDRGP4 cpm_startpowerups
CNSTI4 0
ASGNI4
line 183
;183:	cpm_itemrespawnBS = 120;
ADDRGP4 cpm_itemrespawnBS
CNSTI4 120
ASGNI4
line 192
;184:
;185:	// Megahealth
;186:	//cpm_megastyle = 0;
;187:
;188:	// Respawn delay
;189:	//cpm_clientrespawndelay = 1700;
;190:
;191:	// Hit tones
;192:	cpm_hittones = 0;
ADDRGP4 cpm_hittones
CNSTI4 0
ASGNI4
line 195
;193:
;194:	// Item size
;195:	cpm_itemsize = 36;
ADDRGP4 cpm_itemsize
CNSTI4 36
ASGNI4
line 198
;196:
;197:	// Lava damage
;198:	cpm_lavadamage = 30;
ADDRGP4 cpm_lavadamage
CNSTF4 1106247680
ASGNF4
line 199
;199:	cpm_slimedamage = 10;
ADDRGP4 cpm_slimedamage
CNSTF4 1092616192
ASGNF4
line 200
;200:	cpm_lavafrequency = 700;
ADDRGP4 cpm_lavafrequency
CNSTF4 1143930880
ASGNF4
line 202
;201:
;202:	if (num)
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $43
line 203
;203:	{
line 204
;204:		cpm_pm_jump_z = 100; // enable double-jump
ADDRGP4 cpm_pm_jump_z
CNSTF4 1120403456
ASGNF4
line 207
;205:
;206:		// Physics
;207:		cpm_pm_airstopaccelerate = 2.5;
ADDRGP4 cpm_pm_airstopaccelerate
CNSTF4 1075838976
ASGNF4
line 208
;208:		cpm_pm_aircontrol = 150;
ADDRGP4 cpm_pm_aircontrol
CNSTF4 1125515264
ASGNF4
line 209
;209:		cpm_pm_strafeaccelerate = 70;
ADDRGP4 cpm_pm_strafeaccelerate
CNSTF4 1116471296
ASGNF4
line 210
;210:		cpm_pm_wishspeed = 30;
ADDRGP4 cpm_pm_wishspeed
CNSTF4 1106247680
ASGNF4
line 211
;211:		pm_accelerate = 15;
ADDRGP4 pm_accelerate
CNSTF4 1097859072
ASGNF4
line 212
;212:		pm_friction = 8;
ADDRGP4 pm_friction
CNSTF4 1090519040
ASGNF4
line 215
;213:
;214:		// Gauntlet
;215:		cpm_Gauntletknockback = 0.5;
ADDRGP4 cpm_Gauntletknockback
CNSTF4 1056964608
ASGNF4
line 218
;216:
;217:		// machinegun
;218:		cpm_MGbox = 25;
ADDRGP4 cpm_MGbox
CNSTF4 1103626240
ASGNF4
line 219
;219:		cpm_MGdmg = 5;
ADDRGP4 cpm_MGdmg
CNSTF4 1084227584
ASGNF4
line 220
;220:		cpm_MGdmg_tp = 5;
ADDRGP4 cpm_MGdmg_tp
CNSTF4 1084227584
ASGNF4
line 221
;221:		cpm_MGweapon = 50;
ADDRGP4 cpm_MGweapon
CNSTI4 50
ASGNI4
line 224
;222:
;223:		// Shotgun
;224:		cpm_SSGdmg = 7;
ADDRGP4 cpm_SSGdmg
CNSTF4 1088421888
ASGNF4
line 227
;225:		//cpm_SSGspread = 900;
;226:		//cpm_SSGcount = 16;
;227:		cpm_SSGknockback = 1.33f;
ADDRGP4 cpm_SSGknockback
CNSTF4 1068121457
ASGNF4
line 228
;228:		cpm_SSGmaxammo = 25;
ADDRGP4 cpm_SSGmaxammo
CNSTI4 25
ASGNI4
line 231
;229:
;230:		// Grenade Launcher
;231:		cpm_GLreload = 600;
ADDRGP4 cpm_GLreload
CNSTF4 1142292480
ASGNF4
line 232
;232:		cpm_GLmaxammo = 25;
ADDRGP4 cpm_GLmaxammo
CNSTI4 25
ASGNI4
line 235
;233:
;234:		// Rocket Launcher
;235:		cpm_RLspeed = 1000;
ADDRGP4 cpm_RLspeed
CNSTF4 1148846080
ASGNF4
line 236
;236:		cpm_RLmaxammo = 25;
ADDRGP4 cpm_RLmaxammo
CNSTI4 25
ASGNI4
line 241
;237:		//cpm_RLsplashknockback = 1.2f;
;238:		//cpm_RLknockback = 1.2f;
;239:
;240:		// Lightning Gun
;241:		cpm_LGknockback = 1.50f;
ADDRGP4 cpm_LGknockback
CNSTF4 1069547520
ASGNF4
line 242
;242:		cpm_LGmaxammo = 150;
ADDRGP4 cpm_LGmaxammo
CNSTI4 150
ASGNI4
line 245
;243:
;244:		// Railgun
;245:		cpm_RGmaxammo = 25;
ADDRGP4 cpm_RGmaxammo
CNSTI4 25
ASGNI4
line 246
;246:		cpm_RGbox = 5;
ADDRGP4 cpm_RGbox
CNSTI4 5
ASGNI4
line 247
;247:		cpm_RGchange = 1000; // allow users to switch weapon before reload
ADDRGP4 cpm_RGchange
CNSTF4 1148846080
ASGNF4
line 254
;248:
;249:		// Plasma Gun
;250:		//cpm_PGdmg = 18;
;251:		//cpm_PGknockback = 0.5f;
;252:
;253:		// Weapon switching
;254:		cpm_weapondrop = 0;
ADDRGP4 cpm_weapondrop
CNSTF4 0
ASGNF4
line 255
;255:		cpm_weaponraise = 0;
ADDRGP4 cpm_weaponraise
CNSTF4 0
ASGNF4
line 256
;256:		cpm_outofammodelay = 100;
ADDRGP4 cpm_outofammodelay
CNSTF4 1120403456
ASGNF4
line 259
;257:
;258:		// Armor system
;259:		cpm_armorsystem = 1;
ADDRGP4 cpm_armorsystem
CNSTI4 1
ASGNI4
line 262
;260:
;261:		// Battle Suit
;262:		cpm_BSprotection = 0.25; // ie 75% protection
ADDRGP4 cpm_BSprotection
CNSTF4 1048576000
ASGNF4
line 265
;263:
;264:		// Respawn Health
;265:		cpm_respawnhealth = 1.0;
ADDRGP4 cpm_respawnhealth
CNSTF4 1065353216
ASGNF4
line 274
;266:
;267:		// Backpacks
;268:		//cpm_backpacks = 1;
;269:
;270:		// Radius Damage Fix
;271:		//cpm_radiusdamagefix = 1;
;272:
;273:		// Z Knockback
;274:		cpm_knockback_z = 40;
ADDRGP4 cpm_knockback_z
CNSTF4 1109393408
ASGNF4
line 277
;275:
;276:		// Respawn Times
;277:		cpm_itemrespawnhealth = 30;
ADDRGP4 cpm_itemrespawnhealth
CNSTI4 30
ASGNI4
line 278
;278:		cpm_itemrespawnpowerup = 60;
ADDRGP4 cpm_itemrespawnpowerup
CNSTI4 60
ASGNI4
line 279
;279:		cpm_itemrespawnammo = 30;
ADDRGP4 cpm_itemrespawnammo
CNSTI4 30
ASGNI4
line 280
;280:		cpm_startpowerups = 1;
ADDRGP4 cpm_startpowerups
CNSTI4 1
ASGNI4
line 281
;281:		cpm_itemrespawnBS = 120;
ADDRGP4 cpm_itemrespawnBS
CNSTI4 120
ASGNI4
line 290
;282:
;283:		// Megahealth
;284:		//cpm_megastyle = 1;
;285:
;286:		// Respawn delay
;287:		//cpm_clientrespawndelay = 500;
;288:
;289:		// Hit tones
;290:		cpm_hittones = 1;
ADDRGP4 cpm_hittones
CNSTI4 1
ASGNI4
line 293
;291:
;292:		// Item size
;293:		cpm_itemsize = 66; // easier to get items in pro mode
ADDRGP4 cpm_itemsize
CNSTI4 66
ASGNI4
line 296
;294:
;295:		// Lava damage
;296:		cpm_lavadamage = 4;
ADDRGP4 cpm_lavadamage
CNSTF4 1082130432
ASGNF4
line 297
;297:		cpm_slimedamage = 1.3f;
ADDRGP4 cpm_slimedamage
CNSTF4 1067869798
ASGNF4
line 298
;298:		cpm_lavafrequency = 100;
ADDRGP4 cpm_lavafrequency
CNSTF4 1120403456
ASGNF4
line 300
;299:
;300:	}
LABELV $43
line 301
;301:}
LABELV $42
endproc CPM_UpdateSettings 0 0
export CPM_PM_Aircontrol
proc CPM_PM_Aircontrol 48 4
line 304
;302:
;303:void CPM_PM_Aircontrol (pmove_t *pm, vec3_t wishdir, float wishspeed )
;304:{
line 308
;305:	float	zspeed, speed, dot, k;
;306:	int		i;
;307:
;308:	if ( (pm->ps->movementDir && pm->ps->movementDir !=4 && pm->ps->movementDir != -4 && pm->ps->movementDir != 12) || wishspeed == 0.0) 
ADDRLP4 20
ADDRFP4 0
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $51
ADDRLP4 20
INDIRI4
CNSTI4 4
EQI4 $51
ADDRLP4 20
INDIRI4
CNSTI4 -4
EQI4 $51
ADDRLP4 20
INDIRI4
CNSTI4 12
NEI4 $48
LABELV $51
ADDRFP4 8
INDIRF4
CNSTF4 0
NEF4 $46
LABELV $48
line 309
;309:		return; // can't control movement if not moveing forward or backward
ADDRGP4 $45
JUMPV
LABELV $46
line 311
;310:
;311:	zspeed = pm->ps->velocity[2];
ADDRLP4 16
ADDRFP4 0
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ASGNF4
line 312
;312:	pm->ps->velocity[2] = 0;
ADDRFP4 0
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 0
ASGNF4
line 313
;313:	speed = VectorNormalize(pm->ps->velocity);
ADDRFP4 0
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 24
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 24
INDIRF4
ASGNF4
line 315
;314:
;315:	dot = DotProduct(pm->ps->velocity,wishdir);
ADDRLP4 28
ADDRFP4 0
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 32
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 28
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
INDIRF4
MULF4
ADDRLP4 28
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 28
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 316
;316:	k = 32; 
ADDRLP4 8
CNSTF4 1107296256
ASGNF4
line 317
;317:	k *= cpm_pm_aircontrol*dot*dot*pml.frametime;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRGP4 cpm_pm_aircontrol
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDRLP4 12
INDIRF4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
MULF4
ASGNF4
line 320
;318:	
;319:	
;320:	if (dot > 0) {	// we can't change direction while slowing down
ADDRLP4 12
INDIRF4
CNSTF4 0
LEF4 $53
line 321
;321:		for (i=0; i < 2; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $55
line 322
;322:			pm->ps->velocity[i] = pm->ps->velocity[i]*speed + wishdir[i]*k;
ADDRLP4 40
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 44
ADDRLP4 40
INDIRI4
ADDRFP4 0
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ADDRLP4 40
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $56
line 321
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $55
line 323
;323:		VectorNormalize(pm->ps->velocity);
ADDRFP4 0
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 324
;324:	}
LABELV $53
line 326
;325:	
;326:	for (i=0; i < 2; i++) 
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $59
line 327
;327:		pm->ps->velocity[i] *=speed;
ADDRLP4 40
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
LABELV $60
line 326
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $59
line 329
;328:
;329:	pm->ps->velocity[2] = zspeed;
ADDRFP4 0
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 16
INDIRF4
ASGNF4
line 330
;330:}
LABELV $45
endproc CPM_PM_Aircontrol 48 4
export CPM_CanGrabAmmo
proc CPM_CanGrabAmmo 12 0
line 333
;331:
;332:qboolean CPM_CanGrabAmmo(const gitem_t *item, const playerState_t *ps)
;333:{
line 336
;334:	int		quantity;
;335:
;336:	switch (item->giTag)
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 3
LTI4 $64
ADDRLP4 4
INDIRI4
CNSTI4 7
GTI4 $64
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $71-12
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $71
address $67
address $68
address $69
address $64
address $70
code
line 337
;337:	{
LABELV $67
line 338
;338:		case WP_SHOTGUN: quantity = cpm_SSGmaxammo; break;
ADDRLP4 0
ADDRGP4 cpm_SSGmaxammo
INDIRI4
ASGNI4
ADDRGP4 $65
JUMPV
LABELV $68
line 339
;339:		case WP_GRENADE_LAUNCHER: quantity = cpm_GLmaxammo; break;
ADDRLP4 0
ADDRGP4 cpm_GLmaxammo
INDIRI4
ASGNI4
ADDRGP4 $65
JUMPV
LABELV $69
line 340
;340:		case WP_ROCKET_LAUNCHER: quantity = cpm_RLmaxammo; break;
ADDRLP4 0
ADDRGP4 cpm_RLmaxammo
INDIRI4
ASGNI4
ADDRGP4 $65
JUMPV
LABELV $70
line 341
;341:		case WP_RAILGUN: quantity = cpm_RGmaxammo; break;
ADDRLP4 0
ADDRGP4 cpm_RGmaxammo
INDIRI4
ASGNI4
ADDRGP4 $65
JUMPV
LABELV $64
line 342
;342:		default: quantity = 200;
ADDRLP4 0
CNSTI4 200
ASGNI4
line 343
;343:	}
LABELV $65
line 345
;344:	
;345:	if (ps->ammo[item->giTag] < quantity) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
GEI4 $73
CNSTI4 1
RETI4
ADDRGP4 $63
JUMPV
LABELV $73
line 346
;346:	return qfalse;
CNSTI4 0
RETI4
LABELV $63
endproc CPM_CanGrabAmmo 12 0
export CPM_CanGrabArmor
proc CPM_CanGrabArmor 8 0
line 350
;347:}
;348:
;349:qboolean CPM_CanGrabArmor(const gitem_t *item, const playerState_t *ps)
;350:{
line 352
;351:	// vq3 system
;352:	if (!cpm_armorsystem)
ADDRGP4 cpm_armorsystem
INDIRI4
CNSTI4 0
NEI4 $76
line 353
;353:	{
line 355
;354:		// notice that vq3 armor system is cap'ed for handicaps
;355:		return (ps->stats[STAT_ARMOR] >= ps->stats[STAT_MAX_HEALTH] * 2) ? qfalse : qtrue;
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 1
LSHI4
LTI4 $79
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $80
JUMPV
LABELV $79
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $80
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $75
JUMPV
LABELV $76
line 359
;356:	}
;357:
;358:	// pro mode system
;359:	if (item->quantity == 100) // RA
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 100
NEI4 $81
line 360
;360:	{
line 361
;361:		return (ps->stats[STAT_ARMOR] >= 200) ? qfalse : qtrue;		
ADDRFP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 200
LTI4 $84
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $85
JUMPV
LABELV $84
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $85
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $75
JUMPV
LABELV $81
line 363
;362:	}
;363:	if (item->quantity == 50) // YA
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 50
NEI4 $86
line 364
;364:	{
line 365
;365:		if (ps->stats[STAT_ARMORTYPE] <= 1)
ADDRFP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CNSTI4 1
GTI4 $88
line 366
;366:		{
line 367
;367:			return (ps->stats[STAT_ARMOR] >= 150) ? qfalse : qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 150
LTI4 $91
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $92
JUMPV
LABELV $91
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $92
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $75
JUMPV
LABELV $88
line 369
;368:		}
;369:		return (ps->stats[STAT_ARMOR] > CPM_RABREAKPOINT) ? qfalse : qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 120
LEI4 $94
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $95
JUMPV
LABELV $94
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $95
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $75
JUMPV
LABELV $86
line 372
;370:	}
;371:	//TODO:Evo:Match this with cpma
;372:	if (item->quantity > 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
LEI4 $96
line 373
;373:		return (ps->stats[STAT_ARMOR] >= 200) ? qfalse : qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 200
LTI4 $99
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $100
JUMPV
LABELV $99
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $100
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $75
JUMPV
LABELV $96
line 377
;374:	}
;375:
;376:	//return qtrue; // you can _always_ get shards in cpm
;377:	return qfalse;
CNSTI4 0
RETI4
LABELV $75
endproc CPM_CanGrabArmor 8 0
bss
export cpm_RGchange
align 4
LABELV cpm_RGchange
skip 4
export cpm_pm_jump_z
align 4
LABELV cpm_pm_jump_z
skip 4
import g_allowReady
import g_fastSwitch
import g_interference
import g_pro_mode
import g_delagHitscan
import g_gamemode
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
import PM_StepSlideMove
import PM_SlideMove
import PM_AddEvent
import PM_AddTouchEnt
import PM_ClipVelocity
import c_pmove
import pm_flightfriction
import pm_waterfriction
import pm_friction
import pm_flyaccelerate
import pm_wateraccelerate
import pm_airaccelerate
import pm_accelerate
import pm_wadeScale
import pm_swimScale
import pm_duckScale
import pm_stopspeed
import pml
import pm
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
