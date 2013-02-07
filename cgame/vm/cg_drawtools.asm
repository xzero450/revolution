data
export fadeTime
align 4
LABELV fadeTime
byte 4 0
align 4
LABELV baseFadeTime
byte 4 -1
export CG_GetFadeTime
code
proc CG_GetFadeTime 0 0
file "../cg_drawtools.c"
line 12
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_drawtools.c -- helper functions called by cg_draw, cg_scoreboard, cg_info, etc
;4:#include "cg_local.h"
;5:
;6:////XXX############## CHANGE START
;7://for text fading
;8:int fadeTime = 0;
;9:static int baseFadeTime = -1;
;10:
;11:int CG_GetFadeTime(void)
;12:{
line 13
;13:	if(baseFadeTime == -1)
ADDRGP4 baseFadeTime
INDIRI4
CNSTI4 -1
NEI4 $78
line 14
;14:		baseFadeTime = cg.time; //trap_Milliseconds();
ADDRGP4 baseFadeTime
ADDRGP4 cg+107604
INDIRI4
ASGNI4
LABELV $78
line 16
;15:
;16:	fadeTime = cg.time - baseFadeTime; //trap_Milliseconds() - baseFadeTime;
ADDRGP4 fadeTime
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 baseFadeTime
INDIRI4
SUBI4
ASGNI4
line 18
;17:
;18:	return fadeTime;
ADDRGP4 fadeTime
INDIRI4
RETI4
LABELV $77
endproc CG_GetFadeTime 0 0
export CG_AdjustFrom640
proc CG_AdjustFrom640 16 0
line 29
;19:}
;20:////XXX############## CHANGE END
;21:
;22:/*
;23:================
;24:CG_AdjustFrom640
;25:
;26:Adjusted for resolution and screen aspect ratio
;27:================
;28:*/
;29:void CG_AdjustFrom640( float *x, float *y, float *w, float *h ) {
line 37
;30:#if 0
;31:	// adjust for wide screens
;32:	if ( cgs.glconfig.vidWidth * 480 > cgs.glconfig.vidHeight * 640 ) {
;33:		*x += 0.5 * ( cgs.glconfig.vidWidth - ( cgs.glconfig.vidHeight * 640 / 480 ) );
;34:	}
;35:#endif
;36:	// scale for screen sizes
;37:	*x *= cgs.screenXScale;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ASGNF4
line 38
;38:	*y *= cgs.screenYScale;
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRGP4 cgs+31436
INDIRF4
MULF4
ASGNF4
line 39
;39:	*w *= cgs.screenXScale;
ADDRLP4 8
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ASGNF4
line 40
;40:	*h *= cgs.screenYScale;
ADDRLP4 12
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRGP4 cgs+31436
INDIRF4
MULF4
ASGNF4
line 41
;41:}
LABELV $82
endproc CG_AdjustFrom640 16 0
export CG_FillRect
proc CG_FillRect 4 36
line 50
;42:
;43:/*
;44:================
;45:CG_FillRect
;46:
;47:Coordinates are 640*480 virtual values
;48:=================
;49:*/
;50:void CG_FillRect( float x, float y, float width, float height, const float *color ) {
line 51
;51:	trap_R_SetColor( color );
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 53
;52:
;53:	CG_AdjustFrom640( &x, &y, &width, &height );
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
line 54
;54:	trap_R_DrawStretchPic( x, y, width, height, 0, 0, 0, 0, cgs.media.whiteShader );
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
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 cgs+156680+36
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 56
;55:
;56:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 57
;57:}
LABELV $87
endproc CG_FillRect 4 36
export CG_DrawSides
proc CG_DrawSides 12 36
line 66
;58:
;59:/*
;60:================
;61:CG_DrawSides
;62:
;63:Coords are virtual 640x480
;64:================
;65:*/
;66:void CG_DrawSides(float x, float y, float w, float h, float size) {
line 67
;67:	CG_AdjustFrom640( &x, &y, &w, &h );
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
line 68
;68:	size *= cgs.screenXScale;
ADDRFP4 16
ADDRFP4 16
INDIRF4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ASGNF4
line 69
;69:	trap_R_DrawStretchPic( x, y, size, h, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 16
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 0
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 cgs+156680+36
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 70
;70:	trap_R_DrawStretchPic( x + w - size, y, size, h, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRLP4 4
ADDRFP4 16
INDIRF4
ASGNF4
ADDRFP4 0
INDIRF4
ADDRFP4 8
INDIRF4
ADDF4
ADDRLP4 4
INDIRF4
SUBF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRGP4 cgs+156680+36
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 71
;71:}
LABELV $90
endproc CG_DrawSides 12 36
export CG_DrawTopBottom
proc CG_DrawTopBottom 12 36
line 73
;72:
;73:void CG_DrawTopBottom(float x, float y, float w, float h, float size) {
line 74
;74:	CG_AdjustFrom640( &x, &y, &w, &h );
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
line 75
;75:	size *= cgs.screenYScale;
ADDRFP4 16
ADDRFP4 16
INDIRF4
ADDRGP4 cgs+31436
INDIRF4
MULF4
ASGNF4
line 76
;76:	trap_R_DrawStretchPic( x, y, w, size, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 16
INDIRF4
ARGF4
ADDRLP4 0
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 cgs+156680+36
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 77
;77:	trap_R_DrawStretchPic( x, y + h - size, w, size, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRFP4 16
INDIRF4
ASGNF4
ADDRFP4 4
INDIRF4
ADDRFP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRF4
SUBF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRGP4 cgs+156680+36
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 78
;78:}
LABELV $96
endproc CG_DrawTopBottom 12 36
export CG_DrawRect
proc CG_DrawRect 0 20
line 86
;79:/*
;80:================
;81:UI_DrawRect
;82:
;83:Coordinates are 640*480 virtual values
;84:=================
;85:*/
;86:void CG_DrawRect( float x, float y, float width, float height, float size, const float *color ) {
line 87
;87:	trap_R_SetColor( color );
ADDRFP4 20
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 89
;88:
;89:  CG_DrawTopBottom(x, y, width, height, size);
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
ADDRFP4 16
INDIRF4
ARGF4
ADDRGP4 CG_DrawTopBottom
CALLV
pop
line 90
;90:  CG_DrawSides(x, y, width, height, size);
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
ADDRFP4 16
INDIRF4
ARGF4
ADDRGP4 CG_DrawSides
CALLV
pop
line 92
;91:
;92:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 93
;93:}
LABELV $102
endproc CG_DrawRect 0 20
export CG_DrawPic
proc CG_DrawPic 8 36
line 104
;94:
;95:
;96:
;97:/*
;98:================
;99:CG_DrawPic
;100:
;101:Coordinates are 640*480 virtual values
;102:=================
;103:*/
;104:void CG_DrawPic( float x, float y, float width, float height, qhandle_t hShader ) {
line 105
;105:	CG_AdjustFrom640( &x, &y, &width, &height );
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
line 106
;106:	trap_R_DrawStretchPic( x, y, width, height, 0, 0, 1, 1, hShader );
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
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 107
;107:}
LABELV $103
endproc CG_DrawPic 8 36
export CG_DrawChar
proc CG_DrawChar 64 36
line 117
;108:
;109://Superhud - Begin
;110:/*
;111:===============
;112:CG_DrawChar
;113:
;114:Coordinates and size in 640*480 virtual screen size
;115:===============
;116:*/
;117:void CG_DrawChar( int x, int y, int width, int height, int ch, int altFont, int superhud ) {
line 123
;118:	int row, col;
;119:	float frow, fcol;
;120:	float size;
;121:	float	ax, ay, aw, ah;
;122:
;123:	ch &= 255;
ADDRFP4 16
ADDRFP4 16
INDIRI4
CNSTI4 255
BANDI4
ASGNI4
line 125
;124:
;125:	if ( ch == ' ' ) {
ADDRFP4 16
INDIRI4
CNSTI4 32
NEI4 $105
line 126
;126:		return;
ADDRGP4 $104
JUMPV
LABELV $105
line 129
;127:	}
;128:
;129:	ax = x;
ADDRLP4 0
ADDRFP4 0
INDIRI4
CVIF4 4
ASGNF4
line 130
;130:	ay = y;
ADDRLP4 4
ADDRFP4 4
INDIRI4
CVIF4 4
ASGNF4
line 131
;131:	aw = width;
ADDRLP4 8
ADDRFP4 8
INDIRI4
CVIF4 4
ASGNF4
line 132
;132:	ah = height;
ADDRLP4 12
ADDRFP4 12
INDIRI4
CVIF4 4
ASGNF4
line 133
;133:	CG_AdjustFrom640( &ax, &ay, &aw, &ah );
ADDRLP4 0
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 135
;134:
;135:	row = ch>>4;
ADDRLP4 28
ADDRFP4 16
INDIRI4
CNSTI4 4
RSHI4
ASGNI4
line 136
;136:	col = ch&15;
ADDRLP4 32
ADDRFP4 16
INDIRI4
CNSTI4 15
BANDI4
ASGNI4
line 138
;137:
;138:	frow = row*0.0625;
ADDRLP4 16
CNSTF4 1031798784
ADDRLP4 28
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 139
;139:	fcol = col*0.0625;
ADDRLP4 20
CNSTF4 1031798784
ADDRLP4 32
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 140
;140:	size = 0.0625;
ADDRLP4 24
CNSTF4 1031798784
ASGNF4
line 142
;141:
;142:	if ( superhud && ( !Q_stricmp(hud[superhud].font, "threewave") || !Q_stricmp(hud[superhud].font, "cpma")) ) {
ADDRLP4 36
ADDRFP4 24
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $107
CNSTI4 504
ADDRLP4 36
INDIRI4
MULI4
ADDRGP4 hud+176
ADDP4
ARGP4
ADDRGP4 $110
ARGP4
ADDRLP4 40
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $113
CNSTI4 504
ADDRFP4 24
INDIRI4
MULI4
ADDRGP4 hud+176
ADDP4
ARGP4
ADDRGP4 $112
ARGP4
ADDRLP4 44
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $107
LABELV $113
line 143
;143:		if ( !Q_stricmp(hud[superhud].font, "threewave") ) {
CNSTI4 504
ADDRFP4 24
INDIRI4
MULI4
ADDRGP4 hud+176
ADDP4
ARGP4
ADDRGP4 $110
ARGP4
ADDRLP4 48
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $114
line 144
;144:			trap_R_DrawStretchPic( ax, ay, aw, ah, fcol, frow, fcol + size, frow + size, cgs.media.charsetThreewave );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 52
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 56
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 60
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 52
INDIRF4
ADDRLP4 60
INDIRF4
ADDF4
ARGF4
ADDRLP4 56
INDIRF4
ADDRLP4 60
INDIRF4
ADDF4
ARGF4
ADDRGP4 cgs+156680+8
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 145
;145:		} else {
ADDRGP4 $108
JUMPV
LABELV $114
line 146
;146:			trap_R_DrawStretchPic( ax, ay, aw, ah, fcol, frow, fcol + size, frow + size, cgs.media.charsetCPMA );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 52
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 56
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 60
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 52
INDIRF4
ADDRLP4 60
INDIRF4
ADDF4
ARGF4
ADDRLP4 56
INDIRF4
ADDRLP4 60
INDIRF4
ADDF4
ARGF4
ADDRGP4 cgs+156680+4
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 147
;147:		}
line 148
;148:	} else {
ADDRGP4 $108
JUMPV
LABELV $107
line 149
;149:		if ( !altFont ) {
ADDRFP4 20
INDIRI4
CNSTI4 0
NEI4 $121
line 150
;150:			trap_R_DrawStretchPic( ax, ay, aw, ah, fcol, frow, fcol + size, frow + size, cgs.media.charsetShader );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 48
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 52
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 56
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 48
INDIRF4
ADDRLP4 56
INDIRF4
ADDF4
ARGF4
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
ADDF4
ARGF4
ADDRGP4 cgs+156680
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 151
;151:		} else if ( altFont == FONT_BLOCK ) {
ADDRGP4 $122
JUMPV
LABELV $121
ADDRFP4 20
INDIRI4
CNSTI4 1
NEI4 $124
line 152
;152:			trap_R_DrawStretchPic( ax, ay, aw, ah, fcol, frow, fcol + size, frow + size, cgs.media.charsetPropC );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 48
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 52
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 56
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 48
INDIRF4
ADDRLP4 56
INDIRF4
ADDF4
ARGF4
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
ADDF4
ARGF4
ADDRGP4 cgs+156680+32
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 153
;153:		} else if ( altFont == FONT_THREEWAVE ) {
ADDRGP4 $125
JUMPV
LABELV $124
ADDRFP4 20
INDIRI4
CNSTI4 2
NEI4 $128
line 154
;154:			trap_R_DrawStretchPic( ax, ay, aw, ah, fcol, frow, fcol + size, frow + size, cgs.media.charsetThreewave );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 48
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 52
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 56
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 48
INDIRF4
ADDRLP4 56
INDIRF4
ADDF4
ARGF4
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
ADDF4
ARGF4
ADDRGP4 cgs+156680+8
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 155
;155:		} else if ( altFont == FONT_CPMA ) {
ADDRGP4 $129
JUMPV
LABELV $128
ADDRFP4 20
INDIRI4
CNSTI4 3
NEI4 $132
line 156
;156:			trap_R_DrawStretchPic( ax, ay, aw, ah, fcol, frow, fcol + size, frow + size, cgs.media.charsetCPMA );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 48
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 52
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 56
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 48
INDIRF4
ADDRLP4 56
INDIRF4
ADDF4
ARGF4
ADDRLP4 52
INDIRF4
ADDRLP4 56
INDIRF4
ADDF4
ARGF4
ADDRGP4 cgs+156680+4
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 157
;157:		}
LABELV $132
LABELV $129
LABELV $125
LABELV $122
line 158
;158:	}
LABELV $108
line 159
;159:}
LABELV $104
endproc CG_DrawChar 64 36
export CG_FigureHUDColor
proc CG_FigureHUDColor 12 0
line 167
;160:
;161:/*
;162:==============
;163:CG_FigureHUDColor
;164:==============
;165:*/
;166:float *CG_FigureHUDColor(int superhud)
;167:{
line 169
;168:	//FIXME: ???
;169:	if(cgs.gametype >= GT_TEAM && (hud[superhud].TEColor == TEAM_COLORS || hud[superhud].TEColor == ENEMY_COLORS))
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $137
ADDRLP4 0
CNSTI4 504
ADDRFP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRGP4 hud+172
ADDP4
INDIRU1
CVUI4 1
CNSTI4 1
EQI4 $142
ADDRLP4 0
INDIRI4
ADDRGP4 hud+172
ADDP4
INDIRU1
CVUI4 1
CNSTI4 2
NEI4 $137
LABELV $142
line 170
;170:	{
line 171
;171:		if ( cgs.clientinfo[cg.clientNum].team == TEAM_RED && hud[superhud].TEColor == 1 ||
ADDRLP4 4
CNSTI4 1
ASGNI4
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $154
CNSTI4 504
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 hud+172
ADDP4
INDIRU1
CVUI4 1
ADDRLP4 4
INDIRI4
EQI4 $153
LABELV $154
CNSTI4 1776
ADDRGP4 cg+4
INDIRI4
MULI4
ADDRGP4 cgs+40960+68
ADDP4
INDIRI4
CNSTI4 1
EQI4 $143
CNSTI4 504
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 hud+172
ADDP4
INDIRU1
CVUI4 1
CNSTI4 2
NEI4 $143
LABELV $153
line 172
;172:			 cgs.clientinfo[cg.clientNum].team != TEAM_RED && hud[superhud].TEColor == 2 ) {
line 173
;173:			return colorRed;
ADDRGP4 colorRed
RETP4
ADDRGP4 $136
JUMPV
LABELV $143
line 174
;174:		} else {
line 175
;175:			return colorBlue;
ADDRGP4 colorBlue
RETP4
ADDRGP4 $136
JUMPV
LABELV $137
line 177
;176:		}
;177:	} else if ( hud[superhud].TEColor > 0 || hud[superhud].TEColor == 0 && hud[superhud].bgcolor ) {//It's a byte, has to be > 0 comparison
ADDRLP4 4
CNSTI4 504
ADDRFP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRI4
ADDRGP4 hud+172
ADDP4
INDIRU1
CVUI4 1
ADDRLP4 8
INDIRI4
GTI4 $160
ADDRLP4 4
INDIRI4
ADDRGP4 hud+172
ADDP4
INDIRU1
CVUI4 1
ADDRLP4 8
INDIRI4
NEI4 $155
ADDRLP4 4
INDIRI4
ADDRGP4 hud+84
ADDP4
CVPU4 4
CNSTU4 0
EQU4 $155
LABELV $160
line 179
;178:		//This should be enforced by the parser when T/E are set.
;179:		return hud[superhud].bgcolor;
CNSTI4 504
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 hud+84
ADDP4
RETP4
ADDRGP4 $136
JUMPV
LABELV $155
line 180
;180:	} else {
line 181
;181:		return hud[superhud].color;
CNSTI4 504
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 hud+68
ADDP4
RETP4
LABELV $136
endproc CG_FigureHUDColor 12 0
export CG_DrawStringExt
proc CG_DrawStringExt 228 28
line 225
;182:	}
;183:/*	//This may not be setup incorrectly, all FillRect's should be able to use this also
;184:	if ( cgs.gametype >= GT_TEAM && (hud[superhud].TEColor == 1 || hud[superhud].TEColor == 2 ) ) {
;185:		if ( cgs.clientinfo[cg.clientNum].team == TEAM_RED && hud[superhud].TEColor == 1 ||
;186:			 cgs.clientinfo[cg.clientNum].team != TEAM_RED && hud[superhud].TEColor == 2 ) {
;187:			return colorRed;
;188:		} else {
;189:			return colorBlue;
;190:		}
;191:	} else if ( hud[superhud].TEColor > 0 || hud[superhud].TEColor == 0 && hud[superhud].bgcolor ) {//It's a byte, has to be > 0 comparison
;192:		//This should be enforced by the parser when T/E are set.
;193:		return hud[superhud].bgcolor;
;194:	} else {
;195:		return hud[superhud].color;
;196:	}
;197:*/
;198:}
;199:
;200:/*
;201:==================
;202:CG_DrawStringExt
;203:
;204:Draws a multi-colored string with a drop shadow, optionally forcing
;205:to a fixed color.
;206:
;207:Coordinates are at 640 by 480 virtual resolution
;208:==================
;209:*/
;210:/********************************
;211:#################################
;212:Note to M^onk^K
;213:
;214:Virtually every string rendering function calls this.
;215:They will all need to be updated for the extra param
;216:Unless you create a new rendering route.
;217:#################################
;218:********************************/
;219:
;220:////XXX############## CHANGE START
;221:#define FADE_RATE 1300	//milliseconds
;222:////XXX############## CHANGE END
;223:
;224:void CG_DrawStringExt( int x, int y, const char *string, const float *setColor, 
;225:		qboolean forceColor, qboolean shadow, int charWidth, int charHeight, int maxChars, int altFont, int superhud ) {
line 230
;226:	vec4_t		color;
;227:	const char	*s;
;228:	int			xx;
;229:	int			cnt;
;230:	int			cnt_colors = 0;
ADDRLP4 88
CNSTI4 0
ASGNI4
line 232
;231:	vec4_t		fadeColors[5];
;232:	int			nameLength[2], nameCnt = 0;
ADDRLP4 124
CNSTI4 0
ASGNI4
line 233
;233:	int			staticStart = 0;
ADDRLP4 144
CNSTI4 0
ASGNI4
line 234
;234:	qboolean	isStaticFade = qfalse;
ADDRLP4 96
CNSTI4 0
ASGNI4
line 240
;235:	int			num_state;
;236:	int			state;	//0 = fade forward; 1 = stay color2; 2 = fade backwards; 3 = stay color1
;237:	int			rem;
;238:	float		scale;
;239:
;240:	memset( fadeColors, 0, sizeof(fadeColors));
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
CNSTI4 80
ARGI4
ADDRGP4 memset
CALLP4
pop
line 242
;241:
;242:	if (maxChars <= 0)
ADDRFP4 32
INDIRI4
CNSTI4 0
GTI4 $164
line 243
;243:		maxChars = 32767; // do them all!
ADDRFP4 32
CNSTI4 32767
ASGNI4
LABELV $164
line 245
;244:
;245:	if ( superhud == -1 ) {
ADDRFP4 40
INDIRI4
CNSTI4 -1
NEI4 $166
line 248
;246:			//align center
;247:			int w;
;248:			w = CG_DrawStrlen( string ) * charWidth;
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 152
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 148
ADDRLP4 152
INDIRI4
ADDRFP4 24
INDIRI4
MULI4
ASGNI4
line 249
;249:			x = (x + (altFont * .5)) - (w * .5);
ADDRLP4 156
CNSTF4 1056964608
ASGNF4
ADDRFP4 0
ADDRFP4 0
INDIRI4
CVIF4 4
ADDRLP4 156
INDIRF4
ADDRFP4 36
INDIRI4
CVIF4 4
MULF4
ADDF4
ADDRLP4 156
INDIRF4
ADDRLP4 148
INDIRI4
CVIF4 4
MULF4
SUBF4
CVFI4 4
ASGNI4
line 250
;250:			superhud = 0;
ADDRFP4 40
CNSTI4 0
ASGNI4
line 251
;251:			altFont = 0;
ADDRFP4 36
CNSTI4 0
ASGNI4
line 252
;252:	} else if ( superhud && 
ADDRGP4 $167
JUMPV
LABELV $166
ADDRLP4 148
ADDRFP4 40
INDIRI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $168
ADDRLP4 152
CNSTI4 504
ADDRLP4 148
INDIRI4
MULI4
ASGNI4
ADDRLP4 152
INDIRI4
ADDRGP4 hud+44
ADDP4
INDIRI4
CNSTI4 66
EQI4 $168
ADDRLP4 152
INDIRI4
ADDRGP4 hud+44
ADDP4
INDIRI4
CNSTI4 55
EQI4 $168
ADDRLP4 152
INDIRI4
ADDRGP4 hud+44
ADDP4
INDIRI4
CNSTI4 56
EQI4 $168
ADDRLP4 152
INDIRI4
ADDRGP4 hud+44
ADDP4
INDIRI4
CNSTI4 57
EQI4 $168
ADDRLP4 152
INDIRI4
ADDRGP4 hud+44
ADDP4
INDIRI4
CNSTI4 58
EQI4 $168
ADDRLP4 152
INDIRI4
ADDRGP4 hud+44
ADDP4
INDIRI4
CNSTI4 59
EQI4 $168
ADDRLP4 152
INDIRI4
ADDRGP4 hud+44
ADDP4
INDIRI4
CNSTI4 60
EQI4 $168
ADDRLP4 152
INDIRI4
ADDRGP4 hud+44
ADDP4
INDIRI4
CNSTI4 61
EQI4 $168
ADDRLP4 152
INDIRI4
ADDRGP4 hud+44
ADDP4
INDIRI4
CNSTI4 62
EQI4 $168
line 262
;253:		!( hud[superhud].element == WeaponList ||
;254:		   hud[superhud].element == Team1 || 
;255:		   hud[superhud].element == Team2 ||
;256:		   hud[superhud].element == Team3 ||
;257:		   hud[superhud].element == Team4 ||
;258:		   hud[superhud].element == Team5 ||
;259:		   hud[superhud].element == Team6 ||
;260:		   hud[superhud].element == Team7 ||
;261:		   hud[superhud].element == Team8
;262:		) ) {//Ignore the settings passed through
line 265
;263:		int w;
;264:
;265:		w = CG_DrawStrlen( string ) * hud[superhud].fontsize[0];
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 160
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 156
ADDRLP4 160
INDIRI4
CNSTI4 504
ADDRFP4 40
INDIRI4
MULI4
ADDRGP4 hud+160
ADDP4
INDIRI4
MULI4
ASGNI4
line 266
;266:		y = hud[superhud].rect[1];
ADDRFP4 4
CNSTI4 504
ADDRFP4 40
INDIRI4
MULI4
ADDRGP4 hud+144+4
ADDP4
INDIRI4
ASGNI4
line 267
;267:		setColor = hud[superhud].color;
ADDRFP4 12
CNSTI4 504
ADDRFP4 40
INDIRI4
MULI4
ADDRGP4 hud+68
ADDP4
ASGNP4
line 268
;268:		forceColor = qfalse;
ADDRFP4 16
CNSTI4 0
ASGNI4
line 269
;269:		charWidth = hud[superhud].fontsize[0];
ADDRFP4 24
CNSTI4 504
ADDRFP4 40
INDIRI4
MULI4
ADDRGP4 hud+160
ADDP4
INDIRI4
ASGNI4
line 270
;270:		charHeight = hud[superhud].fontsize[1];
ADDRFP4 28
CNSTI4 504
ADDRFP4 40
INDIRI4
MULI4
ADDRGP4 hud+160+4
ADDP4
INDIRI4
ASGNI4
line 271
;271:		if ( hud[superhud].textstyle == 1 ) {
CNSTI4 504
ADDRFP4 40
INDIRI4
MULI4
ADDRGP4 hud+175
ADDP4
INDIRU1
CVUI4 1
CNSTI4 1
NEI4 $186
line 272
;272:			shadow = qtrue;
ADDRFP4 20
CNSTI4 1
ASGNI4
line 273
;273:		} else {
ADDRGP4 $187
JUMPV
LABELV $186
line 274
;274:			shadow = qfalse;
ADDRFP4 20
CNSTI4 0
ASGNI4
line 275
;275:		}
LABELV $187
line 278
;276:
;277:		//CG_Printf("%s %i %i %i %i\n", hud[superhud].name, hud[superhud].rect[0],hud[superhud].rect[1],hud[superhud].rect[2],hud[superhud].rect[3]);
;278:		if ( hud[superhud].element == RankMessage ) {
CNSTI4 504
ADDRFP4 40
INDIRI4
MULI4
ADDRGP4 hud+44
ADDP4
INDIRI4
CNSTI4 35
NEI4 $189
line 279
;279:			if ( hud[superhud].fade ) {
CNSTI4 504
ADDRFP4 40
INDIRI4
MULI4
ADDRGP4 hud+100
ADDP4
CVPU4 4
CNSTU4 0
EQU4 $190
line 280
;280:				setColor = CG_FadeFromColorTo(hud[superhud].color, hud[superhud].fade, cg.rankMessageTime, hud[superhud].time);
ADDRLP4 164
CNSTI4 504
ADDRFP4 40
INDIRI4
MULI4
ASGNI4
ADDRLP4 164
INDIRI4
ADDRGP4 hud+68
ADDP4
ARGP4
ADDRLP4 164
INDIRI4
ADDRGP4 hud+100
ADDP4
ARGP4
ADDRGP4 cg+170448
INDIRI4
ARGI4
ADDRLP4 164
INDIRI4
ADDRGP4 hud+168
ADDP4
INDIRI4
ARGI4
ADDRLP4 168
ADDRGP4 CG_FadeFromColorTo
CALLP4
ASGNP4
ADDRFP4 12
ADDRLP4 168
INDIRP4
ASGNP4
line 281
;281:			}
line 282
;282:		} else if ( hud[superhud].element == FragMessage ) {
ADDRGP4 $190
JUMPV
LABELV $189
CNSTI4 504
ADDRFP4 40
INDIRI4
MULI4
ADDRGP4 hud+44
ADDP4
INDIRI4
CNSTI4 19
NEI4 $199
line 283
;283:			if ( hud[superhud].fade ) {
CNSTI4 504
ADDRFP4 40
INDIRI4
MULI4
ADDRGP4 hud+100
ADDP4
CVPU4 4
CNSTU4 0
EQU4 $200
line 284
;284:				setColor = CG_FadeFromColorTo(hud[superhud].color, hud[superhud].fade, cg.fragMessageTime, hud[superhud].time);
ADDRLP4 164
CNSTI4 504
ADDRFP4 40
INDIRI4
MULI4
ASGNI4
ADDRLP4 164
INDIRI4
ADDRGP4 hud+68
ADDP4
ARGP4
ADDRLP4 164
INDIRI4
ADDRGP4 hud+100
ADDP4
ARGP4
ADDRGP4 cg+170316
INDIRI4
ARGI4
ADDRLP4 164
INDIRI4
ADDRGP4 hud+168
ADDP4
INDIRI4
ARGI4
ADDRLP4 168
ADDRGP4 CG_FadeFromColorTo
CALLP4
ASGNP4
ADDRFP4 12
ADDRLP4 168
INDIRP4
ASGNP4
line 285
;285:			}
line 286
;286:		} else if ( hud[superhud].element == TargetName ) {
ADDRGP4 $200
JUMPV
LABELV $199
CNSTI4 504
ADDRFP4 40
INDIRI4
MULI4
ADDRGP4 hud+44
ADDP4
INDIRI4
CNSTI4 49
NEI4 $209
line 287
;287:			if ( hud[superhud].fade ) {
CNSTI4 504
ADDRFP4 40
INDIRI4
MULI4
ADDRGP4 hud+100
ADDP4
CVPU4 4
CNSTU4 0
EQU4 $210
line 288
;288:				setColor = CG_FadeFromColorTo(hud[superhud].color, hud[superhud].fade, cg.crosshairClientTime, hud[superhud].time);
ADDRLP4 164
CNSTI4 504
ADDRFP4 40
INDIRI4
MULI4
ASGNI4
ADDRLP4 164
INDIRI4
ADDRGP4 hud+68
ADDP4
ARGP4
ADDRLP4 164
INDIRI4
ADDRGP4 hud+100
ADDP4
ARGP4
ADDRGP4 cg+130552
INDIRI4
ARGI4
ADDRLP4 164
INDIRI4
ADDRGP4 hud+168
ADDP4
INDIRI4
ARGI4
ADDRLP4 168
ADDRGP4 CG_FadeFromColorTo
CALLP4
ASGNP4
ADDRFP4 12
ADDRLP4 168
INDIRP4
ASGNP4
line 289
;289:			}
line 290
;290:		} else if ( hud[superhud].element == AttackerName ) {
ADDRGP4 $210
JUMPV
LABELV $209
CNSTI4 504
ADDRFP4 40
INDIRI4
MULI4
ADDRGP4 hud+44
ADDP4
INDIRI4
CNSTI4 5
NEI4 $219
line 291
;291:			if ( hud[superhud].fade ) {
CNSTI4 504
ADDRFP4 40
INDIRI4
MULI4
ADDRGP4 hud+100
ADDP4
CVPU4 4
CNSTU4 0
EQU4 $222
line 292
;292:				setColor = CG_FadeFromColorTo(hud[superhud].color, hud[superhud].fade, cg.attackerTime, hud[superhud].time);
ADDRLP4 164
CNSTI4 504
ADDRFP4 40
INDIRI4
MULI4
ASGNI4
ADDRLP4 164
INDIRI4
ADDRGP4 hud+68
ADDP4
ARGP4
ADDRLP4 164
INDIRI4
ADDRGP4 hud+100
ADDP4
ARGP4
ADDRGP4 cg+130564
INDIRI4
ARGI4
ADDRLP4 164
INDIRI4
ADDRGP4 hud+168
ADDP4
INDIRI4
ARGI4
ADDRLP4 168
ADDRGP4 CG_FadeFromColorTo
CALLP4
ASGNP4
ADDRFP4 12
ADDRLP4 168
INDIRP4
ASGNP4
line 293
;293:			}
LABELV $222
line 294
;294:		}
LABELV $219
LABELV $210
LABELV $200
LABELV $190
line 296
;295:
;296:		if ( hud[superhud].textalign == 0 ) {
CNSTI4 504
ADDRFP4 40
INDIRI4
MULI4
ADDRGP4 hud+174
ADDP4
INDIRU1
CVUI4 1
CNSTI4 0
NEI4 $229
line 298
;297:			//align right
;298:			x = (hud[superhud].rect[0] + hud[superhud].rect[2]) - w;
ADDRLP4 164
CNSTI4 504
ADDRFP4 40
INDIRI4
MULI4
ASGNI4
ADDRFP4 0
ADDRLP4 164
INDIRI4
ADDRGP4 hud+144
ADDP4
INDIRI4
ADDRLP4 164
INDIRI4
ADDRGP4 hud+144+8
ADDP4
INDIRI4
ADDI4
ADDRLP4 156
INDIRI4
SUBI4
ASGNI4
line 299
;299:		} else if ( hud[superhud].textalign == 1 ) {
ADDRGP4 $230
JUMPV
LABELV $229
CNSTI4 504
ADDRFP4 40
INDIRI4
MULI4
ADDRGP4 hud+174
ADDP4
INDIRU1
CVUI4 1
CNSTI4 1
NEI4 $235
line 301
;300:			//align center
;301:			x = hud[superhud].rect[0] + (hud[superhud].rect[2] * .5) - (w * .5);
ADDRLP4 164
CNSTI4 504
ADDRFP4 40
INDIRI4
MULI4
ASGNI4
ADDRLP4 168
CNSTF4 1056964608
ASGNF4
ADDRFP4 0
ADDRLP4 164
INDIRI4
ADDRGP4 hud+144
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 168
INDIRF4
ADDRLP4 164
INDIRI4
ADDRGP4 hud+144+8
ADDP4
INDIRI4
CVIF4 4
MULF4
ADDF4
ADDRLP4 168
INDIRF4
ADDRLP4 156
INDIRI4
CVIF4 4
MULF4
SUBF4
CVFI4 4
ASGNI4
line 302
;302:		} else {
ADDRGP4 $236
JUMPV
LABELV $235
line 304
;303:			//align left
;304:			x = hud[superhud].rect[0];
ADDRFP4 0
CNSTI4 504
ADDRFP4 40
INDIRI4
MULI4
ADDRGP4 hud+144
ADDP4
INDIRI4
ASGNI4
line 305
;305:		}
LABELV $236
LABELV $230
line 306
;306:	}
LABELV $168
LABELV $167
line 309
;307:
;308:	// draw the drop shadow
;309:	nameLength[0] = nameLength[1] = 0;
ADDRLP4 156
CNSTI4 0
ASGNI4
ADDRLP4 100+4
ADDRLP4 156
INDIRI4
ASGNI4
ADDRLP4 100
ADDRLP4 156
INDIRI4
ASGNI4
line 310
;310:	if (shadow) {
ADDRFP4 20
INDIRI4
CNSTI4 0
EQI4 $243
line 311
;311:		color[0] = color[1] = color[2] = 0;
ADDRLP4 160
CNSTF4 0
ASGNF4
ADDRLP4 108+8
ADDRLP4 160
INDIRF4
ASGNF4
ADDRLP4 108+4
ADDRLP4 160
INDIRF4
ASGNF4
ADDRLP4 108
ADDRLP4 160
INDIRF4
ASGNF4
line 312
;312:		color[3] = setColor[3];
ADDRLP4 108+12
ADDRFP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 313
;313:		trap_R_SetColor( color );
ADDRLP4 108
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 314
;314:		s = string;
ADDRLP4 0
ADDRFP4 8
INDIRP4
ASGNP4
line 315
;315:		xx = x;
ADDRLP4 92
ADDRFP4 0
INDIRI4
ASGNI4
line 316
;316:		cnt = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $249
JUMPV
LABELV $248
line 317
;317:		while ( *s && cnt < maxChars) {
line 318
;318:			if ( Q_IsColorString( s ) ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $251
ADDRLP4 168
CNSTI4 94
ASGNI4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 168
INDIRI4
NEI4 $251
ADDRLP4 172
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
EQI4 $251
ADDRLP4 172
INDIRI4
ADDRLP4 168
INDIRI4
EQI4 $251
line 319
;319:				s += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 320
;320:				cnt += 2;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 321
;321:				if((*s == ':') && Q_IsColorString( s+1 ))
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 58
NEI4 $253
ADDRLP4 180
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 180
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $253
ADDRLP4 184
CNSTI4 94
ASGNI4
ADDRLP4 180
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 184
INDIRI4
NEI4 $253
ADDRLP4 188
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 188
INDIRI4
CNSTI4 0
EQI4 $253
ADDRLP4 188
INDIRI4
ADDRLP4 184
INDIRI4
EQI4 $253
line 322
;322:				{
line 323
;323:					s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 324
;324:					cnt++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 325
;325:				} 
ADDRGP4 $249
JUMPV
LABELV $253
line 326
;326:				else if((*s  == ',') && Q_IsColorString( s+1 ) && !isStaticFade )
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 44
NEI4 $249
ADDRLP4 196
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 196
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $249
ADDRLP4 200
CNSTI4 94
ASGNI4
ADDRLP4 196
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 200
INDIRI4
NEI4 $249
ADDRLP4 204
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 208
CNSTI4 0
ASGNI4
ADDRLP4 204
INDIRI4
ADDRLP4 208
INDIRI4
EQI4 $249
ADDRLP4 204
INDIRI4
ADDRLP4 200
INDIRI4
EQI4 $249
ADDRLP4 96
INDIRI4
ADDRLP4 208
INDIRI4
NEI4 $249
line 327
;327:				{
line 329
;328:					//This means we'll be fading across the name.
;329:					isStaticFade = qtrue;
ADDRLP4 96
CNSTI4 1
ASGNI4
line 330
;330:					s += 3;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 3
ADDP4
ASGNP4
line 331
;331:					cnt += 3;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 3
ADDI4
ASGNI4
line 332
;332:					if((*s  == ',') && Q_IsColorString( s+1 ) )
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 44
NEI4 $249
ADDRLP4 216
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 216
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $249
ADDRLP4 220
CNSTI4 94
ASGNI4
ADDRLP4 216
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 220
INDIRI4
NEI4 $249
ADDRLP4 224
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 224
INDIRI4
CNSTI4 0
EQI4 $249
ADDRLP4 224
INDIRI4
ADDRLP4 220
INDIRI4
EQI4 $249
line 333
;333:					{
line 335
;334:						//This means we'll be fading across the name.
;335:						s += 3;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 3
ADDP4
ASGNP4
line 336
;336:						cnt += 3;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 3
ADDI4
ASGNI4
line 337
;337:					}
line 338
;338:				}
line 339
;339:				continue;
ADDRGP4 $249
JUMPV
LABELV $251
line 341
;340:			}
;341:			if ( isStaticFade ) {
ADDRLP4 96
INDIRI4
CNSTI4 0
EQI4 $259
line 342
;342:				if (*s == ' ' || !*s) {
ADDRLP4 176
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 32
EQI4 $263
ADDRLP4 176
INDIRI4
CNSTI4 0
NEI4 $261
LABELV $263
line 343
;343:					isStaticFade = qfalse;
ADDRLP4 96
CNSTI4 0
ASGNI4
line 345
;344:					//nameLength -= 2;
;345:				} else {
ADDRGP4 $262
JUMPV
LABELV $261
line 346
;346:					nameLength[0]++;
ADDRLP4 100
ADDRLP4 100
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 347
;347:				}
LABELV $262
line 348
;348:			}
LABELV $259
line 350
;349:
;350:			if ( !(*s) ) { //FIXME: Hack
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $264
line 351
;351:				break;
ADDRGP4 $250
JUMPV
LABELV $264
line 353
;352:			}
;353:			if ( superhud && (hud[superhud].offset[0] || hud[superhud].offset[1]) ) {
ADDRLP4 176
ADDRFP4 40
INDIRI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 0
EQI4 $266
ADDRLP4 180
CNSTI4 504
ADDRLP4 176
INDIRI4
MULI4
ASGNI4
ADDRLP4 184
CNSTF4 0
ASGNF4
ADDRLP4 180
INDIRI4
ADDRGP4 hud+132
ADDP4
INDIRF4
ADDRLP4 184
INDIRF4
NEF4 $271
ADDRLP4 180
INDIRI4
ADDRGP4 hud+132+4
ADDP4
INDIRF4
ADDRLP4 184
INDIRF4
EQF4 $266
LABELV $271
line 354
;354:				CG_DrawChar( xx + hud[superhud].offset[0], y + hud[superhud].offset[1], charWidth, charHeight, *s, altFont, superhud );
ADDRLP4 188
ADDRFP4 40
INDIRI4
ASGNI4
ADDRLP4 192
CNSTI4 504
ADDRLP4 188
INDIRI4
MULI4
ASGNI4
ADDRLP4 92
INDIRI4
CVIF4 4
ADDRLP4 192
INDIRI4
ADDRGP4 hud+132
ADDP4
INDIRF4
ADDF4
CVFI4 4
ARGI4
ADDRFP4 4
INDIRI4
CVIF4 4
ADDRLP4 192
INDIRI4
ADDRGP4 hud+132+4
ADDP4
INDIRF4
ADDF4
CVFI4 4
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRFP4 28
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRFP4 36
INDIRI4
ARGI4
ADDRLP4 188
INDIRI4
ARGI4
ADDRGP4 CG_DrawChar
CALLV
pop
line 355
;355:			} else {
ADDRGP4 $267
JUMPV
LABELV $266
line 356
;356:				CG_DrawChar( xx + ch_shadowOffset.integer, y + ch_shadowOffset.integer, charWidth, charHeight, *s, altFont, superhud );
ADDRLP4 92
INDIRI4
ADDRGP4 ch_shadowOffset+12
INDIRI4
ADDI4
ARGI4
ADDRFP4 4
INDIRI4
ADDRGP4 ch_shadowOffset+12
INDIRI4
ADDI4
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRFP4 28
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRFP4 36
INDIRI4
ARGI4
ADDRFP4 40
INDIRI4
ARGI4
ADDRGP4 CG_DrawChar
CALLV
pop
line 357
;357:			}
LABELV $267
line 358
;358:			cnt++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 359
;359:			xx += charWidth;
ADDRLP4 92
ADDRLP4 92
INDIRI4
ADDRFP4 24
INDIRI4
ADDI4
ASGNI4
line 360
;360:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 361
;361:		}
LABELV $249
line 317
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $277
ADDRLP4 4
INDIRI4
ADDRFP4 32
INDIRI4
LTI4 $248
LABELV $277
LABELV $250
line 362
;362:	}
LABELV $243
line 365
;363:
;364:	//CG_Printf("%i\n", nameLength);
;365:	nameLength[0]--;
ADDRLP4 100
ADDRLP4 100
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 367
;366:	// draw the colored text
;367:	s = string;
ADDRLP4 0
ADDRFP4 8
INDIRP4
ASGNP4
line 368
;368:	xx = x;
ADDRLP4 92
ADDRFP4 0
INDIRI4
ASGNI4
line 369
;369:	cnt = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 371
;370:////XXX############## CHANGE START
;371:	memcpy(fadeColors[0], setColor, sizeof(vec4_t));
ADDRLP4 8
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $279
JUMPV
LABELV $278
line 375
;372://	trap_R_SetColor( setColor );
;373:	//Evo's fade hack hacked even further by spike
;374:	while(*s && (cnt < maxChars))
;375:	{
line 377
;376://		if ( Q_IsColorString( s ) )
;377:		if(*s == '^')
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $281
line 378
;378:		{
line 380
;379:			//change color
;380:			cnt_colors = 0;
ADDRLP4 88
CNSTI4 0
ASGNI4
line 381
;381:			memcpy(fadeColors[cnt_colors], g_color_table[ColorIndex(*(s + 1))], sizeof(vec4_t));
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 160
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 164
CNSTI4 4
ASGNI4
ADDRLP4 88
INDIRI4
ADDRLP4 164
INDIRI4
LSHI4
ADDRLP4 8
ADDP4
ARGP4
ADDRLP4 160
INDIRI4
ADDRLP4 164
INDIRI4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 382
;382:			cnt_colors++;
ADDRLP4 88
ADDRLP4 88
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 383
;383:			s += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 384
;384:			cnt += 2;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 387
;385:
;386://			if ( (*s == ':') && Q_IsColorString( s+1 ) )
;387:			if((*s == ':') && (*(s + 1) == '^'))
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 58
NEI4 $283
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $283
line 388
;388:			{
line 390
;389:				//this means fade to the next color specified (if specified)
;390:				memcpy(fadeColors[cnt_colors], g_color_table[ColorIndex(*(s + 2))], sizeof(vec4_t));
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 172
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 176
CNSTI4 4
ASGNI4
ADDRLP4 88
INDIRI4
ADDRLP4 176
INDIRI4
LSHI4
ADDRLP4 8
ADDP4
ARGP4
ADDRLP4 172
INDIRI4
ADDRLP4 176
INDIRI4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 391
;391:				cnt_colors++;
ADDRLP4 88
ADDRLP4 88
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 392
;392:				s += 3;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 3
ADDP4
ASGNP4
line 393
;393:				cnt += 3;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 3
ADDI4
ASGNI4
line 395
;394:				//cnt++; //for continue
;395:				continue;
ADDRGP4 $279
JUMPV
LABELV $283
line 397
;396:			}
;397:			else if((*s  == ',') && (*(s + 1) == '^') && cnt_colors < 3  )
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 44
NEI4 $285
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $285
ADDRLP4 88
INDIRI4
CNSTI4 3
GEI4 $285
line 398
;398:			{
line 400
;399:				//This means we'll be fading across the name.
;400:				if (nameLength[0] > 2) {
ADDRLP4 100
INDIRI4
CNSTI4 2
LEI4 $286
line 401
;401:					isStaticFade = qtrue;
ADDRLP4 96
CNSTI4 1
ASGNI4
line 402
;402:					memcpy(fadeColors[cnt_colors], g_color_table[ColorIndex(*(s + 2))], sizeof(vec4_t));
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 176
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 180
CNSTI4 4
ASGNI4
ADDRLP4 88
INDIRI4
ADDRLP4 180
INDIRI4
LSHI4
ADDRLP4 8
ADDP4
ARGP4
ADDRLP4 176
INDIRI4
ADDRLP4 180
INDIRI4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 404
;403:					//
;404:					fadeColors[3][0] = (fadeColors[0][0] - fadeColors[1][0]) / nameLength[0];
ADDRLP4 8+48
ADDRLP4 8
INDIRF4
ADDRLP4 8+16
INDIRF4
SUBF4
ADDRLP4 100
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 405
;405:					fadeColors[3][1] = (fadeColors[0][1] - fadeColors[1][1]) / nameLength[0];
ADDRLP4 8+48+4
ADDRLP4 8+4
INDIRF4
ADDRLP4 8+16+4
INDIRF4
SUBF4
ADDRLP4 100
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 406
;406:					fadeColors[3][2] = (fadeColors[0][2] - fadeColors[1][2]) / nameLength[0];
ADDRLP4 8+48+8
ADDRLP4 8+8
INDIRF4
ADDRLP4 8+16+8
INDIRF4
SUBF4
ADDRLP4 100
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 408
;407:					//
;408:					cnt_colors++;
ADDRLP4 88
ADDRLP4 88
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 409
;409:					s += 3;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 3
ADDP4
ASGNP4
line 410
;410:					cnt += 3;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 3
ADDI4
ASGNI4
line 411
;411:					if((*s  == ',') && (*(s + 1) == '^') && cnt_colors < 3  )
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 44
NEI4 $279
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $279
ADDRLP4 88
INDIRI4
CNSTI4 3
GEI4 $279
line 412
;412:					{
line 414
;413:						//This means we'll be fading across the name.
;414:						if (cnt_colors == 2) {
ADDRLP4 88
INDIRI4
CNSTI4 2
NEI4 $279
line 415
;415:							isStaticFade = qtrue;
ADDRLP4 96
CNSTI4 1
ASGNI4
line 416
;416:							memcpy(fadeColors[cnt_colors], g_color_table[ColorIndex(*(s + 2))], sizeof(vec4_t));
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 188
ADDRGP4 ColorIndex
CALLI4
ASGNI4
ADDRLP4 192
CNSTI4 4
ASGNI4
ADDRLP4 88
INDIRI4
ADDRLP4 192
INDIRI4
LSHI4
ADDRLP4 8
ADDP4
ARGP4
ADDRLP4 188
INDIRI4
ADDRLP4 192
INDIRI4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 419
;417:							//
;418:							//CG_Printf("%i %i -- ", nameLength[0], nameLength[1]);
;419:							nameLength[1] = (nameLength[0] % 2) + (nameLength[0] * .5);
ADDRLP4 196
ADDRLP4 100
INDIRI4
ASGNI4
ADDRLP4 100+4
ADDRLP4 196
INDIRI4
CNSTI4 2
MODI4
CVIF4 4
CNSTF4 1056964608
ADDRLP4 196
INDIRI4
CVIF4 4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 420
;420:							nameLength[0] -= nameLength[1];
ADDRLP4 100
ADDRLP4 100
INDIRI4
ADDRLP4 100+4
INDIRI4
SUBI4
ASGNI4
line 422
;421:							//CG_Printf("%i %i\n", nameLength[0], nameLength[1]);
;422:							fadeColors[3][0] = (fadeColors[0][0] - fadeColors[1][0]) / nameLength[1];
ADDRLP4 8+48
ADDRLP4 8
INDIRF4
ADDRLP4 8+16
INDIRF4
SUBF4
ADDRLP4 100+4
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 423
;423:							fadeColors[3][1] = (fadeColors[0][1] - fadeColors[1][1]) / nameLength[1];
ADDRLP4 8+48+4
ADDRLP4 8+4
INDIRF4
ADDRLP4 8+16+4
INDIRF4
SUBF4
ADDRLP4 100+4
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 424
;424:							fadeColors[3][2] = (fadeColors[0][2] - fadeColors[1][2]) / nameLength[1];
ADDRLP4 8+48+8
ADDRLP4 8+8
INDIRF4
ADDRLP4 8+16+8
INDIRF4
SUBF4
ADDRLP4 100+4
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 425
;425:							fadeColors[4][0] = (fadeColors[1][0] - fadeColors[2][0]) / nameLength[0];
ADDRLP4 8+64
ADDRLP4 8+16
INDIRF4
ADDRLP4 8+32
INDIRF4
SUBF4
ADDRLP4 100
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 426
;426:							fadeColors[4][1] = (fadeColors[1][1] - fadeColors[2][1]) / nameLength[0];
ADDRLP4 8+64+4
ADDRLP4 8+16+4
INDIRF4
ADDRLP4 8+32+4
INDIRF4
SUBF4
ADDRLP4 100
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 427
;427:							fadeColors[4][2] = (fadeColors[1][2] - fadeColors[2][2]) / nameLength[0];
ADDRLP4 8+64+8
ADDRLP4 8+16+8
INDIRF4
ADDRLP4 8+32+8
INDIRF4
SUBF4
ADDRLP4 100
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 429
;428:							//
;429:							cnt_colors++;
ADDRLP4 88
ADDRLP4 88
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 430
;430:							s += 3;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 3
ADDP4
ASGNP4
line 431
;431:							cnt += 3;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 3
ADDI4
ASGNI4
line 432
;432:						}
line 433
;433:					}
line 434
;434:					continue;
ADDRGP4 $279
JUMPV
line 436
;435:				}
;436:			}
LABELV $285
line 437
;437:			else if(*s == '\0')
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $279
line 438
;438:				break;
ADDRGP4 $280
JUMPV
line 440
;439:			else
;440:				continue;
LABELV $286
line 441
;441:		}
LABELV $281
line 443
;442:
;443:		if(!forceColor)
ADDRFP4 16
INDIRI4
CNSTI4 0
NEI4 $339
line 444
;444:		{
line 445
;445:			if(cg_fontFade.integer && (cnt_colors > 1))
ADDRGP4 cg_fontFade+12
INDIRI4
CNSTI4 0
EQI4 $341
ADDRLP4 88
INDIRI4
CNSTI4 1
LEI4 $341
line 446
;446:			{
line 448
;447:				//CG_Printf("cnt_colors: %i\n", cnt_colors);
;448:				if ( !isStaticFade ) {
ADDRLP4 96
INDIRI4
CNSTI4 0
NEI4 $344
line 450
;449:					//fade
;450:					CG_GetFadeTime();
ADDRGP4 CG_GetFadeTime
CALLI4
pop
line 451
;451:					num_state = fadeTime / FADE_RATE;
ADDRLP4 132
ADDRGP4 fadeTime
INDIRI4
CNSTI4 1300
DIVI4
ASGNI4
line 452
;452:					state = num_state % 4;
ADDRLP4 128
ADDRLP4 132
INDIRI4
CNSTI4 4
MODI4
ASGNI4
line 454
;453:
;454:					switch(state)
ADDRLP4 160
ADDRLP4 128
INDIRI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
LTI4 $340
ADDRLP4 160
INDIRI4
CNSTI4 3
GTI4 $340
ADDRLP4 160
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $389
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $389
address $348
address $365
address $367
address $388
code
line 455
;455:					{
LABELV $348
line 458
;456:						case 0:
;457:							//fade forward
;458:							rem = fadeTime % FADE_RATE;
ADDRLP4 140
ADDRGP4 fadeTime
INDIRI4
CNSTI4 1300
MODI4
ASGNI4
line 459
;459:							scale = (fadeColors[1][0] - fadeColors[0][0]) / (float)(FADE_RATE);
ADDRLP4 136
ADDRLP4 8+16
INDIRF4
ADDRLP4 8
INDIRF4
SUBF4
CNSTF4 1151500288
DIVF4
ASGNF4
line 460
;460:							color[0] = rem * scale + fadeColors[0][0];
ADDRLP4 108
ADDRLP4 140
INDIRI4
CVIF4 4
ADDRLP4 136
INDIRF4
MULF4
ADDRLP4 8
INDIRF4
ADDF4
ASGNF4
line 461
;461:							scale = (fadeColors[1][1] - fadeColors[0][1]) / (float)(FADE_RATE);
ADDRLP4 136
ADDRLP4 8+16+4
INDIRF4
ADDRLP4 8+4
INDIRF4
SUBF4
CNSTF4 1151500288
DIVF4
ASGNF4
line 462
;462:							color[1] = rem * scale + fadeColors[0][1];
ADDRLP4 108+4
ADDRLP4 140
INDIRI4
CVIF4 4
ADDRLP4 136
INDIRF4
MULF4
ADDRLP4 8+4
INDIRF4
ADDF4
ASGNF4
line 463
;463:							scale = (fadeColors[1][2] - fadeColors[0][2]) / (float)(FADE_RATE);
ADDRLP4 136
ADDRLP4 8+16+8
INDIRF4
ADDRLP4 8+8
INDIRF4
SUBF4
CNSTF4 1151500288
DIVF4
ASGNF4
line 464
;464:							color[2] = rem * scale + fadeColors[0][2];
ADDRLP4 108+8
ADDRLP4 140
INDIRI4
CVIF4 4
ADDRLP4 136
INDIRF4
MULF4
ADDRLP4 8+8
INDIRF4
ADDF4
ASGNF4
line 465
;465:							scale = (fadeColors[1][3] - fadeColors[0][3]) / (float)(FADE_RATE);
ADDRLP4 136
ADDRLP4 8+16+12
INDIRF4
ADDRLP4 8+12
INDIRF4
SUBF4
CNSTF4 1151500288
DIVF4
ASGNF4
line 466
;466:							color[3] = rem * scale + fadeColors[0][3];
ADDRLP4 108+12
ADDRLP4 140
INDIRI4
CVIF4 4
ADDRLP4 136
INDIRF4
MULF4
ADDRLP4 8+12
INDIRF4
ADDF4
ASGNF4
line 468
;467:
;468:							trap_R_SetColor(color);
ADDRLP4 108
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 469
;469:							break;
ADDRGP4 $340
JUMPV
LABELV $365
line 473
;470:
;471:						case 1:
;472:							//stay at color2
;473:							trap_R_SetColor(fadeColors[1]);
ADDRLP4 8+16
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 474
;474:							break;
ADDRGP4 $340
JUMPV
LABELV $367
line 478
;475:
;476:						case 2:
;477:							//fade backwards
;478:							rem = fadeTime % FADE_RATE;
ADDRLP4 140
ADDRGP4 fadeTime
INDIRI4
CNSTI4 1300
MODI4
ASGNI4
line 479
;479:							scale = (fadeColors[0][0] - fadeColors[1][0]) / (float)(FADE_RATE);
ADDRLP4 136
ADDRLP4 8
INDIRF4
ADDRLP4 8+16
INDIRF4
SUBF4
CNSTF4 1151500288
DIVF4
ASGNF4
line 480
;480:							color[0] = rem * scale + fadeColors[1][0];
ADDRLP4 108
ADDRLP4 140
INDIRI4
CVIF4 4
ADDRLP4 136
INDIRF4
MULF4
ADDRLP4 8+16
INDIRF4
ADDF4
ASGNF4
line 481
;481:							scale = (fadeColors[0][1] - fadeColors[1][1]) / (float)(FADE_RATE);
ADDRLP4 136
ADDRLP4 8+4
INDIRF4
ADDRLP4 8+16+4
INDIRF4
SUBF4
CNSTF4 1151500288
DIVF4
ASGNF4
line 482
;482:							color[1] = rem * scale + fadeColors[1][1];
ADDRLP4 108+4
ADDRLP4 140
INDIRI4
CVIF4 4
ADDRLP4 136
INDIRF4
MULF4
ADDRLP4 8+16+4
INDIRF4
ADDF4
ASGNF4
line 483
;483:							scale = (fadeColors[0][2] - fadeColors[1][2]) / (float)(FADE_RATE);
ADDRLP4 136
ADDRLP4 8+8
INDIRF4
ADDRLP4 8+16+8
INDIRF4
SUBF4
CNSTF4 1151500288
DIVF4
ASGNF4
line 484
;484:							color[2] = rem * scale + fadeColors[1][2];
ADDRLP4 108+8
ADDRLP4 140
INDIRI4
CVIF4 4
ADDRLP4 136
INDIRF4
MULF4
ADDRLP4 8+16+8
INDIRF4
ADDF4
ASGNF4
line 485
;485:							scale = (fadeColors[0][3] - fadeColors[1][3]) / (float)(FADE_RATE);
ADDRLP4 136
ADDRLP4 8+12
INDIRF4
ADDRLP4 8+16+12
INDIRF4
SUBF4
CNSTF4 1151500288
DIVF4
ASGNF4
line 486
;486:							color[3] = rem * scale + fadeColors[1][3];
ADDRLP4 108+12
ADDRLP4 140
INDIRI4
CVIF4 4
ADDRLP4 136
INDIRF4
MULF4
ADDRLP4 8+16+12
INDIRF4
ADDF4
ASGNF4
line 488
;487:
;488:							trap_R_SetColor(color);
ADDRLP4 108
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 489
;489:							break;
ADDRGP4 $340
JUMPV
LABELV $388
line 493
;490:
;491:						case 3:
;492:							//stay at color1
;493:							trap_R_SetColor(fadeColors[0]);
ADDRLP4 8
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 494
;494:							break;
line 496
;495:					}
;496:				} else {
ADDRGP4 $340
JUMPV
LABELV $344
line 498
;497:					//CG_Printf("DBG: %i > %i\n", nameCnt, nameLength[1]);
;498:					if ( nameCnt >= nameLength[1] && nameLength[1] != 0) {
ADDRLP4 124
INDIRI4
ADDRLP4 100+4
INDIRI4
LTI4 $390
ADDRLP4 100+4
INDIRI4
CNSTI4 0
EQI4 $390
line 499
;499:						trap_R_SetColor(fadeColors[0]);
ADDRLP4 8
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 500
;500:							fadeColors[0][0] -= fadeColors[4][0];
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 8+64
INDIRF4
SUBF4
ASGNF4
line 501
;501:							fadeColors[0][1] -= fadeColors[4][1];
ADDRLP4 8+4
ADDRLP4 8+4
INDIRF4
ADDRLP4 8+64+4
INDIRF4
SUBF4
ASGNF4
line 502
;502:							fadeColors[0][2] -= fadeColors[4][2];
ADDRLP4 8+8
ADDRLP4 8+8
INDIRF4
ADDRLP4 8+64+8
INDIRF4
SUBF4
ASGNF4
line 506
;503:							//CG_Printf("4:%2.2f %2.2f %2.2f %2.2f %2.2f %2.2f\n", 
;504:								//fadeColors[0][0], fadeColors[0][1], fadeColors[0][2],
;505:								//fadeColors[4][0], fadeColors[4][1], fadeColors[4][2]);
;506:					} else {
ADDRGP4 $391
JUMPV
LABELV $390
line 507
;507:						trap_R_SetColor(fadeColors[0]);
ADDRLP4 8
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 508
;508:							fadeColors[0][0] -= fadeColors[3][0];
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 8+48
INDIRF4
SUBF4
ASGNF4
line 509
;509:							fadeColors[0][1] -= fadeColors[3][1];
ADDRLP4 8+4
ADDRLP4 8+4
INDIRF4
ADDRLP4 8+48+4
INDIRF4
SUBF4
ASGNF4
line 510
;510:							fadeColors[0][2] -= fadeColors[3][2];
ADDRLP4 8+8
ADDRLP4 8+8
INDIRF4
ADDRLP4 8+48+8
INDIRF4
SUBF4
ASGNF4
line 514
;511:							//CG_Printf("3:%2.2f %2.2f %2.2f %2.2f %2.2f %2.2f\n", 
;512:								//fadeColors[0][0], fadeColors[0][1], fadeColors[0][2],
;513:								//fadeColors[3][0], fadeColors[3][1], fadeColors[3][2]);
;514:					}
LABELV $391
line 515
;515:					nameCnt++;
ADDRLP4 124
ADDRLP4 124
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 516
;516:				}
line 517
;517:			}
ADDRGP4 $340
JUMPV
LABELV $341
line 519
;518:			else
;519:			{
line 521
;520:				//solid color
;521:				trap_R_SetColor(fadeColors[0]);
ADDRLP4 8
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 522
;522:			}
line 523
;523:		}
ADDRGP4 $340
JUMPV
LABELV $339
line 525
;524:		else
;525:		{
line 527
;526:			//force color
;527:			trap_R_SetColor(setColor);
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 528
;528:		}
LABELV $340
line 530
;529:
;530:		if ( (*s) ) { //FIXME: Hack
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $280
line 531
;531:			CG_DrawChar(xx, y, charWidth, charHeight, *s, altFont, superhud);
ADDRLP4 92
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRFP4 28
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRFP4 36
INDIRI4
ARGI4
ADDRFP4 40
INDIRI4
ARGI4
ADDRGP4 CG_DrawChar
CALLV
pop
line 532
;532:			xx += charWidth;
ADDRLP4 92
ADDRLP4 92
INDIRI4
ADDRFP4 24
INDIRI4
ADDI4
ASGNI4
line 533
;533:		}
line 535
;534:		else
;535:			break;
LABELV $409
line 537
;536:
;537:		cnt++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 538
;538:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 539
;539:	}
LABELV $279
line 374
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $410
ADDRLP4 4
INDIRI4
ADDRFP4 32
INDIRI4
LTI4 $278
LABELV $410
LABELV $280
line 624
;540:
;541:#if 0
;542:	//Evo: Fade Hack
;543:	if ( cg_fontFade.integer ) {
;544:		nameLength = strlen(Q_CleanStr((char *)s));
;545:
;546:		while ( Q_IsColorString( s ) ) {
;547:			CG_Printf("cg_fontFade %s %i %i\n", s, cnt_colors, nameLength);
;548:			memcpy( fadeColors[cnt_colors], g_color_table[ColorIndex(*(s+1))], sizeof( fadeColors ) );
;549:			cnt_colors++;
;550:			s += 2;
;551:			if ( *s == '-' ) {
;552:				s++;
;553:			} else {
;554:				CG_Printf("%s\n", s);
;555:				break;
;556:			}
;557:
;558:			if ( cnt_colors == 2 )
;559:				break;
;560:		}
;561:
;562:		switch(cnt_colors)
;563:		{
;564:			case 2:
;565:				break;
;566:
;567:			case 3:
;568:				break;
;569:		}
;570:
;571:		if ( cnt_colors > 1 ) {		
;572:			CG_Printf("cnt_colors: %i -- %i\n", cnt_colors, nameLength);
;573:			if ( cnt_colors == 3 ) {
;574:				CG_Printf("== 3\n");
;575:				nameLength *= .5;
;576:				fadeColors[3][0] = (fadeColors[0][0] - fadeColors[1][0]) / nameLength;
;577:				fadeColors[3][1] = (fadeColors[0][1] - fadeColors[1][1]) / nameLength;
;578:				fadeColors[3][2] = (fadeColors[0][2] - fadeColors[1][2]) / nameLength;
;579:				fadeColors[4][0] = (fadeColors[1][0] - fadeColors[2][0]) / nameLength;
;580:				fadeColors[4][1] = (fadeColors[1][1] - fadeColors[2][1]) / nameLength;
;581:				fadeColors[4][2] = (fadeColors[1][2] - fadeColors[2][2]) / nameLength;
;582:			} else {
;583:				CG_Printf("else\n");
;584:				fadeColors[3][0] = (fadeColors[0][0] - fadeColors[1][0]) / nameLength;
;585:				fadeColors[3][1] = (fadeColors[0][1] - fadeColors[1][1]) / nameLength;
;586:				fadeColors[3][2] = (fadeColors[0][2] - fadeColors[1][2]) / nameLength;
;587:			}
;588:			memcpy( color, fadeColors[0], sizeof( color ) );
;589:		}
;590:	}
;591:	//Evo: Fade Hack
;592:
;593:	while ( *s && cnt < maxChars) {
;594:		if ( Q_IsColorString( s ) ) {
;595:			if ( !forceColor ) {
;596:				if ( cg_fontFade.integer && cnt_colors > 1 ) {
;597:					//CG_Printf("cnt_colors: %i -- %i\n", cnt_colors, nameLength);
;598:					if ( cnt > nameLength ) {
;599:						memcpy( color, fadeColors[0], sizeof( color ) );
;600:						fadeColors[0][0] -= fadeColors[4][0];
;601:						fadeColors[0][1] -= fadeColors[4][1];
;602:						fadeColors[0][2] -= fadeColors[4][2];
;603:					} else {
;604:						fadeColors[0][0] -= fadeColors[3][0];
;605:						fadeColors[0][1] -= fadeColors[3][1];
;606:						fadeColors[0][2] -= fadeColors[3][2];
;607:					}
;608:				} else {
;609:					memcpy( color, g_color_table[ColorIndex(*(s+1))], sizeof( color ) );
;610://				}
;611:				color[3] = setColor[3];
;612:				trap_R_SetColor( color );
;613:			}
;614:			s += 2;
;615:			continue;
;616:		}
;617:		CG_DrawChar( xx, y, charWidth, charHeight, *s, altFont, superhud );
;618:		xx += charWidth;
;619:		cnt++;
;620:		s++;
;621:	}
;622:#endif
;623:////XXX############## CHANGE END
;624:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 625
;625:}
LABELV $163
endproc CG_DrawStringExt 228 28
export CG_DrawBigString
proc CG_DrawBigString 28 44
line 628
;626://Superhud - End
;627:
;628:void CG_DrawBigString( int x, int y, const char *s, float alpha ) {
line 631
;629:	float	color[4];
;630:
;631:	color[0] = color[1] = color[2] = 1.0;
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
ADDRLP4 0+8
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 632
;632:	color[3] = alpha;
ADDRLP4 0+12
ADDRFP4 12
INDIRF4
ASGNF4
line 633
;633:	CG_DrawStringExt( x, y, s, color, qfalse, qtrue, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 20
INDIRI4
ARGI4
CNSTI4 1
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
line 634
;634:}
LABELV $411
endproc CG_DrawBigString 28 44
export CG_DrawBigStringColor
proc CG_DrawBigStringColor 12 44
line 636
;635:
;636:void CG_DrawBigStringColor( int x, int y, const char *s, vec4_t color ) {
line 637
;637:	CG_DrawStringExt( x, y, s, color, qtrue, qtrue, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0, 0, 0 );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 0
CNSTI4 1
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
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 638
;638:}
LABELV $415
endproc CG_DrawBigStringColor 12 44
export CG_DrawSmallString
proc CG_DrawSmallString 24 44
line 640
;639:
;640:void CG_DrawSmallString( int x, int y, const char *s, float alpha ) {
line 643
;641:	float	color[4];
;642:
;643:	color[0] = color[1] = color[2] = 1.0;
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
ADDRLP4 0+8
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 644
;644:	color[3] = alpha;
ADDRLP4 0+12
ADDRFP4 12
INDIRF4
ASGNF4
line 645
;645:	CG_DrawStringExt( x, y, s, color, qfalse, qfalse, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0, 0, 0 );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
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
CNSTI4 8
ARGI4
CNSTI4 16
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
line 646
;646:}
LABELV $416
endproc CG_DrawSmallString 24 44
export CG_DrawSmallStringColor
proc CG_DrawSmallStringColor 4 44
line 648
;647:
;648:void CG_DrawSmallStringColor( int x, int y, const char *s, vec4_t color ) {
line 649
;649:	CG_DrawStringExt( x, y, s, color, qtrue, qfalse, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0, 0, 0 );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 8
ARGI4
CNSTI4 16
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
line 650
;650:}
LABELV $420
endproc CG_DrawSmallStringColor 4 44
export CG_DrawStrlen
proc CG_DrawStrlen 20 0
line 659
;651:
;652:/*
;653:=================
;654:CG_DrawStrlen
;655:
;656:Returns character count, skiping color escape codes
;657:=================
;658:*/
;659:int CG_DrawStrlen( const char *str ) {
line 660
;660:	const char *s = str;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 661
;661:	int count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $423
JUMPV
LABELV $422
line 663
;662:
;663:	while ( *s ) {
line 664
;664:		if ( Q_IsColorString( s ) ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $425
ADDRLP4 12
CNSTI4 94
ASGNI4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 12
INDIRI4
NEI4 $425
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $425
ADDRLP4 16
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $425
line 665
;665:			s += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 666
;666:		} else {
ADDRGP4 $426
JUMPV
LABELV $425
line 667
;667:			count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 668
;668:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 669
;669:		}
LABELV $426
line 670
;670:	}
LABELV $423
line 663
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $422
line 672
;671:
;672:	return count;
ADDRLP4 4
INDIRI4
RETI4
LABELV $421
endproc CG_DrawStrlen 20 0
proc CG_TileClearBox 16 36
line 683
;673:}
;674:
;675:/*
;676:=============
;677:CG_TileClearBox
;678:
;679:This repeats a 64*64 tile graphic to fill the screen around a sized down
;680:refresh window.
;681:=============
;682:*/
;683:static void CG_TileClearBox( int x, int y, int w, int h, qhandle_t hShader ) {
line 686
;684:	float	s1, t1, s2, t2;
;685:
;686:	s1 = x/64.0;
ADDRLP4 0
ADDRFP4 0
INDIRI4
CVIF4 4
CNSTF4 1115684864
DIVF4
ASGNF4
line 687
;687:	t1 = y/64.0;
ADDRLP4 4
ADDRFP4 4
INDIRI4
CVIF4 4
CNSTF4 1115684864
DIVF4
ASGNF4
line 688
;688:	s2 = (x+w)/64.0;
ADDRLP4 8
ADDRFP4 0
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
CVIF4 4
CNSTF4 1115684864
DIVF4
ASGNF4
line 689
;689:	t2 = (y+h)/64.0;
ADDRLP4 12
ADDRFP4 4
INDIRI4
ADDRFP4 12
INDIRI4
ADDI4
CVIF4 4
CNSTF4 1115684864
DIVF4
ASGNF4
line 690
;690:	trap_R_DrawStretchPic( x, y, w, h, s1, t1, s2, t2, hShader );
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
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 691
;691:}
LABELV $427
endproc CG_TileClearBox 16 36
export CG_TileClear
proc CG_TileClear 48 20
line 702
;692:
;693:
;694:
;695:/*
;696:==============
;697:CG_TileClear
;698:
;699:Clear around a sized down screen
;700:==============
;701:*/
;702:void CG_TileClear( void ) {
line 706
;703:	int		top, bottom, left, right;
;704:	int		w, h;
;705:
;706:	w = cgs.glconfig.vidWidth;
ADDRLP4 8
ADDRGP4 cgs+20100+11304
INDIRI4
ASGNI4
line 707
;707:	h = cgs.glconfig.vidHeight;
ADDRLP4 20
ADDRGP4 cgs+20100+11308
INDIRI4
ASGNI4
line 709
;708:
;709:	if ( cg.refdef.x == 0 && cg.refdef.y == 0 && 
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRGP4 cg+109048
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $433
ADDRGP4 cg+109048+4
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $433
ADDRGP4 cg+109048+8
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $433
ADDRGP4 cg+109048+12
INDIRI4
ADDRLP4 20
INDIRI4
NEI4 $433
line 710
;710:		cg.refdef.width == w && cg.refdef.height == h ) {
line 711
;711:		return;		// full screen rendering
ADDRGP4 $428
JUMPV
LABELV $433
line 714
;712:	}
;713:
;714:	top = cg.refdef.y;
ADDRLP4 0
ADDRGP4 cg+109048+4
INDIRI4
ASGNI4
line 715
;715:	bottom = top + cg.refdef.height-1;
ADDRLP4 4
ADDRLP4 0
INDIRI4
ADDRGP4 cg+109048+12
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ASGNI4
line 716
;716:	left = cg.refdef.x;
ADDRLP4 12
ADDRGP4 cg+109048
INDIRI4
ASGNI4
line 717
;717:	right = left + cg.refdef.width-1;
ADDRLP4 16
ADDRLP4 12
INDIRI4
ADDRGP4 cg+109048+8
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ASGNI4
line 720
;718:
;719:	// clear above view screen
;720:	CG_TileClearBox( 0, 0, w, top, cgs.media.backTileShader );
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 cgs+156680+324
INDIRI4
ARGI4
ADDRGP4 CG_TileClearBox
CALLV
pop
line 723
;721:
;722:	// clear below view screen
;723:	CG_TileClearBox( 0, bottom, w, h - bottom, cgs.media.backTileShader );
CNSTI4 0
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 20
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
ARGI4
ADDRGP4 cgs+156680+324
INDIRI4
ARGI4
ADDRGP4 CG_TileClearBox
CALLV
pop
line 726
;724:
;725:	// clear left of view screen
;726:	CG_TileClearBox( 0, top, left, bottom - top + 1, cgs.media.backTileShader );
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 cgs+156680+324
INDIRI4
ARGI4
ADDRGP4 CG_TileClearBox
CALLV
pop
line 729
;727:
;728:	// clear right of view screen
;729:	CG_TileClearBox( right, top, w - right, bottom - top + 1, cgs.media.backTileShader );
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ADDRLP4 16
INDIRI4
SUBI4
ARGI4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 cgs+156680+324
INDIRI4
ARGI4
ADDRGP4 CG_TileClearBox
CALLV
pop
line 730
;730:}
LABELV $428
endproc CG_TileClear 48 20
bss
align 4
LABELV $458
skip 16
export CG_FadeColor
code
proc CG_FadeColor 8 0
line 739
;731:
;732:
;733:
;734:/*
;735:================
;736:CG_FadeColor
;737:================
;738:*/
;739:float *CG_FadeColor( int startMsec, int totalMsec ) {
line 743
;740:	static vec4_t		color;
;741:	int			t;
;742:
;743:	if ( startMsec == 0 ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $459
line 744
;744:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $457
JUMPV
LABELV $459
line 747
;745:	}
;746:
;747:	t = cg.time - startMsec;
ADDRLP4 0
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 0
INDIRI4
SUBI4
ASGNI4
line 749
;748:
;749:	if ( t >= totalMsec ) {
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $462
line 750
;750:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $457
JUMPV
LABELV $462
line 754
;751:	}
;752:
;753:	// fade out
;754:	if ( totalMsec - t < FADE_TIME ) {
ADDRFP4 4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 200
GEI4 $464
line 755
;755:		color[3] = ( totalMsec - t ) * 1.0/FADE_TIME;
ADDRGP4 $458+12
CNSTF4 1065353216
ADDRFP4 4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CVIF4 4
MULF4
CNSTF4 1128792064
DIVF4
ASGNF4
line 756
;756:	} else {
ADDRGP4 $465
JUMPV
LABELV $464
line 757
;757:		color[3] = 1.0;
ADDRGP4 $458+12
CNSTF4 1065353216
ASGNF4
line 758
;758:	}
LABELV $465
line 759
;759:	color[0] = color[1] = color[2] = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
ADDRGP4 $458+8
ADDRLP4 4
INDIRF4
ASGNF4
ADDRGP4 $458+4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRGP4 $458
ADDRLP4 4
INDIRF4
ASGNF4
line 761
;760:
;761:	return color;
ADDRGP4 $458
RETP4
LABELV $457
endproc CG_FadeColor 8 0
bss
align 4
LABELV $471
skip 16
export CG_FadeFromColorTo
code
proc CG_FadeFromColorTo 24 12
line 771
;762:}
;763:
;764:/*
;765:================
;766:CG_FadeFromColorTo
;767:This is for the superhud fade color...
;768:The goal of this is to "fade" from one color to the next over a period of time.
;769:================
;770:*/
;771:float *CG_FadeFromColorTo( vec4_t startColor, vec4_t endColor, int startTime, int lengthTime ) {
line 775
;772:	static vec4_t		color;
;773:	int			timePassed, i;
;774:
;775:	if ( startTime == 0 ) {
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $472
line 776
;776:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $470
JUMPV
LABELV $472
line 779
;777:	}
;778:
;779:	timePassed = cg.time - startTime;
ADDRLP4 4
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 8
INDIRI4
SUBI4
ASGNI4
line 781
;780:
;781:	if ( timePassed >= lengthTime ) {
ADDRLP4 4
INDIRI4
ADDRFP4 12
INDIRI4
LTI4 $475
line 782
;782:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $470
JUMPV
LABELV $475
line 786
;783:	}
;784:
;785:	//fade to color
;786:	memcpy(color, startColor, sizeof(color) );
ADDRGP4 $471
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 789
;787:
;788:	//Begin Loop
;789:	for ( i = 0; i < 4; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $477
line 791
;790:		//determine which value is greater
;791:		if ( startColor[i] > endColor[i] ) {
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 8
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
LEF4 $481
line 799
;792:			//Find the difference
;793:			//Figure out how much change occurs
;794:			//subtract from color
;795:			//color[i] = ((startColor[i] - endColor[i]) / lengthTime) * timePassed;//Fade in
;796:			//color[i] = startColor[i] - (((startColor[i] - endColor[i]) / lengthTime) * (lengthTime - timePassed ));//Clean Fade in
;797:
;798:					  //Start color - totalDifferenceForTime
;799:			color[i] = startColor[i] - ( ( (startColor[i] - endColor[i]) / lengthTime ) * timePassed );
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 16
ADDRLP4 12
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 12
INDIRI4
ADDRGP4 $471
ADDP4
ADDRLP4 16
INDIRF4
ADDRLP4 16
INDIRF4
ADDRLP4 12
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
SUBF4
ADDRFP4 12
INDIRI4
CVIF4 4
DIVF4
ADDRLP4 4
INDIRI4
CVIF4 4
MULF4
SUBF4
ASGNF4
line 800
;800:		} else if ( startColor[i] < endColor[i] ) {
ADDRGP4 $482
JUMPV
LABELV $481
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 12
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
GEF4 $483
line 804
;801:			//Find the difference
;802:			//Figure out how much change occurs
;803:			//Add to color
;804:			color[i] = startColor[i] + ( ( (startColor[i] - endColor[i]) / lengthTime ) * timePassed );
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 20
ADDRLP4 16
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 16
INDIRI4
ADDRGP4 $471
ADDP4
ADDRLP4 20
INDIRF4
ADDRLP4 20
INDIRF4
ADDRLP4 16
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
SUBF4
ADDRFP4 12
INDIRI4
CVIF4 4
DIVF4
ADDRLP4 4
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 805
;805:		}
LABELV $483
LABELV $482
line 806
;806:	}
LABELV $478
line 789
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $477
line 810
;807:	//End loop
;808:
;809:	//Return the color
;810:	return color;
ADDRGP4 $471
RETP4
LABELV $470
endproc CG_FadeFromColorTo 24 12
data
align 4
LABELV $486
byte 4 1065353216
byte 4 1045220557
byte 4 1045220557
byte 4 1065353216
align 4
LABELV $487
byte 4 1045220557
byte 4 1045220557
byte 4 1065353216
byte 4 1065353216
align 4
LABELV $488
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
align 4
LABELV $489
byte 4 1060320051
byte 4 1060320051
byte 4 1060320051
byte 4 1065353216
export CG_TeamColor
code
proc CG_TeamColor 4 0
line 819
;811:}
;812:
;813:
;814:/*
;815:================
;816:CG_TeamColor
;817:================
;818:*/
;819:float *CG_TeamColor( int team ) {
line 825
;820:	static vec4_t	red = {1, 0.2f, 0.2f, 1};
;821:	static vec4_t	blue = {0.2f, 0.2f, 1, 1};
;822:	static vec4_t	other = {1, 1, 1, 1};
;823:	static vec4_t	spectator = {0.7f, 0.7f, 0.7f, 1};
;824:
;825:	switch ( team ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $492
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $493
ADDRLP4 0
INDIRI4
CNSTI4 3
EQI4 $494
ADDRGP4 $490
JUMPV
LABELV $492
line 827
;826:	case TEAM_RED:
;827:		return red;
ADDRGP4 $486
RETP4
ADDRGP4 $485
JUMPV
LABELV $493
line 829
;828:	case TEAM_BLUE:
;829:		return blue;
ADDRGP4 $487
RETP4
ADDRGP4 $485
JUMPV
LABELV $494
line 831
;830:	case TEAM_SPECTATOR:
;831:		return spectator;
ADDRGP4 $489
RETP4
ADDRGP4 $485
JUMPV
LABELV $490
line 833
;832:	default:
;833:		return other;
ADDRGP4 $488
RETP4
LABELV $485
endproc CG_TeamColor 4 0
export CG_GetColorForHealth
proc CG_GetColorForHealth 16 0
line 844
;834:	}
;835:}
;836:
;837:
;838:
;839:/*
;840:=================
;841:CG_GetColorForHealth
;842:=================
;843:*/
;844:void CG_GetColorForHealth( int health, int armor, vec4_t hcolor ) {
line 850
;845:	int		count;
;846:	int		max;
;847:
;848:	// calculate the total points of damage that can
;849:	// be sustained at the current health / armor level
;850:	if ( health <= 0 ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
GTI4 $496
line 851
;851:		VectorClear( hcolor );	// black
ADDRLP4 8
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 12
CNSTF4 0
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
ADDRLP4 12
INDIRF4
ASGNF4
line 852
;852:		hcolor[3] = 1;
ADDRFP4 8
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1065353216
ASGNF4
line 853
;853:		return;
ADDRGP4 $495
JUMPV
LABELV $496
line 855
;854:	}
;855:	count = armor;
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
line 856
;856:	max = health * ARMOR_PROTECTION / ( 1.0 - ARMOR_PROTECTION );
ADDRLP4 4
CNSTF4 1059648963
ADDRFP4 0
INDIRI4
CVIF4 4
MULF4
CNSTF4 1051595899
DIVF4
CVFI4 4
ASGNI4
line 857
;857:	if ( max < count ) {
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
GEI4 $498
line 858
;858:		count = max;
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 859
;859:	}
LABELV $498
line 860
;860:	health += count;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 863
;861:
;862:	// set the color based on health
;863:	hcolor[0] = 1.0;
ADDRFP4 8
INDIRP4
CNSTF4 1065353216
ASGNF4
line 864
;864:	hcolor[3] = 1.0;
ADDRFP4 8
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1065353216
ASGNF4
line 865
;865:	if ( health >= 100 ) {
ADDRFP4 0
INDIRI4
CNSTI4 100
LTI4 $500
line 866
;866:		hcolor[2] = 1.0;
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1065353216
ASGNF4
line 867
;867:	} else if ( health < 66 ) {
ADDRGP4 $501
JUMPV
LABELV $500
ADDRFP4 0
INDIRI4
CNSTI4 66
GEI4 $502
line 868
;868:		hcolor[2] = 0;
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 0
ASGNF4
line 869
;869:	} else {
ADDRGP4 $503
JUMPV
LABELV $502
line 870
;870:		hcolor[2] = ( health - 66 ) / 33.0;
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 0
INDIRI4
CNSTI4 66
SUBI4
CVIF4 4
CNSTF4 1107558400
DIVF4
ASGNF4
line 871
;871:	}
LABELV $503
LABELV $501
line 873
;872:
;873:	if ( health > 60 ) {
ADDRFP4 0
INDIRI4
CNSTI4 60
LEI4 $504
line 874
;874:		hcolor[1] = 1.0;
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 1065353216
ASGNF4
line 875
;875:	} else if ( health < 30 ) {
ADDRGP4 $505
JUMPV
LABELV $504
ADDRFP4 0
INDIRI4
CNSTI4 30
GEI4 $506
line 876
;876:		hcolor[1] = 0;
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 0
ASGNF4
line 877
;877:	} else {
ADDRGP4 $507
JUMPV
LABELV $506
line 878
;878:		hcolor[1] = ( health - 30 ) / 30.0;
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 0
INDIRI4
CNSTI4 30
SUBI4
CVIF4 4
CNSTF4 1106247680
DIVF4
ASGNF4
line 879
;879:	}
LABELV $507
LABELV $505
line 880
;880:}
LABELV $495
endproc CG_GetColorForHealth 16 0
export CG_ColorForHealth
proc CG_ColorForHealth 0 12
line 887
;881:
;882:/*
;883:=================
;884:CG_ColorForHealth
;885:=================
;886:*/
;887:void CG_ColorForHealth( vec4_t hcolor ) {
line 889
;888:
;889:	CG_GetColorForHealth( cg.snap->ps.stats[STAT_HEALTH], 
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_GetColorForHealth
CALLV
pop
line 891
;890:		cg.snap->ps.stats[STAT_ARMOR], hcolor );
;891:}
LABELV $508
endproc CG_ColorForHealth 0 12
data
align 4
LABELV propMap
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 8
byte 4 11
byte 4 122
byte 4 7
byte 4 154
byte 4 181
byte 4 14
byte 4 55
byte 4 122
byte 4 17
byte 4 79
byte 4 122
byte 4 18
byte 4 101
byte 4 122
byte 4 23
byte 4 153
byte 4 122
byte 4 18
byte 4 9
byte 4 93
byte 4 7
byte 4 207
byte 4 122
byte 4 8
byte 4 230
byte 4 122
byte 4 9
byte 4 177
byte 4 122
byte 4 18
byte 4 30
byte 4 152
byte 4 18
byte 4 85
byte 4 181
byte 4 7
byte 4 34
byte 4 93
byte 4 11
byte 4 110
byte 4 181
byte 4 6
byte 4 130
byte 4 152
byte 4 14
byte 4 22
byte 4 64
byte 4 17
byte 4 41
byte 4 64
byte 4 12
byte 4 58
byte 4 64
byte 4 17
byte 4 78
byte 4 64
byte 4 18
byte 4 98
byte 4 64
byte 4 19
byte 4 120
byte 4 64
byte 4 18
byte 4 141
byte 4 64
byte 4 18
byte 4 204
byte 4 64
byte 4 16
byte 4 162
byte 4 64
byte 4 17
byte 4 182
byte 4 64
byte 4 18
byte 4 59
byte 4 181
byte 4 7
byte 4 35
byte 4 181
byte 4 7
byte 4 203
byte 4 152
byte 4 14
byte 4 56
byte 4 93
byte 4 14
byte 4 228
byte 4 152
byte 4 14
byte 4 177
byte 4 181
byte 4 18
byte 4 28
byte 4 122
byte 4 22
byte 4 5
byte 4 4
byte 4 18
byte 4 27
byte 4 4
byte 4 18
byte 4 48
byte 4 4
byte 4 18
byte 4 69
byte 4 4
byte 4 17
byte 4 90
byte 4 4
byte 4 13
byte 4 106
byte 4 4
byte 4 13
byte 4 121
byte 4 4
byte 4 18
byte 4 143
byte 4 4
byte 4 17
byte 4 164
byte 4 4
byte 4 8
byte 4 175
byte 4 4
byte 4 16
byte 4 195
byte 4 4
byte 4 18
byte 4 216
byte 4 4
byte 4 12
byte 4 230
byte 4 4
byte 4 23
byte 4 6
byte 4 34
byte 4 18
byte 4 27
byte 4 34
byte 4 18
byte 4 48
byte 4 34
byte 4 18
byte 4 68
byte 4 34
byte 4 18
byte 4 90
byte 4 34
byte 4 17
byte 4 110
byte 4 34
byte 4 18
byte 4 130
byte 4 34
byte 4 14
byte 4 146
byte 4 34
byte 4 18
byte 4 166
byte 4 34
byte 4 19
byte 4 185
byte 4 34
byte 4 29
byte 4 215
byte 4 34
byte 4 18
byte 4 234
byte 4 34
byte 4 18
byte 4 5
byte 4 64
byte 4 14
byte 4 60
byte 4 152
byte 4 7
byte 4 106
byte 4 151
byte 4 13
byte 4 83
byte 4 152
byte 4 7
byte 4 128
byte 4 122
byte 4 17
byte 4 4
byte 4 152
byte 4 21
byte 4 134
byte 4 181
byte 4 5
byte 4 5
byte 4 4
byte 4 18
byte 4 27
byte 4 4
byte 4 18
byte 4 48
byte 4 4
byte 4 18
byte 4 69
byte 4 4
byte 4 17
byte 4 90
byte 4 4
byte 4 13
byte 4 106
byte 4 4
byte 4 13
byte 4 121
byte 4 4
byte 4 18
byte 4 143
byte 4 4
byte 4 17
byte 4 164
byte 4 4
byte 4 8
byte 4 175
byte 4 4
byte 4 16
byte 4 195
byte 4 4
byte 4 18
byte 4 216
byte 4 4
byte 4 12
byte 4 230
byte 4 4
byte 4 23
byte 4 6
byte 4 34
byte 4 18
byte 4 27
byte 4 34
byte 4 18
byte 4 48
byte 4 34
byte 4 18
byte 4 68
byte 4 34
byte 4 18
byte 4 90
byte 4 34
byte 4 17
byte 4 110
byte 4 34
byte 4 18
byte 4 130
byte 4 34
byte 4 14
byte 4 146
byte 4 34
byte 4 18
byte 4 166
byte 4 34
byte 4 19
byte 4 185
byte 4 34
byte 4 29
byte 4 215
byte 4 34
byte 4 18
byte 4 234
byte 4 34
byte 4 18
byte 4 5
byte 4 64
byte 4 14
byte 4 153
byte 4 152
byte 4 13
byte 4 11
byte 4 181
byte 4 5
byte 4 180
byte 4 152
byte 4 13
byte 4 79
byte 4 93
byte 4 17
byte 4 0
byte 4 0
byte 4 -1
align 4
LABELV propMapB
byte 4 11
byte 4 12
byte 4 33
byte 4 49
byte 4 12
byte 4 31
byte 4 85
byte 4 12
byte 4 31
byte 4 120
byte 4 12
byte 4 30
byte 4 156
byte 4 12
byte 4 21
byte 4 183
byte 4 12
byte 4 21
byte 4 207
byte 4 12
byte 4 32
byte 4 13
byte 4 55
byte 4 30
byte 4 49
byte 4 55
byte 4 13
byte 4 66
byte 4 55
byte 4 29
byte 4 101
byte 4 55
byte 4 31
byte 4 135
byte 4 55
byte 4 21
byte 4 158
byte 4 55
byte 4 40
byte 4 204
byte 4 55
byte 4 32
byte 4 12
byte 4 97
byte 4 31
byte 4 48
byte 4 97
byte 4 31
byte 4 82
byte 4 97
byte 4 30
byte 4 118
byte 4 97
byte 4 30
byte 4 153
byte 4 97
byte 4 30
byte 4 185
byte 4 97
byte 4 25
byte 4 213
byte 4 97
byte 4 30
byte 4 11
byte 4 139
byte 4 32
byte 4 42
byte 4 139
byte 4 51
byte 4 93
byte 4 139
byte 4 32
byte 4 126
byte 4 139
byte 4 31
byte 4 158
byte 4 139
byte 4 25
code
proc UI_DrawBannerString2 52 36
line 1057
;892:
;893:
;894:
;895:
;896:// bk001205 - code below duplicated in q3_ui/ui-atoms.c
;897:// bk001205 - FIXME: does this belong in ui_shared.c?
;898:// bk001205 - FIXME: HARD_LINKED flags not visible here
;899:#ifndef Q3_STATIC // bk001205 - q_shared defines not visible here 
;900:/*
;901:=================
;902:UI_DrawProportionalString2
;903:=================
;904:*/
;905:static int	propMap[128][3] = {
;906:{0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1},
;907:{0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1},
;908:
;909:{0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1},
;910:{0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1},
;911:
;912:{0, 0, PROP_SPACE_WIDTH},		// SPACE
;913:{11, 122, 7},	// !
;914:{154, 181, 14},	// "
;915:{55, 122, 17},	// #
;916:{79, 122, 18},	// $
;917:{101, 122, 23},	// %
;918:{153, 122, 18},	// &
;919:{9, 93, 7},		// '
;920:{207, 122, 8},	// (
;921:{230, 122, 9},	// )
;922:{177, 122, 18},	// *
;923:{30, 152, 18},	// +
;924:{85, 181, 7},	// ,
;925:{34, 93, 11},	// -
;926:{110, 181, 6},	// .
;927:{130, 152, 14},	// /
;928:
;929:{22, 64, 17},	// 0
;930:{41, 64, 12},	// 1
;931:{58, 64, 17},	// 2
;932:{78, 64, 18},	// 3
;933:{98, 64, 19},	// 4
;934:{120, 64, 18},	// 5
;935:{141, 64, 18},	// 6
;936:{204, 64, 16},	// 7
;937:{162, 64, 17},	// 8
;938:{182, 64, 18},	// 9
;939:{59, 181, 7},	// :
;940:{35,181, 7},	// ;
;941:{203, 152, 14},	// <
;942:{56, 93, 14},	// =
;943:{228, 152, 14},	// >
;944:{177, 181, 18},	// ?
;945:
;946:{28, 122, 22},	// @
;947:{5, 4, 18},		// A
;948:{27, 4, 18},	// B
;949:{48, 4, 18},	// C
;950:{69, 4, 17},	// D
;951:{90, 4, 13},	// E
;952:{106, 4, 13},	// F
;953:{121, 4, 18},	// G
;954:{143, 4, 17},	// H
;955:{164, 4, 8},	// I
;956:{175, 4, 16},	// J
;957:{195, 4, 18},	// K
;958:{216, 4, 12},	// L
;959:{230, 4, 23},	// M
;960:{6, 34, 18},	// N
;961:{27, 34, 18},	// O
;962:
;963:{48, 34, 18},	// P
;964:{68, 34, 18},	// Q
;965:{90, 34, 17},	// R
;966:{110, 34, 18},	// S
;967:{130, 34, 14},	// T
;968:{146, 34, 18},	// U
;969:{166, 34, 19},	// V
;970:{185, 34, 29},	// W
;971:{215, 34, 18},	// X
;972:{234, 34, 18},	// Y
;973:{5, 64, 14},	// Z
;974:{60, 152, 7},	// [
;975:{106, 151, 13},	// '\'
;976:{83, 152, 7},	// ]
;977:{128, 122, 17},	// ^
;978:{4, 152, 21},	// _
;979:
;980:{134, 181, 5},	// '
;981:{5, 4, 18},		// A
;982:{27, 4, 18},	// B
;983:{48, 4, 18},	// C
;984:{69, 4, 17},	// D
;985:{90, 4, 13},	// E
;986:{106, 4, 13},	// F
;987:{121, 4, 18},	// G
;988:{143, 4, 17},	// H
;989:{164, 4, 8},	// I
;990:{175, 4, 16},	// J
;991:{195, 4, 18},	// K
;992:{216, 4, 12},	// L
;993:{230, 4, 23},	// M
;994:{6, 34, 18},	// N
;995:{27, 34, 18},	// O
;996:
;997:{48, 34, 18},	// P
;998:{68, 34, 18},	// Q
;999:{90, 34, 17},	// R
;1000:{110, 34, 18},	// S
;1001:{130, 34, 14},	// T
;1002:{146, 34, 18},	// U
;1003:{166, 34, 19},	// V
;1004:{185, 34, 29},	// W
;1005:{215, 34, 18},	// X
;1006:{234, 34, 18},	// Y
;1007:{5, 64, 14},	// Z
;1008:{153, 152, 13},	// {
;1009:{11, 181, 5},	// |
;1010:{180, 152, 13},	// }
;1011:{79, 93, 17},	// ~
;1012:{0, 0, -1}		// DEL
;1013:};
;1014:
;1015:static int propMapB[26][3] = {
;1016:{11, 12, 33},
;1017:{49, 12, 31},
;1018:{85, 12, 31},
;1019:{120, 12, 30},
;1020:{156, 12, 21},
;1021:{183, 12, 21},
;1022:{207, 12, 32},
;1023:
;1024:{13, 55, 30},
;1025:{49, 55, 13},
;1026:{66, 55, 29},
;1027:{101, 55, 31},
;1028:{135, 55, 21},
;1029:{158, 55, 40},
;1030:{204, 55, 32},
;1031:
;1032:{12, 97, 31},
;1033:{48, 97, 31},
;1034:{82, 97, 30},
;1035:{118, 97, 30},
;1036:{153, 97, 30},
;1037:{185, 97, 25},
;1038:{213, 97, 30},
;1039:
;1040:{11, 139, 32},
;1041:{42, 139, 51},
;1042:{93, 139, 32},
;1043:{126, 139, 31},
;1044:{158, 139, 25},
;1045:};
;1046:
;1047:#define PROPB_GAP_WIDTH		4
;1048:#define PROPB_SPACE_WIDTH	12
;1049:#define PROPB_HEIGHT		36
;1050:
;1051:/*
;1052:=================
;1053:UI_DrawBannerString
;1054:=================
;1055:*/
;1056:static void UI_DrawBannerString2( int x, int y, const char* str, vec4_t color )
;1057:{
line 1070
;1058:	const char* s;
;1059:	unsigned char	ch; // bk001204 : array subscript
;1060:	float	ax;
;1061:	float	ay;
;1062:	float	aw;
;1063:	float	ah;
;1064:	float	frow;
;1065:	float	fcol;
;1066:	float	fwidth;
;1067:	float	fheight;
;1068:
;1069:	// draw the colored text
;1070:	trap_R_SetColor( color );
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1072
;1071:	
;1072:	ax = x * cgs.screenXScale + cgs.screenXBias;
ADDRLP4 8
ADDRFP4 0
INDIRI4
CVIF4 4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ADDRGP4 cgs+31440
INDIRF4
ADDF4
ASGNF4
line 1073
;1073:	ay = y * cgs.screenXScale;
ADDRLP4 36
ADDRFP4 4
INDIRI4
CVIF4 4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ASGNF4
line 1075
;1074:
;1075:	s = str;
ADDRLP4 4
ADDRFP4 8
INDIRP4
ASGNP4
ADDRGP4 $516
JUMPV
LABELV $515
line 1077
;1076:	while ( *s )
;1077:	{
line 1078
;1078:		ch = *s & 127;
ADDRLP4 0
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 1079
;1079:		if ( ch == ' ' ) {
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 32
NEI4 $518
line 1080
;1080:			ax += ((float)PROPB_SPACE_WIDTH + (float)PROPB_GAP_WIDTH)* cgs.screenXScale;
ADDRLP4 8
ADDRLP4 8
INDIRF4
CNSTF4 1098907648
ADDRGP4 cgs+31432
INDIRF4
MULF4
ADDF4
ASGNF4
line 1081
;1081:		}
ADDRGP4 $519
JUMPV
LABELV $518
line 1082
;1082:		else if ( ch >= 'A' && ch <= 'Z' ) {
ADDRLP4 40
ADDRLP4 0
INDIRU1
CVUI4 1
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 65
LTI4 $521
ADDRLP4 40
INDIRI4
CNSTI4 90
GTI4 $521
line 1083
;1083:			ch -= 'A';
ADDRLP4 0
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 65
SUBI4
CVIU4 4
CVUU1 4
ASGNU1
line 1084
;1084:			fcol = (float)propMapB[ch][0] / 256.0f;
ADDRLP4 20
CNSTI4 12
ADDRLP4 0
INDIRU1
CVUI4 1
MULI4
ADDRGP4 propMapB
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1132462080
DIVF4
ASGNF4
line 1085
;1085:			frow = (float)propMapB[ch][1] / 256.0f;
ADDRLP4 16
CNSTI4 12
ADDRLP4 0
INDIRU1
CVUI4 1
MULI4
ADDRGP4 propMapB+4
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1132462080
DIVF4
ASGNF4
line 1086
;1086:			fwidth = (float)propMapB[ch][2] / 256.0f;
ADDRLP4 28
CNSTI4 12
ADDRLP4 0
INDIRU1
CVUI4 1
MULI4
ADDRGP4 propMapB+8
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1132462080
DIVF4
ASGNF4
line 1087
;1087:			fheight = (float)PROPB_HEIGHT / 256.0f;
ADDRLP4 32
CNSTF4 1041235968
ASGNF4
line 1088
;1088:			aw = (float)propMapB[ch][2] * cgs.screenXScale;
ADDRLP4 12
CNSTI4 12
ADDRLP4 0
INDIRU1
CVUI4 1
MULI4
ADDRGP4 propMapB+8
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ASGNF4
line 1089
;1089:			ah = (float)PROPB_HEIGHT * cgs.screenXScale;
ADDRLP4 24
CNSTF4 1108344832
ADDRGP4 cgs+31432
INDIRF4
MULF4
ASGNF4
line 1090
;1090:			trap_R_DrawStretchPic( ax, ay, aw, ah, fcol, frow, fcol+fwidth, frow+fheight, cgs.media.charsetPropB );
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ADDRLP4 28
INDIRF4
ADDF4
ARGF4
ADDRLP4 16
INDIRF4
ADDRLP4 32
INDIRF4
ADDF4
ARGF4
ADDRGP4 cgs+156680+28
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1091
;1091:			ax += (aw + (float)PROPB_GAP_WIDTH * cgs.screenXScale);
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 1082130432
ADDRGP4 cgs+31432
INDIRF4
MULF4
ADDF4
ADDF4
ASGNF4
line 1092
;1092:		}
LABELV $521
LABELV $519
line 1093
;1093:		s++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1094
;1094:	}
LABELV $516
line 1076
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $515
line 1096
;1095:
;1096:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1097
;1097:}
LABELV $511
endproc UI_DrawBannerString2 52 36
export UI_DrawBannerString
proc UI_DrawBannerString 44 16
line 1099
;1098:
;1099:void UI_DrawBannerString( int x, int y, const char* str, int style, vec4_t color ) {
line 1106
;1100:	const char *	s;
;1101:	int				ch;
;1102:	int				width;
;1103:	vec4_t			drawcolor;
;1104:
;1105:	// find the width of the drawn text
;1106:	s = str;
ADDRLP4 4
ADDRFP4 8
INDIRP4
ASGNP4
line 1107
;1107:	width = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $533
JUMPV
LABELV $532
line 1108
;1108:	while ( *s ) {
line 1109
;1109:		ch = *s;
ADDRLP4 0
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 1110
;1110:		if ( ch == ' ' ) {
ADDRLP4 0
INDIRI4
CNSTI4 32
NEI4 $535
line 1111
;1111:			width += PROPB_SPACE_WIDTH;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 12
ADDI4
ASGNI4
line 1112
;1112:		}
ADDRGP4 $536
JUMPV
LABELV $535
line 1113
;1113:		else if ( ch >= 'A' && ch <= 'Z' ) {
ADDRLP4 0
INDIRI4
CNSTI4 65
LTI4 $537
ADDRLP4 0
INDIRI4
CNSTI4 90
GTI4 $537
line 1114
;1114:			width += propMapB[ch - 'A'][2] + PROPB_GAP_WIDTH;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 propMapB-780+8
ADDP4
INDIRI4
CNSTI4 4
ADDI4
ADDI4
ASGNI4
line 1115
;1115:		}
LABELV $537
LABELV $536
line 1116
;1116:		s++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1117
;1117:	}
LABELV $533
line 1108
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $532
line 1118
;1118:	width -= PROPB_GAP_WIDTH;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 4
SUBI4
ASGNI4
line 1120
;1119:
;1120:	switch( style & UI_FORMATMASK ) {
ADDRLP4 28
ADDRFP4 12
INDIRI4
CNSTI4 7
BANDI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $542
ADDRLP4 28
INDIRI4
CNSTI4 1
EQI4 $544
ADDRLP4 28
INDIRI4
CNSTI4 2
EQI4 $545
ADDRGP4 $542
JUMPV
LABELV $544
line 1122
;1121:		case UI_CENTER:
;1122:			x -= width / 2;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 8
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ASGNI4
line 1123
;1123:			break;
ADDRGP4 $542
JUMPV
LABELV $545
line 1126
;1124:
;1125:		case UI_RIGHT:
;1126:			x -= width;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ASGNI4
line 1127
;1127:			break;
line 1131
;1128:
;1129:		case UI_LEFT:
;1130:		default:
;1131:			break;
LABELV $542
line 1134
;1132:	}
;1133:
;1134:	if ( style & UI_DROPSHADOW ) {
ADDRFP4 12
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $547
line 1135
;1135:		drawcolor[0] = drawcolor[1] = drawcolor[2] = 0;
ADDRLP4 36
CNSTF4 0
ASGNF4
ADDRLP4 12+8
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 36
INDIRF4
ASGNF4
line 1136
;1136:		drawcolor[3] = color[3];
ADDRLP4 12+12
ADDRFP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 1137
;1137:		UI_DrawBannerString2( x+2, y+2, str, drawcolor );
ADDRLP4 40
CNSTI4 2
ASGNI4
ADDRFP4 0
INDIRI4
ADDRLP4 40
INDIRI4
ADDI4
ARGI4
ADDRFP4 4
INDIRI4
ADDRLP4 40
INDIRI4
ADDI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 UI_DrawBannerString2
CALLV
pop
line 1138
;1138:	}
LABELV $547
line 1140
;1139:
;1140:	UI_DrawBannerString2( x, y, str, color );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 UI_DrawBannerString2
CALLV
pop
line 1141
;1141:}
LABELV $531
endproc UI_DrawBannerString 44 16
export UI_ProportionalStringWidth
proc UI_ProportionalStringWidth 16 0
line 1144
;1142:
;1143:
;1144:int UI_ProportionalStringWidth( const char* str ) {
line 1150
;1145:	const char *	s;
;1146:	int				ch;
;1147:	int				charWidth;
;1148:	int				width;
;1149:
;1150:	s = str;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 1151
;1151:	width = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $554
JUMPV
LABELV $553
line 1152
;1152:	while ( *s ) {
line 1153
;1153:		ch = *s & 127;
ADDRLP4 8
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
BANDI4
ASGNI4
line 1154
;1154:		charWidth = propMap[ch][2];
ADDRLP4 4
CNSTI4 12
ADDRLP4 8
INDIRI4
MULI4
ADDRGP4 propMap+8
ADDP4
INDIRI4
ASGNI4
line 1155
;1155:		if ( charWidth != -1 ) {
ADDRLP4 4
INDIRI4
CNSTI4 -1
EQI4 $557
line 1156
;1156:			width += charWidth;
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 1157
;1157:			width += PROP_GAP_WIDTH;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 3
ADDI4
ASGNI4
line 1158
;1158:		}
LABELV $557
line 1159
;1159:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1160
;1160:	}
LABELV $554
line 1152
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $553
line 1162
;1161:
;1162:	width -= PROP_GAP_WIDTH;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 3
SUBI4
ASGNI4
line 1163
;1163:	return width;
ADDRLP4 12
INDIRI4
RETI4
LABELV $552
endproc UI_ProportionalStringWidth 16 0
proc UI_DrawProportionalString2 48 36
line 1167
;1164:}
;1165:
;1166:static void UI_DrawProportionalString2( int x, int y, const char* str, vec4_t color, float sizeScale, qhandle_t charset )
;1167:{
line 1180
;1168:	const char* s;
;1169:	unsigned char	ch; // bk001204 - unsigned
;1170:	float	ax;
;1171:	float	ay;
;1172:	float	aw;
;1173:	float	ah;
;1174:	float	frow;
;1175:	float	fcol;
;1176:	float	fwidth;
;1177:	float	fheight;
;1178:
;1179:	// draw the colored text
;1180:	trap_R_SetColor( color );
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1182
;1181:	
;1182:	ax = x * cgs.screenXScale + cgs.screenXBias;
ADDRLP4 12
ADDRFP4 0
INDIRI4
CVIF4 4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ADDRGP4 cgs+31440
INDIRF4
ADDF4
ASGNF4
line 1183
;1183:	ay = y * cgs.screenXScale;
ADDRLP4 36
ADDRFP4 4
INDIRI4
CVIF4 4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ASGNF4
line 1185
;1184:
;1185:	s = str;
ADDRLP4 4
ADDRFP4 8
INDIRP4
ASGNP4
ADDRGP4 $564
JUMPV
LABELV $563
line 1187
;1186:	while ( *s )
;1187:	{
line 1188
;1188:		ch = *s & 127;
ADDRLP4 0
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 1189
;1189:		if ( ch == ' ' ) {
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 32
NEI4 $566
line 1190
;1190:			aw = (float)PROP_SPACE_WIDTH * cgs.screenXScale * sizeScale;
ADDRLP4 8
CNSTF4 1090519040
ADDRGP4 cgs+31432
INDIRF4
MULF4
ADDRFP4 16
INDIRF4
MULF4
ASGNF4
line 1191
;1191:		} else if ( propMap[ch][2] != -1 ) {
ADDRGP4 $567
JUMPV
LABELV $566
CNSTI4 12
ADDRLP4 0
INDIRU1
CVUI4 1
MULI4
ADDRGP4 propMap+8
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $569
line 1192
;1192:			fcol = (float)propMap[ch][0] / 256.0f;
ADDRLP4 20
CNSTI4 12
ADDRLP4 0
INDIRU1
CVUI4 1
MULI4
ADDRGP4 propMap
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1132462080
DIVF4
ASGNF4
line 1193
;1193:			frow = (float)propMap[ch][1] / 256.0f;
ADDRLP4 16
CNSTI4 12
ADDRLP4 0
INDIRU1
CVUI4 1
MULI4
ADDRGP4 propMap+4
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1132462080
DIVF4
ASGNF4
line 1194
;1194:			fwidth = (float)propMap[ch][2] / 256.0f;
ADDRLP4 28
CNSTI4 12
ADDRLP4 0
INDIRU1
CVUI4 1
MULI4
ADDRGP4 propMap+8
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1132462080
DIVF4
ASGNF4
line 1195
;1195:			fheight = (float)PROP_HEIGHT / 256.0f;
ADDRLP4 32
CNSTF4 1037565952
ASGNF4
line 1196
;1196:			aw = (float)propMap[ch][2] * cgs.screenXScale * sizeScale;
ADDRLP4 8
CNSTI4 12
ADDRLP4 0
INDIRU1
CVUI4 1
MULI4
ADDRGP4 propMap+8
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ADDRFP4 16
INDIRF4
MULF4
ASGNF4
line 1197
;1197:			ah = (float)PROP_HEIGHT * cgs.screenXScale * sizeScale;
ADDRLP4 24
CNSTF4 1104674816
ADDRGP4 cgs+31432
INDIRF4
MULF4
ADDRFP4 16
INDIRF4
MULF4
ASGNF4
line 1198
;1198:			trap_R_DrawStretchPic( ax, ay, aw, ah, fcol, frow, fcol+fwidth, frow+fheight, charset );
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ADDRLP4 28
INDIRF4
ADDF4
ARGF4
ADDRLP4 16
INDIRF4
ADDRLP4 32
INDIRF4
ADDF4
ARGF4
ADDRFP4 20
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1199
;1199:		} else {
ADDRGP4 $570
JUMPV
LABELV $569
line 1200
;1200:			aw = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 1201
;1201:		}
LABELV $570
LABELV $567
line 1203
;1202:
;1203:		ax += (aw + (float)PROP_GAP_WIDTH * cgs.screenXScale * sizeScale);
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
CNSTF4 1077936128
ADDRGP4 cgs+31432
INDIRF4
MULF4
ADDRFP4 16
INDIRF4
MULF4
ADDF4
ADDF4
ASGNF4
line 1204
;1204:		s++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1205
;1205:	}
LABELV $564
line 1186
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $563
line 1207
;1206:
;1207:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1208
;1208:}
LABELV $559
endproc UI_DrawProportionalString2 48 36
export UI_ProportionalSizeScale
proc UI_ProportionalSizeScale 0 0
line 1215
;1209:
;1210:/*
;1211:=================
;1212:UI_ProportionalSizeScale
;1213:=================
;1214:*/
;1215:float UI_ProportionalSizeScale( int style ) {
line 1216
;1216:	if ( style & UI_EXTRASMALLFONT ) {
ADDRFP4 0
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $579
line 1217
;1217:		return 0.40f;
CNSTF4 1053609165
RETF4
ADDRGP4 $578
JUMPV
LABELV $579
line 1219
;1218:	}
;1219:	if ( style & UI_SMALLFONT ) {
ADDRFP4 0
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $581
line 1220
;1220:		return 0.75f;
CNSTF4 1061158912
RETF4
ADDRGP4 $578
JUMPV
LABELV $581
line 1223
;1221:	}
;1222:
;1223:	return 1.00;
CNSTF4 1065353216
RETF4
LABELV $578
endproc UI_ProportionalSizeScale 0 0
export UI_DrawProportionalString
proc UI_DrawProportionalString 44 24
line 1232
;1224:}
;1225:
;1226:
;1227:/*
;1228:=================
;1229:UI_DrawProportionalString
;1230:=================
;1231:*/
;1232:void UI_DrawProportionalString( int x, int y, const char* str, int style, vec4_t color ) {
line 1237
;1233:	vec4_t	drawcolor;
;1234:	int		width;
;1235:	float	sizeScale;
;1236:
;1237:	sizeScale = UI_ProportionalSizeScale( style );
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 UI_ProportionalSizeScale
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 24
INDIRF4
ASGNF4
line 1239
;1238:
;1239:	switch( style & UI_FORMATMASK ) {
ADDRLP4 28
ADDRFP4 12
INDIRI4
CNSTI4 7
BANDI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $585
ADDRLP4 28
INDIRI4
CNSTI4 1
EQI4 $587
ADDRLP4 28
INDIRI4
CNSTI4 2
EQI4 $588
ADDRGP4 $585
JUMPV
LABELV $587
line 1241
;1240:		case UI_CENTER:
;1241:			width = UI_ProportionalStringWidth( str ) * sizeScale;
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 UI_ProportionalStringWidth
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 36
INDIRI4
CVIF4 4
ADDRLP4 16
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 1242
;1242:			x -= width / 2;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 20
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ASGNI4
line 1243
;1243:			break;
ADDRGP4 $585
JUMPV
LABELV $588
line 1246
;1244:
;1245:		case UI_RIGHT:
;1246:			width = UI_ProportionalStringWidth( str ) * sizeScale;
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 UI_ProportionalStringWidth
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 40
INDIRI4
CVIF4 4
ADDRLP4 16
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 1247
;1247:			x -= width;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 1248
;1248:			break;
line 1252
;1249:
;1250:		case UI_LEFT:
;1251:		default:
;1252:			break;
LABELV $585
line 1255
;1253:	}
;1254:
;1255:	if ( style & UI_DROPSHADOW ) {
ADDRFP4 12
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $590
line 1256
;1256:		drawcolor[0] = drawcolor[1] = drawcolor[2] = 0;
ADDRLP4 36
CNSTF4 0
ASGNF4
ADDRLP4 0+8
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 36
INDIRF4
ASGNF4
line 1257
;1257:		drawcolor[3] = color[3];
ADDRLP4 0+12
ADDRFP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 1258
;1258:		UI_DrawProportionalString2( x+2, y+2, str, drawcolor, sizeScale, cgs.media.charsetProp );
ADDRLP4 40
CNSTI4 2
ASGNI4
ADDRFP4 0
INDIRI4
ADDRLP4 40
INDIRI4
ADDI4
ARGI4
ADDRFP4 4
INDIRI4
ADDRLP4 40
INDIRI4
ADDI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 cgs+156680+20
INDIRI4
ARGI4
ADDRGP4 UI_DrawProportionalString2
CALLV
pop
line 1259
;1259:	}
LABELV $590
line 1261
;1260:
;1261:	if ( style & UI_INVERSE ) {
ADDRFP4 12
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $597
line 1262
;1262:		drawcolor[0] = color[0] * 0.8;
ADDRLP4 0
CNSTF4 1061997773
ADDRFP4 16
INDIRP4
INDIRF4
MULF4
ASGNF4
line 1263
;1263:		drawcolor[1] = color[1] * 0.8;
ADDRLP4 0+4
CNSTF4 1061997773
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ASGNF4
line 1264
;1264:		drawcolor[2] = color[2] * 0.8;
ADDRLP4 0+8
CNSTF4 1061997773
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ASGNF4
line 1265
;1265:		drawcolor[3] = color[3];
ADDRLP4 0+12
ADDRFP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 1266
;1266:		UI_DrawProportionalString2( x, y, str, drawcolor, sizeScale, cgs.media.charsetProp );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 cgs+156680+20
INDIRI4
ARGI4
ADDRGP4 UI_DrawProportionalString2
CALLV
pop
line 1267
;1267:		return;
ADDRGP4 $583
JUMPV
LABELV $597
line 1270
;1268:	}
;1269:
;1270:	if ( style & UI_PULSE ) {
ADDRFP4 12
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $604
line 1271
;1271:		drawcolor[0] = color[0] * 0.8;
ADDRLP4 0
CNSTF4 1061997773
ADDRFP4 16
INDIRP4
INDIRF4
MULF4
ASGNF4
line 1272
;1272:		drawcolor[1] = color[1] * 0.8;
ADDRLP4 0+4
CNSTF4 1061997773
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ASGNF4
line 1273
;1273:		drawcolor[2] = color[2] * 0.8;
ADDRLP4 0+8
CNSTF4 1061997773
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ASGNF4
line 1274
;1274:		drawcolor[3] = color[3];
ADDRLP4 0+12
ADDRFP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 1275
;1275:		UI_DrawProportionalString2( x, y, str, color, sizeScale, cgs.media.charsetProp );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 cgs+156680+20
INDIRI4
ARGI4
ADDRGP4 UI_DrawProportionalString2
CALLV
pop
line 1277
;1276:
;1277:		drawcolor[0] = color[0];
ADDRLP4 0
ADDRFP4 16
INDIRP4
INDIRF4
ASGNF4
line 1278
;1278:		drawcolor[1] = color[1];
ADDRLP4 0+4
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 1279
;1279:		drawcolor[2] = color[2];
ADDRLP4 0+8
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
line 1280
;1280:		drawcolor[3] = 0.5 + 0.5 * sin( cg.time / PULSE_DIVISOR );
ADDRGP4 cg+107604
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 36
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0+12
CNSTF4 1056964608
ADDRLP4 36
INDIRF4
MULF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 1281
;1281:		UI_DrawProportionalString2( x, y, str, drawcolor, sizeScale, cgs.media.charsetPropGlow );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 cgs+156680+24
INDIRI4
ARGI4
ADDRGP4 UI_DrawProportionalString2
CALLV
pop
line 1282
;1282:		return;
ADDRGP4 $583
JUMPV
LABELV $604
line 1285
;1283:	}
;1284:
;1285:	UI_DrawProportionalString2( x, y, str, color, sizeScale, cgs.media.charsetProp );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 cgs+156680+20
INDIRI4
ARGI4
ADDRGP4 UI_DrawProportionalString2
CALLV
pop
line 1286
;1286:}
LABELV $583
endproc UI_DrawProportionalString 44 24
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
import DrawMOTDBox
import teamChat2
import teamChat1
import systemChat
import drawTeamOverlayModificationCount
import numSortedTeamPlayers
import sortedTeamPlayers
import CG_DrawString
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
LABELV $112
byte 1 99
byte 1 112
byte 1 109
byte 1 97
byte 1 0
align 1
LABELV $110
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
