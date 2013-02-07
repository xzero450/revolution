// Copyright (C) 1999-2000 Id Software, Inc.
//
// cg_draw.c -- draw all of the graphical elements during
// active (after loading) gameplay

#include "cg_local.h"
#include "..\game\bg_promode.h" // CPM

#ifdef MISSIONPACK
#include "../ui/ui_shared.h"

// used for scoreboard
extern displayContextDef_t cgDC;
menuDef_t *menuScoreboard = NULL;
#else
int drawTeamOverlayModificationCount = -1;
#endif

int sortedTeamPlayers[TEAM_MAXOVERLAY];
int	numSortedTeamPlayers;

char systemChat[256];
char teamChat1[256];
char teamChat2[256];

#define MOTD_WIDTH 300.0f

int DrawMOTDBox()
{
	int x;
	int y;
	int height = SMALLCHAR_HEIGHT*9;

	vec4_t		hcolor;
	vec4_t		hcolor2;
	vec4_t		hcolor3;

	if (!cg.motdDisplayTime || cg.motdDisplayTime < cg.time)
		return 0;

	if ( !strlen(cg.sv_motd1) && !strlen(cg.sv_motd2)  && 
		 !strlen(cg.sv_motd3) && !strlen(cg.sv_motd4) &&
		 !strlen(cg.sv_motd5) && !strlen(cg.sv_motd6) &&
		 !strlen(cg.sv_motd7) && !strlen(cg.sv_motd8) ) {
			 //Nothing to display, so don't.
			 return 0;
	}

	
	hcolor[0] = 0.10;
	hcolor[1] = 0.10;
	hcolor[2] = 0.10;

	hcolor2[0] = 0;
	hcolor2[1] = 0;
	hcolor2[2] = 0;

	hcolor3[0] = 0.02;
	hcolor3[1] = 0.02;
	hcolor3[2] = 0.02;

	hcolor[3] = 0.75;
	hcolor2[3] = 1;
	hcolor3[3] = 0.5;

	//trap_R_SetColor( hcolor );

	y = 480 - height - SMALLCHAR_HEIGHT*2;
	x = 640 - MOTD_WIDTH;

	if (cg.time < cg.motdScrollTime) // is the box scrolling on/off the screen?
	{
		if (cg.motdDisplayTime == cg.motdScrollTime) // scrolling off
		{
			//x = 640 - MOTD_WIDTH + MOTD_WIDTH * (((float)(cg.motdDisplayTime-cg.motdScrollTime)/1000.0f - 1.0f) * -1.0f);
			x = 640 - MOTD_WIDTH * (float)(cg.motdScrollTime-cg.time)/1000.0f;
		}
		else // scrolling on
		{
			x = 640 - MOTD_WIDTH + MOTD_WIDTH * (float)(cg.motdScrollTime-cg.time)/1000.0f;
		}
	}
	else if (cg.time + 1000 >= cg.motdDisplayTime)
	{
		cg.motdScrollTime = cg.motdDisplayTime;
	}


	CG_FillRect( x, y, MOTD_WIDTH-SMALLCHAR_WIDTH*2, height, hcolor );
	CG_DrawRect( x, y, MOTD_WIDTH-SMALLCHAR_WIDTH*2, height, 1, hcolor2 );
	CG_DrawRect( x+1, y+1, MOTD_WIDTH-SMALLCHAR_WIDTH*2 + 1, height + 1, 1, hcolor3 );

	x += 8;
	y += 8;

	/**/
	CG_DrawSmallString( x, y, cg.sv_motd1, 1 );
	y += SMALLCHAR_HEIGHT;

	CG_DrawSmallString( x, y, cg.sv_motd2, 1 );
	y += SMALLCHAR_HEIGHT;

	CG_DrawSmallString( x, y, cg.sv_motd3, 1 );
	y += SMALLCHAR_HEIGHT;

	CG_DrawSmallString( x, y, cg.sv_motd4, 1 );
	y += SMALLCHAR_HEIGHT;

	CG_DrawSmallString( x, y, cg.sv_motd5, 1 );
	y += SMALLCHAR_HEIGHT;

	CG_DrawSmallString( x, y, cg.sv_motd6, 1 );
	y += SMALLCHAR_HEIGHT;

	CG_DrawSmallString( x, y, cg.sv_motd7, 1 );
	y += SMALLCHAR_HEIGHT;

	CG_DrawSmallString( x, y, cg.sv_motd8, 1 );
	y += SMALLCHAR_HEIGHT;

	/** /

	CG_DrawBigString( x, y, cg.sv_motd1, 1 );
	y += SMALLCHAR_HEIGHT;

	CG_DrawBigString( x, y, cg.sv_motd2, 1 );
	y += SMALLCHAR_HEIGHT;

	CG_DrawBigString( x, y, cg.sv_motd3, 1 );
	y += SMALLCHAR_HEIGHT;

	CG_DrawBigString( x, y, cg.sv_motd4, 1 );
	y += SMALLCHAR_HEIGHT;

	CG_DrawBigString( x, y, cg.sv_motd5, 1 );
	y += SMALLCHAR_HEIGHT;

	CG_DrawBigString( x, y, cg.sv_motd6, 1 );
	y += SMALLCHAR_HEIGHT;

	CG_DrawBigString( x, y, cg.sv_motd7, 1 );
	y += SMALLCHAR_HEIGHT;

	CG_DrawBigString( x, y, cg.sv_motd8, 1 );
	y += SMALLCHAR_HEIGHT;
	/**/

	return 1;
}

#ifdef MISSIONPACK

int CG_Text_Width(const char *text, float scale, int limit) {
  int count,len;
	float out;
	glyphInfo_t *glyph;
	float useScale;
// FIXME: see ui_main.c, same problem
//	const unsigned char *s = text;
	const char *s = text;
	fontInfo_t *font = &cgDC.Assets.textFont;
	if (scale <= cg_smallFont.value) {
		font = &cgDC.Assets.smallFont;
	} else if (scale > cg_bigFont.value) {
		font = &cgDC.Assets.bigFont;
	}
	useScale = scale * font->glyphScale;
  out = 0;
  if (text) {
    len = strlen(text);
		if (limit > 0 && len > limit) {
			len = limit;
		}
		count = 0;
		while (s && *s && count < len) {
			if ( Q_IsColorString(s) ) {
				s += 2;
				continue;
			} else {
				glyph = &font->glyphs[(int)*s]; // TTimo: FIXME: getting nasty warnings without the cast, hopefully this doesn't break the VM build
				out += glyph->xSkip;
				s++;
				count++;
			}
    }
  }
  return out * useScale;
}

int CG_Text_Height(const char *text, float scale, int limit) {
  int len, count;
	float max;
	glyphInfo_t *glyph;
	float useScale;
// TTimo: FIXME
//	const unsigned char *s = text;
	const char *s = text;
	fontInfo_t *font = &cgDC.Assets.textFont;
	if (scale <= cg_smallFont.value) {
		font = &cgDC.Assets.smallFont;
	} else if (scale > cg_bigFont.value) {
		font = &cgDC.Assets.bigFont;
	}
	useScale = scale * font->glyphScale;
  max = 0;
  if (text) {
    len = strlen(text);
		if (limit > 0 && len > limit) {
			len = limit;
		}
		count = 0;
		while (s && *s && count < len) {
			if ( Q_IsColorString(s) ) {
				s += 2;
				continue;
			} else {
				glyph = &font->glyphs[(int)*s]; // TTimo: FIXME: getting nasty warnings without the cast, hopefully this doesn't break the VM build
	      if (max < glyph->height) {
		      max = glyph->height;
			  }
				s++;
				count++;
			}
    }
  }
  return max * useScale;
}

void CG_Text_PaintChar(float x, float y, float width, float height, float scale, float s, float t, float s2, float t2, qhandle_t hShader) {
  float w, h;
  w = width * scale;
  h = height * scale;
  CG_AdjustFrom640( &x, &y, &w, &h );
  trap_R_DrawStretchPic( x, y, w, h, s, t, s2, t2, hShader );
}

void CG_Text_Paint(float x, float y, float scale, vec4_t color, const char *text, float adjust, int limit, int style) {
  int len, count;
	vec4_t newColor;
	glyphInfo_t *glyph;
	float useScale;
	fontInfo_t *font = &cgDC.Assets.textFont;
	if (scale <= cg_smallFont.value) {
		font = &cgDC.Assets.smallFont;
	} else if (scale > cg_bigFont.value) {
		font = &cgDC.Assets.bigFont;
	}
	useScale = scale * font->glyphScale;
  if (text) {
// TTimo: FIXME
//		const unsigned char *s = text;
		const char *s = text;
		trap_R_SetColor( color );
		memcpy(&newColor[0], &color[0], sizeof(vec4_t));
    len = strlen(text);
		if (limit > 0 && len > limit) {
			len = limit;
		}
		count = 0;
		while (s && *s && count < len) {
			glyph = &font->glyphs[(int)*s]; // TTimo: FIXME: getting nasty warnings without the cast, hopefully this doesn't break the VM build
      //int yadj = Assets.textFont.glyphs[text[i]].bottom + Assets.textFont.glyphs[text[i]].top;
      //float yadj = scale * (Assets.textFont.glyphs[text[i]].imageHeight - Assets.textFont.glyphs[text[i]].height);
			if ( Q_IsColorString( s ) ) {
				memcpy( newColor, g_color_table[ColorIndex(*(s+1))], sizeof( newColor ) );
				newColor[3] = color[3];
				trap_R_SetColor( newColor );
				s += 2;
				continue;
			} else {
				float yadj = useScale * glyph->top;
				if (style == ITEM_TEXTSTYLE_SHADOWED || style == ITEM_TEXTSTYLE_SHADOWEDMORE) {
					int ofs = style == ITEM_TEXTSTYLE_SHADOWED ? 1 : 2;
					colorBlack[3] = newColor[3];
					trap_R_SetColor( colorBlack );
					CG_Text_PaintChar(x + ofs, y - yadj + ofs, 
														glyph->imageWidth,
														glyph->imageHeight,
														useScale, 
														glyph->s,
														glyph->t,
														glyph->s2,
														glyph->t2,
														glyph->glyph);
					colorBlack[3] = 1.0;
					trap_R_SetColor( newColor );
				}
				CG_Text_PaintChar(x, y - yadj, 
													glyph->imageWidth,
													glyph->imageHeight,
													useScale, 
													glyph->s,
													glyph->t,
													glyph->s2,
													glyph->t2,
													glyph->glyph);
				// CG_DrawPic(x, y - yadj, scale * cgDC.Assets.textFont.glyphs[text[i]].imageWidth, scale * cgDC.Assets.textFont.glyphs[text[i]].imageHeight, cgDC.Assets.textFont.glyphs[text[i]].glyph);
				x += (glyph->xSkip * useScale) + adjust;
				s++;
				count++;
			}
    }
	  trap_R_SetColor( NULL );
  }
}


#endif


/*
==============
CG_DrawField

Draws large numbers for status bar and powerups
==============
*/
#ifndef MISSIONPACK
static void CG_DrawField (int x, int y, int width, int value) {
	char	num[16], *ptr;
	int		l;
	int		frame;

	if ( width < 1 ) {
		return;
	}

	// draw number string
	if ( width > 5 ) {
		width = 5;
	}

	switch ( width ) {
	case 1:
		value = value > 9 ? 9 : value;
		value = value < 0 ? 0 : value;
		break;
	case 2:
		value = value > 99 ? 99 : value;
	//	value = value < -9 ? -9 : value;
		break;
	case 3:
		value = value > 999 ? 999 : value;
	//	value = value < -99 ? -99 : value;
		break;
	case 4:
		value = value > 9999 ? 9999 : value;
		//value = value > 999 ? 999 : value;
		value = value < -999 ? -999 : value;
		break;
	}

	Com_sprintf (num, sizeof(num), "%i", value);
	l = strlen(num);
	if (l > width)
		l = width;
	x += 2 + CHAR_WIDTH*(width - l);

	ptr = num;
	while (*ptr && l)
	{
		if (*ptr == '-')
			frame = STAT_MINUS;
		else
			frame = *ptr -'0';


		CG_DrawPic( x, y, CHAR_WIDTH, CHAR_HEIGHT, cgs.media.numberShaders[frame] );
		x += CHAR_WIDTH;
		
		ptr++;
		l--;
	}
}
#endif // MISSIONPACK

/*
================
CG_Draw3DModel

================
*/
void CG_Draw3DModel( float x, float y, float w, float h, qhandle_t model, qhandle_t skin, vec3_t origin, vec3_t angles ) {
	refdef_t		refdef;
	refEntity_t		ent;

	if ( !cg_draw3dIcons.integer || !cg_drawIcons.integer ) {
		return;
	}

	CG_AdjustFrom640( &x, &y, &w, &h );

	memset( &refdef, 0, sizeof( refdef ) );

	memset( &ent, 0, sizeof( ent ) );
	AnglesToAxis( angles, ent.axis );
	VectorCopy( origin, ent.origin );
	ent.hModel = model;
	ent.customSkin = skin;
	ent.renderfx = RF_NOSHADOW;		// no stencil shadows

	refdef.rdflags = RDF_NOWORLDMODEL;

	AxisClear( refdef.viewaxis );

	refdef.fov_x = 30;
	refdef.fov_y = 30;

	refdef.x = x;
	refdef.y = y;
	refdef.width = w;
	refdef.height = h;

	refdef.time = cg.time;

	trap_R_ClearScene();
	trap_R_AddRefEntityToScene( &ent );
	trap_R_RenderScene( &refdef );
}

/*
================
CG_Draw3DHeadModel
PM Skin head/color loading
================
*/
void CG_Draw3DHeadModel( float x, float y, float w, float h, qhandle_t model, qhandle_t skin, vec3_t origin, vec3_t angles, int clientNum ) {
	refdef_t		refdef;
	refEntity_t		ent;
	clientInfo_t	*ci;

	ci = &cgs.clientinfo[ clientNum ];

	if ( cg_draw3dIcons.integer ) {
		CG_AdjustFrom640( &x, &y, &w, &h );

		memset( &refdef, 0, sizeof( refdef ) );

		memset( &ent, 0, sizeof( ent ) );
		AnglesToAxis( angles, ent.axis );

			if (clientNum == cg.clientNum) {
				memcpy(ent.shaderRGBA, &cgs.clientinfo[cg.clientNum].colors[1], sizeof(ent.shaderRGBA));
			} else if (cg_forceColors.integer && cgs.clientinfo[cg.clientNum].team == ci->team && cgs.gametype >= GT_TEAM) {
				memcpy(ent.shaderRGBA, &cgs.clientinfo[cg.clientNum].colors[1], sizeof(ent.shaderRGBA));
			} else if (strlen(cg_TeamColors.string) >= 3 && cgs.clientinfo[cg.clientNum].team == ci->team && cgs.gametype >= GT_TEAM) {
				memcpy(ent.shaderRGBA, &cgs.teamColors[1], sizeof(ent.shaderRGBA));
			} else if (strlen(cg_EnemyColors.string) >= 3 && (cgs.clientinfo[cg.clientNum].team != ci->team || cgs.gametype < GT_TEAM) ) {
				memcpy(ent.shaderRGBA, &cgs.enemyColors[1], sizeof(ent.shaderRGBA));
			} else {
				memcpy(ent.shaderRGBA, &ci->colors[1], sizeof(ent.shaderRGBA));
			}

		VectorCopy( origin, ent.origin );
		ent.hModel = model;
		ent.customSkin = skin;
		ent.renderfx = RF_NOSHADOW;		// no stencil shadows

		refdef.rdflags = RDF_NOWORLDMODEL;

		AxisClear( refdef.viewaxis );

		refdef.fov_x = 30;
		refdef.fov_y = 30;

		refdef.x = x;
		refdef.y = y;
		refdef.width = w;
		refdef.height = h;

		refdef.time = cg.time;

		trap_R_ClearScene();
		trap_R_AddRefEntityToScene( &ent );
		trap_R_RenderScene( &refdef );
	} else if ( cg_drawIcons.integer ) {
		CG_DrawPic( x, y, w, h, ci->modelIcon );
	}

			// if they are deferred, draw a cross out
	if ( ci->deferred ) {
		CG_DrawPic( x, y, w, h, cgs.media.deferShader );
//freeze
		//Add a Frozen text draw here instead
	//} else if ( g_gamemode.integer > 3 && Q_Isfreeze( clientNum ) ) {
	//	CG_DrawPic( x, y, w, h, cgs.media.noammoShader );
//freeze
	}
}

/*
================
CG_Draw3DFlagModel

================
*/ /*
void CG_Draw3DFlagModel( float x, float y, float w, float h, qhandle_t model, qhandle_t skin, vec3_t origin, vec3_t angles, int team ) {
	refdef_t		refdef;
	refEntity_t		ent;

	if ( !cg_draw3dIcons.integer || !cg_drawIcons.integer ) {
		return;
	}

	CG_AdjustFrom640( &x, &y, &w, &h );

	memset( &refdef, 0, sizeof( refdef ) );

	memset( &ent, 0, sizeof( ent ) );
	AnglesToAxis( angles, ent.axis );

		/* set colors here */ /*
	if ( cg_adjustTeamColors.integer && team == cgs.clientinfo[cg.clientNum].team && cg_forceColors.integer && cgs.clientinfo[cg.clientNum].team != TEAM_SPECTATOR ) {
		memcpy(ent.shaderRGBA, &cgs.clientinfo[cg.clientNum].colors[cg_adjustTeamColors.integer - 1], sizeof(ent.shaderRGBA));
	} else if ( cg_adjustTeamColors.integer && team == cgs.clientinfo[cg.clientNum].team && cgs.clientinfo[cg.clientNum].team != TEAM_SPECTATOR ) {
		memcpy(ent.shaderRGBA, &cgs.teamColors[cg_adjustTeamColors.integer - 1], sizeof(ent.shaderRGBA));
	} else if ( cg_adjustTeamColors.integer && team != cgs.clientinfo[cg.clientNum].team && cgs.clientinfo[cg.clientNum].team != TEAM_SPECTATOR ) {
		memcpy(ent.shaderRGBA, &cgs.enemyColors[cg_adjustTeamColors.integer - 1], sizeof(ent.shaderRGBA));
	} else if ( team == TEAM_RED ) {
		memcpy(ent.shaderRGBA, colorRed, sizeof(ent.shaderRGBA));
	} else if ( team == TEAM_BLUE ) {
		memcpy(ent.shaderRGBA, colorBlue, sizeof(ent.shaderRGBA));
	}


	VectorCopy( origin, ent.origin );
	ent.hModel = model;
	ent.customSkin = skin;
	ent.renderfx = RF_NOSHADOW;		// no stencil shadows

	refdef.rdflags = RDF_NOWORLDMODEL;

	AxisClear( refdef.viewaxis );

	refdef.fov_x = 30;
	refdef.fov_y = 30;

	refdef.x = x;
	refdef.y = y;
	refdef.width = w;
	refdef.height = h;

	refdef.time = cg.time;

	trap_R_ClearScene();
	trap_R_AddRefEntityToScene( &ent );
	trap_R_RenderScene( &refdef );
} */

/*
================
CG_DrawHead

Used for both the status bar and the scoreboard
================
*/
void CG_DrawHead( float x, float y, float w, float h, int clientNum, vec3_t headAngles ) {
	clipHandle_t	cm;
	clientInfo_t	*ci;
	float			len;
	vec3_t			origin;
	vec3_t			mins, maxs;

	ci = &cgs.clientinfo[ clientNum ];

	if ( cg_draw3dIcons.integer ) {
		cm = ci->headModel;
		if ( !cm ) {
			return;
		}

		// offset the origin y and z to center the head
		trap_R_ModelBounds( cm, mins, maxs );

		origin[2] = -0.5 * ( mins[2] + maxs[2] );
		origin[1] = 0.5 * ( mins[1] + maxs[1] );

		// calculate distance so the head nearly fills the box
		// assume heads are taller than wide
		len = 0.7 * ( maxs[2] - mins[2] );		
		origin[0] = len / 0.268;	// len / tan( fov/2 )

		// allow per-model tweaking
		VectorAdd( origin, ci->headOffset, origin );

		//CG_Draw3DModel( x, y, w, h, head.hModel, head.customSkin, origin, headAngles );
		//PM Skin apply the colors in the scoreboard and statusbar -- This could be part of the original function
		CG_Draw3DHeadModel( x, y, w, h, ci->headModel, ci->headSkin, origin, headAngles, clientNum );
	} else if ( cg_drawIcons.integer ) {
		CG_DrawPic( x, y, w, h, ci->modelIcon );
	}

		// if they are deferred, draw a cross out
	if ( ci->deferred ) {
		CG_DrawPic( x, y, w, h, cgs.media.deferShader );
//freeze
		//Add a Frozen text draw here instead
	} else if ( g_gamemode.integer > 3 && Q_Isfreeze( clientNum ) ) {
		//CG_DrawPic( x, y, w, h, cgs.media.noammoShader );(y+((h*.5)-6))
		CG_DrawStringExt( x, y, "Frozen", colorCyan, qfalse, qfalse, 10, 12, 0, w, -1 );
//freeze
	}
}

