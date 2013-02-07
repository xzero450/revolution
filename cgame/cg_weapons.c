// Copyright (C) 1999-2000 Id Software, Inc.
//
// cg_weapons.c -- events and effects dealing with weapons
#include "cg_local.h"
#include "..\game\bg_promode.h" // CPM


//void CG_CreateAimtype4FireCmd( void )
//{
//	static int	theTime;
//
//	if (cg_aimType.integer == 4)
//	{
//		if (cg.predictedPlayerState.weapon == WP_MACHINEGUN ||
//			cg.predictedPlayerState.weapon == WP_SHOTGUN ||
//			cg.predictedPlayerState.weapon == WP_LIGHTNING ||
//			cg.predictedPlayerState.weapon == WP_RAILGUN )
//		{
//			if (theTime != cg.oldTime)
//			{
//				byte		buffer1[1024] = {0};
//				byte		buffer2[1024] = {0};
//				int			buffer3[1024] = {0};
//				char		buffer4[1024] = {0};
////				byte		tmpByte;
////				byte		*ptr;
//				int			i, j, count, total;
//
//
//				//Com_Printf(va("C: %i %i %i %f %f %f %f %f %f\n", cg.rawPacket.clientsHit[0], cg.rawPacket.clientsHit[1], cg.rawPacket.attackTime, cg.rawPacket.origin[0], cg.rawPacket.origin[1], cg.rawPacket.origin[2], cg.rawPacket.viewAngles[0], cg.rawPacket.viewAngles[1], cg.rawPacket.viewAngles[2]));
//				
//
//
//				memcpy(&(buffer1[0]), &cg.rawPacket, sizeof(aimtype4packet_t));
//
//
//				/** /
//				// Start debug message
//				memset(&buffer4,0,sizeof(buffer4));
//				count = 0;
//				for (i = 0; i < sizeof(aimtype4packet_t); i++)
//				{
//					for ( j = 7; j >= 0; j-- )
//					{
//						buffer4[count] = ((buffer1[i] & (1 << j)) ? '1' : '0');
//						count++;
//					}
//					buffer4[count] = ' ';
//					count++;
//				}
//				Com_Printf("Client:  %s\n", buffer4);
//				// End debug message
//				/**/
//
//
//
//				count = 0;
//				for (i = 0; i < sizeof(aimtype4packet_t); i++)
//				{
//					// for the first 11 bytes, we don't care about the 7th and 8th bit anyway, so just overwrite them with a 01
//					if (i<DEFAULT_SHOTGUN_COUNT)
//					{
//						buffer2[i] = buffer1[i] | (1 << 6);
//					}
//					else
//					{
//						// now lets copy all the bits out of the remaining structure
//						for ( j = 7; j >= 0; j-- )
//						{
//							buffer3[count] = ((buffer1[i] & (1 << j)) ? 1 : 0);
//							count++;
//						}
//					}
//				}
//
//				
//
//
//
//				total = count;
//
//				j = DEFAULT_SHOTGUN_COUNT;
//				count = 7;
//				buffer2[j] = buffer2[j] | (0 << count);
//				count--;
//				buffer2[j] = buffer2[j] | (1 << count);
//				count--;
//				for (i = 0; i < total; i++)
//				{
//					buffer2[j] = buffer2[j] | (buffer3[i] << count);
//					count--;
//					if (count < 0)
//					{
//						count = 7;
//						buffer2[j] = buffer2[j] | (0 << count);
//						count--;
//						buffer2[j] = buffer2[j] | (1 << count);
//						count--;
//						j++;
//					}
//				}
//
//				/** /
//				// Start debug message
//				memset(&buffer4,0,sizeof(buffer4));
//				count = 0;
//				for (i = 0; buffer2[i]; i++)
//				{
//					for ( j = 7; j >= 0; j-- )
//					{
//						buffer4[count] = ((buffer2[i] & (1 << j)) ? '1' : '0');
//						count++;
//					}
//					buffer4[count] = ' ';
//					count++;
//				}
//				Com_Printf("After: %s\n", buffer4);
//				// End debug message
//				/**/
//
//
//				//Com_Printf(va("Client Raw: %s\n", buffer2));
//
//				trap_SendClientCommand(va("f %s\n", buffer2));
//				
//				// old command
//				//trap_SendClientCommand(va("fcmd %i %i %f %f %f %f %f %f\n", cg.oldTime, cg.clientsHit, cgs.savedMuzzle[0], cgs.savedMuzzle[1], cgs.savedMuzzle[2], cgs.savedViewAngles[0], cgs.savedViewAngles[1], cgs.savedViewAngles[2]));
//				
//				//Com_Printf(va("C: %i %i %f %f %f %f %f %f\n", cg.oldTime, cg.clientsHit, cgs.savedMuzzle[0], cgs.savedMuzzle[1], cgs.savedMuzzle[2], cgs.savedViewAngles[0], cgs.savedViewAngles[1], cgs.savedViewAngles[2]));
//				theTime = cg.oldTime;
//			}
//		}
//	}
//
//}


/*
==========================
CG_MachineGunEjectBrass
==========================
*/
static void CG_MachineGunEjectBrass( centity_t *cent ) {
	localEntity_t	*le;
	refEntity_t		*re;
	vec3_t			velocity, xvelocity;
	vec3_t			offset, xoffset;
	float			waterScale = 1.0f;
	vec3_t			v[3];

	if ( cg_brassTime.integer <= 0 ) {
		return;
	}

	le = CG_AllocLocalEntity();
	re = &le->refEntity;

	velocity[0] = 0;
	velocity[1] = -50 + 40 * crandom();
	velocity[2] = 100 + 50 * crandom();

	le->leType = LE_FRAGMENT;
	le->startTime = cg.time;
	le->endTime = le->startTime + cg_brassTime.integer + ( cg_brassTime.integer / 4 ) * random();

	le->pos.trType = TR_GRAVITY;
	le->pos.trTime = cg.time - (rand()&15);

	AnglesToAxis( cent->lerpAngles, v );

	offset[0] = 8;
	offset[1] = -4;
	offset[2] = 24;

	xoffset[0] = offset[0] * v[0][0] + offset[1] * v[1][0] + offset[2] * v[2][0];
	xoffset[1] = offset[0] * v[0][1] + offset[1] * v[1][1] + offset[2] * v[2][1];
	xoffset[2] = offset[0] * v[0][2] + offset[1] * v[1][2] + offset[2] * v[2][2];
	VectorAdd( cent->lerpOrigin, xoffset, re->origin );

	VectorCopy( re->origin, le->pos.trBase );

	if ( CG_PointContents( re->origin, -1 ) & CONTENTS_WATER ) {
		waterScale = 0.10f;
	}

	xvelocity[0] = velocity[0] * v[0][0] + velocity[1] * v[1][0] + velocity[2] * v[2][0];
	xvelocity[1] = velocity[0] * v[0][1] + velocity[1] * v[1][1] + velocity[2] * v[2][1];
	xvelocity[2] = velocity[0] * v[0][2] + velocity[1] * v[1][2] + velocity[2] * v[2][2];
	VectorScale( xvelocity, waterScale, le->pos.trDelta );

	AxisCopy( axisDefault, re->axis );
	re->hModel = cgs.media.machinegunBrassModel;

	le->bounceFactor = 0.4 * waterScale;

	le->angles.trType = TR_LINEAR;
	le->angles.trTime = cg.time;
	le->angles.trBase[0] = rand()&31;
	le->angles.trBase[1] = rand()&31;
	le->angles.trBase[2] = rand()&31;
	le->angles.trDelta[0] = 2;
	le->angles.trDelta[1] = 1;
	le->angles.trDelta[2] = 0;

	le->leFlags = LEF_TUMBLE;
	le->leBounceSoundType = LEBS_BRASS;
	le->leMarkType = LEMT_NONE;
}

/*
==========================
CG_ShotgunEjectBrass
==========================
*/
static void CG_ShotgunEjectBrass( centity_t *cent ) {
	localEntity_t	*le;
	refEntity_t		*re;
	vec3_t			velocity, xvelocity;
	vec3_t			offset, xoffset;
	vec3_t			v[3];
	int				i;

	if ( cg_brassTime.integer <= 0 ) {
		return;
	}

	for ( i = 0; i < 2; i++ ) {
		float	waterScale = 1.0f;

		le = CG_AllocLocalEntity();
		re = &le->refEntity;

		velocity[0] = 60 + 60 * crandom();
		if ( i == 0 ) {
			velocity[1] = 40 + 10 * crandom();
		} else {
			velocity[1] = -40 + 10 * crandom();
		}
		velocity[2] = 100 + 50 * crandom();

		le->leType = LE_FRAGMENT;
		le->startTime = cg.time;
		le->endTime = le->startTime + cg_brassTime.integer*3 + cg_brassTime.integer * random();

		le->pos.trType = TR_GRAVITY;
		le->pos.trTime = cg.time;

		AnglesToAxis( cent->lerpAngles, v );

		offset[0] = 8;
		offset[1] = 0;
		offset[2] = 24;

		xoffset[0] = offset[0] * v[0][0] + offset[1] * v[1][0] + offset[2] * v[2][0];
		xoffset[1] = offset[0] * v[0][1] + offset[1] * v[1][1] + offset[2] * v[2][1];
		xoffset[2] = offset[0] * v[0][2] + offset[1] * v[1][2] + offset[2] * v[2][2];
		VectorAdd( cent->lerpOrigin, xoffset, re->origin );
		VectorCopy( re->origin, le->pos.trBase );
		if ( CG_PointContents( re->origin, -1 ) & CONTENTS_WATER ) {
			waterScale = 0.10f;
		}

		xvelocity[0] = velocity[0] * v[0][0] + velocity[1] * v[1][0] + velocity[2] * v[2][0];
		xvelocity[1] = velocity[0] * v[0][1] + velocity[1] * v[1][1] + velocity[2] * v[2][1];
		xvelocity[2] = velocity[0] * v[0][2] + velocity[1] * v[1][2] + velocity[2] * v[2][2];
		VectorScale( xvelocity, waterScale, le->pos.trDelta );

		AxisCopy( axisDefault, re->axis );
		re->hModel = cgs.media.shotgunBrassModel;
		le->bounceFactor = 0.3f;

		le->angles.trType = TR_LINEAR;
		le->angles.trTime = cg.time;
		le->angles.trBase[0] = rand()&31;
		le->angles.trBase[1] = rand()&31;
		le->angles.trBase[2] = rand()&31;
		le->angles.trDelta[0] = 1;
		le->angles.trDelta[1] = 0.5;
		le->angles.trDelta[2] = 0;

		le->leFlags = LEF_TUMBLE;
		le->leBounceSoundType = LEBS_BRASS;
		le->leMarkType = LEMT_NONE;
	}
}


#ifdef MISSIONPACK
/*
==========================
CG_NailgunEjectBrass
==========================
*/
static void CG_NailgunEjectBrass( centity_t *cent ) {
	localEntity_t	*smoke;
	vec3_t			origin;
	vec3_t			v[3];
	vec3_t			offset;
	vec3_t			xoffset;
	vec3_t			up;

	AnglesToAxis( cent->lerpAngles, v );

	offset[0] = 0;
	offset[1] = -12;
	offset[2] = 24;

	xoffset[0] = offset[0] * v[0][0] + offset[1] * v[1][0] + offset[2] * v[2][0];
	xoffset[1] = offset[0] * v[0][1] + offset[1] * v[1][1] + offset[2] * v[2][1];
	xoffset[2] = offset[0] * v[0][2] + offset[1] * v[1][2] + offset[2] * v[2][2];
	VectorAdd( cent->lerpOrigin, xoffset, origin );

	VectorSet( up, 0, 0, 64 );

	smoke = CG_SmokePuff( origin, up, 32, 1, 1, 1, 0.33f, 700, cg.time, 0, 0, cgs.media.smokePuffShader );
	// use the optimized local entity add
	smoke->leType = LE_SCALE_FADE;
}
#endif

