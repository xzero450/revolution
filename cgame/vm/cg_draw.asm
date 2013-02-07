data
export drawTeamOverlayModificationCount
align 4
LABELV drawTeamOverlayModificationCount
byte 4 -1
export DrawMOTDBox
code
proc DrawMOTDBox 96 24
file "../cg_draw.c"
line 29
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_draw.c -- draw all of the graphical elements during
;4:// active (after loading) gameplay
;5:
;6:#include "cg_local.h"
;7:#include "..\game\bg_promode.h" // CPM
;8:
;9:#ifdef MISSIONPACK
;10:#include "../ui/ui_shared.h"
;11:
;12:// used for scoreboard
;13:extern displayContextDef_t cgDC;
;14:menuDef_t *menuScoreboard = NULL;
;15:#else
;16:int drawTeamOverlayModificationCount = -1;
;17:#endif
;18:
;19:int sortedTeamPlayers[TEAM_MAXOVERLAY];
;20:int	numSortedTeamPlayers;
;21:
;22:char systemChat[256];
;23:char teamChat1[256];
;24:char teamChat2[256];
;25:
;26:#define MOTD_WIDTH 300.0f
;27:
;28:int DrawMOTDBox()
;29:{
line 32
;30:	int x;
;31:	int y;
;32:	int height = SMALLCHAR_HEIGHT*9;
ADDRLP4 8
CNSTI4 144
ASGNI4
line 38
;33:
;34:	vec4_t		hcolor;
;35:	vec4_t		hcolor2;
;36:	vec4_t		hcolor3;
;37:
;38:	if (!cg.motdDisplayTime || cg.motdDisplayTime < cg.time)
ADDRGP4 cg+170312
INDIRI4
CNSTI4 0
EQI4 $83
ADDRGP4 cg+170312
INDIRI4
ADDRGP4 cg+107604
INDIRI4
GEI4 $78
LABELV $83
line 39
;39:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $77
JUMPV
LABELV $78
line 41
;40:
;41:	if ( !strlen(cg.sv_motd1) && !strlen(cg.sv_motd2)  && 
ADDRGP4 cg+162116
ARGP4
ADDRLP4 60
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $84
ADDRGP4 cg+163140
ARGP4
ADDRLP4 64
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
NEI4 $84
ADDRGP4 cg+164164
ARGP4
ADDRLP4 68
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
NEI4 $84
ADDRGP4 cg+165188
ARGP4
ADDRLP4 72
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $84
ADDRGP4 cg+166212
ARGP4
ADDRLP4 76
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $84
ADDRGP4 cg+167236
ARGP4
ADDRLP4 80
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
NEI4 $84
ADDRGP4 cg+168260
ARGP4
ADDRLP4 84
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
NEI4 $84
ADDRGP4 cg+169284
ARGP4
ADDRLP4 88
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
NEI4 $84
line 44
;42:		 !strlen(cg.sv_motd3) && !strlen(cg.sv_motd4) &&
;43:		 !strlen(cg.sv_motd5) && !strlen(cg.sv_motd6) &&
;44:		 !strlen(cg.sv_motd7) && !strlen(cg.sv_motd8) ) {
line 46
;45:			 //Nothing to display, so don't.
;46:			 return 0;
CNSTI4 0
RETI4
ADDRGP4 $77
JUMPV
LABELV $84
line 50
;47:	}
;48:
;49:	
;50:	hcolor[0] = 0.10;
ADDRLP4 12
CNSTF4 1036831949
ASGNF4
line 51
;51:	hcolor[1] = 0.10;
ADDRLP4 12+4
CNSTF4 1036831949
ASGNF4
line 52
;52:	hcolor[2] = 0.10;
ADDRLP4 12+8
CNSTF4 1036831949
ASGNF4
line 54
;53:
;54:	hcolor2[0] = 0;
ADDRLP4 28
CNSTF4 0
ASGNF4
line 55
;55:	hcolor2[1] = 0;
ADDRLP4 28+4
CNSTF4 0
ASGNF4
line 56
;56:	hcolor2[2] = 0;
ADDRLP4 28+8
CNSTF4 0
ASGNF4
line 58
;57:
;58:	hcolor3[0] = 0.02;
ADDRLP4 44
CNSTF4 1017370378
ASGNF4
line 59
;59:	hcolor3[1] = 0.02;
ADDRLP4 44+4
CNSTF4 1017370378
ASGNF4
line 60
;60:	hcolor3[2] = 0.02;
ADDRLP4 44+8
CNSTF4 1017370378
ASGNF4
line 62
;61:
;62:	hcolor[3] = 0.75;
ADDRLP4 12+12
CNSTF4 1061158912
ASGNF4
line 63
;63:	hcolor2[3] = 1;
ADDRLP4 28+12
CNSTF4 1065353216
ASGNF4
line 64
;64:	hcolor3[3] = 0.5;
ADDRLP4 44+12
CNSTF4 1056964608
ASGNF4
line 68
;65:
;66:	//trap_R_SetColor( hcolor );
;67:
;68:	y = 480 - height - SMALLCHAR_HEIGHT*2;
ADDRLP4 0
CNSTI4 480
ADDRLP4 8
INDIRI4
SUBI4
CNSTI4 32
SUBI4
ASGNI4
line 69
;69:	x = 640 - MOTD_WIDTH;
ADDRLP4 4
CNSTI4 340
ASGNI4
line 71
;70:
;71:	if (cg.time < cg.motdScrollTime) // is the box scrolling on/off the screen?
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+170308
INDIRI4
GEI4 $103
line 72
;72:	{
line 73
;73:		if (cg.motdDisplayTime == cg.motdScrollTime) // scrolling off
ADDRGP4 cg+170312
INDIRI4
ADDRGP4 cg+170308
INDIRI4
NEI4 $107
line 74
;74:		{
line 76
;75:			//x = 640 - MOTD_WIDTH + MOTD_WIDTH * (((float)(cg.motdDisplayTime-cg.motdScrollTime)/1000.0f - 1.0f) * -1.0f);
;76:			x = 640 - MOTD_WIDTH * (float)(cg.motdScrollTime-cg.time)/1000.0f;
ADDRLP4 4
CNSTF4 1142947840
CNSTF4 1133903872
ADDRGP4 cg+170308
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CVIF4 4
MULF4
CNSTF4 1148846080
DIVF4
SUBF4
CVFI4 4
ASGNI4
line 77
;77:		}
ADDRGP4 $104
JUMPV
LABELV $107
line 79
;78:		else // scrolling on
;79:		{
line 80
;80:			x = 640 - MOTD_WIDTH + MOTD_WIDTH * (float)(cg.motdScrollTime-cg.time)/1000.0f;
ADDRLP4 4
CNSTF4 1133903872
ADDRGP4 cg+170308
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CVIF4 4
MULF4
CNSTF4 1148846080
DIVF4
CNSTF4 1135214592
ADDF4
CVFI4 4
ASGNI4
line 81
;81:		}
line 82
;82:	}
ADDRGP4 $104
JUMPV
LABELV $103
line 83
;83:	else if (cg.time + 1000 >= cg.motdDisplayTime)
ADDRGP4 cg+107604
INDIRI4
CNSTI4 1000
ADDI4
ADDRGP4 cg+170312
INDIRI4
LTI4 $115
line 84
;84:	{
line 85
;85:		cg.motdScrollTime = cg.motdDisplayTime;
ADDRGP4 cg+170308
ADDRGP4 cg+170312
INDIRI4
ASGNI4
line 86
;86:	}
LABELV $115
LABELV $104
line 89
;87:
;88:
;89:	CG_FillRect( x, y, MOTD_WIDTH-SMALLCHAR_WIDTH*2, height, hcolor );
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1133379584
ARGF4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 90
;90:	CG_DrawRect( x, y, MOTD_WIDTH-SMALLCHAR_WIDTH*2, height, 1, hcolor2 );
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1133379584
ARGF4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 28
ARGP4
ADDRGP4 CG_DrawRect
CALLV
pop
line 91
;91:	CG_DrawRect( x+1, y+1, MOTD_WIDTH-SMALLCHAR_WIDTH*2 + 1, height + 1, 1, hcolor3 );
ADDRLP4 92
CNSTI4 1
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 92
INDIRI4
ADDI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRI4
ADDRLP4 92
INDIRI4
ADDI4
CVIF4 4
ARGF4
CNSTF4 1133412352
ARGF4
ADDRLP4 8
INDIRI4
ADDRLP4 92
INDIRI4
ADDI4
CVIF4 4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 44
ARGP4
ADDRGP4 CG_DrawRect
CALLV
pop
line 93
;92:
;93:	x += 8;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 8
ADDI4
ASGNI4
line 94
;94:	y += 8;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 8
ADDI4
ASGNI4
line 97
;95:
;96:	/**/
;97:	CG_DrawSmallString( x, y, cg.sv_motd1, 1 );
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 cg+162116
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawSmallString
CALLV
pop
line 98
;98:	y += SMALLCHAR_HEIGHT;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 100
;99:
;100:	CG_DrawSmallString( x, y, cg.sv_motd2, 1 );
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 cg+163140
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawSmallString
CALLV
pop
line 101
;101:	y += SMALLCHAR_HEIGHT;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 103
;102:
;103:	CG_DrawSmallString( x, y, cg.sv_motd3, 1 );
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 cg+164164
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawSmallString
CALLV
pop
line 104
;104:	y += SMALLCHAR_HEIGHT;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 106
;105:
;106:	CG_DrawSmallString( x, y, cg.sv_motd4, 1 );
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 cg+165188
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawSmallString
CALLV
pop
line 107
;107:	y += SMALLCHAR_HEIGHT;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 109
;108:
;109:	CG_DrawSmallString( x, y, cg.sv_motd5, 1 );
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 cg+166212
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawSmallString
CALLV
pop
line 110
;110:	y += SMALLCHAR_HEIGHT;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 112
;111:
;112:	CG_DrawSmallString( x, y, cg.sv_motd6, 1 );
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 cg+167236
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawSmallString
CALLV
pop
line 113
;113:	y += SMALLCHAR_HEIGHT;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 115
;114:
;115:	CG_DrawSmallString( x, y, cg.sv_motd7, 1 );
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 cg+168260
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawSmallString
CALLV
pop
line 116
;116:	y += SMALLCHAR_HEIGHT;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 118
;117:
;118:	CG_DrawSmallString( x, y, cg.sv_motd8, 1 );
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 cg+169284
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawSmallString
CALLV
pop
line 119
;119:	y += SMALLCHAR_HEIGHT;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 148
;120:
;121:	/** /
;122:
;123:	CG_DrawBigString( x, y, cg.sv_motd1, 1 );
;124:	y += SMALLCHAR_HEIGHT;
;125:
;126:	CG_DrawBigString( x, y, cg.sv_motd2, 1 );
;127:	y += SMALLCHAR_HEIGHT;
;128:
;129:	CG_DrawBigString( x, y, cg.sv_motd3, 1 );
;130:	y += SMALLCHAR_HEIGHT;
;131:
;132:	CG_DrawBigString( x, y, cg.sv_motd4, 1 );
;133:	y += SMALLCHAR_HEIGHT;
;134:
;135:	CG_DrawBigString( x, y, cg.sv_motd5, 1 );
;136:	y += SMALLCHAR_HEIGHT;
;137:
;138:	CG_DrawBigString( x, y, cg.sv_motd6, 1 );
;139:	y += SMALLCHAR_HEIGHT;
;140:
;141:	CG_DrawBigString( x, y, cg.sv_motd7, 1 );
;142:	y += SMALLCHAR_HEIGHT;
;143:
;144:	CG_DrawBigString( x, y, cg.sv_motd8, 1 );
;145:	y += SMALLCHAR_HEIGHT;
;146:	/**/
;147:
;148:	return 1;
CNSTI4 1
RETI4
LABELV $77
endproc DrawMOTDBox 96 24
proc CG_DrawField 56 20
line 319
;149:}
;150:
;151:#ifdef MISSIONPACK
;152:
;153:int CG_Text_Width(const char *text, float scale, int limit) {
;154:  int count,len;
;155:	float out;
;156:	glyphInfo_t *glyph;
;157:	float useScale;
;158:// FIXME: see ui_main.c, same problem
;159://	const unsigned char *s = text;
;160:	const char *s = text;
;161:	fontInfo_t *font = &cgDC.Assets.textFont;
;162:	if (scale <= cg_smallFont.value) {
;163:		font = &cgDC.Assets.smallFont;
;164:	} else if (scale > cg_bigFont.value) {
;165:		font = &cgDC.Assets.bigFont;
;166:	}
;167:	useScale = scale * font->glyphScale;
;168:  out = 0;
;169:  if (text) {
;170:    len = strlen(text);
;171:		if (limit > 0 && len > limit) {
;172:			len = limit;
;173:		}
;174:		count = 0;
;175:		while (s && *s && count < len) {
;176:			if ( Q_IsColorString(s) ) {
;177:				s += 2;
;178:				continue;
;179:			} else {
;180:				glyph = &font->glyphs[(int)*s]; // TTimo: FIXME: getting nasty warnings without the cast, hopefully this doesn't break the VM build
;181:				out += glyph->xSkip;
;182:				s++;
;183:				count++;
;184:			}
;185:    }
;186:  }
;187:  return out * useScale;
;188:}
;189:
;190:int CG_Text_Height(const char *text, float scale, int limit) {
;191:  int len, count;
;192:	float max;
;193:	glyphInfo_t *glyph;
;194:	float useScale;
;195:// TTimo: FIXME
;196://	const unsigned char *s = text;
;197:	const char *s = text;
;198:	fontInfo_t *font = &cgDC.Assets.textFont;
;199:	if (scale <= cg_smallFont.value) {
;200:		font = &cgDC.Assets.smallFont;
;201:	} else if (scale > cg_bigFont.value) {
;202:		font = &cgDC.Assets.bigFont;
;203:	}
;204:	useScale = scale * font->glyphScale;
;205:  max = 0;
;206:  if (text) {
;207:    len = strlen(text);
;208:		if (limit > 0 && len > limit) {
;209:			len = limit;
;210:		}
;211:		count = 0;
;212:		while (s && *s && count < len) {
;213:			if ( Q_IsColorString(s) ) {
;214:				s += 2;
;215:				continue;
;216:			} else {
;217:				glyph = &font->glyphs[(int)*s]; // TTimo: FIXME: getting nasty warnings without the cast, hopefully this doesn't break the VM build
;218:	      if (max < glyph->height) {
;219:		      max = glyph->height;
;220:			  }
;221:				s++;
;222:				count++;
;223:			}
;224:    }
;225:  }
;226:  return max * useScale;
;227:}
;228:
;229:void CG_Text_PaintChar(float x, float y, float width, float height, float scale, float s, float t, float s2, float t2, qhandle_t hShader) {
;230:  float w, h;
;231:  w = width * scale;
;232:  h = height * scale;
;233:  CG_AdjustFrom640( &x, &y, &w, &h );
;234:  trap_R_DrawStretchPic( x, y, w, h, s, t, s2, t2, hShader );
;235:}
;236:
;237:void CG_Text_Paint(float x, float y, float scale, vec4_t color, const char *text, float adjust, int limit, int style) {
;238:  int len, count;
;239:	vec4_t newColor;
;240:	glyphInfo_t *glyph;
;241:	float useScale;
;242:	fontInfo_t *font = &cgDC.Assets.textFont;
;243:	if (scale <= cg_smallFont.value) {
;244:		font = &cgDC.Assets.smallFont;
;245:	} else if (scale > cg_bigFont.value) {
;246:		font = &cgDC.Assets.bigFont;
;247:	}
;248:	useScale = scale * font->glyphScale;
;249:  if (text) {
;250:// TTimo: FIXME
;251://		const unsigned char *s = text;
;252:		const char *s = text;
;253:		trap_R_SetColor( color );
;254:		memcpy(&newColor[0], &color[0], sizeof(vec4_t));
;255:    len = strlen(text);
;256:		if (limit > 0 && len > limit) {
;257:			len = limit;
;258:		}
;259:		count = 0;
;260:		while (s && *s && count < len) {
;261:			glyph = &font->glyphs[(int)*s]; // TTimo: FIXME: getting nasty warnings without the cast, hopefully this doesn't break the VM build
;262:      //int yadj = Assets.textFont.glyphs[text[i]].bottom + Assets.textFont.glyphs[text[i]].top;
;263:      //float yadj = scale * (Assets.textFont.glyphs[text[i]].imageHeight - Assets.textFont.glyphs[text[i]].height);
;264:			if ( Q_IsColorString( s ) ) {
;265:				memcpy( newColor, g_color_table[ColorIndex(*(s+1))], sizeof( newColor ) );
;266:				newColor[3] = color[3];
;267:				trap_R_SetColor( newColor );
;268:				s += 2;
;269:				continue;
;270:			} else {
;271:				float yadj = useScale * glyph->top;
;272:				if (style == ITEM_TEXTSTYLE_SHADOWED || style == ITEM_TEXTSTYLE_SHADOWEDMORE) {
;273:					int ofs = style == ITEM_TEXTSTYLE_SHADOWED ? 1 : 2;
;274:					colorBlack[3] = newColor[3];
;275:					trap_R_SetColor( colorBlack );
;276:					CG_Text_PaintChar(x + ofs, y - yadj + ofs, 
;277:														glyph->imageWidth,
;278:														glyph->imageHeight,
;279:														useScale, 
;280:														glyph->s,
;281:														glyph->t,
;282:														glyph->s2,
;283:														glyph->t2,
;284:														glyph->glyph);
;285:					colorBlack[3] = 1.0;
;286:					trap_R_SetColor( newColor );
;287:				}
;288:				CG_Text_PaintChar(x, y - yadj, 
;289:													glyph->imageWidth,
;290:													glyph->imageHeight,
;291:													useScale, 
;292:													glyph->s,
;293:													glyph->t,
;294:													glyph->s2,
;295:													glyph->t2,
;296:													glyph->glyph);
;297:				// CG_DrawPic(x, y - yadj, scale * cgDC.Assets.textFont.glyphs[text[i]].imageWidth, scale * cgDC.Assets.textFont.glyphs[text[i]].imageHeight, cgDC.Assets.textFont.glyphs[text[i]].glyph);
;298:				x += (glyph->xSkip * useScale) + adjust;
;299:				s++;
;300:				count++;
;301:			}
;302:    }
;303:	  trap_R_SetColor( NULL );
;304:  }
;305:}
;306:
;307:
;308:#endif
;309:
;310:
;311:/*
;312:==============
;313:CG_DrawField
;314:
;315:Draws large numbers for status bar and powerups
;316:==============
;317:*/
;318:#ifndef MISSIONPACK
;319:static void CG_DrawField (int x, int y, int width, int value) {
line 324
;320:	char	num[16], *ptr;
;321:	int		l;
;322:	int		frame;
;323:
;324:	if ( width < 1 ) {
ADDRFP4 8
INDIRI4
CNSTI4 1
GEI4 $130
line 325
;325:		return;
ADDRGP4 $129
JUMPV
LABELV $130
line 329
;326:	}
;327:
;328:	// draw number string
;329:	if ( width > 5 ) {
ADDRFP4 8
INDIRI4
CNSTI4 5
LEI4 $132
line 330
;330:		width = 5;
ADDRFP4 8
CNSTI4 5
ASGNI4
line 331
;331:	}
LABELV $132
line 333
;332:
;333:	switch ( width ) {
ADDRLP4 28
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 1
LTI4 $134
ADDRLP4 28
INDIRI4
CNSTI4 4
GTI4 $134
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $158-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $158
address $136
address $143
address $147
address $151
code
LABELV $136
line 335
;334:	case 1:
;335:		value = value > 9 ? 9 : value;
ADDRFP4 12
INDIRI4
CNSTI4 9
LEI4 $138
ADDRLP4 32
CNSTI4 9
ASGNI4
ADDRGP4 $139
JUMPV
LABELV $138
ADDRLP4 32
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $139
ADDRFP4 12
ADDRLP4 32
INDIRI4
ASGNI4
line 336
;336:		value = value < 0 ? 0 : value;
ADDRFP4 12
INDIRI4
CNSTI4 0
GEI4 $141
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRGP4 $142
JUMPV
LABELV $141
ADDRLP4 36
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $142
ADDRFP4 12
ADDRLP4 36
INDIRI4
ASGNI4
line 337
;337:		break;
ADDRGP4 $135
JUMPV
LABELV $143
line 339
;338:	case 2:
;339:		value = value > 99 ? 99 : value;
ADDRFP4 12
INDIRI4
CNSTI4 99
LEI4 $145
ADDRLP4 40
CNSTI4 99
ASGNI4
ADDRGP4 $146
JUMPV
LABELV $145
ADDRLP4 40
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $146
ADDRFP4 12
ADDRLP4 40
INDIRI4
ASGNI4
line 341
;340:	//	value = value < -9 ? -9 : value;
;341:		break;
ADDRGP4 $135
JUMPV
LABELV $147
line 343
;342:	case 3:
;343:		value = value > 999 ? 999 : value;
ADDRFP4 12
INDIRI4
CNSTI4 999
LEI4 $149
ADDRLP4 44
CNSTI4 999
ASGNI4
ADDRGP4 $150
JUMPV
LABELV $149
ADDRLP4 44
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $150
ADDRFP4 12
ADDRLP4 44
INDIRI4
ASGNI4
line 345
;344:	//	value = value < -99 ? -99 : value;
;345:		break;
ADDRGP4 $135
JUMPV
LABELV $151
line 347
;346:	case 4:
;347:		value = value > 9999 ? 9999 : value;
ADDRFP4 12
INDIRI4
CNSTI4 9999
LEI4 $153
ADDRLP4 48
CNSTI4 9999
ASGNI4
ADDRGP4 $154
JUMPV
LABELV $153
ADDRLP4 48
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $154
ADDRFP4 12
ADDRLP4 48
INDIRI4
ASGNI4
line 349
;348:		//value = value > 999 ? 999 : value;
;349:		value = value < -999 ? -999 : value;
ADDRFP4 12
INDIRI4
CNSTI4 -999
GEI4 $156
ADDRLP4 52
CNSTI4 -999
ASGNI4
ADDRGP4 $157
JUMPV
LABELV $156
ADDRLP4 52
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $157
ADDRFP4 12
ADDRLP4 52
INDIRI4
ASGNI4
line 350
;350:		break;
LABELV $134
LABELV $135
line 353
;351:	}
;352:
;353:	Com_sprintf (num, sizeof(num), "%i", value);
ADDRLP4 12
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $160
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 354
;354:	l = strlen(num);
ADDRLP4 12
ARGP4
ADDRLP4 32
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 32
INDIRI4
ASGNI4
line 355
;355:	if (l > width)
ADDRLP4 4
INDIRI4
ADDRFP4 8
INDIRI4
LEI4 $161
line 356
;356:		l = width;
ADDRLP4 4
ADDRFP4 8
INDIRI4
ASGNI4
LABELV $161
line 357
;357:	x += 2 + CHAR_WIDTH*(width - l);
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRFP4 8
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 5
LSHI4
CNSTI4 2
ADDI4
ADDI4
ASGNI4
line 359
;358:
;359:	ptr = num;
ADDRLP4 0
ADDRLP4 12
ASGNP4
ADDRGP4 $164
JUMPV
LABELV $163
line 361
;360:	while (*ptr && l)
;361:	{
line 362
;362:		if (*ptr == '-')
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 45
NEI4 $166
line 363
;363:			frame = STAT_MINUS;
ADDRLP4 8
CNSTI4 10
ASGNI4
ADDRGP4 $167
JUMPV
LABELV $166
line 365
;364:		else
;365:			frame = *ptr -'0';
ADDRLP4 8
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
ASGNI4
LABELV $167
line 368
;366:
;367:
;368:		CG_DrawPic( x, y, CHAR_WIDTH, CHAR_HEIGHT, cgs.media.numberShaders[frame] );
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1107296256
ARGF4
CNSTF4 1111490560
ARGF4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+156680+356
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 369
;369:		x += CHAR_WIDTH;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 32
ADDI4
ASGNI4
line 371
;370:		
;371:		ptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 372
;372:		l--;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 373
;373:	}
LABELV $164
line 360
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 36
INDIRI4
EQI4 $170
ADDRLP4 4
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $163
LABELV $170
line 374
;374:}
LABELV $129
endproc CG_DrawField 56 20
export CG_Draw3DModel
proc CG_Draw3DModel 512 16
line 383
;375:#endif // MISSIONPACK
;376:
;377:/*
;378:================
;379:CG_Draw3DModel
;380:
;381:================
;382:*/
;383:void CG_Draw3DModel( float x, float y, float w, float h, qhandle_t model, qhandle_t skin, vec3_t origin, vec3_t angles ) {
line 387
;384:	refdef_t		refdef;
;385:	refEntity_t		ent;
;386:
;387:	if ( !cg_draw3dIcons.integer || !cg_drawIcons.integer ) {
ADDRLP4 508
CNSTI4 0
ASGNI4
ADDRGP4 cg_draw3dIcons+12
INDIRI4
ADDRLP4 508
INDIRI4
EQI4 $176
ADDRGP4 cg_drawIcons+12
INDIRI4
ADDRLP4 508
INDIRI4
NEI4 $172
LABELV $176
line 388
;388:		return;
ADDRGP4 $171
JUMPV
LABELV $172
line 391
;389:	}
;390:
;391:	CG_AdjustFrom640( &x, &y, &w, &h );
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRFP4 8
ARGP4
ADDRFP4 12
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 393
;392:
;393:	memset( &refdef, 0, sizeof( refdef ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 368
ARGI4
ADDRGP4 memset
CALLP4
pop
line 395
;394:
;395:	memset( &ent, 0, sizeof( ent ) );
ADDRLP4 368
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 396
;396:	AnglesToAxis( angles, ent.axis );
ADDRFP4 28
INDIRP4
ARGP4
ADDRLP4 368+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 397
;397:	VectorCopy( origin, ent.origin );
ADDRLP4 368+68
ADDRFP4 24
INDIRP4
INDIRB
ASGNB 12
line 398
;398:	ent.hModel = model;
ADDRLP4 368+8
ADDRFP4 16
INDIRI4
ASGNI4
line 399
;399:	ent.customSkin = skin;
ADDRLP4 368+108
ADDRFP4 20
INDIRI4
ASGNI4
line 400
;400:	ent.renderfx = RF_NOSHADOW;		// no stencil shadows
ADDRLP4 368+4
CNSTI4 64
ASGNI4
line 402
;401:
;402:	refdef.rdflags = RDF_NOWORLDMODEL;
ADDRLP4 0+76
CNSTI4 1
ASGNI4
line 404
;403:
;404:	AxisClear( refdef.viewaxis );
ADDRLP4 0+36
ARGP4
ADDRGP4 AxisClear
CALLV
pop
line 406
;405:
;406:	refdef.fov_x = 30;
ADDRLP4 0+16
CNSTF4 1106247680
ASGNF4
line 407
;407:	refdef.fov_y = 30;
ADDRLP4 0+20
CNSTF4 1106247680
ASGNF4
line 409
;408:
;409:	refdef.x = x;
ADDRLP4 0
ADDRFP4 0
INDIRF4
CVFI4 4
ASGNI4
line 410
;410:	refdef.y = y;
ADDRLP4 0+4
ADDRFP4 4
INDIRF4
CVFI4 4
ASGNI4
line 411
;411:	refdef.width = w;
ADDRLP4 0+8
ADDRFP4 8
INDIRF4
CVFI4 4
ASGNI4
line 412
;412:	refdef.height = h;
ADDRLP4 0+12
ADDRFP4 12
INDIRF4
CVFI4 4
ASGNI4
line 414
;413:
;414:	refdef.time = cg.time;
ADDRLP4 0+72
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 416
;415:
;416:	trap_R_ClearScene();
ADDRGP4 trap_R_ClearScene
CALLV
pop
line 417
;417:	trap_R_AddRefEntityToScene( &ent );
ADDRLP4 368
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 418
;418:	trap_R_RenderScene( &refdef );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_RenderScene
CALLV
pop
line 419
;419:}
LABELV $171
endproc CG_Draw3DModel 512 16
export CG_Draw3DHeadModel
proc CG_Draw3DHeadModel 528 20
line 427
;420:
;421:/*
;422:================
;423:CG_Draw3DHeadModel
;424:PM Skin head/color loading
;425:================
;426:*/
;427:void CG_Draw3DHeadModel( float x, float y, float w, float h, qhandle_t model, qhandle_t skin, vec3_t origin, vec3_t angles, int clientNum ) {
line 432
;428:	refdef_t		refdef;
;429:	refEntity_t		ent;
;430:	clientInfo_t	*ci;
;431:
;432:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 508
CNSTI4 1776
ADDRFP4 32
INDIRI4
MULI4
ADDRGP4 cgs+40960
ADDP4
ASGNP4
line 434
;433:
;434:	if ( cg_draw3dIcons.integer ) {
ADDRGP4 cg_draw3dIcons+12
INDIRI4
CNSTI4 0
EQI4 $193
line 435
;435:		CG_AdjustFrom640( &x, &y, &w, &h );
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRFP4 8
ARGP4
ADDRFP4 12
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 437
;436:
;437:		memset( &refdef, 0, sizeof( refdef ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 368
ARGI4
ADDRGP4 memset
CALLP4
pop
line 439
;438:
;439:		memset( &ent, 0, sizeof( ent ) );
ADDRLP4 368
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 440
;440:		AnglesToAxis( angles, ent.axis );
ADDRFP4 28
INDIRP4
ARGP4
ADDRLP4 368+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 442
;441:
;442:			if (clientNum == cg.clientNum) {
ADDRFP4 32
INDIRI4
ADDRGP4 cg+4
INDIRI4
NEI4 $197
line 443
;443:				memcpy(ent.shaderRGBA, &cgs.clientinfo[cg.clientNum].colors[1], sizeof(ent.shaderRGBA));
ADDRLP4 368+116
ARGP4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+92+4
ADDP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 444
;444:			} else if (cg_forceColors.integer && cgs.clientinfo[cg.clientNum].team == ci->team && cgs.gametype >= GT_TEAM) {
ADDRGP4 $198
JUMPV
LABELV $197
ADDRGP4 cg_forceColors+12
INDIRI4
CNSTI4 0
EQI4 $206
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
ADDRLP4 508
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
NEI4 $206
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $206
line 445
;445:				memcpy(ent.shaderRGBA, &cgs.clientinfo[cg.clientNum].colors[1], sizeof(ent.shaderRGBA));
ADDRLP4 368+116
ARGP4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+92+4
ADDP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 446
;446:			} else if (strlen(cg_TeamColors.string) >= 3 && cgs.clientinfo[cg.clientNum].team == ci->team && cgs.gametype >= GT_TEAM) {
ADDRGP4 $207
JUMPV
LABELV $206
ADDRGP4 cg_TeamColors+16
ARGP4
ADDRLP4 512
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 516
CNSTI4 3
ASGNI4
ADDRLP4 512
INDIRI4
ADDRLP4 516
INDIRI4
LTI4 $219
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
ADDRLP4 508
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
NEI4 $219
ADDRGP4 cgs+31456
INDIRI4
ADDRLP4 516
INDIRI4
LTI4 $219
line 447
;447:				memcpy(ent.shaderRGBA, &cgs.teamColors[1], sizeof(ent.shaderRGBA));
ADDRLP4 368+116
ARGP4
ADDRGP4 cgs+157840+4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 448
;448:			} else if (strlen(cg_EnemyColors.string) >= 3 && (cgs.clientinfo[cg.clientNum].team != ci->team || cgs.gametype < GT_TEAM) ) {
ADDRGP4 $220
JUMPV
LABELV $219
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 520
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 524
CNSTI4 3
ASGNI4
ADDRLP4 520
INDIRI4
ADDRLP4 524
INDIRI4
LTI4 $230
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
ADDRLP4 508
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
NEI4 $237
ADDRGP4 cgs+31456
INDIRI4
ADDRLP4 524
INDIRI4
GEI4 $230
LABELV $237
line 449
;449:				memcpy(ent.shaderRGBA, &cgs.enemyColors[1], sizeof(ent.shaderRGBA));
ADDRLP4 368+116
ARGP4
ADDRGP4 cgs+157820+4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 450
;450:			} else {
ADDRGP4 $231
JUMPV
LABELV $230
line 451
;451:				memcpy(ent.shaderRGBA, &ci->colors[1], sizeof(ent.shaderRGBA));
ADDRLP4 368+116
ARGP4
ADDRLP4 508
INDIRP4
CNSTI4 96
ADDP4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 452
;452:			}
LABELV $231
LABELV $220
LABELV $207
LABELV $198
line 454
;453:
;454:		VectorCopy( origin, ent.origin );
ADDRLP4 368+68
ADDRFP4 24
INDIRP4
INDIRB
ASGNB 12
line 455
;455:		ent.hModel = model;
ADDRLP4 368+8
ADDRFP4 16
INDIRI4
ASGNI4
line 456
;456:		ent.customSkin = skin;
ADDRLP4 368+108
ADDRFP4 20
INDIRI4
ASGNI4
line 457
;457:		ent.renderfx = RF_NOSHADOW;		// no stencil shadows
ADDRLP4 368+4
CNSTI4 64
ASGNI4
line 459
;458:
;459:		refdef.rdflags = RDF_NOWORLDMODEL;
ADDRLP4 0+76
CNSTI4 1
ASGNI4
line 461
;460:
;461:		AxisClear( refdef.viewaxis );
ADDRLP4 0+36
ARGP4
ADDRGP4 AxisClear
CALLV
pop
line 463
;462:
;463:		refdef.fov_x = 30;
ADDRLP4 0+16
CNSTF4 1106247680
ASGNF4
line 464
;464:		refdef.fov_y = 30;
ADDRLP4 0+20
CNSTF4 1106247680
ASGNF4
line 466
;465:
;466:		refdef.x = x;
ADDRLP4 0
ADDRFP4 0
INDIRF4
CVFI4 4
ASGNI4
line 467
;467:		refdef.y = y;
ADDRLP4 0+4
ADDRFP4 4
INDIRF4
CVFI4 4
ASGNI4
line 468
;468:		refdef.width = w;
ADDRLP4 0+8
ADDRFP4 8
INDIRF4
CVFI4 4
ASGNI4
line 469
;469:		refdef.height = h;
ADDRLP4 0+12
ADDRFP4 12
INDIRF4
CVFI4 4
ASGNI4
line 471
;470:
;471:		refdef.time = cg.time;
ADDRLP4 0+72
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 473
;472:
;473:		trap_R_ClearScene();
ADDRGP4 trap_R_ClearScene
CALLV
pop
line 474
;474:		trap_R_AddRefEntityToScene( &ent );
ADDRLP4 368
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 475
;475:		trap_R_RenderScene( &refdef );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_RenderScene
CALLV
pop
line 476
;476:	} else if ( cg_drawIcons.integer ) {
ADDRGP4 $194
JUMPV
LABELV $193
ADDRGP4 cg_drawIcons+12
INDIRI4
CNSTI4 0
EQI4 $257
line 477
;477:		CG_DrawPic( x, y, w, h, ci->modelIcon );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 508
INDIRP4
CNSTI4 600
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 478
;478:	}
LABELV $257
LABELV $194
line 481
;479:
;480:			// if they are deferred, draw a cross out
;481:	if ( ci->deferred ) {
ADDRLP4 508
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
CNSTI4 0
EQI4 $260
line 482
;482:		CG_DrawPic( x, y, w, h, cgs.media.deferShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 cgs+156680+184
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 488
;483://freeze
;484:		//Add a Frozen text draw here instead
;485:	//} else if ( g_gamemode.integer > 3 && Q_Isfreeze( clientNum ) ) {
;486:	//	CG_DrawPic( x, y, w, h, cgs.media.noammoShader );
;487://freeze
;488:	}
LABELV $260
line 489
;489:}
LABELV $191
endproc CG_Draw3DHeadModel 528 20
export CG_DrawHead
proc CG_DrawHead 56 44
line 557
;490:
;491:/*
;492:================
;493:CG_Draw3DFlagModel
;494:
;495:================
;496:*/ /*
;497:void CG_Draw3DFlagModel( float x, float y, float w, float h, qhandle_t model, qhandle_t skin, vec3_t origin, vec3_t angles, int team ) {
;498:	refdef_t		refdef;
;499:	refEntity_t		ent;
;500:
;501:	if ( !cg_draw3dIcons.integer || !cg_drawIcons.integer ) {
;502:		return;
;503:	}
;504:
;505:	CG_AdjustFrom640( &x, &y, &w, &h );
;506:
;507:	memset( &refdef, 0, sizeof( refdef ) );
;508:
;509:	memset( &ent, 0, sizeof( ent ) );
;510:	AnglesToAxis( angles, ent.axis );
;511:
;512:		/* set colors here */ /*
;513:	if ( cg_adjustTeamColors.integer && team == cgs.clientinfo[cg.clientNum].team && cg_forceColors.integer && cgs.clientinfo[cg.clientNum].team != TEAM_SPECTATOR ) {
;514:		memcpy(ent.shaderRGBA, &cgs.clientinfo[cg.clientNum].colors[cg_adjustTeamColors.integer - 1], sizeof(ent.shaderRGBA));
;515:	} else if ( cg_adjustTeamColors.integer && team == cgs.clientinfo[cg.clientNum].team && cgs.clientinfo[cg.clientNum].team != TEAM_SPECTATOR ) {
;516:		memcpy(ent.shaderRGBA, &cgs.teamColors[cg_adjustTeamColors.integer - 1], sizeof(ent.shaderRGBA));
;517:	} else if ( cg_adjustTeamColors.integer && team != cgs.clientinfo[cg.clientNum].team && cgs.clientinfo[cg.clientNum].team != TEAM_SPECTATOR ) {
;518:		memcpy(ent.shaderRGBA, &cgs.enemyColors[cg_adjustTeamColors.integer - 1], sizeof(ent.shaderRGBA));
;519:	} else if ( team == TEAM_RED ) {
;520:		memcpy(ent.shaderRGBA, colorRed, sizeof(ent.shaderRGBA));
;521:	} else if ( team == TEAM_BLUE ) {
;522:		memcpy(ent.shaderRGBA, colorBlue, sizeof(ent.shaderRGBA));
;523:	}
;524:
;525:
;526:	VectorCopy( origin, ent.origin );
;527:	ent.hModel = model;
;528:	ent.customSkin = skin;
;529:	ent.renderfx = RF_NOSHADOW;		// no stencil shadows
;530:
;531:	refdef.rdflags = RDF_NOWORLDMODEL;
;532:
;533:	AxisClear( refdef.viewaxis );
;534:
;535:	refdef.fov_x = 30;
;536:	refdef.fov_y = 30;
;537:
;538:	refdef.x = x;
;539:	refdef.y = y;
;540:	refdef.width = w;
;541:	refdef.height = h;
;542:
;543:	refdef.time = cg.time;
;544:
;545:	trap_R_ClearScene();
;546:	trap_R_AddRefEntityToScene( &ent );
;547:	trap_R_RenderScene( &refdef );
;548:} */
;549:
;550:/*
;551:================
;552:CG_DrawHead
;553:
;554:Used for both the status bar and the scoreboard
;555:================
;556:*/
;557:void CG_DrawHead( float x, float y, float w, float h, int clientNum, vec3_t headAngles ) {
line 564
;558:	clipHandle_t	cm;
;559:	clientInfo_t	*ci;
;560:	float			len;
;561:	vec3_t			origin;
;562:	vec3_t			mins, maxs;
;563:
;564:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 0
CNSTI4 1776
ADDRFP4 16
INDIRI4
MULI4
ADDRGP4 cgs+40960
ADDP4
ASGNP4
line 566
;565:
;566:	if ( cg_draw3dIcons.integer ) {
ADDRGP4 cg_draw3dIcons+12
INDIRI4
CNSTI4 0
EQI4 $266
line 567
;567:		cm = ci->headModel;
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 592
ADDP4
INDIRI4
ASGNI4
line 568
;568:		if ( !cm ) {
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $269
line 569
;569:			return;
ADDRGP4 $264
JUMPV
LABELV $269
line 573
;570:		}
;571:
;572:		// offset the origin y and z to center the head
;573:		trap_R_ModelBounds( cm, mins, maxs );
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRLP4 28
ARGP4
ADDRGP4 trap_R_ModelBounds
CALLV
pop
line 575
;574:
;575:		origin[2] = -0.5 * ( mins[2] + maxs[2] );
ADDRLP4 4+8
CNSTF4 3204448256
ADDRLP4 16+8
INDIRF4
ADDRLP4 28+8
INDIRF4
ADDF4
MULF4
ASGNF4
line 576
;576:		origin[1] = 0.5 * ( mins[1] + maxs[1] );
ADDRLP4 4+4
CNSTF4 1056964608
ADDRLP4 16+4
INDIRF4
ADDRLP4 28+4
INDIRF4
ADDF4
MULF4
ASGNF4
line 580
;577:
;578:		// calculate distance so the head nearly fills the box
;579:		// assume heads are taller than wide
;580:		len = 0.7 * ( maxs[2] - mins[2] );		
ADDRLP4 44
CNSTF4 1060320051
ADDRLP4 28+8
INDIRF4
ADDRLP4 16+8
INDIRF4
SUBF4
MULF4
ASGNF4
line 581
;581:		origin[0] = len / 0.268;	// len / tan( fov/2 )
ADDRLP4 4
ADDRLP4 44
INDIRF4
CNSTF4 1049179980
DIVF4
ASGNF4
line 584
;582:
;583:		// allow per-model tweaking
;584:		VectorAdd( origin, ci->headOffset, origin );
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 4+4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 560
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 564
ADDP4
INDIRF4
ADDF4
ASGNF4
line 588
;585:
;586:		//CG_Draw3DModel( x, y, w, h, head.hModel, head.customSkin, origin, headAngles );
;587:		//PM Skin apply the colors in the scoreboard and statusbar -- This could be part of the original function
;588:		CG_Draw3DHeadModel( x, y, w, h, ci->headModel, ci->headSkin, origin, headAngles, clientNum );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 592
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 596
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 CG_Draw3DHeadModel
CALLV
pop
line 589
;589:	} else if ( cg_drawIcons.integer ) {
ADDRGP4 $267
JUMPV
LABELV $266
ADDRGP4 cg_drawIcons+12
INDIRI4
CNSTI4 0
EQI4 $283
line 590
;590:		CG_DrawPic( x, y, w, h, ci->modelIcon );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 600
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 591
;591:	}
LABELV $283
LABELV $267
line 594
;592:
;593:		// if they are deferred, draw a cross out
;594:	if ( ci->deferred ) {
ADDRLP4 0
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
CNSTI4 0
EQI4 $286
line 595
;595:		CG_DrawPic( x, y, w, h, cgs.media.deferShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 cgs+156680+184
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 598
;596://freeze
;597:		//Add a Frozen text draw here instead
;598:	} else if ( g_gamemode.integer > 3 && Q_Isfreeze( clientNum ) ) {
ADDRGP4 $287
JUMPV
LABELV $286
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $290
ADDRFP4 16
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 Q_Isfreeze
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $290
line 600
;599:		//CG_DrawPic( x, y, w, h, cgs.media.noammoShader );(y+((h*.5)-6))
;600:		CG_DrawStringExt( x, y, "Frozen", colorCyan, qfalse, qfalse, 10, 12, 0, w, -1 );
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRFP4 4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 $293
ARGP4
ADDRGP4 colorCyan
ARGP4
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
CNSTI4 10
ARGI4
CNSTI4 12
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRFP4 8
INDIRF4
CVFI4 4
ARGI4
CNSTI4 -1
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 602
;601://freeze
;602:	}
LABELV $290
LABELV $287
line 603
;603:}
LABELV $264
endproc CG_DrawHead 56 44
export CG_DrawFlagModel
proc CG_DrawFlagModel 72 32
line 612
;604:
;605:/*
;606:================
;607:CG_DrawFlagModel
;608:
;609:Used for both the status bar and the scoreboard
;610:================
;611:*/
;612:void CG_DrawFlagModel( float x, float y, float w, float h, int team, qboolean force2D ) {
line 619
;613:	qhandle_t		cm;
;614:	float			len;
;615:	vec3_t			origin, angles;
;616:	vec3_t			mins, maxs;
;617:	qhandle_t		handle;
;618:
;619:	if ( !force2D && cg_draw3dIcons.integer ) {
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRFP4 20
INDIRI4
ADDRLP4 60
INDIRI4
NEI4 $295
ADDRGP4 cg_draw3dIcons+12
INDIRI4
ADDRLP4 60
INDIRI4
EQI4 $295
line 621
;620:
;621:		VectorClear( angles );
ADDRLP4 64
CNSTF4 0
ASGNF4
ADDRLP4 0+8
ADDRLP4 64
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 64
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 64
INDIRF4
ASGNF4
line 623
;622:
;623:		cm = cgs.media.redFlagModel;
ADDRLP4 48
ADDRGP4 cgs+156680+56
INDIRI4
ASGNI4
line 626
;624:
;625:		// offset the origin y and z to center the flag
;626:		trap_R_ModelBounds( cm, mins, maxs );
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRLP4 36
ARGP4
ADDRGP4 trap_R_ModelBounds
CALLV
pop
line 628
;627:
;628:		origin[2] = -0.5 * ( mins[2] + maxs[2] );
ADDRLP4 12+8
CNSTF4 3204448256
ADDRLP4 24+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDF4
MULF4
ASGNF4
line 629
;629:		origin[1] = 0.5 * ( mins[1] + maxs[1] );
ADDRLP4 12+4
CNSTF4 1056964608
ADDRLP4 24+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDF4
MULF4
ASGNF4
line 633
;630:
;631:		// calculate distance so the flag nearly fills the box
;632:		// assume heads are taller than wide
;633:		len = 0.5 * ( maxs[2] - mins[2] );		
ADDRLP4 52
CNSTF4 1056964608
ADDRLP4 36+8
INDIRF4
ADDRLP4 24+8
INDIRF4
SUBF4
MULF4
ASGNF4
line 634
;634:		origin[0] = len / 0.268;	// len / tan( fov/2 )
ADDRLP4 12
ADDRLP4 52
INDIRF4
CNSTF4 1049179980
DIVF4
ASGNF4
line 636
;635:
;636:		angles[YAW] = 60 * sin( cg.time / 2000.0 );;
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
CNSTF4 1157234688
DIVF4
ARGF4
ADDRLP4 68
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0+4
CNSTF4 1114636288
ADDRLP4 68
INDIRF4
MULF4
ASGNF4
line 638
;637:
;638:		if( team == TEAM_RED ) {
ADDRFP4 16
INDIRI4
CNSTI4 1
NEI4 $312
line 639
;639:			handle = cgs.media.redFlagModel;
ADDRLP4 56
ADDRGP4 cgs+156680+56
INDIRI4
ASGNI4
line 640
;640:		} else if( team == TEAM_BLUE ) {
ADDRGP4 $313
JUMPV
LABELV $312
ADDRFP4 16
INDIRI4
CNSTI4 2
NEI4 $316
line 641
;641:			handle = cgs.media.blueFlagModel;
ADDRLP4 56
ADDRGP4 cgs+156680+60
INDIRI4
ASGNI4
line 642
;642:		} else if( team == TEAM_FREE ) {
ADDRGP4 $317
JUMPV
LABELV $316
ADDRFP4 16
INDIRI4
CNSTI4 0
NEI4 $294
line 643
;643:			handle = cgs.media.neutralFlagModel;
ADDRLP4 56
ADDRGP4 cgs+156680+64
INDIRI4
ASGNI4
line 644
;644:		} else {
line 645
;645:			return;
LABELV $321
LABELV $317
LABELV $313
line 647
;646:		}
;647:		CG_Draw3DModel( x, y, w, h, handle, 0, origin, angles );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 56
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_Draw3DModel
CALLV
pop
line 649
;648:		//CG_Draw3DFlagModel( x, y, w, h, handle, 0, origin, angles, team );
;649:	} else if ( cg_drawIcons.integer ) {
ADDRGP4 $296
JUMPV
LABELV $295
ADDRGP4 cg_drawIcons+12
INDIRI4
CNSTI4 0
EQI4 $324
line 652
;650:		gitem_t *item;
;651:
;652:		if( team == TEAM_RED ) {
ADDRFP4 16
INDIRI4
CNSTI4 1
NEI4 $327
line 653
;653:			item = BG_FindItemForPowerup( PW_REDFLAG );
CNSTI4 7
ARGI4
ADDRLP4 68
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 64
ADDRLP4 68
INDIRP4
ASGNP4
line 654
;654:		} else if( team == TEAM_BLUE ) {
ADDRGP4 $328
JUMPV
LABELV $327
ADDRFP4 16
INDIRI4
CNSTI4 2
NEI4 $329
line 655
;655:			item = BG_FindItemForPowerup( PW_BLUEFLAG );
CNSTI4 8
ARGI4
ADDRLP4 68
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 64
ADDRLP4 68
INDIRP4
ASGNP4
line 656
;656:		} else if( team == TEAM_FREE ) {
ADDRGP4 $330
JUMPV
LABELV $329
ADDRFP4 16
INDIRI4
CNSTI4 0
NEI4 $294
line 657
;657:			item = BG_FindItemForPowerup( PW_NEUTRALFLAG );
CNSTI4 9
ARGI4
ADDRLP4 68
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 64
ADDRLP4 68
INDIRP4
ASGNP4
line 658
;658:		} else {
line 659
;659:			return;
LABELV $332
LABELV $330
LABELV $328
line 661
;660:		}
;661:		if (item) {
ADDRLP4 64
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $333
line 662
;662:		  CG_DrawPic( x, y, w, h, cg_items[ ITEM_INDEX(item) ].icon );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
CNSTI4 24
ADDRLP4 64
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
MULI4
ADDRGP4 cg_items+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 663
;663:		}
LABELV $333
line 664
;664:	}
LABELV $324
LABELV $296
line 665
;665:}
LABELV $294
endproc CG_DrawFlagModel 72 32
proc CG_DrawStatusBarHead 60 24
line 675
;666:
;667:/*
;668:================
;669:CG_DrawStatusBarHead
;670:
;671:================
;672:*/
;673:#ifndef MISSIONPACK
;674:
;675:static void CG_DrawStatusBarHead( float x ) {
line 681
;676:	vec3_t		angles;
;677:	playerState_t	*ps;
;678:	float		size, stretch;
;679:	float		frac;
;680:
;681:	ps = &cg.snap->ps;
ADDRLP4 24
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 683
;682:
;683:	VectorClear( angles );
ADDRLP4 28
CNSTF4 0
ASGNF4
ADDRLP4 4+8
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 28
INDIRF4
ASGNF4
line 685
;684:
;685:	if ( cg.damageTime && cg.time - cg.damageTime < DAMAGE_TIME ) {
ADDRGP4 cg+130840
INDIRF4
CNSTF4 0
EQF4 $340
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ADDRGP4 cg+130840
INDIRF4
SUBF4
CNSTF4 1140457472
GEF4 $340
line 686
;686:		frac = (float)(cg.time - cg.damageTime ) / DAMAGE_TIME;
ADDRLP4 0
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ADDRGP4 cg+130840
INDIRF4
SUBF4
CNSTF4 1140457472
DIVF4
ASGNF4
line 687
;687:		size = ICON_SIZE * 1.25 * ( 1.5 - frac * 0.5 );
ADDRLP4 16
CNSTF4 1114636288
CNSTF4 1069547520
CNSTF4 1056964608
ADDRLP4 0
INDIRF4
MULF4
SUBF4
MULF4
ASGNF4
line 689
;688:
;689:		stretch = size - ICON_SIZE * 1.25;
ADDRLP4 20
ADDRLP4 16
INDIRF4
CNSTF4 1114636288
SUBF4
ASGNF4
line 691
;690:		// kick in the direction of damage
;691:		x -= stretch * 0.5 + cg.damageX * stretch * 0.5;
ADDRLP4 32
CNSTF4 1056964608
ASGNF4
ADDRLP4 36
ADDRLP4 20
INDIRF4
ASGNF4
ADDRFP4 0
ADDRFP4 0
INDIRF4
ADDRLP4 32
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ADDRLP4 32
INDIRF4
ADDRGP4 cg+130844
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
MULF4
ADDF4
SUBF4
ASGNF4
line 693
;692:
;693:		cg.headStartYaw = 180 + cg.damageX * 45;
ADDRGP4 cg+130876
CNSTF4 1110704128
ADDRGP4 cg+130844
INDIRF4
MULF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 695
;694:
;695:		cg.headEndYaw = 180 + 20 * cos( crandom()*M_PI );
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
CNSTF4 1078530011
CNSTF4 1073741824
ADDRLP4 40
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
ARGF4
ADDRLP4 44
ADDRGP4 cos
CALLF4
ASGNF4
ADDRGP4 cg+130864
CNSTF4 1101004800
ADDRLP4 44
INDIRF4
MULF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 696
;696:		cg.headEndPitch = 5 * cos( crandom()*M_PI );
ADDRLP4 48
ADDRGP4 rand
CALLI4
ASGNI4
CNSTF4 1078530011
CNSTF4 1073741824
ADDRLP4 48
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
ARGF4
ADDRLP4 52
ADDRGP4 cos
CALLF4
ASGNF4
ADDRGP4 cg+130860
CNSTF4 1084227584
ADDRLP4 52
INDIRF4
MULF4
ASGNF4
line 698
;697:
;698:		cg.headStartTime = cg.time;
ADDRGP4 cg+130880
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 699
;699:		cg.headEndTime = cg.time + 100 + random() * 2000;
ADDRLP4 56
ADDRGP4 rand
CALLI4
ASGNI4
ADDRGP4 cg+130868
ADDRGP4 cg+107604
INDIRI4
CNSTI4 100
ADDI4
CVIF4 4
CNSTF4 1157234688
ADDRLP4 56
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
line 700
;700:	} else {
ADDRGP4 $341
JUMPV
LABELV $340
line 701
;701:		if ( cg.time >= cg.headEndTime ) {
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+130868
INDIRI4
LTI4 $356
line 703
;702:			// select a new head angle
;703:			cg.headStartYaw = cg.headEndYaw;
ADDRGP4 cg+130876
ADDRGP4 cg+130864
INDIRF4
ASGNF4
line 704
;704:			cg.headStartPitch = cg.headEndPitch;
ADDRGP4 cg+130872
ADDRGP4 cg+130860
INDIRF4
ASGNF4
line 705
;705:			cg.headStartTime = cg.headEndTime;
ADDRGP4 cg+130880
ADDRGP4 cg+130868
INDIRI4
ASGNI4
line 706
;706:			cg.headEndTime = cg.time + 100 + random() * 2000;
ADDRLP4 32
ADDRGP4 rand
CALLI4
ASGNI4
ADDRGP4 cg+130868
ADDRGP4 cg+107604
INDIRI4
CNSTI4 100
ADDI4
CVIF4 4
CNSTF4 1157234688
ADDRLP4 32
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
line 708
;707:			
;708:			if (ps->stats[STAT_HEALTH] > 0) {
ADDRLP4 24
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LEI4 $368
line 709
;709:			cg.headEndYaw = 180 + 20 * cos( crandom()*M_PI );
ADDRLP4 36
ADDRGP4 rand
CALLI4
ASGNI4
CNSTF4 1078530011
CNSTF4 1073741824
ADDRLP4 36
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
ARGF4
ADDRLP4 40
ADDRGP4 cos
CALLF4
ASGNF4
ADDRGP4 cg+130864
CNSTF4 1101004800
ADDRLP4 40
INDIRF4
MULF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 710
;710:			cg.headEndPitch = 5 * cos( crandom()*M_PI );
ADDRLP4 44
ADDRGP4 rand
CALLI4
ASGNI4
CNSTF4 1078530011
CNSTF4 1073741824
ADDRLP4 44
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
ARGF4
ADDRLP4 48
ADDRGP4 cos
CALLF4
ASGNF4
ADDRGP4 cg+130860
CNSTF4 1084227584
ADDRLP4 48
INDIRF4
MULF4
ASGNF4
line 711
;711:			}
LABELV $368
line 712
;712:		}
LABELV $356
line 714
;713:
;714:		size = ICON_SIZE * 1.25;
ADDRLP4 16
CNSTF4 1114636288
ASGNF4
line 715
;715:	}
LABELV $341
line 718
;716:
;717:	// if the server was frozen for a while we may have a bad head start time
;718:	if ( cg.headStartTime > cg.time ) {
ADDRGP4 cg+130880
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $372
line 719
;719:		cg.headStartTime = cg.time;
ADDRGP4 cg+130880
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 720
;720:	}
LABELV $372
line 722
;721:
;722:	frac = ( cg.time - cg.headStartTime ) / (float)( cg.headEndTime - cg.headStartTime );
ADDRLP4 0
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+130880
INDIRI4
SUBI4
CVIF4 4
ADDRGP4 cg+130868
INDIRI4
ADDRGP4 cg+130880
INDIRI4
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 723
;723:	frac = frac * frac * ( 3 - 2 * frac );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1077936128
CNSTF4 1073741824
ADDRLP4 0
INDIRF4
MULF4
SUBF4
MULF4
ASGNF4
line 724
;724:	angles[YAW] = cg.headStartYaw + ( cg.headEndYaw - cg.headStartYaw ) * frac;
ADDRLP4 4+4
ADDRGP4 cg+130876
INDIRF4
ADDRGP4 cg+130864
INDIRF4
ADDRGP4 cg+130876
INDIRF4
SUBF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 725
;725:	angles[PITCH] = cg.headStartPitch + ( cg.headEndPitch - cg.headStartPitch ) * frac;
ADDRLP4 4
ADDRGP4 cg+130872
INDIRF4
ADDRGP4 cg+130860
INDIRF4
ADDRGP4 cg+130872
INDIRF4
SUBF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 727
;726:
;727:	CG_DrawHead( x, 480 - size, size, size, 
ADDRFP4 0
INDIRF4
ARGF4
CNSTF4 1139802112
ADDRLP4 16
INDIRF4
SUBF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 CG_DrawHead
CALLV
pop
line 729
;728:				cg.snap->ps.clientNum, angles );
;729:}
LABELV $336
endproc CG_DrawStatusBarHead 60 24
proc CG_DrawStatusBarFlag 4 24
line 739
;730:#endif // MISSIONPACK
;731:
;732:/*
;733:================
;734:CG_DrawStatusBarFlag
;735:
;736:================
;737:*/
;738:#ifndef MISSIONPACK
;739:static void CG_DrawStatusBarFlag( float x, int team ) {
line 740
;740:	CG_DrawFlagModel( x, 480 - ICON_SIZE, ICON_SIZE, ICON_SIZE, team, qfalse );
ADDRFP4 0
INDIRF4
ARGF4
CNSTF4 1138229248
ARGF4
ADDRLP4 0
CNSTF4 1111490560
ASGNF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawFlagModel
CALLV
pop
line 741
;741:}
LABELV $390
endproc CG_DrawStatusBarFlag 4 24
export CG_DrawTeamBackground
proc CG_DrawTeamBackground 24 20
line 752
;742:#endif // MISSIONPACK
;743:
;744:/*
;745:================
;746:CG_DrawTeamBackground
;747:
;748:================
;749:*/ /* We aren't using this anymore for the status bar.
;750:	Just the scoreboard*/
;751:void CG_DrawTeamBackground( int x, int y, int w, int h, float alpha, int team )
;752:{
line 755
;753:	vec4_t		hcolor;
;754:
;755:	hcolor[3] = alpha;
ADDRLP4 0+12
ADDRFP4 16
INDIRF4
ASGNF4
line 756
;756:	if ( cgs.gametype >= GT_TEAM && cg_adjustTeamColors.integer && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR ) {
ADDRLP4 16
CNSTI4 3
ASGNI4
ADDRGP4 cgs+31456
INDIRI4
ADDRLP4 16
INDIRI4
LTI4 $393
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
CNSTI4 0
EQI4 $393
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $393
line 757
;757:		if ( team != cgs.clientinfo[ cg.clientNum ].team ) {
ADDRFP4 20
INDIRI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
EQI4 $400
line 758
;758:			memcpy(hcolor, g_color_table[ ColorIndex( cg_EnemyColors.string[cg_adjustTeamColors.integer - 1] ) ], sizeof(hcolor));
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 cg_EnemyColors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 20
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 0
ARGP4
ADDRLP4 20
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
line 759
;759:		} else {
ADDRGP4 $394
JUMPV
LABELV $400
line 760
;760:			memcpy(hcolor, g_color_table[ ColorIndex( cg_TeamColors.string[cg_adjustTeamColors.integer - 1] ) ], sizeof(hcolor));
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 cg_TeamColors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 20
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 0
ARGP4
ADDRLP4 20
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
line 761
;761:		}
line 762
;762:	} else if ( team == TEAM_RED ) {
ADDRGP4 $394
JUMPV
LABELV $393
ADDRFP4 20
INDIRI4
CNSTI4 1
NEI4 $411
line 763
;763:		hcolor[0] = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 764
;764:		hcolor[1] = 0;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 765
;765:		hcolor[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 766
;766:	} else if ( team == TEAM_BLUE ) {
ADDRGP4 $412
JUMPV
LABELV $411
ADDRFP4 20
INDIRI4
CNSTI4 2
NEI4 $391
line 767
;767:		hcolor[0] = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 768
;768:		hcolor[1] = 0;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 769
;769:		hcolor[2] = 1;
ADDRLP4 0+8
CNSTF4 1065353216
ASGNF4
line 770
;770:	} else {
line 771
;771:		return;
LABELV $416
LABELV $412
LABELV $394
line 773
;772:	}
;773:	hcolor[3] = alpha;
ADDRLP4 0+12
ADDRFP4 16
INDIRF4
ASGNF4
line 774
;774:	trap_R_SetColor( hcolor );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 775
;775:	CG_DrawPic( x, y, w, h, cgs.media.teamStatusBar );
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 cgs+156680+180
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 776
;776:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 777
;777:}
LABELV $391
endproc CG_DrawTeamBackground 24 20
data
align 4
LABELV $423
byte 4 1065353216
byte 4 1060152279
byte 4 0
byte 4 1065353216
byte 4 1065353216
byte 4 1045220557
byte 4 1045220557
byte 4 1065353216
byte 4 1056964608
byte 4 1056964608
byte 4 1056964608
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
code
proc CG_DrawStatusBar 80 32
line 786
;778:
;779:/*
;780:================
;781:CG_DrawStatusBar
;782:
;783:================
;784:*/
;785:#ifndef MISSIONPACK
;786:static void CG_DrawStatusBar() {
line 804
;787:	int			color;
;788:	centity_t	*cent;
;789:	playerState_t	*ps;
;790:	int			value;
;791:	vec4_t		hcolor;
;792:	vec3_t		angles;
;793:	vec3_t		origin;
;794:#ifdef MISSIONPACK
;795:	qhandle_t	handle;
;796:#endif
;797:	static float colors[4][4] = { 
;798://		{ 0.2, 1.0, 0.2, 1.0 } , { 1.0, 0.2, 0.2, 1.0 }, {0.5, 0.5, 0.5, 1} };
;799:		{ 1.0f, 0.69f, 0.0f, 1.0f },    // normal
;800:		{ 1.0f, 0.2f, 0.2f, 1.0f },     // low health
;801:		{ 0.5f, 0.5f, 0.5f, 1.0f },     // weapon firing
;802:		{ 1.0f, 1.0f, 1.0f, 1.0f } };   // health > 100
;803:
;804:	if ( cg_drawStatus.integer == 0 ) {
ADDRGP4 cg_drawStatus+12
INDIRI4
CNSTI4 0
NEI4 $424
line 805
;805:		return;
ADDRGP4 $422
JUMPV
LABELV $424
line 811
;806:	}
;807:
;808:	// draw the team background
;809:	//CG_DrawTeamBackground( 0, 420, 640, 60, 0.33f, cg.snap->ps.persistant[PERS_TEAM] );
;810:
;811:	cent = &cg_entities[cg.snap->ps.clientNum];
ADDRLP4 8
CNSTI4 728
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 812
;812:	ps = &cg.snap->ps;
ADDRLP4 4
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 814
;813:
;814:	VectorClear( angles );
ADDRLP4 56
CNSTF4 0
ASGNF4
ADDRLP4 12+8
ADDRLP4 56
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 56
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 56
INDIRF4
ASGNF4
line 817
;815:
;816:	// draw any 3D icons first, so the changes back to 2D are minimized
;817:	if ( cent->currentState.weapon && cg_weapons[ cent->currentState.weapon ].ammoModel ) {
ADDRLP4 60
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
ADDRLP4 64
CNSTI4 0
ASGNI4
ADDRLP4 60
INDIRI4
ADDRLP4 64
INDIRI4
EQI4 $431
CNSTI4 136
ADDRLP4 60
INDIRI4
MULI4
ADDRGP4 cg_weapons+76
ADDP4
INDIRI4
ADDRLP4 64
INDIRI4
EQI4 $431
line 818
;818:		origin[0] = 70;
ADDRLP4 24
CNSTF4 1116471296
ASGNF4
line 819
;819:		origin[1] = 0;
ADDRLP4 24+4
CNSTF4 0
ASGNF4
line 820
;820:		origin[2] = 0;
ADDRLP4 24+8
CNSTF4 0
ASGNF4
line 821
;821:		angles[YAW] = 90 + 20 * sin( cg.time / 1000.0 );
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
CNSTF4 1148846080
DIVF4
ARGF4
ADDRLP4 68
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 12+4
CNSTF4 1101004800
ADDRLP4 68
INDIRF4
MULF4
CNSTF4 1119092736
ADDF4
ASGNF4
line 822
;822:		CG_Draw3DModel( CHAR_WIDTH*3 + TEXT_ICON_SPACE, 432, ICON_SIZE, ICON_SIZE,
CNSTF4 1120403456
ARGF4
CNSTF4 1138229248
ARGF4
ADDRLP4 72
CNSTF4 1111490560
ASGNF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRLP4 72
INDIRF4
ARGF4
CNSTI4 136
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons+76
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 24
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 CG_Draw3DModel
CALLV
pop
line 824
;823:					   cg_weapons[ cent->currentState.weapon ].ammoModel, 0, origin, angles );
;824:	}
LABELV $431
line 826
;825:	
;826:	CG_DrawStatusBarHead( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE );
CNSTF4 1133412352
ARGF4
ADDRGP4 CG_DrawStatusBarHead
CALLV
pop
line 829
;827:
;828:	//This gets drawn as a powerup in the superhud
;829:	if( cg.predictedPlayerState.powerups[PW_REDFLAG] ) {
ADDRGP4 cg+107636+312+28
INDIRI4
CNSTI4 0
EQI4 $439
line 830
;830:		CG_DrawStatusBarFlag( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE + ICON_SIZE, TEAM_RED );
CNSTF4 1134985216
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 CG_DrawStatusBarFlag
CALLV
pop
line 831
;831:	} else if( cg.predictedPlayerState.powerups[PW_BLUEFLAG] ) {
ADDRGP4 $440
JUMPV
LABELV $439
ADDRGP4 cg+107636+312+32
INDIRI4
CNSTI4 0
EQI4 $444
line 832
;832:		CG_DrawStatusBarFlag( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE + ICON_SIZE, TEAM_BLUE );
CNSTF4 1134985216
ARGF4
CNSTI4 2
ARGI4
ADDRGP4 CG_DrawStatusBarFlag
CALLV
pop
line 833
;833:	} else if( cg.predictedPlayerState.powerups[PW_NEUTRALFLAG] ) {
ADDRGP4 $445
JUMPV
LABELV $444
ADDRGP4 cg+107636+312+36
INDIRI4
CNSTI4 0
EQI4 $449
line 834
;834:		CG_DrawStatusBarFlag( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE + ICON_SIZE, TEAM_FREE );
CNSTF4 1134985216
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStatusBarFlag
CALLV
pop
line 835
;835:	}
LABELV $449
LABELV $445
LABELV $440
line 838
;836:
;837:	
;838:	if ( ps->stats[ STAT_ARMOR ] ) {
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
EQI4 $454
line 839
;839:		qhandle_t model = cgs.media.armorModel; // CPM
ADDRLP4 68
ADDRGP4 cgs+156680+164
INDIRI4
ASGNI4
line 842
;840:
;841:		// CPM: Fix RA shader
;842:		if ( g_pro_mode.integer ) {
ADDRGP4 g_pro_mode+12
INDIRI4
CNSTI4 0
EQI4 $458
line 843
;843:			if ( ps->stats[ STAT_ARMORTYPE ] == 2 ) {
ADDRLP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CNSTI4 2
NEI4 $461
line 844
;844:				model = cgs.media.armorModelRA;
ADDRLP4 68
ADDRGP4 cgs+156680+172
INDIRI4
ASGNI4
line 845
;845:			}
LABELV $461
line 846
;846:		}
LABELV $458
line 847
;847:		origin[0] = 90;
ADDRLP4 24
CNSTF4 1119092736
ASGNF4
line 848
;848:		origin[1] = 0;
ADDRLP4 24+4
CNSTF4 0
ASGNF4
line 849
;849:		origin[2] = -10;
ADDRLP4 24+8
CNSTF4 3240099840
ASGNF4
line 850
;850:		angles[YAW] = ( cg.time & 2047 ) * 360 / 2048.0;
ADDRLP4 12+4
CNSTI4 360
ADDRGP4 cg+107604
INDIRI4
CNSTI4 2047
BANDI4
MULI4
CVIF4 4
CNSTF4 1157627904
DIVF4
ASGNF4
line 851
;851:		CG_Draw3DModel( 370 + CHAR_WIDTH*3 + TEXT_ICON_SPACE, 432, ICON_SIZE, ICON_SIZE,
CNSTF4 1139474432
ARGF4
CNSTF4 1138229248
ARGF4
ADDRLP4 72
CNSTF4 1111490560
ASGNF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRLP4 68
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 24
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 CG_Draw3DModel
CALLV
pop
line 853
;852:					   model,0, origin, angles ); // CPM
;853:	}
LABELV $454
line 872
;854:#ifdef MISSIONPACK
;855:	if( cgs.gametype == GT_HARVESTER ) {
;856:		origin[0] = 90;
;857:		origin[1] = 0;
;858:		origin[2] = -10;
;859:		angles[YAW] = ( cg.time & 2047 ) * 360 / 2048.0;
;860:		if( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
;861:			handle = cgs.media.redCubeModel;
;862:		} else {
;863:			handle = cgs.media.blueCubeModel;
;864:		}
;865:		CG_Draw3DModel( 640 - (TEXT_ICON_SPACE + ICON_SIZE), 416, ICON_SIZE, ICON_SIZE, handle, 0, origin, angles );
;866:	}
;867:#endif
;868:	//
;869:	// ammo
;870:	//
;871:	
;872:	if ( cent->currentState.weapon ) {
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 0
EQI4 $469
line 873
;873:		value = ps->ammo[cent->currentState.weapon];
ADDRLP4 0
ADDRLP4 8
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
ASGNI4
line 874
;874:		if ( value > -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
LEI4 $471
line 875
;875:			if ( cg.predictedPlayerState.weaponstate == WEAPON_FIRING
ADDRGP4 cg+107636+148
INDIRI4
CNSTI4 3
NEI4 $473
ADDRGP4 cg+107636+44
INDIRI4
CNSTI4 100
LEI4 $473
line 876
;876:				&& cg.predictedPlayerState.weaponTime > 100 ) {
line 878
;877:				// draw as dark grey when reloading
;878:				color = 2;	// dark grey
ADDRLP4 52
CNSTI4 2
ASGNI4
line 879
;879:			} else {
ADDRGP4 $474
JUMPV
LABELV $473
line 880
;880:				if ( value >= 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $479
line 881
;881:					color = 0;	// green
ADDRLP4 52
CNSTI4 0
ASGNI4
line 882
;882:				} else {
ADDRGP4 $480
JUMPV
LABELV $479
line 883
;883:					color = 1;	// red
ADDRLP4 52
CNSTI4 1
ASGNI4
line 884
;884:				}
LABELV $480
line 885
;885:			}
LABELV $474
line 887
;886:				
;887:			trap_R_SetColor( colors[color] );	
ADDRLP4 52
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 $423
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 888
;888:			CG_DrawField (0, 432, 3, value);
CNSTI4 0
ARGI4
CNSTI4 432
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_DrawField
CALLV
pop
line 889
;889:			trap_R_SetColor( NULL );	
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 892
;890:
;891:			// if we didn't draw a 3D icon, draw a 2D icon for ammo
;892:			if ( !cg_draw3dIcons.integer && cg_drawIcons.integer ) {
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRGP4 cg_draw3dIcons+12
INDIRI4
ADDRLP4 68
INDIRI4
NEI4 $481
ADDRGP4 cg_drawIcons+12
INDIRI4
ADDRLP4 68
INDIRI4
EQI4 $481
line 895
;893:				qhandle_t	icon;
;894:
;895:				icon = cg_weapons[ cg.predictedPlayerState.weapon ].ammoIcon;
ADDRLP4 72
CNSTI4 136
ADDRGP4 cg+107636+144
INDIRI4
MULI4
ADDRGP4 cg_weapons+72
ADDP4
INDIRI4
ASGNI4
line 896
;896:				if ( icon ) {
ADDRLP4 72
INDIRI4
CNSTI4 0
EQI4 $488
line 897
;897:					CG_DrawPic( CHAR_WIDTH*3 + TEXT_ICON_SPACE, 432, ICON_SIZE, ICON_SIZE, icon );
CNSTF4 1120403456
ARGF4
CNSTF4 1138229248
ARGF4
ADDRLP4 76
CNSTF4 1111490560
ASGNF4
ADDRLP4 76
INDIRF4
ARGF4
ADDRLP4 76
INDIRF4
ARGF4
ADDRLP4 72
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 898
;898:				}
LABELV $488
line 899
;899:			}
LABELV $481
line 900
;900:		}
LABELV $471
line 901
;901:	}
LABELV $469
line 906
;902:
;903:	//
;904:	// health
;905:	//
;906:	value = ps->stats[STAT_HEALTH];
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 907
;907:	if ( value > 100 ) {
ADDRLP4 0
INDIRI4
CNSTI4 100
LEI4 $490
line 908
;908:		trap_R_SetColor( colors[3] );		// white
ADDRGP4 $423+48
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 909
;909:	} else if (value > 25) {
ADDRGP4 $491
JUMPV
LABELV $490
ADDRLP4 0
INDIRI4
CNSTI4 25
LEI4 $493
line 910
;910:		trap_R_SetColor( colors[0] );	// green
ADDRGP4 $423
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 911
;911:	} else if (value > 0) {
ADDRGP4 $494
JUMPV
LABELV $493
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $495
line 912
;912:		color = (cg.time >> 8) & 1;	// flash
ADDRLP4 52
ADDRGP4 cg+107604
INDIRI4
CNSTI4 8
RSHI4
CNSTI4 1
BANDI4
ASGNI4
line 913
;913:		trap_R_SetColor( colors[color] );
ADDRLP4 52
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 $423
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 914
;914:	} else {
ADDRGP4 $496
JUMPV
LABELV $495
line 915
;915:		trap_R_SetColor( colors[1] );	// red
ADDRGP4 $423+16
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 916
;916:	}
LABELV $496
LABELV $494
LABELV $491
line 919
;917:
;918:	// stretch the health up when taking damage
;919:	CG_DrawField ( 155, 432, 4, value);
CNSTI4 155
ARGI4
CNSTI4 432
ARGI4
CNSTI4 4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_DrawField
CALLV
pop
line 921
;920:
;921:	CG_ColorForHealth( hcolor );
ADDRLP4 36
ARGP4
ADDRGP4 CG_ColorForHealth
CALLV
pop
line 922
;922:	trap_R_SetColor( hcolor );
ADDRLP4 36
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 927
;923:
;924:	//
;925:	// armor
;926:	//
;927:	value = ps->stats[STAT_ARMOR];
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
line 928
;928:	if (value > 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $499
line 930
;929:		// CPM: Armor icon
;930:		qhandle_t icon = cgs.media.armorIcon;
ADDRLP4 68
ADDRGP4 cgs+156680+168
INDIRI4
ASGNI4
line 932
;931:
;932:		if (g_pro_mode.integer && ps->stats[STAT_ARMORTYPE] == 2)
ADDRGP4 g_pro_mode+12
INDIRI4
CNSTI4 0
EQI4 $503
ADDRLP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CNSTI4 2
NEI4 $503
line 933
;933:			icon = cgs.media.armorIconRA;
ADDRLP4 68
ADDRGP4 cgs+156680+176
INDIRI4
ASGNI4
LABELV $503
line 936
;934:		// !CPM
;935:
;936:		if ( value > 100 ) {
ADDRLP4 0
INDIRI4
CNSTI4 100
LEI4 $508
line 937
;937:			trap_R_SetColor( colors[3] );
ADDRGP4 $423+48
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 938
;938:		} else {
ADDRGP4 $509
JUMPV
LABELV $508
line 939
;939:			trap_R_SetColor( colors[0] );
ADDRGP4 $423
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 940
;940:		}	
LABELV $509
line 941
;941:		CG_DrawField (370, 432, 3, value);
CNSTI4 370
ARGI4
CNSTI4 432
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_DrawField
CALLV
pop
line 942
;942:		trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 945
;943:
;944:		// if we didn't draw a 3D icon, draw a 2D icon for armor
;945:		if ( !cg_draw3dIcons.integer && cg_drawIcons.integer ) {
ADDRLP4 72
CNSTI4 0
ASGNI4
ADDRGP4 cg_draw3dIcons+12
INDIRI4
ADDRLP4 72
INDIRI4
NEI4 $511
ADDRGP4 cg_drawIcons+12
INDIRI4
ADDRLP4 72
INDIRI4
EQI4 $511
line 946
;946:			CG_DrawPic( 370 + CHAR_WIDTH*3 + TEXT_ICON_SPACE, 432, ICON_SIZE, ICON_SIZE, icon ); // CPM
CNSTF4 1139474432
ARGF4
CNSTF4 1138229248
ARGF4
ADDRLP4 76
CNSTF4 1111490560
ASGNF4
ADDRLP4 76
INDIRF4
ARGF4
ADDRLP4 76
INDIRF4
ARGF4
ADDRLP4 68
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 947
;947:		}
LABELV $511
line 948
;948:	}
LABELV $499
line 973
;949:
;950:#ifdef MISSIONPACK
;951:	//
;952:	// cubes
;953:	//
;954:	if( cgs.gametype == GT_HARVESTER ) {
;955:		value = ps->generic1;
;956:		if( value > 99 ) {
;957:			value = 99;
;958:		}
;959:		trap_R_SetColor( colors[0] );
;960:		CG_DrawField (640 - (CHAR_WIDTH*2 + TEXT_ICON_SPACE + ICON_SIZE), 432, 2, value, 0);
;961:		trap_R_SetColor( NULL );
;962:		// if we didn't draw a 3D icon, draw a 2D icon for armor
;963:		if ( !cg_draw3dIcons.integer && cg_drawIcons.integer ) {
;964:			if( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
;965:				handle = cgs.media.redCubeIcon;
;966:			} else {
;967:				handle = cgs.media.blueCubeIcon;
;968:			}
;969:			CG_DrawPic( 640 - (TEXT_ICON_SPACE + ICON_SIZE), 432, ICON_SIZE, ICON_SIZE, handle );
;970:		}
;971:	}
;972:#endif
;973:}
LABELV $422
endproc CG_DrawStatusBar 80 32
proc CG_DrawAttacker 64 44
line 990
;974:#endif
;975:
;976:/*
;977:===========================================================================================
;978:
;979:  UPPER RIGHT CORNER
;980:
;981:===========================================================================================
;982:*/
;983:
;984:/*
;985:================
;986:CG_DrawAttacker
;987:
;988:================
;989:*/
;990:static float CG_DrawAttacker( float y ) {
line 998
;991:	int			t, w;
;992:	float		size;
;993:	vec3_t		angles;
;994:	const char	*info;
;995:	const char	*name;
;996:	int			clientNum;
;997:
;998:	if ( cg.predictedPlayerState.stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 cg+107636+184
INDIRI4
CNSTI4 0
GTI4 $516
line 999
;999:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $515
JUMPV
LABELV $516
line 1002
;1000:	}
;1001:
;1002:	if ( !cg.attackerTime ) {
ADDRGP4 cg+130564
INDIRI4
CNSTI4 0
NEI4 $520
line 1003
;1003:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $515
JUMPV
LABELV $520
line 1006
;1004:	}
;1005:
;1006:	clientNum = cg.predictedPlayerState.persistant[PERS_ATTACKER];
ADDRLP4 0
ADDRGP4 cg+107636+248+24
INDIRI4
ASGNI4
line 1007
;1007:	if ( clientNum < 0 || clientNum >= MAX_CLIENTS || clientNum == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $530
ADDRLP4 0
INDIRI4
CNSTI4 64
GEI4 $530
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $526
LABELV $530
line 1008
;1008:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $515
JUMPV
LABELV $526
line 1011
;1009:	}
;1010:
;1011:	t = cg.time - cg.attackerTime;
ADDRLP4 24
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+130564
INDIRI4
SUBI4
ASGNI4
line 1012
;1012:	if ( t > ATTACKER_HEAD_TIME ) {
ADDRLP4 24
INDIRI4
CNSTI4 10000
LEI4 $533
line 1013
;1013:		cg.attackerTime = 0;
ADDRGP4 cg+130564
CNSTI4 0
ASGNI4
line 1014
;1014:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $515
JUMPV
LABELV $533
line 1017
;1015:	}
;1016:
;1017:	size = ICON_SIZE * 1.25;
ADDRLP4 4
CNSTF4 1114636288
ASGNF4
line 1019
;1018:
;1019:	angles[PITCH] = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 1020
;1020:	angles[YAW] = 180;
ADDRLP4 8+4
CNSTF4 1127481344
ASGNF4
line 1021
;1021:	angles[ROLL] = 0;
ADDRLP4 8+8
CNSTF4 0
ASGNF4
line 1022
;1022:	CG_DrawHead( 640 - size, y, size, size, clientNum, angles );
CNSTF4 1142947840
ADDRLP4 4
INDIRF4
SUBF4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRGP4 CG_DrawHead
CALLV
pop
line 1024
;1023:
;1024:	info = CG_ConfigString( CS_PLAYERS + clientNum );
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 44
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 32
ADDRLP4 44
INDIRP4
ASGNP4
line 1025
;1025:	name = Info_ValueForKey(  info, "n" );
ADDRLP4 32
INDIRP4
ARGP4
ADDRGP4 $538
ARGP4
ADDRLP4 48
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 48
INDIRP4
ASGNP4
line 1026
;1026:	y += size;
ADDRFP4 0
ADDRFP4 0
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
line 1028
;1027:
;1028:	w = CG_DrawStrlen( name ) * BIGCHAR_WIDTH;
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 52
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 1029
;1029:	CG_DrawStringExt( 640 - w, y + 2, name, colorWhite, qfalse, qfalse, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
CNSTI4 640
ADDRLP4 28
INDIRI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 56
CNSTI4 0
ASGNI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRLP4 60
CNSTI4 16
ASGNI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1031
;1030:
;1031:	return y + BIGCHAR_HEIGHT + 2;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1073741824
ADDF4
RETF4
LABELV $515
endproc CG_DrawAttacker 64 44
export CG_DrawSnapshot
proc CG_DrawSnapshot 24 44
line 1039
;1032:}
;1033:
;1034:/*
;1035:==================
;1036:CG_DrawSnapshot
;1037:==================
;1038:*/
;1039:float CG_DrawSnapshot( float y ) {
line 1043
;1040:	char		*s;
;1041:	int			w;
;1042:
;1043:	s = va( "time:%i snap:%i cmd:%i", cg.snap->serverTime, 
ADDRGP4 $540
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+28
INDIRI4
ARGI4
ADDRGP4 cgs+31444
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 1045
;1044:		cg.latestSnapshotNum, cgs.serverCommandSequence );
;1045:	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 1048
;1046:
;1047:	//CG_DrawBigString( 635 - w, y + 2, s, 1.0F);
;1048:	CG_DrawStringExt( 635 - w, y + 2, s, colorWhite, qfalse, qfalse, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
CNSTI4 635
ADDRLP4 4
INDIRI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 20
CNSTI4 16
ASGNI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1050
;1049:
;1050:	return y + BIGCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
LABELV $539
endproc CG_DrawSnapshot 24 44
bss
align 4
LABELV $545
skip 16
align 4
LABELV $546
skip 4
align 4
LABELV $547
skip 4
code
proc CG_DrawFPS 52 44
line 1059
;1051:}
;1052:
;1053:/*
;1054:==================
;1055:CG_DrawFPS
;1056:==================
;1057:*/
;1058:#define	FPS_FRAMES	4
;1059:static float CG_DrawFPS( float y ) {
line 1071
;1060:	char		*s;
;1061:	int			w;
;1062:	static int	previousTimes[FPS_FRAMES];
;1063:	static int	index;
;1064:	int		i, total;
;1065:	int		fps;
;1066:	static	int	previous;
;1067:	int		t, frameTime;
;1068:
;1069:	// don't use serverTime, because that will be drifting to
;1070:	// correct for internet lag changes, timescales, timedemos, etc
;1071:	t = trap_Milliseconds();
ADDRLP4 28
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 28
INDIRI4
ASGNI4
line 1072
;1072:	frameTime = t - previous;
ADDRLP4 12
ADDRLP4 8
INDIRI4
ADDRGP4 $547
INDIRI4
SUBI4
ASGNI4
line 1073
;1073:	previous = t;
ADDRGP4 $547
ADDRLP4 8
INDIRI4
ASGNI4
line 1075
;1074:
;1075:	previousTimes[index % FPS_FRAMES] = frameTime;
ADDRGP4 $546
INDIRI4
CNSTI4 4
MODI4
CNSTI4 2
LSHI4
ADDRGP4 $545
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1076
;1076:	index++;
ADDRLP4 32
ADDRGP4 $546
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1077
;1077:	if ( index > FPS_FRAMES ) {
ADDRGP4 $546
INDIRI4
CNSTI4 4
LEI4 $548
line 1079
;1078:		// average multiple frames together to smooth changes out a bit
;1079:		total = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1080
;1080:		for ( i = 0 ; i < FPS_FRAMES ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $550
line 1081
;1081:			total += previousTimes[i];
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $545
ADDP4
INDIRI4
ADDI4
ASGNI4
line 1082
;1082:		}
LABELV $551
line 1080
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $550
line 1083
;1083:		if ( !total ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $554
line 1084
;1084:			total = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 1085
;1085:		}
LABELV $554
line 1086
;1086:		fps = 1000 * FPS_FRAMES / total;
ADDRLP4 24
CNSTI4 4000
ADDRLP4 4
INDIRI4
DIVI4
ASGNI4
line 1088
;1087:
;1088:		s = va( "%ifps", fps );
ADDRGP4 $556
ARGP4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 36
INDIRP4
ASGNP4
line 1093
;1089:
;1090:		//CG_DrawBigString( 635 - w, y + 2, s, 1.0F);
;1091:		//CG_Printf("FPS -- %i, %i, %i, %i\n", hud[(int)y].rect[0], hud[(int)y].rect[1], hud[(int)y].fontsize[0], hud[(int)y].fontsize[1]);
;1092:
;1093:		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 40
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 1094
;1094:		CG_DrawStringExt( 635 - w, y + 2, s, colorWhite, qfalse, qfalse, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
CNSTI4 635
ADDRLP4 20
INDIRI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 44
CNSTI4 0
ASGNI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 48
CNSTI4 16
ASGNI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1095
;1095:	}
LABELV $548
line 1097
;1096:
;1097:	return y + BIGCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
LABELV $544
endproc CG_DrawFPS 52 44
proc CG_DrawTimer 36 44
line 1105
;1098:}
;1099:
;1100:/*
;1101:=================
;1102:CG_DrawTimer
;1103:=================
;1104:*/
;1105:static float CG_DrawTimer( float y ) {
line 1111
;1106:	char		*s;
;1107:	int			w;
;1108:	int			mins, seconds;//, tens;
;1109:	int			msec;
;1110:
;1111:	if ( cg_drawTimer.integer == 2 && cgs.timelimit > 0 ) {
ADDRGP4 cg_drawTimer+12
INDIRI4
CNSTI4 2
NEI4 $558
ADDRGP4 cgs+31476
INDIRI4
CNSTI4 0
LEI4 $558
line 1113
;1112:		//Figure out how much time left and subtract a second so we're at 0 when timelimit is hit.
;1113:		msec = (((cgs.levelStartTime + (cgs.timelimit * 60000)) - cg.time));
ADDRLP4 16
ADDRGP4 cgs+34784
INDIRI4
CNSTI4 60000
ADDRGP4 cgs+31476
INDIRI4
MULI4
ADDI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
ASGNI4
line 1114
;1114:	} else {
ADDRGP4 $559
JUMPV
LABELV $558
line 1115
;1115:		msec = cg.time - cgs.levelStartTime;
ADDRLP4 16
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cgs+34784
INDIRI4
SUBI4
ASGNI4
line 1116
;1116:	}
LABELV $559
line 1118
;1117:
;1118:	if ( cgs.timelimit > 0 && cg.time >= (cgs.levelStartTime + (cgs.timelimit * 60000)) ) {
ADDRGP4 cgs+31476
INDIRI4
CNSTI4 0
LEI4 $567
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cgs+34784
INDIRI4
CNSTI4 60000
ADDRGP4 cgs+31476
INDIRI4
MULI4
ADDI4
LTI4 $567
line 1119
;1119:		msec = seconds = mins = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 8
ADDRLP4 20
INDIRI4
ASGNI4
ADDRLP4 4
ADDRLP4 20
INDIRI4
ASGNI4
ADDRLP4 16
ADDRLP4 20
INDIRI4
ASGNI4
line 1120
;1120:	} else {
ADDRGP4 $568
JUMPV
LABELV $567
line 1121
;1121:		seconds = msec / 1000;
ADDRLP4 4
ADDRLP4 16
INDIRI4
CNSTI4 1000
DIVI4
ASGNI4
line 1122
;1122:		mins = seconds / 60;
ADDRLP4 8
ADDRLP4 4
INDIRI4
CNSTI4 60
DIVI4
ASGNI4
line 1123
;1123:		seconds -= mins * 60;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 60
ADDRLP4 8
INDIRI4
MULI4
SUBI4
ASGNI4
line 1124
;1124:	}
LABELV $568
line 1126
;1125:
;1126:	s = va( "%i:%02i", mins, seconds );
ADDRGP4 $573
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 1128
;1127:	
;1128:	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 24
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 1129
;1129:	CG_DrawStringExt( 635 - w, y + 2, s, colorWhite, qfalse, qfalse, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
CNSTI4 635
ADDRLP4 12
INDIRI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 32
CNSTI4 16
ASGNI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1132
;1130:
;1131:
;1132:	return y + BIGCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
LABELV $557
endproc CG_DrawTimer 36 44
export CG_DrawClock
proc CG_DrawClock 68 44
line 1140
;1133:}
;1134:
;1135:/*
;1136:=================
;1137:CG_DrawClock
;1138:=================
;1139:*/
;1140:float CG_DrawClock ( float y ) {
line 1147
;1141:	char		*s;
;1142:	int			w, hour;
;1143:	qboolean afternoon; 
;1144:	qtime_t qtm;
;1145:
;1146:
;1147:	if ( !cg.time > cg.clockInterval ) 
ADDRGP4 cg+107604
INDIRI4
CNSTI4 0
NEI4 $580
ADDRLP4 52
CNSTI4 1
ASGNI4
ADDRGP4 $581
JUMPV
LABELV $580
ADDRLP4 52
CNSTI4 0
ASGNI4
LABELV $581
ADDRLP4 52
INDIRI4
ADDRGP4 cg+162056
INDIRI4
LEI4 $575
line 1148
;1148:		return y + BIGCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
ADDRGP4 $574
JUMPV
LABELV $575
line 1150
;1149:
;1150:	cg.clockInterval = cg.time + 1000;
ADDRGP4 cg+162056
ADDRGP4 cg+107604
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 1152
;1151:
;1152:	trap_RealTime(&qtm);
ADDRLP4 0
ARGP4
ADDRGP4 trap_RealTime
CALLI4
pop
line 1156
;1153:	
;1154:/*  Used %02i for minutes and seconds, this reserves 2 spaces
;1155:	then fills any unused spaces with 0. */
;1156:	if (cg_drawClock.integer == 2) {
ADDRGP4 cg_drawClock+12
INDIRI4
CNSTI4 2
NEI4 $584
line 1157
;1157:		s = va( "%i:%02i:%02i", qtm.tm_hour, qtm.tm_min, qtm.tm_sec );
ADDRGP4 $587
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 56
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 36
ADDRLP4 56
INDIRP4
ASGNP4
line 1158
;1158:	} else {
ADDRGP4 $585
JUMPV
LABELV $584
line 1160
;1159:
;1160:			if ( qtm.tm_hour == 0 ) {
ADDRLP4 0+8
INDIRI4
CNSTI4 0
NEI4 $590
line 1161
;1161:				hour = qtm.tm_hour + 12;
ADDRLP4 44
ADDRLP4 0+8
INDIRI4
CNSTI4 12
ADDI4
ASGNI4
line 1162
;1162:				afternoon = qfalse;
ADDRLP4 48
CNSTI4 0
ASGNI4
line 1163
;1163:			} else if ( qtm.tm_hour == 12 ) {
ADDRGP4 $591
JUMPV
LABELV $590
ADDRLP4 0+8
INDIRI4
CNSTI4 12
NEI4 $594
line 1164
;1164:				hour = qtm.tm_hour;
ADDRLP4 44
ADDRLP4 0+8
INDIRI4
ASGNI4
line 1165
;1165:				afternoon = qtrue;
ADDRLP4 48
CNSTI4 1
ASGNI4
line 1166
;1166:			} else if ( qtm.tm_hour > 12 ) {
ADDRGP4 $595
JUMPV
LABELV $594
ADDRLP4 0+8
INDIRI4
CNSTI4 12
LEI4 $598
line 1167
;1167:				hour = qtm.tm_hour - 12;
ADDRLP4 44
ADDRLP4 0+8
INDIRI4
CNSTI4 12
SUBI4
ASGNI4
line 1168
;1168:				afternoon = qtrue;
ADDRLP4 48
CNSTI4 1
ASGNI4
line 1169
;1169:			} else if ( qtm.tm_hour < 12 ) {
ADDRGP4 $599
JUMPV
LABELV $598
ADDRLP4 0+8
INDIRI4
CNSTI4 12
GEI4 $602
line 1170
;1170:				hour = qtm.tm_hour;
ADDRLP4 44
ADDRLP4 0+8
INDIRI4
ASGNI4
line 1171
;1171:				afternoon = qfalse;
ADDRLP4 48
CNSTI4 0
ASGNI4
line 1172
;1172:			} else {
ADDRGP4 $603
JUMPV
LABELV $602
line 1173
;1173:				hour = qtm.tm_hour;
ADDRLP4 44
ADDRLP4 0+8
INDIRI4
ASGNI4
line 1174
;1174:				afternoon = qfalse;
ADDRLP4 48
CNSTI4 0
ASGNI4
line 1175
;1175:			}
LABELV $603
LABELV $599
LABELV $595
LABELV $591
line 1178
;1176:
;1177:
;1178:		if (!afternoon) {
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $607
line 1179
;1179:			s = va( "%i:%02i:%02iam", hour, qtm.tm_min, qtm.tm_sec );
ADDRGP4 $609
ARGP4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 56
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 36
ADDRLP4 56
INDIRP4
ASGNP4
line 1180
;1180:		} else {
ADDRGP4 $608
JUMPV
LABELV $607
line 1181
;1181:			s = va( "%i:%02i:%02ipm", hour, qtm.tm_min, qtm.tm_sec );
ADDRGP4 $611
ARGP4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 56
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 36
ADDRLP4 56
INDIRP4
ASGNP4
line 1182
;1182:		} 
LABELV $608
line 1184
;1183:
;1184:	}
LABELV $585
line 1186
;1185:
;1186:	w = CG_DrawStrlen( s ) * (BIGCHAR_WIDTH * .5);
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
CNSTF4 1090519040
ADDRLP4 56
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 1187
;1187:	CG_DrawStringExt( 635 - w, y + 2, s, colorWhite, qtrue, qfalse, BIGCHAR_WIDTH * .5, BIGCHAR_HEIGHT * .5, 0, 0, 0 );
CNSTI4 635
ADDRLP4 40
INDIRI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ARGI4
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRLP4 64
CNSTI4 8
ASGNI4
ADDRLP4 64
INDIRI4
ARGI4
ADDRLP4 64
INDIRI4
ARGI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1188
;1188:	return y + BIGCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
LABELV $574
endproc CG_DrawClock 68 44
proc CG_DrawTeamOverlay 136 44
line 1198
;1189:
;1190:}
;1191:
;1192:/*
;1193:=================
;1194:CG_DrawTeamOverlay
;1195:=================
;1196:*/
;1197:
;1198:static float CG_DrawTeamOverlay( float y, qboolean right, qboolean upper ) {
line 1210
;1199:	int x, w, h, xx;
;1200:	int i, j, len;
;1201:	const char *p;
;1202:	vec4_t		hcolor;
;1203:	int pwidth, lwidth;
;1204:	int plyrs;
;1205:	char st[16];
;1206:	clientInfo_t *ci;
;1207:	gitem_t	*item;
;1208:	int ret_y, count;
;1209:
;1210:	if ( !cg_drawTeamOverlay.integer ) {
ADDRGP4 cg_drawTeamOverlay+12
INDIRI4
CNSTI4 0
NEI4 $614
line 1211
;1211:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $613
JUMPV
LABELV $614
line 1214
;1212:	}
;1213:
;1214:	if ( cg.snap->ps.persistant[PERS_TEAM] != TEAM_RED && cg.snap->ps.persistant[PERS_TEAM] != TEAM_BLUE ) {
ADDRLP4 92
CNSTI4 304
ASGNI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRI4
CNSTI4 1
EQI4 $617
ADDRGP4 cg+36
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $617
line 1215
;1215:		return y; // Not on any team
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $613
JUMPV
LABELV $617
line 1218
;1216:	}
;1217:
;1218:	plyrs = 0;
ADDRLP4 60
CNSTI4 0
ASGNI4
line 1221
;1219:
;1220:	// max player name width
;1221:	pwidth = 0;
ADDRLP4 56
CNSTI4 0
ASGNI4
line 1222
;1222:	count = (numSortedTeamPlayers > 8) ? 8 : numSortedTeamPlayers;
ADDRGP4 numSortedTeamPlayers
INDIRI4
CNSTI4 8
LEI4 $622
ADDRLP4 96
CNSTI4 8
ASGNI4
ADDRGP4 $623
JUMPV
LABELV $622
ADDRLP4 96
ADDRGP4 numSortedTeamPlayers
INDIRI4
ASGNI4
LABELV $623
ADDRLP4 48
ADDRLP4 96
INDIRI4
ASGNI4
line 1223
;1223:	for (i = 0; i < count; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $627
JUMPV
LABELV $624
line 1224
;1224:		ci = cgs.clientinfo + sortedTeamPlayers[i];
ADDRLP4 4
CNSTI4 1776
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+40960
ADDP4
ASGNP4
line 1225
;1225:		if ( ci->infoValid && ci->team == cg.snap->ps.persistant[PERS_TEAM]) {
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $629
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
NEI4 $629
line 1226
;1226:			plyrs++;
ADDRLP4 60
ADDRLP4 60
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1227
;1227:			len = CG_DrawStrlen(ci->name);
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 104
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 104
INDIRI4
ASGNI4
line 1228
;1228:			if (len > pwidth)
ADDRLP4 40
INDIRI4
ADDRLP4 56
INDIRI4
LEI4 $632
line 1229
;1229:				pwidth = len;
ADDRLP4 56
ADDRLP4 40
INDIRI4
ASGNI4
LABELV $632
line 1230
;1230:		}
LABELV $629
line 1231
;1231:	}
LABELV $625
line 1223
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $627
ADDRLP4 8
INDIRI4
ADDRLP4 48
INDIRI4
LTI4 $624
line 1233
;1232:
;1233:	if (!plyrs)
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $634
line 1234
;1234:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $613
JUMPV
LABELV $634
line 1236
;1235:
;1236:	if (pwidth > TEAM_OVERLAY_MAXNAME_WIDTH)
ADDRLP4 56
INDIRI4
CNSTI4 12
LEI4 $636
line 1237
;1237:		pwidth = TEAM_OVERLAY_MAXNAME_WIDTH;
ADDRLP4 56
CNSTI4 12
ASGNI4
LABELV $636
line 1240
;1238:
;1239:	// max location name width
;1240:	lwidth = 0;
ADDRLP4 44
CNSTI4 0
ASGNI4
line 1241
;1241:	for (i = 1; i < MAX_LOCATIONS; i++) {
ADDRLP4 8
CNSTI4 1
ASGNI4
LABELV $638
line 1242
;1242:		p = CG_ConfigString(CS_LOCATIONS + i);
ADDRLP4 8
INDIRI4
CNSTI4 608
ADDI4
ARGI4
ADDRLP4 100
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 100
INDIRP4
ASGNP4
line 1243
;1243:		if (p && *p) {
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $642
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $642
line 1244
;1244:			len = CG_DrawStrlen(p);
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 108
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 108
INDIRI4
ASGNI4
line 1245
;1245:			if (len > lwidth)
ADDRLP4 40
INDIRI4
ADDRLP4 44
INDIRI4
LEI4 $644
line 1246
;1246:				lwidth = len;
ADDRLP4 44
ADDRLP4 40
INDIRI4
ASGNI4
LABELV $644
line 1247
;1247:		}
LABELV $642
line 1248
;1248:	}
LABELV $639
line 1241
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 64
LTI4 $638
line 1250
;1249:
;1250:	if (lwidth > TEAM_OVERLAY_MAXLOCATION_WIDTH)
ADDRLP4 44
INDIRI4
CNSTI4 16
LEI4 $646
line 1251
;1251:		lwidth = TEAM_OVERLAY_MAXLOCATION_WIDTH;
ADDRLP4 44
CNSTI4 16
ASGNI4
LABELV $646
line 1253
;1252:
;1253:	if ( g_gamemode.integer != 1 ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 1
EQI4 $648
line 1254
;1254:		w = (pwidth + lwidth + 4 + 7) * TINYCHAR_WIDTH;
ADDRLP4 80
ADDRLP4 56
INDIRI4
ADDRLP4 44
INDIRI4
ADDI4
CNSTI4 3
LSHI4
CNSTI4 32
ADDI4
CNSTI4 56
ADDI4
ASGNI4
line 1255
;1255:	} else {
ADDRGP4 $649
JUMPV
LABELV $648
line 1256
;1256:		w = (pwidth + lwidth + 3) * TINYCHAR_WIDTH;
ADDRLP4 80
ADDRLP4 56
INDIRI4
ADDRLP4 44
INDIRI4
ADDI4
CNSTI4 3
LSHI4
CNSTI4 24
ADDI4
ASGNI4
line 1257
;1257:	}
LABELV $649
line 1259
;1258:
;1259:	if ( right )
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $651
line 1260
;1260:		x = 640 - w;
ADDRLP4 52
CNSTI4 640
ADDRLP4 80
INDIRI4
SUBI4
ASGNI4
ADDRGP4 $652
JUMPV
LABELV $651
line 1262
;1261:	else
;1262:		x = 0;
ADDRLP4 52
CNSTI4 0
ASGNI4
LABELV $652
line 1264
;1263:
;1264:	h = plyrs * TINYCHAR_HEIGHT;
ADDRLP4 84
ADDRLP4 60
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
line 1266
;1265:
;1266:	if ( upper ) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $653
line 1267
;1267:		ret_y = y + h;
ADDRLP4 88
ADDRFP4 0
INDIRF4
ADDRLP4 84
INDIRI4
CVIF4 4
ADDF4
CVFI4 4
ASGNI4
line 1268
;1268:	} else {
ADDRGP4 $654
JUMPV
LABELV $653
line 1269
;1269:		y -= h;
ADDRFP4 0
ADDRFP4 0
INDIRF4
ADDRLP4 84
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 1270
;1270:		ret_y = y;
ADDRLP4 88
ADDRFP4 0
INDIRF4
CVFI4 4
ASGNI4
line 1271
;1271:	}
LABELV $654
line 1273
;1272:	
;1273:	if ( cg_adjustTeamColors.integer && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR ) {
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
CNSTI4 0
EQI4 $655
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 3
EQI4 $655
line 1274
;1274:		memcpy(hcolor, g_color_table[ ColorIndex( cg_TeamColors.string[cg_adjustTeamColors.integer - 1] ) ], sizeof(hcolor));
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 cg_TeamColors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 100
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 24
ARGP4
ADDRLP4 100
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
line 1275
;1275:		hcolor[3] = 0.33f;
ADDRLP4 24+12
CNSTF4 1051260355
ASGNF4
line 1276
;1276:	} else 
ADDRGP4 $656
JUMPV
LABELV $655
line 1277
;1277:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $665
line 1278
;1278:		hcolor[0] = 1.0f;
ADDRLP4 24
CNSTF4 1065353216
ASGNF4
line 1279
;1279:		hcolor[1] = 0.0f;
ADDRLP4 24+4
CNSTF4 0
ASGNF4
line 1280
;1280:		hcolor[2] = 0.0f;
ADDRLP4 24+8
CNSTF4 0
ASGNF4
line 1281
;1281:		hcolor[3] = 0.33f;
ADDRLP4 24+12
CNSTF4 1051260355
ASGNF4
line 1282
;1282:	} else { // if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE )
ADDRGP4 $666
JUMPV
LABELV $665
line 1283
;1283:		hcolor[0] = 0.0f;
ADDRLP4 24
CNSTF4 0
ASGNF4
line 1284
;1284:		hcolor[1] = 0.0f;
ADDRLP4 24+4
CNSTF4 0
ASGNF4
line 1285
;1285:		hcolor[2] = 1.0f;
ADDRLP4 24+8
CNSTF4 1065353216
ASGNF4
line 1286
;1286:		hcolor[3] = 0.33f;
ADDRLP4 24+12
CNSTF4 1051260355
ASGNF4
line 1287
;1287:	}
LABELV $666
LABELV $656
line 1288
;1288:	trap_R_SetColor( hcolor );
ADDRLP4 24
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1289
;1289:	CG_DrawPic( x, y, w, h, cgs.media.teamStatusBar );
ADDRLP4 52
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 80
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 84
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 cgs+156680+180
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1290
;1290:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1292
;1291:
;1292:	for (i = 0; i < count; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $679
JUMPV
LABELV $676
line 1293
;1293:		ci = cgs.clientinfo + sortedTeamPlayers[i];
ADDRLP4 4
CNSTI4 1776
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+40960
ADDP4
ASGNP4
line 1294
;1294:		if ( ci->infoValid && ci->team == cg.snap->ps.persistant[PERS_TEAM]) {
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $681
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
NEI4 $681
line 1296
;1295:
;1296:			hcolor[0] = hcolor[1] = hcolor[2] = hcolor[3] = 1.0;
ADDRLP4 104
CNSTF4 1065353216
ASGNF4
ADDRLP4 24+12
ADDRLP4 104
INDIRF4
ASGNF4
ADDRLP4 24+8
ADDRLP4 104
INDIRF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 104
INDIRF4
ASGNF4
ADDRLP4 24
ADDRLP4 104
INDIRF4
ASGNF4
line 1298
;1297:
;1298:			xx = x + TINYCHAR_WIDTH;
ADDRLP4 16
ADDRLP4 52
INDIRI4
CNSTI4 8
ADDI4
ASGNI4
line 1300
;1299:
;1300:			CG_DrawStringExt( xx, y,
ADDRLP4 16
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 108
CNSTI4 0
ASGNI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRLP4 112
CNSTI4 8
ASGNI4
ADDRLP4 112
INDIRI4
ARGI4
ADDRLP4 112
INDIRI4
ARGI4
CNSTI4 12
ARGI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1304
;1301:				ci->name, hcolor, qfalse, qfalse,
;1302:				TINYCHAR_WIDTH, TINYCHAR_HEIGHT, TEAM_OVERLAY_MAXNAME_WIDTH, 0, 0);
;1303:
;1304:			if (lwidth) {
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $687
line 1305
;1305:				p = CG_ConfigString(CS_LOCATIONS + ci->location);
ADDRLP4 4
INDIRP4
CNSTI4 132
ADDP4
INDIRI4
CNSTI4 608
ADDI4
ARGI4
ADDRLP4 116
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 116
INDIRP4
ASGNP4
line 1306
;1306:				if (!p || !*p)
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $691
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $689
LABELV $691
line 1307
;1307:					p = "unknown";
ADDRLP4 20
ADDRGP4 $692
ASGNP4
LABELV $689
line 1308
;1308:				len = CG_DrawStrlen(p);
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 124
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 124
INDIRI4
ASGNI4
line 1309
;1309:				if (len > lwidth)
ADDRLP4 40
INDIRI4
ADDRLP4 44
INDIRI4
LEI4 $693
line 1310
;1310:					len = lwidth;
ADDRLP4 40
ADDRLP4 44
INDIRI4
ASGNI4
LABELV $693
line 1314
;1311:
;1312://				xx = x + TINYCHAR_WIDTH * 2 + TINYCHAR_WIDTH * pwidth + 
;1313://					((lwidth/2 - len/2) * TINYCHAR_WIDTH);
;1314:				xx = x + TINYCHAR_WIDTH * 2 + TINYCHAR_WIDTH * pwidth;
ADDRLP4 16
ADDRLP4 52
INDIRI4
CNSTI4 16
ADDI4
ADDRLP4 56
INDIRI4
CNSTI4 3
LSHI4
ADDI4
ASGNI4
line 1315
;1315:				CG_DrawStringExt( xx, y,
ADDRLP4 16
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 128
CNSTI4 0
ASGNI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRLP4 132
CNSTI4 8
ASGNI4
ADDRLP4 132
INDIRI4
ARGI4
ADDRLP4 132
INDIRI4
ARGI4
CNSTI4 16
ARGI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1318
;1316:					p, hcolor, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT,
;1317:					TEAM_OVERLAY_MAXLOCATION_WIDTH, 0, 0);
;1318:			}
LABELV $687
line 1320
;1319:
;1320:			if ( g_gamemode.integer != 1 ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 1
EQI4 $695
line 1321
;1321:				CG_GetColorForHealth( ci->health, ci->armor, hcolor );
ADDRLP4 4
INDIRP4
CNSTI4 136
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRGP4 CG_GetColorForHealth
CALLV
pop
line 1323
;1322:
;1323:				Com_sprintf (st, sizeof(st), "%3i %3i", ci->health,	ci->armor);
ADDRLP4 64
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $698
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 136
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1325
;1324:
;1325:				xx = x + TINYCHAR_WIDTH * 3 + 
ADDRLP4 124
CNSTI4 3
ASGNI4
ADDRLP4 16
ADDRLP4 52
INDIRI4
CNSTI4 24
ADDI4
ADDRLP4 56
INDIRI4
ADDRLP4 124
INDIRI4
LSHI4
ADDI4
ADDRLP4 44
INDIRI4
ADDRLP4 124
INDIRI4
LSHI4
ADDI4
ASGNI4
line 1328
;1326:					TINYCHAR_WIDTH * pwidth + TINYCHAR_WIDTH * lwidth;
;1327:
;1328:				CG_DrawStringExt( xx, y,
ADDRLP4 16
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 64
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 128
CNSTI4 0
ASGNI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRLP4 132
CNSTI4 8
ASGNI4
ADDRLP4 132
INDIRI4
ARGI4
ADDRLP4 132
INDIRI4
ARGI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1331
;1329:					st, hcolor, qfalse, qfalse,
;1330:					TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0, 0, 0 );
;1331:			}
LABELV $695
line 1334
;1332:
;1333:			// draw weapon icon
;1334:			if ( g_gamemode.integer != 1 ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 1
EQI4 $699
line 1335
;1335:				xx += TINYCHAR_WIDTH * 3;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 24
ADDI4
ASGNI4
line 1337
;1336:
;1337:				if ( cg_weapons[ci->curWeapon].weaponIcon ) {
CNSTI4 136
ADDRLP4 4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons+68
ADDP4
INDIRI4
CNSTI4 0
EQI4 $702
line 1338
;1338:					CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 116
CNSTF4 1090519040
ASGNF4
ADDRLP4 116
INDIRF4
ARGF4
ADDRLP4 116
INDIRF4
ARGF4
CNSTI4 136
ADDRLP4 4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons+68
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1340
;1339:						cg_weapons[ci->curWeapon].weaponIcon );
;1340:				} else {
ADDRGP4 $703
JUMPV
LABELV $702
line 1341
;1341:					CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 116
CNSTF4 1090519040
ASGNF4
ADDRLP4 116
INDIRF4
ARGF4
ADDRLP4 116
INDIRF4
ARGF4
ADDRGP4 cgs+156680+184
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1343
;1342:						cgs.media.deferShader );
;1343:				}
LABELV $703
line 1344
;1344:			}
LABELV $699
line 1347
;1345:
;1346:			// Draw powerup icons
;1347:			if (right) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $708
line 1348
;1348:				xx = x;
ADDRLP4 16
ADDRLP4 52
INDIRI4
ASGNI4
line 1349
;1349:			} else {
ADDRGP4 $709
JUMPV
LABELV $708
line 1350
;1350:				xx = x + w - TINYCHAR_WIDTH;
ADDRLP4 16
ADDRLP4 52
INDIRI4
ADDRLP4 80
INDIRI4
ADDI4
CNSTI4 8
SUBI4
ASGNI4
line 1351
;1351:			}
LABELV $709
line 1352
;1352:			for (j = 0; j <= PW_NUM_POWERUPS; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $710
line 1354
;1353://freeze
;1354:				if ( g_gamemode.integer > 3 ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $714
line 1355
;1355:					if ( Q_Isfreeze( ci - cgs.clientinfo ) ) {
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRGP4 cgs+40960
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 1776
DIVI4
ARGI4
ADDRLP4 116
ADDRGP4 Q_Isfreeze
CALLI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 0
EQI4 $717
line 1356
;1356:						CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, cgs.media.noammoShader );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 120
CNSTF4 1090519040
ASGNF4
ADDRLP4 120
INDIRF4
ARGF4
ADDRLP4 120
INDIRF4
ARGF4
ADDRGP4 cgs+156680+328
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1357
;1357:						break;
ADDRGP4 $712
JUMPV
LABELV $717
line 1359
;1358:					}
;1359:				}
LABELV $714
line 1361
;1360://freeze
;1361:				if (ci->powerups & (1 << j)) {
ADDRLP4 4
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $722
line 1363
;1362:
;1363:					item = BG_FindItemForPowerup( j );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 116
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 116
INDIRP4
ASGNP4
line 1365
;1364:
;1365:					if (item) {
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $724
line 1367
;1366:						/* This is sloppy but it sets the color of the flag icons for cg_adjustTeamColors */
;1367:						 if ( item->giType == IT_TEAM && cgs.gametype == GT_CTF && cg_adjustTeamColors.integer ) {
ADDRLP4 12
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $726
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
NEI4 $726
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
CNSTI4 0
EQI4 $726
line 1368
;1368:							if ( cgs.clientinfo[cg.clientNum].team == TEAM_RED ) {
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $730
line 1369
;1369:								if ( item->giTag == PW_REDFLAG ) {
ADDRLP4 12
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 7
NEI4 $735
line 1370
;1370:									trap_R_SetColor( g_color_table[ ColorIndex( cg_TeamColors.string[cg_adjustTeamColors.integer - 1] ) ] );
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 cg_TeamColors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 120
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1371
;1371:								} else {
ADDRGP4 $731
JUMPV
LABELV $735
line 1372
;1372:									trap_R_SetColor( g_color_table[ ColorIndex(cg_EnemyColors.string[cg_adjustTeamColors.integer - 1]) ] );
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 cg_EnemyColors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 120
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1373
;1373:								}
line 1374
;1374:							} else {
ADDRGP4 $731
JUMPV
LABELV $730
line 1375
;1375:								if ( item->giTag == PW_BLUEFLAG ) {
ADDRLP4 12
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 8
NEI4 $743
line 1376
;1376:									trap_R_SetColor( g_color_table[ ColorIndex( cg_TeamColors.string[cg_adjustTeamColors.integer - 1] ) ] );
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 cg_TeamColors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 120
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1377
;1377:								} else {
ADDRGP4 $744
JUMPV
LABELV $743
line 1378
;1378:									trap_R_SetColor( g_color_table[ ColorIndex(cg_EnemyColors.string[cg_adjustTeamColors.integer - 1]) ] );
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 cg_EnemyColors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 120
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1379
;1379:								}
LABELV $744
line 1380
;1380:							}
LABELV $731
line 1381
;1381:						}
LABELV $726
line 1382
;1382:						 if ( cg_adjustTeamColors.integer ) {
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
CNSTI4 0
EQI4 $751
line 1383
;1383:							 CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, trap_R_RegisterShader( "icons/iconf_fla1" ) );
ADDRGP4 $754
ARGP4
ADDRLP4 120
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 124
CNSTF4 1090519040
ASGNF4
ADDRLP4 124
INDIRF4
ARGF4
ADDRLP4 124
INDIRF4
ARGF4
ADDRLP4 120
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1384
;1384:						 } else {
ADDRGP4 $752
JUMPV
LABELV $751
line 1385
;1385:							CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 
ADDRLP4 12
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 120
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 124
CNSTF4 1090519040
ASGNF4
ADDRLP4 124
INDIRF4
ARGF4
ADDRLP4 124
INDIRF4
ARGF4
ADDRLP4 120
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1387
;1386:							trap_R_RegisterShader( item->icon ) );
;1387:						 }
LABELV $752
line 1388
;1388:						if (right) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $755
line 1389
;1389:							xx -= TINYCHAR_WIDTH;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 1390
;1390:						} else {
ADDRGP4 $756
JUMPV
LABELV $755
line 1391
;1391:							xx += TINYCHAR_WIDTH;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 8
ADDI4
ASGNI4
line 1392
;1392:						}
LABELV $756
line 1393
;1393:					}
LABELV $724
line 1394
;1394:				}
LABELV $722
line 1395
;1395:			}
LABELV $711
line 1352
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 15
LEI4 $710
LABELV $712
line 1397
;1396:
;1397:			y += TINYCHAR_HEIGHT;
ADDRFP4 0
ADDRFP4 0
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 1398
;1398:		}
LABELV $681
line 1399
;1399:	}
LABELV $677
line 1292
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $679
ADDRLP4 8
INDIRI4
ADDRLP4 48
INDIRI4
LTI4 $676
line 1401
;1400:
;1401:	return ret_y;
ADDRLP4 88
INDIRI4
CVIF4 4
RETF4
LABELV $613
endproc CG_DrawTeamOverlay 136 44
proc CG_DrawUpperRight 12 12
line 1412
;1402://#endif
;1403:}
;1404:
;1405:
;1406:/*
;1407:=====================
;1408:CG_DrawUpperRight
;1409:
;1410:=====================
;1411:*/
;1412:static void CG_DrawUpperRight( void ) {
line 1415
;1413:	float	y;
;1414:
;1415:	y = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1417
;1416:
;1417:	if ( cgs.gametype >= GT_TEAM && cg_drawTeamOverlay.integer == 1 ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $758
ADDRGP4 cg_drawTeamOverlay+12
INDIRI4
CNSTI4 1
NEI4 $758
line 1418
;1418:		y = CG_DrawTeamOverlay( y, qtrue, qtrue );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 CG_DrawTeamOverlay
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 1419
;1419:	} 
LABELV $758
line 1420
;1420:	if ( cg_drawSnapshot.integer ) {
ADDRGP4 cg_drawSnapshot+12
INDIRI4
CNSTI4 0
EQI4 $762
line 1421
;1421:		y = CG_DrawSnapshot( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 CG_DrawSnapshot
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1422
;1422:	}
LABELV $762
line 1423
;1423:	if ( cg_drawFPS.integer ) {
ADDRGP4 cg_drawFPS+12
INDIRI4
CNSTI4 0
EQI4 $765
line 1424
;1424:		y = CG_DrawFPS( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 CG_DrawFPS
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1425
;1425:	}
LABELV $765
line 1426
;1426:	if ( cg_drawTimer.integer ) {
ADDRGP4 cg_drawTimer+12
INDIRI4
CNSTI4 0
EQI4 $768
line 1427
;1427:		y = CG_DrawTimer( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 CG_DrawTimer
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1428
;1428:	}
LABELV $768
line 1429
;1429:	if ( cg_drawAttacker.integer ) {
ADDRGP4 cg_drawAttacker+12
INDIRI4
CNSTI4 0
EQI4 $771
line 1430
;1430:		y = CG_DrawAttacker( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 CG_DrawAttacker
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1431
;1431:	}
LABELV $771
line 1432
;1432:	if ( cg_drawClock.integer ) {
ADDRGP4 cg_drawClock+12
INDIRI4
CNSTI4 0
EQI4 $774
line 1433
;1433:		y = CG_DrawClock( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 CG_DrawClock
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1434
;1434:	}
LABELV $774
line 1436
;1435:
;1436:}
LABELV $757
endproc CG_DrawUpperRight 12 12
proc CG_DrawScores 108 44
line 1454
;1437:
;1438:/*
;1439:===========================================================================================
;1440:
;1441:  LOWER RIGHT CORNER
;1442:
;1443:===========================================================================================
;1444:*/
;1445:
;1446:/*
;1447:=================
;1448:CG_DrawScores
;1449:
;1450:Draw the small two score display
;1451:=================
;1452:*/
;1453://#ifndef MISSIONPACK
;1454:static float CG_DrawScores( float y ) {
line 1463
;1455:	const char	*s;
;1456:	int			s1, s2, score;
;1457:	int			x, w;
;1458:	int			v;
;1459:	vec4_t		color;
;1460:	float		y1;
;1461:	gitem_t		*item;
;1462:
;1463:	s1 = cgs.scores1;
ADDRLP4 28
ADDRGP4 cgs+34788
INDIRI4
ASGNI4
line 1464
;1464:	s2 = cgs.scores2;
ADDRLP4 32
ADDRGP4 cgs+34792
INDIRI4
ASGNI4
line 1466
;1465:
;1466:	y -=  BIGCHAR_HEIGHT + 8;
ADDRFP4 0
ADDRFP4 0
INDIRF4
CNSTF4 1103101952
SUBF4
ASGNF4
line 1468
;1467:
;1468:	y1 = y;
ADDRLP4 36
ADDRFP4 0
INDIRF4
ASGNF4
line 1471
;1469:
;1470:	// draw from the right side to left
;1471:	if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $780
line 1472
;1472:		x = 640;
ADDRLP4 0
CNSTI4 640
ASGNI4
line 1474
;1473:		//Set color
;1474:		if ( cg_adjustTeamColors.integer && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR ) {
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
CNSTI4 0
EQI4 $783
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 3
EQI4 $783
line 1475
;1475:			if ( cgs.clientinfo[ cg.clientNum ].team != TEAM_BLUE && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR && strlen(cg_EnemyColors.string) >= cg_adjustTeamColors.integer ) {
ADDRLP4 52
CNSTI4 1776
ASGNI4
ADDRLP4 52
INDIRI4
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 2
EQI4 $789
ADDRLP4 52
INDIRI4
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 3
EQI4 $789
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 56
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
LTI4 $789
line 1476
;1476:				memcpy(color, g_color_table[ ColorIndex( cg_EnemyColors.string[cg_adjustTeamColors.integer - 1] ) ], sizeof(color));
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 cg_EnemyColors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 60
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
ARGP4
ADDRLP4 60
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
line 1477
;1477:			} else if ( cg_forceColors.integer && cgs.clientinfo[ cg.clientNum ].team == TEAM_BLUE && strlen(colors.string) >= cg_adjustTeamColors.integer ) {
ADDRGP4 $784
JUMPV
LABELV $789
ADDRGP4 cg_forceColors+12
INDIRI4
CNSTI4 0
EQI4 $802
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $802
ADDRGP4 colors+16
ARGP4
ADDRLP4 60
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
LTI4 $802
line 1478
;1478:				memcpy(color, g_color_table[ ColorIndex( colors.string[cg_adjustTeamColors.integer - 1] ) ], sizeof(color));
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 colors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 64
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
ARGP4
ADDRLP4 64
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
line 1479
;1479:			} else if ( cgs.clientinfo[ cg.clientNum ].team == TEAM_BLUE && strlen(cg_TeamColors.string) >= cg_adjustTeamColors.integer ) {
ADDRGP4 $784
JUMPV
LABELV $802
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $784
ADDRGP4 cg_TeamColors+16
ARGP4
ADDRLP4 64
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
LTI4 $784
line 1480
;1480:				memcpy(color, g_color_table[ ColorIndex( cg_TeamColors.string[cg_adjustTeamColors.integer - 1] ) ], sizeof(color));
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 cg_TeamColors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 68
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
ARGP4
ADDRLP4 68
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
line 1481
;1481:			}
line 1482
;1482:		} else {
ADDRGP4 $784
JUMPV
LABELV $783
line 1483
;1483:			color[0] = 0.0f;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 1484
;1484:			color[1] = 0.0f;
ADDRLP4 4+4
CNSTF4 0
ASGNF4
line 1485
;1485:			color[2] = 1.0f;
ADDRLP4 4+8
CNSTF4 1065353216
ASGNF4
line 1486
;1486:		}
LABELV $784
line 1487
;1487:		color[3] = 0.33f;
ADDRLP4 4+12
CNSTF4 1051260355
ASGNF4
line 1488
;1488:		s = va( "%2i", s2 );
ADDRGP4 $826
ARGP4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 52
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 52
INDIRP4
ASGNP4
line 1489
;1489:		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 56
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1490
;1490:		x -= w;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 1491
;1491:		CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1493
;1492:
;1493:		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $827
line 1494
;1494:			CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+156680+264
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1495
;1495:		}
LABELV $827
line 1497
;1496:		//CG_DrawBigString( x + 4, y, s, 1.0F);
;1497:		CG_DrawStringExt(x + 4, y, s, colorWhite, qtrue, qfalse, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
ADDRLP4 0
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRLP4 64
CNSTI4 16
ASGNI4
ADDRLP4 64
INDIRI4
ARGI4
ADDRLP4 64
INDIRI4
ARGI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1499
;1498:
;1499:		if ( cgs.gametype == GT_CTF ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
NEI4 $832
line 1501
;1500:			//Set the flag icon color
;1501:			if ( cg_adjustTeamColors.integer && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR ) {
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
CNSTI4 0
EQI4 $835
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 3
EQI4 $835
line 1502
;1502:				if ( cg_adjustTeamColors.integer && cgs.clientinfo[ cg.clientNum ].team != TEAM_BLUE && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR && strlen(cg_EnemyColors.string) >= cg_adjustTeamColors.integer ) {
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
CNSTI4 0
EQI4 $841
ADDRLP4 68
CNSTI4 1776
ASGNI4
ADDRLP4 68
INDIRI4
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 2
EQI4 $841
ADDRLP4 68
INDIRI4
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 3
EQI4 $841
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 72
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
LTI4 $841
line 1503
;1503:					trap_R_SetColor( g_color_table[ ColorIndex( cg_EnemyColors.string[cg_adjustTeamColors.integer - 1] ) ] );
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 cg_EnemyColors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 76
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1504
;1504:				} else if ( cg_adjustTeamColors.integer && cg_forceColors.integer && cgs.clientinfo[ cg.clientNum ].team == TEAM_BLUE && strlen(colors.string) >= cg_adjustTeamColors.integer ) {
ADDRGP4 $842
JUMPV
LABELV $841
ADDRLP4 76
CNSTI4 0
ASGNI4
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRLP4 76
INDIRI4
EQI4 $855
ADDRGP4 cg_forceColors+12
INDIRI4
ADDRLP4 76
INDIRI4
EQI4 $855
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $855
ADDRGP4 colors+16
ARGP4
ADDRLP4 80
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
LTI4 $855
line 1505
;1505:					trap_R_SetColor( g_color_table[ ColorIndex( colors.string[cg_adjustTeamColors.integer - 1] ) ] );
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 colors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 84
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1506
;1506:				} else if ( cg_adjustTeamColors.integer && cgs.clientinfo[ cg.clientNum ].team == TEAM_BLUE && strlen(cg_TeamColors.string) >= cg_adjustTeamColors.integer ) {
ADDRGP4 $856
JUMPV
LABELV $855
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
CNSTI4 0
EQI4 $867
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $867
ADDRGP4 cg_TeamColors+16
ARGP4
ADDRLP4 84
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
LTI4 $867
line 1507
;1507:					trap_R_SetColor( g_color_table[ ColorIndex( cg_TeamColors.string[cg_adjustTeamColors.integer - 1] ) ] );
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 cg_TeamColors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 88
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1508
;1508:				}
LABELV $867
LABELV $856
LABELV $842
line 1509
;1509:			}
LABELV $835
line 1511
;1510:			// Display flag status
;1511:			item = BG_FindItemForPowerup( PW_BLUEFLAG );
CNSTI4 8
ARGI4
ADDRLP4 68
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 44
ADDRLP4 68
INDIRP4
ASGNP4
line 1513
;1512:
;1513:			if (item) {
ADDRLP4 44
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $878
line 1515
;1514:				//CG_Printf("item -- ");
;1515:				y1 = y - BIGCHAR_HEIGHT - 8;
ADDRLP4 36
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1090519040
SUBF4
ASGNF4
line 1516
;1516:				if( cgs.flags[TEAM_BLUE-1] >= 0 && cgs.flags[TEAM_BLUE-1] <= 3 ) {
ADDRGP4 cgs+34796+4
INDIRI4
CNSTI4 0
LTI4 $880
ADDRGP4 cgs+34796+4
INDIRI4
CNSTI4 3
GTI4 $880
line 1517
;1517:					if ( cg_adjustTeamColors.integer && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR ) {
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
CNSTI4 0
EQI4 $886
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 3
EQI4 $886
line 1518
;1518:						CG_DrawPic( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.whiteFlagShader[cgs.flags[TEAM_BLUE-1]] );
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 36
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+34796+4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+156680+100
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1519
;1519:					} else {
ADDRGP4 $887
JUMPV
LABELV $886
line 1520
;1520:						CG_DrawPic( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.blueFlagShader[cgs.flags[TEAM_BLUE-1]] );
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 36
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+34796+4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+156680+84
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1521
;1521:					}
LABELV $887
line 1523
;1522:					//CG_DrawFlagIcons( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.blueFlagShader[cgs.blueflag] );
;1523:				}
LABELV $880
line 1524
;1524:			}
LABELV $878
line 1525
;1525:		}
LABELV $832
line 1527
;1526:		//Set color
;1527:		if ( cg_adjustTeamColors.integer && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR ) {
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
CNSTI4 0
EQI4 $900
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 3
EQI4 $900
line 1528
;1528:			if ( cgs.clientinfo[ cg.clientNum ].team != TEAM_RED && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR && strlen(cg_EnemyColors.string) >= cg_adjustTeamColors.integer ) {
ADDRLP4 68
CNSTI4 1776
ASGNI4
ADDRLP4 68
INDIRI4
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 1
EQI4 $906
ADDRLP4 68
INDIRI4
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 3
EQI4 $906
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 72
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
LTI4 $906
line 1529
;1529:				memcpy(color, g_color_table[ ColorIndex( cg_EnemyColors.string[cg_adjustTeamColors.integer - 1] ) ], sizeof(color));
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 cg_EnemyColors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 76
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
ARGP4
ADDRLP4 76
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
line 1530
;1530:			} else if ( cg_forceColors.integer && cgs.clientinfo[ cg.clientNum ].team == TEAM_RED && strlen(colors.string) >= cg_adjustTeamColors.integer ) {
ADDRGP4 $901
JUMPV
LABELV $906
ADDRGP4 cg_forceColors+12
INDIRI4
CNSTI4 0
EQI4 $919
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $919
ADDRGP4 colors+16
ARGP4
ADDRLP4 76
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
LTI4 $919
line 1531
;1531:				memcpy(color, g_color_table[ ColorIndex( colors.string[cg_adjustTeamColors.integer - 1] ) ], sizeof(color));
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 colors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 80
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
ARGP4
ADDRLP4 80
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
line 1532
;1532:			} else if ( cgs.clientinfo[ cg.clientNum ].team == TEAM_RED && strlen(cg_TeamColors.string) >= cg_adjustTeamColors.integer ) {
ADDRGP4 $901
JUMPV
LABELV $919
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $901
ADDRGP4 cg_TeamColors+16
ARGP4
ADDRLP4 80
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
LTI4 $901
line 1533
;1533:				memcpy(color, g_color_table[ ColorIndex( cg_TeamColors.string[cg_adjustTeamColors.integer - 1] ) ], sizeof(color));
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 cg_TeamColors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 84
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
ARGP4
ADDRLP4 84
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
line 1534
;1534:			}
line 1535
;1535:		} else {
ADDRGP4 $901
JUMPV
LABELV $900
line 1536
;1536:			color[0] = 1.0f;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 1537
;1537:			color[1] = 0.0f;
ADDRLP4 4+4
CNSTF4 0
ASGNF4
line 1538
;1538:			color[2] = 0.0f;
ADDRLP4 4+8
CNSTF4 0
ASGNF4
line 1539
;1539:		}
LABELV $901
line 1540
;1540:		color[3] = 0.33f;
ADDRLP4 4+12
CNSTF4 1051260355
ASGNF4
line 1541
;1541:		s = va( "%2i", s1 );
ADDRGP4 $826
ARGP4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 68
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 68
INDIRP4
ASGNP4
line 1542
;1542:		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 72
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1543
;1543:		x -= w;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 1545
;1544:
;1545:		CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1547
;1546:
;1547:		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $943
line 1548
;1548:			CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+156680+264
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1549
;1549:		}
LABELV $943
line 1551
;1550:
;1551:		CG_DrawStringExt(x + 4, y, s, colorWhite, qtrue, qfalse, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
ADDRLP4 0
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 76
CNSTI4 0
ASGNI4
ADDRLP4 76
INDIRI4
ARGI4
ADDRLP4 80
CNSTI4 16
ASGNI4
ADDRLP4 80
INDIRI4
ARGI4
ADDRLP4 80
INDIRI4
ARGI4
ADDRLP4 76
INDIRI4
ARGI4
ADDRLP4 76
INDIRI4
ARGI4
ADDRLP4 76
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1553
;1552:
;1553:		if ( cgs.gametype == GT_CTF ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
NEI4 $948
line 1555
;1554:			//Set the flag icon color
;1555:				if ( cg_adjustTeamColors.integer && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR ) {
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
CNSTI4 0
EQI4 $951
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 3
EQI4 $951
line 1556
;1556:					if ( cgs.clientinfo[ cg.clientNum ].team != TEAM_RED && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR && strlen(cg_EnemyColors.string) >= cg_adjustTeamColors.integer ) {
ADDRLP4 84
CNSTI4 1776
ASGNI4
ADDRLP4 84
INDIRI4
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 1
EQI4 $957
ADDRLP4 84
INDIRI4
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 3
EQI4 $957
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 88
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
LTI4 $957
line 1557
;1557:						trap_R_SetColor( g_color_table[ ColorIndex( cg_EnemyColors.string[cg_adjustTeamColors.integer - 1] ) ] );
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 cg_EnemyColors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 92
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1558
;1558:					} else if ( cg_forceColors.integer && cgs.clientinfo[ cg.clientNum ].team == TEAM_RED && strlen(colors.string) >= cg_adjustTeamColors.integer ) {
ADDRGP4 $958
JUMPV
LABELV $957
ADDRGP4 cg_forceColors+12
INDIRI4
CNSTI4 0
EQI4 $970
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $970
ADDRGP4 colors+16
ARGP4
ADDRLP4 92
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
LTI4 $970
line 1559
;1559:						trap_R_SetColor( g_color_table[ ColorIndex( colors.string[cg_adjustTeamColors.integer - 1] ) ] );
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 colors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 96
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1560
;1560:					} else if ( cgs.clientinfo[ cg.clientNum ].team == TEAM_RED && strlen(cg_TeamColors.string) >= cg_adjustTeamColors.integer ) {
ADDRGP4 $971
JUMPV
LABELV $970
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $981
ADDRGP4 cg_TeamColors+16
ARGP4
ADDRLP4 96
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 96
INDIRI4
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
LTI4 $981
line 1561
;1561:						trap_R_SetColor( g_color_table[ ColorIndex( cg_TeamColors.string[cg_adjustTeamColors.integer - 1] ) ] );
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 cg_TeamColors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 100
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1562
;1562:					}
LABELV $981
LABELV $971
LABELV $958
line 1563
;1563:				}
LABELV $951
line 1564
;1564:			}
LABELV $948
line 1567
;1565:
;1566:			// Display flag status
;1567:			item = BG_FindItemForPowerup( PW_REDFLAG );
CNSTI4 7
ARGI4
ADDRLP4 84
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 44
ADDRLP4 84
INDIRP4
ASGNP4
line 1569
;1568:
;1569:			if (item) {
ADDRLP4 44
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $991
line 1570
;1570:				y1 = y - BIGCHAR_HEIGHT - 8;
ADDRLP4 36
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1090519040
SUBF4
ASGNF4
line 1571
;1571:				if( cgs.flags[TEAM_RED-1] >= 0 && cgs.flags[TEAM_RED-1] <= 3 ) {
ADDRGP4 cgs+34796
INDIRI4
CNSTI4 0
LTI4 $993
ADDRGP4 cgs+34796
INDIRI4
CNSTI4 3
GTI4 $993
line 1572
;1572:					if ( cg_adjustTeamColors.integer && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR ) {
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
CNSTI4 0
EQI4 $997
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 3
EQI4 $997
line 1573
;1573:						CG_DrawPic( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.whiteFlagShader[cgs.flags[TEAM_RED-1]] );
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 36
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+34796
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+156680+100
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1574
;1574:					} else {
ADDRGP4 $998
JUMPV
LABELV $997
line 1575
;1575:						CG_DrawPic( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.redFlagShader[cgs.flags[TEAM_RED-1]] );
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 36
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+34796
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+156680+68
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1576
;1576:					}
LABELV $998
line 1577
;1577:				}
LABELV $993
line 1579
;1578:			
;1579:			}
LABELV $991
line 1595
;1580:		
;1581:
;1582:#ifdef MISSIONPACK
;1583:		if ( cgs.gametype == GT_1FCTF ) {
;1584:			// Display flag status
;1585:			item = BG_FindItemForPowerup( PW_NEUTRALFLAG );
;1586:
;1587:			if (item) {
;1588:				y1 = y - BIGCHAR_HEIGHT - 8;
;1589:				if( cgs.flagStatus >= 0 && cgs.flagStatus <= 3 ) {
;1590:					CG_DrawPic( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.flagShader[cgs.flagStatus] );
;1591:				}
;1592:			}
;1593:		}
;1594:#endif
;1595:		if ( cgs.gametype >= GT_CTF || g_gamemode.integer >= 4 ) {
ADDRLP4 88
CNSTI4 4
ASGNI4
ADDRGP4 cgs+31456
INDIRI4
ADDRLP4 88
INDIRI4
GEI4 $1013
ADDRGP4 g_gamemode+12
INDIRI4
ADDRLP4 88
INDIRI4
LTI4 $1009
LABELV $1013
line 1596
;1596:			v = cgs.capturelimit;
ADDRLP4 48
ADDRGP4 cgs+31472
INDIRI4
ASGNI4
line 1597
;1597:		} else {
ADDRGP4 $1010
JUMPV
LABELV $1009
line 1598
;1598:			v = cgs.fraglimit;
ADDRLP4 48
ADDRGP4 cgs+31468
INDIRI4
ASGNI4
line 1599
;1599:		}
LABELV $1010
line 1600
;1600:		if ( v ) {
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $781
line 1601
;1601:			s = va( "%2i", v );
ADDRGP4 $826
ARGP4
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 92
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 92
INDIRP4
ASGNP4
line 1602
;1602:			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 96
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 96
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1603
;1603:			x -= w;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 1605
;1604:			//CG_DrawBigString( x + 4, y, s, 1.0F);
;1605:			CG_DrawStringExt(x + 4, y, s, colorWhite, qtrue, qfalse,
ADDRLP4 0
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 100
CNSTI4 0
ASGNI4
ADDRLP4 100
INDIRI4
ARGI4
ADDRLP4 104
CNSTI4 16
ASGNI4
ADDRLP4 104
INDIRI4
ARGI4
ADDRLP4 104
INDIRI4
ARGI4
ADDRLP4 100
INDIRI4
ARGI4
ADDRLP4 100
INDIRI4
ARGI4
ADDRLP4 100
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1607
;1606:								BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
;1607:		}
line 1608
;1608:} else {
ADDRGP4 $781
JUMPV
LABELV $780
line 1611
;1609:		qboolean	spectator;
;1610:
;1611:		x = 640;
ADDRLP4 0
CNSTI4 640
ASGNI4
line 1612
;1612:		score = cg.snap->ps.persistant[PERS_SCORE];
ADDRLP4 40
ADDRGP4 cg+36
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ASGNI4
line 1613
;1613:		spectator = ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR );
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1021
ADDRLP4 56
CNSTI4 1
ASGNI4
ADDRGP4 $1022
JUMPV
LABELV $1021
ADDRLP4 56
CNSTI4 0
ASGNI4
LABELV $1022
ADDRLP4 52
ADDRLP4 56
INDIRI4
ASGNI4
line 1616
;1614:
;1615:		// always show your score in the second box if not in first place
;1616:		if ( s1 != score ) {
ADDRLP4 28
INDIRI4
ADDRLP4 40
INDIRI4
EQI4 $1023
line 1617
;1617:			s2 = score;
ADDRLP4 32
ADDRLP4 40
INDIRI4
ASGNI4
line 1618
;1618:		}
LABELV $1023
line 1619
;1619:		if ( s2 != SCORE_NOT_PRESENT ) {
ADDRLP4 32
INDIRI4
CNSTI4 -9999
EQI4 $1025
line 1620
;1620:			s = va( "%2i", s2 );
ADDRGP4 $826
ARGP4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 60
INDIRP4
ASGNP4
line 1621
;1621:			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 64
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1622
;1622:			x -= w;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 1623
;1623:			if ( !spectator && score == s2 && score != s1 ) {
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $1027
ADDRLP4 68
ADDRLP4 40
INDIRI4
ASGNI4
ADDRLP4 68
INDIRI4
ADDRLP4 32
INDIRI4
NEI4 $1027
ADDRLP4 68
INDIRI4
ADDRLP4 28
INDIRI4
EQI4 $1027
line 1624
;1624:				color[0] = 1.0f;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 1625
;1625:				color[1] = 0.0f;
ADDRLP4 4+4
CNSTF4 0
ASGNF4
line 1626
;1626:				color[2] = 0.0f;
ADDRLP4 4+8
CNSTF4 0
ASGNF4
line 1627
;1627:				color[3] = 0.33f;
ADDRLP4 4+12
CNSTF4 1051260355
ASGNF4
line 1628
;1628:				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1629
;1629:				CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+156680+264
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1630
;1630:			} else {
ADDRGP4 $1028
JUMPV
LABELV $1027
line 1631
;1631:				if ( cg_adjustTeamColors.integer && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR ) {
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
CNSTI4 0
EQI4 $1034
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 3
EQI4 $1034
line 1632
;1632:					memcpy(color, g_color_table[ ColorIndex( cg_EnemyColors.string[cg_adjustTeamColors.integer - 1] ) ], sizeof(color));
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 cg_EnemyColors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 72
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
ARGP4
ADDRLP4 72
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
line 1633
;1633:				} else {
ADDRGP4 $1035
JUMPV
LABELV $1034
line 1634
;1634:					color[0] = 0.5f;
ADDRLP4 4
CNSTF4 1056964608
ASGNF4
line 1635
;1635:					color[1] = 0.5f;
ADDRLP4 4+4
CNSTF4 1056964608
ASGNF4
line 1636
;1636:					color[2] = 0.5f;
ADDRLP4 4+8
CNSTF4 1056964608
ASGNF4
line 1637
;1637:				}
LABELV $1035
line 1638
;1638:				color[3] = 0.33f;
ADDRLP4 4+12
CNSTF4 1051260355
ASGNF4
line 1639
;1639:				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1640
;1640:			}	
LABELV $1028
line 1642
;1641:			//CG_DrawBigString( x + 4, y, s, 1.0F);
;1642:			CG_DrawStringExt(x + 4, y, s, colorWhite, qtrue, qfalse, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
ADDRLP4 0
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 72
CNSTI4 0
ASGNI4
ADDRLP4 72
INDIRI4
ARGI4
ADDRLP4 76
CNSTI4 16
ASGNI4
ADDRLP4 76
INDIRI4
ARGI4
ADDRLP4 76
INDIRI4
ARGI4
ADDRLP4 72
INDIRI4
ARGI4
ADDRLP4 72
INDIRI4
ARGI4
ADDRLP4 72
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1643
;1643:		}
LABELV $1025
line 1646
;1644:
;1645:		// first place
;1646:		if ( s1 != SCORE_NOT_PRESENT ) {
ADDRLP4 28
INDIRI4
CNSTI4 -9999
EQI4 $1046
line 1647
;1647:			s = va( "%2i", s1 );
ADDRGP4 $826
ARGP4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 60
INDIRP4
ASGNP4
line 1648
;1648:			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 64
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1649
;1649:			x -= w;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 1650
;1650:			if ( !spectator && score == s1 ) {
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $1048
ADDRLP4 40
INDIRI4
ADDRLP4 28
INDIRI4
NEI4 $1048
line 1651
;1651:				color[0] = 0.0f;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 1652
;1652:				color[1] = 0.0f;
ADDRLP4 4+4
CNSTF4 0
ASGNF4
line 1653
;1653:				color[2] = 1.0f;
ADDRLP4 4+8
CNSTF4 1065353216
ASGNF4
line 1654
;1654:				color[3] = 0.33f;
ADDRLP4 4+12
CNSTF4 1051260355
ASGNF4
line 1655
;1655:				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1656
;1656:				CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+156680+264
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1657
;1657:			} else {
ADDRGP4 $1049
JUMPV
LABELV $1048
line 1658
;1658:				if ( cg_adjustTeamColors.integer && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR ) {
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
CNSTI4 0
EQI4 $1055
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 3
EQI4 $1055
line 1659
;1659:					memcpy(color, g_color_table[ ColorIndex( cg_EnemyColors.string[cg_adjustTeamColors.integer - 1] ) ], sizeof(color));
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 cg_EnemyColors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 68
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
ARGP4
ADDRLP4 68
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
line 1660
;1660:				} else {
ADDRGP4 $1056
JUMPV
LABELV $1055
line 1661
;1661:					color[0] = 0.5f;
ADDRLP4 4
CNSTF4 1056964608
ASGNF4
line 1662
;1662:					color[1] = 0.5f;
ADDRLP4 4+4
CNSTF4 1056964608
ASGNF4
line 1663
;1663:					color[2] = 0.5f;
ADDRLP4 4+8
CNSTF4 1056964608
ASGNF4
line 1664
;1664:				}
LABELV $1056
line 1665
;1665:				color[3] = 0.33f;
ADDRLP4 4+12
CNSTF4 1051260355
ASGNF4
line 1666
;1666:				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1667
;1667:			}	
LABELV $1049
line 1669
;1668:			//CG_DrawBigString( x + 4, y, s, 1.0F);
;1669:			CG_DrawStringExt(x + 4, y, s, colorWhite, qtrue, qfalse,
ADDRLP4 0
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRLP4 68
INDIRI4
ARGI4
ADDRLP4 72
CNSTI4 16
ASGNI4
ADDRLP4 72
INDIRI4
ARGI4
ADDRLP4 72
INDIRI4
ARGI4
ADDRLP4 68
INDIRI4
ARGI4
ADDRLP4 68
INDIRI4
ARGI4
ADDRLP4 68
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1671
;1670:								BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
;1671:		}
LABELV $1046
line 1673
;1672:
;1673:		if ( cgs.fraglimit ) {
ADDRGP4 cgs+31468
INDIRI4
CNSTI4 0
EQI4 $1067
line 1674
;1674:			s = va( "%2i", cgs.fraglimit );
ADDRGP4 $826
ARGP4
ADDRGP4 cgs+31468
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 60
INDIRP4
ASGNP4
line 1675
;1675:			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 64
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1676
;1676:			x -= w;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 1678
;1677:			//CG_DrawBigString( x + 4, y, s, 1.0F);
;1678:			CG_DrawStringExt(x + 4, y, s, colorWhite, qtrue, qfalse,
ADDRLP4 0
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRLP4 68
INDIRI4
ARGI4
ADDRLP4 72
CNSTI4 16
ASGNI4
ADDRLP4 72
INDIRI4
ARGI4
ADDRLP4 72
INDIRI4
ARGI4
ADDRLP4 68
INDIRI4
ARGI4
ADDRLP4 68
INDIRI4
ARGI4
ADDRLP4 68
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1680
;1679:								BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
;1680:		}
LABELV $1067
line 1681
;1681:	}
LABELV $781
line 1683
;1682:
;1683:	return y1 - 8;
ADDRLP4 36
INDIRF4
CNSTF4 1090519040
SUBF4
RETF4
LABELV $777
endproc CG_DrawScores 108 44
data
align 4
LABELV $1072
byte 4 1045220557
byte 4 1065353216
byte 4 1045220557
byte 4 1065353216
byte 4 1065353216
byte 4 1045220557
byte 4 1045220557
byte 4 1065353216
code
proc CG_DrawPowerups 208 20
line 1693
;1684:}
;1685://#endif // MISSIONPACK
;1686:
;1687:/*
;1688:================
;1689:CG_DrawPowerups
;1690:================
;1691:*/
;1692:#ifndef MISSIONPACK
;1693:static float CG_DrawPowerups( float y ) {
line 1710
;1694:	int		sorted[MAX_POWERUPS];
;1695:	int		sortedTime[MAX_POWERUPS];
;1696:	int		i, j, k;
;1697:	int		active;
;1698:	playerState_t	*ps;
;1699:	int		t;
;1700:	gitem_t	*item;
;1701:	int		x;
;1702:	int		color;
;1703:	float	size;
;1704:	float	f;
;1705:	static float colors[2][4] = { 
;1706:    { 0.2f, 1.0f, 0.2f, 1.0f } , 
;1707:    { 1.0f, 0.2f, 0.2f, 1.0f } 
;1708:  };
;1709:
;1710:	ps = &cg.snap->ps;
ADDRLP4 148
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 1712
;1711:
;1712:	if ( ps->stats[STAT_HEALTH] <= 0 ) {
ADDRLP4 148
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $1074
line 1713
;1713:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $1071
JUMPV
LABELV $1074
line 1717
;1714:	}
;1715:
;1716:	// sort the list by time remaining
;1717:	active = 0;
ADDRLP4 136
CNSTI4 0
ASGNI4
line 1718
;1718:	for ( i = 0 ; i < MAX_POWERUPS ; i++ ) {
ADDRLP4 144
CNSTI4 0
ASGNI4
LABELV $1076
line 1719
;1719:		if ( !ps->powerups[ i ] ) {
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 148
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1080
line 1720
;1720:			continue;
ADDRGP4 $1077
JUMPV
LABELV $1080
line 1722
;1721:		}
;1722:		t = ps->powerups[ i ] - cg.time;
ADDRLP4 140
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 148
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
ASGNI4
line 1725
;1723:		// ZOID--don't draw if the power up has unlimited time (999 seconds)
;1724:		// This is true of the CTF flags
;1725:		if ( t < 0 || t > 999000) {
ADDRLP4 140
INDIRI4
CNSTI4 0
LTI4 $1085
ADDRLP4 140
INDIRI4
CNSTI4 999000
LEI4 $1083
LABELV $1085
line 1726
;1726:			continue;
ADDRGP4 $1077
JUMPV
LABELV $1083
line 1730
;1727:		}
;1728:
;1729:		// insert into the list
;1730:		for ( j = 0 ; j < active ; j++ ) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $1089
JUMPV
LABELV $1086
line 1731
;1731:			if ( sortedTime[j] >= t ) {
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ADDRLP4 140
INDIRI4
LTI4 $1090
line 1732
;1732:				for ( k = active - 1 ; k >= j ; k-- ) {
ADDRLP4 0
ADDRLP4 136
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $1095
JUMPV
LABELV $1092
line 1733
;1733:					sorted[k+1] = sorted[k];
ADDRLP4 176
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 176
INDIRI4
ADDRLP4 68+4
ADDP4
ADDRLP4 176
INDIRI4
ADDRLP4 68
ADDP4
INDIRI4
ASGNI4
line 1734
;1734:					sortedTime[k+1] = sortedTime[k];
ADDRLP4 180
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 180
INDIRI4
ADDRLP4 4+4
ADDP4
ADDRLP4 180
INDIRI4
ADDRLP4 4
ADDP4
INDIRI4
ASGNI4
line 1735
;1735:				}
LABELV $1093
line 1732
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $1095
ADDRLP4 0
INDIRI4
ADDRLP4 132
INDIRI4
GEI4 $1092
line 1736
;1736:				break;
ADDRGP4 $1088
JUMPV
LABELV $1090
line 1738
;1737:			}
;1738:		}
LABELV $1087
line 1730
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1089
ADDRLP4 132
INDIRI4
ADDRLP4 136
INDIRI4
LTI4 $1086
LABELV $1088
line 1739
;1739:		sorted[j] = i;
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
ADDP4
ADDRLP4 144
INDIRI4
ASGNI4
line 1740
;1740:		sortedTime[j] = t;
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ADDRLP4 140
INDIRI4
ASGNI4
line 1741
;1741:		active++;
ADDRLP4 136
ADDRLP4 136
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1742
;1742:	}
LABELV $1077
line 1718
ADDRLP4 144
ADDRLP4 144
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 16
LTI4 $1076
line 1745
;1743:
;1744:	// draw the icons and timers
;1745:	x = 640 - ICON_SIZE - CHAR_WIDTH * 2;
ADDRLP4 168
CNSTI4 528
ASGNI4
line 1746
;1746:	for ( i = 0 ; i < active ; i++ ) {
ADDRLP4 144
CNSTI4 0
ASGNI4
ADDRGP4 $1101
JUMPV
LABELV $1098
line 1747
;1747:		item = BG_FindItemForPowerup( sorted[i] );
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
ADDP4
INDIRI4
ARGI4
ADDRLP4 172
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 152
ADDRLP4 172
INDIRP4
ASGNP4
line 1749
;1748:
;1749:    if (item) {
ADDRLP4 152
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1102
line 1751
;1750:
;1751:		  color = 1;
ADDRLP4 164
CNSTI4 1
ASGNI4
line 1753
;1752:
;1753:		  y -= ICON_SIZE;
ADDRFP4 0
ADDRFP4 0
INDIRF4
CNSTF4 1111490560
SUBF4
ASGNF4
line 1755
;1754:
;1755:		  trap_R_SetColor( colors[color] );
ADDRLP4 164
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 $1072
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1756
;1756:		  CG_DrawField( x, y, 2, sortedTime[ i ] / 1000 );
ADDRLP4 168
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 176
CNSTI4 2
ASGNI4
ADDRLP4 176
INDIRI4
ARGI4
ADDRLP4 144
INDIRI4
ADDRLP4 176
INDIRI4
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
CNSTI4 1000
DIVI4
ARGI4
ADDRGP4 CG_DrawField
CALLV
pop
line 1758
;1757:
;1758:		  t = ps->powerups[ sorted[i] ];
ADDRLP4 180
CNSTI4 2
ASGNI4
ADDRLP4 140
ADDRLP4 144
INDIRI4
ADDRLP4 180
INDIRI4
LSHI4
ADDRLP4 68
ADDP4
INDIRI4
ADDRLP4 180
INDIRI4
LSHI4
ADDRLP4 148
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ASGNI4
line 1759
;1759:		  if ( t - cg.time >= POWERUP_BLINKS * POWERUP_BLINK_TIME ) {
ADDRLP4 140
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CNSTI4 5000
LTI4 $1104
line 1760
;1760:			  trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1761
;1761:		  } else {
ADDRGP4 $1105
JUMPV
LABELV $1104
line 1764
;1762:			  vec4_t	modulate;
;1763:
;1764:			  f = (float)( t - cg.time ) / POWERUP_BLINK_TIME;
ADDRLP4 160
ADDRLP4 140
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1148846080
DIVF4
ASGNF4
line 1765
;1765:			  f -= (int)f;
ADDRLP4 160
ADDRLP4 160
INDIRF4
ADDRLP4 160
INDIRF4
CVFI4 4
CVIF4 4
SUBF4
ASGNF4
line 1766
;1766:			  modulate[0] = modulate[1] = modulate[2] = modulate[3] = f;
ADDRLP4 184+12
ADDRLP4 160
INDIRF4
ASGNF4
ADDRLP4 184+8
ADDRLP4 160
INDIRF4
ASGNF4
ADDRLP4 184+4
ADDRLP4 160
INDIRF4
ASGNF4
ADDRLP4 184
ADDRLP4 160
INDIRF4
ASGNF4
line 1767
;1767:			  trap_R_SetColor( modulate );
ADDRLP4 184
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1768
;1768:		  }
LABELV $1105
line 1770
;1769:
;1770:		  if ( cg.powerupActive == sorted[i] && 
ADDRGP4 cg+130556
INDIRI4
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
ADDP4
INDIRI4
NEI4 $1111
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+130560
INDIRI4
SUBI4
CNSTI4 200
GEI4 $1111
line 1771
;1771:			  cg.time - cg.powerupTime < PULSE_TIME ) {
line 1772
;1772:			  f = 1.0 - ( ( (float)cg.time - cg.powerupTime ) / PULSE_TIME );
ADDRLP4 160
CNSTF4 1065353216
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ADDRGP4 cg+130560
INDIRI4
CVIF4 4
SUBF4
CNSTF4 1128792064
DIVF4
SUBF4
ASGNF4
line 1773
;1773:			  size = ICON_SIZE * ( 1.0 + ( PULSE_SCALE - 1.0 ) * f );
ADDRLP4 156
CNSTF4 1111490560
CNSTF4 1056964608
ADDRLP4 160
INDIRF4
MULF4
CNSTF4 1065353216
ADDF4
MULF4
ASGNF4
line 1774
;1774:		  } else {
ADDRGP4 $1112
JUMPV
LABELV $1111
line 1775
;1775:			  size = ICON_SIZE;
ADDRLP4 156
CNSTF4 1111490560
ASGNF4
line 1776
;1776:		  }
LABELV $1112
line 1778
;1777:
;1778:		  CG_DrawPic( 640 - size, y + ICON_SIZE / 2 - size / 2, 
ADDRLP4 152
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 184
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
CNSTF4 1142947840
ADDRLP4 156
INDIRF4
SUBF4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1103101952
ADDF4
ADDRLP4 156
INDIRF4
CNSTF4 1073741824
DIVF4
SUBF4
ARGF4
ADDRLP4 156
INDIRF4
ARGF4
ADDRLP4 156
INDIRF4
ARGF4
ADDRLP4 184
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1780
;1779:			  size, size, trap_R_RegisterShader( item->icon ) );
;1780:    }
LABELV $1102
line 1781
;1781:	}
LABELV $1099
line 1746
ADDRLP4 144
ADDRLP4 144
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1101
ADDRLP4 144
INDIRI4
ADDRLP4 136
INDIRI4
LTI4 $1098
line 1782
;1782:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1784
;1783:
;1784:	return y;
ADDRFP4 0
INDIRF4
RETF4
LABELV $1071
endproc CG_DrawPowerups 208 20
proc CG_DrawLowerRight 12 12
line 1795
;1785:}
;1786:#endif // MISSIONPACK
;1787:
;1788:/*
;1789:=====================
;1790:CG_DrawLowerRight
;1791:
;1792:=====================
;1793:*/
;1794:#ifndef MISSIONPACK
;1795:static void CG_DrawLowerRight( void ) {
line 1798
;1796:	float	y;
;1797:
;1798:	y = 480 - ICON_SIZE;
ADDRLP4 0
CNSTF4 1138229248
ASGNF4
line 1800
;1799:
;1800:	if ( cgs.gametype >= GT_TEAM && cg_drawTeamOverlay.integer == 2 ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $1119
ADDRGP4 cg_drawTeamOverlay+12
INDIRI4
CNSTI4 2
NEI4 $1119
line 1801
;1801:		y = CG_DrawTeamOverlay( y, qtrue, qfalse );
ADDRLP4 0
INDIRF4
ARGF4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 CG_DrawTeamOverlay
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1802
;1802:	} 
LABELV $1119
line 1804
;1803:
;1804:	y = CG_DrawScores( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 CG_DrawScores
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1805
;1805:	y = CG_DrawPowerups( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 CG_DrawPowerups
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 1806
;1806:}
LABELV $1118
endproc CG_DrawLowerRight 12 12
proc CG_DrawPickupItem 56 44
line 1815
;1807:#endif // MISSIONPACK
;1808:
;1809:/*
;1810:===================
;1811:CG_DrawPickupItem
;1812:===================
;1813:*/
;1814:#ifndef MISSIONPACK
;1815:static int CG_DrawPickupItem( int y ) {
line 1820
;1816:	int		value;
;1817:	float	*fadeColor;
;1818:	float	*fontFade;//Doesn't remove text...
;1819:
;1820:	if ( cg.snap->ps.stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
GTI4 $1124
line 1821
;1821:		return y;
ADDRFP4 0
INDIRI4
RETI4
ADDRGP4 $1123
JUMPV
LABELV $1124
line 1824
;1822:	}
;1823:
;1824:	value = cg.itemPickup;
ADDRLP4 0
ADDRGP4 cg+130812
INDIRI4
ASGNI4
line 1825
;1825:	if ( !value ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1128
line 1826
;1826:		return y;
ADDRFP4 0
INDIRI4
RETI4
ADDRGP4 $1123
JUMPV
LABELV $1128
line 1829
;1827:	}
;1828:
;1829:	y -= ICON_SIZE;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 48
SUBI4
ASGNI4
line 1832
;1830:
;1831:	
;1832:	fadeColor = CG_FadeColor( cg.itemPickupTime, 3000 );
ADDRGP4 cg+130816
INDIRI4
ARGI4
CNSTI4 3000
ARGI4
ADDRLP4 12
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 12
INDIRP4
ASGNP4
line 1833
;1833:	if ( fadeColor ) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1131
line 1834
;1834:		CG_RegisterItemVisuals( value );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_RegisterItemVisuals
CALLV
pop
line 1835
;1835:		if ( cgs.gametype == GT_CTF && bg_itemlist[value].giType == IT_TEAM && cg.itemPickupFlag == PW_BLUEFLAG ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
NEI4 $1133
ADDRLP4 16
CNSTI4 8
ASGNI4
CNSTI4 52
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist+36
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $1133
ADDRGP4 cg+130824
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $1133
line 1837
;1836:			//CG_Printf("DrawPickup: %i -- %i -- set blue\n", bg_itemlist[value].giType, bg_itemlist[value].giTag );
;1837:			if ( cg_adjustTeamColors.integer && cgs.clientinfo[ cg.clientNum ].team != TEAM_BLUE && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR && strlen(cg_EnemyColors.string) >= cg_adjustTeamColors.integer ) {
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
CNSTI4 0
EQI4 $1138
ADDRLP4 20
CNSTI4 1776
ASGNI4
ADDRLP4 20
INDIRI4
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 2
EQI4 $1138
ADDRLP4 24
CNSTI4 3
ASGNI4
ADDRLP4 20
INDIRI4
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $1138
ADDRLP4 20
INDIRI4
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $1138
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 28
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
LTI4 $1138
line 1838
;1838:				fadeColor[0] = g_color_table[ ColorIndex( cg_EnemyColors.string[cg_adjustTeamColors.integer - 1] ) ][0];
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 cg_EnemyColors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 32
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 32
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
INDIRF4
ASGNF4
line 1839
;1839:				fadeColor[1] = g_color_table[ ColorIndex( cg_EnemyColors.string[cg_adjustTeamColors.integer - 1] ) ][1];
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 cg_EnemyColors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 36
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 36
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+4
ADDP4
INDIRF4
ASGNF4
line 1840
;1840:				fadeColor[2] = g_color_table[ ColorIndex( cg_EnemyColors.string[cg_adjustTeamColors.integer - 1] ) ][2];
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 cg_EnemyColors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 40
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 40
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+8
ADDP4
INDIRF4
ASGNF4
line 1841
;1841:			} else if ( cg_adjustTeamColors.integer && cg_forceColors.integer && cgs.clientinfo[ cg.clientNum ].team == TEAM_BLUE && strlen(colors.string) >= cg_adjustTeamColors.integer ) {
ADDRGP4 $1134
JUMPV
LABELV $1138
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRLP4 32
INDIRI4
EQI4 $1163
ADDRGP4 cg_forceColors+12
INDIRI4
ADDRLP4 32
INDIRI4
EQI4 $1163
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1163
ADDRGP4 colors+16
ARGP4
ADDRLP4 36
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
LTI4 $1163
line 1842
;1842:				fadeColor[0] = g_color_table[ ColorIndex( colors.string[cg_adjustTeamColors.integer - 1] ) ][0];
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 colors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 40
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 40
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
INDIRF4
ASGNF4
line 1843
;1843:				fadeColor[1] = g_color_table[ ColorIndex( colors.string[cg_adjustTeamColors.integer - 1] ) ][1];
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 colors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 44
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 44
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+4
ADDP4
INDIRF4
ASGNF4
line 1844
;1844:				fadeColor[2] = g_color_table[ ColorIndex( colors.string[cg_adjustTeamColors.integer - 1] ) ][2];
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 colors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 48
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 48
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+8
ADDP4
INDIRF4
ASGNF4
line 1845
;1845:			} else if ( cg_adjustTeamColors.integer && cgs.clientinfo[ cg.clientNum ].team == TEAM_BLUE && strlen(cg_TeamColors.string) >= cg_adjustTeamColors.integer ) {
ADDRGP4 $1134
JUMPV
LABELV $1163
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
CNSTI4 0
EQI4 $1134
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1134
ADDRGP4 cg_TeamColors+16
ARGP4
ADDRLP4 40
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
LTI4 $1134
line 1846
;1846:				fadeColor[0] = g_color_table[ ColorIndex( cg_TeamColors.string[cg_adjustTeamColors.integer - 1] ) ][0];
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 cg_TeamColors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 44
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 44
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
INDIRF4
ASGNF4
line 1847
;1847:				fadeColor[1] = g_color_table[ ColorIndex( cg_TeamColors.string[cg_adjustTeamColors.integer - 1] ) ][1];
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 cg_TeamColors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 48
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 48
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+4
ADDP4
INDIRF4
ASGNF4
line 1848
;1848:				fadeColor[2] = g_color_table[ ColorIndex( cg_TeamColors.string[cg_adjustTeamColors.integer - 1] ) ][2];
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 cg_TeamColors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 52
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 52
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+8
ADDP4
INDIRF4
ASGNF4
line 1849
;1849:			}
line 1850
;1850:		} else if ( cgs.gametype == GT_CTF && bg_itemlist[value].giType == IT_TEAM && cg.itemPickupFlag == PW_REDFLAG ) {
ADDRGP4 $1134
JUMPV
LABELV $1133
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
NEI4 $1202
CNSTI4 52
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist+36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $1202
ADDRGP4 cg+130824
INDIRI4
CNSTI4 7
NEI4 $1202
line 1852
;1851:			//CG_Printf("DrawPickup: %i -- %i -- set red\n", bg_itemlist[value].giType, bg_itemlist[value].giTag );
;1852:			if ( cg_adjustTeamColors.integer && cgs.clientinfo[ cg.clientNum ].team != TEAM_RED && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR && cgs.clientinfo[ cg.clientNum ].team != TEAM_SPECTATOR && strlen(cg_EnemyColors.string) >= cg_adjustTeamColors.integer ) {
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
CNSTI4 0
EQI4 $1207
ADDRLP4 20
CNSTI4 1776
ASGNI4
ADDRLP4 20
INDIRI4
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 1
EQI4 $1207
ADDRLP4 24
CNSTI4 3
ASGNI4
ADDRLP4 20
INDIRI4
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $1207
ADDRLP4 20
INDIRI4
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $1207
ADDRGP4 cg_EnemyColors+16
ARGP4
ADDRLP4 28
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
LTI4 $1207
line 1853
;1853:				fadeColor[0] = g_color_table[ ColorIndex( cg_EnemyColors.string[cg_adjustTeamColors.integer - 1] ) ][0];
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 cg_EnemyColors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 32
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 32
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
INDIRF4
ASGNF4
line 1854
;1854:				fadeColor[1] = g_color_table[ ColorIndex( cg_EnemyColors.string[cg_adjustTeamColors.integer - 1] ) ][1];
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 cg_EnemyColors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 36
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 36
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+4
ADDP4
INDIRF4
ASGNF4
line 1855
;1855:				fadeColor[2] = g_color_table[ ColorIndex( cg_EnemyColors.string[cg_adjustTeamColors.integer - 1] ) ][2];
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 cg_EnemyColors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 40
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 40
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+8
ADDP4
INDIRF4
ASGNF4
line 1856
;1856:			} else if ( cg_adjustTeamColors.integer && cg_forceColors.integer && cgs.clientinfo[ cg.clientNum ].team == TEAM_RED && strlen(colors.string) >= cg_adjustTeamColors.integer ) {
ADDRGP4 $1208
JUMPV
LABELV $1207
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRLP4 32
INDIRI4
EQI4 $1232
ADDRGP4 cg_forceColors+12
INDIRI4
ADDRLP4 32
INDIRI4
EQI4 $1232
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1232
ADDRGP4 colors+16
ARGP4
ADDRLP4 36
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
LTI4 $1232
line 1857
;1857:				fadeColor[0] = g_color_table[ ColorIndex( colors.string[cg_adjustTeamColors.integer - 1] ) ][0];
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 colors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 40
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 40
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
INDIRF4
ASGNF4
line 1858
;1858:				fadeColor[1] = g_color_table[ ColorIndex( colors.string[cg_adjustTeamColors.integer - 1] ) ][1];
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 colors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 44
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 44
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+4
ADDP4
INDIRF4
ASGNF4
line 1859
;1859:				fadeColor[2] = g_color_table[ ColorIndex( colors.string[cg_adjustTeamColors.integer - 1] ) ][2];
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 colors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 48
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 48
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+8
ADDP4
INDIRF4
ASGNF4
line 1860
;1860:			} else if ( cg_adjustTeamColors.integer && cgs.clientinfo[ cg.clientNum ].team == TEAM_RED && strlen(cg_TeamColors.string) >= cg_adjustTeamColors.integer ) {
ADDRGP4 $1233
JUMPV
LABELV $1232
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
CNSTI4 0
EQI4 $1252
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1252
ADDRGP4 cg_TeamColors+16
ARGP4
ADDRLP4 40
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
LTI4 $1252
line 1861
;1861:				fadeColor[0] = g_color_table[ ColorIndex( cg_TeamColors.string[cg_adjustTeamColors.integer - 1] ) ][0];
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 cg_TeamColors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 44
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 44
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
INDIRF4
ASGNF4
line 1862
;1862:				fadeColor[1] = g_color_table[ ColorIndex( cg_TeamColors.string[cg_adjustTeamColors.integer - 1] ) ][1];
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 cg_TeamColors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 48
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 48
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+4
ADDP4
INDIRF4
ASGNF4
line 1863
;1863:				fadeColor[2] = g_color_table[ ColorIndex( cg_TeamColors.string[cg_adjustTeamColors.integer - 1] ) ][2];
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
ADDRGP4 cg_TeamColors+16-1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 52
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 52
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table+8
ADDP4
INDIRF4
ASGNF4
line 1864
;1864:			}
LABELV $1252
LABELV $1233
LABELV $1208
line 1865
;1865:		}
LABELV $1202
LABELV $1134
line 1866
;1866:		trap_R_SetColor( fadeColor );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1867
;1867:		if ( cg_adjustTeamColors.integer && bg_itemlist[value].giType == IT_TEAM ) {
ADDRGP4 cg_adjustTeamColors+12
INDIRI4
CNSTI4 0
EQI4 $1271
CNSTI4 52
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist+36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $1271
line 1868
;1868:			CG_DrawPic( 8, y, ICON_SIZE, ICON_SIZE, trap_R_RegisterShader("icons/iconf_fla1") );
ADDRGP4 $754
ARGP4
ADDRLP4 20
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
CNSTF4 1090519040
ARGF4
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
CNSTF4 1111490560
ASGNF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 20
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1869
;1869:		} else {
ADDRGP4 $1272
JUMPV
LABELV $1271
line 1870
;1870:			CG_DrawPic( 8, y, ICON_SIZE, ICON_SIZE, cg_items[ value ].icon );
CNSTF4 1090519040
ARGF4
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
CNSTF4 1111490560
ASGNF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cg_items+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1871
;1871:		}
LABELV $1272
line 1872
;1872:	}
LABELV $1131
line 1874
;1873:
;1874:	fontFade = CG_FadeColor( cg.itemPickupTime, 3000 );
ADDRGP4 cg+130816
INDIRI4
ARGI4
CNSTI4 3000
ARGI4
ADDRLP4 16
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 16
INDIRP4
ASGNP4
line 1875
;1875:	if ( fontFade ) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1277
line 1876
;1876:		CG_DrawStringExt(ICON_SIZE + 16, y + (ICON_SIZE/2 - BIGCHAR_HEIGHT/2), bg_itemlist[ value ].pickup_name, fontFade, qfalse, qfalse,
CNSTI4 64
ARGI4
ADDRLP4 20
CNSTI4 16
ASGNI4
ADDRFP4 0
INDIRI4
ADDRLP4 20
INDIRI4
ADDI4
ARGI4
CNSTI4 52
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist+28
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1878
;1877:						BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
;1878:	}
LABELV $1277
line 1879
;1879:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1882
;1880:
;1881:	
;1882:	return y;
ADDRFP4 0
INDIRI4
RETI4
LABELV $1123
endproc CG_DrawPickupItem 56 44
proc CG_DrawLowerLeft 16 12
line 1893
;1883:}
;1884:#endif // MISSIONPACK
;1885:
;1886:/*
;1887:=====================
;1888:CG_DrawLowerLeft
;1889:
;1890:=====================
;1891:*/
;1892:#ifndef MISSIONPACK
;1893:static void CG_DrawLowerLeft( void ) {
line 1896
;1894:	float	y;
;1895:
;1896:	y = 480 - ICON_SIZE;
ADDRLP4 0
CNSTF4 1138229248
ASGNF4
line 1898
;1897:
;1898:	if ( cgs.gametype >= GT_TEAM && cg_drawTeamOverlay.integer == 3 ) {
ADDRLP4 4
CNSTI4 3
ASGNI4
ADDRGP4 cgs+31456
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $1281
ADDRGP4 cg_drawTeamOverlay+12
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $1281
line 1899
;1899:		y = CG_DrawTeamOverlay( y, qfalse, qfalse );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 CG_DrawTeamOverlay
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ASGNF4
line 1900
;1900:	} 
LABELV $1281
line 1903
;1901:
;1902:
;1903:	y = CG_DrawPickupItem( y );
ADDRLP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 8
ADDRGP4 CG_DrawPickupItem
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
CVIF4 4
ASGNF4
line 1904
;1904:}
LABELV $1280
endproc CG_DrawLowerLeft 16 12
export CG_DrawTeamInfo
proc CG_DrawTeamInfo 56 44
line 1916
;1905:#endif // MISSIONPACK
;1906:
;1907:
;1908://===========================================================================================
;1909:
;1910:/*
;1911:=================
;1912:CG_DrawTeamInfo
;1913:=================
;1914:*/
;1915:#ifndef MISSIONPACK
;1916:void CG_DrawTeamInfo( void ) {
line 1925
;1917:	int w, h;
;1918:	int i, len;
;1919:	vec4_t		hcolor;
;1920:	int		chatHeight;
;1921:
;1922:#define CHATLOC_Y 420 // bottom end
;1923:#define CHATLOC_X 0
;1924:
;1925:	if (cg_teamChatHeight.integer < TEAMCHAT_HEIGHT)
ADDRGP4 cg_teamChatHeight+12
INDIRI4
CNSTI4 8
GEI4 $1286
line 1926
;1926:		chatHeight = cg_teamChatHeight.integer;
ADDRLP4 8
ADDRGP4 cg_teamChatHeight+12
INDIRI4
ASGNI4
ADDRGP4 $1287
JUMPV
LABELV $1286
line 1928
;1927:	else
;1928:		chatHeight = TEAMCHAT_HEIGHT;
ADDRLP4 8
CNSTI4 8
ASGNI4
LABELV $1287
line 1929
;1929:	if (chatHeight <= 0)
ADDRLP4 8
INDIRI4
CNSTI4 0
GTI4 $1290
line 1930
;1930:		return; // disabled
ADDRGP4 $1285
JUMPV
LABELV $1290
line 1932
;1931:
;1932:	if (cgs.teamLastChatPos != cgs.teamChatPos) {
ADDRGP4 cgs+156588
INDIRI4
ADDRGP4 cgs+156584
INDIRI4
EQI4 $1292
line 1933
;1933:		if (cg.time - cgs.teamChatMsgTimes[cgs.teamLastChatPos % chatHeight] > cg_teamChatTime.integer) {
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cgs+156588
INDIRI4
ADDRLP4 8
INDIRI4
MODI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+156552
ADDP4
INDIRI4
SUBI4
ADDRGP4 cg_teamChatTime+12
INDIRI4
LEI4 $1296
line 1934
;1934:			cgs.teamLastChatPos++;
ADDRLP4 36
ADDRGP4 cgs+156588
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1935
;1935:		}
LABELV $1296
line 1937
;1936:
;1937:		h = (cgs.teamChatPos - cgs.teamLastChatPos) * TINYCHAR_HEIGHT;
ADDRLP4 32
ADDRGP4 cgs+156584
INDIRI4
ADDRGP4 cgs+156588
INDIRI4
SUBI4
CNSTI4 3
LSHI4
ASGNI4
line 1939
;1938:
;1939:		w = 0;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 1941
;1940:
;1941:		for (i = cgs.teamLastChatPos; i < cgs.teamChatPos; i++) {
ADDRLP4 0
ADDRGP4 cgs+156588
INDIRI4
ASGNI4
ADDRGP4 $1308
JUMPV
LABELV $1305
line 1942
;1942:			len = CG_DrawStrlen(cgs.teamChatMsgs[i % chatHeight]);
CNSTI4 241
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
MODI4
MULI4
ADDRGP4 cgs+154624
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 36
INDIRI4
ASGNI4
line 1943
;1943:			if (len > w)
ADDRLP4 4
INDIRI4
ADDRLP4 28
INDIRI4
LEI4 $1312
line 1944
;1944:				w = len;
ADDRLP4 28
ADDRLP4 4
INDIRI4
ASGNI4
LABELV $1312
line 1945
;1945:		}
LABELV $1306
line 1941
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1308
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+156584
INDIRI4
LTI4 $1305
line 1946
;1946:		w *= TINYCHAR_WIDTH;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
line 1947
;1947:		w += TINYCHAR_WIDTH * 2;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 1949
;1948:
;1949:		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1314
line 1950
;1950:			hcolor[0] = 1.0f;
ADDRLP4 12
CNSTF4 1065353216
ASGNF4
line 1951
;1951:			hcolor[1] = 0.0f;
ADDRLP4 12+4
CNSTF4 0
ASGNF4
line 1952
;1952:			hcolor[2] = 0.0f;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 1953
;1953:			hcolor[3] = 0.33f;
ADDRLP4 12+12
CNSTF4 1051260355
ASGNF4
line 1954
;1954:		} else if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
ADDRGP4 $1315
JUMPV
LABELV $1314
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1320
line 1955
;1955:			hcolor[0] = 0.0f;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 1956
;1956:			hcolor[1] = 0.0f;
ADDRLP4 12+4
CNSTF4 0
ASGNF4
line 1957
;1957:			hcolor[2] = 1.0f;
ADDRLP4 12+8
CNSTF4 1065353216
ASGNF4
line 1958
;1958:			hcolor[3] = 0.33f;
ADDRLP4 12+12
CNSTF4 1051260355
ASGNF4
line 1959
;1959:		} else {
ADDRGP4 $1321
JUMPV
LABELV $1320
line 1960
;1960:			hcolor[0] = 0.0f;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 1961
;1961:			hcolor[1] = 1.0f;
ADDRLP4 12+4
CNSTF4 1065353216
ASGNF4
line 1962
;1962:			hcolor[2] = 0.0f;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 1963
;1963:			hcolor[3] = 0.33f;
ADDRLP4 12+12
CNSTF4 1051260355
ASGNF4
line 1964
;1964:		}
LABELV $1321
LABELV $1315
line 1966
;1965:
;1966:		trap_R_SetColor( hcolor );
ADDRLP4 12
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1967
;1967:		CG_DrawPic( CHATLOC_X, CHATLOC_Y - h, 640, h, cgs.media.teamStatusBar );
CNSTF4 0
ARGF4
ADDRLP4 36
ADDRLP4 32
INDIRI4
ASGNI4
CNSTI4 420
ADDRLP4 36
INDIRI4
SUBI4
CVIF4 4
ARGF4
CNSTF4 1142947840
ARGF4
ADDRLP4 36
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 cgs+156680+180
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1968
;1968:		trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1970
;1969:
;1970:		hcolor[0] = hcolor[1] = hcolor[2] = 1.0f;
ADDRLP4 40
CNSTF4 1065353216
ASGNF4
ADDRLP4 12+8
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 40
INDIRF4
ASGNF4
line 1971
;1971:		hcolor[3] = 1.0f;
ADDRLP4 12+12
CNSTF4 1065353216
ASGNF4
line 1973
;1972:
;1973:		for (i = cgs.teamChatPos - 1; i >= cgs.teamLastChatPos; i--) {
ADDRLP4 0
ADDRGP4 cgs+156584
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $1337
JUMPV
LABELV $1334
line 1974
;1974:			CG_DrawStringExt( CHATLOC_X + TINYCHAR_WIDTH, 
ADDRLP4 44
CNSTI4 8
ASGNI4
ADDRLP4 44
INDIRI4
ARGI4
CNSTI4 420
ADDRGP4 cgs+156584
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 3
LSHI4
SUBI4
ARGI4
CNSTI4 241
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
MODI4
MULI4
ADDRGP4 cgs+154624
ADDP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1978
;1975:				CHATLOC_Y - (cgs.teamChatPos - i)*TINYCHAR_HEIGHT, 
;1976:				cgs.teamChatMsgs[i % chatHeight], hcolor, qfalse, qfalse,
;1977:				TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0, 0, 0 );
;1978:		}
LABELV $1335
line 1973
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $1337
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+156588
INDIRI4
GEI4 $1334
line 1979
;1979:	}
LABELV $1292
line 1980
;1980:}
LABELV $1285
endproc CG_DrawTeamInfo 56 44
export CG_DrawHoldableItem
proc CG_DrawHoldableItem 8 20
line 1989
;1981:#endif // MISSIONPACK
;1982:
;1983:/*
;1984:===================
;1985:CG_DrawHoldableItem
;1986:===================
;1987:*/
;1988:#ifndef MISSIONPACK
;1989:void CG_DrawHoldableItem( void ) { 
line 1992
;1990:	int		value;
;1991:
;1992:	value = cg.snap->ps.stats[STAT_HOLDABLE_ITEM];
ADDRLP4 0
ADDRGP4 cg+36
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ASGNI4
line 1993
;1993:	if ( value ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1344
line 1994
;1994:		CG_RegisterItemVisuals( value );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_RegisterItemVisuals
CALLV
pop
line 1995
;1995:		CG_DrawPic( 640-ICON_SIZE, (SCREEN_HEIGHT-ICON_SIZE)/2, ICON_SIZE, ICON_SIZE, cg_items[ value ].icon );
CNSTF4 1142161408
ARGF4
CNSTF4 1129840640
ARGF4
ADDRLP4 4
CNSTF4 1111490560
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cg_items+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1996
;1996:	}
LABELV $1344
line 1998
;1997:
;1998:}
LABELV $1342
endproc CG_DrawHoldableItem 8 20
export CG_DrawReward
proc CG_DrawReward 68 44
line 2026
;1999:#endif // MISSIONPACK
;2000:
;2001:#ifdef MISSIONPACK
;2002:/*
;2003:===================
;2004:CG_DrawPersistantPowerup
;2005:===================
;2006:*/
;2007:#if 0 // sos001208 - DEAD
;2008:static void CG_DrawPersistantPowerup( void ) { 
;2009:	int		value;
;2010:
;2011:	value = cg.snap->ps.stats[STAT_PERSISTANT_POWERUP];
;2012:	if ( value ) {
;2013:		CG_RegisterItemVisuals( value );
;2014:		CG_DrawPic( 640-ICON_SIZE, (SCREEN_HEIGHT-ICON_SIZE)/2 - ICON_SIZE, ICON_SIZE, ICON_SIZE, cg_items[ value ].icon );
;2015:	}
;2016:}
;2017:#endif
;2018:#endif // MISSIONPACK
;2019:
;2020:
;2021:/*
;2022:===================
;2023:CG_DrawReward
;2024:===================
;2025:*/
;2026:void CG_DrawReward( void ) { 
line 2032
;2027:	float	*color;
;2028:	int		i, count;
;2029:	float	x, y;
;2030:	char	buf[32];
;2031:
;2032:	if ( cg_drawRewards.integer != 1 ) {
ADDRGP4 cg_drawRewards+12
INDIRI4
CNSTI4 1
EQI4 $1348
line 2033
;2033:		return;
ADDRGP4 $1347
JUMPV
LABELV $1348
line 2036
;2034:	}
;2035:
;2036:	color = CG_FadeColor( cg.rewardTime, REWARD_TIME );
ADDRGP4 cg+130576
INDIRI4
ARGI4
CNSTI4 3000
ARGI4
ADDRLP4 52
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 52
INDIRP4
ASGNP4
line 2037
;2037:	if ( !color ) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1352
line 2038
;2038:		if (cg.rewardStack > 0) {
ADDRGP4 cg+130572
INDIRI4
CNSTI4 0
LEI4 $1347
line 2039
;2039:			for(i = 0; i < cg.rewardStack; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1360
JUMPV
LABELV $1357
line 2040
;2040:				cg.rewardSound[i] = cg.rewardSound[i+1];
ADDRLP4 56
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 56
INDIRI4
ADDRGP4 cg+130660
ADDP4
ADDRLP4 56
INDIRI4
ADDRGP4 cg+130660+4
ADDP4
INDIRI4
ASGNI4
line 2041
;2041:				cg.rewardShader[i] = cg.rewardShader[i+1];
ADDRLP4 60
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 60
INDIRI4
ADDRGP4 cg+130620
ADDP4
ADDRLP4 60
INDIRI4
ADDRGP4 cg+130620+4
ADDP4
INDIRI4
ASGNI4
line 2042
;2042:				cg.rewardCount[i] = cg.rewardCount[i+1];
ADDRLP4 64
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 64
INDIRI4
ADDRGP4 cg+130580
ADDP4
ADDRLP4 64
INDIRI4
ADDRGP4 cg+130580+4
ADDP4
INDIRI4
ASGNI4
line 2043
;2043:			}
LABELV $1358
line 2039
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1360
ADDRLP4 0
INDIRI4
ADDRGP4 cg+130572
INDIRI4
LTI4 $1357
line 2044
;2044:			cg.rewardTime = cg.time;
ADDRGP4 cg+130576
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 2045
;2045:			cg.rewardStack--;
ADDRLP4 56
ADDRGP4 cg+130572
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2046
;2046:			color = CG_FadeColor( cg.rewardTime, REWARD_TIME );
ADDRGP4 cg+130576
INDIRI4
ARGI4
CNSTI4 3000
ARGI4
ADDRLP4 60
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 60
INDIRP4
ASGNP4
line 2047
;2047:			trap_S_StartLocalSound(cg.rewardSound[0], CHAN_ANNOUNCER);
ADDRGP4 cg+130660
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2048
;2048:		} else {
line 2049
;2049:			return;
LABELV $1355
line 2051
;2050:		}
;2051:	}
LABELV $1352
line 2053
;2052:
;2053:	trap_R_SetColor( color );
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2070
;2054:
;2055:	/*
;2056:	count = cg.rewardCount[0]/10;				// number of big rewards to draw
;2057:
;2058:	if (count) {
;2059:		y = 4;
;2060:		x = 320 - count * ICON_SIZE;
;2061:		for ( i = 0 ; i < count ; i++ ) {
;2062:			CG_DrawPic( x, y, (ICON_SIZE*2)-4, (ICON_SIZE*2)-4, cg.rewardShader[0] );
;2063:			x += (ICON_SIZE*2);
;2064:		}
;2065:	}
;2066:
;2067:	count = cg.rewardCount[0] - count*10;		// number of small rewards to draw
;2068:	*/
;2069:
;2070:	if ( cg.rewardCount[0] >= 10 ) {
ADDRGP4 cg+130580
INDIRI4
CNSTI4 10
LTI4 $1376
line 2071
;2071:		y = 56;
ADDRLP4 8
CNSTF4 1113587712
ASGNF4
line 2072
;2072:		x = 320 - ICON_SIZE/2;
ADDRLP4 4
CNSTF4 1133772800
ASGNF4
line 2073
;2073:		CG_DrawPic( x, y, ICON_SIZE-4, ICON_SIZE-4, cg.rewardShader[0] );
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 56
CNSTF4 1110441984
ASGNF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRGP4 cg+130620
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 2074
;2074:		Com_sprintf(buf, sizeof(buf), "%d", cg.rewardCount[0]);
ADDRLP4 20
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $1380
ARGP4
ADDRGP4 cg+130580
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 2075
;2075:		x = ( SCREEN_WIDTH - SMALLCHAR_WIDTH * CG_DrawStrlen( buf ) ) / 2;
ADDRLP4 20
ARGP4
ADDRLP4 60
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 4
CNSTI4 640
ADDRLP4 60
INDIRI4
CNSTI4 3
LSHI4
SUBI4
CNSTI4 2
DIVI4
CVIF4 4
ASGNF4
line 2076
;2076:		CG_DrawStringExt( x, y+ICON_SIZE, buf, color, qfalse, qtrue,
ADDRLP4 4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 8
INDIRF4
CNSTF4 1111490560
ADDF4
CVFI4 4
ARGI4
ADDRLP4 20
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 64
CNSTI4 0
ASGNI4
ADDRLP4 64
INDIRI4
ARGI4
CNSTI4 1
ARGI4
CNSTI4 8
ARGI4
CNSTI4 16
ARGI4
ADDRLP4 64
INDIRI4
ARGI4
ADDRLP4 64
INDIRI4
ARGI4
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2078
;2077:								SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0, 0, 0 );
;2078:	}
ADDRGP4 $1377
JUMPV
LABELV $1376
line 2079
;2079:	else {
line 2081
;2080:
;2081:		count = cg.rewardCount[0];
ADDRLP4 12
ADDRGP4 cg+130580
INDIRI4
ASGNI4
line 2083
;2082:
;2083:		y = 56;
ADDRLP4 8
CNSTF4 1113587712
ASGNF4
line 2084
;2084:		x = 320 - count * ICON_SIZE/2;
ADDRLP4 4
CNSTI4 320
CNSTI4 48
ADDRLP4 12
INDIRI4
MULI4
CNSTI4 2
DIVI4
SUBI4
CVIF4 4
ASGNF4
line 2085
;2085:		for ( i = 0 ; i < count ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1386
JUMPV
LABELV $1383
line 2086
;2086:			CG_DrawPic( x, y, ICON_SIZE-4, ICON_SIZE-4, cg.rewardShader[0] );
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 56
CNSTF4 1110441984
ASGNF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRGP4 cg+130620
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 2087
;2087:			x += ICON_SIZE;
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1111490560
ADDF4
ASGNF4
line 2088
;2088:		}
LABELV $1384
line 2085
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1386
ADDRLP4 0
INDIRI4
ADDRLP4 12
INDIRI4
LTI4 $1383
line 2089
;2089:	}
LABELV $1377
line 2090
;2090:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2091
;2091:}
LABELV $1347
endproc CG_DrawReward 68 44
export CG_AddLagometerFrameInfo
proc CG_AddLagometerFrameInfo 8 0
line 2111
;2092:
;2093:
;2094:/*
;2095:===============================================================================
;2096:
;2097:LAGOMETER
;2098:
;2099:===============================================================================
;2100:*/
;2101:
;2102:
;2103:
;2104:/*
;2105:==============
;2106:CG_AddLagometerFrameInfo
;2107:
;2108:Adds the current interpolate / extrapolate bar for this frame
;2109:==============
;2110:*/
;2111:void CG_AddLagometerFrameInfo( void ) {
line 2114
;2112:	int			offset;
;2113:
;2114:	offset = cg.time - cg.latestSnapshotTime;
ADDRLP4 0
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+32
INDIRI4
SUBI4
ASGNI4
line 2115
;2115:	lagometer.frameSamples[ lagometer.frameCount & ( LAG_SAMPLES - 1) ] = offset;
ADDRGP4 lagometer+512
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 2116
;2116:	lagometer.frameCount++;
ADDRLP4 4
ADDRGP4 lagometer+512
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2117
;2117:}
LABELV $1388
endproc CG_AddLagometerFrameInfo 8 0
export CG_AddLagometerSnapshotInfo
proc CG_AddLagometerSnapshotInfo 4 0
line 2129
;2118:
;2119:/*
;2120:==============
;2121:CG_AddLagometerSnapshotInfo
;2122:
;2123:Each time a snapshot is received, log its ping time and
;2124:the number of snapshots that were dropped before it.
;2125:
;2126:Pass NULL for a dropped packet.
;2127:==============
;2128:*/
;2129:void CG_AddLagometerSnapshotInfo( snapshot_t *snap ) {
line 2131
;2130:	// dropped packet
;2131:	if ( !snap ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1394
line 2132
;2132:		lagometer.snapshotSamples[ lagometer.snapshotCount & ( LAG_SAMPLES - 1) ] = -1;
ADDRGP4 lagometer+1540
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+1028
ADDP4
CNSTI4 -1
ASGNI4
line 2133
;2133:		lagometer.snapshotCount++;
ADDRLP4 0
ADDRGP4 lagometer+1540
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2134
;2134:		return;
ADDRGP4 $1393
JUMPV
LABELV $1394
line 2138
;2135:	}
;2136:
;2137:	// add this snapshot's info
;2138:	lagometer.snapshotSamples[ lagometer.snapshotCount & ( LAG_SAMPLES - 1) ] = snap->ping;
ADDRGP4 lagometer+1540
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+1028
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 2139
;2139:	lagometer.snapshotFlags[ lagometer.snapshotCount & ( LAG_SAMPLES - 1) ] = snap->snapFlags;
ADDRGP4 lagometer+1540
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+516
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 2140
;2140:	lagometer.snapshotCount++;
ADDRLP4 0
ADDRGP4 lagometer+1540
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2141
;2141:}
LABELV $1393
endproc CG_AddLagometerSnapshotInfo 4 0
export CG_DrawDisconnect
proc CG_DrawDisconnect 72 44
line 2150
;2142:
;2143:/*
;2144:==============
;2145:CG_DrawDisconnect
;2146:
;2147:Should we draw something differnet for long lag vs no packets?
;2148:==============
;2149:*/
;2150:void CG_DrawDisconnect( void ) {
line 2158
;2151:	float		x, y;
;2152:	int			cmdNum;
;2153:	usercmd_t	cmd;
;2154:	const char		*s;
;2155:	int			w;  // bk010215 - FIXME char message[1024];
;2156:
;2157:	// draw the phone jack if we are completely past our buffers
;2158:	cmdNum = trap_GetCurrentCmdNumber() - CMD_BACKUP + 1;
ADDRLP4 44
ADDRGP4 trap_GetCurrentCmdNumber
CALLI4
ASGNI4
ADDRLP4 36
ADDRLP4 44
INDIRI4
CNSTI4 64
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 2159
;2159:	trap_GetUserCmd( cmdNum, &cmd );
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_GetUserCmd
CALLI4
pop
line 2160
;2160:	if ( cmd.serverTime <= cg.snap->ps.commandTime
ADDRLP4 48
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
LEI4 $1409
ADDRLP4 48
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $1405
LABELV $1409
line 2161
;2161:		|| cmd.serverTime > cg.time ) {	// special check for map_restart // bk 0102165 - FIXME
line 2162
;2162:		return;
ADDRGP4 $1404
JUMPV
LABELV $1405
line 2166
;2163:	}
;2164:
;2165:	// also add text in center of screen
;2166:	s = "Connection Interrupted"; // bk 010215 - FIXME
ADDRLP4 24
ADDRGP4 $1410
ASGNP4
line 2167
;2167:	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 52
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 2169
;2168:	//CG_DrawBigString( 320 - w/2, 100, s, 1.0F);
;2169:	CG_DrawStringExt(320 - w / 2, 100, s, colorWhite, qfalse, qfalse,
CNSTI4 320
ADDRLP4 40
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 100
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 56
CNSTI4 0
ASGNI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRLP4 60
CNSTI4 16
ASGNI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2173
;2170:								BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
;2171:
;2172:	// blink the icon
;2173:	if ( ( cg.time >> 9 ) & 1 ) {
ADDRGP4 cg+107604
INDIRI4
CNSTI4 9
RSHI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1411
line 2174
;2174:		return;
ADDRGP4 $1404
JUMPV
LABELV $1411
line 2177
;2175:	}
;2176:
;2177:	x = 640 - 48;
ADDRLP4 28
CNSTF4 1142161408
ASGNF4
line 2178
;2178:	y = 480 - 48;
ADDRLP4 32
CNSTF4 1138229248
ASGNF4
line 2180
;2179:
;2180:	CG_DrawPic( x, y, 48, 48, trap_R_RegisterShader("gfx/2d/net.tga" ) );
ADDRGP4 $1414
ARGP4
ADDRLP4 64
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 68
CNSTF4 1111490560
ASGNF4
ADDRLP4 68
INDIRF4
ARGF4
ADDRLP4 68
INDIRF4
ARGF4
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 2181
;2181:}
LABELV $1404
endproc CG_DrawDisconnect 72 44
proc CG_DrawLagometer 72 44
line 2192
;2182:
;2183:
;2184:#define	MAX_LAGOMETER_PING	900
;2185:#define	MAX_LAGOMETER_RANGE	300
;2186:
;2187:/*
;2188:==============
;2189:CG_DrawLagometer
;2190:==============
;2191:*/
;2192:static void CG_DrawLagometer() {
line 2199
;2193:	int		a, x, y, i;
;2194:	float	v;
;2195:	float	ax, ay, aw, ah, mid, range;
;2196:	int		color;
;2197:	float	vscale;
;2198:
;2199:	if ( !cg_lagometer.integer || cgs.localServer ) {
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRGP4 cg_lagometer+12
INDIRI4
ADDRLP4 52
INDIRI4
EQI4 $1420
ADDRGP4 cgs+31452
INDIRI4
ADDRLP4 52
INDIRI4
EQI4 $1416
LABELV $1420
line 2200
;2200:		CG_DrawDisconnect();
ADDRGP4 CG_DrawDisconnect
CALLV
pop
line 2201
;2201:		return;
ADDRGP4 $1415
JUMPV
LABELV $1416
line 2211
;2202:	}
;2203:
;2204:	//
;2205:	// draw the graph
;2206:	//
;2207:#ifdef MISSIONPACK
;2208:	x = 640 - 48;
;2209:	y = 480 - 144;
;2210:#else
;2211:		x = 640 - 48;
ADDRLP4 44
CNSTI4 592
ASGNI4
line 2212
;2212:		y = 480 - 48;
ADDRLP4 48
CNSTI4 432
ASGNI4
line 2215
;2213:#endif
;2214:
;2215:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2217
;2216:
;2217:	CG_DrawPic( x, y, 48, 48, cgs.media.lagometerShader );
ADDRLP4 44
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 48
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 56
CNSTF4 1111490560
ASGNF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRGP4 cgs+156680+320
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 2219
;2218:
;2219:	ax = x;
ADDRLP4 24
ADDRLP4 44
INDIRI4
CVIF4 4
ASGNF4
line 2220
;2220:	ay = y;
ADDRLP4 36
ADDRLP4 48
INDIRI4
CVIF4 4
ASGNF4
line 2221
;2221:	aw = 48;
ADDRLP4 12
CNSTF4 1111490560
ASGNF4
line 2222
;2222:	ah = 48;
ADDRLP4 32
CNSTF4 1111490560
ASGNF4
line 2223
;2223:	CG_AdjustFrom640( &ax, &ay, &aw, &ah );
ADDRLP4 24
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 32
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 2225
;2224:
;2225:	color = -1;
ADDRLP4 20
CNSTI4 -1
ASGNI4
line 2226
;2226:	range = ah / 3;
ADDRLP4 16
ADDRLP4 32
INDIRF4
CNSTF4 1077936128
DIVF4
ASGNF4
line 2227
;2227:	mid = ay + range;
ADDRLP4 40
ADDRLP4 36
INDIRF4
ADDRLP4 16
INDIRF4
ADDF4
ASGNF4
line 2229
;2228:
;2229:	vscale = range / MAX_LAGOMETER_RANGE;
ADDRLP4 28
ADDRLP4 16
INDIRF4
CNSTF4 1133903872
DIVF4
ASGNF4
line 2232
;2230:
;2231:	// draw the frame interpoalte / extrapolate graph
;2232:	for ( a = 0 ; a < aw ; a++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1426
JUMPV
LABELV $1423
line 2233
;2233:		i = ( lagometer.frameCount - 1 - a ) & (LAG_SAMPLES - 1);
ADDRLP4 8
ADDRGP4 lagometer+512
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 127
BANDI4
ASGNI4
line 2234
;2234:		v = lagometer.frameSamples[i];
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 2235
;2235:		v *= vscale;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 2236
;2236:		if ( v > 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $1428
line 2237
;2237:			if ( color != 1 ) {
ADDRLP4 20
INDIRI4
CNSTI4 1
EQI4 $1430
line 2238
;2238:				color = 1;
ADDRLP4 20
CNSTI4 1
ASGNI4
line 2239
;2239:				trap_R_SetColor( g_color_table[ColorIndex(COLOR_YELLOW)] );
CNSTI4 51
ARGI4
ADDRLP4 60
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2240
;2240:			}
LABELV $1430
line 2241
;2241:			if ( v > range ) {
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRF4
LEF4 $1432
line 2242
;2242:				v = range;
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 2243
;2243:			}
LABELV $1432
line 2244
;2244:			trap_R_DrawStretchPic ( ax + aw - a, mid - v, 1, v, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 40
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 64
CNSTF4 0
ASGNF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRGP4 cgs+156680+36
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 2245
;2245:		} else if ( v < 0 ) {
ADDRGP4 $1429
JUMPV
LABELV $1428
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $1436
line 2246
;2246:			if ( color != 2 ) {
ADDRLP4 20
INDIRI4
CNSTI4 2
EQI4 $1438
line 2247
;2247:				color = 2;
ADDRLP4 20
CNSTI4 2
ASGNI4
line 2248
;2248:				trap_R_SetColor( g_color_table[ColorIndex(COLOR_BLUE)] );
CNSTI4 52
ARGI4
ADDRLP4 60
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2249
;2249:			}
LABELV $1438
line 2250
;2250:			v = -v;
ADDRLP4 0
ADDRLP4 0
INDIRF4
NEGF4
ASGNF4
line 2251
;2251:			if ( v > range ) {
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRF4
LEF4 $1440
line 2252
;2252:				v = range;
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 2253
;2253:			}
LABELV $1440
line 2254
;2254:			trap_R_DrawStretchPic( ax + aw - a, mid, 1, v, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 60
CNSTF4 0
ASGNF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRGP4 cgs+156680+36
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 2255
;2255:		}
LABELV $1436
LABELV $1429
line 2256
;2256:	}
LABELV $1424
line 2232
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1426
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 12
INDIRF4
LTF4 $1423
line 2259
;2257:
;2258:	// draw the snapshot latency / drop graph
;2259:	range = ah / 2;
ADDRLP4 16
ADDRLP4 32
INDIRF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 2260
;2260:	vscale = range / MAX_LAGOMETER_PING;
ADDRLP4 28
ADDRLP4 16
INDIRF4
CNSTF4 1147207680
DIVF4
ASGNF4
line 2262
;2261:
;2262:	for ( a = 0 ; a < aw ; a++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1447
JUMPV
LABELV $1444
line 2263
;2263:		i = ( lagometer.snapshotCount - 1 - a ) & (LAG_SAMPLES - 1);
ADDRLP4 8
ADDRGP4 lagometer+1540
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 127
BANDI4
ASGNI4
line 2264
;2264:		v = lagometer.snapshotSamples[i];
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+1028
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 2265
;2265:		if ( v > 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $1450
line 2266
;2266:			if ( lagometer.snapshotFlags[i] & SNAPFLAG_RATE_DELAYED ) {
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+516
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1452
line 2267
;2267:				if ( color != 5 ) {
ADDRLP4 20
INDIRI4
CNSTI4 5
EQI4 $1453
line 2268
;2268:					color = 5;	// YELLOW for rate delay
ADDRLP4 20
CNSTI4 5
ASGNI4
line 2269
;2269:					trap_R_SetColor( g_color_table[ColorIndex(COLOR_YELLOW)] );
CNSTI4 51
ARGI4
ADDRLP4 60
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2270
;2270:				}
line 2271
;2271:			} else {
ADDRGP4 $1453
JUMPV
LABELV $1452
line 2272
;2272:				if ( color != 3 ) {
ADDRLP4 20
INDIRI4
CNSTI4 3
EQI4 $1457
line 2273
;2273:					color = 3;
ADDRLP4 20
CNSTI4 3
ASGNI4
line 2274
;2274:					trap_R_SetColor( g_color_table[ColorIndex(COLOR_GREEN)] );
CNSTI4 50
ARGI4
ADDRLP4 60
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2275
;2275:				}
LABELV $1457
line 2276
;2276:			}
LABELV $1453
line 2277
;2277:			v = v * vscale;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 2278
;2278:			if ( v > range ) {
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRF4
LEF4 $1459
line 2279
;2279:				v = range;
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 2280
;2280:			}
LABELV $1459
line 2281
;2281:			trap_R_DrawStretchPic( ax + aw - a, ay + ah - v, 1, v, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 36
INDIRF4
ADDRLP4 32
INDIRF4
ADDF4
ADDRLP4 0
INDIRF4
SUBF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 64
CNSTF4 0
ASGNF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRGP4 cgs+156680+36
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 2282
;2282:		} else if ( v < 0 ) {
ADDRGP4 $1451
JUMPV
LABELV $1450
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $1463
line 2283
;2283:			if ( color != 4 ) {
ADDRLP4 20
INDIRI4
CNSTI4 4
EQI4 $1465
line 2284
;2284:				color = 4;		// RED for dropped snapshots
ADDRLP4 20
CNSTI4 4
ASGNI4
line 2285
;2285:				trap_R_SetColor( g_color_table[ColorIndex(COLOR_RED)] );
CNSTI4 49
ARGI4
ADDRLP4 60
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2286
;2286:			}
LABELV $1465
line 2287
;2287:			trap_R_DrawStretchPic( ax + aw - a, ay + ah - range, 1, range, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 36
INDIRF4
ADDRLP4 32
INDIRF4
ADDF4
ADDRLP4 16
INDIRF4
SUBF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 64
CNSTF4 0
ASGNF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRGP4 cgs+156680+36
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 2288
;2288:		}
LABELV $1463
LABELV $1451
line 2289
;2289:	}
LABELV $1445
line 2262
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1447
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 12
INDIRF4
LTF4 $1444
line 2291
;2290:
;2291:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2293
;2292:
;2293:	if ( cg_nopredict.integer || cg_synchronousClients.integer ) {
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRGP4 cg_nopredict+12
INDIRI4
ADDRLP4 60
INDIRI4
NEI4 $1473
ADDRGP4 cg_synchronousClients+12
INDIRI4
ADDRLP4 60
INDIRI4
EQI4 $1469
LABELV $1473
line 2295
;2294:		//CG_DrawBigString( ax, ay, "snc", 1.0 );
;2295:		CG_DrawStringExt(ax, ay, "snc", colorBlue, qfalse, qfalse,
ADDRLP4 24
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 36
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 $1474
ARGP4
ADDRGP4 colorBlue
ARGP4
ADDRLP4 64
CNSTI4 0
ASGNI4
ADDRLP4 64
INDIRI4
ARGI4
ADDRLP4 64
INDIRI4
ARGI4
ADDRLP4 68
CNSTI4 16
ASGNI4
ADDRLP4 68
INDIRI4
ARGI4
ADDRLP4 68
INDIRI4
ARGI4
ADDRLP4 64
INDIRI4
ARGI4
ADDRLP4 64
INDIRI4
ARGI4
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2297
;2296:								BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
;2297:	}
LABELV $1469
line 2299
;2298:
;2299:	CG_DrawDisconnect();
ADDRGP4 CG_DrawDisconnect
CALLV
pop
line 2300
;2300:}
LABELV $1415
endproc CG_DrawLagometer 72 44
export CG_CenterPrint
proc CG_CenterPrint 8 12
line 2321
;2301:
;2302:
;2303:
;2304:/*
;2305:===============================================================================
;2306:
;2307:CENTER PRINTING
;2308:
;2309:===============================================================================
;2310:*/
;2311:
;2312:
;2313:/*
;2314:==============
;2315:CG_CenterPrint
;2316:
;2317:Called for important messages that should stay in the center of the screen
;2318:for a few moments
;2319:==============
;2320:*/
;2321:void CG_CenterPrint( const char *str, int y, int charWidth ) {
line 2324
;2322:	char	*s;
;2323:
;2324:	Q_strncpyz( cg.centerPrint, str, sizeof(cg.centerPrint) );
ADDRGP4 cg+129512
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2326
;2325:
;2326:	cg.centerPrintTime = cg.time;
ADDRGP4 cg+129500
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 2327
;2327:	cg.centerPrintY = y;
ADDRGP4 cg+129508
ADDRFP4 4
INDIRI4
ASGNI4
line 2328
;2328:	cg.centerPrintCharWidth = charWidth;
ADDRGP4 cg+129504
ADDRFP4 8
INDIRI4
ASGNI4
line 2331
;2329:
;2330:	// count the number of lines for centering
;2331:	cg.centerPrintLines = 1;
ADDRGP4 cg+130536
CNSTI4 1
ASGNI4
line 2332
;2332:	s = cg.centerPrint;
ADDRLP4 0
ADDRGP4 cg+129512
ASGNP4
ADDRGP4 $1485
JUMPV
LABELV $1484
line 2333
;2333:	while( *s ) {
line 2334
;2334:		if (*s == '\n')
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 10
NEI4 $1487
line 2335
;2335:			cg.centerPrintLines++;
ADDRLP4 4
ADDRGP4 cg+130536
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1487
line 2336
;2336:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 2337
;2337:	}
LABELV $1485
line 2333
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1484
line 2338
;2338:}
LABELV $1475
endproc CG_CenterPrint 8 12
export CG_DrawCenterString
proc CG_DrawCenterString 1064 44
line 2346
;2339:
;2340:
;2341:/*
;2342:===================
;2343:CG_DrawCenterString
;2344:===================
;2345:*/
;2346:void CG_DrawCenterString( void ) {
line 2355
;2347:	char	*start;
;2348:	int		l;
;2349:	int		x, y, w;
;2350:#ifdef MISSIONPACK // bk010221 - unused else
;2351:  int h;
;2352:#endif
;2353:	float	*color;
;2354:
;2355:	if ( !cg.centerPrintTime ) {
ADDRGP4 cg+129500
INDIRI4
CNSTI4 0
NEI4 $1491
line 2356
;2356:		return;
ADDRGP4 $1490
JUMPV
LABELV $1491
line 2359
;2357:	}
;2358:
;2359:	color = CG_FadeColor( cg.centerPrintTime, 1000 * cg_centertime.value );
ADDRGP4 cg+129500
INDIRI4
ARGI4
CNSTF4 1148846080
ADDRGP4 cg_centertime+8
INDIRF4
MULF4
CVFI4 4
ARGI4
ADDRLP4 24
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 24
INDIRP4
ASGNP4
line 2360
;2360:	if ( !color ) {
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1496
line 2361
;2361:		return;
ADDRGP4 $1490
JUMPV
LABELV $1496
line 2364
;2362:	}
;2363:
;2364:	trap_R_SetColor( color );
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2366
;2365:
;2366:	start = cg.centerPrint;
ADDRLP4 0
ADDRGP4 cg+129512
ASGNP4
line 2368
;2367:
;2368:	if ( cg.scoreBoardShowing ) //CenterPrint above scoreboard
ADDRGP4 cg+120472
INDIRI4
CNSTI4 0
EQI4 $1499
line 2369
;2369:		y = 10;
ADDRLP4 8
CNSTI4 10
ASGNI4
ADDRGP4 $1505
JUMPV
LABELV $1499
line 2371
;2370:	else
;2371:		y = cg.centerPrintY - cg.centerPrintLines * BIGCHAR_HEIGHT / 2;
ADDRLP4 8
ADDRGP4 cg+129508
INDIRI4
ADDRGP4 cg+130536
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 2
DIVI4
SUBI4
ASGNI4
ADDRGP4 $1505
JUMPV
LABELV $1504
line 2373
;2372:
;2373:	while ( 1 ) {
line 2376
;2374:		char linebuffer[1024];
;2375:
;2376:		for ( l = 0; l < 50; l++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $1507
line 2377
;2377:			if ( !start[l] || start[l] == '\n' ) {
ADDRLP4 1052
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
EQI4 $1513
ADDRLP4 1052
INDIRI4
CNSTI4 10
NEI4 $1511
LABELV $1513
line 2378
;2378:				break;
ADDRGP4 $1509
JUMPV
LABELV $1511
line 2380
;2379:			}
;2380:			linebuffer[l] = start[l];
ADDRLP4 4
INDIRI4
ADDRLP4 28
ADDP4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRI1
ASGNI1
line 2381
;2381:		}
LABELV $1508
line 2376
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 50
LTI4 $1507
LABELV $1509
line 2382
;2382:		linebuffer[l] = 0;
ADDRLP4 4
INDIRI4
ADDRLP4 28
ADDP4
CNSTI1 0
ASGNI1
line 2391
;2383:
;2384:#ifdef MISSIONPACK
;2385:		w = CG_Text_Width(linebuffer, 0.5, 0);
;2386:		h = CG_Text_Height(linebuffer, 0.5, 0);
;2387:		x = (SCREEN_WIDTH - w) / 2;
;2388:		CG_Text_Paint(x, y + h, 0.5, color, linebuffer, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
;2389:		y += h + 6;
;2390:#else
;2391:		w = cg.centerPrintCharWidth * CG_DrawStrlen( linebuffer );
ADDRLP4 28
ARGP4
ADDRLP4 1052
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRGP4 cg+129504
INDIRI4
ADDRLP4 1052
INDIRI4
MULI4
ASGNI4
line 2393
;2392:
;2393:		x = ( SCREEN_WIDTH - w ) / 2;
ADDRLP4 12
CNSTI4 640
ADDRLP4 16
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ASGNI4
line 2395
;2394:
;2395:		CG_DrawStringExt( x, y, linebuffer, color, qfalse, qtrue,
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 1056
CNSTI4 0
ASGNI4
ADDRLP4 1056
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 cg+129504
INDIRI4
ARGI4
CNSTF4 1069547520
ADDRGP4 cg+129504
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ARGI4
ADDRLP4 1056
INDIRI4
ARGI4
ADDRLP4 1056
INDIRI4
ARGI4
ADDRLP4 1056
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2398
;2396:			cg.centerPrintCharWidth, (int)(cg.centerPrintCharWidth * 1.5), 0, 0, 0 );
;2397:
;2398:		y += cg.centerPrintCharWidth * 1.5;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CVIF4 4
CNSTF4 1069547520
ADDRGP4 cg+129504
INDIRI4
CVIF4 4
MULF4
ADDF4
CVFI4 4
ASGNI4
ADDRGP4 $1519
JUMPV
LABELV $1518
line 2400
;2399:#endif
;2400:		while ( *start && ( *start != '\n' ) ) {
line 2401
;2401:			start++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 2402
;2402:		}
LABELV $1519
line 2400
ADDRLP4 1060
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
EQI4 $1521
ADDRLP4 1060
INDIRI4
CNSTI4 10
NEI4 $1518
LABELV $1521
line 2403
;2403:		if ( !*start ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1522
line 2404
;2404:			break;
ADDRGP4 $1506
JUMPV
LABELV $1522
line 2406
;2405:		}
;2406:		start++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 2407
;2407:	}
LABELV $1505
line 2373
ADDRGP4 $1504
JUMPV
LABELV $1506
line 2409
;2408:
;2409:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2410
;2410:}
LABELV $1490
endproc CG_DrawCenterString 1064 44
export CG_DrawCrosshair
proc CG_DrawCrosshair 56 36
line 2428
;2411:
;2412:
;2413:
;2414:/*
;2415:================================================================================
;2416:
;2417:CROSSHAIR
;2418:
;2419:================================================================================
;2420:*/
;2421:
;2422:
;2423:/*
;2424:=================
;2425:CG_DrawCrosshair
;2426:=================
;2427:*/
;2428:void CG_DrawCrosshair(void) {
line 2435
;2429:	float		w, h;
;2430:	qhandle_t	hShader;
;2431:	float		f;
;2432:	float		x, y;
;2433:	int			ca;
;2434:
;2435:	if ( !cg_drawCrosshair.integer ) {
ADDRGP4 cg_drawCrosshair+12
INDIRI4
CNSTI4 0
NEI4 $1525
line 2436
;2436:		return;
ADDRGP4 $1524
JUMPV
LABELV $1525
line 2439
;2437:	}
;2438:
;2439:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1528
line 2440
;2440:		return;
ADDRGP4 $1524
JUMPV
LABELV $1528
line 2443
;2441:	}
;2442:
;2443:	if ( cg.renderingThirdPerson ) {
ADDRGP4 cg+107628
INDIRI4
CNSTI4 0
EQI4 $1531
line 2444
;2444:		return;
ADDRGP4 $1524
JUMPV
LABELV $1531
line 2449
;2445:	}
;2446:
;2447:	
;2448:	// set color based on health
;2449:	if ( cg_crosshairHealth.integer == 1 ) {
ADDRGP4 cg_crosshairHealth+12
INDIRI4
CNSTI4 1
NEI4 $1534
line 2452
;2450:		vec4_t		hcolor;
;2451:
;2452:		CG_ColorForHealth( hcolor );
ADDRLP4 28
ARGP4
ADDRGP4 CG_ColorForHealth
CALLV
pop
line 2453
;2453:		trap_R_SetColor( hcolor );
ADDRLP4 28
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2454
;2454:	} else if ( strlen(cg_crosshairColor.string) >= 1 ) {
ADDRGP4 $1535
JUMPV
LABELV $1534
ADDRGP4 cg_crosshairColor+16
ARGP4
ADDRLP4 28
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 1
LTI4 $1537
line 2455
;2455:		trap_R_SetColor( g_color_table[ ColorIndex( cg_crosshairColor.string[0] ) ] );
ADDRGP4 cg_crosshairColor+16
INDIRI1
CVII4 1
ARGI4
ADDRLP4 32
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2456
;2456:	} else {
ADDRGP4 $1538
JUMPV
LABELV $1537
line 2457
;2457:		trap_R_SetColor( colorWhite );
ADDRGP4 colorWhite
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2458
;2458:	}
LABELV $1538
LABELV $1535
line 2460
;2459:
;2460:	w = h = cg_crosshairSize.value;
ADDRLP4 32
ADDRGP4 cg_crosshairSize+8
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 32
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 32
INDIRF4
ASGNF4
line 2463
;2461:
;2462:	// pulse the size of the crosshair when picking up items
;2463:	if ( cg_crosshairPulse.integer ) {
ADDRGP4 cg_crosshairPulse+12
INDIRI4
CNSTI4 0
EQI4 $1542
line 2464
;2464:		f = cg.time - cg.itemPickupBlendTime;
ADDRLP4 20
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+130820
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 2465
;2465:		if ( f > 0 && f < ITEM_BLOB_TIME ) {
ADDRLP4 36
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 36
INDIRF4
CNSTF4 0
LEF4 $1547
ADDRLP4 36
INDIRF4
CNSTF4 1128792064
GEF4 $1547
line 2466
;2466:			f /= ITEM_BLOB_TIME;
ADDRLP4 20
ADDRLP4 20
INDIRF4
CNSTF4 1128792064
DIVF4
ASGNF4
line 2467
;2467:			w *= ( 1 + f );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRF4
CNSTF4 1065353216
ADDF4
MULF4
ASGNF4
line 2468
;2468:			h *= ( 1 + f );
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 20
INDIRF4
CNSTF4 1065353216
ADDF4
MULF4
ASGNF4
line 2469
;2469:		}
LABELV $1547
line 2470
;2470:	}
LABELV $1542
line 2472
;2471:
;2472:	x = cg_crosshairX.integer;
ADDRLP4 12
ADDRGP4 cg_crosshairX+12
INDIRI4
CVIF4 4
ASGNF4
line 2473
;2473:	y = cg_crosshairY.integer;
ADDRLP4 16
ADDRGP4 cg_crosshairY+12
INDIRI4
CVIF4 4
ASGNF4
line 2474
;2474:	CG_AdjustFrom640( &x, &y, &w, &h );
ADDRLP4 12
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 2476
;2475:
;2476:	ca = cg_drawCrosshair.integer;
ADDRLP4 8
ADDRGP4 cg_drawCrosshair+12
INDIRI4
ASGNI4
line 2477
;2477:	if (ca < 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
GEI4 $1552
line 2478
;2478:		ca = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2479
;2479:	}
LABELV $1552
line 2480
;2480:	hShader = cgs.media.crosshairShader[ ca % NUM_CROSSHAIRS ];
ADDRLP4 24
ADDRLP4 8
INDIRI4
CNSTI4 11
MODI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+156680+276
ADDP4
INDIRI4
ASGNI4
line 2482
;2481:
;2482:	trap_R_DrawStretchPic( x + cg.refdef.x + 0.5 * (cg.refdef.width - w), 
ADDRLP4 36
CNSTF4 1056964608
ASGNF4
ADDRLP4 40
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 12
INDIRF4
ADDRGP4 cg+109048
INDIRI4
CVIF4 4
ADDF4
ADDRLP4 36
INDIRF4
ADDRGP4 cg+109048+8
INDIRI4
CVIF4 4
ADDRLP4 40
INDIRF4
SUBF4
MULF4
ADDF4
ARGF4
ADDRLP4 44
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 16
INDIRF4
ADDRGP4 cg+109048+4
INDIRI4
CVIF4 4
ADDF4
ADDRLP4 36
INDIRF4
ADDRGP4 cg+109048+12
INDIRI4
CVIF4 4
ADDRLP4 44
INDIRF4
SUBF4
MULF4
ADDF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 48
CNSTF4 0
ASGNF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 48
INDIRF4
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
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 2485
;2483:		y + cg.refdef.y + 0.5 * (cg.refdef.height - h), 
;2484:		w, h, 0, 0, 1, 1, hShader );
;2485:}
LABELV $1524
endproc CG_DrawCrosshair 56 36
export CG_ScanForCrosshairEntity
proc CG_ScanForCrosshairEntity 96 28
line 2494
;2486:
;2487:
;2488:
;2489:/*
;2490:=================
;2491:CG_ScanForCrosshairEntity
;2492:=================
;2493:*/
;2494:void CG_ScanForCrosshairEntity( void ) {
line 2499
;2495:	trace_t		trace;
;2496:	vec3_t		start, end;
;2497:	int			content;
;2498:
;2499:	VectorCopy( cg.refdef.vieworg, start );
ADDRLP4 56
ADDRGP4 cg+109048+24
INDIRB
ASGNB 12
line 2500
;2500:	VectorMA( start, 131072, cg.refdef.viewaxis[0], end );
ADDRLP4 84
CNSTF4 1207959552
ASGNF4
ADDRLP4 68
ADDRLP4 56
INDIRF4
ADDRLP4 84
INDIRF4
ADDRGP4 cg+109048+36
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 68+4
ADDRLP4 56+4
INDIRF4
ADDRLP4 84
INDIRF4
ADDRGP4 cg+109048+36+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 68+8
ADDRLP4 56+8
INDIRF4
CNSTF4 1207959552
ADDRGP4 cg+109048+36+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 2502
;2501:
;2502:	CG_Trace( &trace, start, vec3_origin, vec3_origin, end, 
ADDRLP4 0
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 88
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 33554433
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 2504
;2503:		cg.snap->ps.clientNum, CONTENTS_SOLID|CONTENTS_BODY );
;2504:	if ( trace.entityNum >= MAX_CLIENTS ) {
ADDRLP4 0+52
INDIRI4
CNSTI4 64
LTI4 $1579
line 2506
;2505://freeze
;2506:		if ( g_gamemode.integer > 3 ) {
ADDRGP4 g_gamemode+12
INDIRI4
CNSTI4 3
LEI4 $1563
line 2509
;2507:			entityState_t	*es;
;2508:
;2509:			es = &cg_entities[ trace.entityNum ].currentState;
ADDRLP4 92
CNSTI4 728
ADDRLP4 0+52
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 2510
;2510:			if ( es->powerups & ( 1 << PW_BATTLESUIT ) ) {
ADDRLP4 92
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1563
line 2511
;2511:				cg.crosshairClientNum = es->otherEntityNum;
ADDRGP4 cg+130548
ADDRLP4 92
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 2512
;2512:				cg.crosshairClientTime = cg.time;
ADDRGP4 cg+130552
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 2513
;2513:			}
line 2514
;2514:		}
line 2516
;2515://freeze
;2516:		return;
ADDRGP4 $1563
JUMPV
LABELV $1579
line 2520
;2517:	}
;2518:
;2519:	// if the player is in fog, don't show it
;2520:	content = trap_CM_PointContents( trace.endpos, 0 );
ADDRLP4 0+12
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 92
ADDRGP4 trap_CM_PointContents
CALLI4
ASGNI4
ADDRLP4 80
ADDRLP4 92
INDIRI4
ASGNI4
line 2521
;2521:	if ( content & CONTENTS_FOG ) {
ADDRLP4 80
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $1592
line 2522
;2522:		return;
ADDRGP4 $1563
JUMPV
LABELV $1592
line 2526
;2523:	}
;2524:
;2525:	// if the player is invisible, don't show it
;2526:	if ( cg_entities[ trace.entityNum ].currentState.powerups & ( 1 << PW_INVIS ) ) {
CNSTI4 728
ADDRLP4 0+52
INDIRI4
MULI4
ADDRGP4 cg_entities+188
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1594
line 2527
;2527:		return;
ADDRGP4 $1563
JUMPV
LABELV $1594
line 2531
;2528:	}
;2529:
;2530:	// update the fade timer
;2531:	cg.crosshairClientNum = trace.entityNum;
ADDRGP4 cg+130548
ADDRLP4 0+52
INDIRI4
ASGNI4
line 2532
;2532:	cg.crosshairClientTime = cg.time;
ADDRGP4 cg+130552
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 2533
;2533:}
LABELV $1563
endproc CG_ScanForCrosshairEntity 96 28
proc CG_DrawCrosshairNames 40 44
line 2541
;2534:
;2535:
;2536:/*
;2537:=====================
;2538:CG_DrawCrosshairNames
;2539:=====================
;2540:*/
;2541:static void CG_DrawCrosshairNames() {
line 2546
;2542:	float		*color;
;2543:	char		*name;
;2544:	float		w;
;2545:
;2546:	if ( !cg_drawCrosshair.integer ) {
ADDRGP4 cg_drawCrosshair+12
INDIRI4
CNSTI4 0
NEI4 $1603
line 2547
;2547:		return;
ADDRGP4 $1602
JUMPV
LABELV $1603
line 2549
;2548:	}
;2549:	if ( !cg_drawCrosshairNames.integer ) {
ADDRGP4 cg_drawCrosshairNames+12
INDIRI4
CNSTI4 0
NEI4 $1606
line 2550
;2550:		return;
ADDRGP4 $1602
JUMPV
LABELV $1606
line 2552
;2551:	}
;2552:	if ( cg.renderingThirdPerson ) {
ADDRGP4 cg+107628
INDIRI4
CNSTI4 0
EQI4 $1609
line 2553
;2553:		return;
ADDRGP4 $1602
JUMPV
LABELV $1609
line 2557
;2554:	}
;2555:
;2556:	// scan the known entities to see if the crosshair is sighted on one
;2557:	CG_ScanForCrosshairEntity();
ADDRGP4 CG_ScanForCrosshairEntity
CALLV
pop
line 2560
;2558:
;2559:	// draw the name of the player being looked at
;2560:	color = CG_FadeColor( cg.crosshairClientTime, 1000 );
ADDRGP4 cg+130552
INDIRI4
ARGI4
CNSTI4 1000
ARGI4
ADDRLP4 12
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 12
INDIRP4
ASGNP4
line 2561
;2561:	if ( !color ) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1613
line 2562
;2562:		trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2563
;2563:		return;
ADDRGP4 $1602
JUMPV
LABELV $1613
line 2566
;2564:	}
;2565:
;2566:	if ( (cg_drawCrosshairNames.integer > 1 && cgs.gametype < GT_TEAM) || (cg_drawCrosshairNames.integer == 2 && cgs.clientinfo[ cg.crosshairClientNum ].team == cgs.clientinfo[ cg.clientNum ].team && cgs.gametype >= GT_TEAM) ||
ADDRGP4 cg_drawCrosshairNames+12
INDIRI4
CNSTI4 1
LEI4 $1636
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $1637
LABELV $1636
ADDRGP4 cg_drawCrosshairNames+12
INDIRI4
CNSTI4 2
NEI4 $1639
ADDRLP4 16
CNSTI4 1776
ASGNI4
ADDRLP4 16
INDIRI4
ADDRGP4 cg+130548
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
NEI4 $1639
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
GEI4 $1637
LABELV $1639
ADDRLP4 20
CNSTI4 3
ASGNI4
ADDRGP4 cg_drawCrosshairNames+12
INDIRI4
ADDRLP4 20
INDIRI4
NEI4 $1615
ADDRLP4 24
CNSTI4 1776
ASGNI4
ADDRLP4 24
INDIRI4
ADDRGP4 cg+130548
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
EQI4 $1615
ADDRGP4 cgs+31456
INDIRI4
ADDRLP4 20
INDIRI4
LTI4 $1615
LABELV $1637
line 2567
;2567:		 (cg_drawCrosshairNames.integer == 3 && cgs.clientinfo[ cg.crosshairClientNum ].team != cgs.clientinfo[ cg.clientNum ].team && cgs.gametype >= GT_TEAM) ) {
line 2568
;2568:			return;
ADDRGP4 $1602
JUMPV
LABELV $1615
line 2571
;2569:	}
;2570:
;2571:	name = cgs.clientinfo[ cg.crosshairClientNum ].name;
ADDRLP4 0
CNSTI4 1776
ADDRGP4 cg+130548
INDIRI4
MULI4
ADDRGP4 cgs+40960+4
ADDP4
ASGNP4
line 2578
;2572:#ifdef MISSIONPACK
;2573:	color[3] *= 0.5f;
;2574:	w = CG_Text_Width(name, 0.3f, 0);
;2575:	CG_Text_Paint( 320 - w / 2, 190, 0.3f, color, name, 0, 0, ITEM_TEXTSTYLE_SHADOWED);
;2576:#else
;2577:
;2578:	w = CG_DrawStrlen( name ) * BIGCHAR_WIDTH;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 28
INDIRI4
CNSTI4 4
LSHI4
CVIF4 4
ASGNF4
line 2579
;2579:	CG_DrawStringExt( 320 - w / 2, 200, name, colorWhite, qfalse, qfalse, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
CNSTF4 1134559232
ADDRLP4 8
INDIRF4
CNSTF4 1073741824
DIVF4
SUBF4
CVFI4 4
ARGI4
CNSTI4 200
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 36
CNSTI4 16
ASGNI4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2583
;2580:
;2581:
;2582:#endif
;2583:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2584
;2584:}
LABELV $1602
endproc CG_DrawCrosshairNames 40 44
proc CG_DrawSpectator 28 44
line 2594
;2585:
;2586:
;2587://==============================================================================
;2588:
;2589:/*
;2590:=================
;2591:CG_DrawSpectator
;2592:=================
;2593:*/
;2594:static void CG_DrawSpectator() {
line 2596
;2595:
;2596:	CG_DrawStringExt(320 - 9 * 8, 440, "SPECTATOR", colorWhite, qfalse, qfalse,
CNSTI4 248
ARGI4
CNSTI4 440
ARGI4
ADDRGP4 $1644
ARGP4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
CNSTI4 16
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2601
;2597:								BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
;2598:/*freeze
;2599:	if ( cgs.gametype == GT_TOURNAMENT ) {
;2600:freeze*/
;2601:	if ( cgs.gametype == GT_TOURNAMENT || Q_Isfreeze( cg.snap->ps.clientNum ) ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 1
EQI4 $1649
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 Q_Isfreeze
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $1645
LABELV $1649
line 2603
;2602://freeze
;2603:		CG_DrawStringExt(320 - 15 * 8, 460, "waiting to play", colorWhite, qfalse, qfalse,
CNSTI4 200
ARGI4
CNSTI4 460
ARGI4
ADDRGP4 $1650
ARGP4
ADDRGP4 colorWhite
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
ADDRLP4 16
CNSTI4 16
ASGNI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2606
;2604:									BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
;2605:
;2606:		if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $1651
line 2608
;2607:			//CG_DrawBigString(320 - 39 * 8, 460, "press ESC and use the JOIN menu to play", 1.0F);
;2608:			CG_DrawStringExt(320 - 39 * 8, 460, "press ESC and use the JOIN menu to play", colorWhite, qfalse, qfalse,
CNSTI4 8
ARGI4
CNSTI4 460
ARGI4
ADDRGP4 $1654
ARGP4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 24
CNSTI4 16
ASGNI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2611
;2609:									BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
;2610:
;2611:		}
LABELV $1651
line 2612
;2612:	}
LABELV $1645
line 2613
;2613:}
LABELV $1643
endproc CG_DrawSpectator 28 44
proc CG_DrawVote 20 44
line 2620
;2614:
;2615:/*
;2616:=================
;2617:CG_DrawVote
;2618:=================
;2619:*/
;2620:static void CG_DrawVote() {
line 2624
;2621:	char	*s;
;2622:	int		sec;
;2623:
;2624:	if ( !cgs.voteTime ) {
ADDRGP4 cgs+31676
INDIRI4
CNSTI4 0
NEI4 $1656
line 2625
;2625:		return;
ADDRGP4 $1655
JUMPV
LABELV $1656
line 2634
;2626:	}
;2627:
;2628:	// play a talk beep whenever it is modified
;2629:	/*if ( cgs.voteModified ) {
;2630:		cgs.voteModified = qfalse;
;2631:		trap_S_StartLocalSound( cgs.media.talkSound, CHAN_LOCAL_SOUND );
;2632:	}*/
;2633:
;2634:	sec = ( VOTE_TIME - ( cg.time - cgs.voteTime ) ) / 1000;
ADDRLP4 0
CNSTI4 30000
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cgs+31676
INDIRI4
SUBI4
SUBI4
CNSTI4 1000
DIVI4
ASGNI4
line 2635
;2635:	/*if ( sec < -2 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $1661
line 2638
;2636:		return;
;2637:	} else */if ( sec < 0 ) {
;2638:		sec = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2639
;2639:	}
LABELV $1661
line 2646
;2640:#ifdef MISSIONPACK
;2641:	s = va("VOTE(%i):%s yes:%i no:%i", sec, cgs.voteString, cgs.voteYes, cgs.voteNo);
;2642:	CG_DrawSmallString( 0, 58, s, 1.0F );
;2643:	s = "or press ESC then click Vote";
;2644:	CG_DrawSmallString( 0, 58 + SMALLCHAR_HEIGHT + 2, s, 1.0F );
;2645:#else
;2646:	s = va("VOTE(%i):%s yes:%i no:%i", sec, cgs.voteString, cgs.voteYes, cgs.voteNo );
ADDRGP4 $1663
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 cgs+31688
ARGP4
ADDRGP4 cgs+31680
INDIRI4
ARGI4
ADDRGP4 cgs+31684
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 2648
;2647:
;2648:	CG_DrawStringExt( 0, 58, s, colorWhite, qtrue, qtrue, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0, 0, 0 );
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 12
INDIRI4
ARGI4
CNSTI4 58
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 16
INDIRI4
ARGI4
CNSTI4 8
ARGI4
CNSTI4 16
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2651
;2649:
;2650:#endif
;2651:}
LABELV $1655
endproc CG_DrawVote 20 44
proc CG_DrawTeamVote 28 44
line 2658
;2652:
;2653:/*
;2654:=================
;2655:CG_DrawTeamVote
;2656:=================
;2657:*/
;2658:static void CG_DrawTeamVote( ) {
line 2662
;2659:	char	*s;
;2660:	int		sec, cs_offset;
;2661:
;2662:	if ( cgs.clientinfo->team == TEAM_RED )
ADDRGP4 cgs+40960+68
INDIRI4
CNSTI4 1
NEI4 $1668
line 2663
;2663:		cs_offset = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1669
JUMPV
LABELV $1668
line 2664
;2664:	else if ( cgs.clientinfo->team == TEAM_BLUE )
ADDRGP4 cgs+40960+68
INDIRI4
CNSTI4 2
NEI4 $1667
line 2665
;2665:		cs_offset = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 2667
;2666:	else
;2667:		return;
LABELV $1673
LABELV $1669
line 2670
;2668:
;2669:	
;2670:	if ( !cgs.teamVoteTime[cs_offset] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32712
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1676
line 2671
;2671:		return;
ADDRGP4 $1667
JUMPV
LABELV $1676
line 2680
;2672:	}
;2673:	//CG_Printf("DBG: Team: %i", cs_offset);
;2674:	// play a talk beep whenever it is modified
;2675:	/*if ( cgs.teamVoteModified[cs_offset] ) {
;2676:		cgs.teamVoteModified[cs_offset] = qfalse;
;2677:		trap_S_StartLocalSound( cgs.media.talkSound, CHAN_LOCAL_SOUND );
;2678:	}*/
;2679:
;2680:	sec = ( VOTE_TIME - ( cg.time - cgs.teamVoteTime[cs_offset] ) ) / 1000;
ADDRLP4 4
CNSTI4 30000
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32712
ADDP4
INDIRI4
SUBI4
SUBI4
CNSTI4 1000
DIVI4
ASGNI4
line 2681
;2681:	/*if ( sec < -2 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1681
line 2684
;2682:		return;
;2683:	} else*/ if ( sec < 0 ) {
;2684:		sec = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2685
;2685:	}
LABELV $1681
line 2686
;2686:	s = va("TEAMVOTE(%i):%s yes:%i no:%i", sec, cgs.teamVoteString[cs_offset],
ADDRGP4 $1683
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 cgs+32736
ADDP4
ARGP4
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 16
INDIRI4
ADDRGP4 cgs+32720
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
INDIRI4
ADDRGP4 cgs+32728
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 20
INDIRP4
ASGNP4
line 2689
;2687:							cgs.teamVoteYes[cs_offset], cgs.teamVoteNo[cs_offset] );
;2688:
;2689:	CG_DrawStringExt( 0, 90, s, colorWhite, qtrue, qfalse, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0, 0, 0 );
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRLP4 24
INDIRI4
ARGI4
CNSTI4 90
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
CNSTI4 8
ARGI4
CNSTI4 16
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2690
;2690:}
LABELV $1667
endproc CG_DrawTeamVote 28 44
export CG_DrawScoreboard
proc CG_DrawScoreboard 4 0
line 2693
;2691:
;2692:
;2693:qboolean CG_DrawScoreboard() {
line 2759
;2694:
;2695:#ifdef MISSIONPACK
;2696:	static qboolean firstTime = qtrue;
;2697:	float fade, *fadeColor;
;2698:
;2699:	if (menuScoreboard) {
;2700:		menuScoreboard->window.flags &= ~WINDOW_FORCED;
;2701:	}
;2702:	if (cg_paused.integer) {
;2703:		cg.deferredPlayerLoading = 0;
;2704:		firstTime = qtrue;
;2705:		return qfalse;
;2706:	}
;2707:
;2708:	// should never happen in Team Arena
;2709:	if (cgs.gametype == GT_SINGLE_PLAYER && cg.predictedPlayerState.pm_type == PM_INTERMISSION ) {
;2710:		cg.deferredPlayerLoading = 0;
;2711:		firstTime = qtrue;
;2712:		return qfalse;
;2713:	}
;2714:
;2715:	// don't draw scoreboard during death while warmup up
;2716:	if ( cg.warmup && !cg.showScores ) {
;2717:		return qfalse;
;2718:	}
;2719:
;2720:	if ( cg.showScores || cg.predictedPlayerState.pm_type == PM_DEAD || cg.predictedPlayerState.pm_type == PM_INTERMISSION ) {
;2721:		fade = 1.0;
;2722:		fadeColor = colorWhite;
;2723:	} else {
;2724:		fadeColor = CG_FadeColor( cg.scoreFadeTime, FADE_TIME );
;2725:		if ( !fadeColor ) {
;2726:			// next time scoreboard comes up, don't print killer
;2727:			cg.deferredPlayerLoading = 0;
;2728:			cg.killerName[0] = 0;
;2729:			firstTime = qtrue;
;2730:			return qfalse;
;2731:		}
;2732:		fade = *fadeColor;
;2733:	}																					  
;2734:
;2735:
;2736:	if (menuScoreboard == NULL) {
;2737:		if ( cgs.gametype >= GT_TEAM ) {
;2738:			menuScoreboard = Menus_FindByName("teamscore_menu");
;2739:		} else {
;2740:			menuScoreboard = Menus_FindByName("score_menu");
;2741:		}
;2742:	}
;2743:
;2744:	if (menuScoreboard) {
;2745:		if (firstTime) {
;2746:			CG_SetScoreSelection(menuScoreboard);
;2747:			firstTime = qfalse;
;2748:		}
;2749:		Menu_Paint(menuScoreboard, qtrue);
;2750:	}
;2751:
;2752:	// load any models that have been deferred
;2753:	if ( ++cg.deferredPlayerLoading > 10 ) {
;2754:		CG_LoadDeferredPlayers();
;2755:	}
;2756:
;2757:	return qtrue;
;2758:#else
;2759:	if ( cg_oldScoreboard.integer >= 0) {
ADDRGP4 cg_oldScoreboard+12
INDIRI4
CNSTI4 0
LTI4 $1688
line 2760
;2760:		return CG_DrawOldScoreboard();
ADDRLP4 0
ADDRGP4 CG_DrawOldScoreboard
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1687
JUMPV
LABELV $1688
line 2761
;2761:	} else {
line 2762
;2762:		return CG_DrawNewScoreboard();
ADDRLP4 0
ADDRGP4 CG_DrawNewScoreboard
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $1687
endproc CG_DrawScoreboard 4 0
export CG_DrawIntermission
proc CG_DrawIntermission 68 32
line 2772
;2763:	}
;2764:#endif
;2765:}
;2766:
;2767:/*
;2768:=================
;2769:CG_DrawIntermission
;2770:=================
;2771:*/
;2772:void CG_DrawIntermission( void ) {
line 2780
;2773://	int key;
;2774:#ifdef MISSIONPACK
;2775:	//if (cg_singlePlayer.integer) {
;2776:	//	CG_DrawCenterString();
;2777:	//	return;
;2778:	//}
;2779:#else
;2780:	if ( cgs.gametype == GT_SINGLE_PLAYER ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 2
NEI4 $1692
line 2781
;2781:		CG_DrawCenterString();
ADDRGP4 CG_DrawCenterString
CALLV
pop
line 2782
;2782:		return;
ADDRGP4 $1691
JUMPV
LABELV $1692
line 2786
;2783:	}
;2784:#endif
;2785:
;2786:	if ( cg_drawClock.integer ) {
ADDRGP4 cg_drawClock+12
INDIRI4
CNSTI4 0
EQI4 $1695
line 2787
;2787:		CG_DrawClock( 0 );
CNSTF4 0
ARGF4
ADDRGP4 CG_DrawClock
CALLF4
pop
line 2788
;2788:	}
LABELV $1695
line 2790
;2789:
;2790:	cg.scoreFadeTime = cg.time;
ADDRGP4 cg+120476
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 2792
;2791:	//Score_Weapon();
;2792:	cg.scoreBoardShowing = CG_DrawScoreboard();
ADDRLP4 0
ADDRGP4 CG_DrawScoreboard
CALLI4
ASGNI4
ADDRGP4 cg+120472
ADDRLP4 0
INDIRI4
ASGNI4
line 2795
;2793:
;2794:	//FIXME: Optimize the foillwing.
;2795:	if ( (cg_autoScreenshot.integer == 1 || cg_autoScreenshot.integer == 2) && !cgs.autoScreenshotTaken && cgs.takeScreenshot == 0 ) {
ADDRGP4 cg_autoScreenshot+12
INDIRI4
CNSTI4 1
EQI4 $1707
ADDRGP4 cg_autoScreenshot+12
INDIRI4
CNSTI4 2
NEI4 $1701
LABELV $1707
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 cgs+157860
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $1701
ADDRGP4 cgs+157872
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $1701
line 2797
;2796:		//Set time delay
;2797:		cgs.takeScreenshot = (cg.time + 1000);
ADDRGP4 cgs+157872
ADDRGP4 cg+107604
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 2798
;2798:	}
LABELV $1701
line 2800
;2799:
;2800:	if ( cg.predictedPlayerState.pm_type == PM_INTERMISSION && cgs.stopRecording == 0 && cgs.autoRecording ) {
ADDRGP4 cg+107636+4
INDIRI4
CNSTI4 5
NEI4 $1710
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 cgs+157868
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $1710
ADDRGP4 cgs+157864
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $1710
line 2801
;2801:		cgs.stopRecording = (cg.time + 7000);
ADDRGP4 cgs+157868
ADDRGP4 cg+107604
INDIRI4
CNSTI4 7000
ADDI4
ASGNI4
line 2802
;2802:	}
LABELV $1710
line 2804
;2803:
;2804:	if ( cg_autoScreenshot.integer == 1 && !cgs.autoScreenshotTaken && cg.time >= cgs.takeScreenshot && cgs.takeScreenshot != 0 ) {
ADDRGP4 cg_autoScreenshot+12
INDIRI4
CNSTI4 1
NEI4 $1718
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 cgs+157860
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $1718
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cgs+157872
INDIRI4
LTI4 $1718
ADDRGP4 cgs+157872
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $1718
line 2805
;2805:		char	*Hn = Q_CleanString( autoFile.hostname );
ADDRGP4 autoFile
ARGP4
ADDRLP4 56
ADDRGP4 Q_CleanString
CALLP4
ASGNP4
ADDRLP4 52
ADDRLP4 56
INDIRP4
ASGNP4
line 2808
;2806:		qtime_t	qtm;
;2807:		//Month.Day.Year--Hostname-Mapname-HH.MM
;2808:		trap_RealTime(&qtm);
ADDRLP4 16
ARGP4
ADDRGP4 trap_RealTime
CALLI4
pop
line 2809
;2809:		cgs.autoRecording = qtrue;
ADDRGP4 cgs+157864
CNSTI4 1
ASGNI4
line 2810
;2810:		trap_SendConsoleCommand(va("screenshotJPEG %i.%i.%i--%s-%s-%02i.%02i\n", qtm.tm_mon, qtm.tm_mday, (qtm.tm_year + 1900), Hn, autoFile.map, qtm.tm_hour, qtm.tm_min));
ADDRGP4 $1726
ARGP4
ADDRLP4 16+16
INDIRI4
ARGI4
ADDRLP4 16+12
INDIRI4
ARGI4
ADDRLP4 16+20
INDIRI4
CNSTI4 1900
ADDI4
ARGI4
ADDRLP4 52
INDIRP4
ARGP4
ADDRGP4 autoFile+1152
ARGP4
ADDRLP4 16+8
INDIRI4
ARGI4
ADDRLP4 16+4
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 2811
;2811:		cgs.autoScreenshotTaken = qtrue;
ADDRGP4 cgs+157860
CNSTI4 1
ASGNI4
line 2812
;2812:	} else if ( cg_autoScreenshot.integer == 2 && !cgs.autoScreenshotTaken && cg.time >= cgs.takeScreenshot && cgs.takeScreenshot != 0 ) {
ADDRGP4 $1719
JUMPV
LABELV $1718
ADDRGP4 cg_autoScreenshot+12
INDIRI4
CNSTI4 2
NEI4 $1734
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 cgs+157860
INDIRI4
ADDRLP4 16
INDIRI4
NEI4 $1734
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cgs+157872
INDIRI4
LTI4 $1734
ADDRGP4 cgs+157872
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $1734
line 2813
;2813:		char	*Hn = Q_CleanString( autoFile.hostname );
ADDRGP4 autoFile
ARGP4
ADDRLP4 60
ADDRGP4 Q_CleanString
CALLP4
ASGNP4
ADDRLP4 56
ADDRLP4 60
INDIRP4
ASGNP4
line 2816
;2814:		qtime_t	qtm;
;2815:		//Month.Day.Year--Hostname-Mapname-HH.MM
;2816:		trap_RealTime(&qtm);
ADDRLP4 20
ARGP4
ADDRGP4 trap_RealTime
CALLI4
pop
line 2817
;2817:		cgs.autoRecording = qtrue;
ADDRGP4 cgs+157864
CNSTI4 1
ASGNI4
line 2818
;2818:		trap_SendConsoleCommand(va("screenshot %i.%i.%i--%s-%s-%02i.%02i\n", qtm.tm_mon, qtm.tm_mday, (qtm.tm_year + 1900), Hn, autoFile.map, qtm.tm_hour, qtm.tm_min));
ADDRGP4 $1742
ARGP4
ADDRLP4 20+16
INDIRI4
ARGI4
ADDRLP4 20+12
INDIRI4
ARGI4
ADDRLP4 20+20
INDIRI4
CNSTI4 1900
ADDI4
ARGI4
ADDRLP4 56
INDIRP4
ARGP4
ADDRGP4 autoFile+1152
ARGP4
ADDRLP4 20+8
INDIRI4
ARGI4
ADDRLP4 20+4
INDIRI4
ARGI4
ADDRLP4 64
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 2819
;2819:		cgs.autoScreenshotTaken = qtrue;
ADDRGP4 cgs+157860
CNSTI4 1
ASGNI4
line 2820
;2820:	}
LABELV $1734
LABELV $1719
line 2821
;2821:	if ( (cg.time >= cgs.stopRecording && cgs.autoRecording && cgs.stopRecording != 0) ) {
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cgs+157868
INDIRI4
LTI4 $1750
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRGP4 cgs+157864
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $1750
ADDRGP4 cgs+157868
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $1750
line 2822
;2822:		cgs.autoRecording = qfalse;
ADDRGP4 cgs+157864
CNSTI4 0
ASGNI4
line 2823
;2823:		cgs.stopRecording = 0;
ADDRGP4 cgs+157868
CNSTI4 0
ASGNI4
line 2824
;2824:		trap_SendConsoleCommand("stoprecord\n");
ADDRGP4 $1758
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 2825
;2825:	}
LABELV $1750
line 2826
;2826:}
LABELV $1691
endproc CG_DrawIntermission 68 32
proc CG_DrawFollow 48 44
line 2833
;2827:
;2828:/*
;2829:=================
;2830:CG_DrawFollow
;2831:=================
;2832:*/
;2833:static qboolean CG_DrawFollow() {
line 2839
;2834:	float		x;
;2835:	vec4_t		color;
;2836:	const char	*name;
;2837://	char		following[64];
;2838:
;2839:	if ( !(cg.snap->ps.pm_flags & PMF_FOLLOW) ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $1760
line 2840
;2840:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1759
JUMPV
LABELV $1760
line 2842
;2841:	}
;2842:	color[0] = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 2843
;2843:	color[1] = 1;
ADDRLP4 0+4
CNSTF4 1065353216
ASGNF4
line 2844
;2844:	color[2] = 1;
ADDRLP4 0+8
CNSTF4 1065353216
ASGNF4
line 2845
;2845:	color[3] = 1;
ADDRLP4 0+12
CNSTF4 1065353216
ASGNF4
line 2850
;2846:
;2847:
;2848:	//CG_DrawBigString( 320 - (9 + strlen(name)) * 8, 24, "following", 1.0F );
;2849:
;2850:	name = cgs.clientinfo[ cg.snap->ps.clientNum ].name;
ADDRLP4 16
CNSTI4 1776
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+40960+4
ADDP4
ASGNP4
line 2852
;2851:	//Com_sprintf(following, sizeof(following), "following %s", name);
;2852:	x = 0.5 * ( 640 - 8 * (CG_DrawStrlen( name )) );
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
CNSTF4 1056964608
CNSTI4 640
ADDRLP4 24
INDIRI4
CNSTI4 3
LSHI4
SUBI4
CVIF4 4
MULF4
ASGNF4
line 2854
;2853:
;2854:	CG_DrawStringExt( 0.5 * (640 - 8 * (CG_DrawStrlen( "Following" ))), 28, "Following", color, qfalse, qtrue, 10, 10, 0, 0, 0 );
ADDRGP4 $1769
ARGP4
ADDRLP4 28
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
CNSTF4 1056964608
CNSTI4 640
ADDRLP4 28
INDIRI4
CNSTI4 3
LSHI4
SUBI4
CVIF4 4
MULF4
CVFI4 4
ARGI4
CNSTI4 28
ARGI4
ADDRGP4 $1769
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 36
CNSTI4 10
ASGNI4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2855
;2855:	CG_DrawStringExt( x, 40, name, color, qfalse, qtrue, 10, 10, 0, 0, 0 );
ADDRLP4 20
INDIRF4
CVFI4 4
ARGI4
CNSTI4 40
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 40
CNSTI4 0
ASGNI4
ADDRLP4 40
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 44
CNSTI4 10
ASGNI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2858
;2856:	
;2857:
;2858:	return qtrue;
CNSTI4 1
RETI4
LABELV $1759
endproc CG_DrawFollow 48 44
proc CG_DrawAmmoWarning 20 44
line 2868
;2859:}
;2860:
;2861:
;2862:
;2863:/*
;2864:=================
;2865:CG_DrawAmmoWarning
;2866:=================
;2867:*/
;2868:static void CG_DrawAmmoWarning() {
line 2872
;2869:	const char	*s;
;2870:	int			w;
;2871:
;2872:	if ( cg_drawAmmoWarning.integer == 0 ) {
ADDRGP4 cg_drawAmmoWarning+12
INDIRI4
CNSTI4 0
NEI4 $1771
line 2873
;2873:		return;
ADDRGP4 $1770
JUMPV
LABELV $1771
line 2876
;2874:	}
;2875:
;2876:	if ( !cg.lowAmmoWarning ) {
ADDRGP4 cg+130540
INDIRI4
CNSTI4 0
NEI4 $1774
line 2877
;2877:		return;
ADDRGP4 $1770
JUMPV
LABELV $1774
line 2880
;2878:	}
;2879:
;2880:	if ( cg.lowAmmoWarning == 2 ) {
ADDRGP4 cg+130540
INDIRI4
CNSTI4 2
NEI4 $1777
line 2881
;2881:		s = "OUT OF AMMO";
ADDRLP4 0
ADDRGP4 $1780
ASGNP4
line 2882
;2882:	} else {
ADDRGP4 $1778
JUMPV
LABELV $1777
line 2883
;2883:		s = "LOW AMMO WARNING";
ADDRLP4 0
ADDRGP4 $1781
ASGNP4
line 2884
;2884:	}
LABELV $1778
line 2886
;2885:
;2886:	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 2887
;2887:	CG_DrawStringExt( 320 - w / 2, 64, s, colorWhite, qfalse, qfalse, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
CNSTI4 320
ADDRLP4 4
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 64
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 colorWhite
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
ADDRLP4 16
CNSTI4 16
ASGNI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2889
;2888:
;2889:}
LABELV $1770
endproc CG_DrawAmmoWarning 20 44
proc CG_DrawWarmup 56 44
line 2938
;2890:
;2891:
;2892:#ifdef MISSIONPACK
;2893:/*
;2894:=================
;2895:CG_DrawProxWarning
;2896:=================
;2897:*/
;2898:static void CG_DrawProxWarning( void ) {
;2899:	char s [32];
;2900:	int			w;
;2901:  static int proxTime;
;2902:  static int proxCounter;
;2903:  static int proxTick;
;2904:
;2905:	if( !(cg.snap->ps.eFlags & EF_TICKING ) ) {
;2906:    proxTime = 0;
;2907:		return;
;2908:	}
;2909:
;2910:  if (proxTime == 0) {
;2911:    proxTime = cg.time + 5000;
;2912:    proxCounter = 5;
;2913:    proxTick = 0;
;2914:  }
;2915:
;2916:  if (cg.time > proxTime) {
;2917:    proxTick = proxCounter--;
;2918:    proxTime = cg.time + 1000;
;2919:  }
;2920:
;2921:  if (proxTick != 0) {
;2922:    Com_sprintf(s, sizeof(s), "INTERNAL COMBUSTION IN: %i", proxTick);
;2923:  } else {
;2924:    Com_sprintf(s, sizeof(s), "YOU HAVE BEEN MINED");
;2925:  }
;2926:
;2927:	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
;2928:	CG_DrawBigStringColor( 320 - w / 2, 64 + BIGCHAR_HEIGHT, s, g_color_table[ColorIndex(COLOR_RED)] );
;2929:}
;2930:#endif
;2931:
;2932:
;2933:/*
;2934:=================
;2935:CG_DrawWarmup
;2936:=================
;2937:*/
;2938:static void CG_DrawWarmup() {
line 2947
;2939:	int			w;
;2940:	int			sec;
;2941:	int			i;
;2942:	float scale;
;2943:	clientInfo_t	*ci1, *ci2;
;2944:	int			cw;
;2945:	const char	*s;
;2946:
;2947:	sec = cg.warmup;
ADDRLP4 4
ADDRGP4 cg+130804
INDIRI4
ASGNI4
line 2948
;2948:	if ( !sec ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1784
line 2949
;2949:		return;
ADDRGP4 $1782
JUMPV
LABELV $1784
line 2952
;2950:	}
;2951:
;2952:	if ( !cg.showScores ) {
ADDRGP4 cg+120468
INDIRI4
CNSTI4 0
NEI4 $1786
line 2953
;2953:		if ( sec < 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1789
line 2954
;2954:			s = "Waiting for players";
ADDRLP4 8
ADDRGP4 $1791
ASGNP4
line 2955
;2955:			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 32
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 2957
;2956:			//CG_DrawBigString(320 - w / 2, 24, s, 1.0F);
;2957:			CG_DrawStringExt(320 - w * .35, 24, s, colorWhite, qfalse, qtrue,
CNSTF4 1134559232
CNSTF4 1051931443
ADDRLP4 16
INDIRI4
CVIF4 4
MULF4
SUBF4
CVFI4 4
ARGI4
CNSTI4 24
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 36
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 40
CNSTI4 12
ASGNI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 36
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2959
;2958:									BIGCHAR_WIDTH * .75, BIGCHAR_HEIGHT *.75, 0, 0, 0 );
;2959:			cg.warmupCount = 0;
ADDRGP4 cg+130808
CNSTI4 0
ASGNI4
line 2960
;2960:			return;
ADDRGP4 $1782
JUMPV
LABELV $1789
line 2963
;2961:		}
;2962:
;2963:		if (cgs.gametype == GT_TOURNAMENT) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 1
NEI4 $1793
line 2965
;2964:			// find the two active players
;2965:			ci1 = NULL;
ADDRLP4 20
CNSTP4 0
ASGNP4
line 2966
;2966:			ci2 = NULL;
ADDRLP4 24
CNSTP4 0
ASGNP4
line 2967
;2967:			for ( i = 0 ; i < cgs.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1799
JUMPV
LABELV $1796
line 2968
;2968:				if ( cgs.clientinfo[i].infoValid && cgs.clientinfo[i].team == TEAM_FREE ) {
ADDRLP4 32
CNSTI4 1776
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRI4
ADDRGP4 cgs+40960
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
EQI4 $1801
ADDRLP4 32
INDIRI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $1801
line 2969
;2969:					if ( !ci1 ) {
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1806
line 2970
;2970:						ci1 = &cgs.clientinfo[i];
ADDRLP4 20
CNSTI4 1776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+40960
ADDP4
ASGNP4
line 2971
;2971:					} else {
ADDRGP4 $1807
JUMPV
LABELV $1806
line 2972
;2972:						ci2 = &cgs.clientinfo[i];
ADDRLP4 24
CNSTI4 1776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+40960
ADDP4
ASGNP4
line 2973
;2973:					}
LABELV $1807
line 2974
;2974:				}
LABELV $1801
line 2975
;2975:			}
LABELV $1797
line 2967
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1799
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+31480
INDIRI4
LTI4 $1796
line 2977
;2976:
;2977:			if ( ci1 && ci2 ) {
ADDRLP4 32
CNSTU4 0
ASGNU4
ADDRLP4 20
INDIRP4
CVPU4 4
ADDRLP4 32
INDIRU4
EQU4 $1794
ADDRLP4 24
INDIRP4
CVPU4 4
ADDRLP4 32
INDIRU4
EQU4 $1794
line 2979
;2978:				//I always hated it when players couldn't finish in ^7..
;2979:				s = va( "%s "S_COLOR_WHITE"vs %s", ci1->name, ci2->name );
ADDRGP4 $1812
ARGP4
ADDRLP4 36
CNSTI4 4
ASGNI4
ADDRLP4 20
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ARGP4
ADDRLP4 24
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ARGP4
ADDRLP4 40
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 40
INDIRP4
ASGNP4
line 2984
;2980:#ifdef MISSIONPACK
;2981:				w = CG_Text_Width(s, 0.6f, 0);
;2982:				CG_Text_Paint(320 - w / 2, 60, 0.6f, colorWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
;2983:#else
;2984:				w = CG_DrawStrlen( s );
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 44
INDIRI4
ASGNI4
line 2985
;2985:				if ( w > 640 / GIANT_WIDTH ) {
ADDRLP4 16
INDIRI4
CNSTI4 20
LEI4 $1813
line 2986
;2986:					cw = 640 / w;
ADDRLP4 12
CNSTI4 640
ADDRLP4 16
INDIRI4
DIVI4
ASGNI4
line 2987
;2987:				} else {
ADDRGP4 $1814
JUMPV
LABELV $1813
line 2988
;2988:					cw = GIANT_WIDTH;
ADDRLP4 12
CNSTI4 32
ASGNI4
line 2989
;2989:				}
LABELV $1814
line 2990
;2990:				CG_DrawStringExt( 320 - w * cw/2, 20,s, colorWhite, 
CNSTI4 320
ADDRLP4 16
INDIRI4
ADDRLP4 12
INDIRI4
MULI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 20
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRLP4 52
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
CNSTF4 1069547520
ADDRLP4 12
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2993
;2991:						qfalse, qtrue, cw, (int)(cw * 1.5f), 0, 0, 0 );
;2992:#endif
;2993:			}
line 2994
;2994:		} else {
ADDRGP4 $1794
JUMPV
LABELV $1793
line 2995
;2995:			if ( cgs.gametype == GT_FFA ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 0
NEI4 $1815
line 2996
;2996:				s = "Free For All";
ADDRLP4 8
ADDRGP4 $1818
ASGNP4
line 2997
;2997:			} else if ( cgs.gametype == GT_TEAM ) {
ADDRGP4 $1816
JUMPV
LABELV $1815
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
NEI4 $1819
line 2998
;2998:				s = "Team Deathmatch";
ADDRLP4 8
ADDRGP4 $1822
ASGNP4
line 2999
;2999:			} else if ( cgs.gametype == GT_CTF ) {
ADDRGP4 $1820
JUMPV
LABELV $1819
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
NEI4 $1823
line 3000
;3000:				s = "Capture the Flag";
ADDRLP4 8
ADDRGP4 $1826
ASGNP4
line 3010
;3001:
;3002:#ifdef MISSIONPACK
;3003:			} else if ( cgs.gametype == GT_1FCTF ) {
;3004:				s = "One Flag CTF";
;3005:			} else if ( cgs.gametype == GT_OBELISK ) {
;3006:				s = "Overload";
;3007:			} else if ( cgs.gametype == GT_HARVESTER ) {
;3008:				s = "Harvester";
;3009:#endif
;3010:			} else {
ADDRGP4 $1824
JUMPV
LABELV $1823
line 3011
;3011:				s = "";
ADDRLP4 8
ADDRGP4 $1827
ASGNP4
line 3012
;3012:			}
LABELV $1824
LABELV $1820
LABELV $1816
line 3017
;3013:#ifdef MISSIONPACK
;3014:			w = CG_Text_Width(s, 0.6f, 0);
;3015:			CG_Text_Paint(320 - w / 2, 90, 0.6f, colorWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
;3016:#else
;3017:				w = CG_DrawStrlen( s );
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 32
INDIRI4
ASGNI4
line 3018
;3018:				if ( w > 640 / GIANT_WIDTH ) {
ADDRLP4 16
INDIRI4
CNSTI4 20
LEI4 $1828
line 3019
;3019:					cw = 640 / w;
ADDRLP4 12
CNSTI4 640
ADDRLP4 16
INDIRI4
DIVI4
ASGNI4
line 3020
;3020:				} else {
ADDRGP4 $1829
JUMPV
LABELV $1828
line 3021
;3021:					cw = GIANT_WIDTH;
ADDRLP4 12
CNSTI4 32
ASGNI4
line 3022
;3022:				}
LABELV $1829
line 3023
;3023:				CG_DrawStringExt( 320 - w * cw/2, 25,s, colorWhite, 
CNSTI4 320
ADDRLP4 16
INDIRI4
ADDRLP4 12
INDIRI4
MULI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 25
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 40
CNSTI4 0
ASGNI4
ADDRLP4 40
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
CNSTF4 1066192077
ADDRLP4 12
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ARGI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3026
;3024:						qfalse, qtrue, cw, (int)(cw * 1.1f), 0, 0, 0 );
;3025:#endif
;3026:		}
LABELV $1794
line 3027
;3027:	}
LABELV $1786
line 3028
;3028:	sec = ( sec - cg.time ) / 1000;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
ASGNI4
line 3029
;3029:	if ( sec < 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1831
line 3030
;3030:		cg.warmup = 0;
ADDRGP4 cg+130804
CNSTI4 0
ASGNI4
line 3031
;3031:		sec = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 3032
;3032:	}
LABELV $1831
line 3033
;3033:	s = va( "Starts in: %i", sec + 1 );
ADDRGP4 $1834
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 32
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 32
INDIRP4
ASGNP4
line 3034
;3034:	if ( sec != cg.warmupCount ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+130808
INDIRI4
EQI4 $1835
line 3035
;3035:		cg.warmupCount = sec;
ADDRGP4 cg+130808
ADDRLP4 4
INDIRI4
ASGNI4
line 3036
;3036:		switch ( sec ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $1841
ADDRLP4 4
INDIRI4
CNSTI4 1
EQI4 $1844
ADDRLP4 4
INDIRI4
CNSTI4 2
EQI4 $1847
ADDRGP4 $1840
JUMPV
LABELV $1841
line 3038
;3037:		case 0:
;3038:			trap_S_StartLocalSound( cgs.media.count1Sound, CHAN_ANNOUNCER );
ADDRGP4 cgs+156680+1060
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 3039
;3039:			break;
ADDRGP4 $1840
JUMPV
LABELV $1844
line 3041
;3040:		case 1:
;3041:			trap_S_StartLocalSound( cgs.media.count2Sound, CHAN_ANNOUNCER );
ADDRGP4 cgs+156680+1056
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 3042
;3042:			break;
ADDRGP4 $1840
JUMPV
LABELV $1847
line 3044
;3043:		case 2:
;3044:			trap_S_StartLocalSound( cgs.media.count3Sound, CHAN_ANNOUNCER );
ADDRGP4 cgs+156680+1052
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 3045
;3045:			break;
line 3047
;3046:		default:
;3047:			break;
LABELV $1840
line 3049
;3048:		}
;3049:	}
LABELV $1835
line 3050
;3050:	if ( !cg.showScores ) {
ADDRGP4 cg+120468
INDIRI4
CNSTI4 0
NEI4 $1850
line 3051
;3051:		scale = 0.45f;
ADDRLP4 28
CNSTF4 1055286886
ASGNF4
line 3052
;3052:		switch ( cg.warmupCount ) {
ADDRLP4 36
ADDRGP4 cg+130808
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $1856
ADDRLP4 36
INDIRI4
CNSTI4 1
EQI4 $1857
ADDRLP4 36
INDIRI4
CNSTI4 2
EQI4 $1858
ADDRGP4 $1853
JUMPV
LABELV $1856
line 3054
;3053:		case 0:
;3054:			cw = 28;
ADDRLP4 12
CNSTI4 28
ASGNI4
line 3055
;3055:			scale = 0.54f;
ADDRLP4 28
CNSTF4 1057635697
ASGNF4
line 3056
;3056:			break;
ADDRGP4 $1854
JUMPV
LABELV $1857
line 3058
;3057:		case 1:
;3058:			cw = 24;
ADDRLP4 12
CNSTI4 24
ASGNI4
line 3059
;3059:			scale = 0.51f;
ADDRLP4 28
CNSTF4 1057132380
ASGNF4
line 3060
;3060:			break;
ADDRGP4 $1854
JUMPV
LABELV $1858
line 3062
;3061:		case 2:
;3062:			cw = 20;
ADDRLP4 12
CNSTI4 20
ASGNI4
line 3063
;3063:			scale = 0.48f;
ADDRLP4 28
CNSTF4 1056293519
ASGNF4
line 3064
;3064:			break;
ADDRGP4 $1854
JUMPV
LABELV $1853
line 3066
;3065:		default:
;3066:			cw = 16;
ADDRLP4 12
CNSTI4 16
ASGNI4
line 3067
;3067:			scale = 0.45f;
ADDRLP4 28
CNSTF4 1055286886
ASGNF4
line 3068
;3068:			break;
LABELV $1854
line 3075
;3069:		}
;3070:
;3071:#ifdef MISSIONPACK
;3072:			w = CG_Text_Width(s, scale, 0);
;3073:			CG_Text_Paint(320 - w / 2, 125, scale, colorWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
;3074:#else
;3075:		w = CG_DrawStrlen( s );
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 40
INDIRI4
ASGNI4
line 3076
;3076:		CG_DrawStringExt( 320 - w * cw/2, 70, s, colorWhite, 
CNSTI4 320
ADDRLP4 16
INDIRI4
ADDRLP4 12
INDIRI4
MULI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 70
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 48
CNSTI4 0
ASGNI4
ADDRLP4 48
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
CNSTF4 1069547520
ADDRLP4 12
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3079
;3077:				qfalse, qtrue, cw, (int)(cw * 1.5), 0, 0, 0 );
;3078:#endif
;3079:	}
LABELV $1850
line 3080
;3080:}
LABELV $1782
endproc CG_DrawWarmup 56 44
export CG_ExtractToken
proc CG_ExtractToken 8 0
line 3108
;3081:
;3082://==================================================================================
;3083:#ifdef MISSIONPACK
;3084:/* 
;3085:=================
;3086:CG_DrawTimedMenus
;3087:=================
;3088:*/
;3089:void CG_DrawTimedMenus() {
;3090:	if (cg.voiceTime) {
;3091:		int t = cg.time - cg.voiceTime;
;3092:		if ( t > 2500 ) {
;3093:			Menus_CloseByName("voiceMenu");
;3094:			trap_Cvar_Set("cl_conXOffset", "0");
;3095:			cg.voiceTime = 0;
;3096:		}
;3097:	}
;3098:}
;3099:#endif
;3100:
;3101:/*
;3102:=================
;3103:Spike's
;3104:CG_ExtractToken
;3105:=================
;3106:*/
;3107:void CG_ExtractToken(char **ptr, char *token)
;3108:{
ADDRGP4 $1861
JUMPV
LABELV $1860
line 3110
;3109:	while(**ptr == '"' || **ptr == ' ' || **ptr == '\0')
;3110:	{
line 3111
;3111:		if(**ptr == '\0')
ADDRFP4 0
INDIRP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1863
line 3112
;3112:			return;
ADDRGP4 $1859
JUMPV
LABELV $1863
line 3114
;3113:
;3114:		(*ptr)++;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 3115
;3115:	}
LABELV $1861
line 3109
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 34
EQI4 $1860
ADDRLP4 0
INDIRI4
CNSTI4 32
EQI4 $1860
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1860
ADDRGP4 $1866
JUMPV
LABELV $1865
line 3118
;3116:
;3117:	while(**ptr != '"' && **ptr != ' ' && **ptr != '\0')
;3118:	{
line 3119
;3119:		*token = **ptr;
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
INDIRP4
INDIRI1
ASGNI1
line 3120
;3120:		(*ptr)++;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 3121
;3121:		token++;
ADDRFP4 4
ADDRFP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 3122
;3122:	}
LABELV $1866
line 3117
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 34
EQI4 $1869
ADDRLP4 4
INDIRI4
CNSTI4 32
EQI4 $1869
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1865
LABELV $1869
line 3124
;3123:
;3124:	*token = '\0';
ADDRFP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 3125
;3125:}
LABELV $1859
endproc CG_ExtractToken 8 0
lit
align 4
LABELV $1871
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
skip 4
export CG_DrawSpeedometer
code
proc CG_DrawSpeedometer 52 44
line 3133
;3126:
;3127:/*
;3128:=================
;3129:CG_DrawSpeedometer
;3130:Spike's Speedometer
;3131:=================
;3132:*/
;3133:void CG_DrawSpeedometer(qboolean draw_speed, qboolean draw_maxspeed, int x, int y, float alpha) {
line 3137
;3134:	float speed;
;3135:	char *str;
;3136:	int width;
;3137:	vec4_t color = {1.0f, 1.0f, 1.0f};
ADDRLP4 8
ADDRGP4 $1871
INDIRB
ASGNB 16
line 3139
;3138:
;3139:	color[3] = alpha;
ADDRLP4 8+12
ADDRFP4 16
INDIRF4
ASGNF4
line 3141
;3140:
;3141:	speed = 1.0f / Q_rsqrt(cg.snap->ps.velocity[0] * cg.snap->ps.velocity[0] +
ADDRLP4 28
CNSTI4 76
ASGNI4
ADDRLP4 32
CNSTI4 80
ASGNI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
MULF4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 36
ADDRGP4 Q_rsqrt
CALLF4
ASGNF4
ADDRLP4 0
CNSTF4 1065353216
ADDRLP4 36
INDIRF4
DIVF4
ASGNF4
line 3144
;3142:					cg.snap->ps.velocity[1] * cg.snap->ps.velocity[1]);
;3143:
;3144:	if(speed > max_speed)
ADDRLP4 0
INDIRF4
ADDRGP4 max_speed
INDIRF4
LEF4 $1877
line 3145
;3145:		max_speed = speed;
ADDRGP4 max_speed
ADDRLP4 0
INDIRF4
ASGNF4
LABELV $1877
line 3147
;3146:
;3147:	if(draw_speed ) 	{
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $1879
line 3148
;3148:		str = va("%.3fups", speed);
ADDRGP4 $1881
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 40
INDIRP4
ASGNP4
line 3149
;3149:		width = CG_DrawStrlen(str) * 12;
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 24
CNSTI4 12
ADDRLP4 44
INDIRI4
MULI4
ASGNI4
line 3151
;3150:
;3151:		CG_DrawStringExt(x - width, y + 2, str, color, qfalse, qfalse, 12, SMALLCHAR_HEIGHT, 0, 0, 0);
ADDRFP4 8
INDIRI4
ADDRLP4 24
INDIRI4
SUBI4
ARGI4
ADDRFP4 12
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 48
CNSTI4 0
ASGNI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
CNSTI4 12
ARGI4
CNSTI4 16
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3152
;3152:	}
LABELV $1879
line 3154
;3153:
;3154:	if(draw_maxspeed) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $1882
line 3155
;3155:		y += SMALLCHAR_HEIGHT;
ADDRFP4 12
ADDRFP4 12
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 3156
;3156:		str = va("%.3fmax", max_speed);
ADDRGP4 $1884
ARGP4
ADDRGP4 max_speed
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 40
INDIRP4
ASGNP4
line 3157
;3157:		width = CG_DrawStrlen(str) * 12;
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 24
CNSTI4 12
ADDRLP4 44
INDIRI4
MULI4
ASGNI4
line 3159
;3158:
;3159:		CG_DrawStringExt(x - width, y + 2, str, color, qfalse, qfalse, 12, SMALLCHAR_HEIGHT, 0, 0, 0);
ADDRFP4 8
INDIRI4
ADDRLP4 24
INDIRI4
SUBI4
ARGI4
ADDRFP4 12
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 48
CNSTI4 0
ASGNI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
CNSTI4 12
ARGI4
CNSTI4 16
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3160
;3160:	}
LABELV $1882
line 3161
;3161:}
LABELV $1870
endproc CG_DrawSpeedometer 52 44
data
export fallobs
align 4
LABELV fallobs
byte 4 3212836864
byte 4 1040254501
byte 4 0
byte 4 3212836864
byte 4 3191831790
byte 4 1
byte 4 3221225472
byte 4 1026295857
byte 4 0
byte 4 3225419776
byte 4 1033879159
byte 4 0
byte 4 3229614080
byte 4 3181228589
byte 4 1
byte 4 3233808384
byte 4 3190690939
byte 4 1
byte 4 3235905536
byte 4 1024953680
byte 4 0
byte 4 3238002688
byte 4 1044885012
byte 4 0
byte 4 3244294144
byte 4 1041059807
byte 4 0
byte 4 3245342720
byte 4 3173242634
byte 4 1
byte 4 3247964160
byte 4 1041126916
byte 4 0
byte 4 3248488448
byte 4 3194717471
byte 4 1
byte 4 3250061312
byte 4 3186194645
byte 4 1
byte 4 3251634176
byte 4 3191966007
byte 4 1
byte 4 3252682752
byte 4 1045354775
byte 4 0
byte 4 3254255616
byte 4 3190154068
byte 4 1
byte 4 3255042048
byte 4 1034818683
byte 4 0
byte 4 3259760640
byte 4 1041328243
byte 4 0
byte 4 3260284928
byte 4 3183107637
byte 4 1
byte 4 3262119936
byte 4 3181631242
byte 4 1
byte 4 3263299584
byte 4 1017907249
byte 4 0
byte 4 3263954944
byte 4 3180289065
byte 4 1
byte 4 3265003520
byte 4 3179886412
byte 4 1
byte 4 3265396736
byte 4 1043274400
byte 4 0
byte 4 3268935680
byte 4 1042334876
byte 4 0
byte 4 3269328896
byte 4 3182302331
byte 4 1
byte 4 3270639616
byte 4 3184047161
byte 4 1
byte 4 3271557120
byte 4 3159686644
byte 4 1
byte 4 3272015872
byte 4 3186999951
byte 4 1
byte 4 3272736768
byte 4 3188744782
byte 4 1
byte 4 3272998912
byte 4 1035489772
byte 4 0
byte 4 3275096064
byte 4 1045556101
byte 4 0
byte 4 3275358208
byte 4 994352038
byte 4 0
byte 4 3275620352
byte 4 3195791213
byte 4 1
byte 4 3276210176
byte 4 1038174126
byte 4 0
byte 4 3277062144
byte 4 3193643729
byte 4 1
byte 4 3277389824
byte 4 1048441782
byte 4 0
byte 4 3277979648
byte 4 1022202216
byte 4 0
byte 4 3278897152
byte 4 3190019850
byte 4 1
byte 4 3279224832
byte 4 1013276738
byte 4 0
byte 4 3279552512
byte 4 1041261134
byte 4 0
byte 4 3279880192
byte 4 1046495625
byte 4 0
byte 4 3280076800
byte 4 1048576000
byte 4 0
byte 4 3280240640
byte 4 1047368040
byte 4 0
byte 4 3280404480
byte 4 1042938855
byte 4 0
byte 4 3280568320
byte 4 1029248647
byte 4 0
byte 4 3280732160
byte 4 3185523556
byte 4 1
byte 4 3281256448
byte 4 1039247868
byte 4 0
byte 4 3281420288
byte 4 3195053015
byte 4 1
byte 4 3281780736
byte 4 3182436549
byte 4 1
byte 4 3282141184
byte 4 3188006584
byte 4 1
byte 4 3282698240
byte 4 3177000731
byte 4 1
byte 4 3282894848
byte 4 1045757428
byte 4 0
byte 4 3283648512
byte 4 3194180600
byte 4 1
byte 4 3283845120
byte 4 3192704205
byte 4 1
byte 4 3284041728
byte 4 3194449035
byte 4 1
byte 4 3284860928
byte 4 1044683686
byte 4 0
byte 4 3285057536
byte 4 3180825936
byte 4 1
byte 4 3285680128
byte 4 3189885633
byte 4 1
byte 4 3286106112
byte 4 3187268387
byte 4 1
byte 4 3286761472
byte 4 1033342288
byte 4 0
byte 4 3287416832
byte 4 3190221177
byte 4 1
byte 4 3287646208
byte 4 3148076810
byte 4 1
byte 4 3287875584
byte 4 1037637255
byte 4 0
byte 4 3288104960
byte 4 1043073073
byte 4 0
byte 4 3288334336
byte 4 1044012597
byte 4 0
byte 4 3288449024
byte 4 1041798005
byte 4 0
byte 4 3288563712
byte 4 1032402764
byte 4 0
byte 4 3288678400
byte 4 3179148214
byte 4 1
byte 4 3288793088
byte 4 3195388559
byte 4 1
byte 4 3289153536
byte 4 3178879779
byte 4 1
byte 4 3289399296
byte 4 1041999331
byte 4 0
byte 4 3289645056
byte 4 1043408617
byte 4 0
byte 4 3289890816
byte 4 990057071
byte 4 0
byte 4 3290267648
byte 4 3186328863
byte 4 1
byte 4 3290398720
byte 4 1034550247
byte 4 0
byte 4 3290529792
byte 4 1047502258
byte 4 0
byte 4 3291316224
byte 4 1040388719
byte 4 0
byte 4 3291447296
byte 4 3178074472
byte 4 1
byte 4 3291856896
byte 4 1036563513
byte 4 0
byte 4 3292266496
byte 4 3191294919
byte 4 1
byte 4 3292692480
byte 4 1038442562
byte 4 0
byte 4 3293118464
byte 4 3169685864
byte 4 1
byte 4 3293265920
byte 4 1042670420
byte 4 0
byte 4 3294298112
byte 4 1041865114
byte 4 0
byte 4 3294445568
byte 4 3174047941
byte 4 1
byte 4 3294904320
byte 4 1035221336
byte 4 0
byte 4 3295363072
byte 4 3193576620
byte 4 1
byte 4 3295838208
byte 4 1029517083
byte 4 0
byte 4 3296313344
byte 4 3185657774
byte 4 1
byte 4 3296477184
byte 4 1033073852
byte 4 0
byte 4 3296641024
byte 4 1045623210
byte 4 0
byte 4 3297091584
byte 4 1042401985
byte 4 0
byte 4 3297173504
byte 4 1000593162
byte 4 0
byte 4 3297255424
byte 4 3192502878
byte 4 1
byte 4 3297509376
byte 4 3182973420
byte 4 1
byte 4 3297681408
byte 4 1033476506
byte 4 0
byte 4 3297853440
byte 4 1027906470
byte 4 0
byte 4 3298025472
byte 4 3190758048
byte 4 1
byte 4 3298115584
byte 4 1041663787
byte 4 0
byte 4 3298377728
byte 4 3191764681
byte 4 1
byte 4 3298467840
byte 4 3178342908
byte 4 1
byte 4 3298557952
byte 4 1016833507
byte 4 0
byte 4 3298648064
byte 4 1028174905
byte 4 0
byte 4 3298738176
byte 4 1023611503
byte 4 0
byte 4 3298828288
byte 4 3171632022
byte 4 1
byte 4 3298918400
byte 4 3189147435
byte 4 1
byte 4 3299196928
byte 4 1046831170
byte 4 0
byte 4 3299287040
byte 4 3181899678
byte 4 1
byte 4 3299475456
byte 4 1042737529
byte 4 0
byte 4 3299663872
byte 4 1046294299
byte 4 0
byte 4 3299852288
byte 4 1033744941
byte 4 0
byte 4 3300139008
byte 4 1006834287
byte 4 0
byte 4 3300237312
byte 4 1046696952
byte 4 0
byte 4 3301023744
byte 4 1045824537
byte 4 0
byte 4 3301122048
byte 4 3154317935
byte 4 1
byte 4 3301425152
byte 4 1028711776
byte 4 0
byte 4 3301629952
byte 4 1044146815
byte 4 0
byte 4 3301834752
byte 4 1040187392
byte 4 0
byte 4 3302039552
byte 4 3187805258
byte 4 1
byte 4 3302146048
byte 4 1043609944
byte 4 0
byte 4 3302457344
byte 4 3193039749
byte 4 1
byte 4 3302563840
byte 4 3183644508
byte 4 1
byte 4 3302670336
byte 4 3171095151
byte 4 1
byte 4 3302776832
byte 4 3163780284
byte 4 1
byte 4 3302883328
byte 4 3176195424
byte 4 1
byte 4 3302989824
byte 4 3188207911
byte 4 1
byte 4 3303424000
byte 4 1031396131
byte 4 0
byte 4 3303751680
byte 4 3175390118
byte 4 1
byte 4 3303972864
byte 4 3168612123
byte 4 1
byte 4 3304194048
byte 4 3192637096
byte 4 1
byte 4 3304308736
byte 4 1041462460
byte 4 0
byte 4 3304644608
byte 4 3186597298
byte 4 1
byte 4 3304759296
byte 4 1023879938
byte 4 0
byte 4 3304873984
byte 4 1040925590
byte 4 0
byte 4 3304988672
byte 4 1044549468
byte 4 0
byte 4 3305103360
byte 4 1045019230
byte 4 0
byte 4 3305164800
byte 4 1042200658
byte 4 0
byte 4 3305222144
byte 4 1032134328
byte 4 0
byte 4 3305279488
byte 4 3180557500
byte 4 1
byte 4 3305455616
byte 4 1047032496
byte 4 0
byte 4 3305512960
byte 4 3184718250
byte 4 1
byte 4 3305631744
byte 4 1036026642
byte 4 0
byte 4 3305750528
byte 4 1036697731
byte 4 0
byte 4 3305869312
byte 4 3182704984
byte 4 1
byte 4 3305930752
byte 4 1048307565
byte 4 0
byte 4 3306049536
byte 4 3194650362
byte 4 1
byte 4 3306110976
byte 4 3172974199
byte 4 1
byte 4 3306172416
byte 4 1037368820
byte 4 0
byte 4 3306233856
byte 4 1045086339
byte 4 0
byte 4 3306295296
byte 4 1048240456
byte 4 0
byte 4 3306356736
byte 4 1048106238
byte 4 0
byte 4 3306418176
byte 4 1044750795
byte 4 0
byte 4 3306479616
byte 4 1036295078
byte 4 0
byte 4 3306541056
byte 4 3175926989
byte 4 1
byte 4 3306602496
byte 4 3195589886
byte 4 1
byte 4 3306729472
byte 4 1046898278
byte 4 0
byte 4 3306790912
byte 4 3185926210
byte 4 1
byte 4 3306917888
byte 4 1032671199
byte 4 0
byte 4 3307044864
byte 4 1030322389
byte 4 0
byte 4 3307171840
byte 4 3189080326
byte 4 1
byte 4 3307237376
byte 4 1043945488
byte 4 0
byte 4 3307429888
byte 4 3187872367
byte 4 1
byte 4 3307495424
byte 4 1002740646
byte 4 0
byte 4 3307560960
byte 4 1035892425
byte 4 0
byte 4 3307626496
byte 4 1040590045
byte 4 0
byte 4 3307692032
byte 4 1039650521
byte 4 0
byte 4 3307757568
byte 4 1032000111
byte 4 0
byte 4 3307823104
byte 4 3173779505
byte 4 1
byte 4 3307888640
byte 4 3192435769
byte 4 1
byte 4 3308089344
byte 4 1030053954
byte 4 0
byte 4 3308290048
byte 4 3187671040
byte 4 1
byte 4 3308425216
byte 4 3189482979
byte 4 1
byte 4 3308630016
byte 4 3176732295
byte 4 1
byte 4 3308699648
byte 4 1046361407
byte 4 0
byte 4 3308974080
byte 4 3191429136
byte 4 1
byte 4 3309043712
byte 4 3189415870
byte 4 1
byte 4 3309113344
byte 4 3190556721
byte 4 1
byte 4 3309182976
byte 4 3194985906
byte 4 1
byte 4 3309465600
byte 4 1019517862
byte 4 0
byte 4 3309678592
byte 4 3172437328
byte 4 1
byte 4 3309821952
byte 4 1015222895
byte 4 0
byte 4 3309965312
byte 4 3187536822
byte 4 1
byte 4 3310039040
byte 4 1047569367
byte 4 0
byte 4 3310182400
byte 4 3192167334
byte 4 1
byte 4 3310256128
byte 4 1018444120
byte 4 0
byte 4 3310329856
byte 4 1044415250
byte 4 0
byte 4 3310772224
byte 4 1043811271
byte 4 0
byte 4 3310845952
byte 4 1007908028
byte 4 0
byte 4 3310919680
byte 4 3193241076
byte 4 1
byte 4 3311071232
byte 4 1046025863
byte 4 0
byte 4 3311144960
byte 4 3189281653
byte 4 1
byte 4 3311296512
byte 4 3162706543
byte 4 1
byte 4 3311448064
byte 4 3181094371
byte 4 1
byte 4 3311677440
byte 4 3167001510
byte 4 1
byte 4 3311755264
byte 4 1047233823
byte 4 0
byte 4 3312062464
byte 4 3194851688
byte 4 1
byte 4 3312140288
byte 4 3193912164
byte 4 1
byte 4 3312533504
byte 4 1040791372
byte 4 0
byte 4 3312611328
byte 4 3188677673
byte 4 1
byte 4 3312771072
byte 4 1043140182
byte 4 0
byte 4 3312848896
byte 4 3195925430
byte 4 1
byte 4 3313008640
byte 4 3194583253
byte 4 1
byte 4 3313090560
byte 4 1045958754
byte 4 0
byte 4 3313250304
byte 4 3177537602
byte 4 1
byte 4 3313332224
byte 4 1047770694
byte 4 0
byte 4 3313537024
byte 4 3190489612
byte 4 1
byte 4 3313577984
byte 4 3179483759
byte 4 1
byte 4 3313618944
byte 4 3156465418
byte 4 1
byte 4 3313659904
byte 4 3141835686
byte 4 1
byte 4 3313700864
byte 4 3174584812
byte 4 1
byte 4 3313741824
byte 4 3188342129
byte 4 1
byte 4 3313907712
byte 4 1021128475
byte 4 0
byte 4 3314032640
byte 4 3185120903
byte 4 1
byte 4 3314116608
byte 4 3184449815
byte 4 1
byte 4 3314243584
byte 4 1027369599
byte 4 0
byte 4 3314370560
byte 4 3195321450
byte 4 1
byte 4 3314413568
byte 4 3183778726
byte 4 1
byte 4 3314456576
byte 4 3137540719
byte 4 1
byte 4 3314499584
byte 4 1026832728
byte 4 0
byte 4 3314542592
byte 4 1026564293
byte 4 0
byte 4 3314585600
byte 4 3152371778
byte 4 1
byte 4 3314628608
byte 4 3184852468
byte 4 1
byte 4 3314802688
byte 4 1020054733
byte 4 0
byte 4 3314933760
byte 4 3188073693
byte 4 1
byte 4 3315021824
byte 4 3188879000
byte 4 1
byte 4 3315154944
byte 4 3164854026
byte 4 1
byte 4 3315333120
byte 4 3192301552
byte 4 1
byte 4 3315378176
byte 4 3185255121
byte 4 1
byte 4 3315423232
byte 4 3180154847
byte 4 1
byte 4 3315468288
byte 4 3181497025
byte 4 1
byte 4 3315513344
byte 4 3188409238
byte 4 1
byte 4 3315558400
byte 4 3195522777
byte 4 1
byte 4 3315695616
byte 4 1042066440
byte 4 0
byte 4 3315740672
byte 4 3188946108
byte 4 1
byte 4 3315832832
byte 4 1039113650
byte 4 0
byte 4 3315924992
byte 4 1044281033
byte 4 0
byte 4 3316017152
byte 4 1031865893
byte 4 0
byte 4 3316156416
byte 4 1016296636
byte 4 0
byte 4 3316203520
byte 4 1047904911
byte 4 0
byte 4 3316627456
byte 4 1034416030
byte 4 0
byte 4 3316674560
byte 4 3191093592
byte 4 1
byte 4 3316770816
byte 4 1042871747
byte 4 0
byte 4 3316817920
byte 4 3195187233
byte 4 1
byte 4 3316914176
byte 4 3191630463
byte 4 1
byte 4 3317059584
byte 4 1024416809
byte 4 0
byte 4 3317204992
byte 4 3191227810
byte 4 1
byte 4 3317254144
byte 4 3157539160
byte 4 1
byte 4 3317303296
byte 4 1037771473
byte 4 0
byte 4 3317352448
byte 4 1043677053
byte 4 0
byte 4 3317401600
byte 4 1045220557
byte 4 0
byte 4 3317450752
byte 4 1043475726
byte 4 0
byte 4 3317499904
byte 4 1036966167
byte 4 0
byte 4 3317549056
byte 4 3165390897
byte 4 1
byte 4 3317598208
byte 4 3192033116
byte 4 1
byte 4 3317747712
byte 4 1012202996
byte 4 0
byte 4 3317848064
byte 4 1047972020
byte 4 0
byte 4 3317897216
byte 4 3193777947
byte 4 1
byte 4 3318048768
byte 4 1039918957
byte 4 0
byte 4 3318149120
byte 4 3194314818
byte 4 1
byte 4 3318200320
byte 4 1022739087
byte 4 0
byte 4 3318251520
byte 4 1047703585
byte 4 0
byte 4 3318661120
byte 4 1042536202
byte 4 0
byte 4 3318712320
byte 4 3179752194
byte 4 1
byte 4 3318867968
byte 4 3170759606
byte 4 1
byte 4 3318972416
byte 4 1034952901
byte 4 0
byte 4 3319076864
byte 4 1010055512
byte 4 0
byte 4 3319234560
byte 4 1025222115
byte 4 0
byte 4 3319498752
byte 4 3193375293
byte 4 1
byte 4 3319552000
byte 4 3192972640
byte 4 1
byte 4 3319605248
byte 4 3195724104
byte 4 1
byte 4 3319820288
byte 4 1037905691
byte 4 0
byte 4 3319873536
byte 4 3190892265
byte 4 1
byte 4 3319982080
byte 4 1039516303
byte 4 0
byte 4 3320090624
byte 4 1046562734
byte 4 0
byte 4 3320199168
byte 4 1040455827
byte 4 0
byte 4 3320307712
byte 4 3189617197
byte 4 1
byte 4 3320363008
byte 4 1040657154
byte 4 0
byte 4 3320582144
byte 4 3192838423
byte 4 1
byte 4 3320637440
byte 4 3189751415
byte 4 1
byte 4 3320692736
byte 4 3189818524
byte 4 1
byte 4 3320748032
byte 4 3193173967
byte 4 1
byte 4 3320971264
byte 4 1038845215
byte 4 0
byte 4 3321026560
byte 4 3191026483
byte 4 1
byte 4 3321139200
byte 4 1037100384
byte 4 0
byte 4 3321251840
byte 4 1044348142
byte 4 0
byte 4 3321364480
byte 4 1034147594
byte 4 0
byte 4 3321477120
byte 4 3194046382
byte 4 1
byte 4 3321534464
byte 4 1030859260
byte 4 0
byte 4 3321998336
byte 4 1045488992
byte 4 0
byte 4 3322027008
byte 4 3174853247
byte 4 1
byte 4 3322114048
byte 4 3182033895
byte 4 1
byte 4 3322172416
byte 4 3160760386
byte 4 1
byte 4 3322230784
byte 4 3188543455
byte 4 1
byte 4 3322260480
byte 4 1047166714
byte 4 0
byte 4 3322318848
byte 4 3191563354
byte 4 1
byte 4 3322348544
byte 4 1025758986
byte 4 0
byte 4 3322378240
byte 4 1046227190
byte 4 0
byte 4 3322586112
byte 4 1035758207
byte 4 0
byte 4 3322615808
byte 4 3186731516
byte 4 1
byte 4 3322705920
byte 4 3171900457
byte 4 1
byte 4 3322766336
byte 4 1038710997
byte 4 0
byte 4 3322826752
byte 4 1032805417
byte 4 0
byte 4 3322887168
byte 4 3190355395
byte 4 1
byte 4 3322917888
byte 4 1041596678
byte 4 0
byte 4 3323009024
byte 4 3193442402
byte 4 1
byte 4 3323039744
byte 4 3183376073
byte 4 1
byte 4 3323070464
byte 4 3165927768
byte 4 1
byte 4 3323131904
byte 4 3167538381
byte 4 1
byte 4 3323162624
byte 4 3184181379
byte 4 1
byte 4 3323193344
byte 4 3194113491
byte 4 1
byte 4 3323286528
byte 4 1040254501
byte 4 0
byte 4 3323317248
byte 4 3191898898
byte 4 1
byte 4 3323379712
byte 4 1026295857
byte 4 0
byte 4 3323442176
byte 4 1033879159
byte 4 0
byte 4 3323504640
byte 4 3181228589
byte 4 1
byte 4 3323598848
byte 4 3190623830
byte 4 1
byte 4 3323630592
byte 4 1024953680
byte 4 0
byte 4 3323662336
byte 4 1044885012
byte 4 0
export jumpobs
align 4
LABELV jumpobs
byte 4 1073741824
byte 4 1040791372
byte 4 0
byte 4 1082130432
byte 4 1046629843
byte 4 0
byte 4 1090519040
byte 4 1048576000
byte 4 0
byte 4 1092616192
byte 4 1044683686
byte 4 0
byte 4 1094713344
byte 4 1034952901
byte 4 0
byte 4 1096810496
byte 4 3179886412
byte 4 1
byte 4 1100480512
byte 4 1044146815
byte 4 0
byte 4 1101529088
byte 4 3190154068
byte 4 1
byte 4 1103101952
byte 4 994352038
byte 4 0
byte 4 1104674816
byte 4 3167001510
byte 4 1
byte 4 1106247680
byte 4 3195589886
byte 4 1
byte 4 1106771968
byte 4 1033476506
byte 4 0
byte 4 1108344832
byte 4 3188073693
byte 4 1
byte 4 1108606976
byte 4 3176732295
byte 4 1
byte 4 1108869120
byte 4 3165927768
byte 4 1
byte 4 1109131264
byte 4 3173242634
byte 4 1
byte 4 1109393408
byte 4 3185120903
byte 4 1
byte 4 1109655552
byte 4 3193979273
byte 4 1
byte 4 1110179840
byte 4 1041999331
byte 4 0
byte 4 1110441984
byte 4 3189617197
byte 4 1
byte 4 1110704128
byte 4 1035623989
byte 4 0
byte 4 1110966272
byte 4 1041462460
byte 4 0
byte 4 1111228416
byte 4 1000593162
byte 4 0
byte 4 1111490560
byte 4 3179483759
byte 4 1
byte 4 1111490560
byte 4 1041865114
byte 4 0
byte 4 1111490560
byte 4 1041059807
byte 4 0
byte 4 1111490560
byte 4 3181631242
byte 4 1
byte 4 1111228416
byte 4 3165390897
byte 4 1
byte 4 1110966272
byte 4 1038442562
byte 4 0
byte 4 1110704128
byte 4 1029248647
byte 4 0
byte 4 1110441984
byte 4 3192569987
byte 4 1
byte 4 1110179840
byte 4 1037368820
byte 4 0
byte 4 1109393408
byte 4 3190422503
byte 4 1
byte 4 1109131264
byte 4 3184852468
byte 4 1
byte 4 1108869120
byte 4 3182973420
byte 4 1
byte 4 1108606976
byte 4 3187402605
byte 4 1
byte 4 1108344832
byte 4 3193039749
byte 4 1
byte 4 1106771968
byte 4 3157539160
byte 4 1
byte 4 1104674816
byte 4 3186999951
byte 4 1
byte 4 1103101952
byte 4 3184181379
byte 4 1
byte 4 1100480512
byte 4 1033073852
byte 4 0
byte 4 1096810496
byte 4 3191966007
byte 4 1
byte 4 1094713344
byte 4 3172705763
byte 4 1
byte 4 1092616192
byte 4 1032000111
byte 4 0
byte 4 1090519040
byte 4 1039247868
byte 4 0
byte 4 1086324736
byte 4 1040187392
byte 4 0
byte 4 1082130432
byte 4 1034550247
byte 4 0
byte 4 1073741824
byte 4 3150224294
byte 4 1
byte 4 0
byte 4 3188946108
byte 4 1
byte 4 3235905536
byte 4 1042200658
byte 4 0
byte 4 3239051264
byte 4 3190959374
byte 4 1
byte 4 3244294144
byte 4 1018444120
byte 4 0
byte 4 3247964160
byte 4 1021128475
byte 4 0
byte 4 3250585600
byte 4 3190019850
byte 4 1
byte 4 3252158464
byte 4 1043475726
byte 4 0
byte 4 3255566336
byte 4 3185657774
byte 4 1
byte 4 3256352768
byte 4 1023611503
byte 4 0
byte 4 3257139200
byte 4 1040254501
byte 4 0
byte 4 3257925632
byte 4 1043408617
byte 4 0
byte 4 3258712064
byte 4 1043274400
byte 4 0
byte 4 3259498496
byte 4 1039784739
byte 4 0
byte 4 3260284928
byte 4 1019517862
byte 4 0
byte 4 3261071360
byte 4 3187268387
byte 4 1
byte 4 3263430656
byte 4 1042133549
byte 4 0
byte 4 3263823872
byte 4 3191630463
byte 4 1
byte 4 3264741376
byte 4 3141835686
byte 4 1
byte 4 3265658880
byte 4 3160760386
byte 4 1
byte 4 3266576384
byte 4 3193912164
byte 4 1
byte 4 3267100672
byte 4 1038039908
byte 4 0
byte 4 3268542464
byte 4 3192704205
byte 4 1
byte 4 3269066752
byte 4 3179752194
byte 4 1
byte 4 3269591040
byte 4 1017907249
byte 4 0
byte 4 3270115328
byte 4 1030859260
byte 4 0
byte 4 3270639616
byte 4 1028443341
byte 4 0
byte 4 3271163904
byte 4 3154317935
byte 4 1
byte 4 3271622656
byte 4 3186194645
byte 4 1
byte 4 3272736768
byte 4 3162706543
byte 4 1
byte 4 3273326592
byte 4 1048240456
byte 4 0
byte 4 3273588736
byte 4 3192502878
byte 4 1
byte 4 3274178560
byte 4 3194314818
byte 4 1
byte 4 3274506240
byte 4 1044549468
byte 4 0
byte 4 3275096064
byte 4 3187671040
byte 4 1
byte 4 3275423744
byte 4 1041596678
byte 4 0
byte 4 3276996608
byte 4 3194180600
byte 4 1
byte 4 3277324288
byte 4 3195388559
byte 4 1
byte 4 3278700544
byte 4 1045891645
byte 4 0
byte 4 3279028224
byte 4 3175390118
byte 4 1
byte 4 3280011264
byte 4 3185523556
byte 4 1
byte 4 3280371712
byte 4 3177537602
byte 4 1
byte 4 3280732160
byte 4 3192368660
byte 4 1
byte 4 3280928768
byte 4 1042737529
byte 4 0
byte 4 3281485824
byte 4 3175926989
byte 4 1
byte 4 3281682432
byte 4 1039113650
byte 4 0
byte 4 3281879040
byte 4 1047569367
byte 4 0
byte 4 3282665472
byte 4 1047166714
byte 4 0
byte 4 3282862080
byte 4 1037771473
byte 4 0
byte 4 3283058688
byte 4 3179148214
byte 4 1
byte 4 3283681280
byte 4 1041261134
byte 4 0
byte 4 3283877888
byte 4 3194113491
byte 4 1
byte 4 3284303872
byte 4 3182704984
byte 4 1
byte 4 3284729856
byte 4 3189147435
byte 4 1
byte 4 3285385216
byte 4 3183778726
byte 4 1
byte 4 3285614592
byte 4 1042401985
byte 4 0
byte 4 3287908352
byte 4 1031664566
byte 4 0
byte 4 3288137728
byte 4 3193442402
byte 4 1
byte 4 3288481792
byte 4 1036563513
byte 4 0
byte 4 3288727552
byte 4 1046160081
byte 4 0
byte 4 3288973312
byte 4 1041126916
byte 4 0
byte 4 3289219072
byte 4 3187872367
byte 4 1
byte 4 3289350144
byte 4 1042938855
byte 4 0
byte 4 3289726976
byte 4 3195254342
byte 4 1
byte 4 3289858048
byte 4 3188409238
byte 4 1
byte 4 3289989120
byte 4 3181899678
byte 4 1
byte 4 3290120192
byte 4 3180960154
byte 4 1
byte 4 3290251264
byte 4 3186597298
byte 4 1
byte 4 3290382336
byte 4 3193106858
byte 4 1
byte 4 3290791936
byte 4 1047703585
byte 4 0
byte 4 3290923008
byte 4 3174584812
byte 4 1
byte 4 3291201536
byte 4 1048441782
byte 4 0
byte 4 3291332608
byte 4 3191227810
byte 4 1
byte 4 3291611136
byte 4 3190892265
byte 4 1
byte 4 3292037120
byte 4 3168075252
byte 4 1
byte 4 3292610560
byte 4 3190556721
byte 4 1
byte 4 3292758016
byte 4 3180825936
byte 4 1
byte 4 3292905472
byte 4 3168612123
byte 4 1
byte 4 3293052928
byte 4 3169685864
byte 4 1
byte 4 3293200384
byte 4 3181362807
byte 4 1
byte 4 3293347840
byte 4 3191093592
byte 4 1
byte 4 3293806592
byte 4 1048106238
byte 4 0
byte 4 3293954048
byte 4 3174853247
byte 4 1
byte 4 3294265344
byte 4 1047233823
byte 4 0
byte 4 3294412800
byte 4 3192905531
byte 4 1
byte 4 3294724096
byte 4 3193643729
byte 4 1
byte 4 3294887936
byte 4 1045757428
byte 4 0
byte 4 3295199232
byte 4 3183107637
byte 4 1
byte 4 3295363072
byte 4 1044348142
byte 4 0
byte 4 3296002048
byte 4 3191294919
byte 4 1
byte 4 3296165888
byte 4 3188744782
byte 4 1
byte 4 3296329728
byte 4 3189348762
byte 4 1
byte 4 3296493568
byte 4 3193241076
byte 4 1
byte 4 3296944128
byte 4 1034281812
byte 4 0
byte 4 3297026048
byte 4 3193777947
byte 4 1
byte 4 3297198080
byte 4 1027101164
byte 4 0
byte 4 3297370112
byte 4 1038576779
byte 4 0
byte 4 3297542144
byte 4 3156465418
byte 4 1
byte 4 3297804288
byte 4 3177269166
byte 4 1
byte 4 3297894400
byte 4 1043073073
byte 4 0
byte 4 3298615296
byte 4 1046495625
byte 4 0
byte 4 3298705408
byte 4 1007908028
byte 4 0
byte 4 3298795520
byte 4 3195925430
byte 4 1
byte 4 3298983936
byte 4 1035892425
byte 4 0
byte 4 3299172352
byte 4 1047972020
byte 4 0
byte 4 3299360768
byte 4 1045086339
byte 4 0
byte 4 3299549184
byte 4 3172437328
byte 4 1
byte 4 3299835904
byte 4 3196059648
byte 4 1
byte 4 3299934208
byte 4 3182033895
byte 4 1
byte 4 3300032512
byte 4 1024416809
byte 4 0
byte 4 3300130816
byte 4 1037503037
byte 4 0
byte 4 3300229120
byte 4 1040388719
byte 4 0
byte 4 3300327424
byte 4 1037100384
byte 4 0
byte 4 3300425728
byte 4 1022202216
byte 4 0
byte 4 3300524032
byte 4 3183376073
byte 4 1
byte 4 3300925440
byte 4 3178342908
byte 4 1
byte 4 3301130240
byte 4 1043140182
byte 4 0
byte 4 3301335040
byte 4 1045623210
byte 4 0
byte 4 3301539840
byte 4 1028711776
byte 4 0
byte 4 3301851136
byte 4 3173779505
byte 4 1
byte 4 3301957632
byte 4 1042871747
byte 4 0
byte 4 3302809600
byte 4 1035221336
byte 4 0
byte 4 3302916096
byte 4 3188543455
byte 4 1
byte 4 3303243776
byte 4 3184718250
byte 4 1
byte 4 3303464960
byte 4 1013276738
byte 4 0
byte 4 3303686144
byte 4 3178879779
byte 4 1
byte 4 3304022016
byte 4 3171632022
byte 4 1
byte 4 3304136704
byte 4 1046092972
byte 4 0
byte 4 3305197568
byte 4 1024953680
byte 4 0
byte 4 3305254912
byte 4 3195724104
byte 4 1
byte 4 3305373696
byte 4 1027906470
byte 4 0
byte 4 3305492480
byte 4 1041798005
byte 4 0
byte 4 3305611264
byte 4 1030590824
byte 4 0
byte 4 3305730048
byte 4 3194449035
byte 4 1
byte 4 3305791488
byte 4 1031396131
byte 4 0
byte 4 3306094592
byte 4 3194516144
byte 4 1
byte 4 3306156032
byte 4 3194650362
byte 4 1
byte 4 3306467328
byte 4 1026564293
byte 4 0
byte 4 3306528768
byte 4 3195858321
byte 4 1
byte 4 3306655744
byte 4 1022739087
byte 4 0
byte 4 3306782720
byte 4 1038845215
byte 4 0
byte 4 3306909696
byte 4 1006834287
byte 4 0
byte 4 3307102208
byte 4 3159686644
byte 4 1
byte 4 3307167744
byte 4 1046428516
byte 4 0
byte 4 3307757568
byte 4 1040590045
byte 4 0
byte 4 3307823104
byte 4 3186865734
byte 4 1
byte 4 3307958272
byte 4 1047770694
byte 4 0
byte 4 3308023808
byte 4 3189751415
byte 4 1
byte 4 3308158976
byte 4 3182570766
byte 4 1
byte 4 3308294144
byte 4 3193375293
byte 4 1
byte 4 3308363776
byte 4 1042267767
byte 4 0
byte 4 3308568576
byte 4 3171095151
byte 4 1
byte 4 3308638208
byte 4 1041328243
byte 4 0
byte 4 3309056000
byte 4 1043945488
byte 4 0
byte 4 3309125632
byte 4 1016833507
byte 4 0
byte 4 3309195264
byte 4 3192100225
byte 4 1
byte 4 3309338624
byte 4 1048307565
byte 4 0
byte 4 3309408256
byte 4 3185255121
byte 4 1
byte 4 3309551616
byte 4 1026027422
byte 4 0
byte 4 3309694976
byte 4 3137540719
byte 4 1
byte 4 3309838336
byte 4 3195187233
byte 4 1
byte 4 3309912064
byte 4 1033208070
byte 4 0
byte 4 3310202880
byte 4 3190355395
byte 4 1
byte 4 3310276608
byte 4 3183644508
byte 4 1
byte 4 3310350336
byte 4 3180557500
byte 4 1
byte 4 3310424064
byte 4 3184047161
byte 4 1
byte 4 3310497792
byte 4 3190758048
byte 4 1
byte 4 3310796800
byte 4 1029517083
byte 4 0
byte 4 3311022080
byte 4 3170759606
byte 4 1
byte 4 3311173632
byte 4 1002740646
byte 4 0
byte 4 3311325184
byte 4 3189281653
byte 4 1
byte 4 3311403008
byte 4 1045287666
byte 4 0
byte 4 3311554560
byte 4 3195522777
byte 4 1
byte 4 3311632384
byte 4 3172168892
byte 4 1
byte 4 3311710208
byte 4 1039918957
byte 4 0
byte 4 3311788032
byte 4 1047435149
byte 4 0
byte 4 3312099328
byte 4 1044885012
byte 4 0
byte 4 3312177152
byte 4 1032134328
byte 4 0
byte 4 3312254976
byte 4 3185926210
byte 4 1
byte 4 3312492544
byte 4 1032402764
byte 4 0
byte 4 3312730112
byte 4 3191764681
byte 4 1
byte 4 3312971776
byte 4 1040455827
byte 4 0
byte 4 3313131520
byte 4 3194985906
byte 4 1
byte 4 3313213440
byte 4 1011129254
byte 4 0
byte 4 3313295360
byte 4 1045958754
byte 4 0
byte 4 3313725440
byte 4 1032805417
byte 4 0
byte 4 3313766400
byte 4 3190288286
byte 4 1
byte 4 3313850368
byte 4 1046898278
byte 4 0
byte 4 3313891328
byte 4 3189482979
byte 4 1
byte 4 3313975296
byte 4 3176463860
byte 4 1
byte 4 3314059264
byte 4 3188879000
byte 4 1
byte 4 3314102272
byte 4 1047837802
byte 4 0
byte 4 3314186240
byte 4 3188677673
byte 4 1
byte 4 3314229248
byte 4 1036697731
byte 4 0
byte 4 3314616320
byte 4 1034684465
byte 4 0
byte 4 3314659328
byte 4 3189818524
byte 4 1
byte 4 3314747392
byte 4 1046294299
byte 4 0
byte 4 3314790400
byte 4 3190690939
byte 4 1
byte 4 3314878464
byte 4 3182302331
byte 4 1
byte 4 3314966528
byte 4 3192167334
byte 4 1
byte 4 3315011584
byte 4 1044012597
byte 4 0
byte 4 3315099648
byte 4 3193576620
byte 4 1
byte 4 3315144704
byte 4 1015759766
byte 4 0
byte 4 3315189760
byte 4 1045220557
byte 4 0
byte 4 3315505152
byte 4 1040657154
byte 4 0
byte 4 3315550208
byte 4 3180154847
byte 4 1
byte 4 3315687424
byte 4 1025222115
byte 4 0
byte 4 3315779584
byte 4 1045421883
byte 4 0
byte 4 3315871744
byte 4 1043609944
byte 4 0
byte 4 3315963904
byte 4 3174047941
byte 4 1
byte 4 3316103168
byte 4 3194851688
byte 4 1
byte 4 3316150272
byte 4 3178074472
byte 4 1
byte 4 3316197376
byte 4 1032536982
byte 4 0
byte 4 3316244480
byte 4 1041663787
byte 4 0
byte 4 3316291584
byte 4 1043677053
byte 4 0
byte 4 3316338688
byte 4 1042536202
byte 4 0
byte 4 3316385792
byte 4 1036026642
byte 4 0
byte 4 3316432896
byte 4 3164854026
byte 4 1
byte 4 3316480000
byte 4 3191429136
byte 4 1
byte 4 3316623360
byte 4 1027369599
byte 4 0
byte 4 3316766720
byte 4 3189952741
byte 4 1
byte 4 3316862976
byte 4 3192838423
byte 4 1
byte 4 3316912128
byte 4 1045556101
byte 4 0
byte 4 3317008384
byte 4 3187738149
byte 4 1
byte 4 3317057536
byte 4 1040925590
byte 4 0
byte 4 3317549056
byte 4 1039516303
byte 4 0
byte 4 3317598208
byte 4 3189080326
byte 4 1
byte 4 3317698560
byte 4 1043811271
byte 4 0
byte 4 3317747712
byte 4 3194784580
byte 4 1
byte 4 3317848064
byte 4 3192301552
byte 4 1
byte 4 3317999616
byte 4 981668463
byte 4 0
byte 4 3318151168
byte 4 3195053015
byte 4 1
byte 4 3318202368
byte 4 3181228589
byte 4 1
byte 4 3318253568
byte 4 1023879938
byte 4 0
byte 4 3318304768
byte 4 1036295078
byte 4 0
byte 4 3318355968
byte 4 1038174126
byte 4 0
byte 4 3318407168
byte 4 1033610723
byte 4 0
byte 4 3318458368
byte 4 3148076810
byte 4 1
byte 4 3318509568
byte 4 3188342129
byte 4 1
byte 4 3318665216
byte 4 1044415250
byte 4 0
byte 4 3318716416
byte 4 3188207911
byte 4 1
byte 4 3318820864
byte 4 1034147594
byte 4 0
byte 4 3318925312
byte 4 1036831949
byte 4 0
byte 4 3319029760
byte 4 3180423283
byte 4 1
byte 4 3319187456
byte 4 3191898898
byte 4 1
byte 4 3319240704
byte 4 1010055512
byte 4 0
byte 4 3319293952
byte 4 1042603311
byte 4 0
byte 4 3319560192
byte 4 1044750795
byte 4 0
byte 4 3319613440
byte 4 1029785518
byte 4 0
byte 4 3319666688
byte 4 3188006584
byte 4 1
byte 4 3319828480
byte 4 1020054733
byte 4 0
byte 4 3319937024
byte 4 1046696952
byte 4 0
byte 4 3320045568
byte 4 1047032496
byte 4 0
byte 4 3320154112
byte 4 1025490551
byte 4 0
byte 4 3320317952
byte 4 3184584032
byte 4 1
byte 4 3320373248
byte 4 1035355554
byte 4 0
byte 4 3320428544
byte 4 1047300932
byte 4 0
byte 4 3320705024
byte 4 1046764061
byte 4 0
byte 4 3320760320
byte 4 1033879159
byte 4 0
byte 4 3320815616
byte 4 3186463080
byte 4 1
byte 4 3320983552
byte 4 1015222895
byte 4 0
byte 4 3321096192
byte 4 1044952121
byte 4 0
byte 4 3321208832
byte 4 1044213924
byte 4 0
byte 4 3321321472
byte 4 3163780284
byte 4 1
byte 4 3321491456
byte 4 3191563354
byte 4 1
byte 4 3321548800
byte 4 2147483648
byte 4 1
byte 4 3321606144
byte 4 1040791372
byte 4 0
byte 4 3321663488
byte 4 1046562734
byte 4 0
byte 4 3321778176
byte 4 1048508891
byte 4 0
byte 4 3321835520
byte 4 1044616577
byte 4 0
byte 4 3321890816
byte 4 1034952901
byte 4 0
byte 4 3321919488
byte 4 3179886412
byte 4 1
byte 4 3322006528
byte 4 1044146815
byte 4 0
byte 4 3322035200
byte 4 3190154068
byte 4 1
byte 4 3322093568
byte 4 994352038
byte 4 0
byte 4 3322151936
byte 4 3167001510
byte 4 1
byte 4 3322210304
byte 4 3195656995
byte 4 1
byte 4 3322240000
byte 4 1033342288
byte 4 0
byte 4 3322357760
byte 4 3188140802
byte 4 1
byte 4 3322387456
byte 4 3177000731
byte 4 1
byte 4 3322417152
byte 4 3166464639
byte 4 1
byte 4 3322446848
byte 4 3173511070
byte 4 1
byte 4 3322476544
byte 4 3185120903
byte 4 1
byte 4 3322506240
byte 4 3194046382
byte 4 1
byte 4 3322596352
byte 4 1041932222
byte 4 0
byte 4 3322626048
byte 4 3189617197
byte 4 1
byte 4 3322686464
byte 4 1035623989
byte 4 0
byte 4 3322746880
byte 4 1041462460
byte 4 0
byte 4 3322807296
byte 4 998445679
byte 4 0
byte 4 3322898432
byte 4 3179483759
byte 4 1
byte 4 3322929152
byte 4 1041865114
byte 4 0
byte 4 3323174912
byte 4 1040992698
byte 4 0
byte 4 3323205632
byte 4 3181765460
byte 4 1
byte 4 3323298816
byte 4 3165390897
byte 4 1
byte 4 3323361280
byte 4 1038308344
byte 4 0
byte 4 3323423744
byte 4 1028980212
byte 4 0
byte 4 3323486208
byte 4 3192637096
byte 4 1
byte 4 3323517952
byte 4 1037368820
byte 4 0
byte 4 3323643904
byte 4 3190489612
byte 4 1
byte 4 3323675648
byte 4 3184852468
byte 4 1
byte 4 3323707392
byte 4 3182973420
byte 4 1
byte 4 3323739136
byte 4 3187402605
byte 4 1
lit
align 4
LABELV $1887
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
skip 4
align 4
LABELV $1888
byte 4 3245342720
byte 4 3245342720
byte 4 3250585600
align 4
LABELV $1889
byte 4 1097859072
byte 4 1097859072
byte 4 1098907648
export CG_DrawOBs
code
proc CG_DrawOBs 200 44
line 3881
;3162:
;3163://-------------------------------------
;3164:// OB STUFF
;3165://-------------------------------------
;3166:
;3167:typedef struct
;3168:{
;3169:	float height;
;3170:	float offset;
;3171:	int type;		//0 = h, 1 = sobh
;3172:} ob_info_t;
;3173:
;3174://these are for speed optimizations
;3175:#define OBF_OPT_10			8
;3176:#define OBF_OPT_100			24
;3177:#define OBF_OPT_500			64
;3178:#define OBF_OPT_1000		90
;3179:#define OBF_OPT_5000		228
;3180:#define OBF_OPT_END			319
;3181:
;3182:ob_info_t fallobs[] =
;3183:{
;3184://	{0.0f, -0.026f, 1},
;3185://	{0.0f, -0.099f, 1},
;3186://	{0.0f, -0.221f, 1},
;3187:	{-1.0f, 0.126f, 0},		//0
;3188:	{-1.0f, -0.187f, 1},
;3189:	{-2.0f, 0.042f, 0},
;3190:	{-3.0f, 0.078f, 0},
;3191:	{-4.0f, -0.077f, 1},
;3192:	{-6.0f, -0.170f, 1},
;3193:	{-7.0f, 0.037f, 0},
;3194:	{-8.0f, 0.195f, 0},
;3195:	{-14.0f, 0.138f, 0},
;3196:	{-15.0f, -0.040f, 1},
;3197:	{-19.0f, 0.139f, 0},	//10
;3198:	{-20.0f, -0.230f, 1},
;3199:	{-23.0f, -0.114f, 1},
;3200:	{-26.0f, -0.189f, 1},
;3201:	{-28.0f, 0.202f, 0},
;3202:	{-31.0f, -0.162f, 1},
;3203:	{-33.0f, 0.085f, 0},
;3204:	{-51.0f, 0.142f, 0},
;3205:	{-53.0f, -0.091f, 1},
;3206:	{-60.0f, -0.080f, 1},
;3207:	{-65.0f, 0.021f, 0},	//20
;3208:	{-70.0f, -0.070f, 1},
;3209:	{-78.0f, -0.067f, 1},
;3210:	{-81.0f, 0.171f, 0},
;3211:	{-108.0f, 0.157f, 0},
;3212:	{-111.0f, -0.085f, 1},
;3213:	{-121.0f, -0.098f, 1},
;3214:	{-128.0f, -0.013f, 1},
;3215:	{-135.0f, -0.120f, 1},
;3216:	{-146.0f, -0.141f, 1},
;3217:	{-150.0f, 0.090f, 0},	//30
;3218:	{-182.0f, 0.205f, 0},
;3219:	{-186.0f, 0.003f, 0},
;3220:	{-190.0f, -0.246f, 1},
;3221:	{-199.0f, 0.110f, 0},
;3222:	{-212.0f, -0.214f, 1},
;3223:	{-217.0f, 0.248f, 0},
;3224:	{-226.0f, 0.029f, 0},
;3225:	{-240.0f, -0.160f, 1},
;3226:	{-245.0f, 0.014f, 0},
;3227:	{-250.0f, 0.141f, 0},	//40
;3228:	{-255.0f, 0.219f, 0},
;3229:	{-260.0f, 0.250f, 0},
;3230:	{-265.0f, 0.232f, 0},
;3231:	{-270.0f, 0.166f, 0},
;3232:	{-275.0f, 0.053f, 0},
;3233:	{-280.0f, -0.109f, 1},
;3234:	{-296.0f, 0.118f, 0},
;3235:	{-301.0f, -0.235f, 1},
;3236:	{-312.0f, -0.086f, 1},
;3237:	{-323.0f, -0.130f, 1},	//50
;3238:	{-340.0f, -0.054f, 1},
;3239:	{-346.0f, 0.208f, 0},
;3240:	{-369.0f, -0.222f, 1},
;3241:	{-375.0f, -0.200f, 1},
;3242:	{-381.0f, -0.226f, 1},
;3243:	{-406.0f, 0.192f, 0},
;3244:	{-412.0f, -0.074f, 1},
;3245:	{-431.0f, -0.158f, 1},
;3246:	{-444.0f, -0.122f, 1},
;3247:	{-464.0f, 0.074f, 0},	//60
;3248:	{-484.0f, -0.163f, 1},
;3249:	{-491.0f, -0.005f, 1},
;3250:	{-498.0f, 0.106f, 0},
;3251:	{-505.0f, 0.168f, 0},
;3252:	{-512.0f, 0.182f, 0},
;3253:	{-519.0f, 0.149f, 0},
;3254:	{-526.0f, 0.067f, 0},
;3255:	{-533.0f, -0.062f, 1},
;3256:	{-540.0f, -0.240f, 1},
;3257:	{-562.0f, -0.061f, 1},	//70
;3258:	{-577.0f, 0.152f, 0},
;3259:	{-592.0f, 0.173f, 0},
;3260:	{-607.0f, 0.002f, 0},
;3261:	{-630.0f, -0.115f, 1},
;3262:	{-638.0f, 0.083f, 0},
;3263:	{-646.0f, 0.234f, 0},
;3264:	{-694.0f, 0.128f, 0},
;3265:	{-702.0f, -0.058f, 1},
;3266:	{-727.0f, 0.098f, 0},
;3267://	{-727.0f, ???, 1},		//TODO: unkown sticky
;3268:	{-752.0f, -0.179f, 1},	//80
;3269:	{-778.0f, 0.112f, 0},
;3270:	{-804.0f, -0.029f, 1},
;3271:	{-813.0f, 0.162f, 0},
;3272:	{-876.0f, 0.150f, 0},
;3273:	{-885.0f, -0.043f, 1},
;3274:	{-913.0f, 0.088f, 0},
;3275:	{-941.0f, -0.213f, 1},
;3276:	{-970.0f, 0.054f, 0},
;3277:	{-999.0f, -0.110f, 1},
;3278:	{-1009.0f, 0.072f, 0},	//90
;3279://	{-1009.0f, ???, 1},		//TODO: unknown sticky
;3280:	{-1019.0f, 0.206f, 0},
;3281:	{-1069.0f, 0.158f, 0},
;3282:	{-1079.0f, 0.005f, 0},
;3283:	{-1089.0f, -0.197f, 1},
;3284:	{-1120.0f, -0.090f, 1},
;3285:	{-1141.0f, 0.075f, 0},
;3286:	{-1162.0f, 0.048f, 0},
;3287:	{-1183.0f, -0.171f, 1},
;3288:	{-1194.0f, 0.147f, 0},
;3289:	{-1226.0f, -0.186f, 1},	//100
;3290:	{-1237.0f, -0.059f, 1},
;3291:	{-1248.0f, 0.019f, 0},
;3292:	{-1259.0f, 0.049f, 0},
;3293:	{-1270.0f, 0.032f, 0},
;3294://	{-1270.0f, ???, 1},		//TODO: unknown sticky
;3295:	{-1281.0f, -0.034f, 1},
;3296:	{-1292.0f, -0.147f, 1},
;3297:	{-1326.0f, 0.224f, 0},
;3298:	{-1337.0f, -0.082f, 1},
;3299:	{-1360.0f, 0.163f, 0},
;3300:	{-1383.0f, 0.216f, 0},	//110
;3301:	{-1406.0f, 0.077f, 0},
;3302:	{-1441.0f, 0.008f, 0},
;3303:	{-1453.0f, 0.222f, 0},
;3304:	{-1549.0f, 0.209f, 0},
;3305:	{-1561.0f, -0.008f, 1},
;3306:	{-1598.0f, 0.051f, 0},
;3307:	{-1623.0f, 0.184f, 0},
;3308:	{-1648.0f, 0.125f, 0},
;3309:	{-1673.0f, -0.127f, 1},
;3310:	{-1686.0f, 0.176f, 0},	//120
;3311:	{-1724.0f, -0.205f, 1},
;3312:	{-1737.0f, -0.095f, 1},
;3313:	{-1750.0f, -0.032f, 1},
;3314:	{-1763.0f, -0.018f, 1},
;3315:	{-1776.0f, -0.051f, 1},
;3316:	{-1789.0f, -0.133f, 1},
;3317:	{-1842.0f, 0.061f, 0},
;3318:	{-1882.0f, -0.048f, 1},
;3319:	{-1909.0f, -0.027f, 1},
;3320:	{-1936.0f, -0.199f, 1},	//130
;3321:	{-1950.0f, 0.144f, 0},
;3322:	{-1991.0f, -0.117f, 1},
;3323:	{-2005.0f, 0.033f, 0},
;3324:	{-2019.0f, 0.136f, 0},
;3325:	{-2033.0f, 0.190f, 0},
;3326:	{-2047.0f, 0.197f, 0},
;3327:	{-2061.0f, 0.155f, 0},
;3328:	{-2075.0f, 0.065f, 0},
;3329://	{-2075.0f, ???, 1},		//TODO: unknown sticky
;3330:	{-2089.0f, -0.072f, 1},
;3331:	{-2132.0f, 0.227f, 0},	//140
;3332:	{-2146.0f, -0.103f, 1},
;3333:	{-2175.0f, 0.094f, 0},
;3334:	{-2204.0f, 0.099f, 0},
;3335:	{-2233.0f, -0.088f, 1},
;3336:	{-2248.0f, 0.246f, 0},
;3337:	{-2277.0f, -0.229f, 1},
;3338:	{-2292.0f, -0.039f, 1},
;3339:	{-2307.0f, 0.104f, 0},
;3340:	{-2322.0f, 0.198f, 0},
;3341:	{-2337.0f, 0.245f, 0},	//150
;3342:	{-2352.0f, 0.243f, 0},
;3343:	{-2367.0f, 0.193f, 0},
;3344:	{-2382.0f, 0.096f, 0},
;3345:	{-2397.0f, -0.050f, 1},
;3346:	{-2412.0f, -0.243f, 1},
;3347:	{-2443.0f, 0.225f, 0},
;3348:	{-2458.0f, -0.112f, 1},
;3349:	{-2489.0f, 0.069f, 0},
;3350:	{-2520.0f, 0.057f, 0},
;3351:	{-2551.0f, -0.146f, 1},	//160
;3352:	{-2567.0f, 0.181f, 0},
;3353:	{-2614.0f, -0.128f, 1},
;3354:	{-2630.0f, 0.006f, 0},
;3355:	{-2646.0f, 0.093f, 0},
;3356:	{-2662.0f, 0.131f, 0},
;3357:	{-2678.0f, 0.121f, 0},
;3358:	{-2694.0f, 0.064f, 0},
;3359:	{-2710.0f, -0.042f, 1},
;3360:	{-2726.0f, -0.196f, 1},
;3361:	{-2775.0f, 0.056f, 0},	//170
;3362:	{-2824.0f, -0.125f, 1},
;3363:	{-2857.0f, -0.152f, 1},
;3364:	{-2907.0f, -0.053f, 1},
;3365:	{-2924.0f, 0.217f, 0},
;3366:	{-2991.0f, -0.181f, 1},
;3367:	{-3008.0f, -0.151f, 1},
;3368:	{-3025.0f, -0.168f, 1},
;3369:	{-3042.0f, -0.234f, 1},
;3370:	{-3111.0f, 0.024f, 0},
;3371:	{-3163.0f, -0.037f, 1},	//180
;3372:	{-3198.0f, 0.016f, 0},
;3373:	{-3233.0f, -0.124f, 1},
;3374:	{-3251.0f, 0.235f, 0},
;3375:	{-3286.0f, -0.192f, 1},
;3376:	{-3304.0f, 0.022f, 0},
;3377:	{-3322.0f, 0.188f, 0},
;3378:	{-3430.0f, 0.179f, 0},
;3379:	{-3448.0f, 0.009f, 0},
;3380:	{-3466.0f, -0.208f, 1},
;3381:	{-3503.0f, 0.212f, 0},	//190
;3382:	{-3521.0f, -0.149f, 1},
;3383:	{-3558.0f, -0.016f, 1},
;3384:	{-3595.0f, -0.076f, 1},
;3385:	{-3651.0f, -0.024f, 1},
;3386:	{-3670.0f, 0.230f, 0},
;3387:	{-3745.0f, -0.232f, 1},
;3388:	{-3764.0f, -0.218f, 1},
;3389:	{-3860.0f, 0.134f, 0},
;3390:	{-3879.0f, -0.140f, 1},
;3391:	{-3918.0f, 0.169f, 0},	//200
;3392:	{-3937.0f, -0.248f, 1},
;3393:	{-3976.0f, -0.228f, 1},
;3394:	{-3996.0f, 0.211f, 0},
;3395:	{-4035.0f, -0.056f, 1},
;3396:	{-4055.0f, 0.238f, 0},
;3397:	{-4114.0f, -0.167f, 1},
;3398:	{-4134.0f, -0.064f, 1},
;3399:	{-4154.0f, -0.010f, 1},
;3400:	{-4174.0f, -0.003f, 1},
;3401:	{-4194.0f, -0.045f, 1},	//210
;3402:	{-4214.0f, -0.135f, 1},
;3403:	{-4295.0f, 0.027f, 0},
;3404:	{-4356.0f, -0.106f, 1},
;3405:	{-4397.0f, -0.101f, 1},
;3406:	{-4459.0f, 0.046f, 0},
;3407:	{-4521.0f, -0.239f, 1},
;3408:	{-4542.0f, -0.096f, 1},
;3409:	{-4563.0f, -0.002f, 1},
;3410:	{-4584.0f, 0.044f, 0},
;3411:	{-4605.0f, 0.043f, 0},	//220
;3412:	{-4626.0f, -0.007f, 1},
;3413:	{-4647.0f, -0.104f, 1},
;3414:	{-4732.0f, 0.025f, 0},
;3415:	{-4796.0f, -0.131f, 1},
;3416:	{-4839.0f, -0.143f, 1},
;3417:	{-4904.0f, -0.020f, 1},
;3418:	{-4991.0f, -0.194f, 1},
;3419:	{-5013.0f, -0.107f, 1},
;3420:	{-5035.0f, -0.069f, 1},
;3421:	{-5057.0f, -0.079f, 1},	//230
;3422:	{-5079.0f, -0.136f, 1},
;3423:	{-5101.0f, -0.242f, 1},
;3424:	{-5168.0f, 0.153f, 0},
;3425:	{-5190.0f, -0.144f, 1},
;3426:	{-5235.0f, 0.117f, 0},
;3427:	{-5280.0f, 0.186f, 0},
;3428:	{-5325.0f, 0.063f, 0},
;3429:	{-5393.0f, 0.018f, 0},
;3430:	{-5416.0f, 0.240f, 0},
;3431:	{-5623.0f, 0.082f, 0},	//240
;3432:	{-5646.0f, -0.176f, 1},
;3433:	{-5693.0f, 0.165f, 0},
;3434:	{-5716.0f, -0.237f, 1},
;3435:	{-5763.0f, -0.184f, 1},
;3436:	{-5834.0f, 0.035f, 0},
;3437:	{-5905.0f, -0.178f, 1},
;3438:	{-5929.0f, -0.011f, 1},
;3439:	{-5953.0f, 0.107f, 0},
;3440:	{-5977.0f, 0.177f, 0},
;3441:	{-6001.0f, 0.200f, 0},	//250
;3442:	{-6025.0f, 0.174f, 0},
;3443:	{-6049.0f, 0.101f, 0},
;3444:	{-6073.0f, -0.021f, 1},
;3445:	{-6097.0f, -0.190f, 1},
;3446:	{-6170.0f, 0.013f, 0},
;3447:	{-6219.0f, 0.241f, 0},
;3448:	{-6243.0f, -0.216f, 1},
;3449:	{-6317.0f, 0.123f, 0},
;3450:	{-6366.0f, -0.224f, 1},
;3451:	{-6391.0f, 0.030f, 0},	//260
;3452:	{-6416.0f, 0.237f, 0},
;3453:	{-6616.0f, 0.160f, 0},
;3454:	{-6641.0f, -0.066f, 1},
;3455:	{-6717.0f, -0.031f, 1},
;3456:	{-6768.0f, 0.086f, 0},
;3457:	{-6819.0f, 0.011f, 0},
;3458:	{-6896.0f, 0.038f, 0},
;3459:	{-7025.0f, -0.210f, 1},
;3460:	{-7051.0f, -0.204f, 1},
;3461:	{-7077.0f, -0.245f, 1},	//270
;3462:	{-7182.0f, 0.108f, 0},
;3463:	{-7208.0f, -0.173f, 1},
;3464:	{-7261.0f, 0.120f, 0},
;3465:	{-7314.0f, 0.220f, 0},
;3466:	{-7367.0f, 0.129f, 0},
;3467:	{-7420.0f, -0.154f, 1},
;3468:	{-7447.0f, 0.132f, 0},
;3469:	{-7554.0f, -0.202f, 1},
;3470:	{-7581.0f, -0.156f, 1},
;3471:	{-7608.0f, -0.157f, 1},	//280
;3472:	{-7635.0f, -0.207f, 1},
;3473:	{-7744.0f, 0.115f, 0},
;3474:	{-7771.0f, -0.175f, 1},
;3475:	{-7826.0f, 0.102f, 0},
;3476:	{-7881.0f, 0.187f, 0},
;3477:	{-7936.0f, 0.080f, 0},
;3478:	{-7991.0f, -0.220f, 1},
;3479:	{-8019.0f, 0.059f, 0},
;3480:	{-8299.0f, 0.204f, 0},
;3481:	{-8327.0f, -0.046f, 1},	//290
;3482:	{-8412.0f, -0.083f, 1},
;3483:	{-8469.0f, -0.014f, 1},
;3484:	{-8526.0f, -0.138f, 1},
;3485:	{-8555.0f, 0.229f, 0},
;3486:	{-8612.0f, -0.183f, 1},
;3487:	{-8641.0f, 0.040f, 0},
;3488:	{-8670.0f, 0.215f, 0},
;3489:	{-8873.0f, 0.092f, 0},
;3490:	{-8902.0f, -0.118f, 1},
;3491:	{-8990.0f, -0.035f, 1},	//300
;3492:	{-9049.0f, 0.114f, 0},
;3493:	{-9108.0f, 0.070f, 0},
;3494:	{-9167.0f, -0.165f, 1},
;3495:	{-9197.0f, 0.146f, 0},
;3496:	{-9286.0f, -0.211f, 1},
;3497:	{-9316.0f, -0.093f, 1},
;3498:	{-9346.0f, -0.022f, 1},
;3499:	{-9406.0f, -0.025f, 1},
;3500:	{-9436.0f, -0.099f, 1},
;3501:	{-9466.0f, -0.221f, 1},	//310
;3502:	{-9557.0f, 0.126f, 0},
;3503:	{-9587.0f, -0.188f, 1},
;3504:	{-9648.0f, 0.042f, 0},
;3505:	{-9709.0f, 0.078f, 0},
;3506:	{-9770.0f, -0.077f, 1},
;3507:	{-9862.0f, -0.169f, 1},
;3508:	{-9893.0f, 0.037f, 0},
;3509:	{-9924.0f, 0.195f, 0}	//318
;3510:};
;3511:
;3512:#define OBJ_OPT_5			49
;3513:#define OBJ_OPT_30			55
;3514:#define OBJ_OPT_100			69
;3515:#define OBJ_OPT_500			104
;3516:#define OBJ_OPT_1005		138
;3517:#define OBJ_OPT_5000		251
;3518:#define OBJ_OPT_END			349
;3519:
;3520:ob_info_t jumpobs[] =
;3521:{
;3522:	{2.0f, 0.134f, 0},		//0
;3523:	{4.0f, 0.221f, 0},
;3524:	{8.0f, 0.250f, 0},
;3525:	{10.0f, 0.192f, 0},
;3526:	{12.0f, 0.086f, 0},
;3527:	{14.0f, -0.067f, 1},
;3528:	{19.0f, 0.184f, 0},
;3529:	{21.0f, -0.162f, 1},
;3530:	{24.0f, 0.003f, 0},
;3531:	{27.0f, -0.024f, 1},
;3532:	{30.0f, -0.243f, 1},	//10
;3533:	{31.0f, 0.075f, 0},
;3534:	{36.0f, -0.131f, 1},
;3535:	{37.0f, -0.053f, 1},
;3536:	{38.0f, -0.022f, 1},
;3537:	{39.0f, -0.040f, 1},
;3538:	{40.0f, -0.106f, 1},
;3539:	{41.0f, -0.219f, 1},
;3540:	{43.0f, 0.152f, 0},
;3541:	{44.0f, -0.154f, 1},
;3542:	{45.0f, 0.091f, 0},		//20
;3543:	{46.0f, 0.144f, 0},
;3544:	{47.0f, 0.005f, 0},
;3545:	{48.0f, -0.064f, 1},
;3546:	{48.0f, 0.150f, 0},
;3547:	{48.0f, 0.138f, 0},
;3548:	{48.0f, -0.080f, 1},
;3549:	{47.0f, -0.021f, 1},
;3550:	{46.0f, 0.112f, 0},
;3551:	{45.0f, 0.053f, 0},
;3552:	{44.0f, -0.198f, 1},	//30
;3553:	{43.0f, 0.104f, 0},
;3554:	{40.0f, -0.166f, 1},
;3555:	{39.0f, -0.104f, 1},
;3556:	{38.0f, -0.090f, 1},
;3557:	{37.0f, -0.123f, 1},
;3558:	{36.0f, -0.205f, 1},
;3559:	{31.0f, -0.011f, 1},
;3560:	{27.0f, -0.120f, 1},
;3561:	{24.0f, -0.099f, 1},
;3562:	{19.0f, 0.072f, 0},		//40
;3563:	{14.0f, -0.189f, 1},
;3564:	{12.0f, -0.038f, 1},
;3565:	{10.0f, 0.064f, 0},
;3566:	{8.0f, 0.118f, 0},
;3567:	{6.0f, 0.125f, 0},
;3568:	{4.0f, 0.083f, 0},
;3569:	{2.0f, -0.006f, 1},
;3570:	{0.0f, -0.144f, 1},		//special case
;3571:	{-7.0f, 0.155f, 0},
;3572:	{-9.0f, -0.174f, 1},	//50
;3573:	{-14.0f, 0.022f, 0},
;3574:	{-19.0f, 0.027f, 0},
;3575:	{-24.0f, -0.160f, 1},
;3576:	{-27.0f, 0.174f, 0},
;3577:	{-35.0f, -0.110f, 1},
;3578:	{-38.0f, 0.032f, 0},
;3579:	{-41.0f, 0.126f, 0},
;3580:	{-44.0f, 0.173f, 0},
;3581:	{-47.0f, 0.171f, 0},
;3582:	{-50.0f, 0.122f, 0},	//60
;3583:	{-53.0f, 0.024f, 0},
;3584:	{-56.0f, -0.122f, 1},
;3585:	{-66.0f, 0.154f, 0},
;3586:	{-69.0f, -0.184f, 1},
;3587:	{-76.0f, -0.003f, 1},
;3588:	{-83.0f, -0.014f, 1},
;3589:	{-90.0f, -0.218f, 1},
;3590:	{-94.0f, 0.109f, 0},
;3591:	{-105.0f, -0.200f, 1},
;3592:	{-109.0f, -0.066f, 1},	//70
;3593:	{-113.0f, 0.021f, 0},
;3594:	{-117.0f, 0.059f, 0},
;3595:	{-121.0f, 0.050f, 0},
;3596:	{-125.0f, -0.008f, 1},
;3597:	{-129.0f, -0.114f, 1},
;3598:	{-146.0f, -0.016f, 1},
;3599:	{-155.0f, 0.245f, 0},
;3600:	{-159.0f, -0.197f, 1},
;3601:	{-168.0f, -0.224f, 1},
;3602:	{-173.0f, 0.190f, 0},	//80
;3603:	{-182.0f, -0.125f, 1},
;3604:	{-187.0f, 0.146f, 0},
;3605:	{-211.0f, -0.222f, 1},
;3606:	{-216.0f, -0.240f, 1},
;3607:	{-237.0f, 0.210f, 0},
;3608:	{-242.0f, -0.048f, 1},
;3609:	{-258.0f, -0.109f, 1},
;3610:	{-269.0f, -0.056f, 1},
;3611:	{-280.0f, -0.195f, 1},
;3612:	{-286.0f, 0.163f, 0},	//90
;3613:	{-303.0f, -0.050f, 1},
;3614:	{-309.0f, 0.117f, 0},
;3615:	{-315.0f, 0.235f, 0},
;3616:	{-339.0f, 0.229f, 0},
;3617:	{-345.0f, 0.107f, 0},
;3618:	{-351.0f, -0.062f, 1},
;3619:	{-370.0f, 0.141f, 0},
;3620:	{-376.0f, -0.221f, 1},
;3621:	{-389.0f, -0.088f, 1},
;3622:	{-402.0f, -0.147f, 1},	//100
;3623:	{-422.0f, -0.096f, 1},
;3624:	{-429.0f, 0.158f, 0},
;3625:	{-499.0f, 0.062f, 0},
;3626:	{-506.0f, -0.211f, 1},
;3627:	{-521.0f, 0.098f, 0},
;3628:	{-536.0f, 0.214f, 0},
;3629:	{-551.0f, 0.139f, 0},
;3630:	{-566.0f, -0.128f, 1},
;3631:	{-574.0f, 0.166f, 0},
;3632:	{-597.0f, -0.238f, 1},	//110
;3633:	{-605.0f, -0.136f, 1},
;3634:	{-613.0f, -0.082f, 1},
;3635:	{-621.0f, -0.075f, 1},
;3636:	{-629.0f, -0.117f, 1},
;3637:	{-637.0f, -0.206f, 1},
;3638:	{-662.0f, 0.237f, 0},
;3639:	{-670.0f, -0.045f, 1},
;3640:	{-687.0f, 0.248f, 0},
;3641:	{-695.0f, -0.178f, 1},
;3642:	{-712.0f, -0.173f, 1},	//120
;3643:	{-738.0f, -0.026f, 1},
;3644:	{-773.0f, -0.168f, 1},
;3645:	{-782.0f, -0.074f, 1},
;3646:	{-791.0f, -0.027f, 1},
;3647:	{-800.0f, -0.029f, 1},
;3648:	{-809.0f, -0.078f, 1},
;3649:	{-818.0f, -0.176f, 1},
;3650:	{-846.0f, 0.243f, 0},
;3651:	{-855.0f, -0.046f, 1},
;3652:	{-874.0f, 0.230f, 0},	//130
;3653:	{-883.0f, -0.203f, 1},
;3654:	{-902.0f, -0.214f, 1},
;3655:	{-912.0f, 0.208f, 0},
;3656:	{-931.0f, -0.091f, 1},
;3657:	{-941.0f, 0.187f, 0},
;3658:	{-980.0f, -0.179f, 1},
;3659:	{-990.0f, -0.141f, 1},
;3660:	{-1000.0f, -0.150f, 1},
;3661:	{-1010.0f, -0.208f, 1},
;3662:	{-1051.0f, 0.081f, 0},	//140
;3663:	{-1061.0f, -0.216f, 1},
;3664:	{-1082.0f, 0.045f, 0},
;3665:	{-1103.0f, 0.113f, 0},
;3666:	{-1124.0f, -0.010f, 1},
;3667:	{-1156.0f, -0.055f, 1},
;3668:	{-1167.0f, 0.168f, 0},
;3669:	{-1255.0f, 0.219f, 0},
;3670:	{-1266.0f, 0.009f, 0},
;3671:	{-1277.0f, -0.248f, 1},
;3672:	{-1300.0f, 0.093f, 0},	//150
;3673:	{-1323.0f, 0.241f, 0},
;3674:	{-1346.0f, 0.198f, 0},
;3675:	{-1369.0f, -0.037f, 1},
;3676:	{-1404.0f, -0.250f, 1},
;3677:	{-1416.0f, -0.083f, 1},
;3678:	{-1428.0f, 0.035f, 0},
;3679:	{-1440.0f, 0.105f, 0},
;3680:	{-1452.0f, 0.128f, 0},
;3681:	{-1464.0f, 0.102f, 0},
;3682:	{-1476.0f, 0.029f, 0},	//160
;3683:	{-1488.0f, -0.093f, 1},
;3684:	{-1537.0f, -0.059f, 1},
;3685:	{-1562.0f, 0.169f, 0},
;3686:	{-1587.0f, 0.206f, 0},
;3687:	{-1612.0f, 0.051f, 0},
;3688:	{-1650.0f, -0.042f, 1},
;3689:	{-1663.0f, 0.165f, 0},
;3690:	{-1767.0f, 0.088f, 0},
;3691:	{-1780.0f, -0.138f, 1},
;3692:	{-1820.0f, -0.103f, 1},	//170
;3693:	{-1847.0f, 0.014f, 0},
;3694:	{-1874.0f, -0.061f, 1},
;3695:	{-1915.0f, -0.034f, 1},
;3696:	{-1929.0f, 0.213f, 0},
;3697:	{-2069.0f, 0.037f, 0},
;3698:	{-2083.0f, -0.245f, 1},
;3699:	{-2112.0f, 0.048f, 0},
;3700:	{-2141.0f, 0.149f, 0},
;3701:	{-2170.0f, 0.058f, 0},
;3702:	{-2199.0f, -0.226f, 1},	//180
;3703:	{-2214.0f, 0.061f, 0},
;3704:	{-2288.0f, -0.227f, 1},
;3705:	{-2303.0f, -0.229f, 1},
;3706:	{-2379.0f, 0.043f, 0},
;3707:	{-2394.0f, -0.247f, 1},
;3708:	{-2425.0f, 0.030f, 0},
;3709:	{-2456.0f, 0.115f, 0},
;3710:	{-2487.0f, 0.008f, 0},
;3711:	{-2534.0f, -0.013f, 1},
;3712:	{-2550.0f, 0.218f, 0},	//190
;3713:	{-2694.0f, 0.131f, 0},
;3714:	{-2710.0f, -0.119f, 1},
;3715:	{-2743.0f, 0.238f, 0},
;3716:	{-2759.0f, -0.156f, 1},
;3717:	{-2792.0f, -0.087f, 1},
;3718:	{-2825.0f, -0.210f, 1},
;3719:	{-2842.0f, 0.156f, 0},
;3720:	{-2892.0f, -0.032f, 1},
;3721:	{-2909.0f, 0.142f, 0},
;3722:	{-3011.0f, 0.181f, 0},	//200
;3723:	{-3028.0f, 0.019f, 0},
;3724:	{-3045.0f, -0.191f, 1},
;3725:	{-3080.0f, 0.246f, 0},
;3726:	{-3097.0f, -0.107f, 1},
;3727:	{-3132.0f, 0.041f, 0},
;3728:	{-3167.0f, -0.002f, 1},
;3729:	{-3202.0f, -0.237f, 1},
;3730:	{-3220.0f, 0.073f, 0},
;3731:	{-3291.0f, -0.165f, 1},
;3732:	{-3309.0f, -0.095f, 1},	//210
;3733:	{-3327.0f, -0.072f, 1},
;3734:	{-3345.0f, -0.098f, 1},
;3735:	{-3363.0f, -0.171f, 1},
;3736:	{-3436.0f, 0.054f, 0},
;3737:	{-3491.0f, -0.031f, 1},
;3738:	{-3528.0f, 0.006f, 0},
;3739:	{-3565.0f, -0.149f, 1},
;3740:	{-3584.0f, 0.201f, 0},
;3741:	{-3621.0f, -0.242f, 1},
;3742:	{-3640.0f, -0.036f, 1},	//220
;3743:	{-3659.0f, 0.123f, 0},
;3744:	{-3678.0f, 0.233f, 0},
;3745:	{-3754.0f, 0.195f, 0},
;3746:	{-3773.0f, 0.065f, 0},
;3747:	{-3792.0f, -0.112f, 1},
;3748:	{-3850.0f, 0.067f, 0},
;3749:	{-3908.0f, -0.186f, 1},
;3750:	{-3967.0f, 0.129f, 0},
;3751:	{-4006.0f, -0.234f, 1},
;3752:	{-4026.0f, 0.012f, 0},	//230
;3753:	{-4046.0f, 0.211f, 0},
;3754:	{-4206.0f, 0.070f, 0},
;3755:	{-4226.0f, -0.164f, 1},
;3756:	{-4267.0f, 0.225f, 0},
;3757:	{-4287.0f, -0.152f, 1},
;3758:	{-4328.0f, -0.052f, 1},
;3759:	{-4369.0f, -0.143f, 1},
;3760:	{-4390.0f, 0.239f, 0},
;3761:	{-4431.0f, -0.140f, 1},
;3762:	{-4452.0f, 0.099f, 0},	//240
;3763:	{-4641.0f, 0.084f, 0},
;3764:	{-4662.0f, -0.157f, 1},
;3765:	{-4705.0f, 0.216f, 0},
;3766:	{-4726.0f, -0.170f, 1},
;3767:	{-4769.0f, -0.085f, 1},
;3768:	{-4812.0f, -0.192f, 1},
;3769:	{-4834.0f, 0.182f, 0},
;3770:	{-4877.0f, -0.213f, 1},
;3771:	{-4899.0f, 0.017f, 0},
;3772:	{-4921.0f, 0.200f, 0},	//250
;3773:	{-5075.0f, 0.132f, 0},
;3774:	{-5097.0f, -0.069f, 1},
;3775:	{-5164.0f, 0.038f, 0},
;3776:	{-5209.0f, 0.203f, 0},
;3777:	{-5254.0f, 0.176f, 0},
;3778:	{-5299.0f, -0.043f, 1},
;3779:	{-5367.0f, -0.232f, 1},
;3780:	{-5390.0f, -0.058f, 1},
;3781:	{-5413.0f, 0.068f, 0},
;3782:	{-5436.0f, 0.147f, 0},	//260
;3783:	{-5459.0f, 0.177f, 0},
;3784:	{-5482.0f, 0.160f, 0},
;3785:	{-5505.0f, 0.094f, 0},
;3786:	{-5528.0f, -0.020f, 1},
;3787:	{-5551.0f, -0.181f, 1},
;3788:	{-5621.0f, 0.046f, 0},
;3789:	{-5691.0f, -0.159f, 1},
;3790:	{-5738.0f, -0.202f, 1},
;3791:	{-5762.0f, 0.205f, 0},
;3792:	{-5809.0f, -0.126f, 1},	//270
;3793:	{-5833.0f, 0.136f, 0},
;3794:	{-6073.0f, 0.120f, 0},
;3795:	{-6097.0f, -0.146f, 1},
;3796:	{-6146.0f, 0.179f, 0},
;3797:	{-6170.0f, -0.231f, 1},
;3798:	{-6219.0f, -0.194f, 1},
;3799:	{-6293.0f, 0.001f, 0},
;3800:	{-6367.0f, -0.235f, 1},
;3801:	{-6392.0f, -0.077f, 1},
;3802:	{-6417.0f, 0.033f, 0},	//280
;3803:	{-6442.0f, 0.096f, 0},
;3804:	{-6467.0f, 0.110f, 0},
;3805:	{-6492.0f, 0.076f, 0},
;3806:	{-6517.0f, -0.005f, 1},
;3807:	{-6542.0f, -0.135f, 1},
;3808:	{-6618.0f, 0.188f, 0},
;3809:	{-6643.0f, -0.133f, 1},
;3810:	{-6694.0f, 0.080f, 0},
;3811:	{-6745.0f, 0.100f, 0},
;3812:	{-6796.0f, -0.071f, 1},	//290
;3813:	{-6873.0f, -0.188f, 1},
;3814:	{-6899.0f, 0.011f, 0},
;3815:	{-6925.0f, 0.161f, 0},
;3816:	{-7055.0f, 0.193f, 0},
;3817:	{-7081.0f, 0.055f, 0},
;3818:	{-7107.0f,  -0.130f, 1},
;3819:	{-7186.0f, 0.025f, 0},
;3820:	{-7239.0f, 0.222f, 0},
;3821:	{-7292.0f, 0.227f, 0},
;3822:	{-7345.0f, 0.039f, 0},	//300
;3823:	{-7425.0f, -0.102f, 1},
;3824:	{-7452.0f, 0.089f, 0},
;3825:	{-7479.0f, 0.231f, 0},
;3826:	{-7614.0f, 0.223f, 0},
;3827:	{-7641.0f, 0.078f, 0},
;3828:	{-7668.0f, -0.116f, 1},
;3829:	{-7750.0f, 0.016f, 0},
;3830:	{-7805.0f, 0.196f, 0},
;3831:	{-7860.0f, 0.185f, 0},
;3832:	{-7915.0f, -0.018f, 1},	//310
;3833:	{-7998.0f, -0.183f, 1},
;3834:	{-8026.0f, -0.000f, 1},
;3835:	{-8054.0f, 0.134f, 0},
;3836:	{-8082.0f, 0.220f, 0},
;3837:	{-8138.0f, 0.249f, 0},
;3838:	{-8166.0f, 0.191f, 0},
;3839:	{-8194.0f, 0.086f, 0},
;3840:	{-8222.0f, -0.067f, 1},
;3841:	{-8307.0f, 0.184f, 0},
;3842:	{-8335.0f, -0.162f, 1},	//320
;3843:	{-8392.0f, 0.003f, 0},
;3844:	{-8449.0f, -0.024f, 1},
;3845:	{-8506.0f, -0.244f, 1},
;3846:	{-8535.0f, 0.074f, 0},
;3847:	{-8650.0f, -0.132f, 1},
;3848:	{-8679.0f, -0.054f, 1},
;3849:	{-8708.0f, -0.023f, 1},
;3850:	{-8737.0f, -0.041f, 1},
;3851:	{-8766.0f, -0.106f, 1},
;3852:	{-8795.0f, -0.220f, 1},	//330
;3853:	{-8883.0f, 0.151f, 0},
;3854:	{-8912.0f, -0.154f, 1},
;3855:	{-8971.0f, 0.091f, 0},
;3856:	{-9030.0f, 0.144f, 0},
;3857:	{-9089.0f, 0.004f, 0},
;3858:	{-9178.0f, -0.064f, 1},
;3859:	{-9208.0f, 0.150f, 0},
;3860:	{-9448.0f, 0.137f, 0},
;3861:	{-9478.0f, -0.081f, 1},
;3862:	{-9569.0f, -0.021f, 1},	//340
;3863:	{-9630.0f, 0.111f, 0},
;3864:	{-9691.0f, 0.052f, 0},
;3865:	{-9752.0f, -0.199f, 1},
;3866:	{-9783.0f, 0.104f, 0},
;3867:	{-9906.0f, -0.167f, 1},
;3868:	{-9937.0f, -0.104f, 1},
;3869:	{-9968.0f, -0.090f, 1},
;3870:	{-9999.0f, -0.123f, 1}	//348
;3871:};
;3872:
;3873:/*
;3874:=================
;3875:CG_DrawOBs
;3876:Spike's OB Detector
;3877:=================
;3878:*/
;3879:#define OB_EPSILON 1e-3
;3880:void CG_DrawOBs(int x, int y, float alpha)
;3881:{
line 3888
;3882:	vec3_t start, end;
;3883:	trace_t trace;
;3884:	float distz1, distz2, delta;
;3885:	int num_tbl, num_start, width, i;
;3886:	ob_info_t *obptr;
;3887:	char *str;
;3888:	vec4_t color = {1.0f, 1.0f, 1.0f};
ADDRLP4 96
ADDRGP4 $1887
INDIRB
ASGNB 16
line 3889
;3889:	vec3_t mins = {-15.0f, -15.0f, -24.0f};
ADDRLP4 120
ADDRGP4 $1888
INDIRB
ASGNB 12
line 3890
;3890:	vec3_t maxs = {15.0f, 15.0f, 16.0f};
ADDRLP4 132
ADDRGP4 $1889
INDIRB
ASGNB 12
line 3893
;3891:
;3892:	//check if you are standing on the ground
;3893:	if(cg.snap->ps.groundEntityNum != ENTITYNUM_NONE)
ADDRGP4 cg+36
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
CNSTI4 1023
EQI4 $1890
line 3894
;3894:	{
line 3895
;3895:		color[3] = alpha;
ADDRLP4 96+12
ADDRFP4 8
INDIRF4
ASGNF4
line 3896
;3896:		VectorCopy(cg.refdef.vieworg, start);
ADDRLP4 16
ADDRGP4 cg+109048+24
INDIRB
ASGNB 12
line 3897
;3897:		VectorMA(start, 131072, cg.refdef.viewaxis[0], end);
ADDRLP4 156
CNSTF4 1207959552
ASGNF4
ADDRLP4 28
ADDRLP4 16
INDIRF4
ADDRLP4 156
INDIRF4
ADDRGP4 cg+109048+36
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 28+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 156
INDIRF4
ADDRGP4 cg+109048+36+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 28+8
ADDRLP4 16+8
INDIRF4
CNSTF4 1207959552
ADDRGP4 cg+109048+36+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 3900
;3898:
;3899:		//trace crosshair
;3900:		trap_CM_BoxTrace(&trace, start, end, vec3_origin, vec3_origin, 0, CONTENTS_SOLID | CONTENTS_BODY | CONTENTS_PLAYERCLIP);
ADDRLP4 40
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 160
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 160
INDIRP4
ARGP4
ADDRLP4 160
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 33619969
ARGI4
ADDRGP4 trap_CM_BoxTrace
CALLV
pop
line 3903
;3901://		CG_Trace(&trace, start, vec3_origin, vec3_origin, end, cg.snap->ps.clientNum, CONTENTS_SOLID | CONTENTS_BODY);
;3902:
;3903:		if((trace.fraction != 1.0f) && (((trace.plane.normal[2] - 1.0f) > -1e-6) && ((trace.plane.normal[2] - 1.0f) < 1e-6)))
ADDRLP4 164
CNSTF4 1065353216
ASGNF4
ADDRLP4 40+8
INDIRF4
ADDRLP4 164
INDIRF4
EQF4 $1908
ADDRLP4 40+24+8
INDIRF4
ADDRLP4 164
INDIRF4
SUBF4
CNSTF4 3045472189
LEF4 $1908
ADDRLP4 40+24+8
INDIRF4
ADDRLP4 164
INDIRF4
SUBF4
CNSTF4 897988541
GEF4 $1908
line 3904
;3904:		{
line 3906
;3905:			//hit a horizontal surface with normal facing upwards
;3906:			distz2 = trace.endpos[2];
ADDRLP4 152
ADDRLP4 40+12+8
INDIRF4
ASGNF4
line 3907
;3907:		}
LABELV $1908
line 3909
;3908:
;3909:		VectorCopy(start, end);
ADDRLP4 28
ADDRLP4 16
INDIRB
ASGNB 12
line 3910
;3910:		end[2] -= 80.0f;
ADDRLP4 28+8
ADDRLP4 28+8
INDIRF4
CNSTF4 1117782016
SUBF4
ASGNF4
line 3912
;3911:		//trace directly below
;3912:		trap_CM_BoxTrace(&trace, start, end, mins, maxs, 0, CONTENTS_SOLID | CONTENTS_BODY | CONTENTS_PLAYERCLIP);
ADDRLP4 40
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 120
ARGP4
ADDRLP4 132
ARGP4
CNSTI4 0
ARGI4
CNSTI4 33619969
ARGI4
ADDRGP4 trap_CM_BoxTrace
CALLV
pop
line 3915
;3913://		CG_Trace(&trace, start, mins, maxs, end, cg.snap->ps.clientNum, CONTENTS_SOLID | CONTENTS_BODY);
;3914:
;3915:		if(trace.fraction != 1.0f)
ADDRLP4 40+8
INDIRF4
CNSTF4 1065353216
EQF4 $1918
line 3916
;3916:		{
line 3920
;3917:			//this is the surface the player is currently standing on
;3918://			distz1 = trace.plane.dist + 0.125f;
;3919://			Com_Printf("%.3f %.3f %.3f\n", trace.endpos[0], trace.endpos[1], trace.endpos[2]);
;3920:			distz1 = trace.endpos[2] - 24.0f;
ADDRLP4 144
ADDRLP4 40+12+8
INDIRF4
CNSTF4 1103101952
SUBF4
ASGNF4
line 3921
;3921:		}
LABELV $1918
line 3923
;3922:
;3923:		delta = distz2 - distz1;		//negative values are below the player
ADDRLP4 4
ADDRLP4 152
INDIRF4
ADDRLP4 144
INDIRF4
SUBF4
ASGNF4
line 3928
;3924://		num_tbl = sizeof(fallobs) / sizeof(fallobs[0]);
;3925:
;3926://Com_Printf("%.3f %.3f %.3f %.3f\n", distz1, distz2, delta, -((cg.snap->ps.origin[2] - 24.0f) - distz1));
;3927:		//check for fall ob's
;3928:		obptr = NULL;
ADDRLP4 12
CNSTP4 0
ASGNP4
line 3929
;3929:		if(delta > -10.0f)
ADDRLP4 4
INDIRF4
CNSTF4 3240099840
LEF4 $1923
line 3930
;3930:		{
line 3931
;3931:			num_tbl = OBF_OPT_10;
ADDRLP4 8
CNSTI4 8
ASGNI4
line 3932
;3932:			num_start = 0;
ADDRLP4 112
CNSTI4 0
ASGNI4
line 3933
;3933:		}
ADDRGP4 $1924
JUMPV
LABELV $1923
line 3934
;3934:		else if(delta > -100.0f)
ADDRLP4 4
INDIRF4
CNSTF4 3267887104
LEF4 $1925
line 3935
;3935:		{
line 3936
;3936:			num_tbl = OBF_OPT_100;
ADDRLP4 8
CNSTI4 24
ASGNI4
line 3937
;3937:			num_start = OBF_OPT_10;
ADDRLP4 112
CNSTI4 8
ASGNI4
line 3938
;3938:		}
ADDRGP4 $1926
JUMPV
LABELV $1925
line 3939
;3939:		else if(delta > -500.0f)
ADDRLP4 4
INDIRF4
CNSTF4 3287941120
LEF4 $1927
line 3940
;3940:		{
line 3941
;3941:			num_tbl = OBF_OPT_500;
ADDRLP4 8
CNSTI4 64
ASGNI4
line 3942
;3942:			num_start = OBF_OPT_100;
ADDRLP4 112
CNSTI4 24
ASGNI4
line 3943
;3943:		}
ADDRGP4 $1928
JUMPV
LABELV $1927
line 3944
;3944:		else if(delta > -1000.0f)
ADDRLP4 4
INDIRF4
CNSTF4 3296329728
LEF4 $1929
line 3945
;3945:		{
line 3946
;3946:			num_tbl = OBF_OPT_1000;
ADDRLP4 8
CNSTI4 90
ASGNI4
line 3947
;3947:			num_start = OBF_OPT_500;
ADDRLP4 112
CNSTI4 64
ASGNI4
line 3948
;3948:		}
ADDRGP4 $1930
JUMPV
LABELV $1929
line 3949
;3949:		else if(delta > -5000.0f)
ADDRLP4 4
INDIRF4
CNSTF4 3315351552
LEF4 $1931
line 3950
;3950:		{
line 3951
;3951:			num_tbl = OBF_OPT_5000;
ADDRLP4 8
CNSTI4 228
ASGNI4
line 3952
;3952:			num_start = OBF_OPT_1000;
ADDRLP4 112
CNSTI4 90
ASGNI4
line 3953
;3953:		}
ADDRGP4 $1932
JUMPV
LABELV $1931
line 3955
;3954:		else
;3955:		{
line 3956
;3956:			num_tbl = OBF_OPT_END;
ADDRLP4 8
CNSTI4 319
ASGNI4
line 3957
;3957:			num_start = OBF_OPT_5000;
ADDRLP4 112
CNSTI4 228
ASGNI4
line 3958
;3958:		}
LABELV $1932
LABELV $1930
LABELV $1928
LABELV $1926
LABELV $1924
line 3960
;3959:
;3960:		for(i = num_start; i < num_tbl; i++)
ADDRLP4 0
ADDRLP4 112
INDIRI4
ASGNI4
ADDRGP4 $1936
JUMPV
LABELV $1933
line 3961
;3961:		{
line 3962
;3962:			if(((delta - fallobs[i].height) > -OB_EPSILON) && ((delta - fallobs[i].height) < OB_EPSILON))
ADDRLP4 168
ADDRLP4 4
INDIRF4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 fallobs
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 168
INDIRF4
CNSTF4 3129152111
LEF4 $1937
ADDRLP4 168
INDIRF4
CNSTF4 981668463
GEF4 $1937
line 3963
;3963:			{
line 3964
;3964:				obptr = &fallobs[i];
ADDRLP4 12
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 fallobs
ADDP4
ASGNP4
line 3965
;3965:				break;
ADDRGP4 $1935
JUMPV
LABELV $1937
line 3967
;3966:			}
;3967:		}
LABELV $1934
line 3960
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1936
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $1933
LABELV $1935
line 3969
;3968:
;3969:		if(obptr)
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1939
line 3970
;3970:		{
line 3974
;3971:			float offs;
;3972:
;3973:			//found an ob height
;3974:			offs = -((cg.snap->ps.origin[2] - 24.0f) - distz1);
ADDRLP4 168
ADDRGP4 cg+36
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
CNSTF4 1103101952
SUBF4
ADDRLP4 144
INDIRF4
SUBF4
NEGF4
ASGNF4
line 3975
;3975:			if(!obptr->type && ((offs > -1e-6) && (offs < 1e-6)))
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1942
ADDRLP4 172
ADDRLP4 168
INDIRF4
ASGNF4
ADDRLP4 172
INDIRF4
CNSTF4 3045472189
LEF4 $1942
ADDRLP4 172
INDIRF4
CNSTF4 897988541
GEF4 $1942
line 3976
;3976:			{
line 3978
;3977:				//fall ob
;3978:				str = va("G");
ADDRGP4 $1944
ARGP4
ADDRLP4 176
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 116
ADDRLP4 176
INDIRP4
ASGNP4
line 3979
;3979:				width = CG_DrawStrlen(str) * TINYCHAR_WIDTH;
ADDRLP4 116
INDIRP4
ARGP4
ADDRLP4 180
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 148
ADDRLP4 180
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
line 3980
;3980:				CG_DrawStringExt(x - width, y + 2, str, color, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0, 0, 0);
ADDRFP4 0
INDIRI4
ADDRLP4 148
INDIRI4
SUBI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRLP4 116
INDIRP4
ARGP4
ADDRLP4 96
ARGP4
ADDRLP4 184
CNSTI4 0
ASGNI4
ADDRLP4 184
INDIRI4
ARGI4
ADDRLP4 184
INDIRI4
ARGI4
ADDRLP4 188
CNSTI4 8
ASGNI4
ADDRLP4 188
INDIRI4
ARGI4
ADDRLP4 188
INDIRI4
ARGI4
ADDRLP4 184
INDIRI4
ARGI4
ADDRLP4 184
INDIRI4
ARGI4
ADDRLP4 184
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3981
;3981:			}
ADDRGP4 $1943
JUMPV
LABELV $1942
line 3982
;3982:			else if((obptr->type == 1) && (offs <= obptr->offset))
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1945
ADDRLP4 168
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
GTF4 $1945
line 3983
;3983:			{
line 3985
;3984:				//fall ob (caused by sticky)
;3985:				str = va("G");
ADDRGP4 $1944
ARGP4
ADDRLP4 180
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 116
ADDRLP4 180
INDIRP4
ASGNP4
line 3986
;3986:				width = CG_DrawStrlen(str) * TINYCHAR_WIDTH;
ADDRLP4 116
INDIRP4
ARGP4
ADDRLP4 184
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 148
ADDRLP4 184
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
line 3987
;3987:				CG_DrawStringExt(x - width, y + 2, str, color, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0, 0, 0);
ADDRFP4 0
INDIRI4
ADDRLP4 148
INDIRI4
SUBI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRLP4 116
INDIRP4
ARGP4
ADDRLP4 96
ARGP4
ADDRLP4 188
CNSTI4 0
ASGNI4
ADDRLP4 188
INDIRI4
ARGI4
ADDRLP4 188
INDIRI4
ARGI4
ADDRLP4 192
CNSTI4 8
ASGNI4
ADDRLP4 192
INDIRI4
ARGI4
ADDRLP4 192
INDIRI4
ARGI4
ADDRLP4 188
INDIRI4
ARGI4
ADDRLP4 188
INDIRI4
ARGI4
ADDRLP4 188
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3988
;3988:			}
LABELV $1945
LABELV $1943
line 3990
;3989:
;3990:			if((obptr->type == 1) && (offs > obptr->offset))
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1947
ADDRLP4 168
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
LEF4 $1947
line 3991
;3991:			{
line 3993
;3992:				//potential sticky fall ob
;3993:				str = va("SG");
ADDRGP4 $1949
ARGP4
ADDRLP4 184
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 116
ADDRLP4 184
INDIRP4
ASGNP4
line 3994
;3994:				width = CG_DrawStrlen(str) * TINYCHAR_WIDTH;
ADDRLP4 116
INDIRP4
ARGP4
ADDRLP4 188
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 148
ADDRLP4 188
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
line 3995
;3995:				CG_DrawStringExt(x - width + (TINYCHAR_WIDTH * 2), y + 2, str, color, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0, 0, 0);
ADDRFP4 0
INDIRI4
ADDRLP4 148
INDIRI4
SUBI4
CNSTI4 16
ADDI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRLP4 116
INDIRP4
ARGP4
ADDRLP4 96
ARGP4
ADDRLP4 192
CNSTI4 0
ASGNI4
ADDRLP4 192
INDIRI4
ARGI4
ADDRLP4 192
INDIRI4
ARGI4
ADDRLP4 196
CNSTI4 8
ASGNI4
ADDRLP4 196
INDIRI4
ARGI4
ADDRLP4 196
INDIRI4
ARGI4
ADDRLP4 192
INDIRI4
ARGI4
ADDRLP4 192
INDIRI4
ARGI4
ADDRLP4 192
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 3996
;3996:			}
LABELV $1947
line 3997
;3997:		}
LABELV $1939
line 3999
;3998:
;3999:		num_tbl = sizeof(jumpobs) / sizeof(jumpobs[0]);
ADDRLP4 8
CNSTI4 349
ASGNI4
line 4002
;4000:
;4001:		//check for jump ob's
;4002:		obptr = NULL;
ADDRLP4 12
CNSTP4 0
ASGNP4
line 4003
;4003:		if(delta > -5.0f)
ADDRLP4 4
INDIRF4
CNSTF4 3231711232
LEF4 $1950
line 4004
;4004:		{
line 4005
;4005:			num_tbl = OBJ_OPT_5;
ADDRLP4 8
CNSTI4 49
ASGNI4
line 4006
;4006:			num_start = 0;
ADDRLP4 112
CNSTI4 0
ASGNI4
line 4007
;4007:		}
ADDRGP4 $1951
JUMPV
LABELV $1950
line 4008
;4008:		else if(delta > -30.0f)
ADDRLP4 4
INDIRF4
CNSTF4 3253731328
LEF4 $1952
line 4009
;4009:		{
line 4010
;4010:			num_tbl = OBJ_OPT_30;
ADDRLP4 8
CNSTI4 55
ASGNI4
line 4011
;4011:			num_start = OBJ_OPT_5;
ADDRLP4 112
CNSTI4 49
ASGNI4
line 4012
;4012:		}
ADDRGP4 $1953
JUMPV
LABELV $1952
line 4013
;4013:		else if(delta > -100.0f)
ADDRLP4 4
INDIRF4
CNSTF4 3267887104
LEF4 $1954
line 4014
;4014:		{
line 4015
;4015:			num_tbl = OBJ_OPT_100;
ADDRLP4 8
CNSTI4 69
ASGNI4
line 4016
;4016:			num_start = OBJ_OPT_30;
ADDRLP4 112
CNSTI4 55
ASGNI4
line 4017
;4017:		}
ADDRGP4 $1955
JUMPV
LABELV $1954
line 4018
;4018:		else if(delta > -500.0f)
ADDRLP4 4
INDIRF4
CNSTF4 3287941120
LEF4 $1956
line 4019
;4019:		{
line 4020
;4020:			num_tbl = OBJ_OPT_500;
ADDRLP4 8
CNSTI4 104
ASGNI4
line 4021
;4021:			num_start = OBJ_OPT_100;
ADDRLP4 112
CNSTI4 69
ASGNI4
line 4022
;4022:		}
ADDRGP4 $1957
JUMPV
LABELV $1956
line 4023
;4023:		else if(delta > -1005.0f)
ADDRLP4 4
INDIRF4
CNSTF4 3296411648
LEF4 $1958
line 4024
;4024:		{
line 4025
;4025:			num_tbl = OBJ_OPT_1005;
ADDRLP4 8
CNSTI4 138
ASGNI4
line 4026
;4026:			num_start = OBJ_OPT_500;
ADDRLP4 112
CNSTI4 104
ASGNI4
line 4027
;4027:		}
ADDRGP4 $1959
JUMPV
LABELV $1958
line 4028
;4028:		else if(delta > -5000.0f)
ADDRLP4 4
INDIRF4
CNSTF4 3315351552
LEF4 $1960
line 4029
;4029:		{
line 4030
;4030:			num_tbl = OBJ_OPT_5000;
ADDRLP4 8
CNSTI4 251
ASGNI4
line 4031
;4031:			num_start = OBJ_OPT_1005;
ADDRLP4 112
CNSTI4 138
ASGNI4
line 4032
;4032:		}
ADDRGP4 $1961
JUMPV
LABELV $1960
line 4034
;4033:		else
;4034:		{
line 4035
;4035:			num_tbl = OBJ_OPT_END;
ADDRLP4 8
CNSTI4 349
ASGNI4
line 4036
;4036:			num_start = OBJ_OPT_5000;
ADDRLP4 112
CNSTI4 251
ASGNI4
line 4037
;4037:		}
LABELV $1961
LABELV $1959
LABELV $1957
LABELV $1955
LABELV $1953
LABELV $1951
line 4039
;4038:
;4039:		for(i = num_start; i < num_tbl; i++)
ADDRLP4 0
ADDRLP4 112
INDIRI4
ASGNI4
ADDRGP4 $1965
JUMPV
LABELV $1962
line 4040
;4040:		{
line 4041
;4041:			if(((delta - jumpobs[i].height) > -OB_EPSILON) && ((delta - jumpobs[i].height) < OB_EPSILON))
ADDRLP4 168
ADDRLP4 4
INDIRF4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 jumpobs
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 168
INDIRF4
CNSTF4 3129152111
LEF4 $1966
ADDRLP4 168
INDIRF4
CNSTF4 981668463
GEF4 $1966
line 4042
;4042:			{
line 4043
;4043:				obptr = &jumpobs[i];
ADDRLP4 12
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 jumpobs
ADDP4
ASGNP4
line 4044
;4044:				break;
ADDRGP4 $1964
JUMPV
LABELV $1966
line 4046
;4045:			}
;4046:		}
LABELV $1963
line 4039
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1965
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $1962
LABELV $1964
line 4048
;4047:
;4048:		if(obptr)
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1968
line 4049
;4049:		{
line 4053
;4050:			float offs;
;4051:
;4052:			//found an ob height
;4053:			offs = -((cg.snap->ps.origin[2] - 24.0f) - distz1);
ADDRLP4 168
ADDRGP4 cg+36
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
CNSTF4 1103101952
SUBF4
ADDRLP4 144
INDIRF4
SUBF4
NEGF4
ASGNF4
line 4054
;4054:			if(!obptr->type && ((offs > -1e-6) && (offs < 1e-6)))
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1971
ADDRLP4 172
ADDRLP4 168
INDIRF4
ASGNF4
ADDRLP4 172
INDIRF4
CNSTF4 3045472189
LEF4 $1971
ADDRLP4 172
INDIRF4
CNSTF4 897988541
GEF4 $1971
line 4055
;4055:			{
line 4057
;4056:				//jump ob
;4057:				str = va("J");
ADDRGP4 $1973
ARGP4
ADDRLP4 176
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 116
ADDRLP4 176
INDIRP4
ASGNP4
line 4058
;4058:				width = CG_DrawStrlen(str) * TINYCHAR_WIDTH;
ADDRLP4 116
INDIRP4
ARGP4
ADDRLP4 180
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 148
ADDRLP4 180
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
line 4059
;4059:				CG_DrawStringExt(x - width + (TINYCHAR_WIDTH * 6), y + 2, str, color, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0, 0, 0);
ADDRFP4 0
INDIRI4
ADDRLP4 148
INDIRI4
SUBI4
CNSTI4 48
ADDI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRLP4 116
INDIRP4
ARGP4
ADDRLP4 96
ARGP4
ADDRLP4 184
CNSTI4 0
ASGNI4
ADDRLP4 184
INDIRI4
ARGI4
ADDRLP4 184
INDIRI4
ARGI4
ADDRLP4 188
CNSTI4 8
ASGNI4
ADDRLP4 188
INDIRI4
ARGI4
ADDRLP4 188
INDIRI4
ARGI4
ADDRLP4 184
INDIRI4
ARGI4
ADDRLP4 184
INDIRI4
ARGI4
ADDRLP4 184
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 4060
;4060:			}
ADDRGP4 $1972
JUMPV
LABELV $1971
line 4061
;4061:			else if((obptr->type == 1) && (offs <= obptr->offset))
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1974
ADDRLP4 168
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
GTF4 $1974
line 4062
;4062:			{
line 4064
;4063:				//jump ob (caused by sticky)
;4064:				str = va("J");
ADDRGP4 $1973
ARGP4
ADDRLP4 180
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 116
ADDRLP4 180
INDIRP4
ASGNP4
line 4065
;4065:				width = CG_DrawStrlen(str) * TINYCHAR_WIDTH;
ADDRLP4 116
INDIRP4
ARGP4
ADDRLP4 184
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 148
ADDRLP4 184
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
line 4066
;4066:				CG_DrawStringExt(x - width + (TINYCHAR_WIDTH * 6), y + 2, str, color, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0, 0, 0);
ADDRFP4 0
INDIRI4
ADDRLP4 148
INDIRI4
SUBI4
CNSTI4 48
ADDI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRLP4 116
INDIRP4
ARGP4
ADDRLP4 96
ARGP4
ADDRLP4 188
CNSTI4 0
ASGNI4
ADDRLP4 188
INDIRI4
ARGI4
ADDRLP4 188
INDIRI4
ARGI4
ADDRLP4 192
CNSTI4 8
ASGNI4
ADDRLP4 192
INDIRI4
ARGI4
ADDRLP4 192
INDIRI4
ARGI4
ADDRLP4 188
INDIRI4
ARGI4
ADDRLP4 188
INDIRI4
ARGI4
ADDRLP4 188
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 4067
;4067:			}
LABELV $1974
LABELV $1972
line 4069
;4068:
;4069:			if((obptr->type == 1) && (offs > obptr->offset) && (obptr->height != 0.0f))
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1976
ADDRLP4 168
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
LEF4 $1976
ADDRLP4 12
INDIRP4
INDIRF4
CNSTF4 0
EQF4 $1976
line 4070
;4070:			{
line 4072
;4071:				//potential sticky jump ob
;4072:				str = va("SJ");
ADDRGP4 $1978
ARGP4
ADDRLP4 184
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 116
ADDRLP4 184
INDIRP4
ASGNP4
line 4073
;4073:				width = CG_DrawStrlen(str) * TINYCHAR_WIDTH;
ADDRLP4 116
INDIRP4
ARGP4
ADDRLP4 188
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 148
ADDRLP4 188
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
line 4074
;4074:				CG_DrawStringExt(x - width + (TINYCHAR_WIDTH * 8), y + 2, str, color, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0, 0, 0);
ADDRFP4 0
INDIRI4
ADDRLP4 148
INDIRI4
SUBI4
CNSTI4 64
ADDI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRLP4 116
INDIRP4
ARGP4
ADDRLP4 96
ARGP4
ADDRLP4 192
CNSTI4 0
ASGNI4
ADDRLP4 192
INDIRI4
ARGI4
ADDRLP4 192
INDIRI4
ARGI4
ADDRLP4 196
CNSTI4 8
ASGNI4
ADDRLP4 196
INDIRI4
ARGI4
ADDRLP4 196
INDIRI4
ARGI4
ADDRLP4 192
INDIRI4
ARGI4
ADDRLP4 192
INDIRI4
ARGI4
ADDRLP4 192
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 4075
;4075:			}
LABELV $1976
line 4076
;4076:		}
LABELV $1968
line 4077
;4077:	}
LABELV $1890
line 4078
;4078:}
LABELV $1886
endproc CG_DrawOBs 200 44
export CG_DrawWeaponSideBar
proc CG_DrawWeaponSideBar 128 44
line 4085
;4079:
;4080:/*
;4081:=================
;4082:CG_DrawWeaponSideBar
;4083:=================
;4084:*/
;4085:void CG_DrawWeaponSideBar( qboolean draw_sidebar, char *bgColor, char *fontColor, char *selectedBGColor, char *selectedFontColor ) {
line 4088
;4086:	int		y;
;4087:	int		i;
;4088:	int		totalWeapons = 0, numWepsPerRow, remainingWeps = 0;
ADDRLP4 72
CNSTI4 0
ASGNI4
ADDRLP4 76
CNSTI4 0
ASGNI4
line 4095
;4089:	vec4_t	vbgColor, vfontColor, vs_bgColor, vs_fontColor;
;4090:
;4091:	/*if (!draw_sidebar && !superhud) {
;4092:		return;
;4093:	}*/
;4094:
;4095:	numWepsPerRow = 0;
ADDRLP4 80
CNSTI4 0
ASGNI4
line 4096
;4096:	for ( i = WP_NONE; i < WP_NUM_WEAPONS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1980
line 4097
;4097:		if ( cg.snap->ps.stats[ STAT_WEAPONS ] & ( 1 << i ) ) {
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
EQI4 $1984
line 4098
;4098:			totalWeapons++;
ADDRLP4 72
ADDRLP4 72
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4099
;4099:		}
LABELV $1984
line 4100
;4100:	}
LABELV $1981
line 4096
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 11
LTI4 $1980
line 4101
;4101:	remainingWeps = totalWeapons;
ADDRLP4 76
ADDRLP4 72
INDIRI4
ASGNI4
line 4104
;4102:
;4103:
;4104:	i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 4106
;4105:	//totalSpaceNeeded = ( (totalWeapons * 16) + (spacing * (totalWeapons - 1)) );
;4106:	y = ( (480 - (totalWeapons * 16) + (4 * (totalWeapons - 1))) * .3);
ADDRLP4 88
CNSTI4 4
ASGNI4
ADDRLP4 4
CNSTF4 1050253722
CNSTI4 480
ADDRLP4 72
INDIRI4
ADDRLP4 88
INDIRI4
LSHI4
SUBI4
ADDRLP4 72
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 88
INDIRI4
SUBI4
ADDI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 4108
;4107:
;4108:	for ( i = 0; i < 4; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1987
line 4109
;4109:		vbgColor[i] = g_color_table[ColorIndex(bgColor[0])][i];
ADDRFP4 4
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 92
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 96
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 96
INDIRI4
ADDRLP4 8
ADDP4
ADDRLP4 96
INDIRI4
ADDRLP4 92
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ADDP4
INDIRF4
ASGNF4
line 4110
;4110:		vfontColor[i] = g_color_table[ColorIndex(fontColor[0])][i];
ADDRFP4 8
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 100
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 104
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 104
INDIRI4
ADDRLP4 40
ADDP4
ADDRLP4 104
INDIRI4
ADDRLP4 100
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ADDP4
INDIRF4
ASGNF4
line 4111
;4111:		vs_bgColor[i] = g_color_table[ColorIndex(selectedBGColor[0])][i];
ADDRFP4 12
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 108
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 112
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 112
INDIRI4
ADDRLP4 24
ADDP4
ADDRLP4 112
INDIRI4
ADDRLP4 108
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ADDP4
INDIRF4
ASGNF4
line 4112
;4112:		vs_fontColor[i] = g_color_table[ColorIndex(selectedFontColor[0])][i];
ADDRFP4 16
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 116
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 120
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 120
INDIRI4
ADDRLP4 56
ADDP4
ADDRLP4 120
INDIRI4
ADDRLP4 116
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ADDP4
INDIRF4
ASGNF4
line 4113
;4113:	}
LABELV $1988
line 4108
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $1987
line 4114
;4114:	i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 4115
;4115:	vbgColor[3] = 0.25;
ADDRLP4 8+12
CNSTF4 1048576000
ASGNF4
line 4116
;4116:	vs_bgColor[3] = 0.25;
ADDRLP4 24+12
CNSTF4 1048576000
ASGNF4
line 4120
;4117:	//If we have the weapon, draw the icon and a background box
;4118:	//then space it out for the next one
;4119:	//If we have no ammo for the gun, then draw the no ammo shader over the icon
;4120:	for ( i = WP_NONE; i < WP_NUM_WEAPONS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1993
line 4121
;4121:		if ( cg.snap->ps.stats[ STAT_WEAPONS ] & ( 1 << i ) ) {
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
EQI4 $1997
line 4123
;4122:			char	ammo[24];
;4123:			if ( i != cg.weaponSelect ) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+108944
INDIRI4
EQI4 $2000
line 4125
;4124:				//Not the weapon selected or holding
;4125:				CG_FillRect(0, (float)y, 44, 16, vbgColor);
CNSTF4 0
ARGF4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1110441984
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 8
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 4126
;4126:				CG_DrawPic( 2, (float)y, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, cg_weapons[i].weaponIcon );
CNSTF4 1073741824
ARGF4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 116
CNSTF4 1098907648
ASGNF4
ADDRLP4 116
INDIRF4
ARGF4
ADDRLP4 116
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
line 4127
;4127:				if ( !cg.snap->ps.ammo[ i ] ) {
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
NEI4 $2004
line 4128
;4128:					CG_DrawPic( 2, (float)y, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, cgs.media.noammoShader );
CNSTF4 1073741824
ARGF4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 120
CNSTF4 1098907648
ASGNF4
ADDRLP4 120
INDIRF4
ARGF4
ADDRLP4 120
INDIRF4
ARGF4
ADDRGP4 cgs+156680+328
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 4129
;4129:				}
LABELV $2004
line 4130
;4130:				if ( cg.snap->ps.ammo[i] < 1 ) {
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
CNSTI4 1
GEI4 $2009
line 4131
;4131:					Com_sprintf( ammo, 24, "0");
ADDRLP4 92
ARGP4
CNSTI4 24
ARGI4
ADDRGP4 $2012
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 4132
;4132:				} else {
ADDRGP4 $2010
JUMPV
LABELV $2009
line 4133
;4133:					Com_sprintf(ammo, 24, "%i", cg.snap->ps.ammo[i]);
ADDRLP4 92
ARGP4
CNSTI4 24
ARGI4
ADDRGP4 $160
ARGP4
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
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 4134
;4134:				}
LABELV $2010
line 4135
;4135:				CG_DrawStringExt( 19, y + 3, ammo, vfontColor, qfalse, qtrue, 8, 10, 3, 0, 0);
CNSTI4 19
ARGI4
ADDRLP4 120
CNSTI4 3
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 120
INDIRI4
ADDI4
ARGI4
ADDRLP4 92
ARGP4
ADDRLP4 40
ARGP4
ADDRLP4 124
CNSTI4 0
ASGNI4
ADDRLP4 124
INDIRI4
ARGI4
CNSTI4 1
ARGI4
CNSTI4 8
ARGI4
CNSTI4 10
ARGI4
ADDRLP4 120
INDIRI4
ARGI4
ADDRLP4 124
INDIRI4
ARGI4
ADDRLP4 124
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 4136
;4136:				y += (16 + 4);
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 20
ADDI4
ASGNI4
line 4137
;4137:			} else {
ADDRGP4 $2001
JUMPV
LABELV $2000
line 4139
;4138:				//The weapon selected or holding
;4139:				CG_FillRect(0, (float)y, 44, 16, vs_bgColor);
CNSTF4 0
ARGF4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1110441984
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 24
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 4140
;4140:				CG_DrawPic( 2, (float)y, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, cg_weapons[i].weaponIcon );
CNSTF4 1073741824
ARGF4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 116
CNSTF4 1098907648
ASGNF4
ADDRLP4 116
INDIRF4
ARGF4
ADDRLP4 116
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
line 4141
;4141:				if ( !cg.snap->ps.ammo[ i ] ) {
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
NEI4 $2015
line 4142
;4142:					CG_DrawPic( 2, (float)y, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, cgs.media.noammoShader );
CNSTF4 1073741824
ARGF4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 120
CNSTF4 1098907648
ASGNF4
ADDRLP4 120
INDIRF4
ARGF4
ADDRLP4 120
INDIRF4
ARGF4
ADDRGP4 cgs+156680+328
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 4143
;4143:				}
LABELV $2015
line 4145
;4144:
;4145:				if ( cg.snap->ps.ammo[i] < 1 ) {//Gauntlet would print -1.. do this as a sanity check.
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
CNSTI4 1
GEI4 $2020
line 4146
;4146:					Com_sprintf( ammo, 24, "0");
ADDRLP4 92
ARGP4
CNSTI4 24
ARGI4
ADDRGP4 $2012
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 4147
;4147:				} else if ( cg.snap->ps.ammo[i] > 999 ) {//Instagib would print 169, no need for it anyway.
ADDRGP4 $2021
JUMPV
LABELV $2020
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
CNSTI4 999
LEI4 $2023
line 4148
;4148:					Com_sprintf(ammo, 24, "999");
ADDRLP4 92
ARGP4
CNSTI4 24
ARGI4
ADDRGP4 $2026
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 4149
;4149:				} else {
ADDRGP4 $2024
JUMPV
LABELV $2023
line 4150
;4150:					Com_sprintf(ammo, 24, "%i", cg.snap->ps.ammo[i]);
ADDRLP4 92
ARGP4
CNSTI4 24
ARGI4
ADDRGP4 $160
ARGP4
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
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 4151
;4151:				}
LABELV $2024
LABELV $2021
line 4152
;4152:				CG_DrawStringExt( 19, y + 3, ammo, vs_fontColor, qfalse, qtrue, 8, 10, 3, 0, 0);
CNSTI4 19
ARGI4
ADDRLP4 120
CNSTI4 3
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 120
INDIRI4
ADDI4
ARGI4
ADDRLP4 92
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 124
CNSTI4 0
ASGNI4
ADDRLP4 124
INDIRI4
ARGI4
CNSTI4 1
ARGI4
CNSTI4 8
ARGI4
CNSTI4 10
ARGI4
ADDRLP4 120
INDIRI4
ARGI4
ADDRLP4 124
INDIRI4
ARGI4
ADDRLP4 124
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 4154
;4153:
;4154:				y += (16 + 4);
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 20
ADDI4
ASGNI4
line 4156
;4155:
;4156:			}
LABELV $2001
line 4157
;4157:		}
LABELV $1997
line 4158
;4158:	}
LABELV $1994
line 4120
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 11
LTI4 $1993
line 4159
;4159:}
LABELV $1979
endproc CG_DrawWeaponSideBar 128 44
export CG_DrawKeyPress
proc CG_DrawKeyPress 64 44
line 4165
;4160:/*
;4161:================
;4162:CG_DrawKeyPress
;4163:================
;4164:*/
;4165:void CG_DrawKeyPress( qboolean draw_keys, int x, int y, char *keyColor, char *fontColor, int size ) {
line 4174
;4166:	//int		x, y;
;4167:	int			i;
;4168:	vec4_t		keys, font;
;4169:
;4170:	/*if ( !draw_keys ) {
;4171:		return;
;4172:	}*/
;4173:
;4174:	for ( i = 0; i < 4; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2029
line 4175
;4175:		keys[i] = g_color_table[ColorIndex(keyColor[0])][i];
ADDRFP4 12
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 36
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 40
INDIRI4
ADDRLP4 4
ADDP4
ADDRLP4 40
INDIRI4
ADDRLP4 36
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ADDP4
INDIRF4
ASGNF4
line 4176
;4176:		font[i] = g_color_table[ColorIndex(fontColor[0])][i];
ADDRFP4 16
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 44
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 48
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 48
INDIRI4
ADDRLP4 20
ADDP4
ADDRLP4 48
INDIRI4
ADDRLP4 44
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ADDP4
INDIRF4
ASGNF4
line 4178
;4177:
;4178:	}
LABELV $2030
line 4174
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2029
line 4180
;4179:
;4180:	if ( cg.snap->ps.pm_flags & PMF_FORWARD_KEY_PRESSED ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $2033
line 4182
;4181:		//Forward
;4182:		CG_FillRect((float)(x - ( size / 4 )), (float)(y - ( size / 4 )), (size + (size / 2 )), (size + (size / 2 )), keys);
ADDRLP4 36
ADDRFP4 20
INDIRI4
ASGNI4
ADDRLP4 40
ADDRLP4 36
INDIRI4
CNSTI4 4
DIVI4
ASGNI4
ADDRFP4 4
INDIRI4
ADDRLP4 40
INDIRI4
SUBI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRI4
ADDRLP4 40
INDIRI4
SUBI4
CVIF4 4
ARGF4
ADDRLP4 44
ADDRLP4 36
INDIRI4
ADDRLP4 36
INDIRI4
CNSTI4 2
DIVI4
ADDI4
CVIF4 4
ASGNF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 4183
;4183:		CG_DrawStringExt( x, y, "F", font, qfalse, qfalse, size, size, (size + (size / 2 )), 0, 0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 $2036
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 48
CNSTI4 0
ASGNI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 52
ADDRFP4 20
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 52
INDIRI4
ADDRLP4 52
INDIRI4
CNSTI4 2
DIVI4
ADDI4
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 4185
;4184:		//CG_Printf("DBG: ViewKeys: Drawing F\n");
;4185:	}
LABELV $2033
line 4186
;4186:	if ( cg.snap->ps.pm_flags & PMF_BACKWARD_KEY_PRESSED ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $2037
line 4188
;4187:		//Backward
;4188:		CG_FillRect((float)(x - ( size / 4 )), (float)(y + (size + size)), (size + (size / 2 )), (size + (size / 2 )), keys);
ADDRLP4 36
ADDRFP4 20
INDIRI4
ASGNI4
ADDRFP4 4
INDIRI4
ADDRLP4 36
INDIRI4
CNSTI4 4
DIVI4
SUBI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRI4
ADDRLP4 36
INDIRI4
ADDRLP4 36
INDIRI4
ADDI4
ADDI4
CVIF4 4
ARGF4
ADDRLP4 40
ADDRLP4 36
INDIRI4
ADDRLP4 36
INDIRI4
CNSTI4 2
DIVI4
ADDI4
CVIF4 4
ASGNF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 4189
;4189:		CG_DrawStringExt( x, y + ((size + size) + ( size / 4 )), "B", font, qfalse, qfalse, size, size, (size + (size / 2 )), 0, 0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 44
ADDRFP4 20
INDIRI4
ASGNI4
ADDRFP4 8
INDIRI4
ADDRLP4 44
INDIRI4
ADDRLP4 44
INDIRI4
ADDI4
ADDRLP4 44
INDIRI4
CNSTI4 4
DIVI4
ADDI4
ADDI4
ARGI4
ADDRGP4 $2040
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 48
CNSTI4 0
ASGNI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 44
INDIRI4
ADDRLP4 44
INDIRI4
CNSTI4 2
DIVI4
ADDI4
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 4191
;4190:		//CG_Printf("DBG: ViewKeys: Drawing B\n");
;4191:	}
LABELV $2037
line 4193
;4192:		
;4193:	if ( cg.snap->ps.pm_flags & PMF_MOVE_RIGHT_KEY_PRESSED ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $2041
line 4195
;4194:		//Right
;4195:		CG_FillRect((float)(x + (size + size)), (float)(y + (size + size)), (size + (size / 2 )), (size + (size / 2 )), keys);
ADDRLP4 36
ADDRFP4 20
INDIRI4
ASGNI4
ADDRLP4 40
ADDRLP4 36
INDIRI4
ADDRLP4 36
INDIRI4
ADDI4
ASGNI4
ADDRFP4 4
INDIRI4
ADDRLP4 40
INDIRI4
ADDI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRI4
ADDRLP4 40
INDIRI4
ADDI4
CVIF4 4
ARGF4
ADDRLP4 44
ADDRLP4 36
INDIRI4
ADDRLP4 36
INDIRI4
CNSTI4 2
DIVI4
ADDI4
CVIF4 4
ASGNF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 4196
;4196:		CG_DrawStringExt( x + ((size + size) + ( size / 4 )), y + ((size + size) + ( size / 4 )), "R", font, qfalse, qfalse, size, size, (size + (size / 2 )), 0, 0 );
ADDRLP4 48
ADDRFP4 20
INDIRI4
ASGNI4
ADDRLP4 52
ADDRLP4 48
INDIRI4
ADDRLP4 48
INDIRI4
ADDI4
ADDRLP4 48
INDIRI4
CNSTI4 4
DIVI4
ADDI4
ASGNI4
ADDRFP4 4
INDIRI4
ADDRLP4 52
INDIRI4
ADDI4
ARGI4
ADDRFP4 8
INDIRI4
ADDRLP4 52
INDIRI4
ADDI4
ARGI4
ADDRGP4 $2044
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 56
CNSTI4 0
ASGNI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 48
INDIRI4
ADDRLP4 48
INDIRI4
CNSTI4 2
DIVI4
ADDI4
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 4198
;4197:		//CG_Printf("DBG: ViewKeys: Drawing R\n");
;4198:	}
LABELV $2041
line 4200
;4199:		
;4200:	if ( cg.snap->ps.eFlags & EF_MOVE_LEFT_KEY_PRESSED ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $2045
line 4202
;4201:		//Left
;4202:		CG_FillRect((float)(x - ((size + size) + ( size / 4 ))), (float)(y + (size + size) ), (size + (size / 2 )), (size + (size / 2 )), keys);
ADDRLP4 36
ADDRFP4 20
INDIRI4
ASGNI4
ADDRLP4 40
ADDRLP4 36
INDIRI4
ADDRLP4 36
INDIRI4
ADDI4
ASGNI4
ADDRFP4 4
INDIRI4
ADDRLP4 40
INDIRI4
ADDRLP4 36
INDIRI4
CNSTI4 4
DIVI4
ADDI4
SUBI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRI4
ADDRLP4 40
INDIRI4
ADDI4
CVIF4 4
ARGF4
ADDRLP4 44
ADDRLP4 36
INDIRI4
ADDRLP4 36
INDIRI4
CNSTI4 2
DIVI4
ADDI4
CVIF4 4
ASGNF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 4203
;4203:		CG_DrawStringExt( x - ((size + size) + ( size / 4 )), y + ((size + size) + ( size / 4 )), "L", font, qfalse, qfalse, size, size, (size + (size / 2 )), 0, 0 );
ADDRLP4 48
ADDRFP4 20
INDIRI4
ASGNI4
ADDRLP4 52
ADDRLP4 48
INDIRI4
ADDRLP4 48
INDIRI4
ADDI4
ADDRLP4 48
INDIRI4
CNSTI4 4
DIVI4
ADDI4
ASGNI4
ADDRFP4 4
INDIRI4
ADDRLP4 52
INDIRI4
SUBI4
ARGI4
ADDRFP4 8
INDIRI4
ADDRLP4 52
INDIRI4
ADDI4
ARGI4
ADDRGP4 $2048
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 56
CNSTI4 0
ASGNI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 48
INDIRI4
ADDRLP4 48
INDIRI4
CNSTI4 2
DIVI4
ADDI4
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 4205
;4204:		//CG_Printf("DBG: ViewKeys: Drawing L\n");
;4205:	}
LABELV $2045
line 4207
;4206:
;4207:	if ( cg.predictedPlayerState.viewheight == CROUCH_VIEWHEIGHT ) {
ADDRGP4 cg+107636+164
INDIRI4
CNSTI4 12
NEI4 $2049
line 4209
;4208:		//Crouch
;4209:		CG_FillRect((float)(x - ((size + (size / 2 )) * 5)), (float)(y + ((size * 4) - ( size / 4))), ((size + (size / 2 )) * 4), (size + (size / 2 )), keys);
ADDRLP4 36
ADDRFP4 20
INDIRI4
ASGNI4
ADDRLP4 40
CNSTI4 2
ASGNI4
ADDRLP4 44
ADDRLP4 36
INDIRI4
ADDRLP4 36
INDIRI4
ADDRLP4 40
INDIRI4
DIVI4
ADDI4
ASGNI4
ADDRFP4 4
INDIRI4
CNSTI4 5
ADDRLP4 44
INDIRI4
MULI4
SUBI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRI4
ADDRLP4 36
INDIRI4
ADDRLP4 40
INDIRI4
LSHI4
ADDRLP4 36
INDIRI4
CNSTI4 4
DIVI4
SUBI4
ADDI4
CVIF4 4
ARGF4
ADDRLP4 44
INDIRI4
ADDRLP4 40
INDIRI4
LSHI4
CVIF4 4
ARGF4
ADDRLP4 44
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 4210
;4210:		CG_DrawStringExt( x - ((size + (size / 2 )) * 5), y + (size * 4), "Crouch", font, qfalse, qfalse, size, size, (size + (size / 2 )), 0, 0 );
ADDRLP4 48
ADDRFP4 20
INDIRI4
ASGNI4
ADDRLP4 52
CNSTI4 2
ASGNI4
ADDRLP4 56
ADDRLP4 48
INDIRI4
ADDRLP4 48
INDIRI4
ADDRLP4 52
INDIRI4
DIVI4
ADDI4
ASGNI4
ADDRFP4 4
INDIRI4
CNSTI4 5
ADDRLP4 56
INDIRI4
MULI4
SUBI4
ARGI4
ADDRFP4 8
INDIRI4
ADDRLP4 48
INDIRI4
ADDRLP4 52
INDIRI4
LSHI4
ADDI4
ARGI4
ADDRGP4 $2053
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 4211
;4211:	}
LABELV $2049
line 4213
;4212:
;4213:	if ( cg.snap->ps.movementDir > 7 ) { //This method is more reliable
ADDRGP4 cg+36
INDIRP4
CNSTI4 132
ADDP4
INDIRI4
CNSTI4 7
LEI4 $2054
line 4215
;4214:		//Jump
;4215:		CG_FillRect((float)(x - ((size + size) + ( size / 4 ))), (float)(y + ((size * 4) - ( size / 4))), ((size + (size / 2 )) * 4), (size + (size / 2 )), keys);
ADDRLP4 36
ADDRFP4 20
INDIRI4
ASGNI4
ADDRLP4 40
ADDRLP4 36
INDIRI4
CNSTI4 4
DIVI4
ASGNI4
ADDRFP4 4
INDIRI4
ADDRLP4 36
INDIRI4
ADDRLP4 36
INDIRI4
ADDI4
ADDRLP4 40
INDIRI4
ADDI4
SUBI4
CVIF4 4
ARGF4
ADDRLP4 44
CNSTI4 2
ASGNI4
ADDRFP4 8
INDIRI4
ADDRLP4 36
INDIRI4
ADDRLP4 44
INDIRI4
LSHI4
ADDRLP4 40
INDIRI4
SUBI4
ADDI4
CVIF4 4
ARGF4
ADDRLP4 48
ADDRLP4 36
INDIRI4
ADDRLP4 36
INDIRI4
ADDRLP4 44
INDIRI4
DIVI4
ADDI4
ASGNI4
ADDRLP4 48
INDIRI4
ADDRLP4 44
INDIRI4
LSHI4
CVIF4 4
ARGF4
ADDRLP4 48
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 4216
;4216:		CG_DrawStringExt( x - (size + (size / 4)), y + (size * 4), "Jump", font, qfalse, qfalse, size, size, (size + (size / 2 )), 0, 0 );
ADDRLP4 52
ADDRFP4 20
INDIRI4
ASGNI4
ADDRFP4 4
INDIRI4
ADDRLP4 52
INDIRI4
ADDRLP4 52
INDIRI4
CNSTI4 4
DIVI4
ADDI4
SUBI4
ARGI4
ADDRLP4 56
CNSTI4 2
ASGNI4
ADDRFP4 8
INDIRI4
ADDRLP4 52
INDIRI4
ADDRLP4 56
INDIRI4
LSHI4
ADDI4
ARGI4
ADDRGP4 $2057
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 52
INDIRI4
ADDRLP4 52
INDIRI4
ADDRLP4 56
INDIRI4
DIVI4
ADDI4
ARGI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 4217
;4217:	}
LABELV $2054
line 4218
;4218:}
LABELV $2028
endproc CG_DrawKeyPress 64 44
proc CG_Draw2D 132 24
line 4225
;4219:
;4220:/*
;4221:=================
;4222:CG_Draw2D
;4223:=================
;4224:*/
;4225:static void CG_Draw2D( void ) {
line 4232
;4226:#ifdef MISSIONPACK
;4227:	if (cgs.orderPending && cg.time > cgs.orderTime) {
;4228:		CG_CheckOrderPending();
;4229:	}
;4230:#endif
;4231:	// if we are taking a levelshot for the menu, don't draw anything
;4232:	if ( cg.levelShot ) {
ADDRGP4 cg+12
INDIRI4
CNSTI4 0
EQI4 $2059
line 4233
;4233:		return;
ADDRGP4 $2058
JUMPV
LABELV $2059
line 4236
;4234:	}
;4235:
;4236:	if ( cg_draw2D.integer == -1 ) {
ADDRGP4 cg_draw2D+12
INDIRI4
CNSTI4 -1
NEI4 $2062
line 4237
;4237:		CG_DrawCrosshair();
ADDRGP4 CG_DrawCrosshair
CALLV
pop
line 4238
;4238:		return;
ADDRGP4 $2058
JUMPV
LABELV $2062
line 4241
;4239:	}
;4240:
;4241:	if ( cg_draw2D.integer == 0 ) {
ADDRGP4 cg_draw2D+12
INDIRI4
CNSTI4 0
NEI4 $2065
line 4242
;4242:		return;
ADDRGP4 $2058
JUMPV
LABELV $2065
line 4245
;4243:	}
;4244:
;4245:	if ( cg.snap->ps.pm_type == PM_INTERMISSION ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 5
NEI4 $2068
line 4246
;4246:		CG_DrawIntermission();
ADDRGP4 CG_DrawIntermission
CALLV
pop
line 4247
;4247:		DrawMOTDBox();
ADDRGP4 DrawMOTDBox
CALLI4
pop
line 4248
;4248:		return;
ADDRGP4 $2058
JUMPV
LABELV $2068
line 4256
;4249:	}
;4250:
;4251:/*
;4252:	if (cg.cameraMode) {
;4253:		return;
;4254:	}
;4255:*/
;4256:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $2071
line 4257
;4257:		CG_DrawSpectator();
ADDRGP4 CG_DrawSpectator
CALLV
pop
line 4259
;4258:		//CG_DrawCrosshair(); -- Waste, it kicks back out if team is spectator
;4259:		CG_DrawCrosshairNames();
ADDRGP4 CG_DrawCrosshairNames
CALLV
pop
line 4260
;4260:	} else {
ADDRGP4 $2072
JUMPV
LABELV $2071
line 4267
;4261:#ifdef MISSIONPACK
;4262:			if ( cg_drawStatus.integer ) {
;4263:				Menu_PaintAll();
;4264:				CG_DrawTimedMenus();
;4265:			}
;4266:#else
;4267:			CG_DrawStatusBar();
ADDRGP4 CG_DrawStatusBar
CALLV
pop
line 4270
;4268:#endif
;4269:
;4270:			{ //Spike's Speedometer
line 4278
;4271:				qboolean draw_speed, draw_maxspeed;
;4272:				int x, y;
;4273:				float alpha;
;4274:				char *sptr;
;4275:				//char sptr[MAX_STRING_TOKENS];
;4276:				char token[24];
;4277:
;4278:				sptr = ch_Speedometer.string;
ADDRLP4 24
ADDRGP4 ch_Speedometer+16
ASGNP4
line 4281
;4279:				//Com_sprintf( sptr, MAX_STRING_TOKENS, cg_Speedometer.string);
;4280:				//Q_CleanStrOfQuotes( sptr );
;4281:				CG_ExtractToken(&sptr, token);
ADDRLP4 24
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 4282
;4282:				draw_speed = atoi(token);
ADDRLP4 0
ARGP4
ADDRLP4 48
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 48
INDIRI4
ASGNI4
line 4283
;4283:				CG_ExtractToken(&sptr, token);
ADDRLP4 24
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 4284
;4284:				draw_maxspeed = atoi(token);
ADDRLP4 0
ARGP4
ADDRLP4 52
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 52
INDIRI4
ASGNI4
line 4285
;4285:				if ( draw_speed || draw_maxspeed ) {
ADDRLP4 56
CNSTI4 0
ASGNI4
ADDRLP4 28
INDIRI4
ADDRLP4 56
INDIRI4
NEI4 $2077
ADDRLP4 32
INDIRI4
ADDRLP4 56
INDIRI4
EQI4 $2075
LABELV $2077
line 4287
;4286:					//Don't waste time if we're not gonna draw
;4287:					CG_ExtractToken(&sptr, token);
ADDRLP4 24
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 4288
;4288:					x = atoi(token);
ADDRLP4 0
ARGP4
ADDRLP4 60
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 36
ADDRLP4 60
INDIRI4
ASGNI4
line 4289
;4289:					CG_ExtractToken(&sptr, token);
ADDRLP4 24
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 4290
;4290:					y = atoi(token);
ADDRLP4 0
ARGP4
ADDRLP4 64
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 64
INDIRI4
ASGNI4
line 4291
;4291:					CG_ExtractToken(&sptr, token);
ADDRLP4 24
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 4292
;4292:					alpha = atof(token);
ADDRLP4 0
ARGP4
ADDRLP4 68
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 44
ADDRLP4 68
INDIRF4
ASGNF4
line 4294
;4293:
;4294:					CG_DrawSpeedometer(draw_speed, draw_maxspeed, x, y, alpha);
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 44
INDIRF4
ARGF4
ADDRGP4 CG_DrawSpeedometer
CALLV
pop
line 4295
;4295:				}
LABELV $2075
line 4296
;4296:			}
line 4298
;4297:
;4298:			if(cg_pmove_fixed.integer)
ADDRGP4 cg_pmove_fixed+12
INDIRI4
CNSTI4 0
EQI4 $2078
line 4299
;4299:			{ //Spike's OB Detector
line 4306
;4300:				qboolean draw;
;4301:				int x, y;
;4302:				float alpha;
;4303:				char *sptr;
;4304:				char token[24];
;4305:
;4306:				sptr = ch_OBDetector.string;
ADDRLP4 24
ADDRGP4 ch_OBDetector+16
ASGNP4
line 4307
;4307:				CG_ExtractToken(&sptr, token);
ADDRLP4 24
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 4308
;4308:				draw = atoi(token);
ADDRLP4 0
ARGP4
ADDRLP4 44
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 44
INDIRI4
ASGNI4
line 4309
;4309:				if(draw)
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $2082
line 4310
;4310:				{
line 4311
;4311:					CG_ExtractToken(&sptr, token);
ADDRLP4 24
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 4312
;4312:					x = atoi(token);
ADDRLP4 0
ARGP4
ADDRLP4 48
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 48
INDIRI4
ASGNI4
line 4313
;4313:					CG_ExtractToken(&sptr, token);
ADDRLP4 24
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 4314
;4314:					y = atoi(token);
ADDRLP4 0
ARGP4
ADDRLP4 52
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 36
ADDRLP4 52
INDIRI4
ASGNI4
line 4315
;4315:					CG_ExtractToken(&sptr, token);
ADDRLP4 24
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 4316
;4316:					alpha = atof(token);
ADDRLP4 0
ARGP4
ADDRLP4 56
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 40
ADDRLP4 56
INDIRF4
ASGNF4
line 4318
;4317:
;4318:					CG_DrawOBs(x, y, alpha);
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 40
INDIRF4
ARGF4
ADDRGP4 CG_DrawOBs
CALLV
pop
line 4319
;4319:				}
LABELV $2082
line 4320
;4320:			}
LABELV $2078
line 4322
;4321:
;4322:			{//Evo's WeaponSideBar... Kinda like Spike's stuff..
line 4336
;4323:			//I just got lucky I need 5 values and wanted to do it like his anyway.
;4324:				//{Display Background_color Width Hieght Spacing}
;4325:				qboolean draw_sidebar;
;4326:			//	int		width, height, spacing;
;4327:				//vec4_t		color;
;4328:				char	bgColor[24];
;4329:				char	fontColor[24];
;4330:				char	s_bgColor[24];
;4331:				char	s_fontColor[24];
;4332:				char	*sptr;
;4333:				char	token[24];
;4334:				
;4335:				//The colors should be figured out here and sent as vec4's
;4336:				sptr = ch_weaponSideBar.string;
ADDRLP4 24
ADDRGP4 ch_weaponSideBar+16
ASGNP4
line 4338
;4337:
;4338:				CG_ExtractToken(&sptr, token);
ADDRLP4 24
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 4339
;4339:				draw_sidebar = atoi(token);
ADDRLP4 0
ARGP4
ADDRLP4 128
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 128
INDIRI4
ASGNI4
line 4341
;4340:
;4341:				if ( draw_sidebar ) {
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $2085
line 4343
;4342:					//Don't waste time if we're not gonna draw
;4343:					CG_ExtractToken(&sptr, token);
ADDRLP4 24
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 4345
;4344:					//color = atoi(token);
;4345:					Com_sprintf(bgColor, sizeof(bgColor), token);
ADDRLP4 32
ARGP4
CNSTI4 24
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 4347
;4346:
;4347:					CG_ExtractToken(&sptr, token);
ADDRLP4 24
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 4349
;4348:					//width = atoi(token);
;4349:					Com_sprintf(fontColor, sizeof(fontColor), token);
ADDRLP4 56
ARGP4
CNSTI4 24
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 4351
;4350:
;4351:					CG_ExtractToken(&sptr, token);
ADDRLP4 24
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 4353
;4352:					//height = atoi(token);
;4353:					Com_sprintf(s_bgColor, sizeof(s_bgColor), token);
ADDRLP4 80
ARGP4
CNSTI4 24
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 4355
;4354:
;4355:					CG_ExtractToken(&sptr, token);
ADDRLP4 24
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 4357
;4356:					//spacing = atoi(token);
;4357:					Com_sprintf(s_fontColor, sizeof(s_fontColor), token);
ADDRLP4 104
ARGP4
CNSTI4 24
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 4359
;4358:
;4359:					CG_DrawWeaponSideBar(draw_sidebar, bgColor, fontColor, s_bgColor, s_fontColor);
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 32
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 80
ARGP4
ADDRLP4 104
ARGP4
ADDRGP4 CG_DrawWeaponSideBar
CALLV
pop
line 4360
;4360:				}
LABELV $2085
line 4361
;4361:			}
line 4363
;4362:
;4363:			{//Evo's viewKeyPress... Kinda like Spike's stuff..
line 4374
;4364:			//I just got lucky I need 5 values and wanted to do it like his anyway.
;4365:				//{Display x_position y_position, keyColor, fontColor}
;4366:				qboolean draw_keys;
;4367:				int		x, y, size;
;4368:				char	keyColor[24];
;4369:				char	fontColor[24];
;4370:				char	*sptr;
;4371:				char	token[24];
;4372:				
;4373:				//The colors should be figured out here and sent as vec4's
;4374:				sptr = ch_viewKeyPress.string;
ADDRLP4 24
ADDRGP4 ch_viewKeyPress+16
ASGNP4
line 4376
;4375:
;4376:				CG_ExtractToken(&sptr, token);
ADDRLP4 24
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 4377
;4377:				draw_keys = atoi(token);
ADDRLP4 0
ARGP4
ADDRLP4 92
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 92
INDIRI4
ASGNI4
line 4379
;4378:
;4379:				if ( draw_keys ) {
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $2088
line 4381
;4380:					//Don't waste time if we're not gonna draw
;4381:					CG_ExtractToken(&sptr, token);
ADDRLP4 24
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 4382
;4382:					x = atoi(token);
ADDRLP4 0
ARGP4
ADDRLP4 96
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 80
ADDRLP4 96
INDIRI4
ASGNI4
line 4384
;4383:
;4384:					CG_ExtractToken(&sptr, token);
ADDRLP4 24
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 4385
;4385:					y = atoi(token);
ADDRLP4 0
ARGP4
ADDRLP4 100
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 84
ADDRLP4 100
INDIRI4
ASGNI4
line 4387
;4386:
;4387:					CG_ExtractToken(&sptr, token);
ADDRLP4 24
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 4388
;4388:					Com_sprintf(keyColor, sizeof(keyColor), token);
ADDRLP4 32
ARGP4
CNSTI4 24
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 4390
;4389:
;4390:					CG_ExtractToken(&sptr, token);
ADDRLP4 24
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 4391
;4391:					Com_sprintf(fontColor, sizeof(fontColor), token);
ADDRLP4 56
ARGP4
CNSTI4 24
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 4393
;4392:
;4393:					CG_ExtractToken(&sptr, token);
ADDRLP4 24
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_ExtractToken
CALLV
pop
line 4394
;4394:					size = atoi(token);
ADDRLP4 0
ARGP4
ADDRLP4 104
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 88
ADDRLP4 104
INDIRI4
ASGNI4
line 4396
;4395:
;4396:					CG_DrawKeyPress(draw_keys, x, y, keyColor, fontColor, size);
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 80
INDIRI4
ARGI4
ADDRLP4 84
INDIRI4
ARGI4
ADDRLP4 32
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 88
INDIRI4
ARGI4
ADDRGP4 CG_DrawKeyPress
CALLV
pop
line 4397
;4397:				}
LABELV $2088
line 4398
;4398:			}
line 4402
;4399:
;4400:
;4401:		// don't draw any status if dead or the scoreboard is being explicitly shown
;4402:			if ( !cg.showScores && cg.snap->ps.stats[STAT_HEALTH] > 0 ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 cg+120468
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $2090
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $2090
line 4416
;4403:				//Don't draw if the scoreboard is showing, we want to see if when we're dead.
;4404:				//if ( !cg.showScores ) {
;4405:
;4406:/*
;4407:#ifdef MISSIONPACK
;4408:				if ( cg_drawStatus.integer ) {
;4409:					Menu_PaintAll();
;4410:					CG_DrawTimedMenus();
;4411:				}
;4412:#else
;4413:				CG_DrawStatusBar();
;4414:#endif
;4415:*/      
;4416:				CG_DrawAmmoWarning();
ADDRGP4 CG_DrawAmmoWarning
CALLV
pop
line 4421
;4417:
;4418:#ifdef MISSIONPACK
;4419:				CG_DrawProxWarning();
;4420:#endif      
;4421:				CG_DrawCrosshair();
ADDRGP4 CG_DrawCrosshair
CALLV
pop
line 4422
;4422:				CG_DrawCrosshairNames();
ADDRGP4 CG_DrawCrosshairNames
CALLV
pop
line 4423
;4423:				CG_DrawWeaponSelect();
ADDRGP4 CG_DrawWeaponSelect
CALLV
pop
line 4426
;4424:
;4425:#ifndef MISSIONPACK
;4426:				CG_DrawHoldableItem();
ADDRGP4 CG_DrawHoldableItem
CALLV
pop
line 4430
;4427:#else
;4428:				//CG_DrawPersistantPowerup();
;4429:#endif
;4430:				CG_DrawReward();
ADDRGP4 CG_DrawReward
CALLV
pop
line 4432
;4431:
;4432:				if ( !CG_DrawFollow() ) {
ADDRLP4 4
ADDRGP4 CG_DrawFollow
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2094
line 4434
;4433:					//CG_DrawWarmup();
;4434:				}
LABELV $2094
line 4435
;4435:		}
LABELV $2090
line 4437
;4436:
;4437:			CG_DrawWarmup();
ADDRGP4 CG_DrawWarmup
CALLV
pop
line 4439
;4438:    
;4439:		if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $2096
line 4441
;4440:#ifndef MISSIONPACK
;4441:			CG_DrawTeamInfo();
ADDRGP4 CG_DrawTeamInfo
CALLV
pop
line 4443
;4442:#endif
;4443:		}
LABELV $2096
line 4444
;4444:	}
LABELV $2072
line 4446
;4445:
;4446:	CG_DrawVote();
ADDRGP4 CG_DrawVote
CALLV
pop
line 4447
;4447:	CG_DrawTeamVote();
ADDRGP4 CG_DrawTeamVote
CALLV
pop
line 4449
;4448:
;4449:	CG_DrawLagometer();
ADDRGP4 CG_DrawLagometer
CALLV
pop
line 4456
;4450:
;4451:#ifdef MISSIONPACK
;4452:	if (!cg_paused.integer) {
;4453:		CG_DrawUpperRight();
;4454:	}
;4455:#else
;4456:	CG_DrawUpperRight();
ADDRGP4 CG_DrawUpperRight
CALLV
pop
line 4460
;4457:#endif
;4458:
;4459:#ifndef MISSIONPACK
;4460:	CG_DrawLowerRight();
ADDRGP4 CG_DrawLowerRight
CALLV
pop
line 4461
;4461:	CG_DrawLowerLeft();
ADDRGP4 CG_DrawLowerLeft
CALLV
pop
line 4468
;4462:#endif
;4463:
;4464:	/*if ( !CG_DrawFollow() ) {
;4465:		CG_DrawWarmup();
;4466:	}*/
;4467:
;4468:	DrawMOTDBox();
ADDRGP4 DrawMOTDBox
CALLI4
pop
line 4472
;4469:
;4470:	// don't draw center string if scoreboard is up
;4471:	//Score_Weapon();
;4472:	cg.scoreBoardShowing = CG_DrawScoreboard();
ADDRLP4 0
ADDRGP4 CG_DrawScoreboard
CALLI4
ASGNI4
ADDRGP4 cg+120472
ADDRLP4 0
INDIRI4
ASGNI4
line 4474
;4473:	//if ( !cg.scoreBoardShowing) {
;4474:		CG_DrawCenterString();
ADDRGP4 CG_DrawCenterString
CALLV
pop
line 4476
;4475:	//}
;4476:}
LABELV $2058
endproc CG_Draw2D 132 24
proc CG_DrawTourneyScoreboard 0 0
line 4479
;4477:
;4478:
;4479:static void CG_DrawTourneyScoreboard() {
line 4482
;4480:#ifdef MISSIONPACK
;4481:#else
;4482:	CG_DrawOldTourneyScoreboard();
ADDRGP4 CG_DrawOldTourneyScoreboard
CALLV
pop
line 4484
;4483:#endif
;4484:}
LABELV $2100
endproc CG_DrawTourneyScoreboard 0 0
export CG_Alarm
proc CG_Alarm 44 16
line 4491
;4485:
;4486:/*
;4487:=====================
;4488:CG_Alarm
;4489:=====================
;4490:*/
;4491:void CG_Alarm ( void ) {
line 4495
;4492:	qtime_t	qtm;
;4493:	
;4494:
;4495:	trap_RealTime(&qtm);
ADDRLP4 0
ARGP4
ADDRGP4 trap_RealTime
CALLI4
pop
line 4497
;4496:
;4497:	if ( cg_drawClock.integer == 2 || cg.time_type == 2) {
ADDRLP4 36
CNSTI4 2
ASGNI4
ADDRGP4 cg_drawClock+12
INDIRI4
ADDRLP4 36
INDIRI4
EQI4 $2106
ADDRGP4 cg+162088
INDIRU1
CVUI4 1
ADDRLP4 36
INDIRI4
NEI4 $2102
LABELV $2106
line 4498
;4498:		if ( qtm.tm_hour == cg.alarmTime_hour && qtm.tm_min == cg.alarmTime_minute ) {
ADDRLP4 0+8
INDIRI4
ADDRGP4 cg+162092
INDIRI4
NEI4 $2103
ADDRLP4 0+4
INDIRI4
ADDRGP4 cg+162096
INDIRI4
NEI4 $2103
line 4499
;4499:			cg.alarmSet = qfalse;
ADDRGP4 cg+162084
CNSTI4 0
ASGNI4
line 4500
;4500:			trap_S_StartSound (NULL, cg.clientNum, CHAN_AUTO, trap_S_RegisterSound( "sound/world/buzzer.wav", qtrue ) );
ADDRGP4 $2115
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 40
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRGP4 cg+4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 4501
;4501:			CG_CenterPrint("^1That is your alarm going off!", SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH);
ADDRGP4 $2116
ARGP4
CNSTI4 144
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 4503
;4502:			//CG_Printf("Alarm!\n");
;4503:			return;
ADDRGP4 $2101
JUMPV
line 4505
;4504:		}
;4505:	} else {
LABELV $2102
line 4506
;4506:		if ( qtm.tm_hour > 12 ) {
ADDRLP4 0+8
INDIRI4
CNSTI4 12
LEI4 $2117
line 4507
;4507:			if ( qtm.tm_hour - 12 == cg.alarmTime_hour && qtm.tm_min == cg.alarmTime_minute ) {
ADDRLP4 0+8
INDIRI4
CNSTI4 12
SUBI4
ADDRGP4 cg+162092
INDIRI4
NEI4 $2118
ADDRLP4 0+4
INDIRI4
ADDRGP4 cg+162096
INDIRI4
NEI4 $2118
line 4508
;4508:				cg.alarmSet = qfalse;
ADDRGP4 cg+162084
CNSTI4 0
ASGNI4
line 4509
;4509:				trap_S_StartSound (NULL, cg.clientNum, CHAN_AUTO, trap_S_RegisterSound( "sound/world/buzzer.wav", qtrue ) );
ADDRGP4 $2115
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 40
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRGP4 cg+4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 4510
;4510:				CG_CenterPrint("^1That is your alarm going off!", SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH);
ADDRGP4 $2116
ARGP4
CNSTI4 144
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 4512
;4511:				//CG_Printf("Alarm!\n");
;4512:				return;
ADDRGP4 $2101
JUMPV
line 4514
;4513:			}
;4514:		} else {
LABELV $2117
line 4515
;4515:			if ( qtm.tm_hour == cg.alarmTime_hour && qtm.tm_min == cg.alarmTime_minute ) {
ADDRLP4 0+8
INDIRI4
ADDRGP4 cg+162092
INDIRI4
NEI4 $2128
ADDRLP4 0+4
INDIRI4
ADDRGP4 cg+162096
INDIRI4
NEI4 $2128
line 4517
;4516:				//Probably could have this in the 24 hour clock section too..
;4517:				cg.alarmSet = qfalse;
ADDRGP4 cg+162084
CNSTI4 0
ASGNI4
line 4518
;4518:				trap_S_StartSound (NULL, cg.clientNum, CHAN_AUTO, trap_S_RegisterSound( "sound/world/buzzer.wav", qtrue ) );
ADDRGP4 $2115
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 40
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRGP4 cg+4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 4519
;4519:				CG_CenterPrint("^1That is your alarm going off!", SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH);
ADDRGP4 $2116
ARGP4
CNSTI4 144
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 4521
;4520:				//CG_Printf("Alarm!\n");
;4521:				return;
LABELV $2128
line 4523
;4522:			}
;4523:		}
LABELV $2118
line 4524
;4524:	}
LABELV $2103
line 4525
;4525:}
LABELV $2101
endproc CG_Alarm 44 16
data
align 4
LABELV firsttime
byte 4 1
export CG_DrawActive
code
proc CG_DrawActive 28 4
line 4538
;4526:
;4527:/*
;4528:=====================
;4529:CG_DrawActive
;4530:
;4531:Perform all drawing needed to completely fill the screen
;4532:=====================
;4533:*/
;4534:////XXX############## CHANGE START
;4535:static qboolean firsttime = qtrue;
;4536:////XXX############## CHANGE END
;4537:
;4538:void CG_DrawActive( stereoFrame_t stereoView ) {
line 4543
;4539:	float		separation;
;4540:	vec3_t		baseOrg;
;4541:
;4542:////XXX############## CHANGE START
;4543:	if(firsttime)
ADDRGP4 firsttime
INDIRI4
CNSTI4 0
EQI4 $2137
line 4544
;4544:	{
line 4546
;4545:		//prime the fade timer
;4546:		CG_GetFadeTime();
ADDRGP4 CG_GetFadeTime
CALLI4
pop
line 4547
;4547:		firsttime = qfalse;
ADDRGP4 firsttime
CNSTI4 0
ASGNI4
line 4548
;4548:	}
LABELV $2137
line 4552
;4549:////XXX############## CHANGE END
;4550:
;4551:	// optionally draw the info screen instead
;4552:	if ( !cg.snap ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2139
line 4553
;4553:		CG_DrawInformation();
ADDRGP4 CG_DrawInformation
CALLV
pop
line 4554
;4554:		return;
ADDRGP4 $2136
JUMPV
LABELV $2139
line 4558
;4555:	}
;4556:
;4557:	// optionally draw the tournement scoreboard instead
;4558:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR &&
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $2142
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $2142
line 4559
;4559:		( cg.snap->ps.pm_flags & PMF_SCOREBOARD ) ) {
line 4560
;4560:		CG_DrawTourneyScoreboard();
ADDRGP4 CG_DrawTourneyScoreboard
CALLV
pop
line 4561
;4561:		return;
ADDRGP4 $2136
JUMPV
LABELV $2142
line 4564
;4562:	}
;4563:
;4564:	switch ( stereoView ) {
ADDRLP4 16
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $2149
ADDRLP4 16
INDIRI4
CNSTI4 1
EQI4 $2150
ADDRLP4 16
INDIRI4
CNSTI4 2
EQI4 $2152
ADDRGP4 $2146
JUMPV
LABELV $2149
line 4566
;4565:	case STEREO_CENTER:
;4566:		separation = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 4567
;4567:		break;
ADDRGP4 $2147
JUMPV
LABELV $2150
line 4569
;4568:	case STEREO_LEFT:
;4569:		separation = -cg_stereoSeparation.value / 2;
ADDRLP4 0
ADDRGP4 cg_stereoSeparation+8
INDIRF4
NEGF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 4570
;4570:		break;
ADDRGP4 $2147
JUMPV
LABELV $2152
line 4572
;4571:	case STEREO_RIGHT:
;4572:		separation = cg_stereoSeparation.value / 2;
ADDRLP4 0
ADDRGP4 cg_stereoSeparation+8
INDIRF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 4573
;4573:		break;
ADDRGP4 $2147
JUMPV
LABELV $2146
line 4575
;4574:	default:
;4575:		separation = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 4576
;4576:		CG_Error( "CG_DrawActive: Undefined stereoView" );
ADDRGP4 $2154
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 4577
;4577:	}
LABELV $2147
line 4581
;4578:
;4579:
;4580:	// clear around the rendered view if sized down
;4581:	CG_TileClear();
ADDRGP4 CG_TileClear
CALLV
pop
line 4584
;4582:
;4583:	// offset vieworg appropriately if we're doing stereo separation
;4584:	VectorCopy( cg.refdef.vieworg, baseOrg );
ADDRLP4 4
ADDRGP4 cg+109048+24
INDIRB
ASGNB 12
line 4585
;4585:	if ( separation != 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
EQF4 $2157
line 4586
;4586:		VectorMA( cg.refdef.vieworg, -separation, cg.refdef.viewaxis[1], cg.refdef.vieworg );
ADDRGP4 cg+109048+24
ADDRGP4 cg+109048+24
INDIRF4
ADDRGP4 cg+109048+36+12
INDIRF4
ADDRLP4 0
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+109048+24+4
ADDRGP4 cg+109048+24+4
INDIRF4
ADDRGP4 cg+109048+36+12+4
INDIRF4
ADDRLP4 0
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+109048+24+8
ADDRGP4 cg+109048+24+8
INDIRF4
ADDRGP4 cg+109048+36+12+8
INDIRF4
ADDRLP4 0
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 4587
;4587:	}
LABELV $2157
line 4590
;4588:
;4589:	// draw 3D view
;4590:	trap_R_RenderScene( &cg.refdef );
ADDRGP4 cg+109048
ARGP4
ADDRGP4 trap_R_RenderScene
CALLV
pop
line 4593
;4591:
;4592:	// restore original viewpoint if running stereo
;4593:	if ( separation != 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
EQF4 $2187
line 4594
;4594:		VectorCopy( baseOrg, cg.refdef.vieworg );
ADDRGP4 cg+109048+24
ADDRLP4 4
INDIRB
ASGNB 12
line 4595
;4595:	}
LABELV $2187
line 4599
;4596:
;4597:	// draw status bar and other floating elements
;4598:	//Superhud - Begin
;4599:	if ( hud_count && strlen(ch_file.string) ) {
ADDRGP4 hud_count
INDIRI4
CNSTI4 0
EQI4 $2191
ADDRGP4 ch_file+16
ARGP4
ADDRLP4 24
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $2191
line 4600
;4600:		CG_DrawHud2D();
ADDRGP4 CG_DrawHud2D
CALLV
pop
line 4601
;4601:	} else {
ADDRGP4 $2192
JUMPV
LABELV $2191
line 4602
;4602: 		CG_Draw2D();
ADDRGP4 CG_Draw2D
CALLV
pop
line 4603
;4603:	}
LABELV $2192
line 4606
;4604:	//Superhud - End
;4605:
;4606:}
LABELV $2136
endproc CG_DrawActive 28 4
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
import CG_StatusHandle
import CG_OtherTeamHasFlag
import CG_YourTeamHasFlag
import CG_GameTypeString
import CG_CheckOrderPending
import CG_Text_PaintChar
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
import CG_DrawHud2D
import CG_FigureHUDColor
bss
export teamChat2
align 1
LABELV teamChat2
skip 256
export teamChat1
align 1
LABELV teamChat1
skip 256
export systemChat
align 1
LABELV systemChat
skip 256
export numSortedTeamPlayers
align 4
LABELV numSortedTeamPlayers
skip 4
export sortedTeamPlayers
align 4
LABELV sortedTeamPlayers
skip 128
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
LABELV $2154
byte 1 67
byte 1 71
byte 1 95
byte 1 68
byte 1 114
byte 1 97
byte 1 119
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 101
byte 1 58
byte 1 32
byte 1 85
byte 1 110
byte 1 100
byte 1 101
byte 1 102
byte 1 105
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 101
byte 1 111
byte 1 86
byte 1 105
byte 1 101
byte 1 119
byte 1 0
align 1
LABELV $2116
byte 1 94
byte 1 49
byte 1 84
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 97
byte 1 108
byte 1 97
byte 1 114
byte 1 109
byte 1 32
byte 1 103
byte 1 111
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 111
byte 1 102
byte 1 102
byte 1 33
byte 1 0
align 1
LABELV $2115
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
byte 1 98
byte 1 117
byte 1 122
byte 1 122
byte 1 101
byte 1 114
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $2057
byte 1 74
byte 1 117
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $2053
byte 1 67
byte 1 114
byte 1 111
byte 1 117
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $2048
byte 1 76
byte 1 0
align 1
LABELV $2044
byte 1 82
byte 1 0
align 1
LABELV $2040
byte 1 66
byte 1 0
align 1
LABELV $2036
byte 1 70
byte 1 0
align 1
LABELV $2026
byte 1 57
byte 1 57
byte 1 57
byte 1 0
align 1
LABELV $2012
byte 1 48
byte 1 0
align 1
LABELV $1978
byte 1 83
byte 1 74
byte 1 0
align 1
LABELV $1973
byte 1 74
byte 1 0
align 1
LABELV $1949
byte 1 83
byte 1 71
byte 1 0
align 1
LABELV $1944
byte 1 71
byte 1 0
align 1
LABELV $1884
byte 1 37
byte 1 46
byte 1 51
byte 1 102
byte 1 109
byte 1 97
byte 1 120
byte 1 0
align 1
LABELV $1881
byte 1 37
byte 1 46
byte 1 51
byte 1 102
byte 1 117
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $1834
byte 1 83
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1827
byte 1 0
align 1
LABELV $1826
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $1822
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 68
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $1818
byte 1 70
byte 1 114
byte 1 101
byte 1 101
byte 1 32
byte 1 70
byte 1 111
byte 1 114
byte 1 32
byte 1 65
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $1812
byte 1 37
byte 1 115
byte 1 32
byte 1 94
byte 1 55
byte 1 118
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1791
byte 1 87
byte 1 97
byte 1 105
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $1781
byte 1 76
byte 1 79
byte 1 87
byte 1 32
byte 1 65
byte 1 77
byte 1 77
byte 1 79
byte 1 32
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 0
align 1
LABELV $1780
byte 1 79
byte 1 85
byte 1 84
byte 1 32
byte 1 79
byte 1 70
byte 1 32
byte 1 65
byte 1 77
byte 1 77
byte 1 79
byte 1 0
align 1
LABELV $1769
byte 1 70
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $1758
byte 1 115
byte 1 116
byte 1 111
byte 1 112
byte 1 114
byte 1 101
byte 1 99
byte 1 111
byte 1 114
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1742
byte 1 115
byte 1 99
byte 1 114
byte 1 101
byte 1 101
byte 1 110
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 32
byte 1 37
byte 1 105
byte 1 46
byte 1 37
byte 1 105
byte 1 46
byte 1 37
byte 1 105
byte 1 45
byte 1 45
byte 1 37
byte 1 115
byte 1 45
byte 1 37
byte 1 115
byte 1 45
byte 1 37
byte 1 48
byte 1 50
byte 1 105
byte 1 46
byte 1 37
byte 1 48
byte 1 50
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $1726
byte 1 115
byte 1 99
byte 1 114
byte 1 101
byte 1 101
byte 1 110
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 74
byte 1 80
byte 1 69
byte 1 71
byte 1 32
byte 1 37
byte 1 105
byte 1 46
byte 1 37
byte 1 105
byte 1 46
byte 1 37
byte 1 105
byte 1 45
byte 1 45
byte 1 37
byte 1 115
byte 1 45
byte 1 37
byte 1 115
byte 1 45
byte 1 37
byte 1 48
byte 1 50
byte 1 105
byte 1 46
byte 1 37
byte 1 48
byte 1 50
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $1683
byte 1 84
byte 1 69
byte 1 65
byte 1 77
byte 1 86
byte 1 79
byte 1 84
byte 1 69
byte 1 40
byte 1 37
byte 1 105
byte 1 41
byte 1 58
byte 1 37
byte 1 115
byte 1 32
byte 1 121
byte 1 101
byte 1 115
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 110
byte 1 111
byte 1 58
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1663
byte 1 86
byte 1 79
byte 1 84
byte 1 69
byte 1 40
byte 1 37
byte 1 105
byte 1 41
byte 1 58
byte 1 37
byte 1 115
byte 1 32
byte 1 121
byte 1 101
byte 1 115
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 110
byte 1 111
byte 1 58
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1654
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 32
byte 1 69
byte 1 83
byte 1 67
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 74
byte 1 79
byte 1 73
byte 1 78
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $1650
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $1644
byte 1 83
byte 1 80
byte 1 69
byte 1 67
byte 1 84
byte 1 65
byte 1 84
byte 1 79
byte 1 82
byte 1 0
align 1
LABELV $1474
byte 1 115
byte 1 110
byte 1 99
byte 1 0
align 1
LABELV $1414
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 101
byte 1 116
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1410
byte 1 67
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 73
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 114
byte 1 117
byte 1 112
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $1380
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $826
byte 1 37
byte 1 50
byte 1 105
byte 1 0
align 1
LABELV $754
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
LABELV $698
byte 1 37
byte 1 51
byte 1 105
byte 1 32
byte 1 37
byte 1 51
byte 1 105
byte 1 0
align 1
LABELV $692
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $611
byte 1 37
byte 1 105
byte 1 58
byte 1 37
byte 1 48
byte 1 50
byte 1 105
byte 1 58
byte 1 37
byte 1 48
byte 1 50
byte 1 105
byte 1 112
byte 1 109
byte 1 0
align 1
LABELV $609
byte 1 37
byte 1 105
byte 1 58
byte 1 37
byte 1 48
byte 1 50
byte 1 105
byte 1 58
byte 1 37
byte 1 48
byte 1 50
byte 1 105
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $587
byte 1 37
byte 1 105
byte 1 58
byte 1 37
byte 1 48
byte 1 50
byte 1 105
byte 1 58
byte 1 37
byte 1 48
byte 1 50
byte 1 105
byte 1 0
align 1
LABELV $573
byte 1 37
byte 1 105
byte 1 58
byte 1 37
byte 1 48
byte 1 50
byte 1 105
byte 1 0
align 1
LABELV $556
byte 1 37
byte 1 105
byte 1 102
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $540
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 115
byte 1 110
byte 1 97
byte 1 112
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 99
byte 1 109
byte 1 100
byte 1 58
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $538
byte 1 110
byte 1 0
align 1
LABELV $293
byte 1 70
byte 1 114
byte 1 111
byte 1 122
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $160
byte 1 37
byte 1 105
byte 1 0
