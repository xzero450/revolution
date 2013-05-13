// Copyright (C) 1999-2000 Id Software, Inc.
//
// cg_drawtools.c -- helper functions called by cg_draw, cg_scoreboard, cg_info, etc
#include "cg_local.h"

////XXX############## CHANGE START
//for text fading
int fadeTime = 0;
static int baseFadeTime = -1;

int CG_GetFadeTime(void)
{
	if(baseFadeTime == -1)
		baseFadeTime = cg.time; //trap_Milliseconds();

	fadeTime = cg.time - baseFadeTime; //trap_Milliseconds() - baseFadeTime;

	return fadeTime;
}
////XXX############## CHANGE END

/*
================
CG_AdjustFrom640

Adjusted for resolution and screen aspect ratio
================
*/
void CG_AdjustFrom640( float *x, float *y, float *w, float *h ) {
#if 0
	// adjust for wide screens
	if ( cgs.glconfig.vidWidth * 480 > cgs.glconfig.vidHeight * 640 ) {
		*x += 0.5 * ( cgs.glconfig.vidWidth - ( cgs.glconfig.vidHeight * 640 / 480 ) );
	}
#endif
	// scale for screen sizes
	*x *= cgs.screenXScale;
	*y *= cgs.screenYScale;
	*w *= cgs.screenXScale;
	*h *= cgs.screenYScale;
}

/*
================
CG_FillRect

Coordinates are 640*480 virtual values
=================
*/
void CG_FillRect( float x, float y, float width, float height, const float *color ) {
	trap_R_SetColor( color );

	CG_AdjustFrom640( &x, &y, &width, &height );
	trap_R_DrawStretchPic( x, y, width, height, 0, 0, 0, 0, cgs.media.whiteShader );

	trap_R_SetColor( NULL );
}

/*
================
CG_DrawSides

Coords are virtual 640x480
================
*/
void CG_DrawSides(float x, float y, float w, float h, float size) {
	CG_AdjustFrom640( &x, &y, &w, &h );
	size *= cgs.screenXScale;
	trap_R_DrawStretchPic( x, y, size, h, 0, 0, 0, 0, cgs.media.whiteShader );
	trap_R_DrawStretchPic( x + w - size, y, size, h, 0, 0, 0, 0, cgs.media.whiteShader );
}

void CG_DrawTopBottom(float x, float y, float w, float h, float size) {
	CG_AdjustFrom640( &x, &y, &w, &h );
	size *= cgs.screenYScale;
	trap_R_DrawStretchPic( x, y, w, size, 0, 0, 0, 0, cgs.media.whiteShader );
	trap_R_DrawStretchPic( x, y + h - size, w, size, 0, 0, 0, 0, cgs.media.whiteShader );
}
/*
================
UI_DrawRect

Coordinates are 640*480 virtual values
=================
*/
void CG_DrawRect( float x, float y, float width, float height, float size, const float *color ) {
	trap_R_SetColor( color );

  CG_DrawTopBottom(x, y, width, height, size);
  CG_DrawSides(x, y, width, height, size);

	trap_R_SetColor( NULL );
}



/*
================
CG_DrawPic

Coordinates are 640*480 virtual values
=================
*/
void CG_DrawPic( float x, float y, float width, float height, qhandle_t hShader ) {
	CG_AdjustFrom640( &x, &y, &width, &height );
	trap_R_DrawStretchPic( x, y, width, height, 0, 0, 1, 1, hShader );
}

//Superhud - Begin
/*
===============
CG_DrawChar

Coordinates and size in 640*480 virtual screen size
===============
*/
void CG_DrawChar( int x, int y, int width, int height, int ch, int altFont, int superhud ) {
	int row, col;
	float frow, fcol;
	float size;
	float	ax, ay, aw, ah;

	ch &= 255;

	if ( ch == ' ' ) {
		return;
	}

	ax = x;
	ay = y;
	aw = width;
	ah = height;
	CG_AdjustFrom640( &ax, &ay, &aw, &ah );

	row = ch>>4;
	col = ch&15;

	frow = row*0.0625;
	fcol = col*0.0625;
	size = 0.0625;

	if ( superhud && ( !Q_stricmp(hud[superhud].font, "threewave") || !Q_stricmp(hud[superhud].font, "cpma")) ) {
		if ( !Q_stricmp(hud[superhud].font, "threewave") ) {
			trap_R_DrawStretchPic( ax, ay, aw, ah, fcol, frow, fcol + size, frow + size, cgs.media.charsetThreewave );
		} else {
			trap_R_DrawStretchPic( ax, ay, aw, ah, fcol, frow, fcol + size, frow + size, cgs.media.charsetCPMA );
		}
	} else {
		if ( !altFont ) {
			trap_R_DrawStretchPic( ax, ay, aw, ah, fcol, frow, fcol + size, frow + size, cgs.media.charsetShader );
		} else if ( altFont == FONT_BLOCK ) {
			trap_R_DrawStretchPic( ax, ay, aw, ah, fcol, frow, fcol + size, frow + size, cgs.media.charsetPropC );
		} else if ( altFont == FONT_THREEWAVE ) {
			trap_R_DrawStretchPic( ax, ay, aw, ah, fcol, frow, fcol + size, frow + size, cgs.media.charsetThreewave );
		} else if ( altFont == FONT_CPMA ) {
			trap_R_DrawStretchPic( ax, ay, aw, ah, fcol, frow, fcol + size, frow + size, cgs.media.charsetCPMA );
		}
	}
}