/*
================
CG_DrawFlagModel

Used for both the status bar and the scoreboard
================
*/
void CG_DrawFlagModel( float x, float y, float w, float h, int team, qboolean force2D ) {
	qhandle_t		cm;
	float			len;
	vec3_t			origin, angles;
	vec3_t			mins, maxs;
	qhandle_t		handle;

	if ( !force2D && cg_draw3dIcons.integer ) {

		VectorClear( angles );

		cm = cgs.media.redFlagModel;

		// offset the origin y and z to center the flag
		trap_R_ModelBounds( cm, mins, maxs );

		origin[2] = -0.5 * ( mins[2] + maxs[2] );
		origin[1] = 0.5 * ( mins[1] + maxs[1] );

		// calculate distance so the flag nearly fills the box
		// assume heads are taller than wide
		len = 0.5 * ( maxs[2] - mins[2] );		
		origin[0] = len / 0.268;	// len / tan( fov/2 )

		angles[YAW] = 60 * sin( cg.time / 2000.0 );;

		if( team == TEAM_RED ) {
			handle = cgs.media.redFlagModel;
		} else if( team == TEAM_BLUE ) {
			handle = cgs.media.blueFlagModel;
		} else if( team == TEAM_FREE ) {
			handle = cgs.media.neutralFlagModel;
		} else {
			return;
		}
		CG_Draw3DModel( x, y, w, h, handle, 0, origin, angles );
		//CG_Draw3DFlagModel( x, y, w, h, handle, 0, origin, angles, team );
	} else if ( cg_drawIcons.integer ) {
		gitem_t *item;

		if( team == TEAM_RED ) {
			item = BG_FindItemForPowerup( PW_REDFLAG );
		} else if( team == TEAM_BLUE ) {
			item = BG_FindItemForPowerup( PW_BLUEFLAG );
		} else if( team == TEAM_FREE ) {
			item = BG_FindItemForPowerup( PW_NEUTRALFLAG );
		} else {
			return;
		}
		if (item) {
		  CG_DrawPic( x, y, w, h, cg_items[ ITEM_INDEX(item) ].icon );
		}
	}
}

/*
================
CG_DrawStatusBarHead

================
*/
#ifndef MISSIONPACK

static void CG_DrawStatusBarHead( float x ) {
	vec3_t		angles;
	playerState_t	*ps;
	float		size, stretch;
	float		frac;

	ps = &cg.snap->ps;

	VectorClear( angles );

	if ( cg.damageTime && cg.time - cg.damageTime < DAMAGE_TIME ) {
		frac = (float)(cg.time - cg.damageTime ) / DAMAGE_TIME;
		size = ICON_SIZE * 1.25 * ( 1.5 - frac * 0.5 );

		stretch = size - ICON_SIZE * 1.25;
		// kick in the direction of damage
		x -= stretch * 0.5 + cg.damageX * stretch * 0.5;

		cg.headStartYaw = 180 + cg.damageX * 45;

		cg.headEndYaw = 180 + 20 * cos( crandom()*M_PI );
		cg.headEndPitch = 5 * cos( crandom()*M_PI );

		cg.headStartTime = cg.time;
		cg.headEndTime = cg.time + 100 + random() * 2000;
	} else {
		if ( cg.time >= cg.headEndTime ) {
			// select a new head angle
			cg.headStartYaw = cg.headEndYaw;
			cg.headStartPitch = cg.headEndPitch;
			cg.headStartTime = cg.headEndTime;
			cg.headEndTime = cg.time + 100 + random() * 2000;
			
			if (ps->stats[STAT_HEALTH] > 0) {
			cg.headEndYaw = 180 + 20 * cos( crandom()*M_PI );
			cg.headEndPitch = 5 * cos( crandom()*M_PI );
			}
		}

		size = ICON_SIZE * 1.25;
	}

	// if the server was frozen for a while we may have a bad head start time
	if ( cg.headStartTime > cg.time ) {
		cg.headStartTime = cg.time;
	}

	frac = ( cg.time - cg.headStartTime ) / (float)( cg.headEndTime - cg.headStartTime );
	frac = frac * frac * ( 3 - 2 * frac );
	angles[YAW] = cg.headStartYaw + ( cg.headEndYaw - cg.headStartYaw ) * frac;
	angles[PITCH] = cg.headStartPitch + ( cg.headEndPitch - cg.headStartPitch ) * frac;

	CG_DrawHead( x, 480 - size, size, size, 
				cg.snap->ps.clientNum, angles );
}
#endif // MISSIONPACK

/*
================
CG_DrawStatusBarFlag

================
*/
#ifndef MISSIONPACK
static void CG_DrawStatusBarFlag( float x, int team ) {
	CG_DrawFlagModel( x, 480 - ICON_SIZE, ICON_SIZE, ICON_SIZE, team, qfalse );
}
#endif // MISSIONPACK

/*
================
CG_DrawTeamBackground

================
*/ /* We aren't using this anymore for the status bar.
	Just the scoreboard*/
void CG_DrawTeamBackground( int x, int y, int w, int h, float alpha, int team )
{
	vec4_t		hcolor;

	hcolor[3] = alpha;
	if ( cgs.gametype >= GT_TEAM && cg_adjustTeamColors.integer && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR ) {
		if ( team != cgs.clientinfo[ cg.clientNum ].team ) {
			memcpy(hcolor, g_color_table[ ColorIndex( cg_EnemyColors.string[cg_adjustTeamColors.integer - 1] ) ], sizeof(hcolor));
		} else {
			memcpy(hcolor, g_color_table[ ColorIndex( cg_TeamColors.string[cg_adjustTeamColors.integer - 1] ) ], sizeof(hcolor));
		}
	} else if ( team == TEAM_RED ) {
		hcolor[0] = 1;
		hcolor[1] = 0;
		hcolor[2] = 0;
	} else if ( team == TEAM_BLUE ) {
		hcolor[0] = 0;
		hcolor[1] = 0;
		hcolor[2] = 1;
	} else {
		return;
	}
	hcolor[3] = alpha;
	trap_R_SetColor( hcolor );
	CG_DrawPic( x, y, w, h, cgs.media.teamStatusBar );
	trap_R_SetColor( NULL );
}

/*
================
CG_DrawStatusBar

================
*/
#ifndef MISSIONPACK
static void CG_DrawStatusBar() {
	int			color;
	centity_t	*cent;
	playerState_t	*ps;
	int			value;
	vec4_t		hcolor;
	vec3_t		angles;
	vec3_t		origin;
#ifdef MISSIONPACK
	qhandle_t	handle;
#endif
	static float colors[4][4] = { 
//		{ 0.2, 1.0, 0.2, 1.0 } , { 1.0, 0.2, 0.2, 1.0 }, {0.5, 0.5, 0.5, 1} };
		{ 1.0f, 0.69f, 0.0f, 1.0f },    // normal
		{ 1.0f, 0.2f, 0.2f, 1.0f },     // low health
		{ 0.5f, 0.5f, 0.5f, 1.0f },     // weapon firing
		{ 1.0f, 1.0f, 1.0f, 1.0f } };   // health > 100

	if ( cg_drawStatus.integer == 0 ) {
		return;
	}

	// draw the team background
	//CG_DrawTeamBackground( 0, 420, 640, 60, 0.33f, cg.snap->ps.persistant[PERS_TEAM] );

	cent = &cg_entities[cg.snap->ps.clientNum];
	ps = &cg.snap->ps;

	VectorClear( angles );

	// draw any 3D icons first, so the changes back to 2D are minimized
	if ( cent->currentState.weapon && cg_weapons[ cent->currentState.weapon ].ammoModel ) {
		origin[0] = 70;
		origin[1] = 0;
		origin[2] = 0;
		angles[YAW] = 90 + 20 * sin( cg.time / 1000.0 );
		CG_Draw3DModel( CHAR_WIDTH*3 + TEXT_ICON_SPACE, 432, ICON_SIZE, ICON_SIZE,
					   cg_weapons[ cent->currentState.weapon ].ammoModel, 0, origin, angles );
	}
	
	CG_DrawStatusBarHead( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE );

	//This gets drawn as a powerup in the superhud
	if( cg.predictedPlayerState.powerups[PW_REDFLAG] ) {
		CG_DrawStatusBarFlag( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE + ICON_SIZE, TEAM_RED );
	} else if( cg.predictedPlayerState.powerups[PW_BLUEFLAG] ) {
		CG_DrawStatusBarFlag( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE + ICON_SIZE, TEAM_BLUE );
	} else if( cg.predictedPlayerState.powerups[PW_NEUTRALFLAG] ) {
		CG_DrawStatusBarFlag( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE + ICON_SIZE, TEAM_FREE );
	}

	
	if ( ps->stats[ STAT_ARMOR ] ) {
		qhandle_t model = cgs.media.armorModel; // CPM

		// CPM: Fix RA shader
		if ( g_pro_mode.integer ) {
			if ( ps->stats[ STAT_ARMORTYPE ] == 2 ) {
				model = cgs.media.armorModelRA;
			}
		}
		origin[0] = 90;
		origin[1] = 0;
		origin[2] = -10;
		angles[YAW] = ( cg.time & 2047 ) * 360 / 2048.0;
		CG_Draw3DModel( 370 + CHAR_WIDTH*3 + TEXT_ICON_SPACE, 432, ICON_SIZE, ICON_SIZE,
					   model,0, origin, angles ); // CPM
	}
#ifdef MISSIONPACK
	if( cgs.gametype == GT_HARVESTER ) {
		origin[0] = 90;
		origin[1] = 0;
		origin[2] = -10;
		angles[YAW] = ( cg.time & 2047 ) * 360 / 2048.0;
		if( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
			handle = cgs.media.redCubeModel;
		} else {
			handle = cgs.media.blueCubeModel;
		}
		CG_Draw3DModel( 640 - (TEXT_ICON_SPACE + ICON_SIZE), 416, ICON_SIZE, ICON_SIZE, handle, 0, origin, angles );
	}
#endif
	//
	// ammo
	//
	
	if ( cent->currentState.weapon ) {
		value = ps->ammo[cent->currentState.weapon];
		if ( value > -1 ) {
			if ( cg.predictedPlayerState.weaponstate == WEAPON_FIRING
				&& cg.predictedPlayerState.weaponTime > 100 ) {
				// draw as dark grey when reloading
				color = 2;	// dark grey
			} else {
				if ( value >= 0 ) {
					color = 0;	// green
				} else {
					color = 1;	// red
				}
			}
				
			trap_R_SetColor( colors[color] );	
			CG_DrawField (0, 432, 3, value);
			trap_R_SetColor( NULL );	

			// if we didn't draw a 3D icon, draw a 2D icon for ammo
			if ( !cg_draw3dIcons.integer && cg_drawIcons.integer ) {
				qhandle_t	icon;

				icon = cg_weapons[ cg.predictedPlayerState.weapon ].ammoIcon;
				if ( icon ) {
					CG_DrawPic( CHAR_WIDTH*3 + TEXT_ICON_SPACE, 432, ICON_SIZE, ICON_SIZE, icon );
				}
			}
		}
	}

	//
	// health
	//
	value = ps->stats[STAT_HEALTH];
	if ( value > 100 ) {
		trap_R_SetColor( colors[3] );		// white
	} else if (value > 25) {
		trap_R_SetColor( colors[0] );	// green
	} else if (value > 0) {
		color = (cg.time >> 8) & 1;	// flash
		trap_R_SetColor( colors[color] );
	} else {
		trap_R_SetColor( colors[1] );	// red
	}

	// stretch the health up when taking damage
	CG_DrawField ( 155, 432, 4, value);

	CG_ColorForHealth( hcolor );
	trap_R_SetColor( hcolor );

	//
	// armor
	//
	value = ps->stats[STAT_ARMOR];
	if (value > 0 ) {
		// CPM: Armor icon
		qhandle_t icon = cgs.media.armorIcon;

		if (g_pro_mode.integer && ps->stats[STAT_ARMORTYPE] == 2)
			icon = cgs.media.armorIconRA;
		// !CPM

		if ( value > 100 ) {
			trap_R_SetColor( colors[3] );
		} else {
			trap_R_SetColor( colors[0] );
		}	
		CG_DrawField (370, 432, 3, value);
		trap_R_SetColor( NULL );

		// if we didn't draw a 3D icon, draw a 2D icon for armor
		if ( !cg_draw3dIcons.integer && cg_drawIcons.integer ) {
			CG_DrawPic( 370 + CHAR_WIDTH*3 + TEXT_ICON_SPACE, 432, ICON_SIZE, ICON_SIZE, icon ); // CPM
		}
	}

#ifdef MISSIONPACK
	//
	// cubes
	//
	if( cgs.gametype == GT_HARVESTER ) {
		value = ps->generic1;
		if( value > 99 ) {
			value = 99;
		}
		trap_R_SetColor( colors[0] );
		CG_DrawField (640 - (CHAR_WIDTH*2 + TEXT_ICON_SPACE + ICON_SIZE), 432, 2, value, 0);
		trap_R_SetColor( NULL );
		// if we didn't draw a 3D icon, draw a 2D icon for armor
		if ( !cg_draw3dIcons.integer && cg_drawIcons.integer ) {
			if( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
				handle = cgs.media.redCubeIcon;
			} else {
				handle = cgs.media.blueCubeIcon;
			}
			CG_DrawPic( 640 - (TEXT_ICON_SPACE + ICON_SIZE), 432, ICON_SIZE, ICON_SIZE, handle );
		}
	}
#endif
}
#endif

/*
===========================================================================================

  UPPER RIGHT CORNER

===========================================================================================
*/

/*
================
CG_DrawAttacker

================
*/
static float CG_DrawAttacker( float y ) {
	int			t, w;
	float		size;
	vec3_t		angles;
	const char	*info;
	const char	*name;
	int			clientNum;

	if ( cg.predictedPlayerState.stats[STAT_HEALTH] <= 0 ) {
		return y;
	}

	if ( !cg.attackerTime ) {
		return y;
	}

	clientNum = cg.predictedPlayerState.persistant[PERS_ATTACKER];
	if ( clientNum < 0 || clientNum >= MAX_CLIENTS || clientNum == cg.snap->ps.clientNum ) {
		return y;
	}

	t = cg.time - cg.attackerTime;
	if ( t > ATTACKER_HEAD_TIME ) {
		cg.attackerTime = 0;
		return y;
	}

	size = ICON_SIZE * 1.25;

	angles[PITCH] = 0;
	angles[YAW] = 180;
	angles[ROLL] = 0;
	CG_DrawHead( 640 - size, y, size, size, clientNum, angles );

	info = CG_ConfigString( CS_PLAYERS + clientNum );
	name = Info_ValueForKey(  info, "n" );
	y += size;

	w = CG_DrawStrlen( name ) * BIGCHAR_WIDTH;
	CG_DrawStringExt( 640 - w, y + 2, name, colorWhite, qfalse, qfalse, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );

	return y + BIGCHAR_HEIGHT + 2;
}

/*
==================
CG_DrawSnapshot
==================
*/
float CG_DrawSnapshot( float y ) {
	char		*s;
	int			w;

	s = va( "time:%i snap:%i cmd:%i", cg.snap->serverTime, 
		cg.latestSnapshotNum, cgs.serverCommandSequence );
	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;

	//CG_DrawBigString( 635 - w, y + 2, s, 1.0F);
	CG_DrawStringExt( 635 - w, y + 2, s, colorWhite, qfalse, qfalse, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );

	return y + BIGCHAR_HEIGHT + 4;
}