/*
==========================
CG_DottedRailTrail
==========================
*/
void CG_DottedRailTrail (clientInfo_t *ci, vec3_t start, vec3_t end, float len) {
	vec3_t axis[36], move, move2, vec;
	int    i, j, skip;
 
	localEntity_t *le;
	refEntity_t   *re;

	VectorCopy (start, move);
	VectorSubtract (end, start, vec);
	VectorNormalize (vec);

	//Dotted core
	skip = 0;
	j = 18;
	for (i = 0; i < len; i++) {
		if ( skip < i ) {
			skip += 25;
			le = CG_AllocLocalEntity();
			re = &le->refEntity;
			le->leFlags = LEF_PUFF_DONT_SCALE;
			le->leType = LE_MOVE_SCALE_FADE;
			le->startTime = cg.time;
			le->endTime = (cg.time - 275) + cg_railTrailTime.integer;
			le->lifeRate = 1.0 / (le->endTime - le->startTime);

			re->shaderTime = cg.time / 1000.0f;
			re->reType = RT_SPRITE;
			re->radius = 1.5f;
			re->customShader = cgs.media.railRingsShader;

				if ( (ci->team != cgs.clientinfo[ cg.clientNum ].team && (strlen(cg_EnemyColors.string) == 2 || strlen(cg_EnemyColors.string) == 5)
					&& cgs.gametype >= GT_TEAM && cgs.clientinfo[cg.clientNum].team != TEAM_SPECTATOR) 
					|| ( cgs.gametype < GT_TEAM && !ci->localClient && (strlen(cg_EnemyColors.string) == 2 || strlen(cg_EnemyColors.string) == 5) ) ) {
					re->shaderRGBA[0] = cgs.enemyColors[4][0];
					re->shaderRGBA[1] = cgs.enemyColors[4][1];
					re->shaderRGBA[2] = cgs.enemyColors[4][2];
					re->shaderRGBA[3] = 255;
				} else if ( ci->team == cgs.clientinfo[ cg.clientNum ].team && cg_forceColors.integer && cgs.gametype >= GT_TEAM ) {
					re->shaderRGBA[0] = cgs.clientinfo[cg.clientNum].color2[0];
					re->shaderRGBA[1] = cgs.clientinfo[cg.clientNum].color2[1];
					re->shaderRGBA[2] = cgs.clientinfo[cg.clientNum].color2[2];
					re->shaderRGBA[3] = 255;
				} else if ( ci->team == cgs.clientinfo[ cg.clientNum ].team && strlen(cg_TeamColors.string) != 3
					&& cgs.gametype >= GT_TEAM && !ci->localClient ) {
					re->shaderRGBA[0] = cgs.teamColors[4][0];
					re->shaderRGBA[1] = cgs.teamColors[4][1];
					re->shaderRGBA[2] = cgs.teamColors[4][2];
					re->shaderRGBA[3] = 255;
				} else {
					re->shaderRGBA[0] = ci->color2[0] * 255;
					re->shaderRGBA[1] = ci->color2[1] * 255;
					re->shaderRGBA[2] = ci->color2[2] * 255;
					re->shaderRGBA[3] = 255;
				}

				if ( (ci->team != cgs.clientinfo[ cg.clientNum ].team && 
					( strlen(cg_EnemyColors.string) == 2 || strlen(cg_EnemyColors.string) == 5 ) 
					&& cgs.gametype >= GT_TEAM && cgs.clientinfo[cg.clientNum].team != TEAM_SPECTATOR) || 
					( cgs.gametype < GT_TEAM && !ci->localClient && (strlen(cg_EnemyColors.string) == 2 || strlen(cg_EnemyColors.string) == 5) )) {
							le->color[0] = g_color_table[ColorIndex(cg_EnemyColors.string[4])][0] * 0.75;
							le->color[1] = g_color_table[ColorIndex(cg_EnemyColors.string[4])][1] * 0.75;
							le->color[2] = g_color_table[ColorIndex(cg_EnemyColors.string[4])][2] * 0.75;
							le->color[3] = 1.0f;
				} else if ( ci->team == cgs.clientinfo[ cg.clientNum ].team && cg_forceColors.integer && cgs.gametype >= GT_TEAM ) {
							le->color[0] = cgs.clientinfo[cg.clientNum].color2[0] * 0.75;
							le->color[1] = cgs.clientinfo[cg.clientNum].color2[1] * 0.75;
							le->color[2] = cgs.clientinfo[cg.clientNum].color2[2] * 0.75;
							le->color[3] = 1.0f;
				} else if ( ci->team == cgs.clientinfo[ cg.clientNum ].team && 
					( strlen(cg_TeamColors.string) == 2 || strlen(cg_TeamColors.string) >= 5 
					&& cgs.gametype >= GT_TEAM && !ci->localClient) ) {
							le->color[0] = g_color_table[ColorIndex(cg_TeamColors.string[4])][0] * 0.75;
							le->color[1] = g_color_table[ColorIndex(cg_TeamColors.string[4])][1] * 0.75;
							le->color[2] = g_color_table[ColorIndex(cg_TeamColors.string[4])][2] * 0.75;
							le->color[3] = 1.0f;
				} else {
					le->color[0] = ci->color2[0] * 0.75;
					le->color[1] = ci->color2[1] * 0.75;
					le->color[2] = ci->color2[2] * 0.75;
					le->color[3] = 1.0f;
				}

			le->pos.trType = TR_LINEAR;
			le->pos.trTime = cg.time;

			VectorCopy( move, move2);
			VectorMA(move2, 0, axis[j], move2);
			VectorCopy(move2, le->pos.trBase);

			le->pos.trDelta[0] = axis[j][0]*0;
			le->pos.trDelta[1] = axis[j][1]*0;
			le->pos.trDelta[2] = axis[j][2]*0;
		}

		VectorAdd (move, vec, move);

		j = j + 1 < 36 ? j + 1 : (j + 1) % 36;
	}
}

/*********************************************************************************
				PM Skin / Colors / Forcing rail colors

		This next section of code is the railTrail drawing code, was setup to be
	able to be like CPMA's cg_railStyle with the addition of an OSP like railTrail.
	The forceColors code is somewhat self-explanatory if you know how color1 and
	color2 effect the railTrail color. Not much different than any other refEntity.
	It's cumbersome for sure, a lot messy too, the results are nice though.

*********************************************************************************/

/*
==========================
CG_RailTrail
==========================
*/
void CG_RailTrail (clientInfo_t *ci, vec3_t start, vec3_t end) {
	vec3_t axis[36], move, move2, next_move, vec, temp;
	float  len;
	int    i, j, skip;
 
	localEntity_t *le;
	refEntity_t   *re;
	len = 0;
 
#define RADIUS   4
#define ROTATION 1
#define SPACING  5

	if ( !cg_railStyle.integer ) {
		return;
	}

	start[2] -= 4;
	VectorCopy (start, move);
	VectorSubtract (end, start, vec);
	len = VectorNormalize (vec);

	if ( cg_railStyle.integer ==  4 || cg_railStyle.integer > 5 ) {
		CG_DottedRailTrail( ci, start, end, len);
	}
	
	if ( cg_railStyle.integer == 1 || cg_railStyle.integer == 3 || cg_railStyle.integer == 5 || cg_railStyle.integer >= 7 ) {
		PerpendicularVector(temp, vec);
		for (i = 0 ; i < 36; i++) {
			RotatePointAroundVector(axis[i], vec, temp, i * 10);//banshee 2.4 was 10
		}
 
		le = CG_AllocLocalEntity();
		re = &le->refEntity;
 
		le->leType = LE_FADE_RGB;
		le->startTime = cg.time;
		le->endTime = cg.time + cg_railTrailTime.value;
		le->lifeRate = 1.0 / (le->endTime - le->startTime);
 
		re->shaderTime = cg.time / 1000.0f;
		re->reType = RT_RAIL_CORE;
		re->customShader = cgs.media.railCoreShader;
 
		VectorCopy(start, re->origin);
		VectorCopy(end, re->oldorigin);
 
		//
		//Color1
		//
			if ( (ci->team != cgs.clientinfo[ cg.clientNum ].team && (strlen(cg_EnemyColors.string) == 2 || strlen(cg_EnemyColors.string) == 5)
				&& cgs.gametype >= GT_TEAM && cgs.clientinfo[cg.clientNum].team != TEAM_SPECTATOR) || 
				( cgs.gametype < GT_TEAM && !ci->localClient && (strlen(cg_EnemyColors.string) == 2 || strlen(cg_EnemyColors.string) == 5) ) ) {
				re->shaderRGBA[0] = cgs.enemyColors[0][0];
				re->shaderRGBA[1] = cgs.enemyColors[0][1];
				re->shaderRGBA[2] = cgs.enemyColors[0][2];
				re->shaderRGBA[3] = 255;
			} else if ( ci->team == cgs.clientinfo[ cg.clientNum ].team && cg_forceColors.integer && cgs.gametype >= GT_TEAM ) {
				re->shaderRGBA[0] = cgs.clientinfo[cg.clientNum].color1[0];
				re->shaderRGBA[1] = cgs.clientinfo[cg.clientNum].color1[1];
				re->shaderRGBA[2] = cgs.clientinfo[cg.clientNum].color1[2];
				re->shaderRGBA[3] = 255;
			} else if ( ci->team == cgs.clientinfo[ cg.clientNum ].team && strlen(cg_TeamColors.string) != 3 
				&& cgs.gametype >= GT_TEAM && !ci->localClient ) {
				re->shaderRGBA[0] = cgs.teamColors[0][0];
				re->shaderRGBA[1] = cgs.teamColors[0][1];
				re->shaderRGBA[2] = cgs.teamColors[0][2];
				re->shaderRGBA[3] = 255;
			} else {
				re->shaderRGBA[0] = ci->color1[0] * 255;
				re->shaderRGBA[1] = ci->color1[1] * 255;
				re->shaderRGBA[2] = ci->color1[2] * 255;
				re->shaderRGBA[3] = 255;
			}

			if ( (ci->team != cgs.clientinfo[ cg.clientNum ].team && (strlen(cg_EnemyColors.string) == 2 || strlen(cg_EnemyColors.string) == 5)
				&& cgs.gametype >= GT_TEAM && cgs.clientinfo[cg.clientNum].team != TEAM_SPECTATOR) ||
				( cgs.gametype < GT_TEAM && !ci->localClient && (strlen(cg_EnemyColors.string) == 2 || strlen(cg_EnemyColors.string) == 5) ) ) {
						le->color[0] = g_color_table[ColorIndex(cg_EnemyColors.string[0])][0] * 0.75;
						le->color[1] = g_color_table[ColorIndex(cg_EnemyColors.string[0])][1] * 0.75;
						le->color[2] = g_color_table[ColorIndex(cg_EnemyColors.string[0])][2] * 0.75;
						le->color[3] = 1.0f;
				} else if ( ci->team == cgs.clientinfo[ cg.clientNum ].team && cg_forceColors.integer && cgs.gametype >= GT_TEAM ) {
							le->color[0] = cgs.clientinfo[cg.clientNum].color1[0] * 0.75;
							le->color[1] = cgs.clientinfo[cg.clientNum].color1[1] * 0.75;
							le->color[2] = cgs.clientinfo[cg.clientNum].color1[2] * 0.75;
							le->color[3] = 1.0f;
				} else if ( ci->team == cgs.clientinfo[ cg.clientNum ].team && strlen(cg_TeamColors.string) != 3
					&& cgs.gametype >= GT_TEAM && !ci->localClient ) {
							le->color[0] = g_color_table[ColorIndex(cg_TeamColors.string[0])][0] * 0.75;
							le->color[1] = g_color_table[ColorIndex(cg_TeamColors.string[0])][1] * 0.75;
							le->color[2] = g_color_table[ColorIndex(cg_TeamColors.string[0])][2] * 0.75;
							le->color[3] = 1.0f;
				} else {
					le->color[0] = ci->color1[0] * 0.75;
					le->color[1] = ci->color1[1] * 0.75;
					le->color[2] = ci->color1[2] * 0.75;
					le->color[3] = 1.0f;
				}

		AxisClear( re->axis );
 
		VectorMA(move, 20, vec, move);
		VectorCopy(move, next_move);
		VectorScale (vec, SPACING, vec);
	}

	if ( cg_railStyle.integer == 1 || cg_railStyle.integer == 5 ) {
		// nudge down a bit so it isn't exactly in center
		re->origin[2] -= 8;
		re->oldorigin[2] -= 8;
		return;
	}

	if ( cg_railStyle.integer == 2 || cg_railStyle.integer == 3 || cg_railStyle.integer  == 6 || cg_railStyle.integer  == 7 ) {
		if ( cg_railStyle.integer == 2 || cg_railStyle.integer == 6 ) {
			PerpendicularVector(temp, vec);
			for (i = 0 ; i < 36; i++) {
				RotatePointAroundVector(axis[i], vec, temp, i * 10);//banshee 2.4 was 10
			}
			VectorMA(move, 20, vec, move);
			VectorCopy(move, next_move);
			VectorScale (vec, SPACING, vec);
		}
		skip = -1;

		j = 18;
		for (i = 0; i < len; i += SPACING) {
			if (i != skip) {
				skip = i + SPACING;
				le = CG_AllocLocalEntity();
				re = &le->refEntity;
				le->leFlags = LEF_PUFF_DONT_SCALE;
				le->leType = LE_MOVE_SCALE_FADE;
				le->startTime = cg.time;
				le->endTime = cg.time + (i>>1) + 600;
				le->lifeRate = 1.0 / (le->endTime - le->startTime);

				re->shaderTime = cg.time / 1000.0f;
				re->reType = RT_SPRITE;
				re->radius = 1.1f;
				re->customShader = cgs.media.railRingsShader;

					if ( (ci->team != cgs.clientinfo[ cg.clientNum ].team && (strlen(cg_EnemyColors.string) == 2 || strlen(cg_EnemyColors.string) == 5)
						&& cgs.gametype >= GT_TEAM && cgs.clientinfo[cg.clientNum].team != TEAM_SPECTATOR) 
						|| ( cgs.gametype < GT_TEAM && !ci->localClient && (strlen(cg_EnemyColors.string) == 2 || strlen(cg_EnemyColors.string) == 5) ) ) {
						re->shaderRGBA[0] = cgs.enemyColors[4][0];
						re->shaderRGBA[1] = cgs.enemyColors[4][1];
						re->shaderRGBA[2] = cgs.enemyColors[4][2];
						re->shaderRGBA[3] = 255;
					} else if ( ci->team == cgs.clientinfo[ cg.clientNum ].team && cg_forceColors.integer && cgs.gametype >= GT_TEAM ) {
						re->shaderRGBA[0] = cgs.clientinfo[cg.clientNum].color2[0];
						re->shaderRGBA[1] = cgs.clientinfo[cg.clientNum].color2[1];
						re->shaderRGBA[2] = cgs.clientinfo[cg.clientNum].color2[2];
						re->shaderRGBA[3] = 255;
					} else if ( ci->team == cgs.clientinfo[ cg.clientNum ].team && strlen(cg_TeamColors.string) != 3
						&& cgs.gametype >= GT_TEAM && !ci->localClient ) {
						re->shaderRGBA[0] = cgs.teamColors[4][0];
						re->shaderRGBA[1] = cgs.teamColors[4][1];
						re->shaderRGBA[2] = cgs.teamColors[4][2];
						re->shaderRGBA[3] = 255;
					} else {
						re->shaderRGBA[0] = ci->color2[0] * 255;
						re->shaderRGBA[1] = ci->color2[1] * 255;
						re->shaderRGBA[2] = ci->color2[2] * 255;
						re->shaderRGBA[3] = 255;
					}

					if ( (ci->team != cgs.clientinfo[ cg.clientNum ].team && 
						( strlen(cg_EnemyColors.string) == 2 || strlen(cg_EnemyColors.string) == 5 ) 
						&& cgs.gametype >= GT_TEAM && cgs.clientinfo[cg.clientNum].team != TEAM_SPECTATOR) || 
						( cgs.gametype < GT_TEAM && !ci->localClient && strlen(cg_EnemyColors.string) !=3 )) {
								le->color[0] = g_color_table[ColorIndex(cg_EnemyColors.string[4])][0] * 0.75;
								le->color[1] = g_color_table[ColorIndex(cg_EnemyColors.string[4])][1] * 0.75;
								le->color[2] = g_color_table[ColorIndex(cg_EnemyColors.string[4])][2] * 0.75;
								le->color[3] = 1.0f;
					} else if ( ci->team == cgs.clientinfo[ cg.clientNum ].team && cg_forceColors.integer && cgs.gametype >= GT_TEAM ) {
								le->color[0] = cgs.clientinfo[cg.clientNum].color2[0] * 0.75;
								le->color[1] = cgs.clientinfo[cg.clientNum].color2[1] * 0.75;
								le->color[2] = cgs.clientinfo[cg.clientNum].color2[2] * 0.75;
								le->color[3] = 1.0f;
					} else if ( ci->team == cgs.clientinfo[ cg.clientNum ].team && 
						( strlen(cg_TeamColors.string) == 2 || strlen(cg_TeamColors.string) == 5 
						&& cgs.gametype >= GT_TEAM && !ci->localClient) ) {
								le->color[0] = g_color_table[ColorIndex(cg_TeamColors.string[4])][0] * 0.75;
								le->color[1] = g_color_table[ColorIndex(cg_TeamColors.string[4])][1] * 0.75;
								le->color[2] = g_color_table[ColorIndex(cg_TeamColors.string[4])][2] * 0.75;
								le->color[3] = 1.0f;
					} else {
						le->color[0] = ci->color2[0] * 0.75;
						le->color[1] = ci->color2[1] * 0.75;
						le->color[2] = ci->color2[2] * 0.75;
						le->color[3] = 1.0f;
					}

				le->pos.trType = TR_LINEAR;
				le->pos.trTime = cg.time;

				VectorCopy( move, move2);
				VectorMA(move2, RADIUS , axis[j], move2);
				VectorCopy(move2, le->pos.trBase);

				le->pos.trDelta[0] = axis[j][0]*6;
				le->pos.trDelta[1] = axis[j][1]*6;
				le->pos.trDelta[2] = axis[j][2]*6;
			}

			VectorAdd (move, vec, move);

			j = j + ROTATION < 36 ? j + ROTATION : (j + ROTATION) % 36;
		}

	}
}