/*
==============
CG_FigureHUDColor
==============
*/
float *CG_FigureHUDColor(int superhud)
{
	//FIXME: ???
	if(cgs.gametype >= GT_TEAM && (hud[superhud].TEColor == TEAM_COLORS || hud[superhud].TEColor == ENEMY_COLORS))
	{
		if ( cgs.clientinfo[cg.clientNum].team == TEAM_RED && hud[superhud].TEColor == 1 ||
			 cgs.clientinfo[cg.clientNum].team != TEAM_RED && hud[superhud].TEColor == 2 ) {
			return colorRed;
		} else {
			return colorBlue;
		}
	} else if ( hud[superhud].TEColor > 0 || hud[superhud].TEColor == 0 && hud[superhud].bgcolor ) {//It's a byte, has to be > 0 comparison
		//This should be enforced by the parser when T/E are set.
		return hud[superhud].bgcolor;
	} else {
		return hud[superhud].color;
	}
/*	//This may not be setup incorrectly, all FillRect's should be able to use this also
	if ( cgs.gametype >= GT_TEAM && (hud[superhud].TEColor == 1 || hud[superhud].TEColor == 2 ) ) {
		if ( cgs.clientinfo[cg.clientNum].team == TEAM_RED && hud[superhud].TEColor == 1 ||
			 cgs.clientinfo[cg.clientNum].team != TEAM_RED && hud[superhud].TEColor == 2 ) {
			return colorRed;
		} else {
			return colorBlue;
		}
	} else if ( hud[superhud].TEColor > 0 || hud[superhud].TEColor == 0 && hud[superhud].bgcolor ) {//It's a byte, has to be > 0 comparison
		//This should be enforced by the parser when T/E are set.
		return hud[superhud].bgcolor;
	} else {
		return hud[superhud].color;
	}
*/
}

/*
==================
CG_DrawStringExt

Draws a multi-colored string with a drop shadow, optionally forcing
to a fixed color.

Coordinates are at 640 by 480 virtual resolution
==================
*/
/********************************
#################################
Note to M^onk^K

Virtually every string rendering function calls this.
They will all need to be updated for the extra param
Unless you create a new rendering route.
#################################
********************************/

////XXX############## CHANGE START
#define FADE_RATE 1300	//milliseconds
////XXX############## CHANGE END