/*
==================
CG_DrawFPS
==================
*/
#define	FPS_FRAMES	4
static float CG_DrawFPS( float y ) {
	char		*s;
	int			w;
	static int	previousTimes[FPS_FRAMES];
	static int	index;
	int		i, total;
	int		fps;
	static	int	previous;
	int		t, frameTime;

	// don't use serverTime, because that will be drifting to
	// correct for internet lag changes, timescales, timedemos, etc
	t = trap_Milliseconds();
	frameTime = t - previous;
	previous = t;

	previousTimes[index % FPS_FRAMES] = frameTime;
	index++;
	if ( index > FPS_FRAMES ) {
		// average multiple frames together to smooth changes out a bit
		total = 0;
		for ( i = 0 ; i < FPS_FRAMES ; i++ ) {
			total += previousTimes[i];
		}
		if ( !total ) {
			total = 1;
		}
		fps = 1000 * FPS_FRAMES / total;

		s = va( "%ifps", fps );

		//CG_DrawBigString( 635 - w, y + 2, s, 1.0F);
		//CG_Printf("FPS -- %i, %i, %i, %i\n", hud[(int)y].rect[0], hud[(int)y].rect[1], hud[(int)y].fontsize[0], hud[(int)y].fontsize[1]);

		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
		CG_DrawStringExt( 635 - w, y + 2, s, colorWhite, qfalse, qfalse, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
	}

	return y + BIGCHAR_HEIGHT + 4;
}

/*
=================
CG_DrawTimer
=================
*/
static float CG_DrawTimer( float y ) {
	char		*s;
	int			w;
	int			mins, seconds;//, tens;
	int			msec;

	if ( cg_drawTimer.integer == 2 && cgs.timelimit > 0 ) {
		//Figure out how much time left and subtract a second so we're at 0 when timelimit is hit.
		msec = (((cgs.levelStartTime + (cgs.timelimit * 60000)) - cg.time));
	} else {
		msec = cg.time - cgs.levelStartTime;
	}

	if ( cgs.timelimit > 0 && cg.time >= (cgs.levelStartTime + (cgs.timelimit * 60000)) ) {
		msec = seconds = mins = 0;
	} else {
		seconds = msec / 1000;
		mins = seconds / 60;
		seconds -= mins * 60;
	}

	s = va( "%i:%02i", mins, seconds );
	
	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
	CG_DrawStringExt( 635 - w, y + 2, s, colorWhite, qfalse, qfalse, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );


	return y + BIGCHAR_HEIGHT + 4;
}

/*
=================
CG_DrawClock
=================
*/
float CG_DrawClock ( float y ) {
	char		*s;
	int			w, hour;
	qboolean afternoon; 
	qtime_t qtm;


	if ( !cg.time > cg.clockInterval ) 
		return y + BIGCHAR_HEIGHT + 4;

	cg.clockInterval = cg.time + 1000;

	trap_RealTime(&qtm);
	
/*  Used %02i for minutes and seconds, this reserves 2 spaces
	then fills any unused spaces with 0. */
	if (cg_drawClock.integer == 2) {
		s = va( "%i:%02i:%02i", qtm.tm_hour, qtm.tm_min, qtm.tm_sec );
	} else {

			if ( qtm.tm_hour == 0 ) {
				hour = qtm.tm_hour + 12;
				afternoon = qfalse;
			} else if ( qtm.tm_hour == 12 ) {
				hour = qtm.tm_hour;
				afternoon = qtrue;
			} else if ( qtm.tm_hour > 12 ) {
				hour = qtm.tm_hour - 12;
				afternoon = qtrue;
			} else if ( qtm.tm_hour < 12 ) {
				hour = qtm.tm_hour;
				afternoon = qfalse;
			} else {
				hour = qtm.tm_hour;
				afternoon = qfalse;
			}


		if (!afternoon) {
			s = va( "%i:%02i:%02iam", hour, qtm.tm_min, qtm.tm_sec );
		} else {
			s = va( "%i:%02i:%02ipm", hour, qtm.tm_min, qtm.tm_sec );
		} 

	}

	w = CG_DrawStrlen( s ) * (BIGCHAR_WIDTH * .5);
	CG_DrawStringExt( 635 - w, y + 2, s, colorWhite, qtrue, qfalse, BIGCHAR_WIDTH * .5, BIGCHAR_HEIGHT * .5, 0, 0, 0 );
	return y + BIGCHAR_HEIGHT + 4;

}

/*
=================
CG_DrawTeamOverlay
=================
*/

static float CG_DrawTeamOverlay( float y, qboolean right, qboolean upper ) {
	int x, w, h, xx;
	int i, j, len;
	const char *p;
	vec4_t		hcolor;
	int pwidth, lwidth;
	int plyrs;
	char st[16];
	clientInfo_t *ci;
	gitem_t	*item;
	int ret_y, count;

	if ( !cg_drawTeamOverlay.integer ) {
		return y;
	}

	if ( cg.snap->ps.persistant[PERS_TEAM] != TEAM_RED && cg.snap->ps.persistant[PERS_TEAM] != TEAM_BLUE ) {
		return y; // Not on any team
	}

	plyrs = 0;

	// max player name width
	pwidth = 0;
	count = (numSortedTeamPlayers > 8) ? 8 : numSortedTeamPlayers;
	for (i = 0; i < count; i++) {
		ci = cgs.clientinfo + sortedTeamPlayers[i];
		if ( ci->infoValid && ci->team == cg.snap->ps.persistant[PERS_TEAM]) {
			plyrs++;
			len = CG_DrawStrlen(ci->name);
			if (len > pwidth)
				pwidth = len;
		}
	}

	if (!plyrs)
		return y;

	if (pwidth > TEAM_OVERLAY_MAXNAME_WIDTH)
		pwidth = TEAM_OVERLAY_MAXNAME_WIDTH;

	// max location name width
	lwidth = 0;
	for (i = 1; i < MAX_LOCATIONS; i++) {
		p = CG_ConfigString(CS_LOCATIONS + i);
		if (p && *p) {
			len = CG_DrawStrlen(p);
			if (len > lwidth)
				lwidth = len;
		}
	}

	if (lwidth > TEAM_OVERLAY_MAXLOCATION_WIDTH)
		lwidth = TEAM_OVERLAY_MAXLOCATION_WIDTH;

	if ( g_gamemode.integer != 1 ) {
		w = (pwidth + lwidth + 4 + 7) * TINYCHAR_WIDTH;
	} else {
		w = (pwidth + lwidth + 3) * TINYCHAR_WIDTH;
	}

	if ( right )
		x = 640 - w;
	else
		x = 0;

	h = plyrs * TINYCHAR_HEIGHT;

	if ( upper ) {
		ret_y = y + h;
	} else {
		y -= h;
		ret_y = y;
	}
	
	if ( cg_adjustTeamColors.integer && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR ) {
		memcpy(hcolor, g_color_table[ ColorIndex( cg_TeamColors.string[cg_adjustTeamColors.integer - 1] ) ], sizeof(hcolor));
		hcolor[3] = 0.33f;
	} else 
	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED ) {
		hcolor[0] = 1.0f;
		hcolor[1] = 0.0f;
		hcolor[2] = 0.0f;
		hcolor[3] = 0.33f;
	} else { // if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE )
		hcolor[0] = 0.0f;
		hcolor[1] = 0.0f;
		hcolor[2] = 1.0f;
		hcolor[3] = 0.33f;
	}
	trap_R_SetColor( hcolor );
	CG_DrawPic( x, y, w, h, cgs.media.teamStatusBar );
	trap_R_SetColor( NULL );

	for (i = 0; i < count; i++) {
		ci = cgs.clientinfo + sortedTeamPlayers[i];
		if ( ci->infoValid && ci->team == cg.snap->ps.persistant[PERS_TEAM]) {

			hcolor[0] = hcolor[1] = hcolor[2] = hcolor[3] = 1.0;

			xx = x + TINYCHAR_WIDTH;

			CG_DrawStringExt( xx, y,
				ci->name, hcolor, qfalse, qfalse,
				TINYCHAR_WIDTH, TINYCHAR_HEIGHT, TEAM_OVERLAY_MAXNAME_WIDTH, 0, 0);

			if (lwidth) {
				p = CG_ConfigString(CS_LOCATIONS + ci->location);
				if (!p || !*p)
					p = "unknown";
				len = CG_DrawStrlen(p);
				if (len > lwidth)
					len = lwidth;

//				xx = x + TINYCHAR_WIDTH * 2 + TINYCHAR_WIDTH * pwidth + 
//					((lwidth/2 - len/2) * TINYCHAR_WIDTH);
				xx = x + TINYCHAR_WIDTH * 2 + TINYCHAR_WIDTH * pwidth;
				CG_DrawStringExt( xx, y,
					p, hcolor, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT,
					TEAM_OVERLAY_MAXLOCATION_WIDTH, 0, 0);
			}

			if ( g_gamemode.integer != 1 ) {
				CG_GetColorForHealth( ci->health, ci->armor, hcolor );

				Com_sprintf (st, sizeof(st), "%3i %3i", ci->health,	ci->armor);

				xx = x + TINYCHAR_WIDTH * 3 + 
					TINYCHAR_WIDTH * pwidth + TINYCHAR_WIDTH * lwidth;

				CG_DrawStringExt( xx, y,
					st, hcolor, qfalse, qfalse,
					TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0, 0, 0 );
			}

			// draw weapon icon
			if ( g_gamemode.integer != 1 ) {
				xx += TINYCHAR_WIDTH * 3;

				if ( cg_weapons[ci->curWeapon].weaponIcon ) {
					CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 
						cg_weapons[ci->curWeapon].weaponIcon );
				} else {
					CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 
						cgs.media.deferShader );
				}
			}

			// Draw powerup icons
			if (right) {
				xx = x;
			} else {
				xx = x + w - TINYCHAR_WIDTH;
			}
			for (j = 0; j <= PW_NUM_POWERUPS; j++) {
//freeze
				if ( g_gamemode.integer > 3 ) {
					if ( Q_Isfreeze( ci - cgs.clientinfo ) ) {
						CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, cgs.media.noammoShader );
						break;
					}
				}
//freeze
				if (ci->powerups & (1 << j)) {

					item = BG_FindItemForPowerup( j );

					if (item) {
						/* This is sloppy but it sets the color of the flag icons for cg_adjustTeamColors */
						 if ( item->giType == IT_TEAM && cgs.gametype == GT_CTF && cg_adjustTeamColors.integer ) {
							if ( cgs.clientinfo[cg.clientNum].team == TEAM_RED ) {
								if ( item->giTag == PW_REDFLAG ) {
									trap_R_SetColor( g_color_table[ ColorIndex( cg_TeamColors.string[cg_adjustTeamColors.integer - 1] ) ] );
								} else {
									trap_R_SetColor( g_color_table[ ColorIndex(cg_EnemyColors.string[cg_adjustTeamColors.integer - 1]) ] );
								}
							} else {
								if ( item->giTag == PW_BLUEFLAG ) {
									trap_R_SetColor( g_color_table[ ColorIndex( cg_TeamColors.string[cg_adjustTeamColors.integer - 1] ) ] );
								} else {
									trap_R_SetColor( g_color_table[ ColorIndex(cg_EnemyColors.string[cg_adjustTeamColors.integer - 1]) ] );
								}
							}
						}
						 if ( cg_adjustTeamColors.integer ) {
							 CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, trap_R_RegisterShader( "icons/iconf_fla1" ) );
						 } else {
							CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 
							trap_R_RegisterShader( item->icon ) );
						 }
						if (right) {
							xx -= TINYCHAR_WIDTH;
						} else {
							xx += TINYCHAR_WIDTH;
						}
					}
				}
			}

			y += TINYCHAR_HEIGHT;
		}
	}

	return ret_y;
//#endif
}


/*
=====================
CG_DrawUpperRight

=====================
*/
static void CG_DrawUpperRight( void ) {
	float	y;

	y = 0;

	if ( cgs.gametype >= GT_TEAM && cg_drawTeamOverlay.integer == 1 ) {
		y = CG_DrawTeamOverlay( y, qtrue, qtrue );
	} 
	if ( cg_drawSnapshot.integer ) {
		y = CG_DrawSnapshot( y );
	}
	if ( cg_drawFPS.integer ) {
		y = CG_DrawFPS( y );
	}
	if ( cg_drawTimer.integer ) {
		y = CG_DrawTimer( y );
	}
	if ( cg_drawAttacker.integer ) {
		y = CG_DrawAttacker( y );
	}
	if ( cg_drawClock.integer ) {
		y = CG_DrawClock( y );
	}

}

/*
===========================================================================================

  LOWER RIGHT CORNER

===========================================================================================
*/

/*
=================
CG_DrawScores

Draw the small two score display
=================
*/
//#ifndef MISSIONPACK
static float CG_DrawScores( float y ) {
	const char	*s;
	int			s1, s2, score;
	int			x, w;
	int			v;
	vec4_t		color;
	float		y1;
	gitem_t		*item;

	s1 = cgs.scores1;
	s2 = cgs.scores2;

	y -=  BIGCHAR_HEIGHT + 8;

	y1 = y;

	// draw from the right side to left
	if ( cgs.gametype >= GT_TEAM ) {
		x = 640;
		//Set color
		if ( cg_adjustTeamColors.integer && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR ) {
			if ( cgs.clientinfo[ cg.clientNum ].team != TEAM_BLUE && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR && strlen(cg_EnemyColors.string) >= cg_adjustTeamColors.integer ) {
				memcpy(color, g_color_table[ ColorIndex( cg_EnemyColors.string[cg_adjustTeamColors.integer - 1] ) ], sizeof(color));
			} else if ( cg_forceColors.integer && cgs.clientinfo[ cg.clientNum ].team == TEAM_BLUE && strlen(colors.string) >= cg_adjustTeamColors.integer ) {
				memcpy(color, g_color_table[ ColorIndex( colors.string[cg_adjustTeamColors.integer - 1] ) ], sizeof(color));
			} else if ( cgs.clientinfo[ cg.clientNum ].team == TEAM_BLUE && strlen(cg_TeamColors.string) >= cg_adjustTeamColors.integer ) {
				memcpy(color, g_color_table[ ColorIndex( cg_TeamColors.string[cg_adjustTeamColors.integer - 1] ) ], sizeof(color));
			}
		} else {
			color[0] = 0.0f;
			color[1] = 0.0f;
			color[2] = 1.0f;
		}
		color[3] = 0.33f;
		s = va( "%2i", s2 );
		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
		x -= w;
		CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );

		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
			CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
		}
		//CG_DrawBigString( x + 4, y, s, 1.0F);
		CG_DrawStringExt(x + 4, y, s, colorWhite, qtrue, qfalse, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );

		if ( cgs.gametype == GT_CTF ) {
			//Set the flag icon color
			if ( cg_adjustTeamColors.integer && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR ) {
				if ( cg_adjustTeamColors.integer && cgs.clientinfo[ cg.clientNum ].team != TEAM_BLUE && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR && strlen(cg_EnemyColors.string) >= cg_adjustTeamColors.integer ) {
					trap_R_SetColor( g_color_table[ ColorIndex( cg_EnemyColors.string[cg_adjustTeamColors.integer - 1] ) ] );
				} else if ( cg_adjustTeamColors.integer && cg_forceColors.integer && cgs.clientinfo[ cg.clientNum ].team == TEAM_BLUE && strlen(colors.string) >= cg_adjustTeamColors.integer ) {
					trap_R_SetColor( g_color_table[ ColorIndex( colors.string[cg_adjustTeamColors.integer - 1] ) ] );
				} else if ( cg_adjustTeamColors.integer && cgs.clientinfo[ cg.clientNum ].team == TEAM_BLUE && strlen(cg_TeamColors.string) >= cg_adjustTeamColors.integer ) {
					trap_R_SetColor( g_color_table[ ColorIndex( cg_TeamColors.string[cg_adjustTeamColors.integer - 1] ) ] );
				}
			}
			// Display flag status
			item = BG_FindItemForPowerup( PW_BLUEFLAG );

			if (item) {
				//CG_Printf("item -- ");
				y1 = y - BIGCHAR_HEIGHT - 8;
				if( cgs.flags[TEAM_BLUE-1] >= 0 && cgs.flags[TEAM_BLUE-1] <= 3 ) {
					if ( cg_adjustTeamColors.integer && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR ) {
						CG_DrawPic( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.whiteFlagShader[cgs.flags[TEAM_BLUE-1]] );
					} else {
						CG_DrawPic( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.blueFlagShader[cgs.flags[TEAM_BLUE-1]] );
					}
					//CG_DrawFlagIcons( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.blueFlagShader[cgs.blueflag] );
				}
			}
		}
		//Set color
		if ( cg_adjustTeamColors.integer && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR ) {
			if ( cgs.clientinfo[ cg.clientNum ].team != TEAM_RED && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR && strlen(cg_EnemyColors.string) >= cg_adjustTeamColors.integer ) {
				memcpy(color, g_color_table[ ColorIndex( cg_EnemyColors.string[cg_adjustTeamColors.integer - 1] ) ], sizeof(color));
			} else if ( cg_forceColors.integer && cgs.clientinfo[ cg.clientNum ].team == TEAM_RED && strlen(colors.string) >= cg_adjustTeamColors.integer ) {
				memcpy(color, g_color_table[ ColorIndex( colors.string[cg_adjustTeamColors.integer - 1] ) ], sizeof(color));
			} else if ( cgs.clientinfo[ cg.clientNum ].team == TEAM_RED && strlen(cg_TeamColors.string) >= cg_adjustTeamColors.integer ) {
				memcpy(color, g_color_table[ ColorIndex( cg_TeamColors.string[cg_adjustTeamColors.integer - 1] ) ], sizeof(color));
			}
		} else {
			color[0] = 1.0f;
			color[1] = 0.0f;
			color[2] = 0.0f;
		}
		color[3] = 0.33f;
		s = va( "%2i", s1 );
		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
		x -= w;

		CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );

		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED ) {
			CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
		}

		CG_DrawStringExt(x + 4, y, s, colorWhite, qtrue, qfalse, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );

		if ( cgs.gametype == GT_CTF ) {
			//Set the flag icon color
				if ( cg_adjustTeamColors.integer && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR ) {
					if ( cgs.clientinfo[ cg.clientNum ].team != TEAM_RED && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR && strlen(cg_EnemyColors.string) >= cg_adjustTeamColors.integer ) {
						trap_R_SetColor( g_color_table[ ColorIndex( cg_EnemyColors.string[cg_adjustTeamColors.integer - 1] ) ] );
					} else if ( cg_forceColors.integer && cgs.clientinfo[ cg.clientNum ].team == TEAM_RED && strlen(colors.string) >= cg_adjustTeamColors.integer ) {
						trap_R_SetColor( g_color_table[ ColorIndex( colors.string[cg_adjustTeamColors.integer - 1] ) ] );
					} else if ( cgs.clientinfo[ cg.clientNum ].team == TEAM_RED && strlen(cg_TeamColors.string) >= cg_adjustTeamColors.integer ) {
						trap_R_SetColor( g_color_table[ ColorIndex( cg_TeamColors.string[cg_adjustTeamColors.integer - 1] ) ] );
					}
				}
			}

			// Display flag status
			item = BG_FindItemForPowerup( PW_REDFLAG );

			if (item) {
				y1 = y - BIGCHAR_HEIGHT - 8;
				if( cgs.flags[TEAM_RED-1] >= 0 && cgs.flags[TEAM_RED-1] <= 3 ) {
					if ( cg_adjustTeamColors.integer && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR ) {
						CG_DrawPic( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.whiteFlagShader[cgs.flags[TEAM_RED-1]] );
					} else {
						CG_DrawPic( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.redFlagShader[cgs.flags[TEAM_RED-1]] );
					}
				}
			
			}
		

#ifdef MISSIONPACK
		if ( cgs.gametype == GT_1FCTF ) {
			// Display flag status
			item = BG_FindItemForPowerup( PW_NEUTRALFLAG );

			if (item) {
				y1 = y - BIGCHAR_HEIGHT - 8;
				if( cgs.flagStatus >= 0 && cgs.flagStatus <= 3 ) {
					CG_DrawPic( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.flagShader[cgs.flagStatus] );
				}
			}
		}
