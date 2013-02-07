code
proc UI_CreditMenu_Key 0 8
file "../ui_credits.c"
line 27
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:/*
;4:=======================================================================
;5:
;6:CREDITS
;7:
;8:=======================================================================
;9:*/
;10:
;11:
;12:#include "ui_local.h"
;13:
;14:
;15:typedef struct {
;16:	menuframework_s	menu;
;17:} creditsmenu_t;
;18:
;19:static creditsmenu_t	s_credits;
;20:
;21:
;22:/*
;23:=================
;24:UI_CreditMenu_Key
;25:=================
;26:*/
;27:static sfxHandle_t UI_CreditMenu_Key( int key ) {
line 28
;28:	if( key & K_CHAR_FLAG ) {
ADDRFP4 0
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $70
line 29
;29:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $69
JUMPV
LABELV $70
line 32
;30:	}
;31:
;32:	trap_Cmd_ExecuteText( EXEC_APPEND, "quit\n" );
CNSTI4 2
ARGI4
ADDRGP4 $72
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 33
;33:	return 0;
CNSTI4 0
RETI4
LABELV $69
endproc UI_CreditMenu_Key 0 8
proc UI_CreditMenu_Draw 4 24
line 103
;34:}
;35:
;36:
;37:/*
;38:===============
;39:UI_CreditMenu_Draw
;40:===============
;41:*/ /*
;42:static void UI_CreditMenu_Draw( void ) {
;43:	int		y;
;44:
;45:	y = 12;
;46:	UI_DrawProportionalString( 320, y, "id Software is:", UI_CENTER|UI_SMALLFONT, color_white );
;47:
;48:	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
;49:	UI_DrawProportionalString( 320, y, "Programming", UI_CENTER|UI_SMALLFONT, color_white );
;50:	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
;51:	UI_DrawProportionalString( 320, y, "John Carmack, Robert A. Duffy, Jim Dose'", UI_CENTER|UI_EXTRASMALLFONT, color_white );
;52:
;53:	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
;54:	UI_DrawProportionalString( 320, y, "Art", UI_CENTER|UI_SMALLFONT, color_white );
;55:	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
;56:	UI_DrawProportionalString( 320, y, "Adrian Carmack, Kevin Cloud,", UI_CENTER|UI_EXTRASMALLFONT, color_white );
;57:	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
;58:	UI_DrawProportionalString( 320, y, "Kenneth Scott, Seneca Menard, Fred Nilsson", UI_CENTER|UI_EXTRASMALLFONT, color_white );
;59:
;60:	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
;61:	UI_DrawProportionalString( 320, y, "Game Designer", UI_CENTER|UI_SMALLFONT, color_white );
;62:	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
;63:	UI_DrawProportionalString( 320, y, "Graeme Devine", UI_CENTER|UI_EXTRASMALLFONT, color_white );
;64:
;65:	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
;66:	UI_DrawProportionalString( 320, y, "Level Design", UI_CENTER|UI_SMALLFONT, color_white );
;67:	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
;68:	UI_DrawProportionalString( 320, y, "Tim Willits, Christian Antkow, Paul Jaquays", UI_CENTER|UI_EXTRASMALLFONT, color_white );
;69:
;70:	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
;71:	UI_DrawProportionalString( 320, y, "CEO", UI_CENTER|UI_SMALLFONT, color_white );
;72:	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
;73:	UI_DrawProportionalString( 320, y, "Todd Hollenshead", UI_CENTER|UI_EXTRASMALLFONT, color_white );
;74:
;75:	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
;76:	UI_DrawProportionalString( 320, y, "Director of Business Development", UI_CENTER|UI_SMALLFONT, color_white );
;77:	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
;78:	UI_DrawProportionalString( 320, y, "Marty Stratton", UI_CENTER|UI_EXTRASMALLFONT, color_white );
;79:
;80:	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
;81:	UI_DrawProportionalString( 320, y, "Biz Assist and id Mom", UI_CENTER|UI_SMALLFONT, color_white );
;82:	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
;83:	UI_DrawProportionalString( 320, y, "Donna Jackson", UI_CENTER|UI_EXTRASMALLFONT, color_white );
;84:
;85:	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
;86:	UI_DrawProportionalString( 320, y, "Development Assistance", UI_CENTER|UI_SMALLFONT, color_white );
;87:	y += PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
;88:	UI_DrawProportionalString( 320, y, "Eric Webb", UI_CENTER|UI_EXTRASMALLFONT, color_white );
;89:
;90:	y += 1.35 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
;91:	//UI_DrawString( 320, y, "To order: 1-800-idgames     www.quake3arena.com     www.idsoftware.com", UI_CENTER|UI_SMALLFONT, color_red );
;92:	//y += SMALLCHAR_HEIGHT;
;93:	UI_DrawString( 320, y, "Visit www.Quake-Revolution.com - You'll love it.", UI_CENTER|UI_SMALLFONT, color_main );
;94:	y += SMALLCHAR_HEIGHT;
;95:	UI_DrawString( 320, y, "Quake III Arena(c) 1999-2000, Id Software, Inc.  All Rights Reserved", UI_CENTER|UI_SMALLFONT, color_main );
;96:}*/
;97:
;98:/*
;99:===============
;100:UI_CreditMenu_Draw
;101:===============
;102:*/
;103:static void UI_CreditMenu_Draw( void ) {
line 106
;104:	int		y;
;105:
;106:	y = 12;
ADDRLP4 0
CNSTI4 12
ASGNI4
line 108
;107:	//Line 0
;108:	UI_DrawProportionalString( 320, y, "id Software is:", UI_CENTER, 0.75f, g_color_table[60] );
CNSTI4 320
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $74
ARGP4
CNSTI4 1
ARGI4
CNSTF4 1061158912
ARGF4
ADDRGP4 g_color_table+960
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 111
;109:
;110:	//Line 1
;111:	y += 1.42 * PROP_HEIGHT * 0.75;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1105594941
ADDF4
CVFI4 4
ASGNI4
line 112
;112:	UI_DrawProportionalString( 20, y, "Programming", 0, 0.5f, g_color_table[60] );
CNSTI4 20
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $76
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 g_color_table+960
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 113
;113:	UI_DrawProportionalString( 230, y, "Art", 0, 0.5f, g_color_table[60] );
CNSTI4 230
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $78
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 g_color_table+960
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 114
;114:	UI_DrawProportionalString( 440, y, "Level Design", 0, 0.5f, g_color_table[60] );
CNSTI4 440
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $80
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 g_color_table+960
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 117
;115:
;116:	//Line 2
;117:	y += PROP_HEIGHT * 0.5;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1096286208
ADDF4
CVFI4 4
ASGNI4
line 118
;118:	UI_DrawProportionalString( 20, y, "John Carmack", 0, 0.5f, color_white );
CNSTI4 20
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $82
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 119
;119:	UI_DrawProportionalString( 230, y, "Adrian Carmack", 0, 0.5f, color_white );
CNSTI4 230
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $83
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 120
;120:	UI_DrawProportionalString( 440, y, "Tim Willits", 0, 0.5f, color_white );
CNSTI4 440
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $84
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 123
;121:
;122:	//Line 3
;123:	y += PROP_HEIGHT * 0.5;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1096286208
ADDF4
CVFI4 4
ASGNI4
line 124
;124:	UI_DrawProportionalString( 20, y, "Robert A. Duffy", 0, 0.5f, color_white );
CNSTI4 20
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $85
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 125
;125:	UI_DrawProportionalString( 230, y, "Kevin Cloud", 0, 0.5f, color_white );
CNSTI4 230
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $86
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 126
;126:	UI_DrawProportionalString( 440, y, "Christian Antkow", 0, 0.5f, color_white );
CNSTI4 440
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $87
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 129
;127:
;128:	//Line 4
;129:	y += PROP_HEIGHT * 0.5;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1096286208
ADDF4
CVFI4 4
ASGNI4
line 130
;130:	UI_DrawProportionalString( 20, y, "Jim Dose'", 0, 0.5f, color_white );
CNSTI4 20
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $88
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 131
;131:	UI_DrawProportionalString( 230, y, "Kenneth Scott", 0, 0.5f, color_white );
CNSTI4 230
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $89
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 132
;132:	UI_DrawProportionalString( 440, y, "Paul Jaquays", 0, 0.5f, color_white );
CNSTI4 440
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $90
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 135
;133:
;134:	//Line 5
;135:	y += PROP_HEIGHT * 0.5;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1096286208
ADDF4
CVFI4 4
ASGNI4
line 136
;136:	UI_DrawProportionalString( 230, y, "Seneca Menard", 0, 0.5f, color_white );
CNSTI4 230
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $91
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 139
;137:
;138:	//Line 6
;139:	y += PROP_HEIGHT * 0.5;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1096286208
ADDF4
CVFI4 4
ASGNI4
line 140
;140:	UI_DrawProportionalString( 230, y, "Fred Nilsson", 0, 0.5f, color_white );
CNSTI4 230
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $92
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 144
;141:	
;142:
;143:	//Second branch -- Line 7
;144:	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1105594941
ADDF4
CVFI4 4
ASGNI4
line 145
;145:	UI_DrawProportionalString( 20, y, "Game Designer", 0, 0.5f, g_color_table[60] );
CNSTI4 20
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $93
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 g_color_table+960
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 146
;146:	UI_DrawProportionalString( 230, y, "Biz Assist and id Mom", 0, 0.5f, g_color_table[60] );
CNSTI4 230
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $95
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 g_color_table+960
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 148
;147:	
;148:	UI_DrawProportionalString( 440, y, "CEO", 0, 0.5f, g_color_table[60] );
CNSTI4 440
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $97
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 g_color_table+960
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 151
;149:
;150:	//Line 8
;151:	y += PROP_HEIGHT * 0.5;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1096286208
ADDF4
CVFI4 4
ASGNI4
line 152
;152:	UI_DrawProportionalString( 20, y, "Graeme Devine", 0, 0.5f, color_white );
CNSTI4 20
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $99
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 153
;153:	UI_DrawProportionalString( 230, y, "Donna Jackson", 0, 0.5f, color_white );
CNSTI4 230
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $100
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 154
;154:	UI_DrawProportionalString( 440, y, "Todd Hollenshead", 0, 0.5f, color_white );
CNSTI4 440
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $101
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 157
;155:
;156:	//extras
;157:	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1105594941
ADDF4
CVFI4 4
ASGNI4
line 158
;158:	UI_DrawProportionalString( 20, y, "Director of Business Development", 0, 0.5f, g_color_table[60] );
CNSTI4 20
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $102
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 g_color_table+960
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 159
;159:	UI_DrawProportionalString( 420, y, "Development Assistance", 0, 0.5f, g_color_table[60] );
CNSTI4 420
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $104
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 g_color_table+960
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 160
;160:	y += PROP_HEIGHT * 0.5;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1096286208
ADDF4
CVFI4 4
ASGNI4
line 161
;161:	UI_DrawProportionalString( 20, y, "Marty Stratton", 0, 0.5f, color_white );
CNSTI4 20
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $106
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 162
;162:	UI_DrawProportionalString( 440, y, "Eric Webb", 0, 0.5f, color_white );
CNSTI4 440
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $107
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 165
;163:
;164:	//Mod Developers
;165:	y += 1.42 * PROP_HEIGHT * 0.75;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1105594941
ADDF4
CVFI4 4
ASGNI4
line 166
;166:	UI_DrawProportionalString( 20, y, "Mod Developers:", 0, 0.75f, g_color_table[60] );
CNSTI4 20
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $108
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1061158912
ARGF4
ADDRGP4 g_color_table+960
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 167
;167:	UI_DrawProportionalString( 370, y, "Other Contributors:", 0, 0.75f, g_color_table[60] );
CNSTI4 370
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $110
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1061158912
ARGF4
ADDRGP4 g_color_table+960
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 168
;168:	y += 1.42 * PROP_HEIGHT * 0.75;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1105594941
ADDF4
CVFI4 4
ASGNI4
line 169
;169:	UI_DrawProportionalString( 20, y, "Jonathan \"Evolution\" Murphy", 0, 0.5f, color_white );
CNSTI4 20
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $112
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 170
;170:	UI_DrawProportionalString( 370, y, "ProMode Team", 0, 0.5f, color_white );
CNSTI4 370
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $113
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 171
;171:	y += PROP_HEIGHT * 0.5;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1096286208
ADDF4
CVFI4 4
ASGNI4
line 172
;172:	UI_DrawProportionalString( 20, y, "Curtis \"Lucron\"  Click", 0, 0.5f, color_white );
CNSTI4 20
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $114
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 173
;173:	UI_DrawProportionalString( 370, y, "Reactance team", 0, 0.5f, color_white );
CNSTI4 370
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $115
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 174
;174:	y += PROP_HEIGHT * 0.5;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1096286208
ADDF4
CVFI4 4
ASGNI4
line 175
;175:	UI_DrawProportionalString( 20, y, "William \"Spike\" Kimerer", 0, 0.5f, color_white );
CNSTI4 20
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $116
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 176
;176:	UI_DrawProportionalString( 370, y, "C.J. \"methejuggler\" Manca", 0, 0.5f, color_white );
CNSTI4 370
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $117
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 177
;177:	y += PROP_HEIGHT * 0.5;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1096286208
ADDF4
CVFI4 4
ASGNI4
line 178
;178:	UI_DrawProportionalString( 20, y, "John \"M^onk^K\" Minadeo", 0, 0.5f, color_white );
CNSTI4 20
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $118
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 179
;179:	UI_DrawProportionalString( 370, y, "Darrell \"Doolittle\" Bircsak", 0, 0.5f, color_white );
CNSTI4 370
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $119
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 180
;180:	y += PROP_HEIGHT * 0.5;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1096286208
ADDF4
CVFI4 4
ASGNI4
line 182
;181:	//This is fun
;182:	UI_DrawProportionalString( 20, y, "Robin \"Arcaon\" Blomberg", 0, 0.5f, color_white );
CNSTI4 20
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $120
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 183
;183:	UI_DrawProportionalString( 370, y, "Neil \"haste\" Toronto", 0, 0.5f, color_white );
CNSTI4 370
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $121
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 184
;184:	y += PROP_HEIGHT * 0.5;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1096286208
ADDF4
CVFI4 4
ASGNI4
line 185
;185:	UI_DrawProportionalString( 20, y, "John \"Dwel13R\" Rokosky", 0, 0.5f, color_white );
CNSTI4 20
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $122
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 186
;186:	y += 1.42 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1105594941
ADDF4
CVFI4 4
ASGNI4
line 187
;187:	UI_DrawProportionalString( 20, y, "Graphics", 0, 0.5f, g_color_table[60] );
CNSTI4 20
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $123
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 g_color_table+960
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 188
;188:	y += PROP_HEIGHT * 0.5;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1096286208
ADDF4
CVFI4 4
ASGNI4
line 189
;189:	UI_DrawProportionalString( 20, y, "Vesa \"Decky\" Autio", 0, 0.5f, color_white );
CNSTI4 20
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $125
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 190
;190:	y += PROP_HEIGHT * 0.5;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1096286208
ADDF4
CVFI4 4
ASGNI4
line 191
;191:	UI_DrawProportionalString( 20, y, "Max \"Maxeh\" Nystrom", 0, 0.5f, color_white );
CNSTI4 20
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $126
ARGP4
CNSTI4 0
ARGI4
CNSTF4 1056964608
ARGF4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 196
;192:	
;193:	
;194:
;195:	//y += 1.35 * PROP_HEIGHT * PROP_SMALL_SIZE_SCALE;
;196:	y = 480 - 36;
ADDRLP4 0
CNSTI4 444
ASGNI4
line 199
;197:	//UI_DrawString( 320, y, "To order: 1-800-idgames     www.quake3arena.com     www.idsoftware.com", UI_CENTER|UI_SMALLFONT, color_red );
;198:	//y += SMALLCHAR_HEIGHT;
;199:	UI_DrawString( 320, y, "Visit www.Quake-Revolution.net - You'll love it.", UI_CENTER|UI_SMALLFONT, color_main );
CNSTI4 320
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $127
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_main
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 200
;200:	y += SMALLCHAR_HEIGHT;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 201
;201:	UI_DrawString( 320, y, "Quake III Arena(c) 1999-2000, Id Software, Inc.  All Rights Reserved", UI_CENTER|UI_SMALLFONT, color_main );
CNSTI4 320
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $128
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_main
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 202
;202:}
LABELV $73
endproc UI_CreditMenu_Draw 4 24
export UI_CreditMenu
proc UI_CreditMenu 0 12
line 210
;203:
;204:
;205:/*
;206:===============
;207:UI_CreditMenu
;208:===============
;209:*/
;210:void UI_CreditMenu( void ) {
line 211
;211:	memset( &s_credits, 0 ,sizeof(s_credits) );
ADDRGP4 s_credits
ARGP4
CNSTI4 0
ARGI4
CNSTI4 288
ARGI4
ADDRGP4 memset
CALLP4
pop
line 213
;212:
;213:	s_credits.menu.draw = UI_CreditMenu_Draw;
ADDRGP4 s_credits+268
ADDRGP4 UI_CreditMenu_Draw
ASGNP4
line 214
;214:	s_credits.menu.key = UI_CreditMenu_Key;
ADDRGP4 s_credits+272
ADDRGP4 UI_CreditMenu_Key
ASGNP4
line 215
;215:	s_credits.menu.fullscreen = qtrue;
ADDRGP4 s_credits+280
CNSTI4 1
ASGNI4
line 216
;216:	UI_PushMenu ( &s_credits.menu );
ADDRGP4 s_credits
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 217
;217:}
LABELV $129
endproc UI_CreditMenu 0 12
bss
align 4
LABELV s_credits
skip 288
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
LABELV $128
byte 1 81
byte 1 117
byte 1 97
byte 1 107
byte 1 101
byte 1 32
byte 1 73
byte 1 73
byte 1 73
byte 1 32
byte 1 65
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 40
byte 1 99
byte 1 41
byte 1 32
byte 1 49
byte 1 57
byte 1 57
byte 1 57
byte 1 45
byte 1 50
byte 1 48
byte 1 48
byte 1 48
byte 1 44
byte 1 32
byte 1 73
byte 1 100
byte 1 32
byte 1 83
byte 1 111
byte 1 102
byte 1 116
byte 1 119
byte 1 97
byte 1 114
byte 1 101
byte 1 44
byte 1 32
byte 1 73
byte 1 110
byte 1 99
byte 1 46
byte 1 32
byte 1 32
byte 1 65
byte 1 108
byte 1 108
byte 1 32
byte 1 82
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 115
byte 1 32
byte 1 82
byte 1 101
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $127
byte 1 86
byte 1 105
byte 1 115
byte 1 105
byte 1 116
byte 1 32
byte 1 119
byte 1 119
byte 1 119
byte 1 46
byte 1 81
byte 1 117
byte 1 97
byte 1 107
byte 1 101
byte 1 45
byte 1 82
byte 1 101
byte 1 118
byte 1 111
byte 1 108
byte 1 117
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 46
byte 1 110
byte 1 101
byte 1 116
byte 1 32
byte 1 45
byte 1 32
byte 1 89
byte 1 111
byte 1 117
byte 1 39
byte 1 108
byte 1 108
byte 1 32
byte 1 108
byte 1 111
byte 1 118
byte 1 101
byte 1 32
byte 1 105
byte 1 116
byte 1 46
byte 1 0
align 1
LABELV $126
byte 1 77
byte 1 97
byte 1 120
byte 1 32
byte 1 34
byte 1 77
byte 1 97
byte 1 120
byte 1 101
byte 1 104
byte 1 34
byte 1 32
byte 1 78
byte 1 121
byte 1 115
byte 1 116
byte 1 114
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $125
byte 1 86
byte 1 101
byte 1 115
byte 1 97
byte 1 32
byte 1 34
byte 1 68
byte 1 101
byte 1 99
byte 1 107
byte 1 121
byte 1 34
byte 1 32
byte 1 65
byte 1 117
byte 1 116
byte 1 105
byte 1 111
byte 1 0
align 1
LABELV $123
byte 1 71
byte 1 114
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 99
byte 1 115
byte 1 0
align 1
LABELV $122
byte 1 74
byte 1 111
byte 1 104
byte 1 110
byte 1 32
byte 1 34
byte 1 68
byte 1 119
byte 1 101
byte 1 108
byte 1 49
byte 1 51
byte 1 82
byte 1 34
byte 1 32
byte 1 82
byte 1 111
byte 1 107
byte 1 111
byte 1 115
byte 1 107
byte 1 121
byte 1 0
align 1
LABELV $121
byte 1 78
byte 1 101
byte 1 105
byte 1 108
byte 1 32
byte 1 34
byte 1 104
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 34
byte 1 32
byte 1 84
byte 1 111
byte 1 114
byte 1 111
byte 1 110
byte 1 116
byte 1 111
byte 1 0
align 1
LABELV $120
byte 1 82
byte 1 111
byte 1 98
byte 1 105
byte 1 110
byte 1 32
byte 1 34
byte 1 65
byte 1 114
byte 1 99
byte 1 97
byte 1 111
byte 1 110
byte 1 34
byte 1 32
byte 1 66
byte 1 108
byte 1 111
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 103
byte 1 0
align 1
LABELV $119
byte 1 68
byte 1 97
byte 1 114
byte 1 114
byte 1 101
byte 1 108
byte 1 108
byte 1 32
byte 1 34
byte 1 68
byte 1 111
byte 1 111
byte 1 108
byte 1 105
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 34
byte 1 32
byte 1 66
byte 1 105
byte 1 114
byte 1 99
byte 1 115
byte 1 97
byte 1 107
byte 1 0
align 1
LABELV $118
byte 1 74
byte 1 111
byte 1 104
byte 1 110
byte 1 32
byte 1 34
byte 1 77
byte 1 94
byte 1 111
byte 1 110
byte 1 107
byte 1 94
byte 1 75
byte 1 34
byte 1 32
byte 1 77
byte 1 105
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 111
byte 1 0
align 1
LABELV $117
byte 1 67
byte 1 46
byte 1 74
byte 1 46
byte 1 32
byte 1 34
byte 1 109
byte 1 101
byte 1 116
byte 1 104
byte 1 101
byte 1 106
byte 1 117
byte 1 103
byte 1 103
byte 1 108
byte 1 101
byte 1 114
byte 1 34
byte 1 32
byte 1 77
byte 1 97
byte 1 110
byte 1 99
byte 1 97
byte 1 0
align 1
LABELV $116
byte 1 87
byte 1 105
byte 1 108
byte 1 108
byte 1 105
byte 1 97
byte 1 109
byte 1 32
byte 1 34
byte 1 83
byte 1 112
byte 1 105
byte 1 107
byte 1 101
byte 1 34
byte 1 32
byte 1 75
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $115
byte 1 82
byte 1 101
byte 1 97
byte 1 99
byte 1 116
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $114
byte 1 67
byte 1 117
byte 1 114
byte 1 116
byte 1 105
byte 1 115
byte 1 32
byte 1 34
byte 1 76
byte 1 117
byte 1 99
byte 1 114
byte 1 111
byte 1 110
byte 1 34
byte 1 32
byte 1 32
byte 1 67
byte 1 108
byte 1 105
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $113
byte 1 80
byte 1 114
byte 1 111
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $112
byte 1 74
byte 1 111
byte 1 110
byte 1 97
byte 1 116
byte 1 104
byte 1 97
byte 1 110
byte 1 32
byte 1 34
byte 1 69
byte 1 118
byte 1 111
byte 1 108
byte 1 117
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 34
byte 1 32
byte 1 77
byte 1 117
byte 1 114
byte 1 112
byte 1 104
byte 1 121
byte 1 0
align 1
LABELV $110
byte 1 79
byte 1 116
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 67
byte 1 111
byte 1 110
byte 1 116
byte 1 114
byte 1 105
byte 1 98
byte 1 117
byte 1 116
byte 1 111
byte 1 114
byte 1 115
byte 1 58
byte 1 0
align 1
LABELV $108
byte 1 77
byte 1 111
byte 1 100
byte 1 32
byte 1 68
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 111
byte 1 112
byte 1 101
byte 1 114
byte 1 115
byte 1 58
byte 1 0
align 1
LABELV $107
byte 1 69
byte 1 114
byte 1 105
byte 1 99
byte 1 32
byte 1 87
byte 1 101
byte 1 98
byte 1 98
byte 1 0
align 1
LABELV $106
byte 1 77
byte 1 97
byte 1 114
byte 1 116
byte 1 121
byte 1 32
byte 1 83
byte 1 116
byte 1 114
byte 1 97
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $104
byte 1 68
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 111
byte 1 112
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 65
byte 1 115
byte 1 115
byte 1 105
byte 1 115
byte 1 116
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $102
byte 1 68
byte 1 105
byte 1 114
byte 1 101
byte 1 99
byte 1 116
byte 1 111
byte 1 114
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 66
byte 1 117
byte 1 115
byte 1 105
byte 1 110
byte 1 101
byte 1 115
byte 1 115
byte 1 32
byte 1 68
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 111
byte 1 112
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $101
byte 1 84
byte 1 111
byte 1 100
byte 1 100
byte 1 32
byte 1 72
byte 1 111
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 115
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $100
byte 1 68
byte 1 111
byte 1 110
byte 1 110
byte 1 97
byte 1 32
byte 1 74
byte 1 97
byte 1 99
byte 1 107
byte 1 115
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $99
byte 1 71
byte 1 114
byte 1 97
byte 1 101
byte 1 109
byte 1 101
byte 1 32
byte 1 68
byte 1 101
byte 1 118
byte 1 105
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $97
byte 1 67
byte 1 69
byte 1 79
byte 1 0
align 1
LABELV $95
byte 1 66
byte 1 105
byte 1 122
byte 1 32
byte 1 65
byte 1 115
byte 1 115
byte 1 105
byte 1 115
byte 1 116
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 105
byte 1 100
byte 1 32
byte 1 77
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $93
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 68
byte 1 101
byte 1 115
byte 1 105
byte 1 103
byte 1 110
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $92
byte 1 70
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 78
byte 1 105
byte 1 108
byte 1 115
byte 1 115
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $91
byte 1 83
byte 1 101
byte 1 110
byte 1 101
byte 1 99
byte 1 97
byte 1 32
byte 1 77
byte 1 101
byte 1 110
byte 1 97
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $90
byte 1 80
byte 1 97
byte 1 117
byte 1 108
byte 1 32
byte 1 74
byte 1 97
byte 1 113
byte 1 117
byte 1 97
byte 1 121
byte 1 115
byte 1 0
align 1
LABELV $89
byte 1 75
byte 1 101
byte 1 110
byte 1 110
byte 1 101
byte 1 116
byte 1 104
byte 1 32
byte 1 83
byte 1 99
byte 1 111
byte 1 116
byte 1 116
byte 1 0
align 1
LABELV $88
byte 1 74
byte 1 105
byte 1 109
byte 1 32
byte 1 68
byte 1 111
byte 1 115
byte 1 101
byte 1 39
byte 1 0
align 1
LABELV $87
byte 1 67
byte 1 104
byte 1 114
byte 1 105
byte 1 115
byte 1 116
byte 1 105
byte 1 97
byte 1 110
byte 1 32
byte 1 65
byte 1 110
byte 1 116
byte 1 107
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $86
byte 1 75
byte 1 101
byte 1 118
byte 1 105
byte 1 110
byte 1 32
byte 1 67
byte 1 108
byte 1 111
byte 1 117
byte 1 100
byte 1 0
align 1
LABELV $85
byte 1 82
byte 1 111
byte 1 98
byte 1 101
byte 1 114
byte 1 116
byte 1 32
byte 1 65
byte 1 46
byte 1 32
byte 1 68
byte 1 117
byte 1 102
byte 1 102
byte 1 121
byte 1 0
align 1
LABELV $84
byte 1 84
byte 1 105
byte 1 109
byte 1 32
byte 1 87
byte 1 105
byte 1 108
byte 1 108
byte 1 105
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $83
byte 1 65
byte 1 100
byte 1 114
byte 1 105
byte 1 97
byte 1 110
byte 1 32
byte 1 67
byte 1 97
byte 1 114
byte 1 109
byte 1 97
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $82
byte 1 74
byte 1 111
byte 1 104
byte 1 110
byte 1 32
byte 1 67
byte 1 97
byte 1 114
byte 1 109
byte 1 97
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $80
byte 1 76
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 32
byte 1 68
byte 1 101
byte 1 115
byte 1 105
byte 1 103
byte 1 110
byte 1 0
align 1
LABELV $78
byte 1 65
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $76
byte 1 80
byte 1 114
byte 1 111
byte 1 103
byte 1 114
byte 1 97
byte 1 109
byte 1 109
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $74
byte 1 105
byte 1 100
byte 1 32
byte 1 83
byte 1 111
byte 1 102
byte 1 116
byte 1 119
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 105
byte 1 115
byte 1 58
byte 1 0
align 1
LABELV $72
byte 1 113
byte 1 117
byte 1 105
byte 1 116
byte 1 10
byte 1 0