/*
==========================
CG_RocketTrail
==========================
*/
static void CG_RocketTrail( centity_t *ent, const weaponInfo_t *wi ) {
	int		step;
	vec3_t	origin, lastPos;
	int		t;
	int		startTime, contents;
	int		lastContents;
	entityState_t	*es;
	vec3_t	up;
	localEntity_t	*smoke;

	if ( cg_noProjectileTrail.integer ) {
		return;
	}

	up[0] = 0;
	up[1] = 0;
	up[2] = 0;

	step = 50;

	es = &ent->currentState;
	startTime = ent->trailTime;
	t = step * ( (startTime + step) / step );

	BG_EvaluateTrajectory( &es->pos, cg.time, origin );
	contents = CG_PointContents( origin, -1 );

	// if object (e.g. grenade) is stationary, don't toss up smoke
	if ( es->pos.trType == TR_STATIONARY ) {
		ent->trailTime = cg.time;
		return;
	}

	BG_EvaluateTrajectory( &es->pos, ent->trailTime, lastPos );
	lastContents = CG_PointContents( lastPos, -1 );

	ent->trailTime = cg.time;

	if ( contents & ( CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) ) {
		if ( contents & lastContents & CONTENTS_WATER ) {
			CG_BubbleTrail( lastPos, origin, 8 );
		}
		return;
	}

	for ( ; t <= ent->trailTime ; t += step ) {
		BG_EvaluateTrajectory( &es->pos, t, lastPos );

		smoke = CG_SmokePuff( lastPos, up, 
					  wi->trailRadius, 
					  1, 1, 1, 0.33f,
					  wi->wiTrailTime, 
					  t,
					  0,
					  0, 
					  cgs.media.smokePuffShader );
		// use the optimized local entity add
		if ( wi->wiTrailTime == 2000 && cg_smokeGrowth_RL.integer || wi->wiTrailTime == 700 && cg_smokeGrowth_GL.integer ) {
			smoke->leType = LE_SCALE_FADE;
		} else {//h4x
			smoke->leType = LE_SCALE_FADE2;
		}
	}

}

#ifdef MISSIONPACK
/*
==========================
CG_NailTrail
==========================
*/
static void CG_NailTrail( centity_t *ent, const weaponInfo_t *wi ) {
	int		step;
	vec3_t	origin, lastPos;
	int		t;
	int		startTime, contents;
	int		lastContents;
	entityState_t	*es;
	vec3_t	up;
	localEntity_t	*smoke;

	if ( cg_noProjectileTrail.integer ) {
		return;
	}

	up[0] = 0;
	up[1] = 0;
	up[2] = 0;

	step = 50;

	es = &ent->currentState;
	startTime = ent->trailTime;
	t = step * ( (startTime + step) / step );

	BG_EvaluateTrajectory( &es->pos, cg.time, origin );
	contents = CG_PointContents( origin, -1 );

	// if object (e.g. grenade) is stationary, don't toss up smoke
	if ( es->pos.trType == TR_STATIONARY ) {
		ent->trailTime = cg.time;
		return;
	}

	BG_EvaluateTrajectory( &es->pos, ent->trailTime, lastPos );
	lastContents = CG_PointContents( lastPos, -1 );

	ent->trailTime = cg.time;

	if ( contents & ( CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) ) {
		if ( contents & lastContents & CONTENTS_WATER ) {
			CG_BubbleTrail( lastPos, origin, 8 );
		}
		return;
	}

	for ( ; t <= ent->trailTime ; t += step ) {
		BG_EvaluateTrajectory( &es->pos, t, lastPos );

		smoke = CG_SmokePuff( lastPos, up, 
					  wi->trailRadius, 
					  1, 1, 1, 0.33f,
					  wi->wiTrailTime, 
					  t,
					  0,
					  0, 
					  cgs.media.nailPuffShader );
		// use the optimized local entity add
		smoke->leType = LE_SCALE_FADE;
	}

}
#endif

/*
==========================
CG_NailTrail
==========================
*/
static void CG_PlasmaTrail( centity_t *cent, const weaponInfo_t *wi ) {
	localEntity_t	*le;
	refEntity_t		*re;
	entityState_t	*es;
	vec3_t			velocity, xvelocity, origin;
	vec3_t			offset, xoffset;
	vec3_t			v[3];
	int				t, startTime, step;

	float	waterScale = 1.0f;

	if ( cg_noProjectileTrail.integer || cg_oldPlasma.integer ) {
		return;
	}

	step = 50;

	es = &cent->currentState;
	startTime = cent->trailTime;
	t = step * ( (startTime + step) / step );

	BG_EvaluateTrajectory( &es->pos, cg.time, origin );

	le = CG_AllocLocalEntity();
	re = &le->refEntity;

	velocity[0] = 60 - 120 * crandom();
	velocity[1] = 40 - 80 * crandom();
	velocity[2] = 100 - 200 * crandom();

	le->leType = LE_MOVE_SCALE_FADE;
	le->leFlags = LEF_TUMBLE;
	le->leBounceSoundType = LEBS_NONE;
	le->leMarkType = LEMT_NONE;

	le->startTime = cg.time;
	le->endTime = le->startTime + 600;

	le->pos.trType = TR_GRAVITY;
	le->pos.trTime = cg.time;

	AnglesToAxis( cent->lerpAngles, v );

	offset[0] = 2;
	offset[1] = 2;
	offset[2] = 2;

	xoffset[0] = offset[0] * v[0][0] + offset[1] * v[1][0] + offset[2] * v[2][0];
	xoffset[1] = offset[0] * v[0][1] + offset[1] * v[1][1] + offset[2] * v[2][1];
	xoffset[2] = offset[0] * v[0][2] + offset[1] * v[1][2] + offset[2] * v[2][2];

	VectorAdd( origin, xoffset, re->origin );
	VectorCopy( re->origin, le->pos.trBase );

	if ( CG_PointContents( re->origin, -1 ) & CONTENTS_WATER ) {
		waterScale = 0.10f;
	}

	xvelocity[0] = velocity[0] * v[0][0] + velocity[1] * v[1][0] + velocity[2] * v[2][0];
	xvelocity[1] = velocity[0] * v[0][1] + velocity[1] * v[1][1] + velocity[2] * v[2][1];
	xvelocity[2] = velocity[0] * v[0][2] + velocity[1] * v[1][2] + velocity[2] * v[2][2];
	VectorScale( xvelocity, waterScale, le->pos.trDelta );

	AxisCopy( axisDefault, re->axis );
    re->shaderTime = cg.time / 1000.0f;
    re->reType = RT_SPRITE;
    re->radius = 0.25f;
	re->customShader = cgs.media.railRingsShader;
	le->bounceFactor = 0.3f;

    re->shaderRGBA[0] = wi->flashDlightColor[0] * 63;
    re->shaderRGBA[1] = wi->flashDlightColor[1] * 63;
    re->shaderRGBA[2] = wi->flashDlightColor[2] * 63;
    re->shaderRGBA[3] = 63;

    le->color[0] = wi->flashDlightColor[0] * 0.2;
    le->color[1] = wi->flashDlightColor[1] * 0.2;
    le->color[2] = wi->flashDlightColor[2] * 0.2;
    le->color[3] = 0.25f;

	le->angles.trType = TR_LINEAR;
	le->angles.trTime = cg.time;
	le->angles.trBase[0] = rand()&31;
	le->angles.trBase[1] = rand()&31;
	le->angles.trBase[2] = rand()&31;
	le->angles.trDelta[0] = 1;
	le->angles.trDelta[1] = 0.5;
	le->angles.trDelta[2] = 0;

}
/*
==========================
CG_GrappleTrail
==========================
*/
void CG_GrappleTrail( centity_t *ent, const weaponInfo_t *wi ) {
	vec3_t	origin;
	entityState_t	*es;
	vec3_t			forward, up;
	refEntity_t		beam;

	es = &ent->currentState;

	BG_EvaluateTrajectory( &es->pos, cg.time, origin );
	ent->trailTime = cg.time;

	memset( &beam, 0, sizeof( beam ) );
	//FIXME adjust for muzzle position
	VectorCopy ( cg_entities[ ent->currentState.otherEntityNum ].lerpOrigin, beam.origin );
	beam.origin[2] += 26;
	AngleVectors( cg_entities[ ent->currentState.otherEntityNum ].lerpAngles, forward, NULL, up );
	VectorMA( beam.origin, -6, up, beam.origin );
	VectorCopy( origin, beam.oldorigin );

	if (Distance( beam.origin, beam.oldorigin ) < 64 )
		return; // Don't draw if close

	beam.reType = RT_LIGHTNING;
	beam.customShader = cgs.media.lightningShader;

	AxisClear( beam.axis );
	beam.shaderRGBA[0] = 0xff;
	beam.shaderRGBA[1] = 0xff;
	beam.shaderRGBA[2] = 0xff;
	beam.shaderRGBA[3] = 0xff;
	trap_R_AddRefEntityToScene( &beam );
}

/*
==========================
CG_GrenadeTrail
==========================
*/
static void CG_GrenadeTrail( centity_t *ent, const weaponInfo_t *wi ) {
	CG_RocketTrail( ent, wi );
}