#endif
		if ( cgs.gametype >= GT_CTF || g_gamemode.integer >= 4 ) {
			v = cgs.capturelimit;
		} else {
			v = cgs.fraglimit;
		}
		if ( v ) {
			s = va( "%2i", v );
			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
			x -= w;
			//CG_DrawBigString( x + 4, y, s, 1.0F);
			CG_DrawStringExt(x + 4, y, s, colorWhite, qtrue, qfalse,
								BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
		}
} else {
		qboolean	spectator;

		x = 640;
		score = cg.snap->ps.persistant[PERS_SCORE];
		spectator = ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR );

		// always show your score in the second box if not in first place
		if ( s1 != score ) {
			s2 = score;
		}
		if ( s2 != SCORE_NOT_PRESENT ) {
			s = va( "%2i", s2 );
			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
			x -= w;
			if ( !spectator && score == s2 && score != s1 ) {
				color[0] = 1.0f;
				color[1] = 0.0f;
				color[2] = 0.0f;
				color[3] = 0.33f;
				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
				CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
			} else {
				if ( cg_adjustTeamColors.integer && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR ) {
					memcpy(color, g_color_table[ ColorIndex( cg_EnemyColors.string[cg_adjustTeamColors.integer - 1] ) ], sizeof(color));
				} else {
					color[0] = 0.5f;
					color[1] = 0.5f;
					color[2] = 0.5f;
				}
				color[3] = 0.33f;
				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
			}	
			//CG_DrawBigString( x + 4, y, s, 1.0F);
			CG_DrawStringExt(x + 4, y, s, colorWhite, qtrue, qfalse, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
		}

		// first place
		if ( s1 != SCORE_NOT_PRESENT ) {
			s = va( "%2i", s1 );
			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
			x -= w;
			if ( !spectator && score == s1 ) {
				color[0] = 0.0f;
				color[1] = 0.0f;
				color[2] = 1.0f;
				color[3] = 0.33f;
				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
				CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
			} else {
				if ( cg_adjustTeamColors.integer && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR ) {
					memcpy(color, g_color_table[ ColorIndex( cg_EnemyColors.string[cg_adjustTeamColors.integer - 1] ) ], sizeof(color));
				} else {
					color[0] = 0.5f;
					color[1] = 0.5f;
					color[2] = 0.5f;
				}
				color[3] = 0.33f;
				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
			}	
			//CG_DrawBigString( x + 4, y, s, 1.0F);
			CG_DrawStringExt(x + 4, y, s, colorWhite, qtrue, qfalse,
								BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
		}

		if ( cgs.fraglimit ) {
			s = va( "%2i", cgs.fraglimit );
			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
			x -= w;
			//CG_DrawBigString( x + 4, y, s, 1.0F);
			CG_DrawStringExt(x + 4, y, s, colorWhite, qtrue, qfalse,
								BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
		}
	}

	return y1 - 8;
}
//#endif // MISSIONPACK

/*
================
CG_DrawPowerups
================
*/
#ifndef MISSIONPACK
static float CG_DrawPowerups( float y ) {
	int		sorted[MAX_POWERUPS];
	int		sortedTime[MAX_POWERUPS];
	int		i, j, k;
	int		active;
	playerState_t	*ps;
	int		t;
	gitem_t	*item;
	int		x;
	int		color;
	float	size;
	float	f;
	static float colors[2][4] = { 
    { 0.2f, 1.0f, 0.2f, 1.0f } , 
    { 1.0f, 0.2f, 0.2f, 1.0f } 
  };

	ps = &cg.snap->ps;

	if ( ps->stats[STAT_HEALTH] <= 0 ) {
		return y;
	}

	// sort the list by time remaining
	active = 0;
	for ( i = 0 ; i < MAX_POWERUPS ; i++ ) {
		if ( !ps->powerups[ i ] ) {
			continue;
		}
		t = ps->powerups[ i ] - cg.time;
		// ZOID--don't draw if the power up has unlimited time (999 seconds)
		// This is true of the CTF flags
		if ( t < 0 || t > 999000) {
			continue;
		}

		// insert into the list
		for ( j = 0 ; j < active ; j++ ) {
			if ( sortedTime[j] >= t ) {
				for ( k = active - 1 ; k >= j ; k-- ) {
					sorted[k+1] = sorted[k];
					sortedTime[k+1] = sortedTime[k];
				}
				break;
			}
		}
		sorted[j] = i;
		sortedTime[j] = t;
		active++;
	}

	// draw the icons and timers
	x = 640 - ICON_SIZE - CHAR_WIDTH * 2;
	for ( i = 0 ; i < active ; i++ ) {
		item = BG_FindItemForPowerup( sorted[i] );

    if (item) {

		  color = 1;

		  y -= ICON_SIZE;

		  trap_R_SetColor( colors[color] );
		  CG_DrawField( x, y, 2, sortedTime[ i ] / 1000 );

		  t = ps->powerups[ sorted[i] ];
		  if ( t - cg.time >= POWERUP_BLINKS * POWERUP_BLINK_TIME ) {
			  trap_R_SetColor( NULL );
		  } else {
			  vec4_t	modulate;

			  f = (float)( t - cg.time ) / POWERUP_BLINK_TIME;
			  f -= (int)f;
			  modulate[0] = modulate[1] = modulate[2] = modulate[3] = f;
			  trap_R_SetColor( modulate );
		  }

		  if ( cg.powerupActive == sorted[i] && 
			  cg.time - cg.powerupTime < PULSE_TIME ) {
			  f = 1.0 - ( ( (float)cg.time - cg.powerupTime ) / PULSE_TIME );
			  size = ICON_SIZE * ( 1.0 + ( PULSE_SCALE - 1.0 ) * f );
		  } else {
			  size = ICON_SIZE;
		  }

		  CG_DrawPic( 640 - size, y + ICON_SIZE / 2 - size / 2, 
			  size, size, trap_R_RegisterShader( item->icon ) );
    }
	}
	trap_R_SetColor( NULL );

	return y;
}
#endif // MISSIONPACK

/*
=====================
CG_DrawLowerRight

=====================
*/
#ifndef MISSIONPACK
static void CG_DrawLowerRight( void ) {
	float	y;

	y = 480 - ICON_SIZE;

	if ( cgs.gametype >= GT_TEAM && cg_drawTeamOverlay.integer == 2 ) {
		y = CG_DrawTeamOverlay( y, qtrue, qfalse );
	} 

	y = CG_DrawScores( y );
	y = CG_DrawPowerups( y );
}
#endif // MISSIONPACK

/*
===================
CG_DrawPickupItem
===================
*/
#ifndef MISSIONPACK
static int CG_DrawPickupItem( int y ) {
	int		value;
	float	*fadeColor;
	float	*fontFade;//Doesn't remove text...

	if ( cg.snap->ps.stats[STAT_HEALTH] <= 0 ) {
		return y;
	}

	value = cg.itemPickup;
	if ( !value ) {
		return y;
	}

	y -= ICON_SIZE;

	
	fadeColor = CG_FadeColor( cg.itemPickupTime, 3000 );
	if ( fadeColor ) {
		CG_RegisterItemVisuals( value );
		if ( cgs.gametype == GT_CTF && bg_itemlist[value].giType == IT_TEAM && cg.itemPickupFlag == PW_BLUEFLAG ) {
			//CG_Printf("DrawPickup: %i -- %i -- set blue\n", bg_itemlist[value].giType, bg_itemlist[value].giTag );
			if ( cg_adjustTeamColors.integer && cgs.clientinfo[ cg.clientNum ].team != TEAM_BLUE && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR && strlen(cg_EnemyColors.string) >= cg_adjustTeamColors.integer ) {
				fadeColor[0] = g_color_table[ ColorIndex( cg_EnemyColors.string[cg_adjustTeamColors.integer - 1] ) ][0];
				fadeColor[1] = g_color_table[ ColorIndex( cg_EnemyColors.string[cg_adjustTeamColors.integer - 1] ) ][1];
				fadeColor[2] = g_color_table[ ColorIndex( cg_EnemyColors.string[cg_adjustTeamColors.integer - 1] ) ][2];
			} else if ( cg_adjustTeamColors.integer && cg_forceColors.integer && cgs.clientinfo[ cg.clientNum ].team == TEAM_BLUE && strlen(colors.string) >= cg_adjustTeamColors.integer ) {
				fadeColor[0] = g_color_table[ ColorIndex( colors.string[cg_adjustTeamColors.integer - 1] ) ][0];
				fadeColor[1] = g_color_table[ ColorIndex( colors.string[cg_adjustTeamColors.integer - 1] ) ][1];
				fadeColor[2] = g_color_table[ ColorIndex( colors.string[cg_adjustTeamColors.integer - 1] ) ][2];
			} else if ( cg_adjustTeamColors.integer && cgs.clientinfo[ cg.clientNum ].team == TEAM_BLUE && strlen(cg_TeamColors.string) >= cg_adjustTeamColors.integer ) {
				fadeColor[0] = g_color_table[ ColorIndex( cg_TeamColors.string[cg_adjustTeamColors.integer - 1] ) ][0];
				fadeColor[1] = g_color_table[ ColorIndex( cg_TeamColors.string[cg_adjustTeamColors.integer - 1] ) ][1];
				fadeColor[2] = g_color_table[ ColorIndex( cg_TeamColors.string[cg_adjustTeamColors.integer - 1] ) ][2];
			}
		} else if ( cgs.gametype == GT_CTF && bg_itemlist[value].giType == IT_TEAM && cg.itemPickupFlag == PW_REDFLAG ) {
			//CG_Printf("DrawPickup: %i -- %i -- set red\n", bg_itemlist[value].giType, bg_itemlist[value].giTag );
			if ( cg_adjustTeamColors.integer && cgs.clientinfo[ cg.clientNum ].team != TEAM_RED && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR && strlen(cg_EnemyColors.string) >= cg_adjustTeamColors.integer ) {
				fadeColor[0] = g_color_table[ ColorIndex( cg_EnemyColors.string[cg_adjustTeamColors.integer - 1] ) ][0];
				fadeColor[1] = g_color_table[ ColorIndex( cg_EnemyColors.string[cg_adjustTeamColors.integer - 1] ) ][1];
				fadeColor[2] = g_color_table[ ColorIndex( cg_EnemyColors.string[cg_adjustTeamColors.integer - 1] ) ][2];
			} else if ( cg_adjustTeamColors.integer && cg_forceColors.integer && cgs.clientinfo[ cg.clientNum ].team == TEAM_RED && strlen(colors.string) >= cg_adjustTeamColors.integer ) {
				fadeColor[0] = g_color_table[ ColorIndex( colors.string[cg_adjustTeamColors.integer - 1] ) ][0];
				fadeColor[1] = g_color_table[ ColorIndex( colors.string[cg_adjustTeamColors.integer - 1] ) ][1];
				fadeColor[2] = g_color_table[ ColorIndex( colors.string[cg_adjustTeamColors.integer - 1] ) ][2];
			} else if ( cg_adjustTeamColors.integer && cgs.clientinfo[ cg.clientNum ].team == TEAM_RED && strlen(cg_TeamColors.string) >= cg_adjustTeamColors.integer ) {
				fadeColor[0] = g_color_table[ ColorIndex( cg_TeamColors.string[cg_adjustTeamColors.integer - 1] ) ][0];
				fadeColor[1] = g_color_table[ ColorIndex( cg_TeamColors.string[cg_adjustTeamColors.integer - 1] ) ][1];
				fadeColor[2] = g_color_table[ ColorIndex( cg_TeamColors.string[cg_adjustTeamColors.integer - 1] ) ][2];
			}
		}
		trap_R_SetColor( fadeColor );
		if ( cg_adjustTeamColors.integer && bg_itemlist[value].giType == IT_TEAM ) {
			CG_DrawPic( 8, y, ICON_SIZE, ICON_SIZE, trap_R_RegisterShader("icons/iconf_fla1") );
		} else {
			CG_DrawPic( 8, y, ICON_SIZE, ICON_SIZE, cg_items[ value ].icon );
		}
	}

	fontFade = CG_FadeColor( cg.itemPickupTime, 3000 );
	if ( fontFade ) {
		CG_DrawStringExt(ICON_SIZE + 16, y + (ICON_SIZE/2 - BIGCHAR_HEIGHT/2), bg_itemlist[ value ].pickup_name, fontFade, qfalse, qfalse,
						BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
	}
	trap_R_SetColor( NULL );

	
	return y;
}
#endif // MISSIONPACK

/*
=====================
CG_DrawLowerLeft

=====================
*/
#ifndef MISSIONPACK
static void CG_DrawLowerLeft( void ) {
	float	y;

	y = 480 - ICON_SIZE;

	if ( cgs.gametype >= GT_TEAM && cg_drawTeamOverlay.integer == 3 ) {
		y = CG_DrawTeamOverlay( y, qfalse, qfalse );
	} 


	y = CG_DrawPickupItem( y );
}
#endif // MISSIONPACK


//===========================================================================================

/*
=================
CG_DrawTeamInfo
=================
*/
#ifndef MISSIONPACK
void CG_DrawTeamInfo( void ) {
	int w, h;
	int i, len;
	vec4_t		hcolor;
	int		chatHeight;

#define CHATLOC_Y 420 // bottom end
#define CHATLOC_X 0

	if (cg_teamChatHeight.integer < TEAMCHAT_HEIGHT)
		chatHeight = cg_teamChatHeight.integer;
	else
		chatHeight = TEAMCHAT_HEIGHT;
	if (chatHeight <= 0)
		return; // disabled

	if (cgs.teamLastChatPos != cgs.teamChatPos) {
		if (cg.time - cgs.teamChatMsgTimes[cgs.teamLastChatPos % chatHeight] > cg_teamChatTime.integer) {
			cgs.teamLastChatPos++;
		}

		h = (cgs.teamChatPos - cgs.teamLastChatPos) * TINYCHAR_HEIGHT;

		w = 0;

		for (i = cgs.teamLastChatPos; i < cgs.teamChatPos; i++) {
			len = CG_DrawStrlen(cgs.teamChatMsgs[i % chatHeight]);
			if (len > w)
				w = len;
		}
		w *= TINYCHAR_WIDTH;
		w += TINYCHAR_WIDTH * 2;

		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED ) {
			hcolor[0] = 1.0f;
			hcolor[1] = 0.0f;
			hcolor[2] = 0.0f;
			hcolor[3] = 0.33f;
		} else if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
			hcolor[0] = 0.0f;
			hcolor[1] = 0.0f;
			hcolor[2] = 1.0f;
			hcolor[3] = 0.33f;
		} else {
			hcolor[0] = 0.0f;
			hcolor[1] = 1.0f;
			hcolor[2] = 0.0f;
			hcolor[3] = 0.33f;
		}

		trap_R_SetColor( hcolor );
		CG_DrawPic( CHATLOC_X, CHATLOC_Y - h, 640, h, cgs.media.teamStatusBar );
		trap_R_SetColor( NULL );

		hcolor[0] = hcolor[1] = hcolor[2] = 1.0f;
		hcolor[3] = 1.0f;

		for (i = cgs.teamChatPos - 1; i >= cgs.teamLastChatPos; i--) {
			CG_DrawStringExt( CHATLOC_X + TINYCHAR_WIDTH, 
				CHATLOC_Y - (cgs.teamChatPos - i)*TINYCHAR_HEIGHT, 
				cgs.teamChatMsgs[i % chatHeight], hcolor, qfalse, qfalse,
				TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0, 0, 0 );
		}
	}
}
#endif // MISSIONPACK

/*
===================
CG_DrawHoldableItem
===================
*/
#ifndef MISSIONPACK
void CG_DrawHoldableItem( void ) { 
	int		value;

	value = cg.snap->ps.stats[STAT_HOLDABLE_ITEM];
	if ( value ) {
		CG_RegisterItemVisuals( value );
		CG_DrawPic( 640-ICON_SIZE, (SCREEN_HEIGHT-ICON_SIZE)/2, ICON_SIZE, ICON_SIZE, cg_items[ value ].icon );
	}

}
#endif // MISSIONPACK

#ifdef MISSIONPACK
/*
===================
CG_DrawPersistantPowerup
===================
*/
#if 0 // sos001208 - DEAD
static void CG_DrawPersistantPowerup( void ) { 
	int		value;

	value = cg.snap->ps.stats[STAT_PERSISTANT_POWERUP];
	if ( value ) {
		CG_RegisterItemVisuals( value );
		CG_DrawPic( 640-ICON_SIZE, (SCREEN_HEIGHT-ICON_SIZE)/2 - ICON_SIZE, ICON_SIZE, ICON_SIZE, cg_items[ value ].icon );
	}
}
#endif
#endif // MISSIONPACK


/*
===================
CG_DrawReward
===================
*/
void CG_DrawReward( void ) { 
	float	*color;
	int		i, count;
	float	x, y;
	char	buf[32];

	if ( cg_drawRewards.integer != 1 ) {
		return;
	}

	color = CG_FadeColor( cg.rewardTime, REWARD_TIME );
	if ( !color ) {
		if (cg.rewardStack > 0) {
			for(i = 0; i < cg.rewardStack; i++) {
				cg.rewardSound[i] = cg.rewardSound[i+1];
				cg.rewardShader[i] = cg.rewardShader[i+1];
				cg.rewardCount[i] = cg.rewardCount[i+1];
			}
			cg.rewardTime = cg.time;
			cg.rewardStack--;
			color = CG_FadeColor( cg.rewardTime, REWARD_TIME );
			trap_S_StartLocalSound(cg.rewardSound[0], CHAN_ANNOUNCER);
		} else {
			return;
		}
	}

	trap_R_SetColor( color );

	/*
	count = cg.rewardCount[0]/10;				// number of big rewards to draw

	if (count) {
		y = 4;
		x = 320 - count * ICON_SIZE;
		for ( i = 0 ; i < count ; i++ ) {
			CG_DrawPic( x, y, (ICON_SIZE*2)-4, (ICON_SIZE*2)-4, cg.rewardShader[0] );
			x += (ICON_SIZE*2);
		}
	}

	count = cg.rewardCount[0] - count*10;		// number of small rewards to draw
	*/

	if ( cg.rewardCount[0] >= 10 ) {
		y = 56;
		x = 320 - ICON_SIZE/2;
		CG_DrawPic( x, y, ICON_SIZE-4, ICON_SIZE-4, cg.rewardShader[0] );
		Com_sprintf(buf, sizeof(buf), "%d", cg.rewardCount[0]);
		x = ( SCREEN_WIDTH - SMALLCHAR_WIDTH * CG_DrawStrlen( buf ) ) / 2;
		CG_DrawStringExt( x, y+ICON_SIZE, buf, color, qfalse, qtrue,
								SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0, 0, 0 );
	}
	else {

		count = cg.rewardCount[0];

		y = 56;
		x = 320 - count * ICON_SIZE/2;
		for ( i = 0 ; i < count ; i++ ) {
			CG_DrawPic( x, y, ICON_SIZE-4, ICON_SIZE-4, cg.rewardShader[0] );
			x += ICON_SIZE;
		}
	}
	trap_R_SetColor( NULL );
}


/*
===============================================================================

LAGOMETER

===============================================================================
*/



/*
==============
CG_AddLagometerFrameInfo

Adds the current interpolate / extrapolate bar for this frame
==============
*/
void CG_AddLagometerFrameInfo( void ) {
	int			offset;

	offset = cg.time - cg.latestSnapshotTime;
	lagometer.frameSamples[ lagometer.frameCount & ( LAG_SAMPLES - 1) ] = offset;
	lagometer.frameCount++;
}

/*
==============
CG_AddLagometerSnapshotInfo

Each time a snapshot is received, log its ping time and
the number of snapshots that were dropped before it.

Pass NULL for a dropped packet.
==============
*/
void CG_AddLagometerSnapshotInfo( snapshot_t *snap ) {
	// dropped packet
	if ( !snap ) {
		lagometer.snapshotSamples[ lagometer.snapshotCount & ( LAG_SAMPLES - 1) ] = -1;
		lagometer.snapshotCount++;
		return;
	}

	// add this snapshot's info
	lagometer.snapshotSamples[ lagometer.snapshotCount & ( LAG_SAMPLES - 1) ] = snap->ping;
	lagometer.snapshotFlags[ lagometer.snapshotCount & ( LAG_SAMPLES - 1) ] = snap->snapFlags;
	lagometer.snapshotCount++;
}

/*
==============
CG_DrawDisconnect

Should we draw something differnet for long lag vs no packets?
==============
*/
void CG_DrawDisconnect( void ) {
	float		x, y;
	int			cmdNum;
	usercmd_t	cmd;
	const char		*s;
	int			w;  // bk010215 - FIXME char message[1024];

	// draw the phone jack if we are completely past our buffers
	cmdNum = trap_GetCurrentCmdNumber() - CMD_BACKUP + 1;
	trap_GetUserCmd( cmdNum, &cmd );
	if ( cmd.serverTime <= cg.snap->ps.commandTime
		|| cmd.serverTime > cg.time ) {	// special check for map_restart // bk 0102165 - FIXME
		return;
	}

	// also add text in center of screen
	s = "Connection Interrupted"; // bk 010215 - FIXME
	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
	//CG_DrawBigString( 320 - w/2, 100, s, 1.0F);
	CG_DrawStringExt(320 - w / 2, 100, s, colorWhite, qfalse, qfalse,
								BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );

	// blink the icon
	if ( ( cg.time >> 9 ) & 1 ) {
		return;
	}

	x = 640 - 48;
	y = 480 - 48;

	CG_DrawPic( x, y, 48, 48, trap_R_RegisterShader("gfx/2d/net.tga" ) );
}


#define	MAX_LAGOMETER_PING	900
#define	MAX_LAGOMETER_RANGE	300