void CG_DrawStringExt( int x, int y, const char *string, const float *setColor, 
		qboolean forceColor, qboolean shadow, int charWidth, int charHeight, int maxChars, int altFont, int superhud ) {
	vec4_t		color;
	const char	*s;
	int			xx;
	int			cnt;
	int			cnt_colors = 0;
	vec4_t		fadeColors[5];
	int			nameLength[2], nameCnt = 0;
	int			staticStart = 0;
	qboolean	isStaticFade = qfalse;
	int			num_state;
	int			state;	//0 = fade forward; 1 = stay color2; 2 = fade backwards; 3 = stay color1
	int			rem;
	float		scale;

	memset( fadeColors, 0, sizeof(fadeColors));

	if (maxChars <= 0)
		maxChars = 32767; // do them all!

	if ( superhud == -1 ) {
			//align center
			int w;
			w = CG_DrawStrlen( string ) * charWidth;
			x = (x + (altFont * .5)) - (w * .5);
			superhud = 0;
			altFont = 0;
	} else if ( superhud && 
		!( hud[superhud].element == WeaponList ||
		   hud[superhud].element == Team1 || 
		   hud[superhud].element == Team2 ||
		   hud[superhud].element == Team3 ||
		   hud[superhud].element == Team4 ||
		   hud[superhud].element == Team5 ||
		   hud[superhud].element == Team6 ||
		   hud[superhud].element == Team7 ||
		   hud[superhud].element == Team8
		) ) {//Ignore the settings passed through
		int w;

		w = CG_DrawStrlen( string ) * hud[superhud].fontsize[0];
		y = hud[superhud].rect[1];
		setColor = hud[superhud].color;
		forceColor = qfalse;
		charWidth = hud[superhud].fontsize[0];
		charHeight = hud[superhud].fontsize[1];
		if ( hud[superhud].textstyle == 1 ) {
			shadow = qtrue;
		} else {
			shadow = qfalse;
		}

		//CG_Printf("%s %i %i %i %i\n", hud[superhud].name, hud[superhud].rect[0],hud[superhud].rect[1],hud[superhud].rect[2],hud[superhud].rect[3]);
		if ( hud[superhud].element == RankMessage ) {
			if ( hud[superhud].fade ) {
				setColor = CG_FadeFromColorTo(hud[superhud].color, hud[superhud].fade, cg.rankMessageTime, hud[superhud].time);
			}
		} else if ( hud[superhud].element == FragMessage ) {
			if ( hud[superhud].fade ) {
				setColor = CG_FadeFromColorTo(hud[superhud].color, hud[superhud].fade, cg.fragMessageTime, hud[superhud].time);
			}
		} else if ( hud[superhud].element == TargetName ) {
			if ( hud[superhud].fade ) {
				setColor = CG_FadeFromColorTo(hud[superhud].color, hud[superhud].fade, cg.crosshairClientTime, hud[superhud].time);
			}
		} else if ( hud[superhud].element == AttackerName ) {
			if ( hud[superhud].fade ) {
				setColor = CG_FadeFromColorTo(hud[superhud].color, hud[superhud].fade, cg.attackerTime, hud[superhud].time);
			}
		}

		if ( hud[superhud].textalign == 0 ) {
			//align right
			x = (hud[superhud].rect[0] + hud[superhud].rect[2]) - w;
		} else if ( hud[superhud].textalign == 1 ) {
			//align center
			x = hud[superhud].rect[0] + (hud[superhud].rect[2] * .5) - (w * .5);
		} else {
			//align left
			x = hud[superhud].rect[0];
		}
	}

	// draw the drop shadow
	nameLength[0] = nameLength[1] = 0;
	if (shadow/* || cg_fontFade.integer */) {
		color[0] = color[1] = color[2] = 0;
		color[3] = setColor[3];
		trap_R_SetColor( color );
		s = string;
		xx = x;
		cnt = 0;
		while ( *s && cnt < maxChars) {
			if ( Q_IsColorString( s ) ) {
				s += 2;
				if((*s == ':') && Q_IsColorString( s+1 ))
				{
					s += 3;
				} 
				//else if((*s  == ',') && Q_IsColorString( s+1 ) && !isStaticFade )
				else if ( Q_IsColorString(s) && !isStaticFade )
				{
					//This means we'll be fading across the name.
					isStaticFade = qtrue;
					s += 2;
					//if((*s  == ',') && Q_IsColorString( s+1 ) )
					if ( Q_IsColorString(s) )
					{
						//This means we'll be fading across the name.
						s += 2;
					}
				}
				continue;
			}
			if ( isStaticFade ) {
				if (*s == ' ' || !*s) {
					isStaticFade = qfalse;
					//nameLength -= 2;
				} else {
					nameLength[0]++;
				}
			}

			if ( !(*s) ) { //FIXME: Hack
				break;
			}
			if ( superhud && (hud[superhud].offset[0] || hud[superhud].offset[1]) ) {
				CG_DrawChar( xx + hud[superhud].offset[0], y + hud[superhud].offset[1], charWidth, charHeight, *s, altFont, superhud );
			//} else {
			} else if ( shadow ) {
				CG_DrawChar( xx + ch_shadowOffset.integer, y + ch_shadowOffset.integer, charWidth, charHeight, *s, altFont, superhud );
			}
			cnt++;
			xx += charWidth;
			s++;
		}
	}

	//CG_Printf("%i\n", nameLength);
	nameLength[0]--;
	// draw the colored text
	s = string;
	xx = x;
	cnt = 0;
////XXX############## CHANGE START
	memcpy(fadeColors[0], setColor, sizeof(vec4_t));
//	trap_R_SetColor( setColor );
	//Evo's fade hack hacked even further by spike
	while(*s && (cnt < maxChars))
	{
		if ( Q_IsColorString( s )|| (*s == '^' && *s+1 != '^') )
		{
			//change color
			cnt_colors = 0;
			memcpy(fadeColors[cnt_colors], g_color_table[ColorIndex(*(s + 1))], sizeof(vec4_t));
			cnt_colors++;
			s += 2;
			
			if ( (*s == ':') && ( Q_IsColorString( s+1 ) || (*(s) == '^' && *(s + 1) != '^') ) )
			{
				//this means fade to the next color specified (if specified)
				memcpy(fadeColors[cnt_colors], g_color_table[ColorIndex(*(s + 2))], sizeof(vec4_t));
				cnt_colors++;
				s += 3;
				continue;
			}
			else if ( ( Q_IsColorString(s) || (*(s) == '^' && *(s + 1) != '^') ) && cnt_colors < 3 )
			{
				//This means we'll be fading across the name.
				if (nameLength[0] > 2) {
					isStaticFade = qtrue;
					memcpy(fadeColors[cnt_colors], g_color_table[ColorIndex(*(s + 1))], sizeof(vec4_t));
					//
					fadeColors[3][0] = (fadeColors[0][0] - fadeColors[1][0]) / nameLength[0];
					fadeColors[3][1] = (fadeColors[0][1] - fadeColors[1][1]) / nameLength[0];
					fadeColors[3][2] = (fadeColors[0][2] - fadeColors[1][2]) / nameLength[0];
					//
					cnt_colors++;
					s += 2;
					if ( ( Q_IsColorString(s) || (*(s) == '^' && *(s + 1) != '^') ) && cnt_colors < 3 )
					{
						//This means we'll be fading across the name.
						if (cnt_colors == 2) {
							isStaticFade = qtrue;
							memcpy(fadeColors[cnt_colors], g_color_table[ColorIndex(*(s + 1))], sizeof(vec4_t));
							//
							//CG_Printf("%i %i -- ", nameLength[0], nameLength[1]);
							nameLength[1] = (nameLength[0] % 2) + (nameLength[0] * .5);
							nameLength[0] -= nameLength[1];
							//CG_Printf("%i %i\n", nameLength[0], nameLength[1]);
							fadeColors[3][0] = (fadeColors[0][0] - fadeColors[1][0]) / nameLength[1];
							fadeColors[3][1] = (fadeColors[0][1] - fadeColors[1][1]) / nameLength[1];
							fadeColors[3][2] = (fadeColors[0][2] - fadeColors[1][2]) / nameLength[1];
							fadeColors[4][0] = (fadeColors[1][0] - fadeColors[2][0]) / nameLength[0];
							fadeColors[4][1] = (fadeColors[1][1] - fadeColors[2][1]) / nameLength[0];
							fadeColors[4][2] = (fadeColors[1][2] - fadeColors[2][2]) / nameLength[0];
							//
							cnt_colors++;
							s += 2;
						}
					}
					continue;
				}
			}
			//else if(*s == '\0')
				//break;
			else
				continue;
		}

		if(!forceColor)
		{
			if( (cnt_colors > 1) )
			{
				//CG_Printf("cnt_colors: %i\n", cnt_colors);
				if ( !isStaticFade ) {
					//fade
					fadeTime = CG_GetFadeTime();
					num_state = fadeTime / FADE_RATE;
					state = num_state % 4;

					switch(state)
					{
						case 0:
							//fade forward
							rem = fadeTime % FADE_RATE;
							scale = (fadeColors[1][0] - fadeColors[0][0]) / (float)(FADE_RATE);
							color[0] = rem * scale + fadeColors[0][0];
							scale = (fadeColors[1][1] - fadeColors[0][1]) / (float)(FADE_RATE);
							color[1] = rem * scale + fadeColors[0][1];
							scale = (fadeColors[1][2] - fadeColors[0][2]) / (float)(FADE_RATE);
							color[2] = rem * scale + fadeColors[0][2];
							scale = (fadeColors[1][3] - fadeColors[0][3]) / (float)(FADE_RATE);
							color[3] = rem * scale + fadeColors[0][3];

							trap_R_SetColor(color);
							break;

						case 1:
							//stay at color2
							trap_R_SetColor(fadeColors[1]);
							break;

						case 2:
							//fade backwards
							rem = fadeTime % FADE_RATE;
							scale = (fadeColors[0][0] - fadeColors[1][0]) / (float)(FADE_RATE);
							color[0] = rem * scale + fadeColors[1][0];
							scale = (fadeColors[0][1] - fadeColors[1][1]) / (float)(FADE_RATE);
							color[1] = rem * scale + fadeColors[1][1];
							scale = (fadeColors[0][2] - fadeColors[1][2]) / (float)(FADE_RATE);
							color[2] = rem * scale + fadeColors[1][2];
							scale = (fadeColors[0][3] - fadeColors[1][3]) / (float)(FADE_RATE);
							color[3] = rem * scale + fadeColors[1][3];

							trap_R_SetColor(color);
							break;

						case 3:
							//stay at color1
							trap_R_SetColor(fadeColors[0]);
							break;
					}
				} else {
					//CG_Printf("DBG: %i > %i\n", nameCnt, nameLength[1]);
					if ( nameCnt >= nameLength[1] && nameLength[1] != 0) {
						trap_R_SetColor(fadeColors[0]);
							fadeColors[0][0] -= fadeColors[4][0];
							fadeColors[0][1] -= fadeColors[4][1];
							fadeColors[0][2] -= fadeColors[4][2];
							//CG_Printf("4:%2.2f %2.2f %2.2f %2.2f %2.2f %2.2f\n", 
								//fadeColors[0][0], fadeColors[0][1], fadeColors[0][2],
								//fadeColors[4][0], fadeColors[4][1], fadeColors[4][2]);
					} else {
						trap_R_SetColor(fadeColors[0]);
							fadeColors[0][0] -= fadeColors[3][0];
							fadeColors[0][1] -= fadeColors[3][1];
							fadeColors[0][2] -= fadeColors[3][2];
							//CG_Printf("3:%2.2f %2.2f %2.2f %2.2f %2.2f %2.2f\n", 
								//fadeColors[0][0], fadeColors[0][1], fadeColors[0][2],
								//fadeColors[3][0], fadeColors[3][1], fadeColors[3][2]);
					}
					nameCnt++;
				}
			}
			else
			{
				//solid color
				trap_R_SetColor(fadeColors[0]);
			}
		}
		else
		{
			//force color
			trap_R_SetColor(setColor);
		}

		if ( (*s) ) { //FIXME: Hack
			CG_DrawChar(xx, y, charWidth, charHeight, *s, altFont, superhud);
			xx += charWidth;
		}
		else
			break;

		cnt++;
		s++;
	}

#if 0
	//Evo: Fade Hack
	if ( cg_fontFade.integer ) {
		nameLength = strlen(Q_CleanStr((char *)s));

		while ( Q_IsColorString( s ) ) {
			CG_Printf("cg_fontFade %s %i %i\n", s, cnt_colors, nameLength);
			memcpy( fadeColors[cnt_colors], g_color_table[ColorIndex(*(s+1))], sizeof( fadeColors ) );
			cnt_colors++;
			s += 2;
			if ( *s == '-' ) {
				s++;
			} else {
				CG_Printf("%s\n", s);
				break;
			}

			if ( cnt_colors == 2 )
				break;
		}

		switch(cnt_colors)
		{
			case 2:
				break;

			case 3:
				break;
		}

		if ( cnt_colors > 1 ) {		
			CG_Printf("cnt_colors: %i -- %i\n", cnt_colors, nameLength);
			if ( cnt_colors == 3 ) {
				CG_Printf("== 3\n");
				nameLength *= .5;
				fadeColors[3][0] = (fadeColors[0][0] - fadeColors[1][0]) / nameLength;
				fadeColors[3][1] = (fadeColors[0][1] - fadeColors[1][1]) / nameLength;
				fadeColors[3][2] = (fadeColors[0][2] - fadeColors[1][2]) / nameLength;
				fadeColors[4][0] = (fadeColors[1][0] - fadeColors[2][0]) / nameLength;
				fadeColors[4][1] = (fadeColors[1][1] - fadeColors[2][1]) / nameLength;
				fadeColors[4][2] = (fadeColors[1][2] - fadeColors[2][2]) / nameLength;
			} else {
				CG_Printf("else\n");
				fadeColors[3][0] = (fadeColors[0][0] - fadeColors[1][0]) / nameLength;
				fadeColors[3][1] = (fadeColors[0][1] - fadeColors[1][1]) / nameLength;
				fadeColors[3][2] = (fadeColors[0][2] - fadeColors[1][2]) / nameLength;
			}
			memcpy( color, fadeColors[0], sizeof( color ) );
		}
	}
	//Evo: Fade Hack

	while ( *s && cnt < maxChars) {
		if ( Q_IsColorString( s ) ) {
			if ( !forceColor ) {
				if ( cg_fontFade.integer && cnt_colors > 1 ) {
					//CG_Printf("cnt_colors: %i -- %i\n", cnt_colors, nameLength);
					if ( cnt > nameLength ) {
						memcpy( color, fadeColors[0], sizeof( color ) );
						fadeColors[0][0] -= fadeColors[4][0];
						fadeColors[0][1] -= fadeColors[4][1];
						fadeColors[0][2] -= fadeColors[4][2];
					} else {
						fadeColors[0][0] -= fadeColors[3][0];
						fadeColors[0][1] -= fadeColors[3][1];
						fadeColors[0][2] -= fadeColors[3][2];
					}
				} else {
					memcpy( color, g_color_table[ColorIndex(*(s+1))], sizeof( color ) );
//				}
				color[3] = setColor[3];
				trap_R_SetColor( color );
			}
			s += 2;
			continue;
		}
		CG_DrawChar( xx, y, charWidth, charHeight, *s, altFont, superhud );
		xx += charWidth;
		cnt++;
		s++;
	}
#endif
////XXX############## CHANGE END
	trap_R_SetColor( NULL );
}
//Superhud - End

void CG_DrawBigString( int x, int y, const char *s, float alpha ) {
	float	color[4];

	color[0] = color[1] = color[2] = 1.0;
	color[3] = alpha;
	CG_DrawStringExt( x, y, s, color, qfalse, qtrue, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
}

void CG_DrawBigStringColor( int x, int y, const char *s, vec4_t color ) {
	CG_DrawStringExt( x, y, s, color, qtrue, qtrue, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
}

void CG_DrawSmallString( int x, int y, const char *s, float alpha ) {
	float	color[4];

	color[0] = color[1] = color[2] = 1.0;
	color[3] = alpha;
	CG_DrawStringExt( x, y, s, color, qfalse, qfalse, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0, 0, 0 );
}

void CG_DrawSmallStringColor( int x, int y, const char *s, vec4_t color ) {
	CG_DrawStringExt( x, y, s, color, qtrue, qfalse, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0, 0, 0 );
}

/*
=================
CG_DrawStrlen

Returns character count, skiping color escape codes
=================
*/
int CG_DrawStrlen( const char *str ) {
	const char *s = str;
	int count = 0;

	while ( *s ) {
		if ( Q_IsColorString( s ) || ((*s == '^') && ((*s+1) != '^' )) ) {
			s += 2;
			//Shorten the length of the name for fontFades
		} else if ((*s == ':') && Q_IsColorString( s+1 )) {
					s += 3;
		/*} else if((*s  == ',') && Q_IsColorString( s+1 ) ) {
				//This means we'll be fading across the name.
				s += 3;
				if((*s  == ',') && Q_IsColorString( s+1 ) )
				{
					//This means we'll be fading across the name.
					s += 3;
				}*/
		} else {
			count++;
			s++;
		}
	}

	return count;
}

/*
=============
CG_TileClearBox

This repeats a 64*64 tile graphic to fill the screen around a sized down
refresh window.
=============
*/
static void CG_TileClearBox( int x, int y, int w, int h, qhandle_t hShader ) {
	float	s1, t1, s2, t2;

	s1 = x/64.0;
	t1 = y/64.0;
	s2 = (x+w)/64.0;
	t2 = (y+h)/64.0;
	trap_R_DrawStretchPic( x, y, w, h, s1, t1, s2, t2, hShader );
}



/*
==============
CG_TileClear

Clear around a sized down screen
==============
*/
void CG_TileClear( void ) {
	int		top, bottom, left, right;
	int		w, h;

	w = cgs.glconfig.vidWidth;
	h = cgs.glconfig.vidHeight;

	if ( cg.refdef.x == 0 && cg.refdef.y == 0 && 
		cg.refdef.width == w && cg.refdef.height == h ) {
		return;		// full screen rendering
	}

	top = cg.refdef.y;
	bottom = top + cg.refdef.height-1;
	left = cg.refdef.x;
	right = left + cg.refdef.width-1;

	// clear above view screen
	CG_TileClearBox( 0, 0, w, top, cgs.media.backTileShader );

	// clear below view screen
	CG_TileClearBox( 0, bottom, w, h - bottom, cgs.media.backTileShader );

	// clear left of view screen
	CG_TileClearBox( 0, top, left, bottom - top + 1, cgs.media.backTileShader );

	// clear right of view screen
	CG_TileClearBox( right, top, w - right, bottom - top + 1, cgs.media.backTileShader );
}



/*
================
CG_FadeColor
================
*/
float *CG_FadeColor( int startMsec, int totalMsec ) {
	static vec4_t		color;
	int			t;

	if ( startMsec == 0 ) {
		return NULL;
	}

	t = cg.time - startMsec;

	if ( t >= totalMsec ) {
		return NULL;
	}

	// fade out
	if ( totalMsec - t < FADE_TIME ) {
		color[3] = ( totalMsec - t ) * 1.0/FADE_TIME;
	} else {
		color[3] = 1.0;
	}
	color[0] = color[1] = color[2] = 1;

	return color;
}

/*
================
CG_FadeFromColorTo
This is for the superhud fade color...
The goal of this is to "fade" from one color to the next over a period of time.
================
*/
float *CG_FadeFromColorTo( vec4_t startColor, vec4_t endColor, int startTime, int lengthTime ) {
	static vec4_t		color;
	int			timePassed, i;

	if ( startTime == 0 ) {
		return NULL;
	}

	timePassed = cg.time - startTime;

	if ( timePassed >= lengthTime ) {
		return NULL;
	}

	//fade to color
	memcpy(color, startColor, sizeof(color) );

	//Begin Loop
	for ( i = 0; i < 4; i++ ) {
		//determine which value is greater
		if ( startColor[i] > endColor[i] ) {
			//Find the difference
			//Figure out how much change occurs
			//subtract from color
			//color[i] = ((startColor[i] - endColor[i]) / lengthTime) * timePassed;//Fade in
			//color[i] = startColor[i] - (((startColor[i] - endColor[i]) / lengthTime) * (lengthTime - timePassed ));//Clean Fade in

					  //Start color - totalDifferenceForTime
			color[i] = startColor[i] - ( ( (startColor[i] - endColor[i]) / lengthTime ) * timePassed );
		} else if ( startColor[i] < endColor[i] ) {
			//Find the difference
			//Figure out how much change occurs
			//Add to color
			color[i] = startColor[i] + ( ( (startColor[i] - endColor[i]) / lengthTime ) * timePassed );
		}
	}
	//End loop

	//Return the color
	return color;
}


/*
================
CG_TeamColor
================
*/
float *CG_TeamColor( int team ) {
	static vec4_t	red = {1, 0.2f, 0.2f, 1};
	static vec4_t	blue = {0.2f, 0.2f, 1, 1};
	static vec4_t	other = {1, 1, 1, 1};
	static vec4_t	spectator = {0.7f, 0.7f, 0.7f, 1};

	switch ( team ) {
	case TEAM_RED:
		return red;
	case TEAM_BLUE:
		return blue;
	case TEAM_SPECTATOR:
		return spectator;
	default:
		return other;
	}
}



/*
=================
CG_GetColorForHealth
=================
*/
void CG_GetColorForHealth( int health, int armor, vec4_t hcolor ) {
	int		count;
	int		max;

	// calculate the total points of damage that can
	// be sustained at the current health / armor level
	if ( health <= 0 ) {
		VectorClear( hcolor );	// black
		hcolor[3] = 1;
		return;
	}
	count = armor;
	max = health * ARMOR_PROTECTION / ( 1.0 - ARMOR_PROTECTION );
	if ( max < count ) {
		count = max;
	}
	health += count;

	// set the color based on health
	hcolor[0] = 1.0;
	hcolor[3] = 1.0;
	if ( health >= 100 ) {
		hcolor[2] = 1.0;
	} else if ( health < 66 ) {
		hcolor[2] = 0;
	} else {
		hcolor[2] = ( health - 66 ) / 33.0;
	}

	if ( health > 60 ) {
		hcolor[1] = 1.0;
	} else if ( health < 30 ) {
		hcolor[1] = 0;
	} else {
		hcolor[1] = ( health - 30 ) / 30.0;
	}
}

/*
=================
CG_ColorForHealth
=================
*/
void CG_ColorForHealth( vec4_t hcolor ) {

	CG_GetColorForHealth( cg.snap->ps.stats[STAT_HEALTH], 
		cg.snap->ps.stats[STAT_ARMOR], hcolor );
}




// bk001205 - code below duplicated in q3_ui/ui-atoms.c
// bk001205 - FIXME: does this belong in ui_shared.c?
// bk001205 - FIXME: HARD_LINKED flags not visible here
#ifndef Q3_STATIC // bk001205 - q_shared defines not visible here 
/*
=================
UI_DrawProportionalString2
=================
*/
static int	propMap[128][3] = {
{0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1},
{0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1},

{0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1},
{0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1},

{0, 0, PROP_SPACE_WIDTH},		// SPACE
{11, 122, 7},	// !
{154, 181, 14},	// "
{55, 122, 17},	// #
{79, 122, 18},	// $
{101, 122, 23},	// %
{153, 122, 18},	// &
{9, 93, 7},		// '
{207, 122, 8},	// (
{230, 122, 9},	// )
{177, 122, 18},	// *
{30, 152, 18},	// +
{85, 181, 7},	// ,
{34, 93, 11},	// -
{110, 181, 6},	// .
{130, 152, 14},	// /

{22, 64, 17},	// 0
{41, 64, 12},	// 1
{58, 64, 17},	// 2
{78, 64, 18},	// 3
{98, 64, 19},	// 4
{120, 64, 18},	// 5
{141, 64, 18},	// 6
{204, 64, 16},	// 7
{162, 64, 17},	// 8
{182, 64, 18},	// 9
{59, 181, 7},	// :
{35,181, 7},	// ;
{203, 152, 14},	// <
{56, 93, 14},	// =
{228, 152, 14},	// >
{177, 181, 18},	// ?

{28, 122, 22},	// @
{5, 4, 18},		// A
{27, 4, 18},	// B
{48, 4, 18},	// C
{69, 4, 17},	// D
{90, 4, 13},	// E
{106, 4, 13},	// F
{121, 4, 18},	// G
{143, 4, 17},	// H
{164, 4, 8},	// I
{175, 4, 16},	// J
{195, 4, 18},	// K
{216, 4, 12},	// L
{230, 4, 23},	// M
{6, 34, 18},	// N
{27, 34, 18},	// O

{48, 34, 18},	// P
{68, 34, 18},	// Q
{90, 34, 17},	// R
{110, 34, 18},	// S
{130, 34, 14},	// T
{146, 34, 18},	// U
{166, 34, 19},	// V
{185, 34, 29},	// W
{215, 34, 18},	// X
{234, 34, 18},	// Y
{5, 64, 14},	// Z
{60, 152, 7},	// [
{106, 151, 13},	// '\'
{83, 152, 7},	// ]
{128, 122, 17},	// ^
{4, 152, 21},	// _

{134, 181, 5},	// '
{5, 4, 18},		// A
{27, 4, 18},	// B
{48, 4, 18},	// C
{69, 4, 17},	// D
{90, 4, 13},	// E
{106, 4, 13},	// F
{121, 4, 18},	// G
{143, 4, 17},	// H
{164, 4, 8},	// I
{175, 4, 16},	// J
{195, 4, 18},	// K
{216, 4, 12},	// L
{230, 4, 23},	// M
{6, 34, 18},	// N
{27, 34, 18},	// O

{48, 34, 18},	// P
{68, 34, 18},	// Q
{90, 34, 17},	// R
{110, 34, 18},	// S
{130, 34, 14},	// T
{146, 34, 18},	// U
{166, 34, 19},	// V
{185, 34, 29},	// W
{215, 34, 18},	// X
{234, 34, 18},	// Y
{5, 64, 14},	// Z
{153, 152, 13},	// {
{11, 181, 5},	// |
{180, 152, 13},	// }
{79, 93, 17},	// ~
{0, 0, -1}		// DEL
};

static int propMapB[26][3] = {
{11, 12, 33},
{49, 12, 31},
{85, 12, 31},
{120, 12, 30},
{156, 12, 21},
{183, 12, 21},
{207, 12, 32},

{13, 55, 30},
{49, 55, 13},
{66, 55, 29},
{101, 55, 31},
{135, 55, 21},
{158, 55, 40},
{204, 55, 32},

{12, 97, 31},
{48, 97, 31},
{82, 97, 30},
{118, 97, 30},
{153, 97, 30},
{185, 97, 25},
{213, 97, 30},

{11, 139, 32},
{42, 139, 51},
{93, 139, 32},
{126, 139, 31},
{158, 139, 25},
};

#define PROPB_GAP_WIDTH		4
#define PROPB_SPACE_WIDTH	12
#define PROPB_HEIGHT		36

/*
=================
UI_DrawBannerString
=================
*/
static void UI_DrawBannerString2( int x, int y, const char* str, vec4_t color )
{
	const char* s;
	unsigned char	ch; // bk001204 : array subscript
	float	ax;
	float	ay;
	float	aw;
	float	ah;
	float	frow;
	float	fcol;
	float	fwidth;
	float	fheight;

	// draw the colored text
	trap_R_SetColor( color );
	
	ax = x * cgs.screenXScale + cgs.screenXBias;
	ay = y * cgs.screenXScale;

	s = str;
	while ( *s )
	{
		ch = *s & 127;
		if ( ch == ' ' ) {
			ax += ((float)PROPB_SPACE_WIDTH + (float)PROPB_GAP_WIDTH)* cgs.screenXScale;
		}
		else if ( ch >= 'A' && ch <= 'Z' ) {
			ch -= 'A';
			fcol = (float)propMapB[ch][0] / 256.0f;
			frow = (float)propMapB[ch][1] / 256.0f;
			fwidth = (float)propMapB[ch][2] / 256.0f;
			fheight = (float)PROPB_HEIGHT / 256.0f;
			aw = (float)propMapB[ch][2] * cgs.screenXScale;
			ah = (float)PROPB_HEIGHT * cgs.screenXScale;
			trap_R_DrawStretchPic( ax, ay, aw, ah, fcol, frow, fcol+fwidth, frow+fheight, cgs.media.charsetPropB );
			ax += (aw + (float)PROPB_GAP_WIDTH * cgs.screenXScale);
		}
		s++;
	}

	trap_R_SetColor( NULL );
}

void UI_DrawBannerString( int x, int y, const char* str, int style, vec4_t color ) {
	const char *	s;
	int				ch;
	int				width;
	vec4_t			drawcolor;

	// find the width of the drawn text
	s = str;
	width = 0;
	while ( *s ) {
		ch = *s;
		if ( ch == ' ' ) {
			width += PROPB_SPACE_WIDTH;
		}
		else if ( ch >= 'A' && ch <= 'Z' ) {
			width += propMapB[ch - 'A'][2] + PROPB_GAP_WIDTH;
		}
		s++;
	}
	width -= PROPB_GAP_WIDTH;

	switch( style & UI_FORMATMASK ) {
		case UI_CENTER:
			x -= width / 2;
			break;

		case UI_RIGHT:
			x -= width;
			break;

		case UI_LEFT:
		default:
			break;
	}

	if ( style & UI_DROPSHADOW ) {
		drawcolor[0] = drawcolor[1] = drawcolor[2] = 0;
		drawcolor[3] = color[3];
		UI_DrawBannerString2( x+2, y+2, str, drawcolor );
	}

	UI_DrawBannerString2( x, y, str, color );
}


int UI_ProportionalStringWidth( const char* str ) {
	const char *	s;
	int				ch;
	int				charWidth;
	int				width;

	s = str;
	width = 0;
	while ( *s ) {
		ch = *s & 127;
		charWidth = propMap[ch][2];
		if ( charWidth != -1 ) {
			width += charWidth;
			width += PROP_GAP_WIDTH;
		}
		s++;
	}

	width -= PROP_GAP_WIDTH;
	return width;
}

static void UI_DrawProportionalString2( int x, int y, const char* str, vec4_t color, float sizeScale, qhandle_t charset )
{
	const char* s;
	unsigned char	ch; // bk001204 - unsigned
	float	ax;
	float	ay;
	float	aw;
	float	ah;
	float	frow;
	float	fcol;
	float	fwidth;
	float	fheight;

	// draw the colored text
	trap_R_SetColor( color );
	
	ax = x * cgs.screenXScale + cgs.screenXBias;
	ay = y * cgs.screenXScale;

	s = str;
	while ( *s )
	{
		ch = *s & 127;
		if ( ch == ' ' ) {
			aw = (float)PROP_SPACE_WIDTH * cgs.screenXScale * sizeScale;
		} else if ( propMap[ch][2] != -1 ) {
			fcol = (float)propMap[ch][0] / 256.0f;
			frow = (float)propMap[ch][1] / 256.0f;
			fwidth = (float)propMap[ch][2] / 256.0f;
			fheight = (float)PROP_HEIGHT / 256.0f;
			aw = (float)propMap[ch][2] * cgs.screenXScale * sizeScale;
			ah = (float)PROP_HEIGHT * cgs.screenXScale * sizeScale;
			trap_R_DrawStretchPic( ax, ay, aw, ah, fcol, frow, fcol+fwidth, frow+fheight, charset );
		} else {
			aw = 0;
		}

		ax += (aw + (float)PROP_GAP_WIDTH * cgs.screenXScale * sizeScale);
		s++;
	}

	trap_R_SetColor( NULL );
}

/*
=================
UI_ProportionalSizeScale
=================
*/
float UI_ProportionalSizeScale( int style ) {
	if ( style & UI_EXTRASMALLFONT ) {
		return 0.40f;
	}
	if ( style & UI_SMALLFONT ) {
		return 0.75f;
	}

	return 1.00;
}


/*
=================
UI_DrawProportionalString
=================
*/
void UI_DrawProportionalString( int x, int y, const char* str, int style, vec4_t color ) {
	vec4_t	drawcolor;
	int		width;
	float	sizeScale;

	sizeScale = UI_ProportionalSizeScale( style );

	switch( style & UI_FORMATMASK ) {
		case UI_CENTER:
			width = UI_ProportionalStringWidth( str ) * sizeScale;
			x -= width / 2;
			break;

		case UI_RIGHT:
			width = UI_ProportionalStringWidth( str ) * sizeScale;
			x -= width;
			break;

		case UI_LEFT:
		default:
			break;
	}

	if ( style & UI_DROPSHADOW ) {
		drawcolor[0] = drawcolor[1] = drawcolor[2] = 0;
		drawcolor[3] = color[3];
		UI_DrawProportionalString2( x+2, y+2, str, drawcolor, sizeScale, cgs.media.charsetProp );
	}

	if ( style & UI_INVERSE ) {
		drawcolor[0] = color[0] * 0.8;
		drawcolor[1] = color[1] * 0.8;
		drawcolor[2] = color[2] * 0.8;
		drawcolor[3] = color[3];
		UI_DrawProportionalString2( x, y, str, drawcolor, sizeScale, cgs.media.charsetProp );
		return;
	}

	if ( style & UI_PULSE ) {
		drawcolor[0] = color[0] * 0.8;
		drawcolor[1] = color[1] * 0.8;
		drawcolor[2] = color[2] * 0.8;
		drawcolor[3] = color[3];
		UI_DrawProportionalString2( x, y, str, color, sizeScale, cgs.media.charsetProp );

		drawcolor[0] = color[0];
		drawcolor[1] = color[1];
		drawcolor[2] = color[2];
		drawcolor[3] = 0.5 + 0.5 * sin( cg.time / PULSE_DIVISOR );
		UI_DrawProportionalString2( x, y, str, drawcolor, sizeScale, cgs.media.charsetPropGlow );
		return;
	}

	UI_DrawProportionalString2( x, y, str, color, sizeScale, cgs.media.charsetProp );
}
#endif // Q3STATIC