/*
=================
CG_RegisterWeapon

The server says this item is used on this level
=================
*/
void CG_RegisterWeapon( int weaponNum ) {
	weaponInfo_t	*weaponInfo;
	gitem_t			*item, *ammo;
	char			path[MAX_QPATH];
	vec3_t			mins, maxs;
	int				i;

	weaponInfo = &cg_weapons[weaponNum];

	if ( weaponNum == 0 ) {
		return;
	}

	if ( weaponInfo->registered ) {
		return;
	}

	memset( weaponInfo, 0, sizeof( *weaponInfo ) );
	weaponInfo->registered = qtrue;

	for ( item = bg_itemlist + 1 ; item->classname ; item++ ) {
		if ( item->giType == IT_WEAPON && item->giTag == weaponNum ) {
			weaponInfo->item = item;
			break;
		}
	}
	if ( !item->classname ) {
		CG_Error( "Couldn't find weapon %i", weaponNum );
	}
	CG_RegisterItemVisuals( item - bg_itemlist );

	// load cmodel before model so filecache works
	weaponInfo->weaponModel = trap_R_RegisterModel( item->world_model[0] );

	// calc midpoint for rotation
	trap_R_ModelBounds( weaponInfo->weaponModel, mins, maxs );
	for ( i = 0 ; i < 3 ; i++ ) {
		weaponInfo->weaponMidpoint[i] = mins[i] + 0.5 * ( maxs[i] - mins[i] );
	}

	weaponInfo->weaponIcon = trap_R_RegisterShader( item->icon );
	weaponInfo->ammoIcon = trap_R_RegisterShader( item->icon );

	for ( ammo = bg_itemlist + 1 ; ammo->classname ; ammo++ ) {
		if ( ammo->giType == IT_AMMO && ammo->giTag == weaponNum ) {
			break;
		}
	}
	if ( ammo->classname && ammo->world_model[0] ) {
		weaponInfo->ammoModel = trap_R_RegisterModel( ammo->world_model[0] );
	}

	strcpy( path, item->world_model[0] );
	COM_StripExtension( path, path );
	strcat( path, "_flash.md3" );
	weaponInfo->flashModel = trap_R_RegisterModel( path );

	strcpy( path, item->world_model[0] );
	COM_StripExtension( path, path );
	strcat( path, "_barrel.md3" );
	weaponInfo->barrelModel = trap_R_RegisterModel( path );

	strcpy( path, item->world_model[0] );
	COM_StripExtension( path, path );
	strcat( path, "_hand.md3" );
	weaponInfo->handsModel = trap_R_RegisterModel( path );

	if ( !weaponInfo->handsModel ) {
		weaponInfo->handsModel = trap_R_RegisterModel( "models/weapons2/shotgun/shotgun_hand.md3" );
	}

	weaponInfo->loopFireSound = qfalse;

	switch ( weaponNum ) {
	case WP_GAUNTLET:
		MAKERGB( weaponInfo->flashDlightColor, 0.6f, 0.6f, 1.0f );
		weaponInfo->firingSound = trap_S_RegisterSound( "sound/weapons/melee/fstrun.wav", qfalse );
		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/melee/fstatck.wav", qfalse );
		break;

	case WP_LIGHTNING:
		MAKERGB( weaponInfo->flashDlightColor, 0.6f, 0.6f, 1.0f );
		weaponInfo->readySound = trap_S_RegisterSound( "sound/weapons/melee/fsthum.wav", qfalse );
		weaponInfo->firingSound = trap_S_RegisterSound( "sound/weapons/lightning/lg_hum.wav", qfalse );

		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/lightning/lg_fire.wav", qfalse );
		cgs.media.lightningShader = trap_R_RegisterShader( "lightningBoltNew");
		cgs.media.lightningExplosionModel = trap_R_RegisterModel( "models/weaphits/crackle.md3" );
		cgs.media.sfx_lghit1 = trap_S_RegisterSound( "sound/weapons/lightning/lg_hit.wav", qfalse );
		cgs.media.sfx_lghit2 = trap_S_RegisterSound( "sound/weapons/lightning/lg_hit2.wav", qfalse );
		cgs.media.sfx_lghit3 = trap_S_RegisterSound( "sound/weapons/lightning/lg_hit3.wav", qfalse );

		break;

	case WP_GRAPPLING_HOOK:
		cgs.media.lightningShader = trap_R_RegisterShader( "lightningBoltNew");
		MAKERGB( weaponInfo->flashDlightColor, 0.6f, 0.6f, 1.0f );
		weaponInfo->missileModel = trap_R_RegisterModel( "models/ammo/rocket/rocket.md3" );
		weaponInfo->missileTrailFunc = CG_GrappleTrail;
		weaponInfo->missileDlight = 200;
		weaponInfo->wiTrailTime = 2000;
		weaponInfo->trailRadius = 64;
		MAKERGB( weaponInfo->missileDlightColor, 1, 0.75f, 0 );
		//weaponInfo->readySound = trap_S_RegisterSound( "sound/weapons/melee/fsthum.wav", qfalse );
		weaponInfo->firingSound = trap_S_RegisterSound( "sound/weapons/melee/fstrun.wav", qfalse );
		break;

#ifdef MISSIONPACK
	case WP_CHAINGUN:
		weaponInfo->firingSound = trap_S_RegisterSound( "sound/weapons/vulcan/wvulfire.wav", qfalse );
		weaponInfo->loopFireSound = qtrue;
		MAKERGB( weaponInfo->flashDlightColor, 1, 1, 0 );
		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/vulcan/vulcanf1b.wav", qfalse );
		weaponInfo->flashSound[1] = trap_S_RegisterSound( "sound/weapons/vulcan/vulcanf2b.wav", qfalse );
		weaponInfo->flashSound[2] = trap_S_RegisterSound( "sound/weapons/vulcan/vulcanf3b.wav", qfalse );
		weaponInfo->flashSound[3] = trap_S_RegisterSound( "sound/weapons/vulcan/vulcanf4b.wav", qfalse );
		weaponInfo->ejectBrassFunc = CG_MachineGunEjectBrass;
		cgs.media.bulletExplosionShader = trap_R_RegisterShader( "bulletExplosion" );
		break;
#endif

	case WP_MACHINEGUN:
		MAKERGB( weaponInfo->flashDlightColor, 1, 1, 0 );
		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/machinegun/machgf1b.wav", qfalse );
		weaponInfo->flashSound[1] = trap_S_RegisterSound( "sound/weapons/machinegun/machgf2b.wav", qfalse );
		weaponInfo->flashSound[2] = trap_S_RegisterSound( "sound/weapons/machinegun/machgf3b.wav", qfalse );
		weaponInfo->flashSound[3] = trap_S_RegisterSound( "sound/weapons/machinegun/machgf4b.wav", qfalse );
		weaponInfo->ejectBrassFunc = CG_MachineGunEjectBrass;
		cgs.media.bulletExplosionShader = trap_R_RegisterShader( "bulletExplosion" );
		break;

	case WP_SHOTGUN:
		MAKERGB( weaponInfo->flashDlightColor, 1, 1, 0 );
		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/shotgun/sshotf1b.wav", qfalse );
		weaponInfo->ejectBrassFunc = CG_ShotgunEjectBrass;
		break;

	case WP_ROCKET_LAUNCHER:
		weaponInfo->missileModel = trap_R_RegisterModel( "models/ammo/rocket/rocket.md3" );
		weaponInfo->missileSound = trap_S_RegisterSound( "sound/weapons/rocket/rockfly.wav", qfalse );
		weaponInfo->missileTrailFunc = CG_RocketTrail;
		weaponInfo->missileDlight = 200;
		weaponInfo->wiTrailTime = 2000;
		weaponInfo->trailRadius = cg_smokeRadius_RL.integer;
		
		MAKERGB( weaponInfo->missileDlightColor, 1, 0.75f, 0 );
		MAKERGB( weaponInfo->flashDlightColor, 1, 0.75f, 0 );

		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/rocket/rocklf1a.wav", qfalse );
		cgs.media.rocketExplosionShader = trap_R_RegisterShader( "rocketExplosion" );
		break;

#ifdef MISSIONPACK
	case WP_PROX_LAUNCHER:
		weaponInfo->missileModel = trap_R_RegisterModel( "models/weaphits/proxmine.md3" );
		weaponInfo->missileTrailFunc = CG_GrenadeTrail;
		weaponInfo->wiTrailTime = 700;
		weaponInfo->trailRadius = 32;
		MAKERGB( weaponInfo->flashDlightColor, 1, 0.70f, 0 );
		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/proxmine/wstbfire.wav", qfalse );
		cgs.media.grenadeExplosionShader = trap_R_RegisterShader( "grenadeExplosion" );
		break;
#endif

	case WP_GRENADE_LAUNCHER:
		weaponInfo->missileModel = trap_R_RegisterModel( "models/ammo/grenade1.md3" );
		weaponInfo->missileTrailFunc = CG_GrenadeTrail;
		weaponInfo->wiTrailTime = 700;
		weaponInfo->trailRadius = cg_smokeRadius_GL.integer;
		MAKERGB( weaponInfo->flashDlightColor, 1, 0.70f, 0 );
		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/grenade/grenlf1a.wav", qfalse );
		cgs.media.grenadeExplosionShader = trap_R_RegisterShader( "grenadeExplosion" );
		break;

#ifdef MISSIONPACK
	case WP_NAILGUN:
		weaponInfo->ejectBrassFunc = CG_NailgunEjectBrass;
		weaponInfo->missileTrailFunc = CG_NailTrail;
//		weaponInfo->missileSound = trap_S_RegisterSound( "sound/weapons/nailgun/wnalflit.wav", qfalse );
		weaponInfo->trailRadius = 16;
		weaponInfo->wiTrailTime = 250;
		weaponInfo->missileModel = trap_R_RegisterModel( "models/weaphits/nail.md3" );
		MAKERGB( weaponInfo->flashDlightColor, 1, 0.75f, 0 );
		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/nailgun/wnalfire.wav", qfalse );
		break;
#endif

	case WP_PLASMAGUN:
//		weaponInfo->missileModel = cgs.media.invulnerabilityPowerupModel;
		weaponInfo->missileTrailFunc = CG_PlasmaTrail;
		weaponInfo->missileSound = trap_S_RegisterSound( "sound/weapons/plasma/lasfly.wav", qfalse );
		MAKERGB( weaponInfo->flashDlightColor, 0.6f, 0.6f, 1.0f );
		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/plasma/hyprbf1a.wav", qfalse );
		cgs.media.plasmaExplosionShader = trap_R_RegisterShader( "plasmaExplosion" );
		cgs.media.railRingsShader = trap_R_RegisterShader( "railDisc" );
		break;

	case WP_RAILGUN:
		weaponInfo->readySound = trap_S_RegisterSound( "sound/weapons/railgun/rg_hum.wav", qfalse );
		MAKERGB( weaponInfo->flashDlightColor, 1, 0.5f, 0 );
		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/railgun/railgf1a.wav", qfalse );
		cgs.media.railExplosionShader = trap_R_RegisterShader( "railExplosion" );
		cgs.media.railRingsShader = trap_R_RegisterShader( "railDisc" );
		cgs.media.railCoreShader = trap_R_RegisterShader( "railCore" );
		break;

	case WP_BFG:
		weaponInfo->readySound = trap_S_RegisterSound( "sound/weapons/bfg/bfg_hum.wav", qfalse );
		MAKERGB( weaponInfo->flashDlightColor, 1, 0.7f, 1 );
		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/bfg/bfg_fire.wav", qfalse );
		cgs.media.bfgExplosionShader = trap_R_RegisterShader( "bfgExplosion" );
		weaponInfo->missileModel = trap_R_RegisterModel( "models/weaphits/bfg.md3" );
		weaponInfo->missileSound = trap_S_RegisterSound( "sound/weapons/rocket/rockfly.wav", qfalse );
		break;

	 default:
		MAKERGB( weaponInfo->flashDlightColor, 1, 1, 1 );
		weaponInfo->flashSound[0] = trap_S_RegisterSound( "sound/weapons/rocket/rocklf1a.wav", qfalse );
		break;
	}
}

/*
=================
CG_RegisterItemVisuals

The server says this item is used on this level
=================
*/
void CG_RegisterItemVisuals( int itemNum ) {
	itemInfo_t		*itemInfo;
	gitem_t			*item;

	if ( itemNum < 0 || itemNum >= bg_numItems ) {
		CG_Error( "CG_RegisterItemVisuals: itemNum %d out of range [0-%d]", itemNum, bg_numItems-1 );
	}

	itemInfo = &cg_items[ itemNum ];
	if ( itemInfo->registered ) {
		return;
	}

	item = &bg_itemlist[ itemNum ];

	memset( itemInfo, 0, sizeof( &itemInfo ) );
	itemInfo->registered = qtrue;

	itemInfo->models[0] = trap_R_RegisterModel( item->world_model[0] );

	itemInfo->icon = trap_R_RegisterShader( item->icon );

	if ( item->giType == IT_WEAPON ) {
		CG_RegisterWeapon( item->giTag );
	}

	//
	// powerups have an accompanying ring or sphere
	//
	if ( item->giType == IT_POWERUP || item->giType == IT_HEALTH || 
		item->giType == IT_ARMOR || item->giType == IT_HOLDABLE ) {
		if ( item->world_model[1] ) {
			itemInfo->models[1] = trap_R_RegisterModel( item->world_model[1] );
		}
	}
}