/*
==============
CG_DrawLagometer
==============
*/
static void CG_DrawLagometer() {
	int		a, x, y, i;
	float	v;
	float	ax, ay, aw, ah, mid, range;
	int		color;
	float	vscale;

	if ( !cg_lagometer.integer || cgs.localServer ) {
		CG_DrawDisconnect();
		return;
	}

	//
	// draw the graph
	//
#ifdef MISSIONPACK
	x = 640 - 48;
	y = 480 - 144;
#else
		x = 640 - 48;
		y = 480 - 48;
#endif

	trap_R_SetColor( NULL );

	CG_DrawPic( x, y, 48, 48, cgs.media.lagometerShader );

	ax = x;
	ay = y;
	aw = 48;
	ah = 48;
	CG_AdjustFrom640( &ax, &ay, &aw, &ah );

	color = -1;
	range = ah / 3;
	mid = ay + range;

	vscale = range / MAX_LAGOMETER_RANGE;

	// draw the frame interpoalte / extrapolate graph
	for ( a = 0 ; a < aw ; a++ ) {
		i = ( lagometer.frameCount - 1 - a ) & (LAG_SAMPLES - 1);
		v = lagometer.frameSamples[i];
		v *= vscale;
		if ( v > 0 ) {
			if ( color != 1 ) {
				color = 1;
				trap_R_SetColor( g_color_table[ColorIndex(COLOR_YELLOW)] );
			}
			if ( v > range ) {
				v = range;
			}
			trap_R_DrawStretchPic ( ax + aw - a, mid - v, 1, v, 0, 0, 0, 0, cgs.media.whiteShader );
		} else if ( v < 0 ) {
			if ( color != 2 ) {
				color = 2;
				trap_R_SetColor( g_color_table[ColorIndex(COLOR_BLUE)] );
			}
			v = -v;
			if ( v > range ) {
				v = range;
			}
			trap_R_DrawStretchPic( ax + aw - a, mid, 1, v, 0, 0, 0, 0, cgs.media.whiteShader );
		}
	}

	// draw the snapshot latency / drop graph
	range = ah / 2;
	vscale = range / MAX_LAGOMETER_PING;

	for ( a = 0 ; a < aw ; a++ ) {
		i = ( lagometer.snapshotCount - 1 - a ) & (LAG_SAMPLES - 1);
		v = lagometer.snapshotSamples[i];
		if ( v > 0 ) {
			if ( lagometer.snapshotFlags[i] & SNAPFLAG_RATE_DELAYED ) {
				if ( color != 5 ) {
					color = 5;	// YELLOW for rate delay
					trap_R_SetColor( g_color_table[ColorIndex(COLOR_YELLOW)] );
				}
			} else {
				if ( color != 3 ) {
					color = 3;
					trap_R_SetColor( g_color_table[ColorIndex(COLOR_GREEN)] );
				}
			}
			v = v * vscale;
			if ( v > range ) {
				v = range;
			}
			trap_R_DrawStretchPic( ax + aw - a, ay + ah - v, 1, v, 0, 0, 0, 0, cgs.media.whiteShader );
		} else if ( v < 0 ) {
			if ( color != 4 ) {
				color = 4;		// RED for dropped snapshots
				trap_R_SetColor( g_color_table[ColorIndex(COLOR_RED)] );
			}
			trap_R_DrawStretchPic( ax + aw - a, ay + ah - range, 1, range, 0, 0, 0, 0, cgs.media.whiteShader );
		}
	}

	trap_R_SetColor( NULL );

	if ( cg_nopredict.integer || cg_synchronousClients.integer ) {
		//CG_DrawBigString( ax, ay, "snc", 1.0 );
		CG_DrawStringExt(ax, ay, "snc", colorBlue, qfalse, qfalse,
								BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
	}

	CG_DrawDisconnect();
}



/*
===============================================================================

CENTER PRINTING

===============================================================================
*/


/*
==============
CG_CenterPrint

Called for important messages that should stay in the center of the screen
for a few moments
==============
*/
void CG_CenterPrint( const char *str, int y, int charWidth ) {
	char	*s;

	Q_strncpyz( cg.centerPrint, str, sizeof(cg.centerPrint) );

	cg.centerPrintTime = cg.time;
	cg.centerPrintY = y;
	cg.centerPrintCharWidth = charWidth;

	// count the number of lines for centering
	cg.centerPrintLines = 1;
	s = cg.centerPrint;
	while( *s ) {
		if (*s == '\n')
			cg.centerPrintLines++;
		s++;
	}
}


/*
===================
CG_DrawCenterString
===================
*/
void CG_DrawCenterString( void ) {
	char	*start;
	int		l;
	int		x, y, w;
#ifdef MISSIONPACK // bk010221 - unused else
  int h;
#endif
	float	*color;

	if ( !cg.centerPrintTime ) {
		return;
	}

	color = CG_FadeColor( cg.centerPrintTime, 1000 * cg_centertime.value );
	if ( !color ) {
		return;
	}

	trap_R_SetColor( color );

	start = cg.centerPrint;

	if ( cg.scoreBoardShowing ) //CenterPrint above scoreboard
		y = 10;
	else
		y = cg.centerPrintY - cg.centerPrintLines * BIGCHAR_HEIGHT / 2;

	while ( 1 ) {
		char linebuffer[1024];

		for ( l = 0; l < 50; l++ ) {
			if ( !start[l] || start[l] == '\n' ) {
				break;
			}
			linebuffer[l] = start[l];
		}
		linebuffer[l] = 0;

#ifdef MISSIONPACK
		w = CG_Text_Width(linebuffer, 0.5, 0);
		h = CG_Text_Height(linebuffer, 0.5, 0);
		x = (SCREEN_WIDTH - w) / 2;
		CG_Text_Paint(x, y + h, 0.5, color, linebuffer, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
		y += h + 6;
#else
		w = cg.centerPrintCharWidth * CG_DrawStrlen( linebuffer );

		x = ( SCREEN_WIDTH - w ) / 2;

		CG_DrawStringExt( x, y, linebuffer, color, qfalse, qtrue,
			cg.centerPrintCharWidth, (int)(cg.centerPrintCharWidth * 1.5), 0, 0, 0 );

		y += cg.centerPrintCharWidth * 1.5;
#endif
		while ( *start && ( *start != '\n' ) ) {
			start++;
		}
		if ( !*start ) {
			break;
		}
		start++;
	}

	trap_R_SetColor( NULL );
}



/*
================================================================================

CROSSHAIR

================================================================================
*/


/*
=================
CG_DrawCrosshair
=================
*/
void CG_DrawCrosshair(void) {
	float		w, h;
	qhandle_t	hShader;
	float		f;
	float		x, y;
	int			ca;

	if ( !cg_drawCrosshair.integer ) {
		return;
	}

	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR) {
		return;
	}

	if ( cg.renderingThirdPerson ) {
		return;
	}

	
	// set color based on health
	if ( cg_crosshairHealth.integer == 1 ) {
		vec4_t		hcolor;

		CG_ColorForHealth( hcolor );
		trap_R_SetColor( hcolor );
	} else if ( strlen(cg_crosshairColor.string) >= 1 ) {
		trap_R_SetColor( g_color_table[ ColorIndex( cg_crosshairColor.string[0] ) ] );
	} else {
		trap_R_SetColor( colorWhite );
	}

	w = h = cg_crosshairSize.value;

	// pulse the size of the crosshair when picking up items
	if ( cg_crosshairPulse.integer ) {
		f = cg.time - cg.itemPickupBlendTime;
		if ( f > 0 && f < ITEM_BLOB_TIME ) {
			f /= ITEM_BLOB_TIME;
			w *= ( 1 + f );
			h *= ( 1 + f );
		}
	}

	x = cg_crosshairX.integer;
	y = cg_crosshairY.integer;
	CG_AdjustFrom640( &x, &y, &w, &h );

	ca = cg_drawCrosshair.integer;
	if (ca < 0) {
		ca = 0;
	}
	hShader = cgs.media.crosshairShader[ ca % NUM_CROSSHAIRS ];

	trap_R_DrawStretchPic( x + cg.refdef.x + 0.5 * (cg.refdef.width - w), 
		y + cg.refdef.y + 0.5 * (cg.refdef.height - h), 
		w, h, 0, 0, 1, 1, hShader );
}



/*
=================
CG_ScanForCrosshairEntity
=================
*/
void CG_ScanForCrosshairEntity( void ) {
	trace_t		trace;
	vec3_t		start, end;
	int			content;

	VectorCopy( cg.refdef.vieworg, start );
	VectorMA( start, 131072, cg.refdef.viewaxis[0], end );

	CG_Trace( &trace, start, vec3_origin, vec3_origin, end, 
		cg.snap->ps.clientNum, CONTENTS_SOLID|CONTENTS_BODY );
	if ( trace.entityNum >= MAX_CLIENTS ) {
//freeze
		if ( g_gamemode.integer > 3 ) {
			entityState_t	*es;

			es = &cg_entities[ trace.entityNum ].currentState;
			if ( es->powerups & ( 1 << PW_BATTLESUIT ) ) {
				cg.crosshairClientNum = es->otherEntityNum;
				cg.crosshairClientTime = cg.time;
			}
		}
//freeze
		return;
	}

	// if the player is in fog, don't show it
	content = trap_CM_PointContents( trace.endpos, 0 );
	if ( content & CONTENTS_FOG ) {
		return;
	}

	// if the player is invisible, don't show it
	if ( cg_entities[ trace.entityNum ].currentState.powerups & ( 1 << PW_INVIS ) ) {
		return;
	}

	// update the fade timer
	cg.crosshairClientNum = trace.entityNum;
	cg.crosshairClientTime = cg.time;
}


/*
=====================
CG_DrawCrosshairNames
=====================
*/
static void CG_DrawCrosshairNames() {
	float		*color;
	char		*name;
	float		w;

	if ( !cg_drawCrosshair.integer ) {
		return;
	}
	if ( !cg_drawCrosshairNames.integer ) {
		return;
	}
	if ( cg.renderingThirdPerson ) {
		return;
	}

	// scan the known entities to see if the crosshair is sighted on one
	CG_ScanForCrosshairEntity();

	// draw the name of the player being looked at
	color = CG_FadeColor( cg.crosshairClientTime, 1000 );
	if ( !color ) {
		trap_R_SetColor( NULL );
		return;
	}

	if ( (cg_drawCrosshairNames.integer > 1 && cgs.gametype < GT_TEAM) || (cg_drawCrosshairNames.integer == 2 && cgs.clientinfo[ cg.crosshairClientNum ].team == cgs.clientinfo[ cg.clientNum ].team && cgs.gametype >= GT_TEAM) ||
		 (cg_drawCrosshairNames.integer == 3 && cgs.clientinfo[ cg.crosshairClientNum ].team != cgs.clientinfo[ cg.clientNum ].team && cgs.gametype >= GT_TEAM) ) {
			return;
	}

	name = cgs.clientinfo[ cg.crosshairClientNum ].name;
#ifdef MISSIONPACK
	color[3] *= 0.5f;
	w = CG_Text_Width(name, 0.3f, 0);
	CG_Text_Paint( 320 - w / 2, 190, 0.3f, color, name, 0, 0, ITEM_TEXTSTYLE_SHADOWED);
#else

	w = CG_DrawStrlen( name ) * BIGCHAR_WIDTH;
	CG_DrawStringExt( 320 - w / 2, 200, name, colorWhite, qfalse, qfalse, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );


#endif
	trap_R_SetColor( NULL );
}


//==============================================================================

/*
=================
CG_DrawSpectator
=================
*/
static void CG_DrawSpectator() {

	CG_DrawStringExt(320 - 9 * 8, 440, "SPECTATOR", colorWhite, qfalse, qfalse,
								BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
/*freeze
	if ( cgs.gametype == GT_TOURNAMENT ) {
freeze*/
	if ( cgs.gametype == GT_TOURNAMENT || Q_Isfreeze( cg.snap->ps.clientNum ) ) {
//freeze
		CG_DrawStringExt(320 - 15 * 8, 460, "waiting to play", colorWhite, qfalse, qfalse,
									BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );

		if ( cgs.gametype >= GT_TEAM ) {
			//CG_DrawBigString(320 - 39 * 8, 460, "press ESC and use the JOIN menu to play", 1.0F);
			CG_DrawStringExt(320 - 39 * 8, 460, "press ESC and use the JOIN menu to play", colorWhite, qfalse, qfalse,
									BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );

		}
	}
}

/*
=================
CG_DrawVote
=================
*/
static void CG_DrawVote() {
	char	*s;
	int		sec;

	if ( !cgs.voteTime ) {
		return;
	}

	// play a talk beep whenever it is modified
	/*if ( cgs.voteModified ) {
		cgs.voteModified = qfalse;
		trap_S_StartLocalSound( cgs.media.talkSound, CHAN_LOCAL_SOUND );
	}*/

	sec = ( VOTE_TIME - ( cg.time - cgs.voteTime ) ) / 1000;
	/*if ( sec < -2 ) {
		return;
	} else */if ( sec < 0 ) {
		sec = 0;
	}
#ifdef MISSIONPACK
	s = va("VOTE(%i):%s yes:%i no:%i", sec, cgs.voteString, cgs.voteYes, cgs.voteNo);
	CG_DrawSmallString( 0, 58, s, 1.0F );
	s = "or press ESC then click Vote";
	CG_DrawSmallString( 0, 58 + SMALLCHAR_HEIGHT + 2, s, 1.0F );
#else
	s = va("VOTE(%i):%s yes:%i no:%i", sec, cgs.voteString, cgs.voteYes, cgs.voteNo );

	CG_DrawStringExt( 0, 58, s, colorWhite, qtrue, qtrue, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0, 0, 0 );

#endif
}

/*
=================
CG_DrawTeamVote
=================
*/
static void CG_DrawTeamVote( ) {
	char	*s;
	int		sec, cs_offset;

	if ( cgs.clientinfo->team == TEAM_RED )
		cs_offset = 0;
	else if ( cgs.clientinfo->team == TEAM_BLUE )
		cs_offset = 1;
	else
		return;

	
	if ( !cgs.teamVoteTime[cs_offset] ) {
		return;
	}
	//CG_Printf("DBG: Team: %i", cs_offset);
	// play a talk beep whenever it is modified
	/*if ( cgs.teamVoteModified[cs_offset] ) {
		cgs.teamVoteModified[cs_offset] = qfalse;
		trap_S_StartLocalSound( cgs.media.talkSound, CHAN_LOCAL_SOUND );
	}*/

	sec = ( VOTE_TIME - ( cg.time - cgs.teamVoteTime[cs_offset] ) ) / 1000;
	/*if ( sec < -2 ) {
		return;
	} else*/ if ( sec < 0 ) {
		sec = 0;
	}
	s = va("TEAMVOTE(%i):%s yes:%i no:%i", sec, cgs.teamVoteString[cs_offset],
							cgs.teamVoteYes[cs_offset], cgs.teamVoteNo[cs_offset] );

	CG_DrawStringExt( 0, 90, s, colorWhite, qtrue, qfalse, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0, 0, 0 );
}


qboolean CG_DrawScoreboard() {

#ifdef MISSIONPACK
	static qboolean firstTime = qtrue;
	float fade, *fadeColor;

	if (menuScoreboard) {
		menuScoreboard->window.flags &= ~WINDOW_FORCED;
	}
	if (cg_paused.integer) {
		cg.deferredPlayerLoading = 0;
		firstTime = qtrue;
		return qfalse;
	}

	// should never happen in Team Arena
	if (cgs.gametype == GT_SINGLE_PLAYER && cg.predictedPlayerState.pm_type == PM_INTERMISSION ) {
		cg.deferredPlayerLoading = 0;
		firstTime = qtrue;
		return qfalse;
	}

	// don't draw scoreboard during death while warmup up
	if ( cg.warmup && !cg.showScores ) {
		return qfalse;
	}

	if ( cg.showScores || cg.predictedPlayerState.pm_type == PM_DEAD || cg.predictedPlayerState.pm_type == PM_INTERMISSION ) {
		fade = 1.0;
		fadeColor = colorWhite;
	} else {
		fadeColor = CG_FadeColor( cg.scoreFadeTime, FADE_TIME );
		if ( !fadeColor ) {
			// next time scoreboard comes up, don't print killer
			cg.deferredPlayerLoading = 0;
			cg.killerName[0] = 0;
			firstTime = qtrue;
			return qfalse;
		}
		fade = *fadeColor;
	}																					  


	if (menuScoreboard == NULL) {
		if ( cgs.gametype >= GT_TEAM ) {
			menuScoreboard = Menus_FindByName("teamscore_menu");
		} else {
			menuScoreboard = Menus_FindByName("score_menu");
		}
	}

	if (menuScoreboard) {
		if (firstTime) {
			CG_SetScoreSelection(menuScoreboard);
			firstTime = qfalse;
		}
		Menu_Paint(menuScoreboard, qtrue);
	}

	// load any models that have been deferred
	if ( ++cg.deferredPlayerLoading > 10 ) {
		CG_LoadDeferredPlayers();
	}

	return qtrue;
#else
	if ( cg_oldScoreboard.integer >= 0) {
		return CG_DrawOldScoreboard();
	} else {
		return CG_DrawNewScoreboard();
	}
#endif
}

/*
=================
CG_DrawIntermission
=================
*/
void CG_DrawIntermission( void ) {
//	int key;
#ifdef MISSIONPACK
	//if (cg_singlePlayer.integer) {
	//	CG_DrawCenterString();
	//	return;
	//}
#else
	if ( cgs.gametype == GT_SINGLE_PLAYER ) {
		CG_DrawCenterString();
		return;
	}
#endif

	if ( cg_drawClock.integer ) {
		CG_DrawClock( 0 );
	}

	cg.scoreFadeTime = cg.time;
	//Score_Weapon();
	cg.scoreBoardShowing = CG_DrawScoreboard();

	//FIXME: Optimize the foillwing.
	if ( (cg_autoScreenshot.integer == 1 || cg_autoScreenshot.integer == 2) && !cgs.autoScreenshotTaken && cgs.takeScreenshot == 0 ) {
		//Set time delay
		cgs.takeScreenshot = (cg.time + 1000);
	}

	if ( cg.predictedPlayerState.pm_type == PM_INTERMISSION && cgs.stopRecording == 0 && cgs.autoRecording ) {
		cgs.stopRecording = (cg.time + 7000);
	}

	if ( cg_autoScreenshot.integer == 1 && !cgs.autoScreenshotTaken && cg.time >= cgs.takeScreenshot && cgs.takeScreenshot != 0 ) {
		char	*Hn = Q_CleanString( autoFile.hostname );
		qtime_t	qtm;
		//Month.Day.Year--Hostname-Mapname-HH.MM
		trap_RealTime(&qtm);
		cgs.autoRecording = qtrue;
		trap_SendConsoleCommand(va("screenshotJPEG %i.%i.%i--%s-%s-%02i.%02i\n", qtm.tm_mon, qtm.tm_mday, (qtm.tm_year + 1900), Hn, autoFile.map, qtm.tm_hour, qtm.tm_min));
		cgs.autoScreenshotTaken = qtrue;
	} else if ( cg_autoScreenshot.integer == 2 && !cgs.autoScreenshotTaken && cg.time >= cgs.takeScreenshot && cgs.takeScreenshot != 0 ) {
		char	*Hn = Q_CleanString( autoFile.hostname );
		qtime_t	qtm;
		//Month.Day.Year--Hostname-Mapname-HH.MM
		trap_RealTime(&qtm);
		cgs.autoRecording = qtrue;
		trap_SendConsoleCommand(va("screenshot %i.%i.%i--%s-%s-%02i.%02i\n", qtm.tm_mon, qtm.tm_mday, (qtm.tm_year + 1900), Hn, autoFile.map, qtm.tm_hour, qtm.tm_min));
		cgs.autoScreenshotTaken = qtrue;
	}
	if ( (cg.time >= cgs.stopRecording && cgs.autoRecording && cgs.stopRecording != 0) ) {
		cgs.autoRecording = qfalse;
		cgs.stopRecording = 0;
		trap_SendConsoleCommand("stoprecord\n");
	}
}

/*
=================
CG_DrawFollow
=================
*/
static qboolean CG_DrawFollow() {
	float		x;
	vec4_t		color;
	const char	*name;
//	char		following[64];

	if ( !(cg.snap->ps.pm_flags & PMF_FOLLOW) ) {
		return qfalse;
	}
	color[0] = 1;
	color[1] = 1;
	color[2] = 1;
	color[3] = 1;


	//CG_DrawBigString( 320 - (9 + strlen(name)) * 8, 24, "following", 1.0F );

	name = cgs.clientinfo[ cg.snap->ps.clientNum ].name;
	//Com_sprintf(following, sizeof(following), "following %s", name);
	x = 0.5 * ( 640 - 8 * (CG_DrawStrlen( name )) );

	CG_DrawStringExt( 0.5 * (640 - 8 * (CG_DrawStrlen( "Following" ))), 28, "Following", color, qfalse, qtrue, 10, 10, 0, 0, 0 );
	CG_DrawStringExt( x, 40, name, color, qfalse, qtrue, 10, 10, 0, 0, 0 );
	

	return qtrue;
}



/*
=================
CG_DrawAmmoWarning
=================
*/
static void CG_DrawAmmoWarning() {
	const char	*s;
	int			w;

	if ( cg_drawAmmoWarning.integer == 0 ) {
		return;
	}

	if ( !cg.lowAmmoWarning ) {
		return;
	}

	if ( cg.lowAmmoWarning == 2 ) {
		s = "OUT OF AMMO";
	} else {
		s = "LOW AMMO WARNING";
	}

	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
	CG_DrawStringExt( 320 - w / 2, 64, s, colorWhite, qfalse, qfalse, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );

}


#ifdef MISSIONPACK
/*
=================
CG_DrawProxWarning
=================
*/
static void CG_DrawProxWarning( void ) {
	char s [32];
	int			w;
  static int proxTime;
  static int proxCounter;
  static int proxTick;

	if( !(cg.snap->ps.eFlags & EF_TICKING ) ) {
    proxTime = 0;
		return;
	}

  if (proxTime == 0) {
    proxTime = cg.time + 5000;
    proxCounter = 5;
    proxTick = 0;
  }

  if (cg.time > proxTime) {
    proxTick = proxCounter--;
    proxTime = cg.time + 1000;
  }

  if (proxTick != 0) {
    Com_sprintf(s, sizeof(s), "INTERNAL COMBUSTION IN: %i", proxTick);
  } else {
    Com_sprintf(s, sizeof(s), "YOU HAVE BEEN MINED");
  }

	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
	CG_DrawBigStringColor( 320 - w / 2, 64 + BIGCHAR_HEIGHT, s, g_color_table[ColorIndex(COLOR_RED)] );
}
#endif


/*
=================
CG_DrawWarmup
=================
*/
static void CG_DrawWarmup() {
	int			w;
	int			sec;
	int			i;
	float scale;
	clientInfo_t	*ci1, *ci2;
	int			cw;
	const char	*s;

	sec = cg.warmup;
	if ( !sec ) {
		return;
	}

	if ( !cg.showScores ) {
		if ( sec < 0 ) {
			s = "Waiting for players";
			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
			//CG_DrawBigString(320 - w / 2, 24, s, 1.0F);
			CG_DrawStringExt(320 - w * .35, 24, s, colorWhite, qfalse, qtrue,
									BIGCHAR_WIDTH * .75, BIGCHAR_HEIGHT *.75, 0, 0, 0 );
			cg.warmupCount = 0;
			return;
		}

		if (cgs.gametype == GT_TOURNAMENT) {
			// find the two active players
			ci1 = NULL;
			ci2 = NULL;
			for ( i = 0 ; i < cgs.maxclients ; i++ ) {
				if ( cgs.clientinfo[i].infoValid && cgs.clientinfo[i].team == TEAM_FREE ) {
					if ( !ci1 ) {
						ci1 = &cgs.clientinfo[i];
					} else {
						ci2 = &cgs.clientinfo[i];
					}
				}
			}

			if ( ci1 && ci2 ) {
				//I always hated it when players couldn't finish in ^7..
				s = va( "%s "S_COLOR_WHITE"vs %s", ci1->name, ci2->name );
#ifdef MISSIONPACK
				w = CG_Text_Width(s, 0.6f, 0);
				CG_Text_Paint(320 - w / 2, 60, 0.6f, colorWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
#else
				w = CG_DrawStrlen( s );
				if ( w > 640 / GIANT_WIDTH ) {
					cw = 640 / w;
				} else {
					cw = GIANT_WIDTH;
				}
				CG_DrawStringExt( 320 - w * cw/2, 20,s, colorWhite, 
						qfalse, qtrue, cw, (int)(cw * 1.5f), 0, 0, 0 );
#endif
			}
		} else {
			if ( cgs.gametype == GT_FFA ) {
				s = "Free For All";
			} else if ( cgs.gametype == GT_TEAM ) {
				s = "Team Deathmatch";
			} else if ( cgs.gametype == GT_CTF ) {
				s = "Capture the Flag";

#ifdef MISSIONPACK
			} else if ( cgs.gametype == GT_1FCTF ) {
				s = "One Flag CTF";
			} else if ( cgs.gametype == GT_OBELISK ) {
				s = "Overload";
			} else if ( cgs.gametype == GT_HARVESTER ) {
				s = "Harvester";
#endif
			} else {
				s = "";
			}
#ifdef MISSIONPACK
			w = CG_Text_Width(s, 0.6f, 0);
			CG_Text_Paint(320 - w / 2, 90, 0.6f, colorWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
#else
				w = CG_DrawStrlen( s );
				if ( w > 640 / GIANT_WIDTH ) {
					cw = 640 / w;
				} else {
					cw = GIANT_WIDTH;
				}
				CG_DrawStringExt( 320 - w * cw/2, 25,s, colorWhite, 
						qfalse, qtrue, cw, (int)(cw * 1.1f), 0, 0, 0 );
#endif
		}
	}
	sec = ( sec - cg.time ) / 1000;
	if ( sec < 0 ) {
		cg.warmup = 0;
		sec = 0;
	}
	s = va( "Starts in: %i", sec + 1 );
	if ( sec != cg.warmupCount ) {
		cg.warmupCount = sec;
		switch ( sec ) {
		case 0:
			trap_S_StartLocalSound( cgs.media.count1Sound, CHAN_ANNOUNCER );
			break;
		case 1:
			trap_S_StartLocalSound( cgs.media.count2Sound, CHAN_ANNOUNCER );
			break;
		case 2:
			trap_S_StartLocalSound( cgs.media.count3Sound, CHAN_ANNOUNCER );
			break;
		default:
			break;
		}
	}
	if ( !cg.showScores ) {
		scale = 0.45f;
		switch ( cg.warmupCount ) {
		case 0:
			cw = 28;
			scale = 0.54f;
			break;
		case 1:
			cw = 24;
			scale = 0.51f;
			break;
		case 2:
			cw = 20;
			scale = 0.48f;
			break;
		default:
			cw = 16;
			scale = 0.45f;
			break;
		}

#ifdef MISSIONPACK
			w = CG_Text_Width(s, scale, 0);
			CG_Text_Paint(320 - w / 2, 125, scale, colorWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
#else
		w = CG_DrawStrlen( s );
		CG_DrawStringExt( 320 - w * cw/2, 70, s, colorWhite, 
				qfalse, qtrue, cw, (int)(cw * 1.5), 0, 0, 0 );
#endif
	}
}

//==================================================================================
#ifdef MISSIONPACK
/* 
=================
CG_DrawTimedMenus
=================
*/
void CG_DrawTimedMenus() {
	if (cg.voiceTime) {
		int t = cg.time - cg.voiceTime;
		if ( t > 2500 ) {
			Menus_CloseByName("voiceMenu");
			trap_Cvar_Set("cl_conXOffset", "0");
			cg.voiceTime = 0;
		}
	}
}
#endif

/*
=================
Spike's
CG_ExtractToken
=================
*/
void CG_ExtractToken(char **ptr, char *token)
{
	while(**ptr == '"' || **ptr == ' ' || **ptr == '\0')
	{
		if(**ptr == '\0')
			return;

		(*ptr)++;
	}

	while(**ptr != '"' && **ptr != ' ' && **ptr != '\0')
	{
		*token = **ptr;
		(*ptr)++;
		token++;
	}

	*token = '\0';
}

/*
=================
CG_DrawSpeedometer
Spike's Speedometer
=================
*/
void CG_DrawSpeedometer(qboolean draw_speed, qboolean draw_maxspeed, int x, int y, float alpha) {
	float speed;
	char *str;
	int width;
	vec4_t color = {1.0f, 1.0f, 1.0f};

	color[3] = alpha;

	speed = 1.0f / Q_rsqrt(cg.snap->ps.velocity[0] * cg.snap->ps.velocity[0] +
					cg.snap->ps.velocity[1] * cg.snap->ps.velocity[1]);

	if(speed > max_speed)
		max_speed = speed;

	if(draw_speed ) 	{
		str = va("%.3fups", speed);
		width = CG_DrawStrlen(str) * 12;

		CG_DrawStringExt(x - width, y + 2, str, color, qfalse, qfalse, 12, SMALLCHAR_HEIGHT, 0, 0, 0);
	}

	if(draw_maxspeed) {
		y += SMALLCHAR_HEIGHT;
		str = va("%.3fmax", max_speed);
		width = CG_DrawStrlen(str) * 12;

		CG_DrawStringExt(x - width, y + 2, str, color, qfalse, qfalse, 12, SMALLCHAR_HEIGHT, 0, 0, 0);
	}
}

//-------------------------------------
// OB STUFF
//-------------------------------------

typedef struct
{
	float height;
	float offset;
	int type;		//0 = h, 1 = sobh
} ob_info_t;

//these are for speed optimizations
#define OBF_OPT_10			8
#define OBF_OPT_100			24
#define OBF_OPT_500			64
#define OBF_OPT_1000		90
#define OBF_OPT_5000		228
#define OBF_OPT_END			319

ob_info_t fallobs[] =
{
//	{0.0f, -0.026f, 1},
//	{0.0f, -0.099f, 1},
//	{0.0f, -0.221f, 1},
	{-1.0f, 0.126f, 0},		//0
	{-1.0f, -0.187f, 1},
	{-2.0f, 0.042f, 0},
	{-3.0f, 0.078f, 0},
	{-4.0f, -0.077f, 1},
	{-6.0f, -0.170f, 1},
	{-7.0f, 0.037f, 0},
	{-8.0f, 0.195f, 0},
	{-14.0f, 0.138f, 0},
	{-15.0f, -0.040f, 1},
	{-19.0f, 0.139f, 0},	//10
	{-20.0f, -0.230f, 1},
	{-23.0f, -0.114f, 1},
	{-26.0f, -0.189f, 1},
	{-28.0f, 0.202f, 0},
	{-31.0f, -0.162f, 1},
	{-33.0f, 0.085f, 0},
	{-51.0f, 0.142f, 0},
	{-53.0f, -0.091f, 1},
	{-60.0f, -0.080f, 1},
	{-65.0f, 0.021f, 0},	//20
	{-70.0f, -0.070f, 1},
	{-78.0f, -0.067f, 1},
	{-81.0f, 0.171f, 0},
	{-108.0f, 0.157f, 0},
	{-111.0f, -0.085f, 1},
	{-121.0f, -0.098f, 1},
	{-128.0f, -0.013f, 1},
	{-135.0f, -0.120f, 1},
	{-146.0f, -0.141f, 1},
	{-150.0f, 0.090f, 0},	//30
	{-182.0f, 0.205f, 0},
	{-186.0f, 0.003f, 0},
	{-190.0f, -0.246f, 1},
	{-199.0f, 0.110f, 0},
	{-212.0f, -0.214f, 1},
	{-217.0f, 0.248f, 0},
	{-226.0f, 0.029f, 0},
	{-240.0f, -0.160f, 1},
	{-245.0f, 0.014f, 0},
	{-250.0f, 0.141f, 0},	//40
	{-255.0f, 0.219f, 0},
	{-260.0f, 0.250f, 0},
	{-265.0f, 0.232f, 0},
	{-270.0f, 0.166f, 0},
	{-275.0f, 0.053f, 0},
	{-280.0f, -0.109f, 1},
	{-296.0f, 0.118f, 0},
	{-301.0f, -0.235f, 1},
	{-312.0f, -0.086f, 1},
	{-323.0f, -0.130f, 1},	//50
	{-340.0f, -0.054f, 1},
	{-346.0f, 0.208f, 0},
	{-369.0f, -0.222f, 1},
	{-375.0f, -0.200f, 1},
	{-381.0f, -0.226f, 1},
	{-406.0f, 0.192f, 0},
	{-412.0f, -0.074f, 1},
	{-431.0f, -0.158f, 1},
	{-444.0f, -0.122f, 1},
	{-464.0f, 0.074f, 0},	//60
	{-484.0f, -0.163f, 1},
	{-491.0f, -0.005f, 1},
	{-498.0f, 0.106f, 0},
	{-505.0f, 0.168f, 0},
	{-512.0f, 0.182f, 0},
	{-519.0f, 0.149f, 0},
	{-526.0f, 0.067f, 0},
	{-533.0f, -0.062f, 1},
	{-540.0f, -0.240f, 1},
	{-562.0f, -0.061f, 1},	//70
	{-577.0f, 0.152f, 0},
	{-592.0f, 0.173f, 0},
	{-607.0f, 0.002f, 0},
	{-630.0f, -0.115f, 1},
	{-638.0f, 0.083f, 0},
	{-646.0f, 0.234f, 0},
	{-694.0f, 0.128f, 0},
	{-702.0f, -0.058f, 1},
	{-727.0f, 0.098f, 0},
//	{-727.0f, ???, 1},		//TODO: unkown sticky
	{-752.0f, -0.179f, 1},	//80
	{-778.0f, 0.112f, 0},
	{-804.0f, -0.029f, 1},
	{-813.0f, 0.162f, 0},
	{-876.0f, 0.150f, 0},
	{-885.0f, -0.043f, 1},
	{-913.0f, 0.088f, 0},
	{-941.0f, -0.213f, 1},
	{-970.0f, 0.054f, 0},
	{-999.0f, -0.110f, 1},
	{-1009.0f, 0.072f, 0},	//90
//	{-1009.0f, ???, 1},		//TODO: unknown sticky
	{-1019.0f, 0.206f, 0},
	{-1069.0f, 0.158f, 0},
	{-1079.0f, 0.005f, 0},
	{-1089.0f, -0.197f, 1},
	{-1120.0f, -0.090f, 1},
	{-1141.0f, 0.075f, 0},
	{-1162.0f, 0.048f, 0},
	{-1183.0f, -0.171f, 1},
	{-1194.0f, 0.147f, 0},
	{-1226.0f, -0.186f, 1},	//100
	{-1237.0f, -0.059f, 1},
	{-1248.0f, 0.019f, 0},
	{-1259.0f, 0.049f, 0},
	{-1270.0f, 0.032f, 0},
//	{-1270.0f, ???, 1},		//TODO: unknown sticky
	{-1281.0f, -0.034f, 1},
	{-1292.0f, -0.147f, 1},
	{-1326.0f, 0.224f, 0},
	{-1337.0f, -0.082f, 1},
	{-1360.0f, 0.163f, 0},
	{-1383.0f, 0.216f, 0},	//110
	{-1406.0f, 0.077f, 0},
	{-1441.0f, 0.008f, 0},
	{-1453.0f, 0.222f, 0},
	{-1549.0f, 0.209f, 0},
	{-1561.0f, -0.008f, 1},
	{-1598.0f, 0.051f, 0},
	{-1623.0f, 0.184f, 0},
	{-1648.0f, 0.125f, 0},
	{-1673.0f, -0.127f, 1},
	{-1686.0f, 0.176f, 0},	//120
	{-1724.0f, -0.205f, 1},
	{-1737.0f, -0.095f, 1},
	{-1750.0f, -0.032f, 1},
	{-1763.0f, -0.018f, 1},
	{-1776.0f, -0.051f, 1},
	{-1789.0f, -0.133f, 1},
	{-1842.0f, 0.061f, 0},
	{-1882.0f, -0.048f, 1},
	{-1909.0f, -0.027f, 1},
	{-1936.0f, -0.199f, 1},	//130
	{-1950.0f, 0.144f, 0},
	{-1991.0f, -0.117f, 1},
	{-2005.0f, 0.033f, 0},
	{-2019.0f, 0.136f, 0},
	{-2033.0f, 0.190f, 0},
	{-2047.0f, 0.197f, 0},
	{-2061.0f, 0.155f, 0},
	{-2075.0f, 0.065f, 0},
//	{-2075.0f, ???, 1},		//TODO: unknown sticky
	{-2089.0f, -0.072f, 1},
	{-2132.0f, 0.227f, 0},	//140
	{-2146.0f, -0.103f, 1},
	{-2175.0f, 0.094f, 0},
	{-2204.0f, 0.099f, 0},
	{-2233.0f, -0.088f, 1},
	{-2248.0f, 0.246f, 0},
	{-2277.0f, -0.229f, 1},
	{-2292.0f, -0.039f, 1},
	{-2307.0f, 0.104f, 0},
	{-2322.0f, 0.198f, 0},
	{-2337.0f, 0.245f, 0},	//150
	{-2352.0f, 0.243f, 0},
	{-2367.0f, 0.193f, 0},
	{-2382.0f, 0.096f, 0},
	{-2397.0f, -0.050f, 1},
	{-2412.0f, -0.243f, 1},
	{-2443.0f, 0.225f, 0},
	{-2458.0f, -0.112f, 1},
	{-2489.0f, 0.069f, 0},
	{-2520.0f, 0.057f, 0},
	{-2551.0f, -0.146f, 1},	//160
	{-2567.0f, 0.181f, 0},
	{-2614.0f, -0.128f, 1},
	{-2630.0f, 0.006f, 0},
	{-2646.0f, 0.093f, 0},
	{-2662.0f, 0.131f, 0},
	{-2678.0f, 0.121f, 0},
	{-2694.0f, 0.064f, 0},
	{-2710.0f, -0.042f, 1},
	{-2726.0f, -0.196f, 1},
	{-2775.0f, 0.056f, 0},	//170
	{-2824.0f, -0.125f, 1},
	{-2857.0f, -0.152f, 1},
	{-2907.0f, -0.053f, 1},
	{-2924.0f, 0.217f, 0},
	{-2991.0f, -0.181f, 1},
	{-3008.0f, -0.151f, 1},
	{-3025.0f, -0.168f, 1},
	{-3042.0f, -0.234f, 1},
	{-3111.0f, 0.024f, 0},
	{-3163.0f, -0.037f, 1},	//180
	{-3198.0f, 0.016f, 0},
	{-3233.0f, -0.124f, 1},
	{-3251.0f, 0.235f, 0},
	{-3286.0f, -0.192f, 1},
	{-3304.0f, 0.022f, 0},
	{-3322.0f, 0.188f, 0},
	{-3430.0f, 0.179f, 0},
	{-3448.0f, 0.009f, 0},
	{-3466.0f, -0.208f, 1},
	{-3503.0f, 0.212f, 0},	//190
	{-3521.0f, -0.149f, 1},
	{-3558.0f, -0.016f, 1},
	{-3595.0f, -0.076f, 1},
	{-3651.0f, -0.024f, 1},
	{-3670.0f, 0.230f, 0},
	{-3745.0f, -0.232f, 1},
	{-3764.0f, -0.218f, 1},
	{-3860.0f, 0.134f, 0},
	{-3879.0f, -0.140f, 1},
	{-3918.0f, 0.169f, 0},	//200
	{-3937.0f, -0.248f, 1},
	{-3976.0f, -0.228f, 1},
	{-3996.0f, 0.211f, 0},
	{-4035.0f, -0.056f, 1},
	{-4055.0f, 0.238f, 0},
	{-4114.0f, -0.167f, 1},
	{-4134.0f, -0.064f, 1},
	{-4154.0f, -0.010f, 1},
	{-4174.0f, -0.003f, 1},
	{-4194.0f, -0.045f, 1},	//210
	{-4214.0f, -0.135f, 1},
	{-4295.0f, 0.027f, 0},
	{-4356.0f, -0.106f, 1},
	{-4397.0f, -0.101f, 1},
	{-4459.0f, 0.046f, 0},
	{-4521.0f, -0.239f, 1},
	{-4542.0f, -0.096f, 1},
	{-4563.0f, -0.002f, 1},
	{-4584.0f, 0.044f, 0},
	{-4605.0f, 0.043f, 0},	//220
	{-4626.0f, -0.007f, 1},
	{-4647.0f, -0.104f, 1},
	{-4732.0f, 0.025f, 0},
	{-4796.0f, -0.131f, 1},
	{-4839.0f, -0.143f, 1},
	{-4904.0f, -0.020f, 1},
	{-4991.0f, -0.194f, 1},
	{-5013.0f, -0.107f, 1},
	{-5035.0f, -0.069f, 1},
	{-5057.0f, -0.079f, 1},	//230
	{-5079.0f, -0.136f, 1},
	{-5101.0f, -0.242f, 1},
	{-5168.0f, 0.153f, 0},
	{-5190.0f, -0.144f, 1},
	{-5235.0f, 0.117f, 0},
	{-5280.0f, 0.186f, 0},
	{-5325.0f, 0.063f, 0},
	{-5393.0f, 0.018f, 0},
	{-5416.0f, 0.240f, 0},
	{-5623.0f, 0.082f, 0},	//240
	{-5646.0f, -0.176f, 1},
	{-5693.0f, 0.165f, 0},
	{-5716.0f, -0.237f, 1},
	{-5763.0f, -0.184f, 1},
	{-5834.0f, 0.035f, 0},
	{-5905.0f, -0.178f, 1},
	{-5929.0f, -0.011f, 1},
	{-5953.0f, 0.107f, 0},
	{-5977.0f, 0.177f, 0},
	{-6001.0f, 0.200f, 0},	//250
	{-6025.0f, 0.174f, 0},
	{-6049.0f, 0.101f, 0},
	{-6073.0f, -0.021f, 1},
	{-6097.0f, -0.190f, 1},
	{-6170.0f, 0.013f, 0},
	{-6219.0f, 0.241f, 0},
	{-6243.0f, -0.216f, 1},
	{-6317.0f, 0.123f, 0},
	{-6366.0f, -0.224f, 1},
	{-6391.0f, 0.030f, 0},	//260
	{-6416.0f, 0.237f, 0},
	{-6616.0f, 0.160f, 0},
	{-6641.0f, -0.066f, 1},
	{-6717.0f, -0.031f, 1},
	{-6768.0f, 0.086f, 0},
	{-6819.0f, 0.011f, 0},
	{-6896.0f, 0.038f, 0},
	{-7025.0f, -0.210f, 1},
	{-7051.0f, -0.204f, 1},
	{-7077.0f, -0.245f, 1},	//270
	{-7182.0f, 0.108f, 0},
	{-7208.0f, -0.173f, 1},
	{-7261.0f, 0.120f, 0},
	{-7314.0f, 0.220f, 0},
	{-7367.0f, 0.129f, 0},
	{-7420.0f, -0.154f, 1},
	{-7447.0f, 0.132f, 0},
	{-7554.0f, -0.202f, 1},
	{-7581.0f, -0.156f, 1},
	{-7608.0f, -0.157f, 1},	//280
	{-7635.0f, -0.207f, 1},
	{-7744.0f, 0.115f, 0},
	{-7771.0f, -0.175f, 1},
	{-7826.0f, 0.102f, 0},
	{-7881.0f, 0.187f, 0},
	{-7936.0f, 0.080f, 0},
	{-7991.0f, -0.220f, 1},
	{-8019.0f, 0.059f, 0},
	{-8299.0f, 0.204f, 0},
	{-8327.0f, -0.046f, 1},	//290
	{-8412.0f, -0.083f, 1},
	{-8469.0f, -0.014f, 1},
	{-8526.0f, -0.138f, 1},
	{-8555.0f, 0.229f, 0},
	{-8612.0f, -0.183f, 1},
	{-8641.0f, 0.040f, 0},
	{-8670.0f, 0.215f, 0},
	{-8873.0f, 0.092f, 0},
	{-8902.0f, -0.118f, 1},
	{-8990.0f, -0.035f, 1},	//300
	{-9049.0f, 0.114f, 0},
	{-9108.0f, 0.070f, 0},
	{-9167.0f, -0.165f, 1},
	{-9197.0f, 0.146f, 0},
	{-9286.0f, -0.211f, 1},
	{-9316.0f, -0.093f, 1},
	{-9346.0f, -0.022f, 1},
	{-9406.0f, -0.025f, 1},
	{-9436.0f, -0.099f, 1},
	{-9466.0f, -0.221f, 1},	//310
	{-9557.0f, 0.126f, 0},
	{-9587.0f, -0.188f, 1},
	{-9648.0f, 0.042f, 0},
	{-9709.0f, 0.078f, 0},
	{-9770.0f, -0.077f, 1},
	{-9862.0f, -0.169f, 1},
	{-9893.0f, 0.037f, 0},
	{-9924.0f, 0.195f, 0}	//318
};

#define OBJ_OPT_5			49
#define OBJ_OPT_30			55
#define OBJ_OPT_100			69
#define OBJ_OPT_500			104
#define OBJ_OPT_1005		138
#define OBJ_OPT_5000		251
#define OBJ_OPT_END			349

ob_info_t jumpobs[] =
{
	{2.0f, 0.134f, 0},		//0
	{4.0f, 0.221f, 0},
	{8.0f, 0.250f, 0},
	{10.0f, 0.192f, 0},
	{12.0f, 0.086f, 0},
	{14.0f, -0.067f, 1},
	{19.0f, 0.184f, 0},
	{21.0f, -0.162f, 1},
	{24.0f, 0.003f, 0},
	{27.0f, -0.024f, 1},
	{30.0f, -0.243f, 1},	//10
	{31.0f, 0.075f, 0},
	{36.0f, -0.131f, 1},
	{37.0f, -0.053f, 1},
	{38.0f, -0.022f, 1},
	{39.0f, -0.040f, 1},
	{40.0f, -0.106f, 1},
	{41.0f, -0.219f, 1},
	{43.0f, 0.152f, 0},
	{44.0f, -0.154f, 1},
	{45.0f, 0.091f, 0},		//20
	{46.0f, 0.144f, 0},
	{47.0f, 0.005f, 0},
	{48.0f, -0.064f, 1},
	{48.0f, 0.150f, 0},
	{48.0f, 0.138f, 0},
	{48.0f, -0.080f, 1},
	{47.0f, -0.021f, 1},
	{46.0f, 0.112f, 0},
	{45.0f, 0.053f, 0},
	{44.0f, -0.198f, 1},	//30
	{43.0f, 0.104f, 0},
	{40.0f, -0.166f, 1},
	{39.0f, -0.104f, 1},
	{38.0f, -0.090f, 1},
	{37.0f, -0.123f, 1},
	{36.0f, -0.205f, 1},
	{31.0f, -0.011f, 1},
	{27.0f, -0.120f, 1},
	{24.0f, -0.099f, 1},
	{19.0f, 0.072f, 0},		//40
	{14.0f, -0.189f, 1},
	{12.0f, -0.038f, 1},
	{10.0f, 0.064f, 0},
	{8.0f, 0.118f, 0},
	{6.0f, 0.125f, 0},
	{4.0f, 0.083f, 0},
	{2.0f, -0.006f, 1},
	{0.0f, -0.144f, 1},		//special case
	{-7.0f, 0.155f, 0},
	{-9.0f, -0.174f, 1},	//50
	{-14.0f, 0.022f, 0},
	{-19.0f, 0.027f, 0},
	{-24.0f, -0.160f, 1},
	{-27.0f, 0.174f, 0},
	{-35.0f, -0.110f, 1},
	{-38.0f, 0.032f, 0},
	{-41.0f, 0.126f, 0},
	{-44.0f, 0.173f, 0},
	{-47.0f, 0.171f, 0},
	{-50.0f, 0.122f, 0},	//60
	{-53.0f, 0.024f, 0},
	{-56.0f, -0.122f, 1},
	{-66.0f, 0.154f, 0},
	{-69.0f, -0.184f, 1},
	{-76.0f, -0.003f, 1},
	{-83.0f, -0.014f, 1},
	{-90.0f, -0.218f, 1},
	{-94.0f, 0.109f, 0},
	{-105.0f, -0.200f, 1},
	{-109.0f, -0.066f, 1},	//70
	{-113.0f, 0.021f, 0},
	{-117.0f, 0.059f, 0},
	{-121.0f, 0.050f, 0},
	{-125.0f, -0.008f, 1},
	{-129.0f, -0.114f, 1},
	{-146.0f, -0.016f, 1},
	{-155.0f, 0.245f, 0},
	{-159.0f, -0.197f, 1},
	{-168.0f, -0.224f, 1},
	{-173.0f, 0.190f, 0},	//80
	{-182.0f, -0.125f, 1},
	{-187.0f, 0.146f, 0},
	{-211.0f, -0.222f, 1},
	{-216.0f, -0.240f, 1},
	{-237.0f, 0.210f, 0},
	{-242.0f, -0.048f, 1},
	{-258.0f, -0.109f, 1},
	{-269.0f, -0.056f, 1},
	{-280.0f, -0.195f, 1},
	{-286.0f, 0.163f, 0},	//90
	{-303.0f, -0.050f, 1},
	{-309.0f, 0.117f, 0},
	{-315.0f, 0.235f, 0},
	{-339.0f, 0.229f, 0},
	{-345.0f, 0.107f, 0},
	{-351.0f, -0.062f, 1},
	{-370.0f, 0.141f, 0},
	{-376.0f, -0.221f, 1},
	{-389.0f, -0.088f, 1},
	{-402.0f, -0.147f, 1},	//100
	{-422.0f, -0.096f, 1},
	{-429.0f, 0.158f, 0},
	{-499.0f, 0.062f, 0},
	{-506.0f, -0.211f, 1},
	{-521.0f, 0.098f, 0},
	{-536.0f, 0.214f, 0},
	{-551.0f, 0.139f, 0},
	{-566.0f, -0.128f, 1},
	{-574.0f, 0.166f, 0},
	{-597.0f, -0.238f, 1},	//110
	{-605.0f, -0.136f, 1},
	{-613.0f, -0.082f, 1},
	{-621.0f, -0.075f, 1},
	{-629.0f, -0.117f, 1},
	{-637.0f, -0.206f, 1},
	{-662.0f, 0.237f, 0},
	{-670.0f, -0.045f, 1},
	{-687.0f, 0.248f, 0},
	{-695.0f, -0.178f, 1},
	{-712.0f, -0.173f, 1},	//120
	{-738.0f, -0.026f, 1},
	{-773.0f, -0.168f, 1},
	{-782.0f, -0.074f, 1},
	{-791.0f, -0.027f, 1},
	{-800.0f, -0.029f, 1},
	{-809.0f, -0.078f, 1},
	{-818.0f, -0.176f, 1},
	{-846.0f, 0.243f, 0},
	{-855.0f, -0.046f, 1},
	{-874.0f, 0.230f, 0},	//130
	{-883.0f, -0.203f, 1},
	{-902.0f, -0.214f, 1},
	{-912.0f, 0.208f, 0},
	{-931.0f, -0.091f, 1},
	{-941.0f, 0.187f, 0},
	{-980.0f, -0.179f, 1},
	{-990.0f, -0.141f, 1},
	{-1000.0f, -0.150f, 1},
	{-1010.0f, -0.208f, 1},
	{-1051.0f, 0.081f, 0},	//140
	{-1061.0f, -0.216f, 1},
	{-1082.0f, 0.045f, 0},
	{-1103.0f, 0.113f, 0},
	{-1124.0f, -0.010f, 1},
	{-1156.0f, -0.055f, 1},
	{-1167.0f, 0.168f, 0},
	{-1255.0f, 0.219f, 0},
	{-1266.0f, 0.009f, 0},
	{-1277.0f, -0.248f, 1},
	{-1300.0f, 0.093f, 0},	//150
	{-1323.0f, 0.241f, 0},
	{-1346.0f, 0.198f, 0},
	{-1369.0f, -0.037f, 1},
	{-1404.0f, -0.250f, 1},
	{-1416.0f, -0.083f, 1},
	{-1428.0f, 0.035f, 0},
	{-1440.0f, 0.105f, 0},
	{-1452.0f, 0.128f, 0},
	{-1464.0f, 0.102f, 0},
	{-1476.0f, 0.029f, 0},	//160
	{-1488.0f, -0.093f, 1},
	{-1537.0f, -0.059f, 1},
	{-1562.0f, 0.169f, 0},
	{-1587.0f, 0.206f, 0},
	{-1612.0f, 0.051f, 0},
	{-1650.0f, -0.042f, 1},
	{-1663.0f, 0.165f, 0},
	{-1767.0f, 0.088f, 0},
	{-1780.0f, -0.138f, 1},
	{-1820.0f, -0.103f, 1},	//170
	{-1847.0f, 0.014f, 0},
	{-1874.0f, -0.061f, 1},
	{-1915.0f, -0.034f, 1},
	{-1929.0f, 0.213f, 0},
	{-2069.0f, 0.037f, 0},
	{-2083.0f, -0.245f, 1},
	{-2112.0f, 0.048f, 0},
	{-2141.0f, 0.149f, 0},
	{-2170.0f, 0.058f, 0},
	{-2199.0f, -0.226f, 1},	//180
	{-2214.0f, 0.061f, 0},
	{-2288.0f, -0.227f, 1},
	{-2303.0f, -0.229f, 1},
	{-2379.0f, 0.043f, 0},
	{-2394.0f, -0.247f, 1},
	{-2425.0f, 0.030f, 0},
	{-2456.0f, 0.115f, 0},
	{-2487.0f, 0.008f, 0},
	{-2534.0f, -0.013f, 1},
	{-2550.0f, 0.218f, 0},	//190
	{-2694.0f, 0.131f, 0},
	{-2710.0f, -0.119f, 1},
	{-2743.0f, 0.238f, 0},
	{-2759.0f, -0.156f, 1},
	{-2792.0f, -0.087f, 1},
	{-2825.0f, -0.210f, 1},
	{-2842.0f, 0.156f, 0},
	{-2892.0f, -0.032f, 1},
	{-2909.0f, 0.142f, 0},
	{-3011.0f, 0.181f, 0},	//200
	{-3028.0f, 0.019f, 0},
	{-3045.0f, -0.191f, 1},
	{-3080.0f, 0.246f, 0},
	{-3097.0f, -0.107f, 1},
	{-3132.0f, 0.041f, 0},
	{-3167.0f, -0.002f, 1},
	{-3202.0f, -0.237f, 1},
	{-3220.0f, 0.073f, 0},
	{-3291.0f, -0.165f, 1},
	{-3309.0f, -0.095f, 1},	//210
	{-3327.0f, -0.072f, 1},
	{-3345.0f, -0.098f, 1},
	{-3363.0f, -0.171f, 1},
	{-3436.0f, 0.054f, 0},
	{-3491.0f, -0.031f, 1},
	{-3528.0f, 0.006f, 0},
	{-3565.0f, -0.149f, 1},
	{-3584.0f, 0.201f, 0},
	{-3621.0f, -0.242f, 1},
	{-3640.0f, -0.036f, 1},	//220
	{-3659.0f, 0.123f, 0},
	{-3678.0f, 0.233f, 0},
	{-3754.0f, 0.195f, 0},
	{-3773.0f, 0.065f, 0},
	{-3792.0f, -0.112f, 1},
	{-3850.0f, 0.067f, 0},
	{-3908.0f, -0.186f, 1},
	{-3967.0f, 0.129f, 0},
	{-4006.0f, -0.234f, 1},
	{-4026.0f, 0.012f, 0},	//230
	{-4046.0f, 0.211f, 0},
	{-4206.0f, 0.070f, 0},
	{-4226.0f, -0.164f, 1},
	{-4267.0f, 0.225f, 0},
	{-4287.0f, -0.152f, 1},
	{-4328.0f, -0.052f, 1},
	{-4369.0f, -0.143f, 1},
	{-4390.0f, 0.239f, 0},
	{-4431.0f, -0.140f, 1},
	{-4452.0f, 0.099f, 0},	//240
	{-4641.0f, 0.084f, 0},
	{-4662.0f, -0.157f, 1},
	{-4705.0f, 0.216f, 0},
	{-4726.0f, -0.170f, 1},
	{-4769.0f, -0.085f, 1},
	{-4812.0f, -0.192f, 1},
	{-4834.0f, 0.182f, 0},
	{-4877.0f, -0.213f, 1},
	{-4899.0f, 0.017f, 0},
	{-4921.0f, 0.200f, 0},	//250
	{-5075.0f, 0.132f, 0},
	{-5097.0f, -0.069f, 1},
	{-5164.0f, 0.038f, 0},
	{-5209.0f, 0.203f, 0},
	{-5254.0f, 0.176f, 0},
	{-5299.0f, -0.043f, 1},
	{-5367.0f, -0.232f, 1},
	{-5390.0f, -0.058f, 1},
	{-5413.0f, 0.068f, 0},
	{-5436.0f, 0.147f, 0},	//260
	{-5459.0f, 0.177f, 0},
	{-5482.0f, 0.160f, 0},
	{-5505.0f, 0.094f, 0},
	{-5528.0f, -0.020f, 1},
	{-5551.0f, -0.181f, 1},
	{-5621.0f, 0.046f, 0},
	{-5691.0f, -0.159f, 1},
	{-5738.0f, -0.202f, 1},
	{-5762.0f, 0.205f, 0},
	{-5809.0f, -0.126f, 1},	//270
	{-5833.0f, 0.136f, 0},
	{-6073.0f, 0.120f, 0},
	{-6097.0f, -0.146f, 1},
	{-6146.0f, 0.179f, 0},
	{-6170.0f, -0.231f, 1},
	{-6219.0f, -0.194f, 1},
	{-6293.0f, 0.001f, 0},
	{-6367.0f, -0.235f, 1},
	{-6392.0f, -0.077f, 1},
	{-6417.0f, 0.033f, 0},	//280
	{-6442.0f, 0.096f, 0},
	{-6467.0f, 0.110f, 0},
	{-6492.0f, 0.076f, 0},
	{-6517.0f, -0.005f, 1},
	{-6542.0f, -0.135f, 1},
	{-6618.0f, 0.188f, 0},
	{-6643.0f, -0.133f, 1},
	{-6694.0f, 0.080f, 0},
	{-6745.0f, 0.100f, 0},
	{-6796.0f, -0.071f, 1},	//290
	{-6873.0f, -0.188f, 1},
	{-6899.0f, 0.011f, 0},
	{-6925.0f, 0.161f, 0},
	{-7055.0f, 0.193f, 0},
	{-7081.0f, 0.055f, 0},
	{-7107.0f,  -0.130f, 1},
	{-7186.0f, 0.025f, 0},
	{-7239.0f, 0.222f, 0},
	{-7292.0f, 0.227f, 0},
	{-7345.0f, 0.039f, 0},	//300
	{-7425.0f, -0.102f, 1},
	{-7452.0f, 0.089f, 0},
	{-7479.0f, 0.231f, 0},
	{-7614.0f, 0.223f, 0},
	{-7641.0f, 0.078f, 0},
	{-7668.0f, -0.116f, 1},
	{-7750.0f, 0.016f, 0},
	{-7805.0f, 0.196f, 0},
	{-7860.0f, 0.185f, 0},
	{-7915.0f, -0.018f, 1},	//310
	{-7998.0f, -0.183f, 1},
	{-8026.0f, -0.000f, 1},
	{-8054.0f, 0.134f, 0},
	{-8082.0f, 0.220f, 0},
	{-8138.0f, 0.249f, 0},
	{-8166.0f, 0.191f, 0},
	{-8194.0f, 0.086f, 0},
	{-8222.0f, -0.067f, 1},
	{-8307.0f, 0.184f, 0},
	{-8335.0f, -0.162f, 1},	//320
	{-8392.0f, 0.003f, 0},
	{-8449.0f, -0.024f, 1},
	{-8506.0f, -0.244f, 1},
	{-8535.0f, 0.074f, 0},
	{-8650.0f, -0.132f, 1},
	{-8679.0f, -0.054f, 1},
	{-8708.0f, -0.023f, 1},
	{-8737.0f, -0.041f, 1},
	{-8766.0f, -0.106f, 1},
	{-8795.0f, -0.220f, 1},	//330
	{-8883.0f, 0.151f, 0},
	{-8912.0f, -0.154f, 1},
	{-8971.0f, 0.091f, 0},
	{-9030.0f, 0.144f, 0},
	{-9089.0f, 0.004f, 0},
	{-9178.0f, -0.064f, 1},
	{-9208.0f, 0.150f, 0},
	{-9448.0f, 0.137f, 0},
	{-9478.0f, -0.081f, 1},
	{-9569.0f, -0.021f, 1},	//340
	{-9630.0f, 0.111f, 0},
	{-9691.0f, 0.052f, 0},
	{-9752.0f, -0.199f, 1},
	{-9783.0f, 0.104f, 0},
	{-9906.0f, -0.167f, 1},
	{-9937.0f, -0.104f, 1},
	{-9968.0f, -0.090f, 1},
	{-9999.0f, -0.123f, 1}	//348
};

/*
=================
CG_DrawOBs
Spike's OB Detector
=================
*/
#define OB_EPSILON 1e-3
void CG_DrawOBs(int x, int y, float alpha)
{
	vec3_t start, end;
	trace_t trace;
	float distz1, distz2, delta;
	int num_tbl, num_start, width, i;
	ob_info_t *obptr;
	char *str;
	vec4_t color = {1.0f, 1.0f, 1.0f};
	vec3_t mins = {-15.0f, -15.0f, -24.0f};
	vec3_t maxs = {15.0f, 15.0f, 16.0f};

	//check if you are standing on the ground
	if(cg.snap->ps.groundEntityNum != ENTITYNUM_NONE)
	{
		color[3] = alpha;
		VectorCopy(cg.refdef.vieworg, start);
		VectorMA(start, 131072, cg.refdef.viewaxis[0], end);

		//trace crosshair
		trap_CM_BoxTrace(&trace, start, end, vec3_origin, vec3_origin, 0, CONTENTS_SOLID | CONTENTS_BODY | CONTENTS_PLAYERCLIP);
//		CG_Trace(&trace, start, vec3_origin, vec3_origin, end, cg.snap->ps.clientNum, CONTENTS_SOLID | CONTENTS_BODY);

		if((trace.fraction != 1.0f) && (((trace.plane.normal[2] - 1.0f) > -1e-6) && ((trace.plane.normal[2] - 1.0f) < 1e-6)))
		{
			//hit a horizontal surface with normal facing upwards
			distz2 = trace.endpos[2];
		}

		VectorCopy(start, end);
		end[2] -= 80.0f;
		//trace directly below
		trap_CM_BoxTrace(&trace, start, end, mins, maxs, 0, CONTENTS_SOLID | CONTENTS_BODY | CONTENTS_PLAYERCLIP);
//		CG_Trace(&trace, start, mins, maxs, end, cg.snap->ps.clientNum, CONTENTS_SOLID | CONTENTS_BODY);

		if(trace.fraction != 1.0f)
		{
			//this is the surface the player is currently standing on
//			distz1 = trace.plane.dist + 0.125f;
//			Com_Printf("%.3f %.3f %.3f\n", trace.endpos[0], trace.endpos[1], trace.endpos[2]);
			distz1 = trace.endpos[2] - 24.0f;
		}

		delta = distz2 - distz1;		//negative values are below the player
//		num_tbl = sizeof(fallobs) / sizeof(fallobs[0]);

//Com_Printf("%.3f %.3f %.3f %.3f\n", distz1, distz2, delta, -((cg.snap->ps.origin[2] - 24.0f) - distz1));
		//check for fall ob's
		obptr = NULL;
		if(delta > -10.0f)
		{
			num_tbl = OBF_OPT_10;
			num_start = 0;
		}
		else if(delta > -100.0f)
		{
			num_tbl = OBF_OPT_100;
			num_start = OBF_OPT_10;
		}
		else if(delta > -500.0f)
		{
			num_tbl = OBF_OPT_500;
			num_start = OBF_OPT_100;
		}
		else if(delta > -1000.0f)
		{
			num_tbl = OBF_OPT_1000;
			num_start = OBF_OPT_500;
		}
		else if(delta > -5000.0f)
		{
			num_tbl = OBF_OPT_5000;
			num_start = OBF_OPT_1000;
		}
		else
		{
			num_tbl = OBF_OPT_END;
			num_start = OBF_OPT_5000;
		}

		for(i = num_start; i < num_tbl; i++)
		{
			if(((delta - fallobs[i].height) > -OB_EPSILON) && ((delta - fallobs[i].height) < OB_EPSILON))
			{
				obptr = &fallobs[i];
				break;
			}
		}

		if(obptr)
		{
			float offs;

			//found an ob height
			offs = -((cg.snap->ps.origin[2] - 24.0f) - distz1);
			if(!obptr->type && ((offs > -1e-6) && (offs < 1e-6)))
			{
				//fall ob
				str = va("G");
				width = CG_DrawStrlen(str) * TINYCHAR_WIDTH;
				CG_DrawStringExt(x - width, y + 2, str, color, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0, 0, 0);
			}
			else if((obptr->type == 1) && (offs <= obptr->offset))
			{
				//fall ob (caused by sticky)
				str = va("G");
				width = CG_DrawStrlen(str) * TINYCHAR_WIDTH;
				CG_DrawStringExt(x - width, y + 2, str, color, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0, 0, 0);
			}

			if((obptr->type == 1) && (offs > obptr->offset))
			{
				//potential sticky fall ob
				str = va("SG");
				width = CG_DrawStrlen(str) * TINYCHAR_WIDTH;
				CG_DrawStringExt(x - width + (TINYCHAR_WIDTH * 2), y + 2, str, color, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0, 0, 0);
			}
		}

		num_tbl = sizeof(jumpobs) / sizeof(jumpobs[0]);

		//check for jump ob's
		obptr = NULL;
		if(delta > -5.0f)
		{
			num_tbl = OBJ_OPT_5;
			num_start = 0;
		}
		else if(delta > -30.0f)
		{
			num_tbl = OBJ_OPT_30;
			num_start = OBJ_OPT_5;
		}
		else if(delta > -100.0f)
		{
			num_tbl = OBJ_OPT_100;
			num_start = OBJ_OPT_30;
		}
		else if(delta > -500.0f)
		{
			num_tbl = OBJ_OPT_500;
			num_start = OBJ_OPT_100;
		}
		else if(delta > -1005.0f)
		{
			num_tbl = OBJ_OPT_1005;
			num_start = OBJ_OPT_500;
		}
		else if(delta > -5000.0f)
		{
			num_tbl = OBJ_OPT_5000;
			num_start = OBJ_OPT_1005;
		}
		else
		{
			num_tbl = OBJ_OPT_END;
			num_start = OBJ_OPT_5000;
		}

		for(i = num_start; i < num_tbl; i++)
		{
			if(((delta - jumpobs[i].height) > -OB_EPSILON) && ((delta - jumpobs[i].height) < OB_EPSILON))
			{
				obptr = &jumpobs[i];
				break;
			}
		}

		if(obptr)
		{
			float offs;

			//found an ob height
			offs = -((cg.snap->ps.origin[2] - 24.0f) - distz1);
			if(!obptr->type && ((offs > -1e-6) && (offs < 1e-6)))
			{
				//jump ob
				str = va("J");
				width = CG_DrawStrlen(str) * TINYCHAR_WIDTH;
				CG_DrawStringExt(x - width + (TINYCHAR_WIDTH * 6), y + 2, str, color, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0, 0, 0);
			}
			else if((obptr->type == 1) && (offs <= obptr->offset))
			{
				//jump ob (caused by sticky)
				str = va("J");
				width = CG_DrawStrlen(str) * TINYCHAR_WIDTH;
				CG_DrawStringExt(x - width + (TINYCHAR_WIDTH * 6), y + 2, str, color, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0, 0, 0);
			}

			if((obptr->type == 1) && (offs > obptr->offset) && (obptr->height != 0.0f))
			{
				//potential sticky jump ob
				str = va("SJ");
				width = CG_DrawStrlen(str) * TINYCHAR_WIDTH;
				CG_DrawStringExt(x - width + (TINYCHAR_WIDTH * 8), y + 2, str, color, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0, 0, 0);
			}
		}
	}
}

/*
=================
CG_DrawWeaponSideBar
=================
*/
void CG_DrawWeaponSideBar( qboolean draw_sidebar, char *bgColor, char *fontColor, char *selectedBGColor, char *selectedFontColor ) {
	int		y;
	int		i;
	int		totalWeapons = 0, numWepsPerRow, remainingWeps = 0;
	vec4_t	vbgColor, vfontColor, vs_bgColor, vs_fontColor;

	/*if (!draw_sidebar && !superhud) {
		return;
	}*/

	numWepsPerRow = 0;
	for ( i = WP_NONE; i < WP_NUM_WEAPONS; i++ ) {
		if ( cg.snap->ps.stats[ STAT_WEAPONS ] & ( 1 << i ) ) {
			totalWeapons++;
		}
	}
	remainingWeps = totalWeapons;


	i = 0;
	//totalSpaceNeeded = ( (totalWeapons * 16) + (spacing * (totalWeapons - 1)) );
	y = ( (480 - (totalWeapons * 16) + (4 * (totalWeapons - 1))) * .3);

	for ( i = 0; i < 4; i++ ) {
		vbgColor[i] = g_color_table[ColorIndex(bgColor[0])][i];
		vfontColor[i] = g_color_table[ColorIndex(fontColor[0])][i];
		vs_bgColor[i] = g_color_table[ColorIndex(selectedBGColor[0])][i];
		vs_fontColor[i] = g_color_table[ColorIndex(selectedFontColor[0])][i];
	}
	i = 0;
	vbgColor[3] = 0.25;
	vs_bgColor[3] = 0.25;
	//If we have the weapon, draw the icon and a background box
	//then space it out for the next one
	//If we have no ammo for the gun, then draw the no ammo shader over the icon
	for ( i = WP_NONE; i < WP_NUM_WEAPONS; i++ ) {
		if ( cg.snap->ps.stats[ STAT_WEAPONS ] & ( 1 << i ) ) {
			char	ammo[24];
			if ( i != cg.weaponSelect ) {
				//Not the weapon selected or holding
				CG_FillRect(0, (float)y, 44, 16, vbgColor);
				CG_DrawPic( 2, (float)y, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, cg_weapons[i].weaponIcon );
				if ( !cg.snap->ps.ammo[ i ] ) {
					CG_DrawPic( 2, (float)y, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, cgs.media.noammoShader );
				}
				if ( cg.snap->ps.ammo[i] < 1 ) {
					Com_sprintf( ammo, 24, "0");
				} else {
					Com_sprintf(ammo, 24, "%i", cg.snap->ps.ammo[i]);
				}
				CG_DrawStringExt( 19, y + 3, ammo, vfontColor, qfalse, qtrue, 8, 10, 3, 0, 0);
				y += (16 + 4);
			} else {
				//The weapon selected or holding
				CG_FillRect(0, (float)y, 44, 16, vs_bgColor);
				CG_DrawPic( 2, (float)y, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, cg_weapons[i].weaponIcon );
				if ( !cg.snap->ps.ammo[ i ] ) {
					CG_DrawPic( 2, (float)y, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, cgs.media.noammoShader );
				}

				if ( cg.snap->ps.ammo[i] < 1 ) {//Gauntlet would print -1.. do this as a sanity check.
					Com_sprintf( ammo, 24, "0");
				} else if ( cg.snap->ps.ammo[i] > 999 ) {//Instagib would print 169, no need for it anyway.
					Com_sprintf(ammo, 24, "999");
				} else {
					Com_sprintf(ammo, 24, "%i", cg.snap->ps.ammo[i]);
				}
				CG_DrawStringExt( 19, y + 3, ammo, vs_fontColor, qfalse, qtrue, 8, 10, 3, 0, 0);

				y += (16 + 4);

			}
		}
	}
}
/*
================
CG_DrawKeyPress
================
*/
void CG_DrawKeyPress( qboolean draw_keys, int x, int y, char *keyColor, char *fontColor, int size ) {
	//int		x, y;
	int			i;
	vec4_t		keys, font;

	/*if ( !draw_keys ) {
		return;
	}*/

	for ( i = 0; i < 4; i++ ) {
		keys[i] = g_color_table[ColorIndex(keyColor[0])][i];
		font[i] = g_color_table[ColorIndex(fontColor[0])][i];

	}

	if ( cg.snap->ps.pm_flags & PMF_FORWARD_KEY_PRESSED ) {
		//Forward
		CG_FillRect((float)(x - ( size / 4 )), (float)(y - ( size / 4 )), (size + (size / 2 )), (size + (size / 2 )), keys);
		CG_DrawStringExt( x, y, "F", font, qfalse, qfalse, size, size, (size + (size / 2 )), 0, 0 );
		//CG_Printf("DBG: ViewKeys: Drawing F\n");
	}
	if ( cg.snap->ps.pm_flags & PMF_BACKWARD_KEY_PRESSED ) {
		//Backward
		CG_FillRect((float)(x - ( size / 4 )), (float)(y + (size + size)), (size + (size / 2 )), (size + (size / 2 )), keys);
		CG_DrawStringExt( x, y + ((size + size) + ( size / 4 )), "B", font, qfalse, qfalse, size, size, (size + (size / 2 )), 0, 0 );
		//CG_Printf("DBG: ViewKeys: Drawing B\n");
	}
		
	if ( cg.snap->ps.pm_flags & PMF_MOVE_RIGHT_KEY_PRESSED ) {
		//Right
		CG_FillRect((float)(x + (size + size)), (float)(y + (size + size)), (size + (size / 2 )), (size + (size / 2 )), keys);
		CG_DrawStringExt( x + ((size + size) + ( size / 4 )), y + ((size + size) + ( size / 4 )), "R", font, qfalse, qfalse, size, size, (size + (size / 2 )), 0, 0 );
		//CG_Printf("DBG: ViewKeys: Drawing R\n");
	}
		
	if ( cg.snap->ps.eFlags & EF_MOVE_LEFT_KEY_PRESSED ) {
		//Left
		CG_FillRect((float)(x - ((size + size) + ( size / 4 ))), (float)(y + (size + size) ), (size + (size / 2 )), (size + (size / 2 )), keys);
		CG_DrawStringExt( x - ((size + size) + ( size / 4 )), y + ((size + size) + ( size / 4 )), "L", font, qfalse, qfalse, size, size, (size + (size / 2 )), 0, 0 );
		//CG_Printf("DBG: ViewKeys: Drawing L\n");
	}

	if ( cg.predictedPlayerState.viewheight == CROUCH_VIEWHEIGHT ) {
		//Crouch
		CG_FillRect((float)(x - ((size + (size / 2 )) * 5)), (float)(y + ((size * 4) - ( size / 4))), ((size + (size / 2 )) * 4), (size + (size / 2 )), keys);
		CG_DrawStringExt( x - ((size + (size / 2 )) * 5), y + (size * 4), "Crouch", font, qfalse, qfalse, size, size, (size + (size / 2 )), 0, 0 );
	}

	if ( cg.snap->ps.movementDir > 7 ) { //This method is more reliable
		//Jump
		CG_FillRect((float)(x - ((size + size) + ( size / 4 ))), (float)(y + ((size * 4) - ( size / 4))), ((size + (size / 2 )) * 4), (size + (size / 2 )), keys);
		CG_DrawStringExt( x - (size + (size / 4)), y + (size * 4), "Jump", font, qfalse, qfalse, size, size, (size + (size / 2 )), 0, 0 );
	}
}

/*
=================
CG_Draw2D
=================
*/
static void CG_Draw2D( void ) {
#ifdef MISSIONPACK
	if (cgs.orderPending && cg.time > cgs.orderTime) {
		CG_CheckOrderPending();
	}
#endif
	// if we are taking a levelshot for the menu, don't draw anything
	if ( cg.levelShot ) {
		return;
	}

	if ( cg_draw2D.integer == -1 ) {
		CG_DrawCrosshair();
		return;
	}

	if ( cg_draw2D.integer == 0 ) {
		return;
	}

	if ( cg.snap->ps.pm_type == PM_INTERMISSION ) {
		CG_DrawIntermission();
		DrawMOTDBox();
		return;
	}

/*
	if (cg.cameraMode) {
		return;
	}
*/
	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR ) {
		CG_DrawSpectator();
		//CG_DrawCrosshair(); -- Waste, it kicks back out if team is spectator
		CG_DrawCrosshairNames();
	} else {
#ifdef MISSIONPACK
			if ( cg_drawStatus.integer ) {
				Menu_PaintAll();
				CG_DrawTimedMenus();
			}
#else
			CG_DrawStatusBar();
#endif

			{ //Spike's Speedometer
				qboolean draw_speed, draw_maxspeed;
				int x, y;
				float alpha;
				char *sptr;
				//char sptr[MAX_STRING_TOKENS];
				char token[24];

				sptr = ch_Speedometer.string;
				//Com_sprintf( sptr, MAX_STRING_TOKENS, cg_Speedometer.string);
				//Q_CleanStrOfQuotes( sptr );
				CG_ExtractToken(&sptr, token);
				draw_speed = atoi(token);
				CG_ExtractToken(&sptr, token);
				draw_maxspeed = atoi(token);
				if ( draw_speed || draw_maxspeed ) {
					//Don't waste time if we're not gonna draw
					CG_ExtractToken(&sptr, token);
					x = atoi(token);
					CG_ExtractToken(&sptr, token);
					y = atoi(token);
					CG_ExtractToken(&sptr, token);
					alpha = atof(token);

					CG_DrawSpeedometer(draw_speed, draw_maxspeed, x, y, alpha);
				}
			}

			if(cg_pmove_fixed.integer)
			{ //Spike's OB Detector
				qboolean draw;
				int x, y;
				float alpha;
				char *sptr;
				char token[24];

				sptr = ch_OBDetector.string;
				CG_ExtractToken(&sptr, token);
				draw = atoi(token);
				if(draw)
				{
					CG_ExtractToken(&sptr, token);
					x = atoi(token);
					CG_ExtractToken(&sptr, token);
					y = atoi(token);
					CG_ExtractToken(&sptr, token);
					alpha = atof(token);

					CG_DrawOBs(x, y, alpha);
				}
			}

			{//Evo's WeaponSideBar... Kinda like Spike's stuff..
			//I just got lucky I need 5 values and wanted to do it like his anyway.
				//{Display Background_color Width Hieght Spacing}
				qboolean draw_sidebar;
			//	int		width, height, spacing;
				//vec4_t		color;
				char	bgColor[24];
				char	fontColor[24];
				char	s_bgColor[24];
				char	s_fontColor[24];
				char	*sptr;
				char	token[24];
				
				//The colors should be figured out here and sent as vec4's
				sptr = ch_weaponSideBar.string;

				CG_ExtractToken(&sptr, token);
				draw_sidebar = atoi(token);

				if ( draw_sidebar ) {
					//Don't waste time if we're not gonna draw
					CG_ExtractToken(&sptr, token);
					//color = atoi(token);
					Com_sprintf(bgColor, sizeof(bgColor), token);

					CG_ExtractToken(&sptr, token);
					//width = atoi(token);
					Com_sprintf(fontColor, sizeof(fontColor), token);

					CG_ExtractToken(&sptr, token);
					//height = atoi(token);
					Com_sprintf(s_bgColor, sizeof(s_bgColor), token);

					CG_ExtractToken(&sptr, token);
					//spacing = atoi(token);
					Com_sprintf(s_fontColor, sizeof(s_fontColor), token);

					CG_DrawWeaponSideBar(draw_sidebar, bgColor, fontColor, s_bgColor, s_fontColor);
				}
			}

			{//Evo's viewKeyPress... Kinda like Spike's stuff..
			//I just got lucky I need 5 values and wanted to do it like his anyway.
				//{Display x_position y_position, keyColor, fontColor}
				qboolean draw_keys;
				int		x, y, size;
				char	keyColor[24];
				char	fontColor[24];
				char	*sptr;
				char	token[24];
				
				//The colors should be figured out here and sent as vec4's
				sptr = ch_viewKeyPress.string;

				CG_ExtractToken(&sptr, token);
				draw_keys = atoi(token);

				if ( draw_keys ) {
					//Don't waste time if we're not gonna draw
					CG_ExtractToken(&sptr, token);
					x = atoi(token);

					CG_ExtractToken(&sptr, token);
					y = atoi(token);

					CG_ExtractToken(&sptr, token);
					Com_sprintf(keyColor, sizeof(keyColor), token);

					CG_ExtractToken(&sptr, token);
					Com_sprintf(fontColor, sizeof(fontColor), token);

					CG_ExtractToken(&sptr, token);
					size = atoi(token);

					CG_DrawKeyPress(draw_keys, x, y, keyColor, fontColor, size);
				}
			}


		// don't draw any status if dead or the scoreboard is being explicitly shown
			if ( !cg.showScores && cg.snap->ps.stats[STAT_HEALTH] > 0 ) {
				//Don't draw if the scoreboard is showing, we want to see if when we're dead.
				//if ( !cg.showScores ) {

/*
#ifdef MISSIONPACK
				if ( cg_drawStatus.integer ) {
					Menu_PaintAll();
					CG_DrawTimedMenus();
				}
#else
				CG_DrawStatusBar();
#endif
*/      
				CG_DrawAmmoWarning();

#ifdef MISSIONPACK
				CG_DrawProxWarning();
#endif      
				CG_DrawCrosshair();
				CG_DrawCrosshairNames();
				CG_DrawWeaponSelect();

#ifndef MISSIONPACK
				CG_DrawHoldableItem();
#else
				//CG_DrawPersistantPowerup();
#endif
				CG_DrawReward();

				if ( !CG_DrawFollow() ) {
					//CG_DrawWarmup();
				}
		}

			CG_DrawWarmup();
    
		if ( cgs.gametype >= GT_TEAM ) {
#ifndef MISSIONPACK
			CG_DrawTeamInfo();
#endif
		}
	}

	CG_DrawVote();
	CG_DrawTeamVote();

	CG_DrawLagometer();

#ifdef MISSIONPACK
	if (!cg_paused.integer) {
		CG_DrawUpperRight();
	}
#else
	CG_DrawUpperRight();
#endif

#ifndef MISSIONPACK
	CG_DrawLowerRight();
	CG_DrawLowerLeft();
#endif

	/*if ( !CG_DrawFollow() ) {
		CG_DrawWarmup();
	}*/

	DrawMOTDBox();

	// don't draw center string if scoreboard is up
	//Score_Weapon();
	cg.scoreBoardShowing = CG_DrawScoreboard();
	//if ( !cg.scoreBoardShowing) {
		CG_DrawCenterString();
	//}
}


static void CG_DrawTourneyScoreboard() {
#ifdef MISSIONPACK
#else
	CG_DrawOldTourneyScoreboard();
#endif
}

/*
=====================
CG_Alarm
=====================
*/
void CG_Alarm ( void ) {
	qtime_t	qtm;
	

	trap_RealTime(&qtm);

	if ( cg_drawClock.integer == 2 || cg.time_type == 2) {
		if ( qtm.tm_hour == cg.alarmTime_hour && qtm.tm_min == cg.alarmTime_minute ) {
			cg.alarmSet = qfalse;
			trap_S_StartSound (NULL, cg.clientNum, CHAN_AUTO, trap_S_RegisterSound( "sound/world/buzzer.wav", qtrue ) );
			CG_CenterPrint("^1That is your alarm going off!", SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH);
			//CG_Printf("Alarm!\n");
			return;
		}
	} else {
		if ( qtm.tm_hour > 12 ) {
			if ( qtm.tm_hour - 12 == cg.alarmTime_hour && qtm.tm_min == cg.alarmTime_minute ) {
				cg.alarmSet = qfalse;
				trap_S_StartSound (NULL, cg.clientNum, CHAN_AUTO, trap_S_RegisterSound( "sound/world/buzzer.wav", qtrue ) );
				CG_CenterPrint("^1That is your alarm going off!", SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH);
				//CG_Printf("Alarm!\n");
				return;
			}
		} else {
			if ( qtm.tm_hour == cg.alarmTime_hour && qtm.tm_min == cg.alarmTime_minute ) {
				//Probably could have this in the 24 hour clock section too..
				cg.alarmSet = qfalse;
				trap_S_StartSound (NULL, cg.clientNum, CHAN_AUTO, trap_S_RegisterSound( "sound/world/buzzer.wav", qtrue ) );
				CG_CenterPrint("^1That is your alarm going off!", SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH);
				//CG_Printf("Alarm!\n");
				return;
			}
		}
	}
}

/*
=====================
CG_DrawActive

Perform all drawing needed to completely fill the screen
=====================
*/
////XXX############## CHANGE START
static qboolean firsttime = qtrue;
////XXX############## CHANGE END

void CG_DrawActive( stereoFrame_t stereoView ) {
	float		separation;
	vec3_t		baseOrg;

////XXX############## CHANGE START
	if(firsttime)
	{
		//prime the fade timer
		CG_GetFadeTime();
		firsttime = qfalse;
	}
////XXX############## CHANGE END

	// optionally draw the info screen instead
	if ( !cg.snap ) {
		CG_DrawInformation();
		return;
	}

	// optionally draw the tournement scoreboard instead
	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR &&
		( cg.snap->ps.pm_flags & PMF_SCOREBOARD ) ) {
		CG_DrawTourneyScoreboard();
		return;
	}

	switch ( stereoView ) {
	case STEREO_CENTER:
		separation = 0;
		break;
	case STEREO_LEFT:
		separation = -cg_stereoSeparation.value / 2;
		break;
	case STEREO_RIGHT:
		separation = cg_stereoSeparation.value / 2;
		break;
	default:
		separation = 0;
		CG_Error( "CG_DrawActive: Undefined stereoView" );
	}


	// clear around the rendered view if sized down
	CG_TileClear();

	// offset vieworg appropriately if we're doing stereo separation
	VectorCopy( cg.refdef.vieworg, baseOrg );
	if ( separation != 0 ) {
		VectorMA( cg.refdef.vieworg, -separation, cg.refdef.viewaxis[1], cg.refdef.vieworg );
	}

	// draw 3D view
	trap_R_RenderScene( &cg.refdef );

	// restore original viewpoint if running stereo
	if ( separation != 0 ) {
		VectorCopy( baseOrg, cg.refdef.vieworg );
	}

	// draw status bar and other floating elements
	//Superhud - Begin
	if ( hud_count && strlen(ch_file.string) ) {
		CG_DrawHud2D();
	} else {
 		CG_Draw2D();
	}
	//Superhud - End

}



