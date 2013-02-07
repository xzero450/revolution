code
proc CG_MachineGunEjectBrass 136 8
file "../cg_weapons.c"
line 143
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_weapons.c -- events and effects dealing with weapons
;4:#include "cg_local.h"
;5:#include "..\game\bg_promode.h" // CPM
;6:
;7:
;8://void CG_CreateAimtype4FireCmd( void )
;9://{
;10://	static int	theTime;
;11://
;12://	if (cg_aimType.integer == 4)
;13://	{
;14://		if (cg.predictedPlayerState.weapon == WP_MACHINEGUN ||
;15://			cg.predictedPlayerState.weapon == WP_SHOTGUN ||
;16://			cg.predictedPlayerState.weapon == WP_LIGHTNING ||
;17://			cg.predictedPlayerState.weapon == WP_RAILGUN )
;18://		{
;19://			if (theTime != cg.oldTime)
;20://			{
;21://				byte		buffer1[1024] = {0};
;22://				byte		buffer2[1024] = {0};
;23://				int			buffer3[1024] = {0};
;24://				char		buffer4[1024] = {0};
;25:////				byte		tmpByte;
;26:////				byte		*ptr;
;27://				int			i, j, count, total;
;28://
;29://
;30://				//Com_Printf(va("C: %i %i %i %f %f %f %f %f %f\n", cg.rawPacket.clientsHit[0], cg.rawPacket.clientsHit[1], cg.rawPacket.attackTime, cg.rawPacket.origin[0], cg.rawPacket.origin[1], cg.rawPacket.origin[2], cg.rawPacket.viewAngles[0], cg.rawPacket.viewAngles[1], cg.rawPacket.viewAngles[2]));
;31://				
;32://
;33://
;34://				memcpy(&(buffer1[0]), &cg.rawPacket, sizeof(aimtype4packet_t));
;35://
;36://
;37://				/** /
;38://				// Start debug message
;39://				memset(&buffer4,0,sizeof(buffer4));
;40://				count = 0;
;41://				for (i = 0; i < sizeof(aimtype4packet_t); i++)
;42://				{
;43://					for ( j = 7; j >= 0; j-- )
;44://					{
;45://						buffer4[count] = ((buffer1[i] & (1 << j)) ? '1' : '0');
;46://						count++;
;47://					}
;48://					buffer4[count] = ' ';
;49://					count++;
;50://				}
;51://				Com_Printf("Client:  %s\n", buffer4);
;52://				// End debug message
;53://				/**/
;54://
;55://
;56://
;57://				count = 0;
;58://				for (i = 0; i < sizeof(aimtype4packet_t); i++)
;59://				{
;60://					// for the first 11 bytes, we don't care about the 7th and 8th bit anyway, so just overwrite them with a 01
;61://					if (i<DEFAULT_SHOTGUN_COUNT)
;62://					{
;63://						buffer2[i] = buffer1[i] | (1 << 6);
;64://					}
;65://					else
;66://					{
;67://						// now lets copy all the bits out of the remaining structure
;68://						for ( j = 7; j >= 0; j-- )
;69://						{
;70://							buffer3[count] = ((buffer1[i] & (1 << j)) ? 1 : 0);
;71://							count++;
;72://						}
;73://					}
;74://				}
;75://
;76://				
;77://
;78://
;79://
;80://				total = count;
;81://
;82://				j = DEFAULT_SHOTGUN_COUNT;
;83://				count = 7;
;84://				buffer2[j] = buffer2[j] | (0 << count);
;85://				count--;
;86://				buffer2[j] = buffer2[j] | (1 << count);
;87://				count--;
;88://				for (i = 0; i < total; i++)
;89://				{
;90://					buffer2[j] = buffer2[j] | (buffer3[i] << count);
;91://					count--;
;92://					if (count < 0)
;93://					{
;94://						count = 7;
;95://						buffer2[j] = buffer2[j] | (0 << count);
;96://						count--;
;97://						buffer2[j] = buffer2[j] | (1 << count);
;98://						count--;
;99://						j++;
;100://					}
;101://				}
;102://
;103://				/** /
;104://				// Start debug message
;105://				memset(&buffer4,0,sizeof(buffer4));
;106://				count = 0;
;107://				for (i = 0; buffer2[i]; i++)
;108://				{
;109://					for ( j = 7; j >= 0; j-- )
;110://					{
;111://						buffer4[count] = ((buffer2[i] & (1 << j)) ? '1' : '0');
;112://						count++;
;113://					}
;114://					buffer4[count] = ' ';
;115://					count++;
;116://				}
;117://				Com_Printf("After: %s\n", buffer4);
;118://				// End debug message
;119://				/**/
;120://
;121://
;122://				//Com_Printf(va("Client Raw: %s\n", buffer2));
;123://
;124://				trap_SendClientCommand(va("f %s\n", buffer2));
;125://				
;126://				// old command
;127://				//trap_SendClientCommand(va("fcmd %i %i %f %f %f %f %f %f\n", cg.oldTime, cg.clientsHit, cgs.savedMuzzle[0], cgs.savedMuzzle[1], cgs.savedMuzzle[2], cgs.savedViewAngles[0], cgs.savedViewAngles[1], cgs.savedViewAngles[2]));
;128://				
;129://				//Com_Printf(va("C: %i %i %f %f %f %f %f %f\n", cg.oldTime, cg.clientsHit, cgs.savedMuzzle[0], cgs.savedMuzzle[1], cgs.savedMuzzle[2], cgs.savedViewAngles[0], cgs.savedViewAngles[1], cgs.savedViewAngles[2]));
;130://				theTime = cg.oldTime;
;131://			}
;132://		}
;133://	}
;134://
;135://}
;136:
;137:
;138:/*
;139:==========================
;140:CG_MachineGunEjectBrass
;141:==========================
;142:*/
;143:static void CG_MachineGunEjectBrass( centity_t *cent ) {
line 148
;144:	localEntity_t	*le;
;145:	refEntity_t		*re;
;146:	vec3_t			velocity, xvelocity;
;147:	vec3_t			offset, xoffset;
;148:	float			waterScale = 1.0f;
ADDRLP4 92
CNSTF4 1065353216
ASGNF4
line 151
;149:	vec3_t			v[3];
;150:
;151:	if ( cg_brassTime.integer <= 0 ) {
ADDRGP4 cg_brassTime+12
INDIRI4
CNSTI4 0
GTI4 $78
line 152
;152:		return;
ADDRGP4 $77
JUMPV
LABELV $78
line 155
;153:	}
;154:
;155:	le = CG_AllocLocalEntity();
ADDRLP4 96
ADDRGP4 CG_AllocLocalEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 96
INDIRP4
ASGNP4
line 156
;156:	re = &le->refEntity;
ADDRLP4 64
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
ASGNP4
line 158
;157:
;158:	velocity[0] = 0;
ADDRLP4 40
CNSTF4 0
ASGNF4
line 159
;159:	velocity[1] = -50 + 40 * crandom();
ADDRLP4 100
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 40+4
CNSTF4 1109393408
CNSTF4 1073741824
ADDRLP4 100
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
CNSTF4 3259498496
ADDF4
ASGNF4
line 160
;160:	velocity[2] = 100 + 50 * crandom();
ADDRLP4 104
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 40+8
CNSTF4 1112014848
CNSTF4 1073741824
ADDRLP4 104
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
CNSTF4 1120403456
ADDF4
ASGNF4
line 162
;161:
;162:	le->leType = LE_FRAGMENT;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 3
ASGNI4
line 163
;163:	le->startTime = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 164
;164:	le->endTime = le->startTime + cg_brassTime.integer + ( cg_brassTime.integer / 4 ) * random();
ADDRLP4 108
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ADDRGP4 cg_brassTime+12
INDIRI4
ADDI4
CVIF4 4
ADDRGP4 cg_brassTime+12
INDIRI4
CNSTI4 4
DIVI4
CVIF4 4
ADDRLP4 108
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 166
;165:
;166:	le->pos.trType = TR_GRAVITY;
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTI4 5
ASGNI4
line 167
;167:	le->pos.trTime = cg.time - (rand()&15);
ADDRLP4 116
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 116
INDIRI4
CNSTI4 15
BANDI4
SUBI4
ASGNI4
line 169
;168:
;169:	AnglesToAxis( cent->lerpAngles, v );
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 171
;170:
;171:	offset[0] = 8;
ADDRLP4 52
CNSTF4 1090519040
ASGNF4
line 172
;172:	offset[1] = -4;
ADDRLP4 52+4
CNSTF4 3229614080
ASGNF4
line 173
;173:	offset[2] = 24;
ADDRLP4 52+8
CNSTF4 1103101952
ASGNF4
line 175
;174:
;175:	xoffset[0] = offset[0] * v[0][0] + offset[1] * v[1][0] + offset[2] * v[2][0];
ADDRLP4 80
ADDRLP4 52
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ADDRLP4 52+4
INDIRF4
ADDRLP4 4+12
INDIRF4
MULF4
ADDF4
ADDRLP4 52+8
INDIRF4
ADDRLP4 4+24
INDIRF4
MULF4
ADDF4
ASGNF4
line 176
;176:	xoffset[1] = offset[0] * v[0][1] + offset[1] * v[1][1] + offset[2] * v[2][1];
ADDRLP4 80+4
ADDRLP4 52
INDIRF4
ADDRLP4 4+4
INDIRF4
MULF4
ADDRLP4 52+4
INDIRF4
ADDRLP4 4+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 52+8
INDIRF4
ADDRLP4 4+24+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 177
;177:	xoffset[2] = offset[0] * v[0][2] + offset[1] * v[1][2] + offset[2] * v[2][2];
ADDRLP4 80+8
ADDRLP4 52
INDIRF4
ADDRLP4 4+8
INDIRF4
MULF4
ADDRLP4 52+4
INDIRF4
ADDRLP4 4+12+8
INDIRF4
MULF4
ADDF4
ADDRLP4 52+8
INDIRF4
ADDRLP4 4+24+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 178
;178:	VectorAdd( cent->lerpOrigin, xoffset, re->origin );
ADDRLP4 64
INDIRP4
CNSTI4 68
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRF4
ADDRLP4 80
INDIRF4
ADDF4
ASGNF4
ADDRLP4 64
INDIRP4
CNSTI4 72
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
INDIRF4
ADDRLP4 80+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 64
INDIRP4
CNSTI4 76
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 712
ADDP4
INDIRF4
ADDRLP4 80+8
INDIRF4
ADDF4
ASGNF4
line 180
;179:
;180:	VectorCopy( re->origin, le->pos.trBase );
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 64
INDIRP4
CNSTI4 68
ADDP4
INDIRB
ASGNB 12
line 182
;181:
;182:	if ( CG_PointContents( re->origin, -1 ) & CONTENTS_WATER ) {
ADDRLP4 64
INDIRP4
CNSTI4 68
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 120
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $111
line 183
;183:		waterScale = 0.10f;
ADDRLP4 92
CNSTF4 1036831949
ASGNF4
line 184
;184:	}
LABELV $111
line 186
;185:
;186:	xvelocity[0] = velocity[0] * v[0][0] + velocity[1] * v[1][0] + velocity[2] * v[2][0];
ADDRLP4 68
ADDRLP4 40
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ADDRLP4 40+4
INDIRF4
ADDRLP4 4+12
INDIRF4
MULF4
ADDF4
ADDRLP4 40+8
INDIRF4
ADDRLP4 4+24
INDIRF4
MULF4
ADDF4
ASGNF4
line 187
;187:	xvelocity[1] = velocity[0] * v[0][1] + velocity[1] * v[1][1] + velocity[2] * v[2][1];
ADDRLP4 68+4
ADDRLP4 40
INDIRF4
ADDRLP4 4+4
INDIRF4
MULF4
ADDRLP4 40+4
INDIRF4
ADDRLP4 4+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 40+8
INDIRF4
ADDRLP4 4+24+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 188
;188:	xvelocity[2] = velocity[0] * v[0][2] + velocity[1] * v[1][2] + velocity[2] * v[2][2];
ADDRLP4 68+8
ADDRLP4 40
INDIRF4
ADDRLP4 4+8
INDIRF4
MULF4
ADDRLP4 40+4
INDIRF4
ADDRLP4 4+12+8
INDIRF4
MULF4
ADDF4
ADDRLP4 40+8
INDIRF4
ADDRLP4 4+24+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 189
;189:	VectorScale( xvelocity, waterScale, le->pos.trDelta );
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
ADDRLP4 68
INDIRF4
ADDRLP4 92
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
ADDRLP4 68+4
INDIRF4
ADDRLP4 92
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
ADDRLP4 68+8
INDIRF4
ADDRLP4 92
INDIRF4
MULF4
ASGNF4
line 191
;190:
;191:	AxisCopy( axisDefault, re->axis );
ADDRGP4 axisDefault
ARGP4
ADDRLP4 64
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRGP4 AxisCopy
CALLV
pop
line 192
;192:	re->hModel = cgs.media.machinegunBrassModel;
ADDRLP4 64
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 cgs+156680+232
INDIRI4
ASGNI4
line 194
;193:
;194:	le->bounceFactor = 0.4 * waterScale;
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
CNSTF4 1053609165
ADDRLP4 92
INDIRF4
MULF4
ASGNF4
line 196
;195:
;196:	le->angles.trType = TR_LINEAR;
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 2
ASGNI4
line 197
;197:	le->angles.trTime = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 198
;198:	le->angles.trBase[0] = rand()&31;
ADDRLP4 124
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 124
INDIRI4
CNSTI4 31
BANDI4
CVIF4 4
ASGNF4
line 199
;199:	le->angles.trBase[1] = rand()&31;
ADDRLP4 128
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
ADDRLP4 128
INDIRI4
CNSTI4 31
BANDI4
CVIF4 4
ASGNF4
line 200
;200:	le->angles.trBase[2] = rand()&31;
ADDRLP4 132
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 88
ADDP4
ADDRLP4 132
INDIRI4
CNSTI4 31
BANDI4
CVIF4 4
ASGNF4
line 201
;201:	le->angles.trDelta[0] = 2;
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
CNSTF4 1073741824
ASGNF4
line 202
;202:	le->angles.trDelta[1] = 1;
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
CNSTF4 1065353216
ASGNF4
line 203
;203:	le->angles.trDelta[2] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
CNSTF4 0
ASGNF4
line 205
;204:
;205:	le->leFlags = LEF_TUMBLE;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 2
ASGNI4
line 206
;206:	le->leBounceSoundType = LEBS_BRASS;
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 2
ASGNI4
line 207
;207:	le->leMarkType = LEMT_NONE;
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 0
ASGNI4
line 208
;208:}
LABELV $77
endproc CG_MachineGunEjectBrass 136 8
proc CG_ShotgunEjectBrass 136 8
line 215
;209:
;210:/*
;211:==========================
;212:CG_ShotgunEjectBrass
;213:==========================
;214:*/
;215:static void CG_ShotgunEjectBrass( centity_t *cent ) {
line 223
;216:	localEntity_t	*le;
;217:	refEntity_t		*re;
;218:	vec3_t			velocity, xvelocity;
;219:	vec3_t			offset, xoffset;
;220:	vec3_t			v[3];
;221:	int				i;
;222:
;223:	if ( cg_brassTime.integer <= 0 ) {
ADDRGP4 cg_brassTime+12
INDIRI4
CNSTI4 0
GTI4 $139
line 224
;224:		return;
ADDRGP4 $138
JUMPV
LABELV $139
line 227
;225:	}
;226:
;227:	for ( i = 0; i < 2; i++ ) {
ADDRLP4 92
CNSTI4 0
ASGNI4
LABELV $142
line 228
;228:		float	waterScale = 1.0f;
ADDRLP4 96
CNSTF4 1065353216
ASGNF4
line 230
;229:
;230:		le = CG_AllocLocalEntity();
ADDRLP4 100
ADDRGP4 CG_AllocLocalEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 100
INDIRP4
ASGNP4
line 231
;231:		re = &le->refEntity;
ADDRLP4 64
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
ASGNP4
line 233
;232:
;233:		velocity[0] = 60 + 60 * crandom();
ADDRLP4 104
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 40
CNSTF4 1114636288
CNSTF4 1073741824
ADDRLP4 104
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 234
;234:		if ( i == 0 ) {
ADDRLP4 92
INDIRI4
CNSTI4 0
NEI4 $146
line 235
;235:			velocity[1] = 40 + 10 * crandom();
ADDRLP4 108
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 40+4
CNSTF4 1092616192
CNSTF4 1073741824
ADDRLP4 108
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
CNSTF4 1109393408
ADDF4
ASGNF4
line 236
;236:		} else {
ADDRGP4 $147
JUMPV
LABELV $146
line 237
;237:			velocity[1] = -40 + 10 * crandom();
ADDRLP4 108
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 40+4
CNSTF4 1092616192
CNSTF4 1073741824
ADDRLP4 108
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
CNSTF4 3256877056
ADDF4
ASGNF4
line 238
;238:		}
LABELV $147
line 239
;239:		velocity[2] = 100 + 50 * crandom();
ADDRLP4 108
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 40+8
CNSTF4 1112014848
CNSTF4 1073741824
ADDRLP4 108
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
CNSTF4 1120403456
ADDF4
ASGNF4
line 241
;240:
;241:		le->leType = LE_FRAGMENT;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 3
ASGNI4
line 242
;242:		le->startTime = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 243
;243:		le->endTime = le->startTime + cg_brassTime.integer*3 + cg_brassTime.integer * random();
ADDRLP4 112
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 3
ADDRGP4 cg_brassTime+12
INDIRI4
MULI4
ADDI4
CVIF4 4
ADDRGP4 cg_brassTime+12
INDIRI4
CVIF4 4
ADDRLP4 112
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 245
;244:
;245:		le->pos.trType = TR_GRAVITY;
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTI4 5
ASGNI4
line 246
;246:		le->pos.trTime = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 248
;247:
;248:		AnglesToAxis( cent->lerpAngles, v );
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 250
;249:
;250:		offset[0] = 8;
ADDRLP4 52
CNSTF4 1090519040
ASGNF4
line 251
;251:		offset[1] = 0;
ADDRLP4 52+4
CNSTF4 0
ASGNF4
line 252
;252:		offset[2] = 24;
ADDRLP4 52+8
CNSTF4 1103101952
ASGNF4
line 254
;253:
;254:		xoffset[0] = offset[0] * v[0][0] + offset[1] * v[1][0] + offset[2] * v[2][0];
ADDRLP4 80
ADDRLP4 52
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ADDRLP4 52+4
INDIRF4
ADDRLP4 4+12
INDIRF4
MULF4
ADDF4
ADDRLP4 52+8
INDIRF4
ADDRLP4 4+24
INDIRF4
MULF4
ADDF4
ASGNF4
line 255
;255:		xoffset[1] = offset[0] * v[0][1] + offset[1] * v[1][1] + offset[2] * v[2][1];
ADDRLP4 80+4
ADDRLP4 52
INDIRF4
ADDRLP4 4+4
INDIRF4
MULF4
ADDRLP4 52+4
INDIRF4
ADDRLP4 4+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 52+8
INDIRF4
ADDRLP4 4+24+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 256
;256:		xoffset[2] = offset[0] * v[0][2] + offset[1] * v[1][2] + offset[2] * v[2][2];
ADDRLP4 80+8
ADDRLP4 52
INDIRF4
ADDRLP4 4+8
INDIRF4
MULF4
ADDRLP4 52+4
INDIRF4
ADDRLP4 4+12+8
INDIRF4
MULF4
ADDF4
ADDRLP4 52+8
INDIRF4
ADDRLP4 4+24+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 257
;257:		VectorAdd( cent->lerpOrigin, xoffset, re->origin );
ADDRLP4 64
INDIRP4
CNSTI4 68
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRF4
ADDRLP4 80
INDIRF4
ADDF4
ASGNF4
ADDRLP4 64
INDIRP4
CNSTI4 72
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 708
ADDP4
INDIRF4
ADDRLP4 80+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 64
INDIRP4
CNSTI4 76
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 712
ADDP4
INDIRF4
ADDRLP4 80+8
INDIRF4
ADDF4
ASGNF4
line 258
;258:		VectorCopy( re->origin, le->pos.trBase );
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 64
INDIRP4
CNSTI4 68
ADDP4
INDIRB
ASGNB 12
line 259
;259:		if ( CG_PointContents( re->origin, -1 ) & CONTENTS_WATER ) {
ADDRLP4 64
INDIRP4
CNSTI4 68
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 120
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $179
line 260
;260:			waterScale = 0.10f;
ADDRLP4 96
CNSTF4 1036831949
ASGNF4
line 261
;261:		}
LABELV $179
line 263
;262:
;263:		xvelocity[0] = velocity[0] * v[0][0] + velocity[1] * v[1][0] + velocity[2] * v[2][0];
ADDRLP4 68
ADDRLP4 40
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ADDRLP4 40+4
INDIRF4
ADDRLP4 4+12
INDIRF4
MULF4
ADDF4
ADDRLP4 40+8
INDIRF4
ADDRLP4 4+24
INDIRF4
MULF4
ADDF4
ASGNF4
line 264
;264:		xvelocity[1] = velocity[0] * v[0][1] + velocity[1] * v[1][1] + velocity[2] * v[2][1];
ADDRLP4 68+4
ADDRLP4 40
INDIRF4
ADDRLP4 4+4
INDIRF4
MULF4
ADDRLP4 40+4
INDIRF4
ADDRLP4 4+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 40+8
INDIRF4
ADDRLP4 4+24+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 265
;265:		xvelocity[2] = velocity[0] * v[0][2] + velocity[1] * v[1][2] + velocity[2] * v[2][2];
ADDRLP4 68+8
ADDRLP4 40
INDIRF4
ADDRLP4 4+8
INDIRF4
MULF4
ADDRLP4 40+4
INDIRF4
ADDRLP4 4+12+8
INDIRF4
MULF4
ADDF4
ADDRLP4 40+8
INDIRF4
ADDRLP4 4+24+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 266
;266:		VectorScale( xvelocity, waterScale, le->pos.trDelta );
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
ADDRLP4 68
INDIRF4
ADDRLP4 96
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
ADDRLP4 68+4
INDIRF4
ADDRLP4 96
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
ADDRLP4 68+8
INDIRF4
ADDRLP4 96
INDIRF4
MULF4
ASGNF4
line 268
;267:
;268:		AxisCopy( axisDefault, re->axis );
ADDRGP4 axisDefault
ARGP4
ADDRLP4 64
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRGP4 AxisCopy
CALLV
pop
line 269
;269:		re->hModel = cgs.media.shotgunBrassModel;
ADDRLP4 64
INDIRP4
CNSTI4 8
ADDP4
ADDRGP4 cgs+156680+236
INDIRI4
ASGNI4
line 270
;270:		le->bounceFactor = 0.3f;
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
CNSTF4 1050253722
ASGNF4
line 272
;271:
;272:		le->angles.trType = TR_LINEAR;
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 2
ASGNI4
line 273
;273:		le->angles.trTime = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 274
;274:		le->angles.trBase[0] = rand()&31;
ADDRLP4 124
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 124
INDIRI4
CNSTI4 31
BANDI4
CVIF4 4
ASGNF4
line 275
;275:		le->angles.trBase[1] = rand()&31;
ADDRLP4 128
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
ADDRLP4 128
INDIRI4
CNSTI4 31
BANDI4
CVIF4 4
ASGNF4
line 276
;276:		le->angles.trBase[2] = rand()&31;
ADDRLP4 132
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 88
ADDP4
ADDRLP4 132
INDIRI4
CNSTI4 31
BANDI4
CVIF4 4
ASGNF4
line 277
;277:		le->angles.trDelta[0] = 1;
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
CNSTF4 1065353216
ASGNF4
line 278
;278:		le->angles.trDelta[1] = 0.5;
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
CNSTF4 1056964608
ASGNF4
line 279
;279:		le->angles.trDelta[2] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
CNSTF4 0
ASGNF4
line 281
;280:
;281:		le->leFlags = LEF_TUMBLE;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 2
ASGNI4
line 282
;282:		le->leBounceSoundType = LEBS_BRASS;
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 2
ASGNI4
line 283
;283:		le->leMarkType = LEMT_NONE;
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 0
ASGNI4
line 284
;284:	}
LABELV $143
line 227
ADDRLP4 92
ADDRLP4 92
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 2
LTI4 $142
line 285
;285:}
LABELV $138
endproc CG_ShotgunEjectBrass 136 8
export CG_DottedRailTrail
proc CG_DottedRailTrail 580 4
line 326
;286:
;287:
;288:#ifdef MISSIONPACK
;289:/*
;290:==========================
;291:CG_NailgunEjectBrass
;292:==========================
;293:*/
;294:static void CG_NailgunEjectBrass( centity_t *cent ) {
;295:	localEntity_t	*smoke;
;296:	vec3_t			origin;
;297:	vec3_t			v[3];
;298:	vec3_t			offset;
;299:	vec3_t			xoffset;
;300:	vec3_t			up;
;301:
;302:	AnglesToAxis( cent->lerpAngles, v );
;303:
;304:	offset[0] = 0;
;305:	offset[1] = -12;
;306:	offset[2] = 24;
;307:
;308:	xoffset[0] = offset[0] * v[0][0] + offset[1] * v[1][0] + offset[2] * v[2][0];
;309:	xoffset[1] = offset[0] * v[0][1] + offset[1] * v[1][1] + offset[2] * v[2][1];
;310:	xoffset[2] = offset[0] * v[0][2] + offset[1] * v[1][2] + offset[2] * v[2][2];
;311:	VectorAdd( cent->lerpOrigin, xoffset, origin );
;312:
;313:	VectorSet( up, 0, 0, 64 );
;314:
;315:	smoke = CG_SmokePuff( origin, up, 32, 1, 1, 1, 0.33f, 700, cg.time, 0, 0, cgs.media.smokePuffShader );
;316:	// use the optimized local entity add
;317:	smoke->leType = LE_SCALE_FADE;
;318:}
;319:#endif
;320:
;321:/*
;322:==========================
;323:CG_DottedRailTrail
;324:==========================
;325:*/
;326:void CG_DottedRailTrail (clientInfo_t *ci, vec3_t start, vec3_t end, float len) {
line 333
;327:	vec3_t axis[36], move, move2, vec;
;328:	int    i, j, skip;
;329: 
;330:	localEntity_t *le;
;331:	refEntity_t   *re;
;332:
;333:	VectorCopy (start, move);
ADDRLP4 8
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 334
;334:	VectorSubtract (end, start, vec);
ADDRLP4 488
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 492
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 36
ADDRLP4 488
INDIRP4
INDIRF4
ADDRLP4 492
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 496
CNSTI4 4
ASGNI4
ADDRLP4 36+4
ADDRLP4 488
INDIRP4
ADDRLP4 496
INDIRI4
ADDP4
INDIRF4
ADDRLP4 492
INDIRP4
ADDRLP4 496
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 500
CNSTI4 8
ASGNI4
ADDRLP4 36+8
ADDRFP4 8
INDIRP4
ADDRLP4 500
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
ADDRLP4 500
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 335
;335:	VectorNormalize (vec);
ADDRLP4 36
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 338
;336:
;337:	//Dotted core
;338:	skip = 0;
ADDRLP4 484
CNSTI4 0
ASGNI4
line 339
;339:	j = 18;
ADDRLP4 4
CNSTI4 18
ASGNI4
line 340
;340:	for (i = 0; i < len; i++) {
ADDRLP4 48
CNSTI4 0
ASGNI4
ADDRGP4 $212
JUMPV
LABELV $209
line 341
;341:		if ( skip < i ) {
ADDRLP4 484
INDIRI4
ADDRLP4 48
INDIRI4
GEI4 $213
line 342
;342:			skip += 25;
ADDRLP4 484
ADDRLP4 484
INDIRI4
CNSTI4 25
ADDI4
ASGNI4
line 343
;343:			le = CG_AllocLocalEntity();
ADDRLP4 504
ADDRGP4 CG_AllocLocalEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 504
INDIRP4
ASGNP4
line 344
;344:			re = &le->refEntity;
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
ASGNP4
line 345
;345:			le->leFlags = LEF_PUFF_DONT_SCALE;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 1
ASGNI4
line 346
;346:			le->leType = LE_MOVE_SCALE_FADE;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 4
ASGNI4
line 347
;347:			le->startTime = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 348
;348:			le->endTime = (cg.time - 275) + cg_railTrailTime.integer;
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRGP4 cg+107604
INDIRI4
CNSTI4 275
SUBI4
ADDRGP4 cg_railTrailTime+12
INDIRI4
ADDI4
ASGNI4
line 349
;349:			le->lifeRate = 1.0 / (le->endTime - le->startTime);
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1065353216
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 351
;350:
;351:			re->shaderTime = cg.time / 1000.0f;
ADDRLP4 20
INDIRP4
CNSTI4 128
ADDP4
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
CNSTF4 1148846080
DIVF4
ASGNF4
line 352
;352:			re->reType = RT_SPRITE;
ADDRLP4 20
INDIRP4
CNSTI4 2
ASGNI4
line 353
;353:			re->radius = 1.5f;
ADDRLP4 20
INDIRP4
CNSTI4 132
ADDP4
CNSTF4 1069547520
ASGNF4
line 354
;354:			re->customShader = cgs.media.railRingsShader;
ADDRLP4 20
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+156680+240
INDIRI4
ASGNI4
line 356
;355:
;356:				if ( (ci->team != cgs.clientinfo[ cg.clientNum ].team && (strlen(cg_EnemyColors.string) == 2 || strlen(cg_EnemyColors.string) == 5)
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
EQI4 $239
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 512
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 512
INDIRI4
CNSTI4 2
EQI4 $238
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 516
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 516
INDIRI4
CNSTI4 5
NEI4 $239
LABELV $238
ADDRLP4 520
CNSTI4 3
ASGNI4
ADDRGP4 cgs+31456
INDIRI4
ADDRLP4 520
INDIRI4
LTI4 $239
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
ADDRLP4 520
INDIRI4
NEI4 $240
LABELV $239
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
GEI4 $221
ADDRFP4 0
INDIRP4
CNSTI4 1768
ADDP4
INDIRI4
CNSTI4 0
NEI4 $221
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 524
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 524
INDIRI4
CNSTI4 2
EQI4 $240
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 528
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 528
INDIRI4
CNSTI4 5
NEI4 $221
LABELV $240
line 358
;357:					&& cgs.gametype >= GT_TEAM && cgs.clientinfo[cg.clientNum].team != TEAM_SPECTATOR) 
;358:					|| ( cgs.gametype < GT_TEAM && !ci->localClient && (strlen(cg_EnemyColors.string) == 2 || strlen(cg_EnemyColors.string) == 5) ) ) {
line 359
;359:					re->shaderRGBA[0] = cgs.enemyColors[4][0];
ADDRLP4 20
INDIRP4
CNSTI4 116
ADDP4
ADDRGP4 cgs+157820+16
INDIRU1
ASGNU1
line 360
;360:					re->shaderRGBA[1] = cgs.enemyColors[4][1];
ADDRLP4 20
INDIRP4
CNSTI4 117
ADDP4
ADDRGP4 cgs+157820+16+1
INDIRU1
ASGNU1
line 361
;361:					re->shaderRGBA[2] = cgs.enemyColors[4][2];
ADDRLP4 20
INDIRP4
CNSTI4 118
ADDP4
ADDRGP4 cgs+157820+16+2
INDIRU1
ASGNU1
line 362
;362:					re->shaderRGBA[3] = 255;
ADDRLP4 20
INDIRP4
CNSTI4 119
ADDP4
CNSTU1 255
ASGNU1
line 363
;363:				} else if ( ci->team == cgs.clientinfo[ cg.clientNum ].team && cg_forceColors.integer && cgs.gametype >= GT_TEAM ) {
ADDRGP4 $222
JUMPV
LABELV $221
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
NEI4 $249
ADDRGP4 cg_forceColors+12
INDIRI4
CNSTI4 0
EQI4 $249
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $249
line 364
;364:					re->shaderRGBA[0] = cgs.clientinfo[cg.clientNum].color2[0];
ADDRLP4 536
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+112
ADDP4
INDIRF4
ASGNF4
ADDRLP4 540
CNSTF4 1325400064
ASGNF4
ADDRLP4 536
INDIRF4
ADDRLP4 540
INDIRF4
LTF4 $260
ADDRLP4 532
ADDRLP4 536
INDIRF4
ADDRLP4 540
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $261
JUMPV
LABELV $260
ADDRLP4 532
ADDRLP4 536
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $261
ADDRLP4 20
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 532
INDIRU4
CVUU1 4
ASGNU1
line 365
;365:					re->shaderRGBA[1] = cgs.clientinfo[cg.clientNum].color2[1];
ADDRLP4 548
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+112+4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 552
CNSTF4 1325400064
ASGNF4
ADDRLP4 548
INDIRF4
ADDRLP4 552
INDIRF4
LTF4 $267
ADDRLP4 544
ADDRLP4 548
INDIRF4
ADDRLP4 552
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $268
JUMPV
LABELV $267
ADDRLP4 544
ADDRLP4 548
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $268
ADDRLP4 20
INDIRP4
CNSTI4 117
ADDP4
ADDRLP4 544
INDIRU4
CVUU1 4
ASGNU1
line 366
;366:					re->shaderRGBA[2] = cgs.clientinfo[cg.clientNum].color2[2];
ADDRLP4 560
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+112+8
ADDP4
INDIRF4
ASGNF4
ADDRLP4 564
CNSTF4 1325400064
ASGNF4
ADDRLP4 560
INDIRF4
ADDRLP4 564
INDIRF4
LTF4 $274
ADDRLP4 556
ADDRLP4 560
INDIRF4
ADDRLP4 564
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $275
JUMPV
LABELV $274
ADDRLP4 556
ADDRLP4 560
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $275
ADDRLP4 20
INDIRP4
CNSTI4 118
ADDP4
ADDRLP4 556
INDIRU4
CVUU1 4
ASGNU1
line 367
;367:					re->shaderRGBA[3] = 255;
ADDRLP4 20
INDIRP4
CNSTI4 119
ADDP4
CNSTU1 255
ASGNU1
line 368
;368:				} else if ( ci->team == cgs.clientinfo[ cg.clientNum ].team && strlen(cg_TeamColors.string) != 3
ADDRGP4 $250
JUMPV
LABELV $249
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
NEI4 $276
ADDRGP4 cg_TeamColors+16
ARGP4
ADDRLP4 532
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 536
CNSTI4 3
ASGNI4
ADDRLP4 532
INDIRI4
ADDRLP4 536
INDIRI4
EQI4 $276
ADDRGP4 cgs+31456
INDIRI4
ADDRLP4 536
INDIRI4
LTI4 $276
ADDRFP4 0
INDIRP4
CNSTI4 1768
ADDP4
INDIRI4
CNSTI4 0
NEI4 $276
line 369
;369:					&& cgs.gametype >= GT_TEAM && !ci->localClient ) {
line 370
;370:					re->shaderRGBA[0] = cgs.teamColors[4][0];
ADDRLP4 20
INDIRP4
CNSTI4 116
ADDP4
ADDRGP4 cgs+157840+16
INDIRU1
ASGNU1
line 371
;371:					re->shaderRGBA[1] = cgs.teamColors[4][1];
ADDRLP4 20
INDIRP4
CNSTI4 117
ADDP4
ADDRGP4 cgs+157840+16+1
INDIRU1
ASGNU1
line 372
;372:					re->shaderRGBA[2] = cgs.teamColors[4][2];
ADDRLP4 20
INDIRP4
CNSTI4 118
ADDP4
ADDRGP4 cgs+157840+16+2
INDIRU1
ASGNU1
line 373
;373:					re->shaderRGBA[3] = 255;
ADDRLP4 20
INDIRP4
CNSTI4 119
ADDP4
CNSTU1 255
ASGNU1
line 374
;374:				} else {
ADDRGP4 $277
JUMPV
LABELV $276
line 375
;375:					re->shaderRGBA[0] = ci->color2[0] * 255;
ADDRLP4 544
CNSTF4 1132396544
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 548
CNSTF4 1325400064
ASGNF4
ADDRLP4 544
INDIRF4
ADDRLP4 548
INDIRF4
LTF4 $292
ADDRLP4 540
ADDRLP4 544
INDIRF4
ADDRLP4 548
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $293
JUMPV
LABELV $292
ADDRLP4 540
ADDRLP4 544
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $293
ADDRLP4 20
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 540
INDIRU4
CVUU1 4
ASGNU1
line 376
;376:					re->shaderRGBA[1] = ci->color2[1] * 255;
ADDRLP4 556
CNSTF4 1132396544
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 560
CNSTF4 1325400064
ASGNF4
ADDRLP4 556
INDIRF4
ADDRLP4 560
INDIRF4
LTF4 $295
ADDRLP4 552
ADDRLP4 556
INDIRF4
ADDRLP4 560
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $296
JUMPV
LABELV $295
ADDRLP4 552
ADDRLP4 556
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $296
ADDRLP4 20
INDIRP4
CNSTI4 117
ADDP4
ADDRLP4 552
INDIRU4
CVUU1 4
ASGNU1
line 377
;377:					re->shaderRGBA[2] = ci->color2[2] * 255;
ADDRLP4 568
CNSTF4 1132396544
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 572
CNSTF4 1325400064
ASGNF4
ADDRLP4 568
INDIRF4
ADDRLP4 572
INDIRF4
LTF4 $298
ADDRLP4 564
ADDRLP4 568
INDIRF4
ADDRLP4 572
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $299
JUMPV
LABELV $298
ADDRLP4 564
ADDRLP4 568
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $299
ADDRLP4 20
INDIRP4
CNSTI4 118
ADDP4
ADDRLP4 564
INDIRU4
CVUU1 4
ASGNU1
line 378
;378:					re->shaderRGBA[3] = 255;
ADDRLP4 20
INDIRP4
CNSTI4 119
ADDP4
CNSTU1 255
ASGNU1
line 379
;379:				}
LABELV $277
LABELV $250
LABELV $222
line 381
;380:
;381:				if ( (ci->team != cgs.clientinfo[ cg.clientNum ].team && 
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
EQI4 $318
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 540
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 540
INDIRI4
CNSTI4 2
EQI4 $317
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 544
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 544
INDIRI4
CNSTI4 5
NEI4 $318
LABELV $317
ADDRLP4 548
CNSTI4 3
ASGNI4
ADDRGP4 cgs+31456
INDIRI4
ADDRLP4 548
INDIRI4
LTI4 $318
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
ADDRLP4 548
INDIRI4
NEI4 $319
LABELV $318
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
GEI4 $300
ADDRFP4 0
INDIRP4
CNSTI4 1768
ADDP4
INDIRI4
CNSTI4 0
NEI4 $300
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 552
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 552
INDIRI4
CNSTI4 2
EQI4 $319
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 556
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 556
INDIRI4
CNSTI4 5
NEI4 $300
LABELV $319
line 384
;382:					( strlen(cg_EnemyColors.string) == 2 || strlen(cg_EnemyColors.string) == 5 ) 
;383:					&& cgs.gametype >= GT_TEAM && cgs.clientinfo[cg.clientNum].team != TEAM_SPECTATOR) || 
;384:					( cgs.gametype < GT_TEAM && !ci->localClient && (strlen(cg_EnemyColors.string) == 2 || strlen(cg_EnemyColors.string) == 5) )) {
line 385
;385:							le->color[0] = g_color_table[ColorIndex(cg_EnemyColors.string[4])][0] * 0.75;
ADDRGP4 cg_EnemyColors+16+4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 560
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
CNSTF4 1061158912
ADDRLP4 560
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
INDIRF4
MULF4
ASGNF4
line 386
;386:							le->color[1] = g_color_table[ColorIndex(cg_EnemyColors.string[4])][1] * 0.75;
ADDRGP4 cg_EnemyColors+16+4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 564
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
CNSTF4 1061158912
ADDRLP4 564
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+4
ADDP4
INDIRF4
MULF4
ASGNF4
line 387
;387:							le->color[2] = g_color_table[ColorIndex(cg_EnemyColors.string[4])][2] * 0.75;
ADDRGP4 cg_EnemyColors+16+4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 568
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
CNSTF4 1061158912
ADDRLP4 568
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+8
ADDP4
INDIRF4
MULF4
ASGNF4
line 388
;388:							le->color[3] = 1.0f;
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
CNSTF4 1065353216
ASGNF4
line 389
;389:				} else if ( ci->team == cgs.clientinfo[ cg.clientNum ].team && cg_forceColors.integer && cgs.gametype >= GT_TEAM ) {
ADDRGP4 $301
JUMPV
LABELV $300
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
NEI4 $328
ADDRGP4 cg_forceColors+12
INDIRI4
CNSTI4 0
EQI4 $328
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $328
line 390
;390:							le->color[0] = cgs.clientinfo[cg.clientNum].color2[0] * 0.75;
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
CNSTF4 1061158912
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+112
ADDP4
INDIRF4
MULF4
ASGNF4
line 391
;391:							le->color[1] = cgs.clientinfo[cg.clientNum].color2[1] * 0.75;
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
CNSTF4 1061158912
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+112+4
ADDP4
INDIRF4
MULF4
ASGNF4
line 392
;392:							le->color[2] = cgs.clientinfo[cg.clientNum].color2[2] * 0.75;
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
CNSTF4 1061158912
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+112+8
ADDP4
INDIRF4
MULF4
ASGNF4
line 393
;393:							le->color[3] = 1.0f;
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
CNSTF4 1065353216
ASGNF4
line 394
;394:				} else if ( ci->team == cgs.clientinfo[ cg.clientNum ].team && 
ADDRGP4 $329
JUMPV
LABELV $328
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
NEI4 $346
ADDRGP4 cg_TeamColors+16
ARGP4
ADDRLP4 560
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 560
INDIRI4
CNSTI4 2
EQI4 $354
ADDRGP4 cg_TeamColors+16
ARGP4
ADDRLP4 564
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 564
INDIRI4
CNSTI4 5
LTI4 $346
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $346
ADDRFP4 0
INDIRP4
CNSTI4 1768
ADDP4
INDIRI4
CNSTI4 0
NEI4 $346
LABELV $354
line 396
;395:					( strlen(cg_TeamColors.string) == 2 || strlen(cg_TeamColors.string) >= 5 
;396:					&& cgs.gametype >= GT_TEAM && !ci->localClient) ) {
line 397
;397:							le->color[0] = g_color_table[ColorIndex(cg_TeamColors.string[4])][0] * 0.75;
ADDRGP4 cg_TeamColors+16+4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 568
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
CNSTF4 1061158912
ADDRLP4 568
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
INDIRF4
MULF4
ASGNF4
line 398
;398:							le->color[1] = g_color_table[ColorIndex(cg_TeamColors.string[4])][1] * 0.75;
ADDRGP4 cg_TeamColors+16+4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 572
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
CNSTF4 1061158912
ADDRLP4 572
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+4
ADDP4
INDIRF4
MULF4
ASGNF4
line 399
;399:							le->color[2] = g_color_table[ColorIndex(cg_TeamColors.string[4])][2] * 0.75;
ADDRGP4 cg_TeamColors+16+4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 576
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
CNSTF4 1061158912
ADDRLP4 576
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+8
ADDP4
INDIRF4
MULF4
ASGNF4
line 400
;400:							le->color[3] = 1.0f;
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
CNSTF4 1065353216
ASGNF4
line 401
;401:				} else {
ADDRGP4 $347
JUMPV
LABELV $346
line 402
;402:					le->color[0] = ci->color2[0] * 0.75;
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
CNSTF4 1061158912
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRF4
MULF4
ASGNF4
line 403
;403:					le->color[1] = ci->color2[1] * 0.75;
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
CNSTF4 1061158912
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRF4
MULF4
ASGNF4
line 404
;404:					le->color[2] = ci->color2[2] * 0.75;
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
CNSTF4 1061158912
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
MULF4
ASGNF4
line 405
;405:					le->color[3] = 1.0f;
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
CNSTF4 1065353216
ASGNF4
line 406
;406:				}
LABELV $347
LABELV $329
LABELV $301
line 408
;407:
;408:			le->pos.trType = TR_LINEAR;
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTI4 2
ASGNI4
line 409
;409:			le->pos.trTime = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 411
;410:
;411:			VectorCopy( move, move2);
ADDRLP4 24
ADDRLP4 8
INDIRB
ASGNB 12
line 412
;412:			VectorMA(move2, 0, axis[j], move2);
ADDRLP4 568
CNSTF4 0
ASGNF4
ADDRLP4 572
CNSTI4 12
ADDRLP4 4
INDIRI4
MULI4
ASGNI4
ADDRLP4 24
ADDRLP4 24
INDIRF4
ADDRLP4 568
INDIRF4
ADDRLP4 572
INDIRI4
ADDRLP4 52
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 24+4
INDIRF4
ADDRLP4 568
INDIRF4
ADDRLP4 572
INDIRI4
ADDRLP4 52+4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 24+8
ADDRLP4 24+8
INDIRF4
CNSTF4 0
CNSTI4 12
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 52+8
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 413
;413:			VectorCopy(move2, le->pos.trBase);
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 24
INDIRB
ASGNB 12
line 415
;414:
;415:			le->pos.trDelta[0] = axis[j][0]*0;
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 0
CNSTI4 12
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 52
ADDP4
INDIRF4
MULF4
ASGNF4
line 416
;416:			le->pos.trDelta[1] = axis[j][1]*0;
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 0
CNSTI4 12
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 52+4
ADDP4
INDIRF4
MULF4
ASGNF4
line 417
;417:			le->pos.trDelta[2] = axis[j][2]*0;
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTF4 0
CNSTI4 12
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 52+8
ADDP4
INDIRF4
MULF4
ASGNF4
line 418
;418:		}
LABELV $213
line 420
;419:
;420:		VectorAdd (move, vec, move);
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
ASGNF4
ADDRLP4 8+4
ADDRLP4 8+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 8+8
ADDRLP4 8+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDF4
ASGNF4
line 422
;421:
;422:		j = j + 1 < 36 ? j + 1 : (j + 1) % 36;
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 36
GEI4 $379
ADDRLP4 504
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $380
JUMPV
LABELV $379
ADDRLP4 504
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 36
MODI4
ASGNI4
LABELV $380
ADDRLP4 4
ADDRLP4 504
INDIRI4
ASGNI4
line 423
;423:	}
LABELV $210
line 340
ADDRLP4 48
ADDRLP4 48
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $212
ADDRLP4 48
INDIRI4
CVIF4 4
ADDRFP4 12
INDIRF4
LTF4 $209
line 424
;424:}
LABELV $206
endproc CG_DottedRailTrail 580 4
export CG_RailTrail
proc CG_RailTrail 616 16
line 442
;425:
;426:/*********************************************************************************
;427:				PM Skin / Colors / Forcing rail colors
;428:
;429:		This next section of code is the railTrail drawing code, was setup to be
;430:	able to be like CPMA's cg_railStyle with the addition of an OSP like railTrail.
;431:	The forceColors code is somewhat self-explanatory if you know how color1 and
;432:	color2 effect the railTrail color. Not much different than any other refEntity.
;433:	It's cumbersome for sure, a lot messy too, the results are nice though.
;434:
;435:*********************************************************************************/
;436:
;437:/*
;438:==========================
;439:CG_RailTrail
;440:==========================
;441:*/
;442:void CG_RailTrail (clientInfo_t *ci, vec3_t start, vec3_t end) {
line 449
;443:	vec3_t axis[36], move, move2, next_move, vec, temp;
;444:	float  len;
;445:	int    i, j, skip;
;446: 
;447:	localEntity_t *le;
;448:	refEntity_t   *re;
;449:	len = 0;
ADDRLP4 500
CNSTF4 0
ASGNF4
line 455
;450: 
;451:#define RADIUS   4
;452:#define ROTATION 1
;453:#define SPACING  5
;454:
;455:	if ( !cg_railStyle.integer ) {
ADDRGP4 cg_railStyle+12
INDIRI4
CNSTI4 0
NEI4 $382
line 456
;456:		return;
ADDRGP4 $381
JUMPV
LABELV $382
line 459
;457:	}
;458:
;459:	start[2] -= 4;
ADDRLP4 516
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 516
INDIRP4
ADDRLP4 516
INDIRP4
INDIRF4
CNSTF4 1082130432
SUBF4
ASGNF4
line 460
;460:	VectorCopy (start, move);
ADDRLP4 8
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 461
;461:	VectorSubtract (end, start, vec);
ADDRLP4 520
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 524
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 520
INDIRP4
INDIRF4
ADDRLP4 524
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 528
CNSTI4 4
ASGNI4
ADDRLP4 24+4
ADDRLP4 520
INDIRP4
ADDRLP4 528
INDIRI4
ADDP4
INDIRF4
ADDRLP4 524
INDIRP4
ADDRLP4 528
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 532
CNSTI4 8
ASGNI4
ADDRLP4 24+8
ADDRFP4 8
INDIRP4
ADDRLP4 532
INDIRI4
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
ADDRLP4 532
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 462
;462:	len = VectorNormalize (vec);
ADDRLP4 24
ARGP4
ADDRLP4 536
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 500
ADDRLP4 536
INDIRF4
ASGNF4
line 464
;463:
;464:	if ( cg_railStyle.integer ==  4 || cg_railStyle.integer > 5 ) {
ADDRGP4 cg_railStyle+12
INDIRI4
CNSTI4 4
EQI4 $391
ADDRGP4 cg_railStyle+12
INDIRI4
CNSTI4 5
LEI4 $387
LABELV $391
line 465
;465:		CG_DottedRailTrail( ci, start, end, len);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 500
INDIRF4
ARGF4
ADDRGP4 CG_DottedRailTrail
CALLV
pop
line 466
;466:	}
LABELV $387
line 468
;467:	
;468:	if ( cg_railStyle.integer == 1 || cg_railStyle.integer == 3 || cg_railStyle.integer == 5 || cg_railStyle.integer >= 7 ) {
ADDRGP4 cg_railStyle+12
INDIRI4
CNSTI4 1
EQI4 $400
ADDRGP4 cg_railStyle+12
INDIRI4
CNSTI4 3
EQI4 $400
ADDRGP4 cg_railStyle+12
INDIRI4
CNSTI4 5
EQI4 $400
ADDRGP4 cg_railStyle+12
INDIRI4
CNSTI4 7
LTI4 $392
LABELV $400
line 469
;469:		PerpendicularVector(temp, vec);
ADDRLP4 484
ARGP4
ADDRLP4 24
ARGP4
ADDRGP4 PerpendicularVector
CALLV
pop
line 470
;470:		for (i = 0 ; i < 36; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $401
line 471
;471:			RotatePointAroundVector(axis[i], vec, temp, i * 10);//banshee 2.4 was 10
CNSTI4 12
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 40
ADDP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 484
ARGP4
CNSTI4 10
ADDRLP4 4
INDIRI4
MULI4
CVIF4 4
ARGF4
ADDRGP4 RotatePointAroundVector
CALLV
pop
line 472
;472:		}
LABELV $402
line 470
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 36
LTI4 $401
line 474
;473: 
;474:		le = CG_AllocLocalEntity();
ADDRLP4 540
ADDRGP4 CG_AllocLocalEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 540
INDIRP4
ASGNP4
line 475
;475:		re = &le->refEntity;
ADDRLP4 36
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
ASGNP4
line 477
;476: 
;477:		le->leType = LE_FADE_RGB;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 6
ASGNI4
line 478
;478:		le->startTime = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 479
;479:		le->endTime = cg.time + cg_railTrailTime.value;
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ADDRGP4 cg_railTrailTime+8
INDIRF4
ADDF4
CVFI4 4
ASGNI4
line 480
;480:		le->lifeRate = 1.0 / (le->endTime - le->startTime);
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1065353216
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 482
;481: 
;482:		re->shaderTime = cg.time / 1000.0f;
ADDRLP4 36
INDIRP4
CNSTI4 128
ADDP4
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
CNSTF4 1148846080
DIVF4
ASGNF4
line 483
;483:		re->reType = RT_RAIL_CORE;
ADDRLP4 36
INDIRP4
CNSTI4 4
ASGNI4
line 484
;484:		re->customShader = cgs.media.railCoreShader;
ADDRLP4 36
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+156680+244
INDIRI4
ASGNI4
line 486
;485: 
;486:		VectorCopy(start, re->origin);
ADDRLP4 36
INDIRP4
CNSTI4 68
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 487
;487:		VectorCopy(end, re->oldorigin);
ADDRLP4 36
INDIRP4
CNSTI4 84
ADDP4
ADDRFP4 8
INDIRP4
INDIRB
ASGNB 12
line 492
;488: 
;489:		//
;490:		//Color1
;491:		//
;492:			if ( (ci->team != cgs.clientinfo[ cg.clientNum ].team && (strlen(cg_EnemyColors.string) == 2 || strlen(cg_EnemyColors.string) == 5)
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
EQI4 $429
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 548
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 548
INDIRI4
CNSTI4 2
EQI4 $428
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 552
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 552
INDIRI4
CNSTI4 5
NEI4 $429
LABELV $428
ADDRLP4 556
CNSTI4 3
ASGNI4
ADDRGP4 cgs+31456
INDIRI4
ADDRLP4 556
INDIRI4
LTI4 $429
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
ADDRLP4 556
INDIRI4
NEI4 $430
LABELV $429
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
GEI4 $411
ADDRFP4 0
INDIRP4
CNSTI4 1768
ADDP4
INDIRI4
CNSTI4 0
NEI4 $411
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 560
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 560
INDIRI4
CNSTI4 2
EQI4 $430
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 564
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 564
INDIRI4
CNSTI4 5
NEI4 $411
LABELV $430
line 494
;493:				&& cgs.gametype >= GT_TEAM && cgs.clientinfo[cg.clientNum].team != TEAM_SPECTATOR) || 
;494:				( cgs.gametype < GT_TEAM && !ci->localClient && (strlen(cg_EnemyColors.string) == 2 || strlen(cg_EnemyColors.string) == 5) ) ) {
line 495
;495:				re->shaderRGBA[0] = cgs.enemyColors[0][0];
ADDRLP4 36
INDIRP4
CNSTI4 116
ADDP4
ADDRGP4 cgs+157820
INDIRU1
ASGNU1
line 496
;496:				re->shaderRGBA[1] = cgs.enemyColors[0][1];
ADDRLP4 36
INDIRP4
CNSTI4 117
ADDP4
ADDRGP4 cgs+157820+1
INDIRU1
ASGNU1
line 497
;497:				re->shaderRGBA[2] = cgs.enemyColors[0][2];
ADDRLP4 36
INDIRP4
CNSTI4 118
ADDP4
ADDRGP4 cgs+157820+2
INDIRU1
ASGNU1
line 498
;498:				re->shaderRGBA[3] = 255;
ADDRLP4 36
INDIRP4
CNSTI4 119
ADDP4
CNSTU1 255
ASGNU1
line 499
;499:			} else if ( ci->team == cgs.clientinfo[ cg.clientNum ].team && cg_forceColors.integer && cgs.gametype >= GT_TEAM ) {
ADDRGP4 $412
JUMPV
LABELV $411
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
NEI4 $436
ADDRGP4 cg_forceColors+12
INDIRI4
CNSTI4 0
EQI4 $436
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $436
line 500
;500:				re->shaderRGBA[0] = cgs.clientinfo[cg.clientNum].color1[0];
ADDRLP4 572
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+76
ADDP4
INDIRF4
ASGNF4
ADDRLP4 576
CNSTF4 1325400064
ASGNF4
ADDRLP4 572
INDIRF4
ADDRLP4 576
INDIRF4
LTF4 $447
ADDRLP4 568
ADDRLP4 572
INDIRF4
ADDRLP4 576
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $448
JUMPV
LABELV $447
ADDRLP4 568
ADDRLP4 572
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $448
ADDRLP4 36
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 568
INDIRU4
CVUU1 4
ASGNU1
line 501
;501:				re->shaderRGBA[1] = cgs.clientinfo[cg.clientNum].color1[1];
ADDRLP4 584
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+76+4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 588
CNSTF4 1325400064
ASGNF4
ADDRLP4 584
INDIRF4
ADDRLP4 588
INDIRF4
LTF4 $454
ADDRLP4 580
ADDRLP4 584
INDIRF4
ADDRLP4 588
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $455
JUMPV
LABELV $454
ADDRLP4 580
ADDRLP4 584
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $455
ADDRLP4 36
INDIRP4
CNSTI4 117
ADDP4
ADDRLP4 580
INDIRU4
CVUU1 4
ASGNU1
line 502
;502:				re->shaderRGBA[2] = cgs.clientinfo[cg.clientNum].color1[2];
ADDRLP4 596
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+76+8
ADDP4
INDIRF4
ASGNF4
ADDRLP4 600
CNSTF4 1325400064
ASGNF4
ADDRLP4 596
INDIRF4
ADDRLP4 600
INDIRF4
LTF4 $461
ADDRLP4 592
ADDRLP4 596
INDIRF4
ADDRLP4 600
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $462
JUMPV
LABELV $461
ADDRLP4 592
ADDRLP4 596
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $462
ADDRLP4 36
INDIRP4
CNSTI4 118
ADDP4
ADDRLP4 592
INDIRU4
CVUU1 4
ASGNU1
line 503
;503:				re->shaderRGBA[3] = 255;
ADDRLP4 36
INDIRP4
CNSTI4 119
ADDP4
CNSTU1 255
ASGNU1
line 504
;504:			} else if ( ci->team == cgs.clientinfo[ cg.clientNum ].team && strlen(cg_TeamColors.string) != 3 
ADDRGP4 $437
JUMPV
LABELV $436
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
NEI4 $463
ADDRGP4 cg_TeamColors+16
ARGP4
ADDRLP4 568
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 572
CNSTI4 3
ASGNI4
ADDRLP4 568
INDIRI4
ADDRLP4 572
INDIRI4
EQI4 $463
ADDRGP4 cgs+31456
INDIRI4
ADDRLP4 572
INDIRI4
LTI4 $463
ADDRFP4 0
INDIRP4
CNSTI4 1768
ADDP4
INDIRI4
CNSTI4 0
NEI4 $463
line 505
;505:				&& cgs.gametype >= GT_TEAM && !ci->localClient ) {
line 506
;506:				re->shaderRGBA[0] = cgs.teamColors[0][0];
ADDRLP4 36
INDIRP4
CNSTI4 116
ADDP4
ADDRGP4 cgs+157840
INDIRU1
ASGNU1
line 507
;507:				re->shaderRGBA[1] = cgs.teamColors[0][1];
ADDRLP4 36
INDIRP4
CNSTI4 117
ADDP4
ADDRGP4 cgs+157840+1
INDIRU1
ASGNU1
line 508
;508:				re->shaderRGBA[2] = cgs.teamColors[0][2];
ADDRLP4 36
INDIRP4
CNSTI4 118
ADDP4
ADDRGP4 cgs+157840+2
INDIRU1
ASGNU1
line 509
;509:				re->shaderRGBA[3] = 255;
ADDRLP4 36
INDIRP4
CNSTI4 119
ADDP4
CNSTU1 255
ASGNU1
line 510
;510:			} else {
ADDRGP4 $464
JUMPV
LABELV $463
line 511
;511:				re->shaderRGBA[0] = ci->color1[0] * 255;
ADDRLP4 580
CNSTF4 1132396544
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 584
CNSTF4 1325400064
ASGNF4
ADDRLP4 580
INDIRF4
ADDRLP4 584
INDIRF4
LTF4 $476
ADDRLP4 576
ADDRLP4 580
INDIRF4
ADDRLP4 584
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $477
JUMPV
LABELV $476
ADDRLP4 576
ADDRLP4 580
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $477
ADDRLP4 36
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 576
INDIRU4
CVUU1 4
ASGNU1
line 512
;512:				re->shaderRGBA[1] = ci->color1[1] * 255;
ADDRLP4 592
CNSTF4 1132396544
ADDRFP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 596
CNSTF4 1325400064
ASGNF4
ADDRLP4 592
INDIRF4
ADDRLP4 596
INDIRF4
LTF4 $479
ADDRLP4 588
ADDRLP4 592
INDIRF4
ADDRLP4 596
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $480
JUMPV
LABELV $479
ADDRLP4 588
ADDRLP4 592
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $480
ADDRLP4 36
INDIRP4
CNSTI4 117
ADDP4
ADDRLP4 588
INDIRU4
CVUU1 4
ASGNU1
line 513
;513:				re->shaderRGBA[2] = ci->color1[2] * 255;
ADDRLP4 604
CNSTF4 1132396544
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 608
CNSTF4 1325400064
ASGNF4
ADDRLP4 604
INDIRF4
ADDRLP4 608
INDIRF4
LTF4 $482
ADDRLP4 600
ADDRLP4 604
INDIRF4
ADDRLP4 608
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $483
JUMPV
LABELV $482
ADDRLP4 600
ADDRLP4 604
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $483
ADDRLP4 36
INDIRP4
CNSTI4 118
ADDP4
ADDRLP4 600
INDIRU4
CVUU1 4
ASGNU1
line 514
;514:				re->shaderRGBA[3] = 255;
ADDRLP4 36
INDIRP4
CNSTI4 119
ADDP4
CNSTU1 255
ASGNU1
line 515
;515:			}
LABELV $464
LABELV $437
LABELV $412
line 517
;516:
;517:			if ( (ci->team != cgs.clientinfo[ cg.clientNum ].team && (strlen(cg_EnemyColors.string) == 2 || strlen(cg_EnemyColors.string) == 5)
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
EQI4 $502
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 576
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 576
INDIRI4
CNSTI4 2
EQI4 $501
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 580
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 580
INDIRI4
CNSTI4 5
NEI4 $502
LABELV $501
ADDRLP4 584
CNSTI4 3
ASGNI4
ADDRGP4 cgs+31456
INDIRI4
ADDRLP4 584
INDIRI4
LTI4 $502
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
ADDRLP4 584
INDIRI4
NEI4 $503
LABELV $502
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
GEI4 $484
ADDRFP4 0
INDIRP4
CNSTI4 1768
ADDP4
INDIRI4
CNSTI4 0
NEI4 $484
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 588
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 588
INDIRI4
CNSTI4 2
EQI4 $503
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 592
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 592
INDIRI4
CNSTI4 5
NEI4 $484
LABELV $503
line 519
;518:				&& cgs.gametype >= GT_TEAM && cgs.clientinfo[cg.clientNum].team != TEAM_SPECTATOR) ||
;519:				( cgs.gametype < GT_TEAM && !ci->localClient && (strlen(cg_EnemyColors.string) == 2 || strlen(cg_EnemyColors.string) == 5) ) ) {
line 520
;520:						le->color[0] = g_color_table[ColorIndex(cg_EnemyColors.string[0])][0] * 0.75;
ADDRGP4 cg_EnemyColors+16
INDIRI1
CVII4 1
ARGI4
ADDRLP4 596
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
CNSTF4 1061158912
ADDRLP4 596
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
INDIRF4
MULF4
ASGNF4
line 521
;521:						le->color[1] = g_color_table[ColorIndex(cg_EnemyColors.string[0])][1] * 0.75;
ADDRGP4 cg_EnemyColors+16
INDIRI1
CVII4 1
ARGI4
ADDRLP4 600
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
CNSTF4 1061158912
ADDRLP4 600
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+4
ADDP4
INDIRF4
MULF4
ASGNF4
line 522
;522:						le->color[2] = g_color_table[ColorIndex(cg_EnemyColors.string[0])][2] * 0.75;
ADDRGP4 cg_EnemyColors+16
INDIRI1
CVII4 1
ARGI4
ADDRLP4 604
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
CNSTF4 1061158912
ADDRLP4 604
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+8
ADDP4
INDIRF4
MULF4
ASGNF4
line 523
;523:						le->color[3] = 1.0f;
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
CNSTF4 1065353216
ASGNF4
line 524
;524:				} else if ( ci->team == cgs.clientinfo[ cg.clientNum ].team && cg_forceColors.integer && cgs.gametype >= GT_TEAM ) {
ADDRGP4 $485
JUMPV
LABELV $484
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
NEI4 $509
ADDRGP4 cg_forceColors+12
INDIRI4
CNSTI4 0
EQI4 $509
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $509
line 525
;525:							le->color[0] = cgs.clientinfo[cg.clientNum].color1[0] * 0.75;
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
CNSTF4 1061158912
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+76
ADDP4
INDIRF4
MULF4
ASGNF4
line 526
;526:							le->color[1] = cgs.clientinfo[cg.clientNum].color1[1] * 0.75;
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
CNSTF4 1061158912
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+76+4
ADDP4
INDIRF4
MULF4
ASGNF4
line 527
;527:							le->color[2] = cgs.clientinfo[cg.clientNum].color1[2] * 0.75;
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
CNSTF4 1061158912
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+76+8
ADDP4
INDIRF4
MULF4
ASGNF4
line 528
;528:							le->color[3] = 1.0f;
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
CNSTF4 1065353216
ASGNF4
line 529
;529:				} else if ( ci->team == cgs.clientinfo[ cg.clientNum ].team && strlen(cg_TeamColors.string) != 3
ADDRGP4 $510
JUMPV
LABELV $509
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
NEI4 $527
ADDRGP4 cg_TeamColors+16
ARGP4
ADDRLP4 596
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 600
CNSTI4 3
ASGNI4
ADDRLP4 596
INDIRI4
ADDRLP4 600
INDIRI4
EQI4 $527
ADDRGP4 cgs+31456
INDIRI4
ADDRLP4 600
INDIRI4
LTI4 $527
ADDRFP4 0
INDIRP4
CNSTI4 1768
ADDP4
INDIRI4
CNSTI4 0
NEI4 $527
line 530
;530:					&& cgs.gametype >= GT_TEAM && !ci->localClient ) {
line 531
;531:							le->color[0] = g_color_table[ColorIndex(cg_TeamColors.string[0])][0] * 0.75;
ADDRGP4 cg_TeamColors+16
INDIRI1
CVII4 1
ARGI4
ADDRLP4 604
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
CNSTF4 1061158912
ADDRLP4 604
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
INDIRF4
MULF4
ASGNF4
line 532
;532:							le->color[1] = g_color_table[ColorIndex(cg_TeamColors.string[0])][1] * 0.75;
ADDRGP4 cg_TeamColors+16
INDIRI1
CVII4 1
ARGI4
ADDRLP4 608
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
CNSTF4 1061158912
ADDRLP4 608
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+4
ADDP4
INDIRF4
MULF4
ASGNF4
line 533
;533:							le->color[2] = g_color_table[ColorIndex(cg_TeamColors.string[0])][2] * 0.75;
ADDRGP4 cg_TeamColors+16
INDIRI1
CVII4 1
ARGI4
ADDRLP4 612
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
CNSTF4 1061158912
ADDRLP4 612
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+8
ADDP4
INDIRF4
MULF4
ASGNF4
line 534
;534:							le->color[3] = 1.0f;
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
CNSTF4 1065353216
ASGNF4
line 535
;535:				} else {
ADDRGP4 $528
JUMPV
LABELV $527
line 536
;536:					le->color[0] = ci->color1[0] * 0.75;
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
CNSTF4 1061158912
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
MULF4
ASGNF4
line 537
;537:					le->color[1] = ci->color1[1] * 0.75;
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
CNSTF4 1061158912
ADDRFP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
MULF4
ASGNF4
line 538
;538:					le->color[2] = ci->color1[2] * 0.75;
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
CNSTF4 1061158912
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
MULF4
ASGNF4
line 539
;539:					le->color[3] = 1.0f;
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
CNSTF4 1065353216
ASGNF4
line 540
;540:				}
LABELV $528
LABELV $510
LABELV $485
line 542
;541:
;542:		AxisClear( re->axis );
ADDRLP4 36
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRGP4 AxisClear
CALLV
pop
line 544
;543: 
;544:		VectorMA(move, 20, vec, move);
ADDRLP4 604
CNSTF4 1101004800
ASGNF4
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 604
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 8+4
ADDRLP4 8+4
INDIRF4
ADDRLP4 604
INDIRF4
ADDRLP4 24+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 8+8
ADDRLP4 8+8
INDIRF4
CNSTF4 1101004800
ADDRLP4 24+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 545
;545:		VectorCopy(move, next_move);
ADDRLP4 504
ADDRLP4 8
INDIRB
ASGNB 12
line 546
;546:		VectorScale (vec, SPACING, vec);
ADDRLP4 608
CNSTF4 1084227584
ASGNF4
ADDRLP4 24
ADDRLP4 608
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 608
INDIRF4
ADDRLP4 24+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 24+8
CNSTF4 1084227584
ADDRLP4 24+8
INDIRF4
MULF4
ASGNF4
line 547
;547:	}
LABELV $392
line 549
;548:
;549:	if ( cg_railStyle.integer == 1 || cg_railStyle.integer == 5 ) {
ADDRGP4 cg_railStyle+12
INDIRI4
CNSTI4 1
EQI4 $553
ADDRGP4 cg_railStyle+12
INDIRI4
CNSTI4 5
NEI4 $549
LABELV $553
line 551
;550:		// nudge down a bit so it isn't exactly in center
;551:		re->origin[2] -= 8;
ADDRLP4 540
ADDRLP4 36
INDIRP4
CNSTI4 76
ADDP4
ASGNP4
ADDRLP4 540
INDIRP4
ADDRLP4 540
INDIRP4
INDIRF4
CNSTF4 1090519040
SUBF4
ASGNF4
line 552
;552:		re->oldorigin[2] -= 8;
ADDRLP4 544
ADDRLP4 36
INDIRP4
CNSTI4 92
ADDP4
ASGNP4
ADDRLP4 544
INDIRP4
ADDRLP4 544
INDIRP4
INDIRF4
CNSTF4 1090519040
SUBF4
ASGNF4
line 553
;553:		return;
ADDRGP4 $381
JUMPV
LABELV $549
line 556
;554:	}
;555:
;556:	if ( cg_railStyle.integer == 2 || cg_railStyle.integer == 3 || cg_railStyle.integer  == 6 || cg_railStyle.integer  == 7 ) {
ADDRGP4 cg_railStyle+12
INDIRI4
CNSTI4 2
EQI4 $562
ADDRGP4 cg_railStyle+12
INDIRI4
CNSTI4 3
EQI4 $562
ADDRGP4 cg_railStyle+12
INDIRI4
CNSTI4 6
EQI4 $562
ADDRGP4 cg_railStyle+12
INDIRI4
CNSTI4 7
NEI4 $554
LABELV $562
line 557
;557:		if ( cg_railStyle.integer == 2 || cg_railStyle.integer == 6 ) {
ADDRGP4 cg_railStyle+12
INDIRI4
CNSTI4 2
EQI4 $567
ADDRGP4 cg_railStyle+12
INDIRI4
CNSTI4 6
NEI4 $563
LABELV $567
line 558
;558:			PerpendicularVector(temp, vec);
ADDRLP4 484
ARGP4
ADDRLP4 24
ARGP4
ADDRGP4 PerpendicularVector
CALLV
pop
line 559
;559:			for (i = 0 ; i < 36; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $568
line 560
;560:				RotatePointAroundVector(axis[i], vec, temp, i * 10);//banshee 2.4 was 10
CNSTI4 12
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 40
ADDP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 484
ARGP4
CNSTI4 10
ADDRLP4 4
INDIRI4
MULI4
CVIF4 4
ARGF4
ADDRGP4 RotatePointAroundVector
CALLV
pop
line 561
;561:			}
LABELV $569
line 559
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 36
LTI4 $568
line 562
;562:			VectorMA(move, 20, vec, move);
ADDRLP4 540
CNSTF4 1101004800
ASGNF4
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 540
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 8+4
ADDRLP4 8+4
INDIRF4
ADDRLP4 540
INDIRF4
ADDRLP4 24+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 8+8
ADDRLP4 8+8
INDIRF4
CNSTF4 1101004800
ADDRLP4 24+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 563
;563:			VectorCopy(move, next_move);
ADDRLP4 504
ADDRLP4 8
INDIRB
ASGNB 12
line 564
;564:			VectorScale (vec, SPACING, vec);
ADDRLP4 544
CNSTF4 1084227584
ASGNF4
ADDRLP4 24
ADDRLP4 544
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 544
INDIRF4
ADDRLP4 24+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 24+8
CNSTF4 1084227584
ADDRLP4 24+8
INDIRF4
MULF4
ASGNF4
line 565
;565:		}
LABELV $563
line 566
;566:		skip = -1;
ADDRLP4 496
CNSTI4 -1
ASGNI4
line 568
;567:
;568:		j = 18;
ADDRLP4 20
CNSTI4 18
ASGNI4
line 569
;569:		for (i = 0; i < len; i += SPACING) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $585
JUMPV
LABELV $582
line 570
;570:			if (i != skip) {
ADDRLP4 4
INDIRI4
ADDRLP4 496
INDIRI4
EQI4 $586
line 571
;571:				skip = i + SPACING;
ADDRLP4 496
ADDRLP4 4
INDIRI4
CNSTI4 5
ADDI4
ASGNI4
line 572
;572:				le = CG_AllocLocalEntity();
ADDRLP4 540
ADDRGP4 CG_AllocLocalEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 540
INDIRP4
ASGNP4
line 573
;573:				re = &le->refEntity;
ADDRLP4 36
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
ASGNP4
line 574
;574:				le->leFlags = LEF_PUFF_DONT_SCALE;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 1
ASGNI4
line 575
;575:				le->leType = LE_MOVE_SCALE_FADE;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 4
ASGNI4
line 576
;576:				le->startTime = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 577
;577:				le->endTime = cg.time + (i>>1) + 600;
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 1
RSHI4
ADDI4
CNSTI4 600
ADDI4
ASGNI4
line 578
;578:				le->lifeRate = 1.0 / (le->endTime - le->startTime);
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1065353216
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 580
;579:
;580:				re->shaderTime = cg.time / 1000.0f;
ADDRLP4 36
INDIRP4
CNSTI4 128
ADDP4
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
CNSTF4 1148846080
DIVF4
ASGNF4
line 581
;581:				re->reType = RT_SPRITE;
ADDRLP4 36
INDIRP4
CNSTI4 2
ASGNI4
line 582
;582:				re->radius = 1.1f;
ADDRLP4 36
INDIRP4
CNSTI4 132
ADDP4
CNSTF4 1066192077
ASGNF4
line 583
;583:				re->customShader = cgs.media.railRingsShader;
ADDRLP4 36
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+156680+240
INDIRI4
ASGNI4
line 585
;584:
;585:					if ( (ci->team != cgs.clientinfo[ cg.clientNum ].team && (strlen(cg_EnemyColors.string) == 2 || strlen(cg_EnemyColors.string) == 5)
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
EQI4 $611
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 548
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 548
INDIRI4
CNSTI4 2
EQI4 $610
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 552
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 552
INDIRI4
CNSTI4 5
NEI4 $611
LABELV $610
ADDRLP4 556
CNSTI4 3
ASGNI4
ADDRGP4 cgs+31456
INDIRI4
ADDRLP4 556
INDIRI4
LTI4 $611
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
ADDRLP4 556
INDIRI4
NEI4 $612
LABELV $611
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
GEI4 $593
ADDRFP4 0
INDIRP4
CNSTI4 1768
ADDP4
INDIRI4
CNSTI4 0
NEI4 $593
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 560
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 560
INDIRI4
CNSTI4 2
EQI4 $612
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 564
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 564
INDIRI4
CNSTI4 5
NEI4 $593
LABELV $612
line 587
;586:						&& cgs.gametype >= GT_TEAM && cgs.clientinfo[cg.clientNum].team != TEAM_SPECTATOR) 
;587:						|| ( cgs.gametype < GT_TEAM && !ci->localClient && (strlen(cg_EnemyColors.string) == 2 || strlen(cg_EnemyColors.string) == 5) ) ) {
line 588
;588:						re->shaderRGBA[0] = cgs.enemyColors[4][0];
ADDRLP4 36
INDIRP4
CNSTI4 116
ADDP4
ADDRGP4 cgs+157820+16
INDIRU1
ASGNU1
line 589
;589:						re->shaderRGBA[1] = cgs.enemyColors[4][1];
ADDRLP4 36
INDIRP4
CNSTI4 117
ADDP4
ADDRGP4 cgs+157820+16+1
INDIRU1
ASGNU1
line 590
;590:						re->shaderRGBA[2] = cgs.enemyColors[4][2];
ADDRLP4 36
INDIRP4
CNSTI4 118
ADDP4
ADDRGP4 cgs+157820+16+2
INDIRU1
ASGNU1
line 591
;591:						re->shaderRGBA[3] = 255;
ADDRLP4 36
INDIRP4
CNSTI4 119
ADDP4
CNSTU1 255
ASGNU1
line 592
;592:					} else if ( ci->team == cgs.clientinfo[ cg.clientNum ].team && cg_forceColors.integer && cgs.gametype >= GT_TEAM ) {
ADDRGP4 $594
JUMPV
LABELV $593
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
NEI4 $621
ADDRGP4 cg_forceColors+12
INDIRI4
CNSTI4 0
EQI4 $621
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $621
line 593
;593:						re->shaderRGBA[0] = cgs.clientinfo[cg.clientNum].color2[0];
ADDRLP4 572
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+112
ADDP4
INDIRF4
ASGNF4
ADDRLP4 576
CNSTF4 1325400064
ASGNF4
ADDRLP4 572
INDIRF4
ADDRLP4 576
INDIRF4
LTF4 $632
ADDRLP4 568
ADDRLP4 572
INDIRF4
ADDRLP4 576
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $633
JUMPV
LABELV $632
ADDRLP4 568
ADDRLP4 572
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $633
ADDRLP4 36
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 568
INDIRU4
CVUU1 4
ASGNU1
line 594
;594:						re->shaderRGBA[1] = cgs.clientinfo[cg.clientNum].color2[1];
ADDRLP4 584
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+112+4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 588
CNSTF4 1325400064
ASGNF4
ADDRLP4 584
INDIRF4
ADDRLP4 588
INDIRF4
LTF4 $639
ADDRLP4 580
ADDRLP4 584
INDIRF4
ADDRLP4 588
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $640
JUMPV
LABELV $639
ADDRLP4 580
ADDRLP4 584
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $640
ADDRLP4 36
INDIRP4
CNSTI4 117
ADDP4
ADDRLP4 580
INDIRU4
CVUU1 4
ASGNU1
line 595
;595:						re->shaderRGBA[2] = cgs.clientinfo[cg.clientNum].color2[2];
ADDRLP4 596
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+112+8
ADDP4
INDIRF4
ASGNF4
ADDRLP4 600
CNSTF4 1325400064
ASGNF4
ADDRLP4 596
INDIRF4
ADDRLP4 600
INDIRF4
LTF4 $646
ADDRLP4 592
ADDRLP4 596
INDIRF4
ADDRLP4 600
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $647
JUMPV
LABELV $646
ADDRLP4 592
ADDRLP4 596
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $647
ADDRLP4 36
INDIRP4
CNSTI4 118
ADDP4
ADDRLP4 592
INDIRU4
CVUU1 4
ASGNU1
line 596
;596:						re->shaderRGBA[3] = 255;
ADDRLP4 36
INDIRP4
CNSTI4 119
ADDP4
CNSTU1 255
ASGNU1
line 597
;597:					} else if ( ci->team == cgs.clientinfo[ cg.clientNum ].team && strlen(cg_TeamColors.string) != 3
ADDRGP4 $622
JUMPV
LABELV $621
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
NEI4 $648
ADDRGP4 cg_TeamColors+16
ARGP4
ADDRLP4 568
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 572
CNSTI4 3
ASGNI4
ADDRLP4 568
INDIRI4
ADDRLP4 572
INDIRI4
EQI4 $648
ADDRGP4 cgs+31456
INDIRI4
ADDRLP4 572
INDIRI4
LTI4 $648
ADDRFP4 0
INDIRP4
CNSTI4 1768
ADDP4
INDIRI4
CNSTI4 0
NEI4 $648
line 598
;598:						&& cgs.gametype >= GT_TEAM && !ci->localClient ) {
line 599
;599:						re->shaderRGBA[0] = cgs.teamColors[4][0];
ADDRLP4 36
INDIRP4
CNSTI4 116
ADDP4
ADDRGP4 cgs+157840+16
INDIRU1
ASGNU1
line 600
;600:						re->shaderRGBA[1] = cgs.teamColors[4][1];
ADDRLP4 36
INDIRP4
CNSTI4 117
ADDP4
ADDRGP4 cgs+157840+16+1
INDIRU1
ASGNU1
line 601
;601:						re->shaderRGBA[2] = cgs.teamColors[4][2];
ADDRLP4 36
INDIRP4
CNSTI4 118
ADDP4
ADDRGP4 cgs+157840+16+2
INDIRU1
ASGNU1
line 602
;602:						re->shaderRGBA[3] = 255;
ADDRLP4 36
INDIRP4
CNSTI4 119
ADDP4
CNSTU1 255
ASGNU1
line 603
;603:					} else {
ADDRGP4 $649
JUMPV
LABELV $648
line 604
;604:						re->shaderRGBA[0] = ci->color2[0] * 255;
ADDRLP4 580
CNSTF4 1132396544
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 584
CNSTF4 1325400064
ASGNF4
ADDRLP4 580
INDIRF4
ADDRLP4 584
INDIRF4
LTF4 $664
ADDRLP4 576
ADDRLP4 580
INDIRF4
ADDRLP4 584
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $665
JUMPV
LABELV $664
ADDRLP4 576
ADDRLP4 580
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $665
ADDRLP4 36
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 576
INDIRU4
CVUU1 4
ASGNU1
line 605
;605:						re->shaderRGBA[1] = ci->color2[1] * 255;
ADDRLP4 592
CNSTF4 1132396544
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 596
CNSTF4 1325400064
ASGNF4
ADDRLP4 592
INDIRF4
ADDRLP4 596
INDIRF4
LTF4 $667
ADDRLP4 588
ADDRLP4 592
INDIRF4
ADDRLP4 596
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $668
JUMPV
LABELV $667
ADDRLP4 588
ADDRLP4 592
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $668
ADDRLP4 36
INDIRP4
CNSTI4 117
ADDP4
ADDRLP4 588
INDIRU4
CVUU1 4
ASGNU1
line 606
;606:						re->shaderRGBA[2] = ci->color2[2] * 255;
ADDRLP4 604
CNSTF4 1132396544
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 608
CNSTF4 1325400064
ASGNF4
ADDRLP4 604
INDIRF4
ADDRLP4 608
INDIRF4
LTF4 $670
ADDRLP4 600
ADDRLP4 604
INDIRF4
ADDRLP4 608
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $671
JUMPV
LABELV $670
ADDRLP4 600
ADDRLP4 604
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $671
ADDRLP4 36
INDIRP4
CNSTI4 118
ADDP4
ADDRLP4 600
INDIRU4
CVUU1 4
ASGNU1
line 607
;607:						re->shaderRGBA[3] = 255;
ADDRLP4 36
INDIRP4
CNSTI4 119
ADDP4
CNSTU1 255
ASGNU1
line 608
;608:					}
LABELV $649
LABELV $622
LABELV $594
line 610
;609:
;610:					if ( (ci->team != cgs.clientinfo[ cg.clientNum ].team && 
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
EQI4 $689
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 576
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 576
INDIRI4
CNSTI4 2
EQI4 $688
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 580
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 580
INDIRI4
CNSTI4 5
NEI4 $689
LABELV $688
ADDRLP4 584
CNSTI4 3
ASGNI4
ADDRGP4 cgs+31456
INDIRI4
ADDRLP4 584
INDIRI4
LTI4 $689
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
ADDRLP4 584
INDIRI4
NEI4 $685
LABELV $689
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
GEI4 $672
ADDRFP4 0
INDIRP4
CNSTI4 1768
ADDP4
INDIRI4
CNSTI4 0
NEI4 $672
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 588
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 588
INDIRI4
CNSTI4 3
EQI4 $672
LABELV $685
line 613
;611:						( strlen(cg_EnemyColors.string) == 2 || strlen(cg_EnemyColors.string) == 5 ) 
;612:						&& cgs.gametype >= GT_TEAM && cgs.clientinfo[cg.clientNum].team != TEAM_SPECTATOR) || 
;613:						( cgs.gametype < GT_TEAM && !ci->localClient && strlen(cg_EnemyColors.string) !=3 )) {
line 614
;614:								le->color[0] = g_color_table[ColorIndex(cg_EnemyColors.string[4])][0] * 0.75;
ADDRGP4 cg_EnemyColors+16+4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 592
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
CNSTF4 1061158912
ADDRLP4 592
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
INDIRF4
MULF4
ASGNF4
line 615
;615:								le->color[1] = g_color_table[ColorIndex(cg_EnemyColors.string[4])][1] * 0.75;
ADDRGP4 cg_EnemyColors+16+4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 596
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
CNSTF4 1061158912
ADDRLP4 596
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+4
ADDP4
INDIRF4
MULF4
ASGNF4
line 616
;616:								le->color[2] = g_color_table[ColorIndex(cg_EnemyColors.string[4])][2] * 0.75;
ADDRGP4 cg_EnemyColors+16+4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 600
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
CNSTF4 1061158912
ADDRLP4 600
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+8
ADDP4
INDIRF4
MULF4
ASGNF4
line 617
;617:								le->color[3] = 1.0f;
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
CNSTF4 1065353216
ASGNF4
line 618
;618:					} else if ( ci->team == cgs.clientinfo[ cg.clientNum ].team && cg_forceColors.integer && cgs.gametype >= GT_TEAM ) {
ADDRGP4 $673
JUMPV
LABELV $672
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
NEI4 $698
ADDRGP4 cg_forceColors+12
INDIRI4
CNSTI4 0
EQI4 $698
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $698
line 619
;619:								le->color[0] = cgs.clientinfo[cg.clientNum].color2[0] * 0.75;
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
CNSTF4 1061158912
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+112
ADDP4
INDIRF4
MULF4
ASGNF4
line 620
;620:								le->color[1] = cgs.clientinfo[cg.clientNum].color2[1] * 0.75;
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
CNSTF4 1061158912
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+112+4
ADDP4
INDIRF4
MULF4
ASGNF4
line 621
;621:								le->color[2] = cgs.clientinfo[cg.clientNum].color2[2] * 0.75;
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
CNSTF4 1061158912
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+112+8
ADDP4
INDIRF4
MULF4
ASGNF4
line 622
;622:								le->color[3] = 1.0f;
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
CNSTF4 1065353216
ASGNF4
line 623
;623:					} else if ( ci->team == cgs.clientinfo[ cg.clientNum ].team && 
ADDRGP4 $699
JUMPV
LABELV $698
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
NEI4 $716
ADDRGP4 cg_TeamColors+16
ARGP4
ADDRLP4 592
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 592
INDIRI4
CNSTI4 2
EQI4 $724
ADDRGP4 cg_TeamColors+16
ARGP4
ADDRLP4 596
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 596
INDIRI4
CNSTI4 5
NEI4 $716
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $716
ADDRFP4 0
INDIRP4
CNSTI4 1768
ADDP4
INDIRI4
CNSTI4 0
NEI4 $716
LABELV $724
line 625
;624:						( strlen(cg_TeamColors.string) == 2 || strlen(cg_TeamColors.string) == 5 
;625:						&& cgs.gametype >= GT_TEAM && !ci->localClient) ) {
line 626
;626:								le->color[0] = g_color_table[ColorIndex(cg_TeamColors.string[4])][0] * 0.75;
ADDRGP4 cg_TeamColors+16+4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 600
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
CNSTF4 1061158912
ADDRLP4 600
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
INDIRF4
MULF4
ASGNF4
line 627
;627:								le->color[1] = g_color_table[ColorIndex(cg_TeamColors.string[4])][1] * 0.75;
ADDRGP4 cg_TeamColors+16+4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 604
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
CNSTF4 1061158912
ADDRLP4 604
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+4
ADDP4
INDIRF4
MULF4
ASGNF4
line 628
;628:								le->color[2] = g_color_table[ColorIndex(cg_TeamColors.string[4])][2] * 0.75;
ADDRGP4 cg_TeamColors+16+4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 608
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
CNSTF4 1061158912
ADDRLP4 608
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+8
ADDP4
INDIRF4
MULF4
ASGNF4
line 629
;629:								le->color[3] = 1.0f;
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
CNSTF4 1065353216
ASGNF4
line 630
;630:					} else {
ADDRGP4 $717
JUMPV
LABELV $716
line 631
;631:						le->color[0] = ci->color2[0] * 0.75;
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
CNSTF4 1061158912
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRF4
MULF4
ASGNF4
line 632
;632:						le->color[1] = ci->color2[1] * 0.75;
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
CNSTF4 1061158912
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRF4
MULF4
ASGNF4
line 633
;633:						le->color[2] = ci->color2[2] * 0.75;
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
CNSTF4 1061158912
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
MULF4
ASGNF4
line 634
;634:						le->color[3] = 1.0f;
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
CNSTF4 1065353216
ASGNF4
line 635
;635:					}
LABELV $717
LABELV $699
LABELV $673
line 637
;636:
;637:				le->pos.trType = TR_LINEAR;
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTI4 2
ASGNI4
line 638
;638:				le->pos.trTime = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 640
;639:
;640:				VectorCopy( move, move2);
ADDRLP4 472
ADDRLP4 8
INDIRB
ASGNB 12
line 641
;641:				VectorMA(move2, RADIUS , axis[j], move2);
ADDRLP4 600
CNSTF4 1082130432
ASGNF4
ADDRLP4 604
CNSTI4 12
ADDRLP4 20
INDIRI4
MULI4
ASGNI4
ADDRLP4 472
ADDRLP4 472
INDIRF4
ADDRLP4 600
INDIRF4
ADDRLP4 604
INDIRI4
ADDRLP4 40
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 472+4
ADDRLP4 472+4
INDIRF4
ADDRLP4 600
INDIRF4
ADDRLP4 604
INDIRI4
ADDRLP4 40+4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 472+8
ADDRLP4 472+8
INDIRF4
CNSTF4 1082130432
CNSTI4 12
ADDRLP4 20
INDIRI4
MULI4
ADDRLP4 40+8
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 642
;642:				VectorCopy(move2, le->pos.trBase);
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 472
INDIRB
ASGNB 12
line 644
;643:
;644:				le->pos.trDelta[0] = axis[j][0]*6;
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
CNSTF4 1086324736
CNSTI4 12
ADDRLP4 20
INDIRI4
MULI4
ADDRLP4 40
ADDP4
INDIRF4
MULF4
ASGNF4
line 645
;645:				le->pos.trDelta[1] = axis[j][1]*6;
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
CNSTF4 1086324736
CNSTI4 12
ADDRLP4 20
INDIRI4
MULI4
ADDRLP4 40+4
ADDP4
INDIRF4
MULF4
ASGNF4
line 646
;646:				le->pos.trDelta[2] = axis[j][2]*6;
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTF4 1086324736
CNSTI4 12
ADDRLP4 20
INDIRI4
MULI4
ADDRLP4 40+8
ADDP4
INDIRF4
MULF4
ASGNF4
line 647
;647:			}
LABELV $586
line 649
;648:
;649:			VectorAdd (move, vec, move);
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 24
INDIRF4
ADDF4
ASGNF4
ADDRLP4 8+4
ADDRLP4 8+4
INDIRF4
ADDRLP4 24+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 8+8
ADDRLP4 8+8
INDIRF4
ADDRLP4 24+8
INDIRF4
ADDF4
ASGNF4
line 651
;650:
;651:			j = j + ROTATION < 36 ? j + ROTATION : (j + ROTATION) % 36;
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 36
GEI4 $749
ADDRLP4 540
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $750
JUMPV
LABELV $749
ADDRLP4 540
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 36
MODI4
ASGNI4
LABELV $750
ADDRLP4 20
ADDRLP4 540
INDIRI4
ASGNI4
line 652
;652:		}
LABELV $583
line 569
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 5
ADDI4
ASGNI4
LABELV $585
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 500
INDIRF4
LTF4 $582
line 654
;653:
;654:	}
LABELV $554
line 655
;655:}
LABELV $381
endproc CG_RailTrail 616 16
proc CG_RocketTrail 96 48
line 662
;656:
;657:/*
;658:==========================
;659:CG_RocketTrail
;660:==========================
;661:*/
;662:static void CG_RocketTrail( centity_t *ent, const weaponInfo_t *wi ) {
line 672
;663:	int		step;
;664:	vec3_t	origin, lastPos;
;665:	int		t;
;666:	int		startTime, contents;
;667:	int		lastContents;
;668:	entityState_t	*es;
;669:	vec3_t	up;
;670:	localEntity_t	*smoke;
;671:
;672:	if ( cg_noProjectileTrail.integer ) {
ADDRGP4 cg_noProjectileTrail+12
INDIRI4
CNSTI4 0
EQI4 $752
line 673
;673:		return;
ADDRGP4 $751
JUMPV
LABELV $752
line 676
;674:	}
;675:
;676:	up[0] = 0;
ADDRLP4 28
CNSTF4 0
ASGNF4
line 677
;677:	up[1] = 0;
ADDRLP4 28+4
CNSTF4 0
ASGNF4
line 678
;678:	up[2] = 0;
ADDRLP4 28+8
CNSTF4 0
ASGNF4
line 680
;679:
;680:	step = 50;
ADDRLP4 20
CNSTI4 50
ASGNI4
line 682
;681:
;682:	es = &ent->currentState;
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
line 683
;683:	startTime = ent->trailTime;
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRI4
ASGNI4
line 684
;684:	t = step * ( (startTime + step) / step );
ADDRLP4 0
ADDRLP4 20
INDIRI4
ADDRLP4 56
INDIRI4
ADDRLP4 20
INDIRI4
ADDI4
ADDRLP4 20
INDIRI4
DIVI4
MULI4
ASGNI4
line 686
;685:
;686:	BG_EvaluateTrajectory( &es->pos, cg.time, origin );
ADDRLP4 24
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 44
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 687
;687:	contents = CG_PointContents( origin, -1 );
ADDRLP4 44
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 68
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 68
INDIRI4
ASGNI4
line 690
;688:
;689:	// if object (e.g. grenade) is stationary, don't toss up smoke
;690:	if ( es->pos.trType == TR_STATIONARY ) {
ADDRLP4 24
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
NEI4 $758
line 691
;691:		ent->trailTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 692
;692:		return;
ADDRGP4 $751
JUMPV
LABELV $758
line 695
;693:	}
;694:
;695:	BG_EvaluateTrajectory( &es->pos, ent->trailTime, lastPos );
ADDRLP4 24
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 696
;696:	lastContents = CG_PointContents( lastPos, -1 );
ADDRLP4 4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 72
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 60
ADDRLP4 72
INDIRI4
ASGNI4
line 698
;697:
;698:	ent->trailTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 700
;699:
;700:	if ( contents & ( CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) ) {
ADDRLP4 40
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $769
line 701
;701:		if ( contents & lastContents & CONTENTS_WATER ) {
ADDRLP4 40
INDIRI4
ADDRLP4 60
INDIRI4
BANDI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $751
line 702
;702:			CG_BubbleTrail( lastPos, origin, 8 );
ADDRLP4 4
ARGP4
ADDRLP4 44
ARGP4
CNSTF4 1090519040
ARGF4
ADDRGP4 CG_BubbleTrail
CALLV
pop
line 703
;703:		}
line 704
;704:		return;
ADDRGP4 $751
JUMPV
line 707
;705:	}
;706:
;707:	for ( ; t <= ent->trailTime ; t += step ) {
LABELV $766
line 708
;708:		BG_EvaluateTrajectory( &es->pos, t, lastPos );
ADDRLP4 24
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 710
;709:
;710:		smoke = CG_SmokePuff( lastPos, up, 
ADDRLP4 4
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 76
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 116
ADDP4
INDIRF4
ARGF4
ADDRLP4 80
CNSTF4 1065353216
ASGNF4
ADDRLP4 80
INDIRF4
ARGF4
ADDRLP4 80
INDIRF4
ARGF4
ADDRLP4 80
INDIRF4
ARGF4
CNSTF4 1051260355
ARGF4
ADDRLP4 76
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 84
CNSTI4 0
ASGNI4
ADDRLP4 84
INDIRI4
ARGI4
ADDRLP4 84
INDIRI4
ARGI4
ADDRGP4 cgs+156680+332
INDIRI4
ARGI4
ADDRLP4 88
ADDRGP4 CG_SmokePuff
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 88
INDIRP4
ASGNP4
line 719
;711:					  wi->trailRadius, 
;712:					  1, 1, 1, 0.33f,
;713:					  wi->wiTrailTime, 
;714:					  t,
;715:					  0,
;716:					  0, 
;717:					  cgs.media.smokePuffShader );
;718:		// use the optimized local entity add
;719:		if ( wi->wiTrailTime == 2000 && cg_smokeGrowth_RL.integer || wi->wiTrailTime == 700 && cg_smokeGrowth_GL.integer ) {
ADDRFP4 4
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
CNSTF4 1157234688
NEF4 $777
ADDRGP4 cg_smokeGrowth_RL+12
INDIRI4
CNSTI4 0
NEI4 $776
LABELV $777
ADDRFP4 4
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
CNSTF4 1143930880
NEF4 $772
ADDRGP4 cg_smokeGrowth_GL+12
INDIRI4
CNSTI4 0
EQI4 $772
LABELV $776
line 720
;720:			smoke->leType = LE_SCALE_FADE;
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 7
ASGNI4
line 721
;721:		} else {//h4x
ADDRGP4 $773
JUMPV
LABELV $772
line 722
;722:			smoke->leType = LE_SCALE_FADE2;
ADDRLP4 92
CNSTI4 8
ASGNI4
ADDRLP4 16
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
ADDRLP4 92
INDIRI4
ASGNI4
line 723
;723:		}
LABELV $773
line 724
;724:	}
LABELV $767
line 707
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 20
INDIRI4
ADDI4
ASGNI4
LABELV $769
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRI4
LEI4 $766
line 726
;725:
;726:}
LABELV $751
endproc CG_RocketTrail 96 48
proc CG_PlasmaTrail 204 12
line 802
;727:
;728:#ifdef MISSIONPACK
;729:/*
;730:==========================
;731:CG_NailTrail
;732:==========================
;733:*/
;734:static void CG_NailTrail( centity_t *ent, const weaponInfo_t *wi ) {
;735:	int		step;
;736:	vec3_t	origin, lastPos;
;737:	int		t;
;738:	int		startTime, contents;
;739:	int		lastContents;
;740:	entityState_t	*es;
;741:	vec3_t	up;
;742:	localEntity_t	*smoke;
;743:
;744:	if ( cg_noProjectileTrail.integer ) {
;745:		return;
;746:	}
;747:
;748:	up[0] = 0;
;749:	up[1] = 0;
;750:	up[2] = 0;
;751:
;752:	step = 50;
;753:
;754:	es = &ent->currentState;
;755:	startTime = ent->trailTime;
;756:	t = step * ( (startTime + step) / step );
;757:
;758:	BG_EvaluateTrajectory( &es->pos, cg.time, origin );
;759:	contents = CG_PointContents( origin, -1 );
;760:
;761:	// if object (e.g. grenade) is stationary, don't toss up smoke
;762:	if ( es->pos.trType == TR_STATIONARY ) {
;763:		ent->trailTime = cg.time;
;764:		return;
;765:	}
;766:
;767:	BG_EvaluateTrajectory( &es->pos, ent->trailTime, lastPos );
;768:	lastContents = CG_PointContents( lastPos, -1 );
;769:
;770:	ent->trailTime = cg.time;
;771:
;772:	if ( contents & ( CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) ) {
;773:		if ( contents & lastContents & CONTENTS_WATER ) {
;774:			CG_BubbleTrail( lastPos, origin, 8 );
;775:		}
;776:		return;
;777:	}
;778:
;779:	for ( ; t <= ent->trailTime ; t += step ) {
;780:		BG_EvaluateTrajectory( &es->pos, t, lastPos );
;781:
;782:		smoke = CG_SmokePuff( lastPos, up, 
;783:					  wi->trailRadius, 
;784:					  1, 1, 1, 0.33f,
;785:					  wi->wiTrailTime, 
;786:					  t,
;787:					  0,
;788:					  0, 
;789:					  cgs.media.nailPuffShader );
;790:		// use the optimized local entity add
;791:		smoke->leType = LE_SCALE_FADE;
;792:	}
;793:
;794:}
;795:#endif
;796:
;797:/*
;798:==========================
;799:CG_NailTrail
;800:==========================
;801:*/
;802:static void CG_PlasmaTrail( centity_t *cent, const weaponInfo_t *wi ) {
line 811
;803:	localEntity_t	*le;
;804:	refEntity_t		*re;
;805:	entityState_t	*es;
;806:	vec3_t			velocity, xvelocity, origin;
;807:	vec3_t			offset, xoffset;
;808:	vec3_t			v[3];
;809:	int				t, startTime, step;
;810:
;811:	float	waterScale = 1.0f;
ADDRLP4 92
CNSTF4 1065353216
ASGNF4
line 813
;812:
;813:	if ( cg_noProjectileTrail.integer || cg_oldPlasma.integer ) {
ADDRLP4 124
CNSTI4 0
ASGNI4
ADDRGP4 cg_noProjectileTrail+12
INDIRI4
ADDRLP4 124
INDIRI4
NEI4 $783
ADDRGP4 cg_oldPlasma+12
INDIRI4
ADDRLP4 124
INDIRI4
EQI4 $779
LABELV $783
line 814
;814:		return;
ADDRGP4 $778
JUMPV
LABELV $779
line 817
;815:	}
;816:
;817:	step = 50;
ADDRLP4 108
CNSTI4 50
ASGNI4
line 819
;818:
;819:	es = &cent->currentState;
ADDRLP4 112
ADDRFP4 0
INDIRP4
ASGNP4
line 820
;820:	startTime = cent->trailTime;
ADDRLP4 116
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRI4
ASGNI4
line 821
;821:	t = step * ( (startTime + step) / step );
ADDRLP4 120
ADDRLP4 108
INDIRI4
ADDRLP4 116
INDIRI4
ADDRLP4 108
INDIRI4
ADDI4
ADDRLP4 108
INDIRI4
DIVI4
MULI4
ASGNI4
line 823
;822:
;823:	BG_EvaluateTrajectory( &es->pos, cg.time, origin );
ADDRLP4 112
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 96
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 825
;824:
;825:	le = CG_AllocLocalEntity();
ADDRLP4 132
ADDRGP4 CG_AllocLocalEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 132
INDIRP4
ASGNP4
line 826
;826:	re = &le->refEntity;
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
ASGNP4
line 828
;827:
;828:	velocity[0] = 60 - 120 * crandom();
ADDRLP4 136
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 44
CNSTF4 1114636288
CNSTF4 1123024896
CNSTF4 1073741824
ADDRLP4 136
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
SUBF4
ASGNF4
line 829
;829:	velocity[1] = 40 - 80 * crandom();
ADDRLP4 140
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 44+4
CNSTF4 1109393408
CNSTF4 1117782016
CNSTF4 1073741824
ADDRLP4 140
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
SUBF4
ASGNF4
line 830
;830:	velocity[2] = 100 - 200 * crandom();
ADDRLP4 144
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 44+8
CNSTF4 1120403456
CNSTF4 1128792064
CNSTF4 1073741824
ADDRLP4 144
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
SUBF4
ASGNF4
line 832
;831:
;832:	le->leType = LE_MOVE_SCALE_FADE;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 4
ASGNI4
line 833
;833:	le->leFlags = LEF_TUMBLE;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 2
ASGNI4
line 834
;834:	le->leBounceSoundType = LEBS_NONE;
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 835
;835:	le->leMarkType = LEMT_NONE;
ADDRLP4 0
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 0
ASGNI4
line 837
;836:
;837:	le->startTime = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 838
;838:	le->endTime = le->startTime + 600;
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 600
ADDI4
ASGNI4
line 840
;839:
;840:	le->pos.trType = TR_GRAVITY;
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTI4 5
ASGNI4
line 841
;841:	le->pos.trTime = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 843
;842:
;843:	AnglesToAxis( cent->lerpAngles, v );
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 845
;844:
;845:	offset[0] = 2;
ADDRLP4 56
CNSTF4 1073741824
ASGNF4
line 846
;846:	offset[1] = 2;
ADDRLP4 56+4
CNSTF4 1073741824
ASGNF4
line 847
;847:	offset[2] = 2;
ADDRLP4 56+8
CNSTF4 1073741824
ASGNF4
line 849
;848:
;849:	xoffset[0] = offset[0] * v[0][0] + offset[1] * v[1][0] + offset[2] * v[2][0];
ADDRLP4 80
ADDRLP4 56
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ADDRLP4 56+4
INDIRF4
ADDRLP4 4+12
INDIRF4
MULF4
ADDF4
ADDRLP4 56+8
INDIRF4
ADDRLP4 4+24
INDIRF4
MULF4
ADDF4
ASGNF4
line 850
;850:	xoffset[1] = offset[0] * v[0][1] + offset[1] * v[1][1] + offset[2] * v[2][1];
ADDRLP4 80+4
ADDRLP4 56
INDIRF4
ADDRLP4 4+4
INDIRF4
MULF4
ADDRLP4 56+4
INDIRF4
ADDRLP4 4+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 56+8
INDIRF4
ADDRLP4 4+24+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 851
;851:	xoffset[2] = offset[0] * v[0][2] + offset[1] * v[1][2] + offset[2] * v[2][2];
ADDRLP4 80+8
ADDRLP4 56
INDIRF4
ADDRLP4 4+8
INDIRF4
MULF4
ADDRLP4 56+4
INDIRF4
ADDRLP4 4+12+8
INDIRF4
MULF4
ADDF4
ADDRLP4 56+8
INDIRF4
ADDRLP4 4+24+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 853
;852:
;853:	VectorAdd( origin, xoffset, re->origin );
ADDRLP4 40
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 96
INDIRF4
ADDRLP4 80
INDIRF4
ADDF4
ASGNF4
ADDRLP4 40
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 96+4
INDIRF4
ADDRLP4 80+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 40
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 96+8
INDIRF4
ADDRLP4 80+8
INDIRF4
ADDF4
ASGNF4
line 854
;854:	VectorCopy( re->origin, le->pos.trBase );
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 40
INDIRP4
CNSTI4 68
ADDP4
INDIRB
ASGNB 12
line 856
;855:
;856:	if ( CG_PointContents( re->origin, -1 ) & CONTENTS_WATER ) {
ADDRLP4 40
INDIRP4
CNSTI4 68
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 152
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $815
line 857
;857:		waterScale = 0.10f;
ADDRLP4 92
CNSTF4 1036831949
ASGNF4
line 858
;858:	}
LABELV $815
line 860
;859:
;860:	xvelocity[0] = velocity[0] * v[0][0] + velocity[1] * v[1][0] + velocity[2] * v[2][0];
ADDRLP4 68
ADDRLP4 44
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ADDRLP4 44+4
INDIRF4
ADDRLP4 4+12
INDIRF4
MULF4
ADDF4
ADDRLP4 44+8
INDIRF4
ADDRLP4 4+24
INDIRF4
MULF4
ADDF4
ASGNF4
line 861
;861:	xvelocity[1] = velocity[0] * v[0][1] + velocity[1] * v[1][1] + velocity[2] * v[2][1];
ADDRLP4 68+4
ADDRLP4 44
INDIRF4
ADDRLP4 4+4
INDIRF4
MULF4
ADDRLP4 44+4
INDIRF4
ADDRLP4 4+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 44+8
INDIRF4
ADDRLP4 4+24+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 862
;862:	xvelocity[2] = velocity[0] * v[0][2] + velocity[1] * v[1][2] + velocity[2] * v[2][2];
ADDRLP4 68+8
ADDRLP4 44
INDIRF4
ADDRLP4 4+8
INDIRF4
MULF4
ADDRLP4 44+4
INDIRF4
ADDRLP4 4+12+8
INDIRF4
MULF4
ADDF4
ADDRLP4 44+8
INDIRF4
ADDRLP4 4+24+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 863
;863:	VectorScale( xvelocity, waterScale, le->pos.trDelta );
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
ADDRLP4 68
INDIRF4
ADDRLP4 92
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
ADDRLP4 68+4
INDIRF4
ADDRLP4 92
INDIRF4
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
ADDRLP4 68+8
INDIRF4
ADDRLP4 92
INDIRF4
MULF4
ASGNF4
line 865
;864:
;865:	AxisCopy( axisDefault, re->axis );
ADDRGP4 axisDefault
ARGP4
ADDRLP4 40
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRGP4 AxisCopy
CALLV
pop
line 866
;866:    re->shaderTime = cg.time / 1000.0f;
ADDRLP4 40
INDIRP4
CNSTI4 128
ADDP4
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
CNSTF4 1148846080
DIVF4
ASGNF4
line 867
;867:    re->reType = RT_SPRITE;
ADDRLP4 40
INDIRP4
CNSTI4 2
ASGNI4
line 868
;868:    re->radius = 0.25f;
ADDRLP4 40
INDIRP4
CNSTI4 132
ADDP4
CNSTF4 1048576000
ASGNF4
line 869
;869:	re->customShader = cgs.media.railRingsShader;
ADDRLP4 40
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+156680+240
INDIRI4
ASGNI4
line 870
;870:	le->bounceFactor = 0.3f;
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
CNSTF4 1050253722
ASGNF4
line 872
;871:
;872:    re->shaderRGBA[0] = wi->flashDlightColor[0] * 63;
ADDRLP4 160
CNSTF4 1115422720
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 164
CNSTF4 1325400064
ASGNF4
ADDRLP4 160
INDIRF4
ADDRLP4 164
INDIRF4
LTF4 $843
ADDRLP4 156
ADDRLP4 160
INDIRF4
ADDRLP4 164
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $844
JUMPV
LABELV $843
ADDRLP4 156
ADDRLP4 160
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $844
ADDRLP4 40
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 156
INDIRU4
CVUU1 4
ASGNU1
line 873
;873:    re->shaderRGBA[1] = wi->flashDlightColor[1] * 63;
ADDRLP4 172
CNSTF4 1115422720
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 176
CNSTF4 1325400064
ASGNF4
ADDRLP4 172
INDIRF4
ADDRLP4 176
INDIRF4
LTF4 $846
ADDRLP4 168
ADDRLP4 172
INDIRF4
ADDRLP4 176
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $847
JUMPV
LABELV $846
ADDRLP4 168
ADDRLP4 172
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $847
ADDRLP4 40
INDIRP4
CNSTI4 117
ADDP4
ADDRLP4 168
INDIRU4
CVUU1 4
ASGNU1
line 874
;874:    re->shaderRGBA[2] = wi->flashDlightColor[2] * 63;
ADDRLP4 184
CNSTF4 1115422720
ADDRFP4 4
INDIRP4
CNSTI4 48
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 188
CNSTF4 1325400064
ASGNF4
ADDRLP4 184
INDIRF4
ADDRLP4 188
INDIRF4
LTF4 $849
ADDRLP4 180
ADDRLP4 184
INDIRF4
ADDRLP4 188
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $850
JUMPV
LABELV $849
ADDRLP4 180
ADDRLP4 184
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $850
ADDRLP4 40
INDIRP4
CNSTI4 118
ADDP4
ADDRLP4 180
INDIRU4
CVUU1 4
ASGNU1
line 875
;875:    re->shaderRGBA[3] = 63;
ADDRLP4 40
INDIRP4
CNSTI4 119
ADDP4
CNSTU1 63
ASGNU1
line 877
;876:
;877:    le->color[0] = wi->flashDlightColor[0] * 0.2;
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
CNSTF4 1045220557
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
MULF4
ASGNF4
line 878
;878:    le->color[1] = wi->flashDlightColor[1] * 0.2;
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
CNSTF4 1045220557
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRF4
MULF4
ASGNF4
line 879
;879:    le->color[2] = wi->flashDlightColor[2] * 0.2;
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
CNSTF4 1045220557
ADDRFP4 4
INDIRP4
CNSTI4 48
ADDP4
INDIRF4
MULF4
ASGNF4
line 880
;880:    le->color[3] = 0.25f;
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
CNSTF4 1048576000
ASGNF4
line 882
;881:
;882:	le->angles.trType = TR_LINEAR;
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 2
ASGNI4
line 883
;883:	le->angles.trTime = cg.time;
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 884
;884:	le->angles.trBase[0] = rand()&31;
ADDRLP4 192
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 192
INDIRI4
CNSTI4 31
BANDI4
CVIF4 4
ASGNF4
line 885
;885:	le->angles.trBase[1] = rand()&31;
ADDRLP4 196
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
ADDRLP4 196
INDIRI4
CNSTI4 31
BANDI4
CVIF4 4
ASGNF4
line 886
;886:	le->angles.trBase[2] = rand()&31;
ADDRLP4 200
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 88
ADDP4
ADDRLP4 200
INDIRI4
CNSTI4 31
BANDI4
CVIF4 4
ASGNF4
line 887
;887:	le->angles.trDelta[0] = 1;
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
CNSTF4 1065353216
ASGNF4
line 888
;888:	le->angles.trDelta[1] = 0.5;
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
CNSTF4 1056964608
ASGNF4
line 889
;889:	le->angles.trDelta[2] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
CNSTF4 0
ASGNF4
line 891
;890:
;891:}
LABELV $778
endproc CG_PlasmaTrail 204 12
export CG_GrappleTrail
proc CG_GrappleTrail 184 16
line 897
;892:/*
;893:==========================
;894:CG_GrappleTrail
;895:==========================
;896:*/
;897:void CG_GrappleTrail( centity_t *ent, const weaponInfo_t *wi ) {
line 903
;898:	vec3_t	origin;
;899:	entityState_t	*es;
;900:	vec3_t			forward, up;
;901:	refEntity_t		beam;
;902:
;903:	es = &ent->currentState;
ADDRLP4 164
ADDRFP4 0
INDIRP4
ASGNP4
line 905
;904:
;905:	BG_EvaluateTrajectory( &es->pos, cg.time, origin );
ADDRLP4 164
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 152
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 906
;906:	ent->trailTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 908
;907:
;908:	memset( &beam, 0, sizeof( beam ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 910
;909:	//FIXME adjust for muzzle position
;910:	VectorCopy ( cg_entities[ ent->currentState.otherEntityNum ].lerpOrigin, beam.origin );
ADDRLP4 0+68
CNSTI4 728
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities+704
ADDP4
INDIRB
ASGNB 12
line 911
;911:	beam.origin[2] += 26;
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
CNSTF4 1104150528
ADDF4
ASGNF4
line 912
;912:	AngleVectors( cg_entities[ ent->currentState.otherEntityNum ].lerpAngles, forward, NULL, up );
CNSTI4 728
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities+716
ADDP4
ARGP4
ADDRLP4 168
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 140
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 913
;913:	VectorMA( beam.origin, -6, up, beam.origin );
ADDRLP4 0+68
ADDRLP4 0+68
INDIRF4
CNSTF4 3233808384
ADDRLP4 140
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+4
ADDRLP4 0+68+4
INDIRF4
CNSTF4 3233808384
ADDRLP4 140+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
CNSTF4 3233808384
ADDRLP4 140+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 914
;914:	VectorCopy( origin, beam.oldorigin );
ADDRLP4 0+84
ADDRLP4 152
INDIRB
ASGNB 12
line 916
;915:
;916:	if (Distance( beam.origin, beam.oldorigin ) < 64 )
ADDRLP4 0+68
ARGP4
ADDRLP4 0+84
ARGP4
ADDRLP4 180
ADDRGP4 Distance
CALLF4
ASGNF4
ADDRLP4 180
INDIRF4
CNSTF4 1115684864
GEF4 $873
line 917
;917:		return; // Don't draw if close
ADDRGP4 $852
JUMPV
LABELV $873
line 919
;918:
;919:	beam.reType = RT_LIGHTNING;
ADDRLP4 0
CNSTI4 6
ASGNI4
line 920
;920:	beam.customShader = cgs.media.lightningShader;
ADDRLP4 0+112
ADDRGP4 cgs+156680+248
INDIRI4
ASGNI4
line 922
;921:
;922:	AxisClear( beam.axis );
ADDRLP4 0+28
ARGP4
ADDRGP4 AxisClear
CALLV
pop
line 923
;923:	beam.shaderRGBA[0] = 0xff;
ADDRLP4 0+116
CNSTU1 255
ASGNU1
line 924
;924:	beam.shaderRGBA[1] = 0xff;
ADDRLP4 0+116+1
CNSTU1 255
ASGNU1
line 925
;925:	beam.shaderRGBA[2] = 0xff;
ADDRLP4 0+116+2
CNSTU1 255
ASGNU1
line 926
;926:	beam.shaderRGBA[3] = 0xff;
ADDRLP4 0+116+3
CNSTU1 255
ASGNU1
line 927
;927:	trap_R_AddRefEntityToScene( &beam );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 928
;928:}
LABELV $852
endproc CG_GrappleTrail 184 16
proc CG_GrenadeTrail 0 8
line 935
;929:
;930:/*
;931:==========================
;932:CG_GrenadeTrail
;933:==========================
;934:*/
;935:static void CG_GrenadeTrail( centity_t *ent, const weaponInfo_t *wi ) {
line 936
;936:	CG_RocketTrail( ent, wi );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_RocketTrail
CALLV
pop
line 937
;937:}
LABELV $888
endproc CG_GrenadeTrail 0 8
export CG_RegisterWeapon
proc CG_RegisterWeapon 304 12
line 947
;938:
;939:
;940:/*
;941:=================
;942:CG_RegisterWeapon
;943:
;944:The server says this item is used on this level
;945:=================
;946:*/
;947:void CG_RegisterWeapon( int weaponNum ) {
line 954
;948:	weaponInfo_t	*weaponInfo;
;949:	gitem_t			*item, *ammo;
;950:	char			path[MAX_QPATH];
;951:	vec3_t			mins, maxs;
;952:	int				i;
;953:
;954:	weaponInfo = &cg_weapons[weaponNum];
ADDRLP4 12
CNSTI4 136
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 cg_weapons
ADDP4
ASGNP4
line 956
;955:
;956:	if ( weaponNum == 0 ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $890
line 957
;957:		return;
ADDRGP4 $889
JUMPV
LABELV $890
line 960
;958:	}
;959:
;960:	if ( weaponInfo->registered ) {
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $892
line 961
;961:		return;
ADDRGP4 $889
JUMPV
LABELV $892
line 964
;962:	}
;963:
;964:	memset( weaponInfo, 0, sizeof( *weaponInfo ) );
ADDRLP4 12
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 136
ARGI4
ADDRGP4 memset
CALLP4
pop
line 965
;965:	weaponInfo->registered = qtrue;
ADDRLP4 12
INDIRP4
CNSTI4 1
ASGNI4
line 967
;966:
;967:	for ( item = bg_itemlist + 1 ; item->classname ; item++ ) {
ADDRLP4 4
ADDRGP4 bg_itemlist+52
ASGNP4
ADDRGP4 $897
JUMPV
LABELV $894
line 968
;968:		if ( item->giType == IT_WEAPON && item->giTag == weaponNum ) {
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $899
ADDRLP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $899
line 969
;969:			weaponInfo->item = item;
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 970
;970:			break;
ADDRGP4 $896
JUMPV
LABELV $899
line 972
;971:		}
;972:	}
LABELV $895
line 967
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 52
ADDP4
ASGNP4
LABELV $897
ADDRLP4 4
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $894
LABELV $896
line 973
;973:	if ( !item->classname ) {
ADDRLP4 4
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $901
line 974
;974:		CG_Error( "Couldn't find weapon %i", weaponNum );
ADDRGP4 $903
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 975
;975:	}
LABELV $901
line 976
;976:	CG_RegisterItemVisuals( item - bg_itemlist );
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
ARGI4
ADDRGP4 CG_RegisterItemVisuals
CALLV
pop
line 979
;977:
;978:	// load cmodel before model so filecache works
;979:	weaponInfo->weaponModel = trap_R_RegisterModel( item->world_model[0] );
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ARGP4
ADDRLP4 104
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 104
INDIRI4
ASGNI4
line 982
;980:
;981:	// calc midpoint for rotation
;982:	trap_R_ModelBounds( weaponInfo->weaponModel, mins, maxs );
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRLP4 92
ARGP4
ADDRGP4 trap_R_ModelBounds
CALLV
pop
line 983
;983:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $904
line 984
;984:		weaponInfo->weaponMidpoint[i] = mins[i] + 0.5 * ( maxs[i] - mins[i] );
ADDRLP4 108
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 112
ADDRLP4 108
INDIRI4
ADDRLP4 16
ADDP4
INDIRF4
ASGNF4
ADDRLP4 108
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 24
ADDP4
ADDP4
ADDRLP4 112
INDIRF4
CNSTF4 1056964608
ADDRLP4 108
INDIRI4
ADDRLP4 92
ADDP4
INDIRF4
ADDRLP4 112
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 985
;985:	}
LABELV $905
line 983
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $904
line 987
;986:
;987:	weaponInfo->weaponIcon = trap_R_RegisterShader( item->icon );
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 108
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 108
INDIRI4
ASGNI4
line 988
;988:	weaponInfo->ammoIcon = trap_R_RegisterShader( item->icon );
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 112
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 112
INDIRI4
ASGNI4
line 990
;989:
;990:	for ( ammo = bg_itemlist + 1 ; ammo->classname ; ammo++ ) {
ADDRLP4 8
ADDRGP4 bg_itemlist+52
ASGNP4
ADDRGP4 $911
JUMPV
LABELV $908
line 991
;991:		if ( ammo->giType == IT_AMMO && ammo->giTag == weaponNum ) {
ADDRLP4 8
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 2
NEI4 $913
ADDRLP4 8
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $913
line 992
;992:			break;
ADDRGP4 $910
JUMPV
LABELV $913
line 994
;993:		}
;994:	}
LABELV $909
line 990
ADDRLP4 8
ADDRLP4 8
INDIRP4
CNSTI4 52
ADDP4
ASGNP4
LABELV $911
ADDRLP4 8
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $908
LABELV $910
line 995
;995:	if ( ammo->classname && ammo->world_model[0] ) {
ADDRLP4 120
CNSTU4 0
ASGNU4
ADDRLP4 8
INDIRP4
INDIRP4
CVPU4 4
ADDRLP4 120
INDIRU4
EQU4 $915
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 120
INDIRU4
EQU4 $915
line 996
;996:		weaponInfo->ammoModel = trap_R_RegisterModel( ammo->world_model[0] );
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ARGP4
ADDRLP4 124
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 124
INDIRI4
ASGNI4
line 997
;997:	}
LABELV $915
line 999
;998:
;999:	strcpy( path, item->world_model[0] );
ADDRLP4 28
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1000
;1000:	COM_StripExtension( path, path );
ADDRLP4 28
ARGP4
ADDRLP4 28
ARGP4
ADDRGP4 COM_StripExtension
CALLV
pop
line 1001
;1001:	strcat( path, "_flash.md3" );
ADDRLP4 28
ARGP4
ADDRGP4 $917
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 1002
;1002:	weaponInfo->flashModel = trap_R_RegisterModel( path );
ADDRLP4 28
ARGP4
ADDRLP4 124
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 124
INDIRI4
ASGNI4
line 1004
;1003:
;1004:	strcpy( path, item->world_model[0] );
ADDRLP4 28
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1005
;1005:	COM_StripExtension( path, path );
ADDRLP4 28
ARGP4
ADDRLP4 28
ARGP4
ADDRGP4 COM_StripExtension
CALLV
pop
line 1006
;1006:	strcat( path, "_barrel.md3" );
ADDRLP4 28
ARGP4
ADDRGP4 $918
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 1007
;1007:	weaponInfo->barrelModel = trap_R_RegisterModel( path );
ADDRLP4 28
ARGP4
ADDRLP4 128
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 128
INDIRI4
ASGNI4
line 1009
;1008:
;1009:	strcpy( path, item->world_model[0] );
ADDRLP4 28
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1010
;1010:	COM_StripExtension( path, path );
ADDRLP4 28
ARGP4
ADDRLP4 28
ARGP4
ADDRGP4 COM_StripExtension
CALLV
pop
line 1011
;1011:	strcat( path, "_hand.md3" );
ADDRLP4 28
ARGP4
ADDRGP4 $919
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 1012
;1012:	weaponInfo->handsModel = trap_R_RegisterModel( path );
ADDRLP4 28
ARGP4
ADDRLP4 132
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 132
INDIRI4
ASGNI4
line 1014
;1013:
;1014:	if ( !weaponInfo->handsModel ) {
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 0
NEI4 $920
line 1015
;1015:		weaponInfo->handsModel = trap_R_RegisterModel( "models/weapons2/shotgun/shotgun_hand.md3" );
ADDRGP4 $922
ARGP4
ADDRLP4 136
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 136
INDIRI4
ASGNI4
line 1016
;1016:	}
LABELV $920
line 1018
;1017:
;1018:	weaponInfo->loopFireSound = qfalse;
ADDRLP4 12
INDIRP4
CNSTI4 132
ADDP4
CNSTI4 0
ASGNI4
line 1020
;1019:
;1020:	switch ( weaponNum ) {
ADDRLP4 136
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 1
LTI4 $923
ADDRLP4 136
INDIRI4
CNSTI4 10
GTI4 $923
ADDRLP4 136
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1002-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1002
address $925
address $951
address $959
address $968
address $961
address $928
address $984
address $975
address $995
address $947
code
LABELV $925
line 1022
;1021:	case WP_GAUNTLET:
;1022:		MAKERGB( weaponInfo->flashDlightColor, 0.6f, 0.6f, 1.0f );
ADDRLP4 12
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1058642330
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 44
ADDP4
CNSTF4 1058642330
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 48
ADDP4
CNSTF4 1065353216
ASGNF4
line 1023
;1023:		weaponInfo->firingSound = trap_S_RegisterSound( "sound/weapons/melee/fstrun.wav", qfalse );
ADDRGP4 $926
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 140
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 128
ADDP4
ADDRLP4 140
INDIRI4
ASGNI4
line 1024
;1024:		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/melee/fstatck.wav", qfalse );
ADDRGP4 $927
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 144
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 52
ADDP4
ADDRLP4 144
INDIRI4
ASGNI4
line 1025
;1025:		break;
ADDRGP4 $924
JUMPV
LABELV $928
line 1028
;1026:
;1027:	case WP_LIGHTNING:
;1028:		MAKERGB( weaponInfo->flashDlightColor, 0.6f, 0.6f, 1.0f );
ADDRLP4 12
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1058642330
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 44
ADDP4
CNSTF4 1058642330
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 48
ADDP4
CNSTF4 1065353216
ASGNF4
line 1029
;1029:		weaponInfo->readySound = trap_S_RegisterSound( "sound/weapons/melee/fsthum.wav", qfalse );
ADDRGP4 $929
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 148
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 124
ADDP4
ADDRLP4 148
INDIRI4
ASGNI4
line 1030
;1030:		weaponInfo->firingSound = trap_S_RegisterSound( "sound/weapons/lightning/lg_hum.wav", qfalse );
ADDRGP4 $930
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 152
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 128
ADDP4
ADDRLP4 152
INDIRI4
ASGNI4
line 1032
;1031:
;1032:		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/lightning/lg_fire.wav", qfalse );
ADDRGP4 $931
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 156
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 52
ADDP4
ADDRLP4 156
INDIRI4
ASGNI4
line 1033
;1033:		cgs.media.lightningShader = trap_R_RegisterShader( "lightningBoltNew");
ADDRGP4 $934
ARGP4
ADDRLP4 160
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+248
ADDRLP4 160
INDIRI4
ASGNI4
line 1034
;1034:		cgs.media.lightningExplosionModel = trap_R_RegisterModel( "models/weaphits/crackle.md3" );
ADDRGP4 $937
ARGP4
ADDRLP4 164
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+156680+508
ADDRLP4 164
INDIRI4
ASGNI4
line 1035
;1035:		cgs.media.sfx_lghit1 = trap_S_RegisterSound( "sound/weapons/lightning/lg_hit.wav", qfalse );
ADDRGP4 $940
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 168
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+736
ADDRLP4 168
INDIRI4
ASGNI4
line 1036
;1036:		cgs.media.sfx_lghit2 = trap_S_RegisterSound( "sound/weapons/lightning/lg_hit2.wav", qfalse );
ADDRGP4 $943
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 172
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+740
ADDRLP4 172
INDIRI4
ASGNI4
line 1037
;1037:		cgs.media.sfx_lghit3 = trap_S_RegisterSound( "sound/weapons/lightning/lg_hit3.wav", qfalse );
ADDRGP4 $946
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 176
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+156680+744
ADDRLP4 176
INDIRI4
ASGNI4
line 1039
;1038:
;1039:		break;
ADDRGP4 $924
JUMPV
LABELV $947
line 1042
;1040:
;1041:	case WP_GRAPPLING_HOOK:
;1042:		cgs.media.lightningShader = trap_R_RegisterShader( "lightningBoltNew");
ADDRGP4 $934
ARGP4
ADDRLP4 180
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+248
ADDRLP4 180
INDIRI4
ASGNI4
line 1043
;1043:		MAKERGB( weaponInfo->flashDlightColor, 0.6f, 0.6f, 1.0f );
ADDRLP4 12
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1058642330
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 44
ADDP4
CNSTF4 1058642330
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 48
ADDP4
CNSTF4 1065353216
ASGNF4
line 1044
;1044:		weaponInfo->missileModel = trap_R_RegisterModel( "models/ammo/rocket/rocket.md3" );
ADDRGP4 $950
ARGP4
ADDRLP4 184
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 184
INDIRI4
ASGNI4
line 1045
;1045:		weaponInfo->missileTrailFunc = CG_GrappleTrail;
ADDRLP4 12
INDIRP4
CNSTI4 88
ADDP4
ADDRGP4 CG_GrappleTrail
ASGNP4
line 1046
;1046:		weaponInfo->missileDlight = 200;
ADDRLP4 12
INDIRP4
CNSTI4 92
ADDP4
CNSTF4 1128792064
ASGNF4
line 1047
;1047:		weaponInfo->wiTrailTime = 2000;
ADDRLP4 12
INDIRP4
CNSTI4 120
ADDP4
CNSTF4 1157234688
ASGNF4
line 1048
;1048:		weaponInfo->trailRadius = 64;
ADDRLP4 12
INDIRP4
CNSTI4 116
ADDP4
CNSTF4 1115684864
ASGNF4
line 1049
;1049:		MAKERGB( weaponInfo->missileDlightColor, 1, 0.75f, 0 );
ADDRLP4 12
INDIRP4
CNSTI4 96
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 100
ADDP4
CNSTF4 1061158912
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 104
ADDP4
CNSTF4 0
ASGNF4
line 1051
;1050:		//weaponInfo->readySound = trap_S_RegisterSound( "sound/weapons/melee/fsthum.wav", qfalse );
;1051:		weaponInfo->firingSound = trap_S_RegisterSound( "sound/weapons/melee/fstrun.wav", qfalse );
ADDRGP4 $926
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 188
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 128
ADDP4
ADDRLP4 188
INDIRI4
ASGNI4
line 1052
;1052:		break;
ADDRGP4 $924
JUMPV
LABELV $951
line 1069
;1053:
;1054:#ifdef MISSIONPACK
;1055:	case WP_CHAINGUN:
;1056:		weaponInfo->firingSound = trap_S_RegisterSound( "sound/weapons/vulcan/wvulfire.wav", qfalse );
;1057:		weaponInfo->loopFireSound = qtrue;
;1058:		MAKERGB( weaponInfo->flashDlightColor, 1, 1, 0 );
;1059:		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/vulcan/vulcanf1b.wav", qfalse );
;1060:		weaponInfo->flashSound[1] = trap_S_RegisterSound( "sound/weapons/vulcan/vulcanf2b.wav", qfalse );
;1061:		weaponInfo->flashSound[2] = trap_S_RegisterSound( "sound/weapons/vulcan/vulcanf3b.wav", qfalse );
;1062:		weaponInfo->flashSound[3] = trap_S_RegisterSound( "sound/weapons/vulcan/vulcanf4b.wav", qfalse );
;1063:		weaponInfo->ejectBrassFunc = CG_MachineGunEjectBrass;
;1064:		cgs.media.bulletExplosionShader = trap_R_RegisterShader( "bulletExplosion" );
;1065:		break;
;1066:#endif
;1067:
;1068:	case WP_MACHINEGUN:
;1069:		MAKERGB( weaponInfo->flashDlightColor, 1, 1, 0 );
ADDRLP4 12
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 44
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 48
ADDP4
CNSTF4 0
ASGNF4
line 1070
;1070:		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/machinegun/machgf1b.wav", qfalse );
ADDRGP4 $952
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 192
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 52
ADDP4
ADDRLP4 192
INDIRI4
ASGNI4
line 1071
;1071:		weaponInfo->flashSound[1] = trap_S_RegisterSound( "sound/weapons/machinegun/machgf2b.wav", qfalse );
ADDRGP4 $953
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 196
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 56
ADDP4
ADDRLP4 196
INDIRI4
ASGNI4
line 1072
;1072:		weaponInfo->flashSound[2] = trap_S_RegisterSound( "sound/weapons/machinegun/machgf3b.wav", qfalse );
ADDRGP4 $954
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 200
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 60
ADDP4
ADDRLP4 200
INDIRI4
ASGNI4
line 1073
;1073:		weaponInfo->flashSound[3] = trap_S_RegisterSound( "sound/weapons/machinegun/machgf4b.wav", qfalse );
ADDRGP4 $955
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 204
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 64
ADDP4
ADDRLP4 204
INDIRI4
ASGNI4
line 1074
;1074:		weaponInfo->ejectBrassFunc = CG_MachineGunEjectBrass;
ADDRLP4 12
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 CG_MachineGunEjectBrass
ASGNP4
line 1075
;1075:		cgs.media.bulletExplosionShader = trap_R_RegisterShader( "bulletExplosion" );
ADDRGP4 $958
ARGP4
ADDRLP4 208
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+520
ADDRLP4 208
INDIRI4
ASGNI4
line 1076
;1076:		break;
ADDRGP4 $924
JUMPV
LABELV $959
line 1079
;1077:
;1078:	case WP_SHOTGUN:
;1079:		MAKERGB( weaponInfo->flashDlightColor, 1, 1, 0 );
ADDRLP4 12
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 44
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 48
ADDP4
CNSTF4 0
ASGNF4
line 1080
;1080:		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/shotgun/sshotf1b.wav", qfalse );
ADDRGP4 $960
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 212
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 52
ADDP4
ADDRLP4 212
INDIRI4
ASGNI4
line 1081
;1081:		weaponInfo->ejectBrassFunc = CG_ShotgunEjectBrass;
ADDRLP4 12
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 CG_ShotgunEjectBrass
ASGNP4
line 1082
;1082:		break;
ADDRGP4 $924
JUMPV
LABELV $961
line 1085
;1083:
;1084:	case WP_ROCKET_LAUNCHER:
;1085:		weaponInfo->missileModel = trap_R_RegisterModel( "models/ammo/rocket/rocket.md3" );
ADDRGP4 $950
ARGP4
ADDRLP4 216
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 216
INDIRI4
ASGNI4
line 1086
;1086:		weaponInfo->missileSound = trap_S_RegisterSound( "sound/weapons/rocket/rockfly.wav", qfalse );
ADDRGP4 $962
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 220
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 84
ADDP4
ADDRLP4 220
INDIRI4
ASGNI4
line 1087
;1087:		weaponInfo->missileTrailFunc = CG_RocketTrail;
ADDRLP4 12
INDIRP4
CNSTI4 88
ADDP4
ADDRGP4 CG_RocketTrail
ASGNP4
line 1088
;1088:		weaponInfo->missileDlight = 200;
ADDRLP4 12
INDIRP4
CNSTI4 92
ADDP4
CNSTF4 1128792064
ASGNF4
line 1089
;1089:		weaponInfo->wiTrailTime = 2000;
ADDRLP4 12
INDIRP4
CNSTI4 120
ADDP4
CNSTF4 1157234688
ASGNF4
line 1090
;1090:		weaponInfo->trailRadius = cg_smokeRadius_RL.integer;
ADDRLP4 12
INDIRP4
CNSTI4 116
ADDP4
ADDRGP4 cg_smokeRadius_RL+12
INDIRI4
CVIF4 4
ASGNF4
line 1092
;1091:		
;1092:		MAKERGB( weaponInfo->missileDlightColor, 1, 0.75f, 0 );
ADDRLP4 12
INDIRP4
CNSTI4 96
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 100
ADDP4
CNSTF4 1061158912
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 104
ADDP4
CNSTF4 0
ASGNF4
line 1093
;1093:		MAKERGB( weaponInfo->flashDlightColor, 1, 0.75f, 0 );
ADDRLP4 12
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 44
ADDP4
CNSTF4 1061158912
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 48
ADDP4
CNSTF4 0
ASGNF4
line 1095
;1094:
;1095:		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/rocket/rocklf1a.wav", qfalse );
ADDRGP4 $964
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 224
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 52
ADDP4
ADDRLP4 224
INDIRI4
ASGNI4
line 1096
;1096:		cgs.media.rocketExplosionShader = trap_R_RegisterShader( "rocketExplosion" );
ADDRGP4 $967
ARGP4
ADDRLP4 228
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+524
ADDRLP4 228
INDIRI4
ASGNI4
line 1097
;1097:		break;
ADDRGP4 $924
JUMPV
LABELV $968
line 1112
;1098:
;1099:#ifdef MISSIONPACK
;1100:	case WP_PROX_LAUNCHER:
;1101:		weaponInfo->missileModel = trap_R_RegisterModel( "models/weaphits/proxmine.md3" );
;1102:		weaponInfo->missileTrailFunc = CG_GrenadeTrail;
;1103:		weaponInfo->wiTrailTime = 700;
;1104:		weaponInfo->trailRadius = 32;
;1105:		MAKERGB( weaponInfo->flashDlightColor, 1, 0.70f, 0 );
;1106:		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/proxmine/wstbfire.wav", qfalse );
;1107:		cgs.media.grenadeExplosionShader = trap_R_RegisterShader( "grenadeExplosion" );
;1108:		break;
;1109:#endif
;1110:
;1111:	case WP_GRENADE_LAUNCHER:
;1112:		weaponInfo->missileModel = trap_R_RegisterModel( "models/ammo/grenade1.md3" );
ADDRGP4 $969
ARGP4
ADDRLP4 232
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 232
INDIRI4
ASGNI4
line 1113
;1113:		weaponInfo->missileTrailFunc = CG_GrenadeTrail;
ADDRLP4 12
INDIRP4
CNSTI4 88
ADDP4
ADDRGP4 CG_GrenadeTrail
ASGNP4
line 1114
;1114:		weaponInfo->wiTrailTime = 700;
ADDRLP4 12
INDIRP4
CNSTI4 120
ADDP4
CNSTF4 1143930880
ASGNF4
line 1115
;1115:		weaponInfo->trailRadius = cg_smokeRadius_GL.integer;
ADDRLP4 12
INDIRP4
CNSTI4 116
ADDP4
ADDRGP4 cg_smokeRadius_GL+12
INDIRI4
CVIF4 4
ASGNF4
line 1116
;1116:		MAKERGB( weaponInfo->flashDlightColor, 1, 0.70f, 0 );
ADDRLP4 12
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 44
ADDP4
CNSTF4 1060320051
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 48
ADDP4
CNSTF4 0
ASGNF4
line 1117
;1117:		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/grenade/grenlf1a.wav", qfalse );
ADDRGP4 $971
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 236
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 52
ADDP4
ADDRLP4 236
INDIRI4
ASGNI4
line 1118
;1118:		cgs.media.grenadeExplosionShader = trap_R_RegisterShader( "grenadeExplosion" );
ADDRGP4 $974
ARGP4
ADDRLP4 240
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+528
ADDRLP4 240
INDIRI4
ASGNI4
line 1119
;1119:		break;
ADDRGP4 $924
JUMPV
LABELV $975
line 1136
;1120:
;1121:#ifdef MISSIONPACK
;1122:	case WP_NAILGUN:
;1123:		weaponInfo->ejectBrassFunc = CG_NailgunEjectBrass;
;1124:		weaponInfo->missileTrailFunc = CG_NailTrail;
;1125://		weaponInfo->missileSound = trap_S_RegisterSound( "sound/weapons/nailgun/wnalflit.wav", qfalse );
;1126:		weaponInfo->trailRadius = 16;
;1127:		weaponInfo->wiTrailTime = 250;
;1128:		weaponInfo->missileModel = trap_R_RegisterModel( "models/weaphits/nail.md3" );
;1129:		MAKERGB( weaponInfo->flashDlightColor, 1, 0.75f, 0 );
;1130:		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/nailgun/wnalfire.wav", qfalse );
;1131:		break;
;1132:#endif
;1133:
;1134:	case WP_PLASMAGUN:
;1135://		weaponInfo->missileModel = cgs.media.invulnerabilityPowerupModel;
;1136:		weaponInfo->missileTrailFunc = CG_PlasmaTrail;
ADDRLP4 12
INDIRP4
CNSTI4 88
ADDP4
ADDRGP4 CG_PlasmaTrail
ASGNP4
line 1137
;1137:		weaponInfo->missileSound = trap_S_RegisterSound( "sound/weapons/plasma/lasfly.wav", qfalse );
ADDRGP4 $976
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 244
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 84
ADDP4
ADDRLP4 244
INDIRI4
ASGNI4
line 1138
;1138:		MAKERGB( weaponInfo->flashDlightColor, 0.6f, 0.6f, 1.0f );
ADDRLP4 12
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1058642330
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 44
ADDP4
CNSTF4 1058642330
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 48
ADDP4
CNSTF4 1065353216
ASGNF4
line 1139
;1139:		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/plasma/hyprbf1a.wav", qfalse );
ADDRGP4 $977
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 248
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 52
ADDP4
ADDRLP4 248
INDIRI4
ASGNI4
line 1140
;1140:		cgs.media.plasmaExplosionShader = trap_R_RegisterShader( "plasmaExplosion" );
ADDRGP4 $980
ARGP4
ADDRLP4 252
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+516
ADDRLP4 252
INDIRI4
ASGNI4
line 1141
;1141:		cgs.media.railRingsShader = trap_R_RegisterShader( "railDisc" );
ADDRGP4 $983
ARGP4
ADDRLP4 256
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+240
ADDRLP4 256
INDIRI4
ASGNI4
line 1142
;1142:		break;
ADDRGP4 $924
JUMPV
LABELV $984
line 1145
;1143:
;1144:	case WP_RAILGUN:
;1145:		weaponInfo->readySound = trap_S_RegisterSound( "sound/weapons/railgun/rg_hum.wav", qfalse );
ADDRGP4 $985
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 260
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 124
ADDP4
ADDRLP4 260
INDIRI4
ASGNI4
line 1146
;1146:		MAKERGB( weaponInfo->flashDlightColor, 1, 0.5f, 0 );
ADDRLP4 12
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 44
ADDP4
CNSTF4 1056964608
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 48
ADDP4
CNSTF4 0
ASGNF4
line 1147
;1147:		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/railgun/railgf1a.wav", qfalse );
ADDRGP4 $986
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 264
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 52
ADDP4
ADDRLP4 264
INDIRI4
ASGNI4
line 1148
;1148:		cgs.media.railExplosionShader = trap_R_RegisterShader( "railExplosion" );
ADDRGP4 $989
ARGP4
ADDRLP4 268
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+512
ADDRLP4 268
INDIRI4
ASGNI4
line 1149
;1149:		cgs.media.railRingsShader = trap_R_RegisterShader( "railDisc" );
ADDRGP4 $983
ARGP4
ADDRLP4 272
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+240
ADDRLP4 272
INDIRI4
ASGNI4
line 1150
;1150:		cgs.media.railCoreShader = trap_R_RegisterShader( "railCore" );
ADDRGP4 $994
ARGP4
ADDRLP4 276
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+244
ADDRLP4 276
INDIRI4
ASGNI4
line 1151
;1151:		break;
ADDRGP4 $924
JUMPV
LABELV $995
line 1154
;1152:
;1153:	case WP_BFG:
;1154:		weaponInfo->readySound = trap_S_RegisterSound( "sound/weapons/bfg/bfg_hum.wav", qfalse );
ADDRGP4 $996
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 280
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 124
ADDP4
ADDRLP4 280
INDIRI4
ASGNI4
line 1155
;1155:		MAKERGB( weaponInfo->flashDlightColor, 1, 0.7f, 1 );
ADDRLP4 12
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 44
ADDP4
CNSTF4 1060320051
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 48
ADDP4
CNSTF4 1065353216
ASGNF4
line 1156
;1156:		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/bfg/bfg_fire.wav", qfalse );
ADDRGP4 $997
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 284
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 52
ADDP4
ADDRLP4 284
INDIRI4
ASGNI4
line 1157
;1157:		cgs.media.bfgExplosionShader = trap_R_RegisterShader( "bfgExplosion" );
ADDRGP4 $1000
ARGP4
ADDRLP4 288
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+156680+532
ADDRLP4 288
INDIRI4
ASGNI4
line 1158
;1158:		weaponInfo->missileModel = trap_R_RegisterModel( "models/weaphits/bfg.md3" );
ADDRGP4 $1001
ARGP4
ADDRLP4 292
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 292
INDIRI4
ASGNI4
line 1159
;1159:		weaponInfo->missileSound = trap_S_RegisterSound( "sound/weapons/rocket/rockfly.wav", qfalse );
ADDRGP4 $962
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 296
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 84
ADDP4
ADDRLP4 296
INDIRI4
ASGNI4
line 1160
;1160:		break;
ADDRGP4 $924
JUMPV
LABELV $923
line 1163
;1161:
;1162:	 default:
;1163:		MAKERGB( weaponInfo->flashDlightColor, 1, 1, 1 );
ADDRLP4 12
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 44
ADDP4
CNSTF4 1065353216
ASGNF4
ADDRLP4 12
INDIRP4
CNSTI4 48
ADDP4
CNSTF4 1065353216
ASGNF4
line 1164
;1164:		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/rocket/rocklf1a.wav", qfalse );
ADDRGP4 $964
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 300
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 52
ADDP4
ADDRLP4 300
INDIRI4
ASGNI4
line 1165
;1165:		break;
LABELV $924
line 1167
;1166:	}
;1167:}
LABELV $889
endproc CG_RegisterWeapon 304 12
export CG_RegisterItemVisuals
proc CG_RegisterItemVisuals 28 12
line 1176
;1168:
;1169:/*
;1170:=================
;1171:CG_RegisterItemVisuals
;1172:
;1173:The server says this item is used on this level
;1174:=================
;1175:*/
;1176:void CG_RegisterItemVisuals( int itemNum ) {
line 1180
;1177:	itemInfo_t		*itemInfo;
;1178:	gitem_t			*item;
;1179:
;1180:	if ( itemNum < 0 || itemNum >= bg_numItems ) {
ADDRLP4 8
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $1007
ADDRLP4 8
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $1005
LABELV $1007
line 1181
;1181:		CG_Error( "CG_RegisterItemVisuals: itemNum %d out of range [0-%d]", itemNum, bg_numItems-1 );
ADDRGP4 $1008
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 bg_numItems
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 1182
;1182:	}
LABELV $1005
line 1184
;1183:
;1184:	itemInfo = &cg_items[ itemNum ];
ADDRLP4 4
CNSTI4 24
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 cg_items
ADDP4
ASGNP4
line 1185
;1185:	if ( itemInfo->registered ) {
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $1009
line 1186
;1186:		return;
ADDRGP4 $1004
JUMPV
LABELV $1009
line 1189
;1187:	}
;1188:
;1189:	item = &bg_itemlist[ itemNum ];
ADDRLP4 0
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 1191
;1190:
;1191:	memset( itemInfo, 0, sizeof( &itemInfo ) );
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1192
;1192:	itemInfo->registered = qtrue;
ADDRLP4 4
INDIRP4
CNSTI4 1
ASGNI4
line 1194
;1193:
;1194:	itemInfo->models[0] = trap_R_RegisterModel( item->world_model[0] );
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1196
;1195:
;1196:	itemInfo->icon = trap_R_RegisterShader( item->icon );
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1198
;1197:
;1198:	if ( item->giType == IT_WEAPON ) {
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1011
line 1199
;1199:		CG_RegisterWeapon( item->giTag );
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_RegisterWeapon
CALLV
pop
line 1200
;1200:	}
LABELV $1011
line 1205
;1201:
;1202:	//
;1203:	// powerups have an accompanying ring or sphere
;1204:	//
;1205:	if ( item->giType == IT_POWERUP || item->giType == IT_HEALTH || 
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 5
EQI4 $1017
ADDRLP4 20
INDIRI4
CNSTI4 4
EQI4 $1017
ADDRLP4 20
INDIRI4
CNSTI4 3
EQI4 $1017
ADDRLP4 20
INDIRI4
CNSTI4 6
NEI4 $1013
LABELV $1017
line 1206
;1206:		item->giType == IT_ARMOR || item->giType == IT_HOLDABLE ) {
line 1207
;1207:		if ( item->world_model[1] ) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1018
line 1208
;1208:			itemInfo->models[1] = trap_R_RegisterModel( item->world_model[1] );
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 1209
;1209:		}
LABELV $1018
line 1210
;1210:	}
LABELV $1013
line 1211
;1211:}
LABELV $1004
endproc CG_RegisterItemVisuals 28 12
proc CG_MapTorsoToWeaponFrame 24 0
line 1228
;1212:
;1213:
;1214:/*
;1215:========================================================================================
;1216:
;1217:VIEW WEAPON
;1218:
;1219:========================================================================================
;1220:*/
;1221:
;1222:/*
;1223:=================
;1224:CG_MapTorsoToWeaponFrame
;1225:
;1226:=================
;1227:*/
;1228:static int CG_MapTorsoToWeaponFrame( clientInfo_t *ci, int frame ) {
line 1231
;1229:
;1230:	// change weapon
;1231:	if ( frame >= ci->animations[TORSO_DROP].firstFrame 
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 856
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $1021
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 9
ADDI4
GEI4 $1021
line 1232
;1232:		&& frame < ci->animations[TORSO_DROP].firstFrame + 9 ) {
line 1233
;1233:		return frame - ci->animations[TORSO_DROP].firstFrame + 6;
ADDRFP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 856
ADDP4
INDIRI4
SUBI4
CNSTI4 6
ADDI4
RETI4
ADDRGP4 $1020
JUMPV
LABELV $1021
line 1237
;1234:	}
;1235:
;1236:	// stand attack
;1237:	if ( frame >= ci->animations[TORSO_ATTACK].firstFrame 
ADDRLP4 8
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 800
ADDP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRI4
LTI4 $1023
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRI4
CNSTI4 6
ADDI4
GEI4 $1023
line 1238
;1238:		&& frame < ci->animations[TORSO_ATTACK].firstFrame + 6 ) {
line 1239
;1239:		return 1 + frame - ci->animations[TORSO_ATTACK].firstFrame;
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
ADDRFP4 0
INDIRP4
CNSTI4 800
ADDP4
INDIRI4
SUBI4
RETI4
ADDRGP4 $1020
JUMPV
LABELV $1023
line 1243
;1240:	}
;1241:
;1242:	// stand attack 2
;1243:	if ( frame >= ci->animations[TORSO_ATTACK2].firstFrame 
ADDRLP4 16
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 828
ADDP4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRI4
LTI4 $1025
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRI4
CNSTI4 6
ADDI4
GEI4 $1025
line 1244
;1244:		&& frame < ci->animations[TORSO_ATTACK2].firstFrame + 6 ) {
line 1245
;1245:		return 1 + frame - ci->animations[TORSO_ATTACK2].firstFrame;
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
ADDRFP4 0
INDIRP4
CNSTI4 828
ADDP4
INDIRI4
SUBI4
RETI4
ADDRGP4 $1020
JUMPV
LABELV $1025
line 1248
;1246:	}
;1247:	
;1248:	return 0;
CNSTI4 0
RETI4
LABELV $1020
endproc CG_MapTorsoToWeaponFrame 24 0
proc CG_CalculateWeaponPosition 40 4
line 1257
;1249:}
;1250:
;1251:
;1252:/*
;1253:==============
;1254:CG_CalculateWeaponPosition
;1255:==============
;1256:*/
;1257:static void CG_CalculateWeaponPosition( vec3_t origin, vec3_t angles ) {
line 1262
;1258:	float	scale;
;1259:	int		delta;
;1260:	float	fracsin;
;1261:
;1262:	VectorCopy( cg.refdef.vieworg, origin );
ADDRFP4 0
INDIRP4
ADDRGP4 cg+109048+24
INDIRB
ASGNB 12
line 1263
;1263:	VectorCopy( cg.refdefViewAngles, angles );
ADDRFP4 4
INDIRP4
ADDRGP4 cg+109416
INDIRB
ASGNB 12
line 1266
;1264:
;1265:	// on odd legs, invert some angles
;1266:	if ( cg.bobcycle & 1 ) {
ADDRGP4 cg+130924
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1031
line 1267
;1267:		scale = -cg.xyspeed;
ADDRLP4 0
ADDRGP4 cg+130928
INDIRF4
NEGF4
ASGNF4
line 1268
;1268:	} else {
ADDRGP4 $1032
JUMPV
LABELV $1031
line 1269
;1269:		scale = cg.xyspeed;
ADDRLP4 0
ADDRGP4 cg+130928
INDIRF4
ASGNF4
line 1270
;1270:	}
LABELV $1032
line 1273
;1271:
;1272:	// gun angles from bobbing
;1273:	angles[ROLL] += scale * cg.bobfracsin * 0.005;
ADDRLP4 12
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
CNSTF4 1000593162
ADDRLP4 0
INDIRF4
ADDRGP4 cg+130920
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 1274
;1274:	angles[YAW] += scale * cg.bobfracsin * 0.01;
ADDRLP4 16
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
CNSTF4 1008981770
ADDRLP4 0
INDIRF4
ADDRGP4 cg+130920
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 1275
;1275:	angles[PITCH] += cg.xyspeed * cg.bobfracsin * 0.005;
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
CNSTF4 1000593162
ADDRGP4 cg+130928
INDIRF4
ADDRGP4 cg+130920
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 1278
;1276:
;1277:	// drop the weapon when landing
;1278:	delta = cg.time - cg.landTime;
ADDRLP4 8
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+108940
INDIRI4
SUBI4
ASGNI4
line 1279
;1279:	if ( delta < LAND_DEFLECT_TIME ) {
ADDRLP4 8
INDIRI4
CNSTI4 150
GEI4 $1042
line 1280
;1280:		origin[2] += cg.landChange*0.25 * delta / LAND_DEFLECT_TIME;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
CNSTF4 1048576000
ADDRGP4 cg+108936
INDIRF4
MULF4
ADDRLP4 8
INDIRI4
CVIF4 4
MULF4
CNSTF4 1125515264
DIVF4
ADDF4
ASGNF4
line 1281
;1281:	} else if ( delta < LAND_DEFLECT_TIME + LAND_RETURN_TIME ) {
ADDRGP4 $1043
JUMPV
LABELV $1042
ADDRLP4 8
INDIRI4
CNSTI4 450
GEI4 $1045
line 1282
;1282:		origin[2] += cg.landChange*0.25 * 
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
CNSTF4 1048576000
ADDRGP4 cg+108936
INDIRF4
MULF4
CNSTI4 450
ADDRLP4 8
INDIRI4
SUBI4
CVIF4 4
MULF4
CNSTF4 1133903872
DIVF4
ADDF4
ASGNF4
line 1284
;1283:			(LAND_DEFLECT_TIME + LAND_RETURN_TIME - delta) / LAND_RETURN_TIME;
;1284:	}
LABELV $1045
LABELV $1043
line 1297
;1285:
;1286:#if 0
;1287:	// drop the weapon when stair climbing
;1288:	delta = cg.time - cg.stepTime;
;1289:	if ( delta < STEP_TIME/2 ) {
;1290:		origin[2] -= cg.stepChange*0.25 * delta / (STEP_TIME/2);
;1291:	} else if ( delta < STEP_TIME ) {
;1292:		origin[2] -= cg.stepChange*0.25 * (STEP_TIME - delta) / (STEP_TIME/2);
;1293:	}
;1294:#endif
;1295:
;1296:	// idle drift
;1297:	scale = cg.xyspeed + 40;
ADDRLP4 0
ADDRGP4 cg+130928
INDIRF4
CNSTF4 1109393408
ADDF4
ASGNF4
line 1298
;1298:	fracsin = sin( cg.time * 0.001 );
CNSTF4 981668463
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
MULF4
ARGF4
ADDRLP4 24
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 24
INDIRF4
ASGNF4
line 1299
;1299:	angles[ROLL] += scale * fracsin * 0.01;
ADDRLP4 28
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
CNSTF4 1008981770
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 1300
;1300:	angles[YAW] += scale * fracsin * 0.01;
ADDRLP4 32
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRF4
CNSTF4 1008981770
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 1301
;1301:	angles[PITCH] += scale * fracsin * 0.01;
ADDRLP4 36
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRF4
CNSTF4 1008981770
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 1302
;1302:}
LABELV $1027
endproc CG_CalculateWeaponPosition 40 4
proc CG_LightningBolt 284 28
line 1316
;1303:
;1304:
;1305:/*
;1306:===============
;1307:CG_LightningBolt
;1308:
;1309:Origin will be the exact tag point, which is slightly
;1310:different than the muzzle point used for determining hits.
;1311:The cent should be the non-predicted cent if it is from the player,
;1312:so the endpoint will reflect the simulated strike (lagging the predicted
;1313:angle)
;1314:===============
;1315:*/
;1316:static void CG_LightningBolt( centity_t *cent, vec3_t origin ) {
line 1322
;1317:	trace_t  trace;
;1318:	refEntity_t  beam;
;1319:	vec3_t   forward;
;1320:	vec3_t   muzzlePoint, endPoint;
;1321:
;1322:	if (cent->currentState.weapon != WP_LIGHTNING) {
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 6
EQI4 $1051
line 1323
;1323:		return;
ADDRGP4 $1050
JUMPV
LABELV $1051
line 1326
;1324:	}
;1325:
;1326:	memset( &beam, 0, sizeof( beam ) );
ADDRLP4 12
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1330
;1327:
;1328://unlagged - attack prediction #1
;1329:	// if the entity is us, unlagged is on server-side, and we've got it on for the lightning gun
;1330:	if ( (cent->currentState.number == cg.predictedPlayerState.clientNum) && cgs.delagHitscan &&
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $1053
ADDRLP4 232
CNSTI4 0
ASGNI4
ADDRGP4 cgs+157800
INDIRI4
ADDRLP4 232
INDIRI4
EQI4 $1053
ADDRGP4 cg_aimType+12
INDIRI4
ADDRLP4 232
INDIRI4
LEI4 $1053
line 1331
;1331:			( cg_aimType.integer > 0 ) ) {
line 1333
;1332:		// always shoot straight forward from our current position
;1333:		AngleVectors( cg.predictedPlayerState.viewangles, forward, NULL, NULL );
ADDRGP4 cg+107636+152
ARGP4
ADDRLP4 152
ARGP4
ADDRLP4 236
CNSTP4 0
ASGNP4
ADDRLP4 236
INDIRP4
ARGP4
ADDRLP4 236
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 1334
;1334:		VectorCopy( cg.predictedPlayerState.origin, muzzlePoint );
ADDRLP4 0
ADDRGP4 cg+107636+20
INDIRB
ASGNB 12
line 1335
;1335:	}
ADDRGP4 $1054
JUMPV
LABELV $1053
line 1339
;1336:	else
;1337://unlagged - attack prediction #1
;1338:	// CPMA  "true" lightning
;1339:	if ((cent->currentState.number == cg.predictedPlayerState.clientNum) && (cg_trueLightning.value != 0)) {
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $1063
ADDRGP4 cg_trueLightning+8
INDIRF4
CNSTF4 0
EQF4 $1063
line 1346
;1340:		vec3_t angle;
;1341:		int i;
;1342:
;1343://unlagged - true lightning
;1344:		// might as well fix up true lightning while we're at it
;1345:		vec3_t viewangles;
;1346:		VectorCopy( cg.predictedPlayerState.viewangles, viewangles );
ADDRLP4 252
ADDRGP4 cg+107636+152
INDIRB
ASGNB 12
line 1349
;1347://unlagged - true lightning
;1348:
;1349:		for (i = 0; i < 3; i++) {
ADDRLP4 236
CNSTI4 0
ASGNI4
LABELV $1070
line 1350
;1350:			float a = cent->lerpAngles[i] - viewangles[i]; //unlagged: was cg.refdefViewAngles[i];
ADDRLP4 268
ADDRLP4 236
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 264
ADDRLP4 268
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ADDP4
INDIRF4
ADDRLP4 268
INDIRI4
ADDRLP4 252
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1351
;1351:			if (a > 180) {
ADDRLP4 264
INDIRF4
CNSTF4 1127481344
LEF4 $1074
line 1352
;1352:				a -= 360;
ADDRLP4 264
ADDRLP4 264
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
line 1353
;1353:			}
LABELV $1074
line 1354
;1354:			if (a < -180) {
ADDRLP4 264
INDIRF4
CNSTF4 3274964992
GEF4 $1076
line 1355
;1355:				a += 360;
ADDRLP4 264
ADDRLP4 264
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
line 1356
;1356:			}
LABELV $1076
line 1358
;1357:
;1358:			angle[i] = viewangles[i] /*unlagged: was cg.refdefViewAngles[i]*/ + a * (1.0 - cg_trueLightning.value);
ADDRLP4 272
ADDRLP4 236
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 272
INDIRI4
ADDRLP4 240
ADDP4
ADDRLP4 272
INDIRI4
ADDRLP4 252
ADDP4
INDIRF4
ADDRLP4 264
INDIRF4
CNSTF4 1065353216
ADDRGP4 cg_trueLightning+8
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 1359
;1359:			if (angle[i] < 0) {
ADDRLP4 236
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 240
ADDP4
INDIRF4
CNSTF4 0
GEF4 $1079
line 1360
;1360:				angle[i] += 360;
ADDRLP4 276
ADDRLP4 236
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 240
ADDP4
ASGNP4
ADDRLP4 276
INDIRP4
ADDRLP4 276
INDIRP4
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
line 1361
;1361:			}
LABELV $1079
line 1362
;1362:			if (angle[i] > 360) {
ADDRLP4 236
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 240
ADDP4
INDIRF4
CNSTF4 1135869952
LEF4 $1081
line 1363
;1363:				angle[i] -= 360;
ADDRLP4 276
ADDRLP4 236
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 240
ADDP4
ASGNP4
ADDRLP4 276
INDIRP4
ADDRLP4 276
INDIRP4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
line 1364
;1364:			}
LABELV $1081
line 1365
;1365:		}
LABELV $1071
line 1349
ADDRLP4 236
ADDRLP4 236
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 236
INDIRI4
CNSTI4 3
LTI4 $1070
line 1367
;1366:
;1367:		AngleVectors(angle, forward, NULL, NULL );
ADDRLP4 240
ARGP4
ADDRLP4 152
ARGP4
ADDRLP4 264
CNSTP4 0
ASGNP4
ADDRLP4 264
INDIRP4
ARGP4
ADDRLP4 264
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 1373
;1368:
;1369://unlagged - true lightning
;1370://		VectorCopy(cent->lerpOrigin, muzzlePoint );
;1371://		VectorCopy(cg.refdef.vieworg, muzzlePoint );
;1372:		// *this* is the correct origin for true lightning
;1373:		VectorCopy(cg.predictedPlayerState.origin, muzzlePoint );
ADDRLP4 0
ADDRGP4 cg+107636+20
INDIRB
ASGNB 12
line 1376
;1374://unlagged - true lightning
;1375:
;1376:	} else {
ADDRGP4 $1064
JUMPV
LABELV $1063
line 1378
;1377:		// !CPMA
;1378:		AngleVectors( cent->lerpAngles, forward, NULL, NULL );
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 152
ARGP4
ADDRLP4 236
CNSTP4 0
ASGNP4
ADDRLP4 236
INDIRP4
ARGP4
ADDRLP4 236
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 1379
;1379:		VectorCopy(cent->lerpOrigin, muzzlePoint );
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 704
ADDP4
INDIRB
ASGNB 12
line 1380
;1380:	}
LABELV $1064
LABELV $1054
line 1383
;1381:
;1382:	//Verify this
;1383:	muzzlePoint[2] += cg.snap->ps.viewheight;//DEFAULT_VIEWHEIGHT;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRGP4 cg+36
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1385
;1384:
;1385:	VectorMA( muzzlePoint, 14, forward, muzzlePoint );
ADDRLP4 236
CNSTF4 1096810496
ASGNF4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 236
INDIRF4
ADDRLP4 152
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 236
INDIRF4
ADDRLP4 152+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1096810496
ADDRLP4 152+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1388
;1386:
;1387:	// project forward by the lightning range
;1388:	VectorMA( muzzlePoint, LIGHTNING_RANGE, forward, endPoint );
ADDRLP4 240
CNSTF4 1145044992
ASGNF4
ADDRLP4 164
ADDRLP4 0
INDIRF4
ADDRLP4 240
INDIRF4
ADDRLP4 152
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 164+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 240
INDIRF4
ADDRLP4 152+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 164+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1145044992
ADDRLP4 152+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1391
;1389:
;1390:	// see if it hit a wall
;1391:	CG_Trace( &trace, muzzlePoint, vec3_origin, vec3_origin, endPoint, 
ADDRLP4 176
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 244
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 244
INDIRP4
ARGP4
ADDRLP4 244
INDIRP4
ARGP4
ADDRLP4 164
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 1395
;1392:		cent->currentState.number, MASK_SHOT );
;1393:
;1394:	// this is the endpoint
;1395:	VectorCopy( trace.endpos, beam.oldorigin );
ADDRLP4 12+84
ADDRLP4 176+12
INDIRB
ASGNB 12
line 1399
;1396:
;1397:	// use the provided origin, even though it may be slightly
;1398:	// different than the muzzle origin
;1399:	VectorCopy( origin, beam.origin );
ADDRLP4 12+68
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 1401
;1400:
;1401:	beam.reType = RT_LIGHTNING;
ADDRLP4 12
CNSTI4 6
ASGNI4
line 1402
;1402:	beam.customShader = cgs.media.lightningShader;
ADDRLP4 12+112
ADDRGP4 cgs+156680+248
INDIRI4
ASGNI4
line 1403
;1403:	trap_R_AddRefEntityToScene( &beam );
ADDRLP4 12
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1406
;1404:
;1405:	// add the impact flare if it hit something
;1406:	if ( cg_lightningImpact.integer ) {
ADDRGP4 cg_lightningImpact+12
INDIRI4
CNSTI4 0
EQI4 $1105
line 1407
;1407:		if ( trace.fraction < 1.0 ) {
ADDRLP4 176+8
INDIRF4
CNSTF4 1065353216
GEF4 $1108
line 1411
;1408:			vec3_t	angles;
;1409:			vec3_t	dir;
;1410:
;1411:			VectorSubtract( beam.oldorigin, beam.origin, dir );
ADDRLP4 248
ADDRLP4 12+84
INDIRF4
ADDRLP4 12+68
INDIRF4
SUBF4
ASGNF4
ADDRLP4 248+4
ADDRLP4 12+84+4
INDIRF4
ADDRLP4 12+68+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 248+8
ADDRLP4 12+84+8
INDIRF4
ADDRLP4 12+68+8
INDIRF4
SUBF4
ASGNF4
line 1412
;1412:			VectorNormalize( dir );
ADDRLP4 248
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 1414
;1413:
;1414:			memset( &beam, 0, sizeof( beam ) );
ADDRLP4 12
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1415
;1415:			beam.hModel = cgs.media.lightningExplosionModel;
ADDRLP4 12+8
ADDRGP4 cgs+156680+508
INDIRI4
ASGNI4
line 1417
;1416:
;1417:			VectorMA( trace.endpos, -16, dir, beam.origin );
ADDRLP4 12+68
ADDRLP4 176+12
INDIRF4
CNSTF4 3246391296
ADDRLP4 248
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 12+68+4
ADDRLP4 176+12+4
INDIRF4
CNSTF4 3246391296
ADDRLP4 248+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 12+68+8
ADDRLP4 176+12+8
INDIRF4
CNSTF4 3246391296
ADDRLP4 248+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1420
;1418:
;1419:			// make a random orientation
;1420:			angles[0] = rand() % 360;
ADDRLP4 272
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 260
ADDRLP4 272
INDIRI4
CNSTI4 360
MODI4
CVIF4 4
ASGNF4
line 1421
;1421:			angles[1] = rand() % 360;
ADDRLP4 276
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 260+4
ADDRLP4 276
INDIRI4
CNSTI4 360
MODI4
CVIF4 4
ASGNF4
line 1422
;1422:			angles[2] = rand() % 360;
ADDRLP4 280
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 260+8
ADDRLP4 280
INDIRI4
CNSTI4 360
MODI4
CVIF4 4
ASGNF4
line 1423
;1423:			AnglesToAxis( angles, beam.axis );
ADDRLP4 260
ARGP4
ADDRLP4 12+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1424
;1424:			trap_R_AddRefEntityToScene( &beam );
ADDRLP4 12
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1425
;1425:		}
LABELV $1108
line 1426
;1426:	}
LABELV $1105
line 1427
;1427:}
LABELV $1050
endproc CG_LightningBolt 284 28
proc CG_SpawnRailTrail 4 12
line 1500
;1428:/*
;1429:
;1430:static void CG_LightningBolt( centity_t *cent, vec3_t origin ) {
;1431:	trace_t		trace;
;1432:	refEntity_t		beam;
;1433:	vec3_t			forward;
;1434:	vec3_t			muzzlePoint, endPoint;
;1435:
;1436:	if ( cent->currentState.weapon != WP_LIGHTNING ) {
;1437:		return;
;1438:	}
;1439:
;1440:	memset( &beam, 0, sizeof( beam ) );
;1441:
;1442:	// find muzzle point for this frame
;1443:	VectorCopy( cent->lerpOrigin, muzzlePoint );
;1444:	AngleVectors( cent->lerpAngles, forward, NULL, NULL );
;1445:
;1446:	// FIXME: crouch
;1447:	muzzlePoint[2] += DEFAULT_VIEWHEIGHT;
;1448:
;1449:	VectorMA( muzzlePoint, 14, forward, muzzlePoint );
;1450:
;1451:	// project forward by the lightning range
;1452:	VectorMA( muzzlePoint, LIGHTNING_RANGE, forward, endPoint );
;1453:
;1454:	// see if it hit a wall
;1455:	CG_Trace( &trace, muzzlePoint, vec3_origin, vec3_origin, endPoint, 
;1456:		cent->currentState.number, MASK_SHOT );
;1457:
;1458:	// this is the endpoint
;1459:	VectorCopy( trace.endpos, beam.oldorigin );
;1460:
;1461:	// use the provided origin, even though it may be slightly
;1462:	// different than the muzzle origin
;1463:	VectorCopy( origin, beam.origin );
;1464:
;1465:	beam.reType = RT_LIGHTNING;
;1466:	beam.customShader = cgs.media.lightningShader;
;1467:	trap_R_AddRefEntityToScene( &beam );
;1468:
;1469:	// add the impact flare if it hit something
;1470:	if ( trace.fraction < 1.0 ) {
;1471:		vec3_t	angles;
;1472:		vec3_t	dir;
;1473:
;1474:		VectorSubtract( beam.oldorigin, beam.origin, dir );
;1475:		VectorNormalize( dir );
;1476:
;1477:		memset( &beam, 0, sizeof( beam ) );
;1478:		beam.hModel = cgs.media.lightningExplosionModel;
;1479:
;1480:		VectorMA( trace.endpos, -16, dir, beam.origin );
;1481:
;1482:		// make a random orientation
;1483:		angles[0] = rand() % 360;
;1484:		angles[1] = rand() % 360;
;1485:		angles[2] = rand() % 360;
;1486:		AnglesToAxis( angles, beam.axis );
;1487:		trap_R_AddRefEntityToScene( &beam );
;1488:	}
;1489:}
;1490:*/
;1491:
;1492:/*
;1493:===============
;1494:CG_SpawnRailTrail
;1495:
;1496:Origin will be the exact tag point, which is slightly
;1497:different than the muzzle point used for determining hits.
;1498:===============
;1499:*/
;1500:static void CG_SpawnRailTrail( centity_t *cent, vec3_t origin ) {
line 1503
;1501:	clientInfo_t	*ci;
;1502:
;1503:	if ( cent->currentState.weapon != WP_RAILGUN ) {
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 7
EQI4 $1142
line 1504
;1504:		return;
ADDRGP4 $1141
JUMPV
LABELV $1142
line 1506
;1505:	}
;1506:	if ( !cent->pe.railgunFlash ) {
ADDRFP4 0
INDIRP4
CNSTI4 620
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1144
line 1507
;1507:		return;
ADDRGP4 $1141
JUMPV
LABELV $1144
line 1509
;1508:	}
;1509:	cent->pe.railgunFlash = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 620
ADDP4
CNSTI4 1
ASGNI4
line 1510
;1510:	ci = &cgs.clientinfo[ cent->currentState.clientNum ];
ADDRLP4 0
CNSTI4 1776
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+40960
ADDP4
ASGNP4
line 1511
;1511:	CG_RailTrail( ci, origin, cent->pe.railgunImpact );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 608
ADDP4
ARGP4
ADDRGP4 CG_RailTrail
CALLV
pop
line 1512
;1512:}
LABELV $1141
endproc CG_SpawnRailTrail 4 12
proc CG_MachinegunSpinAngle 32 4
line 1522
;1513:
;1514:
;1515:/*
;1516:======================
;1517:CG_MachinegunSpinAngle
;1518:======================
;1519:*/
;1520:#define		SPIN_SPEED	0.9
;1521:#define		COAST_TIME	1000
;1522:static float	CG_MachinegunSpinAngle( centity_t *cent ) {
line 1527
;1523:	int		delta;
;1524:	float	angle;
;1525:	float	speed;
;1526:
;1527:	delta = cg.time - cent->pe.barrelTime;
ADDRLP4 0
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 628
ADDP4
INDIRI4
SUBI4
ASGNI4
line 1528
;1528:	if ( cent->pe.barrelSpinning ) {
ADDRFP4 0
INDIRP4
CNSTI4 632
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1149
line 1529
;1529:		angle = cent->pe.barrelAngle + delta * SPIN_SPEED;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 624
ADDP4
INDIRF4
CNSTF4 1063675494
ADDRLP4 0
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 1530
;1530:	} else {
ADDRGP4 $1150
JUMPV
LABELV $1149
line 1531
;1531:		if ( delta > COAST_TIME ) {
ADDRLP4 0
INDIRI4
CNSTI4 1000
LEI4 $1151
line 1532
;1532:			delta = COAST_TIME;
ADDRLP4 0
CNSTI4 1000
ASGNI4
line 1533
;1533:		}
LABELV $1151
line 1535
;1534:
;1535:		speed = 0.5 * ( SPIN_SPEED + (float)( COAST_TIME - delta ) / COAST_TIME );
ADDRLP4 8
CNSTF4 1056964608
CNSTI4 1000
ADDRLP4 0
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1148846080
DIVF4
CNSTF4 1063675494
ADDF4
MULF4
ASGNF4
line 1536
;1536:		angle = cent->pe.barrelAngle + delta * speed;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 624
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CVIF4 4
ADDRLP4 8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1537
;1537:	}
LABELV $1150
line 1539
;1538:
;1539:	if ( cent->pe.barrelSpinning == !(cent->currentState.eFlags & EF_FIRING) ) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
NEI4 $1156
ADDRLP4 12
CNSTI4 1
ASGNI4
ADDRGP4 $1157
JUMPV
LABELV $1156
ADDRLP4 12
CNSTI4 0
ASGNI4
LABELV $1157
ADDRLP4 16
INDIRP4
CNSTI4 632
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $1153
line 1540
;1540:		cent->pe.barrelTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 628
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1541
;1541:		cent->pe.barrelAngle = AngleMod( angle );
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 624
ADDP4
ADDRLP4 20
INDIRF4
ASGNF4
line 1542
;1542:		cent->pe.barrelSpinning = !!(cent->currentState.eFlags & EF_FIRING);
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $1160
ADDRLP4 24
CNSTI4 1
ASGNI4
ADDRGP4 $1161
JUMPV
LABELV $1160
ADDRLP4 24
CNSTI4 0
ASGNI4
LABELV $1161
ADDRLP4 28
INDIRP4
CNSTI4 632
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 1548
;1543:#ifdef MISSIONPACK
;1544:		if ( cent->currentState.weapon == WP_CHAINGUN && !cent->pe.barrelSpinning ) {
;1545:			trap_S_StartSound( NULL, cent->currentState.number, CHAN_WEAPON, trap_S_RegisterSound( "sound/weapons/vulcan/wvulwind.wav", qfalse ) );
;1546:		}
;1547:#endif
;1548:	}
LABELV $1153
line 1550
;1549:
;1550:	return angle;
ADDRLP4 4
INDIRF4
RETF4
LABELV $1147
endproc CG_MachinegunSpinAngle 32 4
proc CG_AddWeaponWithPowerups 0 4
line 1559
;1551:}
;1552:
;1553:
;1554:/*
;1555:========================
;1556:CG_AddWeaponWithPowerups
;1557:========================
;1558:*/
;1559:static void CG_AddWeaponWithPowerups( refEntity_t *gun, int powerups ) {
line 1561
;1560:	// add powerup effects
;1561:	if ( powerups & ( 1 << PW_INVIS ) ) {
ADDRFP4 4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1163
line 1562
;1562:		gun->customShader = cgs.media.invisShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+156680+468
INDIRI4
ASGNI4
line 1563
;1563:		trap_R_AddRefEntityToScene( gun );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1564
;1564:	} else {
ADDRGP4 $1164
JUMPV
LABELV $1163
line 1565
;1565:		trap_R_AddRefEntityToScene( gun );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1567
;1566:
;1567:		if ( powerups & ( 1 << PW_BATTLESUIT ) ) {
ADDRFP4 4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1167
line 1568
;1568:			gun->customShader = cgs.media.battleWeaponShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+156680+480
INDIRI4
ASGNI4
line 1569
;1569:			trap_R_AddRefEntityToScene( gun );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1570
;1570:		}
LABELV $1167
line 1571
;1571:		if ( powerups & ( 1 << PW_QUAD ) ) {
ADDRFP4 4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1171
line 1572
;1572:			gun->customShader = cgs.media.quadWeaponShader;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cgs+156680+464
INDIRI4
ASGNI4
line 1573
;1573:			trap_R_AddRefEntityToScene( gun );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1574
;1574:		}
LABELV $1171
line 1575
;1575:	}
LABELV $1164
line 1576
;1576:}
LABELV $1162
endproc CG_AddWeaponWithPowerups 0 4
export CG_AddPlayerWeapon
proc CG_AddPlayerWeapon 496 20
line 1588
;1577:
;1578:
;1579:/*
;1580:=============
;1581:CG_AddPlayerWeapon
;1582:
;1583:Used for both the view weapon (ps is valid) and the world modelother character models (ps is NULL)
;1584:The main player will have this called for BOTH cases, so effects like light and
;1585:sound should only be done on the world model case.
;1586:=============
;1587:*/
;1588:void CG_AddPlayerWeapon( refEntity_t *parent, playerState_t *ps, centity_t *cent, int team ) {
line 1598
;1589:	refEntity_t	gun;
;1590:	refEntity_t	barrel;
;1591:	refEntity_t	flash;
;1592:	vec3_t		angles;
;1593:	weapon_t	weaponNum;
;1594:	weaponInfo_t	*weapon;
;1595:	centity_t	*nonPredictedCent;
;1596://	int	col;
;1597:
;1598:	weaponNum = cent->currentState.weapon;
ADDRLP4 284
ADDRFP4 8
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
line 1600
;1599:
;1600:	CG_RegisterWeapon( weaponNum );
ADDRLP4 284
INDIRI4
ARGI4
ADDRGP4 CG_RegisterWeapon
CALLV
pop
line 1601
;1601:	weapon = &cg_weapons[weaponNum];
ADDRLP4 280
CNSTI4 136
ADDRLP4 284
INDIRI4
MULI4
ADDRGP4 cg_weapons
ADDP4
ASGNP4
line 1604
;1602:
;1603:	// add the weapon
;1604:	memset( &gun, 0, sizeof( gun ) );
ADDRLP4 140
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1605
;1605:	VectorCopy( parent->lightingOrigin, gun.lightingOrigin );
ADDRLP4 140+12
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRB
ASGNB 12
line 1606
;1606:	gun.shadowPlane = parent->shadowPlane;
ADDRLP4 140+24
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1607
;1607:	gun.renderfx = parent->renderfx;
ADDRLP4 140+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1610
;1608:
;1609:	// set custom shading for railgun refire rate
;1610:	if ( ps ) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1179
line 1611
;1611:		if ( cg.predictedPlayerState.weapon == WP_RAILGUN 
ADDRGP4 cg+107636+144
INDIRI4
CNSTI4 7
NEI4 $1181
ADDRGP4 cg+107636+148
INDIRI4
CNSTI4 3
NEI4 $1181
line 1612
;1612:			&& cg.predictedPlayerState.weaponstate == WEAPON_FIRING ) {
line 1628
;1613:			float	f;
;1614:
;1615:			//Zero: railgun "square" color
;1616:/* original
;1617:			f = (float)cg.predictedPlayerState.weaponTime / 1500;
;1618:			gun.shaderRGBA[1] = 0;
;1619:			gun.shaderRGBA[0] = 
;1620:			gun.shaderRGBA[2] = 255 * ( 1.0 - f );
;1621:		} else {
;1622:			gun.shaderRGBA[0] = 255;
;1623:			gun.shaderRGBA[1] = 255;
;1624:			gun.shaderRGBA[2] = 255;
;1625:			gun.shaderRGBA[3] = 255;
;1626:*/
;1627:			//color1 and color2 for actual railgun colors
;1628:			f = (float)cg.predictedPlayerState.weaponTime / 1500;
ADDRLP4 444
ADDRGP4 cg+107636+44
INDIRI4
CVIF4 4
CNSTF4 1153138688
DIVF4
ASGNF4
line 1629
;1629:			memcpy(gun.shaderRGBA, &cgs.clientinfo[cent->currentState.clientNum].colors[4], sizeof(gun.shaderRGBA));
ADDRLP4 140+116
ARGP4
CNSTI4 1776
ADDRFP4 8
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+40960+92+16
ADDP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1630
;1630:		} else { 
ADDRGP4 $1182
JUMPV
LABELV $1181
line 1631
;1631:			memcpy(gun.shaderRGBA, &cgs.clientinfo[cent->currentState.clientNum].colors[0], sizeof(gun.shaderRGBA));
ADDRLP4 140+116
ARGP4
CNSTI4 1776
ADDRFP4 8
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+40960+92
ADDP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1632
;1632:		}
LABELV $1182
line 1633
;1633:	}
LABELV $1179
line 1635
;1634:
;1635:	gun.hModel = weapon->weaponModel;
ADDRLP4 140+8
ADDRLP4 280
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1636
;1636:	if (!gun.hModel) {
ADDRLP4 140+8
INDIRI4
CNSTI4 0
NEI4 $1199
line 1637
;1637:		return;
ADDRGP4 $1175
JUMPV
LABELV $1199
line 1640
;1638:	}
;1639:
;1640:	if ( !ps ) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1202
line 1642
;1641:		// add weapon ready sound
;1642:		cent->pe.lightningFiring = qfalse;
ADDRFP4 8
INDIRP4
CNSTI4 604
ADDP4
CNSTI4 0
ASGNI4
line 1643
;1643:		if ( ( cent->currentState.eFlags & EF_FIRING ) && weapon->firingSound ) {
ADDRLP4 444
CNSTI4 0
ASGNI4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 256
BANDI4
ADDRLP4 444
INDIRI4
EQI4 $1204
ADDRLP4 280
INDIRP4
CNSTI4 128
ADDP4
INDIRI4
ADDRLP4 444
INDIRI4
EQI4 $1204
line 1645
;1644:			// lightning gun and guantlet make a different sound when fire is held down
;1645:			trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin, weapon->firingSound );
ADDRLP4 448
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 448
INDIRP4
INDIRI4
ARGI4
ADDRLP4 448
INDIRP4
CNSTI4 704
ADDP4
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRLP4 280
INDIRP4
CNSTI4 128
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_AddLoopingSound
CALLV
pop
line 1646
;1646:			cent->pe.lightningFiring = qtrue;
ADDRFP4 8
INDIRP4
CNSTI4 604
ADDP4
CNSTI4 1
ASGNI4
line 1647
;1647:		} else if ( (weapon->readySound && (weapon->item->giType != IT_WEAPON && weapon->item->giTag != WP_RAILGUN) ) ||
ADDRGP4 $1205
JUMPV
LABELV $1204
ADDRLP4 280
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1216
ADDRLP4 452
ADDRLP4 280
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ASGNP4
ADDRLP4 452
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 1
EQI4 $1216
ADDRLP4 452
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 7
NEI4 $1217
LABELV $1216
ADDRLP4 460
CNSTI4 0
ASGNI4
ADDRLP4 280
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
ADDRLP4 460
INDIRI4
EQI4 $1206
ADDRLP4 464
ADDRLP4 280
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ASGNP4
ADDRLP4 464
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1206
ADDRLP4 464
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 7
NEI4 $1206
ADDRGP4 cg_railHum+12
INDIRI4
ADDRLP4 460
INDIRI4
NEI4 $1218
ADDRFP4 8
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ADDRGP4 cg+4
INDIRI4
NEI4 $1217
ADDRGP4 cg+107636+140
INDIRI4
ADDRGP4 cg+4
INDIRI4
NEI4 $1217
LABELV $1218
ADDRGP4 cg_railHum+12
INDIRI4
CNSTI4 1
NEI4 $1206
LABELV $1217
line 1649
;1648:			( weapon->readySound && (weapon->item->giType == IT_WEAPON && weapon->item->giTag == WP_RAILGUN) && 
;1649:			( (cg_railHum.integer == 0 && (cent->currentState.clientNum != cg.clientNum || cg.predictedPlayerState.clientNum != cg.clientNum)) || (cg_railHum.integer == 1) ) ) ) {
line 1650
;1650:			trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin, weapon->readySound );
ADDRLP4 468
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 468
INDIRP4
INDIRI4
ARGI4
ADDRLP4 468
INDIRP4
CNSTI4 704
ADDP4
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRLP4 280
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_AddLoopingSound
CALLV
pop
line 1651
;1651:		}
LABELV $1206
LABELV $1205
line 1652
;1652:	}
LABELV $1202
line 1654
;1653:
;1654:	CG_PositionEntityOnTag( &gun, parent, parent->hModel, "tag_weapon");
ADDRLP4 140
ARGP4
ADDRLP4 444
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 444
INDIRP4
ARGP4
ADDRLP4 444
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 $1219
ARGP4
ADDRGP4 CG_PositionEntityOnTag
CALLV
pop
line 1656
;1655:
;1656:	CG_AddWeaponWithPowerups( &gun, cent->currentState.powerups );
ADDRLP4 140
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_AddWeaponWithPowerups
CALLV
pop
line 1659
;1657:
;1658:	// add the spinning barrel
;1659:	if ( weapon->barrelModel ) {
ADDRLP4 280
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1220
line 1660
;1660:		memset( &barrel, 0, sizeof( barrel ) );
ADDRLP4 300
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1661
;1661:		VectorCopy( parent->lightingOrigin, barrel.lightingOrigin );
ADDRLP4 300+12
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRB
ASGNB 12
line 1662
;1662:		barrel.shadowPlane = parent->shadowPlane;
ADDRLP4 300+24
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1663
;1663:		barrel.renderfx = parent->renderfx;
ADDRLP4 300+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1665
;1664:
;1665:		barrel.hModel = weapon->barrelModel;
ADDRLP4 300+8
ADDRLP4 280
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 1666
;1666:		angles[YAW] = 0;
ADDRLP4 288+4
CNSTF4 0
ASGNF4
line 1667
;1667:		angles[PITCH] = 0;
ADDRLP4 288
CNSTF4 0
ASGNF4
line 1668
;1668:		angles[ROLL] = CG_MachinegunSpinAngle( cent );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 448
ADDRGP4 CG_MachinegunSpinAngle
CALLF4
ASGNF4
ADDRLP4 288+8
ADDRLP4 448
INDIRF4
ASGNF4
line 1669
;1669:		AnglesToAxis( angles, barrel.axis );
ADDRLP4 288
ARGP4
ADDRLP4 300+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1671
;1670:
;1671:		CG_PositionRotatedEntityOnTag( &barrel, &gun, weapon->weaponModel, "tag_barrel" );
ADDRLP4 300
ARGP4
ADDRLP4 140
ARGP4
ADDRLP4 280
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRGP4 $1229
ARGP4
ADDRGP4 CG_PositionRotatedEntityOnTag
CALLV
pop
line 1673
;1672:
;1673:		CG_AddWeaponWithPowerups( &barrel, cent->currentState.powerups );
ADDRLP4 300
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_AddWeaponWithPowerups
CALLV
pop
line 1674
;1674:	}
LABELV $1220
line 1677
;1675:
;1676:	// make sure we aren't looking at cg.predictedPlayerEntity for LG
;1677:	nonPredictedCent = &cg_entities[cent->currentState.clientNum];
ADDRLP4 440
CNSTI4 728
ADDRFP4 8
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 1682
;1678:
;1679:	// if the index of the nonPredictedCent is not the same as the clientNum
;1680:	// then this is a fake player (like on teh single player podiums), so
;1681:	// go ahead and use the cent
;1682:	if( ( nonPredictedCent - cg_entities ) != cent->currentState.clientNum ) {
ADDRLP4 440
INDIRP4
CVPU4 4
ADDRGP4 cg_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 728
DIVI4
ADDRFP4 8
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
EQI4 $1230
line 1683
;1683:		nonPredictedCent = cent;
ADDRLP4 440
ADDRFP4 8
INDIRP4
ASGNP4
line 1684
;1684:	}
LABELV $1230
line 1687
;1685:
;1686:	// add the flash
;1687:	if ( ( weaponNum == WP_LIGHTNING || weaponNum == WP_GAUNTLET || weaponNum == WP_GRAPPLING_HOOK )
ADDRLP4 284
INDIRI4
CNSTI4 6
EQI4 $1235
ADDRLP4 284
INDIRI4
CNSTI4 1
EQI4 $1235
ADDRLP4 284
INDIRI4
CNSTI4 10
NEI4 $1232
LABELV $1235
ADDRLP4 440
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $1232
line 1688
;1688:		&& ( nonPredictedCent->currentState.eFlags & EF_FIRING ) ) {
line 1690
;1689:		// continuous flash
;1690:	} else {
ADDRGP4 $1233
JUMPV
LABELV $1232
line 1692
;1691:		// impulse flash
;1692:		if ( cg.time - cent->muzzleFlashTime > MUZZLE_FLASH_TIME && !cent->pe.railgunFlash ) {
ADDRLP4 452
ADDRFP4 8
INDIRP4
ASGNP4
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 452
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
SUBI4
CNSTI4 20
LEI4 $1236
ADDRLP4 452
INDIRP4
CNSTI4 620
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1236
line 1693
;1693:			return;
ADDRGP4 $1175
JUMPV
LABELV $1236
line 1695
;1694:		}
;1695:	}
LABELV $1233
line 1697
;1696:
;1697:	memset( &flash, 0, sizeof( flash ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1698
;1698:	VectorCopy( parent->lightingOrigin, flash.lightingOrigin );
ADDRLP4 0+12
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRB
ASGNB 12
line 1699
;1699:	flash.shadowPlane = parent->shadowPlane;
ADDRLP4 0+24
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1700
;1700:	flash.renderfx = parent->renderfx;
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1702
;1701:
;1702:	flash.hModel = weapon->flashModel;
ADDRLP4 0+8
ADDRLP4 280
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ASGNI4
line 1703
;1703:	if (!flash.hModel) {
ADDRLP4 0+8
INDIRI4
CNSTI4 0
NEI4 $1243
line 1704
;1704:		return;
ADDRGP4 $1175
JUMPV
LABELV $1243
line 1706
;1705:	}
;1706:	angles[YAW] = 0;
ADDRLP4 288+4
CNSTF4 0
ASGNF4
line 1707
;1707:	angles[PITCH] = 0;
ADDRLP4 288
CNSTF4 0
ASGNF4
line 1708
;1708:	angles[ROLL] = crandom() * 10;
ADDRLP4 452
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 288+8
CNSTF4 1092616192
CNSTF4 1073741824
ADDRLP4 452
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
ASGNF4
line 1709
;1709:	AnglesToAxis( angles, flash.axis );
ADDRLP4 288
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1712
;1710:
;1711:	// colorize the railgun blast
;1712:	if ( weaponNum == WP_RAILGUN ) {
ADDRLP4 284
INDIRI4
CNSTI4 7
NEI4 $1249
line 1715
;1713:		clientInfo_t	*ci;
;1714:
;1715:		ci = &cgs.clientinfo[ cent->currentState.clientNum ];
ADDRLP4 456
CNSTI4 1776
ADDRFP4 8
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+40960
ADDP4
ASGNP4
line 1716
;1716:		flash.shaderRGBA[0] = 255 * ci->color1[0];
ADDRLP4 464
CNSTF4 1132396544
ADDRLP4 456
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 468
CNSTF4 1325400064
ASGNF4
ADDRLP4 464
INDIRF4
ADDRLP4 468
INDIRF4
LTF4 $1254
ADDRLP4 460
ADDRLP4 464
INDIRF4
ADDRLP4 468
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1255
JUMPV
LABELV $1254
ADDRLP4 460
ADDRLP4 464
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1255
ADDRLP4 0+116
ADDRLP4 460
INDIRU4
CVUU1 4
ASGNU1
line 1717
;1717:		flash.shaderRGBA[1] = 255 * ci->color1[1];
ADDRLP4 476
CNSTF4 1132396544
ADDRLP4 456
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 480
CNSTF4 1325400064
ASGNF4
ADDRLP4 476
INDIRF4
ADDRLP4 480
INDIRF4
LTF4 $1259
ADDRLP4 472
ADDRLP4 476
INDIRF4
ADDRLP4 480
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1260
JUMPV
LABELV $1259
ADDRLP4 472
ADDRLP4 476
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1260
ADDRLP4 0+116+1
ADDRLP4 472
INDIRU4
CVUU1 4
ASGNU1
line 1718
;1718:		flash.shaderRGBA[2] = 255 * ci->color1[2];
ADDRLP4 488
CNSTF4 1132396544
ADDRLP4 456
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 492
CNSTF4 1325400064
ASGNF4
ADDRLP4 488
INDIRF4
ADDRLP4 492
INDIRF4
LTF4 $1264
ADDRLP4 484
ADDRLP4 488
INDIRF4
ADDRLP4 492
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $1265
JUMPV
LABELV $1264
ADDRLP4 484
ADDRLP4 488
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $1265
ADDRLP4 0+116+2
ADDRLP4 484
INDIRU4
CVUU1 4
ASGNU1
line 1719
;1719:	}
LABELV $1249
line 1721
;1720:
;1721:	CG_PositionRotatedEntityOnTag( &flash, &gun, weapon->weaponModel, "tag_flash");
ADDRLP4 0
ARGP4
ADDRLP4 140
ARGP4
ADDRLP4 280
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRGP4 $1266
ARGP4
ADDRGP4 CG_PositionRotatedEntityOnTag
CALLV
pop
line 1722
;1722:	trap_R_AddRefEntityToScene( &flash );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 1724
;1723:
;1724:	if ( ps || cg.renderingThirdPerson ||
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1273
ADDRGP4 cg+107628
INDIRI4
CNSTI4 0
NEI4 $1273
ADDRFP4 8
INDIRP4
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
EQI4 $1267
LABELV $1273
line 1725
;1725:		cent->currentState.number != cg.predictedPlayerState.clientNum ) {
line 1727
;1726:		// add lightning bolt
;1727:		CG_LightningBolt( nonPredictedCent, flash.origin );
ADDRLP4 440
INDIRP4
ARGP4
ADDRLP4 0+68
ARGP4
ADDRGP4 CG_LightningBolt
CALLV
pop
line 1730
;1728:
;1729:		// add rail trail
;1730:		CG_SpawnRailTrail( cent, flash.origin );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0+68
ARGP4
ADDRGP4 CG_SpawnRailTrail
CALLV
pop
line 1732
;1731:
;1732:		if ( weapon->flashDlightColor[0] || weapon->flashDlightColor[1] || weapon->flashDlightColor[2] ) {
ADDRLP4 460
CNSTF4 0
ASGNF4
ADDRLP4 280
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 460
INDIRF4
NEF4 $1279
ADDRLP4 280
INDIRP4
CNSTI4 44
ADDP4
INDIRF4
ADDRLP4 460
INDIRF4
NEF4 $1279
ADDRLP4 280
INDIRP4
CNSTI4 48
ADDP4
INDIRF4
ADDRLP4 460
INDIRF4
EQF4 $1276
LABELV $1279
line 1733
;1733:			trap_R_AddLightToScene( flash.origin, 300 + (rand()&31), weapon->flashDlightColor[0],
ADDRLP4 464
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+68
ARGP4
ADDRLP4 464
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 300
ADDI4
CVIF4 4
ARGF4
ADDRLP4 280
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ARGF4
ADDRLP4 280
INDIRP4
CNSTI4 44
ADDP4
INDIRF4
ARGF4
ADDRLP4 280
INDIRP4
CNSTI4 48
ADDP4
INDIRF4
ARGF4
ADDRGP4 trap_R_AddLightToScene
CALLV
pop
line 1735
;1734:				weapon->flashDlightColor[1], weapon->flashDlightColor[2] );
;1735:		}
LABELV $1276
line 1736
;1736:	}
LABELV $1267
line 1737
;1737:}
LABELV $1175
endproc CG_AddPlayerWeapon 496 20
export CG_AddViewWeapon
proc CG_AddViewWeapon 188 16
line 1746
;1738:
;1739:/*
;1740:==============
;1741:CG_AddViewWeapon
;1742:
;1743:Add the weapon, and flash for the player's view
;1744:==============
;1745:*/
;1746:void CG_AddViewWeapon( playerState_t *ps ) {
line 1755
;1747:	refEntity_t	hand;
;1748:	centity_t	*cent;
;1749:	clientInfo_t	*ci;
;1750:	float		fovOffset;
;1751:	float	lengthscale;
;1752:	vec3_t		angles;
;1753:	weaponInfo_t	*weapon;
;1754:
;1755:	if ( ps->persistant[PERS_TEAM] == TEAM_SPECTATOR ) {
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1282
line 1756
;1756:		return;
ADDRGP4 $1281
JUMPV
LABELV $1282
line 1759
;1757:	}
;1758:
;1759:	if ( ps->pm_type == PM_INTERMISSION ) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 5
NEI4 $1284
line 1760
;1760:		return;
ADDRGP4 $1281
JUMPV
LABELV $1284
line 1765
;1761:	}
;1762:
;1763:	// no gun if in third person view or a camera is active
;1764:	//if ( cg.renderingThirdPerson || cg.cameraMode) {
;1765:	if ( cg.renderingThirdPerson ) {
ADDRGP4 cg+107628
INDIRI4
CNSTI4 0
EQI4 $1286
line 1766
;1766:		return;
ADDRGP4 $1281
JUMPV
LABELV $1286
line 1771
;1767:	}
;1768:
;1769:
;1770:	// allow the gun to be completely removed
;1771:	if ( cg_drawGun.integer == 0 ) {
ADDRGP4 cg_drawGun+12
INDIRI4
CNSTI4 0
NEI4 $1289
line 1774
;1772:		vec3_t		origin;
;1773:
;1774:		if ( cg.predictedPlayerState.eFlags & EF_FIRING ) {
ADDRGP4 cg+107636+104
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $1281
line 1776
;1775:			// special hack for lightning gun...
;1776:			VectorCopy( cg.refdef.vieworg, origin );
ADDRLP4 172
ADDRGP4 cg+109048+24
INDIRB
ASGNB 12
line 1777
;1777:			VectorMA( origin, -8, cg.refdef.viewaxis[2], origin );
ADDRLP4 184
CNSTF4 3238002688
ASGNF4
ADDRLP4 172
ADDRLP4 172
INDIRF4
ADDRLP4 184
INDIRF4
ADDRGP4 cg+109048+36+24
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 172+4
ADDRLP4 172+4
INDIRF4
ADDRLP4 184
INDIRF4
ADDRGP4 cg+109048+36+24+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 172+8
ADDRLP4 172+8
INDIRF4
CNSTF4 3238002688
ADDRGP4 cg+109048+36+24+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1778
;1778:			CG_LightningBolt( &cg_entities[ps->clientNum], origin );
CNSTI4 728
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ARGP4
ADDRLP4 172
ARGP4
ADDRGP4 CG_LightningBolt
CALLV
pop
line 1779
;1779:		}
line 1780
;1780:		return;
ADDRGP4 $1281
JUMPV
LABELV $1289
line 1784
;1781:	}
;1782:
;1783:	// don't draw if testing a gun model
;1784:	if ( cg.testGun ) {
ADDRGP4 cg+131140
INDIRI4
CNSTI4 0
EQI4 $1313
line 1785
;1785:		return;
ADDRGP4 $1281
JUMPV
LABELV $1313
line 1789
;1786:	}
;1787:
;1788:	// drop gun lower at higher fov
;1789:	if ( cg_fov.integer > 90 && cg_drawGun.integer == 1 ) {
ADDRGP4 cg_fov+12
INDIRI4
CNSTI4 90
LEI4 $1316
ADDRGP4 cg_drawGun+12
INDIRI4
CNSTI4 1
NEI4 $1316
line 1790
;1790:		fovOffset = -0.2 * ( cg_fov.integer - 90 );
ADDRLP4 140
CNSTF4 3192704205
ADDRGP4 cg_fov+12
INDIRI4
CNSTI4 90
SUBI4
CVIF4 4
MULF4
ASGNF4
line 1791
;1791:	} else {
ADDRGP4 $1317
JUMPV
LABELV $1316
line 1792
;1792:		fovOffset = 0;
ADDRLP4 140
CNSTF4 0
ASGNF4
line 1793
;1793:	}
LABELV $1317
line 1795
;1794:
;1795:	cent = &cg.predictedPlayerEntity;	// &cg_entities[cg.snap->ps.clientNum];
ADDRLP4 148
ADDRGP4 cg+108104
ASGNP4
line 1796
;1796:	CG_RegisterWeapon( ps->weapon );
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_RegisterWeapon
CALLV
pop
line 1797
;1797:	weapon = &cg_weapons[ ps->weapon ];
ADDRLP4 164
CNSTI4 136
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons
ADDP4
ASGNP4
line 1799
;1798:
;1799:	memset (&hand, 0, sizeof(hand));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1802
;1800:
;1801:	// set up gun position
;1802:	CG_CalculateWeaponPosition( hand.origin, angles );
ADDRLP4 0+68
ARGP4
ADDRLP4 152
ARGP4
ADDRGP4 CG_CalculateWeaponPosition
CALLV
pop
line 1804
;1803:
;1804:	VectorMA( hand.origin, cg_gun_x.value, cg.refdef.viewaxis[0], hand.origin );
ADDRLP4 0+68
ADDRLP4 0+68
INDIRF4
ADDRGP4 cg+109048+36
INDIRF4
ADDRGP4 cg_gun_x+8
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+4
ADDRLP4 0+68+4
INDIRF4
ADDRGP4 cg+109048+36+4
INDIRF4
ADDRGP4 cg_gun_x+8
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
ADDRGP4 cg+109048+36+8
INDIRF4
ADDRGP4 cg_gun_x+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1805
;1805:	VectorMA( hand.origin, cg_gun_y.value, cg.refdef.viewaxis[1], hand.origin );
ADDRLP4 0+68
ADDRLP4 0+68
INDIRF4
ADDRGP4 cg+109048+36+12
INDIRF4
ADDRGP4 cg_gun_y+8
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+4
ADDRLP4 0+68+4
INDIRF4
ADDRGP4 cg+109048+36+12+4
INDIRF4
ADDRGP4 cg_gun_y+8
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
ADDRGP4 cg+109048+36+12+8
INDIRF4
ADDRGP4 cg_gun_y+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1806
;1806:	VectorMA( hand.origin, (cg_gun_z.value+fovOffset), cg.refdef.viewaxis[2], hand.origin );
ADDRLP4 0+68
ADDRLP4 0+68
INDIRF4
ADDRGP4 cg+109048+36+24
INDIRF4
ADDRGP4 cg_gun_z+8
INDIRF4
ADDRLP4 140
INDIRF4
ADDF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+4
ADDRLP4 0+68+4
INDIRF4
ADDRGP4 cg+109048+36+24+4
INDIRF4
ADDRGP4 cg_gun_z+8
INDIRF4
ADDRLP4 140
INDIRF4
ADDF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
ADDRGP4 cg+109048+36+24+8
INDIRF4
ADDRGP4 cg_gun_z+8
INDIRF4
ADDRLP4 140
INDIRF4
ADDF4
MULF4
ADDF4
ASGNF4
line 1808
;1807:
;1808:	AnglesToAxis( angles, hand.axis );
ADDRLP4 152
ARGP4
ADDRLP4 0+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 1811
;1809:
;1810:	// map torso animations to weapon animations
;1811:	if ( cg_gun_frame.integer ) {
ADDRGP4 cg_gun_frame+12
INDIRI4
CNSTI4 0
EQI4 $1393
line 1813
;1812:		// development tool
;1813:		hand.frame = hand.oldframe = cg_gun_frame.integer;
ADDRLP4 172
ADDRGP4 cg_gun_frame+12
INDIRI4
ASGNI4
ADDRLP4 0+96
ADDRLP4 172
INDIRI4
ASGNI4
ADDRLP4 0+80
ADDRLP4 172
INDIRI4
ASGNI4
line 1814
;1814:		hand.backlerp = 0;
ADDRLP4 0+100
CNSTF4 0
ASGNF4
line 1815
;1815:	} else {
ADDRGP4 $1394
JUMPV
LABELV $1393
line 1817
;1816:		// get clientinfo for animation map
;1817:		ci = &cgs.clientinfo[ cent->currentState.clientNum ];
ADDRLP4 168
CNSTI4 1776
ADDRLP4 148
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+40960
ADDP4
ASGNP4
line 1818
;1818:		hand.frame = CG_MapTorsoToWeaponFrame( ci, cent->pe.torso.frame );
ADDRLP4 168
INDIRP4
ARGP4
ADDRLP4 148
INDIRP4
CNSTI4 508
ADDP4
INDIRI4
ARGI4
ADDRLP4 172
ADDRGP4 CG_MapTorsoToWeaponFrame
CALLI4
ASGNI4
ADDRLP4 0+80
ADDRLP4 172
INDIRI4
ASGNI4
line 1819
;1819:		hand.oldframe = CG_MapTorsoToWeaponFrame( ci, cent->pe.torso.oldFrame );
ADDRLP4 168
INDIRP4
ARGP4
ADDRLP4 148
INDIRP4
CNSTI4 500
ADDP4
INDIRI4
ARGI4
ADDRLP4 176
ADDRGP4 CG_MapTorsoToWeaponFrame
CALLI4
ASGNI4
ADDRLP4 0+96
ADDRLP4 176
INDIRI4
ASGNI4
line 1820
;1820:		hand.backlerp = cent->pe.torso.backlerp;
ADDRLP4 0+100
ADDRLP4 148
INDIRP4
CNSTI4 516
ADDP4
INDIRF4
ASGNF4
line 1821
;1821:	}
LABELV $1394
line 1823
;1822:
;1823:	hand.hModel = weapon->handsModel;
ADDRLP4 0+8
ADDRLP4 164
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1825
;1824:
;1825:	if ( cg_drawGun.integer >= 50 && cg_drawGun.integer <= 160 ) {
ADDRGP4 cg_drawGun+12
INDIRI4
CNSTI4 50
LTI4 $1405
ADDRGP4 cg_drawGun+12
INDIRI4
CNSTI4 160
GTI4 $1405
line 1826
;1826:		lengthscale = 1.0f * tan( DEG2RAD(cg_drawGun.integer/2) );
CNSTF4 1078530011
ADDRGP4 cg_drawGun+12
INDIRI4
CNSTI4 2
DIVI4
CVIF4 4
MULF4
CNSTF4 1127481344
DIVF4
ARGF4
ADDRLP4 172
ADDRGP4 tan
CALLF4
ASGNF4
ADDRLP4 144
CNSTF4 1065353216
ADDRLP4 172
INDIRF4
MULF4
ASGNF4
line 1827
;1827:	} else if ( cg_drawGun.integer == -1 ) {
ADDRGP4 $1406
JUMPV
LABELV $1405
ADDRGP4 cg_drawGun+12
INDIRI4
CNSTI4 -1
NEI4 $1410
line 1828
;1828:		lengthscale = 1.0f / tan( DEG2RAD(cg_fov.integer/2) );
CNSTF4 1078530011
ADDRGP4 cg_fov+12
INDIRI4
CNSTI4 2
DIVI4
CVIF4 4
MULF4
CNSTF4 1127481344
DIVF4
ARGF4
ADDRLP4 172
ADDRGP4 tan
CALLF4
ASGNF4
ADDRLP4 144
CNSTF4 1065353216
ADDRLP4 172
INDIRF4
DIVF4
ASGNF4
line 1829
;1829:	} else {
ADDRGP4 $1411
JUMPV
LABELV $1410
line 1830
;1830:		lengthscale = 1.0f;
ADDRLP4 144
CNSTF4 1065353216
ASGNF4
line 1831
;1831:	}
LABELV $1411
LABELV $1406
line 1832
;1832:	VectorScale(hand.axis[0], lengthscale, hand.axis[0]);
ADDRLP4 0+28
ADDRLP4 0+28
INDIRF4
ADDRLP4 144
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+4
ADDRLP4 0+28+4
INDIRF4
ADDRLP4 144
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+28+8
ADDRLP4 0+28+8
INDIRF4
ADDRLP4 144
INDIRF4
MULF4
ASGNF4
line 1835
;1833:	
;1834:
;1835:	hand.renderfx = RF_DEPTHHACK | RF_FIRST_PERSON | RF_MINLIGHT;
ADDRLP4 0+4
CNSTI4 13
ASGNI4
line 1838
;1836:
;1837:	// add everything onto the hand
;1838:	CG_AddPlayerWeapon( &hand, ps, &cg.predictedPlayerEntity, ps->persistant[PERS_TEAM] );
ADDRLP4 0
ARGP4
ADDRLP4 172
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 172
INDIRP4
ARGP4
ADDRGP4 cg+108104
ARGP4
ADDRLP4 172
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_AddPlayerWeapon
CALLV
pop
line 1839
;1839:}
LABELV $1281
endproc CG_AddViewWeapon 188 16
export CG_DrawWeaponSelect
proc CG_DrawWeaponSelect 48 20
line 1854
;1840:
;1841:/*
;1842:==============================================================================
;1843:
;1844:WEAPON SELECTION
;1845:
;1846:==============================================================================
;1847:*/
;1848:
;1849:/*
;1850:===================
;1851:CG_DrawWeaponSelect
;1852:===================
;1853:*/
;1854:void CG_DrawWeaponSelect( void ) {
line 1868
;1855:	int		i;
;1856:	int		bits;
;1857:	int		count;
;1858:	int		x, y, w;
;1859:	char	*name;
;1860:	float	*color;
;1861:
;1862:	// don't display if dead
;1863:	/* Was already checked.
;1864:	if ( cg.predictedPlayerState.stats[STAT_HEALTH] <= 0 ) {
;1865:		return;
;1866:	}*/
;1867:
;1868:	color = CG_FadeColor( cg.weaponSelectTime, WEAPON_SELECT_TIME );
ADDRGP4 cg+130828
INDIRI4
ARGI4
CNSTI4 1400
ARGI4
ADDRLP4 32
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 32
INDIRP4
ASGNP4
line 1869
;1869:	if ( !color ) {
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1428
line 1870
;1870:		return;
ADDRGP4 $1426
JUMPV
LABELV $1428
line 1872
;1871:	}
;1872:	trap_R_SetColor( color );
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1875
;1873:
;1874:	// showing weapon select clears pickup item display, but not the blend blob
;1875:	cg.itemPickupTime = 0;
ADDRGP4 cg+130816
CNSTI4 0
ASGNI4
line 1878
;1876:
;1877:	// count the number of weapons owned
;1878:	bits = cg.snap->ps.stats[ STAT_WEAPONS ];
ADDRLP4 12
ADDRGP4 cg+36
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
ASGNI4
line 1879
;1879:	count = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 1880
;1880:	for ( i = 1 ; i < 16 ; i++ ) {
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $1432
line 1881
;1881:		if ( bits & ( 1 << i ) ) {
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $1436
line 1882
;1882:			count++;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1883
;1883:		}
LABELV $1436
line 1884
;1884:	}
LABELV $1433
line 1880
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $1432
line 1886
;1885:
;1886:	x = 320 - count * 20;
ADDRLP4 4
CNSTI4 320
CNSTI4 20
ADDRLP4 16
INDIRI4
MULI4
SUBI4
ASGNI4
line 1887
;1887:	y = 380;
ADDRLP4 8
CNSTI4 380
ASGNI4
line 1889
;1888:
;1889:	for ( i = 1 ; i < 16 ; i++ ) {
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $1438
line 1890
;1890:		if ( !( bits & ( 1 << i ) ) ) {
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
NEI4 $1442
line 1891
;1891:			continue;
ADDRGP4 $1439
JUMPV
LABELV $1442
line 1894
;1892:		}
;1893:
;1894:		CG_RegisterWeapon( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_RegisterWeapon
CALLV
pop
line 1897
;1895:
;1896:		// draw weapon icon
;1897:		CG_DrawPic( x, y, 32, 32, cg_weapons[i].weaponIcon );
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 36
CNSTF4 1107296256
ASGNF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
CNSTI4 136
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cg_weapons+68
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1900
;1898:
;1899:		// draw selection marker
;1900:		if ( i == WEAPON_MASK(cg.weaponSelect) ) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+108944
INDIRI4
NEI4 $1445
line 1901
;1901:			CG_DrawPic( x-4, y-4, 40, 40, cgs.media.selectShader );
ADDRLP4 40
CNSTI4 4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 40
INDIRI4
SUBI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRI4
ADDRLP4 40
INDIRI4
SUBI4
CVIF4 4
ARGF4
ADDRLP4 44
CNSTF4 1109393408
ASGNF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRGP4 cgs+156680+264
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1902
;1902:		}
LABELV $1445
line 1905
;1903:
;1904:		// no ammo cross on top
;1905:		if ( !cg.snap->ps.ammo[ i ] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 420
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1450
line 1906
;1906:			CG_DrawPic( x, y, 32, 32, cgs.media.noammoShader );
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 40
CNSTF4 1107296256
ASGNF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRGP4 cgs+156680+328
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1907
;1907:		}
LABELV $1450
line 1909
;1908:
;1909:		x += 40;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 40
ADDI4
ASGNI4
line 1910
;1910:	}
LABELV $1439
line 1889
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $1438
line 1913
;1911:
;1912:	// draw the selected name
;1913:	if ( cg_weapons[ WEAPON_MASK(cg.weaponSelect) ].item ) {
CNSTI4 136
ADDRGP4 cg+108944
INDIRI4
MULI4
ADDRGP4 cg_weapons+4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1455
line 1914
;1914:		name = cg_weapons[ WEAPON_MASK(cg.weaponSelect) ].item->pickup_name;
ADDRLP4 24
CNSTI4 136
ADDRGP4 cg+108944
INDIRI4
MULI4
ADDRGP4 cg_weapons+4
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRP4
ASGNP4
line 1915
;1915:		if ( name ) {
ADDRLP4 24
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1461
line 1916
;1916:			w = CG_DrawStrlen( name ) * BIGCHAR_WIDTH;
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 36
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 1917
;1917:			x = ( SCREEN_WIDTH - w ) / 2;
ADDRLP4 4
CNSTI4 640
ADDRLP4 28
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ASGNI4
line 1918
;1918:			CG_DrawBigStringColor(x, y - 22, name, color);
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
CNSTI4 22
SUBI4
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 CG_DrawBigStringColor
CALLV
pop
line 1919
;1919:		}
LABELV $1461
line 1920
;1920:	}
LABELV $1455
line 1922
;1921:
;1922:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1923
;1923:}
LABELV $1426
endproc CG_DrawWeaponSelect 48 20
proc CG_WeaponSelectable 0 0
line 1931
;1924:
;1925:
;1926:/*
;1927:===============
;1928:CG_WeaponSelectable
;1929:===============
;1930:*/
;1931:static qboolean CG_WeaponSelectable( int i ) {
line 1932
;1932:	if ( !cg.snap->ps.ammo[i] ) {
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 420
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1464
line 1933
;1933:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1463
JUMPV
LABELV $1464
line 1935
;1934:	}
;1935:	if ( ! (cg.snap->ps.stats[ STAT_WEAPONS ] & ( 1 << i ) ) ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
CNSTI4 1
ADDRFP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
NEI4 $1467
line 1936
;1936:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1463
JUMPV
LABELV $1467
line 1939
;1937:	}
;1938:
;1939:	return qtrue;
CNSTI4 1
RETI4
LABELV $1463
endproc CG_WeaponSelectable 0 0
export CG_NextWeapon_f
proc CG_NextWeapon_f 12 4
line 1947
;1940:}
;1941:
;1942:/*
;1943:===============
;1944:CG_NextWeapon_f
;1945:===============
;1946:*/
;1947:void CG_NextWeapon_f( void ) {
line 1953
;1948:	int		i;
;1949:	int		original;
;1950:	//char	command[64];
;1951:	//char	weaponNum[8];
;1952:
;1953:	if ( !cg.snap ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1471
line 1954
;1954:		return;
ADDRGP4 $1470
JUMPV
LABELV $1471
line 1956
;1955:	}
;1956:	if ( cg.snap->ps.pm_flags & PMF_FOLLOW ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $1474
line 1957
;1957:		return;
ADDRGP4 $1470
JUMPV
LABELV $1474
line 1960
;1958:	}
;1959:
;1960:	cg.weaponSelectTime = cg.time;
ADDRGP4 cg+130828
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1961
;1961:	original = WEAPON_MASK(cg.weaponSelect);
ADDRLP4 4
ADDRGP4 cg+108944
INDIRI4
ASGNI4
line 1963
;1962:
;1963:	for ( i = 0 ; i < 16 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1480
line 1964
;1964:		SET_WEAPON(cg.weaponSelect, cg.weaponSelect + 1);
ADDRGP4 cg+108944
ADDRGP4 cg+108944
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1965
;1965:		if ( WEAPON_MASK(cg.weaponSelect) == 16 ) {
ADDRGP4 cg+108944
INDIRI4
CNSTI4 16
NEI4 $1486
line 1966
;1966:			SET_WEAPON(cg.weaponSelect, 0);
ADDRGP4 cg+108944
CNSTI4 0
ASGNI4
line 1967
;1967:		}
LABELV $1486
line 1968
;1968:		if ( WEAPON_MASK(cg.weaponSelect) == WP_GAUNTLET && !cg_fullWeaponCycle.integer) {
ADDRGP4 cg+108944
INDIRI4
CNSTI4 1
NEI4 $1490
ADDRGP4 cg_fullWeaponCycle+12
INDIRI4
CNSTI4 0
NEI4 $1490
line 1969
;1969:			continue;		// never cycle to gauntlet
ADDRGP4 $1481
JUMPV
LABELV $1490
line 1971
;1970:		}
;1971:		if ( CG_WeaponSelectable( WEAPON_MASK(cg.weaponSelect) ) ) {
ADDRGP4 cg+108944
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 CG_WeaponSelectable
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $1494
line 1972
;1972:			break;
ADDRGP4 $1482
JUMPV
LABELV $1494
line 1974
;1973:		}
;1974:	}
LABELV $1481
line 1963
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $1480
LABELV $1482
line 1975
;1975:	if ( i == 16 ) {
ADDRLP4 0
INDIRI4
CNSTI4 16
NEI4 $1497
line 1976
;1976:		SET_WEAPON(cg.weaponSelect, original);
ADDRGP4 cg+108944
ADDRLP4 4
INDIRI4
ASGNI4
line 1977
;1977:	}
LABELV $1497
line 1984
;1978:	//Hack, but we're using the byte weapon; to transfer hitscan results
;1979:	//if ( cg.weaponSelect >= WP_NONE && cg.weaponSelect <= WP_NUM_WEAPONS && cg.weaponSelect != original ) {
;1980:		//Com_sprintf(weaponNum, 8, "%i", cg.weaponSelect);
;1981:	//	Com_sprintf(command, 64, "WeaponSwitch %i \n", cg.weaponSelect);
;1982:	//	trap_SendClientCommand( command );
;1983:	//}
;1984:}
LABELV $1470
endproc CG_NextWeapon_f 12 4
export CG_PrevWeapon_f
proc CG_PrevWeapon_f 12 4
line 1991
;1985:
;1986:/*
;1987:===============
;1988:CG_PrevWeapon_f
;1989:===============
;1990:*/
;1991:void CG_PrevWeapon_f( void ) {
line 1997
;1992:	int		i;
;1993:	int		original;
;1994:	//char	command[64];
;1995:	//char	weaponNum[8];
;1996:
;1997:	if ( !cg.snap ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1501
line 1998
;1998:		return;
ADDRGP4 $1500
JUMPV
LABELV $1501
line 2000
;1999:	}
;2000:	if ( cg.snap->ps.pm_flags & PMF_FOLLOW ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $1504
line 2001
;2001:		return;
ADDRGP4 $1500
JUMPV
LABELV $1504
line 2004
;2002:	}
;2003:
;2004:	cg.weaponSelectTime = cg.time;
ADDRGP4 cg+130828
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 2005
;2005:	original = WEAPON_MASK(cg.weaponSelect);
ADDRLP4 4
ADDRGP4 cg+108944
INDIRI4
ASGNI4
line 2007
;2006:
;2007:	for ( i = 0 ; i < 16 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1510
line 2008
;2008:		SET_WEAPON(cg.weaponSelect, cg.weaponSelect - 1);
ADDRGP4 cg+108944
ADDRGP4 cg+108944
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2009
;2009:		if ( WEAPON_MASK(cg.weaponSelect) == -1 ) {
ADDRGP4 cg+108944
INDIRI4
CNSTI4 -1
NEI4 $1516
line 2010
;2010:			SET_WEAPON(cg.weaponSelect, 15);
ADDRGP4 cg+108944
CNSTI4 15
ASGNI4
line 2011
;2011:		}
LABELV $1516
line 2012
;2012:		if ( WEAPON_MASK(cg.weaponSelect) == WP_GAUNTLET && !cg_fullWeaponCycle.integer) {
ADDRGP4 cg+108944
INDIRI4
CNSTI4 1
NEI4 $1520
ADDRGP4 cg_fullWeaponCycle+12
INDIRI4
CNSTI4 0
NEI4 $1520
line 2013
;2013:			continue;		// never cycle to gauntlet
ADDRGP4 $1511
JUMPV
LABELV $1520
line 2015
;2014:		}
;2015:		if ( CG_WeaponSelectable( WEAPON_MASK(cg.weaponSelect) ) ) {
ADDRGP4 cg+108944
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 CG_WeaponSelectable
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $1524
line 2016
;2016:			break;
ADDRGP4 $1512
JUMPV
LABELV $1524
line 2018
;2017:		}
;2018:	}
LABELV $1511
line 2007
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $1510
LABELV $1512
line 2019
;2019:	if ( i == 16 ) {
ADDRLP4 0
INDIRI4
CNSTI4 16
NEI4 $1527
line 2020
;2020:		SET_WEAPON(cg.weaponSelect, original);
ADDRGP4 cg+108944
ADDRLP4 4
INDIRI4
ASGNI4
line 2021
;2021:	}
LABELV $1527
line 2028
;2022:	//Hack, but we're using the byte weapon; to transfer hitscan results
;2023:	//if ( cg.weaponSelect >= WP_NONE && cg.weaponSelect <= WP_NUM_WEAPONS && cg.weaponSelect != original ) {
;2024:		//Com_sprintf(weaponNum, 8, "%i", cg.weaponSelect);
;2025:	//	Com_sprintf(command, 64, "WeaponSwitch %i \n", cg.weaponSelect);
;2026:	//	trap_SendClientCommand( command );
;2027:	//}
;2028:}
LABELV $1500
endproc CG_PrevWeapon_f 12 4
export CG_Weapon_f
proc CG_Weapon_f 16 4
line 2035
;2029:
;2030:/*
;2031:===============
;2032:CG_Weapon_f
;2033:===============
;2034:*/
;2035:void CG_Weapon_f( void ) {
line 2040
;2036:	int		num;
;2037:	//char	command[64];
;2038:	//char	weaponNum[8];
;2039:
;2040:	if ( !cg.snap ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1531
line 2041
;2041:		return;
ADDRGP4 $1530
JUMPV
LABELV $1531
line 2043
;2042:	}
;2043:	if ( cg.snap->ps.pm_flags & PMF_FOLLOW ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $1534
line 2044
;2044:		return;
ADDRGP4 $1530
JUMPV
LABELV $1534
line 2047
;2045:	}
;2046:
;2047:	num = atoi( CG_Argv( 1 ) );
CNSTI4 1
ARGI4
ADDRLP4 4
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 2049
;2048:
;2049:	if ( num < 1 || num > 15 ) {
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $1539
ADDRLP4 0
INDIRI4
CNSTI4 15
LEI4 $1537
LABELV $1539
line 2050
;2050:		return;
ADDRGP4 $1530
JUMPV
LABELV $1537
line 2053
;2051:	}
;2052:
;2053:	cg.weaponSelectTime = cg.time;
ADDRGP4 cg+130828
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 2055
;2054:
;2055:	if ( ! ( cg.snap->ps.stats[STAT_WEAPONS] & ( 1 << num ) ) ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
NEI4 $1542
line 2056
;2056:		return;		// don't have the weapon
ADDRGP4 $1530
JUMPV
LABELV $1542
line 2059
;2057:	}
;2058:
;2059:	SET_WEAPON(cg.weaponSelect, num);
ADDRGP4 cg+108944
ADDRLP4 0
INDIRI4
ASGNI4
line 2066
;2060:	//Hack, but we're using the byte weapon; to transfer hitscan results
;2061:	//if ( cg.weaponSelect >= WP_NONE && cg.weaponSelect <= WP_NUM_WEAPONS ) {
;2062:		//Com_sprintf(weaponNum, 8, "%i", cg.weaponSelect);
;2063:	//	Com_sprintf(command, 64, "WeaponSwitch %i \n", cg.weaponSelect);
;2064:	//	trap_SendClientCommand( command );
;2065:	//}
;2066:}
LABELV $1530
endproc CG_Weapon_f 16 4
export CG_OutOfAmmoChange
proc CG_OutOfAmmoChange 8 4
line 2075
;2067:
;2068:/*
;2069:===================
;2070:CG_OutOfAmmoChange
;2071:
;2072:The current weapon has just run out of ammo
;2073:===================
;2074:*/
;2075:void CG_OutOfAmmoChange( void ) {
line 2078
;2076:	int		i;
;2077:
;2078:	cg.weaponSelectTime = cg.time;
ADDRGP4 cg+130828
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 2080
;2079:
;2080:	for ( i = 15 ; i > 0 ; i-- ) {
ADDRLP4 0
CNSTI4 15
ASGNI4
LABELV $1549
line 2081
;2081:		if ( CG_WeaponSelectable( i ) ) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 CG_WeaponSelectable
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $1553
line 2082
;2082:			SET_WEAPON(cg.weaponSelect, i);
ADDRGP4 cg+108944
ADDRLP4 0
INDIRI4
ASGNI4
line 2083
;2083:			break;
ADDRGP4 $1551
JUMPV
LABELV $1553
line 2085
;2084:		}
;2085:	}
LABELV $1550
line 2080
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $1549
LABELV $1551
line 2086
;2086:}
LABELV $1546
endproc CG_OutOfAmmoChange 8 4
export CG_FireWeapon
proc CG_FireWeapon 20 16
line 2105
;2087:
;2088:
;2089:
;2090:/*
;2091:===================================================================================================
;2092:
;2093:WEAPON EVENTS
;2094:
;2095:===================================================================================================
;2096:*/
;2097:
;2098:/*
;2099:================
;2100:CG_FireWeapon
;2101:
;2102:Caused by an EV_FIRE_WEAPON event
;2103:================
;2104:*/
;2105:void CG_FireWeapon( centity_t *cent ) {
line 2110
;2106:	entityState_t *ent;
;2107:	int				c;
;2108:	weaponInfo_t	*weap;
;2109:
;2110:	ent = &cent->currentState;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
line 2111
;2111:	if ( ent->weapon == WP_NONE ) {
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1557
line 2112
;2112:		return;
ADDRGP4 $1556
JUMPV
LABELV $1557
line 2114
;2113:	}
;2114:	if ( ent->weapon >= WP_NUM_WEAPONS ) {
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 11
LTI4 $1559
line 2115
;2115:		CG_Error( "CG_FireWeapon: ent->weapon >= WP_NUM_WEAPONS" );
ADDRGP4 $1561
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 2116
;2116:		return;
ADDRGP4 $1556
JUMPV
LABELV $1559
line 2118
;2117:	}
;2118:	weap = &cg_weapons[ ent->weapon ];
ADDRLP4 4
CNSTI4 136
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons
ADDP4
ASGNP4
line 2122
;2119:
;2120:	// mark the entity as muzzle flashing, so when it is added it will
;2121:	// append the flash to the weapon model
;2122:	cent->muzzleFlashTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 2123
;2123:	if ( !cg_muzzleFlash.integer ) {
ADDRGP4 cg_muzzleFlash+12
INDIRI4
CNSTI4 0
NEI4 $1563
line 2124
;2124:		cent->muzzleFlashTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 0
ASGNI4
line 2125
;2125:	}
LABELV $1563
line 2128
;2126:
;2127:	// lightning gun only does this this on initial press
;2128:	if ( ent->weapon == WP_LIGHTNING ) {
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 6
NEI4 $1566
line 2129
;2129:		if ( cent->pe.lightningFiring ) {
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1568
line 2130
;2130:			return;
ADDRGP4 $1556
JUMPV
LABELV $1568
line 2132
;2131:		}
;2132:	}
LABELV $1566
line 2135
;2133:
;2134:	// play quad sound if needed
;2135:	if ( cent->currentState.powerups & ( 1 << PW_QUAD ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1570
line 2136
;2136:		trap_S_StartSound (NULL, cent->currentState.number, CHAN_ITEM, cgs.media.quadSound );
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 cgs+156680+604
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 2137
;2137:	}
LABELV $1570
line 2140
;2138:
;2139:	// play a sound
;2140:	for ( c = 0 ; c < 4 ; c++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1574
line 2141
;2141:		if ( !weap->flashSound[c] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 52
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1578
line 2142
;2142:			break;
ADDRGP4 $1576
JUMPV
LABELV $1578
line 2144
;2143:		}
;2144:	}
LABELV $1575
line 2140
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $1574
LABELV $1576
line 2145
;2145:	if ( c > 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $1580
line 2146
;2146:		c = rand() % c;
ADDRLP4 12
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ADDRLP4 0
INDIRI4
MODI4
ASGNI4
line 2147
;2147:		if ( weap->flashSound[c] )
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 52
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1582
line 2148
;2148:		{
line 2149
;2149:			trap_S_StartSound( NULL, ent->number, CHAN_WEAPON, weap->flashSound[c] );
CNSTP4 0
ARGP4
ADDRLP4 8
INDIRP4
INDIRI4
ARGI4
ADDRLP4 16
CNSTI4 2
ASGNI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 52
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 2150
;2150:		}
LABELV $1582
line 2151
;2151:	}
LABELV $1580
line 2154
;2152:
;2153:	// do brass ejection
;2154:	if ( weap->ejectBrassFunc && cg_brassTime.integer > 0 ) {
ADDRLP4 4
INDIRP4
CNSTI4 112
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1584
ADDRGP4 cg_brassTime+12
INDIRI4
CNSTI4 0
LEI4 $1584
line 2155
;2155:		weap->ejectBrassFunc( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 112
ADDP4
INDIRP4
CALLV
pop
line 2156
;2156:	}
LABELV $1584
line 2159
;2157:
;2158://unlagged - attack prediction #1
;2159:	CG_PredictWeaponEffects( cent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_PredictWeaponEffects
CALLV
pop
line 2161
;2160://unlagged - attack prediction #1
;2161:}
LABELV $1556
endproc CG_FireWeapon 20 16
export CG_FireGrapple
proc CG_FireGrapple 4 0
line 2163
;2162:
;2163:void CG_FireGrapple( centity_t *cent ) {
line 2168
;2164:	entityState_t *ent;
;2165:	//weaponInfo_t	*weap;
;2166:
;2167:	//no grapple allowed
;2168:	if( weap_enableHook.integer == 0 ) {
ADDRGP4 weap_enableHook+12
INDIRI4
CNSTI4 0
NEI4 $1588
line 2169
;2169:		return;
ADDRGP4 $1587
JUMPV
LABELV $1588
line 2172
;2170:	}
;2171:	
;2172:	ent = &cent->currentState;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 2178
;2173:	//weap = &cg_weapons[ WP_GRAPPLING_HOOK ];
;2174:
;2175:	// mark the entity as muzzle flashing, so when it is added it will
;2176:	// append the flash to the weapon model
;2177:	// cent->muzzleFlashTime = cg.time;
;2178:	cent->muzzleFlashTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 0
ASGNI4
line 2191
;2179:
;2180:	//no clue why sound isn't played...
;2181:	//Evo: removed sound cuz it sucks. annoying as hell and this _isn't_ the right way
;2182:	//if ( cg.time >= cgs.grappleSoundPlayAgain ) {
;2183:	//	trap_S_StartSound( NULL, ent->number, CHAN_ITEM, cgs.media.grappleSound );
;2184:	//	cgs.grappleSoundPlayAgain = cg.time + 1985;
;2185:	//}
;2186:
;2187:
;2188:	//unlagged - attack prediction #1
;2189:	//CG_PredictWeaponEffects( cent );
;2190:	//unlagged - attack prediction #1
;2191:}
LABELV $1587
endproc CG_FireGrapple 4 0
export CG_MissileHitWall
proc CG_MissileHitWall 156 44
line 2200
;2192:
;2193:/*
;2194:=================
;2195:CG_MissileHitWall
;2196:
;2197:Caused by an EV_MISSILE_MISS event, or directly by local bullet tracing
;2198:=================
;2199:*/
;2200:void CG_MissileHitWall( int weapon, int clientNum, vec3_t origin, vec3_t dir, impactSound_t soundType ) {
line 2216
;2201:	qhandle_t		mod;
;2202:	qhandle_t		mark;
;2203:	qhandle_t		shader;
;2204:	sfxHandle_t		sfx;
;2205:	float			radius;
;2206:	float			light;
;2207:	vec3_t			lightColor;
;2208:	localEntity_t	*le;
;2209:	int				r;
;2210:	qboolean		alphaFade;
;2211:	qboolean		isSprite;
;2212:	int				duration;
;2213:	vec3_t			sprOrg;
;2214:	vec3_t			sprVel;
;2215:
;2216:	mark = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2217
;2217:	radius = 32;
ADDRLP4 24
CNSTF4 1107296256
ASGNF4
line 2218
;2218:	sfx = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 2219
;2219:	mod = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 2220
;2220:	shader = 0;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 2221
;2221:	light = 0;
ADDRLP4 44
CNSTF4 0
ASGNF4
line 2222
;2222:	lightColor[0] = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 2223
;2223:	lightColor[1] = 1;
ADDRLP4 4+4
CNSTF4 1065353216
ASGNF4
line 2224
;2224:	lightColor[2] = 0;
ADDRLP4 4+8
CNSTF4 0
ASGNF4
line 2227
;2225:
;2226:	// set defaults
;2227:	isSprite = qfalse;
ADDRLP4 36
CNSTI4 0
ASGNI4
line 2228
;2228:	duration = 600;
ADDRLP4 48
CNSTI4 600
ASGNI4
line 2230
;2229:
;2230:	switch ( weapon ) {
ADDRLP4 80
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 84
CNSTI4 2
ASGNI4
ADDRLP4 80
INDIRI4
ADDRLP4 84
INDIRI4
LTI4 $1594
ADDRLP4 80
INDIRI4
CNSTI4 9
GTI4 $1594
ADDRLP4 80
INDIRI4
ADDRLP4 84
INDIRI4
LSHI4
ADDRGP4 $1688-8
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1688
address $1671
address $1664
address $1609
address $1618
address $1596
address $1637
address $1646
address $1655
code
LABELV $1594
LABELV $1596
line 2247
;2231:	default:
;2232:#ifdef MISSIONPACK
;2233:	case WP_NAILGUN:
;2234:		if( soundType == IMPACTSOUND_FLESH ) {
;2235:			sfx = cgs.media.sfx_nghitflesh;
;2236:		} else if( soundType == IMPACTSOUND_METAL ) {
;2237:			sfx = cgs.media.sfx_nghitmetal;
;2238:		} else {
;2239:			sfx = cgs.media.sfx_nghit;
;2240:		}
;2241:		mark = cgs.media.holeMarkShader;
;2242:		radius = 12;
;2243:		break;
;2244:#endif
;2245:	case WP_LIGHTNING:
;2246:		// no explosion at LG impact, it is added with the beam
;2247:		r = rand() & 3;
ADDRLP4 88
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 52
ADDRLP4 88
INDIRI4
CNSTI4 3
BANDI4
ASGNI4
line 2248
;2248:		if ( r < 2 ) {
ADDRLP4 52
INDIRI4
CNSTI4 2
GEI4 $1597
line 2249
;2249:			sfx = cgs.media.sfx_lghit2;
ADDRLP4 16
ADDRGP4 cgs+156680+740
INDIRI4
ASGNI4
line 2250
;2250:		} else if ( r == 2 ) {
ADDRGP4 $1598
JUMPV
LABELV $1597
ADDRLP4 52
INDIRI4
CNSTI4 2
NEI4 $1601
line 2251
;2251:			sfx = cgs.media.sfx_lghit1;
ADDRLP4 16
ADDRGP4 cgs+156680+736
INDIRI4
ASGNI4
line 2252
;2252:		} else {
ADDRGP4 $1602
JUMPV
LABELV $1601
line 2253
;2253:			sfx = cgs.media.sfx_lghit3;
ADDRLP4 16
ADDRGP4 cgs+156680+744
INDIRI4
ASGNI4
line 2254
;2254:		}
LABELV $1602
LABELV $1598
line 2255
;2255:		mark = cgs.media.holeMarkShader;
ADDRLP4 0
ADDRGP4 cgs+156680+440
INDIRI4
ASGNI4
line 2256
;2256:		radius = 12;
ADDRLP4 24
CNSTF4 1094713344
ASGNF4
line 2257
;2257:		break;
ADDRGP4 $1595
JUMPV
LABELV $1609
line 2270
;2258:#ifdef MISSIONPACK
;2259:	case WP_PROX_LAUNCHER:
;2260:		mod = cgs.media.dishFlashModel;
;2261:		shader = cgs.media.grenadeExplosionShader;
;2262:		sfx = cgs.media.sfx_proxexp;
;2263:		mark = cgs.media.burnMarkShader;
;2264:		radius = 64;
;2265:		light = 300;
;2266:		isSprite = qtrue;
;2267:		break;
;2268:#endif
;2269:	case WP_GRENADE_LAUNCHER:
;2270:		mod = cgs.media.dishFlashModel;
ADDRLP4 20
ADDRGP4 cgs+156680+504
INDIRI4
ASGNI4
line 2271
;2271:		shader = cgs.media.grenadeExplosionShader;
ADDRLP4 28
ADDRGP4 cgs+156680+528
INDIRI4
ASGNI4
line 2272
;2272:		sfx = cgs.media.sfx_rockexp;
ADDRLP4 16
ADDRGP4 cgs+156680+764
INDIRI4
ASGNI4
line 2273
;2273:		mark = cgs.media.burnMarkShader;
ADDRLP4 0
ADDRGP4 cgs+156680+436
INDIRI4
ASGNI4
line 2274
;2274:		radius = 64;
ADDRLP4 24
CNSTF4 1115684864
ASGNF4
line 2275
;2275:		light = 300;
ADDRLP4 44
CNSTF4 1133903872
ASGNF4
line 2276
;2276:		isSprite = qtrue;
ADDRLP4 36
CNSTI4 1
ASGNI4
line 2277
;2277:		break;
ADDRGP4 $1595
JUMPV
LABELV $1618
line 2279
;2278:	case WP_ROCKET_LAUNCHER:
;2279:		mod = cgs.media.dishFlashModel;
ADDRLP4 20
ADDRGP4 cgs+156680+504
INDIRI4
ASGNI4
line 2280
;2280:		shader = cgs.media.rocketExplosionShader;
ADDRLP4 28
ADDRGP4 cgs+156680+524
INDIRI4
ASGNI4
line 2281
;2281:		sfx = cgs.media.sfx_rockexp;
ADDRLP4 16
ADDRGP4 cgs+156680+764
INDIRI4
ASGNI4
line 2282
;2282:		mark = cgs.media.burnMarkShader;
ADDRLP4 0
ADDRGP4 cgs+156680+436
INDIRI4
ASGNI4
line 2283
;2283:		radius = 64;
ADDRLP4 24
CNSTF4 1115684864
ASGNF4
line 2284
;2284:		light = 300;
ADDRLP4 44
CNSTF4 1133903872
ASGNF4
line 2285
;2285:		isSprite = qtrue;
ADDRLP4 36
CNSTI4 1
ASGNI4
line 2286
;2286:		duration = 1000;
ADDRLP4 48
CNSTI4 1000
ASGNI4
line 2287
;2287:		lightColor[0] = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 2288
;2288:		lightColor[1] = 0.75;
ADDRLP4 4+4
CNSTF4 1061158912
ASGNF4
line 2289
;2289:		lightColor[2] = 0.0;
ADDRLP4 4+8
CNSTF4 0
ASGNF4
line 2290
;2290:		if (cg_oldRocket.integer == 0) {
ADDRGP4 cg_oldRocket+12
INDIRI4
CNSTI4 0
NEI4 $1595
line 2292
;2291:			// explosion sprite animation
;2292:			VectorMA( origin, 24, dir, sprOrg );
ADDRLP4 92
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 96
CNSTF4 1103101952
ASGNF4
ADDRLP4 100
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 56
ADDRLP4 92
INDIRP4
INDIRF4
ADDRLP4 96
INDIRF4
ADDRLP4 100
INDIRP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 104
CNSTI4 4
ASGNI4
ADDRLP4 56+4
ADDRLP4 92
INDIRP4
ADDRLP4 104
INDIRI4
ADDP4
INDIRF4
ADDRLP4 96
INDIRF4
ADDRLP4 100
INDIRP4
ADDRLP4 104
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 108
CNSTI4 8
ASGNI4
ADDRLP4 56+8
ADDRFP4 8
INDIRP4
ADDRLP4 108
INDIRI4
ADDP4
INDIRF4
CNSTF4 1103101952
ADDRFP4 12
INDIRP4
ADDRLP4 108
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 2293
;2293:			VectorScale( dir, 64, sprVel );
ADDRLP4 112
CNSTF4 1115684864
ASGNF4
ADDRLP4 116
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 68
ADDRLP4 112
INDIRF4
ADDRLP4 116
INDIRP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 68+4
ADDRLP4 112
INDIRF4
ADDRLP4 116
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ASGNF4
ADDRLP4 68+8
CNSTF4 1115684864
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ASGNF4
line 2295
;2294:
;2295:			CG_ParticleExplosion( "explode1", sprOrg, sprVel, 1400, 20, 30 );
ADDRGP4 $1636
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 68
ARGP4
CNSTI4 1400
ARGI4
CNSTI4 20
ARGI4
CNSTI4 30
ARGI4
ADDRGP4 CG_ParticleExplosion
CALLV
pop
line 2296
;2296:		}
line 2297
;2297:		break;
ADDRGP4 $1595
JUMPV
LABELV $1637
line 2299
;2298:	case WP_RAILGUN:
;2299:		mod = cgs.media.ringFlashModel;
ADDRLP4 20
ADDRGP4 cgs+156680+500
INDIRI4
ASGNI4
line 2300
;2300:		shader = cgs.media.railExplosionShader;
ADDRLP4 28
ADDRGP4 cgs+156680+512
INDIRI4
ASGNI4
line 2301
;2301:		sfx = cgs.media.sfx_plasmaexp;
ADDRLP4 16
ADDRGP4 cgs+156680+768
INDIRI4
ASGNI4
line 2302
;2302:		mark = cgs.media.energyMarkShader;
ADDRLP4 0
ADDRGP4 cgs+156680+444
INDIRI4
ASGNI4
line 2303
;2303:		radius = 24;
ADDRLP4 24
CNSTF4 1103101952
ASGNF4
line 2304
;2304:		break;
ADDRGP4 $1595
JUMPV
LABELV $1646
line 2306
;2305:	case WP_PLASMAGUN:
;2306:		mod = cgs.media.ringFlashModel;
ADDRLP4 20
ADDRGP4 cgs+156680+500
INDIRI4
ASGNI4
line 2307
;2307:		shader = cgs.media.plasmaExplosionShader;
ADDRLP4 28
ADDRGP4 cgs+156680+516
INDIRI4
ASGNI4
line 2308
;2308:		sfx = cgs.media.sfx_plasmaexp;
ADDRLP4 16
ADDRGP4 cgs+156680+768
INDIRI4
ASGNI4
line 2309
;2309:		mark = cgs.media.energyMarkShader;
ADDRLP4 0
ADDRGP4 cgs+156680+444
INDIRI4
ASGNI4
line 2310
;2310:		radius = 16;
ADDRLP4 24
CNSTF4 1098907648
ASGNF4
line 2311
;2311:		break;
ADDRGP4 $1595
JUMPV
LABELV $1655
line 2313
;2312:	case WP_BFG:
;2313:		mod = cgs.media.dishFlashModel;
ADDRLP4 20
ADDRGP4 cgs+156680+504
INDIRI4
ASGNI4
line 2314
;2314:		shader = cgs.media.bfgExplosionShader;
ADDRLP4 28
ADDRGP4 cgs+156680+532
INDIRI4
ASGNI4
line 2315
;2315:		sfx = cgs.media.sfx_rockexp;
ADDRLP4 16
ADDRGP4 cgs+156680+764
INDIRI4
ASGNI4
line 2316
;2316:		mark = cgs.media.burnMarkShader;
ADDRLP4 0
ADDRGP4 cgs+156680+436
INDIRI4
ASGNI4
line 2317
;2317:		radius = 32;
ADDRLP4 24
CNSTF4 1107296256
ASGNF4
line 2318
;2318:		isSprite = qtrue;
ADDRLP4 36
CNSTI4 1
ASGNI4
line 2319
;2319:		break;
ADDRGP4 $1595
JUMPV
LABELV $1664
line 2321
;2320:	case WP_SHOTGUN:
;2321:		mod = cgs.media.bulletFlashModel;
ADDRLP4 20
ADDRGP4 cgs+156680+496
INDIRI4
ASGNI4
line 2322
;2322:		shader = cgs.media.bulletExplosionShader;
ADDRLP4 28
ADDRGP4 cgs+156680+520
INDIRI4
ASGNI4
line 2323
;2323:		mark = cgs.media.bulletMarkShader;
ADDRLP4 0
ADDRGP4 cgs+156680+432
INDIRI4
ASGNI4
line 2324
;2324:		sfx = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 2325
;2325:		radius = 4;
ADDRLP4 24
CNSTF4 1082130432
ASGNF4
line 2326
;2326:		break;
ADDRGP4 $1595
JUMPV
LABELV $1671
line 2354
;2327:
;2328:#ifdef MISSIONPACK
;2329:	case WP_CHAINGUN:
;2330:		mod = cgs.media.bulletFlashModel;
;2331:		if( soundType == IMPACTSOUND_FLESH ) {
;2332:			sfx = cgs.media.sfx_chghitflesh;
;2333:		} else if( soundType == IMPACTSOUND_METAL ) {
;2334:			sfx = cgs.media.sfx_chghitmetal;
;2335:		} else {
;2336:			sfx = cgs.media.sfx_chghit;
;2337:		}
;2338:		mark = cgs.media.bulletMarkShader;
;2339:
;2340:		r = rand() & 3;
;2341:		if ( r < 2 ) {
;2342:			sfx = cgs.media.sfx_ric1;
;2343:		} else if ( r == 2 ) {
;2344:			sfx = cgs.media.sfx_ric2;
;2345:		} else {
;2346:			sfx = cgs.media.sfx_ric3;
;2347:		}
;2348:
;2349:		radius = 8;
;2350:		break;
;2351:#endif
;2352:
;2353:	case WP_MACHINEGUN:
;2354:		mod = cgs.media.bulletFlashModel;
ADDRLP4 20
ADDRGP4 cgs+156680+496
INDIRI4
ASGNI4
line 2355
;2355:		shader = cgs.media.bulletExplosionShader;
ADDRLP4 28
ADDRGP4 cgs+156680+520
INDIRI4
ASGNI4
line 2356
;2356:		mark = cgs.media.bulletMarkShader;
ADDRLP4 0
ADDRGP4 cgs+156680+432
INDIRI4
ASGNI4
line 2358
;2357:
;2358:		r = rand() & 3;
ADDRLP4 92
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 52
ADDRLP4 92
INDIRI4
CNSTI4 3
BANDI4
ASGNI4
line 2359
;2359:		if ( r == 0 ) {
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $1678
line 2360
;2360:			sfx = cgs.media.sfx_ric1;
ADDRLP4 16
ADDRGP4 cgs+156680+748
INDIRI4
ASGNI4
line 2361
;2361:		} else if ( r == 1 ) {
ADDRGP4 $1679
JUMPV
LABELV $1678
ADDRLP4 52
INDIRI4
CNSTI4 1
NEI4 $1682
line 2362
;2362:			sfx = cgs.media.sfx_ric2;
ADDRLP4 16
ADDRGP4 cgs+156680+752
INDIRI4
ASGNI4
line 2363
;2363:		} else {
ADDRGP4 $1683
JUMPV
LABELV $1682
line 2364
;2364:			sfx = cgs.media.sfx_ric3;
ADDRLP4 16
ADDRGP4 cgs+156680+756
INDIRI4
ASGNI4
line 2365
;2365:		}
LABELV $1683
LABELV $1679
line 2367
;2366:
;2367:		radius = 8;
ADDRLP4 24
CNSTF4 1090519040
ASGNF4
line 2368
;2368:		break;
LABELV $1595
line 2371
;2369:	}
;2370:
;2371:	if ( sfx ) {
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $1690
line 2372
;2372:		trap_S_StartSound( origin, ENTITYNUM_WORLD, CHAN_AUTO, sfx );
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 1022
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 2373
;2373:	}
LABELV $1690
line 2378
;2374:
;2375:	//
;2376:	// create the explosion
;2377:	//
;2378:	if ( mod ) {
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $1692
line 2379
;2379:		le = CG_MakeExplosion( origin, dir, 
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 88
ADDRGP4 CG_MakeExplosion
CALLP4
ASGNP4
ADDRLP4 40
ADDRLP4 88
INDIRP4
ASGNP4
line 2382
;2380:							   mod,	shader,
;2381:							   duration, isSprite );
;2382:		le->light = light;
ADDRLP4 40
INDIRP4
CNSTI4 128
ADDP4
ADDRLP4 44
INDIRF4
ASGNF4
line 2383
;2383:		VectorCopy( lightColor, le->lightColor );
ADDRLP4 40
INDIRP4
CNSTI4 132
ADDP4
ADDRLP4 4
INDIRB
ASGNB 12
line 2384
;2384:		if ( weapon == WP_RAILGUN ) {
ADDRFP4 0
INDIRI4
CNSTI4 7
NEI4 $1694
line 2386
;2385:			// colorize with client color
;2386:			VectorCopy( cgs.clientinfo[clientNum].color1, le->color );
ADDRLP4 40
INDIRP4
CNSTI4 108
ADDP4
CNSTI4 1776
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 cgs+40960+76
ADDP4
INDIRB
ASGNB 12
line 2387
;2387:		}
LABELV $1694
line 2388
;2388:	}
LABELV $1692
line 2393
;2389:
;2390:	//
;2391:	// impact mark
;2392:	//
;2393:	alphaFade = (mark == cgs.media.energyMarkShader);	// plasma fades alpha, all others fade color
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+156680+444
INDIRI4
NEI4 $1701
ADDRLP4 88
CNSTI4 1
ASGNI4
ADDRGP4 $1702
JUMPV
LABELV $1701
ADDRLP4 88
CNSTI4 0
ASGNI4
LABELV $1702
ADDRLP4 32
ADDRLP4 88
INDIRI4
ASGNI4
line 2394
;2394:	if ( weapon == WP_RAILGUN ) {
ADDRFP4 0
INDIRI4
CNSTI4 7
NEI4 $1703
line 2399
;2395:		//float	*color;
;2396:		vec4_t	color;
;2397:
;2398:		// colorize with client color
;2399:/*freeze*/if ( (cgs.clientinfo[clientNum].team != cgs.clientinfo[ cg.clientNum ].team && strlen(cg_EnemyColors.string) !=3 
ADDRLP4 108
CNSTI4 1776
ASGNI4
ADDRLP4 108
INDIRI4
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
ADDRLP4 108
INDIRI4
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
EQI4 $1724
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 112
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 116
CNSTI4 3
ASGNI4
ADDRLP4 112
INDIRI4
ADDRLP4 116
INDIRI4
EQI4 $1724
ADDRGP4 cgs+31456
INDIRI4
ADDRLP4 116
INDIRI4
LTI4 $1724
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
ADDRLP4 116
INDIRI4
NEI4 $1721
LABELV $1724
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
GEI4 $1705
CNSTI4 1776
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 cgs+40960+1768
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1705
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 120
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 3
EQI4 $1705
LABELV $1721
line 2401
;2400:					&& cgs.gametype >= GT_TEAM && cgs.clientinfo[cg.clientNum].team != TEAM_SPECTATOR ||
;2401:					(cgs.gametype < GT_TEAM && !cgs.clientinfo[clientNum].localClient && strlen(cg_EnemyColors.string) !=3 ) ) ) {
line 2402
;2402:						if ( strlen( cg_EnemyColors.string ) == 2 ) {
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 124
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 2
NEI4 $1725
line 2403
;2403:							memcpy(color, g_color_table[ColorIndex(cg_EnemyColors.string[1])], sizeof(color));
ADDRGP4 cg_EnemyColors+16+1
INDIRI1
CVII4 1
ARGI4
ADDRLP4 128
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 92
ARGP4
ADDRLP4 128
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2404
;2404:						} else {
ADDRGP4 $1706
JUMPV
LABELV $1725
line 2405
;2405:							memcpy(color, g_color_table[ColorIndex(cg_EnemyColors.string[4])], sizeof(color));
ADDRGP4 cg_EnemyColors+16+4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 128
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 92
ARGP4
ADDRLP4 128
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2406
;2406:						}
line 2407
;2407:				} else if ( cgs.clientinfo[clientNum].team == cgs.clientinfo[ cg.clientNum ].team && strlen(cg_TeamColors.string) != 3
ADDRGP4 $1706
JUMPV
LABELV $1705
ADDRLP4 124
CNSTI4 1776
ASGNI4
ADDRLP4 124
INDIRI4
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
ADDRLP4 124
INDIRI4
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
NEI4 $1732
ADDRGP4 cg_TeamColors+16
ARGP4
ADDRLP4 128
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 132
CNSTI4 3
ASGNI4
ADDRLP4 128
INDIRI4
ADDRLP4 132
INDIRI4
EQI4 $1732
ADDRGP4 cgs+31456
INDIRI4
ADDRLP4 132
INDIRI4
LTI4 $1732
CNSTI4 1776
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 cgs+40960+1768
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1732
line 2408
;2408:					&& cgs.gametype >= GT_TEAM && !cgs.clientinfo[clientNum].localClient ) {
line 2409
;2409:						if ( strlen(cg_TeamColors.string) == 2 ) {
ADDRGP4 cg_TeamColors+16
ARGP4
ADDRLP4 136
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 2
NEI4 $1743
line 2410
;2410:							memcpy(color, g_color_table[ColorIndex(cg_TeamColors.string[1])], sizeof(color));
ADDRGP4 cg_TeamColors+16+1
INDIRI1
CVII4 1
ARGI4
ADDRLP4 140
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 92
ARGP4
ADDRLP4 140
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2411
;2411:						} else {
ADDRGP4 $1733
JUMPV
LABELV $1743
line 2412
;2412:							memcpy(color, g_color_table[ColorIndex(cg_TeamColors.string[4])], sizeof(color));
ADDRGP4 cg_TeamColors+16+4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 140
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 92
ARGP4
ADDRLP4 140
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2413
;2413:						}
line 2414
;2414:				} else if ( cgs.clientinfo[clientNum].team == cgs.clientinfo[ cg.clientNum ].team && strlen(cg_TeamColors.string) != 3
ADDRGP4 $1733
JUMPV
LABELV $1732
ADDRLP4 136
CNSTI4 1776
ASGNI4
ADDRLP4 136
INDIRI4
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
ADDRLP4 136
INDIRI4
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
NEI4 $1750
ADDRGP4 cg_TeamColors+16
ARGP4
ADDRLP4 140
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 144
CNSTI4 3
ASGNI4
ADDRLP4 140
INDIRI4
ADDRLP4 144
INDIRI4
EQI4 $1750
ADDRGP4 cgs+31456
INDIRI4
ADDRLP4 144
INDIRI4
LTI4 $1750
ADDRLP4 148
CNSTI4 0
ASGNI4
CNSTI4 1776
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 cgs+40960+1768
ADDP4
INDIRI4
ADDRLP4 148
INDIRI4
NEI4 $1750
ADDRGP4 cg_forceColors+12
INDIRI4
ADDRLP4 148
INDIRI4
EQI4 $1750
line 2415
;2415:					&& cgs.gametype >= GT_TEAM && !cgs.clientinfo[clientNum].localClient && cg_forceColors.integer ) {
line 2416
;2416:						memcpy(color, cgs.clientinfo[clientNum].color2, sizeof(color));
ADDRLP4 92
ARGP4
CNSTI4 1776
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 cgs+40960+112
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2417
;2417:				} else {
ADDRGP4 $1751
JUMPV
LABELV $1750
line 2418
;2418:					memcpy(color, cgs.clientinfo[clientNum].color2, sizeof(color));
ADDRLP4 92
ARGP4
CNSTI4 1776
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 cgs+40960+112
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2419
;2419:				}
LABELV $1751
LABELV $1733
LABELV $1706
line 2425
;2420:
;2421:		//color = cgs.clientinfo[clientNum].color2;
;2422:/*freeze*/
;2423://		color = cgs.clientinfo[ clientNum ].color1;
;2424://freeze
;2425:		CG_ImpactMark( mark, origin, dir, random()*360, color[0],color[1], color[2],1, alphaFade, radius, qfalse );
ADDRLP4 152
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
CNSTF4 1135869952
ADDRLP4 152
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ARGF4
ADDRLP4 92
INDIRF4
ARGF4
ADDRLP4 92+4
INDIRF4
ARGF4
ADDRLP4 92+8
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 24
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 CG_ImpactMark
CALLV
pop
line 2426
;2426:	} else {
ADDRGP4 $1704
JUMPV
LABELV $1703
line 2427
;2427:		CG_ImpactMark( mark, origin, dir, random()*360, 1,1,1,1, alphaFade, radius, qfalse );
ADDRLP4 92
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
CNSTF4 1135869952
ADDRLP4 92
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ARGF4
ADDRLP4 96
CNSTF4 1065353216
ASGNF4
ADDRLP4 96
INDIRF4
ARGF4
ADDRLP4 96
INDIRF4
ARGF4
ADDRLP4 96
INDIRF4
ARGF4
ADDRLP4 96
INDIRF4
ARGF4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 24
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 CG_ImpactMark
CALLV
pop
line 2428
;2428:	}
LABELV $1704
line 2429
;2429:}
LABELV $1591
endproc CG_MissileHitWall 156 44
export CG_MissileHitPlayer
proc CG_MissileHitPlayer 4 20
line 2437
;2430:
;2431:
;2432:/*
;2433:=================
;2434:CG_MissileHitPlayer
;2435:=================
;2436:*/
;2437:void CG_MissileHitPlayer( int weapon, vec3_t origin, vec3_t dir, int entityNum ) {
line 2438
;2438:	CG_Bleed( origin, entityNum );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_Bleed
CALLV
pop
line 2442
;2439:
;2440:	// some weapons will make an explosion with the blood, while
;2441:	// others will just make the blood
;2442:	switch ( weapon ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
EQI4 $1771
ADDRLP4 0
INDIRI4
CNSTI4 5
EQI4 $1771
ADDRGP4 $1770
JUMPV
LABELV $1771
line 2450
;2443:	case WP_GRENADE_LAUNCHER:
;2444:	case WP_ROCKET_LAUNCHER:
;2445:#ifdef MISSIONPACK
;2446:	case WP_NAILGUN:
;2447:	case WP_CHAINGUN:
;2448:	case WP_PROX_LAUNCHER:
;2449:#endif
;2450:		CG_MissileHitWall( weapon, 0, origin, dir, IMPACTSOUND_FLESH );
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 2451
;2451:		break;
line 2453
;2452:	default:
;2453:		break;
LABELV $1770
line 2455
;2454:	}
;2455:}
LABELV $1768
endproc CG_MissileHitPlayer 4 20
proc CG_ShotgunPellet 136 28
line 2472
;2456:
;2457:
;2458:
;2459:/*
;2460:============================================================================
;2461:
;2462:SHOTGUN TRACING
;2463:
;2464:============================================================================
;2465:*/
;2466:
;2467:/*
;2468:================
;2469:CG_ShotgunPellet
;2470:================
;2471:*/
;2472:static void CG_ShotgunPellet( vec3_t start, vec3_t end, int skipNum ) {
line 2476
;2473:	trace_t		tr;
;2474:	int sourceContentType, destContentType;
;2475:
;2476:	CG_Trace( &tr, start, NULL, NULL, end, skipNum, MASK_SHOT );
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 64
CNSTP4 0
ASGNP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 2478
;2477:
;2478:	sourceContentType = trap_CM_PointContents( start, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 68
ADDRGP4 trap_CM_PointContents
CALLI4
ASGNI4
ADDRLP4 56
ADDRLP4 68
INDIRI4
ASGNI4
line 2479
;2479:	destContentType = trap_CM_PointContents( tr.endpos, 0 );
ADDRLP4 0+12
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 72
ADDRGP4 trap_CM_PointContents
CALLI4
ASGNI4
ADDRLP4 60
ADDRLP4 72
INDIRI4
ASGNI4
line 2482
;2480:
;2481:	// FIXME: should probably move this cruft into CG_BubbleTrail
;2482:	if ( sourceContentType == destContentType ) {
ADDRLP4 56
INDIRI4
ADDRLP4 60
INDIRI4
NEI4 $1774
line 2483
;2483:		if ( cg_noProjectileTrail.integer ) {
ADDRGP4 cg_noProjectileTrail+12
INDIRI4
CNSTI4 0
EQI4 $1775
line 2484
;2484:			if ( sourceContentType & CONTENTS_WATER ) {
ADDRLP4 56
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $1775
line 2485
;2485:				CG_BubbleTrail( start, tr.endpos, 32 );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+12
ARGP4
CNSTF4 1107296256
ARGF4
ADDRGP4 CG_BubbleTrail
CALLV
pop
line 2486
;2486:			}
line 2487
;2487:		}
line 2488
;2488:	} else if ( sourceContentType & CONTENTS_WATER ) {
ADDRGP4 $1775
JUMPV
LABELV $1774
ADDRLP4 56
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $1782
line 2491
;2489:		trace_t trace;
;2490:
;2491:		trap_CM_BoxTrace( &trace, end, start, NULL, NULL, 0, CONTENTS_WATER );
ADDRLP4 76
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 132
CNSTP4 0
ASGNP4
ADDRLP4 132
INDIRP4
ARGP4
ADDRLP4 132
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 32
ARGI4
ADDRGP4 trap_CM_BoxTrace
CALLV
pop
line 2492
;2492:		CG_BubbleTrail( start, trace.endpos, 32 );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 76+12
ARGP4
CNSTF4 1107296256
ARGF4
ADDRGP4 CG_BubbleTrail
CALLV
pop
line 2493
;2493:	} else if ( destContentType & CONTENTS_WATER ) {
ADDRGP4 $1783
JUMPV
LABELV $1782
ADDRLP4 60
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $1785
line 2496
;2494:		trace_t trace;
;2495:
;2496:		trap_CM_BoxTrace( &trace, start, end, NULL, NULL, 0, CONTENTS_WATER );
ADDRLP4 76
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 132
CNSTP4 0
ASGNP4
ADDRLP4 132
INDIRP4
ARGP4
ADDRLP4 132
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 32
ARGI4
ADDRGP4 trap_CM_BoxTrace
CALLV
pop
line 2497
;2497:		CG_BubbleTrail( tr.endpos, trace.endpos, 32 );
ADDRLP4 0+12
ARGP4
ADDRLP4 76+12
ARGP4
CNSTF4 1107296256
ARGF4
ADDRGP4 CG_BubbleTrail
CALLV
pop
line 2498
;2498:	}
LABELV $1785
LABELV $1783
LABELV $1775
line 2500
;2499:
;2500:	if (  tr.surfaceFlags & SURF_NOIMPACT ) {
ADDRLP4 0+44
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1789
line 2501
;2501:		return;
ADDRGP4 $1772
JUMPV
LABELV $1789
line 2504
;2502:	}
;2503:
;2504:	if ( cg_entities[tr.entityNum].currentState.eType == ET_PLAYER ) {
CNSTI4 728
ADDRLP4 0+52
INDIRI4
MULI4
ADDRGP4 cg_entities+4
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1792
line 2505
;2505:		CG_MissileHitPlayer( WP_SHOTGUN, tr.endpos, tr.plane.normal, tr.entityNum );
CNSTI4 3
ARGI4
ADDRLP4 0+12
ARGP4
ADDRLP4 0+24
ARGP4
ADDRLP4 0+52
INDIRI4
ARGI4
ADDRGP4 CG_MissileHitPlayer
CALLV
pop
line 2506
;2506:	} else {
ADDRGP4 $1793
JUMPV
LABELV $1792
line 2507
;2507:		if ( tr.surfaceFlags & SURF_NOIMPACT ) {
ADDRLP4 0+44
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1799
line 2509
;2508:			// SURF_NOIMPACT will not make a flame puff or a mark
;2509:			return;
ADDRGP4 $1772
JUMPV
LABELV $1799
line 2511
;2510:		}
;2511:		if ( tr.surfaceFlags & SURF_METALSTEPS ) {
ADDRLP4 0+44
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $1802
line 2512
;2512:			CG_MissileHitWall( WP_SHOTGUN, 0, tr.endpos, tr.plane.normal, IMPACTSOUND_METAL );
CNSTI4 3
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0+12
ARGP4
ADDRLP4 0+24
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 2513
;2513:		} else {
ADDRGP4 $1803
JUMPV
LABELV $1802
line 2514
;2514:			CG_MissileHitWall( WP_SHOTGUN, 0, tr.endpos, tr.plane.normal, IMPACTSOUND_DEFAULT );
CNSTI4 3
ARGI4
ADDRLP4 76
CNSTI4 0
ASGNI4
ADDRLP4 76
INDIRI4
ARGI4
ADDRLP4 0+12
ARGP4
ADDRLP4 0+24
ARGP4
ADDRLP4 76
INDIRI4
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 2515
;2515:		}
LABELV $1803
line 2516
;2516:	}
LABELV $1793
line 2517
;2517:}
LABELV $1772
endproc CG_ShotgunPellet 136 28
export CG_ShotgunPattern
proc CG_ShotgunPattern 84 12
line 2529
;2518:
;2519:/*
;2520:================
;2521:CG_ShotgunPattern
;2522:
;2523:Perform the same traces the server did to locate the
;2524:hit splashes
;2525:================
;2526:*/
;2527://unlagged - attack prediction
;2528:// made this non-static for access from cg_unlagged.c
;2529:void CG_ShotgunPattern( vec3_t origin, vec3_t origin2, int seed, int otherEntNum ) {
line 2537
;2530:	int			i;
;2531:	float		r, u;
;2532:	vec3_t		end;
;2533:	vec3_t		forward, right, up;
;2534:
;2535:	// derive the right and up vectors from the forward vector, because
;2536:	// the client won't have any other information
;2537:	VectorNormalize2( origin2, forward );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 VectorNormalize2
CALLF4
pop
line 2538
;2538:	PerpendicularVector( right, forward );
ADDRLP4 32
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 PerpendicularVector
CALLV
pop
line 2539
;2539:	CrossProduct( forward, right, up );
ADDRLP4 20
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 44
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 2542
;2540:
;2541:	// generate the "random" spread pattern
;2542:	for ( i = 0 ; i < DEFAULT_SHOTGUN_COUNT ; i++ ) {
ADDRLP4 56
CNSTI4 0
ASGNI4
LABELV $1810
line 2543
;2543:		r = Q_crandom( &seed ) * DEFAULT_SHOTGUN_SPREAD * 16;
ADDRFP4 8
ARGP4
ADDRLP4 60
ADDRGP4 Q_crandom
CALLF4
ASGNF4
ADDRLP4 12
CNSTF4 1098907648
CNSTF4 1143930880
ADDRLP4 60
INDIRF4
MULF4
MULF4
ASGNF4
line 2544
;2544:		u = Q_crandom( &seed ) * DEFAULT_SHOTGUN_SPREAD * 16;
ADDRFP4 8
ARGP4
ADDRLP4 64
ADDRGP4 Q_crandom
CALLF4
ASGNF4
ADDRLP4 16
CNSTF4 1098907648
CNSTF4 1143930880
ADDRLP4 64
INDIRF4
MULF4
MULF4
ASGNF4
line 2548
;2545://	for ( i = 0 ; i < cpm_SSGcount ; i++ ) { // CPM
;2546://		r = crandom() * cpm_SSGspread;  // CPM
;2547://		u = crandom() * cpm_SSGspread;  // CPM
;2548:		VectorMA( origin, 8192 * 16, forward, end);
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
CNSTF4 1207959552
ASGNF4
ADDRLP4 0
ADDRLP4 68
INDIRP4
INDIRF4
ADDRLP4 72
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 68
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 72
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
line 2549
;2549:		VectorMA (end, r, right, end);
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
line 2550
;2550:		VectorMA (end, u, up, end);
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
line 2552
;2551:
;2552:		CG_ShotgunPellet( origin, end, otherEntNum );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_ShotgunPellet
CALLV
pop
line 2553
;2553:	}
LABELV $1811
line 2542
ADDRLP4 56
ADDRLP4 56
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 11
LTI4 $1810
line 2554
;2554:}
LABELV $1809
endproc CG_ShotgunPattern 84 12
export CG_ShotgunFire
proc CG_ShotgunFire 56 48
line 2561
;2555:
;2556:/*
;2557:==============
;2558:CG_ShotgunFire
;2559:==============
;2560:*/
;2561:void CG_ShotgunFire( entityState_t *es ) {
line 2565
;2562:	vec3_t	v;
;2563:	int		contents;
;2564:
;2565:	VectorSubtract( es->origin2, es->pos.trBase, v );
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
CNSTI4 104
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 16
INDIRP4
CNSTI4 108
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 20
INDIRP4
CNSTI4 112
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2566
;2566:	VectorNormalize( v );
ADDRLP4 0
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 2567
;2567:	VectorScale( v, 32, v );
ADDRLP4 24
CNSTF4 1107296256
ASGNF4
ADDRLP4 0
ADDRLP4 24
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 24
INDIRF4
ADDRLP4 0+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 0+8
CNSTF4 1107296256
ADDRLP4 0+8
INDIRF4
MULF4
ASGNF4
line 2568
;2568:	VectorAdd( es->pos.trBase, v, v );
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 28
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ASGNF4
line 2569
;2569:	if ( cgs.glconfig.hardwareType != GLHW_RAGEPRO ) {
ADDRGP4 cgs+20100+11288
INDIRI4
CNSTI4 3
EQI4 $1841
line 2573
;2570:		// ragepro can't alpha fade, so don't even bother with smoke
;2571:		vec3_t			up;
;2572:
;2573:		contents = trap_CM_PointContents( es->pos.trBase, 0 );
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 44
ADDRGP4 trap_CM_PointContents
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 44
INDIRI4
ASGNI4
line 2574
;2574:		if ( cg_smoke_SG.integer ) {
ADDRGP4 cg_smoke_SG+12
INDIRI4
CNSTI4 0
EQI4 $1845
line 2575
;2575:			if ( !( contents & CONTENTS_WATER ) ) {
ADDRLP4 12
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
NEI4 $1848
line 2576
;2576:				VectorSet( up, 0, 0, 8 );
ADDRLP4 48
CNSTF4 0
ASGNF4
ADDRLP4 32
ADDRLP4 48
INDIRF4
ASGNF4
ADDRLP4 32+4
ADDRLP4 48
INDIRF4
ASGNF4
ADDRLP4 32+8
CNSTF4 1090519040
ASGNF4
line 2577
;2577:				CG_SmokePuff( v, up, 32, 1, 1, 1, 0.33f, 900, cg.time, 0, LEF_PUFF_DONT_SCALE, cgs.media.shotgunSmokePuffShader );
ADDRLP4 0
ARGP4
ADDRLP4 32
ARGP4
CNSTF4 1107296256
ARGF4
ADDRLP4 52
CNSTF4 1065353216
ASGNF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 52
INDIRF4
ARGF4
CNSTF4 1051260355
ARGF4
CNSTF4 1147207680
ARGF4
ADDRGP4 cg+107604
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 cgs+156680+340
INDIRI4
ARGI4
ADDRGP4 CG_SmokePuff
CALLP4
pop
line 2578
;2578:			}
LABELV $1848
line 2579
;2579:		}
LABELV $1845
line 2580
;2580:	}
LABELV $1841
line 2581
;2581:	CG_ShotgunPattern( es->pos.trBase, es->origin2, es->eventParm, es->otherEntityNum );
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 104
ADDP4
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 32
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_ShotgunPattern
CALLV
pop
line 2582
;2582:}
LABELV $1830
endproc CG_ShotgunFire 56 48
export CG_Tracer
proc CG_Tracer 224 16
line 2598
;2583:
;2584:/*
;2585:============================================================================
;2586:
;2587:BULLETS
;2588:
;2589:============================================================================
;2590:*/
;2591:
;2592:
;2593:/*
;2594:===============
;2595:CG_Tracer
;2596:===============
;2597:*/
;2598:void CG_Tracer( vec3_t source, vec3_t dest ) {
line 2607
;2599:	vec3_t		forward, right;
;2600:	polyVert_t	verts[4];
;2601:	vec3_t		line;
;2602:	float		len, begin, end;
;2603:	vec3_t		start, finish;
;2604:	vec3_t		midpoint;
;2605:
;2606:	// tracer
;2607:	VectorSubtract( dest, source, forward );
ADDRLP4 180
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 184
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 108
ADDRLP4 180
INDIRP4
INDIRF4
ADDRLP4 184
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 188
CNSTI4 4
ASGNI4
ADDRLP4 108+4
ADDRLP4 180
INDIRP4
ADDRLP4 188
INDIRI4
ADDP4
INDIRF4
ADDRLP4 184
INDIRP4
ADDRLP4 188
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 192
CNSTI4 8
ASGNI4
ADDRLP4 108+8
ADDRFP4 4
INDIRP4
ADDRLP4 192
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 192
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2608
;2608:	len = VectorNormalize( forward );
ADDRLP4 108
ARGP4
ADDRLP4 196
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 164
ADDRLP4 196
INDIRF4
ASGNF4
line 2611
;2609:
;2610:	// start at least a little ways from the muzzle
;2611:	if ( len < 100 ) {
ADDRLP4 164
INDIRF4
CNSTF4 1120403456
GEF4 $1858
line 2612
;2612:		return;
ADDRGP4 $1855
JUMPV
LABELV $1858
line 2614
;2613:	}
;2614:	begin = 50 + random() * (len - 60);
ADDRLP4 200
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 160
ADDRLP4 200
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRLP4 164
INDIRF4
CNSTF4 1114636288
SUBF4
MULF4
CNSTF4 1112014848
ADDF4
ASGNF4
line 2615
;2615:	end = begin + cg_tracerLength.value;
ADDRLP4 156
ADDRLP4 160
INDIRF4
ADDRGP4 cg_tracerLength+8
INDIRF4
ADDF4
ASGNF4
line 2616
;2616:	if ( end > len ) {
ADDRLP4 156
INDIRF4
ADDRLP4 164
INDIRF4
LEF4 $1861
line 2617
;2617:		end = len;
ADDRLP4 156
ADDRLP4 164
INDIRF4
ASGNF4
line 2618
;2618:	}
LABELV $1861
line 2619
;2619:	VectorMA( source, begin, forward, start );
ADDRLP4 204
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 120
ADDRLP4 204
INDIRP4
INDIRF4
ADDRLP4 108
INDIRF4
ADDRLP4 160
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 120+4
ADDRLP4 204
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 108+4
INDIRF4
ADDRLP4 160
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 120+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 108+8
INDIRF4
ADDRLP4 160
INDIRF4
MULF4
ADDF4
ASGNF4
line 2620
;2620:	VectorMA( source, end, forward, finish );
ADDRLP4 212
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 132
ADDRLP4 212
INDIRP4
INDIRF4
ADDRLP4 108
INDIRF4
ADDRLP4 156
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 132+4
ADDRLP4 212
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 108+4
INDIRF4
ADDRLP4 156
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 132+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 108+8
INDIRF4
ADDRLP4 156
INDIRF4
MULF4
ADDF4
ASGNF4
line 2622
;2621:
;2622:	line[0] = DotProduct( forward, cg.refdef.viewaxis[1] );
ADDRLP4 144
ADDRLP4 108
INDIRF4
ADDRGP4 cg+109048+36+12
INDIRF4
MULF4
ADDRLP4 108+4
INDIRF4
ADDRGP4 cg+109048+36+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 108+8
INDIRF4
ADDRGP4 cg+109048+36+12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2623
;2623:	line[1] = DotProduct( forward, cg.refdef.viewaxis[2] );
ADDRLP4 144+4
ADDRLP4 108
INDIRF4
ADDRGP4 cg+109048+36+24
INDIRF4
MULF4
ADDRLP4 108+4
INDIRF4
ADDRGP4 cg+109048+36+24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 108+8
INDIRF4
ADDRGP4 cg+109048+36+24+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2625
;2624:
;2625:	VectorScale( cg.refdef.viewaxis[1], line[1], right );
ADDRLP4 96
ADDRGP4 cg+109048+36+12
INDIRF4
ADDRLP4 144+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 96+4
ADDRGP4 cg+109048+36+12+4
INDIRF4
ADDRLP4 144+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 96+8
ADDRGP4 cg+109048+36+12+8
INDIRF4
ADDRLP4 144+4
INDIRF4
MULF4
ASGNF4
line 2626
;2626:	VectorMA( right, -line[0], cg.refdef.viewaxis[2], right );
ADDRLP4 220
ADDRLP4 144
INDIRF4
NEGF4
ASGNF4
ADDRLP4 96
ADDRLP4 96
INDIRF4
ADDRGP4 cg+109048+36+24
INDIRF4
ADDRLP4 220
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 96+4
ADDRLP4 96+4
INDIRF4
ADDRGP4 cg+109048+36+24+4
INDIRF4
ADDRLP4 220
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 96+8
ADDRLP4 96+8
INDIRF4
ADDRGP4 cg+109048+36+24+8
INDIRF4
ADDRLP4 144
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 2627
;2627:	VectorNormalize( right );
ADDRLP4 96
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 2629
;2628:
;2629:	VectorMA( finish, cg_tracerWidth.value, right, verts[0].xyz );
ADDRLP4 0
ADDRLP4 132
INDIRF4
ADDRLP4 96
INDIRF4
ADDRGP4 cg_tracerWidth+8
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 132+4
INDIRF4
ADDRLP4 96+4
INDIRF4
ADDRGP4 cg_tracerWidth+8
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 132+8
INDIRF4
ADDRLP4 96+8
INDIRF4
ADDRGP4 cg_tracerWidth+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2630
;2630:	verts[0].st[0] = 0;
ADDRLP4 0+12
CNSTF4 0
ASGNF4
line 2631
;2631:	verts[0].st[1] = 1;
ADDRLP4 0+12+4
CNSTF4 1065353216
ASGNF4
line 2632
;2632:	verts[0].modulate[0] = 255;
ADDRLP4 0+20
CNSTU1 255
ASGNU1
line 2633
;2633:	verts[0].modulate[1] = 255;
ADDRLP4 0+20+1
CNSTU1 255
ASGNU1
line 2634
;2634:	verts[0].modulate[2] = 255;
ADDRLP4 0+20+2
CNSTU1 255
ASGNU1
line 2635
;2635:	verts[0].modulate[3] = 255;
ADDRLP4 0+20+3
CNSTU1 255
ASGNU1
line 2637
;2636:
;2637:	VectorMA( finish, -cg_tracerWidth.value, right, verts[1].xyz );
ADDRLP4 0+24
ADDRLP4 132
INDIRF4
ADDRLP4 96
INDIRF4
ADDRGP4 cg_tracerWidth+8
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+24+4
ADDRLP4 132+4
INDIRF4
ADDRLP4 96+4
INDIRF4
ADDRGP4 cg_tracerWidth+8
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+24+8
ADDRLP4 132+8
INDIRF4
ADDRLP4 96+8
INDIRF4
ADDRGP4 cg_tracerWidth+8
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 2638
;2638:	verts[1].st[0] = 1;
ADDRLP4 0+24+12
CNSTF4 1065353216
ASGNF4
line 2639
;2639:	verts[1].st[1] = 0;
ADDRLP4 0+24+12+4
CNSTF4 0
ASGNF4
line 2640
;2640:	verts[1].modulate[0] = 255;
ADDRLP4 0+24+20
CNSTU1 255
ASGNU1
line 2641
;2641:	verts[1].modulate[1] = 255;
ADDRLP4 0+24+20+1
CNSTU1 255
ASGNU1
line 2642
;2642:	verts[1].modulate[2] = 255;
ADDRLP4 0+24+20+2
CNSTU1 255
ASGNU1
line 2643
;2643:	verts[1].modulate[3] = 255;
ADDRLP4 0+24+20+3
CNSTU1 255
ASGNU1
line 2645
;2644:
;2645:	VectorMA( start, -cg_tracerWidth.value, right, verts[2].xyz );
ADDRLP4 0+48
ADDRLP4 120
INDIRF4
ADDRLP4 96
INDIRF4
ADDRGP4 cg_tracerWidth+8
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+48+4
ADDRLP4 120+4
INDIRF4
ADDRLP4 96+4
INDIRF4
ADDRGP4 cg_tracerWidth+8
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+48+8
ADDRLP4 120+8
INDIRF4
ADDRLP4 96+8
INDIRF4
ADDRGP4 cg_tracerWidth+8
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 2646
;2646:	verts[2].st[0] = 1;
ADDRLP4 0+48+12
CNSTF4 1065353216
ASGNF4
line 2647
;2647:	verts[2].st[1] = 1;
ADDRLP4 0+48+12+4
CNSTF4 1065353216
ASGNF4
line 2648
;2648:	verts[2].modulate[0] = 255;
ADDRLP4 0+48+20
CNSTU1 255
ASGNU1
line 2649
;2649:	verts[2].modulate[1] = 255;
ADDRLP4 0+48+20+1
CNSTU1 255
ASGNU1
line 2650
;2650:	verts[2].modulate[2] = 255;
ADDRLP4 0+48+20+2
CNSTU1 255
ASGNU1
line 2651
;2651:	verts[2].modulate[3] = 255;
ADDRLP4 0+48+20+3
CNSTU1 255
ASGNU1
line 2653
;2652:
;2653:	VectorMA( start, cg_tracerWidth.value, right, verts[3].xyz );
ADDRLP4 0+72
ADDRLP4 120
INDIRF4
ADDRLP4 96
INDIRF4
ADDRGP4 cg_tracerWidth+8
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+72+4
ADDRLP4 120+4
INDIRF4
ADDRLP4 96+4
INDIRF4
ADDRGP4 cg_tracerWidth+8
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+72+8
ADDRLP4 120+8
INDIRF4
ADDRLP4 96+8
INDIRF4
ADDRGP4 cg_tracerWidth+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2654
;2654:	verts[3].st[0] = 0;
ADDRLP4 0+72+12
CNSTF4 0
ASGNF4
line 2655
;2655:	verts[3].st[1] = 0;
ADDRLP4 0+72+12+4
CNSTF4 0
ASGNF4
line 2656
;2656:	verts[3].modulate[0] = 255;
ADDRLP4 0+72+20
CNSTU1 255
ASGNU1
line 2657
;2657:	verts[3].modulate[1] = 255;
ADDRLP4 0+72+20+1
CNSTU1 255
ASGNU1
line 2658
;2658:	verts[3].modulate[2] = 255;
ADDRLP4 0+72+20+2
CNSTU1 255
ASGNU1
line 2659
;2659:	verts[3].modulate[3] = 255;
ADDRLP4 0+72+20+3
CNSTU1 255
ASGNU1
line 2661
;2660:
;2661:	trap_R_AddPolyToScene( cgs.media.tracerShader, 4, verts );
ADDRGP4 cgs+156680+272
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddPolyToScene
CALLV
pop
line 2663
;2662:
;2663:	midpoint[0] = ( start[0] + finish[0] ) * 0.5;
ADDRLP4 168
CNSTF4 1056964608
ADDRLP4 120
INDIRF4
ADDRLP4 132
INDIRF4
ADDF4
MULF4
ASGNF4
line 2664
;2664:	midpoint[1] = ( start[1] + finish[1] ) * 0.5;
ADDRLP4 168+4
CNSTF4 1056964608
ADDRLP4 120+4
INDIRF4
ADDRLP4 132+4
INDIRF4
ADDF4
MULF4
ASGNF4
line 2665
;2665:	midpoint[2] = ( start[2] + finish[2] ) * 0.5;
ADDRLP4 168+8
CNSTF4 1056964608
ADDRLP4 120+8
INDIRF4
ADDRLP4 132+8
INDIRF4
ADDF4
MULF4
ASGNF4
line 2668
;2666:
;2667:	// add the tracer sound
;2668:	trap_S_StartSound( midpoint, ENTITYNUM_WORLD, CHAN_AUTO, cgs.media.tracerSound );
ADDRLP4 168
ARGP4
CNSTI4 1022
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+156680+608
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 2670
;2669:
;2670:}
LABELV $1855
endproc CG_Tracer 224 16
proc CG_CalcMuzzlePoint 40 16
line 2678
;2671:
;2672:
;2673:/*
;2674:======================
;2675:CG_CalcMuzzlePoint
;2676:======================
;2677:*/
;2678:static qboolean	CG_CalcMuzzlePoint( int entityNum, vec3_t muzzle ) {
line 2683
;2679:	vec3_t		forward;
;2680:	centity_t	*cent;
;2681:	int			anim;
;2682:
;2683:	if ( entityNum == cg.snap->ps.clientNum ) {
ADDRFP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $2043
line 2684
;2684:		VectorCopy( cg.snap->ps.origin, muzzle );
ADDRFP4 4
INDIRP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 64
ADDP4
INDIRB
ASGNB 12
line 2685
;2685:		muzzle[2] += cg.snap->ps.viewheight;
ADDRLP4 20
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRGP4 cg+36
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 2686
;2686:		AngleVectors( cg.snap->ps.viewangles, forward, NULL, NULL );
ADDRGP4 cg+36
INDIRP4
CNSTI4 196
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 24
CNSTP4 0
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 2687
;2687:		VectorMA( muzzle, 14, forward, muzzle );
ADDRLP4 28
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
CNSTF4 1096810496
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 32
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRF4
CNSTF4 1096810496
ADDRLP4 0+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 36
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRF4
CNSTF4 1096810496
ADDRLP4 0+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2688
;2688:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2042
JUMPV
LABELV $2043
line 2691
;2689:	}
;2690:
;2691:	cent = &cg_entities[entityNum];
ADDRLP4 12
CNSTI4 728
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 2692
;2692:	if ( !cent->currentValid ) {
ADDRLP4 12
INDIRP4
CNSTI4 420
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2051
line 2693
;2693:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2042
JUMPV
LABELV $2051
line 2696
;2694:	}
;2695:
;2696:	VectorCopy( cent->currentState.pos.trBase, muzzle );
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 2698
;2697:
;2698:	AngleVectors( cent->currentState.apos.trBase, forward, NULL, NULL );
ADDRLP4 12
INDIRP4
CNSTI4 60
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 20
CNSTP4 0
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 2699
;2699:	anim = cent->currentState.legsAnim & ~ANIM_TOGGLEBIT;
ADDRLP4 16
ADDRLP4 12
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 2700
;2700:	if ( anim == LEGS_WALKCR || anim == LEGS_IDLECR ) {
ADDRLP4 16
INDIRI4
CNSTI4 13
EQI4 $2055
ADDRLP4 16
INDIRI4
CNSTI4 23
NEI4 $2053
LABELV $2055
line 2701
;2701:		muzzle[2] += CROUCH_VIEWHEIGHT;
ADDRLP4 28
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
CNSTF4 1094713344
ADDF4
ASGNF4
line 2702
;2702:	} else {
ADDRGP4 $2054
JUMPV
LABELV $2053
line 2703
;2703:		muzzle[2] += DEFAULT_VIEWHEIGHT;
ADDRLP4 28
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
CNSTF4 1104150528
ADDF4
ASGNF4
line 2704
;2704:	}
LABELV $2054
line 2706
;2705:
;2706:	VectorMA( muzzle, 14, forward, muzzle );
ADDRLP4 28
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
CNSTF4 1096810496
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 32
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRF4
CNSTF4 1096810496
ADDRLP4 0+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 36
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRF4
CNSTF4 1096810496
ADDRLP4 0+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2708
;2707:
;2708:	return qtrue;
CNSTI4 1
RETI4
LABELV $2042
endproc CG_CalcMuzzlePoint 40 16
export CG_Bullet
proc CG_Bullet 96 28
line 2719
;2709:
;2710:}
;2711:
;2712:/*
;2713:======================
;2714:CG_Bullet
;2715:
;2716:Renders bullet effects.
;2717:======================
;2718:*/
;2719:void CG_Bullet( vec3_t end, int sourceEntityNum, vec3_t normal, qboolean flesh, int fleshEntityNum ) {
line 2726
;2720:	trace_t trace;
;2721:	int sourceContentType, destContentType;
;2722:	vec3_t		start;
;2723:
;2724:	// if the shooter is currently valid, calc a source point and possibly
;2725:	// do trail effects
;2726:	if ( sourceEntityNum >= 0 && cg_tracerChance.value > 0 ) {
ADDRFP4 4
INDIRI4
CNSTI4 0
LTI4 $2059
ADDRGP4 cg_tracerChance+8
INDIRF4
CNSTF4 0
LEF4 $2059
line 2727
;2727:		if ( CG_CalcMuzzlePoint( sourceEntityNum, start ) ) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 76
ADDRGP4 CG_CalcMuzzlePoint
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
EQI4 $2062
line 2728
;2728:			sourceContentType = trap_CM_PointContents( start, 0 );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 80
ADDRGP4 trap_CM_PointContents
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 80
INDIRI4
ASGNI4
line 2729
;2729:			destContentType = trap_CM_PointContents( end, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 84
ADDRGP4 trap_CM_PointContents
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 84
INDIRI4
ASGNI4
line 2732
;2730:
;2731:			// do a complete bubble trail if necessary
;2732:			if ( ( sourceContentType == destContentType ) && ( sourceContentType & CONTENTS_WATER ) ) {
ADDRLP4 88
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 88
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $2064
ADDRLP4 88
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $2064
line 2733
;2733:				CG_BubbleTrail( start, end, 32 );
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTF4 1107296256
ARGF4
ADDRGP4 CG_BubbleTrail
CALLV
pop
line 2734
;2734:			}
ADDRGP4 $2065
JUMPV
LABELV $2064
line 2736
;2735:			// bubble trail from water into air
;2736:			else if ( ( sourceContentType & CONTENTS_WATER ) ) {
ADDRLP4 12
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $2066
line 2737
;2737:				trap_CM_BoxTrace( &trace, end, start, NULL, NULL, 0, CONTENTS_WATER );
ADDRLP4 20
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
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
CNSTI4 0
ARGI4
CNSTI4 32
ARGI4
ADDRGP4 trap_CM_BoxTrace
CALLV
pop
line 2738
;2738:				CG_BubbleTrail( start, trace.endpos, 32 );
ADDRLP4 0
ARGP4
ADDRLP4 20+12
ARGP4
CNSTF4 1107296256
ARGF4
ADDRGP4 CG_BubbleTrail
CALLV
pop
line 2739
;2739:			}
ADDRGP4 $2067
JUMPV
LABELV $2066
line 2741
;2740:			// bubble trail from air into water
;2741:			else if ( ( destContentType & CONTENTS_WATER ) ) {
ADDRLP4 16
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $2069
line 2742
;2742:				trap_CM_BoxTrace( &trace, start, end, NULL, NULL, 0, CONTENTS_WATER );
ADDRLP4 20
ARGP4
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
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
CNSTI4 0
ARGI4
CNSTI4 32
ARGI4
ADDRGP4 trap_CM_BoxTrace
CALLV
pop
line 2743
;2743:				CG_BubbleTrail( trace.endpos, end, 32 );
ADDRLP4 20+12
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTF4 1107296256
ARGF4
ADDRGP4 CG_BubbleTrail
CALLV
pop
line 2744
;2744:			}
LABELV $2069
LABELV $2067
LABELV $2065
line 2747
;2745:
;2746:			// draw a tracer
;2747:			if ( random() < cg_tracerChance.value ) {
ADDRLP4 92
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
ADDRGP4 cg_tracerChance+8
INDIRF4
GEF4 $2072
line 2748
;2748:				CG_Tracer( start, end );
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Tracer
CALLV
pop
line 2749
;2749:			}
LABELV $2072
line 2750
;2750:		}
LABELV $2062
line 2751
;2751:	}
LABELV $2059
line 2754
;2752:
;2753:	// impact splash and mark
;2754:	if ( flesh ) {
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $2075
line 2755
;2755:		CG_Bleed( end, fleshEntityNum );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 CG_Bleed
CALLV
pop
line 2756
;2756:	} else {
ADDRGP4 $2076
JUMPV
LABELV $2075
line 2757
;2757:		CG_MissileHitWall( WP_MACHINEGUN, 0, end, normal, IMPACTSOUND_DEFAULT );
CNSTI4 2
ARGI4
ADDRLP4 76
CNSTI4 0
ASGNI4
ADDRLP4 76
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 76
INDIRI4
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 2758
;2758:	}
LABELV $2076
line 2760
;2759:
;2760:}
LABELV $2058
endproc CG_Bullet 96 28
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
LABELV $1636
byte 1 101
byte 1 120
byte 1 112
byte 1 108
byte 1 111
byte 1 100
byte 1 101
byte 1 49
byte 1 0
align 1
LABELV $1561
byte 1 67
byte 1 71
byte 1 95
byte 1 70
byte 1 105
byte 1 114
byte 1 101
byte 1 87
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 45
byte 1 62
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 62
byte 1 61
byte 1 32
byte 1 87
byte 1 80
byte 1 95
byte 1 78
byte 1 85
byte 1 77
byte 1 95
byte 1 87
byte 1 69
byte 1 65
byte 1 80
byte 1 79
byte 1 78
byte 1 83
byte 1 0
align 1
LABELV $1266
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
LABELV $1229
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
LABELV $1219
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
LABELV $1008
byte 1 67
byte 1 71
byte 1 95
byte 1 82
byte 1 101
byte 1 103
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 86
byte 1 105
byte 1 115
byte 1 117
byte 1 97
byte 1 108
byte 1 115
byte 1 58
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 78
byte 1 117
byte 1 109
byte 1 32
byte 1 37
byte 1 100
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
byte 1 32
byte 1 91
byte 1 48
byte 1 45
byte 1 37
byte 1 100
byte 1 93
byte 1 0
align 1
LABELV $1001
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
byte 1 102
byte 1 103
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1000
byte 1 98
byte 1 102
byte 1 103
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
LABELV $997
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
byte 1 98
byte 1 102
byte 1 103
byte 1 47
byte 1 98
byte 1 102
byte 1 103
byte 1 95
byte 1 102
byte 1 105
byte 1 114
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $996
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
byte 1 98
byte 1 102
byte 1 103
byte 1 47
byte 1 98
byte 1 102
byte 1 103
byte 1 95
byte 1 104
byte 1 117
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $994
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 67
byte 1 111
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $989
byte 1 114
byte 1 97
byte 1 105
byte 1 108
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
LABELV $986
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
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 47
byte 1 114
byte 1 103
byte 1 95
byte 1 104
byte 1 117
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $983
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 68
byte 1 105
byte 1 115
byte 1 99
byte 1 0
align 1
LABELV $980
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
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
LABELV $977
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
byte 1 104
byte 1 121
byte 1 112
byte 1 114
byte 1 98
byte 1 102
byte 1 49
byte 1 97
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
byte 1 108
byte 1 97
byte 1 115
byte 1 102
byte 1 108
byte 1 121
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $974
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
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
LABELV $971
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
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 108
byte 1 102
byte 1 49
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $969
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 47
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 49
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $967
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
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
byte 1 102
byte 1 49
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $962
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
byte 1 102
byte 1 108
byte 1 121
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $960
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
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 47
byte 1 115
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 102
byte 1 49
byte 1 98
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $958
byte 1 98
byte 1 117
byte 1 108
byte 1 108
byte 1 101
byte 1 116
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
LABELV $955
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
byte 1 109
byte 1 97
byte 1 99
byte 1 104
byte 1 103
byte 1 102
byte 1 52
byte 1 98
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $954
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
byte 1 109
byte 1 97
byte 1 99
byte 1 104
byte 1 103
byte 1 102
byte 1 51
byte 1 98
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $953
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
byte 1 109
byte 1 97
byte 1 99
byte 1 104
byte 1 103
byte 1 102
byte 1 50
byte 1 98
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
byte 1 109
byte 1 97
byte 1 99
byte 1 104
byte 1 103
byte 1 102
byte 1 49
byte 1 98
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $950
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 97
byte 1 109
byte 1 109
byte 1 111
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
byte 1 101
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $946
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
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 47
byte 1 108
byte 1 103
byte 1 95
byte 1 104
byte 1 105
byte 1 116
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $943
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
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 47
byte 1 108
byte 1 103
byte 1 95
byte 1 104
byte 1 105
byte 1 116
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $940
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
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 47
byte 1 108
byte 1 103
byte 1 95
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $937
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
byte 1 99
byte 1 114
byte 1 97
byte 1 99
byte 1 107
byte 1 108
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $934
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 66
byte 1 111
byte 1 108
byte 1 116
byte 1 78
byte 1 101
byte 1 119
byte 1 0
align 1
LABELV $931
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
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 47
byte 1 108
byte 1 103
byte 1 95
byte 1 102
byte 1 105
byte 1 114
byte 1 101
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
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 47
byte 1 108
byte 1 103
byte 1 95
byte 1 104
byte 1 117
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $929
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
byte 1 104
byte 1 117
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $927
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
byte 1 97
byte 1 116
byte 1 99
byte 1 107
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
LABELV $922
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
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 47
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 95
byte 1 104
byte 1 97
byte 1 110
byte 1 100
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $919
byte 1 95
byte 1 104
byte 1 97
byte 1 110
byte 1 100
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $918
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
align 1
LABELV $917
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
LABELV $903
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
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 37
byte 1 105
byte 1 0