/*
========================================================================================

VIEW WEAPON

========================================================================================
*/

/*
=================
CG_MapTorsoToWeaponFrame

=================
*/
static int CG_MapTorsoToWeaponFrame( clientInfo_t *ci, int frame ) {

	// change weapon
	if ( frame >= ci->animations[TORSO_DROP].firstFrame 
		&& frame < ci->animations[TORSO_DROP].firstFrame + 9 ) {
		return frame - ci->animations[TORSO_DROP].firstFrame + 6;
	}

	// stand attack
	if ( frame >= ci->animations[TORSO_ATTACK].firstFrame 
		&& frame < ci->animations[TORSO_ATTACK].firstFrame + 6 ) {
		return 1 + frame - ci->animations[TORSO_ATTACK].firstFrame;
	}

	// stand attack 2
	if ( frame >= ci->animations[TORSO_ATTACK2].firstFrame 
		&& frame < ci->animations[TORSO_ATTACK2].firstFrame + 6 ) {
		return 1 + frame - ci->animations[TORSO_ATTACK2].firstFrame;
	}
	
	return 0;
}


/*
==============
CG_CalculateWeaponPosition
==============
*/
static void CG_CalculateWeaponPosition( vec3_t origin, vec3_t angles ) {
	float	scale;
	int		delta;
	float	fracsin;

	VectorCopy( cg.refdef.vieworg, origin );
	VectorCopy( cg.refdefViewAngles, angles );

	// on odd legs, invert some angles
	if ( cg.bobcycle & 1 ) {
		scale = -cg.xyspeed;
	} else {
		scale = cg.xyspeed;
	}

	// gun angles from bobbing
	angles[ROLL] += scale * cg.bobfracsin * 0.005;
	angles[YAW] += scale * cg.bobfracsin * 0.01;
	angles[PITCH] += cg.xyspeed * cg.bobfracsin * 0.005;

	// drop the weapon when landing
	delta = cg.time - cg.landTime;
	if ( delta < LAND_DEFLECT_TIME ) {
		origin[2] += cg.landChange*0.25 * delta / LAND_DEFLECT_TIME;
	} else if ( delta < LAND_DEFLECT_TIME + LAND_RETURN_TIME ) {
		origin[2] += cg.landChange*0.25 * 
			(LAND_DEFLECT_TIME + LAND_RETURN_TIME - delta) / LAND_RETURN_TIME;
	}

#if 0
	// drop the weapon when stair climbing
	delta = cg.time - cg.stepTime;
	if ( delta < STEP_TIME/2 ) {
		origin[2] -= cg.stepChange*0.25 * delta / (STEP_TIME/2);
	} else if ( delta < STEP_TIME ) {
		origin[2] -= cg.stepChange*0.25 * (STEP_TIME - delta) / (STEP_TIME/2);
	}
#endif

	// idle drift
	scale = cg.xyspeed + 40;
	fracsin = sin( cg.time * 0.001 );
	angles[ROLL] += scale * fracsin * 0.01;
	angles[YAW] += scale * fracsin * 0.01;
	angles[PITCH] += scale * fracsin * 0.01;
}


/*
===============
CG_LightningBolt

Origin will be the exact tag point, which is slightly
different than the muzzle point used for determining hits.
The cent should be the non-predicted cent if it is from the player,
so the endpoint will reflect the simulated strike (lagging the predicted
angle)
===============
*/
static void CG_LightningBolt( centity_t *cent, vec3_t origin ) {
	trace_t  trace;
	refEntity_t  beam;
	vec3_t   forward;
	vec3_t   muzzlePoint, endPoint;

	if (cent->currentState.weapon != WP_LIGHTNING) {
		return;
	}

	memset( &beam, 0, sizeof( beam ) );

//unlagged - attack prediction #1
	// if the entity is us, unlagged is on server-side, and we've got it on for the lightning gun
	if ( (cent->currentState.number == cg.predictedPlayerState.clientNum) && cgs.delagHitscan &&
			( cg_aimType.integer > 0 ) ) {
		// always shoot straight forward from our current position
		AngleVectors( cg.predictedPlayerState.viewangles, forward, NULL, NULL );
		VectorCopy( cg.predictedPlayerState.origin, muzzlePoint );
	}
	else
//unlagged - attack prediction #1
	// CPMA  "true" lightning
	if ((cent->currentState.number == cg.predictedPlayerState.clientNum) && (cg_trueLightning.value != 0)) {
		vec3_t angle;
		int i;

//unlagged - true lightning
		// might as well fix up true lightning while we're at it
		vec3_t viewangles;
		VectorCopy( cg.predictedPlayerState.viewangles, viewangles );
//unlagged - true lightning

		for (i = 0; i < 3; i++) {
			float a = cent->lerpAngles[i] - viewangles[i]; //unlagged: was cg.refdefViewAngles[i];
			if (a > 180) {
				a -= 360;
			}
			if (a < -180) {
				a += 360;
			}

			angle[i] = viewangles[i] /*unlagged: was cg.refdefViewAngles[i]*/ + a * (1.0 - cg_trueLightning.value);
			if (angle[i] < 0) {
				angle[i] += 360;
			}
			if (angle[i] > 360) {
				angle[i] -= 360;
			}
		}

		AngleVectors(angle, forward, NULL, NULL );

//unlagged - true lightning
//		VectorCopy(cent->lerpOrigin, muzzlePoint );
//		VectorCopy(cg.refdef.vieworg, muzzlePoint );
		// *this* is the correct origin for true lightning
		VectorCopy(cg.predictedPlayerState.origin, muzzlePoint );
//unlagged - true lightning

	} else {
		// !CPMA
		AngleVectors( cent->lerpAngles, forward, NULL, NULL );
		VectorCopy(cent->lerpOrigin, muzzlePoint );
	}

	//Verify this
	muzzlePoint[2] += cg.snap->ps.viewheight;//DEFAULT_VIEWHEIGHT;

	VectorMA( muzzlePoint, 14, forward, muzzlePoint );

	// project forward by the lightning range
	VectorMA( muzzlePoint, LIGHTNING_RANGE, forward, endPoint );

	// see if it hit a wall
	CG_Trace( &trace, muzzlePoint, vec3_origin, vec3_origin, endPoint, 
		cent->currentState.number, MASK_SHOT );

	// this is the endpoint
	VectorCopy( trace.endpos, beam.oldorigin );

	// use the provided origin, even though it may be slightly
	// different than the muzzle origin
	VectorCopy( origin, beam.origin );

	beam.reType = RT_LIGHTNING;
	beam.customShader = cgs.media.lightningShader;
	trap_R_AddRefEntityToScene( &beam );

	// add the impact flare if it hit something
	if ( cg_lightningImpact.integer ) {
		if ( trace.fraction < 1.0 ) {
			vec3_t	angles;
			vec3_t	dir;

			VectorSubtract( beam.oldorigin, beam.origin, dir );
			VectorNormalize( dir );

			memset( &beam, 0, sizeof( beam ) );
			beam.hModel = cgs.media.lightningExplosionModel;

			VectorMA( trace.endpos, -16, dir, beam.origin );

			// make a random orientation
			angles[0] = rand() % 360;
			angles[1] = rand() % 360;
			angles[2] = rand() % 360;
			AnglesToAxis( angles, beam.axis );
			trap_R_AddRefEntityToScene( &beam );
		}
	}
}
/*

static void CG_LightningBolt( centity_t *cent, vec3_t origin ) {
	trace_t		trace;
	refEntity_t		beam;
	vec3_t			forward;
	vec3_t			muzzlePoint, endPoint;

	if ( cent->currentState.weapon != WP_LIGHTNING ) {
		return;
	}

	memset( &beam, 0, sizeof( beam ) );

	// find muzzle point for this frame
	VectorCopy( cent->lerpOrigin, muzzlePoint );
	AngleVectors( cent->lerpAngles, forward, NULL, NULL );

	// FIXME: crouch
	muzzlePoint[2] += DEFAULT_VIEWHEIGHT;

	VectorMA( muzzlePoint, 14, forward, muzzlePoint );

	// project forward by the lightning range
	VectorMA( muzzlePoint, LIGHTNING_RANGE, forward, endPoint );

	// see if it hit a wall
	CG_Trace( &trace, muzzlePoint, vec3_origin, vec3_origin, endPoint, 
		cent->currentState.number, MASK_SHOT );

	// this is the endpoint
	VectorCopy( trace.endpos, beam.oldorigin );

	// use the provided origin, even though it may be slightly
	// different than the muzzle origin
	VectorCopy( origin, beam.origin );

	beam.reType = RT_LIGHTNING;
	beam.customShader = cgs.media.lightningShader;
	trap_R_AddRefEntityToScene( &beam );

	// add the impact flare if it hit something
	if ( trace.fraction < 1.0 ) {
		vec3_t	angles;
		vec3_t	dir;

		VectorSubtract( beam.oldorigin, beam.origin, dir );
		VectorNormalize( dir );

		memset( &beam, 0, sizeof( beam ) );
		beam.hModel = cgs.media.lightningExplosionModel;

		VectorMA( trace.endpos, -16, dir, beam.origin );

		// make a random orientation
		angles[0] = rand() % 360;
		angles[1] = rand() % 360;
		angles[2] = rand() % 360;
		AnglesToAxis( angles, beam.axis );
		trap_R_AddRefEntityToScene( &beam );
	}
}
*/

/*
===============
CG_SpawnRailTrail

Origin will be the exact tag point, which is slightly
different than the muzzle point used for determining hits.
===============
*/
static void CG_SpawnRailTrail( centity_t *cent, vec3_t origin ) {
	clientInfo_t	*ci;

	if ( cent->currentState.weapon != WP_RAILGUN ) {
		return;
	}
	if ( !cent->pe.railgunFlash ) {
		return;
	}
	cent->pe.railgunFlash = qtrue;
	ci = &cgs.clientinfo[ cent->currentState.clientNum ];
	CG_RailTrail( ci, origin, cent->pe.railgunImpact );
}


/*
======================
CG_MachinegunSpinAngle
======================
*/
#define		SPIN_SPEED	0.9
#define		COAST_TIME	1000
static float	CG_MachinegunSpinAngle( centity_t *cent ) {
	int		delta;
	float	angle;
	float	speed;

	delta = cg.time - cent->pe.barrelTime;
	if ( cent->pe.barrelSpinning ) {
		angle = cent->pe.barrelAngle + delta * SPIN_SPEED;
	} else {
		if ( delta > COAST_TIME ) {
			delta = COAST_TIME;
		}

		speed = 0.5 * ( SPIN_SPEED + (float)( COAST_TIME - delta ) / COAST_TIME );
		angle = cent->pe.barrelAngle + delta * speed;
	}

	if ( cent->pe.barrelSpinning == !(cent->currentState.eFlags & EF_FIRING) ) {
		cent->pe.barrelTime = cg.time;
		cent->pe.barrelAngle = AngleMod( angle );
		cent->pe.barrelSpinning = !!(cent->currentState.eFlags & EF_FIRING);
#ifdef MISSIONPACK
		if ( cent->currentState.weapon == WP_CHAINGUN && !cent->pe.barrelSpinning ) {
			trap_S_StartSound( NULL, cent->currentState.number, CHAN_WEAPON, trap_S_RegisterSound( "sound/weapons/vulcan/wvulwind.wav", qfalse ) );
		}
#endif
	}

	return angle;
}


/*
========================
CG_AddWeaponWithPowerups
========================
*/
static void CG_AddWeaponWithPowerups( refEntity_t *gun, int powerups ) {
	// add powerup effects
	if ( powerups & ( 1 << PW_INVIS ) ) {
		gun->customShader = cgs.media.invisShader;
		trap_R_AddRefEntityToScene( gun );
	} else {
		trap_R_AddRefEntityToScene( gun );

		if ( powerups & ( 1 << PW_BATTLESUIT ) ) {
			gun->customShader = cgs.media.battleWeaponShader;
			trap_R_AddRefEntityToScene( gun );
		}
		if ( powerups & ( 1 << PW_QUAD ) ) {
			gun->customShader = cgs.media.quadWeaponShader;
			trap_R_AddRefEntityToScene( gun );
		}
	}
}


