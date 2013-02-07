data
export menu_text_color
align 4
LABELV menu_text_color
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
export menu_dim_color
align 4
LABELV menu_dim_color
byte 4 0
byte 4 0
byte 4 0
byte 4 1061158912
export color_black
align 4
LABELV color_black
byte 4 0
byte 4 0
byte 4 0
byte 4 1065353216
export color_white
align 4
LABELV color_white
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
export color_yellow
align 4
LABELV color_yellow
byte 4 1065353216
byte 4 1065353216
byte 4 0
byte 4 1065353216
export color_blue
align 4
LABELV color_blue
byte 4 0
byte 4 0
byte 4 1065353216
byte 4 1065353216
export color_lightOrange
align 4
LABELV color_lightOrange
byte 4 1065353216
byte 4 1059984507
byte 4 0
byte 4 1065353216
export color_orange
align 4
LABELV color_orange
byte 4 1065353216
byte 4 1054615798
byte 4 0
byte 4 1065353216
export color_red
align 4
LABELV color_red
byte 4 1065353216
byte 4 0
byte 4 0
byte 4 1065353216
export color_dim
align 4
LABELV color_dim
byte 4 0
byte 4 0
byte 4 0
byte 4 1048576000
export color_main
align 4
LABELV color_main
byte 4 0
byte 4 1061158912
byte 4 1065353216
byte 4 1065353216
export pulse_color
align 4
LABELV pulse_color
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
export text_color_disabled
align 4
LABELV text_color_disabled
byte 4 1056964608
byte 4 1056964608
byte 4 1056964608
byte 4 1065353216
export text_color_normal
align 4
LABELV text_color_normal
byte 4 1065353216
byte 4 1054615798
byte 4 0
byte 4 1065353216
export text_color_highlight
align 4
LABELV text_color_highlight
byte 4 1065353216
byte 4 1065353216
byte 4 0
byte 4 1065353216
export listbar_color
align 4
LABELV listbar_color
byte 4 1065353216
byte 4 1054615798
byte 4 0
byte 4 1050253722
export text_color_status
align 4
LABELV text_color_status
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
code
proc Text_Init 4 0
file "../ui_qmenu.c"
line 83
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:/**********************************************************************
;4:	UI_QMENU.C
;5:
;6:	Quake's menu framework system.
;7:**********************************************************************/
;8:#include "ui_local.h"
;9:
;10:sfxHandle_t menu_in_sound;
;11:sfxHandle_t menu_move_sound;
;12:sfxHandle_t menu_out_sound;
;13:sfxHandle_t menu_buzz_sound;
;14:sfxHandle_t menu_null_sound;
;15:sfxHandle_t weaponChangeSound;
;16:
;17:static qhandle_t	sliderBar;
;18:static qhandle_t	sliderButton_0;
;19:static qhandle_t	sliderButton_1;
;20:
;21:vec4_t menu_text_color	    = {1.0f, 1.0f, 1.0f, 1.0f};
;22:vec4_t menu_dim_color       = {0.0f, 0.0f, 0.0f, 0.75f};
;23:vec4_t color_black	    = {0.00f, 0.00f, 0.00f, 1.00f};
;24:vec4_t color_white	    = {1.00f, 1.00f, 1.00f, 1.00f};
;25:vec4_t color_yellow	    = {1.00f, 1.00f, 0.00f, 1.00f};
;26:vec4_t color_blue	    = {0.00f, 0.00f, 1.00f, 1.00f};
;27:vec4_t color_lightOrange    = {1.00f, 0.68f, 0.00f, 1.00f };
;28:vec4_t color_orange	    = {1.00f, 0.43f, 0.00f, 1.00f};
;29:vec4_t color_red	    = {1.00f, 0.00f, 0.00f, 1.00f};
;30:vec4_t color_dim	    = {0.00f, 0.00f, 0.00f, 0.25f};
;31://
;32:vec4_t color_main		= {0.00f, 0.75f, 1.00f, 1.00f};
;33:
;34:// current color scheme
;35:vec4_t pulse_color          = {1.00f, 1.00f, 1.00f, 1.00f};
;36:vec4_t text_color_disabled  = {0.50f, 0.50f, 0.50f, 1.00f};	// light gray
;37:vec4_t text_color_normal    = {1.00f, 0.43f, 0.00f, 1.00f};	// light orange
;38:vec4_t text_color_highlight = {1.00f, 1.00f, 0.00f, 1.00f};	// bright yellow
;39:vec4_t listbar_color        = {1.00f, 0.43f, 0.00f, 0.30f};	// transluscent orange
;40:vec4_t text_color_status    = {1.00f, 1.00f, 1.00f, 1.00f};	// bright white	
;41:
;42:// action widget
;43:static void	Action_Init( menuaction_s *a );
;44:static void	Action_Draw( menuaction_s *a );
;45:
;46:// radio button widget
;47:static void	RadioButton_Init( menuradiobutton_s *rb );
;48:static void	RadioButton_Draw( menuradiobutton_s *rb );
;49:static sfxHandle_t RadioButton_Key( menuradiobutton_s *rb, int key );
;50:
;51:// slider widget
;52:static void Slider_Init( menuslider_s *s );
;53:static sfxHandle_t Slider_Key( menuslider_s *s, int key );
;54:static void	Slider_Draw( menuslider_s *s );
;55:
;56:// spin control widget
;57:static void	SpinControl_Init( menulist_s *s );
;58:static void	SpinControl_Draw( menulist_s *s );
;59:static sfxHandle_t SpinControl_Key( menulist_s *l, int key );
;60:
;61:// text widget
;62:static void Text_Init( menutext_s *b );
;63:static void Text_Draw( menutext_s *b );
;64:
;65:// scrolllist widget
;66:static void	ScrollList_Init( menulist_s *l );
;67:sfxHandle_t ScrollList_Key( menulist_s *l, int key );
;68:
;69:// proportional text widget
;70:static void PText_Init( menutext_s *b );
;71:static void PText_Draw( menutext_s *b );
;72:
;73:// proportional banner text widget
;74:static void BText_Init( menutext_s *b );
;75:static void BText_Draw( menutext_s *b );
;76:
;77:/*
;78:=================
;79:Text_Init
;80:=================
;81:*/
;82:static void Text_Init( menutext_s *t )
;83:{
line 84
;84:	t->generic.flags |= QMF_INACTIVE;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
line 85
;85:}
LABELV $68
endproc Text_Init 4 0
proc Text_Draw 524 20
line 93
;86:
;87:/*
;88:=================
;89:Text_Draw
;90:=================
;91:*/
;92:static void Text_Draw( menutext_s *t )
;93:{
line 99
;94:	int		x;
;95:	int		y;
;96:	char	buff[512];	
;97:	float*	color;
;98:
;99:	x = t->generic.x;
ADDRLP4 512
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 100
;100:	y = t->generic.y;
ADDRLP4 516
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 102
;101:
;102:	buff[0] = '\0';
ADDRLP4 0
CNSTI1 0
ASGNI1
line 105
;103:
;104:	// possible label
;105:	if (t->generic.name)
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $70
line 106
;106:		strcpy(buff,t->generic.name);
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
LABELV $70
line 109
;107:
;108:	// possible value
;109:	if (t->string)
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $72
line 110
;110:		strcat(buff,t->string);
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRP4
ARGP4
ADDRGP4 strcat
CALLP4
pop
LABELV $72
line 112
;111:		
;112:	if (t->generic.flags & QMF_GRAYED)
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 8192
BANDU4
CNSTU4 0
EQU4 $74
line 113
;113:		color = text_color_disabled;
ADDRLP4 520
ADDRGP4 text_color_disabled
ASGNP4
ADDRGP4 $75
JUMPV
LABELV $74
line 115
;114:	else
;115:		color = t->color;
ADDRLP4 520
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRP4
ASGNP4
LABELV $75
line 117
;116:
;117:	UI_DrawString( x, y, buff, t->style, color );
ADDRLP4 512
INDIRI4
ARGI4
ADDRLP4 516
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ARGI4
ADDRLP4 520
INDIRP4
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 118
;118:}
LABELV $69
endproc Text_Draw 524 20
proc BText_Init 4 0
line 126
;119:
;120:/*
;121:=================
;122:BText_Init
;123:=================
;124:*/
;125:static void BText_Init( menutext_s *t )
;126:{
line 127
;127:	t->generic.flags |= QMF_INACTIVE;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
line 128
;128:}
LABELV $76
endproc BText_Init 4 0
proc BText_Draw 16 20
line 136
;129:
;130:/*
;131:=================
;132:BText_Draw
;133:=================
;134:*/
;135:static void BText_Draw( menutext_s *t )
;136:{
line 141
;137:	int		x;
;138:	int		y;
;139:	float*	color;
;140:
;141:	x = t->generic.x;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 142
;142:	y = t->generic.y;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 144
;143:
;144:	if (t->generic.flags & QMF_GRAYED)
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 8192
BANDU4
CNSTU4 0
EQU4 $78
line 145
;145:		color = text_color_disabled;
ADDRLP4 8
ADDRGP4 text_color_disabled
ASGNP4
ADDRGP4 $79
JUMPV
LABELV $78
line 147
;146:	else
;147:		color = t->color;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRP4
ASGNP4
LABELV $79
line 149
;148:
;149:	UI_DrawBannerString( x, y, t->string, t->style, color );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 60
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 UI_DrawBannerString
CALLV
pop
line 150
;150:}
LABELV $77
endproc BText_Draw 16 20
proc PText_Init 28 4
line 158
;151:
;152:/*
;153:=================
;154:PText_Init
;155:=================
;156:*/
;157:static void PText_Init( menutext_s *t )
;158:{
line 165
;159:	int	x;
;160:	int	y;
;161:	int	w;
;162:	int	h;
;163:	float	sizeScale;
;164:
;165:	sizeScale = UI_ProportionalSizeScale( t->style );
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 UI_ProportionalSizeScale
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 20
INDIRF4
ASGNF4
line 167
;166:
;167:	x = t->generic.x;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 168
;168:	y = t->generic.y;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 169
;169:	w = UI_ProportionalStringWidth( t->string ) * sizeScale;
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 UI_ProportionalStringWidth
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 24
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 170
;170:	h =	PROP_HEIGHT * sizeScale;
ADDRLP4 16
CNSTF4 1104674816
ADDRLP4 0
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 172
;171:
;172:	if( t->generic.flags & QMF_RIGHT_JUSTIFY ) {
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 16
BANDU4
CNSTU4 0
EQU4 $81
line 173
;173:		x -= w;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 12
INDIRI4
SUBI4
ASGNI4
line 174
;174:	}
ADDRGP4 $82
JUMPV
LABELV $81
line 175
;175:	else if( t->generic.flags & QMF_CENTER_JUSTIFY ) {
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 8
BANDU4
CNSTU4 0
EQU4 $83
line 176
;176:		x -= w / 2;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 12
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ASGNI4
line 177
;177:	}
LABELV $83
LABELV $82
line 179
;178:
;179:	t->generic.left   = x - PROP_GAP_WIDTH * sizeScale;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 4
INDIRI4
CVIF4 4
CNSTF4 1077936128
ADDRLP4 0
INDIRF4
MULF4
SUBF4
CVFI4 4
ASGNI4
line 180
;180:	t->generic.right  = x + w + PROP_GAP_WIDTH * sizeScale;
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 4
INDIRI4
ADDRLP4 12
INDIRI4
ADDI4
CVIF4 4
CNSTF4 1077936128
ADDRLP4 0
INDIRF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 181
;181:	t->generic.top    = y;
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 182
;182:	t->generic.bottom = y + h;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 8
INDIRI4
ADDRLP4 16
INDIRI4
ADDI4
ASGNI4
line 183
;183:}
LABELV $80
endproc PText_Init 28 4
proc PText_Draw 24 24
line 191
;184:
;185:/*
;186:=================
;187:PText_Draw
;188:=================
;189:*/
;190:static void PText_Draw( menutext_s *t )
;191:{
line 197
;192:	int		x;
;193:	int		y;
;194:	float *	color;
;195:	int		style;
;196:
;197:	x = t->generic.x;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 198
;198:	y = t->generic.y;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 200
;199:
;200:	if (t->generic.flags & QMF_GRAYED)
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 8192
BANDU4
CNSTU4 0
EQU4 $86
line 201
;201:		color = text_color_disabled;
ADDRLP4 12
ADDRGP4 text_color_disabled
ASGNP4
ADDRGP4 $87
JUMPV
LABELV $86
line 203
;202:	else
;203:		color = t->color;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRP4
ASGNP4
LABELV $87
line 205
;204:
;205:	style = t->style;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ASGNI4
line 206
;206:	if( t->generic.flags & QMF_PULSEIFFOCUS ) {
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 256
BANDU4
CNSTU4 0
EQU4 $88
line 207
;207:		if( Menu_ItemAtCursor( t->generic.parent ) == t ) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 Menu_ItemAtCursor
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
CVPU4 4
ADDRLP4 20
INDIRP4
CVPU4 4
NEU4 $90
line 208
;208:			style |= UI_PULSE;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
line 209
;209:		}
ADDRGP4 $91
JUMPV
LABELV $90
line 210
;210:		else {
line 211
;211:			style |= UI_INVERSE;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 8192
BORI4
ASGNI4
line 212
;212:		}
LABELV $91
line 213
;213:	}
LABELV $88
line 215
;214:
;215:	UI_DrawProportionalString( x, y, t->string, style, UI_ProportionalSizeScale( style ), color );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 UI_ProportionalSizeScale
CALLF4
ASGNF4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 216
;216:}
LABELV $85
endproc PText_Draw 24 24
export Bitmap_Init
proc Bitmap_Init 16 0
line 224
;217:
;218:/*
;219:=================
;220:Bitmap_Init
;221:=================
;222:*/
;223:void Bitmap_Init( menubitmap_s *b )
;224:{
line 230
;225:	int	x;
;226:	int	y;
;227:	int	w;
;228:	int	h;
;229:
;230:	x = b->generic.x;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 231
;231:	y = b->generic.y;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 232
;232:	w = b->width;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
ASGNI4
line 233
;233:	h =	b->height;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ASGNI4
line 234
;234:	if( w < 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $93
line 235
;235:		w = -w;
ADDRLP4 0
ADDRLP4 0
INDIRI4
NEGI4
ASGNI4
line 236
;236:	}
LABELV $93
line 237
;237:	if( h < 0 ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
GEI4 $95
line 238
;238:		h = -h;
ADDRLP4 8
ADDRLP4 8
INDIRI4
NEGI4
ASGNI4
line 239
;239:	}
LABELV $95
line 241
;240:
;241:	if (b->generic.flags & QMF_RIGHT_JUSTIFY)
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 16
BANDU4
CNSTU4 0
EQU4 $97
line 242
;242:	{
line 243
;243:		x = x - w;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
ASGNI4
line 244
;244:	}
ADDRGP4 $98
JUMPV
LABELV $97
line 245
;245:	else if (b->generic.flags & QMF_CENTER_JUSTIFY)
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 8
BANDU4
CNSTU4 0
EQU4 $99
line 246
;246:	{
line 247
;247:		x = x - w/2;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ASGNI4
line 248
;248:	}
LABELV $99
LABELV $98
line 250
;249:
;250:	b->generic.left   = x;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 251
;251:	b->generic.right  = x + w;
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 252
;252:	b->generic.top    = y;
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 253
;253:	b->generic.bottom = y + h;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 12
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
ASGNI4
line 255
;254:
;255:	b->shader      = 0;
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 0
ASGNI4
line 256
;256:	b->focusshader = 0;
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 257
;257:}
LABELV $92
endproc Bitmap_Init 16 0
export Bitmap_Draw
proc Bitmap_Draw 84 20
line 265
;258:
;259:/*
;260:=================
;261:Bitmap_Draw
;262:=================
;263:*/
;264:void Bitmap_Draw( menubitmap_s *b )
;265:{
line 273
;266:	float	x;
;267:	float	y;
;268:	float	w;
;269:	float	h;
;270:	vec4_t	tempcolor;
;271:	float*	color;
;272:
;273:	x = b->generic.x;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 274
;274:	y = b->generic.y;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 275
;275:	w = b->width;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 276
;276:	h =	b->height;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 278
;277:
;278:	if (b->generic.flags & QMF_RIGHT_JUSTIFY)
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 16
BANDU4
CNSTU4 0
EQU4 $102
line 279
;279:	{
line 280
;280:		x = x - w;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
line 281
;281:	}
ADDRGP4 $103
JUMPV
LABELV $102
line 282
;282:	else if (b->generic.flags & QMF_CENTER_JUSTIFY)
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 8
BANDU4
CNSTU4 0
EQU4 $104
line 283
;283:	{
line 284
;284:		x = x - w/2;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRF4
CNSTF4 1073741824
DIVF4
SUBF4
ASGNF4
line 285
;285:	}
LABELV $104
LABELV $103
line 288
;286:
;287:	// used to refresh shader
;288:	if (b->generic.name && !b->shader)
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $106
ADDRLP4 36
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 0
NEI4 $106
line 289
;289:	{
line 290
;290:		b->shader = trap_R_RegisterShaderNoMip( b->generic.name );
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 40
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
line 291
;291:		if (!b->shader && b->errorpic)
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 0
NEI4 $108
ADDRLP4 48
INDIRP4
CNSTI4 64
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $108
line 292
;292:			b->shader = trap_R_RegisterShaderNoMip( b->errorpic );
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 64
ADDP4
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 52
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 56
INDIRI4
ASGNI4
LABELV $108
line 293
;293:	}
LABELV $106
line 295
;294:
;295:	if (b->focuspic && !b->focusshader)
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 60
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $110
ADDRLP4 40
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
NEI4 $110
line 296
;296:		b->focusshader = trap_R_RegisterShaderNoMip( b->focuspic );
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 60
ADDP4
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 44
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 48
INDIRI4
ASGNI4
LABELV $110
line 298
;297:
;298:	if (b->generic.flags & QMF_GRAYED)
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 8192
BANDU4
CNSTU4 0
EQU4 $112
line 299
;299:	{
line 300
;300:		if (b->shader)
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 0
EQI4 $113
line 301
;301:		{
line 302
;302:			trap_R_SetColor( colorMdGrey );
ADDRGP4 colorMdGrey
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 303
;303:			UI_DrawHandlePic( x, y, w, h, b->shader );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 304
;304:			trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 305
;305:		}
line 306
;306:	}
ADDRGP4 $113
JUMPV
LABELV $112
line 308
;307:	else
;308:	{
line 309
;309:		if (b->shader)
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 0
EQI4 $116
line 310
;310:			UI_DrawHandlePic( x, y, w, h, b->shader );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
LABELV $116
line 313
;311:
;312:		// bk001204 - parentheses
;313:		if (  ( (b->generic.flags & QMF_PULSE) 
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
ASGNU4
ADDRLP4 56
CNSTU4 0
ASGNU4
ADDRLP4 52
INDIRU4
CNSTU4 131072
BANDU4
ADDRLP4 56
INDIRU4
NEU4 $120
ADDRLP4 52
INDIRU4
CNSTU4 256
BANDU4
ADDRLP4 56
INDIRU4
EQU4 $118
LABELV $120
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 Menu_ItemAtCursor
CALLP4
ASGNP4
ADDRLP4 60
INDIRP4
CVPU4 4
ADDRLP4 64
INDIRP4
CVPU4 4
NEU4 $118
line 316
;314:			|| (b->generic.flags & QMF_PULSEIFFOCUS) )
;315:		      && (Menu_ItemAtCursor( b->generic.parent ) == b))
;316:		{	
line 317
;317:			if (b->focuscolor)			
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $121
line 318
;318:			{
line 319
;319:				tempcolor[0] = b->focuscolor[0];
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRP4
INDIRF4
ASGNF4
line 320
;320:				tempcolor[1] = b->focuscolor[1];
ADDRLP4 20+4
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 321
;321:				tempcolor[2] = b->focuscolor[2];
ADDRLP4 20+8
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
line 322
;322:				color        = tempcolor;	
ADDRLP4 16
ADDRLP4 20
ASGNP4
line 323
;323:			}
ADDRGP4 $122
JUMPV
LABELV $121
line 325
;324:			else
;325:				color = pulse_color;
ADDRLP4 16
ADDRGP4 pulse_color
ASGNP4
LABELV $122
line 326
;326:			color[3] = 0.5+0.5*sin(uis.realtime/PULSE_DIVISOR);
ADDRGP4 uis+4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 68
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1056964608
ADDRLP4 68
INDIRF4
MULF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 328
;327:
;328:			trap_R_SetColor( color );
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 329
;329:			UI_DrawHandlePic( x, y, w, h, b->focusshader );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 330
;330:			trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 331
;331:		}
ADDRGP4 $119
JUMPV
LABELV $118
line 332
;332:		else if ((b->generic.flags & QMF_HIGHLIGHT) || ((b->generic.flags & QMF_HIGHLIGHT_IF_FOCUS) && (Menu_ItemAtCursor( b->generic.parent ) == b)))
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
ADDRLP4 68
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
ASGNU4
ADDRLP4 76
CNSTU4 0
ASGNU4
ADDRLP4 72
INDIRU4
CNSTU4 64
BANDU4
ADDRLP4 76
INDIRU4
NEU4 $128
ADDRLP4 72
INDIRU4
CNSTU4 128
BANDU4
ADDRLP4 76
INDIRU4
EQU4 $126
ADDRLP4 68
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 Menu_ItemAtCursor
CALLP4
ASGNP4
ADDRLP4 68
INDIRP4
CVPU4 4
ADDRLP4 80
INDIRP4
CVPU4 4
NEU4 $126
LABELV $128
line 333
;333:		{	
line 334
;334:			if (b->focuscolor)
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $129
line 335
;335:			{
line 336
;336:				trap_R_SetColor( b->focuscolor );
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 337
;337:				UI_DrawHandlePic( x, y, w, h, b->focusshader );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 338
;338:				trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 339
;339:			}
ADDRGP4 $130
JUMPV
LABELV $129
line 341
;340:			else
;341:				UI_DrawHandlePic( x, y, w, h, b->focusshader );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
LABELV $130
line 342
;342:		}
LABELV $126
LABELV $119
line 343
;343:	}
LABELV $113
line 344
;344:}
LABELV $101
endproc Bitmap_Draw 84 20
proc Action_Init 28 4
line 352
;345:
;346:/*
;347:=================
;348:Action_Init
;349:=================
;350:*/
;351:static void Action_Init( menuaction_s *a )
;352:{
line 356
;353:	int	len;
;354:
;355:	// calculate bounds
;356:	if (a->generic.name)
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $132
line 357
;357:		len = strlen(a->generic.name);
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
ADDRGP4 $133
JUMPV
LABELV $132
line 359
;358:	else
;359:		len = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $133
line 362
;360:
;361:	// left justify text
;362:	a->generic.left   = a->generic.x; 
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 363
;363:	a->generic.right  = a->generic.x + len*BIGCHAR_WIDTH;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDI4
ASGNI4
line 364
;364:	a->generic.top    = a->generic.y;
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 365
;365:	a->generic.bottom = a->generic.y + BIGCHAR_HEIGHT;
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
CNSTI4 16
ASGNI4
ADDRLP4 20
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
ADDI4
ASGNI4
line 366
;366:}
LABELV $131
endproc Action_Init 28 4
proc Action_Draw 28 20
line 374
;367:
;368:/*
;369:=================
;370:Action_Draw
;371:=================
;372:*/
;373:static void Action_Draw( menuaction_s *a )
;374:{
line 379
;375:	int		x, y;
;376:	int		style;
;377:	float*	color;
;378:
;379:	style = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 380
;380:	color = menu_text_color;
ADDRLP4 0
ADDRGP4 menu_text_color
ASGNP4
line 381
;381:	if ( a->generic.flags & QMF_GRAYED )
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 8192
BANDU4
CNSTU4 0
EQU4 $135
line 382
;382:	{
line 383
;383:		color = text_color_disabled;
ADDRLP4 0
ADDRGP4 text_color_disabled
ASGNP4
line 384
;384:	}
ADDRGP4 $136
JUMPV
LABELV $135
line 385
;385:	else if (( a->generic.flags & QMF_PULSEIFFOCUS ) && ( a->generic.parent->cursor == a->generic.menuPosition ))
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 256
BANDU4
CNSTU4 0
EQU4 $137
ADDRLP4 16
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
INDIRI4
ADDRLP4 16
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $137
line 386
;386:	{
line 387
;387:		color = text_color_highlight;
ADDRLP4 0
ADDRGP4 text_color_highlight
ASGNP4
line 388
;388:		style = UI_PULSE;
ADDRLP4 12
CNSTI4 16384
ASGNI4
line 389
;389:	}
ADDRGP4 $138
JUMPV
LABELV $137
line 390
;390:	else if (( a->generic.flags & QMF_HIGHLIGHT_IF_FOCUS ) && ( a->generic.parent->cursor == a->generic.menuPosition ))
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 128
BANDU4
CNSTU4 0
EQU4 $139
ADDRLP4 20
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
INDIRI4
ADDRLP4 20
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $139
line 391
;391:	{
line 392
;392:		color = text_color_highlight;
ADDRLP4 0
ADDRGP4 text_color_highlight
ASGNP4
line 393
;393:	}
ADDRGP4 $140
JUMPV
LABELV $139
line 394
;394:	else if ( a->generic.flags & QMF_BLINK )
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 1
BANDU4
CNSTU4 0
EQU4 $141
line 395
;395:	{
line 396
;396:		style = UI_BLINK;
ADDRLP4 12
CNSTI4 4096
ASGNI4
line 397
;397:		color = text_color_highlight;
ADDRLP4 0
ADDRGP4 text_color_highlight
ASGNP4
line 398
;398:	}
LABELV $141
LABELV $140
LABELV $138
LABELV $136
line 400
;399:
;400:	x = a->generic.x;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 401
;401:	y = a->generic.y;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 403
;402:
;403:	UI_DrawString( x, y, a->generic.name, UI_LEFT|style, color );
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 405
;404:
;405:	if ( a->generic.parent->cursor == a->generic.menuPosition )
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
INDIRI4
ADDRLP4 24
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $143
line 406
;406:	{
line 408
;407:		// draw cursor
;408:		UI_DrawChar( x - BIGCHAR_WIDTH, y, 13, UI_LEFT|UI_BLINK, color);
ADDRLP4 4
INDIRI4
CNSTI4 16
SUBI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
CNSTI4 13
ARGI4
CNSTI4 4096
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 UI_DrawChar
CALLV
pop
line 409
;409:	}
LABELV $143
line 410
;410:}
LABELV $134
endproc Action_Draw 28 20
proc RadioButton_Init 28 4
line 418
;411:
;412:/*
;413:=================
;414:RadioButton_Init
;415:=================
;416:*/
;417:static void RadioButton_Init( menuradiobutton_s *rb )
;418:{
line 422
;419:	int	len;
;420:
;421:	// calculate bounds
;422:	if (rb->generic.name)
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $146
line 423
;423:		len = strlen(rb->generic.name);
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
ADDRGP4 $147
JUMPV
LABELV $146
line 425
;424:	else
;425:		len = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $147
line 427
;426:
;427:	rb->generic.left   = rb->generic.x - (len+1)*SMALLCHAR_WIDTH;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
CNSTI4 8
ADDI4
SUBI4
ASGNI4
line 428
;428:	rb->generic.right  = rb->generic.x + 6*SMALLCHAR_WIDTH;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 48
ADDI4
ASGNI4
line 429
;429:	rb->generic.top    = rb->generic.y;
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 430
;430:	rb->generic.bottom = rb->generic.y + SMALLCHAR_HEIGHT;
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
CNSTI4 16
ASGNI4
ADDRLP4 20
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
ADDI4
ASGNI4
line 431
;431:}
LABELV $145
endproc RadioButton_Init 28 4
proc RadioButton_Key 44 8
line 439
;432:
;433:/*
;434:=================
;435:RadioButton_Key
;436:=================
;437:*/
;438:static sfxHandle_t RadioButton_Key( menuradiobutton_s *rb, int key )
;439:{
line 440
;440:	switch (key)
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 163
EQI4 $154
ADDRLP4 4
CNSTI4 165
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $154
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
GTI4 $161
LABELV $160
ADDRLP4 8
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 12
CNSTI4 13
ASGNI4
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $154
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRI4
LTI4 $149
LABELV $162
ADDRLP4 16
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 134
EQI4 $154
ADDRLP4 16
INDIRI4
CNSTI4 135
EQI4 $154
ADDRGP4 $149
JUMPV
LABELV $161
ADDRLP4 20
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 24
CNSTI4 178
ASGNI4
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $151
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
GTI4 $164
LABELV $163
ADDRFP4 4
INDIRI4
CNSTI4 169
EQI4 $154
ADDRGP4 $149
JUMPV
LABELV $164
ADDRLP4 28
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 185
LTI4 $149
ADDRLP4 28
INDIRI4
CNSTI4 188
GTI4 $149
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $165-740
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $165
address $154
address $154
address $154
address $154
code
line 441
;441:	{
LABELV $151
line 443
;442:		case K_MOUSE1:
;443:			if (!(rb->generic.flags & QMF_HASMOUSEFOCUS))
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 512
BANDU4
CNSTU4 0
NEU4 $152
line 444
;444:				break;
ADDRGP4 $150
JUMPV
LABELV $152
LABELV $154
line 456
;445:
;446:		case K_JOY1:
;447:		case K_JOY2:
;448:		case K_JOY3:
;449:		case K_JOY4:
;450:		case K_ENTER:
;451:		case K_KP_ENTER:
;452:		case K_KP_LEFTARROW:
;453:		case K_LEFTARROW:
;454:		case K_KP_RIGHTARROW:
;455:		case K_RIGHTARROW:
;456:			rb->curvalue = !rb->curvalue;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $156
ADDRLP4 32
CNSTI4 1
ASGNI4
ADDRGP4 $157
JUMPV
LABELV $156
ADDRLP4 32
CNSTI4 0
ASGNI4
LABELV $157
ADDRLP4 36
INDIRP4
ADDRLP4 32
INDIRI4
ASGNI4
line 457
;457:			if ( rb->generic.callback )
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $158
line 458
;458:				rb->generic.callback( rb, QM_ACTIVATED );
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRLP4 40
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
CALLV
pop
LABELV $158
line 460
;459:
;460:			return (menu_move_sound);
ADDRGP4 menu_move_sound
INDIRI4
RETI4
ADDRGP4 $148
JUMPV
LABELV $149
LABELV $150
line 464
;461:	}
;462:
;463:	// key not handled
;464:	return 0;
CNSTI4 0
RETI4
LABELV $148
endproc RadioButton_Key 44 8
proc RadioButton_Draw 44 20
line 473
;465:}
;466:
;467:/*
;468:=================
;469:RadioButton_Draw
;470:=================
;471:*/
;472:static void RadioButton_Draw( menuradiobutton_s *rb )
;473:{
line 480
;474:	int	x;
;475:	int y;
;476:	float *color;
;477:	int	style;
;478:	qboolean focus;
;479:
;480:	x = rb->generic.x;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 481
;481:	y = rb->generic.y;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 483
;482:
;483:	focus = (rb->generic.parent->cursor == rb->generic.menuPosition);
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
INDIRI4
ADDRLP4 24
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $169
ADDRLP4 20
CNSTI4 1
ASGNI4
ADDRGP4 $170
JUMPV
LABELV $169
ADDRLP4 20
CNSTI4 0
ASGNI4
LABELV $170
ADDRLP4 12
ADDRLP4 20
INDIRI4
ASGNI4
line 485
;484:
;485:	if ( rb->generic.flags & QMF_GRAYED )
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 8192
BANDU4
CNSTU4 0
EQU4 $171
line 486
;486:	{
line 487
;487:		color = text_color_disabled;
ADDRLP4 8
ADDRGP4 text_color_disabled
ASGNP4
line 488
;488:		style = UI_LEFT|UI_SMALLFONT;
ADDRLP4 16
CNSTI4 16
ASGNI4
line 489
;489:	}
ADDRGP4 $172
JUMPV
LABELV $171
line 490
;490:	else if ( focus )
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $173
line 491
;491:	{
line 492
;492:		color = text_color_highlight;
ADDRLP4 8
ADDRGP4 text_color_highlight
ASGNP4
line 493
;493:		style = UI_LEFT|UI_PULSE|UI_SMALLFONT;
ADDRLP4 16
CNSTI4 16400
ASGNI4
line 494
;494:	}
ADDRGP4 $174
JUMPV
LABELV $173
line 496
;495:	else
;496:	{
line 497
;497:		color = text_color_normal;
ADDRLP4 8
ADDRGP4 text_color_normal
ASGNP4
line 498
;498:		style = UI_LEFT|UI_SMALLFONT;
ADDRLP4 16
CNSTI4 16
ASGNI4
line 499
;499:	}
LABELV $174
LABELV $172
line 501
;500:
;501:	if ( focus )
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $175
line 502
;502:	{
line 504
;503:		// draw cursor
;504:		UI_FillRect( rb->generic.left, rb->generic.top, rb->generic.right-rb->generic.left+1, rb->generic.bottom-rb->generic.top+1, listbar_color ); 
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
ADDRLP4 28
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 36
ADDRLP4 28
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 40
CNSTI4 1
ASGNI4
ADDRLP4 28
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ADDRLP4 32
INDIRI4
SUBI4
ADDRLP4 40
INDIRI4
ADDI4
CVIF4 4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
SUBI4
ADDRLP4 40
INDIRI4
ADDI4
CVIF4 4
ARGF4
ADDRGP4 listbar_color
ARGP4
ADDRGP4 UI_FillRect
CALLV
pop
line 505
;505:		UI_DrawChar( x, y, 13, UI_CENTER|UI_BLINK|UI_SMALLFONT, color);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 13
ARGI4
CNSTI4 4113
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 UI_DrawChar
CALLV
pop
line 506
;506:	}
LABELV $175
line 508
;507:
;508:	if ( rb->generic.name )
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $177
line 509
;509:		UI_DrawString( x - SMALLCHAR_WIDTH, y, rb->generic.name, UI_RIGHT|UI_SMALLFONT, color );
ADDRLP4 0
INDIRI4
CNSTI4 8
SUBI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
CNSTI4 18
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
LABELV $177
line 511
;510:
;511:	if ( !rb->curvalue )
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
CNSTI4 0
NEI4 $179
line 512
;512:	{
line 513
;513:		UI_DrawHandlePic( x + SMALLCHAR_WIDTH, y + 2, 16, 16, uis.rb_off);
ADDRLP4 0
INDIRI4
CNSTI4 8
ADDI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRI4
CNSTI4 2
ADDI4
CVIF4 4
ARGF4
ADDRLP4 28
CNSTF4 1098907648
ASGNF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRGP4 uis+11432
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 514
;514:		UI_DrawString( x + SMALLCHAR_WIDTH + 16, y, "off", style, color );
ADDRLP4 0
INDIRI4
CNSTI4 8
ADDI4
CNSTI4 16
ADDI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 $182
ARGP4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 515
;515:	}
ADDRGP4 $180
JUMPV
LABELV $179
line 517
;516:	else
;517:	{
line 518
;518:		UI_DrawHandlePic( x + SMALLCHAR_WIDTH, y + 2, 16, 16, uis.rb_on );
ADDRLP4 0
INDIRI4
CNSTI4 8
ADDI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRI4
CNSTI4 2
ADDI4
CVIF4 4
ARGF4
ADDRLP4 28
CNSTF4 1098907648
ASGNF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRGP4 uis+11428
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 519
;519:		UI_DrawString( x + SMALLCHAR_WIDTH + 16, y, "on", style, color );
ADDRLP4 0
INDIRI4
CNSTI4 8
ADDI4
CNSTI4 16
ADDI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 $184
ARGP4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 520
;520:	}
LABELV $180
line 521
;521:}
LABELV $167
endproc RadioButton_Draw 44 20
proc Slider_Init 28 4
line 529
;522:
;523:/*
;524:=================
;525:Slider_Init
;526:=================
;527:*/
;528:static void Slider_Init( menuslider_s *s )
;529:{
line 533
;530:	int len;
;531:
;532:	// calculate bounds
;533:	if (s->generic.name)
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $186
line 534
;534:		len = strlen(s->generic.name);
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
ADDRGP4 $187
JUMPV
LABELV $186
line 536
;535:	else
;536:		len = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $187
line 538
;537:
;538:	s->generic.left   = s->generic.x - (len+1)*SMALLCHAR_WIDTH; 
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
CNSTI4 8
ADDI4
SUBI4
ASGNI4
line 539
;539:	s->generic.right  = s->generic.x + (SLIDER_RANGE+2+1)*SMALLCHAR_WIDTH;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 104
ADDI4
ASGNI4
line 540
;540:	s->generic.top    = s->generic.y;
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 541
;541:	s->generic.bottom = s->generic.y + SMALLCHAR_HEIGHT;
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
CNSTI4 16
ASGNI4
ADDRLP4 20
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 20
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
ADDI4
ASGNI4
line 542
;542:}
LABELV $185
endproc Slider_Init 28 4
proc Slider_Key 60 8
line 550
;543:
;544:/*
;545:=================
;546:Slider_Key
;547:=================
;548:*/
;549:static sfxHandle_t Slider_Key( menuslider_s *s, int key )
;550:{
line 555
;551:	sfxHandle_t	sound;
;552:	int			x;
;553:	int			oldvalue;
;554:
;555:	switch (key)
ADDRLP4 12
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 163
EQI4 $199
ADDRLP4 16
CNSTI4 165
ASGNI4
ADDRLP4 12
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $202
ADDRLP4 12
INDIRI4
ADDRLP4 16
INDIRI4
GTI4 $206
LABELV $205
ADDRLP4 20
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 134
EQI4 $199
ADDRLP4 20
INDIRI4
CNSTI4 135
EQI4 $202
ADDRGP4 $189
JUMPV
LABELV $206
ADDRFP4 4
INDIRI4
CNSTI4 178
EQI4 $191
ADDRGP4 $189
JUMPV
line 556
;556:	{
LABELV $191
line 558
;557:		case K_MOUSE1:
;558:			x           = uis.cursorx - s->generic.x - 2*SMALLCHAR_WIDTH;
ADDRLP4 4
ADDRGP4 uis+8
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
SUBI4
CNSTI4 16
SUBI4
ASGNI4
line 559
;559:			oldvalue    = s->curvalue;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 560
;560:			s->curvalue = (x/(float)(SLIDER_RANGE*SMALLCHAR_WIDTH)) * (s->maxvalue-s->minvalue) + s->minvalue;
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
ASGNF4
ADDRLP4 24
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 4
INDIRI4
CVIF4 4
CNSTF4 1117782016
DIVF4
ADDRLP4 24
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDRLP4 28
INDIRF4
SUBF4
MULF4
ADDRLP4 28
INDIRF4
ADDF4
ASGNF4
line 562
;561:
;562:			if (s->curvalue < s->minvalue)
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
GEF4 $193
line 563
;563:				s->curvalue = s->minvalue;
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 36
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
ASGNF4
ADDRGP4 $194
JUMPV
LABELV $193
line 564
;564:			else if (s->curvalue > s->maxvalue)
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
LEF4 $195
line 565
;565:				s->curvalue = s->maxvalue;
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 44
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ASGNF4
LABELV $195
LABELV $194
line 566
;566:			if (s->curvalue != oldvalue)
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ADDRLP4 8
INDIRI4
CVIF4 4
EQF4 $197
line 567
;567:				sound = menu_move_sound;
ADDRLP4 0
ADDRGP4 menu_move_sound
INDIRI4
ASGNI4
ADDRGP4 $190
JUMPV
LABELV $197
line 569
;568:			else
;569:				sound = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 570
;570:			break;
ADDRGP4 $190
JUMPV
LABELV $199
line 574
;571:
;572:		case K_KP_LEFTARROW:
;573:		case K_LEFTARROW:
;574:			if (s->curvalue > s->minvalue)
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
LEF4 $200
line 575
;575:			{
line 576
;576:				s->curvalue--;
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 577
;577:				sound = menu_move_sound;
ADDRLP4 0
ADDRGP4 menu_move_sound
INDIRI4
ASGNI4
line 578
;578:			}
ADDRGP4 $190
JUMPV
LABELV $200
line 580
;579:			else
;580:				sound = menu_buzz_sound;
ADDRLP4 0
ADDRGP4 menu_buzz_sound
INDIRI4
ASGNI4
line 581
;581:			break;			
ADDRGP4 $190
JUMPV
LABELV $202
line 585
;582:
;583:		case K_KP_RIGHTARROW:
;584:		case K_RIGHTARROW:
;585:			if (s->curvalue < s->maxvalue)
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
GEF4 $203
line 586
;586:			{
line 587
;587:				s->curvalue++;
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 588
;588:				sound = menu_move_sound;
ADDRLP4 0
ADDRGP4 menu_move_sound
INDIRI4
ASGNI4
line 589
;589:			}
ADDRGP4 $190
JUMPV
LABELV $203
line 591
;590:			else
;591:				sound = menu_buzz_sound;
ADDRLP4 0
ADDRGP4 menu_buzz_sound
INDIRI4
ASGNI4
line 592
;592:			break;			
ADDRGP4 $190
JUMPV
LABELV $189
line 596
;593:
;594:		default:
;595:			// key not handled
;596:			sound = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 597
;597:			break;
LABELV $190
line 600
;598:	}
;599:
;600:	if ( sound && s->generic.callback )
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $207
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $207
line 601
;601:		s->generic.callback( s, QM_ACTIVATED );
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRLP4 24
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
CALLV
pop
LABELV $207
line 603
;602:
;603:	return (sound);
ADDRLP4 0
INDIRI4
RETI4
LABELV $188
endproc Slider_Key 60 8
proc Slider_Draw 44 20
line 612
;604:}
;605:
;606:#if 1
;607:/*
;608:=================
;609:Slider_Draw
;610:=================
;611:*/
;612:static void Slider_Draw( menuslider_s *s ) {
line 620
;613:	int			x;
;614:	int			y;
;615:	int			style;
;616:	float		*color;
;617:	int			button;
;618:	qboolean	focus;
;619:	
;620:	x =	s->generic.x;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 621
;621:	y = s->generic.y;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 622
;622:	focus = (s->generic.parent->cursor == s->generic.menuPosition);
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
INDIRI4
ADDRLP4 28
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $211
ADDRLP4 24
CNSTI4 1
ASGNI4
ADDRGP4 $212
JUMPV
LABELV $211
ADDRLP4 24
CNSTI4 0
ASGNI4
LABELV $212
ADDRLP4 20
ADDRLP4 24
INDIRI4
ASGNI4
line 624
;623:
;624:	if( s->generic.flags & QMF_GRAYED ) {
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 8192
BANDU4
CNSTU4 0
EQU4 $213
line 625
;625:		color = text_color_disabled;
ADDRLP4 12
ADDRGP4 text_color_disabled
ASGNP4
line 626
;626:		style = UI_SMALLFONT;
ADDRLP4 8
CNSTI4 16
ASGNI4
line 627
;627:	}
ADDRGP4 $214
JUMPV
LABELV $213
line 628
;628:	else if( focus ) {
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $215
line 629
;629:		color  = text_color_highlight;
ADDRLP4 12
ADDRGP4 text_color_highlight
ASGNP4
line 630
;630:		style = UI_SMALLFONT | UI_PULSE;
ADDRLP4 8
CNSTI4 16400
ASGNI4
line 631
;631:	}
ADDRGP4 $216
JUMPV
LABELV $215
line 632
;632:	else {
line 633
;633:		color = text_color_normal;
ADDRLP4 12
ADDRGP4 text_color_normal
ASGNP4
line 634
;634:		style = UI_SMALLFONT;
ADDRLP4 8
CNSTI4 16
ASGNI4
line 635
;635:	}
LABELV $216
LABELV $214
line 638
;636:
;637:	// draw label
;638:	UI_DrawString( x - SMALLCHAR_WIDTH, y, s->generic.name, UI_RIGHT|style, color );
ADDRLP4 0
INDIRI4
CNSTI4 8
SUBI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 2
BORI4
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 641
;639:
;640:	// draw slider
;641:	UI_SetColor( color );
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 UI_SetColor
CALLV
pop
line 642
;642:	UI_DrawHandlePic( x + SMALLCHAR_WIDTH, y, 96, 16, sliderBar );
ADDRLP4 0
INDIRI4
CNSTI4 8
ADDI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1119879168
ARGF4
CNSTF4 1098907648
ARGF4
ADDRGP4 sliderBar
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 643
;643:	UI_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 UI_SetColor
CALLV
pop
line 646
;644:
;645:	// clamp thumb
;646:	if( s->maxvalue > s->minvalue )	{
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
LEF4 $217
line 647
;647:		s->range = ( s->curvalue - s->minvalue ) / ( float ) ( s->maxvalue - s->minvalue );
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
ADDRLP4 36
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
ASGNF4
ADDRLP4 36
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 36
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ADDRLP4 40
INDIRF4
SUBF4
ADDRLP4 36
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDRLP4 40
INDIRF4
SUBF4
DIVF4
ASGNF4
line 648
;648:		if( s->range < 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
CNSTF4 0
GEF4 $219
line 649
;649:			s->range = 0;
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
CNSTF4 0
ASGNF4
line 650
;650:		}
ADDRGP4 $218
JUMPV
LABELV $219
line 651
;651:		else if( s->range > 1) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
CNSTF4 1065353216
LEF4 $218
line 652
;652:			s->range = 1;
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
CNSTF4 1065353216
ASGNF4
line 653
;653:		}
line 654
;654:	}
ADDRGP4 $218
JUMPV
LABELV $217
line 655
;655:	else {
line 656
;656:		s->range = 0;
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
CNSTF4 0
ASGNF4
line 657
;657:	}
LABELV $218
line 660
;658:
;659:	// draw thumb
;660:	if( style & UI_PULSE) {
ADDRLP4 8
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $223
line 661
;661:		button = sliderButton_1;
ADDRLP4 16
ADDRGP4 sliderButton_1
INDIRI4
ASGNI4
line 662
;662:	}
ADDRGP4 $224
JUMPV
LABELV $223
line 663
;663:	else {
line 664
;664:		button = sliderButton_0;
ADDRLP4 16
ADDRGP4 sliderButton_0
INDIRI4
ASGNI4
line 665
;665:	}
LABELV $224
line 667
;666:
;667:	UI_DrawHandlePic( (int)( x + 2*SMALLCHAR_WIDTH + (SLIDER_RANGE-1)*SMALLCHAR_WIDTH* s->range ) - 2, y - 2, 12, 20, button );
ADDRLP4 36
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
ADDI4
CVIF4 4
CNSTF4 1116733440
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
MULF4
ADDF4
CVFI4 4
ADDRLP4 36
INDIRI4
SUBI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRI4
ADDRLP4 36
INDIRI4
SUBI4
CVIF4 4
ARGF4
CNSTF4 1094713344
ARGF4
CNSTF4 1101004800
ARGF4
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 668
;668:}
LABELV $209
endproc Slider_Draw 44 20
proc SpinControl_Init 48 4
line 745
;669:#else
;670:/*
;671:=================
;672:Slider_Draw
;673:=================
;674:*/
;675:static void Slider_Draw( menuslider_s *s )
;676:{
;677:	float *color;
;678:	int	style;
;679:	int	i;
;680:	int x;
;681:	int y;
;682:	qboolean focus;
;683:	
;684:	x =	s->generic.x;
;685:	y = s->generic.y;
;686:	focus = (s->generic.parent->cursor == s->generic.menuPosition);
;687:
;688:	style = UI_SMALLFONT;
;689:	if ( s->generic.flags & QMF_GRAYED )
;690:	{
;691:		color = text_color_disabled;
;692:	}
;693:	else if (focus)
;694:	{
;695:		color  = text_color_highlight;
;696:		style |= UI_PULSE;
;697:	}
;698:	else
;699:	{
;700:		color = text_color_normal;
;701:	}
;702:
;703:	if ( focus )
;704:	{
;705:		// draw cursor
;706:		UI_FillRect( s->generic.left, s->generic.top, s->generic.right-s->generic.left+1, s->generic.bottom-s->generic.top+1, listbar_color ); 
;707:		UI_DrawChar( x, y, 13, UI_CENTER|UI_BLINK|UI_SMALLFONT, color);
;708:	}
;709:
;710:	// draw label
;711:	UI_DrawString( x - SMALLCHAR_WIDTH, y, s->generic.name, UI_RIGHT|style, color );
;712:
;713:	// draw slider
;714:	UI_DrawChar( x + SMALLCHAR_WIDTH, y, 128, UI_LEFT|style, color);
;715:	for ( i = 0; i < SLIDER_RANGE; i++ )
;716:		UI_DrawChar( x + (i+2)*SMALLCHAR_WIDTH, y, 129, UI_LEFT|style, color);
;717:	UI_DrawChar( x + (i+2)*SMALLCHAR_WIDTH, y, 130, UI_LEFT|style, color);
;718:
;719:	// clamp thumb
;720:	if (s->maxvalue > s->minvalue)
;721:	{
;722:		s->range = ( s->curvalue - s->minvalue ) / ( float ) ( s->maxvalue - s->minvalue );
;723:		if ( s->range < 0)
;724:			s->range = 0;
;725:		else if ( s->range > 1)
;726:			s->range = 1;
;727:	}
;728:	else
;729:		s->range = 0;
;730:
;731:	// draw thumb
;732:	if (style & UI_PULSE) {
;733:		style &= ~UI_PULSE;
;734:		style |= UI_BLINK;
;735:	}
;736:	UI_DrawChar( (int)( x + 2*SMALLCHAR_WIDTH + (SLIDER_RANGE-1)*SMALLCHAR_WIDTH* s->range ), y, 131, UI_LEFT|style, color);
;737:}
;738:#endif
;739:
;740:/*
;741:=================
;742:SpinControl_Init
;743:=================
;744:*/
;745:static void SpinControl_Init( menulist_s *s ) {
line 750
;746:	int	len;
;747:	int	l;
;748:	const char* str;
;749:
;750:	if (s->generic.name)
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $226
line 751
;751:		len = strlen(s->generic.name) * SMALLCHAR_WIDTH;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
ADDRGP4 $227
JUMPV
LABELV $226
line 753
;752:	else
;753:		len = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $227
line 755
;754:
;755:	s->generic.left	= s->generic.x - SMALLCHAR_WIDTH - len;
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 8
SUBI4
ADDRLP4 8
INDIRI4
SUBI4
ASGNI4
line 757
;756:
;757:	len = s->numitems = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
ADDRLP4 8
ADDRLP4 20
INDIRI4
ASGNI4
ADDRGP4 $229
JUMPV
LABELV $228
line 759
;758:	while ( (str = s->itemnames[s->numitems]) != 0 )
;759:	{
line 760
;760:		l = strlen(str);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 24
INDIRI4
ASGNI4
line 761
;761:		if (l > len)
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LEI4 $231
line 762
;762:			len = l;
ADDRLP4 8
ADDRLP4 0
INDIRI4
ASGNI4
LABELV $231
line 764
;763:
;764:		s->numitems++;
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 765
;765:	}		
LABELV $229
line 758
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 24
INDIRP4
CNSTI4 76
ADDP4
INDIRP4
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 28
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $228
line 767
;766:
;767:	s->generic.top	  =	s->generic.y;
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 32
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 768
;768:	s->generic.right  =	s->generic.x + (len+1)*SMALLCHAR_WIDTH;
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 36
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
CNSTI4 3
LSHI4
CNSTI4 8
ADDI4
ADDI4
ASGNI4
line 769
;769:	s->generic.bottom =	s->generic.y + SMALLCHAR_HEIGHT;
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
CNSTI4 16
ASGNI4
ADDRLP4 40
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 40
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRI4
ADDRLP4 44
INDIRI4
ADDI4
ASGNI4
line 770
;770:}
LABELV $225
endproc SpinControl_Init 48 4
proc SpinControl_Key 32 8
line 778
;771:
;772:/*
;773:=================
;774:SpinControl_Key
;775:=================
;776:*/
;777:static sfxHandle_t SpinControl_Key( menulist_s *s, int key )
;778:{
line 781
;779:	sfxHandle_t	sound;
;780:
;781:	sound = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 782
;782:	switch (key)
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 163
EQI4 $239
ADDRLP4 8
CNSTI4 165
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $242
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
GTI4 $246
LABELV $245
ADDRLP4 12
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 134
EQI4 $239
ADDRLP4 12
INDIRI4
CNSTI4 135
EQI4 $242
ADDRGP4 $234
JUMPV
LABELV $246
ADDRFP4 4
INDIRI4
CNSTI4 178
EQI4 $236
ADDRGP4 $234
JUMPV
line 783
;783:	{
LABELV $236
line 785
;784:		case K_MOUSE1:
;785:			s->curvalue++;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 786
;786:			if (s->curvalue >= s->numitems)
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ADDRLP4 20
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
LTI4 $237
line 787
;787:				s->curvalue = 0;
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 0
ASGNI4
LABELV $237
line 788
;788:			sound = menu_move_sound;
ADDRLP4 0
ADDRGP4 menu_move_sound
INDIRI4
ASGNI4
line 789
;789:			break;
ADDRGP4 $235
JUMPV
LABELV $239
line 793
;790:		
;791:		case K_KP_LEFTARROW:
;792:		case K_LEFTARROW:
;793:			if (s->curvalue > 0)
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
CNSTI4 0
LEI4 $240
line 794
;794:			{
line 795
;795:				s->curvalue--;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 796
;796:				sound = menu_move_sound;
ADDRLP4 0
ADDRGP4 menu_move_sound
INDIRI4
ASGNI4
line 797
;797:			}
ADDRGP4 $235
JUMPV
LABELV $240
line 799
;798:			else
;799:				sound = menu_buzz_sound;
ADDRLP4 0
ADDRGP4 menu_buzz_sound
INDIRI4
ASGNI4
line 800
;800:			break;
ADDRGP4 $235
JUMPV
LABELV $242
line 804
;801:
;802:		case K_KP_RIGHTARROW:
;803:		case K_RIGHTARROW:
;804:			if (s->curvalue < s->numitems-1)
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ADDRLP4 24
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1
SUBI4
GEI4 $243
line 805
;805:			{
line 806
;806:				s->curvalue++;
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 807
;807:				sound = menu_move_sound;
ADDRLP4 0
ADDRGP4 menu_move_sound
INDIRI4
ASGNI4
line 808
;808:			}
ADDRGP4 $235
JUMPV
LABELV $243
line 810
;809:			else
;810:				sound = menu_buzz_sound;
ADDRLP4 0
ADDRGP4 menu_buzz_sound
INDIRI4
ASGNI4
line 811
;811:			break;
LABELV $234
LABELV $235
line 814
;812:	}
;813:
;814:	if ( sound && s->generic.callback )
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $247
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $247
line 815
;815:		s->generic.callback( s, QM_ACTIVATED );
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRLP4 16
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
CALLV
pop
LABELV $247
line 817
;816:
;817:	return (sound);
ADDRLP4 0
INDIRI4
RETI4
LABELV $233
endproc SpinControl_Key 32 8
proc SpinControl_Draw 44 20
line 826
;818:}
;819:
;820:/*
;821:=================
;822:SpinControl_Draw
;823:=================
;824:*/
;825:static void SpinControl_Draw( menulist_s *s )
;826:{
line 832
;827:	float *color;
;828:	int	x,y;
;829:	int	style;
;830:	qboolean focus;
;831:
;832:	x = s->generic.x;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 833
;833:	y =	s->generic.y;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 835
;834:
;835:	style = UI_SMALLFONT;
ADDRLP4 12
CNSTI4 16
ASGNI4
line 836
;836:	focus = (s->generic.parent->cursor == s->generic.menuPosition);
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
INDIRI4
ADDRLP4 24
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $251
ADDRLP4 20
CNSTI4 1
ASGNI4
ADDRGP4 $252
JUMPV
LABELV $251
ADDRLP4 20
CNSTI4 0
ASGNI4
LABELV $252
ADDRLP4 16
ADDRLP4 20
INDIRI4
ASGNI4
line 838
;837:
;838:	if ( s->generic.flags & QMF_GRAYED )
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 8192
BANDU4
CNSTU4 0
EQU4 $253
line 839
;839:		color = text_color_disabled;
ADDRLP4 0
ADDRGP4 text_color_disabled
ASGNP4
ADDRGP4 $254
JUMPV
LABELV $253
line 840
;840:	else if ( focus )
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $255
line 841
;841:	{
line 842
;842:		color = text_color_highlight;
ADDRLP4 0
ADDRGP4 text_color_highlight
ASGNP4
line 843
;843:		style |= UI_PULSE;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
line 844
;844:	}
ADDRGP4 $256
JUMPV
LABELV $255
line 845
;845:	else if ( s->generic.flags & QMF_BLINK )
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 1
BANDU4
CNSTU4 0
EQU4 $257
line 846
;846:	{
line 847
;847:		color = text_color_highlight;
ADDRLP4 0
ADDRGP4 text_color_highlight
ASGNP4
line 848
;848:		style |= UI_BLINK;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
line 849
;849:	}
ADDRGP4 $258
JUMPV
LABELV $257
line 851
;850:	else
;851:		color = text_color_normal;
ADDRLP4 0
ADDRGP4 text_color_normal
ASGNP4
LABELV $258
LABELV $256
LABELV $254
line 853
;852:
;853:	if ( focus )
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $259
line 854
;854:	{
line 856
;855:		// draw cursor
;856:		UI_FillRect( s->generic.left, s->generic.top, s->generic.right-s->generic.left+1, s->generic.bottom-s->generic.top+1, listbar_color ); 
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
ADDRLP4 28
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 36
ADDRLP4 28
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 40
CNSTI4 1
ASGNI4
ADDRLP4 28
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ADDRLP4 32
INDIRI4
SUBI4
ADDRLP4 40
INDIRI4
ADDI4
CVIF4 4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
SUBI4
ADDRLP4 40
INDIRI4
ADDI4
CVIF4 4
ARGF4
ADDRGP4 listbar_color
ARGP4
ADDRGP4 UI_FillRect
CALLV
pop
line 857
;857:		UI_DrawChar( x, y, 13, UI_CENTER|UI_BLINK|UI_SMALLFONT, color);
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
CNSTI4 13
ARGI4
CNSTI4 4113
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 UI_DrawChar
CALLV
pop
line 858
;858:	}
LABELV $259
line 860
;859:
;860:	UI_DrawString( x - SMALLCHAR_WIDTH, y, s->generic.name, style|UI_RIGHT, color );
ADDRLP4 4
INDIRI4
CNSTI4 8
SUBI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
INDIRI4
CNSTI4 2
BORI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 861
;861:	UI_DrawString( x + SMALLCHAR_WIDTH, y, s->itemnames[s->curvalue], style|UI_LEFT, color );
ADDRLP4 4
INDIRI4
CNSTI4 8
ADDI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 28
INDIRP4
CNSTI4 76
ADDP4
INDIRP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 862
;862:}
LABELV $249
endproc SpinControl_Draw 44 20
proc ScrollList_Init 36 0
line 870
;863:
;864:/*
;865:=================
;866:ScrollList_Init
;867:=================
;868:*/
;869:static void ScrollList_Init( menulist_s *l )
;870:{
line 873
;871:	int		w;
;872:
;873:	l->oldvalue = 0;
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
CNSTI4 0
ASGNI4
line 874
;874:	l->curvalue = 0;
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 0
ASGNI4
line 875
;875:	l->top      = 0;
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 877
;876:
;877:	if( !l->columns ) {
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 0
NEI4 $262
line 878
;878:		l->columns = 1;
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 1
ASGNI4
line 879
;879:		l->seperation = 0;
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
CNSTI4 0
ASGNI4
line 880
;880:	}
ADDRGP4 $263
JUMPV
LABELV $262
line 881
;881:	else if( !l->seperation ) {
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRI4
CNSTI4 0
NEI4 $264
line 882
;882:		l->seperation = 3;
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
CNSTI4 3
ASGNI4
line 883
;883:	}
LABELV $264
LABELV $263
line 885
;884:
;885:	w = ( (l->width + l->seperation) * l->columns - l->seperation) * SMALLCHAR_WIDTH;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 4
INDIRP4
CNSTI4 92
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
ADDRLP4 4
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
MULI4
ADDRLP4 8
INDIRI4
SUBI4
CNSTI4 3
LSHI4
ASGNI4
line 887
;886:
;887:	l->generic.left   =	l->generic.x;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 888
;888:	l->generic.top    = l->generic.y;	
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 889
;889:	l->generic.right  =	l->generic.x + w;
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 890
;890:	l->generic.bottom =	l->generic.y + l->height * SMALLCHAR_HEIGHT;
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ADDRLP4 24
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDI4
ASGNI4
line 892
;891:
;892:	if( l->generic.flags & QMF_CENTER_JUSTIFY ) {
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 8
BANDU4
CNSTU4 0
EQU4 $266
line 893
;893:		l->generic.left -= w / 2;
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ASGNI4
line 894
;894:		l->generic.right -= w / 2;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ASGNI4
line 895
;895:	}
LABELV $266
line 896
;896:}
LABELV $261
endproc ScrollList_Init 36 0
export ScrollList_Key
proc ScrollList_Key 140 16
line 904
;897:
;898:/*
;899:=================
;900:ScrollList_Key
;901:=================
;902:*/
;903:sfxHandle_t ScrollList_Key( menulist_s *l, int key )
;904:{
line 916
;905:	int	x;
;906:	int	y;
;907:	int	w;
;908:	int	i;
;909:	int	j;	
;910:	int	c;
;911:	int	cursorx;
;912:	int	cursory;
;913:	int	column;
;914:	int	index;
;915:
;916:	switch (key)
ADDRLP4 40
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 160
LTI4 $352
ADDRLP4 40
INDIRI4
CNSTI4 168
GTI4 $353
ADDRLP4 40
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $354-640
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $354
address $284
address $316
address $294
address $334
address $269
address $343
address $287
address $325
address $305
code
LABELV $352
ADDRLP4 44
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 132
LTI4 $269
ADDRLP4 44
INDIRI4
CNSTI4 144
GTI4 $269
ADDRLP4 44
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $356-528
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $356
address $316
address $325
address $334
address $343
address $269
address $269
address $269
address $269
address $269
address $305
address $294
address $284
address $287
code
LABELV $353
ADDRFP4 4
INDIRI4
CNSTI4 178
EQI4 $271
ADDRGP4 $269
JUMPV
line 917
;917:	{
LABELV $271
line 919
;918:		case K_MOUSE1:
;919:			if (l->generic.flags & QMF_HASMOUSEFOCUS)
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 512
BANDU4
CNSTU4 0
EQU4 $270
line 920
;920:			{
line 922
;921:				// check scroll region
;922:				x = l->generic.x;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 923
;923:				y = l->generic.y;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 924
;924:				w = ( (l->width + l->seperation) * l->columns - l->seperation) * SMALLCHAR_WIDTH;
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
ADDRLP4 48
INDIRP4
CNSTI4 92
ADDP4
INDIRI4
ASGNI4
ADDRLP4 20
ADDRLP4 48
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ADDRLP4 52
INDIRI4
ADDI4
ADDRLP4 48
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
MULI4
ADDRLP4 52
INDIRI4
SUBI4
CNSTI4 3
LSHI4
ASGNI4
line 925
;925:				if( l->generic.flags & QMF_CENTER_JUSTIFY ) {
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 8
BANDU4
CNSTU4 0
EQU4 $274
line 926
;926:					x -= w / 2;
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 20
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ASGNI4
line 927
;927:				}
LABELV $274
line 928
;928:				if (UI_CursorInRect( x, y, w, l->height*SMALLCHAR_HEIGHT ))
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ARGI4
ADDRLP4 56
ADDRGP4 UI_CursorInRect
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $276
line 929
;929:				{
line 930
;930:					cursorx = (uis.cursorx - x)/SMALLCHAR_WIDTH;
ADDRLP4 28
ADDRGP4 uis+8
INDIRI4
ADDRLP4 12
INDIRI4
SUBI4
CNSTI4 8
DIVI4
ASGNI4
line 931
;931:					column = cursorx / (l->width + l->seperation);
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
ADDRLP4 28
INDIRI4
ADDRLP4 60
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ADDRLP4 60
INDIRP4
CNSTI4 92
ADDP4
INDIRI4
ADDI4
DIVI4
ASGNI4
line 932
;932:					cursory = (uis.cursory - y)/SMALLCHAR_HEIGHT;
ADDRLP4 32
ADDRGP4 uis+12
INDIRI4
ADDRLP4 16
INDIRI4
SUBI4
CNSTI4 16
DIVI4
ASGNI4
line 933
;933:					index = column * l->height + cursory;
ADDRLP4 24
ADDRLP4 36
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
MULI4
ADDRLP4 32
INDIRI4
ADDI4
ASGNI4
line 934
;934:					if (l->top + index < l->numitems)
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
ADDI4
ADDRLP4 64
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
GEI4 $280
line 935
;935:					{
line 936
;936:						l->oldvalue = l->curvalue;
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 60
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ASGNI4
line 937
;937:						l->curvalue = l->top + index;
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 64
ADDP4
ADDRLP4 72
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
ADDI4
ASGNI4
line 939
;938:
;939:						if (l->oldvalue != l->curvalue && l->generic.callback)
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ADDRLP4 76
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
EQI4 $282
ADDRLP4 76
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $282
line 940
;940:						{
line 941
;941:							l->generic.callback( l, QM_GOTFOCUS );
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 80
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
CALLV
pop
line 942
;942:							return (menu_move_sound);
ADDRGP4 menu_move_sound
INDIRI4
RETI4
ADDRGP4 $268
JUMPV
LABELV $282
line 944
;943:						}
;944:					}
LABELV $280
line 945
;945:				}
LABELV $276
line 948
;946:			
;947:				// absorbed, silent sound effect
;948:				return (menu_null_sound);
ADDRGP4 menu_null_sound
INDIRI4
RETI4
ADDRGP4 $268
JUMPV
line 950
;949:			}
;950:			break;
LABELV $284
line 954
;951:
;952:		case K_KP_HOME:
;953:		case K_HOME:
;954:			l->oldvalue = l->curvalue;
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 60
ADDP4
ADDRLP4 48
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ASGNI4
line 955
;955:			l->curvalue = 0;
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 0
ASGNI4
line 956
;956:			l->top      = 0;
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 958
;957:
;958:			if (l->oldvalue != l->curvalue && l->generic.callback)
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ADDRLP4 52
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
EQI4 $285
ADDRLP4 52
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $285
line 959
;959:			{
line 960
;960:				l->generic.callback( l, QM_GOTFOCUS );
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
CALLV
pop
line 961
;961:				return (menu_move_sound);
ADDRGP4 menu_move_sound
INDIRI4
RETI4
ADDRGP4 $268
JUMPV
LABELV $285
line 963
;962:			}
;963:			return (menu_buzz_sound);
ADDRGP4 menu_buzz_sound
INDIRI4
RETI4
ADDRGP4 $268
JUMPV
LABELV $287
line 967
;964:
;965:		case K_KP_END:
;966:		case K_END:
;967:			l->oldvalue = l->curvalue;
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 60
ADDP4
ADDRLP4 56
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ASGNI4
line 968
;968:			l->curvalue = l->numitems-1;
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 64
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 969
;969:			if( l->columns > 1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 1
LEI4 $288
line 970
;970:				c = (l->curvalue / l->height + 1) * l->height;
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
ADDRLP4 64
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ASGNI4
ADDRLP4 4
ADDRLP4 64
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ADDRLP4 68
INDIRI4
DIVI4
CNSTI4 1
ADDI4
ADDRLP4 68
INDIRI4
MULI4
ASGNI4
line 971
;971:				l->top = c - (l->columns * l->height);
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 4
INDIRI4
ADDRLP4 72
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
ADDRLP4 72
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
MULI4
SUBI4
ASGNI4
line 972
;972:			}
ADDRGP4 $289
JUMPV
LABELV $288
line 973
;973:			else {
line 974
;974:				l->top = l->curvalue - (l->height - 1);
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 64
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ADDRLP4 64
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 1
SUBI4
SUBI4
ASGNI4
line 975
;975:			}
LABELV $289
line 976
;976:			if (l->top < 0)
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
GEI4 $290
line 977
;977:				l->top = 0;			
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
LABELV $290
line 979
;978:
;979:			if (l->oldvalue != l->curvalue && l->generic.callback)
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ADDRLP4 64
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
EQI4 $292
ADDRLP4 64
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $292
line 980
;980:			{
line 981
;981:				l->generic.callback( l, QM_GOTFOCUS );
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
CALLV
pop
line 982
;982:				return (menu_move_sound);
ADDRGP4 menu_move_sound
INDIRI4
RETI4
ADDRGP4 $268
JUMPV
LABELV $292
line 984
;983:			}
;984:			return (menu_buzz_sound);
ADDRGP4 menu_buzz_sound
INDIRI4
RETI4
ADDRGP4 $268
JUMPV
LABELV $294
line 988
;985:
;986:		case K_PGUP:
;987:		case K_KP_PGUP:
;988:			if( l->columns > 1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 1
LEI4 $295
line 989
;989:				return menu_null_sound;
ADDRGP4 menu_null_sound
INDIRI4
RETI4
ADDRGP4 $268
JUMPV
LABELV $295
line 992
;990:			}
;991:
;992:			if (l->curvalue > 0)
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
CNSTI4 0
LEI4 $297
line 993
;993:			{
line 994
;994:				l->oldvalue = l->curvalue;
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 60
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ASGNI4
line 995
;995:				l->curvalue -= l->height-1;
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
ADDRLP4 72
INDIRP4
CNSTI4 64
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
ADDRLP4 72
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 1
SUBI4
SUBI4
ASGNI4
line 996
;996:				if (l->curvalue < 0)
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
CNSTI4 0
GEI4 $299
line 997
;997:					l->curvalue = 0;
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTI4 0
ASGNI4
LABELV $299
line 998
;998:				l->top = l->curvalue;
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 80
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ASGNI4
line 999
;999:				if (l->top < 0)
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
GEI4 $301
line 1000
;1000:					l->top = 0;
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
LABELV $301
line 1002
;1001:
;1002:				if (l->generic.callback)
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $303
line 1003
;1003:					l->generic.callback( l, QM_GOTFOCUS );
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 84
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
CALLV
pop
LABELV $303
line 1005
;1004:
;1005:				return (menu_move_sound);
ADDRGP4 menu_move_sound
INDIRI4
RETI4
ADDRGP4 $268
JUMPV
LABELV $297
line 1007
;1006:			}
;1007:			return (menu_buzz_sound);
ADDRGP4 menu_buzz_sound
INDIRI4
RETI4
ADDRGP4 $268
JUMPV
LABELV $305
line 1011
;1008:
;1009:		case K_PGDN:
;1010:		case K_KP_PGDN:
;1011:			if( l->columns > 1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 1
LEI4 $306
line 1012
;1012:				return menu_null_sound;
ADDRGP4 menu_null_sound
INDIRI4
RETI4
ADDRGP4 $268
JUMPV
LABELV $306
line 1015
;1013:			}
;1014:
;1015:			if (l->curvalue < l->numitems-1)
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ADDRLP4 68
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1
SUBI4
GEI4 $308
line 1016
;1016:			{
line 1017
;1017:				l->oldvalue = l->curvalue;
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 60
ADDP4
ADDRLP4 72
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ASGNI4
line 1018
;1018:				l->curvalue += l->height-1;
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
ADDRLP4 76
INDIRP4
CNSTI4 64
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRI4
ADDRLP4 76
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ADDI4
ASGNI4
line 1019
;1019:				if (l->curvalue > l->numitems-1)
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ADDRLP4 84
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1
SUBI4
LEI4 $310
line 1020
;1020:					l->curvalue = l->numitems-1;
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 64
ADDP4
ADDRLP4 88
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $310
line 1021
;1021:				l->top = l->curvalue - (l->height-1);
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 92
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ADDRLP4 92
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 1
SUBI4
SUBI4
ASGNI4
line 1022
;1022:				if (l->top < 0)
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
GEI4 $312
line 1023
;1023:					l->top = 0;
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
LABELV $312
line 1025
;1024:
;1025:				if (l->generic.callback)
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $314
line 1026
;1026:					l->generic.callback( l, QM_GOTFOCUS );
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 96
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
CALLV
pop
LABELV $314
line 1028
;1027:
;1028:				return (menu_move_sound);
ADDRGP4 menu_move_sound
INDIRI4
RETI4
ADDRGP4 $268
JUMPV
LABELV $308
line 1030
;1029:			}
;1030:			return (menu_buzz_sound);
ADDRGP4 menu_buzz_sound
INDIRI4
RETI4
ADDRGP4 $268
JUMPV
LABELV $316
line 1034
;1031:
;1032:		case K_KP_UPARROW:
;1033:		case K_UPARROW:
;1034:			if( l->curvalue == 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
CNSTI4 0
NEI4 $317
line 1035
;1035:				return menu_buzz_sound;
ADDRGP4 menu_buzz_sound
INDIRI4
RETI4
ADDRGP4 $268
JUMPV
LABELV $317
line 1038
;1036:			}
;1037:
;1038:			l->oldvalue = l->curvalue;
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 60
ADDP4
ADDRLP4 72
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ASGNI4
line 1039
;1039:			l->curvalue--;
ADDRLP4 76
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1041
;1040:
;1041:			if( l->curvalue < l->top ) {
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ADDRLP4 80
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
GEI4 $319
line 1042
;1042:				if( l->columns == 1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 1
NEI4 $321
line 1043
;1043:					l->top--;
ADDRLP4 84
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1044
;1044:				}
ADDRGP4 $322
JUMPV
LABELV $321
line 1045
;1045:				else {
line 1046
;1046:					l->top -= l->height;
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
ADDRLP4 84
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
ADDRLP4 84
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
SUBI4
ASGNI4
line 1047
;1047:				}
LABELV $322
line 1048
;1048:			}
LABELV $319
line 1050
;1049:
;1050:			if( l->generic.callback ) {
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $323
line 1051
;1051:				l->generic.callback( l, QM_GOTFOCUS );
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 84
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
CALLV
pop
line 1052
;1052:			}
LABELV $323
line 1054
;1053:
;1054:			return (menu_move_sound);
ADDRGP4 menu_move_sound
INDIRI4
RETI4
ADDRGP4 $268
JUMPV
LABELV $325
line 1058
;1055:
;1056:		case K_KP_DOWNARROW:
;1057:		case K_DOWNARROW:
;1058:			if( l->curvalue == l->numitems - 1 ) {
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ADDRLP4 84
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1
SUBI4
NEI4 $326
line 1059
;1059:				return menu_buzz_sound;
ADDRGP4 menu_buzz_sound
INDIRI4
RETI4
ADDRGP4 $268
JUMPV
LABELV $326
line 1062
;1060:			}
;1061:
;1062:			l->oldvalue = l->curvalue;
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 60
ADDP4
ADDRLP4 88
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ASGNI4
line 1063
;1063:			l->curvalue++;
ADDRLP4 92
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1065
;1064:
;1065:			if( l->curvalue >= l->top + l->columns * l->height ) {
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ADDRLP4 96
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
ADDRLP4 96
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
ADDRLP4 96
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
MULI4
ADDI4
LTI4 $328
line 1066
;1066:				if( l->columns == 1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 1
NEI4 $330
line 1067
;1067:					l->top++;
ADDRLP4 100
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1068
;1068:				}
ADDRGP4 $331
JUMPV
LABELV $330
line 1069
;1069:				else {
line 1070
;1070:					l->top += l->height;
ADDRLP4 100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 104
ADDRLP4 100
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRI4
ADDRLP4 100
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ADDI4
ASGNI4
line 1071
;1071:				}
LABELV $331
line 1072
;1072:			}
LABELV $328
line 1074
;1073:
;1074:			if( l->generic.callback ) {
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $332
line 1075
;1075:				l->generic.callback( l, QM_GOTFOCUS );
ADDRLP4 100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 100
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
CALLV
pop
line 1076
;1076:			}
LABELV $332
line 1078
;1077:
;1078:			return menu_move_sound;
ADDRGP4 menu_move_sound
INDIRI4
RETI4
ADDRGP4 $268
JUMPV
LABELV $334
line 1082
;1079:
;1080:		case K_KP_LEFTARROW:
;1081:		case K_LEFTARROW:
;1082:			if( l->columns == 1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 1
NEI4 $335
line 1083
;1083:				return menu_null_sound;
ADDRGP4 menu_null_sound
INDIRI4
RETI4
ADDRGP4 $268
JUMPV
LABELV $335
line 1086
;1084:			}
;1085:
;1086:			if( l->curvalue < l->height ) {
ADDRLP4 100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ADDRLP4 100
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
GEI4 $337
line 1087
;1087:				return menu_buzz_sound;
ADDRGP4 menu_buzz_sound
INDIRI4
RETI4
ADDRGP4 $268
JUMPV
LABELV $337
line 1090
;1088:			}
;1089:
;1090:			l->oldvalue = l->curvalue;
ADDRLP4 104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 104
INDIRP4
CNSTI4 60
ADDP4
ADDRLP4 104
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ASGNI4
line 1091
;1091:			l->curvalue -= l->height;
ADDRLP4 108
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 112
ADDRLP4 108
INDIRP4
CNSTI4 64
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRI4
ADDRLP4 108
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
SUBI4
ASGNI4
line 1093
;1092:
;1093:			if( l->curvalue < l->top ) {
ADDRLP4 116
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 116
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ADDRLP4 116
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
GEI4 $339
line 1094
;1094:				l->top -= l->height;
ADDRLP4 120
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 124
ADDRLP4 120
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 124
INDIRP4
ADDRLP4 124
INDIRP4
INDIRI4
ADDRLP4 120
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
SUBI4
ASGNI4
line 1095
;1095:			}
LABELV $339
line 1097
;1096:
;1097:			if( l->generic.callback ) {
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $341
line 1098
;1098:				l->generic.callback( l, QM_GOTFOCUS );
ADDRLP4 120
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 120
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 120
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
CALLV
pop
line 1099
;1099:			}
LABELV $341
line 1101
;1100:
;1101:			return menu_move_sound;
ADDRGP4 menu_move_sound
INDIRI4
RETI4
ADDRGP4 $268
JUMPV
LABELV $343
line 1105
;1102:
;1103:		case K_KP_RIGHTARROW:
;1104:		case K_RIGHTARROW:
;1105:			if( l->columns == 1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 1
NEI4 $344
line 1106
;1106:				return menu_null_sound;
ADDRGP4 menu_null_sound
INDIRI4
RETI4
ADDRGP4 $268
JUMPV
LABELV $344
line 1109
;1107:			}
;1108:
;1109:			c = l->curvalue + l->height;
ADDRLP4 120
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 120
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ADDRLP4 120
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ADDI4
ASGNI4
line 1111
;1110:
;1111:			if( c >= l->numitems ) {
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
LTI4 $346
line 1112
;1112:				return menu_buzz_sound;
ADDRGP4 menu_buzz_sound
INDIRI4
RETI4
ADDRGP4 $268
JUMPV
LABELV $346
line 1115
;1113:			}
;1114:
;1115:			l->oldvalue = l->curvalue;
ADDRLP4 124
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 124
INDIRP4
CNSTI4 60
ADDP4
ADDRLP4 124
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ASGNI4
line 1116
;1116:			l->curvalue = c;
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 1118
;1117:
;1118:			if( l->curvalue > l->top + l->columns * l->height - 1 ) {
ADDRLP4 128
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 128
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ADDRLP4 128
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
ADDRLP4 128
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
ADDRLP4 128
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
MULI4
ADDI4
CNSTI4 1
SUBI4
LEI4 $348
line 1119
;1119:				l->top += l->height;
ADDRLP4 132
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 136
ADDRLP4 132
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 136
INDIRP4
ADDRLP4 136
INDIRP4
INDIRI4
ADDRLP4 132
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ADDI4
ASGNI4
line 1120
;1120:			}
LABELV $348
line 1122
;1121:
;1122:			if( l->generic.callback ) {
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $350
line 1123
;1123:				l->generic.callback( l, QM_GOTFOCUS );
ADDRLP4 132
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 132
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 132
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
CALLV
pop
line 1124
;1124:			}
LABELV $350
line 1126
;1125:
;1126:			return menu_move_sound;
ADDRGP4 menu_move_sound
INDIRI4
RETI4
ADDRGP4 $268
JUMPV
LABELV $269
LABELV $270
line 1130
;1127:	}
;1128:
;1129:	// cycle look for ascii key inside list items
;1130:	if ( !Q_isprint( key ) )
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 Q_isprint
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $358
line 1131
;1131:		return (0);
CNSTI4 0
RETI4
ADDRGP4 $268
JUMPV
LABELV $358
line 1134
;1132:
;1133:	// force to lower for case insensitive compare
;1134:	if ( Q_isupper( key ) )
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 52
ADDRGP4 Q_isupper
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $360
line 1135
;1135:	{
line 1136
;1136:		key -= 'A' - 'a';
ADDRFP4 4
ADDRFP4 4
INDIRI4
CNSTI4 -32
SUBI4
ASGNI4
line 1137
;1137:	}
LABELV $360
line 1140
;1138:
;1139:	// iterate list items
;1140:	for (i=1; i<=l->numitems; i++)
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 $365
JUMPV
LABELV $362
line 1141
;1141:	{
line 1142
;1142:		j = (l->curvalue + i) % l->numitems;
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 56
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
ADDRLP4 56
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
MODI4
ASGNI4
line 1143
;1143:		c = l->itemnames[j][0];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRP4
ADDP4
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 1144
;1144:		if ( Q_isupper( c ) )
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 Q_isupper
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $366
line 1145
;1145:		{
line 1146
;1146:			c -= 'A' - 'a';
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 -32
SUBI4
ASGNI4
line 1147
;1147:		}
LABELV $366
line 1149
;1148:
;1149:		if (c == key)
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $368
line 1150
;1150:		{
line 1152
;1151:			// set current item, mimic windows listbox scroll behavior
;1152:			if (j < l->top)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
GEI4 $370
line 1153
;1153:			{
line 1155
;1154:				// behind top most item, set this as new top
;1155:				l->top = j;
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1156
;1156:			}
ADDRGP4 $371
JUMPV
LABELV $370
line 1157
;1157:			else if (j > l->top+l->height-1)
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
ADDRLP4 64
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
ADDRLP4 64
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ADDI4
CNSTI4 1
SUBI4
LEI4 $372
line 1158
;1158:			{
line 1160
;1159:				// past end of list box, do page down
;1160:				l->top = (j+1) - l->height;
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 72
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 68
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
SUBI4
ASGNI4
line 1161
;1161:			}
LABELV $372
LABELV $371
line 1163
;1162:			
;1163:			if (l->curvalue != j)
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $374
line 1164
;1164:			{
line 1165
;1165:				l->oldvalue = l->curvalue;
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 60
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ASGNI4
line 1166
;1166:				l->curvalue = j;
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1167
;1167:				if (l->generic.callback)
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $376
line 1168
;1168:					l->generic.callback( l, QM_GOTFOCUS );
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
CALLV
pop
LABELV $376
line 1169
;1169:				return ( menu_move_sound );			
ADDRGP4 menu_move_sound
INDIRI4
RETI4
ADDRGP4 $268
JUMPV
LABELV $374
line 1172
;1170:			}
;1171:
;1172:			return (menu_buzz_sound);
ADDRGP4 menu_buzz_sound
INDIRI4
RETI4
ADDRGP4 $268
JUMPV
LABELV $368
line 1174
;1173:		}
;1174:	}
LABELV $363
line 1140
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $365
ADDRLP4 8
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
LEI4 $362
line 1176
;1175:
;1176:	return (menu_buzz_sound);
ADDRGP4 menu_buzz_sound
INDIRI4
RETI4
LABELV $268
endproc ScrollList_Key 140 16
export ScrollList_Draw
proc ScrollList_Draw 52 20
line 1185
;1177:}
;1178:
;1179:/*
;1180:=================
;1181:ScrollList_Draw
;1182:=================
;1183:*/
;1184:void ScrollList_Draw( menulist_s *l )
;1185:{
line 1196
;1186:	int			x;
;1187:	int			u;
;1188:	int			y;
;1189:	int			i;
;1190:	int			base;
;1191:	int			column;
;1192:	float*		color;
;1193:	qboolean	hasfocus;
;1194:	int			style;
;1195:
;1196:	hasfocus = (l->generic.parent->cursor == l->generic.menuPosition);
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
INDIRI4
ADDRLP4 40
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $380
ADDRLP4 36
CNSTI4 1
ASGNI4
ADDRGP4 $381
JUMPV
LABELV $380
ADDRLP4 36
CNSTI4 0
ASGNI4
LABELV $381
ADDRLP4 28
ADDRLP4 36
INDIRI4
ASGNI4
line 1198
;1197:
;1198:	x =	l->generic.x;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1199
;1199:	for( column = 0; column < l->columns; column++ ) {
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRGP4 $385
JUMPV
LABELV $382
line 1200
;1200:		y =	l->generic.y;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 1201
;1201:		base = l->top + column * l->height;
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 44
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
ADDRLP4 32
INDIRI4
ADDRLP4 44
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
MULI4
ADDI4
ASGNI4
line 1202
;1202:		for( i = base; i < base + l->height; i++) {
ADDRLP4 0
ADDRLP4 24
INDIRI4
ASGNI4
ADDRGP4 $389
JUMPV
LABELV $386
line 1203
;1203:			if (i >= l->numitems)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
LTI4 $390
line 1204
;1204:				break;
ADDRGP4 $388
JUMPV
LABELV $390
line 1206
;1205:
;1206:			if (i == l->curvalue)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
NEI4 $392
line 1207
;1207:			{
line 1208
;1208:				u = x - 2;
ADDRLP4 20
ADDRLP4 16
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 1209
;1209:				if( l->generic.flags & QMF_CENTER_JUSTIFY ) {
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 8
BANDU4
CNSTU4 0
EQU4 $394
line 1210
;1210:					u -= (l->width * SMALLCHAR_WIDTH) / 2 + 1;
ADDRLP4 20
ADDRLP4 20
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 3
LSHI4
CNSTI4 2
DIVI4
CNSTI4 1
ADDI4
SUBI4
ASGNI4
line 1211
;1211:				}
LABELV $394
line 1213
;1212:
;1213:				UI_FillRect(u,y,l->width*SMALLCHAR_WIDTH,SMALLCHAR_HEIGHT+2,listbar_color);
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 3
LSHI4
CVIF4 4
ARGF4
CNSTF4 1099956224
ARGF4
ADDRGP4 listbar_color
ARGP4
ADDRGP4 UI_FillRect
CALLV
pop
line 1214
;1214:				color = text_color_highlight;
ADDRLP4 12
ADDRGP4 text_color_highlight
ASGNP4
line 1216
;1215:
;1216:				if (hasfocus)
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $396
line 1217
;1217:					style = UI_PULSE|UI_LEFT|UI_SMALLFONT;
ADDRLP4 8
CNSTI4 16400
ASGNI4
ADDRGP4 $393
JUMPV
LABELV $396
line 1219
;1218:				else
;1219:					style = UI_LEFT|UI_SMALLFONT;
ADDRLP4 8
CNSTI4 16
ASGNI4
line 1220
;1220:			}
ADDRGP4 $393
JUMPV
LABELV $392
line 1222
;1221:			else
;1222:			{
line 1223
;1223:				color = text_color_normal;
ADDRLP4 12
ADDRGP4 text_color_normal
ASGNP4
line 1224
;1224:				style = UI_LEFT|UI_SMALLFONT;
ADDRLP4 8
CNSTI4 16
ASGNI4
line 1225
;1225:			}
LABELV $393
line 1226
;1226:			if( l->generic.flags & QMF_CENTER_JUSTIFY ) {
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 8
BANDU4
CNSTU4 0
EQU4 $398
line 1227
;1227:				style |= UI_CENTER;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1228
;1228:			}
LABELV $398
line 1230
;1229:
;1230:			UI_DrawString(
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 1237
;1231:				x,
;1232:				y,
;1233:				l->itemnames[i],
;1234:				style,
;1235:				color);
;1236:
;1237:			y += SMALLCHAR_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 1238
;1238:		}
LABELV $387
line 1202
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $389
ADDRLP4 0
INDIRI4
ADDRLP4 24
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ADDI4
LTI4 $386
LABELV $388
line 1239
;1239:		x += (l->width + l->seperation) * SMALLCHAR_WIDTH;
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 48
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ADDRLP4 48
INDIRP4
CNSTI4 92
ADDP4
INDIRI4
ADDI4
CNSTI4 3
LSHI4
ADDI4
ASGNI4
line 1240
;1240:	}
LABELV $383
line 1199
ADDRLP4 32
ADDRLP4 32
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $385
ADDRLP4 32
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
LTI4 $382
line 1241
;1241:}
LABELV $378
endproc ScrollList_Draw 52 20
export Menu_AddItem
proc Menu_AddItem 40 8
line 1249
;1242:
;1243:/*
;1244:=================
;1245:Menu_AddItem
;1246:=================
;1247:*/
;1248:void Menu_AddItem( menuframework_s *menu, void *item )
;1249:{
line 1252
;1250:	menucommon_s	*itemptr;
;1251:
;1252:	if (menu->nitems >= MAX_MENUITEMS)
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 64
LTI4 $401
line 1253
;1253:		trap_Error ("Menu_AddItem: excessive items");
ADDRGP4 $403
ARGP4
ADDRGP4 trap_Error
CALLV
pop
LABELV $401
line 1255
;1254:
;1255:	menu->items[menu->nitems] = item;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDP4
ADDRFP4 4
INDIRP4
ASGNP4
line 1256
;1256:	((menucommon_s*)menu->items[menu->nitems])->parent        = menu;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
ADDP4
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 8
INDIRP4
ASGNP4
line 1257
;1257:	((menucommon_s*)menu->items[menu->nitems])->menuPosition  = menu->nitems;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
ADDP4
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1258
;1258:	((menucommon_s*)menu->items[menu->nitems])->flags        &= ~QMF_HASMOUSEFOCUS;
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 20
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
ADDP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRU4
CNSTU4 4294966783
BANDU4
ASGNU4
line 1261
;1259:
;1260:	// perform any item specific initializations
;1261:	itemptr = (menucommon_s*)item;
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
line 1262
;1262:	if (!(itemptr->flags & QMF_NODEFAULTINIT))
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 32768
BANDU4
CNSTU4 0
NEU4 $404
line 1263
;1263:	{
line 1264
;1264:		switch (itemptr->type)
ADDRLP4 28
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 1
LTI4 $406
ADDRLP4 28
INDIRI4
CNSTI4 10
GTI4 $406
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $420-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $420
address $413
address $409
address $411
address $410
address $412
address $414
address $415
address $416
address $417
address $418
code
line 1265
;1265:		{
LABELV $409
line 1267
;1266:			case MTYPE_ACTION:
;1267:				Action_Init((menuaction_s*)item);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Action_Init
CALLV
pop
line 1268
;1268:				break;
ADDRGP4 $407
JUMPV
LABELV $410
line 1271
;1269:
;1270:			case MTYPE_FIELD:
;1271:				MenuField_Init((menufield_s*)item);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 MenuField_Init
CALLV
pop
line 1272
;1272:				break;
ADDRGP4 $407
JUMPV
LABELV $411
line 1275
;1273:
;1274:			case MTYPE_SPINCONTROL:
;1275:				SpinControl_Init((menulist_s*)item);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 SpinControl_Init
CALLV
pop
line 1276
;1276:				break;
ADDRGP4 $407
JUMPV
LABELV $412
line 1279
;1277:
;1278:			case MTYPE_RADIOBUTTON:
;1279:				RadioButton_Init((menuradiobutton_s*)item);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 RadioButton_Init
CALLV
pop
line 1280
;1280:				break;
ADDRGP4 $407
JUMPV
LABELV $413
line 1283
;1281:
;1282:			case MTYPE_SLIDER:
;1283:				Slider_Init((menuslider_s*)item);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Slider_Init
CALLV
pop
line 1284
;1284:				break;
ADDRGP4 $407
JUMPV
LABELV $414
line 1287
;1285:
;1286:			case MTYPE_BITMAP:
;1287:				Bitmap_Init((menubitmap_s*)item);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Bitmap_Init
CALLV
pop
line 1288
;1288:				break;
ADDRGP4 $407
JUMPV
LABELV $415
line 1291
;1289:
;1290:			case MTYPE_TEXT:
;1291:				Text_Init((menutext_s*)item);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Text_Init
CALLV
pop
line 1292
;1292:				break;
ADDRGP4 $407
JUMPV
LABELV $416
line 1295
;1293:
;1294:			case MTYPE_SCROLLLIST:
;1295:				ScrollList_Init((menulist_s*)item);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 ScrollList_Init
CALLV
pop
line 1296
;1296:				break;
ADDRGP4 $407
JUMPV
LABELV $417
line 1299
;1297:
;1298:			case MTYPE_PTEXT:
;1299:				PText_Init((menutext_s*)item);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 PText_Init
CALLV
pop
line 1300
;1300:				break;
ADDRGP4 $407
JUMPV
LABELV $418
line 1303
;1301:
;1302:			case MTYPE_BTEXT:
;1303:				BText_Init((menutext_s*)item);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BText_Init
CALLV
pop
line 1304
;1304:				break;
ADDRGP4 $407
JUMPV
LABELV $406
line 1307
;1305:
;1306:			default:
;1307:				trap_Error( va("Menu_Init: unknown type %d", itemptr->type) );
ADDRGP4 $419
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 trap_Error
CALLV
pop
line 1308
;1308:		}
LABELV $407
line 1309
;1309:	}
LABELV $404
line 1311
;1310:
;1311:	menu->nitems++;
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1312
;1312:}
LABELV $400
endproc Menu_AddItem 40 8
export Menu_CursorMoved
proc Menu_CursorMoved 32 8
line 1320
;1313:
;1314:/*
;1315:=================
;1316:Menu_CursorMoved
;1317:=================
;1318:*/
;1319:void Menu_CursorMoved( menuframework_s *m )
;1320:{
line 1323
;1321:	void (*callback)( void *self, int notification );
;1322:	
;1323:	if (m->cursor_prev == m->cursor)
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
INDIRI4
NEI4 $423
line 1324
;1324:		return;
ADDRGP4 $422
JUMPV
LABELV $423
line 1326
;1325:
;1326:	if (m->cursor_prev >= 0 && m->cursor_prev < m->nitems)
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
LTI4 $425
ADDRLP4 12
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
GEI4 $425
line 1327
;1327:	{
line 1328
;1328:		callback = ((menucommon_s*)(m->items[m->cursor_prev]))->callback;
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
ADDP4
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
ASGNP4
line 1329
;1329:		if (callback)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $427
line 1330
;1330:			callback(m->items[m->cursor_prev],QM_LOSTFOCUS);
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
CNSTI4 2
ASGNI4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
LSHI4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CALLV
pop
LABELV $427
line 1331
;1331:	}
LABELV $425
line 1333
;1332:	
;1333:	if (m->cursor >= 0 && m->cursor < m->nitems)
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 16
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
LTI4 $429
ADDRLP4 20
INDIRI4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
GEI4 $429
line 1334
;1334:	{
line 1335
;1335:		callback = ((menucommon_s*)(m->items[m->cursor]))->callback;
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 24
INDIRP4
CNSTI4 12
ADDP4
ADDP4
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
ASGNP4
line 1336
;1336:		if (callback)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $431
line 1337
;1337:			callback(m->items[m->cursor],QM_GOTFOCUS);
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 28
INDIRP4
CNSTI4 12
ADDP4
ADDP4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CALLV
pop
LABELV $431
line 1338
;1338:	}
LABELV $429
line 1339
;1339:}
LABELV $422
endproc Menu_CursorMoved 32 8
export Menu_SetCursor
proc Menu_SetCursor 4 4
line 1347
;1340:
;1341:/*
;1342:=================
;1343:Menu_SetCursor
;1344:=================
;1345:*/
;1346:void Menu_SetCursor( menuframework_s *m, int cursor )
;1347:{
line 1348
;1348:	if (((menucommon_s*)(m->items[cursor]))->flags & (QMF_GRAYED|QMF_INACTIVE))
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDP4
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 24576
BANDU4
CNSTU4 0
EQU4 $434
line 1349
;1349:	{
line 1351
;1350:		// cursor can't go there
;1351:		return;
ADDRGP4 $433
JUMPV
LABELV $434
line 1354
;1352:	}
;1353:
;1354:	m->cursor_prev = m->cursor;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 1355
;1355:	m->cursor      = cursor;
ADDRFP4 0
INDIRP4
ADDRFP4 4
INDIRI4
ASGNI4
line 1357
;1356:
;1357:	Menu_CursorMoved( m );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_CursorMoved
CALLV
pop
line 1358
;1358:}
LABELV $433
endproc Menu_SetCursor 4 4
export Menu_SetCursorToItem
proc Menu_SetCursorToItem 4 8
line 1365
;1359:
;1360:/*
;1361:=================
;1362:Menu_SetCursorToItem
;1363:=================
;1364:*/
;1365:void Menu_SetCursorToItem( menuframework_s *m, void* ptr ) {
line 1368
;1366:	int	i;
;1367:
;1368:	for (i=0; i<m->nitems; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $440
JUMPV
LABELV $437
line 1369
;1369:		if (m->items[i] == ptr) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
NEU4 $441
line 1370
;1370:			Menu_SetCursor( m, i );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Menu_SetCursor
CALLV
pop
line 1371
;1371:			return;
ADDRGP4 $436
JUMPV
LABELV $441
line 1373
;1372:		}
;1373:	}
LABELV $438
line 1368
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $440
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
LTI4 $437
line 1374
;1374:}
LABELV $436
endproc Menu_SetCursorToItem 4 8
export Menu_AdjustCursor
proc Menu_AdjustCursor 24 0
line 1383
;1375:
;1376:/*
;1377:** Menu_AdjustCursor
;1378:**
;1379:** This function takes the given menu, the direction, and attempts
;1380:** to adjust the menu's cursor so that it's at the next available
;1381:** slot.
;1382:*/
;1383:void Menu_AdjustCursor( menuframework_s *m, int dir ) {
line 1384
;1384:	menucommon_s	*item = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 1385
;1385:	qboolean		wrapped = qfalse;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $446
JUMPV
LABELV $445
line 1388
;1386:
;1387:wrap:
;1388:	while ( m->cursor >= 0 && m->cursor < m->nitems ) {
line 1389
;1389:		item = ( menucommon_s * ) m->items[m->cursor];
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
ADDP4
INDIRP4
ASGNP4
line 1390
;1390:		if (( item->flags & (QMF_GRAYED|QMF_MOUSEONLY|QMF_INACTIVE) ) ) {
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 26624
BANDU4
CNSTU4 0
EQU4 $447
line 1391
;1391:			m->cursor += dir;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
ADDRFP4 4
INDIRI4
ADDI4
ASGNI4
line 1392
;1392:		} else {
line 1393
;1393:			break;
LABELV $449
line 1395
;1394:		}
;1395:	}
LABELV $446
line 1388
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 8
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
LTI4 $450
ADDRLP4 12
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
LTI4 $445
LABELV $450
LABELV $447
line 1397
;1396:
;1397:	if ( dir == 1 ) {
ADDRFP4 4
INDIRI4
CNSTI4 1
NEI4 $451
line 1398
;1398:		if ( m->cursor >= m->nitems ) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRI4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
LTI4 $452
line 1399
;1399:			if ( m->wrapAround ) {
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 0
EQI4 $455
line 1400
;1400:				if ( wrapped ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $457
line 1401
;1401:					m->cursor = m->cursor_prev;
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1402
;1402:					return;
ADDRGP4 $443
JUMPV
LABELV $457
line 1404
;1403:				}
;1404:				m->cursor = 0;
ADDRFP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 1405
;1405:				wrapped = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 1406
;1406:				goto wrap;
ADDRGP4 $446
JUMPV
LABELV $455
line 1408
;1407:			}
;1408:			m->cursor = m->cursor_prev;
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1409
;1409:		}
line 1410
;1410:	} else {
ADDRGP4 $452
JUMPV
LABELV $451
line 1411
;1411:		if ( m->cursor < 0 ) {
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 0
GEI4 $459
line 1412
;1412:			if ( m->wrapAround ) {
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 0
EQI4 $461
line 1413
;1413:				if ( wrapped ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $463
line 1414
;1414:					m->cursor = m->cursor_prev;
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1415
;1415:					return;
ADDRGP4 $443
JUMPV
LABELV $463
line 1417
;1416:				}
;1417:				m->cursor = m->nitems - 1;
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1418
;1418:				wrapped = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 1419
;1419:				goto wrap;
ADDRGP4 $446
JUMPV
LABELV $461
line 1421
;1420:			}
;1421:			m->cursor = m->cursor_prev;
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1422
;1422:		}
LABELV $459
line 1423
;1423:	}
LABELV $452
line 1424
;1424:}
LABELV $443
endproc Menu_AdjustCursor 24 0
export Menu_Draw
proc Menu_Draw 32 20
line 1432
;1425:
;1426:/*
;1427:=================
;1428:Menu_Draw
;1429:=================
;1430:*/
;1431:void Menu_Draw( menuframework_s *menu )
;1432:{
line 1437
;1433:	int				i;
;1434:	menucommon_s	*itemptr;
;1435:
;1436:	// draw menu
;1437:	for (i=0; i<menu->nitems; i++)
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $469
JUMPV
LABELV $466
line 1438
;1438:	{
line 1439
;1439:		itemptr = (menucommon_s*)menu->items[i];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDP4
INDIRP4
ASGNP4
line 1441
;1440:
;1441:		if (itemptr->flags & QMF_HIDDEN)
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 4096
BANDU4
CNSTU4 0
EQU4 $470
line 1442
;1442:			continue;
ADDRGP4 $467
JUMPV
LABELV $470
line 1444
;1443:
;1444:		if (itemptr->ownerdraw)
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $472
line 1445
;1445:		{
line 1447
;1446:			// total subclassing, owner draws everything
;1447:			itemptr->ownerdraw( itemptr );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
INDIRP4
CALLV
pop
line 1448
;1448:		}	
ADDRGP4 $473
JUMPV
LABELV $472
line 1450
;1449:		else 
;1450:		{
line 1451
;1451:			switch (itemptr->type)
ADDRLP4 8
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 1
LTI4 $474
ADDRLP4 8
INDIRI4
CNSTI4 10
GTI4 $474
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $488-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $488
address $479
address $481
address $480
address $478
address $477
address $482
address $483
address $484
address $485
address $486
code
line 1452
;1452:			{	
LABELV $477
line 1454
;1453:				case MTYPE_RADIOBUTTON:
;1454:					RadioButton_Draw( (menuradiobutton_s*)itemptr );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 RadioButton_Draw
CALLV
pop
line 1455
;1455:					break;
ADDRGP4 $475
JUMPV
LABELV $478
line 1458
;1456:
;1457:				case MTYPE_FIELD:
;1458:					MenuField_Draw( (menufield_s*)itemptr );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 MenuField_Draw
CALLV
pop
line 1459
;1459:					break;
ADDRGP4 $475
JUMPV
LABELV $479
line 1462
;1460:		
;1461:				case MTYPE_SLIDER:
;1462:					Slider_Draw( (menuslider_s*)itemptr );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Slider_Draw
CALLV
pop
line 1463
;1463:					break;
ADDRGP4 $475
JUMPV
LABELV $480
line 1466
;1464: 
;1465:				case MTYPE_SPINCONTROL:
;1466:					SpinControl_Draw( (menulist_s*)itemptr );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 SpinControl_Draw
CALLV
pop
line 1467
;1467:					break;
ADDRGP4 $475
JUMPV
LABELV $481
line 1470
;1468:		
;1469:				case MTYPE_ACTION:
;1470:					Action_Draw( (menuaction_s*)itemptr );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Action_Draw
CALLV
pop
line 1471
;1471:					break;
ADDRGP4 $475
JUMPV
LABELV $482
line 1474
;1472:		
;1473:				case MTYPE_BITMAP:
;1474:					Bitmap_Draw( (menubitmap_s*)itemptr );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Bitmap_Draw
CALLV
pop
line 1475
;1475:					break;
ADDRGP4 $475
JUMPV
LABELV $483
line 1478
;1476:
;1477:				case MTYPE_TEXT:
;1478:					Text_Draw( (menutext_s*)itemptr );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Text_Draw
CALLV
pop
line 1479
;1479:					break;
ADDRGP4 $475
JUMPV
LABELV $484
line 1482
;1480:
;1481:				case MTYPE_SCROLLLIST:
;1482:					ScrollList_Draw( (menulist_s*)itemptr );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 ScrollList_Draw
CALLV
pop
line 1483
;1483:					break;
ADDRGP4 $475
JUMPV
LABELV $485
line 1486
;1484:				
;1485:				case MTYPE_PTEXT:
;1486:					PText_Draw( (menutext_s*)itemptr );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 PText_Draw
CALLV
pop
line 1487
;1487:					break;
ADDRGP4 $475
JUMPV
LABELV $486
line 1490
;1488:
;1489:				case MTYPE_BTEXT:
;1490:					BText_Draw( (menutext_s*)itemptr );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 BText_Draw
CALLV
pop
line 1491
;1491:					break;
ADDRGP4 $475
JUMPV
LABELV $474
line 1494
;1492:
;1493:				default:
;1494:					trap_Error( va("Menu_Draw: unknown type %d", itemptr->type) );
ADDRGP4 $487
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_Error
CALLV
pop
line 1495
;1495:			}
LABELV $475
line 1496
;1496:		}
LABELV $473
line 1498
;1497:#ifndef NDEBUG
;1498:		if( uis.debug ) {
ADDRGP4 uis+11388
INDIRI4
CNSTI4 0
EQI4 $490
line 1504
;1499:			int	x;
;1500:			int	y;
;1501:			int	w;
;1502:			int	h;
;1503:
;1504:			if( !( itemptr->flags & QMF_INACTIVE ) ) {
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 16384
BANDU4
CNSTU4 0
NEU4 $493
line 1505
;1505:				x = itemptr->left;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ASGNI4
line 1506
;1506:				y = itemptr->top;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
ASGNI4
line 1507
;1507:				w = itemptr->right - itemptr->left + 1;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 1508
;1508:				h =	itemptr->bottom - itemptr->top + 1;
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 1510
;1509:
;1510:				if (itemptr->flags & QMF_HASMOUSEFOCUS) {
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 512
BANDU4
CNSTU4 0
EQU4 $495
line 1511
;1511:					UI_DrawRect(x, y, w, h, colorYellow );
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 colorYellow
ARGP4
ADDRGP4 UI_DrawRect
CALLV
pop
line 1512
;1512:				}
ADDRGP4 $496
JUMPV
LABELV $495
line 1513
;1513:				else {
line 1514
;1514:					UI_DrawRect(x, y, w, h, colorWhite );
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawRect
CALLV
pop
line 1515
;1515:				}
LABELV $496
line 1516
;1516:			}
LABELV $493
line 1517
;1517:		}
LABELV $490
line 1519
;1518:#endif
;1519:	}
LABELV $467
line 1437
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $469
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
LTI4 $466
line 1521
;1520:
;1521:	itemptr = Menu_ItemAtCursor( menu );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Menu_ItemAtCursor
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 1522
;1522:	if ( itemptr && itemptr->statusbar)
ADDRLP4 16
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRU4
EQU4 $497
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRU4
EQU4 $497
line 1523
;1523:		itemptr->statusbar( ( void * ) itemptr );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRP4
CALLV
pop
LABELV $497
line 1524
;1524:}
LABELV $465
endproc Menu_Draw 32 20
export Menu_ItemAtCursor
proc Menu_ItemAtCursor 12 0
line 1532
;1525:
;1526:/*
;1527:=================
;1528:Menu_ItemAtCursor
;1529:=================
;1530:*/
;1531:void *Menu_ItemAtCursor( menuframework_s *m )
;1532:{
line 1533
;1533:	if ( m->cursor < 0 || m->cursor >= m->nitems )
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $502
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
LTI4 $500
LABELV $502
line 1534
;1534:		return 0;
CNSTP4 0
RETP4
ADDRGP4 $499
JUMPV
LABELV $500
line 1536
;1535:
;1536:	return m->items[m->cursor];
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
ADDP4
INDIRP4
RETP4
LABELV $499
endproc Menu_ItemAtCursor 12 0
export Menu_ActivateItem
proc Menu_ActivateItem 4 8
line 1544
;1537:}
;1538:
;1539:/*
;1540:=================
;1541:Menu_ActivateItem
;1542:=================
;1543:*/
;1544:sfxHandle_t Menu_ActivateItem( menuframework_s *s, menucommon_s* item ) {
line 1545
;1545:	if ( item->callback ) {
ADDRFP4 4
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $504
line 1546
;1546:		item->callback( item, QM_ACTIVATED );
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 3
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
CALLV
pop
line 1547
;1547:		if( !( item->flags & QMF_SILENT ) ) {
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 1048576
BANDU4
CNSTU4 0
NEU4 $506
line 1548
;1548:			return menu_move_sound;
ADDRGP4 menu_move_sound
INDIRI4
RETI4
ADDRGP4 $503
JUMPV
LABELV $506
line 1550
;1549:		}
;1550:	}
LABELV $504
line 1552
;1551:
;1552:	return 0;
CNSTI4 0
RETI4
LABELV $503
endproc Menu_ActivateItem 4 8
export Menu_DefaultKey
proc Menu_DefaultKey 108 8
line 1561
;1553:}
;1554:
;1555:/*
;1556:=================
;1557:Menu_DefaultKey
;1558:=================
;1559:*/
;1560:sfxHandle_t Menu_DefaultKey( menuframework_s *m, int key )
;1561:{
line 1562
;1562:	sfxHandle_t		sound = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1567
;1563:	menucommon_s	*item;
;1564:	int				cursor_prev;
;1565:
;1566:	// menu system keys
;1567:	switch ( key )
ADDRLP4 12
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 16
CNSTI4 27
ASGNI4
ADDRLP4 12
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $511
ADDRLP4 12
INDIRI4
ADDRLP4 16
INDIRI4
LTI4 $509
LABELV $512
ADDRFP4 4
INDIRI4
CNSTI4 179
EQI4 $511
ADDRGP4 $509
JUMPV
line 1568
;1568:	{
LABELV $511
line 1571
;1569:		case K_MOUSE2:
;1570:		case K_ESCAPE:
;1571:			UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 1572
;1572:			return menu_out_sound;
ADDRGP4 menu_out_sound
INDIRI4
RETI4
ADDRGP4 $508
JUMPV
LABELV $509
line 1575
;1573:	}
;1574:
;1575:	if (!m || !m->nitems)
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $515
ADDRLP4 20
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 0
NEI4 $513
LABELV $515
line 1576
;1576:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $508
JUMPV
LABELV $513
line 1579
;1577:
;1578:	// route key stimulus to widget
;1579:	item = Menu_ItemAtCursor( m );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 Menu_ItemAtCursor
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
ASGNP4
line 1580
;1580:	if (item && !(item->flags & (QMF_GRAYED|QMF_INACTIVE)))
ADDRLP4 32
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 32
INDIRU4
EQU4 $516
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 24576
BANDU4
ADDRLP4 32
INDIRU4
NEU4 $516
line 1581
;1581:	{
line 1582
;1582:		switch (item->type)
ADDRLP4 36
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 1
LTI4 $518
ADDRLP4 36
INDIRI4
CNSTI4 8
GTI4 $518
ADDRLP4 36
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $526-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $526
address $523
address $518
address $521
address $525
address $522
address $518
address $518
address $524
code
line 1583
;1583:		{
LABELV $521
line 1585
;1584:			case MTYPE_SPINCONTROL:
;1585:				sound = SpinControl_Key( (menulist_s*)item, key );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 SpinControl_Key
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 44
INDIRI4
ASGNI4
line 1586
;1586:				break;
ADDRGP4 $519
JUMPV
LABELV $522
line 1589
;1587:
;1588:			case MTYPE_RADIOBUTTON:
;1589:				sound = RadioButton_Key( (menuradiobutton_s*)item, key );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 RadioButton_Key
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 48
INDIRI4
ASGNI4
line 1590
;1590:				break;
ADDRGP4 $519
JUMPV
LABELV $523
line 1593
;1591:
;1592:			case MTYPE_SLIDER:
;1593:				sound = Slider_Key( (menuslider_s*)item, key );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 52
ADDRGP4 Slider_Key
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 52
INDIRI4
ASGNI4
line 1594
;1594:				break;
ADDRGP4 $519
JUMPV
LABELV $524
line 1597
;1595:
;1596:			case MTYPE_SCROLLLIST:
;1597:				sound = ScrollList_Key( (menulist_s*)item, key );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 56
ADDRGP4 ScrollList_Key
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 56
INDIRI4
ASGNI4
line 1598
;1598:				break;
ADDRGP4 $519
JUMPV
LABELV $525
line 1601
;1599:
;1600:			case MTYPE_FIELD:
;1601:				sound = MenuField_Key( (menufield_s*)item, &key );
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
ARGP4
ADDRLP4 60
ADDRGP4 MenuField_Key
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 60
INDIRI4
ASGNI4
line 1602
;1602:				break;
LABELV $518
LABELV $519
line 1605
;1603:		}
;1604:
;1605:		if (sound) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $528
line 1607
;1606:			// key was handled
;1607:			return sound;		
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $508
JUMPV
LABELV $528
line 1609
;1608:		}
;1609:	}
LABELV $516
line 1612
;1610:
;1611:	// default handling
;1612:	switch ( key )
ADDRLP4 36
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 155
EQI4 $532
ADDRLP4 40
CNSTI4 156
ASGNI4
ADDRLP4 36
INDIRI4
ADDRLP4 40
INDIRI4
EQI4 $534
ADDRLP4 36
INDIRI4
ADDRLP4 40
INDIRI4
GTI4 $553
LABELV $552
ADDRLP4 44
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 48
CNSTI4 13
ASGNI4
ADDRLP4 44
INDIRI4
ADDRLP4 48
INDIRI4
EQI4 $547
ADDRLP4 44
INDIRI4
ADDRLP4 48
INDIRI4
GTI4 $555
LABELV $554
ADDRFP4 4
INDIRI4
CNSTI4 9
EQI4 $539
ADDRGP4 $530
JUMPV
LABELV $555
ADDRLP4 52
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 132
EQI4 $536
ADDRLP4 52
INDIRI4
CNSTI4 133
EQI4 $539
ADDRGP4 $530
JUMPV
LABELV $553
ADDRLP4 56
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 167
EQI4 $539
ADDRLP4 60
CNSTI4 169
ASGNI4
ADDRLP4 56
INDIRI4
ADDRLP4 60
INDIRI4
EQI4 $547
ADDRLP4 56
INDIRI4
ADDRLP4 60
INDIRI4
GTI4 $557
LABELV $556
ADDRFP4 4
INDIRI4
CNSTI4 161
EQI4 $536
ADDRGP4 $530
JUMPV
LABELV $557
ADDRLP4 64
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 178
LTI4 $530
ADDRLP4 64
INDIRI4
CNSTI4 188
GTI4 $558
ADDRLP4 64
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $559-712
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $559
address $542
address $530
address $542
address $530
address $530
address $530
address $530
address $547
address $547
address $547
address $547
code
LABELV $558
ADDRLP4 68
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 217
LTI4 $530
ADDRLP4 68
INDIRI4
CNSTI4 232
GTI4 $530
ADDRLP4 68
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $561-868
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $561
address $547
address $547
address $547
address $547
address $547
address $547
address $547
address $547
address $547
address $547
address $547
address $547
address $547
address $547
address $547
address $547
code
line 1613
;1613:	{
LABELV $532
line 1616
;1614:#ifndef NDEBUG
;1615:		case K_F11:
;1616:			uis.debug ^= 1;
ADDRLP4 72
ADDRGP4 uis+11388
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 1617
;1617:			break;
ADDRGP4 $531
JUMPV
LABELV $534
line 1620
;1618:
;1619:		case K_F12:
;1620:			trap_Cmd_ExecuteText(EXEC_APPEND, "screenshot\n");
CNSTI4 2
ARGI4
ADDRGP4 $535
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 1621
;1621:			break;
ADDRGP4 $531
JUMPV
LABELV $536
line 1625
;1622:#endif
;1623:		case K_KP_UPARROW:
;1624:		case K_UPARROW:
;1625:			cursor_prev    = m->cursor;
ADDRLP4 8
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 1626
;1626:			m->cursor_prev = m->cursor;
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 76
INDIRP4
INDIRI4
ASGNI4
line 1627
;1627:			m->cursor--;
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1628
;1628:			Menu_AdjustCursor( m, -1 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 Menu_AdjustCursor
CALLV
pop
line 1629
;1629:			if ( cursor_prev != m->cursor ) {
ADDRLP4 8
INDIRI4
ADDRFP4 0
INDIRP4
INDIRI4
EQI4 $531
line 1630
;1630:				Menu_CursorMoved( m );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_CursorMoved
CALLV
pop
line 1631
;1631:				sound = menu_move_sound;
ADDRLP4 4
ADDRGP4 menu_move_sound
INDIRI4
ASGNI4
line 1632
;1632:			}
line 1633
;1633:			break;
ADDRGP4 $531
JUMPV
LABELV $539
line 1638
;1634:
;1635:		case K_TAB:
;1636:		case K_KP_DOWNARROW:
;1637:		case K_DOWNARROW:
;1638:			cursor_prev    = m->cursor;
ADDRLP4 8
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 1639
;1639:			m->cursor_prev = m->cursor;
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 84
INDIRP4
INDIRI4
ASGNI4
line 1640
;1640:			m->cursor++;
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1641
;1641:			Menu_AdjustCursor( m, 1 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_AdjustCursor
CALLV
pop
line 1642
;1642:			if ( cursor_prev != m->cursor ) {
ADDRLP4 8
INDIRI4
ADDRFP4 0
INDIRP4
INDIRI4
EQI4 $531
line 1643
;1643:				Menu_CursorMoved( m );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_CursorMoved
CALLV
pop
line 1644
;1644:				sound = menu_move_sound;
ADDRLP4 4
ADDRGP4 menu_move_sound
INDIRI4
ASGNI4
line 1645
;1645:			}
line 1646
;1646:			break;
ADDRGP4 $531
JUMPV
LABELV $542
line 1650
;1647:
;1648:		case K_MOUSE1:
;1649:		case K_MOUSE3:
;1650:			if (item)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $531
line 1651
;1651:				if ((item->flags & QMF_HASMOUSEFOCUS) && !(item->flags & (QMF_GRAYED|QMF_INACTIVE)))
ADDRLP4 92
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
ASGNU4
ADDRLP4 96
CNSTU4 0
ASGNU4
ADDRLP4 92
INDIRU4
CNSTU4 512
BANDU4
ADDRLP4 96
INDIRU4
EQU4 $531
ADDRLP4 92
INDIRU4
CNSTU4 24576
BANDU4
ADDRLP4 96
INDIRU4
NEU4 $531
line 1652
;1652:					return (Menu_ActivateItem( m, item ));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 Menu_ActivateItem
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
RETI4
ADDRGP4 $508
JUMPV
line 1653
;1653:			break;
LABELV $547
line 1677
;1654:
;1655:		case K_JOY1:
;1656:		case K_JOY2:
;1657:		case K_JOY3:
;1658:		case K_JOY4:
;1659:		case K_AUX1:
;1660:		case K_AUX2:
;1661:		case K_AUX3:
;1662:		case K_AUX4:
;1663:		case K_AUX5:
;1664:		case K_AUX6:
;1665:		case K_AUX7:
;1666:		case K_AUX8:
;1667:		case K_AUX9:
;1668:		case K_AUX10:
;1669:		case K_AUX11:
;1670:		case K_AUX12:
;1671:		case K_AUX13:
;1672:		case K_AUX14:
;1673:		case K_AUX15:
;1674:		case K_AUX16:
;1675:		case K_KP_ENTER:
;1676:		case K_ENTER:
;1677:			if (item)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $531
line 1678
;1678:				if (!(item->flags & (QMF_MOUSEONLY|QMF_GRAYED|QMF_INACTIVE)))
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRU4
CNSTU4 26624
BANDU4
CNSTU4 0
NEU4 $531
line 1679
;1679:					return (Menu_ActivateItem( m, item ));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 104
ADDRGP4 Menu_ActivateItem
CALLI4
ASGNI4
ADDRLP4 104
INDIRI4
RETI4
ADDRGP4 $508
JUMPV
line 1680
;1680:			break;
LABELV $530
LABELV $531
line 1683
;1681:	}
;1682:
;1683:	return sound;
ADDRLP4 4
INDIRI4
RETI4
LABELV $508
endproc Menu_DefaultKey 108 8
export Menu_Cache
proc Menu_Cache 76 8
line 1692
;1684:}
;1685:
;1686:/*
;1687:=================
;1688:Menu_Cache
;1689:=================
;1690:*/
;1691:void Menu_Cache( void )
;1692:{
line 1693
;1693:	uis.charset			= trap_R_RegisterShaderNoMip( "gfx/2d/bigchars" );
ADDRGP4 $565
ARGP4
ADDRLP4 0
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uis+11404
ADDRLP4 0
INDIRI4
ASGNI4
line 1694
;1694:	uis.charsetProp		= trap_R_RegisterShaderNoMip( "menu/art/font1_prop.tga" );
ADDRGP4 $567
ARGP4
ADDRLP4 4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uis+11408
ADDRLP4 4
INDIRI4
ASGNI4
line 1695
;1695:	uis.charsetPropGlow	= trap_R_RegisterShaderNoMip( "menu/art/font1_prop_glo.tga" );
ADDRGP4 $569
ARGP4
ADDRLP4 8
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uis+11412
ADDRLP4 8
INDIRI4
ASGNI4
line 1696
;1696:	uis.charsetPropB	= trap_R_RegisterShaderNoMip( "menu/art/font2_prop.tga" );
ADDRGP4 $571
ARGP4
ADDRLP4 12
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uis+11416
ADDRLP4 12
INDIRI4
ASGNI4
line 1697
;1697:	uis.cursor          = trap_R_RegisterShaderNoMip( "menu/art/3_cursor2" );
ADDRGP4 $573
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uis+11420
ADDRLP4 16
INDIRI4
ASGNI4
line 1698
;1698:	uis.rb_on           = trap_R_RegisterShaderNoMip( "menu/art/switch_on" );
ADDRGP4 $575
ARGP4
ADDRLP4 20
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uis+11428
ADDRLP4 20
INDIRI4
ASGNI4
line 1699
;1699:	uis.rb_off          = trap_R_RegisterShaderNoMip( "menu/art/switch_off" );
ADDRGP4 $577
ARGP4
ADDRLP4 24
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uis+11432
ADDRLP4 24
INDIRI4
ASGNI4
line 1701
;1700:
;1701:	uis.whiteShader = trap_R_RegisterShaderNoMip( "white" );
ADDRGP4 $579
ARGP4
ADDRLP4 28
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uis+11392
ADDRLP4 28
INDIRI4
ASGNI4
line 1708
;1702:	//if ( uis.glconfig.hardwareType == GLHW_RAGEPRO ) {
;1703:		// the blend effect turns to shit with the normal 
;1704:	//	uis.menuBackShader	= trap_R_RegisterShaderNoMip( "menubackRagePro" );
;1705:	//} else {
;1706:	//	uis.menuBackShader	= trap_R_RegisterShaderNoMip( "menuback" );
;1707:	//}
;1708:	uis.menuBackShader = trap_R_RegisterShaderNoMip( "menu/art/logo" );
ADDRGP4 $581
ARGP4
ADDRLP4 32
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uis+11396
ADDRLP4 32
INDIRI4
ASGNI4
line 1709
;1709:	uis.connecting = trap_R_RegisterShaderNoMip( "menu/art/connecting" );
ADDRGP4 $583
ARGP4
ADDRLP4 36
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uis+11424
ADDRLP4 36
INDIRI4
ASGNI4
line 1710
;1710:	uis.menuBackNoLogoShader = trap_R_RegisterShaderNoMip( "menubacknologo" );
ADDRGP4 $585
ARGP4
ADDRLP4 40
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uis+11400
ADDRLP4 40
INDIRI4
ASGNI4
line 1712
;1711:
;1712:	menu_in_sound	= trap_S_RegisterSound( "sound/misc/menu1.wav", qfalse );
ADDRGP4 $586
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 44
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 menu_in_sound
ADDRLP4 44
INDIRI4
ASGNI4
line 1713
;1713:	menu_move_sound	= trap_S_RegisterSound( "sound/misc/menu2.wav", qfalse );
ADDRGP4 $587
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 48
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 menu_move_sound
ADDRLP4 48
INDIRI4
ASGNI4
line 1714
;1714:	menu_out_sound	= trap_S_RegisterSound( "sound/misc/menu3.wav", qfalse );
ADDRGP4 $588
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 52
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 menu_out_sound
ADDRLP4 52
INDIRI4
ASGNI4
line 1715
;1715:	menu_buzz_sound	= trap_S_RegisterSound( "sound/misc/menu4.wav", qfalse );
ADDRGP4 $589
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 56
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 menu_buzz_sound
ADDRLP4 56
INDIRI4
ASGNI4
line 1716
;1716:	weaponChangeSound	= trap_S_RegisterSound( "sound/weapons/change.wav", qfalse );
ADDRGP4 $590
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 60
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 weaponChangeSound
ADDRLP4 60
INDIRI4
ASGNI4
line 1719
;1717:
;1718:	// need a nonzero sound, make an empty sound for this
;1719:	menu_null_sound = -1;
ADDRGP4 menu_null_sound
CNSTI4 -1
ASGNI4
line 1721
;1720:
;1721:	sliderBar = trap_R_RegisterShaderNoMip( "menu/art/slider2" );
ADDRGP4 $591
ARGP4
ADDRLP4 64
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 sliderBar
ADDRLP4 64
INDIRI4
ASGNI4
line 1722
;1722:	sliderButton_0 = trap_R_RegisterShaderNoMip( "menu/art/sliderbutt_0" );
ADDRGP4 $592
ARGP4
ADDRLP4 68
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 sliderButton_0
ADDRLP4 68
INDIRI4
ASGNI4
line 1723
;1723:	sliderButton_1 = trap_R_RegisterShaderNoMip( "menu/art/sliderbutt_1" );
ADDRGP4 $593
ARGP4
ADDRLP4 72
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 sliderButton_1
ADDRLP4 72
INDIRI4
ASGNI4
line 1724
;1724:}
LABELV $563
endproc Menu_Cache 76 8
bss
align 4
LABELV sliderButton_1
skip 4
align 4
LABELV sliderButton_0
skip 4
align 4
LABELV sliderBar
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
import UI_RegisterClientModelname
import UI_PlayerInfo_SetInfo
import UI_PlayerInfo_SetModel
import UI_DrawPlayer
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
import list_color
import name_color
import menu_black_color
import menu_red_color
import menu_highlight_color
import menu_dark_color
import menu_grayed_color
export weaponChangeSound
align 4
LABELV weaponChangeSound
skip 4
export menu_null_sound
align 4
LABELV menu_null_sound
skip 4
export menu_buzz_sound
align 4
LABELV menu_buzz_sound
skip 4
export menu_out_sound
align 4
LABELV menu_out_sound
skip 4
export menu_move_sound
align 4
LABELV menu_move_sound
skip 4
export menu_in_sound
align 4
LABELV menu_in_sound
skip 4
import Menu_Focus
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
LABELV $593
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
byte 1 108
byte 1 105
byte 1 100
byte 1 101
byte 1 114
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $592
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
byte 1 108
byte 1 105
byte 1 100
byte 1 101
byte 1 114
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $591
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
byte 1 108
byte 1 105
byte 1 100
byte 1 101
byte 1 114
byte 1 50
byte 1 0
align 1
LABELV $590
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
LABELV $589
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 52
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $588
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $587
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $586
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $585
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 110
byte 1 111
byte 1 108
byte 1 111
byte 1 103
byte 1 111
byte 1 0
align 1
LABELV $583
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $581
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 108
byte 1 111
byte 1 103
byte 1 111
byte 1 0
align 1
LABELV $579
byte 1 119
byte 1 104
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $577
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
byte 1 119
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 95
byte 1 111
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $575
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
byte 1 119
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 95
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $573
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 51
byte 1 95
byte 1 99
byte 1 117
byte 1 114
byte 1 115
byte 1 111
byte 1 114
byte 1 50
byte 1 0
align 1
LABELV $571
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
LABELV $569
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
LABELV $567
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
LABELV $565
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
LABELV $535
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
byte 1 10
byte 1 0
align 1
LABELV $487
byte 1 77
byte 1 101
byte 1 110
byte 1 117
byte 1 95
byte 1 68
byte 1 114
byte 1 97
byte 1 119
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
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 32
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $419
byte 1 77
byte 1 101
byte 1 110
byte 1 117
byte 1 95
byte 1 73
byte 1 110
byte 1 105
byte 1 116
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
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 32
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $403
byte 1 77
byte 1 101
byte 1 110
byte 1 117
byte 1 95
byte 1 65
byte 1 100
byte 1 100
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 58
byte 1 32
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 118
byte 1 101
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $184
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $182
byte 1 111
byte 1 102
byte 1 102
byte 1 0