/*
=============
CG_AddPlayerWeapon

Used for both the view weapon (ps is valid) and the world modelother character models (ps is NULL)
The main player will have this called for BOTH cases, so effects like light and
sound should only be done on the world model case.
=============
*/
void CG_AddPlayerWeapon( refEntity_t *parent, playerState_t *ps, centity_t *cent, int team ) {
	refEntity_t	gun;
	refEntity_t	barrel;
	refEntity_t	flash;
	vec3_t		angles;
	weapon_t	weaponNum;
	weaponInfo_t	*weapon;
	centity_t	*nonPredictedCent;
//	int	col;

	weaponNum = cent->currentState.weapon;

	CG_RegisterWeapon( weaponNum );
	weapon = &cg_weapons[weaponNum];

	// add the weapon
	memset( &gun, 0, sizeof( gun ) );
	VectorCopy( parent->lightingOrigin, gun.lightingOrigin );
	gun.shadowPlane = parent->shadowPlane;
	gun.renderfx = parent->renderfx;

	// set custom shading for railgun refire rate
	if ( ps ) {
		if ( cg.predictedPlayerState.weapon == WP_RAILGUN 
			&& cg.predictedPlayerState.weaponstate == WEAPON_FIRING ) {
			float	f;

			//Zero: railgun "square" color
/* original
			f = (float)cg.predictedPlayerState.weaponTime / 1500;
			gun.shaderRGBA[1] = 0;
			gun.shaderRGBA[0] = 
			gun.shaderRGBA[2] = 255 * ( 1.0 - f );
		} else {
			gun.shaderRGBA[0] = 255;
			gun.shaderRGBA[1] = 255;
			gun.shaderRGBA[2] = 255;
			gun.shaderRGBA[3] = 255;
*/
			//color1 and color2 for actual railgun colors
			f = (float)cg.predictedPlayerState.weaponTime / 1500;
			memcpy(gun.shaderRGBA, &cgs.clientinfo[cent->currentState.clientNum].colors[4], sizeof(gun.shaderRGBA));
		} else { 
			memcpy(gun.shaderRGBA, &cgs.clientinfo[cent->currentState.clientNum].colors[0], sizeof(gun.shaderRGBA));
		}
	}

	gun.hModel = weapon->weaponModel;
	if (!gun.hModel) {
		return;
	}

	if ( !ps ) {
		// add weapon ready sound
		cent->pe.lightningFiring = qfalse;
		if ( ( cent->currentState.eFlags & EF_FIRING ) && weapon->firingSound ) {
			// lightning gun and guantlet make a different sound when fire is held down
			trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin, weapon->firingSound );
			cent->pe.lightningFiring = qtrue;
		} else if ( (weapon->readySound && (weapon->item->giType != IT_WEAPON && weapon->item->giTag != WP_RAILGUN) ) ||
			( weapon->readySound && (weapon->item->giType == IT_WEAPON && weapon->item->giTag == WP_RAILGUN) && 
			( (cg_railHum.integer == 0 && (cent->currentState.clientNum != cg.clientNum || cg.predictedPlayerState.clientNum != cg.clientNum)) || (cg_railHum.integer == 1) ) ) ) {
			trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin, weapon->readySound );
		}
	}

	CG_PositionEntityOnTag( &gun, parent, parent->hModel, "tag_weapon");

	CG_AddWeaponWithPowerups( &gun, cent->currentState.powerups );

	// add the spinning barrel
	if ( weapon->barrelModel ) {
		memset( &barrel, 0, sizeof( barrel ) );
		VectorCopy( parent->lightingOrigin, barrel.lightingOrigin );
		barrel.shadowPlane = parent->shadowPlane;
		barrel.renderfx = parent->renderfx;

		barrel.hModel = weapon->barrelModel;
		angles[YAW] = 0;
		angles[PITCH] = 0;
		angles[ROLL] = CG_MachinegunSpinAngle( cent );
		AnglesToAxis( angles, barrel.axis );

		CG_PositionRotatedEntityOnTag( &barrel, &gun, weapon->weaponModel, "tag_barrel" );

		CG_AddWeaponWithPowerups( &barrel, cent->currentState.powerups );
	}

	// make sure we aren't looking at cg.predictedPlayerEntity for LG
	nonPredictedCent = &cg_entities[cent->currentState.clientNum];

	// if the index of the nonPredictedCent is not the same as the clientNum
	// then this is a fake player (like on teh single player podiums), so
	// go ahead and use the cent
	if( ( nonPredictedCent - cg_entities ) != cent->currentState.clientNum ) {
		nonPredictedCent = cent;
	}

	// add the flash
	if ( ( weaponNum == WP_LIGHTNING || weaponNum == WP_GAUNTLET || weaponNum == WP_GRAPPLING_HOOK )
		&& ( nonPredictedCent->currentState.eFlags & EF_FIRING ) ) {
		// continuous flash
	} else {
		// impulse flash
		if ( cg.time - cent->muzzleFlashTime > MUZZLE_FLASH_TIME && !cent->pe.railgunFlash ) {
			return;
		}
	}

	memset( &flash, 0, sizeof( flash ) );
	VectorCopy( parent->lightingOrigin, flash.lightingOrigin );
	flash.shadowPlane = parent->shadowPlane;
	flash.renderfx = parent->renderfx;

	flash.hModel = weapon->flashModel;
	if (!flash.hModel) {
		return;
	}
	angles[YAW] = 0;
	angles[PITCH] = 0;
	angles[ROLL] = crandom() * 10;
	AnglesToAxis( angles, flash.axis );

	// colorize the railgun blast
	if ( weaponNum == WP_RAILGUN ) {
		clientInfo_t	*ci;

		ci = &cgs.clientinfo[ cent->currentState.clientNum ];
		flash.shaderRGBA[0] = 255 * ci->color1[0];
		flash.shaderRGBA[1] = 255 * ci->color1[1];
		flash.shaderRGBA[2] = 255 * ci->color1[2];
	}

	CG_PositionRotatedEntityOnTag( &flash, &gun, weapon->weaponModel, "tag_flash");
	trap_R_AddRefEntityToScene( &flash );

	if ( ps || cg.renderingThirdPerson ||
		cent->currentState.number != cg.predictedPlayerState.clientNum ) {
		// add lightning bolt
		CG_LightningBolt( nonPredictedCent, flash.origin );

		// add rail trail
		CG_SpawnRailTrail( cent, flash.origin );

		if ( weapon->flashDlightColor[0] || weapon->flashDlightColor[1] || weapon->flashDlightColor[2] ) {
			trap_R_AddLightToScene( flash.origin, 300 + (rand()&31), weapon->flashDlightColor[0],
				weapon->flashDlightColor[1], weapon->flashDlightColor[2] );
		}
	}
}

/*
==============
CG_AddViewWeapon

Add the weapon, and flash for the player's view
==============
*/
void CG_AddViewWeapon( playerState_t *ps ) {
	refEntity_t	hand;
	centity_t	*cent;
	clientInfo_t	*ci;
	float		fovOffset;
	float	lengthscale;
	vec3_t		angles;
	weaponInfo_t	*weapon;

	if ( ps->persistant[PERS_TEAM] == TEAM_SPECTATOR ) {
		return;
	}

	if ( ps->pm_type == PM_INTERMISSION ) {
		return;
	}

	// no gun if in third person view or a camera is active
	//if ( cg.renderingThirdPerson || cg.cameraMode) {
	if ( cg.renderingThirdPerson ) {
		return;
	}


	// allow the gun to be completely removed
	if ( cg_drawGun.integer == 0 ) {
		vec3_t		origin;

		if ( cg.predictedPlayerState.eFlags & EF_FIRING ) {
			// special hack for lightning gun...
			VectorCopy( cg.refdef.vieworg, origin );
			VectorMA( origin, -8, cg.refdef.viewaxis[2], origin );
			CG_LightningBolt( &cg_entities[ps->clientNum], origin );
		}
		return;
	}

	// don't draw if testing a gun model
	if ( cg.testGun ) {
		return;
	}

	// drop gun lower at higher fov
	if ( cg_fov.integer > 90 && cg_drawGun.integer == 1 ) {
		fovOffset = -0.2 * ( cg_fov.integer - 90 );
	} else {
		fovOffset = 0;
	}

	cent = &cg.predictedPlayerEntity;	// &cg_entities[cg.snap->ps.clientNum];
	CG_RegisterWeapon( ps->weapon );
	weapon = &cg_weapons[ ps->weapon ];

	memset (&hand, 0, sizeof(hand));

	// set up gun position
	CG_CalculateWeaponPosition( hand.origin, angles );

	VectorMA( hand.origin, cg_gun_x.value, cg.refdef.viewaxis[0], hand.origin );
	VectorMA( hand.origin, cg_gun_y.value, cg.refdef.viewaxis[1], hand.origin );
	VectorMA( hand.origin, (cg_gun_z.value+fovOffset), cg.refdef.viewaxis[2], hand.origin );

	AnglesToAxis( angles, hand.axis );

	// map torso animations to weapon animations
	if ( cg_gun_frame.integer ) {
		// development tool
		hand.frame = hand.oldframe = cg_gun_frame.integer;
		hand.backlerp = 0;
	} else {
		// get clientinfo for animation map
		ci = &cgs.clientinfo[ cent->currentState.clientNum ];
		hand.frame = CG_MapTorsoToWeaponFrame( ci, cent->pe.torso.frame );
		hand.oldframe = CG_MapTorsoToWeaponFrame( ci, cent->pe.torso.oldFrame );
		hand.backlerp = cent->pe.torso.backlerp;
	}

	hand.hModel = weapon->handsModel;

	if ( cg_drawGun.integer >= 50 && cg_drawGun.integer <= 160 ) {
		lengthscale = 1.0f * tan( DEG2RAD(cg_drawGun.integer/2) );
	} else if ( cg_drawGun.integer == -1 ) {
		lengthscale = 1.0f / tan( DEG2RAD(cg_fov.integer/2) );
	} else {
		lengthscale = 1.0f;
	}
	VectorScale(hand.axis[0], lengthscale, hand.axis[0]);
	

	hand.renderfx = RF_DEPTHHACK | RF_FIRST_PERSON | RF_MINLIGHT;

	// add everything onto the hand
	CG_AddPlayerWeapon( &hand, ps, &cg.predictedPlayerEntity, ps->persistant[PERS_TEAM] );
}

/*
==============================================================================

WEAPON SELECTION

==============================================================================
*/

/*
===================
CG_DrawWeaponSelect
===================
*/
void CG_DrawWeaponSelect( void ) {
	int		i;
	int		bits;
	int		count;
	int		x, y, w;
	char	*name;
	float	*color;

	// don't display if dead
	/* Was already checked.
	if ( cg.predictedPlayerState.stats[STAT_HEALTH] <= 0 ) {
		return;
	}*/

	color = CG_FadeColor( cg.weaponSelectTime, WEAPON_SELECT_TIME );
	if ( !color ) {
		return;
	}
	trap_R_SetColor( color );

	// showing weapon select clears pickup item display, but not the blend blob
	cg.itemPickupTime = 0;

	// count the number of weapons owned
	bits = cg.snap->ps.stats[ STAT_WEAPONS ];
	count = 0;
	for ( i = 1 ; i < 16 ; i++ ) {
		if ( bits & ( 1 << i ) ) {
			count++;
		}
	}

	x = 320 - count * 20;
	y = 380;

	for ( i = 1 ; i < 16 ; i++ ) {
		if ( !( bits & ( 1 << i ) ) ) {
			continue;
		}

		CG_RegisterWeapon( i );

		// draw weapon icon
		CG_DrawPic( x, y, 32, 32, cg_weapons[i].weaponIcon );

		// draw selection marker
		if ( i == WEAPON_MASK(cg.weaponSelect) ) {
			CG_DrawPic( x-4, y-4, 40, 40, cgs.media.selectShader );
		}

		// no ammo cross on top
		if ( !cg.snap->ps.ammo[ i ] ) {
			CG_DrawPic( x, y, 32, 32, cgs.media.noammoShader );
		}

		x += 40;
	}

	// draw the selected name
	if ( cg_weapons[ WEAPON_MASK(cg.weaponSelect) ].item ) {
		name = cg_weapons[ WEAPON_MASK(cg.weaponSelect) ].item->pickup_name;
		if ( name ) {
			w = CG_DrawStrlen( name ) * BIGCHAR_WIDTH;
			x = ( SCREEN_WIDTH - w ) / 2;
			CG_DrawBigStringColor(x, y - 22, name, color);
		}
	}

	trap_R_SetColor( NULL );
}


/*
===============
CG_WeaponSelectable
===============
*/
static qboolean CG_WeaponSelectable( int i ) {
	if ( !cg.snap->ps.ammo[i] ) {
		return qfalse;
	}
	if ( ! (cg.snap->ps.stats[ STAT_WEAPONS ] & ( 1 << i ) ) ) {
		return qfalse;
	}

	return qtrue;
}

/*
===============
CG_NextWeapon_f
===============
*/
void CG_NextWeapon_f( void ) {
	int		i;
	int		original;
	//char	command[64];
	//char	weaponNum[8];

	if ( !cg.snap ) {
		return;
	}
	if ( cg.snap->ps.pm_flags & PMF_FOLLOW ) {
		return;
	}

	cg.weaponSelectTime = cg.time;
	original = WEAPON_MASK(cg.weaponSelect);

	for ( i = 0 ; i < 16 ; i++ ) {
		SET_WEAPON(cg.weaponSelect, cg.weaponSelect + 1);
		if ( WEAPON_MASK(cg.weaponSelect) == 16 ) {
			SET_WEAPON(cg.weaponSelect, 0);
		}
		if ( WEAPON_MASK(cg.weaponSelect) == WP_GAUNTLET && !cg_fullWeaponCycle.integer) {
			continue;		// never cycle to gauntlet
		}
		if ( CG_WeaponSelectable( WEAPON_MASK(cg.weaponSelect) ) ) {
			break;
		}
	}
	if ( i == 16 ) {
		SET_WEAPON(cg.weaponSelect, original);
	}
	//Hack, but we're using the byte weapon; to transfer hitscan results
	//if ( cg.weaponSelect >= WP_NONE && cg.weaponSelect <= WP_NUM_WEAPONS && cg.weaponSelect != original ) {
		//Com_sprintf(weaponNum, 8, "%i", cg.weaponSelect);
	//	Com_sprintf(command, 64, "WeaponSwitch %i \n", cg.weaponSelect);
	//	trap_SendClientCommand( command );
	//}
}

/*
===============
CG_PrevWeapon_f
===============
*/
void CG_PrevWeapon_f( void ) {
	int		i;
	int		original;
	//char	command[64];
	//char	weaponNum[8];

	if ( !cg.snap ) {
		return;
	}
	if ( cg.snap->ps.pm_flags & PMF_FOLLOW ) {
		return;
	}

	cg.weaponSelectTime = cg.time;
	original = WEAPON_MASK(cg.weaponSelect);

	for ( i = 0 ; i < 16 ; i++ ) {
		SET_WEAPON(cg.weaponSelect, cg.weaponSelect - 1);
		if ( WEAPON_MASK(cg.weaponSelect) == -1 ) {
			SET_WEAPON(cg.weaponSelect, 15);
		}
		if ( WEAPON_MASK(cg.weaponSelect) == WP_GAUNTLET && !cg_fullWeaponCycle.integer) {
			continue;		// never cycle to gauntlet
		}
		if ( CG_WeaponSelectable( WEAPON_MASK(cg.weaponSelect) ) ) {
			break;
		}
	}
	if ( i == 16 ) {
		SET_WEAPON(cg.weaponSelect, original);
	}
	//Hack, but we're using the byte weapon; to transfer hitscan results
	//if ( cg.weaponSelect >= WP_NONE && cg.weaponSelect <= WP_NUM_WEAPONS && cg.weaponSelect != original ) {
		//Com_sprintf(weaponNum, 8, "%i", cg.weaponSelect);
	//	Com_sprintf(command, 64, "WeaponSwitch %i \n", cg.weaponSelect);
	//	trap_SendClientCommand( command );
	//}
}

/*
===============
CG_Weapon_f
===============
*/
void CG_Weapon_f( void ) {
	int		num;
	//char	command[64];
	//char	weaponNum[8];

	if ( !cg.snap ) {
		return;
	}
	if ( cg.snap->ps.pm_flags & PMF_FOLLOW ) {
		return;
	}

	num = atoi( CG_Argv( 1 ) );

	if ( num < 1 || num > 15 ) {
		return;
	}

	cg.weaponSelectTime = cg.time;

	if ( ! ( cg.snap->ps.stats[STAT_WEAPONS] & ( 1 << num ) ) ) {
		return;		// don't have the weapon
	}

	SET_WEAPON(cg.weaponSelect, num);
	//Hack, but we're using the byte weapon; to transfer hitscan results
	//if ( cg.weaponSelect >= WP_NONE && cg.weaponSelect <= WP_NUM_WEAPONS ) {
		//Com_sprintf(weaponNum, 8, "%i", cg.weaponSelect);
	//	Com_sprintf(command, 64, "WeaponSwitch %i \n", cg.weaponSelect);
	//	trap_SendClientCommand( command );
	//}
}

/*
===================
CG_OutOfAmmoChange

The current weapon has just run out of ammo
===================
*/
void CG_OutOfAmmoChange( void ) {
	int		i;

	cg.weaponSelectTime = cg.time;

	for ( i = 15 ; i > 0 ; i-- ) {
		if ( CG_WeaponSelectable( i ) ) {
			SET_WEAPON(cg.weaponSelect, i);
			break;
		}
	}
}



/*
===================================================================================================

WEAPON EVENTS

===================================================================================================
*/

/*
================
CG_FireWeapon

Caused by an EV_FIRE_WEAPON event
================
*/
void CG_FireWeapon( centity_t *cent ) {
	entityState_t *ent;
	int				c;
	weaponInfo_t	*weap;

	ent = &cent->currentState;
	if ( ent->weapon == WP_NONE ) {
		return;
	}
	if ( ent->weapon >= WP_NUM_WEAPONS ) {
		CG_Error( "CG_FireWeapon: ent->weapon >= WP_NUM_WEAPONS" );
		return;
	}
	weap = &cg_weapons[ ent->weapon ];

	// mark the entity as muzzle flashing, so when it is added it will
	// append the flash to the weapon model
	cent->muzzleFlashTime = cg.time;
	if ( !cg_muzzleFlash.integer ) {
		cent->muzzleFlashTime = 0;
	}

	// lightning gun only does this this on initial press
	if ( ent->weapon == WP_LIGHTNING ) {
		if ( cent->pe.lightningFiring ) {
			return;
		}
	}

	// play quad sound if needed
	if ( cent->currentState.powerups & ( 1 << PW_QUAD ) ) {
		trap_S_StartSound (NULL, cent->currentState.number, CHAN_ITEM, cgs.media.quadSound );
	}

	// play a sound
	for ( c = 0 ; c < 4 ; c++ ) {
		if ( !weap->flashSound[c] ) {
			break;
		}
	}
	if ( c > 0 ) {
		c = rand() % c;
		if ( weap->flashSound[c] )
		{
			trap_S_StartSound( NULL, ent->number, CHAN_WEAPON, weap->flashSound[c] );
		}
	}

	// do brass ejection
	if ( weap->ejectBrassFunc && cg_brassTime.integer > 0 ) {
		weap->ejectBrassFunc( cent );
	}

//unlagged - attack prediction #1
	CG_PredictWeaponEffects( cent );
//unlagged - attack prediction #1
}

void CG_FireGrapple( centity_t *cent ) {
	entityState_t *ent;
	//weaponInfo_t	*weap;

	//no grapple allowed
	if( weap_enableHook.integer == 0 ) {
		return;
	}
	
	ent = &cent->currentState;
	//weap = &cg_weapons[ WP_GRAPPLING_HOOK ];

	// mark the entity as muzzle flashing, so when it is added it will
	// append the flash to the weapon model
	// cent->muzzleFlashTime = cg.time;
	cent->muzzleFlashTime = 0;

	//no clue why sound isn't played...
	//Evo: removed sound cuz it sucks. annoying as hell and this _isn't_ the right way
	//if ( cg.time >= cgs.grappleSoundPlayAgain ) {
	//	trap_S_StartSound( NULL, ent->number, CHAN_ITEM, cgs.media.grappleSound );
	//	cgs.grappleSoundPlayAgain = cg.time + 1985;
	//}


	//unlagged - attack prediction #1
	//CG_PredictWeaponEffects( cent );
	//unlagged - attack prediction #1
}

/*
=================
CG_MissileHitWall

Caused by an EV_MISSILE_MISS event, or directly by local bullet tracing
=================
*/
void CG_MissileHitWall( int weapon, int clientNum, vec3_t origin, vec3_t dir, impactSound_t soundType ) {
	qhandle_t		mod;
	qhandle_t		mark;
	qhandle_t		shader;
	sfxHandle_t		sfx;
	float			radius;
	float			light;
	vec3_t			lightColor;
	localEntity_t	*le;
	int				r;
	qboolean		alphaFade;
	qboolean		isSprite;
	int				duration;
	vec3_t			sprOrg;
	vec3_t			sprVel;

	mark = 0;
	radius = 32;
	sfx = 0;
	mod = 0;
	shader = 0;
	light = 0;
	lightColor[0] = 1;
	lightColor[1] = 1;
	lightColor[2] = 0;

	// set defaults
	isSprite = qfalse;
	duration = 600;

	switch ( weapon ) {
	default:
#ifdef MISSIONPACK
	case WP_NAILGUN:
		if( soundType == IMPACTSOUND_FLESH ) {
			sfx = cgs.media.sfx_nghitflesh;
		} else if( soundType == IMPACTSOUND_METAL ) {
			sfx = cgs.media.sfx_nghitmetal;
		} else {
			sfx = cgs.media.sfx_nghit;
		}
		mark = cgs.media.holeMarkShader;
		radius = 12;
		break;
#endif
	case WP_LIGHTNING:
		// no explosion at LG impact, it is added with the beam
		r = rand() & 3;
		if ( r < 2 ) {
			sfx = cgs.media.sfx_lghit2;
		} else if ( r == 2 ) {
			sfx = cgs.media.sfx_lghit1;
		} else {
			sfx = cgs.media.sfx_lghit3;
		}
		mark = cgs.media.holeMarkShader;
		radius = 12;
		break;
#ifdef MISSIONPACK
	case WP_PROX_LAUNCHER:
		mod = cgs.media.dishFlashModel;
		shader = cgs.media.grenadeExplosionShader;
		sfx = cgs.media.sfx_proxexp;
		mark = cgs.media.burnMarkShader;
		radius = 64;
		light = 300;
		isSprite = qtrue;
		break;
#endif
	case WP_GRENADE_LAUNCHER:
		mod = cgs.media.dishFlashModel;
		shader = cgs.media.grenadeExplosionShader;
		sfx = cgs.media.sfx_rockexp;
		mark = cgs.media.burnMarkShader;
		radius = 64;
		light = 300;
		isSprite = qtrue;
		break;
	case WP_ROCKET_LAUNCHER:
		mod = cgs.media.dishFlashModel;
		shader = cgs.media.rocketExplosionShader;
		sfx = cgs.media.sfx_rockexp;
		mark = cgs.media.burnMarkShader;
		radius = 64;
		light = 300;
		isSprite = qtrue;
		duration = 1000;
		lightColor[0] = 1;
		lightColor[1] = 0.75;
		lightColor[2] = 0.0;
		if (cg_oldRocket.integer == 0) {
			// explosion sprite animation
			VectorMA( origin, 24, dir, sprOrg );
			VectorScale( dir, 64, sprVel );

			CG_ParticleExplosion( "explode1", sprOrg, sprVel, 1400, 20, 30 );
		}
		break;
	case WP_RAILGUN:
		mod = cgs.media.ringFlashModel;
		shader = cgs.media.railExplosionShader;
		sfx = cgs.media.sfx_plasmaexp;
		mark = cgs.media.energyMarkShader;
		radius = 24;
		break;
	case WP_PLASMAGUN:
		mod = cgs.media.ringFlashModel;
		shader = cgs.media.plasmaExplosionShader;
		sfx = cgs.media.sfx_plasmaexp;
		mark = cgs.media.energyMarkShader;
		radius = 16;
		break;
	case WP_BFG:
		mod = cgs.media.dishFlashModel;
		shader = cgs.media.bfgExplosionShader;
		sfx = cgs.media.sfx_rockexp;
		mark = cgs.media.burnMarkShader;
		radius = 32;
		isSprite = qtrue;
		break;
	case WP_SHOTGUN:
		mod = cgs.media.bulletFlashModel;
		shader = cgs.media.bulletExplosionShader;
		mark = cgs.media.bulletMarkShader;
		sfx = 0;
		radius = 4;
		break;

#ifdef MISSIONPACK
	case WP_CHAINGUN:
		mod = cgs.media.bulletFlashModel;
		if( soundType == IMPACTSOUND_FLESH ) {
			sfx = cgs.media.sfx_chghitflesh;
		} else if( soundType == IMPACTSOUND_METAL ) {
			sfx = cgs.media.sfx_chghitmetal;
		} else {
			sfx = cgs.media.sfx_chghit;
		}
		mark = cgs.media.bulletMarkShader;

		r = rand() & 3;
		if ( r < 2 ) {
			sfx = cgs.media.sfx_ric1;
		} else if ( r == 2 ) {
			sfx = cgs.media.sfx_ric2;
		} else {
			sfx = cgs.media.sfx_ric3;
		}

		radius = 8;
		break;
#endif

	case WP_MACHINEGUN:
		mod = cgs.media.bulletFlashModel;
		shader = cgs.media.bulletExplosionShader;
		mark = cgs.media.bulletMarkShader;

		r = rand() & 3;
		if ( r == 0 ) {
			sfx = cgs.media.sfx_ric1;
		} else if ( r == 1 ) {
			sfx = cgs.media.sfx_ric2;
		} else {
			sfx = cgs.media.sfx_ric3;
		}

		radius = 8;
		break;
	}

	if ( sfx ) {
		trap_S_StartSound( origin, ENTITYNUM_WORLD, CHAN_AUTO, sfx );
	}

	//
	// create the explosion
	//
	if ( mod ) {
		le = CG_MakeExplosion( origin, dir, 
							   mod,	shader,
							   duration, isSprite );
		le->light = light;
		VectorCopy( lightColor, le->lightColor );
		if ( weapon == WP_RAILGUN ) {
			// colorize with client color
			VectorCopy( cgs.clientinfo[clientNum].color1, le->color );
		}
	}

	//
	// impact mark
	//
	alphaFade = (mark == cgs.media.energyMarkShader);	// plasma fades alpha, all others fade color
	if ( weapon == WP_RAILGUN ) {
		//float	*color;
		vec4_t	color;

		// colorize with client color
/*freeze*/if ( (cgs.clientinfo[clientNum].team != cgs.clientinfo[ cg.clientNum ].team && strlen(cg_EnemyColors.string) !=3 
					&& cgs.gametype >= GT_TEAM && cgs.clientinfo[cg.clientNum].team != TEAM_SPECTATOR ||
					(cgs.gametype < GT_TEAM && !cgs.clientinfo[clientNum].localClient && strlen(cg_EnemyColors.string) !=3 ) ) ) {
						if ( strlen( cg_EnemyColors.string ) == 2 ) {
							memcpy(color, g_color_table[ColorIndex(cg_EnemyColors.string[1])], sizeof(color));
						} else {
							memcpy(color, g_color_table[ColorIndex(cg_EnemyColors.string[4])], sizeof(color));
						}
				} else if ( cgs.clientinfo[clientNum].team == cgs.clientinfo[ cg.clientNum ].team && strlen(cg_TeamColors.string) != 3
					&& cgs.gametype >= GT_TEAM && !cgs.clientinfo[clientNum].localClient ) {
						if ( strlen(cg_TeamColors.string) == 2 ) {
							memcpy(color, g_color_table[ColorIndex(cg_TeamColors.string[1])], sizeof(color));
						} else {
							memcpy(color, g_color_table[ColorIndex(cg_TeamColors.string[4])], sizeof(color));
						}
				} else if ( cgs.clientinfo[clientNum].team == cgs.clientinfo[ cg.clientNum ].team && strlen(cg_TeamColors.string) != 3
					&& cgs.gametype >= GT_TEAM && !cgs.clientinfo[clientNum].localClient && cg_forceColors.integer ) {
						memcpy(color, cgs.clientinfo[clientNum].color2, sizeof(color));
				} else {
					memcpy(color, cgs.clientinfo[clientNum].color2, sizeof(color));
				}

		//color = cgs.clientinfo[clientNum].color2;
/*freeze*/
//		color = cgs.clientinfo[ clientNum ].color1;
//freeze
		CG_ImpactMark( mark, origin, dir, random()*360, color[0],color[1], color[2],1, alphaFade, radius, qfalse );
	} else {
		CG_ImpactMark( mark, origin, dir, random()*360, 1,1,1,1, alphaFade, radius, qfalse );
	}
}


/*
=================
CG_MissileHitPlayer
=================
*/
void CG_MissileHitPlayer( int weapon, vec3_t origin, vec3_t dir, int entityNum ) {
	CG_Bleed( origin, entityNum );

	// some weapons will make an explosion with the blood, while
	// others will just make the blood
	switch ( weapon ) {
	case WP_GRENADE_LAUNCHER:
	case WP_ROCKET_LAUNCHER:
#ifdef MISSIONPACK
	case WP_NAILGUN:
	case WP_CHAINGUN:
	case WP_PROX_LAUNCHER:
#endif
		CG_MissileHitWall( weapon, 0, origin, dir, IMPACTSOUND_FLESH );
		break;
	default:
		break;
	}
}



/*
============================================================================

SHOTGUN TRACING

============================================================================
*/

/*
================
CG_ShotgunPellet
================
*/
static void CG_ShotgunPellet( vec3_t start, vec3_t end, int skipNum ) {
	trace_t		tr;
	int sourceContentType, destContentType;

	CG_Trace( &tr, start, NULL, NULL, end, skipNum, MASK_SHOT );

	sourceContentType = trap_CM_PointContents( start, 0 );
	destContentType = trap_CM_PointContents( tr.endpos, 0 );

	// FIXME: should probably move this cruft into CG_BubbleTrail
	if ( sourceContentType == destContentType ) {
		if ( cg_noProjectileTrail.integer ) {
			if ( sourceContentType & CONTENTS_WATER ) {
				CG_BubbleTrail( start, tr.endpos, 32 );
			}
		}
	} else if ( sourceContentType & CONTENTS_WATER ) {
		trace_t trace;

		trap_CM_BoxTrace( &trace, end, start, NULL, NULL, 0, CONTENTS_WATER );
		CG_BubbleTrail( start, trace.endpos, 32 );
	} else if ( destContentType & CONTENTS_WATER ) {
		trace_t trace;

		trap_CM_BoxTrace( &trace, start, end, NULL, NULL, 0, CONTENTS_WATER );
		CG_BubbleTrail( tr.endpos, trace.endpos, 32 );
	}

	if (  tr.surfaceFlags & SURF_NOIMPACT ) {
		return;
	}

	if ( cg_entities[tr.entityNum].currentState.eType == ET_PLAYER ) {
		CG_MissileHitPlayer( WP_SHOTGUN, tr.endpos, tr.plane.normal, tr.entityNum );
	} else {
		if ( tr.surfaceFlags & SURF_NOIMPACT ) {
			// SURF_NOIMPACT will not make a flame puff or a mark
			return;
		}
		if ( tr.surfaceFlags & SURF_METALSTEPS ) {
			CG_MissileHitWall( WP_SHOTGUN, 0, tr.endpos, tr.plane.normal, IMPACTSOUND_METAL );
		} else {
			CG_MissileHitWall( WP_SHOTGUN, 0, tr.endpos, tr.plane.normal, IMPACTSOUND_DEFAULT );
		}
	}
}

/*
================
CG_ShotgunPattern

Perform the same traces the server did to locate the
hit splashes
================
*/
//unlagged - attack prediction
// made this non-static for access from cg_unlagged.c
void CG_ShotgunPattern( vec3_t origin, vec3_t origin2, int seed, int otherEntNum ) {
	int			i;
	float		r, u;
	vec3_t		end;
	vec3_t		forward, right, up;

	// derive the right and up vectors from the forward vector, because
	// the client won't have any other information
	VectorNormalize2( origin2, forward );
	PerpendicularVector( right, forward );
	CrossProduct( forward, right, up );

	// generate the "random" spread pattern
	for ( i = 0 ; i < DEFAULT_SHOTGUN_COUNT ; i++ ) {
		r = Q_crandom( &seed ) * DEFAULT_SHOTGUN_SPREAD * 16;
		u = Q_crandom( &seed ) * DEFAULT_SHOTGUN_SPREAD * 16;
//	for ( i = 0 ; i < cpm_SSGcount ; i++ ) { // CPM
//		r = crandom() * cpm_SSGspread;  // CPM
//		u = crandom() * cpm_SSGspread;  // CPM
		VectorMA( origin, 8192 * 16, forward, end);
		VectorMA (end, r, right, end);
		VectorMA (end, u, up, end);

		CG_ShotgunPellet( origin, end, otherEntNum );
	}
}

/*
==============
CG_ShotgunFire
==============
*/
void CG_ShotgunFire( entityState_t *es ) {
	vec3_t	v;
	int		contents;

	VectorSubtract( es->origin2, es->pos.trBase, v );
	VectorNormalize( v );
	VectorScale( v, 32, v );
	VectorAdd( es->pos.trBase, v, v );
	if ( cgs.glconfig.hardwareType != GLHW_RAGEPRO ) {
		// ragepro can't alpha fade, so don't even bother with smoke
		vec3_t			up;

		contents = trap_CM_PointContents( es->pos.trBase, 0 );
		if ( cg_smoke_SG.integer ) {
			if ( !( contents & CONTENTS_WATER ) ) {
				VectorSet( up, 0, 0, 8 );
				CG_SmokePuff( v, up, 32, 1, 1, 1, 0.33f, 900, cg.time, 0, LEF_PUFF_DONT_SCALE, cgs.media.shotgunSmokePuffShader );
			}
		}
	}
	CG_ShotgunPattern( es->pos.trBase, es->origin2, es->eventParm, es->otherEntityNum );
}

/*
============================================================================

BULLETS

============================================================================
*/


/*
===============
CG_Tracer
===============
*/
void CG_Tracer( vec3_t source, vec3_t dest ) {
	vec3_t		forward, right;
	polyVert_t	verts[4];
	vec3_t		line;
	float		len, begin, end;
	vec3_t		start, finish;
	vec3_t		midpoint;

	// tracer
	VectorSubtract( dest, source, forward );
	len = VectorNormalize( forward );

	// start at least a little ways from the muzzle
	if ( len < 100 ) {
		return;
	}
	begin = 50 + random() * (len - 60);
	end = begin + cg_tracerLength.value;
	if ( end > len ) {
		end = len;
	}
	VectorMA( source, begin, forward, start );
	VectorMA( source, end, forward, finish );

	line[0] = DotProduct( forward, cg.refdef.viewaxis[1] );
	line[1] = DotProduct( forward, cg.refdef.viewaxis[2] );

	VectorScale( cg.refdef.viewaxis[1], line[1], right );
	VectorMA( right, -line[0], cg.refdef.viewaxis[2], right );
	VectorNormalize( right );

	VectorMA( finish, cg_tracerWidth.value, right, verts[0].xyz );
	verts[0].st[0] = 0;
	verts[0].st[1] = 1;
	verts[0].modulate[0] = 255;
	verts[0].modulate[1] = 255;
	verts[0].modulate[2] = 255;
	verts[0].modulate[3] = 255;

	VectorMA( finish, -cg_tracerWidth.value, right, verts[1].xyz );
	verts[1].st[0] = 1;
	verts[1].st[1] = 0;
	verts[1].modulate[0] = 255;
	verts[1].modulate[1] = 255;
	verts[1].modulate[2] = 255;
	verts[1].modulate[3] = 255;

	VectorMA( start, -cg_tracerWidth.value, right, verts[2].xyz );
	verts[2].st[0] = 1;
	verts[2].st[1] = 1;
	verts[2].modulate[0] = 255;
	verts[2].modulate[1] = 255;
	verts[2].modulate[2] = 255;
	verts[2].modulate[3] = 255;

	VectorMA( start, cg_tracerWidth.value, right, verts[3].xyz );
	verts[3].st[0] = 0;
	verts[3].st[1] = 0;
	verts[3].modulate[0] = 255;
	verts[3].modulate[1] = 255;
	verts[3].modulate[2] = 255;
	verts[3].modulate[3] = 255;

	trap_R_AddPolyToScene( cgs.media.tracerShader, 4, verts );

	midpoint[0] = ( start[0] + finish[0] ) * 0.5;
	midpoint[1] = ( start[1] + finish[1] ) * 0.5;
	midpoint[2] = ( start[2] + finish[2] ) * 0.5;

	// add the tracer sound
	trap_S_StartSound( midpoint, ENTITYNUM_WORLD, CHAN_AUTO, cgs.media.tracerSound );

}


/*
======================
CG_CalcMuzzlePoint
======================
*/
static qboolean	CG_CalcMuzzlePoint( int entityNum, vec3_t muzzle ) {
	vec3_t		forward;
	centity_t	*cent;
	int			anim;

	if ( entityNum == cg.snap->ps.clientNum ) {
		VectorCopy( cg.snap->ps.origin, muzzle );
		muzzle[2] += cg.snap->ps.viewheight;
		AngleVectors( cg.snap->ps.viewangles, forward, NULL, NULL );
		VectorMA( muzzle, 14, forward, muzzle );
		return qtrue;
	}

	cent = &cg_entities[entityNum];
	if ( !cent->currentValid ) {
		return qfalse;
	}

	VectorCopy( cent->currentState.pos.trBase, muzzle );

	AngleVectors( cent->currentState.apos.trBase, forward, NULL, NULL );
	anim = cent->currentState.legsAnim & ~ANIM_TOGGLEBIT;
	if ( anim == LEGS_WALKCR || anim == LEGS_IDLECR ) {
		muzzle[2] += CROUCH_VIEWHEIGHT;
	} else {
		muzzle[2] += DEFAULT_VIEWHEIGHT;
	}

	VectorMA( muzzle, 14, forward, muzzle );

	return qtrue;

}

/*
======================
CG_Bullet

Renders bullet effects.
======================
*/
void CG_Bullet( vec3_t end, int sourceEntityNum, vec3_t normal, qboolean flesh, int fleshEntityNum ) {
	trace_t trace;
	int sourceContentType, destContentType;
	vec3_t		start;

	// if the shooter is currently valid, calc a source point and possibly
	// do trail effects
	if ( sourceEntityNum >= 0 && cg_tracerChance.value > 0 ) {
		if ( CG_CalcMuzzlePoint( sourceEntityNum, start ) ) {
			sourceContentType = trap_CM_PointContents( start, 0 );
			destContentType = trap_CM_PointContents( end, 0 );

			// do a complete bubble trail if necessary
			if ( ( sourceContentType == destContentType ) && ( sourceContentType & CONTENTS_WATER ) ) {
				CG_BubbleTrail( start, end, 32 );
			}
			// bubble trail from water into air
			else if ( ( sourceContentType & CONTENTS_WATER ) ) {
				trap_CM_BoxTrace( &trace, end, start, NULL, NULL, 0, CONTENTS_WATER );
				CG_BubbleTrail( start, trace.endpos, 32 );
			}
			// bubble trail from air into water
			else if ( ( destContentType & CONTENTS_WATER ) ) {
				trap_CM_BoxTrace( &trace, start, end, NULL, NULL, 0, CONTENTS_WATER );
				CG_BubbleTrail( trace.endpos, end, 32 );
			}

			// draw a tracer
			if ( random() < cg_tracerChance.value ) {
				CG_Tracer( start, end );
			}
		}
	}

	// impact splash and mark
	if ( flesh ) {
		CG_Bleed( end, fleshEntityNum );
	} else {
		CG_MissileHitWall( WP_MACHINEGUN, 0, end, normal, IMPACTSOUND_DEFAULT );
	}

}
